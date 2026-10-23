-- =====================================================
-- EJERCICIO 04 - SETUP
-- Acumulación de millas y actualización del historial de nivel
-- =====================================================

DROP TRIGGER IF EXISTS trg_ai_miles_transaction_update_tier ON miles_transaction;
DROP FUNCTION IF EXISTS fn_ai_miles_transaction_update_tier();
DROP PROCEDURE IF EXISTS sp_register_miles_transaction(uuid, varchar, integer, timestamptz, varchar, text);

CREATE OR REPLACE FUNCTION fn_ai_miles_transaction_update_tier()
RETURNS trigger
LANGUAGE plpgsql
AS $$
DECLARE
    v_customer_id uuid;
    v_total_miles integer;
    v_new_tier_id uuid;
    v_current_tier_id uuid;
    v_program_id uuid;
BEGIN
    SELECT customer_id, loyalty_program_id INTO v_customer_id, v_program_id
    FROM loyalty_account WHERE loyalty_account_id = NEW.loyalty_account_id;
    
    SELECT COALESCE(SUM(miles_delta), 0) INTO v_total_miles
    FROM miles_transaction WHERE loyalty_account_id = NEW.loyalty_account_id AND transaction_type = 'EARN';
    
    SELECT loyalty_tier_id INTO v_new_tier_id
    FROM loyalty_tier WHERE loyalty_program_id = v_program_id AND required_miles <= v_total_miles
    ORDER BY required_miles DESC LIMIT 1;
    
    SELECT loyalty_tier_id INTO v_current_tier_id
    FROM loyalty_account_tier WHERE loyalty_account_id = NEW.loyalty_account_id AND expires_at IS NULL;
    
    IF v_current_tier_id IS DISTINCT FROM v_new_tier_id AND v_new_tier_id IS NOT NULL THEN
        UPDATE loyalty_account_tier SET expires_at = NOW()
        WHERE loyalty_account_id = NEW.loyalty_account_id AND expires_at IS NULL;
        
        INSERT INTO loyalty_account_tier (loyalty_account_id, loyalty_tier_id, assigned_at)
        VALUES (NEW.loyalty_account_id, v_new_tier_id, NOW());
    END IF;
    
    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_ai_miles_transaction_update_tier
AFTER INSERT ON miles_transaction
FOR EACH ROW
EXECUTE FUNCTION fn_ai_miles_transaction_update_tier();

CREATE OR REPLACE PROCEDURE sp_register_miles_transaction(
    p_loyalty_account_id uuid,
    p_transaction_type varchar,
    p_miles_delta integer,
    p_occurred_at timestamptz,
    p_reference_code varchar DEFAULT NULL,
    p_notes text DEFAULT NULL
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM loyalty_account WHERE loyalty_account_id = p_loyalty_account_id) THEN
        RAISE EXCEPTION 'Cuenta de fidelización no existe';
    END IF;
    
    IF p_transaction_type NOT IN ('EARN', 'REDEEM', 'ADJUST') THEN
        RAISE EXCEPTION 'Tipo inválido';
    END IF;
    
    INSERT INTO miles_transaction (loyalty_account_id, transaction_type, miles_delta, occurred_at, reference_code, notes)
    VALUES (p_loyalty_account_id, p_transaction_type, p_miles_delta, p_occurred_at, p_reference_code, p_notes);
END;
$$;

-- CONSULTA INNER JOIN
SELECT c.customer_id, la.account_number, lt.tier_name, mt.transaction_type, mt.miles_delta
FROM customer c
INNER JOIN loyalty_account la ON la.customer_id = c.customer_id
INNER JOIN loyalty_account_tier lat ON lat.loyalty_account_id = la.loyalty_account_id AND lat.expires_at IS NULL
INNER JOIN loyalty_tier lt ON lt.loyalty_tier_id = lat.loyalty_tier_id
LEFT JOIN miles_transaction mt ON mt.loyalty_account_id = la.loyalty_account_id;