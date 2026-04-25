# Stack Research

## Recommended Technical Approach

Implement Trading Hub inside the existing root AutoHotkey v2 macro only. The owning runtime is `submacros\natro_macro.ahk`, launched through `START.bat`, with field routing in `paths\`, gather patterns in `patterns\`, persistent state in `settings\*.ini`, and bitmap/image-search support in `nm_image_assets\` plus `lib\Gdip_*` helpers.

Trading Hub should be added as one more root-owned field integration, not as a sidecar copied from `Hub file\`. The root tree already contains `paths\gtf-tradinghub.ahk`, so the likely gap is wiring and field-specific behavior, not inventing a new transport stack.

## Existing Components To Reuse

- `submacros\natro_macro.ahk` as the only orchestration surface
- `paths\gtf-tradinghub.ahk` for root-side Trading Hub travel
- `patterns\Squares.ahk` as the donor-compatible gather pattern baseline
- `settings\field_config.ini` for Trading Hub field defaults
- `settings\nm_config.ini` for slot selection persistence and current-field state
- Root reconnect and return helpers already used by the main macro for rejoin-style recovery
- Existing image-search stack in `lib\Gdip_All.ahk`, `lib\Gdip_ImageSearch.ahk`, and `nm_image_assets\`

## New Artifacts Likely Needed

- Trading Hub registration in the root field/path lists inside `submacros\natro_macro.ahk`
- A root-owned Trading Hub default section in the field-default/config flow
- Trading Hub-safe return behavior, likely preserving Rejoin instead of Walk
- Trading Hub UI guardrails if the current GUI assumes every field behaves like a normal pollen field
- Replacement or newly captured Trading Hub bitmaps only where the current runtime proves they are needed

## What Not To Introduce

- No broad merge of `Hub file\`
- No second runtime, second reconnect system, or parallel hub-only macro flow
- No new language, build system, package manager, or external service
- No speculative Trading Hub asset subtree unless a concrete lookup requires it
- No fake walk-back route for Trading Hub if the intended behavior is Rejoin

## Confidence Assessment

- High: root AutoHotkey runtime is the correct integration target
- High: existing route/pattern/config surfaces are sufficient for a narrow port
- Medium: exact bitmap scope cannot be finalized until the owning lookup sites are verified in live runtime behavior
