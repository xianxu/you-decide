#!/usr/bin/env bash
# test-stale-reads.sh — fixture test for scripts/stale-reads.sh.
#
# Covers the happy path AND the fail-closed contract (workshop/lessons.md
# §2026-05-31): malformed / ambiguous input must read as STALE, never fresh.
# Each case builds an isolated throwaway private dir via $YOU_DECIDE_PRIVATE_DIR.
set -uo pipefail   # deliberately NOT -e: we run the detector and read its nonzero exits

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
DETECTOR="$script_dir/../stale-reads.sh"

dirs=()
cleanup() { for d in "${dirs[@]:-}"; do [[ -n "$d" ]] && rm -rf "$d"; done; }
trap cleanup EXIT

fails=0
ok()   { echo "  ok: $1"; }
bad()  { echo "  FAIL: $1"; fails=$((fails+1)); }
mkf()  { mkdir -p "$(dirname "$1")"; printf '%s' "$2" > "$1"; }

# new_priv — fresh private dir with a dated philosophy (revised 2026-06-02) and
# one calibration skill (2026-05-01). Echoes the path.
new_priv() {
  local d; d="$(mktemp -d "${TMPDIR:-/tmp}/sr.XXXXXX")"; dirs+=("$d")
  mkdir -p "$d/calibration-skills" "$d/dossiers" "$d/2026/CA/race"
  mkf "$d/philosophy-test.md"          $'---\nrevised: 2026-06-02\n---\nphilosophy body\n'
  mkf "$d/calibration-skills/x.md"     $'---\ngenerated-on: 2026-05-01\n---\nrule\n'
  printf '%s' "$d"
}
# a dossier (older than philosophy unless told otherwise) at <priv>/dossiers/<name>.md
mkdoss() { mkf "$1/dossiers/$2.md" "---"$'\n'"generated-on: ${3:-2026-05-01}"$'\n'"---"$'\n'"dossier"$'\n'; }

# run PRIV -> stale paths on stdout (warnings suppressed). Capture the exit code
# in the PARENT via `out="$(run ..)"; EC=$?` — a command substitution runs in a
# subshell, so EC must be read where the substitution completes, not inside run.
run() { YOU_DECIDE_PRIVATE_DIR="$1" "$DETECTOR" --quiet 2>/dev/null; }
has()  { printf '%s\n' "$1" | grep -qF "$2"; }

# ---------------------------------------------------------------------------
echo "case 1: mixed happy path with dossiers (a-read+vote stale, b-read fresh, exit 1)"
d="$(new_priv)"; mkdoss "$d" a; mkdoss "$d" b
mkf "$d/2026/CA/race/a-read.md" $'---\nread-date: 2026-05-28\ncandidate: ../../../dossiers/a.md\n---\nscore\n'
mkf "$d/2026/CA/race/b-read.md" $'---\nread-date: 2026-05-28\nrevised: 2026-06-03\ncandidate: ../../../dossiers/b.md\n---\nscore\n'
mkf "$d/2026/CA/race/vote.md"   $'---\nrevised: 2026-05-29\n---\nvote\n'
out="$(run "$d")"; EC=$?
has "$out" "a-read.md" && ok "a-read stale (philosophy newer)" || bad "a-read should be stale"
has "$out" "b-read.md" && bad "b-read should be fresh" || ok "b-read fresh"
has "$out" "vote.md"   && ok "vote stale (sibling b-read newer)" || bad "vote should be stale"
[[ "$EC" == 1 ]] && ok "exit 1 when stale" || bad "expected exit 1, got $EC"

echo "case 2: dossier edge — read fresh vs philosophy but its DOSSIER is newer -> stale (I2)"
d="$(new_priv)"; mkdoss "$d" a 2026-06-11
mkf "$d/2026/CA/race/a-read.md" $'---\nrevised: 2026-06-10\ncandidate: ../../../dossiers/a.md\n---\nscore\n'
out="$(run "$d")"; EC=$?
has "$out" "a-read.md" && ok "read flagged via candidate: dossier date" || bad "dossier edge not honored"

echo "case 3: all fresh -> exit 0, no output"
d="$(new_priv)"; mkdoss "$d" a; mkdoss "$d" b
mkf "$d/2026/CA/race/a-read.md" $'---\nrevised: 2026-06-09\ncandidate: ../../../dossiers/a.md\n---\nscore\n'
mkf "$d/2026/CA/race/b-read.md" $'---\nrevised: 2026-06-09\ncandidate: ../../../dossiers/b.md\n---\nscore\n'
mkf "$d/2026/CA/race/vote.md"   $'---\nrevised: 2026-06-09\n---\nvote\n'
out="$(run "$d")"; EC=$?
[[ -z "$out" ]] && ok "no stale output" || bad "unexpected stale: $out"
[[ "$EC" == 0 ]] && ok "exit 0 when fresh" || bad "expected exit 0, got $EC"

echo "case 4 (FAIL-CLOSED): unclosed fence must NOT leak a body date (C3, lessons §2026-05-31)"
d="$(new_priv)"; mkdoss "$d" a
# opening ---, an old date, NO closing fence, then a COLUMN-0 line that mimics a
# frontmatter date. With the fence guard this is body (unparsed) -> read has no
# date -> stale. WITHOUT the guard, fm() would read to EOF, `revised: 2099` would
# parse, and the read would look fresh -> this assertion then FAILS (locks C3).
mkf "$d/2026/CA/race/a-read.md" $'---\nread-date: 2020-01-01\ncandidate: ../../../dossiers/a.md\nrevised: 2099-01-01\n'
vout="$(YOU_DECIDE_PRIVATE_DIR="$d" "$DETECTOR" 2>/dev/null || true)"
has "$vout" "a-read.md" && ok "unclosed-fence read flagged stale (body 2099 not parsed as fresh)" || bad "C3 regressed: body date leaked -> false fresh"

echo "case 5 (FAIL-CLOSED): properly fenced but NO date key -> stale, via the no-date guard (C2)"
d="$(new_priv)"; mkdoss "$d" a
mkf "$d/2026/CA/race/a-read.md" $'---\nname: foo\ncandidate: ../../../dossiers/a.md\n---\nscore\n'
# Assert the TRIGGER is the no-date guard, not the base-date comparison — so the
# test fails if the explicit `[[ -z "$rd" ]]` branch is removed (locks C2).
vout="$(YOU_DECIDE_PRIVATE_DIR="$d" "$DETECTOR" 2>/dev/null || true)"
has "$vout" "no-date-in-read" && ok "date-less read flagged via the no-date guard" || bad "C2: date-less read not flagged by the no-date branch"

echo "case 6 (FAIL-CLOSED): unresolvable dossier -> stale even if the read date is recent (I2)"
d="$(new_priv)"
mkf "$d/2026/CA/race/a-read.md" $'---\nrevised: 2026-06-30\ncandidate: ../../../dossiers/NOPE.md\n---\nscore\n'
out="$(run "$d")"; EC=$?
has "$out" "a-read.md" && ok "missing-dossier read flagged stale" || bad "I2: missing dossier silently skipped -> false fresh"

echo "case 7 (FAIL-CLOSED): a date-less read sorting FIRST must not suppress a later stale read (C1)"
d="$(new_priv)"; mkdoss "$d" a
# aaa sorts before zzz; aaa has no date (stale), zzz is unambiguously stale
mkf "$d/2026/CA/race/aaa-read.md" $'---\nname: nodate\ncandidate: ../../../dossiers/a.md\n---\nx\n'
mkf "$d/2026/CA/race/zzz-read.md" $'---\nread-date: 2020-01-01\ncandidate: ../../../dossiers/a.md\n---\nx\n'
out="$(run "$d")"; EC=$?
has "$out" "aaa-read.md" && ok "first (date-less) read reported" || bad "C1: first read not reported"
has "$out" "zzz-read.md" && ok "later stale read reported (loop not truncated)" || bad "C1 regressed: loop truncated, later stale read lost"

echo "case 8 (FAIL-CLOSED): empty read file -> stale"
d="$(new_priv)"; : > "$d/2026/CA/race/a-read.md"
out="$(run "$d")"; EC=$?
has "$out" "a-read.md" && ok "empty read flagged stale" || bad "empty read read as fresh"

echo "case 9 (FAIL-CLOSED): undated philosophy -> everything stale, warning, still exit 1"
d="$(new_priv)"; mkf "$d/philosophy-test.md" $'---\nname: no-date-here\n---\nbody\n'; mkdoss "$d" a
mkf "$d/2026/CA/race/a-read.md" $'---\nrevised: 2026-06-30\ncandidate: ../../../dossiers/a.md\n---\nscore\n'
out="$(run "$d")"; EC=$?
has "$out" "a-read.md" && ok "undated philosophy -> read stale" || bad "I3: undated philosophy -> false fresh"
[[ "$EC" == 1 ]] && ok "exit 1" || bad "expected exit 1, got $EC"

echo "case 10: CRLF frontmatter parses (genuinely fresh read not falsely flagged)"
d="$(new_priv)"; mkdoss "$d" a
printf '%s\r\n' '---' 'revised: 2026-06-09' 'candidate: ../../../dossiers/a.md' '---' 'score' > "$d/2026/CA/race/a-read.md"
out="$(run "$d")"; EC=$?
has "$out" "a-read.md" && bad "CRLF date not parsed -> falsely stale" || ok "CRLF date parsed, read fresh"

echo "case 11 (FAIL-CLOSED): a read's own date is revised-first, not newest — a stray newer read-date must not mask staleness"
d="$(new_priv)"; mkdoss "$d" a 2026-06-05
# revised (authoritative re-derive) = 2026-06-01, OLDER than the dossier 2026-06-05 -> STALE.
# read-date = 2026-06-20 would mask it under a newest-wins own-date. fdate_own takes
# revised first, so it stays flagged; reverting to max makes this assertion FAIL.
mkf "$d/2026/CA/race/a-read.md" $'---\nrevised: 2026-06-01\nread-date: 2026-06-20\ncandidate: ../../../dossiers/a.md\n---\nscore\n'
out="$(run "$d")"; EC=$?
has "$out" "a-read.md" && ok "flagged on revised(06-01) vs dossier(06-05); newer read-date(06-20) did not mask" || bad "own-date masking: newest read-date hid staleness"

echo ""
if [[ $fails -eq 0 ]]; then echo "PASS — all assertions green"; else echo "FAIL — $fails assertion(s) failed"; exit 1; fi
