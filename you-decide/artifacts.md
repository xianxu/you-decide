---
name: artifacts
description: The artifact-type registry for you-decide. The single authority for every document the algorithm writes into the user's private dir — path pattern, frontmatter, and purpose per type. Other skill files reference this instead of restating naming, so conventions never drift. User-agnostic; the private dir it writes into is resolved separately (see Private-dir resolution).
generated-by: claude
generated-on: 2026-06-02
review: not-done
---

# Artifacts — the type registry

Every artifact the you-decide algorithm produces in the **user's private dir** has
its name, location, and frontmatter defined **here, once**. The other skill files
([[SKILL]], [[resolve-ballot]], [[bootstrap-survey]], [[review]]) and the atlas refer
to this registry rather than restating path patterns inline — that is the whole point
of the file: one authority, no drift.

All paths below are **relative to the resolved private dir** (see
[Private-dir resolution](#private-dir-resolution) — they are NOT repo paths). The
public, shared substrate (`data/candidates/`, `data/elections/`, …) is a separate
concern documented in [atlas/substrate](../atlas/substrate.md); this file is only the
private side.

All artifacts carry the bundle's standard frontmatter contract
(`generated-by` / `generated-on` / `review`, plus `reviewed-*` once reviewed) on top
of their type-specific fields — see [atlas/substrate](../atlas/substrate.md#per-file-frontmatter-contract).

## Type registry

| Type | Path (under private dir) | Kind | Stage |
|---|---|---|---|
| [Ballot guide](#ballot-guide) | `<year>/<state>/<addr>-<date>-ballot.md` | derived (recommendation) | 1 + 5 |
| [Candidate read](#candidate-read) | `<year>/<state>/<race>/<slug>-read.md` | derived (pure fn) | 3 |
| [Race vote](#race-vote) | `<year>/<state>/<race>/vote.md` | derived (deliberation) | 6 |
| [Cast ballot](#cast-ballot) | `<year>/<state>/<addr>-<date>-cast.md` | record (what was marked) | post-vote |

Tokens: `<year>` = `YYYY`; `<state>` = 2-letter code (`CA`); `<addr>` = address slug
(`springfield`); `<date>` = election day `YYYY-MM-DD`; `<race>` = office slug
(`<county>/county-superintendent-schools`); `<slug>` = candidate slug
(`hector-camacho-jr`).

### Ballot guide

`<year>/<state>/<addr>-<date>-ballot.md` — the personalized voter guide for one
address + one election day: every race on the ballot, full field scored and sorted,
recommended vote marked, framed risk-mode. Written/refreshed at [[resolve-ballot]]
(Stage 1) and updated through Stage 5. One per (address, election day).

```yaml
---
address-slug: <addr>
state: <CA>
election-date: <YYYY-MM-DD>
election-type: <primary | general | special>
jurisdictions: [STATEWIDE, US-House-D16, ...]   # resolved district tags
posture: <contested-only | all>
generated-by: <claude | …>
generated-on: <YYYY-MM-DD>
revised: <YYYY-MM-DD>          # optional; when the guide was last re-resolved
review: <not-done | passed | …>
---
```

### Candidate read

`<year>/<state>/<race>/<slug>-read.md` — one candidate scored against the user's
philosophy for one race. A **pure function** of (philosophy, calibration skills,
candidate profile); cached and reused unless one of those inputs is newer (the
Stage-3 staleness rule in [[SKILL]]). Body carries the per-axis scoring matrix +
explicit weighted-total math.

```yaml
---
candidate: <relative path to the shared data/candidates/…/<slug>.md profile>
name: <Candidate Name>
race: <race-id>
office-template: <template slug, e.g. county-superintendent-schools>
read-date: <YYYY-MM-DD>
weighted-total: <integer; MUST equal the body math>
generated-by: <claude | …>
generated-on: <YYYY-MM-DD>
revised-on: <YYYY-MM-DD>       # optional; set when a newer input forced a re-score
review: <not-done | passed | …>
---
```

### Race vote

`<year>/<state>/<race>/vote.md` — the final per-race deliberation once the
disagreement loop converges (Stage 6): hard-filter pass, per-axis matrix, conscience
vote, strategic vote, divergence, and the calibration skills active for the race.

```yaml
---
race: <race-id>
date: <decision-date YYYY-MM-DD>
primary-date: <YYYY-MM-DD>             # for primaries; the election day this decides
final-vote: <candidate | undecided>    # general; OR primary-vote: for a primary
strategic-vote: <candidate | conscience-aligned>
posture: <single-vote | top-2 | ranked-choice>
generated-by: <claude | …>
generated-on: <YYYY-MM-DD>
revised-on: <YYYY-MM-DD>        # optional
review: <not-done | passed | …>
---
```

### Cast ballot

`<year>/<state>/<addr>-<date>-cast.md` — the record of what the user **actually
marked**, reported back after voting, reconciled against the ballot guide. NOT a
recommendation (that is the ballot guide); this is the durable record of the decision
taken. One per (address, election day). Mirrors the ballot-guide naming with `-cast`.

```yaml
---
address-slug: <addr>
state: <CA>
election-date: <YYYY-MM-DD>
election-type: <primary | general | special>
status: cast
guide: <addr>-<date>-ballot.md         # backlink to the recommendation it reconciles against
jurisdictions: [STATEWIDE, ...]
generated-by: <claude | …>
generated-on: <YYYY-MM-DD>             # the day the vote was recorded
review: <not-done | passed | …>
---
```

Body shape:
- **What I voted** — a table: Office | My vote | Guide rec | Note (✓ match / within-rec
  toss-up / diverged / not-analyzed).
- **Not on this cast list** — offices skipped or out of the voter's districts; do NOT
  infer a vote.
- **Divergences** — for each office where the cast vote ≠ the guide's pick, the
  rationale (often a calibration signal worth capturing).
- **Calibration skills active** — same footer as the ballot guide.

## User-root files (not type-templated, but private-dir residents)

These live at the private-dir root, not under `<year>/<state>/`. They are the user's
own substrate, written by [[bootstrap-survey]] and the Stage-3/4 loops, not per-race
artifacts:

- `philosophy-<user>.md` — the user's political philosophy. Source of truth for what
  the user believes; grows organically across cycles. Shape documented in
  [atlas/survey-and-philosophy](../atlas/survey-and-philosophy.md).
- `calibration-skills/*.md` — user-specific interpretation rules that don't generalize
  (the shared ones live in `you-decide/calibration-skills/` in this repo). Schema in
  [[SKILL]] (Disagreement loop → calibration skills).

## Private-dir resolution

This registry defines *names and shapes*; it does not decide *where the private dir
is*. That is resolved by `scripts/private-dir.sh`:

1. `$YOU_DECIDE_PRIVATE_DIR` if set (explicit override), else
2. the `who-to-vote-for` sibling of the repo root.

**In a brain install**, the durable anchor is the brain's `construct/deps`, which
declares the you-decide mount (`data <url> data/life/politics/you-decide`); the private
dir is the `who-to-vote-for` sibling of that mount
(`data/life/politics/who-to-vote-for`). Invoked through the brain symlink,
`private-dir.sh` already lands there — `construct/deps` is what makes that a contract
rather than a coincidence. See [atlas/overview](../atlas/overview.md).

The privacy boundary is the directory: anything under the private dir is the user's and
never committed to this repo; see [atlas/substrate](../atlas/substrate.md#why-split-public--private).
