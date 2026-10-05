---
id: 000015
status: open
deps: []
github_issue:
created: 2026-10-04
updated: 2026-10-04
estimate_hours:
card_mirror: 'c8586fac33de280f0a7816ab1194c0544c150f0c' # card fields mirrored from issue-cards; edit via sdlc
---

# Promote Nov-2026 CA general research packet to public substrate

## Problem

The Nov 3 2026 CA general research (a neutral, preference-free packet: 48-contest BT-114 manifest, candidate/measure/judicial reports, county reference ballot) was written by a Codex session into the user's **private** dir (`who-to-vote-for/2026/CA/2026-11-03-research/`) instead of the shared fact layer, against the substrate split (facts in `data/`, inference in the private dir). A same-day Claude session also gathered fresh general-election facts (Hilton's 2020 statements, GOP down-ballot posture, measure funding, local races) that landed only in private reads/guide. So the next cache-first run can't see any of it, and there is no `data/elections/2026/2026-11-03-CA-general*` manifest.

## Spec

Move the packet to the public substrate, co-located with the election it scopes:

- `data/elections/2026/2026-11-03-CA-general/` ← the packet verbatim (README, `ballot.json`, `sources.json`, the five reports, `review.md`, `sources/` PDF+txt). Internal relative links keep working because the folder moves intact. The PDF is the generic county **reference ballot for style BT-114**; it was checked for personal identifiers (none: no name, address, or voter ID).
- `data/elections/2026/2026-11-03-CA-general.md`: a per-election manifest in the `resolve-ballot.md` schema, derived from `ballot.json`. Coverage is stated honestly as **ballot style BT-114 only**, not the whole state/county.
- `data/elections/2026/2026-11-03-CA-general/supplement-2026-10-04.md`: neutral, claim-cited write-up of the same-day fresh research (no scores, no recommendations).
- Packet README: drop the "keep in private dir" guidance and point at its new home.
- Private dir: remove the moved packet; repoint the user's ballot guide links (brain-side, not in this repo).
- Review: Codex-authored files get a Claude fresh-context review (cross-stack). Claude-authored files (manifest, supplement) get a Gemini review. All gated `.md` files reach `review: passed` with `reviewed-by ≠ generated-by` before publishing.

Out of scope (follow-up): folding the supplement into the individual `data/candidates/` dossiers, and a `data/measures/` home. Both belong with #13's data model.

## Done when

- `scripts/review-gate.sh` and `scripts/cross-stack-gate.sh` pass over the branch range.
- The packet exists only under `data/elections/2026/2026-11-03-CA-general/`, with no copy left in the private dir.
- `ballot.json` parses; every `research_file`#anchor in it resolves to a heading in the moved reports.
- The new manifest lists all 48 BT-114 contests.
- The supplement contains no personalized scoring or recommendations.

## Plan

- [ ] Move the packet into `data/elections/2026/2026-11-03-CA-general/` and fix the README.
- [ ] Write the manifest `.md` from `ballot.json`.
- [ ] Write the neutral supplement.
- [ ] Verify JSON parsing and anchors, and grep for personal identifiers.
- [ ] Cross-stack reviews (Claude on the Codex files, Gemini on the Claude files), then fix, then set review frontmatter.
- [ ] Run both gate scripts, close, open a PR, merge.
- [ ] Brain side: delete the private copy and repoint the guide links.

## Log

### 2026-10-04
