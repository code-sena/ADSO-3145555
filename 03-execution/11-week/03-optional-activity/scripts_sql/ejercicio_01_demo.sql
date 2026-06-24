DO $$
DECLARE
    v_ticket_segment_id       uuid;
    v_check_in_status_id      uuid;
    v_boarding_group_id       uuid;
    v_checked_in_by_user_id   uuid;
BEGIN
    -- Buscar un ticket_segment que aún no tenga check-in registrado
    SELECT ts.ticket_segment_id
    INTO v_ticket_segment_id
    FROM ticket_segment ts
    LEFT JOIN check_in ci
        ON ci.ticket_segment_id = ts.ticket_segment_id
    WHERE ci.check_in_id IS NULL
    ORDER BY ts.created_at
    LIMIT 1;

    -- Obtener el primer check_in_status disponible
    SELECT cis.check_in_status_id
    INTO v_check_in_status_id
    FROM check_in_status cis
    ORDER BY cis.created_at
    LIMIT 1;

    -- Obtener el boarding_group con menor número de secuencia
    SELECT bg.boarding_group_id
    INTO v_boarding_group_id
    FROM boarding_group bg
    ORDER BY bg.sequence_no
    LIMIT 1;

    -- Obtener el primer usuario del sistema
    SELECT ua.user_account_id
    INTO v_checked_in_by_user_id
    FROM user_account ua
    ORDER BY ua.created_at
    LIMIT 1;

    -- Validaciones previas
    IF v_ticket_segment_id IS NULL THEN
        RAISE EXCEPTION 'No existe ticket_segment disponible sin check-in.';
    END IF;

    IF v_check_in_status_id IS NULL THEN
        RAISE EXCEPTION 'No existe check_in_status cargado.';
    END IF;

    IF v_checked_in_by_user_id IS NULL THEN
        RAISE EXCEPTION 'No existe user_account disponible.';
    END IF;

    -- Invocar el procedimiento de registro de check-in
    CALL sp_register_check_in(
        v_ticket_segment_id,
        v_check_in_status_id,
        v_boarding_group_id,
        v_checked_in_by_user_id,
        now()
    );
END;
$$;

-- Validación: verificar el check-in registrado y el boarding_pass generado por el trigger
SELECT
    ci.check_in_id,
    ci.ticket_segment_id,
    ci.checked_in_at,
    bp.boarding_pass_id,
    bp.boarding_pass_code,
    bp.barcode_value
FROM check_in ci
INNER JOIN boarding_pass bp
    ON bp.check_in_id = ci.check_in_id
ORDER BY ci.created_at DESC
LIMIT 5;