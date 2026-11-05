

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE role (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(100) NOT NULL,
    description TEXT,
    status VARCHAR(20) DEFAULT 'active'
);


CREATE TABLE "user" (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    person_id UUID,
    email VARCHAR(150) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    status VARCHAR(20) DEFAULT 'active'
);

CREATE TABLE user_role (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL,
    role_id UUID NOT NULL,
    CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES "user"(id),
    CONSTRAINT fk_role FOREIGN KEY (role_id) REFERENCES role(id)
);


CREATE TABLE type_document (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(100) NOT NULL,
    code VARCHAR(20) NOT NULL,
    status VARCHAR(20) DEFAULT 'active'
);


CREATE TABLE person (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    document_number VARCHAR(50) NOT NULL,
    type_document_id UUID,
    phone VARCHAR(20),
    email VARCHAR(150),
    status VARCHAR(20) DEFAULT 'active',
    CONSTRAINT fk_type_document FOREIGN KEY (type_document_id) REFERENCES type_document(id)
);

ALTER TABLE "user"
ADD CONSTRAINT fk_person
FOREIGN KEY (person_id) REFERENCES person(id);



CREATE TABLE category (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(100) NOT NULL,
    status VARCHAR(20) DEFAULT 'active'
);

CREATE TABLE product (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(150) NOT NULL,
    description TEXT,
    price NUMERIC(10,2) NOT NULL CHECK (price >= 0),
    category_id UUID,
    status VARCHAR(20) DEFAULT 'active',
    CONSTRAINT fk_category FOREIGN KEY (category_id) REFERENCES category(id)
);


CREATE TABLE inventory (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    product_id UUID UNIQUE,
    stock INTEGER NOT NULL CHECK (stock >= 0),
    minimum_stock INTEGER DEFAULT 0,
    last_update TIMESTAMPTZ DEFAULT NOW(), 
    CONSTRAINT fk_product FOREIGN KEY (product_id) REFERENCES product(id)
);


CREATE TABLE orders (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL,
    status VARCHAR(20) DEFAULT 'pending',
    total NUMERIC(10,2) DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT NOW(), 
    CONSTRAINT fk_order_user FOREIGN KEY (user_id) REFERENCES "user"(id)
);

CREATE TABLE order_item (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    order_id UUID NOT NULL,
    product_id UUID NOT NULL,
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    price NUMERIC(10,2) NOT NULL CHECK (price >= 0),
    subtotal NUMERIC(10,2) NOT NULL,
    CONSTRAINT fk_order FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    CONSTRAINT fk_product_order FOREIGN KEY (product_id) REFERENCES product(id)
);


INSERT INTO role (name, description, status) VALUES
('Administrador', 'Acceso total al sistema', 'active'),
('Cajero', 'Gestiona ventas y cobros', 'active'),
('Inventarista', 'Administra inventario y productos', 'active'),
('Mesero', 'Atiende pedidos de clientes', 'active'),
('Gerente', 'Supervisa operaciones generales', 'active'),
('Contador', 'Gestiona finanzas y reportes', 'active'),
('Chef', 'Prepara alimentos', 'active'),
('Aprendiz', 'Usuario en entrenamiento', 'active'),
('Cliente', 'Realiza pedidos', 'active'),
('Proveedor', 'Suministra productos', 'inactive');


INSERT INTO type_document (name, code, status) VALUES
('Cédula de Ciudadanía', 'CC', 'active'),
('Tarjeta de Identidad', 'TI', 'active'),
('Cédula de Extranjería', 'CE', 'active'),
('Pasaporte', 'PA', 'active'),
('NIT', 'NIT', 'active'),
('Registro Civil', 'RC', 'active'),
('Permiso Especial de Permanencia', 'PEP', 'active'),
('Documento Nacional de Identidad', 'DNI', 'active'),
('Licencia de Conducción', 'LC', 'inactive'),
('Carné Estudiantil', 'CE_EST', 'active');


INSERT INTO person (first_name, last_name, document_number, type_document_id, phone, email, status) VALUES
('Daniel', 'Salazar', '1001234567', (SELECT id FROM type_document WHERE code = 'CC' LIMIT 1), '3101234567', 'daniel.salazar@sena.edu.co', 'active'),
('María José', 'Rodríguez', '1001234568', (SELECT id FROM type_document WHERE code = 'CC' LIMIT 1), '3101234568', 'maria.rodriguez@sena.edu.co', 'active'),
('Carlos', 'Gómez', '1001234569', (SELECT id FROM type_document WHERE code = 'CC' LIMIT 1), '3101234569', 'carlos.gomez@sena.edu.co', 'active'),
('Ana', 'Martínez', '1001234570', (SELECT id FROM type_document WHERE code = 'CC' LIMIT 1), '3101234570', 'ana.martinez@sena.edu.co', 'active'),
('Luis', 'Pérez', '1001234571', (SELECT id FROM type_document WHERE code = 'TI' LIMIT 1), '3101234571', 'luis.perez@sena.edu.co', 'active'),
('Laura', 'García', '1001234572', (SELECT id FROM type_document WHERE code = 'CC' LIMIT 1), '3101234572', 'laura.garcia@sena.edu.co', 'active'),
('Juan', 'López', '1001234573', (SELECT id FROM type_document WHERE code = 'CC' LIMIT 1), '3101234573', 'juan.lopez@sena.edu.co', 'active'),
('Sofía', 'Hernández', '1001234574', (SELECT id FROM type_document WHERE code = 'CC' LIMIT 1), '3101234574', 'sofia.hernandez@sena.edu.co', 'active'),
('Miguel', 'Torres', '1001234575', (SELECT id FROM type_document WHERE code = 'CE' LIMIT 1), '3101234575', 'miguel.torres@sena.edu.co', 'active'),
('Valentina', 'Ramírez', '1001234576', (SELECT id FROM type_document WHERE code = 'CC' LIMIT 1), '3101234576', 'valentina.ramirez@sena.edu.co', 'inactive');

-- USUARIOS
INSERT INTO "user" (person_id, email, password, status) VALUES
((SELECT id FROM person WHERE document_number = '1001234567' LIMIT 1), 'daniel.salazar@sena.edu.co', '$2a$10$password123hash', 'active'),
((SELECT id FROM person WHERE document_number = '1001234568' LIMIT 1), 'maria.rodriguez@sena.edu.co', '$2a$10$password123hash', 'active'),
((SELECT id FROM person WHERE document_number = '1001234569' LIMIT 1), 'carlos.gomez@sena.edu.co', '$2a$10$password123hash', 'active'),
((SELECT id FROM person WHERE document_number = '1001234570' LIMIT 1), 'ana.martinez@sena.edu.co', '$2a$10$password123hash', 'active'),
((SELECT id FROM person WHERE document_number = '1001234571' LIMIT 1), 'luis.perez@sena.edu.co', '$2a$10$password123hash', 'active'),
((SELECT id FROM person WHERE document_number = '1001234572' LIMIT 1), 'laura.garcia@sena.edu.co', '$2a$10$password123hash', 'active'),
((SELECT id FROM person WHERE document_number = '1001234573' LIMIT 1), 'juan.lopez@sena.edu.co', '$2a$10$password123hash', 'active'),
((SELECT id FROM person WHERE document_number = '1001234574' LIMIT 1), 'sofia.hernandez@sena.edu.co', '$2a$10$password123hash', 'active'),
((SELECT id FROM person WHERE document_number = '1001234575' LIMIT 1), 'miguel.torres@sena.edu.co', '$2a$10$password123hash', 'active'),
((SELECT id FROM person WHERE document_number = '1001234576' LIMIT 1), 'valentina.ramirez@sena.edu.co', '$2a$10$password123hash', 'inactive');


INSERT INTO user_role (user_id, role_id) VALUES
((SELECT id FROM "user" WHERE email = 'daniel.salazar@sena.edu.co' LIMIT 1), (SELECT id FROM role WHERE name = 'Administrador' LIMIT 1)),
((SELECT id FROM "user" WHERE email = 'maria.rodriguez@sena.edu.co' LIMIT 1), (SELECT id FROM role WHERE name = 'Gerente' LIMIT 1)),
((SELECT id FROM "user" WHERE email = 'carlos.gomez@sena.edu.co' LIMIT 1), (SELECT id FROM role WHERE name = 'Cajero' LIMIT 1)),
((SELECT id FROM "user" WHERE email = 'ana.martinez@sena.edu.co' LIMIT 1), (SELECT id FROM role WHERE name = 'Mesero' LIMIT 1)),
((SELECT id FROM "user" WHERE email = 'luis.perez@sena.edu.co' LIMIT 1), (SELECT id FROM role WHERE name = 'Inventarista' LIMIT 1)),
((SELECT id FROM "user" WHERE email = 'laura.garcia@sena.edu.co' LIMIT 1), (SELECT id FROM role WHERE name = 'Chef' LIMIT 1)),
((SELECT id FROM "user" WHERE email = 'juan.lopez@sena.edu.co' LIMIT 1), (SELECT id FROM role WHERE name = 'Aprendiz' LIMIT 1)),
((SELECT id FROM "user" WHERE email = 'sofia.hernandez@sena.edu.co' LIMIT 1), (SELECT id FROM role WHERE name = 'Cliente' LIMIT 1)),
((SELECT id FROM "user" WHERE email = 'miguel.torres@sena.edu.co' LIMIT 1), (SELECT id FROM role WHERE name = 'Contador' LIMIT 1)),
((SELECT id FROM "user" WHERE email = 'valentina.ramirez@sena.edu.co' LIMIT 1), (SELECT id FROM role WHERE name = 'Proveedor' LIMIT 1));


INSERT INTO category (name, status) VALUES
('Bebidas Calientes', 'active'),
('Bebidas Frías', 'active'),
('Panadería', 'active'),
('Snacks', 'active'),
('Almuerzos', 'active'),
('Postres', 'active'),
('Ensaladas', 'active'),
('Jugos Naturales', 'active'),
('Comida Rápida', 'active'),
('Productos Descontinuados', 'inactive');


INSERT INTO product (name, description, price, category_id, status) VALUES
('Café Americano', 'Café negro de 8oz', 2500.00, (SELECT id FROM category WHERE name = 'Bebidas Calientes' LIMIT 1), 'active'),
('Cappuccino', 'Café con leche espumada 12oz', 4500.00, (SELECT id FROM category WHERE name = 'Bebidas Calientes' LIMIT 1), 'active'),
('Jugo de Naranja Natural', 'Jugo recién exprimido 12oz', 3500.00, (SELECT id FROM category WHERE name = 'Jugos Naturales' LIMIT 1), 'active'),
('Empanada de Carne', 'Empanada colombiana tradicional', 2000.00, (SELECT id FROM category WHERE name = 'Snacks' LIMIT 1), 'active'),
('Almuerzo Ejecutivo', 'Sopa, arroz, proteína, ensalada, jugo', 12000.00, (SELECT id FROM category WHERE name = 'Almuerzos' LIMIT 1), 'active'),
('Pan de Queso', 'Pandebono artesanal', 1500.00, (SELECT id FROM category WHERE name = 'Panadería' LIMIT 1), 'active'),
('Gaseosa Coca-Cola', 'Gaseosa 350ml', 2500.00, (SELECT id FROM category WHERE name = 'Bebidas Frías' LIMIT 1), 'active'),
('Ensalada César', 'Lechuga, pollo, queso parmesano', 8000.00, (SELECT id FROM category WHERE name = 'Ensaladas' LIMIT 1), 'active'),
('Brownie de Chocolate', 'Brownie casero con helado', 5000.00, (SELECT id FROM category WHERE name = 'Postres' LIMIT 1), 'active'),
('Hamburguesa Sencilla', 'Carne, queso, lechuga, tomate', 9000.00, (SELECT id FROM category WHERE name = 'Comida Rápida' LIMIT 1), 'active');


INSERT INTO inventory (product_id, stock, minimum_stock, last_update) VALUES
((SELECT id FROM product WHERE name = 'Café Americano' LIMIT 1), 150, 20, NOW()),
((SELECT id FROM product WHERE name = 'Cappuccino' LIMIT 1), 120, 15, NOW()),
((SELECT id FROM product WHERE name = 'Jugo de Naranja Natural' LIMIT 1), 80, 10, NOW()),
((SELECT id FROM product WHERE name = 'Empanada de Carne' LIMIT 1), 200, 30, NOW()),
((SELECT id FROM product WHERE name = 'Almuerzo Ejecutivo' LIMIT 1), 50, 10, NOW()),
((SELECT id FROM product WHERE name = 'Pan de Queso' LIMIT 1), 100, 20, NOW()),
((SELECT id FROM product WHERE name = 'Gaseosa Coca-Cola' LIMIT 1), 180, 25, NOW()),
((SELECT id FROM product WHERE name = 'Ensalada César' LIMIT 1), 40, 5, NOW()),
((SELECT id FROM product WHERE name = 'Brownie de Chocolate' LIMIT 1), 60, 10, NOW()),
((SELECT id FROM product WHERE name = 'Hamburguesa Sencilla' LIMIT 1), 70, 12, NOW());


INSERT INTO orders (user_id, status, total, created_at) VALUES
((SELECT id FROM "user" WHERE email = 'sofia.hernandez@sena.edu.co' LIMIT 1), 'completed', 0, NOW() - INTERVAL '5 days'),
((SELECT id FROM "user" WHERE email = 'juan.lopez@sena.edu.co' LIMIT 1), 'completed', 0, NOW() - INTERVAL '4 days'),
((SELECT id FROM "user" WHERE email = 'sofia.hernandez@sena.edu.co' LIMIT 1), 'completed', 0, NOW() - INTERVAL '3 days'),
((SELECT id FROM "user" WHERE email = 'miguel.torres@sena.edu.co' LIMIT 1), 'pending', 0, NOW() - INTERVAL '2 days'),
((SELECT id FROM "user" WHERE email = 'juan.lopez@sena.edu.co' LIMIT 1), 'completed', 0, NOW() - INTERVAL '1 day'),
((SELECT id FROM "user" WHERE email = 'sofia.hernandez@sena.edu.co' LIMIT 1), 'processing', 0, NOW()),
((SELECT id FROM "user" WHERE email = 'ana.martinez@sena.edu.co' LIMIT 1), 'completed', 0, NOW() - INTERVAL '6 days'),
((SELECT id FROM "user" WHERE email = 'carlos.gomez@sena.edu.co' LIMIT 1), 'cancelled', 0, NOW() - INTERVAL '7 days'),
((SELECT id FROM "user" WHERE email = 'miguel.torres@sena.edu.co' LIMIT 1), 'completed', 0, NOW() - INTERVAL '8 days'),
((SELECT id FROM "user" WHERE email = 'juan.lopez@sena.edu.co' LIMIT 1), 'pending', 0, NOW());


INSERT INTO order_item (order_id, product_id, quantity, price, subtotal) VALUES

((SELECT id FROM orders ORDER BY created_at LIMIT 1 OFFSET 0), (SELECT id FROM product WHERE name = 'Café Americano' LIMIT 1), 2, 2500.00, 5000.00),
((SELECT id FROM orders ORDER BY created_at LIMIT 1 OFFSET 0), (SELECT id FROM product WHERE name = 'Empanada de Carne' LIMIT 1), 1, 2000.00, 2000.00),

((SELECT id FROM orders ORDER BY created_at LIMIT 1 OFFSET 1), (SELECT id FROM product WHERE name = 'Almuerzo Ejecutivo' LIMIT 1), 1, 12000.00, 12000.00),
((SELECT id FROM orders ORDER BY created_at LIMIT 1 OFFSET 1), (SELECT id FROM product WHERE name = 'Jugo de Naranja Natural' LIMIT 1), 1, 3500.00, 3500.00),

((SELECT id FROM orders ORDER BY created_at LIMIT 1 OFFSET 2), (SELECT id FROM product WHERE name = 'Hamburguesa Sencilla' LIMIT 1), 1, 9000.00, 9000.00),
((SELECT id FROM orders ORDER BY created_at LIMIT 1 OFFSET 2), (SELECT id FROM product WHERE name = 'Gaseosa Coca-Cola' LIMIT 1), 2, 2500.00, 5000.00),

((SELECT id FROM orders ORDER BY created_at LIMIT 1 OFFSET 3), (SELECT id FROM product WHERE name = 'Cappuccino' LIMIT 1), 2, 4500.00, 9000.00),

((SELECT id FROM orders ORDER BY created_at LIMIT 1 OFFSET 4), (SELECT id FROM product WHERE name = 'Ensalada César' LIMIT 1), 1, 8000.00, 8000.00),
((SELECT id FROM orders ORDER BY created_at LIMIT 1 OFFSET 4), (SELECT id FROM product WHERE name = 'Brownie de Chocolate' LIMIT 1), 1, 5000.00, 5000.00),

((SELECT id FROM orders ORDER BY created_at LIMIT 1 OFFSET 5), (SELECT id FROM product WHERE name = 'Pan de Queso' LIMIT 1), 3, 1500.00, 4500.00);


UPDATE orders o
SET total = (
    SELECT COALESCE(SUM(oi.subtotal), 0)
    FROM order_item oi
    WHERE oi.order_id = o.id
);


CREATE OR REPLACE VIEW vista_historial_usuario AS
SELECT 
    u.id AS user_id,
    CONCAT(p.first_name, ' ', p.last_name) AS usuario,
    u.email,
    r.name AS rol,
    o.id AS order_id,
    o.created_at AS fecha_pedido,
    o.status AS estado_pedido,
    o.total AS total_pedido,
    pr.name AS producto,
    c.name AS categoria,
    oi.quantity AS cantidad,
    oi.price AS precio_unitario,
    oi.subtotal
FROM "user" u
LEFT JOIN person p ON u.person_id = p.id
LEFT JOIN user_role ur ON u.id = ur.user_id
LEFT JOIN role r ON ur.role_id = r.id
LEFT JOIN orders o ON u.id = o.user_id
LEFT JOIN order_item oi ON o.id = oi.order_id
LEFT JOIN product pr ON oi.product_id = pr.id
LEFT JOIN category c ON pr.category_id = c.id
ORDER BY u.id, o.created_at DESC;

