> **Estado y alcance.** Documento en revisión para la entrega. Las fechas, cifras y funciones heredadas del documento fuente solo se consideran vigentes cuando están respaldadas por evidencia del monorepo PT_HS. Consulta el [índice de entrega](../README.md) y el [índice de entrega](../README.md).

<strong>Diseño conceptual y arquitectura de información</strong>

<strong>Proyecto Hidro Smart</strong>





Emerson Calet Molano Cardozo

José Alejandro Montealegre Rodríguez

José David Amaya Mosquera





Instructor

Carlos Julio Cadena





Servicio Nacional de Aprendizaje SENA

Análisis y Desarrollo de Software ADSO


2026

<strong>Contenido del documento</strong>

- Introducción y contexto del sistema
- Mapa y modelo de navegación
- Roles, permisos y estructura principal
- Flujos de usuario y pantallas
- Adaptación por dispositivo y seguridad
- Anexo de contraste técnico con PT_HS


Introducción

El presente documento de Diseño Conceptual y Arquitectura de Información tiene como propósito establecer la estructura lógica, organizacional y funcional del proyecto Hidro Smart, tomando como base los requerimientos definidos en el Documento de Especificación de Requisitos de Software (SRS) y en el análisis previo del sistema.

Durante esta fase se plantea la organización de la información, la distribución de módulos y la definición de los flujos de navegación necesarios para garantizar una interacción clara, eficiente e intuitiva entre los diferentes usuarios y el sistema. La arquitectura de información permite identificar cómo se relacionan los componentes funcionales de la aplicación, facilitando la comprensión de su funcionamiento y apoyando el posterior desarrollo e implementación.

Asimismo, se busca asegurar que la solución propuesta responda de manera adecuada a las necesidades operativas del proyecto, priorizando funcionalidades esenciales como el monitoreo en tiempo real, la gestión de alertas, el control de dispositivos, la administración de usuarios y la generación de reportes.

Como resultado de esta etapa se presentan los siguientes elementos:

<p> Mapa de navegación (Site Map): representación jerárquica de los módulos y secciones principales del sistema.</p>
<p> Flujos de usuario (User Flows): secuencia de interacción para los procesos funcionales más relevantes.</p>
<p> Descripción de pantallas principales: identificación de interfaces vinculadas a los requerimientos funcionales.</p>
<p> Explicación textual del flujo de navegación: descripción de la lógica de acceso y transición entre funcionalidades.</p>
Mapa de navegación (Site Map)

El diagrama gráfico original no está incluido en esta copia del repositorio. Para la versión consolidada, consulta los [casos de uso](../04-software-design/diagrams/use-cases.md) y el [wireframe](../04-software-design/ui-wireframe.md); no representan necesariamente el mismo mapa original.

El Mapa de Navegación del sistema Hidro Smart representa la estructura jerárquica de las interfaces, módulos y rutas de interacción disponibles dentro de la plataforma, permitiendo visualizar de manera organizada el comportamiento general de navegación según cada tipo de usuario definido en el sistema.

Su propósito principal es establecer una visión estructural del acceso a funcionalidades, facilitando tanto el diseño de experiencia de usuario como la implementación técnica de los módulos de software.

El diseño del site map se fundamenta en una arquitectura modular y escalable, donde cada perfil de acceso dispone de funcionalidades específicas de acuerdo con sus responsabilidades dentro del sistema.Estructura principal (común a los roles)


Modelo de navegación implementado

La arquitectura de navegación del sistema responde a un modelo híbrido compuesto por tres enfoques principales:

Navegación jerárquica

Se establece un nodo principal de entrada desde el cual se distribuyen los diferentes caminos de acceso:

<p> Inicio</p>
<p> Registro / autenticación</p>
<p> Redirección por rol</p>
Navegación modular

Cada panel organiza funciones relacionadas dentro de módulos independientes:

<p> monitoreo</p>
<p> administración</p>
<p> configuración</p>
<p> control técnico</p>
Navegación condicionada por permisos

La interfaz mostrada depende del rol autenticado en el sistema, garantizando seguridad y control de acceso.


Estructura principal del sistema

Pantalla de inicio

Constituye el punto inicial de acceso al sistema.

Incluye:

<p> autenticación de usuarios</p>
<p> registro de nuevas cuentas</p>
<p> validación de credenciales</p>
Esta etapa corresponde al proceso inicial de control de acceso del sistema.

Panel principal (Dashboard dinámico)

Una vez validado el acceso, el sistema redirige automáticamente al panel correspondiente según el perfil autenticado.


Navegación por perfiles de usuario

Usuario final

El usuario dispone de un entorno orientado al monitoreo del consumo hídrico y control doméstico.

<strong>Funcionalidades principales</strong>

<p> visualización de consumo en tiempo real</p>
<p> consulta de gráficos comparativos</p>
<p> análisis por periodos:</p>
<p> diario</p>
<p> semanal</p>
<p> mensual</p>
<p> anual</p>
<p> recepción de alertas automáticas</p>
<p> consulta de recomendaciones inteligentes</p>
<p> gestión de perfil</p>
<p> selección de hogares asociados</p>
<strong>Objetivo de navegación</strong>

Permitir acceso rápido a información crítica de consumo y toma de decisiones de ahorro.

Técnico

El técnico accede a un entorno orientado a la gestión operativa de dispositivos IoT.

<strong>Funcionalidades principales</strong>

<p> registro de dispositivos</p>
<p> asignación de identificadores únicos</p>
<p> vinculación de sensores a hogares</p>
<p> validación de conectividad</p>
<p> control de estado operativo</p>
<strong>Objetivo de navegación</strong>

Facilitar procesos de instalación, activación y mantenimiento técnico.

Administrador

El administrador concentra la gestión global del sistema.

<strong>Funcionalidades principales</strong>

<p> gestión de usuarios</p>
<p> administración de proyectos</p>
<p> configuración general del sistema</p>
<p> auditoría de operaciones</p>
<p> generación de reportes</p>
<strong>Objetivo de navegación</strong>

Garantizar control administrativo y supervisión integral de la plataforma.


Justificación de diseño UX/UI

El diseño de navegación fue estructurado bajo principios de usabilidad y eficiencia operativa.

<strong>Principios aplicados</strong>

<p> simplicidad visual</p>
<p> agrupación funcional</p>
<p> reducción de carga cognitiva</p>
<p> consistencia estructural</p>
<strong>Beneficios del diseño</strong>

<p> acceso intuitivo</p>
<p> disminución de errores de navegación</p>
<p> rápida localización de funciones críticas</p>
<p> facilidad de escalabilidad futura</p>

Características técnicas de navegación

<strong>Diseño adaptable</strong>

La estructura está preparada para entornos web responsivos.

<strong>Integración tecnológica</strong>

<p> Compatible con:</p>
<p> servicios REST</p>
<p> gestión de sesiones</p>
<p> comunicación IoT</p>
<strong>Escalabilidad</strong>

Permite incorporar nuevos módulos sin afectar la arquitectura existente.


Relación con requerimientos funcionales

La navegación del sistema responde directamente a los requerimientos funcionales establecidos en el SRS.

<strong>Usuario</strong>

<p> monitoreo</p>
<p> alertas</p>
<p> recomendaciones</p>
<p> perfil</p>
<strong>Técnico</strong>

<p> registro de dispositivos</p>
<p> validación de conexión</p>
<strong>Administrador</strong>

<p> usuarios</p>
<p> proyectos</p>
<p> auditoría</p>
<p> reportes</p>
















Flujos de usuario (User FlowS)

El gráfico de flujo original no está incluido en esta copia. Los flujos vigentes se documentan en los [diagramas de secuencia](../04-software-design/diagrams/sequence-diagrams.md) y deben validarse con las pruebas de la versión final.




















Título Primer Nivel


Descripción de los Flujos de Usuario (User Flows)

Los Flujos de Usuario (User Flows) representan las principales secuencias de interacción entre los usuarios y el sistema Hidro Smart, describiendo cómo cada actor cumple sus objetivos dentro de la plataforma.

Cada flujo se encuentra alineado con un Requisito Funcional (RF) y fue diseñado siguiendo principios de:

<p> Usabilidad</p>
<p> Experiencia de usuario (UX)</p>
<p> Automatización de procesos</p>
<p> Monitoreo inteligente del consumo hídrico</p>

Flujo 1: Registro y acceso de usuario (RF1)

<strong>Escenario:</strong>

Un usuario doméstico crea una cuenta en la aplicación Hidro Smart y accede por primera vez al sistema para comenzar el monitoreo de consumo de agua.

<strong>Puntos clave:</strong>

<p> Registro guiado mediante ingreso de datos personales.</p>
<p> Validación automática de información ingresada.</p>
<p> Corrección inmediata en caso de errores detectados.</p>
<p> Verificación de cuenta mediante correo electrónico.</p>
<p> Acceso seguro al dashboard del usuario tras autenticación exitosa.</p>
<p> Tiempo estimado de proceso: 1 – 2 minutos desde registro hasta acceso al sistema.</p>
Flujo 2: Consulta de consumo en tiempo real (RF2)

<strong>Escenario:</strong>

Un usuario autenticado consulta el consumo de agua de su hogar desde la aplicación móvil para monitorear su gasto diario.

<strong>Puntos clave:</strong>

<p> Acceso directo desde el dashboard principal.</p>
<p> Selección del hogar asociado al usuario.</p>
<p> Visualización del consumo en tiempo real proveniente del dispositivo IoT.</p>
<p> Actualización automática de datos sin intervención manual.</p>
<p> Evaluación automática de límites de consumo configurados.</p>
<p> Generación de alertas inmediatas cuando se supera el umbral definido.</p>
<p> Continuidad del monitoreo en segundo plano.</p>
Tiempo objetivo: menos de 10 segundos para visualizar datos actualizados.


Flujo 3: Generación de recomendaciones inteligentes (RF3)

<strong>Escenario:</strong>

El usuario revisa recomendaciones personalizadas para reducir su consumo de agua basadas en su historial de uso.

<strong>Puntos clave:</strong>

<p> Consulta del historial de consumo desde el dashboard.</p>
<p> Análisis automático de patrones de uso.</p>
<p> Generación de recomendaciones inteligentes de ahorro.</p>
<p> Presentación visual de consejos prácticos al usuario.</p>
<p> Apoyo a la toma de decisiones sostenibles.</p>
<p> Mejora progresiva del comportamiento de consumo.</p>

Flujo 4: Registro de dispositivo por técnico (RF4)

<strong>Escenario:</strong>

Un técnico instala y configura un dispositivo Hidro Smart en el hogar del usuario.

<strong>Puntos clave:</strong>

<p> Acceso mediante autenticación técnica.</p>
<p> Registro del nuevo dispositivo dentro del sistema.</p>
<p> Asignación de identificador único (ID).</p>
<p> Vinculación del dispositivo con el hogar del usuario.</p>
<p> Validación automática de conexión del dispositivo IoT.</p>
<p> Activación del dispositivo tras conexión exitosa.</p>
<p> Flujo alternativo para revisión de configuración en caso de fallo.</p>
Tiempo estimado de instalación digital: 3 – 5 minutos.


Flujo 5: Administración de usuarios (RF5)

<strong>Escenario:</strong>

Un administrador gestiona los usuarios registrados dentro del sistema desde el panel administrativo.

<strong>Puntos clave:</strong>

<p> Acceso al panel administrativo mediante credenciales seguras.</p>
<p> Visualización del listado de usuarios.</p>
<p> Selección individual de usuarios.</p>
<p> Acciones disponibles:</p>
<p> Crear nuevo usuario.</p>
<p> Suspender usuario.</p>
<p> Reactivar usuario.</p>
<p> Actualización inmediata del estado del usuario dentro del sistema.</p>
<p> Control centralizado de acceso a la plataforma.</p>

Flujo 6: Generación de reportes administrativos (RF6)

<strong>Escenario:</strong>

Un administrador genera reportes de consumo hídrico para análisis institucional o toma de decisiones.

<strong>Puntos clave:</strong>

<p> Acceso a módulo de consultas y reportes.</p>
<p> Selección de periodo de análisis.</p>
<p> Generación automática de reportes estadísticos.</p>
<p> Exportación de información en formatos PDF y Excel.</p>
<p> Apoyo a análisis de consumo y estrategias de ahorro hídrico.</p>
Tiempo objetivo: menos de 15 segundos para generación del reporte.





Descripción de pantallas principales (Vinculadas a RF)

<table>
<tr>
<td><p>Pantalla</p></td>
<td><p>RF Relacionado</p></td>
<td><p>Componentes Claves</p></td>
<td><p>Funcionalidad</p></td>
</tr>
<tr>
<td><p>Inicio</p></td>
<td><p>----</p></td>
<td><p>Logo del sistema, botones Iniciar sesi&#243;n / Registrarse</p></td>
<td><p>Acceso inicial al sistema</p></td>
</tr>
<tr>
<td><p>Login Usuario</p></td>
<td><p>RF1</p></td>
<td><p>Correo electr&#243;nico, contrase&#241;a, recuperaci&#243;n de contrase&#241;a</p></td>
<td><p>Autenticaci&#243;n segura de usuarios</p></td>
</tr>
<tr>
<td><p>Registro Usuario</p></td>
<td><p>RF1</p></td>
<td><p>Formulario de registro, validaci&#243;n de datos, verificaci&#243;n por correo</p></td>
<td><p>Creaci&#243;n de cuenta</p></td>
</tr>
<tr>
<td><p>Dashboard Usuario</p></td>
<td><p>RF2, RF3</p></td>
<td><p>Resumen de consumo, alertas, accesos r&#225;pidos, hogares asociados</p></td>
<td><p>Vista general del consumo h&#237;drico</p></td>
</tr>
<tr>
<td><p>Consumo en Tiempo Real</p></td>
<td><p>RF2</p></td>
<td><p>Gr&#225;ficas din&#225;micas, indicadores de consumo, rangos diario/semanal/mensual/anual</p></td>
<td><p>Monitoreo en tiempo real</p></td>
</tr>
<tr>
<td><p>Alertas y Notificaciones</p></td>
<td><p>RF2</p></td>
<td><p>Lista de alertas, estado de consumo, avisos autom&#225;ticos</p></td>
<td><p>Prevenci&#243;n de sobreconsumo</p></td>
</tr>
<tr>
<td><p>Recomendaciones Inteligentes</p></td>
<td><p>RF3</p></td>
<td><p>Consejos de ahorro, an&#225;lisis hist&#243;rico</p></td>
<td><p>Optimizaci&#243;n del uso del agua</p></td>
</tr>
<tr>
<td><p>Gesti&#243;n de Perfil</p></td>
<td><p>RF1</p></td>
<td><p>Actualizar datos personales, cambio de contrase&#241;a</p></td>
<td><p>Administraci&#243;n de cuenta</p></td>
</tr>
<tr>
<td><p>Proyectos / Hogares Asociados</p></td>
<td><p>RF2</p></td>
<td><p>Lista de hogares, selecci&#243;n de hogar</p></td>
<td><p>Gesti&#243;n de entornos monitoreados</p></td>
</tr>
<tr>
<td><p>Login T&#233;cnico</p></td>
<td><p>RF4</p></td>
<td><p>Usuario t&#233;cnico, contrase&#241;a</p></td>
<td><p>Acceso al panel t&#233;cnico</p></td>
</tr>
<tr>
<td><p>Panel T&#233;cnico</p></td>
<td><p>RF4</p></td>
<td><p>Registro de dispositivo, asignaci&#243;n ID</p></td>
<td><p>Configuraci&#243;n de dispositivos IoT</p></td>
</tr>
<tr>
<td><p>Registro de Dispositivo</p></td>
<td><p>RF4</p></td>
<td><p>ID &#250;nico, vinculaci&#243;n a hogar</p></td>
<td><p>Instalaci&#243;n digital del sensor</p></td>
</tr>
<tr>
<td><p>Estado del Dispositivo</p></td>
<td><p>RF4</p></td>
<td><p>Estado conexi&#243;n IoT, activar/suspender dispositivo</p></td>
<td><p>Control operativo del dispositivo</p></td>
</tr>
<tr>
<td><p>Login Administrador</p></td>
<td><p>RF5, RF6</p></td>
<td><p>Credenciales administrativas</p></td>
<td><p>Acceso administrativo</p></td>
</tr>
<tr>
<td><p>Panel Administrativo</p></td>
<td><p>RF5, RF6</p></td>
<td><p>Men&#250; administrativo general</p></td>
<td><p>Control total del sistema</p></td>
</tr>
<tr>
<td><p>Gesti&#243;n de Usuarios</p></td>
<td><p>RF5</p></td>
<td><p>Crear, suspender, reactivar usuarios</p></td>
<td><p>Administraci&#243;n de accesos</p></td>
</tr>
<tr>
<td><p>Gesti&#243;n de Proyectos</p></td>
<td><p>RF5</p></td>
<td><p>Crear hogar, asignar titular y miembros</p></td>
<td><p>Organizaci&#243;n del sistema</p></td>
</tr>
<tr>
<td><p>Configuraci&#243;n del Sistema</p></td>
<td><p>RF6</p></td>
<td><p>Idioma, moneda, alertas, colores</p></td>
<td><p>Personalizaci&#243;n global</p></td>
</tr>
<tr>
<td><p>Auditor&#237;a</p></td>
<td><p>RF6</p></td>
<td><p>Registro de acciones del sistema</p></td>
<td><p>Seguimiento y control</p></td>
</tr>
<tr>
<td><p>Consultas y Reportes</p></td>
<td><p>RF6</p></td>
<td><p>Filtros, generaci&#243;n de reportes</p></td>
<td><p>An&#225;lisis administrativo</p></td>
</tr>
<tr>
<td><p>Exportaci&#243;n de Reportes</p></td>
<td><p>RF6</p></td>
<td><p>Exportar PDF / Excel</p></td>
<td><p>Generaci&#243;n de informes</p></td>
</tr>
</table>




















Explicación textual del flujo de navegación

La navegación del sistema Hidro Smart sigue un modelo híbrido orientado a roles, diseñado para garantizar accesibilidad, eficiencia operativa y control seguro de las funcionalidades del sistema.

El diseño combina:

<p> Navegación jerárquica, donde el Dashboard actúa como centro principal de operaciones.</p>
<p> Acceso directo a funciones críticas como monitoreo de consumo, gestión de dispositivos y generación de reportes.</p>
Este enfoque permite reducir el número de pasos necesarios para ejecutar tareas frecuentes y mejora la experiencia del usuario en entornos móviles y web.


Modelo de Navegación

<strong>Navegación Jerárquica</strong>

El sistema organiza las funcionalidades desde pantallas principales hacia módulos especializados:

<p> Inicio → Autenticación → Panel correspondiente según rol.</p>
<p> Dashboard como punto central de interacción.</p>
<p> Submódulos accesibles mediante menús contextuales.</p>
El flujo se adapta dinámicamente según el tipo de usuario:

<p> Usuario doméstico</p>
<p> Técnico instalador</p>
<p> Administrador del sistema</p>
Lógica de Transiciones Clave

<p>1\. <strong>Inicio → Login → </strong><strong>Dashboard</strong></p>
El usuario ingresa sus credenciales y, tras validación exitosa, accede al panel correspondiente. (RF1 – Autenticación y acceso seguro).

<p>2\. <strong>Dashboard</strong><strong> Usuario → Consumo en Tiempo Real</strong></p>
El usuario consulta métricas actualizadas provenientes del dispositivo IoT instalado en el hogar. (RF2 – Monitoreo de consumo hídrico).

<p>3\. <strong>Consumo → Alertas Automáticas</strong></p>
Cuando el sistema detecta valores superiores al umbral configurado, se generan notificaciones automáticas visibles desde el dashboard. (RF2 – Sistema de alertas inteligentes).

<p>4\. <strong>Dashboard</strong><strong> → Recomendaciones Inteligentes</strong></p>
El usuario accede a sugerencias generadas a partir del análisis histórico de consumo. (RF3 – Optimización del uso del agua).

<p>5\. <strong>Panel Técnico → Registro de Dispositivo → Validación </strong><strong>IoT</strong></p>
El técnico registra un dispositivo, asigna un identificador único y valida su conexión con el sistema. (RF4 – Gestión de dispositivos IoT).

<p>6\. <strong>Panel Administrativo → Gestión del Sistema</strong></p>
El administrador gestiona usuarios, proyectos, configuraciones globales y reportes institucionales. (RF5 y RF6 – Administración y análisis del sistema).


Adaptación por Dispositivo

<strong>Dispositivos Móviles</strong>

La navegación prioriza rapidez y accesibilidad mediante:


<p> Menú inferior persistente:</p>
<p> Dashboard</p>
<p> Consumo</p>
<p> Alertas</p>
<p> Perfil</p>
Optimizado para monitoreo continuo y consulta rápida.


Plataforma Web

Se emplea navegación estructurada para operaciones avanzadas:

<p> Menú superior para usuarios domésticos.</p>
<p> Menú lateral administrativo para técnicos y administradores.</p>
<p> Uso de breadcrumb navigation para mantener la referencia jerárquica dentro del sistema.</p>

Seguridad en la Navegación (RF de Seguridad)

El sistema implementa mecanismos de protección durante toda la navegación:

<p> Comunicación segura mediante HTTPS obligatorio.</p>
<p> Expiración automática de sesión tras 15 minutos de inactividad.</p>
<p> Control de acceso basado en roles:</p>
<p> Usuario</p>
<p> Técnico</p>
<p> Administrador</p>
<p> Restricción automática de módulos según permisos asignados.</p>
<p> Validación continua del estado de autenticación.</p>





















Referencias Bibliográficas

Bahga, A., & Madisetti, V. (2014). *Internet of Things: A hands-on approach*. Universities Press.

Garrett, J. J. (2010). *The elements of user experience: User-centered design for the web and beyond* (2nd ed.). New Riders.

International Organization for Standardization. (2018). *ISO/IEC/IEEE 29148:2018 Systems and software engineering - Life cycle processes - Requirements engineering*. ISO.

Krug, S. (2014). *Don't make me think: A commonsense approach to web usability* (3rd ed.). New Riders.

Morville, P., & Rosenfeld, L. (2015). *Information architecture for the web and beyond* (4th ed.). O'Reilly Media.

National Institute of Standards and Technology. (2020). *Digital identity guidelines (NIST Special Publication 800-63)*. https://doi.org/10.6028/NIST.SP.800-63

Nielsen Norman Group. (2020). *User experience basics*. https://www.nngroup.com

OWASP Foundation. (2021). *OWASP Top 10: The ten most critical web application security risks*. https://owasp.org/www-project-top-ten/

Pressman, R. S., &amp; Maxim, B. R. (2019). <em>Software </em><em>engineering</em><em>: A </em><em>practitioner’s</em><em>approach</em> (9th ed.). McGraw-Hill Education.

Sommerville, I. (2016). <em>Software </em><em>engineering</em> (10th ed.). Pearson Education Limited.


Anexo de actualización 2026: vistas dinámicas verificadas

El documento conceptual original se conserva como base de navegación y análisis. Este anexo incorpora la dinámica observada en el repositorio, diferenciando la interacción del usuario de la cadena IoT.

Flujo autenticación → autorización

Registro crea cuenta pendiente; verificación de correo habilita el ingreso.

El login establece cookies HttpOnly de sesión; las mutaciones requieren X-CSRF-Token. Bearer se conserva como compatibilidad cuando está habilitado.

Refresh intenta renovar una vez ante 401; logout revoca la sesión.

Roles y restricciones de hogar/RLS limitan el acceso a datos.

Flujo dispositivo → telemetría → pantalla

El ESP32 mide pulsos/flujo y publica telemetry en hidrosmart/devices/{deviceCode}/telemetry.

MqttSubscriber recibe; parser y handler validan, normalizan y deduplican.

La lectura se persiste en PostgreSQL; los agregados se consultan mediante API.

El frontend actualiza la información mediante polling HTTP documentado de 5 segundos; no se afirma WebSocket push.

Estado de las vistas originales

**Navegación y pantallas.** Se conserva el análisis conceptual y se incorpora el WebView/BLE móvil y el estado real de los módulos.

**Flujos de usuario.** Se conservan como base; la actualización describe web más WebView y polling HTTP, sin afirmar React Native puro ni WebSocket.

**Secuencia IoT.** Se coteja con los topics, QoS, retain, parser, ingesta y persistencia en PostgreSQL del corte revisado.

**Actores y roles.** Se contrastan con usuarios, administración, soporte y permisos implementados en backend.
