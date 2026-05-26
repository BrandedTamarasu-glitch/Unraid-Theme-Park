# Roadmap

## 1. Release Packaging

- Automate package and plugin manifest generation.
- Commit `plugin/unraid.theme.park.plg` for install-by-URL.
- Publish release artifacts only after manual review.

## 2. Lifecycle Testing

- Validate install, enable, switch, disable, reboot, reinstall, and uninstall.
- Record tested Unraid versions in release notes.

## 3. User Docs

- Document supported versions and themes.
- Provide recovery commands.
- State that this is not Theme Engine parity.

## 4. Theme Hardening

- Patch Unraid-specific readability issues through `themes/compat/unraid-7.css`.
- Keep upstream Theme Park assets vendored and reproducible.

## 5. Community Beta

- Use `v0.1.2` as the current community test baseline for Unraid `7.3.0`.
- Validate beta on latest Unraid `7.2.x`.
- Collect screenshots and environment details.
- Keep Plex deferred until its resource assets are packaged locally.

## 6. Versioning

- Use plain numeric plugin versions such as `0.1.2`.
- Avoid prerelease suffixes in installable Unraid plugin manifests because Unraid can compare suffixes unexpectedly.
