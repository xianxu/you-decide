---
id: 000010
status: open
deps: [you-decide#4, you-decide#8]
github_issue:
created: 2026-06-02
updated: 2026-06-02
estimate_hours: 0.5
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

## Spec

A **non-blocking** `pre-commit` hook that warns — never blocks — when staged
substrate is `review ≠ passed`. This is the "optional non-blocking warning"
#4 explicitly scoped for pre-commit but deferred; it is **not** a second gate.

- Same underlying check as the push gate (`review: passed` on substrate), same
  substrate definition — surfaced one trigger earlier as a nudge.
- Reuse `scripts/lib-substrate.sh` so the pre-commit warn and the push gate
  cannot drift on "what is substrate" or "how frontmatter is parsed." Add a
  staged/index counterpart to `substrate_files_in_range` (the push gate diffs a
  SHA range; pre-commit inspects the index), sharing one substrate-dir list.
- Always `exit 0`. Commit stays a free sync/handoff primitive. The blocking
  enforcement stays exactly where #4 put it (pre-push → `review-gate.sh`).
- Output names the offending files + their state, and tells the reader to run
  the `review` skill (fresh context, different stack) before pushing.
- Hook lives at `scripts/hooks/pre-commit` (repo uses `core.hooksPath =
  scripts/hooks`); must be executable.

Out of scope: changing the blocking boundary; gating the brain-side private dir
(not substrate, not gated); the coverage *report* (that's #8).

## Done when

- Committing a staged substrate file at `review: not-done` prints a visible
  warning naming the file(s) and state — and the commit still succeeds.
- Committing only `review: passed` substrate (or no substrate) prints nothing
  and exits 0.
- The warn path reuses `lib-substrate.sh`; the substrate-dir list exists in
  exactly one place, shared with `substrate_files_in_range`.
- The existing push gate (`review-gate.sh`, `cross-stack-gate.sh`) still passes
  unchanged on current HEAD (no regression from the lib refactor).

## Plan

- [x] Factor the substrate-dir list in `lib-substrate.sh` into one shared
      definition (`SUBSTRATE_DIRS`); add `substrate_files_staged()` (index
      counterpart).
- [x] Add `scripts/warn-unreviewed.sh` (non-blocking; sources the lib; reads
      the staged blob's `review:` via `frontmatter_field "" <file> review`).
- [x] Add `scripts/hooks/pre-commit` (executable) calling it; always exit 0.
- [x] Verify: push gate still green on HEAD; warn fires on a staged not-done
      fixture and stays silent on a passed one; commit is never blocked.

## Log

### 2026-06-02

Born from the CA-LG-dossier incident above (claude produced + committed at
`review: not-done`; codex review, run only after the operator asked, caught a
false endorsement fact). Filed to close the silent commit→push window with the
minimum mechanism #4 already envisioned.

Implemented + verified same session:
- `lib-substrate.sh`: `SUBSTRATE_DIRS` factored out; `substrate_files_staged()`
  added (index counterpart of `substrate_files_in_range`).
- `scripts/warn-unreviewed.sh` (non-blocking) + `scripts/hooks/pre-commit`.
- Verification: (1) push gate regression — `run-merge-checks.sh 550b9b5
  9f26776` still all-green after the lib refactor; (2) positive — staging a
  `review: not-done` substrate fixture makes the warn fire and name the file,
  exit 0; (3) negative — flipping the *staged blob* to `passed` silences it
  (confirms it reads the index, not HEAD); (4) hook end-to-end via git-style
  invocation warns and returns 0 (never blocks). Fixture cleaned up.
- Status left `open` for a proper `sdlc close` (actuals + atlas note) rather
  than a hand-edit.
