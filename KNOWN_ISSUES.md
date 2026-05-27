# Known Issues

This file tracks the current support boundary for the `v0.1.7` community test baseline.

## Deferred Themes

- Plex is not bundled yet. The upstream Theme Park Plex option references `/resources/...` assets that need to be packaged locally and rewritten before the theme can be supported without broken image paths.
- Theme Park community themes are not part of the first parity target.

## Versioning

- Installable Unraid plugin versions should use plain numeric values such as `0.1.7`.
- Avoid prerelease suffixes such as `-beta.10` in `plugin/unraid.theme.park.plg`; Unraid can compare those suffixes unexpectedly and reject a newer build as older.

## Unraid Versions

- `v0.1.7` is manually validated on Unraid `7.3.0`.
- Latest Unraid `7.2.x` still needs a community validation report.
- Later Unraid `7.x` releases may require selector updates if the WebGUI markup changes.

## Third-Party Plugin Pages

The compatibility layer currently includes targeted readability fixes for:

- Community Applications
- Unassigned Devices

Other third-party plugins may still render stock light surfaces or low-contrast text. Please report those with:

- Unraid version
- Unraid Theme Park version
- selected theme
- browser
- affected page or plugin
- screenshot

Use the GitHub issue templates when possible. The reporting checklist lives in
[Reporting issues](docs/reporting-issues.md).

## Browser Cache

After switching themes or updating the plugin, the browser may keep an older imported stylesheet. Hard-refresh before filing a readability report:

- Windows/Linux: `Ctrl+F5`
- macOS: `Cmd+Shift+R`

## Not In Scope Yet

- Theme Engine migration tooling
- custom CSS editor
- login page theme packs
- remote runtime dependency on `theme-park.dev`
