DO $$
DECLARE
    v_flight_segment_id      uuid;
    v_delay_reason_type_id   uuid;
    v_reported_at            timestamptz := now();
    v_delay_minutes          integer := 45;
    v_notes                  varchar := 'Demora por condiciones meteorológicas adversas en aeropuerto de origen';
BEGIN
    -- Buscar un segmento de vuelo sin demora registrada
    SELECT fs.flight_segment_id
    INTO v_flight_segment_id
    FROM flight_segment fs
    LEFT JOIN flight_delay fd
        ON fd.flight_segment_id = fs.flight_segment_id
    WHERE fd.flight_delay_id IS NULL
    ORDER BY fs.created_at
    LIMIT 1;

    -- Si todos tienen demora, tomar cualquier segmento disponible
    IF v_flight_segment_id IS NULL THEN
        SELECT fs.flight_segment_id
        INTO v_flight_segment_id
        FROM flight_segment fs
        ORDER BY fs.created_at
        LIMIT 1;
    END IF;

    -- Obtener el primer motivo de retraso disponible
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

    -- Invocar el procedimiento de registro de demora
    CALL sp_register_flight_delay(
        v_flight_segment_id,
        v_delay_reason_type_id,
        v_reported_at,
        v_delay_minutes,
        v_notes
    );
END;
$$;

-- Validación: verificar la demora registrada y el estado del vuelo actualizado por el trigger
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