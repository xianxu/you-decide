---
id: '000004'
status: done
created: 2026-05-28
updated: 2026-05-31
estimate_hours: 6.0
actual_hours: 5.8
---

# Pre-commit review hook + data/reviews/COVERAGE.md tracking

## Problem

The `review.md` sub-skill is in place — every commit to shared substrate (`data/candidates/`, `data/elections/`, `data/controversies/`) should pass through it with a different AI stack before merging. But the convention is operator-driven; without tooling, the discipline erodes (first commit-without-review is a slippery slope).

The whole "AI-curated not crowdsourced" pitch in the README depends on the substrate being trustworthy. Tooling makes the convention load-bearing.
