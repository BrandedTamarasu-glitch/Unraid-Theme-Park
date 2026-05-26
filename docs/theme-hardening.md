# Theme Hardening

## Compatibility Layer

All generated theme wrappers import:

```css
@import url("/plugins/unraid.theme.park/themes/compat/unraid-7.css");
```

after the Theme Park base and theme option CSS. Put Unraid-specific readability and selector drift fixes there.

## Screens To Check

- Dashboard
- Main/storage
- Settings
- Plugins
- Docker
- VMs
- Notifications
- Modal dialogs
- Dropdown menus
- Login/logout readability, if covered by the same WebGUI layout

## States To Check

- Normal text
- Links and hover states
- Inputs, selects, textareas
- Disabled controls
- Selected rows/options
- Warning/error text
- Modal confirm/cancel buttons
- Keyboard focus indicators

## Patch Rules

- Prefer targeted selectors in `themes/compat/unraid-7.css`.
- Avoid changing upstream vendored files by hand.
- Avoid adding global `!important` unless the upstream Theme Park layer already requires it.
- Re-run `scripts/sync-themepark-assets.sh` after upstream updates and confirm the compat import remains.
