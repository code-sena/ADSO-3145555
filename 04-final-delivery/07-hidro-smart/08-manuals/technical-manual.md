> **Estado y alcance.** Documento en revisión para la entrega. Las fechas, cifras y funciones heredadas del documento fuente solo se consideran vigentes cuando están respaldadas por evidencia del monorepo PT_HS. Consulta el [índice de entrega](../README.md) y el [índice de entrega](../README.md).

<strong>HIDROSMART</strong>

Manual técnico de HidroSmart

Referencia para desarrollo, integración y soporte técnico

Versión documental consolidada 1.0  
Fecha de corte: 2026-10-09  
Código documental: DOC-08


# Ampliación de alcance técnico

Esta ampliación desarrolla el manual a partir del repositorio PT\_HS y de sus documentos técnicos. Las instrucciones distinguen el ambiente local comprobado de las condiciones de producción aún pendientes. Las rutas, nombres de servicios, topics y variables se escriben tal como aparecen en las fuentes revisadas.

# 1. Mapa del repositorio

<table>
<tr>
<td><p><strong>Ruta</strong></p></td>
<td><p><strong>Contenido t&#233;cnico</strong></p></td>
</tr>
<tr>
<td><p>BD_HS</p></td>
<td><p>PostgreSQL/Liquibase, changelogs, roles, scripts y documentaci&#243;n de datos.</p></td>
</tr>
<tr>
<td><p>BK_HS</p></td>
<td><p>Backend Node/Express, API, dominio, infraestructura, MQTT, jobs y pruebas.</p></td>
</tr>
<tr>
<td><p>FT_HS/Web y FT_HS/frontend</p></td>
<td><p>React/Vite/TypeScript, features, UI, m&#243;vil WebView y puente BLE.</p></td>
</tr>
<tr>
<td><p>firmware</p></td>
<td><p>PlatformIO/ESP32: provisioning, Wi-Fi, MQTT, sensores, actuadores, OTA y tests.</p></td>
</tr>
<tr>
<td><p>docs</p></td>
<td><p>Estado, integraci&#243;n, IoT, ejecuci&#243;n local y validaci&#243;n.</p></td>
</tr>
<tr>
<td><p>scripts</p></td>
<td><p>Validaci&#243;n integral y automatizaci&#243;n del proyecto.</p></td>
</tr>
</table>


# 2. Contrato MQTT

<table>
<tr>
<td><p><strong>Direcci&#243;n/t&#243;pico</strong></p></td>
<td><p><strong>QoS/retain</strong></p></td>
<td><p><strong>Contenido</strong></p></td>
</tr>
<tr>
<td><p>ESP32 → backend /telemetry</p></td>
<td><p>QoS 1 / no retain</p></td>
<td><p>flowRateLpm, consumptionLiters; opcional totalLiters, pulses, mqttMessageId, timestamp, RSSI.</p></td>
</tr>
<tr>
<td><p>ESP32 → backend /status</p></td>
<td><p>QoS 1 / retain</p></td>
<td><p>ONLINE/OFFLINE/ERROR, hardwareId, provisioningState, firmwareVersion, red y timestamp.</p></td>
</tr>
<tr>
<td><p>Backend → ESP32 /commands</p></td>
<td><p>QoS 1 seg&#250;n uso</p></td>
<td><p>Comandos admitidos por el contrato, incluido el modo de medici&#243;n.</p></td>
</tr>
<tr>
<td><p>Backend → actuador /command</p></td>
<td><p>QoS 1 / no retain</p></td>
<td><p>Topic previsto por el backend; no forma parte del contrato vigente del firmware ni prueba una v&#225;lvula o bomba f&#237;sica instalada.</p></td>
</tr>
<tr>
<td><p>ESP32 → actuador /status</p></td>
<td><p>QoS 1 / retain</p></td>
<td><p>Estado del actuador.</p></td>
</tr>
</table>


# 3. Flujo de ingestión

MqttSubscriber mantiene suscripción.

Parser convierte payload a estructura interna.

Handler y caso IngestReading aplican validación y reglas.

Repositorio persiste en PostgreSQL con idempotencia.

La consulta REST entrega lecturas/agregados al frontend.

Los errores deben ser observables y no deben producir lecturas parciales.

# 4. API y seguridad

La API usa el prefijo /api/v1 y agrupa autenticación, hogares, dispositivos, consumo, usuarios, tarifas, alertas, metas, vacaciones, roles, soporte, auditoría, privacidad, reportes y recomendaciones. En la web, la sesión usa cookies HttpOnly y las solicitudes mutables incluyen X-CSRF-Token; el backend conserva Bearer/JWT para clientes autorizados cuando está habilitado. La renovación se limita al flujo descrito en la documentación del backend. Los nombres exactos de endpoints y payloads deben consultarse en el código antes de integrar un cliente nuevo.

# 5. Firmware

Entorno PlatformIO esp32dev, Arduino framework, monitor 115200.

Sensor observado: YF-S201 en GPIO 27 en el corte documentado.

BLE guarda SSID, contraseña, host, puerto y deviceCode en NVS.

HardwareId estable se deriva de eFuse; el código puede usarlo por defecto.

BLE local no tiene pairing/PIN de producción; debe endurecerse antes de despliegue real.

No introducir credenciales Wi-Fi/MQTT en el repositorio.

# 6. Diagnóstico técnico

<table>
<tr>
<td><p><strong>S&#237;ntoma</strong></p></td>
<td><p><strong>Puntos de revisi&#243;n</strong></p></td>
</tr>
<tr>
<td><p>Frontend no carga</p></td>
<td><p>Puerto 5173, VITE_API_URL, logs del contenedor y respuesta API.</p></td>
</tr>
<tr>
<td><p>Login falla</p></td>
<td><p>Estado de verificaci&#243;n, cookies de sesi&#243;n, token CSRF, renovaci&#243;n, configuraci&#243;n y logs del backend.</p></td>
</tr>
<tr>
<td><p>No llegan lecturas</p></td>
<td><p>MQTT_BROKER_URL y puerto activo (Mosquitto local o Flespi TLS 8883), topic y deviceCode, payload, suscriptor, permisos BD y deduplicaci&#243;n.</p></td>
</tr>
<tr>
<td><p>ESP32 offline</p></td>
<td><p>Wi-Fi, NVS, host/puerto, estado MQTT, RSSI y fuente de alimentaci&#243;n.</p></td>
</tr>
<tr>
<td><p>Datos duplicados</p></td>
<td><p>mqttMessageId, timestamp, reintentos y restricciones de BD.</p></td>
</tr>
<tr>
<td><p>Correo no llega</p></td>
<td><p>Revisar BREVO_API_KEY, BREVO_FROM_EMAIL y BREVO_FROM_NAME en el entorno; confirmar el evento y su estado en Brevo. No registrar secretos.</p></td>
</tr>
</table>


# 7. Mantenimiento

Toda modificación debe acompañarse de cambios versionados, pruebas, actualización de documentación y fecha de corte. Las migraciones de BD no se reescriben después de aplicadas; se agregan cambios nuevos y rollback correspondiente.

<strong>Nota de control documental. </strong>Basado en README raíz, BK\_HS/docs, firmware/README.md, platformio.ini, contrato MQTT y estructura real del repositorio. No se incluyen secretos, direcciones productivas ni instrucciones destructivas.


# 8. Mapa técnico del repositorio

El sistema no es un único ejecutable: se compone de módulos coordinados. El repositorio mantiene separadas la persistencia, la API, la presentación y el dispositivo físico. El siguiente mapa ayuda a ubicar una incidencia antes de modificar cualquier componente.

<table>
<tr>
<td><p><strong>Ruta</strong></p></td>
<td><p><strong>Responsabilidad</strong></p></td>
<td><p><strong>Puntos de revisi&#243;n</strong></p></td>
</tr>
<tr>
<td><p>BD_HS</p></td>
<td><p>PostgreSQL, Liquibase, tablas, funciones, vistas, RLS, roles y grants.</p></td>
<td><p>changelog-master.yaml, 01_ddl–05_rollbacks, docs y diagn&#243;sticos.</p></td>
</tr>
<tr>
<td><p>BK_HS</p></td>
<td><p>API Node.js/Express, autenticaci&#243;n, casos de uso, repositorios, MQTT, jobs y pruebas.</p></td>
<td><p>src/app.js, core/application, core/domain, core/infrastructure, src/mqtt y tests.</p></td>
</tr>
<tr>
<td><p>FT_HS/Web y FT_HS/frontend</p></td>
<td><p>Web React/Vite y cliente Expo/React Native con WebView y puente BLE nativo.</p></td>
<td><p>Web/src; frontend/src/mobile, frontend/src/shared y scripts m&#243;viles. Expo Go no incluye BLE nativo.</p></td>
</tr>
<tr>
<td><p>firmware</p></td>
<td><p>ESP32 con PlatformIO, provisioning BLE, Wi-Fi, MQTT, sensores, actuadores, OTA y almacenamiento.</p></td>
<td><p>platformio.ini, src/main.cpp, provisioning, wifi, mqtt, sensors, actuators y tests.</p></td>
</tr>
<tr>
<td><p>docs</p></td>
<td><p>Estado, integraci&#243;n, IoT, ejecuci&#243;n local y validaci&#243;n transversal.</p></td>
<td><p>README, contrato MQTT, gu&#237;as de integraci&#243;n y cortes de estado fechados.</p></td>
</tr>
</table>


# 9. Topología de ejecución local

El Compose raíz levanta PostgreSQL, el bootstrap de roles, Mosquitto, backend, frontend y el perfil opcional de Liquibase. Desde Windows se usan los puertos publicados; entre contenedores se usan los nombres de servicio y los puertos internos.

<table>
<tr>
<td><p><strong>Servicio</strong></p></td>
<td><p><strong>Host / puerto</strong></p></td>
<td><p><strong>Red interna / funci&#243;n</strong></p></td>
</tr>
<tr>
<td><p>Frontend</p></td>
<td><p>http://localhost:5173</p></td>
<td><p>Nginx sirve la aplicaci&#243;n; reenv&#237;a /api/ al backend.</p></td>
</tr>
<tr>
<td><p>Backend</p></td>
<td><p>http://localhost:3000</p></td>
<td><p>API REST, health, reglas de negocio y subscriber MQTT.</p></td>
</tr>
<tr>
<td><p>Health backend</p></td>
<td><p>http://localhost:3000/health</p></td>
<td><p>Comprobaci&#243;n directa de salud.</p></td>
</tr>
<tr>
<td><p>Health frontend</p></td>
<td><p>http://localhost:5173/health</p></td>
<td><p>Comprobaci&#243;n a trav&#233;s de Nginx.</p></td>
</tr>
<tr>
<td><p>PostgreSQL</p></td>
<td><p>localhost:5433</p></td>
<td><p>Desde Windows; dentro de Docker: postgres:5432.</p></td>
</tr>
<tr>
<td><p>Mosquitto</p></td>
<td><p>localhost:1883</p></td>
<td><p>Desde Windows; dentro de Docker: mosquitto:1883.</p></td>
</tr>
<tr>
<td><p>Liquibase</p></td>
<td><p>Perfil tooling</p></td>
<td><p>Ejecuta validate, status y update contra PostgreSQL.</p></td>
</tr>
</table>


<strong>Control de evidencia. </strong>Los puertos se toman de docker-compose.yml y README.md. El broker local es anónimo y sin TLS solo para desarrollo; no deben extrapolarse estas condiciones a producción.

# 10. Backend, API y autenticación

La API se monta bajo /api/v1. El health público se consulta en /health y el backend también expone /health/live y /health/ready para liveness y readiness. La telemetría MQTT no entra por una ruta REST: llega por el broker y pasa por el subscriber.

<table>
<tr>
<td><p><strong>Prefijo</strong></p></td>
<td><p><strong>Responsabilidad documentada</strong></p></td>
</tr>
<tr>
<td><p>/auth</p></td>
<td><p>Registro, verificaci&#243;n, login, refresh, logout, cambio y recuperaci&#243;n de contrase&#241;a.</p></td>
</tr>
<tr>
<td><p>/homes</p></td>
<td><p>Hogares, miembros y solicitudes.</p></td>
</tr>
<tr>
<td><p>/devices</p></td>
<td><p>Registro, vinculaci&#243;n, configuraci&#243;n, estado y dispositivos.</p></td>
</tr>
<tr>
<td><p>/consumption</p></td>
<td><p>Resumen, lecturas agregadas, costos y series por d&#237;a, hora, mes o ubicaci&#243;n.</p></td>
</tr>
<tr>
<td><p>/users</p></td>
<td><p>Perfil y preferencias.</p></td>
</tr>
<tr>
<td><p>/tariffs</p></td>
<td><p>Tarifa vigente por hogar.</p></td>
</tr>
<tr>
<td><p>/alerts</p></td>
<td><p>Alertas, reglas, umbrales e historial.</p></td>
</tr>
<tr>
<td><p>/goals y /vacation</p></td>
<td><p>Metas, progreso y configuraci&#243;n del modo vacaciones.</p></td>
</tr>
<tr>
<td><p>/roles, /support y /audit</p></td>
<td><p>Roles, tickets/respuestas y auditor&#237;a.</p></td>
</tr>
<tr>
<td><p>/privacy</p></td>
<td><p>Consentimientos, exportaci&#243;n propia y solicitudes ARCO.</p></td>
</tr>
<tr>
<td><p>/reports</p></td>
<td><p>Exportaci&#243;n de consumo en PDF/Excel e historial de descargas.</p></td>
</tr>
<tr>
<td><p>/recommendations</p></td>
<td><p>Recomendaciones propias y resumen por hogar.</p></td>
</tr>
</table>


## 10.1 Flujo de autenticación

Una cuenta nueva queda en estado Pending hasta consumir el token de correo.

El login establece cookies HttpOnly de access y refresh; sus duraciones dependen de la configuración validada del entorno.

El navegador envía las cookies de sesión; las peticiones mutables incluyen X-CSRF-Token. Bearer se mantiene como compatibilidad cuando se habilita. El cliente HTTP intenta una renovación ante 401 una sola vez.

Logout, revocación, cambio de contraseña y cierre de sesiones invalidan el acceso conforme al flujo del backend.

No se deben registrar tokens, contraseñas, BREVO\_API\_KEY, claves JWT ni credenciales Wi-Fi/MQTT en tickets o documentos.

# 11. Base de datos y migraciones

La fuente de verdad de la estructura es BD\_HS/changelog. El corte verificado registra PostgreSQL 16, Liquibase 5.0.2, 245 changesets, 58 tablas de aplicación y 5 vistas materializadas.

<table>
<tr>
<td><p><strong>Esquema</strong></p></td>
<td><p><strong>Responsabilidad t&#233;cnica</strong></p></td>
</tr>
<tr>
<td><p>user_account</p></td>
<td><p>Usuarios, perfiles, sesiones, credenciales y roles.</p></td>
</tr>
<tr>
<td><p>preference</p></td>
<td><p>Idioma, moneda, tema y preferencias.</p></td>
</tr>
<tr>
<td><p>home</p></td>
<td><p>Hogares, miembros, solicitudes, vacaciones y metas.</p></td>
</tr>
<tr>
<td><p>device</p></td>
<td><p>Dispositivos, asociaciones, estados, telemetr&#237;a y actuadores.</p></td>
</tr>
<tr>
<td><p>consumption</p></td>
<td><p>Lecturas y agregados diarios, horarios, mensuales y por ubicaci&#243;n.</p></td>
</tr>
<tr>
<td><p>alert_rate</p></td>
<td><p>Reglas, umbrales, eventos, notificaciones y tarifas.</p></td>
</tr>
<tr>
<td><p>analytics_support</p></td>
<td><p>Reportes, recomendaciones y tickets.</p></td>
</tr>
<tr>
<td><p>audit</p></td>
<td><p>Auditor&#237;a y errores.</p></td>
</tr>
<tr>
<td><p>privacy</p></td>
<td><p>Consentimientos y solicitudes ARCO.</p></td>
</tr>
</table>


Los roles técnicos documentados son hidro\_smart\_admin, hidro\_smart\_liquibase, hidro\_smart\_app, hidro\_smart\_ingest e hidro\_smart\_readonly. La aplicación usa hidro\_smart\_app; la ingestión IoT está separada en hidro\_smart\_ingest. RLS/RBAC y funciones SQL protegidas actúan como barrera de datos.

# 12. Contrato MQTT completo

<table>
<tr>
<td><p><strong>Topic</strong></p></td>
<td><p><strong>Direcci&#243;n</strong></p></td>
<td><p><strong>QoS / retain</strong></p></td>
<td><p><strong>Contenido o uso</strong></p></td>
</tr>
<tr>
<td><p>hidrosmart/devices/{deviceCode}/telemetry</p></td>
<td><p>ESP32 → backend</p></td>
<td><p>QoS 1 / no retain</p></td>
<td><p>Lecturas de flujo/consumo y m&#233;tricas opcionales.</p></td>
</tr>
<tr>
<td><p>hidrosmart/devices/{deviceCode}/status</p></td>
<td><p>ESP32 → backend</p></td>
<td><p>QoS 1 / retain</p></td>
<td><p>ONLINE, OFFLINE o ERROR; hardwareId, provisioningState, firmwareVersion, red y timestamp.</p></td>
</tr>
<tr>
<td><p>hidrosmart/devices/{deviceCode}/commands</p></td>
<td><p>backend → ESP32</p></td>
<td><p>QoS 1 seg&#250;n uso</p></td>
<td><p>Comandos del dispositivo; el contrato del ESP32 incluye confirm_link, unlink, enable_ble, disable_ble y set_measurement.</p></td>
</tr>
<tr>
<td><p>.../actuators/{valve|pump}/command</p></td>
<td><p>backend → ESP32</p></td>
<td><p>QoS 1 / no retain</p></td>
<td><p>Topic previsto por el backend; no forma parte del contrato vigente del firmware ni prueba una v&#225;lvula o bomba f&#237;sica instalada.</p></td>
</tr>
<tr>
<td><p>.../actuators/{valve|pump}/status</p></td>
<td><p>ESP32 → backend</p></td>
<td><p>QoS 1 / retain</p></td>
<td><p>Topic previsto por el backend; la respuesta de hardware requiere una prueba f&#237;sica independiente.</p></td>
</tr>
</table>


El payload mínimo de telemetría incluye flowRateLpm y consumptionLiters. Puede incluir totalLiters, pulses, mqttMessageId, deviceId, hardwareId, sampleIntervalSeconds, timestamp, signalQuality, wifiRssiDbm, batería, voltaje y temperatura. Los timestamps ISO-8601 se normalizan a UTC; si faltan, el backend usa la recepción como fallback según la documentación del parser.

## 12.1 Cadena de ingestión

MqttSubscriber mantiene las suscripciones de telemetry, status y estados de actuadores.

El parser valida y normaliza nombres, tipos, timestamp y métricas.

El handler delega en IngestReading y PostgresTelemetryRepository.

Se resuelve deviceCode contra device.device.code y se verifica asociación activa con el hogar.

La lectura se inserta en consumption.sensor\_reading mediante función SQL protegida.

mqttMessageId permite idempotencia; los mensajes duplicados no deben generar lecturas adicionales.

El dato documentado usa consumption\_liters NUMERIC(14,3) y volumen en m³ NUMERIC(14,6).

# 13. Firmware y BLE

El firmware usa PlatformIO, entorno esp32dev para pruebas locales y esp32dev-flespi para MQTT/TLS, framework Arduino y monitor a 115200. Las dependencias declaradas son PubSubClient, ArduinoJson y NimBLE-Arduino. El sensor YF-S201 se observa conectado al GPIO 27 en el corte técnico; la adaptación eléctrica y la calibración con volumen conocido siguen siendo responsabilidades de la validación física.

<table>
<tr>
<td><p><strong>Elemento BLE</strong></p></td>
<td><p><strong>UUID / dato</strong></p></td>
</tr>
<tr>
<td><p>Servicio</p></td>
<td><p>4fafc201-1fb5-459e-8fcc-c5c9c331914b</p></td>
</tr>
<tr>
<td><p>Caracter&#237;stica Configuraci&#243;n</p></td>
<td><p>beb5483e-36e1-4688-b7f5-ea07361b26a8</p></td>
</tr>
<tr>
<td><p>Caracter&#237;stica Estado</p></td>
<td><p>beb5483e-36e1-4688-b7f5-ea07361b26a9</p></td>
</tr>
<tr>
<td><p>Persistencia</p></td>
<td><p>SSID, contrase&#241;a, host, puerto y deviceCode en NVS; hasta cinco perfiles de red.</p></td>
</tr>
<tr>
<td><p>Identidad</p></td>
<td><p>hardwareId estable derivado del eFuse; el firmware selecciona un solo deviceCode l&#243;gico activo por placa entre los c&#243;digos configurados.</p></td>
</tr>
</table>


El JSON de configuración incluye ssid, password, mqttHost, mqttPort y un deviceCode lógico preasignado; no se deben usar códigos inventados ni registrar contraseñas en documentación. La placa tiene un único código lógico activo por vez. El puente móvil usa react-native-ble-plx y requiere development build; Expo Go no incluye BLE nativo.

# 14. Diagnóstico técnico por síntoma

<table>
<tr>
<td><p><strong>S&#237;ntoma</strong></p></td>
<td><p><strong>Comprobaciones en orden</strong></p></td>
<td><p><strong>L&#237;mite conocido</strong></p></td>
</tr>
<tr>
<td><p>Frontend no responde</p></td>
<td><p>Puerto 5173, frontend container, /health, backend healthy y VITE_API_URL.</p></td>
<td><p>No asumir que una pantalla carga datos si API/BD no est&#225;n saludables.</p></td>
</tr>
<tr>
<td><p>API no responde</p></td>
<td><p>docker compose ps, /health, logs backend, variables DB/JWT.</p></td>
<td><p>No exponer credenciales al adjuntar logs.</p></td>
</tr>
<tr>
<td><p>BD no aplica cambios</p></td>
<td><p>postgres healthy, db-bootstrap completo, validate/status/update.</p></td>
<td><p>No editar tablas manualmente para corregir una migraci&#243;n.</p></td>
</tr>
<tr>
<td><p>No llegan lecturas</p></td>
<td><p>Broker 1883, topic/deviceCode, payload, subscriber, permisos y funci&#243;n SQL.</p></td>
<td><p>MQTT no usa una ruta REST.</p></td>
</tr>
<tr>
<td><p>ESP32 offline</p></td>
<td><p>Energ&#237;a, Wi-Fi, NVS, host/puerto, estado MQTT, RSSI y BLE.</p></td>
<td><p>La prueba local no demuestra seguridad productiva.</p></td>
</tr>
<tr>
<td><p>Lecturas duplicadas</p></td>
<td><p>mqttMessageId, reintentos, timestamp y constraints/funci&#243;n SQL.</p></td>
<td><p>Repetir con mensaje controlado antes de corregir c&#243;digo.</p></td>
</tr>
<tr>
<td><p>Actuador sin ACK</p></td>
<td><p>Topic command/status, correlationId, estado persistido y dispositivo soportado.</p></td>
<td><p>Hardware real requerido para cerrar prueba.</p></td>
</tr>
</table>


# 15. Evidencia y límites técnicos

El corte 2026-09-26 registra Docker, BD, backend unitario, frontend, firmware compilado y MQTT local como verificados.

Se documentan dos dispositivos y 3.245 lecturas persistidas al cierre de ese corte.

La prueba física registra seis mensajes en reposo y cinco con agua circulando para HS-141F47470968.

Al corte histórico 2026-09-26 quedaban pendientes calibración con volumen conocido, MQTT productivo, backup/restore, correo real, accesibilidad, E2E y push WebSocket. El estado posterior se registra en la actualización fechada a continuación.

<strong>Control de evidencia. </strong>Fuentes: PT\_HS/README.md, docker-compose.yml, docs/estado-verificado-2026-09-26.md, BK\_HS/docs/00-estado-actual.md, BK\_HS/docs/14-mqtt-protocol.md, BD\_HS/docs/README.md, firmware/README.md, platformio.ini y package.json. La fecha de corte es parte del contenido técnico.

<!-- footer: HidroSmart | DOC-08 | Versión documental consolidada 1.0 | Página PAGE -->

## Actualización técnica - 2026-11-05

La fuente de esta actualización es PT_HS/main (`32be1cf`), no una lectura de las variables privadas ni del panel de los proveedores.

- Autenticación web: cookies HttpOnly y CSRF; Bearer es compatibilidad opcional.
- Correo: Brevo por API HTTPS, con BREVO_API_KEY, BREVO_FROM_EMAIL y BREVO_FROM_NAME. La respuesta HTTP aceptada no confirma entrega.
- MQTT ESP32: topics del contrato de firmware: hidrosmart/devices/{deviceCode}/telemetry, /status y /commands. Flespi/TLS usa puerto 8883; Mosquitto local queda para desarrollo. Verifica ACL y tokens en el ambiente.
- Identidad: deviceCode es lógico; hardwareId identifica la placa. El firmware elige un único código lógico activo a la vez.
- Vigilancia de fuga: measurementEnabled=false conserva telemetría de flujo/pulsos y conexión MQTT, pero deja de sumar litros. No es un apagado eléctrico.
- HU-21: la pantalla de Configuración consulta el perfil independientemente de hogares y dispositivos, para que un error en esas consultas no impida cargar los datos del perfil.
- Límites: el flujo físico reciente, la entrega de todos los correos, la ACL remota y la calibración requieren evidencia del ambiente/dispositivo; no se infieren de que exista código.

Consulta el [contrato MQTT del firmware](../04-software-design/architecture.md), la [guía de correos](../04-software-design/architecture.md) y el [índice de entrega](../README.md).
