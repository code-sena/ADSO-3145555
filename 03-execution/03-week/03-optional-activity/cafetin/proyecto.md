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
1. Reestructuración por "Features" (Módulos)
   En lugar de tener todos los archivos mezclados, organizaste el proyecto por funcionalidades. Esto permite que el código sea escalable (que pueda crecer sin volverse un lío).

Seguridad: Todo lo relacionado con Login y Roles.

Inventario: Manejo de productos y stock.

Registro: Control de personas y fichas.

2. Implementación de la Capa de Datos (JPA & Hibernate)
   Convertiste tus ideas en una Base de Datos real en MySQL.

Entidades: Creaste las "plantillas" de Java (como Product, User, Ficha) que Hibernate usa para crear automáticamente las tablas en MySQL.

Relaciones: Definiste cómo se "hablan" las tablas entre sí:

Muchos a Uno: Muchos Usuarios pueden tener un mismo Rol.

Uno a Uno: Un Producto tiene un único registro de Inventario.

Uno a Muchos: Un Usuario puede hacer muchos Pedidos.

3. El Corazón del CRUD: Repositorios
   Creaste interfaces que heredan de JpaRepository. Esto es "magia" de Spring:

Sin escribir SQL: No tuviste que escribir INSERT INTO... ni SELECT * FROM....

Funciones listas: Solo con crear el archivo, ya tienes disponibles los métodos .save(), .findAll(), .deleteById(), etc.

4. La Puerta de Enlace: Controladores (REST API)
   Creaste el ProductController, que es lo que permite que el mundo exterior se comunique con tu código.

Endpoints: Definiste rutas como /api/products.

Métodos HTTP: Configuraste el controlador para entender qué hacer según el botón que presiones en Postman:

GET: Para ver productos.

POST: Para guardar nuevos.

PUT: Para actualizar.

DELETE: Para eliminar.

5. Limpieza de Errores y Dependencias
   Adiós a Lombok (Manualización): Tuviste un problema con la librería Lombok, pero lo solucionaste de la forma más profesional: escribiendo los Getters y Setters manualmente. Esto hizo que tu código fuera más compatible y fácil de leer para el compilador de Java.

Configuración del Servidor: Ajustaste el puerto al 8081 para evitar conflictos y lograste que la consola mostrara el mensaje de éxito: ☕ SISTEMA CAFETÍN SENA ARRANCADO.

6. Pruebas de Integración con Postman
   Finalmente, dejaste de probar "a ciegas". Usaste Postman para:

Enviar datos reales (JSON).

Verificar que el servidor responde.

Confirmar que la información realmente llega a la base de datos MySQL.