-- =====================================================
-- EJERCICIO 07 - DEMO
-- =====================================================

DO $$
DECLARE
    v_ticket_segment_id uuid;
    v_aircraft_seat_id uuid;
BEGIN
    SELECT ts.ticket_segment_id INTO v_ticket_segment_id FROM ticket_segment ts LIMIT 1;
    SELECT aircraft_seat_id INTO v_aircraft_seat_id FROM aircraft_seat LIMIT 1;
    
    CALL sp_assign_seat(v_ticket_segment_id, v_aircraft_seat_id, NOW(), 'MANUAL');
    CALL sp_register_baggage(v_ticket_segment_id, 'CHECKED', 'REGISTERED', 23.5, NOW());
    CALL sp_register_baggage(v_ticket_segment_id, 'CARRY_ON', 'REGISTERED', 7.0, NOW());
END;
$$;

SELECT b.baggage_tag, b.baggage_type, b.weight_kg
FROM baggage b
ORDER BY b.created_at DESC LIMIT 5;