CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
-- Activa la extensión para usar identificadores únicos universales (UUIDs).

-- MÓDULO SECURITY
-- 1. Tabla de roles
CREATE TABLE role (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(), -- Clave primaria que se genera con un UUID.
    name VARCHAR(100) NOT NULL, -- Nombre del rol, no puede ser nulo.
    description TEXT, -- Descripción del rol.
    status VARCHAR(20) DEFAULT 'active' -- Estado del rol, por defecto activo.
);

-- 2. Tabla de usuarios
CREATE TABLE "user" (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(), -- Clave primaria generada con UUID.
    person_id UUID, -- Referencia a una persona (opcional, para vincular con la tabla person).
    email VARCHAR(150) UNIQUE NOT NULL, -- Email del usuario, único y no nulo.
    password VARCHAR(255) NOT NULL, -- Contraseña del usuario, no puede ser nula.
    status VARCHAR(20) DEFAULT 'active' -- Estado del usuario, por defecto activo.
);

-- 3. Tabla intermedia de usuarios y roles
CREATE TABLE user_role (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(), -- Clave primaria.
    user_id UUID NOT NULL, -- Usuario al que se le asigna un rol.
    role_id UUID NOT NULL, -- Rol asignado al usuario.
    CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES "user"(id), -- Relación: usuario.
    CONSTRAINT fk_role FOREIGN KEY (role_id) REFERENCES role(id) -- Relación: rol asignado.
);

-- MÓDULO PARAMETER
-- 4. Tabla de tipos de documento
CREATE TABLE type_document (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(), -- Clave primaria.
    name VARCHAR(100) NOT NULL, -- Nombre del tipo de documento.
    code VARCHAR(20) NOT NULL, -- Código del tipo de documento.
    status VARCHAR(20) DEFAULT 'active' -- Estado del tipo de documento.
);

-- 5. Tabla de personas
CREATE TABLE person (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(), -- Clave primaria.
    first_name VARCHAR(100) NOT NULL, -- Primer nombre de la persona.
    last_name VARCHAR(100) NOT NULL, -- Apellido de la persona.
    document_number VARCHAR(50) NOT NULL, -- Número de documento, único.
    type_document_id UUID, -- Referencia al tipo de documento.
    phone VARCHAR(20), -- Teléfono de la persona.
    email VARCHAR(150), -- Email de la persona.
    status VARCHAR(20) DEFAULT 'active', -- Estado de la persona, por defecto activo.
    CONSTRAINT fk_type_document FOREIGN KEY (type_document_id) REFERENCES type_document(id) -- Relación con tipo de documento.
);

-- Conexión de USER con PERSON
ALTER TABLE "user"
ADD CONSTRAINT fk_person
FOREIGN KEY (person_id) REFERENCES person(id); -- Relaciona el usuario con su persona.

-- MÓDULO INVENTORY
-- 6. Tabla de categorías
CREATE TABLE category (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(), -- Clave primaria.
    name VARCHAR(100) NOT NULL, -- Nombre de la categoría.
    status VARCHAR(20) DEFAULT 'active' -- Estado de la categoría, por defecto activo.
);

-- 7. Tabla de productos
CREATE TABLE product (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(), -- Clave primaria.
    name VARCHAR(150) NOT NULL, -- Nombre del producto.
    description TEXT, -- Descripción del producto.
    price NUMERIC(10,2) NOT NULL CHECK (price >= 0), -- Precio del producto, no puede ser negativo.
    category_id UUID, -- Referencia a la categoría a la que pertenece.
    status VARCHAR(20) DEFAULT 'active', -- Estado del producto, por defecto activo.
    CONSTRAINT fk_category FOREIGN KEY (category_id) REFERENCES category(id) -- Relaciona el producto con una categoría.
);

-- 8. Tabla de inventario
CREATE TABLE inventory (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(), -- Clave primaria con UUID.
    product_id UUID UNIQUE, -- Referencia única al producto.
    stock INTEGER NOT NULL CHECK (stock >= 0), -- Cantidad en stock, no puede ser negativa.
    minimum_stock INTEGER DEFAULT 0, -- Stock mínimo para alertas.
    last_update TIMESTAMPTZ DEFAULT NOW(), -- Fecha de la última actualización, con zona horaria.
    CONSTRAINT fk_product FOREIGN KEY (product_id) REFERENCES product(id) -- Relaciona el inventario con un producto específico.
);

-- MÓDULO SALES
-- 9. Tabla de pedidos (orders)
CREATE TABLE orders (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(), -- Clave primaria del pedido.
    user_id UUID NOT NULL, -- Usuario que hizo el pedido.
    status VARCHAR(20) DEFAULT 'pending', -- Estado del pedido, por defecto pendiente.
    total NUMERIC(10,2) DEFAULT 0, -- Total del pedido, se calculará al final.
    created_at TIMESTAMPZ DEFAULT NOW(), -- Fecha de creación del pedido.
    CONSTRAINT fk_order_user FOREIGN KEY (user_id) REFERENCES "user"(id) -- Relación del pedido con un usuario.
);

-- 10. Tabla de ítems del pedido (order_items)
CREATE TABLE order_item (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(), -- Clave primaria del ítem del pedido.
    order_id UUID NOT NULL, -- Pedido al que pertenece este ítem.
    product_id UUID NOT NULL, -- Producto que se pidió.
    quantity INTEGER NOT NULL CHECK (quantity > 0), -- Cantidad del producto, debe ser mayor que cero.
    price NUMERIC(10,2) NOT NULL CHECK (price >= 0), -- Precio unitario del producto, no puede ser negativo.
    subtotal NUMERIC(10,2) NOT NULL, -- Subtotal del ítem (cantidad * precio).
    CONSTRAINT fk_order FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE, -- Si se borra el pedido, se borran sus ítems.
    CONSTRAINT fk_product_order FOREIGN KEY (product_id) REFERENCES product(id) -- Relaciona el ítem con un producto específico.