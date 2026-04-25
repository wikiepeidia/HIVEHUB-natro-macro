# Phase 2: UI And Persistence - Context

**Gathered:** 2026-04-24
**Status:** Ready for planning
**Mode:** Autonomous auto-discuss (agent-picked defaults)

<domain>
## Phase Boundary

Phase 2 exposes Trading Hub in the main gather UI and the persisted gather-slot config flow so the root macro can select, save, reload, and reuse Trading Hub like a supported field. This phase does not broaden Trading Hub into planter/manual field registries, does not refresh bitmap assets, and does not do end-to-end live gather validation.

</domain>

<decisions>
## Implementation Decisions

### UI exposure scope

- **D-01:** Trading Hub should be selectable in the main gather slot dropdowns (`FieldName1..3`) so the user can choose it in the primary macro flow.
- **D-02:** Trading Hub should not be added to planter/manual field registries that reuse `fieldnamelist` indirectly today; Phase 2 should keep those surfaces Trading-Hub-free to avoid unsupported planter leakage.

### Persistence strategy

- **D-03:** Trading Hub selection should persist through the existing `settings\nm_config.ini` keys (`FieldName1..3`, `CurrentFieldNum`) rather than a Trading-Hub-only settings path.
- **D-04:** Copy/paste gather settings should accept Trading Hub through the same gather-specific field validation surface used by the main dropdowns.

### Safety posture

- **D-05:** When a gather slot is set to Trading Hub, unsupported controls for that slot should be disabled or ignored safely rather than exposed as if fully supported.
- **D-06:** The unsupported slot controls to guard are the donor-proven sprinkler/drift surfaces: drift compensation, sprinkler location controls/help, and sprinkler distance controls for the selected Trading Hub slot.

### UI behavior tone

- **D-07:** Phase 2 should preserve the existing UI look and control layout; no new visual redesign or explanatory copy is required unless a guard would otherwise be invisible or misleading.

### the agent's Discretion

- Whether the safest implementation is a dedicated gather-only field list or another narrow selector-specific injection path, as long as planter/manual lists remain untouched.
- Exact helper shape for slot-specific enable/disable logic, as long as all three gather slots stay behaviorally consistent.
- Whether unsupported Trading Hub controls are only disabled in selection handlers or also normalized during initial GUI load, as long as reload state is correct.

</decisions>

<code_context>

## Existing Code Insights

### Reusable Assets

- `submacros/natro_macro.ahk` already owns the main gather dropdowns (`FieldName1..3`), slot persistence writes, and slot enable/disable logic in `nm_FieldSelect1/2/3`.
- `settings\nm_config.ini` already persists gather slot names and the current slot selection.
- The donor `Hub file\submacros\natro_macro.ahk` contains the known Trading Hub slot-guard pattern for drift and sprinkler controls.

### Established Patterns

- Gather slot changes are handled through `nm_FieldSelect1/2/3`, which both persist the field choice and toggle related controls for each slot.
- `fieldnamelist` is currently shared by the main gather dropdowns and planter/manual field surfaces, so naive reuse would leak Trading Hub into unsupported planner flows.
- Copy/paste gather settings validates field names through `fieldnamelist`, so any gather-only Trading Hub exposure must account for that persistence path too.

### Integration Points

- Main gather dropdown definitions near the `FieldName1..3` GUI controls.
- `nm_FieldSelect1/2/3` for slot-specific enable/disable behavior and persistence writes.
- `nm_PasteGatherSettings` for gather-setting import validation.
- `MFieldList := [""].Push(fieldnamelist*)` and related planter/manual field surfaces that should remain Trading-Hub-free in this phase.

</code_context>

<specifics>
## Specific Ideas

- Keep the UI change narrow: Trading Hub should appear where users choose gather fields, not where planter/manual cycles enumerate standard pollen fields.
- Mirror the donor's safe disable behavior for unsupported controls, but do not copy broader donor UI changes that are unrelated to Trading Hub.
- Preserve the existing UI layout and naming so Phase 2 feels native to the current root macro.

</specifics>

<deferred>
## Deferred Ideas

- Refactoring all field lists so special destinations and planter fields are fully separated by architecture (`CLN-01`) — later work.
- Richer Trading Hub-specific helper copy or stronger UX messaging (`UX-01`, `UX-02`) — later work.
- Bitmap refresh and end-to-end live gather validation — Phase 3.

</deferred>

---

*Phase: 02-ui-and-persistence*
*Context gathered: 2026-04-24*
