INSERT INTO person (name, email, created_at)
VALUES
    ('Jose Montealegre', 'montealegrejose254@gmail.com', NOW()),
    ('Admin User',       'admin@example.com',            NOW())
ON CONFLICT (email) DO NOTHING;
