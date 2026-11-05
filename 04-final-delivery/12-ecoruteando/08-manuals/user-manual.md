# Manual de Usuario — EcoRuteando

> **Plataforma de Movilidad Urbana Sostenible para Neiva, Colombia**

| Campo | Detalle |
|-------|---------|
| **Versión del documento** | 1.0 |
| **Fecha de elaboración** | 10 de octubre de 2026 |
| **Proyecto** | EcoRuteando |
| **Plataformas** | Web (React) · Móvil (Expo/React Native) |
| **Idiomas disponibles** | Español · English · Português · Français |

---

## Índice

1. [Introducción](#1-introducción)
2. [Objetivos del Manual](#2-objetivos-del-manual)
3. [Público Objetivo](#3-público-objetivo)
4. [Requisitos del Sistema](#4-requisitos-del-sistema)
5. [Acceso a la Plataforma](#5-acceso-a-la-plataforma)
6. [Descripción de la Interfaz](#6-descripción-de-la-interfaz)
7. [Módulos y Funcionalidades](#7-módulos-y-funcionalidades)
8. [Procesos Paso a Paso](#8-procesos-paso-a-paso)
9. [Mensajes y Errores Comunes](#9-mensajes-y-errores-comunes)
10. [Recomendaciones de Uso y Seguridad](#10-recomendaciones-de-uso-y-seguridad)
11. [Contacto y Soporte](#11-contacto-y-soporte)
12. [Enlaces de Interés](#12-enlaces-de-interés)
13. [Glosario](#13-glosario)

---

## 1. Introducción

**EcoRuteando** es una plataforma digital diseñada para transformar la movilidad urbana en Neiva, Colombia. El sistema permite a los ciudadanos planificar rutas ecológicas, estimar el impacto ambiental de sus trayectos, reportar obstáculos en las vías, y contribuir a una comunidad más sostenible.

### 1.1 ¿Qué es EcoRuteando?

EcoRuteando es una aplicación web y móvil que integra:

- **Planificación de rutas ecológicas** con estimación de tiempo y emisiones de CO₂.
- **Gestión de trayectos** con historial, estadísticas personales y exportación de datos.
- **Participación ciudadana** mediante reportes de obstáculos y calificación de rutas.
- **Información climática** en tiempo real para tomar mejores decisiones de movilidad.
- **Segmentación de transporte** disponible: bicicleta, transporte público, mixto, a pie y carro.

### 1.2 Contexto

Neiva, capital del Huila, enfrenta desafíos de movilidad urbana que afectan la calidad de vida de sus habitantes. EcoRuteando busca incentivar el uso de modos de transporte sostenibles, reducir las emisiones de carbono y fortalecer la participación comunitaria en la mejora de la infraestructura vial.

### 1.3 Plataformas Disponibles

| Plataforma | Tecnología | Estado |
|------------|-----------|--------|
| **Aplicación Web** | React + Vite | ✅ Disponible |
| **Aplicación Móvil** | Expo / React Native | ✅ Disponible |
| **API Backend** | .NET 9 | ✅ Activo |

> 📹 *[Espacio para video: presentación general de EcoRuteando]*

> 📸 *[Captura de pantalla: página principal de EcoRuteando]*

---

## 2. Objetivos del Manual

Este manual tiene como propósito:

1. **Orientar** al usuario en el acceso y uso de la plataforma EcoRuteando.
2. **Explicar** de manera clara y sencilla cada funcionalidad disponible.
3. **Resolver** dudas frecuentes y guiar ante errores comunes.
4. **Establecer** las mejores prácticas de seguridad y uso responsable.
5. **Documentar** el estado actual de cada funcionalidad (disponible / no disponible).

### Convenciones de estado utilizadas

| Icono | Significado |
|-------|-------------|
| ✅ | Funcionalidad disponible y operativa |
| 🚧 | Funcionalidad en desarrollo o parcialmente disponible |
| ❌ | Funcionalidad no disponible actualmente |
| 💡 | Consejo o recomendación |
| ⚠️ | Advertencia importante |

---

## 3. Público Objetivo

Este manual está dirigido a:

| Perfil | Descripción |
|--------|-------------|
| **Ciudadano de Neiva** | Cualquier persona que desee planificar rutas sostenibles |
| **Usuario registrado** | Personas con cuenta que desean acceder a todas las funciones |
| **Administrador** | Personal designado para gestionar reportes, POIs y estadísticas |
| **Desarrolladores** | Técnicos que necesiten integrar con la API o contribuir al proyecto |

No se requieren conocimientos técnicos para usar la plataforma.

---

## 4. Requisitos del Sistema

### 4.1 Aplicación Web

| Requisito | Mínimo | Recomendado |
|-----------|--------|-------------|
| **Navegador** | Chrome 90+, Firefox 88+, Safari 14+, Edge 90+ | Última versión |
| **Conexión a Internet** | 1 Mbps | 5 Mbps o superior |
| **Resolución de pantalla** | 1024 × 768 px | 1920 × 1080 px |
| **JavaScript** | Habilitado | Habilitado |
| **Almacenamiento** | 50 MB libres | 100 MB o más |

### 4.2 Aplicación Móvil

| Requisito | Android | iOS |
|-----------|---------|-----|
| **Versión mínima** | Android 8.0 (API 26) | iOS 14.0 |
| **Espacio libre** | 100 MB | 100 MB |
| **Permisos requeridos** | Ubicación, Notificaciones | Ubicación, Notificaciones |
| **Conexión** | WiFi o datos móviles | WiFi o datos móviles |

### 4.3 Cuenta de Correo Electrónico

Es necesario tener acceso a un correo electrónico válido para:
- La verificación de cuenta durante el registro.
- La recuperación de contraseña.
- El envío de alertas climáticas y notificaciones.

> ⚠️ **Importante**: Sin verificar tu correo electrónico, no podrás iniciar sesión en la plataforma.

---

## 5. Acceso a la Plataforma

### 5.1 Registro de Nuevo Usuario

> 📸 *[Captura: formulario de registro]*

**Paso 1:** Accede a la página principal y selecciona **"Registrarse"** o navega a `/register`.

**Paso 2:** Completa el formulario de registro con la siguiente información:

| Campo | Requisito |
|-------|-----------|
| **Nombre** | Obligatorio, mínimo 2 caracteres |
| **Apellido** | Obligatorio, mínimo 2 caracteres |
| **Correo electrónico** | Obligatorio, formato válido, debe ser único |
| **Contraseña** | Obligatorio, mínimo 8 caracteres, debe incluir mayúscula, número y carácter especial |
| **Confirmar contraseña** | Obligatorio, debe coincidir con la contraseña |

**Paso 3:** Lee y acepta los **Términos y Condiciones** haciendo clic en la casilla correspondiente.

**Paso 4:** Haz clic en **"Crear cuenta"**.

**Paso 5:** Revisa tu correo electrónico. Recibirás un código de verificación de 6 dígitos.

**Paso 6:** Ingresa el código en la pantalla de verificación.

**Paso 7:** Una vez verificado, tu cuenta quedará activa. Ya puedes iniciar sesión.

> 💡 **Consejo**: Si no recibes el correo de verificación, revisa la carpeta de spam o correo no deseado.

### 5.2 Inicio de Sesión

> 📸 *[Captura: pantalla de login]*

**Paso 1:** Accede a `/login` o haz clic en **"Iniciar sesión"**.

**Paso 2:** Ingresa tu correo electrónico y contraseña.

**Paso 3:** Haz clic en **"Iniciar sesión"**.

**Opciones alternativas de inicio de sesión:**

| Método | Descripción | Estado |
|--------|-------------|--------|
| **Correo y contraseña** | Método estándar | ✅ Disponible |
| **Google (OAuth)** | Iniciar sesión con tu cuenta de Google | ✅ Disponible |
| **Modo invitado** | Explorar la plataforma sin cuenta | ✅ Disponible |

> 💡 **Consejo**: Si tu cuenta tiene activada la verificación en dos pasos (2FA), recibirás un código adicional por correo electrónico.

### 5.3 Recuperación de Contraseña

> 📸 *[Captura: flujo de recuperación de contraseña]*

**Paso 1:** En la pantalla de inicio de sesión, haz clic en **"¿Olvidaste tu contraseña?"**.

**Paso 2:** Ingresa tu correo electrónico registrado.

**Paso 3:** Haz clic en **"Enviar código"**.

**Paso 4:** Revisa tu correo. Recibirás un código de recuperación.

**Paso 5:** Ingresa el código de 6 dígitos en la pantalla de verificación.

**Paso 6:** Crea una nueva contraseña que cumpla con los requisitos de seguridad.

**Paso 7:** Confirma la nueva contraseña y haz clic en **"Restablecer"**.

**Paso 8:** Inicia sesión con tu nueva contraseña.

> ⚠️ **Importante**: Los códigos de recuperación tienen un tiempo limitado de vigencia. Si expira, solicita uno nuevo.

### 5.4 Modo Invitado

El modo invitado permite explorar la plataforma sin necesidad de crear una cuenta. Las funciones disponibles para invitados son:

| Función | Estado en modo invitado |
|---------|------------------------|
| Planificar rutas | ✅ Disponible |
| Ver el mapa | ✅ Disponible |
| Estimar tiempo y CO₂ | ✅ Disponible |
| Ver puntos de interés | ✅ Disponible |
| Guardar rutas favoritas | ❌ Requiere cuenta |
| Ver historial de trayectos | ❌ Requiere cuenta |
| Calificar rutas | ❌ Requiere cuenta |
| Reportar obstáculos | ❌ Requiere cuenta |
| Ver estadísticas personales | ❌ Requiere cuenta |

---

## 6. Descripción de la Interfaz

### 6.1 Aplicación Web — Estructura General

> 📸 *[Captura: dashboard del usuario]*

La aplicación web se organiza en las siguientes áreas principales:

#### Navegación Principal (Barra superior)

| Elemento | Función |
|----------|---------|
| **Logo EcoRuteando** | Regresa a la página principal |
| **Inicio** | Acceso al dashboard del usuario |
| **Planificar ruta** | Abre el planificador de rutas con mapa |
| **Mis rutas** | Gestión de rutas guardadas |
| **Historial** | Historial de trayectos realizados |
| **Favoritas** | Rutas marcadas como favoritas |
| **Estadísticas** | Estadísticas personales de movilidad |
| **Reportar** | Formulario para reportar obstáculos |
| **Alertas** | Alertas climáticas activas |
| **Perfil** | Configuración de la cuenta |
| **Idioma** | Selector de idioma (ES/EN/PT/FR) |
| **Modo oscuro** | Alternar tema claro/oscuro |
| **Cerrar sesión** | Termina la sesión actual |

#### Panel de Administración

Accesible solo para usuarios con rol **administrador**:

| Sección | Función | Estado |
|---------|---------|--------|
| **Panel general** | Resumen de actividad | ✅ |
| **Estadísticas de impacto** | Métricas de sostenibilidad | ✅ |
| **Reportes ciudadanos** | Gestión de obstáculos reportados | ✅ |
| **Exportar datos** | Descarga de historial y estadísticas | ✅ |
| **Gestionar POIs** | Administración de puntos de interés | ✅ |
| **Usuarios** | Gestión de usuarios | 🚧 Próximamente |
| **Soporte** | Tickets de soporte | 🚧 Próximamente |
| **Auditoría** | Logs de auditoría | 🚧 Próximamente |
| **Configuración** | Ajustes del sistema | 🚧 Próximamente |

### 6.2 Aplicación Móvil — Estructura General

> 📸 *[Captura: pantallas principales de la app móvil]*

La aplicación móvil utiliza navegación por pestañas (tabs) en la parte inferior:

#### Pestañas Visibles

| Pestaña | Icono | Función |
|---------|-------|---------|
| **Inicio** | 🏠 | Dashboard y acceso rápido a funciones |
| **Ruta** | 🗺️ | Planificador de rutas con mapa |
| **Historial** | 📋 | Historial de trayectos |
| **Favoritas** | ⭐ | Rutas favoritas |
| **Perfil** | 👤 | Configuración de la cuenta |

#### Pantallas de Acceso Rápido (desde Inicio)

| Pantalla | Acceso | Función |
|----------|--------|---------|
| **Mis rutas** | Tarjeta en Home | Gestión de rutas guardadas |
| **Alertas** | Tarjeta en Home | Alertas climáticas |
| **Estadísticas** | Desde Perfil | Estadísticas personales |
| **Reportar** | Desde el mapa | Reporte de obstáculos |

#### Pantallas de Autenticación

| Pantalla | Función |
|----------|---------|
| **Bienvenida** | Landing page con selector de idioma |
| **Iniciar sesión** | Formulario de acceso |
| **Registrarse** | Formulario de registro |
| **Recuperar contraseña** | Flujo de recuperación en 3 pasos |
| **Verificar código** | Ingreso de código de verificación |

> ⚠️ **Nota para usuarios invitados**: Al iniciar en modo invitado, solo se muestran las pestañas de Inicio y Ruta. Las demás pestañas se ocultan.

---

## 7. Módulos y Funcionalidades

### 7.1 Módulo de Autenticación y Cuenta

| Funcionalidad | Descripción | Estado |
|---------------|-------------|--------|
| Registro de usuario | Crear cuenta con verificación por correo | ✅ |
| Inicio de sesión | Acceso con correo/contraseña | ✅ |
| Inicio con Google | Autenticación OAuth con Google | ✅ |
| Verificación de correo | Código de 6 dígitos al registrarse | ✅ |
| Recuperación de contraseña | Código de verificación + nueva contraseña | ✅ |
| Cambio de contraseña | Desde el perfil de usuario | ✅ |
| Verificación en dos pasos (2FA) | Código adicional por correo | ✅ |
| Gestión de sesiones | Ver y cerrar sesiones activas | ✅ |
| Edición de perfil | Nombre, apellido, correo, teléfono | ✅ |
| Eliminación de cuenta | Borrado definitivo de la cuenta y datos | ✅ |
| Modo invitado | Exploración sin cuenta | ✅ |
| Aceptación de términos | Modal de términos y condiciones | ✅ |

### 7.2 Módulo de Planificación de Rutas

| Funcionalidad | Descripción | Estado |
|---------------|-------------|--------|
| Planificador con mapa | Interfaz de mapa para seleccionar origen y destino | ✅ |
| Búsqueda de ubicaciones | Buscar direcciones o lugares por nombre | ✅ |
| Estimación de tiempo | Tiempo estimado según el medio de transporte | ✅ |
| Estimación de CO₂ | Emisiones estimadas del trayecto | ✅ |
| Alertas climáticas en ruta | Condiciones del clima a lo largo de la ruta | ✅ |
| Visualización ecológica | Resaltado de rutas con menor impacto ambiental | ✅ |
| Búsqueda de puntos cercanos | Lugares de interés cerca de la ubicación actual | ✅ |
| Paradas intermedias | Agregar puntos de parada en la ruta | ✅ |

**Medios de transporte disponibles:**

| Transporte | Icono | Estado |
|------------|-------|--------|
| Bicicleta | 🚲 | ✅ |
| Transporte público | 🚌 | ✅ |
| Mixto (varios modos) | 🔀 | ✅ |
| A pie | 🚶 | ✅ |
| Carro | 🚗 | ✅ |

### 7.3 Módulo de Gestión de Rutas

| Funcionalidad | Descripción | Estado |
|---------------|-------------|--------|
| Guardar rutas | Almacenar rutas planificadas | ✅ |
| Ver rutas guardadas | Listado de rutas del usuario | ✅ |
| Editar rutas | Modificar nombre o detalles de una ruta | ✅ |
| Eliminar rutas | Borrar rutas guardadas | ✅ |
| Rutas favoritas | Marcar rutas como favoritas con etiqueta | ✅ |
| Gestión de favoritas | Ver, agregar y eliminar favoritas | ✅ |
| Compartir rutas | Generar enlace para compartir recorridos | ✅ |

### 7.4 Módulo de Historial de Trayectos

| Funcionalidad | Descripción | Estado |
|---------------|-------------|--------|
| Registro de trayectos | Guardar cada trayecto realizado | ✅ |
| Ver historial | Listado cronológico de trayectos | ✅ |
| Detalle de trayecto | Información completa de un trayecto | ✅ |
| Iniciar trayecto | Comenzar un nuevo registro | ✅ |
| Completar trayecto | Finalizar y guardar el trayecto | ✅ |
| Interrumpir trayecto | Cancelar un trayecto en curso | ✅ |
| Exportar historial | Descarga en formato CSV/JSON | ✅ |
| Historial de direcciones | Búsquedas de ubicaciones recientes | ✅ |

### 7.5 Módulo de Estadísticas

| Funcionalidad | Descripción | Estado |
|---------------|-------------|--------|
| Estadísticas personales | Métricas de movilidad del usuario | ✅ |
| Estadísticas de impacto | Datos agregados de sostenibilidad | ✅ |
| Desglose por transporte | Estadísticas por medio de transporte | ✅ |
| Estadísticas mensuales | Evolución temporal de trayectos | ✅ |
| Exportar estadísticas | Descarga de datos estadísticos | ✅ |
| Portal de estadísticas (admin) | Vista global para administradores | ✅ |

### 7.6 Módulo de Reporte de Obstáculos

| Funcionalidad | Descripción | Estado |
|---------------|-------------|--------|
| Reportar obstáculo | Formulario con tipo, descripción y ubicación | ✅ |
| Adjuntar foto | Carga de imagen del obstáculo | ✅ |
| Ver mis reportes | Listado de reportes del usuario | ✅ |
| Estados del reporte | Pendiente → En validación → Validado/Rechazado | ✅ |
| Validación comunitaria | Votos de la comunidad | ✅ |
| Validación admin | Gestión de reportes por administrador | ✅ |

### 7.7 Módulo de Calificación de Rutas

| Funcionalidad | Descripción | Estado |
|---------------|-------------|--------|
| Calificar ruta | Asignar estrellas (1-5) a una ruta | ✅ |
| Ver calificaciones | Ver promedio y cantidad de evaluaciones | ✅ |
| Mis calificaciones | Ver las calificaciones del usuario | ✅ |

### 7.8 Módulo de Puntos de Interés (POIs)

| Funcionalidad | Descripción | Estado |
|---------------|-------------|--------|
| Ver POIs en el mapa | Visualización de puntos de interés | ✅ |
| Buscar POIs cercanos | Lugares cerca de una ubicación | ✅ |
| Gestionar POIs (admin) | CRUD de puntos de interés | ✅ |
| Categorías de POI | Diferentes tipos de lugares | ✅ |

### 7.9 Módulo de Alertas Climáticas

| Funcionalidad | Descripción | Estado |
|---------------|-------------|--------|
| Alertas climáticas | Notificaciones sobre condiciones del clima | ✅ |
| Clima en ruta | Condiciones del tiempo a lo largo de la ruta | ✅ |
| Clima actual | Consulta del clima actual en Neiva | ✅ |
| Notificaciones push | Alertas en dispositivo móvil | ✅ |

### 7.10 Módulo de Notificaciones

| Funcionalidad | Descripción | Estado |
|---------------|-------------|--------|
| Notificaciones push | Alertas en el dispositivo móvil | ✅ |
| Notificaciones por correo | Avisos al correo electrónico | ✅ |
| Registro de dispositivos | Vinculación de dispositivos para push | ✅ |
| Gestión de dispositivos | Ver y remover dispositivos vinculados | ✅ |

### 7.11 Módulo de Exportación de Datos

| Funcionalidad | Descripción | Estado |
|---------------|-------------|--------|
| Exportar historial de trayectos | Descarga en formato CSV | ✅ |
| Exportar estadísticas | Descarga de datos estadísticos | ✅ |
| Exportación admin | Exportación masiva para administradores | ✅ |

### 7.12 Funcionalidades No Disponibles

| Funcionalidad | Estado | Notas |
|---------------|--------|-------|
| Gestión de usuarios (admin) | 🚧 En desarrollo | Sección placeholder |
| Soporte / tickets (admin) | 🚧 En desarrollo | Sección placeholder |
| Auditoría (admin) | 🚧 En desarrollo | Sección placeholder |
| Configuración del sistema (admin) | 🚧 En desarrollo | Sección placeholder |
| Tracking en tiempo real (móvil) | 🚧 En desarrollo | Pantalla placeholder |
| Configuración avanzada (móvil) | 🚧 En desarrollo | Pantalla placeholder |

---

## 8. Procesos Paso a Paso

### 8.1 Planificar una Ruta Ecológica (Web)

> 📹 *[Espacio para video: tutorial de planificación de rutas]*
> 📸 *[Captura: planificador de rutas con mapa]*

**Paso 1:** Inicia sesión en la plataforma.

**Paso 2:** Navega a **"Planificar ruta"** en el menú principal.

**Paso 3:** En el mapa, haz clic en **"Origen"** y selecciona tu punto de partida. Puedes:
- Hacer clic directamente en el mapa.
- Escribir una dirección en el buscador.
- Usar tu ubicación actual.

**Paso 4:** Haz clic en **"Destino"** y selecciona tu punto de llegada con el mismo método.

**Paso 5:** Selecciona el medio de transporte deseado (bicicleta, transporte público, mixto, a pie o carro).

**Paso 6:** La plataforma mostrará:
- La ruta trazada en el mapa.
- Tiempo estimado del trayecto.
- Estimación de emisiones de CO₂.
- Condiciones climáticas a lo largo de la ruta.

**Paso 7 (Opcional):** Haz clic en **"Agregar parada"** para incluir puntos intermedios en tu ruta.

**Paso 8:** Para guardar la ruta, haz clic en **"Guardar ruta"** e ingresa un nombre descriptivo.

> 💡 **Consejo**: Compara las estimaciones de CO₂ entre diferentes medios de transporte para elegir la opción más sostenible.

### 8.2 Realizar un Trayecto y Ver el Historial

> 📸 *[Captura: historial de trayectos]*

**Paso 1:** Planifica tu ruta como se describe en la sección 8.1.

**Paso 2:** Haz clic en **"Iniciar trayecto"** para comenzar el registro.

**Paso 3:** Durante el trayecto, la plataforma registra tu recorrido.

**Paso 4:** Al llegar a tu destino, haz clic en **"Completar trayecto"**.

**Paso 5:** El trayecto quedará guardado en tu historial.

**Paso 6:** Para ver tus trayectos, navega a **"Historial"** en el menú.

**Paso 7:** Haz clic en cualquier trayecto para ver el detalle completo.

**Paso 8 (Opcional):** Para exportar tu historial, haz clic en **"Exportar"** y selecciona el formato (CSV o JSON).

### 8.3 Reportar un Obstáculo

> 📸 *[Captura: formulario de reporte de obstáculos]*

**Paso 1:** Inicia sesión en la plataforma.

**Paso 2:** Navega a **"Reportar"** en el menú.

**Paso 3:** Selecciona la ubicación del obstáculo en el mapa o escribe la dirección.

**Paso 4:** Selecciona el tipo de obstáculo (hueco, señal dañada, vía cerrada, etc.).

**Paso 5:** Escribe una descripción clara del problema.

**Paso 6 (Opcional):** Adjunta una fotografía del obstáculo.

**Paso 7:** Haz clic en **"Enviar reporte"**.

**Paso 8:** Tu reporte quedará en estado **"Pendiente"** hasta que sea validado.

> 💡 **Consejo**: Mientras más detallada sea tu descripción y clara la foto, más fácil será para la comunidad y los administradores validar el reporte.

### 8.4 Calificar una Ruta

> 📸 *[Captura: sistema de calificación]*

**Paso 1:** Navega a **"Mis rutas"** o a una ruta compartida.

**Paso 2:** Selecciona la ruta que deseas calificar.

**Paso 3:** Haz clic en las estrellas para asignar una calificación del 1 al 5.

**Paso 4:** Tu calificación se guardará automáticamente.

> 💡 **Consejo**: Calificar las rutas ayuda a otros usuarios a elegir las mejores opciones de movilidad.

### 8.5 Gestionar el Perfil de Usuario

> 📸 *[Captura: página de perfil]*

**Paso 1:** Navega a **"Perfil"** en el menú.

**Paso 2:** Para editar tu información, haz clic en **"Editar perfil"**.

**Paso 3:** Modifica los campos que desees cambiar:
- Nombre
- Apellido
- Correo electrónico
- Número de teléfono

**Paso 4:** Para cambiar tu contraseña, usa la sección **"Cambiar contraseña"**:
- Ingresa tu contraseña actual.
- Ingresa la nueva contraseña.
- Confirma la nueva contraseña.

**Paso 5:** Para activar la verificación en dos pasos (2FA), usa la sección **"Seguridad"**.

**Paso 6:** Para ver y cerrar sesiones activas, usa la sección **"Sesiones activas"**.

**Paso 7:** Haz clic en **"Guardar cambios"** para aplicar las modificaciones.

### 8.6 Eliminar la Cuenta

> ⚠️ **Advertencia**: La eliminación de la cuenta es **permanente e irreversible**. Se borrará toda tu información personal, historial de trayectos y rutas guardadas.

**Paso 1:** Navega a **"Perfil"** en el menú.

**Paso 2:** Desplázate hasta la sección **"Eliminar cuenta"**.

**Paso 3:** Haz clic en **"Eliminar mi cuenta"**.

**Paso 4:** Se mostrará un modal de confirmación advirtiéndote sobre las consecuencias.

**Paso 5:** Confirma la eliminación.

**Paso 6:** Tu cuenta será borrada y cerrarás sesión automáticamente.

### 8.7 Compartir un Recorrido

> 📸 *[Captura: funcionalidad de compartir]*

**Paso 1:** Navega a la ruta o trayecto que deseas compartir.

**Paso 2:** Haz clic en el botón **"Compartir"**.

**Paso 3:** Se generará un enlace único de la ruta.

**Paso 4:** Copia el enlace y compártelo por el medio que prefieras (WhatsApp, correo, redes sociales).

### 8.8 Cambiar el Idioma de la Plataforma

> 📸 *[Captura: selector de idioma]*

**Paso 1:** Localiza el selector de idioma en la barra superior (web) o en la pantalla de bienvenida (móvil).

**Paso 2:** Selecciona el idioma deseado:

| Código | Idioma |
|--------|--------|
| ES | Español (por defecto) |
| EN | English |
| PT | Português |
| FR | Français |

**Paso 3:** La interfaz se actualizará inmediatamente con las traducciones seleccionadas.

---

## 9. Mensajes y Errores Comunes

### 9.1 Errores de Autenticación

| Mensaje | Causa | Solución |
|---------|-------|----------|
| "Correo o contraseña incorrectos" | Credenciales inválidas | Verifica tu correo y contraseña. Usa "¿Olvidaste tu contraseña?" si es necesario. |
| "El correo ya está registrado" | Cuenta duplicada | Usa otro correo o inicia sesión con la cuenta existente. |
| "La verificación de correo es requerida" | Cuenta sin verificar | Revisa tu correo e ingresa el código de verificación. |
| "La sesión ha expirado" | Token JWT vencido | Inicia sesión nuevamente. |
| "No autorizado" | Credenciales inválidas o sesión cerrada | Verifica que estés autenticado correctamente. |

### 9.2 Errores de Registro

| Mensaje | Causa | Solución |
|---------|-------|----------|
| "La contraseña no cumple con la política de seguridad" | Contraseña débil | Usa al menos 8 caracteres con mayúscula, número y carácter especial. |
| "Las contraseñas no coinciden" | Confirmación incorrecta | Verifica que ambas contraseñas sean idénticas. |
| "Debes aceptar los términos y condiciones" | Términos no aceptados | Marca la casilla de aceptación antes de registrarte. |
| "El código de verificación es inválido" | Código incorrecto o expirado | Verifica el código recibido o solicita uno nuevo. |

### 9.3 Errores de Rutas y Trayectos

| Mensaje | Causa | Solución |
|---------|-------|----------|
| "El origen y el destino no pueden ser iguales" | Misma ubicación | Selecciona ubicaciones diferentes. |
| "No se pudo calcular la ruta" | Error del servicio de mapas | Verifica tu conexión e intenta nuevamente. |
| "La ruta ya existe" | Ruta duplicada | Usa un nombre diferente o edita la ruta existente. |
| "No hay trayectos registrados" | Historial vacío | Realiza al menos un trayecto para ver datos. |

### 9.4 Errores de Reportes

| Mensaje | Causa | Solución |
|---------|-------|----------|
| "El tipo de obstáculo es obligatorio" | Campo sin seleccionar | Selecciona un tipo de obstáculo válido. |
| "La descripción es obligatoria" | Descripción vacía | Escribe una descripción del obstáculo. |
| "La ubicación es obligatoria" | Sin ubicación | Selecciona la ubicación en el mapa. |
| "La foto no supera el tamaño máximo" | Imagen muy grande | Comprime la foto o usa una de menor resolución. |

### 9.5 Errores de Conexión

| Mensaje | Causa | Solución |
|---------|-------|----------|
| "Error de conexión con el servidor" | Servidor no disponible | Espera unos minutos e intenta nuevamente. |
| Página en blanco | Error de carga | Recarga la página (F5) o limpia la caché del navegador. |
| "No se pudo cargar el mapa" | API key o conexión | Verifica tu conexión a Internet. |

### 9.6 Errores Móviles

| Mensaje | Causa | Solución |
|---------|-------|----------|
| "Permiso de ubicación denegado" | GPS desactivado | Activa la ubicación en la configuración del dispositivo. |
| "No se pudieron registrar las notificaciones" | Permisos push desactivados | Activa las notificaciones para EcoRuteando. |
| "Error de red" | Sin conexión | Verifica tu conexión WiFi o datos móviles. |

> 💡 **Consejo**: Si experimentas un error persistente, intenta cerrar y volver a abrir la aplicación, o recarga la página web.

---

## 10. Recomendaciones de Uso y Seguridad

### 10.1 Seguridad de la Cuenta

| Recomendación | Descripción |
|---------------|-------------|
| 🔐 **Contraseña fuerte** | Usa al menos 8 caracteres con mayúsculas, minúsculas, números y caracteres especiales. |
| 🔄 **Contraseña única** | No uses la misma contraseña que en otros servicios. |
| ✉️ **Verifica tu correo** | Completa siempre la verificación de correo durante el registro. |
| 🛡️ **Activa 2FA** | Habilita la verificación en dos pasos para mayor seguridad. |
| 🚪 **Cierra sesión** | Cierra sesión al terminar de usar la plataforma, especialmente en equipos compartidos. |
| 👀 **Sesiones activas** | Revisa periódicamente tus sesiones activas y cierra las que no reconozcas. |
| 📧 **Cuidado con phishing** | EcoRuteando nunca te pedirá tu contraseña por correo o teléfono. |
| 💾 **Contraseñas seguras** | No anotes tus contraseñas en lugares visibles. |

### 10.2 Uso Responsable de la Plataforma

| Recomendación | Descripción |
|---------------|-------------|
| 🚲 **Prioriza lo sostenible** | Elige bicicleta, transporte público o caminata siempre que sea posible. |
| 📍 **Reporta con responsabilidad** | Reporta obstáculos reales con información precisa. |
| ⭐ **Califica con honestidad** | Tus calificaciones ayudan a otros usuarios. |
| 🤝 **Participa en la comunidad** | Valida reportes de otros ciudadanos y contribuye a la mejora de la red. |
| 📸 **Fotos claras** | Si adjuntas fotos en reportes, asegúrate de que sean nítidas y relevantes. |
| 🌍 **Cuida el medio ambiente** | Usa las estimaciones de CO₂ para tomar decisiones más sostenibles. |

### 10.3 Privacidad de Datos

| Aspecto | Descripción |
|---------|-------------|
| **Datos personales** | EcoRuteando almacena solo los datos necesarios para el funcionamiento del servicio. |
| **Ubicación** | La ubicación se usa únicamente para planificar rutas y no se comparte con terceros. |
| **Historial** | Tu historial de trayectos es privado y solo tú puedes verlo. |
| **Eliminación** | Puedes eliminar tu cuenta y todos tus datos en cualquier momento desde el perfil. |
| **Cumplimiento** | El manejo de datos cumple con la normativa de protección de datos vigente. |

### 10.4 Buenas Prácticas de Navegación

- Usa un navegador actualizado para mejor rendimiento y seguridad.
- Limpia la caché del navegador si experimentas problemas visuales.
- En móvil, mantén la aplicación actualizada a la última versión.
- Usa una conexión a Internet estable para funciones que requieren mapas.

---

## 11. Contacto y Soporte

### 11.1 Canales de Soporte

| Canal | Contacto | Disponibilidad |
|-------|----------|----------------|
| **Correo electrónico** | soporte@ecoruteando.com | Lunes a Viernes, 8:00 AM - 5:00 PM |
| **Reportar un bug** | GitHub Issues | 24/7 |
| **Preguntas generales** | GitHub Discussions | 24/7 |

### 11.2 Información del Proyecto

| Campo | Detalle |
|-------|---------|
| **Nombre del proyecto** | EcoRuteando |
| **Ubicación** | Neiva, Huila, Colombia |
| **Tipo de proyecto** | Plataforma de movilidad urbana sostenible |
| **Licencia** | Proyecto académico |

### 11.3 Al Presentar un Problema

Al reportar un error o problema, incluye la siguiente información:

1. **Descripción del problema**: Qué estabas intentando hacer.
2. **Pasos para reproducir**: Los pasos exactos que realizaste.
3. **Resultado esperado**: Qué esperabas que ocurriera.
4. **Resultado obtenido**: Qué ocurrió realmente.
5. **Captura de pantalla**: Si es posible, adjunta una imagen del error.
6. **Dispositivo y navegador**: Estás usando web o móvil, y en qué dispositivo.
7. **Mensaje de error**: Si apareció algún mensaje, inclúyelo textualmente.

> 📸 *[Captura: plantilla para reporte de problemas]*

---

## 12. Enlaces de Interés

### 12.1 Repositorios del Proyecto

| Repositorio | Descripción | Enlace |
|-------------|-------------|--------|
| **Frontend Web** | Aplicación React | [GitHub - EcoRuteando](https://github.com/daniel2004-lsd/EcoRuteando) |
| **Backend API** | API .NET 9 | [GitHub - EcoRuteandoBackend](https://github.com/daniel2004-lsd/EcoRuteandoBackend) |
| **Base de Datos** | Esquema Liquibase + PostgreSQL | [GitHub - EcoRuteandoDb](https://github.com/daniel2004-lsd/EcoRuteandoDb) |
| **App Móvil** | Aplicación Expo/React Native | [GitHub - Movil-EcoRuteando](https://github.com/daniel2004-lsd/Movil-EcoRuteando) |

### 12.2 Documentación del Proyecto

| Documento | Descripción |
|-----------|-------------|
| [Especificación de Casos de Uso](./documents/Especificación%20de%20casos%20de%20uso/) | 22 casos de uso documentados (CU01-CU22) |
| [Documento de Arquitectura](./documents/documento-arquitectura.md) | Arquitectura técnica del sistema |
| [Diagrama de Despliegue](./documents/diagrama_despliegue_ecoruteando.puml) | Diagrama de despliegue UML |
| [Web Documentación](./documents/web_documentacion/) | Documentación web interactiva |
| [Diagramas de Actividad](./documents/diagramas-actividad/) | Diagramas UML de actividades |

### 12.3 Videos y Tutoriales

> 📹 *[Espacio para video: Tutorial de registro y primeros pasos]*
>
> 📹 *[Espacio para video: Cómo planificar una ruta ecológica]*
>
> 📹 *[Espacio para video: Cómo reportar un obstáculo]*
>
> 📹 *[Espacio para video: Uso de la aplicación móvil]*
>
> 📹 *[Espacio para video: Panel de administración]*

### 12.4 Capturas de Pantalla

> 📸 *[Galería de capturas: Pantallas principales de la aplicación]*
>
> 📸 *[Galería de capturas: Aplicación móvil]*
>
> 📸 *[Galería de capturas: Panel de administración]*
>
> 📸 *[Galería de capturas: Funcionalidades de mapa]*

### 12.5 Enlaces Externos de Interés

| Recurso | Enlace |
|---------|--------|
| Neiva, Huila — Información turística | [Turismo Neiva](https://www.neiva-huila.gov.co) |
| Transporte público de Neiva | [Información de transporte] |
| Datos abiertos de movilidad | [Datos abiertos Colombia](https://www.datos.gov.co) |

---

## 13. Glosario

| Término | Definición |
|---------|-----------|
| **CO₂** | Dióxido de carbono, gas de efecto invernadero emitido por medios de transporte. |
| **CU** | Caso de Uso, descripción funcional de una interacción con el sistema. |
| **Dashboard** | Panel principal que muestra un resumen de la actividad del usuario. |
| **Endpoint** | Punto de acceso de la API para una funcionalidad específica. |
| **Expo** | Framework para desarrollo de aplicaciones móviles con React Native. |
| **HU** | Historia de Usuario, descripción de una funcionalidad desde la perspectiva del usuario. |
| **JWT** | JSON Web Token, mecanismo de autenticación utilizado por la plataforma. |
| **OAuth** | Protocolo de autorización que permite iniciar sesión con cuentas de terceros (Google). |
| **POI** | Point of Interest, punto de interés o lugar relevante en el mapa. |
| **PostGIS** | Extensión de PostgreSQL para datos geoespaciales. |
| **Push** | Notificación enviada directamente al dispositivo móvil. |
| **2FA** | Autenticación de dos factores, seguridad adicional con código temporal. |

---

## Historial de Versiones

| Versión | Fecha | Cambios |
|---------|-------|---------|
| 1.0 | 10/10/2026 | Versión inicial del manual |

---

> **EcoRuteando** — Moviendo Neiva hacia un futuro más sostenible. 🌿🚲
