#!/usr/bin/node
// Deletes from the area relay's database what a moderator removed.
//
// push/ writes banned-area.json on a "ban" decision about an area report
// (createAreaBans in push/src/index.js); cubechat-area-purge.path notices the
// file change and runs this as the relay's own user, which owns the LMDB —
// push/ never touches the relay's files. The relay holds the only copy of a
// public message, so deleting it here is the main remedy; the app's
// `/banned/area` check only covers what a phone already received.
//
// One `strfry delete` for the listed ids and one for the listed keys. Ids and
// keys are checked as 64 hex before they reach a command line.

import { execFileSync } from 'node:child_process';
import { readFileSync } from 'node:fs';
import { pathToFileURL } from 'node:url';

const HEX64 = /^[0-9a-f]{64}$/;

/// The `strfry delete` filters for a ban file's contents.
export function purgeFilters(raw) {
  const ids = (raw?.events ?? []).map((e) => e?.id).filter((v) => HEX64.test(v ?? ''));
  const authors = (raw?.keys ?? []).map((k) => k?.key).filter((v) => HEX64.test(v ?? ''));
  return [
    ...(ids.length ? [{ ids }] : []),
    ...(authors.length ? [{ authors }] : []),
  ];
}

function main() {
  const path = process.env.AREA_BANNED_PATH || '/opt/cubechat-push/banned-area.json';
  const config = process.env.AREA_STRFRY_CONFIG || '/opt/cubechat-area-relay/strfry.conf';
  let raw;
  try {
    raw = JSON.parse(readFileSync(path, 'utf8'));
  } catch (error) {
    if (error.code === 'ENOENT') return;
    throw error;
  }
  for (const filter of purgeFilters(raw)) {
    execFileSync('/usr/local/bin/strfry', [`--config=${config}`, 'delete', `--filter=${JSON.stringify(filter)}`], {
      stdio: 'inherit',
    });
  }
}

if (process.argv[1] && import.meta.url === pathToFileURL(process.argv[1]).href) main();
