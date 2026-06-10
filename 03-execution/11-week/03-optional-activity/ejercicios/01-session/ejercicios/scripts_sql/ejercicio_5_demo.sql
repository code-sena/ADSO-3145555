-- =====================================================
-- EJERCICIO 05 - DEMO COMPLETO
-- Demostración del funcionamiento del trigger y procedimiento
-- =====================================================

DO $$
DECLARE
    v_aircraft_id uuid;
    v_maintenance_type_id uuid;
    v_maintenance_provider_id uuid;
    v_maintenance_event_id uuid;
BEGIN
    -- 1. Obtener una aeronave existente
    SELECT aircraft_id INTO v_aircraft_id
    FROM aircraft
    LIMIT 1;
    
    -- 2. Obtener un tipo de mantenimiento
    SELECT maintenance_type_id INTO v_maintenance_type_id
    FROM maintenance_type
    LIMIT 1;
    
    -- 3. Obtener un proveedor de mantenimiento
    SELECT maintenance_provider_id INTO v_maintenance_provider_id
    FROM maintenance_provider
    LIMIT 1;
    
    IF v_aircraft_id IS NULL THEN
        RAISE EXCEPTION 'No existe aeronave disponible para la demostración';
    END IF;
    
    IF v_maintenance_type_id IS NULL THEN
        RAISE EXCEPTION 'No existe tipo de mantenimiento disponible';
    END IF;
    
    RAISE NOTICE 'Aeronave encontrada: %, Tipo mantenimiento: %', v_aircraft_id, v_maintenance_type_id;
    
    -- 4. Registrar evento de mantenimiento planificado
    CALL sp_register_maintenance_event(
        v_aircraft_id,
        v_maintenance_type_id,
        v_maintenance_provider_id,
        'PLANNED',
        NOW(),
        'Mantenimiento preventivo planificado - Revisión de motores'
    );
    
    -- 5. Registrar evento de mantenimiento en progreso
    CALL sp_register_maintenance_event(
        v_aircraft_id,
        v_maintenance_type_id,
        v_maintenance_provider_id,
        'IN_PROGRESS',
        NOW(),
        'Mantenimiento en curso - Inspección de tren de aterrizaje'
    );
    
    RAISE NOTICE 'Demostración completada exitosamente';
END;
$$;

-- VALIDACIÓN 1: Ver eventos de mantenimiento registrados
SELECT 
    me.maintenance_event_id,
    a.registration_number,
    mt.type_name AS tipo_mantenimiento,
    me.status_code,
    me.started_at,
    me.notes
FROM maintenance_event me
INNER JOIN aircraft a ON a.aircraft_id = me.aircraft_id
INNER JOIN maintenance_type mt ON mt.maintenance_type_id = me.maintenance_type_id
ORDER BY me.created_at DESC
LIMIT 10;

-- VALIDACIÓN 2: Script que dispara el trigger directamente (UPDATE de estado)
UPDATE maintenance_event 
SET status_code = 'COMPLETED', 
    completed_at = NOW(),
    notes = COALESCE(notes, '') || ' | Mantenimiento completado - Trigger ejecutado',
    updated_at = NOW()
WHERE maintenance_event_id = (
    SELECT maintenance_event_id FROM maintenance_event 
    ORDER BY created_at DESC LIMIT 1
);

-- VALIDACIÓN 3: Verificar que el trigger se ejecutó (ver mensajes en RAISE NOTICE)
-- También verificar que la aeronave fue actualizada
SELECT 
    a.registration_number,
    a.updated_at,
    COUNT(me.maintenance_event_id) AS total_eventos
FROM aircraft a
LEFT JOIN maintenance_event me ON me.aircraft_id = a.aircraft_id
WHERE a.aircraft_id = (SELECT aircraft_id FROM maintenance_event ORDER BY created_at DESC LIMIT 1)
GROUP BY a.registration_number, a.updated_at;

-- VALIDACIÓN 4: Script que invoca el procedimiento directamente
CALL sp_register_maintenance_event(
    (SELECT aircraft_id FROM aircraft LIMIT 1),
    (SELECT maintenance_type_id FROM maintenance_type LIMIT 1),
    (SELECT maintenance_provider_id FROM maintenance_provider LIMIT 1),
    'PLANNED',
    NOW(),
    'Procedimiento directo - Nuevo evento de mantenimiento'
);

-- VALIDACIÓN 5: Resumen de eventos por aeronave
SELECT 
    a.registration_number,
    COUNT(me.maintenance_event_id) AS total_mantenimientos,
    COUNT(CASE WHEN me.status_code = 'COMPLETED' THEN 1 END) AS completados,
    COUNT(CASE WHEN me.status_code = 'IN_PROGRESS' THEN 1 END) AS en_curso,
    COUNT(CASE WHEN me.status_code = 'PLANNED' THEN 1 END) AS planificados
FROM aircraft a
LEFT JOIN maintenance_event me ON me.aircraft_id = a.aircraft_id
GROUP BY a.registration_number
ORDER BY a.registration_number;