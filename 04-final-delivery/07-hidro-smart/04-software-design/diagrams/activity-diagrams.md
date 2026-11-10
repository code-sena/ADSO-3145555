# Diagramas de actividades

El Draw.io contiene flujos de autenticación y procesamiento de MQTT:
[activity-diagrams.drawio](activity-diagrams.drawio).

## Autenticación y solicitud mutable

```mermaid
flowchart TD
  start([Inicio]) --> getcsrf[Cliente obtiene token CSRF]
  getcsrf --> login[Enviar credenciales]
  login --> valid{Credenciales válidas}
  valid -- No --> error[Respuesta de error]
  valid -- Sí --> session[Crear o rotar sesión]
  session --> cookie[Cookies y token CSRF]
  cookie --> mutate[Enviar operación mutable]
  mutate --> check{CSRF, sesión y permiso válidos}
  check -- No --> deny[Rechazar]
  check -- Sí --> action[Ejecutar operación]
```

## Ingesta y alerta

```mermaid
flowchart TD
  message[Mensaje MQTT] --> schema{Topic y payload válidos}
  schema -- No --> reject[Rechazar y registrar]
  schema -- Sí --> device[Resolver dispositivo y hogar]
  device --> linked{Asociación activa}
  linked -- No --> reject
  linked -- Sí --> duplicate{mqttMessageId ya procesado}
  duplicate -- Sí --> ignore[Ignorar duplicado]
  duplicate -- No --> persist[Persistir lectura]
  persist --> evaluate[Evaluar regla activa]
  evaluate --> alert{Condición de alerta satisfecha}
  alert -- Sí --> create[Crear evento de alerta]
  alert -- No --> done([Fin])
  create --> done
```

El flujo depende de una regla activa y de migraciones compatibles; revisar el
código y la BD de la rama desplegada antes de asumir que una alerta se generó.
