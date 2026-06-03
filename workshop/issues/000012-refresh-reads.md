---
id: 000012
status: open
deps: []
github_issue:
created: 2026-06-02
updated: 2026-06-02
estimate_hours: 3
---

# refresh-reads: stale-read detector + re-score driver

## Problem

Editing a user's `philosophy-<user>.md`, a calibration skill, or a candidate dossier silently invalidates the downstream `-read.md` + `vote.md` cache. SKILL.md Stage 3 *specifies* the staleness predicate ("a read is stale if philosophy / any calibration skill / the dossier is newer than it") but nothing **executes** it — there's no driver that finds the stale reads and re-scores them. Concretely: on 2026-06-02 the philosophy gained a Progress/positive-sum lens + Backbone section + a new `progress-over-status-quo` calibration skill, which staled essentially every read in the private dir, with no mechanism to detect or refresh them.

## Spec

Two layers, matching the deterministic-shell-over-model-capability principle:

1. **Detector (hard, deterministic shell)** — `scripts/stale-reads.sh`. Compares **frontmatter dates**, not mtime (mtime is fragile under git checkouts + autosave). For each `<private>/**/*-read.md` and `<private>/**/vote.md`, take its effective date = `revised` || `read-date` || `generated-on`, and flag STALE if any input is newer:
   - reads → `philosophy-<user>.md`, every `calibration-skills/*.md`, and the dossier named in the read's `candidate:` frontmatter (`last-updated`).
   - `vote.md` → philosophy, calibration-skills, and the sibling `*-read.md` files in the same race dir (a vote is downstream of its reads).
   Resolve the private dir via `scripts/private-dir.sh`. Print each stale file + the newest input that triggered it. `--quiet` prints paths only; nonzero exit when any stale (CI/hook-able). Dates are ISO `YYYY-MM-DD` → lexicographic compare is correct.
2. **Driver (soft layer)** — `you-decide/refresh-reads.md` sub-skill: run the detector → for each stale read, re-score against current inputs per the SKILL Stage-3 scoring contract → update the read, propagate to its `vote.md`, and report **what moved** (old → new total + which axis/skill drove it). Re-score is dispatchable per-read to a cheaper model / subagent.

Scope: build **refresh-reads (inference)** only. The sibling **refresh-facts** (drives Stage 1–2 dossier re-research: web + source-hygiene + cross-stack review) is the natural pair but is YAGNI until a fact-refresh actually fires — note it in SKILL.md and leave a follow-up.

## Done when

- `scripts/stale-reads.sh` exists, is deterministic (frontmatter-date based), prints stale files + reason, exits nonzero when any stale, and has a `scripts/tests/` case.
- `you-decide/refresh-reads.md` documents the run → re-score → propagate → report loop; linked from SKILL.md's cache-first table.
- Dogfooded: the detector, run on the live private dir after the 2026-06-02 philosophy change, correctly flags the stale reads; ≥1 race re-scored end-to-end through the loop as the acceptance run, with what-moved logged here.

## Plan

- [x] `scripts/stale-reads.sh` — frontmatter-date staleness detector + `scripts/tests/test-stale-reads.sh` (green)
- [x] `you-decide/refresh-reads.md` sub-skill + link from SKILL.md cache-first table
- [x] Dogfood: detector flagged 47 stale artifacts on the live dir; Governor race re-scored end-to-end; what-moved logged below
- [x] (defer) `refresh-facts` sibling noted in SKILL.md + refresh-reads.md — follow-up issue deferred (YAGNI until a fact-refresh fires)

## Log

### 2026-06-02
Issue created from a brainstorm: philosophy edit (Progress lens + Backbone + `progress-over-status-quo` skill) staled the read cache; user asked for a refresh skill. Confirmed design: deterministic frontmatter-date detector (script) + soft re-score driver (sub-skill); inference-refresh now, fact-refresh deferred.

**Built + dogfooded.** `scripts/stale-reads.sh` + `scripts/tests/test-stale-reads.sh` (both green); `you-decide/refresh-reads.md` sub-skill; linked from SKILL.md cache table. Detector on the live private dir flagged **47** stale artifacts (philosophy 2026-06-02 newer than every read) and correctly *excluded* the D23 marc-berman files already re-scored to 2026-06-02 — date logic verified.

**Acceptance run — Governor race** (richest test of the new lenses), re-scored via a subagent (dogfooding the offload pattern):
| Candidate | old → new | driver |
|---|---|---|
| Mahan | +11 → +12 | [[progress-over-status-quo]]: tech-donor capture now *light* (pie-growing force) → anti-hypocrisy −2→−1 |
| Hilton | +6 → +7 | anti-personalist −2→0 (narrowed to Trump-*type*; institutional risk stays on institutionalist axis, no double-count) |
| Bianco | −3 → −2 | anti-personalist −2→0 (ballot-seizure already −4 institutional; personalist hit was a double-penalty) |
| (5 others) | no change | re-scored, confirmed; dates bumped |

Ordering + recommendation unchanged (Villaraigosa conscience, Becerra/Hilton strategic) — the philosophy edits *formalized* prior intent rather than overturning it. Detector re-run → Governor fully clears.

**Findings surfaced by the dogfood (follow-ups):**
1. **Date-bump-on-no-change is load-bearing.** The driver must set `revised:` on EVERY re-scored read, including unchanged ones — else the detector can't distinguish "not yet refreshed" from "refreshed, unchanged." The refresh-reads skill already prescribes this; the acceptance subagent initially skipped it (5 unchanged reads stayed flagged until bumped). Candidate for `workshop/lessons.md`.
2. **Consolidated guide not in detector scope.** `who-to-vote-for/**/menlo-park-*-ballot.md` is downstream of the per-race `vote.md`s but is neither a `-read.md` nor a `vote.md`, so the detector doesn't track it; it needs a manual re-sync after a race re-score (done by hand here for Governor). Extend the detector to track consolidated guides, or add a `consolidate` step. → new issue.
3. **Stale `candidate:` paths.** Reads point at `you-decide/candidates/...` but dossiers live at `you-decide/data/candidates/...`; the detector resolves the dossier by path-convention as a workaround. Fix the frontmatter field (relates to #000006). → fold into #000006 or new issue.
