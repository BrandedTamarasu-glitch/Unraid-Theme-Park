#!/usr/bin/env node
const fs = require('fs');
const path = require('path');

const root = path.resolve(__dirname, '..');
const themeDir = path.join(root, 'source/usr/local/emhttp/plugins/unraid.theme.park/themes/options');
const overrideDir = path.join(root, 'source/usr/local/emhttp/plugins/unraid.theme.park/themes/overrides');
const strict = process.argv.includes('--strict');

const checks = [
  ['text', '--text'],
  ['heading', '--text-hover'],
  ['muted', '--text-muted'],
  ['link', '--link-color'],
  ['link hover', '--link-color-hover'],
];

const backgrounds = [
  ['opaque panel', '#1f2328', 4.5, true],
  ['strong overlay on black', '#000000', 4.5, true],
  ['stock light escape', '#f5f5f5', 4.5, false],
];

function parseVars(css) {
  const vars = {};
  for (const match of css.matchAll(/(--[a-z0-9-]+)\s*:\s*([^;]+);/gi)) {
    vars[match[1]] = match[2].trim();
  }
  return vars;
}

function expandShortHex(value) {
  return value.replace(/^#([0-9a-f])([0-9a-f])([0-9a-f])$/i, '#$1$1$2$2$3$3');
}

function rgbFromColor(value) {
  const hex = expandShortHex(value.trim()).match(/^#([0-9a-f]{6})$/i);
  if (hex) {
    const n = Number.parseInt(hex[1], 16);
    return [(n >> 16) & 255, (n >> 8) & 255, n & 255];
  }

  const rgb = value.match(/^rgba?\(\s*([0-9.]+)\s*,\s*([0-9.]+)\s*,\s*([0-9.]+)/i);
  if (rgb) {
    return rgb.slice(1, 4).map((n) => Number.parseFloat(n));
  }

  return null;
}

function luminance(rgb) {
  const linear = rgb.map((channel) => {
    const c = channel / 255;
    return c <= 0.03928 ? c / 12.92 : ((c + 0.055) / 1.055) ** 2.4;
  });
  return 0.2126 * linear[0] + 0.7152 * linear[1] + 0.0722 * linear[2];
}

function contrast(a, b) {
  const l1 = luminance(a);
  const l2 = luminance(b);
  const light = Math.max(l1, l2);
  const dark = Math.min(l1, l2);
  return (light + 0.05) / (dark + 0.05);
}

function formatRatio(value) {
  return `${value.toFixed(2)}:1`;
}

const files = fs.readdirSync(themeDir).filter((file) => file.endsWith('.css')).sort();
let hasFailure = false;

for (const file of files) {
  const theme = path.basename(file, '.css');
  const vars = parseVars(fs.readFileSync(path.join(themeDir, file), 'utf8'));
  const overrideFile = path.join(overrideDir, file);
  if (fs.existsSync(overrideFile)) {
    Object.assign(vars, parseVars(fs.readFileSync(overrideFile, 'utf8')));
  }
  console.log(`\n${theme}`);

  for (const [label, variable] of checks) {
    const color = vars[variable];
    const rgb = color ? rgbFromColor(color) : null;
    if (!rgb) {
      console.log(`  ${label}: skip (${variable}=${color || 'missing'})`);
      continue;
    }

    const results = backgrounds.map(([bgLabel, bgColor, min, enforce]) => {
      const ratio = contrast(rgb, rgbFromColor(bgColor));
      const pass = ratio >= min;
      if (!pass && enforce) hasFailure = true;
      return `${bgLabel} ${formatRatio(ratio)} ${pass ? 'PASS' : 'FAIL'}`;
    });

    console.log(`  ${label} ${color}: ${results.join('; ')}`);
  }

  const buttonPairs = [
    ['button', '--button-text', '--button-color'],
    ['button hover', '--button-text-hover', '--button-color-hover'],
  ];

  for (const [label, fgVar, bgVar] of buttonPairs) {
    const fg = vars[fgVar];
    const bg = vars[bgVar];
    const fgRgb = fg ? rgbFromColor(fg) : null;
    const bgRgb = bg ? rgbFromColor(bg) : null;
    if (!fgRgb || !bgRgb) {
      console.log(`  ${label}: skip (${fgVar}=${fg || 'missing'}, ${bgVar}=${bg || 'missing'})`);
      continue;
    }

    const ratio = contrast(fgRgb, bgRgb);
    const pass = ratio >= 4.5;
    if (!pass) hasFailure = true;
    console.log(`  ${label} ${fg} on ${bg}: ${formatRatio(ratio)} ${pass ? 'PASS' : 'FAIL'}`);
  }
}

process.exit(strict && hasFailure ? 1 : 0);
