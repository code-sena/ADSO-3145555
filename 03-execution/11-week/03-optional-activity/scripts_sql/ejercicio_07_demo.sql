DO $$
DECLARE
    v_ticket_segment_id   uuid;
    v_baggage_tag         varchar;
    v_baggage_type        varchar := 'checked';
    v_baggage_status      varchar := 'checked_in';
    v_registered_at       timestamptz := now();
BEGIN
    -- Buscar un ticket_segment que tenga seat_assignment pero sin equipaje registrado
    SELECT ts.ticket_segment_id
    INTO v_ticket_segment_id
    FROM ticket_segment ts
    INNER JOIN seat_assignment sa
        ON sa.ticket_segment_id = ts.ticket_segment_id
    LEFT JOIN baggage b
        ON b.ticket_segment_id = ts.ticket_segment_id
    WHERE b.baggage_id IS NULL
    ORDER BY ts.created_at
    LIMIT 1;

    -- Si no hay ninguno con asiento sin equipaje, tomar cualquier ticket_segment disponible
    IF v_ticket_segment_id IS NULL THEN
        SELECT ts.ticket_segment_id
        INTO v_ticket_segment_id
        FROM ticket_segment ts
        ORDER BY ts.created_at
        LIMIT 1;
    END IF;

    IF v_ticket_segment_id IS NULL THEN
        RAISE EXCEPTION 'No existe ningún ticket_segment disponible en el sistema.';
    END IF;

    -- Generar una etiqueta de equipaje única basada en el ticket_segment_id
    v_baggage_tag := 'BAG-' || left(replace(v_ticket_segment_id::text, '-', ''), 16);

    -- Invocar el procedimiento de registro de equipaje
    CALL sp_register_baggage(
        v_ticket_segment_id,
        v_baggage_tag,
        v_baggage_type,
        v_baggage_status,
        v_registered_at
    );
END;
$$;

-- Validación: verificar el equipaje registrado y el estado de confirmación del asiento por el trigger
SELECT
    b.baggage_id,
    b.ticket_segment_id,
    b.baggage_tag,
    b.baggage_type,
    b.baggage_status,
    b.registered_at,
    sa.seat_assignment_id,
    sa.is_confirmed            AS asiento_confirmado,
    ase.row_number             AS fila,
    ase.column_letter          AS columna
FROM baggage b
INNER JOIN seat_assignment sa
    ON sa.ticket_segment_id = b.ticket_segment_id
INNER JOIN aircraft_seat ase
    ON ase.aircraft_seat_id = sa.aircraft_seat_id
ORDER BY b.registered_at DESC
LIMIT 5;