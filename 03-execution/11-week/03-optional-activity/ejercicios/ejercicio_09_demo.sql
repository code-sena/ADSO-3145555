-- ============================================================
-- ejercicio_09_demo.sql
-- Ejercicio 09 - Script de demostración y validación
-- ============================================================

-- REQUERIMIENTO 1: Consulta INNER JOIN mínimo 5 tablas
-- Flujo: airline > fare > fare_class > airport(orig) > airport(dest) >
--        currency > ticket > sale > reservation

SELECT
    al.airline_name                         AS aerolinea,
    f.fare_code                             AS codigo_tarifa,
    fc.fare_class_name                      AS clase_tarifaria,
    ap_orig.airport_name                    AS aeropuerto_origen,
    ap_dest.airport_name                    AS aeropuerto_destino,
    c.iso_currency_code                     AS moneda,
    r.reservation_code                      AS reserva,
    s.sale_code                             AS venta,
    t.ticket_number                         AS tiquete
FROM airline al
    INNER JOIN fare f               ON f.airline_id             = al.airline_id
    INNER JOIN fare_class fc        ON fc.fare_class_id         = f.fare_class_id
    INNER JOIN airport ap_orig      ON ap_orig.airport_id       = f.origin_airport_id
    INNER JOIN airport ap_dest      ON ap_dest.airport_id       = f.destination_airport_id
    INNER JOIN currency c           ON c.currency_id            = f.currency_id
    INNER JOIN ticket t             ON t.fare_id                = f.fare_id
    INNER JOIN sale s               ON s.sale_id                = t.sale_id
    INNER JOIN reservation r        ON r.reservation_id         = s.reservation_id
ORDER BY al.airline_name, f.fare_code;


-- DEMOSTRACIÓN DEL TRIGGER Y PROCEDIMIENTO

-- Paso 1: Ver aerolíneas, aeropuertos, clases tarifarias y monedas disponibles
SELECT airline_id, airline_code, airline_name FROM airline LIMIT 3;
SELECT airport_id, iata_code, airport_name FROM airport LIMIT 5;
SELECT fare_class_id, fare_class_code, fare_class_name FROM fare_class LIMIT 3;
SELECT currency_id, iso_currency_code FROM currency LIMIT 3;

-- Paso 2: Invocar el procedimiento
-- (Reemplaza los UUIDs con los valores reales obtenidos arriba)
CALL sp_publicar_tarifa(
    '00000000-0000-0000-0000-000000000001',  -- reemplazar: airline_id real
    '00000000-0000-0000-0000-000000000002',  -- reemplazar: origin_airport_id real
    '00000000-0000-0000-0000-000000000003',  -- reemplazar: destination_airport_id real
    '00000000-0000-0000-0000-000000000004',  -- reemplazar: fare_class_id real
    '00000000-0000-0000-0000-000000000005',  -- reemplazar: currency_id real
    'ECO-BOG-MED-2026',
    350000.00,
    '2026-04-25',
    '2026-12-31',
    1
);

-- Paso 3: Validar que la tarifa quedó registrada y el trigger se ejecutó
SELECT
    f.fare_code,
    fc.fare_class_name,
    ap_orig.airport_name AS origen,
    ap_dest.airport_name AS destino,
    f.base_amount,
    c.iso_currency_code,
    f.valid_from,
    f.valid_to
FROM fare f
    INNER JOIN fare_class fc    ON fc.fare_class_id = f.fare_class_id
    INNER JOIN airport ap_orig  ON ap_orig.airport_id = f.origin_airport_id
    INNER JOIN airport ap_dest  ON ap_dest.airport_id = f.destination_airport_id
    INNER JOIN currency c       ON c.currency_id = f.currency_id
ORDER BY f.created_at DESC
LIMIT 10;
