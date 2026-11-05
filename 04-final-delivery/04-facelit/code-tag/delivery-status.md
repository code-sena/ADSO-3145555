# FaceLit — delivery status

Updated 2026-11-05. The coordinator authorized delivery publication with the limitations below, without changes to any component `main`. Packaging completion is not instructor or runtime acceptance.

## Checklist

| Item | Status | Evidence / remaining limitation |
|---|---|---|
| 1. Folder and instructions | Completed | FaceLit delivery folder identified and guide reviewed with the team |
| 2. Fork | Prepared | `pemarival/ADSO-3145555`, delivery branch `entrega-final-facelit` |
| 3. Repository inventory | Completed | Five active components; unused empty repository retained for traceability |
| 4. Source in main | Team-confirmed snapshot | No main changed during finalization; deployment-only changes deferred |
| 5. Credentials | Closed in documented production scope | [Valery's operator record](credential-rotation-record.md); not independent production replay |
| 6. Installation | Partial final acceptance | Passing automatic retest has DB revision/harness differences; no positive camera test |
| 7. Visibility / write access | Partial | Five originals public; instructor invitations require effective-write confirmation |
| 8. Annotated tags | Completed | Five annotated tags retain the selected main commits |
| 9. ZIPs | Completed | Ten regenerated ZIPs; five full restores passed integrity/ref checks |
| 10. SHA-256 | Completed for these bytes | [ZIP manifest](SHA256SUMS.txt) |
| 11. Release | Authorized for publication | [final-delivery](https://github.com/pemarival/ADSO-3145555/releases/tag/final-delivery), subject to actual publication verification |
| 12. Links | Prepared | [Repository/tag/download inventory](README.md) |
| 13. Documents / PR | Integrated; review pending | [PR #10](https://github.com/code-sena/ADSO-3145555/pull/10); not merged or declared accepted |

## Selected source and annotated tags

See [archive verification](archive-verification.md) for exact main/tag object hashes and restored ref counts. The selected commits remain FaceLit `6efd92c`, backend `2ba7398`, DB `cd069ae`, micro-facial `166e4a7`, docs `2993404`. Replacing lightweight tags with annotations did not change their peeled commits.

The developer checkouts may still retain old local tags. Do not force-update local refs blindly. The archives use refreshed, verified mirrors, not those checkouts.

## Independent installation evidence received — partial

Responsible tester: María José Rodríguez Oyola. Delivery coordinator: Mariana Valenzuela Penagos.

The [initial execution record](../05-test-documentation/installation-execution-record.md) preserves incomplete startup/coordinator screenshots. The [new automatic report](../05-test-documentation/installation-verification/README.md) provides complete backend startup, successful migration, login/persistence/browser integration and ten passing coordinator tests with H2 and mocked email. Its second integral attempt passes with zero failures; its first failure is retained.

**The delivered source is not identical to the full tested setup:** DB test commit `096cd3e99d6936a7dacfe4b216b5e548f0a6eaf8` differs from delivery `cd069ae0cb4947d4b7ebbff17e9d6dc280ab86fd`. The passing browser retest uses an uncommitted test-harness correction, retained as evidence but not applied to main. Positive facial inference is deterministic; the real model's negative black-frame response is not positive recognition. No actual-camera, SMTP-delivery or Hostinger acceptance is asserted.

The coordinator explicitly chose unchanged main snapshots and publication with these limitations. See [full scope](../05-test-documentation/installation-final-scope.md). This does not mark point 6 passed, approve future commits or diagnose the old coordinator error.

## Received production rotation evidence

[Updated operator record](credential-rotation-record.md), attributed to Valery by the coordinator: JWT, internal facial key, PostgreSQL and Gmail replacement credentials accepted, old credentials rejected; final check reported 2026-11-05 05:07:46 Colombia. Gmail old app password returns SMTP 535. No email was sent. The historical Resend finding is classified as an example marker, not certification of an external account.

Item 5 is closed for these documented production credentials only. This agent did not replay production checks or verify exhaustive absence of secrets. Full-history ZIPs preserve historical source.

Earlier Gitleaks 8.30.1 scans of available Git refs found frontend UI translation false positives (5), backend historical authentication documentation matches (4), and zero DB/facial/docs matches. Prepared delivery directory scan found zero pattern matches at that earlier stage. Those scans predate the newly imported evidence and are not a complete binary/screenshot audit. GitHub secret scanning returned disabled/404, not zero alerts.

## Deployment scope

The team deliberately retained Hostinger-only changes locally and deferred their integration to a future update. ZIPs are GitHub source snapshots, not an exact reconstruction of the running VPS. The supplied report refers to a DB deployment commit `422aac6` and an uncommitted frontend batching adjustment; neither was invented or included from the narrative. Instructor acceptance of this limitation is not assumed.

## Documents, contributions and videos

The coordinator's authoritative Downloads document package supplied 106 non-code-tag files; original PDF bytes were preserved. New installation evidence (29 files) and contribution evidence (5 files) were imported byte-for-byte; the 28 installation-manifest hashes and four contribution hashes matched. The CSV has 677 rows; its contribution percentages count commits, not effort, rights or grades. See [contributions](../05-test-documentation/team-contributions/README.md). Personal authorizations remain unchecked.

[Both videos](https://drive.google.com/drive/folders/1xxpKgaNFhQJD3j3ghriaaXjS0GgABbkT) were listed in an unauthenticated folder response. Full playback/tutorial duration remain unverified. The known presentation duration is 4:31, outside the guide's 1–2 minute pitch range. See [video details](../10-videos/README.md).

## Remaining human acceptance

- A fresh permission check on 2026-11-05 still returns `read` for `ariel5253` on all five repositories. Confirm effective write after invitation acceptance; public visibility does not imply write.
- Accept or resolve installation/version/camera limitations with the tester and instructor; do not turn automatic fixtures into camera evidence.
- Confirm video requirements and individual data authorizations, applicant/declarations and instructor contribution fields.
- Review the PR; publication does not authorize merge or represent completed academic acceptance.
