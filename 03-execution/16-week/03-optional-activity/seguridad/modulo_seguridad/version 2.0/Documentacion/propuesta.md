# PRJ-EDU-HORARIOS - Propuesta del Proyecto

**Nombre recomendado:** SIGHA SENA - Sistema Inteligente de Gestion de Horarios y Ambientes  
**Enfoque:** MVP institucional escalable  
**Objetivo:** mejorar la programacion academica mediante validaciones, trazabilidad y organizacion por sede.

---

## 1. Vision

El proyecto debe evolucionar de un sistema que registra horarios a una plataforma de gestion academica operativa. Su valor no esta solo en almacenar datos, sino en prevenir conflictos antes de que afecten la formacion.

La plataforma debe responder cuatro preguntas:

- quien puede orientar una competencia;
- donde se puede orientar;
- cuando puede programarse;
- que impacto tiene esa programacion en fichas, ambientes, instructores y aprendices.

---

## 2. Problema que resuelve

La programacion academica puede presentar:

- cruces de instructor, ambiente o ficha;
- asignaciones manuales sin validacion suficiente;
- ambientes sin visibilidad real de disponibilidad;
- instructores asignados sin confirmar habilitacion;
- cambios sin historial claro;
- dificultad para generar indicadores confiables.

La propuesta convierte estos controles manuales en reglas del sistema.

---

## 3. Propuesta de valor

| Nivel | Valor |
|---|---|
| Operativo | Reduce cruces y mejora la programacion diaria. |
| Academico | Relaciona horarios con programas, competencias y fichas. |
| Institucional | Permite trazabilidad, reportes y escalamiento por sede, centro y regional. |

---

## 4. Alcance del MVP

El MVP debe concentrarse en funcionalidades que entregan valor inmediato:

- seguridad y roles;
- usuarios y sesiones;
- estructura institucional basica;
- catalogos base;
- programas, competencias e instructores;
- ambientes y disponibilidad;
- fichas y franjas horarias;
- motor de horarios sin cruces;
- observaciones e incidencias;
- auditoria basica;
- notificaciones internas.

---

## 5. Fuera del MVP

Se recomienda dejar para versiones posteriores:

- optimizacion automatica de horarios;
- analitica predictiva;
- integracion con sistemas externos;
- proyectos formativos completos;
- evaluacion individual de aprendices;
- notificaciones masivas por WhatsApp, SMS o correo.

---

## 6. Modulos funcionales propuestos

| Prioridad | Modulo | Papel dentro del sistema |
|---|---|---|
| Alta | Seguridad y Acceso | Controla identidad, roles, permisos, sesiones y auditoria. |
| Alta | Estructura Institucional | Permite operar por sede y escalar a centro/regional. |
| Alta | Catalogos Base | Centraliza jornadas, tipos, estados y parametros. |
| Alta | Programas y Competencias | Define la oferta academica y competencias. |
| Alta | Instructores | Controla perfiles, contratos y habilitaciones. |
| Alta | Ambientes | Gestiona espacios, recursos y disponibilidad. |
| Alta | Fichas y Franjas | Controla grupos, vigencias y bloques de tiempo. |
| Critica | Motor de Horarios | Valida y registra la programacion. |
| Alta | Observaciones | Gestiona incidencias y novedades. |
| Media | Proyectos Formativos | Conecta programacion con seguimiento academico futuro. |
| Alta | Auditoria y Notificaciones | Conserva historial y comunica eventos relevantes. |

---

## 7. Reglas de negocio principales

El motor de horarios debe validar:

1. El instructor no puede tener dos horarios en la misma fecha y franja.
2. El ambiente no puede tener dos fichas en la misma fecha y franja.
3. La ficha no puede tener dos bloques simultaneos.
4. La ficha debe estar vigente.
5. Instructor, ambiente y ficha deben estar activos.
6. El instructor debe estar habilitado para la competencia.
7. El ambiente debe pertenecer a la sede correspondiente.
8. La capacidad del ambiente debe cubrir el numero de aprendices.
9. La franja debe ser compatible con la jornada.
10. El ambiente no debe estar bloqueado.
11. El instructor no debe tener novedad en esa franja.
12. Todo cambio posterior debe quedar auditado.

---

## 8. Modelo de crecimiento

La estructura institucional recomendada es:

```text
regional -> centro_formacion -> sede
```

Esta separacion permite reportar, filtrar y escalar el sistema sin mezclar datos de diferentes sedes.

Tablas clave para el crecimiento:

| Tabla | Motivo |
|---|---|
| `regional` | Agrupa centros por regional. |
| `centro_formacion` | Separa centros de sedes fisicas. |
| `sede` | Define el aislamiento operativo principal. |
| `disponibilidad_instructor` | Evita asignaciones fuera de disponibilidad. |
| `novedad_instructor` | Registra incapacidades, permisos o bloqueos. |
| `validacion_horario` | Guarda motivos de aprobacion o rechazo. |
| `cambio_horario` | Conserva historial de modificaciones. |
| `proyecto_formativo` | Permite evolucion hacia seguimiento academico. |

---

## 9. Flujos principales

### Crear horario

1. Coordinador selecciona ficha.
2. Sistema carga sede, jornada y programa.
3. Coordinador selecciona competencia.
4. Sistema muestra instructores habilitados.
5. Coordinador selecciona fecha, franja y ambiente.
6. Motor ejecuta validaciones.
7. Si no hay conflictos, guarda horario.
8. Sistema registra auditoria y notifica actores relacionados.

### Reprogramar bloque

1. Coordinador selecciona horario existente.
2. Ingresa motivo del cambio.
3. Sistema valida nuevos datos.
4. Guarda historial del cambio.
5. Notifica a los usuarios afectados.

### Registrar incidencia

1. Usuario reporta observacion.
2. Selecciona tipo, severidad y entidad relacionada.
3. Coordinacion revisa y cambia estado.
4. Sistema guarda historial y notifica resultado.

---

## 10. Indicadores del proyecto

| Indicador | Utilidad |
|---|---|
| Cruces evitados | Mide efectividad del motor. |
| Ocupacion de ambientes | Mide uso de espacios fisicos. |
| Carga docente | Controla horas por instructor. |
| Tiempo de programacion | Mide eficiencia operativa. |
| Incidencias abiertas | Mide estabilidad de la programacion. |
| Tiempo de resolucion | Mide capacidad de respuesta. |
| Cumplimiento de horas | Relaciona horarios con avance academico. |

---

## 11. Roadmap recomendado

| Fase | Entregables |
|---|---|
| Fase 1 | Seguridad, catalogos, programas, instructores, ambientes, fichas y motor basico. |
| Fase 2 | Calendario, buscador de ambientes, observaciones y reportes. |
| Fase 3 | Regionales, centros, disponibilidad real, cambios con aprobacion e indicadores. |
| Fase 4 | Simulador, sugerencias, alertas, analitica y proyectos formativos completos. |

---

## 12. Version final recomendada

SIGHA SENA debe presentarse como una plataforma institucional para planear, validar, registrar y auditar horarios academicos, conectando fichas, instructores, ambientes, competencias y sedes.

La propuesta es seria porque tiene problema claro, MVP realizable, reglas verificables, indicadores medibles y ruta de crecimiento.
