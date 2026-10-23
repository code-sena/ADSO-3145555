-- =====================================================
-- EJERCICIO 06 - SETUP
-- Retrasos operativos y análisis de impacto por segmento de vuelo
-- =====================================================

DROP TRIGGER IF EXISTS trg_ai_flight_delay_update_flight_status ON flight_delay;
DROP FUNCTION IF EXISTS fn_ai_flight_delay_update_flight_status();
DROP PROCEDURE IF EXISTS sp_register_flight_delay(uuid, uuid, timestamptz, integer, text);

CREATE OR REPLACE FUNCTION fn_ai_flight_delay_update_flight_status()
RETURNS trigger
LANGUAGE plpgsql
AS $$
DECLARE
    v_flight_id uuid;
    v_delayed_status_id uuid;
BEGIN
    SELECT flight_id INTO v_flight_id FROM flight_segment WHERE flight_segment_id = NEW.flight_segment_id;
    SELECT flight_status_id INTO v_delayed_status_id FROM flight_status WHERE status_code = 'DELAYED';
    
    UPDATE flight SET flight_status_id = v_delayed_status_id, updated_at = NOW()
    WHERE flight_id = v_flight_id AND flight_status_id != v_delayed_status_id;
    
    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_ai_flight_delay_update_flight_status
AFTER INSERT ON flight_delay
FOR EACH ROW
EXECUTE FUNCTION fn_ai_flight_delay_update_flight_status();

CREATE OR REPLACE PROCEDURE sp_register_flight_delay(
    p_flight_segment_id uuid,
    p_delay_reason_type_id uuid,
    p_reported_at timestamptz,
    p_delay_minutes integer,
    p_notes text DEFAULT NULL
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM flight_segment WHERE flight_segment_id = p_flight_segment_id) THEN
        RAISE EXCEPTION 'Segmento de vuelo no existe';
    END IF;
    
    IF p_delay_minutes <= 0 THEN
        RAISE EXCEPTION 'Minutos de demora deben ser > 0';
    END IF;
    
    INSERT INTO flight_delay (flight_segment_id, delay_reason_type_id, reported_at, delay_minutes, notes)
    VALUES (p_flight_segment_id, p_delay_reason_type_id, p_reported_at, p_delay_minutes, p_notes);
END;
$$;

-- CONSULTA INNER JOIN
SELECT f.flight_number, fs.segment_number, fd.delay_minutes, drt.reason_name
FROM flight f
INNER JOIN flight_segment fs ON fs.flight_id = f.flight_id
INNER JOIN flight_delay fd ON fd.flight_segment_id = fs.flight_segment_id
INNER JOIN delay_reason_type drt ON drt.delay_reason_type_id = fd.delay_reason_type_id;