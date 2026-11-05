# Anexo B Seguimiento de criterios y decisiones de FaceLit

Revisión integral del 5 de noviembre de 2026. Este anexo desarrolla los 60 registros del SRS V4.1 que necesitan una verificación especializada, una decisión o una ampliación concreta. La operación confirmada de login, CSV, cámara, asistencia y correo se mantiene como contexto funcional.

## 1 Cómo interpretar el seguimiento

Los estados y observaciones proceden del SRS vigente. Un criterio por verificar necesita su evidencia específica: por ejemplo, que el CSV funcione no establece el tiempo de procesamiento de 500 filas. El Anexo A mantiene los 97 requerimientos y sus casos; aquí se reúnen las condiciones adicionales que conserva esa especificación.

| Grupo de seguimiento | Registros |
|---|---|
| Criterio por verificar | 48 |
| Diferencia con el criterio | 6 |
| Objetivo adicional | 2 |
| Integrado con criterio adicional | 2 |
| Retirado del alcance vigente | 1 |
| Ampliación futura | 1 |

## 2 Criterios del SRS que requieren seguimiento

Cada fila conserva su caso CP para registrar el resultado. El título y la aceptación completa se consultan por ID en el SRS. Las referencias COO, INS y APR se resuelven en el Anexo A y en el catálogo visual de pruebas.

### 2 1 Requerimientos funcionales y alcance

| Requerimiento y estado | Observación y condición de verificación | Caso |
|---|---|---|
| RF-3.3 - Objetivo adicional | El alta administrativa actual permite COORDINATOR. El Coordinador de Registro diferenciado del baseline requiere DEC-01 y una implementación propia. | CP-RF-3.3 |
| RF-3.4 - Integrado con criterio adicional | InitialCredentialServiceImpl genera y cifra la credencial y entrega el acceso tras commit. Persisten campos legacy de contraseña en DTO académicos. Su presencia exige comprobar las respuestas efectivas antes de declarar cumplida la prohibición de exposición. | CP-RF-3.4 |
| RF-3.5 - Objetivo adicional | Los roles asignables se validan en servidor. El perfil separado de registro no está en RoleName y se conserva como decisión de alcance. | CP-RF-3.5 |
| RF-5.3 - Integrado con criterio adicional | La configuración del servicio facial usa similitud 0.65 y rango técnico 0..1. La administración institucional versionada y su panel siguen como objetivo de aceptación específico. | CP-RF-5.3 |
| RF-C1 - Retirado del alcance vigente | Las rutas de gestión de horarios y excepciones fueron retiradas. El ID se conserva para rastrear el baseline. Los tiempos operativos se definen en la sesión de ambiente. | CP-RF-C1 |

### 2 2 Autenticación y seguridad

| Requerimiento y estado | Observación y condición de verificación | Caso |
|---|---|---|
| RNF-1.1 - Criterio por verificar | BCrypt, JWT y HTTPS público están presentes. El acceso privado al microservicio usa la red Docker y clave interna. | CP-RNF-1.1 |
| RNF-1.2 - Criterio por verificar | Existe validación de longitud y complejidad. Revisar cambio inicial, recuperación y rotación con la misma política. | CP-RNF-1.2 |
| RNF-1.4 - Criterio por verificar | SecurityConfig diferencia operaciones de coordinación, instructor y aprendiz. Se requieren variantes por recurso ajeno para el criterio completo. | CP-RNF-1.4 |
| RNF-1.5 - Criterio por verificar | Las rutas de autoservicio y los servicios de asistencia aplican alcance. La comparación de identificadores propios y ajenos pertenece al caso negativo. | CP-RNF-1.5 |
| RNF-1.6 - Criterio por verificar | Se observan consentimiento, control de sesión y permisos. La política de retención y eliminación biométrica requiere responsable y evidencia propia. | CP-RNF-1.6 |
| RNF-1.7 - Criterio por verificar | Existe actualización administrativa. El cambio de documento permitido por el servicio debe alinearse con la regla de identidad del baseline. | CP-RNF-1.7 |
| RNF-1.8 - Criterio por verificar | Hay ChangeHistory y sesiones persistidas. La cobertura de cada campo, motivo y operación debe verificarse por caso. | CP-RNF-1.8 |
| RNF-1.9 - Criterio por verificar | Hay recuperación, códigos y sesiones de recuperación. Duración, límite, reenvío, titular y consumo se verifican con solicitudes controladas. | CP-RNF-1.9 |
| RNF-1.10 - Diferencia con el criterio | El login visible solicita documento. LoginServiceImpl también busca por correo. La restricción exclusiva a documento sigue siendo una diferencia concreta. | CP-RNF-1.10 |
| RNF-1.12 - Criterio por verificar | La operación del login está confirmada. Falta una serie de mediciones que demuestre el percentil exigido. | CP-RNF-1.12 |
| RNF-1.13 - Criterio por verificar | La publicación está operativa. Una respuesta HTTP correcta no mide disponibilidad durante el periodo acordado. | CP-RNF-1.13 |
| RNF-1.14 - Criterio por verificar | Hay formularios y mensajes por rol. La evaluación con usuarios y su registro de tareas corresponde a la aceptación de usabilidad. | CP-RNF-1.14 |

### 2 3 Gestión académica y CSV

| Requerimiento y estado | Observación y condición de verificación | Caso |
|---|---|---|
| RNF-2.2 - Criterio por verificar | DTO, servicios y restricciones de la base validan referencias y estados. La batería de errores se documenta por caso. | CP-RNF-2.2 |
| RNF-2.3 - Criterio por verificar | ChangeHistory conserva operaciones académicas. La cobertura completa del historial es un criterio adicional de revisión. | CP-RNF-2.3 |
| RNF-2.4 - Criterio por verificar | La interfaz y API manejan datos personales. El resumen y los DTO legacy deben revisarse para confirmar máscara y ausencia de secretos en cada respuesta. | CP-RNF-2.4 |
| RNF-2.5 - Criterio por verificar | CSV está operativo. COO-04 muestra los límites del formulario. La meta de 500 filas en menos de 10 s requiere cronometraje con condiciones registradas. | CP-RNF-2.5 |
| RNF-2.6 - Criterio por verificar | Las consultas cargan datos en las capturas. La disponibilidad requiere una ventana de observación y meta aprobadas. | CP-RNF-2.6 |
| RNF-2.7 - Criterio por verificar | COO-04 muestra guía previa y COO-07 avisos comprensibles de referencias inválidas. La prueba de comprensión requiere participantes y resultados. | CP-RNF-2.7 |
| RNF-2.8 - Criterio por verificar | CSV y formularios usan servicios de dominio. Comparar una misma entidad por ambos caminos verifica equivalencia. | CP-RNF-2.8 |
| RNF-2.9 - Criterio por verificar | Se observan validaciones de unicidad y restricciones SQL. La prueba concurrente requiere ejecución controlada. | CP-RNF-2.9 |
| RNF-2.10 - Criterio por verificar | El traslado se implementa transaccionalmente. La inyección de un fallo y traslados concurrentes comprueban su atomicidad. | CP-RNF-2.10 |
| RNF-2.11 - Criterio por verificar | Hay decisiones de traslados pendientes y ChangeHistory. Verificar el vínculo de la decisión a su carga y motivo. | CP-RNF-2.11 |
| RNF-2.12 - Criterio por verificar | COO-01 muestra 402 fichas y 3.640 usuarios. El frontend local consulta aprendices en lotes de hasta 80 fichas. Los tiempos bajo carga requieren medición. | CP-RNF-2.12 |
| RNF-2.13 - Criterio por verificar | La carga tiene tratamiento de filas y transacciones. Un ensayo de interrupción debe demostrar el estado final de la base. | CP-RNF-2.13 |
| RNF-2.14 - Criterio por verificar | CSV y capturas presentan tildes. Revisar también diéresis, ñ y normalización en alta y edición con los mismos datos. | CP-RNF-2.14 |

### 2 4 Usuarios y credenciales

| Requerimiento y estado | Observación y condición de verificación | Caso |
|---|---|---|
| RNF-3.1 - Criterio por verificar | COO-02 muestra listado y filtros con 3.640 resultados. Paginación y tiempo del criterio se evalúan aparte. | CP-RNF-3.1 |
| RNF-3.2 - Criterio por verificar | Existen comprobaciones y unicidad del documento. Probar duplicados por alta administrativa y CSV. | CP-RNF-3.2 |
| RNF-3.3 - Criterio por verificar | Se generan credenciales y se almacenan hashes. Los DTO conservan campos legacy. Comprobar contenido real de respuestas y exportaciones. | CP-RNF-3.3 |
| RNF-3.4 - Diferencia con el criterio | UserManagementServiceImpl permite asignar un nuevo documento en edición. El criterio de inmutabilidad sigue por alinear. | CP-RNF-3.4 |
| RNF-3.5 - Criterio por verificar | Hay avisos de modificaciones e historial académico. La auditoría de todos los campos de usuario requiere inspección y caso específico. | CP-RNF-3.5 |
| RNF-3.7 - Criterio por verificar | La interfaz contiene exportación. Conservar el XLSX, filtros y conteo permite comprobar el resultado. | CP-RNF-3.7 |

### 2 5 Perfil y sesión

| Requerimiento y estado | Observación y condición de verificación | Caso |
|---|---|---|
| RNF-4.1 - Criterio por verificar | Los perfiles propios aparecen en COO-08 y APR-07. La API toma la identidad autenticada. | CP-RNF-4.1 |
| RNF-4.2 - Diferencia con el criterio | El perfil coloca el correo completo en su campo de información. El enmascaramiento sigue siendo una diferencia de privacidad del baseline. | CP-RNF-4.2 |
| RNF-4.4 - Criterio por verificar | El JWT tiene expiración. No se aporta una ejecución que demuestre el criterio independiente de 30 minutos de inactividad. | CP-RNF-4.4 |
| RNF-4.5 - Criterio por verificar | El perfil es de consulta y la edición administrativa está restringida. Probar cambios directos desde los otros roles. | CP-RNF-4.5 |

### 2 6 Biometría y captura

| Requerimiento y estado | Observación y condición de verificación | Caso |
|---|---|---|
| RNF-5.1 - Criterio por verificar | La cámara y el registro funcionan según el equipo. Los controles de uno o varios rostros se verifican en los casos de rechazo. | CP-RNF-5.1 |
| RNF-5.2 - Criterio por verificar | Existen controles de calidad y vida. El conjunto de iluminación y nitidez aceptado debe quedar identificado en la prueba. | CP-RNF-5.2 |
| RNF-5.4 - Diferencia con el criterio | La base usa pgvector y la revisión debe demostrar cifrado en reposo, retención y borrado. El uso de un vector no prueba cifrado. | CP-RNF-5.4 |
| RNF-5.5 - Diferencia con el criterio | El servicio configura facial_match_threshold=0.65 con rango técnico 0..1. El panel institucional versionado del baseline requiere desarrollo y aceptación específicos. | CP-RNF-5.5 |
| RNF-5.6 - Diferencia con el criterio | Caddy publica HTTPS válido. La comunicación backend-facial se configura por HTTP en una red privada Docker con clave de servicio. TLS entre todos los saltos es un objetivo adicional. | CP-RNF-5.6 |
| RNF-5.7 - Ampliación futura | La entrega vigente opera conectada desde navegador y servicios. Raspberry Pi y cola facial offline quedan como ampliación futura. | CP-RNF-5.7 |

### 2 7 Sesión y asistencia

| Requerimiento y estado | Observación y condición de verificación | Caso |
|---|---|---|
| RNF-6.1 - Criterio por verificar | El equipo confirma asistencia y la API persiste eventos. El tiempo máximo del criterio requiere medición. | CP-RNF-6.1 |
| RNF-6.2 - Criterio por verificar | La clasificación usa sesiones y ventanas de registro. APR-03 muestra retraso. Las fronteras E, E+T, S y A requieren sus casos específicos. | CP-RNF-6.2 |
| RNF-6.3 - Criterio por verificar | Existen eventos y gestión de excusas. La anulación con motivo y preservación del hecho original debe demostrarse antes de cerrar el criterio. | CP-RNF-6.3 |
| RNF-6.4 - Criterio por verificar | La alerta mensual al cuarto retraso grave y su umbral requieren una prueba y una definición de producto específicas. | CP-RNF-6.4 |
| RNF-6.5 - Criterio por verificar | El respaldo manual pendiente de aprobación se conserva como objetivo adicional. Esta entrega de capturas no documenta esa ejecución. | CP-RNF-6.5 |

### 2 8 Consultas y reportes

| Requerimiento y estado | Observación y condición de verificación | Caso |
|---|---|---|
| RNF-7.1 - Criterio por verificar | useAttendance filtra al aprendiz por identidad. La autorización definitiva depende de backend y debe comprobarse con consultas ajenas. | CP-RNF-7.1 |
| RNF-7.2 - Criterio por verificar | La consulta de asistencia está operativa. Los volúmenes y tiempos del criterio requieren medición reproducible. | CP-RNF-7.2 |
| RNF-7.3 - Criterio por verificar | INS-01 muestra botones Excel y CSV. La evidencia del archivo es necesaria para cotejar contenido y filtros. | CP-RNF-7.3 |
| RNF-7.4 - Criterio por verificar | La interfaz tiene indicadores por estado. El umbral de alerta crítica configurable se evalúa como criterio específico. | CP-RNF-7.4 |
| RNF-7.5 - Criterio por verificar | Los reportes derivan datos de useAttendance. El calendario debe cotejarse con matriz y archivo para el mismo periodo. | CP-RNF-7.5 |

### 2 9 Notificaciones y entrega

| Requerimiento y estado | Observación y condición de verificación | Caso |
|---|---|---|
| RNF-8.1 - Criterio por verificar | COO-07 y APR-06 muestran notificaciones de eventos. Los avisos de sincronización Raspberry pertenecen al alcance futuro. | CP-RNF-8.1 |
| RNF-8.2 - Criterio por verificar | Las bandejas muestran retención de 30 días y persistencia de lectura. El acceso offline durable necesita prueba específica. | CP-RNF-8.2 |
| RNF-8.3 - Criterio por verificar | SMTP está operativo según el equipo. La cuota de cinco por hora y ausencia de secretos se comprueban mediante evidencia de entrega. | CP-RNF-8.3 |
| RNF-8.4 - Criterio por verificar | El sistema dispone de entrega SMTP y bandeja. El backoff push especificado en el baseline se conserva como objetivo adicional de canal. | CP-RNF-8.4 |

## 3 Decisiones de producto y operación

Se conservan DEC-01 a DEC-06 con los responsables por función que define el SRS. Esta revisión no asigna nombres ni resuelve decisiones institucionales por el equipo.

| Decisión | Responsable | Requerimientos | Estado |
|---|---|---|---|
| DEC-01 Identidad y permisos del Coordinador de Registro | Responsable académico/producto | RF-3.3, RF-3.5, RNF-1.16 | Por validar institucionalmente |
| DEC-02 Activación y entrega de credenciales | Responsable de producto y seguridad | RF-3.4, RNF-3.3, RNF-8.3 | Por validar institucionalmente |
| DEC-03 Contrato facial y protección del descriptor | Responsable técnico y de datos | RF-5.1, RNF-5.3, RNF-5.4 | Por validar institucionalmente |
| DEC-04 Dispositivos y alcance offline | Responsable académico y técnico | RF-C2, RNF-5.6, RNF-5.7 | Por validar institucionalmente |
| DEC-05 Metas operativas | Responsable de operación/producto | RNF-1.13, RNF-2.6, RNF-2.12 | Por validar institucionalmente |
| DEC-06 Parámetros de seguridad y evaluación | Responsable de seguridad y académico | RF-1.4, RF-5.4, RNF-6.4 | Por validar institucionalmente |

El detalle de cada decisión está en la sección 9 del SRS. Las diferencias de identidad y entrega de credenciales, protección del descriptor, dispositivos, operación y parámetros se resuelven con una decisión versionada y su evidencia.

## 4 Variantes de los casos de prueba

| Variante | Comprobación | Evidencia que se conserva |
|---|---|---|
| A Flujo normal | Entrada válida y resultado del servicio. | Captura del resultado y registro persistido. |
| B Datos inválidos | Formato, referencia, duplicado, vigencia y límites. | Entrada usada, rechazo y ausencia de cambios indebidos. |
| C Permiso y propiedad | Rol correcto, rol distinto y recurso ajeno. | Petición y respuesta sin secretos, con identidad de prueba. |
| D Falla y concurrencia | Interrupción, reintento, doble envío y recuperación. | Estados antes y después, transacción y logs depurados. |
| E Rendimiento | Volumen y umbral del criterio. | Mediciones, condiciones, percentiles y artefacto de corrida. |

La ejecución de una variante depende del criterio. Las pruebas que cambian datos, interrumpen servicios o provocan concurrencia se preparan en un entorno de prueba con datos controlados.

## 5 Registro mínimo de un resultado

| Campo | Contenido |
|---|---|
| Identificación | Caso CP, variante y requerimiento del SRS. |
| Ejecución | Fecha y hora, ejecutor y entorno. |
| Versiones | Rama, SHA y ajustes locales de los cuatro repositorios; configuración y modelo usados. |
| Preparación | Cuenta de prueba, alcance del rol, datos de entrada y precondiciones. |
| Procedimiento | Pasos que permiten repetir la prueba. |
| Resultado | Esperado, obtenido y estado aprobado, fallido, omitido o bloqueado. |
| Artefactos | Ruta del reporte, captura, archivo descargado o log depurado. |
| Cierre | Incidente, decisión aplicable, responsable y fecha de aceptación. |

No se marca un resultado como aprobado a partir de una plantilla vacía. Para exportación se adjunta el archivo; para métricas se adjunta la medición; para recuperación se conserva el estado restaurado y su comprobación.

## 6 Control de alcance

RF-C1 mantiene la trazabilidad del módulo de horarios retirado. Los tiempos vigentes se configuran en las sesiones de ambiente. RNF-5.7 mantiene Raspberry y la sincronización facial offline como ampliación futura. El rol diferenciado de Coordinador de Registro permanece sujeto a DEC-01. Estas clasificaciones conservan el alcance escrito en el SRS.

## 7 Referencias

- [SRS V4.1 y criterios completos](requirements-specification.md).
- [Matriz de los 97 requerimientos](requirements-traceability.md).
- [Plan de pruebas](../05-test-documentation/test-plan.md).
- [Resultados y límites de la evidencia](../05-test-documentation/reported-test-results.md).
- [Despliegue y versiones del paquete](../06-implementation-procedure/hostinger-deployment.md).
