DO $$
DECLARE
    v_person_id          uuid;
    v_document_type_id   uuid;
    v_issuing_country_id uuid;
    v_document_number    varchar := 'TEST-DOC-' || to_char(now(), 'HH24MISS');
BEGIN
    -- Obtener la primera persona disponible
    SELECT p.person_id
    INTO v_person_id
    FROM person p
    ORDER BY p.created_at
    LIMIT 1;

    -- Obtener el primer tipo de documento disponible
    SELECT dt.document_type_id
    INTO v_document_type_id
    FROM document_type dt
    ORDER BY dt.created_at
    LIMIT 1;

    -- Obtener el primer país disponible como país emisor
    SELECT c.country_id
    INTO v_issuing_country_id
    FROM country c
    ORDER BY c.created_at
    LIMIT 1;

    -- Validaciones previas
    IF v_person_id IS NULL THEN
        RAISE EXCEPTION 'No existe persona disponible.';
    END IF;

    IF v_document_type_id IS NULL THEN
        RAISE EXCEPTION 'No existe tipo de documento disponible.';
    END IF;

    IF v_issuing_country_id IS NULL THEN
        RAISE EXCEPTION 'No existe país disponible como emisor.';
    END IF;

    -- Invocar el procedimiento de registro de documento
    CALL sp_register_person_document(
        v_person_id,
        v_document_type_id,
        v_document_number,
        current_date - interval '5 years',
        current_date + interval '5 years',
        v_issuing_country_id
    );
END;
$$;

SELECT
    p.first_name,
    p.last_name,
    dt.document_type_name,
    pd.document_number,
    pd.issue_date,
    pd.expiration_date
FROM person_document pd
INNER JOIN person p
    ON p.person_id = pd.person_id
INNER JOIN document_type dt
    ON dt.document_type_id = pd.document_type_id
ORDER BY pd.created_at DESC
LIMIT 5;


SELECT
    pc.person_contact_id,
    p.first_name,
    p.last_name,
    ct.contact_type_name,
    pc.contact_value,
    pc.created_at
FROM person_contact pc
INNER JOIN person p
    ON p.person_id = pc.person_id
INNER JOIN contact_type ct
    ON ct.contact_type_id = pc.contact_type_id
WHERE pc.contact_value LIKE 'DOC-AUDIT:%'
ORDER BY pc.created_at DESC
LIMIT 5;