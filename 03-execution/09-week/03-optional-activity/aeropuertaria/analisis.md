# Análisis de la base de datos

## Error encontrado
- `flight_segment.ck_flight_segment_actuals` tenía un cierre incorrecto del `CHECK`, lo que impedía ejecutar el script completo.

## Posibles mejoras aplicadas
- Validación de fecha de nacimiento no futura en `person`.
- Validación de texto no vacío en contacto, vuelo, reserva y referencia de pago.
- Homologación de códigos IATA/ICAO a mayúsculas en `airline` y `airport`.
- Índices adicionales para consultas operativas frecuentes.

## Observaciones de diseño
- El modelo está bastante bien separado por dominios.
- Hay buen uso de claves sustitutas UUID, restricciones `UNIQUE` y `CHECK`.
- En varios catálogos y entidades transaccionales se usa `created_at` y `updated_at`, pero falta automatizar el mantenimiento de `updated_at`.
- Algunas reglas de negocio siguen en texto/códigos simples; podrían migrarse a tablas catálogo en una siguiente versión.

## Archivos entregados
- SQL original copiado para referencia.
- SQL actualizado con correcciones y mejoras.
- ADR con decisiones arquitectónicas tomadas.
