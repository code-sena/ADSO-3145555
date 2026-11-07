# Manual Técnico

**Proyecto:** SmartHome · **ADSO:** 3145555 · **Fecha:** 6 de noviembre de 2026

**Elaborado por:** Natalia Chala Chala, Kevin Stiven López Amaya, Karen Daniela Holguín Cruz

---

## 1. Finalidad y alcance

Este manual describe la organización técnica de SmartHome y los criterios con los que se integran sus cuatro componentes de software: base de datos, backend, plataforma web y aplicación móvil. Está destinado a desarrolladores, responsables de pruebas y personal que necesite mantener o auditar el sistema. No es un certificado de funcionamiento en producción ni sustituye las verificaciones con el dispositivo IoT real.

Se consultaron los README, configuraciones, rutas y workflows publicados por los repositorios durante la revisión del 6 de noviembre de 2026. Las fuentes documentales del Drive complementan el contexto; si difieren del código, se privilegian los contratos y archivos reales de la versión de referencia.

## 2. Panorama de la arquitectura

| Capa o componente | Tecnología verificada | Responsabilidad principal |
| --- | --- | --- |
| Cliente web | React 18, TypeScript, Vite 6 | Interfaz de gestión de hogares, dispositivos, consumo, notificaciones y perfil. |
| Cliente móvil | React Native 0.86, Expo SDK 57, Expo Router | Experiencia Android: inicio, hogares, energía, avisos y perfil, más funciones de dispositivos. |
| API de negocio | Node.js 22 (CI), NestJS, TypeScript | Autenticación, autorización, reglas de dominio, acceso a datos y coordinación IoT. |
| Persistencia | PostgreSQL 16 local, Prisma y Liquibase 4.29 | Datos de usuarios, hogares, dispositivos, lecturas, permisos y migraciones. |
| Mensajería y eventos | MQTT y Socket.IO | Telemetría y órdenes hacia IoT, y actualizaciones para clientes conectados. |

La API concentra decisiones que los clientes no deben tomar por su cuenta: validación de permisos, acceso al hogar y reglas de control. La separación permite que web y móvil consuman servicios compartidos sin acceder directamente a las tablas de PostgreSQL.

## 3. Estructura y responsabilidades

| Repositorio | Estructuras técnicas relevantes |
| --- | --- |
| smarthome-backend | src/modules/{auth,homes,devices,consumption,notifications,realtime,energy}; src/infrastructure/database/prisma; src/security; test. |
| smarthome-frontend-web | web/src/app; web/src/features; web/src/shared/api; web/src/shared/realtime; web/src/components; web/test. |
| from_movil | app; lib/api; lib/services; lib/pairing; lib/context; lib/hooks; components; scripts. |
| smarthome-database | 01_ddl; 02_dml; 03_dcl; 04_tcl; 05_rollbacks; changelog; releases; scripts; tests. |

## 4. Backend: módulos y flujo de una solicitud

| Módulo | Función de negocio |
| --- | --- |
| Auth | Registro/autenticación, recuperación y administración del ciclo de sesión según rutas disponibles. |
| Homes | Administración de hogares, membresías y roles por hogar. |
| Devices | Registro, consulta, estados y acciones autorizadas sobre dispositivos. |
| Consumption / Energy | Consultas energéticas, históricos, tarifas y planificación asociada al consumo. |
| Notifications | Avisos, alertas y sus operaciones de consulta. |
| Realtime | Comunicación de eventos con los clientes conectados mediante Socket.IO. |

Recorrido habitual de una operación: (1) el cliente envía una solicitud; (2) el controlador recibe parámetros y datos validados; (3) se revisa identidad, membresía y permisos; (4) el caso de uso ejecuta reglas; (5) el repositorio o adaptador realiza persistencia o mensajería; (6) la API devuelve un resultado interpretable por el cliente. Esta descripción se corresponde con la división de responsabilidades del backend, pero no implica que todos los endpoints sigan exactamente la misma secuencia.

## 5. Contratos de comunicación

| Interfaz | Contrato identificado | Precaución de interpretación |
| --- | --- | --- |
| REST | Prefijo /api/v1 | Las rutas concretas y sus permisos dependen de cada controlador; no construir endpoints a partir del nombre de la pantalla. |
| Swagger | /api/docs cuando está habilitado | No asumir que Swagger se expone en un entorno de producción. |
| Realtime | Socket.IO en integración con clientes | La existencia del gateway no confirma conectividad de red ni recepción real por un cliente. |
| MQTT | Publicación de comandos y recepción de estado/telemetría | COMMAND_PUBLISHED significa envío de la orden, no confirmación física del relé. |

Una operación de control requiere evaluar dos niveles: la aceptación de la orden por la API y el estado posterior reportado por el dispositivo. Para afirmar accionamiento real es necesario un evento de estado coherente o una observación del equipo físico.

## 6. Diseño de persistencia y migraciones

El repositorio de base de datos administra el historial SQL por medio de changelog/changelog-master.yaml. El backend usa Prisma para comunicarse con PostgreSQL. Las entidades funcionales abarcan usuarios, sesiones, hogares y miembros, dispositivos, lecturas, configuraciones, alertas y auditorías. El detalle exacto de columnas, llaves e índices debe comprobarse contra los changesets de la revisión analizada.

| Elemento | Criterio operativo |
| --- | --- |
| DDL y cambios incrementales | Usar changesets versionados, sin editar migraciones ya aplicadas. |
| Privilegios / RLS | Separar cuentas de administración y cuentas LOGIN de operación; aplicar mínimo privilegio. |
| Migración | Validar y revisar SQL antes de update; aplicar solo al destino aprobado. |
| Seguridad | Configurar el contexto de autorización del usuario de manera transaccional según la implementación. |
| Rollback | No asumir reversión libre de pérdida de datos; revisar efecto de cada migración. |

## 7. Seguridad y permisos

El SRS revisado distingue roles globales (SYSTEM_ADMIN y USER) y roles por hogar (OWNER, MEMBER y GUEST). El acceso efectivo debe comprobarse en guards, políticas y servicios del backend. Los controles visuales del frontend no reemplazan autorización del servidor.

- Mantener secretos fuera de Git y de variables públicas VITE_* y EXPO_PUBLIC_*.
- Gestionar JWT y sesiones con los mecanismos propios del backend; no copiar tokens a capturas.
- Usar TLS en servicios accesibles por Internet y validar su configuración; no inferir seguridad por el nombre del proveedor.
- No habilitar pairing Shelly de producción por modificar una sola variable: los README exigen precondiciones de broker, permisos, TLS y persistencia.
- MFA obligatorio y funcionamiento offline completo aparecen fuera del alcance v1.0 del SRS revisado; no afirmarlos como funciones certificadas.

## 8. Integración Shelly y límites comprobados

El README del backend informa que en DEV se probaron telemetría y control sobre un Shelly ya conocido, pero que la vinculación inicial LAN/AP desde cero permanece pendiente. La documentación móvil registra una prueba de concepto BLE: descubrimiento y lectura experimental de información mediante GATT/RPC. Esa función no equivale a un emparejamiento completo ni debe usarse para modificar credenciales del dispositivo.

**Seguridad eléctrica.** La configuración o el cableado de dispositivos conectados a la red doméstica debe ser realizada por personal competente siguiendo las instrucciones del fabricante. Este manual no ofrece un procedimiento de cableado de 110/220 V.

## 9. Automatización y evidencias

| Componente | Validación identificada | Alcance de la evidencia |
| --- | --- | --- |
| Backend | Workflow CI aprobado, 4 nov. 2026 | ESLint, TypeScript, Jest, build y seguridad MQTT. |
| Web | Workflow CI aprobado, 5 nov. 2026 | Lint, tipado, contratos, build y smoke test Docker; publicación/despliegue omitidos. |
| Base de datos | Workflow CI aprobado, 5 nov. 2026 | Liquibase y auditorías de permisos en una base desechable. |
| Móvil | Workflow CI aprobado, 5 nov. 2026 | Lint, tipos, suites simuladas y exportación del bundle Android. |
| Auditoría móvil | Workflow de seguridad fallido, 5 nov. 2026 | Cinco hallazgos altos, ocho moderados, uno bajo. Incidencia #42 abierta. |

Estos resultados se refieren a commits concretos de CI y no constituyen una prueba de despliegue extremo a extremo. La documentación de las pruebas completas se encuentra en el producto 05 de la entrega.

## 10. Mantenimiento y diagnóstico

1. Identificar repositorio, rama, commit y ambiente; no mezclar una base QA con backend DEV sin validación.
1. Revisar logs sin exponer secretos, tokens o datos personales.
1. Separar un fallo REST, un error RLS/Prisma, una desconexión MQTT y un fallo de interfaz: cada uno requiere un diagnóstico distinto.
1. Antes de cambiar el esquema, verificar changelog y realizar un respaldo probado.
1. Antes de actualizar Expo o sus dependencias, revisar la compatibilidad con SDK 57, navegación, BLE y el build Android.
1. Registrar el resultado observado y el identificador de la evidencia en la matriz de pruebas.

## 11. Alcance del mantenimiento evolutivo

Las prioridades identificadas para la versión revisada incluyen corregir hallazgos de seguridad móvil, verificar la vinculación física Shelly y reconciliar la versión documentada con los commits definitivos de main. Las propuestas de mejora y acciones abiertas se conservan en el producto 07, sin declararlas cerradas por su sola mención.

## 12. Conclusión

SmartHome incorpora capas y módulos reconocibles, con fronteras técnicas suficientemente claras para orientar mantenimiento y pruebas. Este manual describe su estructura desde las fuentes reales, identifica los límites de lo probado y permite ampliar la documentación en cuanto existan nuevas ejecuciones, un tag final y evidencias de integración IoT.

## Fuentes y referencias verificables

1. [Requisito institucional de manuales](https://github.com/code-sena/ADSO-3145555/blob/main/04-final-delivery/02-smarthome/08-manuals/README.md)
2. [SRS revisado de SmartHome](https://docs.google.com/document/d/1BYwKmODc6xmjVqJjOdBtK7t9KJr7vHnm/edit)
3. [Backend / README](https://github.com/nataliachala1/smarthome-backend/blob/dev/README.md)
4. [Base de datos / README](https://github.com/nataliachala1/smarthome-database/blob/dev/README.md)
5. [Frontend web / README](https://github.com/nataliachala1/smarthome-frontend-web/blob/dev/README.md)
6. [Frontend móvil / README](https://github.com/Kevin-Stiven-Lopez-Amaya404/from_movil/blob/dev/README.md)
7. [Arquitectura central](https://github.com/Kevin-Stiven-Lopez-Amaya404/smart-home-doc/tree/main/docs/10-arquitectura)
8. [CI backend](https://github.com/nataliachala1/smarthome-backend/actions/runs/41937120061)
9. [CI web](https://github.com/nataliachala1/smarthome-frontend-web/actions/runs/42029415737)
10. [CI base de datos](https://github.com/nataliachala1/smarthome-database/actions/runs/41949904947)
11. [CI móvil](https://github.com/Kevin-Stiven-Lopez-Amaya404/from_movil/actions/runs/42026996921)
12. [Auditoría móvil fallida](https://github.com/Kevin-Stiven-Lopez-Amaya404/from_movil/actions/runs/42026688999)
13. [Incidencia #42](https://github.com/Kevin-Stiven-Lopez-Amaya404/from_movil/issues/42)