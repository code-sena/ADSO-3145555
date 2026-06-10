# SENA - Resumen Ejecutivo

**Sistema Inteligente de Gestion de Horarios y Ambientes**  
**Proposito:** explicar el proyecto en una lectura rapida para presentacion o decision inicial.

---

## 1. Que es el proyecto

SIGHA SENA es una plataforma web para planear, validar, registrar y auditar horarios academicos del SENA. Su objetivo es evitar cruces de instructor, ambiente y ficha antes de guardar un horario, mejorando la trazabilidad y la toma de decisiones de coordinacion.

---

## 2. Problema principal

La programacion academica suele depender de validaciones manuales. Esto genera:

- cruces de horarios;
- ambientes mal asignados o sobreocupados;
- poca visibilidad de disponibilidad real;
- cambios sin trazabilidad suficiente;
- dificultad para saber quien hizo cada modificacion;
- reportes debiles para coordinacion.

---

## 3. Solucion propuesta

El sistema se organiza en tres pilares:

| Pilar | Valor principal |
|---|---|
| Horarios | Valida y registra la programacion academica sin cruces. |
| Proyectos Formativos | Relaciona la programacion con avance, horas y resultados academicos. |
| Seguridad | Controla usuarios, roles, permisos, sede activa y auditoria. |

Idea central:

```text
Planear horarios + validar reglas + auditar cambios = coordinacion confiable.
```

---

## 4. Arquitectura general

```text
Cliente web
    |
    v
API Gateway
    |
    v
Microservicios
    |
    v
PostgreSQL por servicio + eventos asincronos
```

Servicios principales:

| Servicio | Responsabilidad |
|---|---|
| Security Service | Autenticacion, autorizacion, roles, permisos y auditoria. |
| Catalog Service | Jornadas, ambientes, tipos y parametros base. |
| Academic Service | Programas, competencias e instructores. |
| Ficha Service | Fichas, franjas y aprendices. |
| Schedule Service | Motor de validacion y registro de horarios. |
| Project Service | Seguimiento de proyectos formativos. |

---

## 5. Beneficios esperados

| Indicador | Resultado esperado |
|---|---|
| Tiempo de creacion de horario | Reduccion significativa frente al proceso manual. |
| Cruces de horario | Prevencion antes de guardar la programacion. |
| Trazabilidad | Cada cambio queda asociado a usuario, fecha, sede y accion. |
| Ocupacion de ambientes | Mejor uso de espacios disponibles. |
| Incidencias | Registro y seguimiento mas claro. |
| Escalabilidad | Preparado para operar por sede, centro y regional. |

---

## 6. Alcance recomendado del MVP

El MVP debe incluir:

- login, roles y permisos;
- estructura institucional por sede;
- catalogos base;
- programas, competencias e instructores;
- ambientes y disponibilidad;
- fichas y franjas horarias;
- motor basico de horarios;
- observaciones e incidencias;
- auditoria y notificaciones internas.

Fuera del MVP:

- optimizacion automatica avanzada;
- inteligencia predictiva;
- integraciones externas;
- proyectos formativos completos;
- notificaciones masivas por canales externos.

---

## 7. Roadmap resumido

| Fase | Enfoque |
|---|---|
| Fase 1 | Seguridad, catalogos, fichas, ambientes y motor basico. |
| Fase 2 | Calendario, observaciones, reportes y validaciones ampliadas. |
| Fase 3 | Regionales, centros, varias sedes y disponibilidad real. |
| Fase 4 | Analitica, simulacion, recomendaciones y proyectos completos. |

---

## 8. Mensaje ejecutivo

SENA convierte la programacion academica en un proceso controlado, validado y auditable. El proyecto no solo guarda horarios: ayuda a evitar errores, mejora la visibilidad operativa y crea una base institucional para crecer hacia proyectos formativos, reportes y analitica.
