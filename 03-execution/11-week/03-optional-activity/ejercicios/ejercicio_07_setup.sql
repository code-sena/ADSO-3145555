-- ============================================================
-- ejercicio_07_setup.sql
-- Ejercicio 07 - Asignación de asientos y registro de equipaje
-- Dominios: SALES/TICKETING, AIRCRAFT, FLIGHT OPERATIONS
-- ============================================================

-- REQUERIMIENTO 2: Función y Trigger AFTER INSERT sobre baggage
-- Al registrar un equipaje, emite un RAISE NOTICE con el conteo total
-- de piezas de equipaje registradas para ese ticket_segment

CREATE OR REPLACE FUNCTION fn_log_equipaje_por_segmento()
RETURNS TRIGGER AS $$
DECLARE
    v_total_piezas integer;
    v_peso_total   numeric(8,2);
BEGIN
    SELECT count(*), sum(weight_kg)
    INTO v_total_piezas, v_peso_total
    FROM baggage
    WHERE ticket_segment_id = NEW.ticket_segment_id;

    RAISE NOTICE 'Ticket-Segment [%] — equipaje registrado. Total piezas: %, Peso total: % kg',
        NEW.ticket_segment_id, v_total_piezas, v_peso_total;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_after_baggage_log ON baggage;
CREATE TRIGGER trg_after_baggage_log
    AFTER INSERT ON baggage
    FOR EACH ROW
    EXECUTE FUNCTION fn_log_equipaje_por_segmento();


-- REQUERIMIENTO 3: Procedimiento almacenado para registrar equipaje

CREATE OR REPLACE PROCEDURE sp_registrar_equipaje(
    p_ticket_segment_id uuid,
    p_baggage_tag       varchar(30),
    p_baggage_type      varchar(20),
    p_baggage_status    varchar(20),
    p_weight_kg         numeric(6,2)
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM ticket_segment WHERE ticket_segment_id = p_ticket_segment_id) THEN
        RAISE EXCEPTION 'Ticket segment no encontrado: %', p_ticket_segment_id;
    END IF;

    INSERT INTO baggage (
        baggage_id,
        ticket_segment_id,
        baggage_tag,
        baggage_type,
        baggage_status,
        weight_kg,
        created_at,
        updated_at
    ) VALUES (
        gen_random_uuid(),
        p_ticket_segment_id,
        p_baggage_tag,
        p_baggage_type,
        p_baggage_status,
        p_weight_kg,
        now(), now()
    );

    RAISE NOTICE 'Equipaje [%] registrado para ticket_segment %', p_baggage_tag, p_ticket_segment_id;
END;
$$;
