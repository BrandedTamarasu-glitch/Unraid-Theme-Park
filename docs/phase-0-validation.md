# Phase 0 Validation Plan

## Goal

Prove that Unraid Theme Park can add and remove one global stylesheet on Unraid 7.2+ and 7.3+ without Theme Engine, core file patching, or JavaScript DOM injection.

## Prototype Files

The prototype source lives under:

- `prototype/source/usr/local/emhttp/plugins/unraid.theme.park/ThemeParkGlobal.page`
- `prototype/source/usr/local/emhttp/plugins/unraid.theme.park/sheets/ThemeParkGlobal.css`

These are not a complete plugin package yet. They are the smallest files needed to validate the injection contract on a disposable Unraid instance.

## Test Matrix

- Unraid 7.2.0
- Latest available Unraid 7.2.x
- Latest stable Unraid 7.3.x
- Chromium-based browser
- Firefox
- Top navigation theme
- Sidebar theme
- Desktop, tablet, and mobile viewport widths

## Manual Install For Spike

On a disposable Unraid test instance:

```sh
mkdir -p /usr/local/emhttp/plugins/unraid.theme.park/sheets
cp prototype/source/usr/local/emhttp/plugins/unraid.theme.park/ThemeParkGlobal.page /usr/local/emhttp/plugins/unraid.theme.park/ThemeParkGlobal.page
cp prototype/source/usr/local/emhttp/plugins/unraid.theme.park/sheets/ThemeParkGlobal.css /usr/local/emhttp/plugins/unraid.theme.park/sheets/ThemeParkGlobal.css
```

Then reload the WebGUI.

## Expected Result

Every normal WebGUI page should include:

```html
<link type="text/css" rel="stylesheet" href="/plugins/unraid.theme.park/sheets/ThemeParkGlobal.css?...">
```

The prototype stylesheet adds a small fixed marker through CSS only. It must not add a visible navigation button.

## Manual Cleanup

```sh
rm -f /usr/local/emhttp/plugins/unraid.theme.park/ThemeParkGlobal.page
rm -f /usr/local/emhttp/plugins/unraid.theme.park/sheets/ThemeParkGlobal.css
```

Then reload the WebGUI.

## Pages To Check

- Dashboard
- Main/storage
- Settings
- Plugins
- Docker
- VMs
- Notifications
- Modal dialog
- Login/logout path, if it uses the same page layout

## Pass Criteria

- Stylesheet is present on normal WebGUI pages. Passed on Unraid `7.3.0`.
- No visible navigation item is added by the helper page.
- CSS loads after stock theme CSS.
- Removing `ThemeParkGlobal.page` or `ThemeParkGlobal.css` restores stock UI after refresh.
- No JavaScript console errors are introduced by the prototype.
- No layout breakage appears at mobile, tablet, or desktop widths.

## Fail Criteria

- The helper page creates visible UI or spacing artifacts.
- The stylesheet is not included on key WebGUI pages.
- The stylesheet loads before stock theme CSS and cannot reliably override it.
- Removing the files leaves stale UI effects.
- The path works on 7.2.x but fails on 7.3.x.

## Next Decision

This passed on Unraid `7.3.0`; build Phase 1 around the hidden `Buttons` helper page and a generated active-theme stylesheet.

If later `7.2.x` validation fails, test the fallback paths in this order:

1. A documented Unraid global include hook, if one exists in the target version.
2. A minimal, checksum-guarded `DefaultPageLayout.php` patch with automatic rollback.
3. JavaScript DOM injection only as a last resort.
