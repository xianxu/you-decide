---
id: 000010
status: open
created: 2026-06-02
updated: 2026-06-02
estimate_hours: 0.5
github_issue:
---

# Non-blocking pre-commit review reminder for unreviewed substrate

## Problem

The publish gate (#4) blocks `review ≠ passed` substrate at **push to main**, by
design: commit is a free sync/handoff primitive, so the readiness boundary is
publish, not commit. That design is correct and stays.

But it leaves a silent window. A producer can research → write substrate at
`review: not-done` → `git commit` → and get **no signal at all** that the review
step is owed. The obligation only resurfaces at push (which may be much later)
or when a human notices. That window bit us on 2026-06-02: the CA lieutenant
governor dossiers were produced, committed at `review: not-done`, and sat there
unreviewed — the gap was caught only because the operator asked. When the
eventual review ran, it found a *false fact* (a fabricated CTA/CFT-endorses-Tubbs
claim) plus a name error and Tier-C-sourcing issues. The cost of the silent
window is real, not hypothetical.

The root cause was a producer skipping the review step (and not entering the
skill at all). Prose alone doesn't fix a prose-skip — #4's own thesis is that
"without tooling, the discipline erodes." We need the obligation surfaced
**at the moment substrate is committed**, observable to a human or agent, on a
file-path trigger (so it fires even when the producer never entered the skill).
