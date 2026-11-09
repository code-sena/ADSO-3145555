# FaceLit — plan de pruebas y evidencia disponible

La [evidencia visual por rol](visual-evidence-by-role.md) reúne las capturas aportadas por el equipo y explica qué resultados se observan en cada una.

**Corte:** 27 de octubre de 2026.  
**Criterio:** cada resultado se asocia a la suite, rama/SHA, entorno y tipo de dependencia utilizado. Los conteos no se suman entre ejecuciones diferentes.

**Estado funcional actualizado al 4 de noviembre:** el equipo confirma que acceso, carga CSV, cámara, asistencia y correo funcionan en el sistema actual. Las tablas siguientes preservan el alcance de las ejecuciones automatizadas reportadas al 27 de octubre y no deben interpretarse como una lista de fallas actuales.

## Resultados de prueba reportados para los retos HU-45

| Área | Resultado reportado | Qué comprueba | Límite |
|---|---|---|---|
| micro-facial | 123 aprobadas; 1 prueba PostgreSQL optativa omitida | Retos activos, reglas de secuencia, señales sintéticas y rechazos | No implica que la prueba optativa omitida haya sido ejecutada |
| FaceLit frontend | 120 aprobadas en 13 suites; 6 scripts de regresión aprobados | Flujos de cliente seleccionados, tipos y lint de módulos afectados | Dependencias controladas; no certifica cámara física, SMTP ni todo el lint global |
| HTTP integrado | 19 comprobaciones específicas de retos: señales correctas, quietud, gesto incorrecto y rechazo de siete códigos retirados; además registro, confirmación, autorización, asistencia, matriz y CSV | Comunicación HTTP, JWT, reglas y persistencia contra base desechable con 45 migraciones | Inferencia facial determinista/controlada; correo simulado; no es prueba biométrica física |
| Despliegue Hostinger | HTTPS, salud de servicios, API, 401 sin autenticación y WebSocket 101 comprobados | Arranque, proxy, conectividad y configuración técnica | El equipo confirmó por separado que las funciones de cuenta, CSV, cámara y correo funcionan. |

Los resultados de 123 y 120 se reportan en RETOS_ACTIVOS_HU45_2026-10-27.md y la guía de sustentación. Son propios de la validación de los cuatro retos. Otros informes de ramas/fases anteriores presentan conteos distintos; no mezclarlos con esta tabla ni llamarlos una sola corrida.

## Alcance de la batería de retos

Se probaron los cuatro códigos activos: MOVE_UP, MOVE_DOWN, MOVE_CLOSER y MOVE_AWAY. Los flujos requieren dos retos distintos con siete capturas por reto. La batería rechaza los siete códigos retirados. Las señales usadas para pruebas lógicas son sintéticas; prueban reglas de aceptación/rechazo, no la tasa de acierto en personas/cámaras diversas.

## Escenario integrado

El escenario registrado usa rutas HTTP reales del frontend/backend/microservicio, autenticación JWT, SQL y PostgreSQL desechable. La inferencia es un fixture determinista y el correo se sustituye por un envío controlado/simulado. Entre los comportamientos reportados están registro facial, confirmación idempotente, control de autorización, asistencia, rechazo de duplicados, matriz e importación CSV. La navegación web se incluye en la verificación documentada.

Este escenario automatizado comprueba contratos y coordinación de componentes; no mide precisión biométrica poblacional ni rendimiento bajo carga. El equipo confirma por separado el funcionamiento de la cámara y del correo en el sistema actual.

## Despliegue reportado y seguimiento de evidencia

El despliegue reportó respuesta 200 para la web y login, salud facial 200, rechazo 401 a endpoint administrativo sin autenticar y handshake WebSocket 101. Además, el backend inició con validación JPA y la migración dejó 45 changesets sin pendientes.

El equipo confirma al 4 de noviembre que los siguientes flujos funcionan en el sistema actual. La lista refleja verificaciones cuya evidencia formal no estaba adjunta al informe del 27 de octubre, no defectos funcionales vigentes:

1. Login real del coordinador retenido en producción.
2. Carga CSV de datos autorizados de demostración y comprobación de relaciones creadas.
3. Entrega de correo SMTP, si se incluye en la sustentación.
4. Registro facial y asistencia con cámara física y usuario participante autorizado.
5. Confirmación de persistencia tras recargar la consulta.
6. Recorrido con el APK instalado en dispositivo, si se va a afirmar esa plataforma.
7. Restauración de un respaldo en entorno separado.
8. Resultado de CI/checks remotos para los SHA exactos publicados.

## Formato mínimo para registrar una nueva ejecución

Por cada corrida conservar:

- Identificador/fecha y responsable.
- Repositorio, rama y SHA de frontend, backend, servicio facial y DB.
- Comando o procedimiento y versiones de runtime.
- Entorno: unitario, base aislada, despliegue o físico.
- Datos de prueba no identificables.
- Resultado por caso: aprobado/fallido/omitido/bloqueado.
- Logs/artefactos con secretos y datos personales eliminados.
- Limitaciones: inferencia real/controlada, SMTP real/simulado, cámara física/sintética.
- Incidentes y decisión de aceptación.

## Redacción permitida para resultados

Decir: “El equipo confirmó que acceso, CSV, cámara, asistencia y correo funcionan; las suites citadas cubren solo los casos y entornos descritos.” No decir “100 % preciso”, “cero errores” ni asignar porcentaje de cobertura de producto a partir del número de pruebas.

## Fuentes de evidencia

- RETOS_ACTIVOS_HU45_2026-10-27.md y carpeta de evidencias four-challenges-hu45.
- GUIA_SUSTENTACION_FACELIT_ADSO_28_OCTUBRE_2026.md.
- DESPLIEGUE_HOSTINGER_2026-10-27.md y evidencia técnica del VPS.
- Informes de CI/PR asociados al SHA de cada repositorio.

La carpeta de esta actualización no duplica artefactos sensibles ni contiene respaldos, tokens, correos reales o fotografías faciales. Adjuntar reportes de pruebas redactados antes de la distribución final.


## Alcance de la revisión local del 4 de noviembre de 2026

No se ejecutaron pruebas del nuevo registro, correo, aceptación de términos ni consentimiento. Antes de reportar aceptación se requiere evidencia del mismo SHA integrado para: adulto y menor; código válido, incorrecto, expirado y reenviado; aceptación y rechazo del acudiente; persistencia del consentimiento y versión del aviso; autorización de endpoints; migración desde esquema previo y arranque del backend. La existencia de scripts o código local no equivale a evidencia de aprobación.
