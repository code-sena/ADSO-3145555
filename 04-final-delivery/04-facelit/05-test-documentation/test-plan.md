# FaceLit

## Plan de pruebas

**Validación funcional, integración, seguridad y experiencia de usuario**

**Autoras:**
- Maria José Rodriguez Oyola
- Valery Sinaí Trujillo Quintero
- Mariana Valenzuela Penagos

**SENA**
Análisis y Desarrollo de Software
Ficha 3145555
Instructor: José de Jesús Motta
Versión 1.0 · 12 de octubre de 2026

*Documento de planificación y registro de evidencia disponible*

---

## Índice

| Sección | Página |
|---|---|
| 1. Objetivos y alcance | 3 |
| 2. Estrategia y criterios de aceptación | 4 |
| 3. Entorno, datos y responsables | 5 |
| 4. Casos CP-001 a CP-030 | 6 a 15 |
| 5. Registro de ejecución y defectos | 16 |
| 6. Evidencias recibidas y trazabilidad | 17 |
| 7. Cierre y fuentes | 18 |

El plan describe qué comprobar, con qué datos y cómo decidir el resultado. Los casos tienen procedimientos, resultados esperados y un registro inicial de ejecución. La evidencia recibida se distingue de las pruebas aún pendientes.

### Convención de estado

- **Aprobado:** ejecución documentada que cumple todos los criterios.
- **Fallido:** ejecución documentada que incumple al menos un criterio.
- **No ejecutado:** todavía no se dispone de ejecución completa.
- **Bloqueado:** no puede ejecutarse por una dependencia o condición registrada.

Los 30 casos quedan inicialmente como No ejecutado. Dos capturas aportan observaciones parciales para la carga CSV y la notificación de finalización; no se convierten automáticamente en casos aprobados.

---

## 1. Objetivos y alcance

### Objetivo general

Comprobar que FaceLit registra y consulta información académica y asistencia de forma coherente, aplica los permisos de coordinador, instructor y aprendiz y comunica correctamente los resultados de las operaciones.

### Objetivos específicos

Validar acceso y recuperación; verificar altas manuales y carga CSV; comprobar asociaciones y traslados; evaluar enrolamiento y verificación facial; confirmar persistencia y notificaciones; revisar contenido, videos, navegación y adaptación de la landing; documentar errores y repetir pruebas después de correcciones.

### Dentro del alcance

Frontend web y recorridos pertinentes en Android; APIs Java y Python; PostgreSQL y su integridad; permisos por rol; sesión y asistencia; notificaciones de aplicación y correo configurado; captura de cámara; landing explicativa, animaciones y videos disponibles.

### Fuera del alcance

Raspberry Pi y el módulo de horarios retirado; calificaciones y pagos; garantía universal de precisión biométrica o resistencia a suplantación; pruebas contra servicios ajenos. Las mediciones se realizan en un entorno controlado, sin afectar usuarios reales.

### Límite de esta entrega

Esta entrega prepara el plan y organiza evidencia del PDF aportado. No ejecuta FaceLit, no mide producción ni dispone de reportes automatizados. La landing y Face Mesh deben contrastarse con la versión a probar; una demostración HTML o una descripción no demuestra su integración en la aplicación.

---

## 2. Estrategia y aceptación

| Tipo | Qué se evalúa |
|---|---|
| Funcional | Credenciales, usuarios, fichas, sesiones, asistencia y estados de interfaz. |
| Integración | Recorrido interfaz → Java/Python → PostgreSQL y coherencia del resultado. |
| Seguridad | Token, roles, propiedad del recurso y ausencia de credenciales en evidencias. |
| Unitarias | Reglas aisladas, validadores CSV, conversión de tipos y manejo de respuestas; registrar reportes reales si existen. |
| Rendimiento | Latencia, errores y carga con parámetros acordados antes de ejecutar. |
| Usabilidad y accesibilidad | Permisos de cámara, foco, teclado, mensajes, lectura y movimiento reducido. |
| Regresión | Repetir recorridos afectados por una corrección y sus dependencias. |

### Condiciones de inicio

Identificar versión/commit y URLs de prueba; migraciones aplicadas; usuarios de cada rol; fichas y sesiones controladas; cámara disponible; correo de prueba; servicios accesibles; responsables confirmados y autorización para usar imágenes de prueba.

### Criterios de aprobación

Cada caso cumple su resultado esperado, conserva coherencia persistente y adjunta evidencia suficiente. Rechazar una operación inválida puede ser un resultado aprobado. Una pantalla con éxito y sin persistencia no basta. La respuesta exacta y el criterio de rendimiento deben ajustarse al contrato y SRS vigente antes de ejecutar.

### Criterios de salida

Ejecutar los casos aplicables; no dejar defectos críticos/altos abiertos en acceso, aislamiento de roles o asistencia; documentar riesgos aceptados, bloqueos y casos no aplicables; repetir los fallidos corregidos; emitir acta final con evidencias y responsables. No declarar aprobación global con resultados pendientes.

---

## 3. Entorno, datos y responsables

| Dato sintético | Uso |
|---|---|
| COOR-01 / INST-01 / APR-01 / APR-02 | Cuentas aisladas de los tres roles. Contraseñas fuera del informe. |
| PROG-T01 / FICHA-T01 / FICHA-T02 | Programa, ficha origen/destino y asociaciones verificables. |
| DOC-APR-01 / DOC-APR-02 | Documentos ficticios válidos según reglas; nunca de personas reales. |
| CSV-VALIDO / CSV-INVALIDO / CSV-DUP | Columnas según plantilla vigente; filas nuevas, errores y duplicados. |
| SES-ABIERTA / SES-CERRADA | Contextos de sesión definidos por reglas vigentes. |
| IMG-01 / IMG-02 / IMG-SIN / IMG-MULTI | Imágenes consentidas: mismo aprendiz, otra persona, sin rostro y varios rostros. |
| MAIL-TEST / VIDEO-TEST | Buzón controlado y tutorial de prueba autorizado. |

Preparar primero los datos y registrar sus identificadores reales de prueba. Los alias anteriores no son nombres de columnas ni valores para pegar directamente en una base productiva. No incluir contraseñas, JWT o embeddings en capturas.

### Asignación propuesta para confirmar

- **Maria José Rodriguez Oyola:** backend, permisos, sesiones y correo.
- **Mariana Valenzuela Penagos:** base de datos, carga académica, asociaciones y persistencia.
- **Valery Sinaí Trujillo Quintero:** frontend, aprendiz, cámara y landing.

La asignación es propuesta; no identifica quién ejecutó las capturas recibidas.

### Registro obligatorio del entorno

Fecha/hora y zona; ejecutora; versión/commit; navegador y sistema operativo; dispositivo; URL; versión de esquema; estado de Java/Python; modalidad web/Android; datos utilizados. Repetir en cada entorno aplicable y separar resultados.

---

## 4. Casos de prueba

> En todos los casos, el campo **Datos / precondición** incluye "entorno de la sección 3 preparado", y el campo **Evidencia a registrar** sigue el patrón `CP-0XX_fecha_entorno; respuesta y persistencia cuando aplique`. Salvo indicación contraria, el **resultado obtenido** de cada caso es "No ejecutado; sin resultado registrado" y su **estado** es "No ejecutado".

### 4.1. Casos CP-001 a CP-003

#### CP-001 · Acceso válido por rol
- **Tipo:** Funcional / seguridad. **Responsable propuesto:** Maria José.
- **Datos / precondición:** COOR-01, INST-01, APR-01; entorno de la sección 3 preparado.
- **Procedimiento:** Iniciar sesión con cada cuenta activa; revisar panel y una operación permitida.
- **Resultado esperado:** Permite acceso y abre el panel del rol asignado; el token habilita solo operaciones autorizadas.
- **Resultado obtenido:** No ejecutado; sin resultado registrado.
- **Estado:** No ejecutado. **Evidencia a registrar:** CP-001_fecha_entorno; respuesta y persistencia cuando aplique.

#### CP-002 · Contraseña incorrecta
- **Tipo:** Funcional / seguridad. **Responsable propuesto:** Maria José.
- **Datos / precondición:** APR-01 y contraseña errónea; entorno de la sección 3 preparado.
- **Procedimiento:** Intentar acceder con contraseña incorrecta; revisar mensaje y estado de sesión.
- **Resultado esperado:** Rechaza el acceso, no crea sesión válida y no expone detalles internos.
- **Resultado obtenido:** No ejecutado; sin resultado registrado.
- **Estado:** No ejecutado. **Evidencia a registrar:** CP-002_fecha_entorno; respuesta y persistencia cuando aplique.

#### CP-003 · API sin token o con token inválido
- **Tipo:** Seguridad / API. **Responsable propuesto:** Maria José.
- **Datos / precondición:** Ruta protegida y token ficticio; entorno de la sección 3 preparado.
- **Procedimiento:** Solicitar una ruta protegida sin token y con token inválido o vencido.
- **Resultado esperado:** Rechaza la solicitud con respuesta de autenticación conforme al contrato; no devuelve datos protegidos.
- **Resultado obtenido:** No ejecutado; sin resultado registrado.
- **Estado:** No ejecutado. **Evidencia a registrar:** CP-003_fecha_entorno; respuesta y persistencia cuando aplique.

### 4.2. Casos CP-004 a CP-006

#### CP-004 · Recuperación de contraseña
- **Tipo:** Integración / correo. **Responsable propuesto:** Maria José.
- **Datos / precondición:** MAIL-TEST y código vigente/vencido; entorno de la sección 3 preparado.
- **Procedimiento:** Solicitar recuperación; comprobar correo; probar código válido y luego reutilizado o vencido.
- **Resultado esperado:** Código válido permite el flujo previsto; vencido o usado se rechaza y no modifica la contraseña.
- **Resultado obtenido:** No ejecutado; sin resultado registrado.
- **Estado:** No ejecutado. **Evidencia a registrar:** CP-004_fecha_entorno; respuesta y persistencia cuando aplique.

#### CP-005 · Alta manual de aprendiz e instructor
- **Tipo:** Funcional / persistencia. **Responsable propuesto:** Mariana.
- **Datos / precondición:** APR-02, INST-02 y documentos nuevos; entorno de la sección 3 preparado.
- **Procedimiento:** Crear ambos usuarios como coordinador; recargar; consultar sus relaciones en la base.
- **Resultado esperado:** Usuarios y datos académicos requeridos quedan persistidos con rol correcto y sin duplicados.
- **Resultado obtenido:** No ejecutado; sin resultado registrado.
- **Estado:** No ejecutado. **Evidencia a registrar:** CP-005_fecha_entorno; respuesta y persistencia cuando aplique.

#### CP-006 · Carga de CSV válido
- **Tipo:** Integración / académica. **Responsable propuesto:** Mariana.
- **Datos / precondición:** CSV-VALIDO con cantidades conocidas; entorno de la sección 3 preparado.
- **Procedimiento:** Cargar archivo; comparar resumen con filas; verificar usuarios y asociaciones en PostgreSQL.
- **Resultado esperado:** Los conteos coinciden con los datos de prueba y la persistencia; las credenciales no se publican en evidencias.
- **Resultado obtenido:** Evidencia parcial EV-001: interfaz muestra 29 creados y 0 actualizados/errores. Falta cotejo del archivo y persistencia.
- **Estado:** No ejecutado. **Evidencia a registrar:** CP-006_fecha_entorno; respuesta y persistencia cuando aplique.

### 4.3. Casos CP-007 a CP-009

#### CP-007 · CSV inválido
- **Tipo:** Funcional / validación. **Responsable propuesto:** Mariana.
- **Datos / precondición:** CSV-INVALIDO; entorno de la sección 3 preparado.
- **Procedimiento:** Cargar filas con documento o campos obligatorios inválidos; comparar errores y persistencia.
- **Resultado esperado:** Informa errores identificables y respeta la política de carga/atomicidad definida en el contrato vigente.
- **Resultado obtenido:** No ejecutado; sin resultado registrado.
- **Estado:** No ejecutado. **Evidencia a registrar:** CP-007_fecha_entorno; respuesta y persistencia cuando aplique.

#### CP-008 · Usuarios o filas duplicados
- **Tipo:** Integridad / regresión. **Responsable propuesto:** Mariana.
- **Datos / precondición:** CSV-DUP y documento existente; entorno de la sección 3 preparado.
- **Procedimiento:** Intentar alta manual duplicada y carga repetida; revisar usuarios y asociaciones.
- **Resultado esperado:** Se impiden duplicados o se aplica actualización documentada; no se crean asociaciones incoherentes.
- **Resultado obtenido:** No ejecutado; sin resultado registrado.
- **Estado:** No ejecutado. **Evidencia a registrar:** CP-008_fecha_entorno; respuesta y persistencia cuando aplique.

#### CP-009 · Programas, fichas y asociaciones
- **Tipo:** Funcional / integración. **Responsable propuesto:** Mariana.
- **Datos / precondición:** PROG-T01, FICHA-T01, INST-01, APR-01; entorno de la sección 3 preparado.
- **Procedimiento:** Crear contexto académico; asociar usuarios; recargar y comparar relaciones en base.
- **Resultado esperado:** La ficha pertenece al programa y las asociaciones activas coinciden con lo mostrado.
- **Resultado obtenido:** No ejecutado; sin resultado registrado.
- **Estado:** No ejecutado. **Evidencia a registrar:** CP-009_fecha_entorno; respuesta y persistencia cuando aplique.

### 4.4. Casos CP-010 a CP-012

#### CP-010 · Traslado de aprendiz
- **Tipo:** Integración / integridad. **Responsable propuesto:** Mariana.
- **Datos / precondición:** APR-01 y FICHA-T01 → FICHA-T02; entorno de la sección 3 preparado.
- **Procedimiento:** Trasladar como coordinador; revisar ficha actual, asociación previa e historial.
- **Resultado esperado:** Se conserva historial y una situación académica coherente conforme a las reglas de traslado.
- **Resultado obtenido:** No ejecutado; sin resultado registrado.
- **Estado:** No ejecutado. **Evidencia a registrar:** CP-010_fecha_entorno; respuesta y persistencia cuando aplique.

#### CP-011 · Permisos entre roles
- **Tipo:** Seguridad / autorización. **Responsable propuesto:** Maria José.
- **Datos / precondición:** Tres cuentas y operación de coordinación; entorno de la sección 3 preparado.
- **Procedimiento:** Intentar la operación con coordinador, instructor y aprendiz desde UI y API.
- **Resultado esperado:** Solo el rol permitido ejecuta la operación; esconder botones no es el único control.
- **Resultado obtenido:** No ejecutado; sin resultado registrado.
- **Estado:** No ejecutado. **Evidencia a registrar:** CP-011_fecha_entorno; respuesta y persistencia cuando aplique.

#### CP-012 · Consulta de datos propios
- **Tipo:** Seguridad / aislamiento. **Responsable propuesto:** Maria José.
- **Datos / precondición:** APR-01 y APR-02; entorno de la sección 3 preparado.
- **Procedimiento:** Consultar perfil/asistencia propia; intentar recurso ajeno cambiando identificador.
- **Resultado esperado:** No permite obtener ni modificar datos de otro aprendiz fuera de los permisos previstos.
- **Resultado obtenido:** No ejecutado; sin resultado registrado.
- **Estado:** No ejecutado. **Evidencia a registrar:** CP-012_fecha_entorno; respuesta y persistencia cuando aplique.

### 4.5. Casos CP-013 a CP-015

#### CP-013 · Instructor y fichas asignadas
- **Tipo:** Funcional / permisos. **Responsable propuesto:** Valery.
- **Datos / precondición:** INST-01 con ficha asignada/no asignada; entorno de la sección 3 preparado.
- **Procedimiento:** Consultar grupos; intentar operar sobre una ficha no asignada desde UI y API.
- **Resultado esperado:** Muestra datos autorizados y restringe acciones sobre recursos no asignados según la política vigente.
- **Resultado obtenido:** No ejecutado; sin resultado registrado.
- **Estado:** No ejecutado. **Evidencia a registrar:** CP-013_fecha_entorno; respuesta y persistencia cuando aplique.

#### CP-014 · Ambiente y contexto de sesión
- **Tipo:** Funcional / integración. **Responsable propuesto:** Maria José.
- **Datos / precondición:** FICHA-T01 y ambiente de prueba; entorno de la sección 3 preparado.
- **Procedimiento:** Crear/configurar sesión con datos válidos y luego inválidos; recargar el contexto.
- **Resultado esperado:** Guarda la configuración válida y rechaza incoherencias; las reglas utilizadas quedan identificadas.
- **Resultado obtenido:** No ejecutado; sin resultado registrado.
- **Estado:** No ejecutado. **Evidencia a registrar:** CP-014_fecha_entorno; respuesta y persistencia cuando aplique.

#### CP-015 · Permiso de cámara denegado
- **Tipo:** Usabilidad / error. **Responsable propuesto:** Valery.
- **Datos / precondición:** Navegador/dispositivo sin permiso; entorno de la sección 3 preparado.
- **Procedimiento:** Abrir captura y denegar acceso a cámara; intentar reactivar permiso.
- **Resultado esperado:** Muestra instrucciones y permite recuperación; no afirma captura o asistencia exitosa.
- **Resultado obtenido:** No ejecutado; sin resultado registrado.
- **Estado:** No ejecutado. **Evidencia a registrar:** CP-015_fecha_entorno; respuesta y persistencia cuando aplique.

### 4.6. Casos CP-016 a CP-018

#### CP-016 · Enrolamiento con un rostro
- **Tipo:** Integración / facial. **Responsable propuesto:** Valery.
- **Datos / precondición:** APR-01 e IMG-01; entorno de la sección 3 preparado.
- **Procedimiento:** Registrar rostro; comprobar respuesta Python y referencia persistida; recargar estado.
- **Resultado esperado:** Confirma solo después de respuesta válida y vincula referencia al aprendiz; no crea asistencia por enrolar.
- **Resultado obtenido:** No ejecutado; sin resultado registrado.
- **Estado:** No ejecutado. **Evidencia a registrar:** CP-016_fecha_entorno; respuesta y persistencia cuando aplique.

#### CP-017 · Captura sin rostro o con varios
- **Tipo:** Funcional / facial. **Responsable propuesto:** Valery.
- **Datos / precondición:** IMG-SIN e IMG-MULTI; entorno de la sección 3 preparado.
- **Procedimiento:** Enviar ambas capturas al flujo; revisar respuesta y estado de referencia.
- **Resultado esperado:** Rechaza entradas incompatibles con el requisito de un rostro y no sobrescribe una referencia válida.
- **Resultado obtenido:** No ejecutado; sin resultado registrado.
- **Estado:** No ejecutado. **Evidencia a registrar:** CP-017_fecha_entorno; respuesta y persistencia cuando aplique.

#### CP-018 · Registro facial incompleto
- **Tipo:** Integración / resiliencia. **Responsable propuesto:** Valery.
- **Datos / precondición:** APR-02 y desconexión controlada; entorno de la sección 3 preparado.
- **Procedimiento:** Interrumpir envío/persistencia; observar mensaje y reintentar el proceso.
- **Resultado esperado:** No muestra éxito sin confirmación; permite reintento y no deja datos incoherentes.
- **Resultado obtenido:** No ejecutado; sin resultado registrado.
- **Estado:** No ejecutado. **Evidencia a registrar:** CP-018_fecha_entorno; respuesta y persistencia cuando aplique.

### 4.7. Casos CP-019 a CP-021

#### CP-019 · Malla facial y movimiento reducido
- **Tipo:** Frontend / accesibilidad. **Responsable propuesto:** Valery.
- **Datos / precondición:** Captura y preferencia de movimiento reducido; entorno de la sección 3 preparado.
- **Procedimiento:** Si Face Mesh está integrado, verificar landmarks con rostro/sin rostro; probar alternativa de movimiento.
- **Resultado esperado:** La ayuda visual corresponde al estado de captura; no equivale a identidad verificada. Si no está integrado, registrar bloqueo.
- **Resultado obtenido:** No ejecutado; sin resultado registrado.
- **Estado:** No ejecutado. **Evidencia a registrar:** CP-019_fecha_entorno; respuesta y persistencia cuando aplique.

#### CP-020 · Verificación válida en sesión
- **Tipo:** Integración / asistencia. **Responsable propuesto:** Maria José.
- **Datos / precondición:** SES-ABIERTA, APR-01 e IMG-01; entorno de la sección 3 preparado.
- **Procedimiento:** Capturar aprendiz enrolado y asociado; comprobar respuesta Java/Python, evento y consulta.
- **Resultado esperado:** La coincidencia válida participa en el registro conforme a reglas de sesión y se vincula al aprendiz correcto.
- **Resultado obtenido:** No ejecutado; sin resultado registrado.
- **Estado:** No ejecutado. **Evidencia a registrar:** CP-020_fecha_entorno; respuesta y persistencia cuando aplique.

#### CP-021 · No coincidencia o ficha ajena
- **Tipo:** Seguridad / facial. **Responsable propuesto:** Maria José.
- **Datos / precondición:** IMG-02 y aprendiz no asociado; entorno de la sección 3 preparado.
- **Procedimiento:** Comparar rostro diferente y rostro enrolado fuera de la ficha de sesión.
- **Resultado esperado:** No registra asistencia para una identidad incorrecta ni incluye candidatos fuera del contexto permitido.
- **Resultado obtenido:** No ejecutado; sin resultado registrado.
- **Estado:** No ejecutado. **Evidencia a registrar:** CP-021_fecha_entorno; respuesta y persistencia cuando aplique.

### 4.8. Casos CP-022 a CP-024

#### CP-022 · Sesión cerrada y duplicidad
- **Tipo:** Integridad / asistencia. **Responsable propuesto:** Maria José.
- **Datos / precondición:** SES-CERRADA y evento repetido; entorno de la sección 3 preparado.
- **Procedimiento:** Intentar registro fuera de sesión permitida; repetir mismo evento en una sesión válida.
- **Resultado esperado:** Rechaza contexto no permitido y evita duplicados activos por sesión, aprendiz y tipo según reglas vigentes.
- **Resultado obtenido:** No ejecutado; sin resultado registrado.
- **Estado:** No ejecutado. **Evidencia a registrar:** CP-022_fecha_entorno; respuesta y persistencia cuando aplique.

#### CP-023 · Consulta de asistencia persistida
- **Tipo:** Integración / regresión. **Responsable propuesto:** Mariana.
- **Datos / precondición:** Evento conocido de CP-020; entorno de la sección 3 preparado.
- **Procedimiento:** Recargar/nueva sesión de acceso; consultar como instructor y aprendiz; contrastar base.
- **Resultado esperado:** Los registros persistidos coinciden con sesión y usuario; no son solo datos locales de demostración.
- **Resultado obtenido:** No ejecutado; sin resultado registrado.
- **Estado:** No ejecutado. **Evidencia a registrar:** CP-023_fecha_entorno; respuesta y persistencia cuando aplique.

#### CP-024 · Solicitud de restablecimiento facial
- **Tipo:** Funcional / integración. **Responsable propuesto:** Valery.
- **Datos / precondición:** APR-01 con referencia existente; entorno de la sección 3 preparado.
- **Procedimiento:** Crear solicitud; consultar con cuenta autorizada y resolver; probar recorrido posterior.
- **Resultado esperado:** La solicitud persiste y su resolución habilita el flujo definido; comprobar cuentas distintas, no solo estado local.
- **Resultado obtenido:** No ejecutado; sin resultado registrado.
- **Estado:** No ejecutado. **Evidencia a registrar:** CP-024_fecha_entorno; respuesta y persistencia cuando aplique.

### 4.9. Casos CP-025 a CP-027

#### CP-025 · Notificación de carga CSV
- **Tipo:** Integración / notificaciones. **Responsable propuesto:** Maria José.
- **Datos / precondición:** CSV-VALIDO y cuenta destinataria; entorno de la sección 3 preparado.
- **Procedimiento:** Cargar; consultar notificación; recargar; comprobar destinatario, contenido y vínculo persistente.
- **Resultado esperado:** La notificación corresponde a la operación y llega solo a destinatarios definidos; no se presupone aviso a todos.
- **Resultado obtenido:** Evidencia parcial EV-002: se observa "Carga de CSV finalizada", con 29 creados y canal Solo app. Falta trazabilidad completa.
- **Estado:** No ejecutado. **Evidencia a registrar:** CP-025_fecha_entorno; respuesta y persistencia cuando aplique.

#### CP-026 · Correo de notificación y fallo SMTP
- **Tipo:** Integración / resiliencia. **Responsable propuesto:** Maria José.
- **Datos / precondición:** MAIL-TEST y evento APP_EMAIL; entorno de la sección 3 preparado.
- **Procedimiento:** Generar evento; comprobar buzón y estado; simular fallo controlado y revisar reintentos.
- **Resultado esperado:** Correo recibido o fallo registrado sin falso éxito; reintentos coinciden con la configuración vigente.
- **Resultado obtenido:** No ejecutado; sin resultado registrado.
- **Estado:** No ejecutado. **Evidencia a registrar:** CP-026_fecha_entorno; respuesta y persistencia cuando aplique.

#### CP-027 · Contenido y navegación de landing
- **Tipo:** Funcional / contenido. **Responsable propuesto:** Valery.
- **Datos / precondición:** Textos finales aprobados; entorno de la sección 3 preparado.
- **Procedimiento:** Recorrer enlaces y botones; revisar tres roles, etiquetas, explicación facial y destino de acceso.
- **Resultado esperado:** Contenido aprobado, sin "sistema SENA", sin cuarto rol ni promesas no medidas; enlaces llevan al destino previsto.
- **Resultado obtenido:** No ejecutado; sin resultado registrado.
- **Estado:** No ejecutado. **Evidencia a registrar:** CP-027_fecha_entorno; respuesta y persistencia cuando aplique.

### 4.10. Casos CP-028 a CP-030

#### CP-028 · Videos y modal accesible
- **Tipo:** Usabilidad / accesibilidad. **Responsable propuesto:** Valery.
- **Datos / precondición:** VIDEO-TEST y teclado; entorno de la sección 3 preparado.
- **Procedimiento:** Abrir video, reproducir, cerrar con botón/Escape y volver al disparador; probar recurso ausente.
- **Resultado esperado:** Controles y subtítulos disponibles; foco correcto; video se detiene al cerrar; recurso ausente no simula reproducción.
- **Resultado obtenido:** No ejecutado; sin resultado registrado.
- **Estado:** No ejecutado. **Evidencia a registrar:** CP-028_fecha_entorno; respuesta y persistencia cuando aplique.

#### CP-029 · Responsive, traducciones y animación
- **Tipo:** Frontend / regresión. **Responsable propuesto:** Valery.
- **Datos / precondición:** 360×800, 768×1024, 1440×900 e idiomas; entorno de la sección 3 preparado.
- **Procedimiento:** Recorrer vistas y landing; cambiar idioma/tema; activar movimiento reducido; navegar por teclado.
- **Resultado esperado:** Sin desbordes ni claves sin traducir; controles legibles; contenido accesible sin animaciones.
- **Resultado obtenido:** No ejecutado; sin resultado registrado.
- **Estado:** No ejecutado. **Evidencia a registrar:** CP-029_fecha_entorno; respuesta y persistencia cuando aplique.

#### CP-030 · Rendimiento y caída del servicio
- **Tipo:** Rendimiento / integración. **Responsable propuesto:** Maria José.
- **Datos / precondición:** Entorno aislado; 1/5/10 usuarios; lote controlado; entorno de la sección 3 preparado.
- **Procedimiento:** Acordar umbrales del SRS; medir latencias p50/p95 y errores; simular caída Java/Python.
- **Resultado esperado:** Cumple umbrales previamente aprobados; fallos informados sin registros falsos. Sin umbrales, resultado No evaluable.
- **Resultado obtenido:** No ejecutado; sin resultado registrado.
- **Estado:** No ejecutado. **Evidencia a registrar:** CP-030_fecha_entorno; respuesta y persistencia cuando aplique.

---

## 5. Registro de ejecución y defectos

Completar esta ficha por cada ejecución. Un mismo caso puede tener resultados distintos en web, Android o después de una corrección; conservar los intentos previos.

| Campo | Registro inicial |
|---|---|
| Caso / intento | CP-___ / intento ___ |
| Fecha hora / entorno / versión | Pendiente de registrar |
| Responsable real | Pendiente de confirmar |
| Datos utilizados | Alias e identificadores de prueba |
| Resultado esperado | Referencia al caso correspondiente |
| Resultado obtenido | Descripción concreta de lo observado; no copiar el esperado |
| Estado | Aprobado / Fallido / No ejecutado / Bloqueado |
| Evidencia | Nombre, ruta y contexto del archivo |
| Defecto / repetición | DEF-___; pasos, prioridad y resultado de reejecución |

### Gestión de defectos

Registrar identificador, caso, precondiciones, pasos, esperado/obtenido, evidencia, versión, responsable de corrección y severidad. **Crítico:** exposición o corrupción grave; **alto:** bloquea flujo central; **medio:** función afectada con alternativa; **bajo:** problema visual menor. Reejecutar el caso y recorridos relacionados después de corregir.

### Resumen actual

30 casos planificados; 0 aprobados acreditados; 0 fallidos acreditados; 30 no ejecutados; 2 evidencias visuales parciales. Esta distribución refleja la documentación disponible, no un porcentaje de calidad o de implementación del sistema.

---

## 6. Evidencias y trazabilidad

El PDF adjunto contiene dos páginas con capturas y una página vacía. Se incorporan fragmentos reales relevantes; se omiten listados que muestran datos personales o credenciales. No son imágenes generadas ni una nueva ejecución del sistema.

### EV-001 · Resumen de carga CSV

> **[Imagen — captura EV-001]** Pantalla de FaceLit "Cargar información académica (CSV)" ("Carga programas, fichas, aprendices e instructores desde un solo archivo"), con el panel desplegable "Guía de columnas" y cuatro indicadores:
>
> | Creados | Actualizados | Inconsistencias bloqueadas | Errores |
> |---|---|---|---|
> | 29 | 0 | 0 | 0 |

Origen: página 1 del adjunto. Se observa la pantalla de carga y un resumen de 29 creados, 0 actualizados y 0 errores. Vinculación: CP-006. No demuestra por sí solo qué filas se procesaron ni toda la persistencia.

### EV-002 · Notificación de finalización

> **[Imagen — captura EV-002]** Pantalla "Centro de Notificaciones" de FaceLit, con filtros "Todas / No leídas / Leídas" y categorías "Todas, Carga CSV, Traslados, Asistencia, Gestión Académica, Seguridad, Reconocimiento Facial". Notificación expandida **"Carga de CSV finalizada"**: "Carga finalizada: 29 creados, 0 actualizados, 0 pendientes de confirmación y 0 errores." Fecha: 9 oct 2026 · 15:26. Detalle: Creados 29; Actualizados 0; Bloqueados 0; Errores 0; Canal: Solo app.

Origen: página 2 del adjunto. Se observa "Carga de CSV finalizada", 29 creados y canal Solo app. Vinculación: CP-025. No demuestra envío SMTP ni notificación individual a cada usuario del archivo.

Las capturas de PostgreSQL del adjunto muestran consultas y filas, pero no permiten atribuirlas de forma reproducible a una ejecución controlada. Para cerrar CP-006 y CP-025 deben correlacionarse con datos, versión, hora y destinatario.

---

## 7. Cierre y fuentes

### Organización de la entrega

- `07_Pruebas/Plan_Pruebas.pdf`: objetivos, criterios y casos.
- `07_Pruebas/Evidencias/Evidencias_Disponibles.pdf`: fragmentos de capturas reales, alcance y trazabilidad.

### Cómo incorporar evidencia nueva

Guardar archivos por caso y ejecución: `CP-006_2026-10-12_web_intento01.pdf`. Incluir contexto, pasos y resultado; para API, petición/respuesta sin secretos; para pruebas automatizadas, comando, versión, reporte y fallos. Separar esperado y observado. No usar imágenes ilustrativas como prueba de funcionamiento.

### Ejecución recomendada

Primero acceso, roles y datos; después carga y asociaciones; luego cámara, enrolamiento y asistencia; finalmente notificaciones y landing. Confirmar dependencia Java/Python/base antes del flujo facial. Repetir en Android los recorridos aplicables; los efectos web y modal se validan en navegador.

### Decisión de entrega

El plan está preparado para ejecución. La aceptación del software permanece pendiente hasta completar criterios y adjuntar resultados. Los problemas de cámara, registro y traducciones reportados anteriormente requieren regresión; no se consideran resueltos por este documento sin evidencia de la versión actual.

### Fuentes

1. `Documento sin título.pdf`, adjunto del equipo: capturas de carga CSV, notificación y consultas de base; tres páginas.
2. Contenido de la landing page de FaceLit, suministrado en esta solicitud: funciones por rol, acceso, videos y descripción facial.
3. Documentación técnica compartida en la conversación: monolito Java por módulos/capas, PostgreSQL/Liquibase y microservicio Python con InsightFace. Los casos y criterios de este plan son una propuesta de validación, no reportes de ejecución.

### Responsables y aprobación final

- **Ejecutoras propuestas:** Maria José Rodriguez Oyola, Mariana Valenzuela Penagos y Valery Sinaí Trujillo Quintero. Confirmación de responsables: pendiente.
- **Revisión del plan:** pendiente.
- **Aprobación de resultados:** pendiente.
- **Fecha de cierre:** pendiente.
