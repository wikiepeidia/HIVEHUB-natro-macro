---
status: human_needed
phase: 03-live-flow-validation
verified: 2026-04-24
sources:
  - 03-01-SUMMARY.md
  - 03-02-SUMMARY.md
requirements:
  - FLOW-02
  - SAFE-02
human_verification:
  - Run `.planning/phases/03-live-flow-validation/03-MANUAL-VALIDATION.md` against a real Roblox-backed Trading Hub cycle and fill in the result log.
gaps: []
---

# Phase 03 Verification

## Result

Phase 3 static readiness is complete. The root macro now skips unsupported Trading Hub sprinkler setup, the existing Trading Hub route remains valid, and no active Trading Hub-specific bitmap lookup was found in the root runtime. A full Roblox-backed Trading Hub cycle still needs human execution, so this phase remains at `human_needed` rather than `passed`.

## Automated Checks

- `cmd //c "submacros\\AutoHotkey64.exe /Validate /ErrorStdOut submacros\\natro_macro.ahk"` passed after the Phase 3 runtime change.
- `grep -nF 'if (field="Trading Hub") {' submacros/natro_macro.ahk` confirmed the donor-matched Trading Hub early return exists inside `nm_setSprinkler(field, loc, dist)`.
- `md5sum paths/gtf-tradinghub.ahk "Hub file/paths/gtf-tradinghub.ahk"` confirmed the root and donor Trading Hub route files are identical.
- `! grep -RiqE 'tradinghub|trading hub' nm_image_assets` confirmed there are no Trading Hub-named bitmap assets in the active asset tree.
- `! grep -nE 'bitmaps\[.*trading|nm_image_assets.*trading' submacros/natro_macro.ahk` confirmed the root runtime has no Trading Hub-specific bitmap lookup or Trading Hub-named asset reference.
- `grep -nF 'Rejoin()' submacros/natro_macro.ahk` confirmed the Trading Hub exit path still routes through `Rejoin()`.
- `grep -nE '^FieldName[123]=' settings/nm_config.ini` confirmed gather slot persistence still uses the existing root gather config keys.
- `grep -nE 'Trading Hub|Rejoin|sprinkler|missing-image|gtf-tradinghub' .planning/phases/03-live-flow-validation/03-MANUAL-VALIDATION.md` confirmed the manual validation guide covers the active runtime surfaces.

## Requirement Coverage

- `FLOW-02`: The root runtime now skips unsupported Trading Hub sprinkler setup, preserves the existing route and exit behavior, and provides a concrete manual checklist for the remaining in-game gather-cycle proof.
- `SAFE-02`: The active root runtime currently has no Trading Hub-specific bitmap lookup to refresh; the manual run must still confirm no missing-image or missing-file dialogs appear during a real Trading Hub cycle.

## Must-Haves

- Trading Hub gather setup no longer attempts unsupported sprinkler-placement movement.
- The active root runtime has an evidence-based answer for Trading Hub asset compatibility instead of a speculative bitmap pack.
- A repeatable manual checklist exists for launch, select, travel, gather, and exit through the root macro.
- The phase output states clearly that the live Roblox-backed cycle is still human-needed.

## Human Verification

Run `.planning/phases/03-live-flow-validation/03-MANUAL-VALIDATION.md` and fill its result log during a real Trading Hub run. A successful closeout should confirm:

- Trading Hub can be selected and launched from the root macro.
- Travel reaches Trading Hub through the existing route.
- Gather begins without Trading Hub sprinkler-placement movement.
- No missing-image or missing-file dialogs appear.
- Exit returns through `Rejoin()`.

## Gaps

None in static readiness. The only remaining step is the human-run Trading Hub cycle described above.
