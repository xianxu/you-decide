---
id: 000008
status: open
deps: []
created: 2026-05-31
updated: 2026-05-31
estimate_hours: 1.5
---

# Review-coverage dashboard (COVERAGE.md + cross-stack rollup)

## Problem

The publish **gate** is live (you-decide #4 M2: `review: passed` AND
`reviewed-by ≠ generated-by`, enforced at the push boundary + PR CI). The gate
*blocks*; it does not give a human an at-a-glance **report** of what's been
reviewed and by whom. This issue is the reporting/visibility layer — split out
of #4 (was its M4) so it never blocks the gate.

Extracted from #4 on 2026-05-31 (operator: postpone to a future issue).

## Spec

### `data/reviews/COVERAGE.md`

A hand-or-script-maintained status table, **one row per `(state, year)` batch**:

| column | meaning |
|---|---|
| `(state, year)` | the batch, e.g. `CA / 2026` |
| `generated-by` | producing stack(s) for the batch |
| `reviewed-by` | reviewing stack(s) |
| `unfixed-blockers` | open med/high markers, or "—" |

**Pin this format before populating** (the plan-quality judge flagged the
original item as under-specified). Only `2026/CA` exists today, so the cost is
the format decision, not data entry.

### Cross-stack-coverage rollup

`scripts/audit-review.sh:50-63` *already* emits a "Same-stack reviews (INVALID)"
section. The remaining delta is:
1. a **per-batch rollup** that feeds COVERAGE.md (counts/coverage by batch), and
2. **reconcile the three coexisting definitions of "same stack"** into one
   canonical rule and make all three agree:
   - Spec prose (`you-decide/review.md`): "both Claude ⇒ incomplete"
   - the gate (`scripts/cross-stack-gate.sh`): exact string inequality
   - the dashboard (`scripts/audit-review.sh`): any `generated-by == reviewed-by`
   This includes deciding compound-stack semantics (`claude+codex` vs `codex`)
   that #4 M2 deliberately deferred (exact-inequality today).

## Out of scope

The gate itself (done in #4). This is reporting only; it must not change
blocking behavior.

## Plan

- [ ] Pin the COVERAGE.md format (columns above; markdown table); add a header
  note on maintenance (hand vs script).
- [ ] Populate COVERAGE.md for the existing `2026/CA` batch.
- [ ] Decide the canonical stack-equality rule; align `review.md` prose,
  `cross-stack-gate.sh`, and `audit-review.sh` to it (one definition).
- [ ] Extend `audit-review.sh` with the per-batch rollup feeding COVERAGE.md.
- [ ] (if a script maintains COVERAGE.md) add a test for the rollup.

## Done when

- [ ] `data/reviews/COVERAGE.md` exists with a pinned format and the `2026/CA`
  row populated (producing + reviewing stack, blockers).
- [ ] The three stack-equality notions are reconciled to one canonical rule,
  reflected in `cross-stack-gate.sh`, `audit-review.sh`, and `review.md`.
- [ ] `audit-review.sh` emits a per-batch coverage rollup.

## Log

- 2026-05-31 — Split out of #4 (its M4) so the gate isn't blocked on the
  dashboard. The gate (#4 M2) is the enforcement; this is the report. The
  stack-equality reconciliation is the substantive part (three definitions
  currently coexist).
