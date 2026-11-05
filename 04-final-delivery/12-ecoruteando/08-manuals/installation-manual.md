# Manual de Instalación — EcoRuteando

| Campo | Valor |
|-------|-------|
| **Proyecto** | EcoRuteando |
| **Versión** | 1.0 |
| **Fecha** | 13 de octubre de 2026 |
| **Dirigido a** | Desarrolladores que necesiten levantar el proyecto por primera vez |

---

## Índice

1. [Requisitos previos](#1-requisitos-previos)
2. [Clonar los repositorios](#2-clonar-los-repositorios)
3. [Configurar variables de entorno](#3-configurar-variables-de-entorno)
4. [Instalación rápida con Docker (recomendada)](#4-instalación-rápida-con-docker)
5. [Instalación manual paso a paso (sin Docker)](#5-instalación-manual-paso-a-paso)
6. [Ejecutar la aplicación móvil](#6-ejecutar-la-aplicación-móvil)
7. [Verificación post-instalación](#7-verificación-post-instalación)
8. [Solución de problemas de instalación](#8-solución-de-problemas-de-instalación)
9. [Actualizaciones y migraciones](#9-actualizaciones-y-migraciones)

---

## 1. Requisitos previos

### 1.1 Herramientas obligatorias

| Herramienta | Versión mínima | Para qué se usa | Verificar con |
|------------|---------------|-----------------|---------------|
| **Git** | 2.x | Clonar repositorios | `git --version` |
| **Docker** | 29.x | Contenedores (postgres, backend, frontend) | `docker --version` |
| **Docker Compose** | v2 | Orquestación del stack | `docker compose version` |

### 1.2 Herramientas según lo que vayas a ejecutar

| Herramienta | Versión mínima | Necesario para | Verificar con |
|------------|---------------|----------------|---------------|
| **.NET SDK** | 9.0 | Backend sin Docker | `dotnet --version` |
| **Node.js** | 22.x | Frontend y móvil | `node -v` |
| **npm** | 10.x | Frontend y móvil | `npm -v` |
| **Expo CLI** | ~57 | App móvil | `npx expo --version` |
| **adb** | (Android SDK) | Móvil en dispositivo físico | `adb version` |

### 1.3 Cuentas externas necesarias

| Servicio | Para qué | Obligatorio |
|----------|----------|-------------|
| **Google Cloud Console** | API key de Google Maps + OAuth Client ID | ✅ Sí (mapas y login) |
| **Meta for Developers** | Facebook App ID + Secret (OAuth) | ⚠️ Opcional |
| **Gmail** | Cuenta con contraseña de aplicación para SMTP | ⚠️ Opcional (verificación email) |
| **Expo (expo.dev)** | Cuenta para EAS Build | ⚠️ Opcional (solo builds de móvil) |

### 1.4 Espacio en disco

| Componente | Espacio aproximado |
|-----------|-------------------|
| Docker images (postgres + backend + frontend) | ~2 GB |
| PostgreSQL data | ~50 MB (inicial) |
| node_modules (frontend) | ~300 MB |
| node_modules (móvil) | ~400 MB |
| .NET SDK (si no está instalado) | ~500 MB |
| **Total estimado** | **~3.5 GB** |

---

## 2. Clonar los repositorios

EcoRuteando consta de **4 repositorios**. Clona todos en tu directorio de trabajo:

```bash
# 1. Repositorio del backend (.NET 9)
git clone <URL-DEL-REPO-BACKEND> ~/Escritorio/EcoRuteandoBackend

# 2. Repositorio del frontend + docker-compose (React + Vite)
git clone <URL-DEL-REPO-FRONTEND> ~/Escritorio/EcoRuteando

# 3. Repositorio de la base de datos (Liquibase + PostgreSQL)
git clone <URL-DEL-REPO-DB> ~/Escritorio/EcoRuteandoDb

# 4. Repositorio de la app móvil (Expo / React Native)
git clone <URL-DEL-REPO-MOVIL> ~/Escritorio/Movil-EcoRuteando
```

### 2.1 Estructura esperada tras clonar

```
~/Escritorio/
├── EcoRuteandoBackend/          # API .NET 9
│   ├── EcoRuteando.sln
│   ├── dockerfile
│   └── src/
├── EcoRuteando/                 # Frontend + docker-compose
│   ├── docker-compose.yml
│   └── front-end/
│       └── ecoRuteando-react/
├── EcoRuteandoDb/               # Base de datos
│   ├── changelog/
│   └── docker/
└── Movil-EcoRuteando/           # App móvil
    ├── app/
    └── package.json
```

### 2.2 Verificar que clonaste correctamente

```bash
# Debe mostrar archivos
ls ~/Escritorio/EcoRuteandoBackend/EcoRuteando.sln
ls ~/Escritorio/EcoRuteando/docker-compose.yml
ls ~/Escritorio/EcoRuteandoDb/changelog/db.changelog-master.yaml
ls ~/Escritorio/Movil-EcoRuteando/package.json

# Verificar ramas actuales
for dir in EcoRuteandoBackend EcoRuteando EcoRuteandoDb Movil-EcoRuteando; do
  echo "=== $dir ==="
  git -C ~/Escritorio/$dir branch --show-current
done
```

---

## 3. Configurar variables de entorno

### 3.1 Backend — `EcoRuteandoBackend/.env`

Copia la plantilla oficial:

```bash
cp ~/Escritorio/EcoRuteandoBackend/.env.example ~/Escritorio/EcoRuteandoBackend/.env
```

Edita el archivo con tus valores:

```bash
nano ~/Escritorio/EcoRuteandoBackend/.env
```

**Contenido mínimo obligatorio:**

```bash
# Base de datos (usa las credenciales del docker-compose)
ConnectionStrings__DefaultConnection=Host=postgres;Port=5432;Database=ecoRuteando_db;Username=postgres;Password=postgres

# JWT — genera una clave segura
Jwt__Issuer=EcoRuteando
Jwt__Audience=EcoRuteandoUsers
Jwt__SecretKey=REEMPLAZA_CON_CLAVE_SEGURA_MINIMO_32_BYTES
Jwt__ExpirationMinutes=60

# SMTP (opcional pero recomendado)
EmailSettings__Host=smtp.gmail.com
EmailSettings__Port=587
EmailSettings__EnableSsl=true
EmailSettings__Username=tu_correo@gmail.com
EmailSettings__Password=contraseña_de_aplicacion_de_16_caracteres
EmailSettings__FromName=EcoRuteando
EmailSettings__FromEmail=no-reply@ecoruteando.com

# Google OAuth (para login con Google)
Google__ClientId=tu_client_id_de_google_cloud
Google__ClientSecret=tu_client_secret_de_google_cloud

# Facebook OAuth (opcional)
Facebook__AppId=tu_app_id_de_facebook
Facebook__AppSecret=tu_app_secret_de_facebook

# Google Maps (para planificación de rutas)
GoogleMaps__ApiKey=tu_api_key_de_google_maps

# Admin seed (contraseña inicial del admin)
Admin__Email=admin@ecoruteando.com
Admin__Password=EcoAdmin!2026
```

**Generar clave JWT segura:**

```bash
openssl rand -base64 64
```

### 3.2 Frontend — `front-end/ecoRuteando-react/.env`

```bash
cp ~/Escritorio/EcoRuteando/front-end/ecoRuteando-react/.env.example \
   ~/Escritorio/EcoRuteando/front-end/ecoRuteando-react/.env
```

**Contenido:**

```bash
# Clave JavaScript de Google Maps (para renderizar el mapa en el navegador)
VITE_GOOGLE_MAPS_API_KEY=tu_api_key_javascript_de_google_maps

# OAuth (si usas login con Google/Facebook desde la web)
VITE_GOOGLE_CLIENT_ID=tu_client_id_de_google_cloud
VITE_FACEBOOK_APP_ID=tu_app_id_de_facebook
```

> **Importante:** La API key del frontend (`VITE_GOOGLE_MAPS_API_KEY`) es **diferente** a la del backend (`GoogleMaps__ApiKey`). En Google Cloud Console, habilita la **Maps JavaScript API** para la clave del frontend y **Directions API + Geocoding API + Places API** para la clave del backend.

### 3.3 Móvil — `Movil-EcoRuteando/.env`

```bash
cp ~/Escritorio/Movil-EcoRuteando/.env.example \
   ~/Escritorio/Movil-EcoRuteando/.env
```

**Contenido para desarrollo local:**

```bash
# URL del backend (para Expo Go en el mismo ordenador)
EXPO_PUBLIC_API_URL=http://localhost:5124

# Google Maps para React Native
EXPO_PUBLIC_GOOGLE_MAPS_KEY=tu_api_key_de_google_maps

# OAuth Google
EXPO_PUBLIC_GOOGLE_CLIENT_ID=tu_client_id_de_google_cloud
```

### 3.4 Configurar Google Cloud Console (guía rápida)

1. Ve a [console.cloud.google.com](https://console.cloud.google.com)
2. Crea un proyecto (o selecciona uno existente)
3. **Habilita APIs:**
   - Maps JavaScript API
   - Directions API
   - Geocoding API
   - Places API
4. **Crea credenciales:**
   - **API Key** → para `GoogleMaps__ApiKey` (backend) y `VITE_GOOGLE_MAPS_API_KEY` (frontend)
   - **OAuth Client ID (Web)** → para `Google__ClientId` y `VITE_GOOGLE_CLIENT_ID`
5. **Restringe la API Key** (recomendado):
   - Por HTTP referrer: `http://localhost:3007/*` y tu dominio de producción
   - Por IP: solo si usas el backend desde un servidor fijo

### 3.5 ⚠️ Reglas de seguridad para `.env`

- **NUNCA** commitees archivos `.env` (ya están en `.gitignore`)
- **NUNCA** pongas claves reales en `docker-compose.yml`
- **NUNCA** compartas tu `.env` por chat o correo
- Si una clave se filtra: **rotala inmediatamente** en Google Cloud Console

---

## 4. Instalación rápida con Docker

Esta es la **forma recomendada** de levantar el proyecto completo.

### 4.1 Un solo comando

```bash
cd ~/Escritorio/EcoRuteando
docker compose up -d
```

Este comando levanta **4 servicios** en orden automático:

```
postgres (1)  →  liquibase (2)  →  backend (3)  →  frontend (4)
   salud              77 changesets     API REST         nginx + React
```

| Servicio | Contenedor | Puerto | Imagen |
|----------|-----------|--------|--------|
| postgres | ecoruteando-postgres | 5450 → 5432 | postgis/postgis:16-3.5 |
| liquibase | ecoruteando-liquibase | — | Custom (one-shot) |
| backend | ecoruteando-backend | 5124 → 5124 | Custom (.NET 9) |
| frontend | ecoruteando-frontend | 3007 → 80 | Custom (nginx + React) |

### 4.2 Verificar que todo arrancó

```bash
# Ver estado de contenedores (todos deben estar Up o Exited 0)
docker compose ps

# Esperar a que el backend esté listo
docker compose logs -f backend
# Debes ver: "Now listening on: http://[::]:5124"

# Presiona Ctrl+C para salir de los logs
```

### 4.3 Verificar cada servicio

```bash
# PostgreSQL
docker compose exec postgres pg_isready -U postgres -d ecoRuteando_db

# Backend (debe responder JSON)
curl http://localhost:5124/api/test/public

# Frontend (debe responder HTML)
curl -I http://localhost:3007
```

### 4.4 Abrir la aplicación

| Componente | URL |
|-----------|-----|
| **Frontend Web** | http://localhost:3007 |
| **Swagger (backend)** | http://localhost:5124/swagger |
| **Login admin** | admin@ecoruteando.com / EcoAdmin!2026 |

### 4.5 Reconstruir tras cambios de código

```bash
# Si cambiaste código del backend
docker compose build --no-cache backend
docker compose up -d backend

# Si cambiaste código del frontend (¡siempre --no-cache!)
docker compose build --no-cache frontend
docker compose up -d frontend

# Reconstruir todo
docker compose build --no-cache
docker compose up -d
```

### 4.6 Detener y limpiar

```bash
# Detener (conserva datos)
docker compose down

# Detener y BORRAR datos de PostgreSQL (⚠️ pierdes todo)
docker compose down -v

# Detener, borrar datos y reconstruir desde cero
docker compose down -v
docker compose up -d --build
```

---

## 5. Instalación manual paso a paso (sin Docker)

Útil para desarrollo cuando quieres ejecutar cada componente por separado.

### 5.1 Base de datos (PostgreSQL + Liquibase)

```bash
# Opción A: PostgreSQL en Docker (recomendada)
cd ~/Escritorio/EcoRuteando
docker compose up -d postgres

# Esperar a que esté sana
docker compose exec postgres pg_isready -U postgres -d ecoRuteando_db
```

**Aplicar migraciones Liquibase:**

```bash
# Opción A: Con Docker (automático)
docker compose up liquibase

# Opción B: Con el CLI de Liquibase instalado localmente
cd ~/Escritorio/EcoRuteandoDb
liquibase \
  --changeLogFile=changelog/db.changelog-master.yaml \
  --url=jdbc:postgresql://localhost:5450/ecoRuteando_db \
  --username=postgres \
  --password=postgres \
  update
```

**Verificar que las migraciones se aplicaron:**

```bash
docker compose exec postgres psql -U postgres -d ecoRuteando_db \
  -c "SELECT COUNT(*) AS changesets FROM databasechangelog;"
# Debe mostrar 77
```

### 5.2 Backend (.NET 9)

```bash
cd ~/Escritorio/EcoRuteandoBackend

# Restaurar dependencias
dotnet restore

# Compilar
dotnet build

# Ejecutar (asegúrate de que PostgreSQL esté corriendo)
dotnet run --project src/Api/EcoRuteando.Api
```

El backend queda disponible en `http://localhost:5124`.

**Si el backend no conecta a PostgreSQL**, verifica que la variable `ConnectionStrings__DefaultConnection` en `.env` apunte al host y puerto correctos:

```bash
# Para PostgreSQL en Docker (red del compose):
Host=postgres;Port=5432;Database=ecoRuteando_db;Username=postgres;Password=postgres

# Para PostgreSQL en localhost (puerto host):
Host=localhost;Port=5450;Database=ecoRuteando_db;Username=postgres;Password=postgres
```

### 5.3 Frontend (React + Vite)

```bash
cd ~/Escritorio/EcoRuteando/front-end/ecoRuteando-react

# Instalar dependencias
npm install

# Ejecutar en modo desarrollo
npm run dev
```

El frontend queda disponible en `http://localhost:5124` o el puerto que Vite muestre en consola (típicamente `http://localhost:5173` o `http://localhost:3007`).

**Nota:** En modo desarrollo sin nginx, el frontend llama al backend directamente a `http://localhost:5124`. Verifica que no haya problemas de CORS (el backend ya tiene CORS configurado para desarrollo).

### 5.4 Orden de arranque manual

```
1. PostgreSQL     →  esperar healthcheck
2. Liquibase      →  aplicar 77 changesets (one-shot)
3. Backend        →  dotnet run
4. Frontend       →  npm run dev
```

---

## 6. Ejecutar la aplicación móvil

### 6.1 Requisitos del móvil

| Componente | Detalle |
|-----------|---------|
| **Node.js** | 22.x |
| **Expo Go** | App instalada en tu teléfono (iOS/Android) |
| **Cuenta Expo** | Gratuita en [expo.dev](https://expo.dev) (solo para EAS Build) |
| **Metro bundler** | Se inicia con `npx expo start` |

### 6.2 Instalar dependencias

```bash
cd ~/Escritorio/Movil-EcoRuteando
npm install
```

### 6.3 Configurar `.env`

```bash
cp .env.example .env
nano .env
```

Para desarrollo local:

```bash
EXPO_PUBLIC_API_URL=http://localhost:5124
EXPO_PUBLIC_GOOGLE_MAPS_KEY=tu_api_key
EXPO_PUBLIC_GOOGLE_CLIENT_ID=tu_client_id
```

### 6.4 Ejecutar en Expo Go

```bash
npx expo start
```

Escanea el QR code con la cámara del teléfono (iOS) o con Expo Go (Android).

### 6.5 Conectar con el backend local

**Desde emulador Android:**

```bash
# En una terminal separada, antes de abrir Expo Go:
adb reverse tcp:5124 tcp:5124
adb reverse tcp:8081 tcp:8081
```

**Desde dispositivo físico (misma red WiFi):**

Cambia `.env` para usar la IP local de tu ordenador:

```bash
# Descubre tu IP local
ip addr | grep "inet " | grep -v 127.0.0.1

# Usa esa IP en .env
EXPO_PUBLIC_API_URL=http://192.168.1.XXX:5124
```

**Desde emulador iOS (simulador):**

`localhost` funciona directamente — no necesitas `adb reverse`.

### 6.6 Build con EAS (producción)

```bash
# Instalar EAS CLI
npm install -g eas-cli

# Autenticar con tu cuenta Expo
eas login

# Build de prueba (APK interno)
eas build --profile preview --platform android

# Build de producción
eas build --profile production --platform all
```

### 6.7 Build de desarrollo (development client)

```bash
eas build --profile development --platform android
```

Este build incluye el development client de Expo, lo que permite hot-reload sin Expo Go.

---

## 7. Verificación post-instalación

### 7.1 Checklist rápido

Ejecuta esta serie de comandos para verificar que todo funciona:

```bash
echo "=== 1. Contenedores ==="
docker compose ps

echo "=== 2. PostgreSQL ==="
docker compose exec postgres pg_isready -U postgres -d ecoRuteando_db

echo "=== 3. Backend ==="
curl -s http://localhost:5124/api/test/public | head -c 200

echo "=== 4. Frontend ==="
curl -sI http://localhost:3007 | head -1

echo "=== 5. Login admin ==="
curl -s -X POST http://localhost:5124/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"admin@ecoruteando.com","password":"EcoAdmin!2026"}' | head -c 200
```

### 7.2 Resultado esperado

| Paso | Esperado |
|------|----------|
| Contenedores | 4 servicios `Up` (liquibase puede estar `Exited 0`) |
| PostgreSQL | `accepting connections` |
| Backend | JSON con `"status":"healthy"` o similar |
| Frontend | `HTTP/1.1 200 OK` |
| Login | JSON con `"token":"..."` o `"accessToken":"..."` |

### 7.3 Prueba manual en el navegador

1. Abre `http://localhost:3007`
2. Inicia sesión con `admin@ecoruteando.com` / `EcoAdmin!2026`
3. Navega a **Planificar ruta**
4. Ingresa origen y destino (ej: "Neiva" → "Pitalito")
5. Selecciona tipo de transporte (caminando/carro/bici)
6. Verifica que se muestre la ruta en el mapa y la estimación de CO₂
7. Guarda la ruta y verifica que aparezca en **Mis rutas**

### 7.4 Prueba de la app móvil

1. Abre Expo Go en tu teléfono
2. Escanea el QR de `npx expo start`
3. Inicia sesión con las mismas credenciales
4. Planifica una ruta
5. Verifica que el mapa se renderice correctamente

---

## 8. Solución de problemas de instalación

### 8.1 Docker

| Problema | Causa | Solución |
|----------|-------|----------|
| `port is already allocated` (5450, 5124, 3007) | Otro proceso usa el puerto | `docker compose down` y verificar con `lsof -i :5450` |
| `permission denied` al montar volúmenes | Permisos de Docker | Agregar usuario al grupo docker: `sudo usermod -aG docker $USER` y cerrar sesión |
| `liquibase` falla con "already exists" | Cambios manuales previos en BD | `docker compose down -v` y `docker compose up -d` (borra todo) |
| Backend no arranca: `connection refused` | PostgreSQL aún arrancando | Esperar; el `depends_on` con healthcheck debería manejarlo |
| `ECONNREFUSED postgres:5432` | Backend sin red con postgres | `docker compose up -d --force-recreate` |

### 8.2 Backend

| Problema | Causa | Solución |
|----------|-------|----------|
| `dotnet: command not found` | .NET SDK no instalado | Instalar desde [dotnet.microsoft.com](https://dotnet.microsoft.com/download) |
| `Unable to connect to PostgreSQL` | Cadena de conexión incorrecta | Verificar `.env` → `ConnectionStrings__DefaultConnection` |
| `JWT secret key not configured` | Falta `Jwt__SecretKey` | Generar con `openssl rand -base64 64` y poner en `.env` |
| `Google Maps API error` | API key inválida o APIs no habilitadas | Verificar Google Cloud Console |
| Puerto 5124 ocupado | Otro proceso | Cambiar `ASPNETCORE_URLS` o terminar el proceso |

### 8.3 Frontend

| Problema | Causa | Solución |
|----------|-------|----------|
| `npm: command not found` | Node.js no instalado | Instalar Node.js 22.x desde [nodejs.org](https://nodejs.org) |
| Mapa en blanco | API key de Google Maps inválida | Verificar `VITE_GOOGLE_MAPS_API_KEY` en `.env` |
| `Failed to fetch` en login | Backend caído o CORS | Verificar backend; revisar consola del navegador |
| Página en blanco con error JS | Error de importación | Revisar consola del navegador; verificar que `.env` existe |

### 8.4 Móvil

| Problema | Causa | Solución |
|----------|-------|----------|
| `Network request failed` | Backend inaccesible desde el teléfono | `adb reverse tcp:5124 tcp:5124` o usar IP local |
| Expo Go no carga el bundle | Metro bundler no corriendo | Verificar `npx expo start` esté activo |
| `EXPO_PUBLIC_API_URL` no toma efecto | Variable no reconstruida | Reiniciar `npx expo start --clear` |
| Mapa no renderiza | API key inválida | Verificar `EXPO_PUBLIC_GOOGLE_MAPS_KEY` |

### 8.5 Base de datos

| Problema | Causa | Solución |
|----------|-------|----------|
| `database does not exist` | Liquibase no creó la BD | `docker compose up liquibase` |
| `extension postgis does not exist` | PostGIS no habilitado | Verificar imagen `postgis/postgis:16-3.5` |
| `relation does not exist` | Migraciones no aplicadas | Revisar logs de liquibase: `docker compose logs liquibase` |
| Error de ENUM type | Tipo no creado | Verificar que el cambioset correspondiente se aplicó |

---

## 9. Actualizaciones y migraciones

### 9.1 Actualizar código

```bash
# Backend
cd ~/Escritorio/EcoRuteandoBackend
git pull origin develop
dotnet build

# Frontend
cd ~/Escritorio/EcoRuteando/front-end/ecoRuteando-react
git pull origin develop
npm install

# Base de datos
cd ~/Escritorio/EcoRuteandoDb
git pull origin develop
docker compose -f ~/Escritorio/EcoRuteando/docker-compose.yml up liquibase

# Móvil
cd ~/Escritorio/Movil-EcoRuteando
git pull origin develop
npm install
```

### 9.2 Aplicar nuevas migraciones de BD

```bash
# Liquibase aplica solo los cambiosets nuevos (idempotente)
cd ~/Escritorio/EcoRuteando
docker compose up liquibase

# Verificar
docker compose exec postgres psql -U postgres -d ecoRuteando_db \
  -c "SELECT id, author, filename FROM databasechangelog ORDER BY orderexecuted DESC LIMIT 5;"
```

### 9.3 Reiniciar servicios tras cambios

```bash
# Solo backend
docker compose build --no-cache backend && docker compose up -d backend

# Solo frontend
docker compose build --no-cache frontend && docker compose up -d frontend

# Todo
docker compose build --no-cache && docker compose up -d
```

### 9.4 Reset completo (desarrollo)

```bash
# ⚠️ Esto BORRA todos los datos de la base de datos
cd ~/Escritorio/EcoRuteando
docker compose down -v
docker compose build --no-cache
docker compose up -d
```

---

## Resumen de URLs y puertos

| Servicio | URL | Puerto |
|----------|-----|--------|
| Frontend Web | http://localhost:3007 | 3007 |
| Backend API | http://localhost:5124 | 5124 |
| Swagger UI | http://localhost:5124/swagger | 5124 |
| PostgreSQL | localhost:5450 | 5450 |
| Metro Bundler (móvil) | exp://localhost:8081 | 8081 |

## Resumen de credenciales seed

| Usuario | Contraseña | Rol |
|---------|-----------|-----|
| admin@ecoruteando.com | EcoAdmin!2026 | Admin |

---

*Fin del Manual de Instalación de EcoRuteando — v1.0 — 13 de octubre de 2026*
