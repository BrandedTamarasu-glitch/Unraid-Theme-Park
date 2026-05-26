#!/bin/bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
UPSTREAM_REF="${1:-1.22.0}"
BASE_URL="https://raw.githubusercontent.com/themepark-dev/theme.park/${UPSTREAM_REF}/css"
THEME_DIR="$ROOT/source/usr/local/emhttp/plugins/unraid.theme.park/themes"

THEMES=(
  aquamarine:Aquamarine
  dark:Dark
  dracula:Dracula
  hotpink:Hotpink
  nord:Nord
  space-gray:Space\ Gray
)

mkdir -p "$THEME_DIR/base" "$THEME_DIR/defaults" "$THEME_DIR/options"

curl -fsSL "$BASE_URL/base/unraid/unraid-base.css" \
  | sed \
      -e 's#@import url("/css/defaults/placeholders.css");#@import url("/plugins/unraid.theme.park/themes/defaults/placeholders.css");#' \
      -e 's#@import url("/css/defaults/transparent.css");#@import url("/plugins/unraid.theme.park/themes/defaults/transparent.css");#' \
  > "$THEME_DIR/base/unraid-base.css"

curl -fsSL "$BASE_URL/defaults/placeholders.css" > "$THEME_DIR/defaults/placeholders.css"
curl -fsSL "$BASE_URL/defaults/transparent.css" > "$THEME_DIR/defaults/transparent.css"

cat > "$THEME_DIR/manifest.json" <<JSON
{
JSON

first=1
for entry in "${THEMES[@]}"; do
  id="${entry%%:*}"
  name="${entry#*:}"
  curl -fsSL "$BASE_URL/theme-options/${id}.css" > "$THEME_DIR/options/${id}.css"
  cat > "$THEME_DIR/${id}.css" <<CSS
/* Generated from Theme Park ${UPSTREAM_REF}. */
@import url("/plugins/unraid.theme.park/themes/base/unraid-base.css");
@import url("/plugins/unraid.theme.park/themes/options/${id}.css");
CSS

  if [[ "$first" -eq 0 ]]; then
    printf ',\n' >> "$THEME_DIR/manifest.json"
  fi
  first=0
  cat >> "$THEME_DIR/manifest.json" <<JSON
  "${id}": {
    "name": "${name}",
    "file": "${id}.css",
    "source": "themepark-dev/theme.park@${UPSTREAM_REF}"
  }
JSON
done

cat >> "$THEME_DIR/manifest.json" <<JSON
}
JSON

printf 'Synced %s themes from Theme Park %s\n' "${#THEMES[@]}" "$UPSTREAM_REF"
