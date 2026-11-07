# Inventario de tablas de la base de datos

Este inventario se obtuvo de forma estática desde las sentencias `CREATE TABLE` de `PT_HS/BD_HS/01_ddl` en `main`, SHA `32be1cf787f20120dfd3b4cc72226dab55d88216` (consulta 2026-11-05). HU-21 solo modificó la carga del perfil en el frontend, por lo que el conjunto de migraciones consultado no cambió. No consulta Neon y no demuestra qué migraciones están aplicadas en un entorno.

El corte contiene **57 tablas en nueve esquemas**. La lista identifica tablas, no columnas: las columnas, tipos, claves, restricciones y políticas se deben leer en las migraciones Liquibase. Para una base desplegada, comparar `liquibase status --verbose` y `DATABASECHANGELOG` antes de usar este inventario como descripción del esquema vivo.

El [modelo entidad-relación](entity-relationship.md) presenta relaciones conceptuales seleccionadas. Las migraciones son la fuente normativa del modelo físico.

## `user_account`

Identidades, perfiles, credenciales, roles, sesiones, tokens y autenticación.

| Tabla |
| --- |
| `email_verification_token` |
| `login_attempt` |
| `password_policy` |
| `password_reset_token` |
| `permission` |
| `role` |
| `role_permission` |
| `session` |
| `token` |
| `user_account` |
| `user_credential` |
| `user_mfa` |
| `user_profile` |
| `user_role` |

## `preference`

Preferencias de idioma, moneda y tema.

| Tabla |
| --- |
| `currency` |
| `language` |
| `theme` |
| `user_preference` |

## `home`

Hogares, membresías, asociaciones, metas y modo de vacaciones.

| Tabla |
| --- |
| `home` |
| `home_device` |
| `home_member_request` |
| `home_user` |
| `home_user_function` |
| `saving_goal` |
| `vacation_mode` |

## `device`

Dispositivos, actuadores, grupos lógicos e historial/calibración.

| Tabla |
| --- |
| `actuator_command` |
| `actuator_state` |
| `calibration_history` |
| `device` |
| `device_history` |
| `device_telemetry_history` |
| `logical_device_group_member` |

## `consumption`

Lecturas, agregados y predicciones de consumo.

| Tabla |
| --- |
| `consumption_prediction` |
| `daily_consumption_summary` |
| `hourly_consumption_history` |
| `monthly_consumption_history` |
| `sensor_reading` |

## `alert_rate`

Reglas/eventos/notificaciones de alertas y tarifas.

| Tabla |
| --- |
| `alert_event` |
| `alert_notification` |
| `alert_rule` |
| `estratos` |
| `home_rate` |
| `reference_rate` |
| `threshold_configuration` |

## `analytics_support`

Reportes, recomendaciones y solicitudes de soporte.

| Tabla |
| --- |
| `generated_report` |
| `recommendation` |
| `recommendation_category` |
| `ticket` |
| `ticket_category` |
| `ticket_priority` |
| `ticket_response` |
| `ticket_status` |
| `user_recommendation` |

## `audit`

Auditoría y registro de errores.

| Tabla |
| --- |
| `audit_log` |
| `log_error` |

## `privacy`

Consentimientos y solicitudes ARCO.

| Tabla |
| --- |
| `arco_request` |
| `user_consent` |

## Comprobación del conteo

57 nombres de tabla distintos distribuidos en nueve esquemas fueron detectados en el DDL del corte indicado. El conteo no equivale a contar cambios aplicados, y una misma tabla puede aparecer en varias migraciones de alteración.
