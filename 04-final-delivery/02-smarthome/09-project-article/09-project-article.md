# SmartHome: diseño y evaluación técnica de una plataforma para el monitoreo energético residencial

**Elaborado por:** Natalia Chala Chala, Kevin Stiven López Amaya, Karen Daniela Holguín Cruz
**Institución:** Servicio Nacional de Aprendizaje (SENA), ADSO 3145555
**Fecha:** 6 de noviembre de 2026

---

## Resumen

SmartHome es un proyecto formativo orientado a facilitar la supervisión y el control del consumo eléctrico residencial. Este artículo describe la solución desde una revisión documental y técnica de sus cuatro repositorios principales, del SRS actualizado y de ejecuciones identificables de integración continua. El sistema combina clientes web y móvil, una API modular desarrollada con NestJS, persistencia PostgreSQL versionada mediante Liquibase e intercambio de mensajes MQTT con dispositivos compatibles. El análisis identificó una separación funcional de responsabilidades y validaciones automáticas satisfactorias para backend, web, base de datos y móvil. También identificó una auditoría de dependencias móviles fallida y una limitación relevante: la vinculación inicial de un Shelly desde cero no está certificada por la documentación actual. Los resultados se refieren a comprobaciones de código y CI; no constituyen una medición del ahorro energético ni una certificación de funcionamiento con hardware físico en producción. Se concluye que el proyecto dispone de una base técnica documentada para continuar su integración, pero requiere cerrar hallazgos de seguridad y completar pruebas funcionales de extremo a extremo.

Palabras clave: SmartHome; Internet de las cosas; consumo eléctrico; NestJS; MQTT; PostgreSQL; Liquibase; integración continua.

## Abstract

SmartHome is an educational project intended to support residential electricity monitoring and device control. This paper examines its updated software requirements, four source-code repositories, and traceable continuous-integration results. The architecture combines web and mobile clients, a modular NestJS API, PostgreSQL data storage managed through Liquibase, and MQTT-based communication with compatible devices. The review found successful automated validation workflows for the backend, web frontend, database, and mobile application. It also identified a failed mobile dependency-security audit and an unresolved limitation concerning first-time Shelly device onboarding. These findings reflect source-code inspection and CI evidence, not measured household energy savings or verified end-to-end operation in production. The project provides a documented technical foundation, while security remediation and physical integration testing remain necessary before stronger operational conclusions can be drawn.

Keywords: smart home; Internet of Things; electrical consumption; MQTT; PostgreSQL; continuous integration.

## 1. Introducción

Comprender cuánto consume un hogar y qué equipos contribuyen a ese consumo no siempre es sencillo con la información consolidada de una factura. La lectura periódica del servicio permite conocer un total, pero no explica por sí sola los momentos de mayor demanda ni permite supervisar directamente cada equipo. A partir de esa necesidad, SmartHome propone reunir datos energéticos y operaciones de control en una experiencia accesible desde el navegador y desde Android [1].

La propuesta integra tres preocupaciones que deben resolverse juntas. La primera es funcional: organizar hogares, miembros, dispositivos y mediciones. La segunda es técnica: hacer que varios clientes consuman una lógica de negocio coherente y que la telemetría llegue desde el entorno IoT. La tercera es de seguridad: impedir que una persona pueda administrar recursos de un hogar al que no pertenece. Por eso el proyecto utiliza una aplicación web, una aplicación móvil, una API y una base de datos con reglas de acceso diferenciadas [1–5].

El propósito de este artículo es explicar cómo se materializa esa organización, qué resultados de validación pueden citarse y cuáles son los límites actuales de la evidencia. Se toma como antecedente el artículo histórico del equipo [7], pero se actualizan sus afirmaciones frente al SRS y los registros verificables de noviembre de 2026. La existencia de un prototipo, una ruta o un documento no se interpreta automáticamente como prueba de despliegue satisfactorio.

## 2. Objetivo y alcance del trabajo

El objetivo del desarrollo es construir una plataforma que permita gestionar hogares y dispositivos compatibles, consultar mediciones eléctricas y presentar información útil para el seguimiento del consumo residencial. En la revisión de noviembre de 2026 se examinan cuatro repositorios funcionales: backend, interfaz web, aplicación móvil y base de datos [2–5].

El alcance considerado incluye autenticación y sesiones, administración de hogares y roles, registro y consulta de dispositivos, consumo histórico, alertas, reportes y mecanismos de actualización en tiempo real. El dispositivo de referencia es Shelly 1PM Gen4 y el intercambio IoT está asociado a MQTT. El SRS actualizado distingue los roles globales SYSTEM_ADMIN y USER, y los roles por hogar OWNER, MEMBER y GUEST [1].

Quedan fuera de las conclusiones comprobadas la reducción porcentual de la factura, el rendimiento para miles de dispositivos simultáneos, el cumplimiento medido de niveles de disponibilidad o la validación integral en una instalación doméstica. Son objetivos o escenarios que necesitan métodos de evaluación específicos, no inferencias obtenidas del código.

## 3. Metodología de revisión y desarrollo

El artículo utiliza un enfoque descriptivo de estudio de caso. Se revisaron la especificación de requisitos, la estructura de los repositorios, sus archivos de configuración y las evidencias públicas producidas por GitHub Actions. La documentación de Drive se empleó como antecedente de diseño, sin otorgarle el mismo nivel probatorio que a una ejecución identificada por su commit.

Para conservar la trazabilidad se fijaron revisiones de la rama dev correspondientes a los resultados automatizados consultados. La diferencia entre “requisito”, “implementación” y “resultado probado” es fundamental: un requisito declara qué se espera; el código expresa una solución programada; y una prueba con evidencia permite afirmar únicamente aquello que dicha prueba ejecutó y observó.

| Componente | Revisión examinada | Fuente |
| --- | --- | --- |
| Backend | 60297c361e4a… | Repositorio NestJS [2] |
| Base de datos | 3b20c9177a9a… | SQL y Liquibase [3] |
| Frontend web | 7b9acdf12205… | React/Vite [4] |
| Frontend móvil | 6b5fe36655eb… | Expo/React Native [5] |

La validación se basó en cinco ejecuciones de CI: cuatro flujos funcionales de componentes y una auditoría de dependencias. No se realizaron durante esta revisión pruebas nuevas en un celular, en PostgreSQL productivo ni sobre un dispositivo físico. Tampoco se efectuaron encuestas ni mediciones de consumo antes/después, por lo que el artículo no presenta resultados experimentales de ahorro.

## 4. Diseño y construcción de la solución

### 4.1. Arquitectura general

El diseño se organiza como un sistema cliente-servidor con módulos separados. La web y el móvil solicitan operaciones a una API central; allí se verifican identidad y permisos, se ejecutan casos de uso y se consulta la información persistente. Los componentes IoT envían datos o reciben órdenes mediante MQTT; la API dispone además de canales de notificación hacia los clientes en tiempo real [2–5].

| Capa | Tecnologías identificadas | Responsabilidad principal |
| --- | --- | --- |
| Presentación web | React, TypeScript, Vite | Navegación, gestión de hogares y dispositivos, consumo y notificaciones. |
| Presentación móvil | Expo, React Native, Expo Router | Pantallas para Android: inicio, hogares, energía, avisos y perfil. |
| Aplicación / API | NestJS, TypeScript, Prisma | Autenticación, reglas de acceso, operaciones de negocio y persistencia. |
| Datos | PostgreSQL, Liquibase | Entidades del sistema, migraciones, roles y políticas de acceso. |
| Comunicación IoT | MQTT y Socket.IO | Telemetría, envío de órdenes y difusión de eventos cuando hay infraestructura conectada. |

En esta arquitectura, el frontend no decide por sí solo si una persona tiene permiso de controlar un dispositivo. Esa comprobación corresponde al backend, de acuerdo con la membresía y los privilegios asignados al hogar. La interfaz complementa la autorización ocultando o limitando acciones cuando corresponde, pero no sustituye las validaciones del servidor.

### 4.2. Backend y lógica de negocio

El backend NestJS distribuye sus responsabilidades en módulos reconocibles: autenticación, hogares, dispositivos, consumo, energía, notificaciones y tiempo real. Utiliza controladores para exponer rutas HTTP, servicios y casos de uso para coordinar reglas, y adaptadores o repositorios para comunicarse con otros recursos. Esta organización ayuda a evitar que toda la lógica quede concentrada en una sola pantalla o endpoint [2].

Un ejemplo significativo es el control de dispositivos. Una persona solicita encender o apagar un equipo desde la interfaz; el backend debe validar el acceso y preparar la orden para el canal IoT. El estado COMMAND_PUBLISHED, documentado por el proyecto, significa que la orden fue publicada; no equivale a comprobar eléctricamente que el relé cambió de estado. Esa distinción condiciona tanto las pruebas como la forma correcta de informar al usuario [2].

### 4.3. Persistencia y seguridad de los datos

PostgreSQL es la base de datos relacional del sistema. Las migraciones SQL se gestionan con Liquibase, que permite registrar y reproducir cambios de esquema. La capa de acceso del backend utiliza Prisma. Los scripts incluyen elementos relacionados con autenticación, hogares, dispositivos, mediciones, permisos y auditoría [3].

La seguridad combina mecanismos de aplicación y de persistencia. Los permisos definidos por roles y hogares se complementan con cuentas técnicas de privilegio limitado y políticas Row-Level Security (RLS) cuando corresponde. Esto reduce el riesgo de que una operación llegue a datos de un hogar no autorizado. La existencia de tales mecanismos en la estructura no reemplaza las pruebas de autorización sobre cada ruta o entorno de despliegue [1–3].

### 4.4. Interfaces y seguimiento energético

La interfaz web ofrece rutas para panel principal, hogares, dispositivos, consumo, notificaciones y perfil. En la aplicación móvil, las pestañas principales son Inicio, Hogares, Energía, Avisos y Perfil. Ambas comparten conceptos de hogar activo, dispositivo, usuario y consumo, aunque distribuyen la información de formas diferentes según el tamaño de pantalla [4, 5].

En el módulo de energía se presentan períodos de consulta e indicadores expresados en unidades eléctricas. Es importante no confundir potencia instantánea, expresada en W o kW, con energía acumulada, expresada en kWh. Los costos de consumo son estimaciones dependientes de los registros y de la tarifa configurada; no deben sustituir la factura oficial de la empresa prestadora. Los componentes móviles incluyen opciones de generación de archivos CSV y PDF cuando existen datos válidos [5].

## 5. Resultados de la revisión técnica

Las ejecuciones consultadas permiten registrar resultados concretos para una revisión de desarrollo. Todas se realizaron sobre commits identificables de la rama dev, entre el 4 y el 5 de noviembre de 2026. No corresponden al tag de entrega final de main ni acreditan un despliegue productivo [6].

| Ejecución | Estado | Qué demuestra |
| --- | --- | --- |
| Backend | Aprobada | Análisis estático, TypeScript, suite Jest, compilación NestJS y prueba e2e de seguridad MQTT. |
| Frontend web | Aprobada | Lint, tipos, contrato Shelly, compilación Vite y prueba básica del contenedor; publicación/despliegue omitidos. |
| Base de datos | Aprobada | Liquibase y controles de PostgreSQL, roles y RLS en base temporal de CI. |
| Aplicación móvil | Aprobada | Regresiones, navegación, alertas, energía y exportación JavaScript Android en CI. |
| Auditoría móvil | Fallida | 14 avisos: 5 altos, 8 moderados y 1 bajo; ninguno crítico en la ejecución examinada. |

Los resultados favorables muestran que los pipelines configurados ejecutaron satisfactoriamente sus comprobaciones: compilación, pruebas unitarias o de contrato, validaciones del esquema y pruebas de código móvil. El caso de la web requiere una precisión adicional: aunque el flujo de validación terminó correctamente, los trabajos de publicación y despliegue fueron omitidos en esa ejecución. En consecuencia, no se concluye que el sistema haya sido publicado en producción.

La auditoría de dependencias móviles finalizó con error porque reportó cinco hallazgos de severidad alta, ocho moderados y uno bajo, sin críticos en la ejecución examinada. El equipo mantiene el seguimiento en la incidencia #42 [9]. Este resultado no demuestra por sí mismo que una vulnerabilidad pueda explotarse desde una APK instalada, porque debe determinarse si la dependencia afecta al runtime o a herramientas de compilación; sí constituye una tarea de seguridad abierta que debe gestionarse antes de declarar la versión lista para producción.

## 6. Discusión y limitaciones

La revisión permite sostener que SmartHome cuenta con una arquitectura funcionalmente coherente y mecanismos definidos para separar responsabilidades. También muestra por qué la evaluación del proyecto no debería reducirse a la existencia de interfaces o a un conjunto de workflows en verde. El sistema depende de varios servicios que deben operar juntos: API, base de datos, canal de mensajería, tiempo real, configuración del dispositivo y permisos del usuario.

El README del backend informa que en el entorno DEV se probaron telemetría y control sobre un Shelly previamente conocido, pero señala que el emparejamiento inicial LAN/AP desde cero continúa pendiente [2]. Por su parte, la documentación móvil describe una prueba de concepto BLE de descubrimiento y lectura experimental, sin afirmar que haya completado un pairing de producto en un teléfono físico [5]. Estas dos observaciones muestran una diferencia entre disponer de módulos de integración y cerrar todo el recorrido de incorporación de un dispositivo nuevo.

El artículo histórico del equipo [7] recoge experiencias positivas con la API y el canal IoT, pero en su archivo no se adjuntan registros que permitan reproducir de manera independiente todos los escenarios que enumera. Por ello, esta versión no reproduce como resultados comprobados ni porcentajes de avance global ni mediciones de potencia de un dispositivo específico, y omite identificadores o correos de prueba contenidos en esa fuente. Mantener esta distinción protege la calidad académica del informe y hace explícito qué falta verificar.

Las prioridades técnicas derivadas de la revisión son claras: resolver y volver a auditar las dependencias de mayor riesgo; verificar los permisos y el aislamiento de datos en entornos representativos; ejecutar pruebas del flujo completo de telemetría y control; y demostrar el emparejamiento inicial en hardware compatible y en un build Android apropiado. Un resultado favorable de esas pruebas permitiría ampliar las conclusiones en una versión posterior del estudio.

## 7. Conclusiones

SmartHome integra tecnologías actuales para afrontar un problema concreto: ofrecer a las personas una visión más detallada del consumo eléctrico de su hogar y funciones de gestión sobre dispositivos compatibles. La revisión del SRS y del código evidencia una división razonable entre experiencia de usuario, reglas del servidor, datos e integración con IoT.

Las pruebas automáticas encontradas constituyen evidencia útil de la calidad técnica de los componentes examinados. Sin embargo, el valor de esa evidencia depende de su alcance: que el backend compile y que las migraciones pasen en una base temporal no demuestra, por sí solo, la operación continua de una instalación doméstica. De igual manera, que se publique un comando MQTT no prueba el cambio físico de un relé.

El avance del proyecto se describe con mayor precisión cuando se presentan juntos sus logros y límites: existen módulos y validaciones automatizadas trazables; también queda una auditoría de dependencias móviles sin cerrar y se requieren pruebas integrales adicionales para la vinculación inicial y la operación física con Shelly. Sobre esa base, SmartHome puede continuar su desarrollo y evaluación sin convertir objetivos de diseño en resultados que aún no han sido observados.

## Referencias

[1] Equipo SmartHome. (2026). Especificación de requisitos de software, revisión 2026 [Documento de proyecto]. SENA, ficha 3145555. https://docs.google.com/document/d/1BYwKmODc6xmjVqJjOdBtK7t9KJr7vHnm/edit

[2] Equipo SmartHome. (2026). Backend NestJS: código, README y configuración, revisión dev 60297c361e4a [Repositorio de código]. GitHub. https://github.com/nataliachala1/smarthome-backend/tree/60297c361e4acac6e98161337ef8e149e069d441

[3] Equipo SmartHome. (2026). Persistencia PostgreSQL y migraciones Liquibase, revisión dev 3b20c9177a9a [Repositorio de código]. GitHub. https://github.com/nataliachala1/smarthome-database/tree/3b20c9177a9aabfcc285043a6d85048bb1b95b7a

[4] Equipo SmartHome. (2026). Interfaz web React, revisión dev 7b9acdf12205 [Repositorio de código]. GitHub. https://github.com/nataliachala1/smarthome-frontend-web/tree/7b9acdf12205cbc25aa3d0647cb9c60dbaaf17ac

[5] Equipo SmartHome. (2026). Aplicación móvil Expo y React Native, revisión dev 6b5fe36655eb [Repositorio de código]. GitHub. https://github.com/Kevin-Stiven-Lopez-Amaya404/from_movil/tree/6b5fe36655eb9048aa4054a914ec245810d58893

[6] Equipo SmartHome. (2026). Documentación de pruebas y resultados de CI [Producto 05 de la entrega final, elaborado con registros de GitHub Actions]. https://github.com/nataliachala1/smarthome-backend/actions/runs/41937120061

[7] Equipo SmartHome. (2026, octubre). Smart_Home_Articulo_Proyecto.pdf [Artículo técnico histórico, archivo del equipo]. Google Drive. https://drive.google.com/file/d/1LONN6JCFVvSPyeRMZHBPl0Hxz558-cFh/view

[8] SENA, ficha 3145555. (2026). Product 09: Project article: requisitos de entrega [README institucional]. GitHub. https://github.com/code-sena/ADSO-3145555/blob/main/04-final-delivery/02-smarthome/09-project-article/README.md

[9] Equipo SmartHome. (2026). Incidencia de auditoría de dependencias móviles #42 [Registro de seguimiento]. GitHub. https://github.com/Kevin-Stiven-Lopez-Amaya404/from_movil/issues/42