# Pitfalls Research

## High-Risk Failure Modes

- Partial port: the route file exists but Trading Hub is still missing from root registrations, so the feature looks present but is unusable
- Missing defaults: Trading Hub becomes selectable before root field defaults exist, causing missing-key or bad-state failures
- Bad return behavior: Trading Hub falls into normal Walk or whirligig-style field exit logic even though it should rejoin safely
- Config drift: stale slot state overrides the intended Trading Hub defaults and makes the feature look broken
- Stale donor merge: broad copy-paste from `Hub file\` reintroduces outdated behavior into the newer root tree
- Bitmap thrash: old unusable Trading Hub assets are copied in without a verified root lookup that needs them
- AHK load failure: path or special-case logic is inserted into the monolith in the wrong place and breaks runtime load or child-script execution

## Early Warning Signs

- Trading Hub route file exists but is never reachable from the main UI
- Selecting Trading Hub breaks before any movement starts
- Travel starts but gather or exit stalls immediately afterward
- Trading Hub persists wrong return type or incorrect field profile after reload
- Auto field boost or other metadata-driven behavior fails only when Trading Hub is active
- Asset work grows faster than runtime integration work without a proven detection point

## Prevention Strategy

- Wire the root registrations before touching user config
- Port narrowly from the donor tree; use it as a checklist, not a merge base
- Keep return behavior explicit and safe for Trading Hub
- Reset and verify active slot state after default support lands
- Make each change slice manually testable through launch -> select -> travel -> gather -> exit
- Capture or replace bitmaps only when a concrete root lookup requires them

## Which Step Should Address It

- Root registration step: partial port and missing-default failures
- Return-behavior step: walk/rejoin/whirligig mismatches
- Config-validation step: stale slot state and persistence drift
- Asset step: bitmap replacement risk
- Final validation step: AHK load failures and end-to-end regressions

## Confidence Assessment

- High: stale donor merge, partial registration, and return-behavior risks
- Medium: exact bitmap scope and the amount of UI spillover into non-gather surfaces
