# Features Research

## Table Stakes

- Trading Hub appears in the main macro as a selectable field
- Selecting Trading Hub loads valid default settings instead of missing-field state
- The root macro can travel to Trading Hub through the existing route file
- The root macro can gather there with a known-good pattern and stable field profile
- Gather completion uses a supported return path for Trading Hub, likely Rejoin rather than Walk
- Trading Hub does not break boost, slot persistence, or field metadata lookups

## Supporting Requirements

- `settings\field_config.ini` persists a Trading Hub section
- Root field metadata includes a safe booster/no-booster entry for Trading Hub
- GUI logic disables or ignores controls that do not make sense for Trading Hub, especially field-only drift or sprinkler assumptions if needed
- Any Trading Hub-specific assets used by the port are compatible with the current root macro
- Manual validation exists for launch, field selection, travel, gather, persistence, and exit behavior

## Nice To Have Later

- Clear GUI messaging that Trading Hub is a special-case field
- Stronger guardrails preventing unsupported combinations like Walk return if Rejoin is mandatory
- Better field-list separation so special destinations do not leak into unrelated planter flows
- Dedicated Trading Hub asset capture only if live runtime failures prove it necessary

## Explicit Non-Goals

- Full merge of the old `Hub file\` tree
- Porting unrelated hub features or other stale donor behavior
- General refactor of the whole field system
- Adding planter, boost rotation, or unrelated route work beyond what Trading Hub needs to function cleanly

## Integration Dependencies

- Root field/path registration inside `submacros\natro_macro.ahk`
- Field default and slot-persistence logic in the root config flow
- Return/rejoin logic in the root gather exit flow
- Optional bitmap refresh work if the current runtime depends on Trading Hub-specific visual detection

## Confidence Assessment

- High: field registration, defaults, route wiring, and return behavior are required
- Medium: exact GUI and bitmap scope depends on how much current root behavior already generalizes to Trading Hub
