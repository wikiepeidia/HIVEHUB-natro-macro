# Integrations

## External Systems

### Roblox Client

- The macro automates the local Roblox client rather than a network API
- `lib\Roblox.ahk` and the background scripts resolve the Roblox window handle, client bounds, and Y-offsets
- `submacros\background.ahk` runs continuous health and state checks against the live game window
- Most gameplay detection depends on bitmap/image search assets stored in `nm_image_assets\`

### Discord

- `lib\Discord.ahk` integrates with Discord via two modes:
  - webhook mode through a configured webhook URL
  - bot mode through Discord REST API v10 with channel IDs and bot tokens
- The implementation uses the Windows `WinHttp.WinHttpRequest.5.1` COM object rather than an SDK
- The main macro passes Discord-related settings such as `DiscordMode`, `webhook`, `bottoken`, `MainChannelID`, and `ReportChannelID` out of `settings\nm_config.ini`
- Screenshots and folders can be posted as attachments, with folders zipped through PowerShell before upload

### GitHub Automation

- `.github\workflows\discord-release.yml` publishes release notifications to Discord through `NatroTeam/discord-release-action@v2`
- `.github\workflows\discord-star.yml` posts GitHub star events to Discord through `NatroTeam/discord-star-action@v1.0`
- These workflows use GitHub secrets such as `RELEASE_BOT_TOKEN` and `STAR_WEBHOOK_URL`

## Windows Platform Dependencies

- `START.bat` uses `cscript` with embedded VBScript to inspect and extract zip contents
- `START.bat` and `lib\Discord.ahk` rely on PowerShell features such as `Compress-Archive`
- Several scripts use COM automation through `WScript.Shell`, `Shell.Application`, and `WinHttp.WinHttpRequest.5.1`
- The macro expects bundled `AutoHotkey32.exe` and optionally `AutoHotkey64.exe` in `submacros\`

## Filesystem Contracts

- The macro reads and writes INI state inside `settings\`
- Imported user path/pattern content is cached into `settings\imported\`
- `submacros\natro_macro.ahk` validates user-supplied pattern code by spawning the 64-bit AutoHotkey runtime in `/Validate /ErrorStdOut` mode

## What Is Not Present

- No database integration was found
- No browser automation framework was found
- No cloud storage, auth provider, or payment provider was found
- No HTTP server or IPC service was found beyond local Windows messages and outbound Discord traffic

## Porting-Relevant Integration Notes

- Any hub-field port has to respect both the local Roblox image-search flow and the Discord/reporting state that the root macro already carries
- Because `Hub file\` is not isolated, integration work should target the main tree first and then decide whether the mirrored tree should be retired or updated
