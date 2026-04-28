-- ============================================================
-- ejercicio_07_demo.sql
-- Ejercicio 07 - Script de demostración y validación
-- ============================================================

-- REQUERIMIENTO 1: Consulta INNER JOIN mínimo 5 tablas
-- Flujo: ticket > ticket_segment > flight_segment > flight >
--        seat_assignment > aircraft_seat > aircraft_cabin > cabin_class > baggage

SELECT
    t.ticket_number                         AS numero_tiquete,
    ts.segment_sequence_no                  AS secuencia_segmento,
    f.flight_number                         AS numero_vuelo,
    cc.class_name                           AS cabina,
    aseat.seat_row_number                   AS fila_asiento,
    aseat.seat_column_code                  AS columna_asiento,
    b.baggage_tag                           AS etiqueta_equipaje,
    b.baggage_type                          AS tipo_equipaje,
    b.baggage_status                        AS estado_equipaje,
    b.weight_kg                             AS peso_kg
FROM ticket t
    INNER JOIN ticket_segment ts        ON ts.ticket_id             = t.ticket_id
    INNER JOIN flight_segment fsg       ON fsg.flight_segment_id    = ts.flight_segment_id
    INNER JOIN flight f                 ON f.flight_id              = fsg.flight_id
    INNER JOIN seat_assignment sa       ON sa.ticket_segment_id     = ts.ticket_segment_id
                                       AND sa.flight_segment_id     = ts.flight_segment_id
    INNER JOIN aircraft_seat aseat      ON aseat.aircraft_seat_id   = sa.aircraft_seat_id
    INNER JOIN aircraft_cabin ac        ON ac.aircraft_cabin_id     = aseat.aircraft_cabin_id
    INNER JOIN cabin_class cc           ON cc.cabin_class_id        = ac.cabin_class_id
    INNER JOIN baggage b                ON b.ticket_segment_id      = ts.ticket_segment_id
ORDER BY t.ticket_number, ts.segment_sequence_no;


-- DEMOSTRACIÓN DEL TRIGGER Y PROCEDIMIENTO

-- Paso 1: Ver ticket_segments disponibles
SELECT
    ts.ticket_segment_id,
    t.ticket_number,
    f.flight_number,
    fsg.segment_number
FROM ticket_segment ts
    INNER JOIN ticket t         ON t.ticket_id          = ts.ticket_id
    INNER JOIN flight_segment fsg ON fsg.flight_segment_id = ts.flight_segment_id
    INNER JOIN flight f         ON f.flight_id           = fsg.flight_id
LIMIT 5;

-- Paso 2: Invocar el procedimiento
-- (Reemplaza el UUID con el ticket_segment_id real del Paso 1)
CALL sp_registrar_equipaje(
    '00000000-0000-0000-0000-000000000001',  -- reemplazar: ticket_segment_id real
    'BAG-2026-00123',
    'CHECKED',
    'CHECKED_IN',
    23.50
);

-- Paso 3: Validar que el equipaje quedó registrado y el trigger se ejecutó
SELECT
    b.baggage_tag,
    b.baggage_type,
    b.baggage_status,
    b.weight_kg,
    t.ticket_number,
    f.flight_number,
    b.created_at
FROM baggage b
    INNER JOIN ticket_segment ts    ON ts.ticket_segment_id = b.ticket_segment_id
    INNER JOIN ticket t             ON t.ticket_id          = ts.ticket_id
    INNER JOIN flight_segment fsg   ON fsg.flight_segment_id = ts.flight_segment_id
    INNER JOIN flight f             ON f.flight_id           = fsg.flight_id
ORDER BY b.created_at DESC
LIMIT 10;
