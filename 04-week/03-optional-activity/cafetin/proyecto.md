 SEMANA UNO ///////////////////////////////////////////////////////////////////////////////////////
 
1. El Cimiento: Infraestructura con Docker
   Empieza explicando dónde vive la información:

Qué decir: "Para este proyecto, no instalamos una base de datos tradicional en Windows. Usamos Docker
para crear un contenedor con MySQL 8. Esto garantiza que el entorno sea 'portátil': si tú te llevas
mi carpeta docker-compose.yml, tendrás exactamente la misma base de datos que yo."

Concepto clave: Aislamiento y Portabilidad.

2. El Corazón: Arquitectura de N-Capas
   Explica cómo organizaste el código de Java. Imagina que es un restaurante:

Entidad (El Menú): "Son nuestras clases (User, Product). Aquí definimos qué datos queremos guardar, como el nombre o el precio."

Repository (El Almacén): "Gracias a Spring Data JPA, no escribimos código SQL manual (como INSERT INTO...).
El Repositorio se encarga de hablar con la base de datos automáticamente."

Service (La Cocina): "Aquí es donde procesamos la información antes de guardarla. Es la capa intermedia que asegura
que todo esté correcto."

Controller (El Mesero): "Es el que recibe las órdenes desde afuera (Postman).
Él toma el pedido, se lo lleva al Service y nos trae una respuesta."

3. La Comunicación: API REST y JSON
   Aquí es donde muestras Postman:

Qué decir: "Usamos el protocolo HTTP. Cuando enviamos un POST con un cuerpo en formato JSON,
el controlador lo traduce a un objeto de Java."

El detalle técnico (El error de los null): Puedes mencionar como un logro: "Tuvimos un reto con
los valores null debido a la diferencia entre nombres como tipo_usuario y tipoUsuario.
Lo solucionamos estandarizando el formato camelCase en el JSON para que coincidiera exactamente con nuestras Entidades."

4. Las Relaciones (POO avanzada)
   Muestra tu usuario ID 3 (el que te salió perfecto):

"Mi proyecto aplica los pilares de la POO de la siguiente manera:
Uso Encapsulamiento al declarar mis atributos privados y protegerlos con Getters y Setters.
Aplico Abstracción al modelar las entidades del cafetín en clases específicas.
Utilizo Herencia y Polimorfismo a través de interfaces en la capa de Service, lo que desacopla
la lógica de negocio de la implementación.
Finalmente, manejo Asociaciones complejas, donde un objeto User contiene instancias de Person y Role,
permitiendo una estructura de datos relacional y organizada."

Enlaces de la API (Endpoints)

 Productos
- **GET / POST:** `http://localhost:8081/api/product`

###  Personas
- **GET / POST:** `http://localhost:8081/api/person`
  *Nota: Usar `tipoUsuario` en el JSON para evitar valores null.*

###  Roles
- **GET / POST:** `http://localhost:8081/api/role`

###  Usuarios
- **GET / POST:** `http://localhost:8081/api/user`

---

##  Guía de Operaciones CRUD (Postman)

| Acción | Método | URL | Body (JSON) |
| :--- | :--- | :--- | :--- |
| **Crear** | `POST` | `/api/entidad` | Enviar objeto sin ID |
| **Listar** | `GET` | `/api/entidad` | No requiere Body |
| **Actualizar** | `PUT` | `/api/entidad` | Enviar objeto **CON ID** |
| **Eliminar** | `DELETE` | `/api/entidad/{id}` | ID en la URL |

---

## 💡 Notas de Implementación
1. **Relaciones:** Para crear un Usuario, primero deben existir la Persona y el Rol.
   Se envían como objetos anidados: `"person": {"id": 1}`.
3. **Docker:** El comando `docker-compose down -v` limpia la base de datos, y `up -d` la reinicia desde cero.s


SEMANA DOS ////////////////////////////////////////////////////////////////////////////////

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


### flujo de Realización de Pedido (Aprendiz)

![BPMN Realización Pedido](img/bpmn_pedido.png)

### Flujo de Gestión y Entrega (Cafetería)

![BPMN Gestión Entrega](img/bpmn_gestion.png)
 sesion dos /////--------------------------------------------------------------------------------------------------
En esta nueva versión del proyecto, se ha realizado una reestructuración profunda de
la base de datos para cumplir con los estándares de Seguridad RBAC, Gestión de Inventarios 
y Facturación Automatizada. Se pasó de un modelo básico a uno de nivel empresarial con 23 entidades interconectadas.