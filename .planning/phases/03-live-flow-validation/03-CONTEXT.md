# Phase 3: Live Flow Validation - Context

**Gathered:** 2026-04-24
**Status:** Ready for planning
**Mode:** Autonomous auto-discuss (agent-picked defaults)

<domain>
## Phase Boundary

Phase 3 proves the root Trading Hub runtime can complete a clean gather cycle and records any truly required asset work. This phase stays narrow: fix only live-flow issues proven by root-versus-donor behavior, avoid speculative bitmap packs, and treat full Roblox-backed validation as a separate evidence step instead of pretending it happened from static analysis.

</domain>

<decisions>
## Implementation Decisions

### Runtime Fix Scope

- **D-01:** Only fix live-flow issues proven by root versus donor runtime comparison; do not reopen Phase 1 or Phase 2 UI/persistence work.
- **D-02:** Treat the missing Trading Hub short-circuit in `nm_setSprinkler(field, loc, dist)` as an in-scope runtime defect because the donor runtime skips sprinkler placement for Trading Hub and the root runtime currently does not.
- **D-03:** Preserve the existing root `gtf-tradinghub` route file and `Squares` field profile unless a concrete runtime failure proves they are wrong.

### Asset Posture

- **D-04:** Do not add a speculative Trading Hub asset subtree if the active root runtime has no Trading Hub-specific bitmap lookup.
- **D-05:** `SAFE-02` can be satisfied by proving there are no Trading Hub-specific bitmap lookups in the active root runtime, as long as live validation also checks for missing-image errors during a real run.

### Validation Posture

- **D-06:** Keep the end-to-end validation narrow and field-specific: launch, select Trading Hub, travel, gather, and exit through the root runtime only.
- **D-07:** If the full Roblox-backed cycle cannot be executed from this environment, record a human-needed validation step instead of claiming the live cycle passed.

### the agent's Discretion

- Exact verification commands for the no-asset audit.
- Whether the manual validation evidence lives in a checklist file or directly in the verification artifact, as long as the next human step is unambiguous.

</decisions>

<code_context>

## Existing Code Insights

### Reusable Assets

- `paths\gtf-tradinghub.ahk` already exists in both root and donor trees and currently hashes identically.
- `patterns\Squares.ahk` already exists and matches the `FieldDefault["Trading Hub"]` profile.
- `nm_walkFrom(field)` in the root runtime already special-cases Trading Hub to `Rejoin()`.

### Established Patterns

- Trading Hub support remains root-owned; donor behavior is used only as a narrow behavioral baseline.
- Shared UI boundary work is already complete from Phase 2 and should not be widened here.
- Root verification uses `cmd //c "submacros\\AutoHotkey64.exe /Validate /ErrorStdOut submacros\\natro_macro.ahk"` plus targeted grep checks.

### Integration Points

- `submacros\natro_macro.ahk` `nm_setSprinkler(field, loc, dist)` is the proven live-flow gap.
- `submacros\natro_macro.ahk` gather exit flow already guards Trading Hub away from whirligig return and into `Rejoin()`.
- `paths\gtf-tradinghub.ahk` is the existing live route surface to validate, not replace.

</code_context>

<specifics>
## Specific Ideas

- Manual validation should explicitly check that a Trading Hub run does not try to place sprinklers or move to sprinkler offsets.
- Manual validation should explicitly check for missing-image errors during launch, travel, gather, and exit before any asset work is declared necessary.
- Phase 3 should prefer a documented no-asset finding over copying old donor bitmaps with no live lookup proving they are needed.

</specifics>

<deferred>
## Deferred Ideas

- Re-capturing or adding Trading Hub-specific bitmap files unless a proven root lookup fails during validation.
- Broad donor cleanup or `Hub file` retirement work outside the Trading Hub slice.

</deferred>

---

*Phase: 03-live-flow-validation*
*Context gathered: 2026-04-24*
