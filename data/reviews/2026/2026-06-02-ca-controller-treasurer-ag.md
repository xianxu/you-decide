---
batch: ca-controller-treasurer-ag
date: 2026-06-02
reviewer-stack: codex
producing-stack: claude
scope: candidates
files-reviewed: 12
issues-blocker: 0
issues-important: 0
issues-minor: 0
status: pass
---

# Review — ca-controller-treasurer-ag

Cross-stack review of 12 newly added 2026 California FACT dossiers for Controller, Treasurer, and Attorney General. Applied `you-decide/review.md`, `you-decide/calibration-skills/source-hygiene-tier-list.md`, `data/sources/CA.md`, and `data/sources/US.md`. These are FACT dossiers, so no weighted-score math check was applicable.

Re-review on 2026-06-02 was limited to the five previously issues-flagged files:

- `data/candidates/2026/CA/treasurer/tony-vazquez.md`
- `data/candidates/2026/CA/treasurer/david-serpa.md`
- `data/candidates/2026/CA/attorney-general/rob-bonta.md`
- `data/candidates/2026/CA/attorney-general/michael-gates.md`
- `data/candidates/2026/CA/attorney-general/marjorie-mikels.md`

The seven prior `passed` verdicts are retained.

## Issues found

### blocker

None.

### important

None.

### minor

None.

## Files cleared

- `data/candidates/2026/CA/controller/malia-cohen.md`
- `data/candidates/2026/CA/controller/herb-morgan.md`
- `data/candidates/2026/CA/controller/meghann-adams.md`
- `data/candidates/2026/CA/treasurer/eleni-kounalakis.md`
- `data/candidates/2026/CA/treasurer/anna-caballero.md`
- `data/candidates/2026/CA/treasurer/tony-vazquez.md`
- `data/candidates/2026/CA/treasurer/jennifer-hawks.md`
- `data/candidates/2026/CA/treasurer/david-serpa.md`
- `data/candidates/2026/CA/treasurer/glenn-turner.md`
- `data/candidates/2026/CA/attorney-general/rob-bonta.md`
- `data/candidates/2026/CA/attorney-general/michael-gates.md`
- `data/candidates/2026/CA/attorney-general/marjorie-mikels.md`

## Per-file verdicts

- `data/candidates/2026/CA/controller/malia-cohen.md` — `review: passed`
- `data/candidates/2026/CA/controller/herb-morgan.md` — `review: passed`
- `data/candidates/2026/CA/controller/meghann-adams.md` — `review: passed`
- `data/candidates/2026/CA/treasurer/eleni-kounalakis.md` — `review: passed`
- `data/candidates/2026/CA/treasurer/anna-caballero.md` — `review: passed`
- `data/candidates/2026/CA/treasurer/tony-vazquez.md` — `review: passed`
- `data/candidates/2026/CA/treasurer/jennifer-hawks.md` — `review: passed`
- `data/candidates/2026/CA/treasurer/david-serpa.md` — `review: passed`
- `data/candidates/2026/CA/treasurer/glenn-turner.md` — `review: passed`
- `data/candidates/2026/CA/attorney-general/rob-bonta.md` — `review: passed`
- `data/candidates/2026/CA/attorney-general/michael-gates.md` — `review: passed`
- `data/candidates/2026/CA/attorney-general/marjorie-mikels.md` — `review: passed`

## Notes / observations

- No artifact leakage found with `rg -i 'WebSearch|franding|TBD|<unknown>|\[.*\]\(\)'` across the five re-reviewed files.
- DATA-GAP markers in the cleared files use the required `[axis: ...; severity: ...; last-attempt: 2026-06-02]` shape and are low-severity honest gaps; under `review.md`, these do not block passage.
- The prior five blockers are resolved: decisive record, position, liability, endorsement, fundraising, and viability claims now use Tier A/B source pages or explicit inference/DATA-GAP treatment. The remaining Tier C sources in the five re-reviewed files are explicitly orienting-only and are not used for decisive claims.
- No Ballotpedia or California Globe reliance remains in the five re-reviewed files.
- Content-bearing single-page campaign URLs remain in a few source tables for candidate self-descriptions/platform lists; I did not treat those as the prior class of invalid bare domain-level rebinding, because the cited root pages themselves expose the claim text rather than serving as generic outlet homepages.
- Cohen's 2022 disclosure items are framed correctly as opposition-raised, partisan-sourced, unadjudicated allegations, not proven misconduct.
- Kounalakis's Meridian Plaza / blind-trust conflict flag is anchored to CalMatters, with California Globe explicitly marked Tier C and not relied on for the decisive claim.
- Bonta's behested-payments section is framed as apparently legal and avoids asserting illegality. The prior Bonta blockers on source-depth and Tier C reliance for endorsements/fundraising are resolved.
- Office-reported statistics in Bonta are labeled as claims by the office and not independently audited, which is the right framing once the deep OAG URLs are supplied.
- Candidate-name disambiguation is acceptable in the cleared files and in the re-reviewed AG files; no mistaken-identity issue surfaced.
