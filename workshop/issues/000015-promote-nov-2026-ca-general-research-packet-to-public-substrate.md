---
id: 000015
status: working
deps: []
github_issue:
created: 2026-10-04
updated: 2026-10-04
estimate_hours:
card_mirror: 'cb94c845e6169498a570c11c526e283a056ab574' # card fields mirrored from issue-cards; edit via sdlc
started: 2026-10-04T19:27:21-07:00
claimant:
    operator: Xian Xu
    machine: 4716879978a7b90f6b583da1716fd0e9
    machine_name: Xian’s MacBook Pro
    worktree: /Users/xianxu/workspace/you-decide
    repository: github.com/xianxu/you-decide
flow: {kind: full, provenance: inferred}
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
- (revised) No voter-exported ballot PDF or image is published: `sources/` holds only the text transcription, and no file references the withheld PDF.
- (revised) Every `District:` tag in the manifest matches a pattern in `resolve-ballot.md` Stage 2's tag vocabulary.

## Plan

- [x] Move the packet into `data/elections/2026/2026-11-03-CA-general/` and fix the README.
- [x] Write the manifest `.md` from `ballot.json`.
- [x] Write the neutral supplement.
- [x] Verify JSON parsing and anchors, and grep for personal identifiers.
- [x] Cross-stack reviews (Claude on the Codex files, Gemini on the Claude files), then fix, then set review frontmatter.
- [x] Run both gate scripts (both pass). `sdlc close` → `sdlc pr` → `sdlc merge` follow this checklist.
- [x] Brain side: delete the private copy and repoint the guide links. The private copy was deleted, keeping only the user's original PDF export as a private record (`menlo-park-2026-11-03-reference-ballot.pdf`). The guide's links now point to the public packet, and each target was verified to exist.

## Log

### 2026-10-04
- 2026-10-04: closed — review-gate.sh + cross-stack-gate.sh pass; ballot.json parses, 48/48 contests + anchors resolve; packet passed Claude cross-stack (3 rounds), manifest+supplement passed Codex cross-stack (3 rounds); PDF withheld (sources/ = txt only, no PDF refs); manifest District tags all in resolve-ballot Stage 2 vocabulary; atlas updated; brain-side private copy removed and guide links verified; review verdict: FIX-THEN-SHIP
- 2026-10-04: flow upgraded quick → full — 2926 added lines in code files (limit 100); an earlier round of this close already ran the full review
- Packet copied verbatim into `data/elections/2026/2026-11-03-CA-general/`. Codex's same-stack review record moved to `data/reviews/2026/` (review records don't live in substrate dirs).
- Manifest generated from `ballot.json`: 48/48 contests; all 48 research anchors resolve; 22 candidate dossier links verified (matched by race folder + last name for slug drift, e.g. `don-wagner`).
- **Privacy catch by cross-stack review (Critical):** the voter-exported ballot PDF carried the exporter's personal name in `/Author`, and page 25 showed an on-screen selection mark. A text-only grep missed both. Resolution: the PDF is withheld from the public packet; the text transcription is published; `ballot.json` `source.pdf = null` with a note. Never committed, so no history scrub needed. Lesson added to `workshop/lessons.md`.
- Reviews:
  - Claude cross-stack on the Codex packet: 3 rounds, all 6 files passed (Johnson disambiguation, TIDE/Sunset/Kounalakis wording fixes).
  - Codex cross-stack on the Claude manifest (passed r1) and supplement: 3 rounds, passed. Unverifiable claims were demoted to DATA-GAP, and the poll was bound to the primary memo.
  - The Gemini CLI is now unusable (ineligible tier); Codex 0.160 works for reviews.
- Gates: `review-gate.sh` and `cross-stack-gate.sh` both pass over the branch range.
- Follow-ups (not done here): fold the supplement into individual `data/candidates/` dossiers; add a `data/measures/` home; remove user-specific phrasing from office templates (`templates/*` cite "the user's stated values").

## Revisions

- 2026-10-04: **scope change.** The Spec planned to move `sources/` with the PDF and the text. Review found that the voter-exported PDF embeds the exporter's name (metadata) and on-screen selections (page image), so it is **withheld** from the public packet. Only the text transcription is published, and `ballot.json` `source.pdf = null`. The original stays in the user's private dir.
- 2026-10-04: **boundary review BR-1, fixed at the class level.** The tag vocabulary is now single-sourced in `resolve-ballot.md` Stage 2, extended with BOE, Court of Appeal, trustee-area, community-college and transit-district patterns, with a rule that manifests draw from it. The manifest is retagged `MPCSD` → `MENLO-PARK-CSD`. Minor findings also fixed: duplicate manifest headings, missing Sources section, and stale PDF references in the README.
