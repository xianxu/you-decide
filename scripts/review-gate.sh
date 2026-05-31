#!/usr/bin/env bash
# Publish gate (issue #4): over a git range, block if any shared-substrate
# file is not `review: passed`.
#
#   review-gate.sh <base_sha> <tip_sha>
#
# Exit 0 = every substrate file added/modified in base..tip is `review: passed`.
# Exit 1 = at least one is not (the blockers are printed to stderr).
# Exit 2 = the range could not be resolved (fail closed — never silently pass).
#
# Pure check — no TTY, no prompts, no push logic. Reused by the pre-push hook
# (scripts/hooks/pre-push) and by PR-side CI. The publish standard and the
# commit-is-sync rationale live in you-decide/review.md + workshop/issues/000004.
#
# Substrate discovery + fail-closed frontmatter parsing live in lib-substrate.sh
# (shared with cross-stack-gate.sh; #4 M2 / ariadne #53 Phase D).
set -euo pipefail

BASE="${1:?usage: review-gate.sh <base_sha> <tip_sha>}"
TIP="${2:?usage: review-gate.sh <base_sha> <tip_sha>}"

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=lib-substrate.sh
. "$DIR/lib-substrate.sh"

if ! files="$(substrate_files_in_range "$BASE" "$TIP")"; then
    echo "✖ review-gate: could not diff range ${BASE}..${TIP} — unresolved revision? (failing closed)" >&2
    exit 2
fi

blockers=""
count=0
while IFS= read -r f; do
    [ -n "$f" ] || continue
    state="$(frontmatter_field "$TIP" "$f" review)"
    if [ "$state" != "passed" ]; then
        blockers="${blockers}    ${f}  [review: ${state:-<missing>}]
"
        count=$((count + 1))
    fi
done < <(printf '%s\n' "$files")

if [ "$count" -gt 0 ]; then
    {
        echo "✖ publish gate: ${count} substrate file(s) not 'review: passed':"
        printf '%s' "$blockers"
    } >&2
    exit 1
fi

echo "✓ publish gate: all substrate files in ${BASE:0:7}..${TIP:0:7} are review: passed"
exit 0
