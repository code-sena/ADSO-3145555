-- =====================================================
-- EJERCICIO 07 - SETUP
-- Asignación de asientos y registro de equipaje por segmento ticketed
-- =====================================================

DROP TRIGGER IF EXISTS trg_ai_baggage_update_check_in_status ON baggage;
DROP FUNCTION IF EXISTS fn_ai_baggage_update_check_in_status();
DROP PROCEDURE IF EXISTS sp_register_baggage(uuid, varchar, varchar, numeric, timestamptz);
DROP PROCEDURE IF EXISTS sp_assign_seat(uuid, uuid, timestamptz, varchar);

CREATE OR REPLACE FUNCTION fn_ai_baggage_update_check_in_status()
RETURNS trigger
LANGUAGE plpgsql
AS $$
DECLARE
    v_check_in_id uuid;
    v_confirmed_status_id uuid;
BEGIN
    SELECT check_in_id INTO v_check_in_id FROM check_in WHERE ticket_segment_id = NEW.ticket_segment_id;
    
    IF v_check_in_id IS NOT NULL THEN
        SELECT check_in_status_id INTO v_confirmed_status_id FROM check_in_status WHERE status_code = 'CONFIRMED';
        
        UPDATE check_in SET check_in_status_id = v_confirmed_status_id, updated_at = NOW()
        WHERE check_in_id = v_check_in_id;
    END IF;
    
    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_ai_baggage_update_check_in_status
AFTER INSERT ON baggage
FOR EACH ROW
EXECUTE FUNCTION fn_ai_baggage_update_check_in_status();

CREATE OR REPLACE PROCEDURE sp_register_baggage(
    p_ticket_segment_id uuid,
    p_baggage_type varchar,
    p_baggage_status varchar,
    p_weight_kg numeric,
    p_checked_at timestamptz
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_baggage_tag varchar(30);
BEGIN
    IF p_baggage_type NOT IN ('CHECKED', 'CARRY_ON', 'SPECIAL') THEN
        RAISE EXCEPTION 'Tipo de equipaje inválido';
    END IF;
    
    v_baggage_tag := 'BG-' || replace(gen_random_uuid()::text, '-', '');
    v_baggage_tag := left(v_baggage_tag, 30);
    
    INSERT INTO baggage (ticket_segment_id, baggage_tag, baggage_type, baggage_status, weight_kg, checked_at)
    VALUES (p_ticket_segment_id, v_baggage_tag, p_baggage_type, p_baggage_status, p_weight_kg, p_checked_at);
END;
$$;

CREATE OR REPLACE PROCEDURE sp_assign_seat(
    p_ticket_segment_id uuid,
    p_aircraft_seat_id uuid,
    p_assigned_at timestamptz,
    p_assignment_source varchar
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_flight_segment_id uuid;
BEGIN
    SELECT flight_segment_id INTO v_flight_segment_id FROM ticket_segment WHERE ticket_segment_id = p_ticket_segment_id;
    
    IF p_assignment_source NOT IN ('AUTO', 'MANUAL', 'CUSTOMER') THEN
        RAISE EXCEPTION 'Fuente de asignación inválida';
    END IF;
    
    INSERT INTO seat_assignment (ticket_segment_id, flight_segment_id, aircraft_seat_id, assigned_at, assignment_source)
    VALUES (p_ticket_segment_id, v_flight_segment_id, p_aircraft_seat_id, p_assigned_at, p_assignment_source)
    ON CONFLICT (ticket_segment_id) DO UPDATE SET
        aircraft_seat_id = EXCLUDED.aircraft_seat_id,
        assigned_at = EXCLUDED.assigned_at,
        assignment_source = EXCLUDED.assignment_source;
END;
$$;

-- CONSULTA INNER JOIN
SELECT t.ticket_number, sa.seat_row_number, sa.seat_column_code, b.baggage_type, b.weight_kg
FROM ticket t
INNER JOIN ticket_segment ts ON ts.ticket_id = t.ticket_id
LEFT JOIN seat_assignment sa ON sa.ticket_segment_id = ts.ticket_segment_id
LEFT JOIN baggage b ON b.ticket_segment_id = ts.ticket_segment_id;