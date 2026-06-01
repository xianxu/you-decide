# GitHub export snapshot — 2026-05-31

One-time raw export of the GitHub-side artifacts (issues + PR conversation)
taken **before** the `xianxu/you-decide` repo was deleted and recreated.

## Why this exists

The repo's git history was rewritten on 2026-05-31 to purge a leaked personal
home address from all commits (it had been committed verbatim into `SKILL.md`
examples + `resolve-ballot.md` during the initial brain→public extraction).
Force-pushing cleaned `main` + tags, but GitHub's immutable `refs/pull/4/head`
still pointed at a pre-rewrite commit containing the address. The only fully
effective removal was to **delete and recreate** the GitHub repo — which also
destroys Issues and PR conversation threads. This snapshot preserves them.

## Contents

- `issue-{1,2,3}.json` — GitHub Issues #1–#3 (title, body, comments, labels,
  timestamps). These are public *stubs*; the authoritative Spec/Plan/Log lives
  in `workshop/issues/` (`000002`←#1, `000003`←#2, `000004`←#3).
- `pr-4.json` — merged PR #4 (body, comments, reviews, commits). The merge
  itself is in git history; this preserves the GitHub-only discussion.

These are raw `gh ... --json` dumps. The `workshop/issues/` files remain the
real tracker — this is archival insurance, not a live source.
