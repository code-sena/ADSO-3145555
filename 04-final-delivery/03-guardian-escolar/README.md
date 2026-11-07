# Guardián Escolar

Final delivery of the training project / Entrega final del proyecto formativo.

## General information / Información general

| Field / Campo                                                  | Value / Valor                                                                                                                                                                                                                                                                                                                                              |
| -------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Product name / Nombre del producto                             | Guardián Escolar                                                                                                                                                                                                                                                                                                                                          |
| Ficha                                                          | 3145555                                                                                                                                                                                                                                                                                                                                                    |
| Training program / Programa de formación                      | Análisis y Desarrollo de Software (228118)                                                                                                                                                                                                                                                                                                                |
| Training project / Proyecto formativo                          | Desarrollo de software orientado a servicios                                                                                                                                                                                                                                                                                                               |
| Training center / Centro de formación                         | Centro de la Industria, la Empresa y los Servicios (Regional Huila)                                                                                                                                                                                                                                                                                        |
| Process / Proceso                                              | Completion of the technologist taught stage / Finalización de la etapa lectiva del tecnólogo                                                                                                                                                                                                                                                             |
| Research seedbed / Semillero de investigación                 | Developers & Geeks                                                                                                                                                                                                                                                                                                                                         |
| Delivery version / Versión entregada                          | `final-delivery-2026`                                                                                                                                                                                                                                                                                                                                    |
| Delivery date / Fecha de entrega                               | 2026-11-04                                                                                                                                                                                                                                                                                                                                                 |
| Delivered by / Entregado por                                   | Nicolas Estid Ruiz Sastoque (`Nicolasruiz918`)                                                                                                                                                                                                                                                                                                           |
| Web production URL / URL web de producción                    | [GPS Guardian Escolar](https://gps-guardian-escolar-frontend.onrender.com)                                                                                                                                                                                                                                                                                  |
| Backend production URL / URL backend de producción            | [GPS Guardian Escolar API](https://gps-guardian-escolar-backend.onrender.com)                                                                                                                                                                                                                                                                               |
| API health endpoint / Endpoint de salud                        | `https://gps-guardian-escolar-backend.onrender.com/api/health` — verify availability before final submission / verificar disponibilidad antes de la entrega final                                                                                                                                                                                       |
| Android APK / APK Android                                      | [Download from Frontend Release](https://github.com/GPS-Guardian-Escolar/Fronted-GuardianEscolar-/releases/download/final-delivery-2026/GPS-Guardian-Escolar-v1.0.1.apk) / [Descargar desde el Release del frontend](https://github.com/GPS-Guardian-Escolar/Fronted-GuardianEscolar-/releases/download/final-delivery-2026/GPS-Guardian-Escolar-v1.0.1.apk) |
| Video 1 — Advertising pitch / Pitch publicitario              | [Open pitch video](https://drive.google.com/file/d/1xC4FuJ2W39JVcgzTf8oTY11R09BzXVkW/view?usp=drive_link)                                                                                                                                                                                                                                                   |
| Video 2 — Short usage tutorial / Tutorial corto de uso        | [Open usage tutorial](https://drive.google.com/file/d/1GNNhO_cvIJ9iFszx9EyD9uOYgyLLHKRC/view?usp=drive_link) |
| Official Google Drive folder / Carpeta oficial de Google Drive | [drive.google.com/drive/folders/15ib4ov5jNNtGDajfvQ5s4cRe7DwsGrPm?usp=drive_link](https://drive.google.com/drive/folders/15ib4ov5jNNtGDajfvQ5s4cRe7DwsGrPm?usp=drive_link)                                                                                                                                                                                  |

## Summary / Resumen

- **Problem it solves / Problema que resuelve:** Provides guardians with a web and Android solution to register students, link a student device by QR, define routes and safe zones, and monitor school trips with location and notification information.
- **Target users / Usuarios:**
  - **Guardian / Acudiente:** registers students, manages emergency contacts, links devices, configures routes and safe zones, monitors trips and finishes a trip.
  - **Student / Estudiante:** uses the linked device to share location during an active trip and can be identified through the QR linking flow.
  - **Administrator / Administrador:** supervises users, students, routes, notifications, audits and operational information.
  - **Project team / Equipo del proyecto:** maintains the web, Android, backend, database and infrastructure components.
- **Main features / Funciones principales:**
  - Registration, email verification, sign-in and two-factor device confirmation.
  - QR and validated manual student-device linking.
  - Student profiles and emergency-contact information.
  - Route selection, route management and safe-zone configuration.
  - Active-trip tracking, location availability, notifications and history.
  - Parent-controlled trip completion and student access restrictions.
  - Android APK distribution and responsive web access.
- **Technology stack / Tecnologías:** React Native, Expo and React Native Web; Java 17 and Spring Boot; PostgreSQL and Liquibase; Docker Compose; GitHub Actions; Render; Google Maps integrations.
- **Production URL / URL en producción:** https://gps-guardian-escolar-frontend.onrender.com
- **Demo credentials / Credenciales de prueba:** Use the credentials supplied privately during the demonstration. No real passwords are stored in this repository.

## Production and evidence links / Enlaces de producción y evidencias

The web frontend is deployed on Render and uses the backend service through its configured proxy/API environment variables. The backend URL above is the public service reference; endpoint availability must be checked again immediately before submission.

El frontend web está desplegado en Render y utiliza el backend mediante las variables de proxy/API configuradas. La URL anterior es la referencia pública del servicio; la disponibilidad de los endpoints debe verificarse nuevamente antes de entregar.

The APK, advertising pitch, usage tutorial and official Drive folder are linked above. / La APK, el pitch publicitario, el tutorial de uso y la carpeta oficial de Drive están enlazados arriba.

The documents in folders `01`–`09` are delivered only in the final PDF format required by the delivery guide. No separate Canva design was used; the PDF technical design document in `04-software-design` is the official design deliverable. / Los documentos de las carpetas `01`–`09` se entregan únicamente en el formato PDF final exigido por la guía. No se utilizó un diseño separado en Canva; el PDF técnico de diseño en `04-software-design` es el entregable oficial.

## Team members / Integrantes

> Names and document numbers were preloaded by the instructor from the Sofía Plus report. Each member checks their row, completes GitHub user and role, and marks the last column. Report any error, missing member or extra member to the instructor.
>
> Los nombres y documentos los precargó el instructor desde el reporte de Sofía Plus. Cada integrante revisa su fila, completa usuario de GitHub y rol, y marca la última columna. Reporte al instructor cualquier error, o si falta o sobra alguien.

| Full name / Nombre completo | Doc. type / Tipo | Doc. number / Número | Ficha   | GitHub user / Usuario | Role / Rol                                                                                                                                                                      | Verified and authorized / Verificado y autorizado |
| --------------------------- | ---------------- | --------------------- | ------- | --------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------- |
| KEVIN ANDREY CULMA GOMEZ    | TI               | 1130024165            | 3145555 | Andrey31072           | Documentation, QA and frontend support / Documentación, QA y apoyo frontend                                                                                                    | ☑                                                |
| NICOLAS ESTID RUIZ SASTOQUE | CC               | 1029144515            | 3145555 | Nicolasruiz918        | Backend, frontend, database, infrastructure, integration and release coordination / Backend, frontend, base de datos, infraestructura, integración y coordinación de entregas | ☑                                                |
| JHON CAMILO SUAZA SANCHEZ   | CC               | 1077230121            | 3145555 | JhonCamiloSuaza       | Frontend, tracking and user interface / Frontend, seguimiento e interfaz de usuario                                                                                             | ☑                                                |

Data use authorization: by checking the box, the member confirms their data and authorizes publishing their name, document number and ficha in this public repository, for the software registration process (Ley 1581 de 2012). Anyone who does not authorize it tells the instructor before delivering.

Autorización de datos: al marcar la casilla, el integrante confirma sus datos y autoriza publicar su nombre, número de documento y ficha en este repositorio público, para el trámite de registro de software (Ley 1581 de 2012). Quien no lo autorice se lo informa al instructor antes de entregar.

## Delivery contents / Contenido de la entrega

| Folder / Carpeta                                                    | Content / Contenido                                          | Done / Listo |
| ------------------------------------------------------------------- | ------------------------------------------------------------ | ------------ |
| [`01-requirements-specification/`](01-requirements-specification/) | Requirements specification / Especificación de requisitos   | ☑           |
| [`02-software-analysis/`](02-software-analysis/)                   | Software analysis / Análisis del software                   | ☑           |
| [`03-technical-proposal/`](03-technical-proposal/)                 | Technical proposal / Propuesta técnica                      | ☑           |
| [`04-software-design/`](04-software-design/)                       | Software design / Diseño del software                       | ☑           |
| [`05-test-documentation/`](05-test-documentation/)                 | Test documentation / Documentación de pruebas               | ☑           |
| [`06-implementation-procedure/`](06-implementation-procedure/)     | Implementation procedure / Procedimiento de implementación  | ☑           |
| [`07-improvement-actions/`](07-improvement-actions/)               | Improvement actions / Acciones de mejoramiento               | ☑           |
| [`08-manuals/`](08-manuals/)                                       | Manuals / Manuales                                           | ☑           |
| [`09-project-article/`](09-project-article/)                       | Project article / Artículo del proyecto                     | ☑           |
| [`10-videos/`](10-videos/)                                         | Videos / Videos                                              | ☑           |
| [`code-tag/`](code-tag/)                                           | Repository links, tags and ZIP files / Enlaces, tags y ZIP   | ☑           |
| [`team-roster.md`](team-roster.md)                                 | Team and roles / Equipo y roles                              | ☑           |
| [`software-registration.md`](software-registration.md)             | Software registration data / Datos para registro de software | ☑           |

The folders `01` to `08` contain the documents copied from `Docs-Guardian-Escolar/14-deliverables/version-2.5.6`, and `09-project-article` contains the final academic article from Docs `main`. The final videos are available in the shared Google Drive folder. / Las carpetas `01` a `08` contienen los documentos copiados desde `Docs-Guardian-Escolar/14-deliverables/version-2.5.6`, y `09-project-article` contiene el artículo académico final de `main` de Docs. Los videos finales están disponibles en la carpeta compartida de Google Drive.

## Large files on Google Drive / Archivos pesados en Google Drive

Only files too heavy for GitHub go here, such as demo videos. Everything else stays in this folder.

Aquí solo van archivos demasiado pesados para GitHub, como videos de demostración. Todo lo demás vive en esta carpeta.

| File / Archivo                                  | Size / Tamaño  | Link / Enlace                                                                                                                                                    |
| ----------------------------------------------- | --------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Android APK `GPS-Guardian-Escolar-v1.0.1.apk` | More than 50 MB | [GitHub Release download](https://github.com/GPS-Guardian-Escolar/Fronted-GuardianEscolar-/releases/download/final-delivery-2026/GPS-Guardian-Escolar-v1.0.1.apk) |
| Advertising pitch                               | 1–2 minutes    | [Open pitch video](https://drive.google.com/file/d/1xC4FuJ2W39JVcgzTf8oTY11R09BzXVkW/view?usp=drive_link)                                                         |
| Short usage tutorial                            | 3–5 minutes    | [Open usage tutorial](https://drive.google.com/file/d/1GNNhO_cvIJ9iFszx9EyD9uOYgyLLHKRC/view?usp=drive_link) |

## Delivery checklist / Lista de verificación de entrega

- [X] Documentation folders `01`–`09` exported to the required final PDF format and reviewed / Carpetas `01`–`09` exportadas al formato PDF final requerido y revisadas.
- [X] Docs repository promoted to `main` and tagged / Repositorio Docs promovido a `main` y etiquetado.
- [X] Final Releases created in the five original repositories / Releases finales creados en los cinco repositorios originales.
- [X] Videos uploaded to Drive and linked above / Videos subidos a Drive y enlazados arriba.
- [X] Apprentice authorizations recorded; instructor Write invitations remain pending acceptance / Autorizaciones de aprendices registradas; las invitaciones Write de instructores siguen pendientes de aceptación.
