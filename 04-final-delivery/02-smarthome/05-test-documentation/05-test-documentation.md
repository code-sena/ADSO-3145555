
# Producto 05 — Documentación de pruebas

Servicio Nacional de Aprendizaje (SENA)  
Programa: Análisis y Desarrollo de Software  
Ficha: 3145555  
Proyecto: SmartHome  
Elaborado por: Natalia Chala Chala, Kevin Stiven López Amaya y Karen Daniela Holguín Cruz  
Instructor: José de Jesús Motta Vargas  
Fecha de actualización: 6 de noviembre de 2026

## 1. Presentación

Este documento consolida el plan de pruebas de SmartHome, su estrategia de ejecución y una matriz de 19 casos enlazados con requisitos del SRS. La actualización incorpora la mejora solicitada: cada caso se vincula ahora con uno o varios RF/RNF y se conserva la diferencia entre lo probado automáticamente, lo observado por evidencia documental y lo que aún está pendiente de ejecución manual o física.

Como marco de referencia, la estrategia de pruebas se organiza por niveles (unitarias, de integración y extremo a extremo) siguiendo los conceptos de ISO/IEC/IEEE 29119-1 (ISO/IEC/IEEE, 2022), y los casos de seguridad se derivan de las categorías de riesgo de OWASP Top 10 (OWASP Foundation, 2021).

## 2. Alcance

Se consideran cuatro tipos de validación:

1. Automatizadas / CI: lint, tipado, build, Jest, contratos y auditorías.
2. Integración controlada: base de datos, migraciones, reglas de seguridad y comunicación entre capas.
3. Funcionales manuales: navegación, formularios, roles, consumo, reportes y notificaciones.
4. End-to-end con hardware: integración real con canales IoT y dispositivo compatible.

## 3. Evidencias base utilizadas

**Tabla 1**

*Evidencias base utilizadas*

| Código | Evidencia | Estado | Observación |
|---|---|---|---|
| E-01 | CI backend | Aprobada | Lint, TypeScript, pruebas y build. |
| E-02 | CI frontend web | Aprobada | Validación y build del cliente web. |
| E-03 | CI base de datos | Aprobada | Liquibase y controles de BD en entorno de CI. |
| E-04 | CI aplicación móvil | Aprobada | Exportación y validaciones del cliente móvil. |
| E-05 | Auditoría de dependencias móvil | Fallida | Hay hallazgos de dependencias que deben atenderse. |

Fuente: elaboración propia.

## 4. Criterios generales de aceptación

- Todo caso debe indicar requisito asociado, tipo de prueba, resultado esperado y estado.
- Un caso solo puede declararse aprobado si existe evidencia verificable.
- Los prototipos del Drive no se usan como evidencia de ejecución; solo como referencia visual.
- La integración con hardware o red local no se marca como aprobada sin acta o evidencia real de laboratorio.

## 5. Matriz de casos de prueba

**Tabla 2**

*Matriz de casos de prueba*

| ID | Caso de prueba | Requisito(s) asociados | Tipo | Estado | Evidencia / fuente |
|---|---|---|---|---|---|
| CP-01 | Registro básico de usuario | RF1.1 | Funcional / integración | Pendiente | Requiere evidencia manual o automatizada específica |
| CP-02 | Inicio de sesión con credenciales válidas | RF1.2 | Automatizada / funcional | Parcialmente respaldado | E-01, E-02, E-04 |
| CP-03 | Cierre de sesión y revocación de acceso | RF1.4 | Funcional | Pendiente | Debe ejecutarse en web y móvil |
| CP-04 | Recuperación de contraseña | RF1.8 | Funcional | Pendiente | Requiere flujo real o simulación controlada |
| CP-05 | Creación de hogar | RF2.1 | Funcional / integración | Pendiente | Se necesita ejecución sobre backend activo |
| CP-06 | Modificación de hogar | RF2.2 | Funcional | Pendiente | Debe validarse con permisos |
| CP-07 | Vinculación de dispositivo a hogar | RF2.3, RF3.1 | Integración | Pendiente | Requiere backend + BD |
| CP-08 | Registro/configuración de dispositivo | RF3.1, RF3.2 | Funcional / integración | Pendiente | Debe contrastarse con API y UI |
| CP-09 | Actualización y desactivación de dispositivo | RF3.3, RF3.4 | Funcional | Pendiente | Falta ejecución documentada |
| CP-10 | Monitoreo y control de dispositivo | RF3.5 | Integración / E2E | Pendiente crítico | La orden publicada no basta sin confirmación física |
| CP-11 | Consulta de reportes históricos | RF4.1 | Funcional | Pendiente | Requiere datos cargados |
| CP-12 | Visualización de consumo en tiempo real | RF4.2 | Integración / E2E | Pendiente | Necesita entorno con telemetría activa |
| CP-13 | Generación de gráficos de consumo | RF4.3 | Funcional | Pendiente | Validación visual y de datos |
| CP-14 | Visualización de notificaciones | RF4.4 | Funcional | Pendiente | Validar lectura, listado y estados |
| CP-15 | Sincronización entre clientes / actualización de datos | RF5.1 | Integración | Pendiente | Requiere backend, BD y clientes activos |
| CP-16 | Restauración/recuperación de información | RF5.3 | Integración | Pendiente | Debe comprobarse el procedimiento real |
| CP-17 | Configuración de idioma | RF6.1 | Funcional | Pendiente | Validar persistencia del ajuste |
| CP-18 | Personalización de tema | RF6.2 | Funcional | Pendiente | Validar aplicación consistente del tema |
| CP-19 | Seguridad de dependencias y control de calidad móvil | RNF seguridad / política CI | Automatizada | Fallida | E-05 |

Fuente: elaboración propia.

## 6. Lectura técnica de la matriz

### 6.1 Casos con mejor respaldo hoy

Los casos con mayor soporte verificable son los que dependen de los pipelines de calidad: compilación, validaciones estáticas, pruebas del backend, verificaciones del frontend, ejecución del flujo de base de datos y exportación de la app móvil. Esto no significa que la experiencia completa de usuario haya sido aprobada; significa que existe un piso técnico razonable para continuar con pruebas funcionales.

### 6.2 Casos pendientes que no deben maquillarse como aprobados

Los casos CP-10, CP-12 y CP-15 son especialmente sensibles porque involucran integración real: control sobre dispositivo, consumo en tiempo real y sincronización entre plataformas. Estos casos no deben pasar a “aprobados” sin evidencia concreta.

### 6.3 Caso con hallazgo abierto

El caso CP-19 permanece en estado fallido porque la auditoría móvil reportó vulnerabilidades de dependencias. Este hallazgo debe mantenerse visible en la entrega porque representa una condición real del estado del proyecto.

## 7. Ambiente de prueba recomendado

**Tabla 3**

*Ambiente de prueba recomendado*

| Ambiente | Componentes mínimos | Uso |
|---|---|---|
| CI / automatizado | Repositorios, workflows y runners configurados | calidad técnica base |
| Local integrado | PostgreSQL, Liquibase, backend, frontend web, app móvil | validación funcional e integración |
| Laboratorio IoT | Entorno local integrado + dispositivo compatible + broker / canal IoT | pruebas end-to-end con hardware |

Fuente: elaboración propia.

## 8. Evidencia que aún conviene recolectar

- Capturas o acta de ejecución de login, hogares, dispositivos y notificaciones.
- Evidencia de control físico sobre dispositivo compatible.
- Confirmación de consumo en tiempo real y trazas asociadas.
- Registro de corrección del hallazgo de dependencias móviles.
- Validación del procedimiento de restauración o recuperación de información.

## 9. Conclusión

La documentación de pruebas queda mejor estructurada al relacionar los 19 casos con requisitos concretos del SRS. La actualización también mejora la honestidad técnica del entregable: conserva las evidencias reales de GitHub Actions, reconoce el hallazgo abierto en la auditoría móvil y evita marcar como aprobados los escenarios que todavía necesitan ejecución manual o de laboratorio.

## Referencias

ISO/IEC/IEEE. (2022). *Software and systems engineering — Software testing — Part 1: General concepts* (ISO/IEC/IEEE 29119-1:2022). https://www.iso.org/standard/81291.html

OWASP Foundation. (2021). *OWASP Top 10:2021*. https://owasp.org/Top10/
