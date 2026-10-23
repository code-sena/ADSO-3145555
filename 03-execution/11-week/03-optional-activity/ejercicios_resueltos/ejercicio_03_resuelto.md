# Ejercicio 03 Resuelto - Facturación e integración entre venta, impuestos y detalle facturable

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
El área de facturación necesita relacionar ventas, facturas y líneas facturables con impuestos aplicados para validar la consistencia del flujo comercial y automatizar el recalculo del total de la factura cada vez que se registre una nueva línea facturable.

---

## 6. Dominios involucrados
### SALES, RESERVATION, TICKETING
**Entidades:** `sale`, `reservation`  
**Propósito en este ejercicio:** proveer el origen comercial de la facturación.

### BILLING
**Entidades:** `invoice`, `invoice_status`, `invoice_line`, `tax`, `exchange_rate`  
**Propósito en este ejercicio:** gestionar factura, estado, detalle facturable e impuestos dentro del flujo de facturación.

### GEOGRAPHY AND REFERENCE DATA
**Entidades:** `currency`  
**Propósito en este ejercicio:** normalizar la moneda de la venta y de la factura.

---

## 7. Problema a resolver
Se requiere consultar el detalle facturable derivado de una venta y automatizar el recalculo del total de la factura cada vez que se inserte una nueva línea facturable, manteniendo coherencia entre la cabecera de la factura y sus líneas asociadas.

El modelo ya posee las tablas necesarias para almacenar tanto la factura como sus líneas. Sin embargo, si el total de la factura se gestiona manualmente, el flujo queda expuesto a inconsistencias entre la cabecera y el detalle facturable.

Por eso se plantea una solución en tres capas:
1. una consulta consolidada con `INNER JOIN`,
2. un trigger `AFTER INSERT` sobre `invoice_line`,
3. un procedimiento almacenado que centralice el registro del detalle facturable.

---

## 8. Solución propuesta

### 8.1 Consulta resuelta con `INNER JOIN`
Se eligió una consulta que conecta seis tablas reales del modelo. La consulta muestra la trazabilidad completa del flujo de facturación: venta, factura, estado, línea facturable, impuesto y moneda.

```sql
SELECT
    s.sale_code,
    i.invoice_number,
    ist.status_name       AS estado_factura,
    il.line_number        AS linea_facturable,
    il.description        AS descripcion_linea,
    il.quantity,
    il.unit_price         AS precio_unitario,
    t.tax_name            AS impuesto_aplicado,
    c.currency_code       AS moneda
FROM sale s
INNER JOIN invoice i
    ON i.sale_id = s.sale_id
INNER JOIN invoice_status ist
    ON ist.invoice_status_id = i.invoice_status_id
INNER JOIN invoice_line il
    ON il.invoice_id = i.invoice_id
INNER JOIN tax t
    ON t.tax_id = il.tax_id
INNER JOIN currency c
    ON c.currency_id = i.currency_id
ORDER BY i.invoice_number, il.line_number;
```

### 8.2 Explicación paso a paso de la consulta
1. **`sale`** aporta el código comercial de la venta que originó la factura.
2. **`invoice`** representa el documento de facturación emitido.
3. **`invoice_status`** expone el estado actual de la factura.
4. **`invoice_line`** detalla cada línea facturable registrada.
5. **`tax`** identifica el impuesto aplicado a cada línea.
6. **`currency`** normaliza la moneda de la operación.

La solución usa `INNER JOIN` porque el objetivo es listar únicamente facturas que tienen líneas facturables e impuestos completamente registrados.

---

## 9. Trigger resuelto

### 9.1 Decisión técnica
Se tomó un trigger `AFTER INSERT ON invoice_line` porque el total de la factura debe recalcularse después de que cada nueva línea quede persistida en la base de datos. El modelo lo soporta, ya que `invoice.total_amount` es el campo que concentra el valor acumulado de la factura.

### 9.2 Lógica implementada
- Suma el producto de `unit_price * quantity` de todas las líneas asociadas a la factura.
- Actualiza el campo `total_amount` en la tabla `invoice`.
- Garantiza que la cabecera siempre refleje el total real del detalle facturable.

### 9.3 Script del trigger

```sql
DROP TRIGGER IF EXISTS trg_ai_invoice_line_update_invoice_total ON invoice_line;
DROP FUNCTION IF EXISTS fn_ai_invoice_line_update_invoice_total();

CREATE OR REPLACE FUNCTION fn_ai_invoice_line_update_invoice_total()
RETURNS trigger
LANGUAGE plpgsql
AS $$
DECLARE
    v_total_amount numeric;
BEGIN
    SELECT COALESCE(SUM(il.unit_price * il.quantity), 0)
    INTO v_total_amount
    FROM invoice_line il
    WHERE il.invoice_id = NEW.invoice_id;

    UPDATE invoice
    SET total_amount = v_total_amount
    WHERE invoice_id = NEW.invoice_id;

    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_ai_invoice_line_update_invoice_total
AFTER INSERT ON invoice_line
FOR EACH ROW
EXECUTE FUNCTION fn_ai_invoice_line_update_invoice_total();
```

### 9.4 Por qué esta solución es correcta
- No cambia ninguna tabla del modelo.
- Usa relaciones reales existentes entre `invoice_line` e `invoice`.
- Recalcula el total sumando todas las líneas, no solo la nueva, garantizando consistencia acumulada.
- Automatiza el paso que naturalmente ocurre después de insertar una línea facturable.

---

## 10. Procedimiento almacenado resuelto

### 10.1 Objetivo
Centralizar el registro de una línea facturable para asegurar que no se dupliquen líneas dentro de la misma factura y que el trigger pueda actuar de forma consistente sobre el total.

### 10.2 Decisión técnica
El procedimiento valida dos condiciones antes de insertar: que la factura exista y que el número de línea no esté duplicado dentro de la misma factura. Esto respeta la integridad del modelo sin modificar ninguna restricción existente.

### 10.3 Script del procedimiento

```sql
CREATE OR REPLACE PROCEDURE sp_register_invoice_line(
    p_invoice_id     uuid,
    p_tax_id         uuid,
    p_line_number    integer,
    p_description    varchar,
    p_quantity       numeric,
    p_unit_price     numeric
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM invoice i
        WHERE i.invoice_id = p_invoice_id
    ) THEN
        RAISE EXCEPTION 'No existe una factura con invoice_id %', p_invoice_id;
    END IF;

    IF EXISTS (
        SELECT 1
        FROM invoice_line il
        WHERE il.invoice_id = p_invoice_id
          AND il.line_number = p_line_number
    ) THEN
        RAISE EXCEPTION 'Ya existe una línea % para la factura %', p_line_number, p_invoice_id;
    END IF;

    INSERT INTO invoice_line (
        invoice_id,
        tax_id,
        line_number,
        description,
        quantity,
        unit_price
    )
    VALUES (
        p_invoice_id,
        p_tax_id,
        p_line_number,
        p_description,
        p_quantity,
        p_unit_price
    );
END;
$$;
```

### 10.4 Por qué esta solución es correcta
- Encapsula la inserción de la línea facturable.
- Evita líneas duplicadas dentro de la misma factura.
- Deja que el trigger recalcule automáticamente el `total_amount` en `invoice`.
- Se alinea con el flujo real del negocio: primero se registra la línea, luego la factura refleja el total actualizado.

---

## 11. Script de demostración del funcionamiento

```sql
DO $$
DECLARE
    v_invoice_id     uuid;
    v_tax_id         uuid;
    v_line_number    integer;
    v_description    varchar := 'Servicio de transporte aéreo - segmento adicional';
    v_quantity       numeric := 1;
    v_unit_price     numeric;
BEGIN
    SELECT i.invoice_id
    INTO v_invoice_id
    FROM invoice i
    ORDER BY i.created_at
    LIMIT 1;

    SELECT t.tax_id
    INTO v_tax_id
    FROM tax t
    ORDER BY t.created_at
    LIMIT 1;

    SELECT COALESCE(MAX(il.line_number), 0) + 1
    INTO v_line_number
    FROM invoice_line il
    WHERE il.invoice_id = v_invoice_id;

    SELECT COALESCE(i.total_amount, 100)
    INTO v_unit_price
    FROM invoice i
    WHERE i.invoice_id = v_invoice_id;

    IF v_invoice_id IS NULL THEN
        RAISE EXCEPTION 'No existe ninguna factura disponible en el sistema.';
    END IF;

    IF v_tax_id IS NULL THEN
        RAISE EXCEPTION 'No existe ningún impuesto disponible en el sistema.';
    END IF;

    CALL sp_register_invoice_line(
        v_invoice_id,
        v_tax_id,
        v_line_number,
        v_description,
        v_quantity,
        v_unit_price
    );
END;
$$;

SELECT
    i.invoice_id,
    i.invoice_number,
    i.total_amount        AS total_actualizado,
    il.line_number,
    il.description,
    il.quantity,
    il.unit_price,
    t.tax_name
FROM invoice i
INNER JOIN invoice_line il
    ON il.invoice_id = i.invoice_id
INNER JOIN tax t
    ON t.tax_id = il.tax_id
ORDER BY il.created_at DESC
LIMIT 5;
```

### 11.1 Qué demuestra este script
1. Busca la primera factura disponible en el sistema.
2. Obtiene el primer impuesto disponible.
3. Calcula dinámicamente el siguiente número de línea disponible para esa factura.
4. Usa el total actual de la factura como precio unitario de referencia.
5. Valida que tanto la factura como el impuesto existan antes de proceder.
6. Ejecuta el procedimiento almacenado `sp_register_invoice_line`.
7. El procedimiento inserta en `invoice_line`.
8. El trigger `trg_ai_invoice_line_update_invoice_total` recalcula y actualiza automáticamente `invoice.total_amount`.
9. La consulta final valida que la línea fue registrada y el total de la factura refleja el valor actualizado.

---

## 12. Validación final
La solución es válida porque:
- la consulta usa `INNER JOIN` en más de 5 tablas reales del modelo,
- el trigger es `AFTER INSERT` y produce un efecto verificable sobre `invoice.total_amount`,
- el procedimiento almacenado es reutilizable y encapsula el registro del detalle facturable,
- la demostración prueba la ejecución completa del flujo de facturación,
- no se alteró ningún atributo, tabla ni relación del modelo base.

---

## 13. Archivos SQL relacionados
- `scripts_sql/ejercicio_03_setup.sql`
- `scripts_sql/ejercicio_03_demo.sql`