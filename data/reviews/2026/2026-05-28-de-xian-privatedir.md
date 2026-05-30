---
date: 2026-05-28
batch: de-hardcode brain origin + private-dir resolution (issue #5)
review-stack: claude (general-purpose subagent, fresh context)
scope: working-tree diff — skill bundle, atlas, README, templates, 6 candidate profiles, scripts/private-dir.sh
result: pass-after-fixes
---

# Review — de-Xian-ification + private-dir resolution (#5)

Fresh-context review gate (per [[review]]) over the issue #5 diff before committing
shared-substrate changes.

## Checklist outcome

| # | Item | Result |
|---|------|--------|
| 1 | No privacy leaks in shared substrate | FAIL → fixed (C1) |
| 2 | Excision integrity (the 5 named profiles) | PASS |
| 3 | De-hardcoding completeness | FAIL → fixed (I1, I2) |
| 4 | Resolver correctness (`scripts/private-dir.sh`) | PASS (M1 contract gap fixed) |
| 5 | Internal consistency across docs | PASS (after I1/I2) |
| 6 | Other | M2 (defensive .gitignore) added |

## Findings + resolution

- **C1 (Critical) — privacy leak survivor.** `data/candidates/.../district-attorney/daniel-chung.md`
  still carried a full `## Scoring (county-district-attorney template)` section + a
  "For a Palo Alto voter…" verdict — the same-race opponent of jeff-rosen (whose read I'd
  already excised). Missed because daniel-chung framed it generically (no "Xian" token).
  **Fixed:** excised the scoring section (Endorsements → Controversies now). Re-ran a
  pattern-based scan (`## Scoring`/`## Axis`/`Summary read`/`For a … voter`/`| Axis |`/
  `Weighted…`) across **all** candidate profiles — daniel-chung was the last one.
- **I1 (Important).** `you-decide/identify-controversies.md:28` had operative path
  `data/life/politics/controversies/...` + "cached in shared brain". **Fixed** →
  `data/controversies/<year>/<state>.md` (shared substrate).
- **I2 (Important).** `you-decide/resolve-ballot.md:20,231` had operative
  `data/life/politics/{elections,candidates}/...` paths contradicting the file's own body.
  **Fixed** → repo-root-relative.
- **M1 (Minor).** `scripts/private-dir.sh` printed a relative `$YOU_DECIDE_PRIVATE_DIR`
  verbatim, breaking the "absolute path" contract. **Fixed** → normalize via logical
  `cd … && pwd` after `mkdir`.
- **M2 (Minor).** Added defensive `who-to-vote-for/` to `.gitignore` (guards a mis-set
  env var pointing inside the checkout).

## Post-fix verification

- No embedded read/scoring/verdict sections remain in `data/candidates/`.
- No "Xian" token in `data/candidates/`, `data/elections/`, `data/controversies/`, `data/sources/`,
  `you-decide/`, `atlas/`, `README.md`.
- Remaining `data/life/politics/...` mentions are all intentional brain-install-mode
  references (how to point `$YOU_DECIDE_PRIVATE_DIR` at a brain), not operative paths.
- Resolver: `bash -n` clean; default → `<repo-root>/../who-to-vote-for`; env override
  honored + normalized to absolute; brain-symlink logical coincidence preserved.
