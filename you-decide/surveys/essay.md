---
slug: essay
description: 3 essay-style questions (fiscal / social / era-politics) seeded with concrete examples + 3 cycle-specific outliers. Intuition-first — no canned options, just free-form short essays. Chat follow-up only when surprised or genuinely empty.
status: experimental
target-user: prefers writing freely; doesn't want canned options; willing to write a paragraph or two per question
generated-by: human
generated-on: 2026-05-28
review: not-done
---

# Survey design: essay

3 open-ended essay questions + 3 cycle-specific outliers, total 6 questions. Each main question is seeded with concrete examples (rent control, gender-affirming care, Trump endorsement) to ground the abstraction; user writes a paragraph or two of intuition rather than picking canned options. The synthesizer agent reads the prose and extracts axis positions.

**Intuition-first framing is load-bearing.** We're after the gut response, not the considered-policy answer. Stakes-clarity ("this measures X") would actually hurt — it pushes users toward consequence-thinking and away from frank reaction.

## Intro to user

*"Three open questions, with concrete examples to ground each. Don't worry about being internally consistent, about consequences, or about whether your answer 'matches' anything. Just say what comes to mind — a paragraph or two per question. Bluntness is welcome; we're after your gut, not a position paper. After these three, I'll ask about a few cycle-specific debates if any are live for your state."*

## Q1 — Fiscal / government in the economy

> Government's role in the economy. Some concrete examples to ground your thinking — answer some, all, or use them as prompts for your own:
>
> - Should government control rent?
> - Should government protect the environment, and to what degree? (CEQA, EPA, carbon taxes)
> - Should home-building be governed by stringent rules, or only cover major defects?
> - Minimum wage — set high, set low, leave to market?
> - Should government subsidize housing for low-income families?
> - When is government intervention in markets useful (industrial policy, R&D funding) vs counterproductive (corruption, picking winners)?
>
> Write a small essay — a paragraph or two on what comes to mind.

## Q2 — Social / government in personal life

> Government's role in personal life. Some concrete examples — answer any, all, or your own:
>
> - Should government regulate gender-affirming care (for minors? for adults)?
> - Reproductive rights — government's role?
> - Drug use — full prohibition, regulated, decriminalized?
> - End-of-life — should assisted dying be legal?
> - Hate speech / misinformation — should government regulate online content?
> - Gun ownership — restrictions OK or basically untouchable right?
> - Religious influence in policy — when's it appropriate, when's it overreach?
>
> A paragraph or two on your default — when should government regulate personal choices, when should it stay out.

## Q3 — Era politics / current political moment

> The current political environment — Trump second term, polarized media, MAGA-vs-resistance dynamics, Israel/Gaza arguments, court-vs-executive fights. Some concrete examples:
>
> - A Republican who voted to certify 2020 but supports most Trump policy — how do you read them?
> - A Democrat who calls Israel's Gaza actions "genocide" vs one who says "self-defense and complicated" — what does each signal to you?
> - A candidate endorsed by Trump — does that change your read on them?
> - Local races where national tribal lines don't apply — does the calculation change?
> - A sheriff who refused COVID enforcement, or who tried to seize ballots — same category, or different?
>
> A paragraph or two on how you orient in the current era — what disqualifies, what reads as pragmatic survival theater vs genuine threat.

## Cycle-specific outliers (3, composed at runtime)

Drawn from `controversies/<year>/<state>.md` — pick the top-3 High-salience non-Tier-4 entries (the cycle-specific debates that don't surface organically from the 3 essays above). For each, present the controversy's framing + invite a paragraph response.

E.g., for CA 2026 the top-3 outliers might be:
- Billionaire self-funding (Steyer's $147M run)
- Charter schools vs teacher-union alignment
- Wealth-tax mechanism (Thurmond's billionaire asset tax)

Skip outliers that overlap with what the user already covered in the essays.

## Chat follow-up rules

Synthesizer probes ONLY in these cases:

- **Branch-on-surprise** — user mentions a NEW position not in standard taxonomy (e.g., "AI for bureaucracy"): ask 1-2 follow-ups to nail the position down
- **Branch-on-empty** — user gives 1-2 sentences without engaging the prompt: invite expansion ("any of the specific examples spark a reaction?")
- **Don't probe-to-explain** — never ask "say more about WHY you chose X" — that pushes toward considered-policy mode, away from intuition

Max 2 follow-ups per question. Keep total conversational time bounded.

## Synthesis

After all 3 essays + outliers collected:
1. Read essays as prose; extract positions per axis using natural-language understanding (not pattern-matching)
2. Map concrete-example references in user's prose to specific axis positions (e.g., "rent control is theft" → housing-zoning-realism +, anti-tax-spend +)
3. Capture novel framings verbatim in synthesized philosophy (e.g., "game of playing favorite", "AI for bureaucracy") — preserve voice
4. Detect hard-limit signals (e.g., "I'd never vote for X") and surface for confirmation
5. Write `philosophy-<user>.md` matching the shape of `philosophy-xian.md`

## What this design is for

Use this design for:
- Users who'd find canned options confining or who want to think out loud
- A/B testing against `progressive` to see which produces a more accurate philosophy reconstruction
- Cold-start users who haven't thought about their political philosophy systematically and benefit from open prompting

Use `progressive` instead for:
- Users who'd find a blank prompt intimidating
- Reproducibility / cross-user comparison studies
- Bootstrap of a new cycle when controversies aren't yet well-mapped
