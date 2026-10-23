-- =====================================================
-- EJERCICIO 02 - SETUP
-- Control de pagos y trazabilidad de transacciones financieras
-- =====================================================

DROP TRIGGER IF EXISTS trg_au_payment_create_refund ON payment;
DROP FUNCTION IF EXISTS fn_au_payment_create_refund();
DROP PROCEDURE IF EXISTS sp_register_payment_transaction(uuid, varchar, numeric, timestamptz, text);

CREATE OR REPLACE FUNCTION fn_au_payment_create_refund()
RETURNS trigger
LANGUAGE plpgsql
AS $$
DECLARE
    v_refund_reference varchar(40);
BEGIN
    IF NEW.payment_status_id IN (
        SELECT payment_status_id FROM payment_status WHERE status_code IN ('CANCELLED', 'REFUNDED')
    ) AND OLD.payment_status_id != NEW.payment_status_id THEN
        
        IF EXISTS (SELECT 1 FROM refund WHERE payment_id = NEW.payment_id) THEN
            RETURN NEW;
        END IF;
        
        v_refund_reference := 'REF-' || replace(NEW.payment_id::text, '-', '');
        v_refund_reference := left(v_refund_reference, 40);
        
        INSERT INTO refund (payment_id, refund_reference, amount, requested_at, processed_at, refund_reason)
        VALUES (NEW.payment_id, v_refund_reference, NEW.amount, NOW(), NOW(), 'Refund automático');
    END IF;
    
    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_au_payment_create_refund
AFTER UPDATE ON payment
FOR EACH ROW
EXECUTE FUNCTION fn_au_payment_create_refund();

CREATE OR REPLACE PROCEDURE sp_register_payment_transaction(
    p_payment_id uuid,
    p_transaction_type varchar,
    p_transaction_amount numeric,
    p_processed_at timestamptz,
    p_provider_message text DEFAULT NULL
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_transaction_reference varchar(60);
    v_payment_status_id uuid;
BEGIN
    IF NOT EXISTS (SELECT 1 FROM payment WHERE payment_id = p_payment_id) THEN
        RAISE EXCEPTION 'Pago no existe';
    END IF;
    
    IF p_transaction_type NOT IN ('AUTH', 'CAPTURE', 'VOID', 'REFUND', 'REVERSAL') THEN
        RAISE EXCEPTION 'Tipo inválido';
    END IF;
    
    v_transaction_reference := 'TXN-' || replace(gen_random_uuid()::text, '-', '');
    v_transaction_reference := left(v_transaction_reference, 60);
    
    INSERT INTO payment_transaction (payment_id, transaction_reference, transaction_type, transaction_amount, processed_at, provider_message)
    VALUES (p_payment_id, v_transaction_reference, p_transaction_type, p_transaction_amount, p_processed_at, p_provider_message);
    
    IF p_transaction_type = 'REFUND' THEN
        SELECT payment_status_id INTO v_payment_status_id FROM payment_status WHERE status_code = 'REFUNDED';
        UPDATE payment SET payment_status_id = v_payment_status_id WHERE payment_id = p_payment_id;
    END IF;
END;
$$;

-- CONSULTA INNER JOIN
SELECT s.sale_code, p.payment_reference, ps.status_code, pt.transaction_type, pt.transaction_amount
FROM sale s
INNER JOIN payment p ON p.sale_id = s.sale_id
INNER JOIN payment_status ps ON ps.payment_status_id = p.payment_status_id
INNER JOIN payment_transaction pt ON pt.payment_id = p.payment_id;