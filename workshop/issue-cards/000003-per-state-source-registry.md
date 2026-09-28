---
id: 000003
status: open
created: 2026-05-28
updated: 2026-05-28
---

# Build out per-state authoritative-source registry (data/sources/ directory)

## Problem

As coverage expands beyond California (via #000002), each new state needs its own `data/sources/<state>.md` listing authoritative outlets (Tier A primary, Tier B authoritative-secondary) for that jurisdiction. Without per-state outlet registries, the research subagents fall back to whatever the WebSearch tool surfaces — which tends to over-index on Wikipedia, blog posts, and partisan local outlets.

The tier-classification *principle* lives in `calibration-skills/source-hygiene-tier-list.md`; the concrete per-state outlet *lists* are what unblocks accurate research in new states.
