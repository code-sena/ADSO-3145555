-- ============================================================
-- ejercicio_02_setup.sql
-- Ejercicio 02 - Control de pagos y trazabilidad de transacciones
-- Dominios: SALES/TICKETING, PAYMENT, BILLING, GEOGRAPHY
-- ============================================================

-- REQUERIMIENTO 2: Función y Trigger AFTER INSERT sobre payment_transaction
-- Al insertar una transacción de tipo 'REVERSAL', genera automáticamente un refund

CREATE OR REPLACE FUNCTION fn_generar_refund_por_reversal()
RETURNS TRIGGER AS $$
DECLARE
    v_amount numeric(12,2);
BEGIN
    IF NEW.transaction_type = 'REVERSAL' THEN
        SELECT amount INTO v_amount FROM payment WHERE payment_id = NEW.payment_id;
        INSERT INTO refund (
            refund_id, payment_id, refund_reference,
            amount, requested_at, created_at, updated_at
        ) VALUES (
            gen_random_uuid(),
            NEW.payment_id,
            'REF-' || upper(substring(NEW.payment_transaction_id::text, 1, 12)),
            NEW.transaction_amount,
            now(), now(), now()
        );
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_after_payment_transaction_refund ON payment_transaction;
CREATE TRIGGER trg_after_payment_transaction_refund
    AFTER INSERT ON payment_transaction
    FOR EACH ROW
    EXECUTE FUNCTION fn_generar_refund_por_reversal();


-- REQUERIMIENTO 3: Procedimiento almacenado para registrar transacción de pago
-- Parámetros:
--   p_payment_id           : UUID del pago existente
--   p_transaction_type     : tipo de transacción (ej: 'CHARGE', 'REVERSAL')
--   p_transaction_amount   : monto procesado
--   p_transaction_reference: referencia externa

CREATE OR REPLACE PROCEDURE sp_registrar_transaccion_pago(
    p_payment_id            uuid,
    p_transaction_type      varchar(20),
    p_transaction_amount    numeric(12,2),
    p_transaction_reference varchar(60)
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM payment WHERE payment_id = p_payment_id) THEN
        RAISE EXCEPTION 'Pago no encontrado: %', p_payment_id;
    END IF;

    INSERT INTO payment_transaction (
        payment_transaction_id, payment_id, transaction_reference,
        transaction_type, transaction_amount, processed_at,
        created_at, updated_at
    ) VALUES (
        gen_random_uuid(),
        p_payment_id,
        p_transaction_reference,
        p_transaction_type,
        p_transaction_amount,
        now(), now(), now()
    );

    RAISE NOTICE 'Transacción % registrada para payment_id: %', p_transaction_type, p_payment_id;
END;
$$;
