DROP TRIGGER IF EXISTS trg_ai_fare_audit_miles ON fare;
DROP FUNCTION IF EXISTS fn_ai_fare_audit_miles();
DROP PROCEDURE IF EXISTS sp_publish_fare(uuid, uuid, uuid, uuid, uuid, varchar, numeric, date, date);


CREATE OR REPLACE FUNCTION fn_ai_fare_audit_miles()
RETURNS trigger
LANGUAGE plpgsql
AS $$
DECLARE
    v_loyalty_account_id uuid;
BEGIN
    -- Verificar si ya existe una entrada de auditoría para esta tarifa
    IF EXISTS (
        SELECT 1
        FROM miles_transaction mt
        WHERE mt.description LIKE '%' || NEW.fare_code || '%'
          AND mt.transaction_type = 'FARE_PUBLISHED'
    ) THEN
        RETURN NEW;
    END IF;

    -- Obtener el primer loyalty_account disponible como referencia de auditoría
    SELECT la.loyalty_account_id
    INTO v_loyalty_account_id
    FROM loyalty_account la
    ORDER BY la.created_at
    LIMIT 1;

    IF v_loyalty_account_id IS NULL THEN
        RETURN NEW;
    END IF;

    INSERT INTO miles_transaction (
        loyalty_account_id,
        transaction_type,
        miles_amount,
        description,
        transaction_date
    )
    VALUES (
        v_loyalty_account_id,
        'FARE_PUBLISHED',
        0,
        'Tarifa publicada: ' || NEW.fare_code || ' | monto base: ' || NEW.base_amount::text,
        now()
    );

    RETURN NEW;
END;
$$;


CREATE TRIGGER trg_ai_fare_audit_miles
AFTER INSERT ON fare
FOR EACH ROW
EXECUTE FUNCTION fn_ai_fare_audit_miles();


CREATE OR REPLACE PROCEDURE sp_publish_fare(
    p_airline_id              uuid,
    p_fare_class_id           uuid,
    p_origin_airport_id       uuid,
    p_destination_airport_id  uuid,
    p_currency_id             uuid,
    p_fare_code               varchar,
    p_base_amount             numeric,
    p_valid_from              date,
    p_valid_to                date
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Validar que no exista una tarifa activa con el mismo código para la misma aerolínea
    IF EXISTS (
        SELECT 1
        FROM fare f
        WHERE f.fare_code = p_fare_code
          AND f.airline_id = p_airline_id
    ) THEN
        RAISE EXCEPTION 'Ya existe una tarifa con el código % para esta aerolínea.', p_fare_code;
    END IF;

    INSERT INTO fare (
        airline_id,
        fare_class_id,
        origin_airport_id,
        destination_airport_id,
        currency_id,
        fare_code,
        base_amount,
        valid_from,
        valid_to
    )
    VALUES (
        p_airline_id,
        p_fare_class_id,
        p_origin_airport_id,
        p_destination_airport_id,
        p_currency_id,
        p_fare_code,
        p_base_amount,
        p_valid_from,
        p_valid_to
    );
END;
$$;


SELECT
    al.trade_name                   AS aerolinea,
    f.fare_code                     AS codigo_tarifa,
    fc.fare_class_code              AS clase_tarifaria,
    ap_orig.iata_code               AS origen,
    ap_dest.iata_code               AS destino,
    cu.currency_code                AS moneda,
    f.base_amount                   AS monto_base,
    r.reservation_code              AS reserva,
    s.sale_code                     AS venta,
    t.ticket_number                 AS tiquete
FROM fare f
INNER JOIN airline al
    ON al.airline_id = f.airline_id
INNER JOIN fare_class fc
    ON fc.fare_class_id = f.fare_class_id
INNER JOIN airport ap_orig
    ON ap_orig.airport_id = f.origin_airport_id
INNER JOIN airport ap_dest
    ON ap_dest.airport_id = f.destination_airport_id
INNER JOIN currency cu
    ON cu.currency_id = f.currency_id
INNER JOIN ticket t
    ON t.fare_id = f.fare_id
INNER JOIN sale s
    ON s.sale_id = t.sale_id
INNER JOIN reservation r
    ON r.reservation_id = s.reservation_id
ORDER BY f.fare_code, t.ticket_number;