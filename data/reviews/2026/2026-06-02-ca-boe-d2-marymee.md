---
batch: ca-boe-d2-marymee
date: 2026-06-02
reviewer-stack: codex
producing-stack: claude
scope: candidates
files-reviewed: 1
issues-blocker: 0
issues-important: 0
issues-minor: 0
status: pass
---

# Review — ca-boe-d2-marymee

Cross-stack re-review of one newly added 2026 California Board of Equalization District 2 FACT dossier. Applied `you-decide/review.md`, `you-decide/calibration-skills/source-hygiene-tier-list.md`, `data/sources/CA.md`, and `data/sources/US.md`. This is a FACT dossier, so no weighted-score math check was applicable.

Re-review scope was limited to verifying whether the prior report's three important findings and one minor finding were addressed, and whether the fixes introduced regressions.

## Issues found

### blocker

None.

### important

None.

### minor

None.

## Files cleared

- `data/candidates/2026/CA/boe-d2/j-brett-marymee.md`

## Per-file verdicts

- `data/candidates/2026/CA/boe-d2/j-brett-marymee.md` — `review: passed`

## Prior findings re-check

- The paywalled-op-ed positions gap and fundraising gap are now `severity: low` and include explicit low-impact justifications. Under `you-decide/review.md`, low-severity honest `DATA-GAP`s do not block pass.
- The BOE structural-position claim is now framed as absence of accessible Tier A/B evidence, and the platform read is explicitly marked as inference.
- The viability paragraph is softened: Democratic lean is marked inference, and the top-two-path read rests on field structure rather than an uncited partisan-rating claim.
- The "search-confirmed CalMatters summary" process label was removed and replaced with ordinary source descriptions, including The Almanac for district scale.

## Notes / observations

- No decisive claim in the revised file rests solely on Tier C evidence. Tier C use is labeled orienting only.
- No decisive claim rests on a bare domain-level URL; cited campaign-site claims are linked to the relevant home/about pages and bounded by surrounding text.
- Inferences are marked where the file moves beyond directly sourced facts.
- Low-severity `DATA-GAP`s are honest, localized, and do not silently support decisive claims.
- HJTA endorsement handling is correct: the dossier states the endorsement is a dual / co-endorsement shared with John Pimentel, not a sole endorsement, and binds that claim to the HJTA-PAC page.
- The "22 years elected service" issue is handled correctly as Marymee's self-description plus an explicit discrepancy / low-severity `DATA-GAP`, not asserted as independently documented fact.
- iVoterGuide is labeled Tier C / orienting only. No decisive claim appears to rest solely on it.
- No artifact leakage found with `rg -i 'WebSearch|franding|TBD|<unknown>|\[.*\]\(\)'` on the scoped file.
- Name disambiguation is acceptable: the file identifies this candidate as J. Brett Marymee, Santa Ynez / SYRWCD Division 5 official, running for 2026 California Board of Equalization District 2.
- These were FACT dossier checks only; no score math was reviewed.
