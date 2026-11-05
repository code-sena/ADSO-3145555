# Archive verification — 2026-11-05

Ten delivery ZIPs were regenerated after the coordinator authorized replacing the five lightweight `final-delivery-2026` tags with annotated tags pointing to the same commits. No component `main` was changed. Publication is a delivery snapshot, not application acceptance.

## Contents and verification

- Source ZIP: `git archive` from the annotated tag, with a component-specific root directory. No untracked developer files or private local environment files are included.
- Full ZIP: bare mirror `<repo>.git/`, including remote-advertised branches, tags and history. The mirror was refreshed from GitHub before the authorized tag replacement.
- Each full ZIP was independently extracted, passed `git fsck --full --no-dangling`, and retained exactly the mirror's ref names/object IDs. Restored tags are annotated and peel to the unchanged main commits.
- Selected source trees were previously checked for submodules and LFS pointers. They did not change. Source ZIPs are regenerated from these same trees.
- Remote main hashes were checked again after tag publication. Each tag update used an exact old-object force-with-lease to avoid replacing a concurrent change.
- ZIP SHA-256 values are calculated from actual bytes in [SHA256SUMS.txt](SHA256SUMS.txt). Uploaded asset hashes and sizes are compared with those bytes before Release publication.

| Repository | Main / peeled commit | Annotated tag object | Restored refs |
|---|---|---|---|
| FaceLit | `6efd92cdd7e4e358b131cbe860cd8585d13e5550` | `dafb87be14f6fb4c455ea835f8e8f9e5b78ad082` | 171 |
| FaceLit-Backend | `2ba739853a808c8e5902f70eae98706a612f91e6` | `929f587efcc66128cbb433e01d2c7edcabb8145a` | 107 |
| FaceLit-DB | `cd069ae0cb4947d4b7ebbff17e9d6dc280ab86fd` | `df0c7e98c2435d21a09180286826f35372f4fd39` | 109 |
| micro-facial | `166e4a7f2245456277d57015259c678d8febfa9f` | `f580e46a98becef864193611f3bf975324b5bae6` | 47 |
| facelit-docs | `299340428bc7b04fa013cd1b4d034f673b9d3dbc` | `da82e14e775bfc315544539cee720d2b0cc9e61a` | 4 |

## Uploaded asset verification

Before publication, GitHub Release ID `434892695` returned exactly ten uploaded ZIP assets. Each asset's `sha256:` digest and byte count matched its regenerated local archive. No candidate archive remains among these ten uploads. This verifies transfer integrity, not application acceptance.

## Restoring a component

Extract a full export outside any existing checkout. For example:

```powershell
git clone .\FaceLit.git .\FaceLit-restored
git -C .\FaceLit-restored switch main
git -C .\FaceLit-restored cat-file -t refs/tags/final-delivery-2026
```

The extracted bare mirror preserves the complete archived refs. An ordinary clone checks out only one branch. Do not delete project directories or database volumes.

## Scope

These archives do not back up GitHub issues, permissions, PR discussions, Actions logs, external dependencies/models or private VPS configuration. Historical source may contain past credential examples; the production rotation record is [documented separately](credential-rotation-record.md). Integrity is not proof of security or runtime acceptance.

The delivered DB commit differs from Persona 2's tested DB commit; her passing browser test also uses an uncommitted runner correction not applied here. Positive real-camera recognition was not tested. Hostinger contains deployment-only adjustments deferred by the team. See [installation scope](../05-test-documentation/installation-final-scope.md) and [current status](delivery-status.md).
