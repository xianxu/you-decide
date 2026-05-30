---
batch: ca-2026-candidates-batch3
date: 2026-05-28
reviewer-stack: codex
producing-stack: claude
scope: candidates
files-reviewed: 7
issues-blocker: 7
issues-important: 9
issues-minor: 2
status: issues-flagged
---

# Review - ca-2026-candidates-batch3

Full per-file review of seven CA 2026 candidate profiles that had not been individually cleared:

- `data/candidates/2026/CA/assembly-d23/rick-giorgetti.md`
- `data/candidates/2026/CA/supt-public-instruction/gus-mattammal.md`
- `data/candidates/2026/CA/supt-public-instruction/frank-lara.md`
- `data/candidates/2026/CA/us-house-d15/charles-hoelter.md`
- `data/candidates/2026/CA/us-house-d15/james-garrity.md`
- `data/candidates/2026/CA/us-house-d15/anthony-van-dang.md`
- `data/candidates/2026/CA/us-house-d15/mantosh-kumar.md`

Method: applied `you-decide/review.md` Stage 2 against source-tier compliance, genesis tracking, internal consistency, candidate-name disambiguation, and math where applicable. Checked `you-decide/calibration-skills/source-hygiene-tier-list.md`, `data/sources/CA.md`, `data/sources/US.md`, the CA Secretary of State certified candidate list/contact list, FEC pages for CA-15 candidates, and available Tier B/Tier C pages named by the profiles. No body/fact edits were made; required `DATA-GAP` / `DATA-FIXME` markers are reported for a fixer.

## Issues found

### blocker

#### `data/candidates/2026/CA/assembly-d23/rick-giorgetti.md` - genesis tracking

The profile fails the review contract that every decisive claim has an inline source URL. Lines 19, 21, 23, 29-42, 48, 52-54, 58-60, and 64 make biography, district, race-dynamics, position, endorsement/finance, and Trump-alignment claims without inline URLs beside the assertions. The source table at lines 70-75 is not sufficient under Stage 2.

Suggested fix: add inline Tier A/B URLs for each decisive claim, or replace unverifiable claims with `DATA-GAP [axis: ...; severity: ...; last-attempt: 2026-05-28]` markers.

#### `data/candidates/2026/CA/supt-public-instruction/gus-mattammal.md` - genesis tracking

The profile relies on a source list and a blanket "Source: votegus.org/policy and EdSource" statement rather than inline URLs. Lines 19, 21, 23, 29-37, 41, 45-47, and 51 contain decisive biography, prior-race, finance, position, and liability claims without claim-level URLs.

Suggested fix: add inline Tier A/B URLs, especially for the education biography and finance claims, or add formal `DATA-GAP` markers.

#### `data/candidates/2026/CA/supt-public-instruction/frank-lara.md` - genesis tracking

The body has no inline URLs for most decisive facts. Lines 19, 21, 25-36, 40-43, 47-59, and 63-68 make biography, PSL/Peace and Freedom, platform, finance, endorsement, and liability claims sourced only by a final source list.

Suggested fix: add claim-level URLs from the campaign site, CalMatters, EdSource, Press Democrat, and campaign-finance source, or mark unresolved facts with `DATA-GAP` / `DATA-FIXME`.

#### `data/candidates/2026/CA/us-house-d15/charles-hoelter.md` - genesis tracking

The body contains no inline source URLs. Lines 19, 23-39, 43, 47, and 51 make biography, position, FEC/finance, endorsement, and no-controversy claims supported only by the source table at lines 57-63.

Suggested fix: add inline campaign-site/FEC/Tier B URLs or demote unverified absence claims to formal `DATA-GAP` markers.

#### `data/candidates/2026/CA/us-house-d15/james-garrity.md` - genesis tracking

The body contains no inline source URLs. Lines 19-25, 29-45, 49-57, and 61-62 make biography, prior-run, policy, finance, endorsement, and viability claims supported only by the source table at lines 68-75.

Suggested fix: add inline campaign-site, CA SOS, FEC, Almanac, and Patch URLs, or mark unresolved finance/endorsement claims as `DATA-GAP`.

#### `data/candidates/2026/CA/us-house-d15/anthony-van-dang.md` - genesis tracking

The profile uses tier labels in the body but not inline URLs. Lines 19, 21, 25-39, 43, 47, 49-57, and 61 contain decisive biography, issue, whistleblower, endorsement, finance, and liability claims without claim-level URLs.

Suggested fix: add inline campaign-site, More Perfect Union, FEC, Almanac, and endorsement URLs at the relevant claims, or add formal gap markers where sources cannot be fetched.

#### `data/candidates/2026/CA/us-house-d15/mantosh-kumar.md` - genesis tracking

Some position paragraphs have inline URLs, but decisive claims remain unsupported at claim level. Lines 19, 21, 45, 49, 51-61, and 65 cover biography, opponent-capture claims, no-public-service claims, endorsements, FEC finance, incumbent-resource context, and no-controversy/viability claims without complete inline URLs.

Suggested fix: add inline URLs for the unsourced paragraphs and finance/context assertions, or mark missing facts with `DATA-GAP`.

### important

#### `data/candidates/2026/CA/assembly-d23/rick-giorgetti.md` - unresolved negative-search claims need formal gaps

Lines 19, 48, 52-54, 58, and 64 assert no campaign website, no detailed biography, no public-office record, no CRA/other endorsements, no Cal-Access data, and no institutionalist red flags. These are negative-search claims that can materially affect competence, capture-risk, and institutionalist reads. They should be represented as explicit `DATA-GAP [axis: competence|capture-risk|institutionalist; severity: med; last-attempt: 2026-05-28]` unless backed by a reproducible search/fetch log and inline URLs.

#### `data/candidates/2026/CA/assembly-d23/rick-giorgetti.md` - source-tier mismatch for "community volunteer"

Line 19 attributes "businessman and community volunteer" to the San Mateo County candidate roster. The CA Secretary of State certified list and contact list checked for this review confirm "Businessman" / active AD-23 candidacy, but the reviewed official SOS extracts did not confirm "community volunteer." If the San Mateo roster is the support, cite it inline; otherwise mark `DATA-GAP [axis: competence; severity: low; last-attempt: 2026-05-28]`.

#### `data/candidates/2026/CA/supt-public-instruction/gus-mattammal.md` - finance and donor claims under-sourced

Line 23 says the campaign raised `$83,799` as of March 31, 2026 and line 45 says no major institutional money surfaced. The source list does not include an FPPC/Power Search/Transparency USA/The Ballot Book URL for Mattammal finance, and search results found the same figure in aggregator-style summaries rather than a cited Tier A filing. Add a Tier A/B finance source or mark `DATA-GAP [axis: capture-risk; severity: med; last-attempt: 2026-05-28]`.

#### `data/candidates/2026/CA/supt-public-instruction/gus-mattammal.md` - prior endorsement claims need Tier A/B confirmation

Lines 21 and 47 list prior CA GOP and local Republican endorsements from 2022-2024. Because party endorsement history is load-bearing for ideological classification in a formally nonpartisan race, those claims need inline Tier A/B URLs from campaign archives, party pages, or press coverage. Ballotpedia orientation alone is not enough; if no Tier A/B source is retrievable, use `DATA-GAP [axis: institutionalist; severity: med; last-attempt: 2026-05-28]`.

#### `data/candidates/2026/CA/supt-public-instruction/frank-lara.md` - campaign-finance figures conflict with fetched source

Lines 36 and 59 say Lara raised `$37,737` total and had `$12,814` cash on hand as of April 2026. The fetched Transparency USA page named in the source list reports data through 2026-05-16 with `$38,650` total contributions and `$7,286` cash on hand. Treat the current body finance numbers as `DATA-FIXME [axis: capture-risk; severity: med; last-attempt: 2026-05-28]` unless an older report-date citation is added inline.

#### `data/candidates/2026/CA/supt-public-instruction/frank-lara.md` - donation pledge overclaim

Line 36 says the campaign accepts only working-class individual donations and no corporate PACs. The fetched Transparency USA page lists entity contributors including United Educators of San Francisco, D&J Singh Farm, and Peace and Freedom Party. If line 36 is only a candidate pledge/self-description, it needs that framing and a campaign-source URL; if presented as actual donor composition, mark `DATA-FIXME [axis: anti-hypocrisy; severity: med; last-attempt: 2026-05-28]`.

#### `data/candidates/2026/CA/us-house-d15/charles-hoelter.md` - FEC inference needs a gap marker

Line 43 says Hoelter raised below the `$5,000` FEC disclosure threshold and line 47 says no FEC financial summary is available. The FEC page confirms it does not have Hoelter data for 2025-2026 and lists possible explanations, including processing lag, no activity, or no deadline yet. The "below threshold" conclusion is plausible but not directly established by the page. Mark `DATA-GAP [axis: capture-risk; severity: med; last-attempt: 2026-05-28]` unless confirmed by raw filings or reporting.

#### `data/candidates/2026/CA/us-house-d15/james-garrity.md` - current-cycle FEC/finance support is incomplete

Lines 25 and 56 cite FEC candidate/committee IDs and say 2026 FEC data is not processed / not itemized, with no PAC money or major donor patterns identified. The FEC candidate page opened during review is a 2022 profile for `H2CA15144`, not a 2026 financial summary. The CA SOS list confirms current 2026 candidacy, but finance conclusions need current-cycle FEC support or `DATA-GAP [axis: capture-risk; severity: med; last-attempt: 2026-05-28]`.

#### `data/candidates/2026/CA/us-house-d15/mantosh-kumar.md` - opponent-capture and endorsement claims need direct support

Line 21 repeats Kumar's claim that Mullin received approximately `$862,000` in AIPAC-linked donations, and line 49 says Progressive Voters Network endorsed Kumar via campaign social media. Neither claim has a direct inline URL in the body or a clearly matching source-table entry. Add primary/social or Tier B URLs, or mark the AIPAC-linked number as `DATA-GAP [axis: capture-risk; severity: med; last-attempt: 2026-05-28]` and the endorsement as `DATA-GAP [axis: viability; severity: low; last-attempt: 2026-05-28]`.

### minor

#### `data/candidates/2026/CA/us-house-d15/anthony-van-dang.md` - source-table URL omission

Line 69 lists "Ballotpedia Anthony Dang page" without a URL. The note says it is not used for decisive claims, so this is not blocking, but source tables should still preserve URLs for reproducibility.

#### batch-wide - artifact and math checks

Artifact-leakage grep for `WebSearch`, `franding`, `TBD`, `<unknown>`, and empty markdown links returned no matches in the seven reviewed files. No weighted-score math was present; ordinary finance arithmetic checked where possible. Dang's self-funding percentage is correct after rounding, and Kumar's FEC totals match the opened FEC page.

## Files cleared (no issues)

None. Every file in this batch remains `review: issues-flagged` because every profile fails the inline-source genesis requirement and several contain med-severity finance/source gaps.

## Per-file verdicts

- `data/candidates/2026/CA/assembly-d23/rick-giorgetti.md` - `issues-flagged`
- `data/candidates/2026/CA/supt-public-instruction/gus-mattammal.md` - `issues-flagged`
- `data/candidates/2026/CA/supt-public-instruction/frank-lara.md` - `issues-flagged`
- `data/candidates/2026/CA/us-house-d15/charles-hoelter.md` - `issues-flagged`
- `data/candidates/2026/CA/us-house-d15/james-garrity.md` - `issues-flagged`
- `data/candidates/2026/CA/us-house-d15/anthony-van-dang.md` - `issues-flagged`
- `data/candidates/2026/CA/us-house-d15/mantosh-kumar.md` - `issues-flagged`

## Notes / observations

- CA Secretary of State certified candidate list confirms AD-23 candidates Marc Berman, Rick Giorgetti, and David G. Johnson; and CA-15 candidates Anthony Van Dang, Mantosh Kumar, Kevin Mullin, Charles Hoelter, and Jim Garrity.
- CA Secretary of State contact list confirms current AD-23 and CA-15 candidate contact/ballot-designation data, including Hoelter's campaign site and Kumar's campaign site.
- EdSource pages for Mattammal and Lara failed to fetch in this review environment. The profiles should not rely on those pages without inline source URLs or a documented `DATA-GAP`.
