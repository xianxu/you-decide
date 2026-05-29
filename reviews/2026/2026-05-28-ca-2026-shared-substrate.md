---
batch: ca-2026-shared-substrate
date: 2026-05-28
reviewer-stack: codex
producing-stack: claude
scope: all-shared
files-reviewed: 41
issues-blocker: 6
issues-important: 5
issues-minor: 2
status: fail
---

# Review - ca-2026-shared-substrate

Formal review pass over the 2026 California shared substrate:

- `candidates/2026/CA/**/*.md`
- `elections/2026/*.md`
- `controversies/2026/*.md`

Method: applied `you-decide/review.md` checklist for source hygiene, genesis tracking, official ballot scoping, cross-reference resolution, stale placeholders, and internal consistency. Official ballot checks used the CA Secretary of State certified candidate list PDF and the San Mateo County candidate roster PDF.

## Issues Found

### blocker

#### `elections/2026/2026-06-02-CA-primary.md` - ballot-scope overclaim

The manifest says it is the "Manifest of every race appearing on any CA voter's 6/2/2026 ballot" at line 23, but it omits multiple statewide races that appear in the official CA certified candidate list: Lieutenant Governor, Secretary of State, Controller, Treasurer, Attorney General, and Insurance Commissioner.

Suggested fix: either narrow the statement to "current partial San Mateo-oriented coverage" or add the omitted statewide races and candidate slugs.

#### `elections/2026/2026-06-02-CA-primary.md` - statewide candidate undercount

The listed statewide races are incomplete against the CA Secretary of State certified list:

- Superintendent of Public Instruction lists 3 candidates; the official list shows 10.
- Board of Equalization District 2 lists 3 candidates; the official list shows 6.
- Governor is explicitly labeled "8 viable candidates"; that may be a research-scope decision, but the manifest does not distinguish "certified candidates" from "viable candidates."

Suggested fix: preserve both concepts explicitly: `certified-candidates` for ballot truth and `research-scope` / `viability-filter` for the decision workflow.

#### `elections/2026/2026-06-02-CA-primary.md` - district candidate omissions

The manifest omits certified candidates in races it does include:

- US House District 16 omits Kevin Johnson and Peter Sundin Soule.
- Assembly District 23 omits David G. Johnson.

Candidate profile files now exist for the omitted D16 and AD23 candidates, so the manifest is stale relative to the repository itself.

Suggested fix: update those race entries and add `[[kevin-johnson]]`, `[[peter-soule]]`, and `[[david-johnson]]` links.

#### `elections/2026/2026-06-02-CA-primary.md` - unresolved TBD in shared manifest

Line 143 still contains "Status TBD" for Board of Supervisors District 5. The San Mateo County roster checked for this review shows Board of Supervisors Districts 2 and 3, not D5, on this candidate roster.

Suggested fix: remove D5 from this manifest unless a later official roster proves it appears on the June 2, 2026 ballot; if retained for future-cycle context, mark it clearly out-of-scope.

#### `controversies/2026/CA.md` - stale derivation count and path

Line 21 says the map is derived from 30 candidate profiles, but the current reviewed scope contains 39 candidate profiles under `candidates/2026/CA`. Line 145 points to stale private-brain path `data/life/politics/candidates/2026/CA/`.

Suggested fix: update the derivation count and use repo-root-relative `candidates/2026/CA/`.

#### cross-substrate - missing calibration skill

The shared substrate and algorithm docs reference `[[trump-era-cater-discount]]`, but no matching file exists under `you-decide/calibration-skills/`.

Affected reviewed files:

- `controversies/2026/CA.md`

Related non-reviewed algorithm files also depend on this missing skill: `you-decide/SKILL.md`, `you-decide/review.md`, `you-decide/templates/governor.md`, and `you-decide/templates/assessor-clerk-recorder.md`.

Suggested fix: add the missing calibration skill or change references to the actual existing rule.

### important

#### `candidates/2026/CA/us-house-d16/sam-liccardo.md` - unverified campaign-finance claim

Line 80 says FEC data was "not fetched due to rate limits" and OpenSecrets returned 403, but still draws a donor-profile conclusion. The source table repeats the "not fetched, 403" note at line 101.

Suggested fix: fetch the FEC data directly or remove the donor conclusion until verified.

#### `candidates/2026/CA/us-house-d15/kevin-mullin.md` - 403/search-summary source leakage

The profile records direct-fetch failures and use of search summaries for congressional/GovTrack data. That is useful as a research note, but it is not clean enough as a reviewed factual substrate.

Suggested fix: replace inaccessible/search-summary-derived assertions with accessible Tier A/B sources or move the access failures to a "Data gaps" section that does not support claims.

#### `candidates/2026/CA/San-Mateo/assessor-clerk-recorder/jim-irizarry.md` - donor profile unverified

The donor section explicitly says FPPC/donor data was not retrieved and the donor profile is unverified.

Suggested fix: fetch SM County NetFile/FPPC data before using donor profile in any downstream read.

#### `candidates/2026/CA/San-Mateo/county-controller/juan-raigoza.md` - campaign-finance source blocked

The profile cites a theballotbook/FPPC receipts URL as Tier A while also saying it returned 403 on direct fetch.

Suggested fix: use an accessible official or exported campaign-finance source, or mark the finance detail as a gap.

#### `candidates/2026/CA/supt-public-instruction/william-mcgee.md` - search-result-only sources

The source list includes KPBS and LAist entries marked "search result only, not fetched." Search-result-only evidence should not be part of reviewed substrate.

Suggested fix: fetch those pages or remove them from the source table.

### minor

#### source-tier consistency - Wikipedia usage needs a cleanup pass

Multiple candidate profiles retain Wikipedia citations for biographical or historical details. Some entries explicitly restrict Wikipedia to orientation, which matches `source-hygiene-tier-list`; others use it in body text in ways that are easy for downstream reads to treat as decisive.

Suggested fix: replace Wikipedia citations for load-bearing biography/record claims with official bios, campaign pages, legislative pages, or Tier B reporting where practical.

#### schema consistency - frontmatter uses mixed date fields

Some files use `generated:` plus `generated-on:`, while the review skill only requires `generated-by`, `generated-on`, and `review`. This is not blocking, but it makes audit scripts noisier.

Suggested fix: keep `generated:` only where the file-type schema explicitly calls for it; otherwise rely on `generated-on:`.

## Files Cleared

None. The batch has blocker-level scoping and cross-reference issues, so no file in this shared-substrate batch should be treated as passed by this review.

## Files Reviewed

- `candidates/2026/CA/San-Mateo/assessor-clerk-recorder/clinton-freeman.md`
- `candidates/2026/CA/San-Mateo/assessor-clerk-recorder/david-canepa.md`
- `candidates/2026/CA/San-Mateo/assessor-clerk-recorder/jim-irizarry.md`
- `candidates/2026/CA/San-Mateo/county-controller/juan-raigoza.md`
- `candidates/2026/CA/San-Mateo/county-controller/thomas-morgan.md`
- `candidates/2026/CA/San-Mateo/county-superintendent-schools/chelsea-bonini.md`
- `candidates/2026/CA/San-Mateo/county-superintendent-schools/hector-camacho-jr.md`
- `candidates/2026/CA/San-Mateo/supervisor-d3/joaquin-jimenez.md`
- `candidates/2026/CA/San-Mateo/supervisor-d3/ray-mueller.md`
- `candidates/2026/CA/Santa-Clara/district-attorney/daniel-chung.md`
- `candidates/2026/CA/Santa-Clara/district-attorney/jeff-rosen.md`
- `candidates/2026/CA/assembly-d21/diane-papan.md`
- `candidates/2026/CA/assembly-d21/jabra-muhawieh.md`
- `candidates/2026/CA/assembly-d23/david-johnson.md`
- `candidates/2026/CA/assembly-d23/marc-berman.md`
- `candidates/2026/CA/assembly-d23/rick-giorgetti.md`
- `candidates/2026/CA/boe-d2/john-pimentel.md`
- `candidates/2026/CA/boe-d2/sally-lieber.md`
- `candidates/2026/CA/boe-d2/william-shireman.md`
- `candidates/2026/CA/governor/antonio-villaraigosa.md`
- `candidates/2026/CA/governor/chad-bianco.md`
- `candidates/2026/CA/governor/katie-porter.md`
- `candidates/2026/CA/governor/matt-mahan.md`
- `candidates/2026/CA/governor/steve-hilton.md`
- `candidates/2026/CA/governor/tom-steyer.md`
- `candidates/2026/CA/governor/tony-thurmond.md`
- `candidates/2026/CA/governor/xavier-becerra.md`
- `candidates/2026/CA/supt-public-instruction/frank-lara.md`
- `candidates/2026/CA/supt-public-instruction/gus-mattammal.md`
- `candidates/2026/CA/supt-public-instruction/william-mcgee.md`
- `candidates/2026/CA/us-house-d15/anthony-van-dang.md`
- `candidates/2026/CA/us-house-d15/charles-hoelter.md`
- `candidates/2026/CA/us-house-d15/james-garrity.md`
- `candidates/2026/CA/us-house-d15/kevin-mullin.md`
- `candidates/2026/CA/us-house-d15/mantosh-kumar.md`
- `candidates/2026/CA/us-house-d16/jotham-stein.md`
- `candidates/2026/CA/us-house-d16/kevin-johnson.md`
- `candidates/2026/CA/us-house-d16/peter-soule.md`
- `candidates/2026/CA/us-house-d16/sam-liccardo.md`
- `controversies/2026/CA.md`
- `elections/2026/2026-06-02-CA-primary.md`

## Notes

This pass intentionally failed fast on official ballot scoping and genesis/source-hygiene problems. It did not attempt to repair the substrate. A re-review should be run after the manifest is reconciled with the official candidate lists and the listed source gaps are closed.
