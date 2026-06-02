---
batch: ca-secretary-of-state
date: 2026-06-02
reviewer-stack: codex
producing-stack: claude
scope: candidates+elections
files-reviewed: 5
issues-blocker: 0
issues-important: 0
issues-minor: 0
status: pass
---

# Review — ca-secretary-of-state

Cross-stack review of four newly added 2026 California Secretary of State FACT dossiers plus the scoped additions to the June 2, 2026 California primary manifest. Applied `you-decide/review.md`, `you-decide/calibration-skills/source-hygiene-tier-list.md`, `data/sources/CA.md`, and `data/sources/US.md`. These are FACT dossiers, so no weighted-score math check was applicable.

Manifest scope note: review covered only the newly added Lieutenant Governor and Secretary of State race-enumeration blocks and the updated Scope caveat. Existing manifest races were not re-litigated.

Re-review note, 2026-06-02: this pass re-checked only `data/candidates/2026/CA/secretary-of-state/gary-blenner.md`, after the prior important finding on the exact 2022 vote total/percentage was revised.

## Issues found

### blocker

None.

### important

None. The prior important issue in `data/candidates/2026/CA/secretary-of-state/gary-blenner.md` is resolved: the exact 2022 vote total/percentage is now an inline low-severity `DATA-GAP`, not a decisive record claim.

### minor

None.

## Files cleared

- `data/candidates/2026/CA/secretary-of-state/shirley-weber.md`
- `data/candidates/2026/CA/secretary-of-state/don-wagner.md`
- `data/candidates/2026/CA/secretary-of-state/michael-feinstein.md`
- `data/candidates/2026/CA/secretary-of-state/gary-blenner.md`
- `data/elections/2026/2026-06-02-CA-primary.md`

## Per-file verdicts

- `data/candidates/2026/CA/secretary-of-state/shirley-weber.md` — `review: passed`
- `data/candidates/2026/CA/secretary-of-state/don-wagner.md` — `review: passed`
- `data/candidates/2026/CA/secretary-of-state/michael-feinstein.md` — `review: passed`
- `data/candidates/2026/CA/secretary-of-state/gary-blenner.md` — `review: passed`
- `data/elections/2026/2026-06-02-CA-primary.md` — `review: passed`

## Notes / observations

- The CA SoS certified candidate list confirms the Secretary of State certified field is four candidates: Shirley N. Weber, Donald P. (Don) Wagner, Gary N. Blenner, and Michael Feinstein. The manifest's Secretary of State enumeration is accurate and all four `[[candidate-slug]]` links resolve to files under `data/candidates/`.
- The manifest's Lieutenant Governor block is correctly labeled as a viability-filtered subset. The CA SoS certified list contains more Lt. Gov candidates than the five enumerated names, and all five enumerated `[[candidate-slug]]` links resolve to files under `data/candidates/`.
- No artifact leakage found with `rg -i 'WebSearch|franding|TBD|<unknown>|\[.*\]\(\)'` across the scoped files.
- The Wagner 2020-election framing is acceptable: the dossier reports his explicit non-denial quote from the Santa Barbara Independent / CalMatters story and keeps broader absence-of-evidence claims marked as inferences.
- The slow-ballot-count attribution in the Weber dossier is acceptable: it attributes the count period to statute/county canvass mechanics rather than Weber's unilateral discretion.
- Candidate-name disambiguation is acceptable in the passed files: Weber is distinguished from Akilah Weber, Wagner is identified as Donald P. Wagner of Orange County, and Michael Feinstein is clearly identified as the Green/Santa Monica electoral-reform candidate.
- Blenner's 2022-result handling is now acceptable: the dossier keeps the Tier-A GPCA-sourced fact that he ran in 2022 and did not advance, while the exact vote total/percentage is explicitly marked unverified in a low-severity `DATA-GAP`. No decisive Blenner record, position, liability, or viability claim now rests on Tier C.
- Low-severity `DATA-GAP` markers are used for unresolved finance, absence-of-evidence, and thin-biography items. Under `review.md`, honest low-severity gaps do not by themselves block passage.
