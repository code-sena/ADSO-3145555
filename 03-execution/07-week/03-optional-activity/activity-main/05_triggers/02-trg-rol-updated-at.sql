CREATE OR REPLACE FUNCTION fn_set_updated_at_rol()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_rol_updated_at
BEFORE UPDATE ON rol
FOR EACH ROW
EXECUTE FUNCTION fn_set_updated_at_rol();
