
# Producto 02 — Análisis del software


**Servicio Nacional de Aprendizaje (SENA)**  
**Programa:** Análisis y Desarrollo de Software  
**Ficha:** 3145555  
**Proyecto:** SmartHome  
**Elaborado por:** Natalia Chala Chala, Kevin Stiven López Amaya y Karen Daniela Holguín Cruz  
**Instructor:** José de Jesús Motta Vargas  
**Fecha de actualización:** 6 de noviembre de 2026


## 1. Presentación

Este documento actualiza el análisis del software de SmartHome con un criterio más estricto de trazabilidad. Se integran tres tipos de fuente: el código de los repositorios, el SRS revisado en 2026 y la documentación histórica disponible en Drive. El objetivo es describir cómo se comporta el sistema y qué flujos están representados en sus casos de uso y vistas dinámicas, sin afirmar como implementado aquello que solo aparece en documentos históricos.

El análisis se concentra en cuatro ejes funcionales que sí son relevantes para la entrega: autenticación, gestión de hogares y espacios, control/monitoreo de dispositivos y consulta del consumo energético. También se dejan explícitos los límites: una respuesta HTTP exitosa o la publicación de un mensaje MQTT no equivalen, por sí solas, a la confirmación física del dispositivo.

## 2. Fuentes utilizadas y criterio de lectura

| Tipo de fuente | Descripción | Uso en este documento |
|---|---|---|
| Repositorios del proyecto | Backend, frontend web, frontend móvil y base de datos. | Fuente principal para describir lo implementado. |
| SRS final revisado | Requisitos funcionales y no funcionales, roles, alcance y restricciones. | Fuente principal de trazabilidad RF/RNF. |
| Drive del equipo | Diagramas, prototipos, navegación y documentos históricos. | Fuente de apoyo para comprender la intención del diseño. |
| CI / GitHub Actions | Workflows y resultados automáticos. | Fuente de contraste para afirmar qué fue probado y qué no. |

### 2.1 Repositorios y referencias de trabajo

| Componente | Repositorio | Referencia base usada en el análisis |
|---|---|---|
| Backend | `nataliachala1/smarthome-backend` | rama `dev` y evidencia documental previa |
| Frontend web | `nataliachala1/smarthome-frontend-web` | rama `dev` y evidencia documental previa |
| Frontend móvil | `Kevin-Stiven-Lopez-Amaya404/from_movil` | rama `dev` y evidencia documental previa |
| Base de datos | `nataliachala1/smarthome-database` | rama `dev/main` y changelog Liquibase |

## 3. Alcance funcional analizado

De acuerdo con el SRS revisado, SmartHome contempla gestión de usuarios, hogares, dispositivos, monitoreo de consumo, reportes, notificaciones y opciones de personalización. Para este documento se priorizan los flujos que permiten explicar la lógica principal del sistema y conectarla con vistas dinámicas útiles para la entrega.

### 3.1 Actores identificados

- **Usuario autenticado:** consulta información de hogares, dispositivos, consumo, notificaciones y reportes.
- **Administrador o usuario con mayores permisos:** puede ejecutar tareas de administración según su rol global o rol por hogar.
- **Invitado o miembro restringido:** consume información y tiene permisos limitados sobre acciones sensibles.
- **Backend SmartHome:** orquesta validaciones, reglas de negocio, acceso a datos y emisión de eventos.
- **Dispositivo IoT / canal MQTT:** recibe órdenes o entrega telemetría cuando el entorno está configurado.
- **Base de datos PostgreSQL:** persiste usuarios, hogares, membresías, dispositivos, telemetría y auditoría.

## 4. Matriz de trazabilidad entre requisitos y flujos analizados

| Flujo / caso de uso analizado | Requisitos del SRS relacionados | Qué se analiza |
|---|---|---|
| Inicio de sesión | RF1.2, RF1.4, RF1.8 | Validación de credenciales, generación de sesión, cierre y recuperación. |
| Gestión básica de hogares | RF2.1, RF2.2, RF2.3 | Creación/actualización del hogar y vínculo con dispositivos. |
| Registro y gestión de dispositivos | RF3.1, RF3.2, RF3.3, RF3.4 | Alta, configuración, actualización y desactivación. |
| Monitoreo y control del dispositivo | RF3.5, RF4.2 | Consulta del estado, control remoto y sincronización del estado. |
| Reportes y consumo | RF4.1, RF4.3 | Consulta histórica, gráficos y consolidación de consumo. |
| Notificaciones | RF4.4 | Visualización y manejo de avisos del sistema. |
| Sincronización entre plataformas | RF5.1, RF5.3 | Consistencia entre clientes y recuperación de información. |
| Personalización | RF6.1, RF6.2 | Idioma, tema y preferencias de interfaz. |

## 5. Relación entre los diagramas y los requisitos

La mejora principal de esta versión consiste en dejar de tratar los diagramas como piezas aisladas. Cada vista dinámica ahora se entiende como un soporte visual de uno o varios requisitos.

| Vista dinámica | Propósito | Requisitos asociados |
|---|---|---|
| Casos de uso del sistema | Delimitar actores y funcionalidades principales. | RF1.*, RF2.*, RF3.*, RF4.*, RF5.*, RF6.* |
| Secuencia de inicio de sesión | Mostrar el intercambio cliente → backend → persistencia. | RF1.2, RF1.4, RF1.8 |
| Actividad de control de dispositivo | Representar decisiones y permisos antes de emitir una orden. | RF3.5, RF2.3 |
| Secuencia de consulta de consumo | Representar lectura de datos y respuesta al usuario. | RF4.1, RF4.2, RF4.3 |
| Actividad de notificaciones / alertas | Mostrar generación, recuperación y lectura de avisos. | RF4.4 |

## 6. Análisis de flujos principales

### 6.1 Flujo 1 — autenticación del usuario

El recorrido inicia cuando el usuario envía sus credenciales desde el cliente web o móvil. El backend valida formato, identidad y estado de la cuenta; si la verificación es exitosa, se genera una sesión o token y el cliente habilita el acceso a módulos protegidos. En este flujo también se relacionan procesos de cierre de sesión y recuperación de contraseña, porque forman parte del ciclo de autenticación.

**Lo que sí se puede afirmar:** existe una estructura funcional donde la autenticación es un módulo reconocible y está conectada con el consumo de APIs desde web y móvil.  
**Lo que no debe afirmarse sin nueva evidencia:** que MFA esté operativo y obligatorio en v1.0, porque el SRS revisado lo deja fuera de alcance y los documentos históricos no son prueba suficiente.

### 6.2 Flujo 2 — gestión y control de dispositivos

Una vez autenticado, el usuario accede al listado de dispositivos de su hogar. Desde ese punto puede consultar estados, editar datos, asociar un dispositivo a un contexto del hogar y, si tiene permisos, emitir acciones de control. El backend valida membresía y rol antes de ejecutar la lógica correspondiente.

Cuando el caso de uso implica control remoto, la aplicación puede terminar en una publicación de evento, comando o mensaje hacia el componente que se comunica con el canal IoT. Por eso el análisis separa dos resultados distintos:

1. **Orden aceptada por el sistema**: el backend admite la solicitud y genera la acción interna.
2. **Accionamiento físico comprobado**: requiere evidencia adicional de laboratorio o pruebas integradas.

### 6.3 Flujo 3 — consulta de consumo energético

El consumo energético se consulta desde la interfaz como datos en tiempo real, históricos o reportes consolidados. En el recorrido participan el backend, la base de datos y, cuando aplica, canales de actualización en tiempo real. La capa cliente organiza filtros por hogar, período, dispositivo o agrupación temporal.

Este flujo se relaciona directamente con RF4.1, RF4.2 y RF4.3, y además depende de que la base de datos y el pipeline de datos estén correctamente configurados. La presencia de la interfaz y del servicio no equivale a garantizar un volumen de telemetría real si no hay un entorno IoT activo.

### 6.4 Flujo 4 — notificaciones y sincronización

Las notificaciones sirven como punto de unión entre consumo, alertas y experiencia del usuario. Su análisis se conecta con RF4.4 y con la parte de sincronización de RF5.1. Desde la perspectiva de arquitectura, su presencia demuestra que el sistema no es solo CRUD: también busca mantener al usuario informado frente a cambios relevantes.

## 7. Hallazgos principales

1. El sistema presenta una organización suficiente para describir los flujos principales sin depender únicamente de pantallas.
2. El SRS actualizado corrige o limita algunas afirmaciones históricas; por ejemplo, MFA y operación offline total no deben tratarse como características verificadas de la versión 1.0.
3. El análisis de control de dispositivos debe conservar la distinción entre **orden emitida** y **acción física comprobada**.
4. Los diagramas del equipo son útiles, pero deben citarse como apoyo documental y no como prueba de ejecución.
5. La trazabilidad mejora cuando cada caso de uso se conecta explícitamente con uno o varios requisitos RF/RNF.

## 8. Limitaciones y pendientes

- Este documento no sustituye las pruebas funcionales del producto 05.
- No se adjuntan credenciales, IP privadas ni secretos de entorno.
- La confirmación de integración IoT, WebSocket y hardware Shelly depende de ensayos controlados y evidencias adicionales.
- La conciliación final con la versión etiquetada en `main` debe hacerse antes del cierre formal de la entrega.

## 9. Conclusión

SmartHome puede describirse de forma consistente como un sistema con clientes web y móvil, backend central, persistencia en PostgreSQL y componentes de integración IoT. La mejora introducida en esta versión del documento consiste en amarrar ese análisis a los requisitos oficiales del SRS, evitando afirmaciones no verificadas. En consecuencia, el producto 02 queda mejor sustentado para una revisión académica y técnica.