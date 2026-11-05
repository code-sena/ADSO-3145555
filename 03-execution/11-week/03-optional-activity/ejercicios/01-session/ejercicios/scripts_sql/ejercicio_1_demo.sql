-- =====================================================
-- EJERCICIO 01 - DEMO
-- =====================================================

DO $$
DECLARE
    v_ticket_segment_id uuid;
    v_check_in_status_id uuid;
    v_boarding_group_id uuid;
    v_checked_in_by_user_id uuid;
BEGIN
    SELECT ts.ticket_segment_id INTO v_ticket_segment_id
    FROM ticket_segment ts
    LEFT JOIN check_in ci ON ci.ticket_segment_id = ts.ticket_segment_id
    WHERE ci.check_in_id IS NULL
    LIMIT 1;

    SELECT check_in_status_id INTO v_check_in_status_id
    FROM check_in_status LIMIT 1;

    SELECT boarding_group_id INTO v_boarding_group_id
    FROM boarding_group ORDER BY sequence_no LIMIT 1;

    SELECT user_account_id INTO v_checked_in_by_user_id
    FROM user_account LIMIT 1;

    IF v_ticket_segment_id IS NULL THEN
        RAISE EXCEPTION 'No hay ticket_segment disponible';
    END IF;

    CALL sp_register_check_in(
        v_ticket_segment_id,
        v_check_in_status_id,
        v_boarding_group_id,
        v_checked_in_by_user_id,
        NOW()
    );
END;
$$;

SELECT ci.check_in_id, ci.ticket_segment_id, bp.boarding_pass_code
FROM check_in ci
INNER JOIN boarding_pass bp ON bp.check_in_id = ci.check_in_id
ORDER BY ci.created_at DESC LIMIT 5;