#!/bin/bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
VERSION="${1:-$(tr -d '[:space:]' < "$ROOT/VERSION")}"
OLD_VERSION="$(tr -d '[:space:]' < "$ROOT/VERSION" 2>/dev/null || true)"

restore_version_on_error() {
  if [[ -n "$OLD_VERSION" ]]; then
    printf '%s\n' "$OLD_VERSION" > "$ROOT/VERSION"
  fi
}
trap restore_version_on_error ERR

if [[ ! "$VERSION" =~ ^[0-9]+\.[0-9]+\.[0-9]+(-[A-Za-z0-9.-]+)?$ ]]; then
  echo "Invalid version: $VERSION" >&2
  exit 1
fi

"$ROOT/scripts/check-scaffold.sh"
printf '%s\n' "$VERSION" > "$ROOT/VERSION"

PLG_OUT="$ROOT/plugin/unraid.theme.park.plg" "$ROOT/scripts/build-plugin.sh"
trap - ERR

PKG="$ROOT/dist/unraid.theme.park-${VERSION}-noarch-1.txz"
PLG="$ROOT/plugin/unraid.theme.park.plg"

if [[ ! -f "$PKG" || ! -f "$PLG" ]]; then
  echo "Release artifacts missing." >&2
  exit 1
fi

cat > "$ROOT/dist/release-notes-v${VERSION}.md" <<NOTES
# Unraid Theme Park v${VERSION}

## Install URL

\`\`\`text
https://raw.githubusercontent.com/BrandedTamarasu-glitch/Unraid-Theme-Park/main/plugin/unraid.theme.park.plg
\`\`\`

## Artifacts

- \`unraid.theme.park-${VERSION}-noarch-1.txz\`
- \`unraid.theme.park.plg\`

## Validation Required Before Publishing

- Install from Plugin Manager URL on Unraid 7.3.0.
- Enable each bundled theme and refresh.
- Disable theme and confirm stock styling returns.
- Reboot and confirm selected theme persists.
- Remove plugin and confirm runtime files are removed.
NOTES

cat <<SUMMARY
Prepared release v${VERSION}

Files:
- $PKG
- $PLG
- $ROOT/dist/release-notes-v${VERSION}.md

High-risk publishing step intentionally not run.
Safe release sequence:

1. Review and commit source changes, VERSION, and plugin/unraid.theme.park.plg locally.
2. Create the GitHub release asset.
3. Push the commit containing plugin/unraid.theme.park.plg only after the release asset exists.

Publish release asset manually with:

gh release create v${VERSION} "$PKG" --title "Unraid Theme Park v${VERSION}" --notes-file "$ROOT/dist/release-notes-v${VERSION}.md" --prerelease
SUMMARY
