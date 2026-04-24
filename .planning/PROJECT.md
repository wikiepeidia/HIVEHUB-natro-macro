# Natro Macro Trading Hub Port

## What This Is

This project adds Trading Hub support to the main Natro Macro codebase so the field behaves like a native option instead of living in the old embedded `Hub file` snapshot. The goal is to port the Trading Hub-specific path, pattern, settings hooks, GUI exposure, and replacement bitmaps needed for the current root macro to recognize and run the field correctly.

## Core Value

Trading Hub must work in the main macro with the same level of reliability and discoverability as the existing built-in fields.

## Requirements

### Validated

- ✓ Main macro launches from `START.bat` into `submacros\natro_macro.ahk` and manages field automation end to end — existing
- ✓ Main macro already supports imported paths, imported patterns, and field-specific configuration through `settings\field_config.ini` — existing
- ✓ Main macro already uses bitmap-based detection and GUI-driven configuration for field automation — existing

### Active

- [ ] Trading Hub appears as a supported field in the main macro flow
- [ ] Main macro has the Trading Hub route/pattern logic needed to travel to and gather in that field
- [ ] Main macro has working Trading Hub bitmap assets compatible with the current root macro
- [ ] Any Trading Hub-specific settings needed by the feature are handled by the main macro without breaking existing fields
- [ ] The Trading Hub port avoids reintroducing obsolete behavior from the old `Hub file` snapshot

### Out of Scope

- Full merge of the embedded `Hub file` tree — only Trading Hub support is being ported
- Reusing obsolete Trading Hub bitmaps from the old hub snapshot without validation — they are already considered unusable for the target macro
- Unrelated field or hub feature ports — keep scope on Trading Hub only

## Context

This is a brownfield AutoHotkey v2 Bee Swarm Simulator macro with one dominant orchestrator in `submacros\natro_macro.ahk`, route files under `paths\`, movement patterns under `patterns\`, persisted state in `settings\*.ini`, and bitmap-driven detection under `nm_image_assets\`. The repository also contains an older mirrored `Hub file\` tree that appears to be a lagging subset of the main root tree. The requested work is to extract the useful Trading Hub behavior from that old snapshot, replace unusable bitmap assets, and integrate the feature into the current root macro rather than broadening the port.

## Constraints

- **Tech stack**: Must fit the existing AutoHotkey v2 + bundled runtime architecture — the main macro is the integration target
- **Compatibility**: Must preserve current root-macro behavior for existing fields — this is a feature port, not a rewrite
- **Asset quality**: Old Trading Hub bitmaps are not trustworthy — replacement/current-compatible bitmaps are required
- **Scope**: Only Trading Hub support is in scope — broader hub cleanup or other ports stay out of this project
- **Maintainability**: Avoid copying large stale sections from `Hub file\` when narrower root-targeted integration points exist

## Key Decisions

| Decision | Rationale | Outcome |
|----------|-----------|---------|
| Use the root macro as source of truth | The embedded `Hub file` tree is older and smaller than the root tree | — Pending |
| Scope the project to Trading Hub only | The user wants the feature port, not a broad hub merge | — Pending |
| Replace or re-capture Trading Hub bitmaps as needed | Existing old hub bitmaps are considered unusable in the current macro | — Pending |
| Port supporting settings/GUI hooks only when required by Trading Hub | The feature should appear and work naturally in the main macro, but scope should stay narrow | — Pending |

## Evolution

This document evolves at phase transitions and milestone boundaries.

**After each phase transition** (via `/gsd-transition`):
1. Requirements invalidated? → Move to Out of Scope with reason
2. Requirements validated? → Move to Validated with phase reference
3. New requirements emerged? → Add to Active
4. Decisions to log? → Add to Key Decisions
5. "What This Is" still accurate? → Update if drifted

**After each milestone** (via `/gsd-complete-milestone`):
1. Full review of all sections
2. Core Value check — still the right priority?
3. Audit Out of Scope — reasons still valid?
4. Update Context with current state

---
*Last updated: 2026-04-24 after initialization*