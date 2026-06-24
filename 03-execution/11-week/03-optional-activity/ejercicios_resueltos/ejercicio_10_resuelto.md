# Ejercicio 10 Resuelto - Identidad de pasajeros, documentos y medios de contacto

# Modelo de datos base del sistema

## 1. Descripción general del modelo
El modelo de datos corresponde a un sistema integral de aerolínea, diseñado para soportar de forma relacional los procesos principales del negocio: gestión geográfica, identidad de personas, seguridad, clientes, fidelización, aeropuertos, aeronaves, operación de vuelos, reservas, tiquetes, abordaje, pagos y facturación.

Se trata de un modelo amplio y normalizado, en el que las entidades están separadas por dominios funcionales y conectadas mediante llaves foráneas para garantizar trazabilidad, integridad y consistencia en todo el flujo operativo y comercial.

---

## 2. Resumen previo del análisis realizado
Como base de trabajo, previamente se identificó y organizó el script en dominios funcionales. A partir de esa revisión, se determinó que el modelo no corresponde a un caso pequeño o aislado, sino a una solución empresarial con múltiples áreas del negocio conectadas entre sí.

También se verificó que:
- el modelo contiene más de 60 entidades,
- las relaciones entre tablas siguen una estructura consistente,
- existen restricciones de integridad mediante `PRIMARY KEY`, `FOREIGN KEY`, `UNIQUE` y `CHECK`,
- el diseño soporta trazabilidad end-to-end desde la reserva hasta el pago, abordaje y facturación.

---

## 3. Dominios del modelo y propósito general

### GEOGRAPHY AND REFERENCE DATA
**Entidades:** `time_zone`, `continent`, `country`, `state_province`, `city`, `district`, `address`, `currency`  
**Resumen:** Centraliza información geográfica y de referencia para ubicar aeropuertos, personas, proveedores y definir monedas operativas del sistema.

### AIRLINE
**Entidades:** `airline`  
**Resumen:** Representa la aerolínea operadora del sistema, incluyendo sus códigos y país base.

### IDENTITY
**Entidades:** `person_type`, `document_type`, `contact_type`, `person`, `person_document`, `person_contact`  
**Resumen:** Permite modelar la identidad de las personas, sus documentos y medios de contacto.

### SECURITY
**Entidades:** `user_status`, `security_role`, `security_permission`, `user_account`, `user_role`, `role_permission`  
**Resumen:** Administra autenticación, autorización y control de acceso al sistema.

### CUSTOMER AND LOYALTY
**Entidades:** `customer_category`, `benefit_type`, `loyalty_program`, `loyalty_tier`, `customer`, `loyalty_account`, `loyalty_account_tier`, `miles_transaction`, `customer_benefit`  
**Resumen:** Gestiona clientes, programas de fidelización, acumulación de millas, beneficios y niveles.

### AIRPORT
**Entidades:** `airport`, `terminal`, `boarding_gate`, `runway`, `airport_regulation`  
**Resumen:** Modela la infraestructura aeroportuaria y las condiciones regulatorias asociadas a cada aeropuerto.

### AIRCRAFT
**Entidades:** `aircraft_manufacturer`, `aircraft_model`, `cabin_class`, `aircraft`, `aircraft_cabin`, `aircraft_seat`, `maintenance_provider`, `maintenance_type`, `maintenance_event`  
**Resumen:** Gestiona aeronaves, fabricantes, configuración interna y procesos de mantenimiento.

### FLIGHT OPERATIONS
**Entidades:** `flight_status`, `delay_reason_type`, `flight`, `flight_segment`, `flight_delay`  
**Resumen:** Controla la operación de vuelos, sus segmentos, estados y retrasos.

### SALES, RESERVATION, TICKETING
**Entidades:** `reservation_status`, `sale_channel`, `fare_class`, `fare`, `ticket_status`, `reservation`, `reservation_passenger`, `sale`, `ticket`, `ticket_segment`, `seat_assignment`, `baggage`  
**Resumen:** Gestiona el flujo comercial principal: reserva, pasajero, venta, emisión de tiquetes, asignación de asiento y equipaje.

### BOARDING
**Entidades:** `boarding_group`, `check_in_status`, `check_in`, `boarding_pass`, `boarding_validation`  
**Resumen:** Soporta el proceso de check-in, emisión de pase de abordar y validación final de embarque.

### PAYMENT
**Entidades:** `payment_status`, `payment_method`, `payment`, `payment_transaction`, `refund`  
**Resumen:** Administra pagos, transacciones y devoluciones asociadas a las ventas.

### BILLING
**Entidades:** `tax`, `exchange_rate`, `invoice_status`, `invoice`, `invoice_line`  
**Resumen:** Gestiona impuestos, tasas de cambio, facturas y detalle facturable.

---

## 4. Restricción general para todos los ejercicios
Todos los ejercicios se resuelven respetando estrictamente el modelo entregado.

No se cambia:
- ningún atributo existente,
- nombres de tablas o columnas,
- relaciones del modelo,
- ni la estructura general del script base.

---

## 5. Contexto del ejercicio
El área de servicio al cliente necesita consultar la identidad completa del pasajero, sus documentos y datos de contacto, y automatizar una acción posterior cuando se registre un nuevo documento de identidad. Adicionalmente, se requiere encapsular el registro de nuevos documentos en un procedimiento almacenado reutilizable.

---

## 6. Dominios involucrados
### IDENTITY
**Entidades:** `person`, `person_type`, `person_document`, `document_type`, `person_contact`, `contact_type`  
**Propósito en este ejercicio:** gestionar la identidad completa del pasajero: datos personales, documentos y medios de contacto.

### CUSTOMER AND LOYALTY
**Entidades:** `customer`  
**Propósito en este ejercicio:** relacionar la persona con su rol como cliente registrado en el sistema.

### SALES, RESERVATION, TICKETING
**Entidades:** `reservation_passenger`, `reservation`  
**Propósito en este ejercicio:** vincular la identidad del pasajero con su participación en reservas activas.

---

## 7. Problema a resolver
La organización necesita una visión integrada de los pasajeros registrados que muestre su identidad, documentos y medios de contacto junto con su participación en reservas. Adicionalmente, se desea que al registrar un nuevo documento de identidad se genere automáticamente un registro de auditoría trazable, y que el proceso de registro de documentos quede centralizado en un procedimiento almacenado.

El modelo ya posee todas las tablas necesarias. Sin embargo, si la inserción de documentos se realiza de forma directa y dispersa, el flujo queda expuesto a duplicidades y omisiones de trazabilidad.

Por eso se plantea una solución en tres capas:
1. una consulta consolidada con `INNER JOIN`,
2. un trigger `AFTER INSERT` sobre `person_document`,
3. un procedimiento almacenado que centralice el registro del documento.

---

## 8. Solución propuesta

### 8.1 Consulta resuelta con `INNER JOIN`
Se construyó una consulta que conecta ocho tablas reales del modelo. La consulta muestra la identidad completa del pasajero: tipo de persona, documento, contacto y participación en reservas.

```sql
SELECT
    p.first_name                        AS nombre,
    p.last_name                         AS apellido,
    pt.person_type_name                 AS tipo_persona,
    dt.document_type_name               AS tipo_documento,
    pd.document_number                  AS numero_documento,
    pd.expiration_date                  AS vencimiento_documento,
    ct.contact_type_name                AS tipo_contacto,
    pc.contact_value                    AS valor_contacto,
    r.reservation_code                  AS reserva,
    rp.sequence_number                  AS secuencia_pasajero
FROM person p
INNER JOIN person_type pt
    ON pt.person_type_id = p.person_type_id
INNER JOIN person_document pd
    ON pd.person_id = p.person_id
INNER JOIN document_type dt
    ON dt.document_type_id = pd.document_type_id
INNER JOIN person_contact pc
    ON pc.person_id = p.person_id
INNER JOIN contact_type ct
    ON ct.contact_type_id = pc.contact_type_id
INNER JOIN reservation_passenger rp
    ON rp.person_id = p.person_id
INNER JOIN reservation r
    ON r.reservation_id = rp.reservation_id
ORDER BY p.last_name, p.first_name, pd.document_number;
```

### 8.2 Explicación paso a paso de la consulta
1. **`person`** es el eje central: aporta el nombre y apellido del pasajero.
2. **`person_type`** clasifica la persona según su rol en el sistema.
3. **`person_document`** aporta el número y vencimiento del documento registrado.
4. **`document_type`** describe el tipo de documento (pasaporte, cédula, etc.).
5. **`person_contact`** aporta el valor del medio de contacto registrado (correo, teléfono, etc.).
6. **`contact_type`** describe el tipo de contacto asociado.
7. **`reservation_passenger`** vincula al pasajero con una reserva y aporta su número de secuencia.
8. **`reservation`** cierra el flujo mostrando el código comercial de la reserva.

La solución usa `INNER JOIN` porque el objetivo es listar únicamente pasajeros que tienen documentos, contactos y participación en reservas registrados de forma completa.

---

## 9. Trigger resuelto

### 9.1 Decisión técnica
Se diseñó un trigger `AFTER INSERT ON person_document` que al registrar un nuevo documento de identidad genera automáticamente un segundo registro de contacto de auditoría en `person_contact`, usando el tipo de contacto disponible en el sistema como referencia interna. Esto permite evidenciar en `person_contact` que la identidad del pasajero fue actualizada con un nuevo documento.

> El tipo de contacto se obtiene dinámicamente del primer registro disponible en `contact_type`, lo que garantiza que la solución funciona sobre datos reales sin alterar el modelo.

### 9.2 Lógica implementada
- Al insertar un nuevo documento en `person_document`, el trigger verifica si ya existe un contacto de auditoría documental para esa persona en `person_contact` con el valor derivado del número de documento.
- Si no existe, genera un nuevo registro en `person_contact` con:
  - el `person_id` del documento recién insertado,
  - el primer `contact_type_id` disponible en el sistema,
  - un `contact_value` que incluye el tipo y número de documento para trazabilidad.

### 9.3 Script del trigger

```sql
DROP TRIGGER IF EXISTS trg_ai_person_document_audit_contact ON person_document;
DROP FUNCTION IF EXISTS fn_ai_person_document_audit_contact();

CREATE OR REPLACE FUNCTION fn_ai_person_document_audit_contact()
RETURNS trigger
LANGUAGE plpgsql
AS $$
DECLARE
    v_contact_type_id uuid;
    v_contact_value   varchar(200);
BEGIN
    v_contact_value := 'DOC-AUDIT:' || NEW.document_number;

    -- Verificar si ya existe un contacto de auditoría para este documento
    IF EXISTS (
        SELECT 1
        FROM person_contact pc
        WHERE pc.person_id = NEW.person_id
          AND pc.contact_value = v_contact_value
    ) THEN
        RETURN NEW;
    END IF;

    -- Obtener el primer tipo de contacto disponible
    SELECT ct.contact_type_id
    INTO v_contact_type_id
    FROM contact_type ct
    ORDER BY ct.created_at
    LIMIT 1;

    IF v_contact_type_id IS NULL THEN
        RETURN NEW;
    END IF;

    INSERT INTO person_contact (
        person_id,
        contact_type_id,
        contact_value
    )
    VALUES (
        NEW.person_id,
        v_contact_type_id,
        v_contact_value
    );

    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_ai_person_document_audit_contact
AFTER INSERT ON person_document
FOR EACH ROW
EXECUTE FUNCTION fn_ai_person_document_audit_contact();
```

### 9.4 Por qué esta solución es correcta
- No cambia ninguna tabla del modelo.
- Opera exclusivamente sobre tablas reales del dominio IDENTITY: `person_document` y `person_contact`.
- El efecto del trigger es verificable directamente en `person_contact`.
- Mantiene coherencia con el modelo: `person_contact` ya está diseñada para registrar múltiples medios de contacto por persona.
- Automatiza la trazabilidad documental sin intervención manual.

---

## 10. Procedimiento almacenado resuelto

### 10.1 Objetivo
Centralizar el registro de un nuevo documento de identidad para una persona existente, asegurando que no se dupliquen documentos del mismo tipo y número, y que el trigger de auditoría se active automáticamente.

### 10.2 Decisión técnica
El procedimiento valida primero que no exista ya un documento con el mismo `document_type_id` y `document_number` para la misma persona. Luego realiza la inserción en `person_document`, lo que dispara automáticamente el trigger `trg_ai_person_document_audit_contact`.

### 10.3 Script del procedimiento

```sql
CREATE OR REPLACE PROCEDURE sp_register_person_document(
    p_person_id          uuid,
    p_document_type_id   uuid,
    p_document_number    varchar,
    p_issue_date         date,
    p_expiration_date    date,
    p_issuing_country_id uuid
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Validar que no exista el mismo documento para la misma persona
    IF EXISTS (
        SELECT 1
        FROM person_document pd
        WHERE pd.person_id = p_person_id
          AND pd.document_type_id = p_document_type_id
          AND pd.document_number = p_document_number
    ) THEN
        RAISE EXCEPTION 'Ya existe un documento del mismo tipo y número para la persona %', p_person_id;
    END IF;

    INSERT INTO person_document (
        person_id,
        document_type_id,
        document_number,
        issue_date,
        expiration_date,
        issuing_country_id
    )
    VALUES (
        p_person_id,
        p_document_type_id,
        p_document_number,
        p_issue_date,
        p_expiration_date,
        p_issuing_country_id
    );
END;
$$;
```

### 10.4 Por qué esta solución es correcta
- Encapsula el registro de documentos en una sola unidad lógica reutilizable.
- Evita duplicados por tipo y número de documento dentro de la misma persona.
- Al insertar en `person_document`, activa automáticamente el trigger `trg_ai_person_document_audit_contact`.
- Se alinea con el flujo real del negocio: primero se registra el documento de identidad y luego queda trazada la auditoría en `person_contact`.

---

## 11. Script de demostración del funcionamiento

```sql
DO $$
DECLARE
    v_person_id          uuid;
    v_document_type_id   uuid;
    v_issuing_country_id uuid;
    v_document_number    varchar := 'TEST-DOC-' || to_char(now(), 'HH24MISS');
BEGIN
    -- Obtener la primera persona disponible
    SELECT p.person_id
    INTO v_person_id
    FROM person p
    ORDER BY p.created_at
    LIMIT 1;

    -- Obtener el primer tipo de documento disponible
    SELECT dt.document_type_id
    INTO v_document_type_id
    FROM document_type dt
    ORDER BY dt.created_at
    LIMIT 1;

    -- Obtener el primer país disponible como país emisor
    SELECT c.country_id
    INTO v_issuing_country_id
    FROM country c
    ORDER BY c.created_at
    LIMIT 1;

    -- Validaciones previas
    IF v_person_id IS NULL THEN
        RAISE EXCEPTION 'No existe persona disponible.';
    END IF;

    IF v_document_type_id IS NULL THEN
        RAISE EXCEPTION 'No existe tipo de documento disponible.';
    END IF;

    IF v_issuing_country_id IS NULL THEN
        RAISE EXCEPTION 'No existe país disponible como emisor.';
    END IF;

    -- Invocar el procedimiento de registro de documento
    CALL sp_register_person_document(
        v_person_id,
        v_document_type_id,
        v_document_number,
        current_date - interval '5 years',
        current_date + interval '5 years',
        v_issuing_country_id
    );
END;
$$;

-- Validación 1: confirmar el documento registrado
SELECT
    p.first_name,
    p.last_name,
    dt.document_type_name,
    pd.document_number,
    pd.issue_date,
    pd.expiration_date
FROM person_document pd
INNER JOIN person p
    ON p.person_id = pd.person_id
INNER JOIN document_type dt
    ON dt.document_type_id = pd.document_type_id
ORDER BY pd.created_at DESC
LIMIT 5;

-- Validación 2: confirmar el registro de auditoría generado por el trigger en person_contact
SELECT
    pc.person_contact_id,
    p.first_name,
    p.last_name,
    ct.contact_type_name,
    pc.contact_value,
    pc.created_at
FROM person_contact pc
INNER JOIN person p
    ON p.person_id = pc.person_id
INNER JOIN contact_type ct
    ON ct.contact_type_id = pc.contact_type_id
WHERE pc.contact_value LIKE 'DOC-AUDIT:%'
ORDER BY pc.created_at DESC
LIMIT 5;
```

### 11.1 Qué demuestra este script
1. Busca una persona, un tipo de documento y un país emisor disponibles en el modelo.
2. Valida que los identificadores necesarios existan antes de proceder.
3. Ejecuta el procedimiento almacenado `sp_register_person_document` con un número de documento único generado dinámicamente.
4. El procedimiento inserta el registro en `person_document`.
5. El trigger `trg_ai_person_document_audit_contact` se dispara automáticamente.
6. La primera validación confirma que el documento fue registrado correctamente con su tipo y fechas.
7. La segunda validación confirma que el registro de auditoría fue generado por el trigger en `person_contact`.

---

## 12. Validación final
La solución es válida porque:
- la consulta usa `INNER JOIN` en ocho tablas reales del modelo,
- el trigger es `AFTER INSERT` y produce un efecto verificable sobre `person_contact`,
- el procedimiento almacenado es reutilizable y encapsula el registro de documentos de identidad,
- la demostración prueba la ejecución completa del flujo de extremo a extremo,
- no se alteró ningún atributo, tabla ni relación del modelo base.

---

## 13. Archivos SQL relacionados
- `scripts_sql/ejercicio_10_setup.sql`
- `scripts_sql/ejercicio_10_demo.sql`