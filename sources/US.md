---
state: US
slug: us-federal
generated: 2026-05-28
last-verified: 2026-05-28
scope: Federal races (US House, US Senate, presidential) and cross-state national coverage
---

# US (federal-level) — authoritative sources

For federal races and cross-state national coverage, use these sources. Composes with per-state `sources/<state>.md` files for state-level races.

Tier discipline is the same as `calibration-skills/source-hygiene-tier-list.md` — A/B for decisive claims, C only with explicit tilt flag.

## Tier A — Primary / official

- **Candidate's official campaign site** — date-stamp snapshots (campaign sites get scrubbed)
- **FEC filings** (fec.gov) — federal campaign finance, donor disclosures, party-committee records
- **Congress.gov** — voting records, bill cosponsorship, committee assignments for sitting members
- **House Clerk** (clerk.house.gov) — roll-call votes
- **Senate.gov** — roll-call votes
- **PACER / court records** — federal court filings if relevant
- **Candidate's verified social-media posts** — link the post directly; screenshot as fallback

## Tier B — Authoritative-secondary (national, low-tilt)

- **AP** (apnews.com) — wire-service factual
- **Reuters** (reuters.com) — wire-service factual
- **NPR / PBS** — public broadcasting; generally low-tilt
- **Politico** — DC-focused; useful for committee politics
- **GovTrack** (govtrack.us) — voting-record analysis, ideology scoring derived from votes

## Tier C — Use only with explicit tilt flag

- **Wikipedia** (en.wikipedia.org) — orienting bio facts only; never decisive
- **Fox News** — right-tilt; flag when citing
- **MSNBC** — left-tilt; flag when citing
- **National Review / Daily Wire / The Federalist** — right-tilt
- **Mother Jones / The Nation / Slate / Jacobin** — left-tilt
- **Factually.co** and similar AI-summary aggregators — derivative; chase the underlying primary source

## Specialized (use with appropriate tier discipline)

- **OpenSecrets** (opensecrets.org) — campaign finance analysis sourced from FEC; Tier B
- **Ballotpedia** (ballotpedia.org) — broad election coverage; verify decisive claims against primary; Tier B/C depending on the specific page's sourcing
- **FiveThirtyEight / Cook Political Report / Sabato's Crystal Ball** — race ratings + polling aggregation; Tier B for polling aggregation, methodological-tilt aware
- **ADL / SPLC** — extremism / hate-group affiliation reporting; Tier B with explicit framing-aware citation
