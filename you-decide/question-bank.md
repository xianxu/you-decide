---
name: question-bank
description: Universal (cycle-independent) question pool used by bootstrap-survey. Covers the timeless axes — character, fiscal disposition, social orientation, institutional integrity, builder-vs-regulator, plus deeper nuance. Cycle-specific issue questions and outliers are NOT here — they're composed at runtime from `controversies/<year>/<state>.md`.
generated-by: human
generated-on: 2026-05-28
review: passed
---

# Question bank — universal

This file holds **universal, era-stable** survey questions. Cycle-specific and location-specific questions (housing-CEQA in CA, billionaire-self-funding for the Steyer cycle, etc.) are NOT here — they live in `controversies/<year>/<state>.md` and are composed into the survey at runtime by [[bootstrap-survey]].

## Composition at runtime

[[bootstrap-survey]] builds the rounds by composing two sources:

| Round | Source | Notes |
|---|---|---|
| **Round 1 — Headline** | This file (Headline section) | Always asked. ~5 questions. The Trump-posture question is parameterized — see "Era-parameterization" below. |
| **Round 2 — Issues** | `controversies/<year>/<state>.md` Tier-4 entries | Cycle-specific. Each High-salience Tier-4 controversy → one question, generated from the entry's `Survey-ready stance:` + candidate-position sides. |
| **Round 3 — Deeper** | This file (Round 3 section) | Always available. ~5-6 questions on character, economic mechanism, social values. |
| **Round 4 — Cycle outliers** | `controversies/<year>/<state>.md` non-Tier-4 entries | Cycle-specific. Each High-salience non-Tier-4 controversy (anti-hypocrisy meta-issues, capture-risk, etc.) → one question. |

Each question — whether universal or composed — follows the same format: question text + 3-4 typical stance options (drawn from real-debate sides) + outlier option (captures less-mainstream views) + free-form "Other".

## Era-parameterization

Some universal questions reference a "current example" for an era-defining figure or dynamic. Example: H1 references *"the current example: Donald Trump"* because Trump-personalism is the dominant axis-instance in the 2025-2030 era. When the era shifts:

- **Edit this file** to update the example (e.g., "the current example: [next personalist figure]"). Git history preserves old framings.
- For multi-era support (e.g., running the survey on a 2010 election), use git checkout of the appropriate era's question-bank.
- Era-overlay folder structure (`question-bank/era-trump-2025-2030.md`, `question-bank/era-post-trump.md`) is an option if the codebase grows to support concurrent eras — but premature now.

Era-parameterized questions are marked with **[era-current: <axis>]** so they're easy to find when an era shifts.

---

## Headline (5 questions — always asked)

These five capture the largest signal-per-question on the major dimensions of current US political identity: party-tribal realignment, economic philosophy, social orientation, institutional posture, and government's posture toward building vs. regulating. A voter who answers only these gets a usable but coarse philosophy.

### H1: Personalist-strongman posture **[era-current: anti-personalist-strongman]**
**Probes**: anti-personalist-strongman (Tier 1)
**Cycle-relevance**: universal

> A candidate is endorsed by a national figure you view as personally dangerous (the current example: **Donald Trump**). How does that endorsement affect your willingness to vote for them?

**Stance options:**
- A. Disqualifying — the endorsement reveals who they really are. I won't vote for endorsees regardless of policy.
- B. Tolerable in moderation — many candidates cater to the era's dominant figure for political survival; I can distinguish cater from conviction.
- C. Irrelevant — endorsements aren't the candidate. I vote on the candidate's own record.
- D. Positive signal — I align with the endorser's general direction even if specific policies differ.
- E. Other — _free-form_

**Synthesis hint**: A → strong anti-personalist + "wouldn't vote for [figure]-aligned." B → "tolerate cater-mode, reject personalist" (triggers `trump-era-cater-discount` skill applicability). D → endorser-positive disposition.

---

### H2: Fiscal disposition
**Probes**: fiscally-conservative / grow-pie-before-spending (Tier 3)
**Cycle-relevance**: universal

> When government wants to fund a "worthy cause" (housing, transit, climate, education) via a new tax or bond measure, what's your default?

**Stance options:**
- A. Skeptical — figure out why current spending isn't working before adding more; bonds and cause-taxes are the lazy answer.
- B. Supportive if the cause is genuinely worthy and the funding mechanism is reasonable.
- C. Depends entirely on the specific measure — case by case.
- D. Generally supportive of revenue raises — government underfunds important things.
- E. Other — _free-form_

**Synthesis hint**: A → "don't like just tax and spend; grow the pie first." D → expansive-government leaning.

---

### H3: Social orientation
**Probes**: socially-liberal + leave-people-alone (Tier 5 + Tier 2)
**Cycle-relevance**: universal

> Government regulation of personal choices (gender expression, family structure, reproductive rights, substance use, end-of-life decisions):

**Stance options:**
- A. Government should stay out. These are personal choices; leave people alone.
- B. Government has a legitimate role in maintaining traditional norms even when specific harms are unclear.
- C. Government should protect vulnerable parties (minors, disabled) but otherwise stay out.
- D. Government should actively expand individual rights and protections.
- E. Other — _free-form_

**Synthesis hint**: A → "leaving people alone" + socially liberal. B → traditional / conservative. C → moderate-libertarian. D → progressive-activist.

---

### H4: Institutional integrity
**Probes**: institutionalist / procedural-justice (Tier 2)
**Cycle-relevance**: universal

> A candidate has actively tried to interfere with election machinery (attempted to seize ballots, blocked vote certification, pushed for voter-roll purges beyond standard procedure). How does that affect your vote?

**Stance options:**
- A. Disqualifying — full stop, regardless of their other positions.
- B. Heavy negative, but not auto-disqualifying — if they're way better than alternatives on everything else, I might still vote for them.
- C. Concerning if I think it's bad-faith, OK if I think it's a good-faith pushback against a flawed system.
- D. Not particularly concerning — election administration is contested, candidates can have views on it.
- E. Other — _free-form_

**Synthesis hint**: A → encode as hard-limit in philosophy. B → strong negative on institutionalist axis. C/D → no institutionalist axis weight.

---

### H5: Government's role — builder vs. regulator
**Probes**: builder-mentality (Tier 3)
**Cycle-relevance**: universal

> The US has slowed down its ability to build (housing, transit, energy infrastructure) relative to countries like China or to its own past. The main culprit:

**Stance options:**
- A. Environmental and procedural regulations gone too far — we need to fix things forward, not stop building.
- B. Underfunded public capacity — we need more public investment to build.
- C. Bad governance / corruption — the rules aren't the problem; implementation is.
- D. Capitalism / private interests blocking public goods.
- E. Other — _free-form_

**Synthesis hint**: A → strong builder-mentality. B → progressive-build orientation. C → governance-focused. D → progressive-anti-corporate.

---

**↓ Between rounds: *"Want to go deeper? Round 2 is ~5 questions on this cycle's specific issues (drawn from the controversies in your area). Or stop here — coarse philosophy gets filled in per-race."***

---

## Round 2 — Issues (cycle-specific, composed at runtime)

**Not in this file.** Round 2 questions are composed from `controversies/<year>/<state>.md` — specifically, each High-salience Tier-4 controversy entry generates one question:
- **Question text** = controversy's `Survey-ready stance:` line
- **Stance options** = drawn from the controversy's Side-A / Side-B / middle / outlier candidate-position summaries
- **Synthesis hint** = tier/axis tag from the controversy entry

Skip Round 2 entirely if the cycle's controversies map has no Tier-4 entries (rare but possible for special elections with no policy races).

---

**↓ Between rounds: *"Next round is ~5 deeper questions on character, economic mechanism, and social values."***

---

## Round 3 — Deeper nuance (~5-6 universal questions)

Fine-tunes the philosophy beyond Headline broad strokes. Drawn from Tier 1 (character beyond personalist-posture), Tier 3 (economic-mechanism beyond fiscal direction), Tier 5 (social-values beyond orientation).

### R3-1: Character — coherence vs policy fit
**Probes**: smart-and-logically-consistent (Tier 1)
**Cycle-relevance**: universal

> When choosing between candidates, how much does *coherence of thought* matter to you relative to *whether they hit your policy buttons*?

**Stance options:**
- A. Coherence is decisive. I'd rather support someone who's clearly thought through their positions, even if I disagree with several, than a button-hitter who seems opportunistic.
- B. Policy is decisive. Coherence is nice-to-have, but I need someone who'll actually vote the way I want.
- C. Both matter equally — I weigh them together.
- D. Neither — I vote tribal / party-line because individual-candidate evaluation isn't worth the time.
- E. Other — _free-form_

**Synthesis hint**: A → "I favor smart, logically consistent people." D → don't write a smart/consistent paragraph at all.

---

### R3-2: Anti-hypocrisy / flawed-honest preference
**Probes**: anti-hypocrisy (Tier 1)
**Cycle-relevance**: universal

> A candidate with documented flaws (extramarital affair, old ethics violations, off-the-cuff offensive remarks) vs. a polished candidate who's evasive when you push them on their actual positions. Which is the bigger red flag?

**Stance options:**
- A. The polished/evasive one. I'd rather work with someone whose flaws are known — I can model their motivations. Evasion means I don't know their true views.
- B. The flawed one. Character matters; old transgressions show what they're capable of.
- C. Depends on how old the flaws are — decades-old + fully aired is less concerning than recent + hidden.
- D. Neither bothers me much; I vote on policy alone.
- E. Other — _free-form_

**Synthesis hint**: A → "allergic to hypocrisy; prefer flawed-honest." A+C → captures `aged-flaws-discount` instinct.

---

### R3-3: Worker protection mechanism
**Probes**: anti-union-pro-ownership-floor (Tier 3)
**Cycle-relevance**: universal

> The power asymmetry between corporations and workers is real. The best mechanism to address it:

**Stance options:**
- A. Stronger unions and collective bargaining.
- B. Structural — government-funded investment accounts for every newborn (e.g., baby S&P 500 fund), paid out at milestones, building an ownership floor.
- C. Better labor regulation — minimum wage, OSHA, anti-discrimination enforcement.
- D. Markets correct themselves; minimal intervention needed.
- E. Other — _free-form_

**Synthesis hint**: A → pro-union. B → structural-ownership-floor. C → standard progressive labor. D → libertarian.

---

### R3-4: Education investment
**Probes**: education-investment (Tier 5)
**Cycle-relevance**: universal

> Investment in education — which deserves the most focus?

**Stance options:**
- A. Early-childhood (universal pre-K, ECE access). Highest-leverage investment in equity and human capital.
- B. K-12 — teacher pay, smaller classes, more resources for existing schools.
- C. Higher education — financial aid, free community college.
- D. School choice — vouchers, charters, parent-controlled.
- E. Other — _free-form_

**Synthesis hint**: A → early-ed focus. D → school-choice / pro-charter. B/C → standard progressive-ed.

---

### R3-5: Work and opportunity
**Probes**: work + opportunity belief (Tier 5)
**Cycle-relevance**: universal

> Personal responsibility vs. structural opportunity in success outcomes:

**Stance options:**
- A. People should work, and the US offers genuine opportunity. But the lottery of birth and womb is real — investing in those people (especially via education) is important.
- B. People who succeed largely earned it; people who fail largely failed themselves. Government safety nets create dependency.
- C. Success is mostly structural — class, race, location. Personal effort is overrated as a cause.
- D. Both matter equally; programs should support both effort and opportunity.
- E. Other — _free-form_

**Synthesis hint**: A → "believe in work AND in structural-opportunity-investment." B → rugged individualist. C → structuralist progressive.

---

**↓ After Round 3: *"Want to answer cycle-specific outlier questions? These are debates that surfaced this cycle but don't fit a universal axis (e.g., billionaire-self-funding, charter-vs-union). Or stop here — your philosophy is fairly complete."***

---

## Round 4 — Cycle outliers (cycle-specific, composed at runtime)

**Not in this file.** Round 4 questions are composed from `controversies/<year>/<state>.md` — High-salience non-Tier-4 entries (anti-hypocrisy meta-issues, capture-risk, election-integrity-as-tier-2-violation, etc.). Same composition shape as Round 2.

If the cycle has no non-Tier-4 outliers, skip Round 4.

---

## Adding new universal questions

When a new TIMELESS axis emerges (rare — the 5-tier taxonomy is fairly stable), add a question here:

1. Identify the axis from the [[SKILL]] 5-tier taxonomy
2. Decide round: Headline (only if it captures a major political-identity dimension) or Round 3 (universal but finer-grained)
3. Draft 3-4 typical stance options
4. Add outlier option (libertarian, socialist, traditionalist as appropriate)
5. Always include free-form "Other"
6. Write synthesis hint
7. If era-parameterized, mark `[era-current: <axis>]` and note in "Era-parameterization" section above

For cycle-specific questions, **don't add them here**. Add the controversy to `controversies/<year>/<state>.md` with a `Survey-ready stance:` line; bootstrap-survey will compose at runtime.

## Anti-patterns to avoid

- **Likert-mush**: "On a scale of 1-5, how much do you support X?" produces noise.
- **Leading framings**: "Don't you think we should..."
- **Generic civics**: "Should government provide healthcare?" — too abstract to differentiate this cycle's debates.
- **Combined dimensions**: A question that mixes housing-cost + tax-policy + environmental-stance asks too much. Split.
- **Asking about settled issues**: If everyone in this cycle agrees, the question wastes survey budget.
- **Asking too many upfront**: respect attention budget. Headline 5 → opt-in. Stop after 3 if user impatient.
- **Putting cycle-specific framings here**: that's what `controversies/<year>/<state>.md` is for.
