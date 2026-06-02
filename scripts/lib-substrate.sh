#!/usr/bin/env bash
# lib-substrate.sh — shared helpers for the publish gates (review-gate.sh and
# cross-stack-gate.sh). Sourced, not executed. Pure: no TTY, no prompts, no push
# logic. Factored out of review-gate.sh (#4 M2 / ariadne #53 Phase D) so the
# substrate-discovery + fail-closed frontmatter parsing lives in exactly one
# place and both gates can't drift.
#
# Substrate = the fact-bearing dirs (data/candidates, data/elections,
# data/controversies). data/reviews + data/sources are intentionally out of
# scope (review reports + human-curated reference, not AI-curated facts).

# The fact-bearing substrate dirs — ONE definition shared by both discovery
# helpers (range + staged), so the push gate and the pre-commit warn can't drift.
SUBSTRATE_DIRS="data/candidates data/elections data/controversies"

# substrate_files_in_range <base> <tip>
# Prints the *.md substrate files added/modified in base..tip, one per line,
# sorted + deduped. An all-zeros base (a brand-new ref) is diffed against the
# empty tree so the first publish reviews every file. Returns 2 (and prints
# nothing) on an unresolvable range — callers MUST fail closed, never treat the
# empty output as "no blockers".
substrate_files_in_range() {
    local base="$1" tip="$2" changed
    if printf '%s' "$base" | grep -qE '^0+$'; then
        base="$(git hash-object -t tree /dev/null)"
    fi
    # shellcheck disable=SC2086  # intentional word-split of the dir list
    if ! changed="$(git diff --name-only --diff-filter=d "$base" "$tip" \
            -- $SUBSTRATE_DIRS)"; then
        return 2
    fi
    printf '%s\n' "$changed" | grep -E '\.md$' | sort -u || true
    return 0
}

# substrate_files_staged
# Index counterpart of substrate_files_in_range: prints the *.md substrate files
# currently STAGED for commit (added/copied/modified), one per line, sorted +
# deduped. Used by the pre-commit warn (scripts/warn-unreviewed.sh) so it shares
# the same substrate definition as the push gate. Empty output = nothing staged.
substrate_files_staged() {
    # shellcheck disable=SC2086  # intentional word-split of the dir list
    git diff --cached --name-only --diff-filter=ACM -- $SUBSTRATE_DIRS \
        | grep -E '\.md$' | sort -u || true
}

# frontmatter_field <tip> <file> <key>
# Echoes the value of `<key>:` from <file>'s YAML frontmatter at <tip>. Parses
# ONLY the frontmatter block (between the leading '---' on line 1 and the next
# '---') so a body line that looks like `key:` can't masquerade as metadata.
# Fail-closed sentinels (never an empty string):
#   <unreadable>  — file missing/unreadable at <tip>
#   <missing>     — no such key in frontmatter
#   <duplicate>   — key appears more than once (ambiguous)
frontmatter_field() {
    local tip="$1" file="$2" key="$3" content fm n
    if ! content="$(git show "$tip:$file" 2>/dev/null)"; then
        printf '%s\n' "<unreadable>"
        return 0
    fi
    # Parse ONLY a *properly fenced* frontmatter block: opening '---' on line 1,
    # a matching closing '---'. Buffer the interior and emit it ONLY if the
    # closing fence is seen — an unclosed fence yields no frontmatter (every
    # field → <missing>), so a malformed file fails closed rather than letting
    # body lines masquerade as metadata. Tolerate CRLF (strip trailing \r) so a
    # legitimately-reviewed CRLF file parses instead of false-blocking.
    fm="$(printf '%s\n' "$content" | awk '
        { sub(/\r$/, "") }
        NR==1 && $0 != "---" { exit }
        NR==1 { next }
        /^---[[:space:]]*$/ { closed = 1; exit }
        { buf = buf $0 "\n" }
        END { if (closed) printf "%s", buf }
    ')"
    n="$(printf '%s\n' "$fm" | grep -cE "^${key}:[[:space:]]" || true)"
    if [ "$n" -eq 1 ]; then
        printf '%s\n' "$fm" | grep -m1 -E "^${key}:[[:space:]]" \
            | sed -E "s/^${key}:[[:space:]]*//; s/[[:space:]]*$//"
    elif [ "$n" -gt 1 ]; then
        printf '%s\n' "<duplicate>"
    else
        printf '%s\n' "<missing>"
    fi
    return 0
}
