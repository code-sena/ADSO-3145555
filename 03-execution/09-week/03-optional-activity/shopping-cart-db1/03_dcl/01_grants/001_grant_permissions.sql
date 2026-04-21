-- ===================================================================
-- GRANTS BY ROLE
-- ===================================================================

-- ── app_admin: full access to all schemas ──────────────────────────
GRANT USAGE ON SCHEMA security, inventory, bill, shipping, payment, audit TO app_admin;
GRANT ALL PRIVILEGES ON ALL TABLES    IN SCHEMA security  TO app_admin;
GRANT ALL PRIVILEGES ON ALL TABLES    IN SCHEMA inventory TO app_admin;
GRANT ALL PRIVILEGES ON ALL TABLES    IN SCHEMA bill      TO app_admin;
GRANT ALL PRIVILEGES ON ALL TABLES    IN SCHEMA shipping  TO app_admin;
GRANT ALL PRIVILEGES ON ALL TABLES    IN SCHEMA payment   TO app_admin;
GRANT ALL PRIVILEGES ON ALL TABLES    IN SCHEMA audit     TO app_admin;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA security  TO app_admin;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA inventory TO app_admin;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA bill      TO app_admin;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA shipping  TO app_admin;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA payment   TO app_admin;

-- ── app_customer: read catalog + own orders/payments/shipping ──────
GRANT USAGE ON SCHEMA inventory, bill, shipping, payment TO app_customer;
GRANT SELECT ON inventory.category, inventory.product, inventory.inventory TO app_customer;
GRANT SELECT, INSERT ON bill.bill, bill.bill_item TO app_customer;
GRANT SELECT, INSERT ON shipping.address, shipping.shipment    TO app_customer;
GRANT SELECT, INSERT ON payment.payment_method, payment.payment TO app_customer;

-- ── app_seller: manage products & inventory ────────────────────────
GRANT USAGE ON SCHEMA inventory TO app_seller;
GRANT SELECT, INSERT, UPDATE ON inventory.category TO app_seller;
GRANT SELECT, INSERT, UPDATE ON inventory.product  TO app_seller;
GRANT SELECT, INSERT, UPDATE ON inventory.inventory TO app_seller;

-- ── app_warehouse: inventory control only ─────────────────────────
GRANT USAGE ON SCHEMA inventory TO app_warehouse;
GRANT SELECT, UPDATE ON inventory.inventory TO app_warehouse;
GRANT SELECT ON inventory.product           TO app_warehouse;

-- ── app_analyst: read-only on all business schemas ─────────────────
GRANT USAGE ON SCHEMA security, inventory, bill, shipping, payment TO app_analyst;
GRANT SELECT ON ALL TABLES IN SCHEMA inventory TO app_analyst;
GRANT SELECT ON ALL TABLES IN SCHEMA bill      TO app_analyst;
GRANT SELECT ON ALL TABLES IN SCHEMA shipping  TO app_analyst;
GRANT SELECT ON ALL TABLES IN SCHEMA payment   TO app_analyst;
GRANT SELECT ON security.role                  TO app_analyst;

-- ── app_auditor: read-only on audit + security ─────────────────────
GRANT USAGE ON SCHEMA audit, security TO app_auditor;
GRANT SELECT ON ALL TABLES IN SCHEMA audit    TO app_auditor;
GRANT SELECT ON security."user", security.role TO app_auditor;

-- ── app_support: read orders + users, limited updates ─────────────
GRANT USAGE ON SCHEMA security, bill, shipping TO app_support;
GRANT SELECT ON security."user"                TO app_support;
GRANT SELECT ON bill.bill, bill.bill_item      TO app_support;
GRANT SELECT, UPDATE ON shipping.shipment      TO app_support;
