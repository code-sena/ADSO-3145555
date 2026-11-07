# Análisis del software SaborExpress

**Proyecto:** SaborExpress | **Autor / integrante:** Yerson Stiven Cuellar Rubiano | **Ficha:** 3145555 | **Fecha:** 14 de octubre de 2026 | **Versión documental:** 4.0

**Estado de la evidencia:** inspección documental y estática del código. Las pruebas de ejecución y los datos institucionales no aportados no se presumen realizados.

## 1. Problema de negocio

Una operación gastronómica combina catálogo, atención de mesa, cocina, caja, despachos y reparto. Cuando estos procesos usan registros aislados, se incrementa el riesgo de confusión de estados, transcripciones manuales y baja trazabilidad. La solución analizada centraliza contratos y datos de pedidos a través de una API; esto es una justificación de diseño, no una medición real de reducción de errores.

## 2. Interesados y responsabilidades

| Interesado | Necesidad | Acciones principales |
| --- | --- | --- |
| Cliente | Comprar y dar seguimiento | Catálogo, pedido, pago, cancelación, calificación |
| Cajero | Consolidar transacciones | Pedido, cobro, cierre de turno |
| Cocina | Atender órdenes | Tablero, cambios de estado por plato |
| Administrador | Coordinar sede | Personal, productos, horarios, caja, entregas |
| Repartidor | Gestionar domicilio | Órdenes asignadas, estatus, ubicación |
| Gerente | Supervisar operación | Sedes, reportes, permisos |
| Equipo técnico | Operar y mantener | API, migraciones, logs, incidentes |

## 3. Casos de uso principales

### CU-01. Inicio de sesión

Precondición: usuario registrado. Flujo: introducir credenciales → enviar `POST /api/Auth/login` → recibir respuesta o error controlado → habilitar rutas conforme a roles. Excepciones: cuenta no activada, correo sin confirmar, intentos fallidos, token inválido. Postcondición: sesión autenticada según el contrato de la API.

### CU-02. Gestión del catálogo

Precondición: sede o catálogo disponible. Flujo: `GET /api/Products` con `branchId` opcional, elegir productos, consultar categorías. Actor administrador puede crear, modificar o inhabilitar productos bajo permisos específicos. Excepciones: producto inexistente, sede inactiva, error de imagen.

### CU-03. Pedido y cocina

El usuario selecciona detalles, cantidades y tipo (comer en sitio, para llevar o domicilio). Se envía `POST /api/Orders`; el personal consulta vistas filtradas y actualiza estado mediante PATCH. El tablero de cocina atiende etapas operativas; se deben demostrar las transiciones válidas en pruebas futuras.

### CU-04. Cobro por pasarela

Se inicia la transacción con Wompi; el backend genera una referencia y expone un webhook para confirmación de eventos externos. La sincronización por ID funciona como alternativa de consulta. Riesgos: firmas erróneas, eventos duplicados, carrera entre confirmación y cancelación, latencia del proveedor.

### CU-05. Domicilio y entrega

Gerente o administrador asigna entrega; repartidor consulta sus órdenes, actualiza estados, cliente califica. Se deben validar reglas de privacidad y segregación por sede.

## 4. Flujos de información

`Interfaz → servicio de cliente → HTTP/JWT → controlador → servicio de dominio → repositorio/EF → BD`. Para notificaciones: `evento de negocio → notificación → hub SignalR → cliente suscrito`; el código del Hub prueba su existencia, no la garantía de entrega.

## 5. Escenarios excepcionales y riesgos

| ID | Escenario | Comportamiento esperado | Prueba pendiente |
| --- | --- | --- | --- |
| EX-01 | JWT expirado | 401 y renovación guiada | Token caducado |
| EX-02 | Acceso a otra sede | 403 sin filtrar información | Prueba cruzada |
| EX-03 | Webhook repetido | No duplicar pago | Repetición mismo evento |
| EX-04 | Falla de base de datos | Respuesta controlada + recuperación | Interrupción de DB |
| EX-05 | Pérdida de SignalR | Reintento o estado reconciliado | Reconexión |
| EX-06 | Dirección inválida | Validación sin pedido inconsistente | Caso domicilio |
| EX-07 | Estado de cocina incompatible | Rechazo de transición | Secuencia inválida |
| EX-08 | Pago rechazado | Pedido no aparece abonado | Sandbox Wompi |

## 6. Análisis de viabilidad

**Técnica:** el stack identificado dispone de bibliotecas y convenciones para la integración. **Operativa:** requiere roles, política de turnos y manuales por actor. **Financiera:** no hay datos reales de costos operativos, por lo que no se presenta ROI; se incluye una matriz de rubros a cotizar. **Jurídica y de privacidad:** se requiere política de tratamiento de datos, términos y controles de seguridad para operación real.

## 7. Hallazgos y decisiones abiertas

Los controladores contienen numerosas operaciones, pero el repositorio no demuestra por sí solo la cobertura de tests, permisos en profundidad ni consistencia multi-proveedor de las migraciones. El archivo `README.md` del repositorio documental describía Supabase como backend principal, contradiciendo el proyecto .NET inspeccionado; esta versión lo corrige.


## 8. Fichas ampliadas de casos de uso

Los siguientes casos representan flujos reconstruidos desde los contratos conocidos; cada paso debe contrastarse con el servicio y el frontend antes de aprobarse como comportamiento implantado.


### CU-01. Autenticación

**Actor primario:** Usuario. **Trazabilidad:** RF-01 RF-02. **Interesados secundarios:** servicio API, base de datos y/o pasarela según flujo.

**Precondición:** Usuario activo, servicio Auth accesible. **Flujo normal:** 1) iniciar operación en interfaz; 2) comprobar autorización; 3) Suministra credenciales; backend verifica; rol autoriza cliente; 4) observar respuesta REST o confirmación de pasarela; 5) mostrar estado actualizado y conservar registro.

**Postcondición:** Sesión creada según respuesta real. **Eventos excepcionales:** Usuario no confirmado, bloqueo por intentos, token expirado. Ante fallos se debe evitar duplicar el efecto de negocio y exponer información sensible.

**Aceptación propuesta:** ejecutar caso positivo y negativo, guardar peticiones/respuestas anonimizadas, evidencia de BD y verificación del cliente con SHA y fecha. **Estado:** pendiente de ensayo.


### CU-02. Catálogo por sede

**Actor primario:** Cliente. **Trazabilidad:** RF-08 RF-09. **Interesados secundarios:** servicio API, base de datos y/o pasarela según flujo.

**Precondición:** Productos globales y por sede preparados. **Flujo normal:** 1) iniciar operación en interfaz; 2) comprobar autorización; 3) Selecciona sede; lista catálogo; filtra categoría; 4) observar respuesta REST o confirmación de pasarela; 5) mostrar estado actualizado y conservar registro.

**Postcondición:** Lista consistente con sucursal. **Eventos excepcionales:** Producto deshabilitado, sede inactiva. Ante fallos se debe evitar duplicar el efecto de negocio y exponer información sensible.

**Aceptación propuesta:** ejecutar caso positivo y negativo, guardar peticiones/respuestas anonimizadas, evidencia de BD y verificación del cliente con SHA y fecha. **Estado:** pendiente de ensayo.


### CU-03. Pedido para mesa

**Actor primario:** Mesero/Cajero. **Trazabilidad:** RF-10 RF-24. **Interesados secundarios:** servicio API, base de datos y/o pasarela según flujo.

**Precondición:** Mesa elegible y empleado con turno. **Flujo normal:** 1) iniciar operación en interfaz; 2) comprobar autorización; 3) Elige mesa, productos, cantidades; registra orden; 4) observar respuesta REST o confirmación de pasarela; 5) mostrar estado actualizado y conservar registro.

**Postcondición:** Orden con BranchId y TableId. **Eventos excepcionales:** Mesa incorrecta, precio desactualizado. Ante fallos se debe evitar duplicar el efecto de negocio y exponer información sensible.

**Aceptación propuesta:** ejecutar caso positivo y negativo, guardar peticiones/respuestas anonimizadas, evidencia de BD y verificación del cliente con SHA y fecha. **Estado:** pendiente de ensayo.


### CU-04. Pedido para domicilio

**Actor primario:** Cliente. **Trazabilidad:** RF-10 RF-23. **Interesados secundarios:** servicio API, base de datos y/o pasarela según flujo.

**Precondición:** Dirección válida y sede operativa. **Flujo normal:** 1) iniciar operación en interfaz; 2) comprobar autorización; 3) Elige canal domicilio; registra detalles y dirección; 4) observar respuesta REST o confirmación de pasarela; 5) mostrar estado actualizado y conservar registro.

**Postcondición:** Order.AddressId presente según regla del servicio. **Eventos excepcionales:** Dirección ajena, radio fuera de cobertura. Ante fallos se debe evitar duplicar el efecto de negocio y exponer información sensible.

**Aceptación propuesta:** ejecutar caso positivo y negativo, guardar peticiones/respuestas anonimizadas, evidencia de BD y verificación del cliente con SHA y fecha. **Estado:** pendiente de ensayo.


### CU-05. Actualización de cocina

**Actor primario:** Cocinero. **Trazabilidad:** RF-12 RF-22. **Interesados secundarios:** servicio API, base de datos y/o pasarela según flujo.

**Precondición:** Pedido pendiente según política. **Flujo normal:** 1) iniciar operación en interfaz; 2) comprobar autorización; 3) Abre tablero y marca nuevas etapas; 4) observar respuesta REST o confirmación de pasarela; 5) mostrar estado actualizado y conservar registro.

**Postcondición:** Estado persistido y reflejado en clientes. **Eventos excepcionales:** Dos cambios simultáneos, turno inválido. Ante fallos se debe evitar duplicar el efecto de negocio y exponer información sensible.

**Aceptación propuesta:** ejecutar caso positivo y negativo, guardar peticiones/respuestas anonimizadas, evidencia de BD y verificación del cliente con SHA y fecha. **Estado:** pendiente de ensayo.


### CU-06. Cancelación del pedido

**Actor primario:** Cliente. **Trazabilidad:** RF-13. **Interesados secundarios:** servicio API, base de datos y/o pasarela según flujo.

**Precondición:** El titular posee pedido en estado cancelable. **Flujo normal:** 1) iniciar operación en interfaz; 2) comprobar autorización; 3) Consulta y cancela desde su sesión; 4) observar respuesta REST o confirmación de pasarela; 5) mostrar estado actualizado y conservar registro.

**Postcondición:** Cancelación auditable. **Eventos excepcionales:** No propietario, pago pendiente. Ante fallos se debe evitar duplicar el efecto de negocio y exponer información sensible.

**Aceptación propuesta:** ejecutar caso positivo y negativo, guardar peticiones/respuestas anonimizadas, evidencia de BD y verificación del cliente con SHA y fecha. **Estado:** pendiente de ensayo.


### CU-07. Pago presencial

**Actor primario:** Cajero. **Trazabilidad:** RF-14. **Interesados secundarios:** servicio API, base de datos y/o pasarela según flujo.

**Precondición:** Cuenta autorizada con turno activo. **Flujo normal:** 1) iniciar operación en interfaz; 2) comprobar autorización; 3) Registra monto, medio y conciliación; 4) observar respuesta REST o confirmación de pasarela; 5) mostrar estado actualizado y conservar registro.

**Postcondición:** Payment asociada a Order. **Eventos excepcionales:** Doble registro, sobrepago. Ante fallos se debe evitar duplicar el efecto de negocio y exponer información sensible.

**Aceptación propuesta:** ejecutar caso positivo y negativo, guardar peticiones/respuestas anonimizadas, evidencia de BD y verificación del cliente con SHA y fecha. **Estado:** pendiente de ensayo.


### CU-08. Pago Wompi

**Actor primario:** Cliente. **Trazabilidad:** RF-15 RF-16. **Interesados secundarios:** servicio API, base de datos y/o pasarela según flujo.

**Precondición:** Pedido, ambiente Wompi configurado. **Flujo normal:** 1) iniciar operación en interfaz; 2) comprobar autorización; 3) Solicita init; paga en pasarela; recibe webhook; 4) observar respuesta REST o confirmación de pasarela; 5) mostrar estado actualizado y conservar registro.

**Postcondición:** Estado no se adelanta antes de verificación. **Eventos excepcionales:** Firma inválida, devolución, webhook duplicado. Ante fallos se debe evitar duplicar el efecto de negocio y exponer información sensible.

**Aceptación propuesta:** ejecutar caso positivo y negativo, guardar peticiones/respuestas anonimizadas, evidencia de BD y verificación del cliente con SHA y fecha. **Estado:** pendiente de ensayo.


### CU-09. Pago por QR

**Actor primario:** Cajero. **Trazabilidad:** RF-17. **Interesados secundarios:** servicio API, base de datos y/o pasarela según flujo.

**Precondición:** Pedido válido y permisos vigentes. **Flujo normal:** 1) iniciar operación en interfaz; 2) comprobar autorización; 3) Obtiene QR/referencia; presenta al cliente; 4) observar respuesta REST o confirmación de pasarela; 5) mostrar estado actualizado y conservar registro.

**Postcondición:** Pago conciliado tras evento auténtico. **Eventos excepcionales:** Referencia caducada, múltiples QR. Ante fallos se debe evitar duplicar el efecto de negocio y exponer información sensible.

**Aceptación propuesta:** ejecutar caso positivo y negativo, guardar peticiones/respuestas anonimizadas, evidencia de BD y verificación del cliente con SHA y fecha. **Estado:** pendiente de ensayo.


### CU-10. Asignación de domicilio

**Actor primario:** Gerente/Admin. **Trazabilidad:** RF-18. **Interesados secundarios:** servicio API, base de datos y/o pasarela según flujo.

**Precondición:** Orden domicilio y empleado elegible. **Flujo normal:** 1) iniciar operación en interfaz; 2) comprobar autorización; 3) Designa repartidor y crea Delivery; 4) observar respuesta REST o confirmación de pasarela; 5) mostrar estado actualizado y conservar registro.

**Postcondición:** Relación única coherente. **Eventos excepcionales:** Repartidor de otra sede. Ante fallos se debe evitar duplicar el efecto de negocio y exponer información sensible.

**Aceptación propuesta:** ejecutar caso positivo y negativo, guardar peticiones/respuestas anonimizadas, evidencia de BD y verificación del cliente con SHA y fecha. **Estado:** pendiente de ensayo.


### CU-11. Entrega a domicilio

**Actor primario:** Repartidor. **Trazabilidad:** RF-19. **Interesados secundarios:** servicio API, base de datos y/o pasarela según flujo.

**Precondición:** Entrega asignada. **Flujo normal:** 1) iniciar operación en interfaz; 2) comprobar autorización; 3) Consulta su tarea y cambia etapa; 4) observar respuesta REST o confirmación de pasarela; 5) mostrar estado actualizado y conservar registro.

**Postcondición:** Estado entregado bajo política. **Eventos excepcionales:** Empleado no titular, status inválido. Ante fallos se debe evitar duplicar el efecto de negocio y exponer información sensible.

**Aceptación propuesta:** ejecutar caso positivo y negativo, guardar peticiones/respuestas anonimizadas, evidencia de BD y verificación del cliente con SHA y fecha. **Estado:** pendiente de ensayo.


### CU-12. Calificación

**Actor primario:** Cliente. **Trazabilidad:** RF-20. **Interesados secundarios:** servicio API, base de datos y/o pasarela según flujo.

**Precondición:** Entrega finalizada de su orden. **Flujo normal:** 1) iniciar operación en interfaz; 2) comprobar autorización; 3) Califica con puntuación y comentario; 4) observar respuesta REST o confirmación de pasarela; 5) mostrar estado actualizado y conservar registro.

**Postcondición:** Rating 1..5 asociada a Delivery. **Eventos excepcionales:** Tercero o repetición no autorizada. Ante fallos se debe evitar duplicar el efecto de negocio y exponer información sensible.

**Aceptación propuesta:** ejecutar caso positivo y negativo, guardar peticiones/respuestas anonimizadas, evidencia de BD y verificación del cliente con SHA y fecha. **Estado:** pendiente de ensayo.


### CU-13. Administración de sedes

**Actor primario:** Gerente. **Trazabilidad:** RF-04 RF-05. **Interesados secundarios:** servicio API, base de datos y/o pasarela según flujo.

**Precondición:** Privilegios de gerente. **Flujo normal:** 1) iniciar operación en interfaz; 2) comprobar autorización; 3) Crea/edita sede con datos operativos; 4) observar respuesta REST o confirmación de pasarela; 5) mostrar estado actualizado y conservar registro.

**Postcondición:** Sucursal actualizada. **Eventos excepcionales:** Administrador de sede ajena. Ante fallos se debe evitar duplicar el efecto de negocio y exponer información sensible.

**Aceptación propuesta:** ejecutar caso positivo y negativo, guardar peticiones/respuestas anonimizadas, evidencia de BD y verificación del cliente con SHA y fecha. **Estado:** pendiente de ensayo.


### CU-14. Notificación en tiempo real

**Actor primario:** Usuario operativo. **Trazabilidad:** RF-21 RF-22. **Interesados secundarios:** servicio API, base de datos y/o pasarela según flujo.

**Precondición:** Sesión autorizada y Hub disponible. **Flujo normal:** 1) iniciar operación en interfaz; 2) comprobar autorización; 3) Se conecta a SignalR y atiende evento; 4) observar respuesta REST o confirmación de pasarela; 5) mostrar estado actualizado y conservar registro.

**Postcondición:** Cliente reconcilia estado con REST. **Eventos excepcionales:** Red caída, duplicado, conexión sin permisos. Ante fallos se debe evitar duplicar el efecto de negocio y exponer información sensible.

**Aceptación propuesta:** ejecutar caso positivo y negativo, guardar peticiones/respuestas anonimizadas, evidencia de BD y verificación del cliente con SHA y fecha. **Estado:** pendiente de ensayo.


## 9. Modelo de actores, permisos y límites

| Actor | Datos propios | Operación usual | Riesgo crítico de autorización |
| --- | --- | --- | --- |
| Cliente | pedidos, direcciones y perfil | consulta propia, pedidos, pago, cancelación | IDOR: acceder a pedido ajeno |
| Cajero | caja de turno, pedidos | cobro presencial, QR, cierre | mezclar pagos de otro empleado |
| Mesero | mesas y órdenes de sede | tomar/editar pedido | editar mesas fuera de sede |
| Cocinero | cola de preparación | cambiar estado de cocina | elevar permiso administrativo |
| Repartidor | entregas asignadas | actualizar estado | leer/modificar reparto ajeno |
| Administrador | sede, equipo, catálogo | configuración y turnos | saltar aislamiento de sucursales |
| Gerente | múltiples sedes | alta, supervisión y reportes | exposición de perfiles personales |
| Sistema externo Wompi | evento firmado | webhook de pago | suplantación / repetición |


## 10. Reglas y excepciones por agregado

**Pedido:** la entidad Order mantiene asociación obligatoria a Branch y opcionales a Customer, Employee, Table y Address. No se debe suponer un único canal: validar diferencias de DineIn, ToGo y Delivery en los servicios. La suma total es un cálculo del servidor; el cliente no es autoridad monetaria.

**Pago:** cada Payment tiene OrderId y Amount; los campos WompiReference y WompiTransactionId vinculan las actualizaciones externas. Se recomienda unicidad lógica por referencia y transacción; su implementación física debe comprobarse en configuraciones EF. Un webhook válido no debe cambiar dos veces el saldo.

**Entrega:** Delivery referencia Order, Address y DeliveryPersonId; verificación de sede y titular debe ejecutarse en servicios, no solo en pantallas. La calificación requiere identidad del propietario, rango válido y criterio explícito de repetición.

**Catálogo:** Product.BranchId nullable distingue productos globales de específicos de una sede; el cliente no debe ver estados internos o productos deshabilitados según las reglas reales del servicio.

**Sesión/turno:** Program.cs registra ActiveShift, pero cada controlador puede tener atributos distintos; elaborar matriz endpoint-rol-turno con la implementación completa.


## 11. Viabilidad y supuestos de la solución

La viabilidad técnica se fundamenta en proyectos existentes con tecnologías de soporte amplio, aunque faltan pruebas de compilación y despliegue reproducible. La viabilidad económica exige presupuestar cómputo, almacenamiento, copias, correo, dominio, transacciones y soporte, y medir ingresos/costos: no se calcula retorno de inversión sin datos. La viabilidad operativa depende de conectividad, capacitación de caja, procedimientos de cocina, teléfonos del personal y funcionamiento de la pasarela. La viabilidad regulatoria demanda análisis de tratamiento de datos personales, retención y condiciones contractuales de la pasarela, sin que este informe constituya dictamen legal.

**Supuestos a validar:** un negocio con varias sedes, un backend central, cuentas diferenciadas por rol y conectividad móvil. **Restricciones:** llamadas REST autorizadas, gestión de credenciales y conciliación de pagos. **Dependencias críticas:** plataforma de datos, Wompi, conectividad y dispositivos de cajeros y repartidores.


## Fuentes primarias de implementación

- API: https://github.com/yersonct/SaborExpressBack/tree/main
- Web: https://github.com/yersonct/SaborExpressWeb/tree/main
- Móvil: https://github.com/yersonct/SaborExpressMovil/tree/main
- Referencia de presentación: https://github.com/jsgh1/SRD-v1/tree/dev/docs/docs-SRD

**Control documental:** documento elaborado a partir del estado observado en octubre de 2026. Antes de entregar, verificar el commit exacto, responsable, revisión del instructor y cualquier cambio posterior del código.


## 14. Contexto, actores y reglas de colaboración

Se identifican cinco grupos operativos y un proveedor de pagos. Cliente efectúa exploración y pedido; personal de caja realiza pagos y cierres; cocina necesita un tablero de preparación que permanezca consistente con los estados; repartidor consulta asignaciones permitidas; gerente/administrador mantiene recursos y personal por sucursal. La pasarela externa no sustituye el registro financiero local: responde a los intentos iniciados por la API y notifica estados cuya procedencia debe validarse.

El análisis diferencia los canales **consumo en mesa**, **recogida** y **entrega a domicilio** inferidos de `OrderType`, campos opcionales de dirección y mesa, y notas del modelo. Los valores precisos del enum deben revisarse antes de publicar pantallas o flujos que dependan de nombres literales.

## 15. Casos de uso desarrollados: compra, cobro y despacho

**CU-01 Crear pedido:** actor cliente/cajero. Entrada: artículos existentes, unidades positivas, sede seleccionada y canal. Camino básico: seleccionar sede, consultar productos permitidos, conformar carrito, revisar dirección o mesa, enviar DTO y mostrar identificador. Alternos: producto fuera de catálogo, dirección faltante para domicilio, sesión vencida, turno inactivo, doble clic de confirmación. Postcondición: pedido único con detalle coherente y estado inicial recuperable mediante API. Riesgo a cubrir: carrera de precio entre consulta y compra.

**CU-02 Pago digital:** actor cliente y servicio externo Wompi. Precondición: pedido y monto validado en backend. Camino: inicialización de referencia y transacción, interacción segura con pasarela, recepción del evento, verificación de integridad, conciliación con monto y referencia, modificación transaccional del pago y estado visible. Alternos: cancelación externa, expiración, webhook duplicado, diferencia de monto, falla de conexión, resincronización. Postcondición: ningún pago duplicado por repetir el evento.

**CU-03 Reparto:** actor administrador y repartidor. Precondición: pedido apto para entregar y repartidor disponible. Camino: asignación controlada, consulta del envío correspondiente, cambio autorizado de estado, registro de entrega y calificación de cliente. Alternos: otro repartidor intenta operar, cambio de sede, ruta desactualizada, anulación y reconexión del dispositivo. Postcondición: la historia del pedido y del reparto permanecen consistentes.

## 16. Diagramas de casos de uso y transición


![01_CONTEXT0](recursos/01_CONTEXT0.png)

*Nota. Elaboración para el estudio de caso SaborExpress; las figuras no certifican operaciones desplegadas.*


![08_CASOS_USO](recursos/08_CASOS_USO.png)

*Nota. Elaboración para el estudio de caso SaborExpress; las figuras no certifican operaciones desplegadas.*


![03_FLUJO_PEDIDO](recursos/03_FLUJO_PEDIDO.png)

*Nota. Elaboración para el estudio de caso SaborExpress; las figuras no certifican operaciones desplegadas.*
## 17. Políticas analíticas para los flujos críticos

Se recomienda definir por escrito los invariantes operativos: un `OrderDetail` pertenece a exactamente un `Order`; un `Payment` pertenece a un pedido determinado; una `Delivery` referencia orden, dirección y empleado; un producto global (BranchId nulo) tiene semántica diferente de uno ligado a sede. Cada cambio financiero requiere correlación inequívoca con referencia externa e identidad interna. La limpieza o modificación histórica no debe destruir trazabilidad necesaria para auditoría.
