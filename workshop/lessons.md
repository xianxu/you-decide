## 2026-05-28 - Review ballot manifests before candidate facts

When reviewing election substrate, verify the manifest against official certified candidate lists before spending time on candidate-profile source hygiene. A stale or partial manifest makes otherwise well-sourced candidate profiles unsafe for downstream ballot resolution.

## 2026-05-28 - Data-gap fixes must remove downstream claims

When a fixer demotes an unsupported claim to `DATA GAP`, re-review every other section that reused the claim. A clean gap note is not enough if the controversy/liability prose or source table still treats blocked or search-summary evidence as support.

## 2026-05-30 - Commit/discard uncommitted edits before throwaway-branch tests

To test a gate I made a throwaway branch and `git commit -am` to fabricate a dirty state — which swept up *unrelated* uncommitted edits (the issue file) into that commit; `git branch -D` then discarded both. Before creating a test branch and committing, either commit the real work first, `git stash` it, or test in a separate `git worktree`. (Recovery here was luck: the dangling commit was still reachable via its SHA. Don't rely on that.)

## 2026-05-30 - perl byte-mode corrupts UTF-8; macOS bash is 3.2

`perl -i`/`sed` operate on bytes by default and will split multi-byte UTF-8 (e.g. box-drawing `─│┐` in an ASCII diagram) when a char class matches a partial byte — silent corruption in exactly the files with line art. Use `perl -CSD` or a Python script opened with `encoding='utf-8'`. Also: `/usr/bin/env bash` on macOS is **3.2** — no `mapfile`/`readarray`; use `while IFS= read -r` with process substitution.
