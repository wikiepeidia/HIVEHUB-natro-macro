# Architecture Research

## Owning Integration Points

- `submacros\natro_macro.ahk` owns field lists, field defaults, GUI slot handling, boost metadata, and gather return behavior
- `paths\gtf-tradinghub.ahk` is the existing root-side travel script that needs to be registered and exercised
- `patterns\Squares.ahk` is the likely default gather pattern reference
- `settings\field_config.ini` and `settings\nm_config.ini` carry persisted field and slot state
- `nm_image_assets\` and image-search helpers own any Trading Hub-specific visual detection that survives into the final port

## Expected Data And Control Flow

1. Startup loads path registries, field defaults, persisted config, and GUI options in `submacros\natro_macro.ahk`
2. User selects Trading Hub in a field slot
3. Slot logic loads the Trading Hub defaults into active field variables
4. Travel dispatch resolves `Trading Hub` to the registered root route
5. Gather logic runs with the assigned pattern/profile
6. Exit logic uses the Trading Hub-safe return path, likely Rejoin

## Minimal Build Order

1. Register Trading Hub in the root field/path/default metadata
2. Add the root-side return behavior and any field-specific safety guards
3. Expose Trading Hub in the user-facing field selection flow
4. Validate persistence in `settings\field_config.ini` and slot state in `settings\nm_config.ini`
5. Only then capture or replace bitmaps if the live flow proves they are needed

## Coupling Risks

- The main macro is monolithic, so field registration, GUI state, config defaults, and exit logic all meet in one file
- The shared field lists may be reused by unrelated surfaces such as planter UI, so Trading Hub exposure can spill further than intended
- Boost and return logic may assume all fields behave like standard pollen fields
- The donor `Hub file\` tree is stale and should only be used as a narrow reference source

## Validation Points

- Trading Hub is visible and selectable in the main macro UI
- Selecting it does not crash startup or field-slot loading
- Travel reaches Trading Hub through the root route file
- Gather uses the intended pattern/profile
- Exit behavior does not fall into unsupported walk-back logic
- Config persists and reloads Trading Hub correctly

## Confidence Assessment

- High: the owning integration points are in the root orchestrator and related config files
- Medium: exact spillover into other UI surfaces needs verification after Trading Hub is added to the field lists
