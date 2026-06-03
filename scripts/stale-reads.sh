#!/usr/bin/env bash
# stale-reads.sh — deterministic detector for cache-stale per-axis reads + votes.
#
# The you-decide algorithm (you-decide/SKILL.md, Stage 3) treats a `-read.md` as
# a PURE function of three inputs: the user's philosophy, the calibration skills,
# and the candidate dossier it scored against. A read is *stale* when any of
# those inputs is newer than the read. `vote.md` is downstream of its race's
# reads, so it is stale when philosophy/calibration OR any sibling read is newer.
#
# This is the HARD, deterministic half of the refresh loop (the soft re-score
# half lives in you-decide/refresh-reads.md). It compares **frontmatter dates**,
# not filesystem mtime — mtime is fragile under git checkouts and brain autosave,
# whereas the dated frontmatter the artifacts already carry is stable and
# git-portable. ISO `YYYY-MM-DD` dates compare correctly lexicographically.
#
# FAIL-CLOSED CONTRACT (per workshop/lessons.md §2026-05-31): the only failure
# mode that matters is the *permissive* one — a genuinely-stale artifact reading
# as fresh. So every ambiguous/malformed input is treated as STALE, never fresh:
#   - frontmatter without a closing `---` fence  -> no metadata parsed -> stale
#   - a read/vote with no parseable effective date -> stale
#   - a read whose dossier can't be resolved/found -> stale
#   - philosophy / a calibration skill / a dossier that is missing or UNDATED
#     -> treated as newer-than-everything (sentinel) -> dependents stale
# A body line that mimics `revised:` cannot leak in, because only a properly
# fenced leading block is ever scanned.
#
# Output: one line per stale file, `<path>  <-- newer: <trigger> (<date>)`.
# With --quiet: bare paths only. Exit 1 if any stale read/vote found (so it can
# gate a hook / CI), 0 if everything is fresh.
#
# Usage:
#   scripts/stale-reads.sh            # human-readable report
#   scripts/stale-reads.sh --quiet    # paths only (for piping to a re-score driver)
set -euo pipefail

quiet=0
[[ "${1:-}" == "--quiet" ]] && quiet=1

# A date guaranteed to sort after any real ISO date — the fail-closed sentinel
# for "this input is unverifiable, assume it is newer than everything".
SENTINEL_FUTURE="9999-12-31"

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(cd -- "$script_dir/.." && pwd)"
PRIVATE_DIR="$("$script_dir/private-dir.sh")"
CANDIDATES_DIR="$repo_root/data/candidates"

# fm FILE — print the leading frontmatter block, ONLY if it is properly fenced
# (`---` on line 1 AND a later closing `---`). No closing fence => no output, so
# a body line can never be read as metadata (fail closed). Always returns 0.
fm() {
  [[ -f "$1" ]] || return 0
  awk '
    NR==1 && /^---[[:space:]]*$/ { f=1; next }
    f && /^---[[:space:]]*$/     { closed=1; exit }
    f                           { buf = buf $0 "\n" }
    END { if (closed) printf "%s", buf }
  ' "$1"
  return 0
}

# fdate FILE KEY [KEY...] — newest ISO date among the given frontmatter keys
# (priority order is irrelevant once we take the max; duplicate keys take the
# newest value, the fail-closed choice for an input). Empty if none present or
# the block is unfenced. Always returns 0 (so `set -e` never aborts the caller).
fdate() {
  local file="$1"; shift
  local block; block="$(fm "$file")"
  local key v best=""
  for key in "$@"; do
    while IFS= read -r v; do
      v="${v//[[:space:]]/}"          # strip spaces + trailing CR (CRLF-safe)
      [[ -n "$v" && "$v" > "$best" ]] && best="$v"
    done < <(printf '%s\n' "$block" | sed -n "s/^${key}:[[:space:]]*//p")
  done
  printf '%s' "$best"
  return 0
}

# fval FILE KEY — first value of KEY in the fenced frontmatter, trailing-trimmed
# (used for the dossier path, which is not a date). Always returns 0.
fval() {
  local block; block="$(fm "$1")"
  local v
  v="$(printf '%s\n' "$block" | sed -n "s/^${2}:[[:space:]]*//p" | head -1)"
  v="${v%"${v##*[![:space:]]}"}"      # trim trailing whitespace/CR
  printf '%s' "$v"
  return 0
}

# resolve_rel BASEDIR REL — absolute path of REL interpreted from BASEDIR. The
# directory portion must exist (so we can cd), but the file itself need not — a
# *missing* dossier still yields a concrete path the caller tests with -f and
# fails closed on. Empty if the directory can't be resolved. Always returns 0.
resolve_rel() {
  local base="$1" rel="$2"
  [[ "$rel" = /* ]] && { printf '%s' "$rel"; return 0; }
  local abs
  abs="$(cd "$base" 2>/dev/null && cd "$(dirname "$rel")" 2>/dev/null && pwd)" || abs=""
  [[ -n "$abs" ]] && printf '%s/%s' "$abs" "$(basename "$rel")"
  return 0
}

# maxd A B — print the lexicographically greater ISO date (empty sorts smallest).
maxd() { if [[ "${1:-}" > "${2:-}" ]]; then printf '%s' "${1:-}"; else printf '%s' "${2:-}"; fi; }

stale=0
report() {  # report FILE TRIGGER DATE
  stale=1
  if [[ $quiet -eq 1 ]]; then printf '%s\n' "$1"
  else printf '%s  <-- newer: %s (%s)\n' "$1" "$2" "$3"; fi
}

# --- baseline: max(philosophy, all calibration skills) — applies to every read ---
# Philosophy is the dominant input. If it is missing or undated, no read can be
# verified -> fail closed by forcing the future sentinel (every read/vote stale).
phil="$(ls "$PRIVATE_DIR"/philosophy-*.md 2>/dev/null | grep -v -- '-from-survey' | head -1 || true)"
phil_date=""
[[ -n "$phil" && -f "$phil" ]] && phil_date="$(fdate "$phil" revised generated-on date)"
if [[ -z "$phil_date" ]]; then
  printf 'stale-reads: WARNING: philosophy missing or undated (%s) — failing closed (all stale)\n' "${phil:-<none found>}" >&2
  phil_date="$SENTINEL_FUTURE"; phil_name="philosophy(MISSING-OR-UNDATED)"
else
  phil_name="$(basename "$phil")"
fi

calib_max=""; calib_who=""
shopt -s nullglob
for cs in "$PRIVATE_DIR"/calibration-skills/*.md; do
  d="$(fdate "$cs" revised generated-on)"
  if [[ -z "$d" ]]; then
    printf 'stale-reads: WARNING: calibration skill undated (%s) — failing closed\n' "$(basename "$cs")" >&2
    d="$SENTINEL_FUTURE"
  fi
  if [[ "$d" > "$calib_max" ]]; then calib_max="$d"; calib_who="$(basename "$cs")"; fi
done
shopt -u nullglob

base="$(maxd "$phil_date" "$calib_max")"
if [[ "$base" == "$phil_date" ]]; then base_who="$phil_name"; else base_who="calibration:$calib_who"; fi

# --- reads ---
while IFS= read -r read; do
  rd="$(fdate "$read" revised read-date generated-on)"
  # no parseable date on the read itself -> cannot verify -> stale
  [[ -z "$rd" ]] && { report "$read" "no-date-in-read" "-"; continue; }

  # dossier: prefer the read's declared `candidate:` path; fall back to the
  # <private>/REL/<slug>-read.md -> data/candidates/REL/<slug>.md convention.
  doss=""
  cand="$(fval "$read" candidate)"
  [[ -n "$cand" ]] && doss="$(resolve_rel "$(dirname "$read")" "$cand")"
  if [[ -z "$doss" || ! -f "$doss" ]]; then
    rel="${read#"$PRIVATE_DIR"/}"
    conv="$CANDIDATES_DIR/${rel%-read.md}.md"
    [[ -f "$conv" ]] && doss="$conv" || doss=""
  fi
  # dossier unresolved/missing -> cannot verify the dossier edge -> stale
  [[ -z "$doss" || ! -f "$doss" ]] && { report "$read" "dossier-unresolved" "${cand:-<none>}"; continue; }

  trig="$base_who"; td="$base"
  dd="$(fdate "$doss" last-updated revised generated-on)"
  [[ -z "$dd" ]] && dd="$SENTINEL_FUTURE"        # undated dossier -> fail closed
  if [[ "$dd" > "$td" ]]; then td="$dd"; trig="dossier:$(basename "$doss")"; fi

  [[ "$td" > "$rd" ]] && report "$read" "$trig" "$td"
done < <(find "$PRIVATE_DIR" -name '*-read.md' | sort)

# --- votes (downstream of their race's reads) ---
while IFS= read -r vote; do
  vd="$(fdate "$vote" revised date generated-on)"
  [[ -z "$vd" ]] && { report "$vote" "no-date-in-vote" "-"; continue; }
  trig="$base_who"; td="$base"
  shopt -s nullglob
  for sib in "$(dirname "$vote")"/*-read.md; do
    [[ -f "$sib" ]] || continue
    sd="$(fdate "$sib" revised read-date generated-on)"
    [[ -z "$sd" ]] && sd="$SENTINEL_FUTURE"      # undated sibling read -> fail closed
    if [[ "$sd" > "$td" ]]; then td="$sd"; trig="read:$(basename "$sib")"; fi
  done
  shopt -u nullglob
  [[ "$td" > "$vd" ]] && report "$vote" "$trig" "$td"
done < <(find "$PRIVATE_DIR" -name 'vote.md' | sort)

exit $stale
