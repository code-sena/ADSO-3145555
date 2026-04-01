/*
    base de datos EcoRuteando
    ultima actualización: 16/12/2025

*/
CREATE DATABASE ecoRuteando;


CREATE TYPE estado_usuario AS ENUM ('ACTIVO','INACTIVO','BLOQUEADO');
CREATE TYPE nivel_error AS ENUM ('INFO','WARNING','ERROR','CRITICO');
CREATE TYPE estado_reporte AS ENUM ('pendiente','validado','rechazado');


CREATE TABLE usuarios (
    id_usuario SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(150) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    telefono VARCHAR(30),
    acepto_terminos BOOLEAN NOT NULL DEFAULT FALSE,
    correo_verificado BOOLEAN NOT NULL DEFAULT FALSE,
    estado estado_usuario DEFAULT 'ACTIVO',
    rol_principal VARCHAR(50) DEFAULT 'USUARIO',
    es_invitado BOOLEAN DEFAULT FALSE,
    creado_en TIMESTAMP WITH TIME ZONE DEFAULT now()
);

CREATE INDEX idx_usuario_correo ON usuarios(correo);


CREATE TABLE seg_roles (
    id_rol SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE,
    descripcion VARCHAR(255)
);

CREATE TABLE seg_permisos (
    id_permiso SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE,
    descripcion VARCHAR(255)
);

CREATE TABLE seg_usuario_rol (
    id_usuario INT NOT NULL,
    id_rol INT NOT NULL,
    PRIMARY KEY (id_usuario, id_rol),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_rol) REFERENCES seg_roles(id_rol) ON DELETE CASCADE
);

CREATE TABLE seg_rol_permiso (
    id_rol INT NOT NULL,
    id_permiso INT NOT NULL,
    PRIMARY KEY (id_rol, id_permiso),
    FOREIGN KEY (id_rol) REFERENCES seg_roles(id_rol) ON DELETE CASCADE,
    FOREIGN KEY (id_permiso) REFERENCES seg_permisos(id_permiso) ON DELETE CASCADE
);


CREATE TABLE seg_auditoria (
    id_auditoria SERIAL PRIMARY KEY,
    id_usuario INT,
    accion VARCHAR(500) NOT NULL,
    fecha TIMESTAMP WITH TIME ZONE DEFAULT now(),
    ip_origen VARCHAR(45),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE SET NULL
);

CREATE TABLE seg_politicas (
    id_politica SERIAL PRIMARY KEY,
    longitud_min_contrasena INT DEFAULT 8,
    requiere_mayusculas BOOLEAN DEFAULT TRUE,
    requiere_numeros BOOLEAN DEFAULT TRUE,
    requiere_caracter_especial BOOLEAN DEFAULT TRUE,
    dias_expiracion INT DEFAULT 90,
    intentos_max_fallidos INT DEFAULT 5
);

CREATE TABLE seg_sesiones (
    id_sesion SERIAL PRIMARY KEY,
    id_usuario INT,
    token VARCHAR(255) UNIQUE NOT NULL,
    ip VARCHAR(45),
    inicio TIMESTAMP WITH TIME ZONE DEFAULT now(),
    fin TIMESTAMP WITH TIME ZONE,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE
);

CREATE TABLE seg_log_errores (
    id_error SERIAL PRIMARY KEY,
    id_usuario INT,
    mensaje TEXT NOT NULL,
    nivel nivel_error DEFAULT 'ERROR',
    fecha TIMESTAMP WITH TIME ZONE DEFAULT now(),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE SET NULL
);

CREATE TABLE seg_recuperacion (
    id_recuperacion SERIAL PRIMARY KEY,
    id_usuario INT NOT NULL,
    token VARCHAR(255) UNIQUE NOT NULL,
    fecha_expiracion TIMESTAMP WITH TIME ZONE NOT NULL,
    usado BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE
);

CREATE TABLE seg_verificacion_correo (
    id_verificacion SERIAL PRIMARY KEY,
    id_usuario INT NOT NULL,
    token VARCHAR(255) UNIQUE NOT NULL,
    fecha_expiracion TIMESTAMP WITH TIME ZONE NOT NULL,
    verificado BOOLEAN DEFAULT FALSE,
    fecha_verificacion TIMESTAMP WITH TIME ZONE,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE
);


CREATE TABLE rutas (
    id_ruta SERIAL PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    descripcion TEXT,
    punto_inicio VARCHAR(150) NOT NULL,
    punto_destino VARCHAR(150) NOT NULL,
    lat_inicio DOUBLE PRECISION,
    lon_inicio DOUBLE PRECISION,
    lat_fin DOUBLE PRECISION,
    lon_fin DOUBLE PRECISION,
    co2_ahorrado NUMERIC(10,2),
    tiempo_estimado_min INT,
    distancia_km NUMERIC(10,2),
    url_foto VARCHAR(255),
    fecha DATE NOT NULL,
    creado_por INT,
    FOREIGN KEY (creado_por) REFERENCES usuarios(id_usuario) ON DELETE SET NULL
);

CREATE INDEX idx_rutas_fecha ON rutas(fecha);
CREATE INDEX idx_rutas_distancia ON rutas(distancia_km);

CREATE TABLE uso_rutas (
    id SERIAL PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_ruta INT NOT NULL,
    fecha_inicio TIMESTAMP WITH TIME ZONE DEFAULT now(),
    fecha_fin TIMESTAMP WITH TIME ZONE,
    finalizada BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_ruta) REFERENCES rutas(id_ruta) ON DELETE CASCADE
);

CREATE INDEX idx_uso_rutas_fecha ON uso_rutas(fecha_inicio);

CREATE TABLE rutas_favoritas (
    id SERIAL PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_ruta INT NOT NULL,
    fecha_agregado TIMESTAMP WITH TIME ZONE DEFAULT now(),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_ruta) REFERENCES rutas(id_ruta) ON DELETE CASCADE,
    UNIQUE (id_usuario, id_ruta)
);

CREATE TABLE calificacion (
    id_calificacion SERIAL PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_ruta INT NOT NULL,
    fecha TIMESTAMP WITH TIME ZONE DEFAULT now(),
    comentario TEXT,
    calificacion INT NOT NULL CHECK (calificacion BETWEEN 1 AND 5),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_ruta) REFERENCES rutas(id_ruta) ON DELETE CASCADE,
    UNIQUE (id_usuario, id_ruta)
);

CREATE INDEX idx_calificacion_ruta ON calificacion(id_ruta);


CREATE TABLE alertas (
    id_alerta SERIAL PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    mensaje TEXT NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    fecha_inicio TIMESTAMP WITH TIME ZONE NOT NULL,
    fecha_fin TIMESTAMP WITH TIME ZONE,
    creado_por INT,
    FOREIGN KEY (creado_por) REFERENCES usuarios(id_usuario) ON DELETE SET NULL
);

CREATE TABLE ruta_alerta (
    id_alerta INT NOT NULL,
    id_ruta INT NOT NULL,
    PRIMARY KEY (id_alerta, id_ruta),
    FOREIGN KEY (id_alerta) REFERENCES alertas(id_alerta) ON DELETE CASCADE,
    FOREIGN KEY (id_ruta) REFERENCES rutas(id_ruta) ON DELETE CASCADE
);


CREATE TABLE reporte_obstaculos (
    id_reporte SERIAL PRIMARY KEY,
    id_usuario INT NOT NULL,
    tipo VARCHAR(100) NOT NULL,
    descripcion TEXT NOT NULL,
    ubicacion VARCHAR(200) NOT NULL,
    url_foto VARCHAR(255),
    estado estado_reporte DEFAULT 'pendiente',
    id_admin_validador INT,
    fecha TIMESTAMP WITH TIME ZONE DEFAULT now(),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_admin_validador) REFERENCES usuarios(id_usuario) ON DELETE SET NULL
);

CREATE INDEX idx_reporte_fecha ON reporte_obstaculos(fecha);


CREATE TABLE historial_direcciones (
    id_historial SERIAL PRIMARY KEY,
    id_usuario INT NOT NULL,
    direccion VARCHAR(255) NOT NULL,
    fecha TIMESTAMP WITH TIME ZONE DEFAULT now(),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE
);


CREATE TABLE soporte (
    id_soporte SERIAL PRIMARY KEY,
    id_usuario INT,
    id_admin INT,
    asunto VARCHAR(200),
    mensaje TEXT NOT NULL,
    respuesta TEXT,
    estado VARCHAR(50) DEFAULT 'pendiente',
    fecha TIMESTAMP WITH TIME ZONE DEFAULT now(),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE SET NULL,
    FOREIGN KEY (id_admin) REFERENCES usuarios(id_usuario) ON DELETE SET NULL
);


CREATE TABLE exportaciones (
    id_exportacion SERIAL PRIMARY KEY,
    id_usuario INT,
    tipo VARCHAR(50) NOT NULL,
    formato VARCHAR(20) NOT NULL,
    fecha TIMESTAMP WITH TIME ZONE DEFAULT now(),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE SET NULL
);


CREATE TABLE configuracion_sistema (
    id_config SERIAL PRIMARY KEY,
    nombre_admin VARCHAR(100),
    correo_admin VARCHAR(150),
    ultima_actualizacion TIMESTAMP WITH TIME ZONE DEFAULT now()
);


CREATE VIEW vista_estadisticas AS
SELECT
    (SELECT COUNT(*) FROM rutas) AS total_rutas,
    (SELECT COUNT(*) FROM usuarios) AS total_usuarios,
    COALESCE((SELECT SUM(co2_ahorrado) FROM rutas), 0)::NUMERIC(14,2) AS total_co2_ev,
    (SELECT AVG(tiempo_estimado_min) FROM rutas)::NUMERIC(10,2) AS tiempo_promedio_min;
