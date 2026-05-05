# Análisis de Dominios Funcionales del Modelo de Datos

## Resumen Ejecutivo
El script `modelo_postgresql.sql` presenta una arquitectura de datos madura organizada en **6 dominios funcionales principales**, con claves UUID, auditoría completa y restricciones de integridad bien definidas.

## Dominios Identificados

| # | Dominio | Esquema | Tablas | Propósito |
|---|---------|---------|--------|-----------|
| 1 | **Geografía y Referencias** | `geo` | 8 | Ubicaciones físicas, direcciones, monedas, husos horarios |
| 2 | **Identidad y Seguridad** | `identity_security` | 12 | Personas, documentos, usuarios, roles, permisos |
| 3 | **Operaciones y Activos** | `operations_assets` | 15 | Aeronaves, aeropuertos, mantenimiento, infraestructura |
| 4 | **Lealtad y Clientes** | `loyalty` | 9 | Clientes frecuentes, millas, beneficios |
| 5 | **Operaciones de Vuelo** | `flight_ops` | 5 | Vuelos, segmentos, estados, retrasos |
| 6 | **Ventas y Facturación** | `sales_billing` | 27 | Reservas, ticketing, pagos, facturación, embarque |

## Mapa de Dependencias entre Dominios
