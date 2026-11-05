# CRUD By Module - Spring Boot 3

Proyecto CRUD completo con arquitectura **by module** basado en el esquema de la imagen.

## 📦 Módulos

```
com.crud
├── security/
│   ├── entity/       Person, User, UserRole, Role
│   ├── repository/
│   ├── service/
│   ├── controller/
│   └── dto/
├── billing/
│   ├── entity/       Bill, BillDetail
│   ├── repository/
│   ├── service/
│   ├── controller/
│   └── dto/
├── inventory/
│   ├── entity/       Product, Category
│   ├── repository/
│   ├── service/
│   ├── controller/
│   └── dto/
└── shared/           ApiResponse, GlobalExceptionHandler
```

## 🚀 Cómo ejecutar

```bash
# Compilar y ejecutar
./mvnw spring-boot:run

# O con Maven
mvn spring-boot:run
```

## 🌐 URLs importantes

| URL | Descripción |
|-----|-------------|
| `http://localhost:8080/swagger-ui.html` | Swagger UI (todos los endpoints) |
| `http://localhost:8080/h2-console` | Consola H2 (Base de datos en memoria) |
| `http://localhost:8080/api-docs` | OpenAPI JSON spec |

## 📡 Endpoints REST

### 🔐 Security Module
| Method | URL | Descripción |
|--------|-----|-------------|
| GET | `/api/security/persons` | Listar personas |
| POST | `/api/security/persons` | Crear persona |
| GET | `/api/security/persons/{id}` | Obtener por ID |
| PUT | `/api/security/persons/{id}` | Actualizar |
| DELETE | `/api/security/persons/{id}` | Eliminar |
| GET | `/api/security/roles` | Listar roles |
| POST | `/api/security/roles` | Crear rol |
| GET | `/api/security/users` | Listar usuarios |
| POST | `/api/security/users` | Crear usuario |
| GET | `/api/security/user-roles` | Listar asignaciones |
| POST | `/api/security/user-roles` | Asignar rol a usuario |
| GET | `/api/security/user-roles/user/{userId}` | Roles por usuario |

### 🧾 Billing Module
| Method | URL | Descripción |
|--------|-----|-------------|
| GET | `/api/billing/bills` | Listar facturas |
| POST | `/api/billing/bills` | Crear factura con detalles |
| GET | `/api/billing/bills/{id}` | Obtener por ID |
| PATCH | `/api/billing/bills/{id}/status?status=PAID` | Cambiar estado |
| DELETE | `/api/billing/bills/{id}` | Eliminar |
| GET | `/api/billing/bills/user/{userId}` | Facturas por usuario |

### 📦 Inventory Module
| Method | URL | Descripción |
|--------|-----|-------------|
| GET | `/api/inventory/categories` | Listar categorías |
| POST | `/api/inventory/categories` | Crear categoría |
| GET | `/api/inventory/products` | Listar productos |
| POST | `/api/inventory/products` | Crear producto |
| GET | `/api/inventory/products/category/{id}` | Productos por categoría |

## 📝 Ejemplo JSON - Crear Factura

```json
POST /api/billing/bills
{
  "userId": 1,
  "status": "PENDING",
  "details": [
    {
      "productId": 1,
      "quantity": 2,
      "unitPrice": 1200.00
    },
    {
      "productId": 2,
      "quantity": 3,
      "unitPrice": 25.00
    }
  ]
}
```

## 🛠 Tecnologías

- **Spring Boot 3.2** + Java 17
- **Spring Data JPA** + Hibernate
- **H2** (dev) / **PostgreSQL** (prod)
- **Lombok** + Validations
- **SpringDoc OpenAPI** (Swagger UI)

## 🔄 Cambiar a PostgreSQL

En `application.properties`, comenta la sección H2 y descomenta PostgreSQL:

```properties
spring.datasource.url=jdbc:postgresql://localhost:5432/cruddb
spring.datasource.username=postgres
spring.datasource.password=yourpassword
spring.jpa.database-platform=org.hibernate.dialect.PostgreSQLDialect
spring.jpa.hibernate.ddl-auto=update
```
