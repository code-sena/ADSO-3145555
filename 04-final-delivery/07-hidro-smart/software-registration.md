# Registro del software Hidro Smart

**Estado:** preparado para la entrega con los datos técnicos, aportes, roles y clasificaciones confirmados por el equipo. José David Amaya Mosquera es el responsable de realizar la entrega. Las declaraciones de autoría legal, productor y titularidad corresponden al trámite DNDA externo; este documento no es una solicitud presentada ni reemplaza ese trámite.

## 1. Contexto formativo

| Campo                                    | Dato disponible                                           |
| ---------------------------------------- | --------------------------------------------------------- |
| Proyecto                                 | Hidro Smart                                               |
| Ficha                                    | 3145555                                                   |
| Proyecto formativo                       | Desarrollo de software orientado a servicios              |
| Semillero mencionado en el roster previo | Developers & Geeks — confirmar que aplica a esta entrega |

## 2. Solicitante

**Responsable informado por el equipo:** José David Amaya Mosquera (`joseamaya009`) realizará la entrega y deberá diligenciar la solicitud con sus datos por el canal privado indicado por el instructor.

| Campo                  | Dato                                                                                                      |
| ---------------------- | --------------------------------------------------------------------------------------------------------- |
| Nombre legal           | José David Amaya Mosquera; confirmar directamente en el trámite o por canal privado                      |
| Documento de identidad | Pendiente; no guardar el número en este repositorio                                                      |
| Calidad en que actúa  | Responsable de la entrega; confirmar en el trámite si actúa en nombre propio o con representación         |
| Poder o autorización  | Solo aplica si actúa en representación de otra persona; confirmar y adjuntar al trámite si corresponde |

La DNDA distingue actuar en nombre propio de actuar con representación y puede requerir autorización o prueba de representación. Verifique la opción exacta en el formulario oficial antes de enviarlo.

## 3. Autores declarados por el equipo

El roster consolidado registra actividad de los aprendices en PT_HS y los componentes separados. Los tres integrantes confirmaron el 2026-11-08 que sus aportes creativos forman parte de la versión que se va a registrar. Los números de documento se completan en privado, no en este archivo.

| Nombre                               |   Ficha | Identidad Git observada                             | Aportes observados en los repositorios                                                                                | Confirmación para el registro      |
| ------------------------------------ | ------: | --------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------- | ----------------------------------- |
| JOSE ALEJANDRO MONTEALEGRE RODRIGUEZ | 3145555 | `joseale879`                                      | PT_HS, backend, frontend web/móvil, base de datos, firmware y documentación; desarrollo e integración transversal. | Confirmado por el equipo el 2026-11-08 |
| JOSE DAVID AMAYA MOSQUERA            | 3145555 | `joseamaya009`; `José David Amaya Mosquera`    | PT_HS, backend, frontend, base de datos, firmware y documentación; desarrollo integral e integración de todos los componentes. | Confirmado por el equipo el 2026-11-08 |
| EMERSON CALET MOLANO CARDOZO         | 3145555 | `EmersonMolano`; `Emerson Calet Molano Cardozo` | PT_HS, backend, frontend, base de datos y documentación.                                                             | Confirmado por el equipo el 2026-11-08 |

### Instructores

Los instructores enumerados en `team-roster.md` se mantienen como personas relacionadas con el proceso formativo. **No se declaran automáticamente como autores.** El instructor líder debe confirmar si alguno creó código, documentación, diagramas u otra parte original incluida en la obra a registrar y, de ser así, describir su aporte. Sus datos de identidad se conservan por canal privado.

## 4. Productor y titularidad

| Campo                                 | Estado actual                                                                                                                                                                           |
| ------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Productor o productores               | Declaración del equipo: José Alejandro Montealegre, José David Amaya y Emerson Calet coordinaron y desarrollaron conjuntamente HidroSmart. Confirmar esta calidad en el trámite y en los soportes adjuntos, junto con el posible reconocimiento institucional del SENA. |
| Titular de los derechos patrimoniales | El equipo declara titularidad conjunta, pero informa que usó ocasionalmente computadores/equipos del SENA bajo acompañamiento formativo. No se puede afirmar titularidad exclusiva del equipo hasta que el Centro o la instancia jurídica del SENA determine si aplica la regla institucional sobre desarrollos realizados con recursos de la entidad. |
| Transferencia de derechos             | El equipo no declara transferencia. Antes de presentar, verificar el contrato o instrumento formativo aplicable; no adjuntar una cesión inexistente. |

**Contexto informado por el equipo:** HidroSmart fue desarrollado como proyecto formativo del SENA para evidenciar y aprobar RAPS técnicos, usando principalmente equipos y cuentas propias, pero también computadores/equipos del SENA en algunas sesiones. No hubo contrato, encargo, SENNOVA ni semillero según la declaración del equipo. El instructor aportó la idea general de los proyectos de la cohorte. La titularidad patrimonial requiere confirmación institucional porque la guía del SENA distingue entre obras independientes y desarrollos realizados con recursos o coordinación de la entidad.

## 5. Datos de la obra

| Campo | Valor confirmado | Estado |
|---|---|---|
| Título | Hidro Smart | Confirmado; usar exactamente el mismo título en la solicitud y en el archivo adjunto. |
| Año de finalización de la obra | 2026, asociado a la versión `final-delivery-2026`. | Confirmado por el equipo. |
| País de origen | Colombia | Confirmado por el equipo. |
| Versión | `final-delivery-2026`; los seis tags remotos y sus commits objetivo están registrados en [`code-tag/README.md`](code-tag/README.md). | Confirmada para el paquete de esta entrega. |
| Tipo de software | Aplicación web, aplicación móvil basada en Expo/React Native y firmware embebido para ESP32. | Confirmado para el paquete registrado. |
| Lenguajes detectados | TypeScript y JavaScript (frontend/backend); SQL (base de datos y migraciones); C++ con framework Arduino (firmware ESP32). | Confirmados contra el alcance técnico de la entrega. |

### Descripción funcional confirmada

> Hidro Smart permite monitorear el consumo de agua por hogar. Un sensor conectado a un ESP32 envía lecturas mediante MQTT; el backend las procesa y almacena en PostgreSQL. Las aplicaciones web y móvil permiten consultar consumos, reportes, dispositivos y alertas, y revisar el historial de mediciones.

La descripción confirmada tiene 300 caracteres, contando espacios. Se mantiene dentro del límite de 500 caracteres del formulario y debe conservarse igual en la solicitud y en la copia adjunta. La DNDA también indica que el título del formulario debe coincidir con el título de la copia adjunta.

### Diferenciador confirmado

Integra telemetría de sensores ESP32, comunicación MQTT, gestión de hogares y dispositivos, historial de consumo y alertas en una plataforma con clientes web y móvil. Esta descripción corresponde al alcance confirmado de la versión final.

## 6. Clasificaciones de la obra confirmadas

La guía actual de la DNDA solicita responder varias clasificaciones. Las opciones no se determinan únicamente por el número de commits ni por la lista de integrantes; deben reflejar cómo se creó y publicó la obra y quién coordinó su producción.

| Clasificación del formulario | Valor confirmado | Estado |
|---|---|---|
| Participación de autores | **Obra en colaboración**, porque se identifican tres aprendices con aportes creativos en la versión integrada. | Confirmado por el equipo. |
| Origen de la obra | **Original**, sin perjuicio de que los componentes de terceros conserven sus licencias y atribuciones. | Confirmado por el equipo. |
| Forma de dar a conocer al autor | **Nombre propio de cada autor**; no se usará anonimato ni seudónimo. | Confirmado por el equipo y consistente con el roster. |
| Forma de elaboración | **Ninguna de las modalidades especiales** de encargo o creación por funcionario público. | Confirmado por el equipo. |
| Publicada o inédita | **Publicada**, porque la versión tiene repositorio público, Release y URL de producción. | Confirmado para la versión presentada. |
| Fecha y lugar de publicación, si aplica | **2026-11-07 — repositorio GitHub de `joseamaya009` y Release `final-delivery-2026`**, como fecha de esta corrección. | Confirmado para esta versión de entrega. |

## 7. Repositorios que contienen el proyecto

Se consideran partes y antecedentes del mismo Hidro Smart; las copias separadas no se cuentan como proyectos o equipos distintos.

| Componente                  | Repositorio                                                 |
| --------------------------- | ----------------------------------------------------------- |
| Monorepo e integración     | [PT_HS](https://github.com/joseale879/PT_HS)                 |
| Backend                     | [BK_HS](https://github.com/joseamaya009/BK_HS)               |
| Frontend web y móvil       | [FT_HS](https://github.com/joseamaya009/FT_HS)               |
| Base de datos               | [BD_HS](https://github.com/EmersonMolano/BD_HS)              |
| Firmware ESP32              | [Firmaware_HS](https://github.com/joseamaya009/Firmaware_HS) |
| Documentación del proyecto | [DOCS_HS](https://github.com/EmersonMolano/DOCS_HS)          |

Las ramas de estos repositorios pueden estar en historias de usuario diferentes. El material que se entregue debe corresponder a una versión integrada concreta, identificada por tag/SHA, y no a una mezcla indeterminada de ramas.

## 8. Material de soporte

La DNDA admite como soporte el programa de computador, la descripción del programa o material auxiliar; la documentación oficial indica que se aporte al menos uno. Para esta entrega se recomienda preparar los tres, siempre vinculados a la misma versión identificada.

| Elemento                  | Ubicación prevista                                                                                                                                                                  | Estado                                     |
| ------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------ |
| Programa de computador    | ZIP de código y exportación completa publicados en el Release `final-delivery`, enlazados desde [`code-tag/README.md`](code-tag/README.md) y comprobados con `SHA256SUMS.txt` | Verificado en el Release público y en los digest SHA-256 del 2026-11-07 |
| Descripción del programa | Documentos Word/PDF finales y fuentes Markdown en `02-software-analysis/` y `04-software-design/`                                                                                | Disponible en el tag raíz `final-delivery-2026` |
| Material auxiliar         | Manuales Word/PDF y fuentes Markdown en `08-manuals/`                                                                                                                              | Disponible en el tag raíz `final-delivery-2026` |

## 9. Componentes de terceros

Inventario de los componentes principales basado en los manifiestos, los lockfiles, `platformio.ini` y las licencias de sus proyectos de origen. Los lockfiles también contienen dependencias transitivas; si el trámite exige un SBOM completo, debe generarse desde esos lockfiles y conservar sus avisos.

| Componente o tecnología                                      | Uso identificado                                             | Licencia/atribución                                                                                                 |
| ------------------------------------------------------------- | ------------------------------------------------------------ | -------------------------------------------------------------------------------------------------------------------- |
| React, React Native y Expo                                    | Interfaces web y móvil                                      | MIT; consultar [React](https://github.com/facebook/react/blob/main/LICENSE), [React Native](https://github.com/facebook/react-native/blob/main/LICENSE) y [Expo](https://github.com/expo/expo/blob/main/LICENSE). |
| Express, MQTT.js y `pg`                                      | API, comunicación MQTT y acceso PostgreSQL desde el backend | MIT; consultar [Express](https://github.com/expressjs/express/blob/master/LICENSE), [MQTT.js](https://github.com/mqttjs/MQTT.js/blob/main/LICENSE.md) y [node-postgres](https://github.com/brianc/node-postgres/blob/master/LICENSE). |
| PostgreSQL 16 y Liquibase 5.0.2                              | Persistencia y gestión de migraciones de base de datos      | PostgreSQL License para PostgreSQL; FSL-1.1-ALv2 para Liquibase Community 5.0.2. Consultar [PostgreSQL](https://www.postgresql.org/about/licence/) y [Liquibase 5.0.2](https://github.com/liquibase/liquibase/blob/v5.0.2/LICENSE.txt). |
| Arduino framework, PubSubClient, ArduinoJson y NimBLE-Arduino | Firmware ESP32, MQTT, JSON y BLE                             | LGPL-2.1 para Arduino-ESP32; MIT para PubSubClient y ArduinoJson; Apache-2.0 para NimBLE-Arduino. Consultar [Arduino-ESP32](https://github.com/espressif/arduino-esp32/blob/master/LICENSE.md), [PubSubClient](https://github.com/knolleary/pubsubclient/blob/master/LICENSE.txt), [ArduinoJson](https://github.com/bblanchon/ArduinoJson/blob/7.x/LICENSE.txt) y [NimBLE-Arduino](https://github.com/h2zero/NimBLE-Arduino/blob/master/LICENSE). |
| Flespi                                                        | Servicio externo de broker MQTT                              | Servicio de terceros; revisar las condiciones del servicio de la cuenta y no presentarlo como código creado por el equipo. |

## 10. Datos personales

No almacenar aquí cédulas, direcciones, nacionalidad, teléfonos, correos personales, poderes ni documentos firmados. Cada integrante entrega sus datos directamente a quien diligencie la solicitud por el canal privado que indique el instructor líder.

## 11. Lista de cierre

- [ ] Solicitante y calidad de representación confirmados.
- [x] Los tres aprendices y sus aportes confirmados por el equipo; queda pendiente revisar la participación de instructores.
- [ ] Productor(es) y titularidad declarados por el equipo; falta verificar el instrumento formativo o contractual del SENA y adjuntar soporte si aplica.
- [x] Año de finalización, versión, tag y SHA del paquete registrados.
- [x] Descripción, lenguajes, tipo y diferenciador revisados contra el tag final.
- [x] Origen de la obra y clasificación por participación confirmados.
- [x] Estado y fecha de publicación revisados considerando el sitio y repositorios públicos.
- [x] Inventario de los principales terceros y sus licencias cotejado contra los manifiestos y la configuración de la versión final; las dependencias transitivas permanecen identificadas por los lockfiles.
- [x] Archivo de código, descripción y manuales corresponden a la misma versión `final-delivery-2026` del paquete publicado.
- [ ] Se comprobó que no haya secretos, tokens ni datos personales en los adjuntos.

## Fuentes oficiales

- [DNDA: Registro de software y pasos del trámite](https://www.derechodeautor.gov.co/es/registro-de-software)
- [DNDA: Guía para la inscripción de obras, fonogramas, actos y contratos (edición 2026)](https://www.derechodeautor.gov.co/es/guia-para-la-inscripcion-de-obras-fonogramas-actos-y-contratos-en-el-registro-nacional-del-derecho)
- [Decreto 1066 de 2015, Gestor Normativo de Función Pública](https://www.funcionpublica.gov.co/eva/gestornormativo/norma_pdf.php?i=76835)
- [SENA: Guía de propiedad intelectual SIGA](https://repositorio.sena.edu.co/bitstream/handle/11404/7440/DE-F-025_PROPIEDAD_INTELECTUAL_SIGA_V02.pdf?isAllowed=true&sequence=1)
