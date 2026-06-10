-- =====================================================
-- EJERCICIO 10 - DEMO
-- =====================================================

DO $$
DECLARE
    v_person_id uuid;
    v_person_type_id uuid;
    v_document_type_id uuid;
    v_contact_type_id uuid;
    v_country_id uuid;
BEGIN
    SELECT person_type_id INTO v_person_type_id FROM person_type WHERE type_code = 'NATURAL' LIMIT 1;
    SELECT document_type_id INTO v_document_type_id FROM document_type WHERE type_code = 'CC' LIMIT 1;
    SELECT contact_type_id INTO v_contact_type_id FROM contact_type WHERE type_code = 'EMAIL' LIMIT 1;
    SELECT country_id INTO v_country_id FROM country WHERE iso_alpha2 = 'CO' LIMIT 1;
    
    INSERT INTO person (person_type_id, nationality_country_id, first_name, last_name)
    VALUES (v_person_type_id, v_country_id, 'PRUEBA', 'DEMO')
    RETURNING person_id INTO v_person_id;
    
    CALL sp_register_person_document(v_person_id, v_document_type_id, v_country_id, '1234567890', '2000-01-01', '2030-01-01');
    CALL sp_register_person_contact(v_person_id, v_contact_type_id, 'prueba@aerolinea.com', true);
END;
$$;

SELECT p.first_name, pd.document_number, pc.contact_value
FROM person p
LEFT JOIN person_document pd ON pd.person_id = p.person_id
LEFT JOIN person_contact pc ON pc.person_id = p.person_id
ORDER BY p.created_at DESC LIMIT 5;