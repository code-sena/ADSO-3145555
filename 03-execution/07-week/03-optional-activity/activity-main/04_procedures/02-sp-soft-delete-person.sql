CREATE OR REPLACE PROCEDURE sp_soft_delete_person(
    p_id INT
)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE person
    SET deleted_at = NOW()
    WHERE id = p_id;
END;
$$;
