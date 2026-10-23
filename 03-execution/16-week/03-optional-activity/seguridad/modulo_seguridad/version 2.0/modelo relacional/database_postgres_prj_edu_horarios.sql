-- PRJ-EDU-HORARIOS / SIGHA SENA
-- Base de datos PostgreSQL recomendada
-- Version: institucional escalable
-- Enfoque: horarios academicos sin cruces, trazabilidad y crecimiento por fases

CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE SCHEMA IF NOT EXISTS horarios;
SET search_path TO horarios;

-- =========================================================
-- 1. UTILIDADES
-- =========================================================

CREATE OR REPLACE FUNCTION horarios.set_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- =========================================================
-- 2. ESTRUCTURA INSTITUCIONAL Y CATALOGOS
-- =========================================================

CREATE TABLE regional (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  codigo VARCHAR(30) UNIQUE NOT NULL,
  nombre VARCHAR(150) NOT NULL,
  activo BOOLEAN NOT NULL DEFAULT TRUE,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE centro_formacion (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  regional_id UUID NOT NULL REFERENCES regional(id),
  codigo VARCHAR(30) UNIQUE NOT NULL,
  nombre VARCHAR(180) NOT NULL,
  ciudad VARCHAR(100),
  activo BOOLEAN NOT NULL DEFAULT TRUE,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE sede (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  centro_formacion_id UUID NOT NULL REFERENCES centro_formacion(id),
  nombre VARCHAR(150) NOT NULL,
  direccion VARCHAR(220),
  ciudad VARCHAR(100),
  activo BOOLEAN NOT NULL DEFAULT TRUE,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW(),
  UNIQUE (centro_formacion_id, nombre)
);

CREATE TABLE modalidad (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nombre VARCHAR(80) UNIQUE NOT NULL,
  descripcion TEXT,
  activo BOOLEAN NOT NULL DEFAULT TRUE,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE tipo_ambiente (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nombre VARCHAR(100) UNIQUE NOT NULL,
  descripcion TEXT,
  activo BOOLEAN NOT NULL DEFAULT TRUE,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE tipo_contrato (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nombre VARCHAR(100) UNIQUE NOT NULL,
  max_horas_semana INTEGER CHECK (max_horas_semana IS NULL OR max_horas_semana > 0),
  activo BOOLEAN NOT NULL DEFAULT TRUE,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE jornada (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nombre VARCHAR(80) UNIQUE NOT NULL,
  hora_inicio TIME NOT NULL,
  hora_fin TIME NOT NULL,
  activo BOOLEAN NOT NULL DEFAULT TRUE,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW(),
  CHECK (hora_fin > hora_inicio)
);

CREATE TABLE parametro_sistema (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  clave VARCHAR(120) UNIQUE NOT NULL,
  valor TEXT NOT NULL,
  descripcion TEXT,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

-- =========================================================
-- 3. SEGURIDAD Y ACCESO
-- =========================================================

CREATE TABLE rol (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nombre VARCHAR(100) UNIQUE NOT NULL,
  descripcion TEXT,
  activo BOOLEAN NOT NULL DEFAULT TRUE,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE permiso (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  codigo VARCHAR(120) UNIQUE NOT NULL,
  descripcion TEXT,
  modulo VARCHAR(80) NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE rol_permiso (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  rol_id UUID NOT NULL REFERENCES rol(id) ON DELETE CASCADE,
  permiso_id UUID NOT NULL REFERENCES permiso(id) ON DELETE CASCADE,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  UNIQUE (rol_id, permiso_id)
);

CREATE TABLE usuario (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  documento VARCHAR(30) UNIQUE NOT NULL,
  nombre VARCHAR(100) NOT NULL,
  apellido VARCHAR(100) NOT NULL,
  correo VARCHAR(180) UNIQUE NOT NULL,
  contrasena_hash VARCHAR(255) NOT NULL,
  rol_id UUID NOT NULL REFERENCES rol(id),
  sede_id UUID REFERENCES sede(id),
  activo BOOLEAN NOT NULL DEFAULT TRUE,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE sesion (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  usuario_id UUID NOT NULL REFERENCES usuario(id) ON DELETE CASCADE,
  token_hash VARCHAR(255) NOT NULL,
  ip_origen VARCHAR(80),
  user_agent TEXT,
  activa BOOLEAN NOT NULL DEFAULT TRUE,
  expires_at TIMESTAMP NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE auditoria (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  tabla_afectada VARCHAR(120) NOT NULL,
  registro_id UUID,
  accion VARCHAR(30) NOT NULL CHECK (accion IN ('insert', 'update', 'delete', 'login', 'logout', 'validacion')),
  datos_anteriores JSONB,
  datos_nuevos JSONB,
  usuario_id UUID REFERENCES usuario(id) ON DELETE SET NULL,
  usuario_documento VARCHAR(30),
  usuario_nombre VARCHAR(220),
  usuario_rol VARCHAR(120),
  ip_origen VARCHAR(80),
  created_at TIMESTAMP NOT NULL DEFAULT NOW()
);

-- =========================================================
-- 4. PROGRAMA ACADEMICO Y OFERTA
-- =========================================================

CREATE TABLE linea_tecnologica (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nombre VARCHAR(150) UNIQUE NOT NULL,
  descripcion TEXT,
  activo BOOLEAN NOT NULL DEFAULT TRUE,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE red_conocimiento (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nombre VARCHAR(150) UNIQUE NOT NULL,
  descripcion TEXT,
  activo BOOLEAN NOT NULL DEFAULT TRUE,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE programa_formacion (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  linea_tecnologica_id UUID REFERENCES linea_tecnologica(id),
  nombre VARCHAR(220) NOT NULL,
  codigo VARCHAR(60) UNIQUE NOT NULL,
  nivel_formacion VARCHAR(80) NOT NULL,
  duracion_meses INTEGER CHECK (duracion_meses IS NULL OR duracion_meses > 0),
  activo BOOLEAN NOT NULL DEFAULT TRUE,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE programa_red (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  programa_id UUID NOT NULL REFERENCES programa_formacion(id) ON DELETE CASCADE,
  red_conocimiento_id UUID NOT NULL REFERENCES red_conocimiento(id),
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  UNIQUE (programa_id, red_conocimiento_id)
);

CREATE TABLE oferta_formacion (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  programa_id UUID NOT NULL REFERENCES programa_formacion(id),
  sede_id UUID NOT NULL REFERENCES sede(id),
  modalidad_id UUID NOT NULL REFERENCES modalidad(id),
  codigo_oferta VARCHAR(80) UNIQUE NOT NULL,
  fecha_inicio DATE NOT NULL,
  fecha_fin DATE NOT NULL,
  estado VARCHAR(30) NOT NULL DEFAULT 'activa'
    CHECK (estado IN ('planeada', 'activa', 'cerrada', 'cancelada')),
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW(),
  CHECK (fecha_fin >= fecha_inicio)
);

CREATE TABLE competencia (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  codigo VARCHAR(80) UNIQUE NOT NULL,
  nombre VARCHAR(250) NOT NULL,
  descripcion TEXT,
  activo BOOLEAN NOT NULL DEFAULT TRUE,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE resultado_aprendizaje (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  codigo VARCHAR(80) UNIQUE NOT NULL,
  nombre VARCHAR(250) NOT NULL,
  descripcion TEXT,
  activo BOOLEAN NOT NULL DEFAULT TRUE,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE competencia_resultado (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  competencia_id UUID NOT NULL REFERENCES competencia(id) ON DELETE CASCADE,
  resultado_id UUID NOT NULL REFERENCES resultado_aprendizaje(id) ON DELETE CASCADE,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  UNIQUE (competencia_id, resultado_id)
);

CREATE TABLE programa_competencia (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  programa_id UUID NOT NULL REFERENCES programa_formacion(id) ON DELETE CASCADE,
  competencia_id UUID NOT NULL REFERENCES competencia(id),
  horas_lectivas INTEGER NOT NULL CHECK (horas_lectivas > 0),
  activo BOOLEAN NOT NULL DEFAULT TRUE,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW(),
  UNIQUE (programa_id, competencia_id)
);

-- =========================================================
-- 5. INSTRUCTORES
-- =========================================================

CREATE TABLE instructor (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  usuario_id UUID UNIQUE REFERENCES usuario(id) ON DELETE SET NULL,
  documento VARCHAR(30) UNIQUE NOT NULL,
  nombre VARCHAR(100) NOT NULL,
  apellido VARCHAR(100) NOT NULL,
  correo VARCHAR(180) UNIQUE NOT NULL,
  telefono VARCHAR(40),
  tipo_contrato_id UUID NOT NULL REFERENCES tipo_contrato(id),
  sede_id UUID NOT NULL REFERENCES sede(id),
  activo BOOLEAN NOT NULL DEFAULT TRUE,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE instructor_competencia (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  instructor_id UUID NOT NULL REFERENCES instructor(id) ON DELETE CASCADE,
  competencia_id UUID NOT NULL REFERENCES competencia(id),
  programa_id UUID NOT NULL REFERENCES programa_formacion(id),
  fecha_inicio DATE NOT NULL,
  fecha_fin DATE,
  activo BOOLEAN NOT NULL DEFAULT TRUE,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW(),
  UNIQUE (instructor_id, competencia_id, programa_id),
  CHECK (fecha_fin IS NULL OR fecha_fin >= fecha_inicio)
);

CREATE TABLE disponibilidad_instructor (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  instructor_id UUID NOT NULL REFERENCES instructor(id) ON DELETE CASCADE,
  dia_semana SMALLINT NOT NULL CHECK (dia_semana BETWEEN 1 AND 7),
  franja_horaria_id UUID NOT NULL,
  disponible BOOLEAN NOT NULL DEFAULT TRUE,
  fecha_desde DATE,
  fecha_hasta DATE,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW(),
  CHECK (fecha_hasta IS NULL OR fecha_desde IS NULL OR fecha_hasta >= fecha_desde)
);

CREATE TABLE novedad_instructor (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  instructor_id UUID NOT NULL REFERENCES instructor(id) ON DELETE CASCADE,
  tipo VARCHAR(40) NOT NULL CHECK (tipo IN ('permiso', 'incapacidad', 'vacaciones', 'bloqueo', 'otro')),
  descripcion TEXT,
  fecha_desde DATE NOT NULL,
  fecha_hasta DATE NOT NULL,
  created_by UUID REFERENCES usuario(id) ON DELETE SET NULL,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW(),
  CHECK (fecha_hasta >= fecha_desde)
);

-- =========================================================
-- 6. AMBIENTES
-- =========================================================

CREATE TABLE ambiente (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  codigo VARCHAR(80) UNIQUE NOT NULL,
  nombre VARCHAR(150) NOT NULL,
  capacidad INTEGER NOT NULL CHECK (capacidad > 0),
  ubicacion VARCHAR(180),
  sede_id UUID NOT NULL REFERENCES sede(id),
  tipo_ambiente_id UUID NOT NULL REFERENCES tipo_ambiente(id),
  activo BOOLEAN NOT NULL DEFAULT TRUE,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE recurso_ambiente (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  ambiente_id UUID NOT NULL REFERENCES ambiente(id) ON DELETE CASCADE,
  nombre VARCHAR(120) NOT NULL,
  cantidad INTEGER NOT NULL DEFAULT 1 CHECK (cantidad > 0),
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

-- =========================================================
-- 7. FICHAS, FRANJAS Y DISPONIBILIDAD
-- =========================================================

CREATE TABLE franja_horaria (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nombre VARCHAR(100) NOT NULL,
  hora_inicio TIME NOT NULL,
  hora_fin TIME NOT NULL,
  jornada_id UUID NOT NULL REFERENCES jornada(id),
  activo BOOLEAN NOT NULL DEFAULT TRUE,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW(),
  UNIQUE (jornada_id, hora_inicio, hora_fin),
  CHECK (hora_fin > hora_inicio)
);

ALTER TABLE disponibilidad_instructor
  ADD CONSTRAINT fk_disponibilidad_instructor_franja
  FOREIGN KEY (franja_horaria_id) REFERENCES franja_horaria(id);

CREATE TABLE disponibilidad_ambiente (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  ambiente_id UUID NOT NULL REFERENCES ambiente(id) ON DELETE CASCADE,
  dia_semana SMALLINT NOT NULL CHECK (dia_semana BETWEEN 1 AND 7),
  franja_horaria_id UUID NOT NULL REFERENCES franja_horaria(id),
  disponible BOOLEAN NOT NULL DEFAULT TRUE,
  motivo_bloqueo VARCHAR(180),
  fecha_desde DATE,
  fecha_hasta DATE,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW(),
  CHECK (fecha_hasta IS NULL OR fecha_desde IS NULL OR fecha_hasta >= fecha_desde)
);

CREATE TABLE ficha (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  codigo VARCHAR(80) UNIQUE NOT NULL,
  oferta_id UUID NOT NULL REFERENCES oferta_formacion(id),
  sede_id UUID NOT NULL REFERENCES sede(id),
  jornada_id UUID NOT NULL REFERENCES jornada(id),
  fecha_inicio DATE NOT NULL,
  fecha_fin DATE NOT NULL,
  fecha_fin_extendida DATE,
  numero_aprendices INTEGER NOT NULL CHECK (numero_aprendices > 0),
  activo BOOLEAN NOT NULL DEFAULT TRUE,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW(),
  CHECK (fecha_fin >= fecha_inicio),
  CHECK (fecha_fin_extendida IS NULL OR fecha_fin_extendida >= fecha_fin)
);

CREATE TABLE extension_ficha (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  ficha_id UUID NOT NULL REFERENCES ficha(id) ON DELETE CASCADE,
  fecha_fin_anterior DATE NOT NULL,
  fecha_fin_nueva DATE NOT NULL,
  motivo TEXT NOT NULL,
  usuario_id UUID REFERENCES usuario(id) ON DELETE SET NULL,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  CHECK (fecha_fin_nueva >= fecha_fin_anterior)
);

-- =========================================================
-- 8. APRENDICES
-- =========================================================

CREATE TABLE aprendiz (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  usuario_id UUID UNIQUE REFERENCES usuario(id) ON DELETE SET NULL,
  documento VARCHAR(30) UNIQUE NOT NULL,
  nombre VARCHAR(100) NOT NULL,
  apellido VARCHAR(100) NOT NULL,
  correo VARCHAR(180) UNIQUE NOT NULL,
  telefono VARCHAR(40),
  sede_id UUID NOT NULL REFERENCES sede(id),
  activo BOOLEAN NOT NULL DEFAULT TRUE,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE aprendiz_ficha (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  aprendiz_id UUID NOT NULL REFERENCES aprendiz(id) ON DELETE CASCADE,
  ficha_id UUID NOT NULL REFERENCES ficha(id) ON DELETE CASCADE,
  fecha_matricula DATE NOT NULL,
  estado VARCHAR(30) NOT NULL DEFAULT 'activo'
    CHECK (estado IN ('activo', 'trasladado', 'retirado', 'finalizado')),
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW(),
  UNIQUE (aprendiz_id, ficha_id)
);

-- =========================================================
-- 9. MOTOR DE HORARIOS
-- =========================================================

CREATE TABLE horario (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  ficha_id UUID NOT NULL REFERENCES ficha(id),
  instructor_id UUID NOT NULL REFERENCES instructor(id),
  ambiente_id UUID NOT NULL REFERENCES ambiente(id),
  competencia_id UUID NOT NULL REFERENCES competencia(id),
  franja_horaria_id UUID NOT NULL REFERENCES franja_horaria(id),
  fecha DATE NOT NULL,
  estado VARCHAR(30) NOT NULL DEFAULT 'programado'
    CHECK (estado IN ('programado', 'reprogramado', 'cancelado', 'ejecutado')),
  created_by UUID REFERENCES usuario(id) ON DELETE SET NULL,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE UNIQUE INDEX uq_horario_instructor_activo
  ON horario (instructor_id, franja_horaria_id, fecha)
  WHERE estado <> 'cancelado';

CREATE UNIQUE INDEX uq_horario_ambiente_activo
  ON horario (ambiente_id, franja_horaria_id, fecha)
  WHERE estado <> 'cancelado';

CREATE UNIQUE INDEX uq_horario_ficha_activa
  ON horario (ficha_id, franja_horaria_id, fecha)
  WHERE estado <> 'cancelado';

CREATE TABLE validacion_horario (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  horario_id UUID REFERENCES horario(id) ON DELETE SET NULL,
  ficha_id UUID REFERENCES ficha(id),
  instructor_id UUID REFERENCES instructor(id),
  ambiente_id UUID REFERENCES ambiente(id),
  competencia_id UUID REFERENCES competencia(id),
  franja_horaria_id UUID REFERENCES franja_horaria(id),
  fecha DATE,
  resultado VARCHAR(30) NOT NULL CHECK (resultado IN ('aprobado', 'rechazado', 'advertencia')),
  codigo_regla VARCHAR(80) NOT NULL,
  mensaje TEXT NOT NULL,
  created_by UUID REFERENCES usuario(id) ON DELETE SET NULL,
  created_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE cambio_horario (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  horario_id UUID NOT NULL REFERENCES horario(id) ON DELETE CASCADE,
  datos_anteriores JSONB NOT NULL,
  datos_nuevos JSONB NOT NULL,
  motivo TEXT NOT NULL,
  estado VARCHAR(30) NOT NULL DEFAULT 'aprobado'
    CHECK (estado IN ('pendiente', 'aprobado', 'rechazado')),
  solicitado_por UUID REFERENCES usuario(id) ON DELETE SET NULL,
  aprobado_por UUID REFERENCES usuario(id) ON DELETE SET NULL,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE revision_coordinacion (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  cambio_horario_id UUID REFERENCES cambio_horario(id) ON DELETE CASCADE,
  observacion TEXT,
  decision VARCHAR(30) NOT NULL CHECK (decision IN ('aprobado', 'rechazado', 'devuelto')),
  usuario_id UUID REFERENCES usuario(id) ON DELETE SET NULL,
  created_at TIMESTAMP NOT NULL DEFAULT NOW()
);

-- =========================================================
-- 10. OBSERVACIONES, NOTIFICACIONES Y PROYECTOS
-- =========================================================

CREATE TABLE observacion (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  tipo VARCHAR(40) NOT NULL CHECK (tipo IN ('cruce', 'queja', 'solicitud', 'incidencia', 'bloqueo', 'otro')),
  severidad VARCHAR(20) NOT NULL DEFAULT 'info' CHECK (severidad IN ('info', 'warning', 'critical')),
  descripcion TEXT NOT NULL,
  estado VARCHAR(30) NOT NULL DEFAULT 'abierta' CHECK (estado IN ('abierta', 'en_revision', 'resuelta', 'cerrada')),
  ficha_id UUID REFERENCES ficha(id) ON DELETE SET NULL,
  instructor_id UUID REFERENCES instructor(id) ON DELETE SET NULL,
  ambiente_id UUID REFERENCES ambiente(id) ON DELETE SET NULL,
  horario_id UUID REFERENCES horario(id) ON DELETE SET NULL,
  reportado_por UUID REFERENCES usuario(id) ON DELETE SET NULL,
  resuelto_por UUID REFERENCES usuario(id) ON DELETE SET NULL,
  fecha_resolucion TIMESTAMP,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE observacion_estado (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  observacion_id UUID NOT NULL REFERENCES observacion(id) ON DELETE CASCADE,
  estado_anterior VARCHAR(30),
  estado_nuevo VARCHAR(30) NOT NULL,
  comentario TEXT,
  usuario_id UUID REFERENCES usuario(id) ON DELETE SET NULL,
  created_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE notificacion (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  usuario_id UUID NOT NULL REFERENCES usuario(id) ON DELETE CASCADE,
  titulo VARCHAR(180) NOT NULL,
  mensaje TEXT NOT NULL,
  tipo VARCHAR(60) NOT NULL,
  leida BOOLEAN NOT NULL DEFAULT FALSE,
  referencia_id UUID,
  referencia_tabla VARCHAR(120),
  created_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE proyecto_formativo (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nombre VARCHAR(220) NOT NULL,
  descripcion TEXT,
  fecha_inicio DATE,
  fecha_fin DATE,
  estado VARCHAR(30) NOT NULL DEFAULT 'activo'
    CHECK (estado IN ('planeado', 'activo', 'cerrado', 'cancelado')),
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW(),
  CHECK (fecha_fin IS NULL OR fecha_inicio IS NULL OR fecha_fin >= fecha_inicio)
);

CREATE TABLE proyecto_ficha (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  proyecto_id UUID NOT NULL REFERENCES proyecto_formativo(id) ON DELETE CASCADE,
  ficha_id UUID NOT NULL REFERENCES ficha(id) ON DELETE CASCADE,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  UNIQUE (proyecto_id, ficha_id)
);

-- =========================================================
-- 11. INDICES RECOMENDADOS
-- =========================================================

CREATE INDEX idx_usuario_rol ON usuario(rol_id);
CREATE INDEX idx_usuario_sede ON usuario(sede_id);
CREATE INDEX idx_instructor_sede ON instructor(sede_id);
CREATE INDEX idx_instructor_contrato ON instructor(tipo_contrato_id);
CREATE INDEX idx_ambiente_sede ON ambiente(sede_id);
CREATE INDEX idx_ficha_sede ON ficha(sede_id);
CREATE INDEX idx_ficha_oferta ON ficha(oferta_id);
CREATE INDEX idx_horario_fecha_franja ON horario(fecha, franja_horaria_id);
CREATE INDEX idx_horario_ficha_fecha ON horario(ficha_id, fecha);
CREATE INDEX idx_horario_instructor_fecha ON horario(instructor_id, fecha);
CREATE INDEX idx_horario_ambiente_fecha ON horario(ambiente_id, fecha);
CREATE INDEX idx_observacion_estado ON observacion(estado);
CREATE INDEX idx_observacion_tipo ON observacion(tipo);
CREATE INDEX idx_notificacion_usuario_leida ON notificacion(usuario_id, leida);
CREATE INDEX idx_auditoria_tabla_registro ON auditoria(tabla_afectada, registro_id);

-- =========================================================
-- 12. TRIGGERS updated_at
-- =========================================================

DO $$
DECLARE
  r RECORD;
BEGIN
  FOR r IN
    SELECT table_schema, table_name
    FROM information_schema.columns
    WHERE table_schema = 'horarios'
      AND column_name = 'updated_at'
  LOOP
    EXECUTE format('DROP TRIGGER IF EXISTS trg_set_updated_at ON %I.%I', r.table_schema, r.table_name);
    EXECUTE format(
      'CREATE TRIGGER trg_set_updated_at BEFORE UPDATE ON %I.%I FOR EACH ROW EXECUTE FUNCTION horarios.set_updated_at()',
      r.table_schema,
      r.table_name
    );
  END LOOP;
END $$;

-- =========================================================
-- 13. DATOS BASE MINIMOS
-- =========================================================

INSERT INTO modalidad (nombre, descripcion)
VALUES
  ('Presencial', 'Formacion desarrollada en sede fisica.'),
  ('Virtual', 'Formacion desarrollada en entornos virtuales.'),
  ('Distancia', 'Formacion con acompanamiento remoto y actividades autonomas.'),
  ('Mixta', 'Formacion combinada entre presencial y virtual.')
ON CONFLICT (nombre) DO NOTHING;

INSERT INTO rol (nombre, descripcion)
VALUES
  ('Administrador', 'Gestiona usuarios, permisos y parametros del sistema.'),
  ('Coordinador Academico', 'Programa horarios, revisa incidencias y aprueba cambios.'),
  ('Instructor', 'Consulta horarios y reporta novedades.'),
  ('Aprendiz', 'Consulta horarios y notificaciones.'),
  ('Auditor', 'Consulta trazabilidad e indicadores.')
ON CONFLICT (nombre) DO NOTHING;

-- =========================================================
-- FIN DEL SCRIPT
-- =========================================================
