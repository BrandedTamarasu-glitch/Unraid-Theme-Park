# Unraid Theme Park

Theme Park-style themes for Unraid 7.2+ without the deprecated Theme Engine plugin.

## Status

Unraid Theme Park is preparing its first beta release. Manual testing has validated the Theme Engine-free stylesheet hook, settings page, config persistence, theme switching, bundled Theme Park assets, and local compatibility layer on Unraid 7.3.0.

Unraid 7.2.x validation is still pending before wider beta distribution.

## Why This Exists

Theme Park's historical Unraid install path depended on Theme Engine. Unraid 7.2+ marks Theme Engine incompatible, which leaves users without the old supported path for applying Theme Park themes.

This plugin provides a native Unraid WebGUI plugin path:

- no Theme Engine
- no browser extension
- no reverse proxy injection
- no runtime dependency on `theme-park.dev`
- no core WebGUI file patching

## How It Works

The plugin uses a hidden Unraid `.page` file registered under `Menu='Buttons'`. Current Unraid WebGUI layouts include stylesheets for `Buttons` pages globally, so the plugin can load one local stylesheet on normal WebGUI pages without adding a visible nav button.

Runtime flow:

1. User chooses a theme in **Settings > Unraid Theme Park > Theme Settings**.
2. The plugin writes persistent config under `/boot/config/plugins/unraid.theme.park`.
3. The plugin generates `/usr/local/emhttp/plugins/unraid.theme.park/generated/current.css`.
4. The hidden global hook imports that generated stylesheet.

Architecture details are in [ADR 0001](docs/adr/0001-css-injection-path.md).

## Bundled Themes

The current curated beta set is vendored from Theme Park `1.22.0`:

- Aquamarine
- Dark
- Dracula
- Hotpink
- Nord
- Space Gray

Plex is deferred because the upstream theme references `/resources/...` image assets that are not packaged locally yet.

## Compatibility

Validated:

- Unraid 7.3.0

Targeted but not fully validated yet:

- Unraid 7.2.x
- Later Unraid 7.x releases

Unraid-specific readability and selector drift fixes live in:

```text
source/usr/local/emhttp/plugins/unraid.theme.park/themes/compat/unraid-7.css
```

## Install

Install-by-URL will be available after the first beta release asset is published.

Planned plugin URL:

```text
https://raw.githubusercontent.com/BrandedTamarasu-glitch/Unraid-Theme-Park/main/plugin/unraid.theme.park.plg
```

Until the beta release is published, use manual test installs only.

## Manual Test Install

On a disposable Unraid test host:

```sh
installpkg /path/to/unraid.theme.park-0.1.0-beta.1-noarch-1.txz
/usr/local/emhttp/plugins/unraid.theme.park/scripts/apply-theme
```

Then open **Settings > Unraid Theme Park > Theme Settings**, choose a bundled theme, enable it, apply, and refresh the WebGUI.

Remove runtime files:

```sh
rm -rf /usr/local/emhttp/plugins/unraid.theme.park
```

Reset persistent config:

```sh
rm -rf /boot/config/plugins/unraid.theme.park
```

## Build

```sh
scripts/check-scaffold.sh
scripts/build-plugin.sh
```

Build artifacts are written to `dist/`:

- `unraid.theme.park.plg`
- `unraid.theme.park-<version>-noarch-1.txz`

## Release Prep

```sh
scripts/prepare-release.sh 0.1.0-beta.1
```

This prepares:

- `plugin/unraid.theme.park.plg`
- `dist/unraid.theme.park-<version>-noarch-1.txz`
- `dist/release-notes-v<version>.md`

It does not publish a GitHub release. Follow [Release Process](docs/release-process.md) to avoid pushing an install manifest before its release asset exists.

## Project Docs

- [Roadmap](docs/roadmap.md)
- [Release process](docs/release-process.md)
- [Lifecycle testing](docs/lifecycle-testing.md)
- [Theme hardening](docs/theme-hardening.md)
- [Community beta plan](docs/community-beta.md)
- [Phase 0 validation](docs/phase-0-validation.md)

## Support Boundary

This is not a full Theme Engine replacement. The first beta focuses on reliable CSS theme application for Unraid 7.2+ using local assets and a reversible plugin lifecycle.

Deferred:

- Theme Engine migration
- custom CSS editor
- community theme imports
- Plex theme asset packaging
- login page theme packs
