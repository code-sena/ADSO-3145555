# Base de Datos - Modulo de Seguridad

**Enfoque:** diseno logico y profesional de la base de datos necesaria para el modulo de seguridad del sistema.  
**Alcance:** solo seguridad y las dependencias minimas con otros modulos del proyecto.

---

## 1. Proposito

La base de datos del modulo de seguridad debe permitir controlar:

- identidad de usuarios;
- credenciales;
- roles;
- permisos;
- sesiones;
- tokens;
- MFA;
- auditoria;
- acceso por sede;
- trazabilidad de acciones criticas.

El objetivo no es almacenar la informacion operativa de horarios, proyectos o ambientes, sino proteger el acceso a esos modulos.

Idea central:

```text
El modulo de seguridad no administra el negocio academico.
Administra quien puede acceder, que puede hacer y sobre que sede puede operar.
```

---

## 2. Modulos del sistema y dependencia con seguridad

Segun la organizacion modular del proyecto, el modulo de seguridad se relaciona con varios modulos, pero no depende de todos de la misma forma.

| Modulo | Relacion con seguridad | Tipo de dependencia |
|---|---|---|
| 1. Seguridad y Acceso | Es el modulo principal. Contiene usuarios, roles, permisos, sesiones, MFA y auditoria. | Directa |
| 2. Estructura Institucional | Seguridad necesita regionales, centros y sedes para aplicar multi-tenant. | Directa |
| 3. Infraestructura | Seguridad valida permisos sobre ambientes, pero no administra inventario. | Indirecta |
| 4. Parametrizacion | Seguridad puede usar parametros de politicas, estados y catalogos base. | Directa parcial |
| 5. Programas de Formacion | Seguridad puede filtrar acceso academico, pero no gestiona competencias ni disenos. | Indirecta |
| 6. Oferta y Programas | Seguridad valida acceso a fichas y aprendices por sede o rol. | Indirecta |
| 7. Actores | Seguridad se relaciona con instructores, aprendices y directivos como perfiles asociados a usuarios. | Directa parcial |
| 8. Horarios | Seguridad controla quien crea, consulta, modifica o elimina horarios. | Indirecta |
| 9. Proyectos Formativos | Seguridad controla quien consulta, registra avance, evalua o cierra proyectos. | Indirecta |
| 10. Coordinacion y Eventos | Seguridad audita acciones de coordinacion y controla acceso a eventos. | Indirecta |

Conclusion:

```text
Para crear la base de datos de seguridad son indispensables:
Seguridad y Acceso + Estructura Institucional + parte de Parametrizacion + relacion con Actores.
```

Los demas modulos deben ser protegidos por seguridad, pero no deben vivir dentro de la base de datos de seguridad.

---

## 3. Separacion correcta de responsabilidades

La base de datos de seguridad debe guardar:

- usuarios;
- credenciales;
- roles;
- permisos;
- sesiones;
- tokens;
- MFA;
- auditoria;
- relacion usuario-sede;
- relacion usuario-rol.

No debe guardar:

- horarios;
- ambientes;
- inventario;
- fichas;
- competencias;
- proyectos formativos;
- observaciones academicas;
- eventos de coordinacion como entidad principal.

Separacion recomendada:

```text
SECURITY_DB
  -> identidad, acceso, sesiones, roles, permisos, auditoria

ACADEMIC_DB / SCHEDULE_DB / PROJECT_DB
  -> reglas de negocio academicas y operativas
```

---

## 4. Entidades principales del modulo de seguridad

### 4.1 usuario

Representa la identidad base de una persona que puede acceder al sistema.

Campos sugeridos:

```sql
usuario (
  id UUID PRIMARY KEY,
  documento VARCHAR(30) UNIQUE NOT NULL,
  nombres VARCHAR(120) NOT NULL,
  apellidos VARCHAR(120) NOT NULL,
  correo VARCHAR(180) UNIQUE NOT NULL,
  username VARCHAR(80) UNIQUE,
  estado VARCHAR(30) NOT NULL,
  tipo_usuario VARCHAR(40) NOT NULL,
  sede_principal_id UUID NULL,
  created_at TIMESTAMP NOT NULL,
  updated_at TIMESTAMP NOT NULL
)
```

Justificacion:

- centraliza identidad;
- evita duplicar datos personales en instructores, aprendices o directivos;
- permite activar, inactivar o bloquear cuentas;
- sirve como base para auditoria y trazabilidad.

`sede_principal_id` referencia a `sede`, pero un usuario puede tener varias sedes mediante `usuario_sede`.

---

### 4.2 credencial

Guarda datos sensibles de autenticacion.

```sql
credencial (
  id UUID PRIMARY KEY,
  usuario_id UUID NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  algoritmo_hash VARCHAR(40) NOT NULL,
  intentos_fallidos INTEGER NOT NULL DEFAULT 0,
  bloqueado_hasta TIMESTAMP NULL,
  requiere_cambio BOOLEAN NOT NULL DEFAULT false,
  fecha_ultimo_cambio TIMESTAMP NULL,
  created_at TIMESTAMP NOT NULL,
  updated_at TIMESTAMP NOT NULL
)
```

Justificacion:

- separa identidad de credenciales;
- nunca almacena contrasenas en texto plano;
- permite bloquear cuentas por intentos fallidos;
- permite forzar cambio de contrasena.

Regla:

```text
La contrasena real nunca se guarda. Solo se guarda su hash.
```

---

### 4.3 rol

Define perfiles de acceso.

```sql
rol (
  id UUID PRIMARY KEY,
  codigo VARCHAR(80) UNIQUE NOT NULL,
  nombre VARCHAR(120) NOT NULL,
  descripcion TEXT,
  es_critico BOOLEAN NOT NULL DEFAULT false,
  activo BOOLEAN NOT NULL DEFAULT true,
  created_at TIMESTAMP NOT NULL,
  updated_at TIMESTAMP NOT NULL
)
```

Ejemplos:

- `ADMINISTRADOR`;
- `COORDINADOR_ACADEMICO`;
- `INSTRUCTOR`;
- `APRENDIZ`;
- `AUDITOR`.

Justificacion:

- permite agrupar permisos;
- evita validar accesos por texto libre;
- permite identificar roles criticos para MFA.

---

### 4.4 permiso

Define acciones granulares.

```sql
permiso (
  id UUID PRIMARY KEY,
  codigo VARCHAR(100) UNIQUE NOT NULL,
  modulo VARCHAR(80) NOT NULL,
  descripcion TEXT,
  activo BOOLEAN NOT NULL DEFAULT true,
  created_at TIMESTAMP NOT NULL,
  updated_at TIMESTAMP NOT NULL
)
```

Ejemplos:

| Modulo | Permisos |
|---|---|
| Seguridad | `USUARIOS_ADMIN`, `ROLES_ADMIN`, `PERMISOS_ADMIN`, `AUDITORIA_READ` |
| Horarios | `HORARIOS_READ`, `HORARIOS_CREATE`, `HORARIOS_UPDATE`, `HORARIOS_DELETE` |
| Proyectos | `PROYECTOS_READ`, `PROYECTOS_CREATE`, `PROYECTOS_UPDATE`, `PROYECTOS_EVALUATE` |
| Ambientes | `AMBIENTES_READ`, `AMBIENTES_UPDATE` |
| Fichas | `FICHAS_READ`, `FICHAS_UPDATE` |

Justificacion:

- permite control fino;
- evita depender solo del nombre del rol;
- facilita cambios sin modificar codigo.

---

### 4.5 rol_permiso

Relaciona roles con permisos.

```sql
rol_permiso (
  id UUID PRIMARY KEY,
  rol_id UUID NOT NULL,
  permiso_id UUID NOT NULL,
  asignado_por UUID NULL,
  created_at TIMESTAMP NOT NULL,
  UNIQUE (rol_id, permiso_id)
)
```

Justificacion:

- resuelve relacion muchos a muchos;
- impide permisos duplicados en el mismo rol;
- permite auditar quien asigno el permiso.

---

### 4.6 usuario_rol

Relaciona usuarios con roles.

```sql
usuario_rol (
  id UUID PRIMARY KEY,
  usuario_id UUID NOT NULL,
  rol_id UUID NOT NULL,
  sede_id UUID NULL,
  activo BOOLEAN NOT NULL DEFAULT true,
  asignado_por UUID NULL,
  fecha_asignacion TIMESTAMP NOT NULL,
  fecha_fin TIMESTAMP NULL,
  UNIQUE (usuario_id, rol_id, sede_id)
)
```

Justificacion:

- un usuario puede tener varios roles;
- un rol puede aplicar solo en una sede;
- permite historico de asignaciones;
- facilita multi-tenant por sede.

Ejemplo:

```text
Laura puede ser Coordinadora en Sede Principal,
pero solo Auditora de consulta en otra sede.
```

---

## 5. Entidades para multi-tenant institucional

El multi-tenant se basa en la estructura:

```text
regional -> centro_formacion -> sede
```

Estas entidades pueden pertenecer a una base institucional compartida. Seguridad las necesita como referencia para restringir acceso.

### 5.1 regional

```sql
regional (
  id UUID PRIMARY KEY,
  codigo VARCHAR(30) UNIQUE NOT NULL,
  nombre VARCHAR(150) NOT NULL,
  activo BOOLEAN NOT NULL DEFAULT true
)
```

### 5.2 centro_formacion

```sql
centro_formacion (
  id UUID PRIMARY KEY,
  regional_id UUID NOT NULL,
  codigo VARCHAR(30) UNIQUE NOT NULL,
  nombre VARCHAR(180) NOT NULL,
  activo BOOLEAN NOT NULL DEFAULT true
)
```

### 5.3 sede

```sql
sede (
  id UUID PRIMARY KEY,
  centro_formacion_id UUID NOT NULL,
  nombre VARCHAR(180) NOT NULL,
  ciudad VARCHAR(100),
  direccion VARCHAR(255),
  activo BOOLEAN NOT NULL DEFAULT true
)
```

### 5.4 usuario_sede

Define a que sedes puede acceder un usuario.

```sql
usuario_sede (
  id UUID PRIMARY KEY,
  usuario_id UUID NOT NULL,
  sede_id UUID NOT NULL,
  es_principal BOOLEAN NOT NULL DEFAULT false,
  activo BOOLEAN NOT NULL DEFAULT true,
  asignado_por UUID NULL,
  fecha_asignacion TIMESTAMP NOT NULL,
  UNIQUE (usuario_id, sede_id)
)
```

Justificacion:

- evita que un usuario opere sobre sedes no autorizadas;
- permite usuarios con multiples sedes;
- soporta seleccion de sede activa en login;
- protege horarios, fichas, ambientes y proyectos.

---

## 6. Entidades para sesiones y tokens

### 6.1 sesion

```sql
sesion (
  id UUID PRIMARY KEY,
  usuario_id UUID NOT NULL,
  sede_activa_id UUID NULL,
  ip_origen VARCHAR(45),
  user_agent TEXT,
  estado VARCHAR(30) NOT NULL,
  fecha_inicio TIMESTAMP NOT NULL,
  fecha_fin TIMESTAMP NULL,
  revocada BOOLEAN NOT NULL DEFAULT false,
  motivo_revocacion TEXT NULL
)
```

Justificacion:

- permite ver sesiones activas;
- permite cerrar sesiones especificas;
- permite revocar accesos ante cambios de seguridad;
- relaciona una sesion con sede activa.

---

### 6.2 refresh_token

```sql
refresh_token (
  id UUID PRIMARY KEY,
  usuario_id UUID NOT NULL,
  sesion_id UUID NOT NULL,
  token_hash VARCHAR(255) NOT NULL,
  fecha_emision TIMESTAMP NOT NULL,
  fecha_expiracion TIMESTAMP NOT NULL,
  revocado BOOLEAN NOT NULL DEFAULT false,
  fecha_revocacion TIMESTAMP NULL,
  reemplazado_por UUID NULL
)
```

Justificacion:

- permite renovar JWT sin pedir credenciales;
- se almacena como hash;
- puede revocarse en logout;
- permite rotacion de tokens.

---

## 7. Entidades para MFA

### 7.1 mfa_configuracion

```sql
mfa_configuracion (
  id UUID PRIMARY KEY,
  usuario_id UUID NOT NULL,
  tipo_mfa VARCHAR(40) NOT NULL,
  activo BOOLEAN NOT NULL DEFAULT false,
  secreto_hash VARCHAR(255) NULL,
  requerido_por_rol BOOLEAN NOT NULL DEFAULT false,
  fecha_activacion TIMESTAMP NULL,
  ultimo_uso TIMESTAMP NULL
)
```

### 7.2 mfa_codigo_recuperacion

```sql
mfa_codigo_recuperacion (
  id UUID PRIMARY KEY,
  usuario_id UUID NOT NULL,
  codigo_hash VARCHAR(255) NOT NULL,
  usado BOOLEAN NOT NULL DEFAULT false,
  fecha_uso TIMESTAMP NULL,
  created_at TIMESTAMP NOT NULL
)
```

Justificacion:

- MFA protege roles criticos;
- los codigos nunca deben guardarse en texto plano;
- permite recuperacion controlada de cuenta.

---

## 8. Entidad de auditoria

### auditoria_seguridad

```sql
auditoria_seguridad (
  id UUID PRIMARY KEY,
  usuario_id UUID NULL,
  usuario_documento VARCHAR(30) NULL,
  usuario_nombre VARCHAR(180) NULL,
  usuario_rol VARCHAR(120) NULL,
  sede_id UUID NULL,
  accion VARCHAR(80) NOT NULL,
  resultado VARCHAR(30) NOT NULL,
  modulo VARCHAR(80) NOT NULL,
  entidad VARCHAR(80) NULL,
  registro_id UUID NULL,
  datos_anteriores JSONB NULL,
  datos_nuevos JSONB NULL,
  ip_origen VARCHAR(45),
  user_agent TEXT,
  fecha_evento TIMESTAMP NOT NULL
)
```

Justificacion:

- registra eventos criticos;
- conserva snapshot del usuario aunque cambie despues;
- permite trazabilidad;
- soporta auditorias internas y externas;
- no debe editarse ni eliminarse desde la aplicacion.

Eventos minimos:

- `LOGIN_SUCCESS`;
- `LOGIN_FAILED`;
- `LOGOUT`;
- `ACCESS_DENIED`;
- `ROLE_ASSIGNED`;
- `PERMISSION_ASSIGNED`;
- `TOKEN_REVOKED`;
- `MFA_SUCCESS`;
- `MFA_FAILED`;
- `HORARIO_CREATED`;
- `PROYECTO_UPDATED`.

---

## 9. Relacion con Actores

El modulo de Actores contiene perfiles como:

- instructores;
- aprendices;
- directivos.

Seguridad no debe duplicar esos perfiles. La relacion recomendada es:

```text
usuario 1 -> 0..1 instructor
usuario 1 -> 0..1 aprendiz
usuario 1 -> 0..1 directivo
```

Ejemplo:

```text
usuario guarda identidad y acceso.
instructor guarda datos academicos del instructor.
aprendiz guarda datos academicos del aprendiz.
```

Esto evita duplicar documento, correo, nombres y credenciales.

---

## 10. Dependencias minimas para crear la base de seguridad

Orden recomendado:

1. `regional`
2. `centro_formacion`
3. `sede`
4. `usuario`
5. `credencial`
6. `rol`
7. `permiso`
8. `rol_permiso`
9. `usuario_sede`
10. `usuario_rol`
11. `sesion`
12. `refresh_token`
13. `mfa_configuracion`
14. `mfa_codigo_recuperacion`
15. `auditoria_seguridad`

Este orden evita problemas de claves foraneas.

---

## 11. Reglas de integridad recomendadas

- `usuario.correo` debe ser unico.
- `usuario.documento` debe ser unico.
- `rol.codigo` debe ser unico.
- `permiso.codigo` debe ser unico.
- `rol_permiso` no debe permitir duplicados.
- `usuario_sede` no debe repetir usuario y sede.
- `usuario_rol` no debe repetir usuario, rol y sede.
- `refresh_token.token_hash` debe guardarse como hash.
- `auditoria_seguridad` no debe actualizarse desde la aplicacion.
- todo usuario debe tener al menos una sede activa para operar.

---

## 12. Indices recomendados

```sql
CREATE INDEX idx_usuario_estado ON usuario (estado);
CREATE INDEX idx_usuario_correo ON usuario (correo);
CREATE INDEX idx_usuario_sede_usuario ON usuario_sede (usuario_id);
CREATE INDEX idx_usuario_sede_sede ON usuario_sede (sede_id);
CREATE INDEX idx_usuario_rol_usuario ON usuario_rol (usuario_id);
CREATE INDEX idx_rol_permiso_rol ON rol_permiso (rol_id);
CREATE INDEX idx_sesion_usuario_estado ON sesion (usuario_id, estado);
CREATE INDEX idx_refresh_sesion ON refresh_token (sesion_id);
CREATE INDEX idx_auditoria_usuario ON auditoria_seguridad (usuario_id);
CREATE INDEX idx_auditoria_fecha ON auditoria_seguridad (fecha_evento);
CREATE INDEX idx_auditoria_modulo ON auditoria_seguridad (modulo);
```

Justificacion:

- mejora login;
- acelera validacion de permisos;
- facilita consulta de sesiones;
- mejora busqueda de auditoria.

---

## 13. Criterios de aceptacion de la base de seguridad

La base de datos esta correctamente planteada si permite:

- crear usuarios sin duplicar documento o correo;
- asignar varios roles a un usuario;
- asignar roles por sede;
- limitar datos por sede activa;
- guardar credenciales seguras;
- bloquear cuentas por intentos fallidos;
- revocar sesiones;
- revocar refresh tokens;
- consultar auditoria por usuario, sede, modulo y fecha;
- proteger acciones de horarios, proyectos, ambientes y fichas sin mezclar sus datos en seguridad.

---

## 14. Conclusion

La base de datos del modulo de seguridad debe ser el nucleo de identidad, acceso y trazabilidad del sistema. Su diseno depende directamente de la estructura institucional y parcialmente del modulo de actores, pero no debe absorber la logica de horarios, proyectos, ambientes o programas.

El enfoque correcto es:

```text
Seguridad decide quien puede hacer algo.
Cada modulo decide como se ejecuta su propia regla de negocio.
```

Con esta separacion, el sistema queda mas ordenado, auditable, escalable y preparado para operar por regional, centro de formacion y sede.
