# Substrate dependencies & freshness

Which artifacts derive from which, and the rule that says when a derived artifact has gone stale. [substrate.md](substrate.md) is the *what-lives-where* map; this is the *what-invalidates-what* map. The two together are how you answer "I just changed X — what else is now wrong?"

The motivating bug: the controversy map (`controversies/2026/CA.md`) was drafted against 30 candidate profiles. Nine more profiles were later added. None of the original 30 changed — so a last-modified-time check on the map's inputs passes — yet the map was stale, because its *input set grew* and nothing recomputed it. That failure mode is the reason this doc exists. See **Freshness rules** below.

## Artifact classes

Nine classes. The first group are **roots** (authored or externally sourced — nothing in the repo derives them); the rest are **derived** (a pure-ish function of upstream artifacts, cacheable, and therefore invalidatable).

| Class | Path | Root/derived | Owner |
|---|---|---|---|
| Source registry | `sources/<US\|state>.md` | root | human-curated, rarely changes |
| Calibration skills | `you-decide/calibration-skills/*.md` (shared) + `<private>/calibration-skills/*.md` (per-user) | root | curated through use |
| Skill bundle (axis taxonomy, templates, sub-skills) | `you-decide/**` | root | the algorithm itself |
| Election manifest | `elections/<year>/<date>-<state>-<type>.md` | root-ish (derived from SoS filings, an external source) | research subagents |
| Candidate profile | `candidates/<year>/<state>/<office>/<slug>.md` | **derived** | research subagents (Stage 2) |
| Controversy map | `controversies/<year>/<state>.md` | **derived** | synthesis (per cycle) |
| Philosophy file | `<private>/philosophy-<user>.md` | root | the user (grows via use) |
| Per-axis read | `<private>/<year>/<state>/<race>/<slug>-read.md` | **derived** | Stage 3 |
| Vote deliberation | `<private>/<year>/<state>/<race>/vote.md` | **derived** | Stage 4–5 |

## The dependency DAG

Edges point from input → derived artifact. Read "A → B" as "B must be recomputed when A changes."

```
sources ─────────────┐
                     ├──→ candidate profile ──┬──→ controversy map
election manifest ────┘    (per candidate)    │     (fan-in: all profiles
   (ballot membership)                        │      for the state/cycle)
external voter guides ────────────────────────┘
                                              │
philosophy ───────┐                           │
calibration ──────┼──→ per-axis read ─────────┤
candidate profile ┘    (philosophy × calib    │
                        × profile)            │
                                              ▼
                              reads + controversy map + election manifest
                                              │
                                              ▼
                                      vote deliberation
```

Roots (no in-edges): sources, calibration skills, skill bundle, philosophy. The election manifest is a root *within the repo* but is itself derived from external SoS filings — refresh it by proximity-to-election rules, not by any in-repo edge.

## Freshness rules

A derived artifact is **stale** when any of the following holds. The first is the familiar one; the second is the one the controversy-map bug exposed.

1. **Newer-input staleness (mtime).** Any input artifact is newer than the derived artifact. This is the rule [[SKILL]] Stage 3 already enforces for reads: a `<slug>-read.md` is reused only if it is newer than (a) the philosophy file, (b) the relevant calibration skills, and (c) the candidate profile it scored against. Generalize it to every derived class — compare against each *named* input on its in-edges.

2. **Membership staleness (fan-in cardinality).** For an edge where the input is a **glob** (many files fan into one derived artifact — `candidates/.../*.md → controversy map`, and `reads/*.md → vote`), the derived artifact is also stale when the *set* of inputs changes — a profile added or removed — even if no surviving input is newer. An mtime check cannot catch this, because the new file is newer than the artifact but the *artifact never knew to look at it*.

   **Mechanism:** a glob-fan-in artifact records its input set in frontmatter — minimally a count, ideally the enumerated list. Staleness = the live glob differs from the recorded set. The controversy map already carries a `sources:` list and an inline "(N files as of DATE)" count for exactly this; the bug was that nothing *checked* it. Treat a count/list mismatch as a refresh trigger, same status as a stale mtime.

Two staleness kinds, one disposition: when either fires, the derived artifact's `review:` no longer certifies its current content. Recompute (or incrementally integrate the delta), update the recorded input set, and re-run review.

### Why the controversy edge was the one that rotted

Every other derived edge had a working trigger: reads have the Stage-3 mtime rule; profiles refresh on candidate news; the manifest refreshes on election proximity. The `candidates → controversy map` edge had only the prose trigger "refresh as new controversies surface" — a human cue, not a mechanical check, and it's a fan-in edge, so it needed the membership rule that didn't exist. Rule 2 is the fix; this doc is where it now lives.

## Worked example — refreshing the controversy map (2026-05-29)

First application of Rule 2. The 2026 CA map was generated against 30 profiles; the live glob held 39 (assembly-d23 ×3, us-house-d16 ×4, Santa-Clara/district-attorney ×2 had been added). Membership mismatch → stale.

The refresh: digest the 9 unmapped profiles (claim-bound to their in-profile source URLs), fold each candidate into the existing contested axes they take a public stance on, and add any genuinely new contested axis (the Santa-Clara DA race surfaced one — prosecutorial independence / office ethics — that none of the 14 existing axes covered). Then update the recorded input set (`sources:` list + the inline count) so the membership check passes, and drop `review:` back to re-review state because the content materially changed. See `controversies/2026/CA.md` frontmatter and its trailing refresh note.

## See also

- [substrate.md](substrate.md) — the artifacts themselves, frontmatter contract, public/private split
- [algorithm.md](algorithm.md) — the Stage 0–6 flow that reads and writes these artifacts, cache-first principle
- [review.md](review.md) — the review pipeline that re-certifies an artifact after a refresh
