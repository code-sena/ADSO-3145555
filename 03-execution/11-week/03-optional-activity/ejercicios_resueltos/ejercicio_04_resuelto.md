# Ejercicio 04 Resuelto - Acumulación de millas y actualización del historial de nivel

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
El programa de fidelización de la aerolínea requiere consultar el comportamiento comercial del cliente y automatizar la actualización del nivel de fidelización cuando se registra una nueva transacción de millas, manteniendo el historial de cambios de tier en `loyalty_account_tier`.

---

## 6. Dominios involucrados
### CUSTOMER AND LOYALTY
**Entidades:** `customer`, `loyalty_account`, `loyalty_program`, `loyalty_tier`, `loyalty_account_tier`, `miles_transaction`, `customer_category`  
**Propósito en este ejercicio:** gestionar clientes, cuentas de fidelización, niveles y acumulación de millas.

### AIRLINE
**Entidades:** `airline`  
**Propósito en este ejercicio:** identificar la aerolínea propietaria del programa de fidelización.

### IDENTITY
**Entidades:** `person`  
**Propósito en este ejercicio:** relacionar el cliente con la persona real del sistema.

### SALES, RESERVATION, TICKETING
**Entidades:** `reservation`, `sale`  
**Propósito en este ejercicio:** relacionar la actividad comercial con el cliente fidelizado.

---

## 7. Problema a resolver
La aerolínea necesita analizar la relación entre clientes, ventas y cuentas de fidelización, y además automatizar la actualización del nivel del cliente cada vez que se registre una transacción de millas.

El modelo ya posee las tablas necesarias para almacenar transacciones de millas y el historial de niveles. Sin embargo, si la actualización del tier se gestiona manualmente, el historial queda expuesto a inconsistencias y pérdida de trazabilidad.

Por eso se plantea una solución en tres capas:
1. una consulta consolidada con `INNER JOIN`,
2. un trigger `AFTER INSERT` sobre `miles_transaction`,
3. un procedimiento almacenado que centralice el registro de la transacción de millas.

---

## 8. Solución propuesta

### 8.1 Consulta resuelta con `INNER JOIN`
Se eligió una consulta que conecta ocho tablas reales del modelo. La consulta muestra la trazabilidad completa del cliente fidelizado: persona, cuenta, programa, nivel activo y venta relacionada.

```sql
SELECT
    c.customer_code,
    p.first_name,
    p.last_name,
    la.account_number         AS cuenta_fidelizacion,
    lp.program_name           AS programa,
    lt.tier_name              AS nivel,
    lat.start_date            AS fecha_asignacion_nivel,
    s.sale_code               AS venta_relacionada
FROM customer c
INNER JOIN person p
    ON p.person_id = c.person_id
INNER JOIN loyalty_account la
    ON la.customer_id = c.customer_id
INNER JOIN loyalty_program lp
    ON lp.loyalty_program_id = la.loyalty_program_id
INNER JOIN loyalty_account_tier lat
    ON lat.loyalty_account_id = la.loyalty_account_id
INNER JOIN loyalty_tier lt
    ON lt.loyalty_tier_id = lat.loyalty_tier_id
INNER JOIN reservation r
    ON r.customer_id = c.customer_id
INNER JOIN sale s
    ON s.reservation_id = r.reservation_id
ORDER BY lat.start_date DESC, c.customer_code;
```

### 8.2 Explicación paso a paso de la consulta
1. **`customer`** aporta el código del cliente dentro del programa.
2. **`person`** aporta la identidad real del cliente.
3. **`loyalty_account`** representa la cuenta de fidelización del cliente.
4. **`loyalty_program`** identifica el programa al que pertenece la cuenta.
5. **`loyalty_account_tier`** registra el nivel activo o histórico de la cuenta.
6. **`loyalty_tier`** describe el nombre y condiciones del nivel.
7. **`reservation`** conecta el cliente con su actividad comercial.
8. **`sale`** aporta el código de la venta relacionada con la reserva.

La solución usa `INNER JOIN` porque el objetivo es listar únicamente clientes con cuenta de fidelización, nivel asignado y actividad comercial registrada.

---

## 9. Trigger resuelto

### 9.1 Decisión técnica
Se tomó un trigger `AFTER INSERT ON miles_transaction` porque la actualización del nivel de fidelización depende de que la transacción de millas ya esté persistida. El modelo lo confirma, ya que `loyalty_account_tier.loyalty_account_id` referencia a `loyalty_account(loyalty_account_id)` y `loyalty_tier.min_miles` define el umbral de cada nivel.

### 9.2 Lógica implementada
- Calcula el total acumulado de millas de la cuenta incluyendo la transacción recién insertada.
- Busca el tier cuyo `min_miles` más alto no supere el total acumulado.
- Compara el tier calculado con el tier activo actual en `loyalty_account_tier`.
- Si son distintos, cierra el tier anterior seteando `end_date = now()` e inserta el nuevo tier con `end_date = NULL`.
- Si no hay cambio de tier, no hace ninguna acción adicional.

### 9.3 Script del trigger

```sql
DROP TRIGGER IF EXISTS trg_ai_miles_transaction_update_account_tier ON miles_transaction;
DROP FUNCTION IF EXISTS fn_ai_miles_transaction_update_account_tier();

CREATE OR REPLACE FUNCTION fn_ai_miles_transaction_update_account_tier()
RETURNS trigger
LANGUAGE plpgsql
AS $$
DECLARE
    v_total_miles       numeric;
    v_new_tier_id       uuid;
    v_current_tier_id   uuid;
BEGIN
    SELECT COALESCE(SUM(mt.miles_amount), 0)
    INTO v_total_miles
    FROM miles_transaction mt
    WHERE mt.loyalty_account_id = NEW.loyalty_account_id;

    SELECT lt.loyalty_tier_id
    INTO v_new_tier_id
    FROM loyalty_tier lt
    WHERE lt.min_miles <= v_total_miles
    ORDER BY lt.min_miles DESC
    LIMIT 1;

    IF v_new_tier_id IS NULL THEN
        RETURN NEW;
    END IF;

    SELECT lat.loyalty_tier_id
    INTO v_current_tier_id
    FROM loyalty_account_tier lat
    WHERE lat.loyalty_account_id = NEW.loyalty_account_id
      AND lat.end_date IS NULL
    ORDER BY lat.start_date DESC
    LIMIT 1;

    IF v_current_tier_id IS DISTINCT FROM v_new_tier_id THEN
        UPDATE loyalty_account_tier
        SET end_date = now()
        WHERE loyalty_account_id = NEW.loyalty_account_id
          AND end_date IS NULL;

        INSERT INTO loyalty_account_tier (
            loyalty_account_id,
            loyalty_tier_id,
            start_date,
            end_date
        )
        VALUES (
            NEW.loyalty_account_id,
            v_new_tier_id,
            now(),
            NULL
        );
    END IF;

    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_ai_miles_transaction_update_account_tier
AFTER INSERT ON miles_transaction
FOR EACH ROW
EXECUTE FUNCTION fn_ai_miles_transaction_update_account_tier();
```

### 9.4 Por qué esta solución es correcta
- No cambia ninguna tabla del modelo.
- Usa relaciones reales entre `miles_transaction`, `loyalty_account_tier` y `loyalty_tier`.
- Mantiene el historial de niveles cerrando el tier anterior antes de abrir el nuevo.
- Solo actúa cuando hay un cambio real de nivel, evitando duplicados innecesarios.

---

## 10. Procedimiento almacenado resuelto

### 10.1 Objetivo
Centralizar el registro de una transacción de millas para garantizar que la cuenta exista y que el monto sea válido antes de persistir el movimiento, dejando al trigger la responsabilidad de actualizar el nivel.

### 10.2 Decisión técnica
El procedimiento valida dos condiciones antes de insertar: que la cuenta de fidelización exista y que el monto de millas sea mayor a cero. Esto protege la integridad del historial sin modificar ninguna restricción existente del modelo.

### 10.3 Script del procedimiento

```sql
CREATE OR REPLACE PROCEDURE sp_register_miles_transaction(
    p_loyalty_account_id   uuid,
    p_transaction_type     varchar,
    p_miles_amount         numeric,
    p_transaction_date     timestamptz,
    p_notes                varchar
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM loyalty_account la
        WHERE la.loyalty_account_id = p_loyalty_account_id
    ) THEN
        RAISE EXCEPTION 'No existe una cuenta de fidelización con loyalty_account_id %', p_loyalty_account_id;
    END IF;

    IF p_miles_amount <= 0 THEN
        RAISE EXCEPTION 'El monto de millas debe ser mayor a cero. Valor recibido: %', p_miles_amount;
    END IF;

    INSERT INTO miles_transaction (
        loyalty_account_id,
        transaction_type,
        miles_amount,
        transaction_date,
        notes
    )
    VALUES (
        p_loyalty_account_id,
        p_transaction_type,
        p_miles_amount,
        p_transaction_date,
        p_notes
    );
END;
$$;
```

### 10.4 Por qué esta solución es correcta
- Encapsula la inserción de la transacción de millas.
- Valida la existencia de la cuenta y la validez del monto.
- Deja que el trigger actualice automáticamente el nivel en `loyalty_account_tier`.
- Se alinea con el flujo real del negocio: primero se acumulan millas, luego el sistema evalúa y actualiza el nivel.

---

## 11. Script de demostración del funcionamiento

```sql
DO $$
DECLARE
    v_loyalty_account_id   uuid;
    v_transaction_type     varchar := 'accrual';
    v_miles_amount         numeric := 5000;
    v_transaction_date     timestamptz := now();
    v_notes                varchar := 'Acumulación por vuelo operado - registro automático';
BEGIN
    SELECT la.loyalty_account_id
    INTO v_loyalty_account_id
    FROM loyalty_account la
    ORDER BY la.created_at
    LIMIT 1;

    IF v_loyalty_account_id IS NULL THEN
        RAISE EXCEPTION 'No existe ninguna cuenta de fidelización disponible en el sistema.';
    END IF;

    CALL sp_register_miles_transaction(
        v_loyalty_account_id,
        v_transaction_type,
        v_miles_amount,
        v_transaction_date,
        v_notes
    );
END;
$$;

SELECT
    mt.miles_transaction_id,
    mt.loyalty_account_id,
    mt.transaction_type,
    mt.miles_amount,
    mt.transaction_date,
    mt.notes,
    lat.loyalty_tier_id,
    lt.tier_name              AS nivel_asignado,
    lat.start_date            AS inicio_nivel,
    lat.end_date              AS fin_nivel
FROM miles_transaction mt
INNER JOIN loyalty_account_tier lat
    ON lat.loyalty_account_id = mt.loyalty_account_id
    AND lat.end_date IS NULL
INNER JOIN loyalty_tier lt
    ON lt.loyalty_tier_id = lat.loyalty_tier_id
WHERE mt.loyalty_account_id = (
    SELECT loyalty_account_id
    FROM miles_transaction
    ORDER BY created_at DESC
    LIMIT 1
)
ORDER BY mt.transaction_date DESC
LIMIT 5;
```

### 11.1 Qué demuestra este script
1. Busca la primera cuenta de fidelización disponible en el sistema.
2. Define una transacción de tipo `accrual` con 5.000 millas.
3. Valida que la cuenta exista antes de proceder.
4. Ejecuta el procedimiento almacenado `sp_register_miles_transaction`.
5. El procedimiento inserta en `miles_transaction`.
6. El trigger `trg_ai_miles_transaction_update_account_tier` calcula el total acumulado de millas y evalúa si corresponde un cambio de nivel.
7. Si el tier calculado difiere del activo, cierra el anterior y abre un nuevo registro en `loyalty_account_tier`.
8. La consulta final valida que la transacción fue registrada y muestra el nivel activo actualizado para esa cuenta.

---

## 12. Validación final
La solución es válida porque:
- la consulta usa `INNER JOIN` en más de 5 tablas reales del modelo,
- el trigger es `AFTER INSERT` y produce un efecto verificable sobre `loyalty_account_tier`,
- el procedimiento almacenado es reutilizable y encapsula el registro de la transacción de millas,
- la demostración prueba la ejecución completa del flujo de fidelización,
- no se alteró ningún atributo, tabla ni relación del modelo base.

---

## 13. Archivos SQL relacionados
- `scripts_sql/ejercicio_04_setup.sql`
- `scripts_sql/ejercicio_04_demo.sql`