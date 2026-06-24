-- ============================================================
-- ejercicio_05_setup.sql
-- Ejercicio 05 - Mantenimiento de aeronaves y habilitación operativa
-- Dominios: AIRCRAFT, AIRLINE, GEOGRAPHY
-- ============================================================

-- REQUERIMIENTO 2: Función y Trigger AFTER INSERT sobre maintenance_event
-- Al insertar un evento de mantenimiento, registra un RAISE NOTICE con
-- el conteo total de eventos activos para esa aeronave (efecto verificable)

CREATE OR REPLACE FUNCTION fn_log_mantenimiento_aeronave()
RETURNS TRIGGER AS $$
DECLARE
    v_total_activos integer;
    v_registro_aeronave varchar(20);
BEGIN
    SELECT registration_number INTO v_registro_aeronave
    FROM aircraft WHERE aircraft_id = NEW.aircraft_id;

    SELECT count(*) INTO v_total_activos
    FROM maintenance_event
    WHERE aircraft_id = NEW.aircraft_id
      AND status_code NOT IN ('COMPLETED', 'CANCELLED');

    RAISE NOTICE 'Aeronave [%] — nuevo evento de mantenimiento registrado. Eventos activos: %',
        v_registro_aeronave, v_total_activos;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_after_maintenance_event_log ON maintenance_event;
CREATE TRIGGER trg_after_maintenance_event_log
    AFTER INSERT ON maintenance_event
    FOR EACH ROW
    EXECUTE FUNCTION fn_log_mantenimiento_aeronave();


-- REQUERIMIENTO 3: Procedimiento almacenado para registrar evento de mantenimiento

CREATE OR REPLACE PROCEDURE sp_registrar_mantenimiento(
    p_aircraft_id               uuid,
    p_maintenance_type_id       uuid,
    p_maintenance_provider_id   uuid,
    p_status_code               varchar(20),
    p_started_at                timestamptz,
    p_notes                     text
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM aircraft WHERE aircraft_id = p_aircraft_id) THEN
        RAISE EXCEPTION 'Aeronave no encontrada: %', p_aircraft_id;
    END IF;

    IF NOT EXISTS (SELECT 1 FROM maintenance_type WHERE maintenance_type_id = p_maintenance_type_id) THEN
        RAISE EXCEPTION 'Tipo de mantenimiento no encontrado: %', p_maintenance_type_id;
    END IF;

    INSERT INTO maintenance_event (
        maintenance_event_id,
        aircraft_id,
        maintenance_type_id,
        maintenance_provider_id,
        status_code,
        started_at,
        completed_at,
        notes,
        created_at,
        updated_at
    ) VALUES (
        gen_random_uuid(),
        p_aircraft_id,
        p_maintenance_type_id,
        p_maintenance_provider_id,
        p_status_code,
        p_started_at,
        NULL,
        p_notes,
        now(), now()
    );

    RAISE NOTICE 'Evento de mantenimiento registrado para aeronave %', p_aircraft_id;
END;
$$;
