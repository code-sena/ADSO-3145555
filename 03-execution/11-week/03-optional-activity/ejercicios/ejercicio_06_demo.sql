-- ============================================================
-- ejercicio_06_demo.sql
-- Ejercicio 06 - Script de demostración y validación
-- ============================================================

-- REQUERIMIENTO 1: Consulta INNER JOIN mínimo 5 tablas
-- Flujo: airline > flight > flight_status > flight_segment >
--        airport (origen) > airport (destino) > flight_delay > delay_reason_type

SELECT
    al.airline_name                         AS aerolinea,
    f.flight_number                         AS numero_vuelo,
    f.service_date                          AS fecha_servicio,
    fs_status.status_name                   AS estado_vuelo,
    fs.segment_number                       AS segmento,
    ap_orig.airport_name                    AS aeropuerto_origen,
    ap_dest.airport_name                    AS aeropuerto_destino,
    fd.delay_minutes                        AS minutos_demora,
    drt.reason_name                         AS motivo_retraso
FROM airline al
    INNER JOIN flight f             ON f.airline_id             = al.airline_id
    INNER JOIN flight_status fs_status ON fs_status.flight_status_id = f.flight_status_id
    INNER JOIN flight_segment fs    ON fs.flight_id             = f.flight_id
    INNER JOIN airport ap_orig      ON ap_orig.airport_id       = fs.origin_airport_id
    INNER JOIN airport ap_dest      ON ap_dest.airport_id       = fs.destination_airport_id
    INNER JOIN flight_delay fd      ON fd.flight_segment_id     = fs.flight_segment_id
    INNER JOIN delay_reason_type drt ON drt.delay_reason_type_id = fd.delay_reason_type_id
ORDER BY f.service_date, f.flight_number, fs.segment_number;


-- DEMOSTRACIÓN DEL TRIGGER Y PROCEDIMIENTO

-- Paso 1: Ver segmentos de vuelo y motivos de retraso disponibles
SELECT fs.flight_segment_id, f.flight_number, f.service_date, fs.segment_number
FROM flight_segment fs
    INNER JOIN flight f ON f.flight_id = fs.flight_id
LIMIT 5;

SELECT delay_reason_type_id, reason_code, reason_name FROM delay_reason_type LIMIT 5;

-- Paso 2: Invocar el procedimiento
-- (Reemplaza los UUIDs con los valores reales obtenidos arriba)
CALL sp_registrar_demora(
    '00000000-0000-0000-0000-000000000001',  -- reemplazar: flight_segment_id real
    '00000000-0000-0000-0000-000000000002',  -- reemplazar: delay_reason_type_id real
    45,
    'Demora por condiciones climáticas en aeropuerto de origen'
);

-- Paso 3: Validar que la demora quedó registrada y el trigger se ejecutó
SELECT
    fd.flight_delay_id,
    f.flight_number,
    fs.segment_number,
    drt.reason_name,
    fd.delay_minutes,
    fd.reported_at,
    fd.notes
FROM flight_delay fd
    INNER JOIN flight_segment fs        ON fs.flight_segment_id     = fd.flight_segment_id
    INNER JOIN flight f                 ON f.flight_id              = fs.flight_id
    INNER JOIN delay_reason_type drt    ON drt.delay_reason_type_id = fd.delay_reason_type_id
ORDER BY fd.created_at DESC
LIMIT 10;
