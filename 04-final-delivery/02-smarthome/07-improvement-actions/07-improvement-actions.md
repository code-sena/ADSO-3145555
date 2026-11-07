# Documentación de acciones correctivas, preventivas y de mejoramiento

**Proyecto:** SmartHome · **Ficha:** ADSO 3145555 · **Fecha:** 6 de noviembre de 2026

**Elaborado por:** Natalia Chala Chala · Kevin Stiven López Amaya · Karen Daniela Holguín Cruz

**Instructor:** José de Jesús Motta Vargas

**Estado:** registro técnico basado en evidencias; acciones abiertas y propuestas se identifican expresamente.

---

## 1. Presentación

El mejoramiento de SmartHome no se reduce a enumerar errores. Consiste en identificar una situación verificable, comprender su impacto, definir una respuesta y conservar evidencia suficiente para comprobar si la acción produjo el resultado esperado. Este documento presenta las acciones correctivas, preventivas y de mejora de la entrega ADSO 3145555 con base en el SRS, el código del proyecto, los resultados de integración continua y los documentos históricos del equipo.

A diferencia de un informe de avances porcentuales, cada registro distingue entre hechos comprobados, actividades en curso y propuestas. Así se evita declarar una corrección como terminada cuando solo existe una intención de implementarla. El análisis cubre backend, base de datos, frontend web, aplicación móvil, integración IoT y documentación.

## 2. Objetivo, alcance y criterio de evidencia

El objetivo es consolidar un registro de decisiones técnicas orientadas a resolver defectos observados, reducir riesgos futuros y elevar la calidad de la solución sin alterar su alcance aprobado. Se aplica una evaluación documental al 6 de noviembre de 2026: las ejecuciones citadas pertenecen a los commits indicados en cada enlace y no representan pruebas locales nuevas realizadas para esta redacción.

| Clasificación | Uso en este informe |
| --- | --- |
| Comprobado | Resultado o condición visible en un workflow, archivo de código, issue o README identificado. |
| En seguimiento | Existe evidencia del problema o de la actividad, pero no de su cierre. |
| Propuesto | Medida razonable que todavía no cuenta con ejecución o aceptación demostrada. |
| Histórico | Declaración encontrada en documentos previos; se conserva como antecedente, no como certificación. |

## 3. Diagnóstico técnico basado en las fuentes

El proyecto dispone de validaciones automatizadas útiles en cuatro repositorios. Estas verificaciones muestran una base técnica en funcionamiento dentro de CI, pero no reemplazan una prueba de operación completa con dispositivos físicos y un entorno de entrega congelado.

| Componente | Evidencia | Resultado observado |
| --- | --- | --- |
| Backend | E-01 · GitHub Actions, 60297c3 | CI aprobada: lint, TypeScript, Jest, build y prueba de seguridad MQTT. |
| Base de datos | E-02 · GitHub Actions, 3b20c91 | CI aprobada: Liquibase y auditorías de permisos en PostgreSQL de prueba. |
| Frontend web | E-03 · GitHub Actions, 7b9acdf | Validación, build y smoke Docker aprobados; publicación y despliegue omitidos. |
| Aplicación móvil | E-04 · GitHub Actions, 6b5fe36 | CI principal aprobada; la auditoría de dependencias separada falló. |

### 3.1. Incidencia de seguridad documentada

La auditoría móvil del 5 de noviembre detectó 14 hallazgos en dependencias clasificadas por npm como de producción: 5 altos, 8 moderados, 1 bajo y 0 críticos. El informe bloqueó la aprobación de seguridad. La incidencia #42 permanece abierta en el momento de la consulta. Los paquetes señalados incluyen expo-router, query-string, decode-uri-component, @expo/cli y zod.

El hallazgo no demuestra automáticamente explotación dentro de una APK. Algunas rutas pueden pertenecer a herramientas de compilación y otras exigirían verificar si son alcanzables en tiempo de ejecución. Precisamente por eso la remediación debe evitar actualizaciones mayores o overrides sin probar compatibilidad con Expo, navegación, BLE y MQTT.

### 3.2. Límites operativos y documentales

El README del backend indica que en DEV se han probado telemetría y control sobre un Shelly conocido, pero que el emparejamiento LAN/AP desde cero aún está pendiente. El workflow del frontend web conserva expresamente deshabilitado el trabajo de despliegue, a la espera de revisión de QA y recuperación. Por tanto, un build correcto no equivale a despliegue de producción confirmado.

En Drive existe un documento histórico de mejoras que presenta algunas tareas como corregidas y porcentajes de avance. Estos datos se consideran antecedentes: su fecha y su propio texto no prueban que cada solución siga vigente sobre el código más reciente. Además, el informe antiguo de diseño describe MFA obligatorio y el SRS actualizado lo excluye de la versión 1.0. La documentación final debe preservar esa diferencia.

## 4. Acciones correctivas

Una acción correctiva responde a un problema identificado. Para considerarla cerrada debe existir una evidencia nueva que demuestre la solución y descarte regresiones relevantes.

### AC-01 — Atender los hallazgos altos de dependencias móviles

**Prioridad:** Crítica · **Estado:** Abierta; registrada en issue #42

**Situación identificada.** El workflow de auditoría terminó en error con cinco hallazgos altos. No se ha acreditado cierre ni inexistencia de exposición en runtime Android.

**Medida definida.** Analizar cada dependencia y su ruta, distinguir CLI/build de runtime, seleccionar un parche compatible con Expo 57, actualizar lockfile mediante npm y repetir las verificaciones de navegación, BLE, MQTT y exportación Android.

**Evidencia disponible.** Auditoría 42026688999; incidencia #42; CI móvil 42026996921.

**Criterio de cierre.** Workflow de auditoría satisfactorio o evaluación documentada de cada riesgo; pruebas de regresión aprobadas y evidencia de compatibilidad Android.

### AC-02 — Conciliar requisitos y diseño histórico

**Prioridad:** Alta · **Estado:** Pendiente de revisión documental

**Situación identificada.** El SRS excluye MFA obligatorio de la v1.0, pero un informe de diseño previo lo describe como funcionalidad implementada. Otros textos contienen promesas de rendimiento y disponibilidad sin mediciones aportadas.

**Medida definida.** Revisar productos 01, 02, 04, 05, 06 y manuales; clasificar cada característica como implementada, prevista o fuera de alcance. Eliminar garantías no sustentadas y añadir vínculos a código y pruebas cuando existan.

**Evidencia disponible.** SRS FINAL 2026; informe histórico de diseño en Drive.

**Criterio de cierre.** Matriz de contradicciones resuelta, documentos consistentes y validación técnica cruzada del equipo.

### AC-03 — Corregir el inventario institucional de repositorios

**Prioridad:** Alta · **Estado:** Pendiente de conciliación

**Situación identificada.** El registro precargado en code-tag usa nombres de repositorios de documentación y base de datos distintos de los repositorios que contienen el código y los documentos centrales del proyecto.

**Medida definida.** Determinar con los propietarios qué repositorios son originales y cuáles son históricos; registrar ambos cuando corresponda, indicando estado, rama y commit. Actualizar los enlaces antes de publicar tags o archivos finales.

**Evidencia disponible.** README institucional code-tag y repositorios actuales de BD/documentación.

**Criterio de cierre.** Inventario único aprobado por el equipo, con URL y estado verificables para cada repositorio.

### AC-04 — Alinear la entrega final con la versión de main

**Prioridad:** Alta · **Estado:** Pendiente de validación final

**Situación identificada.** Los documentos técnicos existentes parten de revisiones de desarrollo, mientras la guía institucional exige una versión final etiquetada en main. No hay evidencia en estas fuentes que permita declarar completada la integración de todas las ramas.

**Medida definida.** Revisar diferencias dev/qa/main por componente, integrar únicamente cambios aprobados, ejecutar pruebas desde la revisión final y crear los tags/respaldos tras cumplir los controles de calidad y seguridad.

**Evidencia disponible.** README institucional y workflows de release/CI.

**Criterio de cierre.** Commits de main documentados, controles aprobados, tag final-delivery-2026 y enlaces verificables.

## 5. Acciones preventivas

Una acción preventiva reduce la probabilidad de nuevos defectos o evita que una condición conocida afecte a versiones futuras. Puede existir como política definida sin que ello pruebe su eficacia en todos los escenarios.

### AP-01 — Proteger la promoción entre entornos

**Prioridad:** Alta · **Estado:** Control presente en frontend web; revisión general pendiente

**Situación identificada.** Un cambio que llegue sin validación a main puede dejar el software final distinto de la versión documentada.

**Medida definida.** Mantener el flujo dev → qa → main donde aplique; exigir aprobación de CI y evidencia mínima antes de liberar. Verificar que todos los componentes compartan una política de promoción apropiada.

**Evidencia disponible.** Workflow ci-deploy.yml del frontend y política de promoción móvil.

**Criterio de cierre.** PRs trazables, comprobaciones obligatorias y evidencia de una promoción sin saltos de validación.

### AP-02 — Prevenir la exposición de secretos y datos personales

**Prioridad:** Alta · **Estado:** Control preventivo propuesto

**Situación identificada.** Archivos de entorno, credenciales, URLs internas y datos personales pueden filtrarse a través de anexos, repositorios o capturas.

**Medida definida.** Usar ejemplos .env.example sin secretos, revisar commits/ZIP/PDF antes de publicar y rotar cualquier valor que haya quedado expuesto. Conservar evidencias depuradas en la documentación.

**Evidencia disponible.** Reglas de entrega institucional y plantillas de entorno del proyecto.

**Criterio de cierre.** Revisión de seguridad documentada, ausencia de credenciales en artefactos publicados y tratamiento de incidentes si aparecen.

### AP-03 — Evitar confundir comando MQTT con control físico confirmado

**Prioridad:** Media-alta · **Estado:** Control preventivo propuesto

**Situación identificada.** La emisión de un comando desde la API no comprueba por sí sola que el equipo haya cambiado su estado real.

**Medida definida.** Diferenciar estados de orden publicada, orden recibida y confirmación por telemetría. Exigir evidencia física y de broker para afirmar control end-to-end.

**Evidencia disponible.** Análisis del software, README del backend y flujo de pairing Shelly.

**Criterio de cierre.** Prueba de laboratorio documentada con respuesta de API, evento MQTT, estado observado y resultado consistente.

### AP-04 — Preservar compatibilidad durante correcciones de seguridad

**Prioridad:** Alta · **Estado:** Precaución técnica definida en issue #42

**Situación identificada.** Forzar actualizaciones mayores de dependencias puede romper módulos nativos, autenticación, navegación o BLE, aun si reduce advertencias de npm audit.

**Medida definida.** Probar cambios en rama específica; mantener matriz de compatibilidad; exigir instalación limpia, tipado, pruebas automatizadas, export Android y build de prueba cuando cambie código nativo.

**Evidencia disponible.** Incidencia #42 y workflow Mobile CI.

**Criterio de cierre.** Paquetes corregidos sin regresiones conocidas, con evidencia de build y pruebas del runtime correspondiente.

## 6. Acciones de mejoramiento continuo

Las acciones de mejora no requieren un defecto previo; buscan hacer el sistema más comprensible, mantenible, seguro y fácil de verificar.

### AM-01 — Fortalecer trazabilidad SRS–análisis–pruebas

**Prioridad:** Media · **Estado:** Iniciada en borradores documentales

**Situación identificada.** Los documentos originales no vinculaban consistentemente cada caso de uso o prueba con los identificadores del SRS.

**Medida definida.** Relacionar flujos de 02 y los casos de 05 con RF/RNF; revisar que cada código corresponda al contenido del requisito y añadir evidencia de aceptación donde exista.

**Evidencia disponible.** SRS actualizado y documentos 02/05 preparados.

**Criterio de cierre.** Matriz de trazabilidad revisada, sin requisitos mal asociados y con evidencia diferenciada por estado.

### AM-02 — Aprovechar los prototipos reales del equipo

**Prioridad:** Media · **Estado:** Fuentes identificadas; integración editorial pendiente

**Situación identificada.** Un documento de diseño con esquemas genéricos representa peor el trabajo colaborativo que las pantallas y diagramas producidos por el equipo.

**Medida definida.** Seleccionar capturas de prototipos web y móvil y diagramas originales del Drive; contrastarlos con la navegación actual; identificar cada figura como prototipo histórico o interfaz implementada.

**Evidencia disponible.** Carpetas Prototipo, Diagramas y DRAW.IO de Drive.

**Criterio de cierre.** Documento 04 con figuras legibles, atribución, pie de figura y correspondencia comprobada con la versión de código descrita.

### AM-03 — Consolidar un registro de evidencias de calidad

**Prioridad:** Media · **Estado:** Documentación parcial ya disponible

**Situación identificada.** Los pipelines están distribuidos entre repositorios, lo que dificulta comunicar qué pasó, dónde y sobre qué commit.

**Medida definida.** Mantener una matriz compacta de evidencias con componente, SHA, fecha, pasos aprobados, incidencias y enlace. Actualizarla tras cada versión candidata.

**Evidencia disponible.** CI backend, web, BD, móvil y auditoría móvil.

**Criterio de cierre.** Registro por componente reproducible, con fallos visibles y sin afirmar aprobaciones inexistentes.

### AM-04 — Hacer reproducible el procedimiento de instalación

**Prioridad:** Media · **Estado:** Procedimiento escrito; prueba limpia pendiente

**Situación identificada.** Los manuales históricos incluyen rutas de repositorio ficticias y comandos que no necesariamente corresponden a la estructura actual.

**Medida definida.** Validar desde un entorno limpio el orden PostgreSQL/Liquibase → backend → web/móvil; usar las plantillas .env.example y registrar pasos observados y errores frecuentes.

**Evidencia disponible.** Producto 06, READMEs de los repositorios y manuales históricos.

**Criterio de cierre.** Acta de instalación limpia con comandos ejecutados, versiones y resultado de cada componente.

## 7. Priorización y seguimiento

Se recomienda resolver primero los hallazgos que pueden bloquear la aceptación o comprometer la coherencia de la versión final. El estado de cada acción debe actualizarse únicamente cuando aparezcan evidencias nuevas, no por estimaciones subjetivas de avance.

| Orden | Acciones | Justificación de prioridad |
| --- | --- | --- |
| 1 · Crítica | AC-01 | Control de seguridad móvil bloqueado por auditoría. |
| 2 · Alta | AC-04, AC-03 | La entrega exige versión final y repositorios originales identificados. |
| 3 · Alta | AC-02, AP-01, AP-02, AP-04 | Coherencia documental y prevención de fallos en publicación. |
| 4 · Media | AP-03, AM-01, AM-02, AM-03, AM-04 | Calidad, usabilidad, trazabilidad y validación de hardware. |

## 8. Condiciones para declarar una acción cerrada

Una acción no se cierra por haber sido descrita en el informe. La evidencia mínima aceptable es: (1) referencia exacta al cambio o decisión aprobada, (2) versión o commit relacionado, (3) ejecución o revisión verificable, (4) resultado observado y (5) ausencia de una regresión relevante. Si la acción depende de hardware, además se requiere evidencia de laboratorio.

La documentación que se publique como producto final debe conservar estos estados y distinguir las fechas de los hallazgos y de sus comprobaciones. No se incorporan contraseñas, tokens ni datos privados en las pruebas, capturas o anexos.

## 9. Conclusión

SmartHome dispone de una base de validaciones técnicas útil para sostener su avance: los cuatro componentes principales registran ejecuciones de CI aprobadas en los commits consultados. Sin embargo, la auditoría móvil fallida, la vinculación física Shelly pendiente y las diferencias entre documentos históricos y requisitos actuales muestran que todavía existen acciones de cierre importantes.

La calidad de una entrega final depende de explicar esas situaciones con precisión. Esta actualización organiza las acciones en medidas correctivas, preventivas y de mejora, establece criterios de cierre comprobables y evita presentar como completadas actividades que aún necesitan pruebas o conciliación documental.

## 10. Referencias y fuentes consultadas

1. [Guía institucional, producto 07](https://github.com/code-sena/ADSO-3145555/blob/main/04-final-delivery/02-smarthome/07-improvement-actions/README.md)
2. [Especificación de requisitos SmartHome, SRS 2026](https://docs.google.com/document/d/1BYwKmODc6xmjVqJjOdBtK7t9KJr7vHnm/edit)
3. [Plan histórico de mejoras del equipo](https://docs.google.com/document/d/1JLrAS4_XM3BAxFMMlbMBB01nZ2s1WX9w/edit)
4. [CI del backend (04 nov, SHA 60297c3)](https://github.com/nataliachala1/smarthome-backend/actions/runs/41937120061)
5. [CI de la base de datos (04/05 nov, SHA 3b20c91)](https://github.com/nataliachala1/smarthome-database/actions/runs/41949904947)
6. [CI del frontend web (05 nov, SHA 7b9acdf)](https://github.com/nataliachala1/smarthome-frontend-web/actions/runs/42029415737)
7. [CI de la aplicación móvil (05 nov, SHA 6b5fe36)](https://github.com/Kevin-Stiven-Lopez-Amaya404/from_movil/actions/runs/42026996921)
8. [Auditoría de dependencias móvil (05 nov, fallida)](https://github.com/Kevin-Stiven-Lopez-Amaya404/from_movil/actions/runs/42026688999)
9. [Incidencia abierta de seguridad móvil #42](https://github.com/Kevin-Stiven-Lopez-Amaya404/from_movil/issues/42)
10. [Backend, README de la rama dev](https://github.com/nataliachala1/smarthome-backend/blob/dev/README.md)
11. [Frontend web, workflow de publicación](https://github.com/nataliachala1/smarthome-frontend-web/blob/dev/.github/workflows/ci-deploy.yml)
12. [Inventario institucional de código](https://github.com/code-sena/ADSO-3145555/blob/main/04-final-delivery/02-smarthome/code-tag/README.md)
13. [Carpeta de fuentes SmartHome en Drive](https://drive.google.com/drive/folders/1XixiaSgSRYYQ-v05Cc7eiCjQqPzcn5i1)

*Las referencias de GitHub Actions corresponden a los commits y fechas registrados en dichas ejecuciones. Los documentos históricos se citan como antecedentes, no como pruebas de resultado.*