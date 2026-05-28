---
name: question-bank
description: Meta-documentation for designing survey questions in `surveys/<slug>.md`. Defines the schema for a question entry, anti-patterns to avoid, and guidance for adding new questions or designs. The actual questions live in `surveys/<slug>.md` (each design self-contained).
generated-by: human
generated-on: 2026-05-28
review: passed
---

# Question bank — meta-documentation

This file is **not** the source of survey questions anymore. The actual questions live in `surveys/<slug>.md` — each survey design is self-contained.

This file documents the schema for designing questions, the anti-patterns to avoid, and the general principles for adding new questions or new designs.

## Where questions actually live

| Design | File | Question shape |
|---|---|---|
| `progressive` | `surveys/progressive.md` | Force-choice (A/B/C/D/E with E=free-form), 5+5+5+3 across rounds |
| `essay` | `surveys/essay.md` | Open-ended essays seeded with concrete examples, 3+3 total |
| *future designs* | `surveys/<slug>.md` | Whatever shape the design calls for |

Cycle-specific Round 2 and Round 4 (in `progressive`) and cycle-outliers (in `essay`) are composed at runtime from `controversies/<year>/<state>.md` — they're not stored in the survey design file itself.

## Question entry schema (for force-choice questions in progressive)

```markdown
### Q<N>: <axis-tag> — <topic>

**Probes**: <which axis from the 5-tier taxonomy in SKILL.md>
**Cycle-relevance**: `universal` OR list of controversy slugs that gate it

> <Question text — concrete and specific, not abstract>

**Stance options:**
- A. <Typical stance A — one of the sides in actual debate>
- B. <Typical stance B — the other side>
- C. <Middle / nuanced position>
- D. <Outlier — less common but real view>
- E. Other — _free-form text_

**Synthesis hint**: <one line on how to convert the answer into philosophy prose>
```

## Question entry schema (for essay questions in essay design)

```markdown
## Q<N> — <axis category>

> <Open question framing>
>
> Some concrete examples to ground your thinking — answer some, all, or use them as prompts for your own:
> - <Concrete example 1>
> - <Concrete example 2>
> - ...
>
> <Invitation to write — "paragraph or two", "what comes to mind">
```

No canned options. The synthesizer reads the user's prose and extracts axis positions.

## Anti-patterns to avoid (in any design)

- **Likert-mush** ("on a scale of 1-5, how much do you support X?") — produces noise. Never use.
- **Leading framings** ("don't you think we should...") — biases the response.
- **Generic civics** ("should government provide healthcare?") — too abstract to differentiate this cycle's debates.
- **Combined dimensions in one force-choice question** (mixes housing-cost + tax-policy + environmental-stance) — split into separate questions. Exception: in essay designs, combined questions seeded with examples are fine since user writes prose covering multiple sub-axes.
- **Asking about settled issues** — if everyone in this cycle agrees, the question wastes budget.
- **Asking too many upfront** — respect attention budget. `progressive` mitigates via progressive-disclosure rounds; `essay` mitigates via fewer-but-deeper questions.
- **Stakes-clarity** ("this question measures your axis on X") — pushes users toward considered-policy mode and away from frank intuition. Counter-intuitively, *less* explanation of what's being measured invites more honest responses.
- **Putting cycle-specific framings inline in a design file** — cycle-specifics live in `controversies/<year>/<state>.md`; designs compose them at runtime.

## Stable-axis question pool (for force-choice designs)

The 5-tier axis taxonomy from [[SKILL]] defines the universal axes. For force-choice designs (like `progressive`), each axis can have ~1-3 stock questions that probe it. These are inlined directly in the design file — no central repository — to keep designs self-contained.

If you're writing a new force-choice design and need questions for an axis, copy the relevant Q from `surveys/progressive.md` and adapt.

## Adding a new survey design

1. Create `surveys/<slug>.md` following the shape of `surveys/progressive.md` or `surveys/essay.md`
2. Frontmatter: slug, description, status (`experimental` initially), target-user, generated-by, generated-on, review (`not-done` initially)
3. Intro to user, question list, chat-follow-up rules, synthesis hints
4. Update `bootstrap-survey.md`'s "Available survey designs" table with the new slug
5. Test on a real user; refine based on feedback; promote `experimental` → `stable` when proven

## Adding a new axis to the taxonomy

If a recurring controversy reveals a missing universal axis:
1. Update the 5-tier taxonomy in [[SKILL]]
2. Add stock probes (for force-choice designs) and concrete examples (for essay designs) to the relevant design files
3. Document the calibration skill that drove the addition

This is rare — the taxonomy is fairly stable. Most "new axes" are actually existing axes with novel framings, better captured via calibration skills than new axes.

## Cross-references

- Survey orchestrator: [[bootstrap-survey]]
- Specific designs: `surveys/<slug>.md`
- Axis taxonomy: [[SKILL]]
- Cycle-specific composition source: [[identify-controversies]]
