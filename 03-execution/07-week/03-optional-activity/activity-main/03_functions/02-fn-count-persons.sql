CREATE OR REPLACE FUNCTION fn_count_persons()
RETURNS INT AS $$
DECLARE
    v_count INT;
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM person
    WHERE deleted_at IS NULL;
    RETURN v_count;
END;
$$ LANGUAGE plpgsql;
