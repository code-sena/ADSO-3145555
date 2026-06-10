-- ============================================================
-- 05_DML_SEED.sql | Datos iniciales (seed) para tablas lookup
-- Proyecto: Airline Schema v3
-- Motor: PostgreSQL
-- IMPORTANTE: Ejecutar antes de insertar datos operacionales
-- ============================================================

-- ============================================================
-- CATÁLOGOS BASE
-- ============================================================

INSERT INTO seat_class (code, name) VALUES
    ('ECONOMY',  'Economy Class'),
    ('PREMIUM_E','Premium Economy'),
    ('BUSINESS', 'Business Class'),
    ('FIRST',    'First Class');

INSERT INTO contact_type (code, name) VALUES
    ('MOBILE',     'Mobile Phone'),
    ('HOME_PHONE', 'Home Phone'),
    ('WORK_PHONE', 'Work Phone'),
    ('EMAIL',      'Email Address'),
    ('WORK_EMAIL', 'Work Email');

INSERT INTO reservation_status (code, name) VALUES
    ('PENDING',   'Pending Confirmation'),
    ('CONFIRMED', 'Confirmed'),
    ('CANCELLED', 'Cancelled'),
    ('COMPLETED', 'Completed'),
    ('ON_HOLD',   'On Hold');

INSERT INTO ticket_status (code, name) VALUES
    ('ISSUED',     'Issued'),
    ('VOID',       'Void'),
    ('REFUNDED',   'Refunded'),
    ('EXCHANGED',  'Exchanged'),
    ('USED',       'Used / Flown');

INSERT INTO payment_status (code, name) VALUES
    ('PENDING',    'Payment Pending'),
    ('AUTHORIZED', 'Authorized'),
    ('CAPTURED',   'Captured'),
    ('FAILED',     'Failed'),
    ('REFUNDED',   'Refunded'),
    ('CANCELLED',  'Cancelled');

INSERT INTO refund_status (code, name) VALUES
    ('REQUESTED', 'Refund Requested'),
    ('APPROVED',  'Approved'),
    ('PROCESSED', 'Processed'),
    ('REJECTED',  'Rejected');

INSERT INTO miles_transaction_type (code, name) VALUES
    ('EARN',   'Miles Earned from Flight'),
    ('REDEEM', 'Miles Redeemed'),
    ('ADJUST', 'Manual Adjustment'),
    ('EXPIRE', 'Miles Expired'),
    ('BONUS',  'Bonus Miles');

INSERT INTO maintenance_status (code, name) VALUES
    ('SCHEDULED',   'Scheduled'),
    ('IN_PROGRESS', 'In Progress'),
    ('COMPLETED',   'Completed'),
    ('CANCELLED',   'Cancelled');

-- ============================================================
-- ADR-02 — passenger_type seed
-- ============================================================
INSERT INTO passenger_type (code, name) VALUES
    ('ADULT',               'Adult (12+ years)'),
    ('CHILD',               'Child (2–11 years)'),
    ('INFANT',              'Infant (under 2 years)'),
    ('UNACCOMPANIED_MINOR', 'Unaccompanied Minor');

-- ============================================================
-- ADR-03 — baggage_type y baggage_status seed
-- ============================================================
INSERT INTO baggage_type (code, name) VALUES
    ('CHECKED',    'Checked Baggage'),
    ('CARRY_ON',   'Carry-On Baggage'),
    ('OVERSIZED',  'Oversized Baggage'),
    ('SPORTS',     'Sports Equipment'),
    ('PET',        'Pet Carrier');

INSERT INTO baggage_status (code, name) VALUES
    ('CHECKED_IN', 'Checked In'),
    ('LOADED',     'Loaded on Aircraft'),
    ('IN_TRANSIT', 'In Transit'),
    ('DELIVERED',  'Delivered to Passenger'),
    ('DAMAGED',    'Damaged'),
    ('DELAYED',    'Delayed'),
    ('LOST',       'Lost');

-- ============================================================
-- ADR-04 — seat_assignment_source seed
-- ============================================================
INSERT INTO seat_assignment_source (code, name) VALUES
    ('AUTO',     'Automatic System Assignment'),
    ('MANUAL',   'Manual Agent Assignment'),
    ('CUSTOMER', 'Customer Self-Selection'),
    ('KIOSK',    'Check-in Kiosk'),
    ('API',      'API / Third-party Integration');

-- ============================================================
-- ADR-05 — boarding_validation_result seed
-- ============================================================
INSERT INTO boarding_validation_result (code, name) VALUES
    ('APPROVED',      'Approved for Boarding'),
    ('REJECTED',      'Rejected'),
    ('MANUAL_REVIEW', 'Manual Review Required'),
    ('EXPIRED',       'Boarding Pass Expired'),
    ('DUPLICATE',     'Duplicate Scan Detected');

-- ============================================================
-- ADR-06 — payment_transaction_type seed
-- ============================================================
INSERT INTO payment_transaction_type (code, name) VALUES
    ('AUTH',       'Authorization'),
    ('CAPTURE',    'Capture'),
    ('VOID',       'Void'),
    ('REFUND',     'Refund'),
    ('REVERSAL',   'Reversal'),
    ('CHARGEBACK', 'Chargeback');

-- ============================================================
-- ADR-11 — exchange_rate_type seed
-- ============================================================
INSERT INTO exchange_rate_type (code, name) VALUES
    ('MID',      'Mid-Market Rate'),
    ('BUY',      'Buy Rate'),
    ('SELL',     'Sell Rate'),
    ('OFFICIAL', 'Official Government Rate'),
    ('PARALLEL', 'Parallel / Black Market Rate');

-- ============================================================
-- FUENTES DE TASA DE CAMBIO (preexistente)
-- ============================================================
INSERT INTO exchange_rate_source (code, name) VALUES
    ('ECB',       'European Central Bank'),
    ('REUTERS',   'Reuters'),
    ('BLOOMBERG', 'Bloomberg'),
    ('MANUAL',    'Manual Entry');

-- ============================================================
-- PAÍSES BASE
-- ============================================================
INSERT INTO country (iso_code, iso_code_3, name) VALUES
    ('CO', 'COL', 'Colombia'),
    ('US', 'USA', 'United States'),
    ('MX', 'MEX', 'Mexico'),
    ('BR', 'BRA', 'Brazil'),
    ('AR', 'ARG', 'Argentina'),
    ('ES', 'ESP', 'Spain'),
    ('DE', 'DEU', 'Germany'),
    ('GB', 'GBR', 'United Kingdom'),
    ('FR', 'FRA', 'France'),
    ('PA', 'PAN', 'Panama');

-- ============================================================
-- VERIFICACIÓN DEL SEED
-- ============================================================
SELECT 'passenger_type'             AS tabla, COUNT(*) AS registros FROM passenger_type
UNION ALL
SELECT 'baggage_type',               COUNT(*) FROM baggage_type
UNION ALL
SELECT 'baggage_status',             COUNT(*) FROM baggage_status
UNION ALL
SELECT 'seat_assignment_source',     COUNT(*) FROM seat_assignment_source
UNION ALL
SELECT 'boarding_validation_result', COUNT(*) FROM boarding_validation_result
UNION ALL
SELECT 'payment_transaction_type',   COUNT(*) FROM payment_transaction_type
UNION ALL
SELECT 'exchange_rate_type',         COUNT(*) FROM exchange_rate_type
UNION ALL
SELECT 'reservation_status',         COUNT(*) FROM reservation_status
UNION ALL
SELECT 'ticket_status',              COUNT(*) FROM ticket_status
UNION ALL
SELECT 'payment_status',             COUNT(*) FROM payment_status
ORDER BY tabla;
