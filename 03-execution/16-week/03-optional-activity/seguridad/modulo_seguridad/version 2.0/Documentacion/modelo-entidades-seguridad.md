# Modelo de Entidades y Atributos - Modulo de Seguridad

**Objetivo:** definir las entidades, atributos, relaciones y reglas de integridad necesarias para construir la base de datos del modulo de seguridad.  
**Alcance:** autenticacion, autorizacion, roles, permisos, sesiones, tokens, MFA, auditoria y multi-tenant institucional por sede.

---

## 1. Criterio de diseno

El modelo de seguridad debe responder tres preguntas centrales:

```text
1. Quien es el usuario?
2. Que puede hacer?
3. En que sede puede hacerlo?
```

Por eso la base de datos no debe limitarse a una tabla de usuarios. Debe separar identidad, credenciales, roles, permisos, sedes, sesiones y auditoria.

Principios aplicados:

- separar identidad de credenciales;
- no guardar contrasenas en texto plano;
- usar roles y permisos para autorizacion flexible;
- permitir multiples roles por usuario;
- permitir acceso por una o varias sedes;
- registrar eventos criticos en auditoria;
- permitir revocacion de sesiones y tokens;
- evitar que seguridad almacene datos propios de horarios, proyectos o ambientes.

---

## 2. Mapa general de entidades

```text
regional
   |
   v
centro_formacion
   |
   v
sede
   |
   +------------------+
                      |
usuario ---- usuario_sede
   |
   +---- credencial
   |
   +---- usuario_rol ---- rol ---- rol_permiso ---- permiso
   |
   +---- sesion ---- refresh_token
   |
   +---- mfa_configuracion
   |
   +---- mfa_codigo_recuperacion
   |
   +---- auditoria_seguridad
```

Este modelo permite controlar usuarios y permisos sin duplicar datos academicos de otros modulos.

---

## 3. Entidad `regional`

Representa el nivel institucional mas alto.

| Atributo | Tipo sugerido | Restriccion | Descripcion |
|---|---|---|---|
| `id` | UUID | PK | Identificador unico. |
| `codigo` | VARCHAR(30) | UNIQUE, NOT NULL | Codigo institucional de la regional. |
| `nombre` | VARCHAR(150) | NOT NULL | Nombre de la regional. |
| `activo` | BOOLEAN | NOT NULL, DEFAULT true | Permite desactivar sin eliminar. |
| `created_at` | TIMESTAMP | NOT NULL | Fecha de creacion. |
| `updated_at` | TIMESTAMP | NOT NULL | Fecha de actualizacion. |

Justificacion:

La regional permite escalar el sistema y generar reportes institucionales. Seguridad la necesita porque el acceso puede estar limitado por regional, centro o sede.

---

## 4. Entidad `centro_formacion`

Representa un centro perteneciente a una regional.

| Atributo | Tipo sugerido | Restriccion | Descripcion |
|---|---|---|---|
| `id` | UUID | PK | Identificador unico. |
| `regional_id` | UUID | FK, NOT NULL | Regional a la que pertenece. |
| `codigo` | VARCHAR(30) | UNIQUE, NOT NULL | Codigo institucional del centro. |
| `nombre` | VARCHAR(180) | NOT NULL | Nombre del centro. |
| `activo` | BOOLEAN | NOT NULL, DEFAULT true | Estado del centro. |
| `created_at` | TIMESTAMP | NOT NULL | Fecha de creacion. |
| `updated_at` | TIMESTAMP | NOT NULL | Fecha de actualizacion. |

Justificacion:

Un centro de formacion puede tener varias sedes. Separarlo evita mezclar ubicaciones fisicas con unidades administrativas.

---

## 5. Entidad `sede`

Representa la unidad principal de aislamiento operativo.

| Atributo | Tipo sugerido | Restriccion | Descripcion |
|---|---|---|---|
| `id` | UUID | PK | Identificador unico. |
| `centro_formacion_id` | UUID | FK, NOT NULL | Centro al que pertenece. |
| `nombre` | VARCHAR(180) | NOT NULL | Nombre de la sede. |
| `ciudad` | VARCHAR(100) | NULL | Ciudad de ubicacion. |
| `direccion` | VARCHAR(255) | NULL | Direccion fisica. |
| `activo` | BOOLEAN | NOT NULL, DEFAULT true | Estado de la sede. |
| `created_at` | TIMESTAMP | NOT NULL | Fecha de creacion. |
| `updated_at` | TIMESTAMP | NOT NULL | Fecha de actualizacion. |

Justificacion:

La sede es critica para el multi-tenant. Horarios, fichas, ambientes, instructores y aprendices deben filtrarse por sede. Seguridad usa esta entidad para decidir el alcance de cada usuario.

---

## 6. Entidad `usuario`

Representa la identidad principal de acceso al sistema.

| Atributo | Tipo sugerido | Restriccion | Descripcion |
|---|---|---|---|
| `id` | UUID | PK | Identificador unico del usuario. |
| `documento` | VARCHAR(30) | UNIQUE, NOT NULL | Documento de identidad. |
| `nombres` | VARCHAR(120) | NOT NULL | Nombres del usuario. |
| `apellidos` | VARCHAR(120) | NOT NULL | Apellidos del usuario. |
| `correo` | VARCHAR(180) | UNIQUE, NOT NULL | Correo institucional. |
| `username` | VARCHAR(80) | UNIQUE, NULL | Nombre de usuario opcional. |
| `estado` | VARCHAR(30) | NOT NULL | Estado: activo, inactivo, bloqueado, pendiente. |
| `tipo_usuario` | VARCHAR(40) | NOT NULL | Tipo: admin, coordinador, instructor, aprendiz, auditor. |
| `sede_principal_id` | UUID | FK, NULL | Sede principal del usuario. |
| `created_at` | TIMESTAMP | NOT NULL | Fecha de creacion. |
| `updated_at` | TIMESTAMP | NOT NULL | Fecha de actualizacion. |

Estados sugeridos:

| Estado | Significado |
|---|---|
| `ACTIVO` | Puede iniciar sesion. |
| `INACTIVO` | No puede acceder, pero conserva historial. |
| `BLOQUEADO` | Bloqueado por seguridad o administracion. |
| `PENDIENTE` | Cuenta creada pero no habilitada completamente. |

Justificacion:

`usuario` no debe guardar la contrasena. Solo contiene identidad y estado de cuenta. Las credenciales se separan para mejorar seguridad y mantenimiento.

---

## 7. Entidad `credencial`

Almacena los datos de autenticacion del usuario.

| Atributo | Tipo sugerido | Restriccion | Descripcion |
|---|---|---|---|
| `id` | UUID | PK | Identificador unico. |
| `usuario_id` | UUID | FK, UNIQUE, NOT NULL | Usuario propietario de la credencial. |
| `password_hash` | VARCHAR(255) | NOT NULL | Hash de la contrasena. |
| `algoritmo_hash` | VARCHAR(40) | NOT NULL | Algoritmo usado: Argon2id, bcrypt o PBKDF2. |
| `intentos_fallidos` | INTEGER | NOT NULL, DEFAULT 0 | Intentos fallidos acumulados. |
| `bloqueado_hasta` | TIMESTAMP | NULL | Fecha hasta la que la cuenta esta bloqueada. |
| `requiere_cambio` | BOOLEAN | NOT NULL, DEFAULT false | Obliga cambio de contrasena. |
| `fecha_ultimo_cambio` | TIMESTAMP | NULL | Ultimo cambio de contrasena. |
| `created_at` | TIMESTAMP | NOT NULL | Fecha de creacion. |
| `updated_at` | TIMESTAMP | NOT NULL | Fecha de actualizacion. |

Reglas:

- nunca guardar contrasena en texto plano;
- bloquear temporalmente tras varios intentos fallidos;
- reiniciar `intentos_fallidos` tras login exitoso;
- marcar `requiere_cambio` para contrasenas temporales.

---

## 8. Entidad `rol`

Agrupa permisos bajo un perfil funcional.

| Atributo | Tipo sugerido | Restriccion | Descripcion |
|---|---|---|---|
| `id` | UUID | PK | Identificador unico. |
| `codigo` | VARCHAR(80) | UNIQUE, NOT NULL | Codigo interno del rol. |
| `nombre` | VARCHAR(120) | NOT NULL | Nombre visible. |
| `descripcion` | TEXT | NULL | Explicacion del rol. |
| `es_critico` | BOOLEAN | NOT NULL, DEFAULT false | Indica si requiere MFA. |
| `activo` | BOOLEAN | NOT NULL, DEFAULT true | Estado del rol. |
| `created_at` | TIMESTAMP | NOT NULL | Fecha de creacion. |
| `updated_at` | TIMESTAMP | NOT NULL | Fecha de actualizacion. |

Roles base:

| Codigo | Uso |
|---|---|
| `ADMINISTRADOR` | Gestion total del sistema. |
| `COORDINADOR_ACADEMICO` | Gestion de horarios y fichas de su sede. |
| `INSTRUCTOR` | Consulta horarios y registra novedades o avances. |
| `APRENDIZ` | Consulta informacion propia. |
| `AUDITOR` | Consulta trazabilidad sin modificar datos. |

---

## 9. Entidad `permiso`

Define acciones atomicas del sistema.

| Atributo | Tipo sugerido | Restriccion | Descripcion |
|---|---|---|---|
| `id` | UUID | PK | Identificador unico. |
| `codigo` | VARCHAR(100) | UNIQUE, NOT NULL | Codigo del permiso. |
| `modulo` | VARCHAR(80) | NOT NULL | Modulo al que pertenece. |
| `descripcion` | TEXT | NULL | Explicacion del permiso. |
| `activo` | BOOLEAN | NOT NULL, DEFAULT true | Estado del permiso. |
| `created_at` | TIMESTAMP | NOT NULL | Fecha de creacion. |
| `updated_at` | TIMESTAMP | NOT NULL | Fecha de actualizacion. |

Ejemplos:

| Codigo | Modulo |
|---|---|
| `USUARIOS_ADMIN` | Seguridad |
| `ROLES_ADMIN` | Seguridad |
| `PERMISOS_ADMIN` | Seguridad |
| `AUDITORIA_READ` | Seguridad |
| `HORARIOS_CREATE` | Horarios |
| `HORARIOS_UPDATE` | Horarios |
| `PROYECTOS_EVALUATE` | Proyectos |

Justificacion:

Los permisos hacen que el sistema no dependa de validaciones duras como "si rol es coordinador". Permiten cambiar reglas sin modificar la logica principal.

---

## 10. Entidad `rol_permiso`

Relacion muchos a muchos entre roles y permisos.

| Atributo | Tipo sugerido | Restriccion | Descripcion |
|---|---|---|---|
| `id` | UUID | PK | Identificador unico. |
| `rol_id` | UUID | FK, NOT NULL | Rol asignado. |
| `permiso_id` | UUID | FK, NOT NULL | Permiso asignado. |
| `asignado_por` | UUID | FK, NULL | Usuario que asigno el permiso. |
| `created_at` | TIMESTAMP | NOT NULL | Fecha de asignacion. |

Restriccion:

```text
UNIQUE (rol_id, permiso_id)
```

Justificacion:

Impide duplicidad y permite administrar permisos por rol de forma limpia.

---

## 11. Entidad `usuario_rol`

Asigna roles a usuarios, opcionalmente por sede.

| Atributo | Tipo sugerido | Restriccion | Descripcion |
|---|---|---|---|
| `id` | UUID | PK | Identificador unico. |
| `usuario_id` | UUID | FK, NOT NULL | Usuario asignado. |
| `rol_id` | UUID | FK, NOT NULL | Rol asignado. |
| `sede_id` | UUID | FK, NULL | Sede donde aplica el rol. |
| `activo` | BOOLEAN | NOT NULL, DEFAULT true | Estado de la asignacion. |
| `asignado_por` | UUID | FK, NULL | Usuario que realizo la asignacion. |
| `fecha_asignacion` | TIMESTAMP | NOT NULL | Fecha de asignacion. |
| `fecha_fin` | TIMESTAMP | NULL | Fecha de cierre de asignacion. |

Restriccion:

```text
UNIQUE (usuario_id, rol_id, sede_id)
```

Justificacion:

Un usuario puede tener roles diferentes por sede. Esto es clave para multi-tenant institucional.

---

## 12. Entidad `usuario_sede`

Define las sedes donde un usuario puede operar.

| Atributo | Tipo sugerido | Restriccion | Descripcion |
|---|---|---|---|
| `id` | UUID | PK | Identificador unico. |
| `usuario_id` | UUID | FK, NOT NULL | Usuario autorizado. |
| `sede_id` | UUID | FK, NOT NULL | Sede autorizada. |
| `es_principal` | BOOLEAN | NOT NULL, DEFAULT false | Indica sede principal. |
| `activo` | BOOLEAN | NOT NULL, DEFAULT true | Estado de la relacion. |
| `asignado_por` | UUID | FK, NULL | Usuario que asigno sede. |
| `fecha_asignacion` | TIMESTAMP | NOT NULL | Fecha de asignacion. |

Restriccion:

```text
UNIQUE (usuario_id, sede_id)
```

Regla:

```text
Todo usuario operativo debe tener al menos una sede activa.
```

---

## 13. Entidad `sesion`

Registra sesiones activas o historicas.

| Atributo | Tipo sugerido | Restriccion | Descripcion |
|---|---|---|---|
| `id` | UUID | PK | Identificador unico. |
| `usuario_id` | UUID | FK, NOT NULL | Usuario de la sesion. |
| `sede_activa_id` | UUID | FK, NULL | Sede seleccionada para operar. |
| `ip_origen` | VARCHAR(45) | NULL | IP de origen. |
| `user_agent` | TEXT | NULL | Navegador o dispositivo. |
| `estado` | VARCHAR(30) | NOT NULL | Activa, cerrada, expirada o revocada. |
| `fecha_inicio` | TIMESTAMP | NOT NULL | Inicio de sesion. |
| `fecha_fin` | TIMESTAMP | NULL | Fin de sesion. |
| `revocada` | BOOLEAN | NOT NULL, DEFAULT false | Marca de revocacion. |
| `motivo_revocacion` | TEXT | NULL | Motivo de revocacion. |

Justificacion:

Permite consultar sesiones activas, cerrar sesiones y revocar accesos despues de cambios sensibles.

---

## 14. Entidad `refresh_token`

Controla renovacion de acceso.

| Atributo | Tipo sugerido | Restriccion | Descripcion |
|---|---|---|---|
| `id` | UUID | PK | Identificador unico. |
| `usuario_id` | UUID | FK, NOT NULL | Usuario propietario. |
| `sesion_id` | UUID | FK, NOT NULL | Sesion asociada. |
| `token_hash` | VARCHAR(255) | NOT NULL | Hash del refresh token. |
| `fecha_emision` | TIMESTAMP | NOT NULL | Fecha de emision. |
| `fecha_expiracion` | TIMESTAMP | NOT NULL | Fecha de vencimiento. |
| `revocado` | BOOLEAN | NOT NULL, DEFAULT false | Marca de revocacion. |
| `fecha_revocacion` | TIMESTAMP | NULL | Fecha de revocacion. |
| `reemplazado_por` | UUID | FK, NULL | Token que lo reemplaza. |

Reglas:

- guardar solo hash del token;
- revocar en logout;
- revocar cuando cambie rol, contrasena o estado;
- rotar en cada renovacion si se requiere mayor seguridad.

---

## 15. Entidad `mfa_configuracion`

Configura segundo factor de autenticacion.

| Atributo | Tipo sugerido | Restriccion | Descripcion |
|---|---|---|---|
| `id` | UUID | PK | Identificador unico. |
| `usuario_id` | UUID | FK, UNIQUE, NOT NULL | Usuario propietario. |
| `tipo_mfa` | VARCHAR(40) | NOT NULL | TOTP, correo u otro mecanismo. |
| `activo` | BOOLEAN | NOT NULL, DEFAULT false | Indica si MFA esta activo. |
| `secreto_hash` | VARCHAR(255) | NULL | Secreto protegido. |
| `requerido_por_rol` | BOOLEAN | NOT NULL, DEFAULT false | MFA obligatorio por rol critico. |
| `fecha_activacion` | TIMESTAMP | NULL | Fecha de activacion. |
| `ultimo_uso` | TIMESTAMP | NULL | Ultima validacion exitosa. |

Justificacion:

Permite reforzar usuarios criticos sin obligar MFA a todos los perfiles desde el inicio.

---

## 16. Entidad `mfa_codigo_recuperacion`

Permite recuperacion segura de acceso MFA.

| Atributo | Tipo sugerido | Restriccion | Descripcion |
|---|---|---|---|
| `id` | UUID | PK | Identificador unico. |
| `usuario_id` | UUID | FK, NOT NULL | Usuario propietario. |
| `codigo_hash` | VARCHAR(255) | NOT NULL | Hash del codigo de recuperacion. |
| `usado` | BOOLEAN | NOT NULL, DEFAULT false | Indica si ya fue usado. |
| `fecha_uso` | TIMESTAMP | NULL | Fecha de uso. |
| `created_at` | TIMESTAMP | NOT NULL | Fecha de creacion. |

Regla:

```text
Los codigos de recuperacion tambien deben almacenarse como hash.
```

---

## 17. Entidad `auditoria_seguridad`

Registra eventos criticos de seguridad y trazabilidad.

| Atributo | Tipo sugerido | Restriccion | Descripcion |
|---|---|---|---|
| `id` | UUID | PK | Identificador unico. |
| `usuario_id` | UUID | FK, NULL | Usuario asociado, si existe. |
| `usuario_documento` | VARCHAR(30) | NULL | Snapshot del documento. |
| `usuario_nombre` | VARCHAR(180) | NULL | Snapshot del nombre. |
| `usuario_rol` | VARCHAR(120) | NULL | Rol usado en el evento. |
| `sede_id` | UUID | FK, NULL | Sede activa del evento. |
| `accion` | VARCHAR(80) | NOT NULL | Accion realizada. |
| `resultado` | VARCHAR(30) | NOT NULL | Exitoso, fallido, denegado. |
| `modulo` | VARCHAR(80) | NOT NULL | Modulo afectado. |
| `entidad` | VARCHAR(80) | NULL | Entidad afectada. |
| `registro_id` | UUID | NULL | Registro afectado. |
| `datos_anteriores` | JSONB | NULL | Estado anterior. |
| `datos_nuevos` | JSONB | NULL | Estado nuevo. |
| `ip_origen` | VARCHAR(45) | NULL | IP de origen. |
| `user_agent` | TEXT | NULL | Dispositivo o navegador. |
| `fecha_evento` | TIMESTAMP | NOT NULL | Fecha del evento. |

Eventos sugeridos:

| Evento | Uso |
|---|---|
| `LOGIN_SUCCESS` | Login exitoso. |
| `LOGIN_FAILED` | Login fallido. |
| `LOGOUT` | Cierre de sesion. |
| `ACCESS_DENIED` | Acceso no autorizado. |
| `ROLE_ASSIGNED` | Rol asignado. |
| `PERMISSION_ASSIGNED` | Permiso asignado. |
| `TOKEN_REVOKED` | Token revocado. |
| `MFA_SUCCESS` | MFA exitoso. |
| `MFA_FAILED` | MFA fallido. |
| `HORARIO_CREATED` | Horario creado. |
| `PROYECTO_UPDATED` | Proyecto actualizado. |

Justificacion:

La auditoria debe conservar evidencia historica. Por eso guarda snapshots del usuario y no depende exclusivamente de joins actuales.

---

## 18. Relaciones principales

| Relacion | Cardinalidad | Explicacion |
|---|---|---|
| `regional` -> `centro_formacion` | 1:N | Una regional tiene varios centros. |
| `centro_formacion` -> `sede` | 1:N | Un centro tiene varias sedes. |
| `usuario` -> `credencial` | 1:1 | Cada usuario tiene una credencial activa. |
| `usuario` -> `usuario_sede` | 1:N | Un usuario puede operar en varias sedes. |
| `sede` -> `usuario_sede` | 1:N | Una sede puede tener muchos usuarios. |
| `usuario` -> `usuario_rol` | 1:N | Un usuario puede tener varios roles. |
| `rol` -> `usuario_rol` | 1:N | Un rol puede estar en varios usuarios. |
| `rol` -> `rol_permiso` | 1:N | Un rol puede tener varios permisos. |
| `permiso` -> `rol_permiso` | 1:N | Un permiso puede estar en varios roles. |
| `usuario` -> `sesion` | 1:N | Un usuario puede tener varias sesiones. |
| `sesion` -> `refresh_token` | 1:N | Una sesion puede tener tokens rotados. |
| `usuario` -> `mfa_configuracion` | 1:1 | Cada usuario puede tener configuracion MFA. |
| `usuario` -> `auditoria_seguridad` | 1:N | Un usuario puede generar muchos eventos. |

---

## 19. Orden recomendado de creacion

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

---

## 20. Reglas de negocio del modelo

- Un usuario no puede operar sin sede activa.
- Un usuario bloqueado no puede iniciar sesion.
- Un usuario sin permisos no puede ejecutar acciones protegidas.
- Un refresh token revocado no puede renovar JWT.
- Un rol critico debe exigir MFA.
- Un permiso inactivo no debe conceder acceso.
- La auditoria no debe editarse desde la aplicacion.
- Los datos de horarios, proyectos y ambientes no se guardan en seguridad; solo se auditan por referencia.

---

## 21. Indices recomendados

| Indice | Motivo |
|---|---|
| `usuario(correo)` | Login por correo. |
| `usuario(documento)` | Login o busqueda por documento. |
| `usuario(estado)` | Filtro de cuentas activas o bloqueadas. |
| `usuario_sede(usuario_id)` | Consultar sedes del usuario. |
| `usuario_sede(sede_id)` | Consultar usuarios de una sede. |
| `usuario_rol(usuario_id)` | Resolver roles del usuario. |
| `rol_permiso(rol_id)` | Resolver permisos del rol. |
| `sesion(usuario_id, estado)` | Consultar sesiones activas. |
| `refresh_token(sesion_id)` | Renovacion y revocacion de tokens. |
| `auditoria_seguridad(usuario_id)` | Auditoria por usuario. |
| `auditoria_seguridad(sede_id)` | Auditoria por sede. |
| `auditoria_seguridad(fecha_evento)` | Auditoria por fecha. |
| `auditoria_seguridad(modulo)` | Auditoria por modulo. |

---

## 22. Validaciones minimas antes de implementar

Antes de construir la base se debe confirmar:

- lista oficial de roles iniciales;
- permisos por modulo;
- estados permitidos de usuario;
- si un usuario puede tener varios roles por sede;
- si MFA sera obligatorio desde el MVP o fase posterior;
- si `regional`, `centro_formacion` y `sede` viven en seguridad o en una base institucional compartida;
- politica de expiracion de JWT y refresh token;
- reglas de retencion de auditoria.

---

## 23. Conclusion

Este modelo de entidades permite implementar una base de datos de seguridad robusta y escalable. La clave esta en separar identidad, credenciales, roles, permisos, sesiones y auditoria, mientras se integra la estructura institucional para aplicar multi-tenant por sede.

El resultado es una base capaz de proteger horarios, proyectos, fichas, ambientes y demas modulos sin mezclar la logica propia de esos dominios dentro del modulo de seguridad.
