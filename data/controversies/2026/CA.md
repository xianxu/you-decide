---
year: 2026
state: CA
sub-jurisdictions: [San-Mateo, Santa-Clara]
generated: 2026-05-28
last-verified: 2026-05-29
refreshed-on: 2026-05-29
source-elections: [2026-06-02-CA-primary]
# Input-set fingerprint (fan-in membership check, per atlas/substrate-dependencies.md
# Rule 2): refresh when the live `data/candidates/2026/CA/**` glob differs from this list.
input-profiles: 39
sources:
  - data/candidates/2026/CA/governor/*.md (8)
  - data/candidates/2026/CA/San-Mateo/assessor-clerk-recorder/*.md (3)
  - data/candidates/2026/CA/San-Mateo/county-controller/*.md (2)
  - data/candidates/2026/CA/San-Mateo/county-superintendent-schools/*.md (2)
  - data/candidates/2026/CA/San-Mateo/supervisor-d3/*.md (2)
  - data/candidates/2026/CA/assembly-d21/*.md (2)
  - data/candidates/2026/CA/assembly-d23/*.md (3)
  - data/candidates/2026/CA/boe-d2/*.md (3)
  - data/candidates/2026/CA/supt-public-instruction/*.md (3)
  - data/candidates/2026/CA/us-house-d15/*.md (5)
  - data/candidates/2026/CA/us-house-d16/*.md (4)
  - data/candidates/2026/CA/Santa-Clara/district-attorney/*.md (2)
  - https://calmatters.org/california-voter-guide-2026/
  - https://www.kqed.org/voterguide/california
generated-by: claude
generated-on: 2026-05-28
review: passed
reviewed-by: codex
reviewed-on: 2026-05-29
review-ref: data/reviews/2026/2026-05-29-ca-2026-post-close-rereview.md
---

# Controversies — California 2026 cycle

Derived from the candidate profiles in `data/candidates/2026/CA/` (39 files; the `input-profiles`/`sources` frontmatter records the exact set so the fan-in membership check in [[substrate-dependencies]] can detect drift). Originally drafted against 30; **refreshed 2026-05-29** to fold in the 9 then-unmapped profiles (assembly-d23 ×3, us-house-d16 ×4, Santa-Clara/district-attorney ×2) — that delta awaits cross-stack re-review (`review: in-progress`). Each entry surfaces a dimension where candidates substantively disagree AND there's visible public debate. Survey-ready stances are drafted for downstream use by `[[bootstrap-survey]]` (M3).

## High-salience (driving multiple races + visible in media coverage)

### 1. Housing — CEQA reform vs incrementalism
- Tier / axis: Tier 4 — housing-zoning-realism
- **Pro-reform**: Villaraigosa (CEQA explicit reformer), Hilton (anti-CEQA-abuse), Mahan (regulatory streamlining), Berman (AD-23 incumbent — serial CEQA-infill-exemption author AB 1804/AB 2199/AB 782, CA YIMBY + YIMBY Action endorsed), Liccardo (CA-16 incumbent — housing-flagship mayoral record, motel conversions, five bipartisan housing bills)
- **Process-technocratic / incrementalist**: Papan (AB 2296 streamlines review timelines, doesn't reform zoning), Becerra (no clear stance)
- **Reform-skeptic / spend-and-build**: Steyer, Thurmond (default to government-funded construction, not zoning reform)
- Races affected: governor, state-assembly, US-house, SM-supervisor (county unincorporated-area zoning)
- Survey-ready stance: *"California should speed up housing construction by limiting environmental-review (CEQA) lawsuits, even at the cost of fewer environmental challenges to projects."*

### 2. Energy cost vs climate spending
- Tier / axis: Tier 4 — energy-cost-not-just-green
- **Cost-focused / climate-adapt**: Hilton (*"$3/gallon gas, electric bills cut in half"*), Villaraigosa (*"all-of-the-above"*), Soule (CA-16 R — increase oil drilling + refinery construction to lower energy costs)
- **Climate-spend-focused**: Steyer (NextGen pedigree, big climate spend, opposes CARB rollback), Berman (AD-23 — AB 1346 small-off-road-engine ban, a cost-imposing climate regulation), Liccardo (CA-16 — San José Clean Energy, 95% renewable)
- **Status quo / unclear**: Becerra, Porter, Mahan
- Races affected: governor, state-assembly, US-house
- Survey-ready stance: *"I want lower energy prices for California families even if that means slowing the state's climate-policy ambitions."*

### 3. Public-safety enforcement — strict rules vs decarceral
- Tier / axis: Tier 4 — public-safety-strict-but-care
- **Strict-rules**: Mahan (supported Prop 36; chronic-homeless responsibility-to-shelter → arrest), Bianco (sheriff career), Mueller (oversaw Sheriff Corpus removal under pressure), Chung (SCC-DA challenger — "eliminate the revolving door", vertical prosecution, backed Prop 36)
- **Strict-but-care / prosecute-plus-diversion**: Liccardo (CA-16 — rebuilt SJPD +200 officers, lowest big-city homicide rate, paired with diversion), Rosen (SCC-DA incumbent — "triangle": vigorous violent-crime prosecution + mental-health diversion + ethics)
- **Decarceral-leaning**: Steyer (abolish-ICE, prosecute ICE agents), Lara (cops-out-of-schools / defund-adjacent), Berman (AD-23 — vocally opposed Prop 36 against ~70% statewide support)
- **Middle**: Becerra (HHS-era enforcement record), Papan (no Prop 36 position found)
- Races affected: governor, SM-supervisor (sheriff oversight), SCC-district-attorney, assembly, US-house
- Survey-ready stance: *"Chronic-homeless individuals who refuse three shelter offers should face arrest for trespassing, provided mental-health treatment is part of the enforcement package."*

### 4. Trump alignment — cater-mode vs personalist conviction
- Tier / axis: Tier 1 — anti-personalist-strongman + [[trump-era-cater-discount]] calibration
- **Personalist-aligned**: Bianco (ballot-seizure attempt, Oath Keepers membership confirmed and "proud" on debate stage), Hilton (Trump endorsement + on-air refusal to confirm Biden won during the 2026 campaign — May 4 Mediaite)
- **Cater-mode plausible / under-evaluated**: (the calibration skill exists precisely to disambiguate these — many GOP candidates land here)
- **Trump-tolerating-but-not-aligned**: Mattammal (ran R in 2022/2024 with no MAGA signals; no 2020-fraud claims), Muhawieh (conditional Trump voter, willing to challenge Trump on First Amendment), K. Johnson (CA-16 R — voted Trump but "uninterested in acquiescing", judges by policy not personality)
- Races affected: governor, state-supt-instruction, assembly, US-house
- Survey-ready stance — TWO opposing framings:
  - *"Republican candidates who echo 2020 election-fraud claims are doing so for political survival in the Trump-era GOP, not because they actually believe them — I can tolerate that and judge them on policy."*
  - *"Republican candidates who echo 2020 election-fraud claims are personally complicit in undermining democracy regardless of motivation, and I will not vote for them."*

### 5. Election integrity — institutional norms under real pressure
- Tier / axis: Tier 2 — institutionalist (with action-tier extension to −4 per [[trump-era-cater-discount]])
- **Norm-violating action**: Bianco (650K-ballot-seizure attempt halted by CA Supreme Court; Oath Keepers)
- **Norm-violating rhetoric**: Hilton (promote-tier 2020-fraud)
- **Norm-defending / pro-access institutionalist**: Mueller (held the Corpus-removal vote despite lawsuits and political attack), Irizarry (13+ years SM election admin, 35 elections, no violations), Berman (AD-23 — wrote CA's permanent vote-by-mail law + Office of Elections Cybersecurity, authored deepfake laws AB 730/AB 2655, chairs Assembly Elections)
- **Restriction-leaning rhetoric**: D.G. Johnson (AD-23 R — advocates "one-day, in-person voting, targeting fraud" — access-narrowing framing, no documented norm violation)
- Races affected: governor, SM-supervisor, SM-assessor/clerk-recorder/elections, assembly
- Survey-ready stance: *"A candidate who has actively interfered with election machinery (ballot seizure, voter-roll purges beyond procedure) should be disqualified from my vote regardless of their other positions."*

### 6. Billionaire self-funding in politics
- Tier / axis: anti-hypocrisy + capture-risk
- **Mega self-funder**: Steyer ($147M+ as of April 2026 — ~100% personal funds; exceeds Newsom 2021 recall total)
- **Tech-billionaire-donor-concentration**: Mahan (Brin, Lonsdale, Moritz, Hastings dominate)
- **Donor-funded normal-scale**: Becerra ($1M), Porter ($2.8M), Villaraigosa ($707K)
- Races affected: governor (primarily)
- Survey-ready stance — TWO framings:
  - *"A candidate who self-funds with personal wealth has fewer accountability problems than one beholden to wealthy donors."*
  - *"A self-funded billionaire candidate is itself a problem — concentrated wealth + political power is the failure mode regardless of donor independence."*

### 7. Charter schools vs teacher-union alignment
- Tier / axis: Tier 4 — education-investment + school-choice sub-dimension
- **Pro-charter / school-choice**: Villaraigosa (LA-era school reform record), Hilton (school choice + parental rights; Romero LG pick), Mattammal (school-choice-friendly platform)
- **Union-aligned / anti-charter**: Thurmond (defeated charter-backed Tuck in 2018; though notably CTA went Steyer in 2026, not Thurmond), Lara (UESF EVP, full union framing)
- Races affected: governor, state-supt-instruction, county-supt-schools (Camacho equity-ED vs Bonini certificate-only)
- Survey-ready stance: *"California should expand charter-school capacity and parental school choice rather than further increase per-pupil funding to existing district schools."*

### 8. Wealth / billionaire tax mechanism
- Tier / axis: Tier 3 — anti-tax-spend / fiscal-conservative
- **Billionaire asset tax**: Thurmond (one-time 5% on net-worth >$1B; broader asset tax on >$150M)
- **Split-roll commercial property tax**: Steyer (2027 ballot framing) — note: Steyer does NOT back the union-led wealth-tax ballot initiative; Thurmond does
- **Anti-tax-increase**: Hilton (flat tax, Prop 13 pledge), Mahan (explicitly opposes billionaire tax)
- Races affected: governor, state-supt-instruction
- Survey-ready stance: *"Taxing California's ~200 billionaires at 5% one-time to fund services I value is fair and worth doing."*

## Medium-salience

### 9. Single-payer healthcare
- **Newly pro**: Steyer (flipped Dec 2025 — *"Bernie Sanders was right"*)
- **Long-pro**: Thurmond (cites personal loss — brother's lost-job/insurance/illness cascade)
- **Status quo / unclear**: most others
- Races affected: governor, state-supt-instruction, US-house (federally — Medicare-for-All variants)
- Survey-ready stance: *"California should establish state-level single-payer healthcare even if it requires significant new taxation."*

### 10. Immigration enforcement at the state-county boundary
- **Strict / anti-sanctuary**: Bianco (sheriff anti-sanctuary), Hilton ("Obama-era enforcement as model"), Soule (CA-16 R — withhold federal funds from sanctuary cities shielding undocumented criminals)
- **Abolish / prosecute-ICE**: Steyer (formal abolish-ICE + criminally prosecute ICE agents platform — April 2026)
- **Humane-on-residence / reform-pathway**: Jiménez (farmworker-defense advocacy), most moderate Dems
- **Standard Dem**: Mullin, Papan
- Races affected: governor, SM-supervisor (county sheriff cooperation), assembly, US-house
- Survey-ready stance — TWO framings:
  - *"California should fully cooperate with federal immigration enforcement, even when ICE targets long-term residents."*
  - *"California should refuse ICE cooperation and fund state-level immigration legal defense, even if it means open conflict with federal authorities."*

### 11. Israel / Gaza framing as idealist-vs-pragmatist tell
- Tier / axis: Tier 4 (foreign policy at federal level) + Tier 1 (character signal)
- **Genocide framing / arms embargo**: Van Dang (calls Gaza genocide, supports embargo + ceasefire), Kumar (Gaza-genocide framing)
- **Muddled / position-dependent**: Mullin (Yea on symbolic ceasefire votes, Nay on $17.6B aid, abstained on IHRA; verbal call but didn't sign letter)
- **Aid-first / liberal-critical (not genocide framing)**: Liccardo (CA-16 — co-signed H.Res.473 urging Gaza humanitarian aid, "very serious concerns about how the war has been conducted", criticized US military support; J Street PAC backing)
- **Pro-Israel-standard**: not yet surfaced explicitly in profiled candidates
- Races affected: US-house (federal)
- Survey-ready stance: *"A candidate calling Israel's military actions in Gaza a 'genocide' shows the moral seriousness I want; one who calls it 'self-defense' or stays vague is showing pragmatic flexibility I distrust."* (note: this is the idealist-vs-pragmatist proxy per philosophy framing)

## Low-salience / niche

### 12. AI regulation — state role vs deregulation vs federal preemption
- **Pro-state-regulation**: Berman (AD-23 — supports state AI regulation citing CA's leadership role), Mahan (tax AI companies to fund workforce development; cellphone-ban-in-schools)
- **Anti-state-regulation / deregulation**: D.G. Johnson (AD-23 R — *"I really don't want the state to regulate it"*), Giorgetti (AD-23 R — no state role; misuse *"should be prosecuted through the criminal justice system"*)
- **Federal-preemption framing**: Liccardo (CA-16 — "conditional preemption": a federal floor that preserves state innovation; at the center of the national who-regulates-AI fight)
- **Vague**: Steyer ("AI advances benefit all Californians equitably" — no specifics)
- Races affected: governor, assembly, US-house
- (Promoted from niche → contested this refresh: the AD-23 and CA-16 races surface a real state-role-vs-deregulation-vs-preemption split. Survey-relevant where AI policy matters to the user.)

### 13. Crypto / blockchain state-level policy
- No major California candidate has surfaced as a crypto-policy advocate or opponent
- *Confirms philosophy expectation: crypto is irrelevant at state level*

### 14. Public-school cellphone / social-media policy
- **Active proposer**: Mahan (ban cellphones K-12, parental consent for under-16 social media)
- **Aligned but quieter**: Mattammal, Hilton (parental-rights framing)
- **No position**: others
- (Medium-private interest but not a major race-deciding axis)

## Race-specific (single-race, high-intensity)

### 15. Prosecutorial independence & office ethics (Santa Clara County DA)
- Tier / axis: Tier 2 — institutionalist + Tier 1 — character/integrity signal
- **Incumbent under scrutiny**: Rosen — a judge ordered his recusal and declared a mistrial after he used an active prosecution (Stanford pro-Palestinian protesters) as a campaign fundraiser, reframing it as "fighting antisemitism" in donor emails. [(KQED — Rosen barred from retrying Stanford protesters)](https://www.kqed.org/news/12082713/santa-clara-county-da-barred-from-retrying-pro-palestinan-stanford-protesters) Secondary office-conduct items: a reinstatement creating a ~$314K paid-leave liability [(Palo Alto Daily Post — DA sued for paying prosecutor not to work)](https://padailypost.com/2026/04/13/da-sued-for-paying-prosecutor-not-to-work/) and his "triangle" reform branding.
- **Challenger framing**: Chung — alleges systemic Brady-disclosure / officer-credibility failures (candidate allegation, not adjudicated) and proposes a conviction-integrity review. [(Davis Vanguard — prosecutorial misconduct / police accountability)](https://davisvanguard.org/2026/05/prosecutorial-misconduct-police-accountability/)
- Races affected: Santa-Clara district-attorney (only)
- Survey-ready stance: *"A district attorney who used an active criminal prosecution as a campaign fundraising vehicle has shown a disqualifying lapse of prosecutorial independence, regardless of their record on crime."*
- Note: distinct from #3 (both DA candidates are *strict-prosecution*; they don't diverge on enforcement posture — they diverge on office ethics and independence).

## How to use this map

- **For bootstrap survey design (M3)**: take 6-10 stances from High-salience, 2-3 from Medium. Avoid Low (low signal, wastes survey budget).
- **For per-race reads**: when scoring a candidate against the philosophy, check which controversies their race involves — focuses the scoring on actually-contested axes vs neutral ones.
- **For voter conversation**: when surfacing per-race recommendations, lead with the dominant controversy for that race ("this race turns on housing — here's where each candidate sits").

## Sources

- Candidate profiles in `data/candidates/2026/CA/` (39 files; set enumerated in frontmatter `sources:`, refreshed 2026-05-29; derived from Tier A/B sources per the source-hygiene calibration skill)
- CalMatters 2026 voter guide
- KQED CA + SM voter guides (incl. SCC-DA Stanford-protester recusal coverage)
- LA Times polling and candidate coverage
- AP race-update coverage
- SM Daily Journal local race coverage (incl. AD-23 and CA-16 challenger candidate forums)
- Palo Alto Daily Post (county Supt of Schools credentials issue; SCC-DA paid-leave suit)
- Davis Vanguard (SCC-DA prosecutorial-accountability coverage)
