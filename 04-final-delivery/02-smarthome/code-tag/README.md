# Code and tags / Código y tags: SmartHome

## Repositorios oficiales

Cada componente tiene **un** repositorio oficial. Los dos repositorios marcados como históricos son versiones anteriores que la plantilla del instructor menciona; se etiquetan y empaquetan igual, pero no contienen el producto final.

**Tabla 1**

*Repositorios de SmartHome y su papel en la entrega*

| Componente | Repositorio | Papel | Tag | ZIP de `main` en el tag | ZIP del repositorio completo |
|---|---|---|---|---|---|
| Backend | [nataliachala1/smarthome-backend](https://github.com/nataliachala1/smarthome-backend) | **Oficial** | `final-delivery-2026` | [smarthome-backend-final-delivery-2026-main.zip](https://github.com/Kevin-Stiven-Lopez-Amaya404/ADSO-3145555/releases/download/final-delivery/smarthome-backend-final-delivery-2026-main.zip) | [smarthome-backend-full-export.zip](https://github.com/Kevin-Stiven-Lopez-Amaya404/ADSO-3145555/releases/download/final-delivery/smarthome-backend-full-export.zip) |
| Frontend web | [nataliachala1/smarthome-frontend-web](https://github.com/nataliachala1/smarthome-frontend-web) | **Oficial** | `final-delivery-2026` | [smarthome-frontend-web-final-delivery-2026-main.zip](https://github.com/Kevin-Stiven-Lopez-Amaya404/ADSO-3145555/releases/download/final-delivery/smarthome-frontend-web-final-delivery-2026-main.zip) | [smarthome-frontend-web-full-export.zip](https://github.com/Kevin-Stiven-Lopez-Amaya404/ADSO-3145555/releases/download/final-delivery/smarthome-frontend-web-full-export.zip) |
| Móvil | [Kevin-Stiven-Lopez-Amaya404/from_movil](https://github.com/Kevin-Stiven-Lopez-Amaya404/from_movil) | **Oficial** | `final-delivery-2026` | [from_movil-final-delivery-2026-main.zip](https://github.com/Kevin-Stiven-Lopez-Amaya404/ADSO-3145555/releases/download/final-delivery/from_movil-final-delivery-2026-main.zip) | [from_movil-full-export.zip](https://github.com/Kevin-Stiven-Lopez-Amaya404/ADSO-3145555/releases/download/final-delivery/from_movil-full-export.zip) |
| Base de datos | [nataliachala1/smarthome-database](https://github.com/nataliachala1/smarthome-database) | **Oficial** | `final-delivery-2026` | [smarthome-database-final-delivery-2026-main.zip](https://github.com/Kevin-Stiven-Lopez-Amaya404/ADSO-3145555/releases/download/final-delivery/smarthome-database-final-delivery-2026-main.zip) | [smarthome-database-full-export.zip](https://github.com/Kevin-Stiven-Lopez-Amaya404/ADSO-3145555/releases/download/final-delivery/smarthome-database-full-export.zip) |
| Documentación técnica | [Kevin-Stiven-Lopez-Amaya404/smart-home-doc](https://github.com/Kevin-Stiven-Lopez-Amaya404/smart-home-doc) | **Oficial** | `final-delivery-2026` | [smart-home-doc-final-delivery-2026-main.zip](https://github.com/Kevin-Stiven-Lopez-Amaya404/ADSO-3145555/releases/download/final-delivery/smart-home-doc-final-delivery-2026-main.zip) | [smart-home-doc-full-export.zip](https://github.com/Kevin-Stiven-Lopez-Amaya404/ADSO-3145555/releases/download/final-delivery/smart-home-doc-full-export.zip) |
| Base de datos (anterior) | [nataliachala1/smart-home-database](https://github.com/nataliachala1/smart-home-database) | Histórico | `final-delivery-2026` | [smart-home-database-final-delivery-2026-main.zip](https://github.com/Kevin-Stiven-Lopez-Amaya404/ADSO-3145555/releases/download/final-delivery/smart-home-database-final-delivery-2026-main.zip) | [smart-home-database-full-export.zip](https://github.com/Kevin-Stiven-Lopez-Amaya404/ADSO-3145555/releases/download/final-delivery/smart-home-database-full-export.zip) |
| Documentación (anterior) | [Kevin-Stiven-Lopez-Amaya404/smart-home-docs](https://github.com/Kevin-Stiven-Lopez-Amaya404/smart-home-docs) | Histórico (1 archivo; su README remite a `smart-home-doc`) | `final-delivery-2026` | [smart-home-docs-final-delivery-2026-main.zip](https://github.com/Kevin-Stiven-Lopez-Amaya404/ADSO-3145555/releases/download/final-delivery/smart-home-docs-final-delivery-2026-main.zip) | [smart-home-docs-full-export.zip](https://github.com/Kevin-Stiven-Lopez-Amaya404/ADSO-3145555/releases/download/final-delivery/smart-home-docs-full-export.zip) |

Fuente: elaboración propia.

La documentación oficial es **`smart-home-doc`** (152 archivos). La base de datos oficial es **`smarthome-database`** (sin guion entre *smart* y *home*): contiene las 100 migraciones Liquibase y las políticas RLS.

Los enlaces de los ZIP apuntan al Release [`final-delivery`](https://github.com/Kevin-Stiven-Lopez-Amaya404/ADSO-3145555/releases/tag/final-delivery) del fork de quien entrega. Los siete tags se crearon el 2026-11-08 sobre el `main` de cada repositorio, después de fusionar las correcciones y con el CI de `main` aprobado. El commit exacto de cada tag queda en [`SHA256SUMS.txt`](SHA256SUMS.txt) junto a la huella de cada ZIP.

## Por qué dos ZIP

| Archivo | Contenido | Para qué sirve |
|---|---|---|
| `<repo>-final-delivery-2026-main.zip` | Solo el código de `main` en el tag (`git archive`) | La versión exacta entregada; es la que se usa para el registro de software |
| `<repo>-full-export.zip` | Clon espejo: todas las ramas, tags e historial | Prueba del trabajo realizado y respaldo completo |

## Cómo se generan

Por cada repositorio, después de fusionar `dev → qa → main`:

```bash
git tag -a final-delivery-2026 -m "SmartHome final delivery 2026" origin/main
git push origin final-delivery-2026
git archive --format=zip --prefix=<repo>/ -o <repo>-final-delivery-2026-main.zip final-delivery-2026
git clone --mirror <url> <repo>.git && zip -qr <repo>-full-export.zip <repo>.git
sha256sum *.zip > SHA256SUMS.txt
```

## Integridad

Verifique cada ZIP descargado con `sha256sum -c SHA256SUMS.txt`.

## Acceso del instructor

La cuenta `ariel5253` necesita **Write** en los siete repositorios. Cada dueño la agrega en *Settings → Collaborators → Add people → Write*: Natalia en los cuatro de `nataliachala1` y Kevin en los tres de `Kevin-Stiven-Lopez-Amaya404`.

Antes de hacer público un repositorio, quite los archivos `.env` y cambie toda contraseña, token o llave que se haya subido alguna vez.
