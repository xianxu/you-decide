---
name: review
description: Use after research-subagents produce facts or scoring subagents produce per-axis reads, AND before any commit to the shared substrate (candidates/, elections/, controversies/). Runs in fresh context (no shared session memory) and ideally a different AI stack to independently check (a) source-tier compliance per source-hygiene-tier-list, (b) genesis tracking — every claim has source URL, (c) math correctness in weighted totals, (d) internal consistency, (e) disambiguation of common names. Outputs a review report to `reviews/<year>/<date>-<batch>.md` and updates per-file `last-reviewed:` + `review-pass:` frontmatter.
generated-by: human
generated-on: 2026-05-28
review: passed
---

# review

## Why this exists

Producing subagents are fast and reasonable but make mistakes — score-scale drift (some report X/14, some report weighted -2/+2 totals), arithmetic errors in weighted totals, weak-source citations slipping through, candidate-name disambiguation failures (Kevin Johnson the law student vs Kevin Johnson the former Sacramento mayor). An independent review catches these *before* committed substrate becomes content downstream users trust.

This sub-skill is the institutional check on AI-curated content. **Fresh context, different stack** are the two requirements that make it actually independent. Without them it's just re-running the same biases.

## Per-file frontmatter contract (the greppable part)

**Every markdown artifact in this repo + in users' private dirs carries explicit review state in frontmatter.** Unreviewed state is *named explicitly* (`review: not-done`), not implied by absence — that way "what hasn't been reviewed" is a positive grep: `rg '^review: not-done' .` rather than a negated one. Operators and CI can audit coverage trivially.

Required fields on every artifact:

```yaml
---
# ... (existing schema fields for the file type)

generated-by: claude | codex | gemini | human | mixed
generated-on: YYYY-MM-DD
review: not-done | passed | issues-flagged | failed
reviewed-by:           # set when review ≠ not-done; must differ from generated-by for cross-stack independence
reviewed-on:           # ISO date; set when review ≠ not-done
review-ref:            # path to the review report; required when review ≠ passed
---
```

Conventions:

- **Producing skills MUST set** `generated-by` + `generated-on` + `review: not-done` at write time. Never omit the `review:` field, even on first write.
- **Review skill updates** `review:`, `reviewed-by`, `reviewed-on`, `review-ref` after a fresh-stack pass.
- **Author-curated algorithm files** (templates, calibration-skills, sub-skill markdown, README, sources/) can use `generated-by: human` + `review: passed` since they go through git-PR review rather than AI-mediated review. Still carry the fields for consistency.
- **Cross-stack-independence check**: a hook or audit script flags any file where `generated-by == reviewed-by` (same-stack review doesn't count).

Audit queries:

```bash
# Anything that hasn't been reviewed yet (the most important grep)
rg '^review: not-done' .

# Anything reviewed-with-issues that needs follow-up
rg '^review: (issues-flagged|failed)' .

# Cross-stack coverage: producing-stack distribution
rg '^generated-by:' . | sort | uniq -c

# Same-stack reviews (invalid — should be empty)
# (requires per-file check; one-liner only approximates)
```

## Data gaps — DATA-GAP / DATA-FIXME

Some data quality issues are permanent fixtures, not transient bugs: a campaign-finance source that 403s, a claim no Tier A/B source confirms, a stale count. The substrate must **tolerate** these — the failure modes to avoid are (a) asserting an unverified fact anyway, and (b) parking a file in `issues-flagged` forever because one gap can't be closed. The convention: log the gap **inline, visibly, next to the fact it concerns**, and move on.

Two tokens (visible markdown, never HTML comments — transparency is the point):

- **`DATA-GAP`** — a fact is **missing or unverified** (couldn't fetch / no source confirms).
- **`DATA-FIXME`** — a fact is **present but known-wrong** and needs correction (stale count, contradicted claim).

Shape:

```
**DATA-GAP** [axis: <axis-slug | none>; severity: low|med|high; last-attempt: YYYY-MM-DD]: <what is missing/wrong> — <why (e.g. 403, no source)> — <how it's handled now>.
```

- **axis** — the scoring axis the gap bears on (`capture-risk`, `institutionalist`, …), or `none` for cosmetic/biographical gaps that touch no score.
- **severity** — potential to move a read: `low` (unlikely to change the rec), `med`, `high` (could flip conscience/strategic).
- **last-attempt** — the date resolution was last tried. This drives retry cadence: a sweep greps for gaps whose `last-attempt` is older than a threshold (transient 403s often recover) and re-attempts; `severity: high` can retry sooner. Update it on every retry, whether or not it succeeded.

### Scoring impact lives in the read, not the profile

The candidate profile is **shared** (one file, all users); a gap's *impact* depends on the user's axis weights, so it can't be a single number in the shared profile. The profile marker carries only the **handle** — which `axis` the gap touches. The **realized impact** is recorded in the per-user read (`who-to-vote-for/.../<slug>-read.md`): score the axis low-confidence and name the gap, e.g. *"capture-risk: 0 (low-confidence) — DATA-GAP in profile; if donor concentration is high this moves to −1."* Filling the gap updates the profile, which invalidates the read under the Stage-3 cache rule (profile newer than read → re-score) — so resolution propagates to the decision automatically.

### Gaps are orthogonal to review-state

A file with **honestly-marked gaps and no unsupported claims can be `review: passed`.** The review verified everything verifiable; documented debt is not a review failure. **Severity, not the token, governs blocking:** a med/high marker (an actually-wrong fact, or a missing fact a decisive claim silently leans on) blocks `passed` until resolved; a `low` marker (an unfillable `DATA-GAP`, or a `DATA-FIXME` for a claim that is plausibly correct but under-tier-sourced) is tolerable debt — log it and pass. Do not hold a file in `issues-flagged` solely for a `low` marker.

### Rollup

`rg 'DATA-GAP|DATA-FIXME' candidates/` is the live debt list. Optionally generate `reviews/DATA-GAPS.md` tabulating by severity × axis × staleness (a script greps + sorts). Individual gaps stay inline; only **systemic** remediation (e.g. "build an FPPC/FEC fetcher to close finance gaps in bulk") belongs in `workshop/issues/` as tooling work.

**Routing rule (where does a follow-up live?):** *data-content* debt — a missing/unverified/under-sourced fact in a substrate file — is an inline `DATA-GAP`/`DATA-FIXME`, tracked by grep. *Schema / tooling / convention* work — file-format conformance, a script, an algorithm change — is a `workshop/issues/` item. Litmus: "is this a property of a specific fact, or a thing to build/decide?"

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

For each file checked, update the [per-file contract](#per-file-frontmatter-contract-the-greppable-part) fields:
- `review: passed` | `issues-flagged` | `failed` (replace the prior `not-done`)
- `reviewed-by: <reviewer-stack>` (must differ from `generated-by`)
- `reviewed-on: <date>`
- `review-ref: reviews/<year>/<date>-<batch>.md` (required if review ≠ passed; nice-to-have if passed)

Makes coverage queryable: `rg '^review: not-done' .` returns the unreviewed set.

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

## Commit-gate convention — one commit per handoff

Review is a **turn-based loop between two isolated stacks** (e.g. Codex reviews, Claude produced + fixes), and **each turn ends in a commit**. Git history *is* the review's audit trail — what was flagged, what was fixed, what was re-checked — each turn attributed to the stack that did it. Because the two sessions share one working tree, they MUST take turns (one stack live at a time); each turn starts from the other's commit (`git pull`/fresh checkout first).

### The loop

1. **Review** (reviewer stack). Run this skill's checklist (Stage 1–2). Commit **only** the report (Stage 3) + per-file review-state frontmatter (Stage 4).
   - Commit msg: `review: <stack> r1 — <batch> (<status>: N blockers)`; trailer `Reviewed-by: <stack>`.
   - Flag: `not-done → issues-flagged` (or `passed` if the round is clean).
2. **Fix** (producer/fixer stack). Read the report; correct the **content** of flagged files. The commit body classifies every finding as **fixed**, **deferred** (with reason), or **disputed** (with rationale).
   - Commit msg: `fix: address <stack> rN review — <summary>`.
   - Flag: **leave at `issues-flagged`.** The fixer does NOT set `passed` — self-certifying a fix you authored defeats the independent check. The commit *sequence* (your fix between two review commits) already records "fix pending re-check."
3. **Re-review** (reviewer stack). **Diff-scoped:** check only (a) were the flagged findings addressed, (b) did the fixes regress anything — NOT a fresh full audit (round 1 was that). Commit a new report (`…-rN.md`) + flag flips.
   - Flag: `issues-flagged → passed` when cleared. **Only the re-reviewer flips to `passed`.**
4. **Repeat 2–3** until the re-review passes. Cap at ~3 rounds.

### Boundaries that keep it converging

- **Reviewer write-surface = the report + review-state frontmatter, nothing else.** The reviewer never edits the body/facts of a file under review — content corrections are the fixer's turn, so every fix stays independently attributable and re-reviewable. (Updating `review:`/`reviewed-by`/`reviewed-on`/`review-ref` is review *metadata*, not content — that IS the reviewer's job, per Stage 4.)
- **Deferral is a valid outcome, not a failure.** A finding you can't close by verification (a 403'd campaign-finance source, a search-result-only citation) is legitimately cleared by **demoting the claim to an explicit "Data gap"** — the file stops *asserting* the unverified thing. Never invent facts to satisfy a finding.
- **Disputes escalate, capped.** Disagree with a finding? Dispute it in the fix commit body with rationale — never silently skip it. If reviewer and fixer still disagree after ~2 rounds, escalate to the operator as tiebreaker. Two stacks must not ping-pong indefinitely.

A pre-commit hook can enforce "no commit to `candidates/`/`elections/`/`controversies/` without a current `review-ref`" (see `workshop/issues/000004`), but for MVP it's a convention.

## Spawning the other stack (cross-stack review mechanics)

The review's independence requirement is **a different AI stack than `generated-by`** (Stage 1). The driver — whichever stack is running the main session — spawns the *other* stack one-shot to do (or take) a review turn. Either direction works; the mechanics are symmetric.

The driver may either (a) shell out to the other stack's CLI directly, or (b) wrap that CLI call in one of its own sub-agents (keeps the reviewer's verbose output out of the driver's context — the sub-agent runs the CLI, verifies the result, returns a digest). (b) is preferred for a clean main context.

Both CLIs run agentically and may take minutes — give the call a long timeout (≈600s) or run it detached. Both invocations below **skip approval/sandbox prompts** so the one-shot doesn't stall; that's safe *because the driver is already running inside its own sandbox* (the external-sandbox case these flags are built for). The reviewer must read this file first, then write only the report + `review:` frontmatter and commit its own turn signed per `AGENTS.md` §12.

### Claude driving → spawn Codex (reviewer)

```bash
codex exec --dangerously-bypass-approvals-and-sandbox -C <repo-root> "<REVIEW PROMPT>"
# or pipe a long prompt via stdin:  codex exec --dangerously-bypass-approvals-and-sandbox -C <repo-root> - < prompt.txt
```
- Config lives in `.codex/config.toml` (`sandbox_mode = workspace-write`); the bypass flag overrides approval pauses for the one-shot.
- Commit trailer: `Co-Authored-By: <Codex model> <noreply@openai.com>`.

### Codex driving → spawn Claude (reviewer)

```bash
claude -p "<REVIEW PROMPT>" --dangerously-skip-permissions --add-dir <repo-root>
# scope tools if you prefer least-privilege instead of the blanket bypass:
#   claude -p "…" --permission-mode acceptEdits --allowedTools Read Edit Write Bash Grep
```
- `-p/--print` is headless mode; `--dangerously-skip-permissions` is the analogue of Codex's bypass (lets the reviewer Edit/Write the report+frontmatter and run `git` without prompts).
- Commit trailer: `Co-Authored-By: <Claude model> <noreply@anthropic.com>`.

### Prompt skeleton (either reviewer)

> Read `you-decide/review.md` in full — it defines your procedure, write-surface (report + `review:` frontmatter ONLY, never the body/facts), and the DATA-GAP/DATA-FIXME + severity-governs-blocking rules. You are the **<reviewer-stack>** reviewer. [If re-review:] This is round N — **diff-scoped**; `git log`/`git diff` the fix commits since the prior report (`reviews/.../…-r{N-1}.md`); verify only those findings + check for regressions, do not re-audit untouched files. Write `reviews/<year>/<date>-<batch>[-rN].md`, flip cleared files `issues-flagged → passed` (severity governs: low debt is passable), and commit `review: <stack> rN — <batch> (<status>)` with the `Co-Authored-By` trailer above.

When wrapping in a sub-agent, also have the sub-agent **verify** afterward (`git log`, the new report's status, `git show --stat` to confirm the commit is report + frontmatter only) and return a digest — never let the wrapping agent edit substrate itself.

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
