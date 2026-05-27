# Lifecycle Testing

Run this matrix on a disposable Unraid host before each community test release.

## Environment

- Unraid `7.3.0`, validated manually with `v0.1.7`.
- Add latest `7.2.x` before wider beta.
- Chromium browser.
- Firefox browser.
- Top navigation layout.
- Sidebar layout.

## Tests

### Fresh Install

1. Install from the plugin URL.
2. Confirm **Settings > Unraid Theme Park > Theme Settings** appears.
3. Confirm default state is disabled.
4. Confirm no visible Theme Park marker or theme is active before enabling.

### Enable Theme

1. Select `Dark`.
2. Check `Enabled`.
3. Apply.
4. Refresh.
5. Confirm theme is visible.

### Switch Theme

1. Switch through Aquamarine, Dracula, Hotpink, Nord, and Space Gray.
2. Refresh after each selection.
3. Confirm no blank page or unreadable primary navigation.

### Plugin Compatibility Spot Checks

1. Open Apps / Community Applications.
2. Confirm the search area, category sidebar, and app cards are readable.
3. Open Main with Unassigned Devices visible.
4. Confirm `usb_mounts`, `samba_mounts`, `disk-table-body`, and `remotes-table-body` rows do not render stock white boxes in dark themes.

### Disable Theme

1. Uncheck `Enabled`.
2. Apply.
3. Refresh.
4. Confirm stock styling returns.

### Reboot Persistence

1. Enable a non-default theme.
2. Reboot.
3. Confirm selected theme remains active after the WebGUI reloads.

### Reinstall Over Config

1. Keep an existing config in `/boot/config/plugins/unraid.theme.park`.
2. Reinstall the plugin package.
3. Confirm the selected theme survives reinstall.

### Uninstall Cleanup

1. Remove the plugin.
2. Confirm `/usr/local/emhttp/plugins/unraid.theme.park` is gone.
3. Confirm no theme CSS applies after refresh.
4. Confirm `/boot/config/plugins/unraid.theme.park/unraid.theme.park.cfg` may remain so user settings survive reinstall.

Validated on Unraid `7.3.0` with the built-in plugin uninstaller:

- `/usr/local/emhttp/plugins/unraid.theme.park` was removed.
- `/boot/config/plugins/unraid.theme.park/unraid.theme.park.cfg` remained.
- Retaining the config is intentional unless a future purge option is added.

## Validation Log

### Unraid 7.3.0, `v0.1.7`

Manual validation passed:

- Install from published plugin manifest.
- Theme switching across bundled Theme Park options and local Unraid themes.
- Local theme validation for Crema, Meridian, Meridian Light, and Ristretto.
- Dashboard readability.
- Apps / Community Applications readability, including top search area and category sidebar.
- Unassigned Devices readability, including disk and remote share table rows.
- Main, Docker, Plugins, and Settings spot checks.
- Disable and stock-style return.
- Reboot persistence.
- Built-in plugin uninstall.
- Reinstall over preserved config.

## Recovery

If a theme makes the UI hard to use:

```sh
rm -rf /usr/local/emhttp/plugins/unraid.theme.park
```

Refresh the WebGUI. For a persistent config reset:

```sh
rm -rf /boot/config/plugins/unraid.theme.park
```
