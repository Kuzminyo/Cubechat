import assert from 'node:assert/strict';
import { spawn } from 'node:child_process';
import { once } from 'node:events';
import { fileURLToPath } from 'node:url';
import test from 'node:test';
import { decide, difficulty, KINDS } from './area-policy.mjs';
import { purgeFilters } from './area-purge.mjs';

test('the purge deletes listed ids and keys, and nothing that is not 64 hex', () => {
  assert.deepEqual(purgeFilters({
    events: [{ id: 'a'.repeat(64), at: 1 }, { id: '"; rm -rf /', at: 1 }],
    keys: [{ key: 'b'.repeat(64), at: 1 }],
  }), [{ ids: ['a'.repeat(64)] }, { authors: ['b'.repeat(64)] }]);
  assert.deepEqual(purgeFilters({}), []);
});

const NOW = 1_800_000_000_000;
const nowS = NOW / 1000;
const limits = { maxBytes: 4096, messagesPerMinute: 3, notesPerHour: 2, presencePerMinute: 2, deletionsPerHour: 5 };

// An id with exactly `zeros` leading zero hex digits (4 bits each), unique by n.
const idWith = (zeros, n = 0) => '0'.repeat(zeros) + 'f' + n.toString(16).padStart(63 - zeros, '1');

const message = (overrides = {}) => ({
  id: idWith(3),
  pubkey: 'a'.repeat(64),
  kind: KINDS.message,
  created_at: nowS,
  tags: [['g', 'u8vx'], ['expiration', `${nowS + 3600}`], ['nonce', '1', '12']],
  content: '{"v":1,"text":"hi","cell":"u8vxn"}',
  ...overrides,
});
const req = (event, ip = '203.0.113.1', sourceType = 'IP4') =>
  ({ type: 'new', event, receivedAt: 0, sourceType, sourceInfo: ip });
const run = (event, state = new Map(), { at = NOW, banned, ip } = {}) =>
  decide(req(event, ip), state, { now: at, banned, limits });

test('difficulty counts leading zero bits', () => {
  assert.equal(difficulty('f'), 0);
  assert.equal(difficulty('0f'), 4);
  assert.equal(difficulty('001'), 11);
  assert.equal(difficulty('0008'), 12);
});

test('only the area kinds pass', () => {
  assert.equal(run(message()).action, 'accept');
  for (const kind of [1, 1059, 20000, 23517]) {
    assert.equal(run(message({ kind })).action, 'reject', `${kind}`);
  }
});

test('proof of work per kind', () => {
  assert.equal(run(message({ id: idWith(2) })).action, 'reject');
  assert.match(run(message({ id: idWith(2) })).msg, /pow/);
  const note = message({ kind: KINDS.note, id: idWith(3) });
  assert.equal(run(note).action, 'reject', 'a note needs 16 bits');
  assert.equal(run({ ...note, id: idWith(4) }).action, 'accept');
  const presence = message({
    kind: KINDS.presence, id: idWith(2), tags: [['g', 'u8vx'], ['nonce', '1', '8']], content: '',
  });
  assert.equal(run(presence).action, 'accept');
});

test('g is a city or a region, never finer', () => {
  for (const g of ['u8vxn', 'u8', 'u8vA', 'ilo']) {
    const e = message({ tags: [['g', g], ['expiration', `${nowS + 3600}`]] });
    assert.equal(run(e).action, 'reject', g);
  }
  const twoG = message({ tags: [['g', 'u8vx'], ['g', 'u8v'], ['expiration', `${nowS + 3600}`]] });
  assert.equal(run(twoG).action, 'reject');
  const region = message({ tags: [['g', 'u8v'], ['expiration', `${nowS + 3600}`]], content: '{"v":1,"text":"x"}' });
  assert.equal(run(region).action, 'accept');
});

test('a cell is a district inside g, and only on messages and notes', () => {
  for (const cell of ['u9bbb', 'u8vx', 'u8vxnn']) {
    assert.equal(run(message({ content: `{"v":1,"text":"x","cell":"${cell}"}` })).action, 'reject', cell);
  }
  const presence = message({
    kind: KINDS.presence, tags: [['g', 'u8vx']], content: '{"v":1,"text":"x","cell":"u8vxn"}',
  });
  assert.equal(run(presence).action, 'reject');
});

test('expiration is required and bounded by the kind', () => {
  assert.equal(run(message({ tags: [['g', 'u8vx']] })).action, 'reject');
  assert.equal(run(message({ tags: [['g', 'u8vx'], ['expiration', `${nowS + 2 * 86400}`]] })).action, 'reject');
  assert.equal(run(message({ tags: [['g', 'u8vx'], ['expiration', `${nowS - 1}`]] })).action, 'reject');
  const note = message({
    kind: KINDS.note, id: idWith(4), tags: [['g', 'u8vx'], ['expiration', `${nowS + 7 * 86400}`]],
  });
  assert.equal(run(note).action, 'accept');
  assert.equal(run({ ...note, tags: [['g', 'u8vx'], ['expiration', `${nowS + 8 * 86400}`]] }).action, 'reject');
});

test('an event over 4 KiB is refused', () => {
  const big = message({ content: `{"v":1,"text":"${'x'.repeat(5000)}"}` });
  assert.match(run(big).msg, /too large/);
});

test('a deletion names an event and no place', () => {
  const del = { id: 'f'.repeat(64), pubkey: 'a'.repeat(64), kind: 5, created_at: nowS, tags: [['e', 'b'.repeat(64)]], content: '' };
  assert.equal(run(del).action, 'accept');
  assert.equal(run({ ...del, tags: [['e', 'b'.repeat(64)], ['g', 'u8vx']] }).action, 'reject');
});

test('per address: messages a minute, notes an hour, presences a minute', () => {
  const state = new Map();
  for (let i = 0; i < 3; i++) assert.equal(run(message({ id: idWith(3, i) }), state).action, 'accept');
  assert.match(run(message({ id: idWith(3, 9) }), state).msg, /rate/);
  assert.equal(run(message({ id: idWith(3, 10) }), state, { ip: '198.51.100.7' }).action, 'accept');
  assert.equal(run(message({ id: idWith(3, 11) }), state, { at: NOW + 60_000 }).action, 'accept');

  const note = (n) => message({ kind: KINDS.note, id: idWith(4, n) });
  assert.equal(run(note(1), state).action, 'accept');
  assert.equal(run(note(2), state).action, 'accept');
  assert.equal(run(note(3), state).action, 'reject');
});

test('a key removed by a moderator is refused', () => {
  const banned = new Set(['a'.repeat(64)]);
  assert.match(run(message(), new Map(), { banned }).msg, /moderator/);
});

test("the operator's own imports are not checked", () => {
  const r = decide(req({ id: 'x', kind: 1, tags: [] }, '', 'Import'), new Map(), { now: NOW, limits });
  assert.equal(r.action, 'accept');
});

test("speaks strfry's line protocol", async () => {
  const child = spawn(process.execPath, [fileURLToPath(new URL('./area-policy.mjs', import.meta.url))], {
    env: { ...process.env, AREA_BANNED_PATH: '/nonexistent/banned-area.json' },
  });
  const fresh = { ...message(), created_at: Math.floor(Date.now() / 1000) };
  fresh.tags = [['g', 'u8vx'], ['expiration', `${fresh.created_at + 3600}`]];
  child.stdin.write(`${JSON.stringify(req(fresh))}\n`);
  child.stdin.write(`${JSON.stringify(req({ id: 'no', kind: 1059, tags: [] }))}\n`);
  child.stdin.end();
  let out = '';
  child.stdout.on('data', (chunk) => { out += chunk; });
  await once(child, 'close');
  const answers = out.trim().split('\n').map((line) => JSON.parse(line));
  assert.deepEqual(answers.map((a) => a.action), ['accept', 'reject']);
});
