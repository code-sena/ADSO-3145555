-- ============================================================
-- ejercicio_05_demo.sql
-- Ejercicio 05 - Script de demostración y validación
-- ============================================================

-- REQUERIMIENTO 1: Consulta INNER JOIN mínimo 5 tablas
-- Flujo: aircraft > airline > aircraft_model > aircraft_manufacturer >
--        maintenance_event > maintenance_type > maintenance_provider

SELECT
    a.registration_number                   AS matricula_aeronave,
    al.airline_name                         AS aerolinea,
    am.model_name                           AS modelo,
    amf.manufacturer_name                   AS fabricante,
    mt.type_name                            AS tipo_mantenimiento,
    mp.provider_name                        AS proveedor,
    me.status_code                          AS estado_evento,
    me.started_at                           AS fecha_inicio,
    me.completed_at                         AS fecha_finalizacion
FROM aircraft a
    INNER JOIN airline al                   ON al.airline_id                  = a.airline_id
    INNER JOIN aircraft_model am            ON am.aircraft_model_id           = a.aircraft_model_id
    INNER JOIN aircraft_manufacturer amf    ON amf.aircraft_manufacturer_id   = am.aircraft_manufacturer_id
    INNER JOIN maintenance_event me         ON me.aircraft_id                 = a.aircraft_id
    INNER JOIN maintenance_type mt          ON mt.maintenance_type_id         = me.maintenance_type_id
    LEFT  JOIN maintenance_provider mp      ON mp.maintenance_provider_id     = me.maintenance_provider_id
ORDER BY a.registration_number, me.started_at DESC;


-- DEMOSTRACIÓN DEL TRIGGER Y PROCEDIMIENTO

-- Paso 1: Ver aeronaves y tipos de mantenimiento disponibles
SELECT a.aircraft_id, a.registration_number, al.airline_name
FROM aircraft a INNER JOIN airline al ON al.airline_id = a.airline_id LIMIT 5;

SELECT maintenance_type_id, type_code, type_name FROM maintenance_type LIMIT 5;

SELECT maintenance_provider_id, provider_name FROM maintenance_provider LIMIT 5;

-- Paso 2: Invocar el procedimiento
-- (Reemplaza los UUIDs con los valores reales obtenidos arriba)
CALL sp_registrar_mantenimiento(
    '00000000-0000-0000-0000-000000000001',  -- reemplazar: aircraft_id real
    '00000000-0000-0000-0000-000000000002',  -- reemplazar: maintenance_type_id real
    '00000000-0000-0000-0000-000000000003',  -- reemplazar: maintenance_provider_id real (o NULL)
    'IN_PROGRESS',
    now(),
    'Revisión de motores programada - ciclo 500h'
);

-- Paso 3: Validar que el evento quedó registrado y el trigger se ejecutó
SELECT
    me.maintenance_event_id,
    a.registration_number,
    mt.type_name,
    mp.provider_name,
    me.status_code,
    me.started_at,
    me.notes,
    me.created_at
FROM maintenance_event me
    INNER JOIN aircraft a           ON a.aircraft_id            = me.aircraft_id
    INNER JOIN maintenance_type mt  ON mt.maintenance_type_id   = me.maintenance_type_id
    LEFT  JOIN maintenance_provider mp ON mp.maintenance_provider_id = me.maintenance_provider_id
ORDER BY me.created_at DESC
LIMIT 10;
