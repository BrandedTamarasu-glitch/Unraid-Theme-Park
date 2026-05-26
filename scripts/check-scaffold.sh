#!/bin/bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

test -f "$ROOT/source/usr/local/emhttp/plugins/unraid.theme.park/ThemeParkGlobal.page"
test -f "$ROOT/source/usr/local/emhttp/plugins/unraid.theme.park/UnraidThemePark.page"
test -f "$ROOT/source/usr/local/emhttp/plugins/unraid.theme.park/ThemeParkSettings.page"
test -f "$ROOT/source/usr/local/emhttp/plugins/unraid.theme.park/include/ThemePark.php"
test -f "$ROOT/source/usr/local/emhttp/plugins/unraid.theme.park/include/Apply.php"
test -f "$ROOT/source/usr/local/emhttp/plugins/unraid.theme.park/themes/manifest.json"
test -f "$ROOT/source/usr/local/emhttp/plugins/unraid.theme.park/themes/compat/unraid-7.css"
grep -q 'compat/unraid-7.css' "$ROOT"/source/usr/local/emhttp/plugins/unraid.theme.park/themes/*.css
! grep -R -E 'theme-park.dev|raw.githubusercontent|/css/|/resources/' "$ROOT/source/usr/local/emhttp/plugins/unraid.theme.park/themes"

if command -v php >/dev/null 2>&1; then
  php -l "$ROOT/source/usr/local/emhttp/plugins/unraid.theme.park/include/ThemePark.php"
  php -l "$ROOT/source/usr/local/emhttp/plugins/unraid.theme.park/include/Apply.php"
  php -r 'json_decode(file_get_contents($argv[1]), true); exit(json_last_error() === JSON_ERROR_NONE ? 0 : 1);' "$ROOT/source/usr/local/emhttp/plugins/unraid.theme.park/themes/manifest.json"
else
  echo "Skipping PHP lint: php not found on PATH."
fi

echo "Scaffold checks passed."
