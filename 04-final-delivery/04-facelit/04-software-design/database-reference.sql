-- FACELIT-DB | PostgreSQL | DDL basado en migraciones del repositorio
-- Ejecutar en una base PostgreSQL creada previamente.

-- ORIGEN: 01_ddl/00_extensions/001_enable_uuid_extension.sql
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS vector;

-- ORIGEN: 01_ddl/01_schemas/001_create_schemas.sql
CREATE SCHEMA IF NOT EXISTS security;
CREATE SCHEMA IF NOT EXISTS roleandpermission;
CREATE SCHEMA IF NOT EXISTS academic;
CREATE SCHEMA IF NOT EXISTS environment;
CREATE SCHEMA IF NOT EXISTS notification;
CREATE SCHEMA IF NOT EXISTS legal;
CREATE SCHEMA IF NOT EXISTS facialrecognition;

-- ORIGEN: 01_ddl/03_tables/001_create_security_tables.sql
CREATE TABLE security.user_app(
    id_user_app UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    first_name VARCHAR(60) NOT NULL,
    last_name VARCHAR(60) NOT NULL,
    account_status VARCHAR(20) NOT NULL,
    number_document VARCHAR(15) NOT NULL UNIQUE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by VARCHAR(100),
    updated_at TIMESTAMPTZ,
    updated_by VARCHAR(100),
    deleted_by VARCHAR(100),
    deleted_at TIMESTAMPTZ
);

CREATE TABLE security.credential(
    id_credential UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_user_app UUID NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    credential_status VARCHAR(20) NOT NULL DEFAULT 'ACTIVE',
    failed_attempts INTEGER NOT NULL DEFAULT 0,
    locked_until TIMESTAMPTZ,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by VARCHAR(100),
    updated_at TIMESTAMPTZ,
    updated_by VARCHAR(100),
    deleted_by VARCHAR(100),
    deleted_at TIMESTAMPTZ,
    CONSTRAINT chk_failed_attempts_non_negative CHECK (failed_attempts >= 0)
);

CREATE TABLE security.password_recovery (
    id_password_recovery UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_user_app UUID NOT NULL,
    token VARCHAR(255) NOT NULL,
    expiration_date TIMESTAMPTZ NOT NULL,
    used BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by VARCHAR(100),
    updated_at TIMESTAMPTZ,
    updated_by VARCHAR(100),
    deleted_by VARCHAR(100),
    deleted_at TIMESTAMPTZ
);

CREATE TABLE security.user_session (
    id_user_session UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_user_app UUID NOT NULL,
    start_date TIMESTAMPTZ NOT NULL,
    end_date TIMESTAMPTZ,
    session_status VARCHAR(20) NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by VARCHAR(100),
    updated_at TIMESTAMPTZ,
    updated_by VARCHAR(100),
    deleted_by VARCHAR(100),
    deleted_at TIMESTAMPTZ
);

CREATE TABLE security.user_configuration (
    id_user_configuration UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_user_app UUID NOT NULL UNIQUE,
    notifications_active BOOLEAN NOT NULL DEFAULT TRUE,
    dark_mode BOOLEAN NOT NULL DEFAULT FALSE,
    language VARCHAR(2) NOT NULL CHECK (language IN ('ES', 'EN', 'PR', 'FR')),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by VARCHAR(100),
    updated_at TIMESTAMPTZ,
    updated_by VARCHAR(100),
    deleted_by VARCHAR(100),
    deleted_at TIMESTAMPTZ
);

-- ORIGEN: 01_ddl/03_tables/002_create_roleandpermissions_tables.sql
CREATE TABLE roleandpermission.role (
    id_role UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name_rol VARCHAR(50) NOT NULL UNIQUE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by VARCHAR(100),
    updated_at TIMESTAMPTZ,
    updated_by VARCHAR(100),
    deleted_by VARCHAR(100),
    deleted_at TIMESTAMPTZ
);

CREATE TABLE roleandpermission.permission (
    id_permission UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name_permission VARCHAR(100) NOT NULL,
    descripcion TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by VARCHAR(100),
    updated_at TIMESTAMPTZ,
    updated_by VARCHAR(100),
    deleted_by VARCHAR(100),
    deleted_at TIMESTAMPTZ
);

CREATE TABLE roleandpermission.user_role (
    id_user_role UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_user_app UUID NOT NULL,
    id_role UUID NOT NULL,
    asigned_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by VARCHAR(100),
    updated_at TIMESTAMPTZ,
    updated_by VARCHAR(100),
    deleted_by VARCHAR(100),
    deleted_at TIMESTAMPTZ,
    CONSTRAINT uq_user_role UNIQUE (id_user_app, id_role)
);

CREATE TABLE roleandpermission.role_permission (
    id_role_permission UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_role UUID NOT NULL,
    id_permission UUID NOT NULL,
    assigned_at TIMESTAMPTZ DEFAULT NOW(),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by VARCHAR(100),
    updated_at TIMESTAMPTZ,
    updated_by VARCHAR(100),
    deleted_by VARCHAR(100),
    deleted_at TIMESTAMPTZ,
    CONSTRAINT uq_role_permission UNIQUE (id_role, id_permission)
);

-- ORIGEN: 01_ddl/03_tables/003_create_academic_tables.sql
CREATE TABLE academic.program (
    id_program UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    program_name VARCHAR(100) NOT NULL UNIQUE,
    program_code VARCHAR(15) NOT NULL UNIQUE,
    state VARCHAR(20) NOT NULL,
    deactivation_reason VARCHAR(200),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by VARCHAR(100),
    updated_at TIMESTAMPTZ,
    updated_by VARCHAR(100),
    deleted_by VARCHAR(100),
    deleted_at TIMESTAMPTZ
);

CREATE TABLE academic.instructor (
    id_instructor UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_user_app UUID NOT NULL UNIQUE,
    instructor_type VARCHAR(20) NOT NULL CHECK (instructor_type IN ('SPECIFIC', 'CROSS-CUTTING')),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by VARCHAR(100), updated_at TIMESTAMPTZ, updated_by VARCHAR(100), deleted_by VARCHAR(100), deleted_at TIMESTAMPTZ
);

CREATE TABLE academic.instructor_program (
    id_instructor_program UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_instructor UUID NOT NULL,
    id_program UUID NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by VARCHAR(100), updated_at TIMESTAMPTZ, updated_by VARCHAR(100), deleted_by VARCHAR(100), deleted_at TIMESTAMPTZ,
    CONSTRAINT uq_instructor_program UNIQUE (id_instructor, id_program)
);

CREATE TABLE academic.change_history (
    id_change_history UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    entity_name VARCHAR(50) NOT NULL,
    entity_id UUID NOT NULL,
    field_name VARCHAR(100) NOT NULL,
    old_value TEXT,
    new_value TEXT,
    action VARCHAR(20) NOT NULL CHECK (action IN ('CREATE', 'UPDATE', 'DEACTIVATE', 'REACTIVATE', 'DELETE', 'CSV_LOAD', 'CSV_CONFIRM', 'CSV_CANCEL')),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by VARCHAR(100)
);

CREATE TABLE academic.chip (
    id_chip UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_program UUID NOT NULL,
    chip_code VARCHAR(20) NOT NULL UNIQUE,
    start_date DATE,
    end_date DATE,
    state VARCHAR(20) NOT NULL,
    deactivation_reason VARCHAR(200),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by VARCHAR(100),
    updated_at TIMESTAMPTZ,
    updated_by VARCHAR(100),
    deleted_by VARCHAR(100),
    deleted_at TIMESTAMPTZ
);

CREATE TABLE academic.instructor_chip (
    id_instructor_chip UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_instructor UUID NOT NULL,
    id_chip UUID NOT NULL,
    assignment_start DATE,
    assignment_end DATE,
    active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by VARCHAR(100),
    updated_at TIMESTAMPTZ,
    updated_by VARCHAR(100),
    deleted_by VARCHAR(100),
    deleted_at TIMESTAMPTZ
);

CREATE TABLE academic.apprentice (
    id_apprentice UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_user_app UUID NOT NULL UNIQUE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by VARCHAR(100),
    updated_at TIMESTAMPTZ,
    updated_by VARCHAR(100),
    deleted_by VARCHAR(100),
    deleted_at TIMESTAMPTZ
);

CREATE TABLE academic.apprentice_chip (
    id_apprentice_chip UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_apprentice UUID NOT NULL,
    id_chip UUID NOT NULL,
    state VARCHAR(20) NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by VARCHAR(100),
    updated_at TIMESTAMPTZ,
    updated_by VARCHAR(100),
    deleted_by VARCHAR(100),
    deleted_at TIMESTAMPTZ
);

CREATE TABLE academic.csv_pending_transfer (
    id_pending_transfer UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_user_app UUID NOT NULL REFERENCES security.user_app(id_user_app),
    id_chip_current UUID NOT NULL REFERENCES academic.chip(id_chip),
    id_chip_proposed UUID NOT NULL REFERENCES academic.chip(id_chip),
    source_row_number INTEGER NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'PENDING',
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by VARCHAR(100),
    updated_at TIMESTAMPTZ,
    updated_by VARCHAR(100),
    deleted_by VARCHAR(100),
    deleted_at TIMESTAMPTZ,
    resolved_at TIMESTAMPTZ,
    resolved_by VARCHAR(100),
    CONSTRAINT chk_csv_pending_transfer_status CHECK (status IN ('PENDING', 'ACCEPTED', 'CANCELLED'))
);

CREATE UNIQUE INDEX uq_pending_transfer_active
ON academic.csv_pending_transfer (id_user_app)
WHERE status = 'PENDING';

-- ORIGEN: 01_ddl/03_tables/004_create_environment_tables.sql
CREATE TABLE environment.environment (
    id_environment UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    environment_name VARCHAR(100) NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by VARCHAR(100),
    updated_at TIMESTAMPTZ,
    updated_by VARCHAR(100),
    deleted_by VARCHAR(100),
    deleted_at TIMESTAMPTZ
);

CREATE TABLE environment.chip_environment (
    id_chip_environment UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_chip UUID NOT NULL,
    id_environment UUID NOT NULL,
    assignment_date TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    state VARCHAR(20) NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by VARCHAR(100),
    updated_at TIMESTAMPTZ,
    updated_by VARCHAR(100),
    deleted_by VARCHAR(100),
    deleted_at TIMESTAMPTZ
);

CREATE TABLE environment.record_environment (
    id_record_environment UUID NOT NULL PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_environment UUID NOT NULL,
    id_device UUID NOT NULL,
    id_chip UUID NOT NULL,
    id_instructor_scheduled UUID NOT NULL,
    id_instructor_in_charge UUID NULL,
    entry_time TIMESTAMPTZ NOT NULL,
    registration_minutes INTEGER NOT NULL CHECK (registration_minutes > 0),
    exit_time TIMESTAMPTZ NOT NULL,
    shutdown_time TIMESTAMPTZ NOT NULL,
    exit_reminder_sent BOOLEAN NOT NULL DEFAULT FALSE,
    active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by VARCHAR(100),
    updated_at TIMESTAMPTZ,
    updated_by VARCHAR(100),
    deleted_by VARCHAR(100),
    deleted_at TIMESTAMPTZ,
    CONSTRAINT chk_record_environment_times CHECK (
        exit_time > entry_time
        AND shutdown_time > exit_time
    )
);

-- ORIGEN: 01_ddl/03_tables/005_create_notification_tables.sql
CREATE TABLE notification.notification (
    id_notification UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_user_app UUID NOT NULL,
    id_facial_event UUID NULL,
    notification_type VARCHAR(60) NOT NULL DEFAULT 'academic_delete_blocked',
    category VARCHAR(30) NOT NULL CHECK (category IN ('SEGURIDAD', 'ACADEMICO', 'ASISTENCIA', 'RECONOCIMIENTO_FACIAL', 'TRASLADO')),
    title VARCHAR(120) NOT NULL DEFAULT 'Notificacion',
    message TEXT NOT NULL,
    channel VARCHAR(15) NOT NULL CHECK (channel IN ('APP', 'APP_EMAIL')),
    read_status BOOLEAN NOT NULL DEFAULT FALSE,
    read_at TIMESTAMPTZ,
    reference_entity VARCHAR(50), reference_id UUID,
    metadata_json TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE notification.email_log (
    id_email_log UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_notification UUID NOT NULL,
    send_status VARCHAR(20) NOT NULL CHECK (send_status IN ('PENDING', 'SENT', 'FAILED')),
    attempts INTEGER NOT NULL DEFAULT 0,
    sent_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    CONSTRAINT uq_email_log_notification UNIQUE (id_notification)
);

-- ORIGEN: 01_ddl/03_tables/006_create_legal_tables.sql
CREATE TABLE legal.terms_acceptance (
    id_acceptance UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_user_app UUID NOT NULL,
    accepted BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by VARCHAR(100),
    updated_at TIMESTAMPTZ,
    updated_by VARCHAR(100),
    deleted_by VARCHAR(100),
    deleted_at TIMESTAMPTZ
);

-- ORIGEN: 01_ddl/03_tables/007_create_facialrecognition_tables.sql
CREATE TABLE facialrecognition.device (
    id_device UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_environment UUID NOT NULL,
    device_code VARCHAR(50) NOT NULL UNIQUE,
    location VARCHAR(100),
    status VARCHAR(20) NOT NULL CHECK (status IN ('ACTIVE', 'PENDING', 'INACTIVE')),
    origin_ip VARCHAR(50),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by VARCHAR(100),
    updated_at TIMESTAMPTZ,
    updated_by VARCHAR(100),
    deleted_by VARCHAR(100),
    deleted_at TIMESTAMPTZ
);

CREATE TABLE facialrecognition.user_face (
    id_user_face UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_apprentice UUID NOT NULL UNIQUE,
    embedding vector NOT NULL,
    embedding_dimension INT4,
    model_name VARCHAR(100),
    photo_reference VARCHAR(500),
    status VARCHAR(20) NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by VARCHAR(1000),
    updated_at TIMESTAMPTZ,
    updated_by VARCHAR(100),
    deleted_by VARCHAR(100),
    deleted_at TIMESTAMPTZ
);

CREATE TABLE facialrecognition.facial_event (
    id_facial_event UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_record_environment UUID NOT NULL, 
    id_device UUID NOT NULL,
    id_apprentice UUID NOT NULL,
    event_datetime TIMESTAMPTZ NOT NULL,
    event_type VARCHAR(20) NOT NULL CHECK (event_type IN ('ENTRY', 'EXIT')),
    recognition_result VARCHAR(20) NOT NULL,
    attendance_status VARCHAR(20) NOT NULL CHECK (attendance_status IN ('PUNCTUAL', 'LATE', 'ABSENT')),
    match_score NUMERIC(5,4) CHECK (match_score >= 0 AND match_score <= 1),
    origin VARCHAR(10) NOT NULL CHECK (origin IN ('PC', 'MOBILE')),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by VARCHAR(100),
    updated_at TIMESTAMPTZ,
    updated_by VARCHAR(100),
    deleted_by VARCHAR(100),
    deleted_at TIMESTAMPTZ
);

CREATE TABLE facialrecognition.biometric_log (
    id_biometric_log UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_facial_event UUID NOT NULL,
    description TEXT,
    log_date TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by VARCHAR(100),
    updated_at TIMESTAMPTZ,
    updated_by VARCHAR(100),
    deleted_by VARCHAR(100),
    deleted_at TIMESTAMPTZ
);

CREATE TABLE facialrecognition.face_reset_request (
    id_face_reset_request UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_user_app UUID NOT NULL,
    request_status VARCHAR(20) NOT NULL CHECK (request_status IN ('PENDING', 'ACCEPTED', 'REJECTED')),
    requested_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    resolved_by UUID,
    resolved_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by VARCHAR(100),
    updated_at TIMESTAMPTZ,
    updated_by VARCHAR(100),
    deleted_by VARCHAR(100),
    deleted_at TIMESTAMPTZ
);

-- ORIGEN: 01_ddl/04_alter/001_create_foreignkeys_security.sql
ALTER TABLE security.credential ADD CONSTRAINT fk_credential_user FOREIGN KEY (id_user_app) REFERENCES security.user_app(id_user_app);
ALTER TABLE security.password_recovery ADD CONSTRAINT fk_password_recovery_user FOREIGN KEY (id_user_app) REFERENCES security.user_app(id_user_app);
ALTER TABLE security.user_session ADD CONSTRAINT fk_user_session_user FOREIGN KEY (id_user_app) REFERENCES security.user_app(id_user_app);
ALTER TABLE security.user_configuration ADD CONSTRAINT fk_user_configuration_user FOREIGN KEY (id_user_app) REFERENCES security.user_app(id_user_app);

-- ORIGEN: 01_ddl/04_alter/002_create_foreignkeys_roleandpermissions_tables.sql
ALTER TABLE roleandpermission.user_role ADD CONSTRAINT fk_user_role_user FOREIGN KEY (id_user_app) REFERENCES security.user_app(id_user_app);
ALTER TABLE roleandpermission.user_role ADD CONSTRAINT fk_user_role_role FOREIGN KEY (id_role) REFERENCES roleandpermission.role(id_role);
ALTER TABLE roleandpermission.role_permission ADD CONSTRAINT fk_role_permission_role FOREIGN KEY (id_role) REFERENCES roleandpermission.role(id_role);
ALTER TABLE roleandpermission.role_permission ADD CONSTRAINT fk_role_permission_permission FOREIGN KEY (id_permission) REFERENCES roleandpermission.permission(id_permission);
ALTER TABLE roleandpermission.permission ADD CONSTRAINT uq_permission_name UNIQUE (name_permission);

-- ORIGEN: 01_ddl/04_alter/003_create_foreignkeys_academic_tables.sql
ALTER TABLE academic.instructor ADD CONSTRAINT fk_instructor_user FOREIGN KEY (id_user_app) REFERENCES security.user_app(id_user_app);
ALTER TABLE academic.instructor_program ADD CONSTRAINT fk_instructor_program_instructor FOREIGN KEY (id_instructor) REFERENCES academic.instructor(id_instructor);
ALTER TABLE academic.instructor_program ADD CONSTRAINT fk_instructor_program_program FOREIGN KEY (id_program) REFERENCES academic.program(id_program);
ALTER TABLE academic.chip ADD CONSTRAINT fk_chip_program FOREIGN KEY (id_program) REFERENCES academic.program(id_program);
ALTER TABLE academic.instructor_chip ADD CONSTRAINT fk_instructor_chip_instructor FOREIGN KEY (id_instructor) REFERENCES academic.instructor(id_instructor);
ALTER TABLE academic.instructor_chip ADD CONSTRAINT fk_instructor_chip_chip FOREIGN KEY (id_chip) REFERENCES academic.chip(id_chip);
ALTER TABLE academic.apprentice ADD CONSTRAINT fk_apprentice_user FOREIGN KEY (id_user_app) REFERENCES security.user_app(id_user_app);
ALTER TABLE academic.apprentice_chip ADD CONSTRAINT fk_apprentice_chip_apprentice FOREIGN KEY (id_apprentice) REFERENCES academic.apprentice(id_apprentice);
ALTER TABLE academic.apprentice_chip ADD CONSTRAINT fk_apprentice_chip_chip FOREIGN KEY (id_chip) REFERENCES academic.chip(id_chip);

-- ORIGEN: 01_ddl/04_alter/004_create_foreignkeys_environment_tables.sql
ALTER TABLE environment.chip_environment ADD CONSTRAINT fk_chip_environment_chip FOREIGN KEY (id_chip) REFERENCES academic.chip(id_chip);
ALTER TABLE environment.chip_environment ADD CONSTRAINT fk_chip_environment_environment FOREIGN KEY (id_environment) REFERENCES environment.environment(id_environment);
ALTER TABLE environment.record_environment ADD CONSTRAINT fk_record_environment_environment FOREIGN KEY (id_environment) REFERENCES environment.environment(id_environment);
ALTER TABLE environment.record_environment ADD CONSTRAINT fk_record_environment_chip FOREIGN KEY (id_chip) REFERENCES academic.chip(id_chip);
ALTER TABLE environment.record_environment ADD CONSTRAINT fk_record_environment_instructor FOREIGN KEY (id_instructor_in_charge) REFERENCES academic.instructor(id_instructor);

-- ORIGEN: 01_ddl/04_alter/005_create_foreignkeys_notification_tables.sql
ALTER TABLE notification.notification ADD CONSTRAINT fk_notification_user FOREIGN KEY (id_user_app) REFERENCES security.user_app(id_user_app);
ALTER TABLE notification.notification ADD CONSTRAINT fk_notification_event FOREIGN KEY (id_facial_event) REFERENCES facialrecognition.facial_event(id_facial_event);
ALTER TABLE notification.email_log ADD CONSTRAINT fk_email_log_notification FOREIGN KEY (id_notification) REFERENCES notification.notification(id_notification);

-- ORIGEN: 01_ddl/04_alter/006_create_foreignkeys_legal_tables.sql
ALTER TABLE legal.terms_acceptance ADD CONSTRAINT fk_terms_acceptance_user FOREIGN KEY (id_user_app) REFERENCES security.user_app(id_user_app);

-- ORIGEN: 01_ddl/04_alter/007_program_audit_dates.sql
UPDATE academic.program
SET updated_at = created_at
WHERE updated_at IS NULL;

ALTER TABLE academic.program
    ALTER COLUMN updated_at SET DEFAULT NOW();

-- ORIGEN: 01_ddl/04_alter/008_chip_audit_dates.sql
UPDATE academic.chip
SET updated_at = created_at
WHERE updated_at IS NULL;

ALTER TABLE academic.chip
    ALTER COLUMN updated_at SET DEFAULT NOW();

-- ORIGEN: 01_ddl/04_alter/009_user_document_length.sql
ALTER TABLE security.user_app
    ALTER COLUMN number_document TYPE VARCHAR(15);

-- ORIGEN: 01_ddl/04_alter/010_environment_state_capacity_unique.sql
ALTER TABLE environment.environment
    ADD COLUMN IF NOT EXISTS capacity INTEGER,
    ADD COLUMN IF NOT EXISTS state VARCHAR(20) NOT NULL DEFAULT 'ACTIVE';

ALTER TABLE environment.environment
    ADD CONSTRAINT chk_environment_state CHECK (state IN ('ACTIVE', 'INACTIVE'));

ALTER TABLE environment.environment
    ADD CONSTRAINT chk_environment_capacity CHECK (capacity IS NULL OR capacity > 0);

CREATE UNIQUE INDEX IF NOT EXISTS uq_environment_name_normalized
ON environment.environment (lower(btrim(environment_name)));

-- ORIGEN: 01_ddl/04_alter/011_notification_catalog_fields.sql
ALTER TABLE notification.notification
    ADD COLUMN IF NOT EXISTS notification_type VARCHAR(60) NOT NULL DEFAULT 'academic_delete_blocked';

ALTER TABLE notification.notification
    ADD COLUMN IF NOT EXISTS title VARCHAR(120) NOT NULL DEFAULT 'Notificacion';

ALTER TABLE notification.notification
    ADD COLUMN IF NOT EXISTS metadata_json TEXT;

-- ORIGEN: 01_ddl/04_alter/012_create_foreignkeys_facialrecognition.sql
ALTER TABLE facialrecognition.device ADD CONSTRAINT fk_device_environment FOREIGN KEY (id_environment) REFERENCES environment.environment(id_environment);
ALTER TABLE environment.record_environment ADD CONSTRAINT fk_record_environment_device FOREIGN KEY (id_device) REFERENCES facialrecognition.device(id_device);
ALTER TABLE facialrecognition.user_face ADD CONSTRAINT fk_user_face_user FOREIGN KEY (id_apprentice) REFERENCES academic.apprentice(id_apprentice);
ALTER TABLE facialrecognition.facial_event ADD CONSTRAINT fk_facial_event_record_environment FOREIGN KEY (id_record_environment) REFERENCES environment.record_environment(id_record_environment);
ALTER TABLE facialrecognition.facial_event ADD CONSTRAINT fk_facial_event_device FOREIGN KEY (id_device) REFERENCES facialrecognition.device(id_device);
ALTER TABLE facialrecognition.facial_event ADD CONSTRAINT fk_facial_event_apprendice FOREIGN KEY (id_apprentice) REFERENCES academic.apprentice(id_apprentice);
ALTER TABLE facialrecognition.face_reset_request ADD CONSTRAINT fk_face_reset_request_user FOREIGN KEY (id_user_app) REFERENCES security.user_app(id_user_app);
ALTER TABLE facialrecognition.face_reset_request ADD CONSTRAINT fk_face_reset_request_resolver FOREIGN KEY (resolved_by) REFERENCES security.user_app(id_user_app);
ALTER TABLE facialrecognition.biometric_log ADD CONSTRAINT fk_biometric_log_event FOREIGN KEY (id_facial_event) REFERENCES facialrecognition.facial_event(id_facial_event);

-- ORIGEN: 01_ddl/04_alter/013_user_face_embedding_array.sql
ALTER TABLE facialrecognition.user_face
  ALTER COLUMN embedding TYPE vector
  USING CASE
    WHEN embedding IS NULL THEN NULL
    WHEN pg_typeof(embedding)::text = 'vector' THEN embedding::vector
    ELSE embedding::vector
  END;

-- ORIGEN: 01_ddl/04_alter/014_record_environment_business_times.sql
ALTER TABLE environment.record_environment
DROP CONSTRAINT IF EXISTS chk_record_environment_times;

ALTER TABLE environment.record_environment
ADD COLUMN IF NOT EXISTS entry_time TIMESTAMPTZ;

UPDATE environment.record_environment
SET entry_time = created_at
WHERE entry_time IS NULL;

ALTER TABLE environment.record_environment
ALTER COLUMN entry_time SET NOT NULL;

ALTER TABLE environment.record_environment
ALTER COLUMN registration_minutes SET NOT NULL;

ALTER TABLE environment.record_environment
DROP CONSTRAINT IF EXISTS chk_record_environment_registration_minutes;

ALTER TABLE environment.record_environment
ADD CONSTRAINT chk_record_environment_registration_minutes
CHECK (registration_minutes > 0);

DO $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM information_schema.columns
        WHERE table_schema = 'environment'
          AND table_name = 'record_environment'
          AND column_name = 'exit_time'
          AND data_type = 'time without time zone'
    ) THEN
        ALTER TABLE environment.record_environment
        ALTER COLUMN exit_time TYPE TIMESTAMPTZ
        USING CASE
            WHEN exit_time IS NULL THEN NULL
            ELSE (created_at::date + exit_time)::timestamptz
        END;
    END IF;
END $$;

DO $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM information_schema.columns
        WHERE table_schema = 'environment'
          AND table_name = 'record_environment'
          AND column_name = 'shutdown_time'
          AND data_type = 'time without time zone'
    ) THEN
        ALTER TABLE environment.record_environment
        ALTER COLUMN shutdown_time TYPE TIMESTAMPTZ
        USING CASE
            WHEN shutdown_time IS NULL THEN NULL
            ELSE (created_at::date + shutdown_time)::timestamptz
        END;
    END IF;
END $$;

ALTER TABLE environment.record_environment
ALTER COLUMN exit_time SET NOT NULL;

ALTER TABLE environment.record_environment
ALTER COLUMN shutdown_time SET NOT NULL;

ALTER TABLE environment.record_environment
ADD CONSTRAINT chk_record_environment_times CHECK (
    exit_time > entry_time
    AND shutdown_time > exit_time
);

DROP INDEX IF EXISTS environment.idx_record_environment_session;

CREATE INDEX IF NOT EXISTS idx_record_environment_session
ON environment.record_environment (id_chip, entry_time);

-- ORIGEN: 01_ddl/10_indexes/002_create_roleandpermissions_indexes.sql
CREATE INDEX idx_user_role_user ON roleandpermission.user_role (id_user_app);
CREATE INDEX idx_role_permission_role ON roleandpermission.role_permission (id_role);

-- ORIGEN: 01_ddl/10_indexes/003_create_academic_indexes.sql
CREATE INDEX idx_instructor_program_instructor ON academic.instructor_program (id_instructor);
CREATE INDEX idx_instructor_program_program ON academic.instructor_program (id_program);

-- ORIGEN: 01_ddl/10_indexes/004_create_environment_indexes.sql
CREATE INDEX IF NOT EXISTS idx_record_environment_session ON environment.record_environment (id_chip, entry_time);

-- ORIGEN: 01_ddl/10_indexes/005_create_notification_indexes.sql
CREATE INDEX idx_notification_user_unread ON notification.notification (id_user_app) WHERE read_status = FALSE;

-- ORIGEN: 01_ddl/10_indexes/006_create_legal_indexes.sql
CREATE INDEX idx_terms_acceptance_user ON legal.terms_acceptance (id_user_app);

-- ORIGEN: 01_ddl/10_indexes/007_create_facialrecognition_indexes.sql
CREATE UNIQUE INDEX uq_user_face_active ON facialrecognition.user_face (id_apprentice) WHERE status = 'ACTIVE';
CREATE UNIQUE INDEX uq_face_reset_request_pending ON facialrecognition.face_reset_request (id_user_app) WHERE request_status = 'PENDING';
CREATE INDEX idx_facial_event_session ON facialrecognition.facial_event (id_record_environment, event_datetime);
CREATE INDEX idx_facial_event_user ON facialrecognition.facial_event (id_apprentice);

-- ORIGEN: 01_ddl/10_indexes/008_unique_facial_event_attendance.sql
WITH duplicated_events AS (
    SELECT
        id_facial_event,
        ROW_NUMBER() OVER (
            PARTITION BY id_record_environment, id_apprentice, event_type
            ORDER BY event_datetime ASC, created_at ASC, id_facial_event ASC
        ) AS duplicate_rank
    FROM facialrecognition.facial_event
    WHERE deleted_at IS NULL
)
UPDATE facialrecognition.facial_event fe
SET deleted_at = NOW(),
    deleted_by = 'liquibase-unique-facial-event-attendance'
FROM duplicated_events de
WHERE fe.id_facial_event = de.id_facial_event
  AND de.duplicate_rank > 1;

CREATE UNIQUE INDEX uq_facial_event_attendance_once
ON facialrecognition.facial_event (id_record_environment, id_apprentice, event_type)
WHERE deleted_at IS NULL;
