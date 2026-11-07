# Final Delivery — SmartHome

**Training Program:** Software Analysis and Development (ADSO)  
**Training Group:** 3145555  
**Institution:** Servicio Nacional de Aprendizaje (SENA)  
**Project:** SmartHome — Smart Home Energy Management

## Project Overview

SmartHome is a smart-home platform for managing homes and connected devices, displaying energy consumption and notifications, and communicating with supported devices. The system integrates a NestJS/TypeScript backend, React/Vite web client, React Native/Expo mobile client, and PostgreSQL database with Liquibase. Device communication involves MQTT and experimental Shelly LAN/BLE workflows.

## Source Code Repositories

- Backend: https://github.com/nataliachala1/smarthome-backend
- Web frontend: https://github.com/nataliachala1/smarthome-frontend-web
- Mobile application: https://github.com/Kevin-Stiven-Lopez-Amaya404/from_movil
- Database: https://github.com/nataliachala1/smarthome-database
- Technical documentation: https://github.com/Kevin-Stiven-Lopez-Amaya404/smart-home-doc

## Academic Documentation

The project documentation is organized in the institutional folder:

**[04-final-delivery/02-smarthome/](https://github.com/code-sena/ADSO-3145555/tree/main/04-final-delivery/02-smarthome)**

The **consolidated PR #17** now includes the source documents of PR #13 and final PDF documents in institutional sections **01 (SRS), 02 (analysis), 04 (design), 05 (tests), 06 (implementation) and 09 (article)**. Technical proposal, corrective actions and technical/manual sources are also available as DOCX and Markdown; confirm definitive PDF versions as needed. Team and software-registration details have been drafted for individual verification, not signed.

An optional documentation asset, `SmartHome_Release_Todo.zip`, contains 15 original Drive files and 37 previously prepared academic files; a corrected supplementary pack with the final-format PDFs is also available from the team. This **does not replace** the institutional documentation folder.

## Code Packages and Integrity

For each approved **original code repository**, publish both:

- `<repo>-final-delivery-2026-main.zip` — snapshot of the approved `main` commit carrying annotated tag `final-delivery-2026`.
- `<repo>-full-export.zip` — full Git history including branches and tags.

Publish the files as **Release Assets** in this fork. Record their real SHA-256 checksums and download links in **[code-tag/SHA256SUMS.txt](https://github.com/code-sena/ADSO-3145555/tree/main/04-final-delivery/02-smarthome/code-tag/SHA256SUMS.txt)**. Do not invent checksum strings or attach a nonvalidated branch as the final code snapshot.

## Acceptance Status

**At document preparation (7 November 2026):** the web `main` CI smoke test had failed; mobile security PR #61 and QA-to-main PR #49 remained draft/open and physical Android acceptance was pending. This Release **must remain unpublished as a final verified code delivery** until the build, acceptance and tags are completed. The academic documentation can be reviewed independently.

## Project Team

- Natalia Chala Chala
- Kevin Stiven López Amaya
- Karen Daniela Holguín Cruz


## Documentación original de Google Drive — incluir en Assets

**Carpeta original del proyecto:** https://drive.google.com/drive/folders/1FI2E_qAiMVAG1lDXIPhSyPoFF3Pc8ndQ

Se descargaron y conservaron **15 archivos de 12 secciones**: documentación general (SRS y costos), navegación, propuesta técnica, diseño, artefactos de código (enlace a repositorio), pruebas, implementación, acciones correctivas, manuales, artículo, despliegue y términos/política de datos. Se conservaron archivos repetidos en sus carpetas de origen.

Adjuntar preferentemente **`SmartHome_Release_Todo.zip`**, que integra **esos 15 archivos originales** y **37 archivos académicos previamente preparados**; incluye inventario y SHA-256 de cada contenido. También existe la copia separada `SmartHome_Drive_Completo.zip` si se requiere presentar la fuente de Drive por separado.

**Estos ZIP son de DOCUMENTACIÓN. No reemplazan los paquetes de código/tag/exportación Git ni los videos.** Verificar que no contienen datos personales o secretos antes de hacer público el Release. El archivo `Repositorio.txt` en Drive contiene un enlace, no una copia completa del código.


## Correcciones para evaluación del instructor — 7 de noviembre de 2026

- **Un solo PR:** [PR #17](https://github.com/code-sena/ADSO-3145555/pull/17) contiene ahora los cinco archivos originales aportados en el [PR #13](https://github.com/code-sena/ADSO-3145555/pull/13) y los nuevos informes. Solicitar a su autora cerrar el #13 tras comprobar la consolidación, y al mantenedor revisar el #17. Ninguno se ha fusionado a `code-sena/main`.
- **PDF:** se incorporaron archivos finales en `01-requirements-specification`, `02-software-analysis`, `04-software-design`, `05-test-documentation`, `06-implementation-procedure` y `09-project-article`.
- **Documentación oficial de trabajo:** `Kevin-Stiven-Lopez-Amaya404/smart-home-doc` (repositorio documental completo). El `smart-home-docs` solicitado como fuente histórica aún debe incluirse según indicación del instructor, pero no es el canónico. La BD vigente es `nataliachala1/smarthome-database`, distinta de `smart-home-database` histórico; véase `code-tag/README.md`.
- **Videos disponibles:** demo web 06:29 y demo móvil 10:05. **No cumplen** los rangos 01–02 min del pitch ni 03–05 min del tutorial. Requieren edición y comprobación de acceso por enlace con permiso Lector.
- **Registro software:** funciones, lenguajes, tipo de software y aportes propuestos están documentados. Continúan pendientes las tres autorizaciones personales y las declaraciones legales de originalidad, clase de obra y publicación.
- **Cinco tags y diez ZIP:** no existen aún `final-delivery-2026` ni los diez paquetes de código validados; no declararlos listos hasta crearles y comprobar SHA-256 y `main` aprobado. El ZIP académico **no sustituye** los ZIP de código.
- **Permisos:** el instructor `ariel5253` necesita Write en cada repositorio. En dos repositorios de Stiven se observó solo Read; los permisos en repositorios de Natalia requieren verificación por su titular.

**Nota: este documento es la descripción propuesta, no evidencia de que el GitHub Release se haya publicado o aprobado.**
