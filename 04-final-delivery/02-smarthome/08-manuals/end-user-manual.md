# Manual de usuario final — SmartHome

Servicio Nacional de Aprendizaje (SENA)  
Programa: Análisis y Desarrollo de Software · Ficha: 3145555  
Proyecto: SmartHome · Revisión documental: 7 de noviembre de 2026  
Equipo: Karen Daniela Holguín Cruz, Natalia Chala Chala y Kevin Stiven López Amaya  
Estado: versión preparada para revisión académica; no publicada en el PR #17 ni aprobada por el instructor.

> Control de versión. Estos manuales parten de los tres Markdown de la rama `final-delivery/smarthome-stiven-20261107` del PR institucional #17 y se contrastaron con README y manifiestos `package.json` de las ramas `dev` accesibles el 7-11-2026. Son una referencia documental de desarrollo, no certificación de funcionamiento de una versión `main` etiquetada. No se ejecutaron instalaciones, pruebas Android ni operaciones eléctricas durante su elaboración.

## 1. ¿Qué es SmartHome?

SmartHome ayuda a organizar hogares, consultar dispositivos conectados, visualizar información de consumo eléctrico y revisar avisos. Cuenta con una interfaz web y una aplicación móvil Android. Las opciones visibles dependen de la versión instalada, del hogar seleccionado y de los permisos de tu cuenta.

Antes de comenzar: necesitas una cuenta habilitada, acceso al servicio configurado por el equipo y, para operar un dispositivo, autorización sobre ese hogar. Nunca compartas contraseñas, códigos ni tokens. Las pantallas descritas son una guía documental: deben comprobarse con una demostración de la versión aprobada.

Como marco de referencia, este manual se estructura por tareas del usuario según ISO/IEC/IEEE 26514 (ISO/IEC/IEEE, 2022), y el uso de los datos personales se explica conforme a la Ley 1581 de 2012 (Congreso de la República de Colombia, 2012).

## 2. Entrar a tu cuenta

1. Abre la dirección web o aplicación Android que te entregó el equipo.
2. En la pantalla de acceso, escribe tu correo y contraseña.
3. Selecciona Iniciar sesión y comprueba el mensaje de respuesta.
4. Si olvidaste tu contraseña, utiliza la opción oficial de recuperación; sigue el enlace enviado por el sistema.
5. Si te solicitan activar o reactivar la cuenta, completa ese proceso antes de volver a ingresar.

La web documenta una ruta `/login` con enlaces de registro, activación y recuperación. No todas las funciones se mostrarán de la misma manera en la app Android. Evita enviar capturas que muestren tu correo, códigos de activación o datos de otras personas.

## 3. Reconocer las pantallas

**Tabla 1**

*Reconocer las pantallas*

| Web | Aplicación móvil |
|---|---|
| Panel principal, Hogares, Dispositivos, Consumo, Notificaciones, Perfil | Inicio, Hogares, Energía, Avisos, Perfil |

Fuente: elaboración propia.

En móvil, Dispositivos puede aparecer dentro de un hogar en lugar de ser una pestaña independiente. Verifica el nombre del hogar activo antes de consultar consumo o realizar controles.

## 4. Consultar y administrar hogares

1. Abre Hogares o Mis hogares.
2. Elige el hogar que deseas visualizar.
3. Si tienes permiso, utiliza las opciones visibles para crear o editar un hogar.
4. Entra al detalle para ver dispositivos y datos del hogar.
5. Si aparece «Acceso denegado», consulta con el propietario: tu cuenta puede pertenecer a otro hogar o tener un rol restringido.

Existen permisos diferentes para propietarios, miembros e invitados. No interpretes la presencia de un botón como autorización completa: el servidor verifica los permisos cuando se envía una acción.

## 5. Consultar dispositivos

1. Selecciona el hogar correcto.
2. Entra a Dispositivos dentro del contexto del hogar.
3. Busca por nombre si hay muchos equipos; abre su detalle.
4. Observa el estado reportado por la aplicación antes de actuar.
5. Para encender o apagar, utiliza el control disponible solo si tu rol lo permite y revisa el resultado.

Muy importante: si la aplicación dice que se envió una orden, eso no garantiza que el relé haya cambiado físicamente. No te acerques a un cable o carga eléctrica suponiendo que está desconectada; comprueba el estado real y sigue las instrucciones del fabricante.

## 6. Agregar un Shelly compatible

La aplicación puede mostrar opciones para agregar dispositivos, descubrirlos por red o usar Bluetooth. La documentación del backend indica que el proceso completo de vinculación inicial Shelly desde cero aún requiere validación; BLE en Android incluye funciones experimentales.

1. Abre Agregar dispositivo cuando esté disponible.
2. Sigue las indicaciones específicas para el modelo y el entorno autorizado.
3. Si no aparece, comprueba el estado de conexión y la versión de la app.
4. No reinicies, reconfigures Wi-Fi ni cambies contraseñas del equipo por ensayo y error.
5. Comunica al responsable técnico el mensaje mostrado, sin enviar claves ni identificadores sensibles.

## 7. Consultar energía y consumo

1. Elige tu hogar activo.
2. Abre Energía en Android o Consumo en el entorno web.
3. Selecciona el período ofrecido en pantalla (por ejemplo, día, mes o año).
4. Consulta indicadores y gráficas cuando existan mediciones almacenadas.
5. Si hay un botón de exportación habilitado, podrás generar o compartir archivos según los formatos disponibles en tu versión.

Diferencia importante: W o kW describen potencia en un instante; kWh describe energía acumulada en un período. Si una gráfica está vacía, puede faltar telemetría o selección de hogar: no significa necesariamente que el consumo haya sido cero.

## 8. Avisos, notificaciones y perfil

En Avisos o Notificaciones, revisa el mensaje, su relación con el hogar o dispositivo y las acciones disponibles. Un aviso no sustituye una revisión eléctrica profesional, y la ausencia de alertas tampoco garantiza que no haya riesgo.

Desde Perfil encontrarás funciones de sesión y opciones de preferencia cuando estén habilitadas, por ejemplo idioma o aspecto visual. Comprueba que cada cambio realmente se conserve antes de darlo por aplicado.

## 9. Preguntas frecuentes

**Tabla 2**

*Preguntas frecuentes*

| Situación | Qué puedes hacer |
|---|---|
| No puedo entrar | Revisar credenciales, conexión y recuperación de cuenta |
| No veo mi hogar | Comprobar usuario, membresía y hogar activo |
| No puedo controlar un equipo | Revisar rol, conexión, estado y resultado de la orden |
| No hay gráfica | Seleccionar hogar/período y confirmar que existen lecturas |
| No aparece Shelly | Verificar entorno de prueba y consultar soporte |
| No se habilita exportar | Confirmar que hay datos y que terminó la carga |
| Recibo aviso de consumo | Revisar la información y tomar decisiones seguras |

Fuente: elaboración propia.

## 10. Glosario para usuarios

**Tabla 3**

*Glosario para usuarios*

| Término | Significado |
|---|---|
| Hogar | Espacio que agrupa personas, dispositivos y datos |
| Dispositivo | Equipo registrado para consultar su estado o consumo |
| Telemetría | Datos que envía un dispositivo al sistema |
| MQTT | Tecnología de comunicación entre equipos y servicios |
| Potencia (W) | Energía consumida por unidad de tiempo, instantánea |
| Energía (kWh) | Electricidad acumulada durante un período |
| Rol | Permisos asociados a una cuenta o un hogar |

Fuente: elaboración propia.

## 11. Uso responsable y alcance real

No difundas claves ni capturas con datos personales. Nunca uses el estado de SmartHome como prueba suficiente de ausencia de tensión eléctrica. El equipo debe aportar capturas de una versión instalada y una demostración funcional antes de certificar el recorrido de este manual. No confundir prototipos antiguos con funcionamiento actual.

## 12. Fuentes

- [Manual de usuario del PR #17](https://github.com/Kevin-Stiven-Lopez-Amaya404/ADSO-3145555/blob/final-delivery/smarthome-stiven-20261107/04-final-delivery/02-smarthome/08-manuals/end-user-manual.md)
- [Frontend web](https://github.com/nataliachala1/smarthome-frontend-web)
- [Frontend móvil](https://github.com/Kevin-Stiven-Lopez-Amaya404/from_movil)
- [Requisitos institucionales](https://github.com/code-sena/ADSO-3145555/blob/main/04-final-delivery/02-smarthome/08-manuals/README.md)

## Referencias

Congreso de la República de Colombia. (2012, 17 de octubre). *Ley Estatutaria 1581 de 2012, por la cual se dictan disposiciones generales para la protección de datos personales*. Diario Oficial n.º 48.587. https://www.funcionpublica.gov.co/eva/gestornormativo/norma.php?i=49981

ISO/IEC/IEEE. (2022). *Systems and software engineering — Design and development of information for users* (ISO/IEC/IEEE 26514:2022). https://www.iso.org/standard/77451.html
