---
batch: ca-general-packet-claude
date: 2026-10-04
reviewer-stack: claude
producing-stack: codex
scope: elections
files-reviewed: 6
issues-blocker: 1
issues-important: 1
issues-minor: 7
status: issues-flagged
---

# Review — November 2026 CA general packet (BT-114), cross-stack round 1

Cross-stack (Claude) review of the Codex-generated packet in `data/elections/2026/2026-11-03-CA-general/`. It builds on the same-stack record [`2026-10-04-ca-general-packet-codex-samestack.md`](2026-10-04-ca-general-packet-codex-samestack.md): claims Codex verified there were not re-verified, except where noted. Effort went mostly to the parts that record did not cover: state/federal candidate biographies, local-candidate claims, judicial biography dates, and a privacy sweep of the folder. About 30 web operations were used, all on 2026-10-04.

Severity terms: **Critical** is the procedure's *blocker*. **Important** and **Minor** match the procedure.

## Per-file verdicts

| File | Verdict | Why |
|---|---|---|
| `README.md` | **issues-flagged** | Critical: the ballot PDF it describes and hashes contains a personal name in its metadata. The fix changes the SHA-256 printed in this file. |
| `state-and-federal-candidates.md` | **issues-flagged** | Important: the procedure's disambiguation rule for the "David Johnson" common name is not met. All 14 other spot checks passed. |
| `local-candidates.md` | passed | Two Minor wording and staleness issues. No decisive claim is wrong. |
| `local-measures.md` | passed | No findings. Verified Measure RTM page 1 independently; the rest relies on the same-stack checks. |
| `state-propositions.md` | passed | No findings. Verified Propositions 43 and 45 against LAO, adding to the same-stack checks. |
| `judicial-retention.md` | passed | One Minor note about a stale access limit. Every biography date I checked matches official sources. |

## Issues found

### blocker (Critical)

#### `sources/2026-11-03-ballot.pdf` (described and hashed by `README.md`): voter's personal name in PDF metadata

The PDF's document-info dictionary has an `/Author` field set to a personal name: the name of the account that exported the reference ballot from Safari. It also has a `/CreationDate` of `D:20261005011232Z`. This review deliberately does not repeat the name. Run `strings sources/2026-11-03-ballot.pdf | grep /Author` to see it. The packet is public substrate, so this identifies the voter whose ballot style defines the packet. The ballot-style, district, and trustee-area combination already narrows the voter's location to a small area. The file is **untracked**, so nothing is in git history yet. Fix it before the first commit.

**Fix:**
1. Strip the document-info metadata. For example, run `exiftool -all= -overwrite_original sources/2026-11-03-ballot.pdf`, or `qpdf --empty --pages in.pdf -- out.pdf`, or re-export with the author field cleared. Then confirm that `strings … | grep -i author` returns nothing.
2. Recompute the SHA-256 and update it in `README.md` (line 34, currently `b2dcd898…fd440`) and in `ballot.json` (its recorded source hash).
3. Remove the empty harness directory `data/elections/2026/2026-11-03-CA-general/.claude/` (`.cc-writes`) so it doesn't land in the public folder.

No other personal identifiers turned up. I grepped the whole folder, including `sources/ballot-bt-114.txt`, `ballot.json`, `sources.json`, and the supplement, for the operator's name and email, street-address patterns, "precinct", and "voter id". The printed omniballot URL is generic and carries no voter token.

### important

#### `state-and-federal-candidates.md`: AD-23 "David G. Johnson" needs explicit disambiguation and a second source

The procedure (review.md → Disambiguation) names "David Johnson" as a common name that needs an explicit "this is X, NOT Y" line, plus identifying details cross-checked against at least two sources. The file identifies Johnson only from his own campaign site. The hazard is real: a search for the name also returns a different "Dave Johnson", an author at California Globe. The campaign-site facts are correct; a second source confirms them.

**Suggested correction** (append to the AD-23 Background paragraph):
> "This is David G. Johnson, the Santa Clara County Republican Party chair since January 2025 and owner of two commercial-construction firms (since 1994 and 2010). He is not any other similarly named California political figure or writer. Party chairmanship confirmed by the [California Republican Party county page](https://cagop.org/counties/santa-clara/)."

(Source: https://cagop.org/counties/santa-clara/; campaign: https://davidjohnsonad23.com/meet_david)

### minor

1. **`local-candidates.md`: the TIDE Academy description is inaccurate and stale.** "Close TIDE Academy and phase out its program at Woodside" reverses the decision. On February 4, 2026, the board voted to *move* the academic program to Woodside. The district later said "TIDE at Woodside" would not be implemented as intended because only 26 students enrolled, so students were distributed across other schools. **Fix:** "Nori joined the unanimous February 4, 2026 vote to close TIDE Academy on June 30 and move its program to Woodside High; the district later reported the Woodside program would not be implemented as intended because of low enrollment." Sources: https://www.seq.org/about-us/superintendent/tide-academy-information-page and https://www.almanacnews.com/education/2026/02/05/after-6-years-tide-academy-is-closing-down/ (unanimity). The cited Daily Journal URL returned 403 to this reviewer.
2. **`local-candidates.md`: the claim that both candidates resist the Sunset-site high-rise overstates the evidence.** The cited Combs newsletter (September 6, 2026) urges the city to "stay the course" on CEQA review of the 80 Willow Road builder's-remedy project. That is a process position, not opposition to the project. No source is cited for Velagapudi's position. **Fix:** "Combs urges completing CEQA review of the 80 Willow Road (former Sunset campus) builder's-remedy project despite litigation risk." Then drop the Velagapudi half, or cite a source for it. Source: https://drews-newsletter-c45b6e.beehiiv.com/p/september-2026-newsletter
3. **`README.md` line 59 goes stale once this review lands.** It says "`review: not-done` in research frontmatter means…". The frontmatter now carries cross-stack review state. **Fix:** rewrite as "Review state is in each file's frontmatter. See the [Codex same-stack record](…) and the [Claude cross-stack record](2026-10-04-ca-general-packet-claude.md)." Also add the new review to the README's report table.
4. **All six files: `generated-by: Codex` is capitalized.** The review.md enum is lowercase (`codex`). The cross-stack gate uses exact inequality, so it still passes (`claude` ≠ `Codex`), but the casing breaks `rg '^generated-by: codex'` audits. **Fix:** lowercase it. This touches frontmatter, so it falls to the fixer, not this reviewer.
5. **`judicial-retention.md`: the 403 access note is stale.** "Several court biography pages rejected direct retrieval with HTTP 403" — today the Stewart and Tracie Brown biography pages fetched directly without error. **Fix:** date the limitation ("on first research pass") or re-fetch and drop it.
6. **`state-and-federal-candidates.md`: "former real-estate business executive" (Kounalakis) is not supported by the cited CalMatters treasurer page.** That page says she is the "daughter of Sacramento developer Angelo Tsakopoulos". The claim is plausibly true but not bound. **Fix:** cite a source that states her AKT Development role, or rephrase to match CalMatters.
7. **`state-and-federal-candidates.md`: the description of Ma's Assembly service is fine, but note for the fixer:** CalMatters says "served four terms in the state Legislature". The file's generic "prior service in the Assembly" avoids the term count, which is the right call. No change needed. Logged only so a future fixer doesn't add an unverified term count.

## Spot checks that passed (claim → source)

**State and federal candidates** (all against live pages, 2026-10-04):
- Hilton's income-tax exemption on the first $150,000; both candidates oppose Proposition 40; Becerra's emergency insurance and utility rate freeze and financing for already-approved affordable housing. https://calmatters.org/california-voter-guide-2026/governor/
- Hilton avoided committing on repeal of the sanctuary law at the September 30 CNN debate. https://calmatters.org/politics/2026/09/california-general-election-gubernatorial-debate-cnn/
- Romero became a Republican in 2024; Ma's offices. https://calmatters.org/california-voter-guide-2026/lieutenant-governor/ (the $350,000 settlement was verified by the same-stack review)
- Wagner: former Irvine mayor and assemblymember, supports voter ID, pushed release of voter data to the Department of Justice. Weber: appointed 2021, elected 2022, permanent universal mail voting. https://calmatters.org/california-voter-guide-2026/secretary-of-state/
- Cohen controller since 2023; Morgan's firm acquired by Cantor Fitzgerald Investment Advisors. https://calmatters.org/california-voter-guide-2026/controller/
- Hawks on the Sacred Heart Schools (Atherton) executive team and a Republican activist; Kounalakis ambassador to Hungary and votes against tuition increases. https://calmatters.org/california-voter-guide-2026/treasurer/
- Bonta appointed 2021 and elected 2022; Gates a decade as Huntington Beach city attorney, DOJ Civil Rights Division, returned to Huntington Beach in November 2025. https://calmatters.org/california-voter-guide-2026/attorney-general/
- Kim: free City College and the $15 minimum wage. Allen: Proposition 4 wildfire bond. Consumer Watchdog's startup-capital and depletion concern, and Kim's acknowledgment that further study is needed. https://calmatters.org/economy/2026/08/insurance-commissioner-progressive-wave/
- Lieber elected 2022, BOE chair in 2026, prior Mountain View and Assembly service. https://boe.ca.gov/lieber/about.htm
- Shaw is Chino Valley board president; Barrera is San Diego Unified board president and a state superintendent adviser. https://calmatters.org/california-voter-guide-2026/superintendent-of-public-instruction/
- AB 3209 (Berman): Chapter 169, signed August 16, 2024; creates retail-theft restraining orders. https://leginfo.legislature.ca.gov/faces/billNavClient.xhtml?bill_id=202320240AB3209
- Johnson: 40 years in construction, two firms, Santa Clara County GOP chair. Campaign site plus cagop.org.

**Local candidates:**
- Combs on council since 2018, a Meta attorney, seeking a third term. Velagapudi a retired strategy consultant, on the Finance and Audit Commission, formerly on the Library Commission. https://www.almanacnews.com/menlo-park/2026/05/14/finance-commissioner-challenges-combs-for-menlo-park-city-council-seat/
- Combs opposes Measure P, wants to start with one lot (Plaza 2), and says land use belongs with the council. Newsletter dated September 6, 2026 (link above).
- Chen joined December 2018; Scolnick joined December 2022 and is current president. https://district.mpcsd.org/board/board-of-education

**Judicial retention:**
- Groban: Paul Weiss 1999–2005, Munger Tolles 2005–2010, Stanford and Harvard Law. Evans: Alameda Superior Court 2021–2022, on the Supreme Court since 2023, Stanford and UC Davis, and **includes "Assistant Public Defender, Sacramento County (1995)"**, so the "public defense" claim holds. 12-year term with a remainder-of-term rule. https://voterguide.sos.ca.gov/justices/supreme-court-justices/
- Stewart: First District since June 2014, confirmed presiding justice November 2022, SF chief deputy city attorney for 12 years, *Marriage Cases* and *Perry*, Howard Rice. https://appellate.courts.ca.gov/district-courts/1dca/bio/therese-m-stewart
- Tracie Brown: associate justice since November 2018, presiding justice confirmed April 7, 2023, SF Superior Court, federal prosecutor, private firms. https://appellate.courts.ca.gov/district-courts/1dca/bio/tracie-l-brown
- Chou: unanimous confirmation June 23, 2023, San Mateo Superior Court since 2018, Santa Clara county counsel, SF complex and appellate litigation, Supreme Court staff attorney. https://newsroom.courts.ca.gov/news/commission-confirms-appointments-courts-appeal-13
- All 13 names and divisions match the SOS First District listing and the ballot.

**Propositions and measures (additions to the same-stack review):**
- Proposition 43: two-thirds vote for voter-proposed local special taxes beginning January 1, 2027; unknown revenue reduction. https://voterguide.sos.ca.gov/propositions/43/analysis.htm
- Proposition 45: initial costs in the "high tens of millions… potentially exceeding $100 million", partly fee-offset; longer-term effects could go either way. https://voterguide.sos.ca.gov/propositions/45/analysis.htm
- Measure RTM, page 1, inspected visually: 0.5% / 1.0% rates, 14 years, about $980 million a year, efficiency reviews and withholding, independent oversight. https://smcacre.gov/system/files/2026-08/52-ENG-M206-ImpartialAnalysis-Public-Transit-District-Sales-Tax.pdf

**Internal consistency:** I parsed `ballot.json`. All 30 named candidates and 13 justices appear in `sources/ballot-bt-114.txt`. Party preferences match the printed ballot, and nonpartisan contests have a null party. Contest numbers 1–27 match the headings in the reports, and all 48 `research_anchor` values resolve to real headings. The counts in the README coverage table (11 races / 22 candidates; 3 / 8; 13 retentions) are correct.

**Neutrality:** I grepped all six files for recommendation language and read the candidate files in full. No personalized recommendation, ranking, or vote selection appears. Campaign claims are consistently attributed and their causal claims are flagged as unverified. The paired framing gives each candidate comparable space. Hits in `supplement-2026-10-04.md` are attributed third-party endorsements (CA YIMBY, LWV), which is acceptable, but that file was not in scope.

## Not checked

- `supplement-2026-10-04.md` and `sources.json`: privacy grep only. No factual or neutrality review.
- Measures V, L, AA, J, U, and P: no independent fact check. I rely on the same-stack review's visual checks for V and P. RTM page 2 was not checked.
- Propositions 1–5 and 37–42, 44: not re-verified (the same-stack review covered 1, 2, 5, 38, 40–42, and 44). Propositions 3, 4, 37, and 39 have had no fact check from either stack beyond comparison with the ballot text.
- Unverified biography details: Wilson (commissioner years, Napa background), Smiley, Banke, Desautels, Petrou, Rodríguez, Burns, and Simons's date discrepancy (the same-stack review checked Smiley and Simons). The CJP public-index absence claim was not re-run.
- Candidate claims sourced only to campaign sites (Soulé's biography and issues, Liccardo's page, Berman's priorities, Velagapudi's platform): not re-fetched. The Combs newsletter's Measure P stance was checked. The HHS OIG report and the Chino Valley DOJ account were not re-fetched (the same-stack review checked them).
- Campaign finance, roll calls, and court dockets: out of scope, as the packet itself states.
- The PDF's rendered pages: I compared `sources/ballot-bt-114.txt` against `ballot.json` but did not visually compare it with every PDF page.

## Notes / observations

- **Enum deviation:** the dispatch asked for `review: needs-work`. I used `issues-flagged`, because that is the canonical value in review.md and the one `scripts/audit-review.sh` counts. `needs-work` would be invisible to the audit queries.
- The packet is well hedged overall. Its main residual risk is staleness, not fabrication. Two of the three content findings are claims that were true or plausible at research time and need a dated re-check (the TIDE follow-through, the 403 note).

## Re-review — 2026-10-04 (round 2, diff-scoped)

I checked only the fixer's changes and looked for regressions.

| Finding | Result |
|---|---|
| Critical: `/Author` in the PDF metadata | **Fixed.** `pdfinfo`: producer cairo 1.18.4, `Metadata Stream: no` (no XMP), no Author or Creator. `strings` shows no author, xmpmeta, or dc:creator. Decompressed content streams match "author" only inside ballot text ("Authorizes…"). 25 pages render. The SHA-256 `2726b146…c888` matches the file, `README.md`, and `ballot.json`. The old hash appears nowhere. `ballot.json` parses. `.claude/` is gone. |
| Important: Johnson disambiguation | **Fixed.** The sentence and the cagop.org cite are present in the AD-23 Background paragraph. |
| Minor: TIDE wording | **Fixed.** Matches the suggested text, with the district page and Almanac cited. |
| Minor: Sunset / 80 Willow | **Fixed.** Uses the Combs CEQA wording and adds a no-sourced-Velagapudi-position note. |
| Minor: README review line and table | **Fixed.** Both review records are linked. Residual (Minor, not blocking): line 63 still opens "The review is a same-stack fresh-context spot check, not an independent cross-stack certification". Reword it so it doesn't contradict the cross-stack record now listed beside it. |
| Minor: `generated-by` casing | **Fixed.** `codex` in all six files. |
| Minor: judicial 403 note | **Fixed.** Dated to the first pass. |
| Minor: Kounalakis | **Fixed.** Now matches the CalMatters wording. |

### New finding — blocker (Critical)

#### `sources/2026-11-03-ballot.pdf`: a marked vote selection is visible on page 25

Visual rendering, plus a scan of all 25 pages for yellow pixels, shows a **filled (selected) star on the YES option for Measure P (contest 48)**. Page 25 is the only page with a filled star; every other choice shows an empty star. This is one voter's marked choice, saved in the omniballot reference-ballot export. It is private vote data in the public, neutral layer: it breaks the privacy rule (item 5) and the neutrality posture (a de facto position on a contested measure). Stripping the metadata didn't touch it because it is page content. `sources/ballot-bt-114.txt` is unaffected, since the text extraction has no selection state.

**Fix:** re-export the reference ballot from the county voter guide with **all selections cleared**, or redact the page-25 star to the unselected state. Then re-render with metadata stripped, as before. Confirm that a filled-star scan of every page finds zero yellow pixels, and that `pdfinfo` reports 25 pages and no metadata. Recompute the SHA-256 and update it in `README.md` and `ballot.json`. **Lesson:** the privacy sweep must include a *visual/raster* pass over captured ballots, not only text and metadata. Interactive ballot tools persist the user's marks into the export.

### Round-2 verdicts

- `state-and-federal-candidates.md`: **passed**. All findings are resolved.
- `README.md`: **stays issues-flagged** until the PDF it hashes and describes is re-exported without marks. Flip it after a diff-scoped re-check.
- The other four files: unchanged, **passed**.

## Re-review — 2026-10-04 (round 3, diff-scoped)

The page-25 marked-selection finding is **resolved by withholding the PDF**:

- `sources/` now holds only `ballot-bt-114.txt`. Nothing in `data/elections/2026/` references a `sources/*.pdf` path or either old SHA-256. `judicial-retention.md` now links to the text file.
- `ballot.json` parses. `source.pdf` is `null`, `pdf_note` explains why it's withheld, and `sha256` is removed. `page_count` stays at 25, consistent with the 25 "Page N of 25" markers in the text file, which the `ballot_pages` note now points to.
- The text file has no selection state. There are 33 bare `YES` and 33 bare `NO` option lines (66 lines, 33 yes/no contests, one with page-break indentation), and no star, check, or "selected" glyphs. No personal name or email appears anywhere in the folder or the sibling manifest.
- The README states that the export is withheld and why, and points to the county's public tool. The stale "same-stack… not cross-stack" sentence is rewritten.

`README.md` → **passed**. All six files are now `review: passed`, and no Critical or Important findings remain open.
