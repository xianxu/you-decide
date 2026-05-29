---
id: 000004
status: working
deps: []
github_issue: xianxu/you-decide#3
created: 2026-05-28
updated: 2026-05-28
estimate_hours: 1.0
---

# Pre-commit review hook + reviews/COVERAGE.md tracking

## Problem

The `review.md` sub-skill is in place — every commit to shared substrate (`candidates/`, `elections/`, `controversies/`) should pass through it with a different AI stack before merging. But the convention is operator-driven; without tooling, the discipline erodes (first commit-without-review is a slippery slope).

The whole "AI-curated not crowdsourced" pitch in the README depends on the substrate being trustworthy. Tooling makes the convention load-bearing.

## Spec

### Pre-commit hook

Fails the commit if any new/modified file in `candidates/`, `elections/`, `controversies/` doesn't have one of:
- `review: passed` in frontmatter pointing to a `reviews/<year>/*.md` entry
- An override flag for legitimate WIP (`review: in-progress` is fine for batch work)

Implementation note: leverage the existing `scripts/audit-review.sh` greppable contract — the hook is the audit script run against the staged diff.

### reviews/COVERAGE.md

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

- [ ] `scripts/audit-review.sh` — already exists; verify it greps the staged diff correctly
- [ ] Pre-commit hook installer (`make install-hooks` or similar) that wires `audit-review.sh` into `.git/hooks/pre-commit`
- [ ] `reviews/COVERAGE.md` initial population + maintenance convention
- [ ] GitHub Actions workflow for PR-side lint
- [ ] Cross-stack-coverage tracker (probably part of `audit-review.sh` output)

## Log

### 2026-05-28
Ported from GH#3 per the ariadne in-repo-first convention. GH#3 remains as the public-visibility stub pointing here.

### 2026-05-28
Ran formal `you-decide/review.md` pass over `candidates/2026/CA/`, `elections/2026/`, and `controversies/2026/`. Output: `reviews/2026/2026-05-28-ca-2026-shared-substrate.md`, status `fail`, with blocker findings around CA ballot-scope completeness, stale candidate manifest entries, a missing `trump-era-cater-discount` calibration skill, and source-gap leakage. Updated reviewed shared-substrate frontmatter from `review: not-done` to `review: issues-flagged` with `review-ref` pointing at the report.
