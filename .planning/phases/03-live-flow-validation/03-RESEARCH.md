# Phase 3: Live Flow Validation - Research

**Created:** 2026-04-24
**Status:** Ready for planning

## Objective

Identify the remaining proven runtime or asset gaps before a real Trading Hub run can be validated end to end in the root macro.

## Verified Findings

### Route And Pattern Surfaces Already Exist

- `paths\gtf-tradinghub.ahk` exists in both the root and donor trees.
- A direct hash comparison showed the root and donor `gtf-tradinghub` route files are identical.
- `patterns\Squares.ahk` already exists in the root tree and matches the existing `FieldDefault["Trading Hub"]` profile.
- Result: Phase 3 does not need a new Trading Hub route or a new Trading Hub gather pattern file.

### Proven Runtime Defect In Root

- The donor `nm_setSprinkler(field, loc, dist)` returns immediately when `field="Trading Hub"`.
- The root `nm_setSprinkler(field, loc, dist)` currently lacks that Trading Hub short-circuit.
- Result: the root runtime still risks attempting unsupported sprinkler-placement movement for Trading Hub during a live gather cycle even though Phase 2 already disabled the related UI controls.

### Trading Hub Asset Audit Result

- A workspace search found no Trading Hub-named files under `nm_image_assets\`.
- A root-source search found no Trading Hub-specific bitmap keys or image-file references in the active `submacros\natro_macro.ahk` runtime.
- Result: there is currently no proven root Trading Hub bitmap lookup that requires a replacement asset pack. `SAFE-02` should be satisfied by documenting this no-lookup finding and by checking for missing-image errors during a real run, not by adding speculative assets.

### Existing Live-Flow Behavior Already In Place

- `nm_walkFrom(field)` already special-cases Trading Hub to `Rejoin()` in the root runtime.
- Gather exit flow already guards Trading Hub away from the generic whirligig return path.
- Result: the remaining live-flow risk is pre-gather setup behavior, not exit logic.

## Recommended Phase 3 Build Order

1. Port the donor Trading Hub early return into the root `nm_setSprinkler(field, loc, dist)` function.
2. Re-verify that the route file remains the existing root-owned `gtf-tradinghub` surface and that no Trading Hub-specific bitmap lookup exists in root code.
3. Write a narrow manual validation checklist covering launch, selection, travel, gather, exit, sprinkler no-op behavior, and missing-image errors.
4. Mark live end-to-end validation as human-needed if a Roblox-backed run cannot be completed from this environment.

## Planning Guardrails

- Do not add a new Trading Hub asset pack without a real runtime lookup proving it is needed.
- Do not replace the existing `gtf-tradinghub` route file when the root and donor copies already match.
- Do not reopen Phase 2 UI/persistence surfaces during Phase 3 unless a direct live-flow bug forces it.
- Do not claim the full Trading Hub cycle passed unless it was actually executed against the running game.

## Recommended Plans

- Plan 03-01: fix the proven root runtime defect in `nm_setSprinkler` and audit the active asset footprint.
- Plan 03-02: prepare the live-cycle validation checklist and record deferred human validation status if a real run is not possible here.
