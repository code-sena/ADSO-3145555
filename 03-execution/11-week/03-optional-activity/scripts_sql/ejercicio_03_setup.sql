DROP TRIGGER IF EXISTS trg_ai_invoice_line_update_invoice_total ON invoice_line;
DROP FUNCTION IF EXISTS fn_ai_invoice_line_update_invoice_total();
DROP PROCEDURE IF EXISTS sp_register_invoice_line(uuid, uuid, integer, varchar, numeric, numeric);

CREATE OR REPLACE FUNCTION fn_ai_invoice_line_update_invoice_total()
RETURNS trigger
LANGUAGE plpgsql
AS $$
DECLARE
    v_total_amount numeric;
BEGIN
    SELECT COALESCE(SUM(il.unit_price * il.quantity), 0)
    INTO v_total_amount
    FROM invoice_line il
    WHERE il.invoice_id = NEW.invoice_id;

    UPDATE invoice
    SET total_amount = v_total_amount
    WHERE invoice_id = NEW.invoice_id;

    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_ai_invoice_line_update_invoice_total
AFTER INSERT ON invoice_line
FOR EACH ROW
EXECUTE FUNCTION fn_ai_invoice_line_update_invoice_total();

CREATE OR REPLACE PROCEDURE sp_register_invoice_line(
    p_invoice_id     uuid,
    p_tax_id         uuid,
    p_line_number    integer,
    p_description    varchar,
    p_quantity       numeric,
    p_unit_price     numeric
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM invoice i
        WHERE i.invoice_id = p_invoice_id
    ) THEN
        RAISE EXCEPTION 'No existe una factura con invoice_id %', p_invoice_id;
    END IF;

    IF EXISTS (
        SELECT 1
        FROM invoice_line il
        WHERE il.invoice_id = p_invoice_id
          AND il.line_number = p_line_number
    ) THEN
        RAISE EXCEPTION 'Ya existe una línea % para la factura %', p_line_number, p_invoice_id;
    END IF;

    INSERT INTO invoice_line (
        invoice_id,
        tax_id,
        line_number,
        description,
        quantity,
        unit_price
    )
    VALUES (
        p_invoice_id,
        p_tax_id,
        p_line_number,
        p_description,
        p_quantity,
        p_unit_price
    );
END;
$$;

-- Consulta resuelta: trazabilidad de facturación venta-factura-línea-impuesto-moneda
SELECT
    s.sale_code,
    i.invoice_number,
    ist.status_name       AS estado_factura,
    il.line_number        AS linea_facturable,
    il.description        AS descripcion_linea,
    il.quantity,
    il.unit_price         AS precio_unitario,
    t.tax_name            AS impuesto_aplicado,
    c.currency_code       AS moneda
FROM sale s
INNER JOIN invoice i
    ON i.sale_id = s.sale_id
INNER JOIN invoice_status ist
    ON ist.invoice_status_id = i.invoice_status_id
INNER JOIN invoice_line il
    ON il.invoice_id = i.invoice_id
INNER JOIN tax t
    ON t.tax_id = il.tax_id
INNER JOIN currency c
    ON c.currency_id = i.currency_id
ORDER BY i.invoice_number, il.line_number;