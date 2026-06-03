#!/usr/bin/env bash
# private-dir.sh — resolve (and create) the directory that holds the user's
# PRIVATE voting deliberation: philosophy-<user>.md, per-axis reads, vote.md,
# and user-private calibration-skills.
#
# This directory is deliberately OUTSIDE the repo. For most users the repo is
# read-only substrate (candidate research, ballot manifests, templates); their
# philosophy and votes are personal and must never be capturable by a
# `git push` of you-decide. So nothing private is ever written into the repo
# tree, and this script writes no state into the (possibly read-only) repo —
# it recomputes the location fresh on every call.
#
# Resolution order:
#   1. $YOU_DECIDE_PRIVATE_DIR  if set and non-empty   (explicit override)
#   2. otherwise <repo-root>/../who-to-vote-for         (sibling of the repo root)
#
# The path is resolved LOGICALLY (symlinks preserved, no `pwd -P`). A
# brain-integrated install where brain/data/life/politics/you-decide is a
# symlink to this repo therefore lands on brain/data/life/politics/who-to-vote-for
# — the brain's own private tree — when the skill is invoked through that
# symlink. In a brain that mount is DECLARED, not coincidental: the brain's
# construct/deps carries a `data <url> data/life/politics/you-decide` row, so
# the private dir is the deterministic `who-to-vote-for` sibling of the declared
# mount. $YOU_DECIDE_PRIVATE_DIR remains available as an explicit override (e.g.
# to resolve against the *physical* checkout rather than the brain symlink).
#
# Prints the absolute path on stdout; creates it (mkdir -p) if missing.
# Idempotent. Usage: PRIVATE_DIR="$(scripts/private-dir.sh)"
set -euo pipefail

if [[ -n "${YOU_DECIDE_PRIVATE_DIR:-}" ]]; then
    dir="$YOU_DECIDE_PRIVATE_DIR"
else
    # repo root = parent of this script's directory (scripts/). `cd` defaults to
    # logical mode, so the symlinked prefix of a brain install is preserved and
    # the `..` is collapsed textually against it.
    script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
    repo_root="$(cd -- "$script_dir/.." && pwd)"
    dir="$(cd -- "$repo_root/.." && pwd)/who-to-vote-for"
fi

mkdir -p -- "$dir"
# Normalize to absolute (a relative $YOU_DECIDE_PRIVATE_DIR would otherwise
# print verbatim). Logical pwd, so the brain-symlink case is preserved.
dir="$(cd -- "$dir" && pwd)"
printf '%s\n' "$dir"
