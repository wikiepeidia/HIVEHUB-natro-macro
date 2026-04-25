<!-- GSD:project-start source:PROJECT.md -->
## Project

**Natro Macro Trading Hub Port**

This project adds Trading Hub support to the main Natro Macro codebase so the field behaves like a native option instead of living in the old embedded `Hub file` snapshot. The goal is to port the Trading Hub-specific path, pattern, settings hooks, GUI exposure, and replacement bitmaps needed for the current root macro to recognize and run the field correctly.

**Core Value:** Trading Hub must work in the main macro with the same level of reliability and discoverability as the existing built-in fields.

### Constraints

- **Tech stack**: Must fit the existing AutoHotkey v2 + bundled runtime architecture — the main macro is the integration target
- **Compatibility**: Must preserve current root-macro behavior for existing fields — this is a feature port, not a rewrite
- **Asset quality**: Old Trading Hub bitmaps are not trustworthy — replacement/current-compatible bitmaps are required
- **Scope**: Only Trading Hub support is in scope — broader hub cleanup or other ports stay out of this project
- **Maintainability**: Avoid copying large stale sections from `Hub file\` when narrower root-targeted integration points exist
<!-- GSD:project-end -->

<!-- GSD:stack-start source:codebase/STACK.md -->
## Technology Stack

## Summary
## Runtime
- Primary launcher: `START.bat`
- Main entrypoint: `submacros\natro_macro.ahk`
- Bundled runtimes: `submacros\AutoHotkey32.exe`, `submacros\AutoHotkey64.exe`
- Required script version: `#Requires AutoHotkey v2.0` in `submacros\natro_macro.ahk`
- OS assumptions: Windows desktop, Roblox installed locally, write access to the macro directory, display scaling at 100%
## Languages And Formats
- AutoHotkey: 154 `.ahk` files in the main tree
- Batch/WSF: `START.bat` includes an embedded VBScript extraction helper
- INI: persistent runtime state under `settings\*.ini`
- YAML: GitHub Actions workflow files under `.github\workflows\`
- PNG/Base64 assets: raw image files plus generated bitmap bundles under `nm_image_assets\`
## Core Libraries
- `lib\Gdip_All.ahk` and `lib\Gdip_ImageSearch.ahk` provide bitmap/image search primitives
- `lib\Roblox.ahk` encapsulates Roblox window discovery and client positioning
- `lib\Walk.ahk` contains movement helpers reused by paths and field logic
- `lib\JSON.ahk` is used for JSON parsing and Discord payload generation
- `lib\Discord.ahk` handles webhook and bot-based Discord messaging
- `lib\ErrorHandling.ahk` centralizes `OnError` behavior based on `settings\nm_config.ini`
- `lib\DurationFromSeconds.ahk` and `lib\nowUnix.ahk` support timers and scheduling
## State And Configuration
- Main config: `settings\nm_config.ini`
- Field profiles: `settings\field_config.ini`
- Manual planter state: `settings\manual_planters.ini`
- Mutation settings: `settings\mutations.ini`
- Imported generated caches: `settings\imported\patterns.ahk`, `settings\imported\paths.ahk`
- Debug/log state: `settings\debug_log.txt`, `settings\COMPARISION\`
## Domain Assets
- Paths: 92 field/travel scripts under `paths\`
- Patterns: 14 gather patterns under `patterns\`
- Sub-process macros: 7 scripts under `submacros\`
- Bitmap bundles: 24 `.ahk` asset files under `nm_image_assets\**\bitmaps.ahk`
## Packaging Model
- No `package.json`, `requirements.txt`, or other package manager manifest was found
- No build or compile automation was found in the repo
- Distribution appears to be a zipped folder launched directly with `START.bat`
- `START.bat` can re-extract the macro from a nearby zip when the working folder is incomplete
## Parallel Tree
- `Hub file\` is a second macro tree that mirrors the main structure
- The hub tree is smaller than the root tree and looks like an older subset rather than an independent package
<!-- GSD:stack-end -->

<!-- GSD:conventions-start source:CONVENTIONS.md -->
## Conventions

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
<!-- GSD:conventions-end -->

<!-- GSD:architecture-start source:ARCHITECTURE.md -->
## Architecture

## System Shape
## Primary Control Path
## Major Components
### Launcher Layer
- `START.bat`
- Responsibility: bootstrap the runtime, recover from partially extracted zips, and hand off to AutoHotkey
### Orchestrator Layer
- `submacros\natro_macro.ahk` (~22.9k lines)
- Responsibility: startup checks, config defaults, GUI creation, automation scheduling, travel/collection logic, and submacro coordination
### Background Workers
- `submacros\Heartbeat.ahk`
- `submacros\background.ahk`
- `submacros\Status.ahk`
- `submacros\StatMonitor.ahk`
- `submacros\PlanterTimers.ahk`
- Responsibility: asynchronous checks, status overlays, telemetry, and long-running monitoring loops
### Shared Library Layer
- `lib\*.ahk`
- Responsibility: window interaction, walking helpers, JSON/Discord support, image-search primitives, and lightweight error handling
### Content Packs
- `paths\*.ahk` encode travel/collection routes
- `patterns\*.ahk` encode field movement patterns
- `nm_image_assets\**\bitmaps.ahk` and raw PNG files provide detection references
## Communication Model
- In-process modules are connected through `#Include`
- Cross-script coordination uses `OnMessage`, `PostMessage`, and `WM_COPYDATA`
- Persistent state is also written into `settings\nm_config.ini`, which some scripts read repeatedly
- `submacros\background.ahk` explicitly notes this INI-based communication is inefficient and should move toward message passing
## Data Flow
- Config defaults are declared in the main script, then merged with values stored in `settings\*.ini`
- Paths and patterns are discovered from the filesystem, syntax-checked, and cached to `settings\imported\`
- Runtime automation reads Roblox window pixels and bitmap bundles, derives game state, then triggers navigation, collection, GUI, and Discord behaviors
- Logs/debug state accumulate in `settings\debug_log.txt` and related comparison artifacts
## Architectural Pressure Points
- The monolithic main script is the true decision point for feature work; most supporting files feed it rather than own end-to-end behavior
- `Hub file\` duplicates the overall architecture, which creates drift and doubles maintenance cost
- Because detection, routing, and configuration all meet in the same main file, even narrow feature ports can cross multiple concerns quickly
<!-- GSD:architecture-end -->

<!-- GSD:skills-start source:skills/ -->
## Project Skills

No project skills found. Add skills to any of: `.github/skills/`, `.agents/skills/`, `.cursor/skills/`, or `.github/skills/` with a `SKILL.md` index file.
<!-- GSD:skills-end -->

<!-- GSD:workflow-start source:GSD defaults -->
## GSD Workflow Enforcement

Before using Edit, Write, or other file-changing tools, start work through a GSD command so planning artifacts and execution context stay in sync.

Use these entry points:
- `/gsd-quick` for small fixes, doc updates, and ad-hoc tasks
- `/gsd-debug` for investigation and bug fixing
- `/gsd-execute-phase` for planned phase work

Do not make direct repo edits outside a GSD workflow unless the user explicitly asks to bypass it.
<!-- GSD:workflow-end -->



<!-- GSD:profile-start -->
## Developer Profile

> Profile not yet configured. Run `/gsd-profile-user` to generate your developer profile.
> This section is managed by `generate-claude-profile` -- do not edit manually.
<!-- GSD:profile-end -->
