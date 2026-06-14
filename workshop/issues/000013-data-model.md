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
**One fact layer** (`data/`, collected by you-decide) and **one inference layer** (`who-to-vote-for/`, per-user) on top — *not* mirrored trees. Plus cross-cutting inputs.

**Facts — collected per (year, state):**
- **election** (fact) — `data/elections/<year>/<date>-<state>-<type>.md`. Holds the races and the ballot-styles below. **`race` and `ballot` are not new datatypes — they are records in here.**
  - **race** (fact) — one contest: office, district tag, seats, voting system, on-ballot candidate list (→ `[[candidate]]` edges).
  - **ballot-style** (fact) — a **discrete, enumerable** ballot = a specific district combination → the subset of races a voter with those districts sees. The set of distinct styles in a (year, state) is *finite and small* at the granularity you-decide scores (statewide + the few district races + county): the Peninsula is ~`{D15/D21, D16/D23} × county`. So ballot-styles are **collected as facts**, no address needed — *not* a per-address derivation, and *not* a "view straddling layers." This is the home for the consolidated guide's structure.
- **candidate** (fact) — `data/candidates/<…>/<slug>.md` dossier.

**Inference — per-user (`who-to-vote-for/`):**
- **read** — `<…>/<slug>-read.md`; one candidate × user. Declares its input edges: `candidate:` (dossier), "## Calibration skills applied" (`[[skill]]`), office `template`, and (implicitly) the user `philosophy`.
- **vote** — `<race>/vote.md`; aggregates its race's reads.
- **my-guide** — the consolidated voter guide for *my* ballot-style (`menlo-park-*-ballot.md`); aggregates the votes of the races in my style.

**Cross-cutting inputs** (in neither layer) — `philosophy-<user>.md`, `calibration-skills/*.md`, `templates/<office>.md`.

**Structural conveniences:** `cycle` = `<year>/<state>` subtree; `all` = the private dir.

### The dependency graph
**Computed from conventions — filesystem containment + frontmatter edges — never a stored manifest** (minimum-mechanism; "nouns ≈ directories" only works because the graph *is* the tree + declared edges). Edges:

```
FACTS (collected, no address)                 INFERENCE (per-user)
  race ──────────────┐
  candidate ──┐      │
  philosophy ─┤      ▼
  calib-skill ┼─▶  read ──▶ vote ──┐
  template ───┘                    ▼
  ballot-style ──(which races)──▶ my-guide
       ▲
  address→district resolution (thin · external · per-user) ──picks──▶ my ballot-style
```

One direction: facts → reads → votes → my-guide. **Refresh = downstream closure** from whatever changed. Structural nouns (race/cycle/ballot-style/all) are pre-named subgraphs; **impact scope** is an arbitrary subgraph rooted at a changed input (e.g. `affected-by:calibration-skill:progress-over-status-quo` = only the reads that cite it — fixes the over-invalidation bug). The verbs (`refresh-facts`/`refresh-reads`) walk the same node coordinates on the fact vs inference side.

### The one external/fallible edge: address → ballot-style
This is now small. **Ballot-styles are plain facts** (collected, enumerable). The only per-user, externally-sourced, fallible bit is the **one-line resolution `address → my districts → which ballot-style is mine`** — exactly where D15/D16 went wrong, and nothing detected it. Make *that* dated + sourced + checkable; it is not a subsystem.

Two tiers of external lookup, kept distinct:
- **Coarse — "what's contested in this city / county / state"** → builds the manifest + enumerates ballot-styles. No address needed; this is what we already used (CalMatters / SoS / county roster). Refreshable as facts (`refresh-facts`).
- **Precise — "address → district → which style"** → the thin per-voter resolution, on-the-fly, the one fallible edge. Cheap to re-run; the value is that re-running it (or dating it) makes a wrong/stale ballot *detectable* instead of user-caught.

Net: `my-guide` is just the votes of the races in my resolved ballot-style — closing #12 dogfood-finding #2 (the guide had no home in the graph) without any "view straddling layers."

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

**General pattern (2026-06-03).** Zoomed out from this instance to the category it belongs to —
a "markdown build system" (a build system whose recipes are LLM skills). Captured in
`workshop/pensive/2026-06-03-pensive-markdown-build-system.md`: the three properties that break the
Make analogy (non-deterministic / expensive / self-hosting recipes), the ~five staleness kinds,
certification-replaces-fixed-point, the two separable propagations (recompute-need vs recertify-need),
dbt as the closest analog, and the fork between #13 (you-decide instance) and a possible ariadne
base-layer `refresh` engine. Feeds the `target` this issue proposes.

**Refinement (same session).** User pushed back on two over-builds and simplified the model: (1) dropped "two mirrored trees" — there's just one fact layer + one inference layer, race/ballot are facts you-decide collects like candidates; (2) **ballot = a discrete, enumerable "ballot-style" fact** (the set of distinct ballots in a year/state is finite/small at the scored granularity — Peninsula ≈ {D15/D21, D16/D23}×county), collected with no address. The "ballot straddles fact/inference" awkwardness dissolves: the only external/fallible piece is the thin one-line `address→which-style` resolution. Two distinct external tiers: coarse jurisdiction lookup (builds the manifest+styles; already used) vs precise address→district resolution (the fallible edge). Spec above rewritten to this simpler model.
