DO $$
DECLARE
    v_aircraft_id              uuid;
    v_maintenance_type_id      uuid;
    v_maintenance_provider_id  uuid;
    v_event_status             varchar := 'in_progress';
    v_start_date               timestamptz := now();
    v_notes                    varchar := 'Mantenimiento programado - inspección de sistemas de navegación';
BEGIN
    -- Buscar una aeronave activa disponible
    SELECT a.aircraft_id
    INTO v_aircraft_id
    FROM aircraft a
    WHERE a.is_active = true
    ORDER BY a.created_at
    LIMIT 1;

    -- Si no hay aeronave activa, tomar cualquier aeronave disponible
    IF v_aircraft_id IS NULL THEN
        SELECT a.aircraft_id
        INTO v_aircraft_id
        FROM aircraft a
        ORDER BY a.created_at
        LIMIT 1;
    END IF;

    -- Obtener el primer tipo de mantenimiento disponible
    SELECT mt.maintenance_type_id
    INTO v_maintenance_type_id
    FROM maintenance_type mt
    ORDER BY mt.created_at
    LIMIT 1;

    -- Obtener el primer proveedor de mantenimiento disponible
    SELECT mp.maintenance_provider_id
    INTO v_maintenance_provider_id
    FROM maintenance_provider mp
    ORDER BY mp.created_at
    LIMIT 1;

    IF v_aircraft_id IS NULL THEN
        RAISE EXCEPTION 'No existe ninguna aeronave disponible en el sistema.';
    END IF;

    IF v_maintenance_type_id IS NULL THEN
        RAISE EXCEPTION 'No existe ningún tipo de mantenimiento disponible en el sistema.';
    END IF;

    IF v_maintenance_provider_id IS NULL THEN
        RAISE EXCEPTION 'No existe ningún proveedor de mantenimiento disponible en el sistema.';
    END IF;

    -- Invocar el procedimiento de registro del evento de mantenimiento
    CALL sp_register_maintenance_event(
        v_aircraft_id,
        v_maintenance_type_id,
        v_maintenance_provider_id,
        v_event_status,
        v_start_date,
        v_notes
    );
END;
$$;

-- Validación: verificar el evento registrado y el estado actualizado de la aeronave por el trigger
SELECT
    a.aircraft_id,
    a.registration_code        AS matricula,
    a.is_active                AS aeronave_activa,
    me.maintenance_event_id,
    me.event_status,
    me.start_date,
    me.notes,
    mt.type_name               AS tipo_mantenimiento,
    mp.provider_name           AS proveedor
FROM aircraft a
INNER JOIN maintenance_event me
    ON me.aircraft_id = a.aircraft_id
INNER JOIN maintenance_type mt
    ON mt.maintenance_type_id = me.maintenance_type_id
INNER JOIN maintenance_provider mp
    ON mp.maintenance_provider_id = me.maintenance_provider_id
ORDER BY me.created_at DESC
LIMIT 5;