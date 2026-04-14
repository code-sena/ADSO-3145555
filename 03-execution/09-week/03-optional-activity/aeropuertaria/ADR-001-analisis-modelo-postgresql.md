# ADR-001 - Correcciones y mejoras del modelo PostgreSQL

## Estado
Aceptado

## Contexto
Se revisó el archivo `modelo_postgresql-1.sql` de un sistema aeronáutico con módulos de identidad, seguridad, clientes, aeropuertos, aeronaves, vuelos, reservas, pagos y facturación.

## Hallazgos
- Se detectó un error de sintaxis en `flight_segment`: el `CHECK` `ck_flight_segment_actuals` no cerraba correctamente el paréntesis antes del cierre de la tabla.
- El modelo estaba bien normalizado en términos generales, pero tenía oportunidades de mejora en validaciones de datos, consistencia semántica e indexación para consultas frecuentes.
- Varias columnas tipo código o identificador admitían cadenas vacías o valores con formato inconsistente.

## Decisiones tomadas
1. Corregir el error de sintaxis del `CHECK` en `flight_segment`.
2. Agregar validaciones para evitar datos vacíos en campos críticos como `flight.flight_number`, `reservation.reservation_code`, `payment.payment_reference` y `person_contact.contact_value`.
3. Agregar validación para impedir fechas de nacimiento futuras en `person.birth_date`.
4. Forzar consistencia en mayúsculas para códigos IATA/ICAO en `airline` y `airport`.
5. Añadir índices complementarios orientados a búsqueda operativa y trazabilidad (`flight`, `reservation`, `ticket`).

## Impacto
- El script actualizado ya no presenta el error de sintaxis detectado.
- Se mejora la calidad de los datos al reducir registros inválidos o inconsistentes.
- Se mejora el rendimiento esperado en búsquedas frecuentes por fecha, aerolínea, código de reserva y número de ticket.
- Los cambios son compatibles con la estructura existente y no rompen la lógica general del modelo.

## Mejoras futuras recomendadas
- Añadir triggers para mantener `updated_at` automáticamente.
- Evaluar catálogos para columnas con códigos de estado actualmente modeladas como `varchar` con `CHECK`.
- Agregar políticas de borrado (`ON DELETE`) explícitas según reglas del negocio.
- Crear pruebas de integridad con inserciones válidas e inválidas.
- Considerar dominios PostgreSQL para emails, códigos IATA/ICAO y referencias de negocio.
