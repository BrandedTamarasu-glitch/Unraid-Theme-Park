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
  hotline:Hotline
  hotpink:Hotpink
  maroon:Maroon
  nord:Nord
  organizr:Organizr
  overseerr:Overseerr
  space-gray:Space\ Gray
)

LOCAL_THEMES=(
  crema:Crema:BrandedTamarasu-glitch/Ground_Control@da92af7749e7dd18cf42a6b115d56b22201324d3
  meridian:Meridian:BrandedTamarasu-glitch/unraid-meridian@9a3f3fb5a923e570d8a2076fb3070cad05eb20e2
  meridian-light:Meridian\ Light:BrandedTamarasu-glitch/unraid-meridian@9a3f3fb5a923e570d8a2076fb3070cad05eb20e2
  ristretto:Ristretto:BrandedTamarasu-glitch/Ground_Control@da92af7749e7dd18cf42a6b115d56b22201324d3
)

mkdir -p "$THEME_DIR/base" "$THEME_DIR/defaults" "$THEME_DIR/options" "$THEME_DIR/overrides" "$THEME_DIR/compat" "$THEME_DIR/local"

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
@import url("/plugins/unraid.theme.park/themes/overrides/${id}.css");
@import url("/plugins/unraid.theme.park/themes/compat/unraid-7.css");
CSS
  if [[ ! -f "$THEME_DIR/overrides/${id}.css" ]]; then
    printf '/* Local per-theme readability overrides. */\n' > "$THEME_DIR/overrides/${id}.css"
  fi

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

for entry in "${LOCAL_THEMES[@]}"; do
  id="${entry%%:*}"
  rest="${entry#*:}"
  name="${rest%%:*}"
  source="${rest#*:}"
  if [[ ! -f "$THEME_DIR/local/${id}.css" ]]; then
    echo "Skipping local theme ${id}: $THEME_DIR/local/${id}.css not found" >&2
    continue
  fi
  cat > "$THEME_DIR/${id}.css" <<CSS
/* Generated local wrapper for ${name}. */
@import url("/plugins/unraid.theme.park/themes/local/${id}.css");
@import url("/plugins/unraid.theme.park/themes/compat/local-unraid-7.css");
CSS

  if [[ "$first" -eq 0 ]]; then
    printf ',\n' >> "$THEME_DIR/manifest.json"
  fi
  first=0
  cat >> "$THEME_DIR/manifest.json" <<JSON
  "${id}": {
    "name": "${name}",
    "file": "${id}.css",
    "source": "${source}"
  }
JSON
done

cat >> "$THEME_DIR/manifest.json" <<JSON
}
JSON

printf 'Synced %s themes from Theme Park %s\n' "${#THEMES[@]}" "$UPSTREAM_REF"
