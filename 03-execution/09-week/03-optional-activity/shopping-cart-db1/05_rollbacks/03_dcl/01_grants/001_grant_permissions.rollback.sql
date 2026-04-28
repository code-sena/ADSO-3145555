REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA security  FROM app_admin, app_customer, app_seller, app_warehouse, app_analyst, app_auditor, app_support;
REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA inventory FROM app_admin, app_customer, app_seller, app_warehouse, app_analyst, app_auditor, app_support;
REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA bill      FROM app_admin, app_customer, app_seller, app_warehouse, app_analyst, app_auditor, app_support;
REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA shipping  FROM app_admin, app_customer, app_seller, app_warehouse, app_analyst, app_auditor, app_support;
REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA payment   FROM app_admin, app_customer, app_seller, app_warehouse, app_analyst, app_auditor, app_support;
REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA audit     FROM app_admin, app_customer, app_seller, app_warehouse, app_analyst, app_auditor, app_support;
REVOKE USAGE ON SCHEMA security, inventory, bill, shipping, payment, audit FROM app_admin, app_customer, app_seller, app_warehouse, app_analyst, app_auditor, app_support;
