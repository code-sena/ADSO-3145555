# Code and tags / Código y tags: SmartHome

## Original repositories / Repositorios originales

Every original working repository of the project must be listed here and must be **public**. The instructor compares what was delivered against these repositories, so they must stay public and keep their full history until the review ends.

Todos los repositorios originales de trabajo del proyecto deben estar aquí y deben ser **públicos**. El instructor contrasta lo entregado contra estos repositorios, así que deben seguir públicos y con todo su historial hasta terminar la revisión.

If one is missing, add a row. If one is empty or no longer used, write that in the commit column. The visibility shown was checked on 2026-11-04.

Si falta alguno, agregue la fila. Si uno está vacío o ya no se usa, indíquelo en la columna del commit. La visibilidad indicada se revisó el 2026-11-04.

| Componente | Repositorio original solicitado por el instructor | Estado verificado el 07-11-2026 | Acceso de `ariel5253` | SHA actual de `main` (NO tag final) | Tag `final-delivery-2026` | ZIP snapshot / export |
|---|---|---|---|---|---|---|
| Móvil | [from_movil](https://github.com/Kevin-Stiven-Lopez-Amaya404/from_movil) | `main` existe, pero es histórico; rama por defecto `dev`, PR móvil pendiente | Read; cambiar a Write | `f1deb5331a07ef5` | **No creado** | Pendientes |
| Documentación anterior | [smart-home-docs](https://github.com/Kevin-Stiven-Lopez-Amaya404/smart-home-docs) | Público; 1 archivo, repo histórico/no canónico | Read; cambiar a Write | `f4d1fe99db50007` | **No creado** | Pendientes |
| Base de datos anterior | [smart-home-database](https://github.com/nataliachala1/smart-home-database) | Público; README, sin modelo actual completo | No verificable desde integración; otorgar Write | `aa20de5230627f5` | **No creado** | Pendientes |
| Backend | [smarthome-backend](https://github.com/nataliachala1/smarthome-backend) | Público; `main` protegida, pendiente de cierre técnico | No verificable desde integración; otorgar Write | `e5097116c603ea6` | **No creado** | Pendientes |
| Frontend web | [smarthome-frontend-web](https://github.com/nataliachala1/smarthome-frontend-web) | Público; CI de `main` fallida | No verificable desde integración; otorgar Write | `daae7a411c0da21` | **No creado** | Pendientes |

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


## Identificación inequívoca de la documentación oficial

**Repositorio de documentación canónico recomendado:** [Kevin-Stiven-Lopez-Amaya404/smart-home-doc](https://github.com/Kevin-Stiven-Lopez-Amaya404/smart-home-doc). Contiene la documentación técnica desarrollada (152 archivos en la revisión del instructor). `smart-home-docs` es un repositorio de referencia anterior con solo un archivo y NO debe presentarse como fuente documental completa. **El instructor solicita también etiquetar/exportar `smart-home-docs`; no debe omitirse del paquete de cinco repositorios exigido sin su aprobación.** Se recomienda mantener un sexto paquete para el repo documental canónico, si el equipo y el instructor lo autorizan.

**Base de datos de trabajo vigente:** [nataliachala1/smarthome-database](https://github.com/nataliachala1/smarthome-database). El nombre que aparece en la plantilla del instructor, `nataliachala1/smart-home-database`, corresponde al repositorio anterior. Esta diferencia requiere que el equipo confirme si debe entregarse también el repositorio vigente además de los cinco exigidos; no reemplazar uno por otro silenciosamente.

## Condición obligatoria antes de etiquetar y generar paquetes

No existe el tag `final-delivery-2026` en ninguno de los **cinco** repositorios solicitados a la fecha de revisión. Los SHA de la tabla reflejan el estado observado de `main`; **no son commits aprobados para release**. No crear tags hasta revisar CI/QA, cerrar ramas y obtener la aprobación del responsable técnico. Cada uno de los cinco requiere dos ZIP diferentes (snapshot `main` al tag anotado y repositorio Git completo con ramas/tags/historial) y hashes SHA-256 calculados sobre los bytes reales. Luego adjuntar los diez ZIP al Release `final-delivery` del fork de la persona que entrega y colocar enlaces/huellas en esta carpeta.

## Accesos del instructor

`ariel5253` debe tener **Write** en los cinco repositorios. Se verificó **Read** (insuficiente) en `from_movil` y `smart-home-docs`. Para las tres cuentas de Natalia, el conector no permitió consultar permisos (403); sus propietarios deben comprobarlo en **Settings → Collaborators and teams → Invite a collaborator**. No se han cambiado permisos de nadie mediante esta actualización documental.
