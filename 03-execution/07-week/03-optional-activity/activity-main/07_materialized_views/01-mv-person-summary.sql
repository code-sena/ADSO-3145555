CREATE MATERIALIZED VIEW IF NOT EXISTS mv_person_summary AS
SELECT
    DATE_TRUNC('month', created_at) AS month,
    COUNT(*)                        AS total_persons
FROM person
WHERE deleted_at IS NULL
GROUP BY 1
ORDER BY 1;
