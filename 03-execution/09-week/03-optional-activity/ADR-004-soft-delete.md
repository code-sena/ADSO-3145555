# ADR-004: Implementación de Soft Delete en Tablas Críticas

## Estado

Propuesto

---

## Contexto

El esquema actual no tiene ningún mecanismo de eliminación lógica. Cuando se elimina una fila de tablas como `customer`, `ticket`, `reservation` o `aircraft`, el registro se pierde permanentemente. Esto rompe referencias en sistemas downstream, impide reconstruir el estado histórico y dificulta la recuperación ante errores operacionales.

---

## Decisión

Agregar columnas de soft delete en las tablas críticas del dominio: `customer`, `loyalty_account`, `ticket`, `reservation`, `flight`, `aircraft`.

```sql
ALTER TABLE customer
    ADD COLUMN is_deleted  boolean   NOT NULL DEFAULT false,
    ADD COLUMN deleted_at  timestamptz,
    ADD COLUMN deleted_by  uuid REFERENCES user_account(user_account_id);

-- Índice parcial para mantener performance en queries normales
CREATE INDEX idx_customer_active
    ON customer(customer_id)
    WHERE is_deleted = false;

-- Vista de compatibilidad hacia atrás
CREATE VIEW v_active_customer AS
    SELECT * FROM customer WHERE is_deleted = false;
```

Aplicar el mismo patrón a las demás tablas críticas listadas.

---

## Alternativas

- Eliminar físicamente y mantener una tabla de archivo separada (`customer_archive`)
- Implementar event sourcing para historia completa e inmutable

---

## Justificación

- Preserva el historial de negocio sin perder integridad referencial
- Permite recuperación de registros eliminados por error sin backups
- El índice parcial garantiza que el impacto en performance de queries activas sea mínimo
- Event sourcing es un cambio arquitectónico mayor fuera del alcance actual

---

## Consecuencias

**Positivas**

- Historia de negocio preservada indefinidamente
- Recuperación de datos sin restaurar backups
- Sin roturas de FK en sistemas downstream

**Negativas**

- Todas las queries de la capa de aplicación deben agregar `WHERE is_deleted = false`
- Las vistas `v_active_*` mitigan esto pero añaden una capa de indirección
- El almacenamiento crece con el tiempo al no eliminar físicamente registros
