-- Consulta para ver la ficha técnica completa de los animales
-- Incluye Especie, Hábitat, Cuidador e Historial Médico
SELECT
    a.nombre AS "Animal",
    e.nombre_comun AS "Especie",
    h.nombre AS "Hábitat",
    c.nombre AS "Cuidador",
    hm.fecha_revision AS "Última Cita",
    hm.diagnostico AS "Estado de Salud"
FROM animales a
JOIN especies e ON a.especie_id = e.id
JOIN habitats h ON a.habitat_id = h.id
JOIN cuidadores c ON a.cuidador_id = c.id
LEFT JOIN historial_medico hm ON a.id = hm.animal_id;