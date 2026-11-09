# Software registration: SaborExpress / Registro de software: SaborExpress

The public fields that are known from the project record are completed below. Private instructor identifiers and any institutional filing decision must remain in the private channel indicated by the SENA instructor.

Los campos públicos conocidos del expediente están diligenciados abajo. Los documentos privados de los instructores y cualquier decisión institucional de radicación deben permanecer en el canal privado indicado por el instructor del SENA.

## Institutional context / Marco institucional

| Field / Campo | Value / Valor |
|---|---|
| Purpose / Propósito | Request registration before the Dirección Nacional de Derecho de Autor in the name of the declared software author, with instructors recorded only as training-process contributors / Solicitar el registro ante la Dirección Nacional de Derecho de Autor a nombre del autor de software declarado, con los instructores registrados únicamente como colaboradores del proceso formativo |
| Process / Proceso | Completion of the taught stage of the technologist program / Finalización de la etapa lectiva del tecnólogo |
| Training project / Proyecto formativo | Desarrollo de software orientado a servicios |
| Research seedbed / Semillero de investigación | Developers & Geeks |

## 1. Applicant / Solicitante (Decreto 1360, art. 5, num. 1)

| Field / Campo | Value / Valor |
|---|---|
| Full name / Nombre | YERSON STIVEN CUELLAR RUBIANO |
| ID document / Identificación | CC 1075225114 |
| Acts on own behalf or as representative / Actúa en nombre propio o como representante | ☑ Own behalf / Nombre propio ☐ Representative / Representante |
| Proof of representation / Prueba de representación, si aplica | Not applicable / No aplica |

## 2. Authors / Autores (art. 5, num. 2)

The software author declared by this package is the apprentice listed below. Instructors are recorded in `team-roster.md` as indirect training-process contributors, not as software authors. / El autor del software declarado por este paquete es el aprendiz relacionado abajo. Los instructores están registrados en `team-roster.md` como colaboradores indirectos del proceso formativo, no como autores del software.

| Full name / Nombre completo | Doc. type / Tipo | Doc. number / Número | Ficha | Contribution / Aporte |
|---|---|---|---|---|
| YERSON STIVEN CUELLAR RUBIANO | CC | 1075225114 | 3145555 | Desarrollo backend, web y móvil; modelado de datos, pruebas y documentación |

## 3. Producer / Productor (art. 5, num. 3)

| Field / Campo | Value / Valor |
|---|---|
| Producer name / Nombre del productor | YERSON STIVEN CUELLAR RUBIANO |
| ID document or NIT / Identificación o NIT | CC 1075225114 |

## 4. Rights holder / Titular de los derechos patrimoniales

| Field / Campo | Value / Valor |
|---|---|
| Rights holder / Titular | YERSON STIVEN CUELLAR RUBIANO |
| ID document or NIT / Identificación o NIT | CC 1075225114 |
| How rights were acquired / Cómo adquirió los derechos, si no es el autor | Not applicable: the declared rights holder is the author / No aplica: el titular declarado es el autor |
| Document that proves it / Documento que lo prueba | Not applicable for an author acting on their own behalf / No aplica para el autor que actúa en nombre propio |

## 5. The work / La obra (art. 5, num. 4)

| Field / Campo | Value / Valor |
|---|---|
| Title / Título de la obra | SaborExpress |
| Year of creation / Año de creación | 2026 |
| Country of origin / País de origen | Colombia |
| Version registered / Versión a registrar | `final-delivery-2026` |
| Short description of its functions / Breve descripción de sus funciones | Plataforma web y móvil para administrar sedes, usuarios, roles, catálogos, mesas, pedidos, cocina, caja, pagos, facturas, entregas y notificaciones de un restaurante. |
| What sets it apart from similar software / Qué la diferencia de obras similares | Integración de procesos de restaurante en web y móvil, autorización por rol y sede, eventos en tiempo real con SignalR y pagos con Wompi, sujetos a validación operativa. |
| Programming languages / Lenguajes | C#, TypeScript y JavaScript; SQL para persistencia PostgreSQL. |
| Type: web, mobile, desktop, device / Tipo: web, móvil, escritorio, dispositivo | Aplicación web y aplicación móvil (Android/Expo React Native). No se declara aplicación de escritorio. |

## 6. Declarations / Declaraciones (art. 4 y art. 5, num. 5 y 6)

| Declaration / Declaración | Option / Opción |
|---|---|
| Origin / Origen | ☑ Original ☐ Derived work / Obra derivada |
| If derived, base work / Si es derivada, obra de base | |
| Type of work / Clase de obra | ☑ Individual / Individual ☐ In collaboration / En colaboración ☐ Collective / Colectiva ☐ Anonymous / Anónima ☐ Pseudonymous / Seudónima ☐ Posthumous / Póstuma |
| Publication / Publicación | ☐ Unpublished / Inédita ☑ Published / Publicada |
| If published, date and place / Si está publicada, fecha y lugar | 2026-11-07 — GitHub public repositories `yersonct/SaborExpressBack`, `SaborExpressDocs`, `SaborExpressMovil` and `SaborExpressWeb`; Release `final-delivery`. |

Software is treated as unpublished unless the rights holder states otherwise (art. 4). A public repository may count as publication: the team records it here, and the Centro decides the final declaration.

El software se considera inédito salvo manifestación del titular (art. 4). Un repositorio público puede contar como publicación: el equipo lo deja anotado aquí y el Centro define la declaración final.

## 7. Elements attached / Elementos que se adjuntan (art. 2, 3 y 6)

At least one is required. Attach all three. / Se exige al menos uno. Adjunte los tres.

| Element / Elemento | Where it is / Dónde está | Ready / Listo |
|---|---|---|
| Computer program / Programa de computador | ZIP files for tag `final-delivery-2026` listed in `code-tag/README.md` / ZIP del tag `final-delivery-2026` relacionados en `code-tag/README.md` | ☑ |
| Program description / Descripción de programa | `02-software-analysis/` and `04-software-design/` | ☑ |
| Auxiliary material / Material auxiliar | `08-manuals/` | ☑ |

## 8. Third-party components / Componentes de terceros

List code, libraries, models, images or data not created by the team. An unlisted copy puts the "original work" declaration at risk.

Relacione código, librerías, modelos, imágenes o datos que el equipo no creó. Una copia sin declarar pone en riesgo la declaración de obra original.

| Component / Componente | Author or source / Autor o fuente | License / Licencia | Where it is used / Dónde se usa |
|---|---|---|---|
| ASP.NET Core, Entity Framework Core, Microsoft.Extensions, Microsoft.AspNetCore.Authentication.JwtBearer | Microsoft / NuGet | MIT | Backend API, authentication, ORM and configuration |
| Npgsql.EntityFrameworkCore.PostgreSQL | Npgsql / NuGet | PostgreSQL License | PostgreSQL persistence provider |
| BCrypt.Net-Next, DotNetEnv, Swashbuckle.AspNetCore | NuGet maintainers | MIT | Password hashing, environment loading and OpenAPI |
| PDFsharp-MigraDoc | PDFsharp / NuGet | MIT | Invoice PDF generation |
| Next.js, React, React DOM, TypeScript, Tailwind CSS | Vercel / Meta / Microsoft / npm | MIT | Web application |
| Axios, SignalR JavaScript client, i18next, Zustand, jsPDF and jsPDF-AutoTable | npm maintainers | MIT | Web API, real-time updates, localization, state and PDF export |
| Expo, React Native, Expo Router, React Navigation, SignalR JavaScript client | Expo / Meta / npm | MIT | Mobile application |
| react-native-maps, react-native-qrcode-svg, BLE and thermal-printer packages | npm maintainers | See package metadata in each lockfile | Maps, QR, Bluetooth and printing features |
| Playwright | Microsoft / npm | Apache-2.0 | Web E2E and responsive test suite |

The exact transitive dependency license set is the package-manager lockfile for each repository; preserve those lockfiles with the source ZIPs and review them before a formal DNDA filing.

El conjunto exacto de licencias transitivas está en el lockfile del gestor de paquetes de cada repositorio; conserve esos lockfiles con los ZIP de código y revíselos antes de una radicación formal ante la DNDA.

## 9. Private data / Datos privados

**Do not write this data in this repository.** Registration also asks for address, nationality, phone and email. Each member gives them to the instructor through the private channel the instructor indicates.

**No escriba estos datos en este repositorio.** El registro también pide dirección, nacionalidad, teléfono y correo. Cada integrante se los entrega al instructor por el canal privado que se indique.

## 10. Team declaration / Declaración del equipo

- [x] The information supplied for Yerson is true and matches the identified project owner. / La información suministrada de Yerson es veraz y corresponde al titular identificado del proyecto.
- [x] The listed software author is the person who created the software. / El autor de software relacionado es quien creó el software.
- [x] Third-party components identified during the repository review are declared. / Los componentes de terceros identificados durante la revisión de repositorios están declarados.
- [x] No passwords, tokens or keys are included in the delivery package. / No se incluyen contraseñas, tokens ni llaves en el paquete de entrega.

This is a factual project declaration, not legal advice. The SENA/DNDA filing authority makes the final determination about authorship, ownership and admissible supporting documents.

Esta es una declaración fáctica del proyecto, no asesoría jurídica. La autoridad de radicación del SENA/DNDA determina finalmente la autoría, titularidad y documentos de soporte admisibles.
