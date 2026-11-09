# Individual contribution report / Informe individual de contribución

**Apprentice / Aprendiz:** Yerson Stiven Cuellar Rubiano  
**GitHub:** `yersonct`  
**Period / Periodo:** 2026-09-14 to 2026-11-08  
**Repositories / Repositorios:** SaborExpressBack, SaborExpressDocs, SaborExpressMovil and SaborExpressWeb

This report is based on the Git history available in the four repositories. It does not infer work from file ownership, and it does not count commits by other people as Yerson's contribution.

Este informe se basa en el historial Git disponible en los cuatro repositorios. No infiere trabajo por la propiedad de archivos y no cuenta como aporte de Yerson los commits de otras personas.

## Eight-week activity heatmap / Mapa de actividad de ocho semanas

The counts include non-merge commits authored by a matching `yerson` identity in the repository history. A zero is retained explicitly.

Los conteos incluyen commits que no son merge y que fueron escritos por una identidad coincidente con `yerson` en el historial. Los ceros se conservan explícitamente.

| Week / Semana | Date range / Rango | Back | Docs | Mobile | Web | Total |
|---|---|---:|---:|---:|---:|---:|
| W1 | 2026-09-14 — 2026-09-20 | 0 | 0 | 0 | 0 | 0 |
| W2 | 2026-09-21 — 2026-09-27 | 0 | 0 | 0 | 0 | 0 |
| W3 | 2026-09-28 — 2026-10-04 | 0 | 0 | 0 | 0 | 0 |
| W4 | 2026-10-05 — 2026-10-11 | 7 | 0 | 1 | 4 | 12 |
| W5 | 2026-10-12 — 2026-10-18 | 4 | 4 | 5 | 4 | 17 |
| W6 | 2026-10-19 — 2026-10-25 | 32 | 0 | 5 | 11 | 48 |
| W7 | 2026-10-26 — 2026-11-01 | 2 | 1 | 1 | 2 | 6 |
| W8 | 2026-11-02 — 2026-11-08 | 20 | 31 | 3 | 4 | 58 |

## Net contribution by repository / Aporte neto por repositorio

| Repository / Repositorio | Evidence observed / Evidencia observada |
|---|---|
| SaborExpressBack | Architecture, authentication and session security, branch/role isolation, payments, invoice PDF, operational workflows, CI and release gates. |
| SaborExpressDocs | Requirements, traceability, research article, manuals, test plan, API/database records and closure evidence. |
| SaborExpressMovil | Expo architecture, authentication/session handling, cashier/order flows, translations, printer and Bluetooth workflows, CI. |
| SaborExpressWeb | Next.js architecture, responsive multilingual flows, authentication/SignalR staging proxy, accessibility, E2E and CI. |

## Representative chronology / Cronología representativa

The complete chronology remains reproducible with the following command from each repository:

```powershell
git log --all --author=yerson --no-merges --date=short --format="%ad|%h|%s"
```

Representative final-period entries include:

- Backend: `17a8ce4` (CORS validation), `7d515ff` (effective table privileges), `7116551` (branch access), `d5ad56a` and `c6e340a` (refresh-token security), `e925232` (staging diagnostics).
- Documentation: `480a30f` (traceability scan), `5ff7982` (HU status), `2b5c260` (article alignment), `5217bc6` (PostgreSQL validation).
- Mobile: `af52bba` (redacted API errors), `742485f` (EAS secret handling), `cbb461d` (Android export evidence).
- Web: `aa5cb8d` (safe API errors), `b2debd1` (configurable E2E ports), `6d3fdba` (staging auth and SignalR proxy).

## PR and review evidence / Evidencia de PR y revisiones

The final-delivery PR is [code-sena/ADSO-3145555 #18](https://github.com/code-sena/ADSO-3145555/pull/18). The public package records the PR and repository links, but it does not claim an independent review that is not present in the GitHub history. The evaluator can add review comments and approvals to the private assessment record.

El PR de entrega final es [code-sena/ADSO-3145555 #18](https://github.com/code-sena/ADSO-3145555/pull/18). El paquete público registra el PR y los enlaces de repositorio, pero no afirma una revisión independiente que no aparezca en el historial de GitHub. El evaluador puede agregar comentarios y aprobaciones en el registro privado de evaluación.

## Scope note / Nota de alcance

This is a contribution report, not a legal declaration. The final individual score remains the evaluator's decision under the rubric, including quality, role coherence and collaboration evidence.

Este es un informe de contribución, no una declaración legal. La calificación individual final corresponde al evaluador según la rúbrica, incluidos calidad, coherencia del rol y evidencia de colaboración.
