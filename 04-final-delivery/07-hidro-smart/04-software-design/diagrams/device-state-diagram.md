# Transición de estados

El [Draw.io editable](device-state-diagram.drawio) tiene dos
páginas: conectividad/provisioning y medición/vigilancia.

## Conectividad del dispositivo

```mermaid
stateDiagram-v2
  [*] --> PENDING
  PENDING --> BLE_READY: iniciar aprovisionamiento
  BLE_READY --> WIFI_CONNECTED: guardar credenciales
  WIFI_CONNECTED --> MQTT_CONNECTED: broker disponible y TLS válido
  MQTT_CONNECTED --> ONLINE: asociación confirmada
  ONLINE --> OFFLINE: se pierde conectividad
  OFFLINE --> MQTT_CONNECTED: reconectar
  WIFI_CONNECTED --> BLE_READY: error de red/provisioning
  ONLINE --> BLE_READY: unlink y reactivar BLE
```

## Medición y vigilancia

```mermaid
stateDiagram-v2
  [*] --> COUNTING
  COUNTING --> LEAK_WATCH: measurementEnabled=false
  LEAK_WATCH --> COUNTING: measurementEnabled=true
  LEAK_WATCH --> ALERT: regla de fuga satisfecha
  ALERT --> LEAK_WATCH: evento atendido / siguiente evaluación
  COUNTING --> ALERT: regla satisfecha
  ALERT --> COUNTING: evento atendido
```

El estado LEAK_WATCH mantiene el sensor, ESP32, Wi-Fi y MQTT activos; la suma de
litros se pausa mientras el caudal y los pulsos siguen disponibles para evaluar
fugas. Los nombres de provisioning son aproximados al contrato del monorepo y
deben verificarse contra la versión del firmware que se programe. El flujo de
unlink no implica que el dispositivo borre sus credenciales Wi-Fi.
