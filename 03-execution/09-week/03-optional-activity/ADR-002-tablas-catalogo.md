# ADR-002: Tablas de Catálogo en lugar de CHECK Constraints para Tipos de Dominio

## Estado

Propuesto

---

## Contexto

Varias tablas del esquema (`miles_transaction`, `baggage`, `reservation_passenger`, `seat_assignment`) modelan columnas de tipo enumerado usando `VARCHAR` con restricciones `CHECK`. Esto incluye `transaction_type`, `baggage_type`, `baggage_status`, `passenger_type` y `assignment_source`. Agregar nuevos valores requiere ejecutar `ALTER TABLE` en producción, lo que implica bloqueos y riesgo operacional.

---

## Decisión

Reemplazar todas las columnas `VARCHAR + CHECK` de dominio enumerado por columnas FK que apunten a tablas de catálogo dedicadas, siguiendo el patrón:

```sql
CREATE TABLE transaction_type (
    transaction_type_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    type_code  varchar(20) NOT NULL,
    type_name  varchar(80) NOT NULL,
    CONSTRAINT uq_transaction_type_code UNIQUE (type_code)
);

ALTER TABLE miles_transaction
    ADD COLUMN transaction_type_id uuid
        REFERENCES transaction_type(transaction_type_id);
```

Aplicar el mismo patrón a: `baggage_type`, `baggage_status`, `passenger_type`, `assignment_source`.

---

## Alternativas

- Mantener `CHECK` constraints y documentar los valores en comentarios de columna
- Usar tipos `ENUM` nativos de PostgreSQL

---

## Justificación

- Permite agregar nuevos valores sin `ALTER TABLE` en producción
- Habilita atributos adicionales por tipo (descripciones, traducciones, flags de activo)
- Consistente con el resto del esquema que ya usa tablas de catálogo (`flight_status`, `ticket_status`, etc.)
- Los `ENUM` de PostgreSQL requieren `ALTER TYPE` bloqueante para agregar valores y no son portables

---

## Consecuencias

**Positivas**

- Extensibilidad sin downtime
- Posibilidad de internacionalización de etiquetas
- Consistencia arquitectónica en todo el esquema

**Negativas**

- Aumenta el número de tablas en ~6-8
- Los JOINs de consultas comunes se vuelven más verbosos
- Requiere migración de datos existentes antes de eliminar las columnas originales
