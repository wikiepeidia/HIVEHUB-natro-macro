# Requirements: Natro Macro Trading Hub Port

**Defined:** 2026-04-24
**Core Value:** Trading Hub must work in the main macro with the same level of reliability and discoverability as the existing built-in fields.

## v1 Requirements

### Field Selection

- [ ] **FIELD-01**: User can select Trading Hub as a supported field in the main macro UI
- [ ] **FIELD-02**: User's Trading Hub field choice persists across reloads in the main macro config flow
- [ ] **FIELD-03**: User gets a valid Trading Hub default profile when the field is selected, without missing-field or missing-metadata errors

### Runtime Flow

- [ ] **FLOW-01**: Macro can travel to Trading Hub through the root route integration
- [ ] **FLOW-02**: Macro can gather in Trading Hub with a supported pattern and field profile
- [ ] **FLOW-03**: Macro can complete a Trading Hub run through a supported return path
- [ ] **FLOW-04**: Trading Hub runs do not break current-field, booster, or related field metadata logic

### Safety And Assets

- [ ] **SAFE-01**: Unsupported Trading Hub-specific controls are disabled or ignored safely
- [ ] **SAFE-02**: Any Trading Hub-specific bitmap lookups used by the root macro use current-compatible assets
- [ ] **SAFE-03**: Trading Hub support runs from the root macro without depending on the embedded `Hub file` runtime

## v2 Requirements

### UX Hardening

- **UX-01**: User sees clearer GUI messaging that Trading Hub is a special-case field
- **UX-02**: User gets stronger guardrails against unsupported Trading Hub settings combinations

### System Cleanup

- **CLN-01**: Field lists are refactored so special destinations do not leak into unrelated planter flows
- **CLN-02**: Old `Hub file` Trading Hub donor content is retired or clearly documented after the root port is complete

## Out of Scope

| Feature | Reason |
|---------|--------|
| Full merge of `Hub file` | This project is a narrow Trading Hub port, not a broad donor merge |
| Porting unrelated hub features | The user asked for Trading Hub only |
| Whole-field-system refactor | Too broad for this feature slice |
| Speculative Trading Hub asset pack | Asset work should only follow proven root runtime needs |

## Traceability

| Requirement | Phase | Status |
|-------------|-------|--------|
| FIELD-01 | Phase 2 | Pending |
| FIELD-02 | Phase 2 | Pending |
| FIELD-03 | Phase 1 | Pending |
| FLOW-01 | Phase 1 | Pending |
| FLOW-02 | Phase 3 | Pending |
| FLOW-03 | Phase 1 | Pending |
| FLOW-04 | Phase 1 | Pending |
| SAFE-01 | Phase 2 | Pending |
| SAFE-02 | Phase 3 | Pending |
| SAFE-03 | Phase 1 | Pending |

**Coverage:**

- v1 requirements: 10 total
- Mapped to phases: 10
- Unmapped: 0 ✓

---
*Requirements defined: 2026-04-24*
*Last updated: 2026-04-24 after roadmap creation*
