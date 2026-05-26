# Theme Readability Audit

## Finding

The bundled Theme Park palettes are dark-surface themes. Their normal foreground colors are intentionally light and meet WCAG AA contrast on dark or opaque panels.

They fail when Unraid 7 dashboard widgets keep stock light backgrounds under the Theme Park foreground colors.

## Evidence

Theme wrappers import the Theme Park base CSS, a Theme Park option file, and then the local Unraid 7 compatibility layer:

```css
@import url("/plugins/unraid.theme.park/themes/base/unraid-base.css");
@import url("/plugins/unraid.theme.park/themes/options/<theme>.css");
@import url("/plugins/unraid.theme.park/themes/overrides/<theme>.css");
@import url("/plugins/unraid.theme.park/themes/compat/unraid-7.css");
```

The theme option files are vendored from Theme Park `1.22.0` by `scripts/sync-themepark-assets.sh`. The local project changes import paths and adds local override layers; it does not rewrite upstream theme option files.

Representative contrast results from `scripts/audit-theme-contrast.js`:

| Theme | Text color | Opaque dark panel | Stock light escape |
| --- | --- | ---: | ---: |
| Aquamarine | `#ddd` | `11.63:1` pass | `1.25:1` fail |
| Dark | `#ddd` | `11.63:1` pass | `1.25:1` fail |
| Dracula | `#f8f8f2` | `14.82:1` pass | `1.02:1` fail |
| Hotpink | `#eee` | `13.62:1` pass | `1.06:1` fail |
| Nord | `#D8DEE9` | `11.69:1` pass | `1.24:1` fail |
| Space Gray | `#bbb` | `8.23:1` pass | `1.76:1` fail |

## Decision

Fix readability in `themes/compat/unraid-7.css` by making Unraid 7 dashboard, table, and panel surfaces reliably dark before applying the original Theme Park foreground palette.

Do not make each theme's primary text dark. That would diverge from the upstream Theme Park visual intent and would fail on the dark surfaces that the themes expect.

Use `themes/overrides/<theme>.css` for targeted palette fixes when an upstream accent color fails contrast on the dark surfaces the theme expects. Current targeted overrides:

- Dark: brighter link color.
- Dracula: brighter muted text.
- Nord: darker hover button text.

## Validation

For each theme, validate Dashboard, Main, Shares, Docker, Plugins, and Settings.

Minimum acceptance:

- No light text on light panel backgrounds.
- Table row text remains readable.
- Header and title text remains distinct from normal text.
- Links remain recognizable.
- Semantic status colors remain recognizable.
