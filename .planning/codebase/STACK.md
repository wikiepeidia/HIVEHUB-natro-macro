# Stack

## Summary

This codebase is a Windows-only Bee Swarm Simulator macro written primarily in AutoHotkey v2 and launched through a batch wrapper. The shipped runtime is source-first: the repository contains the main `.ahk` scripts, bundled AutoHotkey executables, INI configuration, and large image-search asset packs rather than a compiled build pipeline.

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
