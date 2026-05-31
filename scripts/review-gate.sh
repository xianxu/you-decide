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

blockers=""
count=0
while IFS= read -r f; do
    [ -n "$f" ] || continue
    case "$f" in *.md) ;; *) continue ;; esac
    state="$(git show "$TIP:$f" 2>/dev/null \
        | grep -m1 -E '^review:[[:space:]]*' \
        | sed -E 's/^review:[[:space:]]*//; s/[[:space:]]*$//' || true)"
    if [ "$state" != "passed" ]; then
        blockers="${blockers}    ${f}  [review: ${state:-<missing>}]
"
        count=$((count + 1))
    fi
done < <(git diff --name-only --diff-filter=d "$BASE" "$TIP" \
            -- data/candidates data/elections data/controversies 2>/dev/null | sort -u)

if [ "$count" -gt 0 ]; then
    {
        echo "✖ publish gate: ${count} substrate file(s) not 'review: passed':"
        printf '%s' "$blockers"
    } >&2
    exit 1
fi

echo "✓ publish gate: all substrate files in ${BASE:0:7}..${TIP:0:7} are review: passed"
exit 0
