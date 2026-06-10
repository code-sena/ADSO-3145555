-- =====================================================
-- EJERCICIO 02 - DEMO
-- =====================================================

DO $$
DECLARE
    v_sale_id uuid;
    v_payment_id uuid;
    v_payment_status_id uuid;
    v_payment_method_id uuid;
    v_currency_id uuid;
BEGIN
    SELECT sale_id, currency_id INTO v_sale_id, v_currency_id FROM sale LIMIT 1;
    SELECT payment_status_id INTO v_payment_status_id FROM payment_status WHERE status_code = 'PENDING';
    SELECT payment_method_id INTO v_payment_method_id FROM payment_method WHERE method_code = 'CREDIT_CARD';
    
    INSERT INTO payment (sale_id, payment_status_id, payment_method_id, currency_id, payment_reference, amount, authorized_at)
    VALUES (v_sale_id, v_payment_status_id, v_payment_method_id, v_currency_id, 'PAY-DEMO-' || replace(gen_random_uuid()::text, '-', ''), 150000.00, NOW())
    RETURNING payment_id INTO v_payment_id;
    
    CALL sp_register_payment_transaction(v_payment_id, 'CAPTURE'::varchar, 150000.00::numeric, NOW(), 'Captura exitosa');
    CALL sp_register_payment_transaction(v_payment_id, 'REFUND'::varchar, 150000.00::numeric, NOW(), 'Reembolso total');
END;
$$;

SELECT p.payment_reference, pt.transaction_type, pt.transaction_amount
FROM payment p
INNER JOIN payment_transaction pt ON pt.payment_id = p.payment_id
ORDER BY p.created_at DESC LIMIT 5;