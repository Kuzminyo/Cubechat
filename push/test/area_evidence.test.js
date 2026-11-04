import assert from 'node:assert/strict';
import { createHash } from 'node:crypto';
import { mkdtemp } from 'node:fs/promises';
import { once } from 'node:events';
import { tmpdir } from 'node:os';
import path from 'node:path';
import test from 'node:test';
import { schnorr } from '@noble/curves/secp256k1';
import { WebSocketServer } from 'ws';

// An area report's quote checked against the relay's own copy of the event
// (areaEvidence / fetchAreaEvent in src/index.js). Its own files, as every
// test file here has.
const dir = await mkdtemp(path.join(tmpdir(), 'cubechat-area-evidence-'));
process.env.REPORTS_PATH = path.join(dir, 'reports.jsonl');
process.env.AREA_BANNED_PATH = path.join(dir, 'banned-area.json');
process.env.BANNED_PATH = path.join(dir, 'banned.json');

const { areaEvidence, cleanAreaText, createRateLimiter, fetchAreaEvent, handleReport } =
  await import('../src/index.js');

const now = 1789000000;
const AUTHOR_KEY = '07'.repeat(32);
const AUTHOR = Buffer.from(schnorr.getPublicKey(AUTHOR_KEY)).toString('hex');

function sign(event, key) {
  event.id = createHash('sha256').update(JSON.stringify([
    0, event.pubkey, event.created_at, event.kind, event.tags, event.content,
  ])).digest('hex');
  event.sig = Buffer.from(schnorr.sign(event.id, key)).toString('hex');
  return event;
}

/// An area message as the app publishes it (area_event.dart).
function areaEvent({ text = 'мова ворожнечі', g = 'u8vx', kind = 1060, key = AUTHOR_KEY } = {}) {
  return sign({
    pubkey: Buffer.from(schnorr.getPublicKey(key)).toString('hex'),
    created_at: now - 60,
    kind,
    tags: [['g', g], ['expiration', `${now + 86000}`]],
    content: JSON.stringify({ v: 1, name: 'Сусід', text }),
  }, key);
}

function payloadFor(event, overrides = {}) {
  return {
    reason: 'abuse',
    context: 'area',
    target: event.pubkey,
    eventId: event.id,
    geohash: 'u8vx',
    message: { text: 'мова ворожнечі', kind: 'text', sentAt: event.created_at * 1000 },
    ...overrides,
  };
}

test('the relay copy that matches the quote, the key and the place is verified', () => {
  const event = areaEvent();
  const evidence = areaEvidence(payloadFor(event), { event }, now);
  assert.equal(evidence.status, 'verified');
  assert.equal(evidence.text, 'мова ворожнечі');
  assert.equal(evidence.createdAt, event.created_at);
  assert.equal(evidence.mismatches, undefined);
  // The author's chosen name is not copied into the report.
  assert.equal(JSON.stringify(evidence).includes('Сусід'), false);
});

test('a quote the author never wrote is a text mismatch, and the real text is kept', () => {
  const event = areaEvent({ text: 'привіт усім' });
  const evidence = areaEvidence(payloadFor(event), { event }, now);
  assert.equal(evidence.status, 'mismatch');
  assert.deepEqual(evidence.mismatches, ['text']);
  assert.equal(evidence.text, 'привіт усім');
});

test('naming somebody else as the author of a real event is an author mismatch', () => {
  const event = areaEvent();
  const evidence = areaEvidence(payloadFor(event, { target: 'cd'.repeat(32) }), { event }, now);
  assert.deepEqual(evidence.mismatches, ['author']);
});

test('the wrong city is a place mismatch', () => {
  const event = areaEvent({ g: 'u8vw' });
  assert.deepEqual(areaEvidence(payloadFor(event), { event }, now).mismatches, ['place']);
});

test('control characters the phone strips do not make a false mismatch', () => {
  const event = areaEvent({ text: '  мова\u0007 ворожнечі\n' });
  assert.equal(areaEvidence(payloadFor(event), { event }, now).status, 'verified');
  assert.equal(cleanAreaText('a\u0000b\tc\uD800'), 'ab\tc');
});

test('no event, a forged event, or a presence is missing; no relay is unavailable', () => {
  const event = areaEvent();
  const payload = payloadFor(event);
  assert.equal(areaEvidence(payload, { missing: true }, now).status, 'missing');
  const forged = { ...event, content: JSON.stringify({ v: 1, text: 'мова ворожнечі' }) };
  assert.equal(areaEvidence(payload, { event: forged }, now).status, 'missing');
  const presence = areaEvent({ kind: 21060 });
  assert.equal(areaEvidence(payloadFor(presence), { event: presence }, now).status, 'missing');
  assert.equal(areaEvidence(payload, { unavailable: true }, now).status, 'unavailable');
});

/// A report signed by a fresh key — no work needed with areaPowBits: 0.
function report(payload) {
  const key = schnorr.utils.randomPrivateKey();
  return sign({
    pubkey: Buffer.from(schnorr.getPublicKey(key)).toString('hex'),
    created_at: now,
    kind: 24242,
    tags: [['action', 'report']],
    content: JSON.stringify(payload),
  }, key);
}

function store() {
  const appended = [];
  return { appended, async append(r) { appended.push(r); return r; } };
}

const limiter = () => createRateLimiter({ perKey: 100, total: Infinity });

test('handleReport stores the evidence on an area report, and only there', async () => {
  const event = areaEvent({ text: 'привіт усім' });
  const asked = [];
  const s = store();
  const r = await handleReport(report(payloadFor(event)), {
    nowSeconds: now, limiter: limiter(), store: s, areaPowBits: 0,
    fetchAreaEvent: async (id) => { asked.push(id); return { event }; },
  });
  assert.equal(r.status, 200);
  assert.deepEqual(asked, [event.id]);
  assert.equal(s.appended[0].evidence.status, 'mismatch');
  assert.equal(s.appended[0].message.text, 'мова ворожнечі');

  const direct = store();
  await handleReport(report({ reason: 'spam', context: 'direct', target: 'ab'.repeat(32) }), {
    nowSeconds: now, limiter: limiter(), store: direct,
    fetchAreaEvent: async () => { throw new Error('must not be asked'); },
  });
  assert.equal(direct.appended[0].evidence, undefined);
});

test('a fetcher that throws still stores the report, as unavailable', async () => {
  const event = areaEvent();
  const s = store();
  const r = await handleReport(report(payloadFor(event)), {
    nowSeconds: now, limiter: limiter(), store: s, areaPowBits: 0,
    fetchAreaEvent: async () => { throw new Error('boom'); },
  });
  assert.equal(r.status, 200);
  assert.equal(s.appended[0].evidence.status, 'unavailable');
});

test('a report refused by a limit never asks the relay', async () => {
  const event = areaEvent();
  let asked = 0;
  const r = await handleReport(report(payloadFor(event)), {
    nowSeconds: now, limiter: createRateLimiter({ perKey: 0, total: Infinity }), store: store(), areaPowBits: 0,
    fetchAreaEvent: async () => { asked++; return { event }; },
  });
  assert.equal(r.status, 429);
  assert.equal(asked, 0);
});

test('fetchAreaEvent asks a real relay socket by id, and reads EOSE as missing', async () => {
  const event = areaEvent();
  const wss = new WebSocketServer({ port: 0, host: '127.0.0.1' });
  await once(wss, 'listening');
  const filters = [];
  wss.on('connection', (socket) => {
    socket.on('message', (data) => {
      const [type, sub, filter] = JSON.parse(data.toString());
      assert.equal(type, 'REQ');
      filters.push(filter);
      if (filter.ids[0] === event.id) socket.send(JSON.stringify(['EVENT', sub, event]));
      socket.send(JSON.stringify(['EOSE', sub]));
    });
  });
  const url = `ws://127.0.0.1:${wss.address().port}`;
  try {
    assert.deepEqual(await fetchAreaEvent(event.id, { url }), { event });
    assert.deepEqual(await fetchAreaEvent('00'.repeat(32), { url }), { missing: true });
    assert.deepEqual(filters[0], { ids: [event.id], kinds: [1060, 1062], limit: 1 });
  } finally {
    for (const client of wss.clients) client.terminate();
    wss.close();
  }
});

test('fetchAreaEvent gives up as unavailable on a refused or silent relay', async () => {
  assert.deepEqual(await fetchAreaEvent('00'.repeat(32), { url: 'ws://127.0.0.1:1', timeoutMs: 2000 }),
    { unavailable: true });
  const wss = new WebSocketServer({ port: 0, host: '127.0.0.1' });
  await once(wss, 'listening');
  try {
    const started = Date.now();
    assert.deepEqual(
      await fetchAreaEvent('00'.repeat(32), { url: `ws://127.0.0.1:${wss.address().port}`, timeoutMs: 200 }),
      { unavailable: true },
    );
    assert.ok(Date.now() - started < 2000);
  } finally {
    for (const client of wss.clients) client.terminate();
    wss.close();
  }
});
