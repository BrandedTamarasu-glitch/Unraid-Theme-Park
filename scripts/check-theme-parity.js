#!/usr/bin/env node
const fs = require('fs');
const path = require('path');

const root = path.resolve(__dirname, '..');
const manifestPath = path.join(root, 'source/usr/local/emhttp/plugins/unraid.theme.park/themes/manifest.json');

const officialThemes = [
  ['aquamarine', 'Aquamarine'],
  ['hotline', 'Hotline'],
  ['hotpink', 'Hotpink'],
  ['dracula', 'Dracula'],
  ['dark', 'Dark'],
  ['organizr', 'Organizr'],
  ['space-gray', 'Space Gray'],
  ['overseerr', 'Overseerr'],
  ['plex', 'Plex'],
  ['nord', 'Nord'],
  ['maroon', 'Maroon'],
];

const deferred = new Set(['plex']);
const manifest = JSON.parse(fs.readFileSync(manifestPath, 'utf8'));
const supported = new Set(Object.keys(manifest));
const missing = officialThemes.filter(([id]) => !supported.has(id) && !deferred.has(id));
const deferredMissing = officialThemes.filter(([id]) => !supported.has(id) && deferred.has(id));

console.log('Theme Park official theme parity');
console.log(`Supported: ${officialThemes.filter(([id]) => supported.has(id)).map(([, name]) => name).join(', ')}`);
console.log(`Missing: ${missing.map(([, name]) => name).join(', ') || 'none'}`);
console.log(`Deferred: ${deferredMissing.map(([, name]) => name).join(', ') || 'none'}`);

process.exit(missing.length ? 1 : 0);
