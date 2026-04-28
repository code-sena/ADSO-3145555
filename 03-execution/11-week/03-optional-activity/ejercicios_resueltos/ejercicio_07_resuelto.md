# Ejercicio 07 Resuelto - Asignación de asientos y registro de equipaje por segmento ticketed

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
El área de aeropuerto necesita auditar qué asientos y equipajes están asociados a cada segmento ticketed y automatizar la confirmación operativa del asiento cuando se registra el equipaje del pasajero, señalando que el proceso aeroportuario quedó completo para ese segmento.

---

## 6. Dominios involucrados
### SALES, RESERVATION, TICKETING
**Entidades:** `ticket`, `ticket_segment`, `seat_assignment`, `baggage`  
**Propósito en este ejercicio:** gestionar el tiquete, su segmento, la asignación de asiento y el equipaje asociado.

### AIRCRAFT
**Entidades:** `aircraft`, `aircraft_cabin`, `aircraft_seat`, `cabin_class`  
**Propósito en este ejercicio:** relacionar el asiento asignado con la configuración real de la aeronave y su cabina.

### FLIGHT OPERATIONS
**Entidades:** `flight`, `flight_segment`  
**Propósito en este ejercicio:** relacionar el segmento ticketed con el segmento operativo del vuelo.

---

## 7. Problema a resolver
Se requiere consultar de manera integrada la asignación de asientos y el registro de equipaje por pasajero y segmento, y además automatizar la confirmación del asiento cuando se registra el equipaje, garantizando que ambos eventos queden trazados de forma consistente.

El modelo ya posee las tablas necesarias para almacenar asientos y equipajes. Sin embargo, si la confirmación del asiento se gestiona manualmente, el flujo aeroportuario queda expuesto a inconsistencias entre el registro del equipaje y el estado de la asignación.

Por eso se plantea una solución en tres capas:
1. una consulta consolidada con `INNER JOIN`,
2. un trigger `AFTER INSERT` sobre `baggage`,
3. un procedimiento almacenado que centralice el registro del equipaje.

---

## 8. Solución propuesta

### 8.1 Consulta resuelta con `INNER JOIN`
Se eligió una consulta que conecta nueve tablas reales del modelo. La consulta muestra la trazabilidad aeroportuaria completa del pasajero: tiquete, segmento ticketed, vuelo, asiento, cabina y equipaje.

```sql
SELECT
    t.ticket_number,
    ts.sequence_number            AS secuencia_segmento,
    f.flight_number,
    cc.class_name                 AS cabina,
    ase.row_number                AS fila_asiento,
    ase.column_letter             AS columna_asiento,
    b.baggage_tag                 AS etiqueta_equipaje,
    b.baggage_type                AS tipo_equipaje,
    b.baggage_status              AS estado_equipaje
FROM ticket t
INNER JOIN ticket_segment ts
    ON ts.ticket_id = t.ticket_id
INNER JOIN flight_segment fs
    ON fs.flight_segment_id = ts.flight_segment_id
INNER JOIN flight f
    ON f.flight_id = fs.flight_id
INNER JOIN seat_assignment sa
    ON sa.ticket_segment_id = ts.ticket_segment_id
INNER JOIN aircraft_seat ase
    ON ase.aircraft_seat_id = sa.aircraft_seat_id
INNER JOIN aircraft_cabin ac
    ON ac.aircraft_cabin_id = ase.aircraft_cabin_id
INNER JOIN cabin_class cc
    ON cc.cabin_class_id = ac.cabin_class_id
INNER JOIN baggage b
    ON b.ticket_segment_id = ts.ticket_segment_id
ORDER BY t.ticket_number, ts.sequence_number;
```

### 8.2 Explicación paso a paso de la consulta
1. **`ticket`** aporta el número del documento comercial del pasajero.
2. **`ticket_segment`** vincula el tiquete con un segmento específico del itinerario.
3. **`flight_segment`** conecta ese segmento ticketed con la operación aérea real.
4. **`flight`** aporta el número de vuelo asociado al segmento.
5. **`seat_assignment`** registra el asiento asignado al pasajero en ese segmento.
6. **`aircraft_seat`** describe la fila y columna física del asiento en la aeronave.
7. **`aircraft_cabin`** agrupa los asientos por cabina dentro de la aeronave.
8. **`cabin_class`** identifica la clase de cabina del asiento asignado.
9. **`baggage`** registra el equipaje facturado para ese segmento ticketed.

La solución usa `INNER JOIN` porque el objetivo es listar únicamente segmentos que tienen asiento asignado, cabina definida y equipaje registrado de forma completa.

---

## 9. Trigger resuelto

### 9.1 Decisión técnica
Se tomó un trigger `AFTER INSERT ON baggage` porque la confirmación del asiento debe ocurrir después de que el equipaje ya esté persistido, lo que indica que el proceso aeroportuario para ese segmento avanzó al siguiente estado. El modelo lo soporta mediante el campo `seat_assignment.is_confirmed`, que señala si el asiento fue confirmado operativamente.

### 9.2 Lógica implementada
- Verifica si existe una asignación de asiento para el mismo `ticket_segment_id` del equipaje insertado.
- Si existe, actualiza `seat_assignment.is_confirmed = true` para ese segmento.
- Si no existe asignación de asiento, no ejecuta ninguna acción adicional.

### 9.3 Script del trigger

```sql
DROP TRIGGER IF EXISTS trg_ai_baggage_update_seat_assignment_status ON baggage;
DROP FUNCTION IF EXISTS fn_ai_baggage_update_seat_assignment_status();

CREATE OR REPLACE FUNCTION fn_ai_baggage_update_seat_assignment_status()
RETURNS trigger
LANGUAGE plpgsql
AS $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM seat_assignment sa
        WHERE sa.ticket_segment_id = NEW.ticket_segment_id
    ) THEN
        UPDATE seat_assignment
        SET is_confirmed = true
        WHERE ticket_segment_id = NEW.ticket_segment_id;
    END IF;

    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_ai_baggage_update_seat_assignment_status
AFTER INSERT ON baggage
FOR EACH ROW
EXECUTE FUNCTION fn_ai_baggage_update_seat_assignment_status();
```

### 9.4 Por qué esta solución es correcta
- No cambia ninguna tabla del modelo.
- Usa la relación real entre `baggage` y `seat_assignment` a través de `ticket_segment_id`.
- Actualiza únicamente `is_confirmed`, que representa el estado operativo de la asignación.
- Automatiza el efecto que naturalmente debe ocurrir cuando el equipaje del pasajero queda registrado para un segmento.

---

## 10. Procedimiento almacenado resuelto

### 10.1 Objetivo
Centralizar el registro del equipaje para garantizar que el segmento ticketed exista y que la etiqueta no esté duplicada antes de persistir el registro, dejando al trigger la responsabilidad de confirmar el asiento asociado.

### 10.2 Decisión técnica
El procedimiento valida dos condiciones antes de insertar: que el `ticket_segment_id` exista y que la `baggage_tag` no esté duplicada en el sistema. Esto protege la unicidad operativa del equipaje sin modificar ninguna restricción del modelo base.

### 10.3 Script del procedimiento

```sql
CREATE OR REPLACE PROCEDURE sp_register_baggage(
    p_ticket_segment_id   uuid,
    p_baggage_tag         varchar,
    p_baggage_type        varchar,
    p_baggage_status      varchar,
    p_registered_at       timestamptz
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM ticket_segment ts
        WHERE ts.ticket_segment_id = p_ticket_segment_id
    ) THEN
        RAISE EXCEPTION 'No existe un ticket_segment con ticket_segment_id %', p_ticket_segment_id;
    END IF;

    IF EXISTS (
        SELECT 1
        FROM baggage b
        WHERE b.baggage_tag = p_baggage_tag
    ) THEN
        RAISE EXCEPTION 'Ya existe un equipaje registrado con la etiqueta %', p_baggage_tag;
    END IF;

    INSERT INTO baggage (
        ticket_segment_id,
        baggage_tag,
        baggage_type,
        baggage_status,
        registered_at
    )
    VALUES (
        p_ticket_segment_id,
        p_baggage_tag,
        p_baggage_type,
        p_baggage_status,
        p_registered_at
    );
END;
$$;
```

### 10.4 Por qué esta solución es correcta
- Encapsula el registro del equipaje con validación de existencia y unicidad de etiqueta.
- Evita equipajes huérfanos sin segmento ticketed válido.
- Deja que el trigger confirme automáticamente el asiento asociado en `seat_assignment`.
- Se alinea con el flujo real del negocio: primero se registra el equipaje, luego el sistema marca el asiento como confirmado.

---

## 11. Script de demostración del funcionamiento

```sql
DO $$
DECLARE
    v_ticket_segment_id   uuid;
    v_baggage_tag         varchar;
    v_baggage_type        varchar := 'checked';
    v_baggage_status      varchar := 'checked_in';
    v_registered_at       timestamptz := now();
BEGIN
    SELECT ts.ticket_segment_id
    INTO v_ticket_segment_id
    FROM ticket_segment ts
    INNER JOIN seat_assignment sa
        ON sa.ticket_segment_id = ts.ticket_segment_id
    LEFT JOIN baggage b
        ON b.ticket_segment_id = ts.ticket_segment_id
    WHERE b.baggage_id IS NULL
    ORDER BY ts.created_at
    LIMIT 1;

    IF v_ticket_segment_id IS NULL THEN
        SELECT ts.ticket_segment_id
        INTO v_ticket_segment_id
        FROM ticket_segment ts
        ORDER BY ts.created_at
        LIMIT 1;
    END IF;

    IF v_ticket_segment_id IS NULL THEN
        RAISE EXCEPTION 'No existe ningún ticket_segment disponible en el sistema.';
    END IF;

    v_baggage_tag := 'BAG-' || left(replace(v_ticket_segment_id::text, '-', ''), 16);

    CALL sp_register_baggage(
        v_ticket_segment_id,
        v_baggage_tag,
        v_baggage_type,
        v_baggage_status,
        v_registered_at
    );
END;
$$;

SELECT
    b.baggage_id,
    b.ticket_segment_id,
    b.baggage_tag,
    b.baggage_type,
    b.baggage_status,
    b.registered_at,
    sa.seat_assignment_id,
    sa.is_confirmed            AS asiento_confirmado,
    ase.row_number             AS fila,
    ase.column_letter          AS columna
FROM baggage b
INNER JOIN seat_assignment sa
    ON sa.ticket_segment_id = b.ticket_segment_id
INNER JOIN aircraft_seat ase
    ON ase.aircraft_seat_id = sa.aircraft_seat_id
ORDER BY b.registered_at DESC
LIMIT 5;
```

### 11.1 Qué demuestra este script
1. Busca preferentemente un `ticket_segment` con asiento asignado pero sin equipaje registrado, usando `INNER JOIN` con `seat_assignment` y `LEFT JOIN` con `baggage`.
2. Si no hay ninguno en esa condición, toma cualquier segmento disponible como fallback.
3. Genera dinámicamente una etiqueta de equipaje única derivada del `ticket_segment_id`.
4. Valida que el segmento exista antes de proceder.
5. Ejecuta el procedimiento almacenado `sp_register_baggage`.
6. El procedimiento inserta en `baggage`.
7. El trigger `trg_ai_baggage_update_seat_assignment_status` detecta la asignación de asiento del mismo `ticket_segment_id` y actualiza `is_confirmed = true`.
8. La consulta final valida que el equipaje fue registrado y que el campo `is_confirmed` del asiento refleja la confirmación operativa.

---

## 12. Validación final
La solución es válida porque:
- la consulta usa `INNER JOIN` en más de 5 tablas reales del modelo, conectando nueve entidades del dominio aeroportuario,
- el trigger es `AFTER INSERT` y produce un efecto verificable sobre `seat_assignment.is_confirmed`,
- el procedimiento almacenado es reutilizable y encapsula el registro del equipaje con doble validación,
- la demostración prueba la ejecución completa del flujo aeroportuario de asientos y equipaje,
- no se alteró ningún atributo, tabla ni relación del modelo base.

---

## 13. Archivos SQL relacionados
- `scripts_sql/ejercicio_07_setup.sql`
- `scripts_sql/ejercicio_07_demo.sql`