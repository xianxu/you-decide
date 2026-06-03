## 2026-06-03 - A fail-closed gate needs fail-closed TESTS — and a green happy-path test proves nothing

Two compounding lessons from #12's stale-read detector, both caught only by fresh-eyes review (the happy-path test shipped green twice over a detector that failed OPEN):

1. **Test the malformed-input classes, and prove the test isn't tautological.** A gate's whole value is that bad input fails closed; so the no-fence / unclosed-fence / no-date / empty / CRLF / missing-edge cases ARE the test suite, not edge notes. Beyond writing them: *verify each new fail-closed case actually FAILS when its guard is reverted.* Two of #12's "fail-closed" cases passed even with the fix removed — one planted a body line (`body revised:`) that the anchored parser could never match anyway; the other was already caught by an unrelated comparison. A quick negative check (`sed` the guard out → re-run the case → expect red) is the only way to know a test pins its fix.

2. **Own date vs input date want OPPOSITE tie-breaking.** When several frontmatter date keys can be present, an artifact's OWN effective date should be priority-first (the authoritative `revised`), but an INPUT's date should be newest-wins (fail-closed). Taking `max` uniformly is a fail-OPEN hole: a stray newer `read-date` on a not-actually-re-derived read masks it against newer inputs. Keep two extractors (`fdate_own` / `fdate_in`), not one.

## 2026-06-02 - Authoritative schema must be derived from ALL instances, not a sample

When authoring a registry/schema asserted as the "single authority" for a document type, derive its frontmatter by surveying **every existing instance**, not the two or three you happened to read. In #11 the `artifacts.md` race-vote schema declared `final-vote:` — a field present in **0 of 19** real `vote.md` files (they use `primary-vote:`/`general-vote:`) — and a `posture:` enum when the field is actually free-text prose; the ballot-guide schema declared `generated-on:` when the one real guide used `generated:`. Both slipped past self-review (confirmation bias from the sampled files) and were caught only by fresh-eyes review. Rule: before writing a schema, run a field-frequency grep over the real corpus, e.g. `for f in $(find . -name vote.md); do sed -n '/^---$/,/^---$/p' "$f"; done | grep -oE '^[a-z-]+:' | sort | uniq -c | sort -rn`. The schema must match observed reality (or, if normalizing forward, say so explicitly and migrate the existing files).

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
