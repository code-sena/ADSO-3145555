# Modulo de Seguridad

**Proposito:** describir que integra el modulo de seguridad, como se organiza y que responsabilidades tiene dentro del sistema.

---

## 1. Idea principal

El modulo de seguridad garantiza que cada usuario acceda solo a la informacion y acciones que le corresponden segun su identidad, rol, permisos y sede activa.

No se limita al inicio de sesion. Tambien protege microservicios, controla permisos, aplica aislamiento por sede y registra auditoria.

Idea clave:

```text
identidad + permisos + sede activa + auditoria = seguridad del sistema
```

---

## 2. Que integra

| Componente | Funcion |
|---|---|
| Autenticacion | Valida credenciales del usuario. |
| Autorizacion | Verifica roles y permisos. |
| Usuarios | Gestiona cuentas, estados y bloqueo. |
| Roles | Agrupa responsabilidades del sistema. |
| Permisos | Define acciones autorizadas por modulo. |
| JWT | Transporta identidad, permisos y sede activa. |
| Sesiones | Controla accesos activos y revocacion. |
| Multi-tenant por sede | Limita datos segun regional, centro y sede. |
| Auditoria | Registra eventos criticos y cambios. |
| MFA | Refuerza acceso para usuarios criticos. |

---

## 3. Roles principales

| Rol | Responsabilidad |
|---|---|
| Administrador | Gestiona usuarios, roles, permisos, sedes y configuracion. |
| Coordinador Academico | Programa horarios y gestiona informacion de su sede. |
| Instructor | Consulta horarios y registra novedades o avances. |
| Aprendiz | Consulta informacion propia. |
| Auditor | Consulta eventos, accesos y trazabilidad sin modificar datos. |

---

## 4. Autenticacion

Flujo:

```text
1. Usuario ingresa credenciales.
2. Security Service valida usuario y contrasena.
3. Verifica estado de la cuenta.
4. Solicita MFA si el rol es critico.
5. Genera JWT y refresh token.
6. Registra evento en auditoria.
```

Controles:

- contrasenas con hash seguro;
- errores genericos;
- bloqueo por intentos fallidos;
- MFA para administradores, auditores y coordinadores criticos;
- revocacion de sesiones ante cambios sensibles.

---

## 5. Autorizacion

Modelo:

```text
usuario -> usuario_rol -> rol -> rol_permiso -> permiso
```

Permisos base:

| Modulo | Permisos |
|---|---|
| Horarios | `HORARIOS_READ`, `HORARIOS_CREATE`, `HORARIOS_UPDATE`, `HORARIOS_DELETE` |
| Fichas | `FICHAS_READ`, `FICHAS_CREATE`, `FICHAS_UPDATE` |
| Ambientes | `AMBIENTES_READ`, `AMBIENTES_UPDATE` |
| Proyectos | `PROYECTOS_READ`, `PROYECTOS_CREATE`, `PROYECTOS_UPDATE`, `PROYECTOS_EVALUATE` |
| Usuarios | `USUARIOS_ADMIN` |
| Seguridad | `ROLES_ADMIN`, `PERMISOS_ADMIN`, `AUDITORIA_READ` |

Regla:

```text
usuario autenticado + sesion activa + permiso requerido + sede autorizada
```

---

## 6. JWT y sesiones

El JWT permite que el API Gateway y los microservicios reconozcan al usuario sin consultar credenciales en cada solicitud.

Ejemplo:

```json
{
  "sub": "coordinador@sena.edu.co",
  "rol": "coordinador_academico",
  "sede_id": "uuid-sede-principal",
  "permisos": ["HORARIOS_CREATE", "HORARIOS_READ"],
  "exp": 1684843200
}
```

Reglas:

- JWT de corta duracion;
- refresh token revocable;
- cierre de sesion invalida token de renovacion;
- cambio de rol, contrasena o estado revoca sesiones afectadas;
- el token no debe incluir datos sensibles innecesarios.

---

## 7. Multi-tenant institucional por sede

En este proyecto, el multi-tenant se adapta a la estructura del SENA:

```text
regional -> centro_formacion -> sede
```

La sede es la unidad principal de aislamiento. Un usuario solo debe operar sobre datos de sus sedes autorizadas.

Reglas:

- el JWT debe incluir `sede_id`;
- cada consulta debe filtrar por sede;
- el backend no debe confiar en el `sede_id` enviado por el cliente;
- usuarios con varias sedes deben seleccionar sede activa;
- reportes y auditoria deben respetar el alcance institucional.

---

## 8. Auditoria

La auditoria registra eventos criticos:

- inicio de sesion exitoso o fallido;
- cierre de sesion;
- cambios de contrasena;
- asignacion de roles o permisos;
- creacion o modificacion de horarios;
- cambios en proyectos;
- accesos denegados;
- revocacion de tokens.

Datos minimos:

- usuario;
- rol;
- sede;
- accion;
- fecha y hora;
- IP o dispositivo;
- resultado;
- registro afectado;
- datos anteriores y nuevos cuando aplique.

---

## 9. Relacion con otros modulos

| Modulo | Como lo protege seguridad |
|---|---|
| Horarios | Valida permiso para crear, editar, eliminar o consultar horarios. |
| Proyectos | Controla quien crea, evalua, cierra o consulta proyectos. |
| Fichas | Filtra acceso por sede y rol. |
| Ambientes | Evita cambios por usuarios no autorizados. |
| Auditoria | Permite consulta solo a roles autorizados. |

---

## 10. Frase para exposicion

El modulo de seguridad garantiza que el sistema sea confiable: identifica al usuario, valida lo que puede hacer, limita su alcance por sede y registra cada accion importante para auditoria.
