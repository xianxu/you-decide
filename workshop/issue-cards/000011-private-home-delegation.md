---
id: '000011'
status: done
created: 2026-06-02
updated: 2026-06-02
estimate_hours: 2
actual_hours: 2
---

# Private home: split routing/longevity out of the shared algorithm

## Problem

`you-decide` is meant to be the publishable, multi-user *algorithm*, but it
currently hardcodes the **private side** into itself:

- the entire "Path conventions" section of `SKILL.md` (the `who-to-vote-for/...`
  layout, the `data/candidates/` vs private-read split rationale),
- `scripts/private-dir.sh` resolution and the `$YOU_DECIDE_PRIVATE_DIR` /
  sibling-default logic,
- the brain-integration note (symlink + brain-resident private tree).

So the reusable algorithm knows one user's home address. Two costs:

1. **Publishability leak.** Publishing `you-decide` carries Xian's path
   assumptions out with it; the public artifact is not genuinely user-agnostic.
2. **No registry for artifact types.** When the user said *"record my vote,
   find a place"* (2026-06-02), there was **no convention** — the agent
   improvised `menlo-park-2026-06-02-cast.md` ad hoc. A cast-ballot is an
   obvious recurring artifact type and nothing owned its name, location, or
   frontmatter. That gap is the concrete evidence this seam needs a home.

This issue separates **where private things live** (routing/longevity) from
**the algorithm that reasons over them**, and has the algorithm *delegate* to
the former.
