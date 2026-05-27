# Reporting Issues

Unraid Theme Park is in community testing. Reports are most useful when they
include enough detail to reproduce the exact page and theme combination.

## Visual Bugs

Use the **Theme readability report** issue template for:

- unreadable text
- white or light boxes
- low contrast controls
- page areas that keep stock Unraid styling
- third-party plugin pages that do not match the selected theme

Include:

- Unraid version
- Unraid Theme Park version
- selected theme
- browser
- navigation layout: top navigation or sidebar
- affected page or plugin
- screenshot
- whether a hard refresh changed anything

## Install Or Update Bugs

Use the **Install or update problem** issue template for:

- install failures
- update failures
- missing Settings page
- theme not applying
- theme not persisting after reboot
- uninstall or reinstall problems

Useful command output:

```sh
cat /etc/unraid-version
grep -E 'version|release/download|upgradepkg' /boot/config/plugins/unraid.theme.park.plg 2>/dev/null
cat /boot/config/plugins/unraid.theme.park/unraid.theme.park.cfg 2>/dev/null
cat /usr/local/emhttp/plugins/unraid.theme.park/generated/current.css 2>/dev/null
```

## Before Filing

After changing themes or updating the plugin, hard-refresh the browser:

- Windows/Linux: `Ctrl+F5`
- macOS: `Cmd+Shift+R`

If the issue remains, open an issue and attach the screenshot.
