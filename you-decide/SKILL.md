---
name: you-decide
description: Use when deciding how to vote in an election. Takes (address, year) or operates race-by-race. Auto-detects cold-start vs returning user; bootstraps philosophy via survey if needed. Resolves ballot, dispatches per-candidate research, applies user's philosophy via per-axis reads, aggregates with race-aware weighting to produce conscience + strategic votes with inference chains visible. Calibrates over time via the disagreement loop.
generated-by: human
generated-on: 2026-05-28
review: passed
---

# you-decide

Help the user decide how to vote in an upcoming election. The deliberation happens in the user's private dir (see Path conventions); the polished output is publishable ("the user's voter guide" format) once stable. This file is the **top-level algorithm**; it composes sub-skills ([[resolve-ballot]], [[identify-controversies]], [[bootstrap-survey]], [[review]]) and runs on a substrate of templates, calibration skills, candidate profiles, and the user's philosophy file.

**Goal posture: decision-help, not profile-building.** We do not try to capture the user's complete political identity upfront. The philosophy file starts sparse — enough to differentiate this cycle's candidates — and accumulates organically across cycles via (a) the Stage 4 disagreement loop, (b) just-in-time disambiguation in Stage 3 when an axis is load-bearing for a race but silent in the philosophy. After several cycles the user ends up with a richer self-portrait, but only as a side effect of getting decisions made. The user's trust in the tool and the tool's understanding of the user grow together — through use, not through more exhaustive surveys.

**Path conventions in this file.** Two roots:

- **Shared substrate** — `data/candidates/<year>/...`, `data/elections/<year>/...`, `data/controversies/...`, `data/sources/...`, `data/templates/...`, `you-decide/calibration-skills/` — is **repo-root-relative** (committed, reusable across users). The skill files live in the inner `you-decide/` folder (the skill bundle); the shared substrate sits under `data/` at repo root.
- **Private substrate** — everything under the **user's private dir** (`who-to-vote-for/...`): the user's `philosophy-<user>.md`, per-axis reads, `vote.md`, cast ballots, user-private `calibration-skills/`. **The name, location, and frontmatter of every private artifact the algorithm writes is defined in [[artifacts]] — the single authority; this file does not restate path patterns.** The private dir itself is resolved by `scripts/private-dir.sh`: `$YOU_DECIDE_PRIVATE_DIR` if set, otherwise the `who-to-vote-for` sibling of the repo root (so it's never inside the repo and a `git push` can't leak it). Resolve once per session via the script; announce the resolved location to the user the first time you write there.

A brain-integrated install reaches the repo via the symlink at `brain/data/life/politics/you-decide/`. The durable anchor for *where the private dir is* is the brain's `construct/deps`, which declares the you-decide mount (`data <url> data/life/politics/you-decide`); the private dir is the `who-to-vote-for` sibling of that mount. Invoked through the brain symlink, `private-dir.sh` already resolves there — `construct/deps` makes that a contract, not a coincidence. `$YOU_DECIDE_PRIVATE_DIR` remains available as an explicit override.

## Entry points

### Address-driven (recommended)

Invoke with the voter's address and (optionally) a year:

- `/you-decide 123 Main St, Menlo Park, CA` — auto-finds upcoming election
- `/you-decide 123 Main St, Menlo Park, CA 2026` — year explicit

The skill auto-detects:
- Whether the user has a `philosophy-<user>.md` (cold-start → triggers [[bootstrap-survey]] first)
- The upcoming election for the user's state (via [[resolve-ballot]])
- The user's districts (address → district mapping)
- Which candidates need research vs. already cached in the shared `data/candidates/` substrate

### Race-by-race (manual mode)

The conversational mode used during M0-M3 development. User names a specific race; the skill walks the algorithm for that one race. Useful when address resolution isn't needed, when running a focused refresh on a single race, or for development / acceptance testing.

## Inputs

| Input | Location | Role |
|---|---|---|
| Philosophy | `philosophy-<user>.md` | Values and axes substrate. The source of truth for what the user believes. |
| Calibration skills | `calibration-skills/*.md` | Accumulated judgments from prior disagreement loops. Apply automatically. |
| Per-office axis template | `data/templates/<office>.md` | Reusable axis weighting for a given office shape (governor, mayor, judge, etc.). |
| Candidate profiles | `<year>/<state>/<office>/<candidate>.md` | Genesis-tracked, with inline source URLs. Generate via research subagents if absent. |
| Current polling | Fresh WebSearch each cycle | Not persisted — moving target. Used for the strategic-vote analysis. |
| Race scope | Conversation with the user | Office, jurisdiction, voting system (top-2, ranked-choice, plurality), date, hard filters. |

## Cache-first by default

Every stage that has a cached artifact reuses it rather than regenerating. The skill re-dispatches research subagents (which cost AI cycles + burn web-fetch budget) only when:

- The cached artifact is **missing**
- The cached artifact is **stale** per its owning sub-skill's rules (e.g., proximity-to-election triggers in [[resolve-ballot]])
- The user **explicitly requests a refresh** (*"re-research Becerra; the AP article I just read contradicts the cached profile"*)

| Stage | Artifact | Cache location | Refresh trigger |
|---|---|---|---|
| 1 | Election manifest | `data/elections/<year>/<date>-<state>-<type>.md` | Per proximity-to-election rules in [[resolve-ballot]] |
| 2 | Candidate profile | `data/candidates/<year>/<state>/<race>/<slug>.md` | Candidate position changes (post-debate, post-major-news); otherwise indefinite reuse |
| 3 | Per-axis read | candidate-read ([[artifacts]]) | Philosophy / calibration-skill / candidate-profile newer than the read |
| — | Controversy map | `data/controversies/<year>/<state>.md` | Per cycle; refresh as new controversies surface |
| — | Source registry | `data/sources/<state>.md` | Rarely changes; manual maintenance |

The typical returning-user invocation (*"help me vote in Menlo Park, CA 2026"* with everything already populated) does ~zero new work in Stages 1-3 — they all hit cache. Stages 4 (disagreement loop) and 5 (aggregate + present) are where the actual deliberation happens.

## Algorithm

### Stage 0 — User-state detection
- Resolve the private dir via `scripts/private-dir.sh` (see Path conventions). Look for `philosophy-<user>.md` there.
- **Exists** (returning user): proceed to Stage 1.
- **Missing** (cold-start): invoke [[bootstrap-survey]], which:
  - Loads cycle controversies via [[identify-controversies]]
  - Runs the Headline 5 (always); offers Rounds 2/3/4 opt-in
  - Synthesizes `philosophy-<user>.md`
  - Returns control here once a philosophy exists

### Stage 1 — Resolve ballot
Invoke [[resolve-ballot]] with `(address, year)`. Returns a structured ballot manifest — every race and measure on the user's actual ballot for the resolved election day, filtered to contested by default. The manifest references candidate slugs that live in `data/candidates/<year>/<state>/<race>/<slug>.md`.

### Stage 2 — Per-candidate research (gap-fill from shared cache)
For each candidate in the resolved ballot:
- **Cached** (`data/candidates/<year>/<state>/<race>/<slug>.md` exists in the shared substrate): reuse — another user already researched this candidate.
- **Missing**: dispatch a research subagent that produces a candidate profile following the schema (Background, Stated positions, Record, Endorsements & donors, Controversies, Sources). The profile must be **born claim-bound** — load [[source-hygiene-tier-list]] (+ the relevant `data/sources/<jurisdiction>.md`) into the subagent prompt and require: every decisive claim traceable to a Tier-A/B source at the claim level (single-source-section rule), targeted per-subject fetches on multi-subject sources, and no claim dropped on a summary's silence. Genesis-tracking is a generation requirement, not just a review check. Output goes to the shared `data/candidates/` location so future users (or future runs) benefit.

Dispatch missing-candidate research subagents in parallel.

### Stage 3 — Per-axis read
**Cache-first**: if `<slug>-read.md` already exists and is newer than (a) the user's philosophy file, (b) the relevant calibration-skill files, and (c) the candidate profile it scored against, **reuse it**. The read is a pure function of those three inputs; nothing changed → re-running produces the same output.

Otherwise — first run, or one of the inputs changed — generate the candidate-read artifact (see [[artifacts]] for its path + frontmatter) in the user's private dir. Apply philosophy + per-office template + all calibration skills (general from `you-decide/calibration-skills/` + user-private from the user's `calibration-skills/`).

**Scoring contract** (use this exact shape; [[review]] checks it):

- Score each axis as integer in **[−2, +2]**
- Exception: institutionalist axis extends to **−4** when [[trump-era-cater-discount]] action-tier applies (cite the calibration skill explicitly)
- Apply per-office template weights: **heavy = ×2, medium = ×1, light = ×0.5**
- Compute `weighted-total = Σ (axis_score × template_weight)` as a scalar (no `/N` or `/max` framings — those drift across subagents)
- Frontmatter `weighted-total:` field MUST equal the body math
- Body math shown explicitly:
  ```
  Heavy:  (a + b + c + ...) × 2 = X
  Medium: a + b + c + ...       = Y
  Light:  (a + b + c + ...) × 0.5 = Z
  Total: X + Y + Z
  ```

Cite source fact + any calibration skill that influenced the read for each axis score.

**Just-in-time disambiguation** (in-line during read generation):

While scoring, if an axis is **load-bearing for this race** (two viable candidates differ substantively on it, and the difference would move the recommendation) AND **silent in the user's philosophy** (neither `philosophy-<user>.md` nor any calibration skill gives a clear signal), pause and ask the user a focused essay-style question — the same shape as `surveys/essay.md` questions: concrete framing, concrete examples to ground it, paragraph response invited. Keep stakes-implicit (do *not* say "this measures axis X" — that pushes toward considered-policy mode; see anti-pattern in [[question-bank]]).

Their answer:
- Drives the per-axis score for THIS read immediately
- Gets appended to `philosophy-<user>.md` as a new paragraph in the relevant section (or a new section if the axis didn't exist yet)
- Becomes permanent — applies to all future races and re-reads

This is just-in-time elicitation, not upfront-comprehensive. **Only ask if the disambiguation would significantly move the read between two real candidates** — don't probe for general philosophy completeness. The bar: "would knowing this change the recommendation?" If not, score 0 for that axis and move on.

Across cycles, just-in-time disambiguation + the Stage 4 disagreement loop are how the philosophy file grows. The user's philosophy becomes richer as they use the tool more, without ever sitting through an exhaustive survey.

### Stage 4 — Disagreement loop
Present per-axis reads + per-race aggregated recommendation. When the user pushes back, each correction crystallizes as a calibration skill — written to `who-to-vote-for/calibration-skills/` (user-private dir) or proposed for `you-decide/calibration-skills/` (shared) if the rule is generic. Update affected `-read.md` files and re-score.

### Stage 5 — Aggregate + present
Apply hard filters from the user's philosophy (auto-reject). Weight axes per the office template. Surface ranked recommendation with inference chain visible. Two outputs by default — **conscience vote** (best-fit across all axes) and **strategic vote** (best-fit among top-N polling). Note divergence (often the most decision-relevant signal). Frame as **risk-mode** not scorecard (see "Recommendation framing" below).

### Stage 6 — Final write
When disagreement loop converges, write the race-vote artifact per race (see [[artifacts]] for its path + frontmatter) — captures conscience vote, strategic vote, general-election scenarios, parked open questions, and calibration skills active for this race. When the user later reports how they actually voted, record a cast-ballot artifact ([[artifacts]]) reconciling the marked ballot against the guide.

### Review gate (before committing shared substrate)
Before any commit to the shared `data/candidates/`, `data/elections/`, `data/controversies/` directories, dispatch [[review]] — a fresh-context, ideally-different-AI-stack check on source-hygiene + genesis tracking + math correctness + disambiguation + internal consistency. Output goes to `data/reviews/<year>/<date>-<batch>.md`; per-file frontmatter gets `last-reviewed:` + `review-pass:` + `review-stack:` updates. Candidate reads ([[artifacts]]) are user-private but can be reviewed by the same mechanism to catch arithmetic errors.

## Axis taxonomy (five tiers)

Tiers 1, 2, 5 carry uniform weight across races. Tiers 3 and 4 weighting depends on the office (see templates).

**Tier 1 — Character & temperament** (universal)
- *Smart and logically consistent* — preference for coherent thinkers
- *Anti-hypocrisy / prefer flawed-honest* — trusts visible motives over politically-correct surface; willing to work with someone whose flaws are known
- *Anti-personalist-strongman* — Trump-on-character is current instance; tolerates pragmatic cater but rejects personalist mode

**Tier 2 — Institutional posture** (universal)
- *Institutionalist / procedural-justice* — respects election results, court orders, due process; substantive justice is a moving target
- *Leave-people-alone* — libertarian default on social regulation
- *Secular-pluralist* — religious-nuts-in-power breaks the system

**Tier 3 — Economic philosophy** (heavy for executive/legislative; minor for judicial)
- *Fiscally-conservative / grow-pie-before-spending* — skeptical of cause-bonds, tax-and-spend
- *Builder-mentality* — regulation cost is real; fix-forward, don't stop
- *Anti-union, pro-ownership-floor* — protect workers structurally (S&P 500 baby fund), not via collective bargaining

**Tier 4 — Issue positions** (weights vary by office; see templates)
- *Housing*: zoning-realism, root-cause-before-bonds
- *Energy*: cost-down-not-just-green, climate-adapt-not-alarmism
- *Public safety*: strict-rules + mentally-ill-need-help-not-jail + cost-aware-geography
- *Immigration*: legal-pathway + humane-on-residence + incentives-against-illegal
- *Healthcare*: basic-tier-for-population-health + no-heroic-end-of-life + allow-rich-to-spend-drives-innovation
- *Crypto*: scam-on-coins + blockchain-fine + sovereign-finality-needed

**Tier 5 — Social values** (universal)
- *Socially-liberal* (extension of leave-people-alone)
- *Education-investment* (especially early)
- *Work + opportunity belief*

When `philosophy-<user>.md` evolves, update this taxonomy. The taxonomy is the *interface*; the philosophy file is the *implementation*.

## Hard filters

Auto-reject conditions that override aggregation. Declared in the philosophy file's "Hard limits" section (append as they accumulate).

Currently established:
- *Promotes 2020-election-fraud claims* — violates institutionalist
- *Attempted to seize ballots or interfere with election machinery* — violates institutionalist
- *Personalist-strongman support* (not pragmatic cater) — violates anti-Trump-on-character

When the user confirms a new hard filter mid-race, append to `philosophy-<user>.md` under "## Hard limits" so it persists for future races.

## Strategic posture

By default produce both:

- **Conscience vote** — best fit across all axes from the full surviving candidate pool. "Who the user would actually prefer."
- **Strategic vote** — best fit among top-N candidates in current polling (default N=4). For top-2 primaries, focuses on influencing which two advance. For ranked-choice, conscience-vote framing applies (rank by alignment).

If conscience and strategic diverge, flag explicitly — that gap is often the most important thing to discuss.

## Recommendation framing — risk-mode, not scorecard-mode

The aggregated per-axis score is an analytic substrate, **not** the recommendation. When presenting, frame as *"which risk are you choosing to accept"* rather than *"candidate X scored +N on the matrix."* Codex peer review (2026-05-27) pushed back on the original mechanical-scorecard framing — it obscured the actual decision the user was making.

The risk inventory for any race typically includes:
- **Institutional risk** — candidates that fail hard filters or stewardship axis
- **Fiscal risk** — tax-and-spend trajectory; donor concentration; cause-bond defaults
- **Capture risk** — donor / faction / agency capture once in office
- **Hypocrisy risk** — documented inconsistency between rhetoric and behavior
- **Viability risk** — strategic vote landing on a candidate who can't make it
- **Establishment risk** — long-career candidates as system-defenders vs. system-creatures (see [[establishment-career-not-equals-institutionalist]])

When conscience and strategic recommendations diverge, present as: *"Conscience vote accepts risk profile A; strategic vote accepts risk profile B; the gap means X."* User picks which risk to take; the algorithm doesn't paper over the choice.

## Disagreement loop → calibration skills

When the user pushes back on a per-axis read:

1. Capture the rule he applied (e.g., *"for CA Democrats, oil-industry money is signal not deal-breaker unless paired with explicit denial"*).
2. Write to `calibration-skills/<slug>.md`:

```markdown
---
rule: <short statement>
applies-to: <office types, party, axis>
born-from: <date> | <race> | <which candidate triggered it>
---

# <Rule title>

<Rule in full prose, with the disagreement context.>

## When it applies
<Office types, candidate types, axes affected.>

## Don't confuse with
<Adjacent rules; when this one does NOT fire.>
```

3. Update the affected candidate profile's alignment section.
4. Subsequent reads apply the skill automatically — pull all `calibration-skills/*.md` into context at stage 4.

These skills are the user's interpretation function accumulating over cycles. Load-bearing.

## Output format

When the disagreement loop converges, write the race-vote artifact (path + frontmatter in [[artifacts]]). Body structure:

```markdown
# Vote rationale — <race>

## Hard-filter pass
Who was eliminated and why (cite the philosophy clause).

## Per-axis matrix
Candidates × dominant axes. Cell: score + one-line rationale.

## Conscience vote
<Candidate>. Inference chain.

## Strategic vote (top-N polling)
Polling citations. <Candidate>. Inference chain.

## Divergence
If conscience ≠ strategic, what the gap means.

## Calibration skills created this race
List of new `calibration-skills/<slug>.md` files born from this race's disagreements.
```

## Address-driven flow (short version)

```
0. User-state detection  → cold-start? → bootstrap-survey → philosophy-<user>.md
                         → returning?  → proceed
1. Resolve ballot        → resolve-ballot(address, year) → race+candidate manifest
2. Candidate research    → gap-fill missing from shared data/candidates/ cache
3. Per-axis reads        → philosophy × template × calibration-skills per candidate
4. Disagreement loop     → user pushback → calibration-skills/ → re-score
5. Aggregate + present   → hard filters → weights → conscience + strategic + risk-frame
6. Final write           → vote.md per race
```

The race-by-race manual mode collapses Stage 1 (uses user-named race instead of resolver) and runs everything else identically.

## When NOT to use

- Races where the user already has a confident pick and just wants to vote.
- Races outside his jurisdiction.
- Symbolic / write-in choices where analysis adds nothing.

## Publishing (later, not now)

The polished `vote.md` is the candidate for publication as "the user's voter guide" — markdown out of the private dir → public repo → static-site renderer (e.g. Astro), following the standard personal-site publishing pattern. The private workshop (disagreement loop, intermediate reads) stays in the private dir.
