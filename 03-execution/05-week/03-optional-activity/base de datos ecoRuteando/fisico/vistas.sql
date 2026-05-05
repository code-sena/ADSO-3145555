CREATE OR REPLACE VIEW vista_rutas_populares AS
SELECT r.nombre, COUNT(u.id) AS veces_usada
FROM rutas r
JOIN uso_rutas u ON r.id_ruta = u.id_ruta
GROUP BY r.nombre;

CREATE OR REPLACE VIEW vista_usuarios_activos AS
SELECT id_usuario, nombre, correo
FROM usuarios
WHERE estado = 'ACTIVO';
