DO $$
DECLARE
    v_airline_id              uuid;
    v_fare_class_id           uuid;
    v_origin_airport_id       uuid;
    v_destination_airport_id  uuid;
    v_currency_id             uuid;
    v_fare_code               varchar := 'TEST-FARE-' || to_char(now(), 'HH24MISS');
BEGIN
    -- Obtener la primera aerolínea disponible
    SELECT al.airline_id
    INTO v_airline_id
    FROM airline al
    ORDER BY al.created_at
    LIMIT 1;

    -- Obtener la primera clase tarifaria disponible
    SELECT fc.fare_class_id
    INTO v_fare_class_id
    FROM fare_class fc
    ORDER BY fc.created_at
    LIMIT 1;

    -- Obtener aeropuerto de origen
    SELECT airport_id
    INTO v_origin_airport_id
    FROM airport
    ORDER BY created_at
    LIMIT 1;

    -- Obtener aeropuerto de destino distinto al de origen
    SELECT airport_id
    INTO v_destination_airport_id
    FROM airport
    WHERE airport_id <> v_origin_airport_id
    ORDER BY created_at
    LIMIT 1;

    -- Obtener la primera moneda disponible
    SELECT cu.currency_id
    INTO v_currency_id
    FROM currency cu
    ORDER BY cu.created_at
    LIMIT 1;

    -- Validaciones previas
    IF v_airline_id IS NULL THEN
        RAISE EXCEPTION 'No existe aerolínea disponible.';
    END IF;

    IF v_fare_class_id IS NULL THEN
        RAISE EXCEPTION 'No existe clase tarifaria disponible.';
    END IF;

    IF v_origin_airport_id IS NULL OR v_destination_airport_id IS NULL THEN
        RAISE EXCEPTION 'No existen aeropuertos suficientes para definir la ruta.';
    END IF;

    IF v_currency_id IS NULL THEN
        RAISE EXCEPTION 'No existe moneda disponible.';
    END IF;

    -- Invocar el procedimiento de publicación de tarifa
    CALL sp_publish_fare(
        v_airline_id,
        v_fare_class_id,
        v_origin_airport_id,
        v_destination_airport_id,
        v_currency_id,
        v_fare_code,
        350.00,
        current_date,
        current_date + interval '180 days'
    );
END;
$$;

SELECT
    f.fare_id,
    f.fare_code,
    f.base_amount,
    f.valid_from,
    f.valid_to,
    al.trade_name       AS aerolinea,
    fc.fare_class_code  AS clase,
    ap_o.iata_code      AS origen,
    ap_d.iata_code      AS destino,
    cu.currency_code    AS moneda
FROM fare f
INNER JOIN airline al     ON al.airline_id = f.airline_id
INNER JOIN fare_class fc  ON fc.fare_class_id = f.fare_class_id
INNER JOIN airport ap_o   ON ap_o.airport_id = f.origin_airport_id
INNER JOIN airport ap_d   ON ap_d.airport_id = f.destination_airport_id
INNER JOIN currency cu    ON cu.currency_id = f.currency_id
ORDER BY f.created_at DESC
LIMIT 5;

SELECT
    mt.miles_transaction_id,
    mt.transaction_type,
    mt.miles_amount,
    mt.description,
    mt.transaction_date
FROM miles_transaction mt
WHERE mt.transaction_type = 'FARE_PUBLISHED'
ORDER BY mt.transaction_date DESC
LIMIT 5;