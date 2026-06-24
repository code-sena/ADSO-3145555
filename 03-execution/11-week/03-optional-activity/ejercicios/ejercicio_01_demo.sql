-- ============================================================
-- ejercicio_01_demo.sql
-- Ejercicio 01 - Script de demostración y validación
-- ============================================================

-- ============================================================
-- REQUERIMIENTO 1: Consulta INNER JOIN mínimo 5 tablas
-- Trazabilidad de pasajeros por vuelo:
-- reservation > reservation_passenger > person > ticket >
-- ticket_segment > flight_segment > flight
-- ============================================================

SELECT
    r.reservation_code                          AS codigo_reserva,
    f.flight_number                             AS numero_vuelo,
    f.service_date                              AS fecha_servicio,
    t.ticket_number                             AS numero_tiquete,
    rp.passenger_sequence_no                    AS secuencia_pasajero,
    p.first_name || ' ' || p.last_name         AS nombre_pasajero,
    fs.segment_number                           AS segmento_vuelo,
    fs.scheduled_departure_at                   AS hora_salida_programada
FROM reservation r
    INNER JOIN reservation_passenger rp  ON rp.reservation_id       = r.reservation_id
    INNER JOIN person p                  ON p.person_id              = rp.person_id
    INNER JOIN ticket t                  ON t.reservation_passenger_id = rp.reservation_passenger_id
    INNER JOIN ticket_segment ts         ON ts.ticket_id             = t.ticket_id
    INNER JOIN flight_segment fs         ON fs.flight_segment_id     = ts.flight_segment_id
    INNER JOIN flight f                  ON f.flight_id              = fs.flight_id
ORDER BY f.service_date, f.flight_number, rp.passenger_sequence_no;


-- ============================================================
-- DEMOSTRACIÓN DEL TRIGGER Y EL PROCEDIMIENTO
-- Paso 1: Preparar datos de catálogos mínimos necesarios
-- ============================================================

-- Estado de check-in
INSERT INTO check_in_status (check_in_status_id, status_code, status_name)
VALUES (gen_random_uuid(), 'CHECKED_IN', 'Check-in completado')
ON CONFLICT DO NOTHING;

-- Grupo de abordaje
INSERT INTO boarding_group (boarding_group_id, group_code, group_name, sequence_no)
VALUES (gen_random_uuid(), 'A', 'Grupo A - Prioritario', 1)
ON CONFLICT DO NOTHING;

-- ============================================================
-- Paso 2: Identificar un ticket_segment y usuario existentes
-- (Ajusta estos UUIDs con los datos reales del seed)
-- ============================================================

-- Ver ticket_segments disponibles
SELECT
    ts.ticket_segment_id,
    t.ticket_number,
    fs.segment_number,
    f.flight_number,
    f.service_date
FROM ticket_segment ts
    INNER JOIN ticket t         ON t.ticket_id         = ts.ticket_id
    INNER JOIN flight_segment fs ON fs.flight_segment_id = ts.flight_segment_id
    INNER JOIN flight f          ON f.flight_id          = fs.flight_id
LIMIT 5;

-- Ver usuarios disponibles
SELECT user_account_id, username FROM user_account LIMIT 5;

-- ============================================================
-- Paso 3: Ejecutar el procedimiento almacenado
-- Reemplaza los UUIDs con los valores obtenidos arriba
-- ============================================================

CALL sp_registrar_check_in(
    '00000000-0000-0000-0000-000000000001',  -- reemplazar: ticket_segment_id real
    'CHECKED_IN',
    'A',
    '00000000-0000-0000-0000-000000000002'   -- reemplazar: user_account_id real
);

-- ============================================================
-- Paso 4: Validar que el trigger generó el boarding_pass
-- ============================================================

SELECT
    ci.check_in_id,
    ci.checked_in_at,
    cis.status_name         AS estado_checkin,
    bg.group_name           AS grupo_abordaje,
    bp.boarding_pass_code,
    bp.barcode_value,
    bp.issued_at            AS pase_emitido_en
FROM check_in ci
    INNER JOIN check_in_status cis ON cis.check_in_status_id = ci.check_in_status_id
    LEFT  JOIN boarding_group  bg  ON bg.boarding_group_id   = ci.boarding_group_id
    INNER JOIN boarding_pass   bp  ON bp.check_in_id         = ci.check_in_id
ORDER BY ci.checked_in_at DESC
LIMIT 10;
