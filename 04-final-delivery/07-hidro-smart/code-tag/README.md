# Code and tags / Código y tags: Hidro Smart

## Original repositories / Repositorios originales

Every original working repository of the project must be listed here and must be **public**. The instructor compares what was delivered against these repositories, so they must stay public and keep their full history until the review ends.

Todos los repositorios originales de trabajo del proyecto deben estar aquí y deben ser **públicos**. El instructor contrasta lo entregado contra estos repositorios, así que deben seguir públicos y con todo su historial hasta terminar la revisión.

If one is missing, add a row. If one is empty or no longer used, write that in the commit column. The visibility shown was checked on 2026-11-05.

Si falta alguno, agregue la fila. Si uno está vacío o ya no se usa, indíquelo en la columna del commit. La visibilidad indicada se revisó el 2026-11-05.

| Component / Componente | Repository / Repositorio | Status / Estado | Access for `ariel5253` / Acceso de `ariel5253` | Commit of tag `final-delivery-2026` / Commit del tag | Main version ZIP / ZIP versión main | Full export ZIP / ZIP completo |
|---|---|---|---|---|---|---|
| Main repository | [joseale879/PT_HS](https://github.com/joseale879/PT_HS) | Public / Público | Read; owner action pending / Lectura; pendiente del propietario | `8dd45ca349134ad0851a536af5f90760b10691f3` | [main ZIP](https://github.com/joseale879/PT_HS/releases/download/final-delivery-2026/PT_HS-final-delivery-2026-main.zip) | [full export](https://github.com/joseale879/PT_HS/releases/download/final-delivery-2026/PT_HS-full-export.zip) |
| Database | [EmersonMolano/BD_HS](https://github.com/EmersonMolano/BD_HS) | Public / Público | Read; owner action pending / Lectura; pendiente del propietario | `42ee03b5906dfdcbd9e9f6c7f03ddc453250d23b` | [main ZIP](https://github.com/EmersonMolano/BD_HS/releases/download/final-delivery-2026/BD_HS-final-delivery-2026-main.zip) | [full export](https://github.com/EmersonMolano/BD_HS/releases/download/final-delivery-2026/BD_HS-full-export.zip) |
| Backend | [joseamaya009/BK_HS](https://github.com/joseamaya009/BK_HS) | Public / Público | Write / Escritura | `190263da952afba5d4ce7f6c2d83c0fde2b239c4` | [main ZIP](https://github.com/joseamaya009/BK_HS/releases/download/final-delivery-2026/BK_HS-final-delivery-2026-main.zip) | [full export](https://github.com/joseamaya009/BK_HS/releases/download/final-delivery-2026/BK_HS-full-export.zip) |
| Web frontend | [joseamaya009/FT_HS](https://github.com/joseamaya009/FT_HS) | Public / Público | Write / Escritura | `91a5ef3125ed73d4d9d410f772b54923f8099430` | [main ZIP](https://github.com/joseamaya009/FT_HS/releases/download/final-delivery-2026/FT_HS-final-delivery-2026-main.zip) | [full export](https://github.com/joseamaya009/FT_HS/releases/download/final-delivery-2026/FT_HS-full-export.zip) |
| Firmware | [joseamaya009/Firmaware_HS](https://github.com/joseamaya009/Firmaware_HS) | Public / Público | Write / Escritura | `917fcfd2129ea6ff92860a4321b1fd7863957d85` | [main ZIP](https://github.com/joseamaya009/Firmaware_HS/releases/download/final-delivery-2026/Firmaware_HS-final-delivery-2026-main.zip) | [full export](https://github.com/joseamaya009/Firmaware_HS/releases/download/final-delivery-2026/Firmaware_HS-full-export.zip) |
| Documentation | [EmersonMolano/DOCS_HS](https://github.com/EmersonMolano/DOCS_HS) | Public / Público | Read; owner action pending / Lectura; pendiente del propietario | `054a063a667f637a55b3641f83a9e4dded1faa5b` | [main ZIP](https://github.com/EmersonMolano/DOCS_HS/releases/download/final-delivery-2026/DOCS_HS-final-delivery-2026-main.zip) | [full export](https://github.com/EmersonMolano/DOCS_HS/releases/download/final-delivery-2026/DOCS_HS-full-export.zip) |

Before making a repository public, remove `.env` files and change any password, token or key that was ever committed.

Antes de hacer público un repositorio, quite los archivos `.env` y cambie toda contraseña, token o llave que se haya subido alguna vez.

The instructor account `ariel5253` needs write access to every repository, so pending items can be corrected for the software registration. Add it as a collaborator where the table says so.

La cuenta del instructor, `ariel5253`, necesita acceso de escritura en cada repositorio, para poder corregir pendientes del registro de software. Agréguela como colaboradora donde la tabla lo indique.

The tag `final-delivery-2026`, both ZIP variants and Release links were verified on 2026-11-05. `ariel5253` has write access on `BK_HS`, `FT_HS` and `Firmaware_HS`; `PT_HS`, `BD_HS` and `DOCS_HS` still require the repository owner to grant write access.

El tag `final-delivery-2026`, las dos variantes ZIP y los enlaces de los Releases se verificaron el 2026-11-05. `ariel5253` tiene acceso de escritura en `BK_HS`, `FT_HS` y `Firmaware_HS`; `PT_HS`, `BD_HS` y `DOCS_HS` todavía requieren que el propietario del repositorio conceda el acceso de escritura.

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
