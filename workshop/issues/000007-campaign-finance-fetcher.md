---
id: 000007
status: open
deps: []
created: 2026-05-29
---

# Campaign-finance fetcher (FPPC/Cal-Access + FEC) → bind donor/fundraising claims to primary filings

## Context

The genesis-binding campaign (28 CA-2026 candidate profiles, May 2026) surfaced one recurring, systemic gap: **campaign-finance figures were the single most common claim that could not be bound to a Tier-A source.** Across the campaign, donor and fundraising claims repeatedly leaned on Tier-C aggregators (`Factually.co`, `theballotbook.com`, TaxBuzz) that frequently **disagree with each other** (e.g. one candidate's fundraising reported as $266K vs $830K across two aggregators; another's "$250K vs $225K lead" appears only in Factually.co with no primary backing). The primary sources exist but aren't fetchable by hand in the loop:

- **State / county (CA):** FPPC / Cal-Access (now `powersearch.sos.ca.gov`) and county NetFile portals (e.g. `netfile.com/public/MAT`) — interactive, JS-driven, not directly fetchable.
- **Federal (US House):** FEC (`fec.gov/data/candidate/<id>`) — has an API but the per-candidate cycle summaries weren't always posted / fetchable in-session.

Result: several profiles carry `DATA-GAP [axis: capture-risk; severity: med|low]` markers for donor/fundraising data that *should* be bindable to a primary filing. `rg 'DATA-GAP.*capture-risk' candidates/` lists them.

This is **tooling**, not data debt — hence a `workshop/issues/` item (per `review.md`'s routing rule): build the fetcher, then a fixer pass closes the finance gaps in bulk.

## Spec (sketch — refine at build time)

A script (per AGENTS.md §10/§11, with a colocated `SKILL.md`) that, given a candidate + jurisdiction, returns structured campaign-finance facts from the **primary** filing:

- **FEC** (federal): use the FEC API (`api.open.fec.gov`) — candidate lookup → committee → totals (receipts, disbursements, cash-on-hand) + top contributors. Returns the canonical figures + the filing URL to bind.
- **CA Cal-Access / FPPC** (state) and **NetFile** (county): these are the hard part (JS-driven / interactive). Options to evaluate: Cal-Access bulk data exports, the SoS Power Search export, or NetFile's per-jurisdiction API/CSV if one exists. May need a headless-browser fallback. Start with whatever has a real export; flag the rest as still-manual.
- Output: a small structured record (amounts + as-of date + primary source URL) suitable for a fixer to bind inline as a Tier-A citation.
- Start with FEC (easiest, covers US House) to prove the loop; add CA/county incrementally.

## Plan

- [ ] FEC API client: candidate→committee→totals + top donors + filing URL. Test against a known CA-15/CA-16 candidate.
- [ ] Evaluate CA Cal-Access / SoS Power Search / NetFile export options; implement whichever has a real data export.
- [ ] `SKILL.md` documenting usage; wire into the genesis-binding workflow (a fixer runs it, binds the result).
- [ ] Bulk-close the open `DATA-GAP capture-risk` finance gaps left by the May-2026 binding campaign.

## Log

### 2026-05-29 — opened
Created from the genesis-binding campaign's biggest recurring gap. Finance figures currently rest on disagreeing Tier-C aggregators; the primary filings exist but aren't hand-fetchable in-loop. FEC first (has an API), then CA/county.
