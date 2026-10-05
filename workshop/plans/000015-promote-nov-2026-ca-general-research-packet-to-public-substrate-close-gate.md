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
    - "n": 2
      timestamp: "2026-10-04T19:59:16-07:00"
      agent: claude
      dispose:
        - id: BR-1
          disposition: addressed
          note: Stage 2 extended (resolve-ballot.md:63-79) with single-vocabulary rule; all manifest District tags verified to match.
          round: 2
        - id: BR-2
          disposition: addressed
          note: README:33-34 now points to the omniballot county tool; no "use the PDF" pointer remains.
          round: 2
        - id: BR-3
          disposition: addressed
          note: Manifest headings now unique; Sources section at line 202.
          round: 2
        - id: BR-4
          disposition: addressed
          note: Revisions entry records the PDF withholding; Done-when revised to match.
          round: 2
      findings:
        - id: BR-5
          severity: Minor
          title: ballot.json field_notes.candidate_order still says "As printed in supplied PDF"
          detail: '2nd finding in this family. Rule: when an artifact is withheld, sweep every file in the packet including JSON notes, not just Markdown. Retarget line 21 to the text transcription.'
          family: stale-reference-to-withheld-artifact
          round: 2
      recipe: milestone-review
      blocked: false
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

## Round 2 — 2026-10-04T19:59:16-07:00 (claude) — passed

### Disposed

- BR-1 — addressed — Stage 2 extended (resolve-ballot.md:63-79) with single-vocabulary rule; all manifest District tags verified to match.
- BR-2 — addressed — README:33-34 now points to the omniballot county tool; no "use the PDF" pointer remains.
- BR-3 — addressed — Manifest headings now unique; Sources section at line 202.
- BR-4 — addressed — Revisions entry records the PDF withholding; Done-when revised to match.

### Raised

- **BR-5** [Minor] `stale-reference-to-withheld-artifact` ballot.json field_notes.candidate_order still says "As printed in supplied PDF"
  2nd finding in this family. Rule: when an artifact is withheld, sweep every file in the packet including JSON notes, not just Markdown. Retarget line 21 to the text transcription.

## Open findings

- **BR-5** [Minor] `stale-reference-to-withheld-artifact` ballot.json field_notes.candidate_order still says "As printed in supplied PDF"
