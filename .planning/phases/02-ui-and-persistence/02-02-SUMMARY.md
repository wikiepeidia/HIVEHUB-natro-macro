---
phase: 02-ui-and-persistence
plan: 02
subsystem: ui
tags: [autohotkey, trading-hub, ui, guardrails, gather]
requires:
  - phase: 02-ui-and-persistence
    provides: Gather-only Trading Hub selector and import validation
provides:
  - Trading Hub slot guard helper for unsupported gather controls
  - Guard replay after gather unlock and config-driven field replay
  - Verified gather-only exposure boundary for Phase 2
affects: [live-flow-validation]
tech-stack:
  added: []
  patterns: [slot-specific trading hub guards, post-unlock guard replay]
key-files:
  created: [.planning/phases/02-ui-and-persistence/02-02-SUMMARY.md]
  modified: [submacros/natro_macro.ahk]
key-decisions:
  - "Implement Trading Hub control safety as a narrow helper reused by selection and unlock paths instead of duplicating donor blocks."
  - "Guard only real root controls and keep planter/manual field surfaces unchanged."
patterns-established:
  - "Unsupported special-field controls should be normalized through a slot helper that runs after both direct selection and generic unlock passes."
  - "Phase boundary validation should prove shared field registries still exclude special destinations after UI exposure work."
requirements-completed: [SAFE-01, FIELD-01, FIELD-02]
duration: 1 min
completed: 2026-04-24
---

# Phase 02 Plan 02: UI Guardrail Summary

**Trading Hub slot guardrails with post-unlock replay and explicit gather-only boundary verification**

## Performance

- **Duration:** 1 min
- **Started:** 2026-04-24T14:19:43+07:00
- **Completed:** 2026-04-24T14:20:41+07:00
- **Tasks:** 2
- **Files modified:** 1

## Accomplishments

- Added `nm_ApplyTradingHubSlotGuard(slot)` to disable unsupported Trading Hub gather controls using only real root control IDs.
- Hooked the Trading Hub guard helper into `nm_FieldSelect1`, `nm_FieldSelect2`, `nm_FieldSelect3`, and `nm_TabGatherUnLock()` so guarded state survives both direct selection and reload/unlock flows.
- Re-verified the Phase 2 boundary: Trading Hub remains gather-only, `MFieldList` still derives from the original shared field list, and `settings\nm_config.ini` still persists through `FieldName1..3`.

## Task Commits

Each task was committed atomically when code changed:

1. **Task 1: Add slot-specific Trading Hub guardrails to the gather UI** - `63b896a` (feat)
2. **Task 2: Validate gather-only Trading Hub UI and persistence boundaries** - no code changes (validation-only task)

**Plan metadata:** not committed (`commit_docs=false`)

## Files Created/Modified

- `submacros/natro_macro.ahk` - Added the Trading Hub slot guard helper and replay hooks for selection and gather unlock paths.

## Decisions Made

- Used a reusable slot guard helper instead of copying donor per-slot blocks into every code path.
- Included the existing `FDCHelp*` controls in the Trading Hub guard because drift compensation should be disabled as a full root-owned surface, not only as a checkbox.

## Deviations from Plan

None - plan executed exactly as written.

## Issues Encountered

- None.

## User Setup Required

None - no external service configuration required.

## Next Phase Readiness

- Phase 2 now leaves Trading Hub selectable, persisted, importable, and safely guarded inside the main gather UI.
- Phase 3 can focus on live Trading Hub field behavior, assets, and end-to-end validation instead of UI exposure or persistence plumbing.

---
*Phase: 02-ui-and-persistence*
*Completed: 2026-04-24*
