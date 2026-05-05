-- ============================================================
-- ejercicio_10_setup.sql
-- Ejercicio 10 - Identidad de pasajeros, documentos y contactos
-- Dominios: IDENTITY, CUSTOMER, SALES/TICKETING
-- ============================================================

-- REQUERIMIENTO 2: Función y Trigger AFTER INSERT sobre person_document
-- Al registrar un nuevo documento, emite RAISE NOTICE con el total
-- de documentos que tiene esa persona registrados en el sistema

CREATE OR REPLACE FUNCTION fn_log_nuevo_documento()
RETURNS TRIGGER AS $$
DECLARE
    v_nombre        varchar(200);
    v_total_docs    integer;
    v_tipo_doc      varchar(80);
BEGIN
    SELECT first_name || ' ' || last_name INTO v_nombre
    FROM person WHERE person_id = NEW.person_id;

    SELECT type_name INTO v_tipo_doc
    FROM document_type WHERE document_type_id = NEW.document_type_id;

    SELECT count(*) INTO v_total_docs
    FROM person_document WHERE person_id = NEW.person_id;

    RAISE NOTICE 'Persona [%] — nuevo documento registrado: [% - %]. Total documentos: %',
        v_nombre, v_tipo_doc, NEW.document_number, v_total_docs;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_after_person_document_log ON person_document;
CREATE TRIGGER trg_after_person_document_log
    AFTER INSERT ON person_document
    FOR EACH ROW
    EXECUTE FUNCTION fn_log_nuevo_documento();


-- REQUERIMIENTO 3: Procedimiento almacenado para registrar documento de persona

CREATE OR REPLACE PROCEDURE sp_registrar_documento_persona(
    p_person_id         uuid,
    p_document_type_id  uuid,
    p_issuing_country_id uuid,
    p_document_number   varchar(64),
    p_issued_on         date,
    p_expires_on        date
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM person WHERE person_id = p_person_id) THEN
        RAISE EXCEPTION 'Persona no encontrada: %', p_person_id;
    END IF;

    IF NOT EXISTS (SELECT 1 FROM document_type WHERE document_type_id = p_document_type_id) THEN
        RAISE EXCEPTION 'Tipo de documento no encontrado: %', p_document_type_id;
    END IF;

    INSERT INTO person_document (
        person_document_id,
        person_id,
        document_type_id,
        issuing_country_id,
        document_number,
        issued_on,
        expires_on,
        created_at,
        updated_at
    ) VALUES (
        gen_random_uuid(),
        p_person_id,
        p_document_type_id,
        p_issuing_country_id,
        p_document_number,
        p_issued_on,
        p_expires_on,
        now(), now()
    );

    RAISE NOTICE 'Documento [%] registrado para persona %', p_document_number, p_person_id;
END;
$$;
