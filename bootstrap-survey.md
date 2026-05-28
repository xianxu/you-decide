---
name: bootstrap-survey
description: Use when a cold-start user (no philosophy file yet) needs to generate one. Runs a curated short survey (~8-12 questions) drawn from the cycle's actual controversies, then synthesizes responses into a `philosophy-<user>.md` that matches the shape of `philosophy-xian.md`. Each question offers typical-position force-choices, an outlier alternative, and free-form input — captures real stances without leading the user.
generated-by: human
generated-on: 2026-05-28
review: passed
---

# bootstrap-survey

Generate a voter's philosophy file from a short interactive survey. Designed for cold-start users who don't have a `philosophy-<user>.md` yet but want to use `you-decide` to evaluate this cycle's ballot.

## Why this exists

A returning user has `philosophy-<user>.md` and the algorithm scores candidates against it. A cold-start user has nothing — we need to elicit their values fast enough that they actually finish the survey, and well enough that the result captures their real positions rather than a sanitized centrist version.

The survey is *short* (~8-12 questions, not 40), *focused* on this cycle's actual controversies (no questions about settled issues), and *force-choice-with-escape-hatch* (typical positions + outlier option + free-form). Each question is drawn from [[question-bank]] and curated by [[identify-controversies]].

## Inputs

| Field | Required | Notes |
|---|---|---|
| `user` | yes | Slug for the user (used to name the output `philosophy-<user>.md`) |
| `year` | yes | Election cycle year (drives controversy selection) |
| `state` | yes | 2-letter state code |
| `sub-jurisdictions` | no | County/city slugs for local controversies |
| `mode` | no | `interactive` (default — present questions one by one) or `batch` (present all at once for user to fill in) |

## Output

`who-to-vote-for/philosophy-<user>.md` in the user's private brain, mirroring the shape of `philosophy-xian.md`:
- Frontmatter (date, topic, status: starting-point)
- Overarching posture (prose paragraphs synthesized from Tier 1/2/5 answers)
- Issue positions (from Tier 4 answers — drawn from cycle's controversies)
- What I look for in a candidate (from Tier 1 character answers)
- Hard limits (auto-reject conditions — only if user explicitly designates one in the survey)

## Algorithm

### Stage 1 — Load context

Two sources:
- [[question-bank]] → **universal** (cycle-stable) questions: Headline (5) + Round 3 deeper (~5-6). These probe timeless axes like Trump-personalist-posture (era-parameterized), fiscal disposition, social orientation, institutional integrity.
- [[identify-controversies]] output for `(year, state, sub-jurisdictions)` → **cycle-specific** questions: each High-salience controversy entry has a `Survey-ready stance:` line + candidate-side-A/B summaries that compose into a question at runtime. Tier-4 controversies → Round 2 (Issues). Non-Tier-4 controversies → Round 4 (Outliers).

### Stage 2 — Compose rounds + present (progressive disclosure)

Survey is structured as **rounds**. Each round is presented, then user is asked whether to continue or stop. The philosophy file is synthesized from whatever's been answered — partial is fine.

**Composition** (which source feeds which round):

| Round | Source | Content |
|---|---|---|
| **Round 1 — Headline** | [[question-bank]] Headline | 5 universal questions: personalist-posture, fiscal disposition, social orientation, institutional integrity, builder-vs-regulator |
| **Round 2 — Issues** | [[identify-controversies]] Tier-4 High-salience entries | ~5 cycle-specific issue questions: each Tier-4 controversy generates one question (text = `Survey-ready stance:`; options = sides-A/B/middle/outlier from candidate-position summaries) |
| **Round 3 — Deeper** | [[question-bank]] Round 3 | ~5-6 universal questions on character, economic mechanism, social values |
| **Round 4 — Outliers** | [[identify-controversies]] non-Tier-4 High-salience entries | Cycle-specific outliers (anti-hypocrisy meta, capture-risk, etc.); composed same as Round 2 |

**Between rounds, prompt:** *"Want to keep going? Next round is ~N questions on [topic]. Or stop here — you can always come back later in `augment mode` to add more."*

User can stop after any round. Headline alone produces a coarse-but-usable philosophy (overarching posture + character + hard-limits are solid; issue-positions section will be sparse and gets filled in per-race as needed).

### Stage 3 — Present each question

For each question, present:
1. The question text (specific, concrete — not "do you support criminal-justice reform")
2. 3-4 typical-stance options (drawn from the actual sides in cycle's debate — see [[identify-controversies]])
3. An "outlier / less common" option that captures common-but-non-mainstream views (libertarian, socialist, religious-traditionalist, etc., as appropriate)
4. "Other" with free-form text input

**Mode `interactive`**: present one question at a time within a round, wait for response, move on. Allows clarifying questions. Between rounds, prompt for continue/stop.
**Mode `batch`**: present whole round at once with response slots, user fills in. Between rounds, same continue/stop prompt.

Collect: per-question (round, option-selected, optional free-form text).

### Stage 4 — Detect hard limits

If user picks an option phrased as a deal-breaker (e.g., *"I'd disqualify any candidate who has actively interfered with election machinery"*), flag it as a candidate hard-filter for the philosophy's "Hard limits" section. Confirm with user before encoding (hard filters auto-reject; user should opt-in explicitly).

### Stage 5 — Synthesize philosophy-<user>.md

Generate prose that reads like the user wrote it, not like a template fill-in. Steps:

1. **Overarching posture prose**: From Tier 1/2/5 answers, generate 3-5 paragraphs of values prose. Use the user's free-form text where present (captures their voice). Don't sanitize edge — if user picked sharp positions, prose should reflect that.

2. **Issue positions section**: From Tier 4 answers, generate one paragraph per issue area. Cite the user's chosen stance verbatim where possible.

3. **What I look for in a candidate**: From Tier 1 answers, generate the closing posture statement (e.g., for Xian: *"Generally I favor smart, logically consistent people"*).

4. **Hard limits**: Encode any deal-breakers the user opted into (Stage 4).

5. **Frontmatter**: date, topic: political philosophy, status: starting-point.

Output written to `who-to-vote-for/philosophy-<user>.md`.

### Stage 6 — Confirm + iterate

Present the synthesized philosophy to the user. They can:
- **Accept as-is** → done
- **Edit specific paragraphs** → re-synthesize with corrections
- **Add positions** → if a Tier 4 issue the user cares about wasn't asked (because it wasn't a cycle controversy), add it manually as a paragraph

This iteration is light — major positions should be right from the answers; only fine-tuning needed.

## Question format (from [[question-bank]])

```markdown
### Q<N>: <axis-tag> — <topic>

**Probes**: <which axis from the taxonomy>
**Cycle-relevance**: <which controversies trigger this; "universal" if always asked>

> <Question text — concrete and specific, not abstract>

**Stance options:**
- A. <Typical stance A — one of the sides in the cycle's actual debate>
- B. <Typical stance B — the other side>
- C. <Middle / nuanced position>
- D. <Outlier — less common but real view>
- E. Other — _free-form text_

**Synthesis hint**: <one line on how to convert the answer into philosophy prose>
```

## Cache / persistence + augment mode

The survey **doesn't cache the result for re-use** — it's a one-time bootstrap. The output (`philosophy-<user>.md`) IS the persistent artifact and lives in the user's private brain.

**Re-running** (two cases):

1. **Views shifted**: user deletes or renames existing `philosophy-<user>.md` and runs from scratch. Old one stays as `philosophy-<user>-<date>.md` for reference.

2. **Augment**: user stopped early (e.g., after Headline only) and wants to answer more rounds later. Re-run with `mode: augment` — the survey loads existing philosophy, skips questions already answered, presents next round(s).

## Acceptance test (from issue 000011)

Run on Xian (the existing user with hand-written `philosophy-xian.md`). For the 2026 CA cycle, the curated survey should ask ~8-12 questions covering housing-CEQA, energy-cost, public-safety-strict-but-care, Trump-cater discount, election-integrity-as-hard-filter, billionaire-self-funding, charter-vs-union, healthcare-basic-tier.

Xian's answers from his existing philosophy:
- Housing-CEQA: reform-not-eliminate (matches Tier 4 housing-zoning-realism +)
- Energy-cost: cost-down-not-just-green (climate-adapt)
- Public-safety: strict-but-care
- Trump-cater: tolerate cater-mode, won't vote Trump-personalist
- Billionaire-self-funding: would need to ask (no explicit philosophy text)
- Healthcare: basic-tier, not heroic
- etc.

Acceptance: reconstructed philosophy from these answers should match major positions in hand-written `philosophy-xian.md`. Voice will differ (synthesis output won't have Xian's specific phrasings like *"defund police people are idiots"* unless he uses free-form). **Positions are the test, not voice.**

Iteration: if a position is missed or wrong, refine the question bank — the question for that axis was bad, not the user.

## When NOT to use

- User already has `philosophy-<user>.md` — skip; use [[SKILL]] directly
- User wants comprehensive philosophy regardless of cycle (e.g., for general self-knowledge, not voting) — use a longer survey not constrained by cycle controversies
- User has strong views and wants to write their philosophy by hand — skip; just have them write it

## Cross-references

- Controversy input: [[identify-controversies]]
- Question bank: [[question-bank]]
- Main algorithm consumes the output: [[SKILL]]
- Philosophy file shape: see existing `philosophy-xian.md` in `who-to-vote-for/`
- Hard-limits convention: declared in philosophy file; loaded by [[SKILL]]
