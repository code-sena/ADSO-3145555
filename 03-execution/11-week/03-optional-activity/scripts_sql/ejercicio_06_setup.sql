DROP TRIGGER IF EXISTS trg_ai_flight_delay_update_flight_status ON flight_delay;
DROP FUNCTION IF EXISTS fn_ai_flight_delay_update_flight_status();
DROP PROCEDURE IF EXISTS sp_register_flight_delay(uuid, uuid, timestamptz, integer, varchar);

CREATE OR REPLACE FUNCTION fn_ai_flight_delay_update_flight_status()
RETURNS trigger
LANGUAGE plpgsql
AS $$
DECLARE
    v_delayed_status_id   uuid;
    v_flight_id           uuid;
BEGIN
    -- Obtener el flight_id a partir del flight_segment impactado
    SELECT fs.flight_id
    INTO v_flight_id
    FROM flight_segment fs
    WHERE fs.flight_segment_id = NEW.flight_segment_id;

    -- Buscar el flight_status correspondiente a 'delayed'
    SELECT fst.flight_status_id
    INTO v_delayed_status_id
    FROM flight_status fst
    WHERE lower(fst.status_code) IN ('delayed', 'delay', 'demorado')
    ORDER BY fst.created_at
    LIMIT 1;

    IF v_flight_id IS NULL OR v_delayed_status_id IS NULL THEN
        RETURN NEW;
    END IF;

    -- Actualizar el estado del vuelo a 'delayed'
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

-- Consulta resuelta: trazabilidad operativa aerolínea-vuelo-estado-segmento-aeropuertos-demora-motivo
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