-- Conteo de animales agrupados por hábitat
SELECT
    h.nombre AS "Hábitat",
    COUNT(a.id) AS "Total Animales"
FROM habitats h
LEFT JOIN animales a ON h.id = a.habitat_id
GROUP BY h.nombre;