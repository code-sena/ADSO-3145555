# Evidencia de CI de HidroSmart

## Registro histórico HU-20

Ejecuciones consultadas el 2026-11-04 para `PT_HS/hu-20-dev`.

- SHA: `1f02b783cd997926ca2b28876d118442f520cd1e`.
- `HidroSmart validation`: finalizó correctamente.
- `Validate and update database`: finalizó correctamente en el stack limpio de CI.
- Inicio de API/web, calidad del backend, calidad del frontend y calidad del móvil: correctos.
- `HidroSmart CI`: finalizó correctamente en el mismo commit.

Ejecuciones históricas: [HidroSmart validation #41923198240](https://github.com/joseale879/PT_HS/actions/runs/41923198240) y [HidroSmart CI #41923198129](https://github.com/joseale879/PT_HS/actions/runs/41923198129).

## Snapshot anterior de `main` consultado el 2026-11-05

- Repositorio: [joseale879/PT_HS](https://github.com/joseale879/PT_HS).
- SHA de `main`: `09c9e4cc7150687e7881699e8da9e0832928df1e`.
- El commit histórico `1f02b783cd997926ca2b28876d118442f520cd1e` es ancestro del `main` consultado y ambos árboles de archivos son idénticos.
- Las cuatro ejecuciones de Actions asociadas a `main` terminaron correctamente: [HidroSmart CI #41977974917](https://github.com/joseale879/PT_HS/actions/runs/41977974917), [HidroSmart validation #41977974989](https://github.com/joseale879/PT_HS/actions/runs/41977974989), [HidroSmart CI #41977970618](https://github.com/joseale879/PT_HS/actions/runs/41977970618) y [HidroSmart validation #41977970507](https://github.com/joseale879/PT_HS/actions/runs/41977970507). Los nueve checks reportados en el SHA terminaron `success`.
- El endpoint de estado combinado del commit informó `pending` con cero contextos de estado. No se interpreta ese resultado como verde; hay que aclararlo en GitHub antes de afirmar que el gate completo está aprobado.

## Snapshot vigente de `main` (HU-21) consultado el 2026-11-05 a las 07:39 UTC

- SHA remoto de `main`: `32be1cf787f20120dfd3b4cc72226dab55d88216`; coincide con `hu-21-main`.
- El cambio HU-21 separa la consulta del perfil de las llamadas para hogares y dispositivos.
- Las dos ejecuciones de workflow asociadas a este SHA terminaron correctamente: [HidroSmart validation #41988310293](https://github.com/joseale879/PT_HS/actions/runs/41988310293) y [HidroSmart CI #41988310310](https://github.com/joseale879/PT_HS/actions/runs/41988310310).
- Los nueve check-runs asociados terminaron `success`, incluidos `full-validation`, frontend build/unit/browser E2E, backend checks/unit tests, build ESP32 local/Flespi TLS y Cloudflare Pages.
- El endpoint de commit status informó `pending` con cero contextos. Por tanto, los workflows/check-runs están verdes, pero el estado combinado del commit no aparece aprobado; no describir el gate global como verde.
- CI de software/compilación no acredita telemetría física, BLE, ACL remota, entrega real de correos, base desplegada ni aceptación de requisitos.

## Tag corregido `final-delivery-2026` verificado el 2026-11-08

El tag de PT_HS fue actualizado al commit `64e03d82696646571fd5e2ad97431c84a12b68e2` después de corregir dos fallos de Liquibase y el formato frontend. La ejecución remota [HidroSmart validation #42447230775](https://github.com/joseale879/PT_HS/actions/runs/42447230775) terminó `success` en los 11 pasos: instalación npm, stack local, `Validate and update database`, API/web, seed, calidad backend, calidad frontend y mobile.

El fallo original [#41974700842](https://github.com/joseale879/PT_HS/actions/runs/41974700842) queda como antecedente histórico del tag anterior (`8dd45ca`), no como estado del tag vigente. El Release de la entrega fue actualizado con los dos ZIP nuevos de PT_HS y sus SHA-256 se sincronizaron en `code-tag/SHA256SUMS.txt`.

Correcciones aplicadas en PT_HS:

- `035_saving_goal_daily_period.sql` se ejecuta como una unidad (`splitStatements: false`) para preservar el bloque PL/pgSQL `$$...$$`.
- La siembra de reglas de fuga ya no usa `ON CONFLICT` antes de que exista el índice parcial correspondiente.
- Se formatearon seis archivos frontend para que `prettier --check` pase en CI.

## Comprobaciones en los repositorios separados

Consulta remota de `main` el 2026-11-05:

| Repositorio | SHA de `main` | Estado observado |
|---|---|---|
| FT_HS | `1cc57796aabee446410146ad6475db2a780dbb10` | Un check `Vercel Preview Comments` finalizó correctamente; no es una ejecución de pruebas del frontend. |
| BK_HS | `190263da952afba5d4ce7f6c2d83c0fde2b239c4` | Sin check-runs ni contextos de estado visibles para ese SHA. |
| BD_HS | `42ee03b5906dfdcbd9e9f6c7f03ddc453250d23b` | Sin check-runs ni contextos de estado visibles para ese SHA. |
| Firmaware_HS | `2e5cfca7d0573e4225a07c6b7b13ea23e9570f4d` | Sin check-runs ni contextos de estado visibles para ese SHA. |
| DOCS_HS | `8ad8a018dd5d0875fa4b3360fa2071c1c4a2adde` | Sin check-runs ni contextos de estado visibles para ese SHA. |

La comprobación remota actual confirma que PT_HS `64e03d8` es el tag vigente y que su workflow está verde. Los demás componentes conservan los SHA exactos registrados en la tabla de `code-tag/README.md`; los tags, no los tips posteriores de `main`, son la versión usada para los ZIP del Release.

## Alcance y límites

La evidencia de CI registra las ejecuciones del proveedor para los SHA indicados; no acredita pruebas físicas del ESP32, funcionamiento actual de Brevo/Flespi/Neon, permisos de revisión, ni aceptación funcional de cada requisito. La instalación local de dependencias quedó reproducible mediante `npm ci` usando `BK_HS/package-lock.json` y `FT_HS/frontend/package-lock.json`; sus resultados detallados están en [test-plan-results.md](test-plan-results.md). La integración Flespi/TLS permanece omitida por falta de credencial externa.
