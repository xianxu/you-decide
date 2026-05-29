---
date: 2026-06-02
type: primary
state: CA
slug: 2026-06-02-CA-primary
generated: 2026-05-28
last-verified: 2026-05-28
coverage: SM County voter ballot (other CA counties' US House + Assembly slices pending)
sources:
  - https://www.sos.ca.gov/elections
  - https://smcacre.gov/elections/county-offices
  - https://calmatters.org/california-voter-guide-2026/
  - https://www.kqed.org/voterguide/sanmateo
  - https://www.kqed.org/voterguide/california
  - https://www.smdailyjournal.com/news/local/roster-for-san-mateo-county-s-june-ballot-closed/article_040038b2-2cb3-42ba-af1f-5244e07f47f8.html
generated-by: claude
generated-on: 2026-05-28
review: issues-flagged
reviewed-by: codex
reviewed-on: 2026-05-28
review-ref: reviews/2026/2026-05-28-ca-2026-shared-substrate-r2.md
review-note: re-opened 2026-05-29 — edited after pass to mark Freeman + Morgan as not-qualified (absent from final May 4 roster); pending re-review
---

# California Primary — June 2, 2026

Decision-support manifest of races on the **San Mateo County** voter's 6/2/2026 ballot (the original development target). The voter's actual ballot is a filtered slice based on their resolved districts (see [[resolve-ballot]] for the filter algorithm). Each race below carries a `District:` tag — the voter sees the race iff their resolved districts include that tag.

**Scope & completeness — read before trusting this for ballot truth.** This is *not* the certified candidate roster; two deliberate filters apply:

- **Coverage is San-Mateo-oriented.** Statewide races appear, but several statewide offices on the certified ballot are **not yet enumerated here**: Lieutenant Governor, Secretary of State, Controller, Treasurer, Attorney General, Insurance Commissioner. Other counties' US-House / Assembly slices are also pending.
- **Candidate lists are viability-filtered, not certified-complete.** Where a race lists fewer names than the CA SoS certified list (e.g. Superintendent of Public Instruction, Board of Equalization D2), the omitted names are low-viability filings dropped for decision-support — they still appear on the physical ballot.

For ballot truth, cross-check the [CA SoS certified candidate list](https://www.sos.ca.gov/elections) and the [SM County roster](https://smcacre.gov/elections/county-offices). Closing both gaps (full statewide enumeration + certified candidate lists) is a tracked research follow-up.

## Statewide races
*Tag: STATEWIDE — visible to every CA voter.*

### Governor
- Seats: 1 (top-2 advances to general)
- District: STATEWIDE
- CONTESTED — 8 viability-filtered candidates (certified field is larger; see Scope & completeness):
  - Xavier Becerra (D) [[xavier-becerra]]
  - Katie Porter (D) [[katie-porter]]
  - Tom Steyer (D) [[tom-steyer]]
  - Antonio Villaraigosa (D) [[antonio-villaraigosa]]
  - Tony Thurmond (D) [[tony-thurmond]]
  - Matt Mahan (D) [[matt-mahan]]
  - Steve Hilton (R) [[steve-hilton]]
  - Chad Bianco (R) [[chad-bianco]]

### Superintendent of Public Instruction (nonpartisan)
- Seats: 1 (top-2 advances)
- District: STATEWIDE
- CONTESTED (viability-filtered subset; CA SoS certifies more — see Scope & completeness):
  - Frank Lara [[frank-lara]]
  - Gus Mattammal [[gus-mattammal]]
  - William L. McGee [[william-mcgee]]

### Board of Equalization, District 2
- Seats: 1 (top-2 advances)
- District: CA-BOE-D2 (covers Bay Area counties)
- CONTESTED (viability-filtered subset; CA SoS certifies more — see Scope & completeness):
  - Sally Lieber (D, incumbent) [[sally-lieber]]
  - John Pimentel [[john-pimentel]]
  - William Shireman [[william-shireman]]

## Federal — US House

### US House, District 15
- Seats: 1 (top-2 advances)
- District: US-House-D15 (most of San Mateo County including Menlo Park)
- CONTESTED:
  - Kevin Mullin (D, incumbent) [[kevin-mullin]]
  - Mantosh Kumar (D) [[mantosh-kumar]]
  - Anthony Van Dang (D) [[anthony-van-dang]]
  - Charles Hoelter (R) [[charles-hoelter]]
  - James B. Garrity (NPP) [[james-garrity]]

### US House, District 16
- Seats: 1 (top-2 advances)
- District: US-House-D16 (southern SM County + parts of Santa Clara)
- CONTESTED:
  - Sam Liccardo (D, incumbent) [[sam-liccardo]]
  - Kevin Johnson (R) [[kevin-johnson]]
  - Peter Sundin Soulé (R) [[peter-soule]]
  - Jotham Stein (NPP) [[jotham-stein]]

## State Legislative

### State Assembly, District 21
- Seats: 1 (top-2 advances)
- District: CA-Assembly-D21 (most of SM County including northern Menlo Park; ZIP 94025 primarily here)
- CONTESTED:
  - Diane Papan (D, incumbent) [[diane-papan]]
  - Jabra J. Muhawieh (R) [[jabra-muhawieh]]

### State Assembly, District 23
- Seats: 1 (top-2 advances)
- District: CA-Assembly-D23 (parts of SM County + Santa Clara)
- CONTESTED:
  - Marc Berman (D, incumbent) [[marc-berman]]
  - Rick Giorgetti (R) [[rick-giorgetti]]
  - David G. Johnson (R) [[david-johnson]]

## San Mateo County

### County Superintendent of Schools (nonpartisan)
- Seats: 1
- District: SM-COUNTY
- CONTESTED:
  - Chelsea Bonini [[chelsea-bonini]]
  - Héctor Camacho Jr [[hector-camacho-jr]]

### Assessor / County Clerk-Recorder / Chief Elections Officer (nonpartisan)
- Seats: 1
- District: SM-COUNTY
- CONTESTED:
  - David Canepa [[david-canepa]]
  - Jim Irizarry [[jim-irizarry]]
  - *Clinton Eric Freeman [[clinton-freeman]] — DID NOT QUALIFY: "Pending" on the March 11 roster, absent from the final [May 4, 2026 qualified roster](https://smcacre.gov/system/files/2026-05/51_candidateroster05042026.pdf). Not on the ballot.*

### County Controller (nonpartisan)
- Seats: 1
- District: SM-COUNTY
- **UNCONTESTED** (only one qualified candidate):
  - Juan Raigoza (incumbent) [[juan-raigoza]]
  - *Thomas Royal Morgan II [[thomas-morgan]] — DID NOT QUALIFY: "Pending" on the March 11 roster, absent from the final [May 4, 2026 qualified roster](https://smcacre.gov/system/files/2026-05/51_candidateroster05042026.pdf) (Controller lists only Raigoza). Not on the ballot.*

### Coroner (nonpartisan)
- Seats: 1
- District: SM-COUNTY
- UNCONTESTED: Robert J. Foucrault (incumbent)

### Treasurer / Tax Collector (nonpartisan)
- Seats: 1
- District: SM-COUNTY
- UNCONTESTED: Sandie Arnott (incumbent)

### Board of Supervisors, District 2 (nonpartisan)
- Seats: 1
- District: SM-SUPERVISOR-D2
- UNCONTESTED: Noelia Corzo (incumbent)

### Board of Supervisors, District 3 (nonpartisan)
- Seats: 1
- District: SM-SUPERVISOR-D3
- CONTESTED:
  - Ray Mueller (incumbent) [[ray-mueller]]
  - Joaquin Jiménez [[joaquin-jimenez]]

### Board of Supervisors, District 5 (nonpartisan)
- **Not on the 6/2/2026 ballot.** The SM County certified candidate roster (03/10/2026) lists only Supervisor Districts 2 and 3 for this primary — D5 is not up in June 2026. Kept here as a note only; remove or relocate if a later official roster contradicts. [SM County roster](https://smcacre.gov/elections/county-offices)

## Sub-county ballot measures

- **Measure A** — Ravenswood City School District $70M bond for new classrooms (55% threshold) — *District: RAVENSWOOD-CSD voters only*
- **Measure B** — Brisbane School District parcel tax (2/3 threshold) — *District: BRISBANE-USD voters only*
- **Measure C** — Redwood City Elementary School District 8-year parcel tax ~17.5¢/sq ft (≈$12.2M/yr, 2/3 threshold) — *District: REDWOOD-CITY-ESD voters only*

## Other CA counties

Not yet enumerated in this manifest. Each county that has races appearing on the 6/2 ballot would add a section parallel to "San Mateo County" above. Extending this manifest to cover other counties is a follow-up; the schema accommodates it.

## Sources

- [CA Secretary of State — Elections](https://www.sos.ca.gov/elections)
- [SM County ACRE — County Offices](https://smcacre.gov/elections/county-offices)
- [CalMatters — 2026 voter guide](https://calmatters.org/california-voter-guide-2026/)
- [KQED — San Mateo voter guide](https://www.kqed.org/voterguide/sanmateo)
- [KQED — California voter guide](https://www.kqed.org/voterguide/california)
- [SM Daily Journal — roster closed (Feb 28 2026)](https://www.smdailyjournal.com/news/local/roster-for-san-mateo-county-s-june-ballot-closed/article_040038b2-2cb3-42ba-af1f-5244e07f47f8.html)
