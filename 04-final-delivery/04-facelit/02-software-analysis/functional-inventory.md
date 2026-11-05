# Anexo C Inventario funcional y técnico de FaceLit

Revisión integral del 5 de noviembre de 2026. Este inventario reúne componentes, versiones, roles, funciones, datos e integraciones de la entrega documentada. Complementa los criterios del SRS V4.1 y los mapas de la carpeta 16.

## 1 Componentes y revisiones fuente

Los cuatro checkouts locales revisados están en main. El manifiesto de empaquetado registra generatedAtUtc igual a 2026-11-05T03:13:24.4999680Z, equivalente al 4 de noviembre de 2026 en Colombia. Sus commits base coinciden con esta tabla.

| Repositorio | Rama | SHA completo |
|---|---|---|
| FaceLit | main | 6efd92cdd7e4e358b131cbe860cd8585d13e5550 |
| FaceLit-Backend | main | 2ba739853a808c8e5902f70eae98706a612f91e6 |
| micro-facial | main | 166e4a7f2245456277d57015259c678d8febfa9f |
| FaceLit-DB | main | 422aac6da27e3b6b7009f6335e9a887763943089 |

El frontend incorpora un ajuste local sin commit que consulta aprendices en lotes de hasta 80 fichas. FaceLit-DB tiene el commit local de compatibilidad de privacidad 422aac6, diferente de la referencia remota cd069ae0cb4947d4b7ebbff17e9d6dc280ab86fd descrita en el informe de despliegue. El manifiesto marca cambios locales en frontend; el árbol limpio de BD corresponde a un cambio ya confirmado localmente.

La publicación se preparó desde main local y se transfirió por SSH/SCP. El registro de un SHA base y un árbol limpio no demuestra que ese commit exista en origin/main ni que reproduzca los ajustes sin commit. Para reproducir el release se conserva paquete, manifiesto, configuración privada y digests de las imágenes.

## 2 Tecnologías declaradas

| Componente | Configuración revisada | Fuente |
|---|---|---|
| Frontend | Expo 57.0.25, React 19.2.3, React Native 0.86.3 y Expo Router. | package.json y package-lock.json. |
| Backend | Java 17 y Spring Boot 3.4.1; JWT, JPA, correo y WebSocket. | pom.xml y configuración de servicios. |
| Servicio facial | Python 3.11, FastAPI 0.115.6, InsightFace 0.7.3, MediaPipe 0.10.14 y ONNX Runtime 1.20.1. | Dockerfile, requirements.txt y app/core/config.py. |
| Base de datos | PostgreSQL 16 y pgvector; migraciones Liquibase. | deploy/compose.yaml y FaceLit-DB. |
| Migración en API | Liquibase Core 4.29.2, gestionado por el BOM de Spring Boot 3.4.1. | POM y BOM correspondiente. |
| Migración operativa | Imagen liquibase/liquibase:5.0.2 y controlador PostgreSQL 42.7.8. | FaceLit-DB/docker/liquibase/Dockerfile. |
| Publicación | Docker Compose, Caddy, HTTPS público y red privada de servicios. | deploy/compose.yaml, Caddyfile e informe de despliegue. |

Las versiones declaradas describen los archivos revisados. El inventario instalado de un servidor se determina con su manifiesto y los digests de las imágenes del release. El migrador operativo y la biblioteca de la API son componentes con versiones distintas.

## 3 Roles y navegación principal

| Rol | Entradas de Sidebar | Responsabilidad |
|---|---|---|
| Coordinador | Panel; Usuarios; Gestión Académica; Ambientes; Asistencias; Notificaciones; Perfil. | Administra cuentas y formación, procesa CSV y traslados, gestiona ambientes y consulta asistencia. |
| Instructor | Panel; Asistencias; Facial; Notificaciones; Perfil. | Consulta fichas autorizadas, configura sesión y usa la cámara para registrar asistencia. Mis fichas es un acceso contextual del panel. |
| Aprendiz | Panel; Mi Asistencia; Reconocimiento Facial; Notificaciones; Perfil. | Consulta su formación y asistencia, registra su referencia y solicita reemplazo autorizado. |

Sidebar define siete entradas para coordinación y cinco para instructor y aprendiz. Los layouts y useRoleGuard determinan el área del rol; la autorización definitiva depende de la API y del recurso. El catálogo de ambientes debe abrir dentro del área administrativa para una sesión válida de coordinación.

## 4 Inventario de capacidades

| Área | Funciones de la entrega | Punto de referencia |
|---|---|---|
| Acceso y recuperación | Login por documento en la interfaz, sesión, código y nueva contraseña. | AuthContext, useRoleGuard y servicios de autenticación. |
| Gestión académica | Programas, fichas, instructores, aprendices y relaciones. | Gestión Académica y servicios de dominio. |
| CSV y traslados | Guía, carga hasta 20 MB y 5.000 filas, resultado y decisiones de cambio de ficha. | academicApi, importación y avisos de resultados. |
| Usuarios | Listado, filtros, alta, consulta, edición y estado según autorización. | Vistas de usuarios y UserManagementServiceImpl. |
| Ambientes | Catálogo, capacidad, estado y fichas vinculadas. | EnvironmentController y servicios de ambiente. |
| Sesiones de ambiente | Ficha, dispositivo, responsables y tiempos de entrada, registro, salida y cierre. | environmentSessionApi y persistencia de sesión. |
| Registro facial | Identidad, aviso, cámara, retos y confirmación de referencia. | useFacialRegistration, backend facial y micro-facial. |
| Reemplazo facial | Solicitud del titular, decisión de coordinación y nueva autorización. | Solicitud, respuesta en bandeja y servicio facial. |
| Asistencia facial | Sesión activa, verificación, eventos y clasificación temporal. | Cámara del instructor, API facial y persistencia. |
| Consultas y reportes | Matriz, vista individual, historial, calendario y exportación según rol. | Hooks de asistencia y vistas de reportes. |
| Notificaciones | Bandeja, filtros, lectura, categorías y decisiones aplicables. | Servicios de notificación, SMTP y WebSocket. |
| Perfil y preferencias | Datos propios, tema claro u oscuro y ES, EN, DE o FR. | Perfil, configuración del titular y ThemeContext. |

Los estados de los requerimientos permanecen en el Anexo A. La presencia de una capacidad en este inventario identifica su módulo y recorrido; la aceptación detallada se documenta con sus casos CP y evidencias.

## 5 Rutas y puntos de entrada

El diseño visual contiene el inventario de 63 rutas TSX, excluidos los layouts: cinco de acceso público, tres comunes, 27 de coordinación, 23 de instructor y cinco de aprendiz. Distingue entradas de menú, destinos contextuales, reutilización de vistas y redirecciones.

Las rutas heredadas /apprentice/join-ficha y /apprentice/transfer-request redirigen a /apprentice/attendance. Los formularios de registro académico bajo instructor reutilizan vistas administrativas y no otorgan permiso de escritura. Los formularios modales de programa y ambiente se abren en el contexto del listado o detalle. Las constantes antiguas de routes.ts se contrastan con los archivos reales de app antes de usarse como inventario.

## 6 Integraciones y datos principales

| Intercambio | Responsabilidad | Datos o controles |
|---|---|---|
| Interfaz a backend | Solicita operaciones y presenta el resultado. | Sesión, rol, filtros y respuestas autorizadas. |
| Backend a servicio facial | Delega extracción, validación y comparación. | Contrato interno, clave de servicio y configuración del modelo. |
| Servicios a PostgreSQL | Persisten entidades y eventos mediante sus accesos configurados. | Identidades, formación, ambientes, sesiones, asistencia, referencias y avisos. |
| Backend a SMTP | Entrega los mensajes definidos por la operación. | Destinatario y resultado de entrega; configuración privada. |
| Backend a WebSocket | Anuncia cambios para actualizar consultas del usuario. | Evento y nueva consulta bajo autorización. |
| Liquibase a PostgreSQL | Aplica cambios de esquema versionados. | Changelog, orden, validación y registro de changesets. |

La sesión de autenticación identifica el acceso de la cuenta. La sesión de ambiente organiza la jornada y los tiempos de asistencia. Los identificadores de cuenta, aprendiz y ficha cumplen funciones distintas y se envían conforme al contrato de cada API.

## 7 Contrato facial de la revisión

El catálogo activo contiene MOVE_UP, MOVE_DOWN, MOVE_CLOSER y MOVE_AWAY. El registro utiliza dos retos distintos con siete imágenes por reto. La configuración de micro-facial selecciona buffalo_l y un umbral técnico de comparación de 0.65, dentro del rango 0..1. Ese valor es un parámetro de decisión, no una medida de precisión del sistema.

La referencia facial se relaciona con el titular y las operaciones de captura y asistencia usan su autorización y sesión. Las condiciones especializadas de calidad, protección, retención y evaluación conservan los IDs y las decisiones del SRS. El anexo de licenciamiento distingue el código de InsightFace de los modelos preentrenados.

## 8 Evidencias y documentación de apoyo

Las 16 capturas únicas y sus límites se relacionan en el Anexo A. La carpeta 07 distingue confirmación funcional del equipo, capturas, pruebas automatizadas e integración HTTP controlada. Las pruebas reportadas de HU-45 conservan sus conteos y fechas originales; esta revisión no los suma ni los presenta como una nueva corrida.

| Documento | Uso en la entrega |
|---|---|
| [Anexo A](../01-requirements-specification/requirements-traceability.md) | 97 IDs, estados, fuentes y casos. |
| [Anexo B](../01-requirements-specification/criteria-and-decisions.md) | 60 criterios de seguimiento y seis decisiones. |
| [SRS V4.1](../01-requirements-specification/requirements-specification.md) | Definiciones, aceptación y casos por requerimiento. |
| [Evidencias por rol](../05-test-documentation/visual-evidence-by-role.md) | Capturas de coordinación, instructor y aprendiz. |
| [Diseño visual](../04-software-design/visual-design-system.md) | 63 rutas, mapas, flujos, identidad y componentes. |
| [Manual de instalación](../08-manuals/installation-manual.md) | Preparación y arranque del entorno. |
| [Despliegue](../06-implementation-procedure/hostinger-deployment.md) | Topología, main local, ajustes y procedimiento aplicado. |

## 9 Clasificaciones de alcance conservadas

RF-C1 conserva el rastro del módulo de horarios retirado. Los tiempos actuales pertenecen a sesiones de ambiente. El Coordinador de Registro diferenciado conserva DEC-01. Raspberry y la sincronización facial offline permanecen como ampliación futura RNF-5.7. Las diferencias de máscara, identidad, protección y administración de parámetros se consultan por requerimiento en el SRS y el Anexo B.

## 10 Glosario de lectura

| Término | Significado en FaceLit |
|---|---|
| Ficha o Chip | Grupo académico asociado a un programa. |
| UUID | Identificador del registro al que se refiere el contrato. |
| Sesión de acceso | Contexto autenticado de una cuenta, asociado a token y controles de sesión. |
| Sesión de ambiente | Contexto de asistencia con ficha, responsables, dispositivo y tiempos. |
| Embedding o descriptor | Representación numérica facial usada en comparación. |
| Retos de vida | Secuencias de captura solicitadas al usuario. |
| CSV | Archivo tabular de importación académica o salida de una consulta, según el flujo. |
| Changeset | Unidad identificada de cambio del esquema en Liquibase. |
| SHA base | Commit que sirve de referencia al paquete, con los ajustes locales registrados aparte. |
| Digest | Identificador de contenido de una imagen de contenedor. |
| Manifest | Registro de procedencia y revisiones del paquete de despliegue. |
| Evidencia visual | Imagen con un alcance observable descrito en su leyenda. |
