# Arquitectura, trazabilidad y verificación técnica de una plataforma web y móvil para operaciones gastronómicas: estudio de caso SaborExpress

**Yerson Stiven Cuéllar Rubiano** · SENA CIES, ADSO 3145555 · 3 noviembre 2026 / November 3, 2026

**Resumen.** Este estudio examina qué afirmaciones sobre la integración funcional de SaborExpress pueden sostenerse mediante evidencia de repositorios y pruebas identificadas por versión. Se empleó un estudio de caso documental y descriptivo, complementado con una revisión dirigida de literatura, extracción de contratos y análisis de registros de validación publicados. La plataforma integra una API ASP.NET Core 8, una interfaz Next.js y un cliente Expo/React Native, con procesos de pedidos, cocina, caja, pagos y domicilios. El informe documental del 3 de noviembre de 2026 registra 90 pruebas de seguridad, 62 de QA y 11 de facturación PDF aprobadas localmente en un candidato de backend, así como 7 pruebas web y 8 móviles sobre otros SHA; estas cifras describen conjuntos de pruebas de alcance limitado, no aceptación integral. Una verificación local de readiness del backend candidato respondió 503 por migraciones pendientes, mientras que un smoke de staging anterior fue satisfactorio. Se concluye que existe evidencia de implementación y verificación parcial, pero no de mejora causal, despliegue integral o aceptación de usuarios. Se proponen instrumentos y controles replicables para cerrar esas brechas.

**Palabras clave:** gestión gastronómica; ingeniería de software; estudio de caso; trazabilidad; validación; aplicaciones web y móviles

## I. INTRODUCCIÓN

Las operaciones de un restaurante conectan catálogo, sedes, personal, mesas, pedidos, cocina, caja y entregas. En sistemas multicliente, una modificación de estados o permisos en el servidor puede alterar la interacción web y móvil. La literatura sobre reparto de comida destaca confianza, calidad de servicio y experiencia de usuario [1]–[5], mientras que TAM y UTAUT orientan investigaciones sobre adopción [6], [7]. Ninguno de esos estudios acredita resultados de SaborExpress. Este trabajo aporta una cadena de evidencia que diferencia arquitectura declarada, pruebas observadas, limitaciones y acciones pendientes.

## II. PROBLEMA, PREGUNTA Y OBJETIVOS

Problema: la documentación previa caracterizó riesgos plausibles de inconsistencias de pedidos, pagos, sedes y reparto, sin una línea base levantada en un establecimiento real. El árbol analítico de problemas identifica como nodo central la insuficiente trazabilidad comprobada entre operaciones y evidencia de calidad; como causas hipotéticas, cambios contractuales entre clientes, permisos por sede no evaluados integralmente y dependencias externas; como posibles efectos, duplicidades o estados inconsistentes. Estas relaciones son hipótesis de trabajo, no incidentes medidos. Pregunta: ¿qué capacidades y resultados de verificación pueden identificarse de forma reproducible en el conjunto documental y técnico de SaborExpress, y qué validaciones faltan para sustentar preparación operativa? Objetivo general: caracterizar la arquitectura y valorar la suficiencia de evidencia de sus flujos críticos. Objetivos específicos: (1) identificar componentes y límites arquitectónicos; (2) relacionar riesgos con estándares y fuentes académicas; (3) tabular pruebas por SHA, entorno y alcance; (4) proponer instrumentos de validación funcional y con usuarios.

## III. MARCO DE REFERENCIA Y VIGILANCIA TECNOLÓGICA

La síntesis de Shroff et al. [1] y la revisión de Shankar et al. [2] contextualizan actores y sistemas de entrega digital. Prasetyo et al. [3], Fakfare [4] y Koay et al. [5] examinan atributos de satisfacción y calidad desde otros contextos. Davis [6] y Venkatesh et al. [7] sirven para operacionalizar utilidad, facilidad y aceptación futura, pero sus constructos todavía no han sido medidos aquí. Kruchten [8] fundamenta separar vistas arquitectónicas; Taibi et al. [9] ayuda a contrastar patrones sin afirmar que una aplicación modular sea una arquitectura de microservicios. Yin [10] orienta el estudio de caso; Kitchenham y Charters [11] ayudan a hacer explícitos criterios de selección bibliográfica. ISO/IEC 25010 [12] proporciona atributos de calidad, OWASP [13] orienta casos de autorización y RFC 9110 y 7519 [14], [15] describen contratos HTTP y JWT. La matriz complementaria registra 15 fuentes con identificadores y síntesis aplicadas. Se trata de revisión dirigida y no de una búsqueda exhaustiva certificada.

## IV. MÉTODO E INSTRUMENTOS

Diseño: estudio de caso descriptivo, documental, no experimental y de corte transversal, con actualización documental al 3 de noviembre de 2026. Unidad: el sistema SaborExpress y sus repositorios Back, Web, Móvil y Docs. Instrumentos aplicados en la evidencia documental consultada: ficha de extracción de tecnologías, tabla de trazabilidad ruta–cliente, y revisión de resultados de QA consignados en el informe de cierre del repositorio Docs. Jerarquía: A) ejecución de pruebas con identificador y entorno; B) hallazgo de código o configuración; C) propuesta no ejecutada. No se realizaron entrevistas ni encuestas en este trabajo de edición; se anexa formulario propuesto sin respuestas. Fuentes de datos: código y manifiestos disponibles, artículo previo, README y reporte 9-traceability/CIERRE-HU-2026-11-03.md. Para reproducir: fijar SHA, entorno, comandos y salida de CI; no comparar métricas de SHA diferentes como si fueran un experimento controlado. Se excluyen credenciales, transacciones y datos personales reales.

## V. RESULTADOS OBSERVADOS

Arquitectura: backend central ASP.NET Core 8/EF Core con autenticación JWT y comunicación SignalR; portal administrativo Next.js y aplicación móvil Expo/React Native. Los dominios documentados comprenden sedes, catálogo, personal, pedidos, pagos Wompi, cocina, caja y entregas. El expediente informa un OpenAPI generado desde un SHA anterior del backend con 269 rutas, 346 operaciones y 84 esquemas; ese inventario no constituye prueba de funcionamiento de cada operación. Contratos estáticos: Web 92/92 firmas ruta+método y Móvil 47/47 coincidieron contra el OpenAPI de referencia; no se verificaron payloads ni semántica en ejecución. Validaciones locales: backend candidato 17a8ce4 reporta Security 90/90, QA 62/62 y Invoice PDF 11/11; Web aa5cb8d reporta 7/7; Móvil af52bba registra 8/8. Una auditoría Playwright web con API sintética reportó 1/1 prueba en 11 pantallas; no constituye estudio de usabilidad. Smoke HTTP local: /health 200 y /health/ready 503 por migraciones pendientes. Un smoke de staging sobre el SHA anterior ac2b39e fue satisfactorio el 29 de octubre de 2026; no valida el candidato actual. Una serie histórica k6 registró una ejecución que cumplió umbrales y dos que no cumplieron la condición de encabezado Server-Timing. Las cifras provienen del expediente de cierre; no fueron reejecutadas durante la preparación de este artículo.

## VI. DISCUSIÓN Y AMENAZAS A LA VALIDEZ

Las pruebas de código y CI demuestran comprobaciones delimitadas, no la ejecución de extremo a extremo del negocio en producción. El backend candidato continúa sin integración a main, y la evidencia de Web y Móvil corresponde a versiones distintas. La comparación de rutas es una prueba de compatibilidad estática, no de autorización, idempotencia de pagos ni consistencia concurrente. Los escenarios OWASP de acceso entre sedes, las firmas de webhook de Wompi, la reconciliación después de desconexión, el control de secretos y los recorridos con siete roles requieren verificación adicional. Validez de constructo: ruta declarada ≠ operación correcta; validez interna: sin diseño antes/después no hay atribución causal; validez externa: un proyecto no representa al sector; replicabilidad: conservar SHAs, artefactos y entorno. No hay registro de entrevista a restaurante ni encuesta a usuarios; por tanto no se presentan tasas de aceptación ni diagnóstico de necesidades reales.

## VII. PROTOCOLO DE VALIDACIÓN Y TRABAJO FUTURO

Se propone un piloto con un responsable operativo y, sujeto a consentimiento, uno o más usuarios reales. Antes de ejecutar se debe capturar sede, rol, escenario, versión, fecha y autorización; aplicar entrevista semiestructurada y tarea observada; anonimizar respuestas; y registrar discrepancias entre resultado esperado y observado. En entorno de pruebas aislado: (a) pedidos/cocina/caja/domicilios por siete roles y dos sedes; (b) rechazo de accesos horizontales y verticales; (c) webhooks duplicados y alterados con proveedor sandbox; (d) pérdida de conexión y recuperación; (e) pruebas de carga con dataset y umbrales explícitos; (f) migraciones, rollback y copias de seguridad; (g) prueba en dispositivo e impresora. Los formatos anexos son instrumentos preparados, no aplicados.


### Delimitación y contribución científica

Se diferencia el problema de gestión observado documentalmente del problema de investigación evaluable. El primero concierne a la necesidad potencial de coordinar pedidos, cocina, cobros y domicilios; no se ha demostrado su incidencia en un negocio específico. El segundo consiste en determinar hasta qué punto la evidencia trazable permite sostener afirmaciones sobre una implementación multicliente. La contribución es un procedimiento replicable de triangulación entre artefactos, contratos y pruebas versionadas, no el diseño de un experimento causal ni una comparación comercial.

Se plantean tres proposiciones analíticas que orientan la recolección de evidencias: P1, la existencia de rutas y modelos compartidos permite documentar una arquitectura de integración; P2, una prueba automatizada aislada de una versión respalda únicamente el comportamiento cubierto en esa versión; P3, sin evidencia con usuarios y flujos integrados no es válido inferir satisfacción, productividad o preparación de producción. Estas proposiciones no se presentan como hipótesis estadísticas confirmadas.

### Selección y tratamiento de fuentes

La vigilancia tecnológica utiliza quince referencias seleccionadas por pertinencia al dominio gastronómico, arquitectura, métodos de investigación, requisitos y seguridad. La matriz distingue artículos empíricos y revisiones, modelos teóricos, guías metodológicas y estándares. Se consideró la relevancia temática, la disponibilidad de DOI o URL y la aplicabilidad a alguna decisión del estudio. No se registró una cadena de búsqueda exhaustiva, criterios formales PRISMA, evaluación independiente de sesgo ni conteo reproducible de exclusiones; por ello la revisión se denomina *dirigida*. La literatura comercial o de proveedores puede servir para describir interfaces, pero no se utiliza como sustituto de estudios empíricos sobre impacto.

Los trabajos sobre satisfacción en plataformas de entrega [1]–[5] informan posibles variables de un estudio futuro. Los marcos TAM y UTAUT [6], [7] orientan preguntas sobre utilidad y facilidad percibidas. La arquitectura mediante vistas [8] y la discusión de patrones [9] ayudan a evitar la atribución errónea de microservicios a un backend modular. Para estudiar la calidad del producto se adopta ISO/IEC 25010 [12] como marco conceptual; OWASP [13] y los RFC [14], [15] guían revisión de controles, pero ninguna de estas fuentes acredita certificación.

### Protocolo de extracción y control de sesgos

La unidad de análisis es el conjunto SaborExpressBack, SaborExpressWeb, SaborExpressMovil y SaborExpressDocs. Cada registro de evidencia debe contener: repositorio, ruta del archivo o ejecución, SHA completo, fecha, ambiente, objeto examinado, observación y límite de inferencia. La clasificación es: E1, prueba ejecutada reportada con identificador y resultado; E2, inspección estática reproducible; E3, actividad propuesta sin ejecución. Para un resultado extraído de un informe ajeno a esta edición se añade la etiqueta *reportado*; no se confunde con prueba reejecutada por el investigador.

Se reducen sesgos mediante cuatro reglas: (a) no sumar pruebas de versiones distintas como porcentaje único de calidad; (b) registrar tanto resultados exitosos como fallos y bloqueos; (c) distinguir resultados locales de checks CI y despliegues; (d) separar evidencia del sistema de supuestos del contexto productivo. No se dispone de muestreo probabilístico ni observación directa de un restaurante. La trazabilidad de algunas cifras depende del expediente técnico y requiere contraste de sus artefactos originales por un evaluador independiente.

### Análisis de resultados por dimensiones

**Arquitectura y contratos.** El inventario OpenAPI con 269 rutas, 346 operaciones y 84 esquemas es una descripción del documento generado desde un SHA anterior, no una prueba de que todas las operaciones respondan correctamente. La coincidencia estática de 92 firmas web y 47 móviles con dicho inventario verifica rutas y métodos, pero no cuerpos JSON, códigos de error, permisos o transacciones concurrentes. La exposición de JWT y SignalR en la configuración tampoco demuestra, por sí misma, control de acceso efectivo o entrega garantizada de eventos.

**Seguridad.** La suite local de seguridad reporta 90 casos aprobados en el candidato `17a8ce4`. Esto es evidencia de regresión limitada, no de auditoría de penetración completa, porque faltan recorridos integrados entre siete perfiles y dos sedes, rotación de credenciales históricas y revisión de autorización por objeto en staging. En materia de pagos se distinguen existencia de endpoints de Wompi, validación criptográfica de eventos y conciliación con transacciones reales o de sandbox: estas últimas dos requieren evidencia adicional.

**Fiabilidad y despliegue.** El mismo candidato respondió `200` en `/health` pero `503` en `/health/ready` por migraciones pendientes. El resultado es una discrepancia verificable entre vivacidad y preparación operativa, y debe mantenerse como hallazgo, sin ocultarse detrás del smoke exitoso de staging de un SHA anterior. El ensayo histórico k6 contiene una corrida aceptada y dos que incumplieron la condición sobre el encabezado `Server-Timing`; por tanto no se puede declarar cumplimiento consistente de todos los umbrales ni generalizar la medición al candidato reciente.

**Usabilidad.** Una prueba Playwright con API sintética sobre once pantallas no equivale a una evaluación con comensales, meseros o cajeros. No se dispone de tasas de tarea completada por participantes ni tiempos de operación observados; esos indicadores se reservan al protocolo piloto. La cobertura actual del estudio es predominantemente técnica, con validez externa restringida.

### Tabla de correspondencia entre hallazgos y criterios de aceptación

| Dimensión | Evidencia reportada | Inferencia admitida | Evidencia todavía necesaria |
|---|---|---|---|
| Contratos | OpenAPI y 92/92 web, 47/47 móvil | Coincidencia estática de rutas y métodos | Pruebas de payloads, errores y sesiones reales |
| Backend | Security 90/90, QA 62/62, PDF 11/11 | Suites locales aprobadas en SHA indicado | CI del candidato y recorridos integrados |
| Web/móvil | 7/7 y 8/8 en sus respectivos SHA | Suites limitadas en cada cliente | Dispositivo real y operación multirrol |
| Disponibilidad | Readiness local 503; staging anterior satisfactorio | Estados diferentes según entorno y versión | Migraciones controladas y nuevo smoke |
| Rendimiento | Una corrida k6 aceptada y dos no | Evidencia mixta histórica | Repeticiones con configuración declarada |
| Contexto real | Instrumento de entrevista sin aplicar | No hay diagnóstico empírico del negocio | Entrevista, consentimiento y registro |

### Plan verificable de validación posterior

El piloto de campo deberá definir previamente establecimiento autorizado, perfil, fecha, tarea, consentimiento, condiciones de observación y manejo de datos. Se propone observar el recorrido de pedido desde catálogo hasta entrega, registrando tiempo, errores, reintentos y comentarios sin identificar personas. Las respuestas deben anonimizarse, conservarse con autorización y analizarse de manera descriptiva. No se asignan tamaños de muestra, porcentajes o puntuaciones ficticias.

La fase técnica requiere un entorno aislado con datos sintéticos, dos sedes y cuentas de siete roles. Para cada caso se documentarán precondiciones, método, resultado esperado, resultado observado, evidencia, SHA y causa de bloqueo. Deben priorizarse la prevención de acceso entre sedes, el manejo idempotente de webhooks Wompi, la recuperación de red, los cierres de caja, la sincronización de estados de cocina, las migraciones reversibles y la prueba física de impresión móvil. Una corrida local no reemplaza la reproducción en staging de la misma versión.


### Correspondencia explícita con la guía GFPI-F-135 V04

La guía del SENA organiza el estudio en cuatro momentos. En el primero se requieren tres casos (uno facilitado por el instructor, otro de literatura y otro del contexto productivo), entrevistas a tres usuarios reales y un árbol de problemas ajustado a esas respuestas. En este corte solo se dispone de un análisis documental de SaborExpress y antecedentes de literatura; los casos del instructor y del restaurante real, al igual que las entrevistas, **no están verificados**. El árbol presentado es provisional, no una necesidad demostrada por participantes.

En el segundo momento, la matriz de consistencia enlaza pregunta, objetivo, actividad, producto y verificación. Se plantea un piloto con al menos dos usuarios para ajustar los instrumentos; no se registran participantes ni resultados porque no se ejecutó. En el tercero, se distinguen seis o más fuentes académicas, tres referentes técnicos y tres soluciones existentes. En el cuarto, los resultados son los registros técnicos versionados publicados por el proyecto, sin extrapolarlos a usuarios o producción. Los anexos contienen las matrices de casos, consistencia, vigilancia, estrategia de búsqueda y formatos de campo que deben completarse con evidencia real.

**Objetivo y contraste verificable.** La caracterización arquitectónica se contrasta con los archivos y especificaciones de los cuatro repositorios; el análisis de calidad con los resultados por SHA del expediente QA; y el estudio del contexto productivo solo podrá contrastarse cuando se apliquen las entrevistas y el piloto. Por tanto, el objetivo documental presenta evidencia parcial y las afirmaciones sobre necesidades y aceptación del restaurante siguen abiertas.

## VIII. CONCLUSIONES

El estudio caracteriza una solución gastronómica web y móvil basada en backend modular y establece una cadena de trazabilidad entre código, documentación, estándares y validaciones con SHA. La evidencia de pruebas locales y CI representa avance verificable respecto de la versión exclusivamente documental, pero es insuficiente para afirmar aceptación de usuarios, disponibilidad en producción o cierre total de historias de usuario. La contribución investigativa es delimitar qué puede concluirse y cómo repetir las verificaciones, y proponer un piloto de campo y un protocolo técnico que permitirían contrastar los riesgos identificados.

## IX. DECLARACIONES

Autor declarado del manuscrito: Yerson Stiven Cuéllar Rubiano (sujeto a confirmación personal de contribuciones y autoría). Afiliación: SENA, Centro de la Industria, la Empresa y los Servicios, ficha ADSO 3145555. Financiación y conflictos de interés: no se aportó información comprobable; el autor debe confirmarlos antes de presentar. Ética: no se realizó investigación con participantes en esta revisión; los instrumentos sin aplicar requieren autorización y consentimiento. Disponibilidad de datos: repositorios públicos citados y evidencia documental según SHA. Uso de inteligencia artificial: se utilizó ChatGPT (OpenAI, familia GPT-6) el 3 de noviembre de 2026 para apoyar la reorganización, redacción, traducción y generación de archivos de esta versión. Los resultados técnicos se extrajeron de los documentos existentes y no fueron generados experimentalmente por la herramienta. Corresponde al autor humano leer, contrastar referencias, verificar afirmaciones y aprobar esta declaración; deben añadirse otras herramientas si se utilizaron.

## REFERENCIAS

[1] Shroff, A., Shah, B. J., and Gajjar, H., “Online food delivery research: A systematic literature review,” *International Journal of Contemporary Hospitality Management*, 2022. https://doi.org/10.1108/IJCHM-10-2021-1273

[2] Shankar, A. et al., “Online food delivery: A systematic synthesis of literature and a framework development,” *International Journal of Hospitality Management*, 2022. https://doi.org/10.1016/j.ijhm.2022.103240

[3] Prasetyo, Y. T. et al., “Factors affecting customer satisfaction and loyalty in online food delivery service during the COVID-19 pandemic,” *Journal of Open Innovation: Technology, Market, and Complexity*, 2021. https://doi.org/10.3390/joitmc7010076

[4] Fakfare, P., “Influence of service attributes of food delivery application on customers’ satisfaction and their behavioural responses: The IPMA approach,” *International Journal of Gastronomy and Food Science*, 2021. https://doi.org/10.1016/j.ijgfs.2021.100392

[5] Koay, K. Y., Cheah, C. W., and Chang, Y. X., “A model of online food delivery service quality, customer satisfaction and customer loyalty: A combination of PLS-SEM and NCA approaches,” *British Food Journal*, 2022. https://doi.org/10.1108/BFJ-10-2021-1169

[6] Davis, F. D., “Perceived usefulness, perceived ease of use, and user acceptance of information technology,” *MIS Quarterly*, 1989. https://doi.org/10.2307/249008

[7] Venkatesh, V. et al., “User acceptance of information technology: Toward a unified view,” *MIS Quarterly*, 2003. https://doi.org/10.2307/30036540

[8] Kruchten, P., “The 4+1 view model of architecture,” *IEEE Software*, 1995. https://doi.org/10.1109/52.469759

[9] Taibi, D., Lenarduzzi, V., and Pahl, C., “Architectural patterns for microservices: A systematic mapping study,” *CLOSER 2018*, 2018. https://doi.org/10.5220/0006798302210232

[10] Yin, R. K., “Case Study Research and Applications: Design and Methods,” *SAGE, 6th ed.*, 2018. https://study.sagepub.com/yin6e

[11] Kitchenham, B., and Charters, S., “Guidelines for performing systematic literature reviews in software engineering,” *EBSE-2007-01*, 2007. https://homepages.dcc.ufmg.br/~figueiredo/disciplinas/papers/guidelines-kitchenham.pdf

[12] ISO/IEC, “ISO/IEC 25010:2023 — Product quality model,” *ISO standard*, 2023. https://www.iso.org/standard/78176.html

[13] OWASP Foundation, “OWASP API Security Top 10 — 2023,” *OWASP*, 2023. https://owasp.org/API-Security/

[14] Fielding, R., Nottingham, M., and Reschke, J., “HTTP Semantics (RFC 9110),” *IETF*, 2022. https://www.rfc-editor.org/rfc/rfc9110

[15] Jones, M., Bradley, J., and Sakimura, N., “JSON Web Token (JWT) (RFC 7519),” *IETF*, 2015. https://www.rfc-editor.org/rfc/rfc7519


Sources and traceability / Fuentes y trazabilidad:
- https://github.com/yersonct/SaborExpressDocs/blob/main/9-traceability/CIERRE-HU-2026-11-03.md
- https://github.com/yersonct/SaborExpressDocs/blob/f77625c469fe21f0e660e946c9741474817a524b/docs-SaborExpress/07_Articulo_investigacion_SaborExpress_ES.md
- https://github.com/yersonct/SaborExpressBack
- https://github.com/yersonct/SaborExpressWeb
- https://github.com/yersonct/SaborExpressMovil
