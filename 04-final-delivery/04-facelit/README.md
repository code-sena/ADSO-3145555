# FaceLit

Final delivery of the training project / Entrega final del proyecto formativo.

## General information / Información general

| Field / Campo | Value / Valor |
|---|---|
| Product name / Nombre del producto | FaceLit |
| Ficha | 3145555 |
| Training program / Programa de formación | Análisis y Desarrollo de Software (228118) |
| Training project / Proyecto formativo | Desarrollo de software orientado a servicios |
| Training center / Centro de formación | Centro de la Industria, la Empresa y los Servicios (Regional Huila) |
| Process / Proceso | Completion of the technologist taught stage / Finalización de la etapa lectiva del tecnólogo |
| Research seedbed / Semillero de investigación | Developers & Geeks |
| Delivery version / Versión entregada | `final-delivery-2026` |
| Delivery date / Fecha de entrega | 2026-11-07 |
| Delivered by / Entregado por | Mariana Valenzuela Penagos (`pemarival`); coordinación documental y prueba independiente: María José Rodríguez Oyola. |

## Summary / Resumen

Entrega de código y descargas: [Release final-delivery](https://github.com/pemarival/ADSO-3145555/releases/tag/final-delivery), [tags, ZIP y huellas](code-tag/README.md). Evidencia recibida: [reprueba de instalación](05-test-documentation/installation-verification/README.md) y [aportes del equipo](05-test-documentation/team-contributions/README.md). La publicación conserva los `main` sin modificaciones y no declara aprobado el punto 6: consulta [las diferencias de versión y alcance](05-test-documentation/installation-final-scope.md).

**Alcance confirmado por el equipo (2026-11-05):** esta entrega corresponde a los `main` actuales de GitHub. Hostinger incorpora ajustes locales adicionales cuya integración se pospone a una actualización futura; no se declara que los ZIP permitan reconstruir exactamente ese despliegue. Consulta la [decisión y sus límites](code-tag/delivery-status.md).

- **Problem it solves / Problema que resuelve:** Centralizar la información académica y relacionar registros de asistencia con aprendices y sesiones.
- **Target users / Usuarios:** Coordinación, instructores y aprendices.
- **Main features / Funciones principales:** Gestión académica y usuarios, importación CSV, enrolamiento facial, sesiones, registro y consulta de asistencia, perfil y notificaciones; alcance final sujeto al tag entregado.
- **Technology stack / Tecnologías:** Expo/React Native, Java/Spring Boot, Python/FastAPI, PostgreSQL/pgvector y Liquibase; despliegue documentado en Docker Compose/Caddy sobre Hostinger.
- **Production URL / URL en producción:** https://facelit.tech - URL declarada en el informe de despliegue; no se comprobó disponibilidad en esta revisión.
- **Demo credentials / Credenciales de prueba:** do not write real passwords here / no escriba contraseñas reales aquí

## Team members / Integrantes

> Names and document numbers were preloaded by the instructor from the Sofía Plus report. Each member checks their row, completes GitHub user and role, and marks the last column. Report any error, missing member or extra member to the instructor.
>
> Los nombres y documentos los precargó el instructor desde el reporte de Sofía Plus. Cada integrante revisa su fila, completa usuario de GitHub y rol, y marca la última columna. Reporte al instructor cualquier error, o si falta o sobra alguien.

| Full name / Nombre completo | Doc. type / Tipo | Doc. number / Número | Ficha | GitHub user / Usuario | Role / Rol | Verified and authorized / Verificado y autorizado |
|---|---|---|---|---|---|---|
| VALERY SINAI TRUJILLO QUINTERO | CC | 1075795018 | 3145555 | valerysinai | Frontend | ☑ |
| MARIA JOSE RODRIGUEZ OYOLA | CC | 1076505530 | 3145555 | MariaOyola | Backend Java y base de datos | ☑ |
| MARIANA VALENZUELA PENAGOS | CC | 1075794823 | 3145555 | pemarival | Microservicio facial | ☑ |

Data use authorization: by checking the box, the member confirms their data and authorizes publishing their name, document number and ficha in this public repository, for the software registration process (Ley 1581 de 2012). Anyone who does not authorize it tells the instructor before delivering.

Autorización de datos: al marcar la casilla, el integrante confirma sus datos y autoriza publicar su nombre, número de documento y ficha en este repositorio público, para el trámite de registro de software (Ley 1581 de 2012). Quien no lo autorice se lo informa al instructor antes de entregar.

## Delivery contents / Contenido de la entrega

| Folder / Carpeta | Content / Contenido | Done / Listo |
|---|---|---|
| [`01-requirements-specification/`](01-requirements-specification/) | Requirements specification / Especificación de requisitos | ☐ |
| [`02-software-analysis/`](02-software-analysis/) | Software analysis / Análisis del software | ☐ |
| [`03-technical-proposal/`](03-technical-proposal/) | Technical proposal / Propuesta técnica | ☐ |
| [`04-software-design/`](04-software-design/) | Software design / Diseño del software | ☐ |
| [`05-test-documentation/`](05-test-documentation/) | Test documentation / Documentación de pruebas | ☐ |
| [`06-implementation-procedure/`](06-implementation-procedure/) | Implementation procedure / Procedimiento de implementación | ☐ |
| [`07-improvement-actions/`](07-improvement-actions/) | Improvement actions / Acciones de mejoramiento | ☐ |
| [`08-manuals/`](08-manuals/) | Manuals / Manuales | ☐ |
| [`09-project-article/`](09-project-article/) | Project article / Artículo del proyecto | ☐ |
| [`10-videos/`](10-videos/) | Videos / Videos | ☑ |
| [`code-tag/`](code-tag/) | Repository links, tags and ZIP files / Enlaces, tags y ZIP | ☐ |
| [`team-roster.md`](team-roster.md) | Team and roles / Equipo y roles | ☐ |
| [`software-registration.md`](software-registration.md) | Software registration data / Datos para registro de software | ☐ |

## Large files on Google Drive / Archivos pesados en Google Drive

Only files too heavy for GitHub go here, such as demo videos. Everything else stays in this folder.

Aquí solo van archivos demasiado pesados para GitHub, como videos de demostración. Todo lo demás vive en esta carpeta.

| File / Archivo | Size / Tamaño | Link / Enlace |
|---|---|---|
| pitch | 1 min 50 s | [Pitch publicitario — Drive](https://drive.google.com/drive/folders/1g6zS8GQ-b6YLMu8mm3y77bA9sVucYGXL) |
| Tutorial | 4 min 9 s | [Tutorial — Drive](https://drive.google.com/drive/folders/1g6zS8GQ-b6YLMu8mm3y77bA9sVucYGXL) |


## Actualización documental - Persona 2

Revisión del 5 de noviembre de 2026, fuente `facelit-docs` en `dcf81aad429eeffbbe9f9ac17d0b7946e82c3dcb`. Consulte [correspondencia y pendientes](delivery-review.md). Se incorporaron SRS V4.1, anexos actualizados, diseño visual completo, evidencias por rol, instalación y despliegue. Los campos de responsable y fecha efectiva de entrega, roles, autorizaciones y videos deben confirmarse por el equipo.


## Última revisión del alojamiento - 2993404

El repositorio documental se revisó de nuevo en `299340428bc7b04fa013cd1b4d034f673b9d3dbc`. El despliegue documentado está íntegramente en un VPS Hostinger: Caddy publica https://facelit.tech/ por HTTPS y Docker Compose coordina la web y los servicios internos. [Documento general actualizado](project-overview.pdf), [fuente editable](project-overview.md) y [detalle de esta revisión](delivery-review.md). No se accedió al VPS ni se modificó el despliegue.
