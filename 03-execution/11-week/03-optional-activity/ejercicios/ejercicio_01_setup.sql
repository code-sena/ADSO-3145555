-- ============================================================
-- ejercicio_01_setup.sql
-- Ejercicio 01 - Flujo de check-in y trazabilidad comercial
-- Dominios: SALES/RESERVATION/TICKETING, FLIGHT OPS, IDENTITY, BOARDING, SECURITY
-- ============================================================

-- ============================================================
-- REQUERIMIENTO 2: Función y Trigger AFTER INSERT sobre check_in
-- Al insertar un check_in, genera automáticamente el boarding_pass
-- ============================================================

CREATE OR REPLACE FUNCTION fn_generar_boarding_pass()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO boarding_pass (
        boarding_pass_id,
        check_in_id,
        boarding_pass_code,
        barcode_value,
        issued_at,
        created_at,
        updated_at
    )
    VALUES (
        gen_random_uuid(),
        NEW.check_in_id,
        'BP-' || upper(substring(NEW.check_in_id::text, 1, 8)),
        'BAR-' || upper(substring(NEW.check_in_id::text, 1, 16)) || '-' || to_char(NEW.checked_in_at, 'YYYYMMDD'),
        now(),
        now(),
        now()
    );
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger AFTER INSERT sobre check_in
DROP TRIGGER IF EXISTS trg_after_check_in_boarding_pass ON check_in;
CREATE TRIGGER trg_after_check_in_boarding_pass
    AFTER INSERT ON check_in
    FOR EACH ROW
    EXECUTE FUNCTION fn_generar_boarding_pass();


-- ============================================================
-- REQUERIMIENTO 3: Procedimiento almacenado para registrar check-in
-- Parámetros:
--   p_ticket_segment_id  : UUID del ticket_segment del pasajero
--   p_check_in_status_code : código del estado del check-in (ej: 'CHECKED_IN')
--   p_boarding_group_code  : código del grupo de abordaje (ej: 'A', 'B') - opcional
--   p_user_account_id      : UUID del usuario que registra
-- ============================================================

CREATE OR REPLACE PROCEDURE sp_registrar_check_in(
    p_ticket_segment_id   uuid,
    p_check_in_status_code varchar(20),
    p_boarding_group_code  varchar(10),
    p_user_account_id      uuid
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_check_in_status_id uuid;
    v_boarding_group_id  uuid;
BEGIN
    -- Obtener el ID del estado de check-in
    SELECT check_in_status_id
    INTO v_check_in_status_id
    FROM check_in_status
    WHERE status_code = p_check_in_status_code;

    IF v_check_in_status_id IS NULL THEN
        RAISE EXCEPTION 'Estado de check-in no encontrado: %', p_check_in_status_code;
    END IF;

    -- Obtener el ID del grupo de abordaje (si se proporcionó)
    IF p_boarding_group_code IS NOT NULL THEN
        SELECT boarding_group_id
        INTO v_boarding_group_id
        FROM boarding_group
        WHERE group_code = p_boarding_group_code;
    END IF;

    -- Insertar el check-in (esto dispara el trigger automáticamente)
    INSERT INTO check_in (
        check_in_id,
        ticket_segment_id,
        check_in_status_id,
        boarding_group_id,
        checked_in_by_user_id,
        checked_in_at,
        created_at,
        updated_at
    )
    VALUES (
        gen_random_uuid(),
        p_ticket_segment_id,
        v_check_in_status_id,
        v_boarding_group_id,
        p_user_account_id,
        now(),
        now(),
        now()
    );

    RAISE NOTICE 'Check-in registrado exitosamente para ticket_segment_id: %', p_ticket_segment_id;
END;
$$;
