DROP TRIGGER IF EXISTS trg_ai_payment_transaction_create_refund ON payment_transaction;
DROP FUNCTION IF EXISTS fn_ai_payment_transaction_create_refund();
DROP PROCEDURE IF EXISTS sp_register_payment_transaction(uuid, varchar, numeric, timestamptz, varchar);

CREATE OR REPLACE FUNCTION fn_ai_payment_transaction_create_refund()
RETURNS trigger
LANGUAGE plpgsql
AS $$
DECLARE
    v_payment_status_code varchar(50);
BEGIN
    SELECT ps.status_code
    INTO v_payment_status_code
    FROM payment p
    INNER JOIN payment_status ps
        ON ps.payment_status_id = p.payment_status_id
    WHERE p.payment_id = NEW.payment_id;

    IF lower(v_payment_status_code) NOT IN ('reversed', 'refunded', 'cancelled') THEN
        RETURN NEW;
    END IF;

    IF EXISTS (
        SELECT 1
        FROM refund r
        WHERE r.payment_transaction_id = NEW.payment_transaction_id
    ) THEN
        RETURN NEW;
    END IF;

    INSERT INTO refund (
        payment_transaction_id,
        refund_amount,
        refund_reason,
        refunded_at
    )
    VALUES (
        NEW.payment_transaction_id,
        NEW.amount,
        'Devolución automática generada por reversión de pago',
        NEW.processed_at
    );

    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_ai_payment_transaction_create_refund
AFTER INSERT ON payment_transaction
FOR EACH ROW
EXECUTE FUNCTION fn_ai_payment_transaction_create_refund();

CREATE OR REPLACE PROCEDURE sp_register_payment_transaction(
    p_payment_id          uuid,
    p_transaction_type    varchar,
    p_amount              numeric,
    p_processed_at        timestamptz,
    p_provider_message    varchar
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM payment p
        WHERE p.payment_id = p_payment_id
    ) THEN
        RAISE EXCEPTION 'No existe un pago con payment_id %', p_payment_id;
    END IF;

    INSERT INTO payment_transaction (
        payment_id,
        transaction_type,
        amount,
        processed_at,
        provider_message
    )
    VALUES (
        p_payment_id,
        p_transaction_type,
        p_amount,
        p_processed_at,
        p_provider_message
    );
END;
$$;

-- Consulta resuelta: trazabilidad financiera venta-pago-transacción-moneda
SELECT
    s.sale_code,
    r.reservation_code,
    p.payment_reference,
    ps.status_name        AS estado_pago,
    pm.method_name        AS metodo_pago,
    pt.transaction_reference,
    pt.transaction_type,
    pt.amount             AS monto_procesado,
    c.currency_code       AS moneda
FROM sale s
INNER JOIN reservation r
    ON r.reservation_id = s.reservation_id
INNER JOIN payment p
    ON p.sale_id = s.sale_id
INNER JOIN payment_status ps
    ON ps.payment_status_id = p.payment_status_id
INNER JOIN payment_method pm
    ON pm.payment_method_id = p.payment_method_id
INNER JOIN payment_transaction pt
    ON pt.payment_id = p.payment_id
INNER JOIN currency c
    ON c.currency_id = p.currency_id
ORDER BY pt.processed_at DESC;