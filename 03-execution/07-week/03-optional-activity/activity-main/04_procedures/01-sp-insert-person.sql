CREATE OR REPLACE PROCEDURE sp_insert_person(
    p_name  VARCHAR,
    p_email VARCHAR
)
LANGUAGE plpgsql AS $$
BEGIN
    INSERT INTO person (name, email, created_at)
    VALUES (p_name, p_email, NOW());
END;
$$;
