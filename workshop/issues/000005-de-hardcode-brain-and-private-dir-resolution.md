---
id: 000005
status: open
deps: []
created: 2026-05-28
updated: 2026-05-28
---

# De-hardcode brain origin + private-dir resolution for standalone use

## Context

`you-decide` was extracted from Xian's brain, and the extraction left two
artifacts baked into the public repo:

1. **Hardcoded brain path / user.** Skill + atlas files name
   `brain/data/life/politics/who-to-vote-for/` as *the* private location, and
   `philosophy-xian.md` as the philosophy-shape exemplar. A non-Xian standalone
   user has neither.
2. **Unsafe standalone default.** `SKILL.md` + `README` say a standalone install
   "resolves [private] via the repo root" — which would write the user's
   political philosophy, reads, and votes *inside the cloned repo*, contradicting
   the headline privacy promise ("your view is yours to keep private"). And
   `YOU_DECIDE_PRIVATE_DIR` is documented in the README but read by nothing.

A real privacy leak was also found: `candidates/2026/CA/us-house-d16/
sam-liccardo.md` (a shared, committed profile) embeds a full
`## Reading against philosophy-xian.md` section — Xian's per-axis scores and
preferences. Reads are supposed to be private (atlas/substrate.md). The private
copy already exists in the brain at `who-to-vote-for/.../sam-liccardo-read.md`.

## Spec

### Private-dir resolution (decided with operator)

The repo is read-only substrate for most users. Resolve the private dir **fresh
every invocation** — no state written into the repo, no interactive prompt:

1. `$YOU_DECIDE_PRIVATE_DIR` if set and non-empty (explicit override).
2. else `<repo-root>/../who-to-vote-for` (sibling of the repo root — outside the
   repo, so `git push` can never leak it).

Resolved **logically** (honoring symlinks) so a brain install reached via the
`brain/data/life/politics/you-decide` symlink lands on the brain's own
`who-to-vote-for/` — but that's a bonus; brain installs should set
`YOU_DECIDE_PRIVATE_DIR` explicitly (their data isn't beside the physical repo).

Implement as `scripts/private-dir.sh` (real committed file): resolve + `mkdir -p`
+ echo the absolute path. The skill's path-convention is: shared substrate
(`candidates/`, `elections/`, …) is repo-root-relative; the private
`who-to-vote-for/...` paths mean `<private-dir>/...`. Stage 0 announces the
resolved location to the user once (transparency, non-blocking).

### De-hardcoding

- `philosophy-xian.md` shape references → the documented shape in
  `atlas/survey-and-philosophy.md` (+ generic `philosophy-<user>.md`). No
  fake-user exemplar file.
- "the user's private brain" / "encrypted brain" phrasing → "the user's private
  dir" (resolved as above). Keep the public/private split *rationale*.
- Brain-specific provenance in atlas softened to not present the brain path as
  the operative location.
- README: make `YOU_DECIDE_PRIVATE_DIR` real (document precedence + default);
  fix the "standalone → repo root" note.

### Privacy fix

- Excise the `## Reading against philosophy-xian.md` section from
  `candidates/.../sam-liccardo.md` (private read leaked into shared profile).

## Plan

- [ ] `scripts/private-dir.sh` — resolver (env → ../who-to-vote-for, logical, mkdir).
- [ ] `you-decide/SKILL.md` — path conventions + Stage 0 + "private brain"→"private dir".
- [ ] `you-decide/bootstrap-survey.md`, `surveys/{progressive,essay}.md` — shape ref + private dir.
- [ ] `you-decide/{resolve-ballot,review}.md`, `templates/governor.md` — phrasing.
- [ ] `atlas/{overview,substrate,algorithm,survey-and-philosophy}.md` — de-hardcode.
- [ ] `README.md` — real env var + resolution + path note.
- [ ] Excise leaked read from `candidates/.../sam-liccardo.md`.
- [ ] Verify resolver (standalone default + env override); grep clean of `philosophy-xian` / hardcoded brain path outside history.

## Log
