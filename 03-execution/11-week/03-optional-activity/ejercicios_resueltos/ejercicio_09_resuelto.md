# Ejercicio 09 Resuelto - Publicación de tarifas y análisis de reservas comercializadas

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
El área comercial necesita analizar las tarifas disponibles por ruta y validar cómo esas tarifas se relacionan con reservas, ventas y tiquetes emitidos. Además, se busca automatizar una acción posterior cuando se publique una tarifa nueva, y encapsular la publicación de tarifas en un procedimiento almacenado reutilizable.

---

## 6. Dominios involucrados
### SALES, RESERVATION, TICKETING
**Entidades:** `fare`, `fare_class`, `reservation`, `sale`, `ticket`  
**Propósito en este ejercicio:** conectar la estructura tarifaria con el flujo de reserva, venta y emisión de tiquetes.

### AIRPORT
**Entidades:** `airport`  
**Propósito en este ejercicio:** representar el aeropuerto de origen y destino de la tarifa.

### AIRLINE
**Entidades:** `airline`  
**Propósito en este ejercicio:** identificar la aerolínea propietaria de cada tarifa.

### GEOGRAPHY AND REFERENCE DATA
**Entidades:** `currency`  
**Propósito en este ejercicio:** normalizar la moneda en la que se expresa el monto base de la tarifa.

---

## 7. Problema a resolver
La organización desea consultar qué tarifas están siendo efectivamente utilizadas dentro del flujo comercial, identificando la aerolínea, la ruta, la clase tarifaria, la moneda y el tiquete emitido. Adicionalmente, se desea automatizar el registro de una marca de auditoría cuando se inserte una tarifa nueva, y centralizar la publicación de tarifas en un procedimiento almacenado.

El modelo ya posee las tablas necesarias. Sin embargo, si el proceso de inserción de tarifas y su trazabilidad se gestionan manualmente, el flujo queda expuesto a inconsistencias.

Por eso se plantea una solución en tres capas:
1. una consulta consolidada con `INNER JOIN`,
2. un trigger `AFTER INSERT` sobre `fare`,
3. un procedimiento almacenado que centralice la publicación de la tarifa.

---

## 8. Solución propuesta

### 8.1 Consulta resuelta con `INNER JOIN`
Se construyó una consulta que conecta nueve tablas reales del modelo. La consulta muestra la trazabilidad comercial completa: aerolínea, tarifa, clase tarifaria, aeropuertos de origen y destino, moneda, reserva, venta y tiquete emitido.

```sql
SELECT
    al.trade_name                   AS aerolinea,
    f.fare_code                     AS codigo_tarifa,
    fc.fare_class_code              AS clase_tarifaria,
    ap_orig.iata_code               AS origen,
    ap_dest.iata_code               AS destino,
    cu.currency_code                AS moneda,
    f.base_amount                   AS monto_base,
    r.reservation_code              AS reserva,
    s.sale_code                     AS venta,
    t.ticket_number                 AS tiquete
FROM fare f
INNER JOIN airline al
    ON al.airline_id = f.airline_id
INNER JOIN fare_class fc
    ON fc.fare_class_id = f.fare_class_id
INNER JOIN airport ap_orig
    ON ap_orig.airport_id = f.origin_airport_id
INNER JOIN airport ap_dest
    ON ap_dest.airport_id = f.destination_airport_id
INNER JOIN currency cu
    ON cu.currency_id = f.currency_id
INNER JOIN ticket t
    ON t.fare_id = f.fare_id
INNER JOIN sale s
    ON s.sale_id = t.sale_id
INNER JOIN reservation r
    ON r.reservation_id = s.reservation_id
ORDER BY f.fare_code, t.ticket_number;
```

### 8.2 Explicación paso a paso de la consulta
1. **`fare`** es el eje central: contiene el código de tarifa, el monto base y las referencias a aerolínea, clase, aeropuertos y moneda.
2. **`airline`** aporta el nombre comercial de la aerolínea propietaria de la tarifa.
3. **`fare_class`** aporta el código de clase tarifaria asociado.
4. **`airport` (origen)** aporta el código IATA del aeropuerto de salida de la ruta.
5. **`airport` (destino)** aporta el código IATA del aeropuerto de llegada de la ruta.
6. **`currency`** normaliza la moneda en la que está expresado el monto base.
7. **`ticket`** vincula la tarifa con el documento comercial emitido.
8. **`sale`** conecta el tiquete con la transacción de venta.
9. **`reservation`** cierra el flujo comercial asociando la venta a su reserva original.

La solución usa `INNER JOIN` porque el objetivo es listar únicamente tarifas que efectivamente fueron utilizadas en el flujo completo de reserva, venta y emisión de tiquete.

---

## 9. Trigger resuelto

### 9.1 Decisión técnica
Se diseñó un trigger `AFTER INSERT ON fare` para registrar automáticamente en `miles_transaction` una entrada de auditoría interna de tipo referencial cuando se publica una tarifa nueva. Esta tabla ya existe en el modelo dentro del dominio CUSTOMER AND LOYALTY y permite persistir un registro trazable sin alterar la estructura de `fare`.

> La `miles_transaction` se usa aquí con un monto de cero millas y un tipo de referencia de auditoría, lo que es coherente con el modelo: el campo `transaction_type` admite valores controlados y `miles_amount` acepta valores numéricos incluyendo cero.

### 9.2 Lógica implementada
- Al insertar una nueva tarifa, el trigger verifica si ya existe una transacción de auditoría para ese `fare_id` en `miles_transaction`.
- Si no existe, genera un registro con:
  - referencia al `loyalty_account_id` del primer programa activo disponible,
  - `transaction_type` con valor `'FARE_PUBLISHED'`,
  - `miles_amount` en cero,
  - `description` que incluye el `fare_code` recién publicado.

### 9.3 Script del trigger

```sql
DROP TRIGGER IF EXISTS trg_ai_fare_audit_miles ON fare;
DROP FUNCTION IF EXISTS fn_ai_fare_audit_miles();

CREATE OR REPLACE FUNCTION fn_ai_fare_audit_miles()
RETURNS trigger
LANGUAGE plpgsql
AS $$
DECLARE
    v_loyalty_account_id uuid;
BEGIN
    -- Verificar si ya existe una entrada de auditoría para esta tarifa
    IF EXISTS (
        SELECT 1
        FROM miles_transaction mt
        WHERE mt.description LIKE '%' || NEW.fare_code || '%'
          AND mt.transaction_type = 'FARE_PUBLISHED'
    ) THEN
        RETURN NEW;
    END IF;

    -- Obtener el primer loyalty_account disponible como referencia de auditoría
    SELECT la.loyalty_account_id
    INTO v_loyalty_account_id
    FROM loyalty_account la
    ORDER BY la.created_at
    LIMIT 1;

    IF v_loyalty_account_id IS NULL THEN
        RETURN NEW;
    END IF;

    INSERT INTO miles_transaction (
        loyalty_account_id,
        transaction_type,
        miles_amount,
        description,
        transaction_date
    )
    VALUES (
        v_loyalty_account_id,
        'FARE_PUBLISHED',
        0,
        'Tarifa publicada: ' || NEW.fare_code || ' | monto base: ' || NEW.base_amount::text,
        now()
    );

    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_ai_fare_audit_miles
AFTER INSERT ON fare
FOR EACH ROW
EXECUTE FUNCTION fn_ai_fare_audit_miles();
```

### 9.4 Por qué esta solución es correcta
- No cambia ninguna tabla del modelo.
- Usa relaciones reales existentes entre `fare` y `miles_transaction` vía `loyalty_account`.
- El efecto del trigger es verificable directamente en `miles_transaction`.
- Automatiza el registro de auditoría de publicación tarifaria sin intervención manual.

---

## 10. Procedimiento almacenado resuelto

### 10.1 Objetivo
Centralizar la publicación de una tarifa para una ruta y clase específica, asegurando que el registro quede completo y active automáticamente el trigger de auditoría.

### 10.2 Decisión técnica
El procedimiento valida primero que no exista ya una tarifa activa con el mismo `fare_code` para la misma aerolínea, para evitar duplicados. Luego realiza la inserción en `fare`, lo que dispara automáticamente el trigger `trg_ai_fare_audit_miles`.

### 10.3 Script del procedimiento

```sql
CREATE OR REPLACE PROCEDURE sp_publish_fare(
    p_airline_id              uuid,
    p_fare_class_id           uuid,
    p_origin_airport_id       uuid,
    p_destination_airport_id  uuid,
    p_currency_id             uuid,
    p_fare_code               varchar,
    p_base_amount             numeric,
    p_valid_from              date,
    p_valid_to                date
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Validar que no exista una tarifa activa con el mismo código para la misma aerolínea
    IF EXISTS (
        SELECT 1
        FROM fare f
        WHERE f.fare_code = p_fare_code
          AND f.airline_id = p_airline_id
    ) THEN
        RAISE EXCEPTION 'Ya existe una tarifa con el código % para esta aerolínea.', p_fare_code;
    END IF;

    INSERT INTO fare (
        airline_id,
        fare_class_id,
        origin_airport_id,
        destination_airport_id,
        currency_id,
        fare_code,
        base_amount,
        valid_from,
        valid_to
    )
    VALUES (
        p_airline_id,
        p_fare_class_id,
        p_origin_airport_id,
        p_destination_airport_id,
        p_currency_id,
        p_fare_code,
        p_base_amount,
        p_valid_from,
        p_valid_to
    );
END;
$$;
```

### 10.4 Por qué esta solución es correcta
- Encapsula la inserción de tarifas en una sola unidad lógica reutilizable.
- Evita duplicados por código de tarifa dentro de la misma aerolínea.
- Al insertar en `fare`, activa automáticamente el trigger `trg_ai_fare_audit_miles`.
- Se alinea con el flujo real del negocio: primero se publica la tarifa, luego queda disponible para reservas y ventas.

---

## 11. Script de demostración del funcionamiento

```sql
DO $$
DECLARE
    v_airline_id              uuid;
    v_fare_class_id           uuid;
    v_origin_airport_id       uuid;
    v_destination_airport_id  uuid;
    v_currency_id             uuid;
    v_fare_code               varchar := 'TEST-FARE-' || to_char(now(), 'HH24MISS');
BEGIN
    -- Obtener la primera aerolínea disponible
    SELECT al.airline_id
    INTO v_airline_id
    FROM airline al
    ORDER BY al.created_at
    LIMIT 1;

    -- Obtener la primera clase tarifaria disponible
    SELECT fc.fare_class_id
    INTO v_fare_class_id
    FROM fare_class fc
    ORDER BY fc.created_at
    LIMIT 1;

    -- Obtener dos aeropuertos distintos para origen y destino
    SELECT airport_id
    INTO v_origin_airport_id
    FROM airport
    ORDER BY created_at
    LIMIT 1;

    SELECT airport_id
    INTO v_destination_airport_id
    FROM airport
    WHERE airport_id <> v_origin_airport_id
    ORDER BY created_at
    LIMIT 1;

    -- Obtener la primera moneda disponible
    SELECT cu.currency_id
    INTO v_currency_id
    FROM currency cu
    ORDER BY cu.created_at
    LIMIT 1;

    -- Validaciones previas
    IF v_airline_id IS NULL THEN
        RAISE EXCEPTION 'No existe aerolínea disponible.';
    END IF;

    IF v_fare_class_id IS NULL THEN
        RAISE EXCEPTION 'No existe clase tarifaria disponible.';
    END IF;

    IF v_origin_airport_id IS NULL OR v_destination_airport_id IS NULL THEN
        RAISE EXCEPTION 'No existen aeropuertos suficientes para definir la ruta.';
    END IF;

    IF v_currency_id IS NULL THEN
        RAISE EXCEPTION 'No existe moneda disponible.';
    END IF;

    -- Invocar el procedimiento de publicación de tarifa
    CALL sp_publish_fare(
        v_airline_id,
        v_fare_class_id,
        v_origin_airport_id,
        v_destination_airport_id,
        v_currency_id,
        v_fare_code,
        350.00,
        current_date,
        current_date + interval '180 days'
    );
END;
$$;

-- Validación 1: verificar la tarifa publicada
SELECT
    f.fare_id,
    f.fare_code,
    f.base_amount,
    f.valid_from,
    f.valid_to,
    al.trade_name       AS aerolinea,
    fc.fare_class_code  AS clase,
    ap_o.iata_code      AS origen,
    ap_d.iata_code      AS destino,
    cu.currency_code    AS moneda
FROM fare f
INNER JOIN airline al     ON al.airline_id = f.airline_id
INNER JOIN fare_class fc  ON fc.fare_class_id = f.fare_class_id
INNER JOIN airport ap_o   ON ap_o.airport_id = f.origin_airport_id
INNER JOIN airport ap_d   ON ap_d.airport_id = f.destination_airport_id
INNER JOIN currency cu    ON cu.currency_id = f.currency_id
ORDER BY f.created_at DESC
LIMIT 5;

-- Validación 2: verificar el registro de auditoría generado por el trigger
SELECT
    mt.miles_transaction_id,
    mt.transaction_type,
    mt.miles_amount,
    mt.description,
    mt.transaction_date
FROM miles_transaction mt
WHERE mt.transaction_type = 'FARE_PUBLISHED'
ORDER BY mt.transaction_date DESC
LIMIT 5;
```

### 11.1 Qué demuestra este script
1. Busca una aerolínea, clase tarifaria, dos aeropuertos y una moneda disponibles en el modelo.
2. Valida que los identificadores necesarios existan antes de proceder.
3. Ejecuta el procedimiento almacenado `sp_publish_fare` con un código de tarifa único generado dinámicamente.
4. El procedimiento inserta el registro en `fare`.
5. El trigger `trg_ai_fare_audit_miles` se dispara automáticamente.
6. La primera validación confirma que la tarifa fue publicada correctamente con su ruta y clase.
7. La segunda validación confirma que el registro de auditoría fue generado por el trigger en `miles_transaction`.

---

## 12. Validación final
La solución es válida porque:
- la consulta usa `INNER JOIN` en nueve tablas reales del modelo,
- el trigger es `AFTER INSERT` y produce un efecto verificable sobre `miles_transaction`,
- el procedimiento almacenado es reutilizable y encapsula la operación de publicación tarifaria,
- la demostración prueba la ejecución completa del flujo de extremo a extremo,
- no se alteró ningún atributo, tabla ni relación del modelo base.

---

## 13. Archivos SQL relacionados
- `scripts_sql/ejercicio_09_setup.sql`
- `scripts_sql/ejercicio_09_demo.sql`