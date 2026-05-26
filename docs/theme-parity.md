# Theme Park Parity

## Source Baseline

Theme Park documents 11 official theme options:

- Aquamarine
- Hotline
- Hotpink
- Dracula
- Dark
- Organizr
- Space Gray
- Overseerr
- Plex
- Nord
- Maroon

Theme Park also documents community theme options separately. Community themes are outside the first parity target.

## Current Plugin Coverage

| Theme Park option | Plugin status | Notes |
| --- | --- | --- |
| Aquamarine | Supported | Validated on Unraid `7.3.0` with `v0.1.0-beta.5`. |
| Dark | Supported | Validated on Unraid `7.3.0` with `v0.1.0-beta.5`. |
| Dracula | Supported | Validated on Unraid `7.3.0` with `v0.1.0-beta.5`. |
| Hotpink | Supported | Validated on Unraid `7.3.0` with `v0.1.0-beta.5`. |
| Nord | Supported | Validated on Unraid `7.3.0` with `v0.1.0-beta.5`. |
| Space Gray | Supported | Validated on Unraid `7.3.0` with `v0.1.0-beta.5`. |
| Hotline | Supported | Imported from Theme Park `1.22.0`; needs manual Unraid validation. |
| Organizr | Supported | Imported from Theme Park `1.22.0`; needs manual Unraid validation. |
| Overseerr | Supported | Imported from Theme Park `1.22.0`; needs manual Unraid validation. |
| Maroon | Supported | Imported from Theme Park `1.22.0`; needs manual Unraid validation. |
| Plex | Deferred | Upstream references `/resources/...`; needs local asset packaging before support. |

## Parity Plan

1. Test Hotline, Organizr, Overseerr, and Maroon on Unraid `7.3.0`.
2. Test Dashboard, Apps, Main, Docker, Plugins, and Settings for each new theme.
3. Add targeted overrides only when a theme accent or button state fails contrast.
4. Keep Plex deferred until resource references are vendored and rewritten to local plugin paths.

## Non-Goals For First Parity Pass

- Community theme options.
- Theme Park application support beyond Unraid.
- Remote runtime dependency on `theme-park.dev`.
