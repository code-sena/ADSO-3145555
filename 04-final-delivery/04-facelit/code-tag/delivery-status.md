# FaceLit delivery verification

Verification date: 2026-11-05. This report distinguishes completed checks from pending acceptance; it is not a declaration that the final version has been approved.

## User-supplied documentary package

The user designated `Downloads/04-facelit/04-facelit` as the authoritative delivery document set. Its 106 files outside `code-tag/` were copied byte-for-byte and checked by SHA-256. The two `code-tag/` templates were not used to overwrite the already verified repository, invitation and security status. Superseded files from the previous preparation were moved to a temporary recovery backup, not mixed into this document set. The original Downloads package is unchanged.

The supplied [delivery review](../delivery-review.md) records document provenance, installation-evidence limitations and differences between the reported deployment package and remote source revisions. These differences must be reconciled before asserting that the final source tags reproduce the deployed system.

The provided presentation video was identified locally: 270.8333 seconds (4 min 31 s), 215,064,307 bytes; SHA-256 `fb001eae8199b6174aab1e6ed2a2485ac3d62243c4a9a2594332810eafc6bc0d`. It is not committed or uploaded. Its public Drive link and classification as pitch/tutorial remain pending. Its duration is outside the guide's 1-2 minute pitch range.

## Source revisions and CI

| Repository | Remote main commit | CI evidence for that commit |
|---|---|---|
| FaceLit | `6efd92cdd7e4e358b131cbe860cd8585d13e5550` | [Successful run](https://github.com/FaceID-Proyect-2026/FaceLit/actions/runs/41781364166) |
| FaceLit-Backend | `2ba739853a808c8e5902f70eae98706a612f91e6` | [Successful run](https://github.com/FaceID-Proyect-2026/FaceLit-Backend/actions/runs/41781369880) |
| FaceLit-DB | `cd069ae0cb4947d4b7ebbff17e9d6dc280ab86fd` | [Successful run](https://github.com/FaceID-Proyect-2026/FaceLit-DB/actions/runs/41928525520) |
| micro-facial | `166e4a7f2245456277d57015259c678d8febfa9f` | [Successful run](https://github.com/FaceID-Proyect-2026/micro-facial/actions/runs/41781416826) |
| facelit-docs | `299340428bc7b04fa013cd1b4d034f673b9d3dbc` | No Actions run returned for main at the time of inspection |

Remote commits were checked through the GitHub API. Successful CI does not establish a clean installation by the independent tester, credential rotation, camera acceptance or SMTP delivery.

## Repository visibility and instructor access

All five active repositories are public. Write invitations were sent to `ariel5253` on 2026-11-05. The invitations are pending acceptance; the permissions endpoint still reports read access. Do not mark write access as effective until the invitation is accepted and rechecked.

| Repository | Invitation ID | Requested permission |
|---|---|---|
| FaceLit | 341662667 | write |
| FaceLit-Backend | 341662702 | write |
| FaceLit-DB | 341662733 | write |
| micro-facial | 341662766 | write |
| facelit-docs | 341662803 | write |

The empty, unused repository remains listed for traceability and is not a source component.

## Security and finalization gates

- No real `.env` file was found in the tracked files of the five current local main checkouts during the initial review.
- Sensitive variable names were found in historical environment files/examples. Their presence is not proof that the values were used in a real environment.
- Credential rotation or revocation has not been confirmed by the environment owners. Do not publish a complete-history archive as security-approved until this is resolved.
- Historical backend documentation contains a JWT signing-secret assignment and token examples requiring review. Values must not be copied into this report.
- Automatic scanner matches must be triaged: frontend UI translation keys are not credentials.
- Gitleaks 8.30.1 was downloaded from its official release, its ZIP SHA-256 was checked against the release checksum manifest, and all locally available Git refs were scanned with `--log-opts=--all --redact=100` on 2026-11-05. Results: FaceLit 5 matches (UI translation-key literals, false positives on inspection); backend 4 matches in historical authentication documentation (a signing-secret assignment and token examples, owner review pending); DB 0; micro-facial 0; documentation 0. This is a pattern-based scan, not proof that all passwords were detected or rotated. Reports remain local and no secret values are published.
- Text extraction from 27 source PDFs found no matches for the selected private-key, GitHub-token, JWT-token and sensitive-environment-assignment patterns. This does not audit text inside screenshots, personal-data consent or document layout. The older SRS V3 had one page without extractable text and is not the current requirements source.
- The earlier PDF extraction applies to the repository-documentation source inspected before the Downloads package replaced that preparation; it must not be read as a complete extraction audit of the replacement PDFs.
- Gitleaks also scanned the prepared Downloads-based delivery directory on 2026-11-05 with fully redacted output: 0 matches. Binary or screenshot text, credential rotation and independent installation are not certified by this result. Three sample role screenshots were visually checked and contained visible masks over identifying fields; this is not a complete audit of all evidence.
- Existing `final-delivery-2026` references are lightweight tags, not annotated tags. Their public references have not been changed by this preparation.
- The remote documentation tag currently points to `2993404`; the local documentation tag still points to `91dd4b7`. Do not force-update either without reviewing the intended final commit.
- Final annotated tags, ten final ZIP archives, checksums and a published final Release remain pending the installation/security gates.

## Independent installation record required

Responsible tester: Maria Jose Rodriguez Oyola. Delivery coordinator: Mariana Valenzuela Penagos (`pemarival`).

Attach a redacted record stating date, clean environment, component commits, installation commands, migration outcome, first-account setup, login, authorized facial registration and attendance, persistence and any relevant email test. Include failures and the successful retest after corrections. Historical CI or a working production site does not replace this test.

## Team input still required

1. Confirmation of real credential revocation/rotation, without disclosing values.
2. Independent clean-installation evidence and acceptance from the tester.
3. Public links to the advertising pitch and the usage tutorial, with durations.
4. Actual contributor roles, individual authorization of preloaded personal data, and registration applicant/declarations confirmed by the team/instructor. These fields must not be inferred or checked on someone's behalf.

ZIP links and SHA-256 entries must refer to actual, verified assets, never planned filenames represented as published downloads.
