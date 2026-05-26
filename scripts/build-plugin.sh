#!/bin/bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
VERSION="$(tr -d '[:space:]' < "$ROOT/VERSION")"
PKG_NAME="unraid.theme.park-${VERSION}-noarch-1.txz"
DIST="$ROOT/dist"
WORK="$ROOT/build"
PKGROOT="$WORK/pkgroot"
PLG_OUT="${PLG_OUT:-$DIST/unraid.theme.park.plg}"

rm -rf "$WORK" "$DIST"
mkdir -p "$PKGROOT" "$DIST" "$(dirname "$PLG_OUT")"

cp -R "$ROOT/source/." "$PKGROOT/"
chmod 0755 "$PKGROOT/usr/local/emhttp/plugins/unraid.theme.park/scripts/apply-theme"

mkdir -p "$PKGROOT/install"
cat > "$PKGROOT/install/slack-desc" <<'DESC'
unraid.theme.park: Unraid Theme Park
unraid.theme.park:
unraid.theme.park: Theme Park-style themes for Unraid 7.2+ without Theme Engine.
unraid.theme.park:
unraid.theme.park:
unraid.theme.park:
unraid.theme.park:
unraid.theme.park:
unraid.theme.park:
unraid.theme.park:
unraid.theme.park:
DESC

tar --owner=0 --group=0 -cJf "$DIST/$PKG_NAME" -C "$PKGROOT" .
MD5="$(md5sum "$DIST/$PKG_NAME" | awk '{print $1}')"
sed \
  -e "s/@VERSION@/$VERSION/g" \
  -e "s/@MD5@/$MD5/g" \
  "$ROOT/plugin/unraid.theme.park.plg.in" > "$PLG_OUT"

printf 'Built %s\n' "$DIST/$PKG_NAME"
printf 'Built %s\n' "$PLG_OUT"
