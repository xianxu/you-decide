---
id: 000009
status: open
deps: []
created: 2026-05-31
updated: 2026-05-31
estimate_hours: 1.0
---

# Source-hygiene grep merge-check (data/candidates substrate)

## Problem

The publish gates (#4) enforce *review state* (`review: passed` AND
`reviewed-by ≠ generated-by`) but not *citation hygiene*. A mechanical lint can
catch the failure modes a human/AI reviewer skims past — and that we've already
hit by hand (e.g. blocked/search-summary URLs surfacing as used evidence in
`kevin-mullin.md`, caught only in an r2 review pass).

This is automated lint **on top of** AI-mediated review, not a replacement.
Split out of #4 (was its deferred M3 "extra lint" bullet) so it never blocked
the gate work. The sibling math-sanity-check idea was dropped (reads are private,
never in you-decide's range — see #4 Revisions 2026-05-31).

## Spec

A new `scripts/merge-checks.d/30-source-hygiene.sh` (+ a pure
`scripts/source-hygiene.sh <base> <tip>` it wraps, mirroring `review-gate.sh`)
that, over a git range, flags substrate `.md` files for:

- **Un-sourced claims** — factual position/record prose with no nearby
  `[(source)](url)` citation.
- **Weak-source citations** — blocked / search-summary URL shapes presented as
  used evidence.
- **Stale dates** — `last-verified` / `last-updated` older than a threshold
  (proximity-to-election aware, if cheap).

Exit 0/1/2, fail-closed, same contract + test-harness pattern as the existing
gates (`scripts/tests/`). Advisory severity vs. hard-block is a design question
to settle when building — a citation smell may warrant a warning rather than a
publish block.

## Plan

- [ ] `scripts/source-hygiene.sh` — pure range check + the three greps above.
- [ ] `scripts/merge-checks.d/30-source-hygiene.sh` — thin wrapper.
- [ ] test harness (fixtures: un-sourced claim, blocked-URL-as-evidence, stale date).
- [ ] decide block-vs-warn; document in `you-decide/review.md`.

## Log
