#!/usr/bin/env bash
# Non-blocking pre-commit review reminder (issue #10).
#
# If any shared-substrate file STAGED for commit is not `review: passed`, print
# a visible warning naming the file(s) and their state — then ALWAYS exit 0.
#
# Commit stays a free sync/handoff primitive; this is NOT a second gate. The
# blocking publish gate lives at push (scripts/hooks/pre-push → review-gate.sh,
# issue #4). This hook only surfaces the review obligation at the moment
# substrate is committed, so the "produce → forget to review → commit at
# not-done" path is observable instead of silent. Rationale + the incident that
# motivated it: workshop/issues/000010 + you-decide/review.md.
#
# Substrate discovery + fail-closed frontmatter parsing are reused from
# lib-substrate.sh (shared with the push gate) so the two can't drift.
set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=lib-substrate.sh
. "$DIR/lib-substrate.sh"

files="$(substrate_files_staged)"
[ -n "$files" ] || exit 0

unreviewed=""
count=0
while IFS= read -r f; do
    [ -n "$f" ] || continue
    # Empty <tip> → frontmatter_field reads `git show ":$f"` = the STAGED blob,
    # so we warn on exactly what's about to be committed (not the HEAD version).
    state="$(frontmatter_field "" "$f" review)"
    if [ "$state" != "passed" ]; then
        unreviewed="${unreviewed}    ${f}  [review: ${state:-<missing>}]
"
        count=$((count + 1))
    fi
done < <(printf '%s\n' "$files")

if [ "$count" -gt 0 ]; then
    {
        echo "⚠ pre-commit: ${count} substrate file(s) staged at review ≠ passed:"
        printf '%s' "$unreviewed"
        echo "  Commit allowed (commit = sync/handoff). Before 'git push' to main,"
        echo "  run the 'review' skill (fresh context, different AI stack) — the push"
        echo "  gate will block these until they are 'review: passed'."
    } >&2
fi

exit 0
