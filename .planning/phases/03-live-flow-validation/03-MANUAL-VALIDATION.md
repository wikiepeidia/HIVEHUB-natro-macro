# Phase 3: Trading Hub Manual Validation

**Status:** Pending human run
**Prepared:** 2026-04-24

## Goal

Validate a full Trading Hub cycle against the root macro only: launch, select, travel, gather, and exit.

## Preconditions

- Launch the root macro from `START.bat` or the normal root runtime path.
- Use the root workspace, not the embedded `Hub file` tree.
- Ensure at least one gather slot can be set to `Trading Hub`.

## Checklist

1. Launch the root macro and open the main gather UI.
Expected: the macro loads without missing-file or missing-image popups.

2. Set one gather slot to `Trading Hub`.
Expected: Trading Hub appears in the main gather selector and the slot saves normally.

3. Inspect the Trading Hub slot controls before starting a run.
Expected: unsupported Trading Hub controls stay disabled, including drift compensation and sprinkler location/distance controls.

4. Start a Trading Hub run from the root macro.
Expected: travel uses the existing `paths/gtf-tradinghub.ahk` route with no donor-runtime dependency.

5. Watch the start of gather setup in Trading Hub.
Expected: the macro does not attempt Trading Hub sprinkler-placement movement or jump-sprinkler behavior before gather begins.

6. Let gather begin with the current field profile.
Expected: Trading Hub uses the current root field defaults and the existing `Squares` pattern profile without crashing or falling back to missing defaults.

7. Observe the whole run for missing asset behavior.
Expected: no missing-image, missing-bitmap, or missing-file error dialogs appear during launch, travel, gather, or exit.

8. Let the run finish through the configured exit path.
Expected: Trading Hub exits through `Rejoin()` instead of a normal walk-back or whirligig return.

## Result Log

- Launch/UI result:
- Travel result:
- Gather start result:
- Sprinkler no-op result:
- Missing-image check result:
- Exit result:
- Overall result:

## If It Fails

- Record the exact failing step above.
- Note whether the failure is a runtime movement issue, a missing-image issue, or an exit-flow issue.
- Capture any error text shown by the macro before changing code.
