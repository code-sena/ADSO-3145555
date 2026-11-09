# Punto 6: verificación de instalación y reprueba automática

FaceLit · 5 de noviembre de 2026 · America/Bogota. Revisión asistida del entorno local de María José.

## Resultado y alcance

**La reprueba integral automática con datos ficticios fue satisfactoria.** Se comprobó arranque del backend, login, registro facial mediante inferencia controlada, asistencia, persistencia, consulta de reportes, importación CSV y navegación de aprendiz e instructor desde el frontend web. Se conservan el primer intento fallido y la corrección de la espera del navegador.

La usuaria solicitó limitar esta revisión a pruebas automáticas con datos ficticios. **Esto no certifica reconocimiento de una persona real, captura de cámara, envío SMTP, despliegue de Hostinger ni aceptación del instructor.** Si el criterio de cierre del punto 6 exige cámara y reconocimiento real, el punto permanece parcial hasta esa prueba y su validación por el equipo/instructor. No se marcan aprobaciones ajenas.

La reprueba ejecutó un caso integral sin fallos, errores ni omisiones. El navegador registró dos avisos de Suspense recuperables y ningún error fatal, según [su registro](attempt-2-browser/runtime.json). Surefire emitió un aviso de canal por la salida heredada del navegador; el mensaje `PASS browser` quedó en [la salida nativa conservada](logs/attempt-2-browser-native-output.log), y el resultado JUnit fue satisfactorio. Los avisos se conservan como límites observados; no se afirma que la consola estuviera libre de advertencias.

## Matriz de evidencias

| Comprobación | Resultado | Evidencia |
| --- | --- | --- |
| Backend con configuración local existente | Arranque completo, conexión PostgreSQL y Tomcat 8080 | [Log de arranque saneado](backend-startup.log) |
| Base nueva de prueba | Liquibase validate correcto y 47 cambios aplicados | [Migraciones de reprueba](logs/attempt-2-liquibase-update.log) |
| Acceso con cuentas ficticias | Login HTTP/JWT y navegación web de aprendiz e instructor aprobados | [Resultado automático](automatic-test-results.json), [log HTTP](logs/attempt-2-http-e2e.log) |
| Servicio facial real instalado | Contenedor saludable; `/health` HTTP 200 en el puerto publicado 8091 | [Inspección inicial](runtime-inspection.json) |
| Modelo real, caso negativo sintético | HTTP 400: no se detectó rostro en cuadros negros; rechazo esperado | [Resultado de prueba negativa](facial-synthetic-probe.json) |
| Flujo facial positivo automático | Registro y asistencia con inferencia determinista; reglas de vida, API y persistencia reales | [Log de integración](logs/attempt-2-http-e2e.log) |
| Frontend y flujo de consulta | Login, pantalla de registro y matriz de asistencia comprobados en navegador | [Captura de aprendiz](attempt-2-browser/apprentice-registration.png), [captura de instructor](attempt-2-browser/instructor-attendance.png) |
| Inicialización de coordinadora | Pruebas focalizadas de creación/login, repetición, rotación y rechazo de entradas inválidas | [Resumen de pruebas](bootstrap-summary.json) |
| Reconocimiento positivo con cámara real | No ejecutado, por alcance solicitado | Requiere prueba adicional autorizada y evidencia |

## Versiones utilizadas

| Repositorio | Commit base probado |
| --- | --- |
| FaceLit | `6efd92cdd7e4e358b131cbe860cd8585d13e5550` |
| FaceLit-Backend | `2ba739853a808c8e5902f70eae98706a612f91e6` |
| FaceLit-DB | `096cd3e99d6936a7dacfe4b216b5e548f0a6eaf8` |
| micro-facial | `166e4a7f2245456277d57015259c678d8febfa9f` |

Los cuatro árboles estaban limpios al comenzar. El segundo intento utiliza además una **corrección local sin commit** de `FaceLit/scripts/test-architecture-browser.cjs`, realizada después de que el runner guardara sus revisiones iniciales y antes de cargar el subproceso del navegador. [Manifiesto y SHA-256 de esa corrección](harness-correction.json); [parche](browser-harness-correction.patch). No se atribuye el cambio local al commit base. La exportación web fue generada desde el frontend indicado con `EXPO_PUBLIC_API_URL=http://127.0.0.1:18080` y reutilizada sin reconstrucción en la reprueba.

El runner reutilizó la imagen facial local `facelit-embedding-service-embedding-service:latest`, montando el código `app/` y los fixtures de este checkout en solo lectura. La prueba acredita esos archivos con las dependencias instaladas de esa imagen; no acredita una construcción nueva sin caché de cada dependencia.

## Incidencias, correcciones y reprueba

| ID | Hallazgo inicial | Acción realizada | Resultado / límite |
| --- | --- | --- | --- |
| INST-01 | Las capturas anteriores terminaban antes del arranque completo de Spring Boot | Iniciar el backend habitual y conservar la salida final | `Started BackendApplication` y Tomcat 8080 confirmados. Se cerró únicamente el proceso iniciado para esta revisión |
| INST-02 | El puerto facial local publicado es 8091, mientras que el ejemplo general usa 8090 | Registrar el puerto real y comprobar `/health` en 8091 | HTTP 200; usar el puerto realmente publicado al configurar el backend. No se modificaron `.env` privados |
| INST-03 | El primer navegador agotó 30 s esperando `networkidle` al entrar a la pantalla facial; aparecieron conexiones PostgreSQL cerradas y avisos de pausa de hilos | Conservar el intento completo. Cambiar la espera de navegación a `domcontentloaded`, manteniendo las aserciones funcionales. Repetir en un proyecto aislado nuevo con la misma web | Reprueba satisfactoria. La causa última de las conexiones cerradas del primer intento no se atribuye sin más al código de negocio |
| INST-04 | Primer sondeo negativo del modelo agotó 45 s mientras se compilaba la web | Repetir con cuadros sintéticos de 160×160 y sin el backend adicional de revisión | Rechazo esperado HTTP 400. Al cambiar tamaño y carga, no se presenta como una medición comparativa de rendimiento |
| INST-05 | Captura antigua muestra error de inicialización de coordinadora sin causa completa | Ejecutar pruebas automáticas focalizadas sobre una base H2 de pruebas, con correo simulado | Casos automatizados aprobados. No se recreó ni rotó la cuenta real del entorno de María José; la causa histórica de su error no queda diagnosticada |
| DOC-01 | Informe de trabajo en equipo citaba dos archivos omitidos | Incorporar CSV y JSON originales y verificar conteos | [Archivos y verificación](../team-contributions/README.md) |

## Cómo repetir la prueba automática

Desde la carpeta que contiene los cuatro repositorios, con Docker activo y los puertos de prueba libres:

```powershell
.\FaceLit-DB\scripts\test-architecture-e2e.ps1 -Browser -PlaywrightModule "<RUTA_LOCAL_AL_MODULO_PLAYWRIGHT>"
```

La ejecución registrada reutilizó una imagen local compatible mediante `-SkipImageBuild -MicroImage facelit-embedding-service-embedding-service:latest`. La reprueba añadió `-WebExport` apuntando a la exportación del primer intento. Esas rutas dependen del equipo. La corrección del script de navegador debe estar presente antes de iniciar una nueva corrida.

El runner crea una base nueva en `127.0.0.1:55439`, FastAPI de prueba en `18090`, backend en `18080` y web en `18081`. Usa inferencia determinista y correo simulado. El backend, JWT, reglas de vida, SQL y PostgreSQL son reales. El runner elimina únicamente sus contenedores, red y volumen temporales al terminar, y guarda registros en `FaceLit-DB/.tmp/<proyecto>/`. No usa la base habitual en 5439 ni el VPS.

Las pruebas de coordinadora se ejecutaron con:

```powershell
cd FaceLit-Backend
.\mvnw.cmd -o "-Dtest=CoordinatorBootstrapIntegrationTest,CoordinatorBootstrapRunnerTest" test
```

Estas últimas usan el perfil H2 de prueba de su clase y no sustituyen una prueba del comando interactivo sobre la cuenta instalada. Las imágenes de cámara y credenciales privadas no forman parte de este paquete.

## Pendiente para una aceptación integral con cámara

1. El equipo confirma que la prueba automática satisface o no el alcance académico del punto 6.
2. Si se requiere cámara: con cuentas de prueba autorizadas, realizar registro facial y retos de vida, abrir una sesión como instructor y registrar asistencia con el rostro; comprobar el reporte y la persistencia. Conservar resultado esperado/obtenido, fecha, commits y evidencia sin imágenes biométricas públicas.
3. Si se corrige código, registrar el nuevo commit y repetir el flujo afectado. No reutilizar estos resultados como certificación de una versión posterior.

Los videos y sus enlaces no se modificaron. El presente registro complementa las capturas anteriores y no altera sus resultados históricos.
