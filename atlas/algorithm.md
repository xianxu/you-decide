# Algorithm

The top-level skill is `you-decide/SKILL.md`. It composes four sub-skills and runs on the substrate described in [substrate](substrate.md). This atlas page gives the sketch; the SKILL file has the executable detail.

## Posture: decision-help, not profile-building

We don't try to capture the user's complete political identity upfront. The philosophy file starts sparse (enough to differentiate this cycle's candidates) and grows organically across cycles via the disagreement loop and just-in-time disambiguation. Trust between user and tool, and the tool's model of the user, compound through *use* — not through more exhaustive surveys.

## Stages

| Stage | Sub-skill | Output |
|---|---|---|
| **0** Cold-start detect | — | If no `philosophy-<user>.md`, route to [[bootstrap-survey]] |
| **1** Resolve ballot | [[resolve-ballot]] | Election manifest for user's address (offices, candidates, voting system) |
| **2** Identify controversies | [[identify-controversies]] | Cycle's controversy map per state, with Survey-ready stances |
| **3** Per-axis read | (inline) | `<slug>-read.md` per candidate: axis scores + weighted total. **Just-in-time disambiguation** fires here when an axis is load-bearing for the race but silent in the philosophy. |
| **4** Disagreement loop | (inline) | User corrections crystallize as calibration skills; affected reads re-scored |
| **5** Aggregate + present | (inline) | Conscience vote + strategic vote, with divergence surfaced; risk-frame not scorecard |
| **6** Final write | (inline) | `who-to-vote-for/<year>/<state>/<race>/vote.md` in user's private dir |

Plus the **Review gate** before any commit to shared substrate (see [review](review.md)).

## Cache-first by default

Every stage that has a cached artifact reuses it. The skill re-dispatches research subagents only when the artifact is missing, stale per its sub-skill's rules (e.g., proximity-to-election triggers in [[resolve-ballot]]), or any of its inputs changed. A per-axis read (`<slug>-read.md`) is a pure function of philosophy + calibration skills + candidate profile; nothing changed → reuse.

## Axis taxonomy (five tiers)

The taxonomy is the *interface*; the philosophy file is the *implementation*. Tiers 1, 2, 5 are universal-weight; tiers 3, 4 weight per office (see `you-decide/templates/`).

| Tier | Name | Examples |
|---|---|---|
| 1 | Character & temperament | smart/coherent, anti-hypocrisy, anti-personalist-strongman |
| 2 | Institutional posture | institutionalist, leave-people-alone, secular-pluralist |
| 3 | Economic philosophy | fiscally-conservative, builder-mentality, anti-union pro-ownership-floor |
| 4 | Issue positions | housing, energy, public safety, immigration, healthcare, crypto |
| 5 | Social values | socially-liberal, education-investment, work + opportunity |

## Scoring contract

Documented in `SKILL.md` Stage 3, enforced by [[review]]:

- Per-axis score: integer in **[−2, +2]**
- Exception: institutionalist axis extends to **−4** when [[trump-era-cater-discount]] action-tier applies
- Per-office template weights: heavy ×2, medium ×1, light ×0.5
- `weighted-total = Σ (axis × weight)` as a scalar (no `/N` or `/max` framings — they drift across subagents)
- Frontmatter `weighted-total:` MUST equal body math
- Body shows formula explicitly

## Calibration skills

User corrections from the Stage 4 disagreement loop crystallize as calibration skills — small markdown files that adjust how axes are scored. Two locations:

- `you-decide/calibration-skills/` — **shared**, applies to all users (e.g., `trump-era-cater-discount`, `expressive-primary-strategic-general`)
- `<private-dir>/calibration-skills/` — **user-specific** (e.g., a user's personal weighting on a particular axis)

Stage 3 loads both sets automatically when generating a per-axis read. Calibration skills accumulate over cycles; they're a primary mechanism (alongside the philosophy file itself) by which the tool becomes more accurate for the specific user across time.

## Hard filters

Auto-reject conditions declared in the user's `philosophy-<user>.md` "Hard limits" section. Examples: personalist-strongman support, attempted election-machinery interference. Applied at Stage 5 before aggregation.

## Two-vote output

Default presents two recommendations:

- **Conscience vote** — best-fit across all axes
- **Strategic vote** — best-fit among top-N polling

Divergence between the two is often the most decision-relevant signal. Framed as risk-mode (what could go wrong with each option) not scorecard (a single number ranking).
