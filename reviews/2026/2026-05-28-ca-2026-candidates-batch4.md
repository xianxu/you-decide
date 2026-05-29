---
batch: ca-2026-candidates-batch4
date: 2026-05-28
reviewer-stack: codex
producing-stack: claude
scope: candidates
files-reviewed: 7
issues-blocker: 7
issues-important: 11
issues-minor: 3
status: issues-flagged
---

# Review - ca-2026-candidates-batch4

Full per-file review of seven CA 2026 candidate profiles that had not been individually cleared:

- `candidates/2026/CA/assembly-d21/diane-papan.md`
- `candidates/2026/CA/assembly-d21/jabra-muhawieh.md`
- `candidates/2026/CA/boe-d2/william-shireman.md`
- `candidates/2026/CA/boe-d2/sally-lieber.md`
- `candidates/2026/CA/boe-d2/john-pimentel.md`
- `candidates/2026/CA/Santa-Clara/district-attorney/jeff-rosen.md`
- `candidates/2026/CA/Santa-Clara/district-attorney/daniel-chung.md`

Method: applied `you-decide/review.md` Stage 2 against source-tier compliance, genesis tracking, internal consistency, candidate-name disambiguation, and math where applicable. Checked `you-decide/calibration-skills/source-hygiene-tier-list.md`, `sources/CA.md`, `sources/US.md`, and the relevant state-assembly, state-BOE, and county-DA templates. Spot-checked official/cited sources including Assembly/BOE official pages, CA SOS voter-guide pages, CalMatters BOE coverage, KQED/Palo Alto Online/Palo Alto Daily Post/San Jose Spotlight DA coverage, and cited candidate/campaign pages where fetchable. No body/fact edits were made; required `DATA-GAP` / `DATA-FIXME` markers are reported for a fixer.

## Issues found

### blocker

#### `candidates/2026/CA/assembly-d21/diane-papan.md` - genesis tracking

The profile has several inline URLs, but still fails the Stage 2 claim-level sourcing rule. Lines 21, 29-35, 43-49, 53-55, 61, and 67-70 make decisive race-context, climate, fiscal, public-safety, mental-health, bill-count, CEQA/housing, Prop 36, endorsement-absence, and controversy-summary claims without inline URLs at the assertions.

Suggested fix: add inline Tier A/B URLs for the official Assembly press releases, bill pages, voting records, Prop 36 context, and endorsement/absence claims, or replace unverifiable claims with formal `DATA-GAP [axis: ...; severity: ...; last-attempt: 2026-05-28]` markers.

#### `candidates/2026/CA/assembly-d21/jabra-muhawieh.md` - genesis tracking

The body relies on one SM Daily Journal source and a final source list, but lines 19, 21, 29-31, 37, 41, 47, and 51 contain biography, district-viability, negative-search, record, finance, and no-controversy claims without claim-level URLs. The source list's "Not found / absent" bullets are not enough under Stage 2.

Suggested fix: add inline URLs for each supported claim and convert material negative-search claims to `DATA-GAP` markers where no Tier A/B source exists.

#### `candidates/2026/CA/boe-d2/william-shireman.md` - genesis tracking

The body contains no inline URLs. Lines 19, 23-29, 33-37, 41-44, and 48-50 make decisive biography, platform, record, endorsement/finance, and liability claims supported only by the source table.

Suggested fix: add inline URLs from CA SOS, VOTE411, candidate/organization pages, CalMatters, GrowSF, and Indivisible Ventura at the claims they support, or mark unresolved finance/endorsement/credentialing facts as gaps.

#### `candidates/2026/CA/boe-d2/sally-lieber.md` - genesis tracking

The profile mixes paragraph-level sourcing with many unsourced decisive claims. Lines 19-28, 36-43, 50, 53-58, 65-68, 72, 76-86 contain office-history, priority, no-misconduct, Assembly-record, endorsement/finance, controversy, and negative-search claims without inline URLs at the claims.

Suggested fix: add claim-level URLs from BOE, GrowSF, Progressive Voters Guide, CalMatters/LAist, and primary campaign-finance filings where possible. Where a claim is not verifiable, add `DATA-GAP` / `DATA-FIXME`.

#### `candidates/2026/CA/boe-d2/john-pimentel.md` - genesis tracking

The profile uses `[Source A]` / `[Source B]` labels rather than inline URLs for many decisive claims. Lines 19-27, 31-34, 38-43, 47-54, and 58-61 make biography, platform, record, fundraising, endorsement, and no-controversy claims without claim-level URLs.

Suggested fix: replace source-label placeholders with inline URLs and add formal gaps for donor breakdown, Foster City/land-use-role uncertainty, and negative-search claims.

#### `candidates/2026/CA/Santa-Clara/district-attorney/jeff-rosen.md` - genesis tracking

The profile has many inline URLs, but still leaves material assertions without claim-level URLs. Lines 37, 45-49, 53-57, 63-65, 75-76, and portions of 80 contain drug/ICE posture, named prosecutions, sexual-misconduct/Brady/State Bar/budget allegations, campaign-use details, recall-movement framing, and endorsement counts without adequate inline support at the assertion.

Suggested fix: add inline Tier A/B URLs or court/agency documents for each allegation. Davis Vanguard and RecallRosen items should either be tilt-flagged inline and triangulated, or converted to `DATA-GAP` markers if they remain load-bearing.

#### `candidates/2026/CA/Santa-Clara/district-attorney/daniel-chung.md` - genesis tracking

The profile has some inline URLs but still has decisive unsourced claims at lines 27, 39, 47, 56, 75, 80, and 84-88. These include the internal-challenger interpretation, source blanket for platform sections, victim-delay claim, Brady-access proposal, endorsement-absence conclusions, campaign-finance inference, and controversy/liability restatements.

Suggested fix: add inline URLs to each sourced claim and convert unsourced interpretation or negative-search claims to documented `DATA-GAP` markers where they affect institutionalist, public-safety, or anti-hypocrisy reads.

### important

#### `candidates/2026/CA/assembly-d21/diane-papan.md` - unsupported race-competitiveness and Prop 36 inferences

Line 21 says no high-profile challenger was found and D21 is safe Democratic; line 55 says absence of a Prop 36 position is notable because most Democratic legislators opposed or stayed silent; line 70 turns that absence into a constituency-alignment inference. These affect viability/public-safety reads and need a reproducible source/search basis or `DATA-GAP [axis: public-safety; severity: med; last-attempt: 2026-05-28]`.

#### `candidates/2026/CA/assembly-d21/diane-papan.md` - bill and voting-record claims need primary support

Lines 43-47 cite counts and statuses for authored bills but provide no URLs for the bill query or bill pages. Because the state-assembly template says incumbent voting record is substrate, add official LegInfo/Digital Democracy URLs at claim level or mark unresolved counts as `DATA-FIXME [axis: institutionalist; severity: med; last-attempt: 2026-05-28]`.

#### `candidates/2026/CA/assembly-d21/jabra-muhawieh.md` - negative-search claims should be explicit data gaps

Lines 29-31, 37, 41, 47, 51, and 65-68 assert no public-safety/immigration/election-fraud statements, no public office, no FPPC filings, no controversies, no campaign website, and no social media. Some are probably true for a low-profile challenger, but they are decisive for public-safety, institutionalist, and capture-risk reads. Add `DATA-GAP [axis: public-safety|institutionalist|capture-risk; severity: med; last-attempt: 2026-05-28]` where they cannot be verified.

#### `candidates/2026/CA/boe-d2/william-shireman.md` - source-tier mismatch for party source and 404 source

The source table labels BayAreaGOP as Tier A and Future 500 as Tier A despite noting the Future 500 page was 404 at research time. BayAreaGOP is a party-affiliated/candidate-friendly source, not neutral Tier A for contested biographical or record claims; a 404 page plus search-index summary cannot support decisive claims. Use CA SOS/candidate pages for Tier A, downgrade party/organizational advocacy sources, or add `DATA-GAP [axis: smart-logically-consistent; severity: med; last-attempt: 2026-05-28]` for unsupported credentials.

#### `candidates/2026/CA/boe-d2/william-shireman.md` - finance and endorsement absence claims need formal gaps

Lines 41-43 assert no major endorsements, a campaign committee, and no accessible donor/fundraising details. These materially affect capture-risk and viability. Add a Tier A FPPC/Cal-Access/The Ballot Book citation for committee/finance facts and `DATA-GAP [axis: capture-risk; severity: med; last-attempt: 2026-05-28]` for unavailable donor data.

#### `candidates/2026/CA/boe-d2/sally-lieber.md` - finance/donor claims under-sourced

Lines 65-68 and 72 rely on Progressive Voters Guide for endorsement and donor-composition claims, including "not funded by fossil fuel, law enforcement, real estate, or corporate donors." Because donor composition is decisive for capture-risk, add primary FPPC filing support or mark `DATA-GAP [axis: capture-risk; severity: med; last-attempt: 2026-05-28]`.

#### `candidates/2026/CA/boe-d2/sally-lieber.md` - Ballotpedia is used for decisive controversy claims

Line 57 cites Ballotpedia for the 2004 emissions bill and Jay Leno criticism, then lines 78 uses that as a liability. Ballotpedia is Tier C for orienting background under the source-hygiene rules. Add LegInfo/news URLs, or mark the controversy as `DATA-GAP [axis: anti-hypocrisy; severity: med; last-attempt: 2026-05-28]`.

#### `candidates/2026/CA/boe-d2/john-pimentel.md` - fundraising comparison is not directly sourced

Lines 25 and 52 state Pimentel raised about `$250K` by late March 2026 and slightly exceeded Lieber's `$225K`, but the body has only a source-label reference. Add the CalMatters or primary finance URL inline, and use FPPC/filing support if this is a capture-risk input; otherwise mark `DATA-GAP [axis: capture-risk; severity: med; last-attempt: 2026-05-28]`.

#### `candidates/2026/CA/boe-d2/john-pimentel.md` - HJTA endorsement needs primary support

Line 47 calls the HJTA endorsement a Tier A signal, but the source table does not include the HJTA-PAC endorsements URL. Because this is a notable cross-ideological fiscal signal for a Democrat, add the endorsing organization's URL inline or mark `DATA-GAP [axis: anti-tax-spend; severity: med; last-attempt: 2026-05-28]`.

#### `candidates/2026/CA/Santa-Clara/district-attorney/jeff-rosen.md` - Tier C allegations are treated as decisive

Lines 53-57 use Davis Vanguard for sexual-misconduct cover allegations, Brady disclosure failures, State Bar complaint framing, and budget-threat framing. The source table correctly flags Davis Vanguard as Tier C/reform-advocacy, but the body treats these as serious record concerns without inline tilt caveats or primary documents. Triangulate with complaints/court records/Tier B coverage or add `DATA-GAP [axis: institutionalist; severity: med; last-attempt: 2026-05-28]`.

#### `candidates/2026/CA/Santa-Clara/district-attorney/daniel-chung.md` - frontmatter race slug is inconsistent with paired file

Chung's frontmatter uses `race: 2026-santa-clara-county-district-attorney` while Rosen's paired profile uses `race: 2026-scc-district-attorney`. This is an internal-consistency problem for ballot resolution and cross-file race grouping. A fixer should align the slug with the race manifest or mark the mismatch for schema/tooling follow-up.

### minor

#### `candidates/2026/CA/boe-d2/sally-lieber.md` - approximate age is weakly sourced

Line 19 says "born ~1960s" with no inline source. This is likely non-decisive biographical context, so a low-severity `DATA-GAP [axis: none; severity: low; last-attempt: 2026-05-28]` would be sufficient if no primary source is found.

#### `candidates/2026/CA/boe-d2/john-pimentel.md` - user-framing note leaks process into profile

Lines 27 and 61 refer to "user's framing" / "user's framing was Foster City planning commissioner." That is process provenance rather than candidate substrate. A fixer should convert it to a neutral data-gap note.

#### batch-wide - artifact and math checks

Artifact-leakage grep for `WebSearch`, `franding`, `TBD`, `<unknown>`, and empty markdown links returned no matches in the seven reviewed files. No weighted-score math was present. The only ordinary arithmetic checked was the Chung/Rosen fundraising ratio: `$437K / $127K` is about `3.44`, so line 80's approximate `3.4:1` ratio is correct.

## Files cleared (no issues)

None. Every file in this batch remains `review: issues-flagged` because every profile has at least one blocker-level genesis-tracking failure, and several have med-severity source-tier or internal-consistency issues.

## Per-file verdicts

- `candidates/2026/CA/assembly-d21/diane-papan.md` - `issues-flagged`
- `candidates/2026/CA/assembly-d21/jabra-muhawieh.md` - `issues-flagged`
- `candidates/2026/CA/boe-d2/william-shireman.md` - `issues-flagged`
- `candidates/2026/CA/boe-d2/sally-lieber.md` - `issues-flagged`
- `candidates/2026/CA/boe-d2/john-pimentel.md` - `issues-flagged`
- `candidates/2026/CA/Santa-Clara/district-attorney/jeff-rosen.md` - `issues-flagged`
- `candidates/2026/CA/Santa-Clara/district-attorney/daniel-chung.md` - `issues-flagged`

## Notes / observations

- This review did not insert `DATA-GAP` / `DATA-FIXME` markers directly into candidate bodies because `you-decide/review.md` limits reviewer writes to the report plus review-state frontmatter.
- Web access was sufficient for spot checks but not exhaustive source-by-source re-fetching. Where source fetches were limited or source support could not be confirmed quickly, findings are framed as data-gap/fixer actions rather than replacement facts.
