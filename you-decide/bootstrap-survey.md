---
name: bootstrap-survey
description: Use when a cold-start user (no philosophy file yet) needs to generate one. Orchestrates one of several named survey designs (see `surveys/<slug>.md`), then synthesizes the user's responses into a `philosophy-<user>.md` matching the shape of `philosophy-xian.md`. Designs vary in question count, shape (force-choice vs essay), and target user; pick per user / cycle / experiment.
generated-by: human
generated-on: 2026-05-28
review: passed
---

# bootstrap-survey

Generate a voter's philosophy file from an interactive survey. Designed for cold-start users who don't have a `philosophy-<user>.md` yet but want to use `you-decide` to evaluate this cycle's ballot.

This skill is an **orchestrator** — it picks among several survey designs in `surveys/<slug>.md`, runs the chosen one, and synthesizes the result. The designs themselves carry the question content + chat-follow-up rules.

## Available survey designs

| Slug | Description | Status | Target user |
|---|---|---|---|
| `progressive` | 5+5+5+3 questions across Headline + Issues + Deeper + Outliers rounds; force-choice options + outlier + free-form; progressive disclosure with stop points | stable | Prefers structured questions, comfortable with 5-15 questions |
| `essay` | 3 essay-style questions (fiscal/social/era) seeded with concrete examples + 3 cycle-specific outliers; intuition-first, no canned options | experimental | Prefers writing freely; willing to write a paragraph or two per question |

Adding a new design: drop a new `surveys/<slug>.md` following the shape of the existing two. The orchestrator picks it up automatically.

## Inputs

| Field | Required | Notes |
|---|---|---|
| `user` | yes | Slug for the user (used to name the output `philosophy-<user>.md`) |
| `year` | yes | Election cycle year (drives controversy selection) |
| `state` | yes | 2-letter state code |
| `sub-jurisdictions` | no | County/city slugs for local controversies |
| `design` | no | Survey design slug (default: `progressive`). Pick from `surveys/`. |
| `mode` | no | `interactive` (default) or `batch` |

## Output

`who-to-vote-for/philosophy-<user>.md` in the user's private brain, matching the shape of `philosophy-xian.md`:
- Frontmatter (date, topic, status: starting-point, design-used: <slug>)
- Overarching posture (prose synthesized from user's answers)
- Issue positions (from Tier 4 answers)
- What I look for in a candidate (from character / disqualifier answers)
- Hard limits (auto-reject conditions, opt-in only)

## Algorithm

### Stage 1 — Pick + load the design

- If `design` parameter given, load `surveys/<design>.md`.
- Otherwise default to `progressive` (the stable baseline).
- The design file's frontmatter + intro + question list + chat-follow-up rules + synthesis hints are the protocol for this run.

### Stage 2 — Compose with cycle data

For designs that reference cycle-specific composition (Round 2 and 4 in `progressive`, the 3 outliers in `essay`):
- Load `controversies/<year>/<state>.md` (per `[[identify-controversies]]`)
- Compose questions from `Survey-ready stance:` entries + candidate-side summaries
- Skip if cycle has no matching entries

### Stage 3 — Run the design

Follow the design file's question flow:
- `interactive`: present one question at a time
- `batch`: present a round at once

Apply the design's chat-follow-up rules. For `progressive`: continue-or-stop prompts between rounds. For `essay`: branch-on-surprise and branch-on-empty, bounded probes.

Collect responses (per-question or per-essay, plus any free-form text and follow-up exchanges).

### Stage 4 — Detect hard limits

If user expresses something that reads as a deal-breaker (*"I'd never vote for X"*, *"automatically disqualifying"*), flag it. Confirm with user before encoding as a hard-limit in the philosophy file — hard filters auto-reject; user should opt-in explicitly.

### Stage 5 — Synthesize philosophy-<user>.md

Per the design's synthesis hints + the general principles:

1. **Capture voice.** If user wrote free-form (essay design always; progressive's E options), preserve their specific phrasings ("game of playing favorite", "AI for bureaucracy"). Don't sanitize edge.
2. **Generate overarching-posture prose** from Tier 1/2/5 signals (3-5 paragraphs in user's voice if essays; tighter if force-choice).
3. **Generate issue-positions section** from Tier 4 signals (Round 2 in progressive; fiscal/social essays + cycle outliers in essay).
4. **Generate what-I-look-for** from character-axis + disqualifier signals.
5. **Generate hard-limits** section from explicit opt-ins (Stage 4).
6. **Frontmatter**: date, topic: political philosophy, status: starting-point, design-used: <slug>.

Output to `who-to-vote-for/philosophy-<user>.md`.

### Stage 6 — Confirm + iterate

Present the synthesized philosophy. User can:
- **Accept as-is** → done
- **Edit specific paragraphs** → re-synthesize affected sections
- **Add positions** → manual paragraph for an axis the design didn't cover

This iteration should be light if the design + synthesis worked. If positions are systematically wrong, the design (or specific questions) needs iteration — file an issue against `surveys/<slug>.md`.

## Cache / persistence + augment mode

The survey doesn't cache results for re-use — `philosophy-<user>.md` IS the persistent artifact, in the user's private brain.

**Re-running**:
1. Views shifted → user deletes/renames existing philosophy, runs from scratch (optionally a different design).
2. Augment → user stopped early in `progressive`, wants more rounds; re-run with `mode: augment` + same `design: progressive` — survey loads existing answers, presents only unanswered rounds.

## Picking a design (guidance)

| Situation | Recommended design |
|---|---|
| First-time user, no prior signal about preferences | `progressive` (safer default; canned options anchor) |
| User says "I just want to talk about this" or "I don't like multiple-choice" | `essay` |
| A/B testing the two designs against each other | one user gets each; compare synthesized philosophies for accuracy |
| Cycle with sparse controversies map (cold-start jurisdiction) | `progressive` (uses universal Round 3 even if Round 2/4 thin) |
| User has limited time / wants <5 questions | `essay` (3 + 3 max) |

When in doubt, ask the user before starting: *"Two question styles available — would you rather pick from canned options (5-15 questions) or write a few short essays (~6 questions)?"*

## Acceptance test (from brain#11 M3)

For the existing user Xian (hand-written `philosophy-xian.md` as ground truth), run a chosen design and compare reconstructed philosophy to hand-written. Acceptance = major positions on heavy axes match; voice differences are expected; gaps where the design didn't cover an axis are diagnostic of the design, not of the user.

The first run completed 2026-05-28 used the `progressive` design with Headline 5 + Round 2 (skipped Rounds 3-4): 7 axes captured cleanly, 0 real divergences (one apparent divergence on H1 was a measurement artifact — user clarified they didn't engage seriously with the question), 5 axes uncaptured because Round 3 was skipped, 3 new dimensions surfaced via free-form. This finding drove the `essay` design — intuition-first, no force-choice that can be clicked-through-casually.

## When NOT to use

- User already has `philosophy-<user>.md` → skip; use [[SKILL]] directly
- User wants comprehensive philosophy regardless of cycle → use `essay` (cycle-agnostic by design) or write by hand
- User has strong views + writing chops → skip survey; have them write `philosophy-<user>.md` directly

## Cross-references

- Available designs: `surveys/<slug>.md`
- Cycle data input: [[identify-controversies]]
- Universal question pool + anti-patterns + schema: [[question-bank]] (used by `progressive` design)
- Main algorithm consumes the output: [[SKILL]]
- Philosophy file shape: see existing `philosophy-xian.md` in `who-to-vote-for/`
- Hard-limits convention: declared in philosophy file; loaded by [[SKILL]]
