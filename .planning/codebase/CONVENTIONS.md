# Conventions

## Language And File Style

- The codebase uses AutoHotkey v2 syntax and directives such as `#Requires AutoHotkey v2.0`, `#SingleInstance Force`, and `#Include`
- Relative includes are rooted from `A_ScriptDir` and then normalized with `SetWorkingDir A_ScriptDir "\.."`
- The project is source-oriented; runtime behavior is assembled through includes rather than package management

## Naming Conventions

- Core helper functions commonly use the `nm_` prefix, for example `nm_importPatterns()` and `nm_CreateFolder()`
- Batch-area helpers use additional prefixes such as `ba_` when grouped by subsystem inside the main script
- Path files use short route prefixes such as `gtf-`, `gtp-`, and `wf-`
- Config keys in INI files are mostly PascalCase or mixed-case descriptive names such as `DiscordMode`, `MainChannelID`, and `StickerStackCheck`

## Configuration Pattern

- Defaults are declared inside `submacros\natro_macro.ahk` as large `Map(...)` sections
- Persisted values live under `settings\*.ini`
- Imported user content is cached into `settings\imported\`
- Background/runtime scripts still read from shared INI state, which is a documented technical debt area

## Error Handling

- `lib\ErrorHandling.ahk` reads `HideErrors` from `settings\nm_config.ini` and sets a quiet `OnError` handler when enabled
- The main macro also uses `try`/`catch` extensively around file I/O, image search, COM calls, and runtime validation
- User-facing failures are often handled with `MsgBox` warnings rather than exceptions bubbling up

## Validation Pattern

- Imported pattern files are syntax-checked by spawning the 64-bit AutoHotkey runtime with `/Validate /ErrorStdOut`
- Unsafe third-party patterns trigger warning dialogs before import
- Runtime assumptions such as display scaling, admin access, and write permissions are checked at startup

## UI And Asset Conventions

- GUI widgets and skins are created directly in AutoHotkey rather than a separate UI layer
- Detection assets are organized by domain folder under `nm_image_assets\`, then bundled through `bitmaps.ahk` files using `Gdip_BitmapFromBase64(...)`
- A large number of behaviors rely on screen coordinates and image-search matches rather than stable typed interfaces

## Code Organization Reality

- The dominant convention is centralization in `submacros\natro_macro.ahk`, not small isolated modules
- Comments and TODOs are used heavily to mark rewrite areas, deprecated functions, and performance issues
- Object-oriented structure exists in places such as `lib\Discord.ahk`, but most business logic remains procedural

## Porting Guidance

- For a hub-field port, preserve existing prefixes, INI key naming, and `nm_` helper style so the new work blends into the root tree
- Avoid treating `Hub file\` as the owning source of truth without checking whether the root tree already added new config keys, assets, or message handlers
