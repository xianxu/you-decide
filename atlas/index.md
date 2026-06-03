# you-decide atlas

Map of how `you-decide` works. Practical sketch — details live in the code, sub-skill files, and issue history.

## Entries

- [Overview](overview.md) — what this repo is, install models (standalone vs brain-integrated), repo layout, where the skill bundle lives
- [Algorithm](algorithm.md) — Stage 0–6 of the top-level skill, cache-first principle, axis taxonomy, calibration skills
- [Substrate](substrate.md) — data directories (`data/candidates/`, `data/controversies/`, `data/elections/`, `data/sources/`, `data/reviews/`), per-file frontmatter contract, public/private split
- [Artifact registry](../you-decide/artifacts.md) — the single authority for every private artifact the algorithm writes (ballot guide, candidate read, race vote, cast ballot): path + frontmatter + purpose per type, and where the private dir resolves
- [Substrate dependencies & freshness](substrate-dependencies.md) — the artifact dependency DAG, the 11 artifact classes, and the two staleness rules (newer-input mtime + fan-in membership) that say when a derived artifact must be recomputed
- [Survey + philosophy](survey-and-philosophy.md) — bootstrap-survey orchestrator, available designs (`progressive`, `essay`), decision-help posture, just-in-time disambiguation
- [Review pipeline](review.md) — fresh-context / different-AI-stack review, per-file frontmatter contract, `scripts/audit-review.sh`, and the two-assertion publish gate (review + cross-stack) at the push boundary
- [Workflow](workflow/index.md) — ariadne base layer: issue lifecycle, directory conventions (symlinked from ariadne)

## What this repo is not

- Not a candidate database — it's the *algorithm* that turns substrate + the user's philosophy into a vote recommendation
- Not a profile-building tool — the user's philosophy file grows organically across cycles via use, not via exhaustive surveys (see [survey-and-philosophy](survey-and-philosophy.md))
- Not a crowdsourced wiki — substrate is AI-curated with inline source citations + review pipeline (see [review](review.md))
