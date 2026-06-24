-- ============================================================
-- ejercicio_03_setup.sql
-- Ejercicio 03 - Facturación e integración venta, impuestos y detalle
-- Dominios: SALES/TICKETING, BILLING, GEOGRAPHY
-- ============================================================

-- REQUERIMIENTO 2: Función y Trigger AFTER INSERT sobre invoice_line
-- Al insertar una línea facturable, registra en RAISE NOTICE el total acumulado
-- de líneas de esa factura (efecto verificable sin alterar el modelo base)

CREATE OR REPLACE FUNCTION fn_log_invoice_line_insert()
RETURNS TRIGGER AS $$
DECLARE
    v_total_lines integer;
    v_total_amount numeric(14,2);
BEGIN
    SELECT
        count(*),
        sum(quantity * unit_price)
    INTO v_total_lines, v_total_amount
    FROM invoice_line
    WHERE invoice_id = NEW.invoice_id;

    RAISE NOTICE 'Factura % — líneas acumuladas: %, total calculado: %',
        NEW.invoice_id, v_total_lines, v_total_amount;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_after_invoice_line_log ON invoice_line;
CREATE TRIGGER trg_after_invoice_line_log
    AFTER INSERT ON invoice_line
    FOR EACH ROW
    EXECUTE FUNCTION fn_log_invoice_line_insert();


-- REQUERIMIENTO 3: Procedimiento almacenado para registrar línea facturable

CREATE OR REPLACE PROCEDURE sp_registrar_linea_factura(
    p_invoice_id        uuid,
    p_tax_id            uuid,
    p_line_number       integer,
    p_line_description  varchar(200),
    p_quantity          numeric(12,2),
    p_unit_price        numeric(12,2)
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM invoice WHERE invoice_id = p_invoice_id) THEN
        RAISE EXCEPTION 'Factura no encontrada: %', p_invoice_id;
    END IF;

    INSERT INTO invoice_line (
        invoice_line_id, invoice_id, tax_id,
        line_number, line_description,
        quantity, unit_price,
        created_at, updated_at
    ) VALUES (
        gen_random_uuid(),
        p_invoice_id,
        p_tax_id,
        p_line_number,
        p_line_description,
        p_quantity,
        p_unit_price,
        now(), now()
    );

    RAISE NOTICE 'Línea % registrada en factura %', p_line_number, p_invoice_id;
END;
$$;
