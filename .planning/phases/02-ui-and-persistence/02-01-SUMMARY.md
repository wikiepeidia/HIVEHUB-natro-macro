---
phase: 02-ui-and-persistence
plan: 01
subsystem: ui
tags: [autohotkey, trading-hub, ui, persistence, gather]
requires:
  - phase: 01-runtime-wiring
    provides: Root Trading Hub route, defaults, and return behavior
provides:
  - Gather-only Trading Hub field selector wiring
  - Trading Hub and Rejoin gather import validation
  - Preserved planter/manual field registry boundary
affects: [ui-guardrails, live-flow-validation]
tech-stack:
  added: []
  patterns: [gather-only field list split, existing gather ini persistence reuse]
key-files:
  created: [.planning/phases/02-ui-and-persistence/02-01-SUMMARY.md]
  modified: [submacros/natro_macro.ahk]
key-decisions:
  - "Expose Trading Hub through a dedicated gatherfieldnamelist instead of widening fieldnamelist."
  - "Keep nm_PasteGatherSettings on the existing gather key path while expanding validation to Trading Hub and Rejoin."
patterns-established:
  - "Special destinations can be surfaced in gather UI through a selector-specific list without widening shared field registries."
  - "Gather import validation should use the same dedicated selector list as the main gather dropdowns."
requirements-completed: [FIELD-01, FIELD-02]
duration: 1 min
completed: 2026-04-24
---

# Phase 02 Plan 01: UI Selector And Import Summary

**Gather-only Trading Hub selector wiring with shared-registry isolation and Rejoin-capable gather import validation**

## Performance

- **Duration:** 1 min
- **Started:** 2026-04-24T14:16:25+07:00
- **Completed:** 2026-04-24T14:16:59+07:00
- **Tasks:** 2
- **Files modified:** 1

## Accomplishments

- Added a dedicated `gatherfieldnamelist` so the main gather slot dropdowns can expose Trading Hub without widening the shared `fieldnamelist`.
- Rewired `FieldName1..3` to the gather-only selector surface while leaving `MFieldList` on the original planter-safe registry.
- Updated `nm_PasteGatherSettings` so gather imports now accept both `Name=Trading Hub` and `ReturnType=Rejoin` through the existing gather INI keys.

## Task Commits

Each task was committed atomically:

1. **Task 1: Create a gather-only Trading Hub selector surface** - `3109710` (feat)
2. **Task 2: Accept Trading Hub and Rejoin through the existing gather import path** - `c4a2ca6` (feat)

**Plan metadata:** not committed (`commit_docs=false`)

## Files Created/Modified

- `submacros/natro_macro.ahk` - Added the gather-only Trading Hub list, rewired the main gather dropdowns, and expanded gather import validation to Trading Hub plus Rejoin.

## Decisions Made

- Used a selector-specific list instead of appending Trading Hub to `fieldnamelist`, which keeps planter/manual field registries unchanged for Phase 2.
- Treated `nm_PasteGatherSettings` as part of the same gather-only exposure surface so pasted settings match what the main gather UI now allows.

## Deviations from Plan

None - plan executed exactly as written.

## Issues Encountered

- `apply_patch` is not available in this shell, so the file edit was applied with a precise in-place Node script instead.
- `rg` is not installed in this environment, so scoped verification commands were rerun with `grep`.

## User Setup Required

None - no external service configuration required.

## Next Phase Readiness

- Wave 2 can now add Trading Hub slot guardrails on top of a gather-only selector surface that no longer leaks into planter/manual field flows.
- Persisted and pasted Trading Hub selections now follow the existing root gather config path, so the next plan can focus on unsupported-control safety instead of storage changes.

---
*Phase: 02-ui-and-persistence*
*Completed: 2026-04-24*
