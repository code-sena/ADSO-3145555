-- ================================================
-- DIAGRAMA MEJORADO CON TABLAS PIVOTE CORRECTAS
-- ================================================

TABLAS PIVOTE (N:N):
===================

1. USER_ROLE (N:N)
   ┌─────────────────────────────────────┐
   │        USER_ROLE (Pivote)           │
   ├──────────────┬──────────────────────┤
   │  user_id (FK)│ → USER(id)           │
   │  role_id (FK)│ → ROLE(id)           │
   │  PRIMARY KEY │ (user_id, role_id)   │
   └─────────────────────────────────────┘
   Un usuario puede tener múltiples roles
   Un rol puede asignarse a múltiples usuarios


2. ROLE_MODULE (N:N)
   ┌─────────────────────────────────────┐
   │      ROLE_MODULE (Pivote)           │
   ├──────────────┬──────────────────────┤
   │  role_id (FK)│ → ROLE(id)           │
   │ module_id(FK)│ → MODULE(id)         │
   │  PRIMARY KEY │ (role_id, module_id) │
   └─────────────────────────────────────┘
   Un rol puede acceder a múltiples módulos
   Un módulo puede ser accedido por múltiples roles


3. MODULE_VIEW (N:N)
   ┌─────────────────────────────────────┐
   │      MODULE_VIEW (Pivote)           │
   ├──────────────┬──────────────────────┤
   │ module_id(FK)│ → MODULE(id)         │
   │  view_id (FK)│ → VIEWW(id)          │
   │  PRIMARY KEY │ (module_id, view_id) │
   └─────────────────────────────────────┘
   Un módulo muestra múltiples vistas
   Una vista puede estar en múltiples módulos


4. ORDER_ITEM (N:N - Modal)
   ┌──────────────────────────────────────┐
   │      ORDER_ITEM (Pivote Modal)       │
   ├──────────────┬───────────────────────┤
   │  order_id(FK)│ → ORDER(id)           │
   │ product_id(FK)│ → PRODUCT(id)        │
   │  quantity    │ (datos específicos)   │
   │  unit_price  │ (datos específicos)   │
   │  subtotal    │ (generado)            │
   │  PRIMARY KEY │ (order_id, product_id)│
   └──────────────────────────────────────┘
   Un pedido tiene muchos productos
   Un producto puede estar en muchos pedidos


5. INVOICE_ITEM (N:N - Modal)
   ┌──────────────────────────────────────┐
   │     INVOICE_ITEM (Pivote Modal)      │
   ├──────────────┬───────────────────────┤
   │ invoice_id(FK)│ → INVOICE(id)        │
   │ product_id(FK)│ → PRODUCT(id)        │
   │  quantity    │ (datos específicos)   │
   │  unit_price  │ (datos específicos)   │
   │  subtotal    │ (generado)            │
   │  PRIMARY KEY │ (invoice_id,product_id)
   └──────────────────────────────────────┘
   Una factura tiene múltiples productos
   Un producto puede estar en múltiples facturas


RELACIONES 1:N (Las más comunes):
=================================

TYPE_DOCUMENT → PERSON (1:N)
   ┌──────────────────────┐
   │   TYPE_DOCUMENT      │
   │   (1)                │
   └─────────┬────────────┘
             │ type_document_id (FK en person)
             │ 1:N
             ▼
   ┌──────────────────────┐
   │     PERSON           │
   │    (N)               │
   └──────────────────────┘
   1 Tipo de documento → N Personas


PERSON → FILE (1:N)
   ┌──────────────────────┐
   │     PERSON           │
   │     (1)              │
   └─────────┬────────────┘
             │ person_id (FK en file)
             │ 1:N
             ▼
   ┌──────────────────────┐
   │      FILE            │
   │      (N)             │
   └──────────────────────┘
   1 Persona → N Archivos


PERSON → USER (1:N)
   ┌──────────────────────┐
   │     PERSON           │
   │     (1)              │
   └─────────┬────────────┘
             │ person_id (FK en user)
             │ 1:N
             ▼
   ┌──────────────────────┐
   │      USER            │
   │      (N)             │
   └──────────────────────┘
   1 Persona → N Usuarios (un usuario por persona)


PERSON → SUPPLIER (1:N)
   ┌──────────────────────┐
   │     PERSON           │
   │     (1)              │
   └─────────┬────────────┘
             │ person_id (FK en supplier)
             │ 1:N
             ▼
   ┌──────────────────────┐
   │     SUPPLIER         │
   │      (N)             │
   └──────────────────────┘
   1 Persona → N Proveedores


PERSON → CUSTOMER (1:N)
   ┌──────────────────────┐
   │     PERSON           │
   │     (1)              │
   └─────────┬────────────┘
             │ person_id (FK en customer)
             │ 1:N
             ▼
   ┌──────────────────────┐
   │     CUSTOMER         │
   │      (N)             │
   └──────────────────────┘
   1 Persona → N Clientes


CATEGORY → PRODUCT (1:N)
   ┌──────────────────────┐
   │     CATEGORY         │
   │     (1)              │
   └─────────┬────────────┘
             │ category_id (FK en product)
             │ 1:N
             ▼
   ┌──────────────────────┐
   │     PRODUCT          │
   │      (N)             │
   └──────────────────────┘
   1 Categoría → N Productos


SUPPLIER → PRODUCT (1:N)
   ┌──────────────────────┐
   │     SUPPLIER         │
   │     (1)              │
   └─────────┬────────────┘
             │ supplier_id (FK en product)
             │ 1:N
             ▼
   ┌──────────────────────┐
   │     PRODUCT          │
   │      (N)             │
   └──────────────────────┘
   1 Proveedor → N Productos


PRODUCT → INVENTORY (1:N)
   ┌──────────────────────┐
   │     PRODUCT          │
   │     (1)              │
   └─────────┬────────────┘
             │ product_id (FK en inventory)
             │ 1:N
             ▼
   ┌──────────────────────┐
   │    INVENTORY         │
   │      (N)             │
   └──────────────────────┘
   1 Producto → N Registros de Inventario


CUSTOMER → ORDER (1:N)
   ┌──────────────────────┐
   │     CUSTOMER         │
   │     (1)              │
   └─────────┬────────────┘
             │ customer_id (FK en order)
             │ 1:N
             ▼
   ┌──────────────────────┐
   │      ORDER           │
   │      (N)             │
   └──────────────────────┘
   1 Cliente → N Pedidos


USER → ORDER (1:N)
   ┌──────────────────────┐
   │      USER            │
   │     (1)              │
   └─────────┬────────────┘
             │ user_id (FK en order)
             │ 1:N
             ▼
   ┌──────────────────────┐
   │      ORDER           │
   │      (N)             │
   └──────────────────────┘
   1 Usuario (vendedor) → N Pedidos


ORDER → INVOICE (1:N)
   ┌──────────────────────┐
   │      ORDER           │
   │     (1)              │
   └─────────┬────────────┘
             │ order_id (FK en invoice)
             │ 1:N
             ▼
   ┌──────────────────────┐
   │     INVOICE          │
   │      (N)             │
   └──────────────────────┘
   1 Pedido → N Facturas


INVOICE → PAYMENT (1:N)
   ┌──────────────────────┐
   │     INVOICE          │
   │     (1)              │
   └─────────┬────────────┘
             │ invoice_id (FK en payment)
             │ 1:N
             ▼
   ┌──────────────────────┐
   │     PAYMENT          │
   │      (N)             │
   └──────────────────────┘
   1 Factura → N Pagos


METHOD_PAYMENT → PAYMENT (1:N)
   ┌──────────────────────┐
   │  METHOD_PAYMENT      │
   │     (1)              │
   └─────────┬────────────┘
             │ method_payment_id (FK en payment)
             │ 1:N
             ▼
   ┌──────────────────────┐
   │     PAYMENT          │
   │      (N)             │
   └──────────────────────┘
   1 Método → N Pagos


SELF-REFERENCES (USER):
=======================
USER → USER (Self)
   ┌──────────────────────────────────────┐
   │         USER                         │
   │                                      │
   │  created_by → USER(id)               │
   │  updated_by → USER(id)               │
   │  deleted_by → USER(id)               │
   └──────────────────────────────────────┘
   Un usuario fue creado/modificado/eliminado por otro usuario


RESUMEN TOTAL:
==============
✓ Relaciones 1:N:     17
✓ Relaciones N:N:      5 (con tablas pivote)
✓ Self-references:     3 (en USER)
✓ TOTAL RELACIONES:   25
