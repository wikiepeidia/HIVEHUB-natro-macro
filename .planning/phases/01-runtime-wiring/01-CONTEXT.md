# Phase 1: Runtime Wiring - Context

**Gathered:** 2026-04-24
**Status:** Ready for planning

<domain>
## Phase Boundary

Phase 1 makes Trading Hub a valid root-owned runtime field by wiring only the minimum registries and runtime behaviors needed for safe travel, gather dispatch, metadata lookup, and return flow in the main macro. This phase does not expose Trading Hub in the main UI and does not broaden it into unrelated shared field systems.

</domain>

<decisions>
## Implementation Decisions

### Runtime registration boundary

- **D-01:** Phase 1 wires Trading Hub only into the root runtime registries needed for valid dispatch and defaults; shared UI-facing field lists remain Phase 2 work.
- **D-02:** Trading Hub is treated as a special destination in Phase 1, not as a normal field everywhere the monolith consumes field names.

### Metadata posture

- **D-03:** Root booster metadata should contain an explicit Trading Hub entry with `booster:"none"` and `stacks:0` rather than relying on missing-key handling or ad hoc special cases.

### Visibility boundary

- **D-04:** Phase 1 may leave Trading Hub non-selectable in the main UI as long as the root runtime can accept and execute Trading Hub safely.

### the agent's Discretion

- Exact code locations and helper shape for the Phase 1 guardrails that keep Trading Hub out of unrelated shared field systems.
- Whether the initial Trading Hub default profile matches the donor baseline exactly or uses a nearby safe variant, as long as Phase 1 runtime validity is preserved.
- Whether the final return implementation is strict Rejoin-only or Rejoin with an internal fallback, since exit-policy specifics were not locked in this discussion.

</decisions>

<specifics>
## Specific Ideas

- Keep Phase 1 narrow and runtime-only.
- Do not pull broad donor parity or UI exposure forward just because the donor file already did.
- Treat Trading Hub as an intentionally special destination until later phases opt it into other field systems.

</specifics>

<canonical_refs>

## Canonical References

**Downstream agents MUST read these before planning or implementing.**

### Project definition

- `.planning/PROJECT.md` — project scope, root-first integration rule, and the no-broad-merge constraint.
- `.planning/REQUIREMENTS.md` — Phase 1 requirements FIELD-03, FLOW-01, FLOW-03, FLOW-04, and SAFE-03.
- `.planning/ROADMAP.md` — Phase 1 goal, scope boundary, and success criteria.
- `.planning/research/SUMMARY.md` — brownfield findings, known risks, and recommended build order.

### Root integration surfaces

- `submacros/natro_macro.ahk` — owning runtime registries, default maps, shared field lists, return-type controls, and gather exit logic.
- `paths/gtf-tradinghub.ahk` — existing root Trading Hub travel route that should be reused rather than recreated.
- `settings/field_config.ini` — persisted field-default store; currently has no Trading Hub section.

### Donor reference only

- `Hub file/submacros/natro_macro.ahk` — donor Trading Hub registrations, metadata, defaults, and Rejoin behavior for narrow reference only.
- `Hub file/settings/field_config.ini` — donor Trading Hub default profile baseline.

</canonical_refs>

<code_context>

## Existing Code Insights

### Reusable Assets

- `paths/gtf-tradinghub.ahk`: existing root travel path for Trading Hub.
- `submacros/natro_macro.ahk`: current owners of `fieldnames`, `FieldBooster`, `FieldDefault`, `fieldnamelist`, `nm_FieldReturnType`, and the gather exit flow.
- `settings/field_config.ini`: persisted default store that will need a Trading Hub entry once the runtime map exists.
- `Hub file/settings/field_config.ini`: one known-good Trading Hub default profile that researcher/planner can compare against the root behavior.

### Established Patterns

- Field validity is centralized in large arrays and maps inside `submacros/natro_macro.ahk`; missing entries propagate into load and dispatch failures.
- Booster behavior is explicit metadata, not inferred, so special destinations are safer when represented as deliberate map entries.
- Return type choices are centrally enumerated, so any `Rejoin` support change touches shared control flow even if UI exposure stays deferred.

### Integration Points

- Root field registration around the `fieldnames` array.
- Root metadata/default maps: `FieldBooster` and `FieldDefault`.
- Runtime load/persistence flow where `FieldDefault[FieldName]` expands into active slot variables.
- Return control surfaces: `nm_FieldReturnType(...)` and the gather exit logic near `FieldReturnType="walk"`.
- Shared field list `fieldnamelist` is a Phase 2 boundary surface, not a default Phase 1 target.

</code_context>

<deferred>
## Deferred Ideas

None — discussion stayed within phase scope.

</deferred>

---

*Phase: 01-runtime-wiring*
*Context gathered: 2026-04-24*
