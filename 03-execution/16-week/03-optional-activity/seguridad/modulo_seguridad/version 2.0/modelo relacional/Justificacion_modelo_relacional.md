# PRJ-EDU-HORARIOS - Justificacion del Modelo Relacional

**Base de datos:** PostgreSQL  
**Version:** MVP institucional escalable  
**Cantidad actual:** 30 tablas  
**Convencion:** nombres en espanol, singular, snake_case, claves primarias UUID  
**Objetivo:** soportar la programacion academica del SENA evitando cruces de ficha, instructor y ambiente, con trazabilidad de cambios y base preparada para escalar.

---

## 1. Enfoque del modelo

El modelo relacional se disena como una base MVP fuerte, no como una version final sobredimensionada. Su prioridad es cubrir el flujo critico del sistema:

1. Identificar usuarios, roles y permisos.
2. Modelar programas, competencias y resultados de aprendizaje.
3. Registrar instructores, ambientes, fichas y franjas horarias.
4. Crear horarios con validaciones contra cruces.
5. Registrar observaciones, notificaciones y auditoria.

La decision central es mantener 30 tablas para el MVP y dejar las tablas de escalamiento institucional para una V2. Esto permite construir primero el nucleo funcional sin perder la posibilidad de crecer hacia regionales, centros de formacion, oferta academica, disponibilidad real de instructores y proyectos formativos.

---

## 2. Principios de diseno

### 2.1 Normalizacion

El modelo sigue una estructura cercana a tercera forma normal. Los catalogos, perfiles, relaciones N:M y eventos historicos se separan en tablas propias para evitar duplicidad y texto libre innecesario.

### 2.2 Trazabilidad

Las operaciones relevantes se apoyan en `auditoria`, `observacion_estado`, `extension_ficha`, `created_by` en `horario` y `notificacion`. Esto permite saber quien hizo un cambio, cuando lo hizo y sobre que entidad.

### 2.3 Validacion en base de datos

Las restricciones `UNIQUE` del motor de horarios no dependen solo de la aplicacion. PostgreSQL impide tecnicamente que se guarden dos asignaciones conflictivas en la misma fecha y franja.

### 2.4 Escalabilidad institucional

El MVP usa `sede` como ancla geografica. Para una version institucional completa, el modelo puede extenderse hacia:

`regional -> centro_formacion -> sede`

Esa separacion se recomienda para V2, pero no bloquea el MVP.

### 2.5 Separacion entre acceso y perfiles

`usuario` representa la identidad de acceso. `instructor` y `aprendiz` son perfiles academicos asociados a un usuario. Esto evita referencias circulares y permite que un usuario exista antes de tener un perfil especifico.

---

## 3. Grupos del modelo

| Grupo | Nombre | Tablas | Funcion |
|---|---|---:|---|
| 1 | Estructura y catalogos base | 5 | Parametros maestros del sistema. |
| 2 | Seguridad y acceso | 6 | Usuarios, roles, permisos, sesiones y auditoria. |
| 3 | Programa academico | 5 | Programas, competencias y resultados de aprendizaje. |
| 4 | Instructores | 2 | Perfil docente y habilitaciones academicas. |
| 5 | Ambientes | 3 | Espacios, recursos y disponibilidad. |
| 6 | Fichas y franjas | 3 | Grupos, vigencias y bloques de tiempo. |
| 7 | Aprendices | 2 | Perfil de aprendiz y matricula en fichas. |
| 8 | Horarios | 1 | Motor central de programacion. |
| 9 | Observaciones | 2 | Incidencias y seguimiento de estados. |
| 10 | Notificaciones | 1 | Comunicaciones internas navegables. |

---

## 4. Grupo 1 - Estructura y catalogos base

### 1. `sede`

```sql
id          UUID PK
nombre      VARCHAR
direccion   VARCHAR
ciudad      VARCHAR
activo      BOOLEAN
created_at  TIMESTAMP
updated_at  TIMESTAMP
```

**Justificacion:**  
`sede` es el ancla territorial del MVP. Permite relacionar usuarios, instructores, ambientes, aprendices y fichas con una ubicacion fisica. Esta tabla hace posible validar que una ficha no sea asignada a un ambiente de otra sede, salvo que exista una autorizacion futura.

**Mejora futura:**  
Cuando el sistema escale, `sede` debe depender de `centro_formacion`, y este de `regional`.

---

### 2. `tipo_ambiente`

```sql
id          UUID PK
nombre      VARCHAR
descripcion TEXT
created_at  TIMESTAMP
updated_at  TIMESTAMP
```

**Justificacion:**  
Normaliza la clasificacion de ambientes. Evita valores inconsistentes como "laboratorio", "lab", "sala sistemas" o "sistemas" para representar el mismo tipo de espacio.

---

### 3. `tipo_contrato`

```sql
id                UUID PK
nombre            VARCHAR
max_horas_semana  INTEGER
created_at        TIMESTAMP
updated_at        TIMESTAMP
```

**Justificacion:**  
Permite diferenciar planta, contratista u otros tipos de vinculacion. El campo `max_horas_semana` prepara el modelo para validar carga docente maxima sin modificar el esquema mas adelante.

---

### 4. `jornada`

```sql
id           UUID PK
nombre       VARCHAR
hora_inicio  TIME
hora_fin     TIME
created_at   TIMESTAMP
updated_at   TIMESTAMP
```

**Justificacion:**  
Define los rangos generales de operacion academica. `ficha` y `franja_horaria` la referencian para evitar duplicar horarios base en varias tablas.

---

### 5. `parametro_sistema`

```sql
id          UUID PK
clave       VARCHAR UNIQUE
valor       TEXT
descripcion TEXT
created_at  TIMESTAMP
updated_at  TIMESTAMP
```

**Justificacion:**  
Permite configurar reglas operativas sin cambiar codigo: porcentajes maximos de ocupacion, limites de programacion, ventanas de edicion o parametros del motor.

---

## 5. Grupo 2 - Seguridad y acceso

### 6. `rol`

```sql
id          UUID PK
nombre      VARCHAR UNIQUE
descripcion TEXT
created_at  TIMESTAMP
updated_at  TIMESTAMP
```

**Justificacion:**  
Define perfiles de acceso como administrador, coordinador, instructor, aprendiz o auditor. Es la base del control RBAC.

---

### 7. `permiso`

```sql
id          UUID PK
codigo      VARCHAR UNIQUE
descripcion TEXT
modulo      VARCHAR
created_at  TIMESTAMP
updated_at  TIMESTAMP
```

**Justificacion:**  
Permite controlar acciones especificas por modulo, por ejemplo `horario.crear`, `ambiente.editar` o `reporte.ver`. Esto evita depender solo del nombre del rol.

---

### 8. `rol_permiso`

```sql
id          UUID PK
rol_id      UUID FK -> rol.id
permiso_id  UUID FK -> permiso.id
created_at  TIMESTAMP
UNIQUE (rol_id, permiso_id)
```

**Justificacion:**  
Resuelve la relacion muchos a muchos entre roles y permisos. La restriccion unica impide duplicar la misma asignacion.

---

### 9. `usuario`

```sql
id               UUID PK
documento        VARCHAR UNIQUE
nombre           VARCHAR
apellido         VARCHAR
correo           VARCHAR UNIQUE
contrasena_hash  VARCHAR
rol_id           UUID FK -> rol.id
sede_id          UUID FK -> sede.id
activo           BOOLEAN
created_at       TIMESTAMP
updated_at       TIMESTAMP
```

**Justificacion:**  
Es la entidad de identidad digital del sistema. Centraliza documento, correo, credenciales y rol. La contrasena se guarda como hash, nunca como texto plano.

**Decision de diseno:**  
`usuario` no contiene `instructor_id` ni `aprendiz_id`. La relacion va desde los perfiles hacia `usuario`, evitando dependencia circular.

---

### 10. `sesion`

```sql
id          UUID PK
usuario_id  UUID FK -> usuario.id
token_hash  VARCHAR
ip_origen   VARCHAR
user_agent  VARCHAR
activa      BOOLEAN
expires_at  TIMESTAMP
created_at  TIMESTAMP
updated_at  TIMESTAMP
```

**Justificacion:**  
Permite invalidar sesiones activas cuando un usuario cambia de rol, es desactivado o se detecta un acceso sospechoso. El token se almacena como hash.

---

### 11. `auditoria`

```sql
id                 UUID PK
tabla_afectada     VARCHAR
registro_id        UUID
accion             VARCHAR
datos_anteriores   JSONB
datos_nuevos       JSONB
usuario_id         UUID NULL FK -> usuario.id
usuario_documento  VARCHAR
usuario_nombre     VARCHAR
usuario_rol        VARCHAR
ip_origen          VARCHAR
created_at         TIMESTAMP
```

**Justificacion:**  
Registra cambios relevantes del sistema. Los campos de copia del usuario mantienen el historial legible incluso si el usuario es eliminado o modificado. `JSONB` permite almacenar estados anteriores y nuevos sin crear una tabla de auditoria por entidad.

---

## 6. Grupo 3 - Programa academico

### 12. `programa_formacion`

```sql
id               UUID PK
nombre           VARCHAR
codigo           VARCHAR UNIQUE
nivel_formacion  VARCHAR
duracion_meses   INTEGER
activo           BOOLEAN
created_at       TIMESTAMP
updated_at       TIMESTAMP
```

**Justificacion:**  
Representa el programa curricular oficial. La clave `codigo` es unica porque el SENA identifica sus programas con codigos institucionales.

**Mejora futura:**  
Separar `programa_formacion` de `oferta_formacion`, porque un programa puede existir en catalogo aunque no este ofertado en una sede o periodo.

---

### 13. `competencia`

```sql
id          UUID PK
codigo      VARCHAR UNIQUE
nombre      VARCHAR
descripcion TEXT
activo      BOOLEAN
created_at  TIMESTAMP
updated_at  TIMESTAMP
```

**Justificacion:**  
Es el catalogo academico de competencias. Permite validar que una asignacion de horario corresponda a una competencia real y no a texto libre.

---

### 14. `resultado_aprendizaje`

```sql
id          UUID PK
codigo      VARCHAR UNIQUE
nombre      VARCHAR
descripcion TEXT
activo      BOOLEAN
created_at  TIMESTAMP
updated_at  TIMESTAMP
```

**Justificacion:**  
Centraliza los resultados de aprendizaje. Evita que el mismo RAP se duplique en varios programas sin relacion entre si.

---

### 15. `competencia_resultado`

```sql
id              UUID PK
competencia_id  UUID FK -> competencia.id
resultado_id    UUID FK -> resultado_aprendizaje.id
created_at      TIMESTAMP
UNIQUE (competencia_id, resultado_id)
```

**Justificacion:**  
Resuelve la relacion entre competencias y resultados de aprendizaje. La restriccion unica evita vincular el mismo resultado dos veces a la misma competencia.

---

### 16. `programa_competencia`

```sql
id              UUID PK
programa_id     UUID FK -> programa_formacion.id
competencia_id  UUID FK -> competencia.id
horas_lectivas  INTEGER
activo          BOOLEAN
created_at      TIMESTAMP
UNIQUE (programa_id, competencia_id)
```

**Justificacion:**  
Define que competencias componen cada programa y cuantas horas deben programarse. Es clave para medir avance, carga academica y cumplimiento de horas por competencia.

---

## 7. Grupo 4 - Instructores

### 17. `instructor`

```sql
id                UUID PK
usuario_id        UUID UNIQUE FK -> usuario.id
documento         VARCHAR UNIQUE
nombre            VARCHAR
apellido          VARCHAR
correo            VARCHAR UNIQUE
telefono          VARCHAR
tipo_contrato_id  UUID FK -> tipo_contrato.id
sede_id           UUID FK -> sede.id
activo            BOOLEAN
created_at        TIMESTAMP
updated_at        TIMESTAMP
```

**Justificacion:**  
Representa el perfil academico y laboral del instructor. La relacion `usuario_id UNIQUE` garantiza que un usuario tenga como maximo un perfil de instructor.

**Observacion tecnica:**  
Aunque `documento`, `nombre` y `correo` tambien existen en `usuario`, se mantienen aqui para facilitar historicos operativos y consultas academicas. En una version mas estricta se podria reducir esa duplicidad y consultar siempre desde `usuario`.

---

### 18. `instructor_competencia`

```sql
id              UUID PK
instructor_id   UUID FK -> instructor.id
competencia_id  UUID FK -> competencia.id
programa_id     UUID FK -> programa_formacion.id
fecha_inicio    DATE
fecha_fin       DATE
activo          BOOLEAN
created_at      TIMESTAMP
updated_at      TIMESTAMP
UNIQUE (instructor_id, competencia_id, programa_id)
```

**Justificacion:**  
Implementa una de las reglas academicas mas importantes: un instructor solo puede ser asignado si esta habilitado para esa competencia dentro de ese programa especifico.

**Por que incluye `programa_id`:**  
La habilitacion no siempre es universal. Un instructor puede orientar una competencia en un programa, pero no necesariamente en otro.

---

## 8. Grupo 5 - Ambientes

### 19. `ambiente`

```sql
id                UUID PK
codigo            VARCHAR UNIQUE
nombre            VARCHAR
capacidad         INTEGER
ubicacion         VARCHAR
sede_id           UUID FK -> sede.id
tipo_ambiente_id  UUID FK -> tipo_ambiente.id
activo            BOOLEAN
created_at        TIMESTAMP
updated_at        TIMESTAMP
```

**Justificacion:**  
Representa aulas, talleres, laboratorios y demas espacios de formacion. Es una de las tres entidades criticas del motor de horarios.

**Reglas que habilita:**  
Validar ocupacion, capacidad, sede y disponibilidad.

---

### 20. `recurso_ambiente`

```sql
id          UUID PK
ambiente_id UUID FK -> ambiente.id
nombre      VARCHAR
cantidad    INTEGER
created_at  TIMESTAMP
updated_at  TIMESTAMP
```

**Justificacion:**  
Permite registrar recursos consultables, como computadores, proyectores, herramientas o equipos especializados. Sin esta tabla, los recursos quedarian como texto libre.

---

### 21. `disponibilidad_ambiente`

```sql
id              UUID PK
ambiente_id     UUID FK -> ambiente.id
dia_semana      SMALLINT
franja_id       UUID FK -> franja_horaria.id
disponible      BOOLEAN
motivo_bloqueo  VARCHAR NULL
fecha_desde     DATE NULL
fecha_hasta     DATE NULL
created_at      TIMESTAMP
updated_at      TIMESTAMP
```

**Justificacion:**  
No toda disponibilidad se infiere por ausencia de horarios. Un ambiente puede estar bloqueado por mantenimiento, reserva institucional o cierre temporal. Esta tabla modela esos casos de forma explicita.

---

## 9. Grupo 6 - Fichas y franjas

### 22. `franja_horaria`

```sql
id           UUID PK
nombre       VARCHAR
hora_inicio  TIME
hora_fin     TIME
jornada_id   UUID FK -> jornada.id
activo       BOOLEAN
created_at   TIMESTAMP
updated_at   TIMESTAMP
```

**Justificacion:**  
Evita que el coordinador ingrese horas manuales inconsistentes. El sistema programa sobre bloques predefinidos.

---

### 23. `ficha`

```sql
id                   UUID PK
codigo               VARCHAR UNIQUE
programa_id          UUID FK -> programa_formacion.id
sede_id              UUID FK -> sede.id
jornada_id           UUID FK -> jornada.id
fecha_inicio         DATE
fecha_fin            DATE
fecha_fin_extendida  DATE NULL
numero_aprendices    INTEGER
activo               BOOLEAN
created_at           TIMESTAMP
updated_at           TIMESTAMP
```

**Justificacion:**  
Representa el grupo academico sobre el cual se programa. Es una de las tres restricciones principales del motor junto con instructor y ambiente.

**Regla de vigencia:**  
El motor debe validar la fecha del horario contra:

```sql
COALESCE(fecha_fin_extendida, fecha_fin)
```

---

### 24. `extension_ficha`

```sql
id                  UUID PK
ficha_id            UUID FK -> ficha.id
fecha_fin_anterior  DATE
fecha_fin_nueva     DATE
motivo              TEXT
usuario_id          UUID FK -> usuario.id
created_at          TIMESTAMP
```

**Justificacion:**  
Conserva el historial de extensiones de ficha. La fecha final puede cambiar, pero la razon y el responsable deben quedar registrados.

---

## 10. Grupo 7 - Aprendices

### 25. `aprendiz`

```sql
id          UUID PK
usuario_id  UUID UNIQUE FK -> usuario.id
documento   VARCHAR UNIQUE
nombre      VARCHAR
apellido    VARCHAR
correo      VARCHAR UNIQUE
telefono    VARCHAR
sede_id     UUID FK -> sede.id
activo      BOOLEAN
created_at  TIMESTAMP
updated_at  TIMESTAMP
```

**Justificacion:**  
Permite pasar de una programacion anonima por ficha a una trazabilidad individual. Es base para asistencia, historial academico y alertas futuras.

---

### 26. `aprendiz_ficha`

```sql
id               UUID PK
aprendiz_id      UUID FK -> aprendiz.id
ficha_id         UUID FK -> ficha.id
fecha_matricula  DATE
estado           VARCHAR
created_at       TIMESTAMP
updated_at       TIMESTAMP
UNIQUE (aprendiz_id, ficha_id)
```

**Justificacion:**  
Registra la matricula del aprendiz en una ficha y conserva historial de traslados o cambios de estado. La restriccion unica evita matricular dos veces al mismo aprendiz en la misma ficha.

---

## 11. Grupo 8 - Horarios

### 27. `horario`

```sql
id                 UUID PK
ficha_id           UUID FK -> ficha.id
instructor_id      UUID FK -> instructor.id
ambiente_id        UUID FK -> ambiente.id
competencia_id     UUID FK -> competencia.id
franja_horaria_id  UUID FK -> franja_horaria.id
fecha              DATE
estado             VARCHAR
created_by         UUID FK -> usuario.id
created_at         TIMESTAMP
updated_at         TIMESTAMP
UNIQUE (instructor_id, franja_horaria_id, fecha)
UNIQUE (ambiente_id, franja_horaria_id, fecha)
UNIQUE (ficha_id, franja_horaria_id, fecha)
```

**Justificacion:**  
Es la tabla central del sistema. Registra cada bloque academico y aplica la triple restriccion tecnica:

- Un instructor no puede estar en dos bloques en la misma fecha y franja.
- Un ambiente no puede recibir dos fichas en la misma fecha y franja.
- Una ficha no puede tener dos clases en la misma fecha y franja.

**Regla academica adicional:**  
La FK `competencia_id` permite validar que el instructor este habilitado para orientar esa competencia en el programa de la ficha.

---

## 12. Grupo 9 - Observaciones

### 28. `observacion`

```sql
id                UUID PK
tipo              VARCHAR
severidad         VARCHAR
descripcion       TEXT
estado            VARCHAR
ficha_id          UUID NULL FK -> ficha.id
instructor_id     UUID NULL FK -> instructor.id
ambiente_id       UUID NULL FK -> ambiente.id
horario_id        UUID NULL FK -> horario.id
reportado_por     UUID FK -> usuario.id
resuelto_por      UUID NULL FK -> usuario.id
fecha_resolucion  TIMESTAMP NULL
created_at        TIMESTAMP
updated_at        TIMESTAMP
```

**Justificacion:**  
Permite registrar conflictos, novedades, bloqueos, quejas o incidencias. Los campos FK opcionales permiten asociar la observacion al contexto exacto sin exigir que siempre aplique a ficha, instructor, ambiente y horario al mismo tiempo.

---

### 29. `observacion_estado`

```sql
id               UUID PK
observacion_id   UUID FK -> observacion.id
estado_anterior  VARCHAR
estado_nuevo     VARCHAR
comentario       TEXT NULL
usuario_id       UUID FK -> usuario.id
created_at       TIMESTAMP
```

**Justificacion:**  
Convierte los cambios de estado en historial medible. Permite calcular tiempos de resolucion y saber quien gestiono cada incidencia.

---

## 13. Grupo 10 - Notificaciones

### 30. `notificacion`

```sql
id                UUID PK
usuario_id        UUID FK -> usuario.id
titulo            VARCHAR
mensaje           TEXT
tipo              VARCHAR
leida             BOOLEAN
referencia_id     UUID NULL
referencia_tabla  VARCHAR NULL
created_at        TIMESTAMP
```

**Justificacion:**  
Comunica eventos internos del sistema. `referencia_id` y `referencia_tabla` permiten que la notificacion sea navegable hacia un horario, observacion, ficha u otra entidad.

---

## 14. Restricciones clave

| Tabla | Restriccion | Justificacion |
|---|---|---|
| `horario` | `UNIQUE (instructor_id, franja_horaria_id, fecha)` | Evita cruce de instructor. |
| `horario` | `UNIQUE (ambiente_id, franja_horaria_id, fecha)` | Evita doble uso del ambiente. |
| `horario` | `UNIQUE (ficha_id, franja_horaria_id, fecha)` | Evita cruce de ficha. |
| `rol_permiso` | `UNIQUE (rol_id, permiso_id)` | Evita permisos duplicados. |
| `programa_competencia` | `UNIQUE (programa_id, competencia_id)` | Evita duplicar competencias por programa. |
| `competencia_resultado` | `UNIQUE (competencia_id, resultado_id)` | Evita duplicar RAP por competencia. |
| `instructor_competencia` | `UNIQUE (instructor_id, competencia_id, programa_id)` | Controla habilitacion especifica. |
| `aprendiz_ficha` | `UNIQUE (aprendiz_id, ficha_id)` | Evita doble matricula en la misma ficha. |

---

## 15. Reglas del motor de horarios

El modelo actual permite validar:

1. Instructor libre en fecha y franja.
2. Ambiente libre en fecha y franja.
3. Ficha libre en fecha y franja.
4. Ficha vigente.
5. Instructor habilitado para la competencia del programa.
6. Ambiente activo.
7. Instructor activo.
8. Ficha activa.
9. Capacidad del ambiente frente al numero de aprendices.
10. Coherencia de sede entre ficha, ambiente e instructor.

Las tres primeras reglas se protegen directamente con restricciones unicas en base de datos. Las demas se validan desde la capa de aplicacion o mediante funciones/triggers si el proyecto decide reforzar el motor en PostgreSQL.

---

## 16. Mapa relacional simplificado

```text
sede
  -> usuario
  -> instructor
  -> ambiente
  -> ficha
  -> aprendiz

usuario
  -> sesion
  -> auditoria
  -> notificacion
  -> instructor
  -> aprendiz

rol
  -> usuario
  -> rol_permiso -> permiso

programa_formacion
  -> ficha
  -> programa_competencia -> competencia
  -> instructor_competencia

competencia
  -> competencia_resultado -> resultado_aprendizaje
  -> horario

ficha
  -> horario
  -> extension_ficha
  -> aprendiz_ficha -> aprendiz

ambiente
  -> horario
  -> recurso_ambiente
  -> disponibilidad_ambiente -> franja_horaria

instructor
  -> horario
  -> instructor_competencia

horario
  -> observacion
```

---

## 17. Mejoras recomendadas para V2

El modelo actual es suficiente para el MVP, pero una version institucional debe agregar tablas de crecimiento controlado.

| Tabla futura | Proposito |
|---|---|
| `regional` | Agrupar centros de formacion por regional. |
| `centro_formacion` | Separar el centro institucional de la sede fisica. |
| `modalidad` | Controlar presencial, virtual, distancia o mixta. |
| `oferta_formacion` | Separar el programa curricular de su oferta activa. |
| `linea_tecnologica` | Organizar programas por lineas academicas. |
| `red_conocimiento` | Agrupar programas e instructores por red. |
| `disponibilidad_instructor` | Registrar disponibilidad real por fecha, dia o franja. |
| `novedad_instructor` | Registrar incapacidades, permisos, vacaciones o bloqueos. |
| `cambio_horario` | Guardar historial formal de reprogramaciones. |
| `validacion_horario` | Registrar resultados del motor, rechazos y motivos. |
| `revision_coordinacion` | Formalizar aprobaciones de cambios sensibles. |
| `proyecto_formativo` | Conectar la programacion con proyectos academicos. |
| `proyecto_ficha` | Asociar proyectos a fichas especificas. |

---

## 18. Ajustes sugeridos sin cambiar el numero de tablas

Estos ajustes pueden aplicarse al modelo actual sin agregar nuevas entidades:

1. Definir `CHECK` para estados controlados: `activo`, `cerrado`, `cancelado`, `pendiente`, `resuelto`.
2. Indexar todas las claves foraneas usadas en busquedas frecuentes.
3. Crear indices compuestos para consultas de calendario:
   - `(fecha, franja_horaria_id)`
   - `(ficha_id, fecha)`
   - `(instructor_id, fecha)`
   - `(ambiente_id, fecha)`
4. Definir `ON DELETE` de forma explicita en tablas historicas.
5. Mantener `auditoria` como append-only desde la aplicacion.
6. Homologar nombres de columnas: usar `franja_horaria_id` en todas las tablas o documentar claramente si se usa `franja_id`.
7. Revisar duplicidad de datos entre `usuario`, `instructor` y `aprendiz`.

---

## 19. Conclusion tecnica

El modelo relacional de 30 tablas es una base correcta para el MVP porque cubre el nucleo del sistema: seguridad, estructura academica, instructores, ambientes, fichas, horarios, observaciones, notificaciones y auditoria.

La mejor version del proyecto no consiste en agregar muchas tablas desde el inicio, sino en defender claramente el alcance actual y mostrar una ruta de evolucion. Por eso se recomienda:

1. Mantener las 30 tablas como MVP.
2. Fortalecer indices, restricciones y estados.
3. Implementar primero el motor de horarios.
4. Agregar disponibilidad de instructores y oferta academica en V2.
5. Escalar despues hacia coordinacion, proyectos formativos e inteligencia operativa.

Con estos ajustes, el modelo deja de verse como una lista de tablas y se presenta como una arquitectura de datos coherente, trazable y preparada para crecer.
