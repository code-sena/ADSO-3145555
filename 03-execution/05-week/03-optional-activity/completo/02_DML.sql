-- ============================================================
-- 02_DML.sql | Inserción de datos
-- Proyecto Final - Base de Datos
-- ============================================================

USE proyecto_db;

-- -------------------------
-- Datos: persona
-- -------------------------
INSERT INTO persona (nombre, apellido, edad, correo) VALUES
('Juan',   'Perez',   20, 'juan@gmail.com'),
('Maria',  'Lopez',   22, 'maria@gmail.com'),
('Carlos', 'Ramirez', 25, 'carlos@gmail.com');

-- -------------------------
-- Datos: usuario
-- -------------------------
INSERT INTO usuario (username, password, id_persona) VALUES
('juan123',  '12345',   1),
('maria22',  'abc123',  2),
('carlos25', 'pass789', 3);

-- -------------------------
-- Verificación rápida
-- -------------------------
SELECT p.id, p.nombre, p.apellido, p.edad, p.correo,
       u.username
FROM persona p
JOIN usuario u ON u.id_persona = p.id;
