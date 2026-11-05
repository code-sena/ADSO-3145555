# FaceLit delivery verification

Verification date: 2026-11-05. This report distinguishes completed checks from pending acceptance; it is not a declaration that the final version has been approved.

## User-supplied documentary package

The user designated `Downloads/04-facelit/04-facelit` as the authoritative delivery document set. Its 106 files outside `code-tag/` were copied byte-for-byte and checked by SHA-256. The two `code-tag/` templates were not used to overwrite the already verified repository, invitation and security status. Superseded files from the previous preparation were moved to a temporary recovery backup, not mixed into this document set. The original Downloads package is unchanged.

The supplied [delivery review](../delivery-review.md) records document provenance, installation-evidence limitations and differences between the reported deployment package and remote source revisions. The team has confirmed that these differences are intentional for this delivery; no exact equivalence between the source tags and the deployed system is claimed.

### Team-confirmed delivery scope — 2026-11-05

The delivery coordinator confirmed that her colleague deliberately retained the additional deployment adjustments locally to avoid last-minute project changes. The team is delivering the current remote `main` revisions and defers integrating those adjustments for reconstruction on another VPS to a future update. No further changes to the component `main` branches were reported.

Accordingly, the prepared ZIPs represent the selected GitHub source, not an exact export of the running Hostinger deployment. This is an explicit delivery limitation, not evidence that the deployed-only adjustments are included in the archives. Existing ZIP bytes and SHA-256 values are unchanged by this documentary clarification. It does not establish instructor acceptance of the limitation or replace independent installation verification of the delivered source.

The provided presentation video was identified locally: 270.8333 seconds (4 min 31 s), 215,064,307 bytes; SHA-256 `fb001eae8199b6174aab1e6ed2a2485ac3d62243c4a9a2594332810eafc6bc0d`. The user confirmed that it is the presentation video and supplied [this Drive folder](https://drive.google.com/drive/folders/1xxpKgaNFhQJD3j3ghriaaXjS0GgABbkT). It is not committed to Git. The user subsequently confirmed that the same folder contains the separate usage tutorial. A new unauthenticated HTTP request on 2026-11-05 returned 200 and showed both `Presentación FaceLit.mp4` and `Tutorial.mp4`. Both video links have now been supplied and their names are visible without signing in. Full playback, tutorial duration/content and byte-for-byte comparison with remote files remain unverified. The known local presentation duration remains outside the guide's 1-2 minute pitch range.

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

All five active repositories are public. Write invitations were sent to `ariel5253` on 2026-11-05. A subsequent check on the same date still returned read access for all five repositories, so invitation acceptance remains pending. Do not mark write access as effective until the invitation is accepted and rechecked.

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
- Follow-up verification on 2026-11-05 found no root `.env`, `.env.local`, `.env.production` or `liquibase.properties` in the five inspected Desktop checkouts, and no owner-provided rotation record was available. README rotation instructions are procedures, not evidence that the operation occurred.
- The GitHub secret-scanning alerts API was queried for all five repositories, returning HTTP 404 with "Secret scanning is disabled on this repository" in each case. This is not a zero-alert result and provides no revocation evidence. No scanning setting, provider credential or production configuration was changed during this check.
- To close item 5, the environment owner must identify which historical values were real (versus unused examples) and confirm revocation/rotation by credential category, environment and date, without disclosing values. Relevant categories include JWT signing material, the shared internal facial-service key, database credentials, and any provider key such as Resend that was actually exposed and used. Retired seeded account credentials also require explicit review if they were used in a real environment. Do not claim that deleting files or changing example values revoked any of these credentials.
- Historical backend documentation contains a JWT signing-secret assignment and token examples requiring review. Values must not be copied into this report.
- Automatic scanner matches must be triaged: frontend UI translation keys are not credentials.
- Gitleaks 8.30.1 was downloaded from its official release, its ZIP SHA-256 was checked against the release checksum manifest, and all locally available Git refs were scanned with `--log-opts=--all --redact=100` on 2026-11-05. Results: FaceLit 5 matches (UI translation-key literals, false positives on inspection); backend 4 matches in historical authentication documentation (a signing-secret assignment and token examples, owner review pending); DB 0; micro-facial 0; documentation 0. This is a pattern-based scan, not proof that all passwords were detected or rotated. Reports remain local and no secret values are published.
- Text extraction from 27 source PDFs found no matches for the selected private-key, GitHub-token, JWT-token and sensitive-environment-assignment patterns. This does not audit text inside screenshots, personal-data consent or document layout. The older SRS V3 had one page without extractable text and is not the current requirements source.
- The earlier PDF extraction applies to the repository-documentation source inspected before the Downloads package replaced that preparation; it must not be read as a complete extraction audit of the replacement PDFs.
- Gitleaks also scanned the prepared Downloads-based delivery directory on 2026-11-05 with fully redacted output: 0 matches. Binary or screenshot text, credential rotation and independent installation are not certified by this result. Three sample role screenshots were visually checked and contained visible masks over identifying fields; this is not a complete audit of all evidence.
- Existing `final-delivery-2026` references are lightweight tags, not annotated tags. Their public references have not been changed by this preparation.
- The remote documentation tag currently points to `2993404`; the local documentation tag still points to `91dd4b7`. Do not force-update either without reviewing the intended final commit.
- Final annotated tags, approval of the final archive snapshot and public Release publication remain pending the installation/security gates. Ten current review-candidate ZIPs and their actual checksums are now prepared, restored/verified and uploaded to the unpublished draft; they are not accepted as final annotated-tag exports.

## Candidate archives and draft Release

Ten review ZIPs were prepared from fresh public mirrors, with peeled tag commits checked against the selected `main` revisions. Each full-export ZIP was restored independently, passed `git fsck --full --no-dangling` and retained identical ref names/object IDs. The five source ZIP commit comments also match the selected commits. Local object reuse, where used, was followed by `--dissociate` and verification that no external alternates remained.

All ten files are attached to the unpublished `final-delivery` draft in the [fork's Releases list](https://github.com/pemarival/ADSO-3145555/releases), Release ID `434892695`. Draft preview URLs can change when the draft is edited; the owner can locate it by this name and ID while signed in. For every uploaded file, GitHub's SHA-256 digest and byte count matched the actual local ZIP. The checksums are recorded in [SHA256SUMS.txt](SHA256SUMS.txt); detailed scope/ref counts and restoration instructions are in [archive-verification.md](archive-verification.md).

The Release remains a draft. These assets preserve the current lightweight tags and must be regenerated as necessary after final tag/source changes. No public final-download links are claimed. Integrity and upload checks do not certify credential revocation or independent application installation.

The supplied deployment document reports a DB commit `422aac6` and an uncommitted frontend batching adjustment. The DB commit was not found in the inspected local checkout, and the referenced deployment package/manifests were not found in the four component directories or the checked Downloads files. The team subsequently confirmed that the deployment-only adjustments will be integrated in a future update. Those artifacts were not invented or reconstructed from the narrative; exact reconstruction of the current Hostinger deployment from these ZIPs is not claimed.

## Independent installation record required

Responsible tester: Maria Jose Rodriguez Oyola. Delivery coordinator: Mariana Valenzuela Penagos (`pemarival`).

Attach a redacted record stating date, clean environment, component commits, installation commands, migration outcome, first-account setup, login, authorized facial registration and attendance, persistence and any relevant email test. Include failures and the successful retest after corrections. Historical CI or a working production site does not replace this test.

## Team input still required

1. Confirmation of real credential revocation/rotation, without disclosing values.
2. Independent clean-installation evidence and acceptance from the tester.
3. Resolve the presentation/pitch duration requirement and verify the tutorial's duration/content and full playback of both files. Both video links have been supplied in the same anonymously accessible folder; the tutorial is no longer missing.
4. Actual contributor roles, individual authorization of preloaded personal data, and registration applicant/declarations confirmed by the team/instructor. These fields must not be inferred or checked on someone's behalf.

ZIP links and SHA-256 entries must refer to actual, verified assets, never planned filenames represented as published downloads.
