# Drivique — Entrega Final del Proyecto Formativo (ADSO-3145555)

Final delivery of the training project / Entrega final del proyecto formativo.

## General information / Información general

| Field / Campo | Value / Valor |
|---|---|
| Product name / Nombre del producto | Drivique |
| Ficha | 3145555 |
| Training program / Programa de formación | Tecnólogo en Análisis y Desarrollo de Software (228118) |
| Training project / Proyecto formativo | Desarrollo de software orientado a servicios |
| Training center / Centro de formación | Centro de la Industria, la Empresa y los Servicios (CIES) — SENA |
| Process / Proceso | Completion of the technologist taught stage / Finalización de la etapa lectiva del tecnólogo |
| Research seedbed / Semillero de investigación | Developers & Geeks |
| Delivery version / Versión entregada | `final-delivery-2026` |
| Delivery date / Fecha de entrega | Noviembre 2026 |
| Delivered by / Entregado por | Laura Vanessa Pérez Perdomo, Danna Valentina Barrios Penagos, Emily Sharith Amézquita Saavedra |
| Production URL / URL de producción Web | [https://drivique.tech](https://drivique.tech) |
| Mobile PWA URL / URL Móvil | [https://app.drivique.tech](https://app.drivique.tech) |
| API URL / URL de API Backend | [https://drivique.tech/api/v1](https://drivique.tech/api/v1) |
| Video 1 — Pitch Publicitario (1–2 min) | [Ver Video 1 en Google Drive](https://drive.google.com/file/d/1Xp9Xvw5L0WXruAmh-Xp4TWbKdTnGoi7j/view?usp=sharing) |
| Video 2 — Tutorial Corto de Uso (`DRIVIQUE.mp4`, 3–5 min) | [Ver Video 2 en Google Drive](https://drive.google.com/file/d/1eRwp5Ljfp8rNEf-WkiWG1_5aG3CYTDJm/view) |
| Google Drive Folder / Carpeta Drive Oficial | [Documentos finales del Proyecto — Google Drive](https://drive.google.com/drive/u/0/folders/1JlSajKFWAOp61nfC0iB8kkIeRJ__CIWh) |

## Summary / Resumen Ejecutivo

- **Problem it solves / Problema que resuelve:** Automatiza, centraliza y moderniza la gestión integral del alquiler y control de flotas vehiculares en Colombia, eliminando procesos manuales en papel, errores de liquidación y falta de trazabilidad mediante reservas en 4 pasos, pagos digitales (Wompi) y en efectivo con vencimiento dinámico, validación documental KYC, firma electrónica de contratos y entrega/recepción validada con PIN de 6 dígitos.
- **Target users / Perfiles de usuario:** el sistema maneja cuatro perfiles con control de acceso por roles (RBAC). El código de cada rol es el mismo que está en la tabla `iam.roles` de la base de datos.

  | Perfil | Código de rol | Canal | Qué puede hacer |
  |---|---|---|---|
  | **Cliente** | `CUSTOMER` | App móvil y web | Registrarse e iniciar sesión, consultar el catálogo, reservar en 4 pasos, cargar documentos KYC (cédula y licencia), pagar en línea (Wompi) o en efectivo, firmar el contrato electrónicamente, recibir el vehículo con PIN de 6 dígitos, calificar el servicio, abrir solicitudes de soporte y gestionar su perfil. |
  | **Empleado de sucursal** | `EMPLOYEE` | Panel web | Atención en mostrador de su sucursal: inspecciones del vehículo, apoyo en entregas y devoluciones, atención al cliente y respuesta a reseñas. |
  | **Administrador de sucursal (encargado)** | `BRANCH_ADMIN` | Panel web (`/encargado/*`) | Operación diaria de la sucursal asignada: validación documental KYC, confirmación de pagos en efectivo, entrega (Check-In) con PIN, devolución (Check-Out), domicilios, flota local, personal, reseñas y auditoría de su sucursal. |
  | **Superadministrador** | `SUPER_ADMIN` | Panel web (`/admin/*`) | Gestión nacional: ciudades, sucursales, asignación de encargados, flota global, usuarios y roles, promociones y cupones, reportes financieros y bitácora de auditoría de todo el sistema. |

- **Main features / Funciones principales:** catálogo de vehículos por sucursal, reservas con vencimiento automático, pagos digitales y en efectivo, validación documental KYC, contratos con firma electrónica, entrega y devolución con PIN, notificaciones, soporte, reseñas, reportes administrativos, auditoría forense y aplicación en 5 idiomas.
- **Technology stack / Tecnologías:** Backend en Java 21 con Spring Boot 4 (API REST, Spring Security con JWT, JPA/Hibernate); base de datos PostgreSQL; frontend web con React 19 y Vite; app móvil con React Native y Expo (TypeScript, Zustand, Axios, i18next).
- **Production URL / URL en producción:** [https://drivique.tech](https://drivique.tech) (web), [https://app.drivique.tech](https://app.drivique.tech) (móvil) y [https://drivique.tech/api/v1](https://drivique.tech/api/v1) (API).
- **Demo credentials / Credenciales de prueba:** no se publican en este repositorio. Se entregan al instructor por un canal privado.

## Team members / Integrantes

> Names and document numbers were preloaded by the instructor from the Sofía Plus report. Each member checks their row, completes GitHub user and role, and marks the last column. Report any error, missing member or extra member to the instructor.
>
> Los nombres y documentos los precargó el instructor desde el reporte de Sofía Plus. Cada integrante revisa su fila, completa usuario de GitHub y rol, y marca la última columna. Reporte al instructor cualquier error, o si falta o sobra alguien.

| Full name / Nombre completo | Doc. type / Tipo | Doc. number / Número | Ficha | GitHub user / Usuario | Role / Rol | Verified and authorized / Verificado y autorizado |
|---|---|---|---|---|---|---|
| DANNA VALENTINA BARRIOS PENAGOS | CC | 1084923587 | 3145555 | Dannabarrios | Full-Stack Developer | ☑ |
| LAURA VANESSA PEREZ PERDOMO | CC | 1075228306 | 3145555 | vanessaperdomo | Full-Stack Developer & Team Representative | ☑ |
| EMILY SHARITH AMEZQUITA SAAVEDRA | CC | 1075243904 | 3145555 | sharithsaavedra1 | Full-Stack Developer | ☑ |

Data use authorization: by checking the box, the member confirms their data and authorizes publishing their name, document number and ficha in this public repository, for the software registration process (Ley 1581 de 2012). Anyone who does not authorize it tells the instructor before delivering.

Autorización de datos: al marcar la casilla, el integrante confirma sus datos y autoriza publicar su nombre, número de documento y ficha en este repositorio público, para el trámite de registro de software (Ley 1581 de 2012). Quien no lo autorice se lo informa al instructor antes de entregar.

## Deliverables Index / Índice Completo de Carpetas Entregables

| Carpeta | Entregable Oficial SENA | Archivo Oficial Entregado | Estado |
|---|---|---|---|
| [`01-requirements-specification/`](01-requirements-specification/) | Especificación de Requisitos de Software (SRS IEEE 830: 60 RF, 12 RNF, 10 CU) | [`requirements-specification.pdf`](01-requirements-specification/requirements-specification.pdf) | ✅ Completo |
| [`02-software-analysis/`](02-software-analysis/) | Informe de Análisis de Software (Vistas Dinámicas) y Diagramas | [`software-analysis.pdf`](02-software-analysis/software-analysis.pdf), [`use-case-diagrams.pdf`](02-software-analysis/use-case-diagrams.pdf), [`sequence-diagrams.pdf`](02-software-analysis/sequence-diagrams.pdf), [`class-diagram.pdf`](02-software-analysis/class-diagram.pdf), [`domain-diagram.pdf`](02-software-analysis/domain-diagram.pdf), [`use-cases.drawio`](02-software-analysis/use-cases.drawio) | ✅ Completo |
| [`03-technical-proposal/`](03-technical-proposal/) | Propuesta Técnica del Software y Justificación Tecnológica | [`technical-proposal.pdf`](03-technical-proposal/technical-proposal.pdf) | ✅ Completo |
| [`04-software-design/`](04-software-design/) | Diseño de Software, Diccionario de Datos, Selección de Frameworks, DDL SQL y Diagramas | [`software-design.pdf`](04-software-design/software-design.pdf), [`data-dictionary.pdf`](04-software-design/data-dictionary.pdf), [`framework-selection.pdf`](04-software-design/framework-selection.pdf), [`database-ddl.sql`](04-software-design/database-ddl.sql) | ✅ Completo |
| [`05-test-documentation/`](05-test-documentation/) | Documentación de Pruebas (Plan, Casos de Prueba y Resultados) | [`test-documentation.pdf`](05-test-documentation/test-documentation.pdf) | ✅ Completo |
| [`06-implementation-procedure/`](06-implementation-procedure/) | Procedimiento de Implementación y Runbook de Despliegue | [`implementation-procedure.pdf`](06-implementation-procedure/implementation-procedure.pdf) | ✅ Completo |
| [`07-improvement-actions/`](07-improvement-actions/) | Acciones Correctivas, Preventivas y de Mejoramiento | [`improvement-actions.pdf`](07-improvement-actions/improvement-actions.pdf) | ✅ Completo |
| [`08-manuals/`](08-manuals/) | Manual Técnico, Manual de Instalación y Manual de Usuario Final | [`technical-manual.pdf`](08-manuals/technical-manual.pdf), [`installation-manual.pdf`](08-manuals/installation-manual.pdf), [`user-manual.pdf`](08-manuals/user-manual.pdf) | ✅ Completo |
| [`09-project-article/`](09-project-article/) | Artículo Científico del Proyecto (Formato IEEE 2 Columnas) | [`project-article.pdf`](09-project-article/project-article.pdf) | ✅ Completo |
| [`10-videos/`](10-videos/) | Pitch Publicitario (1–2 min) y Tutorial de Uso (3–5 min) | [`README.md`](10-videos/README.md) | ✅ Completo |
| [`code-tag/`](code-tag/) | Repositorios Públicos, Tag `final-delivery-2026` y Checksums SHA-256 | [`README.md`](code-tag/README.md), [`SHA256SUMS.txt`](code-tag/SHA256SUMS.txt) | ✅ Completo |
