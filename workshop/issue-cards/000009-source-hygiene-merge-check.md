---
id: 000009
status: open
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
