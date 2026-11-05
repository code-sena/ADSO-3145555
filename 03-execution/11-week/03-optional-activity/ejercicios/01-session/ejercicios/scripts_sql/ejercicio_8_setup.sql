-- =====================================================
-- EJERCICIO 08 - SETUP
-- Auditoría de acceso y asignación de roles a usuarios
-- =====================================================

DROP TRIGGER IF EXISTS trg_ai_user_role_audit ON user_role;
DROP FUNCTION IF EXISTS fn_ai_user_role_audit();
DROP PROCEDURE IF EXISTS sp_assign_role_to_user(uuid, uuid, uuid, timestamptz);

CREATE OR REPLACE FUNCTION fn_ai_user_role_audit()
RETURNS trigger
LANGUAGE plpgsql
AS $$
DECLARE
    v_username varchar;
    v_role_name varchar;
BEGIN
    SELECT username INTO v_username FROM user_account WHERE user_account_id = NEW.user_account_id;
    SELECT role_name INTO v_role_name FROM security_role WHERE security_role_id = NEW.security_role_id;
    
    UPDATE user_account SET updated_at = NOW() WHERE user_account_id = NEW.user_account_id;
    
    RAISE NOTICE 'Usuario % asignado al rol %', v_username, v_role_name;
    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_ai_user_role_audit
AFTER INSERT ON user_role
FOR EACH ROW
EXECUTE FUNCTION fn_ai_user_role_audit();

CREATE OR REPLACE PROCEDURE sp_assign_role_to_user(
    p_user_account_id uuid,
    p_security_role_id uuid,
    p_assigned_by_user_id uuid DEFAULT NULL,
    p_assigned_at timestamptz DEFAULT NULL
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM user_account WHERE user_account_id = p_user_account_id) THEN
        RAISE EXCEPTION 'Usuario no existe';
    END IF;
    
    IF EXISTS (SELECT 1 FROM user_role WHERE user_account_id = p_user_account_id AND security_role_id = p_security_role_id) THEN
        RAISE EXCEPTION 'El usuario ya tiene este rol';
    END IF;
    
    INSERT INTO user_role (user_account_id, security_role_id, assigned_at, assigned_by_user_id)
    VALUES (p_user_account_id, p_security_role_id, COALESCE(p_assigned_at, NOW()), p_assigned_by_user_id);
END;
$$;

-- CONSULTA INNER JOIN
SELECT ua.username, sr.role_name, ur.assigned_at
FROM user_account ua
INNER JOIN user_role ur ON ur.user_account_id = ua.user_account_id
INNER JOIN security_role sr ON sr.security_role_id = ur.security_role_id;