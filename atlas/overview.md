# Overview

`you-decide` helps a voter decide how to vote in local and non-presidential elections — where structured data thins out and most voters lack the time to read endorsements + candidate-statement PDFs themselves.

## Origin

Extracted from a private brain into this standalone public repo in May 2026 — which is why no user-specific paths or identities are baked into the substrate (see [[substrate]] on the private dir). Internal-tracking history (M0–M6) lives at `brain#11`; ongoing development tracked in `workshop/issues/`.

## Install models

Two ways to use the skill bundle. In both, **private deliberation lives outside the repo** — the difference is only *where* outside. The private dir is resolved by `scripts/private-dir.sh`: `$YOU_DECIDE_PRIVATE_DIR` if set, else `<repo-root>/../who-to-vote-for`.

| Mode | Use case | Private dir |
|---|---|---|
| **Standalone** | Single user, no brain integration | `../who-to-vote-for` (sibling of the repo), or `$YOU_DECIDE_PRIVATE_DIR` |
| **Brain-integrated** | User has an ariadne-styled `brain/` with private encrypted directories | `brain/data/life/politics/who-to-vote-for/` — the `who-to-vote-for` sibling of the you-decide mount declared in the brain's `construct/deps`. Reached via the symlink at `brain/data/life/politics/you-decide/`; `$YOU_DECIDE_PRIVATE_DIR` is an optional override. |

Both keep **shared substrate** (candidates, controversies, sources) in this repo's git history and **private deliberation** (the user's philosophy file, per-axis reads, vote.md) in the resolved private dir. The standalone default is a *sibling* of the repo, not inside it, so the privacy boundary holds either way — a `git push` of this repo can never carry private state.

Brain integration is declared in the brain's `construct/deps` as a `data <url> <mount>` row (`data git@github.com:…/you-decide.git data/life/politics/you-decide`), cloned + symlinked by ariadne's `construct/` setup. That row is the brain's canonical anchor for *where you-decide lives*, from which the private dir is derived as the `who-to-vote-for` sibling — so no env var is needed in a brain (it stays available as an override).

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
│   └── data/templates/         # per-office axis weighting
├── data/candidates/<year>/<state>/<office>/<slug>.md  # genesis-tracked profiles
├── data/controversies/<year>/<state>.md
├── data/elections/<year>/<YYYY-MM-DD>-<state>-<scope>.md   # election-day-keyed ballot manifests
├── data/sources/<US|state>.md  # authoritative source registries, composed at runtime
├── data/reviews/<year>/<date>-<batch>.md
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
