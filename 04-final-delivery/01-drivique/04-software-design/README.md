# Software design / Diseño del software — Drivique (ADSO-3145555)

**Training project deliverable / Producto del proyecto formativo:** Documentación de diseño del software (interfaces gráficas, modelo arquitectónico, patrones de diseño, modelo de datos).

## Required content / Contenido requerido

- [x] Graphical interfaces: mockups or prototype / Interfaces gráficas: mockups o prototipo
- [x] Architectural model & framework selection / Modelo arquitectónico y selección de frameworks (`software-design.pdf`, `framework-selection.pdf`, `component-diagram.png`, `deployment-diagram.png`, `state-diagram.png`)
- [x] Design patterns applied, with where they are used / Patrones de diseño aplicados, indicando dónde se usan
- [x] Data model: conceptual, logical and physical / Modelo de datos: diccionario de datos (`data-dictionary.pdf`), script DDL (`database-ddl.sql`) y diagrama físico (`entity-relationship-diagram.png`)

## Official Deliverables / Archivos Oficiales Entregados

| File / Archivo | Format / Formato | Content / Contenido |
|---|---|---|
| [`software-design.pdf`](software-design.pdf) | PDF | Documentación de Diseño de Software, Arquitectura en Capas y Patrones de Diseño. |
| [`data-dictionary.pdf`](data-dictionary.pdf) | PDF | Diccionario de Datos Oficial de los esquemas relacionales en PostgreSQL 17. |
| [`framework-selection.pdf`](framework-selection.pdf) | PDF | Especificación de Selección de Frameworks y Arquitectura Frontend/Backend. |
| [`database-ddl.sql`](database-ddl.sql) | SQL | Script DDL completo de creación del esquema relacional PostgreSQL 17. |
| [`entity-relationship-diagram.png`](entity-relationship-diagram.png) | PNG | Diagrama Entidad-Relación Físico de la base de datos. |
| [`component-diagram.png`](component-diagram.png) | PNG | Diagrama de Componentes de la arquitectura Drivique. |
| [`deployment-diagram.png`](deployment-diagram.png) | PNG | Diagrama de Despliegue en infraestructura Cloud VPS con Docker y Caddy. |
| [`state-diagram.png`](state-diagram.png) | PNG | Diagrama de Estados del ciclo de vida de reservas y entrega con PIN de 6 dígitos. |

## Interactive Prototypes & UI/UX Designs / Prototipos Interactivos y Diseños UI/UX

| Plataforma / Componente | Recurso / Enlace | Descripción |
|---|---|---|
| **App Móvil — Diseño Figma** | [drivique — Diseño App en Figma](https://www.figma.com/design/YAosTPAwhs1kzLwR0hVDFF/drivique?node-id=2-15&t=p1nyTX6R0C9D8AWb-1) | Espacio de trabajo de diseño UI/UX para la aplicación móvil Drivique. |
| **App Móvil — Prototipo Interactivo** | [drivique — Prototipo Interactivo App](https://www.figma.com/proto/YAosTPAwhs1kzLwR0hVDFF/drivique?node-id=437-253&p=f&t=p1nyTX6R0C9D8AWb-0&scaling=scale-down&content-scaling=fixed&page-id=2%3A15&starting-point-node-id=437%3A253&show-proto-sidebar=1) | Flujo navegable interactivo de la aplicación móvil (Onboarding, catálogo, reserva y entrega con PIN). |
| **Plataforma Web — Diseño Figma** | [drivique — Diseño Web en Figma](https://www.figma.com/design/YAosTPAwhs1kzLwR0hVDFF/drivique?node-id=381-2&p=f&t=p1nyTX6R0C9D8AWb-0) | Espacio de diseño UI/UX del portal web y paneles de administración. |
| **Plataforma Web — Prototipo Interactivo** | [drivique — Prototipo Interactivo Web](https://www.figma.com/proto/YAosTPAwhs1kzLwR0hVDFF/drivique?node-id=411-2&p=f&t=p1nyTX6R0C9D8AWb-0&scaling=scale-down&content-scaling=fixed&page-id=381%3A2) | Flujo navegable del portal web de clientes y paneles `/admin` y `/encargado`. |
| **Web en Producción (Servidor)** | [https://drivique.tech/](https://drivique.tech/) | Despliegue en producción del portal web oficial de Drivique. |
| **App Móvil en Producción (PWA)** | [https://app.drivique.tech/onboarding](https://app.drivique.tech/onboarding) | Despliegue en producción de la app móvil Drivique (flujo de onboarding). |

## Format / Formato

- Final version in PDF, plus the editable source when it exists. / Versión final en PDF y, si existe, el archivo fuente editable.
- English file names, without spaces or accents: `requirements-specification.pdf`. / Nombres de archivo en inglés, sin espacios ni tildes.
- Files over 50 MB go to Drive and are listed in the project `README.md`. / Los archivos de más de 50 MB van a Drive y se relacionan en el `README.md` del proyecto.
- Do not add passwords, tokens, keys or real user data. / No incluya contraseñas, tokens, llaves ni datos reales de usuarios.