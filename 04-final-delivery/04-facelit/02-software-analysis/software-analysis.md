# Análisis del software FaceLit
Informe de análisis y vistas dinámicas para la entrega final. Fecha de consolidación: 5 de noviembre de 2026.
## Alcance y fuentes
Este informe integra Arquitectura_Implementada y Flujos_Funcionales del repositorio facelit-docs, revisión dcf81aa. Describe el flujo documentado más reciente, sin ejecutar el sistema ni aprobar todos los requisitos. Los diagramas editables recibidos se conservan en source-diagrams como antecedentes que deben contrastarse con la versión final.
## Problema, actores y casos de uso
FaceLit relaciona usuarios, programas, fichas, ambientes y sesiones para registrar y consultar asistencia con apoyo de identificación facial. Existen tres roles principales; la carpeta admin representa al coordinador.
<!-- diagram:usecases -->
| Actor | Casos de uso | Restricción |
|---|---|---|
| Coordinador | Gestionar usuarios, programas, fichas y asociaciones; importar CSV. | La autorización se aplica en servidor. |
| Instructor | Preparar sesión, operar captura y consultar asistencia. | Solo recursos de su alcance autorizado. |
| Aprendiz | Enrolar rostro, consultar perfil y asistencia propia. | No escribir asistencia como instructor. |
## Secuencia principal de asistencia
Precondiciones: identidad autenticada, sesión permitida, datos académicos relacionados y referencia facial disponible. El cliente obtiene capturas y las envía al backend; Java valida actor y contexto, coordina FastAPI, aplica reglas y persiste el resultado.
<!-- diagram:sequence -->
El servicio facial devuelve la evaluación al backend y el backend responde al cliente. PostgreSQL es compartido por Java y el servicio facial; el navegador no accede directamente a la base ni debe contener la clave privada facial.
## Actividad y caminos alternativos
<!-- diagram:activity -->
1. Comprobar permiso de cámara y preparar los retos activos.
2. Capturar la secuencia documentada: dos retos distintos y siete imágenes por reto.
3. Validar autorización y contexto de sesión en backend.
4. Evaluar captura y coincidencia en el servicio facial interno.
5. Aplicar reglas temporales, entrada/salida y duplicidad en backend.
6. Persistir la operación válida y presentar su resultado; consultar después el dato guardado.
Alternativas: cámara denegada, captura incompleta, rostro no coincidente, sesión inválida, duplicidad o servicio no disponible. Registrar el rechazo y mantener coherencia entre el mensaje de interfaz y el resultado remoto; no presentar un éxito local como asistencia persistida.
## Análisis de responsabilidades
Interfaz: pantallas, formularios, cámara, navegación y estados. Aplicación: autenticación, permisos, coordinación y reglas. Servicio especializado: evaluación de retos y comparación facial. Persistencia: relaciones, vectores, eventos y migraciones Liquibase.
## Trazabilidad y límites
RF-5.1 aborda enrolamiento; RF-5.2 preparación de sesión; RF-6.1 configuración de asistencia; RF-7.1 y RF-7.2 consultas. El SRS conserva requisitos y hallazgos de cortes anteriores. La presencia de un caso de uso o endpoint no acredita aceptación: relacionar cada resultado con casos del plan de pruebas y SHA final.
El manual de instalación actualizado enlaza las migraciones 025 y 026 y los cambios de 06_migrations. El informe de despliegue diferencia el paquete local y GitHub: frontend con consulta por lotes sin commit y DB local 422aac6 frente al remoto de referencia cd069ae. No atribuir el paquete desplegado a un tag remoto sin comprobar su manifiesto.
## Documentos de soporte
implemented-architecture.pdf y functional-flows.pdf acompañan este informe. Los diagramas de este informe son resúmenes actuales derivados de las fuentes; los originales en source-diagrams conservan su contenido recibido y requieren revisión si se usarán como diagramas definitivos.

## Actualización de análisis y alcance
El SRS V4.1 documenta Ambientes integrado, reportes e historial con consulta de API y tres roles vigentes. RF-C1 Horarios y excepciones queda retirado del alcance operativo; RNF-5.7 offline es ampliación futura. El inventario funcional actualizado acompaña este análisis. El diseño visual inventaría 63 rutas y el catálogo contiene 16 capturas únicas con alcance por leyenda.
