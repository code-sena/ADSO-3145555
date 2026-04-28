-- ============================================================
-- ejercicio_04_demo.sql
-- Ejercicio 04 - Script de demostración y validación
-- ============================================================

-- REQUERIMIENTO 1: Consulta INNER JOIN mínimo 5 tablas
-- Flujo: customer > person > loyalty_account > loyalty_program >
--        loyalty_account_tier > loyalty_tier > sale

SELECT
    p.first_name || ' ' || p.last_name     AS nombre_cliente,
    c.customer_code                         AS codigo_cliente,
    la.account_number                       AS cuenta_fidelizacion,
    lp.program_name                         AS programa,
    lt.tier_name                            AS nivel,
    lat.start_date                          AS fecha_asignacion_nivel,
    s.sale_code                             AS venta_relacionada
FROM customer c
    INNER JOIN person p                ON p.person_id              = c.person_id
    INNER JOIN loyalty_account la      ON la.customer_id           = c.customer_id
    INNER JOIN loyalty_program lp      ON lp.loyalty_program_id    = la.loyalty_program_id
    INNER JOIN loyalty_account_tier lat ON lat.loyalty_account_id  = la.loyalty_account_id
    INNER JOIN loyalty_tier lt         ON lt.loyalty_tier_id       = lat.loyalty_tier_id
    INNER JOIN reservation r           ON r.booked_by_customer_id  = c.customer_id
    INNER JOIN sale s                  ON s.reservation_id         = r.reservation_id
ORDER BY c.customer_code, lat.start_date DESC;


-- DEMOSTRACIÓN DEL TRIGGER Y PROCEDIMIENTO

-- Paso 1: Ver cuentas de fidelización y tiers disponibles
SELECT la.loyalty_account_id, la.account_number, c.customer_code
FROM loyalty_account la
    INNER JOIN customer c ON c.customer_id = la.customer_id
LIMIT 5;

SELECT loyalty_tier_id, tier_name, required_miles FROM loyalty_tier ORDER BY required_miles LIMIT 5;

-- Paso 2: Invocar el procedimiento para acumular millas
-- (Reemplaza el UUID con el loyalty_account_id real del Paso 1)
CALL sp_registrar_millas(
    '00000000-0000-0000-0000-000000000001',  -- reemplazar: loyalty_account_id real
    'EARN',
    500.00,
    'Millas por vuelo BOG-MED - abril 2026'
);

-- Paso 3: Validar que el trigger asignó nivel si no existía
SELECT
    mt.transaction_type_code,
    mt.miles_amount,
    mt.transaction_date,
    mt.notes,
    lat.start_date          AS nivel_asignado_desde,
    lt.tier_name            AS nivel
FROM miles_transaction mt
    INNER JOIN loyalty_account la      ON la.loyalty_account_id  = mt.loyalty_account_id
    LEFT  JOIN loyalty_account_tier lat ON lat.loyalty_account_id = la.loyalty_account_id
    LEFT  JOIN loyalty_tier lt         ON lt.loyalty_tier_id      = lat.loyalty_tier_id
ORDER BY mt.created_at DESC
LIMIT 10;
