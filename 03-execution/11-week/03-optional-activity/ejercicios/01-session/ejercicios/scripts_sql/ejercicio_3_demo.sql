-- =====================================================
-- EJERCICIO 03 - DEMO
-- =====================================================

DO $$
DECLARE
    v_sale_id uuid;
    v_invoice_id uuid;
    v_currency_id uuid;
    v_draft_status_id uuid;
    v_tax_id uuid;
BEGIN
    SELECT sale_id, currency_id INTO v_sale_id, v_currency_id FROM sale LIMIT 1;
    SELECT invoice_status_id INTO v_draft_status_id FROM invoice_status WHERE status_code = 'DRAFT';
    SELECT tax_id INTO v_tax_id FROM tax LIMIT 1;
    
    INSERT INTO invoice (sale_id, invoice_status_id, currency_id, invoice_number, issued_at)
    VALUES (v_sale_id, v_draft_status_id, v_currency_id, 'INV-' || replace(gen_random_uuid()::text, '-', ''), NOW())
    RETURNING invoice_id INTO v_invoice_id;
    
    CALL sp_add_invoice_line(v_invoice_id, v_tax_id, 1, 'Tiquete aéreo', 1, 250000.00);
    CALL sp_add_invoice_line(v_invoice_id, v_tax_id, 2, 'Equipaje adicional', 1, 50000.00);
END;
$$;

SELECT i.invoice_number, il.line_description, il.quantity, il.unit_price
FROM invoice i
INNER JOIN invoice_line il ON il.invoice_id = i.invoice_id
ORDER BY i.created_at DESC LIMIT 10;