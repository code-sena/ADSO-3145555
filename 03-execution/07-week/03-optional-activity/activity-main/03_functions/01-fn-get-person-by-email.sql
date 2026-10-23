CREATE OR REPLACE FUNCTION fn_get_person_by_email(p_email VARCHAR)
RETURNS TABLE (
    id INT,
    name VARCHAR,
    email VARCHAR,
    created_at TIMESTAMPTZ
) AS $$
BEGIN
    RETURN QUERY
    SELECT p.id, p.name, p.email, p.created_at
    FROM person p
    WHERE p.email = p_email
      AND p.deleted_at IS NULL;
END;
$$ LANGUAGE plpgsql;
