> **Nota de conversión y vigencia.** Este archivo conserva el contenido de su documento fuente convertido a Markdown. Las afirmaciones de diseño, alcance, roles, tecnologías y fechas pertenecen a esa fuente y no prueban el estado implementado. Para el corte técnico 2026-11-05 consulta el [índice de entrega](../README.md) y el [diseño del software](../04-software-design/software-design.md).

<strong> HIDROSMART</strong>

Manual de instalación de HidroSmart

Preparación del ambiente local y puesta en marcha

Versión documental consolidada 1.0  
Fecha de corte: 2026-10-09  
Código documental: DOC-09


# Ampliación del procedimiento de instalación

Esta versión desarrolla la instalación local que está descrita en PT\_HS. Los pasos destructivos se separan de la instalación normal y se advierte cuándo una verificación no está cerrada. No se incluyen valores reales de contraseñas, tokens, SMTP ni Wi-Fi.

# 1. Alcance

Este manual cubre la instalación local de los componentes versionados en PT\_HS. No describe una liberación productiva ni contiene secretos. La instalación debe realizarse en una copia de trabajo y con las variables del entorno protegidas.

# 2. Requisitos

<table>
<tr>
<td><p><strong>Recurso</strong></p></td>
<td><p><strong>Uso</strong></p></td>
</tr>
<tr>
<td><p>Docker y Docker Compose</p></td>
<td><p>Servicios de PostgreSQL, Mosquitto, backend, frontend y bootstrap.</p></td>
</tr>
<tr>
<td><p>Node/npm</p></td>
<td><p>Desarrollo o ejecuci&#243;n fuera de contenedor del backend/frontend.</p></td>
</tr>
<tr>
<td><p>PlatformIO</p></td>
<td><p>Compilaci&#243;n y carga del firmware ESP32.</p></td>
</tr>
<tr>
<td><p>ESP32 y sensor</p></td>
<td><p>Prueba f&#237;sica opcional; requiere alimentaci&#243;n y red.</p></td>
</tr>
<tr>
<td><p>Development build m&#243;vil</p></td>
<td><p>Aprovisionamiento BLE; Expo Go no es suficiente para BLE nativo.</p></td>
</tr>
</table>


# 3. Configuración segura

# 4. Instalación de servicios

# 5. Instalación del firmware

# 6. Verificación posterior

<table>
<tr>
<td><p><strong>Verificaci&#243;n</strong></p></td>
<td><p><strong>Aprobaci&#243;n</strong></p></td>
</tr>
<tr>
<td><p>Contenedores</p></td>
<td><p>Postgres, broker, backend y frontend responden.</p></td>
</tr>
<tr>
<td><p>BD</p></td>
<td><p>Liquibase v&#225;lido y tablas disponibles.</p></td>
</tr>
<tr>
<td><p>API</p></td>
<td><p>Autenticaci&#243;n y ruta protegida responden con datos de prueba.</p></td>
</tr>
<tr>
<td><p>MQTT</p></td>
<td><p>Mensaje de prueba aparece en logs y/o lectura persistida.</p></td>
</tr>
<tr>
<td><p>Frontend</p></td>
<td><p>Login, dashboard y consulta de dispositivo funcionan.</p></td>
</tr>
<tr>
<td><p>Firmware</p></td>
<td><p>ESP32 publica estado y telemetr&#237;a; RSSI visible.</p></td>
</tr>
</table>


# 7. Desinstalación y recuperación

Antes de eliminar volúmenes o reiniciar datos, obtener backup y confirmar el objetivo. No ejecutar acciones destructivas sobre una base compartida. El material revisado no aporta una receta validada de restauración completa; DOC-11 mantiene esta actividad como pendiente prioritaria.

<strong>Nota de control documental. </strong>Puertos y servicios derivados de docker-compose.yml y documentación de ejecución local. Los nombres de variables se deben tomar de los archivos .env.example del commit que se instale.


# 8. Preparación del ambiente

La instalación documentada se realiza desde la raíz de PT\_HS en Windows PowerShell con Docker Desktop iniciado. El equipo debe tener acceso a los archivos del repositorio y permiso para publicar los puertos locales. Para firmware se necesita además PlatformIO y una placa ESP32; para BLE móvil se necesita un development build.

<table>
<tr>
<td><p><strong>Requisito</strong></p></td>
<td><p><strong>Comprobaci&#243;n / uso</strong></p></td>
<td><p><strong>No hacer</strong></p></td>
</tr>
<tr>
<td><p>Docker Desktop</p></td>
<td><p>Debe estar iniciado; se verifica con docker version.</p></td>
<td><p>No levantar contenedores con variables secretas incompletas.</p></td>
</tr>
<tr>
<td><p>Compose</p></td>
<td><p>docker compose --env-file .env config --quiet.</p></td>
<td><p>No ignorar errores de interpolaci&#243;n.</p></td>
</tr>
<tr>
<td><p>Archivo .env</p></td>
<td><p>Se crea desde .env.example y conserva credenciales locales.</p></td>
<td><p>No subir .env ni copiar secretos en tickets.</p></td>
</tr>
<tr>
<td><p>ESP32/hardware</p></td>
<td><p>Necesario solo para instalaci&#243;n y prueba f&#237;sica IoT.</p></td>
<td><p>No conectar se&#241;ales sin revisar compatibilidad el&#233;ctrica.</p></td>
</tr>
<tr>
<td><p>Development build m&#243;vil</p></td>
<td><p>Necesario para react-native-ble-plx.</p></td>
<td><p>No usar Expo Go como sustituto de BLE nativo.</p></td>
</tr>
</table>


# 6. Variables de entorno sin valores

Los nombres siguientes aparecen en docker-compose.yml o en la documentación del repositorio. Deben tomar sus valores del .env.example y del ambiente autorizado; este manual no fija contraseñas ni direcciones productivas.

<table>
<tr>
<td><p><strong>Grupo</strong></p></td>
<td><p><strong>Variables documentadas</strong></p></td>
<td><p><strong>Uso</strong></p></td>
</tr>
<tr>
<td><p>PostgreSQL</p></td>
<td><p>POSTGRES_DB, POSTGRES_USER, POSTGRES_PASSWORD, POSTGRES_PORT</p></td>
<td><p>Base, rol administrador y puerto publicado.</p></td>
</tr>
<tr>
<td><p>Aplicaci&#243;n BD</p></td>
<td><p>DB_USER, DB_PASSWORD, DB_INGEST_USER, DB_INGEST_PASSWORD</p></td>
<td><p>Roles hidro_smart_app e hidro_smart_ingest.</p></td>
</tr>
<tr>
<td><p>JWT</p></td>
<td><p>JWT_SECRET, JWT_EXPIRES_IN, JWT_REFRESH_EXPIRES_IN, JWT_ISSUER, JWT_AUDIENCE</p></td>
<td><p>Sesiones y validaci&#243;n de tokens.</p></td>
</tr>
<tr>
<td><p>Backend</p></td>
<td><p>BACKEND_PORT, FRONTEND_URL, CORS_ORIGIN, APP_TIMEZONE</p></td>
<td><p>API, origen permitido y zona horaria.</p></td>
</tr>
<tr>
<td><p>MQTT</p></td>
<td><p>MQTT_BROKER_URL, MQTT_PORT, MQTT_DEVICE_HOST, MQTT_DEVICE_PORT, MQTT_USERNAME, MQTT_PASSWORD</p></td>
<td><p>Broker del backend y host accesible por ESP32.</p></td>
</tr>
<tr>
<td><p>Correo</p></td>
<td><p>BREVO_API_KEY, BREVO_FROM_EMAIL, BREVO_FROM_NAME</p></td>
<td><p>Correo transaccional por API HTTPS; configura una API key v3 y un remitente verificado en el gestor del entorno. No pegues secretos en el repositorio.</p></td>
</tr>
<tr>
<td><p>Frontend</p></td>
<td><p>VITE_API_URL, VITE_MQTT_DEVICE_HOST, VITE_MQTT_DEVICE_PORT</p></td>
<td><p>API y broker que el m&#243;vil/ESP32 puede alcanzar.</p></td>
</tr>
</table>


# 10. Instalación desde cero con Docker

Ejecute desde PT\_HS y deténgase si un comando devuelve error. El orden respeta dependencias de salud, bootstrap de roles y migraciones.

## 10.1 Arranque normal y actualización

Cuando la base ya está aplicada, el arranque normal documentado es docker compose --env-file .env up -d. Si se incorporan changesets nuevos, se ejecutan nuevamente validate, status --verbose y update antes de reiniciar o probar el backend.

## 10.2 Reinicio limpio: solo desarrollo

docker compose --env-file .env down --volumes --remove-orphans elimina el volumen local de PostgreSQL y datos de desarrollo. No es una actualización normal. Debe ejecutarse solo después de confirmar que el objetivo es reconstruir desde cero y que no contiene datos que deban conservarse.

# 11. Validación posterior a la instalación

<table>
<tr>
<td><p><strong>Nivel</strong></p></td>
<td><p><strong>Prueba</strong></p></td>
<td><p><strong>Resultado que se busca</strong></p></td>
</tr>
<tr>
<td><p>Servicios</p></td>
<td><p>docker compose ps y logs del servicio con error.</p></td>
<td><p>Postgres, db-bootstrap, Mosquitto, backend y frontend saludables.</p></td>
</tr>
<tr>
<td><p>BD</p></td>
<td><p>validate, status --verbose y consulta controlada.</p></td>
<td><p>Liquibase actualizado; roles y estructura disponibles.</p></td>
</tr>
<tr>
<td><p>API</p></td>
<td><p>GET /health, /health/live y /health/ready.</p></td>
<td><p>Proceso, BD y MQTT reportan estado esperado.</p></td>
</tr>
<tr>
<td><p>Frontend</p></td>
<td><p>GET /health y navegaci&#243;n inicial.</p></td>
<td><p>Nginx entrega la aplicaci&#243;n y /api/ se reenv&#237;a.</p></td>
</tr>
<tr>
<td><p>MQTT</p></td>
<td><p>Test-NetConnection localhost -Port 1883.</p></td>
<td><p>Broker escucha localmente; la telemetr&#237;a se prueba despu&#233;s con payload controlado.</p></td>
</tr>
<tr>
<td><p>Integraci&#243;n</p></td>
<td><p>Backend npm test/check/test:integration seg&#250;n variables disponibles.</p></td>
<td><p>Resultados registrados; las pruebas omitidas se explican.</p></td>
</tr>
</table>


# 12. Instalación y aprovisionamiento del ESP32

Abra firmware en PlatformIO, seleccione el entorno esp32dev y mantenga el monitor a 115200. El firmware declara PubSubClient, ArduinoJson y NimBLE-Arduino. El flujo BLE guarda SSID, contraseña, host, puerto y deviceCode en NVS; el usuario final no debe escribir la IP del PC en una pantalla de la aplicación.

# 13. Actualización, rollback y respaldo

# 14. Resolución de problemas de instalación

<table>
<tr>
<td><p><strong>Problema</strong></p></td>
<td><p><strong>Revisi&#243;n</strong></p></td>
</tr>
<tr>
<td><p>config --quiet falla</p></td>
<td><p>Variables obligatorias, especialmente contrase&#241;as y MQTT_DEVICE_HOST.</p></td>
</tr>
<tr>
<td><p>db-bootstrap no termina</p></td>
<td><p>PostgreSQL healthy, POSTGRES_PASSWORD, DB_PASSWORD y DB_INGEST_PASSWORD.</p></td>
</tr>
<tr>
<td><p>Liquibase no conecta</p></td>
<td><p>Servicio postgres:5432 dentro de Docker; no usar localhost:5433 desde el contenedor.</p></td>
</tr>
<tr>
<td><p>Backend unhealthy</p></td>
<td><p>Logs, conexi&#243;n a BD, JWT_SECRET, usuario ingest y broker mqtt://mosquitto:1883.</p></td>
</tr>
<tr>
<td><p>Frontend no construye</p></td>
<td><p>VITE_API_URL, VITE_MQTT_DEVICE_HOST y VITE_MQTT_DEVICE_PORT.</p></td>
</tr>
<tr>
<td><p>ESP32 no publica</p></td>
<td><p>Host alcanzable desde la red del ESP32; localhost solo sirve para el equipo local.</p></td>
</tr>
</table>


<strong>Control de evidencia. </strong>Fuentes: PT\_HS/README.md, docker-compose.yml, docs/estado-verificado-2026-09-26.md, BD\_HS/docs/README.md, firmware/README.md, platformio.ini y package.json. Los pasos destructivos se describen para advertir, no para ejecutarlos automáticamente.

<!-- footer: HidroSmart | DOC-09 | Versión documental consolidada 1.0 | Página PAGE -->
