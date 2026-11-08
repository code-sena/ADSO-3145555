> **Estado y alcance.** Documento en revisión para la entrega. Las fechas, cifras y funciones heredadas del documento fuente solo se consideran vigentes cuando están respaldadas por evidencia del monorepo PT_HS. Consulta el [índice de entrega](../README.md) y el [índice de entrega](../README.md).

<strong>HIDROSMART</strong>

Plan y reporte de pruebas de HidroSmart

Evidencia disponible, criterios y pendientes

Versión documental consolidada 1.0
Fecha de corte: 2026-10-09
Código documental: DOC-07


# 1. Alcance y método

Este documento separa evidencia ya registrada en el repositorio de pruebas que aún deben ejecutarse. No se presentan como una nueva ejecución las cifras heredadas de docs/estado-verificado-2026-09-26.md. Cada nueva corrida debe guardar fecha, commit, ambiente, comando, resultado y evidencia.

# 2. Resumen de evidencia documentada

<table>
<tr>
<td><p><strong>&#193;rea</strong></p></td>
<td><p><strong>Resultado documentado</strong></p></td>
<td><p><strong>Fecha/corte</strong></p></td>
<td><p><strong>Estado</strong></p></td>
</tr>
<tr>
<td><p>Backend unitario</p></td>
<td><p>174 pruebas unitarias aprobadas.</p></td>
<td><p>2026-09-26</p></td>
<td><p>Registrado</p></td>
</tr>
<tr>
<td><p>Integraci&#243;n</p></td>
<td><p>4 aprobadas, 0 fallidas y 2 omitidas en corte hist&#243;rico.</p></td>
<td><p>Documentos hist&#243;ricos</p></td>
<td><p>Repetir para cierre</p></td>
</tr>
<tr>
<td><p>Frontend</p></td>
<td><p>Lint, typecheck y build aprobados.</p></td>
<td><p>2026-09-26</p></td>
<td><p>Registrado</p></td>
</tr>
<tr>
<td><p>Base de datos</p></td>
<td><p>Liquibase al d&#237;a; 245 changesets y 58 tablas de aplicaci&#243;n.</p></td>
<td><p>2026-09-26</p></td>
<td><p>Registrado</p></td>
</tr>
<tr>
<td><p>MQTT local</p></td>
<td><p>Broker y cadena de ingesti&#243;n saludables.</p></td>
<td><p>2026-09-26</p></td>
<td><p>Registrado</p></td>
</tr>
<tr>
<td><p>Firmware</p></td>
<td><p>Compilaci&#243;n y estructura verificadas; memoria reportada 17.6% RAM y 82.0% Flash.</p></td>
<td><p>2026-09-26</p></td>
<td><p>Registrado</p></td>
</tr>
<tr>
<td><p>Prueba f&#237;sica</p></td>
<td><p>5 lecturas en flujo y 6 lecturas en reposo persistidas para HS-141F47470968.</p></td>
<td><p>2026-09-26</p></td>
<td><p>Registrado</p></td>
</tr>
</table>


**Nota de reconciliación de base de datos:** el total de 58 tablas de la tabla anterior corresponde al reporte histórico del 2026-09-26. El inventario estático posterior de PT_HS `main` (`32be1cf787f20120dfd3b4cc72226dab55d88216`) identifica 57 sentencias `CREATE TABLE` en los changelogs consultados; la actualización HU-21 cambió solo un archivo del frontend y no modificó las migraciones de base de datos. No se debe interpretar la diferencia como una eliminación aplicada en Neon: el inventario no consulta la base desplegada. Confirmar el esquema vivo y sus migraciones antes de cerrar la prueba de base de datos.

# 3. Casos de prueba

<table>
<tr>
<td><p><strong>ID</strong></p></td>
<td><p><strong>Caso</strong></p></td>
<td><p><strong>Criterio</strong></p></td>
<td><p><strong>Observaci&#243;n</strong></p></td>
</tr>
<tr>
<td><p>T-01</p></td>
<td><p>Registro/verificaci&#243;n/login</p></td>
<td><p>Cuenta pendiente no entra; cuenta verificada inicia sesi&#243;n.</p></td>
<td><p>Debe repetirse con ambiente controlado.</p></td>
</tr>
<tr>
<td><p>T-02</p></td>
<td><p>Autorizaci&#243;n</p></td>
<td><p>401/403 seg&#250;n sesi&#243;n, rol y RLS.</p></td>
<td><p>Debe cubrir rutas cr&#237;ticas.</p></td>
</tr>
<tr>
<td><p>T-03</p></td>
<td><p>CRUD de hogar/dispositivo</p></td>
<td><p>Alta, asociaci&#243;n, edici&#243;n y consulta.</p></td>
<td><p>Debe incluir permisos por miembro.</p></td>
</tr>
<tr>
<td><p>T-04</p></td>
<td><p>Mensaje MQTT v&#225;lido</p></td>
<td><p>Lectura normalizada y persistida.</p></td>
<td><p>Criterio central de integraci&#243;n.</p></td>
</tr>
<tr>
<td><p>T-05</p></td>
<td><p>Mensaje MQTT inv&#225;lido</p></td>
<td><p>Rechazo, error trazable y sin lectura corrupta.</p></td>
<td><p>Agregar casos de tipos/rangos.</p></td>
</tr>
<tr>
<td><p>T-06</p></td>
<td><p>Duplicado MQTT</p></td>
<td><p>No se duplica cuando mqttMessageId coincide.</p></td>
<td><p>Verificar constraint/flujo real.</p></td>
</tr>
<tr>
<td><p>T-07</p></td>
<td><p>Agregados/gr&#225;ficas</p></td>
<td><p>Consulta consistente por periodo/unidad.</p></td>
<td><p>Comparar con lecturas base.</p></td>
</tr>
<tr>
<td><p>T-08</p></td>
<td><p>Alertas/metas</p></td>
<td><p>Regla genera evento seg&#250;n umbral.</p></td>
<td><p>En el corte hist&#243;rico de este reporte (2026-10-09), SMTP real pendiente; el corte t&#233;cnico 2026-11-04 documenta Brevo, con entrega integral a&#250;n por evidenciar.</p></td>
</tr>
<tr>
<td><p>T-09</p></td>
<td><p>BLE/firmware</p></td>
<td><p>Par&#225;metros quedan en NVS y el ESP32 reconecta.</p></td>
<td><p>Requiere dispositivo real.</p></td>
</tr>
<tr>
<td><p>T-10</p></td>
<td><p>Actuador</p></td>
<td><p>Comando y estado con t&#243;pico correcto.</p></td>
<td><p>Requiere hardware/fixture.</p></td>
</tr>
<tr>
<td><p>T-11</p></td>
<td><p>Backup/restore</p></td>
<td><p>Restauraci&#243;n conserva integridad y trazabilidad.</p></td>
<td><p>No verificado en corte.</p></td>
</tr>
<tr>
<td><p>T-12</p></td>
<td><p>Accesibilidad/m&#243;vil/E2E</p></td>
<td><p>Flujos principales funcionan en dispositivos y lectores.</p></td>
<td><p>Pendiente formal.</p></td>
</tr>
</table>


# 4. Calidad y límites del reporte

El frontend no se declara cubierto por una suite automatizada equivalente a la del backend; lint/typecheck/build no sustituyen pruebas funcionales.

Los documentos 2026-09-23 y 2026-09-26 tienen cifras distintas; se conserva su fecha para evitar mezclar cortes.

No se fija rendimiento, disponibilidad o seguridad de producción sin mediciones reproducibles.

El polling HTTP de 5 segundos debe probarse bajo reconexión y pérdida temporal de broker/BD.

Las pruebas físicas de calibración con volumen conocido, carga y autonomía quedan abiertas.

# 5. Formato mínimo de evidencia futura

<table>
<tr>
<td><p><strong>Campo</strong></p></td>
<td><p><strong>Contenido</strong></p></td>
</tr>
<tr>
<td><p>Identificaci&#243;n</p></td>
<td><p>ID, fecha, operador, commit y ambiente.</p></td>
</tr>
<tr>
<td><p>Preparaci&#243;n</p></td>
<td><p>Datos, dispositivos, variables no secretas y servicios.</p></td>
</tr>
<tr>
<td><p>Ejecuci&#243;n</p></td>
<td><p>Comando/acci&#243;n, entrada y salida.</p></td>
</tr>
<tr>
<td><p>Resultado</p></td>
<td><p>Pass/fail/skip, logs y captura si aplica.</p></td>
</tr>
<tr>
<td><p>Incidencia</p></td>
<td><p>Severidad, causa, responsable y acci&#243;n.</p></td>
</tr>
</table>


<strong>Nota de control documental. </strong>Fuentes: docs/estado-verificado-2026-09-26.md, docs/estado-integral.md, docs/auditoria-estado-2026-09-23.md y scripts/tests del repositorio. Las pruebas no fueron ejecutadas de nuevo durante la elaboración documental.

<!-- footer: HidroSmart | DOC-07 | Versión documental consolidada 1.0 | Página PAGE -->

## Actualización técnica - 2026-11-05

El código de referencia es PT_HS `main` (`32be1cf787f20120dfd3b4cc72226dab55d88216`). HU-21 separa la carga del perfil de la consulta de hogares y dispositivos; el cambio no modifica el contrato de correo ni las migraciones. El commit obtuvo cuatro ejecuciones de Actions y nueve check-runs exitosos, incluidos build/pruebas/E2E de frontend; el estado combinado de GitHub sigue `pending` sin contextos. Esto no certifica que Render tenga variables válidas ni que cada correo llegue al destinatario. Para cerrar la prueba, registrar por flujo el commit, ambiente, solicitud, `messageId`, estado en Brevo y resultado del enlace. Alertas, medición, desvinculación y el flujo de perfil en despliegue requieren evidencia reproducible; la existencia del código no es resultado de aceptación.

El [contrato MQTT del firmware](../04-software-design/architecture.md) documenta Flespi/TLS y Mosquitto para desarrollo. Esto no equivale a una prueba reciente de la ACL, del token remoto ni de una placa física. Conserva como evidencia histórica los resultados fechados de las secciones anteriores.

En la consulta remota del 2026-11-05 al SHA `32be1cf`, cuatro ejecuciones de Actions y nueve check-runs terminaron correctamente; el estado combinado figuró `pending` con cero contextos. Consulta el detalle y sus límites en [evidencia de CI](ci-evidence.md).

## Verificación local de cierre 2026-11-07

Se intentó ejecutar la validación reproducible sin modificar el código ni los archivos versionados:

| Repositorio | Comando | Resultado | Límite observado |
|---|---|---|---|
| BK_HS | `npm run check` | Correcto: 217 archivos de producción revisados. | Validación estática únicamente. |
| BK_HS | `npm test` | 190 pruebas pasaron y 6 no iniciaron. | Faltan dependencias instaladas (`jsonwebtoken`, `express`, `nodemailer` y `pg`) por el bloqueo de instalación de npm. |
| FT_HS | `npm run lint`, `npm run typecheck`, `npm run build` | No iniciaron. | Faltan `prettier`, `tsc` y `vite`. |
| FT_HS | `npm test` | 3 suites no iniciaron. | Falta `esbuild` en la instalación local. |

La instalación de dependencias se intentó con `npm ci` y quedó bloqueada por errores de permisos/terminación de npm. No se presenta este intento como una ejecución completa ni como aprobación funcional. Debe repetirse en un entorno con dependencias instaladas y asociarse al SHA exacto del tag `final-delivery-2026`.

## Smoke check público 2026-11-07

| Servicio | Resultado observado | Alcance |
|---|---|---|
| `https://pt-hs.pages.dev/login` | HTTP 200; documento HTML de HidroSmart | Confirma disponibilidad pública de la página, no autenticación ni flujo funcional. |
| `https://pt-hs.onrender.com/health` | HTTP 200; `status: ok`, `database: hidro_smart` | Confirma salud básica de la API y conexión reportada con la base; no cubre roles, correo, MQTT, frontend autenticado ni ESP32. |
