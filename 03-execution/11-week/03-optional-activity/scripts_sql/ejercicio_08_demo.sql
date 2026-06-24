DO $$
DECLARE
    v_user_account_id    uuid;
    v_security_role_id   uuid;
    v_assigned_by        uuid;
    v_assigned_at        timestamptz := now();
BEGIN
    -- Buscar una cuenta de usuario que no tenga ningún rol asignado aún
    SELECT ua.user_account_id
    INTO v_user_account_id
    FROM user_account ua
    LEFT JOIN user_role ur
        ON ur.user_account_id = ua.user_account_id
    WHERE ur.user_role_id IS NULL
    ORDER BY ua.created_at
    LIMIT 1;

    -- Si todas tienen rol, tomar la primera cuenta sin rol duplicado disponible
    IF v_user_account_id IS NULL THEN
        SELECT ua.user_account_id
        INTO v_user_account_id
        FROM user_account ua
        ORDER BY ua.created_at
        LIMIT 1;
    END IF;

    -- Obtener el primer rol disponible en el sistema
    SELECT sr.security_role_id
    INTO v_security_role_id
    FROM security_role sr
    WHERE NOT EXISTS (
        SELECT 1
        FROM user_role ur
        WHERE ur.user_account_id = v_user_account_id
          AND ur.security_role_id = sr.security_role_id
    )
    ORDER BY sr.created_at
    LIMIT 1;

    -- Obtener el usuario que ejecutará la asignación (administrador del sistema)
    SELECT ua2.user_account_id
    INTO v_assigned_by
    FROM user_account ua2
    WHERE ua2.user_account_id != v_user_account_id
    ORDER BY ua2.created_at
    LIMIT 1;

    IF v_user_account_id IS NULL THEN
        RAISE EXCEPTION 'No existe ninguna cuenta de usuario disponible en el sistema.';
    END IF;

    IF v_security_role_id IS NULL THEN
        RAISE EXCEPTION 'No existe ningún rol disponible para asignar a esta cuenta.';
    END IF;

    -- Invocar el procedimiento de asignación de rol
    CALL sp_assign_user_role(
        v_user_account_id,
        v_security_role_id,
        v_assigned_by,
        v_assigned_at
    );
END;
$$;

-- Validación: verificar el rol asignado y el estado de la cuenta activado por el trigger
SELECT
    ua.user_account_id,
    ua.username,
    us.status_name              AS estado_cuenta_actualizado,
    sr.role_name                AS rol_asignado,
    ur.assigned_at,
    ur.assigned_by
FROM user_role ur
INNER JOIN user_account ua
    ON ua.user_account_id = ur.user_account_id
INNER JOIN user_status us
    ON us.user_status_id = ua.user_status_id
INNER JOIN security_role sr
    ON sr.security_role_id = ur.security_role_id
ORDER BY ur.assigned_at DESC
LIMIT 5;