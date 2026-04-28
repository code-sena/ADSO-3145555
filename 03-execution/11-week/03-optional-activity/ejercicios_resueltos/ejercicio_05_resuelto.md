# Ejercicio 05 Resuelto - Mantenimiento de aeronaves y habilitación operativa

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
El área técnica desea consultar el historial de mantenimiento de las aeronaves y automatizar la actualización del estado operativo de la aeronave cada vez que se registre un nuevo evento de mantenimiento, inhabilitándola cuando el mantenimiento está en curso y reactivándola cuando el evento se cierra como completado.

---

## 6. Dominios involucrados
### AIRCRAFT
**Entidades:** `aircraft`, `aircraft_model`, `aircraft_manufacturer`, `maintenance_event`, `maintenance_type`, `maintenance_provider`  
**Propósito en este ejercicio:** gestionar aeronaves, modelo, fabricante, tipos de mantenimiento, proveedores y eventos técnicos.

### AIRLINE
**Entidades:** `airline`  
**Propósito en este ejercicio:** relacionar cada aeronave con la aerolínea operadora del sistema.

### GEOGRAPHY AND REFERENCE DATA
**Entidades:** `address`  
**Propósito en este ejercicio:** relacionar la ubicación del proveedor de mantenimiento cuando aplique.

---

## 7. Problema a resolver
La organización necesita una visión consolidada de eventos de mantenimiento y un mecanismo automatizado que refleje el impacto operativo sobre la aeronave cada vez que se registra un evento técnico.

El modelo ya posee las tablas necesarias para almacenar eventos de mantenimiento y el campo `is_active` en `aircraft`. Sin embargo, si la habilitación operativa de la aeronave se gestiona manualmente, el flujo queda expuesto a inconsistencias entre el estado del mantenimiento y la disponibilidad real de la aeronave.

Por eso se plantea una solución en tres capas:
1. una consulta consolidada con `INNER JOIN`,
2. un trigger `AFTER INSERT` sobre `maintenance_event`,
3. un procedimiento almacenado que centralice el registro del evento de mantenimiento.

---

## 8. Solución propuesta

### 8.1 Consulta resuelta con `INNER JOIN`
Se eligió una consulta que conecta siete tablas reales del modelo. La consulta muestra la trazabilidad técnica completa de cada aeronave: aerolínea, modelo, fabricante, evento de mantenimiento, tipo e intervención y proveedor responsable.

```sql
SELECT
    a.registration_code        AS matricula,
    al.airline_name            AS aerolinea,
    am.model_name              AS modelo,
    amf.manufacturer_name      AS fabricante,
    mt.type_name               AS tipo_mantenimiento,
    mp.provider_name           AS proveedor,
    me.event_status            AS estado_evento,
    me.start_date              AS fecha_inicio,
    me.end_date                AS fecha_finalizacion
FROM aircraft a
INNER JOIN airline al
    ON al.airline_id = a.airline_id
INNER JOIN aircraft_model am
    ON am.aircraft_model_id = a.aircraft_model_id
INNER JOIN aircraft_manufacturer amf
    ON amf.aircraft_manufacturer_id = am.aircraft_manufacturer_id
INNER JOIN maintenance_event me
    ON me.aircraft_id = a.aircraft_id
INNER JOIN maintenance_type mt
    ON mt.maintenance_type_id = me.maintenance_type_id
INNER JOIN maintenance_provider mp
    ON mp.maintenance_provider_id = me.maintenance_provider_id
ORDER BY me.start_date DESC, a.registration_code;
```

### 8.2 Explicación paso a paso de la consulta
1. **`aircraft`** aporta la matrícula y el estado operativo de la aeronave.
2. **`airline`** identifica la aerolínea propietaria de la aeronave.
3. **`aircraft_model`** describe el modelo comercial de la aeronave.
4. **`aircraft_manufacturer`** aporta el fabricante del modelo.
5. **`maintenance_event`** registra cada intervención técnica con su estado y fechas.
6. **`maintenance_type`** categoriza el tipo de intervención realizada.
7. **`maintenance_provider`** identifica la empresa responsable del mantenimiento.

La solución usa `INNER JOIN` porque el objetivo es listar únicamente aeronaves que tienen eventos de mantenimiento completamente registrados con proveedor y tipo asociados.

---

## 9. Trigger resuelto

### 9.1 Decisión técnica
Se tomó un trigger `AFTER INSERT ON maintenance_event` porque la habilitación operativa de la aeronave debe reflejar el estado del mantenimiento una vez que el evento ya está persistido. El modelo lo soporta mediante el campo `aircraft.is_active`, que controla la disponibilidad operativa de cada aeronave.

### 9.2 Lógica implementada
- Si el `event_status` del nuevo evento indica mantenimiento en curso (`in_progress`, `scheduled`, `open`), actualiza `aircraft.is_active = false` para inhabilitar la aeronave.
- Si el `event_status` indica que el mantenimiento fue completado (`completed`, `closed`, `released`), actualiza `aircraft.is_active = true` para reactivarla.
- Si el estado no corresponde a ninguno de los casos definidos, no ejecuta ninguna acción adicional.

### 9.3 Script del trigger

```sql
DROP TRIGGER IF EXISTS trg_ai_maintenance_event_update_aircraft_status ON maintenance_event;
DROP FUNCTION IF EXISTS fn_ai_maintenance_event_update_aircraft_status();

CREATE OR REPLACE FUNCTION fn_ai_maintenance_event_update_aircraft_status()
RETURNS trigger
LANGUAGE plpgsql
AS $$
BEGIN
    IF lower(NEW.event_status) IN ('in_progress', 'scheduled', 'open') THEN
        UPDATE aircraft
        SET is_active = false
        WHERE aircraft_id = NEW.aircraft_id;
    END IF;

    IF lower(NEW.event_status) IN ('completed', 'closed', 'released') THEN
        UPDATE aircraft
        SET is_active = true
        WHERE aircraft_id = NEW.aircraft_id;
    END IF;

    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_ai_maintenance_event_update_aircraft_status
AFTER INSERT ON maintenance_event
FOR EACH ROW
EXECUTE FUNCTION fn_ai_maintenance_event_update_aircraft_status();
```

### 9.4 Por qué esta solución es correcta
- No cambia ninguna tabla del modelo.
- Usa la relación real entre `maintenance_event` y `aircraft` a través de `aircraft_id`.
- Actualiza únicamente el campo `is_active`, que representa la disponibilidad operativa sin alterar ningún otro atributo.
- Automatiza el efecto que naturalmente debe ocurrir en la aeronave al registrar un evento técnico.

---

## 10. Procedimiento almacenado resuelto

### 10.1 Objetivo
Centralizar el registro de un evento de mantenimiento para garantizar que la aeronave, el tipo de mantenimiento y el proveedor existan antes de persistir el evento, dejando al trigger la responsabilidad de actualizar el estado operativo.

### 10.2 Decisión técnica
El procedimiento valida tres condiciones antes de insertar: que la aeronave exista, que el tipo de mantenimiento exista y que el proveedor exista. Esto protege la integridad referencial del evento sin modificar ninguna restricción del modelo base.

### 10.3 Script del procedimiento

```sql
CREATE OR REPLACE PROCEDURE sp_register_maintenance_event(
    p_aircraft_id              uuid,
    p_maintenance_type_id      uuid,
    p_maintenance_provider_id  uuid,
    p_event_status             varchar,
    p_start_date               timestamptz,
    p_notes                    varchar
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM aircraft a
        WHERE a.aircraft_id = p_aircraft_id
    ) THEN
        RAISE EXCEPTION 'No existe una aeronave con aircraft_id %', p_aircraft_id;
    END IF;

    IF NOT EXISTS (
        SELECT 1
        FROM maintenance_type mt
        WHERE mt.maintenance_type_id = p_maintenance_type_id
    ) THEN
        RAISE EXCEPTION 'No existe un tipo de mantenimiento con maintenance_type_id %', p_maintenance_type_id;
    END IF;

    IF NOT EXISTS (
        SELECT 1
        FROM maintenance_provider mp
        WHERE mp.maintenance_provider_id = p_maintenance_provider_id
    ) THEN
        RAISE EXCEPTION 'No existe un proveedor de mantenimiento con maintenance_provider_id %', p_maintenance_provider_id;
    END IF;

    INSERT INTO maintenance_event (
        aircraft_id,
        maintenance_type_id,
        maintenance_provider_id,
        event_status,
        start_date,
        notes
    )
    VALUES (
        p_aircraft_id,
        p_maintenance_type_id,
        p_maintenance_provider_id,
        p_event_status,
        p_start_date,
        p_notes
    );
END;
$$;
```

### 10.4 Por qué esta solución es correcta
- Encapsula el registro del evento de mantenimiento con triple validación referencial.
- Evita eventos huérfanos sin aeronave, tipo o proveedor válidos.
- Deja que el trigger actualice automáticamente `aircraft.is_active` según el estado del evento.
- Se alinea con el flujo real del negocio: primero se registra el evento técnico, luego el sistema refleja el impacto operativo sobre la aeronave.

---

## 11. Script de demostración del funcionamiento

```sql
DO $$
DECLARE
    v_aircraft_id              uuid;
    v_maintenance_type_id      uuid;
    v_maintenance_provider_id  uuid;
    v_event_status             varchar := 'in_progress';
    v_start_date               timestamptz := now();
    v_notes                    varchar := 'Mantenimiento programado - inspección de sistemas de navegación';
BEGIN
    SELECT a.aircraft_id
    INTO v_aircraft_id
    FROM aircraft a
    WHERE a.is_active = true
    ORDER BY a.created_at
    LIMIT 1;

    IF v_aircraft_id IS NULL THEN
        SELECT a.aircraft_id
        INTO v_aircraft_id
        FROM aircraft a
        ORDER BY a.created_at
        LIMIT 1;
    END IF;

    SELECT mt.maintenance_type_id
    INTO v_maintenance_type_id
    FROM maintenance_type mt
    ORDER BY mt.created_at
    LIMIT 1;

    SELECT mp.maintenance_provider_id
    INTO v_maintenance_provider_id
    FROM maintenance_provider mp
    ORDER BY mp.created_at
    LIMIT 1;

    IF v_aircraft_id IS NULL THEN
        RAISE EXCEPTION 'No existe ninguna aeronave disponible en el sistema.';
    END IF;

    IF v_maintenance_type_id IS NULL THEN
        RAISE EXCEPTION 'No existe ningún tipo de mantenimiento disponible en el sistema.';
    END IF;

    IF v_maintenance_provider_id IS NULL THEN
        RAISE EXCEPTION 'No existe ningún proveedor de mantenimiento disponible en el sistema.';
    END IF;

    CALL sp_register_maintenance_event(
        v_aircraft_id,
        v_maintenance_type_id,
        v_maintenance_provider_id,
        v_event_status,
        v_start_date,
        v_notes
    );
END;
$$;

SELECT
    a.aircraft_id,
    a.registration_code        AS matricula,
    a.is_active                AS aeronave_activa,
    me.maintenance_event_id,
    me.event_status,
    me.start_date,
    me.notes,
    mt.type_name               AS tipo_mantenimiento,
    mp.provider_name           AS proveedor
FROM aircraft a
INNER JOIN maintenance_event me
    ON me.aircraft_id = a.aircraft_id
INNER JOIN maintenance_type mt
    ON mt.maintenance_type_id = me.maintenance_type_id
INNER JOIN maintenance_provider mp
    ON mp.maintenance_provider_id = me.maintenance_provider_id
ORDER BY me.created_at DESC
LIMIT 5;
```

### 11.1 Qué demuestra este script
1. Busca preferentemente una aeronave con `is_active = true`; si no hay, toma cualquier aeronave disponible.
2. Obtiene el primer tipo de mantenimiento y el primer proveedor disponibles.
3. Valida que los tres identificadores necesarios existan antes de proceder.
4. Ejecuta el procedimiento almacenado `sp_register_maintenance_event` con estado `in_progress`.
5. El procedimiento inserta en `maintenance_event`.
6. El trigger `trg_ai_maintenance_event_update_aircraft_status` detecta el estado `in_progress` y actualiza `aircraft.is_active = false`.
7. La consulta final valida que el evento fue registrado y que el campo `is_active` de la aeronave refleja el estado inhabilitado.

---

## 12. Validación final
La solución es válida porque:
- la consulta usa `INNER JOIN` en más de 5 tablas reales del modelo,
- el trigger es `AFTER INSERT` y produce un efecto verificable sobre `aircraft.is_active`,
- el procedimiento almacenado es reutilizable y encapsula el registro del evento con triple validación,
- la demostración prueba la ejecución completa del flujo técnico de mantenimiento,
- no se alteró ningún atributo, tabla ni relación del modelo base.

---

## 13. Archivos SQL relacionados
- `scripts_sql/ejercicio_05_setup.sql`
- `scripts_sql/ejercicio_05_demo.sql`