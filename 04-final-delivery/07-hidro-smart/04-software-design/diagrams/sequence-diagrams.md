# Diagramas de secuencia

Tres flujos están disponibles en el [Draw.io editable](sequence-diagrams.drawio):
autenticación, vinculación/ingesta y vigilancia de fuga/desvinculación.

## Sesión y CSRF

```mermaid
sequenceDiagram
  actor U as Usuario
  participant C as Cliente
  participant A as API
  participant D as PostgreSQL
  U->>C: Iniciar sesión
  C->>A: Obtener CSRF y enviar credenciales
  A->>D: Verificar usuario y crear sesión
  D-->>A: Sesión
  A-->>C: Cookies de sesión HttpOnly y CSRF
  C->>A: Solicitud mutable con token CSRF
  A->>A: Validar CSRF, sesión y permiso
  A-->>C: Respuesta autorizada o error
```

## Vincular ESP32 e ingestar MQTT

```mermaid
sequenceDiagram
  actor U as Titular
  participant A as API
  participant D as PostgreSQL
  participant B as Flespi
  participant E as ESP32
  U->>A: Solicitar vínculo con deviceCode
  A->>D: Validar hogar y permiso
  A->>B: Publicar confirm_link
  B->>E: Entregar comando
  E->>B: Estado y telemetría
  B->>A: Mensajes MQTT
  A->>A: Validar topic, asociación e idempotencia
  A->>D: Guardar lectura y evaluar reglas
```

## Vigilancia y desvinculación

```mermaid
sequenceDiagram
  actor U as Titular
  participant A as API
  participant B as Flespi
  participant E as ESP32
  participant D as PostgreSQL
  U->>A: Activar vigilancia o desvincular
  A->>B: Publicar set_measurement=false o unlink
  B->>E: Entregar comando
  E->>B: Mantener estado/telemetría
  B->>A: Lectura de flujo y pulsos
  A->>D: Congelar volumen o persistir evento y alerta
  Note over E,B: Vigilancia no apaga ESP32, sensor, Wi-Fi ni MQTT
  Note over E: unlink reactiva BLE según el firmware integrado
```

Los mensajes dependen de conexión, ACL y firmware compatible. El intervalo
esperado de telemetría es de cinco segundos, no una garantía de entrega. Estos
diagramas describen contratos y no prueban una instalación física.
