-- ============================================================
-- ejercicio_04_setup.sql
-- Ejercicio 04 - Acumulación de millas y actualización de nivel
-- Dominios: CUSTOMER AND LOYALTY, IDENTITY, SALES
-- ============================================================

-- REQUERIMIENTO 2: Función y Trigger AFTER INSERT sobre miles_transaction
-- Al insertar una transacción de millas de tipo 'EARN', registra
-- una entrada en loyalty_account_tier si el cliente no tiene nivel activo
-- (usando los datos reales del modelo sin alterar su estructura)

CREATE OR REPLACE FUNCTION fn_registrar_tier_por_millas()
RETURNS TRIGGER AS $$
DECLARE
    v_tier_id uuid;
    v_ya_tiene_nivel boolean;
BEGIN
    IF NEW.transaction_type_code = 'EARN' THEN
        SELECT EXISTS (
            SELECT 1 FROM loyalty_account_tier
            WHERE loyalty_account_id = NEW.loyalty_account_id
              AND (end_date IS NULL OR end_date > now()::date)
        ) INTO v_ya_tiene_nivel;

        IF NOT v_ya_tiene_nivel THEN
            SELECT loyalty_tier_id INTO v_tier_id
            FROM loyalty_tier
            ORDER BY required_miles ASC
            LIMIT 1;

            IF v_tier_id IS NOT NULL THEN
                INSERT INTO loyalty_account_tier (
                    loyalty_account_tier_id,
                    loyalty_account_id,
                    loyalty_tier_id,
                    start_date,
                    end_date,
                    created_at,
                    updated_at
                ) VALUES (
                    gen_random_uuid(),
                    NEW.loyalty_account_id,
                    v_tier_id,
                    now()::date,
                    NULL,
                    now(), now()
                );
                RAISE NOTICE 'Nivel inicial asignado a cuenta: %', NEW.loyalty_account_id;
            END IF;
        END IF;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_after_miles_transaction_tier ON miles_transaction;
CREATE TRIGGER trg_after_miles_transaction_tier
    AFTER INSERT ON miles_transaction
    FOR EACH ROW
    EXECUTE FUNCTION fn_registrar_tier_por_millas();


-- REQUERIMIENTO 3: Procedimiento almacenado para registrar transacción de millas

CREATE OR REPLACE PROCEDURE sp_registrar_millas(
    p_loyalty_account_id    uuid,
    p_transaction_type_code varchar(20),
    p_miles_amount          numeric(12,2),
    p_notes                 text
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM loyalty_account WHERE loyalty_account_id = p_loyalty_account_id) THEN
        RAISE EXCEPTION 'Cuenta de fidelización no encontrada: %', p_loyalty_account_id;
    END IF;

    INSERT INTO miles_transaction (
        miles_transaction_id,
        loyalty_account_id,
        transaction_type_code,
        miles_amount,
        transaction_date,
        notes,
        created_at,
        updated_at
    ) VALUES (
        gen_random_uuid(),
        p_loyalty_account_id,
        p_transaction_type_code,
        p_miles_amount,
        now()::date,
        p_notes,
        now(), now()
    );

    RAISE NOTICE '% millas tipo % registradas para cuenta %',
        p_miles_amount, p_transaction_type_code, p_loyalty_account_id;
END;
$$;
