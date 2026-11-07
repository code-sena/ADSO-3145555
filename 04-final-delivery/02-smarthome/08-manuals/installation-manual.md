# Manual De Instalación

**Proyecto:** SmartHome · **ADSO:** 3145555 · **Fecha:** 6 de noviembre de 2026

**Elaborado por:** Natalia Chala Chala, Kevin Stiven López Amaya, Karen Daniela Holguín Cruz

---

## 1. Objetivo y condiciones de uso

Este manual presenta una ruta de instalación local orientada a Windows y PowerShell, apropiada para desarrollo y pruebas académicas de SmartHome. Los pasos se basan en los README y archivos de configuración de los cuatro repositorios. No se ejecutaron contra los equipos del usuario al redactar el documento: deben aplicarse sobre un entorno de prueba autorizado.

**Antes de ejecutar.** No reutilices contraseñas de manuales antiguos, no subas archivos .env a Git y no apliques migraciones a una base compartida sin respaldo, revisión y autorización.

## 2. Requisitos previos

| Herramienta | Referencia verificable | Uso |
| --- | --- | --- |
| Git | Versión compatible con clonación HTTPS | Obtener y actualizar los repositorios. |
| Node.js | 22, según los workflows actuales | Backend NestJS y clientes web/móvil. |
| npm | Incluido con Node.js | Instalación reproducible mediante npm ci. |
| Docker + Compose | Compatible con compose v2 | PostgreSQL local y Liquibase desde el repositorio DB. |
| Android / Expo | Teléfono Android o emulador para pruebas; build nativo si se necesita BLE | Validación de app móvil. |
| PowerShell | Windows 10/11 con comandos disponibles | Procedimiento de ejemplo en este manual. |

El entorno de base de datos del compose local usa PostgreSQL 16 Alpine; las verificaciones CI de BD se han realizado también contra un entorno desechable PostgreSQL 18, que no debe confundirse con la configuración local.

## 3. Organización del espacio de trabajo

Crea una carpeta independiente para la solución. La aplicación web se ejecuta desde su subcarpeta web/, no desde la raíz del repositorio. La documentación central se conserva por separado y no es necesaria para arrancar los servicios.

```powershell
New-Item -ItemType Directory -Force SmartHome | Out-Null
Set-Location SmartHome

git clone https://github.com/nataliachala1/smarthome-database.git
git clone https://github.com/nataliachala1/smarthome-backend.git
git clone https://github.com/nataliachala1/smarthome-frontend-web.git
git clone https://github.com/Kevin-Stiven-Lopez-Amaya404/from_movil.git
```

Selecciona la rama de trabajo acordada por el equipo y conserva su commit para reproducibilidad. No fuerces una mezcla entre dev, qa y main. Para revisar las ramas disponibles utiliza git branch -a y git log -1 --oneline.

## 4. Base de datos y migraciones Liquibase

La instalación local comienza por la base de datos. El archivo docker-compose.yml contiene el servicio postgres y un servicio liquibase bajo un perfil de herramientas. La cuenta que aplica el esquema no debe reutilizarse automáticamente como cuenta de ejecución del backend.

### 4.1. Preparar configuración local

```powershell
Set-Location smarthome-database
Copy-Item .env.example .env
# Edita .env para establecer una contraseña local segura.
docker compose config
```

### 4.2. Iniciar PostgreSQL de desarrollo

```powershell
docker compose up -d --wait postgres
docker compose ps
```

Comprueba el estado healthy del contenedor y que el puerto definido en .env esté disponible. Si el volumen o el puerto pertenecen a otra instancia, detén el proceso y revisa: no borres datos ni volúmenes por ensayo y error.

### 4.3. Revisar migraciones antes de aplicarlas

```powershell
docker compose run --rm liquibase --defaults-file=liquibase.properties validate
docker compose run --rm liquibase --defaults-file=liquibase.properties update-sql
```

Revisa los cambios previstos y su destino. Solo en una base local de pruebas preparada para recibirlos, y con autorización del equipo, procede a aplicar el changelog:

```powershell
# Solo tras verificar destino y cambios:
docker compose run --rm liquibase --defaults-file=liquibase.properties update
```

**Precaución.** update modifica la base configurada. No lo ejecutes en QA/producción desde un manual de clase. Los roles LOGIN operativos del backend deben aprovisionarse por procedimiento específico y con mínimo privilegio; el README de BD indica que los roles del esquema son principalmente NOLOGIN.

## 5. Backend NestJS

El backend usa variables para PostgreSQL, JWT, CORS y servicios opcionales. La plantilla del repositorio es la referencia válida; no uses las contraseñas, IP o nombres de archivo que figuren en versiones históricas del manual.

```powershell
Set-Location ..\smarthome-backend
Copy-Item .env.example .env
npm ci
npm run start:dev
```

Antes de arrancar, adapta .env al entorno local real. DATABASE_URL y DATABASE_IOT_URL necesitan credenciales de LOGIN con los permisos correctos, no la cuenta propietaria del esquema. Mantén MQTT y pairing según el estado autorizado: la plantilla contiene opciones de laboratorio y varias protecciones de producción deshabilitadas. No actives opciones de producción sin validar broker TLS, políticas y migraciones.

| Variable o grupo | Propósito | Qué revisar |
| --- | --- | --- |
| PORT | Puerto de la API | Evitar conflicto con otros servicios. |
| DATABASE_URL / DATABASE_IOT_URL | Acceso de aplicación e ingesta a PostgreSQL | Conexiones, roles y permisos correctos. |
| JWT_SECRET / JWT_REFRESH_SECRET | Firma de sesiones | Valores propios fuera de Git. |
| FRONTEND_URL / CORS_ALLOWED_ORIGINS | Navegadores autorizados | Concordancia con el origen de Vite. |
| MQTT_ENABLED / MQTT_BROKER_URL | Comunicación IoT habilitada | Broker disponible y esquema de autenticación válido. |
| SHELLY_* | Funciones específicas Shelly | No forzar pairing o control productivo en laboratorio. |

La API usa prefijo /api/v1. Cuando Swagger está habilitado, puede encontrarse en /api/docs. Para comprobar el backend, observa la consola de arranque, el código HTTP de una ruta pública documentada o Swagger, sin publicar tokens ni URLs privadas.

## 6. Frontend web React/Vite

El código de ejecución y las dependencias están dentro de web/. El README indica que VITE_BACKEND_URL controla el destino del proxy de Vite; por defecto se puede utilizar localhost:3000 si el navegador corre en el mismo equipo que el backend.

```powershell
Set-Location ..\smarthome-frontend-web\web
Copy-Item .env.example .env.local
npm ci
npm run dev
```

Configura VITE_BACKEND_URL con la dirección real del backend y conserva VITE_API_URL como base relativa /api/v1 cuando corresponda a la configuración. Vite mostrará el puerto de escucha en consola (habitualmente 5173). Comprueba la carga de la vista /login y la respuesta a solicitudes del backend. Las variables VITE_* son visibles al cliente: no introduzcas secretos.

**No confundir entornos.** El docker-compose.yml de la raíz del repositorio web hace referencia a directorios externos no incluidos en un clon limpio. No ejecutes docker compose up --build allí esperando que funcione sin preparar esas rutas.

## 7. Aplicación móvil Expo

La aplicación móvil tiene sus propias dependencias y archivo de entorno. La conexión hacia la API desde un teléfono físico requiere una dirección accesible desde el teléfono: localhost se refiere al teléfono mismo.

```powershell
Set-Location ..\..\from_movil
Copy-Item .env.example .env.local
npm ci
npx expo start --clear --lan
```

En .env.local define EXPO_PUBLIC_API_URL con la URL completa de la API terminada en /api/v1 y accesible desde Android. Revisa Wi-Fi, firewall y el puerto real del backend. Para funciones BLE de Shelly, Expo Go puede ser insuficiente: se requiere un development build o APK con módulos nativos compatibles.

Los comandos EAS de compilación o actualización OTA no se ejecutan por el simple hecho de documentar la instalación: requieren configuración, perfil, canal, aprobación y una versión validada.

## 8. Verificaciones de calidad

| Componente | Comandos de verificación | Resultado esperado |
| --- | --- | --- |
| Backend | npm run lint; npm test; npm run build | Validaciones y compilación sin errores. |
| Web (desde web/) | npm run lint; npm run typecheck; npm run test:contracts; npm run build | Tipado, contratos y salida Vite válidos. |
| Base de datos | docker compose run --rm liquibase ... validate | Changesets coherentes con el destino local. |
| Móvil | npm run lint; npm run typecheck; npm run test:mobile-config; npm run test:navigation-auth | Config, navegación y chequeos de regresión aprobados. |

También deben registrarse la fecha, el commit, la herramienta utilizada y el resultado observado. Un workflow en verde verifica sus propios pasos; no demuestra por sí mismo que el usuario pueda controlar un Shelly real.

## 9. Comprobación funcional del entorno

1. Inicia PostgreSQL y comprueba que el contenedor esté listo.
1. Confirma que las migraciones se validan y se aplican solo al destino aprobado.
1. Levanta backend y revisa que no existan errores de conexión o configuración de JWT.
1. Abre el cliente web y valida la pantalla de acceso y la comunicación HTTP.
1. Abre la aplicación móvil y confirma que la URL de API configurada sea alcanzable desde Android.
1. Solo con equipo físico autorizado, realiza una prueba separada de estado/telemetría Shelly; no confundir orden enviada con relé confirmado.

## 10. Solución de problemas frecuentes

| Síntoma | Causa probable | Comprobación recomendada |
| --- | --- | --- |
| El backend no inicia | Variables insuficientes o PostgreSQL no disponible | Revisar .env, Docker y los logs de conexión. |
| Errores RLS / acceso denegado | Cuenta LOGIN o contexto de autorización incorrecto | Verificar roles, membresías y políticas según repositorio DB. |
| La web carga pero falla el API | VITE_BACKEND_URL, proxy o CORS incorrectos | Comprobar destino real y origen permitido. |
| La app Android no conecta | EXPO_PUBLIC_API_URL apunta a localhost o red inaccesible | Usar una dirección LAN accesible, revisar firewall y puerto. |
| No funciona BLE en Expo Go | Falta módulo nativo | Instalar development build compatible; no prometer pairing completo. |
| No hay respuesta de Shelly | Dispositivo sin conexión, broker/credenciales o pairing pendiente | Comprobar conectividad y contrato sin compartir secretos. |
| Error al migrar | Changelog o privilegios incompatibles | Detener operación, revisar update-sql y respaldo. |

## 11. Despliegue QA y producción: condiciones de seguridad

Este manual documenta la instalación local. No constituye un procedimiento de despliegue productivo acreditado. La CI del frontend web permite validar y construir la imagen; su trabajo deploy está deshabilitado. El backend menciona despliegue Dokploy bajo condiciones propias. La base de datos exige respaldos y aprobación antes de ejecutar migraciones QA o productivas.

- Nunca copiar un archivo .env local directamente a un repositorio.
- Nunca publicar credenciales de demostración en documentos o capturas.
- Evitar comandos destructivos de volúmenes (por ejemplo docker compose down -v) en un entorno con datos.
- Conservar la evidencia del commit validado y de la versión etiquetada antes de la entrega.
- Repetir las pruebas de integración después de cambiar el esquema o el contrato API.

## 12. Conclusión

La instalación de SmartHome requiere respetar el orden de dependencias: base de datos y roles de ejecución, backend, clientes web y móvil. El procedimiento anterior sustituye rutas y comandos genéricos de los manuales antiguos por referencias concretas de los repositorios actuales. Las verificaciones que dependan de credenciales, redes o hardware deberán ejecutarse en el ambiente aprobado y documentarse con evidencia.

## Fuentes y referencias verificables

1. [Guía institucional del producto 08](https://github.com/code-sena/ADSO-3145555/blob/main/04-final-delivery/02-smarthome/08-manuals/README.md)
2. [Repositorio y README de base de datos](https://github.com/nataliachala1/smarthome-database/blob/dev/README.md)
3. [Compose de base de datos](https://github.com/nataliachala1/smarthome-database/blob/dev/docker-compose.yml)
4. [README del backend](https://github.com/nataliachala1/smarthome-backend/blob/dev/README.md)
5. [Plantilla del backend](https://github.com/nataliachala1/smarthome-backend/blob/dev/.env.example)
6. [README frontend web](https://github.com/nataliachala1/smarthome-frontend-web/blob/dev/README.md)
7. [README frontend móvil](https://github.com/Kevin-Stiven-Lopez-Amaya404/from_movil/blob/dev/README.md)
8. [Guía BLE de móvil](https://github.com/Kevin-Stiven-Lopez-Amaya404/from_movil/blob/dev/docs/BLE_POC_ANDROID.md)
9. [Manual de instalación histórico en Drive](https://docs.google.com/document/d/1sYD9SispvHPIfnzInASyzVmcTEXtA5Ps/edit)