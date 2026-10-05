---
generated-by: codex
generated-on: 2026-10-04
review: passed
reviewed-by: claude
reviewed-on: 2026-10-04
review-ref: data/reviews/2026/2026-10-04-ca-general-packet-claude.md
election-date: 2026-11-03
ballot-style: BT-114
posture: neutral research
---

# November 2026 ballot research

Research for all 48 contests on the supplied San Mateo County reference ballot BT-114: 14 candidate elections, 13 judicial retention votes, and 21 measures. The five reports below distinguish documented facts, campaign statements, analytical tradeoffs, and evidence gaps. They do not rank candidates or prescribe votes.

Research date: October 4, 2026. This is an initial research packet with explicit limits, not an exhaustive investigation of every candidate, donor, court decision, or legal provision. Use the linked sources to inspect the evidence behind individual claims.

## Read the research

| Report | Coverage |
|---|---|
| [State and federal candidates](state-and-federal-candidates.md) | Eleven races and all 22 printed candidates: nine state offices, Congress District 16, Assembly District 23 |
| [Local candidates](local-candidates.md) | Three races and all eight printed names: Menlo Park Council District 2, Sequoia High School Area D, Menlo Park City School Board |
| [State propositions](state-propositions.md) | Propositions 1–5 and 37–45, including potential interaction among 40, 41, and 42 |
| [Local measures](local-measures.md) | RTM, V, L, AA, J, U, and P: vote effects, fiscal details, arguments, and uncertainties |
| [Judicial retention](judicial-retention.md) | Two Supreme Court and eleven Court of Appeal biographies, retention procedure, and public-discipline index check |
| [Research review (Codex, same-stack)](../../../reviews/2026/2026-10-04-ca-general-packet-codex-samestack.md) | Fresh-context spot checks, findings, and stated review limits |
| [Research review (Claude, cross-stack)](../../../reviews/2026/2026-10-04-ca-general-packet-claude.md) | Cross-stack verdicts per file, findings, and fixes |

## Ballot and sources

- The original 25-page PDF export (county voter guide, 6:12 p.m. on October 4) is **not published**. The guide's export embeds the exporting voter's on-screen selections and account metadata, so it stays private. The county's own reference-ballot tool is public: [ca.omniballot.us (San Mateo)](https://ca.omniballot.us/sites/06081/cvig/app/cvig/vig/ballot).
- [Extracted ballot text](sources/ballot-bt-114.txt): retains the PDF's line breaks and overlapping print elements; use the PDF if extraction looks ambiguous.
- [Structured ballot manifest](ballot.json): all 48 contests in printed order, with stable identifiers and references into the research reports.
- [Source index](sources.json): deduplicated URLs cited by the reports, with the report filenames that cite each source. Claim-level attribution remains in the Markdown.

The reference ballot is labeled a reference ballot, not an official ballot. Its named choices establish this packet's scope; a printed name alone does not prove the candidate is still actively campaigning. See the local report's withdrawal discussion.

## Using these files in a web app

Read `ballot.json` as the navigation manifest and render the linked Markdown reports. All paths inside the manifest are relative to this folder. This packet is neutral, preference-free substrate. It lives in the public fact layer at `data/elections/2026/2026-11-03-CA-general/`, beside its manifest [`../2026-11-03-CA-general.md`](../2026-11-03-CA-general.md). Personalized reads and votes built on it stay in the user's private dir.

The JSON's `schema_version` is 1. An election is identified by `election_date`, `state`, `county`, and `ballot_style`. Each contest includes:

- `id`: stable within this election; combine with `election_date` for a cross-election key.
- `ballot_order`: the printed contest number, 1–48.
- `kind`: `candidate_election`, `judicial_retention`, or `ballot_measure`.
- `title`, `jurisdiction`, and `max_selections`.
- `candidates` with stable IDs, names, and printed party preferences for candidate elections; `justice` for retention contests; `options` for Yes/No questions.
- `printed_write_in_slots`: printed lines, not a judgment about write-in eligibility. The four nonpartisan candidate races have 1, 1, 3, and 1 lines respectively.
- `ballot_pages`: one-based page numbers of the county reference ballot (the "Page N of 25" markers in `sources/ballot-bt-114.txt`).
- `research_file` and `research_anchor`: a report and its Markdown heading anchor. Candidate races also include the exact `research_heading`.

Candidate ordering follows the PDF and is not a ranking. A null party preference means the nonpartisan ballot does not display one; it does not assert that the person has no party affiliation. Short measure descriptions are navigation labels, not official ballot titles. The manifest records printed choices; researched status changes belong in separate annotations rather than deleting names from the original ballot.

No frontend or public deployment is included. These are local source files for the application you plan to build.

## Coverage limits

Candidate coverage is uneven where independent reporting is sparse. The packet does not comprehensively audit campaign finance, legislative votes, litigation dockets, or claimed performance outcomes. The judicial report checks biographies and public indexes but does not rate every justice's opinions. Fiscal figures are attributed estimates rather than new forecasts. Where a pro or con argument was not filed, the reports do not invent one or infer unanimous support.

The reviews are spot checks, not an exhaustive fact-check. Review state is in each file's frontmatter. See the [Codex same-stack record](../../../reviews/2026/2026-10-04-ca-general-packet-codex-samestack.md) and the [Claude cross-stack record](../../../reviews/2026/2026-10-04-ca-general-packet-claude.md) for the checks actually performed.

## Revisions

- 2026-10-04: moved from the user's private dir into the public substrate (you-decide#15). Content unchanged apart from these location notes. Same-day fresh research is in [`supplement-2026-10-04.md`](supplement-2026-10-04.md).
