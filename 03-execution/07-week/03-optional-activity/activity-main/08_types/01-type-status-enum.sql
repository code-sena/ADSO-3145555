DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'record_status') THEN
        CREATE TYPE record_status AS ENUM ('active', 'inactive', 'deleted');
    END IF;
END;
$$;
