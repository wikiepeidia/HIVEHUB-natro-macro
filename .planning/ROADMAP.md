# Roadmap: Natro Macro Trading Hub Port

## Overview

This roadmap takes the Trading Hub feature from partial donor-only behavior to a root-owned Natro Macro field that can be selected, persisted, traveled to, gathered in, and exited safely. The work starts with root runtime wiring, then exposes the field through the main UI and config flow, and finishes with asset compatibility and end-to-end validation.

## Phases

- [x] **Phase 1: Runtime Wiring** - Register Trading Hub in the root macro and make its runtime flow safe (completed 2026-04-24)
- [x] **Phase 2: UI And Persistence** - Expose Trading Hub in the main UI with safe saved-state behavior (completed 2026-04-24)
- [ ] **Phase 3: Live Flow Validation** - Runtime work is complete; manual Roblox-backed validation is still pending

## Phase Details

### Phase 1: Runtime Wiring

**Goal**: Register Trading Hub in the root macro's field, route, metadata, and return flow so the feature can exist safely in runtime.
**Depends on**: Nothing (first phase)
**Requirements**: FIELD-03, FLOW-01, FLOW-03, FLOW-04, SAFE-03
**UI hint**: no
**Success Criteria** (what must be TRUE):

  1. Root macro can resolve Trading Hub as a valid field without missing-field or missing-metadata errors.
  2. Trading Hub travel dispatch reaches the root route and can complete with a supported return path.
  3. Trading Hub runtime behavior works entirely from the root tree without depending on the embedded `Hub file` runtime.
**Plans**: 3 plans

Plans:

- [x] 01-01: Wire Trading Hub into root field, route, and metadata registries
- [x] 01-02: Add Trading Hub-safe return and runtime guard behavior
- [x] 01-03: Validate root-only config loading and runtime dispatch

### Phase 2: UI And Persistence

**Goal**: Make Trading Hub selectable and persist correctly in the main macro while blocking unsupported controls.
**Depends on**: Phase 1
**Requirements**: FIELD-01, FIELD-02, SAFE-01
**UI hint**: yes
**Success Criteria** (what must be TRUE):

  1. User can select Trading Hub in the main macro UI.
  2. Trading Hub selection persists and reloads correctly in slot and field state.
  3. Unsupported Trading Hub-specific controls are disabled or ignored safely.
**Plans**: 2 plans

Plans:

- [x] 02-01: Expose Trading Hub in field selectors and slot-loading logic
- [x] 02-02: Add Trading Hub UI guardrails and persistence checks

### Phase 3: Live Flow Validation

**Goal**: Make the Trading Hub gather cycle work end to end with any required current-compatible assets.
**Depends on**: Phase 2
**Requirements**: FLOW-02, SAFE-02
**UI hint**: no
**Success Criteria** (what must be TRUE):

  1. Macro can gather in Trading Hub with the intended pattern and field profile.
  2. Any Trading Hub-specific bitmap lookups used by the root macro are current-compatible or proven absent.
  3. A full Trading Hub cycle is manually validated through launch, select, travel, gather, and exit.
**Plans**: 2 plans

Plans:

- [x] 03-01: Skip unsupported Trading Hub sprinkler setup and audit active asset lookups
- [x] 03-02: Write the live validation checklist and record deferred human validation

## Progress

**Execution Order:**
Phases execute in numeric order: 1 -> 2 -> 3

| Phase | Plans Complete | Status | Completed |
|-------|----------------|--------|-----------|
| 1. Runtime Wiring | 3/3 | Complete   | 2026-04-24 |
| 2. UI And Persistence | 2/2 | Complete   | 2026-04-24 |
| 3. Live Flow Validation | 2/2 | Awaiting human validation | - |
