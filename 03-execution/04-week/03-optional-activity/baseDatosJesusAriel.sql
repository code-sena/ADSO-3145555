CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE TABLE type_document(
id_type_document UUID DEFAULT gen_random_uuid() PRIMARY KEY,
name_document VARCHAR(50),
created_at TIMESTAMPTZ DEFAULT NOW(),
updated_at TIMESTAMPTZ,
deleted_at TIMESTAMPTZ,
created_by UUID,
updated_by UUID,
deleted_by UUID,
status BOOLEAN DEFAULT TRUE
);

CREATE TABLE files(
id_file UUID DEFAULT gen_random_uuid() PRIMARY KEY,
name_file VARCHAR(100),
created_at TIMESTAMPTZ DEFAULT NOW(),
updated_at TIMESTAMPTZ,
deleted_at TIMESTAMPTZ,
created_by UUID,
updated_by UUID,
deleted_by UUID,
status BOOLEAN DEFAULT TRUE
);

CREATE TABLE person(
id_person UUID DEFAULT gen_random_uuid() PRIMARY KEY,
name_person VARCHAR(100),
email VARCHAR(100),
document_number VARCHAR(50),
type_document_id UUID,
file_id UUID,
created_at TIMESTAMPTZ DEFAULT NOW(),
updated_at TIMESTAMPTZ,
deleted_at TIMESTAMPTZ,
created_by UUID,
updated_by UUID,
deleted_by UUID,
status BOOLEAN DEFAULT TRUE
);

CREATE TABLE users(
id_users UUID DEFAULT gen_random_uuid() PRIMARY KEY,
user_name VARCHAR(100),
password_user VARCHAR(100),
id_person UUID,
created_at TIMESTAMPTZ DEFAULT NOW(),
updated_at TIMESTAMPTZ,
deleted_at TIMESTAMPTZ,
created_by UUID,
updated_by UUID,
deleted_by UUID,
status BOOLEAN DEFAULT TRUE
);


CREATE TABLE roles(
id_role UUID DEFAULT gen_random_uuid() PRIMARY KEY,
name_role VARCHAR(50),
created_at TIMESTAMPTZ DEFAULT NOW(),
updated_at TIMESTAMPTZ,
deleted_at TIMESTAMPTZ,
created_by UUID,
updated_by UUID,
deleted_by UUID,
status BOOLEAN DEFAULT TRUE
);


CREATE TABLE user_role(
id_user_role UUID DEFAULT gen_random_uuid() PRIMARY KEY,
users_id UUID,
role_id UUID,
created_at TIMESTAMPTZ DEFAULT NOW(),
updated_at TIMESTAMPTZ,
deleted_at TIMESTAMPTZ,
created_by UUID,
updated_by UUID,
deleted_by UUID,
status BOOLEAN DEFAULT TRUE
);


CREATE TABLE modules(
id_module UUID DEFAULT gen_random_uuid() PRIMARY KEY,
name_modules VARCHAR(100),
created_at TIMESTAMPTZ DEFAULT NOW(),
updated_at TIMESTAMPTZ,
deleted_at TIMESTAMPTZ,
created_by UUID,
updated_by UUID,
deleted_by UUID,
status BOOLEAN DEFAULT TRUE
);


CREATE TABLE app_view(
id_view UUID DEFAULT gen_random_uuid() PRIMARY KEY,
name_view VARCHAR(100),
rout VARCHAR(150),
created_at TIMESTAMPTZ DEFAULT NOW(),
updated_at TIMESTAMPTZ,
deleted_at TIMESTAMPTZ,
created_by UUID,
updated_by UUID,
deleted_by UUID,
status BOOLEAN DEFAULT TRUE
);


CREATE TABLE module_view(
id_module_view UUID DEFAULT gen_random_uuid() PRIMARY KEY,
module_id UUID,
view_id UUID,
created_at TIMESTAMPTZ DEFAULT NOW(),
updated_at TIMESTAMPTZ,
deleted_at TIMESTAMPTZ,
created_by UUID,
updated_by UUID,
deleted_by UUID,
status BOOLEAN DEFAULT TRUE
);


CREATE TABLE category(
id_category UUID DEFAULT gen_random_uuid() PRIMARY KEY,
name_category VARCHAR(100),
created_at TIMESTAMPTZ DEFAULT NOW(),
updated_at TIMESTAMPTZ,
deleted_at TIMESTAMPTZ,
created_by UUID,
updated_by UUID,
deleted_by UUID,
status BOOLEAN DEFAULT TRUE
);


CREATE TABLE supplier(
id_supplier UUID DEFAULT gen_random_uuid() PRIMARY KEY,
name_supplier VARCHAR(100),
created_at TIMESTAMPTZ DEFAULT NOW(),
updated_at TIMESTAMPTZ,
deleted_at TIMESTAMPTZ,
created_by UUID,
updated_by UUID,
deleted_by UUID,
status BOOLEAN DEFAULT TRUE
);


CREATE TABLE product(
id_product UUID DEFAULT gen_random_uuid() PRIMARY KEY,
name_product VARCHAR(100),
description VARCHAR(100),
price NUMERIC(12,2),
supplier_id UUID,
category_id UUID,
created_at TIMESTAMPTZ DEFAULT NOW(),
updated_at TIMESTAMPTZ,
deleted_at TIMESTAMPTZ,
created_by UUID,
updated_by UUID,
deleted_by UUID,
status BOOLEAN DEFAULT TRUE
);


CREATE TABLE inventory(
id_inventory UUID DEFAULT gen_random_uuid() PRIMARY KEY,
quantity INTEGER,
product_id UUID,
created_at TIMESTAMPTZ DEFAULT NOW(),
updated_at TIMESTAMPTZ,
deleted_at TIMESTAMPTZ,
created_by UUID,
updated_by UUID,
deleted_by UUID,
status BOOLEAN DEFAULT TRUE
);

CREATE TABLE customer(
id_customer UUID DEFAULT gen_random_uuid() PRIMARY KEY,
person_id UUID,
created_at TIMESTAMPTZ DEFAULT NOW(),
updated_at TIMESTAMPTZ,
deleted_at TIMESTAMPTZ,
created_by UUID,
updated_by UUID,
deleted_by UUID,
status BOOLEAN DEFAULT TRUE
);


CREATE TABLE app_order(
id_order UUID DEFAULT gen_random_uuid() PRIMARY KEY,
order_date TIMESTAMPTZ DEFAULT NOW(),
order_status VARCHAR(50),
total NUMERIC(12,2),
customer_id UUID,
created_at TIMESTAMPTZ DEFAULT NOW(),
updated_at TIMESTAMPTZ,
deleted_at TIMESTAMPTZ,
created_by UUID,
updated_by UUID,
deleted_by UUID,
status BOOLEAN DEFAULT TRUE
);


CREATE TABLE order_item(
id_order_item UUID DEFAULT gen_random_uuid() PRIMARY KEY,
orden_id UUID,
product_id UUID,
quantity INTEGER,
subtotal NUMERIC(12,2),
created_at TIMESTAMPTZ DEFAULT NOW(),
updated_at TIMESTAMPTZ,
deleted_at TIMESTAMPTZ,
created_by UUID,
updated_by UUID,
deleted_by UUID,
status BOOLEAN DEFAULT TRUE
);

CREATE TABLE invoice(
id_invoice UUID DEFAULT gen_random_uuid() PRIMARY KEY,
order_id UUID,
invoice_number VARCHAR(50),
issue_date TIMESTAMPTZ,
total NUMERIC(10,2),
invoice_status VARCHAR(50),
created_at TIMESTAMPTZ DEFAULT NOW(),
updated_at TIMESTAMPTZ,
deleted_at TIMESTAMPTZ,
created_by UUID,
updated_by UUID,
deleted_by UUID,
status BOOLEAN DEFAULT TRUE
);


CREATE TABLE invoice_item(
id_invoice_item UUID DEFAULT gen_random_uuid() PRIMARY KEY,
invoice_id UUID,
product_id UUID,
quantity INTEGER,
unit_price NUMERIC(10,2),
subtotal NUMERIC(10,2),
created_at TIMESTAMPTZ DEFAULT NOW(),
status BOOLEAN DEFAULT TRUE
);


CREATE TABLE method_payment(
id_method_payment UUID DEFAULT gen_random_uuid() PRIMARY KEY,
name_method_payment VARCHAR(50),
created_at TIMESTAMPTZ DEFAULT NOW(),
updated_at TIMESTAMPTZ,
deleted_at TIMESTAMPTZ,
created_by UUID,
updated_by UUID,
deleted_by UUID,
status BOOLEAN DEFAULT TRUE
);

CREATE TABLE payment(
id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
invoice_id UUID,
method_payment_id UUID,
amount NUMERIC(10,2),
payment_date TIMESTAMPTZ DEFAULT NOW(),
created_at TIMESTAMPTZ DEFAULT NOW(),
updated_at TIMESTAMPTZ,
deleted_at TIMESTAMPTZ,
created_by UUID,
updated_by UUID,
deleted_by UUID,
status BOOLEAN DEFAULT TRUE
);




---INSERT


INSERT INTO type_document (name_document) VALUES
('Cédula'),
('Pasaporte'),
('Tarjeta Identidad'),
('Licencia Conducción'),
('NIT'),
('Registro Civil'),
('PEP'),
('DNI'),
('Documento Militar'),
('Carnet Estudiantil');

INSERT INTO files (name_file) VALUES
('doc1.pdf'),
('doc2.pdf'),
('doc3.pdf'),
('doc4.pdf'),
('doc5.pdf'),
('doc6.pdf'),
('doc7.pdf'),
('doc8.pdf'),
('doc9.pdf'),
('doc10.pdf');



INSERT INTO person (name_person,email,document_number,type_document_id,file_id)
SELECT 
'Persona ' || g,
'persona'||g||'@mail.com',
1000+g,
(SELECT id_type_document FROM type_document ORDER BY RANDOM() LIMIT 1),
(SELECT id_file FROM files ORDER BY RANDOM() LIMIT 1)
FROM generate_series(1,10) g;

INSERT INTO users (user_name,password_user,id_person)
SELECT 
name_person,
'123456',
id_person
FROM person
LIMIT 10;


INSERT INTO roles (name_role) VALUES
('Administrador'),
('Empleado'),
('Cliente'),
('Supervisor'),
('Vendedor'),
('Cajero'),
('Gerente'),
('Soporte'),
('Invitado'),
('Auditor');

INSERT INTO user_role (users_id,role_id)
SELECT 
(SELECT id_users FROM users ORDER BY RANDOM() LIMIT 1),
(SELECT id_role FROM roles ORDER BY RANDOM() LIMIT 1)
FROM generate_series(1,10);

INSERT INTO supplier (name_supplier) VALUES
('Proveedor nutresa'),
('Proveedor coca-cola'),
('Proveedor colanta'),
('Proveedor centrosur'),
('Proveedor superior'),
('Proveedor casaluker'),
('Proveedor roa'),
('Proveedor florhuila'),
('Proveedor soberana'),
('Proveedor bimbo');


INSERT INTO category (name_category) VALUES
('Electrónica'),
('Ropa'),
('Hogar'),
('Deportes'),
('Tecnología'),
('Juguetes'),
('Alimentos'),
('Bebidas'),
('Libros'),
('Accesorios');

INSERT INTO product (name_product,description,price,supplier_id,category_id)
SELECT
'Producto '||g,
'Descripción producto '||g,
(100*g),
(SELECT id_supplier FROM supplier ORDER BY RANDOM() LIMIT 1),
(SELECT id_category FROM category ORDER BY RANDOM() LIMIT 1)
FROM generate_series(1,10) g;

INSERT INTO inventory (quantity, product_id)
SELECT
10,
id_product
FROM product
LIMIT 10;

INSERT INTO customer (person_id)
SELECT id_person
FROM person
LIMIT 10;

INSERT INTO app_order (order_status,total,customer_id)
SELECT
'Pendiente',
(200*g),
(SELECT id_customer FROM customer ORDER BY RANDOM() LIMIT 1)
FROM generate_series(1,10) g;

INSERT INTO order_item (orden_id,product_id,quantity,subtotal)
SELECT
(SELECT id_order FROM app_order ORDER BY RANDOM() LIMIT 1),
(SELECT id_product FROM product ORDER BY RANDOM() LIMIT 1),
(1+floor(random()*5)),
(100+floor(random()*500))
FROM generate_series(1,10);

INSERT INTO invoice (order_id, invoice_number, total, invoice_status)
SELECT
id_order,
'F001',
500,
'Pagada'
FROM app_order
LIMIT 10;


INSERT INTO invoice_item (invoice_id,product_id,quantity,unit_price,subtotal)
SELECT
(SELECT id_invoice FROM invoice ORDER BY RANDOM() LIMIT 1),
(SELECT id_product FROM product ORDER BY RANDOM() LIMIT 1),
(1+floor(random()*5)),
(100),
(200)
FROM generate_series(1,10);

INSERT INTO method_payment (name_method_payment) VALUES
('Efectivo'),
('Tarjeta Débito'),
('Tarjeta Crédito'),
('Transferencia'),
('Nequi'),
('Daviplata'),
('PayPal'),
('Consignación'),
('Cheque'),
('Crédito');

INSERT INTO payment (invoice_id,method_payment_id,amount)
SELECT
(SELECT id_invoice FROM invoice ORDER BY RANDOM() LIMIT 1),
(SELECT id_method_payment FROM method_payment ORDER BY RANDOM() LIMIT 1),
(100+floor(random()*900))
FROM generate_series(1,10);















