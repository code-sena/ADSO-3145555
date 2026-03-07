-- ================================================
-- SCRIPT PARA LIMPIAR TODOS LOS DATOS INSERTADOS
-- ================================================

-- Orden: borrar desde las tablas con Foreign Keys hacia las principales
DELETE FROM payment;
DELETE FROM invoice_item;
DELETE FROM invoice;
DELETE FROM order_item;
DELETE FROM "order";
DELETE FROM customer;
DELETE FROM method_payment;
DELETE FROM inventory;
DELETE FROM product;
DELETE FROM supplier;
DELETE FROM category;
DELETE FROM module_view;
DELETE FROM role_module;
DELETE FROM user_role;
DELETE FROM "user";
DELETE FROM vieww;
DELETE FROM module;
DELETE FROM role;
DELETE FROM file;
DELETE FROM person;
DELETE FROM type_document;

-- Verificación
SELECT 'Limpieza completada' AS status;
