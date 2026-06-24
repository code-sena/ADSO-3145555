-- ============================================================
-- ejercicio_10_demo.sql
-- Ejercicio 10 - Script de demostración y validación
-- ============================================================

-- REQUERIMIENTO 1: Consulta INNER JOIN mínimo 5 tablas
-- Flujo: person > person_type > person_document > document_type >
--        person_contact > contact_type > reservation_passenger > reservation

SELECT
    p.first_name || ' ' || p.last_name      AS persona,
    pt.type_name                             AS tipo_persona,
    dt.type_name                             AS tipo_documento,
    pd.document_number                       AS numero_documento,
    ct.type_name                             AS tipo_contacto,
    pc.contact_value                         AS valor_contacto,
    r.reservation_code                       AS reserva_relacionada,
    rp.passenger_sequence_no                 AS secuencia_pasajero
FROM person p
    INNER JOIN person_type pt           ON pt.person_type_id        = p.person_type_id
    INNER JOIN person_document pd       ON pd.person_id             = p.person_id
    INNER JOIN document_type dt         ON dt.document_type_id      = pd.document_type_id
    INNER JOIN person_contact pc        ON pc.person_id             = p.person_id
    INNER JOIN contact_type ct          ON ct.contact_type_id       = pc.contact_type_id
    INNER JOIN reservation_passenger rp ON rp.person_id             = p.person_id
    INNER JOIN reservation r            ON r.reservation_id         = rp.reservation_id
ORDER BY p.last_name, p.first_name;


-- DEMOSTRACIÓN DEL TRIGGER Y PROCEDIMIENTO

-- Paso 1: Ver personas y tipos de documento disponibles
SELECT p.person_id, p.first_name || ' ' || p.last_name AS nombre
FROM person p LIMIT 5;

SELECT document_type_id, type_code, type_name FROM document_type LIMIT 5;

SELECT country_id, iso_alpha2, country_name FROM country WHERE iso_alpha2 IN ('CO','US','MX') LIMIT 5;

-- Paso 2: Invocar el procedimiento
-- (Reemplaza los UUIDs con los valores reales obtenidos arriba)
CALL sp_registrar_documento_persona(
    '00000000-0000-0000-0000-000000000001',  -- reemplazar: person_id real
    '00000000-0000-0000-0000-000000000002',  -- reemplazar: document_type_id real
    '00000000-0000-0000-0000-000000000003',  -- reemplazar: country_id real (o NULL)
    'CC-987654321',
    '2020-01-15',
    '2030-01-15'
);

-- Paso 3: Validar que el documento quedó registrado y el trigger se ejecutó
SELECT
    p.first_name || ' ' || p.last_name  AS persona,
    dt.type_name                         AS tipo_documento,
    pd.document_number,
    pd.issued_on,
    pd.expires_on,
    pd.created_at
FROM person_document pd
    INNER JOIN person p         ON p.person_id          = pd.person_id
    INNER JOIN document_type dt ON dt.document_type_id  = pd.document_type_id
ORDER BY pd.created_at DESC
LIMIT 10;
