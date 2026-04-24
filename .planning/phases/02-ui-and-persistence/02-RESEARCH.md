# Phase 2: UI And Persistence - Research

**Created:** 2026-04-24
**Status:** Ready for planning

## Objective

Identify the narrowest root-owned UI and persistence changes that make Trading Hub selectable and reloadable in the main macro without leaking it into unsupported planter/manual field systems.

## Core Finding

Phase 2 is not just "add Trading Hub to `fieldnamelist`". In the root macro, `fieldnamelist` is a shared registry that feeds the main gather dropdowns, planter/manual field surfaces, and gather-settings import validation. A naive append would satisfy the gather UI but also leak Trading Hub into unsupported planter flows. The safest implementation is a gather-only exposure path plus slot-specific guardrails.

## Verified Root Surfaces

### Main gather UI

- `submacros\natro_macro.ahk` defines the main field dropdowns at the `FieldName1..3` controls.
- All three dropdowns currently read from `fieldnamelist`.
- `settings\nm_config.ini` already persists `FieldName1`, `FieldName2`, `FieldName3`, and `CurrentFieldNum`.
- Startup replay later re-applies the slot handlers by calling `nm_FieldSelect1(1)`, `nm_FieldSelect2(1)`, and `nm_FieldSelect3(1)` from the config restore path.

### Shared-list leak risk

- `fieldnamelist` currently excludes Trading Hub in root.
- `MFieldList := [""].Push(fieldnamelist*)` reuses that same list for manual planter field surfaces.
- `nm_PasteGatherSettings()` validates imported field names with `ObjHasValue(fieldnamelist, obj["Name"])`.
- Result: appending Trading Hub directly to `fieldnamelist` would expose it in main gather UI, planter/manual field flows, and clipboard import validation at the same time.

### Slot control ownership

- `nm_FieldSelect1/2/3` own slot persistence and most slot-specific enable/disable behavior.
- `nm_TabGatherUnLock()` re-enables gather controls generically when the tab unlocks.
- Because config replay calls the selection handlers after load, Trading Hub guardrails inside those handlers will affect persisted reload state too.
- Because `nm_TabGatherUnLock()` can still re-enable unsupported controls later, a narrow helper or post-unlock guard is needed so Trading Hub slots stay normalized after unlock transitions.

### Unsupported control posture

- The donor UI disables Trading Hub-specific unsupported controls per slot.
- The current root file does not contain donor-only helper IDs like `SprinklerLocHelp*`, `DistanceHide*`, or `SprinklerDistDisable*`.
- The actual root controls that exist and matter are:
  - `FieldDriftCheck1..3`
  - `FSL1Left/FSL1Right`, `FSL2Left/FSL2Right`, `FSL3Left/FSL3Right`
  - `FieldSprinklerDist1..3`
- Result: Phase 2 should port the donor intent, not donor control names.

### Persistence validation gap

- `nm_PasteGatherSettings()` still validates `ReturnType` with `^(Walk|Reset)$` even after Phase 1 added `Rejoin` to the root return selector.
- Result: pasted Trading Hub settings would reject `Rejoin` unless the validation surface is updated alongside the gather-field exposure surface.

## Recommended Build Order

1. Introduce a gather-only field list that includes Trading Hub for the main gather dropdowns and gather-settings import validation.
2. Keep `fieldnamelist` and `MFieldList` planter/manual surfaces unchanged in this phase.
3. Update pasted gather-settings validation so `Name=Trading Hub` and `ReturnType=Rejoin` are both accepted.
4. Add slot-specific Trading Hub guardrails to the real root controls (`FieldDriftCheck*`, `FSL*`, `FieldSprinklerDist*`) in both slot handlers and gather-tab unlock behavior.
5. Validate the boundary explicitly: Trading Hub visible in gather UI and clipboard import, but not in planter/manual field lists.

## Files Most Likely In Phase 2 Plans

- `submacros\natro_macro.ahk`
- `settings\nm_config.ini` only as a verification surface, not as a seeded feature-definition file
- Donor reference only: `Hub file\submacros\natro_macro.ahk`

## Guardrails For Planning

- Do not append Trading Hub to the shared `fieldnamelist` and stop there.
- Do not widen Trading Hub into planter/manual field surfaces in this phase.
- Do not import donor-only GUI control IDs that do not exist in the root file.
- Do not seed active-slot Trading Hub values into `settings\nm_config.ini`; persistence should come from existing user-driven writes.
- Keep the UI visually native to the current root macro.

## Validation Targets For Execution

- Main gather dropdowns accept Trading Hub in all three slots.
- Persisted `FieldName1..3` values of Trading Hub reload safely through the existing config replay path.
- `nm_PasteGatherSettings()` accepts `Name=Trading Hub` and `ReturnType=Rejoin`.
- Planter/manual field surfaces derived from `MFieldList` remain Trading-Hub-free.
- Trading Hub selection disables unsupported slot controls without breaking supported ones.

## Recommendation

Proceed with a two-plan Phase 2:

- Plan 02-01: gather-only field exposure plus persistence/import validation
- Plan 02-02: slot guardrails plus boundary verification
