CREATE OR REPLACE VIEW vw_rol_active AS
SELECT
    id,
    nombre,
    created_at,
    updated_at
FROM rol
WHERE deleted_at IS NULL;
