# Code and tags / Código y tags: FaceLit

## Original repositories / Repositorios originales

Every original working repository of the project must be listed here and must be **public**. The instructor compares what was delivered against these repositories, so they must stay public and keep their full history until the review ends.

Todos los repositorios originales de trabajo del proyecto deben estar aquí y deben ser **públicos**. El instructor contrasta lo entregado contra estos repositorios, así que deben seguir públicos y con todo su historial hasta terminar la revisión.

If one is missing, add a row. If one is empty or no longer used, write that in the commit column. The visibility shown was checked on 2026-11-04.

Si falta alguno, agregue la fila. Si uno está vacío o ya no se usa, indíquelo en la columna del commit. La visibilidad indicada se revisó el 2026-11-04.

| Component / Componente | Repository / Repositorio | Status / Estado | Access for `ariel5253` / Acceso de `ariel5253` | Commit of tag `final-delivery-2026` / Commit del tag | Main version ZIP / ZIP versión main | Full export ZIP / ZIP completo |
|---|---|---|---|---|---|---|
| Frontend | [FaceID-Proyect-2026/FaceLit](https://github.com/FaceID-Proyect-2026/FaceLit) | Public / Público | Escritura confirmada para `ariel5253` | [`6efd92c`](https://github.com/FaceID-Proyect-2026/FaceLit/tree/final-delivery-2026) — tag anotado | [Descargar ZIP](https://github.com/pemarival/ADSO-3145555/releases/download/final-delivery/FaceLit-final-delivery-2026-main.zip) | [Descargar ZIP](https://github.com/pemarival/ADSO-3145555/releases/download/final-delivery/FaceLit-full-export.zip) |
| Backend | [FaceID-Proyect-2026/FaceLit-Backend](https://github.com/FaceID-Proyect-2026/FaceLit-Backend) | Public / Público | Escritura confirmada para `ariel5253` | [`2ba7398`](https://github.com/FaceID-Proyect-2026/FaceLit-Backend/tree/final-delivery-2026) — tag anotado | [Descargar ZIP](https://github.com/pemarival/ADSO-3145555/releases/download/final-delivery/FaceLit-Backend-final-delivery-2026-main.zip) | [Descargar ZIP](https://github.com/pemarival/ADSO-3145555/releases/download/final-delivery/FaceLit-Backend-full-export.zip) |
| Database | [FaceID-Proyect-2026/FaceLit-DB](https://github.com/FaceID-Proyect-2026/FaceLit-DB) | Public / Público | Escritura confirmada para `ariel5253` | [`cd069ae`](https://github.com/FaceID-Proyect-2026/FaceLit-DB/tree/final-delivery-2026) — tag anotado | [Descargar ZIP](https://github.com/pemarival/ADSO-3145555/releases/download/final-delivery/FaceLit-DB-final-delivery-2026-main.zip) | [Descargar ZIP](https://github.com/pemarival/ADSO-3145555/releases/download/final-delivery/FaceLit-DB-full-export.zip) |
| Documentation | [FaceID-Proyect-2026/facelit-docs](https://github.com/FaceID-Proyect-2026/facelit-docs) | Public / Público | Escritura confirmada para `ariel5253` | [`2993404`](https://github.com/FaceID-Proyect-2026/facelit-docs/tree/final-delivery-2026) — tag anotado | [Descargar ZIP](https://github.com/pemarival/ADSO-3145555/releases/download/final-delivery/facelit-docs-final-delivery-2026-main.zip) | [Descargar ZIP](https://github.com/pemarival/ADSO-3145555/releases/download/final-delivery/facelit-docs-full-export.zip) |
| AI service | [FaceID-Proyect-2026/micro-facial](https://github.com/FaceID-Proyect-2026/micro-facial) | Public / Público | Escritura confirmada para `ariel5253` | [`166e4a7`](https://github.com/FaceID-Proyect-2026/micro-facial/tree/final-delivery-2026) — tag anotado | [Descargar ZIP](https://github.com/pemarival/ADSO-3145555/releases/download/final-delivery/micro-facial-final-delivery-2026-main.zip) | [Descargar ZIP](https://github.com/pemarival/ADSO-3145555/releases/download/final-delivery/micro-facial-full-export.zip) |

Before making a repository public, remove `.env` files and change any password, token or key that was ever committed.

Antes de hacer público un repositorio, quite los archivos `.env` y cambie toda contraseña, token o llave que se haya subido alguna vez.

The instructor account `ariel5253` needs write access to every repository, so pending items can be corrected for the software registration. Add it as a collaborator where the table says so.

La cuenta del instructor, `ariel5253`, necesita acceso de escritura en cada repositorio, para poder corregir pendientes del registro de software. Agréguela como colaboradora donde la tabla lo indique.

## Why two ZIP files / Por qué dos ZIP

| File / Archivo | Content / Contenido | Purpose / Para qué sirve |
|---|---|---|
| `<repo>-final-delivery-2026-main.zip` | Only the code of `main` at tag `final-delivery-2026` / Solo el código de `main` en el tag | The exact version delivered, used for software registration / La versión exacta entregada, la que se usa para registro de software |
| `<repo>-full-export.zip` | The whole repository: all branches, tags and history / Todo el repositorio: ramas, tags e historial | Proof of the work done and a complete backup / Prueba del trabajo realizado y respaldo completo |

## Where the ZIP files live / Dónde quedan los ZIP

The ZIP files do not go in this folder. They are attached to a GitHub Release in the fork of the person who delivers, named `final-delivery`, and linked in the table above.

Los ZIP no van en esta carpeta. Se adjuntan a un Release de GitHub llamado `final-delivery` en el fork de quien entrega, y se enlazan en la tabla de arriba.

## Integrity / Integridad

Copy the SHA-256 of every ZIP into [`SHA256SUMS.txt`](SHA256SUMS.txt). / Copie el SHA-256 de cada ZIP en ese archivo.

## Verification status / Estado de verificación

**Punto 5 cerrado en el alcance de producción documentado**, según el [registro actualizado de Valery](credential-rotation-record.md): JWT, clave facial, base de datos y Gmail rotados; credenciales anteriores rechazadas y nuevas aceptadas. El valor histórico de Resend fue clasificado como marcador de ejemplo. No se enviaron correos durante la comprobación; el registro no sustituye la prueba independiente de instalación. Consulta el [alcance y las limitaciones](delivery-status.md#received-production-rotation-evidence).

Los cinco tags son anotados y conservan los commits de `main` indicados. Se regeneraron los diez ZIP y se verificó la restauración de los cinco repositorios completos. Consulta [la verificación](archive-verification.md), [las huellas SHA-256](SHA256SUMS.txt) y [el estado con limitaciones](delivery-status.md).

Release de entrega: [final-delivery](https://github.com/pemarival/ADSO-3145555/releases/tag/final-delivery). La publicación es un corte de entrega autorizado por la coordinadora, no una declaración de aceptación integral. La prueba de Persona 2 utiliza otro commit de base de datos y una corrección local del runner; el caso facial positivo es determinista. Consulta [el alcance exacto](../05-test-documentation/installation-final-scope.md). No se modificó código ni ninguna rama `main`.

