# Archive preparation and verification

Status: **review candidates, not final acceptance**. Prepared on 2026-11-05 from fresh GitHub mirror clones of the five public component repositories.

The snapshots preserve the existing `final-delivery-2026` references. Those references are currently lightweight tags. Creating these backups does not satisfy the annotated-tag requirement or certify installation and credential rotation. Regenerate the affected archives and hashes after any final ref/source change, and verify the uploads again before publication.

## Contents

- `<repo>-final-delivery-2026-main.zip`: source tree produced by `git archive` from `final-delivery-2026`, after checking that the peeled tag commit equals the expected remote `main` commit. A single top-level directory identifies the component. No local `.env`, untracked file or developer working directory is copied.
- `<repo>-full-export.zip`: a bare mirror directory `<repo>.git/`, including all refs and the Git object database available through the public clone. It is created with the .NET ZIP API, not a working-tree ZIP, so hidden files are not silently omitted.
- The full export contains historical source. Historical credentials may remain and require owner confirmation of revocation/rotation before public release.
- GitHub issues, pull-request discussions, permissions, Actions logs, Releases, external model downloads and external deployment configuration are not part of a Git repository mirror. These ZIPs must not be described as backups of the entire GitHub service or VPS.

## Checks performed by the preparation script

1. Clone each public repository with `git clone --mirror` into a fresh directory. After a stalled backend transfer, use local objects as a read-only optimization through `--reference-if-able --dissociate`; verify that no `objects/info/alternates` remains. Only refs advertised by the remote are cloned, and the result must not depend on the developer checkout.
2. Check `refs/heads/main` and `final-delivery-2026^{commit}` against the selected source revision. Abort on a mismatch.
3. Check the tagged tree for submodules and Git LFS pointers; abort if extra content handling is required.
4. Generate the source ZIP and inspect its entries for the expected prefix and unsafe parent-directory paths.
5. Generate the mirror ZIP, extract it into a separate verification directory and run `git fsck --full --no-dangling` against the restored mirror.
6. Compare every restored ref name and object ID with the original mirror.
7. Calculate SHA-256 from the actual ZIP bytes. ZIP hashes are unrelated to the SHA-256 of the presentation video.
8. Keep the Release unpublished. Compare GitHub's per-asset `sha256:` digest and byte count with the local archive; if the server digest is unavailable, download the asset into a separate verification directory and compare its SHA-256 before recording upload verification.

## Completed local restoration checks

All ten candidate ZIPs were created successfully. Each restored full mirror passed Git object-integrity verification and exact ref comparison. No submodules or Git LFS pointers requiring separate archival were found in the selected tagged trees.

| Component | Main/tagged source commit | Restored refs | Tagged source files |
|---|---|---|---|
| FaceLit | `6efd92cdd7e4e358b131cbe860cd8585d13e5550` | 171 | 289 |
| FaceLit-Backend | `2ba739853a808c8e5902f70eae98706a612f91e6` | 107 | 316 |
| FaceLit-DB | `cd069ae0cb4947d4b7ebbff17e9d6dc280ab86fd` | 109 | 192 |
| micro-facial | `166e4a7f2245456277d57015259c678d8febfa9f` | 47 | 51 |
| facelit-docs | `299340428bc7b04fa013cd1b4d034f673b9d3dbc` | 4 | 169 |

The ref count includes every ref advertised to the mirror clone, not only development branches. The ZIP SHA-256 manifest is [SHA256SUMS.txt](SHA256SUMS.txt). These counts and hashes describe this snapshot and do not establish final acceptance.

## Upload integrity

All ten candidate ZIPs are attached to the unpublished `final-delivery` Release (ID `434892695`). GitHub returned a per-asset `sha256:` digest and byte count for each upload; all ten matched the locally computed ZIP hash and size. No download/reupload or file replacement was needed. The Release remains unpublished, and the candidate checksums must be recalculated if an archive is regenerated after final source/tag changes.

## Restoring a component

For example, extract `FaceLit-full-export.zip` outside an existing checkout. The result is a bare mirror named `FaceLit.git`, not an application directory. To obtain a working copy:

```powershell
git clone .\FaceLit.git .\FaceLit-restored
git -C .\FaceLit-restored switch main
git -C .\FaceLit-restored log -1 --oneline
```

The original extracted mirror retains all archived branches and tags; an ordinary clone checks out only one branch and exposes other branches through its remote-tracking refs. Do not delete existing project folders or database volumes as part of this verification.

## Acceptance limits

Successful Git integrity/ref restoration is not an application installation test. The current candidates must not be published as an approved final version until the outstanding items in [delivery-status.md](delivery-status.md) are resolved. Hashes in [SHA256SUMS.txt](SHA256SUMS.txt) identify specific archive bytes; matching a hash is not approval of the source or its credentials.
