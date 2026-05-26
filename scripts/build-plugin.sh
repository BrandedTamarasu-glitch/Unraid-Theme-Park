#!/bin/bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
VERSION="$(tr -d '[:space:]' < "$ROOT/VERSION")"
PKG_NAME="unraid.theme.park-${VERSION}-noarch-1.txz"
DIST="$ROOT/dist"
WORK="$ROOT/build"
PKGROOT="$WORK/pkgroot"

rm -rf "$WORK" "$DIST"
mkdir -p "$PKGROOT" "$DIST"

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
  "$ROOT/plugin/unraid.theme.park.plg.in" > "$DIST/unraid.theme.park.plg"

printf 'Built %s\n' "$DIST/$PKG_NAME"
printf 'Built %s\n' "$DIST/unraid.theme.park.plg"
