-- =====================================================
-- EJERCICIO 08 - DEMO
-- =====================================================

DO $$
DECLARE
    v_user_account_id uuid;
    v_security_role_id uuid;
BEGIN
    SELECT user_account_id INTO v_user_account_id FROM user_account LIMIT 1;
    SELECT security_role_id INTO v_security_role_id FROM security_role LIMIT 1;
    
    CALL sp_assign_role_to_user(v_user_account_id, v_security_role_id, v_user_account_id, NOW());
END;
$$;

SELECT ua.username, sr.role_name
FROM user_role ur
INNER JOIN user_account ua ON ua.user_account_id = ur.user_account_id
INNER JOIN security_role sr ON sr.security_role_id = ur.security_role_id
ORDER BY ur.created_at DESC LIMIT 5;