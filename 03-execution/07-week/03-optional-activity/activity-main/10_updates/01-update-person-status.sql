UPDATE person
SET updated_at = NOW()
WHERE updated_at IS NULL
  AND deleted_at IS NULL;
