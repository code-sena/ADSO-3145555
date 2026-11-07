# Matriz de requisitos y cobertura de la entrega

**Estado:** versión de trabajo actualizada para la estructura `04-final-delivery/07-hidro-smart`.
**Corte documental:** 2026-11-05.

## 1. Propósito y fuentes

Esta matriz relaciona los requisitos de la entrega SENA con los documentos y evidencias disponibles. PT_HS es la fuente canónica elegida para decidir el alcance funcional; los repositorios separados de backend, frontend, base de datos, firmware y documentación se consultan para consolidar aportes y detectar diferencias. Sus checkouts locales están en ramas distintas y no se consideran una única versión integrada.

El SRS convertido conserva requisitos y antecedentes de su documento académico. Sus afirmaciones no equivalen automáticamente a funciones implementadas ni probadas. Para una entrega final, se deben validar requisitos contra un mismo commit/tag integrado y asociar los resultados de prueba a ese identificador.

## 2. Cobertura de los entregables

| Entregable | Archivo(s) de esta carpeta | Estado actual | Cierre requerido |
|---|---|---|---|
| Datos generales y resumen | `README.md` | Borrador actualizado | Completar fecha, responsable, tag/SHA y confirmar semillero. |
| Equipo y aportes | `team-roster.md` | Actividad consolidada entre PT_HS y repos separados | Confirmación de nombres, roles y aportes; instructor confirma contribuciones fuera de Git. |
| Registro de software | `software-registration.md` | Borrador con datos técnicos conocidos | Solicitante, autores/productor, titularidad, año, versión y declaraciones confirmadas. |
| Especificación de requisitos | requirements-specification.md | SRS académico convertido, cifras de contexto corregidas y anexo cotejado estáticamente con PT_HS `main` (`32be1cf`) | Aceptar requisitos con el equipo y asociar cada estado de implementación con una prueba de la versión final. |
| Matriz de requisitos | Este archivo | Actualizada a la estructura de entrega actual | Añadir ID/resultado de pruebas cuando se cierre cada requisito. |
| Análisis del sistema | system-analysis.md | Borrador presente | Cotejar actores, flujos y permisos con la versión final. |
| Propuesta técnica | technical-proposal.md | Borrador presente con contenido histórico | Reconciliar stack, costos, cifras y beneficios; no presentar estimaciones como resultados medidos. |
| Diseño de software | software-design/ | Borradores, diagramas y wireframe presentes | Revisar diagramas y modelos contra código/migraciones; corregir cualquier referencia a entregables que no existan. |
| Pruebas | test-documentation/ | Plan, resultados históricos y consulta de GitHub Actions para PT_HS `main` (`32be1cf`) | Las dos ejecuciones de workflow y los nueve check-runs consultados terminaron `success`; el endpoint de commit status sigue `pending` con cero contextos. No declarar verde el estado combinado. No se encontraron ejecuciones de Actions para `main` en los repositorios separados durante esta consulta. Repetir la consulta al fijar el tag. |
| Implementación y operación | implementation-procedure/ | Fuentes Markdown y PDF presentes | Validar desde clon limpio y confirmar pasos y URLs. |
| Mejora | improvement-actions/ | Borrador presente | Confirmar responsables, estado, evidencia y fecha de cierre de acciones. |
| Manuales | manuals/ | Manual técnico, instalación y usuario presentes | Validar pasos, pantallas y funciones contra el artefacto final. |
| Artículo | project-article/ | Borrador presente | Comprobar resultados y referencias; no afirmar métricas sin evidencia. |
| Videos | `10-videos/README.md` | Enlace Canva recibido para explicación | Verificar duración/acceso y clasificarlo; falta el tutorial corto obligatorio. El video de despliegue es complementario. |
| Código y trazabilidad | `code-tag/README.md`, `code-tag/SHA256SUMS.txt` | Estructura incompleta | Completar repositorios, tag/SHA, ZIP, hashes y Release después de aprobar la versión. |

## 3. Trazabilidad funcional

Los requisitos detallados permanecen en el SRS. Esta tabla agrupa los flujos que deben enlazarse con casos de prueba y evidencia al cerrar la versión final.

| Área | Requisito/flujo a verificar | Evidencia que debe quedar en `05-test-documentation/` |
|---|---|---|
| Identidad y acceso | Registro, verificación de correo, login, recuperación, refresh, logout, CSRF y permisos por rol | Casos con respuesta esperada, resultado real y evidencia sin tokens ni datos personales. |
| Hogares | Crear/consultar hogares, miembros, cambio de hogar y permisos Owner/Guest/Admin | Casos por rol y confirmación de aislamiento de datos. |
| Dispositivos | Vincular, configurar, desvincular y volver a aprovisionar el ESP32 | Evidencia de API y, para BLE, prueba en equipo físico/nativo. |
| Telemetría | ESP32 → MQTT/TLS → backend → PostgreSQL → dashboard; deduplicación y estado de medición | Logs redactados, timestamp, identificador de mensaje no secreto y lectura visible. Repetir sobre el tag final. |
| Consumo y reportes | Consultar periodos, generar reportes y mostrar datos persistidos | Casos con dataset controlado y resultados descargados, sin datos reales privados. |
| Alertas | Configurar umbrales/modo de medición, disparar, consultar y atender alerta | Caso que demuestre condición, alerta generada y tratamiento; separar simulación de prueba física. |
| Correo | Verificación, reenvío y recuperación mediante Brevo | Confirmación de API y recepción real; ocultar direcciones completas, API keys y enlaces de un solo uso. |
| Operación | Build, instalación, despliegue, migración y recuperación | Comandos reproducibles, versiones, commit y resultado. No afirmar restauración real si no se ejecutó. |

## 4. Evidencia técnica disponible y límites

**CI:** La carpeta `05-test-documentation/ci-evidence.md` distingue CI histórica de HU-20 y la consulta remota del `main` actual. No se debe declarar aprobado el estado combinado mientras figure `pending` ni extrapolar los checks de PT_HS a los repositorios separados.

**Web:** La URL indicada es `https://pt-hs.pages.dev/login`; su registro en documentos no prueba disponibilidad al momento de la entrega.

**Video:** Se aportó un enlace Canva para una explicación del proyecto; falta verificar su duración, permisos y correspondencia con los criterios del pitch/tutorial.

**Repositorios:** Reflejan trabajo y antecedentes de componentes, pero la entrega debe identificar claramente qué código integrado se registra y qué repositorios son espejos, forks o fuentes complementarias.

## 5. Datos institucionales por confirmar

En la documentación disponible aparecen la ficha `3145555`, el programa ADSO `228118` y el código de reporte formativo `2678382`. No se deben intercambiar esos identificadores: confirmar en la pauta oficial qué campo corresponde a cada uno y cuál debe aparecer en el formulario de entrega.

El año de los documentos académicos de origen puede ser histórico. El año para el registro del software debe corresponder a la versión final que se registre; no copiar automáticamente el año del SRS.

## 6. Criterio de cierre

La entrega alcanza estado final cuando cada requisito tiene una clasificación clara —implementado, probado, pendiente o fuera de alcance—, cada afirmación de “probado” apunta a evidencia de la misma versión, los documentos enlazan entre sí correctamente y los ZIP/tag/SHA corresponden al commit aprobado. Hasta entonces, los estados de esta matriz son de borrador.
