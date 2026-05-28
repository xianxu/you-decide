---
rule: Prefer CalMatters / AP / LA Times / KQED / candidate sites / FPPC filings / official docs over Wikipedia and aggregator sites for decisive candidate claims
applies-to: [research-subagents, profile-generation, all races]
born-from: 2026-05-27 | 2026 CA governor | Codex peer review flagged Wikipedia and Factually.co as weak source choices, and noted LLM-generation artifacts ("WebSearch" literal text, typo "franding") in final profile text
---

# Source-hygiene tier list

When research subagents build candidate profiles, source quality matters. Codex peer review noted several 2026 CA governor profiles cited Wikipedia and Factually.co for decisive claims that should have been backed by primary or authoritative-secondary sources, and that LLM-generation artifacts leaked through.

## Source tiers (preference order)

**Tier A — Primary (use whenever available):**
- Candidate's official campaign site (date-stamp the snapshot — can be scrubbed mid-race)
- FPPC filings (California campaign-finance ground truth)
- Official voting records (legistar, congressional record, etc.)
- Candidate's own social-media posts (link the post directly, not screenshots)
- Court documents, agency reports

**Tier B — Authoritative-secondary (good for synthesis):**
- **CalMatters** — CA nonpartisan, deep policy reporting
- **AP** — wire-service factual
- **LA Times** — statewide mainstream
- **KQED** — public-radio voter guides
- Local broadsheets — SJ Mercury, SF Chronicle, SD Union-Tribune

**Tier C — Avoid for decisive claims:**
- **Wikipedia** — use for orienting context only; never as the source for a position or controversy
- **Factually.co** and similar AI-summary aggregators — derivative and sometimes confused; chase the underlying primary source
- **Partisan outlets** (Fox right / MSNBC left / etc.) — usable only with explicit tilt flag plus triangulation against Tier A or B

## When it applies

Any per-candidate profile generation. Add this tier list to research-subagent prompts.

## Artifact hygiene (sub-rule)

Subagent outputs sometimes leak generation artifacts: literal tool names like "WebSearch" in citation text, AI-typical typos ("franding" for "branding"), placeholder URLs. Before declaring a profile done, grep for:

```sh
rg -i 'WebSearch|franding|TBD|<unknown>|\[.*\]\(\)' <profile>
```

and clean up matches.

## Don't confuse with

- **Genesis tracking** (architecture principle) — every claim is sourced. This rule is about *which* sources to prefer when there's a choice.
