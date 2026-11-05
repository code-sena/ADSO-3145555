-- =====================================================
-- EJERCICIO 04 - DEMO
-- =====================================================

DO $$
DECLARE
    v_loyalty_account_id uuid;
BEGIN
    SELECT loyalty_account_id INTO v_loyalty_account_id FROM loyalty_account LIMIT 1;
    
    CALL sp_register_miles_transaction(v_loyalty_account_id, 'EARN'::varchar, 5000, NOW(), 'FLIGHT-AV123', 'Millas por vuelo');
    CALL sp_register_miles_transaction(v_loyalty_account_id, 'EARN'::varchar, 3500, NOW(), 'FLIGHT-AV456', 'Millas por vuelo');
    CALL sp_register_miles_transaction(v_loyalty_account_id, 'REDEEM'::varchar, 2000, NOW(), 'UPGRADE-001', 'Canje por upgrade');
END;
$$;

SELECT mt.transaction_type, mt.miles_delta, mt.reference_code
FROM miles_transaction mt
ORDER BY mt.created_at DESC LIMIT 10;