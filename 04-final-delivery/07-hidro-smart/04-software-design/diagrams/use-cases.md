# Casos de uso

Actores funcionales y casos que aparecen en la copia integrada. El Draw.io
editable está en [use-cases.drawio](use-cases.drawio).

```mermaid
flowchart LR
  owner[Titular / Owner] --> homes[Gestionar hogares y miembros]
  owner --> devices[Vincular, configurar y desvincular ESP32]
  owner --> usage[Consultar consumo e historial]
  owner --> rules[Configurar reglas y atender alertas]
  owner --> reports[Consultar y descargar reportes]
  owner --> goals[Gestionar metas]
  owner --> support[Solicitar soporte]
  guest[Invitado / Guest] --> read[Consultar funciones permitidas]
  admin[Administrador] --> adminops[Administrar funciones globales autorizadas]
  esp[ESP32] --> telemetry[Publicar telemetría y estado]
  api[Backend] --> access[Validar sesión y autorización]
```

- **Titular / Owner:** administra hogares, membresías y funciones concedidas.
- **Invitado / Guest:** solo ejecuta acciones permitidas por su membresía.
- **Administrador:** opera las funciones globales permitidas al rol en el backend.
- **ESP32:** actor técnico de provisioning y telemetría.

El dibujo no especifica todos los endpoints ni concede permisos por sí mismo. El
backend y la base de datos verifican acceso. Las pantallas visibles pueden variar
según el rol y el cliente; soporte se encuentra dentro de Configuración en el
flujo móvil documentado.
