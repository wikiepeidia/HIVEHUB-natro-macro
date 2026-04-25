---
phase: 01-runtime-wiring
plan: 01
subsystem: runtime
tags: [autohotkey, trading-hub, field-defaults, ini]
requires: []
provides:
  - Root Trading Hub path import wiring
  - Explicit Trading Hub booster metadata
  - Root-owned Trading Hub default profile in code and INI
affects: [return-flow, ui-and-persistence, config-loading]
tech-stack:
  added: []
  patterns: [root-owned field registration, root-owned field defaults]
key-files:
  created: []
  modified: [submacros/natro_macro.ahk, settings/field_config.ini]
key-decisions:
  - "Keep Trading Hub out of shared UI field lists until Phase 2."
  - "Mirror the donor Trading Hub profile into root-owned code and settings instead of loading donor runtime behavior."
patterns-established:
  - "Runtime-only field onboarding starts with nm_importPaths and the lower-case fieldnames array."
  - "Trading Hub-specific defaults must exist in both FieldDefault and settings/field_config.ini."
requirements-completed: [FIELD-03, FLOW-01, SAFE-03]
duration: 2 min
completed: 2026-04-24
---

# Phase 01 Plan 01: Runtime Registry Summary

**Trading Hub root route wiring with explicit booster metadata and donor-matched persisted defaults**

## Performance

- **Duration:** 2 min
- **Started:** 2026-04-24T13:45:43+07:00
- **Completed:** 2026-04-24T13:47:25+07:00
- **Tasks:** 2
- **Files modified:** 2

## Accomplishments

- Wired `tradinghub` into the root `gtf` path import list and lower-case runtime field identity list.
- Added explicit Trading Hub booster metadata and a root-owned `FieldDefault["Trading Hub"]` profile.
- Appended a matching `[Trading Hub]` section to `settings/field_config.ini` without widening shared UI field lists.

## Task Commits

Each task was committed atomically:

1. **Task 1: Import the Trading Hub route and runtime field identity** - `161a3a9` (feat)
2. **Task 2: Add root-owned Trading Hub metadata and persisted defaults** - `acf8850` (feat)

**Plan metadata:** not committed (`commit_docs=false`)

## Files Created/Modified

- `submacros/natro_macro.ahk` - Added Trading Hub route import, runtime field identity, booster metadata, and default profile entries.
- `settings/field_config.ini` - Added the persisted Trading Hub field profile matching the root defaults.

## Decisions Made

- Kept `fieldnamelist` and other shared UI field selectors unchanged so Phase 1 stays runtime-only.
- Used the embedded hub tree only as a donor baseline; all active Trading Hub registrations now live in the root macro files.

## Deviations from Plan

None - plan executed exactly as written.

## Issues Encountered

- Direct MINGW execution of `submacros/AutoHotkey64.exe /Validate /ErrorStdOut submacros/natro_macro.ahk` did not return reliably, so validation was rerun through `cmd //c` to get the expected clean syntax check.
- `settings/field_config.ini` is ignored by the repo defaults, so the task commit required `git add -f settings/field_config.ini` to preserve the planned persisted-default change.

## User Setup Required

None - no external service configuration required.

## Next Phase Readiness

- Plan 02 can now add Trading Hub-safe `Rejoin` return behavior against root-owned metadata and defaults.
- Shared UI exposure is still deferred cleanly to Phase 2.

---
*Phase: 01-runtime-wiring*
*Completed: 2026-04-24*
