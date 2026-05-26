# Community Beta Plan

## Beta Scope

The beta targets Unraid `7.2+`. Manual validation is confirmed on Unraid `7.3.0` with `v0.1.2`, which is the current community test baseline. Latest `7.2.x` validation is still required before a wider Community Applications release.

Supported in beta:

- Aquamarine
- Crema
- Dark
- Dracula
- Hotline
- Hotpink
- Maroon
- Meridian
- Meridian Light
- Nord
- Organizr
- Overseerr
- Ristretto
- Space Gray

Deferred:

- Plex theme, pending local asset packaging for `/resources/...` references.
- Theme Engine migration.
- Custom CSS editor.
- Community theme imports.

## Tester Instructions

Ask testers to include:

- Unraid version.
- Browser.
- Theme selected.
- Navigation layout: top nav or sidebar.
- Screenshot of Dashboard, Main, Settings, and any unreadable page.
- Whether Community Applications and Unassigned Devices remain readable.
- Whether disable and uninstall restored stock styling.

## Release Criteria

- At least one successful install-from-URL report on Unraid `7.3.x`. Confirmed on Unraid `7.3.0` with `v0.1.2`.
- At least one successful install-from-URL report on latest `7.2.x`.
- No confirmed blocker for disabling or uninstalling.
- No supported theme makes primary navigation unreadable.
- Community Applications and Unassigned Devices readability checks pass for the selected theme.
