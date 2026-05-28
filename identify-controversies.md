---
name: identify-controversies
description: Use when designing a voter-philosophy survey or wanting to understand what issues actually differentiate candidates in a given election cycle. Input (year, state, optionally sub-jurisdictions). Output a ranked map of controversies with framings, evidence of candidate disagreement, and which races they drive. Feeds the bootstrap-survey skill so questions probe real fault-lines instead of generic civics.
---

# identify-controversies

Survey the political fault-lines in an election cycle. The output is a structured map of issues where candidates substantively disagree — not generic civics-textbook topics, but the actual arguments shaping this cycle's races.

## Why this exists

A voter-philosophy survey that asks *"do you support criminal justice reform?"* learns nothing because everyone says yes. A survey that asks *"should chronic-homeless individuals who refuse three shelter offers face arrest?"* pulls a real stance because that's the actual debate in this cycle. This skill identifies the second kind of question by mining where candidates actually disagree.

## Inputs

| Field | Required | Notes |
|---|---|---|
| `year` | yes | 4-digit election year |
| `state` | yes | 2-letter US state code |
| `sub-jurisdictions` | no | List of county/city slugs to include local controversies for |
| `election-manifests` | no | If election manifests already exist for this cycle, pass them to avoid re-discovery |

## Output

A controversy map at `data/life/politics/controversies/<year>/<state>.md` (cached in shared brain, reusable across users and races in the same cycle).

## Algorithm

### Stage 1 — Enumerate races + candidates

Accept election manifests as input or invoke [[resolve-ballot]] to discover them. Goal: get the full list of races + candidates for the cycle.

### Stage 2 — Pull candidate positions

For each race, walk the candidate profiles in `candidates/<year>/<state>/<race>/<slug>.md`. Extract the `## Stated positions` sections. Candidate profiles are factual and value-neutral — they're the input substrate.

### Stage 3 — Cluster disagreements by issue

Use the 5-tier axis taxonomy from [[SKILL]] as a starting structure (Tier 4 issue axes, Tier 3 economic philosophy, etc.). For each axis, identify candidates at each end of any disagreement.

A "controversy" requires:
- At least 2 candidates with substantively different stances (not just labeling — actual policy difference)
- The difference is **on the table** in this cycle (mentioned in campaigns, debates, op-eds — not just theoretically possible)

### Stage 4 — Cross-reference with media coverage

For each candidate-disagreement cluster, search recent (this-cycle) news coverage and op-eds to confirm public salience. A disagreement only visible in candidate-site policy pages is real but low-salience; one driving op-eds and debate questions is high-salience.

Use Tier-A/B sources per [[source-hygiene-tier-list]]: CalMatters, AP, LA Times, KQED, local broadsheets.

### Stage 5 — Rank by salience

Combine: (number of candidates with stake) × (stakeness of disagreement) × (media-coverage salience). Order high-to-low. Group into High / Medium / Low salience tiers.

### Stage 6 — Frame as survey-ready stances

For each top controversy, draft 1-2 **stance statements** that probe the dimension. Format: force-choice or strongly-worded agree-or-disagree, **not Likert-mush**. Bad: *"Housing is important."* Good: *"California should speed up housing by limiting CEQA lawsuits, even at the cost of fewer environmental challenges to projects."*

These become input to [[bootstrap-survey]] (M3).

## Output schema

```markdown
---
year: YYYY
state: <state>
sub-jurisdictions: [<slug>, ...]
generated: YYYY-MM-DD
last-verified: YYYY-MM-DD
source-elections: [<election-slug>, ...]
sources: [<URLs and candidate-profile globs>]
---

# Controversies — <state> <year> cycle

## High-salience (driving multiple races + visible in media coverage)

### N. <Issue framing as a question>
- Tier / axis: <which taxonomy axis>
- Side A (label): <candidates with slugs>
- Side B (label): <candidates with slugs>
- Races affected: <slugs>
- Media coverage: <pointers>
- Survey-ready stance: "<one or two force-choice statements for bootstrap-survey>"

## Medium-salience
[same structure, lower weight]

## Low-salience / niche
[same]

## Sources
```

## Cache invalidation

Same proximity-to-election cadence as [[resolve-ballot]]:
- More than 6 months out: refresh monthly
- 2-6 months: bi-weekly
- 1-2 months: weekly
- < 2 weeks: every few days

After the cycle's last election day, the file becomes historical record (don't delete — useful for "what was contested in 2026?" queries).

## Research subagent prompt template

Dispatch when the controversy map is missing or stale:

> You are mapping the political controversies in <state>'s <year> election cycle.
>
> Pre-loaded context:
> - Election manifests: [paths]
> - Candidate profiles directory: `candidates/<year>/<state>/`
>
> Task: walk the candidate profiles, extract their stated positions, identify where candidates substantively disagree. Cluster disagreements into issue dimensions. For each cluster:
> - Tier the issue per the 5-tier taxonomy in [[SKILL]]
> - List candidates on each side with brief position quotes
> - Note which races involve the disagreement
> - Cite media coverage (Tier A/B sources per [[source-hygiene-tier-list]]) that confirms public salience
> - Draft 1-2 force-choice stance statements that probe the dimension (for use in M3 survey)
>
> Output: structured markdown matching the controversies-output schema in `you-decide/identify-controversies.md`. Rank High / Medium / Low salience.
>
> Budget: 8-12 web operations for media cross-referencing. The bulk of work is reading existing candidate profiles — positions are already in them.

## Acceptance test (from issue 000011)

Run on `(2026, CA, sub-jurisdictions=[San-Mateo])`. Should surface (at minimum) these controversies that emerged organically from the CA-2026 manual research:

1. Housing-CEQA reform (Villaraigosa pro-reform vs others)
2. Energy cost vs climate-spend (Hilton/Villaraigosa cost-focused vs Steyer climate-spend)
3. Public safety — Prop 36 + chronic-homeless enforcement
4. Trump cater-mode vs personalist convert (Hilton, Bianco)
5. Billionaire self-funding (Steyer $147M)
6. Election integrity (Bianco ballot seizure, Hilton 2020-fraud rhetoric)
7. Charter schools vs union alignment
8. Wealth/billionaire tax mechanism

If the algorithm doesn't surface most of these without prompting, the disagreement-clustering or media-cross-referencing step is wrong.

Baseline encoded at `controversies/2026/CA.md`.

## When NOT to use

- Cycle already has a controversies map cached and fresh — load it directly
- User has a mature philosophy and isn't doing the bootstrap survey — main algorithm doesn't need controversies separately (it uses philosophy + candidate profiles directly)

## Cross-references

- Survey design consumes this: [[bootstrap-survey]] (M3 — pending)
- Election manifest discovery: [[resolve-ballot]]
- Main algorithm: [[SKILL]]
- Axis taxonomy: in [[SKILL]] section "Axis taxonomy"
- Source-quality rules: [[source-hygiene-tier-list]]
