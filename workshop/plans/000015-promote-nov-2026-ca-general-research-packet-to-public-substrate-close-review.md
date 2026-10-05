# Boundary Review — you-decide#15 (whole-issue close)

| field | value |
|-------|-------|
| issue | 15 — Promote Nov-2026 CA general research packet to public substrate |
| repo | you-decide |
| issue file | workshop/issues/000015-promote-nov-2026-ca-general-research-packet-to-public-substrate.md |
| boundary | whole-issue close |
| milestone | — |
| window | 41315f5d4bc0a885db771155260b1508ba8b312d..91d5a97368f23c037998eba9c2f2608faaf99172 |
| command | sdlc close --issue 15 |
| reviewer | claude |
| timestamp | 2026-10-04T19:57:14-07:00 |
| verdict | FIX-THEN-SHIP |

## Review

```verdict
verdict: FIX-THEN-SHIP
confidence: high
```

**Verdict: fix, then ship.** I found no Critical problems. I checked each Done-when item directly instead of relying on the commit messages or the issue log:
- `ballot.json` parses and has 48 contests.
- All 48 `research_file#research_anchor` pairs resolve to a heading in their report.
- Every relative link in the manifest points to a file that exists.
- The ballot PDF is not in the tree, and `ballot.json` has `source.pdf = null` with a note explaining why.
- Every gated `.md` file has `review: passed` with `reviewed-by ≠ generated-by` (codex↔claude).
- The supplement has no scoring or recommendations.
- The atlas and `lessons.md` are updated.

Two cheap fixes remain. The manifest's district tags don't fully match what the `resolve-ballot.md` filter expects, and the README still tells readers to use a PDF that is no longer published.

1. **Strengths**
   - Strong privacy handling. The voter-exported PDF is held back, `ballot.json` records why, and the atlas now has a "never publish a voter-exported ballot" rule (`atlas/substrate.md:31`). The lesson about checking binary metadata and rendered pages, not just extracted text, is the right general rule.
   - Coverage limits are stated honestly in both the manifest frontmatter (`coverage:` BT-114 only) and the README.
   - Review records were moved to `data/reviews/2026/`, which keeps the substrate folder clean and follows the existing convention.
   - The manifest is built from `ballot.json` (ARCH-DRY), so the anchors can't drift from the structured source.
   - The scan for personal identifiers came back clean on the text transcription. It contains only county-guide headers, the timestamp and page footers.

2. **Critical:** none.

3. **Important**
   - **District tags in the manifest don't match the filter's tags.** At `data/elections/2026/2026-11-03-CA-general.md:159`, the school board uses `District: MPCSD`. `resolve-ballot.md` Stage 2 resolves school districts as `MENLO-PARK-CSD`. Stage 3 includes a race only when the tags match exactly, so a voter in that district would silently lose the race.
     - The new tags `SEQUOIA-UHSD-AREA-D`, `RTM-DISTRICT`, `SMCCCD` and `CA-APPEAL-D1` are also missing from the Stage 2 list.
     - Fix: change the tag to `MENLO-PARK-CSD`, or add the new tags to the Stage 2 list in `resolve-ballot.md`. Either way there should be one tag vocabulary (ARCH-DRY / ARCH-PURPOSE: the manifest's job is to feed the filter).

4. **Minor**
   - `README.md:34` says "use the PDF if extraction looks ambiguous", but the PDF is withheld. Point to the county omniballot tool instead.
   - `README.md:55` says ordering "follows the PDF". It should say "follows the printed reference ballot".
   - The manifest has two `## Candidate contests` headings (lines 28 and 137). That produces duplicate anchors and breaks the schema's grouping by jurisdiction. Rename the second one (e.g. "Nonpartisan candidate contests") or regroup the contests.
   - The manifest has no `## Sources` section, which the schema and the primary manifest both have. The URLs are only in frontmatter.
   - The working tree has an uncommitted change to the top-level `README.md`, outside the review window. Make sure it's meant to be separate from #15 or commit it.

5. **Test coverage**
   - No code changed. The anchor-resolution and link-existence checks were run by hand (I re-ran both, and both pass), but nothing commits them.
   - A small script that checks `ballot.json` anchors and manifest links for every `data/elections/*/ballot.json` would stop future packets from drifting. It's worth adding when #13's data model lands.

6. **Architecture notes**
   - **ARCH-DRY: flagged.** The district-tag vocabulary diverges (Important finding above). Otherwise the manifest is derived from `ballot.json`, which is correct.
   - **ARCH-PURE: N/A.** This change is data only.
   - **ARCH-PURPOSE: passes.** The deferrals (folding the supplement into the `data/candidates/` dossiers, adding a `data/measures/` home) are genuinely separate from this issue's purpose of moving and exposing the packet.
   - **ARCH-MOCK: N/A.**
   - **ARCH-CONSTRAINTS: N/A.**
   - **ARCH-SECURE: passes.** The PDF's provenance was treated as untrusted, and both the metadata leak and the rendered selection mark were handled. Nothing was ever committed, so no history scrub is needed.
   - **ARCH-ORDER: N/A.** These are static files and hold no state between events.
   - **ARCH-FUNERAL: passes, with a note.** The dated `supplement-2026-10-04.md` file family has a named end: it gets folded into the dossiers in the follow-up. If more supplements are expected, record that retirement rule in the atlas.

7. **Plan revisions**
   - Add a `## Revisions` entry noting the Spec changed. It said "`sources/` PDF+txt", but the delivered packet has only the txt, because the PDF was withheld after the cross-stack review found privacy problems. The Log mentions this, but the Spec text still promises the PDF.

```findings
findings:
  - id: new
    severity: Important
    family: district-tag-vocabulary-single-source
    title: |
      Manifest district tags (MPCSD, SEQUOIA-UHSD-AREA-D, RTM-DISTRICT, SMCCCD, CA-APPEAL-D1) are missing from resolve-ballot Stage 2's tag list
    detail: |
      Stage 3 includes a race only when tags match exactly. Stage 2 lists MENLO-PARK-CSD, so the MPCSD race at manifest line 159 would be silently dropped. Use one tag vocabulary: retag the races or extend the Stage 2 list.
  - id: new
    severity: Minor
    family: stale-reference-to-withheld-artifact
    title: |
      Packet README still points readers to the withheld PDF (lines 34 and 55)
    detail: |
      Replace "use the PDF" with the county omniballot tool, and "follows the PDF" with "follows the printed reference ballot".
  - id: new
    severity: Minor
    family: manifest-schema-conformance
    title: |
      Manifest has duplicate Candidate contests headings and no Sources section, unlike the resolve-ballot schema
  - id: new
    severity: Minor
    family: spec-revision-on-scope-change
    title: |
      Issue Spec still promises the sources/ PDF; add a Revisions entry recording that it was withheld
```
