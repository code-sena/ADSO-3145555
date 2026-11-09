# Texto del Release `final-delivery`

Copiar en la descripción del Release del fork `Kevin-Stiven-Lopez-Amaya404/ADSO-3145555`.

---

## SmartHome: entrega final (ADSO 3145555)

Plataforma para gestionar hogares, controlar relés Shelly 1PM Gen4 y conocer el consumo eléctrico y su costo, con panel web y aplicación Android.

### Código

Dos ZIP por repositorio, generados sobre el tag `final-delivery-2026`:

- `<repo>-final-delivery-2026-main.zip`: solo el código de `main` en el tag. Es la versión para el registro de software.
- `<repo>-full-export.zip`: clon espejo con todas las ramas, tags e historial.

| Repositorio | Papel |
|---|---|
| nataliachala1/smarthome-backend | Oficial |
| nataliachala1/smarthome-frontend-web | Oficial |
| Kevin-Stiven-Lopez-Amaya404/from_movil | Oficial |
| nataliachala1/smarthome-database | Oficial |
| Kevin-Stiven-Lopez-Amaya404/smart-home-doc | Oficial |
| nataliachala1/smart-home-database | Histórico |
| Kevin-Stiven-Lopez-Amaya404/smart-home-docs | Histórico |

El commit de cada tag y la huella SHA-256 de cada ZIP están en `SHA256SUMS.txt`. Para verificar: `sha256sum -c SHA256SUMS.txt`.

### Documentación

`SmartHome-entrega-final.zip` contiene la carpeta de entrega: secciones 01–10 en PDF con su DOCX editable, roles, registro de software y declaración de uso de IA. `SmartHome.zip` es la versión anterior de los documentos (2026-11-07) y se conserva como referencia.

### Probar el sistema

Los cuatro repositorios se clonan en la misma carpeta, en el tag `final-delivery-2026`:

```bash
for r in Kevin-Stiven-Lopez-Amaya404/smart-home-doc nataliachala1/smarthome-database nataliachala1/smarthome-backend nataliachala1/smarthome-frontend-web; do git clone --branch final-delivery-2026 "https://github.com/$r.git"; done
cd smart-home-doc/deploy && cp .env.example .env
docker compose up -d --build --wait
```

Web en `http://localhost:8080`. Usuarios de demostración: `owner@example.com` (también `admin@`, `member@` y `guest@`), contraseña `SmartHome#2026`.
