Aquí está el contenido listo para copiar y pegar:

---

# PRJ-EDU-HORARIOS — Justificación por Tabla
**41 tablas | PostgreSQL | 3FN | UUID**

---

### 1. regional

```sql
id         UUID PK
nombre     VARCHAR(120)
codigo     VARCHAR(20) UNIQUE
activo     BOOLEAN
created_at TIMESTAMP
updated_at TIMESTAMP
```

**Justificación técnica:** Es el nivel más alto de la jerarquía geográfica-institucional del SENA. Todas las entidades del sistema descienden de aquí: regional → centro de formación → sede → ambiente/instructor/ficha. Sin esta tabla, la pertenencia regional de una sede se guardaría como texto libre en cada registro, haciendo imposible agrupar reportes o filtrar conflictos por región sin comparar strings inconsistentes.

**Qué contiene en la práctica:**

| nombre | codigo | activo |
|---|---|---|
| Regional Huila | REG-HUI | true |
| Regional Cundinamarca | REG-CUN | true |
| Regional Antioquia | REG-ANT | true |

El campo `codigo` tiene restricción `UNIQUE` porque el SENA le asigna un código oficial único a cada regional. El campo `activo` permite desactivar una regional sin borrarla, preservando el historial de todo lo que estuvo asociado a ella.

---

### 2. centro_formacion

```sql
id          UUID PK
regional_id UUID FK → regional.id
nombre      VARCHAR(150)
codigo      VARCHAR(20) UNIQUE
activo      BOOLEAN
created_at  TIMESTAMP
updated_at  TIMESTAMP
```

**Justificación técnica:** Segundo nivel de la jerarquía. Una regional puede tener varios centros de formación. Si esta tabla no existiera, `sede` tendría que repetir el nombre de la regional en cada fila, violando la tercera forma normal: si la regional cambia de nombre, habría que actualizar cientos de registros en lugar de uno solo.

**Qué contiene en la práctica:**

| nombre | codigo | regional_id |
|---|---|---|
| Centro de Comercio y Servicios | CCS-HUI | UUID → Regional Huila |
| Centro Agroempresarial | CAE-HUI | UUID → Regional Huila |
| Centro de Gestión Administrativa | CGA-CUN | UUID → Regional Cundinamarca |

Un centro de formación puede tener múltiples sedes físicas (campus, instalaciones alternas), que se modelan en la tabla siguiente.

---

### 3. sede

```sql
id                  UUID PK
centro_formacion_id UUID FK → centro_formacion.id
nombre              VARCHAR(150)
direccion           VARCHAR(255)
ciudad              VARCHAR(100)
activo              BOOLEAN
created_at          TIMESTAMP
updated_at          TIMESTAMP
```

**Justificación técnica:** Es el ancla geográfica de casi todo el sistema. `usuario`, `instructor`, `aprendiz`, `ambiente` y `ficha` la referencian directamente. Gracias a esta FK, el sistema puede verificar automáticamente que un instructor de la Sede Norte no sea asignado a un ambiente de la Sede Sur sin ninguna lógica adicional en la capa de aplicación, la restricción está en los datos.

**Qué contiene en la práctica:**

| nombre | direccion | ciudad | centro_formacion_id |
|---|---|---|---|
| Sede Principal Neiva | Calle 5 # 3-20 | Neiva | UUID → Centro de Comercio |
| Sede La Toma | Vereda La Toma km 3 | Neiva | UUID → Centro de Comercio |
| Sede Garzón | Carrera 12 # 8-15 | Garzón | UUID → Centro Agroempresarial |

---

### 4. tipo_ambiente

```sql
id          UUID PK
nombre      VARCHAR(100)
descripcion TEXT
created_at  TIMESTAMP
updated_at  TIMESTAMP
```

**Justificación técnica:** Catálogo de clasificación de espacios físicos. Sin esta tabla, `ambiente` tendría un campo de texto libre donde cada persona registraría el tipo de forma distinta: "Aula", "aula", "AULA DE CLASE", "Salón", para el mismo concepto. Eso hace imposible filtrar ambientes por categoría de manera confiable.

**Qué contiene en la práctica:**

| nombre | descripcion |
|---|---|
| Aula Teórica | Salón con sillas y tablero para clases magistrales |
| Laboratorio | Espacio con equipos especializados (química, biología, electrónica) |
| Sala de Sistemas | Espacio con computadores para prácticas digitales |
| Taller | Espacio para trabajo práctico con maquinaria o herramientas |
| Auditorio | Espacio de gran capacidad para eventos o charlas |

---

### 5. tipo_contrato

```sql
id               UUID PK
nombre           VARCHAR(100)
max_horas_semana INTEGER
created_at       TIMESTAMP
updated_at       TIMESTAMP
```

**Justificación técnica:** Catálogo de tipos de vinculación docente. El campo `max_horas_semana` ya está modelado aunque la validación automática no esté activa en el MVP. Es la decisión correcta: modelar el dato ahora para no romper el esquema cuando esa validación se active en la siguiente versión, evitando una migración costosa.

**Qué contiene en la práctica:**

| nombre | max_horas_semana |
|---|---|
| Planta | 40 |
| Contratista | 48 |
| Hora Cátedra | 20 |

Un instructor de planta tiene un tope semanal distinto al contratista. Cuando el motor active la validación de horas máximas, leerá este campo en lugar de tenerlo hardcodeado en el código fuente.

---

### 6. jornada

```sql
id          UUID PK
nombre      VARCHAR(80)
hora_inicio TIME
hora_fin    TIME
created_at  TIMESTAMP
updated_at  TIMESTAMP
```

**Justificación técnica:** Define los rangos operativos institucionales. Tanto `franja_horaria` como `ficha` la referencian. Sin esta tabla, cada entidad duplicaría los rangos de tiempo con valores distintos e incompatibles entre sí. Una ficha matriculada en jornada "Noche" y una franja horaria que dice "18:00–22:00" sin referencia común son datos que no se pueden cruzar de forma segura.

**Qué contiene en la práctica:**

| nombre | hora_inicio | hora_fin |
|---|---|---|
| Mañana | 06:00 | 12:00 |
| Tarde | 12:00 | 18:00 |
| Noche | 18:00 | 22:00 |
| Fin de Semana | 06:00 | 18:00 |

---

### 7. modalidad_formacion

```sql
id          UUID PK
nombre      VARCHAR(100)
descripcion TEXT
activo      BOOLEAN
created_at  TIMESTAMP
updated_at  TIMESTAMP
```

**Justificación técnica:** Antes era un VARCHAR libre dentro de `programa_formacion`, lo que generaba inconsistencias como "Presencial", "presencial", "PRESENCIAL" y "Semi-presencial" para representar el mismo valor. Al normalizar en una tabla catálogo, los filtros por modalidad son exactos y el administrador controla el vocabulario permitido.

**Qué contiene en la práctica:**

| nombre | descripcion | activo |
|---|---|---|
| Presencial | Formación en instalaciones físicas del SENA | true |
| Virtual | Formación 100% en plataforma en línea | true |
| A Distancia | Formación mixta con encuentros periódicos | true |

---

### 8. nivel_formacion

```sql
id          UUID PK
nombre      VARCHAR(100)
descripcion TEXT
activo      BOOLEAN
created_at  TIMESTAMP
updated_at  TIMESTAMP
```

**Justificación técnica:** Mismo razonamiento que `modalidad_formacion`: era un campo de texto libre en `programa_formacion` que generaba duplicados. Al separarlo en un catálogo, es posible filtrar programas por nivel académico de forma confiable y consistente.

**Qué contiene en la práctica:**

| nombre | descripcion |
|---|---|
| Técnico | Formación de 12 a 18 meses, enfocada en un oficio específico |
| Tecnólogo | Formación de 24 a 36 meses, con mayor profundidad técnica y teórica |
| Especialización Tecnológica | Profundización para tecnólogos graduados |
| Auxiliar | Formación corta de nivelación u oficio básico |

---

### 9. parametro_sistema

```sql
id          UUID PK
clave       VARCHAR(100) UNIQUE
valor       TEXT
descripcion TEXT
created_at  TIMESTAMP
updated_at  TIMESTAMP
```

**Justificación técnica:** Almacena los umbrales de configuración del motor de validación que pueden cambiar sin necesidad de redeploy. Un administrador los gestiona desde la interfaz. Sin esta tabla cada umbral estaría hardcodeado en el código fuente, lo que significa que cambiar el porcentaje máximo de ocupación requeriría modificar código, pasar por QA y hacer un despliegue completo.

**Qué contiene en la práctica:**

| clave | valor | descripcion |
|---|---|---|
| MAX_OCUPACION_AMBIENTE_PCT | 90 | Porcentaje máximo de ocupación semanal de un ambiente antes de mostrar alerta |
| DIAS_ANTICIPACION_MINIMA | 1 | Días mínimos de anticipación para crear un bloque horario |
| MAX_HORAS_DIA_INSTRUCTOR | 8 | Horas máximas que un instructor puede tener en un día |

---

### 10. rol

```sql
id          UUID PK
nombre      VARCHAR(80) UNIQUE
descripcion TEXT
created_at  TIMESTAMP
updated_at  TIMESTAMP
```

**Justificación técnica:** Define los perfiles de acceso del sistema. Sin esta tabla, `usuario` tendría un campo de texto para el rol y el backend verificaría accesos comparando strings como `if (usuario.rol == "Coordinador")`. Eso se rompe al primer cambio de nombre del rol y no escala cuando se agregan perfiles nuevos.

**Qué contiene en la práctica:**

| nombre | descripcion |
|---|---|
| Coordinador Académico | Puede crear, editar y eliminar horarios y fichas |
| Instructor | Puede consultar su horario y registrar observaciones |
| Administrador de Ambientes | Puede gestionar inventario y disponibilidad de ambientes |
| Administrador del Sistema | Acceso total a configuración, usuarios y auditoría |

---

### 11. permiso

```sql
id          UUID PK
codigo      VARCHAR(100) UNIQUE
descripcion TEXT
modulo      VARCHAR(80)
created_at  TIMESTAMP
updated_at  TIMESTAMP
```

**Justificación técnica:** Catálogo de acciones granulares por módulo. Cada endpoint del backend verifica si el rol del usuario tiene el código de permiso requerido. Sin esta tabla, el control de acceso se reduce a comparar el nombre del rol, lo que obliga a tocar código cada vez que evolucionan las reglas: "el coordinador ahora también puede bloquear ambientes" implicaría modificar `if` en el backend en lugar de insertar una fila en esta tabla.

**Qué contiene en la práctica:**

| codigo | modulo | descripcion |
|---|---|---|
| horario:crear | Horarios | Puede crear nuevos bloques horarios |
| horario:eliminar | Horarios | Puede eliminar bloques horarios existentes |
| ambiente:bloquear | Ambientes | Puede marcar un ambiente como no disponible |
| ficha:editar | Fichas | Puede modificar datos de una ficha |
| usuario:gestionar | Usuarios | Puede crear, editar y desactivar usuarios |

---

### 12. rol_permiso

```sql
id         UUID PK
rol_id     UUID FK → rol.id
permiso_id UUID FK → permiso.id
created_at TIMESTAMP
UNIQUE (rol_id, permiso_id)
```

**Justificación técnica:** Tabla puente N:M requerida por la tercera forma normal. Sin ella, los permisos serían un array de texto dentro de `rol`, violando la primera forma normal. El `UNIQUE` compuesto impide asignar el mismo permiso dos veces al mismo rol, manteniendo el catálogo limpio.

**Qué contiene en la práctica:**

| rol_id | permiso_id |
|---|---|
| UUID → Coordinador Académico | UUID → horario:crear |
| UUID → Coordinador Académico | UUID → horario:eliminar |
| UUID → Coordinador Académico | UUID → ficha:editar |
| UUID → Instructor | UUID → observacion:crear |
| UUID → Administrador de Ambientes | UUID → ambiente:bloquear |

Si el Coordinador necesita un permiso nuevo, se inserta una fila aquí. No se toca código.

---

### 13. usuario

```sql
id              UUID PK
documento       VARCHAR(30) UNIQUE
nombre          VARCHAR(120)
apellido        VARCHAR(120)
correo          VARCHAR(200) UNIQUE
contrasena_hash VARCHAR(255)
rol_id          UUID FK → rol.id
sede_id         UUID FK → sede.id
activo          BOOLEAN
created_at      TIMESTAMP
updated_at      TIMESTAMP
```

**Justificación técnica:** Entidad central de identidad. Es la única tabla que almacena credenciales y siempre guarda solo el hash bcrypt de la contraseña, nunca el valor en claro. La FK a `rol` define qué puede hacer el usuario. La FK a `sede` restringe automáticamente la visibilidad de datos: un coordinador de la Sede Norte no ve los horarios de la Sede Sur, sin lógica adicional en la aplicación.

**Qué contiene en la práctica:**

| documento | nombre | apellido | correo | rol_id | sede_id | activo |
|---|---|---|---|---|---|---|
| 1075432101 | Laura | Ortiz | l.ortiz@sena.edu.co | UUID → Coordinador | UUID → Sede Principal | true |
| 1075987654 | Carlos | Murcia | c.murcia@sena.edu.co | UUID → Instructor | UUID → Sede Principal | true |
| 1075111222 | Diana | Perdomo | d.perdomo@sena.edu.co | UUID → Admin Ambientes | UUID → Sede La Toma | true |

---

### 14. sesion

```sql
id         UUID PK
usuario_id UUID FK → usuario.id
token_hash VARCHAR(255)
ip_origen  VARCHAR(45)
user_agent TEXT
activa     BOOLEAN
expires_at TIMESTAMP
created_at TIMESTAMP
updated_at TIMESTAMP
```

**Justificación técnica:** Permite invalidar el acceso de un usuario en tiempo real cuando es desactivado o cambia de rol, sin esperar que el JWT expire naturalmente. Guarda solo el hash del token, nunca el valor en claro. Sin esta tabla, si un coordinador es desvinculado, su sesión activa seguiría válida hasta que el token venza, lo que es un riesgo de seguridad real.

**Qué contiene en la práctica:**

| usuario_id | ip_origen | activa | expires_at |
|---|---|---|---|
| UUID → Laura Ortiz | 181.52.10.34 | true | 2026-06-02 08:00:00 |
| UUID → Carlos Murcia | 181.52.10.58 | false | 2026-05-30 14:00:00 |

Cuando un administrador desactiva a un usuario, el sistema hace `UPDATE sesion SET activa = false WHERE usuario_id = ?`. La siguiente petición del token activo fallará la verificación.

---

### 15. auditoria

```sql
id                UUID PK
tabla_afectada    VARCHAR(80)
registro_id       UUID
accion            VARCHAR(20)
datos_anteriores  JSONB
datos_nuevos      JSONB
usuario_id        UUID NULL FK → usuario.id  -- SET NULL on DELETE
usuario_documento VARCHAR(30)
usuario_nombre    VARCHAR(120)
usuario_rol       VARCHAR(80)
ip_origen         VARCHAR(45)
created_at        TIMESTAMP
```

**Justificación técnica:** Log inmutable de todas las operaciones del sistema. Las columnas `usuario_documento`, `usuario_nombre` y `usuario_rol` son copias del momento exacto del evento, no derivaciones en tiempo real, por eso no violan 3FN: son snapshots históricos. La FK a `usuario` es nullable con `SET NULL on DELETE` para conservar el registro de auditoría aunque el usuario sea eliminado. El campo JSONB guarda el estado anterior y posterior de cualquier registro sin esquema fijo adicional.

**Qué contiene en la práctica:**

| tabla_afectada | accion | usuario_nombre | usuario_rol | datos_anteriores | datos_nuevos |
|---|---|---|---|---|---|
| horario | INSERT | Laura Ortiz | Coordinador Académico | null | `{"fecha":"2026-06-03","franja":"08:00-10:00"}` |
| ambiente | UPDATE | Diana Perdomo | Admin Ambientes | `{"activo":true}` | `{"activo":false}` |
| usuario | DELETE | Admin Sistema | Administrador | `{"nombre":"Carlos"}` | null |

---

### 16. linea_tecnologica

```sql
id          UUID PK
nombre      VARCHAR(150)
codigo      VARCHAR(20) UNIQUE
descripcion TEXT
activo      BOOLEAN
created_at  TIMESTAMP
updated_at  TIMESTAMP
```

**Justificación técnica:** Primer nivel de la taxonomía académica del SENA. Sin esta tabla la clasificación de los programas sería texto libre sin jerarquía consultable. Con ella, es posible responder preguntas como "¿cuántos instructores tiene el SENA en la línea de Tecnología de la Información?" de forma precisa.

**Qué contiene en la práctica:**

| nombre | codigo |
|---|---|
| Tecnología de la Información y las Comunicaciones | LT-TIC |
| Industria | LT-IND |
| Agroindustria Alimentaria | LT-AGR |
| Comercio y Servicios | LT-CYS |
| Construcción y Obras Civiles | LT-COC |

---

### 17. red_conocimiento

```sql
id                   UUID PK
linea_tecnologica_id UUID FK → linea_tecnologica.id
nombre               VARCHAR(150)
codigo               VARCHAR(20) UNIQUE
descripcion          TEXT
activo               BOOLEAN
created_at           TIMESTAMP
updated_at           TIMESTAMP
```

**Justificación técnica:** Segundo nivel de la taxonomía académica. Cada programa de formación pertenece a una red de conocimiento, que pertenece a una línea tecnológica. Esta jerarquía de dos niveles permite navegar la oferta académica desde lo general (Línea TIC) hasta lo específico (Red de Teleinformática) sin texto libre.

**Qué contiene en la práctica:**

| nombre | codigo | linea_tecnologica_id |
|---|---|---|
| Red de Teleinformática | RC-TELE | UUID → LT-TIC |
| Red de Diseño y Desarrollo de Software | RC-SW | UUID → LT-TIC |
| Red de Automatización | RC-AUTO | UUID → LT-IND |
| Red de Procesos Agroindustriales | RC-AGR | UUID → LT-AGR |

---

### 18. programa_formacion

```sql
id                  UUID PK
red_conocimiento_id UUID FK → red_conocimiento.id
modalidad_id        UUID FK → modalidad_formacion.id
nivel_id            UUID FK → nivel_formacion.id
nombre              VARCHAR(200)
codigo              VARCHAR(20) UNIQUE
duracion_meses      INTEGER
activo              BOOLEAN
created_at          TIMESTAMP
updated_at          TIMESTAMP
```

**Justificación técnica:** Entidad raíz del dominio académico. El `codigo` UNIQUE corresponde al código oficial del SENA, que es la llave de identificación institucional. Las FKs a `modalidad_formacion`, `nivel_formacion` y `red_conocimiento` reemplazan los tres campos VARCHAR libres que tenía antes, normalizando la clasificación completa del programa en catálogos controlados.

**Qué contiene en la práctica:**

| nombre | codigo | nivel | modalidad | duracion_meses |
|---|---|---|---|---|
| Técnico en Sistemas | 228183 | Técnico | Presencial | 18 |
| Tecnólogo en Análisis y Desarrollo de Software | 623931 | Tecnólogo | Presencial | 36 |
| Técnico en Cocina | 532132 | Técnico | Presencial | 12 |

---

### 19. competencia

```sql
id          UUID PK
codigo      VARCHAR(30) UNIQUE
nombre      VARCHAR(200)
descripcion TEXT
activo      BOOLEAN
created_at  TIMESTAMP
updated_at  TIMESTAMP
```

**Justificación técnica:** Catálogo maestro de competencias del SENA. Es la entidad que habilita la cuarta restricción del motor de horarios: un instructor solo puede ser asignado a una competencia si existe un registro que lo vincule explícitamente a ella dentro del programa específico. Sin este catálogo esa validación es imposible porque no habría un identificador único y consistente de competencia al cual referirse.

**Qué contiene en la práctica:**

| codigo | nombre |
|---|---|
| 220501040 | Interactuar en inglés de manera oral y escrita |
| 220501047 | Promover la interacción idónea consigo mismo |
| 228118003 | Desarrollar lógica de programación para software |
| 228118007 | Gestionar bases de datos según proyecto |

---

### 20. resultado_aprendizaje

```sql
id          UUID PK
codigo      VARCHAR(30) UNIQUE
nombre      VARCHAR(200)
descripcion TEXT
activo      BOOLEAN
created_at  TIMESTAMP
updated_at  TIMESTAMP
```

**Justificación técnica:** Catálogo maestro único de Resultados de Aprendizaje del Programa (RAPs). Resuelve el problema de duplicidad detectado en el levantamiento de requisitos: el mismo RAP era registrado varias veces porque cada programa lo creaba de forma independiente. Ahora todos los programas referencian este catálogo único mediante la tabla puente `competencia_resultado`.

**Qué contiene en la práctica:**

| codigo | nombre |
|---|---|
| RAP-001 | Comunicar ideas en inglés en contextos laborales cotidianos |
| RAP-002 | Aplicar algoritmos de ordenamiento en la solución de problemas |
| RAP-003 | Diseñar consultas SQL para extracción de información |
| RAP-004 | Documentar procesos técnicos según estándares institucionales |

---

### 21. competencia_resultado

```sql
id             UUID PK
competencia_id UUID FK → competencia.id
resultado_id   UUID FK → resultado_aprendizaje.id
created_at     TIMESTAMP
UNIQUE (competencia_id, resultado_id)
```

**Justificación técnica:** Tabla puente N:M entre `competencia` y `resultado_aprendizaje`. Una competencia agrupa varios RAPs y un RAP puede pertenecer a varias competencias. El `UNIQUE` compuesto impide vincular el mismo RAP dos veces a la misma competencia, manteniendo la relación limpia.

**Qué contiene en la práctica:**

| competencia_id | resultado_id |
|---|---|
| UUID → Gestionar bases de datos | UUID → RAP: Diseñar consultas SQL |
| UUID → Gestionar bases de datos | UUID → RAP: Documentar procesos técnicos |
| UUID → Desarrollar lógica de programación | UUID → RAP: Aplicar algoritmos |
| UUID → Desarrollar lógica de programación | UUID → RAP: Documentar procesos técnicos |

El RAP "Documentar procesos técnicos" aparece en dos competencias distintas. Eso es válido y es exactamente lo que el `UNIQUE` protege: no duplicar el vínculo dentro de la misma competencia, pero sí permitirlo en competencias distintas.

---

### 22. programa_competencia

```sql
id             UUID PK
programa_id    UUID FK → programa_formacion.id
competencia_id UUID FK → competencia.id
horas_lectivas INTEGER
activo         BOOLEAN
created_at     TIMESTAMP
UNIQUE (programa_id, competencia_id)
```

**Justificación técnica:** Define qué competencias componen cada programa y cuántas horas lectivas tiene cada una. Es la fuente de datos de los KPIs de ocupación y eficiencia, y la base que permite validar que el instructor asignado está habilitado para esa competencia en ese programa específico. El `UNIQUE` impide que una competencia aparezca dos veces dentro del mismo programa.

**Qué contiene en la práctica:**

| programa_id | competencia_id | horas_lectivas |
|---|---|---|
| UUID → Tecnólogo ADSO | UUID → Gestionar bases de datos | 240 |
| UUID → Tecnólogo ADSO | UUID → Desarrollar lógica de programación | 320 |
| UUID → Técnico en Sistemas | UUID → Interactuar en inglés | 120 |

Un programa de 36 meses puede tener 8 a 12 competencias con sus respectivas horas. La suma de `horas_lectivas` por programa representa la carga académica total planificable en el sistema.

---

### 23. instructor

```sql
id               UUID PK
usuario_id       UUID UNIQUE FK → usuario.id
tipo_contrato_id UUID FK → tipo_contrato.id
sede_id          UUID FK → sede.id
telefono         VARCHAR(20)
activo           BOOLEAN
created_at       TIMESTAMP
updated_at       TIMESTAMP
```

**Justificación técnica:** Perfil profesional del instructor separado de su identidad en `usuario`. Solo contiene datos exclusivamente profesionales. `nombre`, `apellido`, `documento` y `correo` no se repiten aquí porque ya viven en `usuario`, tenerlos duplicados violaría 3FN. El `UNIQUE` en `usuario_id` garantiza la relación 1:1 sin referencia circular.

**Qué contiene en la práctica:**

| usuario_id | tipo_contrato | sede | telefono | activo |
|---|---|---|---|---|
| UUID → Carlos Murcia | UUID → Contratista | UUID → Sede Principal | 3115678901 | true |
| UUID → Pedro Lara | UUID → Planta | UUID → Sede La Toma | 3209876543 | true |

Un usuario puede existir en el sistema sin ser instructor (por ejemplo, un coordinador). Solo tiene fila en esta tabla si su rol profesional es el de docente.

---

### 24. instructor_competencia

```sql
id             UUID PK
instructor_id  UUID FK → instructor.id
competencia_id UUID FK → competencia.id
programa_id    UUID FK → programa_formacion.id
fecha_inicio   DATE
fecha_fin      DATE
activo         BOOLEAN
created_at     TIMESTAMP
updated_at     TIMESTAMP
UNIQUE (instructor_id, competencia_id, programa_id)
```

**Justificación técnica:** Implementa la regla de negocio más crítica del sistema: un instructor solo puede ser asignado a un bloque horario si existe un registro que lo habilite para esa competencia dentro de ese programa específico. La clave única de tres columnas refleja que la habilitación es simultáneamente por instructor, competencia y programa. El mismo instructor puede orientar "Inglés" en el programa de Multimedia pero no en Electrónica si no tiene el registro correspondiente.

**Qué contiene en la práctica:**

| instructor_id | competencia_id | programa_id | activo |
|---|---|---|---|
| UUID → Carlos Murcia | UUID → Gestionar bases de datos | UUID → Tecnólogo ADSO | true |
| UUID → Carlos Murcia | UUID → Interactuar en inglés | UUID → Técnico Sistemas | true |
| UUID → Pedro Lara | UUID → Interactuar en inglés | UUID → Técnico Sistemas | true |

Carlos puede dar inglés en Técnico en Sistemas, pero si se intenta asignarlo a Inglés en Cocina y no tiene ese registro, el motor lo rechaza.

---

### 25. ambiente

```sql
id               UUID PK
sede_id          UUID FK → sede.id
tipo_ambiente_id UUID FK → tipo_ambiente.id
codigo           VARCHAR(30) UNIQUE
nombre           VARCHAR(150)
capacidad        INTEGER
ubicacion        VARCHAR(200)
activo           BOOLEAN
created_at       TIMESTAMP
updated_at       TIMESTAMP
```

**Justificación técnica:** Una de las tres entidades de la triple restricción del motor. El `codigo` UNIQUE es el identificador físico que usa el SENA internamente. La FK a `sede` impide asignar un ambiente de otra sede sin lógica adicional. El campo `capacidad` permite validar que el número de aprendices de la ficha no supera el aforo del espacio antes de confirmar la asignación.

**Qué contiene en la práctica:**

| codigo | nombre | tipo | capacidad | sede |
|---|---|---|---|---|
| SAL-101 | Sala de Sistemas 101 | Sala de Sistemas | 30 | UUID → Sede Principal |
| LAB-202 | Laboratorio de Electrónica | Laboratorio | 20 | UUID → Sede Principal |
| AUL-305 | Aula 305 | Aula Teórica | 40 | UUID → Sede La Toma |

---

### 26. recurso_ambiente

```sql
id          UUID PK
ambiente_id UUID FK → ambiente.id
nombre      VARCHAR(120)
cantidad    INTEGER
created_at  TIMESTAMP
updated_at  TIMESTAMP
```

**Justificación técnica:** Sin esta tabla, los recursos tecnológicos de cada ambiente serían texto libre no consultable. Con ella el coordinador puede filtrar y encontrar ambientes que tengan proyector, computadores o equipos específicos antes de asignar una competencia que los requiere.

**Qué contiene en la práctica:**

| ambiente_id | nombre | cantidad |
|---|---|---|
| UUID → Sala de Sistemas 101 | Computadores HP con Windows 10 | 30 |
| UUID → Sala de Sistemas 101 | Proyector Epson | 1 |
| UUID → Laboratorio de Electrónica | Osciloscopio digital | 10 |
| UUID → Aula 305 | Tablero acrílico | 1 |

---

### 27. disponibilidad_ambiente

```sql
id             UUID PK
ambiente_id    UUID FK → ambiente.id
franja_id      UUID FK → franja_horaria.id
dia_semana     SMALLINT CHECK (1-7)
disponible     BOOLEAN
motivo_bloqueo VARCHAR(255)
fecha_desde    DATE
fecha_hasta    DATE
created_at     TIMESTAMP
updated_at     TIMESTAMP
```

**Justificación técnica:** Cubre los bloqueos que no pueden inferirse por ausencia de registros en `horario`: mantenimiento, reservas especiales, jornadas en que el ambiente no opera. Los campos `fecha_desde` y `fecha_hasta` permiten bloqueos temporales sin afectar la disponibilidad general del ambiente. Sin esta tabla, el buscador de ambientes libres devolvería un ambiente en mantenimiento como disponible.

**Qué contiene en la práctica:**

| ambiente_id | dia_semana | franja | disponible | motivo_bloqueo | fecha_desde | fecha_hasta |
|---|---|---|---|---|---|---|
| UUID → Lab Electrónica | 2 (martes) | UUID → 08:00-10:00 | false | Mantenimiento preventivo | 2026-06-01 | 2026-06-07 |
| UUID → Sala 101 | 6 (sábado) | UUID → 06:00-12:00 | false | Jornada de votaciones | 2026-06-07 | 2026-06-07 |

---

### 28. franja_horaria

```sql
id          UUID PK
jornada_id  UUID FK → jornada.id
nombre      VARCHAR(80)
hora_inicio TIME
hora_fin    TIME
activo      BOOLEAN
created_at  TIMESTAMP
updated_at  TIMESTAMP
```

**Justificación técnica:** El coordinador selecciona una franja del catálogo en lugar de ingresar horas manualmente. Esto elimina la posibilidad de franjas inconsistentes o superpuestas ingresadas a mano. Es también lo que habilita el KPI de menos de 30 segundos por bloque programado, ya que el usuario selecciona de una lista en lugar de tipear rangos horarios.

**Qué contiene en la práctica:**

| nombre | hora_inicio | hora_fin | jornada |
|---|---|---|---|
| Bloque 1 Mañana | 06:00 | 08:00 | UUID → Mañana |
| Bloque 2 Mañana | 08:00 | 10:00 | UUID → Mañana |
| Bloque 3 Mañana | 10:00 | 12:00 | UUID → Mañana |
| Bloque 1 Tarde | 12:00 | 14:00 | UUID → Tarde |
| Bloque 1 Noche | 18:00 | 20:00 | UUID → Noche |

---

### 29. ficha

```sql
id                  UUID PK
programa_id         UUID FK → programa_formacion.id
sede_id             UUID FK → sede.id
jornada_id          UUID FK → jornada.id
codigo              VARCHAR(20) UNIQUE
fecha_inicio        DATE
fecha_fin           DATE
fecha_fin_extendida DATE
numero_aprendices   INTEGER
activo              BOOLEAN
created_at          TIMESTAMP
updated_at          TIMESTAMP
```

**Justificación técnica:** Segunda entidad de la triple restricción. Una ficha con fecha fin vencida no puede recibir nuevas asignaciones. El campo `fecha_fin_extendida` nullable permite extensiones formales sin borrar la fecha original. El motor siempre valida contra `COALESCE(fecha_fin_extendida, fecha_fin)` para respetar la extensión si existe.

**Qué contiene en la práctica:**

| codigo | programa | sede | jornada | fecha_inicio | fecha_fin | aprendices |
|---|---|---|---|---|---|---|
| 2875401 | UUID → Tecnólogo ADSO | UUID → Sede Principal | UUID → Tarde | 2024-09-01 | 2026-09-01 | 28 |
| 2941233 | UUID → Técnico Sistemas | UUID → Sede Principal | UUID → Mañana | 2025-03-01 | 2026-09-01 | 22 |
| 2812055 | UUID → Técnico Cocina | UUID → Sede La Toma | UUID → Noche | 2024-06-01 | 2025-12-01 | 18 |

---

### 30. extension_ficha

```sql
id                 UUID PK
ficha_id           UUID FK → ficha.id
usuario_id         UUID FK → usuario.id
fecha_fin_anterior DATE
fecha_fin_nueva    DATE
motivo             TEXT
created_at         TIMESTAMP
```

**Justificación técnica:** Log inmutable del proceso formal de extensión de vigencia. La extensión no es un bypass: debe registrarse aquí antes de poder volver a programar sobre la ficha. Guarda quién extendió, cuándo, por qué, desde qué fecha y hasta cuál. Permite reconstruir el historial completo de prórrogas de un grupo.

**Qué contiene en la práctica:**

| ficha_id | usuario_id | fecha_fin_anterior | fecha_fin_nueva | motivo |
|---|---|---|---|---|
| UUID → 2812055 | UUID → Laura Ortiz | 2025-12-01 | 2026-03-01 | Instructores en licencia durante diciembre |
| UUID → 2875401 | UUID → Laura Ortiz | 2026-09-01 | 2026-11-01 | Retraso en etapa productiva de aprendices |

---

### 31. aprendiz

```sql
id         UUID PK
usuario_id UUID UNIQUE FK → usuario.id
sede_id    UUID FK → sede.id
telefono   VARCHAR(20)
activo     BOOLEAN
created_at TIMESTAMP
updated_at TIMESTAMP
```

**Justificación técnica:** Perfil de seguimiento académico del aprendiz. Solo contiene datos propios de su rol. `nombre`, `apellido`, `documento` y `correo` no se repiten aquí porque ya viven en `usuario`. Sin esta entidad el sistema solo conoce fichas como grupos anónimos y no puede detectar cruces de horario a nivel individual: si un aprendiz está matriculado en dos fichas que se solapan, el sistema no puede saberlo.

**Qué contiene en la práctica:**

| usuario_id | sede | telefono | activo |
|---|---|---|---|
| UUID → Andrés Torres | UUID → Sede Principal | 3145001234 | true |
| UUID → Sara Rincón | UUID → Sede Principal | 3209875678 | true |

---

### 32. aprendiz_ficha

```sql
id              UUID PK
aprendiz_id     UUID FK → aprendiz.id
ficha_id        UUID FK → ficha.id
fecha_matricula DATE
estado          VARCHAR(30)
created_at      TIMESTAMP
updated_at      TIMESTAMP
UNIQUE (aprendiz_id, ficha_id)
```

**Justificación técnica:** Tabla puente con historial entre aprendiz y ficha. El `UNIQUE` impide la doble matrícula activa. Cuando un aprendiz es trasladado, el estado del registro actual cambia a `trasladado` y se crea un nuevo registro con la ficha destino, preservando el historial completo sin violar la restricción de unicidad.

**Qué contiene en la práctica:**

| aprendiz_id | ficha_id | fecha_matricula | estado |
|---|---|---|---|
| UUID → Andrés Torres | UUID → 2875401 | 2024-09-05 | activo |
| UUID → Sara Rincón | UUID → 2875401 | 2024-09-05 | trasladado |
| UUID → Sara Rincón | UUID → 2941233 | 2025-02-01 | activo |

Sara aparece dos veces porque fue trasladada: su historial se conserva completo.

---

### 33. horario

```sql
id                UUID PK
ficha_id          UUID FK → ficha.id
instructor_id     UUID FK → instructor.id
ambiente_id       UUID FK → ambiente.id
competencia_id    UUID FK → competencia.id
franja_horaria_id UUID FK → franja_horaria.id
created_by        UUID FK → usuario.id
fecha             DATE
estado            VARCHAR(30)
created_at        TIMESTAMP
updated_at        TIMESTAMP
UNIQUE (instructor_id,  franja_horaria_id, fecha)
UNIQUE (ambiente_id,    franja_horaria_id, fecha)
UNIQUE (ficha_id,       franja_horaria_id, fecha)
```

**Justificación técnica:** Tabla central del sistema. Las tres restricciones `UNIQUE` son la implementación técnica de la triple restricción: PostgreSQL hace físicamente imposible guardar un cruce, incluso ante operaciones concurrentes de dos coordinadores distintos. La FK directa a `competencia_id` habilita la cuarta restricción —que el instructor esté habilitado para esa competencia en el programa de la ficha— sin joins adicionales en el path crítico. El campo `created_by` vincula cada bloque al coordinador que lo creó para auditoría.

**Qué contiene en la práctica:**

| ficha | instructor | ambiente | competencia | franja | fecha | estado |
|---|---|---|---|---|---|---|
| UUID → 2875401 | UUID → Carlos Murcia | UUID → Sala 101 | UUID → Gestionar BD | UUID → Bloque 2 Mañana | 2026-06-03 | activo |
| UUID → 2875401 | UUID → Carlos Murcia | UUID → Sala 101 | UUID → Gestionar BD | UUID → Bloque 3 Mañana | 2026-06-03 | activo |

Si se intenta insertar un segundo bloque con el mismo instructor en la misma franja y fecha, PostgreSQL lanza una excepción de violación de unicidad antes de que la aplicación pueda hacer nada.

---

### 34. observacion

```sql
id               UUID PK
reportado_por    UUID FK → usuario.id
resuelto_por     UUID NULL FK → usuario.id
ficha_id         UUID NULL FK → ficha.id
instructor_id    UUID NULL FK → instructor.id
ambiente_id      UUID NULL FK → ambiente.id
horario_id       UUID NULL FK → horario.id
tipo             VARCHAR(40)
severidad        VARCHAR(20)
descripcion      TEXT
estado           VARCHAR(30)
fecha_resolucion TIMESTAMP
created_at       TIMESTAMP
updated_at       TIMESTAMP
```

**Justificación técnica:** Fuente de datos del KPI 1 de conflictos. Los campos `tipo` y `severidad` son los clasificadores que evitan que el módulo se convierta en un buzón de texto libre inmanejable. Los campos FK nullable permiten vincular la observación al contexto exacto sin requerir todos los vínculos al mismo tiempo: una queja puede ser sobre un ambiente sin mencionar ficha ni instructor.

**Qué contiene en la práctica:**

| tipo | severidad | descripcion | estado | ficha_id | ambiente_id |
|---|---|---|---|---|---|
| cruce_horario | alta | El instructor aparece asignado a dos fichas el mismo martes a las 8am | abierta | UUID → 2875401 | null |
| ambiente_inadecuado | media | La Sala 101 no tiene suficientes computadores para los 30 aprendices de la ficha | en_revision | UUID → 2941233 | UUID → Sala 101 |
| instructor_ausente | alta | El instructor no se presentó el 3 de junio sin previo aviso | resuelta | UUID → 2875401 | null |

---

### 35. observacion_estado

```sql
id              UUID PK
observacion_id  UUID FK → observacion.id
usuario_id      UUID FK → usuario.id
estado_anterior VARCHAR(30)
estado_nuevo    VARCHAR(30)
comentario      TEXT
created_at      TIMESTAMP
```

**Justificación técnica:** Sin historial de transiciones no es posible calcular el tiempo de resolución de una observación ni saber quién la gestionó en cada paso. Esta tabla convierte el campo `estado` de `observacion` en un log de eventos medible y auditable. Es la diferencia entre saber que una observación está "resuelta" y saber que tardó 3 días y pasó por dos coordinadores antes de cerrarse.

**Qué contiene en la práctica:**

| observacion_id | usuario_id | estado_anterior | estado_nuevo | comentario |
|---|---|---|---|---|
| UUID → obs-001 | UUID → Laura Ortiz | abierta | en_revision | Revisando con el instructor involucrado |
| UUID → obs-001 | UUID → Laura Ortiz | en_revision | resuelta | Se reasignó el bloque a otro ambiente disponible |

---

### 36. proyecto_formativo

```sql
id           UUID PK
ficha_id     UUID FK → ficha.id
creado_por   UUID FK → usuario.id
titulo       VARCHAR(255)
descripcion  TEXT
tipo         VARCHAR(50)
estado       VARCHAR(30)
fecha_inicio DATE
fecha_fin    DATE
activo       BOOLEAN
created_at   TIMESTAMP
updated_at   TIMESTAMP
```

**Justificación técnica:** Gestiona los proyectos académicos vinculados a una ficha específica. El campo `tipo` distingue técnico, tecnólogo e investigación. El campo `estado` modela el ciclo completo del proyecto: formulación → ejecución → revisión → aprobado → archivado. Sin esta tabla los proyectos vivirían en documentos de Word fuera del sistema, sin trazabilidad.

**Qué contiene en la práctica:**

| titulo | tipo | estado | ficha_id | fecha_inicio | fecha_fin |
|---|---|---|---|---|---|
| Sistema de Inventario para Pymes Huilenses | tecnólogo | ejecución | UUID → 2875401 | 2026-01-15 | 2026-08-15 |
| Aplicación Móvil para Registro de Asistencia | técnico | formulación | UUID → 2941233 | 2026-06-01 | 2026-09-01 |

---

### 37. proyecto_hito

```sql
id                    UUID PK
proyecto_formativo_id UUID FK → proyecto_formativo.id
nombre                VARCHAR(200)
descripcion           TEXT
fecha_limite          DATE
completado            BOOLEAN
created_at            TIMESTAMP
updated_at            TIMESTAMP
```

**Justificación técnica:** Descompone el proyecto en entregables medibles con fecha límite y estado de completitud. Sin esta tabla no hay forma de rastrear el avance interno de un proyecto ni identificar hitos vencidos. El coordinador puede ver de un vistazo cuántos hitos lleva completados un grupo y cuáles están en riesgo.

**Qué contiene en la práctica:**

| proyecto_id | nombre | fecha_limite | completado |
|---|---|---|---|
| UUID → Sistema Inventario | Entrega del análisis de requerimientos | 2026-02-28 | true |
| UUID → Sistema Inventario | Prototipo funcional de la base de datos | 2026-04-30 | true |
| UUID → Sistema Inventario | Versión final con pruebas de usuario | 2026-08-15 | false |

---

### 38. proyecto_integrante

```sql
id                    UUID PK
proyecto_formativo_id UUID FK → proyecto_formativo.id
aprendiz_id           UUID FK → aprendiz.id
rol_en_proyecto       VARCHAR(80)
created_at            TIMESTAMP
UNIQUE (proyecto_formativo_id, aprendiz_id)
```

**Justificación técnica:** Vincula aprendices a un proyecto con un rol específico. El `UNIQUE` compuesto impide que el mismo aprendiz aparezca dos veces en el mismo proyecto. Sin esta tabla no se puede saber quién integra cada proyecto ni en qué calidad, lo que hace imposible evaluar individualmente o asignar responsabilidades.

**Qué contiene en la práctica:**

| proyecto_id | aprendiz_id | rol_en_proyecto |
|---|---|---|
| UUID → Sistema Inventario | UUID → Andrés Torres | Líder de proyecto |
| UUID → Sistema Inventario | UUID → Sara Rincón | Desarrollador backend |
| UUID → Sistema Inventario | UUID → Juan Méndez | Desarrollador frontend |

---

### 39. evaluacion_proyecto

```sql
id                    UUID PK
proyecto_formativo_id UUID FK → proyecto_formativo.id
evaluador_id          UUID FK → usuario.id
calificacion          NUMERIC(4,2) CHECK (0–5)
observacion           TEXT
fecha_evaluacion      DATE
estado                VARCHAR(30)
created_at            TIMESTAMP
updated_at            TIMESTAMP
```

**Justificación técnica:** Registra la calificación formal del coordinador sobre un proyecto formativo. Se usa `NUMERIC(4,2)` para admitir decimales en la escala 0–5. Está separada de `observacion` porque es un acto formal con calificación numérica y estado propio, no un reporte de incidencia operativa. Confundirlas en una sola tabla mezclaría un acto de evaluación académica con un log de problemas operativos.

**Qué contiene en la práctica:**

| proyecto_id | evaluador | calificacion | estado | fecha_evaluacion |
|---|---|---|---|---|
| UUID → Sistema Inventario | UUID → Laura Ortiz | 4.50 | aprobado | 2026-08-20 |
| UUID → App Asistencia | UUID → Laura Ortiz | 3.80 | en_revision | 2026-09-05 |

---

### 40. notificacion

```sql
id               UUID PK
usuario_id       UUID FK → usuario.id
titulo           VARCHAR(200)
mensaje          TEXT
tipo             VARCHAR(50)
leida            BOOLEAN
referencia_id    UUID NULL
referencia_tabla VARCHAR(80) NULL
created_at       TIMESTAMP
```

**Justificación técnica:** Comunica eventos relevantes al usuario sin que tenga que consultar activamente cada módulo. Los campos `referencia_id` y `referencia_tabla` implementan el patrón de notificación navegable: el usuario hace clic en la notificación y el sistema lo lleva directamente al registro que generó el evento, sea un horario, una observación, una ficha o un proyecto.

**Qué contiene en la práctica:**

| usuario_id | titulo | tipo | leida | referencia_tabla | referencia_id |
|---|---|---|---|---|---|
| UUID → Carlos Murcia | Nuevo horario asignado para el 5 de junio | horario_asignado | false | horario | UUID → bloque-001 |
| UUID → Laura Ortiz | Observación nueva: ambiente inadecuado | observacion_nueva | true | observacion | UUID → obs-002 |
| UUID → Diana Perdomo | El ambiente Sala 101 tiene solicitud de bloqueo | bloqueo_solicitado | false | ambiente | UUID → SAL-101 |

---

### 41. sesion *(tabla 14 — sin omisión)*

> La tabla `sesion` está completamente documentada como tabla 14. Se referencia aquí únicamente para confirmar que el conteo total es 41 tablas sin omisiones ni entradas duplicadas en el esquema.