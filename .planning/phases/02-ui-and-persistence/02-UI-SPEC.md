---
phase: 2
slug: ui-and-persistence
status: approved
shadcn_initialized: false
preset: none
created: 2026-04-24
---

# Phase 2 — UI Design Contract

> Visual and interaction contract for the Trading Hub UI exposure phase. Generated autonomously from the current AutoHotkey GUI and Phase 2 context.

---

## Design System

| Property | Value |
|----------|-------|
| Tool | none |
| Preset | not applicable |
| Component library | none |
| Icon library | existing bitmap/gui assets only |
| Font | Tahoma |

---

## Spacing Scale

Declared values (must be multiples of 4):

| Token | Value | Usage |
|-------|-------|-------|
| xs | 4px | Tight label/help spacing |
| sm | 8px | Inline gaps between slot controls |
| md | 16px | Default control row spacing |
| lg | 24px | Grouped field control spacing |
| xl | 32px | Section separation |
| 2xl | 48px | Major tab breaks |
| 3xl | 64px | not used |

Exceptions: none

---

## Typography

| Role | Size | Weight | Line Height |
|------|------|--------|-------------|
| Body | 8px | 400 | 1.25 |
| Label | 8px | 400 | 1.25 |
| Heading | 8px | 700 | 1.25 |
| Display | 8px | 700 | 1.25 |

---

## Color

| Role | Value | Usage |
|------|-------|-------|
| Dominant (60%) | existing theme | Main dialog background and surfaces |
| Secondary (30%) | existing theme | Group boxes, separators, inactive surfaces |
| Accent (10%) | existing theme | Existing enabled-state affordances only |
| Destructive | existing theme | Existing confirmations/warnings only |

Accent reserved for: existing enabled/disabled control states and save/default affordances only

---

## Copywriting Contract

| Element | Copy |
|---------|------|
| Primary CTA | Keep existing control labels; no new CTA introduced in Phase 2 |
| Empty state heading | not applicable |
| Empty state body | not applicable |
| Error state | Reuse current warning dialogs for invalid pasted field/settings values |
| Destructive confirmation | Reuse existing save-default confirmation wording |

---

## Interaction Contract

| Surface | Contract |
|---------|----------|
| Gather field dropdowns | Trading Hub appears as a selectable option in `FieldName1..3` only |
| Planter/manual field surfaces | Trading Hub does not appear |
| Trading Hub slot controls | Drift compensation, sprinkler location, sprinkler location help, and sprinkler distance controls are disabled when that slot selects Trading Hub |
| Supported Trading Hub controls | Pattern, return type, and other existing supported gather settings stay in the current layout unless execution proves they must be guarded |
| Persistence | Field selection and pasted gather settings reuse the current `nm_config.ini`/clipboard flows |

---

## Registry Safety

| Registry | Blocks Used | Safety Gate |
|----------|-------------|-------------|
| Existing AutoHotkey GUI controls | Field dropdowns, slot toggles, help buttons, save/default actions | Gather-only Trading Hub exposure; no planter/manual leakage |
| Donor Trading Hub UI logic | Slot-specific disable patterns only | Port narrowly; do not copy unrelated donor UI behavior |

---

## Checker Sign-Off

- [x] Dimension 1 Copywriting: PASS
- [x] Dimension 2 Visuals: PASS
- [x] Dimension 3 Color: PASS
- [x] Dimension 4 Typography: PASS
- [x] Dimension 5 Spacing: PASS
- [x] Dimension 6 Registry Safety: PASS

**Approval:** approved 2026-04-24
