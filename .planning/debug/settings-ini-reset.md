---
status: resolved
slug: settings-ini-reset
created: 2026-04-24
updated: 2026-04-24
issue: Macro reset settings on restart because saved INI values were not being read at startup.
---

# Settings INI Reset Debug Session

## Symptoms

- Expected: values in `settings/nm_config.ini` and `settings/manual_planters.ini` persist across macro restarts.
- Actual: startup reset settings back to defaults and rewrote the INI files.
- Errors: no explicit runtime error reported.
- Timeline: started after the recent update/reapply.
- Reproduction: close and reopen the macro; saved settings are replaced by defaults.

## Root Cause

`nm_ReadIni(path)` in `submacros/natro_macro.ahk` was accidentally changed from a generic INI parser into a field-default-specific condition:

- It skipped section headers entirely.
- It gated key parsing on `FieldDefault.Has(s)`.
- During config startup, that prevented `settings/nm_config.ini` and `settings/manual_planters.ini` from loading saved values.
- `nm_importConfig()` and the manual-planter importer then wrote the default globals back out, causing the observed reset.

## Fix

Restored `nm_ReadIni(path)` to:

- capture section headers via `case "[": s := SubStr(...)`
- ignore comments only
- parse any `key=value` line generically without the `FieldDefault.Has(s)` gate

## Validation

- `cmd //c "submacros\\AutoHotkey64.exe /Validate /ErrorStdOut submacros\\natro_macro.ahk"` passed after the fix.
- A narrow parser simulation against the real `settings/nm_config.ini` returned live saved values instead of defaults.

## Notes

- This fix restores future persistence. Any settings already overwritten by the broken startup path would need to be re-entered unless you have an older backup of the INI files.
