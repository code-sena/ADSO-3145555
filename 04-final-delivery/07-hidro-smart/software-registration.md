# Registro del software Hidro Smart

**Estado:** borrador preparado con datos que aparecen en el monorepo PT_HS y en los repositorios separados. No es una solicitud presentada ni reemplaza la confirmación del equipo ante la Dirección Nacional de Derecho de Autor (DNDA).

## 1. Contexto formativo

| Campo | Dato disponible |
|---|---|
| Proyecto | Hidro Smart |
| Ficha | 3145555 |
| Proyecto formativo | Desarrollo de software orientado a servicios |
| Semillero mencionado en el roster previo | Developers & Geeks — confirmar que aplica a esta entrega |

## 2. Solicitante

**Pendiente de definir por el equipo.** Debe ser la persona que presentará la solicitud y cuya identidad se usará en el formulario de la DNDA.

| Campo | Dato |
|---|---|
| Nombre legal | Pendiente; completar directamente en el trámite o por canal privado |
| Documento de identidad | Pendiente; no guardar el número en este repositorio |
| Calidad en que actúa | Pendiente: nombre propio o representación autorizada |
| Poder o autorización | Solo aplica si actúa en representación de otra persona; confirmar y adjuntar al trámite si corresponde |

La DNDA distingue actuar en nombre propio de actuar con representación y puede requerir autorización o prueba de representación. Verifique la opción exacta en el formulario oficial antes de enviarlo.

## 3. Autores candidatos

El roster consolidado registra actividad de los aprendices en PT_HS y los componentes separados. La actividad Git sirve como evidencia de trabajo, pero cada persona debe confirmar que sus aportes creativos forman parte de la versión que se va a registrar. Los números de documento se completan en privado, no en este archivo.

| Nombre | Ficha | Identidad Git observada | Aportes observados en los repositorios | Confirmación para el registro |
|---|---:|---|---|---|
| JOSE ALEJANDRO MONTEALEGRE RODRIGUEZ | 3145555 | `joseale879` | PT_HS, backend, frontend web/móvil, base de datos, firmware y documentación; desarrollo e integración transversal. | Pendiente de confirmación personal |
| JOSE DAVID AMAYA MOSQUERA | 3145555 | `joseamaya009`; `José David Amaya Mosquera` | PT_HS, backend, frontend, base de datos y firmware; desarrollo e integración. | Pendiente de confirmación personal |
| EMERSON CALET MOLANO CARDOZO | 3145555 | `EmersonMolano`; `Emerson Calet Molano Cardozo` | PT_HS, backend, frontend, base de datos y documentación. | Pendiente de confirmación personal |

### Instructores

Los instructores enumerados en `team-roster.md` se mantienen como personas relacionadas con el proceso formativo. **No se declaran automáticamente como autores.** El instructor líder debe confirmar si alguno creó código, documentación, diagramas u otra parte original incluida en la obra a registrar y, de ser así, describir su aporte. Sus datos de identidad se conservan por canal privado.

## 4. Productor y titularidad

| Campo | Estado actual |
|---|---|
| Productor o productores | Pendiente de confirmación. Identificar a quienes tuvieron la iniciativa, coordinación y responsabilidad de producir el software; no asumir que coincide con toda la lista de autores. |
| Titular de los derechos patrimoniales | Pendiente de confirmación por autores y equipo formativo. No se encontró en los documentos revisados una cesión o autorización que permita asignarlo a una persona o entidad. |
| Transferencia de derechos | Pendiente. No marcar transferencia ni adjuntar una afirmación sin el documento firmado que corresponda. |

## 5. Datos de la obra

| Campo | Propuesta basada en los repositorios | Confirmación necesaria |
|---|---|---|
| Título | Hidro Smart | Usar exactamente el mismo título en la solicitud y en el archivo adjunto. |
| Año de finalización de la obra | 2026, asociado a la versión `final-delivery-2026`. | Confirmar que 2026 corresponde al cierre de la obra que se registrará. |
| País de origen | Colombia | Confirmar con el equipo. |
| Versión | `final-delivery-2026`; los seis tags remotos y sus commits objetivo están registrados en [`code-tag/README.md`](code-tag/README.md). | Mantener el tag, los SHA y el Release sincronizados con el paquete que se presente. |
| Tipo de software | Aplicación web, aplicación móvil basada en Expo/React Native y firmware embebido para ESP32. | Confirmar qué componentes se incluirán en el paquete registrado. |
| Lenguajes detectados | TypeScript y JavaScript (frontend/backend); SQL (base de datos y migraciones); C++ con framework Arduino (firmware ESP32). | Verificar contra el código exacto del tag de entrega. |

### Descripción funcional propuesta

> Hidro Smart permite monitorear el consumo de agua por hogar. Un sensor conectado a un ESP32 envía lecturas mediante MQTT; el backend las procesa y almacena en PostgreSQL. Las aplicaciones web y móvil permiten consultar consumos, reportes, dispositivos y alertas, y revisar el historial de mediciones.

La descripción propuesta tiene 300 caracteres, contando espacios. Debe cotejarse con las funciones presentes en la versión final y mantenerse dentro del límite de 500 caracteres del formulario. La DNDA también indica que el título del formulario debe coincidir con el título de la copia adjunta.

### Diferenciador propuesto

Integra telemetría de sensores ESP32, comunicación MQTT, gestión de hogares y dispositivos, historial de consumo y alertas en una plataforma con clientes web y móvil. Esta descripción corresponde al alcance documentado de la versión final; el equipo debe confirmar que todos los elementos incluidos en la solicitud están dentro del paquete registrado.

## 6. Clasificaciones de la obra por confirmar

La guía actual de la DNDA solicita responder varias clasificaciones. Las opciones no se determinan únicamente por el número de commits ni por la lista de integrantes; deben reflejar cómo se creó y publicó la obra y quién coordinó su producción.

| Clasificación del formulario | Estado y validación requerida |
|---|---|
| Participación de autores | **Propuesta: obra en colaboración**, porque se identifican tres aprendices con aportes creativos en la versión integrada. | Cada integrante debe confirmar que sus aportes son creativos, conjuntos y declarables; revisar si el instructor exige la clasificación “colectiva”. |
| Origen de la obra | **Propuesta: original**, sin perjuicio de revisar componentes de terceros por separado. | El equipo debe confirmar que no se está registrando una adaptación o transformación de otra obra. |
| Forma de dar a conocer al autor | **Propuesta: nombre propio de cada autor**; no se propone anonimato ni seudónimo. | Confirmar los nombres que se diligenciarán en el formulario y su coincidencia con el roster. |
| Forma de elaboración | **Propuesta: ninguna de las modalidades especiales** (no se encontró soporte de encargo ni de creación por funcionario público). | Confirmar contratos, relación institucional y cualquier encargo antes de presentar. |
| Publicada o inédita | **Propuesta: publicada**, porque la versión tiene repositorio público, Release y URL de producción. | Confirmar con el instructor la definición aplicable y la primera fecha/medio de publicación de la versión concreta. |
| Fecha y lugar de publicación, si aplica | **2026-11-07 — repositorio GitHub de `joseamaya009` y Release `final-delivery-2026`**, como fecha de esta corrección. | Sustituir por la primera publicación oficial si el instructor exige la fecha original de entrega. |
## 7. Repositorios que contienen el proyecto

Se consideran partes y antecedentes del mismo Hidro Smart; las copias separadas no se cuentan como proyectos o equipos distintos.

| Componente | Repositorio |
|---|---|
| Monorepo e integración | [PT_HS](https://github.com/joseale879/PT_HS) |
| Backend | [BK_HS](https://github.com/joseamaya009/BK_HS) |
| Frontend web y móvil | [FT_HS](https://github.com/joseamaya009/FT_HS) |
| Base de datos | [BD_HS](https://github.com/EmersonMolano/BD_HS) |
| Firmware ESP32 | [Firmaware_HS](https://github.com/joseamaya009/Firmaware_HS) |
| Documentación del proyecto | [DOCS_HS](https://github.com/EmersonMolano/DOCS_HS) |

Las ramas de estos repositorios pueden estar en historias de usuario diferentes. El material que se entregue debe corresponder a una versión integrada concreta, identificada por tag/SHA, y no a una mezcla indeterminada de ramas.

## 8. Material de soporte

La DNDA admite como soporte el programa de computador, la descripción del programa o material auxiliar; la documentación oficial indica que se aporte al menos uno. Para esta entrega se recomienda preparar los tres, siempre vinculados a la misma versión identificada.

| Elemento | Ubicación prevista | Estado |
|---|---|---|
| Programa de computador | ZIP de código y exportación completa publicados en el Release `final-delivery`, enlazados desde [`code-tag/README.md`](code-tag/README.md) y comprobados con `SHA256SUMS.txt` | Preparado; validar nuevamente al presentar |
| Descripción del programa | Documentos Word/PDF finales y fuentes Markdown en `02-software-analysis/` y `04-software-design/` | Disponible; cotejar con el tag final |
| Material auxiliar | Manuales Word/PDF y fuentes Markdown en `08-manuals/` | Disponible; cotejar con el tag final |

## 9. Componentes de terceros

Inventario preliminar basado en los manifiestos y configuración del código. No es todavía una lista completa de licencias; antes de presentar, cotejar las versiones del tag final con sus archivos `package-lock.json`, `platformio.ini`, licencias y avisos de autoría.

| Componente o tecnología | Uso identificado | Licencia/atribución |
|---|---|---|
| React, React Native y Expo | Interfaces web y móvil | Verificar licencia y versión en el inventario del tag final |
| Express, MQTT.js y `pg` | API, comunicación MQTT y acceso PostgreSQL desde el backend | Verificar licencia y versión en el inventario del tag final |
| PostgreSQL y Liquibase | Persistencia y gestión de migraciones de base de datos | Verificar licencias/versiones incluidas o requeridas en despliegue |
| Arduino framework, PubSubClient, ArduinoJson y NimBLE-Arduino | Firmware ESP32, MQTT, JSON y BLE | Verificar licencia y versión fijadas en la configuración final de PlatformIO |
| Flespi | Servicio externo de broker MQTT | Servicio de terceros; registrar proveedor y condiciones aplicables, no presentarlo como código creado por el equipo |

## 10. Datos personales

No almacenar aquí cédulas, direcciones, nacionalidad, teléfonos, correos personales, poderes ni documentos firmados. Cada integrante entrega sus datos directamente a quien diligencie la solicitud por el canal privado que indique el instructor líder.

## 11. Lista de cierre

- [ ] Solicitante y calidad de representación confirmados.
- [ ] Cada autor y su aporte confirmados; revisar también la participación de instructores.
- [ ] Productor(es) y titularidad confirmados con soporte documental si aplica.
- [ ] Año de finalización, versión, tag y SHA del paquete registrados.
- [ ] Descripción, lenguajes, tipo y diferenciador revisados contra el tag final.
- [ ] Origen de la obra y clasificación por participación confirmados.
- [ ] Estado y fecha de publicación revisados considerando el sitio y repositorios públicos.
- [ ] Inventario de terceros y licencias cotejado para la versión final.
- [ ] Archivo de código, descripción y manuales corresponden a la misma versión.
- [ ] Se comprobó que no haya secretos, tokens ni datos personales en los adjuntos.

## Fuentes oficiales

- [DNDA: Registro de software y pasos del trámite](https://www.derechodeautor.gov.co/es/registro-de-software)
- [DNDA: Guía para la inscripción de obras, fonogramas, actos y contratos (edición 2026)](https://www.derechodeautor.gov.co/es/guia-para-la-inscripcion-de-obras-fonogramas-actos-y-contratos-en-el-registro-nacional-del-derecho)
- [Decreto 1066 de 2015, Gestor Normativo de Función Pública](https://www.funcionpublica.gov.co/eva/gestornormativo/norma_pdf.php?i=76835)
