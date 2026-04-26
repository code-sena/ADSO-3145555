-- ============================================================
-- ejercicio_06_setup.sql
-- Ejercicio 06 - Retrasos operativos y análisis de impacto por segmento
-- Dominios: FLIGHT OPERATIONS, AIRPORT, AIRLINE
-- ============================================================

-- REQUERIMIENTO 2: Función y Trigger AFTER INSERT sobre flight_delay
-- Al registrar una demora, muestra el acumulado de minutos de retraso
-- para ese segmento de vuelo (efecto verificable con RAISE NOTICE)

CREATE OR REPLACE FUNCTION fn_log_retraso_segmento()
RETURNS TRIGGER AS $$
DECLARE
    v_total_minutos integer;
    v_flight_number varchar(12);
BEGIN
    SELECT f.flight_number INTO v_flight_number
    FROM flight_segment fs
        INNER JOIN flight f ON f.flight_id = fs.flight_id
    WHERE fs.flight_segment_id = NEW.flight_segment_id;

    SELECT sum(delay_minutes) INTO v_total_minutos
    FROM flight_delay
    WHERE flight_segment_id = NEW.flight_segment_id;

    RAISE NOTICE 'Vuelo [%] segmento [%] — nueva demora: % min. Total acumulado: % min',
        v_flight_number, NEW.flight_segment_id, NEW.delay_minutes, v_total_minutos;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_after_flight_delay_log ON flight_delay;
CREATE TRIGGER trg_after_flight_delay_log
    AFTER INSERT ON flight_delay
    FOR EACH ROW
    EXECUTE FUNCTION fn_log_retraso_segmento();


-- REQUERIMIENTO 3: Procedimiento almacenado para registrar demora de vuelo

CREATE OR REPLACE PROCEDURE sp_registrar_demora(
    p_flight_segment_id     uuid,
    p_delay_reason_type_id  uuid,
    p_delay_minutes         integer,
    p_notes                 text
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM flight_segment WHERE flight_segment_id = p_flight_segment_id) THEN
        RAISE EXCEPTION 'Segmento de vuelo no encontrado: %', p_flight_segment_id;
    END IF;

    IF NOT EXISTS (SELECT 1 FROM delay_reason_type WHERE delay_reason_type_id = p_delay_reason_type_id) THEN
        RAISE EXCEPTION 'Motivo de retraso no encontrado: %', p_delay_reason_type_id;
    END IF;

    INSERT INTO flight_delay (
        flight_delay_id,
        flight_segment_id,
        delay_reason_type_id,
        reported_at,
        delay_minutes,
        notes,
        created_at,
        updated_at
    ) VALUES (
        gen_random_uuid(),
        p_flight_segment_id,
        p_delay_reason_type_id,
        now(),
        p_delay_minutes,
        p_notes,
        now(), now()
    );

    RAISE NOTICE 'Demora de % minutos registrada para segmento %', p_delay_minutes, p_flight_segment_id;
END;
$$;
