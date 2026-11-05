# FaceLit
**Especificación de requisitos de software**

Sistema de gestión académica y asistencia con apoyo de reconocimiento facial

| RF principales | RF complementarios | RNF |
|---|---|---|
| 30 | 4 | 63 |

Versión 4.1 · revisión integral documental del baseline V4
Actualización de estado documentado: 4 de noviembre de 2026
Valery Sinaí Trujillo · María José Rodríguez Oyola · Mariana Valenzuela Penagos
Instructor: Motta Vargas José de Jesús
SENA · Análisis y Desarrollo de Software · Ficha 3145555

---

# Control documental

FaceLit es un sistema para gestionar información académica y registrar asistencia mediante reconocimiento facial en ambientes de formación del SENA. Esta especificación consolida funciones, reglas, restricciones, criterios de aceptación e interfaces del producto para orientar su implementación, revisión y entrega académica.

| Dato | Valor |
|---|---|
| Documento | Especificación de requisitos de software de FaceLit |
| Versión | 4.1 — actualización integral del SRS V4 |
| Fecha del baseline de requisitos | 13 de octubre de 2026 |
| Fecha de actualización de estado | 4 de noviembre de 2026 |
| Institución | Servicio Nacional de Aprendizaje SENA |
| Programa y ficha | Análisis y Desarrollo de Software 3145555 |
| Equipo | Valery Sinaí Trujillo; María José Rodríguez Oyola; Mariana Valenzuela Penagos |
| Instructor | Motta Vargas José de Jesús |
| Estado documental | SRS V4.1 con inventario de 97 identificadores, estado por requisito y fuentes de evidencia al 4 de noviembre. |
| Cobertura | 30 RF principales, 4 RF complementarios y 63 RNF |
| Idioma | Español |

## Historial de versiones

| Versión | Referencia | Cambio |
|---|---|---|
| 3.0 | Documento previo | Requisitos objetivo y diagnóstico de implementación. |
| 4.0 | 13 octubre 2026 | Baseline de requisitos: alcance, contratos, seguridad, numeración, criterios y trazabilidad. |
| Actualización de estado | 27 octubre 2026 | Registro de HU-45 y despliegue anterior. |
| 4.1 | 4 noviembre 2026 | Actualización por ID, roles vigentes, Ambientes, sesiones, contrato facial HU-45, fuentes de asistencia, preferencias, capturas y publicación desde main local. |

La versión documental no constituye una certificación de cumplimiento del software. El anexo de trazabilidad separa el comportamiento requerido del estado observado. Las decisiones DEC-01 a DEC-06 requieren validación institucional antes de aceptar los aspectos que dependen de ellas; su existencia no invalida los requisitos ya determinados.

# 1 Introducción

## 1.1 Propósito

Establecer de manera verificable el comportamiento de FaceLit, sus límites de acceso, sus datos y sus atributos de calidad. El documento sirve al equipo desarrollador, instructor, responsables académicos y evaluadores como referencia para diseño, implementación, pruebas y aceptación.

## 1.2 Problema y justificación

El control manual de asistencia exige registrar cada aprendiz, comprobar su llegada y conservar evidencia de puntualidad e inasistencia. Las omisiones, la duplicidad de registros y la dispersión de información dificultan el seguimiento. FaceLit propone automatizar parte de ese proceso y reunir la gestión académica, las sesiones y los reportes en una fuente trazable. El reconocimiento facial aporta una verificación de identidad, pero su eficacia debe demostrarse con pruebas y controles contra suplantación.

## 1.3 Objetivo general

Desarrollar un sistema de gestión y registro de asistencia académica mediante reconocimiento facial que permita identificar a los aprendices, registrar entrada y salida, clasificar puntualidad y consultar información confiable por rol.

## 1.4 Objetivos específicos

- Gestionar programas, fichas, personas y relaciones por CSV y formularios con integridad y auditoría.
- Establecer sesiones vinculadas a ficha, ambiente, responsables, dispositivo y tiempos de operación.
- Registrar referencias faciales y verificar capturas con controles de vida, calidad y privacidad.
- Generar consultas, reportes y exportaciones a partir de eventos reales y consistentes.
- Proteger autenticación, autorización, sesiones, credenciales y datos personales.
- Verificar requisitos funcionales y de calidad mediante casos de aceptación trazables.

## 1.5 Convenciones de lectura

“Deberá” expresa una obligación del producto. Cada RF identifica actor, entrada, flujo, alternativas, resultado y aceptación. Los RNF definen controles y atributos comprobables. Los IDs RF-1.1 a RF-9.1 y RNF-1.1 a RNF-8.4 se conservan; RF-C1 a RF-C4 pertenecen al inventario complementario. El orden del módulo de RNF no se asume equivalente al número de RF: las relaciones se indican explícitamente.

# 2 Alcance y perspectiva del producto

## 2.1 Alcance funcional requerido

- Acceso por documento, recuperación, roles, permisos, sesiones y perfil.
- Gestión académica institucional, vínculos, traslados y decisiones sobre inconsistencias CSV.
- Gestión de cuentas, estado y credenciales iniciales protegidas.
- Registro y re-registro facial autorizado, parámetros y sesiones de captura.
- Asistencia por entrada y salida, consulta, respaldo manual y anulación auditada.
- Notificaciones, reportes, calendario, exportaciones y sincronización en tiempo real.
- Ambientes, dispositivos y sesiones con ventanas de entrada, salida y cierre como soporte de asistencia.

## 2.2 Alcance operativo observado

La entrega comprende frontend Expo y React Native, API Spring Boot, PostgreSQL con Liquibase y servicio facial FastAPI. El equipo confirma funcionamiento de login, CSV, correo, cámara y asistencia. Las capturas recibidas muestran gestión académica con datos, Ambientes, consultas de asistencia, notificaciones y perfiles.

Los tres roles de backend son APPRENTICE, INSTRUCTOR y COORDINATOR. El catálogo de ambientes está integrado y las sesiones definen los tiempos de asistencia. La gestión de horarios y excepciones RF-C1 se retiró del alcance operativo. Los historiales y reportes usan la consulta de asistencia de API. La sección 11 distingue evidencia visual, funcionamiento confirmado por el equipo, implementación localizada y criterios adicionales de calidad o seguridad.

Los commits base locales son FaceLit 6efd92c, backend 2ba7398, micro-facial 166e4a7 y DB 422aac6. El frontend conserva un cambio local para consultas académicas en lotes. La base local tiene un commit de compatibilidad adicional respecto de la revisión remota de referencia. El paquete y el manifiesto del despliegue identifican esas diferencias.

## 2.3 Exclusiones y condicionantes

No se incluyen calificaciones, evaluación pedagógica, nómina, pagos o sanciones automáticas. La identificación no sustituye decisiones académicas del personal autorizado. La operación de Raspberry Pi y sincronización facial offline se conserva como requisito RNF-5.7; no se suministró componente para considerarla implementada. Su incorporación a un despliegue debe cumplir DEC-04.

## 2.4 Dependencias y supuestos

- Catálogos institucionales y responsables autorizados mantienen datos académicos correctos.
- Los dispositivos cuentan con cámara y permisos; los servicios tienen conexión protegida y reloj sincronizado.
- Producción provee administración de claves, respaldo y canal de correo/push cuando se habilite.
- La aceptación biométrica utiliza un conjunto de pruebas representativo aprobado; no se asume precisión por la selección de una biblioteca.
- Las reglas de retención, consentimiento, disponibilidad y recuperación se aprueban por los responsables indicados en el registro de decisiones.

# 3 Actores y matriz de permisos

| Actor | Responsabilidad |
|---|---|
| Aprendiz | Consulta sus datos y asistencia, confirma identidad, registra su rostro y solicita re-registro. |
| Instructor | Configura sesiones autorizadas, consulta sus fichas y registra respaldo manual cuando falla reconocimiento. |
| Coordinador | Gestiona información académica y cuentas; decide traslados, solicitudes, anulaciones y parámetros institucionales. |
| Coordinador de Registro | Propuesta del baseline RF-3.3 y RF-3.5, sujeta a DEC-01. La entrega actual usa los tres roles anteriores. |
| Sistema | Valida, persiste, clasifica, audita, notifica y sincroniza. |
| Servicio facial y dispositivo | Capturan/procesan evidencia y devuelven una verificación; no conceden permisos administrativos. |

| Operación | Aprendiz | Instructor | Coordinador | Registro |
|---|---|---|---|---|
| Perfil y preferencias propios | Propio | Propio | Propio | Propio |
| Gestión académica CSV/manual | No | Consulta de alcance | Sí | DEC-01 |
| Gestión de cuentas y roles | No | No | Sí | No por defecto |
| Preparar sesión facial | No | Asignada o suplencia | Operación del instructor | DEC-01 |
| Registro facial | Titular autorizado | No sobre terceros | Resuelve solicitudes | No por defecto |
| Consultar asistencia | Propia | Fichas autorizadas | Ámbito administrativo | DEC-01 |
| Registro manual de respaldo | No | Asignado | Valida | No por defecto |
| Anular asistencia | No | No | Con justificación | No |
| Cambiar umbral institucional | No | Solo delegación de sesión | Sí | No |
| Bandeja de notificaciones | Propia | Propia | Propia | Propia |

Las celdas “DEC-01” corresponden a la propuesta del baseline. La elegibilidad de un instructor transversal requiere validar la asignación o el reemplazo autorizado. Toda consulta valida también el objeto solicitado y su relación con el usuario.

### Operaciones de ambientes del contrato vigente

Coordinador e instructor pueden consultar el catálogo y crear ambientes mediante POST. La edición, desactivación y vinculación o retiro de fichas corresponde a coordinación. La preparación, consulta activa y salida de sesión corresponde al instructor con validación de su alcance. El aprendiz accede a su formación y asistencia mediante las rutas de autoservicio.

La matriz anterior incluye objetivos adicionales del baseline, como respaldo manual, anulación y rol de registro diferenciado. El estado de cada objetivo se registra en la sección 11.

# 4 Reglas de negocio

| Regla | Definición |
|---|---|
| RB-01 | El documento identifica la cuenta y es inmutable en la edición ordinaria; el correo se utiliza para recuperación y comunicación. |
| RB-02 | Cada documento, correo de cuenta, código de programa y código de ficha debe cumplir las reglas de unicidad del dominio. |
| RB-03 | Una ficha pertenece a un programa. El aprendiz operativo tiene una única ficha activa; el historial conserva vínculos previos. |
| RB-04 | Instructor específico puede tener uno o varios programas. Instructor transversal no se restringe a un programa; su operación de sesión mantiene autorización por asignación/reemplazo. |
| RB-05 | Alta administrativa crea solo Coordinador de Registro; altas académicas asignan aprendiz o instructor según la entidad. Coordinador pleno no se concede implícitamente. |
| RB-06 | Toda cuenta nueva obtiene credencial aleatoria protegida; el coordinador no escribe, ve ni exporta la contraseña. |
| RB-07 | Cambios de ficha propuestos por CSV quedan pendientes hasta decisión del coordinador. Traslado confirmado es atómico y conserva la historia. |
| RB-08 | Error de negocio de una fila CSV se informa y excluye. Un fallo técnico antes del commit revierte el conjunto de cambios de esa carga. |
| RB-09 | Solo un rostro por captura; referencia inicial exige dos retos distintos, siete imágenes por reto, calidad y vida. Re-registro necesita autorización temporal de un uso. |
| RB-10 | Se conservan descriptor protegido y metadatos de modelo/versión. Las imágenes de captura no se usan como foto de perfil ni se conservan tras el procesamiento. |
| RB-11 | La sesión tiene ficha, ambiente, dispositivo, instructor programado, responsable real y tiempos. Reemplazo queda identificado y autorizado. |
| RB-12 | Para entrada E, tolerancia T, salida S y cierre A: 0 <= T <= 30; E + T < S < A. Entrada [E,E+T] puntual; (E+T,S) retardo; [S,A) salida. |
| RB-13 | Máximo una entrada y una salida por aprendiz/sesión. Una salida sin entrada no acredita una asistencia puntual. |
| RB-14 | Ausencia solo se evalúa sobre una sesión efectiva para el aprendiz; sesión cancelada o día sin sesión no constituye ausencia. |
| RB-15 | Los hechos son inmutables; anulación y excusa se registran de forma trazable. El respaldo manual queda pendiente de validación. |
| RB-16 | Se mantienen al menos un coordinador activo y el historial de cuentas desactivadas. Logout/desactivación/cambio de rol afectan tokens y canales. |
| RB-17 | Porcentajes se calculan sobre sesiones aplicables. Se distinguen puntualidad, retardo, ausencia, sin clase y sin registro; el denominador se muestra/documenta. |
| RB-18 | Reportes y exportaciones usan eventos reales y el mismo filtro/alcance. No incluyen contraseñas, imágenes ni descriptores. |
| RB-19 | Notificación se asocia a evento/destinatario; lectura no implica aprobación. Reintentos no duplican eventos ni entregas exitosas. |
| RB-20 | Parámetros institucionales se versionan. Cambios retroactivos requieren recálculo autorizado y no borran los hechos originales. |

# 5 Datos, interfaces y arquitectura

## 5.1 Componentes y responsabilidades

| Componente | Responsabilidad | Límite |
|---|---|---|
| FaceLit | Interfaz web/móvil, captura, consultas y preferencias. | No determina identidad autorizada, resultado definitivo ni privilegios. |
| FaceLit Backend | API, permisos, reglas de negocio, sesión, asistencia y auditoría. | No confía en actor/fecha/score libres enviados por cliente. |
| Micro facial | Extracción y comparación, validación de vida/calidad. | Opera con autorización del servidor o identidad/alcance equivalente. |
| FaceLit DB | Esquema, restricciones, transacciones y migraciones. | Una base nueva debe aceptar los mismos contratos que la API. |
| Correo y canal de tiempo real | Entrega y actualización de interfaz. | Un mensaje no sustituye un registro persistente ni una decisión. |

## 5.2 Modelo de datos lógico

| Entidad | Datos y relaciones mínimos |
|---|---|
| Usuario y credencial | UUID, documento, nombre/apellido, correo protegido, hash, estado, contador/bloqueo y marcas de creación/cambio. |
| Rol, permiso y sesión | Asignación vigente, permisos, emisión/expiración, revocación y eventos de autenticación. |
| Programa, ficha y personas | Códigos, nombres, estado, fechas; vínculos de aprendiz/ficha e instructor/programa/ficha con historia. |
| Carga y propuesta CSV | Identidad de carga, actor, resumen por fila, conflicto, valores, propuesta y resolución. |
| Ambiente y asignación | Nombre, capacidad, estado, fichas asociadas, fechas y responsables de cambio. |
| Sesión y dispositivo | Ambiente, ficha, dispositivo, programado/reemplazo, entrada, tolerancia, salida, cierre y versión. |
| Referencia y solicitud facial | Aprendiz, descriptor protegido, modelo/dimensión/versión, estado; solicitud, decisión y autorización de un uso. |
| Asistencia y anotación | Aprendiz, sesión, fecha/hora confiable, ENTRY/EXIT, resultado, estado, score, origen, creador y versión; anulación/excusa separadas. |
| Notificación y entrega | Evento, destinatario, tipo, prioridad, canal, lectura, intento, estado, fechas y deduplicación. |
| Preferencias y auditoría | Idioma, tema, notificaciones; actor, acción, entidad, anterior/nuevo, motivo y resultado sin secretos. |

Los nombres Chip, UserChip y RecordEnvironment del código corresponden a ficha, vínculo aprendiz-ficha y sesión del dominio. El UUID del usuario no es intercambiable con el UUID del aprendiz; toda conversión debe resolver y validar su relación. El esquema actual de referencia facial usa id_apprentice y embedding vector. El flujo vigente transmite imágenes al backend y delega la extracción al microservicio. Las rutas antiguas de vectores del navegador están denegadas en SecurityConfig.

## 5.3 Contratos observados y contratos requeridos

| Familia observada | Rutas principales | Condición de aceptación |
|---|---|---|
| Autenticación | /api/auth/login; request-recovery; verify-token; reset-password; change-password | Documento como acceso; recuperación por titular; revocación y bloqueo persistente. |
| Perfil y usuarios | /api/profile/me; configuration; /api/admin/users | Perfil propio; edición administrativa; documento inmutable y rol de registro diferenciado. |
| Académico | /api/academic/programs; chips; csv/template; csv/upload; pending-transfers | Integridad, alcance, transacciones y respuestas sin contraseñas. |
| Sesión | /api/environment/environments; instructors-for-session; chips-for-instructor; sessions | Elegibilidad y tiempos validados en servidor, no solo en selector. |
| Asistencia | /api/facial/events; from-image; attendance-status; attendance-matrix; excuse | Proteger operación/objeto; ruta automática exige verificación; respaldo manual separado. |
| Registro facial | /api/facial/embeddings/from-image; embeddings/liveness-check; registration-status; registration-confirmation | Titular autenticado, retos vigentes y autorización de reemplazo cuando corresponde. |
| Micro facial | /api/v1/facial-embeddings/from-image; verify-session; users/{id} | Identidad/alcance por operación; no exponer API key administrativa al cliente. |
| Notificaciones | /api/notifications; read; read-all; facial-request | Decisión facial durable; lectura independiente de autorización. |
| Tiempo real | /ws/realtime | Autenticación y revocación; cambios limitados al destinatario. |

Las rutas anteriores describen el inventario actual, no congelan un diseño incompatible. Logout/revocación y solicitud de re-registro tienen implementación actual. Parámetros institucionales versionados, respaldo manual y anulaciones se evalúan como criterios adicionales del baseline. RF-C1 conserva el historial de alcance de horarios. Sus nombres finales se documentarán en el contrato API junto con versión, payload, respuestas y permisos. No se presentarán rutas propuestas como rutas ya desplegadas.

## 5.4 Errores y consistencia

- 400: entrada inválida; 401: autenticación ausente, vencida o inválida; 403: operación/recurso no autorizado.
- 404: recurso inexistente sin filtrar datos ajenos; 409: duplicado o conflicto concurrente; 410: reto/autorización consumidos o vencidos.
- Errores del servicio facial o correo no se convierten en reconocimiento aprobado ni en entrega exitosa.
- Respuestas deben incluir mensaje útil y referencia de operación, sin stack trace, claves, secretos, imágenes o vectores.
- Persistencia e idempotencia se validan antes de comunicar éxito; un reintento no duplica asistencia.

## 5.5 Formato institucional CSV

El encabezado establecido es: tipo,documento,nombre,apellido,correo,programa_codigo,ficha_codigo,instructor_tipo. El formato es UTF-8 con separador coma; se respetan comillas de campos CSV y se dejan vacías las columnas que no aplican. Se admite archivo parcial y se resuelven las dependencias independientemente del orden de filas.

| Tipo | Campos obligatorios | Regla adicional |
|---|---|---|
| programa | tipo, programa_codigo, nombre | Código identifica programa y nombre describe la formación. |
| ficha | tipo, ficha_codigo, programa_codigo | Programa existente o creado en la misma carga. |
| aprendiz | tipo, documento, nombre, apellido, correo, ficha_codigo | Ficha válida; cambio de ficha genera propuesta. |
| instructor específico | tipo, documento, nombre, apellido, correo, instructor_tipo, programa_codigo | Repetir documento para asociar más programas; ficha_codigo puede indicar asignación válida si el contrato la admite. |
| instructor transversal | tipo, documento, nombre, apellido, correo, instructor_tipo | Sin restricción a programa; código de programa innecesario se informa como advertencia. |

Ejemplo ilustrativo con datos ficticios. Los contactos de ejemplo no representan personas del proyecto.

```csv
tipo,documento,nombre,apellido,correo,programa_codigo,ficha_codigo,instructor_tipo
programa,,Análisis y Desarrollo de Software,,,ADSO,,
ficha,,,,,ADSO,2825551,
aprendiz,1002345678,Juan,Pérez,juan@example.com,,2825551,
instructor,1029384756,Laura,Gómez,laura@example.com,ADSO,,especifico
instructor,1050607080,Carlos,Ruiz,carlos@example.com,,,transversal
```

Documentos se validan como secuencias numéricas de 6 a 15 dígitos según el contrato actual y no se almacenan como números que pierdan ceros iniciales. Códigos y longitudes adicionales deben coincidir en plantilla, DTO, interfaz y restricciones de base. El correo es obligatorio para aprendiz/instructor y no habilita autenticación por email.

| Categoría del resumen | Información |
|---|---|
| Creados | Fila, tipo, identidad/código y resultado. |
| Actualizados | Fila, tipo, identidad/código y campos aplicados. |
| Inconsistencias bloqueadas | Fila, entidad, valor actual/propuesto y acción Ir a corregir. |
| Errores de referencia | Fila, dato faltante o inválido y explicación. |
| Traslados pendientes | Solicitud persistente ligada a carga/fila, origen/destino y estado. |

El resumen nunca incluirá contraseñas legibles. La resolución del conflicto se registra como operación propia vinculada a la carga original.

# 6 Requisitos funcionales

Las fichas siguientes definen el comportamiento requerido. El estado observado se registra para trazabilidad, sin sustituir los criterios de aceptación. Prioridad Alta indica dependencia de la integridad, acceso o flujo principal; Media indica función de apoyo que mantiene sus obligaciones de seguridad.

*6 Requisitos funcionales › Accesos al sistema*

## RF-1.1 Inicio de sesión

**Identificador** RF-1.1 | Prioridad Alta

**Actores** Aprendiz, Instructor, Coordinador y Coordinador de Registro

**Requisito** El sistema deberá autenticar mediante número de documento y contraseña, verificar el estado de la cuenta y emitir una sesión con el rol vigente. El correo se reservará para recuperación y comunicaciones.

**Precondiciones** Cuenta existente, activa, con credencial y rol asignados. Aviso de privacidad disponible.

**Entradas** Documento, contraseña y aceptación del aviso cuando corresponda.

**Secuencia normal**

1. El usuario ingresa documento y contraseña.
2. El servidor verifica credencial, estado y bloqueo; valida la aceptación requerida.
3. Obtiene rol y permisos desde su fuente autorizada y registra el acceso.
4. Emite el token y la interfaz abre la pantalla correspondiente.

**Escenarios alternativos**

- Credenciales incorrectas: responder sin revelar existencia de la cuenta y persistir el intento fallido.
- Cuenta inactiva, bloqueo, falta de rol o servicio no disponible: denegar acceso y ofrecer una acción recuperable.

**Postcondiciones** Sesión asociada a la identidad real, con emisión, expiración y evidencia de acceso.

**Criterios de aceptación**

- El documento identifica la cuenta; el correo no permite iniciar sesión.
- Un error no emite token ni privilegios; los intentos fallidos persisten aunque el acceso sea rechazado.
- El rol no se elige ni modifica desde el cliente.

**Relaciones** RF-1.2, RF-1.3, RF-1.4; RNF-1.1 a RNF-1.5, RNF-1.10 a RNF-1.16

**Estado observado** Operativo confirmado. El equipo confirma login en facelit.tech. LoginServiceImpl resuelve documento y también correo. El acceso exclusivamente por documento permanece como criterio por alinear con RNF-1.10. Fuente SRC-01.

**Prueba vinculada** CP-RF-1.1 según sección 8

## RF-1.2 Derechos de acceso

**Identificador** RF-1.2 | Prioridad Alta

**Actores** Todos los roles y Sistema

**Requisito** El sistema deberá autorizar cada operación y cada recurso conforme a rol, permiso y relación con la información, tanto en interfaz como en servidor.

**Precondiciones** Sesión válida y matriz de permisos vigente.

**Entradas** Operación, recurso solicitado e identidad autenticada.

**Secuencia normal**

1. El usuario solicita una función o recurso.
2. El servidor verifica sesión, rol y permiso de operación.
3. Comprueba propiedad o relación vigente con aprendiz, ficha y sesión.
4. Devuelve solo los datos autorizados o ejecuta la operación y registra su resultado.

**Escenarios alternativos**

- Sin sesión: responder 401.
- Sesión válida sin permiso o recurso fuera de alcance: responder 403 y no efectuar cambios.

**Postcondiciones** Acceso limitado al ámbito autorizado, sin exposición de datos ajenos.

**Criterios de aceptación**

- Cambiar un UUID o una ruta no permite consultar otra ficha o usuario.
- La denegación funciona en solicitudes directas y no depende de ocultar botones.
- El aprendiz consulta solo su información; el instructor solo sus fichas o reemplazos autorizados.

**Relaciones** RNF-1.4, RNF-1.5, RNF-1.6, RNF-1.15, RNF-1.16, RNF-7.1

**Estado observado** Integrado en código. SecurityConfig y los servicios aplican permisos por rol y alcance. La revisión completa de solicitudes con identificadores ajenos requiere CP-RF-1.2. Fuente SRC-01.

**Prueba vinculada** CP-RF-1.2 según sección 8

## RF-1.3 Definición de rol al iniciar sesión

**Identificador** RF-1.3 | Prioridad Alta

**Actores** Sistema y usuarios autenticados

**Requisito** El sistema deberá determinar el rol y los permisos desde los registros de autorización y dirigir al usuario al área correspondiente.

**Precondiciones** Autenticación satisfactoria y asignación vigente.

**Entradas** Identidad validada y asignación de rol.

**Secuencia normal**

1. Consulta la asignación vigente.
2. Construye la sesión con permisos mínimos.
3. La interfaz carga el menú y las rutas habilitadas.
4. Un cambio posterior invalida o actualiza las sesiones anteriores.

**Escenarios alternativos**

- Rol inexistente o ambiguo: no habilitar operaciones hasta su regularización.
- Acceso a área de otro rol: denegar y regresar al área propia.

**Postcondiciones** Rol coherente en token, interfaz y servidor.

**Criterios de aceptación**

- El cliente no puede atribuirse un rol diferente.
- Los permisos anteriores no permanecen activos después de un cambio de rol.
- Coordinador de Registro tiene una asignación independiente y no hereda administración por su nombre.

**Relaciones** RF-3.3, RF-3.5; RNF-1.4, RNF-1.11, RNF-1.16

**Estado observado** Integrado en código. RoleName contiene APPRENTICE, INSTRUCTOR y COORDINATOR. Los layouts redirigen por rol. El perfil de registro diferenciado es una propuesta del baseline. Fuente SRC-01.

**Prueba vinculada** CP-RF-1.3 según sección 8

## RF-1.4 Restablecimiento de contraseña

**Identificador** RF-1.4 | Prioridad Alta

**Actores** Usuario y Sistema

**Requisito** El sistema deberá permitir recuperar una contraseña mediante verificación enviada al correo registrado y un código temporal asociado a la solicitud y al titular.

**Precondiciones** Cuenta habilitada y correo de recuperación registrado.

**Entradas** Correo, código de seis dígitos, nueva contraseña y confirmación.

**Secuencia normal**

1. El usuario solicita la recuperación con el correo registrado.
2. Se genera un código de seis dígitos con vencimiento de cinco minutos, se vincula a la solicitud y se envía al titular.
3. El usuario verifica el código y define una nueva contraseña conforme a la política.
4. El servidor actualiza el hash, consume el código, revoca sesiones anteriores y confirma.

**Escenarios alternativos**

- Código vencido, usado o incorrecto: rechazar y permitir solicitar otro sin reutilizar el anterior.
- Contraseña inválida, confirmación diferente o límite de intentos superado: conservar la credencial y aplicar la limitación.

**Postcondiciones** Nueva credencial segura; código y sesiones previas inutilizables.

**Criterios de aceptación**

- El código no puede usarse para otra cuenta ni para dos restablecimientos.
- Reenviar invalida el código anterior.
- La contraseña cumple RNF-1.2 y no aparece en respuestas o registros.

**Relaciones** RNF-1.2, RNF-1.8, RNF-1.9, RNF-1.10, RNF-1.11

**Estado observado** Operativo confirmado. El equipo confirma recuperación y correo. Las rutas request-recovery, verify-token y reset-password están conectadas. Los ensayos de abuso y concurrencia se registran por separado. Fuente SRC-01.

**Prueba vinculada** CP-RF-1.4 según sección 8

*6 Requisitos funcionales › Gestión académica*

## RF-2.1 Carga institucional por archivo CSV

**Identificador** RF-2.1 | Prioridad Alta

**Actores** Coordinador y Sistema

**Requisito** El sistema deberá crear o actualizar programas, fichas, aprendices e instructores desde un CSV UTF-8, sin sobrescribir relaciones en conflicto ni exponer credenciales.

**Precondiciones** Coordinador autorizado; archivo .csv con encabezado válido.

**Entradas** Archivo y sus filas programa, ficha, aprendiz o instructor.

**Secuencia normal**

1. Valida archivo, codificación, encabezados y tipos.
2. Resuelve primero programas y fichas, después personas y relaciones, aunque el archivo use otro orden.
3. Crea o actualiza filas válidas; separa conflictos y referencias inexistentes.
4. Registra la carga y presenta resumen de creados, actualizados, inconsistencias y errores, con acceso al registro en conflicto.

**Escenarios alternativos**

- Archivo ilegible o encabezado inválido: rechazar sin cambios.
- Error de una fila: excluirla del conjunto aplicable; un fallo técnico antes del commit revierte todos los cambios de la carga.

**Postcondiciones** Cambios válidos confirmados juntos; resultados por fila y propuestas de traslado trazables.

**Criterios de aceptación**

- CSV parcial solo afecta las entidades indicadas.
- Un instructor específico puede acumular programas por documento; uno transversal no queda restringido a un programa.
- Una ficha diferente para un aprendiz genera propuesta, nunca traslado automático.
- Las cuentas nuevas reciben credencial segura; el resumen y sus exportaciones no contienen contraseñas.

**Relaciones** RF-2.1.1, RF-2.2, RF-2.3, RF-3.4; RNF-2.1 a RNF-2.14, RNF-3.3

**Estado observado** Operativo confirmado. El equipo confirma carga CSV y gestión académica. COO-03 muestra programas cargados y COO-07 alertas de referencias inválidas. La captura del formulario no aporta por sí sola un resumen de importación exitosa. Fuente SRC-02.

**Prueba vinculada** CP-RF-2.1 según sección 8

## RF-2.1.1 Guía y plantilla del archivo CSV

**Identificador** RF-2.1.1 | Prioridad Media

**Actores** Coordinador

**Requisito** El sistema deberá mostrar ayuda de columnas y ofrecer una plantilla UTF-8 correcta antes de seleccionar el archivo.

**Precondiciones** Acceso autorizado a carga institucional.

**Entradas** Solicitud de ayuda o descarga.

**Secuencia normal**

1. Muestra significado, obligatoriedad y ejemplo de cada columna.
2. Entrega una plantilla con programa, ficha, aprendiz e instructores específico y transversal.
3. Explica encabezado, campos vacíos y posibilidad de carga parcial.
4. El usuario completa el archivo y continúa con RF-2.1.

**Escenarios alternativos**

- Fallo de descarga: informar y permitir reintento.
- Columnas no reconocidas o tipos inválidos: explicar corrección con lenguaje de la guía.

**Postcondiciones** Plantilla válida y reglas visibles; no cambia información académica.

**Criterios de aceptación**

- La ayuda aparece antes de cargar, no solo después de un error.
- Los ejemplos incluyen nombre de programa y referencias consistentes.
- Mensajes comprensibles sin términos internos de base de datos.

**Relaciones** RF-2.1; RNF-2.5, RNF-2.7, RNF-2.14

**Estado observado** Evidencia visual. COO-04 muestra selección de CSV, guía de columnas y límites de 20 MB y 5.000 filas. El controlador ofrece la descarga de plantilla. Fuente SRC-02.

**Prueba vinculada** CP-RF-2.1.1 según sección 8

## RF-2.2 Gestión académica manual

**Identificador** RF-2.2 | Prioridad Alta

**Actores** Coordinador

**Requisito** El sistema deberá crear, consultar, editar, desactivar, reactivar y eliminar entidades académicas según relaciones y preservación del historial.

**Precondiciones** Rol autorizado, catálogos disponibles y entidad identificada.

**Entradas** Datos de programa, ficha, aprendiz, instructor y relaciones.

**Secuencia normal**

1. El coordinador selecciona entidad y acción.
2. El sistema muestra datos y campos permitidos.
3. Valida unicidad, formato, estado y dependencias.
4. Confirma la operación, persiste atómicamente y registra actor y cambios.

**Escenarios alternativos**

- Duplicado o relación inválida: rechazar sin registros parciales.
- Eliminación con historial o dependencias: bloquear y ofrecer desactivación.

**Postcondiciones** Entidad coherente y cambio trazable; historial conservado.

**Criterios de aceptación**

- Toda ficha tiene programa y toda vinculación activa de aprendiz una ficha válida.
- Instructor específico tiene al menos un programa; transversal mantiene su alcance definido.
- Documento no editable; no se permite escribir una contraseña inicial.
- Reactivar vuelve a validar relaciones; eliminación física solo sin dependencias ni historial protegido.

**Relaciones** RF-2.3, RF-3.4; RNF-2.1 a RNF-2.4, RNF-2.8, RNF-2.9, RNF-3.4

**Estado observado** Integrado en código. Programas, fichas, instructores y aprendices usan servicios persistentes. COO-03 muestra consulta. Se conserva el criterio de identidad inmutable frente a la edición administrativa actualmente disponible. Fuente SRC-02.

**Prueba vinculada** CP-RF-2.2 según sección 8

## RF-2.3 Traslado de ficha de un aprendiz

**Identificador** RF-2.3 | Prioridad Alta

**Actores** Coordinador

**Requisito** El sistema deberá trasladar a un aprendiz entre fichas activas del mismo programa mediante una decisión explícita y una transacción indivisible.

**Precondiciones** Aprendiz con una ficha activa; destino activo y diferente, del mismo programa.

**Entradas** Aprendiz, destino y motivo de traslado.

**Secuencia normal**

1. Consulta ficha actual y destinos permitidos.
2. El coordinador selecciona destino y confirma motivo.
3. Desactiva origen y activa destino en una única transacción.
4. Registra valores anteriores y nuevos, comunica resultado y conserva historia.

**Escenarios alternativos**

- Destino inválido, misma ficha o programa diferente: rechazar.
- Fallo o traslado concurrente: revertir o resolver conflicto sin duplicar asignaciones activas.

**Postcondiciones** Una única ficha activa y traslado con actor, fecha y motivo.

**Criterios de aceptación**

- No queda sin ficha ni con dos activas al confirmar.
- Fallo durante el cambio restaura el origen.
- Propuestas CSV usan la misma operación al aceptarse y registran aceptación o cancelación.

**Relaciones** RF-2.1; RNF-2.3, RNF-2.9, RNF-2.10, RNF-2.11

**Estado observado** Integrado en código. UserChipServiceImpl y pending-transfers implementan traslado y resolución. La atomicidad bajo fallo y concurrencia se evalúa con CP-RF-2.3. Fuente SRC-02.

**Prueba vinculada** CP-RF-2.3 según sección 8

*6 Requisitos funcionales › Gestión de usuarios*

## RF-3.1 Panel de usuarios registrados

**Identificador** RF-3.1 | Prioridad Alta

**Actores** Coordinador

**Requisito** El sistema deberá ofrecer un listado filtrable de usuarios con identidad, rol y estado, limitado a los permisos del solicitante.

**Precondiciones** Sesión de coordinador válida.

**Entradas** Filtros por documento, nombre, apellido, correo, rol o estado.

**Secuencia normal**

1. Consulta el listado paginado.
2. Presenta documento, nombre, apellido, correo enmascarado, rol y estado.
3. Aplica filtros y muestra total coherente.
4. Permite abrir detalle o exportar exactamente el conjunto autorizado.

**Escenarios alternativos**

- Sin coincidencias: lista vacía y mensaje.
- API no disponible: error recuperable sin sustituir datos reales por datos de demostración.

**Postcondiciones** Listado autorizado sin cambios sobre cuentas.

**Criterios de aceptación**

- Cada columna corresponde a la cuenta real.
- Otro rol no obtiene la colección mediante la API.
- Filtros, detalle y exportación conservan el mismo alcance.

**Relaciones** RF-3.2; RNF-3.1, RNF-3.7

**Estado observado** Evidencia visual. COO-02 muestra 3.640 usuarios, buscador y filtros por rol y estado. El volumen visible corresponde al momento de la captura. Fuente SRC-03.

**Prueba vinculada** CP-RF-3.1 según sección 8

## RF-3.2 Consulta y gestión de usuarios

**Identificador** RF-3.2 | Prioridad Alta

**Actores** Coordinador

**Requisito** El sistema deberá buscar y gestionar cuentas mediante sus datos permitidos, preservando identidad y relaciones históricas.

**Precondiciones** Cuenta existente y autorización administrativa.

**Entradas** Criterio de búsqueda, cuenta y cambios permitidos.

**Secuencia normal**

1. Busca por nombre, apellido, documento o correo.
2. Abre detalle con estado y relaciones.
3. Edita campos permitidos o ejecuta un cambio de estado.
4. Valida, confirma y registra cada modificación.

**Escenarios alternativos**

- Cuenta inexistente, correo duplicado o intento de cambiar documento: rechazar.
- Eliminación con relaciones o afectación del último coordinador: bloquear.

**Postcondiciones** Información actualizada con auditoría, sin pérdida del historial.

**Criterios de aceptación**

- Documento permanece inmutable.
- Aprendiz e instructor no editan datos personales mediante solicitudes directas.
- Cambio de estado o rol afecta inmediatamente la autorización de sesiones.

**Relaciones** RF-3.5, RF-3.6; RNF-1.7, RNF-3.4, RNF-3.5, RNF-3.6

**Estado observado** Integrado en código. UserManagementServiceImpl consulta y modifica cuentas. El servicio admite actualizar el documento, por lo que el criterio de inmutabilidad requiere una decisión de producto. Fuente SRC-03.

**Prueba vinculada** CP-RF-3.2 según sección 8

## RF-3.3 Creación de usuarios de registro

**Identificador** RF-3.3 | Prioridad Alta

**Actores** Coordinador

**Requisito** El sistema deberá permitir al coordinador crear cuentas de Coordinador de Registro con datos mínimos y sin selector de otro rol. La identidad de ese rol debe implementarse por separado de COORDINATOR.

**Precondiciones** Coordinador autorizado y perfil de permisos del rol de registro establecido.

**Entradas** Documento, nombres, apellidos y correo del titular.

**Secuencia normal**

1. El coordinador abre el alta y diligencia identidad y contacto.
2. Valida formato y unicidad de documento y correo.
3. Crea cuenta y asigna automáticamente Coordinador de Registro.
4. Genera credencial segura y comunica al coordinador solo el resultado del alta.

**Escenarios alternativos**

- Duplicado o datos inválidos: no crear cuenta.
- Perfil de rol no disponible o fallo de credencial: no habilitar una cuenta incompleta.

**Postcondiciones** Cuenta con rol restringido y mecanismo seguro de primer acceso.

**Criterios de aceptación**

- La operación no permite crear aprendiz, instructor o coordinador pleno.
- Rol enviado manualmente distinto al permitido es rechazado.
- Contraseña no visible ni exportable por el coordinador.

**Relaciones** RF-3.4, RF-3.5; RNF-3.2, RNF-3.3

**Estado observado** Objetivo adicional. El alta administrativa actual permite COORDINATOR. El Coordinador de Registro diferenciado del baseline requiere DEC-01 y una implementación propia. Fuente SRC-03.

**Prueba vinculada** CP-RF-3.3 según sección 8

## RF-3.4 Credencial inicial generada por el sistema

**Identificador** RF-3.4 | Prioridad Alta

**Actores** Sistema y titular de la cuenta

**Requisito** El sistema deberá generar una credencial inicial aleatoria que cumpla la política, almacenar solo su hash y entregarla o habilitarla únicamente mediante un canal seguro al titular.

**Precondiciones** Alta autorizada y contacto validado.

**Entradas** Cuenta nueva e información de entrega segura.

**Secuencia normal**

1. Genera un secreto aleatorio independiente del documento.
2. Guarda su hash y estado de primer acceso.
3. Habilita un mecanismo de activación o entrega protegida al titular.
4. Informa estado de entrega sin revelar el secreto en panel, resumen o CSV.

**Escenarios alternativos**

- Fallo de entrega: conserva estado pendiente y permite reintento autorizado.
- Fallo de creación: revierte el alta y evita credenciales huérfanas.

**Postcondiciones** Credencial asociada al titular sin exposición administrativa.

**Criterios de aceptación**

- Ningún endpoint, Excel, CSV o log devuelve la contraseña legible.
- Secreto cumple 8 a 15 caracteres, letras, número y símbolo.
- Preferir activación mediante enlace de un uso para evitar contraseñas en correo ordinario; mecanismo final registrado en DEC-02.

**Relaciones** RF-1.4; RNF-1.2, RNF-3.3, RNF-8.3

**Estado observado** Integrado con criterio adicional. InitialCredentialServiceImpl genera y cifra la credencial y entrega el acceso tras commit. Persisten campos legacy de contraseña en DTO académicos. Su presencia exige comprobar las respuestas efectivas antes de declarar cumplida la prohibición de exposición. Fuente SRC-03.

**Prueba vinculada** CP-RF-3.4 según sección 8

## RF-3.5 Restricción de roles asignables

**Identificador** RF-3.5 | Prioridad Alta

**Actores** Coordinador y Sistema

**Requisito** El sistema deberá aplicar un conjunto explícito de roles asignables por operación. El alta administrativa RF-3.3 solo asignará Coordinador de Registro; las altas académicas asignarán Aprendiz o Instructor según entidad.

**Precondiciones** Actor y operación autorizados; rol destino vigente.

**Entradas** Cuenta, operación y rol previsto.

**Secuencia normal**

1. Identifica quién solicita la asignación.
2. Comprueba el rol permitido para ese flujo.
3. Valida relaciones necesarias y ausencia de privilegios incompatibles.
4. Registra asignación e invalida permisos previos de sesiones afectadas.

**Escenarios alternativos**

- Rol no permitido o intento de escalación: rechazar 403.
- Cambio que deje sin coordinador activo: bloquear.

**Postcondiciones** Asignación única y auditable, coherente con el tipo de cuenta.

**Criterios de aceptación**

- Alterar el cuerpo de una solicitud no amplía el rol.
- El rol de registro no recibe permisos de administración por defecto.
- Una modificación legítima no deja vigentes permisos anteriores.

**Relaciones** RF-1.3, RF-2.2, RF-3.3; RNF-1.16, RNF-3.6

**Estado observado** Objetivo adicional. Los roles asignables se validan en servidor. El perfil separado de registro no está en RoleName y se conserva como decisión de alcance. Fuente SRC-03.

**Prueba vinculada** CP-RF-3.5 según sección 8

## RF-3.6 Estado del usuario

**Identificador** RF-3.6 | Prioridad Alta

**Actores** Coordinador

**Requisito** El sistema deberá activar, desactivar o bloquear cuentas preservando historial y relaciones. La eliminación física se admitirá solo cuando no afecte información protegida.

**Precondiciones** Cuenta existente; actor autorizado; al menos un coordinador activo al terminar.

**Entradas** Cuenta, nuevo estado, motivo y confirmación.

**Secuencia normal**

1. Consulta estado y dependencias.
2. El coordinador elige acción y motivo.
3. Valida transición y conservación del último coordinador.
4. Guarda estado, revoca sesiones cuando aplique y notifica sin borrar historia.

**Escenarios alternativos**

- Transición inválida o último coordinador: rechazar.
- Cancelación del usuario: conservar estado previo.

**Postcondiciones** Cuenta con estado coherente; historia disponible para reportes.

**Criterios de aceptación**

- Cuenta desactivada pierde acceso en menos de cinco segundos.
- Token previo no permite seguir operando.
- Registros históricos no se eliminan por desactivación.

**Relaciones** RNF-1.11, RNF-3.5, RNF-3.6

**Estado observado** Integrado en código. El estado de cuenta se conserva y SessionSecurityService comprueba cuenta, credencial, rol y sesión persistida al validar el token. Fuente SRC-01.

**Prueba vinculada** CP-RF-3.6 según sección 8

*6 Requisitos funcionales › Perfil y preferencias*

## RF-4.1 Consulta del perfil propio

**Identificador** RF-4.1 | Prioridad Media

**Actores** Todos los usuarios

**Requisito** El sistema deberá presentar el perfil del usuario autenticado con identidad, rol, vínculos académicos pertinentes y correo enmascarado.

**Precondiciones** Sesión válida.

**Entradas** Identidad tomada de la sesión; no de un UUID libre del cliente.

**Secuencia normal**

1. El usuario abre Mi perfil.
2. El servidor consulta solo su perfil.
3. La interfaz muestra datos actuales y relaciones relevantes al rol.
4. Ofrece preferencias y recuperación o cambio seguro de contraseña.

**Escenarios alternativos**

- Sesión vencida: cerrar acceso y volver al login.
- Fallo de consulta: informar y permitir reintento sin revelar otro perfil.

**Postcondiciones** Perfil propio consultado, sin modificación de datos personales.

**Criterios de aceptación**

- Cambiar parámetros no muestra un perfil ajeno.
- Correo se muestra enmascarado.
- Aprendiz e instructor ven identidad en solo lectura.

**Relaciones** RF-4.2; RNF-4.1, RNF-4.2, RNF-4.5

**Estado observado** Evidencia visual. COO-08 y APR-07 muestran perfil por titular. El perfil presenta el correo completo en el código revisado. El enmascaramiento del baseline es un criterio de privacidad por alinear. Fuente SRC-04.

**Prueba vinculada** CP-RF-4.1 según sección 8

## RF-4.2 Configuración de preferencias personales

**Identificador** RF-4.2 | Prioridad Media

**Actores** Todos los usuarios

**Requisito** El sistema deberá guardar idioma, tema y activación de notificaciones por usuario y restaurarlos en nuevas sesiones y dispositivos.

**Precondiciones** Perfil autenticado con contrato de preferencias vigente.

**Entradas** Idioma ES, EN, DE o FR; tema claro u oscuro; notificaciones activas o inactivas.

**Secuencia normal**

1. Carga preferencias actuales o valores por defecto.
2. El usuario modifica las opciones.
3. Valida catálogo y guarda en servidor.
4. Aplica y confirma; en otro inicio restaura los valores guardados.

**Escenarios alternativos**

- Idioma no soportado: rechazar sin sustituir silenciosamente.
- Fallo de guardado: mostrar estado sin guardar y permitir reintento.

**Postcondiciones** Preferencias del titular persistidas sin afectar las de otros usuarios.

**Criterios de aceptación**

- Los cuatro idiomas tienen el mismo catálogo en cliente, API y base.
- Desactivar notificaciones se conserva y no se fuerza a true.
- Seguridad y recuperación siguen sus canales obligatorios según política, aun con preferencias informativas desactivadas.

**Relaciones** RF-C3; RNF-4.1, RNF-4.5

**Estado observado** Integrado en código. useUserSettings y el backend persisten preferencias. El cliente mapea ES, EN, DE y FR. Language incluye esos valores y PR como compatibilidad. Fuente SRC-04.

**Prueba vinculada** CP-RF-4.2 según sección 8

*6 Requisitos funcionales › Reconocimiento facial*

## RF-5.1 Registro facial inicial del aprendiz

**Identificador** RF-5.1 | Prioridad Alta

**Actores** Aprendiz, Sistema y servicio facial

**Requisito** El sistema deberá registrar la referencia biométrica del aprendiz autenticado con consentimiento, validación de vida y dos retos distintos del catálogo activo con siete imágenes por reto.

**Precondiciones** Cuenta de aprendiz activa, identidad confirmada, cámara autorizada y ausencia de referencia activa o autorización RF-5.4.

**Entradas** Capturas temporales, reto del servidor, evidencia de calidad/vida e identidad autenticada.

**Secuencia normal**

1. Confirma identidad y presenta finalidad/consentimiento.
2. Servidor inicia un reto temporal asociado al titular.
3. Guía dos retos distintos del catálogo activo y reúne siete imágenes por reto. Verifica un rostro, calidad, variación y vida.
4. Consolida el descriptor con modelo y versión compatibles, lo protege y persiste para el aprendiz; descarta imágenes.

**Escenarios alternativos**

- Rostro múltiple, evidencia insuficiente, reto vencido/reutilizado o mala calidad: rechazar sin registro parcial.
- Servicio no disponible o autorización ausente: permitir reintento seguro, sin aprobación local simulada.

**Postcondiciones** Referencia biométrica activa única, vinculada al aprendiz y trazable.

**Criterios de aceptación**

- La secuencia contiene dos retos distintos del catálogo MOVE_UP, MOVE_DOWN, MOVE_CLOSER y MOVE_AWAY, con siete imágenes por reto.
- La validación y la confirmación deben completarse antes de informar el registro exitoso. La meta temporal se mide por separado.
- El usuario no puede registrar el rostro de otro UUID.
- Modelo, dimensiones y contrato coinciden en cliente, servidor y DB; no se guarda foto original.

**Relaciones** RF-5.4; RNF-5.1 a RNF-5.6

**Estado observado** Operativo confirmado. El equipo confirma cámara y registro facial. APR-04 a APR-06 muestran preparación, validación y aviso de finalización en capturas separadas. El flujo vigente usa dos retos distintos y siete imágenes por reto. Fuente SRC-05.

**Prueba vinculada** CP-RF-5.1 según sección 8

## RF-5.2 Preparación de sesión de reconocimiento

**Identificador** RF-5.2 | Prioridad Alta

**Actores** Instructor; Coordinador según permiso explícito

**Requisito** El sistema deberá preparar una sesión facial con ambiente, ficha, dispositivo e instructor válidos, conservando original y reemplazo cuando corresponda.

**Precondiciones** Ficha y ambiente activos, instructor asignado o reemplazo autorizado y tiempos de sesión válidos.

**Entradas** Ambiente, ficha, instructor programado, responsable y dispositivo.

**Secuencia normal**

1. Consulta opciones elegibles desde el servidor.
2. El instructor confirma datos y eventual reemplazo.
3. Verifica relaciones, tiempos de sesión y disponibilidad del dispositivo.
4. Guarda sesión y presenta resumen para definir tiempos en RF-6.2.

**Escenarios alternativos**

- Relación fuera de alcance, tiempos incompatibles o datos faltantes requieren rechazo.
- Sesión duplicada o dispositivo ocupado: devolver conflicto sin duplicación.

**Postcondiciones** Sesión configurada con autor y responsables diferenciados.

**Criterios de aceptación**

- Campos obligatorios completos.
- Una llamada directa no permite elegir ficha no elegible.
- Reemplazo conserva instructor programado, responsable real, autorización y fecha.

**Relaciones** RF-6.1, RF-6.2, RF-C1, RF-C2; RNF-1.5, RNF-6.1

**Estado observado** Integrado en código. environmentSessionApi y EnvironmentServiceImpl preparan ficha, ambiente, dispositivo, responsables y tiempos de una sesión autorizada. Fuente SRC-06.

**Prueba vinculada** CP-RF-5.2 según sección 8

## RF-5.3 Administración de parámetros faciales

**Identificador** RF-5.3 | Prioridad Alta

**Actores** Coordinador; Instructor para ajustes expresamente delegados

**Requisito** El sistema deberá administrar parámetros globales y de sesión, con versión, alcance y fecha de aplicación, sin alterar silenciosamente eventos históricos.

**Precondiciones** Permiso específico; catálogo de rangos y versión vigente.

**Entradas** Umbral facial, tolerancia y demás parámetros autorizados.

**Secuencia normal**

1. Consulta valor vigente, versión y alcance.
2. El actor cambia parámetros permitidos e indica motivo.
3. Servidor valida rangos y genera nueva versión.
4. Aplica a las identificaciones posteriores y conserva versión de cada evento.

**Escenarios alternativos**

- Valor fuera de rango o cambio global no autorizado: rechazar.
- Cambio retroactivo: requerir recálculo explícito y auditado, sin sobrescribir hechos originales.

**Postcondiciones** Configuración versionada y uso verificable por fecha de evento.

**Criterios de aceptación**

- Umbral por defecto 0.6 y rango inclusivo 0.4 a 0.9.
- Tolerancia entre 0 y 30 minutos, compatible con la sesión.
- Cambio se aplica sin reinicio y deja actor, anterior/nuevo, motivo y vigencia.

**Relaciones** RF-6.2; RNF-5.5, RNF-6.2, RNF-6.4

**Estado observado** Integrado con criterio adicional. La configuración del servicio facial usa similitud 0.65 y rango técnico 0..1. La administración institucional versionada y su panel siguen como objetivo de aceptación específico. Fuente SRC-05.

**Prueba vinculada** CP-RF-5.3 según sección 8

## RF-5.4 Resolución de solicitud de registro facial

**Identificador** RF-5.4 | Prioridad Alta

**Actores** Aprendiz solicitante y Coordinador resolutor

**Requisito** El sistema deberá permitir un nuevo registro facial mediante solicitud persistente y autorización temporal de un único uso, concedida por un coordinador autorizado.

**Precondiciones** Referencia facial previa y solicitud del propio aprendiz.

**Entradas** Solicitud, decisión, motivo y plazo de autorización.

**Secuencia normal**

1. El aprendiz crea solicitud; el servidor evita duplicados y notifica.
2. El coordinador consulta solicitudes de su alcance.
3. Acepta o rechaza; servidor persiste decisión, actor y fecha.
4. Si acepta, habilita el reto de re-registro y consume autorización solo al completarlo.

**Escenarios alternativos**

- Solicitud ya resuelta o actor no autorizado: rechazar.
- Fallo de notificación: conservar decisión y estado de entrega; no perder autorización.

**Postcondiciones** Decisión trazable y referencia anterior preservada hasta completar reemplazo válido.

**Criterios de aceptación**

- No se habilita cámara de re-registro antes de aceptación.
- Dos resoluciones o registros concurrentes no consumen la autorización dos veces.
- Rechazo permite solicitar otra vez salvo política explícita; vencimiento no modifica la referencia activa.

**Relaciones** RF-5.1, RF-8.4; RNF-1.8, RNF-5.4

**Estado observado** Integrado en código. FaceResetRequest y su repositorio conservan solicitudes. Los servicios gestionan decisión y autorización para reemplazo. APR-06 muestra el aviso de respuesta y registro completado. Fuente SRC-05.

**Prueba vinculada** CP-RF-5.4 según sección 8

*6 Requisitos funcionales › Configuración de asistencia*

## RF-6.1 Configuración de asistencia facial

**Identificador** RF-6.1 | Prioridad Alta

**Actores** Instructor

**Requisito** El sistema deberá iniciar una sesión de asistencia a partir de la configuración RF-5.2 y vincular cada reconocimiento con su sesión, ficha y dispositivo.

**Precondiciones** Sesión preparada y tiempos válidos; fichas y responsables activos.

**Entradas** Identificador de sesión y configuración de reconocimiento.

**Secuencia normal**

1. Consulta el resumen de ambiente, ficha y responsables.
2. El servidor vuelve a validar elegibilidad y disponibilidad.
3. Activa la sesión y vincula el dispositivo.
4. La captura identifica aprendices de esa ficha y deriva la asistencia en servidor.

**Escenarios alternativos**

- Sesión cerrada o fuera de horario: no registrar entrada.
- Dispositivo diferente o ficha fuera de alcance: rechazar.

**Postcondiciones** Sesión activa disponible para entrada y salida de asistencia.

**Criterios de aceptación**

- Original y reemplazo son consultables en la sesión.
- No hay aprobación facial basada solo en parámetros enviados por cliente.
- Cada evento incluye aprendiz, sesión, ambiente, dispositivo y hora confiable.

**Relaciones** RF-5.2, RF-6.2; RNF-6.1, RNF-6.2, RNF-6.3

**Estado observado** Operativo confirmado. El equipo confirma asistencia facial. El flujo usa sesión y eventos persistidos. La captura de cámara disponible acredita la fase de validación del registro facial del aprendiz. Fuente SRC-06.

**Prueba vinculada** CP-RF-6.1 según sección 8

## RF-6.2 Ajustes de registro, salida y apagado

**Identificador** RF-6.2 | Prioridad Alta

**Actores** Instructor autorizado y Sistema

**Requisito** El sistema deberá validar y aplicar entrada, ventana de puntualidad, salida y cierre de la sesión, incluyendo la segunda captura de salida.

**Precondiciones** Sesión preparada o activa sin cambio incompatible con eventos previos.

**Entradas** Hora de entrada, minutos de registro, hora de salida y hora de apagado.

**Secuencia normal**

1. Presenta valores vigentes.
2. El actor define tiempos y confirma.
3. Servidor exige 0 a 30 minutos; salida posterior al fin de ventana y apagado posterior a salida.
4. Clasifica entradas y habilita verificación de salida entre salida y apagado; cierra el punto al finalizar.

**Escenarios alternativos**

- Orden temporal inválido: conserva configuración anterior.
- Cambio con eventos históricos: versionar o restringir según autorización y registrar motivo.

**Postcondiciones** Tiempos persistidos, reglas uniformes y sesión cerrada al apagado.

**Criterios de aceptación**

- Entrada a las 06:00 y ventana de 5 minutos: hasta 06:05 inclusive es puntual.
- Después del límite y antes de salida es retardo; desde salida hasta antes de apagado es evento de salida.
- No se acepta salida anterior o igual al límite de puntualidad; una salida sin entrada no acredita puntualidad.

**Relaciones** RF-5.3, RF-6.1; RNF-6.1, RNF-6.2

**Estado observado** Integrado en código. La sesión transmite entryTime, registrationMinutes, exitTime y shutdownTime. El servidor aplica las reglas temporales. Las fronteras exactas y duplicados se verifican en CP-RF-6.2. Fuente SRC-06.

**Prueba vinculada** CP-RF-6.2 según sección 8

*6 Requisitos funcionales › Consulta e historial*

## RF-7.1 Consulta de asistencia por ficha

**Identificador** RF-7.1 | Prioridad Alta

**Actores** Coordinador e Instructor autorizado

**Requisito** El sistema deberá mostrar tarjetas por programa con inasistencias y retardos del día, y una matriz de aprendices por fecha con datos reales de asistencia.

**Precondiciones** Usuario con alcance sobre ficha; sesiones y vinculaciones académicas disponibles.

**Entradas** Programa, ficha y rango de fechas.

**Secuencia normal**

1. Consulta programas/fichas autorizados y tarjetas con porcentajes de fallas y retardos.
2. Selecciona ficha y rango.
3. Obtiene matriz del servidor con estados y categorías sin clase/sin registro.
4. Abre detalle de cualquier celda y exporta el mismo conjunto filtrado.

**Escenarios alternativos**

- Sin fichas, aprendices o eventos: informar el caso específico.
- Rango inválido o ficha fuera de alcance: rechazar sin exponer datos.

**Postcondiciones** Consulta consistente con eventos persistidos y exportación identificada.

**Criterios de aceptación**

- Verde puntual, amarillo retardo y rojo ausencia, con iconos/texto además del color.
- Cualquier celda muestra hora, día, ambiente y responsable cuando existe evento.
- Archivo identifica programa y ficha e incluye las tres categorías.
- Distingue una ausencia de un día sin sesión aplicable y conserva la referencia a la sesión que origina el estado.

**Relaciones** RF-7.2, RF-9.1; RNF-7.1 a RNF-7.5

**Estado observado** Evidencia visual. INS-01 muestra matriz por ficha para el 4 de noviembre, leyenda de estados y controles de exportación. COO-06 muestra el selector inicial de programa. Fuente SRC-07.

**Prueba vinculada** CP-RF-7.1 según sección 8

## RF-7.2 Consulta de asistencia individual

**Identificador** RF-7.2 | Prioridad Alta

**Actores** Aprendiz propio, Instructor asignado y Coordinador

**Requisito** El sistema deberá consultar la asistencia de un aprendiz por documento o nombre según el alcance del usuario, aplicando las mismas reglas de la consulta por ficha.

**Precondiciones** Permiso sobre el aprendiz y rango válido.

**Entradas** Aprendiz y fechas; para aprendiz, identidad tomada de sesión.

**Secuencia normal**

1. Busca aprendices autorizados o selecciona Mi asistencia.
2. Solicita registros del periodo al servidor.
3. Muestra estados, detalle, responsables y evidencia de salida.
4. Permite exportar el conjunto autorizado con filtros y titular identificados.

**Escenarios alternativos**

- Aprendiz ajeno o no asignado: rechazar 403.
- Sin eventos: mostrar vacío; distinguir días sin clase.

**Postcondiciones** Consulta individual sin cambios en registros.

**Criterios de aceptación**

- El aprendiz no obtiene registros de otro titular aunque cambie el UUID.
- Instructor solo consulta asignación o reemplazo autorizado.
- Detalle y estados coinciden con RF-7.1 para los mismos eventos.

**Relaciones** RF-7.1, RF-9.1; RNF-7.1, RNF-7.2, RNF-7.3

**Estado observado** Evidencia visual. APR-03 muestra una consulta individual con un registro de retraso y 100 % de asistencia para el rango seleccionado. APR-02 conserva el estado previo sin fechas. Fuente SRC-07.

**Prueba vinculada** CP-RF-7.2 según sección 8

## RF-7.3 Historial de asistencia

**Identificador** RF-7.3 | Prioridad Alta

**Actores** Todos los usuarios según alcance

**Requisito** El sistema deberá ofrecer un historial de tarjetas agrupadas por ficha y fecha, alimentado por la misma fuente persistente que las consultas y reportes.

**Precondiciones** Sesión válida y permisos de consulta.

**Entradas** Filtros de aprendiz, ficha, periodo y estado.

**Secuencia normal**

1. Solicita historial paginado y ordenado del más reciente al más antiguo.
2. Agrupa por ficha/fecha y muestra estado y tipo de registro.
3. Abre el detalle con hora, ambiente, instructor y entrada/salida.
4. Conserva filtros al navegar y actualiza ante cambios autorizados.

**Escenarios alternativos**

- Sin resultados: mostrar mensaje.
- Fallo de API: informar; caché permitida se identifica con fecha de sincronización, sin datos de demostración.

**Postcondiciones** Historia fiel, filtrada y consultable.

**Criterios de aceptación**

- Un evento real aparece en tabla, historial y reporte con los mismos valores.
- Desactivación o traslado de aprendiz no borra historia ni cambia su ficha histórica.
- La paginación no omite ni duplica eventos.

**Relaciones** RF-7.1, RF-7.2; RNF-3.6, RNF-6.3, RNF-7.2

**Estado observado** Integrado en código. useAttendanceRF6 deriva el historial desde useAttendance, que consulta attendance-matrix. La descripción anterior de fuente exclusivamente local quedó desactualizada. Fuente SRC-07.

**Prueba vinculada** CP-RF-7.3 según sección 8

*6 Requisitos funcionales › Notificaciones*

## RF-8.1 Generación automática de notificaciones

**Identificador** RF-8.1 | Prioridad Alta

**Actores** Sistema y destinatarios por evento

**Requisito** El sistema deberá generar notificaciones del catálogo de eventos y determinar destinatarios por relación académica y permiso.

**Precondiciones** Evento válido confirmado y catálogo de tipos/canales.

**Entradas** Tipo de evento, entidad, actor y datos mínimos de contexto.

**Secuencia normal**

1. Detecta evento de acceso, gestión, asistencia, sesión o solicitud.
2. Determina destinatarios y canal permitido.
3. Persiste la notificación con identidad del evento y evita duplicados.
4. Actualiza bandeja y programa entrega de correo/push según reglas.

**Escenarios alternativos**

- Fallo de entrega: conservar notificación y estado para reintento.
- Evento no confirmado: no comunicar como éxito.

**Postcondiciones** Notificación persistida y asociada a evento y destinatario.

**Criterios de aceptación**

- Incluye tipo, mensaje, fecha/hora, prioridad y referencia suficiente.
- Destinatarios no dependen de IDs arbitrarios enviados por otro rol.
- Un reintento del mismo evento no crea notificaciones duplicadas.

**Relaciones** RF-8.2, RF-8.3, RF-8.4; RNF-8.1 a RNF-8.4

**Estado observado** Evidencia visual. COO-07 y APR-06 muestran avisos por categorías, seguridad, CSV y registro facial. La cobertura de cada evento se comprueba con su caso de aceptación. Fuente SRC-08.

**Prueba vinculada** CP-RF-8.1 según sección 8

## RF-8.2 Visualización de notificaciones

**Identificador** RF-8.2 | Prioridad Media

**Actores** Todos los usuarios

**Requisito** El sistema deberá mostrar la bandeja del usuario autenticado, con estado de lectura, filtros y navegación al recurso autorizado.

**Precondiciones** Sesión válida; notificaciones propias o caché protegida propia.

**Entradas** Filtro de categoría/lectura y página.

**Secuencia normal**

1. Sincroniza notificaciones propias.
2. Ordena por fecha descendente y muestra no leídas.
3. Permite abrir detalle, marcar lectura y navegar al recurso con nueva comprobación de permiso.
4. Actualiza contador y conserva caché durable de las últimas 50.

**Escenarios alternativos**

- Offline: muestra caché propia y fecha de sincronización.
- Notificación ajena: rechazar consulta o modificación.

**Postcondiciones** Estado de lectura persistido y contador coherente.

**Criterios de aceptación**

- Solo destinatario modifica lectura.
- Notificaciones de más de 30 días se depuran según RNF-8.2.
- Bandeja carga en menos de 1.5 s y contador se sincroniza en tiempo real.

**Relaciones** RNF-8.2, RF-C4

**Estado observado** Evidencia visual. Las bandejas muestran filtros de lectura y categoría, contadores y el aviso de retención de 30 días. Fuente SRC-08.

**Prueba vinculada** CP-RF-8.2 según sección 8

## RF-8.3 Envío de notificaciones por correo

**Identificador** RF-8.3 | Prioridad Alta

**Actores** Sistema y destinatario

**Requisito** El sistema deberá enviar notificaciones de canal correo con límite horario, estado de entrega y reintentos, sin incluir contraseñas ni datos biométricos.

**Precondiciones** Notificación persistida, correo del titular y canal permitido.

**Entradas** Notificación, destinatario y estado de envío.

**Secuencia normal**

1. Verifica límite de cinco correos por hora y usuario.
2. Encola o envía después de confirmar el evento.
3. Registra intento y resultado sin duplicar entregas exitosas.
4. Reprograma pendientes o fallidas conservando disponibilidad en bandeja.

**Escenarios alternativos**

- Sexto correo en la hora: encolar para la siguiente ventana.
- SMTP no disponible: marcar fallo/pending y reintentar de forma controlada.

**Postcondiciones** Estado consultable de entrega y mensaje disponible en bandeja.

**Criterios de aceptación**

- Entrega inicial en menos de 5 s en condiciones normales.
- Nunca supera cinco correos por hora por usuario.
- No expone contraseña, vector, imágenes o información ajena.

**Relaciones** RF-8.1; RNF-8.3, RNF-8.4

**Estado observado** Operativo confirmado. El equipo confirma correo SMTP. Los listeners de entrega y recuperación están en backend. Las cuotas y tiempos del baseline necesitan mediciones específicas. Fuente SRC-08.

**Prueba vinculada** CP-RF-8.3 según sección 8

## RF-8.4 Notificación de solicitud de registro facial

**Identificador** RF-8.4 | Prioridad Alta

**Actores** Aprendiz y Coordinador

**Requisito** El sistema deberá notificar una solicitud de re-registro y su decisión usando la solicitud persistente RF-5.4.

**Precondiciones** Solicitud creada por su titular y resolutor autorizado.

**Entradas** Solicitud y decisión aceptada/rechazada.

**Secuencia normal**

1. Genera aviso a coordinadores autorizados con referencia a solicitud.
2. Muestra acciones de resolución si sigue pendiente.
3. Guarda decisión mediante RF-5.4.
4. Notifica al aprendiz aceptación, rechazo o vencimiento de autorización.

**Escenarios alternativos**

- Solicitud ya resuelta: no repetir decisión.
- Fallo de envío: mantener solicitud/decisión y reintentar comunicación.

**Postcondiciones** Ambos actores conocen el estado real y la autorización aplicable.

**Criterios de aceptación**

- Aviso creado en servidor y disponible en otro dispositivo.
- Marcar lectura no equivale a aprobar solicitud.
- La autorización solo habilita al titular y se consume una vez.

**Relaciones** RF-5.4; RNF-8.1, RNF-8.2

**Estado observado** Integrado en código. La solicitud facial se persiste y su decisión produce avisos. APR-06 contiene la respuesta al aprendiz y el aviso de registro completado. Fuente SRC-08.

**Prueba vinculada** CP-RF-8.4 según sección 8

*6 Requisitos funcionales › Reportes y consultas*

## RF-9.1 Reportes y consultas por rol

**Identificador** RF-9.1 | Prioridad Alta

**Actores** Aprendiz, Instructor y Coordinador

**Requisito** El sistema deberá generar reportes de asistencia por usuario, ficha, calendario y desempeño desde eventos persistidos, con filtros y exportación coherentes.

**Precondiciones** Permiso de consulta y datos de sesiones y sus tiempos.

**Entradas** Tipo de reporte, sujeto, fechas y formato XLSX/CSV.

**Secuencia normal**

1. Selecciona reporte y filtros permitidos.
2. Servidor calcula estados y métricas con denominadores definidos.
3. Presenta tabla/calendario, detalle y alertas de riesgo.
4. Exporta exactamente los datos filtrados, identificando sujeto, periodo y fecha de generación.

**Escenarios alternativos**

- Sin clases/eventos: informar sin fabricar porcentajes.
- Fuera de alcance o periodo inválido: denegar.

**Postcondiciones** Reporte reproducible consistente con RF-7.

**Criterios de aceptación**

- Aprendiz solo ve sus datos; instructor sus fichas; coordinador el ámbito administrativo.
- No usa eventos mock para reportes operativos.
- XLSX coincide con filtros y permisos; muestra registros manuales/anulados y excusas sin ocultar su trazabilidad.
- Asistencia inferior al 80% se señala con icono/texto y color; umbral configurable por coordinador.

**Relaciones** RF-7.1 a RF-7.3; RNF-7.1 a RNF-7.5

**Estado observado** Integrado en código. Las consultas usan useAttendance y la matriz de API. INS-01 muestra controles Excel y CSV. La igualdad del archivo descargado con filtros y permisos necesita el archivo de evidencia. Fuente SRC-07.

**Prueba vinculada** CP-RF-9.1 según sección 8

*6 Requisitos funcionales › Requisitos complementarios*

## RF-C1 Horarios y excepciones

**Identificador** RF-C1 | Inventario histórico

**Alcance actualizado** La entrega vigente gestiona tiempos dentro de sesiones de ambiente. Las rutas de horarios y excepciones se retiraron del frontend. Este identificador se conserva para rastrear el requisito anterior.

**Criterio de revisión** Los menús y manuales de la versión actual deben describir Ambientes y sesiones. Una reincorporación de horarios requiere nueva definición de alcance, contratos y pruebas.

**Estado observado** Retirado del alcance vigente. Las rutas de gestión de horarios y excepciones fueron retiradas. El ID se conserva para rastrear el baseline. Los tiempos operativos se definen en la sesión de ambiente. Fuente SRC-06.

**Prueba vinculada** CP-RF-C1 queda como referencia histórica.

## RF-C2 Ambientes, dispositivos y sesiones

**Identificador** RF-C2 | Prioridad Media

**Actores** Coordinador e Instructor según operación

**Requisito** El sistema deberá mantener un catálogo de ambientes/dispositivos y su asociación a sesiones, con estado y disponibilidad verificables.

**Precondiciones** Actor autorizado y relaciones académicas existentes.

**Entradas** Nombre/código, capacidad, estado, dispositivo y sesión.

**Secuencia normal**

1. Consulta catálogo autorizado.
2. Registra o edita datos y valida unicidad/capacidad.
3. Asocia dispositivo al ambiente y sesión sin asignación simultánea incompatible.
4. Desactiva cuando corresponda preservando referencias históricas.

**Escenarios alternativos**

- Ambiente ocupado, capacidad inválida o dependencia activa: rechazar operación incompatible.
- Dispositivo no confiable: no aceptar datos como reconocimiento automático.

**Postcondiciones** Catálogo coherente y dispositivo trazable en eventos.

**Criterios de aceptación**

- No usa catálogos mock en operación.
- Eliminar ambiente con historia o sesión activa no se permite.
- Gestión de catálogo y apertura de sesión tienen permisos separados.

**Relaciones** RF-5.2, RF-6.1; RNF-6.1

**Estado observado** Evidencia visual. COO-05 muestra el catálogo de ambientes cargado. SecurityConfig permite GET y POST de ambientes a instructor y coordinador. Editar, desactivar y vincular fichas corresponde al coordinador. Las sesiones corresponden al instructor. Fuente SRC-06.

**Prueba vinculada** CP-RF-C2 según sección 8

## RF-C3 Persistencia de preferencias entre sesiones

**Identificador** RF-C3 | Prioridad Media

**Actores** Todos los usuarios

**Requisito** El sistema deberá restaurar y sincronizar las preferencias RF-4.2 entre inicios y dispositivos sin sobrescribir las de otros titulares.

**Precondiciones** Sesión y configuración del titular.

**Entradas** Preferencias y versión guardada.

**Secuencia normal**

1. Carga configuración al autenticar.
2. Aplica idioma, tema y notificaciones.
3. Guarda cambios del titular con confirmación.
4. En otra sesión recupera la configuración vigente.

**Escenarios alternativos**

- Fallo de sincronización: informar estado pendiente y conservar último valor confirmado.
- Actualización concurrente: resolver conflicto mediante versión o regla explícita.

**Postcondiciones** Preferencias reproducibles y propias.

**Criterios de aceptación**

- ES/EN/DE/FR coinciden en todas las capas.
- Una preferencia informativa no modifica permisos o mensajes obligatorios de seguridad.
- Desactivación de notificaciones se conserva.

**Relaciones** RF-4.2; RNF-4.1

**Estado observado** Integrado en código. Las preferencias del titular se guardan en API. El mapeo actual incluye alemán y francés. La recuperación en otro dispositivo requiere el caso específico de persistencia. Fuente SRC-04.

**Prueba vinculada** CP-RF-C3 según sección 8

## RF-C4 Sincronización en tiempo real

**Identificador** RF-C4 | Prioridad Media

**Actores** Usuarios autenticados y Sistema

**Requisito** El sistema deberá comunicar cambios relevantes a sesiones autorizadas y permitir recuperación de sincronización después de una desconexión.

**Precondiciones** Token vigente, canal protegido y alcance del destinatario.

**Entradas** Autenticación de canal y eventos de cambio.

**Secuencia normal**

1. Autentica el canal antes de entregar información.
2. Valida identidad/alcance en cada emisión relevante.
3. Notifica cambios y el cliente vuelve a consultar datos autorizados.
4. Reconecta con espera creciente hasta 30 s y recupera cambios pendientes.

**Escenarios alternativos**

- Token inválido, revocado o vencido: cerrar canal.
- Conexión perdida: conservar estado confirmado y sincronizar al recuperar.

**Postcondiciones** Interfaz actualizada sin filtrar datos entre roles o usuarios.

**Criterios de aceptación**

- No emite datos ajenos por compartir conexión o tipo de evento.
- Logout o desactivación invalida también el canal abierto.
- Reconexión no duplica asistencia ni notificaciones.

**Relaciones** RNF-1.11, RNF-1.16, RNF-8.2

**Estado observado** Integrado en código. realtime.ts y el manejador WebSocket intercambian eventos de actualización con autenticación. La prueba técnica de handshake está registrada en despliegue. Recuperación y revocación del canal necesitan su evidencia específica. Fuente SRC-08.

**Prueba vinculada** CP-RF-C4 según sección 8

# 7 Requisitos no funcionales

Los RNF conservan su numeración y objetivos. Los criterios medibles se verifican en un entorno representativo; no se declaran satisfechos por compilar o encontrar una biblioteca. Se distingue el rendimiento de extracción facial del tiempo de persistencia posterior a la identificación.

## 7.1 Accesos y seguridad

### RNF-1.1 Seguridad de autenticación

**Requisito** El sistema debe proteger el proceso de autenticación mediante mecanismos seguros de validación de credenciales.

**Control** - El inicio de sesión debe realizarse mediante número de documento y contraseña. - El número de documento no debe utilizarse como contraseña ni almacenarse como credencial secreta. - Las contraseñas deben almacenarse utilizando algoritmos de hashing seguros. - El sistema nunca debe almacenar ni mostrar contraseñas en texto plano. - Las credenciales no deben enviarse mediante conexiones no seguras. - Las comunicaciones entre frontend y backend deben realizarse mediante HTTPS/TLS en ambientes de producción. - Los mensajes de error no deben revelar información sensible de la cuenta.

**Aceptación** Las credenciales del usuario deben transmitirse y almacenarse de forma segura, sin exponer la contraseña original.

**Estado observado** Criterio por verificar. BCrypt, JWT y HTTPS público están presentes. El acceso privado al microservicio usa la red Docker y clave interna. Fuente SRC-01.

**Prueba** CP-RNF-1.1

### RNF-1.2 Política de contraseñas

**Requisito** El sistema debe aplicar una política mínima de seguridad para las contraseñas.

**Control** La contraseña debe: - Tener entre 8 y 15 caracteres. - Contener letras. - Contener números. - Contener al menos un símbolo. - No almacenarse en texto plano. - No mostrarse en registros, logs ni mensajes del sistema. Cuando se realice un restablecimiento de contraseña, la nueva contraseña debe cumplir las mismas reglas de seguridad.

**Aceptación** El sistema debe rechazar cualquier contraseña que no cumpla con las reglas establecidas.

**Estado observado** Criterio por verificar. Existe validación de longitud y complejidad. Revisar cambio inicial, recuperación y rotación con la misma política. Fuente SRC-01.

**Prueba** CP-RNF-1.2

### RNF-1.3 Protección contra intentos de acceso no autorizados

**Requisito** El sistema deberá registrar intentos de autenticación y persistir un contador por cuenta, con bloqueo temporal tras cinco fallos consecutivos durante cinco minutos. El control deberá operar en servidor aunque se recargue o eluda la interfaz.

**Control** Persistir el intento fallido sin perderlo por rollback; limitar intentos automatizados y registrar éxito/fallo sin revelar existencia de cuenta.

**Aceptación** Cinco fallos consecutivos contra la API activan bloqueo de cinco minutos. Reiniciar la interfaz no elimina el bloqueo. Un éxito permitido reinicia el contador y deja auditoría.

**Estado observado** Integrado en código. Login usa bloqueo de credencial y @Transactional(noRollbackFor = LoginException.class). El hallazgo histórico de rollback ya no describe este método. Fuente SRC-01.

**Prueba** CP-RNF-1.3

### RNF-1.4 Control de acceso basado en roles

**Requisito** El sistema debe implementar un mecanismo de control de acceso basado en roles (RBAC).

**Control** Los permisos deben estar asociados a los siguientes roles: - Aprendiz. - Instructor. - Coordinador. El sistema debe validar los permisos tanto en el frontend como en el backend. La interfaz puede ocultar funcionalidades no autorizadas, pero la seguridad no debe depender únicamente de esta restricción visual.

**Aceptación** Un usuario no debe poder ejecutar mediante solicitudes directas al backend una operación que no esté autorizada para su rol.

**Estado observado** Criterio por verificar. SecurityConfig diferencia operaciones de coordinación, instructor y aprendiz. Se requieren variantes por recurso ajeno para el criterio completo. Fuente SRC-01.

**Prueba** CP-RNF-1.4

### RNF-1.5 Restricción de información por rol

**Requisito** El sistema debe garantizar que cada usuario solo pueda consultar la información correspondiente a sus permisos.

**Control** Aprendiz Debe poder consultar: - Sus propios datos. - Sus propias asistencias. - La información académica que le corresponda. No debe poder consultar información privada ni asistencias de otros Aprendices. Instructor Debe poder consultar: - Las fichas que tenga asignadas. - Los aprendices pertenecientes a dichas fichas. - Las asistencias correspondientes a sus fichas asignadas. No debe poder consultar información de fichas que no tenga asignadas. Coordinador Debe poder consultar y gestionar la información administrativa necesaria para sus funciones, incluyendo la gestión de usuarios, roles y datos personales.

**Aceptación** El sistema debe impedir que un usuario acceda a información perteneciente a otro usuario, ficha o rol fuera de su ámbito autorizado.

**Estado observado** Criterio por verificar. Las rutas de autoservicio y los servicios de asistencia aplican alcance. La comparación de identificadores propios y ajenos pertenece al caso negativo. Fuente SRC-01.

**Prueba** CP-RNF-1.5

### RNF-1.6 Protección de datos personales

**Requisito** El sistema debe proteger los datos personales almacenados y procesados durante el funcionamiento del módulo.

**Control** - El acceso a los datos debe estar limitado según el rol. - Los datos personales no deben exponerse a usuarios no autorizados. - Las modificaciones de información personal deben quedar registradas. - El sistema debe mantener trazabilidad de las operaciones relevantes. - El tratamiento de datos debe realizarse conforme a las políticas de privacidad y protección de datos aplicables al proyecto.

**Aceptación** Un usuario sin permisos suficientes no debe poder consultar ni modificar datos personales de otros usuarios.

**Estado observado** Criterio por verificar. Se observan consentimiento, control de sesión y permisos. La política de retención y eliminación biométrica requiere responsable y evidencia propia. Fuente SRC-01.

**Prueba** CP-RNF-1.6

### RNF-1.7 Gestión de actualización de datos personales

**Requisito** Los Aprendices e Instructores no deben modificar directamente sus datos personales desde el sistema. Las modificaciones deben realizarse mediante un usuario autorizado, principalmente el Coordinador.

**Control** El sistema debe: - Restringir técnicamente la modificación directa por parte de Aprendices e Instructores. - Permitir al Coordinador realizar las modificaciones autorizadas. - Registrar quién realizó la modificación. - Registrar la fecha y hora de la modificación. - Mantener trazabilidad de los cambios realizados.

**Aceptación** Una solicitud realizada por un Aprendiz o Instructor para modificar directamente sus datos debe ser rechazada por el backend.

**Estado observado** Criterio por verificar. Existe actualización administrativa. El cambio de documento permitido por el servicio debe alinearse con la regla de identidad del baseline. Fuente SRC-01.

**Prueba** CP-RNF-1.7

### RNF-1.8 Auditoría y trazabilidad

**Requisito** El sistema debe mantener registros de seguridad de las operaciones relevantes del módulo.

**Control** Como mínimo, deben registrarse: - Inicio de sesión exitoso. - Intentos de inicio de sesión fallidos. - Restablecimientos de contraseña. - Cambios de contraseña. - Cambios de rol. - Modificaciones de datos personales. - Cambios relacionados con permisos. - Eventos relevantes de acceso no autorizado. Los registros deben contener, cuando corresponda: - Usuario involucrado. - Fecha. - Hora. - Tipo de operación. - Resultado de la operación. - Identificador técnico de la operación o sesión. Los registros no deben almacenar contraseñas ni códigos de recuperación en texto plano.

**Aceptación** Las operaciones críticas del módulo deben poder ser rastreadas posteriormente mediante los registros de auditoría.

**Estado observado** Criterio por verificar. Hay ChangeHistory y sesiones persistidas. La cobertura de cada campo, motivo y operación debe verificarse por caso. Fuente SRC-01.

**Prueba** CP-RNF-1.8

### RNF-1.9 Seguridad del restablecimiento de contraseña

**Requisito** La recuperación deberá usar código aleatorio de seis dígitos, vigente cinco minutos, ligado a una solicitud y cuenta; no podrá reutilizarse ni emplearse para otra cuenta.

**Control** Invalidar códigos anteriores al reenviar, limitar intentos y consumir la autorización de manera atómica; revocar sesiones al cambiar contraseña.

**Aceptación** Código vencido, usado o de otra solicitud no permite cambiar la contraseña. Dos peticiones concurrentes no lo consumen dos veces. Los umbrales de intentos de recuperación se registran en DEC-06 antes de aceptación.

**Estado observado** Criterio por verificar. Hay recuperación, códigos y sesiones de recuperación. Duración, límite, reenvío, titular y consumo se verifican con solicitudes controladas. Fuente SRC-01.

**Prueba** CP-RNF-1.9

### RNF-1.10 Protección del correo electrónico

**Requisito** El correo se usará para recuperación y comunicaciones autorizadas; el identificador de inicio de sesión será el documento. Las vistas ordinarias mostrarán correo enmascarado.

**Control** Rechazar autenticación por email y reducir exposición del correo conforme a RNF-4.2.

**Aceptación** Una solicitud de login identificada solo por correo es rechazada. El documento válido permite el acceso con la credencial correcta. El correo completo no se muestra en perfiles/listados/reportes ordinarios.

**Estado observado** Diferencia con el criterio. El login visible solicita documento. LoginServiceImpl también busca por correo. La restricción exclusiva a documento sigue siendo una diferencia concreta. Fuente SRC-01.

**Prueba** CP-RNF-1.10

### RNF-1.11 Gestión segura de sesiones

**Requisito** La sesión deberá usar tokens firmados con expiración y revocación, vinculados a identidad, estado vigente y autorización actual.

**Control** Validar token y estado de sesión/cuenta en API y canal de tiempo real; revocar ante logout, desactivación, recuperación y cambio de rol.

**Aceptación** Token alterado, expirado o revocado es rechazado; no conserva permisos de un rol anterior. Manipular estado local no concede privilegios.

**Estado observado** Integrado en código. JwtServiceImpl valida sid contra SessionSecurityService. Existe revocación de token y comprobación del estado vigente. Fuente SRC-01.

**Prueba** CP-RNF-1.11

### RNF-1.12 Rendimiento del inicio de sesión

**Requisito** El proceso de autenticación debe responder de manera eficiente.

**Control** Bajo condiciones normales de operación: - El sistema debería responder a una solicitud de inicio de sesión en un tiempo máximo de 3 segundos. - La consulta del usuario y su rol debe realizarse de manera eficiente. - Las operaciones de autenticación no deben generar consultas innecesarias a la base de datos.

**Aceptación** Al menos el 95 % de los intentos de inicio de sesión realizados bajo condiciones normales deberían recibir una respuesta en un máximo de 3 segundos.

**Estado observado** Criterio por verificar. La operación del login está confirmada. Falta una serie de mediciones que demuestre el percentil exigido. Fuente SRC-01.

**Prueba** CP-RNF-1.12

### RNF-1.13 Disponibilidad del servicio de autenticación

**Requisito** El servicio necesario para la autenticación debe encontrarse disponible durante el horario operativo definido para el sistema.

**Control** Cuando el servicio de autenticación no esté disponible: - El sistema debe informar al usuario que temporalmente no es posible iniciar sesión. - No debe mostrar información técnica sensible. - No debe generar sesiones incompletas. - El error debe registrarse para su posterior análisis.

**Aceptación** Una falla del servidor de autenticación no debe permitir el acceso no autorizado al sistema.

**Estado observado** Criterio por verificar. La publicación está operativa. Una respuesta HTTP correcta no mide disponibilidad durante el periodo acordado. Fuente SRC-01.

**Prueba** CP-RNF-1.13

### RNF-1.14 Usabilidad del acceso

**Requisito** La pantalla de inicio de sesión debe ser clara y comprensible para los tres roles.

**Control** Debe: - Identificar claramente el campo de número de documento. - Identificar claramente el campo de contraseña. - Permitir visualizar u ocultar la contraseña mediante un control seguro. - Mostrar mensajes de validación comprensibles. - Permitir acceder al proceso de recuperación de contraseña. - Evitar solicitar información innecesaria para iniciar sesión.

**Aceptación** Un usuario debe poder identificar fácilmente cómo ingresar al sistema y cómo recuperar su contraseña.

**Estado observado** Criterio por verificar. Hay formularios y mensajes por rol. La evaluación con usuarios y su registro de tareas corresponde a la aceptación de usabilidad. Fuente SRC-01.

**Prueba** CP-RNF-1.14

### RNF-1.15 Separación de responsabilidades

**Requisito** Las funciones de autenticación, autorización y administración deben mantenerse separadas.

**Control** El sistema debe diferenciar entre: - Autenticación: verificar quién es el usuario. - Autorización: determinar qué puede hacer el usuario. - Administración: gestionar usuarios, datos y roles. La modificación de roles y permisos debe estar restringida a usuarios con autorización administrativa.

**Aceptación** La autenticación exitosa de un usuario no debe otorgarle automáticamente permisos administrativos.

**Estado observado** Integrado en código. Se observan controladores, servicios, repositorios y un servicio facial separado. Fuente SRC-01.

**Prueba** CP-RNF-1.15

### RNF-1.16 Integridad de los permisos

**Requisito** Los permisos asociados a cada rol deben mantenerse consistentes entre frontend y backend.

**Control** El sistema debe garantizar que: - Los permisos definidos para Aprendiz sean respetados. - Los permisos definidos para Instructor sean respetados. - Los permisos definidos para Coordinador sean respetados. - Un cambio de rol realizado por el Coordinador sea aplicado correctamente. - Los permisos anteriores no permanezcan activos de manera indebida después de un cambio de rol.

**Aceptación** Después de modificar el rol de un usuario, el sistema debe aplicar únicamente los permisos correspondientes al nuevo rol.

**Estado observado** Integrado en código. La validación de sesión coteja el rol persistido y estado actual. Los alias de interfaz deben mantenerse alineados con los tres roles de backend. Fuente SRC-01.

**Prueba** CP-RNF-1.16

## 7.2 Gestión académica

### RNF-2.1 Control de acceso

**Requisito** Solo un usuario con rol Coordinador puede cargar archivos CSV, crear, editar, desactivar, reactivar o eliminar Programas, Fichas, Aprendices e Instructores, y generar/consultar códigos de traslado. Esta restricción se valida siempre en el backend, nunca solo ocultando los botones en la pantalla - un Instructor o Aprendiz que intente llamar directamente a estos endpoints debe recibir un rechazo del servidor, no solo no ver el botón.

**Control** Aplicar el control en las capas pertinentes y conservar evidencia de verificación de los criterios indicados.

**Aceptación** Una solicitud directa al backend desde una cuenta que no sea Coordinador para cualquiera de estas operaciones debe ser rechazada con un código de error de autorización, no procesada parcialmente.

**Estado observado** Integrado en código. La escritura académica exige COORDINATOR. Los GET académicos autorizados de instructor tienen un alcance distinto. Fuente SRC-02.

**Prueba** CP-RNF-2.1

### RNF-2.2 Validación e integridad de datos

**Requisito** Las altas y actualizaciones deberán preservar formato, unicidad, estados y relaciones de programa, ficha, aprendiz e instructor.

**Control** Aplicar reglas comunes a CSV y formulario: ficha con programa; aprendiz activo asignado a una ficha activa; instructor específico con programa. Mantener relaciones históricas al desactivar.

**Aceptación** No quedan fichas sin programa ni vínculos activos inválidos. Una cuenta desactivada puede conservar relaciones históricas sin considerarse una asignación operativa. Datos inválidos no crean registros parciales.

**Estado observado** Criterio por verificar. DTO, servicios y restricciones de la base validan referencias y estados. La batería de errores se documenta por caso. Fuente SRC-02.

**Prueba** CP-RNF-2.2

### RNF-2.3 Trazabilidad completa

**Requisito** Toda operación de este módulo - carga de CSV (exitosa o con errores), creación, edición, desactivación, reactivación, eliminación permanente, confirmación o cancelación de un cambio de ficha por CSV, y generación o uso de un código de traslado - debe quedar registrada con: quién la hizo, cuándo (fecha y hora exactas), y qué cambió exactamente (valor anterior y valor nuevo, cuando aplique). Estos registros no pueden editarse ni eliminarse por ningún rol, incluido el propio Coordinador.

**Control** Aplicar el control en las capas pertinentes y conservar evidencia de verificación de los criterios indicados.

**Aceptación** Para cualquier dato de Programa, Ficha, Aprendiz o Instructor, debe poder reconstruirse su historial completo de cambios sin ambigüedad.

**Estado observado** Criterio por verificar. ChangeHistory conserva operaciones académicas. La cobertura completa del historial es un criterio adicional de revisión. Fuente SRC-02.

**Prueba** CP-RNF-2.3

### RNF-2.4 Protección de datos personales

**Requisito** Los datos personales de Aprendices e Instructores (documento, nombre, apellido, correo) se almacenan y transmiten de forma segura. El archivo CSV cargado se procesa y no se conserva en crudo después de procesarse (no queda un archivo con datos personales sueltos en el servidor más allá de lo necesario para el procesamiento). El correo nunca se muestra completo en ninguna pantalla de este módulo salvo en el propio formulario de edición del registro correspondiente.

**Control** Aplicar el control en las capas pertinentes y conservar evidencia de verificación de los criterios indicados.

**Aceptación** Ningún archivo CSV cargado queda accesible o descargable después de haberse procesado.

**Estado observado** Criterio por verificar. La interfaz y API manejan datos personales. El resumen y los DTO legacy deben revisarse para confirmar máscara y ausencia de secretos en cada respuesta. Fuente SRC-02.

**Prueba** CP-RNF-2.4

### RNF-2.5 Rendimiento de la carga de CSV

**Requisito** El procesamiento de un archivo CSV debe completarse en un tiempo razonable según su tamaño. Como referencia: un archivo de hasta 500 filas debe procesarse en menos de 10 segundos; archivos más grandes deben mostrar una barra o indicador de progreso, nunca dejar la pantalla congelada sin retroalimentación.

**Control** Aplicar el control en las capas pertinentes y conservar evidencia de verificación de los criterios indicados.

**Aceptación** El Coordinador siempre tiene una señal visual de que el archivo se está procesando mientras dura la carga.

**Estado observado** Criterio por verificar. CSV está operativo. COO-04 muestra los límites del formulario. La meta de 500 filas en menos de 10 s requiere cronometraje con condiciones registradas. Fuente SRC-02.

**Prueba** CP-RNF-2.5

### RNF-2.6 Disponibilidad de la información académica

**Requisito** La consulta de Programas, Fichas, Aprendices e Instructores (fuera de la carga de CSV en sí) debe estar disponible con alta confiabilidad, dado que otros módulos (Asistencia, Notificaciones, el propio login para verificar a qué ficha pertenece un aprendiz) dependen de esta información para funcionar.

**Control** Aplicar el control en las capas pertinentes y conservar evidencia de verificación de los criterios indicados.

**Aceptación** Antes de aprobar este RNF, definir el horario operativo y la meta de disponibilidad (porcentaje y periodo de medición). Después, verificar consultas de Programas, Fichas, Aprendices e Instructores durante el periodo acordado y registrar indisponibilidades. Meta cuantitativa: pendiente de aprobación; no asumir un porcentaje no acordado.

**Estado observado** Criterio por verificar. Las consultas cargan datos en las capturas. La disponibilidad requiere una ventana de observación y meta aprobadas. Fuente SRC-02.

**Prueba** CP-RNF-2.6

### RNF-2.7 Usabilidad para un usuario no técnico

**Requisito** Los mensajes de error de CSV y de formularios manuales deben explicar el dato que requiere corrección y la acción disponible. Los errores se presentan con lenguaje comprensible según la sección 5.4.

**Control** Aplicar el control en las capas pertinentes y conservar evidencia de verificación de los criterios indicados.

**Aceptación** Un Coordinador sin conocimientos técnicos debe poder entender y corregir cualquier error mostrado, sin necesidad de soporte técnico, en la mayoría de los casos.

**Estado observado** Criterio por verificar. COO-04 muestra guía previa y COO-07 avisos comprensibles de referencias inválidas. La prueba de comprensión requiere participantes y resultados. Fuente SRC-02.

**Prueba** CP-RNF-2.7

### RNF-2.8 Consistencia entre carga por CSV y edición manual

**Requisito** El resultado final de crear/editar un Programa, Ficha, Aprendiz o Instructor debe ser idéntico sin importar si se hizo por CSV o manualmente - las mismas reglas de validación, el mismo ciclo de vida (activo/inactivo), y la misma trazabilidad aplican por los dos caminos, sin excepciones especiales para uno u otro.

**Control** Aplicar el control en las capas pertinentes y conservar evidencia de verificación de los criterios indicados.

**Aceptación** Para una misma entidad y datos equivalentes, ejecutar alta/actualización por CSV y formulario manual; los valores y relaciones persistidos deben coincidir. Registrar el resultado de ambas rutas, incluyendo reglas de validación y errores.

**Estado observado** Criterio por verificar. CSV y formularios usan servicios de dominio. Comparar una misma entidad por ambos caminos verifica equivalencia. Fuente SRC-02.

**Prueba** CP-RNF-2.8

### RNF-2.9 Unicidad de identificadores

**Requisito** El sistema debe garantizar que nunca existan dos Programas con el mismo programa_codigo, dos Fichas con el mismo ficha_codigo, ni dos cuentas (Aprendiz o Instructor) con el mismo número de documento - tanto si el conflicto surge por CSV como por formulario manual.

**Control** Aplicar el control en las capas pertinentes y conservar evidencia de verificación de los criterios indicados.

**Aceptación** Un intento de crear un duplicado, por cualquier vía, siempre se resuelve como actualización del registro existente (si los datos son consistentes) o como error/inconsistencia bloqueada (si no lo son) - nunca se crean dos registros distintos con el mismo identificador.

**Estado observado** Criterio por verificar. Se observan validaciones de unicidad y restricciones SQL. La prueba concurrente requiere ejecución controlada. Fuente SRC-02.

**Prueba** CP-RNF-2.9

### RNF-2.10 Atomicidad del traslado de ficha

**Requisito** El traslado RF-2.3 deberá desactivar origen y activar destino en una única transacción, preservando una asignación activa al confirmar.

**Control** Validar destino, bloquear conflictos concurrentes y registrar el cambio junto con su auditoría.

**Aceptación** Fallo antes o durante el traslado revierte los cambios. Tras confirmar existe una única ficha activa; no se observan relaciones parciales. Dos traslados simultáneos se resuelven sin dos asignaciones activas.

**Estado observado** Criterio por verificar. El traslado se implementa transaccionalmente. La inyección de un fallo y traslados concurrentes comprueban su atomicidad. Fuente SRC-02.

**Prueba** CP-RNF-2.10

### RNF-2.11 Auditoría de la resolución de inconsistencias

**Requisito** Cuando el Coordinador resuelve una inconsistencia bloqueada del CSV (vía "Ir a corregir"), o confirma/cancela un cambio de ficha propuesto por CSV, esa decisión queda registrada como un evento de auditoría propio - distinto del evento de la carga original - para poder diferenciar después "qué trajo el archivo" de "qué decidió finalmente el Coordinador".

**Control** Aplicar el control en las capas pertinentes y conservar evidencia de verificación de los criterios indicados.

**Aceptación** Al resolver/cancelar una inconsistencia, comprobar que queda evidencia consultable con actor, fecha/hora, entidad, valores relevantes, decisión y motivo cuando aplique. La operación debe poder rastrearse hasta la carga CSV que la originó.

**Estado observado** Criterio por verificar. Hay decisiones de traslados pendientes y ChangeHistory. Verificar el vínculo de la decisión a su carga y motivo. Fuente SRC-02.

**Prueba** CP-RNF-2.11

### RNF-2.12 Escalabilidad de la gestión académica

**Requisito** El módulo debe soportar el volumen real esperado de un centro de formación (referencia: cientos de fichas, miles de aprendices) sin degradar el tiempo de respuesta de las pantallas de consulta y búsqueda por debajo de lo aceptable (ver RNF-2.5 para el caso específico de carga de CSV).

**Control** Aplicar el control en las capas pertinentes y conservar evidencia de verificación de los criterios indicados.

**Aceptación** Ejecutar pruebas con el volumen de referencia del requisito (cientos de fichas y miles de aprendices), medir operaciones de consulta/gestión y registrar tiempos y errores. Umbrales de respuesta: pendientes de aprobación antes de declarar conformidad.

**Estado observado** Criterio por verificar. COO-01 muestra 402 fichas y 3.640 usuarios. El frontend local consulta aprendices en lotes de hasta 80 fichas. Los tiempos bajo carga requieren medición. Fuente SRC-02.

**Prueba** CP-RNF-2.12

### RNF-2.13 Recuperación ante fallos durante la carga de CSV

**Requisito** Un fallo técnico durante una carga CSV no deberá dejar cambios a medio confirmar. Las filas con error de negocio se excluyen del conjunto aplicable y se informan en el resumen.

**Control** Validar y clasificar filas, ejecutar el conjunto válido en una transacción y confirmar resultados solo después del commit.

**Aceptación** Interrumpir la carga antes del commit deja la base en su estado anterior. Reprocesar no duplica registros. Un error de negocio por fila no impide procesar las demás válidas según RF-2.1.

**Estado observado** Criterio por verificar. La carga tiene tratamiento de filas y transacciones. Un ensayo de interrupción debe demostrar el estado final de la base. Fuente SRC-02.

**Prueba** CP-RNF-2.13

### RNF-2.14 Internacionalización de nombres y apellidos

**Requisito** El sistema debe aceptar correctamente nombres y apellidos con tildes, diéresis y la letra "ñ", tanto en el CSV como en los formularios manuales, sin corromper los caracteres al guardarlos ni al mostrarlos (el archivo CSV debe leerse en codificación UTF-8).

**Control** Aplicar el control en las capas pertinentes y conservar evidencia de verificación de los criterios indicados.

**Aceptación** Procesar nombres y apellidos con tildes, diéresis y ñ por CSV, formulario, API, almacenamiento, visualización y exportación. Los caracteres deben conservarse sin sustitución ni corrupción en todas las etapas.

**Estado observado** Criterio por verificar. CSV y capturas presentan tildes. Revisar también diéresis, ñ y normalización en alta y edición con los mismos datos. Fuente SRC-02.

**Prueba** CP-RNF-2.14

## 7.3 Gestión de usuarios

### RNF-3.1 Panel de usuarios registrados

**Requisito** El sistema debe mostrar el listado completo de usuarios de forma paginada y permitir filtrar por rol, estado y ficha. Solo el Coordinador tiene acceso a esta vista.

**Control** Consultar la base de datos de usuarios y aplicar los filtros seleccionados antes de renderizar el listado.

**Aceptación** - El listado carga en menos de 2 segundos con hasta 500 usuarios. - El acceso desde otro rol retorna error 403. - Los filtros responden en menos de 1 segundo.

**Estado observado** Criterio por verificar. COO-02 muestra listado y filtros con 3.640 resultados. Paginación y tiempo del criterio se evalúan aparte. Fuente SRC-03.

**Prueba** CP-RNF-3.1

### RNF-3.2 Unicidad de número de documento

**Requisito** El sistema no permite registrar dos usuarios con el mismo número de documento.

**Control** Validar en la base de datos si el documento ya está registrado antes de crear el nuevo usuario.

**Aceptación** - El sistema bloquea el registro duplicado. - El error se muestra en tiempo real sin necesidad de enviar el formulario. - No se crea ningún registro parcial en la base de datos.

**Estado observado** Criterio por verificar. Existen comprobaciones y unicidad del documento. Probar duplicados por alta administrativa y CSV. Fuente SRC-03.

**Prueba** CP-RNF-3.2

### RNF-3.3 Contraseña inicial segura

**Requisito** La credencial inicial deberá ser aleatoria, cumplir RNF-1.2 y almacenarse únicamente como hash. Ningún endpoint ordinario ni exportación la devolverá en texto legible.

**Control** Generar un secreto independiente del documento; emplear activación de un uso o entrega protegida al titular según DEC-02; no conservar el secreto en logs, CSV o resultados administrativos.

**Aceptación** Alta manual y CSV cumplen la misma regla. Password no aparece en panel, Excel, CSV, respuestas o logs. Su longitud es de 8 a 15 e incluye letra, número y símbolo.

**Estado observado** Criterio por verificar. Se generan credenciales y se almacenan hashes. Los DTO conservan campos legacy. Comprobar contenido real de respuestas y exportaciones. Fuente SRC-03.

**Prueba** CP-RNF-3.3

### RNF-3.4 Inmutabilidad del número de documento

**Requisito** El número de documento de un usuario no puede modificarse una vez creado el registro.

**Control** Deshabilitar el campo de documento en el formulario de edición y rechazar cualquier solicitud de actualización de ese campo en el servidor.

**Aceptación** - El campo está visualmente deshabilitado en el formulario. - La API rechaza peticiones de actualización del documento con error 400. - El historial del usuario se mantiene intacto tras cualquier otra edición.

**Estado observado** Diferencia con el criterio. UserManagementServiceImpl permite asignar un nuevo documento en edición. El criterio de inmutabilidad sigue por alinear. Fuente SRC-03.

**Prueba** CP-RNF-3.4

### RNF-3.5 Trazabilidad de cambios en usuarios

**Requisito** El sistema registra en auditoría toda creación, modificación o desactivación de usuarios, incluyendo quién realizó el cambio, qué campo se modificó y los valores anterior y nuevo.

**Control** Interceptar toda operación de escritura sobre usuarios y generar el registro de auditoría antes de confirmar la transacción.

**Aceptación** - Toda modificación genera un registro de auditoría sin excepción. - El registro incluye usuario responsable, fecha/hora, campo y valores. - Los registros de auditoría son de solo lectura; no pueden eliminarse ni modificarse.

**Estado observado** Criterio por verificar. Hay avisos de modificaciones e historial académico. La auditoría de todos los campos de usuario requiere inspección y caso específico. Fuente SRC-03.

**Prueba** CP-RNF-3.5

### RNF-3.6 Desactivación sin eliminación de historial

**Requisito** Al desactivar un usuario, el sistema bloquea su acceso de forma inmediata pero conserva todo su historial de asistencia y registros faciales.

**Control** Cambiar el estado del usuario a inactivo, invalidar sesiones activas del usuario e impedir nuevos inicios de sesión, sin eliminar ningún dato asociado.

**Aceptación** - El acceso se bloquea en menos de 5 segundos tras la desactivación. - Los registros de asistencia del usuario desactivado siguen apareciendo en reportes históricos. - No se elimina ningún dato del usuario al desactivarlo. - El sistema siempre mantiene al menos un Coordinador activo.

**Estado observado** Integrado en código. SessionSecurityService comprueba cuenta y credencial activas. La desactivación preserva relaciones e historial. Fuente SRC-03.

**Prueba** CP-RNF-3.6

### RNF-3.7 Exportación del listado de usuarios

**Requisito** El sistema permite al Coordinador exportar el listado de usuarios filtrado en formato .xlsx.

**Control** Generar el archivo .xlsx usando la librería xlsx del proyecto con los datos del listado activo y entregarlo mediante expo-sharing.

**Aceptación** - El archivo contiene exactamente los registros del listado filtrado, sin omisiones ni extras. - El archivo se genera en menos de 5 segundos. - Los datos exportados no incluyen contraseñas ni descriptores biométricos.

**Estado observado** Criterio por verificar. La interfaz contiene exportación. Conservar el XLSX, filtros y conteo permite comprobar el resultado. Fuente SRC-03.

**Prueba** CP-RNF-3.7

## 7.4 Perfil y sesión

### RNF-4.1 Visualización de datos propios

**Requisito** Cada usuario puede consultar únicamente su propia información de perfil. Ningún usuario puede acceder al perfil de otro.

**Control** Recuperar los datos del usuario autenticado desde el servidor usando su token de sesión y renderizarlos en la pantalla de perfil.

**Aceptación** - La pantalla carga en menos de 2 segundos. - Un usuario nunca puede visualizar el perfil de otro usuario. - Los datos mostrados están actualizados al momento de la consulta.

**Estado observado** Criterio por verificar. Los perfiles propios aparecen en COO-08 y APR-07. La API toma la identidad autenticada. Fuente SRC-04.

**Prueba** CP-RNF-4.1

### RNF-4.2 Enmascaramiento del correo electrónico

**Requisito** El correo deberá mostrarse parcialmente enmascarado en perfiles, listados, notificaciones y exportaciones ordinarias. El ingreso del correo para recuperación o gestión autorizada es una operación explícita, no una exposición general del perfil.

**Control** Aplicar máscara consistente en presentación y minimizar campos retornados. Para recuperación, el usuario ingresa su correo; la confirmación de envío lo presenta enmascarado.

**Aceptación** Las vistas ordinarias no muestran el correo completo. Ninguna API sin permiso suficiente obtiene correos ajenos. La gestión del contacto requiere autorización explícita y registro de cambios.

**Estado observado** Diferencia con el criterio. El perfil coloca el correo completo en su campo de información. El enmascaramiento sigue siendo una diferencia de privacidad del baseline. Fuente SRC-04.

**Prueba** CP-RNF-4.2

### RNF-4.3 Cierre de sesión seguro

**Requisito** Al cerrar sesión, el sistema invalida el token en el servidor y elimina todos los datos sensibles almacenados localmente en el dispositivo.

**Control** Llamar al endpoint de cierre de sesión, invalidar el token en el servidor, limpiar expo-secure-store y redirigir al login.

**Aceptación** - El cierre de sesión se completa en menos de 1 segundo. - El botón "atrás" del dispositivo no permite regresar a pantallas autenticadas. - El token invalidado es rechazado en cualquier solicitud posterior. - Los datos locales sensibles son eliminados del dispositivo.

**Estado observado** Integrado en código. Existe logout con revocación de sid y limpieza del token del cliente. La limpieza de todos los stores debe comprobarse al cambiar de cuenta. Fuente SRC-04.

**Prueba** CP-RNF-4.3

### RNF-4.4 Cierre de sesión automático por inactividad

**Requisito** El sistema cierra automáticamente la sesión del usuario tras 30 minutos de inactividad para proteger el acceso no autorizado.

**Control** Monitorear el tiempo de inactividad del usuario; al alcanzar 30 minutos sin actividad, ejecutar el proceso de cierre de sesión seguro (RNF 4.3).

**Aceptación** - El cierre automático se ejecuta exactamente a los 30 minutos de inactividad. - Cualquier interacción del usuario reinicia el contador de inactividad. - El mensaje de sesión expirada se muestra al usuario antes de redirigirlo.

**Estado observado** Criterio por verificar. El JWT tiene expiración. No se aporta una ejecución que demuestre el criterio independiente de 30 minutos de inactividad. Fuente SRC-04.

**Prueba** CP-RNF-4.4

### RNF-4.5 Restricción de modificación de datos propios

**Requisito** Los usuarios con rol Aprendiz e Instructor no pueden modificar directamente sus datos personales desde la app. Solo el Coordinador puede actualizar esos datos.

**Control** Deshabilitar la edición de campos de datos personales para roles Aprendiz e Instructor; rechazar a nivel de API cualquier solicitud de actualización de datos personales de esos roles.

**Aceptación** - Los campos están deshabilitados visualmente para Aprendiz e Instructor. - La API rechaza peticiones de modificación de datos personales de esos roles con error 403. - El Coordinador puede editar datos de cualquier usuario desde el panel de gestión.

**Estado observado** Criterio por verificar. El perfil es de consulta y la edición administrativa está restringida. Probar cambios directos desde los otros roles. Fuente SRC-04.

**Prueba** CP-RNF-4.5

## 7.5 Reconocimiento y privacidad biométrica

### RNF-5.1 Detección de un único rostro en el encuadre

**Requisito** El sistema solo permite iniciar la captura facial cuando detecta exactamente un rostro en el encuadre. No acepta capturas con cero o más de un rostro.

**Control** Ejecutar detección facial en tiempo real con @vladmandic/human; validar que el conteo de rostros detectados sea exactamente 1 antes de habilitar la captura.

**Aceptación** - La detección de rostros se ejecuta en tiempo real sin superar 500 ms por frame. - El sistema bloquea la captura si detecta 0 o 2+ rostros. - El mensaje de error indica claramente la causa.

**Estado observado** Criterio por verificar. La cámara y el registro funcionan según el equipo. Los controles de uno o varios rostros se verifican en los casos de rechazo. Fuente SRC-05.

**Prueba** CP-RNF-5.1

### RNF-5.2 Calidad mínima de captura facial

**Requisito** El sistema valida que cada captura cumpla condiciones mínimas de iluminación y nitidez antes de extraer los descriptores faciales.

**Control** Evaluar la calidad de la imagen capturada mediante los scores de confianza de @vladmandic/human antes de extraer descriptores. Rechazar capturas con score inferior al umbral definido.

**Aceptación** - Las capturas con score de calidad menor al umbral son rechazadas automáticamente. - El umbral de calidad es configurable. - El mensaje de error indica la causa específica del rechazo.

**Estado observado** Criterio por verificar. Existen controles de calidad y vida. El conjunto de iluminación y nitidez aceptado debe quedar identificado en la prueba. Fuente SRC-05.

**Prueba** CP-RNF-5.2

### RNF-5.3 Registro facial con múltiples capturas

**Requisito** El registro facial deberá incluir dos retos distintos del catálogo activo y siete imágenes por reto, con evidencia de vida de la misma persona.

**Control** Validar la secuencia y sus retos en el servidor. Conservar una referencia compatible con modelo, dimensión y versión y rechazar retos retirados o secuencias incompletas.

**Aceptación** La secuencia incompleta, el reto repetido o un código retirado se rechazan. La confirmación corresponde al titular y requiere una respuesta válida del servidor. El tiempo de ejecución se registra como medición independiente.

**Estado observado** Integrado en código. HU-45 usa dos retos distintos y siete imágenes por reto entre MOVE_UP, MOVE_DOWN, MOVE_CLOSER y MOVE_AWAY. APR-05 muestra la fase de validación. Fuente SRC-05.

**Prueba** CP-RNF-5.3

### RNF-5.4 Almacenamiento encriptado de descriptores faciales

**Requisito** Los descriptores biométricos deberán protegerse en reposo y en tránsito. Las imágenes de captura solo se usarán de forma transitoria para extracción y validación; no se conservará la imagen original ni se utilizará como foto de perfil.

**Control** Cifrar el transporte antes de enviar imágenes temporales y el descriptor antes de su primera transmisión cuando la extracción sea local. Cifrar el descriptor persistido con gestión de claves; descartar imágenes y temporales al terminar o fallar. Si se usa búsqueda vectorial en servidor, su diseño debe cumplir DEC-03 sin tratar un vector legible como cifrado.

**Aceptación** No hay imágenes originales en DB, disco, caché durable, respuestas o logs después del procesamiento. Los descriptores no quedan legibles en reposo sin la clave autorizada. Se verifica borrado de temporales, cifrado y acceso por titular/servicio.

**Estado observado** Diferencia con el criterio. La base usa pgvector y la revisión debe demostrar cifrado en reposo, retención y borrado. El uso de un vector no prueba cifrado. Fuente SRC-05.

**Prueba** CP-RNF-5.4

### RNF-5.5 Umbral configurable de similitud facial

**Requisito** El umbral de similitud mínima para aceptar una identificación facial es configurable por el Coordinador, con un valor por defecto de 0.6.

**Control** Validar que el nuevo valor esté dentro del rango permitido (0.4 - 0.9); actualizar el parámetro en el servidor sin necesidad de reinicio del servicio.

**Aceptación** - El umbral acepta valores entre 0.4 y 0.9 únicamente. - El cambio se aplica inmediatamente a las identificaciones posteriores. - Valores fuera del rango son rechazados con mensaje de error.

**Estado observado** Diferencia con el criterio. El servicio configura facial_match_threshold=0.65 con rango técnico 0..1. El panel institucional versionado del baseline requiere desarrollo y aceptación específicos. Fuente SRC-05.

**Prueba** CP-RNF-5.5

### RNF-5.6 Transmisión segura de datos de identificación

**Requisito** Los datos de reconocimiento deberán transmitirse exclusivamente por HTTPS/TLS entre cliente, servidor y servicio facial, con integridad y autenticación del origen.

**Control** Rechazar HTTP para endpoints biométricos, validar firma o mecanismo equivalente de integridad aprobado para el mensaje y limitar aceptación a dispositivos/servicios autorizados.

**Aceptación** Una transmisión biométrica por HTTP es rechazada con 403. Firma inválida se descarta y audita. UUID, puntaje o fecha arbitrarios no acreditan reconocimiento; verificar configuración productiva y de estaciones.

**Estado observado** Diferencia con el criterio. Caddy publica HTTPS válido. La comunicación backend-facial se configura por HTTP en una red privada Docker con clave de servicio. TLS entre todos los saltos es un objetivo adicional. Fuente SRC-05.

**Prueba** CP-RNF-5.6

### RNF-5.7 Sincronización offline de registros faciales

**Requisito** Si no hay conexión al momento de la identificación, los datos se almacenan localmente en la Raspberry Pi de forma encriptada y se sincronizan automáticamente al restablecer la conexión.

**Control** Encolar los datos de identificación localmente con cifrado; monitorear la conectividad; ejecutar sincronización automática al detectar conexión; eliminar la copia local tras confirmación del servidor.

**Aceptación** - Los datos locales están encriptados durante el almacenamiento temporal. - La sincronización se ejecuta automáticamente sin intervención manual. - La cola local no supera 24 horas de registros acumulados sin alerta al Coordinador. - Los datos locales se eliminan tras confirmación de sincronización exitosa.

**Estado observado** Ampliación futura. La entrega vigente opera conectada desde navegador y servicios. Raspberry Pi y cola facial offline quedan como ampliación futura. Fuente SRC-05.

**Prueba** CP-RNF-5.7

## 7.6 Asistencia y validaciones

### RNF-6.1 Registro automático de asistencia

**Requisito** El sistema registra automáticamente la asistencia del usuario al completar una identificación facial exitosa, sin requerir ninguna acción adicional del usuario ni del instructor.

**Control** Al recibir la identificación exitosa, recuperar el horario activo del ambiente, calcular el estado de asistencia y crear el registro en la base de datos en menos de 2 segundos.

**Aceptación** - El registro se crea en menos de 2 segundos tras la identificación. - No puede existir más de un registro de entrada para el mismo usuario en la misma sesión. - El registro incluye todos los campos requeridos sin excepción.

**Estado observado** Criterio por verificar. El equipo confirma asistencia y la API persiste eventos. El tiempo máximo del criterio requiere medición. Fuente SRC-06.

**Prueba** CP-RNF-6.1

### RNF-6.2 Clasificación automática del estado de asistencia

**Requisito** El servidor deberá clasificar puntualidad, retardo y ausencia según sesión efectiva y su ventana de registro, no según estado declarado por el cliente.

**Control** Permitir tolerancia inclusiva entre 0 y 30 minutos; validar salida posterior al final de ventana; usar hora confiable y calendario efectivo.

**Aceptación** Clasificación por registro en menos de 500 ms. Hasta el límite de puntualidad inclusive es puntual; después y antes de salida es tardío. Ausencia se determina solo para sesión aplicable y no cancelada; excepción activa cambia el cálculo sin alterar silenciosamente hechos.

**Estado observado** Criterio por verificar. La clasificación usa sesiones y ventanas de registro. APR-03 muestra retraso. Las fronteras E, E+T, S y A requieren sus casos específicos. Fuente SRC-06.

**Prueba** CP-RNF-6.2

### RNF-6.3 Inmutabilidad de registros de asistencia

**Requisito** Los hechos de asistencia serán inmutables. Solo el coordinador autorizado podrá anular con motivo documentado; excusas se registrarán como anotaciones separadas y trazables sin sobrescribir hora o resultado original.

**Control** Denegar UPDATE/DELETE ordinarios del hecho; guardar anulación o anotación con autor, fecha y motivo y mostrar estado original y ajuste.

**Aceptación** Aprendiz o instructor no modifica/elimina el hecho ni anula por API. Anulación sin justificación se rechaza. Auditoría conserva original y decisión; permisos de base y servicio impiden eludir la regla.

**Estado observado** Criterio por verificar. Existen eventos y gestión de excusas. La anulación con motivo y preservación del hecho original debe demostrarse antes de cerrar el criterio. Fuente SRC-06.

**Prueba** CP-RNF-6.3

### RNF-6.4 Alerta por retrasos repetidos

**Requisito** El sistema genera una alerta automática al instructor cuando un aprendiz acumula más de 3 retrasos graves en el mismo mes.

**Control** Evaluar el acumulado de retrasos graves del aprendiz en el mes al crear cada registro de asistencia; si supera el umbral, generar la notificación automática al instructor.

**Aceptación** - La alerta se genera en menos de 5 segundos tras el registro que supera el umbral. - El umbral de retrasos graves es configurable por el Coordinador. - La alerta se envía al instructor correcto según la ficha del aprendiz. - No se generan alertas duplicadas para el mismo evento.

**Estado observado** Criterio por verificar. La alerta mensual al cuarto retraso grave y su umbral requieren una prueba y una definición de producto específicas. Fuente SRC-06.

**Prueba** CP-RNF-6.4

### RNF-6.5 Registro manual de asistencia como respaldo

**Requisito** Ante falla facial, el instructor autorizado podrá crear un registro manual identificado como tal y pendiente de validación del coordinador.

**Control** Persistir creador, motivo de respaldo, sesión, aprendiz y hora; comunicar pendientes al coordinador; separar registro manual de reconocimiento automático.

**Aceptación** Reportes distinguen manual/automático. Coordinador recibe pendientes y su decisión queda auditada. Registro incluye ID del instructor y no se aprueba cambiando origin o recognitionResult desde cliente.

**Estado observado** Criterio por verificar. El respaldo manual pendiente de aprobación se conserva como objetivo adicional. Esta entrega de capturas no documenta esa ejecución. Fuente SRC-06.

**Prueba** CP-RNF-6.5

## 7.7 Reportes y consultas

### RNF-7.1 Control de acceso en reportes por usuario

**Requisito** El sistema garantiza que cada rol solo puede consultar los reportes de asistencia que le corresponden: el Aprendiz solo ve los suyos, el Instructor los de sus fichas asignadas, y el Coordinador los de cualquier usuario.

**Control** Validar en el servidor que el usuario solicitante tiene permisos sobre el usuario consultado según la matriz de roles; rechazar la solicitud si no los tiene.

**Aceptación** - Un Aprendiz nunca puede consultar registros de otro usuario. - Un Instructor solo accede a reportes de aprendices en sus fichas asignadas. - El Coordinador accede a reportes de cualquier usuario. - La API rechaza solicitudes no autorizadas con error 403.

**Estado observado** Criterio por verificar. useAttendance filtra al aprendiz por identidad. La autorización definitiva depende de backend y debe comprobarse con consultas ajenas. Fuente SRC-07.

**Prueba** CP-RNF-7.1

### RNF-7.2 Rendimiento en generación de reportes

**Requisito** Los reportes de asistencia deben generarse y mostrarse en pantalla dentro de los tiempos de respuesta aceptables para garantizar una experiencia fluida.

**Control** Optimizar las consultas a la base de datos con índices sobre fecha, usuario y ficha; implementar paginación en el cliente para no cargar todos los registros de una vez.

**Aceptación** - Reporte de hasta 365 días carga en menos de 5 segundos. - Reporte de ficha con 40 aprendices y 90 días carga en menos de 5 segundos. - La paginación muestra máximo 50 registros por página.

**Estado observado** Criterio por verificar. La consulta de asistencia está operativa. Los volúmenes y tiempos del criterio requieren medición reproducible. Fuente SRC-07.

**Prueba** CP-RNF-7.2

### RNF-7.3 Exportación de reportes en formato Excel

**Requisito** El sistema permite exportar cualquier reporte de asistencia en formato .xlsx, con exactamente los datos visibles en pantalla según los filtros activos.

**Control** Generar el archivo .xlsx usando la librería xlsx del proyecto con los datos del reporte filtrado y compartirlo mediante expo-sharing.

**Aceptación** - El archivo contiene exactamente los registros del reporte filtrado. - El archivo se genera en menos de 5 segundos. - El archivo no contiene datos de otros usuarios no incluidos en el reporte visible.

**Estado observado** Criterio por verificar. INS-01 muestra botones Excel y CSV. La evidencia del archivo es necesaria para cotejar contenido y filtros. Fuente SRC-07.

**Prueba** CP-RNF-7.3

### RNF-7.4 Alerta visual de asistencia crítica en reporte de ficha

**Requisito** En el reporte de asistencia por ficha, los aprendices con porcentaje de asistencia inferior al 80% se resaltan visualmente para facilitar la identificación de casos de riesgo.

**Control** Calcular el porcentaje de asistencia de cada aprendiz al generar el reporte; aplicar resaltado visual y/o icono de alerta a los que estén por debajo del umbral configurado.

**Aceptación** - Los aprendices con asistencia < 80% siempre se resaltan en el reporte. - El umbral de alerta es configurable por el Coordinador. - La distinción visual no depende únicamente del color (accesibilidad WCAG 2.1).

**Estado observado** Criterio por verificar. La interfaz tiene indicadores por estado. El umbral de alerta crítica configurable se evalúa como criterio específico. Fuente SRC-07.

**Prueba** CP-RNF-7.4

### RNF-7.5 Vista de calendario de asistencia

**Requisito** El historial de asistencia se visualiza en un calendario mensual que permite identificar el estado de cada día de forma inmediata mediante código de color e icono.

**Control** Cargar los registros de asistencia del mes seleccionado; mapear cada fecha a su estado correspondiente; renderizar el calendario con colores e iconos; al seleccionar un día, mostrar el detalle del registro en la misma pantalla.

**Aceptación** - El calendario del mes actual carga en menos de 2 segundos. - La navegación entre meses no recarga la pantalla completa. - Los estados se distinguen por color e icono simultáneamente para accesibilidad. - El detalle del día seleccionado incluye hora, estado, ambiente e instructor.

**Estado observado** Criterio por verificar. Los reportes derivan datos de useAttendance. El calendario debe cotejarse con matriz y archivo para el mismo periodo. Fuente SRC-07.

**Prueba** CP-RNF-7.5

## 7.8 Notificaciones y entrega

### RNF-8.1 Generación automática de notificaciones por eventos

**Requisito** El sistema genera notificaciones automáticas ante eventos definidos: registro de asistencia, retrasos graves, ausencias, fallos de identificación facial y desincronización de Raspberry Pi.

**Control** Detectar el evento disparador; determinar los destinatarios según el tipo de evento y los roles; crear la notificación en el servidor y entregarla a la app del destinatario.

**Aceptación** - Las notificaciones se generan en menos de 3 segundos tras el evento. - El sistema nunca pierde una notificación generada aunque falle la entrega push. - No se generan notificaciones duplicadas para el mismo evento. - Cada notificación contiene información suficiente para entender el evento sin navegar a otra pantalla.

**Estado observado** Criterio por verificar. COO-07 y APR-06 muestran notificaciones de eventos. Los avisos de sincronización Raspberry pertenecen al alcance futuro. Fuente SRC-08.

**Prueba** CP-RNF-8.1

### RNF-8.2 Persistencia y disponibilidad de notificaciones

**Requisito** Las notificaciones se almacenan en el servidor y se sincronizan con la app del usuario. Se conservan por un máximo de 30 días y son accesibles en modo offline.

**Control** Mantener caché local de las últimas 50 notificaciones en el dispositivo; sincronizar con el servidor al recuperar conexión; eliminar automáticamente notificaciones con más de 30 días de antigüedad.

**Aceptación** - El centro de notificaciones carga en menos de 1.5 segundos. - En modo offline muestra al menos las últimas 50 notificaciones en caché. - Las notificaciones de más de 30 días se eliminan automáticamente. - El badge de no leídas se actualiza en tiempo real.

**Estado observado** Criterio por verificar. Las bandejas muestran retención de 30 días y persistencia de lectura. El acceso offline durable necesita prueba específica. Fuente SRC-08.

**Prueba** CP-RNF-8.2

### RNF-8.3 Límite de envío de correos de notificación

**Requisito** El sistema limita el envío de correos de notificación a un máximo de 5 por hora por usuario para prevenir saturación del correo. Los correos nunca contienen datos biométricos ni contraseñas.

**Control** Llevar un contador de correos enviados por usuario por hora; si se alcanza el límite, encolar el envío para la siguiente hora disponible; registrar el intento y el estado en auditoría.

**Aceptación** - El sistema no supera 5 correos por hora por usuario bajo ninguna circunstancia. - Los correos descartados por límite quedan en cola y se envían en la siguiente ventana. - Ningún correo contiene datos biométricos ni contraseñas. - El estado de cada envío (exitoso/fallido/en cola) queda registrado en auditoría.

**Estado observado** Criterio por verificar. SMTP está operativo según el equipo. La cuota de cinco por hora y ausencia de secretos se comprueban mediante evidencia de entrega. Fuente SRC-08.

**Prueba** CP-RNF-8.3

### RNF-8.4 Reintentos de entrega de notificaciones fallidas

**Requisito** El sistema reintenta automáticamente la entrega de notificaciones push que hayan fallado, usando backoff exponencial, sin generar duplicados.

**Control** Registrar el fallo de entrega; programar reintentos con backoff exponencial (1s, 2s, 4s); tras 3 fallos consecutivos, marcar la notificación como no entregada vía push pero mantenerla disponible en la bandeja.

**Aceptación** - No se generan notificaciones duplicadas por los reintentos. - Tras 3 fallos de entrega push la notificación sigue disponible en la bandeja. - El backoff exponencial entre reintentos es respetado.

**Estado observado** Criterio por verificar. El sistema dispone de entrega SMTP y bandeja. El backoff push especificado en el baseline se conserva como objetivo adicional de canal. Fuente SRC-08.

**Prueba** CP-RNF-8.4

# 8 Verificación y aceptación

## 8.1 Condiciones de ejecución

Las pruebas se realizarán con cuentas de cada rol, fichas propias y ajenas, dispositivos autorizados/no autorizados, sesiones vigentes y casos de falla. La base se crea con migraciones del proyecto; se documentan versiones de aplicación, modelo facial, configuración, volumen, dispositivo y conectividad. Los datos biométricos de prueba deben usarse con autorización y protección, y eliminarse conforme a la política de prueba.

## 8.2 Identificación de pruebas

A cada requisito se asocia CP seguido de su ID, por ejemplo CP-RF-7.1 o CP-RNF-5.5. Un caso puede tener variantes A flujo normal, B entradas inválidas, C permiso/propiedad, D falla/concurrencia y E rendimiento. Esta convención permite ampliar casos sin renumerar los requisitos.

| Familia | Preparación y ejecución | Resultado esperado |
|---|---|---|
| Acceso y sesión | Login válido/inválido repetido; reutilizar token tras logout, rol o desactivación; 30 min inactivo. | Contador durable, bloqueo, permisos vigentes, rechazo del token y cierre por inactividad. |
| Académico y CSV | Archivo válido, tipos mezclados, tildes/ü/ñ, duplicados, referencias faltantes y fallo antes del commit. | Resumen correcto, integridad, relaciones consistentes, ningún secreto y recuperación sin parcialidad. |
| Traslado | Destino inválido, falla entre cambios y dos traslados concurrentes. | Origen intacto al fallar; una ficha activa al confirmar; historial de decisión. |
| Facial | Cero/dos rostros, secuencias incompletas, fotografía/replay, reto usado/vencido, UUID ajeno. | Rechazo sin registro aprobado; referencia válida y protegida solo para titular autorizado. |
| Sesión y asistencia | Límites E, E+T, S, A; sesión cancelada; duplicado entrada/salida; evento directo sin verificación. | Estados correctos, conflictos controlados, tiempo confiable y ausencia de bypass. |
| Consultas y reportes | Mismo evento en matriz/historial/calendario/XLSX; filtros y rol ajeno. | Igualdad de valores, denominadores claros, 403 fuera de alcance y exportación exacta. |
| Notificaciones | Evento repetido, caída SMTP/push, sexto correo, 30 días, offline y solicitud facial. | Persistencia, no duplicados, límite y backoff/caché, decisión durable independiente de lectura. |
| Operación y calidad | Volúmenes establecidos, reconexión, recuperación y base nueva. | Umbrales verificables; versiones/configuración registradas; contratos y migraciones coincidentes. |

## 8.3 Evidencia requerida

- Resultado por caso con fecha, ejecutor, versión, datos de entrada, resultado esperado/obtenido y estado.
- Para seguridad: petición/respuesta y evidencia de que no hubo modificación o exposición indebida.
- Para rendimiento: volumen, condiciones, medición y percentiles cuando el criterio los requiera.
- Para persistencia/rollback: estado de base antes y después y comprobación desde otra sesión/dispositivo.
- Para biometría: condiciones de captura, resultado de calidad/vida y metodología aprobada; ninguna evidencia pública debe contener secretos o rostros sin autorización.

## 8.4 Regla de aceptación

Un requisito se marca Conforme únicamente cuando todas sus variantes aplicables satisfacen los criterios y la evidencia es consultable. Compilación, análisis estático o presencia de endpoint son verificaciones auxiliares. Una decisión pendiente que modifica el criterio se resuelve y versiona antes de la aceptación. La entrega académica del documento no equivale a habilitar un despliegue productivo.

# 9 Decisiones y restricciones de implantación

## DEC-01 Identidad y permisos del Coordinador de Registro

Mantenerlo como rol diferenciado, sin administración implícita. Definir operaciones permitidas y responsables de asignación.

**Responsable** Responsable académico/producto. **Requisitos** RF-3.3, RF-3.5, RNF-1.16. **Estado** Por validar institucionalmente.

## DEC-02 Activación y entrega de credenciales

No retornar contraseña al coordinador ni en CSV. Establecer activación de un uso o entrega protegida al titular compatible con la prohibición de contraseñas en correo ordinario.

**Responsable** Responsable de producto y seguridad. **Requisitos** RF-3.4, RNF-3.3, RNF-8.3. **Estado** Por validar institucionalmente.

## DEC-03 Contrato facial y protección del descriptor

Seleccionar un flujo oficial, modelo/dimensión/consolidación y diseño de búsqueda compatible con cifrado. No conservar imágenes. Definir claves, consentimiento, retención y eliminación de descriptores/auditoría.

**Responsable** Responsable técnico y de datos. **Requisitos** RF-5.1, RNF-5.3, RNF-5.4. **Estado** Por validar institucionalmente.

## DEC-04 Dispositivos y alcance offline

Definir estación fija/móvil, identidad de dispositivo y si Raspberry/offline integra la entrega operativa. Si se difiere, mantener RNF-5.7 en alcance futuro explícito.

**Responsable** Responsable académico y técnico. **Requisitos** RF-C2, RNF-5.6, RNF-5.7. **Estado** Por validar institucionalmente.

## DEC-05 Metas operativas

Aprobar horario, disponibilidad, volúmenes, RPO/RTO, copias y recuperación. No asignar porcentajes o compromisos no acordados.

**Responsable** Responsable de operación/producto. **Requisitos** RNF-1.13, RNF-2.6, RNF-2.12. **Estado** Por validar institucionalmente.

## DEC-06 Parámetros de seguridad y evaluación

Definir límite de códigos de recuperación, expiración/usos de re-registro, criterio de retraso grave y conjunto/métricas de validación biométrica. Registrar política antes de pruebas.

**Responsable** Responsable de seguridad y académico. **Requisitos** RF-1.4, RF-5.4, RNF-6.4. **Estado** Por validar institucionalmente.

## Restricciones de despliegue

La versión implantada deberá utilizar secretos externos al código y cliente público, conexiones protegidas, migraciones controladas y respaldo verificable. Los contratos biométricos antiguos no compatibles no se expondrán como flujo alternativo sin autorización. La aplicación no sustituirá una falla remota con datos o aprobaciones de demostración.

# 10 Glosario y referencias

| Término | Definición |
|---|---|
| SRS o ERS | Especificación de requisitos de software. |
| RF y RNF | Requisito funcional y requisito no funcional. |
| Ficha | Grupo académico vinculado a un programa; Chip en el código. |
| Aprendiz | Persona matriculada; posee UUID propio relacionado con la cuenta. |
| Sesión | Jornada de asistencia con ficha, ambiente, responsables, dispositivo y tiempos. |
| Descriptor o embedding | Representación numérica del rostro; dato biométrico que requiere protección. |
| Validación de vida | Evaluación de evidencia de captura real frente a fotografía/replay/suplantación. |
| Umbral | Similitud mínima para aceptar coincidencia; no es porcentaje de precisión del sistema. |
| Token | Credencial de sesión firmada, temporal y revocable. |
| RBAC y alcance | Permiso por rol más autorización sobre el recurso específico. |
| Commit y rollback | Confirmación o reversión de una transacción de cambios. |
| Idempotencia | Repetir una operación no produce efectos duplicados. |
| RPO y RTO | Objetivos de pérdida de datos y tiempo de recuperación que debe aprobar operación. |
| Baseline | Versión y configuración usadas como referencia de verificación. |

Referencias documentales: SRS_V3_completo_y_trazable.pdf, versión 3.0, 92 páginas; VALIDACION_SRS.md, revisión del 13 de octubre de 2026; repositorios locales FaceLit, FaceLit-Backend, FaceLit-DB y micro-facial. El documento previo cita IEEE 830 como orientación de estructura; esta versión no afirma una certificación normativa. Los lineamientos institucionales de datos, retención y operación se incorporan mediante las decisiones registradas. La justificación no conserva cifras estadísticas sin fuente verificable. Los nombres del equipo, instructor, programa y ficha proceden de la portada suministrada. Se omiten correos personales del equipo porque no son necesarios para evaluar la especificación.

# 11 Trazabilidad actual por requisito

Revisión documental al 4 de noviembre de 2026. Se conservan los 97 identificadores del baseline. RF-C1 está retirado del alcance vigente y RNF-5.7 se identifica como ampliación futura. Los estados distinguen el criterio escrito de la evidencia disponible.

| Estado | Significado |
|---|---|
| Operativo confirmado | El equipo confirmó la función en el sistema. Los criterios especializados se verifican por caso. |
| Evidencia visual | Las capturas muestran el comportamiento indicado en la fila. |
| Integrado en código | Se localiza la cadena de interfaz, API o persistencia descrita. |
| Integrado con criterio adicional | Hay operación implementada y una condición del baseline que requiere trabajo o evidencia adicional. |
| Criterio por verificar | La aceptación requiere una ejecución, medición o decisión específica. |
| Diferencia con el criterio | La inspección identifica una diferencia concreta respecto de la exigencia escrita. |
| Objetivo adicional | La capacidad pertenece al baseline objetivo y necesita definición o implementación adicional. |
| Retirado del alcance vigente | El identificador se conserva por trazabilidad del alcance anterior. |
| Ampliación futura | Capacidad prevista para una extensión de la entrega conectada actual. |

## 11.1 Fuentes y revisiones

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

Los caminos backend son relativos a FaceLit-Backend/src/main/java/com/FaceLit/backend. Los identificadores de captura se resuelven en el catálogo de la carpeta 07. Las capturas documentan 16 vistas únicas y no identifican por sí solas el SHA del servidor.

## 11.2 Requisitos funcionales

| ID | Estado | Evidencia y criterio restante | Caso |
|---|---|---|---|
| RF-1.1 | Operativo confirmado | El equipo confirma login en facelit.tech. LoginServiceImpl resuelve documento y también correo. El acceso exclusivamente por documento permanece como criterio por alinear con RNF-1.10. SRC-01. | CP-RF-1.1 |
| RF-1.2 | Integrado en código | SecurityConfig y los servicios aplican permisos por rol y alcance. La revisión completa de solicitudes con identificadores ajenos requiere CP-RF-1.2. SRC-01. | CP-RF-1.2 |
| RF-1.3 | Integrado en código | RoleName contiene APPRENTICE, INSTRUCTOR y COORDINATOR. Los layouts redirigen por rol. El perfil de registro diferenciado es una propuesta del baseline. SRC-01. | CP-RF-1.3 |
| RF-1.4 | Operativo confirmado | El equipo confirma recuperación y correo. Las rutas request-recovery, verify-token y reset-password están conectadas. Los ensayos de abuso y concurrencia se registran por separado. SRC-01. | CP-RF-1.4 |
| RF-2.1 | Operativo confirmado | El equipo confirma carga CSV y gestión académica. COO-03 muestra programas cargados y COO-07 alertas de referencias inválidas. La captura del formulario no aporta por sí sola un resumen de importación exitosa. SRC-02. | CP-RF-2.1 |
| RF-2.1.1 | Evidencia visual | COO-04 muestra selección de CSV, guía de columnas y límites de 20 MB y 5.000 filas. El controlador ofrece la descarga de plantilla. SRC-02. | CP-RF-2.1.1 |
| RF-2.2 | Integrado en código | Programas, fichas, instructores y aprendices usan servicios persistentes. COO-03 muestra consulta. Se conserva el criterio de identidad inmutable frente a la edición administrativa actualmente disponible. SRC-02. | CP-RF-2.2 |
| RF-2.3 | Integrado en código | UserChipServiceImpl y pending-transfers implementan traslado y resolución. La atomicidad bajo fallo y concurrencia se evalúa con CP-RF-2.3. SRC-02. | CP-RF-2.3 |
| RF-3.1 | Evidencia visual | COO-02 muestra 3.640 usuarios, buscador y filtros por rol y estado. El volumen visible corresponde al momento de la captura. SRC-03. | CP-RF-3.1 |
| RF-3.2 | Integrado en código | UserManagementServiceImpl consulta y modifica cuentas. El servicio admite actualizar el documento, por lo que el criterio de inmutabilidad requiere una decisión de producto. SRC-03. | CP-RF-3.2 |
| RF-3.3 | Objetivo adicional | El alta administrativa actual permite COORDINATOR. El Coordinador de Registro diferenciado del baseline requiere DEC-01 y una implementación propia. SRC-03. | CP-RF-3.3 |
| RF-3.4 | Integrado con criterio adicional | InitialCredentialServiceImpl genera y cifra la credencial y entrega el acceso tras commit. Persisten campos legacy de contraseña en DTO académicos. Su presencia exige comprobar las respuestas efectivas antes de declarar cumplida la prohibición de exposición. SRC-03. | CP-RF-3.4 |
| RF-3.5 | Objetivo adicional | Los roles asignables se validan en servidor. El perfil separado de registro no está en RoleName y se conserva como decisión de alcance. SRC-03. | CP-RF-3.5 |
| RF-3.6 | Integrado en código | El estado de cuenta se conserva y SessionSecurityService comprueba cuenta, credencial, rol y sesión persistida al validar el token. SRC-01. | CP-RF-3.6 |
| RF-4.1 | Evidencia visual | COO-08 y APR-07 muestran perfil por titular. El perfil presenta el correo completo en el código revisado. El enmascaramiento del baseline es un criterio de privacidad por alinear. SRC-04. | CP-RF-4.1 |
| RF-4.2 | Integrado en código | useUserSettings y el backend persisten preferencias. El cliente mapea ES, EN, DE y FR. Language incluye esos valores y PR como compatibilidad. SRC-04. | CP-RF-4.2 |
| RF-5.1 | Operativo confirmado | El equipo confirma cámara y registro facial. APR-04 a APR-06 muestran preparación, validación y aviso de finalización en capturas separadas. El flujo vigente usa dos retos distintos y siete imágenes por reto. SRC-05. | CP-RF-5.1 |
| RF-5.2 | Integrado en código | environmentSessionApi y EnvironmentServiceImpl preparan ficha, ambiente, dispositivo, responsables y tiempos de una sesión autorizada. SRC-06. | CP-RF-5.2 |
| RF-5.3 | Integrado con criterio adicional | La configuración del servicio facial usa similitud 0.65 y rango técnico 0..1. La administración institucional versionada y su panel siguen como objetivo de aceptación específico. SRC-05. | CP-RF-5.3 |
| RF-5.4 | Integrado en código | FaceResetRequest y su repositorio conservan solicitudes. Los servicios gestionan decisión y autorización para reemplazo. APR-06 muestra el aviso de respuesta y registro completado. SRC-05. | CP-RF-5.4 |
| RF-6.1 | Operativo confirmado | El equipo confirma asistencia facial. El flujo usa sesión y eventos persistidos. La captura de cámara disponible acredita la fase de validación del registro facial del aprendiz. SRC-06. | CP-RF-6.1 |
| RF-6.2 | Integrado en código | La sesión transmite entryTime, registrationMinutes, exitTime y shutdownTime. El servidor aplica las reglas temporales. Las fronteras exactas y duplicados se verifican en CP-RF-6.2. SRC-06. | CP-RF-6.2 |
| RF-7.1 | Evidencia visual | INS-01 muestra matriz por ficha para el 4 de noviembre, leyenda de estados y controles de exportación. COO-06 muestra el selector inicial de programa. SRC-07. | CP-RF-7.1 |
| RF-7.2 | Evidencia visual | APR-03 muestra una consulta individual con un registro de retraso y 100 % de asistencia para el rango seleccionado. APR-02 conserva el estado previo sin fechas. SRC-07. | CP-RF-7.2 |
| RF-7.3 | Integrado en código | useAttendanceRF6 deriva el historial desde useAttendance, que consulta attendance-matrix. La descripción anterior de fuente exclusivamente local quedó desactualizada. SRC-07. | CP-RF-7.3 |
| RF-8.1 | Evidencia visual | COO-07 y APR-06 muestran avisos por categorías, seguridad, CSV y registro facial. La cobertura de cada evento se comprueba con su caso de aceptación. SRC-08. | CP-RF-8.1 |
| RF-8.2 | Evidencia visual | Las bandejas muestran filtros de lectura y categoría, contadores y el aviso de retención de 30 días. SRC-08. | CP-RF-8.2 |
| RF-8.3 | Operativo confirmado | El equipo confirma correo SMTP. Los listeners de entrega y recuperación están en backend. Las cuotas y tiempos del baseline necesitan mediciones específicas. SRC-08. | CP-RF-8.3 |
| RF-8.4 | Integrado en código | La solicitud facial se persiste y su decisión produce avisos. APR-06 contiene la respuesta al aprendiz y el aviso de registro completado. SRC-08. | CP-RF-8.4 |
| RF-9.1 | Integrado en código | Las consultas usan useAttendance y la matriz de API. INS-01 muestra controles Excel y CSV. La igualdad del archivo descargado con filtros y permisos necesita el archivo de evidencia. SRC-07. | CP-RF-9.1 |
| RF-C1 | Retirado del alcance vigente | Las rutas de gestión de horarios y excepciones fueron retiradas. El ID se conserva para rastrear el baseline. Los tiempos operativos se definen en la sesión de ambiente. SRC-06. | CP-RF-C1 |
| RF-C2 | Evidencia visual | COO-05 muestra el catálogo de ambientes cargado. SecurityConfig permite GET y POST de ambientes a instructor y coordinador. Editar, desactivar y vincular fichas corresponde al coordinador. Las sesiones corresponden al instructor. SRC-06. | CP-RF-C2 |
| RF-C3 | Integrado en código | Las preferencias del titular se guardan en API. El mapeo actual incluye alemán y francés. La recuperación en otro dispositivo requiere el caso específico de persistencia. SRC-04. | CP-RF-C3 |
| RF-C4 | Integrado en código | realtime.ts y el manejador WebSocket intercambian eventos de actualización con autenticación. La prueba técnica de handshake está registrada en despliegue. Recuperación y revocación del canal necesitan su evidencia específica. SRC-08. | CP-RF-C4 |

## 11.3 Requisitos no funcionales

| ID | Estado | Evidencia y criterio restante | Caso |
|---|---|---|---|
| RNF-1.1 | Criterio por verificar | BCrypt, JWT y HTTPS público están presentes. El acceso privado al microservicio usa la red Docker y clave interna. SRC-01. | CP-RNF-1.1 |
| RNF-1.2 | Criterio por verificar | Existe validación de longitud y complejidad. Revisar cambio inicial, recuperación y rotación con la misma política. SRC-01. | CP-RNF-1.2 |
| RNF-1.3 | Integrado en código | Login usa bloqueo de credencial y @Transactional(noRollbackFor = LoginException.class). El hallazgo histórico de rollback ya no describe este método. SRC-01. | CP-RNF-1.3 |
| RNF-1.4 | Criterio por verificar | SecurityConfig diferencia operaciones de coordinación, instructor y aprendiz. Se requieren variantes por recurso ajeno para el criterio completo. SRC-01. | CP-RNF-1.4 |
| RNF-1.5 | Criterio por verificar | Las rutas de autoservicio y los servicios de asistencia aplican alcance. La comparación de identificadores propios y ajenos pertenece al caso negativo. SRC-01. | CP-RNF-1.5 |
| RNF-1.6 | Criterio por verificar | Se observan consentimiento, control de sesión y permisos. La política de retención y eliminación biométrica requiere responsable y evidencia propia. SRC-01. | CP-RNF-1.6 |
| RNF-1.7 | Criterio por verificar | Existe actualización administrativa. El cambio de documento permitido por el servicio debe alinearse con la regla de identidad del baseline. SRC-01. | CP-RNF-1.7 |
| RNF-1.8 | Criterio por verificar | Hay ChangeHistory y sesiones persistidas. La cobertura de cada campo, motivo y operación debe verificarse por caso. SRC-01. | CP-RNF-1.8 |
| RNF-1.9 | Criterio por verificar | Hay recuperación, códigos y sesiones de recuperación. Duración, límite, reenvío, titular y consumo se verifican con solicitudes controladas. SRC-01. | CP-RNF-1.9 |
| RNF-1.10 | Diferencia con el criterio | El login visible solicita documento. LoginServiceImpl también busca por correo. La restricción exclusiva a documento sigue siendo una diferencia concreta. SRC-01. | CP-RNF-1.10 |
| RNF-1.11 | Integrado en código | JwtServiceImpl valida sid contra SessionSecurityService. Existe revocación de token y comprobación del estado vigente. SRC-01. | CP-RNF-1.11 |
| RNF-1.12 | Criterio por verificar | La operación del login está confirmada. Falta una serie de mediciones que demuestre el percentil exigido. SRC-01. | CP-RNF-1.12 |
| RNF-1.13 | Criterio por verificar | La publicación está operativa. Una respuesta HTTP correcta no mide disponibilidad durante el periodo acordado. SRC-01. | CP-RNF-1.13 |
| RNF-1.14 | Criterio por verificar | Hay formularios y mensajes por rol. La evaluación con usuarios y su registro de tareas corresponde a la aceptación de usabilidad. SRC-01. | CP-RNF-1.14 |
| RNF-1.15 | Integrado en código | Se observan controladores, servicios, repositorios y un servicio facial separado. SRC-01. | CP-RNF-1.15 |
| RNF-1.16 | Integrado en código | La validación de sesión coteja el rol persistido y estado actual. Los alias de interfaz deben mantenerse alineados con los tres roles de backend. SRC-01. | CP-RNF-1.16 |
| RNF-2.1 | Integrado en código | La escritura académica exige COORDINATOR. Los GET académicos autorizados de instructor tienen un alcance distinto. SRC-02. | CP-RNF-2.1 |
| RNF-2.2 | Criterio por verificar | DTO, servicios y restricciones de la base validan referencias y estados. La batería de errores se documenta por caso. SRC-02. | CP-RNF-2.2 |
| RNF-2.3 | Criterio por verificar | ChangeHistory conserva operaciones académicas. La cobertura completa del historial es un criterio adicional de revisión. SRC-02. | CP-RNF-2.3 |
| RNF-2.4 | Criterio por verificar | La interfaz y API manejan datos personales. El resumen y los DTO legacy deben revisarse para confirmar máscara y ausencia de secretos en cada respuesta. SRC-02. | CP-RNF-2.4 |
| RNF-2.5 | Criterio por verificar | CSV está operativo. COO-04 muestra los límites del formulario. La meta de 500 filas en menos de 10 s requiere cronometraje con condiciones registradas. SRC-02. | CP-RNF-2.5 |
| RNF-2.6 | Criterio por verificar | Las consultas cargan datos en las capturas. La disponibilidad requiere una ventana de observación y meta aprobadas. SRC-02. | CP-RNF-2.6 |
| RNF-2.7 | Criterio por verificar | COO-04 muestra guía previa y COO-07 avisos comprensibles de referencias inválidas. La prueba de comprensión requiere participantes y resultados. SRC-02. | CP-RNF-2.7 |
| RNF-2.8 | Criterio por verificar | CSV y formularios usan servicios de dominio. Comparar una misma entidad por ambos caminos verifica equivalencia. SRC-02. | CP-RNF-2.8 |
| RNF-2.9 | Criterio por verificar | Se observan validaciones de unicidad y restricciones SQL. La prueba concurrente requiere ejecución controlada. SRC-02. | CP-RNF-2.9 |
| RNF-2.10 | Criterio por verificar | El traslado se implementa transaccionalmente. La inyección de un fallo y traslados concurrentes comprueban su atomicidad. SRC-02. | CP-RNF-2.10 |
| RNF-2.11 | Criterio por verificar | Hay decisiones de traslados pendientes y ChangeHistory. Verificar el vínculo de la decisión a su carga y motivo. SRC-02. | CP-RNF-2.11 |
| RNF-2.12 | Criterio por verificar | COO-01 muestra 402 fichas y 3.640 usuarios. El frontend local consulta aprendices en lotes de hasta 80 fichas. Los tiempos bajo carga requieren medición. SRC-02. | CP-RNF-2.12 |
| RNF-2.13 | Criterio por verificar | La carga tiene tratamiento de filas y transacciones. Un ensayo de interrupción debe demostrar el estado final de la base. SRC-02. | CP-RNF-2.13 |
| RNF-2.14 | Criterio por verificar | CSV y capturas presentan tildes. Revisar también diéresis, ñ y normalización en alta y edición con los mismos datos. SRC-02. | CP-RNF-2.14 |
| RNF-3.1 | Criterio por verificar | COO-02 muestra listado y filtros con 3.640 resultados. Paginación y tiempo del criterio se evalúan aparte. SRC-03. | CP-RNF-3.1 |
| RNF-3.2 | Criterio por verificar | Existen comprobaciones y unicidad del documento. Probar duplicados por alta administrativa y CSV. SRC-03. | CP-RNF-3.2 |
| RNF-3.3 | Criterio por verificar | Se generan credenciales y se almacenan hashes. Los DTO conservan campos legacy. Comprobar contenido real de respuestas y exportaciones. SRC-03. | CP-RNF-3.3 |
| RNF-3.4 | Diferencia con el criterio | UserManagementServiceImpl permite asignar un nuevo documento en edición. El criterio de inmutabilidad sigue por alinear. SRC-03. | CP-RNF-3.4 |
| RNF-3.5 | Criterio por verificar | Hay avisos de modificaciones e historial académico. La auditoría de todos los campos de usuario requiere inspección y caso específico. SRC-03. | CP-RNF-3.5 |
| RNF-3.6 | Integrado en código | SessionSecurityService comprueba cuenta y credencial activas. La desactivación preserva relaciones e historial. SRC-03. | CP-RNF-3.6 |
| RNF-3.7 | Criterio por verificar | La interfaz contiene exportación. Conservar el XLSX, filtros y conteo permite comprobar el resultado. SRC-03. | CP-RNF-3.7 |
| RNF-4.1 | Criterio por verificar | Los perfiles propios aparecen en COO-08 y APR-07. La API toma la identidad autenticada. SRC-04. | CP-RNF-4.1 |
| RNF-4.2 | Diferencia con el criterio | El perfil coloca el correo completo en su campo de información. El enmascaramiento sigue siendo una diferencia de privacidad del baseline. SRC-04. | CP-RNF-4.2 |
| RNF-4.3 | Integrado en código | Existe logout con revocación de sid y limpieza del token del cliente. La limpieza de todos los stores debe comprobarse al cambiar de cuenta. SRC-04. | CP-RNF-4.3 |
| RNF-4.4 | Criterio por verificar | El JWT tiene expiración. No se aporta una ejecución que demuestre el criterio independiente de 30 minutos de inactividad. SRC-04. | CP-RNF-4.4 |
| RNF-4.5 | Criterio por verificar | El perfil es de consulta y la edición administrativa está restringida. Probar cambios directos desde los otros roles. SRC-04. | CP-RNF-4.5 |
| RNF-5.1 | Criterio por verificar | La cámara y el registro funcionan según el equipo. Los controles de uno o varios rostros se verifican en los casos de rechazo. SRC-05. | CP-RNF-5.1 |
| RNF-5.2 | Criterio por verificar | Existen controles de calidad y vida. El conjunto de iluminación y nitidez aceptado debe quedar identificado en la prueba. SRC-05. | CP-RNF-5.2 |
| RNF-5.3 | Integrado en código | HU-45 usa dos retos distintos y siete imágenes por reto entre MOVE_UP, MOVE_DOWN, MOVE_CLOSER y MOVE_AWAY. APR-05 muestra la fase de validación. SRC-05. | CP-RNF-5.3 |
| RNF-5.4 | Diferencia con el criterio | La base usa pgvector y la revisión debe demostrar cifrado en reposo, retención y borrado. El uso de un vector no prueba cifrado. SRC-05. | CP-RNF-5.4 |
| RNF-5.5 | Diferencia con el criterio | El servicio configura facial_match_threshold=0.65 con rango técnico 0..1. El panel institucional versionado del baseline requiere desarrollo y aceptación específicos. SRC-05. | CP-RNF-5.5 |
| RNF-5.6 | Diferencia con el criterio | Caddy publica HTTPS válido. La comunicación backend-facial se configura por HTTP en una red privada Docker con clave de servicio. TLS entre todos los saltos es un objetivo adicional. SRC-05. | CP-RNF-5.6 |
| RNF-5.7 | Ampliación futura | La entrega vigente opera conectada desde navegador y servicios. Raspberry Pi y cola facial offline quedan como ampliación futura. SRC-05. | CP-RNF-5.7 |
| RNF-6.1 | Criterio por verificar | El equipo confirma asistencia y la API persiste eventos. El tiempo máximo del criterio requiere medición. SRC-06. | CP-RNF-6.1 |
| RNF-6.2 | Criterio por verificar | La clasificación usa sesiones y ventanas de registro. APR-03 muestra retraso. Las fronteras E, E+T, S y A requieren sus casos específicos. SRC-06. | CP-RNF-6.2 |
| RNF-6.3 | Criterio por verificar | Existen eventos y gestión de excusas. La anulación con motivo y preservación del hecho original debe demostrarse antes de cerrar el criterio. SRC-06. | CP-RNF-6.3 |
| RNF-6.4 | Criterio por verificar | La alerta mensual al cuarto retraso grave y su umbral requieren una prueba y una definición de producto específicas. SRC-06. | CP-RNF-6.4 |
| RNF-6.5 | Criterio por verificar | El respaldo manual pendiente de aprobación se conserva como objetivo adicional. Esta entrega de capturas no documenta esa ejecución. SRC-06. | CP-RNF-6.5 |
| RNF-7.1 | Criterio por verificar | useAttendance filtra al aprendiz por identidad. La autorización definitiva depende de backend y debe comprobarse con consultas ajenas. SRC-07. | CP-RNF-7.1 |
| RNF-7.2 | Criterio por verificar | La consulta de asistencia está operativa. Los volúmenes y tiempos del criterio requieren medición reproducible. SRC-07. | CP-RNF-7.2 |
| RNF-7.3 | Criterio por verificar | INS-01 muestra botones Excel y CSV. La evidencia del archivo es necesaria para cotejar contenido y filtros. SRC-07. | CP-RNF-7.3 |
| RNF-7.4 | Criterio por verificar | La interfaz tiene indicadores por estado. El umbral de alerta crítica configurable se evalúa como criterio específico. SRC-07. | CP-RNF-7.4 |
| RNF-7.5 | Criterio por verificar | Los reportes derivan datos de useAttendance. El calendario debe cotejarse con matriz y archivo para el mismo periodo. SRC-07. | CP-RNF-7.5 |
| RNF-8.1 | Criterio por verificar | COO-07 y APR-06 muestran notificaciones de eventos. Los avisos de sincronización Raspberry pertenecen al alcance futuro. SRC-08. | CP-RNF-8.1 |
| RNF-8.2 | Criterio por verificar | Las bandejas muestran retención de 30 días y persistencia de lectura. El acceso offline durable necesita prueba específica. SRC-08. | CP-RNF-8.2 |
| RNF-8.3 | Criterio por verificar | SMTP está operativo según el equipo. La cuota de cinco por hora y ausencia de secretos se comprueban mediante evidencia de entrega. SRC-08. | CP-RNF-8.3 |
| RNF-8.4 | Criterio por verificar | El sistema dispone de entrega SMTP y bandeja. El backoff push especificado en el baseline se conserva como objetivo adicional de canal. SRC-08. | CP-RNF-8.4 |

# 12 Cambios de esta revisión y aceptación

Se revisaron individualmente los 34 identificadores funcionales y 63 no funcionales. Se actualizaron los estados del inventario y la matriz a partir del código local y las capturas entregadas. El baseline conserva objetivos adicionales de privacidad, seguridad, rendimiento y operación que deben aceptarse con evidencia propia.

## 12.1 Cambios respecto del documento anterior

- Se actualizó el contrato de registro facial a los dos retos y siete imágenes por reto de HU-45.
- Se documentaron los tres roles actuales y el alcance específico de gestión de ambientes y apertura de sesiones.
- Se actualizaron las fuentes de historial y reportes, la validación de sesiones JWT y el catálogo de idiomas.
- Se retiró RF-C1 del alcance operativo y se identificó RNF-5.7 como ampliación futura.
- Se conservaron las diferencias concretas del baseline sobre login por correo, identidad editable, exposición de datos, parámetros institucionales y métricas sin ejecución documentada.
- Se registraron los commits locales y los ajustes del paquete de despliegue, con su configuración separada de los repositorios remotos.

## 12.2 Evidencia de la entrega

El catálogo visual de la carpeta 07 contiene 8 capturas de coordinación, 1 captura única del instructor y 7 del aprendiz. Las dos imágenes originales del instructor eran idénticas. Las capturas de validación facial y del aviso de finalización se conservan como evidencias separadas. La imagen de CSV muestra el formulario, y las alertas muestran validación de referencias. El equipo confirmó por separado el funcionamiento de la carga.

Las cifras de pruebas automatizadas del informe de octubre pertenecen a aquellas ejecuciones. Esta revisión documental no ejecuta una nueva batería del software ni cambia esos conteos. La aceptación de un requisito se registra con su caso, revisión de código, entradas, resultado y evidencia consultable.

## 12.3 Documentos relacionados

- Diseño conceptual, mapas de navegación e identidad visual en la carpeta 16.
- Evidencias_Visuales_por_Rol.md y Pruebas_Evidencias_Actualizadas.md en la carpeta 07.
- Manual de instalación actualizado en la carpeta 11.
- Despliegue_Hostinger.md y su manifiesto de referencia en la carpeta 17.
- Anexos A, B y C actualizados en la carpeta 14, con trazabilidad, criterios restantes e inventario funcional.

SRS_V3_completo_y_trazable.pdf conserva el documento histórico. El SRS vigente de esta entrega es SRS_FaceLit_V4.md y su PDF con versión documental 4.1.
