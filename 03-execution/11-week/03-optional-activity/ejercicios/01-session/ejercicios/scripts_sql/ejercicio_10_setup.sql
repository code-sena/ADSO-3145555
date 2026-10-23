-- =====================================================
-- EJERCICIO 10 - SETUP
-- Identidad de pasajeros, documentos y medios de contacto
-- =====================================================

DROP TRIGGER IF EXISTS trg_au_person_contact_primary ON person_contact;
DROP FUNCTION IF EXISTS fn_au_person_contact_primary();
DROP PROCEDURE IF EXISTS sp_register_person_document(uuid, uuid, uuid, varchar, date, date);
DROP PROCEDURE IF EXISTS sp_register_person_contact(uuid, uuid, varchar, boolean);

CREATE OR REPLACE FUNCTION fn_au_person_contact_primary()
RETURNS trigger
LANGUAGE plpgsql
AS $$
BEGIN
    IF NEW.is_primary = true AND (OLD.is_primary = false OR OLD.is_primary IS NULL) THEN
        UPDATE person_contact SET is_primary = false, updated_at = NOW()
        WHERE person_id = NEW.person_id
        AND contact_type_id = NEW.contact_type_id
        AND person_contact_id != NEW.person_contact_id
        AND is_primary = true;
    END IF;
    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_au_person_contact_primary
AFTER UPDATE ON person_contact
FOR EACH ROW
EXECUTE FUNCTION fn_au_person_contact_primary();

CREATE OR REPLACE PROCEDURE sp_register_person_document(
    p_person_id uuid,
    p_document_type_id uuid,
    p_issuing_country_id uuid,
    p_document_number varchar,
    p_issued_on date DEFAULT NULL,
    p_expires_on date DEFAULT NULL
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO person_document (person_id, document_type_id, issuing_country_id, document_number, issued_on, expires_on)
    VALUES (p_person_id, p_document_type_id, p_issuing_country_id, p_document_number, p_issued_on, p_expires_on);
END;
$$;

CREATE OR REPLACE PROCEDURE sp_register_person_contact(
    p_person_id uuid,
    p_contact_type_id uuid,
    p_contact_value varchar,
    p_is_primary boolean DEFAULT false
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF p_is_primary = true THEN
        UPDATE person_contact SET is_primary = false, updated_at = NOW()
        WHERE person_id = p_person_id AND contact_type_id = p_contact_type_id AND is_primary = true;
    END IF;
    
    INSERT INTO person_contact (person_id, contact_type_id, contact_value, is_primary)
    VALUES (p_person_id, p_contact_type_id, p_contact_value, p_is_primary);
END;
$$;

-- CONSULTA INNER JOIN
SELECT p.first_name, p.last_name, dt.type_code, pd.document_number, ct.type_code, pc.contact_value
FROM person p
LEFT JOIN person_document pd ON pd.person_id = p.person_id
LEFT JOIN document_type dt ON dt.document_type_id = pd.document_type_id
LEFT JOIN person_contact pc ON pc.person_id = p.person_id
LEFT JOIN contact_type ct ON ct.contact_type_id = pc.contact_type_id;