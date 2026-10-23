-- =====================================================
-- EJERCICIO 06 - DEMO
-- =====================================================

DO $$
DECLARE
    v_flight_segment_id uuid;
    v_delay_reason_type_id uuid;
BEGIN
    SELECT flight_segment_id INTO v_flight_segment_id FROM flight_segment LIMIT 1;
    SELECT delay_reason_type_id INTO v_delay_reason_type_id FROM delay_reason_type LIMIT 1;
    
    CALL sp_register_flight_delay(v_flight_segment_id, v_delay_reason_type_id, NOW(), 30, 'Demora por clima');
    CALL sp_register_flight_delay(v_flight_segment_id, v_delay_reason_type_id, NOW(), 15, 'Demora adicional');
END;
$$;

SELECT f.flight_number, fd.delay_minutes, fd.notes
FROM flight_delay fd
INNER JOIN flight_segment fs ON fs.flight_segment_id = fd.flight_segment_id
INNER JOIN flight f ON f.flight_id = fs.flight_id
ORDER BY fd.created_at DESC LIMIT 5;