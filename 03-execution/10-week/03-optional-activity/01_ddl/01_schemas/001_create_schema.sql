-- ============================================
-- SCHEMAS: 12 dominios funcionales
-- ============================================

CREATE SCHEMA IF NOT EXISTS geo;
CREATE SCHEMA IF NOT EXISTS airline;
CREATE SCHEMA IF NOT EXISTS identity;
CREATE SCHEMA IF NOT EXISTS security;
CREATE SCHEMA IF NOT EXISTS loyalty;
CREATE SCHEMA IF NOT EXISTS airport;
CREATE SCHEMA IF NOT EXISTS aircraft;
CREATE SCHEMA IF NOT EXISTS flight_ops;
CREATE SCHEMA IF NOT EXISTS sales;
CREATE SCHEMA IF NOT EXISTS boarding;
CREATE SCHEMA IF NOT EXISTS payment;
CREATE SCHEMA IF NOT EXISTS billing;

-- Permisos base
GRANT USAGE ON SCHEMA geo TO airline_user;
GRANT USAGE ON SCHEMA airline TO airline_user;
GRANT USAGE ON SCHEMA identity TO airline_user;
GRANT USAGE ON SCHEMA security TO airline_user;
GRANT USAGE ON SCHEMA loyalty TO airline_user;
GRANT USAGE ON SCHEMA airport TO airline_user;
GRANT USAGE ON SCHEMA aircraft TO airline_user;
GRANT USAGE ON SCHEMA flight_ops TO airline_user;
GRANT USAGE ON SCHEMA sales TO airline_user;
GRANT USAGE ON SCHEMA boarding TO airline_user;
GRANT USAGE ON SCHEMA payment TO airline_user;
GRANT USAGE ON SCHEMA billing TO airline_user;