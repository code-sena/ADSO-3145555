# Mitigaciones de Seguridad

**Proposito:** concentrar los riesgos del sistema y los controles recomendados para reducirlos.

---

## 1. Enfoque

Este documento no describe todo el modulo de seguridad. Su funcion es identificar amenazas y definir mitigaciones concretas para proteger la plataforma SIGHA SENA.

---

## 2. Matriz principal de riesgos

| Riesgo | Impacto | Mitigacion |
|---|---|---|
| Acceso no autorizado | Critico | JWT, roles, permisos y validacion backend. |
| Robo de contrasena | Critico | Hash seguro, salt, MFA y politicas de contrasena. |
| Fuerza bruta | Alto | Rate limiting, bloqueo temporal y auditoria de intentos. |
| Token robado | Alto | JWT corto, refresh token revocable y cierre de sesion. |
| Escalada de privilegios | Critico | Principio de minimo privilegio y auditoria de roles. |
| Acceso a otra sede | Critico | Filtro obligatorio por `sede_id` y validacion en backend. |
| Alteracion de auditoria | Alto | Auditoria inmutable y restricciones de escritura. |
| Servicios internos expuestos | Alto | API Gateway, red privada y rechazo de acceso directo. |
| Datos sensibles expuestos | Alto | HTTPS/TLS, cifrado en reposo y minimizacion de datos. |
| Fallas entre microservicios | Medio | Timeouts, retry controlado, circuit breaker y monitoreo. |

---

## 3. Controles de autenticacion

- almacenar contrasenas con Argon2id, bcrypt o PBKDF2;
- aplicar salt por contrasena;
- usar mensajes genericos en login fallido;
- bloquear temporalmente cuentas con demasiados intentos;
- exigir MFA a administradores, auditores y usuarios criticos;
- registrar login exitoso y fallido.

---

## 4. Controles de autorizacion

- validar permisos en backend;
- no confiar solo en botones ocultos del frontend;
- aplicar principio de minimo privilegio;
- separar permisos por accion;
- auditar cambios de roles y permisos;
- revocar sesiones cuando cambien permisos sensibles.

---

## 5. Controles de multi-tenant por sede

- incluir sede activa en el JWT;
- filtrar consultas por `sede_id`;
- validar que los recursos pertenecen a la sede autorizada;
- impedir que el cliente fuerce un `sede_id`;
- auditar intentos de acceso a sedes no autorizadas.

---

## 6. Controles de tokens y sesiones

- usar JWT de corta duracion;
- guardar refresh tokens como hash;
- revocar refresh token en logout;
- rotar refresh tokens en renovaciones;
- invalidar sesiones por cambio de contrasena, rol o estado;
- registrar tokens revocados.

---

## 7. Controles de microservicios

- exponer servicios solo por API Gateway;
- usar HTTPS/TLS;
- asignar usuarios de base de datos con permisos minimos;
- separar bases de datos por servicio;
- validar JWT en cada servicio;
- aplicar timeouts y circuit breaker;
- centralizar logs y metricas.

---

## 8. Controles de auditoria

Eventos minimos:

- `LOGIN_SUCCESS`;
- `LOGIN_FAILED`;
- `LOGOUT`;
- `ACCESS_DENIED`;
- `ROLE_ASSIGNED`;
- `PERMISSION_ASSIGNED`;
- `TOKEN_REVOKED`;
- `HORARIO_CREATED`;
- `HORARIO_UPDATED`;
- `PROYECTO_UPDATED`.

La auditoria debe registrar:

- usuario;
- rol;
- sede;
- IP;
- accion;
- resultado;
- fecha y hora;
- registro afectado;
- datos anteriores y nuevos cuando aplique.

---

## 9. Criterios de aceptacion de seguridad

| Caso | Resultado esperado |
|---|---|
| Usuario sin token | Acceso rechazado. |
| Token expirado | Acceso rechazado y solicitud de renovacion. |
| Usuario sin permiso | Acceso denegado y evento auditado. |
| Usuario de otra sede | Consulta o accion bloqueada. |
| Login fallido repetido | Cuenta bloqueada temporalmente. |
| Cambio de rol | Sesiones afectadas revocadas. |
| Logout | Refresh token invalidado. |
| Auditoria | Evento guardado sin posibilidad de modificacion desde la app. |

---

## 10. Prioridad de implementacion

| Prioridad | Control |
|---|---|
| Alta | Hash de contrasenas, JWT, roles, permisos y filtros por sede. |
| Alta | Auditoria de login, cambios y accesos denegados. |
| Alta | Revocacion de sesiones y refresh tokens. |
| Media | MFA para usuarios criticos. |
| Media | Circuit breaker y monitoreo. |
| Baja | Integracion futura con SIEM o analitica avanzada. |

---

## 11. Conclusion

La seguridad del sistema depende de controles combinados: autenticacion fuerte, autorizacion por permisos, aislamiento por sede, sesiones revocables, auditoria inmutable y proteccion de microservicios. Ningun control por si solo es suficiente; el valor esta en aplicarlos de forma coordinada.
