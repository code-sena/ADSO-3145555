-- ============================================================
-- ejercicio_08_setup.sql
-- Ejercicio 08 - Auditoría de acceso y asignación de roles
-- Dominios: SECURITY, IDENTITY
-- ============================================================

-- REQUERIMIENTO 2: Función y Trigger AFTER INSERT sobre user_role
-- Al asignar un rol a un usuario, emite RAISE NOTICE con el total
-- de roles que tiene ese usuario (efecto verificable sin alterar el modelo)

CREATE OR REPLACE FUNCTION fn_log_asignacion_rol()
RETURNS TRIGGER AS $$
DECLARE
    v_username      varchar(80);
    v_role_name     varchar(100);
    v_total_roles   integer;
BEGIN
    SELECT ua.username INTO v_username
    FROM user_account ua WHERE ua.user_account_id = NEW.user_account_id;

    SELECT sr.role_name INTO v_role_name
    FROM security_role sr WHERE sr.security_role_id = NEW.security_role_id;

    SELECT count(*) INTO v_total_roles
    FROM user_role WHERE user_account_id = NEW.user_account_id;

    RAISE NOTICE 'Usuario [%] — nuevo rol asignado: [%]. Total roles activos: %',
        v_username, v_role_name, v_total_roles;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_after_user_role_log ON user_role;
CREATE TRIGGER trg_after_user_role_log
    AFTER INSERT ON user_role
    FOR EACH ROW
    EXECUTE FUNCTION fn_log_asignacion_rol();


-- REQUERIMIENTO 3: Procedimiento almacenado para asignar rol a usuario

CREATE OR REPLACE PROCEDURE sp_asignar_rol_usuario(
    p_user_account_id       uuid,
    p_security_role_id      uuid,
    p_assigned_by_user_id   uuid
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM user_account WHERE user_account_id = p_user_account_id) THEN
        RAISE EXCEPTION 'Usuario no encontrado: %', p_user_account_id;
    END IF;

    IF NOT EXISTS (SELECT 1 FROM security_role WHERE security_role_id = p_security_role_id) THEN
        RAISE EXCEPTION 'Rol no encontrado: %', p_security_role_id;
    END IF;

    IF EXISTS (
        SELECT 1 FROM user_role
        WHERE user_account_id = p_user_account_id
          AND security_role_id = p_security_role_id
    ) THEN
        RAISE NOTICE 'El usuario ya tiene asignado ese rol. No se duplica.';
        RETURN;
    END IF;

    INSERT INTO user_role (
        user_role_id,
        user_account_id,
        security_role_id,
        assigned_at,
        assigned_by_user_id,
        created_at,
        updated_at
    ) VALUES (
        gen_random_uuid(),
        p_user_account_id,
        p_security_role_id,
        now(),
        p_assigned_by_user_id,
        now(), now()
    );

    RAISE NOTICE 'Rol asignado exitosamente al usuario %', p_user_account_id;
END;
$$;
