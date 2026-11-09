# SmartHome

Final delivery of the training project / Entrega final del proyecto formativo.

## General information / Información general

| Field / Campo | Value / Valor |
|---|---|
| Product name / Nombre del producto | SmartHome |
| Ficha | 3145555 |
| Training program / Programa de formación | Análisis y Desarrollo de Software (228118) |
| Training project / Proyecto formativo | Desarrollo de software orientado a servicios |
| Training center / Centro de formación | Centro de la Industria, la Empresa y los Servicios (Regional Huila) |
| Process / Proceso | Completion of the technologist taught stage / Finalización de la etapa lectiva del tecnólogo |
| Research seedbed / Semillero de investigación | Developers & Geeks |
| Delivery version / Versión entregada | `final-delivery-2026` (tag anotado en cada repositorio de código, ver [`code-tag/`](code-tag/)) |
| Delivery date / Fecha de entrega | 2026-11-08 |
| Delivered by / Entregado por | Kevin Stiven López Amaya (`Kevin-Stiven-Lopez-Amaya404`), en nombre del equipo |

## Summary / Resumen

- *Problem it solves / Problema que resuelve:* Facilita la gestión de hogares y dispositivos conectados, el control de dispositivos compatibles y la consulta del consumo eléctrico.

- *Target users / Usuarios:* Propietarios y miembros de hogares que quieren controlar cargas eléctricas con relés Shelly 1PM Gen4 y conocer su consumo y costo estimado. Roles: SYSTEM_ADMIN (plataforma), OWNER, MEMBER y GUEST (por hogar).

- *Main features / Funciones principales:*
  - Autenticación, activación de cuentas y recuperación de contraseñas.
  - Gestión de hogares, invitaciones y membresías.
  - Gestión de dispositivos y órdenes de encendido y apagado.
  - Consulta de consumo eléctrico.
  - Comunicación mediante MQTT y Socket.IO.
  - API de notificaciones.

- *Technology stack / Tecnologías:*
  - Backend: NestJS 11, TypeScript, Prisma 7 y Node.js.
  - Frontend web: React 18, TypeScript y Vite 6.
  - Aplicación móvil: Expo SDK 58, React Native 0.88 y TypeScript.
  - Base de datos: PostgreSQL 18 con Row Level Security.
  - Comunicación: MQTT y Socket.IO.
  - Gestión de migraciones: Liquibase.

- *Production URL / URL en producción:* No se publica una URL de evaluación. El sistema completo se levanta con un comando desde [`smart-home-doc/deploy`](https://github.com/Kevin-Stiven-Lopez-Amaya404/smart-home-doc/tree/main/deploy) (web en `http://localhost:8080`); ver el [manual de instalación](08-manuals/installation-manual.pdf).

- *Demo credentials / Credenciales de prueba:* solo en la instalación local de demostración (datos de `changelog-demo.yaml`, nunca en producción): `admin@example.com`, `owner@example.com`, `member@example.com` y `guest@example.com`, contraseña `SmartHome#2026`.
## Team members / Integrantes

> Names and document types were preloaded from the instructor's roster. Full identification numbers are withheld from this public version pending individual authorization and should be supplied only via the instructor's private registration channel. Each member must verify their row, GitHub account and role.
>
> Los nombres y tipos de documento proceden de la plantilla del instructor. Los números completos se reservan en esta versión pública hasta confirmar autorización individual y deben entregarse por el canal privado del registro. Cada integrante verifica su fila, usuario de GitHub y rol, y reporta errores al instructor.

| Full name / Nombre completo | Doc. type / Tipo | Doc. number / Número | Ficha | GitHub user / Usuario | Role / Rol | Verified and authorized / Verificado y autorizado |
|---|---|---|---|---|---|---|
| KAREN DANIELA HOLGUIN CRUZ | CC | Reservado — canal privado | 3145555 | Karendaniela09 | Frontend web y documentación | ☑ |
| NATALIA CHALA CHALA | CC | Reservado — canal privado | 3145555 | nataliachala1 | Aplicación móvil, backend y despliegue | ☑ |
| KEVIN STIVEN LOPEZ AMAYA | CC | Reservado — canal privado | 3145555 | Kevin-Stiven-Lopez-Amaya404 | Backend, base de datos, integración IoT y documentación técnica | ☑ |

Cada integrante confirmó sus datos y autorizó la publicación en un comentario del [PR #17](https://github.com/code-sena/ADSO-3145555/pull/17) (2026-11-08): [Karen](https://github.com/code-sena/ADSO-3145555/pull/17#issuecomment-6723435827), [Natalia](https://github.com/code-sena/ADSO-3145555/pull/17#issuecomment-6723628268) y Kevin.

Privacy and data verification: the unchecked boxes do not constitute consent. Full identification numbers are not to be included in the public README; the official registration form, if applicable, is completed through an authorized private channel. Refer to the privacy protocol linked below.

Verificación de datos: las casillas sin marcar no implican autorización. Los números completos de identificación no se incluyen en este README público; los datos necesarios para el trámite oficial se entregan por un canal privado autorizado. Consultar el protocolo de privacidad enlazado abajo.

## Delivery contents / Contenido de la entrega

| Folder / Carpeta | Content / Contenido | Done / Listo |
|---|---|---|
| [`01-requirements-specification/`](01-requirements-specification/) | Requirements specification / Especificación de requisitos | ☑ PDF |
| [`02-software-analysis/`](02-software-analysis/) | Software analysis / Análisis del software | ☑ PDF y DOCX |
| [`03-technical-proposal/`](03-technical-proposal/) | Technical proposal / Propuesta técnica | ☑ PDF y DOCX |
| [`04-software-design/`](04-software-design/) | Software design / Diseño del software | ☑ PDF y DOCX |
| [`05-test-documentation/`](05-test-documentation/) | Test documentation / Documentación de pruebas | ☑ PDF y DOCX (plan y QA Android/Shelly) |
| [`06-implementation-procedure/`](06-implementation-procedure/) | Implementation procedure / Procedimiento de implementación | ☑ PDF y DOCX |
| [`07-improvement-actions/`](07-improvement-actions/) | Improvement actions / Acciones de mejoramiento | ☑ PDF y DOCX |
| [`08-manuals/`](08-manuals/) | Manuals / Manuales | ☑ [Técnico](08-manuals/technical-manual.pdf), [instalación](08-manuals/installation-manual.pdf) y [usuario](08-manuals/end-user-manual.pdf) |
| [`09-project-article/`](09-project-article/) | Project article / Artículo del proyecto | ☑ PDF y DOCX |
| [`10-videos/`](10-videos/) | Videos / Videos | ☑ Pitch 01:30 y tutorial 04:54, públicos en Drive (enlaces en la carpeta) |
| [`code-tag/`](code-tag/) | Repository links, tags and ZIP files / Enlaces, tags y ZIP | Repositorio oficial de cada componente identificado; tags y ZIP en el Release `final-delivery` |
| [`team-roster.md`](team-roster.md) | Team and roles / Equipo y roles | ☑ Roles según el historial de commits |
| [`software-registration.md`](software-registration.md) | Software registration data / Datos para registro de software | ☑ Datos técnicos y componentes de terceros; declaraciones legales las marca cada integrante |
| [`declaracion-uso-ia.md`](declaracion-uso-ia.md) | AI usage / Uso de inteligencia artificial | ☑ Herramientas, alcance y revisión humana |

Formato de los documentos: Arial, cuerpo de 11 pt, tablas y figuras numeradas con fuente, citas y referencias en APA 7. Cada PDF tiene al lado su DOCX editable.

## Large files on Google Drive / Archivos pesados en Google Drive

Only files too heavy for GitHub go here, such as demo videos. Everything else stays in this folder.

Aquí solo van archivos demasiado pesados para GitHub, como videos de demostración. Todo lo demás vive en esta carpeta.

| File / Archivo | Size / Tamaño | Link / Enlace |
|---|---|---|
| pitch-publicitario.mp4 (pitch, 01:30) | Video MP4 | [Drive](https://drive.google.com/file/d/15RA6TZaiIlZhd5isQAHOYZWuhg8eXAaI/view) |
| aplicativo.mp4 (tutorial de la app móvil, 04:54) | Video MP4 | [Drive](https://drive.google.com/file/d/1Ibl-IyE0H5PFERU_6D1f4x5mvL_TGDzE/view) |
| Fuentes documentales (SRS y anexos) | Carpeta | [Drive](https://drive.google.com/drive/folders/1FI2E_qAiMVAG1lDXIPhSyPoFF3Pc8ndQ) |

## Pull requests de la entrega

- [PR #17](https://github.com/code-sena/ADSO-3145555/pull/17) es el único PR de entrega de SmartHome. El contenido del [PR #13](https://github.com/code-sena/ADSO-3145555/pull/13) ya está incluido en él, así que el #13 se cierra sin fusionar.
- Release del fork con los ZIP de código y sus SHA-256: [`final-delivery`](https://github.com/Kevin-Stiven-Lopez-Amaya404/ADSO-3145555/releases/tag/final-delivery).

## Privacidad

Los números de documento no se publican en este repositorio; se entregan al instructor por canal privado. Cada integrante marca su propia casilla «Verificado y autorizado»: nadie la marca por otra persona. Ver el [protocolo de privacidad](PROTOCOLO-PRIVACIDAD-Y-AUTORIZACIONES-2026-11-07.md).
