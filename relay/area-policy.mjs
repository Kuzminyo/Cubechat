#!/usr/bin/node
// strfry write policy for the area chat's relay (/area): the public district,
// city and region chats and the notes on the map. A process and an LMDB of its
// own, like /media — see relay/README.md, "The area relay" — so a flood here
// cannot take the private lane down.
//
// Spec: docs/superpowers/specs/2026-11-02-area-chat-design.md, «Лимиты на
// релее». What it holds every event to, cheapest first:
//
//   1. Kind: 1060 message, 1062 note, 21060 presence, 5 deletion. strfry only
//      ever applies a deletion to events of the same key, so nobody deletes
//      somebody else's message with it.
//   2. At most 4 KiB.
//   3. Proof of work (NIP-13) per kind: leading zero bits of the id. strfry
//      checks the id and the signature itself; this only counts zeros.
//   4. Shape: exactly one `g` of 3–4 geohash characters — the relay never
//      indexes anything finer than a city. A `cell` in the content, if any,
//      is 5 characters inside that `g`, and only on 1060 and 1062. 1060 and
//      1062 carry an `expiration` (NIP-40) no further off than their kind's
//      limit; 21060 carries none.
//   5. Per source address, in memory only: 30 messages a minute, 5 notes an
//      hour, 4 presences a minute — with room for a carrier's NAT. Nothing
//      here is written down, and no address is kept beside any event: the
//      privacy policy promises that, and it is why there is no ban by address.
//   6. Keys a moderator removed (banned-area.json, written by push/ on a
//      "ban" decision) are refused.
//
// Events strfry replays itself (import, sync, stream) are trusted.

import { readFileSync, statSync } from 'node:fs';
import { createInterface } from 'node:readline';
import { pathToFileURL } from 'node:url';

export const KINDS = { message: 1060, note: 1062, presence: 21060, deletion: 5 };

const POW_BITS = { [KINDS.message]: 12, [KINDS.note]: 16, [KINDS.presence]: 8 };

// Seconds an expiration may be past created_at.
const MAX_LIFETIME = { [KINDS.message]: 24 * 3600, [KINDS.note]: 7 * 24 * 3600 };

const GEOHASH = /^[0-9b-hjkmnp-z]+$/;

export const defaults = {
  maxBytes: Number(process.env.AREA_MAX_BYTES || 4096),
  messagesPerMinute: Number(process.env.AREA_MESSAGES_PER_IP_MINUTE || 30),
  notesPerHour: Number(process.env.AREA_NOTES_PER_IP_HOUR || 5),
  presencePerMinute: Number(process.env.AREA_PRESENCE_PER_IP_MINUTE || 4),
  deletionsPerHour: Number(process.env.AREA_DELETIONS_PER_IP_HOUR || 30),
};

const MINUTE_MS = 60_000;
const HOUR_MS = 3_600_000;

/// Leading zero bits of a hex id — NIP-13's difficulty.
export function difficulty(idHex) {
  let bits = 0;
  for (const ch of idHex) {
    const v = parseInt(ch, 16);
    if (Number.isNaN(v)) return 0;
    if (v === 0) {
      bits += 4;
      continue;
    }
    return bits + Math.clz32(v) - 28;
  }
  return bits;
}

/// What is wrong with the event's shape, or null.
export function shapeProblem(event, nowSeconds) {
  const tags = Array.isArray(event.tags) ? event.tags : [];
  const gs = tags.filter((t) => Array.isArray(t) && t[0] === 'g');
  if (event.kind === KINDS.deletion) {
    if (gs.length > 0) return 'a deletion names no place';
    if (!tags.some((t) => Array.isArray(t) && t[0] === 'e')) return 'a deletion names an event';
    return null;
  }
  if (gs.length !== 1 || typeof gs[0][1] !== 'string') return 'exactly one g';
  const g = gs[0][1];
  if (g.length < 3 || g.length > 4 || !GEOHASH.test(g)) return 'g is a city or a region';

  const expirations = tags.filter((t) => Array.isArray(t) && t[0] === 'expiration');
  if (event.kind === KINDS.presence) {
    if (expirations.length > 0) return 'presence has no expiration';
    if (event.content !== '') return 'presence has no content';
    return null;
  }
  if (expirations.length !== 1) return 'expiration is required';
  const expiration = Number(expirations[0][1]);
  if (!Number.isSafeInteger(expiration) || expiration <= nowSeconds ||
      expiration > event.created_at + MAX_LIFETIME[event.kind]) {
    return 'expiration out of range';
  }
  let content;
  try {
    content = JSON.parse(event.content);
  } catch {
    return 'content is not JSON';
  }
  if (!content || typeof content !== 'object' || Array.isArray(content) || content.v !== 1 ||
      typeof content.text !== 'string') {
    return 'content off the schema';
  }
  if (content.cell !== undefined) {
    if (typeof content.cell !== 'string' || content.cell.length !== 5 ||
        !GEOHASH.test(content.cell) || !content.cell.startsWith(g)) {
      return 'cell is a district inside g';
    }
  }
  return null;
}

/// A rolling counter per (address, kind group), reset on its window.
function count(state, key, now, windowMs, limit) {
  let entry = state.get(key);
  if (!entry || now - entry.at >= windowMs) {
    entry = { at: now, n: 0 };
    state.set(key, entry);
  }
  if (entry.n + 1 > limit) return false;
  entry.n += 1;
  return true;
}

/// Decides one request. Pure apart from `state` (the counters) — so the test
/// can drive it.
export function decide(request, state, { now, banned = new Set(), limits = defaults }) {
  const event = request?.event;
  const id = typeof event?.id === 'string' ? event.id : '';
  const answer = (action, msg) => (msg ? { id, action, msg } : { id, action });

  if (request?.type !== 'new' || !event) return answer('reject', 'invalid: not a new event');
  if (request.sourceType !== 'IP4' && request.sourceType !== 'IP6') return answer('accept');

  if (!Object.values(KINDS).includes(event.kind)) {
    return answer('reject', 'blocked: this relay only carries the cubechat area chat');
  }
  if (Buffer.byteLength(JSON.stringify(event)) > limits.maxBytes) {
    return answer('reject', 'invalid: event too large');
  }
  const bits = POW_BITS[event.kind] ?? 0;
  if (bits > 0 && difficulty(id) < bits) {
    return answer('reject', `pow: difficulty ${bits} required`);
  }
  const nowSeconds = Math.floor(now / 1000);
  const problem = shapeProblem(event, nowSeconds);
  if (problem) return answer('reject', `invalid: ${problem}`);
  if (banned.has(event.pubkey)) return answer('reject', 'blocked: removed by a moderator');

  const ip = String(request.sourceInfo || 'unknown');
  const ok = {
    [KINDS.message]: () => count(state, `m:${ip}`, now, MINUTE_MS, limits.messagesPerMinute),
    [KINDS.note]: () => count(state, `n:${ip}`, now, HOUR_MS, limits.notesPerHour),
    [KINDS.presence]: () => count(state, `p:${ip}`, now, MINUTE_MS, limits.presencePerMinute),
    [KINDS.deletion]: () => count(state, `d:${ip}`, now, HOUR_MS, limits.deletionsPerHour),
  }[event.kind]();
  if (!ok) return answer('reject', 'rate-limited: slow down');

  // Bounded, because this runs as long as strfry does.
  if (state.size > 100_000) {
    for (const [key, value] of state) {
      if (now - value.at >= HOUR_MS) state.delete(key);
    }
  }
  return answer('accept');
}

/// The keys a moderator removed, from the file push/ writes. Read again when
/// the file changes, checked at most every 30 s.
function bannedKeys(path) {
  let keys = new Set();
  let mtime = 0;
  let checkedAt = 0;
  return (now) => {
    if (now - checkedAt < 30_000) return keys;
    checkedAt = now;
    try {
      const stat = statSync(path);
      if (stat.mtimeMs !== mtime) {
        mtime = stat.mtimeMs;
        const raw = JSON.parse(readFileSync(path, 'utf8'));
        keys = new Set((raw.keys ?? []).map((k) => (typeof k === 'string' ? k : k?.key)).filter(Boolean));
      }
    } catch {
      // No file yet is nobody banned yet.
    }
    return keys;
  };
}

function main() {
  const state = new Map();
  const banned = bannedKeys(process.env.AREA_BANNED_PATH || '/opt/cubechat-push/banned-area.json');
  const lines = createInterface({ input: process.stdin, terminal: false });
  lines.on('line', (line) => {
    let request;
    try {
      request = JSON.parse(line);
    } catch {
      return;
    }
    const now = Date.now();
    process.stdout.write(`${JSON.stringify(decide(request, state, { now, banned: banned(now) }))}\n`);
  });
}

if (process.argv[1] && import.meta.url === pathToFileURL(process.argv[1]).href) main();
