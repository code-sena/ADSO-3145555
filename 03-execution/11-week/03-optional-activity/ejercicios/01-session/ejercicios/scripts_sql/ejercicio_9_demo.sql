-- =====================================================
-- EJERCICIO 09 - DEMO
-- =====================================================

DO $$
DECLARE
    v_airline_id uuid;
    v_origin_airport_id uuid;
    v_dest_airport_id uuid;
    v_fare_class_id uuid;
    v_currency_id uuid;
BEGIN
    SELECT airline_id INTO v_airline_id FROM airline LIMIT 1;
    SELECT airport_id INTO v_origin_airport_id FROM airport LIMIT 1;
    SELECT airport_id INTO v_dest_airport_id FROM airport WHERE airport_id != v_origin_airport_id LIMIT 1;
    SELECT fare_class_id INTO v_fare_class_id FROM fare_class LIMIT 1;
    SELECT currency_id INTO v_currency_id FROM currency LIMIT 1;
    
    CALL sp_publish_fare(v_airline_id, v_origin_airport_id, v_dest_airport_id, v_fare_class_id, v_currency_id,
                         250000.00, CURRENT_DATE, CURRENT_DATE + INTERVAL '90 days', 1, 50000.00, 75000.00);
    
    CALL sp_publish_fare(v_airline_id, v_origin_airport_id, v_dest_airport_id, v_fare_class_id, v_currency_id,
                         150000.00, CURRENT_DATE, CURRENT_DATE + INTERVAL '30 days', 0, 100000.00, NULL);
END;
$$;

SELECT fare_code, base_amount, valid_from, valid_to
FROM fare
ORDER BY created_at DESC LIMIT 5;