-- ============================================================
-- 03_INDICES.sql | Índices
-- Proyecto: Airline Schema v3
-- Motor: PostgreSQL
-- Incluye: ADR-08, ADR-09, ADR-12, ADR-16 + índices operacionales
-- ============================================================

-- ============================================================
-- ADR-08 — Índice para soft-delete en address
-- ============================================================
CREATE INDEX idx_address_is_active
    ON address(is_active);

-- ============================================================
-- ADR-09 — Índice parcial en fare para tarifas vigentes
-- ============================================================
CREATE INDEX idx_fare_current
    ON fare(airline_id, origin_airport_id, destination_airport_id)
    WHERE is_current = true;

-- ============================================================
-- ADR-12 — Índices en tablas de historial de estados
-- ============================================================
CREATE INDEX idx_res_status_hist_reservation
    ON reservation_status_history(reservation_id, changed_at DESC);

CREATE INDEX idx_ticket_status_hist_ticket
    ON ticket_status_history(ticket_id, changed_at DESC);

CREATE INDEX idx_payment_status_hist_payment
    ON payment_status_history(payment_id, changed_at DESC);

-- ============================================================
-- ADR-16 — Índice en person(last_name, first_name)
-- ============================================================
CREATE INDEX idx_person_name
    ON person(last_name, first_name);

-- ============================================================
-- ÍNDICES OPERACIONALES ADICIONALES
-- ============================================================

-- person
CREATE INDEX idx_person_passport
    ON person(passport_number)
    WHERE passport_number IS NOT NULL;

-- reservation
CREATE INDEX idx_reservation_booking_ref
    ON reservation(booking_reference);

CREATE INDEX idx_reservation_status
    ON reservation(reservation_status_id);

-- ticket
CREATE INDEX idx_ticket_reservation
    ON ticket(reservation_id);

CREATE INDEX idx_ticket_person
    ON ticket(person_id);

CREATE INDEX idx_ticket_status
    ON ticket(ticket_status_id);

-- ticket_segment
CREATE INDEX idx_ticket_segment_ticket
    ON ticket_segment(ticket_id);

CREATE INDEX idx_ticket_segment_flight
    ON ticket_segment(scheduled_flight_id);

-- seat_assignment
CREATE INDEX idx_seat_assignment_segment
    ON seat_assignment(ticket_segment_id);

CREATE INDEX idx_seat_assignment_seat
    ON seat_assignment(seat_id);

-- boarding_pass
CREATE INDEX idx_boarding_pass_segment
    ON boarding_pass(ticket_segment_id);

CREATE INDEX idx_boarding_pass_barcode
    ON boarding_pass(barcode);

-- boarding_validation
CREATE INDEX idx_boarding_validation_pass
    ON boarding_validation(boarding_pass_id);

-- baggage
CREATE INDEX idx_baggage_ticket
    ON baggage(ticket_id);

CREATE INDEX idx_baggage_tag
    ON baggage(tag_number)
    WHERE tag_number IS NOT NULL;

-- scheduled_flight
CREATE INDEX idx_scheduled_flight_route
    ON scheduled_flight(flight_route_id);

CREATE INDEX idx_scheduled_flight_departure
    ON scheduled_flight(scheduled_departure);

-- fare
CREATE INDEX idx_fare_airline
    ON fare(airline_id);

-- loyalty_account
CREATE INDEX idx_loyalty_person_airline
    ON loyalty_account(person_id, airline_id);

-- miles_transaction
CREATE INDEX idx_miles_loyalty
    ON miles_transaction(loyalty_account_id);

CREATE INDEX idx_miles_ticket
    ON miles_transaction(ticket_id)
    WHERE ticket_id IS NOT NULL;

-- payment
CREATE INDEX idx_payment_reservation
    ON payment(reservation_id);

-- payment_transaction
CREATE INDEX idx_payment_transaction_payment
    ON payment_transaction(payment_id);

-- exchange_rate
CREATE INDEX idx_exchange_rate_currencies
    ON exchange_rate(from_currency, to_currency, valid_at DESC);

-- maintenance_record
CREATE INDEX idx_maintenance_aircraft
    ON maintenance_record(aircraft_id);

-- user_account
CREATE INDEX idx_user_account_person
    ON user_account(person_id);

CREATE UNIQUE INDEX idx_user_account_username
    ON user_account(username);
