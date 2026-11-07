# Alerta Mujer

Final delivery of the training project / Entrega final del proyecto formativo.

## General information / Información general

| Field / Campo | Value / Valor |
|---|---|
| Product name / Nombre del producto | Alerta Mujer |
| Ficha | 3145555 |
| Training program / Programa de formación | Análisis y Desarrollo de Software (228118) |
| Training project / Proyecto formativo | Desarrollo de software orientado a servicios |
| Training center / Centro de formación | Centro de la Industria, la Empresa y los Servicios (Regional Huila) |
| Process / Proceso | Completion of the technologist taught stage / Finalización de la etapa lectiva del tecnólogo |
| Research seedbed / Semillero de investigación | Developers & Geeks |
| Delivery version / Versión del código | [`final-delivery-2026`](code-tag/README.md), tag anotado sobre `main` en los cuatro repositorios originales |
| Delivery date / Fecha de entrega | 2026-11-06 (rama preparada para revisión y PR) |
| Delivered by / Entregado por | Freinier Steven Cardona Perez (`FreinierCardona`) |

## Summary / Resumen

- **Problem it solves / Problema que resuelve:** facilita activar una alerta SOS y conservar el contexto de una emergencia para apoyar su seguimiento por personas autorizadas. No garantiza una respuesta inmediata.
- **Target users / Usuarios:** usuarias de la aplicación móvil y personal administrativo autorizado; las relaciones con contactos de confianza se gestionan entre cuentas del sistema.
- **Main features / Funciones principales:** registro con verificación OTP, inicio de sesión, contactos de confianza, activación y seguimiento de emergencias, ubicación durante una alerta, captura manual de evidencias con almacenamiento privado, chat de emergencia y panel administrativo con auditoría.
- **Technology stack / Tecnologías:** aplicación móvil Android con React Native, Expo Router y TypeScript; sitio web y panel administrativo con React, TypeScript y Vite; API con Java 21 y Spring Boot 4.1.1; PostgreSQL con Liquibase; REST y WebSocket/STOMP.
- **Production URL / URL en producción:** pendiente de verificar y enlazar.
- **Demo credentials / Credenciales de prueba:** solicitar una cuenta de prueba por un canal privado al responsable de la entrega. No publicar contraseñas, tokens, llaves ni archivos `.env`.

## Ejecución local / Local setup

La secuencia completa está en el [manual de instalación](08-manuals/installation-manual.pdf). Los repositorios originales de [base de datos](https://github.com/FreinierCardona/AlertaMujer_Database), [backend](https://github.com/FreinierCardona/AlertaMujer_Backend) y [frontend](https://github.com/FreinierCardona/AlertaMujer_Frontend) deben quedar como carpetas hermanas. Use Docker Desktop con Compose v2, PowerShell, Node.js con npm y un emulador Android o un teléfono para la aplicación móvil. Java 21 solo es necesario si ejecuta el backend fuera de Docker.

La versión reproducible del código es el tag anotado `final-delivery-2026` de cada repositorio, con sus ZIP y SHA-256 enlazados en [`code-tag/README.md`](code-tag/README.md). Los pasos siguientes usan la configuración local de los repositorios.

### 1. Base de datos

Desde `AlertaMujer_Database/`, copie `.env.example` a `.env`. Defina valores locales distintos para `POSTGRES_PASSWORD`, `APP_DB_PASSWORD` y `MIGRATOR_DB_PASSWORD`. Mantenga `APP_DB_USER=alertamujer_app` y `MIGRATOR_DB_USER=alertamujer_migrator`. Si `ADMIN_BOOTSTRAP_ENABLED=true`, complete también `ADMIN_BOOTSTRAP_USERNAME`, `ADMIN_BOOTSTRAP_FIRST_NAMES`, `ADMIN_BOOTSTRAP_LAST_NAMES`, `ADMIN_BOOTSTRAP_EMAIL`, `ADMIN_BOOTSTRAP_PHONE` y `ADMIN_BOOTSTRAP_PASSWORD` para crear el administrador inicial.

```powershell
Copy-Item .env.example .env
docker compose up -d
docker compose logs liquibase
docker compose logs bootstrap-admin
```

La base local se publica por defecto en `127.0.0.1:5434`. Espere a que Liquibase termine correctamente antes de iniciar el backend. El administrador inicial se configura en el `.env` **privado** de la base de datos; su cuenta no es el usuario técnico `alertamujer_app`.

### 2. Backend

Desde `AlertaMujer_Backend/`, copie `.env.example` a `.env`. `SPRING_DATASOURCE_PASSWORD` debe coincidir con `APP_DB_PASSWORD` de la base y `SPRING_DATASOURCE_USERNAME` debe ser `alertamujer_app`. Defina `JWT_SECRET` de al menos 32 bytes y configure `SMTP_HOST`, `SMTP_PORT`, `SMTP_USERNAME`, `SMTP_PASSWORD`, `SMTP_FROM`, `SMTP_AUTH` y `SMTP_STARTTLS` para que el registro y la recuperación puedan enviar OTP. Revise `CORS_ALLOWED_ORIGINS` para el origen web que utilizará. El valor local de `SPRING_DATASOURCE_URL` de la plantilla apunta a `host.docker.internal:5434`.

```powershell
Copy-Item .env.example .env
docker compose up --build -d
docker compose logs backend
```

La API queda en `http://localhost:8081/api/v1` y el endpoint técnico en `http://localhost:8081/actuator/health`. Un fallo del indicador SMTP puede devolver `503` en la salud agregada aunque el servicio REST y PostgreSQL estén disponibles; consulte los logs para identificar el componente que falla. Las evidencias se guardan en un volumen privado persistente configurado por `EVIDENCE_STORAGE_PATH`.

### 3. Sitio web y panel administrativo

Desde `AlertaMujer_Frontend/web/`, copie `.env.example` a `.env` y configure `VITE_API_BASE_URL=http://localhost:8081` y `VITE_WS_BASE_URL=ws://localhost:8081` si abre la web en el mismo equipo. Esas variables contienen el **origen** del backend: el cliente añade `/api/v1` y `/ws` a las solicitudes. Si abre la web desde otro equipo, use la IP o el dominio alcanzable y añada su origen a `CORS_ALLOWED_ORIGINS` del backend.

```powershell
Copy-Item .env.example .env
npm ci
npm run dev
```

Abra `http://localhost:5173`; el acceso administrativo está en `/admin/login` y usa la cuenta inicial configurada en la base de datos.
Para servir la web en la red local, ejecute `npm run dev -- --host 0.0.0.0` y ajuste el origen permitido en el backend.

### 4. Aplicación móvil

Desde `AlertaMujer_Frontend/mobile/`, copie `.env.example` a `.env` y configure `EXPO_PUBLIC_API_BASE_URL=http://<IP-LAN-DEL-PC>:8081` para un teléfono físico en la misma red. Para el emulador Android, use `http://10.0.2.2:8081`. No añada `/api/v1`: el cliente lo añade a sus rutas. El teléfono debe poder alcanzar el backend por la red y el registro requiere el SMTP del paso 2.

```powershell
Copy-Item .env.example .env
npm ci
npm start
```

Expo Go no permite validar el servicio persistente de ubicación Android; para comprobar ese comportamiento se necesita una compilación de desarrollo compatible.

Configure todas las contraseñas, tokens y llaves únicamente en archivos `.env` locales excluidos de Git o en un gestor de secretos. Si alguno se ha publicado en el historial, cámbielo antes de hacer público el repositorio. Los nombres de variables y los valores de ejemplo están en las plantillas `.env.example`; las credenciales de acceso se comparten por canal privado con quien deba probar el sistema.

## Team members / Integrantes

> Names and document numbers were preloaded by the instructor from the Sofía Plus report. Each member checks their row, completes GitHub user and role, and marks the last column. Report any error, missing member or extra member to the instructor.
>
> Los nombres y documentos los precargó el instructor desde el reporte de Sofía Plus. Cada integrante revisa su fila, completa usuario de GitHub y rol, y marca la última columna. Reporte al instructor cualquier error, o si falta o sobra alguien.

| Full name / Nombre completo | Doc. type / Tipo | Doc. number / Número | Ficha | GitHub user / Usuario | Role / Rol | Verified and authorized / Verificado y autorizado |
|---|---|---|---|---|---|---|
| FREINIER STEVEN CARDONA PEREZ | TI | 1077726586 | 3145555 | FreinierCardona | Backend, frontend, base de datos, pruebas y documentación | ☑ |

Data use authorization: by checking the box, the member confirms their data and authorizes publishing their name, document number and ficha in this public repository, for the software registration process (Ley 1581 de 2012). Anyone who does not authorize it tells the instructor before delivering.

Autorización de datos: al marcar la casilla, el integrante confirma sus datos y autoriza publicar su nombre, número de documento y ficha en este repositorio público, para el trámite de registro de software (Ley 1581 de 2012). Quien no lo autorice se lo informa al instructor antes de entregar.

## Delivery contents / Contenido de la entrega

| Folder / Carpeta | Content / Contenido | Done / Listo |
|---|---|---|
| [`01-requirements-specification/`](01-requirements-specification/) | Requirements specification / Especificación de requisitos | ☑ PDF + DOCX |
| [`02-software-analysis/`](02-software-analysis/) | Software analysis / Análisis del software | ☑ PDF + DOCX |
| [`03-technical-proposal/`](03-technical-proposal/) | Technical proposal / Propuesta técnica | ☑ PDF + DOCX |
| [`04-software-design/`](04-software-design/) | Software design / Diseño del software | ☑ PDF + DOCX |
| [`05-test-documentation/`](05-test-documentation/) | Test documentation / Documentación de pruebas | ☑ PDF + DOCX |
| [`06-implementation-procedure/`](06-implementation-procedure/) | Implementation procedure / Procedimiento de implementación | ☑ PDF + DOCX |
| [`07-improvement-actions/`](07-improvement-actions/) | Improvement actions / Acciones de mejoramiento | ☑ PDF + DOCX |
| [`08-manuals/`](08-manuals/) | Manuals / Manuales | ☑ 3 PDF + 3 DOCX |
| [`09-project-article/`](09-project-article/) | Project article / Artículo del proyecto | ☑ PDF + DOCX |
| [`10-videos/`](10-videos/) | Videos / Videos | ☑ Archivos originales MP4 enlazados en Google Drive |
| [`code-tag/`](code-tag/) | Repository links, tags and ZIP files / Enlaces, tags y ZIP | ☑ Tags, ZIP y SHA-256 publicados; invitaciones del instructor pendientes de aceptación |
| [`team-roster.md`](team-roster.md) | Team and roles / Equipo y roles | ☑ Aprendiz identificado y rol documentado; aportes de instructores sujetos a ratificación |
| [`software-registration.md`](software-registration.md) | Software registration data / Datos para registro de software | ☑ Ficha técnica y anexos; declaraciones institucionales sujetas a ratificación |

## Large files on Google Drive / Archivos pesados en Google Drive

The two original MP4 videos are shared through Google Drive; the documents remain in this folder. / Los dos videos originales en MP4 se comparten mediante Google Drive y los documentos permanecen en esta carpeta.

| File / Archivo | Hosting / Alojamiento | Link / Enlace |
|---|---|---|
| Advertising pitch / Pitch publicitario (`AlertaMujer-pitch-publicitario.mp4`) | Google Drive | [Ver o descargar MP4](https://drive.google.com/file/d/1kdgJWpMYIDBZe91LRJHs_w0KXALURQs-/view?usp=sharing) |
| Usage tutorial / Tutorial de uso (`Tutorial de Uso.mp4`) | Google Drive | [Ver o descargar MP4](https://drive.google.com/file/d/1vHyMte3tTOKHkvY8ptgIGUeUgV-Pj78H/view?usp=sharing) |
