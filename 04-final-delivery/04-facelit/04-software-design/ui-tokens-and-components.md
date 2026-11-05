# Sistema visual y componentes de FaceLit

Revisión integral del 5 de noviembre de 2026. La fuente es el frontend main 6efd92c con su ajuste local de consulta académica. Este archivo conserva su nombre histórico Sistema_Visual_UI_2026-10-27.md.

## Estructura de la página

La pantalla autenticada se organiza con cabecera, navegación por rol y contenido de tarea. La cabecera integra marca, menú, idioma, tema y acceso a notificaciones. El contenido presenta título y contexto, filtros o instrucciones, registros o formulario y acciones. Esta jerarquía facilita reconocer dónde se encuentra el usuario y qué operación está realizando.

Sidebar.tsx define las entradas visibles del menú y distingue el destino activo. RoleTopbar conserva los controles comunes. El panel del instructor añade accesos contextuales a sus fichas. Los formularios de programa y ambiente pueden abrirse dentro de FormModal, además de las rutas de registro existentes.

## Paleta de marca y estados

| Token | Valor | Uso |
|---|---|---|
| primary | #65B361 | Marca y acción principal. |
| primaryLight | #72C96D | Variación clara. |
| primaryDark | #4A9146 | Variación oscura. |
| primaryFaint | rgba(101,179,97,0.10) | Fondo de apoyo. |
| secondary | #F59E0B | Acento. |
| secondaryLight | #FFB74D | Variación clara de acento. |
| secondaryDark | #D97706 | Variación oscura de acento. |
| secondaryFaint | rgba(245,158,11,0.08) | Fondo de apoyo al acento. |
| success | #27AE60 | Confirmación y resultado favorable. |
| info | #4A90D9 | Información. |
| warning | #E89B2C | Advertencia. |
| danger y error | #D92027 | Error y acción destructiva. |
| successSoft | rgba(39,174,96,0.15) | Superficie semántica de éxito. |
| infoSoft | rgba(74,144,217,0.12) | Superficie informativa. |
| warningSoft | rgba(232,155,44,0.12) | Superficie de advertencia. |
| dangerSoft | rgba(217,32,39,0.12) | Superficie de error. |

## Temas claro y oscuro

| Token | Claro | Oscuro |
|---|---|---|
| background | #F4F1EA | #000000 |
| surface y card | #FBF8F1 | #06100A |
| surfaceSecondary | #EDE7DC | #0A1710 |
| border | #DED7CC | #173522 |
| borderStrong | #CEC4B5 | #285238 |
| inputBg | #F8F5EE | #08130D |
| inputBorder | #CEC4B5 | #1B3B27 |
| text | #0F172A | #FFFFFF |
| textSecondary | #475569 | #B7C5BC |
| textMuted | #64748B | #7F9587 |
| placeholder | #94A3B8 | #587060 |
| link | #D97706 | #F59E0B |

ThemeContext deriva inputText desde text e inputPlaceholder desde placeholder. primaryDarkText usa el valor primary y secondaryDarkText usa secondary en la configuración revisada. gradientColors combina background, surface y surfaceSecondary. La barra de estado usa contenido oscuro en tema claro y contenido claro en tema oscuro.

Las pantallas consumen estos tokens desde el contexto. El significado de éxito, advertencia y error se conserva al cambiar de tema. La revisión de contraste se hace sobre la combinación real de texto, icono, fondo y tamaño.

## Escala tipográfica

| Nombre | Tamaño en px | Uso de referencia |
|---|---|---|
| xs | 11 | Metadato breve. |
| sm | 12 | Texto auxiliar. |
| md | 13 | Descripción compacta. |
| base | 14 | Texto ordinario. |
| lg | 16 | Texto destacado. |
| xl | 18 | Subtítulo. |
| 2xl | 22 | Encabezado de sección. |
| 3xl | 26 | Título de pantalla. |
| 4xl | 32 | Encabezado principal. |
| 5xl | 38 | Presentación destacada. |

FontWeight define regular 400, medium 500, semibold 600, bold 700, extrabold 800 y black 900. Los usos de referencia organizan la lectura y se ajustan al componente y al ancho disponible.

## Catálogo de componentes compartidos

| Componente | Responsabilidad | Estados que se revisan |
|---|---|---|
| Sidebar y RoleTopbar | Navegación, identidad de rol y controles comunes. | Abierto, cerrado y destino activo. |
| AppButton | Acción principal con gradiente y variantes outline y ghost. | Normal, presionado y deshabilitado. |
| InputField y PasswordField | Captura de datos y manejo de visibilidad de contraseña. | Vacío, valor, foco y error. |
| SelectField y SearchableSelect | Selección y búsqueda de opciones. | Cerrado, abierto, elegido y búsqueda sin coincidencias. |
| DateField y TimeInput | Selección de periodo y tiempos de sesión. | Sin selección, valor y validación. |
| FormModal | Formulario superpuesto con cierre y contenido desplazable. | Abierto, edición y confirmación. |
| AppDialog | Confirmación o comunicación de un resultado. | Confirmar, cancelar y cierre. |
| RemoteDataState | Carga, fallo y acción de reintento de datos remotos. | Procesando y error recuperable. |
| ThemeToggle y LanguageSelector | Preferencias comunes. | Tema y lenguaje elegidos. |

Los formularios específicos de programa, ambiente e instructor comparten estructura y conservan las reglas de cada entidad. Un modal de edición y una ruta de registro pueden servir al mismo caso de uso. La especificación de navegación identifica ambos puntos de entrada cuando existen.

## Estados de interfaz y mensajes

| Estado | Presentación | Acción esperada |
|---|---|---|
| Carga | Indicador y texto de procesamiento. | Esperar y preservar el contexto. |
| Falta de selección | Instrucción junto al selector de programa o fechas. | Completar el filtro inicial. |
| Lista vacía | Explicación asociada al filtro activo. | Cambiar filtro o registrar según permiso. |
| Validación | Mensaje junto al campo y valor conservado. | Corregir el dato indicado. |
| Error remoto | Mensaje comprensible y reintento cuando corresponde. | Repetir la consulta. |
| Guardado confirmado | Resultado devuelto por el servidor y vista actualizada. | Consultar el registro. |
| Confirmación destructiva | Identidad del registro y consecuencias de la acción. | Confirmar o cancelar. |
| Captura facial | Instrucción del reto, estado de captura y validación. | Completar el reto y esperar confirmación. |
| Acceso rechazado | Estado de sesión o permiso explicado en el contexto correcto. | Autenticar o volver al área del rol. |

RemoteDataState utiliza una región accesible de actualización, estado de alerta para errores y un botón de reintento. La prueba de cada pantalla debe registrar cómo presenta esos estados y cómo recupera la tarea.

## Adaptación de ancho y accesibilidad

Las tarjetas y formularios deben conservar su lectura al reducir el ancho. FormModal limita su altura y habilita desplazamiento. Las matrices de asistencia desplazan sus columnas horizontalmente. La cabecera y el menú deben seguir disponibles según el contexto del rol y de la sesión facial.

La revisión con teclado comprueba orden de foco, apertura y cierre de diálogos y retorno al control que los invocó. Los controles requieren una etiqueta reconocible. En tablas de asistencia, la leyenda, el texto o icono y el color comunican el estado conjuntamente. Las comprobaciones de contraste se hacen en ambos temas y con el tamaño de fuente aplicado.

Los valores de separación y ancho se definen en los estilos de cada componente. El criterio documental es conservar alineación, legibilidad y espacio de interacción en el tamaño real de uso. Las medidas se verifican en la pantalla correspondiente.

## Idioma y persistencia

El cliente ofrece español, inglés, alemán y francés. useUserSettings mapea ES, EN, DE y FR. El enum Language del backend contiene esos valores y PR como compatibilidad. Las preferencias se guardan para el titular mediante la API. Al revisar traducciones se comprueban títulos, acciones, mensajes, fechas y textos largos dentro de botones y tablas.

## Revisión de entrega

- Comprobar los dos temas y las cuatro opciones de idioma en las pantallas representativas.
- Abrir y cerrar el menú, navegar por los cinco accesos del instructor y el aprendiz y por los siete de coordinación.
- Revisar formularios vacíos, datos inválidos, confirmación y respuesta de guardado.
- Revisar consulta sin filtros, consulta con datos y consulta sin coincidencias.
- Registrar el estado de la cámara y la respuesta del servidor con la versión del flujo.
- Cotejar exportación y filtro utilizando el archivo descargado.
- Revisar teclado, etiquetas, contraste y desplazamiento con resultados por pantalla.

Las capturas de la carpeta 07 sustentan los estados descritos en su catálogo. Las pruebas de accesibilidad y comprensión se registran con sus propios resultados.
