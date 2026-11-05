# Test documentation / Documentación de pruebas

## Evidencia de instalación recibida — 2026-11-05

**Actualización posterior:** se recibió la [reprueba automática satisfactoria](installation-verification/README.md) y los [archivos de contribuciones faltantes](team-contributions/README.md). Consultar primero el [alcance final y diferencias de versiones](installation-final-scope.md). El resumen siguiente describe el primer intento y conserva su resultado histórico; no resume la nueva reprueba.

[Registro de ejecución de María José](installation-execution-record.md), acompañado de seis capturas originales en [installation-evidence/](installation-evidence/).

**Punto 6: parcial; no aprobado todavía.** Las capturas acreditan validación y aplicación exitosa de 47 cambios de Liquibase, construcción/inicio del contenedor facial y arranque de Expo. El intento de crear la coordinadora muestra un error; el recorte del backend termina antes de confirmar su arranque. No constan los commits probados, la disponibilidad del servicio facial ni un inicio de sesión y flujo integral satisfactorios. La causa del error no puede determinarse con estos recortes.

Para cerrar la prueba, aportar los commits y cambios locales de las cuatro capas, el resultado completo del backend y del acceso con una cuenta de prueba, la salud y operación del servicio facial y un flujo frontend–backend–base de datos. Si hubo correcciones, registrar su versión y una reprueba satisfactoria. No publicar credenciales ni repetir el borrado de volúmenes que figura únicamente como antecedente en el registro.

**Training project deliverable / Producto del proyecto formativo:** Documentación de pruebas.

## Required content / Contenido requerido

- [ ] Test plan / Plan de pruebas
- [ ] Test cases / Casos de prueba
- [ ] Test results with evidence / Resultados de las pruebas con evidencia

## Format / Formato

- Final version in PDF, plus the editable source when it exists. / Versión final en PDF y, si existe, el archivo fuente editable.
- English file names, without spaces or accents: `requirements-specification.pdf`. / Nombres de archivo en inglés, sin espacios ni tildes.
- Files over 50 MB go to Drive and are listed in the project `README.md`. / Los archivos de más de 50 MB van a Drive y se relacionan en el `README.md` del proyecto.
- Do not add passwords, tokens, keys or real user data. / No incluya contraseñas, tokens, llaves ni datos reales de usuarios.


## Actualización documental - Persona 2

Fuente: facelit-docs, commit `dcf81aad429eeffbbe9f9ac17d0b7946e82c3dcb`, revisión del 5 de noviembre de 2026.

- [archived-e2e-evidence.pdf](archived-e2e-evidence.pdf)
- [partial-csv-evidence.pdf](partial-csv-evidence.pdf)
- [reported-test-results.md](reported-test-results.md)
- [test-evidence-summary.md](test-evidence-summary.md)
- [test-evidence-summary.pdf](test-evidence-summary.pdf)
- [test-plan.md](test-plan.md)
- [test-plan.pdf](test-plan.pdf)
- [visual-evidence-by-role.md](visual-evidence-by-role.md)
- [visual-evidence-by-role.pdf](visual-evidence-by-role.pdf)
- [Recursos: role-captures](role-captures/)

Consulte [cambios, fuentes y pendientes](../delivery-review.md). Las casillas oficiales conservan su estado: documentación organizada no equivale a aceptación completa del producto. Para cambios de estado y despliegue, priorice SRS V4.1 y el informe actualizado frente a notas de cortes anteriores.
