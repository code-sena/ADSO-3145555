-- ============================================================
--  estadisticas_zoo.sql
--  Consultas analíticas sobre la operación del zoológico.
-- ============================================================


-- 1. Animales por hábitat (con capacidad y porcentaje de ocupación)
SELECT
    h.nombre                                        AS "Hábitat",
    h.tipo_clima                                    AS "Clima",
    h.capacidad_maxima                              AS "Capacidad",
    COUNT(a.id)                                     AS "Animales Actuales",
    ROUND(COUNT(a.id) * 100.0 / h.capacidad_maxima, 1) AS "% Ocupación"
FROM habitats h
LEFT JOIN animales a ON h.id = a.habitat_id
GROUP BY h.id, h.nombre, h.tipo_clima, h.capacidad_maxima
ORDER BY "% Ocupación" DESC;


-- 2. Distribución de animales por estado de conservación (UICN)
SELECT
    e.estado_conservacion               AS "Estado UICN",
    COUNT(a.id)                         AS "Cantidad Animales",
    STRING_AGG(DISTINCT e.nombre_comun, ', ') AS "Especies"
FROM especies e
JOIN animales a ON e.id = a.especie_id
GROUP BY e.estado_conservacion
ORDER BY
    CASE e.estado_conservacion
        WHEN 'EX' THEN 1 WHEN 'EW' THEN 2 WHEN 'CR' THEN 3
        WHEN 'EN' THEN 4 WHEN 'VU' THEN 5 WHEN 'NT' THEN 6
        WHEN 'LC' THEN 7 END;


-- 3. Carga de trabajo por cuidador (animales asignados + estado de salud)
SELECT
    c.nombre                            AS "Cuidador",
    c.especialidad                      AS "Especialidad",
    COUNT(a.id)                         AS "Total Animales",
    SUM(CASE WHEN a.estado_salud = 'En tratamiento' THEN 1 ELSE 0 END) AS "En Tratamiento",
    SUM(CASE WHEN a.estado_salud = 'Crítico'        THEN 1 ELSE 0 END) AS "Críticos"
FROM cuidadores c
LEFT JOIN animales a ON c.id = a.cuidador_id
WHERE c.activo = TRUE
GROUP BY c.id, c.nombre, c.especialidad
ORDER BY "Total Animales" DESC;


-- 4. Consumo de alimento diario por animal (últimos 7 días)
SELECT
    a.nombre                            AS "Animal",
    e.nombre_comun                      AS "Especie",
    al.fecha_hora::date                 AS "Fecha",
    SUM(al.cantidad_kg)                 AS "Kg Consumidos"
FROM alimentacion al
JOIN animales a ON al.animal_id = a.id
JOIN especies e  ON a.especie_id = e.id
WHERE al.fecha_hora >= NOW() - INTERVAL '7 days'
GROUP BY a.nombre, e.nombre_comun, al.fecha_hora::date
ORDER BY al.fecha_hora::date DESC, "Kg Consumidos" DESC;


-- 5. Animales con revisión médica vencida (proxima_revision < hoy)
SELECT
    a.nombre                            AS "Animal",
    e.nombre_comun                      AS "Especie",
    hm.proxima_revision                 AS "Revisión Programada",
    CURRENT_DATE - hm.proxima_revision  AS "Días Vencida",
    c.nombre                            AS "Cuidador Responsable"
FROM historial_medico hm
JOIN animales  a ON hm.animal_id  = a.id
JOIN especies  e ON a.especie_id  = e.id
JOIN cuidadores c ON a.cuidador_id = c.id
WHERE hm.proxima_revision < CURRENT_DATE
  AND hm.id = (
      SELECT MAX(id) FROM historial_medico WHERE animal_id = hm.animal_id
  )
ORDER BY "Días Vencida" DESC;
