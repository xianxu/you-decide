---
batch: ca-2026-shared-substrate-r3
date: 2026-05-28
reviewer-stack: codex
producing-stack: claude
scope: all-shared-diff
base-review: data/reviews/2026/2026-05-28-ca-2026-shared-substrate-r2.md
fix-commits-reviewed:
  - 2c51c780753f482078382cd364e808867e480de3
  - e4604a19b3f2cf176620ae0254104ce894f6a3d6
  - 3faaa1e02b24b013b7f3b3ac0dec3aaf97e8da6b
files-reviewed: 7
issues-blocker: 0
issues-important: 1
issues-minor: 0
status: issues-flagged
---

# Review - ca-2026-shared-substrate r3

Diff-scoped re-review of the r2 fixes and the follow-on DATA-GAP / DATA-FIXME marker pass. This is not a fresh full audit of all CA 2026 substrate.

Reviewed exactly:

- `data/candidates/2026/CA/us-house-d15/kevin-mullin.md`
- `data/candidates/2026/CA/governor/chad-bianco.md`
- `data/candidates/2026/CA/governor/tony-thurmond.md`
- `data/candidates/2026/CA/governor/katie-porter.md`
- `data/candidates/2026/CA/governor/matt-mahan.md`
- `data/candidates/2026/CA/governor/tom-steyer.md`
- `data/candidates/2026/CA/governor/antonio-villaraigosa.md`

## Issues Found

### blocker

None.

### important

#### `data/candidates/2026/CA/governor/matt-mahan.md` - med-severity DATA-FIXME still blocks passed

The DATA-FIXME marker is well-formed:

`[axis: capture-risk/viability; severity: med; last-attempt: 2026-05-28]`

It also points at genuinely load-bearing Wikipedia-only claims: the Hastings refund / Tan-Sethi-Solana donor support and the 4-10% polling figure. Those claims feed capture-risk and strategic viability, and the marker itself correctly says polling drives the strategic recommendation. Under `review.md`'s updated severity-governs-blocking rule, `severity: med` documented debt still blocks `review: passed`.

Suggested fix: upgrade the donor claims to FEC/FPPC or comparable Tier A/B campaign-finance sources, and the polling claim to a named Tier B poll/tracker. If the profile keeps the claim without upgraded sources, it should remain `review: issues-flagged`.

### minor

None.

## Findings Resolved

- `data/candidates/2026/CA/us-house-d15/kevin-mullin.md`: the r2 party-line-vote characterization is no longer asserted. The remaining caucus-independence issue is a well-formed low-severity DATA-GAP: `[axis: smart-consistent; severity: low; last-attempt: 2026-05-28]`. Congress.gov and GovTrack have been moved out of the Tier A/B source lists into a "not fetched / gaps (not used as evidence)" section.
- `data/candidates/2026/CA/governor/chad-bianco.md`: the BLM-2020 controversy claim is marked with a well-formed low-severity DATA-FIXME and is the genuinely load-bearing Wikipedia-only claim in the scoped diff.
- `data/candidates/2026/CA/governor/tony-thurmond.md`: the Assembly legislative-record claim is marked with a well-formed low-severity DATA-FIXME and is the genuinely load-bearing Wikipedia-only claim in the scoped diff.
- `data/candidates/2026/CA/governor/katie-porter.md`: the voting/caucus-role and consumer-protection record claims are marked with a well-formed low-severity DATA-FIXME and are the genuinely load-bearing Wikipedia-only claims in the scoped diff.
- `data/candidates/2026/CA/governor/tom-steyer.md`: the healthcare-reversal and NextGen/2020-spend claims are marked with a well-formed low-severity DATA-FIXME and are the genuinely load-bearing Wikipedia-only claims in the scoped diff.
- `data/candidates/2026/CA/governor/antonio-villaraigosa.md`: the Measure R, LAPD force-size, and approval/fiscal-record claims are marked with a well-formed low-severity DATA-FIXME and are the genuinely load-bearing Wikipedia-only claims in the scoped diff.

## Files Cleared

- `data/candidates/2026/CA/us-house-d15/kevin-mullin.md`
- `data/candidates/2026/CA/governor/chad-bianco.md`
- `data/candidates/2026/CA/governor/tony-thurmond.md`
- `data/candidates/2026/CA/governor/katie-porter.md`
- `data/candidates/2026/CA/governor/tom-steyer.md`
- `data/candidates/2026/CA/governor/antonio-villaraigosa.md`

## Files Still Flagged

- `data/candidates/2026/CA/governor/matt-mahan.md`

## Notes

The six cleared files are passed-with-low-severity documented data debt under the updated rule. The broader set of candidate files that were not touched or re-examined in this r3 pass remains `review: issues-flagged`; this report does not clear the full batch.
