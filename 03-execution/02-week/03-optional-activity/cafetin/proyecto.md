# ☕ Proyecto Cafetín - Documentación de la API

## 🚀 Configuración del Entorno
* **Lenguaje:** Java 24 (Spring Boot 4.0.3)
* **Base de Datos:** MySQL 8.0 (Corriendo en Docker)
* **Puerto del Servidor:** 8081

## 🔗 Enlaces de la API (Endpoints)

### 🛒 Productos
- **GET / POST:** `http://localhost:8081/api/product`

### 👥 Personas
- **GET / POST:** `http://localhost:8081/api/person`
  *Nota: Usar `tipoUsuario` en el JSON para evitar valores null.*

### 🔑 Roles
- **GET / POST:** `http://localhost:8081/api/role`

### 👤 Usuarios
- **GET / POST:** `http://localhost:8081/api/user`

---

## 🛠️ Guía de Operaciones CRUD (Postman)

| Acción | Método | URL | Body (JSON) |
| :--- | :--- | :--- | :--- |
| **Crear** | `POST` | `/api/entidad` | Enviar objeto sin ID |
| **Listar** | `GET` | `/api/entidad` | No requiere Body |
| **Actualizar** | `PUT` | `/api/entidad` | Enviar objeto **CON ID** |
| **Eliminar** | `DELETE` | `/api/entidad/{id}` | ID en la URL |

---

## 💡 Notas de Implementación
1. **Relaciones:** Para crear un Usuario, primero deben existir la Persona y el Rol. Se envían como objetos anidados: `"person": {"id": 1}`.
2. **Docker:** El comando `docker-compose down -v` limpia la base de datos, y `up -d` la reinicia desde cero.s