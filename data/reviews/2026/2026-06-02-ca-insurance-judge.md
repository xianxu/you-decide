---
batch: ca-insurance-judge
date: 2026-06-02
reviewer-stack: codex
producing-stack: claude
scope: candidates
files-reviewed: 13
issues-blocker: 0
issues-important: 0
issues-minor: 0
status: pass
---

# Review — ca-insurance-judge

Cross-stack review of 13 newly added 2026 California FACT dossiers: 11 Insurance Commissioner candidates and two San Mateo County Superior Court Office No. 4 judicial candidates. Applied `you-decide/review.md`, `you-decide/calibration-skills/source-hygiene-tier-list.md`, `data/sources/CA.md`, and `data/sources/US.md`. These are FACT dossiers, so no weighted-score math check was applicable.

## Issues found

### blocker

None.

### important

None.

### minor

None.

## Files cleared

- `data/candidates/2026/CA/insurance-commissioner/ben-allen.md`
- `data/candidates/2026/CA/insurance-commissioner/steven-bradford.md`
- `data/candidates/2026/CA/insurance-commissioner/jane-kim.md`
- `data/candidates/2026/CA/insurance-commissioner/patrick-wolff.md`
- `data/candidates/2026/CA/insurance-commissioner/stacy-korsgaden.md`
- `data/candidates/2026/CA/insurance-commissioner/merritt-farren.md`
- `data/candidates/2026/CA/insurance-commissioner/eric-aarnio.md`
- `data/candidates/2026/CA/insurance-commissioner/robert-howell.md`
- `data/candidates/2026/CA/insurance-commissioner/sean-lee.md`
- `data/candidates/2026/CA/insurance-commissioner/keith-davis.md`
- `data/candidates/2026/CA/insurance-commissioner/eduardo-vargas.md`
- `data/candidates/2026/CA/San-Mateo/judge-superior-court-office-4/brian-donnellan.md`
- `data/candidates/2026/CA/San-Mateo/judge-superior-court-office-4/jay-boyarsky.md`

## Per-file verdicts

- `data/candidates/2026/CA/insurance-commissioner/ben-allen.md` — `review: passed`
- `data/candidates/2026/CA/insurance-commissioner/steven-bradford.md` — `review: passed`
- `data/candidates/2026/CA/insurance-commissioner/jane-kim.md` — `review: passed`
- `data/candidates/2026/CA/insurance-commissioner/patrick-wolff.md` — `review: passed`
- `data/candidates/2026/CA/insurance-commissioner/stacy-korsgaden.md` — `review: passed`
- `data/candidates/2026/CA/insurance-commissioner/merritt-farren.md` — `review: passed`
- `data/candidates/2026/CA/insurance-commissioner/eric-aarnio.md` — `review: passed`
- `data/candidates/2026/CA/insurance-commissioner/robert-howell.md` — `review: passed`
- `data/candidates/2026/CA/insurance-commissioner/sean-lee.md` — `review: passed`
- `data/candidates/2026/CA/insurance-commissioner/keith-davis.md` — `review: passed`
- `data/candidates/2026/CA/insurance-commissioner/eduardo-vargas.md` — `review: passed`
- `data/candidates/2026/CA/San-Mateo/judge-superior-court-office-4/brian-donnellan.md` — `review: passed`
- `data/candidates/2026/CA/San-Mateo/judge-superior-court-office-4/jay-boyarsky.md` — `review: passed`

## Notes / observations

- No artifact leakage found with `rg -i 'WebSearch|franding|TBD|<unknown>|\[.*\]\(\)'` across the scoped files.
- Re-review of the two revised files cleared the prior findings: Wolff's decisive biography and record claims are no longer bound to Ballotpedia, and the unsupported self-funding dollar figure has been demoted to a low-severity `DATA-GAP`; Howell's CalMatters-sourced 2022 nominee and watchdog / market-access / insurance-payers-bill-of-rights facts are now stated, with remaining gaps narrowed to no further detail.
- `DATA-GAP` markers generally use the required `[axis: ...; severity: low; last-attempt: 2026-06-02]` shape. Low-severity honest gaps did not block this pass.
- The five intentionally brief minor Insurance Commissioner stubs are acceptable in proportion; Howell's previously overbroad no-position / no-prior-candidacy gaps are now narrowed.
- Korsgaden's January 6 / 2020-election section is framed acceptably: it includes her disavowal of violence, acceptance of Biden's election and peaceful transfer of power, and election-verification rhetoric as reported, without turning it into an adjudicated denialism finding.
- Farren's Acrisure item is framed as a reasonable industry-capture question and reported input, not as an adjudicated capture finding.
- The Boyarsky Palo Alto Daily Post "just wants the title" line is labeled as an opinion from a rival-endorsing paper, not as a finding.
- Judge dossiers state the two requested gaps: no sitting-judge record for either candidate and no county-bar rating found. Boyarsky's title ambiguity is handled with a source-neutral top-deputy / second-in-command formulation and a low-severity `DATA-GAP`.
- Name disambiguation is acceptable for the cleared files: Ben Allen is identified as the SD-24 state senator / Insurance Commissioner candidate; Donnellan and Boyarsky are identified by county prosecutor roles and the exact San Mateo County Superior Court Office No. 4 race.
- These were FACT dossiers; no weighted scoring or total math was reviewed.
