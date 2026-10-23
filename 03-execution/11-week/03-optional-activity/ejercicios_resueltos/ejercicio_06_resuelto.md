# Ejercicio 06 Resuelto - Retrasos operativos y análisis de impacto por segmento de vuelo

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
La gerencia de operaciones necesita auditar los retrasos registrados por segmento de vuelo y automatizar la actualización del estado del vuelo a `delayed` cada vez que se reporte una demora operacional sobre cualquiera de sus segmentos.

---

## 6. Dominios involucrados
### FLIGHT OPERATIONS
**Entidades:** `flight`, `flight_segment`, `flight_status`, `flight_delay`, `delay_reason_type`  
**Propósito en este ejercicio:** gestionar vuelos, segmentos, estados y retrasos operativos.

### AIRPORT
**Entidades:** `airport`  
**Propósito en este ejercicio:** identificar los aeropuertos de origen y destino de cada segmento de vuelo.

### AIRLINE
**Entidades:** `airline`  
**Propósito en este ejercicio:** relacionar el vuelo con la aerolínea operadora.

---

## 7. Problema a resolver
Se necesita consultar los retrasos por segmento de vuelo con todo su contexto operativo y automatizar la actualización del estado del vuelo cada vez que se registra una demora, garantizando que el estado en `flight` refleje de forma inmediata el impacto operacional.

El modelo ya posee las tablas necesarias para almacenar demoras y estados. Sin embargo, si el estado del vuelo se actualiza manualmente, el flujo queda expuesto a inconsistencias entre la demora registrada y el estado visible del vuelo.

Por eso se plantea una solución en tres capas:
1. una consulta consolidada con `INNER JOIN`,
2. un trigger `AFTER INSERT` sobre `flight_delay`,
3. un procedimiento almacenado que centralice el registro de la demora.

---

## 8. Solución propuesta

### 8.1 Consulta resuelta con `INNER JOIN`
Se eligió una consulta que conecta ocho tablas reales del modelo. La consulta muestra la trazabilidad operativa completa por vuelo y segmento: aerolínea, número de vuelo, estado, trayecto origen-destino, minutos de demora y motivo.

```sql
SELECT
    al.airline_name                  AS aerolinea,
    f.flight_number,
    f.service_date                   AS fecha_servicio,
    fst.status_name                  AS estado_vuelo,
    fs.segment_number                AS segmento,
    ap_orig.airport_name             AS aeropuerto_origen,
    ap_dest.airport_name             AS aeropuerto_destino,
    fd.delay_minutes                 AS minutos_demora,
    drt.reason_name                  AS motivo_retraso
FROM flight f
INNER JOIN airline al
    ON al.airline_id = f.airline_id
INNER JOIN flight_status fst
    ON fst.flight_status_id = f.flight_status_id
INNER JOIN flight_segment fs
    ON fs.flight_id = f.flight_id
INNER JOIN airport ap_orig
    ON ap_orig.airport_id = fs.origin_airport_id
INNER JOIN airport ap_dest
    ON ap_dest.airport_id = fs.destination_airport_id
INNER JOIN flight_delay fd
    ON fd.flight_segment_id = fs.flight_segment_id
INNER JOIN delay_reason_type drt
    ON drt.delay_reason_type_id = fd.delay_reason_type_id
ORDER BY f.service_date DESC, fs.segment_number;
```

### 8.2 Explicación paso a paso de la consulta
1. **`flight`** aporta el número de vuelo y la fecha de servicio.
2. **`airline`** identifica la aerolínea operadora del vuelo.
3. **`flight_status`** expone el estado actual del vuelo.
4. **`flight_segment`** detalla cada segmento del itinerario operativo.
5. **`airport` (origen)** identifica el aeropuerto de salida del segmento.
6. **`airport` (destino)** identifica el aeropuerto de llegada del segmento.
7. **`flight_delay`** registra la demora reportada sobre el segmento.
8. **`delay_reason_type`** categoriza el motivo de la demora.

La tabla `airport` se usa dos veces con alias distintos (`ap_orig` y `ap_dest`) para representar origen y destino dentro del mismo `JOIN`. La solución usa `INNER JOIN` porque el objetivo es listar únicamente segmentos que tienen demoras completamente registradas con motivo asociado.

---

## 9. Trigger resuelto

### 9.1 Decisión técnica
Se tomó un trigger `AFTER INSERT ON flight_delay` porque el estado del vuelo debe actualizarse después de que la demora ya esté persistida. El modelo lo soporta mediante `flight.flight_status_id`, que referencia a `flight_status` y controla el estado visible del vuelo en el sistema.

### 9.2 Lógica implementada
- Recupera el `flight_id` a partir del `flight_segment_id` de la demora insertada.
- Busca el `flight_status_id` cuyo `status_code` corresponda a `delayed`.
- Si ambos valores existen, actualiza `flight.flight_status_id` con el estado de demora.
- Si alguno de los dos no existe, retorna sin ejecutar ninguna acción adicional.

### 9.3 Script del trigger

```sql
DROP TRIGGER IF EXISTS trg_ai_flight_delay_update_flight_status ON flight_delay;
DROP FUNCTION IF EXISTS fn_ai_flight_delay_update_flight_status();

CREATE OR REPLACE FUNCTION fn_ai_flight_delay_update_flight_status()
RETURNS trigger
LANGUAGE plpgsql
AS $$
DECLARE
    v_delayed_status_id   uuid;
    v_flight_id           uuid;
BEGIN
    SELECT fs.flight_id
    INTO v_flight_id
    FROM flight_segment fs
    WHERE fs.flight_segment_id = NEW.flight_segment_id;

    SELECT fst.flight_status_id
    INTO v_delayed_status_id
    FROM flight_status fst
    WHERE lower(fst.status_code) IN ('delayed', 'delay', 'demorado')
    ORDER BY fst.created_at
    LIMIT 1;

    IF v_flight_id IS NULL OR v_delayed_status_id IS NULL THEN
        RETURN NEW;
    END IF;

    UPDATE flight
    SET flight_status_id = v_delayed_status_id
    WHERE flight_id = v_flight_id;

    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_ai_flight_delay_update_flight_status
AFTER INSERT ON flight_delay
FOR EACH ROW
EXECUTE FUNCTION fn_ai_flight_delay_update_flight_status();
```

### 9.4 Por qué esta solución es correcta
- No cambia ninguna tabla del modelo.
- Usa la relación real entre `flight_delay`, `flight_segment` y `flight` a través de sus llaves foráneas.
- Actualiza únicamente `flight_status_id`, que es el campo estándar de estado del vuelo.
- Automatiza el efecto que naturalmente debe ocurrir cuando se reporta una demora sobre cualquier segmento del vuelo.

---

## 10. Procedimiento almacenado resuelto

### 10.1 Objetivo
Centralizar el registro de una demora operativa para garantizar que el segmento de vuelo y el motivo de retraso existan, y que los minutos sean válidos antes de persistir el evento, dejando al trigger la responsabilidad de actualizar el estado del vuelo.

### 10.2 Decisión técnica
El procedimiento valida tres condiciones antes de insertar: que el segmento de vuelo exista, que el motivo de retraso exista y que los minutos de demora sean mayores a cero. Esto protege la integridad del registro operativo sin modificar ninguna restricción del modelo base.

### 10.3 Script del procedimiento

```sql
CREATE OR REPLACE PROCEDURE sp_register_flight_delay(
    p_flight_segment_id      uuid,
    p_delay_reason_type_id   uuid,
    p_reported_at            timestamptz,
    p_delay_minutes          integer,
    p_notes                  varchar
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM flight_segment fs
        WHERE fs.flight_segment_id = p_flight_segment_id
    ) THEN
        RAISE EXCEPTION 'No existe un segmento de vuelo con flight_segment_id %', p_flight_segment_id;
    END IF;

    IF NOT EXISTS (
        SELECT 1
        FROM delay_reason_type drt
        WHERE drt.delay_reason_type_id = p_delay_reason_type_id
    ) THEN
        RAISE EXCEPTION 'No existe un motivo de retraso con delay_reason_type_id %', p_delay_reason_type_id;
    END IF;

    IF p_delay_minutes <= 0 THEN
        RAISE EXCEPTION 'Los minutos de demora deben ser mayores a cero. Valor recibido: %', p_delay_minutes;
    END IF;

    INSERT INTO flight_delay (
        flight_segment_id,
        delay_reason_type_id,
        reported_at,
        delay_minutes,
        notes
    )
    VALUES (
        p_flight_segment_id,
        p_delay_reason_type_id,
        p_reported_at,
        p_delay_minutes,
        p_notes
    );
END;
$$;
```

### 10.4 Por qué esta solución es correcta
- Encapsula el registro de la demora con doble validación referencial más validación de negocio.
- Evita demoras con segmento o motivo inexistentes y rechaza minutos no positivos.
- Deja que el trigger actualice automáticamente `flight.flight_status_id` al estado `delayed`.
- Se alinea con el flujo real del negocio: primero se registra la demora, luego el sistema refleja el impacto en el estado del vuelo.

---

## 11. Script de demostración del funcionamiento

```sql
DO $$
DECLARE
    v_flight_segment_id      uuid;
    v_delay_reason_type_id   uuid;
    v_reported_at            timestamptz := now();
    v_delay_minutes          integer := 45;
    v_notes                  varchar := 'Demora por condiciones meteorológicas adversas en aeropuerto de origen';
BEGIN
    SELECT fs.flight_segment_id
    INTO v_flight_segment_id
    FROM flight_segment fs
    LEFT JOIN flight_delay fd
        ON fd.flight_segment_id = fs.flight_segment_id
    WHERE fd.flight_delay_id IS NULL
    ORDER BY fs.created_at
    LIMIT 1;

    IF v_flight_segment_id IS NULL THEN
        SELECT fs.flight_segment_id
        INTO v_flight_segment_id
        FROM flight_segment fs
        ORDER BY fs.created_at
        LIMIT 1;
    END IF;

    SELECT drt.delay_reason_type_id
    INTO v_delay_reason_type_id
    FROM delay_reason_type drt
    ORDER BY drt.created_at
    LIMIT 1;

    IF v_flight_segment_id IS NULL THEN
        RAISE EXCEPTION 'No existe ningún segmento de vuelo disponible en el sistema.';
    END IF;

    IF v_delay_reason_type_id IS NULL THEN
        RAISE EXCEPTION 'No existe ningún motivo de retraso disponible en el sistema.';
    END IF;

    CALL sp_register_flight_delay(
        v_flight_segment_id,
        v_delay_reason_type_id,
        v_reported_at,
        v_delay_minutes,
        v_notes
    );
END;
$$;

SELECT
    f.flight_id,
    f.flight_number,
    f.service_date,
    fst.status_name                  AS estado_vuelo_actualizado,
    fs.segment_number                AS segmento,
    fd.flight_delay_id,
    fd.delay_minutes                 AS minutos_demora,
    fd.reported_at,
    fd.notes,
    drt.reason_name                  AS motivo_retraso
FROM flight_delay fd
INNER JOIN flight_segment fs
    ON fs.flight_segment_id = fd.flight_segment_id
INNER JOIN flight f
    ON f.flight_id = fs.flight_id
INNER JOIN flight_status fst
    ON fst.flight_status_id = f.flight_status_id
INNER JOIN delay_reason_type drt
    ON drt.delay_reason_type_id = fd.delay_reason_type_id
ORDER BY fd.reported_at DESC
LIMIT 5;
```

### 11.1 Qué demuestra este script
1. Busca preferentemente un segmento de vuelo sin demora registrada usando `LEFT JOIN`; si todos tienen demora, toma cualquier segmento disponible.
2. Obtiene el primer motivo de retraso disponible en el sistema.
3. Valida que ambos identificadores existan antes de proceder.
4. Ejecuta el procedimiento almacenado `sp_register_flight_delay` con 45 minutos de demora.
5. El procedimiento inserta en `flight_delay`.
6. El trigger `trg_ai_flight_delay_update_flight_status` navega desde el segmento hasta el vuelo y actualiza `flight.flight_status_id` al estado `delayed`.
7. La consulta final valida que la demora fue registrada y que el campo `status_name` del vuelo refleja el estado actualizado.

---

## 12. Validación final
La solución es válida porque:
- la consulta usa `INNER JOIN` en más de 5 tablas reales del modelo, con doble uso de `airport` mediante alias para origen y destino,
- el trigger es `AFTER INSERT` y produce un efecto verificable sobre `flight.flight_status_id`,
- el procedimiento almacenado es reutilizable y encapsula el registro de la demora con triple validación,
- la demostración prueba la ejecución completa del flujo operativo de retrasos,
- no se alteró ningún atributo, tabla ni relación del modelo base.

---

## 13. Archivos SQL relacionados
- `scripts_sql/ejercicio_06_setup.sql`
- `scripts_sql/ejercicio_06_demo.sql`