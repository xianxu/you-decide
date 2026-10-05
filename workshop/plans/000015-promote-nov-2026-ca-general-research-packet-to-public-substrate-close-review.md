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

---

## Re-review — 2026-10-04T19:59:16-07:00 (FIX-THEN-SHIP)

| field | value |
|-------|-------|
| issue | 15 — Promote Nov-2026 CA general research packet to public substrate |
| repo | you-decide |
| issue file | workshop/issues/000015-promote-nov-2026-ca-general-research-packet-to-public-substrate.md |
| boundary | whole-issue close |
| milestone | — |
| window | 41315f5d4bc0a885db771155260b1508ba8b312d..d6f4962b8e008647dddf2deb516c7b02c105ec27 |
| command | sdlc close --issue 15 |
| reviewer | claude |
| timestamp | 2026-10-04T19:59:16-07:00 |
| verdict | FIX-THEN-SHIP |

## Review

```verdict
verdict: FIX-THEN-SHIP
confidence: high
```

The issue can close. All four prior findings are fixed. The tag vocabulary is now a single list in `resolve-ballot.md` Stage 2, and every `District:` tag in the manifest matches it. Both gate scripts pass over `41315f5..d6f4962`. `ballot.json` parses, and the manifest lists 48 contests. `sources/` holds only `ballot-bt-114.txt`. One minor leftover remains: a note inside `ballot.json` still points to the withheld PDF. That contradicts the revised Done-when ("no file references the withheld PDF"). It costs one line to fix and doesn't block.

**1. Strengths**
- **The fix covers the whole class, not one race.** `you-decide/resolve-ballot.md:63-79` adds the missing kinds of district (BOE, Court of Appeal, trustee area, community-college district, `RTM-DISTRICT`). It also states the rule: manifests draw their tags only from this list, and a new kind of district extends the list in the same change. I checked every tag the manifest uses (`STATEWIDE`, `CA-BOE-D2`, `US-House-D16`, `CA-Assembly-D23`, `CA-APPEAL-D1`, `SM-COUNTY`, `MENLO-PARK`, `MENLO-PARK-COUNCIL-D2`, `MENLO-PARK-CSD`, `SEQUOIA-UHSD-AREA-D`, `SMCCCD`, `RTM-DISTRICT`). Each one matches the list.
- **The privacy problem was handled properly.** The PDF was withheld before its first commit, so no history scrub is needed. `ballot.json` sets `source.pdf: null` and gives the reason in `pdf_note`. The atlas rule ("Never publish a voter-exported ballot", `atlas/substrate.md:31`) and the new entry in `workshop/lessons.md` keep it from happening again.
- **The scope change is recorded properly.** `## Revisions` and the revised Done-when bullets state it, rather than rewriting the Spec.
- **The manifest now has one heading per section**, plus `## Sources` and `## Revisions` sections.

**2. Critical:** none.

**3. Important:** none.

**4. Minor**
- **`data/elections/2026/2026-11-03-CA-general/ballot.json:21`:** `"candidate_order": "As printed in supplied PDF; not a ranking"` still refers to the withheld PDF. This is the 2nd finding in family `stale-reference-to-withheld-artifact`. Last round fixed the two Markdown instances in the README, but the sweep didn't cover the packet's JSON notes. The rule: when an artifact is withheld, sweep every file in the packet, including the `.json` files, for prose references to it. URLs to public county or state PDFs are fine. Run `grep -rniE 'supplied pdf|the pdf|pdf export' <packet>`, and change line 21 to "As printed in the reference ballot (see `sources/ballot-bt-114.txt`)". The review records in `data/reviews/` describe the PDF as part of the record, which is acceptable.

**5. Test coverage**
- There are no executable tests, which is expected for data substrate. The evidence is the gate scripts (both pass), `ballot.json` parsing, and the manifest's count of 48.
- The tag-vocabulary rule is enforced only by prose; nothing checks it mechanically. A short check script would close that gap: pull the `District:` values out of each manifest and match them against the Stage 2 patterns. That is follow-up work, not a blocker.

**6. Architecture notes**
- **ARCH-DRY: pass.** There is now one tag vocabulary.
- **ARCH-PURE: N/A.** The diff contains no code.
- **ARCH-PURPOSE: pass.** The packet moved, and the manifest and supplement were written. The follow-ups (folding into `data/candidates/`, a home for measures) are separate extensions tied to #13, not the point of this issue.
- **ARCH-MOCK: N/A.** No external calls were added.
- **ARCH-CONSTRAINTS: N/A.** These are static data files.
- **ARCH-SECURE: pass.** The PDF metadata and on-screen selection mark were caught and the PDF was withheld. I found no personal identifiers in the published text.
- **ARCH-ORDER: N/A.** Nothing holds state between events.
- **ARCH-FUNERAL: pass.** The election folder and the dated supplement are scoped to one election, and they end the way other per-election data ends in `data/elections/`.
- **Watch for later:** the vocabulary rule should become a check script before a second election manifest lands, because rules enforced only by prose tend to drift.

**7. Plan revisions:** none needed. The Spec, Revisions and Done-when match the code.

```findings
dispose:
  - id: BR-1
    disposition: addressed
    note: |
      Stage 2 extended (resolve-ballot.md:63-79) with single-vocabulary rule; all manifest District tags verified to match.
  - id: BR-2
    disposition: addressed
    note: |
      README:33-34 now points to the omniballot county tool; no "use the PDF" pointer remains.
  - id: BR-3
    disposition: addressed
    note: |
      Manifest headings now unique; Sources section at line 202.
  - id: BR-4
    disposition: addressed
    note: |
      Revisions entry records the PDF withholding; Done-when revised to match.
findings:
  - id: new
    severity: Minor
    family: stale-reference-to-withheld-artifact
    title: |
      ballot.json field_notes.candidate_order still says "As printed in supplied PDF"
    detail: |
      2nd finding in this family. Rule: when an artifact is withheld, sweep every file in the packet including JSON notes, not just Markdown. Retarget line 21 to the text transcription.
```
