#!/usr/bin/env bash
# Cross-stack publish gate (#4 M2 / ariadne #53 Phase D): a *passed* substrate
# review must have been done by a different AI stack than produced it. Same-stack
# review degrades to fresh-context only and defeats the "two stacks agree"
# guarantee the AI-curated pitch rests on.
#
#   cross-stack-gate.sh <base_sha> <tip_sha>
#
# Over base..tip, for each substrate file that is `review: passed`, block if
# generated-by or reviewed-by is missing/duplicate/unreadable, OR if the two
# normalized values are equal (exact inequality; compound-stack overlap such as
# `claude+codex` vs `codex` is a deferred refinement — see #4 M4).
#
# Files not yet `review: passed` are review-gate.sh's domain and are skipped
# here, so the two gates stay orthogonal: review-gate enforces "reviewed +
# passed", this one enforces "the passed review was cross-stack".
#
# Exit 0 = every passed substrate file in range is cross-stack reviewed.
# Exit 1 = at least one is same-stack or missing a stack field (blockers → stderr).
# Exit 2 = the range could not be resolved (fail closed). Mirrors review-gate.sh.
set -euo pipefail

BASE="${1:?usage: cross-stack-gate.sh <base_sha> <tip_sha>}"
TIP="${2:?usage: cross-stack-gate.sh <base_sha> <tip_sha>}"

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=lib-substrate.sh
. "$DIR/lib-substrate.sh"

if ! files="$(substrate_files_in_range "$BASE" "$TIP")"; then
    echo "✖ cross-stack-gate: could not diff range ${BASE}..${TIP} — unresolved revision? (failing closed)" >&2
    exit 2
fi

blockers=""
count=0
while IFS= read -r f; do
    [ -n "$f" ] || continue

    # Only passed reviews are in scope; not-yet-passed is review-gate.sh's job.
    review="$(frontmatter_field "$TIP" "$f" review)"
    [ "$review" = "passed" ] || continue

    gen="$(frontmatter_field "$TIP" "$f" generated-by)"
    rev="$(frontmatter_field "$TIP" "$f" reviewed-by)"

    reason=""
    case "$gen" in "<missing>"|"<duplicate>"|"<unreadable>") reason="generated-by=${gen}" ;; esac
    case "$rev" in "<missing>"|"<duplicate>"|"<unreadable>") reason="${reason:+${reason}, }reviewed-by=${rev}" ;; esac
    if [ -z "$reason" ] && [ "$gen" = "$rev" ]; then
        reason="same stack (generated-by=reviewed-by=${gen})"
    fi

    if [ -n "$reason" ]; then
        blockers="${blockers}    ${f}  [${reason}]
"
        count=$((count + 1))
    fi
done < <(printf '%s\n' "$files")

if [ "$count" -gt 0 ]; then
    {
        echo "✖ cross-stack gate: ${count} passed substrate file(s) not cross-stack reviewed:"
        printf '%s' "$blockers"
    } >&2
    exit 1
fi

echo "✓ cross-stack gate: all passed substrate files in ${BASE:0:7}..${TIP:0:7} have reviewed-by ≠ generated-by"
exit 0
