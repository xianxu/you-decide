---
type: pensive
date: 2026-05-28
topic: Source × claim-type reliability and confidence-aware scoring
mode: ideas
description: Data-quality suspicion belongs in a confidence interval, not a discount multiplier; source reliability is really source × claim-type; Wikipedia is good at facts, contested at framing.
references: [review.md, calibration-skills/source-hygiene-tier-list.md, SKILL.md]
---

# Pensive: Source × claim-type reliability and confidence-aware scoring

What do we do with a claim we trust less because of where it came from? My first instinct was a **discount multiplier** — a Tier-C-sourced claim counts for less in the axis score. But that's the wrong model. A weakly-sourced claim, *if true*, is exactly as decision-relevant as a well-sourced one; what I'm actually unsure about is whether it's true, not how big its effect is. Shrinking the score conflates "weak effect" with "uncertain truth." The honest framing is a **distribution**: the axis score is a point estimate with a confidence interval, and a lower-quality source widens the interval rather than pulling the point toward zero.

And the spread has two independent sources, not one. **Source reliability** (is the claimed fact true?) is the one I started from, but **interpretive ambiguity** (even if true, does this fact actually imply this axis position?) is just as real — "voted for X" might be conviction or whip pressure. Source quality only touches the first.

The trap I want to remember: a discount multiplier **systematically penalizes under-covered candidates** — challengers, third-party, local races — not because they're worse but because fewer journalists wrote about them. Uncertainty is not a demerit. Low coverage should widen the interval and surface as a *known unknown*, never dock the score. That alone is enough reason to model this as confidence, not as a multiplier.

The thing is, the decision only cares about confidence when **margins overlap**. If a candidate leads by a mile, source noise on one claim is irrelevant; if it's close *and* the edge rests on a Tier-C claim, that's a near-tie that should be *named* as one. So I don't need real intervals — I need the existing **risk-mode recommendation framing** to flag "this margin is within the noise of its weakest inputs." The seeds are already here: the `severity` field on a DATA-GAP/FIXME is a coarse confidence handle (high = could flip the rec = wide CI on a decisive axis), the per-axis read is where a low-confidence annotation belongs, and risk-mode is where fragile margins surface.

On Wikipedia specifically: it *is* self-correcting, but not flatly — reliability is roughly **prominence × claim-type**. High-traffic political pages are heavily watched, so the hard, verifiable skeleton (dates, vote counts, offices, margins) is very reliable; but framing, emphasis, and characterization are exactly where motivated editors fight, and low-prominence subjects (a county sheriff, an obscure challenger) have too few eyes to be trusted at all. The nice part is this maps onto the tier rule we already have — "Wikipedia for orienting bio context, never for a position or controversy" — and explains *why* it's right: Wikipedia is good at the facts and contested at the framing, and scoring lives in the framing.

Which points at the richer model: reliability isn't a flat per-source tier, it's **source × claim-type**. A campaign site is authoritative for "what they claim to believe" and near-zero for "their actual record." A partisan outlet reliably tells you an event *happened* and unreliably frames *what it meant*. Wikipedia: high hard-fact, low characterization. The current flat tiers are a serviceable approximation of the diagonal of that matrix; the full 2-D version is where this would go if it ever earns the complexity.

## Open questions

- Is the 3-bucket `severity` enough as a confidence proxy, or does a close-call recommendation eventually need an actual robustness check (do the candidates' weighted-total ranges overlap once low-confidence inputs are widened)? Probably wait until the tool produces enough genuine near-ties to feel the pain.
- Where does the source × claim-type matrix live if built — an extension of `source-hygiene-tier-list`, or its own calibration skill? And does it stay qualitative (a guidance table) or become a real likelihood the read multiplies in?
- This feels like it wants to become a **target** eventually — a grounding commitment like *"scores are confidence-aware point estimates, never coverage-penalized"* — but only once the pattern stabilizes through use. Not yet.

## References

- `review.md` — the DATA-GAP/DATA-FIXME convention, severity-governs-blocking, source-hygiene checklist.
- `calibration-skills/source-hygiene-tier-list.md` — the current flat-tier rule (the diagonal of the matrix).
- `SKILL.md` — the −2..+2 scoring contract and the "risk-mode, not scorecard" recommendation framing where fragile margins should surface.
