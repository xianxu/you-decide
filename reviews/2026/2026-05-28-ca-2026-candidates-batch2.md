---
batch: ca-2026-candidates-batch2
date: 2026-05-28
reviewer-stack: codex
producing-stack: claude
scope: candidates
files-reviewed: 7
issues-blocker: 4
issues-important: 5
issues-minor: 1
status: issues-flagged
---

# Review - ca-2026-candidates-batch2

Full per-file review of seven candidate profiles that had not been individually cleared:

- `candidates/2026/CA/San-Mateo/county-controller/thomas-morgan.md`
- `candidates/2026/CA/San-Mateo/supervisor-d3/joaquin-jimenez.md`
- `candidates/2026/CA/San-Mateo/supervisor-d3/ray-mueller.md`
- `candidates/2026/CA/San-Mateo/county-superintendent-schools/hector-camacho-jr.md`
- `candidates/2026/CA/San-Mateo/county-superintendent-schools/chelsea-bonini.md`
- `candidates/2026/CA/assembly-d23/david-johnson.md`
- `candidates/2026/CA/assembly-d23/marc-berman.md`

Method: applied `you-decide/review.md` Stage 2 checklist against source-tier compliance, genesis tracking, internal consistency, candidate-name disambiguation, and math where applicable. Checked `calibration-skills/source-hygiene-tier-list.md`, `sources/CA.md`, `sources/US.md`, the San Mateo County May 5 qualified-candidate roster, the San Mateo County March 11 roster, and the CA Secretary of State certified candidate list. No body/fact edits were made; required `DATA-GAP` / `DATA-FIXME` markers are reported for the fixer.

## Issues found

### blocker

#### `candidates/2026/CA/**/*.md` in this batch - genesis tracking

All seven profiles fail the review contract that every decisive claim has an inline source URL. Most load-bearing claims are supported only by a source list at the bottom or by bracketed source labels such as `[Sources: SM Daily Journal, smcgov.org, CBS SF]` without URLs beside the specific assertion. This affects biography, positions, controversies, endorsements, and donor claims in every reviewed file.

Suggested fix: add inline URLs for each decisive claim, or demote unverifiable assertions to explicit markers such as `**DATA-GAP** [axis: <axis>; severity: med|high; last-attempt: 2026-05-28]: ...`.

#### `candidates/2026/CA/San-Mateo/county-controller/thomas-morgan.md` - official ballot status conflict

The profile marks Morgan `status: active` and says the May 2026 San Mateo County roster is "consistent with March roster data" (lines 6 and 42). The March 11 roster included Thomas Royal Morgan II as pending for County Controller, but the May 5 "Qualified Candidates Only" roster for San Mateo County Controller lists David Canepa, Jim Irizarry, and Juan Raigoza; Morgan is absent. This is not consistent with the March pending snapshot and could mean the profile is stale or should be out-of-scope.

Suggested fix: verify with the latest SMCACRE candidate roster or ballot manifest. If Morgan did not qualify, change status/scope accordingly; if access is inconclusive, add `DATA-FIXME [axis: strategic-viability; severity: high; last-attempt: 2026-05-28]` next to the active-ballot claim.

#### `candidates/2026/CA/San-Mateo/county-controller/thomas-morgan.md` - source-tier failure for decisive credential claim

The Controller profile's only positive competence signal is the CPA credential (line 21), but the source list relies on TaxBuzz, a secondary business listing/aggregator, not the California Board of Accountancy or another primary license source (line 43). Because the CPA credential is load-bearing for the Controller office read, Tier A verification is required.

Suggested fix: verify against the California Board of Accountancy license lookup or mark `DATA-GAP [axis: competence; severity: med; last-attempt: 2026-05-28]`.

#### `candidates/2026/CA/assembly-d23/marc-berman.md` - term-limit math / timeline error

The profile says Berman would complete six terms in 2026 if reelected and that "his term ends Dec 2026 if reelected" (line 23). A 2026 Assembly reelection would begin a new two-year term in December 2026 and end in 2028; if the premise is six two-year terms since 2016, the final-term end date is December 2028, not December 2026. This affects the profile's post-Assembly incentive framing.

Suggested fix: correct the term-limit timeline or add `DATA-FIXME [axis: institutionalist; severity: high; last-attempt: 2026-05-28]` until verified.

### important

#### `candidates/2026/CA/San-Mateo/county-controller/thomas-morgan.md` - unreachable sources used as evidence

The profile uses an unreachable SmartVoter page and an SM Daily Journal URL marked HTTP 429 as support for prior candidacy / public-footprint claims (lines 19, 29, 44, 47). Unretrieved pages should not support decisive biography or absence-of-record assertions.

Suggested fix: replace with accessible Tier A/B evidence, or add `DATA-GAP [axis: competence; severity: med; last-attempt: 2026-05-28]`.

#### `candidates/2026/CA/San-Mateo/supervisor-d3/ray-mueller.md` - gap language not review-trackable

The profile says "Gap flagged" / "partial gap" for sanctuary posture, endorsement names, and campaign-finance details (lines 37, 68, 70), but does not use the required `DATA-GAP` shape with axis, severity, and last-attempt. Because endorsements and finance can affect capture/viability reads, this is not clean passable debt as written.

Suggested fix: convert each gap to explicit `DATA-GAP [axis: ...; severity: low|med; last-attempt: 2026-05-28]` markers, or verify the facts.

#### `candidates/2026/CA/San-Mateo/supervisor-d3/joaquin-jimenez.md` - campaign-finance and endorsement claims need direct support or gap markers

The profile asserts no major union endorsements, approximately $6,000 raised, more than $2,000 spent, and late FPPC filing status (lines 66-68). The source list points to reporting and an article about missing filings, but the finance claims are not inline-sourced to FPPC/NetFile and no `DATA-GAP` marker names the confidence limits.

Suggested fix: cite official filings or add `DATA-GAP [axis: capture-risk; severity: med; last-attempt: 2026-05-28]` for the finance/endorsement read.

#### `candidates/2026/CA/San-Mateo/county-superintendent-schools/hector-camacho-jr.md` and `candidates/2026/CA/San-Mateo/county-superintendent-schools/chelsea-bonini.md` - FPPC figures labeled too strongly

Both superintendent profiles rely on The Almanac's FPPC-sourced fundraising figures, but neither provides direct FPPC/CAL-ACCESS URLs. Camacho labels the fundraising block "FPPC, Tier A" (lines 61-66) while the source list says "Tier A via proxy" (line 91). Bonini's note acknowledges direct FPPC detail was not accessed (line 98) while still presenting specific donor and expenditure figures (lines 62-68).

Suggested fix: fetch and cite official filings, downgrade the tier label to Tier B reporting, or add `DATA-GAP [axis: capture-risk; severity: med; last-attempt: 2026-05-28]`.

#### `candidates/2026/CA/assembly-d23/david-johnson.md` - common-name disambiguation incomplete

"David Johnson" is a common name, and the profile does identify him as David G. Johnson, Santa Clara County GOP chair, and AD23 candidate, but it lacks the review-required explicit disambiguation note and two-source identity check. The source list includes Ballotpedia and community press as lower-tier supports (lines 73-77), but the profile should tie the identity to the CA Secretary of State certified list plus the campaign site or SM Daily Journal.

Suggested fix: add explicit disambiguation in the body, e.g. "This is David G. Johnson, Santa Clara County Republican Party chair and 2026 AD23 candidate, not other public figures named David Johnson," with Tier A/B inline URLs.

### minor

#### `candidates/2026/CA/assembly-d23/marc-berman.md` - biographical date needs cleanup

The profile says Berman was born `~1973` (line 21). Official sources checked for this review confirm birthplace/education but not the year; public secondary sources commonly list October 31, 1980. The year is not decisive for the profile's recommendation surface, but the unsupported approximate date should be removed or sourced.

Suggested fix: remove the birth-year estimate unless verified by a Tier A/B source.

## Files cleared (no issues)

None. Every file in this batch remains `review: issues-flagged` because each fails the inline-source genesis requirement, and several have med/high unsupported or stale claims.

## Per-file verdicts

- `candidates/2026/CA/San-Mateo/county-controller/thomas-morgan.md` - `issues-flagged`
- `candidates/2026/CA/San-Mateo/supervisor-d3/joaquin-jimenez.md` - `issues-flagged`
- `candidates/2026/CA/San-Mateo/supervisor-d3/ray-mueller.md` - `issues-flagged`
- `candidates/2026/CA/San-Mateo/county-superintendent-schools/hector-camacho-jr.md` - `issues-flagged`
- `candidates/2026/CA/San-Mateo/county-superintendent-schools/chelsea-bonini.md` - `issues-flagged`
- `candidates/2026/CA/assembly-d23/david-johnson.md` - `issues-flagged`
- `candidates/2026/CA/assembly-d23/marc-berman.md` - `issues-flagged`

## Notes / observations

- Artifact-leakage grep for `WebSearch`, `franding`, `TBD`, `<unknown>`, and empty markdown links returned no matches in the seven reviewed files.
- Math review was limited to ordinary numeric consistency; these are candidate profiles, not weighted `-read.md` files.
