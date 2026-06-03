---
batch: ca-supt-public-instruction
date: 2026-06-02
reviewer-stack: codex
producing-stack: claude
scope: candidates
files-reviewed: 4
issues-blocker: 0
issues-important: 0
issues-minor: 0
status: pass
---

# Review - ca-supt-public-instruction

Cross-stack review of four newly added 2026 California Superintendent of Public Instruction FACT dossiers. Applied `you-decide/review.md`, `you-decide/calibration-skills/source-hygiene-tier-list.md`, `data/sources/CA.md`, and `data/sources/US.md`. These are FACT dossiers, so no weighted-score math check was applicable.

2026-06-02 re-review: scoped only to `data/candidates/2026/CA/supt-public-instruction/richard-barrera.md`, after the prior blocker was revised. The other three SPI dossiers retain their prior passed verdicts.

## Issues found

### blocker

None. The prior Barrera blocker is resolved: the science-of-reading mandate / uniform-reading-curriculum / phonics-comprehension / "skill of a teacher" claim is now bound directly to the May 15, 2025 Voice of San Diego interview, and that source is present in the source table as the literacy-position source. The CTA-alignment sentence is explicitly marked as an inference and is separately contextualized with the 2024 EdSource article on CTA opposition to science-of-reading mandate legislation.

### important

None.

### minor

None.

## Files cleared

- `data/candidates/2026/CA/supt-public-instruction/anthony-rendon.md`
- `data/candidates/2026/CA/supt-public-instruction/al-muratsuchi.md`
- `data/candidates/2026/CA/supt-public-instruction/richard-barrera.md`
- `data/candidates/2026/CA/supt-public-instruction/sonja-shaw.md`

## Per-file verdicts

- `data/candidates/2026/CA/supt-public-instruction/anthony-rendon.md` - `review: passed`
- `data/candidates/2026/CA/supt-public-instruction/al-muratsuchi.md` - `review: passed`
- `data/candidates/2026/CA/supt-public-instruction/richard-barrera.md` - `review: passed`
- `data/candidates/2026/CA/supt-public-instruction/sonja-shaw.md` - `review: passed`

## Notes / observations

- No artifact leakage found with `rg -i 'WebSearch|franding|TBD|<unknown>|\[.*\]\(\)'` across the four scoped files.
- SPI party/lean handling is acceptable for the passed files: the office is described as nonpartisan, while partisan or coalition lean is separately caveated. CalMatters lists the SPI candidates as No Party Preference for this nonpartisan race; Rendon and Muratsuchi are also accurately described in body prose as Democratic elected officials.
- Rendon: the AB 1505-era charter/accountability claim is bounded correctly. The dossier credits AB 1505 to Patrick O'Donnell, uses Newsom/EdSource/CalMatters for the law and charter-accountability context, and marks the Rendon-specific link as a Speaker-era inference plus a low-severity `DATA-GAP` for individual roll-call retrieval.
- Muratsuchi: the AB 84 and AB 1454 claims are adequately bound to Tier B sources. EdSource supports the AB 84 charter-oversight, small-district/nonclassroom-charter cap, OIG/subpoena-power, withdrawal, and stakeholder-conflict details. CalMatters supports the AB 1454 phonics/science-of-reading compromise, optional district participation, co-sponsorship, CTA neutral posture, and EdVoice support.
- Barrera: CTA/CCSA dual endorsement, the CTA IE caveat, the approximate $5M CTA spending figure, the separate ~$5.6M total IE context, Barrera's ~$220K direct fundraising, and CCSA's approximate $40K ad spending are adequately caveated as IE/direct distinctions and bound to EdSource, CalMatters, and Voice of San Diego. The union-capture read is explicitly labeled as inference.
- Barrera re-review: no decisive claim rests on Tier C or a domain-level URL. The Tier C CTA page is used only as an endorser advocacy page and the endorsement is independently supported by Tier B sources. The Tier C EdSource reader comment is explicitly labeled unverified and used only as the shape of a critique, with the unsupported figures demoted to a low-severity `DATA-GAP`.
- Barrera: the ethnic-studies claim is adequately sourced to EdSource for the fact that he persuaded the San Diego board to mandate ethnic studies in high school and supports ethnic studies in his SPI platform. The dossier does not overextend into an unsupported "struggle-oriented" framing.
- Barrera re-review: the Shaw-style high-stakes parental-notification/legal items are not present in this file.
- Shaw: the Chino Valley parental-notification policy and Sept. 11, 2024 permanent-injunction outcome are presented neutrally and bound to CA DOJ / court materials plus EdSource. The dossier correctly distinguishes the enjoined gender-disclosure provisions from the narrower records-notification provision that survived for minor students, and it does not rely on partisan outlets for the legal outcome.
- Low-severity `DATA-GAP` markers use the requested shape `[axis: ...; severity: low; last-attempt: 2026-06-02]` and do not block passage.
