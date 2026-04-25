# Research Summary

## Scope

This is a brownfield feature port, not a new macro and not a merge of `Hub file\`. The root Natro Macro remains the source of truth, and Trading Hub should be integrated as one more root-owned field.

## Key Findings

**Stack:**

- Reuse the existing AutoHotkey v2 root macro, route system, field config, and image-search stack
- Start from the existing `paths\gtf-tradinghub.ahk` and `patterns\Squares.ahk`
- Add only the minimum root-side wiring, defaults, return behavior, and assets required

**Table Stakes:**

- Trading Hub must show up in the main macro UI
- The root macro must have valid Trading Hub defaults and metadata
- Travel, gather, persistence, and exit behavior must all work from the root tree
- Rejoin-safe return behavior is likely required

**Watch Out For:**

- `Hub file\` is stale; use it only as a donor reference
- Half-porting the field list/defaults/metadata will fail before or during runtime
- Trading Hub-specific bitmaps should be replaced only where a real lookup requires them
- Shared field lists may leak Trading Hub into other UI surfaces if not guarded

## Recommended Build Order

1. Register Trading Hub in the root metadata and default field flow
2. Add Trading Hub-safe return behavior and related guardrails
3. Expose Trading Hub in the main UI and validate config persistence
4. Run live validation through launch, field selection, travel, gather, and exit
5. Add or refresh bitmaps only for confirmed detection gaps

## Research Outcome

The Trading Hub port is feasible as a narrow root-side integration. The highest-value work is wiring and safe behavior in `submacros\natro_macro.ahk`, not broad donor copying.
