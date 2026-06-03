---
id: 000013
status: open
deps: [you-decide#12]
github_issue:
created: 2026-06-02
updated: 2026-06-02
estimate_hours: 4
---

# you-decide data model: nouns, dependency graph, fact/inference layers

## Problem

We grew **verbs** for keeping the substrate current — `refresh-facts`, `refresh-reads` (#12) — but no **nouns** to name *what scope* to refresh. So refresh is all-or-nothing (the #12 detector sweeps the entire private dir), and staleness is over-broad (a single calibration-skill edit flags every read because the check takes `max(all skills)`, even reads that never applied it). Underneath: the system has an implicit data model — entities (read, race, ballot, cycle, candidate dossier, election manifest) and dependencies among them — that has never been written down. Until it is, scoping, precise invalidation, and the ballot's fallible district-resolution all stay ad hoc. The D15→D16 district error (a wrong ballot membership that nothing detected — only the user caught it) is the sharpest symptom.

## Spec

Write down the data model. Design, not (mostly) code — the output is a `target` + atlas entry that later slices implement.

### Entities (nouns) and where they live
Two parallel trees mirror each other race-for-race — **facts** (`data/`) and **inference** (`who-to-vote-for/`) — plus cross-cutting inputs:

- **election** (fact) — `data/elections/<year>/<date>-<state>-<type>.md`. The manifest of races, each tagged with the `District:` that gates visibility. **`race` and `ballot` are not new datatypes — they are records/views in here:**
  - **race** (fact) — one contest in the manifest: office, district tag, seats, voting system, on-ballot candidate list (→ `[[candidate]]` edges). Mirrored on the inference side by a race *directory* (`who-to-vote-for/<year>/<state>/<race>/` = its reads + `vote.md`).
  - **ballot** (fact, a *view*) — `(address, date) → resolved district set → the filtered subset of the manifest's races`. The one noun that is **not** a directory: it's a cross-cut (D16-not-D15, D23-not-D21, + statewide + county). Its content on the inference side is the **consolidated guide** (`menlo-park-*-ballot.md`).
- **candidate** (fact) — `data/candidates/<…>/<slug>.md` dossier.
- **read** (inference) — `<…>/<slug>-read.md`; one candidate × user. Declares its input edges: `candidate:` (dossier), "## Calibration skills applied" (`[[skill]]`), office `template`, and (implicitly) the user `philosophy`.
- **vote** (inference) — `<race>/vote.md`; aggregates its race's reads.
- **cycle** (structural) — `<year>/<state>` subtree; all races in an election.
- **inputs** (cross-cutting, not in either tree) — `philosophy-<user>.md`, `calibration-skills/*.md`, `templates/<office>.md`.

### The dependency graph
**Computed from conventions — filesystem containment + frontmatter edges — never a stored manifest** (minimum-mechanism; "nouns ≈ directories" only works because the graph *is* the tree + declared edges). Edges:

```
election.manifest ──(defines membership/candidates)──▶ race ──▶ vote ──▶ ballot-guide
philosophy ┐                                            ▲                    ▲
calib-skill├──(declared input edges)──▶ read ───────────┘                    │
template   │                             ▲                                   │
candidate ─┴──(dossier edge)─────────────┘                                   │
ballot.resolution (address→districts) ──(defines which races)────────────────┘
```

**Refresh = downstream closure** over this graph from whatever changed. The structural nouns (race/cycle/ballot/all) are pre-named subgraphs; **impact scope** is an arbitrary subgraph rooted at a changed input (e.g. `affected-by:calibration-skill:progress-over-status-quo` = only the reads that cite it — fixes the over-invalidation bug). Same single mechanism; the verbs (`refresh-facts`/`refresh-reads`) walk the fact vs inference side of the *same* node coordinates.

### The hard part: `ballot` straddles fact and inference
Every other noun is pure structure; **ballot membership is a fact-grounded selector**. `(address, date) → district set` is **externally-sourced and fallible** — it is the edge that was wrong in the D15/D16 case, and nothing detected it. So the resolution must become a **dated, sourced, checkable fact edge** (it exists today only as an undated `jurisdictions:` list in the consolidated guide). Consequence: `refresh ballot` has a first step the other nouns lack — **re-resolve districts** (a fact-refresh) → which may change membership → then refresh the member races + re-aggregate the guide. This also gives the consolidated guide a home in the graph (closing #12 dogfood-finding #2: it was untracked).

### Design decisions to lock
- Graph computed-from-conventions, not stored manifests. ✔ (proposed)
- `race`/`ballot` are election-structure facts in `data/elections/`, not new datatypes. ✔ (user)
- Edge sources: read→inputs from read frontmatter/body; race membership + candidates from the election manifest; ballot membership from a (to-be-formalized) dated resolution.
- Express the invariants as a **`target`** ("every inference declares its inputs; refresh = downstream closure; ballot membership is a dated resolved fact; no silent staleness"), since the point is defending against drift.

## Done when

- A written data-model design exists as `workshop/targets/<slug>.md` (the invariants) + an `atlas/` entry (the entity/edge map), linked from `atlas/index.md`.
- The election manifest schema is extended to carry the **address→district resolution** as a dated, sourced edge (or a sibling `data/elections/<…>/resolutions/` record), so a stale/wrong ballot membership is *detectable*, not user-caught.
- The model names how `refresh-facts`/`refresh-reads` take a **scope noun** (`read|race|ballot|cycle|all` + `affected-by:<input>`) and how the #12 detector computes the dependency closure from declared edges (replacing `max(all skills)`).
- #12's detector + driver are reconciled to the model (structural scopes + edge-based invalidation) as the first implementation slice.

## Plan

- [ ] Draft the entity/edge model + invariants → `workshop/targets/data-model.md` (or similar) + `atlas/` entry
- [ ] Specify the election-manifest extension for the dated address→district resolution (the ballot edge)
- [ ] Specify scope-noun args + edge-based closure for the #12 detector/driver (supersedes `max(all skills)`)
- [ ] Identify follow-up implementation slices (manifest completeness, resolution verification, consolidated-guide-as-ballot-node)

## Log

### 2026-06-02
Spun out of the #12 brainstorm. Sequence of insights: verbs without scope-nouns → all-or-nothing refresh + over-invalidation → nouns ≈ directories + a computed dependency graph → `ballot` is the lone non-directory noun (a view) → its membership is a fallible externally-sourced fact (the D15/D16 error) → therefore `race`/`ballot` are really one **election-structure fact type**, already half-modeled in the (incomplete) `data/elections/2026/2026-06-02-CA-primary.md` manifest. This ticket = sort out that model; #12 is its first slice.
