# Matriz de requisitos y cobertura de la entrega

**Estado:** candidata final documentada para la estructura `04-final-delivery/07-hidro-smart`.
**Corte documental:** 2026-11-07.

## 1. Propósito y fuentes

Esta matriz relaciona los requisitos de la entrega SENA con los documentos y evidencias disponibles. PT_HS es la fuente canónica elegida para decidir el alcance funcional; los repositorios separados de backend, frontend, base de datos, firmware y documentación se consultan para consolidar aportes y detectar diferencias. Sus checkouts locales están en ramas distintas y no se consideran una única versión integrada.

El SRS convertido conserva requisitos y antecedentes de su documento académico. Sus afirmaciones no equivalen automáticamente a funciones implementadas ni probadas. Para una entrega final, se deben validar requisitos contra un mismo commit/tag integrado y asociar los resultados de prueba a ese identificador.

## 2. Cobertura de los entregables

| Entregable | Archivo(s) de esta carpeta | Estado actual | Cierre requerido |
|---|---|---|---|
| Datos generales y resumen | `README.md` | Completado para la entrega: fecha, responsable, URL, integrantes y versión registrados | Confirmar el semillero únicamente si el instructor lo exige como campo obligatorio. |
| Equipo y aportes | `team-roster.md` | Roles y autorización de publicación de datos confirmados por el equipo | Confirmar autoría legal y aportes ante el instructor si se usarán en el trámite DNDA. |
| Registro de software | `software-registration.md` | Preparado para la entrega con secciones 5 y 6 y responsable identificados | Completar en el trámite externo la calidad de representación, productor, titularidad y transferencia, si aplica. |
| Especificación de requisitos | requirements-specification.md | SRS académico convertido, cifras de contexto corregidas y anexo cotejado contra el alcance del tag `final-delivery-2026` de PT_HS (`8dd45ca`) | Asociar cada estado de implementación con una prueba de la versión final. |
| Matriz de requisitos | Este archivo | Actualizada a la estructura de entrega actual | Añadir ID/resultado de pruebas cuando se cierre cada requisito. |
| Análisis del sistema | system-analysis.md, system-analysis.pdf | Fuente Markdown y PDF complementario incluidos | Cotejar actores, flujos y permisos con la versión final. |
| Propuesta técnica | technical-proposal.md | Borrador presente con contenido histórico | Reconciliar stack, costos, cifras y beneficios; no presentar estimaciones como resultados medidos. |
| Diseño de software | software-design/ | Borradores, diagramas y wireframe presentes | Revisar diagramas y modelos contra código/migraciones; corregir cualquier referencia a entregables que no existan. |
| Pruebas | test-documentation/ | Plan, resultados históricos y evidencia de CI acotada; tags y Release verificados | Ejecutar CI y pruebas funcionales sobre el SHA exacto del tag si la rúbrica exige una corrida reciente. |
| Implementación y operación | implementation-procedure/ | Fuentes Markdown y PDF presentes, URL documentada y Release público disponible | Aportar evidencia de disponibilidad y smoke test de producción. |
| Mejora | improvement-actions/ | Borrador presente | Confirmar responsables, estado, evidencia y fecha de cierre de acciones. |
| Manuales | manuals/ | Manual técnico, instalación y usuario presentes | Validar pasos, pantallas y funciones contra el artefacto final. |
| Artículo | project-article/ | Borrador presente | Comprobar resultados y referencias; no afirmar métricas sin evidencia. |
| Videos | `10-videos/README.md` | Pitch y tutorial registrados; ambos enlaces Drive responden HTTP 200 sin autenticación | Confirmar duración y contenido mediante revisión visual. |
| Código y trazabilidad | `code-tag/README.md`, `code-tag/SHA256SUMS.txt` | Seis repositorios, tags, 12 ZIP, Release y SHA-256 verificados | Mantener los enlaces públicos y conservar la trazabilidad durante la revisión. |

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

**CI:** La carpeta `05-test-documentation/ci-evidence.md` distingue evidencia histórica de CI y la versión exacta de los tags. No se debe declarar aprobado el estado combinado mientras figure `pending` ni extrapolar los checks de PT_HS a los repositorios separados.

**Web:** La URL indicada es `https://pt-hs.pages.dev/login`; está registrada en la entrega, pero todavía debe conservarse un smoke test reproducible de la versión candidata.

**Video:** Se registraron enlaces Drive separados para pitch y tutorial. Ambos responden sin autenticación; falta verificar duración y correspondencia con los criterios de contenido.

**Repositorios:** La entrega identifica seis repositorios originales y usa los tags `final-delivery-2026` como versión exacta. Los `main` posteriores pueden contener commits descendientes; no deben confundirse con el contenido de los ZIP del Release.

## 5. Datos institucionales por confirmar

En la documentación disponible aparecen la ficha `3145555`, el programa ADSO `228118` y el código de reporte formativo `2678382`. No se deben intercambiar esos identificadores: confirmar en la pauta oficial qué campo corresponde a cada uno y cuál debe aparecer en el formulario de entrega.

El año de los documentos académicos de origen puede ser histórico. El año para el registro del software debe corresponder a la versión final que se registre; no copiar automáticamente el año del SRS.

## 6. Criterio de cierre

La entrega alcanza estado final cuando cada requisito tiene una clasificación clara —implementado, probado, pendiente o fuera de alcance—, cada afirmación de “probado” apunta a evidencia de la misma versión, los documentos enlazan entre sí correctamente y los ZIP/tag/SHA corresponden al commit aprobado. Hasta entonces, los estados de esta matriz son de borrador.
