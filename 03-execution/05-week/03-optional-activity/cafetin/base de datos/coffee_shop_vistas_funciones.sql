USE `coffee_shop`;

-- ================================================================
-- VISTAS Y FUNCIONES - COFFEE SHOP
-- ================================================================

-- ================================================================
-- ▌MÓDULO 1: SEGURIDAD
-- ================================================================

-- Vista: usuarios con su persona y rol asignado
CREATE OR REPLACE VIEW vw_usuarios_completo AS
SELECT
    u.id             AS usuario_id,
    u.username,
    CONCAT(p.first_name, ' ', p.last_name) AS nombre_completo,
    p.email,
    p.tipo_usuario,
    td.name          AS tipo_documento,
    f.name           AS ficha,
    r.name           AS rol,
    u.status         AS activo,
    u.created_at     AS fecha_creacion
FROM users u
JOIN person   p  ON p.id  = u.person_id
JOIN type_document td ON td.id = p.type_document_id
LEFT JOIN ficha f ON f.id = p.ficha_id
LEFT JOIN user_role ur ON ur.user_id = u.id
LEFT JOIN role  r  ON r.id  = ur.role_id;

-- Vista: módulos y vistas accesibles por rol
CREATE OR REPLACE VIEW vw_permisos_rol AS
SELECT
    r.name  AS rol,
    m.name  AS modulo,
    v.name  AS vista,
    v.route AS ruta
FROM role r
JOIN role_module  rm ON rm.role_id   = r.id
JOIN module       m  ON m.id         = rm.module_id
JOIN module_view  mv ON mv.module_id = m.id
JOIN view         v  ON v.id         = mv.view_id
WHERE r.status = TRUE AND m.status = TRUE AND v.status = TRUE;

-- ================================================================
-- ▌MÓDULO 2: PARÁMETROS / PERSONAS
-- ================================================================

-- Vista: personas con información completa
CREATE OR REPLACE VIEW vw_personas AS
SELECT
    p.id,
    CONCAT(p.first_name, ' ', p.last_name) AS nombre_completo,
    p.email,
    p.phone,
    p.tipo_usuario,
    td.code  AS codigo_doc,
    td.name  AS tipo_doc,
    f.code   AS codigo_ficha,
    f.name   AS programa,
    p.status,
    p.created_at
FROM person p
LEFT JOIN type_document td ON td.id = p.type_document_id
LEFT JOIN ficha         f  ON f.id  = p.ficha_id;

-- ================================================================
-- ▌MÓDULO 3: INVENTARIO
-- ================================================================

-- Vista: inventario completo con producto, categoría y proveedor
CREATE OR REPLACE VIEW vw_inventario AS
SELECT
    i.id            AS inventario_id,
    p.id            AS producto_id,
    p.name          AS producto,
    c.name          AS categoria,
    s.name          AS proveedor,
    s.contact_name  AS contacto_proveedor,
    p.price         AS precio,
    i.stock_actual,
    i.stock_minimo,
    CASE WHEN i.stock_actual <= i.stock_minimo THEN 'BAJO STOCK' ELSE 'OK' END AS estado_stock,
    i.last_update
FROM inventory i
JOIN product  p ON p.id = i.product_id
JOIN category c ON c.id = p.category_id
JOIN supplier s ON s.id = p.supplier_id;

-- Vista: productos con stock bajo
CREATE OR REPLACE VIEW vw_stock_bajo AS
SELECT producto, categoria, proveedor, stock_actual, stock_minimo
FROM vw_inventario
WHERE estado_stock = 'BAJO STOCK';

-- ================================================================
-- ▌MÓDULO 4: VENTAS
-- ================================================================

-- Vista: detalle de órdenes con cliente y cajero
CREATE OR REPLACE VIEW vw_ordenes AS
SELECT
    o.id            AS orden_id,
    o.order_date    AS fecha,
    o.status        AS estado,
    o.total,
    CONCAT(pc.first_name, ' ', pc.last_name) AS cliente,
    CONCAT(pu.first_name, ' ', pu.last_name) AS cajero,
    cu.points       AS puntos_cliente
FROM orders o
JOIN customer cu ON cu.id = o.customer_id
JOIN person   pc ON pc.id = cu.person_id
JOIN users     u ON u.id  = o.user_id
JOIN person   pu ON pu.id = u.person_id;

-- Vista: detalle de ítems por orden
CREATE OR REPLACE VIEW vw_detalle_ordenes AS
SELECT
    oi.order_id,
    o.order_date   AS fecha,
    o.status,
    pr.name        AS producto,
    cat.name       AS categoria,
    oi.quantity    AS cantidad,
    oi.price_at_time AS precio_unitario,
    (oi.quantity * oi.price_at_time) AS subtotal
FROM order_item oi
JOIN orders   o   ON o.id   = oi.order_id
JOIN product  pr  ON pr.id  = oi.product_id
JOIN category cat ON cat.id = pr.category_id;

-- Vista: resumen de ventas por cajero
CREATE OR REPLACE VIEW vw_ventas_por_cajero AS
SELECT
    CONCAT(p.first_name, ' ', p.last_name) AS cajero,
    COUNT(o.id)  AS total_ordenes,
    SUM(o.total) AS total_vendido
FROM orders o
JOIN users  u ON u.id = o.user_id
JOIN person p ON p.id = u.person_id
GROUP BY cajero;

-- ================================================================
-- ▌MÓDULO 5: FACTURACIÓN
-- ================================================================

-- Vista: facturas con info de pago y cliente
CREATE OR REPLACE VIEW vw_facturas AS
SELECT
    inv.id             AS factura_id,
    inv.invoice_number AS numero_factura,
    inv.created_at     AS fecha,
    inv.total,
    inv.pago_con,
    inv.cambio,
    mp.name            AS metodo_pago,
    py.amount          AS monto_pago,
    CONCAT(pc.first_name, ' ', pc.last_name) AS cliente
FROM invoice inv
JOIN orders      o   ON o.id  = inv.order_id
JOIN customer    cu  ON cu.id = o.customer_id
JOIN person      pc  ON pc.id = cu.person_id
LEFT JOIN payment    py  ON py.invoice_id = inv.id
LEFT JOIN method_payment mp ON mp.id = py.method_payment_id;

-- Vista: ventas por método de pago
CREATE OR REPLACE VIEW vw_ventas_por_metodo_pago AS
SELECT
    mp.name     AS metodo_pago,
    COUNT(py.id) AS cantidad_transacciones,
    SUM(py.amount) AS total_recaudado
FROM payment py
JOIN method_payment mp ON mp.id = py.method_payment_id
GROUP BY mp.name
ORDER BY total_recaudado DESC;

-- Vista: productos más vendidos
CREATE OR REPLACE VIEW vw_productos_mas_vendidos AS
SELECT
    pr.name       AS producto,
    cat.name      AS categoria,
    SUM(oi.quantity) AS unidades_vendidas,
    SUM(oi.quantity * oi.price_at_time) AS total_generado
FROM order_item oi
JOIN product  pr  ON pr.id  = oi.product_id
JOIN category cat ON cat.id = pr.category_id
JOIN orders   o   ON o.id   = oi.order_id
WHERE o.status != 'CANCELADO'
GROUP BY pr.id, pr.name, cat.name
ORDER BY unidades_vendidas DESC;

-- ================================================================
-- ▌AUDITORÍA
-- ================================================================

-- Vista: log de auditoría con nombre de usuario
CREATE OR REPLACE VIEW vw_auditoria AS
SELECT
    al.id,
    CONCAT(p.first_name, ' ', p.last_name) AS usuario,
    al.action,
    al.table_name AS tabla,
    al.description,
    al.created_at AS fecha
FROM audit_log al
JOIN users  u ON u.id = al.user_id
JOIN person p ON p.id = u.person_id
ORDER BY al.created_at DESC;


-- ================================================================
-- FUNCIONES
-- ================================================================

DELIMITER $$

-- ---------------------------------------------------------------
-- FN 1: Obtener el nombre completo de una persona por su ID
-- ---------------------------------------------------------------
CREATE FUNCTION fn_nombre_persona(p_person_id INT)
RETURNS VARCHAR(101)
DETERMINISTIC
BEGIN
    DECLARE v_nombre VARCHAR(101);
    SELECT CONCAT(first_name, ' ', last_name)
      INTO v_nombre
      FROM person
     WHERE id = p_person_id;
    RETURN COALESCE(v_nombre, 'Desconocido');
END$$

-- ---------------------------------------------------------------
-- FN 2: Total vendido en un rango de fechas
-- ---------------------------------------------------------------
CREATE FUNCTION fn_total_ventas(p_desde DATETIME, p_hasta DATETIME)
RETURNS DECIMAL(12,2)
DETERMINISTIC
BEGIN
    DECLARE v_total DECIMAL(12,2);
    SELECT COALESCE(SUM(total), 0)
      INTO v_total
      FROM orders
     WHERE status != 'CANCELADO'
       AND order_date BETWEEN p_desde AND p_hasta;
    RETURN v_total;
END$$

-- ---------------------------------------------------------------
-- FN 3: Stock actual de un producto
-- ---------------------------------------------------------------
CREATE FUNCTION fn_stock_producto(p_product_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_stock INT;
    SELECT stock_actual
      INTO v_stock
      FROM inventory
     WHERE product_id = p_product_id;
    RETURN COALESCE(v_stock, -1);
END$$

-- ---------------------------------------------------------------
-- FN 4: Verificar si un producto tiene stock suficiente
-- ---------------------------------------------------------------
CREATE FUNCTION fn_tiene_stock(p_product_id INT, p_cantidad INT)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE v_stock INT;
    SET v_stock = fn_stock_producto(p_product_id);
    RETURN v_stock >= p_cantidad;
END$$

-- ---------------------------------------------------------------
-- FN 5: Calcular puntos a acumular en una compra (1 pto por c/$1000)
-- ---------------------------------------------------------------
CREATE FUNCTION fn_calcular_puntos(p_total DECIMAL(10,2))
RETURNS INT
DETERMINISTIC
BEGIN
    RETURN FLOOR(p_total / 1000);
END$$

-- ---------------------------------------------------------------
-- FN 6: Total de órdenes de un cliente
-- ---------------------------------------------------------------
CREATE FUNCTION fn_total_ordenes_cliente(p_customer_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_count INT;
    SELECT COUNT(*) INTO v_count
      FROM orders
     WHERE customer_id = p_customer_id
       AND status != 'CANCELADO';
    RETURN COALESCE(v_count, 0);
END$$


-- ================================================================
-- PROCEDIMIENTOS ALMACENADOS
-- ================================================================

-- ---------------------------------------------------------------
-- SP 1: Registrar una nueva orden con sus ítems
--       Parámetros: user_id, customer_id, productos en JSON
-- ---------------------------------------------------------------
CREATE PROCEDURE sp_crear_orden(
    IN p_user_id     INT,
    IN p_customer_id INT,
    IN p_product_id  INT,
    IN p_quantity    INT,
    OUT p_orden_id   INT,
    OUT p_mensaje    VARCHAR(200)
)
BEGIN
    DECLARE v_price  DECIMAL(10,2);
    DECLARE v_stock  INT;

    -- Verificar stock
    SELECT stock_actual INTO v_stock FROM inventory WHERE product_id = p_product_id;
    IF v_stock < p_quantity THEN
        SET p_mensaje = 'ERROR: Stock insuficiente';
        SET p_orden_id = -1;
    ELSE
        SELECT price INTO v_price FROM product WHERE id = p_product_id;

        INSERT INTO orders (user_id, customer_id, total, status)
        VALUES (p_user_id, p_customer_id, v_price * p_quantity, 'PENDIENTE');

        SET p_orden_id = LAST_INSERT_ID();

        INSERT INTO order_item (order_id, product_id, quantity, price_at_time)
        VALUES (p_orden_id, p_product_id, p_quantity, v_price);

        -- Descontar stock
        UPDATE inventory
           SET stock_actual = stock_actual - p_quantity,
               last_update  = NOW()
         WHERE product_id = p_product_id;

        SET p_mensaje = CONCAT('OK: Orden #', p_orden_id, ' creada exitosamente');
    END IF;
END$$

-- ---------------------------------------------------------------
-- SP 2: Generar factura a partir de una orden
-- ---------------------------------------------------------------
CREATE PROCEDURE sp_generar_factura(
    IN  p_order_id      INT,
    IN  p_pago_con      DECIMAL(10,2),
    IN  p_metodo_pago   INT,
    OUT p_invoice_id    INT,
    OUT p_mensaje       VARCHAR(200)
)
BEGIN
    DECLARE v_total    DECIMAL(10,2);
    DECLARE v_cambio   DECIMAL(10,2);
    DECLARE v_inv_num  VARCHAR(20);
    DECLARE v_exist    INT;

    -- Verificar que la orden exista y no esté ya facturada
    SELECT COUNT(*) INTO v_exist FROM invoice WHERE order_id = p_order_id;
    IF v_exist > 0 THEN
        SET p_mensaje    = 'ERROR: Esta orden ya tiene factura';
        SET p_invoice_id = -1;
    ELSE
        SELECT total INTO v_total FROM orders WHERE id = p_order_id;

        IF p_pago_con < v_total THEN
            SET p_mensaje    = 'ERROR: Pago insuficiente';
            SET p_invoice_id = -1;
        ELSE
            SET v_cambio  = p_pago_con - v_total;
            SET v_inv_num = CONCAT('INV-', LPAD(p_order_id, 5, '0'));

            INSERT INTO invoice (order_id, invoice_number, total, pago_con, cambio)
            VALUES (p_order_id, v_inv_num, v_total, p_pago_con, v_cambio);

            SET p_invoice_id = LAST_INSERT_ID();

            -- Registrar pago
            INSERT INTO payment (invoice_id, method_payment_id, amount)
            VALUES (p_invoice_id, p_metodo_pago, v_total);

            -- Actualizar estado de la orden
            UPDATE orders SET status = 'ENTREGADO' WHERE id = p_order_id;

            -- Acumular puntos al cliente
            UPDATE customer
               SET points = points + fn_calcular_puntos(v_total)
             WHERE id = (SELECT customer_id FROM orders WHERE id = p_order_id);

            SET p_mensaje = CONCAT('OK: Factura ', v_inv_num, ' generada. Cambio: $', v_cambio);
        END IF;
    END IF;
END$$

-- ---------------------------------------------------------------
-- SP 3: Ajustar stock de un producto (entrada/salida manual)
-- ---------------------------------------------------------------
CREATE PROCEDURE sp_ajustar_stock(
    IN  p_product_id INT,
    IN  p_cantidad   INT,   -- positivo=entrada, negativo=salida
    IN  p_user_id    INT,
    OUT p_mensaje    VARCHAR(200)
)
BEGIN
    DECLARE v_stock_actual INT;

    SELECT stock_actual INTO v_stock_actual FROM inventory WHERE product_id = p_product_id;

    IF (v_stock_actual + p_cantidad) < 0 THEN
        SET p_mensaje = 'ERROR: No se puede dejar stock negativo';
    ELSE
        UPDATE inventory
           SET stock_actual = stock_actual + p_cantidad,
               last_update  = NOW()
         WHERE product_id = p_product_id;

        INSERT INTO audit_log (user_id, action, table_name, description)
        VALUES (p_user_id, 'UPDATE', 'inventory',
                CONCAT('Ajuste de stock producto_id=', p_product_id, ' cantidad=', p_cantidad));

        SET p_mensaje = CONCAT('OK: Nuevo stock = ', v_stock_actual + p_cantidad);
    END IF;
END$$

-- ---------------------------------------------------------------
-- SP 4: Reporte de ventas por rango de fechas
-- ---------------------------------------------------------------
CREATE PROCEDURE sp_reporte_ventas(
    IN p_desde DATETIME,
    IN p_hasta DATETIME
)
BEGIN
    SELECT
        DATE(o.order_date)  AS fecha,
        COUNT(o.id)         AS num_ordenes,
        SUM(o.total)        AS total_dia,
        CONCAT(pu.first_name, ' ', pu.last_name) AS cajero
    FROM orders o
    JOIN users  u  ON u.id  = o.user_id
    JOIN person pu ON pu.id = u.person_id
    WHERE o.order_date BETWEEN p_desde AND p_hasta
      AND o.status != 'CANCELADO'
    GROUP BY DATE(o.order_date), cajero
    ORDER BY fecha;
END$$

-- ---------------------------------------------------------------
-- SP 5: Registrar usuario con persona en una sola transacción
-- ---------------------------------------------------------------
CREATE PROCEDURE sp_registrar_usuario(
    IN  p_first_name      VARCHAR(50),
    IN  p_last_name       VARCHAR(50),
    IN  p_email           VARCHAR(100),
    IN  p_tipo_usuario    VARCHAR(50),
    IN  p_type_doc_id     INT,
    IN  p_username        VARCHAR(50),
    IN  p_password        VARCHAR(255),
    IN  p_role_id         INT,
    OUT p_user_id         INT,
    OUT p_mensaje         VARCHAR(200)
)
BEGIN
    DECLARE v_person_id INT;

    START TRANSACTION;

    INSERT INTO person (first_name, last_name, email, tipo_usuario, type_document_id)
    VALUES (p_first_name, p_last_name, p_email, p_tipo_usuario, p_type_doc_id);
    SET v_person_id = LAST_INSERT_ID();

    INSERT INTO users (username, password, person_id)
    VALUES (p_username, p_password, v_person_id);
    SET p_user_id = LAST_INSERT_ID();

    INSERT INTO user_role (user_id, role_id) VALUES (p_user_id, p_role_id);

    COMMIT;

    SET p_mensaje = CONCAT('OK: Usuario "', p_username, '" registrado con ID=', p_user_id);
END$$

DELIMITER ;


-- ================================================================
-- EJEMPLOS DE USO
-- ================================================================

-- Consultar vistas
-- SELECT * FROM vw_usuarios_completo;
-- SELECT * FROM vw_inventario;
-- SELECT * FROM vw_stock_bajo;
-- SELECT * FROM vw_ordenes;
-- SELECT * FROM vw_facturas;
-- SELECT * FROM vw_productos_mas_vendidos;
-- SELECT * FROM vw_ventas_por_metodo_pago;
-- SELECT * FROM vw_ventas_por_cajero;
-- SELECT * FROM vw_auditoria;
-- SELECT * FROM vw_permisos_rol;
-- SELECT * FROM vw_personas;
-- SELECT * FROM vw_detalle_ordenes;

-- Usar funciones
-- SELECT fn_nombre_persona(1);
-- SELECT fn_total_ventas('2024-01-01', NOW());
-- SELECT fn_stock_producto(2);
-- SELECT fn_tiene_stock(1, 10);
-- SELECT fn_calcular_puntos(15000);
-- SELECT fn_total_ordenes_cliente(1);

-- Llamar procedimientos
-- CALL sp_ajustar_stock(1, 20, 1, @msg); SELECT @msg;
-- CALL sp_crear_orden(2, 1, 3, 2, @oid, @msg); SELECT @oid, @msg;
-- CALL sp_reporte_ventas('2024-01-01', NOW());
