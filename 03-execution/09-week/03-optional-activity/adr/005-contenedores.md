# ADR-005: Uso de contenedores Docker

## Contexto
Se necesita portabilidad del entorno.

## Problema
Dependencia de configuraciones locales.

## Decisión
Se implementará Docker para PostgreSQL y Liquibase.

## Justificación técnica
Permite reproducibilidad y despliegue rápido.

## Consecuencias
+ Entorno consistente
+ Fácil despliegue
- Requiere conocimiento en Docker