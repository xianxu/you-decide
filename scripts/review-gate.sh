#!/usr/bin/env bash
# Publish gate (issue #4): over a git range, block if any shared-substrate
# file is not `review: passed`.
#
#   review-gate.sh <base_sha> <tip_sha>
#
# Exit 0 = every substrate file added/modified in base..tip is `review: passed`.
# Exit 1 = at least one is not (the blockers are printed to stderr).
#
# Pure check — no TTY, no prompts, no push logic. Reused by the pre-push hook
# (scripts/hooks/pre-push) and by PR-side CI. The publish standard and the
# commit-is-sync rationale live in you-decide/review.md + workshop/issues/000004.
#
# Substrate = the fact-bearing dirs. data/reviews (the review reports
# themselves) and data/sources (human-curated reference) are intentionally
# out of scope here.
set -euo pipefail

BASE="${1:?usage: review-gate.sh <base_sha> <tip_sha>}"
TIP="${2:?usage: review-gate.sh <base_sha> <tip_sha>}"

# All-zeros base (a brand-new ref) → diff against the empty tree so the first
# publish reviews every substrate file rather than nothing.
if printf '%s' "$BASE" | grep -qE '^0+$'; then
    BASE="$(git hash-object -t tree /dev/null)"
fi

# Resolve the changed substrate files. An unresolvable range MUST fail, not
# silently pass — capture the diff and check git's exit status (don't swallow
# the error into an empty loop). Fail-closed on any git error.
if ! changed="$(git diff --name-only --diff-filter=d "$BASE" "$TIP" \
        -- data/candidates data/elections data/controversies)"; then
    echo "✖ review-gate: could not diff range ${BASE}..${TIP} — unresolved revision? (failing closed)" >&2
    exit 2
fi

blockers=""
count=0
while IFS= read -r f; do
    [ -n "$f" ] || continue
    case "$f" in *.md) ;; *) continue ;; esac

    # Read the file's review-state at TIP. Parse ONLY the YAML frontmatter block
    # (between the leading '---' on line 1 and the next '---'), so a body line
    # that looks like `review:` can't masquerade as metadata. Fail-closed:
    # unreadable, missing, or duplicate `review:` keys all count as not-passed.
    if ! content="$(git show "$TIP:$f" 2>/dev/null)"; then
        state="<unreadable>"
    else
        fm="$(printf '%s\n' "$content" | awk '
            NR==1 && $0 != "---" { exit }
            NR==1 { next }
            /^---[[:space:]]*$/ { exit }
            { print }
        ')"
        n="$(printf '%s\n' "$fm" | grep -cE '^review:[[:space:]]' || true)"
        if [ "$n" -eq 1 ]; then
            state="$(printf '%s\n' "$fm" | grep -m1 -E '^review:[[:space:]]' \
                | sed -E 's/^review:[[:space:]]*//; s/[[:space:]]*$//')"
        elif [ "$n" -gt 1 ]; then
            state="<duplicate>"
        else
            state="<missing>"
        fi
    fi

    if [ "$state" != "passed" ]; then
        blockers="${blockers}    ${f}  [review: ${state:-<missing>}]
"
        count=$((count + 1))
    fi
done < <(printf '%s\n' "$changed" | sort -u)

if [ "$count" -gt 0 ]; then
    {
        echo "✖ publish gate: ${count} substrate file(s) not 'review: passed':"
        printf '%s' "$blockers"
    } >&2
    exit 1
fi

echo "✓ publish gate: all substrate files in ${BASE:0:7}..${TIP:0:7} are review: passed"
exit 0
