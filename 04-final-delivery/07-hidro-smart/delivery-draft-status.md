# Estado de la entrega Hidro Smart

**Corte:** 2026-11-07  
**Versión:** `final-delivery-2026`  
**Responsable de la entrega:** José David Amaya Mosquera (`joseamaya009`)

## Estado de publicación

La rama `docs/final-delivery-2026` y el tag raíz `final-delivery-2026` apuntan al mismo commit publicado en GitHub. El Pull Request #9 contiene únicamente archivos de `04-final-delivery/07-hidro-smart`. El Release público contiene los doce ZIP de los seis repositorios de código y sus digest SHA-256 coinciden con `code-tag/SHA256SUMS.txt`.

Los tags de los seis repositorios de componentes son ancestros de sus ramas remotas `main`; los ZIP del Release representan exactamente los commits etiquetados, no necesariamente el tip posterior de `main`.

## Evidencia disponible

- Figma y respuestas del formulario incluidos en `04-software-design/`.
- Documentos editables, PDF y fuentes Markdown/Drawio incluidos.
- Pitch público descargable: duración 01:40.
- Tutorial público descargable: duración 28:20; no cumple el rango requerido de 03:00 a 05:00 y debe reemplazarse por una versión recortada o un nuevo tutorial.
- La página pública de inicio de sesión respondió HTTP 200 y la API `/health` respondió HTTP 200 con estado `ok` y base `hidro_smart`.
- El chequeo estático del backend pasó sobre 217 archivos.
- En PT_HS, el CI del tag tiene dos workflows `HidroSmart CI` exitosos, pero la validación falla en `Validate and update database`; no es un gate verde.
- La instalación local de dependencias no pudo completarse; las pruebas que requieren paquetes npm no se presentan como aprobadas.

## Cierres externos pendientes

- Reemplazar el tutorial por una versión de 3 a 5 minutos y verificar visualmente sus cuatro puntos de contenido.
- Ejecutar las pruebas con dependencias instaladas y asociarlas al SHA exacto del tag.
- Aportar evidencia de producción, correo, restauración de base de datos, MQTT y prueba física del ESP32.
- Confirmar en el trámite externo la autoría, productor, titularidad y licencias de terceros.

