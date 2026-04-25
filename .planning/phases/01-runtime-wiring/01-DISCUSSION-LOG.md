# Phase 1: Runtime Wiring - Discussion Log

> **Audit trail only.** Do not use as input to planning, research, or execution agents.
> Decisions are captured in CONTEXT.md — this log preserves the alternatives considered.

**Date:** 2026-04-24T06:24:30Z
**Phase:** 01-runtime-wiring
**Areas discussed:** Field identity

---

## Field identity

### Question 1: For Phase 1, how far should Trading Hub be registered in root code?

| Option | Description | Selected |
|--------|-------------|----------|
| Runtime-only first | Add Trading Hub only to the registries needed for runtime validity and dispatch in Phase 1; keep shared UI-facing lists for Phase 2 cleanup. | ✓ |
| Runtime plus shared field lists | Add Trading Hub to both runtime registries and shared field lists now, even if some UI cleanup is deferred to Phase 2. | |
| Mirror donor registration broadly | Follow the donor pattern closely and add Trading Hub anywhere the donor file currently wires it. | |

**User's choice:** Runtime-only first
**Notes:** UI exposure and shared list cleanup stay in Phase 2.

### Question 2: How should Trading Hub be represented in booster metadata during Phase 1?

| Option | Description | Selected |
|--------|-------------|----------|
| Explicit no-booster entry | Add Trading Hub to `FieldBooster` with `none/0` so root logic recognizes it as intentionally non-boosted. | ✓ |
| Leave it out and special-case callers | Do not add a booster entry; handle Trading Hub with conditional logic anywhere booster lookups would break. | |
| Defer booster handling | Avoid booster integration in Phase 1 and only patch failures if they appear later. | |

**User's choice:** Explicit no-booster entry
**Notes:** Trading Hub should be a known special case, not a missing key.

### Question 3: During Phase 1, how should Trading Hub interact with shared field systems beyond basic runtime flow?

| Option | Description | Selected |
|--------|-------------|----------|
| Guard it as a special destination | Only support the runtime paths needed for valid Travel/Gather/Return flow and keep Trading Hub out of unrelated shared field behaviors unless later phases add them intentionally. | ✓ |
| Let standard field logic include it | Once registered, allow existing shared field systems to treat Trading Hub like any other field unless a bug appears. | |
| Mixed approach | Allow some shared systems to see it now, but add guardrails only around the ones already known to be risky. | |

**User's choice:** Guard it as a special destination
**Notes:** Phase 1 should not widen Trading Hub into unrelated field systems.

### Question 4: Is Phase 1 allowed to leave Trading Hub non-selectable in the main UI while still making the runtime path valid?

| Option | Description | Selected |
|--------|-------------|----------|
| Yes, keep UI exposure for Phase 2 | Phase 1 should make Trading Hub runtime-valid but leave main UI selection and field-list exposure to the next phase. | ✓ |
| Expose it early if needed | If adding shared lists is the simplest way to validate runtime flow, it can appear in some UI surfaces before Phase 2 hardens them. | |
| I want it visible immediately | Treat visibility as part of Phase 1 even if that pulls some Phase 2 cleanup forward. | |

**User's choice:** Yes, keep UI exposure for Phase 2
**Notes:** Runtime readiness can ship before visible UI selection.

## the agent's Discretion

- Exact guard implementation shape inside the root macro.
- The initial Trading Hub default profile, which was not locked in this discussion.
- The final Rejoin-vs-fallback return behavior, which was not locked in this discussion.

## Deferred Ideas

None.
