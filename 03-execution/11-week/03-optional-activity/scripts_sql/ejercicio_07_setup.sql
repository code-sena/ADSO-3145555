DROP TRIGGER IF EXISTS trg_ai_baggage_update_seat_assignment_status ON baggage;
DROP FUNCTION IF EXISTS fn_ai_baggage_update_seat_assignment_status();
DROP PROCEDURE IF EXISTS sp_register_baggage(uuid, varchar, varchar, varchar, timestamptz);

CREATE OR REPLACE FUNCTION fn_ai_baggage_update_seat_assignment_status()
RETURNS trigger
LANGUAGE plpgsql
AS $$
BEGIN
    -- Cuando se registra un equipaje, marcar la asignación de asiento del mismo
    -- ticket_segment como confirmada operativamente
    IF EXISTS (
        SELECT 1
        FROM seat_assignment sa
        WHERE sa.ticket_segment_id = NEW.ticket_segment_id
    ) THEN
        UPDATE seat_assignment
        SET is_confirmed = true
        WHERE ticket_segment_id = NEW.ticket_segment_id;
    END IF;

    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_ai_baggage_update_seat_assignment_status
AFTER INSERT ON baggage
FOR EACH ROW
EXECUTE FUNCTION fn_ai_baggage_update_seat_assignment_status();

CREATE OR REPLACE PROCEDURE sp_register_baggage(
    p_ticket_segment_id   uuid,
    p_baggage_tag         varchar,
    p_baggage_type        varchar,
    p_baggage_status      varchar,
    p_registered_at       timestamptz
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM ticket_segment ts
        WHERE ts.ticket_segment_id = p_ticket_segment_id
    ) THEN
        RAISE EXCEPTION 'No existe un ticket_segment con ticket_segment_id %', p_ticket_segment_id;
    END IF;

    IF EXISTS (
        SELECT 1
        FROM baggage b
        WHERE b.baggage_tag = p_baggage_tag
    ) THEN
        RAISE EXCEPTION 'Ya existe un equipaje registrado con la etiqueta %', p_baggage_tag;
    END IF;

    INSERT INTO baggage (
        ticket_segment_id,
        baggage_tag,
        baggage_type,
        baggage_status,
        registered_at
    )
    VALUES (
        p_ticket_segment_id,
        p_baggage_tag,
        p_baggage_type,
        p_baggage_status,
        p_registered_at
    );
END;
$$;

-- Consulta resuelta: trazabilidad aeroportuaria tiquete-segmento-vuelo-asiento-cabina-equipaje
SELECT
    t.ticket_number,
    ts.sequence_number            AS secuencia_segmento,
    f.flight_number,
    cc.class_name                 AS cabina,
    ase.row_number                AS fila_asiento,
    ase.column_letter             AS columna_asiento,
    b.baggage_tag                 AS etiqueta_equipaje,
    b.baggage_type                AS tipo_equipaje,
    b.baggage_status              AS estado_equipaje
FROM ticket t
INNER JOIN ticket_segment ts
    ON ts.ticket_id = t.ticket_id
INNER JOIN flight_segment fs
    ON fs.flight_segment_id = ts.flight_segment_id
INNER JOIN flight f
    ON f.flight_id = fs.flight_id
INNER JOIN seat_assignment sa
    ON sa.ticket_segment_id = ts.ticket_segment_id
INNER JOIN aircraft_seat ase
    ON ase.aircraft_seat_id = sa.aircraft_seat_id
INNER JOIN aircraft_cabin ac
    ON ac.aircraft_cabin_id = ase.aircraft_cabin_id
INNER JOIN cabin_class cc
    ON cc.cabin_class_id = ac.cabin_class_id
INNER JOIN baggage b
    ON b.ticket_segment_id = ts.ticket_segment_id
ORDER BY t.ticket_number, ts.sequence_number;