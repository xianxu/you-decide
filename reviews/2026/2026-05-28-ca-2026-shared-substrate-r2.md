---
batch: ca-2026-shared-substrate-r2
date: 2026-05-28
reviewer-stack: codex
producing-stack: claude
scope: all-shared-diff
base-review: reviews/2026/2026-05-28-ca-2026-shared-substrate.md
fix-commit: fccab28236a8789d29bc7c4e0c379623a87a0c57
files-reviewed: 8
issues-blocker: 0
issues-important: 2
issues-minor: 0
status: issues-flagged
---

# Review - ca-2026-shared-substrate r2

Diff-scoped re-review of Claude's fix commit `fccab28236a8789d29bc7c4e0c379623a87a0c57`, per `you-decide/review.md` commit-per-handoff protocol.

Reviewed only whether the r1 findings were addressed and whether the fixes introduced regressions. This was not a fresh full audit of all CA 2026 substrate.

## Issues Found

### blocker

None. The r1 blocker findings are cleared.

Confirmed:

- `elections/2026/2026-06-02-CA-primary.md` no longer overclaims certified-complete statewide coverage.
- The manifest now explicitly labels viability-filtered candidate lists and names omitted statewide offices as a gap.
- US House D16 now includes Sam Liccardo, Kevin Johnson, Peter Sundin Soule, and Jotham Stein with resolving slugs.
- Assembly D23 now includes Marc Berman, Rick Giorgetti, and David G. Johnson with resolving slugs.
- Supervisor D5 is no longer marked TBD; it is marked not on the 2026-06-02 ballot with an official-roster note.
- `controversies/2026/CA.md` now uses repo-relative `candidates/2026/CA/` and notes 39 profiles.
- `[[trump-era-cater-discount]]` now resolves via `you-decide/calibration-skills/trump-era-cater-discount.md`.

### important

#### `candidates/2026/CA/us-house-d15/kevin-mullin.md` - party-line characterization still asserted

The new data-gap section correctly says no party-unity / independence score was retrieved and that no voting-independence characterization is asserted. But the Controversies section still says:

> No notable independence from caucus: Appears to be a reliable party-line vote. No documented case of voting against Democratic caucus on a high-profile measure.

That is still the original unsupported characterization in downstream-facing prose. It should either be removed or rewritten as a data gap, e.g. "No party-unity score retrieved; do not score independence until a fetched source supports it."

#### `candidates/2026/CA/us-house-d15/kevin-mullin.md` - blocked/search-summary sources still listed as used evidence

The source table still lists:

- `Congress.gov — Kevin Mullin member page` as Tier A, with "accessed via search; direct fetch 403"
- `GovTrack — Kevin Mullin member page` as Tier B, with "direct fetch 403; used search summary"

The r1 finding asked to replace inaccessible/search-summary-derived assertions with accessible Tier A/B sources or move access failures to a gap section that does not support claims. The access failures are noted, but the sources remain in the Tier A/B source lists as if used evidence.

Move both to the Note/gaps section unless directly fetched, or replace them with accessible official press releases / House pages already fetched.

### minor

None in this diff-scoped pass. The r1 minor findings about Wikipedia cleanup and mixed `generated:` / `generated-on:` fields were explicitly deferred in the fix commit and are not blockers for this re-review loop.

## Files Cleared

- `elections/2026/2026-06-02-CA-primary.md`
- `controversies/2026/CA.md`
- `candidates/2026/CA/us-house-d16/sam-liccardo.md`
- `candidates/2026/CA/San-Mateo/assessor-clerk-recorder/jim-irizarry.md`
- `candidates/2026/CA/San-Mateo/county-controller/juan-raigoza.md`
- `candidates/2026/CA/supt-public-instruction/william-mcgee.md`
- `you-decide/calibration-skills/trump-era-cater-discount.md` (reference existence checked; algorithm/calibration content not fully audited as shared candidate substrate)

## Files Still Flagged

- `candidates/2026/CA/us-house-d15/kevin-mullin.md`

## Notes

The batch should remain `issues-flagged` until the two Kevin Mullin source-hygiene issues above are corrected and re-reviewed. The large r1 ballot-scope problems are resolved.
