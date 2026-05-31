## 2026-05-28 - Review ballot manifests before candidate facts

When reviewing election substrate, verify the manifest against official certified candidate lists before spending time on candidate-profile source hygiene. A stale or partial manifest makes otherwise well-sourced candidate profiles unsafe for downstream ballot resolution.

## 2026-05-28 - Data-gap fixes must remove downstream claims

When a fixer demotes an unsupported claim to `DATA GAP`, re-review every other section that reused the claim. A clean gap note is not enough if the controversy/liability prose or source table still treats blocked or search-summary evidence as support.

## 2026-05-30 - Commit/discard uncommitted edits before throwaway-branch tests

To test a gate I made a throwaway branch and `git commit -am` to fabricate a dirty state — which swept up *unrelated* uncommitted edits (the issue file) into that commit; `git branch -D` then discarded both. Before creating a test branch and committing, either commit the real work first, `git stash` it, or test in a separate `git worktree`. (Recovery here was luck: the dangling commit was still reachable via its SHA. Don't rely on that.)

## 2026-05-30 - perl byte-mode corrupts UTF-8; macOS bash is 3.2

`perl -i`/`sed` operate on bytes by default and will split multi-byte UTF-8 (e.g. box-drawing `─│┐` in an ASCII diagram) when a char class matches a partial byte — silent corruption in exactly the files with line art. Use `perl -CSD` or a Python script opened with `encoding='utf-8'`. Also: `/usr/bin/env bash` on macOS is **3.2** — no `mapfile`/`readarray`; use `while IFS= read -r` with process substitution.

## 2026-05-31 - Gates: fail closed, and parse ONLY a properly-fenced frontmatter block

When a gate reads frontmatter to decide pass/block, the failure mode that matters is the *permissive* one. Two real cases caught in fresh-eyes review of the cross-stack gate (#4 M2): (1) an **unclosed** frontmatter fence (opening `---`, no closing `---`) made an "collect until fence or EOF" parser read the whole body as metadata — so a body `review: passed` line could satisfy the gate. Fix: buffer the interior and emit it *only if a closing fence was seen*; no fence → no frontmatter → every field `<missing>` → block. (2) Missing/duplicate/unreadable keys must map to distinct sentinels that are not real values and always block. Rule: enumerate every malformed-input class (no fence, unclosed fence, dup key, empty file, body-mimics-metadata, CRLF) as test cases — a gate's whole value is that these fail closed, so they belong in the test harness, not in a reviewer's head. CRLF specifically: strip trailing `\r` so a legit CRLF file parses instead of false-blocking, but it still fails closed if malformed.
