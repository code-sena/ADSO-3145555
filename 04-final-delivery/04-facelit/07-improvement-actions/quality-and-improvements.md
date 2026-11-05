# FaceLit

## Calidad, seguridad y mejoras

**Estado funcional, evidencia y mejoras**

| Corte documental | Referencias de código |
|---|---|
| 4 de noviembre de 2026 | HEAD locales de `main`: FaceLit `6efd92c` · FaceLit-Backend `2ba7398` · micro-facial `166e4a7` · FaceLit-DB `cd069ae` |

**Autores:** María José Rodríguez Oyola · Valery Sinaí Trujillo Quintero · Mariana Valenzuela Penagos
**Programa:** SENA · Análisis y Desarrollo de Software
**Instructor:** José de Jesús Motta

> El equipo confirma que el inicio de sesión, la carga CSV, el correo SMTP, la cámara y la asistencia funcionan. Los resultados de octubre conservan el alcance de cada ejecución. Los commits de la tabla identifican las copias locales consultadas.

---

## 1. Alcance de calidad y evidencia

FaceLit combina cliente Expo, backend Spring Boot, servicio facial FastAPI y PostgreSQL con pgvector. La calidad del recorrido depende de la interfaz de captura, la autorización del backend, la persistencia y la consulta posterior.

| Tipo de evidencia | Qué permite afirmar | Qué no demuestra |
|---|---|---|
| Inspección estática de código | Existen rutas, validaciones, estados, servicios y mecanismos de persistencia citados. Se contrastaron con el árbol actual de los cuatro repositorios. | No certifica ejecución en producción ni aceptación con usuarios. |
| Pruebas automatizadas reportadas | Las suites indicadas aprobaron sus casos en su entorno/control de dependencias descrito. | No miden precisión biométrica con cámaras/personas reales, SMTP o experiencia móvil completa. |
| Chequeos del despliegue | Servicios, rutas y protocolo responden en las comprobaciones técnicas reportadas. | No equivalen a aceptación manual del proceso de negocio. |
| Reporte del equipo | El equipo comunicó que cámara, registros incompletos y traducciones fueron corregidos. | Sin evidencia antes/después no permite establecer causa histórica, porcentaje de mejora o aprobación de regresión. |

> **Criterios:** funcionalidad y autorización; usabilidad de cámara; integridad y persistencia; confiabilidad ante fallos/reintentos; internacionalización; rendimiento medido; privacidad biométrica; mantenibilidad y trazabilidad.

---

## 2. Incidencias y mecanismos actuales

### Cámara y captura

**Reporte:** el equipo informó que resolvió dificultades para visualizar y utilizar la cámara.

**Mecanismos observados:** en web, `WebCamera.tsx` solicita cámara frontal (640 × 480), gestiona permiso/error, muestra guía y advertencias, analiza muestras de imagen periódicamente y libera pistas al cerrar. En móvil, el hook usa `CameraView` y `takePictureAsync`. Las heurísticas de luz/estabilidad no prueban que exista un rostro ni certifican detección antifraude. La lógica web y móvil no es idéntica.

### Registro y persistencia

El hook de registro comprueba captura/estado y espera `registerFacialEmbeddingFromImage` antes de presentar éxito remoto. El servicio cliente envía a `POST /api/facial/embeddings/from-image` de Spring; Java coordina FastAPI. El fallback local es opcional y está desactivado por defecto. FastAPI confirma transacción o ejecuta rollback ante error. Esto respalda el flujo implementado, pero no demuestra que todo dato histórico esté completo.

### Traducciones

El cliente configura i18next/react-i18next y recursos para español, inglés, alemán y francés. Los componentes citados usan claves traducibles. La existencia de recursos y fallback español no garantiza que cada clave esté completa o lingüísticamente revisada en las cuatro lenguas. El reporte del equipo indica que corrigió las pantallas afectadas; falta evidenciar regresión por idioma y pantalla.

### Antes/después

| Área | Mecanismo o mejora reportada | Verificación necesaria |
|---|---|---|
| Cámara | Permisos, estados, guía visual y limpieza del stream. | Web y Android: permiso denegado, baja luz, rotación, reintento y cierre. |
| Registro | Espera respuesta del backend, estado de envío, manejo de error y persistencia en servicio. | Confirmar consulta tras recarga; probar fallo de red/servidor y duplicación. |
| Idioma | Recursos centralizados y cambio de idioma mediante i18n. | Revisar cobertura, interpolaciones, textos largos y cortes en cuatro idiomas. |

---

## 3. Pruebas y resultados reportados

Los siguientes resultados corresponden a ejecuciones separadas; no se suman como una única corrida.

| Ejecución | Resultado | Alcance y límite |
|---|---|---|
| micro-facial | 123 aprobadas; 1 prueba PostgreSQL optativa omitida. | Retos activos, secuencia, señales sintéticas y rechazos. No valida la prueba omitida ni precisión en personas reales. |
| Frontend FaceLit | 120 aprobadas en 13 suites; 6 scripts de regresión aprobados. | Flujos seleccionados, tipos y lint en módulos afectados. No certifica cámara física, SMTP ni lint global. |
| Integración HTTP | 19 comprobaciones de retos más registro, confirmación, autorización, asistencia, matriz y CSV. | Rutas HTTP y PostgreSQL desechable con 45 migraciones; inferencia determinista y correo simulado. |
| Producción Hostinger | HTTPS/web 200; health facial 200; API admin sin auth 401; WebSocket 101. | Comprobaciones de salud y configuración del 27 de octubre. |

> HU-45 mantiene cuatro retos: `MOVE_UP`, `MOVE_DOWN`, `MOVE_CLOSER` y `MOVE_AWAY`. La secuencia requiere dos retos distintos con siete capturas por reto. Las señales de pruebas son sintéticas; prueban reglas de aceptación/rechazo, no FAR/FRR. El umbral 0.65 es similitud, no 65 % de precisión.

### Incidencia de integridad en asistencia

El índice único parcial `uq_facial_event_attendance_once` en FaceLit-DB evita eventos activos duplicados para la combinación contemplada por la migración. La migración documenta limpieza de duplicados existentes antes de crear el índice. Su presencia en el repositorio no demuestra aplicación en toda instancia; verificar versión de Liquibase y probar inserción duplicada en QA.

---

## 4. Seguridad, privacidad y riesgos

| Riesgo / límite | Estado y tratamiento |
|---|---|
| Evaluación biométrica | No se presentó estudio representativo de falsas aceptaciones/rechazos ni bajo diversidad de cámaras, luz o participantes. Los retos no certifican resistencia a suplantación. |
| Datos faciales | Confirmar aviso, consentimiento/base de autorización, finalidad, accesos, retención, eliminación y respuesta a incidentes. Un embedding no debe describirse como anónimo. |
| Configuración del frontend | README conserva `EXPO_PUBLIC_EMBEDDING_API_URL` y `API_KEY` como referencias heredadas. El código revisado usa API de Spring; retirar referencias y verificar bundle antes de afirmar que no hay exposición. |
| Secretos | Revisar configuración de producción y rotar credenciales si se expusieron. No incluir valores, tokens o capturas con datos personales en documentación. |
| Backups | Restauración en entorno separado pendiente. Crear un respaldo no prueba que sea recuperable. |
| Dispositivos | Si se presenta Android, documentar el recorrido con el APK exacto y el dispositivo utilizado. |
| Rendimiento y disponibilidad | No hay medición formal de latencia/carga ni evidencia que sustente tiempos máximos o disponibilidad. |
| SRS y CI | Revisar requisito por requisito y checks remotos para SHA exactos; una ejecución antigua o un workflow presente no prueba aprobación de la versión final. |

> **Controles reportados:** JWT, hash BCrypt, autorización por rol/alcance, secreto facial en configuración privada del VPS, Caddy/HTTPS y servicios internos en red Docker; migraciones Liquibase coordinadas y respaldo previo. Son controles observados/reportados, no una certificación de ausencia de vulnerabilidades.

---

## 5. Mejoras priorizadas y cierre

| Prioridad | Trabajo | Criterio de cierre |
|---|---|---|
| Alta | Evaluación de biometría y retos con datos autorizados y condiciones diversas. | Protocolo, muestra, criterios y métricas FAR/FRR/errores documentados. |
| Alta | Medir latencia por captura, transporte, inferencia y persistencia. | Medición repetible con equipo/carga definidos; no prometer antes de medir. |
| Alta | Conservar evidencia de los flujos operativos y repetirlos en cada publicación. | Registrar versión, entorno y resultados para acceso, CSV, correo, cámara, asistencia y consulta. |
| Alta | Probar restauración y revisar credenciales/endpoints. | Restauración verificada en entorno separado; bundle, permisos, límites y rotación revisados. |
| Media | Actualizar trazabilidad SRS y validar APK/dispositivos. | Estado por requisito con criterio/evidencia/responsable; artefacto exacto instalado y probado. |
| Continua | Refactorizar por responsabilidad preservando contratos. | Cambios revisados y pruebas del flujo afectado; no usar reducción de líneas como métrica de calidad. |

### Registro de cada nueva validación

Guardar fecha/responsable, repositorios y SHA, comando/procedimiento, entorno, datos de prueba no identificables, resultado por caso, logs redactados, tipo de cámara/inferencia/correo y limitaciones. No mezclar conteos de ramas o fases distintas.

---

**Conclusión.** El código actual proporciona mecanismos para guiar captura, esperar confirmación remota, manejar errores y centralizar traducciones. El equipo reporta las tres incidencias corregidas y hay suites automatizadas aprobadas en los alcances descritos. El equipo confirma el funcionamiento de los flujos principales. Las mejoras incluyen medir el rendimiento y la precisión biométrica y ensayar la restauración de respaldos.

**Referencias internas:** `07_Pruebas/Pruebas_Evidencias_Actualizadas.md`, `09_Implementacion/09_Implementacion.md` y repositorios identificados en la portada.


## Antecedente de integración local del 4 de noviembre de 2026

En una revisión anterior de cambios locales ajenos al `main` consultado, el registro público y el consentimiento presentaban brechas que deben resolverse antes de aceptar el flujo: las entidades de consentimiento no tienen migración correspondiente en la cadena inspeccionada; la migración 025 está sin seguimiento y no se incluye desde el changelog padre; el servicio local de aceptación no asigna `noticeVersion`, aunque el modelo la requiere. También falta demostrar autorización efectiva de las operaciones legales. Estos son hallazgos de inspección estática, no resultados de pruebas ejecutadas.
