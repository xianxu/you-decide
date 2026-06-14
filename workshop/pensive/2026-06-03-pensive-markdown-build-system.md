---
type: pensive
date: 2026-06-03
topic: The "markdown build system" — a build system whose recipes are LLM skills
mode: ideas
description: Prose/markdown artifacts have dependencies and go stale, but unlike code there's no build system to track them. The general pattern behind #13 — what changes when recipes are non-deterministic, expensive, and written in the same medium they build; certification replaces fixed-point; dbt is the closest analog.
references: [workshop/issues/000013-data-model.md, atlas/substrate-dependencies.md, scripts/stale-reads.sh, you-decide/refresh-reads.md]
---

# Pensive: the markdown build system

#13 is the concrete instance — you-decide's nouns and dependency graph. This note
is the *general* thing #13 is an instance of, because the pattern shows up across
the agentic world and across several ariadne artifacts (issues→targets, reads→skills,
atlas→code all declare deps loosely in frontmatter, and nothing refreshes the
intermediate artifacts). Writing it down because it's trickier than it first looked.

## The thesis

A markdown build system is **a build system whose recipes are LLM-executed skills.**
In traditional code, the programming language + build system (Make, Bazel) manage
dependencies; in the AI world, prose/markdown files are *also* the outcome of other
files — a read is derived from a dossier × philosophy × calibration skills — but the
dependencies are undescribed, so staleness rots silently (the controversy-map bug;
the D15→D16 ballot error). The naive move is "Make for markdown." But three properties
break the analogy and they're where all the difficulty lives:

1. **Recipes are non-deterministic.** `skill(inputs)` doesn't produce byte-stable, or
   even *substance*-stable, output. `make` twice is a no-op; `refresh` twice drifts.
   There is no fixed point to converge to.
2. **Recipes are expensive.** Dollars + minutes + web research per rebuild, not
   CPU-milliseconds. So *over*-invalidation is a real cost — "rebuild everything if
   unsure" (fine in Make) is ruinous here. Precise scoping is load-bearing, not a luxury.
   This is the whole reason #13 wants scope-nouns.
3. **Recipe and data share a medium.** Skills are markdown+script; data is markdown;
   outputs are markdown. The build system is written in the thing it builds. "The recipe
   changed" is a frequent, first-class invalidation source — not a rare Makefile edit.

## Make → markdown, where each cell breaks

- *target/prereq* → typed nodes **root / derived / record**. The novel class is **record**
  (the cast ballot): a frozen node *never* rebuilt because it captures a real-world action.
  Make has no notion of "this output is now load-bearing in reality, don't touch it."
- *explicit prereqs* → edges **computed from conventions** (containment + frontmatter +
  `[[links]]` + *implicit* read↔philosophy). #13's bet: the graph IS the tree + declared
  edges, no stored manifest — because a manifest is itself a derived artifact that rots
  (meta-staleness). Minimum-mechanism. The open question is whether that holds once edges
  go implicit and semantic (below).
- *deterministic recipe* → stochastic skill → **no fixed point** → you need
  **certification (review state) as the fixed-point substitute**. An artifact isn't "done"
  when the recipe ran; it's done when it's *certified against its current input set*.
  `review: passed` + the publish gate IS the convergence mechanism. This reframes the whole
  system: you don't maintain *built* artifacts, you maintain *certified* ones.
- *stale = mtime* → **multi-kind staleness**. Make has one rule; we've found two and there
  are ~five.
- *rebuild* → **refresh + re-certify**. Rebuilding always changes bytes, so "did it change"
  ≠ "is it stale." Two *separable* propagations (below).
- *(nothing)* → **selectors / scope-nouns**, central here because cost.

## The staleness kinds (Make has one; we need ~five)

1. **newer-input (date).** `stale-reads.sh` ✔ — frontmatter dates, not mtime (git/autosave
   safe), fail-closed.
2. **fan-in membership / cardinality.** The controversy-map bug: input *set* grew, no
   surviving input newer, mtime passes, artifact stale anyway. Rule 2 ✔.
3. **recipe-version.** When SKILL.md or a calibration skill changes, everything it produced
   is arguably stale — huge fan-out. Currently treated as a stable root. `generated-by`/
   `generated-on` is the seed but doesn't capture skill *version*. This is Bazel's action-key
   idea (tool version is part of the cache key) ported to prompts: `built-with: resolve-ballot@<hash>`
   turns "I edited the skill" into a precise dirty set instead of a silent global stale.
4. **external-world / TTL.** The artifact caches an external fact (filings, finance) that
   moved in the world with *no local in-edge*. Time-based, not graph-based (election-proximity).
5. **semantic.** Input changed cosmetically vs substantively (a typo in a dossier shouldn't
   re-score). mtime/membership can't see this — and because recipes are expensive, this is the
   highest-value filter to add: a *cheap* LLM diff-classifier ("did this edit touch any scored
   axis?") as a pre-filter before paying for a full rebuild. Risk: the classifier is itself a
   non-deterministic recipe → meta-problem. Fail-closed contains it (unsure → stale), exactly
   like `stale-reads.sh` already does.

## What's genuinely new (no existing build system solves these)

- **Certification replaces the fixed point.** Covered above — the single most important
  reframe. Review state is the "built" bit.
- **Two propagations, not one.** Make propagates *recompute-need* downstream. Here it splits:
  **recompute-need** (input materially changed → re-run skill) and **recertify-need**
  (downstream trust is void even without recomputing). A cosmetic philosophy edit might
  recertify-without-recompute; a re-scored read voids its vote's *certification* without
  necessarily rebuilding the vote prose. Modeling these as separable taints is, I think, the
  insight #13 is circling — and it argues `review:` should be an *edge* property
  (certified-against-*this*-input-set), not a node property.
- **Recipe-as-data.** Skills evolve and live in the same tree, so kind-3 is frequent, not rare.
- **Cost-aware everything.** Dry-run (what's stale?), scoped refresh (this subgraph), incremental
  integration (fold the delta — the controversy-map worked example did exactly this rather than
  full recompute), proximity prioritization (refresh what's closest to being consumed). Make
  needs none of this.

## Prior art to steal from

- **dbt (data build tool)** is the closest commercial analog and the best vocabulary source:
  a DAG of derived `model`s, edges **inferred** from `ref()` (not declared), `source` freshness
  checks (= kind-4 TTL), `dbt run --select model+` to rebuild a downstream closure, `tests` to
  certify. Its **selectors** (`+model`, `model+`, `tag:foo`) map ~1:1 onto #13's scope-nouns
  (`read|race|ballot|cycle|all` + `affected-by:<input>`). Swap SQL→prompt and you have ~80% of this.
- **"Build Systems à la Carte"** (Mokhov/Mitchell/Peyton Jones) is the right *lens*: every build
  system = a **scheduler** (what order) × a **rebuilder** (is-it-dirty + how). Make = topological +
  mtime; Bazel = restarting + verifying-trace; Excel = the most successful build-system-for-normal-
  people (cells × formulas × auto dirty-propagation). A markdown build system is a *new point*: a
  **stochastic, expensive rebuilder + a certification layer** — which the paper doesn't cover because
  it assumes deterministic recipes.
- **Jupyter** is the cautionary cousin (out-of-order, hidden state, no dep tracking → irreproducible);
  **Observable** is the fix because it has a real dataflow DAG. Build the Observable version.
- Incremental view maintenance / Datalog: the fan-in aggregate (reads→vote, profiles→controversy-map)
  is literally a materialized aggregate over a growing relation.

## The minimal model I'd commit to

> A markdown build system is a DAG over content artifacts where **(a)** edges are computed from
> conventions, not declared; **(b)** every derived node carries a **build-stamp** =
> `{date, input-set, recipe-id, review-state}`; **(c)** a generic staleness engine produces a dirty
> set for a given *selector* by applying per-edge-kind predicates; **(d)** "build" = refresh-then-
> recertify, because the recipe is untrusted.

## Two artifacts hiding here — name them separately

- **The instance** — #13: write down you-decide's nouns/edges as a `target` + atlas entry;
  `stale-reads.sh` is the bespoke engine.
- **The general capability** — "dbt for agent-generated markdown" as an **ariadne base-layer** thing.
  Several ariadne artifacts already declare deps loosely in frontmatter; nothing refreshes the
  intermediates. The base layer is the natural home for a generic contract: every derived artifact
  stamps `{class, input-edges, build-stamp}`; a generic engine computes dirty sets by convention; a
  generic driver routes refresh through review; selectors bound cost. `stale-reads.sh` graduates from
  "you-decide script" to "instance of the base engine." Possibly a real verb — `sdlc refresh --select
  <noun>`, dbt-style — with #13 as its first consumer.

## Open questions

- **Stored vs inferred graph.** #13 commits to inferred (minimum-mechanism). Does that survive once
  edges are implicit (read→philosophy is unnamed) and you want semantic (kind-5) edges? Or does each
  derived artifact need to *stamp its resolved input-set at build time* — a per-artifact frozen edge
  list — which is the half-way house: inferred at build, stored thereafter? (The build-stamp's
  `input-set` field already leans this way.)
- **Is recipe-version (kind-3) worth the bookkeeping**, or does treating skills as stable roots +
  occasional manual global refresh stay cheaper?
- **`review:` as node vs edge property.** The fan-in bug and the two-propagations split both argue
  for *edge* (certified-against-this-input-set). But that's more mechanism. When does it earn it?
- **Where does the capability live** — does it want to be `sdlc refresh` (base layer, generic) with
  you-decide as consumer #1, or stay per-repo scripts until a second consumer appears? (DRY says wait
  for the second instance before generalizing; the pattern says it's already cross-cutting.)
- This feels like it wants to become a **target** eventually — *"every derived artifact declares its
  inputs; refresh = downstream closure; nothing goes silently stale"* — which is exactly the invariant
  #13 already proposes. The target may be the you-decide-local shadow of a base-layer concept that
  doesn't have a home datatype yet.

## References

- `workshop/issues/000013-data-model.md` — the concrete instance: nouns, the dependency graph, the one
  fallible external edge (address→ballot-style).
- `atlas/substrate-dependencies.md` — the existing DAG: 11 artifact classes (root/derived/record), the
  two staleness rules already written down.
- `scripts/stale-reads.sh` — the working detector for kind-1 (newer-input), fail-closed, frontmatter-date based.
- `you-decide/refresh-reads.md` — the soft re-score driver (the untrusted-rebuild half).
