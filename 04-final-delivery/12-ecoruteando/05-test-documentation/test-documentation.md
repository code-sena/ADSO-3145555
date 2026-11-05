# Documentación de Pruebas — EcoRuteando

## Plataforma de Movilidad Sostenible

---

### 1. Control de versiones y metadatos del documento

#### 1.1 Control de versiones

| Versión | Fecha | Autor | Descripción del cambio |
|---------|-------|-------|----------------------|
| 1.0 | 13 de octubre de 2026 | QA Engineer / DevOps | Emisión inicial de la documentación de pruebas |

#### 1.2 Metadatos del documento

| Campo | Valor |
|-------|-------|
| **Nombre del documento** | Documentación de Pruebas — EcoRuteando |
| **Proyecto** | EcoRuteando — Plataforma de Movilidad Sostenible |
| **Versión del software** | 1.0 |
| **Entorno de pruebas** | Producción (post-despliegue) / Staging |
| **Clasificación** | Documentación oficial de calidad — Confidencial interno |
| **Estado** | Vigente |
| **Próxima revisión** | Por release |

#### 1.3 Metadatos del sistema bajo prueba

| Campo | Valor |
|-------|-------|
| **Nombre del sistema** | EcoRuteando |
| **Descripción** | Plataforma web y móvil para planificación de rutas ecológicas, estimación de impacto ambiental (CO₂, calorías), reporte de obstáculos urbanos y alertas climáticas |
| **Backend** | API REST .NET 9 (C#) — arquitectura DDD + Clean Architecture con CQRS/MediatR |
| **Base de Datos** | PostgreSQL 16 + PostGIS 3.5 + Liquibase 5.0.2 (77 changesets, 6 esquemas, 36 tablas, 17 ENUMs) |
| **Frontend** | Aplicación SPA React 18 + Vite 8 + Tailwind CSS (nginx proxy) |
| **Aplicación Móvil** | Expo SDK 57 / React Native 0.86 (Android, iOS) |
| **Bounded Contexts** | Security, Mobility, Notifications, Admin, Integrations |
| **URL Backend** | `https://ecoruteando-backend.onrender.com` (producción) / `http://localhost:5124` (desarrollo) |
| **URL Frontend** | Dominio Vercel (producción) / `http://localhost:3007` (desarrollo) |
| **Métodos de autenticación** | Email/contraseña + OAuth Google |
| **Total de endpoints** | ~110 en 29 controllers |

---

## 2. Introducción y objetivos

### 2.1 Introducción

El presente documento describe el plan, los casos de prueba y los criterios de aceptación aplicados a la plataforma EcoRuteando durante el ciclo de aseguramiento de calidad previo a la puesta en producción.

La estrategia de pruebas se estructura en cinco niveles:

| Nivel | Tipo | Objetivo | Herramientas |
|-------|------|----------|-------------|
| 1 | Pruebas de humo | Verificar que los componentes críticos responden correctamente tras el despliegue | cURL, Swagger, navegador |
| 2 | Pruebas de integración técnica | Validar conectividad entre componentes, APIs externas y lógica de negocio | cURL, Swagger |
| 3 | Pruebas de integración con BD | Verificar esquema, restricciones, ENUMs y extensiones espaciales | psql, SQL directo |
| 4 | Pruebas de aceptación (UAT) | Validar flujos completos desde la perspectiva del usuario final y administrador | Manual / navegador |
| 5 | Pruebas de regresión | Confirmar que cambios recientes no rompieron funcionalidades existentes | Manual / automatización futura |

### 2.2 Objetivos

| # | Objetivo | Prioridad |
|---|---------|-----------|
| O1 | Verificar la disponibilidad y salud de los cuatro componentes del sistema (backend, BD, frontend, móvil) | Crítica |
| O2 | Validar el ciclo completo de autenticación y autorización (login, refresh, permisos por rol) | Crítica |
| O3 | Confirmar la funcionalidad de planificación de rutas con integración geoespacial (Google Maps + PostGIS) | Crítica |
| O4 | Verificar la integridad del esquema de base de datos (6 esquemas, 36 tablas, 17 ENUMs, extensiones) | Alta |
| O5 | Validar los flujos de usuario final y administrador en web y móvil | Alta |
| O6 | Generar evidencia formal para la autorización de paso a producción | Crítica |

### 2.3 Alcance del aseguramiento de calidad

| Componente | Alcance | Fuera de alcance |
|-----------|---------|-----------------|
| **Backend API** | Autenticación, autorización, CRUD de rutas/POIs, favoritos, calificaciones, reportes, viajes, estadísticas, notificaciones, configuración, integraciones | Rendimiento bajo carga (load testing), pruebas de fuzzing |
| **Base de Datos** | Integridad de esquema, tipos ENUM, extensiones PostGIS, constraints, datos seed | Tuning de rendimiento de queries |
| **Frontend Web** | Flujos de usuario en navegador (Chrome, Firefox), responsive básico | Compatibilidad cross-browser exhaustiva, pruebas de accesibilidad WCAG |
| **App Móvil** | Login, planificación de rutas, perfil con foto, modo invitado | Pruebas en múltiples dispositivos físicos, pruebas de rendimiento en móvil |
| **APIs externas** | Google Maps (Directions, Geocode, Places), Google Weather | Disponibilidad de los servicios de Google (SLA de terceros) |

### 2.4 Entorno de pruebas

| Parámetro | Valor |
|-----------|-------|
| **Base de datos** | PostgreSQL 16 + PostGIS 3.5 (docker: `postgis/postgis:16-3.5`) |
| **Backend** | .NET 9, ASPNETCORE_ENVIRONMENT=Production |
| **Frontend** | Vite build de producción, nginx proxy |
| **Datos de prueba** | Admin seed: `admin@ecoruteando.com` / `EcoAdmin!2026` |
| **Cuenta de prueba adicional** | Usuario registrado con rol User |

### 2.5 Convención de resultados

| Resultado | Significado |
|-----------|------------|
| ✅ **PASS** | La prueba se ejecutó y el resultado cumple el criterio de aceptación |
| ❌ **FAIL** | La prueba se ejecutó y el resultado NO cumple el criterio de aceptación |
| ⏭️ **BLOCKED** | La prueba no pudo ejecutarse por dependencia de otra prueba fallida |
| ⬜ **PENDIENTE** | La prueba aún no ha sido ejecutada |

---

## 3. Pruebas de humo (Smoke Tests)

Las pruebas de humo se ejecutan inmediatamente después de cada despliegue para verificar que los componentes críticos del sistema están operativos. Son pruebas de verificación rápida que no profundizan en lógica de negocio.

### 3.1 Salud del sistema

| ID | Descripción | Endpoint / Acción | Método HTTP | Criterio de aceptación | Resultado |
|----|------------|-------------------|-------------|----------------------|-----------|
| S-01 | Backend responde correctamente | `GET /api/test/public` | GET | HTTP 200 — JSON con campo `status` = `healthy` | ⬜ |
| S-02 | Frontend carga la página principal | Abrir `http://localhost:3007` en navegador | — | HTTP 200 — Página de login renderizada sin errores en consola | ⬜ |
| S-03 | PostgreSQL acepta conexiones | `pg_isready -U postgres -d ecoRuteando_db` | TCP | Mensaje: `accepting connections` | ⬜ |
| S-04 | Liquibase completó todas las migraciones | `SELECT COUNT(*) FROM databasechangelog` | SQL | Resultado = 77 | ⬜ |
| S-05 | Swagger UI accesible | `GET /swagger/index.html` | GET | HTTP 200 — Interfaz Swagger cargada | ⬜ |
| S-06 | Proxy nginx funciona (frontend → backend) | `GET http://localhost:3007/api/test/public` | GET | HTTP 200 — Respuesta del backend a través del proxy | ⬜ |

### 3.2 Autenticación básica

| ID | Descripción | Endpoint / Acción | Método HTTP | Criterio de aceptación | Resultado |
|----|------------|-------------------|-------------|----------------------|-----------|
| S-07 | Login con credenciales válidas (admin) | `POST /api/auth/login` | POST | HTTP 200 — JSON con `token` (JWT) y `refreshToken` | ⬜ |
| S-08 | Login con credenciales inválidas es rechazado | `POST /api/auth/login` con contraseña incorrecta | POST | HTTP 401 — Mensaje de error de autenticación | ⬜ |
| S-09 | Endpoint protegido acepta token válido | `GET /api/auth/me` con header `Authorization: Bearer <token>` | GET | HTTP 200 — JSON con datos del usuario autenticado (`email`, `fullName`, `role`) | ⬜ |
| S-10 | Endpoint protegido rechaza sin token | `GET /api/auth/me` sin header de autorización | GET | HTTP 401 — Error de autenticación | ⬜ |
| S-11 | Refresh token funciona correctamente | `POST /api/auth/refresh` con `refreshToken` válido | POST | HTTP 200 — Nuevo `token` y `refreshToken` | ⬜ |

### 3.3 Persistencia y datos seed

| ID | Descripción | Endpoint / Acción | Método HTTP | Criterio de aceptación | Resultado |
|----|------------|-------------------|-------------|----------------------|-----------|
| S-12 | Roles seed existen en la BD | `SELECT COUNT(*) FROM security.roles` | SQL | Resultado ≥ 2 (User, Admin) | ⬜ |
| S-13 | Permisos seed existen en la BD | `SELECT COUNT(*) FROM security.permissions` | SQL | Resultado = 22 | ⬜ |
| S-14 | Admin seed existe y tiene rol Admin | `SELECT u.email, r.name FROM security.users u JOIN security.user_roles ur ON u.id = ur.user_id JOIN security.roles r ON ur.role_id = r.id WHERE u.email = 'admin@ecoruteando.com'` | SQL | 1 fila — `r.name` = `Admin` | ⬜ |
| S-15 | Factores de transporte seed existen | `SELECT COUNT(*) FROM admin.transport_factors` | SQL | Resultado ≥ 4 | ⬜ |

**Resumen de pruebas de humo:**

| Total | PASS | FAIL | BLOCKED | PENDIENTE |
|-------|------|------|---------|-----------|
| 15 | ⬜ | ⬜ | ⬜ | 15 |

---

## 4. Pruebas de integración técnica y de servicios

Estas pruebas validan la correcta interacción entre los componentes del sistema, la integración con APIs externas y la lógica de negocio del backend.

### 4.1 Integración Backend ↔ Base de Datos

| ID | Descripción | Endpoint / Acción | Criterio de aceptación | Resultado |
|----|------------|-------------------|----------------------|-----------|
| I-01 | Creación de ruta persiste en la BD | `POST /api/routes` con datos válidos | HTTP 201 — La ruta aparece en `SELECT * FROM mobility.routes ORDER BY created_at DESC LIMIT 1` | ⬜ |
| I-02 | Consulta de rutas filtra por usuario | `GET /api/routes?mine=true` con token de usuario A | HTTP 200 — Solo retorna rutas creadas por usuario A (`created_by` = A) | ⬜ |
| I-03 | Eliminación de ruta elimina registros asociados | `DELETE /api/routes/{id}` — verificar `route_pois` | HTTP 204 — Registros en `mobility.route_pois` con `route_id` eliminados | ⬜ |
| I-04 | Transacción de calificación es atómica | `POST /api/ratings` — verificar `ratings` y `rating_votes` | HTTP 201 — Calificación creada; sin registros huérfanos | ⬜ |

### 4.2 Integración con Google Maps API

| ID | Descripción | Endpoint / Acción | Criterio de aceptación | Resultado |
|----|------------|-------------------|----------------------|-----------|
| I-05 | Directions retorna ruta válida | `GET /api/maps/directions?origin=2.9273,-75.2819&destination=2.9300,-75.2850&mode=driving` | HTTP 200 — JSON con `polyline`, `distance_meters` > 0, `duration_seconds` > 0 | ⬜ |
| I-06 | Geocodificación directa funciona | `GET /api/maps/geocode?address=Neiva,Colombia` | HTTP 200 — JSON con `lat` ≈ 2.9273, `lng` ≈ -75.2819 | ⬜ |
| I-07 | Geocodificación inversa funciona | `GET /api/maps/reverse-geocode?lat=2.9273&lng=-75.2819` | HTTP 200 — JSON con dirección formateada | ⬜ |
| I-08 | Places retorna resultados | `GET /api/maps/places?query=restaurantes+Neiva` | HTTP 200 — JSON con array de lugares (nombre, ubicación) | ⬜ |
| I-09 | API key inválida retorna error controlado | `GET /api/maps/directions` con API key inválida | HTTP 4xx/5xx — Error controlado (no exception no capturada) | ⬜ |
| I-10 | Timeout de Google Maps está configurado | Llamada a Directions con red lenta simulada | Tiempo máximo de espera ≤ 10 segundos; error controlado si excede | ⬜ |

### 4.3 Integración con Google Weather API

| ID | Descripción | Endpoint / Acción | Criterio de aceptación | Resultado |
|----|------------|-------------------|----------------------|-----------|
| I-11 | Clima actual retorna datos | `GET /api/weather/current?lat=2.9273&lng=-75.2819` | HTTP 200 — JSON con `temperature`, `humidity`, `condition` | ⬜ |
| I-12 | Clima por ruta retorna datos a lo largo del trayecto | `GET /api/weather/route?origin=...&destination=...` | HTTP 200 — JSON con datos climáticos en puntos de la ruta | ⬜ |
| I-13 | Caché de clima funciona | `GET /api/weather/current` dos veces consecutivas | Segunda respuesta más rápida (cacheada en `integrations.api_cache`) | ⬜ |

### 4.4 Integración con OAuth Google

| ID | Descripción | Endpoint / Acción | Criterio de aceptación | Resultado |
|----|------------|-------------------|----------------------|-----------|
| I-14 | Login OAuth Google funciona | `POST /api/auth/oauth/login` con `idToken` de Google válido | HTTP 200 — JSON con `token` y datos del usuario | ⬜ |
| I-15 | OAuth crea usuario nuevo si no existe | Primer login OAuth con email no registrado | HTTP 200 — Usuario creado en `security.users`, sesión activa | ⬜ |
| I-16 | OAuth vincula cuenta existente | Login OAuth con email que ya tiene cuenta local | HTTP 200 — Cuenta vinculada en `security.oauth_accounts` | ⬜ |
| I-17 | Token OAuth inválido es rechazado | `POST /api/auth/oauth/login` con token manipulado | HTTP 401 — Error de autenticación | ⬜ |

### 4.5 Integración SMTP (correo electrónico)

| ID | Descripción | Endpoint / Acción | Criterio de aceptación | Resultado |
|----|------------|-------------------|----------------------|-----------|
| I-18 | Registro envía email de verificación | `POST /api/auth/register` con email válido | HTTP 201 — Correo de verificación enviado (verificar logs SMTP) | ⬜ |
| I-19 | Verificación de email funciona | `POST /api/auth/verify-email` con token del correo | HTTP 200 — `email_verified` = `true` en BD | ⬜ |
| I-20 | Recuperación de contraseña envía correo | `POST /api/auth/forgot-password` con email registrado | HTTP 200 — Correo de restablecimiento enviado | ⬜ |
| I-21 | Reset de contraseña funciona | `POST /api/auth/reset-password` con token válido y nueva contraseña | HTTP 200 — Contraseña actualizada; login con nueva contraseña funciona | ⬜ |

> **Nota:** Las pruebas I-18 a I-21 dependen del servicio SMTP. En el entorno Docker actual, SMTP puede no estar operativo (hallazgo AC-02 del documento de acciones correctivas). Marcar como BLOCKED si SMTP no responde.

### 4.6 Lógica de negocio — Cálculos de sostenibilidad

| ID | Descripción | Endpoint / Acción | Criterio de aceptación | Resultado |
|----|------------|-------------------|----------------------|-----------|
| I-22 | Estimación de CO₂ es consistente | `GET /api/sustainability/estimate?distance=1000&transport=driving` | HTTP 200 — `co2_grams` dentro de rango esperado (> 0, < 500 para 1km en carro) | ⬜ |
| I-23 | Estimación de calorías es consistente | `GET /api/sustainability/estimate?distance=1000&transport=walking` | HTTP 200 — `calories` dentro de rango esperado (> 0, < 200 para 1km caminando) | ⬜ |
| I-24 | Factores de transporte afectan el cálculo | Misma distancia con `transport=driving` vs `transport=walking` | CO₂ del carro > CO₂ caminando | ⬜ |

### 4.7 Autorización y permisos

| ID | Descripción | Endpoint / Acción | Criterio de aceptación | Resultado |
|----|------------|-------------------|----------------------|-----------|
| I-25 | Usuario sin permiso `routes.write` no puede crear rutas | `POST /api/routes` con token de usuario sin permiso | HTTP 403 — Error de autorización | ⬜ |
| I-26 | Usuario con permiso `routes.read` puede listar rutas | `GET /api/routes` con token de usuario con permiso | HTTP 200 — Lista de rutas retornada | ⬜ |
| I-27 | Usuario sin permiso `stats.read` no accede a estadísticas | `GET /api/admin/stats` con token sin permiso | HTTP 403 | ⬜ |
| I-28 | Usuario normal no accede a panel admin | `GET /api/admin/statistics/summary` con token de rol User | HTTP 403 | ⬜ |
| I-29 | Admin sí accede a panel admin | `GET /api/admin/statistics/summary` con token de rol Admin | HTTP 200 — JSON con estadísticas | ⬜ |

### 4.8 Rate limiting y seguridad

| ID | Descripción | Endpoint / Acción | Criterio de aceptación | Resultado |
|----|------------|-------------------|----------------------|-----------|
| I-30 | Login fallido incrementa intentos | 3 logins fallidos consecutivos | HTTP 401 cada uno; contador de intentos registrado en `security_audit` | ⬜ |
| I-31 | Cuenta se bloquea tras intentos excedidos | 5+ logins fallidos consecutivos | HTTP 401/403 — Cuenta bloqueada temporalmente (según `security_policies`) | ⬜ |
| I-32 | Refresh token se invalida tras uso | `POST /api/auth/refresh` — usar el mismo refresh token dos veces | Primera: HTTP 200; Segunda: HTTP 401 (token ya rotado) | ⬜ |
| I-33 | SQL injection es prevenido | `GET /api/routes?name='; DROP TABLE mobility.routes;--` | HTTP 200/400 — Sin error de BD; tabla intacta | ⬜ |

**Resumen de pruebas de integración:**

| Total | PASS | FAIL | BLOCKED | PENDIENTE |
|-------|------|------|---------|-----------|
| 33 | ⬜ | ⬜ | ⬜ | 33 |

---

## 5. Pruebas de integración con base de datos

Estas pruebas verifican la integridad del esquema de base de datos, incluyendo esquemas, tablas, tipos ENUM, restricciones, índices y extensiones espaciales.

### 5.1 Verificación de esquemas

| ID | Descripción | SQL / Comando | Criterio de aceptación | Resultado |
|----|------------|---------------|----------------------|-----------|
| DB-01 | Los 6 esquemas existen | `SELECT schema_name FROM information_schema.schemata WHERE schema_name IN ('security','mobility','community','admin','integrations','notifications')` | 6 filas retornadas | ⬜ |
| DB-02 | Esquema `security` tiene 14 tablas | `SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = 'security'` | Resultado = 14 | ⬜ |
| DB-03 | Esquema `mobility` tiene 10 tablas | `SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = 'mobility'` | Resultado = 10 | ⬜ |
| DB-04 | Esquema `community` tiene 5 tablas | `SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = 'community'` | Resultado = 5 | ⬜ |
| DB-05 | Esquema `admin` tiene 6 tablas | `SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = 'admin'` | Resultado = 6 | ⬜ |
| DB-06 | Esquema `integrations` tiene 3 tablas | `SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = 'integrations'` | Resultado = 3 | ⬜ |
| DB-07 | Esquema `notifications` tiene 3 tablas | `SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = 'notifications'` | Resultado = 3 | ⬜ |

### 5.2 Verificación de tablas críticas

| ID | Descripción | SQL / Comando | Criterio de aceptación | Resultado |
|----|------------|---------------|----------------------|-----------|
| DB-08 | Tabla `security.users` existe con columnas clave | `SELECT column_name FROM information_schema.columns WHERE table_schema='security' AND table_name='users'` | Incluye: `id`, `email`, `password_hash`, `full_name`, `email_verified`, `profile_photo_url`, `created_at` | ⬜ |
| DB-09 | Tabla `mobility.routes` existe con columnas geoespaciales | Verificar columnas `origin`, `destination`, `geometry` con tipo `GEOGRAPHY` | 3 columnas de tipo `GEOGRAPHY(POINT/LINESTRING, 4326)` | ⬜ |
| DB-10 | Tabla `security.refresh_tokens` existe | `SELECT COUNT(*) FROM information_schema.tables WHERE table_schema='security' AND table_name='refresh_tokens'` | Resultado = 1 | ⬜ |
| DB-11 | Tabla `community.obstacle_reports` existe | `SELECT COUNT(*) FROM information_schema.tables WHERE table_schema='community' AND table_name='obstacle_reports'` | Resultado = 1 | ⬜ |
| DB-12 | Tabla `admin.transport_factors` existe con datos | `SELECT COUNT(*) FROM admin.transport_factors` | Resultado ≥ 4 | ⬜ |

### 5.3 Verificación de tipos ENUM

| ID | Descripción | SQL / Comando | Criterio de aceptación | Resultado |
|----|------------|---------------|----------------------|-----------|
| DB-13 | 17 ENUMs creados | `SELECT COUNT(DISTINCT t.typname) FROM pg_type t JOIN pg_enum e ON t.oid = e.enumtypid JOIN pg_namespace n ON t.typnamespace = n.oid WHERE n.nspname IN ('security','mobility','community','admin','integrations','notifications')` | Resultado ≥ 17 | ⬜ |
| DB-14 | ENUM `route_type` tiene 4 valores | `SELECT e.enumlabel FROM pg_type t JOIN pg_enum e ON t.oid = e.enumtypid WHERE t.typname = 'route_type' ORDER BY e.enumsortorder` | 4 valores: `walking`, `driving`, `bicycling`, `transit` | ⬜ |
| DB-15 | ENUM `route_status` tiene 5 valores | `SELECT e.enumlabel FROM pg_type t JOIN pg_enum e ON t.oid = e.enumtypid WHERE t.typname = 'route_status' ORDER BY e.enumsortorder` | 5 valores: `planned`, `in_progress`, `completed`, `cancelled`, `interrupted` | ⬜ |
| DB-16 | ENUM `report_status` tiene 4 valores | `SELECT e.enumlabel FROM pg_type t JOIN pg_enum e ON t.oid = e.enumtypid WHERE t.typname = 'report_status' ORDER BY e.enumsortorder` | 4 valores: `pending`, `validated`, `rejected`, `resolved` | ⬜ |
| DB-17 | ENUM `user_status` tiene 4 valores | `SELECT e.enumlabel FROM pg_type t JOIN pg_enum e ON t.oid = e.enumtypid WHERE t.typname = 'user_status' ORDER BY e.enumsortorder` | 4 valores: `active`, `inactive`, `suspended`, `locked` | ⬜ |

### 5.4 Verificación de extensiones espaciales (PostGIS)

| ID | Descripción | SQL / Comando | Criterio de aceptación | Resultado |
|----|------------|---------------|----------------------|-----------|
| DB-18 | PostGIS está habilitado | `SELECT PostGIS_Version()` | Versión 3.x retornada | ⬜ |
| DB-19 | Extensión `postgis` instalada | `SELECT extname FROM pg_extension WHERE extname = 'postgis'` | 1 fila: `postgis` | ⬜ |
| DB-20 | Extensión `pgcrypto` instalada | `SELECT extname FROM pg_extension WHERE extname = 'pgcrypto'` | 1 fila: `pgcrypto` | ⬜ |
| DB-21 | Extensión `unaccent` instalada | `SELECT extname FROM pg_extension WHERE extname = 'unaccent'` | 1 fila: `unaccent` | ⬜ |
| DB-22 | Extensión `pg_trgm` instalada | `SELECT extname FROM pg_extension WHERE extname = 'pg_trgm'` | 1 fila: `pg_trgm` | ⬜ |
| DB-23 | Extensión `citext` instalada | `SELECT extname FROM pg_extension WHERE extname = 'citext'` | 1 fila: `citext` | ⬜ |
| DB-24 | Columnas geoespaciales registradas en `geometry_columns` | `SELECT f_table_schema, f_table_name, f_geometry_column FROM geometry_columns WHERE f_table_schema IN ('mobility','community')` | ≥ 3 columnas geoespaciales | ⬜ |

### 5.5 Verificación de restricciones e integridad

| ID | Descripción | SQL / Comando | Criterio de aceptación | Resultado |
|----|------------|---------------|----------------------|-----------|
| DB-25 | `users.email` es UNIQUE | Intentar insertar dos usuarios con el mismo email | Segundo INSERT falla con violación de constraint UNIQUE | ⬜ |
| DB-26 | `users.email` es case-insensitive (citext) | Insertar email en mayúsculas, luego intentar duplicado en minúsculas | Segundo INSERT falla (citext compara sin distinguir mayúsculas) | ⬜ |
| DB-27 | Foreign key `user_roles.user_id` → `users.id` existe | `SELECT conname FROM pg_constraint WHERE conrelid = 'security.user_roles'::regclass AND contype = 'f'` | ≥ 1 foreign key | ⬜ |
| DB-28 | Foreign key `refresh_tokens.user_id` → `users.id` existe | `SELECT conname FROM pg_constraint WHERE conrelid = 'security.refresh_tokens'::regclass AND contype = 'f'` | ≥ 1 foreign key | ⬜ |
| DB-29 | IDs son UUID con default `gen_random_uuid()` | `SELECT column_default FROM information_schema.columns WHERE table_schema='security' AND table_name='users' AND column_name='id'` | `gen_random_uuid()` | ⬜ |
| DB-30 | Columna `users.profile_photo_url` es TEXT | `SELECT data_type FROM information_schema.columns WHERE table_schema='security' AND table_name='users' AND column_name='profile_photo_url'` | `text` | ⬜ |

### 5.6 Verificación de datos seed

| ID | Descripción | SQL / Comando | Criterio de aceptación | Resultado |
|----|------------|---------------|----------------------|-----------|
| DB-31 | Roles seed: User y Admin | `SELECT name FROM security.roles ORDER BY name` | ≥ 2 filas: `Admin`, `User` | ⬜ |
| DB-32 | 22 permisos sembrados | `SELECT COUNT(*) FROM security.permissions` | Resultado = 22 | ⬜ |
| DB-33 | Admin tiene todos los permisos | `SELECT COUNT(*) FROM security.role_permissions rp JOIN security.roles r ON rp.role_id = r.id WHERE r.name = 'Admin'` | Resultado = 22 | ⬜ |
| DB-34 | Security policy sembrada | `SELECT COUNT(*) FROM security.security_policies` | Resultado ≥ 1 | ⬜ |
| DB-35 | 77 changesets aplicados | `SELECT COUNT(*) FROM databasechangelog` | Resultado = 77 | ⬜ |

**Resumen de pruebas de base de datos:**

| Total | PASS | FAIL | BLOCKED | PENDIENTE |
|-------|------|------|---------|-----------|
| 35 | ⬜ | ⬜ | ⬜ | 35 |

---

## 6. Pruebas de aceptación de usuario (UAT)

Los casos de UAT validan los flujos completos desde la perspectiva del usuario final y del administrador del sistema, en la aplicación web y en la aplicación móvil.

### 6.1 Flujo de registro y autenticación (Usuario web)

| ID | Caso de prueba | Pasos | Resultado esperado | Resultado |
|----|---------------|-------|-------------------|-----------|
| U-01 | Registro de nuevo usuario | 1. Abrir frontend → 2. Click "Registrarse" → 3. Completar nombre, email, contraseña → 4. Click "Crear cuenta" | Cuenta creada; mensaje de confirmación visible; email de verificación enviado | ⬜ |
| U-02 | Verificación de email | 1. Abrir correo de verificación → 2. Click en enlace | Cuenta verificada; mensaje de éxito; redirección a login | ⬜ |
| U-03 | Login con credenciales válidas | 1. Ir a login → 2. Ingresar email y contraseña → 3. Click "Ingresar" | Acceso al dashboard; nombre de usuario visible en header | ⬜ |
| U-04 | Login con credenciales inválidas | 1. Ir a login → 2. Ingresar contraseña incorrecta → 3. Click "Ingresar" | Mensaje de error "Credenciales inválidas"; permanece en login | ⬜ |
| U-05 | Login con OAuth Google | 1. Click "Continuar con Google" → 2. Seleccionar cuenta Google | Acceso al dashboard sin ingresar contraseña | ⬜ |
| U-06 | Logout | 1. Click en menú de usuario → 2. Click "Cerrar sesión" | Redirección a login; token eliminado del navegador | ⬜ |

### 6.2 Flujo de planificación de rutas (Usuario web)

| ID | Caso de prueba | Pasos | Resultado esperado | Resultado |
|----|---------------|-------|-------------------|-----------|
| U-07 | Planificar ruta básica | 1. Ir a "Planificar ruta" → 2. Ingresar origen "Neiva" → 3. Ingresar destino "Pitalito" → 4. Seleccionar "Carro" → 5. Click "Calcular" | Ruta mostrada en el mapa; distancia y duración visibles | ⬜ |
| U-08 | Ver estimación de CO₂ | 1. Planificar ruta → 2. Revisar panel de estimaciones | Valor de CO₂ (gramos) mostrado; valor de calorías mostrado | ⬜ |
| U-09 | Cambiar tipo de transporte | 1. Planificar ruta → 2. Cambiar de "Carro" a "Caminando" | Ruta recalculada; nueva distancia y duración; nuevo CO₂ | ⬜ |
| U-10 | Guardar ruta | 1. Planificar ruta → 2. Click "Guardar" → 3. Ingresar nombre → 4. Click "Confirmar" | Ruta guardada; aparece en "Mis rutas" | ⬜ |
| U-11 | Ver rutas guardadas | 1. Ir a "Mis rutas" | Lista de rutas guardadas visible con nombre, distancia, tipo | ⬜ |
| U-12 | Marcar ruta como favorita | 1. En "Mis rutas" → 2. Click en estrella de una ruta | Estrella cambiada a color; ruta aparece en "Favoritos" | ⬜ |
| U-13 | Eliminar ruta | 1. En "Mis rutas" → 2. Click en ícono de eliminar → 3. Confirmar | Ruta eliminada de la lista; ya no aparece | ⬜ |
| U-14 | Calificar ruta | 1. Abrir detalle de ruta → 2. Seleccionar 4 estrellas → 3. Agregar comentario → 4. Submit | Calificación registrada; promedio actualizado | ⬜ |
| U-15 | Compartir ruta | 1. Abrir detalle de ruta → 2. Click "Compartir" → 3. Copiar enlace | Enlace de compartir generado con token | ⬜ |

### 6.3 Flujo de reporte de obstáculos (Usuario web)

| ID | Caso de prueba | Pasos | Resultado esperado | Resultado |
|----|---------------|-------|-------------------|-----------|
| U-16 | Ver obstáculos en el mapa | 1. Ir a "Reportes" o "Mapa de obstáculos" | Marcadores de obstáculos visibles en el mapa | ⬜ |
| U-17 | Crear reporte de obstáculo | 1. Click "Reportar obstáculo" → 2. Tomar/seleccionar foto → 3. Permitir acceso a GPS → 4. Seleccionar categoría → 5. Agregar descripción → 6. Submit | Reporte creado; marcador aparece en el mapa | ⬜ |
| U-18 | Votar un reporte | 1. Abrir reporte existente → 2. Click "Útil" o "No útil" | Voto registrado; contador de votos actualizado | ⬜ |
| U-19 | Ver mis reportes | 1. Ir a "Mis reportes" | Lista de reportes creados por el usuario con estado | ⬜ |

### 6.4 Flujo de historial de viajes (Usuario web)

| ID | Caso de prueba | Pasos | Resultado esperado | Resultado |
|----|---------------|-------|-------------------|-----------|
| U-20 | Iniciar un viaje | 1. Seleccionar ruta → 2. Click "Iniciar viaje" | Viaje registrado con `started_at`; estado = `in_progress` | ⬜ |
| U-21 | Completar un viaje | 1. Durante viaje activo → 2. Click "Completar" | Viaje finalizado; `ended_at` registrado; CO₂ ahorrado calculado | ⬜ |
| U-22 | Ver historial de viajes | 1. Ir a "Historial" | Lista de viajes con fecha, ruta, distancia, CO₂ ahorrado | ⬜ |
| U-23 | Ver estadísticas personales | 1. Ir a "Estadísticas" o perfil | Total de rutas, viajes completados, CO₂ ahorrado, calorías | ⬜ |

### 6.5 Flujo de notificaciones (Usuario web)

| ID | Caso de prueba | Pasos | Resultado esperado | Resultado |
|----|---------------|-------|-------------------|-----------|
| U-24 | Ver notificaciones | 1. Ir a "Notificaciones" o click en campana | Lista de notificaciones visible; no leídas destacadas | ⬜ |
| U-25 | Conteo de no leídas | Observar badge junto al ícono de campana | Número correcto de notificaciones no leídas | ⬜ |
| U-26 | Marcar como leída | 1. Click en notificación no leída → 2. O click "Marcar todas" | Notificación marcada como leída; contador decrementado | ⬜ |

### 6.6 Flujo de perfil de usuario (Usuario web)

| ID | Caso de prueba | Pasos | Resultado esperado | Resultado |
|----|---------------|-------|-------------------|-----------|
| U-27 | Ver perfil | 1. Ir a "Perfil" | Datos visibles: nombre, email, foto (si tiene) | ⬜ |
| U-28 | Editar perfil | 1. Click "Editar" → 2. Cambiar nombre → 3. Guardar | Perfil actualizado; nuevo nombre visible | ⬜ |
| U-29 | Cambiar contraseña | 1. Ir a "Cambiar contraseña" → 2. Ingresar actual y nueva → 3. Guardar | Contraseña actualizada; login con nueva contraseña funciona | ⬜ |
| U-30 | Subir foto de perfil | 1. Ir a perfil → 2. Click en foto → 3. Seleccionar imagen → 4. Esperar upload | Foto de perfil visible y persistente tras recargar página | ⬜ |

### 6.7 Flujo de administración (Admin web)

| ID | Caso de prueba | Pasos | Resultado esperado | Resultado |
|----|---------------|-------|-------------------|-----------|
| U-31 | Acceder al panel de administración | 1. Login como admin → 2. Ir a "Administración" | Dashboard admin visible con estadísticas | ⬜ |
| U-32 | Ver estadísticas del sistema | 1. En panel admin → 2. Revisar dashboard | Totales de usuarios, rutas, viajes, reportes visibles | ⬜ |
| U-33 | Listar usuarios | 1. Ir a "Usuarios" en panel admin | Lista de usuarios con email, nombre, rol, estado | ⬜ |
| U-34 | Editar un usuario | 1. Seleccionar usuario → 2. Cambiar rol o estado → 3. Guardar | Cambio aplicado; visible en lista | ⬜ |
| U-35 | Moderar reportes de obstáculos | 1. Ir a "Reportes" en panel admin → 2. Seleccionar reporte pendiente → 3. Validar o Rechazar | Estado del reporte actualizado (`validated` o `rejected`) | ⬜ |
| U-36 | Exportar datos | 1. Ir a "Exportes" → 2. Seleccionar tipo (viajes/stats) → 3. Click "Exportar" → 4. Descargar | Archivo CSV/Excel descargado con datos correctos | ⬜ |
| U-37 | Ver configuración del sistema | 1. Ir a "Configuración" | Valores de factores de transporte y políticas visibles | ⬜ |
| U-38 | Editar factores de transporte | 1. Ir a "Factores de transporte" → 2. Editar factor → 3. Guardar | Factor actualizado; cálculos de CO₂ afectados en nuevas rutas | ⬜ |
| U-39 | Gestionar tickets de soporte | 1. Ir a "Soporte" → 2. Ver tickets → 3. Responder ticket → 4. Cambiar estado | Mensaje agregado; estado actualizado | ⬜ |

### 6.8 Flujo de aplicación móvil

| ID | Caso de prueba | Pasos | Resultado esperado | Resultado |
|----|---------------|-------|-------------------|-----------|
| U-40 | Login en móvil | 1. Abrir app → 2. Ingresar credenciales → 3. Login | Acceso al dashboard móvil; pestañas visibles | ⬜ |
| U-41 | Planificar ruta en móvil | 1. Ir a planificador → 2. Ingresar origen y destino → 3. Seleccionar transporte → 4. Calcular | Ruta en mapa móvil; estimaciones visibles | ⬜ |
| U-42 | Ver rutas guardadas en móvil | 1. Ir a "Rutas" o "Mis rutas" | Lista de rutas sincronizadas con el backend | ⬜ |
| U-43 | Subir foto de perfil en móvil | 1. Ir a perfil → 2. Tocar foto → 3. Seleccionar de galería → 4. Esperar upload | Foto visible en perfil; persiste tras cerrar y abrir la app | ⬜ |
| U-44 | Avatar por cuenta en móvil | 1. Login con cuenta A → 2. Ver avatar → 3. Logout → 4. Login con cuenta B | Avatar de cuenta A no aparece en cuenta B; cada cuenta muestra su propio avatar | ⬜ |
| U-45 | Modo invitado en móvil | 1. En pantalla de login → 2. Click "Entrar como invitado" | Acceso limitado; funciones de guardado deshabilitadas | ⬜ |
| U-46 | Notificaciones en móvil | 1. Ir a pestaña de notificaciones | Lista de notificaciones visible; badge de no leídas | ⬜ |

**Resumen de pruebas UAT:**

| Total | PASS | FAIL | BLOCKED | PENDIENTE |
|-------|------|------|---------|-----------|
| 46 | ⬜ | ⬜ | ⬜ | 46 |

---

## 7. Resumen y criterios de cierre de pruebas

### 7.1 Resumen ejecutivo de resultados

| Nivel de prueba | Total | PASS | FAIL | BLOCKED | PENDIENTE | % Éxito |
|----------------|-------|------|------|---------|-----------|---------|
| **Humo (S)** | 15 | ⬜ | ⬜ | ⬜ | 15 | ⬜% |
| **Integración (I)** | 33 | ⬜ | ⬜ | ⬜ | 33 | ⬜% |
| **Base de Datos (DB)** | 35 | ⬜ | ⬜ | ⬜ | 35 | ⬜% |
| **UAT (U)** | 46 | ⬜ | ⬜ | ⬜ | 46 | ⬜% |
| **TOTAL** | **129** | **⬜** | **⬜** | **⬜** | **129** | **⬜%** |

### 7.2 Criterios de cierre por categoría

| Categoría | Criterio de aprobación | Requisito mínimo |
|-----------|----------------------|------------------|
| **Pruebas de humo** | 100% PASS | Obligatorio — cualquier FAIL bloquea el paso a producción |
| **Pruebas de integración** | ≥ 95% PASS | Las pruebas I-18 a I-21 (SMTP) pueden ser BLOCKED con plan de remediación |
| **Pruebas de base de datos** | 100% PASS | Obligatorio — cualquier FAIL indica problema de migración |
| **Pruebas UAT (críticas)** | 100% PASS | U-01 a U-10, U-31 a U-35 son críticas |
| **Pruebas UAT (no críticas)** | ≥ 90% PASS | U-26 a U-30, U-36 a U-46 pueden tener ≤ 10% FAIL con plan de remediación |

### 7.3 Matriz de decisión de cierre

| Escenario | Condición | Decisión |
|-----------|----------|----------|
| ✅ **APROBADO** | 100% humo PASS + 100% BD PASS + ≥ 95% integración PASS + 100% UAT críticas PASS | Autorizar paso a producción |
| ⚠️ **APROBADO CON OBSERVACIONES** | 100% humo PASS + 100% BD PASS + ≥ 90% integración PASS + ≥ 95% UAT PASS + plan de remediación para FAILs | Autorizar paso a producción con compromiso de corrección en sprint siguiente |
| ❌ **RECHAZADO** | Cualquier FAIL en humo o BD + < 90% integración PASS + < 95% UAT PASS | No autorizar paso a producción; plan de corrección obligatorio |

### 7.4 Registro de defectos encontrados

| ID | Prueba | Descripción del defecto | Severidad | Estado | Responsable |
|----|--------|------------------------|-----------|--------|-------------|
| — | — | — | — | — | — |

> *(Completar durante la ejecución de pruebas)*

### 7.5 Plan de remediación para pruebas fallidas

| ID de prueba | Defecto | Acción correctiva | Responsable | Fecha compromiso |
|-------------|---------|-------------------|-------------|-----------------|
| — | — | — | — | — |

> *(Completar durante la ejecución de pruebas)*

### 7.6 Conclusión formal

> Este documento de documentación de pruebas de la plataforma **EcoRuteando v1.0** cubre un total de **129 casos de prueba** distribuidos en 4 niveles: humo (15), integración técnica (33), integración con base de datos (35) y aceptación de usuario (46).
>
> La autorización de paso a producción está condicionada al cumplimiento de los criterios de cierre definidos en la sección 7.2. Cualquier prueba categorizada como FAIL deberá ser documentada en la matriz de defectos (sección 7.4) con su respectivo plan de remediación.
>
> **Fecha de ejecución de pruebas:** ___/___/______
>
> **Resultado global:** ⬜ APROBADO / ⬜ APROBADO CON OBSERVACIONES / ⬜ RECHAZADO

### 7.7 Firmas de aprobación

| Rol | Nombre | Firma | Fecha |
|-----|--------|-------|-------|
| **QA Engineer** (responsable de pruebas) | _____________ | _____________ | ___/___/______ |
| **DevOps Engineer** (verificación de despliegue) | _____________ | _____________ | ___/___/______ |
| **Desarrollador Líder** (responsable técnico) | _____________ | _____________ | ___/___/______ |
| **Cliente / Gestor** (aprobación final UAT) | _____________ | _____________ | ___/___/______ |

---

### Anexo A: Cobertura de endpoints por prueba

| Módulo | Controllers | Endpoints | Cubiertos por pruebas | Cobertura |
|--------|------------|-----------|----------------------|-----------|
| Security | 8 | ~40 | S-07 a S-11, I-14 a I-17, I-25 a I-33, U-01 a U-06, U-27 a U-30 | ~80% |
| Mobility | 11 | ~35 | I-01 a I-04, I-05 a I-08, I-22 a I-24, U-07 a U-23 | ~75% |
| Notifications | 2 | 8 | U-24 a U-26, U-46 | ~50% |
| Admin | 5 | ~18 | I-27 a I-29, U-31 a U-39 | ~70% |
| Integrations | 3 | 9 | I-05 a I-13 | ~65% |
| **Total** | **29** | **~110** | — | **~72%** |

### Anexo B: Datos de prueba utilizados

| Tipo | Valor | Uso |
|------|-------|-----|
| Admin email | `admin@ecoruteando.com` | Login admin |
| Admin password | `EcoAdmin!2026` | Login admin |
| Origen por defecto | `2.9273, -75.2819` (Neiva) | Planificación de rutas |
| Destino por defecto | `2.9300, -75.2850` | Planificación de rutas |
| Distancia de prueba | 1000 metros | Estimaciones CO₂/calorías |

---

*Documentación de Pruebas — EcoRuteando v1.0 — 13 de octubre de 2026*
