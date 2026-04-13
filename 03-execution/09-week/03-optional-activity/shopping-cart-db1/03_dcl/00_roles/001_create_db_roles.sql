-- PostgreSQL database roles for each application role

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'app_admin') THEN
    CREATE ROLE app_admin LOGIN PASSWORD 'Admin@2025!';
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'app_customer') THEN
    CREATE ROLE app_customer LOGIN PASSWORD 'Customer@2025!';
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'app_seller') THEN
    CREATE ROLE app_seller LOGIN PASSWORD 'Seller@2025!';
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'app_warehouse') THEN
    CREATE ROLE app_warehouse LOGIN PASSWORD 'Warehouse@2025!';
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'app_analyst') THEN
    CREATE ROLE app_analyst LOGIN PASSWORD 'Analyst@2025!';
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'app_auditor') THEN
    CREATE ROLE app_auditor LOGIN PASSWORD 'Auditor@2025!';
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'app_support') THEN
    CREATE ROLE app_support LOGIN PASSWORD 'Support@2025!';
  END IF;
END
$$;
