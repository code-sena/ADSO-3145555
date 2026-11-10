# Diagrama de despliegue

El Draw.io editable es [deployment-diagram.drawio](deployment-diagram.drawio).
El esquema separa servicios externos descritos por la configuración de la pila
de desarrollo local.

```mermaid
flowchart LR
  user[Usuario] --> browser[Navegador]
  browser -->|HTTPS| pages[Cloudflare Pages]
  pages -->|REST + cookies/CSRF| render[Render API]
  render -->|TLS| neon[(Neon PostgreSQL)]
  render -->|HTTPS| brevo[Brevo]
  esp[ESP32] -->|Wi-Fi / MQTT TLS 8883| flespi[Flespi]
  flespi <-->|MQTT| render
  subgraph Local[Docker local]
    nginx[Nginx / frontend :5173] --> api[Backend :3000]
    api --> pg[(PostgreSQL :5433)]
    api <-->|MQTT :1883| mosq[Mosquitto]
  end
  gh[GitHub Actions: validación] -. resultado CI .-> repo[Repositorio]
```

## Nube documentada

- Frontend: Cloudflare Pages en https://pt-hs.pages.dev.
- Backend: Render en https://pt-hs.onrender.com.
- PostgreSQL administrado: Neon con SSL.
- MQTT: Flespi en mqtt.flespi.io:8883 con TLS y ACL declaradas para los topics necesarios.
- Correo transaccional: API HTTPS de Brevo.
- ESP32: Wi-Fi para MQTT; BLE para el aprovisionamiento local.

## Desarrollo local

Compose contiene frontend/Nginx en 5173, backend en 3000, PostgreSQL en 5433,
Mosquitto en 1883 y Liquibase tooling. Los puertos publicados en loopback son
útiles para servicios del equipo local, pero la placa física no puede resolver
el DNS interno de Docker. Debe apuntar a un host/puerto alcanzable desde su LAN
cuando se usa un broker local.

## CI y límites de despliegue

El workflow de GitHub Actions valida el repositorio según su configuración; no
se debe asumir que un check de CI despliega la aplicación. La publicación en
Pages/Render depende de la integración y configuración del proveedor. La
documentación no confirma la rama, el directorio raíz ni los secretos que están
configurados actualmente en Cloudflare o Render.

Las direcciones muestran configuración documentada, no monitoreo de
disponibilidad. Verifica los paneles de los proveedores antes de afirmar que la
release está activa.
