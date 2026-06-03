---
name: refresh-reads
description: Re-score cache-stale per-axis reads + votes after the philosophy, a calibration skill, or a candidate dossier changes. The soft half of the refresh loop — pairs with the deterministic detector scripts/stale-reads.sh. Enumerate stale artifacts, re-score each against current inputs per the SKILL Stage-3 contract, propagate to vote.md, and report what moved. Inference-refresh only; fact-refresh (re-researching dossiers) is the separate Stage 1–2 concern.
generated-by: claude
generated-on: 2026-06-02
review: not-done
---

# refresh-reads

A `-read.md` is a **pure function** of three inputs — the user's philosophy, the calibration skills, and the candidate dossier (SKILL.md Stage 3). When any input changes, every read scored against it is cache-stale and must be re-scored; `vote.md` is downstream of its race's reads, so it re-aggregates too. This sub-skill is the **soft (model) half** of that refresh; the **hard (deterministic) half** is `scripts/stale-reads.sh`, which decides *what* is stale so the model only spends cycles on the reads that actually need it.

This refreshes **inference**, not facts. If the stale trigger is a *dossier* and the dossier itself is out of date (not just edited), that's a **fact-refresh** (Stage 1–2: re-research with web + source-hygiene + cross-stack review), a separate concern — see SKILL.md's cache-first table. Here we assume inputs are current and only the scoring needs to catch up.

## Algorithm

### Stage 1 — Detect (deterministic)
Run the detector; it resolves the private dir itself and compares frontmatter dates (not mtime):

```
scripts/stale-reads.sh           # human-readable: <path>  <-- newer: <trigger> (<date>)
scripts/stale-reads.sh --quiet   # bare paths, for piping
```

Exit 1 means stale artifacts exist. The `<-- newer: <trigger>` tells you *why* each is stale (which input out-dated it) — useful for deciding scope (a single new calibration skill may only bite a few races).

### Stage 2 — Re-score each stale read (soft, parallelizable)
For each stale `-read.md`, re-score per the SKILL Stage-3 **scoring contract** (integer per-axis [−2,+2]; per-office template weights heavy ×2 / medium ×1 / light ×0.5; `weighted-total` = body math; show the column math) against the **current** philosophy + all calibration skills + the dossier. This is a pure re-score — no web. It is **offload-friendly**: dispatch one subagent per read (or per race) with the philosophy, the calibration skills, the office template, and the dossier in the prompt; a cheaper model is usually fine because the judgment is pinned by the written inputs.

**Bump the date.** Set the read's `revised:` to today on every edit. The detector keys on dates — an edit without a date bump leaves the read falsely flagged next run (or, worse, falsely fresh). This is the one discipline the loop depends on.

### Stage 3 — Propagate to the vote
Re-aggregate the race's `vote.md` matrix from the updated reads (totals, ordering, the recommended ✓, conscience/strategic, any narrative that cites a score). Bump its `revised:`. If a per-axis score moved a *recommendation*, that's a Stage-4 disagreement-loop moment — surface it to the user, don't silently flip the pick.

### Stage 4 — Report what moved
Emit a table: per candidate, **old → new weighted-total**, the **axis / calibration-skill that drove the delta**, and **did the recommendation change**. The point of the loop is not just freshness — it's telling the user where a philosophy edit actually changed a conclusion. "Re-scored, nothing moved" is a valid and common outcome (most edits just formalize prior intent); say so explicitly rather than implying churn.

### Stage 5 — Re-verify (optional)
Re-run `scripts/stale-reads.sh` — the races you refreshed should drop off the list (dates now current). For arithmetic assurance on the re-scored reads, the [[review]] gate's math check applies (private reads are reviewable for arithmetic even though they're not shared substrate).

## Scope & the sibling skill

- **This skill = inference refresh** (`who-to-vote-for/**/*-read.md` + `vote.md`). Cheap, no web, private artifacts.
- **refresh-facts (deferred sibling) = fact refresh** (`data/candidates/**`). Heavy: web re-research, source-hygiene, and a mandatory cross-stack [[review]] before the dossier can re-publish. Build it when a fact-refresh actually fires (election proximity, major news); until then it's YAGNI.

The two share the same detector signal but diverge entirely on cost, triggers, and review treatment — keep them separate skills.

## When NOT to use
- A read whose only "staleness" is a date-bump with no substantive input change — re-scoring will reproduce the same numbers. (Still bump the date so the detector clears it.)
- A dossier that is genuinely out of date on the facts — that needs fact-refresh first; re-scoring against stale facts just launders them.

## Cross-references
- Detector: `scripts/stale-reads.sh` (+ `scripts/tests/test-stale-reads.sh`)
- Scoring contract + cache rules: [[SKILL]] (Stage 3, "Cache-first by default")
- Arithmetic / consistency check: [[review]]
- Born from: `workshop/issues/000012-refresh-reads.md`
