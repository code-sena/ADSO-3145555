# Alcance de la evidencia y de la entrega

Revisión documental: 5 de noviembre de 2026.

La coordinadora de entrega solicita conservar las ramas `main` sin cambios. La [reprueba automática de María José](installation-verification/README.md) se incorpora como evidencia de su alcance, no como aprobación de una versión distinta ni de reconocimiento positivo con cámara.

- Los registros acreditan arranque del backend, migraciones, login, persistencia y una reprueba integral automática sin fallos. Las diez pruebas focalizadas de coordinación usan H2 y correo simulado.
- El caso facial positivo utiliza inferencia determinista; el modelo real responde 400 ante imágenes negras sin rostro. No se certifica captura ni reconocimiento positivo con cámara.
- La prueba usa FaceLit-DB `096cd3e99d6936a7dacfe4b216b5e548f0a6eaf8`; la entrega conserva `cd069ae0cb4947d4b7ebbff17e9d6dc280ab86fd`. No se consideran equivalentes sin comprobar sus diferencias.
- La reprueba incluye una corrección local del runner del navegador, conservada como parche en la evidencia. No se aplica a `main` por decisión de la coordinadora. El resultado no se atribuye al commit base sin esa corrección.
- Se verificaron las 28 huellas del manifiesto de instalación y las cuatro del registro de contribuciones. El CSV contiene 677 registros. Las huellas prueban integridad del paquete, no ejecución independiente por este revisor.

## Aceptación de diferencias por la coordinadora — 2026-11-05

Mariana Valenzuela Penagos, coordinadora de entrega, acepta expresamente entregar el código conservando la diferencia entre el commit de DB probado y el entregado, así como la corrección local del script de navegador no incorporada a `main`. Estas diferencias dejan de estar pendientes de su decisión; se conservan como excepciones conocidas, sin afirmar equivalencia técnica entre las versiones ni modificar los resultados originales de María José.

**Punto 6: evidencia automática aceptada por la coordinadora con las excepciones documentadas.** La aceptación académica del instructor y la determinación de si exige reconocimiento positivo con cámara real siguen pendientes. No se afirma que esa prueba se haya realizado ni que la versión exacta entregada haya pasado el mismo flujo sin las diferencias indicadas.

## Integridad y rutas de origen

Las carpetas [installation-verification](installation-verification/) y [team-contributions](team-contributions/) se importaron sin alterar sus bytes. Algunos enlaces internos conservan rutas del repositorio documental de origen (`14_Anexos/Trabajo_Equipo/`), no de este fork. Para consultar las contribuciones aquí, usar [su índice local](team-contributions/README.md). Sus SHA corresponden al corte histórico del informe, no a todos los cambios posteriores.
