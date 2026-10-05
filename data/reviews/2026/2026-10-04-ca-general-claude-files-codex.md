---
batch: ca-general-claude-files-codex
date: 2026-10-04
reviewer-stack: codex
producing-stack: claude
scope: elections
files-reviewed: 2
issues-critical: 0
issues-important: 5
issues-minor: 4
status: needs-work
generated-by: codex
generated-on: 2026-10-04
review: not-done
---

# Cross-stack review — California general election

Review date: October 4, 2026. Only the following two artifacts were reviewed. Reference inputs and external sources were read as evidence; candidate dossiers and companion research files were not reviewed. Findings use the original, pre-review-metadata line numbers.

| File | Verdict | Findings |
|---|---|---|
| `data/elections/2026/2026-11-03-CA-general.md` (A) | **passed** | None in the requested manifest checks |
| `data/elections/2026/2026-11-03-CA-general/supplement-2026-10-04.md` (B) | **needs-work** | 5 Important; 4 Minor |

The review followed `you-decide/review.md` and `you-decide/calibration-skills/source-hygiene-tier-list.md`, with the California and US source registries. The user's explicit write-surface, `needs-work` status, and no-commit instructions override the review procedure's default commit/status conventions. No content fixes were applied.

## A — manifest evidence

All **48 contests** agree with `2026-11-03-CA-general/ballot.json` and `2026-11-03-CA-general/sources/ballot-bt-114.txt`: **14 candidate contests, 30 candidate names, 13 judicial retentions, and 21 measures**. Checked contest ordering, every candidate's printed name and order, all 20 printed party preferences, omission of party labels in nonpartisan contests, selection counts, and all 48 district tags. Judicial offices and divisions and measure short descriptions also agree. All **22 actual candidate `[[slug]]` links** resolve uniquely under `data/candidates/2026/CA/`; the literal `[[slug]]` in the explanatory paragraph is not a candidate link.

| Ballot positions | Contests checked |
|---|---|
| 1–10 | Governor; Lieutenant Governor; Secretary of State; Controller; Treasurer; Attorney General; Insurance Commissioner; BOE D2; House D16; Assembly D23 |
| 11–23 | Groban; Evans; Langhorne Wilson; Smiley; Banke; Stewart; Desautels; Petrou; Rodriguez; Brown; Chou; Simons; Burns |
| 24–27 | Superintendent; Sequoia UHSD Area D; Menlo Park City School Board; Menlo Park Council D2 |
| 28–41 | Propositions 1, 2, 3, 4, 5, 37, 38, 39, 40, 41, 42, 43, 44, 45 |
| 42–48 | Measures RTM, V, L, AA, J, U, P |

Source provenance: [county reference-ballot application](https://ca.omniballot.us/sites/06081/cvig/app/cvig/vig/ballot). This is a comparison with the supplied reference transcription, not an independent certification of the live ballot.

## B — Important findings

### I1. Decisive claims lack claim-level source bindings

**Locations:** lines 21, 36–41, 45, 47, 112, 118–119, 130–134, 162–175, 189–194, 203. Mixed-source sections cannot inherit whichever citation happens to appear nearby. Particularly clear examples are Soulé's endorsements and $10K fundraising figure, Becerra's housing program and YIMBY endorsement, Combs's height-limit position, Velagapudi's quoted housing position, Galatolo's July sentence and appeal, and the Almanac endorsement/forum timing. The future July sentence cannot be supported by the February conviction article without evidence of an update. Two-source lists for Hilton's platform and insurance positions also do not identify which source supports each claim.

**Exact suggested fix:** attach the supporting Tier-A/B URL to each listed bullet, with the relevant date for money, statements, and legal developments. For any bullet without verified support, replace the assertion with `**DATA-GAP** [axis: none; severity: med; last-attempt: 2026-10-04]: <specific fact> has not been verified against a Tier-A/B source; no substantive conclusion is drawn.` Do not simply add a bibliography or a global disclaimer. For the verified Becerra encampment statement, add the [AP/Scripps report](https://www.scrippsnews.com/politics/america-votes/california-governor-rivals-clash-over-costs-homelessness-and-trump-in-only-debate). For the early Hilton statement, narrow it to the January 6, 2021 remarks documented by [Mediaite](https://www.mediaite.com/media/tv/fox-news-host-declares-u-s-elections-broken-just-as-democrats-look-poised-to-retake-senate/); separately source the investigation claim or mark it unverified. [Soulé's cited homepage](https://souleforcongress.com/) supports the Trump quotation, but does not establish the uncited fundraising claim.

### I2. A budget deficit is described as completed spending cuts

**Location:** line 106, SDUSD “Earlier round: about $94M in cuts.” The cited article describes a nearly $94M projected budget gap and authorization of layoff notices, not proof that $94M of cuts occurred. Its HTML publication metadata dates it **March 6, 2024**, so the year should be explicit alongside the separate 2026 figures.

**Exact suggested fix:** replace with: “**March 2024:** SDUSD faced a nearly $94M projected deficit for the next school year; the board authorized roughly 400 layoff notices, with fewer actual job losses expected.” Retain the [10News source](https://www.10news.com/news/local-news/san-diego-unified-school-district-approves-job-cuts-to-close-94m-deficit). Do not call the deficit realized savings. The separate March 2026 figures are supported.

### I3. Measure P combines different proposals and overstates their affordability category

**Location:** line 180. The sentence binds “345 very-low-income units” to a $19M–$45M funding-gap range as though it describes one settled plan. Following Hoodline's link to the underlying Tier-B reporting shows three competing proposals: Alliant's 345 apartments serve multiple income levels; the reported financing-gap range spans all three proposals. The LWV URL was unavailable to this reviewer, so it cannot resolve that conflict. Hoodline is explicitly AI-assisted and should not remain the decisive citation when the underlying reporting is accessible.

**Exact suggested fix:** replace the sentence with: “Three competing proposals for Plazas 1–3 contain 345, 347, and 500 apartments with different affordability mixes. A consultant identified financing gaps of about $20M, $45M, and $19.2M, respectively.” Cite the [September 29 Daily Post report](https://padailypost.com/2026/09/29/downtown-menlo-park-housing-proposals-will-cost-the-city-money-or-result-in-less-parking-report-says/). If separately retaining a Housing Element target from the League, explicitly attribute it as that target and distinguish it from submitted proposals. Remove the unsupported universal “very-low-income” characterization. The [Hoodline item](https://hoodline.com/2026/09/menlo-park-parking-lot-housing-plans-face-19m-to-45m-cash-gaps/) is a lead, not the final evidence.

### I4. Governor polling remains unverified numerical substrate

**Locations:** lines 54–59. Berkeley IGS/LAT and SurveyUSA numbers and dates have no pollster URL, and the Silver Bulletin average has no URL. The text admits compilation from Wikipedia and asks a future reader to verify it. These are numerical election claims, not merely orienting biography. That disclaimer does not make the asserted numbers verified facts.

**Exact suggested fix:** add and verify the dated original poll releases and average snapshot; otherwise remove those three numerical entries and replace them with explicit DATA-GAP entries. The PPIC row can be retained and directly linked to the [original September survey, page 3](https://www.ppic.org/pdf/ppic-statewide-survey-californians-and-their-government-september-2026.pdf), which confirms September 4–10 and 60/38. Do not cite the October supplement date as the field date.

### I5. Controller allegations and polling need source-tier treatment

**Locations:** lines 67, 72–73. The resignation/audit-video claim relies solely on SJV Sun; the audit-record letter and polling rely on California Globe, without an explicit outlet-tilt flag or an independently verified primary record. The Globe pages reproduce the latter two claims, so this is a source-quality finding, not a claim that the figures were invented. The SJV Sun page remained inaccessible through both web and direct fetch.

**Exact suggested fix:** link the original Morgan statement and complete video/transcript for the resignation claim, the Assembly Republicans' actual letter, and the original poll memo with sponsor, field dates, sample, and methodology. If retaining the secondary links, label their conservative framing and corroborate with Tier A/B; otherwise demote the substantive claims to DATA-GAP. For the poll, distinguish **September 15–16 fieldwork** from the **September 24 report date**, and distinguish the initial ballot from the informed ballot. Sources: [SJV Sun](https://sjvsun.com/?p=104163), [Globe letter article](https://californiaglobe.com/fr/assembly-republicans-demand-state-controllers-audit-records/), [Globe polling article](https://californiaglobe.com/fr/herb-morgan-californians-want-someone-watching-the-money/). Morgan's separate Examiner quotation is verified and is not part of this finding.

## B — Minor findings

### M1. Hilton interview date is the article date

**Location:** line 22. [Mediaite](https://www.mediaite.com/media/tv/ms-now-hosts-throw-down-with-steve-hilton-after-he-refuses-to-say-who-won-2020-election-why-cant-you-answer-the-question/) published Monday May 4 but says the interview occurred Sunday. **Exact suggested fix:** change the label to “**May 3, 2026 (reported May 4):**” and use “repeatedly declined” rather than an approximate refusal count unless the video is counted. The quotation and repeated refusal are supported.

### M2. Proposition money needs an underlying data date and narrower zero wording

**Locations:** line 138 and table cells saying “none.” All 28 displayed side totals match the CalMatters widgets, allowing the supplement's rounding. However, the embedded [source note](https://project-voter-guide-2026.interactives.calmatters.org/general/en/campaign-finance/note?isProp=true) says the data was last updated **September 28, 2026**. A widget showing zero is not proof of no relevant financing anywhere; multi-measure committees and outside spending require care. The [FPPC listing](https://www.fppc.ca.gov/search-filings/top-10-contributors-list/november-2026-general-election/) identifies a joint Yes-on-40/No-on-41-and-42 committee, for example; its totals were not substituted for the CalMatters series.

**Exact suggested fix:** change the preamble to “CalMatters proposition-committee fundraising totals, data updated September 28, 2026, accessed October 4. Zero means $0 displayed in this series, not absence of all opposition funding; shared committees and outside spending are not independently reconciled here.” Replace “none” money cells with “$0 displayed.” Link the individual proposition widgets or guide pages.

### M3. Prop 44 lawsuit summary omits the reported denial; precise exchange only partially verified

**Location:** line 162. The [Daily Journal](https://dailyjournal.com/article/394505-healthcare-clinics-accuse-seiu-uhw-of-racketeering-over-proposition-44) accessible headline/deck and opening paragraphs confirm CPCA plus five clinics, organizing concessions involving 25,000 workers, and SEIU-UHW's categorical denial. The exact offer-to-drop formulation is beyond the accessible article excerpt. A [Law360 case listing](https://www.law360.co.uk/employment-authority/articles/2528019) independently confirms the federal RICO filing on September 18 in California Eastern District; the complaint itself was not retrieved.

**Exact suggested fix:** add “SEIU-UHW denies the allegations,” retaining “allegations, not findings.” Either support the precise offer-to-drop sentence with a retrievable complaint/full Tier-B report, or narrow it to “The plaintiffs allege the measure was used to pressure clinics into organizing concessions involving 25,000 workers.” Do not infer a judicial finding from the filing. This is a verification limit and balance improvement, not evidence that the underlying allegation is false.

### M4. Measure P fundraising lacks reporting date and composition

**Locations:** lines 181–183. The totals and named funders are supported, but the [September 16 Almanac story](https://www.almanacnews.com/election/2026/09/16/menlo-park-downtown-lot-measure-race-gathers-almost-478000-before-ballots-go-out/) includes loans and in-kind support; it is not an October 4 cash-balance report. MidPen's contribution was described as appearing in a future filing.

**Exact suggested fix:** label the two totals “reported September 16; includes loans and nonmonetary support,” and qualify MidPen as reported support pending a subsequent filing. Do not describe the totals as current cash on hand.

## B — web claim-check ledger

The numbered ledger below records **38 checks**, including all 14 proposition rows (both money columns), exceeding the requested 20 decisive claims. “Supported” means the fetched source supports the claim, not independent validation of the source's underlying records. Access failures are explicitly separated from contradictions.

| # | Claim checked | Evidence and result |
|---|---|---|
| 1 | Hilton 2020–21 remarks | Located [January 6, 2021 reporting](https://www.mediaite.com/media/tv/fox-news-host-declares-u-s-elections-broken-just-as-democrats-look-poised-to-retake-senate/) supporting the ballot-harvesting/counting criticism; investigation component not established by that page. I1. |
| 2 | Hilton May refusal and quotation | [Mediaite](https://www.mediaite.com/media/tv/ms-now-hosts-throw-down-with-steve-hilton-after-he-refuses-to-say-who-won-2020-election-why-cant-you-answer-the-question/): content supported; event-date correction M1. |
| 3 | Hilton June 5 acknowledgment of Biden's victory | [LAist](https://laist.com/news/politics/california-governor-candidate-steve-hilton-says-he-believes-joe-biden-won): quotation and date supported. |
| 4 | Hilton June 8 rejection of intervention | Original short URL failed; [canonical TheWrap article](https://www.thewrap.com/media-platforms/politics/steve-hilton-reacts-trump-rigged-california-election-claims/) supports quotation and June 8 date. |
| 5 | Hilton September debate confidence | [AP/Scripps](https://www.scrippsnews.com/politics/america-votes/california-governor-rivals-clash-over-costs-homelessness-and-trump-in-only-debate): supported. |
| 6 | Becerra encampment statement | Same [AP/Scripps report](https://www.scrippsnews.com/politics/america-votes/california-governor-rivals-clash-over-costs-homelessness-and-trump-in-only-debate): supported, but missing its own binding in B. |
| 7 | Morgan party/person quotation | [Examiner](https://www.sfexaminer.com/news/politics/gop-controller-candidate-morgan-emphasizes-competence/article_767130f0-6810-422e-b884-79539f2efe93.html): exact wording and speaker verified in directly fetched HTML after browser-tool failure. |
| 8 | Soulé campaign Trump statement | [Campaign homepage](https://souleforcongress.com/): exact quoted wording supported. |
| 9 | SDUSD 221 classified positions | [KPBS](https://www.kpbs.org/news/education/2026/03/04/san-diego-unified-warns-secretaries-clerks-and-other-classified-staff-of-layoffs): supported as positions voted for elimination, not 221 people laid off; only 133 were staffed. |
| 10 | SDUSD $19M savings | Same [KPBS](https://www.kpbs.org/news/education/2026/03/04/san-diego-unified-warns-secretaries-clerks-and-other-classified-staff-of-layoffs): supported as anticipated savings. |
| 11 | SDUSD $47.7M next-year deficit | Same [KPBS](https://www.kpbs.org/news/education/2026/03/04/san-diego-unified-warns-secretaries-clerks-and-other-classified-staff-of-layoffs): supported as a projection. |
| 12 | Earlier $94M cuts | [10News](https://www.10news.com/news/local-news/san-diego-unified-school-district-approves-job-cuts-to-close-94m-deficit): deficit rather than completed cuts; March 2024. I2. |
| 13 | Prop 44 federal suit and 25,000-worker allegation | [Daily Journal](https://dailyjournal.com/article/394505-healthcare-clinics-accuse-seiu-uhw-of-racketeering-over-proposition-44) plus [Law360](https://www.law360.co.uk/employment-authority/articles/2528019): partial verification with limits in M3. |
| 14 | Measure P Yes money and named funders | [Almanac](https://www.almanacnews.com/election/2026/09/16/menlo-park-downtown-lot-measure-race-gathers-almost-478000-before-ballots-go-out/): ~$205K and listed funders supported; M4. |
| 15 | Measure P No money and named funders | Same [Almanac](https://www.almanacnews.com/election/2026/09/16/menlo-park-downtown-lot-measure-race-gathers-almost-478000-before-ballots-go-out/): ~$272K and listed funders supported; M4. |
| 16 | Caltrain FY2028 hourly weekdays, 9 p.m. finish, no weekends | [The Voice](https://thevoicesf.org/caltrain-warns-of-weekday-weekend-service-cuts-if-november-transit-fails/): supported as a conditional possible service-reduction scenario, not an adopted timetable. |
| 17 | Prop 45 California YIMBY position and rationale | [Organization's own statement](https://cayimby.org/blog/proposition-45-2026/): no recommendation and greater non-housing impact supported. |
| 18 | PPIC governor figures and fieldwork | [PPIC PDF](https://www.ppic.org/pdf/ppic-statewide-survey-californians-and-their-government-september-2026.pdf), page 3: 60/38, September 4–10 supported. |
| 19 | Prop 1 Yes/No totals | $10.4M / $0; matches widgets linked below. |
| 20 | Prop 2 Yes/No totals | $0 / $0; matches displayed series. |
| 21 | Prop 3 Yes/No totals | $47.9M / $5.5K; matches. |
| 22 | Prop 4 Yes/No totals | $0 / $0; matches displayed series. |
| 23 | Prop 5 Yes/No totals | $0 / $0; matches displayed series. |
| 24 | Prop 37 Yes/No totals | $22.6M / $0; matches. |
| 25 | Prop 38 Yes/No totals | $38.2M / $0; matches. |
| 26 | Prop 39 Yes/No totals | $28.4M / $3.93M; supplement rounds opposition to $3.9M correctly. |
| 27 | Prop 40 Yes/No totals | $32.2M / $84.8M; matches. |
| 28 | Prop 41 Yes/No totals | $58.4M / $0; matches displayed series, with M2 qualification. |
| 29 | Prop 42 Yes/No totals | $73.8M / $0; matches displayed series, with M2 qualification. |
| 30 | Prop 43 Yes/No totals | $14.9M / $4.66M; supplement rounds opposition to $4.7M correctly. |
| 31 | Prop 44 Yes/No totals | $16.9M / $37.6M; matches. |
| 32 | Prop 45 Yes/No totals | $38M / $17.1M; matches. |
| 33 | Selected proposition donors | Contributor widgets confirm CTA ~$33.3M/NEA $7M (3); Michelson $20.2M/center $13M (38); Uihlein $17M (39); SEIU approximately 98%, Building a Better California $73.5M and Larsen/Ripple $10M (40); sole listed SEIU contributor (44); Schmidt $5M and Building Trades ~$2M (45). |
| 34 | PPIC Prop 40, 41, 42, 44, 45 polling | [PPIC PDF](https://www.ppic.org/pdf/ppic-statewide-survey-californians-and-their-government-september-2026.pdf), pages 31–33: 52/46, 51/44, 54/43, 34/61, 49/46 supported. |
| 35 | Measure P housing count/affordability/gaps | [Daily Post underlying report](https://padailypost.com/2026/09/29/downtown-menlo-park-housing-proposals-will-cost-the-city-money-or-result-in-less-parking-report-says/): discrepancy I3. |
| 36 | RTM $135M / $32.5M projection | [Streetsblog](https://sf.streetsblog.org/2025/08/07/samtrans-joins-regional-measure): figures supported as an August 2025 account of a SamTrans projection, not a revalidated October 2026 allocation. Advocacy framing; primary statement preferable. |
| 37 | Measure V poll, threshold, unanimous placement | [Almanac](https://www.almanacnews.com/election/2026/08/04/san-mateo-county-college-district-asks-voters-to-extend-bond-measure-in-november/): approximately 65%, 55%, and unanimous vote supported. |
| 38 | Controller letter and reported poll numbers | Direct HTML of [Globe letter](https://californiaglobe.com/fr/assembly-republicans-demand-state-controllers-audit-records/) and [poll report](https://californiaglobe.com/fr/herb-morgan-californians-want-someone-watching-the-money/) reproduces these claims; original documents/methodology not verified, I5. |

### Direct finance evidence for checks 19–33

Fetched all 28 total widgets directly over HTTP after following the cited [CalMatters guide](https://calmatters.org/california-voter-guide-2026/) to its proposition pages and inspecting their embedded source URLs. Each row links both underlying sources; these are fundraising displays, not reviewer-recomputed filing totals.

| Prop | Direct widgets |
|---|---|
| 1 | [Yes](https://project-voter-guide-2026.interactives.calmatters.org/general/en/campaign-finance/prop/1/support/total), [No](https://project-voter-guide-2026.interactives.calmatters.org/general/en/campaign-finance/prop/1/oppose/total) |
| 2 | [Yes](https://project-voter-guide-2026.interactives.calmatters.org/general/en/campaign-finance/prop/2/support/total), [No](https://project-voter-guide-2026.interactives.calmatters.org/general/en/campaign-finance/prop/2/oppose/total) |
| 3 | [Yes](https://project-voter-guide-2026.interactives.calmatters.org/general/en/campaign-finance/prop/3/support/total), [No](https://project-voter-guide-2026.interactives.calmatters.org/general/en/campaign-finance/prop/3/oppose/total) |
| 4 | [Yes](https://project-voter-guide-2026.interactives.calmatters.org/general/en/campaign-finance/prop/4/support/total), [No](https://project-voter-guide-2026.interactives.calmatters.org/general/en/campaign-finance/prop/4/oppose/total) |
| 5 | [Yes](https://project-voter-guide-2026.interactives.calmatters.org/general/en/campaign-finance/prop/5/support/total), [No](https://project-voter-guide-2026.interactives.calmatters.org/general/en/campaign-finance/prop/5/oppose/total) |
| 37 | [Yes](https://project-voter-guide-2026.interactives.calmatters.org/general/en/campaign-finance/prop/37/support/total), [No](https://project-voter-guide-2026.interactives.calmatters.org/general/en/campaign-finance/prop/37/oppose/total) |
| 38 | [Yes](https://project-voter-guide-2026.interactives.calmatters.org/general/en/campaign-finance/prop/38/support/total), [No](https://project-voter-guide-2026.interactives.calmatters.org/general/en/campaign-finance/prop/38/oppose/total) |
| 39 | [Yes](https://project-voter-guide-2026.interactives.calmatters.org/general/en/campaign-finance/prop/39/support/total), [No](https://project-voter-guide-2026.interactives.calmatters.org/general/en/campaign-finance/prop/39/oppose/total) |
| 40 | [Yes](https://project-voter-guide-2026.interactives.calmatters.org/general/en/campaign-finance/prop/40/support/total), [No](https://project-voter-guide-2026.interactives.calmatters.org/general/en/campaign-finance/prop/40/oppose/total) |
| 41 | [Yes](https://project-voter-guide-2026.interactives.calmatters.org/general/en/campaign-finance/prop/41/support/total), [No](https://project-voter-guide-2026.interactives.calmatters.org/general/en/campaign-finance/prop/41/oppose/total) |
| 42 | [Yes](https://project-voter-guide-2026.interactives.calmatters.org/general/en/campaign-finance/prop/42/support/total), [No](https://project-voter-guide-2026.interactives.calmatters.org/general/en/campaign-finance/prop/42/oppose/total) |
| 43 | [Yes](https://project-voter-guide-2026.interactives.calmatters.org/general/en/campaign-finance/prop/43/support/total), [No](https://project-voter-guide-2026.interactives.calmatters.org/general/en/campaign-finance/prop/43/oppose/total) |
| 44 | [Yes](https://project-voter-guide-2026.interactives.calmatters.org/general/en/campaign-finance/prop/44/support/total), [No](https://project-voter-guide-2026.interactives.calmatters.org/general/en/campaign-finance/prop/44/oppose/total) |
| 45 | [Yes](https://project-voter-guide-2026.interactives.calmatters.org/general/en/campaign-finance/prop/45/support/total), [No](https://project-voter-guide-2026.interactives.calmatters.org/general/en/campaign-finance/prop/45/oppose/total) |

Selected donor checks used [3 support](https://project-voter-guide-2026.interactives.calmatters.org/general/en/campaign-finance/prop/3/support/contributors), [38 support](https://project-voter-guide-2026.interactives.calmatters.org/general/en/campaign-finance/prop/38/support/contributors), [39 support](https://project-voter-guide-2026.interactives.calmatters.org/general/en/campaign-finance/prop/39/support/contributors), [40 support](https://project-voter-guide-2026.interactives.calmatters.org/general/en/campaign-finance/prop/40/support/contributors), [40 oppose](https://project-voter-guide-2026.interactives.calmatters.org/general/en/campaign-finance/prop/40/oppose/contributors), [44 support](https://project-voter-guide-2026.interactives.calmatters.org/general/en/campaign-finance/prop/44/support/contributors), and [45 oppose](https://project-voter-guide-2026.interactives.calmatters.org/general/en/campaign-finance/prop/45/oppose/contributors).

## Neutrality and source assessment

No author-issued voting recommendation, candidate score, ranking, or weighted total appears in either target. Third-party endorsements and editorial positions are attributed research, not recommendations by the supplement. Campaign positions and the Prop 44 allegations are generally attributed. M3 identifies a useful balance correction; I2 and I3 identify factual compression that can distort a reader's assessment. Source selection and missing citations still prevent a pass even without explicit recommendations.

For this review, LAist/KPBS public-media reporting, AP syndication, the Examiner interview, Almanac/Daily Post reporting, and specialist legal reporting are Tier B. PPIC's own survey and campaign/organization statements about their own positions are Tier A for those narrow propositions. Mediaite/TheWrap were used for attributed broadcast statements, not their editorial characterizations. Hoodline's AI-assisted item is Tier C; its linked original was retrieved. Streetsblog's advocacy orientation warrants attribution and a primary-source follow-up. Advocacy statements establish the speaker's position, not independent proof of predicted policy effects.

## What was not checked

- Live official ballot certification, PDF visual layout, legal candidate eligibility, district boundaries beyond the supplied ballot's jurisdiction labels, or other ballot styles/counties. No review of candidate dossier bodies or companion packet research bodies.
- Every supplement claim, every endorsement, all newspaper editorial dates, most candidate platforms, candidate finance filings, or completeness of “none found” searches. Specific unbound examples in I1 were identified as citation defects, not all independently disproved.
- Berkeley/SurveyUSA original polls or the Silver Bulletin snapshot; remaining PPIC proposition pairs beyond those explicitly listed in check 34. The PPIC web PDF extraction worked; a separate direct HTTP attempt returned 403.
- Full court complaint, full paywalled Daily Journal article, or adjudication of the Prop 44 allegations. The precise offer-to-drop detail remains only partially checked. No search-result aggregator was treated as conclusive evidence for it.
- Original controller poll methodology, Assembly letter, full O'Keefe video, or the inaccessible SJV Sun report. The LWV Measure P PDF did not load.
- Reconciliation of all campaign transactions, duplicates/transfers, shared committees, independent expenditures, or later updates. Finance checks verify the cited publisher's displayed series; they do not establish a complete statewide accounting as of October 4.
- Whether the 2025 transit funding projection matches the final 2026 enacted allocation. Caltrain's scenario was verified against its cited news report, not original agency board materials.

## Write verification

Only this report and the four authorized review fields in A and B were written. No body text, issue files, lessons, source inputs, or candidate dossiers were edited; no git commit was made. Existing unrelated working-tree changes were left alone. Pre-write body SHA-256 values, used for post-write comparison:

- A: `7f530f01d7af0717699bac3b7b4f8da4baa97b9542ec849efc8c91fb8728c856`
- B: `22b6d9bb68747f6d74f143e7b1db00d1f0acfa847abd5ffebb55cde41f1a38bc`

Before the metadata write, the hash guard detected a concurrent external change to A: its PDF source link became the supplied ballot-text link. Reversing exactly that substitution reproduced the initial body hash `9f123643bf89ea3da8c6773f7857dfa33319190fd81d918266f9e0243b5cbe7d`, establishing that no contest content changed. The updated link was rechecked and preserved; the A hash above is the final reviewed body. The reviewer did not make that body edit.

## Re-review (round 2) — 2026-10-04

**Verdict: needs-work. Remaining: 0 Critical, 2 Important (I1, I5), 3 Minor (M2 remainder and two fix-related observations below).** This section supersedes the original disposition for supplement B; the original report and its counts remain the round-1 record. Manifest A was not re-reviewed. Scope was the nine findings and regressions in their fixes, with a read-only fresh-eyes check. Locations below refer to the current supplement, including its review metadata.

### Disposition of every original finding

| Finding | Round-2 disposition | Verification |
|---|---|---|
| I1 | **Partly fixed; Important remains** | Governor and insurance policy bindings checked successfully; several local bindings also work. Remaining unsupported/binding failures are enumerated below. |
| I2 | **Closed** | Line 101 now distinguishes the March 2024 projected deficit and layoff notices from completed cuts. The [10News article](https://www.10news.com/news/local-news/san-diego-unified-school-district-approves-job-cuts-to-close-94m-deficit) confirms the substance; direct HTML metadata gives March 6, 2024. |
| I3 | **Closed** | Line 172 matches the [September 29 Daily Post report](https://padailypost.com/2026/09/29/downtown-menlo-park-housing-proposals-will-cost-the-city-money-or-result-in-less-parking-report-says/): three proposals, 345/347/500 apartments, different affordability mixes, and respective gaps of $20M/$45M/$19.2M. The universal very-low-income characterization is gone. |
| I4 | **Closed** | Lines 53–54 remove the unverified numerical entries and explicitly mark the gap. [PPIC page 3](https://www.ppic.org/pdf/ppic-statewide-survey-californians-and-their-government-september-2026.pdf) confirms September 4–10 fieldwork and 60/38. |
| I5 | **Partly fixed; Important remains** | Resignation/video claim is explicitly unverified; letter is linked and retrieved; polling dates and initial-ballot distinction are repaired. The poll still lacks the required primary binding and details in the supplement. See the usable memo and exact fix below. |
| M1 | **Closed** | Line 25 now says May 3, reported May 4, and repeatedly declined. [Mediaite](https://www.mediaite.com/media/tv/ms-now-hosts-throw-down-with-steve-hilton-after-he-refuses-to-say-who-won-2020-election-why-cant-you-answer-the-question/) reports the Sunday interview in its Monday article. |
| M2 | **Substance fixed; Minor link remainder** | Line 131 adds the September 28 data date, October 4 access date, and shared-committee/outside-spending qualification; all former zero/none money cells now say $0 displayed. Direct retrieval of the [data note](https://project-voter-guide-2026.interactives.calmatters.org/general/en/campaign-finance/note?isProp=true) confirms September 28. Individual proposition/widget links requested in round 1 are still missing. |
| M3 | **Closed against the round-1 evidence** | Line 155 adds the denial, narrows the allegation to pressure for organizing concessions, and preserves allegations-not-findings. This implements the precise correction grounded in the original [Daily Journal check](https://dailyjournal.com/article/394505-healthcare-clinics-accuse-seiu-uhw-of-racketeering-over-proposition-44). Round-2 browser extraction did not expose the relevant article text and direct retrieval returned 403; this is not a claim of renewed independent verification. The separate uncited party-position sentence remains under I1. |
| M4 | **Closed** | Lines 173–174 correctly date and characterize the totals and qualify MidPen. The [September 16 Almanac report](https://www.almanacnews.com/election/2026/09/16/menlo-park-downtown-lot-measure-race-gathers-almost-478000-before-ballots-go-out/) confirms loans, nonmonetary support, and the future filing. |

### I1 — remaining exact fixes

The new [CalMatters governor guide](https://calmatters.org/california-voter-guide-2026/governor/) bindings at lines 33, 38–41, 43, 46–47 support the attributed relationship, tax, energy, homelessness and housing claims, including Becerra's 40,000-unit proposal. The two candidates' statements are correctly assigned. Unsupported specifics were demoted rather than retained as conclusions.

The [Insurance Business article](https://www.insurancebusinessmag.com/us/news/breaking-news/jane-kims-plan-to-remake-california-insurance-draws-fire-as-fair-plan-increase-nears-591074.aspx) supports Kim's three policy proposals and Allen's ABC7 criticism at lines 124–125. The [July 17 Insurance Journal article](https://www.insurancejournal.com/news/west/2026/07/17/877855.htm) is credited Bloomberg reporting and supports Allen's mitigation emphasis and his $50,000–$60,000 estimate. For these narrow reported-policy claims, these are acceptable specialized Tier-B evidence; industry commentary is not adopted as fact.

The [2023 Almanac article](https://www.almanacnews.com/news/2023/08/18/local-elected-officials-unite-in-opposition-to-huge-builders-remedy-project-in-menlo-park/) supports Combs's vote rationale and height-limit statement. Direct retrieval of the [May 2026 article](https://www.almanacnews.com/menlo-park/2026/05/14/finance-commissioner-challenges-combs-for-menlo-park-city-council-seat/) supports Velagapudi's downtown-housing and budget statements. The [forum announcement](https://www.almanacnews.com/election/2026/09/28/the-almanac-to-host-menlo-park-city-council-candidate-forum-on-oct-8/) supports October 8; the absence of endorsements remains a bounded search result, not proof none exist.

Remaining fixes within the original claim-binding finding:

- **Line 107:** bind Johnson's voting-platform/reason-for-running bullet to its verified source explicitly; the next bullet's Trump citation does not bind this separate assertion.
- **Line 127:** bind the FAIR Plan increase/date directly to the Insurance Business article above, which does support it.
- **Lines 155–156:** add verified per-claim links for the Democratic Party's Prop 44 opposition, GrowSF's Prop 45 support, and the State Building Trades/California Labor Federation/Sierra Club opposition. The lawsuit and California YIMBY citations do not establish those separate positions.
- **Line 175 and lines 180–181:** bind LWV's Measure P and RTM positions, the SamTrans 8–1 vote, and the opposition committee's sponsorship to verified sources. Nearby money, editorial and critics' links are not bindings for these claims.
- **Line 185:** the newly added [August 1 Almanac report, updated August 4](https://www.almanacnews.com/crime/2026/08/01/ex-san-mateo-county-college-chancellor-gets-jail-for-perjury-tax-fraud/) establishes the July 31 eight-month sentence, but its retrieved article contains no appeal statement. Add a dated source establishing an appeal, or remove “and is appealing” and mark appeal status as DATA-GAP. The article's account of a denied new-trial motion is not evidence of an appeal.

For any claim above that cannot be verified, replace the assertion with an explicit dated DATA-GAP rather than leaving it asserted beside an unrelated citation. These are residuals of I1, not a new full audit.

### I5 — primary polling evidence is now available, but not bound in the supplement

**Line 68:** attribution to the Globe plus an unverified-methodology disclaimer does not complete the original fix. The article links an accessible [David Wolfson polling memorandum](https://californiaglobe.com/wp-content/uploads/2026/09/CA.Controller.PollingMemo.pdf). It confirms the initial ballot figures, September 15–16 fieldwork, 828 likely November voters, and MMS text-to-web collection using registration-based sampling, vote history and turnout modeling. It reports a ±4-point margin of error. A commissioning sponsor is not identified in the retrieved memo.

**Exact fix:** bind the figures directly to that memo and identify pollster, sample, fieldwork and method; retain the September 24 secondary-report date separately. Say the commissioning sponsor is not identified in the memo rather than implying that “Republican-released” identifies the sponsor. If retaining the Globe reference, explicitly label its conservative framing. Describe these as the memo's reported results, not independently validated population estimates. Alternatively remove the numbers and use the originally requested explicit DATA-GAP. The primary memo closes the uncertainty about whether these numbers and methods were documented; the supplement still needs to carry that evidence.

The resignation/video DATA-GAP at line 62 is acceptable. The [linked letter PDF](https://californiaglobe.com/wp-content/uploads/2026/09/State-Controller-Letter.pdf) was retrieved directly as a PDF and extracted with `pdftotext`; it supports the audit-record request, so that source-quality component is closed. Its date creates the minor correction below.

### Remaining Minor items

1. **M2, lines 135–150:** link each proposition number to its CalMatters proposition guide or the individual finance widgets (the original report's widget ledger provides the paths). The generic guide and data note establish provenance/date but do not supply the requested row-level navigation. No money-total contradiction was identified in this round.
2. **I5 fix-related date, line 67:** the linked letter is dated **September 14, 2026**; September 15 is the Globe article date. Replace the opening with “Letter dated September 14, reported September 15” unless an independent source establishes the sending date. The current “Sept 15 … sent” is not established by the linked evidence.
3. **I1 fix-related over-demotion, line 125:** the Insurance Business source explicitly reports Kim's proposed 65–75-cent minimum payout per premium dollar. The claim that this specific range has not been verified against Tier-A/B evidence is therefore stale under the source treatment used for the adjacent policy bullets. Attribute the range to Kim and bind it to the same article, or explain a specific source-quality limitation that also applies to that article's other claims. This does not reinstate Allen's separately unverified detailed proposals.

### Write-surface verification

Only this dated section was appended to the report. The supplement's existing `review: needs-work`, `reviewed-by: codex`, `reviewed-on: 2026-10-04`, and report reference remain the correct metadata; no value change was needed. Its body was preserved byte-for-byte. No commit was made. Process lesson recorded here within the authorized surface: check each added source against every clause, and separate document dates from article dates; adding a URL alone does not close a finding.


## Re-review (round 3) — 2026-10-04

**Verdict: passed. Remaining within the round-2 findings and their fixes: 0 Critical, 0 Important, 0 Minor.** This section supersedes the round-2 disposition for supplement B. Earlier sections and report-frontmatter counts remain the historical record. Manifest A and unrelated supplement claims were not re-audited. Review included direct source retrieval and a separate read-only fresh-context check of the fixes, demotions, and proposition-link mapping.

### Disposition of round-2 residuals

| Round-2 item | Round-3 verification | Disposition |
|---|---|---|
| I1 — Johnson voting platform/reason for running | The bullet now carries its own [SM Daily Journal citation](https://www.smdailyjournal.com/news/local/marc-berman-defends-district-23-assembly-seat-against-republican-challengers/article_167f1bcb-a7fb-40af-9251-43468214cc09.html). Retrieved reporting supports Johnson's voting position and identifies permanent vote-by-mail legislation as part of the challengers' motivation. | Closed |
| I1 — FAIR Plan | The context sentence directly links [Insurance Business](https://www.insurancebusinessmag.com/us/news/breaking-news/jane-kims-plan-to-remake-california-insurance-draws-fire-as-fair-plan-increase-nears-591074.aspx), whose text confirms the average 29.1% increase and October 15 effective date. | Closed |
| I1 — Prop 44/45 positions | Democratic Party opposition to Prop 44 and GrowSF/Labor Federation/Sierra Club positions on Prop 45 are explicitly dated DATA-GAPs. Building Trades opposition and Hannan's CEQA criticism are supported by his [America's Work Force interview account](https://awf.labortools.com/listen/california-building-trades-on-proposition-45-and-the-fight-to-stop-it), used as evidence of his stated position, not independent validation of his policy criticism. | Closed |
| I1 — LWV and transit claims | The [LWV page](https://my.lwv.org/california/south-san-mateo-county/vote-league-0) explicitly recommends No on Measure P and Yes on the Regional Transit Measure. Both supplement claims link it. SamTrans's 8–1 vote is now an explicit dated DATA-GAP. The committee's sponsorship is attributed to its [own site's disclosure](https://nonewtransittax.com/), which names the Contra Costa Taxpayers Association. | Closed |
| I1 — Galatolo appeal | The affirmative appeal assertion is removed; appeal status is explicitly unverified in a dated DATA-GAP. The conviction and sentence claims are not expanded by the fix. | Closed |
| I5 — Controller poll | The figures now bind directly to the [Wolfson memo](https://californiaglobe.com/wp-content/uploads/2026/09/CA.Controller.PollingMemo.pdf). Direct download and `pdftotext` confirm Cohen 49.5/Morgan 41.2 on the initial ballot, David Wolfson, 828 likely November voters, September 15–16 fieldwork, MMS text-to-web, registration-based sampling and turnout modeling, and the reported ±4-point margin. The memo does not identify a commissioning sponsor. The supplement explicitly limits the claim to the memo's reported results; its conservative-leaning Globe citation separately carries the correct September 24 report date. | Closed |
| Minor — Controller letter date | Direct extraction of the [letter PDF](https://californiaglobe.com/wp-content/uploads/2026/09/State-Controller-Letter.pdf) confirms September 14; the [Globe article](https://californiaglobe.com/?p=95421) is dated September 15. The revised wording separates them without inferring a sending date. | Closed |
| Minor — Kim range | The proposed 65–75-cent minimum payout is restored, attributed to Kim, and bound to the same Insurance Business article, which explicitly reports the range. Allen's separately unverified proposals remain a DATA-GAP. | Closed |
| M2 — proposition navigation | All 14 proposition numbers (1–5, 37–45) now link to their matching CalMatters `/prop/N/support/total` widgets. Every URL matches the original report's source ledger and returned HTTP 200 on direct retrieval. The instruction for switching to the opposition widget is correct. This verifies the requested navigation fix, not a new audit of unchanged totals. | Closed |

### Regression and write-surface checks

No fix-induced contradiction or reassertion of the demoted claims was found elsewhere in the supplement. The dated DATA-GAPs resolve the review findings by identifying uncertainty; they do not verify the underlying claims. The restored policy range and polling detail remain attributed, and partisan source framing is explicit. This preserves the evidence/uncertainty distinction emphasized by ARCH-ORDER.

Only this round-3 section was appended to the report, and only `review: needs-work` was changed to `review: passed` in the supplement's review frontmatter. Existing reviewer, date, and report reference remain correct. Byte comparisons verified that the supplement body and all prior report bytes were preserved. No body edits, unrelated file edits, or commit were made.
