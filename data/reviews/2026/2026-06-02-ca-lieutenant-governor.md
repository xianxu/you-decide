---
batch: ca-lieutenant-governor
date: 2026-06-02
reviewer-stack: codex
producing-stack: claude
scope: candidates
files-reviewed: 5
issues-blocker: 0
issues-important: 0
issues-minor: 0
status: pass
---

# Review — ca-lieutenant-governor

Cross-stack review of five newly added 2026 California lieutenant governor FACT dossiers. Applied `you-decide/review.md`, `you-decide/calibration-skills/source-hygiene-tier-list.md`, `data/sources/CA.md`, and `data/sources/US.md`. These are FACT dossiers, so no weighted-score math check was applicable.

Final pass note: this update reviewed only the two revised files, `data/candidates/2026/CA/lieutenant-governor/janelle-kellman.md` and `data/candidates/2026/CA/lieutenant-governor/josh-fryday.md`. The prior passed verdicts for Fiona Ma, Michael Tubbs, and Gloria Romero are retained from the earlier pass.

## Issues found

### blocker

None.

### important

None.

### minor

None.

## Files cleared

- `data/candidates/2026/CA/lieutenant-governor/fiona-ma.md`
- `data/candidates/2026/CA/lieutenant-governor/michael-tubbs.md`
- `data/candidates/2026/CA/lieutenant-governor/gloria-romero.md`
- `data/candidates/2026/CA/lieutenant-governor/janelle-kellman.md`
- `data/candidates/2026/CA/lieutenant-governor/josh-fryday.md`

## Per-file verdicts

- `data/candidates/2026/CA/lieutenant-governor/fiona-ma.md` — `review: passed`
- `data/candidates/2026/CA/lieutenant-governor/josh-fryday.md` — `review: passed`
- `data/candidates/2026/CA/lieutenant-governor/michael-tubbs.md` — `review: passed`
- `data/candidates/2026/CA/lieutenant-governor/janelle-kellman.md` — `review: passed`
- `data/candidates/2026/CA/lieutenant-governor/gloria-romero.md` — `review: passed`

## Notes / observations

- No artifact leakage found with `rg -i 'WebSearch|franding|TBD|<unknown>|\[.*\]\(\)'` across the final-pass files.
- Candidate-name disambiguation remains acceptable in the final-pass files: both dossiers identify offices / roles clearly enough to avoid common-name collisions.
- Genesis tracking is acceptable: decisive claims have inline URLs or valid single-source section preambles, inferences are marked, and unresolved items are marked inline with low-severity `DATA-GAP`.
- Kellman correction verified: the file now states the narrower "first openly LGBTQ+ person to serve as California Lieutenant Governor" claim and explicitly notes Ricardo Lara's 2018 statewide-office precedent, matching the Bay Area Reporter source.
- Fryday correction verified: the prior unsupported sanctuary / party-norm and presumed social-liberty inferences are now absence-of-evidence `DATA-GAP` items rather than asserted positions.
- Known producer gaps assessed: EdWeek, NPR StateImpact, and Santa Barbara Independent citations are now deep article URLs; California Globe is now clearly Tier C and marked removed / unused in the Romero dossier's source table; the contested Tubbs/Fryday teacher-union endorsement issue is resolved in the current Tubbs file by attributing CTA/CFT to rivals rather than to Tubbs.
- Low-severity `DATA-GAP` markers are used for unresolved finance / absence-of-evidence items in Ma, Fryday, Tubbs, Kellman, and Romero. Under `review.md`, honest low-severity gaps do not by themselves block passage.
- These were FACT dossiers; no weighted scoring or total math was reviewed.
