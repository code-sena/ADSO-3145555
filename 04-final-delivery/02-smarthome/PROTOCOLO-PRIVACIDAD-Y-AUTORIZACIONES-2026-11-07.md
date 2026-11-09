# SmartHome — Protocolo de privacidad, consentimiento y registro de software

**SENA ADSO 3145555 · Revisión: 7 de noviembre de 2026**  
**Estado:** protocolo preventivo para revisión del equipo e instructor. **No representa consentimiento, autorización legal ni aprobación de publicación.**

## 1. Hallazgo verificable

En la rama del [PR institucional #17](https://github.com/code-sena/ADSO-3145555/pull/17), los documentos públicos `README.md`, `team-roster.md` y `software-registration.md` contenían números completos de identificación personal de tres integrantes, mientras que las tres casillas «Verificado y autorizado» continuaban sin marcar.

**Medida en la rama actual de trabajo:** presentar esos números como **reservados para canal privado** y conservar nombres, rol propuesto, tipo de documento y ficha en las tablas de consulta pública. Esta operación **no borra versiones anteriores, diffs, forks, caches o el `main` ya publicado**. El titular y el instructor deben evaluar la exposición histórica; no realizar `git push --force`, borrar el historial institucional o invalidar PR sin autorización del mantenedor.

La plantilla académica precargada **no sustituye** el consentimiento libre e informado de cada persona. El campo vacío **no equivale** a autorización. Ninguna casilla se marcará en nombre de otra persona.

## 2. Diferenciar entrega pública y registro privado ante la DNDA

| Destino | Datos necesarios | Regla de manejo |
|---|---|---|
| Repositorio GitHub público | Nombre, usuario GitHub, ficha y rol **solo en cuanto esté validado y corresponda**; documentos académicos depurados | **No incorporar** número completo de cédula, dirección, teléfono, firma, tokens ni datos de registro privado |
| Revisión interna por instructor/solicitante autorizado | Información necesaria para la validación, obtenida de cada titular | Compartir mediante un **canal privado definido por el instructor**, con acceso restringido |
| Formulario oficial de inscripción de software DNDA | Los datos de autor(es) y solicitante que pida el formulario vigente, incluidas identificaciones según corresponda | Consignarlos en el **trámite oficial y su custodia autorizada**, no en el README o en un ZIP público |

Fuentes oficiales:
- [Ley 1581 de 2012 — normas de tratamiento de datos personales](https://normograma.dian.gov.co/dian/compilacion/docs/ley_1581_2012.htm)
- [SIC — Política de tratamiento, finalidad y circulación restringida](https://sedeelectronica.sic.gov.co/politica-de-tratamiento-de-datos-personales)
- [DNDA — Formulario de solicitud de inscripción soporte lógico (software)](https://www.derechodeautor.gov.co/sites/default/files/2026-08/6.%20Soporte-Logico-Software.pdf)

No sustituye revisión jurídica de la entidad ni del responsable del trámite.

## 3. Pasos de autorización sin publicar documentos privados

Para cada uno de los **tres integrantes**, el instructor o encargado de datos debe:

1. Explicar **para qué** se necesita cada dato, quién lo recibirá, en qué registro se empleará y qué información quedaría públicamente visible.
2. Solicitar **de manera individual** su verificación de nombre, rol, contribución y condición de autor o titular; no presumir que ser instructor o aprendiz implica por sí mismo la misma titularidad.
3. Obtener consentimiento y autorizaciones exigibles **por el canal institucional definido** y conservar evidencia restringida; no publicar respuestas individuales, firmas ni documentos de identidad en GitHub.
4. Completar los datos obligatorios **en el formulario oficial DNDA** bajo custodia autorizada; mantener la copia pública sin el número de identificación.
5. Registrar en el repositorio **solo estado administrativo no sensible**, por ejemplo «Pendiente de revisión por el responsable» o «Constancia custodiada por instructor», únicamente después de verificarlo. **No marcar ninguna casilla como aprobada antes de esa comprobación.**

### Solicitud modelo para enviar en privado (sin número de documento)

> Para completar la revisión de la entrega de SmartHome y el registro del software, necesitamos que revises tus datos de autoría y aportes. El instructor indicará el canal privado para remitir los datos de identificación exigidos por el formulario oficial. Confirma también si autorizas algún dato de identificación en materiales públicos; si no deseas publicarlo, se mantendrá reservado. No envíes cédulas, firmas ni datos sensibles por mensajes o repositorios públicos. La revisión de tu aporte y la autorización de difusión son asuntos distintos.

## 4. Control de verificación (sin inferir consentimiento)

| Integrante | Aporte/rol | Autorización de exposición pública del documento | Datos DNDA en custodia privada | Revisión del instructor |
|---|---|---|---|---|
| Integrante A | Por ratificar | **Pendiente** | **No verificado** | Pendiente |
| Integrante B | Por ratificar | **Pendiente** | **No verificado** | Pendiente |
| Integrante C | Por ratificar | **Pendiente** | **No verificado** | Pendiente |

Estas filas son únicamente una matriz vacía de seguimiento, **no una declaración de voluntad**.

## 5. Riesgo histórico y criterio de cierre

La eliminación de números de la versión visible de un archivo Git **no elimina automáticamente los commits anteriores, los PR históricos o la versión institucional main**. La rama del PR puede seguir mostrando el dato en la sección eliminada de su diff; los propietarios de la organización deben decidir y ejecutar un tratamiento de exposición histórica que no comprometa evidencia ni trazabilidad sin aprobación.

**No declarar «privacidad corregida en su totalidad»** hasta inspeccionar rama institucional, historia, documentos PDF/Word, releases, fuentes Drive y capturas publicadas; confirmar responsabilidades y procedimiento de divulgación con los titulares.

**Acción inmediata del instructor:** revisar este protocolo, comprobar los datos ya expuestos en la rama institucional, consultar a las personas titulares, decidir minimización y custodia del formulario DNDA y autorizar la fusión del PR únicamente con el riesgo gestionado.

