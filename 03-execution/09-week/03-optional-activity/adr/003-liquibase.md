# ADR-003: Implementación de Liquibase

## Contexto
El modelo actual está en un script monolítico.

## Problema
No hay versionamiento ni control de cambios.

## Decisión
Se implementará Liquibase con changelogs por dominio.

## Justificación técnica
Permite control de versiones del esquema y despliegues controlados.

## Consecuencias
+ Versionamiento del DDL
+ Trazabilidad
- Curva de aprendizaje