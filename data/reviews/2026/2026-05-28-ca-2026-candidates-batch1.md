---
batch: ca-2026-candidates-batch1
date: 2026-05-28
reviewer-stack: codex
producing-stack: claude
scope: candidates
files-reviewed: 7
issues-blocker: 7
issues-important: 5
issues-minor: 1
status: issues-flagged
---

# Review - ca-2026-candidates-batch1

Full per-file review of seven uncleared CA 2026 candidate profiles. Per `you-decide/review.md`, this report records findings only; candidate body/fact text was not edited.

## Issues found

### blocker

#### `data/candidates/2026/CA/governor/xavier-becerra.md` - genesis/source tracking

Several decisive record and liability claims are not individually URL-tracked inline. Lines 58-60 summarize coverage expansion, COVID visibility/messaging, and FDA/CDC restructuring with no URL on those bullets. Lines 67-68 assert congressional leadership/voting-record conclusions without a URL. Lines 98-99 assert debate-stage attacks without a URL. These should be demoted to `DATA-GAP`/`DATA-FIXME` or supplied with Tier A/B inline URLs.

Line 19 says Becerra leads with "roughly 19%" and cites the CalMatters voter guide, but the opened voter guide did not contain that number; CalMatters' May 28 PPIC writeup reported Becerra at 23%. Treat this as `DATA-FIXME [axis: viability; severity: med; last-attempt: 2026-05-28]`.

#### `data/candidates/2026/CA/governor/steve-hilton.md` - source-tier compliance

Lines 79-82 use Ballotpedia (Tier C in this file's source table) for endorsement claims. Endorsements are decisive candidate-support claims and need Tier A/B confirmation or a `DATA-GAP [axis: none/capture-risk; severity: med; last-attempt: 2026-05-28]`.

Line 69 cites a PolitiFact page whose title concerns a WorldNetDaily/Fauci claim, not clearly Hilton's "cure is worse than the disease" COVID-reopening claim. If no direct Hilton source exists, mark the claim as a `DATA-GAP [axis: institutionalist; severity: med; last-attempt: 2026-05-28]`.

#### `data/candidates/2026/CA/us-house-d16/kevin-johnson.md` - genesis/source tracking

The body contains no inline URLs after the disambiguation/background/position/viability claims; sources appear only in the final table. Lines 19, 23, 27-35, 39, 43, 47, and 51 are decisive profile claims and need inline source URLs under Stage 2. Ballotpedia is also marked Tier B on lines 58-59, but the repo source rules treat Ballotpedia as B/C and require Tier A/B verification for decisive candidate claims.

#### `data/candidates/2026/CA/us-house-d16/jotham-stein.md` - genesis/source tracking

Most body claims are sourced by source names or a source table rather than inline URLs. Lines 19, 21, 25, 29-47, 51, 55, 57-66, and 70 require inline URLs or explicit `DATA-GAP` markers. The low-coverage unknowns at lines 43-47 and 89 are reasonable low-severity gaps, but they are not in the required `DATA-GAP [axis; severity; last-attempt]` shape.

#### `data/candidates/2026/CA/us-house-d16/peter-soule.md` - genesis/source tracking

The body relies on a blanket "All from souleforcongress.com/issues unless noted" statement and final source table instead of inline URLs for decisive positions and viability claims. Lines 28-31, 35, 42-70, 74, and 78 need inline source URLs or explicit `DATA-GAP` markers.

#### `data/candidates/2026/CA/San-Mateo/assessor-clerk-recorder/clinton-freeman.md` - genesis/source tracking

The body's null-results and inferences are sourced only in the final source list. Lines 19, 21, 25, 29, 33, and 37 need inline URLs or explicit `DATA-GAP` markers. Line 21's "strong signal of a first-time or protest-style candidate" is an inference from missing data; if retained, it should be explicitly framed as low-confidence or marked `DATA-GAP [axis: viability; severity: med; last-attempt: 2026-05-28]`.

#### `data/candidates/2026/CA/San-Mateo/assessor-clerk-recorder/david-canepa.md` - genesis/source tracking

The body uses `[A]`/`[B]` labels and a source table instead of inline URLs for many decisive claims. Lines 19, 21, 28-47, 52-61, 68-96, and 100-108 need inline URLs. The donor-data note at lines 96 and 124 is a real unresolved finance gap and should be represented as `DATA-GAP [axis: capture-risk; severity: med; last-attempt: 2026-05-28]` unless donor data is fetched.

### important

#### `data/candidates/2026/CA/us-house-d16/jotham-stein.md` - internal consistency / official list

Line 21 lists "Other candidates: Kevin Johnson (R)" but omits Peter Sundin Soulé, who appears on the CA SOS certified candidate list for U.S. Representative District 16. Line 70 repeats the problem by framing the second-slot question as Stein versus Johnson only. This is a med-severity race-context data fix.

#### `data/candidates/2026/CA/us-house-d16/peter-soule.md` - schema consistency

Frontmatter line 5 uses `race: 2026-ca-us-house-d16`, while the peer CA-16 profiles use `race: 2026-us-house-d16`. This likely breaks race-level grouping.

#### `data/candidates/2026/CA/governor/xavier-becerra.md` - source-tier compliance

Line 19 uses Wikipedia for biographical facts including age, congressional tenure, AG appointment, and first-Latino-AG status. Wikipedia is allowed only for orienting context; replace decisive bio claims with Tier A/B sources or split the purely orienting claims from the decisive ones.

#### `data/candidates/2026/CA/governor/steve-hilton.md` - source-tier compliance

Line 27 uses Ballotpedia for the campaign-launch date/location. A launch date is a decisive race-history claim and needs campaign, CA SOS, or Tier B journalism support.

#### `data/candidates/2026/CA/San-Mateo/assessor-clerk-recorder/david-canepa.md` - unsupported finance gap

The profile's `Endorsements & donors` section explicitly says FPPC donor data was not retrieved. Because donor/capture information can materially affect this office read, severity is med and blocks `passed` until either fetched or represented with a formal `DATA-GAP`.

### minor

#### batch-wide - schema / review metadata

All seven files had prior `review-ref` values pointing at `data/reviews/2026/2026-05-28-ca-2026-shared-substrate.md`. This review updates them to this batch-specific report. No body content was changed.

## Files cleared (no issues)

None.

## Per-file verdicts

- `data/candidates/2026/CA/governor/xavier-becerra.md` - `review: issues-flagged`
- `data/candidates/2026/CA/governor/steve-hilton.md` - `review: issues-flagged`
- `data/candidates/2026/CA/us-house-d16/kevin-johnson.md` - `review: issues-flagged`
- `data/candidates/2026/CA/us-house-d16/jotham-stein.md` - `review: issues-flagged`
- `data/candidates/2026/CA/us-house-d16/peter-soule.md` - `review: issues-flagged`
- `data/candidates/2026/CA/San-Mateo/assessor-clerk-recorder/clinton-freeman.md` - `review: issues-flagged`
- `data/candidates/2026/CA/San-Mateo/assessor-clerk-recorder/david-canepa.md` - `review: issues-flagged`

## Notes / observations

- Web checks succeeded for the CalMatters governor guide, Becerra campaign priorities page, KPBS Hilton profile, SM Daily Journal CA-16 overview, and CA SOS certified candidate PDF.
- CA SOS certified candidate PDF confirms CA-16 candidates include Sam Liccardo, Kevin Johnson, Peter Sundin Soulé, and Jotham Stein.
- No weighted-total math was present in these candidate profiles.
