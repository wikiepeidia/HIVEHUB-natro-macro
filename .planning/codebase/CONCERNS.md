# Concerns

## High-Risk Areas

### Monolithic Control File

- `submacros\natro_macro.ahk` is roughly 22.9k lines
- Most business logic, GUI setup, config defaults, message routing, and gameplay behavior converge there
- Even small feature ports can require edits across unrelated sections because the file is the true control surface

### Embedded Duplicate Tree

- `Hub file\submacros\natro_macro.ahk` is still about 21.3k lines, but the whole `Hub file\` tree is smaller than the root tree
- The comparison pass found root-only files such as `lib\Discord.ahk`, `lib\ErrorHandling.ahk`, `settings\mutations.ini`, and many newer `nm_image_assets\` files
- This strongly suggests `Hub file\` is a lagging snapshot, so blind copy-paste from hub to root is likely to regress newer root features

### Weak Automated Safety Nets

- No automated tests or CI validation protect behavior changes
- Image-search macros are sensitive to Roblox UI shifts, asset drift, and environment differences, so regressions are easy to introduce and hard to catch early

## Technical Debt Signals

- `submacros\background.ahk` has an explicit TODO to stop writing state through `nm_config.ini` and move to `PostMessage`
- `submacros\natro_macro.ahk` contains many TODO markers around detection rewrites, quest handling, cooldown detection, and duplicated planter logic
- Several comments mark functions as deprecated or pending rewrite rather than retired cleanly

## Operational Risks

- Error visibility can be suppressed through `HideErrors` in `settings\nm_config.ini`, which can make failures quieter during debugging
- Secrets for Discord bot/webhook mode appear to be user-managed through INI configuration rather than a secrets store
- The macro depends on bundled Windows executables and COM components, so portability is low and local environment issues matter

## Repository Hygiene Risks

- Large generated/base64 bitmap bundles and raw image assets make diffs noisy
- The root tree currently contains the active Git repository while `Hub file\` looks like vendored source, increasing the chance of editing the wrong copy
- `settings\` is gitignored, so reproducing user state issues from version control alone is difficult

## Recommended Focus For The Requested Work

- Treat the root tree as the target integration surface unless evidence shows the hub copy is newer for the specific field
- Start the port from the narrowest owning files: the relevant `paths\*.ahk`, any matching `patterns\*.ahk`, and the call sites inside `submacros\natro_macro.ahk`
- Diff the hub version against the root version before editing so field-specific logic is ported without reintroducing older config or asset assumptions
