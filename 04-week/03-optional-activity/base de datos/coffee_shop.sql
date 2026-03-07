-- ================================================
-- BASE DE DATOS: coffee-shop (PostgreSQL)
-- Esquema organizado por módulos solicitados
-- ================================================

-- Crear la base de datos
DROP DATABASE IF EXISTS "coffee_shop";


CREATE DATABASE "coffee_shop";

\c "coffee_shop";


-- Activar extensión para UUID (ejecutar una sola vez)
CREATE EXTENSION IF NOT EXISTS "pgcrypto";


-- ================================================
-- MÓDULO: PARAMETER
-- ================================================

CREATE TABLE IF NOT EXISTS type_document (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    code            VARCHAR(10)  NOT NULL UNIQUE,   -- CC, TI, CE, PA, NIT...
    name            VARCHAR(50)  NOT NULL,
    description     TEXT,
    
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMPTZ,
    deleted_at      TIMESTAMPTZ,
    created_by      UUID,
    updated_by      UUID,
    deleted_by      UUID
);

CREATE TABLE IF NOT EXISTS person (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    type_document_id UUID NOT NULL REFERENCES type_document(id),
    document_number VARCHAR(30) NOT NULL UNIQUE,
    first_name      VARCHAR(100) NOT NULL,
    last_name       VARCHAR(100),
    email           VARCHAR(150) UNIQUE,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMPTZ,
    deleted_at      TIMESTAMPTZ,
    created_by      UUID,
    updated_by      UUID,
    deleted_by      UUID
);

CREATE TABLE IF NOT EXISTS file (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    person_id       UUID NOT NULL REFERENCES person(id),
    file_name       VARCHAR(255) NOT NULL,
    file_path       TEXT NOT NULL,                 
    mime_type       VARCHAR(100),
    file_size       BIGINT,
    description     TEXT,
    
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMPTZ,
    deleted_at      TIMESTAMPTZ,
    created_by      UUID,
    updated_by      UUID,
    deleted_by      UUID
);


-- ================================================
-- MÓDULO: SECURITY
-- ================================================

CREATE TABLE IF NOT EXISTS role (
    id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    code        VARCHAR(50) NOT NULL UNIQUE,
    name        VARCHAR(100) NOT NULL,
    description TEXT
);

CREATE TABLE IF NOT EXISTS module (
    id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    code        VARCHAR(50) NOT NULL UNIQUE,
    name        VARCHAR(100) NOT NULL,
    description TEXT
);

CREATE TABLE IF NOT EXISTS vieww (          -- "view" es palabra reservada en SQL
    id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    code        VARCHAR(100) NOT NULL,
    name        VARCHAR(150) NOT NULL,
    path        VARCHAR(255),
    description TEXT
);

CREATE TABLE IF NOT EXISTS "user" (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    person_id       UUID REFERENCES person(id),
    username        VARCHAR(80) NOT NULL UNIQUE,
    password_hash   TEXT NOT NULL,
    email           VARCHAR(150) UNIQUE,
    
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMPTZ,
    deleted_at      TIMESTAMPTZ,
    created_by      UUID REFERENCES "user"(id),
    updated_by      UUID REFERENCES "user"(id),
    deleted_by      UUID REFERENCES "user"(id)
);

CREATE TABLE IF NOT EXISTS user_role (
    user_id     UUID REFERENCES "user"(id) ON DELETE CASCADE,
    role_id     UUID REFERENCES role(id) ON DELETE CASCADE,
    PRIMARY KEY (user_id, role_id)
);

CREATE TABLE IF NOT EXISTS role_module (
    role_id     UUID REFERENCES role(id) ON DELETE CASCADE,
    module_id   UUID REFERENCES module(id) ON DELETE CASCADE,
    PRIMARY KEY (role_id, module_id)
);

CREATE TABLE IF NOT EXISTS module_view (
    module_id   UUID REFERENCES module(id) ON DELETE CASCADE,
    view_id     UUID REFERENCES vieww(id) ON DELETE CASCADE,
    PRIMARY KEY (module_id, view_id)
);


-- ================================================
-- MÓDULO: INVENTORY
-- ================================================

CREATE TABLE IF NOT EXISTS category (
    id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name        VARCHAR(100) NOT NULL UNIQUE,
    description TEXT
);

CREATE TABLE IF NOT EXISTS supplier (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    person_id       UUID NOT NULL REFERENCES person(id),
    company_name    VARCHAR(150),
    nit             VARCHAR(20) UNIQUE,
    
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMPTZ,
    deleted_at      TIMESTAMPTZ,
    created_by      UUID REFERENCES "user"(id),
    updated_by      UUID REFERENCES "user"(id),
    deleted_by      UUID REFERENCES "user"(id)
);

CREATE TABLE IF NOT EXISTS product (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    category_id     UUID REFERENCES category(id),
    supplier_id     UUID REFERENCES supplier(id),
    name            VARCHAR(150) NOT NULL,
    description     TEXT,
    sku             VARCHAR(50) UNIQUE,
    unit_price      DECIMAL(12,2) NOT NULL CHECK (unit_price >= 0),
    stock_minimum   INTEGER DEFAULT 0,
    
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMPTZ,
    deleted_at      TIMESTAMPTZ,
    created_by      UUID REFERENCES "user"(id),
    updated_by      UUID REFERENCES "user"(id),
    deleted_by      UUID REFERENCES "user"(id)
);

CREATE TABLE IF NOT EXISTS inventory (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    product_id      UUID NOT NULL REFERENCES product(id),
    quantity        INTEGER NOT NULL CHECK (quantity >= 0),
    entry_date      DATE NOT NULL DEFAULT CURRENT_DATE,
    expiration_date DATE,
    
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMPTZ,
    deleted_at      TIMESTAMPTZ,
    created_by      UUID REFERENCES "user"(id),
    updated_by      UUID REFERENCES "user"(id),
    deleted_by      UUID REFERENCES "user"(id)
);


-- ================================================
-- MÓDULO: SALES
-- ================================================

CREATE TABLE IF NOT EXISTS customer (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    person_id       UUID NOT NULL REFERENCES person(id),
    
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMPTZ,
    deleted_at      TIMESTAMPTZ,
    created_by      UUID REFERENCES "user"(id),
    updated_by      UUID REFERENCES "user"(id),
    deleted_by      UUID REFERENCES "user"(id)
);

CREATE TABLE IF NOT EXISTS "order" ( 
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    customer_id     UUID REFERENCES customer(id),
    user_id         UUID NOT NULL REFERENCES "user"(id),
    order_date      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    total_amount    DECIMAL(12,2) NOT NULL DEFAULT 0 CHECK (total_amount >= 0),
    status          VARCHAR(30) DEFAULT 'pending',   
    
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMPTZ,
    deleted_at      TIMESTAMPTZ,
    created_by      UUID REFERENCES "user"(id),
    updated_by      UUID REFERENCES "user"(id),
    deleted_by      UUID REFERENCES "user"(id)
);

CREATE TABLE IF NOT EXISTS order_item (
    id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    order_id    UUID NOT NULL REFERENCES "order"(id) ON DELETE CASCADE,
    product_id  UUID NOT NULL REFERENCES product(id),
    quantity    INTEGER NOT NULL CHECK (quantity > 0),
    unit_price  DECIMAL(12,2) NOT NULL CHECK (unit_price >= 0),
    subtotal    DECIMAL(12,2) GENERATED ALWAYS AS (quantity * unit_price) STORED
);


-- ================================================
-- MÓDULO: METHOD_PAYMENT
-- ================================================

CREATE TABLE IF NOT EXISTS method_payment (
    id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    code        VARCHAR(50) NOT NULL UNIQUE,
    name        VARCHAR(100) NOT NULL,          -- Efectivo, Nequi, Tarjeta...
    description TEXT
);


-- ================================================
-- MÓDULO: BILLING
-- ================================================

CREATE TABLE IF NOT EXISTS invoice (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    order_id        UUID REFERENCES "order"(id),
    invoice_number  VARCHAR(30) NOT NULL UNIQUE,
    issue_date      DATE NOT NULL DEFAULT CURRENT_DATE,
    total_amount    DECIMAL(12,2) NOT NULL CHECK (total_amount >= 0),
    status          VARCHAR(30) DEFAULT 'generated',   -- generated, paid, cancelled...
    
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMPTZ,
    deleted_at      TIMESTAMPTZ,
    created_by      UUID REFERENCES "user"(id),
    updated_by      UUID REFERENCES "user"(id),
    deleted_by      UUID REFERENCES "user"(id)
);

CREATE TABLE IF NOT EXISTS invoice_item (
    id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    invoice_id  UUID NOT NULL REFERENCES invoice(id) ON DELETE CASCADE,
    product_id  UUID NOT NULL REFERENCES product(id),
    quantity    INTEGER NOT NULL CHECK (quantity > 0),
    unit_price  DECIMAL(12,2) NOT NULL CHECK (unit_price >= 0),
    subtotal    DECIMAL(12,2) GENERATED ALWAYS AS (quantity * unit_price) STORED
);

CREATE TABLE IF NOT EXISTS payment (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    invoice_id      UUID REFERENCES invoice(id),
    method_payment_id UUID NOT NULL REFERENCES method_payment(id),
    amount          DECIMAL(12,2) NOT NULL CHECK (amount > 0),
    payment_date    TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    reference       VARCHAR(100),
    
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMPTZ,
    deleted_at      TIMESTAMPTZ,
    created_by      UUID REFERENCES "user"(id),
    updated_by      UUID REFERENCES "user"(id),
    deleted_by      UUID REFERENCES "user"(id)
);


-- ------------------------------------------------
-- type_document
-- ------------------------------------------------
INSERT INTO type_document (code, name, description) VALUES
('CC',   'Cédula de Ciudadanía',               'Documento de identidad para mayores de edad en Colombia'),
('TI',   'Tarjeta de Identidad',               'Documento de identidad para menores de edad en Colombia'),
('CE',   'Cédula de Extranjería',              'Documento para ciudadanos extranjeros residentes en Colombia'),
('PA',   'Pasaporte',                          'Documento de viaje internacional'),
('NIT',  'NIT',                                'Número de Identificación Tributaria para empresas'),
('RC',   'Registro Civil',                     'Documento de registro civil de nacimiento'),
('PE',   'Permiso Especial de Permanencia',    'Permiso especial para migrantes'),
('PEP',  'Permiso Especial Venezolanos',       'PEP para ciudadanos venezolanos'),
('NUIP', 'Número Único de Identificación',     'NUIP asignado al nacer'),
('DIE',  'Documento de Identidad Extranjero',  'Otros documentos de identidad extranjeros');

-- ------------------------------------------------
-- person
-- ------------------------------------------------
INSERT INTO person (type_document_id, document_number, first_name, last_name, email) VALUES
((SELECT id FROM type_document WHERE code='CC'),  '10254301',   'Carlos',   'Mendoza',   'carlos.mendoza@sena.edu.co'),
((SELECT id FROM type_document WHERE code='CC'),  '52468910',   'Laura',    'Ríos',      'laura.rios@cafeteriasena.co'),
((SELECT id FROM type_document WHERE code='CC'),  '71823456',   'Andrés',   'Castillo',  'andres.castillo@cafeteriasena.co'),
((SELECT id FROM type_document WHERE code='CC'),  '38291047',   'Marcela',  'Suárez',    'marcela.suarez@cafeteriasena.co'),
((SELECT id FROM type_document WHERE code='TI'),  '1002345678', 'Valentina','Herrera',   'valentina.herrera@aprendiz.sena.edu.co'),
((SELECT id FROM type_document WHERE code='TI'),  '1003456789', 'Santiago', 'Moreno',    'santiago.moreno@aprendiz.sena.edu.co'),
((SELECT id FROM type_document WHERE code='CC'),  '1052345610', 'Camila',   'Jiménez',   'camila.jimenez@aprendiz.sena.edu.co'),
((SELECT id FROM type_document WHERE code='CC'),  '1062345611', 'David',    'Ospina',    'david.ospina@aprendiz.sena.edu.co'),
((SELECT id FROM type_document WHERE code='NIT'), '900123456',  'Café',     'del Sur',   'ventas@cafedelsur.com.co'),
((SELECT id FROM type_document WHERE code='NIT'), '800987654',  'La',       'Cosecha',   'pedidos@lacosecha.com.co');

-- ------------------------------------------------
-- file
-- ------------------------------------------------
INSERT INTO file (person_id, file_name, file_path, mime_type, file_size, description) VALUES
((SELECT id FROM person WHERE document_number='10254301'),   'cedula_carlos.pdf',   '/files/persons/cedula_carlos.pdf',   'application/pdf', 204800, 'Cédula administrador Carlos'),
((SELECT id FROM person WHERE document_number='52468910'),   'cedula_laura.pdf',    '/files/persons/cedula_laura.pdf',    'application/pdf', 198000, 'Cédula cajera Laura'),
((SELECT id FROM person WHERE document_number='71823456'),   'cedula_andres.pdf',   '/files/persons/cedula_andres.pdf',   'application/pdf', 201000, 'Cédula cocinero Andrés'),
((SELECT id FROM person WHERE document_number='38291047'),   'cedula_marcela.pdf',  '/files/persons/cedula_marcela.pdf',  'application/pdf', 195000, 'Cédula mesera Marcela'),
((SELECT id FROM person WHERE document_number='1002345678'), 'ti_valentina.pdf',    '/files/persons/ti_valentina.pdf',    'application/pdf', 175000, 'Tarjeta identidad Valentina'),
((SELECT id FROM person WHERE document_number='1003456789'), 'ti_santiago.pdf',     '/files/persons/ti_santiago.pdf',     'application/pdf', 180000, 'Tarjeta identidad Santiago'),
((SELECT id FROM person WHERE document_number='1052345610'), 'cedula_camila.pdf',   '/files/persons/cedula_camila.pdf',   'application/pdf', 192000, 'Cédula aprendiz Camila'),
((SELECT id FROM person WHERE document_number='1062345611'), 'cedula_david.pdf',    '/files/persons/cedula_david.pdf',    'application/pdf', 189000, 'Cédula aprendiz David'),
((SELECT id FROM person WHERE document_number='900123456'),  'rut_cafesur.pdf',     '/files/suppliers/rut_cafesur.pdf',   'application/pdf', 310000, 'RUT proveedor Café del Sur'),
((SELECT id FROM person WHERE document_number='800987654'),  'rut_cosecha.pdf',     '/files/suppliers/rut_cosecha.pdf',   'application/pdf', 305000, 'RUT proveedor La Cosecha');

-- ------------------------------------------------
-- role
-- ------------------------------------------------
INSERT INTO role (code, name, description) VALUES
('ADMIN',      'Administrador',         'Acceso total al sistema de la cafetería'),
('CAJERO',     'Cajero',                'Gestiona el punto de pago y facturación'),
('COCINERO',   'Cocinero',              'Prepara pedidos y gestiona inventario de cocina'),
('MESERO',     'Mesero',                'Toma y entrega pedidos en el área de mesas'),
('CLIENTE',    'Cliente / Aprendiz',    'Aprendiz o funcionario que compra en la cafetería'),
('PROVEEDOR',  'Proveedor',             'Empresa o persona que surte insumos a la cafetería'),
('INSTRUCTOR', 'Instructor SENA',       'Instructor que consume en la cafetería'),
('SUPERVISOR', 'Supervisor',            'Supervisa operaciones sin acceso total al sistema'),
('INVENTARIO', 'Gestor de Inventario',  'Controla entradas y salidas de inventario'),
('SOPORTE',    'Soporte Técnico',       'Soporte del sistema informático de la cafetería');

-- ------------------------------------------------
-- module
-- ------------------------------------------------
INSERT INTO module (code, name, description) VALUES
('MOD_VENTAS',    'Ventas',        'Gestión de pedidos y ventas del día'),
('MOD_INV',       'Inventario',    'Control de insumos y productos en stock'),
('MOD_USUARIOS',  'Usuarios',      'Administración de usuarios del sistema'),
('MOD_FACTURA',   'Facturación',   'Generación y consulta de facturas'),
('MOD_PAGOS',     'Pagos',         'Registro y consulta de métodos de pago'),
('MOD_REPORTES',  'Reportes',      'Informes de ventas, inventario y caja'),
('MOD_PRODUCTOS', 'Productos',     'Catálogo de productos de la cafetería'),
('MOD_PROV',      'Proveedores',   'Gestión de proveedores e insumos'),
('MOD_CLIENTES',  'Clientes',      'Consulta y registro de clientes frecuentes'),
('MOD_CONFIG',    'Configuración', 'Parámetros generales del sistema');

-- ------------------------------------------------
-- vieww
-- ------------------------------------------------
INSERT INTO vieww (code, name, path, description) VALUES
('V_MENU',        'Menú del Día',             '/menu',        'Visualización del menú actual de la cafetería'),
('V_PEDIDO',      'Nuevo Pedido',             '/orders/new',  'Pantalla para crear un nuevo pedido'),
('V_CAJA',        'Caja / POS',               '/pos',         'Punto de venta y cobro'),
('V_FACTURAS',    'Listado de Facturas',      '/invoices',    'Consulta de facturas emitidas'),
('V_INVENTARIO',  'Control de Inventario',   '/inventory',   'Stock actual de productos e insumos'),
('V_PRODUCTOS',   'Catálogo de Productos',   '/products',    'Listado y edición de productos del menú'),
('V_PROVEEDORES', 'Proveedores',              '/suppliers',   'Gestión de proveedores registrados'),
('V_USUARIOS',    'Usuarios del Sistema',     '/users',       'Administración de cuentas de usuario'),
('V_REPORTES',    'Reportes y Estadísticas',  '/reports',     'Dashboard de reportes gerenciales'),
('V_CONFIG',      'Configuración General',    '/settings',    'Parámetros de configuración de la cafetería');

-- ------------------------------------------------
-- user
-- ------------------------------------------------
INSERT INTO "user" (person_id, username, password_hash, email) VALUES
((SELECT id FROM person WHERE document_number='10254301'),   'admin.sena',     crypt('Admin2024*',  gen_salt('bf')), 'carlos.mendoza@sena.edu.co'),
((SELECT id FROM person WHERE document_number='52468910'),   'cajera.laura',   crypt('Caja2024*',   gen_salt('bf')), 'laura.rios@cafeteriasena.co'),
((SELECT id FROM person WHERE document_number='71823456'),   'cocina.andres',  crypt('Cocina2024*', gen_salt('bf')), 'andres.castillo@cafeteriasena.co'),
((SELECT id FROM person WHERE document_number='38291047'),   'mesera.marcela', crypt('Mesa2024*',   gen_salt('bf')), 'marcela.suarez@cafeteriasena.co'),
((SELECT id FROM person WHERE document_number='1002345678'), 'valentina.h',    crypt('Aprendiz1*',  gen_salt('bf')), 'valentina.herrera@aprendiz.sena.edu.co'),
((SELECT id FROM person WHERE document_number='1003456789'), 'santiago.m',     crypt('Aprendiz2*',  gen_salt('bf')), 'santiago.moreno@aprendiz.sena.edu.co'),
((SELECT id FROM person WHERE document_number='1052345610'), 'camila.j',       crypt('Aprendiz3*',  gen_salt('bf')), 'camila.jimenez@aprendiz.sena.edu.co'),
((SELECT id FROM person WHERE document_number='1062345611'), 'david.o',        crypt('Aprendiz4*',  gen_salt('bf')), 'david.ospina@aprendiz.sena.edu.co'),
((SELECT id FROM person WHERE document_number='900123456'),  'prov.cafesur',   crypt('Proveedor1*', gen_salt('bf')), 'ventas@cafedelsur.com.co'),
((SELECT id FROM person WHERE document_number='800987654'),  'prov.cosecha',   crypt('Proveedor2*', gen_salt('bf')), 'pedidos@lacosecha.com.co');

-- ------------------------------------------------
-- user_role
-- ------------------------------------------------
INSERT INTO user_role (user_id, role_id) VALUES
((SELECT id FROM "user" WHERE username='admin.sena'),     (SELECT id FROM role WHERE code='ADMIN')),
((SELECT id FROM "user" WHERE username='cajera.laura'),   (SELECT id FROM role WHERE code='CAJERO')),
((SELECT id FROM "user" WHERE username='cocina.andres'),  (SELECT id FROM role WHERE code='COCINERO')),
((SELECT id FROM "user" WHERE username='mesera.marcela'), (SELECT id FROM role WHERE code='MESERO')),
((SELECT id FROM "user" WHERE username='valentina.h'),    (SELECT id FROM role WHERE code='CLIENTE')),
((SELECT id FROM "user" WHERE username='santiago.m'),     (SELECT id FROM role WHERE code='CLIENTE')),
((SELECT id FROM "user" WHERE username='camila.j'),       (SELECT id FROM role WHERE code='CLIENTE')),
((SELECT id FROM "user" WHERE username='david.o'),        (SELECT id FROM role WHERE code='CLIENTE')),
((SELECT id FROM "user" WHERE username='prov.cafesur'),   (SELECT id FROM role WHERE code='PROVEEDOR')),
((SELECT id FROM "user" WHERE username='prov.cosecha'),   (SELECT id FROM role WHERE code='PROVEEDOR'));

-- ------------------------------------------------
-- role_module
-- ------------------------------------------------
INSERT INTO role_module (role_id, module_id) VALUES
-- Admin: acceso total
((SELECT id FROM role WHERE code='ADMIN'), (SELECT id FROM module WHERE code='MOD_VENTAS')),
((SELECT id FROM role WHERE code='ADMIN'), (SELECT id FROM module WHERE code='MOD_INV')),
((SELECT id FROM role WHERE code='ADMIN'), (SELECT id FROM module WHERE code='MOD_USUARIOS')),
((SELECT id FROM role WHERE code='ADMIN'), (SELECT id FROM module WHERE code='MOD_FACTURA')),
((SELECT id FROM role WHERE code='ADMIN'), (SELECT id FROM module WHERE code='MOD_REPORTES')),
-- Cajero: ventas, facturación y pagos
((SELECT id FROM role WHERE code='CAJERO'), (SELECT id FROM module WHERE code='MOD_VENTAS')),
((SELECT id FROM role WHERE code='CAJERO'), (SELECT id FROM module WHERE code='MOD_FACTURA')),
((SELECT id FROM role WHERE code='CAJERO'), (SELECT id FROM module WHERE code='MOD_PAGOS')),
-- Cocinero: inventario y productos
((SELECT id FROM role WHERE code='COCINERO'), (SELECT id FROM module WHERE code='MOD_INV')),
((SELECT id FROM role WHERE code='COCINERO'), (SELECT id FROM module WHERE code='MOD_PRODUCTOS'));

-- ------------------------------------------------
-- module_view
-- ------------------------------------------------
INSERT INTO module_view (module_id, view_id) VALUES
((SELECT id FROM module WHERE code='MOD_VENTAS'),    (SELECT id FROM vieww WHERE code='V_MENU')),
((SELECT id FROM module WHERE code='MOD_VENTAS'),    (SELECT id FROM vieww WHERE code='V_PEDIDO')),
((SELECT id FROM module WHERE code='MOD_FACTURA'),   (SELECT id FROM vieww WHERE code='V_CAJA')),
((SELECT id FROM module WHERE code='MOD_FACTURA'),   (SELECT id FROM vieww WHERE code='V_FACTURAS')),
((SELECT id FROM module WHERE code='MOD_INV'),       (SELECT id FROM vieww WHERE code='V_INVENTARIO')),
((SELECT id FROM module WHERE code='MOD_PRODUCTOS'), (SELECT id FROM vieww WHERE code='V_PRODUCTOS')),
((SELECT id FROM module WHERE code='MOD_PROV'),      (SELECT id FROM vieww WHERE code='V_PROVEEDORES')),
((SELECT id FROM module WHERE code='MOD_USUARIOS'),  (SELECT id FROM vieww WHERE code='V_USUARIOS')),
((SELECT id FROM module WHERE code='MOD_REPORTES'),  (SELECT id FROM vieww WHERE code='V_REPORTES')),
((SELECT id FROM module WHERE code='MOD_CONFIG'),    (SELECT id FROM vieww WHERE code='V_CONFIG'));

-- ------------------------------------------------
-- category
-- ------------------------------------------------
INSERT INTO category (name, description) VALUES
('Bebidas Calientes',  'Café, chocolate, aromáticas y similares'),
('Bebidas Frías',      'Jugos naturales, limonadas y agua'),
('Desayunos',          'Combos de desayuno para aprendices e instructores'),
('Almuerzos',          'Platos del menú diario: sopa, seco y postre'),
('Snacks y Pasabocas', 'Empanadas, deditos, buñuelos y similares'),
('Panadería',          'Pan, pandebono, almojábanas y croissants'),
('Lácteos',            'Leche, yogurt y kumis'),
('Frutas',             'Frutas frescas y ensaladas de fruta'),
('Mecato',             'Galletas, dulces y chocolatinas'),
('Insumos Cafetería',  'Azúcar, servilletas, vasos desechables y otros insumos');

-- ------------------------------------------------
-- supplier
-- ------------------------------------------------
INSERT INTO supplier (person_id, company_name, nit) VALUES
((SELECT id FROM person WHERE document_number='900123456'), 'Café del Sur S.A.S.',      '900123456-7'),
((SELECT id FROM person WHERE document_number='800987654'), 'Distribuidora La Cosecha', '800987654-1');

-- ------------------------------------------------
-- product
-- ------------------------------------------------
INSERT INTO product (category_id, supplier_id, name, description, sku, unit_price, stock_minimum) VALUES
((SELECT id FROM category WHERE name='Bebidas Calientes'), (SELECT id FROM supplier WHERE nit='900123456-7'), 'Tinto pequeño',        'Café tinto en vaso pequeño',               'BCA-001', 1000.00, 20),
((SELECT id FROM category WHERE name='Bebidas Calientes'), (SELECT id FROM supplier WHERE nit='900123456-7'), 'Café con leche',        'Café con leche caliente en pocillo',        'BCA-002', 1500.00, 15),
((SELECT id FROM category WHERE name='Bebidas Calientes'), (SELECT id FROM supplier WHERE nit='900123456-7'), 'Chocolate con leche',   'Chocolate caliente con leche entera',       'BCA-003', 2000.00, 10),
((SELECT id FROM category WHERE name='Bebidas Calientes'), (SELECT id FROM supplier WHERE nit='900123456-7'), 'Aromática',             'Aromática de panela o manzanilla en bolsa', 'BCA-004',  800.00, 20),
((SELECT id FROM category WHERE name='Bebidas Frías'),     (SELECT id FROM supplier WHERE nit='800987654-1'), 'Jugo de lulo',          'Jugo natural de lulo en vaso',              'BFR-001', 2500.00, 15),
((SELECT id FROM category WHERE name='Bebidas Frías'),     (SELECT id FROM supplier WHERE nit='800987654-1'), 'Jugo de maracuyá',      'Jugo natural de maracuyá en vaso',          'BFR-002', 2500.00, 15),
((SELECT id FROM category WHERE name='Bebidas Frías'),     (SELECT id FROM supplier WHERE nit='800987654-1'), 'Agua en botella',        'Agua mineral botella 600ml',               'BFR-003', 2000.00, 30),
((SELECT id FROM category WHERE name='Desayunos'),         (SELECT id FROM supplier WHERE nit='800987654-1'), 'Combo desayuno',         'Huevo, arepa, jugo y tinto',               'DES-001', 6000.00, 10),
((SELECT id FROM category WHERE name='Desayunos'),         (SELECT id FROM supplier WHERE nit='800987654-1'), 'Arepa con queso',        'Arepa de maíz con queso campesino',        'DES-002', 3000.00, 20),
((SELECT id FROM category WHERE name='Almuerzos'),         (SELECT id FROM supplier WHERE nit='800987654-1'), 'Menú del día',           'Sopa, seco, jugo y postre del día',        'ALM-001',10000.00,  5),
((SELECT id FROM category WHERE name='Almuerzos'),         (SELECT id FROM supplier WHERE nit='800987654-1'), 'Sopa del día',           'Porción de sopa del menú diario',          'ALM-002', 4000.00, 10),
((SELECT id FROM category WHERE name='Snacks y Pasabocas'),(SELECT id FROM supplier WHERE nit='800987654-1'), 'Empanada de pipián',    'Empanada frita rellena de pipián',          'SNA-001', 1500.00, 30),
((SELECT id FROM category WHERE name='Snacks y Pasabocas'),(SELECT id FROM supplier WHERE nit='800987654-1'), 'Buñuelo',               'Buñuelo frito tradicional colombiano',      'SNA-002', 1000.00, 30),
((SELECT id FROM category WHERE name='Panadería'),         (SELECT id FROM supplier WHERE nit='800987654-1'), 'Pandebono',             'Pandebono de almidón y queso',             'PAN-001', 1200.00, 25),
((SELECT id FROM category WHERE name='Panadería'),         (SELECT id FROM supplier WHERE nit='800987654-1'), 'Almojábana',            'Almojábana tradicional antioqueña',        'PAN-002', 1200.00, 25);

-- ------------------------------------------------
-- inventory
-- ------------------------------------------------
INSERT INTO inventory (product_id, quantity, entry_date, expiration_date) VALUES
((SELECT id FROM product WHERE sku='BCA-001'), 200, CURRENT_DATE, NULL),
((SELECT id FROM product WHERE sku='BCA-002'), 150, CURRENT_DATE, NULL),
((SELECT id FROM product WHERE sku='BCA-003'), 100, CURRENT_DATE, NULL),
((SELECT id FROM product WHERE sku='BCA-004'), 180, CURRENT_DATE, NULL),
((SELECT id FROM product WHERE sku='BFR-001'),  80, CURRENT_DATE, CURRENT_DATE + INTERVAL '2 days'),
((SELECT id FROM product WHERE sku='BFR-002'),  80, CURRENT_DATE, CURRENT_DATE + INTERVAL '2 days'),
((SELECT id FROM product WHERE sku='BFR-003'), 120, CURRENT_DATE, CURRENT_DATE + INTERVAL '365 days'),
((SELECT id FROM product WHERE sku='DES-001'),  50, CURRENT_DATE, CURRENT_DATE + INTERVAL '1 day'),
((SELECT id FROM product WHERE sku='DES-002'), 100, CURRENT_DATE, CURRENT_DATE + INTERVAL '1 day'),
((SELECT id FROM product WHERE sku='ALM-001'),  40, CURRENT_DATE, CURRENT_DATE + INTERVAL '1 day'),
((SELECT id FROM product WHERE sku='ALM-002'),  60, CURRENT_DATE, CURRENT_DATE + INTERVAL '1 day'),
((SELECT id FROM product WHERE sku='SNA-001'), 150, CURRENT_DATE, CURRENT_DATE + INTERVAL '1 day'),
((SELECT id FROM product WHERE sku='SNA-002'), 150, CURRENT_DATE, CURRENT_DATE + INTERVAL '1 day'),
((SELECT id FROM product WHERE sku='PAN-001'), 120, CURRENT_DATE, CURRENT_DATE + INTERVAL '1 day'),
((SELECT id FROM product WHERE sku='PAN-002'), 120, CURRENT_DATE, CURRENT_DATE + INTERVAL '1 day');

-- ------------------------------------------------
-- method_payment
-- ------------------------------------------------
INSERT INTO method_payment (code, name, description) VALUES
('EFECTIVO',      'Efectivo',           'Pago en efectivo en caja'),
('NEQUI',         'Nequi',              'Transferencia por Nequi al número de la cafetería'),
('DAVIPLATA',     'Daviplata',          'Transferencia por Daviplata'),
('TRANSFERENCIA', 'Transferencia PSE',  'Transferencia bancaria por PSE o app del banco'),
('BONO_SENA',     'Bono SENA',          'Bono de alimentación entregado por el SENA a aprendices'),
('TARJETA_DEB',   'Tarjeta Débito',     'Pago con tarjeta débito en datáfono'),
('TARJETA_CRED',  'Tarjeta Crédito',    'Pago con tarjeta crédito en datáfono'),
('QR',            'Pago QR',            'Pago mediante código QR (Bancolombia, Nequi, etc.)'),
('VALE',          'Vale de Consumo',    'Vale interno de la cafetería'),
('OTRO',          'Otro Método',        'Cualquier otro método de pago');

-- ------------------------------------------------
-- customer
-- ------------------------------------------------
INSERT INTO customer (person_id) VALUES
((SELECT id FROM person WHERE document_number='1002345678')),
((SELECT id FROM person WHERE document_number='1003456789')),
((SELECT id FROM person WHERE document_number='1052345610')),
((SELECT id FROM person WHERE document_number='1062345611')),
((SELECT id FROM person WHERE document_number='10254301')),
((SELECT id FROM person WHERE document_number='52468910')),
((SELECT id FROM person WHERE document_number='71823456')),
((SELECT id FROM person WHERE document_number='38291047')),
((SELECT id FROM person WHERE document_number='900123456')),
((SELECT id FROM person WHERE document_number='800987654'));

-- ------------------------------------------------
-- order
-- Nota: Las órdenes referencian clientes y usuarios
-- por lo que se mantienen con subconsultas puntuales
-- ------------------------------------------------
INSERT INTO "order" (customer_id, user_id, total_amount, status) VALUES
((SELECT id FROM customer WHERE person_id=(SELECT id FROM person WHERE document_number='1002345678')), (SELECT id FROM "user" WHERE username='cajera.laura'),    7000.00,  'completed'),
((SELECT id FROM customer WHERE person_id=(SELECT id FROM person WHERE document_number='1003456789')), (SELECT id FROM "user" WHERE username='cajera.laura'),   10000.00,  'completed'),
((SELECT id FROM customer WHERE person_id=(SELECT id FROM person WHERE document_number='1052345610')), (SELECT id FROM "user" WHERE username='cajera.laura'),    7000.00,  'completed'),
((SELECT id FROM customer WHERE person_id=(SELECT id FROM person WHERE document_number='1062345611')), (SELECT id FROM "user" WHERE username='cajera.laura'),    5200.00,  'completed'),
((SELECT id FROM customer WHERE person_id=(SELECT id FROM person WHERE document_number='10254301')),   (SELECT id FROM "user" WHERE username='cajera.laura'),    2000.00,  'completed'),
((SELECT id FROM customer WHERE person_id=(SELECT id FROM person WHERE document_number='52468910')),   (SELECT id FROM "user" WHERE username='cajera.laura'),    3800.00,  'completed'),
((SELECT id FROM customer WHERE person_id=(SELECT id FROM person WHERE document_number='71823456')),   (SELECT id FROM "user" WHERE username='cajera.laura'),    3700.00,  'completed'),
((SELECT id FROM customer WHERE person_id=(SELECT id FROM person WHERE document_number='38291047')),   (SELECT id FROM "user" WHERE username='mesera.marcela'), 10000.00,  'pending'),
((SELECT id FROM customer WHERE person_id=(SELECT id FROM person WHERE document_number='1002345678')), (SELECT id FROM "user" WHERE username='mesera.marcela'),  4500.00,  'pending'),
((SELECT id FROM customer WHERE person_id=(SELECT id FROM person WHERE document_number='1003456789')), (SELECT id FROM "user" WHERE username='mesera.marcela'),  3000.00,  'completed');

-- ------------------------------------------------
-- order_item
-- Se agrupan por orden usando alias de orden (ORD-N)
-- ------------------------------------------------

-- ORD-1: Valentina — combo desayuno + tinto
INSERT INTO order_item (order_id, product_id, quantity, unit_price)
SELECT o.id, p.id, 1, 6000.00 FROM "order" o
JOIN customer c ON o.customer_id = c.id
JOIN person pe ON c.person_id = pe.id
CROSS JOIN (SELECT id FROM product WHERE sku='DES-001') p
WHERE pe.document_number='1002345678' AND o.total_amount=7000.00;

INSERT INTO order_item (order_id, product_id, quantity, unit_price)
SELECT o.id, p.id, 1, 1000.00 FROM "order" o
JOIN customer c ON o.customer_id = c.id
JOIN person pe ON c.person_id = pe.id
CROSS JOIN (SELECT id FROM product WHERE sku='BCA-001') p
WHERE pe.document_number='1002345678' AND o.total_amount=7000.00;

-- ORD-2: Santiago — menú del día
INSERT INTO order_item (order_id, product_id, quantity, unit_price)
SELECT o.id, p.id, 1, 10000.00 FROM "order" o
JOIN customer c ON o.customer_id = c.id
JOIN person pe ON c.person_id = pe.id
CROSS JOIN (SELECT id FROM product WHERE sku='ALM-001') p
WHERE pe.document_number='1003456789' AND o.total_amount=10000.00;

-- ORD-3: Camila — 2 empanadas + jugo de lulo
INSERT INTO order_item (order_id, product_id, quantity, unit_price)
SELECT o.id, p.id, 2, 1500.00 FROM "order" o
JOIN customer c ON o.customer_id = c.id
JOIN person pe ON c.person_id = pe.id
CROSS JOIN (SELECT id FROM product WHERE sku='SNA-001') p
WHERE pe.document_number='1052345610' AND o.total_amount=7000.00;

INSERT INTO order_item (order_id, product_id, quantity, unit_price)
SELECT o.id, p.id, 1, 2500.00 FROM "order" o
JOIN customer c ON o.customer_id = c.id
JOIN person pe ON c.person_id = pe.id
CROSS JOIN (SELECT id FROM product WHERE sku='BFR-001') p
WHERE pe.document_number='1052345610' AND o.total_amount=7000.00;

-- ORD-4: David — 2 pandebonos + chocolate
INSERT INTO order_item (order_id, product_id, quantity, unit_price)
SELECT o.id, p.id, 2, 1200.00 FROM "order" o
JOIN customer c ON o.customer_id = c.id
JOIN person pe ON c.person_id = pe.id
CROSS JOIN (SELECT id FROM product WHERE sku='PAN-001') p
WHERE pe.document_number='1062345611' AND o.total_amount=5200.00;

INSERT INTO order_item (order_id, product_id, quantity, unit_price)
SELECT o.id, p.id, 1, 2000.00 FROM "order" o
JOIN customer c ON o.customer_id = c.id
JOIN person pe ON c.person_id = pe.id
CROSS JOIN (SELECT id FROM product WHERE sku='BCA-003') p
WHERE pe.document_number='1062345611' AND o.total_amount=5200.00;

-- ORD-5: Carlos — tinto + buñuelo
INSERT INTO order_item (order_id, product_id, quantity, unit_price)
SELECT o.id, p.id, 1, 1000.00 FROM "order" o
JOIN customer c ON o.customer_id = c.id
JOIN person pe ON c.person_id = pe.id
CROSS JOIN (SELECT id FROM product WHERE sku='BCA-001') p
WHERE pe.document_number='10254301' AND o.total_amount=2000.00;

INSERT INTO order_item (order_id, product_id, quantity, unit_price)
SELECT o.id, p.id, 1, 1000.00 FROM "order" o
JOIN customer c ON o.customer_id = c.id
JOIN person pe ON c.person_id = pe.id
CROSS JOIN (SELECT id FROM product WHERE sku='SNA-002') p
WHERE pe.document_number='10254301' AND o.total_amount=2000.00;

-- ORD-6: Laura — arepa con queso + aromática
INSERT INTO order_item (order_id, product_id, quantity, unit_price)
SELECT o.id, p.id, 1, 3000.00 FROM "order" o
JOIN customer c ON o.customer_id = c.id
JOIN person pe ON c.person_id = pe.id
CROSS JOIN (SELECT id FROM product WHERE sku='DES-002') p
WHERE pe.document_number='52468910' AND o.total_amount=3800.00;

INSERT INTO order_item (order_id, product_id, quantity, unit_price)
SELECT o.id, p.id, 1, 800.00 FROM "order" o
JOIN customer c ON o.customer_id = c.id
JOIN person pe ON c.person_id = pe.id
CROSS JOIN (SELECT id FROM product WHERE sku='BCA-004') p
WHERE pe.document_number='52468910' AND o.total_amount=3800.00;

-- ORD-7: Andrés — jugo de maracuyá + almojábana
INSERT INTO order_item (order_id, product_id, quantity, unit_price)
SELECT o.id, p.id, 1, 2500.00 FROM "order" o
JOIN customer c ON o.customer_id = c.id
JOIN person pe ON c.person_id = pe.id
CROSS JOIN (SELECT id FROM product WHERE sku='BFR-002') p
WHERE pe.document_number='71823456' AND o.total_amount=3700.00;

INSERT INTO order_item (order_id, product_id, quantity, unit_price)
SELECT o.id, p.id, 1, 1200.00 FROM "order" o
JOIN customer c ON o.customer_id = c.id
JOIN person pe ON c.person_id = pe.id
CROSS JOIN (SELECT id FROM product WHERE sku='PAN-002') p
WHERE pe.document_number='71823456' AND o.total_amount=3700.00;

-- ORD-8: Marcela — menú del día (pending)
INSERT INTO order_item (order_id, product_id, quantity, unit_price)
SELECT o.id, p.id, 1, 10000.00 FROM "order" o
JOIN customer c ON o.customer_id = c.id
JOIN person pe ON c.person_id = pe.id
CROSS JOIN (SELECT id FROM product WHERE sku='ALM-001') p
WHERE pe.document_number='38291047' AND o.status='pending';

-- ORD-9: Valentina media mañana — sopa + café con leche (pending)
INSERT INTO order_item (order_id, product_id, quantity, unit_price)
SELECT o.id, p.id, 1, 4000.00 FROM "order" o
JOIN customer c ON o.customer_id = c.id
JOIN person pe ON c.person_id = pe.id
CROSS JOIN (SELECT id FROM product WHERE sku='ALM-002') p
WHERE pe.document_number='1002345678' AND o.total_amount=4500.00;

INSERT INTO order_item (order_id, product_id, quantity, unit_price)
SELECT o.id, p.id, 1, 1500.00 FROM "order" o
JOIN customer c ON o.customer_id = c.id
JOIN person pe ON c.person_id = pe.id
CROSS JOIN (SELECT id FROM product WHERE sku='BCA-002') p
WHERE pe.document_number='1002345678' AND o.total_amount=4500.00;

-- ORD-10: Santiago snacks — 2 buñuelos + tinto
INSERT INTO order_item (order_id, product_id, quantity, unit_price)
SELECT o.id, p.id, 2, 1000.00 FROM "order" o
JOIN customer c ON o.customer_id = c.id
JOIN person pe ON c.person_id = pe.id
CROSS JOIN (SELECT id FROM product WHERE sku='SNA-002') p
WHERE pe.document_number='1003456789' AND o.total_amount=3000.00;

INSERT INTO order_item (order_id, product_id, quantity, unit_price)
SELECT o.id, p.id, 1, 1000.00 FROM "order" o
JOIN customer c ON o.customer_id = c.id
JOIN person pe ON c.person_id = pe.id
CROSS JOIN (SELECT id FROM product WHERE sku='BCA-001') p
WHERE pe.document_number='1003456789' AND o.total_amount=3000.00;

-- ------------------------------------------------
-- invoice
-- ------------------------------------------------
INSERT INTO invoice (order_id, invoice_number, total_amount, status)
SELECT o.id, 'CAF-SENA-001',  7000.00, 'paid'      FROM "order" o JOIN customer c ON o.customer_id=c.id JOIN person pe ON c.person_id=pe.id WHERE pe.document_number='1002345678' AND o.total_amount=7000.00  UNION ALL
SELECT o.id, 'CAF-SENA-002', 10000.00, 'paid'      FROM "order" o JOIN customer c ON o.customer_id=c.id JOIN person pe ON c.person_id=pe.id WHERE pe.document_number='1003456789' AND o.total_amount=10000.00 UNION ALL
SELECT o.id, 'CAF-SENA-003',  7000.00, 'paid'      FROM "order" o JOIN customer c ON o.customer_id=c.id JOIN person pe ON c.person_id=pe.id WHERE pe.document_number='1052345610' AND o.total_amount=7000.00  UNION ALL
SELECT o.id, 'CAF-SENA-004',  5200.00, 'paid'      FROM "order" o JOIN customer c ON o.customer_id=c.id JOIN person pe ON c.person_id=pe.id WHERE pe.document_number='1062345611' AND o.total_amount=5200.00  UNION ALL
SELECT o.id, 'CAF-SENA-005',  2000.00, 'paid'      FROM "order" o JOIN customer c ON o.customer_id=c.id JOIN person pe ON c.person_id=pe.id WHERE pe.document_number='10254301'   AND o.total_amount=2000.00  UNION ALL
SELECT o.id, 'CAF-SENA-006',  3800.00, 'paid'      FROM "order" o JOIN customer c ON o.customer_id=c.id JOIN person pe ON c.person_id=pe.id WHERE pe.document_number='52468910'   AND o.total_amount=3800.00  UNION ALL
SELECT o.id, 'CAF-SENA-007',  3700.00, 'paid'      FROM "order" o JOIN customer c ON o.customer_id=c.id JOIN person pe ON c.person_id=pe.id WHERE pe.document_number='71823456'   AND o.total_amount=3700.00  UNION ALL
SELECT o.id, 'CAF-SENA-008', 10000.00, 'generated' FROM "order" o JOIN customer c ON o.customer_id=c.id JOIN person pe ON c.person_id=pe.id WHERE pe.document_number='38291047'   AND o.status='pending'      UNION ALL
SELECT o.id, 'CAF-SENA-009',  4500.00, 'generated' FROM "order" o JOIN customer c ON o.customer_id=c.id JOIN person pe ON c.person_id=pe.id WHERE pe.document_number='1002345678' AND o.total_amount=4500.00  UNION ALL
SELECT o.id, 'CAF-SENA-010',  3000.00, 'paid'      FROM "order" o JOIN customer c ON o.customer_id=c.id JOIN person pe ON c.person_id=pe.id WHERE pe.document_number='1003456789' AND o.total_amount=3000.00;

-- ------------------------------------------------
-- invoice_item
-- ------------------------------------------------
INSERT INTO invoice_item (invoice_id, product_id, quantity, unit_price) VALUES
((SELECT id FROM invoice WHERE invoice_number='CAF-SENA-001'), (SELECT id FROM product WHERE sku='DES-001'), 1,  6000.00),
((SELECT id FROM invoice WHERE invoice_number='CAF-SENA-001'), (SELECT id FROM product WHERE sku='BCA-001'), 1,  1000.00),
((SELECT id FROM invoice WHERE invoice_number='CAF-SENA-002'), (SELECT id FROM product WHERE sku='ALM-001'), 1, 10000.00),
((SELECT id FROM invoice WHERE invoice_number='CAF-SENA-003'), (SELECT id FROM product WHERE sku='SNA-001'), 2,  1500.00),
((SELECT id FROM invoice WHERE invoice_number='CAF-SENA-003'), (SELECT id FROM product WHERE sku='BFR-001'), 1,  2500.00),
((SELECT id FROM invoice WHERE invoice_number='CAF-SENA-004'), (SELECT id FROM product WHERE sku='PAN-001'), 2,  1200.00),
((SELECT id FROM invoice WHERE invoice_number='CAF-SENA-004'), (SELECT id FROM product WHERE sku='BCA-003'), 1,  2000.00),
((SELECT id FROM invoice WHERE invoice_number='CAF-SENA-005'), (SELECT id FROM product WHERE sku='BCA-001'), 1,  1000.00),
((SELECT id FROM invoice WHERE invoice_number='CAF-SENA-005'), (SELECT id FROM product WHERE sku='SNA-002'), 1,  1000.00),
((SELECT id FROM invoice WHERE invoice_number='CAF-SENA-006'), (SELECT id FROM product WHERE sku='DES-002'), 1,  3000.00),
((SELECT id FROM invoice WHERE invoice_number='CAF-SENA-006'), (SELECT id FROM product WHERE sku='BCA-004'), 1,   800.00),
((SELECT id FROM invoice WHERE invoice_number='CAF-SENA-007'), (SELECT id FROM product WHERE sku='BFR-002'), 1,  2500.00),
((SELECT id FROM invoice WHERE invoice_number='CAF-SENA-007'), (SELECT id FROM product WHERE sku='PAN-002'), 1,  1200.00),
((SELECT id FROM invoice WHERE invoice_number='CAF-SENA-008'), (SELECT id FROM product WHERE sku='ALM-001'), 1, 10000.00),
((SELECT id FROM invoice WHERE invoice_number='CAF-SENA-009'), (SELECT id FROM product WHERE sku='ALM-002'), 1,  4000.00),
((SELECT id FROM invoice WHERE invoice_number='CAF-SENA-009'), (SELECT id FROM product WHERE sku='BCA-002'), 1,  1500.00),
((SELECT id FROM invoice WHERE invoice_number='CAF-SENA-010'), (SELECT id FROM product WHERE sku='SNA-002'), 2,  1000.00),
((SELECT id FROM invoice WHERE invoice_number='CAF-SENA-010'), (SELECT id FROM product WHERE sku='BCA-001'), 1,  1000.00);

-- ------------------------------------------------
-- payment
-- Facturas 008 y 009 sin pago (estado: generated)
-- ------------------------------------------------
INSERT INTO payment (invoice_id, method_payment_id, amount, reference) VALUES
((SELECT id FROM invoice WHERE invoice_number='CAF-SENA-001'), (SELECT id FROM method_payment WHERE code='BONO_SENA'),    7000.00, 'BONO-VAL-001'),
((SELECT id FROM invoice WHERE invoice_number='CAF-SENA-002'), (SELECT id FROM method_payment WHERE code='NEQUI'),       10000.00, 'NQ-SANT-002'),
((SELECT id FROM invoice WHERE invoice_number='CAF-SENA-003'), (SELECT id FROM method_payment WHERE code='EFECTIVO'),     7000.00, 'EF-CAM-003'),
((SELECT id FROM invoice WHERE invoice_number='CAF-SENA-004'), (SELECT id FROM method_payment WHERE code='QR'),           5200.00, 'QR-DAV-004'),
((SELECT id FROM invoice WHERE invoice_number='CAF-SENA-005'), (SELECT id FROM method_payment WHERE code='EFECTIVO'),     2000.00, 'EF-CARL-005'),
((SELECT id FROM invoice WHERE invoice_number='CAF-SENA-006'), (SELECT id FROM method_payment WHERE code='DAVIPLATA'),    3800.00, 'DP-LAU-006'),
((SELECT id FROM invoice WHERE invoice_number='CAF-SENA-007'), (SELECT id FROM method_payment WHERE code='EFECTIVO'),     3700.00, 'EF-AND-007'),
((SELECT id FROM invoice WHERE invoice_number='CAF-SENA-010'), (SELECT id FROM method_payment WHERE code='BONO_SENA'),    3000.00, 'BONO-SANT-010');
