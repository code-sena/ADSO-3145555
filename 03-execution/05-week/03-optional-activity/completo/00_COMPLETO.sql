-- ============================================================
-- 00_COMPLETO.sql | Script completo ejecutable
-- Proyecto Final - Base de Datos
-- Ejecutar este archivo para levantar toda la BD desde cero
-- ============================================================

-- ============================================================
-- PASO 1: BASE DE DATOS
-- ============================================================
CREATE DATABASE IF NOT EXISTS proyecto_db;
USE proyecto_db;

-- ============================================================
-- PASO 2: ELIMINAR TABLAS (orden correcto por FK)
-- ============================================================
DROP TABLE IF EXISTS usuario;
DROP TABLE IF EXISTS persona;

-- ============================================================
-- PASO 3: CREAR TABLAS
-- ============================================================

CREATE TABLE persona (
    id       INT          AUTO_INCREMENT PRIMARY KEY,
    nombre   VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    edad     INT          CHECK (edad >= 0),
    correo   VARCHAR(150) UNIQUE
);

CREATE TABLE usuario (
    id         INT          AUTO_INCREMENT PRIMARY KEY,
    username   VARCHAR(50)  NOT NULL UNIQUE,
    password   VARCHAR(100) NOT NULL,
    id_persona INT          NOT NULL,
    CONSTRAINT fk_usuario_persona
        FOREIGN KEY (id_persona) REFERENCES persona(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- ============================================================
-- PASO 4: INSERTAR DATOS
-- ============================================================

INSERT INTO persona (nombre, apellido, edad, correo) VALUES
('Juan',   'Perez',   20, 'juan@gmail.com'),
('Maria',  'Lopez',   22, 'maria@gmail.com'),
('Carlos', 'Ramirez', 25, 'carlos@gmail.com');

INSERT INTO usuario (username, password, id_persona) VALUES
('juan123',  '12345',   1),
('maria22',  'abc123',  2),
('carlos25', 'pass789', 3);

-- ============================================================
-- PASO 5: FUNCIONES
-- ============================================================

DROP FUNCTION IF EXISTS obtener_nombre;
DELIMITER $$
CREATE FUNCTION obtener_nombre(p_id INT)
RETURNS VARCHAR(100)
DETERMINISTIC READS SQL DATA
BEGIN
    DECLARE v_nombre VARCHAR(100) DEFAULT NULL;
    SELECT nombre INTO v_nombre FROM persona WHERE id = p_id LIMIT 1;
    RETURN v_nombre;
END $$
DELIMITER ;

DROP FUNCTION IF EXISTS obtener_edad;
DELIMITER $$
CREATE FUNCTION obtener_edad(p_id INT)
RETURNS INT
DETERMINISTIC READS SQL DATA
BEGIN
    DECLARE v_edad INT DEFAULT NULL;
    SELECT edad INTO v_edad FROM persona WHERE id = p_id LIMIT 1;
    RETURN v_edad;
END $$
DELIMITER ;

DROP FUNCTION IF EXISTS obtener_nombre_completo;
DELIMITER $$
CREATE FUNCTION obtener_nombre_completo(p_id INT)
RETURNS VARCHAR(201)
DETERMINISTIC READS SQL DATA
BEGIN
    DECLARE v_completo VARCHAR(201) DEFAULT NULL;
    SELECT CONCAT(nombre, ' ', apellido) INTO v_completo
    FROM persona WHERE id = p_id LIMIT 1;
    RETURN v_completo;
END $$
DELIMITER ;

DROP FUNCTION IF EXISTS obtener_username;
DELIMITER $$
CREATE FUNCTION obtener_username(p_id_persona INT)
RETURNS VARCHAR(50)
DETERMINISTIC READS SQL DATA
BEGIN
    DECLARE v_username VARCHAR(50) DEFAULT NULL;
    SELECT username INTO v_username FROM usuario
    WHERE id_persona = p_id_persona LIMIT 1;
    RETURN v_username;
END $$
DELIMITER ;

-- ============================================================
-- PASO 6: VERIFICACIÓN FINAL
-- ============================================================
SELECT 'TABLAS CREADAS CORRECTAMENTE' AS estado;

SELECT p.id, p.nombre, p.apellido, p.edad, p.correo, u.username
FROM persona p
JOIN usuario u ON u.id_persona = p.id;

SELECT obtener_nombre_completo(1) AS prueba_funcion;
