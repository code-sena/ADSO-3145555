# Manual de usuario final por rol

**Proyecto:** SaborExpress · **Autor / integrante:** Yerson Stiven Cuellar Rubiano · **Ficha:** ADSO-3145555 · **Corte:** 3 de noviembre de 2026 · **Versión documental:** 4.1

**Proyecto:** SaborExpress · **Fecha de corte:** 3 de noviembre de 2026 · **Versión documental:** 4.1 · **Tipo:** Documento técnico y académico
**Estado:** guía revisada contra el código de Backend, Web y Móvil de las ramas de cierre. Describe tareas observadas en el producto y límites conocidos. No declara una sesión de aceptación en staging ni pruebas en dispositivo físico.

## 1. Antes de iniciar

- Usa una cuenta individual autorizada y el rol asignado; no compartas contraseñas, códigos de recuperación ni tokens.
- Comprueba la sede activa antes de registrar o consultar operaciones. Cambiar de sede no concede acceso a datos de otra sede.
- Revisa la confirmación que muestra el sistema antes de repetir un pedido, pago o cambio de estado.
- Si el nombre de una opción difiere, consulta la navegación de la versión desplegada. La interfaz puede cambiar entre Web y Móvil.
- Si el sistema muestra un error de sesión o permiso, vuelve a ingresar o solicita el acceso correcto. No uses la cuenta de otra persona.

## 2. Perfiles y alcance

| Perfil | Tareas principales | Límite de uso |
|---|---|---|
| Cliente | Consultar carta, crear pedidos, elegir entrega/consumo, revisar pagos y seguimiento, calificar una entrega propia. | Solo sus pedidos, pagos y entregas. |
| Mesero | Consultar mesas de su sede, tomar pedidos, enviarlos a cocina y entregar pedidos listos. | No registrar operaciones en otra sede ni duplicar pedidos. |
| Cocina | Consultar la cola y actualizar el avance de preparación. | No cambiar pagos ni pedidos ajenos a su sede. |
| Cajero | Revisar pedidos por cobrar, registrar efectivo o iniciar QR cuando esté habilitado, conciliar y consultar su turno. | Un QR generado no confirma el pago. |
| Repartidor | Revisar entregas asignadas, disponibilidad y dirección necesaria; actualizar estados de la entrega propia. | No consultar ni modificar entregas asignadas a otra persona. |
| Administrador de sede | Gestionar recursos de su sede, como personal, horarios y catálogo según los permisos concedidos. | La matriz global de permisos requiere el rol Gerente. |
| Gerente | Supervisar sedes y reportes permitidos, revisar la matriz global de permisos y operaciones administrativas. | Verifica sede, rango de fechas y fuente antes de interpretar un indicador. |

En Web, la navegación observada incluye panel (/panel), pedidos (/orders), caja/reportes (/caja), productos (/productos), equipo (/equipo), sedes (/sedes), ajustes (/ajustes), mesas (/mesas), horarios (/horarios), domicilios (/domicilios) y reseñas (/resenas). Las opciones visibles dependen del rol y de la configuración.

## 3. Cliente

1. Inicia sesión o completa el registro desde la aplicación.
2. Selecciona una sede disponible y revisa categorías, productos, precios y disponibilidad.
3. Agrega productos y cantidades. Elige la modalidad disponible (mesa, retiro o domicilio) y completa la dirección cuando aplique.
4. Revisa el resumen y el total antes de confirmar. Si la conexión se demora, consulta primero la lista de pedidos para evitar crear uno duplicado.
5. Selecciona el medio de pago habilitado. En Wompi, espera el estado confirmado en la aplicación; una redirección, QR o estado pendiente no significa que el pago se haya aprobado.
6. Abre el detalle para consultar el avance. Califica solo la entrega propia cuando el flujo lo permita.

## 4. Mesero

1. Inicia sesión y confirma la sede y mesa antes de tomar el pedido.
2. Busca la mesa en la vista de mesas, agrega los productos y revisa cantidades y observaciones.
3. Confirma el pedido una sola vez y verifica que aparezca en la lista de pedidos activos.
4. Consulta la cola de cocina y entrega cuando los productos estén listos.
5. Si una solicitud falla o se pierde la conexión, vuelve a consultar el pedido antes de repetir la acción.
6. La cancelación se habilita según el estado operativo: no intentes cancelar un pedido pagado o que ya avanzó en cocina.

## 5. Cocina

1. Abre el tablero de cocina asociado a la sede y revisa mesa/modalidad y detalle.
2. Actualiza cada etapa cuando corresponda al avance físico de preparación.
3. Si el tablero no recibe cambios, consulta de nuevo el estado del pedido cuando haya conexión; no registres dos veces la misma transición.
4. Usa enlaces de tablero público únicamente para la operación prevista y no los compartas fuera del establecimiento.
5. No edites pagos desde el tablero de cocina.

## 6. Cajero

1. Inicia sesión y comprueba turno y sede antes de cobrar.
2. Busca el pedido y verifica el valor que muestra el sistema.
3. Para efectivo, registra el pago una sola vez y confirma el resultado.
4. Para QR, inicia el flujo disponible y espera la notificación/conciliación del proveedor. Un QR generado o un pago pendiente no es un pago confirmado.
5. Ante una respuesta lenta, revisa primero el historial del pedido/pago antes de reintentar.
6. Al finalizar, revisa el cierre del turno. Reporta diferencias al Gerente; no alteres manualmente el historial.

## 7. Repartidor

1. Inicia sesión, revisa disponibilidad y abre las entregas asignadas.
2. Verifica dirección y referencias solo para completar la entrega.
3. Actualiza el estado cuando represente el avance real.
4. Si pierde conexión, vuelve a consultar la asignación y el estado antes de reenviar una actualización.
5. Mantén privados dirección, teléfono y detalles del pedido; reporta incidentes por el canal autorizado.

## 8. Administrador de sede

1. Inicia sesión en Web y confirma la sede activa.
2. Usa solo las opciones habilitadas para tu rol: equipo, horarios, productos, categorías, mesas, domicilios y ajustes de sede.
3. Comprueba el listado después de guardar. Si recibes “prohibido”, solicita el permiso correspondiente; no cambies de cuenta ni de sede para evitar el control.
4. Las operaciones globales sobre roles y permisos están reservadas a Gerente.

## 9. Gerente

1. Confirma la sede y el rango de fechas antes de revisar reportes.
2. Administra la matriz global de roles/permisos conforme al procedimiento interno y registra el motivo de los cambios.
3. Para liberar mesas de un día anterior, comprueba primero que no tengan pedidos activos y sigue la opción administrativa disponible.
4. Contrasta las cifras con la fuente y el período; este manual no presenta métricas operativas como resultados verificados.

## 10. Problemas frecuentes

| Síntoma | Qué revisar | Acción segura |
|---|---|---|
| No permite ingresar | Correo, activación y vigencia de sesión. | Reintenta una vez o usa el proceso de recuperación; nunca compartas el código. |
| “No autorizado” | Sesión ausente o expirada. | Ingresa de nuevo desde la aplicación oficial. |
| “Prohibido” | Rol, sede o propiedad del recurso. | Solicita el permiso; no uses una cuenta ajena. |
| Pedido no aparece | Sede, filtros y conexión. | Actualiza la consulta antes de crear otro pedido. |
| Pago pendiente | Estado del proveedor y del pedido. | Espera conciliación y revisa antes de repetir el cobro. |
| Estado de pedido desactualizado | Conexión o actualización en tiempo real. | Recupera la conexión y consulta el estado actual desde la aplicación. |
| Producto no disponible | Catálogo actualizado. | Selecciona otra opción o consulta al personal responsable. |
| Archivo rechazado | Tipo, contenido y tamaño admitidos. | Usa un archivo permitido; no intentes cambiar su extensión para eludir validaciones. |

## 11. Privacidad y soporte

Cierra sesión en equipos compartidos. No publiques capturas con datos de clientes, direcciones, credenciales o información de pagos. Para pedir soporte, incluye módulo, hora aproximada, sede, versión y un identificador no sensible; elimina tokens, contraseñas y datos financieros.

## 12. Capacitación y límites de esta guía

El guion de capacitación debe cubrir pedidos y recuperación de conexión, cocina, caja, pagos pendientes, entregas y permisos por sede. Registra fecha, versión, tareas observadas, incidencias y autorización de quienes participen antes de publicar resultados. No se afirma que estas sesiones se hayan ejecutado.

La guía fue revisada el 3 de noviembre de 2026 contra las ramas de cierre. Los recorridos completos de siete roles y dos sedes siguen pendientes en staging; no hay evidencia de instalación en dispositivo físico ni de aceptación institucional.

## Fuentes de implementación

- [Backend — hu-cierre-backend](https://github.com/yersonct/SaborExpressBack/tree/hu-cierre-backend)
- [Web — hu-cierre-web](https://github.com/yersonct/SaborExpressWeb/tree/hu-cierre-web)
- [Móvil — hu-cierre-movil](https://github.com/yersonct/SaborExpressMovil/tree/hu-cierre-movil)
- [Estado de cierre y evidencia por HU](../9-traceability/CIERRE-HU-2026-11-03.md)
