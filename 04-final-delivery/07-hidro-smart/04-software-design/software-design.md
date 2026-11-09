> **Estado y alcance.** Borrador de diseño con contenido histórico y objetivos de arquitectura. Las funciones enumeradas no se consideran implementadas solo por aparecer aquí. Para el comportamiento contrastado con código, consulta el corte técnico al final del documento, el [índice de entrega](../README.md) y el [índice de entrega](../README.md).

<strong>Hidro Smart</strong>

<strong> Informe de diseño de software</strong>





Emerson Calet Molano Cardozo

José Alejandro Montealegre Rodríguez

José David Amaya Mosquera





Instructor

José de Jesús Motta Vargas





Servicio Nacional de Aprendizaje - SENA

Análisis y Desarrollo de Software - ADSO

Ficha - 3145555

2026

<strong>Resumen</strong>

Este documento conserva el diseño objetivo de Hidro Smart: arquitectura, módulos, modelo de datos, diagramas UML e interfaces planteadas durante el proyecto. La lista de funciones y tecnologías describe ese diseño y no certifica que cada elemento esté implementado o desplegado. El corte técnico al final separa las capacidades contrastadas con PT_HS de las propuestas aún no verificadas. El producto contempla clientes web y móvil, un backend Node.js, PostgreSQL y un dispositivo IoT basado en ESP32.

<strong>Palabras clave: Consumo de agua, IoT, React, Vite, Node.js, sostenibilidad, alertas inteligentes, arquitectura hexagonal, event-driven.</strong>















<strong>Contenido del documento</strong>

- Introducción y descripción general
- Arquitectura, componentes y flujos de datos
- Diagramas del sistema
- Diseño de base de datos e interfaces
- Reglas de negocio y seguridad
- Especificaciones técnicas, implementación y pruebas
- Corte de implementación PT_HS de 2026


Introducción

El presente documento constituye el Informe de Diseño de Software del proyecto Hidro Smart, desarrollado como parte del Tecnólogo en Análisis y Desarrollo de Software del Servicio Nacional de Aprendizaje (SENA), ficha 3145555.

Propósito del documento: registrar el diseño objetivo elaborado a partir de los requisitos disponibles en su momento y mantener trazabilidad para la revisión del equipo. Este documento es una referencia de diseño; la implementación vigente se determina con el corte técnico al final y con el código identificado en el índice de entrega. No reemplaza el SRS ni constituye aprobación formal.

<p> Construcción de la base de datos (PostgreSQL).</p>
<p> Desarrollo del frontend (React + Vite).</p>
<p> Implementación del backend (Node.js + Express).</p>
<p> Codificación de la lógica de negocio (Arquitectura Hexagonal, Casos de Uso).</p>
<p> Integración de dispositivos IoT (MQTT).</p>
<p> Realización de pruebas funcionales y no funcionales.</p>
El documento organiza los objetivos y decisiones de diseño para facilitar su revisión. La trazabilidad y el grado de implementación de cada requisito deben verificarse contra la matriz de requisitos y el código del corte identificado.




<strong>Alcance funcional descrito en el diseño original</strong>

<strong>Hidro Smart es una solución tecnológica compuesta por un medidor inteligente de agua (basado en ESP32) conectado mediante MQTT, con perfil Flespi/TLS en el firmware y Mosquitto sin TLS reservado a desarrollo, además de un cliente web React/Vite y un cliente móvil Expo/React Native. El sistema permite a los usuarios domésticos:</strong>

<p><strong>Nota:</strong> La lista siguiente reúne objetivos funcionales del diseño fuente; no demuestra que todas las funciones estén disponibles en el corte de código. Para lo implementado y sus límites, consulta el corte técnico al final del documento.</p>

<p> Monitorear el consumo de agua en tiempo real con polling HTTP; WebSockets no verificado.</p>
<p> Clasificar el consumo por actividades (ducha, lavado, aseo, cocina, etc.).</p>
<p> Recibir alertas automáticas por consumo excesivo, fugas o desconexión de dispositivos.</p>
<p> Generar recomendaciones personalizadas de ahorro.</p>
<p> Configurar topes de consumo, idioma, moneda y temas visuales.</p>
<p> Exportar reportes en PDF y Excel.</p>
<p> Gestionar hogares (proyectos) y dispositivos IoT.</p>
<p> Activar modo vacaciones para suspender notificaciones no críticas.</p>
<p> Establecer metas de ahorro y presupuesto mensual.</p>
<p> Solicitar soporte técnico a través de un sistema de tickets.</p>
<p> Consultar historial de conectividad de dispositivos (señal, batería, voltaje, temperatura).</p>
<p> Eliminar su cuenta de forma autónoma (derecho al olvido).</p>
Quedan fuera del alcance inicial: integración con sistemas externos de acueductos públicos y la versión nativa para iOS (se prioriza web responsiva).


<strong>Definiciones y términos</strong>

<table>
<tr>
<td><p>T&#233;rmino</p></td>
<td><p>Definici&#243;n</p></td>
</tr>
<tr>
<td><p><strong>IoT</strong></p></td>
<td><p>Internet of Things: red de dispositivos f&#237;sicos (medidores de agua)   conectados a internet que env&#237;an datos de consumo en tiempo real.</p></td>
</tr>
<tr>
<td><p><strong>ESP32</strong></p></td>
<td><p>Microcontrolador con Wi-Fi y Bluetooth usado como medidor </p><p>inteligente.</p></td>
</tr>
<tr>
<td><p><strong>Hogar/Proyecto</strong></p></td>
<td><p>Entidad que agrupa usuarios, dispositivos y configuraciones de </p><p>consumo dentro del sistema.</p></td>
</tr>
<tr>
<td><p><strong>Estrato socioecon&#243;mico</strong></p></td>
<td><p>Clasificaci&#243;n usada para establecer valores base de referencia de </p><p>consumo (1 a 6).</p></td>
</tr>
<tr>
<td><p><strong>Token Access/</strong><strong>Refresh</strong></p></td>
<td><p>Mecanismos de autenticaci&#243;n JWT para gestionar sesiones seguras.</p></td>
</tr>
<tr>
<td><p><strong>Lectura</strong></p></td>
<td><p>Registro individual de caudal y consumo enviado por el dispositivo</p><p> IoT.</p></td>
</tr>
<tr>
<td><p><strong>Alerta</strong></p></td>
<td><p>Notificaci&#243;n autom&#225;tica generada cuando se supera un tope </p><p>configurado o se detecta una anomal&#237;a.</p></td>
</tr>
<tr>
<td><p><strong>DTO</strong></p></td>
<td><p>Data Transfer Object: objeto que estructura datos entre capas.</p></td>
</tr>
<tr>
<td><p><strong>Event</strong><strong> Bus</strong></p></td>
<td><p>Sistema de comunicaci&#243;n as&#237;ncrona basada en eventos (publicador/suscriptor).</p></td>
</tr>
<tr>
<td><p><strong>Circuit</strong><strong> Breaker</strong></p></td>
<td><p>Patr&#243;n de tolerancia a fallos que evita llamadas a servicios ca&#237;dos.</p></td>
</tr>
<tr>
<td><p><strong>Vite</strong></p></td>
<td><p>Bundler ultrarr&#225;pido para aplicaciones web modernas.</p></td>
</tr>
<tr>
<td><p><strong>React</strong></p></td>
<td><p>Biblioteca de JavaScript para construir interfaces de usuario </p><p>basadas en componentes.</p></td>
</tr>
</table>


<strong>Referencias de documentos relacionados</strong>

<p>Los enlaces a carpetas externas provienen del documento fuente; su acceso y correspondencia con esta versión no están verificados. Los diagramas, el modelo conceptual y el wireframe incluidos en esta entrega se enlazan desde sus secciones locales.</p>

•    Amaya Mosquera, J. D., Molano Cardozo, E. C. &amp; Montealegre Rodríguez, J. A. (2025). Diseño conceptual y arquitectura de información. SENA. 

[<u>https://docs.google.com/document/d/17hTIQJPkeWehn6jrOAQP1H1r6Msdb9L4/edit?usp=sharing&ouid=104764955911282672379&rtpof=true&sd=true </u>](https://docs.google.com/document/d/17hTIQJPkeWehn6jrOAQP1H1r6Msdb9L4/edit?usp=sharing&ouid=104764955911282672379&rtpof=true&sd=true )

•    Motta Vargas, J. de J. (2025). Acta General del Proceso del Proyecto Hidro Smart. SENA.

[<u>https://docs.google.com/document/d/13iGF7gaDVy-dOP79u6Z-OnCX5z0ehyoI/edit?usp=sharing&ouid=104764955911282672379&rtpof=true&sd=true</u>](https://docs.google.com/document/d/13iGF7gaDVy-dOP79u6Z-OnCX5z0ehyoI/edit?usp=sharing&ouid=104764955911282672379&rtpof=true&sd=true)

•    Amaya Mosquera, J. D. et al. (2026). Encuesta sobre el Consumo de Agua – Hidro Smart \[Formulario Google\].

[<u>https://forms.gle/er5mLrWgxdPGptHL9</u>](https://forms.gle/er5mLrWgxdPGptHL9)

•    Equipo Hidro Smart. (2026). Mapa de Procesos.

[<u>https://drive.google.com/file/d/1Qk7t0UY9O6Y6Bd9Mv4uM698XJJuXYITN/view?usp=sharing</u>](https://drive.google.com/file/d/1Qk7t0UY9O6Y6Bd9Mv4uM698XJJuXYITN/view?usp=sharing )

•    Equipo Hidro Smart. (2026). Modelo Entidad-Relación (MER).

[<u>https://drive.google.com/drive/folders/1fytOPior9VgV0fDioUFHEXnLBXPlkuI_?usp=sharing</u>](https://drive.google.com/drive/folders/1fytOPior9VgV0fDioUFHEXnLBXPlkuI_?usp=sharing)

•    Equipo Hidro Smart. (2026). Wireframes de Interfaz – Figma \[Prototipo web y móvil\].

[<u>https://drive.google.com/file/d/1-oivju5GncQboQu21cglUMguOfbN7KLJ/view?usp=sharing</u>](https://drive.google.com/file/d/1-oivju5GncQboQu21cglUMguOfbN7KLJ/view?usp=sharing)









Descripción general del sistema

<strong>Hidro Smart es un sistema inteligente diseñado para resolver el problema de la falta de visibilidad y control del consumo de agua en los hogares colombianos. Combina un medidor físico inteligente (IoT) con una aplicación web/móvil que procesa, analiza y presenta la información en tiempo real.</strong>

Diseñar e implementar una solución tecnológica que permita a los usuarios domésticos monitorear, controlar y optimizar su consumo diario de agua, proporcionando información detallada por actividad, alertas preventivas, herramientas de administración avanzada (modo vacaciones, metas, soporte) y recomendaciones prácticas para reducir el desperdicio y promover el uso responsable del recurso hídrico.

El sistema contempla tres tipos de usuarios principales:

<table>
<tr>
<td><p>Tipo de usuario</p></td>
<td><p>Tipo de usuario</p></td>
<td><p>Rol en el sistema</p></td>
</tr>
<tr>
<td><p><strong>Usuario dom&#233;stico</strong></p></td>
<td><p>Persona que utiliza la app para consultar su consumo, configurar topes, generar reportes, gestionar metas y solicitar soporte.</p></td>
<td><p>Visualiza datos de sus hogares, configura topes, genera reportes, gestiona dispositivos y metas.</p></td>
</tr>
<tr>
<td><p><strong>Administrador</strong></p></td>
<td><p>Personal autorizado que supervisa hogares, usuarios y dispositivos.</p></td>
<td><p>Puede crear/suspender cuentas, revisar auditor&#237;as, gestionar configuraciones globales.</p></td>
</tr>
<tr>
<td><p><strong>Soporte T&#233;cnico</strong></p></td>
<td><p>T&#233;cnico IoT que realiza mantenimiento, calibraciones y soporte de conectividad.</p></td>
<td><p>Accede a gesti&#243;n de dispositivos, historial de conectividad y tickets de soporte, pero no a datos personales de usuarios.</p></td>
</tr>
</table>


El sistema se organiza en los siguientes módulos principales:

<table>
<tr>
<td><p>M&#243;dulo</p></td>
<td><p>Funci&#243;n principal</p></td>
</tr>
<tr>
<td><p>RF1 — Autenticaci&#243;n y seguridad</p></td>
<td><p>Registro, login JWT, roles, recuperaci&#243;n de contrase&#241;a, actualizaci&#243;n de perfil, suspensi&#243;n de cuentas, eliminaci&#243;n de cuenta propia (soft delete).</p></td>
</tr>
<tr>
<td><p>RF2 — Gesti&#243;n de dispositivos IoT</p></td>
<td><p>Registro, calibraci&#243;n (factor K y offset), suspensi&#243;n, reactivaci&#243;n, desvinculaci&#243;n, umbral de alerta por dispositivo, historial de conectividad.</p></td>
</tr>
<tr>
<td><p>RF3 — Gesti&#243;n de hogares</p></td>
<td><p>Creaci&#243;n de hogares, estratificaci&#243;n, asignaci&#243;n de titular y miembros, vinculaci&#243;n de dispositivos, suspensi&#243;n y reactivaci&#243;n.</p></td>
</tr>
<tr>
<td><p>RF4 — Configuraciones del sistema</p></td>
<td><p>Topes de consumo, alertas personalizadas, recomendaciones, idioma/moneda, temas visuales, auditor&#237;a, modo vacaciones.</p></td>
</tr>
<tr>
<td><p>RF5 — Reportes y an&#225;lisis</p></td>
<td><p>Gr&#225;ficos en tiempo real (polling HTTP; WebSockets no verificado), hist&#243;ricos, modelo predictivo, alertas, exportaci&#243;n PDF/Excel, h&#225;bitos de consumo, metas de ahorro, soporte t&#233;cnico (tickets).</p></td>
</tr>
</table>


Hidro Smart opera en un entorno doméstico conectado. 

El flujo principal es el siguiente:

<p>1\. El ESP32 envía datos de caudal por MQTT; Mosquitto local sirve para desarrollo y el perfil externo Flespi usa TLS en 8883. La ACL y el token del entorno deben verificarse.</p>
<p>2\. El backend (Node.js) recibe las lecturas, las procesa (aplica calibración, calcula costo) y las almacena en PostgreSQL.</p>
<p>3\. El frontend React/Vite se comunica con el backend mediante API REST; el corte actual refleja datos mediante polling HTTP y no verifica push en tiempo real.[](https://socket.io/)</p>
<p>4\. El usuario interactúa desde su navegador o dispositivo móvil para ver dashboards, configurar alertas, gestionar metas, activar modo vacaciones, etc.</p>
<p>5\. El backend integra correos transaccionales con Brevo para los flujos conectados; FCM, SMS y el envío de alertas por correo no deben suponerse activos sin disparadores verificados.</p>













Arquitectura del software

Tipo de Arquitectura

Se adopta una Arquitectura Hexagonal (Puertos y Adaptadores) con enfoque Domain-Driven Design (DDD), combinada con Event-Driven para comunicación asíncrona y CQRS básico (resúmenes precalculados). El sistema es stateless para permitir escalado horizontal.

<strong>Características principales de la arquitectura elegida</strong>

<table>
<tr>
<td><p><strong>Caracter&#237;stica</strong></p></td>
<td><p><strong>Descripci&#243;n</strong></p></td>
<td><p><strong>Beneficio para Hidro Smart</strong></p></td>
</tr>
<tr>
<td><p><strong>Arquitectura Hexagonal</strong></p></td>
<td><p>A&#237;sla la l&#243;gica de negocio (dominio) de los detalles externos (BD, HTTP, MQTT, etc.) mediante puertos y adaptadores.</p></td>
<td><p>Permite cambiar de base de datos, framework o proveedor de servicios sin afectar la l&#243;gica de negocio.</p></td>
</tr>
<tr>
<td><p><strong>Domain-Driven</strong><strong>Design</strong><strong> (DDD)</strong></p></td>
<td><p>Se enfoca en el dominio del problema (usuarios, hogares, dispositivos, lecturas, alertas) como n&#250;cleo del sistema.</p></td>
<td><p>Garantiza que las reglas de negocio est&#233;n en el centro y sean independientes de la infraestructura.</p></td>
</tr>
<tr>
<td><p><strong>Event-Driven</strong></p></td>
<td><p>Utiliza un Event Bus (mecanismo as&#237;ncrono no verificado) para comunicaci&#243;n as&#237;ncrona entre m&#243;dulos.</p></td>
<td><p>Desacopla la ingesta MQTT de las alertas y notificaciones, mejorando la resiliencia y el rendimiento.</p></td>
</tr>
<tr>
<td><p><strong>CQRS b&#225;sico</strong></p></td>
<td><p>Separa las operaciones de escritura (transaccionales) de las de lectura (res&#250;menes precalculados).</p></td>
<td><p>Las consultas de reportes y gr&#225;ficos son r&#225;pidas porque usan tablas de resumen, mientras que las escrituras mantienen la integridad transaccional.</p></td>
</tr>
<tr>
<td><p><strong>Stateless</strong></p></td>
<td><p>La autenticación web usa cookies HttpOnly con CSRF y sesiones JWT; Redis/blacklist no está verificado como parte del stack activo.</p></td>
<td><p>Permite escalar horizontalmente agregando m&#250;ltiples instancias sin conflictos.</p></td>
</tr>
</table>


Arquitectura en Capas

<table>
<tr>
<td><p>Capa</p></td>
<td><p>Descripci&#243;n</p></td>
<td><p>Tecnolog&#237;as principales</p></td>
<td><p>Responsabilidad</p></td>
</tr>
<tr>
<td><p>Capa de Presentaci&#243;n</p></td>
<td><p>Interfaz de usuario web/m&#243;vil responsiva.</p></td>
<td><p>React 18+, Vite, Tailwind CSS</p></td>
<td><p>Renderizado de la UI, interacci&#243;n con el usuario, validaciones en cliente.</p></td>
</tr>
<tr>
<td><p>Capa de Aplicaci&#243;n (Casos de Uso)</p></td>
<td><p>Orquestaci&#243;n de la l&#243;gica de negocio. Cada caso de uso es una clase independiente.</p></td>
<td><p>Node.js, Express</p></td>
<td><p>Contiene la l&#243;gica de negocio espec&#237;fica de cada funcionalidad, independiente de la infraestructura.</p></td>
</tr>
<tr>
<td><p>Capa de Dominio</p></td>
<td><p>Entidades, objetos de valor y reglas de negocio puras.</p></td>
<td><p>JavaScript/TypeScript (clases puras)</p></td>
<td><p>Representa el coraz&#243;n del negocio: Usuario, Hogar, Dispositivo, Lectura, Alerta, etc.</p></td>
</tr>
<tr>
<td><p>Capa de Infraestructura</p></td>
<td><p>Adaptadores concretos: repositorios PostgreSQL, servicios externos (Firebase, AWS SES, Redis no verificado), cliente MQTT.</p></td>
<td><p>PostgreSQL como persistencia activa; Redis, Bull, AWS SDK y Firebase Admin son opciones del diseño no verificadas como dependencias activas.</p></td>
<td><p>Implementa los puertos definidos en la capa de aplicaci&#243;n y dominio (ej. IUserRepository, INotificationService).</p></td>
</tr>
<tr>
<td><p>Capa de Infraestructura</p></td>
<td><p>Comunicaci&#243;n con los medidores v&#237;a MQTT. </p></td>
<td><p>Mosquitto/MQTT local; cloud no verificado, MQTT.js</p></td>
<td><p>Recibe telemetr&#237;a de los ESP32 y publica eventos en el Event Bus.</p></td>
</tr>
<tr>
<td><p>Capa de Eventos</p></td>
<td><p>Event Bus para comunicaci&#243;n as&#237;ncrona entre m&#243;dulos.</p></td>
<td><p>EventEmitter2 (desarrollo) / procesamiento as&#237;ncrono no verificado (producci&#243;n)</p></td>
<td><p>Desacopla la ingesta MQTT, el procesamiento de alertas y el env&#237;o de notificaciones.</p></td>
</tr>
</table>


Flujo general de datos





El flujo de datos sigue la siguiente secuencia:

ESP32 → (MQTT local) → Broker MQTT				↓                

Broker MQTT → (suscripción) → Backend (MQTT Handler)    ↓

Backend → (Event Bus) → ReadingCreatedEvent            ↓

ReadingCreatedHandler → (consulta/escritura) → PostgreSQL 

(lectura, resúmenes)                            ↓

Backend → (polling HTTP; WebSockets no verificado + REST) → Frontend React

 (actualización en tiempo real)                    ↓

Frontend React → (configuración) → Backend (API REST)    ↓

Backend → Brevo API HTTPS → Usuario (correos de flujos conectados); FCM y SMS no verificados.


<strong>Flujo de petición HTTP (ej. crear hogar):</strong>

HTTP Request → Middleware Chain 

(Auth → Rate Limit → Validation → Audit)                ↓

CreateHomeUseCase.execute(request)                ↓

HomeRepository.save() (vía Unit of Work)                ↓

UnitOfWork.commit()                        ↓

HomeResponse (DTO)


<strong>Flujo de procesamiento asíncrono (ej. generar reporte):</strong>

HTTP Request → GenerateReportUseCase                ↓

Bull Queue (Redis no verificado) → Worker procesa → genera PDF/Excel	↓    

Guarda en S3 → Notifica al usuario vía FCM

<strong>Justificación de la arquitectura elegida</strong>

<table>
<tr>
<td><p><strong>Beneficio</strong></p></td>
<td><p><strong>Explicaci&#243;n</strong></p></td>
</tr>
<tr>
<td><p><strong>Separaci&#243;n de responsabilidades</strong></p></td>
<td><p>Cada capa es independiente, facilitando el mantenimiento y las pruebas.</p></td>
</tr>
<tr>
<td><p>Cada capa es independiente, facilitando el mantenimiento y las pruebas.</p></td>
<td><p>Stateless + colas (Bull/Redis no verificado) permiten escalar horizontalmente agregando instancias.</p></td>
</tr>
<tr>
<td><p><strong>Tiempo real</strong></p></td>
<td><p>El cliente usa polling HTTP; no hay medición reproducible que demuestre latencia inferior a 3 segundos.</p></td>
</tr>
<tr>
<td><p><strong>Seguridad</strong></p></td>
<td><p>Cifrado TLS/HTTPS en todas las comunicaciones, JWT con refresh token, RLS en PostgreSQL.</p></td>
</tr>
<tr>
<td><p><strong>Tolerancia a fallos</strong></p></td>
<td><p>Circuit Breaker + Retry Pattern evitan que fallos externos degraden el sistema.</p></td>
</tr>
<tr>
<td><p><strong>Desacoplamiento</strong></p></td>
<td><p>Event Bus desacopla la ingesta MQTT de las alertas/notificaciones, mejorando la resiliencia.</p></td>
</tr>
<tr>
<td><p><strong>Mantenibilidad</strong></p></td>
<td><p>La arquitectura hexagonal facilita cambios de tecnolog&#237;a (BD, servicios externos) sin tocar la l&#243;gica de negocio.</p></td>
</tr>
</table>


<strong>Patrones de Diseño Aplicados</strong>

<table>
<tr>
<td><p><strong>Patr&#243;n</strong></p></td>
<td><p><strong>Patr&#243;n</strong></p></td>
<td><p><strong>Aplicaci&#243;n en Hidro Smart</strong></p></td>
</tr>
<tr>
<td><p><strong>Arquitectura Hexagonal (Puertos y Adaptadores)</strong></p></td>
<td><p>A&#237;sla la l&#243;gica de negocio de los detalles externos (BD, HTTP, MQTT, etc.).</p></td>
<td><p>El core (dominio + casos de uso) no depende de frameworks. Los adaptadores (repositorios, servicios externos) implementan puertos</p></td>
</tr>
<tr>
<td><p><strong>Event-Driven</strong><strong> (</strong><strong>Event</strong><strong> Bus)</strong></p></td>
<td><p>Desacopla m&#243;dulos mediante eventos as&#237;ncronos.</p></td>
<td><p>ReadingCreatedEvent → ReadingCreatedHandler eval&#250;a alertas. AlertTriggeredEvent → AlertTriggeredHandler env&#237;a notificaciones.</p></td>
</tr>
<tr>
<td><p><strong>Repository</strong><strong>Pattern</strong></p></td>
<td><p>Abstrae el acceso a datos.</p></td>
<td><p>PostgresUserRepository, PostgresHomeRepository, etc. implementan interfaces de repositorio.</p></td>
</tr>
<tr>
<td><p><strong>Service</strong><strong>Layer</strong><strong> (Casos de Uso)</strong></p></td>
<td><p>Contiene la l&#243;gica de negocio pura.</p></td>
<td><p>Cada caso de uso es una clase con un m&#233;todo execute(): RegisterUserUseCase, CreateHomeUseCase.</p></td>
</tr>
<tr>
<td><p><strong>DTO (Data Transfer Object)</strong></p></td>
<td><p>Estructura las respuestas de la API.</p></td>
<td><p>UserResponse, HomeResponse, DeviceResponse ocultan detalles internos de las entidades.</p></td>
</tr>
<tr>
<td><p><strong>Unit</strong><strong>of</strong><strong>Work</strong><strong> (</strong><strong>UoW</strong><strong>)</strong></p></td>
<td><p>Agrupa operaciones en una transacci&#243;n ACID.</p></td>
<td><p>PostgresUnitOfWork maneja begin(), commit(), rollback() para operaciones que afectan m&#250;ltiples tablas.</p></td>
</tr>
<tr>
<td><p><strong>Circuit</strong><strong> Breaker</strong></p></td>
<td><p>Tolerancia a fallos en servicios externos.</p></td>
<td><p>Patrón propuesto para servicios externos; FCM y AWS SES no se verifican como proveedores activos y el envío actual usa Brevo API HTTPS.</p></td>
</tr>
<tr>
<td><p><strong>Retry</strong><strong>Pattern</strong></p></td>
<td><p>Reintenta operaciones fallidas.</p></td>
<td><p>Backoff exponencial (1s, 2s, 4s) hasta 5 intentos para notificaciones.</p></td>
</tr>
<tr>
<td><p><strong>Component-Pattern</strong><strong> (</strong><strong>Frontend</strong><strong>)</strong></p></td>
<td><p>Separa componentes presentacionales de contenedores.</p></td>
<td><p>ConsumptionChart (presentacional) recibe datos por props; DashboardContainer maneja estado.</p></td>
</tr>
<tr>
<td><p><strong>Custom</strong><strong>Hooks</strong><strong> (</strong><strong>Frontend</strong><strong>)</strong></p></td>
<td><p>Encapsula l&#243;gica reutilizable.</p></td>
<td><p>useAuth, useWebSocket, useConsumption, useNotifications.</p></td>
</tr>
<tr>
<td><p><strong>Observer</strong><strong>Pattern</strong><strong> (</strong><strong>Frontend</strong><strong>)</strong></p></td>
<td><p>Actualizaci&#243;n en tiempo real.</p></td>
<td><p>El cliente consulta datos persistidos mediante polling HTTP; suscripciones WebSocket no verificadas.</p></td>
</tr>
</table>



Diseño de Componentes o Módulos

A continuación se describen los módulos principales del sistema Hidro Smart. Cada módulo incluye su nombre, descripción, entradas, procesos principales y salidas esperadas.

<table>
<tr>
<td><p>M&#243;dulo</p></td>
<td><p>Descripci&#243;n</p></td>
<td><p>Entradas</p></td>
<td><p>Procesos principales</p></td>
<td><p>Salidas</p></td>
</tr>
<tr>
<td><p>Autenticaci&#243;n y Usuarios (RF1)</p></td>
<td><p>Gestiona el registro, inicio de sesi&#243;n, roles, recuperaci&#243;n de contrase&#241;a, actualizaci&#243;n de perfil, suspensi&#243;n y eliminaci&#243;n de cuenta (soft delete) de los usuarios del sistema.</p></td>
<td><p>Correo electr&#243;nico, contrase&#241;a, datos personales, confirmaci&#243;n de eliminaci&#243;n.</p></td>
<td><p>Validaci&#243;n de credenciales, hash de contrase&#241;a con bcrypt (costo 12), generaci&#243;n de tokens JWT (Access + Refresh), asignaci&#243;n de roles (RBAC), bloqueo tras 5 intentos fallidos (15 min), env&#237;o de correo de recuperaci&#243;n (token expira en 1 hora), anonimizaci&#243;n de datos al eliminar cuenta, revocaci&#243;n de tokens.</p></td>
<td><p>Token de sesi&#243;n (Access + Refresh), perfil de usuario (DTO), mensajes de confirmaci&#243;n/error, correo de recuperaci&#243;n, confirmaci&#243;n de eliminaci&#243;n.</p></td>
</tr>
<tr>
<td><p>Gesti&#243;n de Dispositivos IoT (RF2)</p></td>
<td><p>Permite registrar, calibrar, suspender, reactivar, desvincular y consultar el historial de conectividad de los medidores inteligentes (ESP32) asociados al sistema.</p></td>
<td><p>C&#243;digo &#250;nico del dispositivo (MAC/UUID), nombre, tipo, ubicaci&#243;n, factor K, offset, umbral de alerta (m&#179;/h), rango de fechas para historial.</p></td>
<td><p>Validaci&#243;n de unicidad del c&#243;digo, asociaci&#243;n al hogar</p><p>en home_device, cambio de estado (activo/suspendido) con registro en device_history, almacenamiento de telemetr&#237;a en device_telemetry_history (se&#241;al, bater&#237;a, voltaje, temperatura), evaluaci&#243;n de umbral por dispositivo (prevalece sobre el del hogar), registro de calibraciones en calibration_history.</p></td>
<td><p>Dispositivo registrado, estado actualizado, historial de conectividad (JSON para gr&#225;ficos), confirmaci&#243;n de calibraci&#243;n, mensajes de error.</p></td>
</tr>
<tr>
<td><p>Gesti&#243;n de Hogares (Proyectos) (RF3)</p></td>
<td><p>Administra la creaci&#243;n, configuraci&#243;n, suspensi&#243;n y reactivaci&#243;n de hogares, as&#237; como la asignaci&#243;n de usuarios titulares y miembros con funciones especiales.</p></td>
<td><p>Nombre del hogar, direcci&#243;n, ciudad, estrato (1-6), usuarios titulares y miembros, funciones especiales.</p></td>
<td><p>Creaci&#243;n de hogar en home, asignaci&#243;n de titular (Owner) y miembros (Member/Guest) en home_user, configuraci&#243;n de estratificaci&#243;n y topes por defecto seg&#250;n estrato en home_rate y threshold_configuration, asignaci&#243;n de funciones especiales en home_user_function, suspensi&#243;n y reactivaci&#243;n con registro en audit_log.</p></td>
<td><p>Hogar creado, lista de usuarios asociados con roles, dispositivos vinculados, estado de suspensi&#243;n, confirmaci&#243;n de asignaci&#243;n.</p></td>
</tr>
<tr>
<td><p>Configuraciones del Sistema (RF4)</p></td>
<td><p>Permite personalizar alertas, topes de consumo, recomendaciones, idioma, moneda, temas visuales, auditor&#237;a y modo vacaciones.</p></td>
<td><p>Topes de consumo (diario/mensual), umbrales de alerta, idioma (es/en/pt/fr), moneda (COP/USD/EUR/MXN), tema (Light/Dark/High Contrast), fechas de modo vacaciones.</p></td>
<td><p>Validaci&#243;n de valores positivos, almacenamiento en threshold_configuration, alert_rule, user_preference y vacation_mode, activaci&#243;n de reglas de negocio, cambio de comportamiento de alertas durante modo vacaciones (solo severidad Alta o Cr&#237;tica), registro en audit_log.</p></td>
<td><p>Configuraci&#243;n guardada, alertas activadas seg&#250;n umbrales, preferencias aplicadas en frontend (React + Vite con i18n y Tailwind CSS), modo vacaciones activado/desactivado.</p></td>
</tr>
<tr>
<td><p>Monitoreo en Tiempo Real y Alertas (RF5)</p></td>
<td><p>Visualiza el consumo actual en tiempo real (polling HTTP; WebSockets no verificado), genera alertas autom&#225;ticas por consumo excesivo, fugas o desconexi&#243;n, y gestiona eventos de alerta.</p></td>
<td><p>Datos de caudal del dispositivo IoT (litros/segundo), m&#233;tricas de salud (se&#241;al, bater&#237;a, voltaje, temperatura), timestamp.</p></td>
<td><p>Procesamiento de lecturas con calibraci&#243;n (factor K y offset), clasificaci&#243;n por actividad (ducha, lavado, cocina, aseo, etc.), comparaci&#243;n con topes configurados (hogar y dispositivo), detecci&#243;n de fugas (flujo continuo &gt;30 min), generaci&#243;n de alerta en alert_event, almacenamiento en device_telemetry_history, env&#237;o de notificaciones push/email/SMS v&#237;a Event Bus y colas (Bull).</p></td>
<td><p>Consumo en tiempo real (polling HTTP; WebSockets no verificado), gr&#225;fico actualizado en frontend (React + recharts), notificaciones push (FCM) y correos electr&#243;nicos, registro de alerta en BD, historial de conectividad actualizado.</p></td>
</tr>
<tr>
<td><p>Reportes y An&#225;lisis (RF5)</p></td>
<td><p>Genera informes hist&#243;ricos, gr&#225;ficos comparativos, an&#225;lisis de h&#225;bitos de consumo, predicciones y exportaci&#243;n a PDF y Excel.</p></td>
<td><p>Rango de fechas, hogar seleccionado, tipo de reporte (diario, semanal, mensual, anual), formato de exportaci&#243;n (PDF/Excel).</p></td>
<td><p>Consulta de datos hist&#243;ricos desde sensor_reading, daily_consumption_summary, monthly_consumption_history, generaci&#243;n de gr&#225;ficos (recharts en frontend), c&#225;lculo de h&#225;bitos de consumo (horas pico, d&#237;as de mayor consumo), aplicaci&#243;n de modelo predictivo (media m&#243;vil simple o regresi&#243;n lineal), generaci&#243;n de archivos PDF (pdf-lib) y Excel (exceljs) de forma as&#237;ncrona (procesamiento as&#237;ncrono no verificado).</p></td>
<td><p>Reportes PDF/Excel descargables, gr&#225;ficos comparativos, h&#225;bitos de consumo, predicci&#243;n de consumo, an&#225;lisis de tendencias.</p></td>
</tr>
<tr>
<td><p>Metas y Presupuesto (RF5.7)</p></td>
<td><p>Permite al usuario definir metas de ahorro de agua (en m&#179;) y l&#237;mites de presupuesto (en COP) con seguimiento visual de progreso y proyecciones de fin de mes.</p></td>
<td><p>L&#237;mite de consumo (m&#179;), presupuesto m&#225;ximo (COP), per&#237;odo (mensual, semanal, anual), fecha de inicio y fin (opcional).</p></td>
<td><p>Inserci&#243;n/actualizaci&#243;n en saving_goal, c&#225;lculo de progreso (porcentaje usado) basado en consumo real vs meta, proyecci&#243;n de consumo final (con promedio diario), generaci&#243;n de alertas autom&#225;ticas al alcanzar el 80% y 90% del l&#237;mite, historial de metas anteriores (&#250;ltimos 6 meses).</p></td>
<td><p>Progreso actual (porcentaje), proyecci&#243;n de fin de mes, estado de cumplimiento (alcanzada/no alcanzada), historial de metas, alertas de proximidad al l&#237;mite.</p></td>
</tr>
<tr>
<td><p>Soporte T&#233;cnico (RF5.8)</p></td>
<td><p>Sistema de tickets para que los usuarios reporten incidencias o consultas t&#233;cnicas, y el equipo de soporte gestione su resoluci&#243;n.</p></td>
<td><p>T&#237;tulo, categor&#237;a (Dispositivo, Reportes, Tarifas, Detecci&#243;n, Otros), prioridad (Baja, Media, Alta), descripci&#243;n detallada, archivos adjuntos (opcional).</p></td>
<td><p>Inserci&#243;n en ticket con estado &#39;Abierto&#39;, actualizaci&#243;n de estado por soporte (En Proceso, Resuelto, Cerrado) en ticket, adici&#243;n de respuestas en ticket_response, notificaci&#243;n al usuario por correo/push cuando se responde o resuelve, archivado autom&#225;tico de tickets cerrados despu&#233;s de 30 d&#237;as, registro en audit_log.</p></td>
<td><p>Ticket creado con ID &#250;nico, historial de respuestas, estado de resoluci&#243;n, notificaciones al usuario, registro en auditor&#237;a.</p></td>
</tr>
<tr>
<td><p>Modo Vacaciones (RF4.7)</p></td>
<td><p>Suspende notificaciones de consumo normal y ajusta alertas a solo eventos cr&#237;ticos (fugas, desconexi&#243;n de dispositivos) durante la ausencia del usuario titular.</p></td>
<td><p>Fecha de inicio, fecha de fin, objetivo de consumo diario (opcional, en m&#179;), notificar al regreso (booleano).</p></td>
<td><p>Activaci&#243;n/desactivaci&#243;n en vacation_mode con active = true/false, cambio en el comportamiento de las reglas de alerta (solo se env&#237;an alertas de severidad &quot;Alta&quot; o &quot;Cr&#237;tica&quot;), desactivaci&#243;n autom&#225;tica al llegar la fecha de fin, registro en audit_log.</p></td>
<td><p>Estado del modo vacaciones (activo/inactivo), suspensi&#243;n de notificaciones no cr&#237;ticas, mantenimiento de alertas de seguridad, confirmaci&#243;n de activaci&#243;n/desactivaci&#243;n.</p></td>
</tr>
</table>


<strong>Diagramas del Sistema (UML)</strong>

Los diagramas editables y sus fuentes se incluyen en la carpeta local diagrams/. Son artefactos de diseño y no constituyen por sí mismos evidencia de ejecución física.

- Casos de uso: [diagrams/use-cases.md](diagrams/use-cases.md) y [diagrams/use-cases.drawio](diagrams/use-cases.drawio).
- Dominio: [diagrams/domain-diagram.md](diagrams/domain-diagram.md) y [diagrams/domain-diagram.drawio](diagrams/domain-diagram.drawio).
- Actividades: [diagrams/activity-diagrams.md](diagrams/activity-diagrams.md) y [diagrams/activity-diagrams.drawio](diagrams/activity-diagrams.drawio).
- Estado del dispositivo: [diagrams/device-state-diagram.md](diagrams/device-state-diagram.md) y [diagrams/device-state-diagram.drawio](diagrams/device-state-diagram.drawio).
- Secuencias: [diagrams/sequence-diagrams.md](diagrams/sequence-diagrams.md) y [diagrams/sequence-diagrams.drawio](diagrams/sequence-diagrams.drawio).
- Componentes: [diagrams/component-diagram.md](diagrams/component-diagram.md) y [diagrams/component-diagram.drawio](diagrams/component-diagram.drawio).
- Despliegue: [diagrams/deployment-diagram.md](diagrams/deployment-diagram.md) y [diagrams/deployment-diagram.drawio](diagrams/deployment-diagram.drawio).

<strong>Diseño de Base de Datos</strong>

El diseño fuente plantea un modelo relacional para organizar la información y aplicar restricciones de integridad. Esta descripción no acredita por sí sola la normalización completa ni la cobertura de requisitos; consulta las migraciones y el inventario estático incluidos en la entrega para el estado contrastado con el código.

Modelo Entidad - Relación

El modelo conceptual y sus límites se documentan en [entity-relationship.md](entity-relationship.md). La fuente editable del diagrama de dominio está en [domain-diagram.md](diagrams/domain-diagram.md) y [domain-diagram.drawio](diagrams/domain-diagram.drawio). No debe interpretarse como un esquema físico exhaustivo.

<pdf:nextpage />

Tablas conceptuales del diseño fuente (no confirman los nombres actuales de PostgreSQL)

<table>
<tr>
<td><p>Tabla</p></td>
<td><p>Descripci&#243;n</p></td>
</tr>
<tr>
<td><p>usuarios</p></td>
<td><p>Informaci&#243;n de todos los usuarios del sistema (dom&#233;sticos, administradores y soporte).</p></td>
</tr>
<tr>
<td><p>roles</p></td>
<td><p>Definici&#243;n de roles y permisos del sistema.</p></td>
</tr>
<tr>
<td><p>hogares</p></td>
<td><p>Entidad que representa cada hogar o proyecto registrado.</p></td>
</tr>
<tr>
<td><p>dispositivos</p></td>
<td><p>Registro de medidores inteligentes IoT.</p></td>
</tr>
<tr>
<td><p>lecturas (consumos)</p></td>
<td><p>Registro detallado de cada lectura de consumo enviada por los dispositivos.</p></td>
</tr>
<tr>
<td><p>alertas</p></td>
<td><p>Registro de todas las alertas generadas por el sistema.</p></td>
</tr>
<tr>
<td><p>recomendaciones</p></td>
<td><p>Sugerencias autom&#225;ticas de ahorro generadas seg&#250;n los h&#225;bitos.</p></td>
</tr>
<tr>
<td><p>auditorias</p></td>
<td><p>Bit&#225;cora completa de todas las acciones cr&#237;ticas realizadas por los usuarios.</p></td>
</tr>
<tr>
<td><p>estratos</p></td>
<td><p>Tabla de referencia para estratos socioecon&#243;micos y valores base.</p></td>
</tr>
<tr>
<td><p>usuarios_hogares</p></td>
<td><p>Relaci&#243;n muchos a muchos entre usuarios y hogares.</p></td>
</tr>
<tr>
<td><p>dispositivos_hogares</p></td>
<td><p>Relaci&#243;n muchos a muchos entre dispositivos y hogares.</p></td>
</tr>
</table>


Referencia de datos e inventario actual

El documento fuente llamaba a esta sección diccionario de datos completo. En esta entrega se incluye un inventario estático de esquemas y tablas, no un diccionario exhaustivo de columnas.

[Inventario estático de esquemas y tablas](database-schema-inventory.md). Este archivo no es un diccionario exhaustivo de columnas.














Diseño de Interfaces

El wireframe disponible para esta entrega está en [ui-wireframe.md](ui-wireframe.md) y [ui-wireframe.pdf](ui-wireframe.pdf). Debe cotejarse con la interfaz de la versión candidata; no se afirma aquí conformidad WCAG ni que coincida con todas las pantallas actuales.

Tecnologías Frontend (React + Vite)

Esta tabla conserva versiones y herramientas del diseño fuente; no representa las dependencias instaladas en el corte actual. Para verificarlas, consulta los manifiestos y lockfiles del código identificado.

<table>
<tr>
<td><p>Tecnolog&#237;a</p></td>
<td><p>Versi&#243;n</p></td>
<td><p>Prop&#243;sito</p></td>
</tr>
<tr>
<td><p>React</p></td>
<td><p>18.x</p></td>
<td><p>Biblioteca para construir la interfaz de usuario basada en componentes.</p></td>
</tr>
<tr>
<td><p>Vite</p></td>
<td><p>4.x</p></td>
<td><p>Bundler ultrarr&#225;pido para desarrollo y producci&#243;n (HMR, builds optimizados).</p></td>
</tr>
<tr>
<td><p>React Router</p></td>
<td><p>6.x</p></td>
<td><p>Enrutamiento de la aplicaci&#243;n (SPA con rutas protegidas).</p></td>
</tr>
<tr>
<td><p>Axios</p></td>
<td><p>1.x</p></td>
<td><p>Cliente HTTP con interceptores para manejo de tokens JWT.</p></td>
</tr>
<tr>
<td><p>Cliente HTTP con interceptores para manejo de tokens JWT.</p></td>
<td><p>4.x</p></td>
<td><p>Comunicaci&#243;n en tiempo real (polling HTTP; WebSockets no verificado) para actualizaci&#243;n del dashboard.</p></td>
</tr>
<tr>
<td><p>Tailwind CSS</p></td>
<td><p>3.x</p></td>
<td><p>Framework de CSS para estilos responsivos y personalizaci&#243;n r&#225;pida.</p></td>
</tr>
<tr>
<td><p>react-i18next</p></td>
<td><p>13.x</p></td>
<td><p>Internacionalizaci&#243;n (idiomas: es, en, pt, fr).</p></td>
</tr>
<tr>
<td><p>recharts</p></td>
<td><p>2.x</p></td>
<td><p>Librer&#237;a de gr&#225;ficos para dashboards y reportes.</p></td>
</tr>
<tr>
<td><p>react-hook-form + zod</p></td>
<td><p>7.x / 3.x</p></td>
<td><p>Manejo de formularios y validaci&#243;n de esquemas.</p></td>
</tr>
<tr>
<td><p>Workbox</p></td>
<td><p>7.x</p></td>
<td><p>Service Worker para PWA (modo offline parcial).</p></td>
</tr>
<tr>
<td><p>Vitest + React Testing Library</p></td>
<td><p>1.x / 14.x</p></td>
<td><p>Pruebas unitarias e integraci&#243;n de componentes.</p></td>
</tr>
</table>


<strong>Prototipos de pantallas principales</strong><strong>:</strong>

<strong> Autenticación y Seguridad (RF1)</strong>

<table>
<tr>
<td><p><strong>Nombre de pantalla</strong></p></td>
<td><p><strong>Descripci&#243;n</strong></p></td>
<td><p><strong>RF asociado</strong></p></td>
</tr>
<tr>
<td><p><strong>Login</strong></p></td>
<td><p><strong>Pantalla inicial con campos de correo electr&#243;nico y contrase&#241;a. Incluye enlace a &quot;&#191;Olvidaste tu contrase&#241;a?&quot; y bot&#243;n de inicio de sesi&#243;n.</strong></p></td>
<td><p><strong>RF1.2</strong></p></td>
</tr>
<tr>
<td><p><strong>Registro</strong></p></td>
<td><p><strong>Formulario con pesta&#241;a para crear cuenta. Campos: nombre completo, correo, contrase&#241;a, confirmaci&#243;n, tipo de documento y n&#250;mero de documento.</strong></p></td>
<td><p><strong>RF1.1</strong></p></td>
</tr>
<tr>
<td><p><strong>Recuperar Contrase&#241;a</strong></p></td>
<td><p><strong>Pantalla dedicada donde el usuario ingresa su correo y recibe un enlace temporal (v&#225;lido por 1 hora) para restablecer su contrase&#241;a.</strong></p></td>
<td><p><strong>RF1.3</strong></p></td>
</tr>
<tr>
<td><p><strong>Actualizar Perfil</strong></p></td>
<td><p><strong>Formulario para modificar datos personales: nombre, tel&#233;fono, ciudad y foto de perfil (opcional). Los cambios sensibles requieren verificaci&#243;n por correo.</strong></p></td>
<td><p><strong>RF1.4</strong></p></td>
</tr>
<tr>
<td><p><strong>Eliminar Cuenta</strong></p></td>
<td><p><strong>Pantalla en &quot;Configuraci&#243;n → Zona de Peligro&quot; con doble confirmaci&#243;n (</strong><strong>checkbox</strong><strong> y verificaci&#243;n de contrase&#241;a) para eliminar la cuenta de forma permanente (</strong><strong>soft</strong><strong>delete</strong><strong>).</strong></p></td>
<td><p><strong>RF1.6</strong></p></td>
</tr>
</table>


<strong>Gestión de Hogares (RF3)</strong>

<table>
<tr>
<td><p>Pantalla</p></td>
<td><p>Descripci&#243;n</p></td>
<td><p>RF asociado</p></td>
</tr>
<tr>
<td><p><strong>Mis Hogares</strong></p></td>
<td><p>Lista de hogares asociados al usuario, con informaci&#243;n resumida: nombre, direcci&#243;n, estrato, n&#250;mero de dispositivos, miembros y consumo del mes. Botones para editar, suspender y ver detalles.</p></td>
<td><p>RF3.1, RF3.4</p></td>
</tr>
<tr>
<td><p><strong>Crear Hogar</strong></p></td>
<td><p>Formulario para registrar un nuevo hogar: nombre, direcci&#243;n, ciudad, estrato (selector 1-6) y tope de consumo mensual (opcional).</p></td>
<td><p>RF3.1</p></td>
</tr>
<tr>
<td><p><strong>Detalle de Hogar</strong></p></td>
<td><p>Vista completa del hogar: informaci&#243;n general, lista de miembros con roles (Owner, Member, Guest), dispositivos vinculados, configuraci&#243;n de topes y modo vacaciones.</p></td>
<td><p>RF3.2, RF3.3</p></td>
</tr>
<tr>
<td><p><strong>Gestionar Miembros</strong></p></td>
<td><p>Pantalla para invitar nuevos miembros por correo electr&#243;nico, asignar roles (Member/Guest) y funciones especiales (ej. administrar dispositivos).</p></td>
<td><p>RF3.2.1, RF3.2.1.1</p></td>
</tr>
</table>


<strong>Gestión de Dispositivos </strong><strong>IoT</strong><strong> (RF2)</strong>

<table>
<tr>
<td><p>Pantalla</p></td>
<td><p>Descripci&#243;n</p></td>
<td><p>RF asociado</p></td>
</tr>
<tr>
<td><p><strong>Mis Dispositivos</strong></p></td>
<td><p>Lista de sensores IoT vinculados al hogar seleccionado. Cada tarjeta muestra: nombre, estado (activo/suspendido), bater&#237;a, se&#241;al, flujo actual y volumen total del d&#237;a. Botones para configurar, calibrar y desvincular.</p></td>
<td><p>RF2.1, RF2.2, RF2.4</p></td>
</tr>
<tr>
<td><p><strong>Registrar Dispositivo</strong></p></td>
<td><p>Formulario para vincular un nuevo medidor IoT: c&#243;digo &#250;nico (MAC/UUID), nombre descriptivo, tipo, ubicaci&#243;n y umbral de alerta (m&#179;/h, opcional).</p></td>
<td><p>RF2.1, RF2.5</p></td>
</tr>
<tr>
<td><p><strong>Calibrar Dispositivo</strong></p></td>
<td><p>Formulario para ajustar el factor de calibraci&#243;n (K) y offset del sensor. Requiere motivo de la calibraci&#243;n y solo est&#225; disponible para soporte t&#233;cnico o administradores.</p></td>
<td><p>RF2.3</p></td>
</tr>
<tr>
<td><p><strong>Historial de Conectividad</strong></p></td>
<td><p>Pantalla con gr&#225;fico (recharts) que muestra la evoluci&#243;n de la se&#241;al, bater&#237;a, voltaje y temperatura del dispositivo en un rango de fechas seleccionable (&#250;ltimos 7 d&#237;as, 30 d&#237;as, etc.).</p></td>
<td><p>RF2.6</p></td>
</tr>
</table>


<strong>Configuraciones del Sistema (RF4)</strong>

<table>
<tr>
<td><p>Pantalla</p></td>
<td><p>Descripci&#243;n</p></td>
<td><p>RF asociado</p></td>
</tr>
<tr>
<td><p><strong>Topes de Consumo</strong></p></td>
<td><p>Configuraci&#243;n de l&#237;mites m&#225;ximos de consumo (diario y mensual) para el hogar. Validaci&#243;n de valores positivos.</p></td>
<td><p>RF4.1</p></td>
</tr>
<tr>
<td><p><strong>Alertas</strong></p></td>
<td><p>Configuraci&#243;n de reglas de alerta personalizadas: tipo (consumo excesivo, fuga, tope mensual, etc.), umbral, unidad y activaci&#243;n.</p></td>
<td><p>RF4.2</p></td>
</tr>
<tr>
<td><p><strong>Recomendaciones</strong></p></td>
<td><p>Configuraci&#243;n de la generaci&#243;n autom&#225;tica de recomendaciones (activar/desactivar).</p></td>
<td><p>RF4.3</p></td>
</tr>
<tr>
<td><p><strong>Idioma y Moneda</strong></p></td>
<td><p>Selectores para cambiar el idioma (es, en, pt, fr) y la moneda (COP, USD, EUR, MXN).</p></td>
<td><p>RF4.4, RF4.4.1</p></td>
</tr>
<tr>
<td><p><strong>Temas Visuales</strong></p></td>
<td><p>Selecci&#243;n de tema (Light, Dark, High Contrast) con previsualizaci&#243;n en tiempo real.</p></td>
<td><p>RF4.5</p></td>
</tr>
<tr>
<td><p><strong>Auditor&#237;a</strong></p></td>
<td><p>Panel de consulta de logs de auditor&#237;a (solo administradores). Filtros por usuario, fecha y tipo de acci&#243;n.</p></td>
<td><p>RF4.6</p></td>
</tr>
<tr>
<td><p><strong>Modo Vacaciones</strong></p></td>
<td><p>Pantalla para activar/desactivar el modo vacaciones con selecci&#243;n de fechas de inicio y fin, objetivo de consumo diario (opcional) y opci&#243;n de notificar al regreso.</p></td>
<td><p>RF4.7</p></td>
</tr>
</table>


<strong>Monitoreo, Reportes y Análisis (RF5)</strong>

<table>
<tr>
<td><p>Pantalla</p></td>
<td><p>Descripci&#243;n</p></td>
<td><p>RF asociado</p></td>
</tr>
<tr>
<td><p><strong>Dashboard</strong><strong> (Inicio)</strong></p></td>
<td><p>Panel principal con: consumo actual en tiempo real (gauge), flujo actual (m&#179;/h), consumo del d&#237;a/semana/mes, alertas activas, estado de dispositivos y recomendaciones destacadas. Actualizaci&#243;n v&#237;a polling HTTP; WebSockets no verificado.</p></td>
<td><p>RF5.1.1, RF5.4, RF5.5</p></td>
</tr>
<tr>
<td><p><strong>Consumo en Tiempo Real</strong></p></td>
<td><p>Pantalla con gr&#225;fico de consumo en vivo (recharts) y desglose por actividad (ducha, lavado, cocina, aseo, etc.).</p></td>
<td><p>RF5.1.1</p></td>
</tr>
<tr>
<td><p><strong>Reportes y An&#225;lisis</strong></p></td>
<td><p>Selector de per&#237;odo (diario, semanal, mensual, anual), gr&#225;ficos comparativos (barras, l&#237;neas, circulares), an&#225;lisis de h&#225;bitos (horas pico, d&#237;as de mayor consumo), proyecci&#243;n de costos y botones de exportaci&#243;n a PDF y Excel.</p></td>
<td><p>RF5.1, RF5.2, RF5.3</p></td>
</tr>
<tr>
<td><p><strong>Metas y Presupuesto</strong></p></td>
<td><p>Configuraci&#243;n de metas de consumo (m&#179;) y presupuesto (COP) con seguimiento visual de progreso (barras de porcentaje), proyecci&#243;n de fin de mes e historial de metas anteriores.</p></td>
<td><p>RF5.7</p></td>
</tr>
<tr>
<td><p><strong>Notificaciones / Alertas</strong></p></td>
<td><p>Lista de eventos de alerta con filtros por estado (todas, no le&#237;das, le&#237;das, descartadas). Cada alerta muestra tipo, severidad, mensaje, valor detectado y fecha. Opci&#243;n de marcar como le&#237;da o descartada.</p></td>
<td><p>RF5.4</p></td>
</tr>
<tr>
<td><p><strong>Soporte T&#233;cnico</strong></p></td>
<td><p>Gesti&#243;n de tickets: listado con filtros (todos, abiertos, en proceso, cerrados), creaci&#243;n de nuevos tickets (t&#237;tulo, categor&#237;a, prioridad, descripci&#243;n, archivos adjuntos), visualizaci&#243;n de detalle y respuestas.</p></td>
<td><p>RF5.8</p></td>
</tr>
</table>


<strong>Formularios principales</strong>

<table>
<tr>
<td><p>Formulario</p></td>
<td><p>Campos</p></td>
<td><p>Validaciones</p></td>
<td><p>RF asociado</p></td>
</tr>
<tr>
<td><p><strong>Registro de usuario</strong></p></td>
<td><p>Nombre completo, correo electr&#243;nico, contrase&#241;a, confirmaci&#243;n, tipo de documento, n&#250;mero de documento.</p></td>
<td><p>Correo &#250;nico, contrase&#241;a ≥8 caracteres con may&#250;scula, min&#250;scula, n&#250;mero y s&#237;mbolo.</p></td>
<td><p>RF1.1</p></td>
</tr>
<tr>
<td><p><strong>Recuperaci&#243;n de contrase&#241;a</strong></p></td>
<td><p>Correo electr&#243;nico.</p></td>
<td><p>Correo registrado en el sistema (sin revelar si existe o no por seguridad).</p></td>
<td><p>RF1.3</p></td>
</tr>
<tr>
<td><p><strong>Actualizaci&#243;n de perfil</strong></p></td>
<td><p>Nombre completo, tel&#233;fono, ciudad, foto de perfil (opcional).</p></td>
<td><p>Tel&#233;fono con formato v&#225;lido, foto ≤2MB (JPG/PNG).</p></td>
<td><p>RF1.4</p></td>
</tr>
<tr>
<td><p><strong>Creaci&#243;n de hogar</strong></p></td>
<td><p>Nombre del hogar, direcci&#243;n, ciudad, estrato (1-6).</p></td>
<td><p>Nombre &#250;nico para el usuario, estrato entre 1 y 6.</p></td>
<td><p>RF3.1</p></td>
</tr>
<tr>
<td><p><strong>Vinculaci&#243;n de dispositivo</strong></p></td>
<td><p>C&#243;digo &#250;nico (MAC/UUID), nombre, tipo, ubicaci&#243;n, umbral de alerta (opcional).</p></td>
<td><p>C&#243;digo &#250;nico en el sistema, umbral &gt; 0 (si se define).</p></td>
<td><p>RF2.1, RF2.5</p></td>
</tr>
<tr>
<td><p><strong>Calibraci&#243;n de dispositivo</strong></p></td>
<td><p>Factor K, offset, motivo de calibraci&#243;n.</p></td>
<td><p>Factor K &gt; 0, motivo obligatorio.</p></td>
<td><p>RF2.3</p></td>
</tr>
<tr>
<td><p><strong>Configuraci&#243;n de alertas</strong></p></td>
<td><p>Tipo de alerta, umbral, unidad, activa/inactiva.</p></td>
<td><p>Umbral &gt; 0, unidad coherente con el tipo.</p></td>
<td><p>RF4.2</p></td>
</tr>
<tr>
<td><p><strong>Modo vacaciones</strong></p></td>
<td><p>Fecha de inicio, fecha de fin, objetivo de consumo diario (opcional), notificar al regreso.</p></td>
<td><p>Fecha de fin ≥ fecha de inicio, objetivo ≥ 0 (si se define).</p></td>
<td><p>RF4.7</p></td>
</tr>
<tr>
<td><p><strong>Meta de ahorro</strong></p></td>
<td><p>L&#237;mite de consumo (m&#179;), presupuesto (COP), per&#237;odo (mensual/semanal/anual).</p></td>
<td><p>L&#237;mite &gt; 0, presupuesto &gt; 0.</p></td>
<td><p>RF5.7</p></td>
</tr>
<tr>
<td><p><strong>Creaci&#243;n de ticket</strong></p></td>
<td><p>T&#237;tulo, categor&#237;a, prioridad, descripci&#243;n, archivos adjuntos (opcional).</p></td>
<td><p>T&#237;tulo y descripci&#243;n obligatorios, categor&#237;a y prioridad predefinidas.</p></td>
<td><p>RF5.8</p></td>
</tr>
</table>


<strong>Menús y navegación (</strong><strong>React</strong><strong>Router</strong><strong>)</strong>

<table>
<tr>
<td><p>Elemento</p></td>
<td><p>Descripci&#243;n</p></td>
<td><p>Rutas asociadas</p></td>
</tr>
<tr>
<td><p><strong>Men&#250; lateral (Drawer)</strong></p></td>
<td><p>Navegaci&#243;n principal para versiones de escritorio y tabletas.</p></td>
<td><p>/, /homes, /devices, /reports,</p><p> /goals, /notifications, /support, /settings</p></td>
</tr>
<tr>
<td><p><strong>Men&#250; inferior (Bottom </strong><strong>Navigation</strong><strong>)</strong></p></td>
<td><p>Navegaci&#243;n para dispositivos m&#243;viles (pantallas peque&#241;as).</p></td>
<td><p>Inicio, Hogares, Dispositivos, Reportes, Configuraci&#243;n</p></td>
</tr>
<tr>
<td><p><strong>Acceso r&#225;pido a Alertas</strong></p></td>
<td><p>Icono de campana en el header, visible desde cualquier pantalla.</p></td>
<td><p>/notifications</p></td>
</tr>
<tr>
<td><p><strong>Perfil de usuario</strong></p></td>
<td><p>Acceso desde el men&#250; lateral o avatar en el header.</p></td>
<td><p>/settings/profile</p></td>
</tr>
<tr>
<td><p><strong>Panel de administraci&#243;n</strong></p></td>
<td><p>Solo visible para usuarios con rol &quot;Administrador&quot; o &quot;Soporte T&#233;cnico&quot;.</p></td>
<td><p>/admin/* (auditor&#237;a, gesti&#243;n de usuarios, etc.)</p></td>
</tr>
</table>



Flujo de navegación principal:

<p>1\. <strong>Login → Dashboard (redirección tras autenticación exitosa).</strong></p>
<p>2\. <strong>Dashboard → Menú lateral/inferior → Cualquier pantalla (Hogares / Dispositivos / Reportes / Metas / Soporte / Configuración).</strong></p>
<p>3\. Desde cualquier pantalla → Acceso rápido a Alertas (icono de campana en el header).</p>
<p>4\. <strong>Rutas protegidas: Todas las rutas excepto /login, /register, /forgot-password, /reset-password requieren autenticación (middleware de React Router).</strong></p>
Estilo y diseño visual

<table>
<tr>
<td><p>Aspecto</p></td>
<td><p>Descripci&#243;n</p></td>
</tr>
<tr>
<td><p><strong>Paleta de colores</strong></p></td>
<td><p>Colores institucionales (azules y verdes) que transmiten confianza, sostenibilidad y tecnolog&#237;a.</p></td>
</tr>
<tr>
<td><p><strong>Tipograf&#237;a</strong></p></td>
<td><p>Fuente sans-serif (Inter o Roboto) para legibilidad en pantallas.</p></td>
</tr>
<tr>
<td><p><strong>Responsividad</strong></p></td>
<td><p>Dise&#241;o mobile-first con Tailwind CSS. Adaptaci&#243;n a resoluciones desde 320px (m&#243;viles) hasta 1920px (escritorio).</p></td>
</tr>
<tr>
<td><p><strong>Accesibilidad</strong></p></td>
<td><p>Cumplimiento de WCAG 2.1 nivel AA: contraste ≥ 4.5:1, navegaci&#243;n por teclado, etiquetas ARIA, texto alternativo en im&#225;genes.</p></td>
</tr>
<tr>
<td><p><strong>Temas</strong></p></td>
<td><p>Soporte para modo claro, oscuro y alto contraste, con persistencia en user_preference.</p></td>
</tr>
<tr>
<td><p><strong>Feedback</strong><strong> visual</strong></p></td>
<td><p>Animaciones suaves, estados de carga (Skeleton o Spinner), notificaciones tipo Toast/SnackBar para confirmaciones y errores.</p></td>
</tr>
</table>


Reglas de negocio

Las reglas de negocio definen las condiciones, restricciones y políticas que debe cumplir el sistema Hidro Smart para garantizar su correcto funcionamiento, integridad de datos y cumplimiento de los requerimientos funcionales establecidos en el SRS v1.1 (RF1 a RF11).

A continuación se detallan las reglas principales, organizadas por módulos funcionales:





<strong>Reglas de Autenticación y Seguridad (RF1)</strong>

<table>
<tr>
<td><p>#</p></td>
<td><p>Regla</p></td>
<td><p>Descripci&#243;n</p></td>
</tr>
<tr>
<td><p>1</p></td>
<td><p>Unicidad de identidad</p></td>
<td><p>Un usuario no puede registrarse con un correo electr&#243;nico o n&#250;mero de documento ya existente en el sistema.</p></td>
</tr>
<tr>
<td><p>2</p></td>
<td><p>Contrase&#241;a segura</p></td>
<td><p>La contrase&#241;a debe tener m&#237;nimo 8 caracteres e incluir al menos una may&#250;scula, una min&#250;scula, un n&#250;mero y un s&#237;mbolo; se almacena siempre cifrada en la base de datos (bcrypt, costo 12).</p></td>
</tr>
<tr>
<td><p>3</p></td>
<td><p>Bloqueo por intentos fallidos</p></td>
<td><p>Tras 5 intentos fallidos de inicio de sesi&#243;n consecutivos, la cuenta se bloquea temporalmente por 15 minutos.</p></td>
</tr>
<tr>
<td><p>4</p></td>
<td><p>Recuperaci&#243;n de contrase&#241;a</p></td>
<td><p>El enlace de recuperaci&#243;n de contrase&#241;a es v&#225;lido &#250;nicamente por 1 hora y es de un solo uso.</p></td>
</tr>
<tr>
<td><p>5</p></td>
<td><p>Eliminaci&#243;n de cuenta (soft delete)</p></td>
<td><p>Al eliminar una cuenta, los datos personales se anonimizan y todos los tokens JWT son revocados. El historial de consumo se conserva anonimizado para estad&#237;sticas.</p></td>
</tr>
<tr>
<td><p>6</p></td>
<td><p>Actualizaci&#243;n de perfil</p></td>
<td><p>Los cambios en informaci&#243;n sensible requieren verificaci&#243;n por correo electr&#243;nico antes de ser aplicados.</p></td>
</tr>
</table>






Reglas de Gestión de Hogares (RF3)

<table>
<tr>
<td><p>#</p></td>
<td><p>Regla</p></td>
<td><p>Descripci&#243;n</p></td>
</tr>
<tr>
<td><p>7</p></td>
<td><p>Titular &#250;nico por hogar</p></td>
<td><p>Solo puede existir un usuario titular (Owner) por hogar; los dem&#225;s miembros pueden tener roles Member o Guest.</p></td>
</tr>
<tr>
<td><p>8</p></td>
<td><p>Asignaci&#243;n de miembros</p></td>
<td><p>Un usuario solo puede ser invitado a un hogar si ya est&#225; registrado. No se permiten duplicados en la relaci&#243;n usuario-hogar.</p></td>
</tr>
<tr>
<td><p>9</p></td>
<td><p>Suspensi&#243;n de hogar</p></td>
<td><p>Un hogar suspendido no genera alertas ni notificaciones hasta ser reactivado. Las lecturas contin&#250;an almacen&#225;ndose.</p></td>
</tr>
<tr>
<td><p>10</p></td>
<td><p>Reactivaci&#243;n de hogar</p></td>
<td><p>Un hogar suspendido solo puede ser reactivado por el titular o un administrador.</p></td>
</tr>
</table>


Reglas de Gestión de Dispositivos IoT (RF2)

<table>
<tr>
<td><p>#</p></td>
<td><p>Regla</p></td>
<td><p>Descripci&#243;n</p></td>
</tr>
<tr>
<td><p>11</p></td>
<td><p>C&#243;digo &#250;nico de dispositivo</p></td>
<td><p>El c&#243;digo identificador (MAC/UUID) de cada dispositivo IoT debe ser &#250;nico en todo el sistema.</p></td>
</tr>
<tr>
<td><p>12</p></td>
<td><p>Vinculaci&#243;n exclusiva</p></td>
<td><p>Un dispositivo IoT solo puede estar vinculado a un &#250;nico hogar al mismo tiempo.</p></td>
</tr>
<tr>
<td><p>13</p></td>
<td><p>Registro condicional de lecturas</p></td>
<td><p>El consumo solo se registra si el dispositivo est&#225; activo y el hogar no est&#225; suspendido.</p></td>
</tr>
<tr>
<td><p>14</p></td>
<td><p>Calibraci&#243;n restringida</p></td>
<td><p>La calibraci&#243;n solo puede ser realizada por usuarios con rol Soporte T&#233;cnico o Administrador.</p></td>
</tr>
<tr>
<td><p>15</p></td>
<td><p>Umbral por dispositivo</p></td>
<td><p>El umbral individual del dispositivo prevalece sobre el umbral del hogar; si no existe, se aplica el del hogar o el valor por defecto seg&#250;n estrato.</p></td>
</tr>
<tr>
<td><p>16</p></td>
<td><p>Desvinculaci&#243;n de dispositivo</p></td>
<td><p>Un dispositivo puede desvincularse de un hogar y ser reasignado posteriormente conservando su historial.</p></td>
</tr>
</table>


Reglas de Configuraciones del Sistema (RF4)

<table>
<tr>
<td><p>#</p></td>
<td><p>Regla</p></td>
<td><p>Descripci&#243;n</p></td>
</tr>
<tr>
<td><p>17</p></td>
<td><p>Consistencia de topes</p></td>
<td><p>Los topes de consumo deben ser positivos y al menos uno (diario o mensual) debe estar definido.</p></td>
</tr>
<tr>
<td><p>18</p></td>
<td><p>Reglas de alerta activas</p></td>
<td><p>Solo las reglas marcadas como activas generan eventos de alerta.</p></td>
</tr>
<tr>
<td><p>19</p></td>
<td><p>Modo vacaciones</p></td>
<td><p>Durante el modo vacaciones solo se notifican alertas cr&#237;ticas o altas; el modo se desactiva autom&#225;ticamente al finalizar el per&#237;odo.</p></td>
</tr>
<tr>
<td><p>20</p></td>
<td><p>Auditor&#237;a obligatoria</p></td>
<td><p>Toda acci&#243;n cr&#237;tica debe registrarse en la tabla audit_log.</p></td>
</tr>
</table>


Reglas de Monitoreo, Alertas y Reportes (RF5)

<table>
<tr>
<td><p>#</p></td>
<td><p>Regla</p></td>
<td><p>Descripci&#243;n</p></td>
</tr>
<tr>
<td><p>21</p></td>
<td><p>Generaci&#243;n de alertas</p></td>
<td><p>Se genera una alerta cuando el consumo supera el tope en ≥10%, se detecta flujo continuo por m&#225;s de 30 minutos o un sensor permanece sin enviar datos durante m&#225;s de una hora.</p></td>
</tr>
<tr>
<td><p>22</p></td>
<td><p>Acceso a reportes</p></td>
<td><p>Los reportes solo pueden generarse para hogares asociados al usuario autenticado.</p></td>
</tr>
<tr>
<td><p>23</p></td>
<td><p>Recomendaciones personalizadas</p></td>
<td><p>Las recomendaciones se generan con datos hist&#243;ricos reales y no se repiten antes de 7 d&#237;as. Se ejecutan diariamente a las 6:00 AM.</p></td>
</tr>
<tr>
<td><p>24</p></td>
<td><p>Metas de ahorro</p></td>
<td><p>Se generan alertas al alcanzar el 80% y 90% de la meta de ahorro. La proyecci&#243;n mensual utiliza el promedio de consumo de los &#250;ltimos siete d&#237;as.</p></td>
</tr>
<tr>
<td><p>25</p></td>
<td><p>Historial de conectividad</p></td>
<td><p>El historial de se&#241;al, bater&#237;a, voltaje y temperatura se conserva durante al menos 30 d&#237;as.</p></td>
</tr>
<tr>
<td><p>26</p></td>
<td><p>Reportes as&#237;ncronos</p></td>
<td><p>La generaci&#243;n de reportes PDF/Excel se realiza mediante mecanismos as&#237;ncronos no verificados para evitar bloquear la API.</p></td>
</tr>
</table>


Reglas de Soporte Técnico (RF5.8)

<table>
<tr>
<td><p>#</p></td>
<td><p>Regla</p></td>
<td><p>Descripci&#243;n</p></td>
</tr>
<tr>
<td><p>27</p></td>
<td><p>Categor&#237;as y prioridades</p></td>
<td><p>Los tickets deben tener una categor&#237;a y una prioridad predefinidas.</p></td>
</tr>
<tr>
<td><p>28</p></td>
<td><p>Gesti&#243;n de estados</p></td>
<td><p>Los estados v&#225;lidos son: Abierto, En Proceso, Resuelto y Cerrado. Solo soporte o administradores pueden modificarlos.</p></td>
</tr>
<tr>
<td><p>29</p></td>
<td><p>Archivado autom&#225;tico</p></td>
<td><p>Los tickets cerrados se archivan autom&#225;ticamente tras 30 d&#237;as sin actividad.</p></td>
</tr>
<tr>
<td><p>30</p></td>
<td><p>Notificaciones de tickets</p></td>
<td><p>El usuario recibe una notificaci&#243;n cuando su ticket es respondido o cambia a Resuelto o Cerrado.</p></td>
</tr>
</table>







Reglas Transversales de Seguridad y Operación

<table>
<tr>
<td><p>#</p></td>
<td><p>Regla</p></td>
<td><p>Descripci&#243;n</p></td>
</tr>
<tr>
<td><p>31</p></td>
<td><p>Protecci&#243;n de datos personales</p></td>
<td><p>El tratamiento de datos cumple con la Ley 1581 de 2012. El usuario debe otorgar consentimiento y puede ejercer sus derechos ARCO.</p></td>
</tr>
<tr>
<td><p>32</p></td>
<td><p>Tolerancia a fallos</p></td>
<td><p>Los servicios externos implementan Circuit Breaker y Retry Pattern. Tras tres fallos consecutivos se abre el circuito durante 30 segundos y se registra el evento.</p></td>
</tr>
<tr>
<td><p>33</p></td>
<td><p>Procesamiento as&#237;ncrono</p></td>
<td><p>Las tareas pesadas se ejecutan mediante mecanismos as&#237;ncronos no verificados para mantener tiempos de respuesta inferiores a 500 ms.</p></td>
</tr>
<tr>
<td><p>34</p></td>
<td><p>Escalabilidad horizontal</p></td>
<td><p>Las sesiones web usan cookies HttpOnly y CSRF; Redis no se verifica como servicio activo. La escalabilidad horizontal no se afirma sin pruebas de carga.</p></td>
</tr>
</table>


Aplicación de las Reglas

<table>
<tr>
<td><p>Capa</p></td>
<td><p>Mecanismo de aplicaci&#243;n</p></td>
</tr>
<tr>
<td><p>Frontend (React + Vite)</p></td>
<td><p>Validaciones en formularios con react-hook-form y zod, mensajes de error en tiempo real y deshabilitaci&#243;n de botones en acciones cr&#237;ticas.</p></td>
</tr>
<tr>
<td><p>Backend (Node.js)</p></td>
<td><p>Validaciones con express-validator, l&#243;gica de negocio en arquitectura hexagonal y manejo estandarizado de excepciones HTTP.</p></td>
</tr>
<tr>
<td><p>Base de datos (PostgreSQL)</p></td>
<td><p>Restricciones NOT NULL, UNIQUE, CHECK, llaves for&#225;neas, triggers para updated_at y validaciones adicionales.</p></td>
</tr>
<tr>
<td><p>Auditor&#237;a</p></td>
<td><p>Middleware que registra acciones cr&#237;ticas en audit_log con usuario, IP, user-agent y valores anteriores y nuevos.</p></td>
</tr>
</table>




Seguridad del Sistema


<strong>Seguridad del Sistema</strong>


El sistema Hidro Smart implementa múltiples capas de seguridad para proteger la información de los usuarios, garantizar la integridad de los datos y cumplir con la normativa colombiana (Ley 1581 de 2012) y estándares internacionales (ISO/IEC 27001). Los mecanismos de protección se aplican en todas las capas del sistema (frontend, backend y base de datos).


<strong> Autenticación</strong>

La API usa JWT para access y refresh; en la web se transportan mediante cookies HttpOnly y las solicitudes mutables con cookie requieren X-CSRF-Token. Las duraciones y atributos de cookie dependen del entorno y deben leerse de su configuración vigente.

El cliente web renueva la sesión mediante el cliente HTTP documentado y el backend permite revocar sesiones. Redis/blacklist no está verificado como mecanismo activo.

La autenticación de dos factores (2FA) está prevista para versiones futuras, utilizando TOTP vía Google Authenticator o SMS. La estructura de la base de datos ya incluye la tabla user\_mfa para este propósito. Además, se implementa un bloqueo temporal de cuenta durante 15 minutos después de 5 intentos fallidos consecutivos, y el contador se reinicia tras un inicio de sesión exitoso.


<strong>Autorización (RBAC)</strong>

Se implementa RBAC (Role-Based Access Control) con tres roles principales. El Usuario doméstico tiene permisos de CRUD sobre sus propios hogares y dispositivos, consulta de reportes, configuración de alertas y topes, gestión de metas, modo vacaciones, tickets de soporte, actualización de perfil y eliminación de cuenta propia. El Administrador tiene permisos de CRUD sobre todos los hogares, usuarios y dispositivos; acceso a auditorías (audit\_log); suspensión y reactivación de cuentas; gestión de roles y permisos; y configuración global del sistema. El Soporte Técnico tiene permisos para gestionar dispositivos (calibración, suspensión, reactivación), consultar el historial de conectividad y gestionar tickets de soporte, pero no tiene acceso a datos personales de usuarios ni a configuración de hogares.

Cada endpoint de la API verifica el token JWT y el rol mediante middleware (auth.middleware.js y role.middleware.js). Además, las políticas de acceso se aplican también a nivel de base de datos mediante RLS (Row Level Security) en PostgreSQL.


<strong>Control de acceso</strong>

Todas las rutas sensibles están protegidas por middleware de autenticación. Las rutas públicas son solo /login, /register, /forgot-password y /reset-password. El control de acceso basado en el hogar garantiza que un usuario solo pueda ver y modificar los datos de los hogares a los que está vinculado (Owner, Member o Guest). Esto se aplica en la capa de servicio (casos de uso) y se refuerza con RLS en PostgreSQL.

Se implementa un límite de 100 solicitudes por minuto por usuario (basado en IP o token JWT) para prevenir ataques de fuerza bruta y DDoS. Además, se registra en la tabla audit\_log toda acción crítica: quién (usuario), qué (acción), cuándo (timestamp), desde qué IP (source\_ip) y qué valores cambiaron (old\_value y new\_value en JSONB).


<strong> Protección de datos</strong>

La web/API publicada se comunica mediante HTTPS; el perfil externo del ESP32 usa MQTT/TLS con Flespi y el Mosquitto local queda para desarrollo sin TLS. El cifrado en reposo y la configuración de cada proveedor dependen de su servicio y no se afirman sin evidencia.

El frontend web usa cookies HttpOnly para la sesión y CSRF en operaciones mutables; Bearer se conserva como compatibilidad. La protección frente a inyección y el almacenamiento de credenciales se detallan en la documentación vigente del backend.

Las copias de seguridad se realizan automáticamente a diario, se cifran con AES-256 y se almacenan en almacenamiento externo no verificado con acceso restringido. El sistema cumple con la Ley 1581 de 2012 (protección de datos personales en Colombia), donde el usuario debe dar consentimiento explícito (user\_consent) y puede ejercer sus derechos ARCO (acceso, rectificación, cancelación, oposición, portabilidad) a través del módulo correspondiente.

Además, al eliminar una cuenta (RF1.6), los datos personales se anonimizan: el nombre se reemplaza por "Usuario eliminado", el correo por deleted\_{id}@hidrosmart.com y el documento por 0000000000. El historial de consumo se conserva anonimizado para estadísticas agregadas


<strong> Manejo de contraseñas</strong>

Las contraseñas nunca se almacenan en texto plano. Se utiliza bcrypt con factor de costo 12 para generar el hash. Se aplican reglas de complejidad según la password\_policy definida: mínimo 8 caracteres, al menos una mayúscula, una minúscula, un número y un símbolo.

La recuperación de contraseña se realiza mediante un enlace temporal enviado al correo electrónico, válido por 1 hora. El enlace contiene un token de un solo uso almacenado en password\_reset\_token. Además, se ofrece la opción de cambio obligatorio de contraseña en el primer inicio de sesión (si fue generada por el administrador) y no se permite reutilizar las últimas 5 contraseñas (opcional, según política de seguridad).


<strong> Tolerancia a fallos y resiliencia</strong>

El sistema implementa Circuit Breaker con la librería opossum para servicios externos como servicio de notificaciones no verificado, envío de emails y SMS. Si un servicio falla 3 veces consecutivas, se "abre" el circuito y se omite la llamada por 30 segundos, registrando el evento en log\_error. También se aplica el Retry Pattern: las operaciones fallidas (envío de notificaciones, sincronización con servicios externos) se reintentan con backoff exponencial (1s, 2s, 4s, hasta 5 intentos).

Las tareas que pueden fallar (envío de emails, notificaciones push, generación de reportes) se procesan de forma asíncrona mediante mecanismos asíncronos no verificados para no bloquear la API principal. Además, se implementa un middleware global de errores en Express que captura excepciones, las registra en log\_error y devuelve respuestas HTTP estandarizadas (400, 401, 403, 404, 500) sin exponer stack traces en producción.

<strong>9.7 Seguridad en el </strong><strong>frontend</strong><strong> (</strong><strong>React</strong><strong> + Vite)</strong>

La web utiliza cookies HttpOnly y protección CSRF para solicitudes mutables; el atributo SameSite y demás parámetros los define el entorno. Todos los formularios validan las entradas del usuario tanto en el frontend (con react-hook-form + zod) como en el backend (con express-validator). Las entradas del usuario se sanitizan para prevenir XSS (Cross-Site Scripting) usando librerías como DOMPurify en el frontend y validator en el backend. Además, se implementa Content Security Policy (CSP) para restringir la ejecución de scripts no autorizados y la aplicación se sirve siempre a través de HTTPS, redirigiendo automáticamente HTTP a HTTPS.


<strong>Resumen de mecanismos por capa</strong>

En el cliente web, la sesión usa cookies HttpOnly con CSRF y la aplicación publicada usa HTTPS. Para librerías y controles restantes, consulta las dependencias y configuración del frontend del corte técnico.

En el backend (Node.js) , se utilizan JWT con Access/Refresh tokens, bcrypt (costo 12), middleware de autenticación y roles, rate limiting, Circuit Breaker, Retry Pattern, procesamiento asíncrono con mecanismos asíncronos no verificados, manejo centralizado de errores y logs en log\_error.

En la base de datos (PostgreSQL) , se aplica cifrado en reposo (AES-256), RLS (Row Level Security), consultas parametrizadas (prepared statements), restricciones de integridad (NOT NULL, UNIQUE, CHECK) y backups cifrados diarios.

La infraestructura web publicada usa HTTPS; Mosquitto local no tiene TLS y es exclusivo de desarrollo. El ESP32 ofrece Flespi/TLS; los tokens/ACL remotos, backups y recuperación deben validarse en sus respectivos entornos. Redis no está verificado como servicio activo.



Especificaciones Técnicas

A continuación, se detallan las tecnologías seleccionadas para el desarrollo de Hidro Smart, garantizando alto rendimiento, escalabilidad, seguridad y facilidad de mantenimiento.

<table>
<tr>
<td><p>Componente</p></td>
<td><p>Tecnolog&#237;a utilizada</p></td>
<td><p>Versi&#243;n</p></td>
<td><p>Prop&#243;sito / Justificaci&#243;n</p></td>
</tr>
<tr>
<td><p>Frontend</p></td>
<td><p>React + Vite</p></td>
<td><p>18.x / 4.x</p></td>
<td><p>Biblioteca para construir interfaces de usuario basadas en componentes. Vite como bundler ultrarr&#225;pido con HMR y builds optimizados.</p></td>
</tr>
<tr>
<td><p>Enrutamiento</p></td>
<td><p>React Router</p></td>
<td><p>6.x</p></td>
<td><p>Navegaci&#243;n SPA con rutas protegidas y lazy loading.</p></td>
</tr>
<tr>
<td><p>Cliente HTTP</p></td>
<td><p>Axios</p></td>
<td><p>1.x</p></td>
<td><p>Cliente HTTP con interceptores para manejo de tokens JWT y renovaci&#243;n autom&#225;tica.</p></td>
</tr>
<tr>
<td><p>polling HTTP; WebSockets no verificado</p></td>
<td><p>cliente HTTP</p></td>
<td><p>4.x</p></td>
<td><p>Comunicaci&#243;n bidireccional en tiempo real para actualizaci&#243;n del dashboard.</p></td>
</tr>
<tr>
<td><p>Estilos</p></td>
<td><p>Tailwind CSS</p></td>
<td><p>3.x</p></td>
<td><p>Framework de CSS para dise&#241;o responsivo, personalizable y mobile-first.</p></td>
</tr>
<tr>
<td><p>Internacionalizaci&#243;n</p></td>
<td><p>react-i18next</p></td>
<td><p>13.x</p></td>
<td><p>Soporte para m&#250;ltiples idiomas (es, en, pt, fr) con traducciones din&#225;micas.</p></td>
</tr>
<tr>
<td><p>Gr&#225;ficos</p></td>
<td><p>recharts</p></td>
<td><p>2.x</p></td>
<td><p>Librer&#237;a de gr&#225;ficos para dashboards y reportes (barras, l&#237;neas, circulares).</p></td>
</tr>
<tr>
<td><p>Formularios y validaci&#243;n</p></td>
<td><p>react-hook-form + zod</p></td>
<td><p>7.x / 3.x</p></td>
<td><p>Manejo eficiente de formularios y validaci&#243;n de esquemas con tipos.</p></td>
</tr>
<tr>
<td><p>PWA (Offline)</p></td>
<td><p>Workbox</p></td>
<td><p>7.x</p></td>
<td><p>Service Worker para modo offline parcial y cach&#233; de recursos est&#225;ticos.</p></td>
</tr>
<tr>
<td><p>Pruebas frontend</p></td>
<td><p>Vitest + React Testing Library</p></td>
<td><p>1.x / 14.x</p></td>
<td><p>Pruebas unitarias e integraci&#243;n de componentes y hooks.</p></td>
</tr>
<tr>
<td><p>Backend</p></td>
<td><p>Node.js + Express</p></td>
<td><p>18 LTS / 4.x</p></td>
<td><p>Entorno JavaScript as&#237;ncrono, ideal para tiempo real y m&#250;ltiples conexiones IoT. Express como framework web ligero y flexible.</p></td>
</tr>
<tr>
<td><p>Arquitectura</p></td>
<td><p>Hexagonal (Puertos y Adaptadores) + DDD</p></td>
<td><p>-</p></td>
<td><p>Separa el n&#250;cleo (dominio + casos de uso) de los detalles externos (BD, HTTP, MQTT). Facilita pruebas y mantenimiento.</p></td>
</tr>
<tr>
<td><p>polling HTTP; WebSockets no verificado (backend)</p></td>
<td><p>WebSocket push no verificado</p></td>
<td><p>4.x</p></td>
<td><p>Comunicaci&#243;n bidireccional en tiempo real con el frontend.</p></td>
</tr>
<tr>
<td><p>Base de datos</p></td>
<td><p>PostgreSQL</p></td>
<td><p>15+</p></td>
<td><p>Relacional robusta, soporte JSONB, RLS (Row Level Security), licencia gratuita.</p></td>
</tr>
<tr>
<td><p>Cliente BD</p></td>
<td><p>pg</p></td>
<td><p>8.x</p></td>
<td><p>Cliente para Node.js con consultas parametrizadas (prepared statements).</p></td>
</tr>
<tr>
<td><p>Comunicaci&#243;n IoT</p></td>
<td><p>Mosquitto local para desarrollo; Flespi/TLS como perfil externo del firmware.</p></td>
<td><p>2.0 / -</p></td>
<td><p>Protocolo ligero y eficiente para dispositivos de bajo consumo (ESP32). TLS para seguridad.</p></td>
</tr>
<tr>
<td><p>Colas y procesamiento as&#237;ncrono</p></td>
<td><p>procesamiento as&#237;ncrono no verificado</p></td>
<td><p>4.x / 7.x</p></td>
<td><p>Procesamiento de tareas pesadas (reportes, notificaciones) en segundo plano sin bloquear la API.</p></td>
</tr>
<tr>
<td><p>Circuit Breaker</p></td>
<td><p>opossum</p></td>
<td><p>8.x</p></td>
<td><p>Tolerancia a fallos en servicios externos (Firebase, emails, SMS).</p></td>
</tr>
<tr>
<td><p>Autenticaci&#243;n</p></td>
<td><p>JWT (jsonwebtoken) + bcrypt</p></td>
<td><p>9.x / 5.x</p></td>
<td><p>Autenticaci&#243;n stateless con Access/Refresh tokens. Hash de contrase&#241;as con bcrypt (costo 12).</p></td>
</tr>
<tr>
<td><p>Logging</p></td>
<td><p>winston</p></td>
<td><p>3.x</p></td>
<td><p>Logs estructurados en archivos y consola (niveles: error, warn, info, debug).</p></td>
</tr>
<tr>
<td><p>Validaci&#243;n</p></td>
<td><p>express-validator + Joi</p></td>
<td><p>7.x / 17.x</p></td>
<td><p>Validaci&#243;n de datos de entrada en controladores y casos de uso.</p></td>
</tr>
<tr>
<td><p>Pruebas backend</p></td>
<td><p>Jest + Supertest</p></td>
<td><p>29.x</p></td>
<td><p>Pruebas unitarias e integraci&#243;n de API.</p></td>
</tr>
<tr>
<td><p>Notificaciones push</p></td>
<td><p>servicio de notificaciones no verificado (FCM)</p></td>
<td><p>API v1</p></td>
<td><p>Entrega instant&#225;nea y confiable de alertas a dispositivos m&#243;viles.</p></td>
</tr>
<tr>
<td><p>Generaci&#243;n de reportes</p></td>
<td><p>pdf-lib + exceljs</p></td>
<td><p>&#218;ltimas</p></td>
<td><p>Exportaci&#243;n nativa a PDF y Excel desde el backend.</p></td>
</tr>
<tr>
<td><p>Control de versiones</p></td>
<td><p>Git + GitHub</p></td>
<td><p>-</p></td>
<td><p>Control de cambios, ramas, pull requests e integraci&#243;n continua.</p></td>
</tr>
<tr>
<td><p>Entorno de desarrollo</p></td>
<td><p>Visual Studio Code</p></td>
<td><p>&#218;ltimo</p></td>
<td><p>Editor con integraci&#243;n Git, depuraci&#243;n y extensiones para React y Node.js.</p></td>
</tr>
<tr>
<td><p>Despliegue backend</p></td>
<td><p>Railway / Render</p></td>
<td><p>-</p></td>
<td><p>Despliegue escalable con integraci&#243;n continua.</p></td>
</tr>
<tr>
<td><p>Despliegue frontend</p></td>
<td><p>Vercel / Netlify</p></td>
<td><p>-</p></td>
<td><p>Hosting optimizado para aplicaciones React.</p></td>
</tr>
<tr>
<td><p>Distribuci&#243;n m&#243;vil</p></td>
<td><p>Google Play Console</p></td>
<td><p>-</p></td>
<td><p>Publicaci&#243;n oficial de la PWA como aplicaci&#243;n Android.</p></td>
</tr>
<tr>
<td><p>CI/CD</p></td>
<td><p>GitHub Actions</p></td>
<td><p>-</p></td>
<td><p>Automatizaci&#243;n de pruebas, linting y despliegues.</p></td>
</tr>
</table>


<strong>Consideraciones de Implementación</strong>

Esta sección describe los aspectos prácticos y técnicos que se tendrán en cuenta durante la fase de construcción del sistema Hidro Smart, con el fin de garantizar calidad, mantenibilidad, seguridad y cumplimiento de los estándares del SENA.



<strong>Estándares de codificación</strong>

<table>
<tr>
<td><p>Capa</p></td>
<td><p>Est&#225;ndar</p></td>
<td><p>Herramientas</p></td>
<td><p>Detalles  </p></td>
</tr>
<tr>
<td><p><strong>Frontend</strong><strong> (</strong><strong>React</strong><strong> + Vite)</strong></p></td>
<td><p>ESLint + Prettier</p></td>
<td><p>ESLint (configuraci&#243;n recomendada React), Prettier</p></td>
<td><p>camelCase para variables/funciones, PascalCase para componentes/hooks. JSDoc para funciones complejas. Estructura por dominios funcionales.</p></td>
</tr>
<tr>
<td><p><strong>Backend</strong><strong> (Node.js)</strong></p></td>
<td><p>ESLint + Prettier</p></td>
<td><p>ESLint (Airbnb), Prettier</p></td>
<td><p>camelCase para variables/funciones, PascalCase para clases, UPPER_SNAKE_CASE para constantes. JSDoc para funciones p&#250;blicas. Arquitectura hexagonal.</p></td>
</tr>
<tr>
<td><p><strong>Base de datos (PostgreSQL)</strong></p></td>
<td><p>snake_case</p></td>
<td><p>-</p></td>
<td><p>snake_case para tablas y columnas. PK: id_nombre (ej. user_account_id). FK: fk_tabla_origen_tabla_destino. &#205;ndices para claves for&#225;neas y columnas de b&#250;squeda frecuente. COMMENT en tablas y funciones.</p></td>
</tr>
<tr>
<td><p><strong>Git (</strong><strong>Commits</strong><strong>)</strong></p></td>
<td><p>Conventional Commits</p></td>
<td><p>-</p></td>
<td><p>Formato: tipo(&#225;mbito): descripci&#243;n. Tipos: feat, fix, docs, style, refactor, test, chore. Commits at&#243;micos y descriptivos.</p></td>
</tr>
</table>


Manejo de errores

<table>
<tr>
<td><p>Capa</p></td>
<td><p>Mecanismo</p></td>
<td><p>Herramientas</p></td>
<td><p>Detalles</p></td>
</tr>
<tr>
<td><p>Backend</p></td>
<td><p>Centralizado + Middleware global</p></td>
<td><p>AppError (clase), Winston, Middleware de errores</p></td>
<td><p>Respuestas HTTP estandarizadas { success: false, message, error }. Logs en logs/error.log y logs/combined.log. Stack traces solo en desarrollo. Registro en log_error.</p></td>
</tr>
<tr>
<td><p>Frontend</p></td>
<td><p>Error Boundaries + Try-catch</p></td>
<td><p>React Error Boundaries, SnackBars/Toasts</p></td>
<td><p>Captura de errores en componentes. Mensajes amigables al usuario. Logs en consola (desarrollo) o servicio de monitoreo (producci&#243;n).</p></td>
</tr>
<tr>
<td><p>Base de datos</p></td>
<td><p>Constraints SQL + Validaci&#243;n en aplicaci&#243;n</p></td>
<td><p>NOT NULL, UNIQUE, CHECK, llaves for&#225;neas</p></td>
<td><p>Validaciones antes de insertar/actualizar. Mensajes de error claros para violaciones de integridad.</p></td>
</tr>
</table>




<strong>Otras consideraciones</strong>

<p>La tabla de esta sección estaba vacía en el documento fuente. La revisión de ramas, repositorios y artefactos se mantiene en el <a href="../code-tag/README.md">inventario de código y tag</a>; no se completan esos datos con supuestos.</p>

<strong>Estructura vigente de componentes en PT_HS</strong>

<p>El árbol de carpetas del documento fuente era una propuesta y no coincidía con el monorepo de referencia. Para evitar presentar nombres de archivos hipotéticos como si fueran actuales, esta sección resume los límites funcionales del corte PT_HS/main, commit 32be1cf. El detalle de flujos está en <a href="architecture.md">architecture.md</a>; el inventario estático de tablas está en <a href="database-schema-inventory.md">database-schema-inventory.md</a>.</p>

<table>
<tr><td><strong>Componente</strong></td><td><strong>Responsabilidad documentada</strong></td><td><strong>Límite o verificación</strong></td></tr>
<tr><td>Cliente web</td><td>Interfaz React/Vite y consumo de API REST.</td><td>La sesión web usa cookies y CSRF en el corte identificado. Confirmar el despliegue con el proveedor.</td></tr>
<tr><td>Cliente móvil</td><td>Aplicación Expo/React Native separada del cliente web.</td><td>BLE requiere compilación nativa compatible; Expo Go no demuestra ese flujo.</td></tr>
<tr><td>Backend</td><td>API Express con autenticación, autorización, reglas del dominio e ingesta MQTT.</td><td>La aceptación de un correo por Brevo no prueba su entrega al destinatario.</td></tr>
<tr><td>Persistencia</td><td>PostgreSQL con esquema administrado por cambios Liquibase.</td><td>El inventario de esta entrega se obtiene estáticamente de las migraciones; no es consulta en vivo a Neon.</td></tr>
<tr><td>Firmware y broker</td><td>ESP32 comunica estado y telemetría por MQTT; BLE aprovisiona la red. Mosquitto es local y Flespi/TLS corresponde al perfil externo.</td><td>El documento no acredita ACL, token vigente, disponibilidad del broker ni ensayo físico actual.</td></tr>
<tr><td>Entrega</td><td>GitHub Actions valida el repositorio según el workflow configurado.</td><td>Un resultado de CI no equivale a despliegue; consulta la evidencia de CI y el inventario de tag.</td></tr>
</table>


Referencias

Servicio Nacional de Aprendizaje. (2025). <em>Especificación de requisitos de software – Hidro Smart</em> (Versión 1).

Motta Vargas, J. de J. (2025). <em>Acta general del proceso del proyecto Hidro Smart</em>.

Amaya Mosquera, J. D., Molano Cardozo, E. C., &amp; Montealegre Rodríguez, J. A. (2026). <em>Encuesta sobre el consumo de agua</em>. Google Forms.


<pdf:nextpage />

Anexo de actualización 2026: diseño frente a la implementación

El informe de diseño original se conserva por su amplitud, tablas, decisiones y diagramas. Este anexo identifica qué elementos corresponden al diseño vigente y cuáles deben considerarse objetivos o antecedentes.

<table>
<tr>
<td><p><strong>Elemento de dise&#241;o</strong></p></td>
<td><p><strong>Estado verificable</strong></p></td>
<td><p><strong>Criterio de lectura</strong></p></td>
</tr>
<tr>
<td><p>Arquitectura hexagonal / por capas</p></td>
<td><p>Respaldada por la organizaci&#243;n del backend.</p></td>
<td><p>Se conserva como decisi&#243;n arquitect&#243;nica.</p></td>
</tr>
<tr>
<td><p>Event-driven / MQTT</p></td>
<td><p>Respaldado en la cadena de telemetr&#237;a.</p></td>
<td><p>Aplicable a IoT; no implica push de UI.</p></td>
</tr>
<tr>
<td><p>WebSockets / Socket.io</p></td>
<td><p>No encontrado como l&#237;nea de ejecuci&#243;n vigente.</p></td>
<td><p>Tratar como evoluci&#243;n o requisito pendiente.</p></td>
</tr>
<tr>
<td><p>AWS/Firebase/Redis/Bull</p></td>
<td><p>No verificados en el corte.</p></td>
<td><p>Tratar como alternativas de dise&#241;o, no como dependencias instaladas.</p></td>
</tr>
<tr>
<td><p>TLS, backups diarios y cifrado en reposo</p></td>
<td><p>No comprobados end-to-end.</p></td>
<td><p>Mantener como controles de producci&#243;n pendientes.</p></td>
</tr>
<tr>
<td><p>PostgreSQL/RLS/roles</p></td>
<td><p>Respaldados por BD_HS y documentaci&#243;n.</p></td>
<td><p>Nombres y permisos exactos se validan contra changelog.</p></td>
</tr>
<tr>
<td><p>BLE provisioning</p></td>
<td><p>Respaldado por firmware y frontend m&#243;vil.</p></td>
<td><p>Requiere development build y seguridad productiva adicional.</p></td>
</tr>
</table>


<pdf:nextpage />

## Corte de implementación PT_HS - 2026-11-05

Este corte técnico complementa el diseño objetivo y evita interpretar tecnologías propuestas como funciones desplegadas. La referencia de código es PT_HS/main, commit `32be1cf`; el [índice de entrega](../README.md) identifica el monorepo como fuente funcional canónica y los repositorios separados como referencias que pueden divergir.

- Web React/Vite y cliente móvil Expo/React Native son clientes distintos.
- HU-21 separa la consulta del perfil (`userApi.me()`) de la carga de hogares y dispositivos. Un error en esas consultas ya no bloquea por sí solo los datos del perfil; esto describe el código, no prueba un despliegue externo.
- La web usa sesión en cookies HttpOnly y protección CSRF para operaciones mutables; Bearer queda como compatibilidad opcional de API.
- Brevo se integra por API HTTPS. La respuesta de aceptación no demuestra entrega; solo están activos los disparadores descritos en la guía de correos.
- Mosquitto es el broker de desarrollo local. El firmware tiene un perfil Flespi/TLS en el puerto 8883; la ACL y el token desplegados deben verificarse en el entorno.
- El firmware admite varios códigos lógicos preasignados, pero mantiene un código activo por placa y publica cada lectura bajo ese código. hardwareId identifica la placa física.
- La ingesta deduplica mensajes con mqttMessageId; la interfaz consulta los datos persistidos mediante polling HTTP configurado a cinco segundos.
- measurementEnabled=false pausa la suma al consumo, mantiene sensor, Wi-Fi, MQTT y telemetría para que el backend evalúe flujo continuo y alertas de fuga. No equivale a apagar la placa.
- AWS, FCM, Redis/Bull y WebSockets mencionados en el diseño original son propuestas o capacidades no verificadas como activas en este corte.

Los diagramas y requisitos de este documento describen el diseño esperado; el código y la documentación técnica fechada son la referencia del comportamiento implementado.
