# Lifecycle Testing

Run this matrix on a disposable Unraid host before each beta.

## Environment

- Unraid `7.3.0`, currently validated manually.
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

## Recovery

If a theme makes the UI hard to use:

```sh
rm -rf /usr/local/emhttp/plugins/unraid.theme.park
```

Refresh the WebGUI. For a persistent config reset:

```sh
rm -rf /boot/config/plugins/unraid.theme.park
```
