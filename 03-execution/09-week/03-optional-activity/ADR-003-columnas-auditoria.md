# ADR-003: Columnas de Auditoría en Tablas Operacionales

## Estado

Propuesto

---

## Contexto

Las tablas operacionales críticas del sistema (`miles_transaction`, `flight_delay`, `boarding_validation`, `payment_transaction`) no registran qué usuario realizó cada operación. Solo existe `created_at` y `updated_at`, pero no `created_by` ni `updated_by`. Esto impide reconstruir la trazabilidad de acciones individuales y no cumple con los requisitos de auditoría de estándares aeronáuticos como IOSA.

---

## Decisión

Agregar columnas `created_by` y `updated_by` en todas las tablas operacionales críticas, referenciando `user_account`:

```sql
ALTER TABLE miles_transaction
    ADD COLUMN created_by uuid REFERENCES user_account(user_account_id),
    ADD COLUMN updated_by uuid REFERENCES user_account(user_account_id);

ALTER TABLE flight_delay
    ADD COLUMN created_by uuid REFERENCES user_account(user_account_id),
    ADD COLUMN updated_by uuid REFERENCES user_account(user_account_id);

-- Aplicar igualmente a: boarding_validation, payment_transaction
```

---

## Alternativas

- Implementar auditoría mediante triggers que escriban a una tabla de log separada
- Usar extensiones de auditoría de PostgreSQL como `pgaudit`

---

## Justificación

- Cumplimiento de estándares IOSA/IATA que exigen trazabilidad de operaciones
- Permite reconstruir quién realizó cada transacción para resolución de disputas
- Más simple de consultar que logs externos: el dato vive en la misma tabla
- Los triggers añaden complejidad operacional y dependencia de lógica en la base de datos

---

## Consecuencias

**Positivas**

- Trail de auditoría completo en tablas críticas
- Consultas de auditoría simples con SQL estándar
- Cumplimiento regulatorio IOSA

**Negativas**

- Las columnas son `NULL`able para registros pre-migración, lo que requiere manejo especial en reportes de auditoría
- La capa de aplicación debe propagar el `user_account_id` en cada operación de escritura
