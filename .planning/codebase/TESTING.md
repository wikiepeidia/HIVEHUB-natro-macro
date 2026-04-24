# Testing

## Current State

No automated unit, integration, or end-to-end test suite was found in the repository. A search for test-like files only surfaced the two GitHub Actions workflows in `.github\workflows\`, and those are notification automations rather than code validation.

## Existing Validation Mechanisms

### Startup Validation

- `START.bat` verifies the bundled AutoHotkey executable exists before launching
- `submacros\natro_macro.ahk` enforces AutoHotkey v2 and a 32-bit runtime path
- Startup checks validate admin/write permissions and warn about unsupported DPI scaling

### Runtime Validation

- `nm_importPatterns()` syntax-checks pattern files by invoking AutoHotkey in validation mode
- Many subsystems rely on visible runtime warnings (`MsgBox`) when image-search assets, files, or imported scripts are invalid
- `submacros\background.ahk`, `submacros\Heartbeat.ahk`, and `submacros\Status.ahk` act as operational monitors rather than tests

### Debug Surfaces

- `settings\debug_log.txt` stores runtime logging output
- The main script includes message handlers such as `nm_copyDebugLog`
- `settings\COMPARISION\` suggests manual config comparison is part of the current debugging workflow

## CI Coverage

- `.github\workflows\discord-release.yml` posts release events to Discord
- `.github\workflows\discord-star.yml` posts GitHub star events to Discord
- No workflow was found for syntax checking, linting, packaging, or regression testing

## Practical Test Strategy For Changes

When modifying this codebase, the realistic validation loop is manual and slice-based:

1. Verify the changed script still loads through `START.bat`
2. Exercise the affected field/path/pattern in Roblox with 100% DPI and expected window layout
3. Confirm related INI keys are persisted correctly under `settings\`
4. Check dependent bitmap assets exist and still match their lookup region
5. Review `settings\debug_log.txt` and any Discord/reporting side effects after the run

## Porting-Specific Recommendation

For a hub-field port, the minimum safe verification should compare:

- the hub source file to the root equivalent
- any new config keys used by the hub logic against `settings\nm_config.ini`
- any new asset lookups against `nm_image_assets\`
- the runtime path through `submacros\natro_macro.ahk` that calls the imported route or field behavior
