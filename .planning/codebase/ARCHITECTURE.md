# Architecture

## System Shape

This project is a source-distributed desktop automation system centered on one large AutoHotkey orchestrator. Control starts in `START.bat`, enters `submacros\natro_macro.ahk`, then fans out into helper submacros, shared libraries, path/pattern scripts, INI-backed settings, and bitmap-driven detection modules.

## Primary Control Path

1. `START.bat` ensures the bundled runtime and source files exist, then launches `submacros\AutoHotkey32.exe` with `submacros\natro_macro.ahk`
2. `submacros\natro_macro.ahk` forces 32-bit execution, checks elevation/write access, sets working directory, and bootstraps global message handlers
3. The main script imports libraries from `lib\`, loads/defaults config maps, imports pattern/path scripts from `patterns\` and `paths\`, and initializes GUI state
4. Supporting scripts such as `submacros\Heartbeat.ahk` and `submacros\background.ahk` run alongside the main macro and exchange state through Windows messages and shared config
5. Image-search bundles under `nm_image_assets\` drive most in-game detection and GUI recognition

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
