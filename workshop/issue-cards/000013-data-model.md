---
id: 000013
status: open
created: 2026-06-02
updated: 2026-06-02
estimate_hours: 4
github_issue:
---

# you-decide data model: nouns, dependency graph, fact/inference layers

## Problem

We grew **verbs** for keeping the substrate current — `refresh-facts`, `refresh-reads` (#12) — but no **nouns** to name *what scope* to refresh. So refresh is all-or-nothing (the #12 detector sweeps the entire private dir), and staleness is over-broad (a single calibration-skill edit flags every read because the check takes `max(all skills)`, even reads that never applied it). Underneath: the system has an implicit data model — entities (read, race, ballot, cycle, candidate dossier, election manifest) and dependencies among them — that has never been written down. Until it is, scoping, precise invalidation, and the ballot's fallible district-resolution all stay ad hoc. The D15→D16 district error (a wrong ballot membership that nothing detected — only the user caught it) is the sharpest symptom.
