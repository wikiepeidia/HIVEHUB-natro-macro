---
phase: 03-live-flow-validation
plan: 01
subsystem: runtime
tags: [autohotkey, trading-hub, runtime, sprinkler, asset-audit]
requires:
  - phase: 02-ui-and-persistence
    provides: Gather-only Trading Hub selection, import validation, and slot guardrails
provides:
  - Trading Hub-safe sprinkler no-op in the root runtime
  - Audited no-speculation Trading Hub asset conclusion
  - Verified root route parity with the donor trading hub path
affects: [manual-validation, milestone-closeout]
tech-stack:
  added: []
  patterns: [special-field sprinkler short-circuit, no-speculation asset audit]
key-files:
  created: [.planning/phases/03-live-flow-validation/03-01-SUMMARY.md]
  modified: [submacros/natro_macro.ahk]
key-decisions:
  - "Port the donor Trading Hub sprinkler early return into the root runtime instead of broadening Phase 2 guardrails again."
  - "Treat the absence of active Trading Hub bitmap lookups as the SAFE-02 answer rather than inventing a bitmap pack."
patterns-established:
  - "Live-field fixes should target the owning runtime function directly when donor comparison proves the missing behavior."
  - "Asset work for Trading Hub stays evidence-based: prove a live lookup exists before adding files under nm_image_assets."
requirements-completed: [FLOW-02, SAFE-02]
duration: 1 min
completed: 2026-04-24
---

# Phase 03 Plan 01: Runtime And Asset Audit Summary

**Trading Hub sprinkler no-op in the root runtime with a verified no-speculation asset footprint**

## Performance

- **Duration:** 1 min
- **Started:** 2026-04-24T14:32:02+07:00
- **Completed:** 2026-04-24T14:32:32+07:00
- **Tasks:** 2
- **Files modified:** 1

## Accomplishments

- Added the donor-matched `if (field="Trading Hub") { return }` guard to `nm_setSprinkler(field, loc, dist)` before any sprinkler-placement movement begins.
- Reconfirmed that the root and donor `paths/gtf-tradinghub.ahk` route files are byte-identical.
- Audited the active root runtime and `nm_image_assets\` tree and found no Trading Hub-specific bitmap lookups or Trading Hub-named bitmap files requiring speculative asset additions.

## Task Commits

Each task was committed atomically when code changed:

1. **Task 1: Port the donor Trading Hub sprinkler no-op into the root runtime** - `2451088` (fix)
2. **Task 2: Audit the active route and bitmap footprint without adding speculative assets** - no code changes (audit-only task)

**Plan metadata:** not committed (`commit_docs=false`)

## Files Created/Modified

- `submacros/natro_macro.ahk` - Added the Trading Hub early return inside `nm_setSprinkler(field, loc, dist)`.

## Decisions Made

- Fixed the proven root runtime defect in the owning sprinkler setup function instead of adding another UI-side workaround.
- Declared the asset result from evidence: no Trading Hub-specific root bitmap lookup exists today, so no new Trading Hub asset pack was added.

## Deviations from Plan

None - plan executed exactly as written.

## Issues Encountered

- None.

## User Setup Required

None - no external service configuration required.

## Next Phase Readiness

- The root Trading Hub runtime no longer attempts unsupported sprinkler placement before gather.
- Phase 03-02 can now focus on the final live-cycle checklist and an explicit human-validation boundary instead of more static runtime fixes.

---
*Phase: 03-live-flow-validation*
*Completed: 2026-04-24*
