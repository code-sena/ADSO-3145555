INSERT INTO rol (nombre, created_at)
VALUES
    ('admin',   NOW()),
    ('editor',  NOW()),
    ('viewer',  NOW())
ON CONFLICT DO NOTHING;
