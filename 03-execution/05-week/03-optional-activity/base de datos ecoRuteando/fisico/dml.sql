INSERT INTO usuarios(nombre, correo, password_hash, acepto_terminos, correo_verificado, rol_principal)
VALUES
('Admin', 'admin@eco.com', 'hash123', TRUE, TRUE, 'ADMIN'),
('Juan', 'juan@eco.com', 'hash456', TRUE, TRUE, 'USUARIO'),
('Ana', 'ana@eco.com', 'hash789', TRUE, TRUE, 'USUARIO');

INSERT INTO seg_roles(nombre, descripcion) VALUES
('ADMIN','Administrador del sistema'),
('USUARIO','Usuario normal');

INSERT INTO seg_permisos(nombre, descripcion) VALUES
('GESTION_USUARIOS','Administrar usuarios'),
('VER_ESTADISTICAS','Acceder a métricas');

INSERT INTO seg_usuario_rol VALUES (1,1),(2,2),(3,2);
INSERT INTO seg_rol_permiso VALUES (1,1),(1,2),(2,2);

INSERT INTO rutas(nombre, punto_inicio, punto_destino, fecha, co2_ahorrado, tiempo_estimado_min, distancia_km)
VALUES
('Ruta verde centro','Centro','Universidad','2026-01-10',1.5,20,4.2),
('Ruta río','Parque','Malecón','2026-01-11',2.1,30,6.0);
