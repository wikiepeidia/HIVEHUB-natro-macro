---
phase: 01-runtime-wiring
plan: 02
subsystem: runtime
tags: [autohotkey, trading-hub, return-flow, rejoin]
requires:
  - phase: 01-runtime-wiring
    provides: Root Trading Hub route and default registrations
provides:
  - Rejoin-aware root return-type control
  - Explicit Trading Hub Rejoin exit branch
  - Trading Hub guard on the generic whirligig return path
affects: [config-loading, live-flow-validation, ui-and-persistence]
tech-stack:
  added: []
  patterns: [explicit return-type enums, special-destination exit guards]
key-files:
  created: []
  modified: [submacros/natro_macro.ahk]
key-decisions:
  - "Support Rejoin in the existing root return-type control instead of creating Trading Hub-only return handling."
  - "Prevent the generic whirligig path from consuming Trading Hub before the explicit Rejoin branch can run."
patterns-established:
  - "Special destinations should be guarded at shared exit-control points, not by widening field lists."
  - "Return-type controls should persist new enum values through the existing nm_config.ini write path."
requirements-completed: [FLOW-03, FLOW-04]
duration: 1 min
completed: 2026-04-24
---

# Phase 01 Plan 02: Return Flow Summary

**Root Rejoin return-type support with an explicit Trading Hub exit branch and a narrow whirligig guard**

## Performance

- **Duration:** 1 min
- **Started:** 2026-04-24T13:49:30+07:00
- **Completed:** 2026-04-24T13:50:15+07:00
- **Tasks:** 2
- **Files modified:** 1

## Accomplishments

- Expanded the root return-type selector so `Rejoin` persists through the existing `settings/nm_config.ini` flow.
- Added an explicit `FieldReturnType="Rejoin"` branch in the gather exit logic.
- Guarded the generic whirligig return path so Trading Hub does not get consumed before the Rejoin branch can run.

## Task Commits

Each task was committed atomically:

1. **Task 1: Extend the root return-type control to include Rejoin** - `aa6a05f` (feat)
2. **Task 2: Add an explicit Rejoin branch to the gather exit flow** - `1a7ee4f` (feat)

**Plan metadata:** not committed (`commit_docs=false`)

## Files Created/Modified

- `submacros/natro_macro.ahk` - Added `Rejoin` to the persisted return-type enum and wired the explicit Trading Hub-safe gather exit branch.

## Decisions Made

- Kept the existing Walk behavior intact and inserted Rejoin as an explicit alternative rather than changing the meaning of Reset or Walk.
- Applied the Trading Hub guard only at the shared whirligig branch so the fix stays local to the exit-control path.

## Deviations from Plan

None - plan executed exactly as written.

## Issues Encountered

- The bundled AutoHotkey validation continued to behave more reliably through `cmd //c` than through direct MINGW execution, so the Windows-native invocation was reused for the task checks.

## User Setup Required

None - no external service configuration required.

## Next Phase Readiness

- Plan 03 can now harden `nm_LoadFieldDefaults()` and validate the full Phase 1 root-only Trading Hub slice.
- Trading Hub has a supported runtime exit path without leaking into Phase 2 UI work.

---
*Phase: 01-runtime-wiring*
*Completed: 2026-04-24*
