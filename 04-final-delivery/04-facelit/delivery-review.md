# Última revisión: VPS Hostinger

5 de noviembre de 2026. Fuente actual: facelit-docs, commit 299340428bc7b04fa013cd1b4d034f673b9d3dbc. Comparación completa del árbol desde dcf81aa: siete archivos cambiados; el resto de la documentación conserva su revisión anterior.

## Cambios incorporados en esta revisión

1. Documento general, PDF y Markdown: ahora explica el despliegue integral en VPS Hostinger, no la propuesta anterior Render/Vercel.
2. Manual técnico, PDF y Markdown: dominio facelit.tech, red privada de servicios y configuración de API para reconstruir el APK.
3. Artículo fuente: se incorpora el PDF actualizado del equipo como source-project-article.pdf. El artículo complementario conserva su editable propio y el flujo técnico actual consolidado.
4. README principal e índices de manuales/artículo: enlaces y procedencia de los nuevos documentos.

## Qué significa el cambio de Hostinger

Hostinger es el proveedor del VPS utilizado para alojar FaceLit. El dominio público es https://facelit.tech/. Caddy sirve la web y hace proxy de API y WebSocket. Docker Compose ejecuta PostgreSQL con pgvector, Spring Boot y FastAPI en la red privada del mismo VPS. Solo la capa web publica 80/443. El puerto 5439 corresponde al entorno local, no a un puerto público de producción.

Android se genera por separado con EAS. El manual actualizado pide configurar EXPO_PUBLIC_API_URL=https://facelit.tech antes de reconstruir el APK y probar el artefacto exacto. Esta revisión no construye ni valida ese APK.

## Observación del artículo fuente

El artículo del equipo corrigió la sección de alojamiento. Sin embargo, el apartado de enrolamiento conserva la frase de acceso directo del frontend a Python de una revisión anterior. El SRS V4.1 y el diseño describen la coordinación mediante backend. Se conserva el PDF recibido sin alterar y se señala esta diferencia; el complemento consolidado mantiene el recorrido cliente-backend-servicio facial. No se presenta la copia del PDF como un editable original.

## Límites y pendientes

El informe de despliegue mantiene sus diferencias entre paquete local y GitHub. La Persona 1 debe comprobar main, tag, manifiesto y ZIP. Permanecen las confirmaciones personales, registro y videos indicadas en la revisión anterior. No se accedió al servidor, no se desplegó, no se ejecutaron pruebas del producto y no se publicaron cambios en GitHub.

## Revisión anterior conservada como antecedente

## Actualización anterior - Persona 2

Fecha: 5 de noviembre de 2026. Fuente facelit-docs fijada en dcf81aad429eeffbbe9f9ac17d0b7946e82c3dcb. Se compara con el corte anterior 8c7f99a.

## Qué se actualizó según la actividad

| Producto o campo | Cambio preparado |
|---|---|
| 01 Requisitos | SRS documental V4.1 y anexos A/B: matriz de 97 identificadores, 60 registros especializados y decisiones. PDF y Markdown. |
| 02 Análisis | Inventario funcional del Anexo C y complemento de análisis ajustado a Ambientes, API de asistencia y alcance vigente. |
| 03 Propuesta | Conserva la propuesta técnica; añade inventario documental de dependencias y licenciamiento, sin convertir la propuesta en licencia aprobada. |
| 04 Diseño | Diseño visual completo de 28 páginas, DOCX editable, Markdown, mapas por rol, flujo general, logos, identidad y tokens. Complemento de datos actualizado para distinguir DDL inicial y paquete de noviembre. |
| 05 Pruebas | Catálogo con 16 capturas de entrega, imágenes y PDF de lectura; resumen de evidencia actualizado sin inventar corridas ni resultados. |
| 06 Implementación | Informe reciente de despliegue, paquete local, dominio, commits base y diferencias con GitHub. |
| 07 Mejoras | Clasificación de correctivas/preventivas/mejora ajustada a SRS V4.1 y seguimiento actual de criterios. |
| 08 Manuales | Manual de instalación actualizado: base, red, SMTP/CORS, inicialización de coordinador y migraciones. Técnico y usuario conservados con sus fechas de origen. |
| 09 Artículo | Complemento actualizado con SRS V4.1, capturas y diferencias del paquete publicado. |
| README general | Resumen y URL documentada del producto; índice local y aviso de pendientes. |
| Registro | Campos descriptivos respaldados por fuentes e inventario preliminar de terceros; sin marcar declaraciones ni elegir solicitante, autoría o publicación. |
| Videos | Plan de grabación para pitch y tutorial; aún requiere grabación, enlaces y prueba de permisos. |

## Fuente documental y precedencia

La presentación adjunta explica la entrega, pero los README oficiales determinan el contenido específico. Se mantiene su estructura y reglas: PDF y editable cuando exista, nombres ingleses sin espacios ni tildes, documentos en la carpeta del proyecto y archivos de más de 50 MB en Drive. ZIP y huellas corresponden a Persona 1 y al Release, no a esta actualización documental.

SRS V4.1 actualiza individualmente los 97 IDs. Anexo A registra 6 operativos confirmados, 8 con evidencia visual, 23 integrados en código, 2 integrados con criterio adicional, 48 criterios por verificar, 6 diferencias con el criterio, 2 objetivos adicionales, 1 retirado y 1 ampliación futura. No son porcentajes de aprobación ni resultados nuevos de ejecución.

El manual de instalación y despliegue recientes actualizan datos que otros informes conservan como antecedentes: migraciones 025/026 en la cadena local y DB local 422aac6. Al leer notas anteriores de arquitectura, modelo, propuesta, manual técnico o implementación, distinguir su fecha y dar prioridad al SRS V4.1 y al informe reciente para esas diferencias. No se borra el registro histórico ni se declara que todo esté publicado en GitHub.

## Qué muestran las nuevas capturas

Ocho imágenes de coordinación, una de instructor y siete de aprendiz. Se copian las versiones de Entrega con zonas cubiertas, sin los originales identificables. La vista CSV muestra preparación; las alertas muestran validación; la matriz no incluye el archivo exportado; la validación facial y su aviso son imágenes separadas. El catálogo no identifica SHA o entorno solo por la imagen.

## Reproducibilidad del despliegue

La fuente declara frontend base 6efd92c con cambio local de consultas en lotes de hasta 80, backend 2ba7398, facial 166e4a7 y DB local 422aac6 frente al remoto de referencia cd069ae. La publicación fue por SSH/SCP sin push de esos ajustes. La Persona 1 debe cotejar main, tag, manifiesto y artefactos; esta organización no resuelve la diferencia ni asegura instalación idéntica desde el tag remoto.

## Pendientes reales de Persona 2

1. Cada integrante confirma su rol, aporte y datos; cada autorización corresponde a su titular. No se marcaron en su nombre.
2. Confirmar solicitante, declaraciones de obra, publicación, año definitivo y registro con el equipo/instructor. La descripción técnica y tabla preliminar de terceros están preparadas con sus fuentes.
3. Completar inventario exacto de componentes/modelos distribuidos y avisos; las condiciones citadas proceden de la documentación, no de una revisión legal nueva.
4. Grabar pitch de 1-2 minutos y tutorial real de 3-5; subir a Drive, completar enlaces y probar en ventana privada.
5. Revisar con Persona 1 los documentos frente al artefacto exacto entregado y aportar evidencia de los criterios que el SRS mantiene por verificar.

## Qué no se realizó

No se ejecutó FaceLit, no se desplegó, no se crearon tags/ZIP/Release/PR ni se subieron cambios a GitHub. No se tocaron datos de autoría o titularidad, autorizaciones, datos privados ni los archivos de code-tag. No se asignaron aprobaciones por el solo hecho de organizar documentos.

## Trazabilidad

La carpeta incluye índices por producto con enlaces reales. Los editables Markdown fueron adaptados para encontrar sus recursos en la estructura de entrega. Los PDF recibidos conservan su contenido y fechas. Los complementos nuevos o actualizados indican su carácter documental. Se conserva un manifiesto de fuentes y huellas en el área de trabajo; las huellas no sustituyen SHA256SUMS de los ZIP de Persona 1.
