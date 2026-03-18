-- ============================================================
--  reporte_maestro.sql
--  Ficha técnica completa de cada animal en el zoológico.
--  Incluye especie, hábitat, cuidador, última revisión médica
--  y último registro de alimentación.
-- ============================================================

SELECT
    -- Identificación
    a.id                                    AS "ID",
    a.nombre                                AS "Animal",
    a.sexo                                  AS "Sexo",
    EXTRACT(YEAR FROM AGE(a.fecha_nacimiento))
                                            AS "Edad (años)",
    a.peso_kg                               AS "Peso (kg)",

    -- Especie
    e.nombre_comun                          AS "Especie",
    e.nombre_cientifico                     AS "Nombre Científico",
    e.estado_conservacion                   AS "Estado UICN",
    e.dieta                                 AS "Tipo Dieta",

    -- Hábitat
    h.nombre                                AS "Hábitat",
    h.tipo_clima                            AS "Clima",

    -- Cuidador
    c.nombre                                AS "Cuidador",
    c.especialidad                          AS "Especialidad Cuidador",

    -- Estado actual
    a.estado_salud                          AS "Estado Salud",
    CASE a.en_exhibicion
        WHEN TRUE  THEN 'Sí'
        WHEN FALSE THEN 'No'
    END                                     AS "En Exhibición",

    -- Última revisión médica
    hm.fecha_revision                       AS "Última Revisión",
    hm.tipo_revision                        AS "Tipo Revisión",
    hm.diagnostico                          AS "Último Diagnóstico",
    hm.proxima_revision                     AS "Próxima Revisión",

    -- Última alimentación
    ul.fecha_hora                           AS "Última Alimentación",
    ul.tipo_alimento                        AS "Alimento Suministrado",
    ul.cantidad_kg                          AS "Cantidad (kg)"

FROM animales a
JOIN especies   e  ON a.especie_id  = e.id
JOIN habitats   h  ON a.habitat_id  = h.id
JOIN cuidadores c  ON a.cuidador_id = c.id

-- Última revisión médica (subquery correlacionado)
LEFT JOIN historial_medico hm ON hm.id = (
    SELECT id FROM historial_medico
    WHERE animal_id = a.id
    ORDER BY fecha_revision DESC
    LIMIT 1
)

-- Última alimentación (subquery correlacionado)
LEFT JOIN alimentacion ul ON ul.id = (
    SELECT id FROM alimentacion
    WHERE animal_id = a.id
    ORDER BY fecha_hora DESC
    LIMIT 1
)

ORDER BY a.id ASC;
