# Ejercicio 08 Resuelto - Auditoría de acceso y asignación de roles a usuarios

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
El equipo de seguridad requiere consultar cómo están asignados los permisos en el sistema y automatizar la activación de la cuenta de usuario cada vez que se le asigne un nuevo rol, garantizando que el estado de acceso refleje de forma inmediata los cambios de autorización.

---

## 6. Dominios involucrados
### SECURITY
**Entidades:** `user_account`, `user_status`, `security_role`, `security_permission`, `user_role`, `role_permission`  
**Propósito en este ejercicio:** gestionar acceso al sistema, estados de usuario, roles y permisos asociados.

### IDENTITY
**Entidades:** `person`  
**Propósito en este ejercicio:** relacionar la cuenta de usuario con la persona real del sistema.

---

## 7. Problema a resolver
La organización necesita consultar el mapa de autorización de los usuarios y automatizar la activación de la cuenta cuando se registra una nueva asignación de rol, asegurando coherencia entre el estado de la cuenta y sus privilegios de acceso.

El modelo ya posee las tablas necesarias para almacenar roles, permisos y estados. Sin embargo, si la activación de la cuenta se gestiona manualmente, el flujo queda expuesto a situaciones donde un usuario tiene rol asignado pero sigue con estado inactivo.

Por eso se plantea una solución en tres capas:
1. una consulta consolidada con `INNER JOIN`,
2. un trigger `AFTER INSERT` sobre `user_role`,
3. un procedimiento almacenado que centralice la asignación del rol.

---

## 8. Solución propuesta

### 8.1 Consulta resuelta con `INNER JOIN`
Se eligió una consulta que conecta siete tablas reales del modelo. La consulta muestra el mapa completo de autorización: persona, cuenta, estado, rol asignado, fecha de asignación y permisos heredados.

```sql
SELECT
    p.first_name,
    p.last_name,
    ua.username,
    us.status_name              AS estado_usuario,
    sr.role_name                AS rol_asignado,
    ur.assigned_at              AS fecha_asignacion,
    sp.permission_name          AS permiso_asociado
FROM person p
INNER JOIN user_account ua
    ON ua.person_id = p.person_id
INNER JOIN user_status us
    ON us.user_status_id = ua.user_status_id
INNER JOIN user_role ur
    ON ur.user_account_id = ua.user_account_id
INNER JOIN security_role sr
    ON sr.security_role_id = ur.security_role_id
INNER JOIN role_permission rp
    ON rp.security_role_id = sr.security_role_id
INNER JOIN security_permission sp
    ON sp.security_permission_id = rp.security_permission_id
ORDER BY p.last_name, p.first_name, sr.role_name, sp.permission_name;
```

### 8.2 Explicación paso a paso de la consulta
1. **`person`** aporta la identidad real del usuario del sistema.
2. **`user_account`** representa la cuenta de acceso vinculada a esa persona.
3. **`user_status`** expone el estado actual de la cuenta de usuario.
4. **`user_role`** registra la asignación del rol a la cuenta con su fecha.
5. **`security_role`** describe el rol con nombre y propósito.
6. **`role_permission`** conecta cada rol con los permisos que hereda.
7. **`security_permission`** describe cada permiso disponible en el sistema.

La solución usa `INNER JOIN` porque el objetivo es listar únicamente usuarios con roles asignados y permisos completamente configurados en el sistema.

---

## 9. Trigger resuelto

### 9.1 Decisión técnica
Se tomó un trigger `AFTER INSERT ON user_role` porque la activación de la cuenta debe ocurrir después de que la asignación del rol ya esté persistida. El modelo lo soporta mediante `user_account.user_status_id`, que referencia a `user_status` y controla el estado de acceso de cada cuenta.

### 9.2 Lógica implementada
- Busca el `user_status_id` cuyo `status_code` corresponda a `active`.
- Si existe, actualiza `user_account.user_status_id` con ese estado para la cuenta que recibió el rol.
- Si no existe el estado activo en el catálogo, retorna sin ejecutar ninguna acción adicional.

### 9.3 Script del trigger

```sql
DROP TRIGGER IF EXISTS trg_ai_user_role_activate_user_account ON user_role;
DROP FUNCTION IF EXISTS fn_ai_user_role_activate_user_account();

CREATE OR REPLACE FUNCTION fn_ai_user_role_activate_user_account()
RETURNS trigger
LANGUAGE plpgsql
AS $$
DECLARE
    v_active_status_id   uuid;
BEGIN
    SELECT us.user_status_id
    INTO v_active_status_id
    FROM user_status us
    WHERE lower(us.status_code) IN ('active', 'activo', 'enabled')
    ORDER BY us.created_at
    LIMIT 1;

    IF v_active_status_id IS NULL THEN
        RETURN NEW;
    END IF;

    UPDATE user_account
    SET user_status_id = v_active_status_id
    WHERE user_account_id = NEW.user_account_id;

    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_ai_user_role_activate_user_account
AFTER INSERT ON user_role
FOR EACH ROW
EXECUTE FUNCTION fn_ai_user_role_activate_user_account();
```

### 9.4 Por qué esta solución es correcta
- No cambia ninguna tabla del modelo.
- Usa la relación real entre `user_role` y `user_account` a través de `user_account_id`.
- Actualiza únicamente `user_status_id`, que es el campo estándar de estado de la cuenta.
- Automatiza el efecto que naturalmente debe ocurrir cuando un usuario recibe su primer rol o un rol adicional en el sistema.

---

## 10. Procedimiento almacenado resuelto

### 10.1 Objetivo
Centralizar la asignación de un rol a un usuario para garantizar que la cuenta y el rol existan, y que la combinación no esté duplicada antes de persistir la asignación, dejando al trigger la responsabilidad de activar la cuenta.

### 10.2 Decisión técnica
El procedimiento valida tres condiciones antes de insertar: que la cuenta de usuario exista, que el rol exista y que esa combinación cuenta-rol no esté ya registrada. Esto protege la unicidad de la asignación sin modificar ninguna restricción del modelo base.

### 10.3 Script del procedimiento

```sql
CREATE OR REPLACE PROCEDURE sp_assign_user_role(
    p_user_account_id    uuid,
    p_security_role_id   uuid,
    p_assigned_by        uuid,
    p_assigned_at        timestamptz
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM user_account ua
        WHERE ua.user_account_id = p_user_account_id
    ) THEN
        RAISE EXCEPTION 'No existe una cuenta de usuario con user_account_id %', p_user_account_id;
    END IF;

    IF NOT EXISTS (
        SELECT 1
        FROM security_role sr
        WHERE sr.security_role_id = p_security_role_id
    ) THEN
        RAISE EXCEPTION 'No existe un rol con security_role_id %', p_security_role_id;
    END IF;

    IF EXISTS (
        SELECT 1
        FROM user_role ur
        WHERE ur.user_account_id = p_user_account_id
          AND ur.security_role_id = p_security_role_id
    ) THEN
        RAISE EXCEPTION 'El usuario % ya tiene asignado el rol %', p_user_account_id, p_security_role_id;
    END IF;

    INSERT INTO user_role (
        user_account_id,
        security_role_id,
        assigned_by,
        assigned_at
    )
    VALUES (
        p_user_account_id,
        p_security_role_id,
        p_assigned_by,
        p_assigned_at
    );
END;
$$;
```

### 10.4 Por qué esta solución es correcta
- Encapsula la asignación del rol con triple validación.
- Evita cuentas inexistentes, roles inexistentes y duplicados de asignación.
- Deja que el trigger active automáticamente la cuenta en `user_account`.
- Se alinea con el flujo real del negocio: primero se asigna el rol, luego el sistema garantiza que la cuenta quede habilitada para operar.

---

## 11. Script de demostración del funcionamiento

```sql
DO $$
DECLARE
    v_user_account_id    uuid;
    v_security_role_id   uuid;
    v_assigned_by        uuid;
    v_assigned_at        timestamptz := now();
BEGIN
    SELECT ua.user_account_id
    INTO v_user_account_id
    FROM user_account ua
    LEFT JOIN user_role ur
        ON ur.user_account_id = ua.user_account_id
    WHERE ur.user_role_id IS NULL
    ORDER BY ua.created_at
    LIMIT 1;

    IF v_user_account_id IS NULL THEN
        SELECT ua.user_account_id
        INTO v_user_account_id
        FROM user_account ua
        ORDER BY ua.created_at
        LIMIT 1;
    END IF;

    SELECT sr.security_role_id
    INTO v_security_role_id
    FROM security_role sr
    WHERE NOT EXISTS (
        SELECT 1
        FROM user_role ur
        WHERE ur.user_account_id = v_user_account_id
          AND ur.security_role_id = sr.security_role_id
    )
    ORDER BY sr.created_at
    LIMIT 1;

    SELECT ua2.user_account_id
    INTO v_assigned_by
    FROM user_account ua2
    WHERE ua2.user_account_id != v_user_account_id
    ORDER BY ua2.created_at
    LIMIT 1;

    IF v_user_account_id IS NULL THEN
        RAISE EXCEPTION 'No existe ninguna cuenta de usuario disponible en el sistema.';
    END IF;

    IF v_security_role_id IS NULL THEN
        RAISE EXCEPTION 'No existe ningún rol disponible para asignar a esta cuenta.';
    END IF;

    CALL sp_assign_user_role(
        v_user_account_id,
        v_security_role_id,
        v_assigned_by,
        v_assigned_at
    );
END;
$$;

SELECT
    ua.user_account_id,
    ua.username,
    us.status_name              AS estado_cuenta_actualizado,
    sr.role_name                AS rol_asignado,
    ur.assigned_at,
    ur.assigned_by
FROM user_role ur
INNER JOIN user_account ua
    ON ua.user_account_id = ur.user_account_id
INNER JOIN user_status us
    ON us.user_status_id = ua.user_status_id
INNER JOIN security_role sr
    ON sr.security_role_id = ur.security_role_id
ORDER BY ur.assigned_at DESC
LIMIT 5;
```

### 11.1 Qué demuestra este script
1. Busca preferentemente una cuenta sin ningún rol asignado usando `LEFT JOIN ... WHERE IS NULL`.
2. Si todas tienen rol, toma la primera cuenta disponible como fallback.
3. Selecciona el primer rol que aún no esté asignado a esa cuenta usando subconsulta `NOT EXISTS`.
4. Obtiene un segundo usuario distinto como responsable de la asignación (`assigned_by`).
5. Valida que tanto la cuenta como el rol disponible existan antes de proceder.
6. Ejecuta el procedimiento almacenado `sp_assign_user_role`.
7. El procedimiento inserta en `user_role`.
8. El trigger `trg_ai_user_role_activate_user_account` busca el estado `active` y actualiza `user_account.user_status_id`.
9. La consulta final valida que el rol fue asignado y que el `status_name` de la cuenta refleja el estado activo.

---

## 12. Validación final
La solución es válida porque:
- la consulta usa `INNER JOIN` en más de 5 tablas reales del modelo, cubriendo la cadena completa de autorización,
- el trigger es `AFTER INSERT` y produce un efecto verificable sobre `user_account.user_status_id`,
- el procedimiento almacenado es reutilizable y encapsula la asignación con triple validación,
- la demostración prueba la ejecución completa del flujo de seguridad y acceso,
- no se alteró ningún atributo, tabla ni relación del modelo base.

---

## 13. Archivos SQL relacionados
- `scripts_sql/ejercicio_08_setup.sql`
- `scripts_sql/ejercicio_08_demo.sql`