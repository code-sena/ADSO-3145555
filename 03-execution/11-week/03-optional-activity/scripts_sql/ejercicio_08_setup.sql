DROP TRIGGER IF EXISTS trg_ai_user_role_activate_user_account ON user_role;
DROP FUNCTION IF EXISTS fn_ai_user_role_activate_user_account();
DROP PROCEDURE IF EXISTS sp_assign_user_role(uuid, uuid, uuid, timestamptz);

CREATE OR REPLACE FUNCTION fn_ai_user_role_activate_user_account()
RETURNS trigger
LANGUAGE plpgsql
AS $$
DECLARE
    v_active_status_id   uuid;
BEGIN
    -- Buscar el user_status correspondiente a 'active'
    SELECT us.user_status_id
    INTO v_active_status_id
    FROM user_status us
    WHERE lower(us.status_code) IN ('active', 'activo', 'enabled')
    ORDER BY us.created_at
    LIMIT 1;

    IF v_active_status_id IS NULL THEN
        RETURN NEW;
    END IF;

    -- Al asignarse un rol, asegurar que la cuenta de usuario quede en estado activo
    UPDATE user_account
    SET user_status_id = v_active_status_id
    WHERE user_account_id = NEW.user_account_id;

    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_ai_user_role_activate_user_account
AFTER INSERT ON user_role
FOR EACH ROW
EXECUTE FUNCTION fn_ai_user_role_activate_user_account();

CREATE OR REPLACE PROCEDURE sp_assign_user_role(
    p_user_account_id    uuid,
    p_security_role_id   uuid,
    p_assigned_by        uuid,
    p_assigned_at        timestamptz
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM user_account ua
        WHERE ua.user_account_id = p_user_account_id
    ) THEN
        RAISE EXCEPTION 'No existe una cuenta de usuario con user_account_id %', p_user_account_id;
    END IF;

    IF NOT EXISTS (
        SELECT 1
        FROM security_role sr
        WHERE sr.security_role_id = p_security_role_id
    ) THEN
        RAISE EXCEPTION 'No existe un rol con security_role_id %', p_security_role_id;
    END IF;

    IF EXISTS (
        SELECT 1
        FROM user_role ur
        WHERE ur.user_account_id = p_user_account_id
          AND ur.security_role_id = p_security_role_id
    ) THEN
        RAISE EXCEPTION 'El usuario % ya tiene asignado el rol %', p_user_account_id, p_security_role_id;
    END IF;

    INSERT INTO user_role (
        user_account_id,
        security_role_id,
        assigned_by,
        assigned_at
    )
    VALUES (
        p_user_account_id,
        p_security_role_id,
        p_assigned_by,
        p_assigned_at
    );
END;
$$;

-- Consulta resuelta: mapa de autorización persona-usuario-estado-rol-permiso
SELECT
    p.first_name,
    p.last_name,
    ua.username,
    us.status_name              AS estado_usuario,
    sr.role_name                AS rol_asignado,
    ur.assigned_at              AS fecha_asignacion,
    sp.permission_name          AS permiso_asociado
FROM person p
INNER JOIN user_account ua
    ON ua.person_id = p.person_id
INNER JOIN user_status us
    ON us.user_status_id = ua.user_status_id
INNER JOIN user_role ur
    ON ur.user_account_id = ua.user_account_id
INNER JOIN security_role sr
    ON sr.security_role_id = ur.security_role_id
INNER JOIN role_permission rp
    ON rp.security_role_id = sr.security_role_id
INNER JOIN security_permission sp
    ON sp.security_permission_id = rp.security_permission_id
ORDER BY p.last_name, p.first_name, sr.role_name, sp.permission_name;