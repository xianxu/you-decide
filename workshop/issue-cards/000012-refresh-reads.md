---
id: '000012'
status: done
created: 2026-06-02
updated: 2026-06-03
estimate_hours: 3
actual_hours: 5
---

# refresh-reads: stale-read detector + re-score driver

## Problem

Editing a user's `philosophy-<user>.md`, a calibration skill, or a candidate dossier silently invalidates the downstream `-read.md` + `vote.md` cache. SKILL.md Stage 3 *specifies* the staleness predicate ("a read is stale if philosophy / any calibration skill / the dossier is newer than it") but nothing **executes** it — there's no driver that finds the stale reads and re-scores them. Concretely: on 2026-06-02 the philosophy gained a Progress/positive-sum lens + Backbone section + a new `progress-over-status-quo` calibration skill, which staled essentially every read in the private dir, with no mechanism to detect or refresh them.
