DROP TRIGGER IF EXISTS trg_ai_maintenance_event_update_aircraft_status ON maintenance_event;
DROP FUNCTION IF EXISTS fn_ai_maintenance_event_update_aircraft_status();
DROP PROCEDURE IF EXISTS sp_register_maintenance_event(uuid, uuid, uuid, varchar, timestamptz, varchar);

CREATE OR REPLACE FUNCTION fn_ai_maintenance_event_update_aircraft_status()
RETURNS trigger
LANGUAGE plpgsql
AS $$
BEGIN
    -- Cuando se registra un evento de mantenimiento, marcar la aeronave como no disponible operativamente
    IF lower(NEW.event_status) IN ('in_progress', 'scheduled', 'open') THEN
        UPDATE aircraft
        SET is_active = false
        WHERE aircraft_id = NEW.aircraft_id;
    END IF;

    -- Cuando el mantenimiento se completa, reactivar la aeronave
    IF lower(NEW.event_status) IN ('completed', 'closed', 'released') THEN
        UPDATE aircraft
        SET is_active = true
        WHERE aircraft_id = NEW.aircraft_id;
    END IF;

    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_ai_maintenance_event_update_aircraft_status
AFTER INSERT ON maintenance_event
FOR EACH ROW
EXECUTE FUNCTION fn_ai_maintenance_event_update_aircraft_status();

CREATE OR REPLACE PROCEDURE sp_register_maintenance_event(
    p_aircraft_id              uuid,
    p_maintenance_type_id      uuid,
    p_maintenance_provider_id  uuid,
    p_event_status             varchar,
    p_start_date               timestamptz,
    p_notes                    varchar
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM aircraft a
        WHERE a.aircraft_id = p_aircraft_id
    ) THEN
        RAISE EXCEPTION 'No existe una aeronave con aircraft_id %', p_aircraft_id;
    END IF;

    IF NOT EXISTS (
        SELECT 1
        FROM maintenance_type mt
        WHERE mt.maintenance_type_id = p_maintenance_type_id
    ) THEN
        RAISE EXCEPTION 'No existe un tipo de mantenimiento con maintenance_type_id %', p_maintenance_type_id;
    END IF;

    IF NOT EXISTS (
        SELECT 1
        FROM maintenance_provider mp
        WHERE mp.maintenance_provider_id = p_maintenance_provider_id
    ) THEN
        RAISE EXCEPTION 'No existe un proveedor de mantenimiento con maintenance_provider_id %', p_maintenance_provider_id;
    END IF;

    INSERT INTO maintenance_event (
        aircraft_id,
        maintenance_type_id,
        maintenance_provider_id,
        event_status,
        start_date,
        notes
    )
    VALUES (
        p_aircraft_id,
        p_maintenance_type_id,
        p_maintenance_provider_id,
        p_event_status,
        p_start_date,
        p_notes
    );
END;
$$;

-- Consulta resuelta: trazabilidad técnica aeronave-aerolínea-modelo-fabricante-mantenimiento-proveedor
SELECT
    a.registration_code        AS matricula,
    al.airline_name            AS aerolinea,
    am.model_name              AS modelo,
    amf.manufacturer_name      AS fabricante,
    mt.type_name               AS tipo_mantenimiento,
    mp.provider_name           AS proveedor,
    me.event_status            AS estado_evento,
    me.start_date              AS fecha_inicio,
    me.end_date                AS fecha_finalizacion
FROM aircraft a
INNER JOIN airline al
    ON al.airline_id = a.airline_id
INNER JOIN aircraft_model am
    ON am.aircraft_model_id = a.aircraft_model_id
INNER JOIN aircraft_manufacturer amf
    ON amf.aircraft_manufacturer_id = am.aircraft_manufacturer_id
INNER JOIN maintenance_event me
    ON me.aircraft_id = a.aircraft_id
INNER JOIN maintenance_type mt
    ON mt.maintenance_type_id = me.maintenance_type_id
INNER JOIN maintenance_provider mp
    ON mp.maintenance_provider_id = me.maintenance_provider_id
ORDER BY me.start_date DESC, a.registration_code;