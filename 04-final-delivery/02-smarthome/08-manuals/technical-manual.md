# Manual técnico — SmartHome

Servicio Nacional de Aprendizaje (SENA)  
Programa: Análisis y Desarrollo de Software · Ficha: 3145555  
Proyecto: SmartHome · Revisión documental: 7 de noviembre de 2026  
Equipo: Karen Daniela Holguín Cruz, Natalia Chala Chala y Kevin Stiven López Amaya  
Estado: versión preparada para revisión académica; no publicada en el PR #17 ni aprobada por el instructor.

> Control de versión. Estos manuales parten de los tres Markdown de la rama `final-delivery/smarthome-stiven-20261107` del PR institucional #17 y se contrastaron con README y manifiestos `package.json` de las ramas `dev` accesibles el 7-11-2026. Son una referencia documental de desarrollo, no certificación de funcionamiento de una versión `main` etiquetada. No se ejecutaron instalaciones, pruebas Android ni operaciones eléctricas durante su elaboración.

## 1. Propósito, alcance y criterio de verificación

Este manual describe los componentes, interfaces, seguridad, persistencia y mantenimiento de SmartHome. Sirve como material de operación y auditoría para responsables técnicos, desarrolladores y evaluadores. La arquitectura se sustenta en repositorios y documentos técnicos, mientras que la aceptación de hardware requiere una prueba física independiente.

Estados usados: «identificado en código o configuración» describe un componente observable; «referenciado en documentación» indica una intención o contrato; «pendiente de validación» exige ejecución y evidencia. No confundir estos estados.

Como marco de referencia, el manual sigue ISO/IEC/IEEE 26514 para información técnica (ISO/IEC/IEEE, 2022) y describe un backend NestJS (NestJS, s. f.), una base PostgreSQL con políticas de seguridad por filas (PostgreSQL Global Development Group, 2025) y la integración de dispositivos por MQTT 5.0 (OASIS, 2019).

## 2. Arquitectura por componentes

**Tabla 1**

*Arquitectura por componentes*

| Componente | Tecnologías contrastadas | Función |
|---|---|---|
| Web | React 18, TypeScript, Vite 6 | Interfaz para hogares, dispositivos, consumo y notificaciones |
| Móvil | React Native 0.88.1, Expo ~58.0.23, Expo Router | Pantallas Android, energía, dispositivos, alertas y pairing experimental |
| API | Node.js, NestJS 11, TypeScript, Prisma 7 | Reglas de negocio, sesiones, permisos, acceso a datos y mensajería |
| Datos | PostgreSQL; Liquibase 4.29 en documentación DB | Persistencia, migraciones, seguridad RLS |
| Integración | MQTT, Socket.IO | Comandos, telemetría y eventos en tiempo real |

Fuente: elaboración propia.

Diferencia detectada: el README móvil aún declara SDK 57 y React Native 0.86, pero `dev/package.json` declara Expo 58.0.23 y React Native 0.88.1. La versión definitiva dependerá del commit aprobado, de su lockfile y de la compilación Android. No utilizar de forma simultánea documentación de SDK 57 y dependencias de SDK 58 para generar una APK.

```text
Web React             Android React Native
      \                 /
       \  API REST / Socket.IO
             NestJS
          /         \
 PostgreSQL/Prisma   MQTT / dispositivos
   y Liquibase         compatibles
```

## 3. Repositorios y división de responsabilidades

**Tabla 2**

*Repositorios y división de responsabilidades*

| Repositorio vigente | Carpetas / referencia | Alcance |
|---|---|---|
| `smarthome-backend` | `src/modules/`, `src/infrastructure/`, `test/` | API y reglas de negocio |
| `smarthome-frontend-web` | `web/src/app`, `web/src/features`, `web/src/shared` | Navegación y vistas web |
| `from_movil` | `app/`, `lib/api`, `lib/pairing`, `lib/services` | Android y comunicación de la app |
| `smarthome-database` | `01_ddl`, `02_dml`, `03_dcl`, `releases`, `changelog` | Esquema y migraciones SQL |

Fuente: elaboración propia.

La documentación técnica canónica del proyecto es `smart-home-doc` (singular). `smart-home-docs` y `smart-home-database` son repositorios históricos citados por el instructor: no deben sustituir silenciosamente a los vigentes.

## 4. Backend y contratos

El backend expone controladores y casos de uso para autenticación, hogares, dispositivos, energía/consumo, notificaciones y eventos. Un recorrido típico comprende: solicitud del cliente; validación de DTO y sesión; comprobación de rol y pertenencia al hogar; ejecución de reglas; persistencia o mensajería; respuesta HTTP. El orden exacto depende del endpoint y debe comprobarse en el código del commit que se entregue.

**Tabla 3**

*Backend y contratos*

| Interfaz | Referencia comprobada | Advertencia |
|---|---|---|
| API REST | Prefijo `/api/v1` | Las rutas concretas dependen de sus controladores |
| Swagger | `/api/docs` cuando esté habilitado | No suponer disponibilidad en producción |
| Tiempo real | Socket.IO | Gateway existente no demuestra conectividad del cliente |
| IoT | MQTT | `COMMAND_PUBLISHED` no es confirmación física del relé |

Fuente: elaboración propia.

Para validar el control de un dispositivo se necesitan, como evidencias separadas: respuesta autorizada de API, publicación/recepción del mensaje MQTT y observación de estado real o telemetría coherente.

## 5. Persistencia y seguridad

La base de datos es PostgreSQL y su evolución se gestiona mediante el `changelog/changelog-master.yaml` de Liquibase. Prisma es el cliente de acceso desde el backend. El esquema incluye dominios para usuarios, hogares, membresías, dispositivos, telemetría, consumo y notificaciones. Los nombres físicos de tablas y columnas deben derivarse del SQL versionado, no de un diagrama histórico.

- RLS y mínimo privilegio: la base separa cuentas y roles técnicos; el backend debe usar credenciales operativas y un contexto de autorización adecuado.
- Transacciones: no persistir accidentalmente el contexto de usuario entre conexiones reutilizadas.
- Migraciones: validar y revisar `update-sql` antes de `update`; no modificar changesets ya aplicados ni destruir datos de QA.
- Credenciales: mantener JWT, contraseñas, tokens MQTT y claves fuera de Git. `VITE_*` y `EXPO_PUBLIC_*` son públicos para clientes.
- Roles funcionales: la documentación SRS distingue roles globales `SYSTEM_ADMIN` / `USER` y roles de hogar `OWNER` / `MEMBER` / `GUEST`. La UI no reemplaza autorización del backend.

No declarar MFA obligatorio, operación totalmente offline ni disponibilidad garantizada cuando no existe evidencia aprobada de esas características en la versión final.

## 6. Integración Shelly y seguridad eléctrica

Los README del backend reportan pruebas DEV de telemetría y control sobre un Shelly previamente conocido. La vinculación completa inicial LAN/AP desde cero continúa pendiente de aceptación. La aplicación móvil contiene descubrimiento BLE y lectura experimental GATT/RPC, lo cual no equivale al emparejamiento completo.

Para afirmar funcionamiento extremo a extremo deben conservarse: modelo, firmware y red del dispositivo; versión de app/backend; usuario/rol de prueba; comando enviado; evento MQTT; lectura posterior; y resultado observado. No incluir identificadores sensibles, credenciales ni direcciones privadas en evidencia pública.

Seguridad: este documento no enseña a intervenir cableado de tensión doméstica. La instalación física debe seguir documentación del fabricante y normas eléctricas con personal competente. Una orden visual de apagado no prueba ausencia de tensión.

## 7. Pruebas, CI y diagnóstico

Las ejecuciones mencionadas en los manuales del PR #17 corresponden a commits de noviembre de 2026, no a un release congelado. El issue móvil #42 de auditoría de dependencias aparecía abierto al revisar la entrega. No interpretar CI antigua como una certificación de seguridad del SDK 58 recién identificado.

**Tabla 4**

*Pruebas, CI y diagnóstico*

| Síntoma | Revisión recomendada |
|---|---|
| API no responde | logs de arranque, `PORT`, JWT y conexión PostgreSQL |
| `403` / RLS | roles, membresía al hogar y contexto transaccional |
| Web no consulta API | proxy Vite, `/api/v1` y CORS del origen |
| Android no conecta | API LAN accesible; en teléfono `localhost` no es el PC |
| No hay cambios físicos | separar estado REST, MQTT, telemetría y hardware |
| BLE no disponible | usar build nativa que incluya los módulos requeridos |

Fuente: elaboración propia.

## 8. Mantenimiento y cierre de versión

1. Identificar repositorio, rama, SHA y entorno antes de corregir.
2. Ejecutar pruebas acordadas en el commit que se promoverá a `main`.
3. Revisar la compatibilidad de migraciones, roles, API y clientes; registrar regresiones.
4. Resolver hallazgos de seguridad y realizar pruebas de Android en hardware real.
5. Generar tags y exportaciones solo después de las aprobaciones técnicas.
6. Mantener el registro del producto 07 actualizado con evidencias de cierre.

## 9. Fuentes y límites

- [Manual técnico base del PR #17](https://github.com/Kevin-Stiven-Lopez-Amaya404/ADSO-3145555/blob/final-delivery/smarthome-stiven-20261107/04-final-delivery/02-smarthome/08-manuals/technical-manual.md)
- [Backend](https://github.com/nataliachala1/smarthome-backend) y [base de datos](https://github.com/nataliachala1/smarthome-database)
- [Frontend web](https://github.com/nataliachala1/smarthome-frontend-web) y [frontend móvil](https://github.com/Kevin-Stiven-Lopez-Amaya404/from_movil)
- [Guía de manuales del instructor](https://github.com/code-sena/ADSO-3145555/blob/main/04-final-delivery/02-smarthome/08-manuals/README.md)

Pendiente para aceptación: verificar en la versión final de `main` el SDK Expo, las pruebas CI, la seguridad de dependencias, la integración IoT y la calidad del manual frente a los requisitos del instructor.

## Referencias

ISO/IEC/IEEE. (2022). *Systems and software engineering — Design and development of information for users* (ISO/IEC/IEEE 26514:2022). https://www.iso.org/standard/77451.html

NestJS. (s. f.). *NestJS documentation*. Recuperado el 8 de noviembre de 2026, de https://docs.nestjs.com/

OASIS. (2019). *MQTT version 5.0* (A. Banks, E. Briggs, K. Borgendale y R. Gupta, Eds.). https://docs.oasis-open.org/mqtt/mqtt/v5.0/mqtt-v5.0.html

PostgreSQL Global Development Group. (2025). *PostgreSQL 18 documentation: Row security policies*. https://www.postgresql.org/docs/18/ddl-rowsecurity.html
