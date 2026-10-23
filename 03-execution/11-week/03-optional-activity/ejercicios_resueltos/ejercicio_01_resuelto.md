# Ejercicio 01 Resuelto - Flujo de check-in y trazabilidad comercial del pasajero

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
La aerolínea requiere fortalecer la trazabilidad operativa del proceso de abordaje, desde la reserva del pasajero hasta la emisión del pase de abordar. Para ello, se necesita consultar información consolidada del flujo comercial y, además, automatizar parte del proceso de check-in mediante lógica en base de datos.

---

## 6. Dominios involucrados
### SALES, RESERVATION, TICKETING
**Entidades:** `reservation`, `reservation_passenger`, `ticket`, `ticket_segment`  
**Propósito en este ejercicio:** conectar la reserva y el pasajero con el segmento específico que será abordado.

### FLIGHT OPERATIONS
**Entidades:** `flight`, `flight_segment`  
**Propósito en este ejercicio:** asociar el tiquete a un vuelo real y a un segmento operativo concreto.

### IDENTITY
**Entidades:** `person`  
**Propósito en este ejercicio:** identificar al pasajero vinculado a la reserva.

### BOARDING
**Entidades:** `check_in`, `check_in_status`, `boarding_group`, `boarding_pass`  
**Propósito en este ejercicio:** registrar el check-in y emitir automáticamente el pase de abordar.

### SECURITY
**Entidades:** `user_account`  
**Propósito en este ejercicio:** identificar el usuario que ejecuta el check-in.

---

## 7. Problema a resolver
La aerolínea desea consultar qué pasajeros ya se encuentran asociados a reservas y tiquetes válidos para un vuelo determinado, y adicionalmente automatizar la creación del pase de abordar cuando se registra un check-in.

El modelo ya posee las tablas necesarias para almacenar tanto el check-in como el boarding pass. Sin embargo, si ambos registros se insertan manualmente, el flujo queda expuesto a errores operativos, duplicidad y omisiones.

Por eso se plantea una solución en tres capas:
1. una consulta consolidada con `INNER JOIN`,
2. un trigger `AFTER INSERT` sobre `check_in`,
3. un procedimiento almacenado que centralice el registro del check-in.

---

## 8. Solución propuesta

### 8.1 Consulta resuelta con `INNER JOIN`
Se eligió una consulta que conecta nueve tablas reales del modelo. La consulta muestra la trazabilidad completa del pasajero ya chequeado: reserva, persona, ticket, segmento, vuelo, check-in y boarding pass.

```sql
SELECT
    r.reservation_code,
    f.flight_number,
    f.service_date,
    fs.segment_number,
    p.first_name,
    p.last_name,
    t.ticket_number,
    ci.checked_in_at,
    bp.boarding_pass_code
FROM reservation r
INNER JOIN reservation_passenger rp
    ON rp.reservation_id = r.reservation_id
INNER JOIN person p
    ON p.person_id = rp.person_id
INNER JOIN ticket t
    ON t.reservation_passenger_id = rp.reservation_passenger_id
INNER JOIN ticket_segment ts
    ON ts.ticket_id = t.ticket_id
INNER JOIN flight_segment fs
    ON fs.flight_segment_id = ts.flight_segment_id
INNER JOIN flight f
    ON f.flight_id = fs.flight_id
INNER JOIN check_in ci
    ON ci.ticket_segment_id = ts.ticket_segment_id
INNER JOIN boarding_pass bp
    ON bp.check_in_id = ci.check_in_id
ORDER BY ci.checked_in_at DESC, f.service_date DESC;
```

### 8.2 Explicación paso a paso de la consulta
1. **`reservation`** aporta el código comercial de la reserva.
2. **`reservation_passenger`** conecta la reserva con la persona real.
3. **`person`** aporta la identidad del pasajero.
4. **`ticket`** representa el documento comercial emitido.
5. **`ticket_segment`** vincula el ticket con un segmento específico del itinerario.
6. **`flight_segment`** conecta ese segmento con la operación aérea.
7. **`flight`** aporta el número del vuelo y la fecha de servicio.
8. **`check_in`** confirma que el pasajero ya se registró.
9. **`boarding_pass`** prueba que el proceso operativo se completó.

La solución usa `INNER JOIN` porque el objetivo es listar únicamente pasajeros cuyo flujo de abordaje ya está completo.

---

## 9. Trigger resuelto

### 9.1 Decisión técnica
Se tomó un trigger `AFTER INSERT ON check_in` porque el `boarding_pass` depende de que el `check_in` exista primero. El modelo lo confirma, ya que `boarding_pass.check_in_id` referencia a `check_in(check_in_id)`.

### 9.2 Lógica implementada
- Si el `check_in` ya tiene pase asociado, no hace nada.
- Si no existe, genera:
  - `boarding_pass_code`
  - `barcode_value`
  - `issued_at`

### 9.3 Script del trigger

```sql
DROP TRIGGER IF EXISTS trg_ai_check_in_create_boarding_pass ON check_in;
DROP FUNCTION IF EXISTS fn_ai_check_in_create_boarding_pass();

CREATE OR REPLACE FUNCTION fn_ai_check_in_create_boarding_pass()
RETURNS trigger
LANGUAGE plpgsql
AS $$
DECLARE
    v_boarding_pass_code varchar(40);
    v_barcode_value varchar(120);
BEGIN
    IF EXISTS (
        SELECT 1
        FROM boarding_pass bp
        WHERE bp.check_in_id = NEW.check_in_id
    ) THEN
        RETURN NEW;
    END IF;

    v_boarding_pass_code := 'BP-' || replace(NEW.check_in_id::text, '-', '');
    v_barcode_value := 'BAR-' || replace(NEW.check_in_id::text, '-', '') || '-' || to_char(NEW.checked_in_at, 'YYYYMMDDHH24MISS');

    INSERT INTO boarding_pass (
        check_in_id,
        boarding_pass_code,
        barcode_value,
        issued_at
    )
    VALUES (
        NEW.check_in_id,
        left(v_boarding_pass_code, 40),
        left(v_barcode_value, 120),
        NEW.checked_in_at
    );

    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_ai_check_in_create_boarding_pass
AFTER INSERT ON check_in
FOR EACH ROW
EXECUTE FUNCTION fn_ai_check_in_create_boarding_pass();
```

### 9.4 Por qué esta solución es correcta
- No cambia ninguna tabla del modelo.
- Usa relaciones reales existentes.
- Respeta la unicidad de `boarding_pass.check_in_id`.
- Automatiza el paso que naturalmente ocurre después del check-in.

---

## 10. Procedimiento almacenado resuelto

### 10.1 Objetivo
Centralizar el registro del check-in para que la aplicación no tenga que repetir la lógica de inserción en múltiples puntos.

### 10.2 Decisión técnica
El procedimiento valida primero si el `ticket_segment_id` ya fue usado en un check-in previo, porque la tabla `check_in` tiene la restricción `uq_check_in_ticket_segment`.

### 10.3 Script del procedimiento

```sql
CREATE OR REPLACE PROCEDURE sp_register_check_in(
    p_ticket_segment_id       uuid,
    p_check_in_status_id      uuid,
    p_boarding_group_id       uuid,
    p_checked_in_by_user_id   uuid,
    p_checked_in_at           timestamptz
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM check_in ci
        WHERE ci.ticket_segment_id = p_ticket_segment_id
    ) THEN
        RAISE EXCEPTION 'Ya existe un check-in para el ticket_segment_id %', p_ticket_segment_id;
    END IF;

    INSERT INTO check_in (
        ticket_segment_id,
        check_in_status_id,
        boarding_group_id,
        checked_in_by_user_id,
        checked_in_at
    )
    VALUES (
        p_ticket_segment_id,
        p_check_in_status_id,
        p_boarding_group_id,
        p_checked_in_by_user_id,
        p_checked_in_at
    );
END;
$$;
```

### 10.4 Por qué esta solución es correcta
- Encapsula la inserción.
- Evita duplicados.
- Deja que el trigger resuelva automáticamente el `boarding_pass`.
- Se alinea con el flujo real del negocio: primero check-in, luego pase de abordar.

---

## 11. Script de demostración del funcionamiento

```sql
DO $$
DECLARE
    v_ticket_segment_id       uuid;
    v_check_in_status_id      uuid;
    v_boarding_group_id       uuid;
    v_checked_in_by_user_id   uuid;
BEGIN
    SELECT ts.ticket_segment_id
    INTO v_ticket_segment_id
    FROM ticket_segment ts
    LEFT JOIN check_in ci
        ON ci.ticket_segment_id = ts.ticket_segment_id
    WHERE ci.check_in_id IS NULL
    ORDER BY ts.created_at
    LIMIT 1;

    SELECT cis.check_in_status_id
    INTO v_check_in_status_id
    FROM check_in_status cis
    ORDER BY cis.created_at
    LIMIT 1;

    SELECT bg.boarding_group_id
    INTO v_boarding_group_id
    FROM boarding_group bg
    ORDER BY bg.sequence_no
    LIMIT 1;

    SELECT ua.user_account_id
    INTO v_checked_in_by_user_id
    FROM user_account ua
    ORDER BY ua.created_at
    LIMIT 1;

    IF v_ticket_segment_id IS NULL THEN
        RAISE EXCEPTION 'No existe ticket_segment disponible sin check-in.';
    END IF;

    IF v_check_in_status_id IS NULL THEN
        RAISE EXCEPTION 'No existe check_in_status cargado.';
    END IF;

    IF v_checked_in_by_user_id IS NULL THEN
        RAISE EXCEPTION 'No existe user_account disponible.';
    END IF;

    CALL sp_register_check_in(
        v_ticket_segment_id,
        v_check_in_status_id,
        v_boarding_group_id,
        v_checked_in_by_user_id,
        now()
    );
END;
$$;

SELECT
    ci.check_in_id,
    ci.ticket_segment_id,
    ci.checked_in_at,
    bp.boarding_pass_id,
    bp.boarding_pass_code,
    bp.barcode_value
FROM check_in ci
INNER JOIN boarding_pass bp
    ON bp.check_in_id = ci.check_in_id
ORDER BY ci.created_at DESC
LIMIT 5;
```

### 11.1 Qué demuestra este script
1. Busca un `ticket_segment` disponible sin check-in previo.
2. Obtiene un estado de check-in, un grupo de abordaje y un usuario del sistema.
3. Valida que los identificadores necesarios existan antes de proceder.
4. Ejecuta el procedimiento almacenado `sp_register_check_in`.
5. El procedimiento inserta en `check_in`.
6. El trigger `trg_ai_check_in_create_boarding_pass` se dispara automáticamente.
7. Se valida que el `boarding_pass` fue generado correctamente.

---

## 12. Validación final
La solución es válida porque:
- la consulta usa `INNER JOIN` en más de 5 tablas reales del modelo,
- el trigger es `AFTER INSERT` y produce un efecto verificable sobre `boarding_pass`,
- el procedimiento almacenado es reutilizable y encapsula la operación principal,
- la demostración prueba la ejecución completa del flujo de extremo a extremo,
- no se alteró ningún atributo, tabla ni relación del modelo base.

---

## 13. Archivos SQL relacionados
- `scripts_sql/ejercicio_01_setup.sql`
- `scripts_sql/ejercicio_01_demo.sql`