# Integracion entre Horarios, Proyectos Formativos y Seguridad

**Proposito:** explicar como se comunican los tres pilares del sistema sin repetir la definicion interna de cada modulo.

---

## 1. Vision integrada

SIGHA SENA se apoya en tres modulos que deben operar coordinados:

| Modulo | Pregunta que responde |
|---|---|
| Horarios | Cuando, donde y con quien se ejecuta la formacion. |
| Proyectos Formativos | Que se esta desarrollando y como avanza la ficha. |
| Seguridad | Quien puede acceder, que puede hacer y que debe auditarse. |

La integracion permite que el sistema no funcione como modulos aislados, sino como una plataforma academica cohesionada.

---

## 2. Flujo academico general

```text
Seguridad valida coordinador
        |
        v
Fichas crea o actualiza grupo
        |
        v
Horarios programa competencias
        |
        v
Proyectos actualiza avance u horas relacionadas
        |
        v
Seguridad audita acciones criticas
```

---

## 3. Responsabilidad de cada modulo en la integracion

| Modulo | Responsabilidad en la integracion |
|---|---|
| Security Service | Valida identidad, permisos, sede y auditoria. |
| Schedule Service | Valida cruces, registra horarios y publica eventos. |
| Project Service | Sincroniza avance, horas y estado academico del proyecto. |
| Ficha Service | Mantiene fichas, aprendices, jornada y vigencia. |
| Notification Service | Notifica cambios relevantes a usuarios autorizados. |
| Audit Service | Registra eventos criticos de todos los modulos. |

---

## 4. Matriz de escenarios

| Escenario | Horarios | Proyectos | Seguridad |
|---|---|---|---|
| Crear ficha | Recibe ficha disponible para programar. | Puede crear proyecto asociado. | Audita creacion y valida permiso. |
| Programar competencia | Crea horario y valida reglas. | Actualiza horas programadas. | Verifica rol, permiso y sede. |
| Cambiar instructor | Modifica horario y publica evento. | Recibe cambio para ajustar seguimiento. | Audita cambio y responsable. |
| Registrar avance | Puede validar horas programadas. | Registra avance del proyecto. | Verifica usuario y audita accion. |
| Extender ficha | Revalida horarios existentes. | Ajusta linea de tiempo del proyecto. | Audita extension. |
| Generar reporte | Entrega datos de cumplimiento. | Entrega avance academico. | Filtra por permisos y sede. |

---

## 5. Eventos principales

| Evento | Publica | Consume | Uso |
|---|---|---|---|
| `horario.creado` | Schedule Service | Project, Notification, Audit | Actualizar horas, notificar y auditar. |
| `horario.modificado` | Schedule Service | Project, Notification, Audit | Informar cambios de instructor, ambiente o franja. |
| `ficha.creada` | Ficha Service | Project, Audit | Crear proyecto asociado o dejar registro. |
| `ficha.vigencia_modificada` | Ficha Service | Schedule, Project, Audit | Revalidar horarios y ajustar proyecto. |
| `proyecto.avance_registrado` | Project Service | Schedule, Audit | Comparar avance con horas programadas. |
| `rol.permiso_modificado` | Security Service | Servicios consumidores | Invalidar cache y forzar nueva autorizacion. |

---

## 6. Integracion Horarios - Seguridad

Antes de crear o modificar un horario, el sistema debe validar:

- usuario activo;
- JWT vigente;
- permiso requerido;
- sede compatible;
- accion auditable.

Ejemplo:

```text
POST /api/v1/horarios
Permiso requerido: HORARIOS_CREATE
Condicion: usuario asignado a la sede del horario
Resultado: permitir o denegar
```

Si el horario se crea correctamente, el evento `horario.creado` debe enviarse a auditoria.

---

## 7. Integracion Proyectos - Seguridad

El Project Service debe solicitar o validar permisos antes de acciones sensibles:

| Accion | Control requerido |
|---|---|
| Crear proyecto | Permiso de creacion y sede autorizada. |
| Registrar avance | Instructor o usuario asociado al proyecto/ficha. |
| Evaluar proyecto | Rol evaluador o coordinador autorizado. |
| Cerrar proyecto | Permiso especial y auditoria obligatoria. |
| Consultar reportes | Filtro por rol, permiso y sede. |

---

## 8. Integracion Horarios - Proyectos

Cuando se crea un horario, el Project Service puede actualizar el avance programado de la ficha o proyecto.

Ejemplo de evento:

```json
{
  "tipo": "horario.creado",
  "ficha_id": "uuid-ficha",
  "competencia_id": "uuid-competencia",
  "instructor_id": "uuid-instructor",
  "horas_asignadas": 4,
  "fecha": "2024-03-15"
}
```

Accion esperada:

- sumar horas programadas;
- actualizar porcentaje de cumplimiento;
- notificar si existe riesgo de atraso;
- registrar auditoria del evento.

---

## 9. Flujo integrado de ejemplo

```text
1. Coordinador inicia sesion.
2. Security Service entrega JWT con rol, permisos y sede.
3. Coordinador crea horario.
4. Schedule Service valida cruces y sede.
5. Schedule Service publica horario.creado.
6. Project Service actualiza horas asociadas a la ficha.
7. Notification Service avisa al instructor.
8. Audit Service registra la accion completa.
```

---

## 10. Criterios de consistencia

| Relacion | Tipo | Criterio |
|---|---|---|
| Security -> Todos | Validacion JWT | Tiempo real. |
| Schedule -> Project | Evento | Sincronizacion en segundos. |
| Ficha -> Schedule | Consulta | Tiempo real para vigencia y jornada. |
| Project -> Audit | Evento | Registro obligatorio de cambios sensibles. |
| Schedule -> Audit | Evento | Registro de creacion, cambio o rechazo. |

---

## 11. Conclusion

La integracion hace que horarios, proyectos y seguridad trabajen como una sola plataforma. Horarios define la operacion academica, proyectos mide avance y seguridad garantiza control, permisos y trazabilidad.
