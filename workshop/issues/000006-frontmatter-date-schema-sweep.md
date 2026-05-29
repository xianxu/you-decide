---
id: 000006
status: open
deps: []
created: 2026-05-28
updated: 2026-05-28
---

# Normalize generated: / generated-on: frontmatter + enforce in audit-review

## Context

Codex's CA-2026 shared-substrate review (`reviews/2026/2026-05-28-ca-2026-shared-substrate.md`, minor finding) flagged mixed date fields: some substrate files carry **both** `generated:` and `generated-on:`. The `review.md` frontmatter contract only requires `generated-by`, `generated-on`, `review` — so a bare `generated:` is redundant and makes audit scripts noisier.

This is **schema/convention** work (file-format conformance + a small canonical-field decision + tooling enforcement), not data-content debt — hence a `workshop/issues/` item rather than an inline `DATA-GAP`/`DATA-FIXME` marker. (Routing rule, per `review.md`: data-content debt → inline markers; schema/tooling/convention → here.)

## Scope (current)

Exactly 4 files carry both fields today (candidate profiles already use `generated-on:` only):

- `elections/2026/2026-06-02-CA-primary.md`
- `controversies/2026/CA.md`
- `sources/US.md`
- `sources/CA.md`

## Spec

1. **Decide the canonical field.** Default: keep `generated-on:` (matches the `review.md` contract); drop bare `generated:` unless a specific datatype's schema in `construct/datatype/` explicitly defines `generated:` with distinct meaning. Confirm against the datatype defs before deleting.
2. **Sweep** the 4 files to the canonical shape.
3. **Enforce**: extend `scripts/audit-review.sh` to flag any file that carries a non-canonical/duplicate date field, so this can't silently reaccumulate. (Same greppable-audit spirit as the `review: not-done` check.)

## Plan

- [ ] Check `construct/datatype/` for any legitimate `generated:` usage; settle canonical field.
- [ ] Sweep the 4 files.
- [ ] Add the duplicate/non-canonical-date check to `audit-review.sh`.
- [ ] Note: these 4 files are review-cleared shared substrate — a frontmatter-only schema edit is metadata, not content, but confirm it doesn't trip the review gate (or re-touch is trivial).

## Log
