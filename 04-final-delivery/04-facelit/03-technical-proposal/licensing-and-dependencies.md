# Propuesta de licenciamiento y sostenimiento de FaceLit

Revisión integral del 5 de noviembre de 2026. Documento académico del equipo de Análisis y Desarrollo de Software, ficha 3145555, SENA, Neiva, Huila. Integrantes: Mariana Valenzuela Penagos, Valery Sinaí Trujillo Quintero y María José Rodríguez Oyola.

## 1 Estado de la propuesta

Esta edición actualiza la descripción técnica, las dependencias y el esquema de estimación de costos. La modalidad educativa y una posible modalidad comercial continúan como propuestas que deben quedar respaldadas por acuerdos de los titulares y condiciones de terceros. Este documento no otorga una licencia general de FaceLit ni fija precios de venta.

En los cuatro checkouts main revisados no se localizan archivos propios LICENSE, LICENCE o NOTICE entre los archivos seguidos por Git. El listado del equipo documenta participación académica; los acuerdos de autoría y titularidad se conservan con los soportes institucionales correspondientes. La presente revisión no afirma la existencia de una cesión, convenio o contrato que no fue aportado.

## 2 Producto y entrega técnica

FaceLit organiza asistencia mediante gestión académica y CSV, administración de ambientes, sesiones de captura, referencia facial, consultas, reportes, avisos y preferencias de coordinación, instructor y aprendiz. La entrega documentada combina Expo y React Native, Spring Boot con Java 17, FastAPI con Python 3.11 y PostgreSQL con pgvector.

La publicación en facelit.tech se preparó desde main local de los cuatro repositorios. El frontend contiene el ajuste local de consulta por lotes y BD el commit de compatibilidad 422aac6. El [Anexo C](../02-software-analysis/functional-inventory.md) y el [informe de despliegue](../06-implementation-procedure/hostinger-deployment.md) registran las revisiones, los ajustes y la diferencia con las referencias remotas. El estado operativo informado por el equipo se conserva en la carpeta 07.

## 3 Opciones a definir por el equipo

| Modalidad propuesta | Alcance que debe acordarse | Soporte documental |
|---|---|---|
| Uso académico | Institución, usuarios, instalaciones, finalidad formativa, copias y duración. | Acuerdo del equipo y autorización institucional aplicable. |
| Uso institucional | Operación, responsables, datos, mantenimiento y actualización. | Términos de uso y responsabilidades de prestación. |
| Uso comercial | Distribución o servicio, precio, soporte, renovación y terminación. | Acuerdo comercial y verificación de los términos de cada dependencia y modelo. |
| Publicación del código | Repositorios y artefactos incluidos, permisos de uso y contribución. | Elección explícita de licencia y avisos por los titulares. |

La elección de modalidad debe identificar código propio, documentación, diseños, marca, dependencias, modelos e infraestructura. La autorización de un componente se determina por sus términos y por la distribución concreta.

## 4 Dependencias y licencias verificadas

La siguiente tabla identifica componentes principales y la fuente revisada. El package-lock fija versiones del cliente; requirements fija paquetes del servicio facial; pom.xml y el BOM fijan la API; Dockerfile fija el migrador. La tabla no sustituye el inventario completo de dependencias transitivas del artefacto instalado.

| Componente y versión de referencia | Licencia o condición identificada | Fuente |
|---|---|---|
| Expo 57.0.25; React 19.2.3; React Native 0.86.3 | MIT según metadatos del package-lock. Expo publica aviso MIT. | package-lock.json y [licencia de Expo](https://github.com/expo/expo/blob/main/LICENSE). |
| Human 3.3.6 | MIT para el código. Los activos o modelos se identifican con su propia procedencia. | package-lock.json y [aviso de Human](https://github.com/vladmandic/human/blob/main/LICENSE). |
| xlsx 0.18.5 | Apache-2.0 según la versión resuelta en package-lock. | package-lock.json, entrada node_modules/xlsx. |
| Spring Boot 3.4.1 | Apache-2.0. Sus dependencias mantienen sus avisos propios. | [Aviso de la versión 3.4.1](https://github.com/spring-projects/spring-boot/blob/v3.4.1/LICENSE.txt). |
| FastAPI 0.115.6 | MIT. | requirements.txt y [licencia de la versión](https://github.com/fastapi/fastapi/blob/0.115.6/LICENSE). |
| InsightFace 0.7.3 y buffalo_l | Código MIT; datos y modelos publicados por el proyecto con condición de investigación no comercial. | [Política oficial de InsightFace](https://github.com/deepinsight/insightface#license). |
| PostgreSQL 16 y pgvector | PostgreSQL License y aviso del proyecto pgvector. | [PostgreSQL](https://www.postgresql.org/about/licence/) y [pgvector](https://github.com/pgvector/pgvector/blob/master/LICENSE). |
| Liquibase operativo 5.0.2 | FSL-1.1-ALv2 según el aviso de esa versión. | [Licencia 5.0.2](https://github.com/liquibase/liquibase/blob/v5.0.2/LICENSE.txt) y Dockerfile del migrador. |
| Liquibase Core en la API | Versión 4.29.2 gestionada por Spring Boot 3.4.1; conservar el aviso del JAR resuelto. | pom.xml y [BOM 3.4.1](https://github.com/spring-projects/spring-boot/blob/v3.4.1/spring-boot-project/spring-boot-dependencies/build.gradle). |

La revisión de fuentes oficiales se realizó el 5 de noviembre de 2026. Los enlaces a una rama principal identifican la política consultada; la entrega debe conservar además el aviso y la versión exactos incluidos en su artefacto.

### 4 1 Código y modelos faciales

La configuración local de micro-facial selecciona buffalo_l y el worker carga los archivos de detección y reconocimiento de ese paquete. La política de InsightFace distingue el código MIT de los modelos preentrenados, incluidos los descargados automáticamente, que identifica para investigación no comercial. La misma fuente indica un canal de licenciamiento para los modelos de reconocimiento abiertos. Por ello, una propuesta comercial debe documentar los términos aplicables al modelo utilizado o seleccionar un modelo con autorización adecuada. Fuente: [política de licencia de InsightFace](https://github.com/deepinsight/insightface#license).

### 4 2 Versiones de Liquibase

El migrador operativo usa la imagen 5.0.2. Su aviso identifica FSL-1.1-ALv2 y contempla propósitos permitidos, redistribución y una licencia Apache futura a partir del segundo aniversario de publicación de cada versión. La biblioteca de la API procede del BOM 3.4.1 y usa 4.29.2. El nombre común Liquibase no determina una única licencia para ambas versiones. Fuentes: [aviso 5.0.2](https://github.com/liquibase/liquibase/blob/v5.0.2/LICENSE.txt) y [BOM de Spring Boot](https://github.com/spring-projects/spring-boot/blob/v3.4.1/spring-boot-project/spring-boot-dependencies/build.gradle).

### 4 3 Paquetes adicionales del servicio facial

| Paquete | Versión declarada |
|---|---|
| asyncpg | 0.30.0 |
| fastapi | 0.115.6 |
| insightface | 0.7.3 |
| mediapipe | 0.10.14 |
| numpy | 2.2.1 |
| onnxruntime | 1.20.1 |
| pydantic-settings | 2.7.1 |
| SQLAlchemy | 2.0.36 |
| uvicorn | 0.34.0 |

Los avisos de estos paquetes y de sus dependencias se obtienen del entorno construido. El registro de distribución debe asociar paquete, versión, licencia, origen y artefacto; también identifica modelos descargados e imágenes base. Esta edición no asigna a todos los componentes la licencia de FaceLit o la de FastAPI.

## 5 Costos y sostenimiento

Las cifras de la propuesta anterior carecen de cotización y alcance verificables para la configuración actual. Se sustituyen por los rubros y datos necesarios para una estimación. Esta edición no presenta los montos históricos como precio aprobado, factura ni costo real del proyecto.

| Rubro | Base de cálculo | Soporte requerido |
|---|---|---|
| VPS y alojamiento | Plan, periodo contratado, moneda, impuestos y renovación. | Factura o cotización fechada del proveedor. |
| Dominio | Registro y renovación por periodo. | Comprobante y fecha de vencimiento. |
| Respaldo y almacenamiento | Capacidad, retención, frecuencia y restauración. | Plan aprobado y precio del servicio. |
| Correo | Proveedor SMTP, volumen y condiciones del plan. | Cuenta o cotización con límites del servicio. |
| Hardware de captura | Cantidad, cámara o dispositivo, especificación y garantía. | Inventario y cotización por unidad. |
| Implementación | Horas por perfil multiplicadas por su tarifa. | Alcance, horas y tarifa aprobados. |
| Mantenimiento | Horas, soporte, actualización y periodo de atención. | Acuerdo de servicio con límites y entregables. |
| Licencias y modelos | Componentes que requieren autorización o pago específico. | Términos, autorización y oferta del titular. |

El costo inicial suma los rubros de una sola ejecución. El costo recurrente suma los rubros del mismo periodo; el anual se calcula con doce mensualidades y los cargos anuales aplicables, evitando duplicarlos. Precio de venta, margen y costo se registran como conceptos distintos. La fecha, moneda, impuestos y tipo de cambio se documentan junto al cálculo cuando correspondan.

## 6 Datos y condiciones de la entrega

La autorización de uso del software se documenta junto a la finalidad, responsables y tratamiento de los datos de su operación. Las decisiones DEC-02 a DEC-06 del SRS conservan los criterios de credenciales, referencia biométrica, dispositivos, operación y evaluación. La presencia de avisos o tablas de consentimiento en el código se describe con su evidencia; las aprobaciones institucionales se conservan con sus soportes.

Para una entrega reproducible se reúne el manifiesto, los commits base y ajustes, los digests, el inventario de dependencias y modelos y sus avisos. La configuración con secretos y los respaldos privados permanecen bajo control del responsable operativo.

## 7 Documentos relacionados

- [Inventario funcional y revisiones](../02-software-analysis/functional-inventory.md).
- [Seguimiento de decisiones del SRS](../01-requirements-specification/criteria-and-decisions.md).
- [SRS V4.1](../01-requirements-specification/requirements-specification.md).
- [Registro del despliegue desde main local](../06-implementation-procedure/hostinger-deployment.md).
- [Identidad visual y recursos de marca](../04-software-design/visual-identity.md).

Esta edición reemplaza la presentación anterior de MMV y sus escenarios económicos como ficha vigente de consulta. La propuesta académica de modalidad dual queda identificada en la sección 3, sin atribuirle una aprobación que no consta en la documentación revisada.
