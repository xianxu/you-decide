#!/usr/bin/env bash
# test-stale-reads.sh — fixture test for scripts/stale-reads.sh.
# Builds a throwaway private dir via $YOU_DECIDE_PRIVATE_DIR and asserts the
# detector flags exactly the stale reads/votes (frontmatter-date based).
set -euo pipefail

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
DETECTOR="$script_dir/../stale-reads.sh"

fixture="$(mktemp -d "${TMPDIR:-/tmp}/stale-reads-test.XXXXXX")"
trap 'rm -rf "$fixture"' EXIT
race="$fixture/2026/CA/test-race"
mkdir -p "$race" "$fixture/calibration-skills"

mk() { mkdir -p "$(dirname "$1")"; printf '%s\n' "$2" > "$1"; }

# philosophy revised 2026-06-02; one calibration skill from 2026-05-01
mk "$fixture/philosophy-test.md"               $'---\ndate: 2026-05-27\ngenerated-on: 2026-05-28\nrevised: 2026-06-02\n---\nbody'
mk "$fixture/calibration-skills/x.md"          $'---\ngenerated-on: 2026-05-01\n---\nrule'
# a-read: dated 2026-05-28 -> STALE (philosophy 2026-06-02 newer)
mk "$race/a-read.md"                           $'---\nread-date: 2026-05-28\n---\nscore'
# b-read: revised 2026-06-03 -> FRESH (newer than every input)
mk "$race/b-read.md"                           $'---\nread-date: 2026-05-28\nrevised: 2026-06-03\n---\nscore'
# vote: revised 2026-05-29 -> STALE (sibling b-read 2026-06-03 + philosophy newer)
mk "$race/vote.md"                             $'---\nrevised: 2026-05-29\n---\nvote'

export YOU_DECIDE_PRIVATE_DIR="$fixture"

fails=0
assert_contains() { if printf '%s\n' "$1" | grep -qF "$2"; then echo "  ok: flagged $2"; else echo "  FAIL: expected $2 flagged"; fails=$((fails+1)); fi; }
assert_absent()   { if printf '%s\n' "$1" | grep -qF "$2"; then echo "  FAIL: $2 should be fresh"; fails=$((fails+1)); else echo "  ok: fresh $2"; fi; }

echo "case 1: mixed (expect a-read + vote stale, b-read fresh, exit 1)"
out="$("$DETECTOR" --quiet || true)"
ec=$("$DETECTOR" --quiet >/dev/null 2>&1; echo $?)
assert_contains "$out" "a-read.md"
assert_absent   "$out" "b-read.md"
assert_contains "$out" "vote.md"
[[ "$ec" == "1" ]] && echo "  ok: exit 1 when stale" || { echo "  FAIL: expected exit 1, got $ec"; fails=$((fails+1)); }

echo "case 2: all fresh (bump reads + vote past all inputs -> exit 0, no output)"
mk "$race/a-read.md" $'---\nread-date: 2026-05-28\nrevised: 2026-06-09\n---\nscore'
mk "$race/vote.md"   $'---\nrevised: 2026-06-09\n---\nvote'
out="$("$DETECTOR" --quiet || true)"; ec=$("$DETECTOR" --quiet >/dev/null 2>&1; echo $?)
[[ -z "$out" ]] && echo "  ok: no stale output" || { echo "  FAIL: unexpected stale: $out"; fails=$((fails+1)); }
[[ "$ec" == "0" ]] && echo "  ok: exit 0 when fresh" || { echo "  FAIL: expected exit 0, got $ec"; fails=$((fails+1)); }

echo ""
if [[ $fails -eq 0 ]]; then echo "PASS — all assertions green"; else echo "FAIL — $fails assertion(s) failed"; exit 1; fi
