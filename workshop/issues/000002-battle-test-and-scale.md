---
id: 000002
status: open
deps: []
created: 2026-05-28
updated: 2026-05-28
---

# Battle-test and scale: AI-curated voter research across key US jurisdictions

## Problem

The MVP (`brain#11`) validated the algorithm on California 2026 (8 governor candidates + 4 SM County races + 4 CA state races + 1 US House district). To become useful beyond a single user in a single state, the substrate (`data/candidates/`, `data/elections/`, `data/controversies/`) needs maintainer-curated, AI-driven population across many jurisdictions — with consistent methodology, inline source citations, and the review pipeline enforcing quality.

Battle-testing also surfaces algorithm gaps that don't appear in a single-state run: voting systems other than CA top-2 (ranked-choice in ME/AK, partisan primaries elsewhere), state-specific filing windows, judicial-retention races, ballot measures with conditional dependencies.

## Spec

### Phased coverage

**Phase 1 — Battle-test (50 states × top races)**
- All 50 states × statewide races (governor, US Senate if year, attorney general, secretary of state)
- US House for top-N populous districts per state
- Goal: validate the algorithm at multi-state scale; surface state-specific edge cases

**Phase 2 — Top metros**
- Top 50 metro areas × full down-ballot (county / city / school district)
- Where most voters live; highest user-adoption leverage

**Phase 3 — Full coverage**
- All US counties × full down-ballot — aspirational long-term target

### Refresh cadence

Per `resolve-ballot.md` cache-invalidation rules tied to proximity-to-election:
- More than 6 months out: refresh monthly
- 2–6 months out: bi-weekly
- 1–2 months out: weekly
- Under 2 weeks out: every few days

Per-cycle full regeneration vs. delta updates: TBD as cost data accumulates.

### AI-transparency requirement (non-negotiable)

Every batch-research run must:
- Use sources from the Tier A/B preference list in `calibration-skills/source-hygiene-tier-list.md`
- Inline source URL for every factual claim (genesis tracking)
- `last-verified` timestamp on every file
- Be reproducible: someone else clones the repo, re-runs the algorithm against the same sources, gets equivalent results

### Initial battle-test sequence (proposed)

1. CA 2026 — fill in remaining CA counties (Phase 1 within one state)
2. Pick 2–3 other large states (TX, NY, FL) for cross-state validation
3. Iterate based on what breaks

## Plan

- [ ] Batch-research driver: `scripts/populate-jurisdiction.sh` taking `(state, year)` → dispatches research subagents → commits results
- [ ] Makefile target: `make populate-state STATE=CA YEAR=2026` (and variants for county / metro level)
- [ ] Per-state voter-info-tool registry (the per-county equivalent of `smcacre.gov`) so `resolve-ballot` can resolve addresses → districts without per-state custom code
- [ ] CI: validate source-hygiene compliance on every commit (grep for un-sourced claims, weak-source citations, stale `last-verified` dates)
- [ ] Coverage tracking: `COVERAGE.md` listing populated jurisdictions × years and their freshness (per #000004 pre-commit hook + data/reviews/COVERAGE.md)
- [ ] Cost model: per-jurisdiction AI-bill estimate; budget planning for Phase 1/2/3 scaling
- [ ] Post-cycle archival convention: after election day passes, manifest becomes historical record — don't delete, document the convention
- [ ] Execute Phase 1 across all 50 states for the next major cycle (incremental over many sessions)

## Log

### 2026-05-28
Ported from GH#1 per the ariadne in-repo-first convention. GH#1 remains as the public-visibility stub pointing here.
