-- =====================================================
-- EJERCICIO 03 - SETUP
-- Facturación e integración entre venta, impuestos y detalle facturable
-- =====================================================

DROP TRIGGER IF EXISTS trg_ai_invoice_line_update_invoice_total ON invoice_line;
DROP FUNCTION IF EXISTS fn_ai_invoice_line_update_invoice_total();
DROP PROCEDURE IF EXISTS sp_add_invoice_line(uuid, uuid, integer, varchar, numeric, numeric);

CREATE OR REPLACE FUNCTION fn_ai_invoice_line_update_invoice_total()
RETURNS trigger
LANGUAGE plpgsql
AS $$
DECLARE
    v_total_amount numeric;
    v_issued_status_id uuid;
BEGIN
    SELECT COALESCE(SUM(il.quantity * il.unit_price), 0) INTO v_total_amount
    FROM invoice_line il WHERE il.invoice_id = NEW.invoice_id;
    
    UPDATE invoice SET notes = 'Total: ' || v_total_amount, updated_at = NOW()
    WHERE invoice_id = NEW.invoice_id;
    
    SELECT invoice_status_id INTO v_issued_status_id FROM invoice_status WHERE status_code = 'ISSUED';
    
    IF v_issued_status_id IS NOT NULL AND 
       (SELECT invoice_status_id FROM invoice WHERE invoice_id = NEW.invoice_id) = 
       (SELECT invoice_status_id FROM invoice_status WHERE status_code = 'DRAFT') THEN
        UPDATE invoice SET invoice_status_id = v_issued_status_id WHERE invoice_id = NEW.invoice_id;
    END IF;
    
    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_ai_invoice_line_update_invoice_total
AFTER INSERT ON invoice_line
FOR EACH ROW
EXECUTE FUNCTION fn_ai_invoice_line_update_invoice_total();

CREATE OR REPLACE PROCEDURE sp_add_invoice_line(
    p_invoice_id uuid,
    p_tax_id uuid,
    p_line_number integer,
    p_line_description varchar,
    p_quantity numeric,
    p_unit_price numeric
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_effective_line_number integer;
BEGIN
    IF NOT EXISTS (SELECT 1 FROM invoice WHERE invoice_id = p_invoice_id) THEN
        RAISE EXCEPTION 'Factura no existe';
    END IF;
    
    SELECT COALESCE(MAX(line_number), 0) + 1 INTO v_effective_line_number
    FROM invoice_line WHERE invoice_id = p_invoice_id;
    
    INSERT INTO invoice_line (invoice_id, tax_id, line_number, line_description, quantity, unit_price)
    VALUES (p_invoice_id, p_tax_id, v_effective_line_number, p_line_description, p_quantity, p_unit_price);
END;
$$;

-- CONSULTA INNER JOIN
SELECT s.sale_code, i.invoice_number, il.line_description, il.quantity, il.unit_price, t.tax_code
FROM sale s
INNER JOIN invoice i ON i.sale_id = s.sale_id
INNER JOIN invoice_line il ON il.invoice_id = i.invoice_id
LEFT JOIN tax t ON t.tax_id = il.tax_id;