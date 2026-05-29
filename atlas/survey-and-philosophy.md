# Survey + philosophy

How the user's political philosophy enters the system, and how it grows.

## Posture

**The goal is decision-help, not profile-building.** The bootstrap survey seeds a *sparse* philosophy file — enough to differentiate this cycle's candidates. Across cycles, the philosophy file grows organically. The user never sits through an exhaustive survey; they answer just-in-time questions when an axis would move a specific recommendation.

This shapes a few decisions:

- The shorter survey design (`essay`, ~6 questions) is the soft-default — not the longer one
- Questions are **intuition-first** (concrete examples, paragraph response invited) — stakes-clarity ("this measures X") is treated as an anti-pattern because it pushes users toward considered-policy mode and away from frank intuition
- Just-in-time disambiguation in [[SKILL]] Stage 3 is the primary growth mechanism, not the survey itself

## bootstrap-survey is an orchestrator

`you-decide/bootstrap-survey.md` doesn't carry the questions — it picks among **named survey designs** in `you-decide/surveys/<slug>.md` and runs the chosen one. Each design is self-contained: its frontmatter declares status, target user, generation provenance.

### Stage 0 — design selection

Before starting, present the user with available designs. Soft-push toward `essay` (simpler, captures more nuance, plays to the strength of chat-style AI). Default to `essay` if user doesn't pick explicitly.

### Available designs

| Slug | Shape | Status | Target user |
|---|---|---|---|
| `essay` | 3 essays (fiscal / social / era) seeded with concrete examples + 3 cycle outliers; no canned options | experimental | Prefers writing freely; willing to write a paragraph or two per question |
| `progressive` | 5+5+5+3 force-choice questions across Headline + Issues + Deeper + Outliers rounds, with `E. Other` free-form on each | stable | Prefers structured questions, comfortable with 5–15 questions |

Adding a new design: drop `you-decide/surveys/<slug>.md` following the shape of the existing two; the orchestrator picks it up automatically. Promote `experimental` → `stable` when real-user tests show it produces accurate philosophy reconstructions.

## Philosophy file shape

User-private, lives in the user's private dir (resolved by `scripts/private-dir.sh`): `<private-dir>/philosophy-<user>.md`. Sections:

- Overarching posture (prose, in the user's voice if essays were used)
- Issue positions (one paragraph per tier-4 axis the user has a position on)
- What I look for in a candidate (character + disqualifiers)
- Hard limits (auto-reject conditions, opt-in only)

Starts sparse. Acceptable — even encouraged — for axes to be absent. Stage 3 of [[SKILL]] handles axis-silence by either scoring 0 (when not load-bearing) or pausing to ask the user (when load-bearing for a race; see below).

## Just-in-time disambiguation (Stage 3, not survey)

The primary mechanism by which the philosophy file grows after bootstrap.

Trigger: during per-axis read generation, an axis is **load-bearing for this race** (two viable candidates differ substantively, the difference would move the recommendation) AND **silent in the philosophy** (neither the philosophy file nor any calibration skill gives a clear signal).

Action: pause and ask the user a focused essay-style question (concrete framing, examples, paragraph invited, stakes-implicit). Answer:
- Drives the per-axis score for this read immediately
- Gets appended to `philosophy-<user>.md` as a new paragraph (or new section if the axis didn't exist)
- Becomes permanent — applies to all future races and re-reads

Bar for asking: "would knowing this change the recommendation?" If not, score 0 and move on. Don't probe for general philosophy completeness.

## Disagreement loop (Stage 4) — the other growth mechanism

When the user pushes back on a per-axis read or aggregated recommendation, the correction crystallizes as a **calibration skill** (see [algorithm](algorithm.md#calibration-skills)). Affected `-read.md` files are re-scored.

Together, just-in-time disambiguation (proactive, fills gaps) and the disagreement loop (reactive, corrects the algorithm's interpretation) compound over cycles into a richer model of the user.

## Question design (meta)

`you-decide/question-bank.md` is *not* a source of questions anymore — the questions live in `surveys/<slug>.md`. It's meta-documentation:

- Schema for force-choice question entries (used by `progressive`)
- Schema for essay question entries (used by `essay`)
- Anti-patterns: Likert-mush, leading framings, generic civics, combined dimensions in one force-choice question, **stakes-clarity** (the counter-intuitive one), and asking about settled issues

Anyone adding a new design reads `question-bank.md` first to internalize the conventions, then writes `surveys/<their-slug>.md`.
