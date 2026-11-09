# Anexo A Matriz de trazabilidad de FaceLit

Revisión integral del 5 de noviembre de 2026. Referencia de requerimientos: SRS V4.1, con 97 identificadores conservados. Este anexo permite seguir cada requerimiento desde su ID hasta el caso de prueba y la familia de fuentes que lo sustenta.

## 1 Alcance y lectura de la matriz

El equipo confirmó el funcionamiento de acceso, CSV, cámara, asistencia y correo al 4 de noviembre. La matriz conserva los estados del SRS vigente y añade una guía de consulta de fuentes y capturas. Esta revisión documental no incorpora una nueva ejecución de los 97 casos.

La columna Fuente remite al catálogo SRC-01 a SRC-08 de este anexo. El caso CP seguido del ID se define en el SRS, sección 8. El Anexo B organiza los 60 criterios que requieren seguimiento específico. Un resultado visible de una pantalla sustenta lo descrito en su leyenda; las mediciones, permisos negativos y resultados de archivos se conservan con su ejecución.

## 2 Estados documentales y recuento

| Estado | Cantidad | Interpretación |
|---|---|---|
| Operativo confirmado | 6 | El equipo confirmó la función en el sistema. Los criterios especializados se revisan por caso. |
| Evidencia visual | 8 | La imagen documenta el resultado visible que explica su leyenda. |
| Integrado en código | 23 | Se localiza la implementación descrita en interfaz, API o persistencia. |
| Integrado con criterio adicional | 2 | La operación existe y una condición del SRS requiere evidencia o definición adicional. |
| Criterio por verificar | 48 | El criterio necesita un resultado específico de ejecución, medición o decisión. |
| Diferencia con el criterio | 6 | La revisión del SRS identifica una diferencia concreta frente a su exigencia escrita. |
| Objetivo adicional | 2 | La capacidad del baseline requiere definición o implementación específica. |
| Retirado del alcance vigente | 1 | El ID conserva el rastro de una capacidad retirada. |
| Ampliación futura | 1 | La capacidad pertenece a una extensión de la entrega conectada actual. |

Total: 97 requerimientos, 34 funcionales y 63 no funcionales. Estos recuentos clasifican evidencia y alcance; no son un porcentaje de aprobación ni de cobertura del producto.

## 3 Requerimientos funcionales

| ID | Requerimiento | Estado | Fuente | Caso |
|---|---|---|---|---|
| RF-1.1 | Inicio de sesión | Operativo confirmado | SRC-01 | CP-RF-1.1 |
| RF-1.2 | Derechos de acceso | Integrado en código | SRC-01 | CP-RF-1.2 |
| RF-1.3 | Definición de rol al iniciar sesión | Integrado en código | SRC-01 | CP-RF-1.3 |
| RF-1.4 | Restablecimiento de contraseña | Operativo confirmado | SRC-01 | CP-RF-1.4 |
| RF-2.1 | Carga institucional por archivo CSV | Operativo confirmado | SRC-02 | CP-RF-2.1 |
| RF-2.1.1 | Guía y plantilla del archivo CSV | Evidencia visual | SRC-02 | CP-RF-2.1.1 |
| RF-2.2 | Gestión académica manual | Integrado en código | SRC-02 | CP-RF-2.2 |
| RF-2.3 | Traslado de ficha de un aprendiz | Integrado en código | SRC-02 | CP-RF-2.3 |
| RF-3.1 | Panel de usuarios registrados | Evidencia visual | SRC-03 | CP-RF-3.1 |
| RF-3.2 | Consulta y gestión de usuarios | Integrado en código | SRC-03 | CP-RF-3.2 |
| RF-3.3 | Creación de usuarios de registro | Objetivo adicional | SRC-03 | CP-RF-3.3 |
| RF-3.4 | Credencial inicial generada por el sistema | Integrado con criterio adicional | SRC-03 | CP-RF-3.4 |
| RF-3.5 | Restricción de roles asignables | Objetivo adicional | SRC-03 | CP-RF-3.5 |
| RF-3.6 | Estado del usuario | Integrado en código | SRC-01 | CP-RF-3.6 |
| RF-4.1 | Consulta del perfil propio | Evidencia visual | SRC-04 | CP-RF-4.1 |
| RF-4.2 | Configuración de preferencias personales | Integrado en código | SRC-04 | CP-RF-4.2 |
| RF-5.1 | Registro facial inicial del aprendiz | Operativo confirmado | SRC-05 | CP-RF-5.1 |
| RF-5.2 | Preparación de sesión de reconocimiento | Integrado en código | SRC-06 | CP-RF-5.2 |
| RF-5.3 | Administración de parámetros faciales | Integrado con criterio adicional | SRC-05 | CP-RF-5.3 |
| RF-5.4 | Resolución de solicitud de registro facial | Integrado en código | SRC-05 | CP-RF-5.4 |
| RF-6.1 | Configuración de asistencia facial | Operativo confirmado | SRC-06 | CP-RF-6.1 |
| RF-6.2 | Ajustes de registro, salida y apagado | Integrado en código | SRC-06 | CP-RF-6.2 |
| RF-7.1 | Consulta de asistencia por ficha | Evidencia visual | SRC-07 | CP-RF-7.1 |
| RF-7.2 | Consulta de asistencia individual | Evidencia visual | SRC-07 | CP-RF-7.2 |
| RF-7.3 | Historial de asistencia | Integrado en código | SRC-07 | CP-RF-7.3 |
| RF-8.1 | Generación automática de notificaciones | Evidencia visual | SRC-08 | CP-RF-8.1 |
| RF-8.2 | Visualización de notificaciones | Evidencia visual | SRC-08 | CP-RF-8.2 |
| RF-8.3 | Envío de notificaciones por correo | Operativo confirmado | SRC-08 | CP-RF-8.3 |
| RF-8.4 | Notificación de solicitud de registro facial | Integrado en código | SRC-08 | CP-RF-8.4 |
| RF-9.1 | Reportes y consultas por rol | Integrado en código | SRC-07 | CP-RF-9.1 |
| RF-C1 | Horarios y excepciones | Retirado del alcance vigente | SRC-06 | CP-RF-C1 |
| RF-C2 | Ambientes, dispositivos y sesiones | Evidencia visual | SRC-06 | CP-RF-C2 |
| RF-C3 | Persistencia de preferencias entre sesiones | Integrado en código | SRC-04 | CP-RF-C3 |
| RF-C4 | Sincronización en tiempo real | Integrado en código | SRC-08 | CP-RF-C4 |

## 4 Requerimientos no funcionales

| ID | Requerimiento | Estado | Fuente | Caso |
|---|---|---|---|---|
| RNF-1.1 | Seguridad de autenticación | Criterio por verificar | SRC-01 | CP-RNF-1.1 |
| RNF-1.2 | Política de contraseñas | Criterio por verificar | SRC-01 | CP-RNF-1.2 |
| RNF-1.3 | Protección contra intentos de acceso no autorizados | Integrado en código | SRC-01 | CP-RNF-1.3 |
| RNF-1.4 | Control de acceso basado en roles | Criterio por verificar | SRC-01 | CP-RNF-1.4 |
| RNF-1.5 | Restricción de información por rol | Criterio por verificar | SRC-01 | CP-RNF-1.5 |
| RNF-1.6 | Protección de datos personales | Criterio por verificar | SRC-01 | CP-RNF-1.6 |
| RNF-1.7 | Gestión de actualización de datos personales | Criterio por verificar | SRC-01 | CP-RNF-1.7 |
| RNF-1.8 | Auditoría y trazabilidad | Criterio por verificar | SRC-01 | CP-RNF-1.8 |
| RNF-1.9 | Seguridad del restablecimiento de contraseña | Criterio por verificar | SRC-01 | CP-RNF-1.9 |
| RNF-1.10 | Protección del correo electrónico | Diferencia con el criterio | SRC-01 | CP-RNF-1.10 |
| RNF-1.11 | Gestión segura de sesiones | Integrado en código | SRC-01 | CP-RNF-1.11 |
| RNF-1.12 | Rendimiento del inicio de sesión | Criterio por verificar | SRC-01 | CP-RNF-1.12 |
| RNF-1.13 | Disponibilidad del servicio de autenticación | Criterio por verificar | SRC-01 | CP-RNF-1.13 |
| RNF-1.14 | Usabilidad del acceso | Criterio por verificar | SRC-01 | CP-RNF-1.14 |
| RNF-1.15 | Separación de responsabilidades | Integrado en código | SRC-01 | CP-RNF-1.15 |
| RNF-1.16 | Integridad de los permisos | Integrado en código | SRC-01 | CP-RNF-1.16 |
| RNF-2.1 | Control de acceso | Integrado en código | SRC-02 | CP-RNF-2.1 |
| RNF-2.2 | Validación e integridad de datos | Criterio por verificar | SRC-02 | CP-RNF-2.2 |
| RNF-2.3 | Trazabilidad completa | Criterio por verificar | SRC-02 | CP-RNF-2.3 |
| RNF-2.4 | Protección de datos personales | Criterio por verificar | SRC-02 | CP-RNF-2.4 |
| RNF-2.5 | Rendimiento de la carga de CSV | Criterio por verificar | SRC-02 | CP-RNF-2.5 |
| RNF-2.6 | Disponibilidad de la información académica | Criterio por verificar | SRC-02 | CP-RNF-2.6 |
| RNF-2.7 | Usabilidad para un usuario no técnico | Criterio por verificar | SRC-02 | CP-RNF-2.7 |
| RNF-2.8 | Consistencia entre carga por CSV y edición manual | Criterio por verificar | SRC-02 | CP-RNF-2.8 |
| RNF-2.9 | Unicidad de identificadores | Criterio por verificar | SRC-02 | CP-RNF-2.9 |
| RNF-2.10 | Atomicidad del traslado de ficha | Criterio por verificar | SRC-02 | CP-RNF-2.10 |
| RNF-2.11 | Auditoría de la resolución de inconsistencias | Criterio por verificar | SRC-02 | CP-RNF-2.11 |
| RNF-2.12 | Escalabilidad de la gestión académica | Criterio por verificar | SRC-02 | CP-RNF-2.12 |
| RNF-2.13 | Recuperación ante fallos durante la carga de CSV | Criterio por verificar | SRC-02 | CP-RNF-2.13 |
| RNF-2.14 | Internacionalización de nombres y apellidos | Criterio por verificar | SRC-02 | CP-RNF-2.14 |
| RNF-3.1 | Panel de usuarios registrados | Criterio por verificar | SRC-03 | CP-RNF-3.1 |
| RNF-3.2 | Unicidad de número de documento | Criterio por verificar | SRC-03 | CP-RNF-3.2 |
| RNF-3.3 | Contraseña inicial segura | Criterio por verificar | SRC-03 | CP-RNF-3.3 |
| RNF-3.4 | Inmutabilidad del número de documento | Diferencia con el criterio | SRC-03 | CP-RNF-3.4 |
| RNF-3.5 | Trazabilidad de cambios en usuarios | Criterio por verificar | SRC-03 | CP-RNF-3.5 |
| RNF-3.6 | Desactivación sin eliminación de historial | Integrado en código | SRC-03 | CP-RNF-3.6 |
| RNF-3.7 | Exportación del listado de usuarios | Criterio por verificar | SRC-03 | CP-RNF-3.7 |
| RNF-4.1 | Visualización de datos propios | Criterio por verificar | SRC-04 | CP-RNF-4.1 |
| RNF-4.2 | Enmascaramiento del correo electrónico | Diferencia con el criterio | SRC-04 | CP-RNF-4.2 |
| RNF-4.3 | Cierre de sesión seguro | Integrado en código | SRC-04 | CP-RNF-4.3 |
| RNF-4.4 | Cierre de sesión automático por inactividad | Criterio por verificar | SRC-04 | CP-RNF-4.4 |
| RNF-4.5 | Restricción de modificación de datos propios | Criterio por verificar | SRC-04 | CP-RNF-4.5 |
| RNF-5.1 | Detección de un único rostro en el encuadre | Criterio por verificar | SRC-05 | CP-RNF-5.1 |
| RNF-5.2 | Calidad mínima de captura facial | Criterio por verificar | SRC-05 | CP-RNF-5.2 |
| RNF-5.3 | Registro facial con múltiples capturas | Integrado en código | SRC-05 | CP-RNF-5.3 |
| RNF-5.4 | Almacenamiento encriptado de descriptores faciales | Diferencia con el criterio | SRC-05 | CP-RNF-5.4 |
| RNF-5.5 | Umbral configurable de similitud facial | Diferencia con el criterio | SRC-05 | CP-RNF-5.5 |
| RNF-5.6 | Transmisión segura de datos de identificación | Diferencia con el criterio | SRC-05 | CP-RNF-5.6 |
| RNF-5.7 | Sincronización offline de registros faciales | Ampliación futura | SRC-05 | CP-RNF-5.7 |
| RNF-6.1 | Registro automático de asistencia | Criterio por verificar | SRC-06 | CP-RNF-6.1 |
| RNF-6.2 | Clasificación automática del estado de asistencia | Criterio por verificar | SRC-06 | CP-RNF-6.2 |
| RNF-6.3 | Inmutabilidad de registros de asistencia | Criterio por verificar | SRC-06 | CP-RNF-6.3 |
| RNF-6.4 | Alerta por retrasos repetidos | Criterio por verificar | SRC-06 | CP-RNF-6.4 |
| RNF-6.5 | Registro manual de asistencia como respaldo | Criterio por verificar | SRC-06 | CP-RNF-6.5 |
| RNF-7.1 | Control de acceso en reportes por usuario | Criterio por verificar | SRC-07 | CP-RNF-7.1 |
| RNF-7.2 | Rendimiento en generación de reportes | Criterio por verificar | SRC-07 | CP-RNF-7.2 |
| RNF-7.3 | Exportación de reportes en formato Excel | Criterio por verificar | SRC-07 | CP-RNF-7.3 |
| RNF-7.4 | Alerta visual de asistencia crítica en reporte de ficha | Criterio por verificar | SRC-07 | CP-RNF-7.4 |
| RNF-7.5 | Vista de calendario de asistencia | Criterio por verificar | SRC-07 | CP-RNF-7.5 |
| RNF-8.1 | Generación automática de notificaciones por eventos | Criterio por verificar | SRC-08 | CP-RNF-8.1 |
| RNF-8.2 | Persistencia y disponibilidad de notificaciones | Criterio por verificar | SRC-08 | CP-RNF-8.2 |
| RNF-8.3 | Límite de envío de correos de notificación | Criterio por verificar | SRC-08 | CP-RNF-8.3 |
| RNF-8.4 | Reintentos de entrega de notificaciones fallidas | Criterio por verificar | SRC-08 | CP-RNF-8.4 |

## 5 Catálogo de fuentes

Los archivos de frontend son relativos a FaceLit. Los caminos backend que comienzan por config, auth, academic, environment, facial, notification o realtime se resuelven bajo FaceLit-Backend/src/main/java/com/FaceLit/backend. Los archivos de Python se resuelven en micro-facial. Las revisiones completas de los cuatro repositorios están en el Anexo C.

| Fuente | Área | Archivos y evidencia |
|---|---|---|
| SRC-01 | Acceso y sesión | FaceLit/shared/contexts/AuthContext.tsx; backend/config/SecurityConfig.java y JwtFilter.java; auth/service/serviceImpl/roleandpermission/LoginServiceImpl.java y JwtServiceImpl.java; SessionSecurityService.java. |
| SRC-02 | Gestión académica | FaceLit/features/academic/academicApi.ts y useAcademic.ts; backend/academic/controller y service/serviceImpl/academic; Capturas COO-03, COO-04 y COO-07. |
| SRC-03 | Usuarios y credenciales | FaceLit/app/admin/users; backend/auth/service/serviceImpl/security/UserManagementServiceImpl.java e InitialCredentialServiceImpl.java; academic/dto/response/academic; Captura COO-02. |
| SRC-04 | Perfil y preferencias | FaceLit/app/profile; features/profile/useUserSettings.ts; backend/auth/model/enums/Language.java y servicios de configuración; Capturas COO-08 y APR-07. |
| SRC-05 | Registro facial | FaceLit/features/auth/hooks/useFacialRegistration.ts; backend/facial y FaceResetRequestRepository; micro-facial/app/core/config.py y servicios faciales; Capturas APR-04 a APR-06. |
| SRC-06 | Ambientes y sesiones | FaceLit/features/environments/environmentSessionApi.ts y environmentsStore.ts; backend/environment/controller/EnvironmentController.java; EnvironmentServiceImpl.java; SecurityConfig; Captura COO-05. |
| SRC-07 | Asistencia y reportes | FaceLit/features/attendance/useAttendance.ts y useAttendanceRF6.ts; shared/services/facialAttendanceService; backend/facial; Capturas COO-06, INS-01, APR-02 y APR-03. |
| SRC-08 | Notificaciones y tiempo real | FaceLit/features/notifications; shared/services/realtime.ts; backend/notification y realtime; Capturas COO-07 y APR-06. |

## 6 Registro de las capturas citadas

El catálogo de la carpeta 07 contiene 17 archivos originales y 16 capturas únicas: ocho de coordinación, una de instructor y siete de aprendiz. Las dos imágenes originales del instructor tienen el mismo hash. Los enlaces siguientes abren las copias de entrega con los datos personales cubiertos.

| Captura | Pantalla | Alcance observado |
|---|---|---|
| COO-01 | [Panel principal](../05-test-documentation/role-captures/coordinator-1.png) | Indicadores y accesos del panel; conteos del momento de captura. |
| COO-02 | [Gestión de usuarios](../05-test-documentation/role-captures/coordinator-2.png) | Listado, filtros y acción de crear usuario. |
| COO-03 | [Programas de formación](../05-test-documentation/role-captures/coordinator-3.png) | Programas activos, fichas y accesos académicos. |
| COO-04 | [Carga académica por CSV](../05-test-documentation/role-captures/coordinator-4.png) | Formulario, guía y límites del CSV antes de elegir archivo. |
| COO-05 | [Gestión de ambientes](../05-test-documentation/role-captures/coordinator-5.png) | Catálogo de ambientes abierto dentro del área de coordinación. |
| COO-06 | [Control de asistencia](../05-test-documentation/role-captures/coordinator-6.png) | Estado inicial de asistencia por ficha, previo a seleccionar programa. |
| COO-07 | [Centro de notificaciones](../05-test-documentation/role-captures/coordinator-7.png) | Bandeja y avisos de filas rechazadas por referencias de importación. |
| COO-08 | [Perfil](../05-test-documentation/role-captures/coordinator-8.png) | Consulta del perfil del coordinador. |
| INS-01 | [Matriz de asistencia por ficha](../05-test-documentation/role-captures/instructor-1.png) | Matriz por fecha con inasistencias y controles de exportación. |
| APR-01 | [Panel y formación asignada](../05-test-documentation/role-captures/apprentice-1.png) | Formación asignada y accesos del aprendiz. |
| APR-02 | [Mi Asistencia antes de consultar](../05-test-documentation/role-captures/apprentice-2.png) | Consulta propia antes de elegir fechas. |
| APR-03 | [Mi Asistencia después de consultar](../05-test-documentation/role-captures/apprentice-2-5.png) | Consulta propia con un retraso y resumen del periodo. |
| APR-04 | [Preparación del registro facial](../05-test-documentation/role-captures/apprentice-3.png) | Verificación de identidad, aviso y preparación del registro facial. |
| APR-05 | [Captura del reto facial](../05-test-documentation/role-captures/apprentice-4.png) | Fase de validación del reto; el resultado final queda fuera de la imagen. |
| APR-06 | [Notificaciones del aprendiz](../05-test-documentation/role-captures/apprentice-5.png) | Bandeja con resultado de registro facial reportado por la interfaz. |
| APR-07 | [Perfil del aprendiz](../05-test-documentation/role-captures/apprentice-6.png) | Consulta del perfil del aprendiz. |

Las imágenes no identifican por sí solas el SHA del servidor, el tiempo de respuesta, la precisión biométrica ni el contenido de un archivo descargado. Las suites del 27 de octubre y la confirmación funcional del equipo se describen por separado en la carpeta 07.

## 7 Regla de actualización

Cuando se documente una nueva ejecución, registrar caso, variante, fecha, ejecutor, entorno, SHA, entradas, resultado esperado, resultado obtenido y artefacto. Cambiar el estado de aceptación con el resultado del caso y la aprobación correspondiente. Si cambia el requerimiento, versionarlo primero en el SRS y reflejar el mismo ID y estado en ambos anexos.

## 8 Documentos relacionados

[SRS V4.1](requirements-specification.md); [Anexo B y criterios de seguimiento](criteria-and-decisions.md); [Anexo C e inventario funcional](../02-software-analysis/functional-inventory.md); [catálogo visual por rol](../05-test-documentation/visual-evidence-by-role.md); [resultados de pruebas documentados](../05-test-documentation/reported-test-results.md).
