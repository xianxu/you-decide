---
batch: ca-assembly-d23-correction
date: 2026-06-02
reviewer-stack: gemini
producing-stack: claude
scope: mixed (candidates+reads)
files-reviewed: 7
issues-blocker: 1
issues-important: 0
issues-minor: 2
status: fail
---

# Review — ca-assembly-d23-correction

## Issues found

### blocker

#### `data/life/politics/who-to-vote-for/2026/CA/assembly-d23/marc-berman-read.md` — Fact inconsistency
The rationale for the **Anti-tax-spend** axis (+0) cites a cross-caucus vote against a wealth-tax bill: *"One notable: voted against wealth-tax bill, called it 'very misleading' — fiscally moderate cross-caucus moment."* 

However, the candidate profile (`data/life/politics/you-decide/data/candidates/2026/CA/assembly-d23/marc-berman.md`) explicitly states that this claim was **confabulated** and was **removed** from the profile: *"an earlier capture claimed Berman 'cast what was characterized as a deciding vote against' a wealth tax ... that claim was confabulated and removed."*

The read must be updated to remove the confabulated fact. Removing this "moderate" signal may require re-evaluating the 0 score on the anti-tax axis (standard caucus alignment with 0% HJTA/CalChamber usually scores negative).

### important
*None.*

### minor

#### `data/life/politics/you-decide/data/candidates/2026/CA/assembly-d23/marc-berman.md` — Missing source in footer
The `InMenlo` source (Tier B) is linked in the body under **Public safety** but is missing from the **Sources** list at the end of the file. 

#### `data/life/politics/who-to-vote-for/2026/CA/assembly-d23/david-johnson-read.md` — Inaccurate correction note
A note in the body states: *"Corrected 2026-06-02: frontmatter + heading previously read +3"*. While the frontmatter was corrected to +7.5, the `# David Johnson — Xian's read` heading does not contain a score and thus was not "corrected" in the literal sense.

## Files cleared (no issues)
- `data/life/politics/who-to-vote-for/2026/CA/assembly-d23/rick-giorgetti-read.md`
- `data/life/politics/who-to-vote-for/2026/CA/assembly-d23/vote.md`
- `data/life/politics/who-to-vote-for/calibration-skills/record-over-ballot-position.md`
- `data/life/politics/who-to-vote-for/2026/CA/menlo-park-2026-06-02-ballot.md` (State Assembly D23 section only)

## Notes / observations
- The new calibration skill `[[record-over-ballot-position]]` is well-formed and successfully reconciles the Prop 36 opposition with the AB 3209 authorship record.
- Berman's arithmetic (8 + 1 = 9) is correct despite the fact error noted above.
- D. Johnson's corrected total (+7.5) and Giorgetti's corrected total (+5) are arithmetically sound under the state-assembly weights.
