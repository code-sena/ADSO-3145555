-- ============================================================
-- ejercicio_03_demo.sql
-- Ejercicio 03 - Script de demostración y validación
-- ============================================================

-- REQUERIMIENTO 1: Consulta INNER JOIN mínimo 5 tablas
-- Flujo: sale > invoice > invoice_status > invoice_line > tax > currency

SELECT
    s.sale_code                         AS codigo_venta,
    i.invoice_number                    AS numero_factura,
    ist.status_name                     AS estado_factura,
    il.line_number                      AS linea_facturable,
    il.line_description                 AS descripcion_linea,
    il.quantity                         AS cantidad,
    il.unit_price                       AS precio_unitario,
    t.tax_name                          AS impuesto_aplicado,
    t.rate_percentage                   AS porcentaje_impuesto,
    c.iso_currency_code                 AS moneda
FROM sale s
    INNER JOIN invoice i                ON i.sale_id             = s.sale_id
    INNER JOIN invoice_status ist       ON ist.invoice_status_id = i.invoice_status_id
    INNER JOIN invoice_line il          ON il.invoice_id         = i.invoice_id
    INNER JOIN tax t                    ON t.tax_id              = il.tax_id
    INNER JOIN currency c               ON c.currency_id         = i.currency_id
ORDER BY i.invoice_number, il.line_number;


-- DEMOSTRACIÓN DEL TRIGGER Y PROCEDIMIENTO

-- Paso 1: Crear datos de catálogo necesarios
INSERT INTO invoice_status (invoice_status_id, status_code, status_name)
VALUES (gen_random_uuid(), 'ISSUED', 'Factura emitida')
ON CONFLICT DO NOTHING;

INSERT INTO tax (tax_id, tax_code, tax_name, rate_percentage, effective_from)
VALUES (gen_random_uuid(), 'IVA19', 'IVA 19%', 19.000, '2024-01-01')
ON CONFLICT DO NOTHING;

-- Paso 2: Ver facturas y taxes disponibles
SELECT i.invoice_id, i.invoice_number, s.sale_code
FROM invoice i INNER JOIN sale s ON s.sale_id = i.sale_id LIMIT 5;

SELECT tax_id, tax_code, tax_name FROM tax LIMIT 5;

-- Paso 3: Invocar el procedimiento
-- (Reemplaza los UUIDs con los valores reales obtenidos arriba)
CALL sp_registrar_linea_factura(
    '00000000-0000-0000-0000-000000000001',  -- reemplazar: invoice_id real
    '00000000-0000-0000-0000-000000000002',  -- reemplazar: tax_id real
    1,
    'Tiquete aéreo ruta BOG-MED clase económica',
    1.00,
    350000.00
);

-- Paso 4: Validar que la línea quedó registrada y el trigger se ejecutó
SELECT
    il.line_number,
    il.line_description,
    il.quantity,
    il.unit_price,
    (il.quantity * il.unit_price)   AS subtotal,
    t.tax_name,
    t.rate_percentage,
    i.invoice_number
FROM invoice_line il
    INNER JOIN invoice i ON i.invoice_id = il.invoice_id
    LEFT  JOIN tax t     ON t.tax_id     = il.tax_id
ORDER BY il.created_at DESC
LIMIT 10;
