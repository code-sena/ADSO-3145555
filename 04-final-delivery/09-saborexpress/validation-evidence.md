# Validation evidence / Evidencia de validación

This file separates evidence that is already reproducible from checks that require a live environment, private credentials or a physical device. It prevents a proposed test from being presented as a completed result.

Este archivo separa la evidencia reproducible de las verificaciones que requieren ambiente activo, credenciales privadas o dispositivo físico. Una prueba propuesta no se presenta como resultado completado.

## Version under evaluation / Versión evaluada

| Item / Elemento | Value / Valor |
|---|---|
| Delivery tag / Tag de entrega | `final-delivery-2026` |
| Fork delivery commit / Commit de entrega del fork | `b85a40e` |
| PR / Pull Request | [code-sena/ADSO-3145555 #18](https://github.com/code-sena/ADSO-3145555/pull/18) |
| Release | [final-delivery](https://github.com/yersonct/ADSO-3145555/releases/tag/final-delivery) |
| API tag | `e30d24af10be757bee9e08993a5ac970d6173211` |
| Docs tag | `61ae5cdca9319852d605d52be11883f1a2769929` |
| Mobile tag | `91a59b090f5716c58dfb9229b0509af23593077e` |
| Web tag | `582b7148bc2aa84bb4c76a24aa6b0b6122e9f189` |

## Correction branches / Ramas de corrección

The code corrections are now merged into `main`, and `final-delivery-2026` points to the corrected main commit in each repository.

Las correcciones de código ya están fusionadas en `main`, y `final-delivery-2026` apunta al commit corregido de `main` en cada repositorio.

| Repository / Repositorio | Main commit / Commit de main | Tag |
|---|---|---|
| [SaborExpressBack](https://github.com/yersonct/SaborExpressBack) | `e30d24a` | `final-delivery-2026` |
| [SaborExpressDocs](https://github.com/yersonct/SaborExpressDocs) | `61ae5cd` | `final-delivery-2026` |
| [SaborExpressMovil](https://github.com/yersonct/SaborExpressMovil) | `91a59b0` | `final-delivery-2026` |
| [SaborExpressWeb](https://github.com/yersonct/SaborExpressWeb) | `582b714` | `final-delivery-2026` |

## Reproducible repository checks / Verificaciones reproducibles

| Check / Verificación | Evidence / Evidencia | Status / Estado |
|---|---|---|
| Public source repositories | Four repository links in `code-tag/README.md` | Ready to reproduce / Lista para reproducir |
| Release assets | Eight ZIP assets linked in `code-tag/README.md` | Uploaded / Subidos |
| SHA-256 integrity | `code-tag/SHA256SUMS.txt` | Recorded / Registrada |
| PR scope | PR #18 contains only `04-final-delivery/09-saborexpress` | Verified / Verificado |
| Main CI | Backend, web, mobile and secret-scan workflows have recent successful runs on the published main commits | Verified in GitHub / Verificado en GitHub |

## Commands / Comandos

Run the following from clean clones at the tags. Do not use production secrets in the working tree.

Ejecute lo siguiente desde clones limpios en los tags. No escriba secretos de producción en el árbol de trabajo.

```powershell
git clone --branch final-delivery-2026 https://github.com/yersonct/SaborExpressBack.git
git clone --branch final-delivery-2026 https://github.com/yersonct/SaborExpressDocs.git
git clone --branch final-delivery-2026 https://github.com/yersonct/SaborExpressMovil.git
git clone --branch final-delivery-2026 https://github.com/yersonct/SaborExpressWeb.git

dotnet restore SaborExpressBack/SaborExpress.csproj
dotnet test SaborExpressBack/tests/SaborExpressBack.Security.Tests/SaborExpressBack.Security.Tests.csproj --configuration Release
dotnet test SaborExpressBack/tests/SaborExpressBack.QA.Tests/SaborExpressBack.QA.Tests.csproj --configuration Release
dotnet test SaborExpressBack/tests/SaborExpressBack.InvoicePdf.Tests/SaborExpressBack.InvoicePdf.Tests.csproj --configuration Release

Push-Location SaborExpressWeb; npm ci; npm run lint; npm run typecheck; npm test; npm run build; npm run test:e2e; Pop-Location
Push-Location SaborExpressMovil; npm ci; npm run lint; npm run typecheck; npm test; npm run build; Pop-Location
```

## Evidence still required / Evidencia que todavía debe producirse

The following rows are intentionally not marked as passed because the repository does not contain a real execution receipt for the exact final tags:

Las siguientes filas no se marcan como aprobadas porque el repositorio no contiene un comprobante de ejecución real para los tags finales exactos:

- Clean lift with migrations and seed data from each final tag.
- Login for every declared role with sanitized test accounts.
- End-to-end web/mobile flows through the API and database.
- Negative security cases, cross-branch authorization and failure recovery.
- Measured coverage with a published threshold of at least 70%.
- Physical Android, Bluetooth, printer, QR and reconnection tests.
- Production/staging receipts for the exact final commits.
- Final institutional confirmation of authorship, ownership and third-party licenses.

Only the evaluator or the team member with access to the corresponding environment can close those rows without fabricating evidence.
