-- ============================================================
-- 01_DDL.sql | Estructura completa - Airline Schema v3
-- Motor: PostgreSQL
-- Incluye: ADR-01 a ADR-15 (estructura y columnas)
-- ============================================================

CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- ============================================================
-- LIMPIEZA (orden inverso a dependencias)
-- ============================================================
DROP TABLE IF EXISTS payment_status_history      CASCADE;
DROP TABLE IF EXISTS ticket_status_history        CASCADE;
DROP TABLE IF EXISTS reservation_status_history   CASCADE;
DROP TABLE IF EXISTS maintenance_record           CASCADE;
DROP TABLE IF EXISTS maintenance_provider         CASCADE;
DROP TABLE IF EXISTS invoice_line                 CASCADE;
DROP TABLE IF EXISTS invoice                      CASCADE;
DROP TABLE IF EXISTS refund                       CASCADE;
DROP TABLE IF EXISTS payment_transaction          CASCADE;
DROP TABLE IF EXISTS payment                      CASCADE;
DROP TABLE IF EXISTS exchange_rate                CASCADE;
DROP TABLE IF EXISTS exchange_rate_type           CASCADE;  -- ADR-11
DROP TABLE IF EXISTS exchange_rate_source         CASCADE;
DROP TABLE IF EXISTS miles_transaction            CASCADE;
DROP TABLE IF EXISTS loyalty_account              CASCADE;
DROP TABLE IF EXISTS loyalty_account_tier         CASCADE;
DROP TABLE IF EXISTS baggage                      CASCADE;
DROP TABLE IF EXISTS boarding_validation          CASCADE;
DROP TABLE IF EXISTS boarding_pass                CASCADE;
DROP TABLE IF EXISTS seat_assignment              CASCADE;
DROP TABLE IF EXISTS ticket_segment               CASCADE;
DROP TABLE IF EXISTS ticket                       CASCADE;
DROP TABLE IF EXISTS reservation_passenger        CASCADE;
DROP TABLE IF EXISTS reservation                  CASCADE;
DROP TABLE IF EXISTS fare                         CASCADE;
DROP TABLE IF EXISTS seat                         CASCADE;
DROP TABLE IF EXISTS scheduled_flight             CASCADE;
DROP TABLE IF EXISTS flight_route                 CASCADE;
DROP TABLE IF EXISTS aircraft                     CASCADE;
DROP TABLE IF EXISTS aircraft_model               CASCADE;
DROP TABLE IF EXISTS airport                      CASCADE;
DROP TABLE IF EXISTS airline                      CASCADE;
DROP TABLE IF EXISTS user_account                 CASCADE;
DROP TABLE IF EXISTS person_contact               CASCADE;
DROP TABLE IF EXISTS person                       CASCADE;
DROP TABLE IF EXISTS address                      CASCADE;
DROP TABLE IF EXISTS country                      CASCADE;

-- Lookups
DROP TABLE IF EXISTS payment_transaction_type     CASCADE;  -- ADR-06
DROP TABLE IF EXISTS boarding_validation_result   CASCADE;  -- ADR-05
DROP TABLE IF EXISTS seat_assignment_source       CASCADE;  -- ADR-04
DROP TABLE IF EXISTS baggage_status               CASCADE;  -- ADR-03
DROP TABLE IF EXISTS baggage_type                 CASCADE;  -- ADR-03
DROP TABLE IF EXISTS passenger_type               CASCADE;  -- ADR-02
DROP TABLE IF EXISTS payment_status               CASCADE;
DROP TABLE IF EXISTS ticket_status                CASCADE;
DROP TABLE IF EXISTS reservation_status           CASCADE;
DROP TABLE IF EXISTS refund_status                CASCADE;
DROP TABLE IF EXISTS miles_transaction_type       CASCADE;
DROP TABLE IF EXISTS contact_type                 CASCADE;
DROP TABLE IF EXISTS seat_class                   CASCADE;
DROP TABLE IF EXISTS maintenance_status           CASCADE;

-- ============================================================
-- TABLAS LOOKUP / CATÁLOGOS
-- ============================================================

-- Clases de asiento
CREATE TABLE seat_class (
    seat_class_id   UUID         NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
    code            VARCHAR(10)  NOT NULL UNIQUE,
    name            VARCHAR(50)  NOT NULL
);

-- Tipos de contacto (teléfono, email, etc.)
CREATE TABLE contact_type (
    contact_type_id UUID        NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
    code            VARCHAR(20) NOT NULL UNIQUE,
    name            VARCHAR(50) NOT NULL
);

-- Estados de reserva
CREATE TABLE reservation_status (
    reservation_status_id UUID        NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
    code                  VARCHAR(30) NOT NULL UNIQUE,
    name                  VARCHAR(80) NOT NULL
);

-- Estados de tiquete
CREATE TABLE ticket_status (
    ticket_status_id UUID        NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
    code             VARCHAR(30) NOT NULL UNIQUE,
    name             VARCHAR(80) NOT NULL
);

-- Estados de pago
CREATE TABLE payment_status (
    payment_status_id UUID        NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
    code              VARCHAR(30) NOT NULL UNIQUE,
    name              VARCHAR(80) NOT NULL
);

-- Estados de reembolso
CREATE TABLE refund_status (
    refund_status_id UUID        NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
    code             VARCHAR(30) NOT NULL UNIQUE,
    name             VARCHAR(80) NOT NULL
);

-- Tipos de transacción de millas
CREATE TABLE miles_transaction_type (
    miles_transaction_type_id UUID        NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
    code                      VARCHAR(20) NOT NULL UNIQUE,
    name                      VARCHAR(80) NOT NULL
);

-- Estado de mantenimiento
CREATE TABLE maintenance_status (
    maintenance_status_id UUID        NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
    code                  VARCHAR(30) NOT NULL UNIQUE,
    name                  VARCHAR(80) NOT NULL
);

-- ── ADR-02: passenger_type como tabla lookup ───────────────────
CREATE TABLE passenger_type (
    passenger_type_id UUID        NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
    code              VARCHAR(30) NOT NULL UNIQUE,
    name              VARCHAR(80) NOT NULL
);

-- ── ADR-03: baggage_type y baggage_status como tablas lookup ──
CREATE TABLE baggage_type (
    baggage_type_id UUID        NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
    code            VARCHAR(30) NOT NULL UNIQUE,
    name            VARCHAR(80) NOT NULL
);

CREATE TABLE baggage_status (
    baggage_status_id UUID        NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
    code              VARCHAR(30) NOT NULL UNIQUE,
    name              VARCHAR(80) NOT NULL
);

-- ── ADR-04: seat_assignment_source como tabla lookup ──────────
CREATE TABLE seat_assignment_source (
    seat_assignment_source_id UUID        NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
    code                      VARCHAR(30) NOT NULL UNIQUE,
    name                      VARCHAR(80) NOT NULL
);

-- ── ADR-05: boarding_validation_result como tabla lookup ──────
CREATE TABLE boarding_validation_result (
    boarding_validation_result_id UUID        NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
    code                          VARCHAR(30) NOT NULL UNIQUE,
    name                          VARCHAR(80) NOT NULL
);

-- ── ADR-06: payment_transaction_type como tabla lookup ────────
CREATE TABLE payment_transaction_type (
    payment_transaction_type_id UUID        NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
    code                        VARCHAR(30) NOT NULL UNIQUE,
    name                        VARCHAR(80) NOT NULL
);

-- ── ADR-11: exchange_rate_type como tabla lookup ──────────────
CREATE TABLE exchange_rate_type (
    exchange_rate_type_id UUID        NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
    code                  VARCHAR(20) NOT NULL UNIQUE,
    name                  VARCHAR(80) NOT NULL
);

-- ============================================================
-- ENTIDADES BASE
-- ============================================================

-- País
CREATE TABLE country (
    country_id   UUID        NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
    iso_code     CHAR(2)     NOT NULL UNIQUE,
    iso_code_3   CHAR(3)     NOT NULL UNIQUE,
    name         VARCHAR(100) NOT NULL
);

-- ── ADR-08: address con soft-delete is_active ─────────────────
CREATE TABLE address (
    address_id   UUID         NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
    country_id   UUID         NOT NULL REFERENCES country(country_id),
    street       VARCHAR(200),
    city         VARCHAR(100),
    state        VARCHAR(100),
    postal_code  VARCHAR(20),
    is_active    BOOLEAN      NOT NULL DEFAULT true,   -- ADR-08
    created_at   TIMESTAMPTZ  NOT NULL DEFAULT NOW(),
    updated_at   TIMESTAMPTZ  NOT NULL DEFAULT NOW()
);

-- ── ADR-07: person con birth_date CHECK ───────────────────────
CREATE TABLE person (
    person_id   UUID         NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
    first_name  VARCHAR(80)  NOT NULL,
    last_name   VARCHAR(80)  NOT NULL,
    birth_date  DATE
        CONSTRAINT ck_person_birth_date
            CHECK (birth_date IS NULL
                OR birth_date BETWEEN '1900-01-01' AND current_date),  -- ADR-07
    passport_number VARCHAR(30),
    nationality_id  UUID     REFERENCES country(country_id),
    created_at  TIMESTAMPTZ  NOT NULL DEFAULT NOW(),
    updated_at  TIMESTAMPTZ  NOT NULL DEFAULT NOW(),
    deleted_at  TIMESTAMPTZ
);

CREATE TABLE person_contact (
    person_contact_id UUID        NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
    person_id         UUID        NOT NULL REFERENCES person(person_id) ON DELETE CASCADE,
    contact_type_id   UUID        NOT NULL REFERENCES contact_type(contact_type_id),
    value             VARCHAR(150) NOT NULL,
    is_primary        BOOLEAN      NOT NULL DEFAULT false,
    created_at        TIMESTAMPTZ  NOT NULL DEFAULT NOW()
);

-- Cuenta de usuario del sistema
CREATE TABLE user_account (
    user_account_id UUID         NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
    person_id       UUID         NOT NULL REFERENCES person(person_id),
    username        VARCHAR(80)  NOT NULL UNIQUE,
    password_hash   VARCHAR(255) NOT NULL,
    is_active       BOOLEAN      NOT NULL DEFAULT true,
    created_at      TIMESTAMPTZ  NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMPTZ  NOT NULL DEFAULT NOW()
);

-- ── ADR-13: airline con address_id ────────────────────────────
CREATE TABLE airline (
    airline_id      UUID        NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
    iata_code       CHAR(2)     NOT NULL UNIQUE,
    icao_code       CHAR(3)     UNIQUE,
    name            VARCHAR(120) NOT NULL,
    home_country_id UUID        REFERENCES country(country_id),
    address_id      UUID        REFERENCES address(address_id),  -- ADR-13
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE airport (
    airport_id  UUID        NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
    iata_code   CHAR(3)     NOT NULL UNIQUE,
    icao_code   CHAR(4),
    name        VARCHAR(150) NOT NULL,
    city        VARCHAR(100),
    country_id  UUID        REFERENCES country(country_id),
    address_id  UUID        REFERENCES address(address_id),
    latitude    DECIMAL(9,6),
    longitude   DECIMAL(9,6),
    timezone    VARCHAR(60),
    created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at  TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE aircraft_model (
    aircraft_model_id UUID        NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
    manufacturer      VARCHAR(80) NOT NULL,
    model             VARCHAR(80) NOT NULL,
    seat_capacity     INTEGER     NOT NULL CHECK (seat_capacity > 0),
    UNIQUE (manufacturer, model)
);

CREATE TABLE aircraft (
    aircraft_id       UUID        NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
    airline_id        UUID        NOT NULL REFERENCES airline(airline_id),
    aircraft_model_id UUID        NOT NULL REFERENCES aircraft_model(aircraft_model_id),
    tail_number       VARCHAR(20) NOT NULL UNIQUE,
    manufacture_year  SMALLINT    CHECK (manufacture_year BETWEEN 1900 AND EXTRACT(YEAR FROM NOW())::SMALLINT),
    is_active         BOOLEAN     NOT NULL DEFAULT true,
    created_at        TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE seat (
    seat_id       UUID        NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
    aircraft_id   UUID        NOT NULL REFERENCES aircraft(aircraft_id) ON DELETE CASCADE,
    seat_class_id UUID        NOT NULL REFERENCES seat_class(seat_class_id),
    seat_number   VARCHAR(10) NOT NULL,
    is_emergency_exit BOOLEAN NOT NULL DEFAULT false,
    UNIQUE (aircraft_id, seat_number)
);

-- ============================================================
-- OPERACIONES DE VUELO
-- ============================================================

CREATE TABLE flight_route (
    flight_route_id     UUID        NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
    airline_id          UUID        NOT NULL REFERENCES airline(airline_id),
    origin_airport_id   UUID        NOT NULL REFERENCES airport(airport_id),
    destination_airport_id UUID     NOT NULL REFERENCES airport(airport_id),
    flight_number       VARCHAR(10) NOT NULL,
    is_active           BOOLEAN     NOT NULL DEFAULT true,
    CONSTRAINT chk_route_airports CHECK (origin_airport_id <> destination_airport_id),
    UNIQUE (airline_id, flight_number)
);

CREATE TABLE scheduled_flight (
    scheduled_flight_id UUID             NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
    flight_route_id     UUID             NOT NULL REFERENCES flight_route(flight_route_id),
    aircraft_id         UUID             NOT NULL REFERENCES aircraft(aircraft_id),
    scheduled_departure TIMESTAMPTZ      NOT NULL,
    scheduled_arrival   TIMESTAMPTZ      NOT NULL,
    actual_departure    TIMESTAMPTZ,
    actual_arrival      TIMESTAMPTZ,
    gate                VARCHAR(10),
    created_at          TIMESTAMPTZ      NOT NULL DEFAULT NOW(),
    CONSTRAINT chk_flight_times CHECK (scheduled_arrival > scheduled_departure)
);

-- ── ADR-09: fare con columna GENERATED is_current ─────────────
CREATE TABLE fare (
    fare_id               UUID           NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
    airline_id            UUID           NOT NULL REFERENCES airline(airline_id),
    origin_airport_id     UUID           NOT NULL REFERENCES airport(airport_id),
    destination_airport_id UUID          NOT NULL REFERENCES airport(airport_id),
    seat_class_id         UUID           NOT NULL REFERENCES seat_class(seat_class_id),
    base_amount           NUMERIC(12,2)  NOT NULL CHECK (base_amount >= 0),
    currency_code         CHAR(3)        NOT NULL,
    valid_from            DATE           NOT NULL,
    valid_to              DATE,
    is_current            BOOLEAN GENERATED ALWAYS AS  -- ADR-09
        (valid_to IS NULL OR valid_to >= current_date) STORED,
    created_at            TIMESTAMPTZ    NOT NULL DEFAULT NOW(),
    CONSTRAINT chk_fare_dates CHECK (valid_to IS NULL OR valid_to >= valid_from)
);

-- ============================================================
-- RESERVAS Y PASAJEROS
-- ============================================================

CREATE TABLE reservation (
    reservation_id        UUID        NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
    reservation_status_id UUID        NOT NULL REFERENCES reservation_status(reservation_status_id),
    created_by            UUID        REFERENCES user_account(user_account_id),
    booking_reference     VARCHAR(10) NOT NULL UNIQUE,
    created_at            TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at            TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ── ADR-02: reservation_passenger usa FK a passenger_type ────
CREATE TABLE reservation_passenger (
    reservation_passenger_id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
    reservation_id           UUID NOT NULL REFERENCES reservation(reservation_id) ON DELETE CASCADE,
    person_id                UUID NOT NULL REFERENCES person(person_id),
    passenger_type_id        UUID NOT NULL REFERENCES passenger_type(passenger_type_id),  -- ADR-02
    created_at               TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE ticket (
    ticket_id        UUID         NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
    reservation_id   UUID         NOT NULL REFERENCES reservation(reservation_id),
    person_id        UUID         NOT NULL REFERENCES person(person_id),
    ticket_status_id UUID         NOT NULL REFERENCES ticket_status(ticket_status_id),
    ticket_number    VARCHAR(20)  NOT NULL UNIQUE,
    fare_id          UUID         REFERENCES fare(fare_id),
    total_amount     NUMERIC(12,2) NOT NULL CHECK (total_amount >= 0),
    currency_code    CHAR(3)      NOT NULL,
    issued_at        TIMESTAMPTZ  NOT NULL DEFAULT NOW(),
    created_at       TIMESTAMPTZ  NOT NULL DEFAULT NOW(),
    updated_at       TIMESTAMPTZ  NOT NULL DEFAULT NOW()
);

-- ── ADR-01 (orden correcto): ticket_segment DESPUÉS de ticket ─
CREATE TABLE ticket_segment (
    ticket_segment_id   UUID        NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
    ticket_id           UUID        NOT NULL REFERENCES ticket(ticket_id) ON DELETE CASCADE,
    scheduled_flight_id UUID        NOT NULL REFERENCES scheduled_flight(scheduled_flight_id),
    segment_order       SMALLINT    NOT NULL CHECK (segment_order > 0),
    created_at          TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ── ADR-01 (orden correcto): seat_assignment DESPUÉS de sus tablas
-- ── ADR-04: seat_assignment_source_id como FK ─────────────────
CREATE TABLE seat_assignment (
    seat_assignment_id        UUID        NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
    ticket_segment_id         UUID        NOT NULL REFERENCES ticket_segment(ticket_segment_id),
    seat_id                   UUID        NOT NULL REFERENCES seat(seat_id),
    seat_assignment_source_id UUID        NOT NULL REFERENCES seat_assignment_source(seat_assignment_source_id),  -- ADR-04
    assigned_at               TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    UNIQUE (ticket_segment_id)
);

-- ── ADR-15: boarding_pass con expires_at ──────────────────────
CREATE TABLE boarding_pass (
    boarding_pass_id  UUID        NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
    ticket_segment_id UUID        NOT NULL REFERENCES ticket_segment(ticket_segment_id),
    seat_assignment_id UUID       REFERENCES seat_assignment(seat_assignment_id),
    barcode           VARCHAR(100) NOT NULL UNIQUE,
    issued_at         TIMESTAMPTZ  NOT NULL DEFAULT NOW(),
    expires_at        TIMESTAMPTZ,                          -- ADR-15
    CONSTRAINT ck_boarding_pass_dates
        CHECK (expires_at IS NULL OR expires_at > issued_at)  -- ADR-15
);

-- ── ADR-05: boarding_validation con FK a boarding_validation_result
CREATE TABLE boarding_validation (
    boarding_validation_id        UUID        NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
    boarding_pass_id              UUID        NOT NULL REFERENCES boarding_pass(boarding_pass_id),
    boarding_validation_result_id UUID        NOT NULL REFERENCES boarding_validation_result(boarding_validation_result_id),  -- ADR-05
    validated_at                  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    agent_user_id                 UUID        REFERENCES user_account(user_account_id),
    notes                         TEXT
);

-- ── ADR-03: baggage con FKs a baggage_type y baggage_status ──
CREATE TABLE baggage (
    baggage_id        UUID           NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
    ticket_id         UUID           NOT NULL REFERENCES ticket(ticket_id),
    baggage_type_id   UUID           NOT NULL REFERENCES baggage_type(baggage_type_id),    -- ADR-03
    baggage_status_id UUID           NOT NULL REFERENCES baggage_status(baggage_status_id), -- ADR-03
    weight_kg         DECIMAL(5,2)   CHECK (weight_kg > 0),
    tag_number        VARCHAR(20)    UNIQUE,
    created_at        TIMESTAMPTZ    NOT NULL DEFAULT NOW(),
    updated_at        TIMESTAMPTZ    NOT NULL DEFAULT NOW()
);

-- ============================================================
-- FIDELIZACIÓN Y MILLAS
-- ============================================================

CREATE TABLE loyalty_account_tier (
    loyalty_account_tier_id UUID        NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
    airline_id              UUID        NOT NULL REFERENCES airline(airline_id),
    code                    VARCHAR(20) NOT NULL,
    name                    VARCHAR(80) NOT NULL,
    min_miles               INTEGER     NOT NULL DEFAULT 0,
    UNIQUE (airline_id, code)
);

CREATE TABLE loyalty_account (
    loyalty_account_id      UUID        NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
    person_id               UUID        NOT NULL REFERENCES person(person_id),
    airline_id              UUID        NOT NULL REFERENCES airline(airline_id),
    loyalty_account_tier_id UUID        REFERENCES loyalty_account_tier(loyalty_account_tier_id),
    account_number          VARCHAR(20) NOT NULL UNIQUE,
    miles_balance           INTEGER     NOT NULL DEFAULT 0 CHECK (miles_balance >= 0),
    enrolled_at             TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at              TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    UNIQUE (person_id, airline_id)
);

-- miles_transaction: trigger EARN valida ticket_id (ADR-10)
-- La tabla se crea aquí; el trigger se aplica en 02_TRIGGERS.sql
CREATE TABLE miles_transaction (
    miles_transaction_id      UUID        NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
    loyalty_account_id        UUID        NOT NULL REFERENCES loyalty_account(loyalty_account_id),
    miles_transaction_type_id UUID        NOT NULL REFERENCES miles_transaction_type(miles_transaction_type_id),
    ticket_id                 UUID        REFERENCES ticket(ticket_id),  -- requerido si tipo = EARN (ADR-10)
    miles_amount              INTEGER     NOT NULL,
    description               TEXT,
    transaction_at            TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_at                TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ============================================================
-- FINANZAS Y PAGOS
-- ============================================================

CREATE TABLE exchange_rate_source (
    exchange_rate_source_id UUID        NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
    code                    VARCHAR(30) NOT NULL UNIQUE,
    name                    VARCHAR(80) NOT NULL
);

-- ── ADR-11: exchange_rate con FK a exchange_rate_type ─────────
CREATE TABLE exchange_rate (
    exchange_rate_id      UUID           NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
    exchange_rate_type_id UUID           NOT NULL REFERENCES exchange_rate_type(exchange_rate_type_id),  -- ADR-11
    exchange_rate_source_id UUID         NOT NULL REFERENCES exchange_rate_source(exchange_rate_source_id),
    from_currency         CHAR(3)        NOT NULL,
    to_currency           CHAR(3)        NOT NULL,
    rate                  NUMERIC(18,8)  NOT NULL CHECK (rate > 0),
    valid_at              TIMESTAMPTZ    NOT NULL,
    UNIQUE (exchange_rate_type_id, from_currency, to_currency, valid_at)
);

CREATE TABLE payment (
    payment_id        UUID           NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
    reservation_id    UUID           NOT NULL REFERENCES reservation(reservation_id),
    payment_status_id UUID           NOT NULL REFERENCES payment_status(payment_status_id),
    total_amount      NUMERIC(12,2)  NOT NULL CHECK (total_amount > 0),
    currency_code     CHAR(3)        NOT NULL,
    created_at        TIMESTAMPTZ    NOT NULL DEFAULT NOW(),
    updated_at        TIMESTAMPTZ    NOT NULL DEFAULT NOW()
);

-- ── ADR-06: payment_transaction con FK a payment_transaction_type
CREATE TABLE payment_transaction (
    payment_transaction_id      UUID           NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
    payment_id                  UUID           NOT NULL REFERENCES payment(payment_id),
    payment_transaction_type_id UUID           NOT NULL REFERENCES payment_transaction_type(payment_transaction_type_id),  -- ADR-06
    amount                      NUMERIC(12,2)  NOT NULL,
    currency_code               CHAR(3)        NOT NULL,
    gateway_reference           VARCHAR(100),
    processed_at                TIMESTAMPTZ    NOT NULL DEFAULT NOW(),
    created_at                  TIMESTAMPTZ    NOT NULL DEFAULT NOW()
);

CREATE TABLE refund (
    refund_id              UUID           NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
    payment_transaction_id UUID           NOT NULL REFERENCES payment_transaction(payment_transaction_id),
    refund_status_id       UUID           NOT NULL REFERENCES refund_status(refund_status_id),
    amount                 NUMERIC(12,2)  NOT NULL CHECK (amount > 0),
    currency_code          CHAR(3)        NOT NULL,
    reason                 TEXT,
    requested_at           TIMESTAMPTZ    NOT NULL DEFAULT NOW(),
    processed_at           TIMESTAMPTZ
);

CREATE TABLE invoice (
    invoice_id     UUID           NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
    reservation_id UUID           NOT NULL REFERENCES reservation(reservation_id),
    invoice_number VARCHAR(20)    NOT NULL UNIQUE,
    issued_at      TIMESTAMPTZ    NOT NULL DEFAULT NOW(),
    total_amount   NUMERIC(12,2)  NOT NULL CHECK (total_amount >= 0),
    currency_code  CHAR(3)        NOT NULL
);

CREATE TABLE invoice_line (
    invoice_line_id UUID           NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
    invoice_id      UUID           NOT NULL REFERENCES invoice(invoice_id) ON DELETE CASCADE,
    description     TEXT           NOT NULL,
    quantity        SMALLINT       NOT NULL DEFAULT 1 CHECK (quantity > 0),
    unit_amount     NUMERIC(12,2)  NOT NULL,
    total_amount    NUMERIC(12,2)  NOT NULL
);

-- ============================================================
-- MANTENIMIENTO
-- ============================================================

-- ── ADR-14: maintenance_provider con contact_person_id ────────
CREATE TABLE maintenance_provider (
    maintenance_provider_id UUID         NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
    name                    VARCHAR(150) NOT NULL,
    contact_person_id       UUID         REFERENCES person(person_id),  -- ADR-14 (reemplaza contact_name varchar)
    address_id              UUID         REFERENCES address(address_id),
    is_active               BOOLEAN      NOT NULL DEFAULT true,
    created_at              TIMESTAMPTZ  NOT NULL DEFAULT NOW(),
    updated_at              TIMESTAMPTZ  NOT NULL DEFAULT NOW()
);

CREATE TABLE maintenance_record (
    maintenance_record_id   UUID        NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
    aircraft_id             UUID        NOT NULL REFERENCES aircraft(aircraft_id),
    maintenance_provider_id UUID        REFERENCES maintenance_provider(maintenance_provider_id),
    maintenance_status_id   UUID        NOT NULL REFERENCES maintenance_status(maintenance_status_id),
    description             TEXT,
    started_at              TIMESTAMPTZ NOT NULL,
    completed_at            TIMESTAMPTZ,
    created_at              TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    CONSTRAINT chk_maintenance_dates
        CHECK (completed_at IS NULL OR completed_at >= started_at)
);

-- ============================================================
-- ADR-12: HISTORIAL DE ESTADOS (trazabilidad IATA)
-- ============================================================

CREATE TABLE reservation_status_history (
    reservation_status_history_id UUID        NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
    reservation_id                UUID        NOT NULL REFERENCES reservation(reservation_id) ON DELETE CASCADE,
    from_status_id                UUID        REFERENCES reservation_status(reservation_status_id),  -- NULL = creación inicial
    to_status_id                  UUID        NOT NULL REFERENCES reservation_status(reservation_status_id),
    changed_by                    UUID        REFERENCES user_account(user_account_id),
    changed_at                    TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE ticket_status_history (
    ticket_status_history_id UUID        NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
    ticket_id                UUID        NOT NULL REFERENCES ticket(ticket_id) ON DELETE CASCADE,
    from_status_id           UUID        REFERENCES ticket_status(ticket_status_id),
    to_status_id             UUID        NOT NULL REFERENCES ticket_status(ticket_status_id),
    changed_by               UUID        REFERENCES user_account(user_account_id),
    changed_at               TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE payment_status_history (
    payment_status_history_id UUID        NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
    payment_id                UUID        NOT NULL REFERENCES payment(payment_id) ON DELETE CASCADE,
    from_status_id            UUID        REFERENCES payment_status(payment_status_id),
    to_status_id              UUID        NOT NULL REFERENCES payment_status(payment_status_id),
    changed_by                UUID        REFERENCES user_account(user_account_id),
    changed_at                TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
