-- ============================================================
-- 03_FUNCIONES.sql | Funciones almacenadas
-- Proyecto Final - Base de Datos
-- ============================================================

USE proyecto_db;

-- ============================================================
-- FUNCIÓN 1: obtener_nombre
-- Retorna el nombre de una persona por su ID
-- ============================================================
DROP FUNCTION IF EXISTS obtener_nombre;

DELIMITER $$

CREATE FUNCTION obtener_nombre(p_id INT)
RETURNS VARCHAR(100)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_nombre VARCHAR(100) DEFAULT NULL;

    SELECT nombre INTO v_nombre
    FROM persona
    WHERE id = p_id
    LIMIT 1;

    -- Retorna NULL si no existe el ID
    RETURN v_nombre;
END $$

DELIMITER ;

-- ============================================================
-- FUNCIÓN 2: obtener_edad
-- Retorna la edad de una persona por su ID
-- ============================================================
DROP FUNCTION IF EXISTS obtener_edad;

DELIMITER $$

CREATE FUNCTION obtener_edad(p_id INT)
RETURNS INT
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_edad INT DEFAULT NULL;

    SELECT edad INTO v_edad
    FROM persona
    WHERE id = p_id
    LIMIT 1;

    RETURN v_edad;
END $$

DELIMITER ;

-- ============================================================
-- FUNCIÓN 3: obtener_nombre_completo  ✅ NUEVA
-- Retorna nombre + apellido concatenados
-- ============================================================
DROP FUNCTION IF EXISTS obtener_nombre_completo;

DELIMITER $$

CREATE FUNCTION obtener_nombre_completo(p_id INT)
RETURNS VARCHAR(201)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_completo VARCHAR(201) DEFAULT NULL;

    SELECT CONCAT(nombre, ' ', apellido) INTO v_completo
    FROM persona
    WHERE id = p_id
    LIMIT 1;

    RETURN v_completo;
END $$

DELIMITER ;

-- ============================================================
-- FUNCIÓN 4: obtener_username  ✅ NUEVA
-- Retorna el username de un usuario por id_persona
-- ============================================================
DROP FUNCTION IF EXISTS obtener_username;

DELIMITER $$

CREATE FUNCTION obtener_username(p_id_persona INT)
RETURNS VARCHAR(50)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_username VARCHAR(50) DEFAULT NULL;

    SELECT username INTO v_username
    FROM usuario
    WHERE id_persona = p_id_persona
    LIMIT 1;

    RETURN v_username;
END $$

DELIMITER ;

-- ============================================================
-- Pruebas de las funciones
-- ============================================================
SELECT obtener_nombre(1)           AS nombre;
SELECT obtener_edad(1)             AS edad;
SELECT obtener_nombre_completo(2)  AS nombre_completo;
SELECT obtener_username(3)         AS username;
