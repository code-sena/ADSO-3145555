Modulo 5 - Programas de Formacion 



Integrantes:



\- Danna Valentina Barrios Penagos

\- Emily Sharith Amezquita Saavedra

\- Laura Vanessa Perez Perdomo



Link drawio: https://drive.google.com/file/d/1GyKt1rkFD2v7nNXwDqow3bjp65A6i2xh/view?usp=sharing



Entregable final script justificacion:



\# MÓDULO 5: PROGRAMAS DE FORMACIÓN

\## Punto 3 — Entidades con Atributos Justificados



\---



\## ENTIDADES NIVEL CATÁLOGO (Referencias de Estructura Institucional)



\### 1. \*\*linea\_tecnologica\*\*

\*\*Atributos:\*\*

\- `id\_linea` (UUID) — Identificador único

\- `codigo\_linea` (VARCHAR) — Código único, obligatorio (ej: "LTE01")

\- `nombre` (VARCHAR) — Nombre descriptivo, obligatorio

\- `descripcion` (TEXT) — Información adicional

\- `estado` (BOOLEAN) — Activo/Inactivo, por defecto TRUE



\*\*Justificación:\*\*

\- Es el nivel más alto de la jerarquía SENA (nivel 1/6)

\- Requiere código y nombre únicos para identificación institucional

\- El estado permite deshabilitar sin borrar datos históricos

\- Viene de \*\*Módulo 2 (Estructura Institucional)\*\* pero se replica aquí como referencia



\---



\### 2. \*\*red\_tecnologica\*\*

\*\*Atributos:\*\*

\- `id\_red\_tecnologica` (UUID) — Identificador único

\- `id\_linea` (UUID FK) — Referencia a linea\_tecnologica (nivel 1)

\- `codigo\_red\_tecnologica` (VARCHAR) — Código único dentro de la línea

\- `nombre` (VARCHAR) — Nombre descriptivo

\- `descripcion` (TEXT) — Información adicional

\- `estado` (BOOLEAN) — Activo/Inactivo



\*\*Justificación:\*\*

\- Nivel 2 de la jerarquía SENA

\- Subordinada obligatoriamente a una `linea\_tecnologica`

\- Código único asegura identificación sin ambigüedad

\- Estado permite gestión de vigencia sin pérdida de datos



\---



\### 3. \*\*red\_conocimiento\*\*

\*\*Atributos:\*\*

\- `id\_red\_conocimiento` (UUID) — Identificador único

\- `id\_red\_tecnologica` (UUID FK) — Referencia a red\_tecnologica (nivel 2)

\- `codigo\_red\_conocimiento` (VARCHAR) — Código único

\- `nombre` (VARCHAR) — Nombre descriptivo

\- `descripcion` (TEXT) — Información adicional

\- `estado` (BOOLEAN) — Activo/Inactivo



\*\*Justificación:\*\*

\- Nivel 3 de la jerarquía SENA

\- Subordinada a `red\_tecnologica` (relación 1:N)

\- Código único para trazabilidad en reportes curriculares

\- Es el punto de entrada para programas de formación



\---



\### 4. \*\*tipo\_formacion\*\*

\*\*Atributos:\*\*

\- `id\_tipo\_formacion` (UUID) — Identificador único

\- `codigo\_tipo` (VARCHAR) — Código único (ej: "TF001")

\- `nombre` (VARCHAR) — Nombre único (ej: "Titulada", "Complementaria", "EDT", "Certificación por Competencia Laboral")

\- `certificado\_emitido` (VARCHAR) — Tipo de certificado que se emite para este tipo

\- `descripcion` (TEXT) — Información adicional

\- `estado` (BOOLEAN) — Activo/Inactivo



\*\*Justificación:\*\*

\- Catálogo maestro con \~4-5 valores fijos según SENA

\- `certificado\_emitido` es crítico: define qué documento legal se expide

\- Nombre único evita duplicados que causen confusión curricular

\- Viene de \*\*Módulo 4 (Parametrización)\*\* pero se replica como referencia



\---



\### 5. \*\*modalidad\_formacion\*\*

\*\*Atributos:\*\*

\- `id\_modalidad` (UUID) — Identificador único

\- `codigo\_modalidad` (VARCHAR) — Código único (ej: "MOD01")

\- `nombre` (VARCHAR) — Nombre único (ej: "Presencial", "Virtual", "Mixta", "A distancia")

\- `descripcion` (TEXT) — Información adicional

\- `requiere\_ambiente\_fisico` (BOOLEAN) — Si necesita sala, laboratorio, etc.

\- `estado` (BOOLEAN) — Activo/Inactivo



\*\*Justificación:\*\*

\- Catálogo maestro (\~4 valores fijos)

\- `requiere\_ambiente\_fisico` es crítico para \*\*Módulo 8 (Horarios)\*\* y \*\*Módulo 10 (Coordinación y Eventos)\*\*: virtual no necesita sala

\- Viene de \*\*Módulo 4\*\* pero se replica aquí como referencia

\- Impacta en costos y disponibilidad de recursos



\---



\### 6. \*\*tipo\_competencia\*\*

\*\*Atributos:\*\*

\- `id\_tipo\_competencia` (UUID) — Identificador único

\- `codigo\_tipo` (VARCHAR) — Código único

\- `nombre` (VARCHAR) — Nombre único (ej: "CE" = Competencia Específica, "CT" = Competencia Transversal, "CB" = Competencia Básica)

\- `descripcion` (TEXT) — Información adicional

\- `estado` (BOOLEAN) — Activo/Inactivo



\*\*Justificación:\*\*

\- Catálogo maestro con 3 tipos según SENA

\- Define la naturaleza curricular de cada competencia

\- Nombre único evita ambigüedades en reportes



\---



\### 7. \*\*tipo\_resultado\_aprendizaje\*\*

\*\*Atributos:\*\*

\- `id\_tipo\_resultado` (UUID) — Identificador único

\- `codigo\_tipo` (VARCHAR) — Código único

\- `nombre` (VARCHAR) — Nombre único (ej: "RAE" = Resultado de Aprendizaje Esperado, "RAT" = Resultado de Aprendizaje en Transferencia, "RAB" = Resultado de Aprendizaje Básico)

\- `descripcion` (TEXT) — Información adicional

\- `estado` (BOOLEAN) — Activo/Inactivo



\*\*Justificación:\*\*

\- Catálogo maestro con 3 subtipos de RAP

\- Diferencia el contexto evaluativo y didáctico de cada RAP

\- Nombre único asegura consistencia en formulación curricular



\---



\## ENTIDADES NIVEL PROGRAMA (Núcleo de Module 5)



\### 8. \*\*programa\_formacion\*\*

\*\*Atributos:\*\*

\- `id\_programa` (UUID) — Identificador único

\- `id\_red\_conocimiento` (UUID FK) — Referencia a red\_conocimiento (nivel 3 jerárquico)

\- `id\_tipo\_formacion` (UUID FK) — Referencia a tipo\_formacion

\- `id\_modalidad` (UUID FK) — Referencia a modalidad\_formacion

\- `codigo\_programa` (VARCHAR) — Código único institucional (ej: "923401")

\- `nombre` (VARCHAR) — Nombre del programa (ej: "Técnico en Desarrollo de Software")

\- `version\_diseno` (VARCHAR) — Control de versión curricular (ej: "2.0")

\- `duracion\_horas` (INTEGER) — Total de horas (validado > 0)

\- `a\_la\_medida` (BOOLEAN) — Si es diseño customizado (por defecto FALSE)

\- `vigencia\_inicio` (DATE) — Fecha de inicio de oferta

\- `vigencia\_fin` (DATE) — Fecha de finalización (NULL = indefinida)

\- `estado` (BOOLEAN) — Activo/Inactivo

\- `created\_at`, `updated\_at` (TIMESTAMP) — Auditoría



\*\*Justificación:\*\*

\- Entidad central de Module 5: representa cada \*\*Programa de Formación SENA\*\*

\- `id\_red\_conocimiento`: cada programa pertenece a exactamente una red de conocimiento (relación 1:N)

\- `id\_tipo\_formacion` y `id\_modalidad`: definen cómo se ofrece

\- `codigo\_programa`: identificador institucional único (formato: 6 dígitos SENA)

\- `version\_diseno`: SENA versiona los currículos (1.0, 2.0, 2.1, etc.)

\- `duracion\_horas`: crítico para calendarización (\*\*Módulo 8\*\*)

\- `a\_la\_medida`: regla de negocio: un programa "titulado" NO puede ser a\_la\_medida

\- `vigencia\_inicio`/`vigencia\_fin`: ciclo de vida del programa (necesario para \*\*Módulo 6 - Oferta\*\*)

\- Auditoría temporal: tracking de cambios curriculares



\---



\### 9. \*\*competencia\*\*

\*\*Atributos:\*\*

\- `id\_competencia` (UUID) — Identificador único

\- `id\_tipo\_competencia` (UUID FK) — Referencia a tipo\_competencia (CE, CT, CB)

\- `codigo\_competencia` (VARCHAR) — Código único institucional

\- `nombre` (VARCHAR) — Descripción de la competencia

\- `descripcion` (TEXT) — Detalles adicionales

\- `horas\_totales` (INTEGER) — Horas base de la competencia (validado > 0)

\- `estado` (BOOLEAN) — Activo/Inactivo

\- `created\_at`, `updated\_at` (TIMESTAMP) — Auditoría



\*\*Justificación:\*\*

\- \*\*Catálogo maestro\*\* de competencias SENA (nivel 5 jerárquico)

\- `id\_tipo\_competencia`: cada competencia es CE, CT o CB

\- `codigo\_competencia`: identificador único institucional

\- `horas\_totales`: horas estándar (puede variar por programa en `programa\_competencia`)

\- No tiene FK a programa directamente: la relación es M:N a través de `programa\_competencia`

\- Auditoría: competencias pueden cambiar de definición con el tiempo



\---



\### 10. \*\*programa\_competencia\*\*

\*\*Atributos:\*\*

\- `id\_programa\_competencia` (UUID) — Identificador único

\- `id\_programa` (UUID FK) — Referencia a programa\_formacion

\- `id\_competencia` (UUID FK) — Referencia a competencia

\- `orden\_malla` (SMALLINT) — Secuencia en la malla curricular (ej: 1, 2, 3...)

\- `horas\_en\_programa` (INTEGER) — Horas específicas en este programa (puede diferir de `horas\_totales`)

\- `estado` (BOOLEAN) — Activo/Inactivo

\- \*\*UNIQUE constraints:\*\*

&#x20; - `(id\_programa, id\_competencia)` — Una competencia aparece una sola vez por programa

&#x20; - `(id\_programa, orden\_malla)` — Cada orden es único por programa



\*\*Justificación:\*\*

\- Tabla de \*\*asociación M:N\*\* entre `programa\_formacion` y `competencia`

\- `orden\_malla`: define el flujo de aprendizaje (secuencialidad curricular)

\- `horas\_en\_programa`: la MISMA competencia puede tener 120h en un programa y 80h en otro

\- UNIQUE constraints previenen duplicados y desorden en la malla

\- Impacta directamente en:

&#x20; - \*\*Módulo 7 (Actores)\*\*: instructores autorizados por competencia

&#x20; - \*\*Módulo 8 (Horarios)\*\*: bloques de tiempo por competencia

&#x20; - \*\*Módulo 9 (Proyectos Formativos)\*\*: proyectos integran competencias



\---



\### 11. \*\*resultado\_aprendizaje\*\*

\*\*Atributos:\*\*

\- `id\_resultado` (UUID) — Identificador único

\- `id\_tipo\_resultado` (UUID FK) — Referencia a tipo\_resultado\_aprendizaje (RAE, RAT, RAB)

\- `codigo\_resultado` (VARCHAR) — Código único institucional

\- `nombre` (VARCHAR) — Descripción del RAP (enunciado de resultado esperado)

\- `descripcion` (TEXT) — Criterios de evaluación, evidencias, etc.

\- `estado` (BOOLEAN) — Activo/Inactivo

\- `created\_at`, `updated\_at` (TIMESTAMP) — Auditoría



\*\*Justificación:\*\*

\- \*\*Catálogo maestro\*\* de Resultados de Aprendizaje (nivel 6 jerárquico)

\- `id\_tipo\_resultado`: diferencia RAE (resultado esperado), RAT (transferencia), RAB (básico)

\- `codigo\_resultado`: código único (ej: "RAE201")

\- `nombre`: enunciado del resultado (ej: "Integra características de seguridad en la aplicación")

\- `descripcion`: criterios de evaluación específicos

\- No tiene FK a competencia: relación es M:N a través de `competencia\_resultado`

\- Auditoría: formulación de RAPs puede mejorarse



\---



\### 12. \*\*competencia\_resultado\*\*

\*\*Atributos:\*\*

\- `id\_competencia\_resultado` (UUID) — Identificador único

\- `id\_competencia` (UUID FK) — Referencia a competencia

\- `id\_resultado` (UUID FK) — Referencia a resultado\_aprendizaje

\- `orden\_resultado` (SMALLINT) — Secuencia de RAPs dentro de la competencia

\- `horas\_resultado` (INTEGER) — Horas dedicadas a este RAP (validado > 0)

\- `estado` (BOOLEAN) — Activo/Inactivo

\- \*\*UNIQUE constraints:\*\*

&#x20; - `(id\_competencia, id\_resultado)` — Un RAP aparece una sola vez por competencia

&#x20; - `(id\_competencia, orden\_resultado)` — Cada orden es único



\*\*Justificación:\*\*

\- Tabla de \*\*asociación M:N\*\* entre `competencia` y `resultado\_aprendizaje`

\- `orden\_resultado`: define el orden de logro dentro de la competencia

\- `horas\_resultado`: horas específicas para evaluar este RAP (suma de todos = `horas\_en\_programa`)

\- UNIQUE constraints previenen duplicados

\- Impacta en:

&#x20; - \*\*Módulo 8 (Horarios)\*\*: temporalidad de RAPs

&#x20; - \*\*Módulo 9 (Proyectos)\*\*: proyectos están alineados a RAPs específicos

&#x20; - \*\*Módulo 6 (Oferta)\*\*: visibilidad de RAPs en catálogos públicos



\---



\## RESUMEN DE RELACIONES ENTRE ENTIDADES



```

linea\_tecnologica (1) ← → (N) red\_tecnologica

red\_tecnologica (1) ← → (N) red\_conocimiento

red\_conocimiento (1) ← → (N) programa\_formacion



tipo\_formacion (1) ← → (N) programa\_formacion

modalidad\_formacion (1) ← → (N) programa\_formacion



tipo\_competencia (1) ← → (N) competencia

competencia (1) ← → (N) programa\_competencia (N) ← → (1) programa\_formacion



tipo\_resultado\_aprendizaje (1) ← → (N) resultado\_aprendizaje

resultado\_aprendizaje (1) ← → (N) competencia\_resultado (N) ← → (1) competencia

```



\---



\## DEPENDENCIAS CON OTROS MÓDULOS



| Entrada (Depende de) | Salida (Proporciona a) |

|---|---|

| \*\*Módulo 2\*\*: Estructura institucional (red tecnológica, red conocimiento) | \*\*Módulo 6\*\*: Oferta y Programas (catálogos) |

| \*\*Módulo 4\*\*: Tipos de formación, modalidades | \*\*Módulo 7\*\*: Actores (instructores por competencia) |

| — | \*\*Módulo 8\*\*: Horarios (malla, competencias, horas) |

| — | \*\*Módulo 9\*\*: Proyectos Formativos (competencias, RAPs) |

| — | \*\*Módulo 10\*\*: Coordinación y Eventos (programas vigentes) |



\---



\## REGLAS DE NEGOCIO IMPLEMENTADAS



1\. ✅ `duracion\_horas > 0` — Un programa debe tener mínimo 1 hora

2\. ✅ `horas\_totales > 0` (competencia) — Una competencia sin horas no es evaluable

3\. ✅ `horas\_resultado > 0` — Un RAP debe tener tiempo asignado

4\. ✅ `orden\_malla > 0` — La secuencia inicia en 1

5\. ✅ `vigencia\_fin >= vigencia\_inicio` — Validación de fechas

6\. ✅ `codigo\_\*` UNIQUE — Evita duplicados en identificación

7\. ✅ `nombre` UNIQUE (tipo\_formacion, modalidad\_formacion, tipo\_competencia, tipo\_resultado) — Catálogos sin duplicados

8\. ✅ `(id\_programa, id\_competencia)` UNIQUE — Una competencia por programa

9\. ✅ `(id\_programa, orden\_malla)` UNIQUE — Orden único en malla

10\. ✅ `(id\_competencia, id\_resultado)` UNIQUE — Un RAP por competencia

11\. ✅ `(id\_competencia, orden\_resultado)` UNIQUE — Orden único en RAPs

12\. ⚠️ \*\*No titulada puede ser a\_la\_medida\*\* — Debe validarse en app/API (no es CHECK SQL directo)



\---



\## OBSERVACIONES FINALES



\- \*\*Todos los IDs\*\* son UUID (no secuenciales): mejor para microservicios y distribuido

\- \*\*Códigos\*\* son VARCHAR (no UUID): mantienen los códigos SENA de 6 dígitos o similar

\- \*\*Estados y auditoría\*\*: permiten soft-delete y trazabilidad sin perder historia

\- \*\*FKs y UNIQUE constraints\*\*: garantizan integridad referencial y unicidad

\- \*\*M:N con atributos\*\*: `programa\_competencia` y `competencia\_resultado` no son solo conectores: llevan data crítica (horas, orden, estado)

