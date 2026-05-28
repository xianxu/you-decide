#!/usr/bin/env bash
# Audit review-state coverage across the repo.
#
# Reports:
# - How many files are unreviewed (review: not-done)
# - How many have issues flagged or failed
# - Producing-stack distribution
# - Any same-stack reviews (invalid — should be empty)
#
# Anchored to end-of-line ($) so schema-documentation in skill files
# (which contains literal "review: not-done | passed | ..." patterns) isn't
# counted as actually-unreviewed.

set -euo pipefail

ROOT="${1:-$(pwd)}"
cd "$ROOT"

echo "=== Audit: review-state coverage in $ROOT ==="
echo

count() {
    local pattern="$1"
    local label="$2"
    local n
    n=$(rg -l "$pattern" --type md 2>/dev/null | wc -l | tr -d ' ')
    printf "%-40s %s\n" "$label" "$n"
}

echo "--- File counts by state ---"
count '^review: not-done\s*$'        "review: not-done"
count '^review: passed\s*$'          "review: passed"
count '^review: issues-flagged\s*$'  "review: issues-flagged"
count '^review: failed\s*$'          "review: failed"

echo
echo "--- Producing-stack distribution ---"
rg -h '^generated-by:\s*([a-z|+ ]+)\s*$' --type md -r '$1' 2>/dev/null \
    | sort | uniq -c | sort -rn

echo
echo "--- Files that need review (review: not-done) ---"
rg -l '^review: not-done\s*$' --type md 2>/dev/null | sort

echo
echo "--- Files with flagged issues (need follow-up) ---"
rg -l '^review: (issues-flagged|failed)\s*$' --type md 2>/dev/null | sort || echo "  (none)"

echo
echo "--- Same-stack reviews (INVALID — reviewer must differ from generator) ---"
# Find files where generated-by and reviewed-by are the same line value
fail=0
while IFS= read -r f; do
    gen=$(rg -N '^generated-by:\s*(\S.*?)\s*$' -r '$1' "$f" 2>/dev/null | head -1 || true)
    rev=$(rg -N '^reviewed-by:\s*(\S.*?)\s*$' -r '$1' "$f" 2>/dev/null | head -1 || true)
    if [[ -n "$gen" && -n "$rev" && "$gen" == "$rev" ]]; then
        echo "  $f: generated-by=$gen, reviewed-by=$rev"
        fail=1
    fi
done < <(rg -l '^reviewed-by:' --type md 2>/dev/null)
if [[ $fail -eq 0 ]]; then
    echo "  (none)"
fi
