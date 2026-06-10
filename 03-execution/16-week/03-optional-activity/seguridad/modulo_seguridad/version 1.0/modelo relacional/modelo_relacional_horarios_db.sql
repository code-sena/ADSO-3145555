
-- Extensión para UUID
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- ============================================================
-- MÓDULO 2 — ESTRUCTURA INSTITUCIONAL
-- Tablas: regional, centro_formacion, sede
-- Nota: sede ahora depende de centro_formacion
-- ============================================================

CREATE TABLE regional (
    id          UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre      VARCHAR(120) NOT NULL,
    codigo      VARCHAR(20)  NOT NULL UNIQUE,
    activo      BOOLEAN      NOT NULL DEFAULT TRUE,
    created_at  TIMESTAMP    NOT NULL DEFAULT NOW(),
    updated_at  TIMESTAMP    NOT NULL DEFAULT NOW()
);

CREATE TABLE centro_formacion (
    id          UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
    regional_id UUID        NOT NULL REFERENCES regional(id),
    nombre      VARCHAR(150) NOT NULL,
    codigo      VARCHAR(20)  NOT NULL UNIQUE,
    activo      BOOLEAN      NOT NULL DEFAULT TRUE,
    created_at  TIMESTAMP    NOT NULL DEFAULT NOW(),
    updated_at  TIMESTAMP    NOT NULL DEFAULT NOW()
);

CREATE TABLE sede (
    id                  UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
    centro_formacion_id UUID        NOT NULL REFERENCES centro_formacion(id),
    nombre              VARCHAR(150) NOT NULL,
    direccion           VARCHAR(255),
    ciudad              VARCHAR(100),
    activo              BOOLEAN      NOT NULL DEFAULT TRUE,
    created_at          TIMESTAMP    NOT NULL DEFAULT NOW(),
    updated_at          TIMESTAMP    NOT NULL DEFAULT NOW()
);

-- ============================================================
-- MÓDULO 3 — CATÁLOGOS BASE
-- Tablas: tipo_ambiente, tipo_contrato, jornada,
--         modalidad_formacion, nivel_formacion, parametro_sistema
-- ============================================================

CREATE TABLE tipo_ambiente (
    id          UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre      VARCHAR(100) NOT NULL,
    descripcion TEXT,
    created_at  TIMESTAMP    NOT NULL DEFAULT NOW(),
    updated_at  TIMESTAMP    NOT NULL DEFAULT NOW()
);

CREATE TABLE tipo_contrato (
    id               UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre           VARCHAR(100) NOT NULL,
    max_horas_semana INTEGER,
    created_at       TIMESTAMP    NOT NULL DEFAULT NOW(),
    updated_at       TIMESTAMP    NOT NULL DEFAULT NOW()
);

CREATE TABLE jornada (
    id          UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre      VARCHAR(80)  NOT NULL,
    hora_inicio TIME         NOT NULL,
    hora_fin    TIME         NOT NULL,
    created_at  TIMESTAMP    NOT NULL DEFAULT NOW(),
    updated_at  TIMESTAMP    NOT NULL DEFAULT NOW()
);

CREATE TABLE modalidad_formacion (
    id          UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre      VARCHAR(100) NOT NULL,  -- presencial, virtual, a distancia
    descripcion TEXT,
    activo      BOOLEAN      NOT NULL DEFAULT TRUE,
    created_at  TIMESTAMP    NOT NULL DEFAULT NOW(),
    updated_at  TIMESTAMP    NOT NULL DEFAULT NOW()
);

CREATE TABLE nivel_formacion (
    id          UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre      VARCHAR(100) NOT NULL,  -- tecnico, tecnologo, especialización
    descripcion TEXT,
    activo      BOOLEAN      NOT NULL DEFAULT TRUE,
    created_at  TIMESTAMP    NOT NULL DEFAULT NOW(),
    updated_at  TIMESTAMP    NOT NULL DEFAULT NOW()
);

CREATE TABLE parametro_sistema (
    id          UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
    clave       VARCHAR(100) NOT NULL UNIQUE,
    valor       TEXT         NOT NULL,
    descripcion TEXT,
    created_at  TIMESTAMP    NOT NULL DEFAULT NOW(),
    updated_at  TIMESTAMP    NOT NULL DEFAULT NOW()
);

-- ============================================================
-- MÓDULO 1 — SEGURIDAD Y ACCESO
-- Tablas: rol, permiso, rol_permiso, usuario, sesion, auditoria
-- ============================================================

CREATE TABLE rol (
    id          UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre      VARCHAR(80)  NOT NULL UNIQUE,
    descripcion TEXT,
    created_at  TIMESTAMP    NOT NULL DEFAULT NOW(),
    updated_at  TIMESTAMP    NOT NULL DEFAULT NOW()
);

CREATE TABLE permiso (
    id          UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
    codigo      VARCHAR(100) NOT NULL UNIQUE,
    descripcion TEXT,
    modulo      VARCHAR(80)  NOT NULL,
    created_at  TIMESTAMP    NOT NULL DEFAULT NOW(),
    updated_at  TIMESTAMP    NOT NULL DEFAULT NOW()
);

CREATE TABLE rol_permiso (
    id         UUID      PRIMARY KEY DEFAULT gen_random_uuid(),
    rol_id     UUID      NOT NULL REFERENCES rol(id),
    permiso_id UUID      NOT NULL REFERENCES permiso(id),
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    UNIQUE (rol_id, permiso_id)
);

CREATE TABLE usuario (
    id              UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
    documento       VARCHAR(30)  NOT NULL UNIQUE,
    nombre          VARCHAR(120) NOT NULL,
    apellido        VARCHAR(120) NOT NULL,
    correo          VARCHAR(200) NOT NULL UNIQUE,
    contrasena_hash VARCHAR(255) NOT NULL,
    rol_id          UUID         NOT NULL REFERENCES rol(id),
    sede_id         UUID         NOT NULL REFERENCES sede(id),
    activo          BOOLEAN      NOT NULL DEFAULT TRUE,
    created_at      TIMESTAMP    NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMP    NOT NULL DEFAULT NOW()
);

CREATE TABLE sesion (
    id          UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
    usuario_id  UUID        NOT NULL REFERENCES usuario(id),
    token_hash  VARCHAR(255) NOT NULL,
    ip_origen   VARCHAR(45),
    user_agent  TEXT,
    activa      BOOLEAN      NOT NULL DEFAULT TRUE,
    expires_at  TIMESTAMP    NOT NULL,
    created_at  TIMESTAMP    NOT NULL DEFAULT NOW(),
    updated_at  TIMESTAMP    NOT NULL DEFAULT NOW()
);

CREATE TABLE auditoria (
    id                UUID      PRIMARY KEY DEFAULT gen_random_uuid(),
    tabla_afectada    VARCHAR(80) NOT NULL,
    registro_id       UUID,
    accion            VARCHAR(20) NOT NULL,   -- INSERT, UPDATE, DELETE
    datos_anteriores  JSONB,
    datos_nuevos      JSONB,
    usuario_id        UUID      REFERENCES usuario(id) ON DELETE SET NULL,
    -- Copia inmutable del momento del evento (no viola 3FN: son snapshots)
    usuario_documento VARCHAR(30),
    usuario_nombre    VARCHAR(120),
    usuario_rol       VARCHAR(80),
    ip_origen         VARCHAR(45),
    created_at        TIMESTAMP NOT NULL DEFAULT NOW()
);

-- ============================================================
-- MÓDULO 4 — LÍNEAS Y REDES
-- Tablas: linea_tecnologica, red_conocimiento, red_linea
-- ============================================================

CREATE TABLE linea_tecnologica (
    id          UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre      VARCHAR(150) NOT NULL,
    codigo      VARCHAR(20)  NOT NULL UNIQUE,
    descripcion TEXT,
    activo      BOOLEAN      NOT NULL DEFAULT TRUE,
    created_at  TIMESTAMP    NOT NULL DEFAULT NOW(),
    updated_at  TIMESTAMP    NOT NULL DEFAULT NOW()
);

CREATE TABLE red_conocimiento (
    id                  UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
    linea_tecnologica_id UUID       NOT NULL REFERENCES linea_tecnologica(id),
    nombre              VARCHAR(150) NOT NULL,
    codigo              VARCHAR(20)  NOT NULL UNIQUE,
    descripcion         TEXT,
    activo              BOOLEAN      NOT NULL DEFAULT TRUE,
    created_at          TIMESTAMP    NOT NULL DEFAULT NOW(),
    updated_at          TIMESTAMP    NOT NULL DEFAULT NOW()
);

-- ============================================================
-- MÓDULO 5 — OFERTA Y PROGRAMAS
-- Tablas: programa_formacion
-- Amplía con FK a modalidad, nivel y red de conocimiento
-- ============================================================

CREATE TABLE programa_formacion (
    id                    UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
    red_conocimiento_id   UUID        NOT NULL REFERENCES red_conocimiento(id),
    modalidad_id          UUID        NOT NULL REFERENCES modalidad_formacion(id),
    nivel_id              UUID        NOT NULL REFERENCES nivel_formacion(id),
    nombre                VARCHAR(200) NOT NULL,
    codigo                VARCHAR(20)  NOT NULL UNIQUE,
    duracion_meses        INTEGER      NOT NULL,
    activo                BOOLEAN      NOT NULL DEFAULT TRUE,
    created_at            TIMESTAMP    NOT NULL DEFAULT NOW(),
    updated_at            TIMESTAMP    NOT NULL DEFAULT NOW()
);

-- ============================================================
-- MÓDULO 6 — PROGRAMA ACADÉMICO
-- Tablas: competencia, resultado_aprendizaje,
--         competencia_resultado, programa_competencia
-- ============================================================

CREATE TABLE competencia (
    id          UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
    codigo      VARCHAR(30)  NOT NULL UNIQUE,
    nombre      VARCHAR(200) NOT NULL,
    descripcion TEXT,
    activo      BOOLEAN      NOT NULL DEFAULT TRUE,
    created_at  TIMESTAMP    NOT NULL DEFAULT NOW(),
    updated_at  TIMESTAMP    NOT NULL DEFAULT NOW()
);

CREATE TABLE resultado_aprendizaje (
    id          UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
    codigo      VARCHAR(30)  NOT NULL UNIQUE,
    nombre      VARCHAR(200) NOT NULL,
    descripcion TEXT,
    activo      BOOLEAN      NOT NULL DEFAULT TRUE,
    created_at  TIMESTAMP    NOT NULL DEFAULT NOW(),
    updated_at  TIMESTAMP    NOT NULL DEFAULT NOW()
);

CREATE TABLE competencia_resultado (
    id             UUID      PRIMARY KEY DEFAULT gen_random_uuid(),
    competencia_id UUID      NOT NULL REFERENCES competencia(id),
    resultado_id   UUID      NOT NULL REFERENCES resultado_aprendizaje(id),
    created_at     TIMESTAMP NOT NULL DEFAULT NOW(),
    UNIQUE (competencia_id, resultado_id)
);

CREATE TABLE programa_competencia (
    id             UUID      PRIMARY KEY DEFAULT gen_random_uuid(),
    programa_id    UUID      NOT NULL REFERENCES programa_formacion(id),
    competencia_id UUID      NOT NULL REFERENCES competencia(id),
    horas_lectivas INTEGER   NOT NULL,
    activo         BOOLEAN   NOT NULL DEFAULT TRUE,
    created_at     TIMESTAMP NOT NULL DEFAULT NOW(),
    UNIQUE (programa_id, competencia_id)
);

-- ============================================================
-- MÓDULO 7 — INSTRUCTORES
-- Tablas: instructor, instructor_competencia
-- 3FN CORREGIDO: nombre/apellido/documento/correo viven en
-- usuario; instructor solo tiene datos profesionales propios
-- ============================================================

CREATE TABLE instructor (
    id               UUID      PRIMARY KEY DEFAULT gen_random_uuid(),
    usuario_id       UUID      NOT NULL UNIQUE REFERENCES usuario(id),
    tipo_contrato_id UUID      NOT NULL REFERENCES tipo_contrato(id),
    sede_id          UUID      NOT NULL REFERENCES sede(id),
    telefono         VARCHAR(20),
    activo           BOOLEAN   NOT NULL DEFAULT TRUE,
    created_at       TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at       TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE instructor_competencia (
    id             UUID      PRIMARY KEY DEFAULT gen_random_uuid(),
    instructor_id  UUID      NOT NULL REFERENCES instructor(id),
    competencia_id UUID      NOT NULL REFERENCES competencia(id),
    programa_id    UUID      NOT NULL REFERENCES programa_formacion(id),
    fecha_inicio   DATE      NOT NULL,
    fecha_fin      DATE,
    activo         BOOLEAN   NOT NULL DEFAULT TRUE,
    created_at     TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at     TIMESTAMP NOT NULL DEFAULT NOW(),
    UNIQUE (instructor_id, competencia_id, programa_id)
);

-- ============================================================
-- MÓDULO 8 — AMBIENTES
-- Tablas: ambiente, recurso_ambiente, disponibilidad_ambiente
-- ============================================================

CREATE TABLE ambiente (
    id               UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
    sede_id          UUID        NOT NULL REFERENCES sede(id),
    tipo_ambiente_id UUID        NOT NULL REFERENCES tipo_ambiente(id),
    codigo           VARCHAR(30)  NOT NULL UNIQUE,
    nombre           VARCHAR(150) NOT NULL,
    capacidad        INTEGER      NOT NULL,
    ubicacion        VARCHAR(200),
    activo           BOOLEAN      NOT NULL DEFAULT TRUE,
    created_at       TIMESTAMP    NOT NULL DEFAULT NOW(),
    updated_at       TIMESTAMP    NOT NULL DEFAULT NOW()
);

CREATE TABLE recurso_ambiente (
    id          UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
    ambiente_id UUID        NOT NULL REFERENCES ambiente(id),
    nombre      VARCHAR(120) NOT NULL,
    cantidad    INTEGER      NOT NULL DEFAULT 1,
    created_at  TIMESTAMP    NOT NULL DEFAULT NOW(),
    updated_at  TIMESTAMP    NOT NULL DEFAULT NOW()
);

CREATE TABLE disponibilidad_ambiente (
    id             UUID      PRIMARY KEY DEFAULT gen_random_uuid(),
    ambiente_id    UUID      NOT NULL REFERENCES ambiente(id),
    franja_id      UUID      NOT NULL REFERENCES franja_horaria(id),  -- FK declarada después con ALTER
    dia_semana     SMALLINT  NOT NULL CHECK (dia_semana BETWEEN 1 AND 7),
    disponible     BOOLEAN   NOT NULL DEFAULT TRUE,
    motivo_bloqueo VARCHAR(255),
    fecha_desde    DATE,
    fecha_hasta    DATE,
    created_at     TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at     TIMESTAMP NOT NULL DEFAULT NOW()
);

-- ============================================================
-- MÓDULO 9 — FICHAS Y FRANJAS HORARIAS
-- Tablas: franja_horaria, ficha, extension_ficha
-- ============================================================

CREATE TABLE franja_horaria (
    id          UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
    jornada_id  UUID        NOT NULL REFERENCES jornada(id),
    nombre      VARCHAR(80)  NOT NULL,
    hora_inicio TIME         NOT NULL,
    hora_fin    TIME         NOT NULL,
    activo      BOOLEAN      NOT NULL DEFAULT TRUE,
    created_at  TIMESTAMP    NOT NULL DEFAULT NOW(),
    updated_at  TIMESTAMP    NOT NULL DEFAULT NOW()
);

-- FK diferida de disponibilidad_ambiente → franja_horaria
ALTER TABLE disponibilidad_ambiente
    ADD CONSTRAINT fk_disponibilidad_franja
    FOREIGN KEY (franja_id) REFERENCES franja_horaria(id);

CREATE TABLE ficha (
    id                   UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
    programa_id          UUID        NOT NULL REFERENCES programa_formacion(id),
    sede_id              UUID        NOT NULL REFERENCES sede(id),
    jornada_id           UUID        NOT NULL REFERENCES jornada(id),
    codigo               VARCHAR(20)  NOT NULL UNIQUE,
    fecha_inicio         DATE         NOT NULL,
    fecha_fin            DATE         NOT NULL,
    fecha_fin_extendida  DATE,
    numero_aprendices    INTEGER      NOT NULL DEFAULT 0,
    activo               BOOLEAN      NOT NULL DEFAULT TRUE,
    created_at           TIMESTAMP    NOT NULL DEFAULT NOW(),
    updated_at           TIMESTAMP    NOT NULL DEFAULT NOW()
);

CREATE TABLE extension_ficha (
    id                 UUID      PRIMARY KEY DEFAULT gen_random_uuid(),
    ficha_id           UUID      NOT NULL REFERENCES ficha(id),
    usuario_id         UUID      NOT NULL REFERENCES usuario(id),
    fecha_fin_anterior DATE      NOT NULL,
    fecha_fin_nueva    DATE      NOT NULL,
    motivo             TEXT      NOT NULL,
    created_at         TIMESTAMP NOT NULL DEFAULT NOW()
);

-- ============================================================
-- MÓDULO 10 — APRENDICES
-- Tablas: aprendiz, aprendiz_ficha
-- 3FN CORREGIDO: nombre/apellido/documento/correo viven en
-- usuario; aprendiz solo tiene datos de seguimiento propios
-- ============================================================

CREATE TABLE aprendiz (
    id         UUID      PRIMARY KEY DEFAULT gen_random_uuid(),
    usuario_id UUID      NOT NULL UNIQUE REFERENCES usuario(id),
    sede_id    UUID      NOT NULL REFERENCES sede(id),
    telefono   VARCHAR(20),
    activo     BOOLEAN   NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE aprendiz_ficha (
    id              UUID      PRIMARY KEY DEFAULT gen_random_uuid(),
    aprendiz_id     UUID      NOT NULL REFERENCES aprendiz(id),
    ficha_id        UUID      NOT NULL REFERENCES ficha(id),
    fecha_matricula DATE      NOT NULL,
    estado          VARCHAR(30) NOT NULL DEFAULT 'activo',
    -- activo | retirado | trasladado | egresado
    created_at      TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMP NOT NULL DEFAULT NOW(),
    UNIQUE (aprendiz_id, ficha_id)
);

-- ============================================================
-- MÓDULO 11 — MOTOR DE HORARIOS
-- Tabla: horario
-- Las tres restricciones UNIQUE son la implementación técnica
-- de la triple restricción: instructor + ambiente + ficha
-- no pueden repetirse en la misma franja y fecha
-- ============================================================

CREATE TABLE horario (
    id                UUID      PRIMARY KEY DEFAULT gen_random_uuid(),
    ficha_id          UUID      NOT NULL REFERENCES ficha(id),
    instructor_id     UUID      NOT NULL REFERENCES instructor(id),
    ambiente_id       UUID      NOT NULL REFERENCES ambiente(id),
    competencia_id    UUID      NOT NULL REFERENCES competencia(id),
    franja_horaria_id UUID      NOT NULL REFERENCES franja_horaria(id),
    created_by        UUID      NOT NULL REFERENCES usuario(id),
    fecha             DATE      NOT NULL,
    estado            VARCHAR(30) NOT NULL DEFAULT 'programado',
    -- programado | cancelado | reprogramado
    created_at        TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at        TIMESTAMP NOT NULL DEFAULT NOW(),
    -- Triple restricción: imposibilidad técnica de cruces
    UNIQUE (instructor_id,  franja_horaria_id, fecha),
    UNIQUE (ambiente_id,    franja_horaria_id, fecha),
    UNIQUE (ficha_id,       franja_horaria_id, fecha)
);

-- ============================================================
-- MÓDULO 12 — OBSERVACIONES E INCIDENCIAS
-- Tablas: observacion, observacion_estado
-- ============================================================

CREATE TABLE observacion (
    id               UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
    reportado_por    UUID        NOT NULL REFERENCES usuario(id),
    resuelto_por     UUID        REFERENCES usuario(id),
    ficha_id         UUID        REFERENCES ficha(id),
    instructor_id    UUID        REFERENCES instructor(id),
    ambiente_id      UUID        REFERENCES ambiente(id),
    horario_id       UUID        REFERENCES horario(id),
    tipo             VARCHAR(40)  NOT NULL,
    -- cruce | queja | solicitud | incidencia | bloqueo
    severidad        VARCHAR(20)  NOT NULL,
    -- info | warning | critical
    descripcion      TEXT         NOT NULL,
    estado           VARCHAR(30)  NOT NULL DEFAULT 'abierta',
    -- abierta | en_gestion | resuelta | cerrada
    fecha_resolucion TIMESTAMP,
    created_at       TIMESTAMP    NOT NULL DEFAULT NOW(),
    updated_at       TIMESTAMP    NOT NULL DEFAULT NOW()
);

CREATE TABLE observacion_estado (
    id              UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
    observacion_id  UUID        NOT NULL REFERENCES observacion(id),
    usuario_id      UUID        NOT NULL REFERENCES usuario(id),
    estado_anterior VARCHAR(30)  NOT NULL,
    estado_nuevo    VARCHAR(30)  NOT NULL,
    comentario      TEXT,
    created_at      TIMESTAMP    NOT NULL DEFAULT NOW()
);

-- ============================================================
-- MÓDULO 13 — PROYECTOS FORMATIVOS
-- Tablas: proyecto_formativo, proyecto_hito, proyecto_integrante
-- ============================================================

CREATE TABLE proyecto_formativo (
    id            UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
    ficha_id      UUID        NOT NULL REFERENCES ficha(id),
    creado_por    UUID        NOT NULL REFERENCES usuario(id),
    titulo        VARCHAR(255) NOT NULL,
    descripcion   TEXT,
    tipo          VARCHAR(50)  NOT NULL DEFAULT 'tecnico',
    -- tecnico | tecnologo | investigacion
    estado        VARCHAR(30)  NOT NULL DEFAULT 'formulacion',
    -- formulacion | ejecucion | revision | aprobado | archivado
    fecha_inicio  DATE         NOT NULL,
    fecha_fin     DATE,
    activo        BOOLEAN      NOT NULL DEFAULT TRUE,
    created_at    TIMESTAMP    NOT NULL DEFAULT NOW(),
    updated_at    TIMESTAMP    NOT NULL DEFAULT NOW()
);

CREATE TABLE proyecto_hito (
    id                    UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
    proyecto_formativo_id UUID        NOT NULL REFERENCES proyecto_formativo(id),
    nombre                VARCHAR(200) NOT NULL,
    descripcion           TEXT,
    fecha_limite          DATE,
    completado            BOOLEAN      NOT NULL DEFAULT FALSE,
    created_at            TIMESTAMP    NOT NULL DEFAULT NOW(),
    updated_at            TIMESTAMP    NOT NULL DEFAULT NOW()
);

CREATE TABLE proyecto_integrante (
    id                    UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
    proyecto_formativo_id UUID        NOT NULL REFERENCES proyecto_formativo(id),
    aprendiz_id           UUID        NOT NULL REFERENCES aprendiz(id),
    rol_en_proyecto       VARCHAR(80),
    -- lider | colaborador | investigador
    created_at            TIMESTAMP   NOT NULL DEFAULT NOW(),
    UNIQUE (proyecto_formativo_id, aprendiz_id)
);

-- ============================================================
-- MÓDULO 14 — COORDINACIÓN Y EVALUACIÓN
-- Tabla: evaluacion_proyecto
-- El coordinador evalúa proyectos sin afectar el horario
-- ============================================================

CREATE TABLE evaluacion_proyecto (
    id                    UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
    proyecto_formativo_id UUID        NOT NULL REFERENCES proyecto_formativo(id),
    evaluador_id          UUID        NOT NULL REFERENCES usuario(id),
    calificacion          NUMERIC(4,2) CHECK (calificacion BETWEEN 0 AND 5),
    observacion           TEXT,
    fecha_evaluacion      DATE         NOT NULL,
    estado                VARCHAR(30)  NOT NULL DEFAULT 'pendiente',
    -- pendiente | aprobado | aplazado | no_aprobado
    created_at            TIMESTAMP    NOT NULL DEFAULT NOW(),
    updated_at            TIMESTAMP    NOT NULL DEFAULT NOW()
);

-- ============================================================
-- MÓDULO 15 — NOTIFICACIONES Y TRAZABILIDAD
-- Tabla: notificacion
-- Trazabilidad cubierta por: auditoria (módulo 1)
-- ============================================================

CREATE TABLE notificacion (
    id               UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
    usuario_id       UUID        NOT NULL REFERENCES usuario(id),
    titulo           VARCHAR(200) NOT NULL,
    mensaje          TEXT         NOT NULL,
    tipo             VARCHAR(50)  NOT NULL,
    -- horario | observacion | ficha | proyecto | sistema
    leida            BOOLEAN      NOT NULL DEFAULT FALSE,
    referencia_id    UUID,
    referencia_tabla VARCHAR(80),
    created_at       TIMESTAMP    NOT NULL DEFAULT NOW()
);

-- ============================================================
-- ÍNDICES DE RENDIMIENTO
-- Complementan las restricciones UNIQUE del motor de horarios
-- ============================================================

-- Búsqueda rápida de horarios por fecha y franja
CREATE INDEX idx_horario_fecha           ON horario (fecha);
CREATE INDEX idx_horario_ficha           ON horario (ficha_id);
CREATE INDEX idx_horario_instructor      ON horario (instructor_id);
CREATE INDEX idx_horario_ambiente        ON horario (ambiente_id);

-- Búsqueda de disponibilidad de ambientes
CREATE INDEX idx_disp_ambiente_dia       ON disponibilidad_ambiente (ambiente_id, dia_semana);

-- Notificaciones no leídas por usuario
CREATE INDEX idx_notif_usuario_leida     ON notificacion (usuario_id, leida);

-- Observaciones abiertas
CREATE INDEX idx_obs_estado              ON observacion (estado);
CREATE INDEX idx_obs_horario             ON observacion (horario_id);

-- Sesiones activas por usuario
CREATE INDEX idx_sesion_usuario_activa   ON sesion (usuario_id, activa);

-- Auditoría por tabla y registro
CREATE INDEX idx_auditoria_tabla_reg     ON auditoria (tabla_afectada, registro_id);

-- Fichas vigentes por sede y programa
CREATE INDEX idx_ficha_sede_activo       ON ficha (sede_id, activo);
CREATE INDEX idx_ficha_programa          ON ficha (programa_id);

-- Proyectos formativos por ficha
CREATE INDEX idx_proyecto_ficha          ON proyecto_formativo (ficha_id);

-- Instructor habilitado (consulta crítica del motor)
CREATE INDEX idx_inst_comp_prog          ON instructor_competencia (instructor_id, competencia_id, programa_id);

