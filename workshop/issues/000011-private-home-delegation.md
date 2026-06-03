---
id: 000011
status: working
deps: []
github_issue:
created: 2026-06-02
updated: 2026-06-02
estimate_hours: 2
---

# Private home: split routing/longevity out of the shared algorithm

## Problem

`you-decide` is meant to be the publishable, multi-user *algorithm*, but it
currently hardcodes the **private side** into itself:

- the entire "Path conventions" section of `SKILL.md` (the `who-to-vote-for/...`
  layout, the `data/candidates/` vs private-read split rationale),
- `scripts/private-dir.sh` resolution and the `$YOU_DECIDE_PRIVATE_DIR` /
  sibling-default logic,
- the brain-integration note (symlink + brain-resident private tree).

So the reusable algorithm knows one user's home address. Two costs:

1. **Publishability leak.** Publishing `you-decide` carries Xian's path
   assumptions out with it; the public artifact is not genuinely user-agnostic.
2. **No registry for artifact types.** When the user said *"record my vote,
   find a place"* (2026-06-02), there was **no convention** — the agent
   improvised `menlo-park-2026-06-02-cast.md` ad hoc. A cast-ballot is an
   obvious recurring artifact type and nothing owned its name, location, or
   frontmatter. That gap is the concrete evidence this seam needs a home.

This issue separates **where private things live** (routing/longevity) from
**the algorithm that reasons over them**, and has the algorithm *delegate* to
the former.

## Spec

### The split

Private content is two kinds; only one of them is the new artifact:

- **(A) Routing & longevity** — where files live, how the private dir resolves
  across repo re-clones / brain remounts, and the naming + frontmatter
  conventions for each ballot document type. *Deterministic.* **This is what we
  build.**
- **(B) The user themselves** — `philosophy-<user>.md`, the user-private
  calibration-skills, hard filters. *Already data, not a skill.* Untouched here
  except that (A) points at it.

### Decision: thin brain-resident "home", NOT a parallel SKILL algorithm

Rejected — a full counterpart SKILL.md that mirrors the algorithm: there is one
algorithm and one *home*, not two algorithms. A parallel skill violates
minimum-mechanism (one mechanism with clear responsibilities beats two
overlapping ones).

Chosen — a **thin private home** that lives in the brain (the encrypted,
user-private tree) and that `you-decide` delegates all private-location
decisions to. It is config + a short conventions doc + the existing resolution
script, NOT a second reasoning engine. It owns exactly four things:

1. **Private-dir resolution for longevity.** Absorbs / wraps
   `scripts/private-dir.sh`. The durable answer to "where do these live so they
   survive a repo re-clone or a brain remount." The brain is the anchor (the
   data already lives at `data/life/politics/who-to-vote-for/`), which is more
   durable than an env var alone.
2. **The artifact-type registry.** Naming + frontmatter for each ballot
   document type, in one place:
   - ballot guide — `<addr>-<date>-ballot.md` (the recommendation/analysis)
   - per-candidate read — `<year>/<state>/<race>/<slug>-read.md`
   - per-race vote — `<year>/<state>/<race>/vote.md`
   - **cast ballot — `<addr>-<date>-cast.md`** (NEW — promoted from the
     2026-06-02 ad-hoc file; record of what was actually marked, reconciled
     against the guide)
3. **A pointer to who the user is** — `philosophy-<user>.md` + the user-private
   calibration-skills dir.
4. **Brain-integration + security posture** — `$YOU_DECIDE_PRIVATE_DIR`, and the
   fact that this tree is gcrypt/GPG-encrypted while shared `you-decide` is
   public.

### Inversion of control in `you-decide`

`SKILL.md` gets **thinner**: delete the Path-conventions prose and the
private-dir resolution detail; replace with a single delegation point —
"resolve all private locations + artifact-type conventions via the private
home." Shared algorithm, private home. After the split, nothing in the public
bundle references `who-to-vote-for/...` paths or a specific user.

### Why the split earns its keep (not just tidiness)

It lands on the **security boundary**: shared `you-decide` is publishable/public;
the private home lives in the encrypted brain. Separating them means the public
artifact is genuinely user-agnostic and the private one never leaves the
encrypted tree. (See `brain/atlas/threat-model-shared-brain.md`.)

### Honest cost

Two places to look when something breaks. Mitigated by keeping the home **thin**
(config + conventions doc + script), not a second reasoning engine. If the home
ever starts accreting reasoning/instructions, that's the smell that the split
went wrong.

## Done when

- A thin private-home artifact exists in the brain tree, owning the four
  responsibilities above (resolution, type registry, user pointer, security
  posture).
- The cast-ballot type is in the registry with a defined name
  (`<addr>-<date>-cast.md`) + frontmatter; the 2026-06-02 file conforms to it.
- `you-decide/SKILL.md` no longer hardcodes `who-to-vote-for/...` paths,
  `$YOU_DECIDE_PRIVATE_DIR` logic, or any user-specific assumption — it
  delegates to the private home at a single point.
- A fresh `grep` of the public bundle for `who-to-vote-for` / `philosophy-xian`
  / brain paths returns nothing load-bearing (only delegation references).
- `atlas/` updated for the new private-home seam + the inversion.

## Plan

*(Revised 2026-06-02 — see `## Revisions`. Original brain-home plan superseded.)*

- [ ] Create `you-decide/artifacts.md` — the shared artifact-type registry
      (ballot-guide / candidate-read / race-vote / **cast-ballot**): path
      pattern + frontmatter + purpose per type.
- [ ] Formalize the cast-ballot type from the 2026-06-02 ad-hoc shape.
- [ ] Thin scattered naming restatements (`SKILL.md`, `resolve-ballot.md`,
      `review.md`) to reference `artifacts.md`; keep algorithm prose.
- [ ] Re-anchor brain-routing docs on `construct/deps` (doc-only:
      `private-dir.sh` comment, `atlas/overview.md`, `README.md`) — demote
      `$YOU_DECIDE_PRIVATE_DIR` to an override.
- [ ] Update atlas (`substrate.md`, `substrate-dependencies.md`, `algorithm.md`,
      `index.md`); conform `menlo-park-2026-06-02-cast.md`.
- [ ] Verify (grep no naming drift / no user leakage; routing dry-run) +
      fresh-eyes review; fix Critical/Important.

## Revisions

### 2026-06-02 — reframed from "brain-resident home" to "shared type registry"

**Reason:** inventory of the bundle + the user's pointer to `brain/construct/deps`
showed the original premise was off. Routing/longevity is already solved twice
over — `scripts/private-dir.sh` resolves the private dir, and `construct/deps`
is the brain's committed declaration of the you-decide mount
(`data <url> data/life/politics/you-decide`), from which the private dir is the
derivable `who-to-vote-for` sibling. A brain-resident "home that owns routing"
would duplicate `construct/deps`.

**Delta:**
- DROP — the brain-resident home artifact, the routing relocation, the
  user-pointer + security-posture responsibilities (all already covered by
  `construct/deps` + `private-dir.sh` + the brain's gcrypt setup).
- KEEP + SHARPEN — the genuine gap: there is no central artifact-type registry,
  and the cast-ballot type doesn't exist. Build `you-decide/artifacts.md`
  (shared, user-agnostic) and fold the scattered naming into it.
- ADD — re-anchor the brain-routing *docs* on `construct/deps` (doc-only;
  `private-dir.sh` already resolves correctly through the brain symlink).
- The "private counterpart skill" framing dissolves: private *data* is already
  in the brain, private *location* is already in `construct/deps`; only a shared
  *type registry* was missing.

## Log

### 2026-06-02

Born from a session that (a) re-confirmed the SM County Superintendent vote
under the new `institutionalism-costly-signal` calibration skill, (b) recorded
Xian's full cast ballot — which surfaced that **no cast-ballot convention
existed** (file invented ad hoc) — and (c) led to the design discussion this
issue captures. Recommendation in this issue = the agreed direction: thin
brain-resident private home + delegation, not a parallel skill.
