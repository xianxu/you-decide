---
batch: ca-lieutenant-governor-vote
date: 2026-06-02
reviewer-stack: gemini
producing-stack: claude
scope: reads
files-reviewed: 1
issues-blocker: 0
issues-important: 0
issues-minor: 1
status: pass
---

# Review — ca-lieutenant-governor-vote

## Issues found

### minor

#### `data/life/politics/who-to-vote-for/2026/CA/lieutenant-governor/vote.md` — Fact documentation
The vote rationale asserts a "Trump endorsement" for Gloria Romero. While corroborated by external sources (LA Times, Sept 2024), the corresponding dossier (`gloria-romero.md`) currently carries a `DATA-GAP` marking this fact as unverified. This is a metadata/consistency debt in the dossier, not an error in the vote rationale itself.

## Files cleared (no issues)
- `data/life/politics/who-to-vote-for/2026/CA/lieutenant-governor/vote.md`

## Notes / observations
- **Arithmetic**: Matrix totals and column math were verified for all 5 candidates. The weighted-total formula `Σ(heavy scores)×2 + Σ(medium scores)×1 + Σ(light scores)×0.5` is applied correctly.
- **Adjustments**: The "education elevation" and "institutionalist correction" math are internally consistent and correctly applied to the final matrix.
- **Fact-fidelity**: Decisive claims (Romero's Parent Trigger / Charter record, Fryday's union slate, Tubbs's 2020 concession, Ma's harassment settlement) match the dossiers and/or external verification.
- **Office Weights**: Axis weights match the `governor.md` template exactly.
