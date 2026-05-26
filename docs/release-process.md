# Release Process

## Goal

Produce a GitHub release containing the package archive and a committed plugin manifest that Unraid can install by URL.

## Automated Prep

```sh
scripts/prepare-release.sh <version>
```

This command:

- updates `VERSION`
- runs scaffold checks
- builds `dist/unraid.theme.park-<version>-noarch-1.txz`
- writes `plugin/unraid.theme.park.plg` with the matching package MD5
- writes draft release notes under `dist/`

It does not publish a GitHub release.

## Manual Review Before Publishing

- Inspect `plugin/unraid.theme.park.plg` and confirm the release URL matches the tag.
- Confirm `dist/unraid.theme.park-<version>-noarch-1.txz` exists.
- Confirm the package contents install only under `/usr/local/emhttp/plugins/unraid.theme.park`.
- Confirm removal only deletes plugin-owned runtime files and staged package files.

## Required Ordering

Avoid leaving `main/plugin/unraid.theme.park.plg` pointing at a release asset that does not exist yet.

Use this order:

1. Run `scripts/prepare-release.sh <version>`.
2. Review the generated package, manifest, and release notes.
3. Commit the source changes, `VERSION`, and `plugin/unraid.theme.park.plg` locally, but do not push yet.
4. Publish the GitHub release asset.
5. Push the commit containing `plugin/unraid.theme.park.plg`.
6. Only then share the install URL.

## High-Risk Publish Step

Publishing is intentionally manual:

```sh
gh release create v<version> \
  dist/unraid.theme.park-<version>-noarch-1.txz \
  --title "Unraid Theme Park v<version>" \
  --notes-file dist/release-notes-v<version>.md \
  --prerelease
```

After publishing, install from:

```text
https://raw.githubusercontent.com/BrandedTamarasu-glitch/Unraid-Theme-Park/main/plugin/unraid.theme.park.plg
```
