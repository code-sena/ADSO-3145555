-- ============================================================
-- 02_TRIGGERS.sql | Funciones y Triggers
-- Proyecto: Airline Schema v3
-- Motor: PostgreSQL
-- Incluye: ADR-01 (orden DDL correcto) y ADR-10 (EARN valida ticket_id)
-- ============================================================

-- ============================================================
-- ADR-10 — Trigger: EARN en miles_transaction requiere ticket_id
-- ============================================================
-- Problema resuelto: transacciones de tipo EARN sin ticket_id
-- eran auditoriamente inútiles. Este trigger lo previene.

-- PASO 1: Función PL/pgSQL
CREATE OR REPLACE FUNCTION fn_check_miles_earn_ticket()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
    v_type_code VARCHAR(20);
BEGIN
    -- Obtener el código del tipo de transacción
    SELECT code INTO v_type_code
    FROM miles_transaction_type
    WHERE miles_transaction_type_id = NEW.miles_transaction_type_id;

    -- Validar: si es EARN, ticket_id es obligatorio
    IF v_type_code = 'EARN' AND NEW.ticket_id IS NULL THEN
        RAISE EXCEPTION
            'miles_transaction de tipo EARN requiere ticket_id. '
            'Proporcione el ticket_id asociado al vuelo acumulado.'
            USING ERRCODE = 'check_violation';
    END IF;

    RETURN NEW;
END;
$$;

-- PASO 2: Trigger sobre miles_transaction
-- ADR-01 nota: la tabla miles_transaction YA existe antes de este CREATE TRIGGER
CREATE TRIGGER trg_miles_earn_ticket_check
BEFORE INSERT OR UPDATE ON miles_transaction
FOR EACH ROW
EXECUTE FUNCTION fn_check_miles_earn_ticket();

-- ============================================================
-- ADR-01 — Triggers de validación (creados DESPUÉS de sus tablas)
-- ============================================================
-- Nota: el error original era que estos triggers se definían
-- antes de que existieran seat_assignment y ticket_segment.
-- En v3 el DDL se reordena: tabla → función → trigger.

-- ─── Validación: seat_assignment debe pertenecer al aircraft del vuelo ───

CREATE OR REPLACE FUNCTION fn_check_seat_assignment_aircraft()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
    v_flight_aircraft_id UUID;
    v_seat_aircraft_id   UUID;
BEGIN
    -- Obtener el aircraft del vuelo asociado al segmento
    SELECT sf.aircraft_id
    INTO v_flight_aircraft_id
    FROM ticket_segment ts
    JOIN scheduled_flight sf ON sf.scheduled_flight_id = ts.scheduled_flight_id
    WHERE ts.ticket_segment_id = NEW.ticket_segment_id;

    -- Obtener el aircraft del asiento asignado
    SELECT aircraft_id INTO v_seat_aircraft_id
    FROM seat
    WHERE seat_id = NEW.seat_id;

    IF v_flight_aircraft_id IS DISTINCT FROM v_seat_aircraft_id THEN
        RAISE EXCEPTION
            'El asiento (seat_id=%) no pertenece al aircraft del vuelo (aircraft_id=%).',
            NEW.seat_id, v_flight_aircraft_id
            USING ERRCODE = 'foreign_key_violation';
    END IF;

    RETURN NEW;
END;
$$;

-- Trigger se crea DESPUÉS de seat_assignment (ADR-01 corregido)
CREATE TRIGGER trg_seat_assignment_aircraft_check
BEFORE INSERT OR UPDATE ON seat_assignment
FOR EACH ROW
EXECUTE FUNCTION fn_check_seat_assignment_aircraft();

-- ─── Validación: ticket_segment debe pertenecer a la reserva del ticket ──

CREATE OR REPLACE FUNCTION fn_check_ticket_segment_reservation()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
    v_ticket_reservation_id UUID;
BEGIN
    SELECT reservation_id INTO v_ticket_reservation_id
    FROM ticket
    WHERE ticket_id = NEW.ticket_id;

    -- Verificar que el vuelo programado existe y es válido
    IF NOT EXISTS (
        SELECT 1 FROM scheduled_flight
        WHERE scheduled_flight_id = NEW.scheduled_flight_id
    ) THEN
        RAISE EXCEPTION
            'El scheduled_flight_id=% no existe.',
            NEW.scheduled_flight_id
            USING ERRCODE = 'foreign_key_violation';
    END IF;

    RETURN NEW;
END;
$$;

-- Trigger se crea DESPUÉS de ticket_segment (ADR-01 corregido)
CREATE TRIGGER trg_ticket_segment_reservation_check
BEFORE INSERT OR UPDATE ON ticket_segment
FOR EACH ROW
EXECUTE FUNCTION fn_check_ticket_segment_reservation();

-- ============================================================
-- Función utilitaria: registrar cambio de estado en historial
-- Usada por la capa de aplicación (ADR-12)
-- ============================================================

CREATE OR REPLACE FUNCTION fn_registrar_cambio_estado_reserva(
    p_reservation_id  UUID,
    p_from_status_id  UUID,    -- NULL si es creación inicial
    p_to_status_id    UUID,
    p_changed_by      UUID
)
RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO reservation_status_history
        (reservation_id, from_status_id, to_status_id, changed_by)
    VALUES
        (p_reservation_id, p_from_status_id, p_to_status_id, p_changed_by);
END;
$$;

CREATE OR REPLACE FUNCTION fn_registrar_cambio_estado_ticket(
    p_ticket_id      UUID,
    p_from_status_id UUID,
    p_to_status_id   UUID,
    p_changed_by     UUID
)
RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO ticket_status_history
        (ticket_id, from_status_id, to_status_id, changed_by)
    VALUES
        (p_ticket_id, p_from_status_id, p_to_status_id, p_changed_by);
END;
$$;

CREATE OR REPLACE FUNCTION fn_registrar_cambio_estado_pago(
    p_payment_id     UUID,
    p_from_status_id UUID,
    p_to_status_id   UUID,
    p_changed_by     UUID
)
RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO payment_status_history
        (payment_id, from_status_id, to_status_id, changed_by)
    VALUES
        (p_payment_id, p_from_status_id, p_to_status_id, p_changed_by);
END;
$$;
