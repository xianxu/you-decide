#!/usr/bin/env bash
# test-gates.sh — correctness harness for the publish gates (#4 M2).
#
# Builds a throwaway git repo in $TMPDIR, commits crafted substrate fixtures
# (one file per commit so PREV..THIS isolates that file), and asserts each
# gate's exit code over specific ranges. Also exercises the real
# run-merge-checks.sh runner end-to-end via a fixture merge-checks.d/ that
# wraps the real gate scripts.
#
# Run: bash scripts/tests/test-gates.sh   (exit 0 = all asserts passed)
#
# NOTE: deliberately NOT `set -e` — we expect non-zero gate exits and check them.
set -uo pipefail

SCRIPTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
REVIEW_GATE="$SCRIPTS_DIR/review-gate.sh"
CROSS_GATE="$SCRIPTS_DIR/cross-stack-gate.sh"
RUNNER="$SCRIPTS_DIR/run-merge-checks.sh"

pass=0
fail=0
ok()  { printf '  \033[1;32m✓\033[0m %s\n' "$1"; pass=$((pass + 1)); }
no()  { printf '  \033[1;31m✗\033[0m %s (expected exit %s, got %s)\n' "$1" "$2" "$3"; fail=$((fail + 1)); }

# assert_exit <label> <expected-code> <cmd...>
assert_exit() {
    local label="$1" expect="$2"
    shift 2
    "$@" >/dev/null 2>&1
    local got=$?
    if [ "$got" -eq "$expect" ]; then ok "$label"; else no "$label" "$expect" "$got"; fi
}

WORK="$(mktemp -d "${TMPDIR:-/tmp}/gatetest.XXXXXX")"
trap 'rm -rf "$WORK"' EXIT
cd "$WORK" || exit 99

git init -q
git config user.email t@example.com
git config user.name tester
git config commit.gpgsign false

# mkfile <path> <review> <generated-by> <reviewed-by>   ("-" omits a field)
mkfile() {
    local p="$1" review="$2" gen="$3" rev="$4"
    mkdir -p "$(dirname "$p")"
    {
        echo "---"
        echo "name: Test Candidate"
        [ "$gen" != "-" ] && echo "generated-by: $gen"
        echo "review: $review"
        [ "$rev" != "-" ] && echo "reviewed-by: $rev"
        echo "---"
        echo
        echo "body"
    } > "$p"
}

commit() { git add -A; git commit -qm "$1"; git rev-parse HEAD; }

echo "test-gates: building fixture repo in $WORK"

echo "readme" > README.md;                                         S0=$(commit "root")
mkfile data/candidates/good.md       passed      claude  codex;    SGOOD=$(commit "good: passed claude/codex")
mkfile data/candidates/same.md       passed      claude  claude;   SSAME=$(commit "same: passed claude/claude")
mkfile data/candidates/nofield.md    passed      claude  -;        SNOFIELD=$(commit "nofield: passed, no reviewed-by")
mkfile data/candidates/inprog.md     in-progress claude  -;        SINPROG=$(commit "inprog: not passed")
mkfile data/candidates/inprogsame.md in-progress claude  claude;   SINPROGSAME=$(commit "inprogsame: not passed, same stack")
mkfile data/candidates/compound.md   passed      claude+codex codex; SCOMPOUND=$(commit "compound: passed claude+codex/codex")
echo "more" >> README.md;                                          SDOC=$(commit "doc-only change")

# Malformed-frontmatter fixtures — each must fail closed (Codex-class bugs).
# body-fake: a body `review: passed` line with NO frontmatter review key.
mkdir -p data/candidates
printf -- '---\nname: X\ngenerated-by: claude\n---\n\nreview: passed\nreviewed-by: codex\n' \
    > data/candidates/bodyfake.md;                                 SBODYFAKE=$(commit "bodyfake: review only in body")
# dup: two reviewed-by lines in frontmatter (ambiguous → <duplicate>).
printf -- '---\nname: X\ngenerated-by: claude\nreview: passed\nreviewed-by: codex\nreviewed-by: gemini\n---\nbody\n' \
    > data/candidates/dup.md;                                      SDUP=$(commit "dup: two reviewed-by keys")
# empty: zero-byte file (no frontmatter at all).
: > data/candidates/empty.md;                                      SEMPTY=$(commit "empty: no frontmatter")
# noclose: opening fence, no closing fence → body must NOT be read as metadata.
printf -- '---\nname: X\ngenerated-by: claude\nreview: passed\nreviewed-by: codex\nbody line\n' \
    > data/candidates/noclose.md;                                  SNOCLOSE=$(commit "noclose: unterminated frontmatter")

echo
echo "── review-gate.sh (review: passed) ──"
assert_exit "passed claude/codex → 0"            0 "$REVIEW_GATE" "$S0" "$SGOOD"
assert_exit "not-passed (in-progress) → 1"       1 "$REVIEW_GATE" "$SNOFIELD" "$SINPROG"
assert_exit "passed-but-no-reviewed-by → 0"      0 "$REVIEW_GATE" "$SSAME" "$SNOFIELD"
assert_exit "doc-only (no substrate) → 0"        0 "$REVIEW_GATE" "$SCOMPOUND" "$SDOC"
assert_exit "body-only review key → 1 (not read as metadata)" 1 "$REVIEW_GATE" "$SDOC" "$SBODYFAKE"
assert_exit "dup reviewed-by but review:passed → 0 (review-gate's scope)" 0 "$REVIEW_GATE" "$SBODYFAKE" "$SDUP"
assert_exit "empty file → 1"                     1 "$REVIEW_GATE" "$SDUP" "$SEMPTY"
assert_exit "unclosed frontmatter → 1 (body not metadata)" 1 "$REVIEW_GATE" "$SEMPTY" "$SNOCLOSE"
assert_exit "unresolvable range → 2"             2 "$REVIEW_GATE" deadbeef HEAD

echo
echo "── cross-stack-gate.sh (reviewed-by ≠ generated-by) ──"
assert_exit "passed claude/codex → 0"            0 "$CROSS_GATE" "$S0" "$SGOOD"
assert_exit "passed same stack (claude/claude) → 1" 1 "$CROSS_GATE" "$SGOOD" "$SSAME"
assert_exit "passed missing reviewed-by → 1"     1 "$CROSS_GATE" "$SSAME" "$SNOFIELD"
assert_exit "not-passed same stack → 0 (skipped)" 0 "$CROSS_GATE" "$SINPROG" "$SINPROGSAME"
assert_exit "passed compound claude+codex/codex → 0 (exact ineq)" 0 "$CROSS_GATE" "$SINPROGSAME" "$SCOMPOUND"
assert_exit "passed dup reviewed-by → 1 (ambiguous, fail closed)" 1 "$CROSS_GATE" "$SBODYFAKE" "$SDUP"
assert_exit "body-only review key → 0 (not passed → skipped)" 0 "$CROSS_GATE" "$SDOC" "$SBODYFAKE"
assert_exit "unclosed frontmatter → 0 (not passed → skipped)" 0 "$CROSS_GATE" "$SEMPTY" "$SNOCLOSE"
assert_exit "unresolvable range → 2"             2 "$CROSS_GATE" deadbeef HEAD

echo
echo "── run-merge-checks.sh (both entries, end-to-end) ──"
mkdir -p scripts/merge-checks.d
printf '#!/usr/bin/env bash\nexec "%s" "$@"\n' "$REVIEW_GATE" > scripts/merge-checks.d/10-review.sh
printf '#!/usr/bin/env bash\nexec "%s" "$@"\n' "$CROSS_GATE"  > scripts/merge-checks.d/20-cross.sh
chmod +x scripts/merge-checks.d/*.sh
assert_exit "aggregate clean cross-stack → 0"    0 "$RUNNER" "$S0" "$SGOOD"
assert_exit "aggregate same-stack passed → 1"    1 "$RUNNER" "$SGOOD" "$SSAME"

echo
echo "test-gates: ${pass} passed, ${fail} failed"
[ "$fail" -eq 0 ]
