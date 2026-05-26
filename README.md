# Unraid Theme Park

Theme Park-style themes for Unraid 7.2+ without the deprecated Theme Engine plugin.

## Project Status

This repository is in Phase 0 feasibility work. The first milestone is to prove a safe, reversible, plugin-owned stylesheet injection path on Unraid 7.2+ and 7.3+ before building the full theme pipeline.

## Current Direction

- Use Theme Park as the initial CSS seed, not as a runtime dependency.
- Package theme assets locally inside the plugin.
- Inject one plugin-owned stylesheet through Unraid's WebGUI plugin system.
- Keep disable, reset, and uninstall paths simple enough to recover stock UI without shell edits.

See [ADR 0001](docs/adr/0001-css-injection-path.md) and the [Phase 0 validation plan](docs/phase-0-validation.md).

## Build

```sh
scripts/check-scaffold.sh
scripts/build-plugin.sh
```

Build artifacts are written to `dist/`:

- `unraid.theme.park.plg`
- `unraid.theme.park-<version>-noarch-1.txz`

## Manual Scaffold Test

On a disposable Unraid 7.3.0 test host, install the generated package directly:

```sh
installpkg /path/to/unraid.theme.park-0.1.0-noarch-1.txz
/usr/local/emhttp/plugins/unraid.theme.park/scripts/apply-theme
```

Then open **Settings > Unraid Theme Park > Theme Settings**, choose a bundled theme, enable it, and refresh the WebGUI.

Remove the scaffold runtime files with:

```sh
rm -rf /usr/local/emhttp/plugins/unraid.theme.park
```
