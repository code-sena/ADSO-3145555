# Resultados locales de pruebas de backend y base de datos

**Fecha:** 4 de noviembre de 2026 (America/Bogota)  
**Entorno:** Windows, Docker Desktop con backend WSL 2  
**Alcance:** Backend Spring Boot, PostgreSQL, migraciones Liquibase y flujo de autenticacion.  
**Produccion:** No se modifico ni se probo contra produccion.

## Resumen

Se restauro Docker Desktop despues del error de WSL, se validaron las migraciones en una PostgreSQL temporal y se verifico el flujo completo de registro e inicio de sesion contra una instancia backend construida desde el repositorio local. Tambien se automatizo el caso E2E y se incorporo un job de CI para ejecutar ese caso junto con las pruebas de concurrencia sobre PostgreSQL.

Los contenedores temporales se eliminaron al finalizar. Los servicios locales del proyecto permanecen activos.

## Resultados

| Verificacion | Resultado |
| --- | --- |
| PostgreSQL temporal | Healthy y accesible durante la prueba. |
| `liquibase validate` | Sin errores de validacion. |
| Migraciones Liquibase | 21 cambios aplicados correctamente; 29 filas afectadas, incluidas las siembras del catalogo. |
| Esquema y claves foraneas requeridas | Verificados correctamente. |
| Segunda ejecucion de Liquibase | Idempotente: no agrego cambiosets nuevos. |
| `mvn verify` regular | 41 pruebas reportadas, 0 fallas, 0 errores y 6 omitidas intencionalmente por requerir PostgreSQL. |
| Suite de integracion PostgreSQL | 6 pruebas, 0 fallas, 0 errores, 0 omitidas: 1 E2E HTTP y 5 de concurrencia de autenticacion. |
| Salud del servicio PostgreSQL local | `pg_isready` respondio que acepta conexiones. |
| Servicios locales del proyecto | Backend, DB, frontend e IA siguieron activos al terminar. |

## Flujo E2E comprobado

La prueba hizo solicitudes HTTP reales a una instancia del backend conectada exclusivamente a una base PostgreSQL temporal:

1. Registro en `POST /api/users`: `201 Created`.
2. Inicio de sesion en `POST /auth/login`: `200 OK` y token emitido.
3. Consulta autenticada a `GET /api/users/me`: `200 OK`, con el perfil del usuario generado para la prueba.
4. Consulta a `GET /api/users/me` sin token: `401 Unauthorized`.
5. Verificacion directa en la DB temporal: la contrasena se persistio como hash BCrypt verificable, no como texto plano.

Los datos de la cuenta fueron generados unicamente para esta ejecucion. No se guardaron credenciales, tokens ni datos de usuarios reales en este informe.

## Pruebas de concurrencia

Se ejecutaron sobre PostgreSQL los cinco escenarios del test `AuthServicePostgresConcurrencyTest`: fallos simultaneos al alcanzar el limite, bloqueo durante el periodo de bloqueo, reinicio del ciclo despues del vencimiento y concurrencia entre un inicio correcto y uno incorrecto. Los cinco pasaron.

## Automatizacion agregada

En la rama local de backend `test/postgres-integration-ci` se agrego `AuthApiPostgresE2ETest` y un job `postgres-integration` al workflow `backend-ci.yml`. El job inicia PostgreSQL 15 efimero y ejecuta ambos tests mediante las propiedades `postgres.integration=true` y `concurrency.integration=true`. La suite equivalente paso localmente en PostgreSQL.

La rama aun no se ha pusheado; por tanto, el workflow de GitHub no se ha ejecutado en Actions y requiere PR/merge para quedar activo en remoto.

## Reproduccion

En una PostgreSQL de pruebas vacia, con las variables de entorno de test configuradas, ejecutar desde `Backend-OneLanguage`:

```powershell
./mvnw -Dpostgres.integration=true -Dconcurrency.integration=true "-Dtest=AuthApiPostgresE2ETest,AuthServicePostgresConcurrencyTest" test
```

La suite regular se ejecuta con `./mvnw verify`. Las credenciales para ambas ejecuciones deben ser ficticias y limitarse al entorno temporal de pruebas.

## Limites y observaciones

- El `verify` regular no ejecuta por defecto las pruebas PostgreSQL: seis casos quedan omitidos porque requieren las propiedades de integracion. El nuevo job de CI activa ambas propiedades y los ejecuta contra un servicio PostgreSQL aislado.
- La ejecucion de migraciones en esta verificacion valida el esquema de la rama local de base de datos; no reemplaza una aprobacion de migraciones para produccion.
- Las pruebas no validan correo real ni servidor SMTP; el E2E cubre registro, autenticacion, autorizacion y persistencia del hash.
- No se hizo push, commit ni despliegue a Hostinger como parte de esta ejecucion.
