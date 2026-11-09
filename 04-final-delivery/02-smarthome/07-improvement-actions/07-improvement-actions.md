# Producto 07 — Acciones correctivas, preventivas y de mejoramiento

Proyecto: SmartHome | Ficha: ADSO 3145555 | Fecha: 7 de noviembre de 2026

Equipo: Natalia Chala Chala; Kevin Stiven López Amaya; Karen Daniela Holguín Cruz

Estado: consolidación para revisión; no implica aprobación de acciones abiertas.

## 1. Propósito, alcance y fuentes

El documento toma como base `07-improvement-actions.md` del PR #17 (6 de noviembre de 2026) y conserva el Word original como antecedente histórico. Separa evidencia de cierre y propuestas.

Como marco de referencia, las acciones correctivas, preventivas y de mejora se plantean según el ciclo de mejora continua y el tratamiento de no conformidades de ISO 9001 (International Organization for Standardization, 2015), y los riesgos de seguridad se priorizan con las categorías de OWASP Top 10 (OWASP Foundation, 2021).

## 2. Definiciones y cierre

- Correctiva: resuelve defectos observados.
- Preventiva: reduce riesgos futuros.
- Mejoramiento: eleva calidad y trazabilidad.
- Cierre: requiere versión, evidencia, resultado y revisión del responsable; para control IoT, validación física.

## 3. Diagnóstico

CI históricas no constituyen aceptación de `main`. La incidencia móvil #42 está abierta. El reporte antiguo cita 14 hallazgos y el título actual de la incidencia menciona 20; cada cifra corresponde a un registro distinto y requiere conciliación.

## 4. Priorización

**Tabla 1**

*Priorización*

| Prioridad | Acciones |
|---|---|
| Crítica | AC-01 |
| Alta | AC-02, AC-03, AC-04, AP-01, AP-02, AP-04 |
| Media o media-alta | AP-03, AM-01, AM-02, AM-03, AM-04 |

Fuente: elaboración propia.

## Acciones correctivas

### AC-01 — Gestionar los hallazgos de seguridad de dependencias móviles

Prioridad: Crítica | Estado: Abierta; seguimiento en issue #42

Situación: La auditoría de dependencias móviles registró hallazgos y bloqueó la aceptación de seguridad en la ejecución documentada del 5 de noviembre. El reporte histórico menciona 14 hallazgos, mientras el título actual de la incidencia #42 menciona 20; son referencias que deben conciliarse por ejecución y versión, sin sumar ni asumir equivalencia.

Acción: Identificar dependencias directas y transitivas afectadas; distinguir herramientas de compilación frente a librerías expuestas en ejecución; evaluar correcciones compatibles con la versión de Expo de cada rama; actualizar el lockfile de forma controlada y ejecutar pruebas de navegación, BLE, MQTT y build Android.

Evidencia: Auditoría móvil GitHub Actions 42026688999; CI móvil 42026996921; incidencia móvil #42 (abierta en la consulta de 7 de noviembre).

Criterio de cierre: Cada hallazgo tiene decisión documentada; auditoría aprobada o excepciones evaluadas y justificadas; regresiones automatizadas y verificación Android acordadas por el equipo.

### AC-02 — Conciliar SRS y documentos históricos de diseño

Prioridad: Alta | Estado: En revisión documental

Situación: Documentos de diseño anteriores describen características como MFA obligatorio y garantías de rendimiento que el SRS actualizado no confirma para la versión evaluada.

Acción: Cruzar requisitos del SRS con análisis, diseño, pruebas y manuales; clasificar cada capacidad como implementada, propuesta, fuera de alcance o pendiente de prueba; eliminar afirmaciones absolutas no demostradas.

Evidencia: SRS 2026; producto 02 y producto 04 del PR #17; documentación histórica en Drive.

Criterio de cierre: Matriz de discrepancias resuelta y documentos coherentes, con aprobación del equipo sobre el alcance real.

### AC-03 — Aclarar repositorios vigentes y repositorios históricos

Prioridad: Alta | Estado: Pendiente de aprobación del inventario

Situación: El inventario institucional menciona smart-home-docs y smart-home-database; la documentación central y la BD vigentes se encuentran, respectivamente, en smart-home-doc y smarthome-database.

Acción: Identificar repositorios exigidos explícitamente por el instructor, distinguir los históricos de los canónicos y documentar URLs, responsables, rama y commit de cada uno. Solicitar confirmación antes de reemplazar o sumar repositorios en la exportación.

Evidencia: code-tag/README.md del PR #17; repositorios históricos y canónicos.

Criterio de cierre: Inventario completo y ratificado, sin omitir los cinco repositorios exigidos ni confundirlos con los actuales.

### AC-04 — Alinear la documentación con la versión definitiva de main

Prioridad: Alta | Estado: Pendiente de validación de release

Situación: El contenido técnico se elaboró a partir de revisiones de desarrollo; el instructor exige versiones definitivas identificables y dos exportaciones por repositorio.

Acción: Revisar dev, qa y main en cada componente, validar cambios, definir commit de cierre y solo después crear tags anotados final-delivery-2026, generar ZIP de snapshot y exportación Git, calcular SHA-256 y adjuntar evidencia al Release.

Evidencia: PR #17 y su inventario de entrega; code-tag/README.md; Release documental final-delivery.

Criterio de cierre: Commits finales aprobados, pruebas registradas, tags publicados, diez ZIP técnicos verificables y hashes auténticos (o ajuste autorizado del alcance).

## Acciones preventivas

### AP-01 — Controlar la promoción de cambios entre ambientes

Prioridad: Alta | Estado: Control documentado; revisión global pendiente

Situación: El uso de ramas de trabajo sin controles coherentes puede producir diferencias entre el software entregado y el documentado.

Acción: Aplicar la ruta dev → qa → main cuando corresponda; exigir revisión de PR, pruebas automatizadas y aprobación antes de la promoción. Guardar SHA, resultado CI y autorizaciones.

Evidencia: Workflow del frontend web; políticas y PR de la aplicación móvil.

Criterio de cierre: Flujo de promoción aplicado y comprobado en los componentes pertinentes, con seguimiento de cada entrega.

### AP-02 — Prevenir exposición de secretos y datos personales

Prioridad: Alta | Estado: Medida preventiva propuesta

Situación: Los archivos .env, capturas, ZIP y anexos académicos podrían contener secretos, cuentas o identificaciones personales que no deben difundirse sin control.

Acción: Mantener solo .env.example con valores ficticios; revisar contenido y metadatos de entregables; evitar publicar credenciales; solicitar autorización explícita de titulares para datos personales; rotar secretos si se detecta exposición.

Evidencia: Plantillas de configuración; README institucional, team-roster.md y software-registration.md.

Criterio de cierre: Revisión de privacidad/seguridad completada y evidencia de permisos o corrección de incidentes, sin marcar consentimientos por terceros.

### AP-03 — Separar aceptación de órdenes MQTT y confirmación física

Prioridad: Media-alta | Estado: Propuesta de control; prueba física pendiente

Situación: La respuesta de la API o la publicación del mensaje MQTT no demuestran por sí solas que un dispositivo Shelly cambió su estado físico.

Acción: Registrar por separado orden aceptada, entrega al broker, respuesta del dispositivo y lectura posterior; documentar errores y tiempos de espera; exigir prueba con hardware real para el cierre.

Evidencia: Producto 02, README backend y escenarios de pairing Shelly.

Criterio de cierre: Evidencia end-to-end desde interfaz hasta dispositivo con estado físico observado y telemetría coherente.

### AP-04 — Proteger la compatibilidad durante actualizaciones de seguridad

Prioridad: Alta | Estado: Precaución asociada a issue #42

Situación: Forzar actualizaciones de dependencias, sobre todo con cambios mayores, puede afectar navegación, BLE, MQTT o compilación móvil.

Acción: Mantener cambios en ramas específicas, versiones compatibles, instalación limpia, tipado y suites de regresión; ejecutar build nativo cuando cambien librerías o permisos de Android.

Evidencia: Incidencia móvil #42; workflows Mobile CI y auditorías.

Criterio de cierre: Reducción del riesgo de dependencias sin regresiones conocidas y con controles reproducibles.

## Acciones de mejoramiento

### AM-01 — Aumentar trazabilidad entre requisitos, análisis y pruebas

Prioridad: Media | Estado: Iniciada en entregables del PR #17

Situación: Las versiones antiguas no vinculaban de modo consistente los diagramas y casos de prueba con los códigos RF/RNF del SRS.

Acción: Relacionar casos de uso del producto 02 y pruebas del producto 05 con requisitos exactos; diferenciar ejecución, resultado y evidencia disponible por caso.

Evidencia: SRS final; productos 02 y 05 preparados en el PR #17.

Criterio de cierre: Matriz de trazabilidad revisada y aprobada sin códigos incorrectos, con evidencia separada de resultados esperados.

### AM-02 — Incorporar prototipos y diagramas propios con trazabilidad

Prioridad: Media | Estado: Fuentes identificadas; integración visual por concluir

Situación: Presentar diagramas genéricos como únicos referentes no evidencia adecuadamente los prototipos y diagramas realizados por el equipo.

Acción: Seleccionar diagramas y pantallas originales de Drive, agregar descripción y pie de figura, indicar cuáles son prototipos históricos y contrastarlos con la navegación implementada.

Evidencia: Material gráfico de Drive; producto 04 de diseño.

Criterio de cierre: Documento de diseño con figuras legibles, autoría indicada y correspondencia comprobada.

### AM-03 — Centralizar el inventario de evidencias de calidad

Prioridad: Media | Estado: Registro parcial existente

Situación: La evidencia CI se encuentra distribuida entre varios repositorios y ramas, dificultando identificar qué se probó y sobre qué commit.

Acción: Crear tabla de componente, rama, SHA, fecha, workflow, resultado, incidencias y enlace; mantener visible cualquier fallo; actualizarla en cada candidato a Release.

Evidencia: Workflows de backend, BD, web y móvil; auditoría de dependencias.

Criterio de cierre: Inventario actualizado y reproducible para el commit definitivo de cada componente.

### AM-04 — Validar los manuales mediante una instalación limpia

Prioridad: Media | Estado: Manual redactado; verificación práctica pendiente

Situación: Algunos procedimientos históricos contienen rutas de ejemplo o requisitos no validados contra la estructura real de los repositorios.

Acción: Probar en entorno aislado la instalación desde PostgreSQL/Liquibase, backend, web y móvil; utilizar variables de ejemplo; registrar errores y dependencias previas.

Evidencia: Producto 06, manuales del producto 08 y READMEs de los repositorios.

Criterio de cierre: Acta de instalación limpia con comandos, versiones, resultados y correcciones necesarias.

## Seguimiento y aprobación

Solicitar por acción: fecha, rama/commit SHA, prueba o acta, resultado, revisor y cierre. No declarar acciones ejecutadas por la sola existencia del documento.

## Conclusión

Este registro organiza doce acciones para la evaluación. Las acciones abiertas requieren verificación independiente y ratificación del equipo.

## Fuentes

- [Guía institucional del producto 07](https://github.com/code-sena/ADSO-3145555/blob/main/04-final-delivery/02-smarthome/07-improvement-actions/README.md)
- [Documento actualizado de acciones - PR #17](https://github.com/Kevin-Stiven-Lopez-Amaya404/ADSO-3145555/blob/final-delivery/smarthome-stiven-20261107/04-final-delivery/02-smarthome/07-improvement-actions/07-improvement-actions.md)
- [Documento original del equipo en Google Drive](https://docs.google.com/document/d/1hew7CuQoNGK9ft6fpm9L-mvwjkPk9tBX/edit)
- [PR #17 - Entrega académica](https://github.com/code-sena/ADSO-3145555/pull/17)
- [Incidencia móvil #42](https://github.com/Kevin-Stiven-Lopez-Amaya404/from_movil/issues/42)
- [Auditoría móvil citada - ejecución histórica](https://github.com/Kevin-Stiven-Lopez-Amaya404/from_movil/actions/runs/42026688999)
- [CI backend histórica](https://github.com/nataliachala1/smarthome-backend/actions/runs/41937120061)
- [CI PostgreSQL/Liquibase histórica](https://github.com/nataliachala1/smarthome-database/actions/runs/41949904947)
- [CI frontend web histórica](https://github.com/nataliachala1/smarthome-frontend-web/actions/runs/42029415737)
- [CI aplicación móvil histórica](https://github.com/Kevin-Stiven-Lopez-Amaya404/from_movil/actions/runs/42026996921)
- [Inventario de repositorios y tags](https://github.com/code-sena/ADSO-3145555/blob/main/04-final-delivery/02-smarthome/code-tag/README.md)

Alcance: documento derivado del Markdown técnico del PR #17 y contrastado con el Word histórico. No contiene firmas ni aprobaciones asumidas.

## Referencias

International Organization for Standardization. (2015). *Quality management systems — Requirements* (ISO 9001:2015). https://www.iso.org/standard/62085.html

OWASP Foundation. (2021). *OWASP Top 10:2021*. https://owasp.org/Top10/
