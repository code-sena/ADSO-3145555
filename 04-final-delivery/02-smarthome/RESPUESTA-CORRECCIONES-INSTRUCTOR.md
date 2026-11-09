# Respuesta a las observaciones del instructor: SmartHome

SENA ADSO, ficha 3145555. Actualizado el 2026-11-08.

**Tabla 1**

*Estado de cada observación*

| # | Observación | Qué se hizo | Dónde verlo | Lo hace |
|---|---|---|---|---|
| 1 | Release `final-delivery` con dos ZIP por repositorio | Procedimiento y enlaces listos. Los ZIP se generan sobre el tag, después de fusionar los PR de código a `main` | [`code-tag/`](code-tag/README.md) | Kevin, tras las fusiones |
| 2 | Unir los PR #13 y #17 | El PR #17 contiene todo lo del #13 | [PR #17](https://github.com/code-sena/ADSO-3145555/pull/17) | Karen cierra el [#13](https://github.com/code-sena/ADSO-3145555/pull/13) sin fusionar |
| 3 | Un elemento de Drive pide permiso | Carpetas y videos compartidos como lector; comprobado sin iniciar sesión el 2026-11-09 | [Accesos de Drive](AUDITORIA-ACCESO-DRIVE.md) | Hecho |
| 4 | Sección 01 solo enlaza el SRS | SRS final en PDF dentro de la carpeta | [`01-requirements-specification/`](01-requirements-specification/requirements-specification.pdf) | Hecho |
| 5 | Secciones 02, 04, 05, 06 y 09 solo en Markdown | PDF y DOCX editable en todas las secciones 02–09, en Arial 11 pt, con tablas numeradas y referencias APA 7 | [README](README.md#delivery-contents--contenido-de-la-entrega) | Hecho |
| 6 | Dos repositorios de documentación | `smart-home-doc` es el oficial; `smart-home-docs` es histórico. Igual con `smarthome-database` (oficial) y `smart-home-database` (histórico) | [`code-tag/`](code-tag/README.md) | Hecho |
| 7 | Videos: cuál es el pitch y cuál el tutorial | Pitch 01:30 y tutorial 04:54, públicos con permiso de lector (comprobado sin iniciar sesión) | [`10-videos/`](10-videos/README.md) | Hecho |
| 8 | Tag `final-delivery-2026` y dos ZIP en cinco repositorios | Se etiquetan los cinco pedidos y, además, los dos oficiales (siete en total) | [`code-tag/`](code-tag/README.md) | Kevin y Natalia, tras las fusiones |
| 9 | Autorización de datos en el README (0 de 3) | Los tres integrantes autorizaron en comentarios del PR #17; cada casilla enlaza a su comentario | [README](README.md#team-members--integrantes) | Hecho |
| 10 | Rol en `team-roster.md` (0 de 3) | Rol de cada aprendiz, con la tabla de commits como evidencia | [`team-roster.md`](team-roster.md) | Hecho; cada integrante revisa el suyo |
| 11 | Aporte en `software-registration.md` (0 de 3) | Aporte de cada aprendiz en la sección 2 | [`software-registration.md`](software-registration.md) | Hecho |
| 12 | Ocho campos de las secciones 5 y 6 | Sección 5 completa. Sección 6 con el dato técnico de cada opción; la casilla legal la marcan los autores. Sección 8 con 28 componentes de terceros y su licencia | [`software-registration.md`](software-registration.md) | Hecho; secciones 6 y 10 confirmadas por el equipo en el PR #17 |
| 13 | Fecha de entrega y quién entrega | 2026-11-08, Kevin Stiven López Amaya | [README](README.md#general-information--información-general) | Hecho |
| 14 | Acceso de escritura para `ariel5253` | Instrucciones por repositorio | [`code-tag/`](code-tag/README.md#acceso-del-instructor) | Natalia (4 repositorios) y Kevin (3) |

Fuente: elaboración propia.

## Correcciones técnicas frente a la rúbrica

Además de lo administrativo, se corrigió el código de los cinco componentes. Cada cambio llega por PR a `dev` y sigue el flujo `dev → qa → main`.

- **Instalación desde cero:** `smart-home-doc/deploy` levanta todo el sistema con `docker compose up` (PostgreSQL, migraciones, MQTT, correo de prueba, backend y web) y carga usuarios de demostración para los cuatro roles. Una prueba automática de 43 controles pasó completa sobre una instalación limpia ([evidencia](https://github.com/Kevin-Stiven-Lopez-Amaya404/smart-home-doc/tree/main/docs/40-operacion/evidencias-e2e)). PR [smart-home-doc#13](https://github.com/Kevin-Stiven-Lopez-Amaya404/smart-home-doc/pull/13).
- **Backend:** registro atómico (si falla el correo no queda un usuario a medias), filtro global de errores sin exponer SQL, rol SYSTEM_ADMIN con endpoints propios, código muerto eliminado y cobertura unitaria de 71,8 % de líneas con 1.217 pruebas; el CI falla si baja del 70 %.
- **Base de datos:** usuarios de demostración fuera de producción, rollbacks de las últimas migraciones probados en CI y PostgreSQL 18 en todos los entornos.
- **Web:** configuración de nginx por variable (corrige el CI de `main`), archivo de Compose roto eliminado y pruebas unitarias con Vitest en CI.
- **Móvil:** comentarios y registros en inglés, logs de Bluetooth solo en desarrollo, README con Expo SDK 58 y sin vulnerabilidades altas en `npm audit`. PR [from_movil#64](https://github.com/Kevin-Stiven-Lopez-Amaya404/from_movil/pull/64).
- **Uso de IA:** declarado en cada repositorio (`AI_USAGE.md`) y en esta carpeta ([`declaracion-uso-ia.md`](declaracion-uso-ia.md)).

## Limitaciones conocidas

- La cobertura de pruebas unitarias de la web (3,5 %) y del móvil (no medida en porcentaje) está por debajo del 70 % del backend. El móvil tiene pruebas de reglas y contratos que corren en CI.
- La prueba en teléfono Android con un Shelly 1PM Gen4 real tiene protocolo y matriz en [`05-test-documentation/`](05-test-documentation/qa-android-shelly-2026-11-07.pdf), con los casos aún en estado PENDIENTE: requiere el equipo físico y no se puede automatizar en CI. La API completa, en cambio, sí se probó extremo a extremo (43 de 43 controles).
