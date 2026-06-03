---
batch: ca-assembly-d23-correction-r2
date: 2026-06-02
reviewer-stack: gemini
producing-stack: claude
scope: mixed (candidates+reads)
files-reviewed: 5
issues-blocker: 0
issues-important: 0
issues-minor: 0
status: pass
---

# Review — ca-assembly-d23-correction-r2

This is a **round 2 diff-scoped re-review** following the `fail` status in r1 ([2026-06-02-ca-assembly-d23-correction.md](2026-06-02-ca-assembly-d23-correction.md)).

## Findings verification

1. **[FIXED] `marc-berman-read.md`** — The confabulated wealth-tax claim is removed. The **Anti-tax-spend** axis has been re-scored **0 → −1** with an honest rationale (standard progressive caucus alignment, no fiscal-moderate signal). The weighted total is correctly recomputed to **+7**: `heavy(2−1+1+0+1)×2=6` + `medium(−1+1+1+0)=+1` = **+7**.
2. **[FIXED] `marc-berman.md`** — `InMenlo` (Tier B) and the `AB 3209` press release (Tier A) have been added to the Sources list.
3. **[FIXED] `david-johnson-read.md`** — The correction note has been sharpened to accurately name the frontmatter `weighted-total` and the `## Weighted total` line.

## Regression checks

- **`vote.md`**: Successfully updated to reflect Berman's anti-tax −1 and total +7. Column math and matrix cells are consistent. Narrative no longer identifies Berman as the raw-score leader (D. Johnson +7.5 > Berman +7), correctly grounding the pick in viability + housing-CEQA dominance.
- **`menlo-park-2026-06-02-ballot.md`**: D23 section updated (Berman +7), table re-sorted with D. Johnson (+7.5) first, and TL;DR row reconciled.

## Files cleared (no issues)
- `data/life/politics/who-to-vote-for/2026/CA/assembly-d23/marc-berman-read.md`
- `data/life/politics/who-to-vote-for/2026/CA/assembly-d23/david-johnson-read.md`
- `data/life/politics/who-to-vote-for/2026/CA/assembly-d23/vote.md`
- `data/life/politics/you-decide/data/candidates/2026/CA/assembly-d23/marc-berman.md`
- `data/life/politics/who-to-vote-for/2026/CA/menlo-park-2026-06-02-ballot.md` (D23 section only)

## Notes / observations
- The re-review is restricted to the diffs since r1. Untouched files (`rick-giorgetti-read.md`, `record-over-ballot-position.md`) that passed in r1 remain cleared.
- As instructed, the top-level `review:` status of the consolidated ballot (`menlo-park-2026-06-02-ballot.md`) remains unchanged as only the D23 section was in scope for this correction batch.
