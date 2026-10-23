# Ejercicio 02 Resuelto - Control de pagos y trazabilidad de transacciones financieras

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
El área financiera necesita auditar el estado de los pagos de una venta, identificar sus transacciones asociadas y controlar la generación de devoluciones cuando se registre una reversión dentro del flujo de pagos.

---

## 6. Dominios involucrados
### SALES, RESERVATION, TICKETING
**Entidades:** `sale`, `reservation`  
**Propósito en este ejercicio:** relacionar la venta con el contexto comercial de la reserva.

### PAYMENT
**Entidades:** `payment`, `payment_status`, `payment_method`, `payment_transaction`, `refund`  
**Propósito en este ejercicio:** gestionar pagos, transacciones y devoluciones dentro del flujo financiero.

### BILLING
**Entidades:** `invoice`  
**Propósito en este ejercicio:** relacionar el pago con el documento facturable asociado, si existe.

### GEOGRAPHY AND REFERENCE DATA
**Entidades:** `currency`  
**Propósito en este ejercicio:** normalizar la moneda usada en la venta y el pago.

---

## 7. Problema a resolver
La organización requiere una vista consolidada del ciclo de pago de una venta y necesita automatizar la generación de una devolución cuando se registra una transacción de tipo reversión sobre un pago.

El modelo ya posee las tablas necesarias para almacenar transacciones y reembolsos. Sin embargo, si ambos registros se insertan manualmente, el flujo queda expuesto a omisiones y falta de trazabilidad financiera.

Por eso se plantea una solución en tres capas:
1. una consulta consolidada con `INNER JOIN`,
2. un trigger `AFTER INSERT` sobre `payment_transaction`,
3. un procedimiento almacenado que centralice el registro de la transacción.

---

## 8. Solución propuesta

### 8.1 Consulta resuelta con `INNER JOIN`
Se eligió una consulta que conecta siete tablas reales del modelo. La consulta muestra la trazabilidad financiera completa de cada venta: reserva, pago, estado, método, transacción y moneda.

```sql
SELECT
    s.sale_code,
    r.reservation_code,
    p.payment_reference,
    ps.status_name        AS estado_pago,
    pm.method_name        AS metodo_pago,
    pt.transaction_reference,
    pt.transaction_type,
    pt.amount             AS monto_procesado,
    c.currency_code       AS moneda
FROM sale s
INNER JOIN reservation r
    ON r.reservation_id = s.reservation_id
INNER JOIN payment p
    ON p.sale_id = s.sale_id
INNER JOIN payment_status ps
    ON ps.payment_status_id = p.payment_status_id
INNER JOIN payment_method pm
    ON pm.payment_method_id = p.payment_method_id
INNER JOIN payment_transaction pt
    ON pt.payment_id = p.payment_id
INNER JOIN currency c
    ON c.currency_id = p.currency_id
ORDER BY pt.processed_at DESC;
```

### 8.2 Explicación paso a paso de la consulta
1. **`sale`** aporta el código comercial de la venta.
2. **`reservation`** conecta la venta con la reserva original del pasajero.
3. **`payment`** representa el pago registrado para esa venta.
4. **`payment_status`** expone el estado actual del pago.
5. **`payment_method`** identifica el medio de pago utilizado.
6. **`payment_transaction`** detalla cada transacción financiera procesada.
7. **`currency`** normaliza la moneda de la operación.

La solución usa `INNER JOIN` porque el objetivo es listar únicamente ventas que cuentan con pagos y transacciones completamente registrados.

---

## 9. Trigger resuelto

### 9.1 Decisión técnica
Se tomó un trigger `AFTER INSERT ON payment_transaction` porque el `refund` depende de que exista primero una transacción registrada. El modelo lo confirma, ya que `refund.payment_transaction_id` referencia a `payment_transaction(payment_transaction_id)`.

El trigger actúa únicamente cuando el pago asociado se encuentra en estado `reversed`, `refunded` o `cancelled`, evitando generar devoluciones para transacciones ordinarias.

### 9.2 Lógica implementada
- Verifica el `status_code` del pago asociado a la transacción insertada.
- Si el estado no corresponde a una reversión, no hace nada.
- Si corresponde y no existe aún un `refund` para esa transacción, genera:
  - `refund_amount` tomado del monto de la transacción
  - `refund_reason` como mensaje estándar de auditoría
  - `refunded_at` tomado de la fecha de procesamiento

### 9.3 Script del trigger

```sql
DROP TRIGGER IF EXISTS trg_ai_payment_transaction_create_refund ON payment_transaction;
DROP FUNCTION IF EXISTS fn_ai_payment_transaction_create_refund();

CREATE OR REPLACE FUNCTION fn_ai_payment_transaction_create_refund()
RETURNS trigger
LANGUAGE plpgsql
AS $$
DECLARE
    v_payment_status_code varchar(50);
BEGIN
    SELECT ps.status_code
    INTO v_payment_status_code
    FROM payment p
    INNER JOIN payment_status ps
        ON ps.payment_status_id = p.payment_status_id
    WHERE p.payment_id = NEW.payment_id;

    IF lower(v_payment_status_code) NOT IN ('reversed', 'refunded', 'cancelled') THEN
        RETURN NEW;
    END IF;

    IF EXISTS (
        SELECT 1
        FROM refund r
        WHERE r.payment_transaction_id = NEW.payment_transaction_id
    ) THEN
        RETURN NEW;
    END IF;

    INSERT INTO refund (
        payment_transaction_id,
        refund_amount,
        refund_reason,
        refunded_at
    )
    VALUES (
        NEW.payment_transaction_id,
        NEW.amount,
        'Devolución automática generada por reversión de pago',
        NEW.processed_at
    );

    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_ai_payment_transaction_create_refund
AFTER INSERT ON payment_transaction
FOR EACH ROW
EXECUTE FUNCTION fn_ai_payment_transaction_create_refund();
```

### 9.4 Por qué esta solución es correcta
- No cambia ninguna tabla del modelo.
- Usa relaciones reales existentes entre `payment`, `payment_status` y `refund`.
- Aplica lógica condicional coherente con el negocio financiero.
- Automatiza el paso que naturalmente ocurre después de registrar una reversión.

---

## 10. Procedimiento almacenado resuelto

### 10.1 Objetivo
Centralizar el registro de una transacción de pago para que la operación quede trazable y el trigger pueda actuar de forma consistente sobre las devoluciones.

### 10.2 Decisión técnica
El procedimiento valida primero que el `payment_id` recibido exista en el sistema. Esto evita transacciones huérfanas que rompan la integridad referencial del modelo.

### 10.3 Script del procedimiento

```sql
CREATE OR REPLACE PROCEDURE sp_register_payment_transaction(
    p_payment_id          uuid,
    p_transaction_type    varchar,
    p_amount              numeric,
    p_processed_at        timestamptz,
    p_provider_message    varchar
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM payment p
        WHERE p.payment_id = p_payment_id
    ) THEN
        RAISE EXCEPTION 'No existe un pago con payment_id %', p_payment_id;
    END IF;

    INSERT INTO payment_transaction (
        payment_id,
        transaction_type,
        amount,
        processed_at,
        provider_message
    )
    VALUES (
        p_payment_id,
        p_transaction_type,
        p_amount,
        p_processed_at,
        p_provider_message
    );
END;
$$;
```

### 10.4 Por qué esta solución es correcta
- Encapsula la inserción de la transacción.
- Valida la existencia del pago antes de proceder.
- Deja que el trigger resuelva automáticamente el `refund` cuando aplique.
- Se alinea con el flujo real del negocio: primero transacción, luego devolución si corresponde.

---

## 11. Script de demostración del funcionamiento

```sql
DO $$
DECLARE
    v_payment_id          uuid;
    v_transaction_type    varchar := 'reversal';
    v_amount              numeric;
    v_processed_at        timestamptz := now();
    v_provider_message    varchar := 'Reversión procesada por proveedor externo';
BEGIN
    SELECT p.payment_id, p.amount
    INTO v_payment_id, v_amount
    FROM payment p
    INNER JOIN payment_status ps
        ON ps.payment_status_id = p.payment_status_id
    WHERE lower(ps.status_code) IN ('reversed', 'refunded', 'cancelled')
    ORDER BY p.created_at
    LIMIT 1;

    IF v_payment_id IS NULL THEN
        SELECT p.payment_id, p.amount
        INTO v_payment_id, v_amount
        FROM payment p
        ORDER BY p.created_at
        LIMIT 1;
    END IF;

    IF v_payment_id IS NULL THEN
        RAISE EXCEPTION 'No existe ningún pago disponible en el sistema.';
    END IF;

    CALL sp_register_payment_transaction(
        v_payment_id,
        v_transaction_type,
        v_amount,
        v_processed_at,
        v_provider_message
    );
END;
$$;

SELECT
    pt.payment_transaction_id,
    pt.payment_id,
    pt.transaction_type,
    pt.amount,
    pt.processed_at,
    r.refund_id,
    r.refund_amount,
    r.refund_reason,
    r.refunded_at
FROM payment_transaction pt
LEFT JOIN refund r
    ON r.payment_transaction_id = pt.payment_transaction_id
ORDER BY pt.processed_at DESC
LIMIT 5;
```

### 11.1 Qué demuestra este script
1. Busca un pago en estado de reversión o cancelación; si no hay, toma cualquier pago disponible.
2. Define los parámetros de la transacción de tipo `reversal`.
3. Valida que exista un pago antes de proceder.
4. Ejecuta el procedimiento almacenado `sp_register_payment_transaction`.
5. El procedimiento inserta en `payment_transaction`.
6. El trigger `trg_ai_payment_transaction_create_refund` evalúa el estado del pago y, si corresponde, genera automáticamente el `refund`.
7. La consulta final valida que la transacción y la devolución quedaron registradas correctamente.

---

## 12. Validación final
La solución es válida porque:
- la consulta usa `INNER JOIN` en más de 5 tablas reales del modelo,
- el trigger es `AFTER INSERT` y produce un efecto verificable sobre `refund`,
- el procedimiento almacenado es reutilizable y encapsula el registro de la transacción,
- la demostración prueba la ejecución completa del flujo financiero,
- no se alteró ningún atributo, tabla ni relación del modelo base.

---

## 13. Archivos SQL relacionados
- `scripts_sql/ejercicio_02_setup.sql`
- `scripts_sql/ejercicio_02_demo.sql`