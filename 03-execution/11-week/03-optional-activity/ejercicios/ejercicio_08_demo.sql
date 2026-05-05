-- ============================================================
-- ejercicio_08_demo.sql
-- Ejercicio 08 - Script de demostración y validación
-- ============================================================

-- REQUERIMIENTO 1: Consulta INNER JOIN mínimo 5 tablas
-- Flujo: person > user_account > user_status > user_role >
--        security_role > role_permission > security_permission

SELECT
    p.first_name || ' ' || p.last_name      AS persona,
    ua.username                              AS usuario,
    us.status_name                           AS estado_usuario,
    sr.role_name                             AS rol_asignado,
    ur.assigned_at                           AS fecha_asignacion,
    sp.permission_name                       AS permiso_asociado
FROM person p
    INNER JOIN user_account ua      ON ua.person_id             = p.person_id
    INNER JOIN user_status us       ON us.user_status_id        = ua.user_status_id
    INNER JOIN user_role ur         ON ur.user_account_id       = ua.user_account_id
    INNER JOIN security_role sr     ON sr.security_role_id      = ur.security_role_id
    INNER JOIN role_permission rp   ON rp.security_role_id      = sr.security_role_id
    INNER JOIN security_permission sp ON sp.security_permission_id = rp.security_permission_id
ORDER BY ua.username, sr.role_name;


-- DEMOSTRACIÓN DEL TRIGGER Y PROCEDIMIENTO

-- Paso 1: Ver usuarios y roles disponibles
SELECT ua.user_account_id, ua.username, p.first_name || ' ' || p.last_name AS nombre
FROM user_account ua INNER JOIN person p ON p.person_id = ua.person_id LIMIT 5;

SELECT security_role_id, role_code, role_name FROM security_role LIMIT 5;

-- Paso 2: Invocar el procedimiento
-- (Reemplaza los UUIDs con los valores reales obtenidos arriba)
CALL sp_asignar_rol_usuario(
    '00000000-0000-0000-0000-000000000001',  -- reemplazar: user_account_id real
    '00000000-0000-0000-0000-000000000002',  -- reemplazar: security_role_id real
    NULL                                      -- o UUID del usuario asignador
);

-- Paso 3: Validar que el rol quedó asignado y el trigger se ejecutó
SELECT
    ua.username,
    sr.role_name,
    ur.assigned_at,
    (SELECT username FROM user_account WHERE user_account_id = ur.assigned_by_user_id) AS asignado_por
FROM user_role ur
    INNER JOIN user_account ua  ON ua.user_account_id  = ur.user_account_id
    INNER JOIN security_role sr ON sr.security_role_id = ur.security_role_id
ORDER BY ur.created_at DESC
LIMIT 10;
