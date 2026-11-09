# Pruebas y evidencia disponible
FaceLit. Actualización documental del 5 de noviembre de 2026, fuente dcf81aa. No se ejecutaron pruebas del producto durante esta organización.
## Plan y casos
test-plan.pdf conserva 30 casos CP-001 a CP-030 con procedimientos y resultados esperados. Su registro inicial es No ejecutado. La evidencia posterior no convierte automáticamente todos esos casos en aprobados.
## Evidencia recibida y sus límites
| Documento | Qué aporta | Límite |
|---|---|---|
| partial-csv-evidence.pdf | Capturas parciales de carga y notificación. | No acredita el recorrido completo. |
| archived-e2e-evidence.pdf | Una prueba Maven aprobada con varios escenarios, base aislada y capturas archivadas por separado. | Inferencia simulada; no cámara física o producción. |
| reported-test-results.md | HU-45: facial 123 aprobadas y una optativa omitida; frontend 120 en 13 suites y seis scripts. | Corridas distintas; no sumar ni atribuir al tag final sin comprobar. |
| visual-evidence-by-role.pdf y MD | 16 capturas únicas: 8 de coordinación, 1 de instructor y 7 de aprendiz. | Solo el resultado visible de cada leyenda; SHA y entorno no deducibles de la imagen. |
## Alcance de las nuevas capturas
El formulario CSV muestra preparación y las alertas muestran validación. La matriz y sus botones no prueban el archivo exportado. Preparación facial, validación del reto y aviso de finalización son estados separados; las imágenes no demuestran una sola ejecución común.
Se conservaron las copias de entrega con zonas cubiertas preparadas por el equipo. Las imágenes originales identificables no se incorporan a esta carpeta.
## Trazabilidad de resultados
El E2E archivado identifica frontend 5f7d6fe, backend a77314d, DB 370cebb y facial d2571c5; la ejecución indicada es del 1 de noviembre de 2026, 00:23 Bogotá. Esas revisiones no se sustituyen por el tag final sin nueva evidencia o demostración de equivalencia.
La matriz vigente es SRS V4.1 con sus anexos A y B en el producto 01. Distingue funcionamiento confirmado, evidencia visual, implementación y verificaciones especializadas; no equivale a aceptación global.
## Registro de cierre
Por caso registrar fecha, ejecutora, SHA y entorno, datos ficticios, procedimiento, resultado esperado y observado, estado y evidencia. Relacionar resultados con el tag final. Mantener separados cámara real o sintética, inferencia real o simulada y SMTP real o simulado. Comprobar restauración en entorno separado y APK exacto si se entrega Android. No incluir secretos ni datos reales en evidencias públicas.
