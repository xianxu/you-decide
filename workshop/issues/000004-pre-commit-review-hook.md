---
id: 000004
status: working
deps: []
github_issue: xianxu/you-decide#3
created: 2026-05-28
updated: 2026-05-30
estimate_hours: 1.0
---

# Pre-commit review hook + data/reviews/COVERAGE.md tracking

## Problem

The `review.md` sub-skill is in place — every commit to shared substrate (`data/candidates/`, `data/elections/`, `data/controversies/`) should pass through it with a different AI stack before merging. But the convention is operator-driven; without tooling, the discipline erodes (first commit-without-review is a slippery slope).

The whole "AI-curated not crowdsourced" pitch in the README depends on the substrate being trustworthy. Tooling makes the convention load-bearing.

## Spec

### Where the gate belongs: publish, not commit (revised — see Revisions)

The original spec said "pre-commit hook." That assumes **commit = "this is ready."** But in this workflow **commit = checkpoint + agent handoff** (the inspectable filesystem-handoff pattern): the fixer commits `issues-flagged` files and the reviewer later commits the flip to `passed`. Gating *commits* on review-readiness fights that loop.

The readiness boundary is instead **publish to the shared-truth ref**, which this repo already treats as the operator's deliberate act (`commit, never push`). So the gate hangs off **push to `refs/heads/main`**, not commit:

- **`pre-commit`** — no blocking gate (commits stay a free sync/handoff primitive). Optional non-blocking warning only.
- **`pre-push`, scoped to `refs/heads/main`** — the real gate. Pushes to any other ref (machine/agent sync) pass untouched.

### Publish standard (pre-push → main)

Hard-block the push if any substrate file (`data/candidates/`, `data/elections/`, `data/controversies/`) in the pushed commits is not `review: passed`. Blocks `not-done`, missing key, `in-progress`, `issues-flagged`, `failed`. (`passed`-with-documented-low-severity-`DATA-GAP` already satisfies the contract, so acknowledged debt still ships.)

### Override requires a human operator (not agent-serviceable)

`git push --no-verify` skips the hook entirely, so the override path itself must require a live human:
- The gate, on block, tries to open `/dev/tty` and prompt for an exact confirmation phrase.
- **No controlling terminal** (agent via tool, CI, piped) → open fails → **hard block, no override.**
- **Human at a terminal** → types the phrase to publish anyway, else abort.
- Codified rule (in `you-decide/review.md`): **agents must never autonomously `--no-verify` the publish gate** — human-only escape, used only on the operator's explicit in-conversation authorization.

Implementation note: leverage the existing `scripts/audit-review.sh` greppable `^review:` contract — a focused `scripts/review-gate.sh` enforces the publish standard over a git range (reused by both the hook and PR-side CI); the reporter stays the human dashboard.

### data/reviews/COVERAGE.md

Maintained by hand (or by a script) tracking:
- Which `(state, year)` batches have been reviewed
- Which producing-stack made them (`generated-by`)
- Which reviewer-stack reviewed them (`reviewed-by`)
- Any unfixed blockers

### Cross-stack-coverage policy

If `generated-by` and `reviewed-by` are both Claude, count as "incomplete" — flag for a different-stack re-review. The point of fresh-context + different-AI-stack is to catch stack-specific failure modes; same-stack review degrades to fresh-context only.

### CI integration

GitHub Actions running on PRs:
- Source-hygiene grep (un-sourced claims, weak-source citations, stale `last-verified` dates)
- Math sanity-check on `-read.md` files (weighted-total matches body formula)
- Per-file frontmatter contract enforcement

This is automated lint on top of AI-mediated full review, not a replacement.

## Out of scope

Building our own review tool. We use Claude / Codex / Gemini / etc. as the reviewer; we just need state tracking + commit-gate enforcement on top of them.

## Plan

**M1 — publish gate (the load-bearing slice):** ✅ built 2026-05-30
- [x] `scripts/review-gate.sh <base> <tip>` — over a git range, find substrate files (`data/candidates|elections|controversies`) and fail (exit 1) listing any whose `review:` (at tip) is not `passed`. Pure check; no TTY/git logic. Reused by hook + CI.
- [x] `scripts/hooks/pre-push` — read pushed refs from stdin; for `refs/heads/main` compute the range, call `review-gate.sh`; on block do the `/dev/tty` human-override prompt (no TTY → hard fail).
- [x] `Makefile.local` — `install-hooks` target: `git config core.hooksPath scripts/hooks` (one-time; later fold into `make bootstrap`).
- [x] `you-decide/review.md` — add "Publish gate" section + the no-autonomous-`--no-verify` rule.
- [x] Test: non-`passed` substrate in range → blocked non-interactively (no `/dev/tty` → hard fail); all-`passed` → passes; non-main ref → untouched. All three verified.
- [ ] Operator one-time activation: `make install-hooks` (writes `core.hooksPath`; sandbox-blocked from agent side — operator runs it).

**M2 — coverage tracking:**
- [ ] `data/reviews/COVERAGE.md` initial population + maintenance convention
- [ ] Cross-stack-coverage tracker (`generated-by == reviewed-by` ⇒ incomplete) — extend `audit-review.sh` output

**M3 — server-side enforcement:** ✅ built 2026-05-31 (on ariadne #52 generic mechanism)
- [x] Built the generic CI merge-check mechanism in the base layer (ariadne #52): seeded `.github/workflows/merge-check.yml` shim + symlinked `scripts/run-merge-checks.sh` runner + scaffolded `scripts/merge-checks.d/`.
- [x] you-decide plugs in `scripts/merge-checks.d/10-review-gate.sh` (wraps `review-gate.sh`).
- [x] Refactored the M1 `pre-push` hook to call `run-merge-checks.sh` (one check-set, two call sites — local hook + CI; can't drift).
- [ ] Validate on a real PR (CI run fires + reports). Advisory for now — branch protection / required-check is opt-in (ariadne #52 M2 `make remote-init`); direct-push-to-main stays the acknowledged escape.
- [ ] (deferred) extra lints: source-hygiene grep, `-read.md` math sanity-check — additional `merge-checks.d/` entries later.

## Revisions

### 2026-05-30 — gate moved from pre-commit to pre-push-to-main
Scope/locus change, not scope creep. Surfaced in design: `commit` is used here as a **checkpoint/handoff/sync** primitive (fixer commits `issues-flagged`; reviewer commits the `passed` flip), so a pre-commit readiness gate fights the review loop. Relocated the gate to the **publish boundary** (push → `main`), which already coincides with the operator's deliberate `commit, never push` step. Added a human-only override requirement (TTY-gated; agents may not autonomously `--no-verify`). Title/Problem still say "pre-commit"; kept for GH#3 continuity — the mechanism is pre-push.

## Log

### 2026-05-28
Ported from GH#3 per the ariadne in-repo-first convention. GH#3 remains as the public-visibility stub pointing here.

### 2026-05-28
Ran formal `you-decide/review.md` pass over `data/candidates/2026/CA/`, `data/elections/2026/`, and `data/controversies/2026/`. Output: `data/reviews/2026/2026-05-28-ca-2026-shared-substrate.md`, status `fail`, with blocker findings around CA ballot-scope completeness, stale candidate manifest entries, a missing `trump-era-cater-discount` calibration skill, and source-gap leakage. Updated reviewed shared-substrate frontmatter from `review: not-done` to `review: issues-flagged` with `review-ref` pointing at the report.

### 2026-05-28
Re-reviewed Claude fix commit `fccab28236a8789d29bc7c4e0c379623a87a0c57` per `you-decide/review.md` r2 loop. Output: `data/reviews/2026/2026-05-28-ca-2026-shared-substrate-r2.md`, status `issues-flagged`. R1 blockers are cleared; remaining issues are two important source-hygiene problems in `data/candidates/2026/CA/us-house-d15/kevin-mullin.md` where party-line characterization and blocked/search-summary sources still appear as used evidence.

### 2026-05-30 — M1 built (publish gate)
Reconciled the commit-is-sync tension (see Revisions): gate moved to pre-push→main. Shipped `scripts/review-gate.sh` (pure range check), `scripts/hooks/pre-push` (main-scoped, TTY-gated human-only override), `Makefile.local install-hooks`, and the `review.md` Publish-gate section. Tested on a throwaway branch: non-`passed` file in range → hard block with no `/dev/tty` (agent path) and clean blocker listing; non-main ref → skipped; clean range → pass. Operator must run `make install-hooks` once to activate (the `git config core.hooksPath` write is blocked from the agent sandbox). M2 (COVERAGE.md + cross-stack tracker) and M3 (CI) still open.

Process note: during testing I `git commit -am` on the throwaway branch, which swept the uncommitted issue-file edits in with the test flip; `git branch -D` then discarded both. Recovered the issue file from the dangling commit. Lesson logged.
