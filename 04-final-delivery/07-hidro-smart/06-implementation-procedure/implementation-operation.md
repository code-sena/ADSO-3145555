> **Estado y alcance.** Documento en revisión para la entrega. Las fechas, cifras y funciones heredadas del documento fuente solo se consideran vigentes cuando están respaldadas por evidencia del monorepo PT_HS. Consulta el [índice de entrega](../README.md) y el [índice de entrega](../README.md).

<strong>HIDROSMART</strong>

Procedimiento de implementación y operación de HidroSmart

Ejecución local reproducible y controles de puesta en marcha

Versión documental consolidada 1.0
Fecha de corte: 2026-10-09
Código documental: DOC-06


# 1. Precondiciones

Clonar o disponer del repositorio PT\_HS sin modificar la rama fuente.

Instalar Docker/Docker Compose; Node/npm y PlatformIO son necesarios para tareas fuera de contenedores.

Disponer de variables de entorno a partir de los ejemplos del repositorio; nunca copiar secretos reales a Git.

Para pruebas físicas: ESP32, sensor, alimentación, red Wi-Fi y development build móvil si se usa BLE.

# 2. Flujo de implementación local

<table>
<tr>
<td><p><strong>Paso</strong></p></td>
<td><p><strong>Acci&#243;n</strong></p></td>
<td><p><strong>Resultado esperado</strong></p></td>
</tr>
<tr>
<td><p>1</p></td>
<td><p>Revisar rama, README, .env.example y puertos.</p></td>
<td><p>Ambiente identificado sin secretos expuestos.</p></td>
</tr>
<tr>
<td><p>2</p></td>
<td><p>Preparar variables para BD, backend, frontend y MQTT.</p></td>
<td><p>Servicios pueden resolver nombres y credenciales locales.</p></td>
</tr>
<tr>
<td><p>3</p></td>
<td><p>Levantar PostgreSQL, broker, backend y frontend mediante docker compose.</p></td>
<td><p>Servicios en ejecuci&#243;n; verificar logs.</p></td>
</tr>
<tr>
<td><p>4</p></td>
<td><p>Ejecutar db-bootstrap/Liquibase conforme al compose.</p></td>
<td><p>Changelog actualizado y BD lista.</p></td>
</tr>
<tr>
<td><p>5</p></td>
<td><p>Comprobar API /api/v1 y frontend en puerto 5173.</p></td>
<td><p>HTTP y aplicaci&#243;n responden.</p></td>
</tr>
<tr>
<td><p>6</p></td>
<td><p>Publicar/recibir un mensaje MQTT de prueba controlado.</p></td>
<td><p>Ingesti&#243;n valida y registra o rechaza de forma trazable.</p></td>
</tr>
<tr>
<td><p>7</p></td>
<td><p>Construir/cargar firmware PlatformIO y aprovisionar BLE.</p></td>
<td><p>ESP32 conecta a Wi-Fi/MQTT y publica estado.</p></td>
</tr>
<tr>
<td><p>8</p></td>
<td><p>Ejecutar pruebas del DOC-07 y guardar evidencia fechada.</p></td>
<td><p>Criterios aceptados o incidencias abiertas.</p></td>
</tr>
</table>


# 3. Orden recomendado de verificación

Contenedores y puertos.

Liquibase status/validate y estado de migraciones.

Conectividad del backend con BD.

Conectividad del backend con broker.

Rutas de autenticación y usuario de prueba.

Ingreso MQTT con mensaje válido, inválido y duplicado.

Consulta de lectura desde frontend.

Firmware y prueba física, si aplica.

# 4. Firmware y aprovisionamiento

El firmware se gestiona con PlatformIO, entorno esp32dev, framework Arduino y monitor a 115200. El flujo BLE guarda SSID, contraseña, host, puerto y deviceCode en NVS; puede conservar hasta cinco perfiles. El hardwareId se deriva del eFuse y puede actuar como código por defecto. El móvil requiere development build para react-native-ble-plx.

# 5. Detención, actualización y rollback

Antes de actualizar migraciones o imágenes, registrar commit, fecha, variables y estado de la BD.

Tomar backup y comprobar restauración antes de cambios destructivos.

Aplicar migraciones de forma ordenada; no editar manualmente la base para “hacer coincidir” diagramas.

Si una verificación falla, detener la liberación, conservar logs y volver a la versión previamente validada según el procedimiento del entorno.

No existe en el material revisado una prueba completa de backup/restore; queda como requisito de cierre.

# 6. Producción: controles obligatorios

<table>
<tr>
<td><p><strong>Control</strong></p></td>
<td><p><strong>Estado en corte</strong></p></td>
<td><p><strong>Acci&#243;n antes de producci&#243;n</strong></p></td>
</tr>
<tr>
<td><p>MQTT TLS/ACL</p></td>
<td><p>El firmware tiene perfil externo Flespi/TLS; Mosquitto local sigue sin TLS para desarrollo. ACL y token del entorno deben verificarse.</p></td>
<td><p>Verificar ACL de m&#237;nimo privilegio, token individual por placa y token separado para backend; no exponer Mosquitto local.</p></td>
</tr>
<tr>
<td><p>Secretos</p></td>
<td><p>Variables previstas; valores reales no documentados.</p></td>
<td><p>Usar gestor seguro y rotaci&#243;n.</p></td>
</tr>
<tr>
<td><p>Backups</p></td>
<td><p>No verificado end-to-end.</p></td>
<td><p>Probar backup, restore y RPO/RTO.</p></td>
</tr>
<tr>
<td><p>Correo transaccional Brevo</p></td>
<td><p>Integraci&#243;n por API HTTPS documentada; estado de variables privadas y entrega real no se deduce del repositorio.</p></td>
<td><p>Probar cada flujo conectado y confirmar aceptaci&#243;n/entrega en Brevo; no asumir alertas por correo sin disparador.</p></td>
</tr>
<tr>
<td><p>Observabilidad</p></td>
<td><p>Logs disponibles; SLA no fijado.</p></td>
<td><p>Definir m&#233;tricas, alarmas y retenci&#243;n.</p></td>
</tr>
</table>


<strong>Nota de control documental. </strong>Este procedimiento describe una ruta operativa basada en docker-compose.yml, README y docs del repositorio. Los comandos exactos pueden variar con el entorno; el operador debe revisar los scripts vigentes antes de ejecutar acciones sobre datos.

<!-- footer: HidroSmart | DOC-06 | Versión documental consolidada 1.0 | Página PAGE -->
