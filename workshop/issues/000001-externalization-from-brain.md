---
id: 000001
status: open
deps: [brain#11]
created: 2026-05-28
updated: 2026-05-28
---

# Externalize design decisions + history from brain

## Context

The `you-decide` skill bundle started life inside `xianxu/brain` (tracked as `brain#11`) — multi-session development across philosophy authoring, candidate research, the disagreement-loop discovery, the substrate refactor, the standalone-repo extraction, the review-mechanism design, and a number of in-context decisions that don't yet have a single home in this repo.

`brain` is private. Once `brain#11` closes and the umbrella work is done, the substantive design rationale needs to externalize to this public repo so future contributors and downstream users can see *why* the architecture is what it is — not just *what* it is.

The README, SKILL.md, and sub-skill files already capture the *what*. This issue is about the *why*.

## Spec

Externalize from `brain#11` into this repo the following (probably across `docs/` + `atlas/` + this workshop issue's Log):

### Major design decisions to document

- **Privacy boundary** (candidates/ raw vs who-to-vote-for/ reads): the rationale for splitting AI-generated facts from per-user interpretation; the "shared brain + private brain" model; the rule "if reading a calibration-skill body reveals the user's preferences, it's private."
- **AI-curated, not crowdsourced**: the Wikipedia-bias-injection concern; PR policy (algorithm-yes, substrate-no); the AI-transparency manifesto.
- **Election-day-centric ballot model**: why `elections/<year>/<date>-<state>-<type>.md` is the primary key vs per-jurisdiction × year manifests; the insight that voters think in election-days.
- **5-tier axis taxonomy**: the structure (Character, Institutional, Economic, Issue, Social); universal vs office-weighted tiers.
- **Risk-frame, not scorecard**: Codex peer-review's pushback on mechanical scoring; the conscience-vs-strategic divergence framing.
- **Cache-first by default**: the explicit table of cache layers; why every stage that has a cache hits it before re-dispatching.
- **Sources organized per-jurisdiction**: `sources/US.md` + `sources/<state>.md` compose at research time; tier classification as principle (in calibration-skills) vs concrete outlet lists (in sources/).
- **Review mechanism**: fresh-context + different-AI-stack as the two independence requirements; the per-file frontmatter contract making review state greppable.
- **Survey design**: progressive disclosure (Headline 5 + opt-in deeper rounds); universal question-bank vs cycle-composed; force-choice + outlier + free-form per question.
- **Scoring contract**: -2/+2 per axis × template weight, sum as weighted-total; the bug it fixed (subagent score-scale drift).
- **Standalone repo + go.mod integration**: extracted from brain, brain integrates via `data/life/politics/go.mod` (matches ariadne `construct/go.mod` pattern across nous/pair/parley.nvim) + symlink for filesystem-level convenience.

### Specific calibration-skill origin stories

Each general calibration skill has a real provenance worth surfacing:
- `source-hygiene-tier-list`: Codex flagged Wikipedia + Factually.co + LLM-leaks ("WebSearch" literal, "franding" typo) in early CA-governor profiles.
- `establishment-career-not-equals-institutionalist`: Codex pushed back on auto-+2 institutionalist for Becerra based on Congress→AG→HHS career length; HHS-era stewardship failures argued against career-length-as-proxy.
- `abolish-position-dual-axis`: Codex caught the framing error of scoring Porter's abolish-ICE as pure state-expansion; the dual-axis rule (leave-people-alone + / institutionalist −) emerged from that.

### Test-run findings worth capturing

- The Palo Alto address-driven test (this batch, 2026-05-28) validated cache-hit / cache-miss behavior + surfaced the SCC DA Stanford prosecutorial-fundraising case as the substantive decision point. Findings + the score-scale-drift issue + the disambiguation near-miss (Kevin Johnson the law student vs Kevin Johnson the former Sacramento mayor) belong in a postmortem.

### Format / location

- This workshop issue's Log section: chronological capture of decisions + their rationale.
- Possibly `docs/design-decisions.md`: structured reference doc for contributors.
- Possibly `atlas/`: high-level architectural pointers (per ariadne convention atlas is "first-level onboarding material for human and agents").
- Possibly fold sub-skill provenance into the sub-skill files themselves (e.g., a `## Origin` section in `review.md`, `bootstrap-survey.md`, etc.).

## Plan

Deferred until `brain#11` closes. Plan items will materialize then.

- [ ] Wait for `brain#11` to close (M0-M6 complete, umbrella work done)
- [ ] Inventory: what design decisions / rationale exist in `brain#11`'s log + conversation history that are NOT already in this repo's user-facing files
- [ ] Decide format: workshop-issue-log only, vs `docs/design-decisions.md`, vs `atlas/`, vs sub-skill `## Origin` sections, vs a mix
- [ ] Write the externalization, preserving the conversational provenance ("Codex flagged X", "Xian's call on Y was Z")
- [ ] Cross-reference from README + SKILL.md so future contributors find it
- [ ] Close this issue with reference to the new docs

## Log

### 2026-05-28 — issue created

Captured the intent. Work itself is gated on `brain#11` closing. Empty workshop/issues/ in you-decide was noticed during the M5 → M6 transition; the right shape is workshop/issues/ as primary (per ariadne convention) with GitHub Issues for external-facing surface only. This issue is the placeholder until the actual externalization work begins.

The corresponding GH issues #1 (scaling), #2 (sources expansion), #3 (pre-commit hook) stay as public-facing surface; they get "fetched" into workshop/issues/ as the work on each actually begins (per `[[ariadne-in-repo-issues-first]]` calibration-skill from brain memory).
