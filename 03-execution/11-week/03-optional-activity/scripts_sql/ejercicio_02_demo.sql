DO $$
DECLARE
    v_payment_id          uuid;
    v_transaction_type    varchar := 'reversal';
    v_amount              numeric;
    v_processed_at        timestamptz := now();
    v_provider_message    varchar := 'Reversión procesada por proveedor externo';
BEGIN
    -- Buscar un pago en estado de reversión o cancelación
    SELECT p.payment_id, p.amount
    INTO v_payment_id, v_amount
    FROM payment p
    INNER JOIN payment_status ps
        ON ps.payment_status_id = p.payment_status_id
    WHERE lower(ps.status_code) IN ('reversed', 'refunded', 'cancelled')
    ORDER BY p.created_at
    LIMIT 1;

    -- Si no hay pago con ese estado, tomar cualquier pago disponible
    IF v_payment_id IS NULL THEN
        SELECT p.payment_id, p.amount
        INTO v_payment_id, v_amount
        FROM payment p
        ORDER BY p.created_at
        LIMIT 1;
    END IF;

    IF v_payment_id IS NULL THEN
        RAISE EXCEPTION 'No existe ningún pago disponible en el sistema.';
    END IF;

    -- Invocar el procedimiento de registro de transacción
    CALL sp_register_payment_transaction(
        v_payment_id,
        v_transaction_type,
        v_amount,
        v_processed_at,
        v_provider_message
    );
END;
$$;

-- Validación: verificar la transacción registrada y el refund generado por el trigger
SELECT
    pt.payment_transaction_id,
    pt.payment_id,
    pt.transaction_type,
    pt.amount,
    pt.processed_at,
    r.refund_id,
    r.refund_amount,
    r.refund_reason,
    r.refunded_at
FROM payment_transaction pt
LEFT JOIN refund r
    ON r.payment_transaction_id = pt.payment_transaction_id
ORDER BY pt.processed_at DESC
LIMIT 5;