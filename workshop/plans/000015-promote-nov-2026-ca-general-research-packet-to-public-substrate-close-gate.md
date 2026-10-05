---
gate: boundary-review
issue: 15
id_prefix: BR
rounds:
    - "n": 1
      timestamp: "2026-10-04T19:57:14-07:00"
      agent: claude
      findings:
        - id: BR-1
          severity: Important
          title: Manifest district tags (MPCSD, SEQUOIA-UHSD-AREA-D, RTM-DISTRICT, SMCCCD, CA-APPEAL-D1) are missing from resolve-ballot Stage 2's tag list
          detail: 'Stage 3 includes a race only when tags match exactly. Stage 2 lists MENLO-PARK-CSD, so the MPCSD race at manifest line 159 would be silently dropped. Use one tag vocabulary: retag the races or extend the Stage 2 list.'
          family: district-tag-vocabulary-single-source
          round: 1
        - id: BR-2
          severity: Minor
          title: Packet README still points readers to the withheld PDF (lines 34 and 55)
          detail: Replace "use the PDF" with the county omniballot tool, and "follows the PDF" with "follows the printed reference ballot".
          family: stale-reference-to-withheld-artifact
          round: 1
        - id: BR-3
          severity: Minor
          title: Manifest has duplicate Candidate contests headings and no Sources section, unlike the resolve-ballot schema
          family: manifest-schema-conformance
          round: 1
        - id: BR-4
          severity: Minor
          title: Issue Spec still promises the sources/ PDF; add a Revisions entry recording that it was withheld
          family: spec-revision-on-scope-change
          round: 1
      recipe: milestone-review
      blocked: true
---

# Gate ledger — you-decide#15 (boundary-review)

Findings this gate raised, the stable ids the binary assigned them, and how
later rounds disposed of them. Generated — edit the gate, not this file.

## Round 1 — 2026-10-04T19:57:14-07:00 (claude) — BLOCKED

### Raised

- **BR-1** [Important] `district-tag-vocabulary-single-source` Manifest district tags (MPCSD, SEQUOIA-UHSD-AREA-D, RTM-DISTRICT, SMCCCD, CA-APPEAL-D1) are missing from resolve-ballot Stage 2's tag list
  Stage 3 includes a race only when tags match exactly. Stage 2 lists MENLO-PARK-CSD, so the MPCSD race at manifest line 159 would be silently dropped. Use one tag vocabulary: retag the races or extend the Stage 2 list.
- **BR-2** [Minor] `stale-reference-to-withheld-artifact` Packet README still points readers to the withheld PDF (lines 34 and 55)
  Replace "use the PDF" with the county omniballot tool, and "follows the PDF" with "follows the printed reference ballot".
- **BR-3** [Minor] `manifest-schema-conformance` Manifest has duplicate Candidate contests headings and no Sources section, unlike the resolve-ballot schema
- **BR-4** [Minor] `spec-revision-on-scope-change` Issue Spec still promises the sources/ PDF; add a Revisions entry recording that it was withheld

## Open findings

- **BR-1** [Important] `district-tag-vocabulary-single-source` Manifest district tags (MPCSD, SEQUOIA-UHSD-AREA-D, RTM-DISTRICT, SMCCCD, CA-APPEAL-D1) are missing from resolve-ballot Stage 2's tag list
- **BR-2** [Minor] `stale-reference-to-withheld-artifact` Packet README still points readers to the withheld PDF (lines 34 and 55)
- **BR-3** [Minor] `manifest-schema-conformance` Manifest has duplicate Candidate contests headings and no Sources section, unlike the resolve-ballot schema
- **BR-4** [Minor] `spec-revision-on-scope-change` Issue Spec still promises the sources/ PDF; add a Revisions entry recording that it was withheld
