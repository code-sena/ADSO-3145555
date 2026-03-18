# 🦁 Zoológico DB — Liquibase Migration Project

Sistema de versionado de base de datos para el Zoológico usando **Liquibase 4.27** y **PostgreSQL 16**.

---

## 📂 Estructura del Proyecto

```
zoo_liquibase_pro/
│
├── db.changelog-master.xml          # ← Punto de entrada principal
│
├── changelogs/
│   ├── ddl/                         # Creación de tablas (estructura)
│   │   ├── 001-create-cuidadores.xml
│   │   ├── 002-create-habitats.xml
│   │   ├── 003-create-especies.xml
│   │   ├── 004-create-animales.xml
│   │   ├── 005-create-historial-medico.xml
│   │   ├── 006-create-alimentacion.xml
│   │   └── 007-create-visitas.xml
│   │
│   ├── indexes/                     # Índices de rendimiento
│   │   └── 001-indexes.xml
│   │
│   └── dml/                         # Datos iniciales (seed)
│       ├── 001-seed-habitats.xml
│       ├── 002-seed-especies.xml
│       ├── 003-seed-cuidadores.xml
│       ├── 004-seed-animales.xml
│       ├── 005-seed-historial-medico.xml
│       └── 006-seed-alimentacion.xml
│
├── sql_scripts/                     # Consultas analíticas y de auditoría
│   ├── auditoria_liquibase.sql
│   ├── estadisticas_zoo.sql
│   └── reporte_maestro.sql
│
├── lib/
│   ├── liquibase.properties         # Configuración local (no subir a git)
│   └── postgresql-42.7.10.jar
│
├── docker-compose.yml
├── .env.example                     # Plantilla de variables de entorno
└── .gitignore
```

---

## 🚀 Inicio Rápido

### 1. Clonar y configurar variables

```bash
cp .env.example .env
# Editar .env con tus credenciales reales
```

### 2. Levantar con Docker Compose

```bash
docker compose up --build
```

Liquibase esperará automáticamente a que PostgreSQL esté sano (`healthcheck`) antes de ejecutar las migraciones.

### 3. Verificar migraciones aplicadas

```bash
docker compose run --rm liquibase \
  --changelog-file=db.changelog-master.xml \
  --url=jdbc:postgresql://db:5432/zoologico_db \
  --username=admin_zoo \
  --password=changeme_en_produccion \
  status
```

---

## 🔄 Comandos Útiles de Liquibase

| Acción | Comando |
|---|---|
| Aplicar migraciones | `update` |
| Ver estado pendiente | `status` |
| Revertir último changeset | `rollbackCount 1` |
| Revertir hasta una tag | `rollback <tag>` |
| Generar SQL sin ejecutar | `updateSQL` |
| Validar changelog | `validate` |

---

## 🗄️ Modelo de Datos

```
cuidadores ──────────────────────────────────┐
                                             │
habitats ─────────────────────────────────── animales ── historial_medico
                                             │         └─ alimentacion
especies ────────────────────────────────────┘

visitas  (tabla independiente — afluencia diaria)
```

### Tablas

| Tabla | Descripción |
|---|---|
| `cuidadores` | Personal del zoológico por especialidad |
| `habitats` | Recintos con tipo de clima y capacidad |
| `especies` | Catálogo taxonómico con estado UICN |
| `animales` | Registro individual de cada animal |
| `historial_medico` | Revisiones veterinarias por animal |
| `alimentacion` | Plan y seguimiento de dieta diaria |
| `visitas` | Afluencia de visitantes por fecha |

---

## ✅ Buenas Prácticas Aplicadas

- **IDs semánticos** en cada changeset (`ddl-001-create-cuidadores`)
- **`<rollback>`** explícito en todos los changesets
- **`<comment>`** descriptivo en cada changeset
- **Constraints CHECK** para valores de dominio (sexo, dieta, estado UICN, etc.)
- **Índices** separados del DDL para control granular
- **Datos seed separados del DDL** (carpetas `dml/` vs `ddl/`)
- **Versión fija** de imagen Docker (`postgres:16-alpine`, `liquibase:4.27`)
- **`healthcheck`** en Docker Compose para evitar race conditions
- **`.env.example`** para documentar variables sin exponer credenciales
- **`SERIAL`** en lugar de `int autoIncrement` para mejor compatibilidad PostgreSQL
- **`remarks`** en columnas como documentación embebida

---

## 📊 Scripts SQL incluidos

- `auditoria_liquibase.sql` — historial de migraciones, locks y fallos
- `estadisticas_zoo.sql` — ocupación de hábitats, carga por cuidador, revisiones vencidas
- `reporte_maestro.sql` — ficha técnica completa de cada animal
