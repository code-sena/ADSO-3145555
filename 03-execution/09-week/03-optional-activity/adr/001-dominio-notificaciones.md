# ADR-001: Incorporación de dominio de notificaciones

## Contexto
El sistema actual no contempla mecanismos de comunicación con el usuario.

## Problema
No existe forma de notificar eventos como confirmación de reservas o cambios de vuelo.

## Decisión
Se implementará un nuevo dominio llamado "Notificaciones".

## Justificación técnica
Permite desacoplar la comunicación del resto del sistema y facilita escalabilidad.

## Consecuencias
+ Mejora experiencia de usuario
+ Permite integración futura con email/SMS
- Aumenta complejidad del modelo