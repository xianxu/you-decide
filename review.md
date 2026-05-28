---
name: review
description: Use after research-subagents produce facts or scoring subagents produce per-axis reads, AND before any commit to the shared substrate (candidates/, elections/, controversies/). Runs in fresh context (no shared session memory) and ideally a different AI stack to independently check (a) source-tier compliance per source-hygiene-tier-list, (b) genesis tracking — every claim has source URL, (c) math correctness in weighted totals, (d) internal consistency, (e) disambiguation of common names. Outputs a review report to `reviews/<year>/<date>-<batch>.md` and updates per-file `last-reviewed:` + `review-pass:` frontmatter.
---

# review

## Why this exists

Producing subagents are fast and reasonable but make mistakes — score-scale drift (some report X/14, some report weighted -2/+2 totals), arithmetic errors in weighted totals, weak-source citations slipping through, candidate-name disambiguation failures (Kevin Johnson the law student vs Kevin Johnson the former Sacramento mayor). An independent review catches these *before* committed substrate becomes content downstream users trust.

This sub-skill is the institutional check on AI-curated content. **Fresh context, different stack** are the two requirements that make it actually independent. Without them it's just re-running the same biases.

## Parameters

| Field | Required | Notes |
|---|---|---|
| `batch` | yes | Logical name for the review report. Becomes the filename in `reviews/<year>/<date>-<batch>.md`. Conventional shape: `<state>-<jurisdiction>-<date>` (e.g. `CA-Palo-Alto-2026-05-28`) or `<producing-skill>-<date>` |
| `reviewer-stack` | recommended | AI provider running the review. **Must differ from the producing stack.** If producing was Claude/Anthropic → review with Codex/OpenAI or Gemini. Recorded in the review report's frontmatter; later audited via `rg 'reviewer-stack:' reviews/` |
| `producing-stack` | annotation | Which AI made the substrate being reviewed (Claude / Codex / Gemini / mixed). Recorded for cross-stack-coverage tracking |
| `scope` | optional, default `all-shared` | Categorical filter: `candidates` / `elections` / `controversies` / `reads` / `all-shared` (= candidates+elections+controversies) / `all` (= shared + reads). User-private reads are usually reviewed via a personal-brain pass, not the public-substrate flow |

### Breadth selection (which files exactly)

One of the following mode-selectors. Precedence is top-down — first one given wins.

| Mode | When to use | Resolves to |
|---|---|---|
| `target-files: [<glob>, ...]` | Spot-check a specific list; explicit overrides everything | Just those files |
| `since-commit: <ref>` | Pre-commit gate; review what changed since a known-good ref | `git diff --name-only <ref> HEAD` ∩ scope-filter (+ unstaged if `include-uncommitted: true`) |
| `since-date: YYYY-MM-DD` | Time-window batch (e.g. "everything I produced this morning") | Files modified after the date ∩ scope-filter |
| `older-than-review: <duration>` | Periodic freshness audit | Files whose frontmatter `last-reviewed` is older than e.g. `30d` / `3mo` / `1y`, OR never reviewed ∩ scope-filter |
| *(default — none of the above given)* | Most common: review uncommitted changes before committing | All uncommitted (modified + untracked) files in the working tree ∩ scope-filter |

All modes are intersected with the `scope` filter as the final narrowing step.

### Examples

Post-research batch (most common — fix the Palo Alto case):
```
review:
  batch: CA-Palo-Alto-2026-05-28
  reviewer-stack: codex
  producing-stack: claude
  scope: candidates
  # no breadth selector → default to all uncommitted under candidates/
```

Pre-commit gate:
```
review:
  batch: pre-commit-2026-05-29
  reviewer-stack: gemini
  since-commit: HEAD
  scope: all-shared
```

Periodic freshness audit (annual sweep):
```
review:
  batch: freshness-audit-2027-01
  reviewer-stack: codex
  older-than-review: 1y
  scope: all-shared
```

Spot-check:
```
review:
  batch: spot-2026-06-15
  reviewer-stack: codex
  target-files: [candidates/2026/CA/governor/xavier-becerra.md]
```

## Algorithm

### Stage 1 — Fresh-context invocation

Dispatch as a single-purpose subagent (or human-driven review session) with **no shared session memory**. Load only:
- The files to review (target-files)
- `calibration-skills/source-hygiene-tier-list.md` (tier principle)
- `sources/<state>.md` + `sources/US.md` (concrete authoritative outlets)
- The relevant office template (for score-scale validation)
- This skill ([[review]]) for the checklist

**Do NOT load**: prior reads, conversational context, user preferences, philosophy file. The reviewer is checking facts + math, not values.

### Stage 2 — Run the checklist

For each file in scope, check the following classes of issue. Severity is `blocker` (must fix before commit), `important` (fix before next batch), `minor` (note for later).

**Source-hygiene (every factual claim)** — blocker
- Inline source URL present for every non-trivial claim
- Source tier acceptable: Tier A/B for decisive claims; Tier C only for orienting context + explicit tilt-flag
- Sources match patterns in `sources/<state>.md` / `sources/US.md` — flag novel sources for tier assignment

**Genesis tracking** — blocker
- Every claim has a URL link (no genesis-untracked assertions)
- No artifact leakage: grep for `WebSearch`, `franding`, `TBD`, `<unknown>`, placeholder URLs (`[text]()` patterns)

**Math correctness (for `-read.md` files)** — blocker
- Per-axis scores within scale: `-2 to +2` for all axes; `-4` allowed only for institutionalist + only when [[trump-era-cater-discount]] action-tier is cited
- Frontmatter `weighted-total:` equals body math
- Body math formula: `Σ (axis_score × template_weight)` where template_weight is `heavy=2`, `medium=1`, `light=0.5` per the office template
- Score-scale consistency across reads in the same race (no /14 alongside /26 alongside +N-weighted)

**Internal consistency** — important
- Frontmatter race / name / slug match body title and content
- Cross-references resolve: every `[[slug]]` points to a real slug; relative paths exist as files
- No contradictions between sections (e.g., Tier-B-cited source in Sources but Tier-C label in body)
- `last-updated` date matches commit date

**Disambiguation** — important
- Common names flagged: any "Kevin Johnson", "David Johnson", "John Smith", etc. require explicit "this is X (occupation, year, prior office), NOT the more-famous Y" disambiguation
- Cross-check identifying details against ≥2 sources (degree, year of birth, prior office, employer)

**Schema conformance** — minor
- File matches the per-type schema in [[SKILL]] / [[resolve-ballot]] / [[identify-controversies]]
- Required sections present
- Frontmatter fields present and well-formed

### Stage 3 — Output review report

Write to `reviews/<year>/<YYYY-MM-DD>-<batch>.md`:

```markdown
---
batch: <batch-id>
date: YYYY-MM-DD
reviewer-stack: <which AI provider>
producing-stack: <which AI provider made the original>
scope: <candidates|elections|controversies|reads|all>
files-reviewed: <N>
issues-blocker: <N>
issues-important: <N>
issues-minor: <N>
status: pass | issues-flagged | fail
---

# Review — <batch-id>

## Issues found

### blocker

#### `<file path>` — <issue-type>
<specific issue + suggested fix>

### important
...

### minor
...

## Files cleared (no issues)
- `<path>`
- `<path>`

## Notes / observations
- <anything else worth flagging>
```

### Stage 4 — Update per-file frontmatter

For each file checked, add/update:
- `last-reviewed: YYYY-MM-DD`
- `review-pass: true` | `issues-flagged` | `false`
- `review-stack: <reviewer-stack>`
- `review-ref: <relative path to review report>` (if not pass)

This makes review status queryable: `rg '^review-pass: false' candidates/` finds anything blocking.

## State tracking

Reviews accumulate in `reviews/<year>/<date>-<batch>.md`. Queries:

```bash
# All reviews of a given year
ls reviews/2026/

# Producing-stack distribution
rg '^producing-stack:' reviews/

# Find unfixed blockers
rg '^status: fail' reviews/

# Cross-stack coverage
rg '^reviewer-stack:' reviews/ | sort -u
```

A long-running `reviews/COVERAGE.md` maintained by hand can track which jurisdictions × cycles have been reviewed and by which stacks — useful for deciding "is the CA 2026 substrate trustworthy enough to publish."

## Commit-gate convention

Every commit to `candidates/`, `elections/`, `controversies/` should have a corresponding review report. Suggested workflow:

1. Run research → write files (uncommitted)
2. Dispatch `review` skill with different stack
3. Read review report; fix any blockers
4. Re-review if blockers fixed
5. Commit, referencing review report in commit message (`Review: reviews/2026/2026-06-02-CA-Palo-Alto.md status=pass`)

A pre-commit hook can enforce this, but for MVP it's a convention — relies on the operator running review before commit.

## When NOT to use

- Re-reviewing a batch that's already passed (idempotent but unnecessary cost)
- Quick experimental runs that won't commit
- User-private artifacts in `who-to-vote-for/` (subjective by design; review is for shared factual substrate)
- Algorithm changes (SKILL.md, sub-skills, templates) — those are PR-reviewable through normal GitHub flow

## Cross-references

- Source quality principle: [[source-hygiene-tier-list]]
- Per-state authoritative sources: `sources/<state>.md`
- Per-office templates: [[templates]] (for score-scale + weight validation)
- Main algorithm: [[SKILL]]
- Producing skills: [[resolve-ballot]], [[identify-controversies]], candidate research dispatches
