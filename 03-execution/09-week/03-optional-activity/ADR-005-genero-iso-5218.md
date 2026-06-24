# ADR-005: Tabla de Catálogo para Género con Soporte ISO 5218

## Estado

Propuesto

---

## Contexto

La tabla `person` almacena el género en una columna `gender_code varchar(1)` con un `CHECK` que permite `F`, `M`, `X` o `NULL`. Este esquema no cumple con el estándar ISO 5218 (*Representation of human sexes in information systems*), que define códigos numéricos para uso en documentos oficiales internacionales. Adicionalmente, no existe tabla de catálogo que permita agregar nuevos valores o descripciones localizadas.

---

## Decisión

Crear una tabla `gender_type` alineada con ISO 5218 y migrar la columna `gender_code` de `person` a una FK:

```sql
CREATE TABLE gender_type (
    gender_type_id uuid    PRIMARY KEY DEFAULT gen_random_uuid(),
    iso_code       varchar(1) NOT NULL,
    gender_name    varchar(60) NOT NULL,
    CONSTRAINT uq_gender_iso_code UNIQUE (iso_code)
);

INSERT INTO gender_type (iso_code, gender_name) VALUES
    ('0', 'Not known'),
    ('1', 'Male'),
    ('2', 'Female'),
    ('9', 'Not applicable');

ALTER TABLE person
    ADD COLUMN gender_type_id uuid
        REFERENCES gender_type(gender_type_id);

-- Después de migrar datos:
-- ALTER TABLE person DROP COLUMN gender_code;
```

---

## Alternativas

- Actualizar el `CHECK` constraint para incluir los códigos ISO 5218 (`0`, `1`, `2`, `9`)
- Mantener el esquema actual y mapear en la capa de aplicación

---

## Justificación

- Cumplimiento con ISO 5218, requerido para documentos de viaje internacionales
- La tabla de catálogo permite agregar atributos como nombre localizado o descripción legal
- Consistente con la decisión ADR-002 de reemplazar `CHECK` por tablas de catálogo

---

## Consecuencias

**Positivas**

- Conformidad con ISO 5218
- Extensible sin cambios de DDL
- Soporte para localización de etiquetas de género

**Negativas**

- Requiere migración de datos: mapear `F`→`2`, `M`→`1`, `X`→`9`
- Los registros con `gender_code = NULL` quedarán sin `gender_type_id` hasta revisión manual
