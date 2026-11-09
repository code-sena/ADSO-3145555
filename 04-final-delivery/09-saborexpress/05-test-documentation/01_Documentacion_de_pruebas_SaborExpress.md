# Plan de pruebas, evidencias y aceptación

**Proyecto:** SaborExpress | **Autor / integrante:** Yerson Stiven Cuellar Rubiano | **Ficha:** 3145555 | **Fecha:** 14 de octubre de 2026 | **Versión documental:** 4.0

**Estado de la evidencia:** inspección documental y estática del código. Las pruebas de ejecución y los datos institucionales no aportados no se presumen realizados.

## 1. Principio de evidencia

**Estado general: NO EJECUTADO en esta elaboración.** Este documento diseña pruebas reproducibles; no hay actas, capturas de ejecución ni registros de CI entregados que permitan certificarlas como aprobadas. Se inspeccionaron rutas y código fuente, no se desplegó la aplicación ni se realizaron cobros.

## 2. Estrategia por niveles

Pruebas unitarias de servicios y validadores; integración con EF Core sobre base efímera; contrato API desde Swagger y Postman; E2E por rol; seguridad negativa de roles/recursos; sandbox de Wompi; carga de HTTP/SignalR; accesibilidad/usabilidad; restauración/recuperación; despliegue y smoke. Cada prueba debe registrar commit, ambiente, conjunto de datos sintéticos, ejecutor, fecha y resultado observado.

## 3. Casos críticos propuestos

| ID | Grupo | Datos/estímulo | Resultado esperado | Ejecución |
| --- | --- | --- | --- | --- |
| CP-01 | Auth válido | Credenciales de prueba válidas | Login exitoso, JWT válido | Pendiente |
| CP-02 | Auth inválido | Contraseña errónea | Respuesta controlada sin token | Pendiente |
| CP-03 | Token expirado | JWT fuera de vigencia | 401 | Pendiente |
| CP-04 | Token manipulado | Firma inválida | 401 | Pendiente |
| CP-05 | Acceso intersede | Admin de sede A consulta B | 403 o filtrado seguro | Pendiente |
| CP-06 | Producto público | GET catálogo sede | Solo productos de sede y globales | Pendiente |
| CP-07 | Crear producto sin rol | Cliente invoca POST | 403 | Pendiente |
| CP-08 | Crear pedido | Detalle consistente | 201 + total calculado | Pendiente |
| CP-09 | Pedido negativo | Cantidad <=0 | Rechazado sin persistencia | Pendiente |
| CP-10 | Pedido domicilio | Sin dirección | Regla de validación consistente | Pendiente |
| CP-11 | Cancelación propia | Cliente propietario, estado admisible | Cancelación controlada | Pendiente |
| CP-12 | Cancelación ajena | Cliente distinto | 403/404 seguro | Pendiente |
| CP-13 | Estado inválido | Transición de pedido prohibida | Conflicto controlado | Pendiente |
| CP-14 | Pago válido | Sandbox Wompi firma válida | Un pago reconciliado | Pendiente |
| CP-15 | Webhook adulterado | Checksum incorrecto | No se aplica pago | Pendiente |
| CP-16 | Webhook repetido | Mismo evento dos veces | Idempotencia | Pendiente |
| CP-17 | Pago rechazado | Sandbox REJECTED | No cambiar a pagado | Pendiente |
| CP-18 | QR cajero | Generar link desde turno válido | Referencia y valor correctos | Pendiente |
| CP-19 | Cierre de caja | Pagos del cajero actual | No mezcla de empleados | Pendiente |
| CP-20 | Entrega ajena | Repartidor A pide B | Acceso rechazado | Pendiente |
| CP-21 | Calificación | Cliente propietario de entrega | Guardar solo 1..5 | Pendiente |
| CP-22 | SignalR | Cliente autorizado suscrito | Evento recibido/reconexión | Pendiente |
| CP-23 | DB falla | Interrumpir motor | Sin corrupción ni secretos en error | Pendiente |
| CP-24 | Migración | BD efímera desde cero | Schema coherente | Pendiente |
| CP-25 | Rollback | Restaurar backup de prueba | Integridad post-restauración | Pendiente |
| CP-26 | Carga HTTP | Carga y duración declaradas | p50/p95 medidos | Pendiente |
| CP-27 | Usabilidad | Tareas por roles voluntarios | Tiempos, errores, SUS si aplica | Pendiente |

## 4. Ambiente y datos sintéticos

Preparar usuarios por cada rol y dos sedes ficticias, productos y pedidos conocidos, cuentas de sandbox, copia limpia de BD de test y timezone consistente. Guardar definición de pruebas sin claves ni información de clientes reales. Controlar estado inicial/final de cada caso para evitar contaminación entre pruebas.

## 5. Matriz de cobertura y formato de resultado

Criterio: 100% de requisitos de prioridad crítica con al menos un caso positivo y uno negativo; cobertura restante acordada por QA. Esta es una **meta**, no porcentaje actual. Plantilla de registro: `ID / SHA / versión / ambiente / datos / pasos / esperado / observado / evidencia / estado / responsable`.

## 6. Requisitos para declarar aceptación

No hay incidentes críticos abiertos, pagos conciliados de forma idempotente, segregación por sede verificada, backup/restore demostrado, documentación e instrucción de usuarios aprobadas y métricas no funcionales medidas contra umbrales acordados. No usar el presente documento para afirmar aprobación del instructor o QA.


## 8. Fichas de ejecución por caso de prueba

Los pasos detallados convierten el catálogo sintético en una guía reproducible. Cada caso debe ejecutarse en sandbox, registrar comparación esperado-observado y crear un defecto si no cumple.


### CP-01. Auth válido

**Objetivo y escenario:** Credenciales de prueba válidas. **Resultado esperado:** Login exitoso, JWT válido.

**Preparación:** anotar el SHA de los tres repositorios y URL sandbox; reservar base efímera con dos sedes ficticias, al menos tres roles y transacciones de prueba; obtener credenciales desde gestor local seguro.

**Ejecución:** 1) confirmar precondición e identidad; 2) capturar estado inicial; 3) ejecutar estímulo `Credenciales de prueba válidas` por interfaz/API con la autorización pertinente; 4) registrar respuesta HTTP, cambios BD e interfaz; 5) repetir ante escenario negativo o reintento; 6) comprobar `Login exitoso, JWT válido` y ausencia de efectos colaterales.

**Criterio de paso:** resultado coincide con contrato y queda evidencia fechada de petición/respuesta sanitizada, log y estado final. **Resultado real y defecto:** pendientes de ejecutar, no completados por esta documentación.


### CP-02. Auth inválido

**Objetivo y escenario:** Contraseña errónea. **Resultado esperado:** Respuesta controlada sin token.

**Preparación:** anotar el SHA de los tres repositorios y URL sandbox; reservar base efímera con dos sedes ficticias, al menos tres roles y transacciones de prueba; obtener credenciales desde gestor local seguro.

**Ejecución:** 1) confirmar precondición e identidad; 2) capturar estado inicial; 3) ejecutar estímulo `Contraseña errónea` por interfaz/API con la autorización pertinente; 4) registrar respuesta HTTP, cambios BD e interfaz; 5) repetir ante escenario negativo o reintento; 6) comprobar `Respuesta controlada sin token` y ausencia de efectos colaterales.

**Criterio de paso:** resultado coincide con contrato y queda evidencia fechada de petición/respuesta sanitizada, log y estado final. **Resultado real y defecto:** pendientes de ejecutar, no completados por esta documentación.


### CP-03. Token expirado

**Objetivo y escenario:** JWT fuera de vigencia. **Resultado esperado:** 401.

**Preparación:** anotar el SHA de los tres repositorios y URL sandbox; reservar base efímera con dos sedes ficticias, al menos tres roles y transacciones de prueba; obtener credenciales desde gestor local seguro.

**Ejecución:** 1) confirmar precondición e identidad; 2) capturar estado inicial; 3) ejecutar estímulo `JWT fuera de vigencia` por interfaz/API con la autorización pertinente; 4) registrar respuesta HTTP, cambios BD e interfaz; 5) repetir ante escenario negativo o reintento; 6) comprobar `401` y ausencia de efectos colaterales.

**Criterio de paso:** resultado coincide con contrato y queda evidencia fechada de petición/respuesta sanitizada, log y estado final. **Resultado real y defecto:** pendientes de ejecutar, no completados por esta documentación.


### CP-04. Token manipulado

**Objetivo y escenario:** Firma inválida. **Resultado esperado:** 401.

**Preparación:** anotar el SHA de los tres repositorios y URL sandbox; reservar base efímera con dos sedes ficticias, al menos tres roles y transacciones de prueba; obtener credenciales desde gestor local seguro.

**Ejecución:** 1) confirmar precondición e identidad; 2) capturar estado inicial; 3) ejecutar estímulo `Firma inválida` por interfaz/API con la autorización pertinente; 4) registrar respuesta HTTP, cambios BD e interfaz; 5) repetir ante escenario negativo o reintento; 6) comprobar `401` y ausencia de efectos colaterales.

**Criterio de paso:** resultado coincide con contrato y queda evidencia fechada de petición/respuesta sanitizada, log y estado final. **Resultado real y defecto:** pendientes de ejecutar, no completados por esta documentación.


### CP-05. Acceso intersede

**Objetivo y escenario:** Admin de sede A consulta B. **Resultado esperado:** 403 o filtrado seguro.

**Preparación:** anotar el SHA de los tres repositorios y URL sandbox; reservar base efímera con dos sedes ficticias, al menos tres roles y transacciones de prueba; obtener credenciales desde gestor local seguro.

**Ejecución:** 1) confirmar precondición e identidad; 2) capturar estado inicial; 3) ejecutar estímulo `Admin de sede A consulta B` por interfaz/API con la autorización pertinente; 4) registrar respuesta HTTP, cambios BD e interfaz; 5) repetir ante escenario negativo o reintento; 6) comprobar `403 o filtrado seguro` y ausencia de efectos colaterales.

**Criterio de paso:** resultado coincide con contrato y queda evidencia fechada de petición/respuesta sanitizada, log y estado final. **Resultado real y defecto:** pendientes de ejecutar, no completados por esta documentación.


### CP-06. Producto público

**Objetivo y escenario:** GET catálogo sede. **Resultado esperado:** Solo productos de sede y globales.

**Preparación:** anotar el SHA de los tres repositorios y URL sandbox; reservar base efímera con dos sedes ficticias, al menos tres roles y transacciones de prueba; obtener credenciales desde gestor local seguro.

**Ejecución:** 1) confirmar precondición e identidad; 2) capturar estado inicial; 3) ejecutar estímulo `GET catálogo sede` por interfaz/API con la autorización pertinente; 4) registrar respuesta HTTP, cambios BD e interfaz; 5) repetir ante escenario negativo o reintento; 6) comprobar `Solo productos de sede y globales` y ausencia de efectos colaterales.

**Criterio de paso:** resultado coincide con contrato y queda evidencia fechada de petición/respuesta sanitizada, log y estado final. **Resultado real y defecto:** pendientes de ejecutar, no completados por esta documentación.


### CP-07. Crear producto sin rol

**Objetivo y escenario:** Cliente invoca POST. **Resultado esperado:** 403.

**Preparación:** anotar el SHA de los tres repositorios y URL sandbox; reservar base efímera con dos sedes ficticias, al menos tres roles y transacciones de prueba; obtener credenciales desde gestor local seguro.

**Ejecución:** 1) confirmar precondición e identidad; 2) capturar estado inicial; 3) ejecutar estímulo `Cliente invoca POST` por interfaz/API con la autorización pertinente; 4) registrar respuesta HTTP, cambios BD e interfaz; 5) repetir ante escenario negativo o reintento; 6) comprobar `403` y ausencia de efectos colaterales.

**Criterio de paso:** resultado coincide con contrato y queda evidencia fechada de petición/respuesta sanitizada, log y estado final. **Resultado real y defecto:** pendientes de ejecutar, no completados por esta documentación.


### CP-08. Crear pedido

**Objetivo y escenario:** Detalle consistente. **Resultado esperado:** 201 + total calculado.

**Preparación:** anotar el SHA de los tres repositorios y URL sandbox; reservar base efímera con dos sedes ficticias, al menos tres roles y transacciones de prueba; obtener credenciales desde gestor local seguro.

**Ejecución:** 1) confirmar precondición e identidad; 2) capturar estado inicial; 3) ejecutar estímulo `Detalle consistente` por interfaz/API con la autorización pertinente; 4) registrar respuesta HTTP, cambios BD e interfaz; 5) repetir ante escenario negativo o reintento; 6) comprobar `201 + total calculado` y ausencia de efectos colaterales.

**Criterio de paso:** resultado coincide con contrato y queda evidencia fechada de petición/respuesta sanitizada, log y estado final. **Resultado real y defecto:** pendientes de ejecutar, no completados por esta documentación.


### CP-09. Pedido negativo

**Objetivo y escenario:** Cantidad <=0. **Resultado esperado:** Rechazado sin persistencia.

**Preparación:** anotar el SHA de los tres repositorios y URL sandbox; reservar base efímera con dos sedes ficticias, al menos tres roles y transacciones de prueba; obtener credenciales desde gestor local seguro.

**Ejecución:** 1) confirmar precondición e identidad; 2) capturar estado inicial; 3) ejecutar estímulo `Cantidad <=0` por interfaz/API con la autorización pertinente; 4) registrar respuesta HTTP, cambios BD e interfaz; 5) repetir ante escenario negativo o reintento; 6) comprobar `Rechazado sin persistencia` y ausencia de efectos colaterales.

**Criterio de paso:** resultado coincide con contrato y queda evidencia fechada de petición/respuesta sanitizada, log y estado final. **Resultado real y defecto:** pendientes de ejecutar, no completados por esta documentación.


### CP-10. Pedido domicilio

**Objetivo y escenario:** Sin dirección. **Resultado esperado:** Regla de validación consistente.

**Preparación:** anotar el SHA de los tres repositorios y URL sandbox; reservar base efímera con dos sedes ficticias, al menos tres roles y transacciones de prueba; obtener credenciales desde gestor local seguro.

**Ejecución:** 1) confirmar precondición e identidad; 2) capturar estado inicial; 3) ejecutar estímulo `Sin dirección` por interfaz/API con la autorización pertinente; 4) registrar respuesta HTTP, cambios BD e interfaz; 5) repetir ante escenario negativo o reintento; 6) comprobar `Regla de validación consistente` y ausencia de efectos colaterales.

**Criterio de paso:** resultado coincide con contrato y queda evidencia fechada de petición/respuesta sanitizada, log y estado final. **Resultado real y defecto:** pendientes de ejecutar, no completados por esta documentación.


### CP-11. Cancelación propia

**Objetivo y escenario:** Cliente propietario, estado admisible. **Resultado esperado:** Cancelación controlada.

**Preparación:** anotar el SHA de los tres repositorios y URL sandbox; reservar base efímera con dos sedes ficticias, al menos tres roles y transacciones de prueba; obtener credenciales desde gestor local seguro.

**Ejecución:** 1) confirmar precondición e identidad; 2) capturar estado inicial; 3) ejecutar estímulo `Cliente propietario, estado admisible` por interfaz/API con la autorización pertinente; 4) registrar respuesta HTTP, cambios BD e interfaz; 5) repetir ante escenario negativo o reintento; 6) comprobar `Cancelación controlada` y ausencia de efectos colaterales.

**Criterio de paso:** resultado coincide con contrato y queda evidencia fechada de petición/respuesta sanitizada, log y estado final. **Resultado real y defecto:** pendientes de ejecutar, no completados por esta documentación.


### CP-12. Cancelación ajena

**Objetivo y escenario:** Cliente distinto. **Resultado esperado:** 403/404 seguro.

**Preparación:** anotar el SHA de los tres repositorios y URL sandbox; reservar base efímera con dos sedes ficticias, al menos tres roles y transacciones de prueba; obtener credenciales desde gestor local seguro.

**Ejecución:** 1) confirmar precondición e identidad; 2) capturar estado inicial; 3) ejecutar estímulo `Cliente distinto` por interfaz/API con la autorización pertinente; 4) registrar respuesta HTTP, cambios BD e interfaz; 5) repetir ante escenario negativo o reintento; 6) comprobar `403/404 seguro` y ausencia de efectos colaterales.

**Criterio de paso:** resultado coincide con contrato y queda evidencia fechada de petición/respuesta sanitizada, log y estado final. **Resultado real y defecto:** pendientes de ejecutar, no completados por esta documentación.


### CP-13. Estado inválido

**Objetivo y escenario:** Transición de pedido prohibida. **Resultado esperado:** Conflicto controlado.

**Preparación:** anotar el SHA de los tres repositorios y URL sandbox; reservar base efímera con dos sedes ficticias, al menos tres roles y transacciones de prueba; obtener credenciales desde gestor local seguro.

**Ejecución:** 1) confirmar precondición e identidad; 2) capturar estado inicial; 3) ejecutar estímulo `Transición de pedido prohibida` por interfaz/API con la autorización pertinente; 4) registrar respuesta HTTP, cambios BD e interfaz; 5) repetir ante escenario negativo o reintento; 6) comprobar `Conflicto controlado` y ausencia de efectos colaterales.

**Criterio de paso:** resultado coincide con contrato y queda evidencia fechada de petición/respuesta sanitizada, log y estado final. **Resultado real y defecto:** pendientes de ejecutar, no completados por esta documentación.


### CP-14. Pago válido

**Objetivo y escenario:** Sandbox Wompi firma válida. **Resultado esperado:** Un pago reconciliado.

**Preparación:** anotar el SHA de los tres repositorios y URL sandbox; reservar base efímera con dos sedes ficticias, al menos tres roles y transacciones de prueba; obtener credenciales desde gestor local seguro.

**Ejecución:** 1) confirmar precondición e identidad; 2) capturar estado inicial; 3) ejecutar estímulo `Sandbox Wompi firma válida` por interfaz/API con la autorización pertinente; 4) registrar respuesta HTTP, cambios BD e interfaz; 5) repetir ante escenario negativo o reintento; 6) comprobar `Un pago reconciliado` y ausencia de efectos colaterales.

**Criterio de paso:** resultado coincide con contrato y queda evidencia fechada de petición/respuesta sanitizada, log y estado final. **Resultado real y defecto:** pendientes de ejecutar, no completados por esta documentación.


### CP-15. Webhook adulterado

**Objetivo y escenario:** Checksum incorrecto. **Resultado esperado:** No se aplica pago.

**Preparación:** anotar el SHA de los tres repositorios y URL sandbox; reservar base efímera con dos sedes ficticias, al menos tres roles y transacciones de prueba; obtener credenciales desde gestor local seguro.

**Ejecución:** 1) confirmar precondición e identidad; 2) capturar estado inicial; 3) ejecutar estímulo `Checksum incorrecto` por interfaz/API con la autorización pertinente; 4) registrar respuesta HTTP, cambios BD e interfaz; 5) repetir ante escenario negativo o reintento; 6) comprobar `No se aplica pago` y ausencia de efectos colaterales.

**Criterio de paso:** resultado coincide con contrato y queda evidencia fechada de petición/respuesta sanitizada, log y estado final. **Resultado real y defecto:** pendientes de ejecutar, no completados por esta documentación.


### CP-16. Webhook repetido

**Objetivo y escenario:** Mismo evento dos veces. **Resultado esperado:** Idempotencia.

**Preparación:** anotar el SHA de los tres repositorios y URL sandbox; reservar base efímera con dos sedes ficticias, al menos tres roles y transacciones de prueba; obtener credenciales desde gestor local seguro.

**Ejecución:** 1) confirmar precondición e identidad; 2) capturar estado inicial; 3) ejecutar estímulo `Mismo evento dos veces` por interfaz/API con la autorización pertinente; 4) registrar respuesta HTTP, cambios BD e interfaz; 5) repetir ante escenario negativo o reintento; 6) comprobar `Idempotencia` y ausencia de efectos colaterales.

**Criterio de paso:** resultado coincide con contrato y queda evidencia fechada de petición/respuesta sanitizada, log y estado final. **Resultado real y defecto:** pendientes de ejecutar, no completados por esta documentación.


### CP-17. Pago rechazado

**Objetivo y escenario:** Sandbox REJECTED. **Resultado esperado:** No cambiar a pagado.

**Preparación:** anotar el SHA de los tres repositorios y URL sandbox; reservar base efímera con dos sedes ficticias, al menos tres roles y transacciones de prueba; obtener credenciales desde gestor local seguro.

**Ejecución:** 1) confirmar precondición e identidad; 2) capturar estado inicial; 3) ejecutar estímulo `Sandbox REJECTED` por interfaz/API con la autorización pertinente; 4) registrar respuesta HTTP, cambios BD e interfaz; 5) repetir ante escenario negativo o reintento; 6) comprobar `No cambiar a pagado` y ausencia de efectos colaterales.

**Criterio de paso:** resultado coincide con contrato y queda evidencia fechada de petición/respuesta sanitizada, log y estado final. **Resultado real y defecto:** pendientes de ejecutar, no completados por esta documentación.


### CP-18. QR cajero

**Objetivo y escenario:** Generar link desde turno válido. **Resultado esperado:** Referencia y valor correctos.

**Preparación:** anotar el SHA de los tres repositorios y URL sandbox; reservar base efímera con dos sedes ficticias, al menos tres roles y transacciones de prueba; obtener credenciales desde gestor local seguro.

**Ejecución:** 1) confirmar precondición e identidad; 2) capturar estado inicial; 3) ejecutar estímulo `Generar link desde turno válido` por interfaz/API con la autorización pertinente; 4) registrar respuesta HTTP, cambios BD e interfaz; 5) repetir ante escenario negativo o reintento; 6) comprobar `Referencia y valor correctos` y ausencia de efectos colaterales.

**Criterio de paso:** resultado coincide con contrato y queda evidencia fechada de petición/respuesta sanitizada, log y estado final. **Resultado real y defecto:** pendientes de ejecutar, no completados por esta documentación.


### CP-19. Cierre de caja

**Objetivo y escenario:** Pagos del cajero actual. **Resultado esperado:** No mezcla de empleados.

**Preparación:** anotar el SHA de los tres repositorios y URL sandbox; reservar base efímera con dos sedes ficticias, al menos tres roles y transacciones de prueba; obtener credenciales desde gestor local seguro.

**Ejecución:** 1) confirmar precondición e identidad; 2) capturar estado inicial; 3) ejecutar estímulo `Pagos del cajero actual` por interfaz/API con la autorización pertinente; 4) registrar respuesta HTTP, cambios BD e interfaz; 5) repetir ante escenario negativo o reintento; 6) comprobar `No mezcla de empleados` y ausencia de efectos colaterales.

**Criterio de paso:** resultado coincide con contrato y queda evidencia fechada de petición/respuesta sanitizada, log y estado final. **Resultado real y defecto:** pendientes de ejecutar, no completados por esta documentación.


### CP-20. Entrega ajena

**Objetivo y escenario:** Repartidor A pide B. **Resultado esperado:** Acceso rechazado.

**Preparación:** anotar el SHA de los tres repositorios y URL sandbox; reservar base efímera con dos sedes ficticias, al menos tres roles y transacciones de prueba; obtener credenciales desde gestor local seguro.

**Ejecución:** 1) confirmar precondición e identidad; 2) capturar estado inicial; 3) ejecutar estímulo `Repartidor A pide B` por interfaz/API con la autorización pertinente; 4) registrar respuesta HTTP, cambios BD e interfaz; 5) repetir ante escenario negativo o reintento; 6) comprobar `Acceso rechazado` y ausencia de efectos colaterales.

**Criterio de paso:** resultado coincide con contrato y queda evidencia fechada de petición/respuesta sanitizada, log y estado final. **Resultado real y defecto:** pendientes de ejecutar, no completados por esta documentación.


### CP-21. Calificación

**Objetivo y escenario:** Cliente propietario de entrega. **Resultado esperado:** Guardar solo 1..5.

**Preparación:** anotar el SHA de los tres repositorios y URL sandbox; reservar base efímera con dos sedes ficticias, al menos tres roles y transacciones de prueba; obtener credenciales desde gestor local seguro.

**Ejecución:** 1) confirmar precondición e identidad; 2) capturar estado inicial; 3) ejecutar estímulo `Cliente propietario de entrega` por interfaz/API con la autorización pertinente; 4) registrar respuesta HTTP, cambios BD e interfaz; 5) repetir ante escenario negativo o reintento; 6) comprobar `Guardar solo 1..5` y ausencia de efectos colaterales.

**Criterio de paso:** resultado coincide con contrato y queda evidencia fechada de petición/respuesta sanitizada, log y estado final. **Resultado real y defecto:** pendientes de ejecutar, no completados por esta documentación.


### CP-22. SignalR

**Objetivo y escenario:** Cliente autorizado suscrito. **Resultado esperado:** Evento recibido/reconexión.

**Preparación:** anotar el SHA de los tres repositorios y URL sandbox; reservar base efímera con dos sedes ficticias, al menos tres roles y transacciones de prueba; obtener credenciales desde gestor local seguro.

**Ejecución:** 1) confirmar precondición e identidad; 2) capturar estado inicial; 3) ejecutar estímulo `Cliente autorizado suscrito` por interfaz/API con la autorización pertinente; 4) registrar respuesta HTTP, cambios BD e interfaz; 5) repetir ante escenario negativo o reintento; 6) comprobar `Evento recibido/reconexión` y ausencia de efectos colaterales.

**Criterio de paso:** resultado coincide con contrato y queda evidencia fechada de petición/respuesta sanitizada, log y estado final. **Resultado real y defecto:** pendientes de ejecutar, no completados por esta documentación.


### CP-23. DB falla

**Objetivo y escenario:** Interrumpir motor. **Resultado esperado:** Sin corrupción ni secretos en error.

**Preparación:** anotar el SHA de los tres repositorios y URL sandbox; reservar base efímera con dos sedes ficticias, al menos tres roles y transacciones de prueba; obtener credenciales desde gestor local seguro.

**Ejecución:** 1) confirmar precondición e identidad; 2) capturar estado inicial; 3) ejecutar estímulo `Interrumpir motor` por interfaz/API con la autorización pertinente; 4) registrar respuesta HTTP, cambios BD e interfaz; 5) repetir ante escenario negativo o reintento; 6) comprobar `Sin corrupción ni secretos en error` y ausencia de efectos colaterales.

**Criterio de paso:** resultado coincide con contrato y queda evidencia fechada de petición/respuesta sanitizada, log y estado final. **Resultado real y defecto:** pendientes de ejecutar, no completados por esta documentación.


### CP-24. Migración

**Objetivo y escenario:** BD efímera desde cero. **Resultado esperado:** Schema coherente.

**Preparación:** anotar el SHA de los tres repositorios y URL sandbox; reservar base efímera con dos sedes ficticias, al menos tres roles y transacciones de prueba; obtener credenciales desde gestor local seguro.

**Ejecución:** 1) confirmar precondición e identidad; 2) capturar estado inicial; 3) ejecutar estímulo `BD efímera desde cero` por interfaz/API con la autorización pertinente; 4) registrar respuesta HTTP, cambios BD e interfaz; 5) repetir ante escenario negativo o reintento; 6) comprobar `Schema coherente` y ausencia de efectos colaterales.

**Criterio de paso:** resultado coincide con contrato y queda evidencia fechada de petición/respuesta sanitizada, log y estado final. **Resultado real y defecto:** pendientes de ejecutar, no completados por esta documentación.


### CP-25. Rollback

**Objetivo y escenario:** Restaurar backup de prueba. **Resultado esperado:** Integridad post-restauración.

**Preparación:** anotar el SHA de los tres repositorios y URL sandbox; reservar base efímera con dos sedes ficticias, al menos tres roles y transacciones de prueba; obtener credenciales desde gestor local seguro.

**Ejecución:** 1) confirmar precondición e identidad; 2) capturar estado inicial; 3) ejecutar estímulo `Restaurar backup de prueba` por interfaz/API con la autorización pertinente; 4) registrar respuesta HTTP, cambios BD e interfaz; 5) repetir ante escenario negativo o reintento; 6) comprobar `Integridad post-restauración` y ausencia de efectos colaterales.

**Criterio de paso:** resultado coincide con contrato y queda evidencia fechada de petición/respuesta sanitizada, log y estado final. **Resultado real y defecto:** pendientes de ejecutar, no completados por esta documentación.


### CP-26. Carga HTTP

**Objetivo y escenario:** Carga y duración declaradas. **Resultado esperado:** p50/p95 medidos.

**Preparación:** anotar el SHA de los tres repositorios y URL sandbox; reservar base efímera con dos sedes ficticias, al menos tres roles y transacciones de prueba; obtener credenciales desde gestor local seguro.

**Ejecución:** 1) confirmar precondición e identidad; 2) capturar estado inicial; 3) ejecutar estímulo `Carga y duración declaradas` por interfaz/API con la autorización pertinente; 4) registrar respuesta HTTP, cambios BD e interfaz; 5) repetir ante escenario negativo o reintento; 6) comprobar `p50/p95 medidos` y ausencia de efectos colaterales.

**Criterio de paso:** resultado coincide con contrato y queda evidencia fechada de petición/respuesta sanitizada, log y estado final. **Resultado real y defecto:** pendientes de ejecutar, no completados por esta documentación.


### CP-27. Usabilidad

**Objetivo y escenario:** Tareas por roles voluntarios. **Resultado esperado:** Tiempos, errores, SUS si aplica.

**Preparación:** anotar el SHA de los tres repositorios y URL sandbox; reservar base efímera con dos sedes ficticias, al menos tres roles y transacciones de prueba; obtener credenciales desde gestor local seguro.

**Ejecución:** 1) confirmar precondición e identidad; 2) capturar estado inicial; 3) ejecutar estímulo `Tareas por roles voluntarios` por interfaz/API con la autorización pertinente; 4) registrar respuesta HTTP, cambios BD e interfaz; 5) repetir ante escenario negativo o reintento; 6) comprobar `Tiempos, errores, SUS si aplica` y ausencia de efectos colaterales.

**Criterio de paso:** resultado coincide con contrato y queda evidencia fechada de petición/respuesta sanitizada, log y estado final. **Resultado real y defecto:** pendientes de ejecutar, no completados por esta documentación.


## 9. Casos complementarios recomendados

| ID | Categoría | Estímulo | Aprobación esperada |
| --- | --- | --- | --- |
| CP-28 | Recuperación | código vencido/reusado | no permite cambiar clave |
| CP-29 | Roles | cliente llama admin endpoint | denegación completa sin filtraciones |
| CP-30 | Turnos | empleado sin turno intenta operación | política ActiveShift aplicada |
| CP-31 | Notificaciones | usuario A consulta notificaciones B | prohibición sin datos filtrados |
| CP-32 | Geo | coordenadas fuera de rango | rechazo validado |
| CP-33 | Mesas | dos clientes actualizan mesa en paralelo | sin duplicación de ocupación |
| CP-34 | Reportes | filtro temporal y otra sede | métricas y permisos consistentes |
| CP-35 | Seguridad | CORS con Origin externo | denegación o política esperada |
| CP-36 | Migración | múltiples instancias iniciando | sin corrupción de esquema |
| CP-37 | Cache | cambio de producto al pagar | servidor calcula tarifa coherente |
| CP-38 | Observabilidad | fallo de webhook y log | sin credenciales/PII |


## 10. Plan de pruebas no funcionales y medición

| Métrica | Método | Datos requeridos | Interpretación |
| --- | --- | --- | --- |
| Latencia p50/p95 API | carga repetible con k6/JMeter | duración, concurrencia, URL, tasas | no comparar sin igual configuración |
| Capacidad de checkout | pedidos/hora con sandbox | referencias y estados únicos | contar completados, no solo 200 HTTP |
| SignalR reconexión | corte wifi de clientes simulados | tiempos, eventos recuperados | verificar consistencia tras reconexión |
| Accesibilidad | axe/Lighthouse + teclado manual | hallazgos WCAG por pantalla | priorizar flujos auth y pago |
| Usabilidad | guion de tareas voluntarias | éxito, errores, tiempo, consentimiento | no afirmar satisfacción sin participantes |
| Backup/restore | restauración en entorno aislado | checksums, total filas, relaciones | exigir coincidencia |
| Seguridad API | OWASP API Top 10 | roles, IDs cruzados, propiedades | hallazgo real requiere reproducción |


## 11. Gestión profesional de defectos y reporte final

**Clasificación:** Bloqueante (corrupción o pago indebido), Crítico (escalada de permisos o fuga personal), Mayor (flujo básico inutilizable), Menor (presentación), Mejora (uso). **Priorización:** impacto × probabilidad × exposición; el revisor valida severidad.

**Informe por caso:** ID, requerimiento relacionado, SHA, rama, ambiente y timestamp, precondiciones, datos anonimizados, procedimiento exacto, estado esperado, observado, captura, logs, evidencia BD, resultado Pass/Fail/Blocked/Not Run, incidencia y re-ejecución.

**Cierre por release:** 100% casos críticos ejecutados; sin defectos bloqueantes/altos abiertos; integridad Wompi aprobada; aislamiento por sede comprobado; restauración y accesibilidad crítica evaluadas; firma de responsables. Son puertas de calidad recomendadas, no porcentajes de cumplimiento actual.


## Fuentes primarias de implementación

- API: https://github.com/yersonct/SaborExpressBack/tree/main
- Web: https://github.com/yersonct/SaborExpressWeb/tree/main
- Móvil: https://github.com/yersonct/SaborExpressMovil/tree/main
- Referencia de presentación: https://github.com/jsgh1/SRD-v1/tree/dev/docs/docs-SRD

**Control documental:** documento elaborado a partir del estado observado en octubre de 2026. Antes de entregar, verificar el commit exacto, responsable, revisión del instructor y cualquier cambio posterior del código.


## 13. Casos críticos con criterio de aceptación y evidencia

| ID | Entrada / contexto | Resultado esperado | Riesgo cubierto | Estado |
|---|---|---|---|---|
| QA-SEC-01 | JWT ausente en `POST /api/Orders` | 401 y sin escritura | autenticación | PENDIENTE |
| QA-SEC-02 | Cliente A lee pedido de cliente B | respuesta negada | BOLA OWASP API1 | PENDIENTE |
| QA-SEC-03 | Administrador consulta reparto de otra sede | 403 | separación de sedes | PENDIENTE |
| QA-PAY-01 | Webhook con checksum incorrecto | rechazo y pago intacto | evento falsificado | PENDIENTE |
| QA-PAY-02 | Webhook válido repetido dos veces | una sola imputación | idempotencia | PENDIENTE |
| QA-PAY-03 | Wompi pendiente reciente y confirmación manual | operación bloqueada según regla | carrera de cobro | PENDIENTE |
| QA-ORD-01 | Dos confirmaciones simultáneas de carrito | ausencia de duplicados no deseados | carrera | PENDIENTE |
| QA-ORD-02 | Precio del catálogo cambia durante el checkout | importe del servidor consistente | manipulación de montos | PENDIENTE |
| QA-MOV-01 | Interrupción de red al despachar | reintento seguro y estado recuperable | duplicidad por reconexión | PENDIENTE |
| QA-DB-01 | Migraciones repetidas en motor oficial | persistencia consistente | despliegue | PENDIENTE |

## 14. Ejemplo de ejecución controlada (PowerShell)

```powershell
# EJEMPLO: entorno sintético; cambie la URL según la API local.
$BaseUrl = 'http://localhost:5000'
# Solo consultar un endpoint publico, NO enviar datos reales.
Invoke-RestMethod -Uri "$BaseUrl/api/Products" -Method Get
# Para rutas protegidas, obtener primero un JWT de usuario de prueba.
# No incluir credenciales en archivos ni capturas del instructor.
```

## 15. Cómo se debe documentar una prueba real

Para cada ejecución registrar fecha UTC y hora local, SHA del backend, web y móvil, sistema operativo, DB y migración, versión del paquete, datos sintéticos usados, pasos exactos, resultado real, HTTP status, duración medida si aplica, evidencia anonimizada, nombre del evaluador y condición PASÓ/NO PASÓ/BLOQUEADO. Mientras estos datos no existan, el resultado es **PENDIENTE** y la cobertura real es **no determinada**.

## 16. Diagramas de integración y control de calidad


![10_CICLO_QA](recursos/10_CICLO_QA.png)

*Nota. Elaboración para el estudio de caso SaborExpress; las figuras no certifican operaciones desplegadas.*


![09_AISLAMIENTO_ROLES](recursos/09_AISLAMIENTO_ROLES.png)

*Nota. Elaboración para el estudio de caso SaborExpress; las figuras no certifican operaciones desplegadas.*
## 17. Estrategia para riesgos no funcionales

Se recomienda medir percentiles HTTP p50/p95 bajo una carga explícitamente definida (usuarios virtuales, duración, tamaño de dataset), y documentar tasas de error. Los escenarios de pagos requieren Wompi sandbox, firma comprobable, eventos duplicados y escenarios fuera de orden. Accesibilidad requiere revisión de teclado, etiquetas y contraste; móvil requiere ensayos en dispositivos y emuladores reales. Ninguno de esos resultados se declara alcanzado en esta entrega documental.
