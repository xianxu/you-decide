---
id: 000002
status: open
created: 2026-05-28
updated: 2026-05-28
---

# Battle-test and scale: AI-curated voter research across key US jurisdictions

## Problem

The MVP (`brain#11`) validated the algorithm on California 2026 (8 governor candidates + 4 SM County races + 4 CA state races + 1 US House district). To become useful beyond a single user in a single state, the substrate (`data/candidates/`, `data/elections/`, `data/controversies/`) needs maintainer-curated, AI-driven population across many jurisdictions — with consistent methodology, inline source citations, and the review pipeline enforcing quality.

Battle-testing also surfaces algorithm gaps that don't appear in a single-state run: voting systems other than CA top-2 (ranked-choice in ME/AK, partisan primaries elsewhere), state-specific filing windows, judicial-retention races, ballot measures with conditional dependencies.
