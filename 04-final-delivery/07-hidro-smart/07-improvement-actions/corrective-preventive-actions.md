> **Estado y alcance.** Documento en revisión para la entrega. Las fechas, cifras y funciones heredadas del documento fuente solo se consideran vigentes cuando están respaldadas por evidencia del monorepo PT_HS. Consulta el [índice de entrega](../README.md) y el [índice de entrega](../README.md).

<strong>HIDROSMART</strong>

Acciones correctivas, preventivas y de mejora

Registro de brechas, prioridad y criterio de cierre

Versión documental consolidada 1.0  
Fecha de corte: 2026-10-09  
Código documental: DOC-11


# 1. Objetivo

Este documento convierte las brechas identificadas en el corte documental en acciones trazables. Una acción se considera cerrada solo con evidencia fechada, responsable, commit o configuración identificable y resultado de prueba.

# 2. Acciones priorizadas

<table>
<tr>
<td><p><strong>ID</strong></p></td>
<td><p><strong>Tipo</strong></p></td>
<td><p><strong>Tema</strong></p></td>
<td><p><strong>Prioridad</strong></p></td>
<td><p><strong>Hallazgo</strong></p></td>
<td><p><strong>Acci&#243;n</strong></p></td>
<td><p><strong>Cierre</strong></p></td>
</tr>
<tr>
<td><p>ACP-01</p></td>
<td><p>Correctiva</p></td>
<td><p>Seguridad MQTT de producci&#243;n</p></td>
<td><p>Alta</p></td>
<td><p>Local opera sin TLS/ACL.</p></td>
<td><p>Configurar TLS, autenticaci&#243;n, ACL, rotaci&#243;n y probar reconexi&#243;n.</p></td>
<td><p>Prueba de conexi&#243;n autorizada/no autorizada y evidencia de certificados.</p></td>
</tr>
<tr>
<td><p>ACP-02</p></td>
<td><p>Correctiva</p></td>
<td><p>Calibraci&#243;n f&#237;sica</p></td>
<td><p>Alta</p></td>
<td><p>Hay lecturas f&#237;sicas, no ensayo de volumen conocido.</p></td>
<td><p>Comparar volumen patr&#243;n, pulsos y error por rango.</p></td>
<td><p>Acta de calibraci&#243;n, datos crudos y aceptaci&#243;n.</p></td>
</tr>
<tr>
<td><p>ACP-03</p></td>
<td><p>Preventiva</p></td>
<td><p>Backup y restore</p></td>
<td><p>Alta</p></td>
<td><p>No verificado end-to-end.</p></td>
<td><p>Automatizar backup, restauraci&#243;n y comprobaci&#243;n de integridad.</p></td>
<td><p>Log de restore, checksum y prueba de consultas.</p></td>
</tr>
<tr>
<td><p>ACP-04</p></td>
<td><p>Correctiva</p></td>
<td><p>Correo transaccional y alertas</p></td>
<td><p>Media</p></td>
<td><p>Brevo ya está integrado por API HTTPS según PT_HS; falta evidencia de entrega E2E de cada flujo activo y configuración privada del entorno.</p></td>
<td><p>Verificar remitente y variables en el gestor, probar verificación/recuperación y documentar messageId, entrega o rebote; conectar aparte los disparadores de alertas que falten.</p></td>
<td><p>Mensaje recibido, log y manejo de error.</p></td>
</tr>
<tr>
<td><p>ACP-05</p></td>
<td><p>Mejora</p></td>
<td><p>Frontend E2E y accesibilidad</p></td>
<td><p>Media</p></td>
<td><p>Lint/build no cubren flujos de usuario.</p></td>
<td><p>A&#241;adir pruebas de rutas, responsive, teclado y lector.</p></td>
<td><p>Reporte por navegador/dispositivo.</p></td>
</tr>
<tr>
<td><p>ACP-06</p></td>
<td><p>Mejora</p></td>
<td><p>Push de tiempo real</p></td>
<td><p>Media</p></td>
<td><p>UI usa polling HTTP de 5 segundos.</p></td>
<td><p>Evaluar WebSocket/SSE solo si el requisito lo exige y medir costo.</p></td>
<td><p>Decisi&#243;n arquitect&#243;nica y prueba de latencia.</p></td>
</tr>
<tr>
<td><p>ACP-07</p></td>
<td><p>Preventiva</p></td>
<td><p>Sincronizaci&#243;n documental</p></td>
<td><p>Media</p></td>
<td><p>Hay versiones locales con cifras/tecnolog&#237;as hist&#243;ricas.</p></td>
<td><p>Usar DOC-00 y fecha de corte en cada entrega.</p></td>
<td><p>Matriz actualizada y revisi&#243;n cruzada.</p></td>
</tr>
<tr>
<td><p>ACP-08</p></td>
<td><p>Mejora</p></td>
<td><p>Identidad institucional</p></td>
<td><p>Alta</p></td>
<td><p>PDF y documentos locales muestran c&#243;digos/fichas distintos.</p></td>
<td><p>Confirmar c&#243;digo, programa, ficha, centro y periodo con coordinaci&#243;n.</p></td>
<td><p>Acta o fuente institucional aprobada.</p></td>
</tr>
</table>


# 3. Clasificación de causas

<table>
<tr>
<td><p><strong>Causa</strong></p></td>
<td><p><strong>Ejemplo</strong></p></td>
<td><p><strong>Respuesta</strong></p></td>
</tr>
<tr>
<td><p>Evidencia incompleta</p></td>
<td><p>No hay prueba de backup/restore.</p></td>
<td><p>Planificar prueba y registrar resultado.</p></td>
</tr>
<tr>
<td><p>Deriva documental</p></td>
<td><p>WebSockets/cloud en documento antiguo.</p></td>
<td><p>Comparar contra c&#243;digo y marcar hist&#243;rico.</p></td>
</tr>
<tr>
<td><p>Dependencia externa</p></td>
<td><p>Brevo y evidencia de entrega, certificados/ACL MQTT y hardware físico.</p></td>
<td><p>Definir ambiente, responsable y criterio de aceptaci&#243;n.</p></td>
</tr>
<tr>
<td><p>Riesgo operativo</p></td>
<td><p>Broker local an&#243;nimo.</p></td>
<td><p>Endurecer configuraci&#243;n antes de producci&#243;n.</p></td>
</tr>
</table>


# 4. Seguimiento

Registrar responsable y fecha objetivo fuera de este documento o en el sistema de gestión aprobado.

No cerrar por declaración; adjuntar evidencia reproducible.

Revisar acciones en cada cambio de rama o corte del repositorio.

Priorizar seguridad, integridad de datos, calibración y recuperación antes de ampliar funcionalidades.

<strong>Nota de control documental. </strong>Las acciones se derivan de docs/estado-verificado-2026-09-26.md, contrato MQTT, README de firmware y discrepancias entre documentación local y código. No se asignan responsables o fechas no proporcionados por el proyecto.

<!-- footer: HidroSmart | DOC-11 | Versión documental consolidada 1.0 | Página PAGE -->


## Seguimiento al corte 2026-11-05

Las ocho acciones ACP de la sección anterior conservan los hallazgos del corte documental original (2026-10-09); no representan por sí solas el estado actual. Esta tabla actualiza el seguimiento con lo que el equipo reportó y con los artefactos disponibles. **Pendiente de verificar** significa que no hay evidencia suficiente para dar el cierre por demostrado en la versión y el entorno de entrega.

El corte histórico de código cotejado fue PT_HS `main`, commit `32be1cf787f20120dfd3b4cc72226dab55d88216` (2026-11-05). El candidato local actual de la entrega es PT_HS `main`/tag `final-delivery-2026`, commit `8dd45ca349134ad0851a536af5f90760b10691f3`; las observaciones históricas no sustituyen una prueba fechada sobre ese candidato.

| ID | Prioridad | Acción actual | Estado documentado al corte | Evidencia necesaria para cerrar |
|---|---|---|---|---|
| SEC-01 | P0 | Confirmar la rotación de credenciales expuestas y la limpieza acordada del historial publicado. | El equipo informó que cambió las credenciales. Este paquete no verifica la revocación de cada clave antigua ni una limpieza completa de todos los historiales remotos. | Confirmación de revocación en cada proveedor y escaneo documentado del historial/adjuntos; nunca incluir los valores secretos. |
| SRC-01 | Alta | Mantener PT_HS como fuente funcional canónica y fijar el conjunto exacto de componentes de entrega. | PT_HS fue elegido como fuente canónica. Los SHA remotos de `main` por componente están en code-tag/README.md; las ramas HU revisadas están contenidas en los `main` correspondientes, pero eso no demuestra equivalencia completa entre repositorios. | Aprobación de componentes, rama y SHA/tag para cada repositorio incluido. |
| CI-01 | Alta | Validar CI en el commit y la rama que se entregarán. | La evidencia de PT_HS `main` (`32be1cf`) es histórica: cuatro ejecuciones de Actions y nueve check-runs terminaron `success`, pero el estado combinado figuró `pending`. El candidato local actual es `8dd45ca`; no se validó CI remoto para ese tag ni para todos los componentes. | Conservar evidencia por SHA del candidato final; aclarar el estado combinado pendiente y verificar build/pruebas suficientes en cada repositorio incluido. |
| MQTT-01 | Alta | Validar TLS, ACL de Flespi y telemetría/estado/comandos del único ESP32. | Los logs compartidos el 2026-10-29 muestran conexión TLS a Flespi y publicaciones periódicas de telemetría. No demuestran por sí solos permisos ACL actuales, recepción del comando ni correspondencia con el tag final. | Evidencia redactada de conexión TLS, publicación de telemetry/status, comando autorizado y respuesta del dispositivo; sin token. |
| IOT-02 | Alta | Comprobar que pausar la contabilización conserva la medición y permite evaluar alertas de fuga. | El equipo aplicó tres changesets Liquibase relacionados con el estado de medición. No hay evidencia completa del ensayo físico antes/durante/después con alerta visible. | Lecturas, estados, alerta y resultado en UI/base de datos para un caso reproducible. |
| MAIL-01 | Alta | Verificar los flujos de correo activos mediante Brevo en el entorno candidato. | El equipo informó que funcionó la solicitud de recuperación de contraseña en pt-hs.pages.dev. Falta evidencia identificable de entrega por cada flujo activo (verificación, reenvío y recuperación) y versión. | Mensaje recibido y registro redactado de cada flujo, con estado/messageId cuando esté disponible, y prueba de manejo de errores. |
| DB-01 | Alta | Verificar migraciones de la versión candidata y una restauración real de PostgreSQL. | La salida compartida de Liquibase reportó la aplicación exitosa de tres changesets en Neon. No acredita una restauración probada ni el estado de un tag posterior. | status/changelog del entorno candidato y registro de restore en una instancia aislada, seguido de consultas de integridad. |
| DOC-01 | Media | Mantener Markdown y PDF coherentes y revisar su presentación completa. | Los PDF se generaron desde Markdown; hasta ahora se revisaron muestras de páginas, no todas las páginas de cada documento. | Revisión visual completa de los PDF, enlaces verificados y registro del resultado. |
| TEAM-01 | Media | Confirmar nombres, aportes, autoría y revisión por pares. | El roster consolida identidades observadas en seis repositorios; confirmaciones de integrantes e instructores siguen pendientes. | Aprobación personal e institucional y registro de la revisión independiente que corresponda. |
| REL-01 | Alta | Crear tag, ZIP, hashes y Release después de aprobar el paquete. | Los tags de componentes existen en los clones locales y el tag raíz debe apuntar al commit final de esta rama. El Release remoto, sus ZIP y sus hashes no se pudieron verificar en esta sesión. | SHA de entrega aprobado, exportaciones revisadas, SHA256SUMS.txt y acceso de revisión comprobado directamente en GitHub. |

Orden recomendado: SEC-01; SRC-01 y CI-01; MQTT-01, IOT-02, MAIL-01 y DB-01; DOC-01 y TEAM-01; finalmente REL-01. No se cierra una acción solo porque exista una implementación o una confirmación verbal.
