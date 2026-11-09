# SmartHome — Protocolo de aceptación Android / Shelly

SENA · ADSO 3145555 · Fecha de revisión: 7 de noviembre de 2026  
Estado: preparación documental y revisión CI. No se ha ejecutado prueba física con teléfono o Shelly en esta auditoría.

## 1. Versión exacta de la prueba

**Tabla 1**

*Versión exacta de la prueba*

| Campo | Valor comprobado |
|---|---|
| Repositorio | `Kevin-Stiven-Lopez-Amaya404/from_movil` |
| Rama de APK | `qa` |
| SHA de APK | `6c3946e970711d1352bf2c8c2a54b0816f3afbe7` |
| `main` observado | `d830ed08886618491ebba2429fd4ffd615ba75ea` |
| SDK / RN | Expo `~58.0.23` y React Native `0.88.1` declarados en `main/package.json` |
| Versión app | `1.1.0` en `main/app.json` |
| Workflow APK | [Android POC APK — run 42404346123](https://github.com/Kevin-Stiven-Lopez-Amaya404/from_movil/actions/runs/42404346123) — SUCCESS |
| Artefacto | `smarthome-poc-android-apk`, ID `13587033044`, caducidad reportada 14 de noviembre de 2026 |
| ZIP bajado | `SmartHome_Android_SDK58_QA_6c3946e_APK_Debug.zip` (paquete local comprobado) |
| SHA-256 ZIP | `415f347261639aec9ae27f5d87cd852bb7f2732fd7d43d743ff64021b9b4f8f9` |
| SHA-256 APK interna | `fec413b7a98a79338585e2d259ad729429be80993b6deb3d9846835edc8466f8` |
| Tipo de APK | Desarrollo/DEBUG, no APK Preview ni producción |

Fuente: elaboración propia.

Observación crítica: la APK se compiló sobre `qa` `6c3946e`, no sobre el commit de fusión `main` `d830ed0`. No presentarla como prueba del binario final de `main`. El APK DEBUG requiere Metro y ejecuta `__DEV__=true`. El bloqueo de pairing en release (`__DEV__=false`) exige una APK Preview aparte.

Como marco de referencia, el protocolo define casos con precondiciones, pasos y resultado esperado según ISO/IEC/IEEE 29119-1 (ISO/IEC/IEEE, 2022), y las operaciones sobre el equipo siguen la documentación oficial de la API de Shelly (Shelly Group, s. f.).

## 2. Estado real de CI, seguridad y release

- [Mobile CI de `main`](https://github.com/Kevin-Stiven-Lopez-Amaya404/from_movil/actions/runs/42406563397): SUCCESS en `d830ed0`.
- [APK Android POC de `qa`](https://github.com/Kevin-Stiven-Lopez-Amaya404/from_movil/actions/runs/42404346123): SUCCESS en `6c3946e` (compilación nativa; no prueba física).
- [Dependency Security Audit en candidato `dev`](https://github.com/Kevin-Stiven-Lopez-Amaya404/from_movil/actions/runs/42403912607): SUCCESS. La auditoría anterior de la migración SDK58 reportó 0 críticas, 0 altas, 5 moderadas y 0 bajas; no se ha comprobado una auditoría nueva ejecutada directamente sobre el merge `main`.
- [Production Release Readiness de `qa`](https://github.com/Kevin-Stiven-Lopez-Amaya404/from_movil/actions/runs/42404346141): FAIL esperado. Exige cerrar/aceptar formalmente [#42](https://github.com/Kevin-Stiven-Lopez-Amaya404/from_movil/issues/42), [#52](https://github.com/Kevin-Stiven-Lopez-Amaya404/from_movil/issues/52) y [#53](https://github.com/Kevin-Stiven-Lopez-Amaya404/from_movil/issues/53), los tres abiertos en la revisión.
- Los PR móviles #61 (migración SDK58) y #49 (promoción QA→main) ya se fusionaron. Esta promoción no equivale a un release de producción autorizado.
- El README móvil aún menciona Expo 57; el `package.json` de `main` indica Expo 58. Es necesario corregir esa discrepancia en la documentación operativa.

## 3. Preparación segura en Windows PowerShell

1. Descargar ZIP del APK de este informe y verificar su SHA-256; extraer `app-debug.apk`.
2. Disponer de Android SDK Platform Tools (`adb`) y autorizar depuración USB en un teléfono propio o autorizado.
3. Clonar el repositorio en una carpeta de pruebas y usar el commit exacto del APK:

```powershell
git clone https://github.com/Kevin-Stiven-Lopez-Amaya404/from_movil.git
cd from_movil
git fetch origin qa
git checkout 6c3946e970711d1352bf2c8c2a54b0816f3afbe7
npm ci
Copy-Item .env.example .env.local
# Configurar EXPO_PUBLIC_API_URL con backend accesible desde el móvil.
# NO pegar contraseñas ni tokens en el repo ni en evidencias.
```

4. En otra terminal PowerShell, desde la carpeta donde extrajiste la APK:

```powershell
Get-FileHash .\app-debug.apk -Algorithm SHA256
adb devices
adb install -r .\app-debug.apk
```

5. Para conectar el development build con Metro, desde el proyecto:

```powershell
adb reverse tcp:8081 tcp:8081
npx expo start --dev-client --localhost
```

Alternativamente, si PC y Android están en la misma Wi-Fi, usar `npx expo start --dev-client --lan` y conectar desde la app. `localhost` en el teléfono NO es la IP del backend que corre en el PC. Ajustar `EXPO_PUBLIC_API_URL` de prueba sin incluir credenciales ni exponer el backend a internet.

No realizar un `git switch dev` ni actualizar dependencias después de instalar esta APK: el JS de Metro tiene que corresponder al commit de la compilación. No usar Expo Go para validar GATT/BLE nativo. No publicar EAS Update o crear un build production durante esta prueba.

## 4. Matriz de pruebas y resultados por registrar

Estados válidos: `PASS`, `FAIL`, `BLOQUEADO`, `NO APLICA`, `PENDIENTE`. Ninguna fila se marca como PASS sin evidencia de ejecución.

**Tabla 2**

*Matriz de pruebas y resultados por registrar*

| ID | Caso | Resultado esperado | Estado inicial |
|---|---|---|---|
| QA-01 | Procedencia de APK | ZIP íntegro; APK presente; SHA coincide. | PENDIENTE |
| QA-02 | Instalación y arranque | Abre sin cierre inesperado y carga JS de desarrollo. | PENDIENTE |
| QA-03 | Autenticación | Sesión autorizada y mensaje claro ante credenciales erróneas. | PENDIENTE |
| QA-04 | Sesión y recuperación | No accede sin autenticación; enlaces/respuestas correctos. | PENDIENTE |
| QA-05 | Navegación | No se pierden rutas ni quedan pantallas bloqueadas. | PENDIENTE |
| QA-06 | Hogares y permisos | La UI y el backend respetan OWNER/MEMBER/GUEST según caso. | PENDIENTE |
| QA-07 | Dispositivos | Datos coherentes; estados vacíos/errores explicativos. | PENDIENTE |
| QA-08 | Energía | Cálculos/representación coinciden con API de la versión evaluada. | PENDIENTE |
| QA-09 | Avisos y tiempo real | No duplicados, no congelamiento, estado visible al restablecer red. | PENDIENTE |
| QA-10 | Permisos Android | Solicitud o rechazo se gestionan sin crash. | PENDIENTE |
| QA-11 | Descubrimiento BLE | Candidatos detectados o error documentado; no afirmar pairing. | PENDIENTE |
| QA-12 | Lectura GATT | Modelo/firmware/estado visibles; operación solo lectura y desconexión limpia. | PENDIENTE |
| QA-13 | Descubrimiento LAN/IP | Resultado o limitación reproducible; no exponer IP ni credenciales. | PENDIENTE |
| QA-14 | MQTT y control físico | Separar HTTP, MQTT y observación/telemetría física; sin intervenir cableado. | PENDIENTE |
| QA-15 | Bloqueo release pairing | Aviso explícito; no iniciar pairing backend incompletable. | PENDIENTE |
| QA-16 | Seguridad dependencias | Sin críticos/altos para lockfile final o excepciones validadas; trazabilidad moderadas. | PENDIENTE |
| QA-17 | Runtime OTA | Aislamiento de runtime documentado. | PENDIENTE |
| QA-18 | Cierre QA | Decisión firmada de aceptación o lista de bloqueos; sin cierres ficticios. | PENDIENTE |

Fuente: elaboración propia.

## 5. Procedimiento y advertencias por caso

### QA-01 — Procedencia de APK

Ejecutar: Descargar el artefacto de run 42404346123 y comparar ZIP SHA-256 con el registro; verificar SHA de QA 6c3946e.

Criterio: ZIP íntegro; APK presente; SHA coincide.

Situación al 7-11-2026: Automático local: integridad del ZIP; instalación pendiente.

### QA-02 — Instalación y arranque

Ejecutar: Extraer app-debug.apk, comprobar adb devices, instalar en teléfono autorizado y conectar al Metro del mismo SHA.

Criterio: Abre sin cierre inesperado y carga JS de desarrollo.

Situación al 7-11-2026: Pendiente dispositivo físico.

### QA-03 — Autenticación

Ejecutar: Abrir login, usar cuenta de pruebas, validar acceso y errores sin publicar credenciales.

Criterio: Sesión autorizada y mensaje claro ante credenciales erróneas.

Situación al 7-11-2026: Pendiente.

### QA-04 — Sesión y recuperación

Ejecutar: Cerrar sesión, reingresar; comprobar rutas de activación/recuperación con cuenta de prueba.

Criterio: No accede sin autenticación; enlaces/respuestas correctos.

Situación al 7-11-2026: Pendiente.

### QA-05 — Navegación

Ejecutar: Recorrer pestañas principales, atrás, enlaces profundos y cambios de orientación si aplica.

Criterio: No se pierden rutas ni quedan pantallas bloqueadas.

Situación al 7-11-2026: Pendiente.

### QA-06 — Hogares y permisos

Ejecutar: Abrir hogar propio y otra situación de rol limitado con cuentas de prueba.

Criterio: La UI y el backend respetan OWNER/MEMBER/GUEST según caso.

Situación al 7-11-2026: Pendiente.

### QA-07 — Dispositivos

Ejecutar: Ver lista, detalle y estados de dispositivos registrados.

Criterio: Datos coherentes; estados vacíos/errores explicativos.

Situación al 7-11-2026: Pendiente.

### QA-08 — Energía

Ejecutar: Consultar consumo y objetivos/tarifas cuando estén configurados.

Criterio: Cálculos/representación coinciden con API de la versión evaluada.

Situación al 7-11-2026: Pendiente.

### QA-09 — Avisos y tiempo real

Ejecutar: Probar notificaciones, reconexión al cambiar red y pérdida temporal de conectividad.

Criterio: No duplicados, no congelamiento, estado visible al restablecer red.

Situación al 7-11-2026: Pendiente.

### QA-10 — Permisos Android

Ejecutar: Comprobar Bluetooth y permisos solicitados al iniciar escaneo Shelly.

Criterio: Solicitud o rechazo se gestionan sin crash.

Situación al 7-11-2026: Pendiente.

### QA-11 — Descubrimiento BLE

Ejecutar: Con Shelly autorizado cerca, buscar anuncios por hasta 12 s sin reiniciar/restablecer el equipo.

Criterio: Candidatos detectados o error documentado; no afirmar pairing.

Situación al 7-11-2026: Pendiente.

### QA-12 — Lectura GATT

Ejecutar: Si lo permite el firmware, pulsar Leer info para Shelly.GetDeviceInfo; cancelar bonding no planificado.

Criterio: Modelo/firmware/estado visibles; operación solo lectura y desconexión limpia.

Situación al 7-11-2026: Pendiente.

### QA-13 — Descubrimiento LAN/IP

Ejecutar: Con teléfono y Shelly en red de prueba autorizada, probar búsqueda IP/LAN documentada.

Criterio: Resultado o limitación reproducible; no exponer IP ni credenciales.

Situación al 7-11-2026: Pendiente.

### QA-14 — MQTT y control físico

Ejecutar: Solo con dispositivo previamente vinculado, autorizado y con seguridad eléctrica garantizada, emitir comando.

Criterio: Separar HTTP, MQTT y observación/telemetría física; sin intervenir cableado.

Situación al 7-11-2026: Pendiente.

### QA-15 — Bloqueo release pairing

Ejecutar: En APK Preview AUTÓNOMA (no debug), verificar limitación de pairing y ausencia de solicitud MQTT indebida.

Criterio: Aviso explícito; no iniciar pairing backend incompletable.

Situación al 7-11-2026: Requiere build preview independiente; no prueba con debug.

### QA-16 — Seguridad dependencias

Ejecutar: Ejecutar npm audit --omit=dev --audit-level=high en SHA exacto y registrar JSON, analizar 5 moderadas.

Criterio: Sin críticos/altos para lockfile final o excepciones validadas; trazabilidad moderadas.

Situación al 7-11-2026: Auditoría candidata dev aprobó; falta criterio de release.

### QA-17 — Runtime OTA

Ejecutar: Comprobar que versión 1.0.0 no recibe OTA del runtime de 1.1.0; no publicar OTA real.

Criterio: Aislamiento de runtime documentado.

Situación al 7-11-2026: Pendiente sin publicación.

### QA-18 — Cierre QA

Ejecutar: Adjuntar prueba por caso, responsable, fecha y versión; revisar issues #42, #52 y #53.

Criterio: Decisión firmada de aceptación o lista de bloqueos; sin cierres ficticios.

Situación al 7-11-2026: Pendiente.

## 6. Criterios de seguridad y aceptación

- BLE/GATT `Shelly.GetDeviceInfo` es una consulta experimental de solo lectura: no significa emparejamiento completo.
- La versión release mantiene deshabilitadas acciones de vinculación que no pueden completarse de forma segura. No retirar `!__DEV__` ni habilitar HTTP en producción como atajo.
- Para MQTT, `COMMAND_PUBLISHED` no es prueba de estado físico del relé. Separar comando, respuesta del broker, telemetría y observación del dispositivo.
- No abrir equipos, tocar cableado de red eléctrica, resetear de fábrica o aceptar bonding inesperado. Intervenir hardware conectado a tensión requiere personal competente y condiciones seguras.
- Evitar compartir IP, MAC/BLE, usuario, correo real, tokens, claves MQTT, QR o capturas de sesiones con datos personales.
- Registrar con responsables todos los casos FAIL/BLOQUEADO. La puerta de release sigue cerrada hasta cumplir los criterios del equipo y los issues vinculados.

## 7. Ficha de evidencia por caso

**Tabla 3**

*Ficha de evidencia por caso*

| Campo | Registrar |
|---|---|
| Fecha y hora / responsable | Por completar |
| ID de caso y estado | Por completar |
| Android (modelo, versión, API) | Por completar |
| Shelly (modelo y versión de firmware, sin identificadores sensibles) | Por completar |
| APK / SHA / canal | QA `6c3946e`; comprobar en teléfono |
| Backend (entorno y commit) | Por completar |
| Resultado observado | Por completar |
| Captura o log depurado | Por completar |
| Incidencia/decisión de cierre | Por completar |

Fuente: elaboración propia.

Dictamen: PENDIENTE DE ACEPTACIÓN FÍSICA. Esta guía no constituye una prueba realizada.

## Referencias

ISO/IEC/IEEE. (2022). *Software and systems engineering — Software testing — Part 1: General concepts* (ISO/IEC/IEEE 29119-1:2022). https://www.iso.org/standard/81291.html

Shelly Group. (s. f.). *Shelly API documentation*. Recuperado el 8 de noviembre de 2026, de https://shelly-api-docs.shelly.cloud/
