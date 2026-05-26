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

## Attribution

Official Theme Park option CSS is vendored from `themepark-dev/theme.park@1.22.0`.

- Theme Park docs: <https://docs.theme-park.dev/>
- Theme Park source: <https://github.com/themepark-dev/theme.park/>

Theme Park was created by gilbN with contributions from the Theme Park community. Unraid Theme Park is an independent Unraid plugin adaptation that packages selected CSS locally for Unraid `7.2+`; it is not the upstream Theme Park project.

## Current Plugin Coverage

| Theme Park option | Plugin status | Notes |
| --- | --- | --- |
| Aquamarine | Supported | Validated on Unraid `7.3.0` with `v0.1.0-beta.7`. |
| Dark | Supported | Validated on Unraid `7.3.0` with `v0.1.0-beta.7`. |
| Dracula | Supported | Validated on Unraid `7.3.0` with `v0.1.0-beta.7`. |
| Hotpink | Supported | Validated on Unraid `7.3.0` with `v0.1.0-beta.7`. |
| Nord | Supported | Validated on Unraid `7.3.0` with `v0.1.0-beta.7`. |
| Space Gray | Supported | Validated on Unraid `7.3.0` with `v0.1.0-beta.7`. |
| Hotline | Supported | Imported from Theme Park `1.22.0`; included in `v0.1.0-beta.7`. |
| Organizr | Supported | Imported from Theme Park `1.22.0`; included in `v0.1.0-beta.7`. |
| Overseerr | Supported | Imported from Theme Park `1.22.0`; included in `v0.1.0-beta.7`. |
| Maroon | Supported | Imported from Theme Park `1.22.0`; included in `v0.1.0-beta.7`. |
| Plex | Deferred | Upstream references `/resources/...`; needs local asset packaging before support. |

## Local Theme Coverage

The plugin also bundles standalone Unraid themes from BrandedTamarasu-glitch repositories. These are not Theme Park parity items, but they are first-class selectable plugin themes.

| Theme | Source | Notes |
| --- | --- | --- |
| Crema | `BrandedTamarasu-glitch/Ground_Control@da92af7749e7dd18cf42a6b115d56b22201324d3` | Light Ground Control theme; included in `v0.1.0-beta.7`. |
| Meridian | `BrandedTamarasu-glitch/unraid-meridian@9a3f3fb5a923e570d8a2076fb3070cad05eb20e2` | Dark Meridian theme; included in `v0.1.0-beta.7`. |
| Meridian Light | `BrandedTamarasu-glitch/unraid-meridian@9a3f3fb5a923e570d8a2076fb3070cad05eb20e2` | Light Meridian theme; included in `v0.1.0-beta.7`. |
| Ristretto | `BrandedTamarasu-glitch/Ground_Control@da92af7749e7dd18cf42a6b115d56b22201324d3` | Dark Ground Control theme; included in `v0.1.0-beta.7`. |

## Parity Plan

1. Test Hotline, Organizr, Overseerr, and Maroon on Unraid `7.3.0`.
2. Test Dashboard, Apps, Main, Docker, Plugins, and Settings for each new theme.
3. Add targeted overrides only when a theme accent or button state fails contrast.
4. Keep Plex deferred until resource references are vendored and rewritten to local plugin paths.

## Non-Goals For First Parity Pass

- Community theme options.
- Theme Park application support beyond Unraid.
- Remote runtime dependency on `theme-park.dev`.
