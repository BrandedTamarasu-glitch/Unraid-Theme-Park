# ADR 0001: CSS Injection Path

## Status

Accepted for MVP, validated manually on Unraid `7.3.0`.

## Context

Unraid 7.2 removed Theme Engine compatibility, so this project needs its own stylesheet delivery path. The path must be local, reversible, and compatible with the responsive WebGUI introduced in Unraid 7.2.

The current Unraid WebGUI layout loads page stylesheets through `includePageStylesheets($page)` in `DefaultPageLayout.php`. That helper includes `/plugins/<plugin>/sheets/<PageName>.css` for discovered pages. `DefaultPageLayout.php` calls this helper for all pages found under `Menu=Buttons`, not only the currently visible page.

`Navigation/Main.php` renders normal button pages as navigation utilities when `Link` is empty. When `Link` is set, it renders a placeholder `<div class="<Link>"></div>` instead of a clickable nav button.

This gives us a plugin-owned global stylesheet path:

1. Add a helper page under this plugin with `Menu='Buttons'`.
2. Set `Link='unraid-theme-park-hook'` so no visible button is added.
3. Add `sheets/ThemeParkGlobal.css`.
4. Let Unraid include that stylesheet on every normal WebGUI page.

## Decision

Use a hidden `Buttons` helper page as the Phase 0 injection candidate.

The helper page should include no JavaScript and no user-facing behavior. It exists only to make Unraid include the plugin stylesheet through the same page stylesheet mechanism used by native/plugin pages.

The global stylesheet should be stable and small. Runtime theme switching should happen by updating a plugin-owned `current.css` or generated import file, not by editing Unraid core files or injecting DOM nodes.

## Alternatives Considered

### Patch `DefaultPageLayout.php`

Rejected for MVP. It would be powerful, but it mutates core WebGUI files and increases the chance of upgrade breakage or an unrecoverable UI error.

### JavaScript DOM Injection

Rejected for MVP. It is more brittle across the responsive WebGUI and can flash unstyled content or fail under stricter browser/content-security behavior.

### Reverse Proxy or Browser Extension Injection

Rejected. It does not provide a normal Unraid plugin experience and does not help Community Applications distribution.

### Theme Engine Compatibility Layer

Rejected. Theme Engine is explicitly incompatible on Unraid 7.2+.

## Consequences

Positive:

- No core file patching.
- No Theme Engine dependency.
- Uses an existing WebGUI stylesheet include path.
- Easy to disable by removing or emptying the plugin stylesheet.
- Easy to uninstall by removing plugin-owned files.

Negative:

- It relies on `Menu=Buttons` behavior remaining stable.
- It must be tested on top-nav and sidebar themes.
- The stylesheet does not automatically cover standalone/login pages unless those pages use the same layout path.
- If the helper page metadata changes or `Link` behavior changes, the injection path may need a replacement.

## Validation Required

- Confirm the stylesheet link appears in `<head>` on dashboard, main/storage, settings, plugin manager, and docker/vm pages.
- Confirm the placeholder `Link` does not create visible UI noise in top-nav or sidebar modes.
- Confirm enable, disable, and uninstall can remove all runtime effects.
- Confirm login/logout pages either receive the stylesheet or are explicitly documented as out of scope for the first prototype.
- Confirm behavior on Unraid 7.2.0 and latest 7.2.x.

## Validation Results

- `2026-05-26`: Manual prototype copied to `/usr/local/emhttp/plugins/unraid.theme.park` on Unraid `7.3.0`.
- Result: `ThemeParkGlobal.css` loaded and displayed the fixed `Unraid Theme Park Phase 0` marker in the WebGUI.
- Conclusion: the hidden `Buttons` helper page is viable as the MVP stylesheet injection path on Unraid `7.3.0`.
- `2026-05-26`: Phase 1 scaffold validated manually on Unraid `7.3.0`.
- Result: top-level Settings category plus `Theme Settings` child page rendered, saved config, regenerated active CSS, and displayed the `Unraid Theme Park Phase 1` marker through the global hook.

## Sources

- Unraid WebGUI `DefaultPageLayout.php`
- Unraid WebGUI `PageBuilder.php`
- Unraid WebGUI `Navigation/Main.php`
- Unraid responsive WebGUI plugin migration guide
- Unraid 7.2.0, 7.2.7, and 7.3.0 release notes
