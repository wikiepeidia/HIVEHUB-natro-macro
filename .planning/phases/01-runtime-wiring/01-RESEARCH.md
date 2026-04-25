# Phase 1: Runtime Wiring - Research

**Created:** 2026-04-24
**Status:** Ready for planning

## Objective

Research the exact root-side gaps that prevent Trading Hub from being a valid runtime field in the main macro, and identify the narrowest implementation order that satisfies Phase 1 without pulling Phase 2 UI work forward.

## Core Finding

The root macro already contains `paths\gtf-tradinghub.ahk`, but Phase 1 is blocked by missing root registrations and return handling, not by a missing route file. The controlling code path is `submacros\natro_macro.ahk`, where the root `path_names` map, `fieldnames`, `FieldBooster`, `FieldDefault`, `nm_FieldReturnType(...)`, and the gather exit branch currently omit Trading Hub support.

## Verified Root-vs-Donor Differences

### Path import gap

- Root `nm_importPaths()` loads `gtf-*` paths from a hardcoded `path_names` map.
- Root `gtf` list stops at `sunflower`; it does not include `tradinghub`.
- Donor `Hub file\submacros\natro_macro.ahk` adds `tradinghub` to the `gtf` list.
- Result: `paths\gtf-tradinghub.ahk` exists in the root tree but is never imported into `paths["gtf"]` until `path_names` is updated.

### Field identity gap

- Root `fieldnames` omits `tradinghub`.
- Root `FieldBooster` omits `"trading hub"`.
- Root `FieldDefault` defines defaults through `Pepper`; no `FieldDefault["Trading Hub"]` exists.
- Donor adds all three, using explicit `booster:"none"` and `stacks:0` metadata.
- Result: any runtime path that expects Trading Hub to behave like a known field will fail on missing map entries before the route ever matters.

### Return-flow gap

- Root `nm_FieldReturnType(...)` cycles only `Walk` and `Reset`.
- Root gather exit logic branches on `FieldReturnType="walk"` and otherwise falls through to reset behavior.
- Donor expands the enum to `Walk`, `Reset`, `Rejoin` and adds an explicit `FieldReturnType="Rejoin"` branch calling `Rejoin()`.
- Result: Trading Hub cannot use the donor’s supported return mode unless both the enum and the exit branch are extended in root.

### Config-load risk

- Root `nm_importFieldDefaults()` loads `settings\field_config.ini`, merges keys into `FieldDefault`, then rewrites the file with the in-memory default map.
- `nm_LoadFieldDefaults()` writes `FieldDefault[s][k] := ...` for every INI section without checking that section `s` exists in `FieldDefault`.
- Result: if `settings\field_config.ini` contains `[Trading Hub]` before `FieldDefault["Trading Hub"]` exists, the load path can break. Sequence matters, and a defensive unknown-section guard is useful for stale configs.

### Shared-field leak risk

- Root `fieldnamelist` feeds the main GUI dropdowns and other shared field-aware surfaces.
- Root `nm_CopyGatherSettings()` validates imported field names against `fieldnamelist`.
- Root planter override logic still enumerates standard pollen fields explicitly and does not include Trading Hub.
- Phase 1 context locks UI exposure to Phase 2, so `fieldnamelist` should stay untouched in this phase unless a later requirement proves otherwise.

## Donor Baseline Worth Reusing Narrowly

The donor Trading Hub default profile in `Hub file\settings\field_config.ini` is:

- `pattern=Squares`
- `size=M`
- `width=5`
- `camera=None`
- `turns=1`
- `sprinkler=Center`
- `distance=1`
- `percent=95`
- `gathertime=300`
- `convert=Rejoin`
- `drift=0`
- `shiftlock=0`
- `invertFB=0`
- `invertLR=0`

This is the only proven Trading Hub runtime profile currently available in the repo and is the safest starting point for Phase 1 unless live runtime evidence disproves it.

## Recommended Phase 1 Build Order

1. Extend root path import and field identity maps in `submacros\natro_macro.ahk`:
   - add `tradinghub` to the root `gtf` import list
   - add `tradinghub` to `fieldnames`
   - add `"trading hub", {booster:"none", stacks:0}` to `FieldBooster`
   - add `FieldDefault["Trading Hub"]` using the donor baseline
2. Seed `settings\field_config.ini` with a `[Trading Hub]` section matching the root default map so persisted defaults stay in sync.
3. Extend root return handling:
   - add `Rejoin` to `nm_FieldReturnType(...)`
   - add an explicit `FieldReturnType="Rejoin"` branch to the gather exit flow
   - prevent Trading Hub from falling into normal walk-back behavior
4. Harden the config load path enough to survive stale or partially migrated Trading Hub config without crashing.
5. Leave `fieldnamelist` and visible UI selection work for Phase 2 per D-04.

## Files Most Likely In Phase 1 Plans

- `submacros\natro_macro.ahk`
- `settings\field_config.ini`
- Possibly `settings\nm_config.ini` only for manual validation scenarios, not as the feature-definition surface

## Guardrails For Planning

- Do not copy broad donor blocks just because they exist; port only the exact Trading Hub entries.
- Do not add Trading Hub to `fieldnamelist` in Phase 1.
- Do not touch bitmap assets in this phase unless a runtime-validity task proves a lookup is required immediately.
- Prefer explicit metadata entries over missing-key special cases.
- Treat unknown or stale Trading Hub config as a recoverable state, not a fatal assumption.

## Validation Targets For Execution

- `submacros\natro_macro.ahk` imports `gtf-tradinghub.ahk` through the root `path_names` map.
- `submacros\natro_macro.ahk` contains lower-case `tradinghub` in the runtime `fieldnames` list but not in the shared UI `fieldnamelist`.
- `submacros\natro_macro.ahk` contains `"trading hub", {booster:"none", stacks:0}` in `FieldBooster`.
- `submacros\natro_macro.ahk` contains `FieldDefault["Trading Hub"]` with `pattern="Squares"` and `convert="Rejoin"`.
- `submacros\natro_macro.ahk` contains `static val := ["Walk", "Reset", "Rejoin"]` in `nm_FieldReturnType(...)`.
- `submacros\natro_macro.ahk` contains an explicit `FieldReturnType="Rejoin"` branch that calls `Rejoin()`.
- `settings\field_config.ini` contains a `[Trading Hub]` section matching the root default map.

## Recommendation

Proceed with Phase 1 planning as a three-plan sequential slice centered on:

- root registration and defaults
- return and guard behavior
- config-load hardening plus runtime validation

This matches the roadmap’s 3-plan expectation and keeps the feature narrow enough to avoid Phase 2 UI spillover.
