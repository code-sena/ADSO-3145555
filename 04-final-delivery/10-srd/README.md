# SRD

Final delivery of the training project / Entrega final del proyecto formativo.

## General information / Información general

| Field / Campo | Value / Valor |
|---|---|
| Product name / Nombre del producto | SRD |
| Ficha | 3145555 |
| Training program / Programa de formación | Análisis y Desarrollo de Software (228118) |
| Training project / Proyecto formativo | Desarrollo de software orientado a servicios |
| Training center / Centro de formación | Centro de la Industria, la Empresa y los Servicios (Regional Huila) |
| Process / Proceso | Completion of the technologist taught stage / Finalización de la etapa lectiva del tecnólogo |
| Research seedbed / Semillero de investigación | Developers & Geeks |
| Delivery version / Versión entregada | `final-delivery-2026` **pendiente de etiquetar en los repositorios** |
| Delivery date / Fecha de entrega | 5 de noviembre de 2026 (preparación de PR; fecha límite institucional: 4 de noviembre) |
| Delivered by / Entregado por | Juan Sebastián Gonzalez Horta ([@jsgh1](https://github.com/jsgh1)) |

## Summary / Resumen

- **Problem it solves / Problema que resuelve:** Digitaliza y centraliza los procesos administrativos de las Juntas de Acción Comunal (JAC) para reducir trámites manuales y facilitar la trazabilidad.
- **Target users / Usuarios:** Juntas de Acción Comunal, administradores, responsables de procesos y usuarios con permisos asignados por rol y junta.
- **Main features / Funciones principales:** Gestión de identidad, roles, registros, archivos, configuración, calendario, notificaciones, tesorería, inventario, chat y auditoría.
- **Technology stack / Tecnologías:** Backend Laravel/PHP con API Gateway y microservicios; React/TypeScript; React Native/Expo; Electron; MySQL; Docker Compose; Nginx; Reverb.
- **Production URL / URL en producción:** [Instancia publicada de SRD](https://srv2093837.hstgr.cloud/login) (disponibilidad y versión final no verificadas durante esta revisión).
- **Demo credentials / Credenciales de prueba:** No se publican contraseñas reales; solicitar credenciales de demostración por canal privado.

## Team members / Integrantes

> Names and document numbers were preloaded by the instructor from the Sofía Plus report. Each member checks their row, completes GitHub user and role, and marks the last column. Report any error, missing member or extra member to the instructor.
>
> Los nombres y documentos los precargó el instructor desde el reporte de Sofía Plus. Cada integrante revisa su fila, completa usuario de GitHub y rol, y marca la última columna. Reporte al instructor cualquier error, o si falta o sobra alguien.

| Full name / Nombre completo | Doc. type / Tipo | Doc. number / Número | Ficha | GitHub user / Usuario | Role / Rol | Verified and authorized / Verificado y autorizado |
|---|---|---|---|---|---|---|
| JUAN SEBASTIAN GONZALEZ HORTA | CC | 1077227978 | 3145555 | jsgh1 | Desarrollo full-stack, infraestructura, pruebas y documentación | ☐ |

Data use authorization: by checking the box, the member confirms their data and authorizes publishing their name, document number and ficha in this public repository, for the software registration process (Ley 1581 de 2012). Anyone who does not authorize it tells the instructor before delivering.

Autorización de datos: al marcar la casilla, el integrante confirma sus datos y autoriza publicar su nombre, número de documento y ficha en este repositorio público, para el trámite de registro de software (Ley 1581 de 2012). Quien no lo autorice se lo informa al instructor antes de entregar.

## Delivery contents / Contenido de la entrega

| Folder / Carpeta | Content / Contenido | Done / Listo |
|---|---|---|
| [`01-requirements-specification/`](01-requirements-specification/) | Requirements specification / Especificación de requisitos | ✅ PDF + Word |
| [`02-software-analysis/`](02-software-analysis/) | Software analysis / Análisis del software | ✅ PDF + Word |
| [`03-technical-proposal/`](03-technical-proposal/) | Technical proposal / Propuesta técnica | ✅ PDF + Word |
| [`04-software-design/`](04-software-design/) | Software design / Diseño del software | ⚠️ Enlaces al origen; falta copiar PDF + Word |
| [`05-test-documentation/`](05-test-documentation/) | Test documentation / Documentación de pruebas | ✅ PDF + Word |
| [`06-implementation-procedure/`](06-implementation-procedure/) | Implementation procedure / Procedimiento de implementación | ✅ PDF + Word |
| [`07-improvement-actions/`](07-improvement-actions/) | Improvement actions / Acciones de mejoramiento | ✅ PDF + Word |
| [`08-manuals/`](08-manuals/) | Manuals / Manuales | ✅ 3 PDF + 3 Word |
| [`09-project-article/`](09-project-article/) | Project article / Artículo del proyecto | ✅ PDF + Word ES/EN |
| [`10-videos/`](10-videos/) | Videos / Videos | ⚠️ Enlaces YouTube; verificar duración/Drive |
| [`code-tag/`](code-tag/) | Repository links, tags and ZIP files / Enlaces, tags y ZIP | ⚠️ Repos listados; faltan tags, ZIP, Release y SHA-256 |
| [`team-roster.md`](team-roster.md) | Team and roles / Equipo y roles | ⚠️ Rol diligenciado; autorización del aprendiz pendiente |
| [`software-registration.md`](software-registration.md) | Software registration data / Datos para registro de software | ⚠️ Descripción técnica; declaraciones y firma pendientes |

## Large files on Google Drive / Archivos pesados en Google Drive

Only files too heavy for GitHub go here, such as demo videos. Everything else stays in this folder.

Aquí solo van archivos demasiado pesados para GitHub, como videos de demostración. Todo lo demás vive en esta carpeta.

| File / Archivo | Size / Tamaño | Link / Enlace |
|---|---|---|
| | | |

## Trazabilidad y pendientes antes del cierre definitivo

- **Procedencia documental:** [SRD-Docs, rama dev](https://github.com/jsgh1/SRD-Docs/tree/dev/Entregables); los 22 archivos incorporados son copias binarias exactas verificadas por SHA de Git.
- **Diseño:** incorporar físicamente el PDF y Word originales enlazados desde [04-software-design/](04-software-design/) (aún no incluidos).
- **Código:** revisar e integrar el trabajo validado de dev en main por PR en cada repositorio antes de crear el tag final-delivery-2026. No se generaron tags ni ZIP en esta rama documental.
- **Registro:** confirmar contribuciones, clase de obra, licencias y autorización de publicación de datos con el equipo e instructor. La casilla de consentimiento no se marcó automáticamente.
- **Videos:** el usuario proporcionó enlaces YouTube; verificar duración y compatibilidad con el requisito de Drive.
- **Seguridad:** auditar secretos expuestos en archivos e historial y rotarlos antes de archivar o publicar entregas completas.
- **Alcance de este PR:** únicamente 04-final-delivery/10-srd/; no modifica otros proyectos ni repositorios técnicos.
