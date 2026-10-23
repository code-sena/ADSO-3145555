CREATE OR REPLACE VIEW vw_person_active AS
SELECT
    id,
    name,
    email,
    created_at,
    updated_at
FROM person
WHERE deleted_at IS NULL;
