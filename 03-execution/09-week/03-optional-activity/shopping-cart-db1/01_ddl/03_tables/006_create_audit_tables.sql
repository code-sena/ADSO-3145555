-- Audit / traceability module

CREATE TABLE IF NOT EXISTS audit.event_log (
    id            UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    schema_name   VARCHAR(100) NOT NULL,
    table_name    VARCHAR(100) NOT NULL,
    operation     VARCHAR(10)  NOT NULL,   -- INSERT, UPDATE, DELETE
    record_id     UUID,
    old_data      JSONB,
    new_data      JSONB,
    performed_by  VARCHAR(100),
    performed_at  TIMESTAMP NOT NULL DEFAULT NOW(),
    ip_address    VARCHAR(45),
    session_id    VARCHAR(200)
);

CREATE TABLE IF NOT EXISTS audit.login_log (
    id            UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id       UUID,
    username      VARCHAR(100),
    success       BOOLEAN NOT NULL,
    ip_address    VARCHAR(45),
    user_agent    TEXT,
    attempted_at  TIMESTAMP NOT NULL DEFAULT NOW()
);
