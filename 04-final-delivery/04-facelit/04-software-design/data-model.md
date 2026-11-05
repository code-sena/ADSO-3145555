# Modelo de datos FaceLit
Modelo conceptual, lógico y físico. Consolidación documental del 5 de noviembre de 2026.
## Fuente y alcance
Se utiliza el DDL de facelit-docs, su diccionario y Base_Datos_Migraciones, revisión dcf81aa. El DDL consolidado es una referencia de diseño; las migraciones de FaceLit-DB determinan la instalación del esquema vigente. No ejecutar este SQL como sustituto del changelog sin validarlo.
## Modelo conceptual
<!-- diagram:conceptual -->
Persona se especializa funcionalmente en aprendiz o instructor. Programa agrupa fichas. Aprendices e instructores se vinculan con fichas mediante asociaciones. Una sesión relaciona ficha, ambiente, dispositivo e instructor. Un evento de asistencia relaciona sesión y aprendiz; el perfil facial aporta la referencia de identidad.
## Modelo lógico
| Relación | Materialización en la referencia SQL |
|---|---|
| Programa - ficha | academic.chip.id_program referencia al programa. |
| Usuario - aprendiz/instructor | apprentice e instructor incluyen id_user_app único. |
| Aprendiz - ficha | academic.apprentice_chip resuelve la asociación. |
| Instructor - ficha | academic.instructor_chip conserva asociación y vigencia. |
| Sesión - ficha/ambiente/dispositivo/instructor | environment.record_environment contiene sus identificadores. |
| Evento - sesión/aprendiz/dispositivo | facialrecognition.facial_event conserva los identificadores del hecho. |
| Usuario - referencia facial | facialrecognition.user_face incluye id_user_app único y embedding. |
| Usuario - rol - permiso | user_role y role_permission resuelven las asociaciones. |
Las cardinalidades finales se determinan por FK, UNIQUE y reglas vigentes. Una asociación temporal puede contener historial; no inferir una única ficha para toda la vida del aprendiz a partir de una pantalla.
## Modelo físico y evolución
Motor PostgreSQL 16, extensión pgvector y claves UUID. Los siete esquemas documentados son security, roleandpermission, academic, environment, facialrecognition, notification y legal. El SQL adjunto conserva tipos, claves y restricciones; el diccionario amplía la descripción.
El DDL de referencia contiene nombres históricos como name_rol, descripcion y asigned_at. La evolución H-50 documenta role_name, description y assigned_at. No confundir la estructura inicial con el esquema resultante de todas las migraciones. El estado de 45 changesets pertenece al despliegue reportado del 27 de octubre, no a una medición nueva.
Actualización de referencia: el manual de instalación del 4 de noviembre incluye las migraciones 025 y 026 en la cadena local y cambios de compatibilidad de 06_migrations. Despliegue registra DB local 422aac6 y diferencias frente al remoto cd069ae. Los avisos de pendientes del documento database-migrations pertenecen a su revisión anterior; no describen por sí solos el paquete de noviembre. Este informe no aplica migraciones y conserva el DDL recibido como referencia inicial.
## Inventario físico de tablas del DDL recibido

## security.user_app
- id_user_app UUID PRIMARY KEY DEFAULT uuid_generate_v4()
- first_name VARCHAR(60) NOT NULL
- last_name VARCHAR(60) NOT NULL
- account_status VARCHAR(20) NOT NULL
- number_document VARCHAR(15) NOT NULL UNIQUE
- created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
- created_by VARCHAR(100)
- updated_at TIMESTAMPTZ
- updated_by VARCHAR(100)
- deleted_by VARCHAR(100)
- deleted_at TIMESTAMPTZ

## security.credential
- id_credential UUID PRIMARY KEY DEFAULT uuid_generate_v4()
- id_user_app UUID NOT NULL
- email VARCHAR(255) NOT NULL UNIQUE
- password_hash VARCHAR(255) NOT NULL
- credential_status VARCHAR(20) NOT NULL DEFAULT 'ACTIVE'
- failed_attempts INTEGER NOT NULL DEFAULT 0
- locked_until TIMESTAMPTZ
- created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
- created_by VARCHAR(100)
- updated_at TIMESTAMPTZ
- updated_by VARCHAR(100)
- deleted_by VARCHAR(100)
- deleted_at TIMESTAMPTZ

## security.password_recovery
- id_password_recovery UUID PRIMARY KEY DEFAULT uuid_generate_v4()
- id_user_app UUID NOT NULL
- token VARCHAR(255) NOT NULL
- expiration_date TIMESTAMPTZ NOT NULL
- used BOOLEAN NOT NULL DEFAULT FALSE
- created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
- created_by VARCHAR(100)
- updated_at TIMESTAMPTZ
- updated_by VARCHAR(100)
- deleted_by VARCHAR(100)
- deleted_at TIMESTAMPTZ

## security.user_session
- id_user_session UUID PRIMARY KEY DEFAULT uuid_generate_v4()
- id_user_app UUID NOT NULL
- start_date TIMESTAMPTZ NOT NULL
- end_date TIMESTAMPTZ
- session_status VARCHAR(20) NOT NULL
- created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
- created_by VARCHAR(100)
- updated_at TIMESTAMPTZ
- updated_by VARCHAR(100)
- deleted_by VARCHAR(100)
- deleted_at TIMESTAMPTZ

## security.user_configuration
- id_user_configuration UUID PRIMARY KEY DEFAULT uuid_generate_v4()
- id_user_app UUID NOT NULL UNIQUE
- notifications_active BOOLEAN NOT NULL DEFAULT TRUE
- dark_mode BOOLEAN NOT NULL DEFAULT FALSE
- language VARCHAR(2) NOT NULL CHECK (language IN ('ES', 'EN', 'PR', 'FR'))
- created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
- created_by VARCHAR(100)
- updated_at TIMESTAMPTZ
- updated_by VARCHAR(100)
- deleted_by VARCHAR(100)
- deleted_at TIMESTAMPTZ

## roleandpermission.role
- id_role UUID PRIMARY KEY DEFAULT uuid_generate_v4()
- name_rol VARCHAR(50) NOT NULL UNIQUE
- created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
- created_by VARCHAR(100)
- updated_at TIMESTAMPTZ
- updated_by VARCHAR(100)
- deleted_by VARCHAR(100)
- deleted_at TIMESTAMPTZ

## roleandpermission.permission
- id_permission UUID PRIMARY KEY DEFAULT uuid_generate_v4()
- name_permission VARCHAR(100) NOT NULL
- descripcion TEXT
- created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
- created_by VARCHAR(100)
- updated_at TIMESTAMPTZ
- updated_by VARCHAR(100)
- deleted_by VARCHAR(100)
- deleted_at TIMESTAMPTZ

## roleandpermission.user_role
- id_user_role UUID PRIMARY KEY DEFAULT uuid_generate_v4()
- id_user_app UUID NOT NULL
- id_role UUID NOT NULL
- asigned_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
- created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
- created_by VARCHAR(100)
- updated_at TIMESTAMPTZ
- updated_by VARCHAR(100)
- deleted_by VARCHAR(100)
- deleted_at TIMESTAMPTZ

## roleandpermission.role_permission
- id_role_permission UUID PRIMARY KEY DEFAULT uuid_generate_v4()
- id_role UUID NOT NULL
- id_permission UUID NOT NULL
- assigned_at TIMESTAMPTZ DEFAULT NOW()
- created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
- created_by VARCHAR(100)
- updated_at TIMESTAMPTZ
- updated_by VARCHAR(100)
- deleted_by VARCHAR(100)
- deleted_at TIMESTAMPTZ

## academic.program
- id_program UUID PRIMARY KEY DEFAULT uuid_generate_v4()
- program_name VARCHAR(100) NOT NULL UNIQUE
- program_code VARCHAR(15) NOT NULL UNIQUE
- state VARCHAR(20) NOT NULL
- deactivation_reason VARCHAR(200)
- created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
- created_by VARCHAR(100)
- updated_at TIMESTAMPTZ
- updated_by VARCHAR(100)
- deleted_by VARCHAR(100)
- deleted_at TIMESTAMPTZ

## academic.instructor
- id_instructor UUID PRIMARY KEY DEFAULT uuid_generate_v4()
- id_user_app UUID NOT NULL UNIQUE
- instructor_type VARCHAR(20) NOT NULL CHECK (instructor_type IN ('SPECIFIC', 'CROSS-CUTTING'))
- created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
- created_by VARCHAR(100), updated_at TIMESTAMPTZ, updated_by VARCHAR(100), deleted_by VARCHAR(100), deleted_at TIMESTAMPTZ

## academic.instructor_program
- id_instructor_program UUID PRIMARY KEY DEFAULT uuid_generate_v4()
- id_instructor UUID NOT NULL
- id_program UUID NOT NULL
- created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
- created_by VARCHAR(100), updated_at TIMESTAMPTZ, updated_by VARCHAR(100), deleted_by VARCHAR(100), deleted_at TIMESTAMPTZ

## academic.change_history
- id_change_history UUID PRIMARY KEY DEFAULT uuid_generate_v4()
- entity_name VARCHAR(50) NOT NULL
- entity_id UUID NOT NULL
- field_name VARCHAR(100) NOT NULL
- old_value TEXT
- new_value TEXT
- action VARCHAR(20) NOT NULL CHECK (action IN ('CREATE', 'UPDATE', 'DEACTIVATE', 'REACTIVATE', 'DELETE', 'CSV_LOAD', 'CSV_CONFIRM', 'CSV_CANCEL'))
- created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
- created_by VARCHAR(100)

## academic.chip
- id_chip UUID PRIMARY KEY DEFAULT uuid_generate_v4()
- id_program UUID NOT NULL
- chip_code VARCHAR(20) NOT NULL UNIQUE
- start_date DATE
- end_date DATE
- state VARCHAR(20) NOT NULL
- deactivation_reason VARCHAR(200)
- created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
- created_by VARCHAR(100)
- updated_at TIMESTAMPTZ
- updated_by VARCHAR(100)
- deleted_by VARCHAR(100)
- deleted_at TIMESTAMPTZ

## academic.instructor_chip
- id_instructor_chip UUID PRIMARY KEY DEFAULT uuid_generate_v4()
- id_instructor UUID NOT NULL
- id_chip UUID NOT NULL
- assignment_start DATE
- assignment_end DATE
- active BOOLEAN NOT NULL DEFAULT TRUE
- created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
- created_by VARCHAR(100)
- updated_at TIMESTAMPTZ
- updated_by VARCHAR(100)
- deleted_by VARCHAR(100)
- deleted_at TIMESTAMPTZ

## academic.apprentice
- id_apprentice UUID PRIMARY KEY DEFAULT uuid_generate_v4()
- id_user_app UUID NOT NULL UNIQUE
- created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
- created_by VARCHAR(100)
- updated_at TIMESTAMPTZ
- updated_by VARCHAR(100)
- deleted_by VARCHAR(100)
- deleted_at TIMESTAMPTZ

## academic.apprentice_chip
- id_apprentice_chip UUID PRIMARY KEY DEFAULT uuid_generate_v4()
- id_apprentice UUID NOT NULL
- id_chip UUID NOT NULL
- state VARCHAR(20) NOT NULL
- created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
- created_by VARCHAR(100)
- updated_at TIMESTAMPTZ
- updated_by VARCHAR(100)
- deleted_by VARCHAR(100)
- deleted_at TIMESTAMPTZ

## academic.csv_pending_transfer
- id_pending_transfer UUID PRIMARY KEY DEFAULT uuid_generate_v4()
- id_user_app UUID NOT NULL REFERENCES security.user_app(id_user_app)
- id_chip_current UUID NOT NULL REFERENCES academic.chip(id_chip)
- id_chip_proposed UUID NOT NULL REFERENCES academic.chip(id_chip)
- source_row_number INTEGER NOT NULL
- status VARCHAR(20) NOT NULL DEFAULT 'PENDING'
- created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
- created_by VARCHAR(100)
- updated_at TIMESTAMPTZ
- updated_by VARCHAR(100)
- deleted_by VARCHAR(100)
- deleted_at TIMESTAMPTZ
- resolved_at TIMESTAMPTZ
- resolved_by VARCHAR(100)

## environment.environment
- id_environment UUID PRIMARY KEY DEFAULT uuid_generate_v4()
- environment_name VARCHAR(100) NOT NULL
- created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
- created_by VARCHAR(100)
- updated_at TIMESTAMPTZ
- updated_by VARCHAR(100)
- deleted_by VARCHAR(100)
- deleted_at TIMESTAMPTZ

## environment.chip_environment
- id_chip_environment UUID PRIMARY KEY DEFAULT uuid_generate_v4()
- id_chip UUID NOT NULL
- id_environment UUID NOT NULL
- assignment_date TIMESTAMPTZ NOT NULL DEFAULT NOW()
- state VARCHAR(20) NOT NULL
- created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
- created_by VARCHAR(100)
- updated_at TIMESTAMPTZ
- updated_by VARCHAR(100)
- deleted_by VARCHAR(100)
- deleted_at TIMESTAMPTZ

## environment.record_environment
- id_record_environment UUID NOT NULL PRIMARY KEY DEFAULT uuid_generate_v4()
- id_environment UUID NOT NULL
- id_device UUID NOT NULL
- id_chip UUID NOT NULL
- id_instructor_scheduled UUID NOT NULL
- id_instructor_in_charge UUID NULL
- entry_time TIMESTAMPTZ NOT NULL
- registration_minutes INTEGER NOT NULL CHECK (registration_minutes > 0)
- exit_time TIMESTAMPTZ NOT NULL
- shutdown_time TIMESTAMPTZ NOT NULL
- exit_reminder_sent BOOLEAN NOT NULL DEFAULT FALSE
- active BOOLEAN NOT NULL DEFAULT TRUE
- created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
- created_by VARCHAR(100)
- updated_at TIMESTAMPTZ
- updated_by VARCHAR(100)
- deleted_by VARCHAR(100)
- deleted_at TIMESTAMPTZ

## notification.notification
- id_notification UUID PRIMARY KEY DEFAULT uuid_generate_v4()
- id_user_app UUID NOT NULL
- id_facial_event UUID NULL
- notification_type VARCHAR(60) NOT NULL DEFAULT 'academic_delete_blocked'
- category VARCHAR(30) NOT NULL CHECK (category IN ('SEGURIDAD', 'ACADEMICO', 'ASISTENCIA', 'RECONOCIMIENTO_FACIAL', 'TRASLADO'))
- title VARCHAR(120) NOT NULL DEFAULT 'Notificacion'
- message TEXT NOT NULL
- channel VARCHAR(15) NOT NULL CHECK (channel IN ('APP', 'APP_EMAIL'))
- read_status BOOLEAN NOT NULL DEFAULT FALSE
- read_at TIMESTAMPTZ
- reference_entity VARCHAR(50), reference_id UUID
- metadata_json TEXT
- created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()

## notification.email_log
- id_email_log UUID PRIMARY KEY DEFAULT uuid_generate_v4()
- id_notification UUID NOT NULL
- send_status VARCHAR(20) NOT NULL CHECK (send_status IN ('PENDING', 'SENT', 'FAILED'))
- attempts INTEGER NOT NULL DEFAULT 0
- sent_at TIMESTAMPTZ
- created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()

## legal.terms_acceptance
- id_acceptance UUID PRIMARY KEY DEFAULT uuid_generate_v4()
- id_user_app UUID NOT NULL
- accepted BOOLEAN NOT NULL DEFAULT FALSE
- created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
- created_by VARCHAR(100)
- updated_at TIMESTAMPTZ
- updated_by VARCHAR(100)
- deleted_by VARCHAR(100)
- deleted_at TIMESTAMPTZ

## facialrecognition.device
- id_device UUID PRIMARY KEY DEFAULT uuid_generate_v4()
- id_environment UUID NOT NULL
- device_code VARCHAR(50) NOT NULL UNIQUE
- location VARCHAR(100)
- status VARCHAR(20) NOT NULL CHECK (status IN ('ACTIVE', 'PENDING', 'INACTIVE'))
- origin_ip VARCHAR(50)
- created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
- created_by VARCHAR(100)
- updated_at TIMESTAMPTZ
- updated_by VARCHAR(100)
- deleted_by VARCHAR(100)
- deleted_at TIMESTAMPTZ

## facialrecognition.user_face
- id_user_face UUID PRIMARY KEY DEFAULT uuid_generate_v4()
- id_apprentice UUID NOT NULL UNIQUE
- embedding vector NOT NULL
- embedding_dimension INT4
- model_name VARCHAR(100)
- photo_reference VARCHAR(500)
- status VARCHAR(20) NOT NULL
- created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
- created_by VARCHAR(1000)
- updated_at TIMESTAMPTZ
- updated_by VARCHAR(100)
- deleted_by VARCHAR(100)
- deleted_at TIMESTAMPTZ

## facialrecognition.facial_event
- id_facial_event UUID PRIMARY KEY DEFAULT uuid_generate_v4()
- id_record_environment UUID NOT NULL
- id_device UUID NOT NULL
- id_apprentice UUID NOT NULL
- event_datetime TIMESTAMPTZ NOT NULL
- event_type VARCHAR(20) NOT NULL CHECK (event_type IN ('ENTRY', 'EXIT'))
- recognition_result VARCHAR(20) NOT NULL
- attendance_status VARCHAR(20) NOT NULL CHECK (attendance_status IN ('PUNCTUAL', 'LATE', 'ABSENT'))
- match_score NUMERIC(5,4) CHECK (match_score >= 0 AND match_score <= 1)
- origin VARCHAR(10) NOT NULL CHECK (origin IN ('PC', 'MOBILE'))
- created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
- created_by VARCHAR(100)
- updated_at TIMESTAMPTZ
- updated_by VARCHAR(100)
- deleted_by VARCHAR(100)
- deleted_at TIMESTAMPTZ

## facialrecognition.biometric_log
- id_biometric_log UUID PRIMARY KEY DEFAULT uuid_generate_v4()
- id_facial_event UUID NOT NULL
- description TEXT
- log_date TIMESTAMPTZ NOT NULL DEFAULT NOW()
- created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
- created_by VARCHAR(100)
- updated_at TIMESTAMPTZ
- updated_by VARCHAR(100)
- deleted_by VARCHAR(100)
- deleted_at TIMESTAMPTZ

## facialrecognition.face_reset_request
- id_face_reset_request UUID PRIMARY KEY DEFAULT uuid_generate_v4()
- id_user_app UUID NOT NULL
- request_status VARCHAR(20) NOT NULL CHECK (request_status IN ('PENDING', 'ACCEPTED', 'REJECTED'))
- requested_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
- resolved_by UUID
- resolved_at TIMESTAMPTZ
- created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
- created_by VARCHAR(100)
- updated_at TIMESTAMPTZ
- updated_by VARCHAR(100)
- deleted_by VARCHAR(100)
- deleted_at TIMESTAMPTZ

## Soportes y validación pendiente
Consultar database-reference.sql, data-dictionary.pdf y database-migrations.pdf. Los diagramas recibidos están en source-diagrams. Comparar este modelo con el tag final y validar el changelog en una base desechable antes de considerar cerrada la correspondencia física.
