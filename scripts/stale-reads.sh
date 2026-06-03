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

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(cd -- "$script_dir/.." && pwd)"
PRIVATE_DIR="$("$script_dir/private-dir.sh")"
CANDIDATES_DIR="$repo_root/data/candidates"

# fdate FILE KEY [KEY...] — print the first present frontmatter date value,
# trying KEYs in priority order. Only scans the leading `---`…`---` block.
fdate() {
  local file="$1"; shift
  [[ -f "$file" ]] || return 0
  local fm
  fm="$(awk 'NR==1 && /^---[[:space:]]*$/ {f=1; next} f && /^---[[:space:]]*$/ {exit} f {print}' "$file")"
  local key v
  for key in "$@"; do
    v="$(printf '%s\n' "$fm" | sed -n "s/^${key}:[[:space:]]*//p" | head -1 | tr -d '[:space:]')"
    [[ -n "$v" ]] && { printf '%s' "$v"; return 0; }
  done
}

# maxd A B — print the lexicographically greater ISO date (empty sorts smallest).
maxd() { if [[ "${1:-}" > "${2:-}" ]]; then printf '%s' "${1:-}"; else printf '%s' "${2:-}"; fi; }

# --- baseline: max(philosophy, all calibration skills) — applies to every read ---
phil="$(ls "$PRIVATE_DIR"/philosophy-*.md 2>/dev/null | grep -v -- '-from-survey' | head -1 || true)"
phil_date="$(fdate "$phil" revised generated-on date)"
phil_name="$(basename "${phil:-philosophy}")"

calib_max=""; calib_who=""
shopt -s nullglob
for cs in "$PRIVATE_DIR"/calibration-skills/*.md; do
  d="$(fdate "$cs" revised generated-on)"
  if [[ "$d" > "$calib_max" ]]; then calib_max="$d"; calib_who="$(basename "$cs")"; fi
done
shopt -u nullglob

base="$(maxd "$phil_date" "$calib_max")"
if [[ "$base" == "$phil_date" ]]; then base_who="$phil_name"; else base_who="calibration:$calib_who"; fi

stale=0
report() {  # report FILE TRIGGER DATE
  stale=1
  if [[ $quiet -eq 1 ]]; then printf '%s\n' "$1"
  else printf '%s  <-- newer: %s (%s)\n' "$1" "$2" "$3"; fi
}

# --- reads ---
while IFS= read -r read; do
  rd="$(fdate "$read" revised read-date generated-on)"
  trig="$base_who"; td="$base"
  # dossier by convention: <private>/REL/<slug>-read.md -> data/candidates/REL/<slug>.md
  rel="${read#"$PRIVATE_DIR"/}"
  doss="$CANDIDATES_DIR/${rel%-read.md}.md"
  if [[ -f "$doss" ]]; then
    dd="$(fdate "$doss" last-updated revised generated-on)"
    if [[ "$dd" > "$td" ]]; then td="$dd"; trig="dossier:$(basename "$doss")"; fi
  fi
  [[ "$td" > "$rd" ]] && report "$read" "$trig" "$td"
done < <(find "$PRIVATE_DIR" -name '*-read.md' | sort)

# --- votes (downstream of their race's reads) ---
while IFS= read -r vote; do
  vd="$(fdate "$vote" revised date generated-on)"
  trig="$base_who"; td="$base"
  for sib in "$(dirname "$vote")"/*-read.md; do
    [[ -f "$sib" ]] || continue
    sd="$(fdate "$sib" revised read-date generated-on)"
    if [[ "$sd" > "$td" ]]; then td="$sd"; trig="read:$(basename "$sib")"; fi
  done
  [[ "$td" > "$vd" ]] && report "$vote" "$trig" "$td"
done < <(find "$PRIVATE_DIR" -name 'vote.md' | sort)

exit $stale
