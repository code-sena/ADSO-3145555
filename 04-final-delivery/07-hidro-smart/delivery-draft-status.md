# Estado de la entrega Hidro Smart

**Corte:** 2026-11-08
**Versión:** `final-delivery-2026`  
**Responsable de la entrega:** José David Amaya Mosquera (`joseamaya009`)

## Estado de publicación

La rama `docs/final-delivery-2026` y el tag raíz `final-delivery-2026` apuntan al mismo commit publicado en GitHub. El Pull Request #9 contiene únicamente archivos de `04-final-delivery/07-hidro-smart`. El Release público contiene los doce ZIP de los seis repositorios de código y sus digest SHA-256 coinciden con `code-tag/SHA256SUMS.txt`.

Los tags de los seis repositorios de componentes son ancestros de sus ramas remotas `main`; los ZIP del Release representan exactamente los commits etiquetados, no necesariamente el tip posterior de `main`.

## Evidencia disponible

- Figma y respuestas del formulario incluidos en `04-software-design/`.
- Documentos editables, PDF y fuentes Markdown/Drawio incluidos.
- Pitch público descargable: duración 01:40.
- Tutorial público descargable: duración 03:02; cumple el rango requerido de 03:00 a 05:00 y contiene narración de los pasos principales. El enlace y la verificación de acceso están registrados en `10-videos/README.md`.
- La página pública de inicio de sesión respondió HTTP 200 y la API `/health` respondió HTTP 200 con estado `ok` y base `hidro_smart`.
- El chequeo estático del backend pasó sobre 217 archivos.
- En PT_HS, la ejecución del tag `final-delivery-2026` (`64e03d8`) completó correctamente los 11 pasos del workflow `HidroSmart CI`, incluida la validación y actualización de la base de datos.
- La instalación local es reproducible con `npm ci` usando los lockfiles versionados. El backend pasó lint y 202 pruebas unitarias; la integración pasó 6 pruebas y omitió 1 que requiere credencial externa Flespi/TLS. El frontend pasó lint, typecheck, 22 pruebas, build y preparación móvil.

## Cierres externos pendientes

- Aportar evidencia de producción, correo, restauración de base de datos, MQTT y prueba física del ESP32.
- Confirmar en el trámite externo el productor, la titularidad, la participación de instructores y las licencias de terceros; la autoría y los aportes de los tres aprendices ya fueron confirmados por el equipo.
- Completar la revisión de secretos y datos personales en los adjuntos, y conservar la aprobación del instructor en el Pull Request.

