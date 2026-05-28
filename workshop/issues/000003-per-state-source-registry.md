---
id: 000003
status: open
deps: [000002]
github_issue: xianxu/you-decide#2
created: 2026-05-28
updated: 2026-05-28
---

# Build out per-state authoritative-source registry (sources/ directory)

## Problem

As coverage expands beyond California (via #000002), each new state needs its own `sources/<state>.md` listing authoritative outlets (Tier A primary, Tier B authoritative-secondary) for that jurisdiction. Without per-state outlet registries, the research subagents fall back to whatever the WebSearch tool surfaces — which tends to over-index on Wikipedia, blog posts, and partisan local outlets.

The tier-classification *principle* lives in `calibration-skills/source-hygiene-tier-list.md`; the concrete per-state outlet *lists* are what unblocks accurate research in new states.

## Current state

- `sources/US.md` — federal (FEC, Congress.gov, AP, Reuters, NPR, Politico, etc.)
- `sources/CA.md` — California (CalMatters, KQED, LA Times, SF Chronicle, EdSource, regional broadsheets, county registrar voter-info tools for SM/LA/SF/SAC/SC/AC/SD/OC)

## Spec

### Composition convention

Each Phase-1 / Phase-2 state addition in #000002 should be accompanied by `sources/<state>.md` populated *before* the candidate-research run, so research subagents have the right outlet list from the start.

Concretely:
1. Add state to coverage plan → seed `sources/<state>.md` with key outlets first
2. Run `scripts/populate-jurisdiction.sh STATE=<X> YEAR=<Y>` using those sources
3. Refine `sources/<X>.md` based on what the research surfaces (outlets discovered get tier-classified and added back)

### What to capture per state

**Tier A — Primary / official**
- State Secretary of State elections office
- State legislature voting/bill records
- State campaign-finance filing system (per-state equivalent of FPPC)
- County registrar voter-info tools (top ~10 counties by population first)

**Tier B — Authoritative-secondary**
- Statewide nonpartisan policy outlets (CalMatters equivalent — Texas Tribune, NJ Spotlight, etc.)
- Statewide public-radio voter guide if it exists
- One or two mainstream state-of-record newspapers
- Specialized outlets if dominant (e.g., EdSource for CA education)

**Tier B-local — Regional broadsheets**
- One per major metro area in the state

**Tier C — Use with caution**
- Wikipedia (orientation only)
- Known partisan local outlets (tilt-flagged)

### PR policy

Unlike candidate research / controversies / ballot manifests (which are factual substrate, no external PRs), `sources/` PRs are **welcomed** — sources are research methodology metadata, and disagreement about which outlets are authoritative is itself useful signal that surfaces faster via PR review.

PR acceptance:
- Tier classification follows `calibration-skills/source-hygiene-tier-list.md`
- Each outlet has a brief context line (region, tilt if any, specialty)
- Tier C entries explicitly flag tilt

### Initial targets after CA

Following #000002:
- US-major-coverage states first: TX, NY, FL (Phase 1 battle-test)
- Then: PA, IL, OH, GA, NC, MI (large electoral states)
- Then: rest of US per Phase 2

## Plan

- [ ] sources/TX.md
- [ ] sources/NY.md
- [ ] sources/FL.md
- [ ] sources/PA.md, IL.md, OH.md, GA.md, NC.md, MI.md
- [ ] Remaining 40 states (long tail; populate as those states enter the scaling roadmap in #000002)

## Log

### 2026-05-28
Ported from GH#2 per the ariadne in-repo-first convention. GH#2 remains as the public-visibility stub pointing here.
