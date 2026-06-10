-- =====================================================
-- EJERCICIO 05 - SETUP
-- Mantenimiento de aeronaves y habilitación operativa
-- =====================================================

DROP TRIGGER IF EXISTS trg_au_maintenance_event_update_aircraft_status ON maintenance_event;
DROP FUNCTION IF EXISTS fn_au_maintenance_event_update_aircraft_status();
DROP PROCEDURE IF EXISTS sp_register_maintenance_event(uuid, uuid, uuid, varchar, timestamptz, text);

CREATE OR REPLACE FUNCTION fn_au_maintenance_event_update_aircraft_status()
RETURNS trigger
LANGUAGE plpgsql
AS $$
BEGIN
    IF NEW.status_code = 'COMPLETED' AND OLD.status_code != 'COMPLETED' THEN
        IF NOT EXISTS (
            SELECT 1 FROM maintenance_event
            WHERE aircraft_id = NEW.aircraft_id AND status_code IN ('PLANNED', 'IN_PROGRESS')
            AND maintenance_event_id != NEW.maintenance_event_id
        ) THEN
            UPDATE aircraft SET updated_at = NOW() WHERE aircraft_id = NEW.aircraft_id;
        END IF;
    END IF;
    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_au_maintenance_event_update_aircraft_status
AFTER UPDATE ON maintenance_event
FOR EACH ROW
EXECUTE FUNCTION fn_au_maintenance_event_update_aircraft_status();

CREATE OR REPLACE PROCEDURE sp_register_maintenance_event(
    p_aircraft_id uuid,
    p_maintenance_type_id uuid,
    p_maintenance_provider_id uuid,
    p_status_code varchar,
    p_started_at timestamptz,
    p_notes text DEFAULT NULL
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM aircraft WHERE aircraft_id = p_aircraft_id) THEN
        RAISE EXCEPTION 'Aeronave no existe';
    END IF;
    
    IF p_status_code NOT IN ('PLANNED', 'IN_PROGRESS', 'COMPLETED', 'CANCELLED') THEN
        RAISE EXCEPTION 'Estado inválido';
    END IF;
    
    INSERT INTO maintenance_event (aircraft_id, maintenance_type_id, maintenance_provider_id, status_code, started_at, notes)
    VALUES (p_aircraft_id, p_maintenance_type_id, p_maintenance_provider_id, p_status_code, p_started_at, p_notes);
END;
$$;

-- CONSULTA INNER JOIN
SELECT a.registration_number, mt.type_name, me.status_code, me.started_at
FROM aircraft a
INNER JOIN maintenance_event me ON me.aircraft_id = a.aircraft_id
INNER JOIN maintenance_type mt ON mt.maintenance_type_id = me.maintenance_type_id;