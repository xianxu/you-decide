---
name: resolve-ballot
description: Use when discovering what's on a voter's ballot for an upcoming or specified election. Input (address, optionally date or year). Output structured ballot manifest of all races and measures the voter can vote on at that election. Composes election-day manifests; dispatches research subagents to enumerate any election that hasn't been scoped yet.
---

# resolve-ballot

Given a voter's address and either a specific election date or "the next upcoming election," produce the full ballot they'll see — every office and ballot measure across federal, state, county, city, school, and special-district jurisdictions that appear on that election's ballot.

## Data model

The primary key is **election day** (one specific date when polls are open). An election day contains many **races**; each race has **1+ candidates** (1 = uncontested), or it's a **ballot measure**. Voters see a filtered subset of an election day's races based on their resolved districts.

Election manifests live at:

```
data/life/politics/elections/<YYYY>/<YYYY-MM-DD>-<state>-<type>.md
```

The year folder keeps each year's elections grouped (a long-running brain accumulates many years of manifests).

Examples:
- `2026/2026-06-02-CA-primary.md`
- `2026/2026-11-03-CA-general.md`
- `2027/2027-03-15-CA-special-AD23.md`

## Inputs

| Field | Required | Notes |
|---|---|---|
| `address` | yes | Full street address (used to determine districts) |
| `state` | yes | 2-letter US state code (`CA`, `WA`, etc.) |
| `when` | no | One of: `next` (default — find the next upcoming election in this state), a specific date `YYYY-MM-DD`, or a year `YYYY` (return all elections that year) |
| `posture` | no | `contested-only` (default) or `all` (include uncontested races) |

## Output

A ballot manifest in markdown — see [Output schema](#output-schema). Returned in-conversation and optionally written to the user's private brain at `who-to-vote-for/<year>/<state>/<address-slug>-<date>-ballot.md`.

## Algorithm

### Stage 1 — Resolve the election day(s)

Given `when`:
- `next` → scan `elections/<YYYY>/` directories (current year onward), find the soonest dated file matching `state`, return if date >= today. If none, ask the user (or research) to identify when the next election is.
- `<date>` → load `elections/<YYYY>/<date>-<state>-*.md` (year derived from date)
- `<year>` → load all matching `elections/<year>/<year>-*-<state>-*.md`

If the relevant election manifest doesn't exist yet, dispatch the [research subagent](#research-prompt-template) to create it.

### Stage 2 — Address to districts

Map the address to all overlapping electoral districts.

**Tool priority:**
1. County registrar's official voter-info tool (most counties have one; e.g., `smcacre.gov/elections/my-election-info` for SM County)
2. State Secretary of State address-based district lookup
3. Census geocoder + state-published district shapefiles

**District tags to resolve** (subset varies per state and election type):
- `STATEWIDE` (always, for any state-level race)
- US House district (`US-House-D<N>`)
- State Senate district (`CA-Senate-D<N>` etc.)
- State Assembly district (`CA-Assembly-D<N>`)
- County (`SM-COUNTY`, etc.)
- County Supervisor district (`SM-SUPERVISOR-D<N>`)
- City (`MENLO-PARK`)
- City Council district (`MENLO-PARK-COUNCIL-D<N>`)
- School district (`MENLO-PARK-CSD`, `SEQUOIA-UHSD`, etc.)
- Special districts (`MENLO-PARK-FIRE`, `WEST-BAY-SANITARY`, etc.)

### Stage 3 — Filter election manifest by districts

For each loaded election manifest:
- Walk through each race
- Read the race's `District:` tag
- Include the race iff the user's resolved districts include that tag
- Apply `posture` filter (drop uncontested if `contested-only`)

### Stage 4 — Return

Structured manifest with the user's actual ballot. Each race carries:
- Office name + seats
- Candidates (with [[slug]] pointers to candidate files in `candidates/`)
- Election date

## Output schema (user's ballot)

```markdown
---
address: <full address>
state: <state>
election-date: <YYYY-MM-DD>
election-type: primary | general | special
generated: YYYY-MM-DD
jurisdictions: [<tag>, <tag>, ...]
posture: contested-only | all
---

# Ballot — <address> — <election date>

## <Office category, e.g. "Statewide">

### <Office name>
- Jurisdiction: <tag>
- Seats: <N>
- Candidates:
  - <Full Name> [[<candidate-slug>]]
  - <Full Name> [[<candidate-slug>]]

## Ballot measures applicable to this address

- **<Measure ID>**: <short title>
```

## Per-election manifest schema

The cached files in `elections/`:

```markdown
---
date: YYYY-MM-DD
type: primary | general | special
state: <state>
slug: <date>-<state>-<type>
generated: YYYY-MM-DD
last-verified: YYYY-MM-DD
coverage: <what jurisdictions this manifest covers>
sources: [<authoritative URLs>]
---

# <State> <Type> — <date>

[organized by jurisdiction category]

## Statewide races
### <Office>
- Seats: <N>
- District: STATEWIDE
- CONTESTED:
  - <Name> ([party]) [[slug]]
  - ...

## Federal — US House
### US House, District <N>
- District: US-House-D<N>
- ...

## State Legislative
### State Assembly, District <N>
- District: CA-Assembly-D<N>
- ...

## <County name>
### <Office>
- District: <SM-COUNTY | SM-SUPERVISOR-D<N> | ...>
- ...

## Sub-county ballot measures
- **<Measure>** — <title> — *District: <tag>*

## Sources
[URLs]
```

## Cache invalidation

Election manifests are tied to a specific election day. Within the run-up to an election, candidates file/withdraw and measures qualify:
- More than 6 months out: refresh monthly
- 2-6 months out: bi-weekly
- 1-2 months out: weekly
- Less than 2 weeks out: every few days

Track via `last-verified:` field in frontmatter. If `last-verified` is older than the threshold for the current proximity, refresh by re-running the research subagent.

After the election day passes, the manifest becomes a historical artifact (useful for "what did Xian vote on in 2026?" queries; don't delete).

## Research prompt template

Dispatch this when an election manifest is missing or stale:

> You are scoping the YYYY-MM-DD election for <state> (<type>).
>
> **Task:** enumerate every office and ballot measure on this election's ballot, organized by jurisdiction.
>
> For each office:
> - Office name + jurisdiction + district tag (e.g., `CA-Assembly-D21`, `SM-COUNTY`, `STATEWIDE`)
> - Number of seats
> - Whether contested (>1 candidate) or uncontested
> - All declared candidates: full names, party if partisan, ballot designation, incumbent status
>
> For each ballot measure:
> - Letter or number
> - Short title and one-line description
> - Jurisdiction tag (which voters see it)
> - Approval threshold (50% / 55% / 2/3)
>
> **Sources** (priority order):
> 1. State Secretary of State + county registrar official sites
> 2. State/local nonpartisan voter guides (e.g., CalMatters, KQED for CA)
> 3. Local newspaper coverage of the closed candidate filing roster
>
> **Output:** markdown matching the per-election manifest schema in `voter-decide/resolve-ballot.md`. Skip uncontested races UNLESS posture is `all`.
>
> Budget: 10-15 web operations for a state primary or general. Flag uncertainties explicitly (especially races where filing isn't yet closed).

## Acceptance test (from issue 000011)

Run against `(123 Main St, Menlo Park, CA, next, contested-only)`. Should produce a ballot containing exactly:

- **Statewide**: Governor, State Supt of Public Instruction, BOE D2 (the test address is in BOE D2)
- **Federal**: US House D15
- **State Legislative**: Assembly D21
- **SM County**: County Superintendent of Schools, Assessor/Clerk-Recorder, Controller, Supervisor D3
- **Sub-county measures**: none (the test address is not in Ravenswood/Brisbane/RCESD)

Baseline encoded at `elections/2026/2026-06-02-CA-primary.md` — should be exactly filterable to the above via the-test-address district tags `STATEWIDE` + `CA-BOE-D2` + `US-House-D15` + `CA-Assembly-D21` + `SM-COUNTY` + `SM-SUPERVISOR-D3`.

## When NOT to use

- A recent election manifest exists for the requested date and all needed jurisdictions are covered — load directly and filter
- User explicitly knows their ballot and just wants per-candidate research — skip to the main [[SKILL]] algorithm

## Cross-references

- Main algorithm: [[SKILL]]
- Per-candidate research files: `data/life/politics/candidates/<year>/<state>/<race>/<slug>.md`
- Per-office axis-weighting templates: [[templates]]
- Calibration skills: [[calibration-skills]] (shared) + the user's private calibration-skills
