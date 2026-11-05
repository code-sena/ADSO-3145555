-- ============================================================
-- 04_COMMENTS.sql | Documentación del esquema
-- Proyecto: Airline Schema v3
-- Motor: PostgreSQL
-- Implementa: ADR-17 — COMMENTs extendidos en tablas y columnas clave
-- ============================================================

-- ============================================================
-- TABLAS LOOKUP
-- ============================================================
COMMENT ON TABLE passenger_type IS
    'ADR-02 | Catálogo de tipos de pasajero (ADULT, CHILD, INFANT, etc.). '
    'Reemplaza CHECK inline en reservation_passenger. Extensible sin DDL.';

COMMENT ON TABLE baggage_type IS
    'ADR-03 | Catálogo de tipos de equipaje (CHECKED, CARRY_ON, OVERSIZED, etc.). '
    'Extensible sin ALTER TABLE.';

COMMENT ON TABLE baggage_status IS
    'ADR-03 | Catálogo de estados de equipaje (CHECKED_IN, LOADED, DELIVERED, DAMAGED, DELAYED). '
    'Extensible sin ALTER TABLE.';

COMMENT ON TABLE seat_assignment_source IS
    'ADR-04 | Catálogo de fuentes de asignación de asiento (AUTO, MANUAL, CUSTOMER, KIOSK, API). '
    'Reemplaza CHECK inline en seat_assignment.';

COMMENT ON TABLE boarding_validation_result IS
    'ADR-05 | Catálogo de resultados de validación de abordaje (APPROVED, REJECTED, MANUAL_REVIEW, EXPIRED, DUPLICATE). '
    'Reemplaza CHECK inline en boarding_validation.';

COMMENT ON TABLE payment_transaction_type IS
    'ADR-06 | Catálogo de tipos de transacción de pago (AUTH, CAPTURE, VOID, REFUND, REVERSAL, CHARGEBACK). '
    'Reemplaza CHECK inline en payment_transaction.';

COMMENT ON TABLE exchange_rate_type IS
    'ADR-11 | Catálogo de tipos de tasa de cambio (MID, BUY, SELL, OFFICIAL, PARALLEL). '
    'Reemplaza CHECK inline en exchange_rate. Consistente con exchange_rate_source.';

-- ============================================================
-- TABLAS PRINCIPALES
-- ============================================================
COMMENT ON TABLE address IS
    'ADR-08 | Dirección física. Soporta soft-delete con is_active para preservar '
    'referencias históricas desde airport, airline y maintenance_provider.';

COMMENT ON COLUMN address.is_active IS
    'ADR-08 | false = dirección inactiva (soft-delete). '
    'Filtrar con WHERE is_active = true en queries de direcciones vigentes. '
    'Nunca eliminar físicamente registros referenciados.';

COMMENT ON TABLE person IS
    'Persona registrada en el sistema. Puede ser pasajero, contacto de proveedor o titular de cuenta. '
    'birth_date tiene CHECK de rango 1900-01-01 a current_date (ADR-07).';

COMMENT ON COLUMN person.birth_date IS
    'ADR-07 | Fecha de nacimiento. Acepta NULL. '
    'CHECK: birth_date BETWEEN 1900-01-01 AND current_date. '
    'Rechaza fechas biológicamente imposibles. Datos migrados anteriores a 1900 '
    'requieren ajuste o excepción documentada.';

COMMENT ON TABLE fare IS
    'ADR-09 | Tarifa por ruta, aerolínea y clase. '
    'is_current es columna GENERATED: no requiere mantenimiento manual.';

COMMENT ON COLUMN fare.is_current IS
    'ADR-09 | GENERATED ALWAYS AS (valid_to IS NULL OR valid_to >= current_date) STORED. '
    'Siempre consistente. Soportado por índice parcial idx_fare_current para '
    'queries de disponibilidad sin full-scan.';

COMMENT ON COLUMN fare.valid_to IS
    'NULL indica tarifa sin fecha de expiración (indefinida). '
    'La columna generada is_current depende de este valor.';

-- ============================================================
-- TABLAS DE OPERACIONES
-- ============================================================
COMMENT ON TABLE seat_assignment IS
    'ADR-01 (orden DDL), ADR-04 (source como FK). '
    'Asignación de asiento a un segmento de tiquete. '
    'El trigger trg_seat_assignment_aircraft_check valida que el asiento '
    'pertenezca al aircraft del vuelo programado.';

COMMENT ON COLUMN seat_assignment.seat_assignment_source_id IS
    'ADR-04 | FK a seat_assignment_source. Indica quién/qué originó la asignación '
    '(AUTO=sistema, MANUAL=agente, CUSTOMER=pasajero, KIOSK, API). '
    'Reemplaza columna assignment_source varchar+CHECK de v2.';

COMMENT ON TABLE boarding_pass IS
    'ADR-15 | Tarjeta de embarque. expires_at permite invalidación automática '
    'post-despegue y detección de pases vencidos en boarding_validation.';

COMMENT ON COLUMN boarding_pass.expires_at IS
    'ADR-15 | Fecha/hora de vencimiento del boarding pass. Nullable. '
    'CHECK: expires_at > issued_at. '
    'La aplicación debe asignar expires_at = scheduled_departure del segmento al emitir. '
    'Sin trigger automático por ahora (pendiente v4).';

COMMENT ON TABLE baggage IS
    'ADR-03 | Equipaje asociado a un tiquete. '
    'baggage_type_id y baggage_status_id son FKs a tablas lookup extensibles. '
    'Reemplaza columnas varchar con CHECK inline de v2.';

-- ============================================================
-- TABLAS FINANCIERAS
-- ============================================================
COMMENT ON TABLE exchange_rate IS
    'ADR-11 | Tasa de cambio entre par de monedas. '
    'exchange_rate_type_id es FK a exchange_rate_type (reemplaza rate_type varchar+CHECK). '
    'UNIQUE sobre (tipo, from, to, valid_at) evita duplicados temporales.';

COMMENT ON COLUMN exchange_rate.exchange_rate_type_id IS
    'ADR-11 | FK a exchange_rate_type. Tipo de tasa: MID, BUY, SELL, OFFICIAL, PARALLEL. '
    'Reemplaza columna rate_type varchar con CHECK inline de v2.';

-- ============================================================
-- TABLAS DE MILLAS
-- ============================================================
COMMENT ON TABLE miles_transaction IS
    'ADR-10 | Transacción de millas en un programa de fidelización. '
    'Tipo EARN requiere ticket_id (validado por trigger trg_miles_earn_ticket_check). '
    'Tipo ADJUST permite ticket_id NULL para ajustes manuales.';

COMMENT ON COLUMN miles_transaction.ticket_id IS
    'ADR-10 | FK a ticket. OBLIGATORIO cuando miles_transaction_type.code = EARN. '
    'Permite NULL para ADJUST y otros tipos. '
    'El trigger fn_check_miles_earn_ticket rechaza filas EARN sin ticket_id.';

-- ============================================================
-- TABLAS DE MANTENIMIENTO
-- ============================================================
COMMENT ON TABLE maintenance_provider IS
    'ADR-14 | Proveedor de mantenimiento de aeronaves. '
    'contact_person_id reemplaza contact_name varchar de v2.';

COMMENT ON COLUMN maintenance_provider.contact_person_id IS
    'ADR-14 | FK nullable a person. Contacto principal del proveedor. '
    'Reemplaza contact_name VARCHAR(120) libre de v2. '
    'Obtener teléfono/email vía JOIN a person_contact. '
    'Si el contacto no está registrado como person, crearlo previamente.';

-- ============================================================
-- TABLAS DE HISTORIAL (ADR-12)
-- ============================================================
COMMENT ON TABLE reservation_status_history IS
    'ADR-12 | Historial de cambios de estado de reservas. '
    'from_status_id = NULL indica creación inicial de la reserva. '
    'Requerido para auditoría IATA Resolution 722f. '
    'La capa de aplicación inserta en esta tabla dentro de la misma transacción '
    'al cambiar reservation.reservation_status_id.';

COMMENT ON TABLE ticket_status_history IS
    'ADR-12 | Historial de cambios de estado de tiquetes. '
    'from_status_id = NULL indica emisión inicial del tiquete. '
    'Requerido para trazabilidad IATA.';

COMMENT ON TABLE payment_status_history IS
    'ADR-12 | Historial de cambios de estado de pagos. '
    'from_status_id = NULL indica creación inicial del pago. '
    'Requerido para trazabilidad financiera y auditoría.';

COMMENT ON COLUMN reservation_status_history.from_status_id IS
    'ADR-12 | Estado previo. NULL indica que es el estado de creación inicial '
    '(no hubo estado anterior).';

COMMENT ON COLUMN ticket_status_history.from_status_id IS
    'ADR-12 | Estado previo del tiquete. NULL para emisión inicial.';

COMMENT ON COLUMN payment_status_history.from_status_id IS
    'ADR-12 | Estado previo del pago. NULL para creación inicial.';

-- ============================================================
-- AEROLÍNEA (ADR-13)
-- ============================================================
COMMENT ON COLUMN airline.address_id IS
    'ADR-13 | FK nullable a address. Sede principal de la aerolínea. '
    'Nullable porque no toda aerolínea tendrá su sede registrada al crearse. '
    'Consistente con airport.address_id y maintenance_provider.address_id.';

-- ============================================================
-- LOYALTY ACCOUNT TIER
-- ============================================================
COMMENT ON TABLE loyalty_account_tier IS
    'Niveles del programa de fidelización de una aerolínea '
    '(ej. Silver, Gold, Platinum). min_miles define el umbral de acumulación.';
