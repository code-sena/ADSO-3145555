DELETE FROM security."user"
WHERE username LIKE '%-____'
  AND email LIKE '%@github.com';
