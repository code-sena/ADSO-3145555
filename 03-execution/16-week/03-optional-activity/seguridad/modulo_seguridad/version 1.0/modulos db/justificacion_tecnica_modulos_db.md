# PRJ-EDU-HORARIOS — Módulos y Justificación Técnica

---

## Módulo 1 — Seguridad y Acceso

**Tablas:**
- rol
- permiso
- rol_permiso
- usuario
- sesion
- auditoria

**Justificación:**
Controla quién puede entrar al sistema y qué puede hacer dentro de él. El modelo RBAC (rol → permiso) permite asignar o revocar acciones granulares por módulo sin tocar código. La sesión permite invalidar accesos en tiempo real cuando un usuario es desactivado o cambia de rol, sin esperar que el token expire. La auditoría registra de forma inmutable cada operación con snapshot del estado anterior y posterior, lo que garantiza trazabilidad legal y operativa completa.

---

## Módulo 2 — Estructura Institucional

**Tablas:**
- regional
- centro_formacion
- sede

**Justificación:**
Modela la jerarquía geográfica del SENA en tres niveles: regional → centro de formación → sede. Esta cadena de FKs permite que el sistema restrinja automáticamente la visibilidad de datos por sede, evita duplicación de información institucional y hace posible agrupar reportes de ocupación o conflictos por nivel geográfico sin depender de texto libre inconsistente.

---

## Módulo 3 — Catálogos Base

**Tablas:**
- tipo_ambiente
- tipo_contrato
- jornada
- modalidad_formacion
- nivel_formacion
- parametro_sistema

**Justificación:**
Centraliza todos los valores de clasificación que antes vivían como texto libre en distintas tablas. Normalizar estos datos en catálogos controlados elimina inconsistencias como "Presencial" vs "presencial" vs "PRESENCIAL" y permite filtros confiables. El `parametro_sistema` es especialmente crítico porque externaliza los umbrales del motor de validación, permitiendo que un administrador los ajuste desde la interfaz sin necesidad de redeploy.

---

## Módulo 4 — Líneas y Redes Académicas

**Tablas:**
- linea_tecnologica
- red_conocimiento

**Justificación:**
Implementa la taxonomía académica oficial del SENA en dos niveles: línea tecnológica → red de conocimiento. Sin esta jerarquía, los programas de formación no tendrían una clasificación consultable y navegar la oferta académica dependería de búsquedas por texto libre. Permite responder preguntas como "¿cuántos programas activos tiene la línea TIC?" de forma exacta y consistente.

---

## Módulo 5 — Oferta y Programas

**Tablas:**
- programa_formacion

**Justificación:**
Es la entidad raíz del dominio académico. Consolida en un solo registro la clasificación completa de un programa: red de conocimiento, modalidad y nivel, reemplazando tres campos VARCHAR libres que generaban duplicados. El código único corresponde al código oficial del SENA, que es la llave de identificación institucional y el punto de partida para vincular fichas, competencias e instructores.

---

## Módulo 6 — Programa Académico

**Tablas:**
- competencia
- resultado_aprendizaje
- competencia_resultado
- programa_competencia

**Justificación:**
Define el contenido académico de cada programa. El catálogo único de competencias y RAPs resuelve el problema de duplicidad donde el mismo elemento era registrado múltiples veces por distintos programas. La tabla `programa_competencia` es la que habilita la cuarta restricción del motor: un instructor solo puede ser asignado si existe un vínculo explícito que lo habilite para esa competencia dentro de ese programa específico.

---

## Módulo 7 — Instructores

**Tablas:**
- instructor
- instructor_competencia

**Justificación:**
Separa el perfil profesional del instructor de su identidad en `usuario`, cumpliendo 3FN. La tabla `instructor_competencia` implementa la regla de negocio más crítica del sistema: la habilitación es simultáneamente por instructor, competencia y programa, lo que significa que el mismo instructor puede orientar una materia en un programa pero no en otro si no tiene el registro correspondiente. Sin esta tabla esa validación es imposible.

---

## Módulo 8 — Ambientes

**Tablas:**
- ambiente
- recurso_ambiente
- disponibilidad_ambiente

**Justificación:**
Gestiona los espacios físicos como entidades consultables. `recurso_ambiente` convierte el inventario tecnológico de cada espacio en datos filtrables, permitiendo encontrar ambientes con equipos específicos antes de asignarlos. `disponibilidad_ambiente` cubre los bloqueos que no se pueden inferir por ausencia de horarios: mantenimiento, reservas especiales o jornadas en que el ambiente no opera, evitando que el buscador devuelva resultados incorrectos.

---

## Módulo 9 — Fichas y Franjas Horarias

**Tablas:**
- franja_horaria
- ficha
- extension_ficha

**Justificación:**
`franja_horaria` elimina el ingreso manual de horas, haciendo que el coordinador seleccione del catálogo y reduciendo el tiempo de programación. `ficha` es la segunda entidad de la triple restricción del motor y su vigencia controla qué grupos pueden recibir nuevas asignaciones. `extension_ficha` convierte el proceso de prórroga en un log formal y trazable, impidiendo que sea un bypass silencioso del sistema.

---

## Módulo 10 — Aprendices

**Tablas:**
- aprendiz
- aprendiz_ficha

**Justificación:**
Permite que el sistema conozca a los aprendices como individuos y no solo como conteos dentro de una ficha. Esto habilita la detección de cruces de horario a nivel personal y el seguimiento de traslados entre fichas. `aprendiz_ficha` conserva el historial completo de matrícula sin violar la restricción de unicidad, usando el campo `estado` para distinguir registros activos de históricos.

---

## Módulo 11 — Motor de Horarios

**Tablas:**
- horario

**Justificación:**
Es la tabla central del sistema y el núcleo de todo el proyecto. Las tres restricciones `UNIQUE` compuestas hacen físicamente imposible guardar un cruce de instructor, ambiente o ficha en la misma franja y fecha, incluso ante operaciones concurrentes de dos coordinadores distintos. PostgreSQL rechaza la inserción antes de que la aplicación pueda procesarla. La FK directa a `competencia_id` habilita la cuarta validación sin joins adicionales en el camino crítico de escritura.

---

## Módulo 12 — Observaciones e Incidencias

**Tablas:**
- observacion
- observacion_estado

**Justificación:**
Provee la fuente de datos del KPI 1 de conflictos. Los campos `tipo` y `severidad` evitan que el módulo se convierta en un basurero de texto libre. `observacion_estado` convierte el campo de estado en un log de transiciones medible, lo que permite calcular tiempos de resolución y saber exactamente quién gestionó cada incidencia en cada paso, convirtiendo un campo simple en un historial auditable.

---

## Módulo 13 — Proyectos Formativos

**Tablas:**
- proyecto_formativo
- proyecto_hito
- proyecto_integrante

**Justificación:**
Saca la gestión de proyectos académicos de los documentos Word y los integra al sistema con trazabilidad real. Los hitos convierten el avance del proyecto en datos medibles con fecha límite y estado de completitud. Los integrantes permiten asignar roles individuales a cada aprendiz dentro del proyecto, habilitando evaluaciones personalizadas y responsabilidades claras.

---

## Módulo 14 — Evaluación de Proyectos

**Tablas:**
- evaluacion_proyecto

**Justificación:**
Registra el acto formal de calificación de un proyecto por parte del coordinador. Está separada de `observacion` porque tiene naturaleza distinta: incluye calificación numérica en escala 0–5 con decimales y un ciclo de estados propio. Mezclarla con el módulo de incidencias operativas habría contaminado el KPI de conflictos con datos académicos no relacionados.

---

## Módulo 15 — Notificaciones

**Tablas:**
- notificacion

**Justificación:**
Comunica eventos relevantes al usuario sin que tenga que revisar activamente cada módulo del sistema. El patrón de referencia navegable (`referencia_id` + `referencia_tabla`) lleva al usuario directamente al registro que generó el evento con un solo clic, independientemente de si es un horario, una observación, una ficha o un proyecto. La trazabilidad profunda del sistema queda cubierta por la tabla `auditoria` del Módulo 1.