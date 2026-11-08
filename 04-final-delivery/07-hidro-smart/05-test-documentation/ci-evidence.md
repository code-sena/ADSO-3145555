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

## Candidato local `final-delivery-2026` consultado el 2026-11-07

La verificación local confirmó que el tag `final-delivery-2026` apunta al `main` local en los seis repositorios incluidos. Esta tabla no sustituye la consulta remota de GitHub ni demuestra que los workflows se hayan ejecutado sobre estos SHA.

| Repositorio | SHA local de `main` y tag | Estado de CI para el candidato |
|---|---|---|
| PT_HS | `8dd45ca349134ad0851a536af5f90760b10691f3` | No revalidado remotamente |
| BK_HS | `190263da952afba5d4ce7f6c2d83c0fde2b239c4` | No revalidado remotamente |
| FT_HS | `91a5ef3125ed73d4d9d410f772b54923f8099430` | No revalidado remotamente |
| BD_HS | `42ee03b5906dfdcbd9e9f6c7f03ddc453250d23b` | No revalidado remotamente |
| Firmaware_HS | `917fcfd2129ea6ff92860a4321b1fd7863957d85` | No revalidado remotamente |
| DOCS_HS | `054a063a667f637a55b3641f83a9e4dded1faa5b` | No revalidado remotamente |

## Comprobaciones en los repositorios separados

Consulta remota de `main` el 2026-11-05:

| Repositorio | SHA de `main` | Estado observado |
|---|---|---|
| FT_HS | `1cc57796aabee446410146ad6475db2a780dbb10` | Un check `Vercel Preview Comments` finalizó correctamente; no es una ejecución de pruebas del frontend. |
| BK_HS | `190263da952afba5d4ce7f6c2d83c0fde2b239c4` | Sin check-runs ni contextos de estado visibles para ese SHA. |
| BD_HS | `42ee03b5906dfdcbd9e9f6c7f03ddc453250d23b` | Sin check-runs ni contextos de estado visibles para ese SHA. |
| Firmaware_HS | `2e5cfca7d0573e4225a07c6b7b13ea23e9570f4d` | Sin check-runs ni contextos de estado visibles para ese SHA. |
| DOCS_HS | `8ad8a018dd5d0875fa4b3360fa2071c1c4a2adde` | Sin check-runs ni contextos de estado visibles para ese SHA. |

## Alcance y límites

La evidencia de CI registra las ejecuciones del proveedor para los SHA indicados; no acredita pruebas físicas del ESP32, funcionamiento actual de Brevo/Flespi/Neon, permisos de revisión, ni aceptación funcional de cada requisito. Las consultas de estado son un corte remoto del 2026-11-05; volver a verificarlas si cambia un SHA. La instalación local de dependencias para repetir las pruebas se bloqueó por errores de permisos de npm, por lo que no se presenta un resultado local nuevo. La entrega debe enlazar resultados a cada caso y a los SHA exactos que finalmente se aprueben.
