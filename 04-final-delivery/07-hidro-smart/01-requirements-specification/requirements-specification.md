> **Estado y alcance.** Documento en revisión para la entrega. Las fechas, cifras y funciones heredadas del documento fuente solo se consideran vigentes cuando están respaldadas por evidencia de la versión integrada PT_HS. Este SRS conserva los requisitos académicos y añade un anexo de estado y trazabilidad; la [matriz de requisitos](requirements-matrix.md) resume evidencias y pendientes de la entrega.

# ESPECIFICACIÓN DE REQUISITOS DE SOFTWARE






<strong>PROYECTO: Hidro Smart</strong>






<strong>INTEGRANTES:</strong>



<strong>Emerson Calet Molano Cardozo </strong>

<strong>José David Amaya Mosquera</strong>

<strong>José Alejandro Montealegre Rodríguez</strong>







<strong>INSTRUCTOR:</strong>

<strong>MOTTA VARGAS JOSÉ DE JESÚS</strong>








<strong>SERVICIO NACIONAL DE APRENDIZAJE – SENA PROGRAMACIÓN DE SOFTWARE – 3145555</strong>






#### 2025

Tabla de contenido

1. Introducción
2. Descripción general
3. Requisitos específicos
4. Requisitos de casos de uso
5. Anexo de actualización 2026: estado de requisitos
6. Anexo de trazabilidad técnica

# Control de actualización

<strong>Fecha de revisión documental: 2026-11-05. Estado: documento base académico con anexo de vigencia; pendiente de aceptación del equipo y validación contra el tag final.</strong>

Fuentes: SRS académico convertido, PT_HS como monorepo canónico (rama `main`, commit `32be1cf787f20120dfd3b4cc72226dab55d88216`) y repositorios separados de componentes para contraste. La revisión del código es estática: no certifica aceptación funcional, operación productiva ni el commit/tag que finalmente se entregue.

Se conserva la estructura y los requisitos funcionales/no funcionales del SRS fuente. Las secciones originales describen alcance esperado, no resultados de pruebas. Los requisitos aún no implementados o cuya aceptación no esté demostrada permanecen como requisitos y no deben presentarse como funciones verificadas. El anexo registra la evidencia disponible para el commit indicado; debe volver a cotejarse con el mismo commit/tag de entrega.

# Introducción.


<strong>Bienvenidos </strong>

El consumo eficiente y responsable del agua es un desafío ambiental y social. En un hogar, una lectura agregada del medidor no siempre permite saber en qué punto o actividad se originó el consumo. Este problema motiva Hidro Smart; el documento no presenta una medición nacional de cuánto conocen los hogares sobre su consumo.

Las cifras de contexto disponibles miden fenómenos distintos: la Universidad de los Andes publicó en 2016 una estimación del 48 % de pérdidas en los sistemas colombianos de distribución de agua potable, no del consumo dentro de los hogares. El DANE informó que en 2020 el 92,2 % de los hogares realizó al menos una práctica para reducir el consumo de agua y energía; el indicador combina ambos servicios y no representa una tasa de ahorro de agua exclusivamente. No se conservan las cifras de 40 % atribuida a la Personería de Bogotá ni de 33 % atribuida al DANE en 2024 porque este documento no cuenta con referencias verificables que respalden esas atribuciones.

<strong>Hidro Smart</strong> integra un cliente web, un cliente Android y dispositivos IoT para registrar y consultar consumo de agua. En el código revisado, las vistas web de consumo, dashboard y dispositivos consultan datos periódicamente (intervalo nominal de cinco segundos); esto no equivale a una garantía de tiempo real. El cliente Android empaqueta la interfaz web en una vista WebView y requiere una compilación nativa para usar aprovisionamiento BLE; Expo Go no incluye esa capacidad. Las alertas, estadísticas y demás resultados deben considerarse sujetos a los estados de aceptación descritos en el anexo.



## Planteamiento del problema.


Una lectura general del hogar puede no permitir identificar cómo, cuándo y en qué punto se consume el agua. Los medidores convencionales suelen presentar un total del periodo sin atribuir cada lectura a una actividad doméstica específica. Esta descripción plantea el problema del proyecto; no es una afirmación estadística sobre todos los hogares colombianos.

Esta falta de información provoca desperdicio, costos elevados y un bajo nivel de conciencia sobre el impacto ambiental del consumo doméstico.

Por tanto, se plantea la siguiente pregunta de investigación:

<strong>¿Cómo puede una solución tecnológica basada en medidores inteligentes, una interfaz web y un cliente móvil ayudar a los usuarios domésticos a conocer y gestionar su consumo de agua para reducir el desperdicio?</strong>

## Propósito.

El propósito del proyecto <strong>Hidro Smart</strong> es desarrollar una herramienta que permita <strong>registrar, analizar y visualizar el consumo de agua</strong> en los hogares mediante un dispositivo IoT y clientes web y Android. La interfaz presenta datos consultados del backend; las vistas principales usan actualización periódica y no se afirma que cada dato aparezca instantáneamente. Las recomendaciones, reportes y alertas se sujetan a los requisitos y estados de aceptación del anexo.

El sistema busca promover el ahorro, la sostenibilidad ambiental y el uso consciente del recurso hídrico, contribuyendo a la gestión eficiente del agua a nivel doméstico.


## Justificación.

El DANE informó que en 2020 el 92,2 % de los hogares realizó al menos una práctica para reducir el consumo de agua y energía. Como el indicador combina los dos servicios, no permite afirmar qué proporción ahorra agua únicamente ni cuánto conoce cada hogar sobre su consumo. Hidro Smart se justifica por la necesidad funcional de consultar lecturas del propio hogar, sin atribuirle a esta fuente conclusiones que no mide.

<strong>Hidro Smart</strong> busca facilitar esa consulta mediante sensores de flujo, conectividad IoT y clientes web y Android. La actualización periódica puede ayudar a observar cambios en el consumo; la detección de anomalías y las recomendaciones personalizadas requieren validación funcional y no se consideran resultados demostrados por esta justificación.

El proyecto no solo tiene un impacto ecológico, sino también <strong>económico y educativo</strong>, al incentivar una cultura de sostenibilidad y responsabilidad ambiental en los hogares.




## Objetivo General.

Diseñar e implementar una solución tecnológica compuesta por un <strong>medidor inteligente de agua</strong>, un <strong>cliente web</strong> y un <strong>cliente Android</strong> que permita a los usuarios consultar y gestionar su consumo, con alertas y herramientas de ahorro sujetas a los criterios de aceptación del proyecto.


### Objetivos específicos.


<p>● Desarrollar clientes web y Android para consultar los datos recibidos desde un medidor inteligente con actualización periódica; el tiempo real estricto es un requisito por validar.
</p>
<p>● Registrar y procesar el consumo de agua. La clasificación automática por actividad doméstica permanece como requisito por validar; una medición agregada de un solo dispositivo no permite inferir si el caudal proviene de la ducha, la cocina u otro punto.
</p>
<p>● Generar <strong>informes y gráficos periódicos</strong> para que el usuario evalúe sus patrones de consumo.
</p>
<p>● Proporcionar <strong>alertas y recomendaciones</strong> para reducir el desperdicio.</p>
<p>● Implementar un sistema de metas y presupuesto mensual que permita al usuario establecer objetivos de ahorro.</p>

<p>● <strong>Desarrollar herramientas de gestión del consumo</strong>, como metas de ahorro, presupuesto mensual y modo vacaciones, que promuevan el uso eficiente del agua.</p>
<!-- page break -->

<p>● <strong>Implementar mecanismos de administración y monitoreo de dispositivos IoT</strong>, permitiendo su registro, calibración, configuración, suspensión, reactivación y consulta del historial de conectividad.</p>
<!-- page break -->

<p>● <strong>Incorporar un sistema de soporte técnico basado en tickets</strong>, que facilite la atención, seguimiento y resolución de incidencias reportadas por los usuarios.</p>
<!-- page break -->

<p>● <strong>Garantizar la seguridad, disponibilidad y confiabilidad del sistema</strong>, mediante mecanismos de autenticación segura, control de acceso, auditoría, cifrado de datos y tolerancia a fallos.
</p>
<p>● Evaluar el rendimiento y la usabilidad del sistema durante su implementación piloto.</p>


<strong>1.5 Alcance</strong>

<!-- page break -->
Este documento especifica los requisitos funcionales y no funcionales de Hidro Smart para esta entrega. El sistema integra una aplicación web y móvil con dispositivos IoT para registrar y consultar el consumo doméstico de agua.

<!-- page break -->
El alcance documentado para esta entrega comprende:

<p>● Diseño, desarrollo, implementación y validación de una plataforma para el monitoreo inteligente del consumo doméstico de agua.</p>

<p>● Integración con dispositivos IoT para capturar lecturas y transmitirlas mediante MQTT. La latencia de extremo a extremo depende del dispositivo, broker, backend y red; no se afirma tiempo real garantizado.</p>
<p>● Visualización del consumo de agua, estado de los dispositivos y estadísticas mediante una interfaz web desarrollada con React + Vite, con actualización periódica nominal de cinco segundos en las vistas principales revisadas.
</p>
<p>● Gestión de usuarios, autenticación segura, administración de perfiles y control de acceso basado en roles.
</p>
<p>● Administración de hogares, dispositivos IoT y configuraciones asociadas a cada usuario.</p>
<p>● Configuración de límites de consumo, generación de alertas automáticas y detección de posibles fugas de agua.</p>
<p>● Generación de reportes estadísticos, gráficos comparativos e historial de consumo.</p>
<p>● Gestión de metas de ahorro, presupuestos mensuales y configuración del modo vacaciones.</p>
<p>● Administración del historial de conectividad de los dispositivos IoT para facilitar tareas de monitoreo y diagnóstico.</p>
<p>● Implementación de un sistema de soporte técnico basado en tickets para el reporte y seguimiento de incidencias.</p>
<p>● Desarrollo del backend utilizando Node.js y Express, con PostgreSQL como sistema gestor de bases de datos. La mensajería IoT usa MQTT: Mosquitto es el broker local y el firmware ofrece un perfil externo Flespi/TLS; Redis y Firebase Cloud Messaging no están verificados en el corte actual.</p>
<p>● Implementación de una arquitectura modular por capas y componentes integrados, utilizando Arquitectura Hexagonal (Ports and Adapters) para el backend y Arquitectura Basada en Componentes (Component-Based Architecture) para el frontend desarrollado con React + Vite.</p>
<p>● Comunicación entre componentes mediante API REST, polling HTTP nominal de cinco segundos en las vistas principales revisadas y MQTT para telemetría. WebSockets no se verificó en el cliente actual; por ello, no se promete entrega instantánea de cada lectura.</p>
<p>● Diseño del sistema bajo principios de escalabilidad, mantenibilidad, seguridad, disponibilidad y facilidad de integración con futuros servicios.
</p>
El sistema no incluirá inicialmente integración con redes externas de servicios públicos, pero quedará preparado para futuras extensiones.



## Personal involucrado.


<table>
<tr>
<td><p><strong>Nombre</strong></p></td>
<td><p>Jos&#233; David Amaya Mosquera</p></td>
</tr>
<tr>
<td><p><strong>Rol</strong></p></td>
<td><p>Analista</p></td>
</tr>
<tr>
<td><p><strong>Categor&#237;a Profesional</strong></p></td>
<td><p>Aprendiz del tecn&#243;logo en an&#225;lisis y desarrollo software</p></td>
</tr>
<tr>
<td><p><strong>Responsabilidad</strong></p></td>
<td><p>An&#225;lisis y documentaci&#243;n del proyecto.</p></td>
</tr>
<tr>
<td><p><strong>Informaci&#243;n de contacto</strong></p></td>
<td><p>josedam2704@gmail.com</p></td>
</tr>
</table>



<table>
<tr>
<td><p><strong>Nombre</strong></p></td>
<td><p>Emerson Calet Molano Cardozo</p></td>
</tr>
<tr>
<td><p><strong>Rol</strong></p></td>
<td><p>Programador</p></td>
</tr>
<tr>
<td><p><strong>Categor&#237;a Profesional</strong></p></td>
<td><p>Aprendiz del tecn&#243;logo en an&#225;lisis y desarrollo software</p></td>
</tr>
<tr>
<td><p><strong>Responsabilidad</strong></p></td>
<td><p>Responsable de todos los requerimientos del c&#243;digo</p></td>
</tr>
<tr>
<td><p><strong>Informaci&#243;n de contacto</strong></p></td>
<td><p>emersoncaletmolano@gmail.com</p></td>
</tr>
</table>


<table>
<tr>
<td><p><strong>Nombre</strong></p></td>
<td><p>Jos&#233; Alejandro Montealegre Rodr&#237;guez</p></td>
</tr>
<tr>
<td><p><strong>Rol</strong></p></td>
<td><p>Base de Datos</p></td>
</tr>
<tr>
<td><p><strong>Categor&#237;a Profesional</strong></p></td>
<td><p>Aprendiz del tecn&#243;logo en an&#225;lisis y desarrollo software</p></td>
</tr>
<tr>
<td><p><strong>Responsabilidad</strong></p></td>
<td><p>Gesti&#243;n de la base de datos con los requerimientos que se presente </p></td>
</tr>
<tr>
<td><p><strong>Informaci&#243;n de contacto</strong></p></td>
<td><p> montealegrejose254@gmail.com</p></td>
</tr>
</table>

## Definiciones, acrónimos y abreviaturas.


<table>
<tr>
<td><p><em><strong>Nombre</strong></em></p></td>
<td><p><em><strong>Descripci&#243;n</strong></em></p></td>
</tr>
<tr>
<td><p><strong>Usuario</strong></p></td>
<td><p>Persona que usar&#225; la aplicaci&#243;n.</p></td>
</tr>
<tr>
<td><p><strong>SRS</strong></p></td>
<td><p>Especificaci&#243;n de Requisitos de Software.</p></td>
</tr>
<tr>
<td><p><strong>RF</strong></p></td>
<td><p>Requerimiento Funcional.</p></td>
</tr>
<tr>
<td><p><strong>RNF</strong></p></td>
<td><p>Requerimiento No Funcional.</p></td>
</tr>
<tr>
<td><p><strong>SENA</strong></p></td>
<td><p>Servicio Nacional de Aprendizaje.</p></td>
</tr>
<tr>
<td><p><strong>CU</strong></p></td>
<td><p>Caso de uso.</p></td>
</tr>
<tr>
<td><p><strong>IoT</strong></p></td>
<td><p>Internet of Things: red de dispositivos f&#237;sicos (sensores) conectados a internet.</p></td>
</tr>
<tr>
<td><p><strong>ESP32</strong></p></td>
<td><p>Microcontrolador con Wi-Fi y Bluetooth usado como medidor inteligente.</p></td>
</tr>
<tr>
<td><p><strong>MQTT</strong></p></td>
<td><p>Protocolo de mensajer&#237;a ligero para IoT, basado en publicaci&#243;n/suscripci&#243;n.</p></td>
</tr>
<tr>
<td><p><strong>JWT</strong></p></td>
<td><p>JSON Web Token: est&#225;ndar para autenticaci&#243;n stateless.</p></td>
</tr>
<tr>
<td><p><strong>Hogar/Proyecto</strong></p></td>
<td><p>Entidad que agrupa usuarios, dispositivos y configuraciones de consumo.</p></td>
</tr>
<tr>
<td><p><strong>Estrato</strong></p></td>
<td><p>Clasificaci&#243;n socioecon&#243;mica colombiana (1 a 6) para asignar valores base.</p></td>
</tr>
<tr>
<td><p><strong>Lectura</strong></p></td>
<td><p>Registro individual de caudal y consumo enviado por el sensor.</p></td>
</tr>
<tr>
<td><p><strong>Alerta</strong></p></td>
<td><p>Notificaci&#243;n autom&#225;tica generada al superar un tope o detectar una fuga.</p></td>
</tr>
<tr>
<td><p><strong>Fuga</strong></p></td>
<td><p>Flujo continuo de agua detectado durante m&#225;s de 30 minutos sin uso aparente.</p></td>
</tr>
<tr>
<td><p><strong>SaaS</strong></p></td>
<td><p>Software as a Service: modelo de negocio por suscripci&#243;n.</p></td>
</tr>
<tr>
<td><p><strong>ARCO</strong></p></td>
<td><p>Derechos de Acceso, Rectificaci&#243;n, Cancelaci&#243;n y Oposici&#243;n (Ley 1581 de 2012).</p></td>
</tr>
<tr>
<td><p><strong>Circuit Breaker</strong></p></td>
<td><p>Patr&#243;n de tolerancia a fallos que evita llamadas a servicios ca&#237;dos.</p></td>
</tr>
<tr>
<td><p><strong>Event Bus</strong></p></td>
<td><p>Sistema de comunicaci&#243;n as&#237;ncrona basado en eventos (publicador/suscriptor).</p></td>
</tr>
<tr>
<td><p><strong>UoW</strong></p></td>
<td><p>Unit of Work: patr&#243;n que agrupa operaciones en una transacci&#243;n ACID.</p></td>
</tr>
<tr>
<td><p><strong>DTO</strong></p></td>
<td><p>Data Transfer Object: objeto que estructura datos entre capas.</p></td>
</tr>
<tr>
<td><p><strong>RBAC</strong></p></td>
<td><p>Role-Based Access Control: control de acceso basado en roles.</p></td>
</tr>
<tr>
<td><p><strong>RLS</strong></p></td>
<td><p>Row Level Security: seguridad a nivel de fila en PostgreSQL.</p></td>
</tr>
</table>






## Referencias.

<table>
<tr>
<td><p><strong>T&#237;tulo del Documento</strong></p></td>
<td><p><strong>Referencia</strong></p></td>
</tr>
<tr>
<td><p>Standard IEEE 830 - 1998</p></td>
<td><p>IEEE, </p></td>
</tr>
<tr>
<td><p>Norma Apa</p></td>
<td><p>Norma APA 7&#170; edici&#243;n</p></td>
</tr>
<tr>
<td><p>Ley 1581 de 2012</p></td>
<td><p>Congreso de Colombia. (2012). Ley de Protecci&#243;n de Datos Personales.</p></td>
</tr>
<tr>
<td><p>ISO/IEC 27001:2022</p></td>
<td><p>Information Security Management Systems.</p></td>
</tr>
<tr>
<td><p>WCAG 2.1</p></td>
<td><p>Web Content Accessibility Guidelines (W3C).</p></td>
</tr>
<tr>
<td><p>Documentaci&#243;n interna</p></td>
<td><p>Acta General del Proyecto (10 feb 2025), Informe de Dise&#241;o v2.0, MER actualizado.</p></td>
</tr>
<tr>
<td><p>Indicador de pr&#225;cticas de ahorro en hogares</p></td>
<td><p>Departamento Administrativo Nacional de Estad&#237;stica (DANE). (2021, 7 de diciembre). <em>En 2020, el 92,2 % de los hogares realizaron al menos una pr&#225;ctica para reducir el consumo de agua y energ&#237;a.</em> <a href="https://www.dane.gov.co/index.php/actualidad-dane/5425-en-2020-el-92-2-de-los-hogares-realizaron-al-menos-una-practica-para-reducir-el-consumo-de-agua-y-energia">Publicaci&#243;n del DANE</a>. El indicador combina agua y energ&#237;a.</p></td>
</tr>
<tr>
<td><p>P&#233;rdidas en sistemas de distribuci&#243;n</p></td>
<td><p>Universidad de los Andes. (2016, 30 de junio). <em>En Colombia, 48 % del agua se pierde en sistemas de distribuci&#243;n.</em> <a href="https://www.uniandes.edu.co/es/noticias/ambiente-y-sostenibilidad/en-colombia-48--del-agua-se-pierde-en-sistemas-de-distribucion">Art&#237;culo de Uniandes</a>. Es un dato de distribuci&#243;n de agua potable, no de consumo intradomiciliario.</p></td>
</tr>
</table>

## Resumen.

El sistema Hidro Smart permitirá a los usuarios visualizar su consumo de agua de forma clara, identificar fugas o patrones anómalos, y recibir sugerencias para optimizar el uso del recurso. El usuario accederá a través de un inicio de sesión seguro, donde podrá consultar estadísticas, reportes, configurar metas de ahorro, activar el modo vacaciones, gestionar dispositivos y solicitar soporte técnico.

El proyecto busca integrar tecnología y conciencia ambiental, ofreciendo una solución práctica para la gestión inteligente del agua en el hogar, con un enfoque en la escalabilidad, la tolerancia a fallos y el cumplimiento normativo.




#  Descripción General.

<strong>HidroSmart es una plataforma de monitoreo de agua conectada a dispositivos IoT. Sus clientes web y móvil permiten consultar y gestionar hogares, dispositivos y consumo; el sistema recopila lecturas, las procesa y las presenta a los usuarios. El sistema se compone de:</strong>

<p>● Un medidor inteligente (ESP32) que registra el caudal de agua y métricas de salud (señal, batería, voltaje, temperatura)

</p>
<p>● Una integración IoT MQTT: Mosquitto local se limita a desarrollo y el firmware dispone de un perfil externo Flespi/TLS; el token y la ACL remotos deben validarse por ambiente.</p>
<p>● Un backend en Node.js que procesa la lógica de negocio, autenticación, alertas y notificaciones.</p>
<p>● Un cliente web React/Vite y un cliente móvil Expo/React Native, con aprovisionamiento BLE móvil que requiere compilación nativa, para visualizar información, generar reportes, configurar metas y gestionar soporte.</p>
<p>● Una base de datos PostgreSQL con políticas de seguridad a nivel de fila (RLS).

</p>
El sistema puede integrarse con servicios en la nube (servicios cloud, Firebase FCM y Redis como alternativas futuras no verificadas) para almacenamiento, análisis avanzado y procesamiento asíncrono.




## Características de los usuarios.




<table>
<tr>
<td><p><strong>Nombre de usuario</strong></p></td>
<td><p>Administrador</p></td>
</tr>
<tr>
<td><p><strong>Formaci&#243;n</strong></p></td>
<td><p>Personal autorizado con conocimientos t&#233;cnicos.</p></td>
</tr>
<tr>
<td><p><strong>Actividades</strong></p></td>
<td><p>Supervisa hogares, usuarios y dispositivos dentro del sistema; gestiona suspensiones/reactivaciones; revisa auditor&#237;as y logs de errores.</p></td>
</tr>
</table>



<table>
<tr>
<td><p><strong>Nombre de usuario</strong></p></td>
<td><p>Soporte T&#233;cnico </p></td>
</tr>
<tr>
<td><p><strong>Formaci&#243;n</strong></p></td>
<td><p>Desarrollador de Software o t&#233;cnico IoT.</p></td>
</tr>
<tr>
<td><p><strong>Actividades</strong></p></td>
<td><p>Realiza mantenimiento, calibraciones y soporte de conectividad; revisa historial de conectividad de dispositivos; gestiona tickets de soporte.</p></td>
</tr>
</table>


<table>
<tr>
<td><p><strong>Nombre de usuario</strong></p></td>
<td><p>Usuario dom&#233;stico</p></td>
</tr>
<tr>
<td><p><strong>Formaci&#243;n</strong></p></td>
<td><p>Persona natural.</p></td>
</tr>
<tr>
<td><p><strong>Actividades</strong></p></td>
<td><p>Monitorea el consumo, genera reportes, sigue ayudas de ahorro, configura metas, activa modo vacaciones, gestiona sus dispositivos y hogares, y solicita soporte t&#233;cnico.</p></td>
</tr>
</table>


##








## Restricciones.


<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.1.1. Requiere conexión a internet estable para la sincronización IoT (aunque se contempla un modo offline parcial para el ESP32).
</p>
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.1.2. Compatible únicamente con Android 9 o superior en su versión inicial (se planea soporte para iOS en futuras versiones.

</p>
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.1.3. Dependencia de hardware compatible con sensores de flujo (YF-S201 o similares) y transmisión Wi-Fi (2.4 GHz).
</p>
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.1.4. La precisión de datos depende de la calibración del dispositivo (factor K y offset), que debe realizarse periódicamente por el soporte técnico.</p>
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.1.5. El desarrollo se realiza con recursos limitados (equipo de 3 aprendices), priorizando herramientas open source y freemium.
</p>

## Suposiciones y dependencias.


<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.1.1. Los usuarios cuentan con dispositivos móviles actualizados y conexión a internet.
</p>
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.1.2. Los medidores IoT están correctamente instalados y calibrados.
</p>
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.1.3. Los requerimientos definidos permanecerán estables durante el desarrollo.
</p>
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.1.4. Las pruebas iniciales se realizarán en un entorno doméstico controlado.</p>
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.1.5. El SRS académico original suponía acceso a GitHub, AWS, Firebase y Redis. Esa suposición no demuestra que AWS, Firebase o Redis formen parte del entorno desplegado; su estado se indica en el anexo.</p>
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.1.6. La disponibilidad de servicios cloud externos no forma parte del corte verificable; el ambiente de referencia es local.

</p>

# Requisitos Específicos.

##

### Requisitos comunes de las interfaces

#### Interfaces de Usuario

La aplicación contará con una interfaz web moderna, intuitiva, responsiva y de fácil navegación, desarrollada con <strong>React + Vite</strong>, que permitirá a los usuarios interactuar con las diferentes funcionalidades del sistema Hidro Smart. La interfaz estará conformada por los siguientes módulos:

<p>● <strong>Inicio de sesión y autenticación:</strong> Permite el registro de usuarios, inicio de sesión, recuperación de contraseña y verificación de identidad. </p>
<p>● <strong>Dashboard:</strong> Muestra el consumo total de agua, flujo actual, estado de los dispositivos IoT, alertas activas, indicadores principales y recomendaciones de ahorro en tiempo real. </p>
<p>● <strong>Gestión de hogares:</strong> Permite crear, consultar, editar, suspender, reactivar y administrar los hogares registrados, así como gestionar sus miembros y permisos. </p>
<p>● <strong>Gestión de dispositivos IoT:</strong> Facilita el registro, configuración, calibración, suspensión, reactivación, desvinculación y consulta del historial de conectividad de los dispositivos inteligentes. </p>
<p>● <strong>Metas y presupuesto:</strong> Permite definir metas de ahorro, establecer presupuestos de consumo, visualizar el progreso y consultar el historial de metas establecidas. </p>
<p>● <strong>Reportes y estadísticas:</strong> Presenta gráficos comparativos, tendencias de consumo, estadísticas históricas y permite exportar la información en formatos PDF y Excel. </p>
<p>● <strong>Notificaciones y alertas:</strong> Administra el historial de notificaciones, la configuración de canales de comunicación y los diferentes tipos de alertas generadas por el sistema. </p>
<p>● <strong>Soporte técnico:</strong> Permite crear, consultar y realizar seguimiento a los tickets de soporte, así como visualizar las respuestas emitidas por el equipo técnico. </p>
<p>● <strong>Configuración del sistema:</strong> Permite administrar el perfil del usuario, preferencias de la aplicación, seguridad de la cuenta, autenticación en dos factores (2FA), privacidad, modo vacaciones y opciones de eliminación de la cuenta.</p>

<strong>Interfaces de Hardware</strong>

<strong>El sistema Hidro Smart interactúa con los siguientes componentes de hardware para la adquisición y transmisión de datos del consumo de agua:</strong>

<p>● <strong>Sensor de caudal (YF-S201 o equivalente): Encargado de medir el flujo de agua y enviar las lecturas al microcontrolador.</strong></p>
<p>● <strong>Microcontrolador ESP32: Dispositivo responsable de procesar las lecturas del sensor, gestionar la conectividad Wi-Fi (2.4 GHz) y transmitir la información al servidor mediante el protocolo MQTT.</strong></p>
<p>● <strong>Red Wi-Fi: Medio de comunicación utilizado por el ESP32 para enviar la telemetría al backend.</strong></p>
<p>● <strong>Equipo cliente: computador o dispositivo con navegador moderno para el cliente React + Vite; Android para la aplicación Expo/React Native que aloja la interfaz web y comunica el puente BLE nativo cuando se instala una compilación compatible.</strong></p>
<p>● <strong>Conexión a Internet: Requerida para la sincronización de datos entre el navegador, el backend y los dispositivos IoT.</strong></p>
<p>● <strong>Pantalla OLED 0.96" (Opcional): Permite visualizar localmente información del dispositivo, como el consumo instantáneo, estado de conexión y mensajes de diagnóstico.</strong></p>
<hr />

<strong>3.1.3 Interfaces de Software</strong>

<strong>Sistema Operativo (Cliente)</strong>

<p>● <strong>Windows 10 o superior.</strong></p>
<p>● <strong>Android  mediante navegadores web modernos.</strong></p>
<strong>Navegadores Compatibles</strong>

<p>● <strong>Google Chrome.</strong></p>
<strong>Frontend</strong>

<p>● <strong>React 19.</strong></p>
<p>● <strong>Vite.</strong></p>
<p>● <strong>JavaScript (ES6+) o TypeScript.</strong></p>
<p>● <strong>React Router DOM.</strong></p>
<p>● <strong>Axios.</strong></p>
<p>● <strong>Tailwind CSS o CSS Modules.</strong></p>
<strong>Backend</strong>

<p>● <strong>Node.js.</strong></p>
<p>● <strong>Express.js.</strong></p>
<strong>Base de Datos</strong>

<p>● <strong>PostgreSQL 15 o superior.</strong></p>
<strong>Broker MQTT</strong>

<p>● <strong>Eclipse Mosquitto (desarrollo).</strong></p>
<p>● <strong>Mosquitto para desarrollo local y perfil de firmware Flespi/TLS para broker externo; verificar credenciales y ACL del entorno.</strong></p>
<strong>Procesamiento Asíncrono</strong>

<p>● <strong>Redis (alternativa propuesta, no verificada como servicio activo).</strong></p>
<p>● <strong>Bull (alternativa propuesta, no verificada como servicio activo).</strong></p>
<strong>Notificaciones</strong>

<p>● <strong>servicio externo de notificaciones (FCM, no verificado).</strong></p>
<strong>Control de Versiones</strong>

<p>● <strong>Git.</strong></p>
<p>● <strong>GitHub.</strong></p>
<hr />

<strong>3.1.4 Interfaces de Comunicación</strong>

<strong>La comunicación entre los diferentes componentes del sistema se realizará mediante los siguientes protocolos y servicios:</strong>

<strong>API REST (HTTPS)</strong>

<strong>La aplicación web se comunica con la API mediante HTTPS. El navegador usa cookies HttpOnly para la sesión y X-CSRF-Token en solicitudes mutables. La API conserva compatibilidad con JWT Bearer para clientes autorizados cuando esa modalidad está habilitada.</strong>

<strong>Authorization: Bearer &lt;token&gt; (compatibilidad para clientes autorizados cuando está habilitada)</strong>

<strong>polling HTTP de 5 segundos en el cliente actual; WSS no verificado</strong>

<strong>WebSocket seguro queda como requisito/evolución; el cliente actual actualiza la interfaz mediante polling HTTP y no se afirma push activo.</strong>

<strong>Flespi/TLS es el perfil externo del ESP32; Mosquitto local sin TLS queda limitado a desarrollo.</strong>

<strong>El firmware dispone de un perfil Flespi que usa MQTT/TLS en el puerto 8883 y valida el certificado CA. La vigencia del token y los permisos ACL deben comprobarse por entorno.</strong>

<strong>Los principales tópicos utilizados serán:</strong>

<p>● <strong>hidrosmart/devices/{deviceCode}/telemetry – Lecturas de consumo de agua y métricas del dispositivo.</strong></p>
<p>● <strong>hidrosmart/devices/{deviceCode}/status – Estado de conexión, disponibilidad y versión del firmware.</strong></p>
<p>● <strong>hidrosmart/devices/{deviceCode}/commands – Comandos dirigidos al dispositivo, incluido el estado de medición.</strong></p>
<p>● </p>
<strong>servicio externo de notificaciones (FCM, no verificado)</strong>

<strong>FCM aparece como alternativa futura no verificada; los correos transaccionales conectados usan Brevo. No se asumen alertas por email/push sin un disparador activo.</strong>

<strong>Correo transaccional mediante Brevo (API HTTPS)</strong>


<strong>La integración usa la API HTTPS de Brevo para los flujos de correo conectados. La entrega debe confirmarse en Brevo; las plantillas de alertas sin disparador activo no se consideran envíos implementados.</strong>

<strong>Redis (TCP)</strong>


<strong>Redis/Bull se conservan como propuesta de procesamiento asíncrono y no deben describirse como servicios activos en el corte técnico 2026-11-04.</strong>




## Requerimientos Funcionales


<strong> RF1. Ingreso, autenticación y seguridad Usuarios:</strong>


RF1.1 Crear Usuario

ERF 1.1.1 Genera tokens de sesión (Access y Refresh)

ERF 1.1.2 Reglas de contraseña

ERF 1.1.3 Asignar roles

RF1.2 Acceso al Sistema

ERF 1.2.1 Bloqueo por intentos fallidos

RF1.3 Recuperar contraseña

RF 1.4 Actualizar perfil

RF 1.5 Suspender cuenta

ERF 1.5.1 Reactivar Usuario

                 RF1.6 Eliminar cuenta propia (Autogestión)


<strong>RF2. Vincular dispositivos</strong>

RF 2.1 Registrar dispositivo

ERF 2.1.1 Valor único ID

RF 2.2 Suspender dispositivos

2.2.1 Reactivar dispositivo

2.2.2 Calibrar Dispositivo

2.2.3 Desvincular Dispositivo

2.2.4 Configurar umbral de alertas

2.2.5 Ver historial de conectividad


<strong>RF3. Implementación de nuevo proyecto (hogar)</strong>

RF 3.1 Crear Proyecto (Hogar)

ERF 3.1.1 Asignar estratificación

ERF 3.1.1.1 Asignar valor base por estrato

RF 3.2 Asignar Usuario titular

ERF 3.2.1 Asignar Usuarios miembros

ERF 3.2.1.1. Asignar funciones especiales

RF 3.3 Asignar dispositivos

RF 3.4 Suspender proyecto (hogar)

ERF 3.4.1 reactivar proyecto (hogar)


<strong>RF4. Configuraciones del sistema</strong>

RF 4.1 Configurar topes de consumo

RF 4.2 Configurar alertas

RF 4.3 Configurar recomendaciones

RF 4.4 Configurar idiomas

ERF 4.4.1 Configurar moneda

RF 4.5 Configuración de colores (gestión global)

RF 4.6 Controles de auditoria

RF 4.7 Modo vacaciones


<strong>RF5. Consultas y/o Reportes PDF y EXCEL</strong>

RF 5.1. Gráficos comparativos

ERF 5.1.1 Gráficos comparativos en tiempo real

ERF 5.1.2 Gráficos comparativos Anuales

ERF 5.1.3 Gráficos comparativos Mensuales

ERF 5.1.4 Gráficos comparativos Semanales

ERF 5.1.5 Gráficos comparativos Diarios

RF 5.2 Hábitos de consumo

RF 5.3 Modelo predictivo

RF 5.4 Alertas

RF 5.5 Recomendaciones

RF 5.6 Proyectos (hogares) asociados al Usuario.

RF 5.7 Metas y presupuesto mensual

RF 5.8 Sistema de soporte técnico


##
Requerimientos Funcionales



#### RF1 – Ingreso, autenticación y seguridad Usuarios


#### RF1.1 – Crear Usuario

<table>
<tr>
<td><p>Tipo</p></td>
<td><p>Usuario</p></td>
</tr>
<tr>
<td><p>Descripci&#243;n</p></td>
<td><p>Permite registrar nuevos usuarios en el sistema mediante el ingreso de datos personales y credenciales de acceso.</p></td>
</tr>
<tr>
<td><p>Entradas</p></td>
<td><p>● • Nombre completo<br />• Correo electr&#243;nico (&#250;nico)<br />• Contrase&#241;a (segura)<br />• Tipo de documento (CC, CE)<br />• N&#250;mero de documento (&#250;nico)<br />• Tel&#233;fono (opcional)<br />• Ciudad (opcional)</p></td>
</tr>
<tr>
<td><p>Salidas</p></td>
<td><p>Confirmaci&#243;n de registro exitoso o mensaje de error por datos inv&#225;lidos.</p></td>
</tr>
<tr>
<td><p>Acci&#243;n</p></td>
<td><p>Validaci&#243;n de datos y almacenamiento en la base de datos de Validaci&#243;n de datos, hash de contrase&#241;a (bcrypt, costo 12), almacenamiento en BD, asignaci&#243;n de rol por defecto (Usuario Dom&#233;stico), generaci&#243;n de JWT (Access + Refresh.</p></td>
</tr>
<tr>
<td><p>Criterio de aceptaci&#243;n</p></td>
<td><p>• Todos los campos obligatorios deben estar completos.<br />• No debe existir duplicidad de correo ni documento.<br />• La contrase&#241;a debe cumplir con ERF 1.1.2.<br />• El usuario recibe correo de bienvenida</p></td>
</tr>
</table>


<strong>ERF1.1.1 – Generación de tokens de sesión (Access y Refresh)</strong>

<table>
<tr>
<td><p>Tipo</p></td>
<td><p>Sistema</p></td>
</tr>
<tr>
<td><p>Descripci&#243;n</p></td>
<td><p>Genera tokens JWT para autenticaci&#243;n stateless despu&#233;s del registro o inicio de sesi&#243;n.</p></td>
</tr>
<tr>
<td><p>Entradas</p></td>
<td><p>Credenciales validadas (usuario ID, rol).</p></td>
</tr>
<tr>
<td><p>Salidas</p></td>
<td><p>● Access Token (expira en 15 minutos) y Refresh Token (expira en 7 d&#237;as).</p></td>
</tr>
<tr>
<td><p>Acci&#243;n</p></td>
<td><p>Creaci&#243;n de tokens cifrados con firma HS256 (secreto JWT), almacenamiento de refresh token en BD para revocaci&#243;n y control de sesiones.</p></td>
</tr>
<tr>
<td><p>Criterio de aceptaci&#243;n</p></td>
<td><p>• Los tokens deben ser &#250;nicos y firmados.<br />• El access token debe tener tiempo limitado (15 min).<br />• El refresh token permite renovaci&#243;n sin re-login.<br />• Los tokens pueden ser revocados individualmente.</p></td>
</tr>
</table>







<strong>ERF1.1.2 – Reglas de contraseña</strong>

<table>
<tr>
<td><p>Tipo</p></td>
<td><p>Sistema</p></td>
</tr>
<tr>
<td><p>Descripci&#243;n</p></td>
<td><p>Aplica pol&#237;ticas de seguridad para la creaci&#243;n de contrase&#241;as robustas.</p></td>
</tr>
<tr>
<td><p>Entradas</p></td>
<td><p>Contrase&#241;a ingresada por el usuario.</p></td>
</tr>
<tr>
<td><p>Salidas</p></td>
<td><p>Validaci&#243;n correcta o mensaje de error con los requisitos.</p></td>
</tr>
<tr>
<td><p>Acci&#243;n</p></td>
<td><p>Evaluaci&#243;n de longitud (≥8), complejidad (may&#250;scula, min&#250;scula, n&#250;mero, s&#237;mbolo) y cifrado con bcrypt.</p></td>
</tr>
<tr>
<td><p>Criterio de aceptaci&#243;n</p></td>
<td><p>• M&#237;nimo 8 caracteres.<br />• Debe incluir al menos una may&#250;scula, una min&#250;scula, un n&#250;mero y un s&#237;mbolo.<br />• La contrase&#241;a se almacena hasheada (nunca en texto plano).<br />• No se permiten contrase&#241;as comunes (ej. &quot;12345678&quot;, &quot;password&quot;).</p></td>
</tr>
</table>




<strong>ERF1.1.3 – Asignar roles</strong>

<table>
<tr>
<td><p>Tipo</p></td>
<td><p>Sistema</p></td>
</tr>
<tr>
<td><p>Descripci&#243;n</p></td>
<td><p>Asigna un rol espec&#237;fico al usuario para definir permisos y accesos dentro del sistema.</p></td>
</tr>
<tr>
<td><p>Entradas</p></td>
<td><p>Rol seleccionado (solo administradores pueden modificar).</p></td>
</tr>
<tr>
<td><p>Salidas</p></td>
<td><p>Rol asignado correctamente</p></td>
</tr>
<tr>
<td><p>Acci&#243;n</p></td>
<td><p>Asociaci&#243;n del rol al usuario en la tabla user_role.</p></td>
</tr>
<tr>
<td><p>Criterio de aceptaci&#243;n</p></td>
<td><p>• El rol debe existir previamente en la tabla roles (Administrador, Soporte T&#233;cnico, Usuario Dom&#233;stico).
• El usuario queda con permisos definidos seg&#250;n el rol.
• El rol por defecto al registrarse es &quot;Usuario Dom&#233;stico&quot;.<br /><br /></p></td>
</tr>
</table>


<strong>RF1.2 – Acceso al sistema</strong>

<table>
<tr>
<td><p>Tipo</p></td>
<td><p>Usuario</p></td>
</tr>
<tr>
<td><p>Descripci&#243;n</p></td>
<td><p>Permite al usuario iniciar sesi&#243;n en el sistema utilizando sus credenciales registradas.</p></td>
</tr>
<tr>
<td><p>Entradas</p></td>
<td><p>● Correo electr&#243;nico</p><p>● Contrase&#241;a</p></td>
</tr>
<tr>
<td><p>Salidas</p></td>
<td><p>Tokens JWT (access + refresh) y datos b&#225;sicos del perfil (sin hash ni informaci&#243;n sensible).</p></td>
</tr>
<tr>
<td><p>Acci&#243;n</p></td>
<td><p>Validaci&#243;n de credenciales (bcrypt compare), verificaci&#243;n de estado de la cuenta (Activa/Suspendida/Bloqueada), actualizaci&#243;n de ultimo_acceso, generaci&#243;n de tokens (ERF 1.1.1).</p></td>
</tr>
<tr>
<td><p>Criterio de aceptaci&#243;n</p></td>
<td><p>• Credenciales correctas → acceso concedido.<br />• Cuenta suspendida → mensaje de error &quot;Cuenta suspendida&quot;.<br />• Credenciales incorrectas → mensaje de error gen&#233;rico (evita enumeraci&#243;n de usuarios).<br />• La sesi&#243;n expira tras 15 minutos de inactividad.</p></td>
</tr>
</table>



<strong>ERF1.2.1 – Bloqueo por intentos fallidos</strong>

<table>
<tr>
<td><p>Tipo</p></td>
<td><p>Sistema</p></td>
</tr>
<tr>
<td><p>Descripci&#243;n</p></td>
<td><p>Bloquea temporalmente la cuenta del usuario tras m&#250;ltiples intentos fallidos de inicio de sesi&#243;n para prevenir ataques de fuerza bruta.</p></td>
</tr>
<tr>
<td><p>Entradas</p></td>
<td><p>N&#250;mero de intentos fallidos (contador en login_attempt).</p></td>
</tr>
<tr>
<td><p>Salidas</p></td>
<td><p>Cuenta bloqueada temporalmente (15 minutos).</p></td>
</tr>
<tr>
<td><p>Acci&#243;n</p></td>
<td><p>Conteo de intentos en login_attempt, bloqueo cuando supera 5 fallos consecutivos, registro de blocked_until. Se reinicia el contador tras un login exitoso.</p></td>
</tr>
<tr>
<td><p>Criterio de aceptaci&#243;n</p></td>
<td><p>• La cuenta se bloquea tras 5 intentos fallidos consecutivos.
• Se muestra mensaje &quot;Demasiados intentos fallidos. Intente de nuevo en 15 minutos&quot;.
• El bloqueo se levanta autom&#225;ticamente tras 15 minutos.
• La acci&#243;n queda registrada en audit_log.<br /><br /><br /></p></td>
</tr>
</table>


<strong>RF1.3 – Recuperar contraseña</strong>

<table>
<tr>
<td><p>Tipo</p></td>
<td><p>Usuario</p></td>
</tr>
<tr>
<td><p>Descripci&#243;n</p></td>
<td><p>Permite al usuario restablecer su contrase&#241;a mediante un enlace temporal enviado a su correo electr&#243;nico registrado.</p></td>
</tr>
<tr>
<td><p>Entradas</p></td>
<td><p>Correo electr&#243;nico</p></td>
</tr>
<tr>
<td><p>Salidas</p></td>
<td><p>Enlace de recuperaci&#243;n enviado (con token) o mensaje de confirmaci&#243;n.</p></td>
</tr>
<tr>
<td><p>Acci&#243;n</p></td>
<td><p>Generaci&#243;n de token &#250;nico (hash), almacenamiento en password_reset_token con expiraci&#243;n (1 hora), env&#237;o de correo con enlace a la URL de restablecimiento (/reset-password?token=...).</p></td>
</tr>
<tr>
<td><p>Criterio de aceptaci&#243;n</p></td>
<td><p>• El enlace debe expirar despu&#233;s de 1 hora.
• El correo debe existir en el sistema (por seguridad, no se indica si existe o no, solo se env&#237;a el correo).
• El token debe ser de un solo uso (se marca used = TRUE al utilizarlo).
• La nueva contrase&#241;a debe cumplir con ERF 1.1.2.<br /><br /><br /></p></td>
</tr>
</table>



<strong>RF1.4 – Actualizar perfil</strong>

<table>
<tr>
<td><p>Tipo</p></td>
<td><p>Usuario</p></td>
</tr>
<tr>
<td><p>Descripci&#243;n</p></td>
<td><p>Permite al usuario modificar su informaci&#243;n personal dentro del sistema.</p></td>
</tr>
<tr>
<td><p>Entradas</p></td>
<td><p>● • Nombre completo<br />• Tel&#233;fono<br />• Ciudad<br />• (Opcional) Foto de perfil (formato JPG/PNG, m&#225;ximo 2MB)</p></td>
</tr>
<tr>
<td><p>Salidas</p></td>
<td><p>Confirmaci&#243;n de actualizaci&#243;n o mensaje de error.</p></td>
</tr>
<tr>
<td><p>Acci&#243;n</p></td>
<td><p>Validaci&#243;n y actualizaci&#243;n de user_profile. Si se sube foto, se almacena en almacenamiento externo no verificado (o local) y se actualiza la URL en user_profile.</p></td>
</tr>
<tr>
<td><p>Criterio de aceptaci&#243;n</p></td>
<td><p>• Los datos deben guardarse correctamente en BD.
• Cambios sensibles (ej. correo electr&#243;nico) requieren verificaci&#243;n por correo.
• La foto de perfil se almacena de forma segura y se asocia al usuario.
• La acci&#243;n queda registrada en audit_log.<br /><br /><br /></p></td>
</tr>
</table>



<strong>RF1.5 – Suspender cuenta</strong>

<table>
<tr>
<td><p>Tipo</p></td>
<td><p>Administrador</p></td>
</tr>
<tr>
<td><p>Descripci&#243;n</p></td>
<td><p>Permite a un administrador suspender o reactivar cuentas de usuario para restringir o restaurar el acceso al sistema.</p></td>
</tr>
<tr>
<td><p>Entradas</p></td>
<td><p>• Usuario seleccionado<br />• Motivo de suspensi&#243;n (obligatorio)</p></td>
</tr>
<tr>
<td><p>Salidas</p></td>
<td><p>Cuenta suspendida o reactivada con confirmaci&#243;n.</p></td>
</tr>
<tr>
<td><p>Acci&#243;n</p></td>
<td><p>Cambio de estado en user_account (status: &#39;Suspended&#39; / &#39;Active&#39;), registro de suspension_reason, suspended_by y suspended_at.</p></td>
</tr>
<tr>
<td><p>Criterio de aceptaci&#243;n</p></td>
<td><p>• El usuario suspendido no puede iniciar sesi&#243;n.
• El usuario reactivado recupera acceso inmediato.
• La acci&#243;n queda registrada en audit_log con el motivo y el administrador responsable.
• Se env&#237;a notificaci&#243;n por correo al usuario afectado<br /><br /><br /></p></td>
</tr>
</table>



<strong>ERF1.5.1 – Reactivar usuario</strong>

<table>
<tr>
<td><p>Tipo</p></td>
<td><p>Administrador</p></td>
</tr>
<tr>
<td><p>Descripci&#243;n</p></td>
<td><p>Permite reactivar una cuenta de usuario previamente suspendida, restaurando su acceso al sistema.</p></td>
</tr>
<tr>
<td><p>Entradas</p></td>
<td><p>Usuario suspendido</p></td>
</tr>
<tr>
<td><p>Salidas</p></td>
<td><p>Cuenta reactivada</p></td>
</tr>
<tr>
<td><p>Acci&#243;n</p></td>
<td><p>Cambio de estado a &#39;Active&#39; y limpieza de suspension_reason y suspended_at.</p></td>
</tr>
<tr>
<td><p>Criterio de aceptaci&#243;n</p></td>
<td><p>• El usuario reactivado puede iniciar sesi&#243;n normalmente.
• La reactivaci&#243;n queda registrada en audit_log con el administrador responsable.
• Se env&#237;a notificaci&#243;n por correo al usuario.<br /><br /></p></td>
</tr>
</table>




<strong>ERF1.6 – Reactivar usuario</strong>

<table>
<tr>
<td><p>Tipo</p></td>
<td><p>Usuario</p><p>&nbsp;</p></td>
</tr>
<tr>
<td><p>Descripci&#243;n</p></td>
<td><p>Permite al usuario eliminar su cuenta de forma permanente (soft delete), anonimizando sus datos personales y revocando todos los tokens de acceso, en cumplimiento del derecho al olvido (Ley 1581 de 2012).</p></td>
</tr>
<tr>
<td><p>Entradas</p></td>
<td><p>Confirmaci&#243;n de eliminaci&#243;n (checkbox de aceptaci&#243;n y doble verificaci&#243;n de contrase&#241;a).</p></td>
</tr>
<tr>
<td><p>Salidas</p></td>
<td><p>Confirmaci&#243;n de eliminaci&#243;n, cierre de sesi&#243;n autom&#225;tico y correo de notificaci&#243;n.</p></td>
</tr>
<tr>
<td><p>Acci&#243;n</p></td>
<td><p>Marca&#160;deleted_at&#160;en&#160;user_account, anonimiza datos personales en&#160;user_profile&#160;(nombre → &quot;Usuario eliminado&quot;, correo →&#160;deleted_{id}@hidrosmart.com, documento →&#160;0000000000), revoca todos los tokens JWT activos en&#160;token&#160;y cierra todas las sesiones en&#160;session.</p></td>
</tr>
<tr>
<td><p>Criterio de aceptaci&#243;n</p></td>
<td><p>• La cuenta queda marcada como eliminada y no permite inicio de sesi&#243;n.
• Los datos personales se anonimizan irreversiblemente.
• Los hogares donde el usuario era titular deben ser reasignados a otro miembro (o suspendidos).
• Los dispositivos asociados se desvinculan autom&#225;ticamente.
• El historial de consumo se conserva anonimizado para estad&#237;sticas agregadas.
• La acci&#243;n es irreversible y queda registrada en audit_log.
• Se env&#237;a correo de confirmaci&#243;n al usuario.
• El usuario tiene un per&#237;odo de gracia de 7 d&#237;as para cancelar la solicitud (opcional, si se implementa).<br /><br /><br /><br /><br /><br /><br /></p></td>
</tr>
</table>



#### RF2 – Vincular Dispositivos


<strong>RF2.1 – Registrar dispositivo</strong>

<table>
<tr>
<td><p>Tipo</p></td>
<td><p>Usuario (Titular del hogar)</p></td>
</tr>
<tr>
<td><p>Descripci&#243;n</p></td>
<td><p>Permite registrar un dispositivo IoT (ESP32) en el sistema y vincularlo a un hogar espec&#237;fico para su monitoreo y control.</p></td>
</tr>
<tr>
<td><p>Entradas</p></td>
<td><p>● • C&#243;digo &#250;nico del dispositivo (MAC o UUID)<br />• Nombre descriptivo<br />• Tipo de dispositivo (caudal, nivel, humedad)<br />• Hogar (ID)<br />• Ubicaci&#243;n espec&#237;fica (opcional)<br />• Umbral de alerta (m&#179;/hora, opcional – ver RF2.5)</p></td>
</tr>
<tr>
<td><p>Salidas</p></td>
<td><p>Confirmaci&#243;n de registro exitoso con ID generado (UUID) y datos del dispositivo registrado.</p></td>
</tr>
<tr>
<td><p>Acci&#243;n</p></td>
<td><p>Validaci&#243;n de unicidad del c&#243;digo, creaci&#243;n del dispositivo en device (estado &#39;Active&#39;), vinculaci&#243;n al hogar en home_device (estado &#39;Active&#39;) y registro en device_history con el evento &quot;Registro inicial&quot;.</p></td>
</tr>
<tr>
<td><p>Criterio de aceptaci&#243;n</p></td>
<td><p>&nbsp;</p><table>
<tr>
<td><p>• El c&#243;digo del dispositivo debe ser &#250;nico en todo el sistema.
• El dispositivo no debe estar previamente registrado en otro hogar.
• El hogar debe existir y el usuario debe ser titular o miembro con permisos.
• La acci&#243;n queda registrada en audit_log.<br /><br /><br /></p></td>
</tr>
</table>

<p>&nbsp;</p></td>
</tr>
</table>



<strong>ERF2.1.1 – Asignar valor único ID</strong>

<table>
<tr>
<td><p>Tipo</p></td>
<td><p>Sistema</p></td>
</tr>
<tr>
<td><p>Descripci&#243;n</p></td>
<td><p>Asigna un identificador &#250;nico al dispositivo para garantizar su correcta identificaci&#243;n dentro del sistema.</p></td>
</tr>
<tr>
<td><p>Entradas</p></td>
<td><p>Datos del dispositivo (c&#243;digo, nombre, tipo).</p></td>
</tr>
<tr>
<td><p>Salidas</p></td>
<td><p>ID &#250;nico asignado (UUID).</p></td>
</tr>
<tr>
<td><p>Acci&#243;n</p></td>
<td><p>Generaci&#243;n autom&#225;tica de UUID mediante gen_random_uuid() (PostgreSQL) o asignaci&#243;n desde el c&#243;digo del dispositivo.</p></td>
</tr>
<tr>
<td><p>Criterio de aceptaci&#243;n</p></td>
<td><p>&nbsp;</p><table>
<tr>
<td><p>• El ID no debe repetirse en toda la base de datos.<br />• El ID queda asociado al dispositivo permanentemente.<br />• El ID se utiliza como referencia en todas las operaciones posteriores.</p></td>
</tr>
</table>

<p>&nbsp;</p></td>
</tr>
<tr>
<td><p>&nbsp;</p></td>
<td><p>&nbsp;</p></td>
</tr>
</table>


<strong>RF2.2 – Suspender dispositivo</strong>

<table>
<tr>
<td><p>Tipo</p></td>
<td><p>Usuario (Titular del hogar) / Administrador</p></td>
</tr>
<tr>
<td><p>Descripci&#243;n</p></td>
<td><p>Permite suspender un dispositivo para detener temporalmente su monitoreo y generaci&#243;n de alertas, sin eliminar su registro.</p></td>
</tr>
<tr>
<td><p>Entradas</p></td>
<td><p>• Dispositivo seleccionado<br />• Motivo de suspensi&#243;n (opcional)</p></td>
</tr>
<tr>
<td><p>Salidas</p></td>
<td><p>Confirmaci&#243;n de suspensi&#243;n con fecha y motivo.</p></td>
</tr>
<tr>
<td><p>Acci&#243;n</p></td>
<td><p>Cambio de estado en device (status: &#39;Suspended&#39;), registro en device_history con estado anterior y nuevo, y motivo.</p></td>
</tr>
<tr>
<td><p>Criterio de aceptaci&#243;n</p></td>
<td><p>• El dispositivo suspendido no debe enviar datos ni generar alertas.
• Las lecturas hist&#243;ricas del dispositivo permanecen en la BD.
• La acci&#243;n queda registrada en audit_log y device_history.
• Solo el titular del hogar o administrador puede suspender.<br /><br /><br /></p></td>
</tr>
</table>


<strong>ERF2.2.1 – Reactivar dispositivo</strong>

<table>
<tr>
<td><p>Tipo</p></td>
<td><p>Usuario (Titular del hogar) / Administrador</p></td>
</tr>
<tr>
<td><p>Descripci&#243;n</p></td>
<td><p>Permite reactivar un dispositivo previamente suspendido para reanudar su monitoreo y generaci&#243;n de alertas.</p></td>
</tr>
<tr>
<td><p>Entradas</p></td>
<td><p>Dispositivo suspendido</p></td>
</tr>
<tr>
<td><p>Salidas</p></td>
<td><p>Confirmaci&#243;n de reactivaci&#243;n.</p></td>
</tr>
<tr>
<td><p>Acci&#243;n</p></td>
<td><p>Cambio de estado en device (status: &#39;Active&#39;), registro en device_history con estado anterior y nuevo.</p></td>
</tr>
<tr>
<td><p>Criterio de aceptaci&#243;n</p></td>
<td><p>• El dispositivo reactivado debe reanudar el env&#237;o de telemetr&#237;a.
• Las reglas de alerta vuelven a aplicarse al dispositivo.
• La acci&#243;n queda registrada en audit_log y device_history.
• Solo el titular del hogar o administrador puede reactivar.<br /><br /><br /></p></td>
</tr>
<tr>
<td><p>&nbsp;</p><p>&nbsp;</p></td>
<td><p>&nbsp;</p></td>
</tr>
</table>


<strong>RF2.3 – Calibrar dispositivo (Factor K y Offset)</strong>

<table>
<tr>
<td><p>Tipo</p></td>
<td><p>Soporte T&#233;cnico / Administrador</p></td>
</tr>
<tr>
<td><p>Descripci&#243;n</p></td>
<td><p>Permite ajustar los par&#225;metros de calibraci&#243;n del sensor (factor de calibraci&#243;n K y offset) para mejorar la precisi&#243;n de las lecturas de caudal.</p></td>
</tr>
<tr>
<td><p>Entradas</p></td>
<td><p>• Factor de calibraci&#243;n (K) – decimal positivo<br />• Offset – decimal (puede ser negativo)<br />• Motivo de la calibraci&#243;n</p></td>
</tr>
<tr>
<td><p>Salidas</p></td>
<td><p>Dispositivo calibrado con nuevos par&#225;metros y confirmaci&#243;n de actualizaci&#243;n.</p></td>
</tr>
<tr>
<td><p>Acci&#243;n</p></td>
<td><p>Actualiza calibration_factor y calibration_offset en device, y registra el cambio en calibration_history con valores anteriores, nuevos, motivo y usuario responsable.</p></td>
</tr>
<tr>
<td><p>Criterio de aceptaci&#243;n</p></td>
<td><p>• Solo soporte t&#233;cnico o administradores pueden calibrar.
• El historial de calibraciones debe mantenerse para auditor&#237;a (tabla calibration_history).
• Los nuevos valores afectan las lecturas futuras en tiempo real.
• El factor K debe ser &gt; 0.
• La acci&#243;n queda registrada en audit_log.<br /><br /><br /><br /></p></td>
</tr>
</table>



<strong> RF2.4 – Desvincular dispositivo del hogar</strong>

<table>
<tr>
<td><p>Tipo</p></td>
<td><p>Usuario (Titular del hogar)</p></td>
</tr>
<tr>
<td><p>Descripci&#243;n</p></td>
<td><p>Permite desvincular un dispositivo IoT de un hogar, dej&#225;ndolo disponible para ser asignado a otro hogar, sin eliminar su registro ni su historial de lecturas.</p></td>
</tr>
<tr>
<td><p>Entradas</p></td>
<td><p>•  Hogar ID<br />• Dispositivo ID</p></td>
</tr>
<tr>
<td><p>Salidas</p></td>
<td><p>Confirmaci&#243;n de desvinculaci&#243;n exitosa.</p></td>
</tr>
<tr>
<td><p>Acci&#243;n</p></td>
<td><p>Cambia el estado de la relaci&#243;n en home_device a &#39;Suspended&#39; (o elimina la relaci&#243;n) y registra fecha_desasignacion. El dispositivo queda sin hogar asignado.</p></td>
</tr>
<tr>
<td><p>Criterio de aceptaci&#243;n</p></td>
<td><p>• El dispositivo deja de estar asociado al hogar y no genera m&#225;s lecturas para ese hogar.
• El dispositivo puede ser reasignado a otro hogar sin conflicto.
• Las lecturas hist&#243;ricas del dispositivo permanecen en la BD.
• La acci&#243;n queda registrada en audit_log.
• Solo el titular del hogar puede desvincular.<br /><br /><br /><br /></p></td>
</tr>
</table>



<strong>RF2.5 – Configurar umbral de alerta por dispositivo</strong>

<table>
<tr>
<td><p>Tipo</p></td>
<td><p>Usuario (Titular del hogar)</p></td>
</tr>
<tr>
<td><p>Descripci&#243;n</p></td>
<td><p>Permite configurar un umbral de alerta individual para cada dispositivo (en litros/minuto o m&#179;/hora), que prevalece sobre el umbral general del hogar cuando est&#225; definido.</p></td>
</tr>
<tr>
<td><p>Entradas</p></td>
<td><p>• Dispositivo ID<br />• Valor del umbral (m&#179;/h)</p></td>
</tr>
<tr>
<td><p>Salidas</p></td>
<td><p>Umbral guardado en device.umbral_alerta y confirmaci&#243;n de configuraci&#243;n.</p></td>
</tr>
<tr>
<td><p>Acci&#243;n</p></td>
<td><p>Actualiza la columna umbral_alerta en device. Al recibir una lectura, se eval&#250;a primero el umbral del dispositivo; si no existe, se usa el umbral general del hogar.</p></td>
</tr>
<tr>
<td><p>Criterio de aceptaci&#243;n</p></td>
<td><p>• El umbral por dispositivo prevalece sobre el umbral general del hogar si est&#225; configurado.
• Si no se configura, se usa el umbral del hogar o el valor por defecto.
• El valor debe ser &gt; 0.
• La acci&#243;n queda registrada en audit_log.<br /><br /><br /></p></td>
</tr>
</table>



<strong>RF2.6 – Ver historial de conectividad del dispositivo</strong>

<table>
<tr>
<td><p>Tipo</p></td>
<td><p>Usuario / Soporte T&#233;cnico</p></td>
</tr>
<tr>
<td><p>Descripci&#243;n</p></td>
<td><p>Permite consultar el historial de m&#233;tricas de salud del dispositivo (calidad de se&#241;al, nivel de bater&#237;a, voltaje y temperatura) para diagn&#243;stico t&#233;cnico y visualizaci&#243;n gr&#225;fica en el frontend (React + Vite con gr&#225;ficos de recharts).</p></td>
</tr>
<tr>
<td><p>Entradas</p></td>
<td><p>• Dispositivo ID<br />• Rango de fechas (opcional, por defecto &#250;ltimos 7 d&#237;as)</p></td>
</tr>
<tr>
<td><p>Salidas</p></td>
<td><p>Datos hist&#243;ricos agrupados por d&#237;a/hora para graficar tendencias (se&#241;al, bater&#237;a, voltaje, temperatura).</p></td>
</tr>
<tr>
<td><p>Acci&#243;n</p></td>
<td><p>Consulta a la tabla device_telemetry_history con filtros por device_id y rango de fechas. Los datos se devuelven en formato JSON para ser renderizados en el frontend.</p></td>
</tr>
<tr>
<td><p>Criterio de aceptaci&#243;n</p></td>
<td><p>• El historial debe conservarse al menos 30 d&#237;as.
• Debe permitir consultas por rango de fechas (&#250;ltimos 7 d&#237;as, 30 d&#237;as, etc.).
• Los datos se devuelven en formato JSON con estructura [{ recorded_at, signal_quality, battery_level, voltage, temperature }].
• Solo usuarios con acceso al hogar pueden ver el historial de sus dispositivos.
• La consulta debe ser eficiente (&#237;ndices por device_id y recorded_at).
• El historial se actualiza autom&#225;ticamente cada vez que el dispositivo env&#237;a telemetr&#237;a MQTT.<br /><br /><br /><br /><br /></p></td>
</tr>
</table>




#### RF3 – Implementación de nuevo proyecto (hogar)


<strong>RF3.1 – Crear proyecto (hogar)</strong>

<table>
<tr>
<td><p>Tipo</p></td>
<td><p>Usuario</p></td>
</tr>
<tr>
<td><p>Descripci&#243;n</p></td>
<td><p>Permite crear un nuevo hogar dentro del sistema, que agrupar&#225; usuarios, dispositivos y configuraciones de consumo.</p></td>
</tr>
<tr>
<td><p>Entradas</p></td>
<td><p>• Nombre del hogar<br />• Direcci&#243;n<br />• Ciudad<br />• Estrato socioecon&#243;mico (1-6)<br />• Tope de consumo mensual (opcional)</p></td>
</tr>
<tr>
<td><p>Salidas</p></td>
<td><p>Hogar creado con ID asignado y confirmaci&#243;n.</p></td>
</tr>
<tr>
<td><p>Acci&#243;n</p></td>
<td><p>Inserci&#243;n en home, asignaci&#243;n autom&#225;tica del usuario creador como Titular en home_user (rol &#39;Owner&#39;), y registro en audit_log.</p></td>
</tr>
<tr>
<td><p>Criterio de aceptaci&#243;n</p></td>
<td><p>&nbsp;</p><table>
<tr>
<td><p>• Todos los campos obligatorios deben completarse.
• El hogar queda activo por defecto (status &#39;Active&#39;).
• El usuario creador es el titular (Owner) autom&#225;ticamente.
• No puede existir otro hogar con el mismo nombre para el mismo usuario.
• La acci&#243;n queda registrada en audit_log.<br /><br /><br /><br /></p></td>
</tr>
</table>

<p>&nbsp;</p></td>
</tr>
</table>

####

#### ERF3.1.1 – Asignar estratificación

<table>
<tr>
<td><p>Tipo</p></td>
<td><p><strong>Sistema</strong></p></td>
</tr>
<tr>
<td><p>Descripci&#243;n</p></td>
<td><p>Asigna el estrato socioecon&#243;mico al hogar para fines de an&#225;lisis, c&#225;lculo de tarifas y subsidios.</p></td>
</tr>
<tr>
<td><p>Entradas</p></td>
<td><p>Estrato (1-6).</p></td>
</tr>
<tr>
<td><p>Salidas</p></td>
<td><p>Estrato asignado en home.tier.</p></td>
</tr>
<tr>
<td><p>Acci&#243;n</p></td>
<td><p>Actualizaci&#243;n de la columna tier en home con el valor seleccionado.</p></td>
</tr>
<tr>
<td><p>Criterio de aceptaci&#243;n</p></td>
<td><p>• El estrato debe estar entre 1 y 6.
• El sistema asigna autom&#225;ticamente un valor base de tarifa seg&#250;n el estrato (definido en estratos).
• El estrato puede ser modificado posteriormente por el titular.<br /><br /></p></td>
</tr>
</table>



<strong>ERF3.1.1.1 – Asignar valor</strong>

<table>
<tr>
<td><p>Tipo</p></td>
<td><p>Sistema</p></td>
</tr>
<tr>
<td><p>Descripci&#243;n</p></td>
<td><p>Asigna un valor base de tarifa (costo por m&#179;) seg&#250;n el estrato socioecon&#243;mico del hogar.</p></td>
</tr>
<tr>
<td><p>Entradas</p></td>
<td><p>Estrato asignado</p></td>
</tr>
<tr>
<td><p>Salidas</p></td>
<td><p>Valor base definido en home_rate (tabla de tarifas).</p></td>
</tr>
<tr>
<td><p>Acci&#243;n</p></td>
<td><p>Al crear el hogar, el sistema consulta la tabla estratos y crea autom&#225;ticamente un registro en home_rate con el valor_m3 correspondiente y la fecha de vigencia.</p></td>
</tr>
<tr>
<td><p>Criterio de aceptaci&#243;n</p></td>
<td><p>&nbsp;</p><table>
<tr>
<td><p>• El valor debe corresponder al estrato seleccionado.<br />• La tarifa se crea con vigencia desde la fecha de creaci&#243;n del hogar.<br />• El titular puede modificar la tarifa manualmente si lo desea (RF4.4.1).</p></td>
</tr>
</table>

<p>&nbsp;</p></td>
</tr>
</table>



<strong>RF3.2 – Asignar usuario titular</strong>

<table>
<tr>
<td><p>Tipo</p></td>
<td><p><strong>Sistema</strong></p></td>
</tr>
<tr>
<td><p>Descripci&#243;n</p></td>
<td><p>Define un usuario titular (Owner) responsable del hogar, con permisos de administraci&#243;n total sobre el mismo.</p></td>
</tr>
<tr>
<td><p>Entradas</p></td>
<td><p>• Hogar ID<br />• Usuario ID</p></td>
</tr>
<tr>
<td><p>Salidas</p></td>
<td><p>Usuario asignado como titular.</p></td>
</tr>
<tr>
<td><p>Acci&#243;n</p></td>
<td><p>Inserci&#243;n o actualizaci&#243;n en home_user con home_role = &#39;Owner&#39;. Si ya existe un titular, se puede transferir la titularidad (solo el titular actual puede hacerlo).</p></td>
</tr>
<tr>
<td><p>Criterio de aceptaci&#243;n</p></td>
<td><p>• El usuario debe existir en el sistema.
• Solo puede existir un titular (Owner) por hogar.
• El titular puede invitar, eliminar miembros y administrar el hogar.
• La asignaci&#243;n queda registrada en audit_log.<br /><br /><br /></p></td>
</tr>
</table>



<strong>ERF3.2.1 – Asignar usuarios miembros</strong>

<table>
<tr>
<td><p>Tipo</p></td>
<td><p><strong>Usuario (Titular)</strong></p></td>
</tr>
<tr>
<td><p>Descripci&#243;n</p></td>
<td><p>Permite agregar otros usuarios como miembros (Member, Guest) del hogar, otorg&#225;ndoles diferentes niveles de acceso.</p></td>
</tr>
<tr>
<td><p>Entradas</p></td>
<td><p>• Correo electr&#243;nico del usuario a invitar<br />• Rol (Member o Guest)</p></td>
</tr>
<tr>
<td><p>Salidas</p></td>
<td><p>Usuario asociado al hogar con el rol asignado.</p></td>
</tr>
<tr>
<td><p>Acci&#243;n</p></td>
<td><p>Inserci&#243;n en home_user con home_role definido (&#39;Member&#39; o &#39;Guest&#39;) y registro de added_by (usuario que invit&#243;).</p></td>
</tr>
<tr>
<td><p>Criterio de aceptaci&#243;n</p></td>
<td><p>• El usuario invitado debe existir en el sistema.
• No se puede duplicar la misma relaci&#243;n usuario-hogar.
• El invitado recibe una notificaci&#243;n por correo.
• La acci&#243;n queda registrada en audit_log.<br /><br /><br /></p></td>
</tr>
</table>



<strong>ERF3.2.1.1 – Asignar funciones especiales</strong>

<table>
<tr>
<td><p>Tipo</p></td>
<td><p><strong>Usuario (Titular)</strong></p></td>
</tr>
<tr>
<td><p>Descripci&#243;n</p></td>
<td><p>Permite asignar funciones o permisos especiales a determinados miembros del hogar, otorg&#225;ndoles capacidades adicionales m&#225;s all&#225; de las de su rol base.</p></td>
</tr>
<tr>
<td><p>Entradas</p></td>
<td><p>• Miembro (ID de home_user)
• Funci&#243;n (ej. &#39;administrar_device&#39;, &#39;ver_reportes&#39;, &#39;configurar_alertas&#39;)<br /></p></td>
</tr>
<tr>
<td><p>Salidas</p></td>
<td><p>Funci&#243;n asignada correctamente al miembro.</p></td>
</tr>
<tr>
<td><p>Acci&#243;n</p></td>
<td><p>Inserci&#243;n en home_user_function con la funci&#243;n y el usuario que la asign&#243; (assigned_by).</p></td>
</tr>
<tr>
<td><p>Criterio de aceptaci&#243;n</p></td>
<td><p>• Las funciones deben estar predefinidas en el sistema (cat&#225;logo).
• Un miembro puede tener m&#250;ltiples funciones.
• Las funciones pueden ser revocadas por el titular.
• La asignaci&#243;n queda registrada en audit_log.<br /><br /><br /></p></td>
</tr>
</table>



<strong>RF3.3 – Asignar dispositivos</strong>

<table>
<tr>
<td><p>Tipo</p></td>
<td><p><strong>Usuario (Titular)</strong></p></td>
</tr>
<tr>
<td><p>Descripci&#243;n</p></td>
<td><p>Permite asociar dispositivos IoT previamente registrados al hogar correspondiente, activando su monitoreo para ese hogar.</p></td>
</tr>
<tr>
<td><p>Entradas</p></td>
<td><p>• Hogar ID<br />• Dispositivo ID</p></td>
</tr>
<tr>
<td><p>Salidas</p></td>
<td><p>Dispositivo vinculado al hogar.</p></td>
</tr>
<tr>
<td><p>Acci&#243;n</p></td>
<td><p>Inserci&#243;n o actualizaci&#243;n en home_device con estado &#39;Active&#39; y fecha de asignaci&#243;n.</p></td>
</tr>
<tr>
<td><p>Criterio de aceptaci&#243;n</p></td>
<td><p>• El dispositivo debe estar registrado en el sistema.
• El dispositivo no puede estar activo en otro hogar simult&#225;neamente.
• Si el dispositivo ya estaba en otro hogar, debe ser desvinculado primero (RF2.4).
• La acci&#243;n queda registrada en audit_log.<br /><br /><br /></p></td>
</tr>
</table>


<strong>RF3.4 – Suspender proyecto (hogar)</strong>

<table>
<tr>
<td><p>Tipo</p></td>
<td><p><strong>Usuario (Titular)</strong></p></td>
</tr>
<tr>
<td><p>Descripci&#243;n</p></td>
<td><p>Permite suspender temporalmente un hogar, deteniendo la generaci&#243;n de alertas y notificaciones, pero manteniendo el almacenamiento de lecturas.</p></td>
</tr>
<tr>
<td><p>Entradas</p></td>
<td><p>• Hogar seleccionado<br />• Motivo de suspensi&#243;n (opcional)</p></td>
</tr>
<tr>
<td><p>Salidas</p></td>
<td><p>Hogar suspendido con confirmaci&#243;n.</p></td>
</tr>
<tr>
<td><p>Acci&#243;n</p></td>
<td><p>Cambio de estado en&#160;home.status&#160;(&#39;Active&#39; → &#39;Suspended&#39;), registro de&#160;suspension_reason,&#160;changed_at_status&#160;y&#160;suspended_by.</p></td>
</tr>
<tr>
<td><p>Criterio de aceptaci&#243;n</p></td>
<td><p>• El hogar suspendido no debe generar alertas ni notificaciones.
• Las lecturas de los dispositivos siguen almacen&#225;ndose.
• Los usuarios miembros no pueden realizar acciones en el hogar suspendido (solo el titular puede reactivar).
• La acci&#243;n queda registrada en audit_log.<br /><br /><br /></p></td>
</tr>
</table>


<strong>ERF3.4.1 – Reactivar proyecto (hogar)</strong>

<table>
<tr>
<td><p>Tipo</p></td>
<td><p><strong>Usuario (Titular del hogar)</strong></p></td>
</tr>
<tr>
<td><p>Descripci&#243;n</p></td>
<td><p>Permite reactivar un hogar previamente suspendido, restaurando su funcionamiento normal y la generaci&#243;n de alertas.</p></td>
</tr>
<tr>
<td><p>Entradas</p></td>
<td><p>Hogar suspendido</p></td>
</tr>
<tr>
<td><p>Salidas</p></td>
<td><p>Hogar reactivado y funcionando normalmente.</p></td>
</tr>
<tr>
<td><p>Acci&#243;n</p></td>
<td><p>Cambio de estado en&#160;home.status&#160;(&#39;Suspended&#39; → &#39;Active&#39;), limpieza de&#160;suspension_reason&#160;y registro en&#160;audit_log.</p></td>
</tr>
<tr>
<td><p>Criterio de aceptaci&#243;n</p></td>
<td><p>• El hogar reactivado vuelve a generar alertas y notificaciones.
• Los usuarios miembros recuperan acceso al hogar.
• La reactivaci&#243;n queda registrada en audit_log.<br /><br /></p></td>
</tr>
</table>



#### RF4 – Configuraciones del sistema


#### RF4.1 – Configurar topes de consumo

<table>
<tr>
<td><p>Tipo</p></td>
<td><p>Usuario (Titular del hogar)</p></td>
</tr>
<tr>
<td><p>Descripci&#243;n</p></td>
<td><p>Define l&#237;mites m&#225;ximos de consumo de agua para un hogar (diario y mensual), con el fin de controlar y prevenir consumos excesivos y activar alertas autom&#225;ticas.</p></td>
</tr>
<tr>
<td><p>Entradas</p></td>
<td><p>• Tope diario (m&#179;)<br />• Tope mensual (m&#179;)</p></td>
</tr>
<tr>
<td><p>Salidas</p></td>
<td><p>Configuraci&#243;n guardada en threshold_configuration y confirmaci&#243;n.</p></td>
</tr>
<tr>
<td><p>Acci&#243;n</p></td>
<td><p>Inserci&#243;n o actualizaci&#243;n en threshold_configuration. Los topes se utilizan para evaluar alertas en tiempo real cuando se reciben lecturas del sensor.</p></td>
</tr>
<tr>
<td><p>Criterio de aceptaci&#243;n</p></td>
<td><p>• Los valores deben ser num&#233;ricos y positivos.
• Al menos uno de los dos topes debe estar definido.
• Los topes pueden ser modificados en cualquier momento por el titular.
• La acci&#243;n queda registrada en audit_log.<br /><br /><br /></p></td>
</tr>
</table>



<strong>RF4.2 – Configurar alertas</strong>

<table>
<tr>
<td><p>Tipo</p></td>
<td><p>Usuario (Titular del hogar)</p></td>
</tr>
<tr>
<td><p>Descripci&#243;n</p></td>
<td><p>Permite configurar reglas de alerta personalizadas para el hogar, definiendo umbrales, tipos de alerta y su activaci&#243;n.</p></td>
</tr>
<tr>
<td><p>Entradas</p></td>
<td><p>• Tipo de alerta (consumo_excesivo, fuga_detectada, tope_mensual, tope_diario, sin_lectura)<br />• Umbral (valor num&#233;rico)<br />• Unidad (m3_dia, m3_mes, lpm)<br />• Activa/Inactiva (booleano)</p></td>
</tr>
<tr>
<td><p>Salidas</p></td>
<td><p>Regla de alerta creada en alert_rule y confirmaci&#243;n.</p></td>
</tr>
<tr>
<td><p>Acci&#243;n</p></td>
<td><p>Inserci&#243;n en alert_rule con los par&#225;metros definidos. El sistema eval&#250;a las reglas activas cada vez que se recibe una nueva lectura.</p></td>
</tr>
<tr>
<td><p>Criterio de aceptaci&#243;n</p></td>
<td><p>&nbsp;</p><table>
<tr>
<td><p>• El umbral debe ser un n&#250;mero positivo.
• La unidad debe coincidir con el tipo de alerta.
• La regla se activa autom&#225;ticamente si activa = true.
• Las reglas pueden ser desactivadas sin ser eliminadas.
• La acci&#243;n queda registrada en audit_log.<br /><br /><br /><br /></p></td>
</tr>
</table>

<p>&nbsp;</p></td>
</tr>
</table>



<strong>RF4.3 – Configurar recomendaciones</strong>

<table>
<tr>
<td><p>Tipo</p></td>
<td><p>Sistema (Autom&#225;tico)</p></td>
</tr>
<tr>
<td><p>Descripci&#243;n</p></td>
<td><p>Permite configurar la generaci&#243;n autom&#225;tica de recomendaciones de ahorro basadas en los h&#225;bitos de consumo del hogar, analizando patrones hist&#243;ricos.</p></td>
</tr>
<tr>
<td><p>Entradas</p></td>
<td><p>Datos hist&#243;ricos de consumo (lecturas de sensor_reading).</p></td>
</tr>
<tr>
<td><p>Salidas</p></td>
<td><p>Recomendaciones personalizadas generadas en user_recommendation.</p></td>
</tr>
<tr>
<td><p>Acci&#243;n</p></td>
<td><p>An&#225;lisis de patrones de consumo (horas pico, d&#237;as de mayor consumo, actividades) y comparaci&#243;n con umbrales definidos en recommendation. Se ejecuta diariamente a las 6:00 AM mediante un job programado (cron).</p></td>
</tr>
<tr>
<td><p>Criterio de aceptaci&#243;n</p></td>
<td><p>• Las recomendaciones deben corresponder al consumo real del hogar.<br />• No se repiten recomendaciones en menos de 7 d&#237;as para el mismo usuario.<br />• Las recomendaciones incluyen ahorro estimado en litros y dinero.<br />• El usuario puede marcar la utilidad de cada recomendaci&#243;n.</p></td>
</tr>
</table>



<strong>RF4.4 – Configurar idiomas</strong>

<table>
<tr>
<td><p>Tipo</p></td>
<td><p>Usuario</p></td>
</tr>
<tr>
<td><p>Descripci&#243;n</p></td>
<td><p>Permite seleccionar el idioma de visualizaci&#243;n de la plataforma seg&#250;n la preferencia del usuario, aplicando la traducci&#243;n a toda la interfaz (React + Vite).</p></td>
</tr>
<tr>
<td><p>Entradas</p></td>
<td><p>Idioma seleccionado (es, en, pt, fr).</p></td>
</tr>
<tr>
<td><p>Salidas</p></td>
<td><p>Idioma configurado en user_preference.</p></td>
</tr>
<tr>
<td><p>Acci&#243;n</p></td>
<td><p>Actualizaci&#243;n de language_id en user_preference. El frontend (React + Vite) consume esta preferencia y aplica las traducciones mediante i18n (react-i18next).</p></td>
</tr>
<tr>
<td><p>Criterio de aceptaci&#243;n</p></td>
<td><p>• El idioma debe aplicarse en toda la interfaz (web y m&#243;vil).
• La preferencia persiste entre sesiones.
• Los idiomas disponibles deben estar en la tabla language.<br /><br /></p></td>
</tr>
</table>




<strong>ERF4.4.1 – Configurar moneda</strong>

<table>
<tr>
<td><p>Tipo</p></td>
<td><p>Usuario</p></td>
</tr>
<tr>
<td><p>Descripci&#243;n</p></td>
<td><p>Permite definir la moneda utilizada para mostrar valores de consumo y estimaciones econ&#243;micas en reportes y gr&#225;ficos.</p></td>
</tr>
<tr>
<td><p>Entradas</p></td>
<td><p>Moneda seleccionada (COP, USD, EUR, MXN).</p></td>
</tr>
<tr>
<td><p>Salidas</p></td>
<td><p>Moneda configurada en user_preference.</p></td>
</tr>
<tr>
<td><p>Acci&#243;n</p></td>
<td><p>Actualizaci&#243;n de currency_id en user_preference. El frontend (React + Vite) consume esta preferencia y formatea los valores monetarios seg&#250;n la moneda seleccionada.</p></td>
</tr>
<tr>
<td><p>Criterio de aceptaci&#243;n</p></td>
<td><p>• La moneda se refleja correctamente en reportes y gr&#225;ficos.
• La preferencia persiste entre sesiones.
• Las monedas disponibles deben estar en la tabla currency.<br /><br /></p></td>
</tr>
</table>



<strong>RF4.5 – Configuración de colores (gestión global)</strong>

<table>
<tr>
<td><p>Tipo</p></td>
<td><p>Usuario</p></td>
</tr>
<tr>
<td><p>Descripci&#243;n</p></td>
<td><p>Permite personalizar la paleta de colores de la interfaz para mejorar la experiencia visual del usuario, seleccionando entre temas predefinidos.</p></td>
</tr>
<tr>
<td><p>Entradas</p></td>
<td><p>Tema o colores seleccionados</p></td>
</tr>
<tr>
<td><p>Salidas</p></td>
<td><p>Estilo visual aplicado en user_preference.</p></td>
</tr>
<tr>
<td><p>Acci&#243;n</p></td>
<td><p>Actualizaci&#243;n de theme_id en user_preference. El frontend (React + Vite) consume esta preferencia y aplica el tema mediante CSS-in-JS o Tailwind CSS.</p></td>
</tr>
<tr>
<td><p>Criterio de aceptaci&#243;n</p></td>
<td><p>Los colores deben aplicarse de forma global en toda la interfaz.
• El tema debe persistir entre sesiones.
• Los temas disponibles deben estar en la tabla theme.
• El tema por defecto es &quot;Light&quot;.<br /><br /><br /></p></td>
</tr>
</table>



<strong>RF4.6 – Controles de auditoría</strong>

<table>
<tr>
<td><p>Tipo</p></td>
<td><p>Sistema</p></td>
</tr>
<tr>
<td><p>Descripci&#243;n</p></td>
<td><p>Registra y consulta acciones relevantes realizadas por los usuarios dentro del sistema para fines de auditor&#237;a, cumplimiento normativo y seguridad.</p></td>
</tr>
<tr>
<td><p>Entradas</p></td>
<td><p>Acciones del usuario (Login, Logout, INSERT, UPDATE, DELETE, EXPORT, IMPORT).</p></td>
</tr>
<tr>
<td><p>Salidas</p></td>
<td><p>Registro de auditor&#237;a en audit_log con todos los detalles.</p></td>
</tr>
<tr>
<td><p>Acci&#243;n</p></td>
<td><p>Middleware que captura cada petici&#243;n HTTP (m&#233;todo, URL, usuario, IP, user-agent) y los datos modificados (valor anterior y nuevo), y almacena en audit_log.</p></td>
</tr>
<tr>
<td><p>Criterio de aceptaci&#243;n</p></td>
<td><p>&nbsp;</p><table>
<tr>
<td><p>• Todas las acciones cr&#237;ticas deben quedar registradas.<br />• Los logs deben conservarse al menos 1 a&#241;o.<br />• Solo administradores pueden consultar auditor&#237;as.<br />• La auditor&#237;a incluye IP de origen y user-agent.<br />• Los registros no pueden ser eliminados (solo archivo).</p></td>
<td><p>&nbsp;</p></td>
</tr>
</table>

<p>&nbsp;</p></td>
</tr>
</table>

####


        <strong>RF4.7 – Modo Vacaciones / Ausencias</strong>


<table>
<tr>
<td><p>Tipo</p></td>
<td><p>Usuario (Titular del hogar)</p></td>
</tr>
<tr>
<td><p>Descripci&#243;n</p></td>
<td><p>Permite activar un modo &quot;Vacaciones&quot; que suspende notificaciones de consumo normal y ajusta alertas a solo eventos cr&#237;ticos (fugas, desconexi&#243;n de dispositivos) durante la ausencia del usuario, reduciendo la saturaci&#243;n de notificaciones.</p></td>
</tr>
<tr>
<td><p>Entradas</p></td>
<td><p>• Fecha de inicio<br />• Fecha de fin<br />• Objetivo de consumo diario (opcional, en m&#179;)<br />• Notificar al regreso (booleano)</p></td>
</tr>
<tr>
<td><p>Salidas</p></td>
<td><p>Estado del modo vacaciones activado/desactivado en vacation_mode.</p></td>
</tr>
<tr>
<td><p>Acci&#243;n</p></td>
<td><p>Inserci&#243;n/actualizaci&#243;n en vacation_mode con active = true. El sistema cambia el comportamiento de las reglas de alerta: solo se env&#237;an alertas de severidad &quot;Alta&quot; o &quot;Cr&#237;tica&quot;. Al finalizar la fecha de fin, el sistema desactiva autom&#225;ticamente el modo.</p></td>
</tr>
<tr>
<td><p>Criterio de aceptaci&#243;n</p></td>
<td><p>&nbsp;</p><table>
<tr>
<td><p>• Solo el titular del hogar puede activar/desactivar.
• Durante el modo, solo se env&#237;an alertas de severidad &quot;Alta&quot; o &quot;Cr&#237;tica&quot; (fugas, desconexi&#243;n de dispositivos).
• Al finalizar, las notificaciones vuelven a la normalidad autom&#225;ticamente.
• Las fechas de fin deben ser posteriores a inicio.
• Se registra en audit_log la activaci&#243;n y desactivaci&#243;n.
• Se puede desactivar manualmente en cualquier momento antes de la fecha de fin.<br /><br /><br /><br /><br /></p></td>
<td><p>&nbsp;</p></td>
</tr>
</table>

<p>&nbsp;</p></td>
</tr>
</table>


####

#### RF5 – Consultas y/o Reportes PDF y EXCEL


#### RF5.1 – Gráficos comparativos

<table>
<tr>
<td><p>Tipo</p></td>
<td><p>Usuario</p></td>
</tr>
<tr>
<td><p>Descripci&#243;n</p></td>
<td><p>Permite visualizar gr&#225;ficos comparativos del consumo de agua para analizar variaciones y tendencias en distintos periodos de tiempo (diario, semanal, mensual, anual), con opci&#243;n de exportaci&#243;n a PDF/Excel.</p></td>
</tr>
<tr>
<td><p>Entradas</p></td>
<td><p>• Hogar seleccionado<br />• Periodo (diario, semanal, mensual, anual)<br />• Rango de fechas (inicio y fin)</p></td>
</tr>
<tr>
<td><p>Salidas</p></td>
<td><p>Gr&#225;ficos de barras, l&#237;neas o circulares renderizados en el frontend (React + Vite con recharts).</p></td>
</tr>
<tr>
<td><p>Acci&#243;n</p></td>
<td><p>Consulta a la base de datos (tablas sensor_reading, daily_consumption_summary, monthly_consumption_history, hourly_consumption_history) y procesamiento de datos para generar la informaci&#243;n agregada.</p></td>
</tr>
<tr>
<td><p>Criterio de aceptaci&#243;n</p></td>
<td><p>• Los gr&#225;ficos deben reflejar datos reales y actualizados.<br />• La informaci&#243;n debe ser clara y legible (colores, etiquetas, leyendas).<br />• Debe permitir comparar periodos (ej. este mes vs mes anterior).<br />• Los datos deben poder exportarse a PDF/Excel (ver RF5.1.x).</p></td>
</tr>
</table>



<strong>ERF5.1.1 – Gráficos comparativos en tiempo real</strong>

<table>
<tr>
<td><p>Tipo</p></td>
<td><p>Sistema</p></td>
</tr>
<tr>
<td><p>Descripci&#243;n</p></td>
<td><p>Muestra gr&#225;ficos actualizados mediante polling HTTP en el cliente actual; WebSocket push no est&#225; verificado.</p></td>
</tr>
<tr>
<td><p>Entradas</p></td>
<td><p>Datos en tiempo real del dispositivo (MQTT procesado por el backend).</p></td>
</tr>
<tr>
<td><p>Salidas</p></td>
<td><p>Gr&#225;fico actualizado cada 5 segundos en el frontend (React + Vite).</p></td>
</tr>
<tr>
<td><p>Acci&#243;n</p></td>
<td><p>El frontend consulta los datos persistidos mediante polling HTTP de 5 segundos; no se verifica emisi&#243;n de eventos mediante WebSocket push no verificado.</p></td>
</tr>
<tr>
<td><p>Criterio de aceptaci&#243;n</p></td>
<td><p>• Los datos deben actualizarse autom&#225;ticamente sin recarga de p&#225;gina.<br />• Latencia menor a 3 segundos.<br />• La conexi&#243;n WebSocket debe ser resiliente (reconexi&#243;n autom&#225;tica).<br />• Solo los usuarios con acceso al hogar reciben las actualizaciones.</p></td>
</tr>
</table>



<strong>ERF5.1.2 – Gráficos comparativos anuales</strong>

<table>
<tr>
<td><p>Tipo</p></td>
<td><p>Usuario</p></td>
</tr>
<tr>
<td><p>Descripci&#243;n</p></td>
<td><p>Permite comparar el consumo de agua entre diferentes a&#241;os, mostrando todos los meses del a&#241;o seleccionado.</p></td>
</tr>
<tr>
<td><p>Entradas</p></td>
<td><p>A&#241;o seleccionado</p></td>
</tr>
<tr>
<td><p>Salidas</p></td>
<td><p>Gr&#225;fico comparativo anual con todos los meses.</p></td>
</tr>
<tr>
<td><p>Acci&#243;n</p></td>
<td><p>Consulta a monthly_consumption_history para el a&#241;o seleccionado.</p></td>
</tr>
<tr>
<td><p>Criterio de aceptaci&#243;n</p></td>
<td><p>• El gr&#225;fico debe incluir todos los meses del a&#241;o seleccionado.<br />• Debe permitir comparar con a&#241;os anteriores (superposici&#243;n o cambio de a&#241;o).<br />• Debe mostrar el consumo total anual y el promedio mensual.</p></td>
</tr>
</table>



<strong>ERF5.1.3 – Gráficos comparativos mensuales</strong>

<table>
<tr>
<td><p>Tipo</p></td>
<td><p>Usuario</p></td>
</tr>
<tr>
<td><p>Descripci&#243;n</p></td>
<td><p>Permite visualizar y comparar el consumo mensual de agua, mostrando el detalle d&#237;a a d&#237;a del mes seleccionado.</p></td>
</tr>
<tr>
<td><p>Entradas</p></td>
<td><p>Mes seleccionado</p></td>
</tr>
<tr>
<td><p>Salidas</p></td>
<td><p>Gr&#225;fico Gr&#225;fico comparativo mensual con los d&#237;as del mes.mensual</p></td>
</tr>
<tr>
<td><p>Acci&#243;n</p></td>
<td><p>Consulta a daily_consumption_summary para el mes seleccionado.</p></td>
</tr>
<tr>
<td><p>Criterio de aceptaci&#243;n</p></td>
<td><p>• El consumo debe corresponder al mes seleccionado.<br />• Debe permitir comparar con meses anteriores.<br />• Debe mostrar el consumo total del mes y el promedio diario.</p></td>
</tr>
</table>



<strong>ERF5.1.4 – Gráficos comparativos semanales</strong>

<table>
<tr>
<td><p>Tipo</p></td>
<td><p>Usuario</p></td>
</tr>
<tr>
<td><p>Descripci&#243;n</p></td>
<td><p>Permite comparar el consumo de agua por semanas, mostrando el detalle d&#237;a a d&#237;a de la semana seleccionada.</p></td>
</tr>
<tr>
<td><p>Entradas</p></td>
<td><p>Semana seleccionada (n&#250;mero de semana y a&#241;o).</p></td>
</tr>
<tr>
<td><p>Salidas</p></td>
<td><p>Gr&#225;fico comparativo semanal con los d&#237;as de la semana.</p></td>
</tr>
<tr>
<td><p>Acci&#243;n</p></td>
<td><p>Consulta a daily_consumption_summary agrupando por semana (funci&#243;n EXTRACT(WEEK FROM date)).</p></td>
</tr>
<tr>
<td><p>Criterio de aceptaci&#243;n</p></td>
<td><p>• La semana debe calcularse correctamente seg&#250;n el calendario (ISO 8601).<br />• Debe permitir comparar con semanas anteriores.<br />• Debe mostrar el consumo total de la semana y el promedio diario.</p></td>
</tr>
</table>



<strong>ERF5.1.5 – Gráficos comparativos diarios</strong>

<table>
<tr>
<td><p>Tipo</p></td>
<td><p>Usuario</p></td>
</tr>
<tr>
<td><p>Descripci&#243;n</p></td>
<td><p>Permite visualizar el consumo diario de agua por hora, mostrando el detalle horario del d&#237;a seleccionado.</p></td>
</tr>
<tr>
<td><p>Entradas</p></td>
<td><p>Fecha seleccionada</p></td>
</tr>
<tr>
<td><p>Salidas</p></td>
<td><p>Gr&#225;fico diario con valores por hora (0-23).</p></td>
</tr>
<tr>
<td><p>Acci&#243;n</p></td>
<td><p>Consulta a hourly_consumption_history para la fecha seleccionada.</p></td>
</tr>
<tr>
<td><p>Criterio de aceptaci&#243;n</p></td>
<td><p>• El gr&#225;fico debe mostrar valores por hora (0-23).<br />• Debe permitir comparar con d&#237;as anteriores.<br />• Debe mostrar el consumo total del d&#237;a y la hora pico.</p></td>
</tr>
</table>


<strong>RF5.2 – Hábitos de consumo</strong>

<table>
<tr>
<td><p>Tipo</p></td>
<td><p>Sistema</p></td>
</tr>
<tr>
<td><p>Descripci&#243;n</p></td>
<td><p>Permite analizar los patrones y h&#225;bitos de consumo de agua del usuario o del hogar, identificando comportamientos recurrentes y oportunidades de ahorro.</p></td>
</tr>
<tr>
<td><p>Entradas</p></td>
<td><p>Datos hist&#243;ricos de consumo (&#250;ltimos 30 d&#237;as).</p></td>
</tr>
<tr>
<td><p>Salidas</p></td>
<td><p>Informe de h&#225;bitos: horas pico, d&#237;as de mayor consumo, actividades m&#225;s frecuentes, comparativa con el promedio del hogar.</p></td>
</tr>
<tr>
<td><p>Acci&#243;n</p></td>
<td><p>Consulta a sensor_reading agrupando por actividad, hora del d&#237;a y d&#237;a de la semana. Se aplican algoritmos de an&#225;lisis estad&#237;stico (media, moda, percentiles).</p></td>
</tr>
<tr>
<td><p>Criterio de aceptaci&#243;n</p></td>
<td><p>• Los h&#225;bitos deben basarse en datos reales (&#250;ltimos 30 d&#237;as).<br />• Debe mostrar recomendaciones asociadas a los h&#225;bitos detectados (ver RF5.5).<br />• Debe permitir filtrar por periodo (&#250;ltimos 7 d&#237;as, 30 d&#237;as, 90 d&#237;as).<br />• Los resultados se presentan en gr&#225;ficos y tablas en el frontend (React + Vite).</p></td>
</tr>
</table>



<strong>RF5.3 – Modelo predictivo</strong>

<table>
<tr>
<td><p>Tipo</p></td>
<td><p>Sistema</p></td>
</tr>
<tr>
<td><p>Descripci&#243;n</p></td>
<td><p>Estima el consumo futuro de agua con base en el historial registrado, aplicando algoritmos de regresi&#243;n lineal simple o media m&#243;vil.</p></td>
</tr>
<tr>
<td><p>Entradas</p></td>
<td><p>Datos hist&#243;ricos de consumo (&#250;ltimos 30 d&#237;as).</p></td>
</tr>
<tr>
<td><p>Salidas</p></td>
<td><p>Predicci&#243;n de consumo para el pr&#243;ximo mes (m&#179; y costo estimado), con nivel de confianza.</p></td>
</tr>
<tr>
<td><p>Acci&#243;n</p></td>
<td><p>Aplicaci&#243;n de algoritmo de regresi&#243;n lineal o media m&#243;vil sobre los datos hist&#243;ricos de daily_consumption_summary. El resultado se almacena en consumption_prediction.</p></td>
</tr>
<tr>
<td><p>Criterio de aceptaci&#243;n</p></td>
<td><p>• La predicci&#243;n debe usar al menos 30 d&#237;as de datos hist&#243;ricos.<br />• Debe incluir un nivel de confianza (porcentaje).<br />• La predicci&#243;n se actualiza autom&#225;ticamente cada semana (job programado).<br />• Debe mostrar la tendencia (creciente, decreciente o estable)</p></td>
</tr>
</table>



<strong>RF5.4 – Alertas</strong>

<table>
<tr>
<td><p>Tipo</p></td>
<td><p><strong>Sistema / Usuario</strong></p></td>
</tr>
<tr>
<td><p>Descripci&#243;n</p></td>
<td><p>Genera alertas autom&#225;ticas cuando se detectan consumos an&#243;malos o se superan los topes configurados, notificando al usuario en tiempo real.</p></td>
</tr>
<tr>
<td><p>Entradas</p></td>
<td><p>• Datos de consumo (lecturas)<br />• Topes configurados y reglas de alerta (RF4.1 y RF4.2)Topes configurados</p></td>
</tr>
<tr>
<td><p>Salidas</p></td>
<td><p>Notificaci&#243;n en app (push), correo electr&#243;nico y/o SMS (seg&#250;n preferencias del usuario).</p></td>
</tr>
<tr>
<td><p>Acci&#243;n</p></td>
<td><p>Evaluaci&#243;n de reglas (alert_rule) y generaci&#243;n de eventos (alert_event) con notificaciones asociadas (alert_notification). Las alertas se eval&#250;an en tiempo real al recibir cada lectura MQTT.</p></td>
</tr>
<tr>
<td><p>Criterio de aceptaci&#243;n</p></td>
<td><p>• La alerta se genera al superar el umbral definido.
• El usuario puede marcar la alerta como le&#237;da o descartada.
• Las notificaciones se env&#237;an por los canales configurados (push, email, SMS).
• Las alertas se agrupan por tipo y hogar.
• Se registra en audit_log la generaci&#243;n y lectura de alertas.<br /><br /><br /><br /></p></td>
</tr>
</table>



<strong>RF5.5 – Recomendaciones</strong>

<table>
<tr>
<td><p>Tipo</p></td>
<td><p>Sistema</p></td>
</tr>
<tr>
<td><p>Descripci&#243;n</p></td>
<td><p>Genera recomendaciones personalizadas para el ahorro de agua basadas en los h&#225;bitos de consumo detectados, con estimaci&#243;n de ahorro potencial.</p></td>
</tr>
<tr>
<td><p>Entradas</p></td>
<td><p>H&#225;bitos de consumo detectados (RF5.2).</p></td>
</tr>
<tr>
<td><p>Salidas</p></td>
<td><p>Recomendaciones espec&#237;ficas con ahorro estimado (litros y dinero) y nivel de prioridad (baja, media, alta).</p></td>
</tr>
<tr>
<td><p>Acci&#243;n</p></td>
<td><p>Evaluaci&#243;n de recommendation con umbrales y asignaci&#243;n a user_recommendation con estado &#39;Pendiente&#39;. Se genera autom&#225;ticamente mediante un job diario a las 6:00 AM.</p></td>
</tr>
<tr>
<td><p>Criterio de aceptaci&#243;n</p></td>
<td><p>• Las recomendaciones deben ser coherentes con los h&#225;bitos reales.<br />• El usuario puede marcar la utilidad de cada recomendaci&#243;n (&#250;til/no &#250;til).<br />• Las recomendaciones se presentan en el dashboard y en la secci&#243;n de recomendaciones.<br />• No se repiten recomendaciones en menos de 7 d&#237;as para el mismo usuario.</p></td>
</tr>
</table>


<strong>RF5.6 – Proyectos (hogares) asociados al usuario</strong>

<table>
<tr>
<td><p>Tipo</p></td>
<td><p>Usuario</p></td>
</tr>
<tr>
<td><p>Descripci&#243;n</p></td>
<td><p>Permite consultar los hogares asociados a la cuenta del usuario, mostrando el rol de cada uno (Owner, Member, Guest) y sus m&#233;tricas b&#225;sicas.</p></td>
</tr>
<tr>
<td><p>Entradas</p></td>
<td><p>Usuario autenticado</p></td>
</tr>
<tr>
<td><p>Salidas</p></td>
<td><p>Listado de hogares con roles (Owner, Member, Guest), n&#250;mero de dispositivos, miembros y consumo actual.</p></td>
</tr>
<tr>
<td><p>Acci&#243;n</p></td>
<td><p>Consulta a home_user con JOIN a home y agregaci&#243;n de m&#233;tricas (dispositivos activos, miembros, consumo del mes).</p></td>
</tr>
<tr>
<td><p>Criterio de aceptaci&#243;n</p></td>
<td><p>&nbsp;</p><table>
<tr>
<td><p>• Solo se muestran hogares asociados al usuario.<br />• Se muestra el rol de cada hogar (Owner, Member, Guest).<br />• Se muestra el consumo actual del mes, n&#250;mero de dispositivos y miembros.<br />• Se puede acceder a la vista detallada de cada hogar.</p></td>
</tr>
</table>

<p>&nbsp;</p></td>
</tr>
</table>



<strong>RF5.7 – Metas y presupuesto mensual (Saving Goals)</strong>


<table>
<tr>
<td><p>Tipo</p></td>
<td><p><strong>Usuario (Titular o miembro con permisos)</strong></p></td>
</tr>
<tr>
<td><p>Descripci&#243;n</p></td>
<td><p>Permite al usuario definir metas mensuales de ahorro de agua (en m&#179;) y l&#237;mites de presupuesto (en COP), con seguimiento visual de progreso y proyecciones de fin de mes.</p></td>
</tr>
<tr>
<td><p>Entradas</p></td>
<td><p>• L&#237;mite de consumo (m&#179;)<br />• Presupuesto m&#225;ximo (COP)<br />• Per&#237;odo de la meta (mensual, semanal, anual)<br />• Fecha de inicio y fin (opcional)</p></td>
</tr>
<tr>
<td><p>Salidas</p></td>
<td><p>Progreso actual (porcentaje usado), proyecci&#243;n de consumo final, estado de cumplimiento (alcanzada/no alcanzada).</p></td>
</tr>
<tr>
<td><p>Acci&#243;n</p></td>
<td><p>Inserci&#243;n/actualizaci&#243;n en saving_goal. El sistema calcula el consumo actual vs la meta y genera alertas si se supera el 80% y 90% del l&#237;mite. La proyecci&#243;n de fin de mes se calcula en base al consumo diario promedio.</p></td>
</tr>
<tr>
<td><p>Criterio de aceptaci&#243;n</p></td>
<td><p>&nbsp;</p><table>
<tr>
<td><p> Solo aplica a hogares donde el usuario es titular o miembro con permisos.
• Las metas deben ser positivas y mayores a cero.
• El sistema debe mostrar el historial de metas anteriores (&#250;ltimos 6 meses).
• La proyecci&#243;n de fin de mes se actualiza diariamente.
• Las alertas se generan al alcanzar el 80% y 90% del l&#237;mite.
• La acci&#243;n queda registrada en audit_log.<br /><br /><br /><br /><br /></p></td>
</tr>
</table>

<p>&nbsp;</p></td>
</tr>
</table>





<strong>RF5.8 – Sistema de Soporte Técnico (Tickets)</strong>


<table>
<tr>
<td><p>Tipo</p></td>
<td><p><strong>Usuario / Soporte T&#233;cnico</strong></p></td>
</tr>
<tr>
<td><p>Descripci&#243;n</p></td>
<td><p>Permite a los usuarios reportar incidencias o consultas t&#233;cnicas a trav&#233;s de un sistema de tickets, y al equipo de soporte gestionar su resoluci&#243;n con seguimiento de estado.</p></td>
</tr>
<tr>
<td><p>Entradas</p></td>
<td><p>• T&#237;tulo del problema<br />• Categor&#237;a (Dispositivo, Reportes, Tarifas, Detecci&#243;n, Otros)<br />• Prioridad (Baja, Media, Alta)<br />• Descripci&#243;n detallada<br />• Archivos adjuntos (opcional, hasta 5MB)</p></td>
</tr>
<tr>
<td><p>Salidas</p></td>
<td><p>Ticket creado con ID &#250;nico, historial de respuestas, estado de resoluci&#243;n y notificaciones de seguimiento.</p></td>
</tr>
<tr>
<td><p>Acci&#243;n</p></td>
<td><p>Inserci&#243;n en ticket con estado &#39;Abierto&#39;. El soporte puede actualizar estado (En Proceso, Resuelto, Cerrado) y agregar respuestas en ticket_response. El sistema notifica al usuario cuando el ticket es respondido o resuelto (v&#237;a correo y/o push).</p></td>
</tr>
<tr>
<td><p>Criterio de aceptaci&#243;n</p></td>
<td><p>&nbsp;</p><table>
<tr>
<td><p>• Los tickets deben tener categor&#237;as y prioridades predefinidas (tablas cat&#225;logo).
• El soporte puede cambiar el estado: Abierto, En Proceso, Resuelto, Cerrado.
• El usuario puede dar seguimiento a sus tickets desde la app (React + Vite).
• Los tickets cerrados se archivan autom&#225;ticamente despu&#233;s de 30 d&#237;as.
• Cada cambio de estado queda registrado en audit_log.
• Se env&#237;a notificaci&#243;n por correo al usuario cuando el ticket es respondido o resuelto.
• Los tickets pueden tener archivos adjuntos (almacenados en almacenamiento externo no verificado o local).<br /><br /><br /><br /><br /><br /></p></td>
</tr>
</table>

<p>&nbsp;</p></td>
</tr>
</table>
















<strong>BOSETO DE REQUERIMIENTOS FUNCIONALES</strong>


<strong>Mockup móvil: </strong>[<u><strong>https://www.figma.com/make/R5Yhy0Jh6SOBGT4ApaBO5y/M%C3%B3vil?node-id=0-1&amp;fullscreen=1&amp;t=1qqLwJS7DidIt8aX-1</strong></u>](https://www.figma.com/make/R5Yhy0Jh6SOBGT4ApaBO5y/M%C3%B3vil?node-id=0-1&fullscreen=1&t=1qqLwJS7DidIt8aX-1)


<strong>Mockup web:  </strong>[<u><strong>https://www.figma.com/make/0zOBmy5JuETUlknQ8Sv91p/Web?node-id=0-1&amp;fullscreen=1&amp;t=HU0K98manyTK96L6-1</strong></u>](https://www.figma.com/make/0zOBmy5JuETUlknQ8Sv91p/Web?node-id=0-1&fullscreen=1&t=HU0K98manyTK96L6-1)

## Requerimientos No Funcionales.

<strong>Requerimientos No Funcionales.</strong>

<strong>RNF1. Rendimiento</strong>

<p>● <strong>RNF1.1 Tiempo de inicio</strong></p>
<p>● <strong>RNF1.2 Rendimiento general</strong></p>
<p>● <strong>RNF1.3 Gestión de capacidad</strong></p>
<p>● <strong>RNF1.4 Escalabilidad (Actualizado: stateless para escalado horizontal)</strong></p>
<strong>RNF2. Usabilidad</strong>

<p>● <strong>RNF2.1 Facilidad de uso</strong></p>
<p>● <strong>RNF2.2 Claridad de la información</strong></p>
<p>● <strong>RNF2.3 Lenguaje (Actualizado: react-i18next)</strong></p>
<p>● <strong>RNF2.4 Adaptabilidad</strong></p>
<strong>RNF3. Compatibilidad</strong>

<p>● <strong>RNF3.1 Compatibilidad Web (Actualizado: React + Vite en navegadores modernos)</strong></p>
<p>● <strong>RNF3.2 Compatibilidad con navegadore.</strong></p>
<strong>RNF4. Disponibilidad y Confiabilidad</strong>

<p>● <strong>RNF4.1 Disponibilidad</strong></p>
<p>● <strong>RNF4.2 Persistencia de datos</strong></p>
<p>● <strong>RNF4.3 Notificaciones en tiempo real</strong></p>
<p>● <strong>RNF4.4 Recuperación ante fallos</strong></p>
<strong>RNF5. Seguridad</strong>

<p>● <strong>RNF5.1 Control de acceso</strong></p>
<p>● <strong>RNF5.2 Autenticación segura (cookies HttpOnly, CSRF y sesiones JWT; Redis no verificado)</strong></p>
<p>● <strong>RNF5.3 Cifrado de datos</strong></p>
<p>● <strong>RNF5.4 Copias de seguridad</strong></p>
<strong>RNF6. Gestión y Operación</strong>

<p>● <strong>RNF6.1 Roles y responsabilidades</strong></p>
<p>● <strong>RNF6.2 Gestión de incidentes</strong></p>
<p>● <strong>RNF6.3 Mantenibilidad (Actualizado: arquitectura hexagonal)</strong></p>
<strong>RNF7. Portabilidad y Accesibilidad</strong>

<p>● <strong>RNF7.1 Portabilidad</strong></p>
<p>● <strong>RNF7.2 Accesibilidad (Actualizado: WCAG 2.1 AA)</strong></p>
<p>● <strong>RNF7.3 Multiplataforma (Actualizado: responsive con React + Vite)</strong></p>
<strong>RNF8. Cumplimiento Normativo y Monitoreo</strong>

<p>● <strong>RNF8.1 Eficiencia energética</strong></p>
<p>● <strong>RNF8.2 Cumplimiento normativo</strong></p>
<p>● <strong>RNF8.3 Auditoría</strong></p>
<p>● <strong>RNF8.4 Monitoreo del rendimiento</strong></p>
<strong> RNF9. Tolerancia a Fallos y Resiliencia (Nuevo)</strong>

<p>● <strong>RNF9.1 Circuit Breaker (Nuevo)</strong></p>
<p>● <strong>RNF9.2 Procesamiento Asíncrono (Colas) (Nuevo)</strong></p>
<p>● <strong>RNF9.3 Retry Pattern (Nuevo)</strong></p>
<strong> RNF10. Escalabilidad Horizontal (Nuevo)</strong>

<p>● <strong>RNF10.1 Stateless (Nuevo)</strong></p>
<p>● <strong>RNF10.2 Gestión de Colas (Nuevo)</strong></p>
<strong>RNF11. Requerimientos Técnicos (Corregido, antes RNF6 duplicado)</strong>

<p>● <strong>RNF11.1 Visualización responsiva</strong></p>
<p>● <strong>RNF11.2 Soporte técnico</strong></p>
<p>● <strong>RNF11.3 Mantenimiento técnico</strong></p>


RNF1 Rendimiento

<table>
<tr>
<td colspan="2"><p>Identificador: RNF 1.1</p></td>
<td colspan="2"><p>Nombre:</p><p>Tiempo de inicio</p></td>
</tr>
<tr>
<td><p>Tipo: Necesario</p></td>
<td colspan="2"><p>Requerimiento que lo utiliza o especializa:</p><p>Sistema</p></td>
<td><p>&#191;Cr&#237;tico? Si</p></td>
</tr>
<tr>
<td><p>Prioridad de desarrollo: Alto</p></td>
<td colspan="3"><p>Documentos de visualizaci&#243;n asociados:</p><p>● Informes de an&#225;lisis de rendimiento del sistema</p><p>● Diagramas de arquitectura del software</p><p>● Registros de pruebas de carga</p><p>● Documentaci&#243;n de optimizaci&#243;n de inicio</p><p>● Reportes de evaluaci&#243;n del tiempo de respuesta</p></td>
</tr>
<tr>
<td><p>Entrada:</p><p>Comando de inicio del sistema</p></td>
<td colspan="3"><p>Salida:</p><p>Interfaz principal operativa</p></td>
</tr>
<tr>
<td colspan="4"><p>Descripci&#243;n:</p><p>● Este requerimiento no funcional se refiere al tiempo que tarda el sistema en iniciar completamente. La aplicaci&#243;n debe cargar todos sus componentes esenciales en un tiempo m&#225;ximo de 5 segundos para ofrecer una experiencia fluida y evitar la percepci&#243;n de lentitud por parte del usuario.</p></td>
</tr>
<tr>
<td colspan="4"><p>Manejo de situaciones anormales</p><p>● Si el tiempo de inicio supera los 5 segundos, el sistema deber&#225; generar un log autom&#225;tico con el detalle del retraso.</p><p>● Si ocurre una falla durante la carga, deber&#225; ejecutarse un protocolo de recuperaci&#243;n autom&#225;tica que restablezca los servicios sin p&#233;rdida de datos.</p></td>
</tr>
<tr>
<td colspan="4"><p>Criterios de aceptaci&#243;n</p><p><br /></p><p>● La aplicaci&#243;n debe iniciar completamente en menos de 5 segundos en condiciones normales.</p><p>● La interfaz debe mostrarse funcional sin errores visibles o bloqueos al cargar.</p></td>
</tr>
</table>


<table>
<tr>
<td colspan="2"><p>Identificador: RNF1.2</p></td>
<td colspan="2"><p>Nombre:</p><p>Rendimiento general</p></td>
</tr>
<tr>
<td><p>Tipo:</p><p>Rendimiento</p></td>
<td colspan="2"><p>Requerimiento que lo utiliza o especializa:</p></td>
<td><p>&#191;Cr&#237;tico?</p><p>Si</p></td>
</tr>
<tr>
<td><p>Prioridad de desarrollo:</p><p>Alto</p></td>
<td colspan="3"><p>Documentos de visualizaci&#243;n asociados:</p><p>● Reportes de rendimiento</p><p>● Pruebas de estr&#233;s</p><p>● Monitoreo del servidor y consumo de CPU</p><p>● Estad&#237;sticas de tiempo de respuesta promedio</p></td>
</tr>
<tr>
<td><p>Entrada:</p><p>Solicitudes concurrentes del usuario</p></td>
<td colspan="3"><p>Salida:</p><p>Respuestas procesadas sin retrasos perceptibles</p></td>
</tr>
<tr>
<td colspan="4"><p>Descripci&#243;n:</p><p><br /></p><p>● El sistema debe mantener tiempos de respuesta &#243;ptimos y consistentes bajo condiciones de carga variable. Esto incluye operaciones simult&#225;neas de usuarios, ejecuci&#243;n de c&#225;lculos y manejo de transacciones sin deteriorar el rendimiento global.</p></td>
</tr>
<tr>
<td colspan="4"><p>Manejo de situaciones anormales</p><p><br /></p><p>● Si el rendimiento cae por debajo del 80% de eficiencia, el sistema debe activar un proceso de redistribuci&#243;n de carga.</p><p>● En caso de sobrecarga, el sistema debe priorizar las solicitudes cr&#237;ticas y encolar las secundarias.</p></td>
</tr>
<tr>
<td colspan="4"><p>Criterios de aceptaci&#243;n</p><p>● El tiempo promedio de respuesta por solicitud no debe superar los 3 segundos.</p><p>● El sistema debe soportar al menos 100 usuarios concurrentes sin degradaci&#243;n perceptible.</p></td>
</tr>
</table>


<table>
<tr>
<td colspan="2"><p>Identificador: RNF1.3</p></td>
<td colspan="2"><p>Nombre:</p><p>Gesti&#243;n de capacidad.</p></td>
</tr>
<tr>
<td><p>Tipo:</p><p>Rendimiento</p></td>
<td colspan="2"><p>Requerimiento que lo utiliza o especializa:</p></td>
<td><p>&#191;Cr&#237;tico?</p><p>Si</p></td>
</tr>
<tr>
<td><p>Prioridad de desarrollo:</p><p>Media</p></td>
<td colspan="3"><p>Documentos de visualizaci&#243;n asociados:</p><p>● Plan de dimensionamiento de recursos</p><p>● Monitoreo de rendimiento</p><p>● Reportes de consumo de memoria y almacenamiento</p></td>
</tr>
<tr>
<td><p>Entrada:</p><p>Datos de carga y uso del sistema</p></td>
<td colspan="3"><p>Salida:</p><p>Balance de recursos ajustado autom&#225;ticamente</p></td>
</tr>
<tr>
<td colspan="4"><p>Descripci&#243;n:</p><p>● El sistema debe ser capaz de ajustar el uso de recursos (memoria, almacenamiento y CPU) de manera din&#225;mica seg&#250;n las necesidades actuales y futuras de operaci&#243;n.</p></td>
</tr>
<tr>
<td colspan="4"><p>Manejo de situaciones anormales</p><p>● Si un recurso alcanza el 90% de su capacidad, el sistema debe generar una alerta preventiva.</p><p>● En caso de alcanzar l&#237;mites cr&#237;ticos, el sistema debe liberar recursos no esenciales autom&#225;ticamente.</p></td>
</tr>
<tr>
<td colspan="4"><p>Criterios de aceptaci&#243;n</p><p>● No se deben presentar bloqueos ni p&#233;rdida de datos por falta de capacidad.</p><p>● La aplicaci&#243;n debe mantener estabilidad con crecimiento de hasta un 50% en el volumen de datos.</p></td>
</tr>
</table>


<table>
<tr>
<td colspan="2"><p>Identificador: RNF1.4</p></td>
<td colspan="2"><p>Nombre:</p><p>Escalabilidad</p></td>
</tr>
<tr>
<td><p>Tipo:</p><p>Rendimiento</p></td>
<td colspan="2"><p>Requerimiento que lo utiliza o especializa:</p></td>
<td><p>&#191;Cr&#237;tico?</p><p>Si</p></td>
</tr>
<tr>
<td><p>Prioridad de desarrollo:</p><p>Alto</p></td>
<td colspan="3"><p>Documentos de visualizaci&#243;n asociados:</p><p><br /></p><p>● Arquitectura de escalado horizontal</p><p>● Diagramas de red</p><p>● Pruebas de carga distribuida</p></td>
</tr>
<tr>
<td><p>Entrada:</p><p>Incremento de usuarios o volumen de datos</p></td>
<td colspan="3"><p>Salida:</p><p>Sistema estable sin p&#233;rdida de rendimiento.</p></td>
</tr>
<tr>
<td colspan="4"><p>Descripci&#243;n:</p><p><br /></p><p>● El sistema debe poder aumentar su capacidad operativa sin modificar la arquitectura principal, soportando el crecimiento en usuarios, datos y transacciones.</p></td>
</tr>
<tr>
<td colspan="4"><p>Manejo de situaciones anormales</p><p>● Si la carga del servidor supera el 75%, debe redirigir nuevas conexiones a instancias adicionales.</p><p>● Si un servidor falla, el sistema debe migrar autom&#225;ticamente las sesiones activas a otro nodo.</p></td>
</tr>
<tr>
<td colspan="4"><p>Criterios de aceptaci&#243;n</p><p>● Mantener un rendimiento constante con el doble de usuarios promedio.</p><p>● Soportar hasta 10.000 registros adicionales sin errores.</p></td>
</tr>
</table>


RNF2 Usabilidad

<table>
<tr>
<td colspan="2"><p>Identificador: RNF2.1</p></td>
<td colspan="2"><p>Nombre:</p><p>Facilidad de uso</p></td>
</tr>
<tr>
<td><p>Tipo:</p><p>Usabilidad</p></td>
<td colspan="2"><p>Requerimiento que lo utiliza o especializa:</p></td>
<td><p>&#191;Cr&#237;tico?</p><p>No</p></td>
</tr>
<tr>
<td><p>Prioridad de desarrollo:</p><p>Alto</p></td>
<td colspan="3"><p>Documentos de visualizaci&#243;n asociados:</p><p><br /></p><p>● Manual de interfaz</p><p>● Resultados de pruebas de usabilidad</p><p>● Encuestas de usuarios</p></td>
</tr>
<tr>
<td><p>Entrada:</p><p>Interacci&#243;n del usuario con la interfaz</p></td>
<td colspan="3"><p>Salida:</p><p>Respuestas gr&#225;ficas claras y comprensibles</p></td>
</tr>
<tr>
<td colspan="4"><p>Descripci&#243;n:</p><p><br /></p><p>● La aplicaci&#243;n debe ofrecer una experiencia intuitiva, accesible y coherente para todo tipo de usuario. El dise&#241;o debe permitir que incluso usuarios sin experiencia puedan utilizar las funciones b&#225;sicas sin asistencia.</p></td>
</tr>
<tr>
<td colspan="4"><p>Manejo de situaciones anormales</p><p>● Si el usuario realiza una acci&#243;n inv&#225;lida, el sistema debe mostrar mensajes claros con instrucciones de correcci&#243;n.</p><p>● Si se detectan errores de navegaci&#243;n, deben registrarse en el log para mejora futura.</p></td>
</tr>
<tr>
<td colspan="4"><p>Criterios de aceptaci&#243;n</p><p>● 90% de los usuarios pueden completar tareas b&#225;sicas sin capacitaci&#243;n previa.</p><p>● Todos los textos e iconos deben ser comprensibles y coherentes.</p></td>
</tr>
</table>


<table>
<tr>
<td colspan="2"><p>Identificador: RNF2.2</p></td>
<td colspan="2"><p>Nombre:</p><p>Claridad de la informaci&#243;n</p></td>
</tr>
<tr>
<td><p>Tipo:</p><p>Usabilidad</p></td>
<td colspan="2"><p>Requerimiento que lo utiliza o especializa:</p><p>Interfaz</p></td>
<td><p>&#191;Cr&#237;tico?</p><p>No</p></td>
</tr>
<tr>
<td><p>Prioridad de desarrollo:</p><p>Medio</p></td>
<td colspan="3"><p>Documentos de visualizaci&#243;n asociados:</p><p><br /></p><p>● Gu&#237;a de estilo de la interfaz</p><p>● Documentaci&#243;n de contenido</p><p>● Manual de redacci&#243;n t&#233;cnica</p><p>● Pruebas de comprensi&#243;n de usuarios</p></td>
</tr>
<tr>
<td><p>Entrada:</p><p>Datos procesados o mensajes del sistema</p></td>
<td colspan="3"><p>Salida:</p><p>Informaci&#243;n mostrada en la interfaz de usuario</p></td>
</tr>
<tr>
<td colspan="4"><p>Descripci&#243;n:</p><p><br /></p><p>● La aplicaci&#243;n debe garantizar que toda la informaci&#243;n que se presente sea clara, comprensible y libre de ambig&#252;edades. Los textos, botones, &#237;conos y mensajes de error deben tener una redacci&#243;n precisa y un significado evidente para el usuario, evitando interpretaciones err&#243;neas que puedan afectar su interacci&#243;n con el sistema.</p></td>
</tr>
<tr>
<td colspan="4"><p>Manejo de situaciones anormales</p><p>● Si se detectan campos o mensajes ambiguos, el sistema deber&#225; registrar el error y notificarlo al equipo de dise&#241;o.</p><p>● En caso de que el usuario no comprenda una acci&#243;n, se mostrar&#225; autom&#225;ticamente una breve ayuda contextual.</p></td>
</tr>
<tr>
<td colspan="4"><p>Criterios de aceptaci&#243;n</p><p>● 100% de los textos e iconos son comprensibles en pruebas de validaci&#243;n.</p><p>● Todos los mensajes de error explican claramente la causa y la soluci&#243;n.</p></td>
</tr>
</table>


<table>
<tr>
<td colspan="2"><p>Identificador: RNF2.3</p></td>
<td colspan="2"><p>Nombre:</p><p>Lenguaje</p></td>
</tr>
<tr>
<td><p>Tipo: Usabilidad</p></td>
<td colspan="2"><p>Requerimiento que lo utiliza o especializa:</p></td>
<td><p>&#191;Cr&#237;tico? No</p></td>
</tr>
<tr>
<td><p>Prioridad de desarrollo: Medio</p></td>
<td colspan="3"><p>Documentos de visualizaci&#243;n asociados:</p><p>● Archivo de localizaci&#243;n del sistema</p><p>● Manual de traducci&#243;n</p><p>● Validaciones de idioma</p></td>
</tr>
<tr>
<td><p>Entrada:</p><p>Configuraci&#243;n regional del usuario</p></td>
<td colspan="3"><p>Salida:</p><p>Interfaz mostrada en idioma espa&#241;ol</p></td>
</tr>
<tr>
<td colspan="4"><p>Descripci&#243;n:</p><p>● Toda la aplicaci&#243;n debe estar traducida al espa&#241;ol y utilizar terminolog&#237;a t&#233;cnica apropiada. El lenguaje debe ser formal, neutro y adaptado al contexto del proyecto, evitando modismos o abreviaturas confusas.</p></td>
</tr>
<tr>
<td colspan="4"><p>Manejo de situaciones anormales</p><p>● Si un texto no est&#225; traducido, el sistema mostrar&#225; el idioma por defecto (espa&#241;ol) y registrar&#225; el error.</p><p>● Se debe disponer de una funci&#243;n de correcci&#243;n r&#225;pida de textos en futuras versiones.</p></td>
</tr>
<tr>
<td colspan="4"><p>Criterios de aceptaci&#243;n</p><p><br /></p><p>● El 100% de los textos deben estar en idioma espa&#241;ol.</p><p>● No deben existir palabras en ingl&#233;s salvo nombres t&#233;cnicos o de librer&#237;as.</p></td>
</tr>
</table>


<table>
<tr>
<td colspan="2"><p>Identificador: RNF2.4</p></td>
<td colspan="2"><p>Nombre:</p><p>Adaptabilidad</p></td>
</tr>
<tr>
<td><p>Tipo:</p><p>Usabilidad</p></td>
<td colspan="2"><p>Requerimiento que lo utiliza o especializa:</p></td>
<td><p>&#191;Cr&#237;tico?</p><p>No</p></td>
</tr>
<tr>
<td><p>Prioridad de desarrollo:</p><p>Media</p></td>
<td colspan="3"><p>Documentos de visualizaci&#243;n asociados:</p><p>● Gu&#237;as de dise&#241;o responsivo</p><p>● Pruebas de compatibilidad en dispositivos</p><p>● Plantillas de interfaz adaptativa</p></td>
</tr>
<tr>
<td><p>Entrada:</p><p>Datos del dispositivo (tama&#241;o de pantalla, sistema operativo)</p></td>
<td colspan="3"><p>Salida:</p><p>Interfaz ajustada autom&#225;ticamente</p></td>
</tr>
<tr>
<td colspan="4"><p>Descripci&#243;n:</p><p><br /></p><p>● El sistema debe ajustarse de forma autom&#225;tica a las caracter&#237;sticas del dispositivo o pantalla desde donde se accede. Esto incluye adaptar tama&#241;os, fuentes, botones y disposici&#243;n de elementos para garantizar una visualizaci&#243;n adecuada tanto en dispositivos m&#243;viles como en equipos de escritorio.</p></td>
</tr>
<tr>
<td colspan="4"><p>Manejo de situaciones anormales</p><p><br /></p><p>● Si la resoluci&#243;n del dispositivo no es soportada, el sistema mostrar&#225; una advertencia de compatibilidad.</p><p>● En caso de error de visualizaci&#243;n, el usuario podr&#225; reajustar manualmente el modo de vista.</p></td>
</tr>
<tr>
<td colspan="4"><p>Criterios de aceptaci&#243;n</p><p>● Compatibilidad comprobada en pantallas desde 5” hasta 24”.</p><p>● Todos los elementos visuales se mantienen proporcionales y funcionales.</p></td>
</tr>
</table>


RNF3 Compatibilidad

<table>
<tr>
<td colspan="2"><p>Identificador: RNF3.1</p></td>
<td colspan="2"><p>Nombre:</p><p>Compatibilidad Android</p></td>
</tr>
<tr>
<td><p>Tipo:</p><p>Compatibilidad</p></td>
<td colspan="2"><p>Requerimiento que lo utiliza o especializa:</p></td>
<td><p>&#191;Cr&#237;tico?</p><p>Si</p></td>
</tr>
<tr>
<td><p>Prioridad de desarrollo:</p><p>Alta</p></td>
<td colspan="3"><p>Documentos de visualizaci&#243;n asociados:</p><p>● Especificaciones del SDK Android</p><p>● Reportes de compatibilidad</p><p>● Registro de pruebas en dispositivos reales</p></td>
</tr>
<tr>
<td><p>Entrada:</p><p>Dispositivo con sistema Android 9 o superior</p></td>
<td colspan="3"><p>Salida:</p><p>Aplicaci&#243;n ejecut&#225;ndose correctamente</p></td>
</tr>
<tr>
<td colspan="4"><p>Descripci&#243;n:</p><p>● La aplicaci&#243;n debe funcionar correctamente en dispositivos Android versi&#243;n 9 o superior, asegurando compatibilidad con las librer&#237;as nativas del sistema operativo, sensores y permisos de acceso.</p></td>
</tr>
<tr>
<td colspan="4"><p>Manejo de situaciones anormales</p><p>● Si la versi&#243;n del sistema operativo es inferior a la requerida, la aplicaci&#243;n mostrar&#225; un mensaje informativo y no permitir&#225; la instalaci&#243;n.</p><p>● En caso de incompatibilidad con hardware, el sistema deber&#225; registrar el fallo y notificar al usuario.</p></td>
</tr>
<tr>
<td colspan="4"><p>Criterios de aceptaci&#243;n</p><p>● Ejecuci&#243;n exitosa en Android 9, 10, 11, 12, 13 y 14.</p><p>● No deben presentarse cierres inesperados ni errores de permisos.</p></td>
</tr>
</table>


<table>
<tr>
<td colspan="2"><p>Identificador: RNF3.2</p></td>
<td colspan="2"><p>Nombre:</p><p>Compatibilidad web</p></td>
</tr>
<tr>
<td><p>Tipo:</p><p>Compatibilidad</p></td>
<td colspan="2"><p>Requerimiento que lo utiliza o especializa:</p></td>
<td><p>&#191;Cr&#237;tico?</p><p>Si</p></td>
</tr>
<tr>
<td><p>Prioridad de desarrollo:</p><p>Alto</p></td>
<td colspan="3"><p>Documentos de visualizaci&#243;n asociados:</p><p><br /></p><p>● Pruebas de navegador</p><p>● Validaciones HTML y CSS</p><p>● Reportes de compatibilidad multiplataforma</p></td>
</tr>
<tr>
<td><p>Entrada:</p><p>Acceso desde navegadores actuales</p></td>
<td colspan="3"><p>Salida:</p><p>Interfaz funcional y completa</p></td>
</tr>
<tr>
<td colspan="4"><p>Descripci&#243;n:</p><p><br /></p><p>● El sistema debe ser completamente funcional desde navegadores modernos, garantizando la correcta ejecuci&#243;n de sus componentes y la compatibilidad con los principales motores de renderizado.</p></td>
</tr>
<tr>
<td colspan="4"><p>Manejo de situaciones anormales</p><p>● Si el usuario intenta ingresar desde un navegador obsoleto, se mostrar&#225; un mensaje de advertencia.</p><p>● Los errores de compatibilidad deber&#225;n registrarse autom&#225;ticamente en los logs del sistema.</p></td>
</tr>
<tr>
<td colspan="4"><p>Criterios de aceptaci&#243;n</p><p>● Compatibilidad total con Chrome, Edge, Firefox y Opera.</p><p>● Las interfaces y funcionalidades deben conservar el mismo comportamiento en todos los navegadores.</p></td>
</tr>
</table>


RNF4 Disponibilidad y confiabilidad

<table>
<tr>
<td colspan="2"><p>Identificador: RNF4.1</p></td>
<td colspan="2"><p>Nombre:</p><p>Disponibilidad</p></td>
</tr>
<tr>
<td><p>Tipo:</p><p>Disponibilidad y Confiabilidad</p></td>
<td colspan="2"><p>Requerimiento que lo utiliza o especializa:</p></td>
<td><p>&#191;Cr&#237;tico?</p><p>Si</p></td>
</tr>
<tr>
<td><p>Prioridad de desarrollo:</p><p>Alto</p></td>
<td colspan="3"><p>Documentos de visualizaci&#243;n asociados:</p><p><br /></p><p>● Reportes de uptime</p><p>● Planes de contingencia</p><p>● Monitoreo de red</p></td>
</tr>
<tr>
<td><p>Entrada:</p><p>Servicios del sistema activos</p></td>
<td colspan="3"><p>Salida:</p><p>Plataforma accesible y estable</p></td>
</tr>
<tr>
<td colspan="4"><p>Descripci&#243;n:</p><p><br /></p><p>● El sistema debe garantizar un tiempo de disponibilidad m&#237;nimo del 99% anual, asegurando acceso continuo a los usuarios incluso durante mantenimientos o actualizaciones menores.</p></td>
</tr>
<tr>
<td colspan="4"><p>Manejo de situaciones anormales</p><p>● En caso de ca&#237;da, el sistema debe redirigir al usuario a una p&#225;gina de mantenimiento informativa.</p><p>● Los eventos de indisponibilidad deben almacenarse en un registro con fecha, duraci&#243;n y causa.</p></td>
</tr>
<tr>
<td colspan="4"><p>Criterios de aceptaci&#243;n</p><p>● Disponibilidad ≥ 99% anual.</p><p>● Tiempos de recuperaci&#243;n menores a 15 minutos.</p></td>
</tr>
</table>


<table>
<tr>
<td colspan="2"><p>Identificador: RNF4.2</p></td>
<td colspan="2"><p>Nombre:</p><p>Persistencia de datos</p></td>
</tr>
<tr>
<td><p>Tipo:</p><p>Confiabilidad</p></td>
<td colspan="2"><p>Requerimiento que lo utiliza o especializa:</p></td>
<td><p>&#191;Cr&#237;tico?</p><p>Si</p></td>
</tr>
<tr>
<td><p>Prioridad de desarrollo:</p><p>Alta</p></td>
<td colspan="3"><p>Documentos de visualizaci&#243;n asociados:</p><p><br /></p><p>● Manual de base de datos</p><p>● Pol&#237;ticas de respaldo</p><p>● Pruebas de integridad</p></td>
</tr>
<tr>
<td><p>Entrada:</p><p>Datos generados por usuarios y el sistema</p></td>
<td colspan="3"><p>Salida:</p><p>Registros almacenados permanentemente</p></td>
</tr>
<tr>
<td colspan="4"><p>Descripci&#243;n:</p><p><br /></p><p>● Los registros, historiales y configuraciones deben almacenarse de forma segura y sin riesgo de p&#233;rdida. Se deben aplicar mecanismos de respaldo autom&#225;tico y redundancia de datos.</p></td>
</tr>
<tr>
<td colspan="4"><p>Manejo de situaciones anormales</p><p>● Si ocurre una falla en el almacenamiento, el sistema debe activar el mecanismo de recuperaci&#243;n de respaldo.</p><p>● En caso de error de escritura, se debe notificar autom&#225;ticamente al administrador.</p></td>
</tr>
<tr>
<td colspan="4"><p>Criterios de aceptaci&#243;n</p><p>● Cero p&#233;rdidas de datos durante las operaciones normales.</p><p>● Copias de respaldo verificadas diariamente.</p></td>
</tr>
</table>


<table>
<tr>
<td colspan="2"><p>Identificador: RNF4.3</p></td>
<td colspan="2"><p>Nombre:</p><p>Notificaciones en tiempo real</p></td>
</tr>
<tr>
<td><p>Tipo: Disponibilidad</p></td>
<td colspan="2"><p>Requerimiento que lo utiliza o especializa:</p><p>&nbsp;</p></td>
<td><p>&#191;Cr&#237;tico? Si</p></td>
</tr>
<tr>
<td><p>Prioridad de desarrollo: Alto</p></td>
<td colspan="3"><p>Documentos de visualizaci&#243;n asociados:</p><p>● Plan de mensajer&#237;a</p><p>● Logs de servidor</p><p>● Manual de configuraci&#243;n de alertas</p></td>
</tr>
<tr>
<td><p>Entrada:</p><p>Eventos del sistema</p></td>
<td colspan="3"><p>Salida:</p><p>Alertas y notificaciones enviadas</p></td>
</tr>
<tr>
<td colspan="4"><p>Descripci&#243;n:</p><p>● El sistema debe emitir notificaciones instant&#225;neas cuando se produzcan eventos relevantes (alertas, actualizaciones o cambios de estado).</p></td>
</tr>
<tr>
<td colspan="4"><p>Manejo de situaciones anormales</p><p>● Si un canal de notificaci&#243;n falla, el sistema debe reenviar la alerta por un canal alternativo.</p><p>● Las notificaciones fallidas deben registrarse en la base de datos.</p></td>
</tr>
<tr>
<td colspan="4"><p>Criterios de aceptaci&#243;n</p><p><br /></p><p>● Tiempo de env&#237;o menor a 3 segundos tras el evento.</p><p>● Tasa de entrega superior al 98%.</p></td>
</tr>
</table>


<table>
<tr>
<td colspan="2"><p>Identificador: RNF4.4</p></td>
<td colspan="2"><p>Nombre</p><p>Recuperaci&#243;n ante fallos</p></td>
</tr>
<tr>
<td><p>Tipo: Disponibilidad y confiabilidad</p></td>
<td colspan="2"><p>Requerimiento que lo utiliza o especializa:</p><p>&nbsp;</p></td>
<td><p>&#191;Cr&#237;tico?</p><p>S&#237;</p></td>
</tr>
<tr>
<td><p>Prioridad de desarrollo: Alto</p></td>
<td colspan="3"><p>Documentos de visualizaci&#243;n asociados:</p><p>● Protocolos de respaldo.</p><p>● Plan de recuperaci&#243;n ante desastres.</p><p>● Procedimientos de restauraci&#243;n.</p></td>
</tr>
<tr>
<td><p>Entrada:</p><p>Falla del sistema o interrupci&#243;n del servicio.</p></td>
<td colspan="3"><p>Salida:</p><p>Recuperaci&#243;n autom&#225;tica y restablecimiento de la operaci&#243;n normal.</p></td>
</tr>
<tr>
<td colspan="4"><p>Descripci&#243;n:</p><p>● El sistema debe contar con mecanismos autom&#225;ticos para realizar respaldos peri&#243;dicos y permitir la restauraci&#243;n r&#225;pida en caso de fallos o p&#233;rdida de informaci&#243;n. Los datos cr&#237;ticos deben preservarse sin corrupci&#243;n.</p></td>
</tr>
<tr>
<td colspan="4"><p>Manejo de situaciones anormales</p><p>● Ante una ca&#237;da del sistema, debe activarse el proceso de restauraci&#243;n autom&#225;tica y notificar al administrador.</p></td>
</tr>
<tr>
<td colspan="4"><p>Criterios de aceptaci&#243;n</p><p><br /></p><p>● El tiempo de recuperaci&#243;n no debe superar los 5 minutos.</p><p>● No se debe perder informaci&#243;n registrada antes del fallo.</p></td>
</tr>
</table>


RNF5 Seguridad

<table>
<tr>
<td colspan="2"><p>Identificador: RNF5</p></td>
<td colspan="2"><p>Nombre:</p><p>Seguridad general</p></td>
</tr>
<tr>
<td><p>Tipo:</p><p>Seguridad</p></td>
<td colspan="2"><p>Requerimiento que lo utiliza o especializa:</p></td>
<td><p>&#191;Cr&#237;tico?</p><p>Si</p></td>
</tr>
<tr>
<td><p>Prioridad de desarrollo:</p><p>Alto</p></td>
<td colspan="3"><p>Documentos de visualizaci&#243;n asociados:</p><p>● Pol&#237;ticas de seguridad</p><p>● Normas ISO/IEC 27001</p><p>● Registros de auditor&#237;a</p></td>
</tr>
<tr>
<td><p>Entrada:</p><p>Datos de usuario</p></td>
<td colspan="3"><p>Salida:</p><p>Datos protegidos y cifrados</p></td>
</tr>
<tr>
<td colspan="4"><p>Descripci&#243;n:</p><p><br /></p><p>● El sistema debe cumplir con los lineamientos de privacidad y seguridad establecidos por las normas internacionales, garantizando la confidencialidad, integridad y disponibilidad de la informaci&#243;n.</p></td>
</tr>
<tr>
<td colspan="4"><p>Manejo de situaciones anormales</p><p><br /></p><p>● Si se detecta intento de acceso no autorizado, el sistema debe bloquear la sesi&#243;n y notificar al administrador.</p><p>● Los incidentes deben registrarse y auditarse seg&#250;n el protocolo de seguridad.</p></td>
</tr>
<tr>
<td colspan="4"><p>Criterios de aceptaci&#243;n</p><p>● Todos los datos sensibles viajan cifrados mediante HTTPS/TLS.</p><p>● Acceso autorizado &#250;nicamente con credenciales v&#225;lidas.</p></td>
</tr>
</table>


<table>
<tr>
<td colspan="2"><p>Identificador: RNF5.1</p></td>
<td colspan="2"><p>Nombre:</p><p>Control de acceso</p></td>
</tr>
<tr>
<td><p>Tipo:</p><p>Seguridad</p></td>
<td colspan="2"><p>Requerimiento que lo utiliza o especializa:</p></td>
<td><p>&#191;Cr&#237;tico?</p><p>Si</p></td>
</tr>
<tr>
<td><p>Prioridad de desarrollo:</p><p>Alta</p></td>
<td colspan="3"><p>Documentos de visualizaci&#243;n asociados:</p><p>● Pol&#237;tica de roles</p><p>● Manual de autenticaci&#243;n</p><p>● Registro de accesos y permisos</p></td>
</tr>
<tr>
<td><p>Entrada:</p><p>Credenciales del usuario</p></td>
<td colspan="3"><p>Salida:</p><p>Permisos de acceso a m&#243;dulos espec&#237;ficos</p></td>
</tr>
<tr>
<td colspan="4"><p>Descripci&#243;n:</p><p>● El sistema debe permitir el acceso solo a usuarios con privilegios autorizados. Cada perfil debe tener permisos definidos que limiten las acciones que puede ejecutar dentro de la plataforma.</p></td>
</tr>
<tr>
<td colspan="4"><p>Manejo de situaciones anormales</p><p>● Si un usuario intenta acceder a un m&#243;dulo restringido, se mostrar&#225; un mensaje de acceso denegado.</p><p>● Cualquier intento de acceso no permitido debe registrarse autom&#225;ticamente con hora y direcci&#243;n IP.</p></td>
</tr>
<tr>
<td colspan="4"><p>Criterios de aceptaci&#243;n</p><p>● Validaci&#243;n de acceso en menos de 2 segundos.</p><p>● Todos los accesos y bloqueos quedan auditados.</p></td>
</tr>
</table>


<table>
<tr>
<td colspan="2"><p>Identificador: RNF5.2</p></td>
<td colspan="2"><p>Nombre:</p><p>Autenticaci&#243;n segura</p></td>
</tr>
<tr>
<td><p>Tipo:</p><p>Usabilidad</p></td>
<td colspan="2"><p>Requerimiento que lo utiliza o especializa:</p></td>
<td><p>&#191;Cr&#237;tico?</p><p>Si</p></td>
</tr>
<tr>
<td><p>Prioridad de desarrollo:</p><p>Alto</p></td>
<td colspan="3"><p>Documentos de visualizaci&#243;n asociados:</p><p><br /></p><p>● Esquemas de sesi&#243;n</p><p>● Manual de inicio y cierre seguro</p><p>● Auditor&#237;as de autenticaci&#243;n</p></td>
</tr>
<tr>
<td><p>Entrada:</p><p>Solicitud de inicio o cierre de sesi&#243;n</p></td>
<td colspan="3"><p>Salida:</p><p>Sesi&#243;n iniciada o terminada correctamente</p></td>
</tr>
<tr>
<td colspan="4"><p>Descripci&#243;n:</p><p><br /></p><p>● Los procesos de autenticaci&#243;n deben proteger la informaci&#243;n del usuario mediante cifrado y manejo de tokens de sesi&#243;n. Al cerrar sesi&#243;n, los tokens deben invalidar inmediatamente para evitar reutilizaci&#243;n no autorizada.</p></td>
</tr>
<tr>
<td colspan="4"><p>Manejo de situaciones anormales</p><p>● Si un token caduc&#243;, el sistema cerrar&#225; sesi&#243;n autom&#225;ticamente.</p><p>● Los intentos de autenticaci&#243;n desde ubicaciones sospechosas se bloquear&#225;n temporalmente.</p></td>
</tr>
<tr>
<td colspan="4"><p>Criterios de aceptaci&#243;n</p><p>● Tiempo m&#225;ximo de sesi&#243;n inactiva: 15 minutos.</p><p>● Sesiones simult&#225;neas desde diferentes IP no permitidas.</p></td>
</tr>
</table>


<table>
<tr>
<td colspan="2"><p>Identificador: RNF5.3</p></td>
<td colspan="2"><p>Nombre:</p><p>Cifrado de datos</p></td>
</tr>
<tr>
<td><p>Tipo:</p><p>Seguridad</p></td>
<td colspan="2"><p>Requerimiento que lo utiliza o especializa:</p></td>
<td><p>&#191;Cr&#237;tico?</p><p>Si</p></td>
</tr>
<tr>
<td><p>Prioridad de desarrollo:</p><p>Alto</p></td>
<td colspan="3"><p>Documentos de visualizaci&#243;n asociados:</p><p><br /></p><p>● Pol&#237;tica de seguridad de datos</p><p>● Certificados HTTPS</p><p>● Especificaciones de cifrado AES y SSL/TLS.</p></td>
</tr>
<tr>
<td><p>Entrada:</p><p>Datos sensibles del usuario.</p></td>
<td colspan="3"><p>Salida:</p><p>Datos cifrados durante transmisi&#243;n y almacenamiento.</p></td>
</tr>
<tr>
<td colspan="4"><p>Descripci&#243;n:</p><p><br /></p><p>● Toda la informaci&#243;n sensible debe transmitirse bajo protocolos HTTPS y almacenarse cifrada en la base de datos. El cifrado garantizar&#225; la confidencialidad e integridad de los datos.</p></td>
</tr>
<tr>
<td colspan="4"><p>Manejo de situaciones anormales</p><p>● Si se detecta una transmisi&#243;n insegura, el sistema debe bloquear la comunicaci&#243;n y registrar el evento.</p></td>
</tr>
<tr>
<td colspan="4"><p>Criterios de aceptaci&#243;n</p><p>● Todas las conexiones deben usar HTTPS.</p><p>● La base de datos debe cifrar informaci&#243;n sensible con cifrado en reposo no verificado en el corte actual.</p></td>
</tr>
</table>


<table>
<tr>
<td colspan="2"><p>Identificador: RNF5.4</p></td>
<td colspan="2"><p>Nombre:</p><p>Copias de seguridad</p></td>
</tr>
<tr>
<td><p>Tipo:</p><p>Seguridad</p></td>
<td colspan="2"><p>Requerimiento que lo utiliza o especializa:</p></td>
<td><p>&#191;Cr&#237;tico?</p><p>Si</p></td>
</tr>
<tr>
<td><p>Prioridad de desarrollo:</p><p>Alto</p></td>
<td colspan="3"><p>Documentos de visualizaci&#243;n asociados:</p><p><br /></p><p>● Plan de respaldo y recuperaci&#243;n</p><p>● Configuraci&#243;n de almacenamiento en la nube.</p></td>
</tr>
<tr>
<td><p>Entrada:</p><p>Datos del sistema y de usuarios.</p></td>
<td colspan="3"><p>Salida:</p><p>Copias de respaldo almacenadas de forma segura.</p></td>
</tr>
<tr>
<td colspan="4"><p>Descripci&#243;n:</p><p><br /></p><p>● El sistema debe generar respaldos autom&#225;ticos semanales y mantenerlos cifrados en la nube. Debe garantizar la integridad y recuperaci&#243;n de los datos.</p></td>
</tr>
<tr>
<td colspan="4"><p>Manejo de situaciones anormales</p><p>● En caso de p&#233;rdida de datos, debe restaurarse la informaci&#243;n m&#225;s reciente del respaldo.</p></td>
</tr>
<tr>
<td colspan="4"><p>Criterios de aceptaci&#243;n</p><p>● El respaldo debe realizarse de forma autom&#225;tica cada semana.</p><p>● Los archivos de respaldo deben estar cifrados y accesibles s&#243;lo por personal autorizado.</p></td>
</tr>
</table>


RNF6 Gestión y Operación

<table>
<tr>
<td colspan="2"><p>Identificador: RNF6.1</p></td>
<td colspan="2"><p>Nombre:</p><p>Roles y responsabilidades</p></td>
</tr>
<tr>
<td><p>Tipo:</p><p>Gesti&#243;n y Operaci&#243;n</p></td>
<td colspan="2"><p>Requerimiento que lo utiliza o especializa:</p></td>
<td><p>&#191;Cr&#237;tico?</p><p>Si</p></td>
</tr>
<tr>
<td><p>Prioridad de desarrollo:</p><p>Media</p></td>
<td colspan="3"><p>Documentos de visualizaci&#243;n asociados:</p><p><br /></p><p>● Manual de operaci&#243;n del sistema</p><p>● Diagrama de roles t&#233;cnicos</p><p>● Pol&#237;tica de gesti&#243;n de cuentas</p></td>
</tr>
<tr>
<td><p>Entrada:</p><p>Definici&#243;n de usuarios y roles</p></td>
<td colspan="3"><p>Salida:</p><p>Responsabilidades asignadas correctamente</p></td>
</tr>
<tr>
<td colspan="4"><p>Descripci&#243;n:</p><p><br /></p><p>● Los roles del sistema deben estar claramente definidos, estableciendo qu&#233; funciones y permisos tiene cada usuario t&#233;cnico y operativo. Esta estructura permite una gesti&#243;n segura y organizada del sistema.</p></td>
</tr>
<tr>
<td colspan="4"><p>Manejo de situaciones anormales</p><p>● Si un usuario intenta ejecutar una acci&#243;n fuera de su rol, el sistema la denegar&#225;.</p><p>● Se deben generar reportes autom&#225;ticos de cambios en permisos.</p></td>
</tr>
<tr>
<td colspan="4"><p>Criterios de aceptaci&#243;n</p><p>● Todos los usuarios tienen roles definidos.</p><p>● Cambios en roles documentados y auditados.</p></td>
</tr>
</table>


<table>
<tr>
<td colspan="2"><p>Identificador: RNF6.2</p></td>
<td colspan="2"><p>Nombre:</p><p>Gesti&#243;n de incidentes</p></td>
</tr>
<tr>
<td><p>Tipo:</p><p>Gesti&#243;n y Seguridad</p></td>
<td colspan="2"><p>Requerimiento que lo utiliza o especializa:</p></td>
<td><p>&#191;Cr&#237;tico?</p><p>Si</p></td>
</tr>
<tr>
<td><p>Prioridad de desarrollo:</p><p>Alta</p></td>
<td colspan="3"><p>Documentos de visualizaci&#243;n asociados:</p><p><br /></p><p>● Plan de contingencia</p><p>● Bit&#225;cora de incidentes</p><p>● Procedimiento de respuesta</p></td>
</tr>
<tr>
<td><p>Entrada:</p><p>Evento inesperado o falla</p></td>
<td colspan="3"><p>Salida:</p><p>Respuesta documentada y controlada</p></td>
</tr>
<tr>
<td colspan="4"><p>Descripci&#243;n:</p><p><br /></p><p>● Debe existir un plan formal de gesti&#243;n de incidentes que incluya la identificaci&#243;n, registro, an&#225;lisis y soluci&#243;n de fallas o vulnerabilidades detectadas en el sistema.</p></td>
</tr>
<tr>
<td colspan="4"><p>Manejo de situaciones anormales</p><p>● Si ocurre un incidente cr&#237;tico, debe activarse el protocolo de contingencia.</p><p>● Los reportes deben generarse autom&#225;ticamente con fecha, hora y responsable.</p></td>
</tr>
<tr>
<td colspan="4"><p>Criterios de aceptaci&#243;n</p><p>● 100% de los incidentes documentados en menos de 24 horas.</p><p>● Tiempos de respuesta menores a 2 horas para incidentes cr&#237;ticos.</p></td>
</tr>
</table>


<table>
<tr>
<td colspan="2"><p>Identificador: RNF6.3</p></td>
<td colspan="2"><p>Nombre:</p><p>Mantenibilidad</p></td>
</tr>
<tr>
<td><p>Tipo:</p><p>Gesti&#243;n y Desarrollo</p></td>
<td colspan="2"><p>Requerimiento que lo utiliza o especializa:</p></td>
<td><p>&#191;Cr&#237;tico?</p><p>Si</p></td>
</tr>
<tr>
<td><p>Prioridad de desarrollo:</p><p>Alto</p></td>
<td colspan="3"><p>Documentos de visualizaci&#243;n asociados:</p><p><br /></p><p>● Manual t&#233;cnico</p><p>● Historial de versiones</p><p>● Registro de actualizaciones</p></td>
</tr>
<tr>
<td><p>Entrada:</p><p>Cambios o actualizaciones del sistema</p></td>
<td colspan="3"><p>Salida:</p><p>Sistema actualizado sin afectar operaciones</p></td>
</tr>
<tr>
<td colspan="4"><p>Descripci&#243;n:</p><p><br /></p><p>● El sistema debe estar dise&#241;ado de forma modular y documentada, facilitando actualizaciones, correcciones y mejoras sin afectar el funcionamiento general.</p></td>
</tr>
<tr>
<td colspan="4"><p>Manejo de situaciones anormales</p><p>● Si una actualizaci&#243;n causa error, debe existir la opci&#243;n de reversi&#243;n inmediata.</p><p>● Se registrar&#225;n todas las modificaciones realizadas al c&#243;digo.</p></td>
</tr>
<tr>
<td colspan="4"><p>Criterios de aceptaci&#243;n</p><p>● Actualizaciones implementadas sin interrupciones.</p><p>● Documentaci&#243;n t&#233;cnica actualizada tras cada cambio.</p></td>
</tr>
</table>



RNF7 Portabilidad y Accesibilidad

<table>
<tr>
<td colspan="2"><p>Identificador: RNF7.1</p></td>
<td colspan="2"><p>Nombre:</p><p>Portabilidad</p></td>
</tr>
<tr>
<td><p>Tipo:</p><p>Portabilidad y Accesibilidad</p></td>
<td colspan="2"><p>Requerimiento que lo utiliza o especializa:</p></td>
<td><p>&#191;Cr&#237;tico?</p><p>No</p></td>
</tr>
<tr>
<td><p>Prioridad de desarrollo:</p><p>Medio</p></td>
<td colspan="3"><p>Documentos de visualizaci&#243;n asociados:</p><p><br /></p><p>● Gu&#237;as de migraci&#243;n</p><p>● Documentaci&#243;n de compatibilidad.</p></td>
</tr>
<tr>
<td><p>Entrada:</p><p>Configuraciones del sistema actual.</p></td>
<td colspan="3"><p>Salida:</p><p>Migraci&#243;n exitosa a otro entorno.</p></td>
</tr>
<tr>
<td colspan="4"><p>Descripci&#243;n:</p><p><br /></p><p>● El sistema debe poder migrar a otras plataformas o entornos con un m&#237;nimo esfuerzo de configuraci&#243;n y sin p&#233;rdida de datos.</p></td>
</tr>
<tr>
<td colspan="4"><p>Manejo de situaciones anormales</p><p>● Si ocurre un error durante la migraci&#243;n, el sistema debe revertir los cambios y registrar el evento.</p></td>
</tr>
<tr>
<td colspan="4"><p>Criterios de aceptaci&#243;n</p><p>● La migraci&#243;n no debe requerir m&#225;s del 10% de reconfiguraci&#243;n manual.</p><p>● No debe perderse informaci&#243;n durante el proceso.</p></td>
</tr>
</table>


<table>
<tr>
<td colspan="2"><p>Identificador: RNF7.2</p></td>
<td colspan="2"><p>Nombre:</p><p>Accesibilidad</p></td>
</tr>
<tr>
<td><p>Tipo:</p><p>Portabilidad y Accesibilidad</p></td>
<td colspan="2"><p>Requerimiento que lo utiliza o especializa:</p></td>
<td><p>&#191;Cr&#237;tico?</p><p>S&#237;</p></td>
</tr>
<tr>
<td><p>Prioridad de desarrollo:</p><p>Alta</p></td>
<td colspan="3"><p>Documentos de visualizaci&#243;n asociados:</p><p><br /></p><p>● Normas WCAG 2.1</p><p>● Manual de accesibilidad</p><p>● Gu&#237;a de dise&#241;o inclusivo</p></td>
</tr>
<tr>
<td><p>Entrada:</p><p>Interacci&#243;n del usuario con discapacidad.</p></td>
<td colspan="3"><p>Salida:</p><p>Interfaz accesible y funcional.</p></td>
</tr>
<tr>
<td colspan="4"><p>Descripci&#243;n:</p><p><br /></p><p>● La interfaz debe cumplir con las normas WCAG 2.1 para garantizar el acceso a usuarios con discapacidad visual o auditiva.</p></td>
</tr>
<tr>
<td colspan="4"><p>Manejo de situaciones anormales</p><p>● Si se detectan barreras de accesibilidad, deben corregirse antes del despliegue.</p></td>
</tr>
<tr>
<td colspan="4"><p>Criterios de aceptaci&#243;n</p><p>● El sistema debe ser navegable mediante teclado.</p><p>● Los elementos visuales deben incluir texto alternativo.</p></td>
</tr>
</table>


<table>
<tr>
<td colspan="2"><p>Identificador: RNF7.3</p></td>
<td colspan="2"><p>Nombre:</p><p>Multiplataforma</p></td>
</tr>
<tr>
<td><p>Tipo:</p><p>Portabilidad y Accesibilidad</p></td>
<td colspan="2"><p>Requerimiento que lo utiliza o especializa:</p></td>
<td><p>&#191;Cr&#237;tico?</p><p>S&#237;</p></td>
</tr>
<tr>
<td><p>Prioridad de desarrollo:</p><p>Alta</p></td>
<td colspan="3"><p>Documentos de visualizaci&#243;n asociados:</p><p><br /></p><p>● Pruebas de compatibilidad</p><p>● Reportes de ejecuci&#243;n multiplataforma.</p></td>
</tr>
<tr>
<td><p>Entrada:</p><p>Aplicaci&#243;n ejecutada en distintos dispositivos.</p></td>
<td colspan="3"><p>Salida:</p><p>Funcionamiento consistente en todos los entornos.</p></td>
</tr>
<tr>
<td colspan="4"><p>Descripci&#243;n:</p><p><br /></p><p>● El sistema debe operar correctamente en dispositivos m&#243;viles, tablets y equipos de escritorio sin p&#233;rdida de funcionalidad.</p></td>
</tr>
<tr>
<td colspan="4"><p>Manejo de situaciones anormales</p><p>● Si se detecta un fallo en un entorno, debe corregirse antes de la siguiente versi&#243;n.</p></td>
</tr>
<tr>
<td colspan="4"><p>Criterios de aceptaci&#243;n</p><p>● El sistema debe adaptarse autom&#225;ticamente a la resoluci&#243;n del dispositivo.</p><p>● Todas las funciones deben ser iguales en web y m&#243;vil.</p></td>
</tr>
</table>




RNF8 Sostenibilidad y Cumplimiento Normativo

<table>
<tr>
<td colspan="2"><p>Identificador: RNF8.1</p></td>
<td colspan="2"><p>Nombre:</p><p>Eficiencia energ&#233;tica</p></td>
</tr>
<tr>
<td><p>Tipo:</p><p>Sostenibilidad y Cumplimiento Normativo</p></td>
<td colspan="2"><p>Requerimiento que lo utiliza o especializa:</p></td>
<td><p>&#191;Cr&#237;tico?</p><p>No</p></td>
</tr>
<tr>
<td><p>Prioridad de desarrollo:</p><p>Media</p></td>
<td colspan="3"><p>Documentos de visualizaci&#243;n asociados:</p><p><br /></p><p>● Reportes de consumo de recursos</p><p>● M&#233;tricas de rendimiento energ&#233;tico.</p></td>
</tr>
<tr>
<td><p>Entrada:</p><p>Procesos en ejecuci&#243;n en segundo plano.</p></td>
<td colspan="3"><p>Salida:</p><p>Uso optimizado de CPU y memoria.</p></td>
</tr>
<tr>
<td colspan="4"><p>Descripci&#243;n:</p><p><br /></p><p>● El software debe minimizar el consumo de recursos en segundo plano, favoreciendo el ahorro energ&#233;tico.</p></td>
</tr>
<tr>
<td colspan="4"><p>Manejo de situaciones anormales</p><p>● Si el consumo excede los l&#237;mites esperados, el sistema debe reducir tareas no esenciales.</p></td>
</tr>
<tr>
<td colspan="4"><p>Criterios de aceptaci&#243;n</p><p>● El uso de CPU en segundo plano no debe superar el 15%.</p><p>● Las tareas inactivas deben suspenderse autom&#225;ticamente.</p></td>
</tr>
</table>


<table>
<tr>
<td colspan="2"><p>Identificador: RNF8.2</p></td>
<td colspan="2"><p>Nombre:</p><p>Cumplimiento normativo</p></td>
</tr>
<tr>
<td><p>Tipo:</p><p>Sostenibilidad y Cumplimiento Normativo</p></td>
<td colspan="2"><p>Requerimiento que lo utiliza o especializa:</p></td>
<td><p>&#191;Cr&#237;tico?</p><p>S&#237;</p></td>
</tr>
<tr>
<td><p>Prioridad de desarrollo:</p><p>Alta</p></td>
<td colspan="3"><p>Documentos de visualizaci&#243;n asociados:</p><p><br /></p><p>● Ley 1581 de 2012</p><p>● Pol&#237;tica de protecci&#243;n de datos</p><p>● Manual de cumplimiento legal.</p></td>
</tr>
<tr>
<td><p>Entrada:</p><p>Datos personales de usuarios.</p></td>
<td colspan="3"><p>Salida:</p><p>Tratamiento legal y seguro de la informaci&#243;n.</p></td>
</tr>
<tr>
<td colspan="4"><p>Descripci&#243;n:</p><p><br /></p><p>● El sistema debe cumplir con la Ley 1581 de 2012 sobre protecci&#243;n de datos personales en Colombia y con los reglamentos aplicables.</p></td>
</tr>
<tr>
<td colspan="4"><p>Manejo de situaciones anormales</p><p>● Si se detecta un incumplimiento, el sistema debe detener la operaci&#243;n relacionada y generar alerta al responsable.</p></td>
</tr>
<tr>
<td colspan="4"><p>Criterios de aceptaci&#243;n</p><p>● Todo tratamiento de datos debe contar con el consentimiento del usuario.</p><p>● Debe existir registro actualizado de pol&#237;ticas de privacidad.</p></td>
</tr>
</table>


<table>
<tr>
<td colspan="2"><p>Identificador: RNF8.3</p></td>
<td colspan="2"><p>Nombre:</p><p>Auditor&#237;a</p></td>
</tr>
<tr>
<td><p>Tipo:</p><p>Sostenibilidad y Cumplimiento Normativo</p></td>
<td colspan="2"><p>Requerimiento que lo utiliza o especializa:</p></td>
<td><p>&#191;Cr&#237;tico?</p><p>S&#237;</p></td>
</tr>
<tr>
<td><p>Prioridad de desarrollo:</p><p>Alta</p></td>
<td colspan="3"><p>Documentos de visualizaci&#243;n asociados:</p><p><br /></p><p>● Logs del sistema</p><p>● Registro de auditor&#237;as</p><p>● Manual de seguridad de informaci&#243;n.</p></td>
</tr>
<tr>
<td><p>Entrada:</p><p>Operaciones cr&#237;ticas realizadas por el sistema.</p></td>
<td colspan="3"><p>Salida:</p><p>Registro detallado de eventos.</p></td>
</tr>
<tr>
<td colspan="4"><p>Descripci&#243;n:</p><p><br /></p><p>● El sistema debe mantener registros detallados de las operaciones cr&#237;ticas, accesos y modificaciones para auditor&#237;as futuras.</p></td>
</tr>
<tr>
<td colspan="4"><p>Manejo de situaciones anormales</p><p>● En caso de fallo en el registro, debe activarse un respaldo alternativo.</p></td>
</tr>
<tr>
<td colspan="4"><p>Criterios de aceptaci&#243;n</p><p>● Todos los eventos cr&#237;ticos deben registrarse autom&#225;ticamente.</p><p>● Los registros deben conservarse por m&#237;nimo un a&#241;o.</p></td>
</tr>
</table>


<table>
<tr>
<td colspan="2"><p>Identificador: RNF8.4</p></td>
<td colspan="2"><p>Nombre:</p><p>Monitoreo del rendimiento</p></td>
</tr>
<tr>
<td><p>Tipo:</p><p>Sostenibilidad y Cumplimiento Normativo</p></td>
<td colspan="2"><p>Requerimiento que lo utiliza o especializa:</p></td>
<td><p>&#191;Cr&#237;tico?</p><p>S&#237;</p></td>
</tr>
<tr>
<td><p>Prioridad de desarrollo:</p><p>Alta</p></td>
<td colspan="3"><p>Documentos de visualizaci&#243;n asociados:</p><p><br /></p><p>● Herramientas de monitoreo</p><p>● Reportes autom&#225;ticos de desempe&#241;o.</p></td>
</tr>
<tr>
<td><p>Entrada:</p><p>Datos operativos del sistema.</p></td>
<td colspan="3"><p>Salida:</p><p>M&#233;tricas de desempe&#241;o actualizadas.</p></td>
</tr>
<tr>
<td colspan="4"><p>Descripci&#243;n:</p><p><br /></p><p>● Deben existir m&#233;tricas autom&#225;ticas que eval&#250;en continuamente el rendimiento del sistema para prevenir degradaciones.</p></td>
</tr>
<tr>
<td colspan="4"><p>Manejo de situaciones anormales</p><p>● Si se detecta un descenso del rendimiento, debe generarse alerta autom&#225;tica al administrador.</p></td>
</tr>
<tr>
<td colspan="4"><p>Criterios de aceptaci&#243;n</p><p>● El monitoreo debe ejecutarse en tiempo real.</p><p>● Las m&#233;tricas deben almacenarse para an&#225;lisis hist&#243;rico.</p></td>
</tr>
</table>




RNF9 Requerimientos técnicos

<table>
<tr>
<td colspan="2"><p>Identificador: RNF 9.1</p></td>
<td colspan="2"><p>Nombre:</p><p>Visualizaci&#243;n responsiva</p></td>
</tr>
<tr>
<td><p>Tipo:</p><p>Requerimiento t&#233;cnico</p></td>
<td colspan="2"><p>Requerimiento que lo utiliza o especializa:</p><p>Interfaces de usuario</p></td>
<td><p>&#191;Cr&#237;tico? Si</p></td>
</tr>
<tr>
<td><p>Prioridad de desarrollo: Alto</p></td>
<td colspan="3"><p>Documentos de visualizaci&#243;n asociados:</p><p>● Gu&#237;a de dise&#241;o responsive</p><p>● Mockups de interfaz</p><p>● Prototipos UI</p></td>
</tr>
<tr>
<td><p>Entrada:</p><p>Resoluci&#243;n y orientaci&#243;n del dispositivo</p></td>
<td colspan="3"><p>Salida:</p><p>Interfaz adaptada correctamente</p></td>
</tr>
<tr>
<td colspan="4"><p>Descripci&#243;n:</p><p>● El sistema debe adaptar autom&#225;ticamente la interfaz de usuario a diferentes tama&#241;os de pantalla y resoluciones, garantizando una correcta visualizaci&#243;n y usabilidad en dispositivos m&#243;viles, tablets y equipos de escritorio.</p></td>
</tr>
<tr>
<td colspan="4"><p>Manejo de situaciones anormales</p><p>● Si la resoluci&#243;n no es soportada, el sistema debe ajustar el dise&#241;o al formato m&#225;s cercano disponible.</p><p>● En caso de error de renderizado, se debe recargar la interfaz sin p&#233;rdida de informaci&#243;n.</p></td>
</tr>
<tr>
<td colspan="4"><p>Criterios de aceptaci&#243;n</p><p>● La interfaz se visualiza correctamente en distintos tama&#241;os de pantalla.</p><p>● No se presentan desbordamientos ni elementos ocultos.</p></td>
</tr>
</table>


<table>
<tr>
<td colspan="2"><p>Identificador: RNF9.2</p></td>
<td colspan="2"><p>Nombre:</p><p>Soporte t&#233;cnico</p></td>
</tr>
<tr>
<td><p>Tipo:</p><p>Requerimiento t&#233;cnico</p></td>
<td colspan="2"><p>Requerimiento que lo utiliza o especializa:</p><p>M&#243;dulos de operaci&#243;n y mantenimiento</p></td>
<td><p>&#191;Cr&#237;tico?</p><p>Si</p></td>
</tr>
<tr>
<td><p>Prioridad de desarrollo:</p><p>Media</p></td>
<td colspan="3"><p>Documentos de visualizaci&#243;n asociados:</p><p>● Manual de soporte t&#233;cnico</p><p>● Registro de incidencias</p></td>
</tr>
<tr>
<td><p>Entrada:</p><p>Solicitud de soporte o incidencia reportada</p></td>
<td colspan="3"><p>Salida:</p><p>Registro y estado de la solicitud</p></td>
</tr>
<tr>
<td colspan="4"><p>Descripci&#243;n:</p><table>
<tr>
<td><p>● </p></td>
</tr>
</table>

<p>&nbsp;</p><table>
<tr>
<td><p>● El sistema debe permitir la gesti&#243;n de solicitudes de soporte t&#233;cnico relacionadas con el funcionamiento de la aplicaci&#243;n o los dispositivos IoT asociados.</p></td>
</tr>
</table>

<p>&nbsp;</p></td>
</tr>
<tr>
<td colspan="4"><p>Manejo de situaciones anormales</p><p>● Si la solicitud no puede procesarse, el sistema debe notificar al usuario.</p><p>● Las solicitudes duplicadas deben agruparse autom&#225;ticamente.</p></td>
</tr>
<tr>
<td colspan="4"><p>Criterios de aceptaci&#243;n</p><p>● Las solicitudes de soporte quedan registradas correctamente.</p><p>● El estado de cada solicitud puede ser consultado.</p></td>
</tr>
</table>


<table>
<tr>
<td colspan="2"><p>Identificador: RNF9.3</p></td>
<td colspan="2"><p>Nombre:</p><p>Mantenimiento t&#233;cnico</p></td>
</tr>
<tr>
<td><p>Tipo:</p><p>Requerimiento t&#233;cnico</p></td>
<td colspan="2"><p>Requerimiento que lo utiliza o especializa:</p><p>Infraestructura y backend del sistema</p></td>
<td><p>&#191;Cr&#237;tico?</p><p>Si</p></td>
</tr>
<tr>
<td><p>Prioridad de desarrollo:</p><p>Alta</p></td>
<td colspan="3"><p>Documentos de visualizaci&#243;n asociados:</p><p>● Plan de mantenimiento</p><p>● Bit&#225;cora de cambios</p></td>
</tr>
<tr>
<td><p>Entrada:</p><p>Solicitud de mantenimiento o actualizaci&#243;n</p></td>
<td colspan="3"><p>Salida:</p><p>Sistema actualizado y operativo</p></td>
</tr>
<tr>
<td colspan="4"><p>Descripci&#243;n:</p><p>● El sistema debe permitir realizar tareas de mantenimiento t&#233;cnico, correcciones y actualizaciones sin afectar la disponibilidad ni el funcionamiento normal del servicio.</p></td>
</tr>
<tr>
<td colspan="4"><p>Manejo de situaciones anormales</p><p>● Si una actualizaci&#243;n falla, el sistema debe restaurar la versi&#243;n anterior.</p><p>● Se debe registrar cualquier error ocurrido durante el mantenimiento.</p></td>
</tr>
<tr>
<td colspan="4"><p>Criterios de aceptaci&#243;n</p><p>● El sistema permanece disponible durante el mantenimiento.</p><p>● No se presenta p&#233;rdida de datos.</p></td>
</tr>
</table>





# Requisitos de Casos de Uso.

## Diagrama UML de casos de uso.

[<u><strong>https://drive.google.com/drive/folders/1jIoAx99qIwPt0lQcZ4ltIn23225zSe3o?usp=sharing</strong></u>](https://drive.google.com/drive/folders/1jIoAx99qIwPt0lQcZ4ltIn23225zSe3o?usp=sharing)



<p>&nbsp;&nbsp;&nbsp;1.2. <strong>Caracterización de Casos de Uso</strong></p>

<table>
<tr>
<td><p>&nbsp;</p></td>
<td colspan="3"><p><strong>Caso de Uso  N&#176; 1</strong></p></td>
<td colspan="3"><p>&nbsp;</p></td>
</tr>
<tr>
<td><p><strong>Nombre</strong></p></td>
<td colspan="6"><p>Registrarse</p></td>
</tr>
<tr>
<td><p><strong>Descripci&#243;n</strong></p></td>
<td colspan="6"><p>La aplicaci&#243;n mostrar&#225; un formulario donde se registran los datos del usuario para permitir el acceso al sistema.</p></td>
</tr>
<tr>
<td><p><strong>Prioridad</strong></p></td>
<td colspan="6"><p>Alta</p></td>
</tr>
<tr>
<td><p><strong>Precondici&#243;n</strong></p></td>
<td colspan="6"><p>El usuario deber&#225; registrarse con un correo y una contrase&#241;a.</p></td>
</tr>
<tr>
<td><p><strong>Secuencia normal</strong></p></td>
<td><p>&nbsp;</p></td>
<td><p><strong>Paso</strong></p></td>
<td colspan="2"><p><strong>Acci&#243;n</strong></p></td>
<td><p><strong>Sistema</strong></p></td>
<td><p>&nbsp;</p></td>
</tr>
<tr>
<td><p>&nbsp;</p></td>
<td><p>&nbsp;</p></td>
<td><p><strong>1</strong></p></td>
<td colspan="2"><p>El usuario ingresa el nombre</p></td>
<td><p>El sistema solicita los datos personales (nombre, correo electr&#243;nico)</p></td>
<td><p>&nbsp;</p></td>
</tr>
<tr>
<td><p>&nbsp;</p></td>
<td><p>&nbsp;</p></td>
<td><p><strong>2</strong></p></td>
<td colspan="2"><p>El usuario ingresa el login</p></td>
<td><p>El sistema valida que el login no exista</p></td>
<td><p>&nbsp;</p></td>
</tr>
<tr>
<td><p>&nbsp;</p></td>
<td><p>&nbsp;</p></td>
<td><p><strong>3</strong></p></td>
<td colspan="2"><p>El usuario ingresa una contrase&#241;a</p></td>
<td><p>El sistema valida las reglas de seguridad</p></td>
<td><p>&nbsp;</p></td>
</tr>
<tr>
<td><p>&nbsp;</p></td>
<td><p>&nbsp;</p></td>
<td><p><strong>4</strong></p></td>
<td colspan="2"><p>Almacenar informaci&#243;n</p></td>
<td><p>El sistema guarda la informaci&#243;n en la base de datos</p></td>
<td><p>&nbsp;</p></td>
</tr>
<tr>
<td><p>&nbsp;</p></td>
<td><p>&nbsp;</p></td>
<td><p><strong>5</strong></p></td>
<td colspan="2"><p>Mostrar informaci&#243;n</p></td>
<td><p>El sistema muestra la informaci&#243;n del usuario</p></td>
<td><p>&nbsp;</p></td>
</tr>
</table>


<table>
<tr>
<td><p><strong>Postcondici&#243;n</strong></p></td>
<td colspan="4"><p>Si los datos del formulario de inicio de sesi&#243;n son correctos, el usuario accede a la pantalla de inicio del aplicativo.</p></td>
</tr>
<tr>
<td><p>&nbsp;</p><p><strong>Excepciones </strong></p><p><strong>(flujo alterno)</strong></p></td>
<td colspan="4"><p>&nbsp;</p></td>
</tr>
<tr>
<td><p>&nbsp;</p></td>
<td><p>&nbsp;</p></td>
<td><p><strong>P</strong><strong>a</strong><strong>so</strong></p></td>
<td><p><strong>Acci&#243;n</strong></p></td>
<td><p>&nbsp;</p></td>
</tr>
<tr>
<td><p>&nbsp;</p></td>
<td><p>&nbsp;</p></td>
<td><p><strong>1</strong></p></td>
<td><p>El usuario ingresa un dato incorrecto</p></td>
<td><p>&nbsp;</p></td>
</tr>
<tr>
<td><p><strong>Actores</strong></p></td>
<td colspan="4"><p>Usuario, Sistema</p></td>
</tr>
<tr>
<td><p><strong>Comentarios</strong></p></td>
<td colspan="4"><p>&nbsp;</p></td>
</tr>
</table>



<table>
<tr>
<td><p>&nbsp;</p></td>
<td colspan="3"><p><strong>Caso de Uso N&#176; 2</strong></p></td>
<td colspan="2"><p>&nbsp;</p></td>
</tr>
<tr>
<td><p><strong>Nombre</strong></p></td>
<td colspan="5"><p>Vincular dispositivos</p></td>
</tr>
<tr>
<td><p><strong>Descripci&#243;n</strong></p></td>
<td colspan="5"><p>Permite al usuario registrar nuevos dispositivos</p><p>&nbsp;</p></td>
</tr>
<tr>
<td><p><strong>Prioridad</strong></p></td>
<td colspan="5"><p>Alta</p></td>
</tr>
<tr>
<td><p><strong>Precondici&#243;n</strong></p></td>
<td colspan="5"><p>El usuario debe tener al menos un dispositivo para registrar.</p></td>
</tr>
<tr>
<td><p><strong>Secuencia normal</strong></p></td>
<td><p>&nbsp;</p></td>
<td><p><strong>Paso</strong></p></td>
<td><p><strong>Acci&#243;n</strong></p></td>
<td><p><strong>Sistema</strong></p></td>
<td><p>&nbsp;</p></td>
</tr>
<tr>
<td><p>&nbsp;</p></td>
<td><p>&nbsp;</p></td>
<td><p><strong>1</strong></p></td>
<td><p>El usuario registra un nuevo dispositivo</p></td>
<td><p>Agrega el dispositivo registrado</p></td>
<td><p>&nbsp;</p></td>
</tr>
<tr>
<td><p>&nbsp;</p></td>
<td><p>&nbsp;</p></td>
<td><p><strong>2</strong></p></td>
<td><p>El usuario configura el dispositivo</p></td>
<td><p>El sistema guarda los cambios temporalmente</p></td>
<td><p>&nbsp;</p></td>
</tr>
<tr>
<td><p>&nbsp;</p></td>
<td><p>&nbsp;</p></td>
<td><p><strong>3</strong></p></td>
<td><p>El usuario solicita guardar los cambios</p></td>
<td><p>El sistema los guarda</p></td>
<td><p>&nbsp;</p></td>
</tr>
</table>


<table>
<tr>
<td><p><strong>Postcondici&#243;n</strong></p></td>
<td colspan="4"><p>El usuario debe estar registrado.</p></td>
</tr>
<tr>
<td><p>&nbsp;</p><p><strong>Excepciones (flujo alterno)</strong></p></td>
<td colspan="4"><p>&nbsp;</p></td>
</tr>
<tr>
<td><p>&nbsp;</p></td>
<td><p>&nbsp;</p></td>
<td><p>Paso</p></td>
<td><p>Acci&#243;n</p></td>
<td><p>&nbsp;</p></td>
</tr>
<tr>
<td><p>&nbsp;</p></td>
<td><p>&nbsp;</p></td>
<td><p>1</p></td>
<td><p>&nbsp;</p></td>
<td><p>&nbsp;</p></td>
</tr>
<tr>
<td><p>&nbsp;</p></td>
<td><p>&nbsp;</p></td>
<td><p>2</p></td>
<td><p>&nbsp;</p></td>
<td><p>&nbsp;</p></td>
</tr>
<tr>
<td><p><strong>Actores</strong></p></td>
<td colspan="4"><p>Usuario, Sistema</p></td>
</tr>
<tr>
<td><p><strong>Comentarios</strong></p></td>
<td colspan="4"><p>&nbsp;</p></td>
</tr>
</table>



<table>
<tr>
<td><p>&nbsp;</p></td>
<td colspan="3"><p><strong>Caso de Uso N&#176; 3</strong></p></td>
<td colspan="3"><p>&nbsp;</p></td>
</tr>
<tr>
<td><p><strong>Nombre</strong></p></td>
<td colspan="6"><p>Implementaci&#243;n de nuevo proyecto</p></td>
</tr>
<tr>
<td><p><strong>Descripci&#243;n</strong></p></td>
<td colspan="6"><p>Permite al usuario agregar una nueva casa para asignarle los dispositivos.</p><p>&nbsp;</p></td>
</tr>
<tr>
<td><p><strong>Prioridad</strong></p></td>
<td colspan="6"><p>Media</p></td>
</tr>
<tr>
<td><p><strong>Precondici&#243;n</strong></p></td>
<td colspan="6"><p>El usuario debe estar registrado</p></td>
</tr>
<tr>
<td><p><strong>Secuencia normal</strong></p></td>
<td><p>&nbsp;</p></td>
<td><p><strong>Paso</strong></p></td>
<td colspan="2"><p><strong>Acci&#243;n</strong></p></td>
<td><p><strong>Sistema</strong></p></td>
<td><p>&nbsp;</p></td>
</tr>
<tr>
<td><p>&nbsp;</p></td>
<td><p>&nbsp;</p></td>
<td><p><strong>1</strong></p></td>
<td colspan="2"><p>El usuario crea el proyecto</p></td>
<td><p>El sistema lo guarda </p></td>
<td><p>&nbsp;</p></td>
</tr>
<tr>
<td><p>&nbsp;</p></td>
<td><p>&nbsp;</p></td>
<td><p><strong>2</strong></p></td>
<td colspan="2"><p>El usuario asigna los dispositivos al proyecto</p></td>
<td><p>El sistema lo aplica</p></td>
<td><p>&nbsp;</p></td>
</tr>
<tr>
<td><p>&nbsp;</p></td>
<td><p>&nbsp;</p></td>
<td><p><strong>3</strong></p></td>
<td colspan="2"><p>El usuario configura el proyecto</p></td>
<td><p>El sistema guarda las configuraciones realizadas</p></td>
<td><p>&nbsp;</p></td>
</tr>
<tr>
<td><p>&nbsp;</p></td>
<td><p>&nbsp;</p></td>
<td><p><strong>4</strong></p></td>
<td colspan="2"><p>EL usuario asigna nuevos usuarios y sus permisos correspondientes</p></td>
<td><p>El sistema busca y guarda los usuarios junto a sus permisos</p></td>
<td><p>&nbsp;</p></td>
</tr>
</table>


<table>
<tr>
<td><p><strong>Postcondici&#243;n</strong></p></td>
<td colspan="4"><p> Registrar los dispositivos de antemano.</p></td>
</tr>
<tr>
<td><p>&nbsp;</p><p><strong>Excepciones (flujo alterno)</strong></p></td>
<td colspan="4"><p>&nbsp;</p></td>
</tr>
<tr>
<td><p>&nbsp;</p></td>
<td><p>&nbsp;</p></td>
<td><p><strong>Paso</strong></p></td>
<td><p><strong>Acci&#243;n</strong></p></td>
<td><p>&nbsp;</p></td>
</tr>
<tr>
<td><p>&nbsp;</p></td>
<td><p>&nbsp;</p></td>
<td><p><strong>1</strong></p></td>
<td><p>Correo no registrado</p></td>
<td><p>&nbsp;</p></td>
</tr>
<tr>
<td><p>&nbsp;</p></td>
<td><p>&nbsp;</p></td>
<td><p><strong>2</strong></p></td>
<td><p>El sistema muestra mensaje de error</p></td>
<td><p>&nbsp;</p></td>
</tr>
<tr>
<td><p><strong>Actores</strong></p></td>
<td colspan="4"><p>Usuario</p></td>
</tr>
<tr>
<td><p><strong>Comentarios</strong></p></td>
<td colspan="4"><p>&nbsp;</p></td>
</tr>
</table>




<table>
<tr>
<td><p>&nbsp;</p></td>
<td colspan="2"><p><strong>Caso de Uso N&#176; 4</strong></p></td>
<td colspan="2"><p>&nbsp;</p></td>
</tr>
<tr>
<td><p><strong>Nombre</strong></p></td>
<td colspan="4"><p>Configuraciones del sistema</p></td>
</tr>
<tr>
<td><p><strong>Descripci&#243;n</strong></p></td>
<td colspan="4"><p>Permite al usuario configurar el sistema a su gusto.</p><p>&nbsp;</p></td>
</tr>
<tr>
<td><p><strong>Prioridad</strong></p></td>
<td colspan="4"><p>Alta</p></td>
</tr>
<tr>
<td><p><strong>Precondici&#243;n</strong></p></td>
<td colspan="4"><p>Usuario autenticado.</p><p>&nbsp;</p></td>
</tr>
<tr>
<td><p><strong>Secuencia normal</strong></p></td>
<td><p><strong>Paso</strong></p></td>
<td colspan="2"><p><strong>Acci&#243;n</strong></p></td>
<td><p><strong>Sistema</strong></p></td>
</tr>
<tr>
<td><p>&nbsp;</p></td>
<td><p><strong>1</strong></p></td>
<td colspan="2"><p>El usuario ingresa a las configuraciones</p></td>
<td><p>&nbsp;</p><p>&nbsp;</p><p>El sistema guarda y aplica los cambios al sistema (y si es necesario actualizar se avisa)</p></td>
</tr>
<tr>
<td><p>&nbsp;</p></td>
<td><p><strong>2</strong></p></td>
<td colspan="2"><p>El usuario cambia la est&#233;tica (Color, idioma, moneda)</p></td>
<td><p>&nbsp;</p></td>
</tr>
<tr>
<td><p>&nbsp;</p></td>
<td><p><strong>3</strong></p></td>
<td colspan="2"><p>El usuario configura las alertas</p></td>
<td><p>&nbsp;</p></td>
</tr>
<tr>
<td><p>&nbsp;</p></td>
<td><p><strong>4</strong></p></td>
<td colspan="2"><p>El usuario ve los controles de auditoria</p></td>
<td><p>El sistema le da acceso para verlo</p></td>
</tr>
</table>


<table>
<tr>
<td><p><strong>Postcondici&#243;n</strong></p></td>
<td colspan="4"><p> Registrar los dispositivos de antemano.</p></td>
</tr>
<tr>
<td><p>&nbsp;</p><p><strong>Excepciones (flujo alterno)</strong></p></td>
<td colspan="4"><p>&nbsp;</p></td>
</tr>
<tr>
<td><p>&nbsp;</p></td>
<td><p>&nbsp;</p></td>
<td><p><strong>Paso</strong></p></td>
<td><p><strong>Acci&#243;n</strong></p></td>
<td><p>&nbsp;</p></td>
</tr>
<tr>
<td><p>&nbsp;</p></td>
<td><p>&nbsp;</p></td>
<td><p><strong>1</strong></p></td>
<td><p>Correo no registrado</p></td>
<td><p>&nbsp;</p></td>
</tr>
<tr>
<td><p>&nbsp;</p></td>
<td><p>&nbsp;</p></td>
<td><p><strong>2</strong></p></td>
<td><p>El sistema muestra mensaje de error</p></td>
<td><p>&nbsp;</p></td>
</tr>
<tr>
<td><p><strong>Actores</strong></p></td>
<td colspan="4"><p>Usuario</p></td>
</tr>
<tr>
<td><p><strong>Comentarios</strong></p></td>
<td colspan="4"><p>&nbsp;</p></td>
</tr>
</table>







<table>
<tr>
<td><p>&nbsp;</p></td>
<td colspan="2"><p><strong>Caso de Uso N&#176; 5</strong></p></td>
<td colspan="2"><p>&nbsp;</p></td>
</tr>
<tr>
<td><p><strong>Nombre</strong></p></td>
<td colspan="4"><p>Consultas y/o Reportes (PDF y Exel)</p></td>
</tr>
<tr>
<td><p><strong>Descripci&#243;n</strong></p></td>
<td colspan="4"><p>Permite al usuario consultar y ver los reportes que ha generado.</p><p>&nbsp;</p></td>
</tr>
<tr>
<td><p><strong>Prioridad</strong></p></td>
<td colspan="4"><p>Baja</p></td>
</tr>
<tr>
<td><p><strong>Precondici&#243;n</strong></p></td>
<td colspan="4"><p>Debe haber reporte generados con anterioridad para su visualizaci&#243;n</p></td>
</tr>
<tr>
<td><p><strong>Secuencia normal</strong></p></td>
<td><p><strong>Paso</strong></p></td>
<td colspan="2"><p><strong>Acci&#243;n</strong></p></td>
<td><p><strong>Sistema</strong></p></td>
</tr>
<tr>
<td><p>&nbsp;</p></td>
<td><p><strong>1</strong></p></td>
<td colspan="2"><p>El usuario ingresa a la consulta de sus datos registrados</p></td>
<td><p>Genera gr&#225;ficos de acuerdo a los datos recopilados hasta el momento</p></td>
</tr>
<tr>
<td><p>&nbsp;</p></td>
<td><p><strong>2</strong></p></td>
<td colspan="2"><p>&nbsp;</p></td>
<td><p>Guarda y Muestra sus h&#225;bitos de consumo</p></td>
</tr>
<tr>
<td><p>&nbsp;</p></td>
<td><p><strong>3</strong></p></td>
<td colspan="2"><p>&nbsp;</p></td>
<td><p>Genera predicciones para mejor administraci&#243;n de dispositivos</p></td>
</tr>
<tr>
<td><p>&nbsp;</p></td>
<td><p><strong>4</strong></p></td>
<td colspan="2"><p>&nbsp;</p></td>
<td><p>&nbsp;</p></td>
</tr>
</table>


<table>
<tr>
<td><p><strong>Postcondici&#243;n</strong></p></td>
<td colspan="4"><p> Registrar los dispositivos de antemano.</p></td>
</tr>
<tr>
<td><p>&nbsp;</p><p><strong>Excepciones (flujo alterno)</strong></p></td>
<td colspan="4"><p>&nbsp;</p></td>
</tr>
<tr>
<td><p>&nbsp;</p></td>
<td><p>&nbsp;</p></td>
<td><p><strong>Paso</strong></p></td>
<td><p><strong>Acci&#243;n</strong></p></td>
<td><p>&nbsp;</p></td>
</tr>
<tr>
<td><p>&nbsp;</p></td>
<td><p>&nbsp;</p></td>
<td><p><strong>1</strong></p></td>
<td><p>Correo no registrado</p></td>
<td><p>&nbsp;</p></td>
</tr>
<tr>
<td><p>&nbsp;</p></td>
<td><p>&nbsp;</p></td>
<td><p><strong>2</strong></p></td>
<td><p>El sistema muestra mensaje de error</p></td>
<td><p>&nbsp;</p></td>
</tr>
<tr>
<td><p><strong>Actores</strong></p></td>
<td colspan="4"><p>Usuario</p></td>
</tr>
<tr>
<td><p><strong>Comentarios</strong></p></td>
<td colspan="4"><p>&nbsp;</p></td>
</tr>
</table>



# Anexo de actualización 2026: estado de requisitos

Este anexo conserva los requisitos y casos de uso del SRS original, pero establece cómo deben interpretarse frente al estado verificable del repositorio PT\_HS. Un requisito histórico puede seguir siendo válido como objetivo, aunque su implementación o prueba todavía no esté cerrada.

<table>
<tr>
<td><p><strong>&#193;rea del SRS original</strong></p></td>
<td><p><strong>Estado frente a PT_HS</strong></p></td>
<td><p><strong>Tratamiento documental</strong></p></td>
</tr>
<tr>
<td><p>Autenticaci&#243;n, sesiones, perfiles y roles</p></td>
<td><p>Hay m&#243;dulos y rutas de autenticaci&#243;n en el monorepo; la revisi&#243;n de c&#243;digo no prueba la aceptaci&#243;n en despliegue ni todos los roles.</p></td>
<td><p>Se conserva; verificar registro, verificaci&#243;n, login, recuperaci&#243;n, refresh, logout, CSRF y permisos en la misma versi&#243;n.</p></td>
</tr>
<tr>
<td><p>Hogares, miembros, vacaciones y metas</p></td>
<td><p>Hay m&#243;dulos de API, persistencia y pantallas para hogares y metas; no hay evidencia de aceptaci&#243;n completa por rol en este anexo.</p></td>
<td><p>Se conserva; probar Owner, Guest y Admin, incluyendo cambio de hogar y aislamiento de datos.</p></td>
</tr>
<tr>
<td><p>Dispositivos y telemetr&#237;a</p></td>
<td><p>El c&#243;digo define asociaci&#243;n por deviceCode, contrato MQTT y deduplicaci&#243;n por mqttMessageId. La revisi&#243;n est&#225;tica no certifica el flujo f&#237;sico del tag final.</p></td>
<td><p>El firmware maneja un c&#243;digo l&#243;gico activo por placa. <code>set_measurement</code> pausa la suma al total y conserva telemetr&#237;a de caudal/pulsos para vigilar fugas; no apaga la placa, el sensor ni MQTT. Adjuntar prueba f&#237;sica y ACL del entorno.</p></td>
</tr>
<tr>
<td><p>WebSockets / tiempo real</p></td>
<td><p>El cliente revisado actualiza las vistas principales mediante polling HTTP nominal de cinco segundos; WebSockets no se verific&#243;.</p></td>
<td><p>Describirlo como actualizaci&#243;n peri&#243;dica, sin prometer tiempo real estricto ni push.</p></td>
</tr>
<tr>
<td><p>AWS, Firebase, Redis y nube</p></td>
<td><p>AWS, FCM y Redis/Bull no se acreditan como servicios activos del corte integrado revisado.</p></td>
<td><p>Se conservan como alternativas o antecedentes, no como dependencias desplegadas verificadas.</p></td>
</tr>
<tr>
<td><p>MQTT seguro de producci&#243;n</p></td><td><p>El firmware contiene un perfil Flespi/TLS; la revisi&#243;n del repositorio no demuestra que el entorno externo actual acepte el token ni aplique la ACL esperada.</p></td><td><p>Local: Mosquitto para desarrollo. Externo: documentar conexi&#243;n, ACL efectiva y prueba telemetry/status/commands sin exponer tokens.</p></td>
</tr>
<tr>
<td><p>Calibraci&#243;n y exactitud metrol&#243;gica</p></td>
<td><p>Pendiente de ensayo con volumen conocido.</p></td>
<td><p>No se elimina el requisito; se marca como criterio de aceptaci&#243;n abierto.</p></td>
</tr>
<tr>
<td><p>Reportes PDF/Excel y notificaciones</p></td>
<td><p>El c&#243;digo contempla reportes y el proveedor Brevo; un resultado HTTP aceptado no acredita entrega real, y el c&#243;digo est&#225;tico no demuestra el flujo de alerta en producci&#243;n.</p></td>
<td><p>Probar descargas PDF/Excel y recepci&#243;n de correo en el entorno/versi&#243;n de entrega. Validar separadamente disparo, consulta y atenci&#243;n de alertas.</p></td>
</tr>
<tr>
<td><p>Seguridad, privacidad y RLS</p></td>
<td><p>Hay controles de sesi&#243;n, CSRF, permisos y modelos de privacidad en el c&#243;digo; la revisi&#243;n est&#225;tica no demuestra hardening productivo, 2FA ni SLA.</p></td>
<td><p>Separar requisitos de dise&#241;o de verificaciones operativas. Medir disponibilidad, recuperaci&#243;n, privacidad y seguridad antes de declarar aceptaci&#243;n.</p></td>
</tr>
</table>


### Requisitos originales cuyo estado no se debe sobreinterpretar

| Área | Estado en el corte de código revisado | Tratamiento para la entrega |
|---|---|---|
| Clasificación del consumo por actividad | No se demuestra clasificación automática por baño, cocina u otro punto a partir de una lectura agregada. | Mantener como requisito pendiente. Requiere sensores diferenciados, identificación de puntos de medición u otro método validado. |
| Predicción y recomendaciones | La existencia de pantallas o endpoints no prueba el modelo predictivo descrito en el SRS ni la personalización basada en datos. | Conservar la predicción como requisito no verificado; documentar el origen de datos y el método antes de afirmar que está implementada. |
| Cliente Android y BLE | El repositorio contiene una aplicación Expo/React Native que carga el cliente web en WebView y un puente BLE; Expo Go no incluye el módulo BLE nativo. | Para aprovisionar por BLE se requiere una compilación nativa compatible. Añadir prueba en dispositivo físico sobre el commit de entrega. |
| Calibración y exactitud metrológica | Pendiente de ensayo con volumen conocido. | Registrar montaje, volumen, pulsos, error y calibración en una prueba reproducible. |
| Disponibilidad, failover y recuperación | Los objetivos de 99 % de disponibilidad y RTO menor a 15 minutos provienen del SRS académico y no están medidos en esta entrega. | No presentarlos como niveles alcanzados; adjuntar medición y ensayo de recuperación si se mantienen como criterios de aceptación. |

## Anexo de trazabilidad técnica

Código y pruebas: PT\_HS/BK\_HS, PT\_HS/FT\_HS/frontend, PT\_HS/firmware y PT\_HS/BD\_HS.

API: grupos /auth, /homes, /devices, /consumption, /users, /tariffs, /alerts, /goals, /vacation, /roles, /support, /audit, /privacy, /reports y /recommendations.

Base de datos: PostgreSQL 16, Liquibase, 245 changesets y 58 tablas de aplicación según el corte histórico 2026-09-26. No usar esas cantidades como inventario del tag final; volver a contarlas al congelar la versión.

Verificación histórica: el corte 2026-09-26 registró 174 pruebas unitarias backend, build/lint/typecheck frontend y una prueba física en `docs/estado-verificado-2026-09-26.md`. Esta evidencia no acredita la versión final ni sustituye las ejecuciones de `05-test-documentation/`.

Control de identidad institucional: los materiales disponibles mencionan la ficha 3145555, el programa ADSO 228118 y el código de reporte 2678382. Confirmar qué identificador corresponde a cada campo de la entrega; no sustituirlos entre sí.
