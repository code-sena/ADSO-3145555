-- =====================================================
-- EJERCICIO 09 - SETUP
-- Publicación de tarifas y análisis de reservas comercializadas
-- =====================================================

DROP TRIGGER IF EXISTS trg_ai_fare_audit ON fare;
DROP FUNCTION IF EXISTS fn_ai_fare_audit();
DROP PROCEDURE IF EXISTS sp_publish_fare(uuid, uuid, uuid, uuid, uuid, numeric, date, date, integer, numeric, numeric);

CREATE OR REPLACE FUNCTION fn_ai_fare_audit()
RETURNS trigger
LANGUAGE plpgsql
AS $$
BEGIN
    RAISE NOTICE 'Nueva tarifa creada: % con monto %', NEW.fare_code, NEW.base_amount;
    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_ai_fare_audit
AFTER INSERT ON fare
FOR EACH ROW
EXECUTE FUNCTION fn_ai_fare_audit();

CREATE OR REPLACE PROCEDURE sp_publish_fare(
    p_airline_id uuid,
    p_origin_airport_id uuid,
    p_destination_airport_id uuid,
    p_fare_class_id uuid,
    p_currency_id uuid,
    p_base_amount numeric,
    p_valid_from date,
    p_valid_to date DEFAULT NULL,
    p_baggage_allowance_qty integer DEFAULT 0,
    p_change_penalty_amount numeric DEFAULT NULL,
    p_refund_penalty_amount numeric DEFAULT NULL
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_fare_code varchar(30);
BEGIN
    IF p_base_amount < 0 THEN
        RAISE EXCEPTION 'Monto base no puede ser negativo';
    END IF;
    
    v_fare_code := 'FARE-' || to_char(NOW(), 'YYYYMMDD') || '-' || left(replace(gen_random_uuid()::text, '-', ''), 6);
    
    INSERT INTO fare (airline_id, origin_airport_id, destination_airport_id, fare_class_id, currency_id,
                      fare_code, base_amount, valid_from, valid_to, baggage_allowance_qty,
                      change_penalty_amount, refund_penalty_amount)
    VALUES (p_airline_id, p_origin_airport_id, p_destination_airport_id, p_fare_class_id, p_currency_id,
            v_fare_code, p_base_amount, p_valid_from, p_valid_to, p_baggage_allowance_qty,
            p_change_penalty_amount, p_refund_penalty_amount);
END;
$$;

-- CONSULTA INNER JOIN
SELECT al.airline_name, f.fare_code, fc.fare_class_name, f.base_amount
FROM airline al
INNER JOIN fare f ON f.airline_id = al.airline_id
INNER JOIN fare_class fc ON fc.fare_class_id = f.fare_class_id;