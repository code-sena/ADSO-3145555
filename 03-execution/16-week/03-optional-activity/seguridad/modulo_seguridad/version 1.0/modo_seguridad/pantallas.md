# PRJ-EDU-HORARIOS - Pantallas y Permisos del Modulo de Seguridad

---

## 1. Introduccion

Este documento organiza las pantallas principales del sistema segun los roles, permisos y controles de seguridad definidos para **PRJ-EDU-HORARIOS**.

La estructura se alinea con la arquitectura descrita en `microservicios.md`, donde el **Auth Security Service** centraliza autenticacion, autorizacion, tokens, sesiones, roles, permisos, contexto por sede y auditoria.

Las pantallas no deben decidir la seguridad por si solas. La interfaz puede ocultar opciones segun el rol, pero cada accion debe validarse tambien en el backend mediante:

- usuario autenticado;
- sesion activa;
- JWT valido;
- permiso requerido;
- sede activa autorizada;
- registro de auditoria cuando aplique.

---

## 2. Criterios de acceso

El acceso a cada pantalla depende de cuatro criterios principales:

| Criterio | Descripcion |
|---|---|
| Rol | Define el perfil general del usuario dentro del sistema. |
| Permiso | Define la accion concreta permitida, como consultar, crear o modificar. |
| Sede activa | Limita la informacion a la sede autorizada del usuario. |
| Estado de sesion | Permite operar solo si la sesion esta activa y el token es valido. |

Regla general:

```text
rol asignado + permiso requerido + sede autorizada + sesion activa = acceso permitido
```

---

## 3. Roles principales

| Rol | Proposito |
|---|---|
| Administrador del Sistema | Gestiona usuarios, roles, permisos, sedes, configuracion, sesiones y auditoria. |
| Coordinador Academico | Gestiona horarios, fichas, ambientes, instructores, observaciones y reportes de su sede. |
| Instructor | Consulta su horario, fichas, ambientes asignados y registra novedades. |
| Aprendiz | Consulta su horario, ficha, proyectos, notificaciones y perfil. |
| Auditor | Consulta eventos de seguridad, accesos, sesiones y reportes de auditoria. |

---

## 4. Resumen de pantallas por rol

| Rol | Pantallas disponibles | Permisos principales |
|---|---|---|
| Administrador del Sistema | Dashboard Administrativo, Usuarios, Roles, Permisos, Sedes, Sesiones Activas, Auditoria, Configuracion General | `USUARIOS_ADMIN`, `ROLES_ADMIN`, `PERMISOS_ADMIN`, `AUDITORIA_READ` |
| Coordinador Academico | Dashboard de Coordinacion, Horarios, Fichas, Ambientes, Asignacion de Instructores, Observaciones, Reportes | `HORARIOS_READ`, `HORARIOS_CREATE`, `HORARIOS_UPDATE`, `FICHAS_READ`, `FICHAS_UPDATE`, `AMBIENTES_READ`, `AMBIENTES_UPDATE`, `OBSERVACIONES_RESOLVE` |
| Instructor | Dashboard Instructor, Mi Horario, Mis Fichas, Mis Ambientes, Observaciones, Perfil | `HORARIOS_READ`, `FICHAS_READ`, `AMBIENTES_READ`, `OBSERVACIONES_READ` |
| Aprendiz | Dashboard Aprendiz, Mi Horario, Mi Ficha, Mis Proyectos, Notificaciones, Perfil | `HORARIOS_READ`, `FICHAS_READ` |
| Auditor | Dashboard Auditoria, Eventos de Seguridad, Historial de Accesos, Sesiones Activas, Reportes de Auditoria | `AUDITORIA_READ` |

---

## 5. Pantallas del Administrador del Sistema

El administrador tiene el mayor nivel de acceso dentro del modulo de seguridad. Debe usar MFA y sus acciones criticas deben quedar registradas en auditoria.

| Pantalla | Descripcion | Acciones principales | Permisos requeridos |
|---|---|---|---|
| Dashboard Administrativo | Muestra resumen general de usuarios, sesiones, eventos y estado del sistema. | Consultar indicadores generales de seguridad. | `USUARIOS_ADMIN`, `AUDITORIA_READ` |
| Gestion de Usuarios | Permite administrar cuentas de usuario. | Crear, editar, activar, inactivar, bloquear y desbloquear usuarios. | `USUARIOS_ADMIN` |
| Gestion de Roles | Permite crear y administrar roles del sistema. | Crear roles, editar roles, activar o inactivar roles. | `ROLES_ADMIN` |
| Gestion de Permisos | Permite administrar permisos y asociarlos a roles. | Crear permisos, asignar permisos, retirar permisos. | `PERMISOS_ADMIN` |
| Gestion de Sedes | Administra regionales, centros de formacion y sedes. | Crear, editar y consultar estructura institucional. | `USUARIOS_ADMIN` |
| Sesiones Activas | Permite ver y revocar sesiones abiertas. | Consultar sesiones y revocar sesiones sospechosas. | `USUARIOS_ADMIN` |
| Auditoria | Consulta eventos de seguridad. | Revisar login, logout, cambios de roles, permisos y accesos denegados. | `AUDITORIA_READ` |
| Configuracion General | Administra parametros globales de seguridad. | Definir politicas de sesion, MFA, bloqueo y vencimiento. | `USUARIOS_ADMIN`, `ROLES_ADMIN` |

Controles recomendados:

- exigir MFA al iniciar sesion;
- registrar en auditoria cambios de usuarios, roles y permisos;
- revocar sesiones cuando se cambie el estado, rol o contrasena de un usuario;
- limitar datos por sede cuando el administrador no tenga alcance global.

---

## 6. Pantallas del Coordinador Academico

El coordinador administra la operacion academica de una sede. Su acceso debe estar limitado por `sede_id`.

| Pantalla | Descripcion | Acciones principales | Permisos requeridos |
|---|---|---|---|
| Dashboard de Coordinacion | Muestra indicadores operativos de la sede activa. | Consultar ocupacion, horarios, fichas y novedades. | `HORARIOS_READ`, `FICHAS_READ`, `AMBIENTES_READ` |
| Gestion de Horarios | Permite crear y modificar horarios. | Crear horarios, editar horarios, validar cruces y consultar franjas. | `HORARIOS_READ`, `HORARIOS_CREATE`, `HORARIOS_UPDATE` |
| Gestion de Fichas | Permite consultar y administrar fichas. | Consultar fichas, actualizar datos y revisar extensiones. | `FICHAS_READ`, `FICHAS_UPDATE` |
| Gestion de Ambientes | Permite consultar ambientes y disponibilidad. | Ver disponibilidad, actualizar asignaciones y validar ocupacion. | `AMBIENTES_READ`, `AMBIENTES_UPDATE` |
| Asignacion de Instructores | Relaciona instructores con horarios y fichas. | Asignar instructor, validar disponibilidad y modificar asignaciones. | `HORARIOS_UPDATE`, `FICHAS_UPDATE` |
| Observaciones | Gestiona incidencias academicas. | Consultar observaciones y marcar incidencias como resueltas. | `OBSERVACIONES_READ`, `OBSERVACIONES_RESOLVE` |
| Reportes | Muestra estadisticas academicas y operativas. | Consultar reportes de horarios, ambientes, fichas e incidencias. | `HORARIOS_READ`, `FICHAS_READ`, `AMBIENTES_READ` |

Controles recomendados:

- filtrar todos los datos por sede activa;
- impedir que el cliente envie o altere manualmente el `sede_id`;
- registrar auditoria cuando se creen o modifiquen horarios;
- validar permisos en cada microservicio funcional.

---

## 7. Pantallas del Instructor

El instructor tiene acceso principalmente de consulta y registro de novedades relacionadas con su carga academica.

| Pantalla | Descripcion | Acciones principales | Permisos requeridos |
|---|---|---|---|
| Dashboard Instructor | Muestra resumen de clases, fichas y novedades. | Consultar informacion asignada al instructor. | `HORARIOS_READ`, `FICHAS_READ` |
| Mi Horario | Consulta horarios asignados. | Ver clases, franjas, ambientes y fechas. | `HORARIOS_READ` |
| Mis Fichas | Consulta grupos asignados. | Ver fichas, aprendices y datos academicos permitidos. | `FICHAS_READ` |
| Mis Ambientes | Consulta ambientes asignados. | Ver ambiente, sede, disponibilidad y recursos asociados. | `AMBIENTES_READ` |
| Observaciones | Permite reportar novedades academicas. | Crear o consultar novedades segun alcance definido. | `OBSERVACIONES_READ` |
| Perfil | Permite consultar datos personales. | Ver informacion personal y datos basicos de cuenta. | Sesion activa |

Controles recomendados:

- mostrar solo horarios, fichas y ambientes asignados al instructor;
- evitar acceso a datos administrativos de otros usuarios;
- registrar eventos si reporta novedades relevantes.

---

## 8. Pantallas del Aprendiz

El aprendiz tiene acceso de consulta a informacion propia de su proceso formativo.

| Pantalla | Descripcion | Acciones principales | Permisos requeridos |
|---|---|---|---|
| Dashboard Aprendiz | Muestra informacion general del aprendiz. | Consultar resumen de horario, ficha y avisos. | `HORARIOS_READ`, `FICHAS_READ` |
| Mi Horario | Consulta clases programadas. | Ver horarios, ambientes, instructores y fechas. | `HORARIOS_READ` |
| Mi Ficha | Consulta informacion de la ficha de formacion. | Ver datos de ficha y programa asociado. | `FICHAS_READ` |
| Mis Proyectos | Consulta proyectos formativos asociados. | Ver estado, integrantes e hitos permitidos. | Sesion activa |
| Notificaciones | Muestra avisos institucionales. | Consultar comunicaciones relacionadas con su ficha o sede. | Sesion activa |
| Perfil | Consulta informacion personal. | Ver datos personales y datos basicos de cuenta. | Sesion activa |

Controles recomendados:

- mostrar solo informacion asociada al aprendiz autenticado;
- no permitir consulta de fichas, horarios o proyectos de otros aprendices;
- aplicar siempre filtro por sede, ficha y usuario.

---

## 9. Pantallas del Auditor

El auditor tiene acceso de consulta a eventos de seguridad y trazabilidad. No debe modificar usuarios, roles ni permisos desde estas pantallas.

| Pantalla | Descripcion | Acciones principales | Permisos requeridos |
|---|---|---|---|
| Dashboard Auditoria | Muestra resumen de actividad del sistema. | Consultar indicadores de eventos, accesos y sesiones. | `AUDITORIA_READ` |
| Eventos de Seguridad | Consulta eventos criticos. | Revisar login fallido, MFA fallido, accesos denegados y cambios de seguridad. | `AUDITORIA_READ` |
| Historial de Accesos | Revisa inicios y cierres de sesion. | Consultar accesos por usuario, IP, fecha y sede. | `AUDITORIA_READ` |
| Sesiones Activas | Monitorea sesiones abiertas. | Consultar sesiones activas y actividad sospechosa. | `AUDITORIA_READ` |
| Reportes de Auditoria | Genera informes de control. | Filtrar eventos y exportar reportes autorizados. | `AUDITORIA_READ` |

Controles recomendados:

- acceso solo de lectura;
- ocultar datos sensibles que no sean necesarios para auditoria;
- mantener auditoria inmutable;
- registrar consultas de eventos criticos cuando aplique.

---

## 10. Matriz de acceso por modulo

| Modulo | Administrador | Coordinador | Instructor | Aprendiz | Auditor |
|---|---|---|---|---|---|
| Usuarios | Gestion completa | Sin acceso | Sin acceso | Sin acceso | Consulta auditada |
| Roles y Permisos | Gestion completa | Sin acceso | Sin acceso | Sin acceso | Consulta auditada |
| Horarios | Gestion completa | Gestion de sede | Consulta asignada | Consulta propia | Consulta auditada |
| Fichas | Gestion completa | Gestion de sede | Consulta asignada | Consulta propia | Consulta auditada |
| Ambientes | Gestion completa | Gestion de sede | Consulta asignada | Sin acceso directo | Consulta auditada |
| Observaciones | Gestion completa | Gestion de sede | Registro y consulta asignada | Sin acceso | Consulta auditada |
| Auditoria | Consulta completa | Sin acceso | Sin acceso | Sin acceso | Consulta completa |
| Configuracion | Gestion completa | Sin acceso | Sin acceso | Sin acceso | Sin acceso |

Leyenda:

- **Gestion completa:** crear, consultar, modificar, eliminar o administrar segun el modulo.
- **Gestion de sede:** administrar solo informacion asociada a la sede activa autorizada.
- **Consulta asignada:** consultar solo informacion relacionada con el usuario autenticado.
- **Consulta propia:** consultar solo informacion personal o academica propia.
- **Consulta auditada:** consultar informacion para control, sin modificar datos.
- **Sin acceso:** la pantalla o modulo no debe mostrarse ni permitir operaciones.

---

## 11. Relacion con permisos del Auth Security Service

Los permisos visibles en las pantallas deben corresponder a los permisos definidos en el Auth Security Service.

| Permiso | Uso en pantallas |
|---|---|
| `HORARIOS_READ` | Consultar horarios propios, asignados o de sede. |
| `HORARIOS_CREATE` | Crear horarios desde la gestion academica. |
| `HORARIOS_UPDATE` | Modificar horarios existentes. |
| `HORARIOS_DELETE` | Eliminar horarios, solo para perfiles autorizados. |
| `FICHAS_READ` | Consultar fichas propias, asignadas o de sede. |
| `FICHAS_CREATE` | Crear fichas, si el negocio lo permite desde el modulo academico. |
| `FICHAS_UPDATE` | Actualizar fichas existentes. |
| `AMBIENTES_READ` | Consultar ambientes y disponibilidad. |
| `AMBIENTES_UPDATE` | Actualizar asignaciones o disponibilidad de ambientes. |
| `OBSERVACIONES_READ` | Consultar observaciones o novedades. |
| `OBSERVACIONES_RESOLVE` | Resolver incidencias academicas. |
| `USUARIOS_ADMIN` | Administrar usuarios, estados y sesiones. |
| `ROLES_ADMIN` | Administrar roles. |
| `PERMISOS_ADMIN` | Administrar permisos y asignaciones. |
| `AUDITORIA_READ` | Consultar eventos y reportes de auditoria. |

---

## 12. Pantallas de autenticacion y sesion

Estas pantallas pertenecen directamente al flujo del Auth Security Service.

| Pantalla | Descripcion | Endpoint relacionado |
|---|---|---|
| Login | Captura usuario, correo o documento y contrasena. | `POST /auth/login` |
| Verificacion MFA | Solicita segundo factor cuando el rol o politica lo requiere. | `POST /auth/mfa/verify` |
| Seleccion de sede activa | Permite seleccionar sede cuando el usuario tiene varias sedes autorizadas. | `GET /auth/me` |
| Perfil de sesion | Muestra datos del usuario autenticado, roles, permisos y sede activa. | `GET /auth/me` |
| Sesiones activas | Lista sesiones del usuario o sesiones administrables segun permisos. | `GET /auth/sessions` |
| Cierre de sesion | Revoca la sesion actual y el refresh token asociado. | `POST /auth/logout` |

Reglas de seguridad:

- el login debe responder errores genericos;
- MFA debe exigirse a roles criticos;
- el JWT debe emitirse solo cuando la autenticacion completa sea exitosa;
- el refresh token debe revocarse en logout;
- al cambiar rol, contrasena o estado del usuario, se deben revocar sesiones afectadas.

---

## 13. Reglas de interfaz

La interfaz debe ayudar al usuario, pero no reemplaza los controles del backend.

Reglas recomendadas:

- ocultar botones o pantallas si el usuario no tiene el permiso requerido;
- bloquear acciones si la sesion expiro;
- mostrar solo datos de la sede activa;
- solicitar seleccion de sede si el usuario tiene mas de una sede autorizada;
- no confiar en permisos calculados solo desde el frontend;
- refrescar permisos cuando cambie el token o la sesion;
- mostrar mensajes genericos en errores de autenticacion;
- mostrar mensajes claros en errores de autorizacion, sin exponer informacion sensible.

Ejemplo de mensaje para acceso denegado:

```text
No tienes permisos para realizar esta accion.
```

---

## 14. Conclusion

La matriz de pantallas debe reflejar el modelo de seguridad del sistema: cada rol ve solo las opciones que necesita, cada accion exige permisos especificos y cada consulta debe respetar la sede activa.

Con esta organizacion, las pantallas quedan alineadas con el **Auth Security Service**, el modelo RBAC, los tokens JWT, la auditoria y el aislamiento institucional por `sede_id`.
