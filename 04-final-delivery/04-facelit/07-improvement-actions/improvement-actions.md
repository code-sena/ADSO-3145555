# Acciones correctivas, preventivas y de mejora
FaceLit. Clasificación para la actividad de entrega final, 5 de noviembre de 2026.
## Alcance
Este registro organiza las acciones descritas en quality-and-improvements y reported-test-results. No acredita ejecución nueva. Responsable y fecha de cierre deben confirmarse por el equipo; las asignaciones de Persona 1 y Persona 2 son distribución de trabajo propuesta.
## Acciones correctivas
| ID y problema | Acción | Estado según fuentes | Evidencia para cierre |
|---|---|---|---|
| AC-01 Cámara | Ajustar permisos, estados, guía visual y liberación del stream. | Corrección reportada por el equipo. | Prueba de permiso permitido/denegado, reintento y cierre en versión final. |
| AC-02 Registro incompleto | Esperar respuesta remota y comprobar persistencia antes de comunicar éxito. | Mecanismos descritos en código; corrección reportada. | Consulta tras recarga, fallo de red y duplicidad. |
| AC-03 Traducciones | Corregir claves y textos de las pantallas afectadas. | Corrección reportada; regresión por pantalla no adjunta. | Capturas y resultado en idiomas habilitados, sin datos reales. |
| AC-04 Artículo desactualizado | Sustituir topología Render/Vercel y llamada facial directa por la arquitectura documentada reciente. | Corrección documental realizada en project-article. | Revisión conjunta del artículo con la Persona 1 y tag final. |
## Acciones preventivas
| ID y riesgo | Acción | Estado | Criterio de cierre |
|---|---|---|---|
| AP-01 Credenciales expuestas | Revisar referencias EXPO_PUBLIC heredadas, bundle, documentos y secretos; rotar si hubo exposición. | Revisión final pendiente de Persona 1. | Evidencia de revisión sin divulgar valores privados. |
| AP-02 Pérdida de datos | Respaldar antes de migraciones y ensayar restauración en entorno separado. | Respaldo reportado; ensayo de restauración pendiente. | Registro de restauración y consultas de integridad. |
| AP-03 Regresión de permisos | Repetir casos por rol y alcance de ficha/sesión en cada versión. | Plan preparado; requiere resultados del tag final. | Solicitudes válidas y rechazos con resultados por caso. |
| AP-04 Inconsistencia documental | Revisar manuales, SRS, modelos y versiones antes del Release. | Matriz de correspondencia preparada. | Evidencia por requisito y referencias al código exacto entregado. |
## Acciones de mejoramiento
| ID y oportunidad | Acción | Estado | Criterio de cierre |
|---|---|---|---|
| AM-01 Rendimiento | Medir captura, transporte, inferencia y persistencia con carga definida. | Sin medición formal en las fuentes. | Protocolo, datos autorizados, latencias y errores registrados. |
| AM-02 Evaluación biométrica | Evaluar falsas aceptaciones/rechazos y condiciones diversas. | Sin estudio representativo adjunto. | Muestra autorizada, criterios y métricas; 0.65 no es porcentaje de precisión. |
| AM-03 Operación móvil | Validar APK exacto en dispositivo si se entrega Android. | Aceptación del APK no acreditada en estas fuentes. | Build, SHA, dispositivo y resultado del recorrido. |
| AM-04 Trazabilidad | Conservar los 97 IDs del SRS V4.1 actualizados y añadir evidencia del tag final a los criterios que la requieran. | Matriz V4.1 y anexos del 5 de noviembre disponibles; criterios especializados pendientes según cada fila. | Estado individual por RF/RNF con fecha, entorno y revisor. |
## Seguimiento y responsabilidades
Persona 1 coordina correcciones técnicas, pruebas, SHA y respaldos. Persona 2 mantiene documentos y evidencias. Cada cierre debe indicar responsable real, fecha, versión, caso de prueba, resultado y enlace a evidencia. No convertir una acción planificada o reportada en una prueba aprobada sin soporte.

## Actualización de seguimiento
El Anexo B actualizado está en ../01-requirements-specification/criteria-and-decisions.md. Organiza 60 registros especializados y seis decisiones. El catálogo visual aporta evidencia de pantallas; no convierte esos 60 registros en fallos ni en pruebas aprobadas. Las acciones anteriores que mencionen una matriz histórica se leen con esta actualización.
