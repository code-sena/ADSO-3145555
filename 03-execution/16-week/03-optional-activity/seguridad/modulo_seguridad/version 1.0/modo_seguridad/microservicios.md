# PRJ-EDU-HORARIOS - Arquitectura de Seguridad con Microservicios

---

## 1. Introduccion

Este documento explica de forma clara la arquitectura propuesta para manejar la seguridad de **PRJ-EDU-HORARIOS** mediante un microservicio central llamado **Auth Security Service**.

Este microservicio se encarga de validar usuarios, generar tokens, controlar permisos, manejar sesiones, aplicar seguridad por sede y registrar auditoria. Los demas microservicios, como horarios, fichas o ambientes, no gestionan el login directamente: solo validan que el usuario tenga un token valido y los permisos necesarios.

---

## 2. Objetivo

El objetivo del **Auth Security Service** es centralizar la seguridad del sistema para que cada usuario pueda acceder solo a la informacion y funciones que le corresponden.

El microservicio debe controlar:

- autenticacion de usuarios;
- generacion y renovacion de tokens;
- roles y permisos;
- sesiones activas;
- acceso por sede;
- auditoria de eventos importantes;
- MFA para usuarios criticos.

---

## 3. Justificacion de la implementacion

Se escogio una arquitectura basada en un **Auth Security Service** centralizado porque el modulo de seguridad es transversal a todo el sistema. Horarios, fichas, ambientes, observaciones y proyectos necesitan validar usuarios, permisos y sede activa, pero no deberian implementar su propia logica de autenticacion.

Centralizar la seguridad permite:

- evitar duplicacion de login, roles, permisos y sesiones en cada microservicio;
- mantener una unica fuente de verdad para identidad y autorizacion;
- aplicar politicas de seguridad de forma uniforme;
- facilitar auditoria y trazabilidad de eventos criticos;
- revocar sesiones y tokens desde un punto comun;
- reducir el riesgo de inconsistencias entre modulos;
- permitir crecimiento del sistema sin redisenar la seguridad en cada servicio.

Esta implementacion tambien se adapta bien al contexto institucional del proyecto, porque el acceso no depende solo del rol del usuario, sino tambien de la **regional**, el **centro de formacion** y principalmente la **sede activa**.

Ejemplo:

```text
Un coordinador puede tener permiso para crear horarios,
pero solo dentro de las sedes autorizadas para su cuenta.
```

Por esta razon, la seguridad debe validar tres aspectos al mismo tiempo:

```text
identidad + permisos + contexto institucional
```

Si cada microservicio manejara su propia seguridad, seria mas dificil garantizar que todos apliquen las mismas reglas de sede, auditoria, bloqueo de cuentas, MFA y revocacion de tokens.

---

## 4. Recomendacion de implementacion

La recomendacion es implementar esta arquitectura por fases, comenzando por las capacidades de seguridad indispensables y dejando las funciones avanzadas para una evolucion posterior.

Fase 1 - Seguridad base:

- crear el **Auth Security Service**;
- implementar login y logout;
- almacenar contrasenas con hash seguro;
- generar JWT de corta duracion;
- generar refresh tokens revocables;
- crear roles y permisos basicos;
- validar permisos en los microservicios funcionales;
- aplicar filtro obligatorio por `sede_id`.

Fase 2 - Control operativo:

- administrar sesiones activas;
- bloquear cuentas por intentos fallidos;
- revocar tokens al cambiar contrasena, rol o estado del usuario;
- registrar eventos minimos de auditoria;
- permitir seleccion de sede activa cuando el usuario tenga varias sedes.

Fase 3 - Seguridad avanzada:

- implementar MFA para administradores, auditores y coordinadores criticos;
- fortalecer auditoria con datos anteriores y nuevos;
- agregar politicas de acceso mas detalladas;
- monitorear eventos sospechosos;
- preparar integraciones futuras con OAuth2, SSO o SIEM.

Recomendacion tecnica principal:

```text
El frontend puede ocultar pantallas y botones segun permisos,
pero la autorizacion real siempre debe validarse en el backend.
```

Tambien se recomienda que los microservicios funcionales validen el JWT y los permisos en cada operacion sensible. El API Gateway ayuda a proteger la entrada, pero no debe ser la unica barrera de seguridad.

---

## 5. Requisitos no funcionales

Ademas de las funciones principales, el **Auth Security Service** debe cumplir requisitos no funcionales que garanticen seguridad, estabilidad y facilidad de mantenimiento.

| Requisito | Criterio recomendado |
|---|---|
| Seguridad | Usar HTTPS, hash seguro de contrasenas, JWT firmado, refresh tokens revocables y MFA para roles criticos. |
| Disponibilidad | Mantener el servicio disponible porque los demas microservicios dependen de el para autenticar y autorizar usuarios. |
| Escalabilidad | Permitir crecimiento de usuarios, sedes y microservicios sin cambiar la logica central de seguridad. |
| Trazabilidad | Registrar eventos relevantes como login, logout, cambios de roles, accesos denegados y revocacion de tokens. |
| Mantenibilidad | Separar responsabilidades internas en modulos de identidad, autenticacion, autorizacion, tokens, tenant y auditoria. |
| Consistencia | Aplicar las mismas reglas de permisos y sede activa en todos los microservicios protegidos. |
| Usabilidad | Permitir una experiencia clara para login, MFA, seleccion de sede activa y cierre de sesion. |

Estos requisitos ayudan a evaluar si la arquitectura no solo funciona, sino si es segura y sostenible para el crecimiento del proyecto.

---

## 6. Criterios de aceptacion

La implementacion del modulo de seguridad se considera correcta cuando cumple, como minimo, los siguientes criterios:

| Criterio | Resultado esperado |
|---|---|
| Login valido | El usuario autenticado recibe un JWT y un refresh token. |
| Login invalido | El sistema responde con un mensaje generico y registra el intento fallido. |
| Cuenta bloqueada | El usuario bloqueado no puede iniciar sesion hasta cumplir la politica definida. |
| MFA requerido | Los usuarios criticos deben validar segundo factor antes de recibir acceso completo. |
| JWT expirado | El sistema rechaza solicitudes con token vencido. |
| Refresh token revocado | El sistema no permite renovar sesiones con tokens revocados. |
| Permiso insuficiente | El microservicio responde acceso denegado y registra el evento cuando aplique. |
| Sede no autorizada | El sistema impide consultar o modificar informacion de una sede no asignada. |
| Cambio de rol o contrasena | Las sesiones afectadas se revocan para obligar nueva autenticacion. |
| Auditoria | Los eventos criticos quedan registrados y no pueden ser modificados desde la aplicacion. |

Estos criterios sirven como base para pruebas funcionales, pruebas de seguridad y validacion del alcance del modulo.

---

## 7. Decisiones tecnicas clave

| Decision | Justificacion |
|---|---|
| Centralizar seguridad en Auth Security Service | Evita duplicar autenticacion y autorizacion en cada microservicio. |
| Usar JWT de corta duracion | Reduce el impacto si un token de acceso es robado. |
| Usar refresh tokens revocables | Permite renovar sesiones sin exponer credenciales y cerrar accesos comprometidos. |
| Validar permisos en backend | Evita que un usuario manipule la interfaz para ejecutar acciones no autorizadas. |
| Aplicar aislamiento por `sede_id` | Protege la informacion operativa de cada sede institucional. |
| Registrar auditoria inmutable | Garantiza trazabilidad sobre acciones criticas y eventos de seguridad. |
| Exigir MFA a roles criticos | Reduce el riesgo de acceso indebido a funciones administrativas o sensibles. |

---

## 8. Alcance del Auth Security Service

El **Auth Security Service** tiene un alcance claramente definido: proteger el acceso al sistema, validar identidad, controlar permisos y registrar eventos de seguridad. No debe asumir reglas de negocio que pertenecen a otros microservicios.

Dentro de su alcance:

- autenticar usuarios;
- validar credenciales y estado de la cuenta;
- administrar sesiones activas;
- generar y renovar tokens;
- revocar tokens y sesiones;
- gestionar roles y permisos;
- aplicar MFA a usuarios criticos;
- validar contexto institucional de regional, centro y sede;
- registrar auditoria de eventos de seguridad;
- exponer informacion del usuario autenticado mediante `/auth/me`.

Fuera de su alcance:

- crear horarios academicos;
- administrar fichas de formacion;
- asignar ambientes;
- gestionar proyectos formativos;
- resolver reglas academicas propias de horarios, fichas o ambientes;
- almacenar datos operativos de otros microservicios;
- decidir disponibilidad de instructores, ambientes o franjas horarias.

Separacion recomendada:

```text
Auth Security Service -> valida identidad, permisos, sesiones y sede.
Horarios Service      -> aplica reglas de negocio sobre horarios.
Fichas Service        -> aplica reglas de negocio sobre fichas.
Ambientes Service     -> aplica reglas de negocio sobre ambientes.
```

Esta separacion evita que el modulo de seguridad se convierta en un servicio demasiado grande y mantiene clara la responsabilidad de cada microservicio.

---

## 9. Arquitectura general

La comunicacion principal del sistema funciona asi:

```text
Cliente web o movil
        |
        v
API Gateway
        |
        v
Auth Security Service
        |
        v
Microservicios funcionales
```

El **API Gateway** recibe las solicitudes externas y las dirige al servicio correspondiente. El **Auth Security Service** valida identidad y entrega tokens. Los microservicios funcionales verifican esos tokens antes de permitir operaciones.

Microservicios protegidos:

| Microservicio | Funcion |
|---|---|
| Auth Security Service | Seguridad, usuarios, roles, permisos, sesiones y auditoria. |
| Horarios Service | Gestion de horarios y franjas. |
| Fichas Service | Gestion de fichas y extensiones. |
| Ambientes Service | Gestion de ambientes y disponibilidad. |
| Observaciones Service | Gestion de incidencias y seguimiento. |
| Proyectos Service | Gestion de proyectos formativos. |

---

## 10. Responsabilidades por componente

| Componente | Responsabilidad principal |
|---|---|
| Cliente | Envia credenciales y consume los servicios autorizados. |
| API Gateway | Recibe peticiones, enruta y aplica controles iniciales. |
| Auth Security Service | Autentica, autoriza, emite tokens y registra auditoria. |
| Microservicios funcionales | Ejecutan reglas de negocio y validan permisos. |
| Base de datos | Almacena informacion propia de cada servicio. |

El Gateway ayuda a proteger la entrada, pero no debe ser la unica barrera. Cada microservicio tambien debe validar el token y los permisos.

---

## 11. Auth Security Service

El microservicio de seguridad se divide en modulos internos simples:

| Modulo | Que hace |
|---|---|
| Identity | Gestiona usuarios y datos de identidad. |
| Authentication | Valida login, contrasenas, MFA y sesiones. |
| Authorization | Controla roles y permisos. |
| Token | Genera y renueva JWT y refresh tokens. |
| Tenant | Aplica acceso por regional, centro y sede. |
| Audit | Registra eventos de seguridad. |

Relacion entre modulos internos:

```text
Authentication
        |
        v
Identity
        |
        v
Token
        |
        v
Authorization
        |
        v
Tenant
        |
        v
Audit
```

Flujo interno:

1. **Authentication** recibe la solicitud de inicio de sesion.
2. **Identity** valida la existencia del usuario, sus credenciales y el estado de la cuenta.
3. **Token** genera los tokens de acceso necesarios.
4. **Authorization** determina roles, permisos y politicas aplicables.
5. **Tenant** aplica el contexto institucional de regional, centro y sede.
6. **Audit** registra los eventos relevantes de seguridad.

Detalle del **Identity Module**:

- **User Management:** crea usuarios, actualiza informacion, activa o inactiva cuentas, bloquea o desbloquea usuarios, asocia usuarios a regionales, centros de formacion y sedes, y gestiona el estado de la cuenta.
- **Credential Management:** almacena contrasenas con hash seguro, permite cambio y restablecimiento de contrasena, aplica politicas de seguridad, conserva historial de cambios, valida credenciales y controla vencimiento cuando aplique.

Tablas principales relacionadas:

```text
usuario
credencial
rol
permiso
rol_permiso
usuario_rol
regional
centro_formacion
sede
usuario_sede
sesion
refresh_token
auditoria_seguridad
```

---

## 12. Autenticacion

La autenticacion valida que el usuario sea quien dice ser.

Flujo de login:

```text
1. El usuario ingresa usuario/correo/documento y contrasena.
2. El API Gateway envia la solicitud al Auth Security Service.
3. El servicio valida credenciales y estado del usuario.
4. Si el usuario es critico, solicita MFA.
5. Si todo es correcto, genera JWT y refresh token.
6. Registra el evento en auditoria.
```

Flujo detallado del Authentication Module:

```text
Login
        |
        v
Validar credenciales
        |
        v
Evaluar MFA
        |
        v
Validar segundo factor, si aplica
        |
        v
Generar JWT y refresh token
        |
        v
Registrar auditoria
        |
        v
Acceso autorizado
```

Controles recomendados:

- guardar contrasenas con hash seguro;
- bloquear temporalmente despues de varios intentos fallidos;
- usar MFA para administradores, auditores y coordinadores criticos;
- registrar login exitoso y fallido;
- responder errores de forma generica;
- administrar sesiones activas;
- orquestar las validaciones completas del proceso de autenticacion.

Ejemplo de respuesta incorrecta:

```text
Credenciales invalidas.
```

No se debe indicar si fallo el usuario, el correo o la contrasena.

---

## 13. JWT y refresh token

El **JWT** permite que los microservicios sepan quien es el usuario y que permisos tiene. Debe tener una duracion corta.

El **refresh token** permite renovar el JWT sin volver a iniciar sesion. Debe guardarse como hash y poder revocarse.

Recomendacion:

| Token | Uso | Duracion sugerida |
|---|---|---|
| Access Token JWT | Acceso a microservicios | 15 a 30 minutos |
| Refresh Token | Renovar el access token | 7 a 30 dias |

Ejemplo de claims del JWT:

```json
{
  "sub": "15",
  "username": "coord.neiva",
  "regional_id": "uuid-regional-huila",
  "centro_formacion_id": "uuid-centro-comercio",
  "sede_id": "uuid-sede-principal",
  "roles": ["COORDINADOR"],
  "permissions": ["HORARIOS_READ", "HORARIOS_CREATE"],
  "mfa_verified": false,
  "exp": 1710001800
}
```

Componentes internos del Token Module:

| Servicio | Responsabilidad |
|---|---|
| Access Token Service | Genera JWT, incluye claims de usuario, roles y permisos, y define expiraciones cortas. |
| Refresh Token Service | Genera refresh tokens, renueva sesiones activas, rota tokens y revoca tokens comprometidos. |
| Token Validation Service | Valida firma digital, expiracion, claims e integridad del token. |
| MFA Token Service | Genera tokens temporales para MFA y controla su expiracion. |

Buenas practicas:

- usar JWT de corta duracion;
- guardar refresh token como hash;
- revocar refresh token en logout;
- revocar sesiones al cambiar rol, contrasena o estado del usuario;
- no incluir informacion sensible innecesaria en el token.

---

## 14. Roles y permisos

El sistema usa un modelo RBAC, donde los permisos se asignan a roles y los roles se asignan a usuarios.

```text
usuario -> usuario_rol -> rol -> rol_permiso -> permiso
```

Permisos sugeridos:

| Modulo | Permisos |
|---|---|
| Horarios | `HORARIOS_READ`, `HORARIOS_CREATE`, `HORARIOS_UPDATE`, `HORARIOS_DELETE` |
| Fichas | `FICHAS_READ`, `FICHAS_CREATE`, `FICHAS_UPDATE` |
| Ambientes | `AMBIENTES_READ`, `AMBIENTES_UPDATE` |
| Observaciones | `OBSERVACIONES_READ`, `OBSERVACIONES_RESOLVE` |
| Usuarios | `USUARIOS_READ`, `USUARIOS_ADMIN` |
| Seguridad | `ROLES_ADMIN`, `PERMISOS_ADMIN`, `AUDITORIA_READ` |

Regla basica de autorizacion:

```text
usuario autenticado + sesion activa + permiso requerido + sede autorizada
```

Politicas de autorizacion:

- gestionar roles y permisos;
- evaluar politicas de acceso;
- autorizar usando claims del JWT;
- restringir operaciones por sede activa;
- aplicar el principio de minimo privilegio.

Principio general:

```text
Un usuario solo puede ejecutar acciones autorizadas por sus roles, permisos y contexto institucional.
```

---

## 15. Multi-tenant por sede

En este proyecto, el multi-tenant se adapta a la estructura institucional del SENA:

```text
regional -> centro_formacion -> sede
```

Para horarios, el aislamiento mas importante es la **sede**, porque fichas, ambientes, instructores y aprendices trabajan en una sede especifica.

Reglas principales:

- todo usuario debe tener al menos una sede autorizada;
- el JWT debe indicar la sede activa;
- las consultas deben filtrar por `sede_id`;
- el backend no debe confiar en un `sede_id` enviado por el cliente;
- si un usuario tiene varias sedes, debe seleccionar una sede activa.

Ejemplo:

Un coordinador de la Sede Principal Neiva solo debe gestionar horarios, fichas, ambientes e instructores asociados a esa sede.

---

## 16. Auditoria

La auditoria registra eventos relevantes para saber quien hizo una accion, cuando la hizo y desde donde.

Eventos minimos:

| Evento | Descripcion |
|---|---|
| `LOGIN_SUCCESS` | Inicio de sesion exitoso. |
| `LOGIN_FAILED` | Intento fallido de login. |
| `LOGOUT` | Cierre de sesion. |
| `PASSWORD_CHANGED` | Cambio de contrasena. |
| `ROLE_ASSIGNED` | Asignacion de rol. |
| `PERMISSION_ASSIGNED` | Asignacion de permiso. |
| `TOKEN_REVOKED` | Revocacion de token. |
| `MFA_SUCCESS` | MFA validado correctamente. |
| `MFA_FAILED` | MFA fallido. |
| `ACCESS_DENIED` | Acceso denegado por permisos insuficientes. |

Datos que debe guardar:

- usuario responsable;
- fecha y hora;
- IP;
- navegador o dispositivo;
- sede activa;
- accion realizada;
- resultado;
- registro afectado;
- datos anteriores y nuevos cuando aplique.

La auditoria debe ser inmutable: la aplicacion no debe permitir editar ni eliminar estos registros.

---

## 17. Endpoints principales

| Metodo | Endpoint | Funcion |
|---|---|---|
| POST | `/auth/login` | Iniciar sesion. |
| POST | `/auth/mfa/verify` | Validar MFA. |
| POST | `/auth/refresh` | Renovar access token. |
| POST | `/auth/logout` | Cerrar sesion. |
| GET | `/auth/me` | Consultar usuario autenticado. |
| GET | `/auth/sessions` | Ver sesiones activas. |
| DELETE | `/auth/sessions/{id}` | Revocar una sesion. |
| POST | `/users` | Crear usuario. |
| PATCH | `/users/{id}/status` | Activar, inactivar o bloquear usuario. |
| POST | `/roles` | Crear rol. |
| POST | `/permissions` | Crear permiso. |
| GET | `/audit/security` | Consultar auditoria de seguridad. |

---

## 18. Riesgos y controles

| Riesgo | Control recomendado |
|---|---|
| Robo de contrasena | Hash seguro y MFA para roles criticos. |
| Fuerza bruta | Bloqueo temporal y rate limiting. |
| Token robado | JWT corto y refresh token revocable. |
| Acceso a otra sede | Validacion obligatoria por `sede_id`. |
| Escalada de privilegios | Validar permisos en backend. |
| Alteracion de auditoria | Auditoria inmutable. |
| Acceso directo a servicios internos | Red privada y validacion de JWT. |

---

## 19. Consideraciones finales de seguridad

Medidas minimas recomendadas:

- usar HTTPS;
- almacenar contrasenas con Argon2id, bcrypt o PBKDF2;
- usar JWT de corta duracion;
- guardar refresh tokens como hash;
- aplicar MFA a usuarios criticos;
- bloquear temporalmente intentos fallidos;
- validar permisos en cada microservicio;
- validar siempre `sede_id`;
- no exponer bases de datos directamente;
- registrar auditoria de eventos criticos.

---

## 20. Mejoras futuras

La arquitectura propuesta permite evolucionar el sistema incorporando nuevas capacidades de seguridad:

- gestion de dispositivos confiables;
- passwordless authentication;
- integracion con OAuth2;
- integracion con Single Sign-On (SSO);
- federacion de identidades institucionales;
- politicas de acceso basadas en riesgo;
- deteccion de comportamientos anomalos;
- monitoreo centralizado de eventos de seguridad;
- integracion con herramientas SIEM.

---

## 21. Conclusion

La arquitectura con **Auth Security Service** permite centralizar la seguridad de **PRJ-EDU-HORARIOS** sin mezclarla con la logica de horarios, fichas o ambientes.

El sistema queda organizado en capas: el cliente entra por el API Gateway, el Auth Security Service valida identidad y permisos, y los microservicios funcionales ejecutan sus procesos solo si el usuario tiene autorizacion.

Con JWT, refresh tokens, roles, permisos, MFA para usuarios criticos, auditoria y aislamiento por `sede_id`, el proyecto obtiene una base de seguridad clara, escalable y facil de mantener.
