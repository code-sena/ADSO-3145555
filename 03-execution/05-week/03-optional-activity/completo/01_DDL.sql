-- ============================================================
-- 01_DDL.sql | Estructura de la base de datos
-- Proyecto Final - Base de Datos
-- ============================================================

CREATE DATABASE IF NOT EXISTS proyecto_db;
USE proyecto_db;

-- Eliminar tablas si existen (orden por FK)
DROP TABLE IF EXISTS usuario;
DROP TABLE IF EXISTS persona;

-- -------------------------
-- Tabla: persona
-- -------------------------
CREATE TABLE persona (
    id       INT          AUTO_INCREMENT PRIMARY KEY,
    nombre   VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    edad     INT          CHECK (edad >= 0),
    correo   VARCHAR(150) UNIQUE
);

-- -------------------------
-- Tabla: usuario
-- -------------------------
CREATE TABLE usuario (
    id         INT         AUTO_INCREMENT PRIMARY KEY,
    username   VARCHAR(50) NOT NULL UNIQUE,
    password   VARCHAR(100) NOT NULL,
    id_persona INT         NOT NULL,
    CONSTRAINT fk_usuario_persona
        FOREIGN KEY (id_persona) REFERENCES persona(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
