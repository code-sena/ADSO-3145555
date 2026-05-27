# Contexto y justificación de la estructura de documentación

## 1. Contexto del proyecto

El proyecto PRJ-EDU-HORARIOS es un sistema web para la gestión de horarios académicos en centros de formación. [file:3]  
Busca reemplazar procesos manuales basados en hojas de cálculo dispersas y revisión visual, que hoy generan cruces de horarios y sobrecarga administrativa. [file:3]  

El MVP se centra en: [file:3]  
- Catálogo CRUD de Ambientes, Fichas e Instructores  
- Motor de horarios con validación estricta de conflictos entre instructor, ambiente y ficha  
- Consulta de disponibilidad de ambientes en tiempo real  
- Reporte de carga horaria por instructor  
- Módulo simple de observaciones sobre problemas de horarios  

Los KPIs principales incluyen reducción de conflictos de horarios, optimización de la ocupación de ambientes y mejora en la eficiencia del coordinador académico. [file:1]

## 2. Principios para adaptar la estructura

La estructura original propuesta por el instructor es genérica y aplica tanto a proyectos monolíticos como a arquitecturas de microservicios. [conversation_history:0]  
En este caso se decidió simplificarla manteniendo las secciones necesarias para documentar claramente el contexto, la arquitectura, los datos y la calidad del sistema de horarios, eliminando o fusionando aquellas partes orientadas a escenarios más complejos o fuera del alcance del MVP actual. [file:1][file:3]  

El criterio principal fue: “¿esta carpeta aporta valor directo para entender, construir, desplegar o operar el MVP del sistema de horarios?”, alineado con los objetivos y KPIs definidos. [file:1][file:3]

## 3. Justificación por sección

### 3.1 00-documentation-governance

Se mantiene una sección de gobernanza de la documentación para definir propósito del repositorio, reglas básicas de documentación, convenciones de nombres y proceso de revisión.  
Esto permite que el equipo mantenga consistencia a medida que el proyecto crece, incluso si en esta fase la documentación la produce un equipo pequeño. [file:3]  

### 3.2 01-project-context

Esta sección concentra el problema actual de los horarios, el espacio de problema, los objetivos de negocio, el alcance y fuera de alcance del MVP, así como restricciones y supuestos. [file:3]  
Sirve como punto de entrada para cualquier nuevo miembro del equipo y conecta directamente con los KPIs definidos en el documento de baseline. [file:1][file:3]  

### 3.3 02-domain

Se simplificó la carpeta de dominio a una versión genérica enfocada en el dominio de horarios académicos, en lugar de mantener todo el dominio institucional completo. [file:3]  
Aquí se documentan actores clave (coordinador, instructor, administrador de ambientes), reglas de negocio y límites del dominio relacionados con la programación de horarios. [file:3]  

### 3.4 03-product-definition

Esta sección agrupa visión de producto, definición de MVP, roadmap, personas, journeys y requisitos funcionales y no funcionales. [file:3]  
Permite vincular directamente el diseño del sistema con los KPIs y riesgos identificados, como la prevención de cruces y la eficiencia en la programación. [file:1][file:3]  

### 3.5 04-architecture

Se mantiene una carpeta de arquitectura para capturar principios, overview de la solución, decisiones clave (ADR) y diagramas C4 hasta nivel de componentes.  
Aunque el proyecto se implementa inicialmente como un monolito, esta documentación ayuda a mantener claridad sobre módulos internos y facilita una futura transición a arquitecturas más distribuidas si fuera necesario. [file:3]  

### 3.6 05-data-architecture

Dado que la integridad de horarios depende de un buen modelo de datos, se conserva una sección dedicada a modelos conceptual, lógico y relacional, así como al catálogo de entidades y diccionario de datos. [file:3]  
Esto es crítico para garantizar que las validaciones de conflictos y los reportes se apoyen en un modelo consistente y comprensible para el equipo. [file:1][file:3]  

### 3.7 06-api-design

La aplicación expone servicios para gestionar catálogos, crear horarios y consultar disponibilidad, por lo que se requiere una sección donde se definan estándares de API, manejo de errores, autenticación y versionado. [file:3]  
Aunque en esta fase no se incluye un catálogo avanzado de contratos OpenAPI, se deja el espacio para documentar las interfaces REST que usará el frontend. [file:3]  

### 3.8 07-security

Se mantiene una sección resumida de seguridad para documentar principios básicos, roles y permisos y un checklist mínimo. [file:3]  
Esto se alinea con el requisito de controlar quién puede crear, modificar o aprobar horarios, aun cuando el sistema se despliegue en un entorno institucional controlado. [file:3]  

### 3.9 08-devops

Dado el interés en CI/CD y despliegue con Docker, se conserva una sección de DevOps para estrategias de repositorio, branching, pipeline de CI/CD, ambientes y checklist de despliegue. [file:3]  
No se incluyen secciones avanzadas de observabilidad orientadas a microservicios, ya que no hacen parte del alcance actual. [conversation_history:0][file:3]  

### 3.10 09-quality-assurance

La calidad es crítica porque un error en el motor de validación podría permitir conflictos de horarios, afectando directamente los KPIs. [file:1]  
Por eso se mantiene una carpeta para estrategia de pruebas, pruebas unitarias, de integración y end-to-end, así como criterios de calidad mínimos para aceptar cambios. [file:1][file:3]  

### 3.11 10-user-experience

El principal usuario es el coordinador académico, que requiere una interfaz clara y eficiente. [file:3]  
Se mantiene una sección compacta para principios de UX, arquitectura de información, modelo de navegación y wireframes básicos. [file:3]  

### 3.12 11-backlog

Esta sección permite trazar épicas, historias de usuario y tareas contra los objetivos del proyecto y los KPIs. [file:1][file:3]  
Ayuda a conectar el trabajo día a día con el impacto esperado en reducción de conflictos, ocupación de ambientes y eficiencia del coordinador. [file:1][file:3]  

### 3.13 14-training-and-adoption

Se conserva una sección reducida para manual de usuario y onboarding, enfocada en facilitar la adopción por parte de coordinadores e instructores. [file:3]  
Esto responde a uno de los riesgos identificados: la resistencia al cambio si la UI es percibida como más compleja que las hojas de cálculo actuales. [file:1][file:3]  

### 3.14 99-archive

Se mantiene una carpeta de archivo para mover documentación que quede obsoleta o decisiones de diseño descartadas.  
Esto evita perder historial y mantiene el repositorio ordenado a medida que el proyecto evoluciona. [file:3]  

## 4. Secciones eliminadas o fusionadas

Se eliminaron o no se incluyeron en esta primera versión las secciones específicas de microservicios, catálogo de eventos y comunicación entre servicios, ya que el sistema se implementa inicialmente como una aplicación monolítica. [conversation_history:0][file:3]  
De igual forma, se simplificó la sección de operaciones avanzadas, asumiendo que en esta fase inicial las tareas de operación se documentarán de forma básica dentro de DevOps y training. [file:3]  

En caso de que el proyecto evolucione hacia una arquitectura distribuida o requiera mayor nivel de operación 24/7, estas secciones se podrán reintroducir o expandir en futuras versiones del repositorio.