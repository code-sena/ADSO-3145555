# 📋 Estructura del Proyecto: PRJ-EDU-HORARIOS

## 🎯 Descripción General
Sistema de gestión de horarios educativos con módulos para seguridad, programación de clases, inventario, reportes y observaciones.

---

## 📁 Estructura Raíz del Proyecto

```
PRJ-EDU-HORARIOS/
│
├── 📂 docs/                  ← Documentación del proyecto
├── 📂 src/                   ← Código fuente de la aplicación
├── 📂 tests/                 ← Pruebas automatizadas
├── 📂 docker/                ← Configuración de Docker
├── 📂 scripts/               ← Scripts de utilidad
│
├── .env                      ← Variables de entorno
├── .gitignore               ← Archivos ignorados por Git
├── README.md                ← Documentación principal
├── pom.xml                  ← Dependencias Maven
└── package.json             ← Dependencias Node.js
```

---

## 📚 DOCUMENTACIÓN (carpeta `docs/`)

### Estructura de Documentos
```
docs/
│
├── 📂 c4/                   ← Diagramas de arquitectura C4
├── 📂 requirements/         ← Requisitos del sistema
├── 📂 kpi/                  ← Indicadores clave de desempeño
└── 📂 open-questions/       ← Preguntas abiertas del proyecto
```

### Modelos C4 (carpeta `c4/`)
```
c4/
│
├── 📂 c1-context/           ← Diagrama de contexto del sistema
├── 📂 c2-containers/        ← Diagrama de contenedores
├── 📂 c3-components/        ← Diagrama de componentes
└── 📂 adr/                  ← Architecture Decision Records
```

#### C1 - Contexto del Sistema
```
c1-context/
├── c1-system-context.drawio    ← Archivo editable (Draw.io)
├── c1-system-context.png       ← Imagen para visualización
├── c1-system-context.puml      ← Diagrama PlantUML
└── README.md                   ← Documentación
```

#### C2 - Contenedores de la Aplicación
```
c2-containers/
├── c2-container-diagram.drawio
├── c2-container-diagram.png
├── c2-container-diagram.puml
└── README.md
```

#### C3 - Componentes por Módulo
```
c3-components/
├── c3-security-module.drawio        ← Módulo de Seguridad
├── c3-schedules-module.drawio       ← Módulo de Horarios
├── c3-inventory-module.drawio       ← Módulo de Inventario
├── c3-reports-module.drawio         ← Módulo de Reportes
├── c3-observations-module.drawio    ← Módulo de Observaciones
└── README.md
```

---

## 💻 CÓDIGO FUENTE (carpeta `src/`)

### Estructura Principal
```
src/
│
├── 📂 modules/           ← Módulos funcionales del sistema
├── 📂 shared/            ← Código compartido entre módulos
└── 📂 main/              ← Punto de entrada de la aplicación
    └── Application.java
```

---

## 🔐 MÓDULO: SECURITY (Seguridad)

**Responsabilidad:** Gestionar autenticación, autorización y control de acceso.

```
security/
│
├── 📂 controller/        ← Endpoints REST de seguridad
├── 📂 service/           ← Lógica de negocio
├── 📂 repository/        ← Acceso a datos
├── 📂 entity/            ← Modelos de base de datos
├── 📂 dto/               ← Objetos de transferencia de datos
├── 📂 mapper/            ← Conversión entre entidades y DTOs
├── 📂 config/            ← Configuración de seguridad
├── 📂 middleware/        ← Filtros e interceptores
├── 📂 utils/             ← Utilidades (JWT, encriptación)
└── 📂 tests/             ← Pruebas del módulo
```

### Controllers
```
controller/
├── AuthController.java          ← Autenticación (login, logout)
├── UserController.java          ← Gestión de usuarios
└── RoleController.java          ← Gestión de roles y permisos
```

### Services
```
service/
├── AuthService.java             ← Lógica de autenticación
├── UserService.java             ← Lógica de gestión de usuarios
└── RoleService.java             ← Lógica de roles y permisos
```

### Repositories
```
repository/
├── UserRepository.java          ← Consultas a tabla User
└── RoleRepository.java          ← Consultas a tabla Role
```

### Entidades
```
entity/
├── User.java                    ← Usuario del sistema
├── Role.java                    ← Rol de usuario
└── Permission.java              ← Permisos específicos
```

### DTOs (Data Transfer Objects)
```
dto/
├── LoginDTO.java                ← Datos para login
├── UserDTO.java                 ← Datos de usuario para respuesta
└── TokenDTO.java                ← Token JWT
```

### Utilidades
```
utils/
└── 📂 jwt/
    ├── JwtProvider.java         ← Generación de JWT
    └── JwtUtils.java            ← Funciones auxiliares
```

---

## 📅 MÓDULO: SCHEDULES (Horarios)

**Responsabilidad:** Gestionar horarios, disponibilidad y asignaciones de docentes.

```
schedules/
│
├── 📂 controller/       ← Endpoints REST de horarios
├── 📂 service/          ← Lógica de negocio
├── 📂 repository/       ← Acceso a datos
├── 📂 entity/           ← Modelos de base de datos
├── 📂 dto/              ← Objetos de transferencia
├── 📂 validators/       ← Validaciones personalizadas
├── 📂 rules/            ← Reglas de negocio complejas
├── 📂 mapper/           ← Conversión de datos
└── 📂 tests/            ← Pruebas del módulo
```

### Controllers
```
controller/
├── ScheduleController.java      ← Gestión de horarios
├── AvailabilityController.java  ← Disponibilidad de docentes
└── CalendarController.java      ← Calendarios académicos
```

### Services
```
service/
├── ScheduleService.java         ← Lógica de horarios
├── AvailabilityService.java     ← Lógica de disponibilidad
├── ValidationService.java       ← Validaciones de conflictos
└── AssignmentService.java       ← Asignación de clases
```

### Repositories
```
repository/
├── ScheduleRepository.java      ← Consultas de horarios
├── TimeSlotRepository.java      ← Consultas de franjas horarias
└── AvailabilityRepository.java  ← Consultas de disponibilidad
```

### Entidades
```
entity/
├── Schedule.java                ← Horario de clases
├── TimeSlot.java                ← Franja horaria
├── AcademicGroup.java           ← Grupo académico
└── Assignment.java              ← Asignación de docente-clase
```

---

## 📦 MÓDULO: INVENTORY (Inventario)

**Responsabilidad:** Gestionar espacios, edificios y recursos disponibles.

```
inventory/
│
├── 📂 controller/       ← Endpoints REST de inventario
├── 📂 service/          ← Lógica de negocio
├── 📂 repository/       ← Acceso a datos
├── 📂 entity/           ← Modelos de base de datos
├── 📂 dto/              ← Objetos de transferencia
├── 📂 utils/            ← Utilidades especializadas
└── 📂 tests/            ← Pruebas del módulo
```

### Controllers
```
controller/
├── EnvironmentController.java   ← Gestión de espacios
├── BuildingController.java      ← Gestión de edificios
└── ResourceController.java      ← Gestión de recursos
```

### Services
```
service/
├── EnvironmentService.java      ← Lógica de espacios
├── ResourceService.java         ← Lógica de recursos
└── CapacityService.java         ← Cálculo de capacidades
```

### Repositories
```
repository/
├── EnvironmentRepository.java   ← Consultas de espacios
└── ResourceRepository.java      ← Consultas de recursos
```

### Entidades
```
entity/
├── Environment.java             ← Aula o espacio físico
├── Building.java                ← Edificio
└── Resource.java                ← Recurso (proyector, etc.)
```

### DTOs
```
dto/
├── EnvironmentDTO.java          ← Datos de espacios
└── ResourceDTO.java             ← Datos de recursos
```

### Utilidades
```
utils/
└── 📂 processInventory/
    ├── CapacityCalculator.java      ← Calcula capacidades
    └── InventoryProcessor.java      ← Procesa datos de inventario
```

---

## 👁️ MÓDULO: OBSERVATIONS (Observaciones)

**Responsabilidad:** Registrar y gestionar observaciones sobre clases y docentes.

```
observations/
│
├── 📂 controller/       ← Endpoints REST
├── 📂 service/          ← Lógica de negocio
├── 📂 repository/       ← Acceso a datos
├── 📂 entity/           ← Modelos de BD
├── 📂 dto/              ← Objetos de transferencia
└── 📂 tests/            ← Pruebas del módulo
```

### Controllers
```
controller/
└── ObservationController.java   ← Gestión de observaciones
```

### Services
```
service/
└── ObservationService.java      ← Lógica de observaciones
```

### Repositories
```
repository/
└── ObservationRepository.java   ← Consultas de observaciones
```

### Entidades
```
entity/
└── Observation.java             ← Observación registrada
```

### DTOs
```
dto/
└── ObservationDTO.java          ← Datos de observación
```

---

## 📊 MÓDULO: REPORTS (Reportes)

**Responsabilidad:** Generar reportes y métricas del sistema.

```
reports/
│
├── 📂 controller/       ← Endpoints REST
├── 📂 service/          ← Lógica de negocio
├── 📂 dto/              ← Objetos de transferencia
├── 📂 queries/          ← Consultas SQL especializadas
└── 📂 tests/            ← Pruebas del módulo
```

### Controllers
```
controller/
└── ReportController.java        ← Endpoints de reportes
```

### Services
```
service/
├── ReportService.java           ← Generación de reportes
└── MetricsService.java          ← Cálculo de métricas
```

### DTOs
```
dto/
├── InstructorLoadDTO.java       ← Carga de docentes
└── OccupationRateDTO.java       ← Tasa de ocupación
```

### Consultas
```
queries/
└── ReportQueries.sql            ← Consultas SQL optimizadas
```

---

## 👨‍🏫 MÓDULO: INSTRUCTORS (Docentes)

**Responsabilidad:** Gestionar información de docentes.

```
instructors/
│
├── 📂 controller/       ← Endpoints REST
├── 📂 service/          ← Lógica de negocio
├── 📂 repository/       ← Acceso a datos
├── 📂 entity/           ← Modelos de BD
├── 📂 dto/              ← Objetos de transferencia
└── 📂 tests/            ← Pruebas del módulo
```

---

## 🔧 CÓDIGO COMPARTIDO (carpeta `shared/`)

Funcionalidades reutilizables en toda la aplicación.

```
shared/
│
├── 📂 config/           ← Configuraciones globales (BD, JWT, etc.)
├── 📂 exceptions/       ← Excepciones personalizadas
├── 📂 middleware/       ← Filtros e interceptores globales
├── 📂 utils/            ← Funciones utilitarias comunes
├── 📂 constants/        ← Constantes del sistema
└── 📂 database/         ← Configuración de base de datos
```

---

## 🧪 PRUEBAS (carpeta `tests/`)

```
tests/
│
├── 📂 integration/      ← Pruebas de integración entre módulos
├── 📂 performance/      ← Pruebas de rendimiento
└── 📂 e2e/              ← Pruebas end-to-end (usuario final)
```

---

## 📌 Resumen Rápido

| Módulo | Función | Entidades Principales |
|--------|---------|----------------------|
| **Security** | Autenticación y autorización | User, Role, Permission |
| **Schedules** | Gestión de horarios | Schedule, TimeSlot, Assignment |
| **Inventory** | Gestión de recursos | Environment, Building, Resource |
| **Observations** | Registro de observaciones | Observation |
| **Reports** | Generación de reportes | ReportData, Metrics |
| **Instructors** | Gestión de docentes | Instructor |

---

## ✅ Patrón de Arquitectura por Módulo

Cada módulo sigue el patrón **Controller → Service → Repository → Entity**:

1. **Controller** → Recibe solicitudes HTTP
2. **Service** → Implementa lógica de negocio
3. **Repository** → Accede a la base de datos
4. **Entity** → Define la estructura de datos
5. **DTO** → Transfiere datos seguros entre capas

