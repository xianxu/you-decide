---
id: 000008
status: open
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
