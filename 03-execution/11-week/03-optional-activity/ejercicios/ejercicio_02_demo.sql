-- ============================================================
-- ejercicio_02_demo.sql
-- Ejercicio 02 - Script de demostración y validación
-- ============================================================

-- REQUERIMIENTO 1: Consulta INNER JOIN mínimo 5 tablas
-- Flujo: sale > reservation > payment > payment_status >
--        payment_method > payment_transaction > currency

SELECT
    s.sale_code                         AS codigo_venta,
    r.reservation_code                  AS codigo_reserva,
    p.payment_reference                 AS referencia_pago,
    ps.status_name                      AS estado_pago,
    pm.method_name                      AS metodo_pago,
    pt.transaction_reference            AS referencia_transaccion,
    pt.transaction_type                 AS tipo_transaccion,
    pt.transaction_amount               AS monto_procesado,
    c.iso_currency_code                 AS moneda
FROM sale s
    INNER JOIN reservation r            ON r.reservation_id       = s.reservation_id
    INNER JOIN payment p                ON p.sale_id              = s.sale_id
    INNER JOIN payment_status ps        ON ps.payment_status_id   = p.payment_status_id
    INNER JOIN payment_method pm        ON pm.payment_method_id   = p.payment_method_id
    INNER JOIN payment_transaction pt   ON pt.payment_id          = p.payment_id
    INNER JOIN currency c               ON c.currency_id          = p.currency_id
ORDER BY s.sale_code, pt.processed_at;


-- DEMOSTRACIÓN DEL TRIGGER Y PROCEDIMIENTO

-- Paso 1: Insertar estado y método de pago si no existen
INSERT INTO payment_status (payment_status_id, status_code, status_name)
VALUES (gen_random_uuid(), 'COMPLETED', 'Pago completado')
ON CONFLICT DO NOTHING;

INSERT INTO payment_method (payment_method_id, method_code, method_name)
VALUES (gen_random_uuid(), 'CREDIT_CARD', 'Tarjeta de crédito')
ON CONFLICT DO NOTHING;

-- Paso 2: Ver pagos disponibles para usar en el procedimiento
SELECT p.payment_id, p.payment_reference, s.sale_code, ps.status_code
FROM payment p
    INNER JOIN sale s ON s.sale_id = p.sale_id
    INNER JOIN payment_status ps ON ps.payment_status_id = p.payment_status_id
LIMIT 5;

-- Paso 3: Invocar el procedimiento con un payment_id real
-- (Reemplaza el UUID con el obtenido en el paso anterior)
CALL sp_registrar_transaccion_pago(
    '00000000-0000-0000-0000-000000000001',  -- reemplazar: payment_id real
    'REVERSAL',
    500.00,
    'TXN-REV-20260425-001'
);

-- Paso 4: Validar que el trigger generó el refund
SELECT
    pt.transaction_reference,
    pt.transaction_type,
    pt.transaction_amount,
    pt.processed_at,
    rf.refund_reference,
    rf.amount           AS monto_devuelto,
    rf.requested_at
FROM payment_transaction pt
    INNER JOIN refund rf ON rf.payment_id = pt.payment_id
WHERE pt.transaction_type = 'REVERSAL'
ORDER BY pt.processed_at DESC
LIMIT 10;
