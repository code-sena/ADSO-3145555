# FaceLit / Frontend

## MoSCoW actualizado

**Prioridades funcionales y estado técnico del proyecto**

| Fecha de referencia | Base de código consultada |
|---|---|
| 4 noviembre 2026 | FaceLit `6efd92c` (`main`); Backend `2ba7398` (`main`); micro-facial `166e4a7` (`main`); FaceLit-DB `cd069ae` (`main`). |

Esta edición actualiza la referencia de código a `main` y conserva el inventario de 74 elementos como anexo histórico de priorización. El 4 de noviembre el equipo confirmó que los flujos de acceso, CSV, cámara, asistencia y correo funcionan en el sistema. Las prioridades no equivalen por sí solas a estado de cumplimiento. Las etiquetas de evidencia del anexo se levantaron en FaceLit `724124e` y no se vuelven a certificar aquí elemento por elemento.

---

## 1. Prioridad MoSCoW

| Prioridad | Elementos | Interpretación |
|---|---|---|
| Must Have | 35 | Núcleo necesario para el recorrido de entrega. Un Must pendiente sigue siendo brecha. |
| Should Have | 23 | Importante para operación/calidad; requiere decisión explícita si se difiere. |
| Could Have | 8 | Complemento que puede posponerse si no afecta el recorrido acordado. |
| Won't Have | 8 | Fuera de esta propuesta de versión; no significa prohibición futura. |

> La suma sigue siendo 74 (35 + 23 + 8 + 8). Se conserva la clasificación funcional propuesta en el documento original; cualquier cambio de prioridad requiere acuerdo del equipo y trazabilidad al SRS aprobado.

---

## 2. Estado técnico que afecta las prioridades

| Área de entrega | Estado funcional reportado al 4 de noviembre | Verificación complementaria |
|---|---|---|
| Acceso y roles | Funcionan el inicio de sesión y los accesos de Coordinador, Instructor y Aprendiz. | Mantener trazabilidad de requisitos y permisos definidos por el SRS. |
| Gestión académica / CSV | La carga CSV funciona. | Conservar plantillas y datos de demostración controlados. |
| Enrolamiento y asistencia facial | Funcionan la cámara, el enrolamiento y la asistencia. El flujo usa 4 retos activos, 2 distintos por secuencia y 7 imágenes por reto. | El umbral 0.65 es similitud, no una medición de precisión biométrica. |
| Notificaciones / tiempo real | Funcionan correo SMTP y WebSocket en el sistema. | Las pruebas automatizadas que usan correo simulado describen solo su entorno de prueba. |
| Reportes / persistencia | Funcionan los recorridos de consulta y persistencia reportados por el equipo. | Conservar evidencia de aceptación y verificar permisos según rol. |
| Infraestructura | Hostinger; Caddy publica web/API/WebSocket por HTTPS; DB/backend/facial internos. | Ensayar restauración en un entorno separado y mantener el respaldo operativo. |

---

## 3. Condición de entrega

Para cada FE, registrar prioridad, rol, plataforma, precondiciones, pasos, esperado/observado, evidencia y resultado tras recargar. Automatización y chequeos HTTP son evidencia técnica, no aceptación institucional.

---

## 4. Evidencia técnica y límites

| Evidencia reportada | Interpretación correcta |
|---|---|
| Servicio facial: 123 aprobadas; 1 prueba opcional PostgreSQL omitida. Frontend: 120 pruebas en 13 suites y 6 scripts de regresión. | Cobertura automatizada reportada; el equipo confirma además que la cámara y los flujos funcionales sirven en el sistema. |
| Integración HTTP con base desechable, inferencia determinista/mock y correo simulado. | Describe esa corrida automatizada; el equipo confirma por separado el funcionamiento de asistencia y correo. No mide precisión poblacional. |
| HTTPS/login 200, health facial 200, ruta admin sin token 401, WebSocket 101. | Chequeos técnicos del despliegue, junto con la confirmación funcional del equipo. |

### Aspectos de mejora y operación

1. Ensayar la restauración de un respaldo en un entorno separado.
2. Documentar retención, acceso y eliminación de datos biométricos.
3. Medir latencia y errores; evaluar biometría con un protocolo y una muestra autorizados.

---

## 5. Trazabilidad y anexo

El anexo conserva las 74 fichas, sus IDs FE, descripciones y prioridades del archivo completo original. Su encabezado de referencia técnica (FaceLit `dev` `724124e`, octubre 2026) se mantiene como fecha del análisis de cada ficha. Por ello, sus etiquetas API/PAR/LOCAL/UI/FUT son observaciones históricas; no deben citarse como auditoría del `main` consultado el 4 de noviembre. La confirmación funcional del equipo se refiere al sistema actual y no reescribe las pruebas históricas del anexo.

### Regla de interpretación

No se calcula un porcentaje de avance a partir del conteo de requisitos. Prioridad, evidencia de código y aceptación funcional son dimensiones diferentes. No declarar completa una función Must solo porque exista pantalla o integración observada.

> **Anexo A — Inventario de 74 requisitos de frontend (corte de evaluación: commit `724124e`).** La priorización se conserva; el estado por ficha es una línea base histórica que debe revalidarse con pruebas de aceptación.

---

# Anexo A — MoSCoW completo del Frontend

**FACELIT / PLANIFICACIÓN DE LA ENTREGA**

**Priorización funcional, estado observado y criterios de aceptación para la sustentación.**

Versión 1.0 | octubre del 2026.
Base: FaceLit, rama dev, commit `724124e`. Alcance: 74 elementos que cubren los módulos y las capacidades transversales.
Carácter: propuesta técnica de prioridades; no es un acta de aprobación ni una certificación de cumplimiento del SRS.

### Cómo se decidió la prioridad

| Prioridad | Criterio |
|---|---|
| **M - Must (35)** | Indispensable para completar el núcleo de la entrega: acceso, contexto académico, captura, guardado remoto y consulta. |
| **S - Should (23)** | Importante para operación y calidad; admite una solución temporal o una entrega posterior explícita. |
| **C - Could (8)** | Complemento deseable si queda capacidad; se puede posponer sin impedir el recorrido mínimo. |
| **W - Won't (8)** | No se compromete en esta versión propuesta. No significa que nunca pueda desarrollarse. |

### Prioridad y estado son dimensiones diferentes

Una función puede ser indispensable y estar incompleta; otra puede ser opcional y tener una pantalla. Cada ficha distingue ambos aspectos y propone una condición de aceptación verificable.

| Etiqueta | Significado |
|---|---|
| **API** | Hay una llamada al servicio en el recorrido revisado; no acredita una prueba de extremo a extremo. |
| **PAR / LOCAL** | Integración parcial o pendiente de validar / uso de store o datos de ejemplo. |
| **UI / FUT** | Interfaz o cálculo local observado / exclusión o función futura. |

> Roles: Coordinador, Instructor y Aprendiz; visitante para landing y acceso. Los IDs FE son propios de este documento. RF-1 a RF-9 se usan solo como agrupación histórica del proyecto. No se asigna equivalencia formal requisito a requisito con un SRS adjunto.

> **Lectura del estado:** API = conexión observada; PAR = parcial/por validar; LOCAL = store o simulación; UI = interfaz; FUT = exclusión. Ningún estado significa aprobación de pruebas.

---

## 01 / Acceso y sesión

**RF-1 / transversal** — Sin acceso y sesión no se puede completar un recorrido por rol.

### FE-001 — Inicio de sesión
**Must Have** · **API**
- **Rol:** Todos.
- **Valor:** Acceder con documento y contraseña.
- **Aceptación:** Credenciales válidas abren el panel correspondiente; las inválidas muestran un error.
- **Referencia:** `features/auth/hooks/useLoginForm.ts`

### FE-002 — Aviso y aceptación de privacidad
**Must Have** · **API**
- **Rol:** Todos.
- **Valor:** Informar antes de utilizar la cuenta y la captura.
- **Aceptación:** Consultar aceptación previa y exigirla cuando corresponda; permitir leer el aviso.
- **Referencia:** `features/auth/components/PrivacyNoticeModal.tsx`

### FE-003 — Restauración de sesión
**Must Have** · **API**
- **Rol:** Todos.
- **Valor:** Evitar perder el acceso al recargar.
- **Aceptación:** Esperar la restauración del token antes de mostrar el panel o redirigir.
- **Referencia:** `shared/contexts/AuthContext.tsx`

### FE-004 — Navegación y acceso por rol
**Must Have** · **PAR**
- **Rol:** Todos.
- **Valor:** Separar funciones de Coordinador, Instructor y Aprendiz.
- **Aceptación:** Mostrar menú adecuado y comprobar también rutas directas; el servidor autoriza datos.
- **Referencia:** `shared/components/layout/Sidebar.tsx`

### FE-005 — Solicitud de recuperación
**Must Have** · **API**
- **Rol:** Todos.
- **Valor:** Recuperar acceso sin intervención manual.
- **Aceptación:** Enviar solicitud al servicio y mostrar resultado sin dar por recibido el correo.
- **Referencia:** `features/auth/hooks/usePasswordRecoveryForm.ts`

### FE-006 — Validación de código y nueva clave
**Must Have** · **API**
- **Rol:** Todos.
- **Valor:** Completar la recuperación con validación.
- **Aceptación:** Rechazar código inválido o vencido y confirmar cambio solo ante respuesta satisfactoria.
- **Referencia:** `features/auth/hooks/useVerificationCode.ts`

### FE-007 — Cerrar sesión
**Must Have** · **API**
- **Rol:** Todos.
- **Valor:** Finalizar el uso de la cuenta en el dispositivo.
- **Aceptación:** Ejecutar salida, limpiar sesión local y regresar al acceso.
- **Referencia:** `shared/contexts/AuthContext.tsx`

### FE-008 — Reacción inmediata a sesión vencida
**Should Have** · **PAR**
- **Rol:** Todos.
- **Valor:** Evitar pantallas que parezcan autenticadas tras un 401.
- **Aceptación:** Sincronizar limpieza del token con AuthContext y redirigir sin reiniciar.
- **Referencia:** `shared/services/api.js`

---

## 02 / Usuarios y paneles por rol

**Usuarios / transversal** — La ruta admin corresponde al panel del Coordinador; su nombre no crea un rol nuevo.

### FE-009 — Listado y búsqueda de usuarios
**Must Have** · **API**
- **Rol:** Coordinador.
- **Valor:** Administrar cuentas existentes.
- **Aceptación:** Cargar lista remota y filtrar por documento, nombre, rol y estado según controles.
- **Referencia:** `app/admin/users/index.tsx`

### FE-010 — Crear coordinador
**Must Have** · **API**
- **Rol:** Coordinador.
- **Valor:** Dar de alta una nueva cuenta administrativa.
- **Aceptación:** Validar datos y confirmar el alta mediante el servicio de usuarios.
- **Referencia:** `app/admin/users/create.tsx`

### FE-011 — Consultar y editar cuenta
**Must Have** · **API**
- **Rol:** Coordinador.
- **Valor:** Corregir información administrada.
- **Aceptación:** Cargar detalle, validar cambios y reflejar respuesta remota.
- **Referencia:** `app/admin/users/[id].tsx`

### FE-012 — Gestionar estado de cuenta
**Should Have** · **API**
- **Rol:** Coordinador.
- **Valor:** Controlar disponibilidad de cuentas.
- **Aceptación:** Actualizar estado autorizado y refrescar listado; verificar efecto real en el servidor.
- **Referencia:** `shared/services/userManagementService.js`

### FE-013 — Inicio del Aprendiz
**Must Have** · **UI**
- **Rol:** Aprendiz.
- **Valor:** Mostrar ficha, programa y accesos principales.
- **Aceptación:** Resolver identidad y contexto académico; mostrar estado sin ficha cuando corresponda.
- **Referencia:** `app/apprentice/index.tsx`

### FE-014 — Paneles de Coordinador e Instructor
**Should Have** · **PAR**
- **Rol:** Coordinador / Instructor.
- **Valor:** Organizar accesos y contexto del rol.
- **Aceptación:** Los accesos abren rutas existentes y los indicadores proceden de fuentes declaradas.
- **Referencia:** `app/admin/index.tsx`; `app/instructor/index.tsx`

---

## 03 / Gestión académica

**RF-3** — CSV, asignación manual y edición administrativa son recorridos distintos.

### FE-015 — Consultar programas y fichas
**Must Have** · **API**
- **Rol:** Coordinador / Instructor.
- **Valor:** Seleccionar el contexto de formación.
- **Aceptación:** Cargar snapshot del rol y mostrar asociaciones programa-ficha.
- **Referencia:** `features/academic/academicApi.ts`

### FE-016 — Crear y editar programas
**Must Have** · **API**
- **Rol:** Coordinador.
- **Valor:** Mantener el catálogo académico.
- **Aceptación:** Validar nombre y código; confirmar solo después del servicio y refrescar datos.
- **Referencia:** `features/academic/useAcademic.ts`

### FE-017 — Crear y editar fichas
**Must Have** · **API**
- **Rol:** Coordinador.
- **Valor:** Relacionar aprendices con formación.
- **Aceptación:** Validar datos y conservar una asociación de programa coherente.
- **Referencia:** `features/academic/useAcademic.ts`

### FE-018 — Desactivar o reactivar catálogos
**Should Have** · **API**
- **Rol:** Coordinador.
- **Valor:** Gestionar el ciclo de vida académico.
- **Aceptación:** Ejecutar operación remota y actualizar estado sin prometer borrado físico.
- **Referencia:** `features/academic/useAcademic.ts`

### FE-019 — Asignación manual de aprendiz
**Must Have** · **API**
- **Rol:** Coordinador.
- **Valor:** Vincular personas que no llegan por CSV.
- **Aceptación:** Enviar datos y ficha a `assignApprentice`; mostrar resultado y errores del servicio.
- **Referencia:** `app/admin/academic/assignments.tsx`

### FE-020 — Gestión de instructores y vínculos
**Must Have** · **PAR**
- **Rol:** Coordinador.
- **Valor:** Relacionar instructor específico/transversal con formación.
- **Aceptación:** Distinguir consultas y operaciones remotas de cambios del store; verificar persistencia de cada acción.
- **Referencia:** `app/admin/academic/instructors.tsx`; `features/academic/useAcademic.ts`

### FE-021 — Traslado manual y pendientes CSV
**Should Have** · **API**
- **Rol:** Coordinador.
- **Valor:** Resolver diferencias de asignación.
- **Aceptación:** Aceptar/cancelar el pendiente por API y refrescar la relación del aprendiz.
- **Referencia:** `features/academic/useTransferRequests.ts`

### FE-022 — Solicitud y unión por código
**Could Have** · **LOCAL**
- **Rol:** Aprendiz.
- **Valor:** Ofrecer una vía alternativa de traslado.
- **Aceptación:** Completar integración y persistencia antes de habilitarlo como flujo operativo.
- **Referencia:** `app/apprentice/transfer-request.tsx`; `app/apprentice/join-ficha.tsx`

---

## 04 / Importación CSV y ambientes

**RF-2 / RF-3** — El catálogo local de ambientes no equivale al ambiente persistido por el flujo de sesión.

### FE-023 — Seleccionar y validar CSV
**Must Have** · **API**
- **Rol:** Coordinador.
- **Valor:** Evitar archivos no procesables.
- **Aceptación:** Validar extensión, tamaño, filas y cabeceras; mostrar errores antes del envío cuando aplique.
- **Referencia:** `app/admin/academic/csv-upload.tsx`

### FE-024 — Enviar y mostrar resultado CSV
**Must Have** · **API**
- **Rol:** Coordinador.
- **Valor:** Cargar datos con resultados comprensibles.
- **Aceptación:** Mostrar creados, actualizados, inconsistencias y errores; diferenciar fallo de refresco.
- **Referencia:** `app/admin/academic/csv-upload.tsx`

### FE-025 — Plantilla y reporte de importación
**Should Have** · **PAR**
- **Rol:** Coordinador.
- **Valor:** Ayudar a preparar y revisar la carga.
- **Aceptación:** Descargar plantilla/reporte en plataformas soportadas sin prometer igual comportamiento nativo.
- **Referencia:** `app/admin/academic/csv-upload.tsx`

### FE-026 — Consultar ambiente para sesión
**Must Have** · **API**
- **Rol:** Instructor.
- **Valor:** Asociar la captura al contexto físico.
- **Aceptación:** Buscar/seleccionar ambiente mediante el flujo conectado de sesión.
- **Referencia:** `features/environments/useEnvironmentSession.ts`

### FE-027 — Crear ambiente desde sesión
**Should Have** · **API**
- **Rol:** Instructor.
- **Valor:** Resolver un ambiente que no existe.
- **Aceptación:** Validar y guardar por el servicio; usar el identificador devuelto.
- **Referencia:** `features/environments/useEnvironmentSession.ts`

### FE-028 — Catálogo general de ambientes
**Should Have** · **LOCAL**
- **Rol:** Coordinador / Instructor.
- **Valor:** Administrar lista, detalle y estado.
- **Aceptación:** Sustituir store de ejemplos por persistencia remota y comprobar recarga.
- **Referencia:** `features/environments/environmentsStore.ts`

### FE-029 — Asignaciones y limpieza de ambientes
**Could Have** · **LOCAL**
- **Rol:** Coordinador.
- **Valor:** Ampliar administración fuera de la sesión.
- **Aceptación:** Persistir asignar/desasignar fichas y validar restricciones antes de borrar.
- **Referencia:** `features/environments/useEnvironments.ts`

### FE-030 — Actualización por eventos de datos
**Could Have** · **API**
- **Rol:** Roles autorizados.
- **Valor:** Refrescar cambios de otras operaciones.
- **Aceptación:** Reconectar el WebSocket y recargar solo recursos relevantes sin duplicar eventos.
- **Referencia:** `shared/services/realtime.ts`

---

## 05 / Registro facial y captura de asistencia

**RF-5 / núcleo** — La evaluación facial depende del microservicio; el Backend conserva reglas y eventos de asistencia.

### FE-031 — Consultar estado facial propio
**Must Have** · **API**
- **Rol:** Aprendiz.
- **Valor:** Evitar registros indebidos o duplicados.
- **Aceptación:** Consultar estado remoto; bloquear inicio mientras carga o existe error.
- **Referencia:** `app/apprentice/facial.tsx`

### FE-032 — Confirmación e instrucciones
**Must Have** · **UI**
- **Rol:** Aprendiz.
- **Valor:** Explicar identidad y condiciones de captura.
- **Aceptación:** Mostrar nombre, responsabilidad y aviso previo; continuar solo tras confirmación.
- **Referencia:** `app/apprentice/facial.tsx`

### FE-033 — Cámara y acciones de vida
**Must Have** · **API**
- **Rol:** Aprendiz / Instructor.
- **Valor:** Obtener evidencia para el procesamiento.
- **Aceptación:** Gestionar permiso, rostro y tres acciones del flujo; validar grupos y permitir corrección.
- **Referencia:** `features/auth/hooks/useFacialRegistration.ts`; `features/facial/useSessionAttendanceCapture.ts`

### FE-034 — Guardar registro facial
**Must Have** · **API**
- **Rol:** Aprendiz.
- **Valor:** Crear la referencia biométrica.
- **Aceptación:** Enviar imágenes al microservicio; mostrar éxito solo después de respuesta satisfactoria.
- **Referencia:** `shared/services/facialEmbeddingService.ts`

### FE-035 — Solicitar y resolver restablecimiento
**Should Have** · **API**
- **Rol:** Aprendiz / Coordinador.
- **Valor:** Controlar el reemplazo de una referencia.
- **Aceptación:** Solicitar, decidir y usar autorización vigente; impedir repetición local tras consumo.
- **Referencia:** `shared/services/facialEnrollmentService.ts`; `app/notifications/index.tsx`

### FE-036 — Configurar sesión facial
**Must Have** · **API**
- **Rol:** Instructor.
- **Valor:** Definir ficha, ambiente, dispositivo y horarios.
- **Aceptación:** Guardar sesión, conservar ID remoto y habilitar captura con contexto válido.
- **Referencia:** `features/environments/useEnvironmentSession.ts`

### FE-037 — Marcar asistencia desde imagen
**Must Have** · **API**
- **Rol:** Instructor / captura del aprendiz.
- **Valor:** Convertir captura en solicitud de asistencia.
- **Aceptación:** Enviar secuencia al Backend; mostrar éxito ante respuesta válida, error en rechazo.
- **Referencia:** `features/facial/useSessionAttendanceCapture.ts`

### FE-038 — Continuidad y salida de cámara
**Should Have** · **API**
- **Rol:** Instructor.
- **Valor:** Mantener el recorrido de varias capturas.
- **Aceptación:** Preparar siguiente persona, restaurar sesión y verificar contraseña al salir por el flujo previsto.
- **Referencia:** `app/instructor/facial/camera.tsx`

---

## 06 / Consulta y validación de asistencia

**RF-6** — No atribuir al Frontend la decisión biométrica ni el cálculo autoritativo de ventanas horarias.

### FE-039 — Consulta por ficha y fechas
**Must Have** · **API**
- **Rol:** Coordinador / Instructor.
- **Valor:** Revisar resultados de una sesión académica.
- **Aceptación:** Solicitar matriz del período y mostrar estados reales de aprendices.
- **Referencia:** `app/admin/attendance/by-ficha.tsx`

### FE-040 — Consulta por usuario
**Must Have** · **API**
- **Rol:** Coordinador / Instructor.
- **Valor:** Revisar el recorrido de una persona.
- **Aceptación:** Seleccionar usuario y fechas; filtrar datos remotos de la matriz.
- **Referencia:** `app/admin/attendance/by-user.tsx`

### FE-041 — Consulta personal de asistencia
**Must Have** · **API**
- **Rol:** Aprendiz.
- **Valor:** Permitir seguimiento individual.
- **Aceptación:** Resolver ficha activa y mostrar solo la selección del aprendiz en la interfaz.
- **Referencia:** `app/apprentice/attendance.tsx`

### FE-042 — Puntualidad, tardanza y ausencia
**Must Have** · **API**
- **Rol:** Roles autorizados.
- **Valor:** Interpretar el resultado académico.
- **Aceptación:** Mostrar estados recibidos y leyenda; no presentar similitud como precisión.
- **Referencia:** `app/apprentice/attendance.tsx`

### FE-043 — Registrar y visualizar excusa
**Should Have** · **API**
- **Rol:** Coordinador / Instructor / consulta Aprendiz.
- **Valor:** Distinguir ausencia con excusa.
- **Aceptación:** Actualizar excusa por servicio y mostrar E sin alterar automáticamente la fórmula de asistencia.
- **Referencia:** `app/admin/attendance/by-ficha.tsx`

### FE-044 — Exportar asistencia Excel/CSV
**Should Have** · **PAR**
- **Rol:** Coordinador / Instructor.
- **Valor:** Compartir resultados del período.
- **Aceptación:** Exportar filas y filtros de la consulta; comprobar cada plataforma soportada.
- **Referencia:** `app/admin/attendance/by-ficha.tsx`; `shared/utils/export.ts`

### FE-045 — Resumen estadístico personal
**Must Have** · **API**
- **Rol:** Aprendiz.
- **Valor:** Entender el período consultado.
- **Aceptación:** Calcular puntuales+tarde sobre total, distinguir vacío de ausencia y redondear.
- **Referencia:** `app/apprentice/attendance.tsx`

### FE-046 — Historial adicional y detalle antiguo
**Could Have** · **LOCAL**
- **Rol:** Coordinador / Instructor.
- **Valor:** Conservar una vista complementaria.
- **Aceptación:** Migrar fuente local al servicio; no mezclar ejemplos con matriz real.
- **Referencia:** `app/admin/attendance/history.tsx`; `features/attendance/useAttendance.ts`

---

## 07 / Notificaciones, perfil y preferencias

**RF-8 / RF-9** — Las notificaciones en pantalla y el envío de correos son responsabilidades diferentes.

### FE-047 — Bandeja personal y lectura
**Must Have** · **API**
- **Rol:** Todos.
- **Valor:** Comunicar resultados y decisiones.
- **Aceptación:** Cargar notificaciones, filtrar destinatario y marcar lectura por servicio.
- **Referencia:** `features/notifications/useNotifications.ts`

### FE-048 — Filtros, detalle y pendientes
**Should Have** · **API**
- **Rol:** Todos.
- **Valor:** Encontrar mensajes relevantes.
- **Aceptación:** Filtrar categoría/lectura, expandir detalle y actualizar el contador.
- **Referencia:** `app/notifications/index.tsx`

### FE-049 — Acción desde aprobación facial
**Should Have** · **API**
- **Rol:** Aprendiz / Coordinador.
- **Valor:** Cerrar el flujo de restablecimiento.
- **Aceptación:** Coordinador decide; Aprendiz abre captura y vuelve a consultar autorización.
- **Referencia:** `app/notifications/index.tsx`

### FE-050 — Consultar perfil
**Must Have** · **API**
- **Rol:** Todos.
- **Valor:** Identificar la cuenta en uso.
- **Aceptación:** Intentar consulta remota y usar sesión como respaldo declarado, sin inventar datos.
- **Referencia:** `app/profile/index.tsx`

### FE-051 — Seguridad desde perfil
**Should Have** · **API**
- **Rol:** Todos.
- **Valor:** Acceder al cambio de contraseña.
- **Aceptación:** Abrir recuperación con correo y completar validación del servicio.
- **Referencia:** `app/profile/index.tsx`

### FE-052 — Tema claro y oscuro
**Could Have** · **UI**
- **Rol:** Todos.
- **Valor:** Adaptar la apariencia.
- **Aceptación:** Aplicar contraste y tema en pantallas principales sin romper la legibilidad.
- **Referencia:** `shared/contexts/ThemeContext.tsx`

### FE-053 — Idiomas de la interfaz
**Should Have** · **PAR**
- **Rol:** Todos.
- **Valor:** Facilitar uso en varios idiomas.
- **Aceptación:** Verificar español, inglés, francés y alemán; localizar textos pendientes y compatibilidad del servidor.
- **Referencia:** `shared/i18n/`; `app/profile/settings.tsx`

### FE-054 — Guardar preferencias
**Should Have** · **API**
- **Rol:** Todos.
- **Valor:** Conservar configuración de la cuenta.
- **Aceptación:** Guardar por API y verificar recuperación posterior; mostrar error si falla.
- **Referencia:** `features/profile/useUserSettings.ts`

---

## 08 / Reportes y horarios complementarios

**RF-4 / RF-7** — Estos módulos no sustituyen la sesión real de captura ni su consulta de asistencia.

### FE-055 — Reportes por usuario y ficha
**Should Have** · **LOCAL**
- **Rol:** Coordinador / Instructor.
- **Valor:** Resumir resultados académicos.
- **Aceptación:** Conectar fuente remota: las vistas revisadas consumen `useAttendance` con datos de ejemplo.
- **Referencia:** `app/admin/reports/by-user.tsx`; `app/admin/reports/by-ficha.tsx`

### FE-056 — Calendario e indicadores de rendimiento
**Could Have** · **LOCAL**
- **Rol:** Coordinador / Instructor.
- **Valor:** Ofrecer lectura visual adicional.
- **Aceptación:** Unificar fuente con asistencia real antes de demostrar métricas institucionales.
- **Referencia:** `app/admin/reports/calendar.tsx`; `app/admin/reports/my-performance.tsx`

### FE-057 — Exportación de reportes y PDF
**Could Have** · **PAR**
- **Rol:** Coordinador / Instructor.
- **Valor:** Facilitar entrega documental.
- **Aceptación:** Comprobar fuente, filtros y salida por plataforma; el botón no acredita un reporte remoto válido.
- **Referencia:** `shared/utils/export.ts`

### FE-058 — Registrar y editar horarios
**Should Have** · **LOCAL**
- **Rol:** Coordinador / Instructor.
- **Valor:** Planificar formación fuera de la sesión puntual.
- **Aceptación:** Persistir horarios y eliminar dependencia de `MOCK_SCHEDULES` para uso real.
- **Referencia:** `features/schedules/schedulesStore.ts`

### FE-059 — Conflictos y excepciones
**Should Have** · **LOCAL**
- **Rol:** Coordinador / Instructor.
- **Valor:** Evitar superposiciones de planificación.
- **Aceptación:** Validar y persistir conflictos/excepciones; no afirmar integración productiva por lógica local.
- **Referencia:** `features/schedules/schedulesStore.ts`

### FE-060 — Revisión documental de excusas
**Could Have** · **PAR**
- **Rol:** Coordinador / Instructor.
- **Valor:** Complementar la marca simple de excusa.
- **Aceptación:** Conectar documentos, decisiones y auditoría; distinguir esta vista de `updateFacialEventExcuse`.
- **Referencia:** `app/admin/reports/excuses-review.tsx`

---

## 09 / Experiencia, integración y calidad

**Transversal / RNF** — Son condiciones de entrega propuestas; su aceptación requiere comprobar el producto.

### FE-061 — Errores, carga y prevención de doble envío
**Must Have** · **PAR**
- **Rol:** Todos.
- **Valor:** Evitar confirmaciones falsas y acciones repetidas.
- **Aceptación:** Mostrar estado de carga; bloquear mientras envía; recuperar errores sin perder contexto.
- **Referencia:** `shared/components/ui/`; `features/auth/hooks/`

### FE-062 — Compatibilidad de la plataforma de entrega
**Must Have** · **PAR**
- **Rol:** Todos.
- **Valor:** Completar el núcleo en el entorno elegido.
- **Aceptación:** Probar acceso, cámara y consulta en la plataforma declarada; no inferir iOS probado.
- **Referencia:** `app/`; `app.json`

### FE-063 — Adaptación de pantallas y accesibilidad
**Should Have** · **PAR**
- **Rol:** Todos.
- **Valor:** Hacer utilizables formularios y tablas.
- **Aceptación:** Revisar tamaños, teclado, foco, contraste, etiquetas y alternativas al color.
- **Referencia:** `shared/components/ui/`; `app/admin/attendance/index.tsx`

### FE-064 — Protección de datos y sesión
**Must Have** · **PAR**
- **Rol:** Todos.
- **Valor:** Evitar exposición indebida en la interfaz.
- **Aceptación:** Revisar token, caché, logs, permisos y rutas; una clave pública no es secreto del servidor.
- **Referencia:** `shared/services/tokenStorage.js`; `shared/services/api.js`

### FE-065 — Landing y ayuda contextual
**Should Have** · **UI**
- **Rol:** Visitante / Todos.
- **Valor:** Explicar el valor y orientar tareas.
- **Aceptación:** Abrir acceso desde landing y mantener instrucciones coherentes con el producto.
- **Referencia:** `app/index.tsx`; `features/auth/components/`

### FE-066 — Rutas consistentes y estados vacíos
**Should Have** · **PAR**
- **Rol:** Todos.
- **Valor:** Evitar accesos rotos o información engañosa.
- **Aceptación:** Comparar rutas declaradas con archivos; mostrar sin ficha, sin registros y sin conexión.
- **Referencia:** `shared/constants/routes.ts`; `app/`

---

## 10 / Fuera de esta entrega propuesta

**Won't Have / exclusiones** — Son exclusiones de alcance propuestas para esta versión; no equivalen a decisiones históricas aprobadas.

### FE-067 — Registro público libre
**Won't Have** · **FUT**
- **Rol:** Visitante.
- **Valor:** Mantener altas por procesos administrativos.
- **Aceptación:** No comprometer registro público; referencias antiguas a `auth/register` no acreditan una pantalla actual.
- **Referencia:** `app/auth/`; `docs-repo/modules/HU-01.md`

### FE-068 — Captura en Raspberry Pi o hardware dedicado
**Won't Have** · **FUT**
- **Rol:** Operación.
- **Valor:** Evitar ampliar el alcance de dispositivos.
- **Aceptación:** No incluir instalación ni soporte de hardware dedicado en la entrega Frontend.
- **Referencia:** Alcance propuesto; sin recorrido de interfaz confirmado

### FE-069 — Marcación totalmente desconectada
**Won't Have** · **FUT**
- **Rol:** Instructor.
- **Valor:** Evitar prometer una confirmación sin servidor.
- **Aceptación:** No incluir cola offline ni sincronización posterior como función entregada.
- **Referencia:** `features/facial/useSessionAttendanceCapture.ts`

### FE-070 — Reconocer varias personas simultáneamente
**Won't Have** · **FUT**
- **Rol:** Captura.
- **Valor:** Mantener el flujo individual actual.
- **Aceptación:** No ofrecer captura de grupo: el servicio revisado rechaza varios rostros.
- **Referencia:** Alcance del núcleo; dependencia micro-facial

### FE-071 — Entrenar modelos desde la interfaz
**Won't Have** · **FUT**
- **Rol:** Administración.
- **Valor:** Conservar el procesamiento especializado.
- **Aceptación:** No incluir entrenamiento, etiquetado ni ajuste automático del modelo en el Frontend.
- **Referencia:** Alcance propuesto; usa servicio especializado

### FE-072 — Consola de auditoría y biometría avanzada
**Won't Have** · **FUT**
- **Rol:** Coordinador.
- **Valor:** Separar operación básica de administración especializada.
- **Aceptación:** No prometer editor de vectores, auditoría forense ni certificación de vida.
- **Referencia:** Sin pantalla operativa confirmada

### FE-073 — Portal completo de acudientes
**Won't Have** · **FUT**
- **Rol:** Acudiente.
- **Valor:** Evitar trasladar el alcance de documentos antiguos.
- **Aceptación:** No incluir registro y autorización de acudientes sin nuevo alcance validado.
- **Referencia:** `docs-repo/modules/HU-01.md`; `app/auth/`

### FE-074 — Nuevos canales y analítica predictiva
**Won't Have** · **FUT**
- **Rol:** Todos.
- **Valor:** Concentrar esfuerzo en asistencia verificable.
- **Aceptación:** No incluir WhatsApp, SMS, predicción de deserción o integraciones externas no acordadas.
- **Referencia:** Alcance propuesto; sin integración confirmada

---

## 11 / Condiciones para entregar

### Orden recomendado para cerrar la versión

| Paso | Descripción |
|---|---|
| **1. Recorrido mínimo** | Acceso del rol, ficha real, registro facial, configuración de sesión, captura desde imagen, evento remoto y consulta personal/por ficha. |
| **2. Cierre de Must** | Verificar todos los FE clasificados M con datos de prueba y Backend/microservicio disponibles. Un M parcial es pendiente de entrega. |
| **3. Calidad y operación** | Tratar permisos/rutas, errores, persistencia y privacidad; después completar los Should de mayor impacto. |
| **4. Extensiones** | Implementar Could solo con capacidad disponible. Mantener Won't fuera de la demostración comprometida. |

### Dependencias y brechas que afectan la aceptación

- **Autorización:** ocultar un menú no protege una ruta o los datos. Debe comprobarse la respuesta del servidor para cada rol.
- **Integración mixta:** ambientes generales y horarios usan stores de ejemplo; la selección de ambiente y la sesión facial tienen otro recorrido conectado.
- **Reportes:** varias vistas consumen `useAttendance` con ejemplos. La matriz real de asistencia no valida automáticamente todos esos reportes.
- **Académico:** algunas acciones del hook son remotas y otras modifican el store. Debe verificarse la persistencia operación por operación.
- **Sesión vencida:** el interceptor elimina el token ante 401; falta verificar que el contexto y la pantalla reaccionen de inmediato.
- **Preferencias, cámara y exportaciones:** comprobar cada plataforma que se declare entregada y la compatibilidad de idioma con el servidor.

### Evidencia mínima de aceptación

Registrar por caso: ID FE, rol, plataforma, precondición, pasos, resultado esperado, resultado observado y evidencia. Incluir un caso correcto y los rechazos relevantes; recargar o consultar nuevamente para comprobar persistencia.

> **Regla de decisión propuesta:** no declarar la entrega completa solo porque existe una pantalla. Si un Must falla, cerrar la brecha o negociar expresamente su alcance. Las funciones locales se presentan como prototipo hasta validar su persistencia.

> No se calculan porcentajes de avance ni de esfuerzo: contar requisitos no equivale a estimar su coste. Los totales de MoSCoW son cantidades de elementos, no una medición de cumplimiento.

---

## 12 / Resumen y trazabilidad

### Índice de requisitos por prioridad

**Must Have (35):** FE-001, FE-002, FE-003, FE-004, FE-005, FE-006, FE-007, FE-009, FE-010, FE-011, FE-013, FE-015, FE-016, FE-017, FE-019, FE-020, FE-023, FE-024, FE-026, FE-031, FE-032, FE-033, FE-034, FE-036, FE-037, FE-039, FE-040, FE-041, FE-042, FE-045, FE-047, FE-050, FE-061, FE-062, FE-064

**Should Have (23):** FE-008, FE-012, FE-014, FE-018, FE-021, FE-025, FE-027, FE-028, FE-035, FE-038, FE-043, FE-044, FE-048, FE-049, FE-051, FE-053, FE-054, FE-055, FE-058, FE-059, FE-063, FE-065, FE-066

**Could Have (8):** FE-022, FE-029, FE-030, FE-046, FE-052, FE-056, FE-057, FE-060

**Won't Have (8):** FE-067, FE-068, FE-069, FE-070, FE-071, FE-072, FE-073, FE-074

### Cobertura de módulos y pantallas

| Módulo | Cobertura |
|---|---|
| Acceso y roles | `app/auth/`, layouts de rol, paneles, Sidebar y AuthContext. |
| Usuarios y académico | `app/admin/users/`, `app/admin/academic/`, transfer-requests y rutas académicas del Instructor. |
| Ambientes y horarios | `app/admin/environments/`, `app/instructor/environments/` y carpetas `schedules/` de ambos roles. |
| Núcleo y asistencia | `app/apprentice/facial.tsx`, `app/instructor/facial/` y carpetas `attendance/`; `shared/services/facial*`. |
| Mensajes y perfil | `app/notifications/`, `app/profile/` y hooks de notificaciones/configuración. |
| Reportes y transversal | carpetas `reports/`, exportación, i18n, componentes compartidos y servicios de sesión. |

### Base documental y límites

Se revisaron las rutas existentes, hooks, stores, servicios y documentación interna HU-01 a HU-09. La documentación antigua describe registro público y otras rutas que no están en `app/` actual. Por eso se prioriza la evidencia del código y se señalan las referencias históricas.

Algunas constantes declaran rutas sin archivo equivalente; no se cuentan como funciones terminadas. Las pantallas adicionales o no presentes en el menú se consideran según su integración real. Las réplicas de una vista entre roles no duplican un requisito de negocio.

> Este documento cubre la planificación funcional del Frontend. No valida disponibilidad de correo, precisión biométrica, seguridad completa, rendimiento del servidor ni el cumplimiento legal. Tampoco sustituye una matriz formal de trazabilidad contra la versión aprobada del SRS.

### Para la sustentación

> "Priorizamos el recorrido que convierte una captura en asistencia consultable. Después ubicamos funciones de operación y calidad como Should, mejoras complementarias como Could y exclusiones explícitas como Won't. La prioridad no se confunde con el estado de implementación."
