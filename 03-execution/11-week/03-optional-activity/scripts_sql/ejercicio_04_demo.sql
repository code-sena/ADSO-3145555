DO $$
DECLARE
    v_loyalty_account_id   uuid;
    v_transaction_type     varchar := 'accrual';
    v_miles_amount         numeric := 5000;
    v_transaction_date     timestamptz := now();
    v_notes                varchar := 'Acumulación por vuelo operado - registro automático';
BEGIN
    -- Buscar una cuenta de fidelización activa disponible
    SELECT la.loyalty_account_id
    INTO v_loyalty_account_id
    FROM loyalty_account la
    ORDER BY la.created_at
    LIMIT 1;

    IF v_loyalty_account_id IS NULL THEN
        RAISE EXCEPTION 'No existe ninguna cuenta de fidelización disponible en el sistema.';
    END IF;

    -- Invocar el procedimiento de registro de transacción de millas
    CALL sp_register_miles_transaction(
        v_loyalty_account_id,
        v_transaction_type,
        v_miles_amount,
        v_transaction_date,
        v_notes
    );
END;
$$;

-- Validación: verificar la transacción registrada y el tier actualizado por el trigger
SELECT
    mt.miles_transaction_id,
    mt.loyalty_account_id,
    mt.transaction_type,
    mt.miles_amount,
    mt.transaction_date,
    mt.notes,
    lat.loyalty_tier_id,
    lt.tier_name              AS nivel_asignado,
    lat.start_date            AS inicio_nivel,
    lat.end_date              AS fin_nivel
FROM miles_transaction mt
INNER JOIN loyalty_account_tier lat
    ON lat.loyalty_account_id = mt.loyalty_account_id
    AND lat.end_date IS NULL
INNER JOIN loyalty_tier lt
    ON lt.loyalty_tier_id = lat.loyalty_tier_id
WHERE mt.loyalty_account_id = (
    SELECT loyalty_account_id
    FROM miles_transaction
    ORDER BY created_at DESC
    LIMIT 1
)
ORDER BY mt.transaction_date DESC
LIMIT 5;