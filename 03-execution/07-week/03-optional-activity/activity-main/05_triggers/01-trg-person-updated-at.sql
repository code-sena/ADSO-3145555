CREATE OR REPLACE FUNCTION fn_set_updated_at_person()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_person_updated_at
BEFORE UPDATE ON person
FOR EACH ROW
EXECUTE FUNCTION fn_set_updated_at_person();
