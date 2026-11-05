1. GOVERNANCE (Gobernanza)
✅ NUEVO
00-governance/
¿Para qué sirve?

Define reglas del proyecto:

estándares
nomenclaturas
documentación
Definition of Done
revisiones

-------------------------------------------------------------
2. PROJECT CONTEXT
✅ NUEVO
01-project-context/
Aquí documentas:
objetivos del negocio
alcance
restricciones
supuestos
glosario

----------------------------------------------------------------

3. DOMAIN MODELING
✅ NUEVO
02-domain/
Aquí modelas el negocio:
Instructor
Ficha
Ambiente
Horario
Reglas del dominio

----------------------------------------------------------------

4. PRODUCT DEFINITION
✅ NUEVO
03-product-definition/
Aquí va:
visión del producto
roadmap
MVP
requisitos funcionales
requisitos no funcionales

-------------------------------------------------------------------

5. C4 PROFESIONAL
🔥 MEJORADO

Antes:

c1-c2-c3

Ahora:

04-architecture/
└── c4/

y además:

c1-context/
c2-containers/
c3-components/
c4-code/
También agregas:
ADR
diagrams
drawio
plantuml
png
svg

---------------------------------------------------------------------------

6. ADR (Architecture Decision Records)
🔥 MUY IMPORTANTE — NUEVO
adr/
Aquí guardas decisiones técnicas:

Ejemplos:

ADR-001-modular-monolith.md
ADR-002-jwt-security.md
ADR-003-postgresql.md
Esto lo usan:
arquitectos
equipos enterprise
DevOps
microservicios

------------------------------------------------------------------------------

7. DATA ARCHITECTURE
✅ NUEVO
05-data-architecture/
Aquí va:
MER
ERD
diccionario de datos
modelo relacional
entidades
Esto fortalece muchísimo tu documentación.

--------------------------------------------------------------------------------

8. API DESIGN
🔥 NUEVO
06-api-design/
Aquí documentas:
OpenAPI
contratos REST
versionamiento
autenticación
manejo de errores

----------------------------------------------------------------------------------

9. SECURITY DOCUMENTATION
🔥 NUEVO
07-security/
Aquí defines:
JWT
roles
permisos
amenazas
auditoría

----------------------------------------------------------------------------------


10.DEVOPS
🔥 NUEVO
08-devops/
Aquí documentas:
CI/CD
Docker
despliegues
ramas Git
ambientes

--------------------------------------------------------------------------------

11. QUALITY ASSURANCE
🔥 NUEVO
09-quality-assurance/
Aquí defines:
estrategia TDD
pruebas unitarias
integración
E2E
quality gates

-------------------------------------------------------------------------------

12. BACKLOG PROFESIONAL
✅ NUEVO
10-backlog/
Aquí organizas:
épicas
historias de usuario
tareas
trazabilidad

--------------------------------------------------------------------------------

13. ASSETS
✅ NUEVO
assets/
Guarda:
imágenes
iconos
exportaciones

--------------------------------------------------------------------------------

14. TOOLS
✅ NUEVO
tools/
Scripts de soporte:
validar docs
generar índices
automatización

--------------------------------------------------------------------------------

15. TESTS GLOBAL
🔥 MEJORADO

Antes:

solo TDD

Ahora:

tests/
├── unit/
├── integration/
├── performance/
└── e2e/


--------------------------------------------------------------------------------

16. GITHUB ACTIONS
🔥 NUEVO
.github/workflows/
Automatización CI/CD:
tests automáticos
validaciones
despliegues

-------------------------------------------------------------------------------

17. SCRIPTS OPERACIONALES
✅ NUEVO
scripts/
Para:
backups
despliegues
ejecución automática

--------------------------------------------------------------------------------


