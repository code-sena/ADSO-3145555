# Aportes del equipo y actividad registrada en Git

FaceLit - soporte documental para README, team-roster y registro del software. Revisión del 5 de noviembre de 2026.

## Cómo interpretar este informe

Los roles principales fueron confirmados por el equipo: Valery, frontend; Mariana, microservicio facial; María José, backend Java y base de datos. Se contrastan con commits, archivos modificados y muestras de diferencias de los cinco repositorios públicos.

Los porcentajes de este informe representan frecuencia de commits sin merge, no porcentaje del trabajo, esfuerzo, calidad, propiedad intelectual ni calificación. Una persona puede registrar trabajo colectivo o publicar documentos preparados por otras; un commit puede ser mínimo o incluir cambios extensos. La ausencia de commits en un repositorio no acredita ausencia de trabajo.

## Roles y aportes que pueden describirse

| Integrante | Rol principal confirmado | Aportes adicionales observados |
|---|---|---|
| Valery Sinaí Trujillo Quintero | Frontend | Pantalla de acceso, landing y guía descargable; documentación final; colaboración en integración y servicio facial. |
| Mariana Valenzuela Penagos | Microservicio facial | MediaPipe y retos; también registra cambios de ambientes, esquema/migraciones, backend y material documental. |
| María José Rodríguez Oyola | Backend Java y base de datos | Autorización de asistencia, inicialización de coordinación, persistencia y pruebas/CI de migraciones; colaboración en cliente y servicio facial. |

Las responsabilidades no son exclusivas. Los porcentajes no sustituyen esta distribución acordada ni identifican por sí solos quién diseñó o resolvió cada tarea fuera de Git.

## Identidades agrupadas

Valery: valerysinai y nombre completo en metadatos; el equipo también identificó la variante ValerySinay. Mariana: pemarival, nombre completo y vamaripe; el equipo confirmó el alias con correo alternativo. María José: MariaOyola, Majo_Rodriguz, Maria Jose y Majo-2007, agrupados por la confirmación recibida del equipo. No se publican correos ni números de documento en este informe.

GitHub permitió comprobar la cuenta vinculada en commits representativos de valerysinai, pemarival, MariaOyola y Majo-2007. Los alias sin cuenta vinculada se agruparon solo después de la confirmación del equipo. Las otras cuentas no se asignan a ninguna de las tres integrantes.

## Porcentaje de commits humanos sin merge en main

Fórmula por repositorio: commits sin merge de la integrante / total de commits humanos sin merge del repositorio x 100. Los commits de otras cuentas humanas permanecen en el denominador. Se excluyen bots y merges; cada SHA distinto cuenta una vez por repositorio. No se deduplican parches repetidos con SHA diferente. Los redondeos pueden producir una suma de 99.99 o 100.01.

| Componente | Valery | Mariana | María José | Otras cuentas | Total humano |
|---|---|---|---|---|---|
| facelit-docs | 5 (38.46%) | 8 (61.54%) | 0 (0.00%) | 0 (0.00%) | 13 |
| FaceLit | 51 (27.13%) | 68 (36.17%) | 69 (36.70%) | 0 (0.00%) | 188 |
| FaceLit-Backend | 12 (10.62%) | 34 (30.09%) | 67 (59.29%) | 0 (0.00%) | 113 |
| FaceLit-DB | 6 (4.08%) | 98 (66.67%) | 34 (23.13%) | 9 (6.12%) | 147 |
| micro-facial | 5 (17.24%) | 13 (44.83%) | 11 (37.93%) | 0 (0.00%) | 29 |

Cada celda muestra número de commits y porcentaje del repositorio, no avance del producto. Por ejemplo, 67/113 = 59.29% en backend para las cuentas de María José.

## Distribución global de esta métrica

| Grupo | Commits humanos sin merge | Proporción de los cinco repositorios |
|---|---|---|
| Valery | 79 | 16.12% |
| Mariana | 221 | 45.10% |
| María José | 181 | 36.94% |
| Otras cuentas | 9 | 1.84% |

Base auditada: 677 commits alcanzables desde los cinco main fijados; se excluyen 185 merges y 2 commits de bots. Quedan 490 commits humanos sin merge. No se normaliza el peso de los repositorios ni el tamaño de los cambios: esta tabla no permite concluir quién hizo más trabajo total.

## Dónde se concentra la actividad registrada de cada una

| Integrante | Concentración de sus propios commits | Interpretación limitada |
|---|---|---|
| Valery | Frontend: 51 de 79, 64.56%. | Coincide con el rol principal declarado; también hay actividad en otros componentes. |
| Mariana | Base de datos: 98 de 221, 44.34%; servicio facial: 13, 5.88%. | Su rol acordado es facial; el historial refleja además una participación amplia en datos e integración. |
| María José | Backend y DB juntos: 101 de 181, 55.80%; frontend: 69, 38.12%. | Responsabilidad backend/DB con colaboración visible en el cliente y otros servicios. |

Estos porcentajes usan como denominador los commits de cada persona; no son los porcentajes de la tabla por repositorio. El reparto por número de commits puede diferir de la especialidad o de las horas invertidas.

## Valery

- [FaceLit 8231d8c](https://github.com/FaceID-Proyect-2026/FaceLit/commit/8231d8c3a9a6843f5d967b0e2a2c9553710b9987): Separación de pantalla de acceso, estilos y transición; cambios de interfaz/accesibilidad.
  Archivos observados: app/auth/login.tsx; features/auth/components/LoginTransitionOverlay.tsx.
- [FaceLit d3e4a4b](https://github.com/FaceID-Proyect-2026/FaceLit/commit/d3e4a4bd9914d150a805993af55529fb820953d9): Enlace de descarga de guía de usuario en la landing y traducciones.
  Archivos observados: features/landing/screens/LandingScreen.tsx; public/facelit-guia-para-usuarios.pdf.
- [facelit-docs 2993404](https://github.com/FaceID-Proyect-2026/facelit-docs/commit/299340428bc7b04fa013cd1b4d034f673b9d3dbc): Actualización documental del despliegue integral en Hostinger y sus referencias.
  Archivos observados: 01_Documento_General_Proyecto/01_Documento_General_Proyecto.md; 01_Documento_General_Proyecto/01_Documento_General_Proyecto.pdf.
- [micro-facial 1681b18](https://github.com/FaceID-Proyect-2026/micro-facial/commit/1681b1801aeff05223616946aa80c00f8c612dec): Refactorización de dependencias y puertos del servicio facial; colaboración fuera del frontend.
  Archivos observados: app/api/dependencies.py; app/api/v1/router.py.

## Mariana

- [micro-facial f547a73](https://github.com/FaceID-Proyect-2026/micro-facial/commit/f547a73f409a3eff493f83c876a4c8b34fc9db90): Incorporación histórica de MediaPipe y métricas faciales en worker/servicio.
  Archivos observados: Dockerfile; app/services/facial_embedding_service.py.
- [micro-facial 53efb88](https://github.com/FaceID-Proyect-2026/micro-facial/commit/53efb88f60c1139e7b0e37cf8ea295467b24c02b): Ajustes históricos de validación de retos de vida; algunos retos fueron retirados después.
  Archivos observados: app/services/facial_embedding_service.py; app/workers/face_embedding_worker.py.
- [FaceLit-DB 57205fb](https://github.com/FaceID-Proyect-2026/FaceLit-DB/commit/57205fb3738f6da741e918d7629cb2074b41bef9): Compatibilidad de migración del aviso y su rollback.
  Archivos observados: 05_rollbacks/06_migrations/002_privacy_notice_version.rollback.sql; 06_migrations/002_privacy_notice_version.changelog.yaml.
- [FaceLit 4b6f32d](https://github.com/FaceID-Proyect-2026/FaceLit/commit/4b6f32dc89eb01ed294da364a87fcc6336ff1e1d): Flujo de gestión de ambientes y asociaciones desde coordinación en frontend.
  Archivos observados: README.md; app/admin/environments/[id].tsx.
- [FaceLit-Backend 0e367b2](https://github.com/FaceID-Proyect-2026/FaceLit-Backend/commit/0e367b261e362b46d742d19006ceebd8f1c73626): API, permisos y asignaciones de ambientes en backend.
  Archivos observados: src/main/java/com/FaceLit/backend/config/SecurityConfig.java; src/main/java/com/FaceLit/backend/environment/controller/EnvironmentController.java.
- [facelit-docs c04f3de](https://github.com/FaceID-Proyect-2026/facelit-docs/commit/c04f3deb0e3ff5386e45739a9dffe4c24a9ff780): Registro de enlaces a diseño web y manual de marca; no demuestra autoría exclusiva de todos sus contenidos.
  Archivos observados: Diseño web/README.md; Manual de marca/README.md.

## Maria Jose

- [FaceLit-Backend c597052](https://github.com/FaceID-Proyect-2026/FaceLit-Backend/commit/c5970522984c014d5a30146c5e0a5c03d6e41b43): Inicialización de coordinación, sesiones persistentes y pruebas de integración.
  Archivos observados: README.md; docs/HU46_COORDINADOR_QA.md.
- [FaceLit-Backend 3cde331](https://github.com/FaceID-Proyect-2026/FaceLit-Backend/commit/3cde331d2f110445fdd1c127c7dd89a167024be6): Autorización de asistencia y coordinación de captura facial en Java.
  Archivos observados: src/main/java/com/FaceLit/backend/academic/dto/response/academic/UserChipResponseDTO.java; src/main/java/com/FaceLit/backend/auth/model/enums/Language.java.
- [FaceLit-DB 16e867d](https://github.com/FaceID-Proyect-2026/FaceLit-DB/commit/16e867dd2aafb9a332088c2e6db7735777746876): Workflow y documentación para verificar rollback y preservación del esquema.
  Archivos observados: docs/HU-47-POSTGRES-CI.md.
- [FaceLit-DB a5e5f9e](https://github.com/FaceID-Proyect-2026/FaceLit-DB/commit/a5e5f9e27c6d57ee63a224bfa5c5f90dbec376f8): Retiro del seed de coordinación y procedimiento de inicialización segura.
  Archivos observados: 02_dml/00_inserts/0000changelog.yaml; README.md.
- [FaceLit ceb3f3b](https://github.com/FaceID-Proyect-2026/FaceLit/commit/ceb3f3b91447bfdc2c0a5ebd6fa09c266e0c5954): Validaciones y pruebas del servicio cliente de asistencia facial.
  Archivos observados: shared/services/facialAttendanceService.ts; tests/services.test.js.
- [micro-facial d2571c5](https://github.com/FaceID-Proyect-2026/micro-facial/commit/d2571c52be4158657ccfa0084983f107718d1529): Caché de inferencia, aislamiento del worker y pruebas del servicio facial.
  Archivos observados: app/core/config.py; app/main.py.

## Alcance, exclusiones y resultados de revisión

Se inspeccionó el historial completo alcanzable desde main y se contrastó con todas las ramas descargadas. Los commits de ramas no integradas no entran en los porcentajes principales. Los archivos actualmente presentes en una rama y los cambios desplegados sin commit no quedan atribuidos por esta métrica.

No se contaron líneas añadidas/eliminadas como porcentaje: binarios, reorganizaciones, archivos generados y borrados pueden distorsionar el resultado. No se utiliza git blame para inferir autoría original ni se atribuye un cambio de bot a quien abrió el PR. Los dos commits de bot incluidos en main tienen trailers de coautoría; se conservan en el registro para revisión, sin repartir fracciones ni sumarlos a las integrantes.

Los otros nueve commits humanos de main se encuentran en FaceLit-DB. Son parte del historial recibido y no se distribuyen entre el equipo actual. Su presencia no cambia automáticamente las personas precargadas en las plantillas de registro; cualquier revisión de autoría/titularidad corresponde al equipo y al instructor.

La evidencia seleccionada demuestra cambios registrados, no ejecución aprobada ni vigencia actual de todos los fragmentos históricos. No se ejecutó el software ni se midieron horas, dificultad, trabajo en pareja, pruebas manuales o elaboración fuera de Git.

## Cortes reproducibles

| Repositorio | Commit main analizado | Merges excluidos | Commits adicionales sin merge en otras ramas |
|---|---|---|---|
| [facelit-docs](https://github.com/FaceID-Proyect-2026/facelit-docs) | [299340428bc7](https://github.com/FaceID-Proyect-2026/facelit-docs/commit/299340428bc7b04fa013cd1b4d034f673b9d3dbc) | 0 | 0 |
| [FaceLit](https://github.com/FaceID-Proyect-2026/FaceLit) | [6efd92cdd7e4](https://github.com/FaceID-Proyect-2026/FaceLit/commit/6efd92cdd7e4e358b131cbe860cd8585d13e5550) | 61 | 29 |
| [FaceLit-Backend](https://github.com/FaceID-Proyect-2026/FaceLit-Backend) | [2ba739853a80](https://github.com/FaceID-Proyect-2026/FaceLit-Backend/commit/2ba739853a808c8e5902f70eae98706a612f91e6) | 43 | 16 |
| [FaceLit-DB](https://github.com/FaceID-Proyect-2026/FaceLit-DB) | [cd069ae0cb49](https://github.com/FaceID-Proyect-2026/FaceLit-DB/commit/cd069ae0cb4947d4b7ebbff17e9d6dc280ab86fd) | 72 | 2 |
| [micro-facial](https://github.com/FaceID-Proyect-2026/micro-facial) | [166e4a7f2245](https://github.com/FaceID-Proyect-2026/micro-facial/commit/166e4a7f2245456277d57015259c678d8febfa9f) | 9 | 6 |

## Cómo reproducir y comprobar

En una copia completa de cada repositorio: git log <SHA-main> --no-merges --format="%H %an" para listar commits y autores. El registro CSV adjunto incluye todos los commits de main, indicador de merge/bot, clasificación utilizada, fecha original y URL para abrir la evidencia. Los alias fueron consolidados según la confirmación del equipo; ese paso debe repetirse para obtener los mismos grupos.

La fecha del commit no determina su pertenencia al corte: se utiliza alcanzabilidad desde los cinco SHA. Los commits con fecha irregular permanecen en el conteo si son alcanzables. Un merge con resoluciones propias queda fuera de la métrica principal; esa exclusión es una limitación, no una afirmación de que integrar no tenga valor.

## Uso en la entrega

README y team-roster describen el rol principal y las colaboraciones respaldadas; software-registration resume el aporte. Este informe y contribution-ledger.csv aportan trazabilidad. No se marcaron autorizaciones personales, se asignaron calificaciones ni se definieron porcentajes de derechos de autor. Cada integrante debe revisar la descripción final de sus aportes.
