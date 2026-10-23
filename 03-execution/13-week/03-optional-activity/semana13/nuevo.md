PRJ-EDU-HORARIOS/
│
├── README.md
├── CHANGELOG.md
├── LICENSE
├── .gitignore
├── docker-compose.yml
├── pom.xml
│
├── .github/
│   └── workflows/
│       ├── ci.yml
│       ├── tests.yml
│       └── deploy.yml
│
├── docs/
│   │
│   ├── 00-governance/
│   │   ├── documentation-rules.md
│   │   ├── naming-conventions.md
│   │   └── definition-of-done.md
│   │
│   ├── 01-project-context/
│   │   ├── business-objectives.md
│   │   ├── scope.md
│   │   ├── assumptions.md
│   │   ├── constraints.md
│   │   └── glossary.md
│   │
│   ├── 02-domain/
│   │   ├── actors.md
│   │   ├── business-rules.md
│   │   ├── domain-boundaries.md
│   │   ├── instructor.md
│   │   ├── academic-group.md
│   │   ├── environment.md
│   │   └── schedules.md
│   │
│   ├── 03-product-definition/
│   │   ├── product-vision.md
│   │   ├── mvp-definition.md
│   │   ├── roadmap.md
│   │   ├── functional-requirements.md
│   │   ├── non-functional-requirements.md
│   │   └── acceptance-criteria.md
│   │
│   ├── 04-architecture/
│   │   │
│   │   ├── architecture-overview.md
│   │   ├── architecture-principles.md
│   │   ├── quality-attributes.md
│   │   ├── deployment-strategy.md
│   │   │
│   │   ├── c4/
│   │   │   │
│   │   │   ├── c1-context/
│   │   │   │   ├── level-1-context.drawio
│   │   │   │   ├── level-1-context.png
│   │   │   │   └── README.md
│   │   │   │
│   │   │   ├── c2-containers/
│   │   │   │   ├── level-2-containers.drawio
│   │   │   │   ├── level-2-containers.png
│   │   │   │   └── README.md
│   │   │   │
│   │   │   ├── c3-components/
│   │   │   │   ├── schedules-module.drawio
│   │   │   │   ├── security-module.drawio
│   │   │   │   ├── inventory-module.drawio
│   │   │   │   └── README.md
│   │   │   │
│   │   │   └── c4-code/
│   │   │       ├── package-structure.md
│   │   │       ├── module-structure.md
│   │   │       └── source-tree.md
│   │   │
│   │   ├── adr/
│   │   │   ├── ADR-001-modular-monolith.md
│   │   │   ├── ADR-002-jwt-security.md
│   │   │   ├── ADR-003-validation-engine.md
│   │   │   └── ADR-004-postgresql.md
│   │   │
│   │   └── diagrams/
│   │       ├── drawio/
│   │       ├── plantuml/
│   │       ├── png/
│   │       └── svg/
│   │
│   ├── 05-data-architecture/
│   │   ├── conceptual-model.md
│   │   ├── logical-model.md
│   │   ├── relational-model.md
│   │   ├── entity-catalog.md
│   │   ├── data-dictionary.md
│   │   └── erd.drawio
│   │
│   ├── 06-api-design/
│   │   ├── api-standards.md
│   │   ├── authentication.md
│   │   ├── error-handling.md
│   │   ├── versioning.md
│   │   └── openapi/
│   │       └── horarios-api.yaml
│   │
│   ├── 07-security/
│   │   ├── roles-permissions.md
│   │   ├── jwt-strategy.md
│   │   ├── threat-model.md
│   │   └── auditability.md
│   │
│   ├── 08-devops/
│   │   ├── ci-cd-strategy.md
│   │   ├── branching-strategy.md
│   │   ├── environments.md
│   │   ├── docker-standards.md
│   │   └── observability.md
│   │
│   ├── 09-quality-assurance/
│   │   ├── testing-strategy.md
│   │   ├── unit-testing.md
│   │   ├── integration-testing.md
│   │   ├── e2e-testing.md
│   │   └── quality-gates.md
│   │
│   ├── 10-backlog/
│   │   ├── epics/
│   │   ├── user-stories/
│   │   ├── tasks/
│   │   └── traceability-matrix.md
│   │
│   └── 99-archive/
│       └── deprecated/
│
├── src/
│   │
│   ├── modules/
│   │   │
│   │   ├── security/
│   │   ├── schedules/
│   │   ├── inventory/
│   │   ├── observations/
│   │   └── reports/
│   │
│   ├── shared/
│   │   ├── config/
│   │   ├── exceptions/
│   │   ├── middleware/
│   │   ├── utils/
│   │   └── database/
│   │
│   └── main/
│       └── Application.java
│
├── tests/
│   ├── unit/
│   ├── integration/
│   ├── performance/
│   └── e2e/
│
├── scripts/
│   ├── deploy.sh
│   ├── backup-db.sh
│   └── run-tests.sh
│
├── assets/
│   ├── images/
│   ├── icons/
│   └── exports/
│
└── tools/
    ├── validate-docs.ps1
    └── generate-index.ps1