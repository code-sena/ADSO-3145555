> **Estado y alcance.** Documento en revisión para la entrega. Las fechas, cifras y funciones heredadas del documento fuente solo se consideran vigentes cuando están respaldadas por evidencia del monorepo PT_HS. Consulta el [índice de entrega](../README.md) y el [índice de entrega](../README.md).

<strong>HIDROSMART</strong>

Manual de usuario final de HidroSmart

Operación funcional de la plataforma

Versión documental consolidada 1.0  
Fecha de corte: 2026-10-09  
Código documental: DOC-10


# Ampliación de operación funcional

Este manual explica los flujos que están respaldados por las rutas, módulos, prototipos y documentación de PT\_HS. Los textos describen funciones y resultados esperados, pero no fijan nombres exactos de botones que pueden cambiar entre builds.

# 1. Antes de comenzar

El usuario necesita una cuenta, acceso al ambiente HidroSmart y, si va a registrar un dispositivo físico, un equipo ESP32 preparado por el responsable técnico. Las pantallas pueden variar con la versión del frontend; este manual describe la funcionalidad que se encuentra respaldada por el repositorio.

# 2. Crear cuenta e ingresar

Abrir la aplicación y seleccionar registro.

Completar los datos solicitados y confirmar el correo.

Ingresar con las credenciales verificadas.

Si la sesión expira, volver a autenticarse; no compartir tokens ni contraseñas.

Usar recuperación de contraseña cuando esté habilitada por el ambiente.

# 3. Hogares y miembros

Crear o seleccionar un hogar.

Consultar miembros y solicitudes.

Administrar vacaciones y metas cuando se tenga permiso.

Cambiar preferencias de idioma, moneda, tema y opciones disponibles.

# 4. Registrar y preparar un dispositivo

Abrir la sección de dispositivos y registrar nombre/ubicación.

Asociar mediante el código del dispositivo.

Revisar estado, última conexión y umbrales.

Para un ESP32 nuevo, solicitar al técnico el modo de aprovisionamiento BLE.

Desde la aplicación móvil compatible, seleccionar el dispositivo BLE y enviar los parámetros autorizados.

No introducir credenciales en formularios o aplicaciones no oficiales.

# 5. Consultar consumo

Seleccionar hogar y dispositivo.

Revisar lectura actual y gráficas por periodo.

Interpretar flujo en L/min y consumo en litros; las vistas pueden mostrar m³.

Comparar agregados con la lectura de origen cuando se analice una anomalía.

La actualización del panel puede usar consulta periódica; no asumir una notificación instantánea si no aparece el nuevo dato.

# 6. Metas, alertas y recomendaciones

Definir una meta de consumo con el periodo disponible.

Configurar umbrales de alerta según permisos.

Revisar eventos y recomendaciones.

Si no llega un correo de cuenta, revisa spam y contacta soporte. HidroSmart usa Brevo; la respuesta de solicitud no garantiza que el mensaje se haya entregado.

# 7. Interpretar estados

<table>
<tr>
<td><p><strong>Estado</strong></p></td>
<td><p><strong>Significado y acci&#243;n</strong></p></td>
</tr>
<tr>
<td><p>ONLINE</p></td>
<td><p>El backend recibi&#243; estado reciente; revisar timestamp.</p></td>
</tr>
<tr>
<td><p>OFFLINE</p></td>
<td><p>No hay comunicaci&#243;n reciente; revisar energ&#237;a, red y broker con soporte.</p></td>
</tr>
<tr>
<td><p>ERROR</p></td>
<td><p>El dispositivo reporta una condici&#243;n que requiere diagn&#243;stico t&#233;cnico.</p></td>
</tr>
<tr>
<td><p>Sin lectura</p></td>
<td><p>No hay dato persistido o el rango no contiene muestras; no concluir que el consumo sea cero.</p></td>
</tr>
</table>


# 8. Buenas prácticas

Usar contraseñas únicas y cerrar sesión en equipos compartidos.

Reportar lecturas imposibles, cambios de ubicación o pérdida de dispositivo.

No desconectar el ESP32 durante una actualización.

Guardar capturas con fecha y dispositivo al reportar un incidente.

Solicitar al administrador la eliminación/corrección de datos conforme al procedimiento institucional.

<strong>Nota de control documental. </strong>Este manual no inventa nombres de botones específicos que pueden cambiar en la UI. Se basa en módulos, rutas y flujos descritos en PT\_HS y en los documentos de prototipado locales.


# 9. Mapa de uso de la plataforma

La navegación autenticada usa /app/\* y el menú lateral es colapsable en escritorio y hamburguesa en móvil. El usuario opera mediante la interfaz; PostgreSQL y MQTT son componentes técnicos y no deben abrirse directamente desde el navegador.

<table>
<tr>
<td><p><strong>&#193;rea</strong></p></td>
<td><p><strong>Qu&#233; permite hacer</strong></p></td>
</tr>
<tr>
<td><p>Cuenta y perfil</p></td>
<td><p>Registro, verificaci&#243;n, login, recuperaci&#243;n, sesiones, perfil, avatar y tel&#233;fono.</p></td>
</tr>
<tr>
<td><p>Hogares</p></td>
<td><p>Crear/consultar hogares, miembros, solicitudes, vacaciones y metas.</p></td>
</tr>
<tr>
<td><p>Dispositivos</p></td>
<td><p>Registrar, vincular por c&#243;digo, editar nombre/ubicaci&#243;n/umbral y consultar estado.</p></td>
</tr>
<tr>
<td><p>Consumo</p></td>
<td><p>Consultar resumen, lecturas, agregados, costos y series por periodo/ubicaci&#243;n.</p></td>
</tr>
<tr>
<td><p>Alertas y tarifas</p></td>
<td><p>Consultar reglas, umbrales, eventos, notificaciones y tarifa del hogar.</p></td>
</tr>
<tr>
<td><p>Reportes</p></td>
<td><p>Solicitar PDF/Excel, revisar historial propio y descargar el resultado disponible.</p></td>
</tr>
<tr>
<td><p>Recomendaciones</p></td>
<td><p>Consultar recomendaciones propias y resumen por hogar.</p></td>
</tr>
<tr>
<td><p>Soporte y privacidad</p></td>
<td><p>Crear/consultar tickets, respuestas, consentimientos y solicitudes ARCO.</p></td>
</tr>
</table>


# 10. Cuenta, verificación y sesiones

## 10.1 Registro y primer ingreso

Abrir la aplicación y elegir el flujo de registro.

Completar los datos solicitados y usar un correo al que se tenga acceso.

Consumir el enlace de verificación recibido; las cuentas nuevas permanecen Pending hasta ese paso.

Iniciar sesión con el correo y contraseña registrados.

Si no llega el correo de verificación, revisa spam y contacta soporte indicando fecha y dirección enmascarada. El proveedor configurado es Brevo.

## 10.2 Sesiones y seguridad de acceso

Cerrar sesión en equipos compartidos.

Usar recuperación de contraseña si se pierde el acceso.

Ante una expiración, permitir que el cliente renueve una vez o volver a autenticarse.

No compartir tokens, contraseñas ni capturas que los contengan.

Consultar sesiones propias y cerrarlas cuando el flujo esté disponible en el build.

# 11. Perfil, preferencias y hogares

## 11.1 Perfil y preferencias

El backend documenta perfil con avatar opcional y teléfono de hasta 60 caracteres. Las preferencias incluyen idioma, moneda, tema y otras opciones que el build exponga. Después de guardar, vuelva a consultar el perfil para confirmar el cambio; si no aparece, registre el mensaje de error y el momento de la operación.

## 11.2 Hogares y miembros

Crear o seleccionar un hogar.

Revisar miembros y solicitudes pendientes.

Conceder o usar funciones solo si el rol/permisos lo permiten.

Asociar dispositivos al hogar correcto antes de consultar consumo.

Configurar modo vacaciones y metas desde el hogar correspondiente.

# 12. Registrar y vincular un dispositivo

Desde dispositivos, registrar el equipo con nombre y ubicación disponibles.

Asociarlo usando device.code, sin inventar un código alternativo.

Verificar que el dispositivo quede relacionado con el hogar esperado.

Para mover el equipo a otro hogar, usa **Desvincular dispositivo** desde el hogar actual y luego vincula el mismo registro en el hogar destino. Desvincular quita la asociación, pero conserva el registro, el código lógico, las lecturas históricas y las credenciales Wi-Fi guardadas; el firmware vuelve a anunciar BLE. Eliminar el dispositivo es una acción diferente y puede borrar su historial.

Editar nombre, ubicación y umbral cuando el usuario tenga permiso. Al pausar la medición, la placa sigue conectada y enviando flujo/pulsos para vigilar fugas; solo deja de sumar litros al consumo. Reactiva la medición para reanudar el conteo. Esta acción no apaga eléctricamente el ESP32.

Revisar el estado, última conexión, hardwareId y datos de aprovisionamiento que el build muestre.

La pantalla no solicita la IP del PC como dato de usuario. El host y puerto MQTT se envían desde la configuración técnica del frontend durante BLE y se guardan en NVS; el equipo técnico debe preparar esa configuración antes de la prueba.

## 12.1 Aprovisionamiento BLE: flujo guiado

La aplicación móvil usa react-native-ble-plx y requiere un development build. El servicio documentado es 4fafc201-1fb5-459e-8fcc-c5c9c331914b; configuración es beb5483e-36e1-4688-b7f5-ea07361b26a8 y estado es beb5483e-36e1-4688-b7f5-ea07361b26a9.

Energizar la placa y acercar el móvil dentro del alcance Bluetooth.

Seleccionar el dispositivo BLE HidroSmart visible en el build compatible.

Enviar SSID, contraseña y deviceCode; mqttHost/mqttPort se usan cuando la configuración los requiere.

Esperar wifi\_connecting y luego wifi\_connected o wifi\_failed.

Confirmar mqtt\_unreachable o provisioning\_complete según el resultado.

No repetir el envío indiscriminadamente: primero revisar el estado y la red.

# 13. Consultar consumo correctamente

Seleccione hogar, dispositivo y periodo antes de interpretar una gráfica. Las rutas documentadas permiten resumen, lecturas agregadas, costos y series por día, hora, mes o ubicación. El dashboard representa el último punto agregado horario; no debe interpretarse como caudal MQTT instantáneo.

<table>
<tr>
<td><p><strong>Dato visible</strong></p></td>
<td><p><strong>Interpretaci&#243;n operativa</strong></p></td>
</tr>
<tr>
<td><p>flowRateLpm</p></td>
<td><p>Caudal en litros por minuto cuando la lectura lo incluye.</p></td>
</tr>
<tr>
<td><p>consumptionLiters</p></td>
<td><p>Consumo de la muestra en litros.</p></td>
</tr>
<tr>
<td><p>totalLiters</p></td>
<td><p>Acumulado informado por el dispositivo cuando est&#225; disponible.</p></td>
</tr>
<tr>
<td><p>pulses</p></td>
<td><p>Pulsos contabilizados por el sensor en el intervalo.</p></td>
</tr>
<tr>
<td><p>timestamp</p></td>
<td><p>Instante de medici&#243;n normalizado; revisar zona horaria.</p></td>
</tr>
<tr>
<td><p>Sin lectura</p></td>
<td><p>No hay muestra disponible para el rango; no equivale autom&#225;ticamente a consumo cero.</p></td>
</tr>
</table>


La interfaz actual actualiza datos mediante polling HTTP periódico de aproximadamente cinco segundos en el flujo documentado; no se debe prometer una notificación push WebSocket. Si se requiere el dato más reciente, revise timestamp y estado antes de concluir que existe una anomalía.

# 14. Metas, vacaciones, tarifas y alertas

Configurar una meta desde el hogar y seleccionar el periodo que la interfaz permita.

Revisar progreso con el mismo rango temporal usado para las lecturas.

Activar o consultar modo vacaciones solo para el hogar correcto.

Consultar la tarifa vigente asociada al hogar antes de interpretar costos.

Revisar reglas, umbrales, eventos e historial de alertas.

Consulta las alertas dentro de la aplicación. No se debe asumir correo o push para fugas, consumo o metas: sus disparadores no están confirmados como conectados en el corte actual.

# 15. Reportes y recomendaciones

Elegir el hogar autorizado y el rango de fechas.

Solicitar el formato disponible, PDF o Excel, desde la sección de reportes.

Esperar la generación y revisar el historial propio de descargas.

No compartir reportes con datos personales sin autorización.

Consultar recomendaciones junto con el periodo y hogar a los que aplican.

# 16. Soporte, privacidad y roles

El módulo de soporte documenta catálogos, tickets y respuestas. Al reportar un problema incluya usuario, hogar, deviceCode, timestamp, estado mostrado y pasos realizados; nunca incluya contraseña, token o clave Wi-Fi. El módulo privacy documenta consentimientos, exportación propia y solicitudes ARCO; use el flujo aprobado por la organización.

<table>
<tr>
<td><p><strong>Perfil / actor</strong></p></td>
<td><p><strong>Uso documentado</strong></p></td>
</tr>
<tr>
<td><p>Usuario dom&#233;stico</p></td>
<td><p>Monitorear consumo, hogares, dispositivos, metas, vacaciones, reportes, recomendaciones y soporte.</p></td>
</tr>
<tr>
<td><p>Administrador</p></td>
<td><p>Supervisar usuarios, hogares, dispositivos, roles, auditor&#237;a y errores seg&#250;n permisos.</p></td>
</tr>
<tr>
<td><p>Soporte t&#233;cnico</p></td>
<td><p>Diagnosticar conectividad, aprovisionamiento, calibraci&#243;n, tickets y estado de dispositivos.</p></td>
</tr>
<tr>
<td><p>ESP32</p></td>
<td><p>Publicar telemetr&#237;a/estado y recibir configuraci&#243;n/comandos; no es un usuario humano.</p></td>
</tr>
</table>


# 17. Estados y solución de problemas

<table>
<tr>
<td><p><strong>Estado / problema</strong></p></td>
<td><p><strong>Qu&#233; significa</strong></p></td>
<td><p><strong>Qu&#233; debe hacer el usuario</strong></p></td>
</tr>
<tr>
<td><p>ONLINE</p></td>
<td><p>Estado reciente recibido.</p></td>
<td><p>Revisar timestamp y consultar lectura.</p></td>
</tr>
<tr>
<td><p>OFFLINE</p></td>
<td><p>No hay comunicaci&#243;n reciente.</p></td>
<td><p>Verificar energ&#237;a/red con soporte; no modificar configuraciones al azar.</p></td>
</tr>
<tr>
<td><p>ERROR</p></td>
<td><p>El dispositivo reporta condici&#243;n de error.</p></td>
<td><p>Registrar timestamp, deviceCode y mensaje para soporte.</p></td>
</tr>
<tr>
<td><p>No aparecen datos</p></td>
<td><p>Rango sin lecturas, backend no saludable o dispositivo sin publicar.</p></td>
<td><p>Revisar rango/estado y escalar con evidencia.</p></td>
</tr>
<tr>
<td><p>Lectura anormal</p></td>
<td><p>Puede requerir calibraci&#243;n o revisi&#243;n del sensor.</p></td>
<td><p>No tomarla como medici&#243;n definitiva; solicitar validaci&#243;n f&#237;sica.</p></td>
</tr>
<tr>
<td><p>No llega correo</p></td>
<td><p>Brevo puede aceptar la solicitud sin que el correo llegue; revisa spam y reporta la hora y el flujo usado.</p></td>
<td><p>Reportar fecha, correo enmascarado y operaci&#243;n realizada.</p></td>
</tr>
</table>


# 18. Uso responsable y límites

No abrir PostgreSQL ni Mosquitto directamente desde el navegador.

No introducir contraseñas Wi-Fi en campos distintos del aprovisionamiento autorizado.

No desconectar la placa durante una actualización o prueba técnica.

No interpretar una lectura sin calibración como medida certificada.

Mosquitto local no tiene TLS/ACL y es solo para desarrollo. El perfil externo del ESP32 usa Flespi/TLS; no reutilices tokens ni asumas que la ACL del ambiente está vigente sin comprobarla.

La compatibilidad móvil, accesibilidad y E2E aún requieren verificación adicional.

<strong>Control de evidencia. </strong>Fuentes: PT\_HS/README.md, docs/estado-verificado-2026-09-26.md, BK\_HS/docs/00-estado-actual.md, BK\_HS/docs/03-endpoints.md y endpoints-por-rol.md, firmware/README.md, FT\_HS/frontend/package.json, SRS original, diseño conceptual y prototipos locales. Los nombres exactos de botones pueden cambiar entre builds.

<!-- footer: HidroSmart | DOC-10 | Versión documental consolidada 1.0 | Página PAGE -->
