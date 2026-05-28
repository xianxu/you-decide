---
slug: progressive
description: 5-question Headline (always asked) + opt-in Rounds 2 (cycle Issues), 3 (Deeper nuance), 4 (Cycle outliers). Force-choice stance options + outlier + free-form per question. Progressive disclosure with continue-or-stop prompts between rounds.
status: stable
target-user: prefers structured questions with canned options; comfortable answering 5-15 questions across rounds
generated-by: human
generated-on: 2026-05-28
review: passed
---

# Survey design: progressive

5+5+5+3 questions across four rounds with explicit stop points. Each question presents 3-4 typical stance options drawn from the actual sides in the cycle's debate, plus an outlier option (less common views), plus free-form "Other". User can stop after any round; even Headline-only produces a usable (coarse) philosophy.

## Intro to user

*"I'll ask up to ~5 questions covering the major dimensions of political identity, then offer you the option to go deeper. Each has a few typical stances to pick from + an 'other' for free-form. You can stop after any round. We're trying to build your philosophy file from your answers — it'll be used as your reference for evaluating candidates in future races."*

## Round 1 — Headline (5 questions, always asked)

These capture the major political-identity dimensions: party-tribal realignment, economic philosophy, social orientation, institutional posture, builder-vs-regulator.

### H1: Personalist-strongman posture [era-current: Trump]

> A candidate is endorsed by a national figure you view as personally dangerous (the current example: **Donald Trump**). How does that endorsement affect your willingness to vote for them?

- **A.** Disqualifying — the endorsement reveals who they really are. I won't vote for endorsees regardless of policy.
- **B.** Tolerable in moderation — many candidates cater to the era's dominant figure for political survival; I can distinguish cater from conviction.
- **C.** Irrelevant — endorsements aren't the candidate. I vote on the candidate's own record.
- **D.** Positive signal — I align with the endorser's general direction even if specific policies differ.
- **E.** Other — _free-form_

**Synthesis hint**: A → strong anti-personalist hard filter. B → tolerate cater-mode (triggers `trump-era-cater-discount`). D → endorser-positive disposition.

### H2: Fiscal disposition

> When government wants to fund a "worthy cause" (housing, transit, climate, education) via a new tax or bond measure, what's your default?

- **A.** Skeptical — figure out why current spending isn't working before adding more.
- **B.** Supportive if the cause is genuinely worthy and the funding mechanism is reasonable.
- **C.** Depends entirely on the specific measure — case by case.
- **D.** Generally supportive of revenue raises — government underfunds important things.
- **E.** Other — _free-form_

### H3: Social orientation

> Government regulation of personal choices (gender expression, family structure, reproductive rights, substance use, end-of-life decisions):

- **A.** Government should stay out. These are personal choices.
- **B.** Government has a legitimate role in maintaining traditional norms.
- **C.** Government should protect vulnerable parties but otherwise stay out.
- **D.** Government should actively expand individual rights and protections.
- **E.** Other — _free-form_

### H4: Institutional integrity

> A candidate has actively tried to interfere with election machinery (attempted to seize ballots, blocked vote certification, pushed for voter-roll purges beyond standard procedure). How does that affect your vote?

- **A.** Disqualifying — full stop, regardless of their other positions.
- **B.** Heavy negative, but not auto-disqualifying.
- **C.** Concerning if I think it's bad-faith, OK if I think it's a good-faith pushback.
- **D.** Not particularly concerning.
- **E.** Other — _free-form_

### H5: Government's role — builder vs regulator

> The US has slowed down its ability to build (housing, transit, energy infrastructure) relative to countries like China or to its own past. The main culprit:

- **A.** Environmental and procedural regulations gone too far — fix forward, don't stop building.
- **B.** Underfunded public capacity — need more public investment.
- **C.** Bad governance / corruption — the rules aren't the problem; implementation is.
- **D.** Capitalism / private interests blocking public goods.
- **E.** Other — _free-form_

---

**↓ Between Headline and Round 2:** *"Want to keep going? Round 2 is ~5 questions on this cycle's specific issues. Or stop here — coarse philosophy gets filled in per-race."*

## Round 2 — Issues (~5, cycle-specific, composed at runtime)

Drawn from `controversies/<year>/<state>.md` — High-salience Tier-4 controversy entries. Each entry generates one question:
- Question text = controversy's `Survey-ready stance:` line
- Stance options = drawn from side-A/B/middle/outlier candidate-position summaries
- Synthesis hint = tier/axis tag from controversy entry

Skip Round 2 entirely if cycle has no Tier-4 entries.

---

**↓ Between Round 2 and Round 3:** *"Next round is ~5 deeper questions on character, economic mechanism, social values."*

## Round 3 — Deeper nuance (~5 universal questions)

### R3-1: Character — coherence vs policy fit

> When choosing between candidates, how much does *coherence of thought* matter to you relative to *whether they hit your policy buttons*?

- **A.** Coherence is decisive — I'd rather support someone clearly thought-through, even if I disagree.
- **B.** Policy is decisive — I need someone who'll vote the way I want.
- **C.** Both equally.
- **D.** Neither — I vote tribal / party-line.
- **E.** Other — _free-form_

### R3-2: Anti-hypocrisy / flawed-honest preference

> A candidate with documented flaws (extramarital affair, old ethics violations, off-the-cuff offensive remarks) vs. a polished candidate who's evasive when you push them on actual positions. Bigger red flag?

- **A.** The polished/evasive one — I'd rather work with someone whose flaws are known.
- **B.** The flawed one — character matters; old transgressions show what they're capable of.
- **C.** Depends on how old the flaws are.
- **D.** Neither bothers me much — I vote on policy alone.
- **E.** Other — _free-form_

### R3-3: Worker protection mechanism

> The power asymmetry between corporations and workers is real. Best mechanism:

- **A.** Stronger unions and collective bargaining.
- **B.** Structural — government-funded investment accounts for every newborn (e.g., baby S&P 500 fund).
- **C.** Better labor regulation — minimum wage, OSHA, anti-discrimination.
- **D.** Markets correct themselves; minimal intervention.
- **E.** Other — _free-form_

### R3-4: Education investment focus

> Investment in education — which deserves the most focus?

- **A.** Early-childhood (universal pre-K, ECE access).
- **B.** K-12 — teacher pay, smaller classes.
- **C.** Higher education — financial aid, free community college.
- **D.** School choice — vouchers, charters, parent-controlled.
- **E.** Other — _free-form_

### R3-5: Work and opportunity

> Personal responsibility vs. structural opportunity in success outcomes:

- **A.** People should work; US offers genuine opportunity — but lottery of birth is real, investing in those people matters.
- **B.** People who succeed largely earned it; people who fail largely failed themselves.
- **C.** Success is mostly structural — class, race, location.
- **D.** Both matter equally.
- **E.** Other — _free-form_

---

**↓ Between Round 3 and Round 4:** *"Want to answer cycle-specific outlier questions? Or stop — your philosophy is fairly complete."*

## Round 4 — Cycle outliers (composed at runtime)

Drawn from `controversies/<year>/<state>.md` — High-salience non-Tier-4 entries (anti-hypocrisy meta, capture-risk, election-integrity-as-tier-2-violation, etc.). Same composition as Round 2. Skip if cycle has none.

## Synthesis

After whichever rounds the user completed:
1. Group answers by tier-axis using the synthesis hints
2. Generate prose overarching-posture from Tier 1/2/5 answers
3. Generate issue-positions section from Tier 4 (Round 2) answers
4. Detect any hard-limit opt-ins (e.g., H4-A) and surface for confirmation
5. Write `philosophy-<user>.md` matching the shape of `philosophy-xian.md`

## Anti-patterns

- **Likert-mush** ("on a scale of 1-5"): produces noise, never use
- **Leading framings** ("don't you think we should..."): biases response
- **Generic civics** ("should government provide healthcare?"): too abstract for cycle differentiation
- **Combined dimensions in one question**: split into separate questions
- **Asking about settled issues**: wastes survey budget if everyone in cycle agrees
