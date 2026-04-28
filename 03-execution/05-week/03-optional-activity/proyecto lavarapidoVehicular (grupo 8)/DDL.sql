/* =================================================================
   PROYECTO : Lava Rápido Vehicular
   VERSIÓN  : 3.0
   MOTOR    : PostgreSQL
   CAMBIOS RESPECTO A V2:
     - Eliminada columna modelo en vehiculos
     - Agregado marco de seguridad completo adaptado a PostgreSQL:
       roles, permisos, usuario_rol, rol_permiso,
       sesion_usuario, auditoria, log_errores,
       politicas_contrasenas, configuracion_seguridad
   ================================================================= */


/* =================================================================
   SECCIÓN 1 — TABLAS DE NEGOCIO
   ================================================================= */

/* -----------------------------------------------------------------
   TABLA: usuario
   Almacena clientes, operadores y administradores.
   tipo_usuario se mantiene como columna de referencia rápida;
   el control formal de acceso vive en usuario_rol (sección 2).
   ----------------------------------------------------------------- */
CREATE TABLE usuario (
    id_usuario     INT          GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    correo         VARCHAR(150) NOT NULL UNIQUE,
    nombre         VARCHAR(100) NOT NULL,
    apellido       VARCHAR(100),
    telefono       VARCHAR(20)  NOT NULL,
    contrasena     VARCHAR(255) NOT NULL,
    documento      VARCHAR(30),
    foto_perfil    VARCHAR(255),
    tipo_usuario   VARCHAR(20)  NOT NULL,
    estado         BOOLEAN      NOT NULL DEFAULT TRUE,
    fecha_registro TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT chk_usuario_tipo
        CHECK (tipo_usuario IN ('cliente', 'operador', 'admin'))
);


/* -----------------------------------------------------------------
   TABLA: vehiculos
   Cada vehículo pertenece a un usuario cliente.
   Se eliminó columna modelo según decisión del equipo.
   usuario 1 --- N vehiculos
   ----------------------------------------------------------------- */
CREATE TABLE vehiculos (
    id_vehiculo   INT         GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    fk_id_usuario INT         NOT NULL,
    placa         VARCHAR(10) NOT NULL UNIQUE,
    marca         VARCHAR(50) NOT NULL,
    color         VARCHAR(30),
    tipo_vehiculo VARCHAR(50) NOT NULL,
    estado        BOOLEAN     NOT NULL DEFAULT TRUE,

    CONSTRAINT fk_vehiculos_usuario
        FOREIGN KEY (fk_id_usuario) REFERENCES usuario(id_usuario),

    CONSTRAINT chk_vehiculos_tipo
        CHECK (tipo_vehiculo IN ('carro', 'moto'))
);


/* -----------------------------------------------------------------
   TABLA: ubicacion
   Catálogo de zonas o barrios de cobertura del servicio.
   ----------------------------------------------------------------- */
CREATE TABLE ubicacion (
    id_ubicacion INT          GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre       VARCHAR(100) NOT NULL,
    ciudad       VARCHAR(100),
    departamento VARCHAR(100),
    latitud      DECIMAL(10,7),
    longitud     DECIMAL(10,7),
    estado       BOOLEAN      NOT NULL DEFAULT TRUE
);


/* -----------------------------------------------------------------
   TABLA: cliente_ubicacion
   Direcciones guardadas por cada cliente.
   usuario   1 --- N cliente_ubicacion
   ubicacion 1 --- N cliente_ubicacion
   ----------------------------------------------------------------- */
CREATE TABLE cliente_ubicacion (
    id_direccion        INT          GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    fk_id_usuario       INT          NOT NULL,
    fk_id_ubicacion     INT          NOT NULL,
    direccion_detallada VARCHAR(200) NOT NULL,
    referencia          VARCHAR(200),
    estado              BOOLEAN      NOT NULL DEFAULT TRUE,

    CONSTRAINT fk_cliente_ubicacion_usuario
        FOREIGN KEY (fk_id_usuario) REFERENCES usuario(id_usuario),

    CONSTRAINT fk_cliente_ubicacion_ubicacion
        FOREIGN KEY (fk_id_ubicacion) REFERENCES ubicacion(id_ubicacion)
);


/* -----------------------------------------------------------------
   TABLA: servicios
   Catálogo de tipos de lavado gestionado por el admin.
   La lógica de quién puede modificar esto va en el backend,
   apoyada en los permisos definidos en la sección 2.
   ----------------------------------------------------------------- */
CREATE TABLE servicios (
    id_servicio      INT           GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre           VARCHAR(100)  NOT NULL,
    descripcion      VARCHAR(300),
    precio           DECIMAL(10,2) NOT NULL,
    duracion_minutos INT           NOT NULL,
    estado           BOOLEAN       NOT NULL DEFAULT TRUE,

    CONSTRAINT chk_servicios_precio
        CHECK (precio > 0),

    CONSTRAINT chk_servicios_duracion
        CHECK (duracion_minutos > 0)
);


/* -----------------------------------------------------------------
   TABLA: operadores
   Extiende al usuario con rol 'operador'.
   usuario 1 --- 1 operadores
   ----------------------------------------------------------------- */
CREATE TABLE operadores (
    id_operador    INT       GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    fk_id_usuario  INT       NOT NULL UNIQUE,
    estado         BOOLEAN   NOT NULL DEFAULT TRUE,
    fecha_registro TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_operadores_usuario
        FOREIGN KEY (fk_id_usuario) REFERENCES usuario(id_usuario)
);


/* -----------------------------------------------------------------
   TABLA: disponibilidad
   Horario de trabajo por día para cada operador.
   operadores 1 --- N disponibilidad
   ----------------------------------------------------------------- */
CREATE TABLE disponibilidad (
    id_disponibilidad INT         GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    fk_id_operador    INT         NOT NULL,
    dia_semana        VARCHAR(10) NOT NULL,
    disponible        BOOLEAN     NOT NULL DEFAULT TRUE,
    hora_inicio       TIME        NOT NULL,
    hora_fin          TIME        NOT NULL,

    CONSTRAINT fk_disponibilidad_operadores
        FOREIGN KEY (fk_id_operador) REFERENCES operadores(id_operador),

    CONSTRAINT chk_disponibilidad_dia
        CHECK (dia_semana IN ('lunes', 'martes', 'miercoles', 'jueves',
                              'viernes', 'sabado', 'domingo')),

    CONSTRAINT chk_disponibilidad_horas
        CHECK (hora_fin > hora_inicio),

    CONSTRAINT uq_disponibilidad_operador_dia
        UNIQUE (fk_id_operador, dia_semana)
);


/* -----------------------------------------------------------------
   TABLA: reservas
   Solicitud de servicio creada por un cliente.
   usuario           1 --- N reservas
   vehiculos         1 --- N reservas
   cliente_ubicacion 1 --- N reservas
   servicios         1 --- N reservas
   ----------------------------------------------------------------- */
CREATE TABLE reservas (
    id_reserva        INT           GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    fk_id_usuario     INT           NOT NULL,
    fk_id_vehiculo    INT           NOT NULL,
    fk_id_direccion   INT           NOT NULL,
    fk_id_servicio    INT           NOT NULL,

    fecha_reserva     DATE          NOT NULL,
    hora_reserva      TIME          NOT NULL,
    fecha_hora_inicio TIMESTAMP,
    fecha_hora_fin    TIMESTAMP,

    estado            VARCHAR(30)   NOT NULL DEFAULT 'pendiente',
    subtotal          DECIMAL(10,2) NOT NULL,
    total             DECIMAL(10,2) NOT NULL,
    fecha_creacion    TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_reservas_usuario
        FOREIGN KEY (fk_id_usuario) REFERENCES usuario(id_usuario),

    CONSTRAINT fk_reservas_vehiculos
        FOREIGN KEY (fk_id_vehiculo) REFERENCES vehiculos(id_vehiculo),

    CONSTRAINT fk_reservas_direcciones
        FOREIGN KEY (fk_id_direccion) REFERENCES cliente_ubicacion(id_direccion),

    CONSTRAINT fk_reservas_servicios
        FOREIGN KEY (fk_id_servicio) REFERENCES servicios(id_servicio),

    CONSTRAINT chk_reservas_estado
        CHECK (estado IN ('pendiente', 'asignada', 'en_proceso',
                          'finalizada', 'cancelada')),

    CONSTRAINT chk_reservas_total
        CHECK (total = subtotal),

    CONSTRAINT chk_reservas_subtotal
        CHECK (subtotal > 0)
);


/* -----------------------------------------------------------------
   TABLA: asignaciones
   Vincula una reserva con el operador que la atiende.
   reservas   1 --- N asignaciones
   operadores 1 --- N asignaciones
   ----------------------------------------------------------------- */
CREATE TABLE asignaciones (
    id_asignacion    INT         GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    fk_id_reserva    INT         NOT NULL,
    fk_id_operador   INT         NOT NULL,
    fecha_asignacion TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP,
    llegada_estimada TIMESTAMP,
    estado           VARCHAR(30) NOT NULL DEFAULT 'asignada',

    CONSTRAINT fk_asignaciones_reservas
        FOREIGN KEY (fk_id_reserva) REFERENCES reservas(id_reserva),

    CONSTRAINT fk_asignaciones_operadores
        FOREIGN KEY (fk_id_operador) REFERENCES operadores(id_operador),

    CONSTRAINT chk_asignaciones_estado
        CHECK (estado IN ('asignada', 'aceptada', 'rechazada',
                          'completada', 'cancelada'))
);


/* -----------------------------------------------------------------
   TABLA: pagos
   Registro de transacciones procesadas por Wompi.
   Un pago fallido genera un nuevo registro en lugar de
   sobreescribir el anterior, permitiendo trazabilidad completa.
   reservas 1 --- N pagos
   ----------------------------------------------------------------- */
CREATE TABLE pagos (
    id_pago         INT           GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    fk_id_reserva   INT           NOT NULL,
    metodo_pago     VARCHAR(30)   NOT NULL DEFAULT 'online',
    referencia_pago VARCHAR(100),
    estado_wompi    VARCHAR(30),
    monto           DECIMAL(10,2) NOT NULL,
    estado          VARCHAR(30)   NOT NULL DEFAULT 'pendiente',
    fecha_pago      TIMESTAMP,

    CONSTRAINT fk_pagos_reservas
        FOREIGN KEY (fk_id_reserva) REFERENCES reservas(id_reserva),

    CONSTRAINT chk_pagos_metodo
        CHECK (metodo_pago IN ('online')),

    CONSTRAINT chk_pagos_estado
        CHECK (estado IN ('pendiente', 'aprobado', 'rechazado', 'reembolsado')),

    CONSTRAINT chk_pagos_estado_wompi
        CHECK (estado_wompi IN ('PENDING', 'APPROVED', 'DECLINED',
                                'VOIDED', 'ERROR') OR estado_wompi IS NULL),

    CONSTRAINT chk_pagos_monto
        CHECK (monto > 0)
);


/* -----------------------------------------------------------------
   TABLA: calificaciones
   Una reserva finalizada puede recibir exactamente una
   calificación. El UNIQUE en fk_id_reserva lo garantiza.
   reservas   1 --- 0..1 calificaciones
   usuario    1 --- N   calificaciones
   operadores 1 --- N   calificaciones
   ----------------------------------------------------------------- */
CREATE TABLE calificaciones (
    id_calificacion    INT          GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    fk_id_reserva      INT          NOT NULL UNIQUE,
    fk_id_usuario      INT          NOT NULL,
    fk_id_operador     INT          NOT NULL,
    puntuacion         INT          NOT NULL,
    comentario         VARCHAR(300),
    fecha_calificacion TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_calificaciones_reservas
        FOREIGN KEY (fk_id_reserva) REFERENCES reservas(id_reserva),

    CONSTRAINT fk_calificaciones_usuario
        FOREIGN KEY (fk_id_usuario) REFERENCES usuario(id_usuario),

    CONSTRAINT fk_calificaciones_operadores
        FOREIGN KEY (fk_id_operador) REFERENCES operadores(id_operador),

    CONSTRAINT chk_calificaciones_puntuacion
        CHECK (puntuacion BETWEEN 1 AND 5)
);


/* =================================================================
   SECCIÓN 2 — MARCO DE SEGURIDAD
   Todas las tablas de esta sección son infraestructura de control
   de acceso y trazabilidad. No contienen lógica de negocio.
   ================================================================= */

/* -----------------------------------------------------------------
   TABLA: roles
   Catálogo formal de roles del sistema.
   Los tres valores iniciales son: cliente, operador, admin.
   Separarlo de usuario permite agregar roles futuros sin
   modificar la estructura de la tabla usuario.
   ----------------------------------------------------------------- */
CREATE TABLE roles (
    id_rol      INT          GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre_rol  VARCHAR(50)  NOT NULL UNIQUE,
    descripcion VARCHAR(255)
);


/* -----------------------------------------------------------------
   TABLA: permisos
   Catálogo de acciones concretas que existen en el sistema.
   Ejemplos: gestionar_servicios, ver_reservas, asignar_operador,
   procesar_pago, calificar_servicio.
   ----------------------------------------------------------------- */
CREATE TABLE permisos (
    id_permiso      INT          GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre_permiso  VARCHAR(100) NOT NULL UNIQUE,
    descripcion     VARCHAR(255)
);


/* -----------------------------------------------------------------
   TABLA: usuario_rol
   Asigna uno o más roles a cada usuario.
   Permite que un usuario tenga múltiples roles si el negocio
   lo requiere en el futuro.
   usuario 1 --- N usuario_rol
   roles   1 --- N usuario_rol
   ----------------------------------------------------------------- */
CREATE TABLE usuario_rol (
    fk_id_usuario    INT       NOT NULL,
    fk_id_rol        INT       NOT NULL,
    fecha_asignacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_usuario_rol
        PRIMARY KEY (fk_id_usuario, fk_id_rol),

    CONSTRAINT fk_usuario_rol_usuario
        FOREIGN KEY (fk_id_usuario) REFERENCES usuario(id_usuario),

    CONSTRAINT fk_usuario_rol_rol
        FOREIGN KEY (fk_id_rol) REFERENCES roles(id_rol)
);


/* -----------------------------------------------------------------
   TABLA: rol_permiso
   Asigna permisos a roles. El backend consulta esta tabla para
   decidir si una acción está permitida antes de ejecutarla.
   roles    1 --- N rol_permiso
   permisos 1 --- N rol_permiso
   ----------------------------------------------------------------- */
CREATE TABLE rol_permiso (
    fk_id_rol        INT       NOT NULL,
    fk_id_permiso    INT       NOT NULL,
    fecha_asignacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_rol_permiso
        PRIMARY KEY (fk_id_rol, fk_id_permiso),

    CONSTRAINT fk_rol_permiso_rol
        FOREIGN KEY (fk_id_rol) REFERENCES roles(id_rol),

    CONSTRAINT fk_rol_permiso_permiso
        FOREIGN KEY (fk_id_permiso) REFERENCES permisos(id_permiso)
);


/* -----------------------------------------------------------------
   TABLA: sesion_usuario
   Registra cada sesión activa o cerrada por usuario.
   Permite detectar accesos sospechosos, sesiones simultáneas
   desde IPs distintas y forzar cierres remotos desde el admin.
   usuario 1 --- N sesion_usuario
   ----------------------------------------------------------------- */
CREATE TABLE sesion_usuario (
    id_sesion     INT         GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    fk_id_usuario INT         NOT NULL,
    fecha_inicio  TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_fin     TIMESTAMP,
    ip_origen     VARCHAR(50),
    estado_sesion VARCHAR(30) NOT NULL DEFAULT 'activa',

    CONSTRAINT fk_sesion_usuario
        FOREIGN KEY (fk_id_usuario) REFERENCES usuario(id_usuario),

    CONSTRAINT chk_sesion_estado
        CHECK (estado_sesion IN ('activa', 'cerrada', 'expirada', 'forzada'))
);


/* -----------------------------------------------------------------
   TABLA: auditoria
   Registra acciones importantes de negocio realizadas por
   usuarios. Cubre el RNF12 del SRS: inicios de sesión,
   pagos, modificaciones del admin a servicios y reservas.
   usuario 1 --- N auditoria
   ----------------------------------------------------------------- */
CREATE TABLE auditoria (
    id_auditoria INT          GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    fk_id_usuario INT,
    accion        VARCHAR(255) NOT NULL,
    fecha         TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    descripcion   VARCHAR(500),
    ip_origen     VARCHAR(50),
    modulo        VARCHAR(100),

    CONSTRAINT fk_auditoria_usuario
        FOREIGN KEY (fk_id_usuario) REFERENCES usuario(id_usuario)
);


/* -----------------------------------------------------------------
   TABLA: log_errores
   Registra fallos técnicos separados de la auditoría de negocio:
   intentos de login fallidos, errores de Wompi, excepciones
   del servidor. fk_id_usuario es NULL si el error ocurre
   antes de que el usuario se autentique.
   usuario 1 --- N log_errores
   ----------------------------------------------------------------- */
CREATE TABLE log_errores (
    id_error      INT          GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    fk_id_usuario INT,
    tipo_error    VARCHAR(100) NOT NULL,
    descripcion   VARCHAR(500),
    fecha         TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ip_origen     VARCHAR(50),

    CONSTRAINT fk_log_errores_usuario
        FOREIGN KEY (fk_id_usuario) REFERENCES usuario(id_usuario)
);


/* -----------------------------------------------------------------
   TABLA: politicas_contrasenas
   Define las reglas de seguridad para contraseñas.
   El backend la lee al momento de crear o cambiar una contraseña.
   Cubre el criterio de aceptación de RF1.4 del SRS:
   mínimo 8 caracteres, mayúscula, minúscula y número.
   Solo debe existir un registro activo a la vez.
   ----------------------------------------------------------------- */
CREATE TABLE politicas_contrasenas (
    id_politica          INT     GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    min_longitud         INT     NOT NULL DEFAULT 8,
    max_longitud         INT     NOT NULL DEFAULT 20,
    requiere_mayusculas  BOOLEAN NOT NULL DEFAULT TRUE,
    requiere_minusculas  BOOLEAN NOT NULL DEFAULT TRUE,
    requiere_numeros     BOOLEAN NOT NULL DEFAULT TRUE,
    requiere_simbolos    BOOLEAN NOT NULL DEFAULT FALSE,
    caducidad_dias       INT              DEFAULT 90,
    activa               BOOLEAN NOT NULL DEFAULT TRUE,

    CONSTRAINT chk_politica_min
        CHECK (min_longitud >= 6),

    CONSTRAINT chk_politica_max
        CHECK (max_longitud >= min_longitud)
);


/* -----------------------------------------------------------------
   TABLA: configuracion_seguridad
   Parámetros globales del sistema que el backend consulta
   en tiempo de ejecución. Permite cambiar comportamientos
   sin redesplegar la aplicación.
   Ejemplos de registros:
     max_intentos_login        → '5'
     tiempo_expiracion_sesion  → '3600'  (segundos)
     bloqueo_cuenta_minutos    → '30'
   ----------------------------------------------------------------- */
CREATE TABLE configuracion_seguridad (
    id_config      INT          GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre_config  VARCHAR(100) NOT NULL UNIQUE,
    valor_config   VARCHAR(100) NOT NULL,
    descripcion    VARCHAR(255)
);

