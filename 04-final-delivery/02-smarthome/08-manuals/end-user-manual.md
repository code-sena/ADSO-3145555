# Manual De Usuario Final

**Proyecto:** SmartHome · **ADSO:** 3145555 · **Fecha:** 6 de noviembre de 2026

**Elaborado por:** Natalia Chala Chala, Kevin Stiven López Amaya, Karen Daniela Holguín Cruz

---

## 1. Bienvenida y finalidad

SmartHome es una solución pensada para que una persona pueda organizar sus hogares, consultar dispositivos conectados y entender mejor su consumo eléctrico. El sistema ofrece una interfaz web y una aplicación móvil. Este manual presenta recorridos habituales de uso sin asumir que todas las funciones de un prototipo antiguo estén disponibles en el entorno que tenga instalado el usuario.

Las instrucciones se basan en pantallas y rutas del código web y móvil. Los nombres visibles pueden variar ligeramente según idioma, sesión y versión. Si una opción no aparece, no intentes forzar la navegación: consulta con el administrador o comprueba que se haya instalado la versión correcta.

## 2. Antes de comenzar

- Necesitas una cuenta habilitada de SmartHome y acceso a Internet o a la red de prueba autorizada.
- Si vas a controlar un dispositivo IoT, debe estar registrado y disponible en tu hogar, y tu rol debe permitir esa operación.
- Para usar la web, abre la dirección que te suministró el equipo; localhost es solo un ejemplo para un entorno local.
- En Android, utiliza la aplicación o build proporcionada por el equipo; las funciones BLE pueden requerir una build nativa.
- No compartas claves, tokens ni códigos de recuperación con otras personas.

## 3. Registro, inicio de sesión y recuperación

### 3.1. Iniciar sesión

1. Abre SmartHome en tu navegador o teléfono Android.
1. Busca la pantalla de acceso y escribe el correo electrónico asociado a tu cuenta.
1. Introduce tu contraseña y selecciona Iniciar sesión.
1. Si los datos y el estado de la cuenta son válidos, accederás al panel principal; de lo contrario, revisa el mensaje de error.

En la web existe una ruta de inicio de sesión /login y enlaces a registro, recuperación, activación y reactivación de cuenta. En móvil la navegación depende de tu estado de autenticación.

### 3.2. Crear o recuperar el acceso

1. Si no tienes cuenta, utiliza la opción de registro disponible en la pantalla de acceso.
1. Completa los campos solicitados y sigue los avisos mostrados en pantalla.
1. Si olvidaste tu contraseña, selecciona la opción de recuperación y utiliza únicamente el enlace enviado por el procedimiento oficial.
1. Si el sistema solicita activar la cuenta, sigue esa ruta antes de volver a intentar el acceso.

**Privacidad.** El personal de soporte nunca necesita que le envíes tu contraseña por chat. Si compartes una captura, oculta correo, códigos de verificación y datos personales.

## 4. Cómo orientarse por la aplicación

| Plataforma | Navegación principal en el código | Recomendación |
| --- | --- | --- |
| Web | Dashboard, Hogares, Dispositivos por hogar, Consumo, Notificaciones, Perfil | Primero selecciona el hogar; algunas páginas requieren un homeId válido. |
| Móvil | Inicio, Hogares, Energía, Avisos y Perfil | Usa las pestañas de navegación y verifica el hogar activo. |

La sección de dispositivos puede estar incluida dentro del contexto del hogar, por lo que no necesariamente aparece como una pestaña independiente en el móvil.

## 5. Gestión de hogares

1. Entra en Hogares o Mis hogares.
1. Selecciona el hogar que quieres consultar o administrar.
1. Si tienes permisos adecuados, utiliza las opciones disponibles para crear o editar un hogar; los campos exactos dependen de la versión instalada.
1. Comprueba que el hogar activo sea el correcto antes de consultar consumo o ejecutar acciones sobre dispositivos.
1. Si recibes un mensaje de acceso denegado, verifica tu membresía con el propietario del hogar.

Los permisos se administran mediante roles globales y roles específicos por hogar. La experiencia puede mostrar controles distintos para OWNER, MEMBER y GUEST. Los invitados deben tratarse como usuarios con acceso limitado; no se debe esperar que puedan controlar todos los equipos.

## 6. Consulta de dispositivos

1. Abre el hogar que deseas administrar.
1. Accede a Dispositivos del hogar.
1. Utiliza el buscador si hay varios equipos registrados.
1. Abre el detalle del equipo para consultar información y acciones disponibles.
1. Si aparece un dispositivo inactivo y tu rol lo permite, revisa la opción de reactivación antes de operar sobre él.

La página web implementa búsqueda, lista de dispositivos activos e inactivos, estados y acciones según permisos. Si la lista está vacía, revisa que hayas seleccionado el hogar correcto.

### 6.1. Encender y apagar dispositivos

1. Comprueba que el dispositivo mostrado corresponde a tu hogar.
1. Si tu rol autoriza la acción, utiliza el control de encendido o apagado disponible en su tarjeta o detalle.
1. Espera el resultado de la solicitud. Si la aplicación indica que la orden fue publicada, interpreta ese estado como un envío, no como una confirmación eléctrica.
1. Antes de manipular cualquier carga, comprueba el estado real del dispositivo y respeta las instrucciones de seguridad del fabricante.

**Atención.** Una orden enviada puede demorarse o no llegar al equipo. No asumas que una carga eléctrica quedó desconectada únicamente por el estado visual de un botón en pantalla.

## 7. Registro o vinculación Shelly

Las versiones web y móvil contienen rutas y pantallas relacionadas con agregar dispositivos y detectar equipos compatibles. Sin embargo, la vinculación inicial completa de Shelly desde cero continúa limitada según la documentación técnica. La app móvil dispone de funciones BLE experimentales de detección y lectura de datos, no de emparejamiento definitivo.

1. Abre la función Agregar dispositivo si está habilitada para tu rol y versión.
1. Selecciona la modalidad autorizada por tu equipo (por ejemplo descubrimiento o búsqueda por IP, si está disponible).
1. Sigue únicamente instrucciones específicas de tu entorno y modelo de Shelly.
1. Si el dispositivo no aparece o la pantalla indica un modo experimental, no restablezcas credenciales ni reinicies el equipo para forzar el resultado.
1. Comunica al responsable técnico el modelo, versión de app y mensaje mostrado, sin compartir claves o identificadores sensibles.

## 8. Consumo y energía

En el móvil, la pestaña Energía permite seleccionar el hogar, consultar información de consumo y cambiar entre apartados como Consumo y Planificación. En la web, el apartado de consumo se relaciona con el hogar seleccionado y presenta consultas y gráficos de valores energéticos cuando hay registros.

1. Selecciona el hogar cuyos datos quieres consultar.
1. Entra en Energía en móvil o en Consumo desde el hogar en la web.
1. Elige el período disponible: día, mes o año, según la interfaz.
1. Observa los indicadores y gráficos con cuidado: kW/W y kWh representan cantidades distintas.
1. Si no hay lecturas, revisa que el dispositivo esté registrado y que la fuente de telemetría esté disponible; evita interpretar ausencia de datos como consumo cero.

### 8.1. Exportación de información desde Android

El código móvil incluye acciones para generar y compartir información de consumo en CSV y PDF. Las opciones están condicionadas a que exista un hogar seleccionado y datos válidos para el período. Si el botón está deshabilitado, revisa la selección y espera a que termine la carga antes de reintentar.

## 9. Avisos y notificaciones

1. Accede a Avisos en móvil o a Notificaciones en la web.
1. Consulta el mensaje y su contexto: hogar, dispositivo o evento.
1. Verifica los estados disponibles y utiliza las acciones que tu sesión permita.
1. Si el aviso indica una situación eléctrica anómala, revisa el equipo con las medidas de seguridad apropiadas y solicita ayuda técnica cuando corresponda.

Las notificaciones dependen de servicios y condiciones de generación configurados. Una ausencia de aviso no debe considerarse garantía de ausencia de riesgo eléctrico.

## 10. Preferencias y perfil

Desde Perfil se pueden encontrar opciones de sesión, preferencias y ajustes de interfaz. El alcance exacto varía entre web y móvil y entre versiones. En la documentación de la aplicación aparecen mecanismos para preferencias de idioma y tema; comprueba el resultado en la versión instalada antes de dar un cambio por guardado.

## 11. Preguntas frecuentes y solución de inconvenientes

| Situación | Qué hacer |
| --- | --- |
| No puedo iniciar sesión | Revisa correo y contraseña, conexión y estado de cuenta. Usa recuperación si olvidaste la clave. |
| No aparece mi hogar | Confirma que entraste con la cuenta correcta y que tienes una membresía activa. |
| No puedo encender un equipo | Verifica rol, conexión, estado del dispositivo y mensaje de la acción. No fuerces un relé manualmente. |
| Los gráficos están vacíos | Selecciona hogar y período, espera la carga y verifica que existan lecturas. |
| No aparece Shelly en la búsqueda | Comprueba versión de la app y entorno autorizado; la detección y pairing no están garantizados. |
| No puedo exportar datos | Comprueba datos válidos, permisos y estado del botón en la pantalla de Energía. |
| Recibo una alerta de consumo | Identifica el equipo y revisa las condiciones reales de uso antes de tomar decisiones. |

## 12. Glosario breve

| Término | Significado para el usuario |
| --- | --- |
| Hogar | Espacio principal que agrupa a las personas y dispositivos que consultas. |
| Dispositivo | Equipo registrado que puede proporcionar estado, mediciones o capacidad de control. |
| Potencia (W) | Energía que un equipo utiliza por unidad de tiempo; refleja demanda instantánea. |
| Energía (kWh) | Cantidad acumulada de electricidad consumida a lo largo de un período. |
| MQTT | Canal utilizado por el sistema para comunicar eventos y telemetría con equipos compatibles. |
| Rol | Conjunto de permisos sobre una cuenta o un hogar. |
| Telemetría | Datos que un dispositivo envía al sistema, por ejemplo potencia y estado. |

## 13. Recomendaciones finales de uso seguro

- No compartas contraseñas, códigos ni capturas con datos personales sin ocultar.
- Comprueba siempre el hogar activo antes de operar un dispositivo.
- No interpretes una orden enviada como confirmación de que la corriente está cortada.
- Consulta soporte técnico si la app muestra errores de conexión persistentes.
- Utiliza la aplicación para orientación y monitoreo; no como instrumento certificado para intervenir instalaciones eléctricas.

## 14. Cierre

Este manual pretende que cualquier usuario pueda recorrer SmartHome con claridad y sin conocimientos de programación. La interfaz orienta a consultar hogares, dispositivos y energía, mientras las acciones de control requieren permisos y conectividad. Para la entrega formal del producto deberá acompañarse de una sesión de uso real y capturas depuradas de la versión instalada, sin confundir los prototipos históricos con pruebas funcionales.

## Fuentes y referencias verificables

1. [Requisito institucional de los tres manuales](https://github.com/code-sena/ADSO-3145555/blob/main/04-final-delivery/02-smarthome/08-manuals/README.md)
2. [SRS del proyecto](https://docs.google.com/document/d/1BYwKmODc6xmjVqJjOdBtK7t9KJr7vHnm/edit)
3. [Código de rutas web](https://github.com/nataliachala1/smarthome-frontend-web/blob/dev/web/src/app/App.tsx)
4. [Pantalla web de dispositivos](https://github.com/nataliachala1/smarthome-frontend-web/blob/dev/web/src/features/devices/pages/Devices.tsx)
5. [Pantalla web de consumo](https://github.com/nataliachala1/smarthome-frontend-web/blob/dev/web/src/features/consumption/pages/Consumption.tsx)
6. [Navegación móvil](https://github.com/Kevin-Stiven-Lopez-Amaya404/from_movil/blob/dev/app/(tabs)/(main)/_layout.tsx)
7. [Pantalla móvil de energía](https://github.com/Kevin-Stiven-Lopez-Amaya404/from_movil/blob/dev/app/(tabs)/(main)/reports.tsx)
8. [Guía BLE de la aplicación](https://github.com/Kevin-Stiven-Lopez-Amaya404/from_movil/blob/dev/docs/BLE_POC_ANDROID.md)
9. [Manual histórico de usuario en Drive](https://docs.google.com/document/d/1S_XQNFJhlY7F5PMUAMU7unqSuzNCusJD/edit)