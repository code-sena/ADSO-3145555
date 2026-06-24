DROP DATABASE IF EXISTS `coffee_shop`;
CREATE DATABASE `coffee_shop`;
USE `coffee_shop`;

-- ===============================
-- MODULO 2: PARÁMETROS
-- ===============================

CREATE TABLE type_document (
    id INT AUTO_INCREMENT PRIMARY KEY,
    code VARCHAR(10) UNIQUE NOT NULL,
    name VARCHAR(50) NOT NULL,
    status BOOLEAN DEFAULT TRUE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME,
    deleted_at DATETIME
);

CREATE TABLE ficha (
    id INT AUTO_INCREMENT PRIMARY KEY,
    code VARCHAR(20) UNIQUE NOT NULL,
    name VARCHAR(100) NOT NULL,
    status BOOLEAN DEFAULT TRUE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE person (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    tipo_usuario VARCHAR(50),
    type_document_id INT,
    ficha_id INT,
    status BOOLEAN DEFAULT TRUE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (type_document_id) REFERENCES type_document(id),
    FOREIGN KEY (ficha_id) REFERENCES ficha(id)
);

-- ===============================
-- MODULO 1: SEGURIDAD
-- ===============================

CREATE TABLE role (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL,
    status BOOLEAN DEFAULT TRUE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE role_hierarchy (
    id INT AUTO_INCREMENT PRIMARY KEY,
    parent_role_id INT,
    child_role_id INT,
    FOREIGN KEY (parent_role_id) REFERENCES role(id),
    FOREIGN KEY (child_role_id) REFERENCES role(id)
);

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    person_id INT,
    status BOOLEAN DEFAULT TRUE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (person_id) REFERENCES person(id)
);

CREATE TABLE user_role (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    role_id INT,
    status BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (role_id) REFERENCES role(id)
);

CREATE TABLE module (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL,
    status BOOLEAN DEFAULT TRUE
);

CREATE TABLE view (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    route VARCHAR(100) NOT NULL,
    status BOOLEAN DEFAULT TRUE
);

CREATE TABLE role_module (
    id INT AUTO_INCREMENT PRIMARY KEY,
    role_id INT,
    module_id INT,
    status BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (role_id) REFERENCES role(id),
    FOREIGN KEY (module_id) REFERENCES module(id)
);

CREATE TABLE module_view (
    id INT AUTO_INCREMENT PRIMARY KEY,
    module_id INT,
    view_id INT,
    status BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (module_id) REFERENCES module(id),
    FOREIGN KEY (view_id) REFERENCES view(id)
);

-- ===============================
-- MODULO 3: INVENTARIO
-- ===============================

CREATE TABLE category (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    status BOOLEAN DEFAULT TRUE
);

CREATE TABLE supplier (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    contact_name VARCHAR(100),
    phone VARCHAR(20),
    status BOOLEAN DEFAULT TRUE
);

CREATE TABLE product (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    category_id INT,
    supplier_id INT,
    status BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (category_id) REFERENCES category(id),
    FOREIGN KEY (supplier_id) REFERENCES supplier(id)
);

CREATE TABLE inventory (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    stock_actual INT NOT NULL DEFAULT 0,
    stock_minimo INT DEFAULT 5,
    last_update DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES product(id)
);

-- ===============================
-- MODULO 4: VENTAS
-- ===============================

CREATE TABLE customer (
    id INT AUTO_INCREMENT PRIMARY KEY,
    person_id INT,
    points INT DEFAULT 0,
    status BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (person_id) REFERENCES person(id)
);

CREATE TABLE method_payment (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    status BOOLEAN DEFAULT TRUE
);

CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    customer_id INT,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    total DECIMAL(10,2) DEFAULT 0,
    status VARCHAR(20) DEFAULT 'PENDIENTE',
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (customer_id) REFERENCES customer(id)
);

CREATE TABLE order_item (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    price_at_time DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_id) REFERENCES product(id)
);

-- ===============================
-- MODULO 5: FACTURACIÓN
-- ===============================

CREATE TABLE invoice (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    invoice_number VARCHAR(20) UNIQUE,
    total DECIMAL(10,2),
    pago_con DECIMAL(10,2),
    cambio DECIMAL(10,2),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES orders(id)
);

CREATE TABLE invoice_item (
    id INT AUTO_INCREMENT PRIMARY KEY,
    invoice_id INT,
    product_name VARCHAR(100),
    quantity INT,
    price DECIMAL(10,2),
    FOREIGN KEY (invoice_id) REFERENCES invoice(id)
);

CREATE TABLE payment (
    id INT AUTO_INCREMENT PRIMARY KEY,
    invoice_id INT,
    method_payment_id INT,
    amount DECIMAL(10,2),
    payment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (invoice_id) REFERENCES invoice(id),
    FOREIGN KEY (method_payment_id) REFERENCES method_payment(id)
);

-- ===============================
-- AUDITORÍA
-- ===============================

CREATE TABLE audit_log (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    action VARCHAR(255),
    table_name VARCHAR(50),
    description TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- =============================================================
-- 2. DML: INSERCIÓN DE DATOS (10 REGISTROS POR TABLA)
-- =============================================================

-- Parámetros
INSERT INTO type_document (code, name) VALUES ('CC','Cédula'), ('TI','Tarjeta Identidad'), ('CE','Cédula Extranjería'), ('PAS','Pasaporte'), ('PEP','Permiso Especial'), ('PPT','Permiso Protección'), ('NIT','NIT'), ('DNI','DNI'), ('RUT','RUT'), ('NUIP','NUIP');
INSERT INTO ficha (code, name) VALUES ('2555551','ADSO'), ('2555552','Multimedia'), ('2555553','Logística'), ('2555554','Cocina'), ('2555555','Mantenimiento'), ('2555556','Electricidad'), ('2555557','Gestión Administrativa'), ('2555558','Recursos Humanos'), ('2555559','Sistemas'), ('2555560','Contabilidad');
INSERT INTO person (first_name, last_name, email, tipo_usuario, type_document_id, ficha_id) VALUES ('Sharith','Lopez','sharith@mail.com','aprendiz',1,1), ('Jesus','Ariel','jesus@mail.com','instructor',1,1), ('Juan','Perez','juan@mail.com','visitante',2,2), ('Laura','Gomez','laura@mail.com','aprendiz',1,3), ('Andres','Cano','andres@mail.com','aprendiz',1,4), ('Sofia','Ruiz','sofia@mail.com','instructor',1,5), ('Diego','Lopez','diego@mail.com','aprendiz',3,6), ('Marta','Vela','marta@mail.com','visitante',2,7), ('Carlos','Paez','carlos@mail.com','aprendiz',1,8), ('Elena','Sosa','elena@mail.com','aprendiz',1,9);

-- Seguridad
INSERT INTO role (name) VALUES ('ADMIN'), ('CASHIER'), ('INVENTORY'), ('APRENDIZ'), ('INSTRUCTOR'), ('VISITOR'), ('COORDINATOR'), ('CLEANING'), ('SECURITY'), ('MANAGER');
INSERT INTO role_hierarchy (parent_role_id, child_role_id) VALUES (1,2), (1,3), (1,10), (10,2), (2,4), (10,3), (1,7), (1,9), (2,6), (3,8);
INSERT INTO users (username, password, person_id) VALUES ('admin','123',1), ('profe_jesus','123',2), ('user3','123',3), ('user4','123',4), ('user5','123',5), ('user6','123',6), ('user7','123',7), ('user8','123',8), ('user9','123',9), ('user10','123',10);
INSERT INTO user_role (user_id, role_id) VALUES (1,1), (2,5), (3,4), (4,4), (5,3), (6,2), (7,4), (8,6), (9,4), (10,4);
INSERT INTO module (name) VALUES ('Seguridad'), ('Inventario'), ('Ventas'), ('Facturación'), ('Reportes'), ('Usuarios'), ('Productos'), ('Proveedores'), ('Configuración'), ('Auditoría');
INSERT INTO view (name, route) VALUES ('Lista Usuarios','/users'), ('Crear Producto','/prod/new'), ('Caja','/pos'), ('Kardex','/inv/k'), ('Dashboard','/home'), ('Roles','/security/roles'), ('Proveedores','/supp'), ('Categorías','/cat'), ('Mi Perfil','/me'), ('Historial Ventas','/sales/h');
INSERT INTO role_module (role_id, module_id) VALUES (1,1), (1,2), (1,3), (2,3), (3,2), (4,3), (5,3), (6,3), (1,4), (1,5);
INSERT INTO module_view (module_id, view_id) VALUES (1,1), (1,6), (2,2), (2,4), (3,3), (3,10), (4,10), (5,5), (2,7), (2,8);

-- Inventario
INSERT INTO category (name) VALUES ('Café Caliente'), ('Café Frío'), ('Panadería'), ('Repostería'), ('Bebidas'), ('Frutas'), ('Snacks Dulces'), ('Snacks Salados'), ('Desayunos'), ('Adicionales');
INSERT INTO supplier (name, contact_name) VALUES ('Sello Rojo','Juan Café'), ('Colanta','Luis Leche'), ('Bimbo','Ana Pan'), ('Postobón','Carlos Soda'), ('Frubana','Marta Fruta'), ('Nestlé','Pedro Choco'), ('Levapan','Sofía Masa'), ('Donas S.A.','Raúl Dulce'), ('Nutresa','Elena Galleta'), ('Mercado Local','Don José');
INSERT INTO product (name, price, category_id, supplier_id) VALUES ('Café Americano',2500,1,1), ('Capuchino',4500,1,2), ('Tinto',1500,1,1), ('Café Latte',4000,1,2), ('Mocaccino',5000,1,6), ('Pan de Bono',2000,3,3), ('Dona Glaseada',3500,4,8), ('Torta Chocolate',6000,4,7), ('Jugo Natural',4000,5,5), ('Croissant Queso',2800,3,3);
INSERT INTO inventory (product_id, stock_actual) VALUES (1,100), (2,50), (3,150), (4,40), (5,30), (6,60), (7,25), (8,15), (9,45), (10,35);

-- Ventas y Facturación
INSERT INTO customer (person_id, points) VALUES (1,10), (2,50), (3,0), (4,25), (5,15), (6,5), (7,30), (8,12), (9,40), (10,100);
INSERT INTO method_payment (name) VALUES ('Efectivo'), ('Nequi'), ('Daviplata'), ('Tarjeta Débito'), ('Bono SENA'), ('Transferencia'), ('Tarjeta Crédito'), ('Sodexo'), ('Paypal'), ('QR Bancolombia');
INSERT INTO orders (user_id, customer_id, total, status) VALUES (2,1,7000,'ENTREGADO'), (2,2,4500,'ENTREGADO'), (2,3,2500,'ENTREGADO'), (2,4,6000,'PENDIENTE'), (2,5,3500,'ENTREGADO'), (6,6,1500,'ENTREGADO'), (6,7,5000,'ENTREGADO'), (6,8,2000,'ENTREGADO'), (6,9,8000,'ENTREGADO'), (6,10,12000,'ENTREGADO');
INSERT INTO order_item (order_id, product_id, quantity, price_at_time) VALUES (1,1,1,2500), (1,2,1,4500), (2,2,1,4500), (3,3,1,1500), (4,8,1,6000), (5,7,1,3500), (6,3,1,1500), (7,5,1,5000), (8,6,1,2000), (9,9,2,4000);
INSERT INTO invoice (order_id, invoice_number, total, pago_con, cambio) VALUES (1,'INV-001',7000,10000,3000), (2,'INV-002',4500,5000,500), (3,'INV-003',2500,2500,0), (4,'INV-004',6000,10000,4000), (5,'INV-005',3500,10000,6500), (6,'INV-006',1500,2000,500), (7,'INV-007',5000,5000,0), (8,'INV-008',2000,10000,8000), (9,'INV-009',8000,10000,2000), (10,'INV-010',12000,20000,8000);
INSERT INTO invoice_item (invoice_id, product_name, quantity, price) VALUES (1,'Café Americano',1,2500), (1,'Capuchino',1,4500), (2,'Capuchino',1,4500), (3,'Tinto',1,1500), (4,'Torta Chocolate',1,6000), (5,'Dona Glaseada',1,3500), (6,'Tinto',1,1500), (7,'Mocaccino',1,5000), (8,'Pan de Bono',1,2000), (9,'Jugo Natural',2,4000);
INSERT INTO payment (invoice_id, method_payment_id, amount) VALUES (1,1,7000), (2,2,4500), (3,1,2500), (4,3,6000), (5,1,3500), (6,1,1500), (7,4,5000), (8,1,2000), (9,5,8000), (10,1,12000);
INSERT INTO audit_log (user_id, action, table_name, description) VALUES (1,'LOGIN','users','Admin inició sesión'), (1,'INSERT','product','Se agregó Café Americano'), (2,'UPDATE','inventory','Ajuste de stock'), (1,'DELETE','users','Limpieza de usuarios'), (2,'LOGIN','users','Cajero inició sesión'), (3,'UPDATE','product','Cambio precio'), (1,'UPDATE','role','Permiso extendido'), (2,'INSERT','invoice','Factura generada'), (1,'INSERT','category','Nueva categoría'), (2,'LOGOUT','users','Cierre de sesión');
CREATE TABLE order_item (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    order_id BIGINT,
    product_id BIGINT,
    quantity INT NOT NULL,
    price_at_time DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_id) REFERENCES product(id)
);

CREATE TABLE invoice (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    order_id BIGINT,
    invoice_number VARCHAR(20) UNIQUE,
    total DECIMAL(10,2),
    pago_con DECIMAL(10,2),
    cambio DECIMAL(10,2),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES orders(id)
);

CREATE TABLE invoice_item (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    invoice_id BIGINT,
    product_name VARCHAR(100),
    quantity INT,
    price DECIMAL(10,2),
    FOREIGN KEY (invoice_id) REFERENCES invoice(id)
);

CREATE TABLE payment (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    invoice_id BIGINT,
    method_payment_id BIGINT,
    amount DECIMAL(10,2),
    payment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (invoice_id) REFERENCES invoice(id),
    FOREIGN KEY (method_payment_id) REFERENCES method_payment(id)
);

INSERT INTO type_document (code, name) VALUES ('CC','Cédula'), ('TI','Tarjeta Identidad'), ('CE','Cédula Extranjería'), ('PAS','Pasaporte'), ('PEP','Permiso Especial'), ('PPT','Permiso Protección'), ('NIT','NIT'), ('DNI','DNI'), ('RUT','RUT'), ('NUIP','NUIP');

INSERT INTO ficha (code, name) VALUES ('2555551','ADSO'), ('2555552','Multimedia'), ('2555553','Logística'), ('2555554','Cocina'), ('2555555','Mantenimiento'), ('2555556','Electricidad'), ('2555557','Gestión Administrativa'), ('2555558','Recursos Humanos'), ('2555559','Sistemas'), ('2555560','Contabilidad');

INSERT INTO role (name) VALUES ('ADMIN'), ('CASHIER'), ('INVENTORY'), ('APRENDIZ'), ('INSTRUCTOR'), ('VISITOR'), ('COORDINATOR'), ('CLEANING'), ('SECURITY'), ('MANAGER');

INSERT INTO person (first_name, last_name, email, tipo_usuario, type_document_id, ficha_id) VALUES
('Sharith', 'Lopez', 'sharith@mail.com', 'aprendiz', 1, 1), ('Jesus', 'Ariel', 'jesus@mail.com', 'instructor', 1, 1), ('Juan', 'Perez', 'juan@mail.com', 'visitante', 2, 2),
('Laura', 'Gomez', 'laura@mail.com', 'aprendiz', 1, 3), ('Andres', 'Cano', 'andres@mail.com', 'aprendiz', 1, 4), ('Sofia', 'Ruiz', 'sofia@mail.com', 'instructor', 1, 5),
('Diego', 'Lopez', 'diego@mail.com', 'aprendiz', 3, 6), ('Marta', 'Vela', 'marta@mail.com', 'visitante', 2, 7), ('Carlos', 'Paez', 'carlos@mail.com', 'aprendiz', 1, 8),
('Elena', 'Sosa', 'elena@mail.com', 'aprendiz', 1, 9);

INSERT INTO users (username, password, person_id) VALUES
('admin', '123', 1), ('profe_jesus', '123', 2), ('user3', '123', 3), ('user4', '123', 4), ('user5', '123', 5),
('user6', '123', 6), ('user7', '123', 7), ('user8', '123', 8), ('user9', '123', 9), ('user10', '123', 10);

INSERT INTO user_role (user_id, role_id) VALUES (1,1), (2,5), (3,4), (4,4), (5,3), (6,2), (7,4), (8,6), (9,4), (10,4);

INSERT INTO module (name) VALUES ('Seguridad'), ('Inventario'), ('Ventas'), ('Facturación'), ('Reportes'), ('Usuarios'), ('Productos'), ('Proveedores'), ('Configuración'), ('Auditoría');

INSERT INTO view (name, route) VALUES ('Lista Usuarios', '/users'), ('Crear Producto', '/prod/new'), ('Caja', '/pos'), ('Kardex', '/inv/k'), ('Dashboard', '/home'), ('Roles', '/security/roles'), ('Proveedores', '/supp'), ('Categorías', '/cat'), ('Mi Perfil', '/me'), ('Historial Ventas', '/sales/h');

INSERT INTO role_module (role_id, module_id) VALUES (1,1), (1,2), (1,3), (2,3), (3,2), (4,3), (5,3), (6,3), (1,4), (1,5);

INSERT INTO module_view (module_id, view_id) VALUES (1,1), (1,6), (2,2), (2,4), (3,3), (3,10), (4,10), (5,5), (2,7), (2,8);

INSERT INTO category (name) VALUES ('Café Caliente'), ('Café Frío'), ('Panadería'), ('Repostería'), ('Bebidas Embote'), ('Frutas'), ('Snacks Dulces'), ('Snacks Salados'), ('Desayunos'), ('Adicionales');

INSERT INTO supplier (name, contact_name) VALUES ('Sello Rojo','Juan Café'), ('Colanta','Luis Leche'), ('Bimbo','Ana Pan'), ('Postobón','Carlos Soda'), ('Frubana','Marta Fruta'), ('Nestlé','Pedro Choco'), ('Levapan','Sofía Masa'), ('Donas S.A.','Raúl Dulce'), ('Nutresa','Elena Galleta'), ('Mercado Local','Don José');

INSERT INTO product (name, price, category_id, supplier_id) VALUES
('Café Americano', 2500, 1, 1), ('Capuchino', 4500, 1, 2), ('Tinto', 1500, 1, 1), ('Café Latte', 4000, 1, 2),
('Mocaccino', 5000, 1, 6), ('Pan de Bono', 2000, 3, 3), ('Dona Glaseada', 3500, 4, 8), ('Torta Chocolate', 6000, 4, 7),
('Jugo Natural', 4000, 5, 5), ('Croissant Queso', 2800, 3, 3);

INSERT INTO inventory (product_id, stock_actual) VALUES (1,100), (2,50), (3,150), (4,40), (5,30), (6,60), (7,25), (8,15), (9,45), (10,35);

INSERT INTO customer (person_id, points) VALUES (1,10), (2,50), (3,0), (4,25), (5,15), (6,5), (7,30), (8,12), (9,40), (10,100);

INSERT INTO method_payment (name) VALUES ('Efectivo'), ('Nequi'), ('Daviplata'), ('Tarjeta Débito'), ('Bono SENA'), ('Transferencia'), ('Tarjeta Crédito'), ('Sodexo'), ('Paypal'), ('QR Bancolombia');

INSERT INTO orders (user_id, customer_id, total, status) VALUES (2,1,7000,'ENTREGADO'), (2,2,4500,'ENTREGADO'), (2,3,2500,'ENTREGADO'), (2,4,6000,'PENDIENTE'), (2,5,3500,'ENTREGADO'), (6,6,1500,'ENTREGADO'), (6,7,5000,'ENTREGADO'), (6,8,2000,'ENTREGADO'), (6,9,8000,'ENTREGADO'), (6,10,12000,'ENTREGADO');

INSERT INTO order_item (order_id, product_id, quantity, price_at_time) VALUES (1,1,1,2500), (1,2,1,4500), (2,2,1,4500), (3,3,1,1500), (4,8,1,6000), (5,7,1,3500), (6,3,1,1500), (7,5,1,5000), (8,6,1,2000), (9,9,2,4000);

INSERT INTO invoice (order_id, invoice_number, total, pago_con, cambio) VALUES (1,'INV-001',7000,10000,3000), (2,'INV-002',4500,5000,500), (3,'INV-003',2500,2500,0), (5,'INV-004',3500,10000,6500), (6,'INV-005',1500,2000,500), (7,'INV-006',5000,5000,0), (8,'INV-007',2000,10000,8000), (9,'INV-008',8000,10000,2000), (10,'INV-009',12000,20000,8000), (1,'INV-010',7000,50000,43000);

INSERT INTO invoice_item (invoice_id, product_name, quantity, price) VALUES (1,'Café Americano',1,2500), (1,'Capuchino',1,4500), (2,'Capuchino',1,4500), (3,'Tinto',1,1500), (4,'Torta Chocolate',1,6000), (5,'Dona Glaseada',1,3500), (6,'Tinto',1,1500), (7,'Mocaccino',1,5000), (8,'Pan de Bono',1,2000), (9,'Jugo Natural',2,4000);

INSERT INTO payment (invoice_id, method_payment_id, amount) VALUES (1,1,7000), (2,2,4500), (3,1,2500), (4,3,6000), (5,1,3500), (6,1,1500), (7,4,5000), (8,1,2000), (9,5,8000), (10,1,12000);