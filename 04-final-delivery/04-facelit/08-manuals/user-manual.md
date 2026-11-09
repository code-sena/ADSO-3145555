# Manual de usuario — FaceLit

**FaceLit | Asistencia académica y reconocimiento facial**
Guía breve para Coordinador, Instructor y Aprendiz
*Actualizado el 4 de noviembre de 2026*

| Coordinador | Instructor | Aprendiz |
|---|---|---|
| Gestiona información | Prepara la sesión | Registra su rostro |

## ¿Qué hace FaceLit?

FaceLit reúne la gestión académica y el registro de asistencia de aprendices. El Instructor configura la sesión y opera la captura; el sistema valida el rostro y muestra el resultado. Cada persona consulta las opciones disponibles para su cuenta.

### El recorrido principal

1. Cuenta y ficha
2. Registro facial
3. Sesión del instructor
4. Captura y consulta

> **La pregunta clave:** el sistema registra asistencia en una sesión configurada y muestra una confirmación del resultado. El registro inicial del rostro, por sí solo, no marca asistencia.

### Alcance de esta guía

- Las opciones visibles dependen del rol asignado a la cuenta.
- Las funciones con cámara se realizan desde la versión web en un computador con cámara y permiso del navegador.
- El equipo confirma el funcionamiento del inicio de sesión, la carga CSV, el correo, la cámara y el registro de asistencia.

> FaceLit tiene tres roles de usuario: Coordinador, Instructor y Aprendiz. La palabra *admin* en nombres internos de rutas corresponde al área del Coordinador.

---

## 1. Acceder a la aplicación

Necesitas una cuenta creada por la institución, tu número de documento y la contraseña asignada. Abre https://facelit.tech/ o el enlace institucional que te haya indicado el equipo.

### Iniciar sesión

1. Escribe tu número de documento en el campo de identificación.
2. Ingresa la contraseña de tu cuenta.
3. Selecciona **Iniciar sesión**.
4. Espera a que cargue el inicio correspondiente a tu rol.

Si es tu primera vez y no tienes credenciales, solicita una cuenta al Coordinador. No uses la cuenta de otra persona.

### Recuperar la contraseña

1. En el acceso, selecciona **¿Olvidaste tu contraseña?**.
2. Escribe el correo asociado a tu cuenta y envía la solicitud.
3. Continúa a la verificación de identidad y escribe el código que recibas.
4. Define la contraseña nueva y vuelve a iniciar sesión.

Si no llega el mensaje, revisa el correo registrado y la carpeta de no deseados. El sistema puede mostrar una respuesta genérica para proteger la privacidad de las cuentas. Si persiste el problema, consulta al Coordinador.

### Cerrar sesión

Usa la opción de cerrar sesión del perfil o menú cuando termines, especialmente en un equipo compartido. Cerrar la pestaña no siempre cierra tu sesión.

---

## 2. Inicio, perfil y notificaciones

La pantalla de inicio muestra accesos y resúmenes según el rol. En web, la página pública presenta información de FaceLit y el acceso al sistema.

### Perfil y preferencias

- Abre **Mi perfil** para revisar la información asociada a tu cuenta.
- En **Configuración**, elige un tema y uno de los idiomas disponibles: español, inglés, alemán o francés.
- Guarda los cambios para conservar la preferencia de cuenta. El selector rápido de idioma cambia la interfaz actual.
- Si nombre, documento u otro dato personal está incorrecto, solicita la corrección al Coordinador.

### Notificaciones

Abre el centro de notificaciones para revisar avisos. Toca un aviso para ver su detalle; al abrirlo, puede marcarse como leído. La bandeja permite filtrar por estado y categoría. Las solicitudes que requieren decisión muestran acciones disponibles según el rol y el tipo de aviso.

El Coordinador puede aceptar o rechazar solicitudes de autorización de nuevo registro facial desde la notificación correspondiente. Espera el resultado visible antes de repetir una acción.

### Resumen por rol

| Rol | Accesos principales |
|---|---|
| Coordinador | Usuarios, gestión académica, ambientes, asistencia, reportes y avisos administrativos. |
| Instructor | Fichas asignadas, ambientes, asistencia, reportes y configuración/operación de sesión facial. |
| Aprendiz | Panel personal, asistencia, notificaciones, perfil y registro facial desde la web. |

Los permisos y acciones efectivamente disponibles dependen de la cuenta y de la configuración institucional.

---

## 3. Coordinador: usuarios y datos académicos

Usa el panel del Coordinador para mantener la información que otras funciones necesitan. Antes de guardar, confirma que seleccionaste el registro correcto.

### Usuarios

1. Abre **Usuarios** y busca a la persona.
2. Entra a su ficha y revisa documento, nombre, correo y rol.
3. Usa las acciones disponibles para crear, editar o cambiar el estado de la cuenta.
4. Guarda y comprueba que la lista o el detalle refleje el resultado.

Un cambio de estado puede afectar el acceso. Verifica la identidad de la persona antes de modificar una cuenta.

### Programas y fichas

1. Abre **Gestión académica** y elige programas, fichas o asignaciones.
2. Busca el registro correspondiente. Revisa instructores, aprendices y asociaciones.
3. Guarda los cambios y confirma que la información aparezca en el detalle.

### Carga de datos CSV

1. Abre la opción de carga CSV de gestión académica.
2. Prepara el archivo con las columnas y formato que indica la pantalla o la plantilla vigente.
3. Revisa la vista previa y los errores antes de confirmar la importación.
4. Al terminar, consulta los registros afectados.

No supongas que el sistema corregirá filas incompletas automáticamente. Conserva el archivo original y evita cargar una segunda vez hasta verificar el resultado de la primera operación.

### Solicitudes de nuevo registro facial

Revisa la notificación del aprendiz. Abre el detalle y acepta o rechaza la solicitud desde la acción disponible. El aprendiz deberá esperar la decisión antes de capturar nuevamente.

---

## 4. Instructor: preparar una sesión

La configuración de reconocimiento facial y la captura de asistencia están disponibles en la versión web. Antes de iniciar, confirma la jornada, las asociaciones y el acceso a la cámara.

### Configurar y guardar

1. Abre **Gestión de Reconocimiento Facial**.
2. Selecciona o busca el ambiente de la jornada.
3. Selecciona el Instructor responsable y luego una ficha disponible para esa selección.
4. Entra a **Ajustes** y define el tiempo de registro, la hora de salida y la hora de apagado.
5. Guarda los ajustes. Vuelve al resumen y confirma ambiente, Instructor, ficha y horarios.
6. Guarda la configuración de sesión. Cuando quede activa, abre la captura.

La aplicación recupera la sesión activa del backend. Si no aparece el ambiente, Instructor o ficha esperados, detente y solicita revisar las asociaciones académicas antes de iniciar la toma de asistencia.

### Durante la jornada

- Mantén abierta la pantalla de captura mientras atiendes al grupo.
- Cada aprendiz debe estar presente y seguir el reto que aparece en pantalla.
- Espera el resultado confirmado antes de atender al siguiente aprendiz.
- La sesión se cierra según la hora de apagado configurada.

> Los horarios de entrada y salida de una sesión no son un ajuste del umbral de coincidencia facial. La administración de horarios académicos no forma parte del flujo vigente descrito aquí.

---

## 5. Instructor: registrar asistencia

La cámara del Instructor está diseñada para operar desde el navegador web en un computador con cámara. En celulares, FaceLit muestra un aviso de función no disponible y permite consultar asistencia/notificaciones.

### Flujo de captura

**Preparar cámara → Seguir 2 retos → Validar rostro → Ver confirmación**

1. Permite el acceso a la cámara si el navegador lo solicita.
2. Comprueba iluminación y que solo aparezca el aprendiz que va a marcar asistencia.
3. Sigue los dos retos aleatorios que aparecen; pueden pedir mirar arriba, mirar abajo, acercarse o alejarse.
4. Espera mientras FaceLit valida la prueba de vida y el registro.
5. Confirma en pantalla el resultado antes de continuar. Si falla, revisa el mensaje y vuelve a intentar según las indicaciones.

Si la identificación coincide y el evento queda guardado, la pantalla muestra **Asistencia registrada**. Una captura o un rostro encuadrado no equivalen a una asistencia confirmada.

### Salir de la pantalla de captura

Con una sesión activa, salir del modo de cámara puede pedir la contraseña del Instructor responsable o del Instructor de reemplazo configurado. Selecciona a quién corresponde la contraseña e ingrésala. Si no valida, permanece en el flujo y consulta al responsable.

### Cierre de jornada

La sesión puede cerrarse automáticamente a la hora de apagado configurada. Si la cámara queda bloqueada o el servicio informa una falla, registra el momento y comunícalo al Coordinador o soporte. No marques asistencia manualmente desde otra cuenta.

---

## 6. Aprendiz: registrar tu rostro

El registro facial inicial se realiza desde la versión web. FaceLit consulta primero si ya existe un registro y si puedes iniciar una captura. Si la verificación no está disponible, espera o consulta al Coordinador.

### Primer registro

1. Inicia sesión con tu cuenta y abre **Reconocimiento facial**.
2. Confirma que el nombre de la pantalla sea el tuyo y acepta el aviso antes de continuar.
3. Permite el acceso a la cámara del navegador. Ubícate solo frente a la cámara, con el rostro visible y buena luz.
4. Sigue los dos retos aleatorios de prueba de vida. Cada reto puede pedir mirar arriba o abajo, acercarte o alejarte.
5. Revisa el mensaje de validación y espera la confirmación de registro completado.

No cierres la página mientras se procesa la validación. Si la imagen no es clara o un reto falla, sigue el aviso en pantalla y repite la captura.

### Ya tengo un registro y necesito cambiarlo

Solicita el nuevo registro desde la pantalla facial. Espera la revisión del Coordinador. Cuando se apruebe, vuelve a la página y completa la captura autorizada. La autorización es necesaria para reemplazar un rostro ya registrado; no intentes usar la captura normal para sustituirlo.

Si la solicitud queda pendiente o no ves el resultado, no la envíes repetidamente. Comunica al Coordinador la fecha y el estado que aparece.

> La función facial no está disponible en el flujo móvil actual. Si el celular muestra el aviso de no disponibilidad, usa la versión web desde un equipo con cámara.

---

## 7. Consultar asistencia y resolver problemas

### Aprendiz

Abre **Mi asistencia** para consultar el historial y el detalle que esté disponible en tu cuenta. Si un registro parece incorrecto, anota fecha, jornada y ambiente y solicita revisión al Instructor. No puedes modificar tus propios estados de asistencia desde esta pantalla.

### Instructor y Coordinador

El Instructor consulta la asistencia de sus fichas y aprendices dentro de las opciones disponibles. El Coordinador consulta las vistas administrativas. Usa filtros para ubicar la ficha, persona o jornada y revisa el detalle antes de reportar una novedad.

### Situaciones frecuentes

| Situación | Qué hacer |
|---|---|
| No puedo iniciar sesión | Revisa documento y contraseña. Usa recuperación o solicita apoyo al Coordinador. |
| La cámara no aparece | Usa la versión web, permite la cámara en el navegador y vuelve a abrir el flujo. |
| Reto facial no validado | Mejora la luz, deja solo un rostro visible y sigue exactamente la instrucción. |
| No se confirma asistencia | Espera el resultado. Revisa ficha, sesión, registro facial y conexión; informa al Instructor. |
| No encuentro ficha o ambiente | Confirma la asignación y pide al Coordinador revisar la información académica. |
| La sesión no permite salir | Confirma la contraseña del Instructor responsable o reemplazo configurado. |

### Uso responsable de tus datos

- Usa tu propia cuenta y rostro; no compartas contraseñas.
- No registres fotos de otras personas, impresiones ni imágenes mostradas en una pantalla.
- No envíes contraseñas ni fotografías faciales en reportes de soporte.
- En capturas de pantalla, oculta documentos, correos y datos de otras personas.

Al reportar una falla, indica tu rol, dispositivo/navegador, pantalla, fecha, hora y mensaje visible.
