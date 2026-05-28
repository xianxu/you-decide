# Overview

`you-decide` helps a voter decide how to vote in local and non-presidential elections — where structured data thins out and most voters lack the time to read endorsements + candidate-statement PDFs themselves.

## Origin

Externalized from `brain/data/life/politics/who-to-vote-for/` in May 2026. Internal-tracking history (M0–M6) lives at `brain#11`; ongoing development tracked in `workshop/issues/`.

## Install models

Two ways to use the skill bundle:

| Mode | Use case | Substrate location |
|---|---|---|
| **Standalone** | Single user, no brain integration | Repo root; user creates their own `who-to-vote-for/` privately |
| **Brain-integrated** | User has an ariadne-styled `brain/` with private encrypted directories | Symlink at `brain/data/life/politics/you-decide/` → this repo; private deliberations in `brain/data/life/politics/who-to-vote-for/` |

The brain-integrated path keeps **shared substrate** (candidates, controversies, sources) in this repo's git history, **private deliberation** (the user's philosophy file, per-axis reads, vote.md) in the user's encrypted brain. Standalone collapses both into the user's local tree without the privacy boundary.

Brain integration via `go.mod` replace directive (parsed by ariadne's `construct/` setup script, not Go itself — convention borrowed from `nous/construct/go.mod`).

## Repo layout

```
you-decide/                # repo root
├── you-decide/            # skill bundle (agentskills.io shape)
│   ├── SKILL.md           # top-level algorithm
│   ├── resolve-ballot.md  # address → election manifest
│   ├── identify-controversies.md
│   ├── bootstrap-survey.md
│   ├── question-bank.md   # meta-doc for survey designers
│   ├── review.md
│   ├── surveys/           # named designs (progressive, essay, ...)
│   ├── calibration-skills/# shared judgments accumulated across users
│   └── templates/         # per-office axis weighting
├── candidates/<year>/<state>/<office>/<slug>.md  # genesis-tracked profiles
├── controversies/<year>/<state>.md
├── elections/<year>/<YYYY-MM-DD>-<state>-<scope>.md   # election-day-keyed ballot manifests
├── sources/<US|state>.md  # authoritative source registries, composed at runtime
├── reviews/<year>/<date>-<batch>.md
├── workshop/              # ariadne convention — issues, plans, history, lessons
├── atlas/                 # this directory
├── construct/             # ariadne base layer (vendored)
└── scripts/audit-review.sh
```

The inner `you-decide/` folder is the **skill bundle** — agentskills.io compatible (SKILL.md at the folder root, sub-skills as siblings). Everything else at the repo root is **substrate** the skill operates on.

## Cross-references

- Algorithm flow: [algorithm](algorithm.md)
- Substrate detail: [substrate](substrate.md)
- Survey: [survey-and-philosophy](survey-and-philosophy.md)
- Review: [review](review.md)
- Workflow (issues, plans, lessons): [workflow](workflow/index.md) — symlinked from ariadne
