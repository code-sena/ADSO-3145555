-- ============================================================
-- ejercicio_09_setup.sql
-- Ejercicio 09 - Publicación de tarifas y análisis de reservas
-- Dominios: SALES/TICKETING, AIRPORT, AIRLINE, GEOGRAPHY
-- ============================================================

-- REQUERIMIENTO 2: Función y Trigger AFTER INSERT sobre fare
-- Al publicar una nueva tarifa, emite RAISE NOTICE con el total
-- de tarifas activas para esa ruta origen-destino

CREATE OR REPLACE FUNCTION fn_log_nueva_tarifa()
RETURNS TRIGGER AS $$
DECLARE
    v_origen    varchar(150);
    v_destino   varchar(150);
    v_total     integer;
BEGIN
    SELECT airport_name INTO v_origen
    FROM airport WHERE airport_id = NEW.origin_airport_id;

    SELECT airport_name INTO v_destino
    FROM airport WHERE airport_id = NEW.destination_airport_id;

    SELECT count(*) INTO v_total
    FROM fare
    WHERE origin_airport_id      = NEW.origin_airport_id
      AND destination_airport_id = NEW.destination_airport_id
      AND (valid_to IS NULL OR valid_to >= now()::date);

    RAISE NOTICE 'Nueva tarifa publicada [%] — Ruta: % → %. Tarifas activas en esa ruta: %',
        NEW.fare_code, v_origen, v_destino, v_total;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_after_fare_insert_log ON fare;
CREATE TRIGGER trg_after_fare_insert_log
    AFTER INSERT ON fare
    FOR EACH ROW
    EXECUTE FUNCTION fn_log_nueva_tarifa();


-- REQUERIMIENTO 3: Procedimiento almacenado para registrar/publicar tarifa

CREATE OR REPLACE PROCEDURE sp_publicar_tarifa(
    p_airline_id            uuid,
    p_origin_airport_id     uuid,
    p_destination_airport_id uuid,
    p_fare_class_id         uuid,
    p_currency_id           uuid,
    p_fare_code             varchar(30),
    p_base_amount           numeric(12,2),
    p_valid_from            date,
    p_valid_to              date,
    p_baggage_allowance_qty integer
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM airline WHERE airline_id = p_airline_id) THEN
        RAISE EXCEPTION 'Aerolínea no encontrada: %', p_airline_id;
    END IF;

    INSERT INTO fare (
        fare_id,
        airline_id,
        origin_airport_id,
        destination_airport_id,
        fare_class_id,
        currency_id,
        fare_code,
        base_amount,
        valid_from,
        valid_to,
        baggage_allowance_qty,
        created_at,
        updated_at
    ) VALUES (
        gen_random_uuid(),
        p_airline_id,
        p_origin_airport_id,
        p_destination_airport_id,
        p_fare_class_id,
        p_currency_id,
        p_fare_code,
        p_base_amount,
        p_valid_from,
        p_valid_to,
        p_baggage_allowance_qty,
        now(), now()
    );

    RAISE NOTICE 'Tarifa [%] publicada correctamente', p_fare_code;
END;
$$;
