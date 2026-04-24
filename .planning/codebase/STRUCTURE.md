# Structure

## Top Level Layout

- `README.md`, `LICENSE.md`, `START.bat`: distribution, licensing, and launch entrypoints
- `.github\workflows\`: release/star notification workflows
- `lib\`: shared AHK helper modules
- `submacros\`: primary runtime scripts and bundled AutoHotkey executables
- `paths\`: movement/travel scripts for fields, planters, quest givers, and event locations
- `patterns\`: gather pattern definitions
- `settings\`: persisted user/runtime state
- `nm_image_assets\`: image-search assets, themed GUI styles, and generated bitmap bundles
- `Hub file\`: mirrored secondary macro tree

## Key Runtime Files

- `START.bat` launches the macro and handles damaged or partially extracted distributions
- `submacros\natro_macro.ahk` is the main application entrypoint
- `submacros\background.ahk` is the continuous background checker loop
- `settings\nm_config.ini` is the primary persisted configuration surface
- `settings\field_config.ini` stores per-field movement preferences

## Directory Metrics

- `paths\`: 92 `.ahk` files
- `patterns\`: 14 `.ahk` files
- `submacros\`: 7 `.ahk` scripts plus bundled AutoHotkey executables
- `lib\`: 15 `.ahk` helper modules in the root tree
- `nm_image_assets\`: 24 generated `.ahk` bitmap bundles plus many raw images

## Naming Patterns

- `gtb-*`: go-to booster routes in `paths\`
- `gtc-*`: go-to collect/machine routes in `paths\`
- `gtf-*`: go-to field routes in `paths\`
- `gtp-*`: go-to planter routes in `paths\`
- `gtq-*`: go-to quest giver routes in `paths\`
- `wf-*`: walk-from-field return routes in `paths\`
- `nm_*`: main macro helper functions and support modules

## Settings Layout

- `settings\nm_config.ini`: large multi-section runtime config
- `settings\field_config.ini`: field-by-field gather configuration
- `settings\manual_planters.ini`: planter state
- `settings\mutations.ini`: additional mutation state in the root tree only
- `settings\COMPARISION\`: comparison/debug artifacts in the root tree only

## Mirrored Hub Tree

- `Hub file\` repeats `lib\`, `paths\`, `patterns\`, `settings\`, `submacros\`, and documentation files
- The hub tree has fewer files than the root tree and no obvious unique files from the comparison pass
- This makes `Hub file\` look like a lagging branch snapshot embedded inside the main workspace

## Practical Navigation Guidance

- For behavior changes, start in `submacros\natro_macro.ahk`
- For reusable travel changes, inspect `paths\`
- For field motion tuning, inspect `patterns\` and `settings\field_config.ini`
- For detection changes, inspect the relevant area under `nm_image_assets\`
