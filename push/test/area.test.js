import assert from 'node:assert/strict';
import { createHash, generateKeyPairSync, verify as edVerify } from 'node:crypto';
import { mkdtemp, readFile, stat } from 'node:fs/promises';
import { tmpdir } from 'node:os';
import path from 'node:path';
import test from 'node:test';
import { schnorr } from '@noble/curves/secp256k1';

// The area chat's half of the report and ban routes
// (docs/superpowers/specs/2026-11-02-area-chat-design.md). Its own files, as
// every test file here has, and a real Ed25519 key so the list is verified.
const dir = await mkdtemp(path.join(tmpdir(), 'cubechat-area-'));
process.env.BANNED_PATH = path.join(dir, 'banned.json');
process.env.AREA_BANNED_PATH = path.join(dir, 'banned-area.json');
process.env.REPORTS_PATH = path.join(dir, 'reports.jsonl');
process.env.ADMIN_TOKEN = 'test-admin-token';
const { publicKey, privateKey } = generateKeyPairSync('ed25519');
process.env.BAN_SIGNING_KEY = privateKey.export({ type: 'pkcs8', format: 'der' }).toString('base64');

const {
  canonicalAreaBanBody, createAreaBans, createBans, createRateLimiter, difficulty,
  handleAdmin, handleBannedArea, handleReport, parseReportPayload,
} = await import('../src/index.js');

const now = Math.floor(Date.now() / 1000);
const AREA_KEY = 'cd'.repeat(32);
const EVENT_ID = 'ef'.repeat(32);

function areaPayload(overrides = {}) {
  return {
    reason: 'abuse',
    context: 'area',
    target: AREA_KEY,
    eventId: EVENT_ID,
    geohash: 'u8vx',
    message: { text: 'мова ворожнечі', kind: 'text', sentAt: now * 1000 },
    ...overrides,
  };
}

/// A report signed by a fresh key with [bits] of work mined into a nonce.
function signedWithWork(content, bits) {
  const key = schnorr.utils.randomPrivateKey();
  const pubkey = Buffer.from(schnorr.getPublicKey(key)).toString('hex');
  for (let nonce = 0; ; nonce++) {
    const event = {
      pubkey, created_at: now, kind: 24242,
      tags: [['action', 'report'], ['nonce', `${nonce}`, `${bits}`]],
      content,
    };
    event.id = createHash('sha256').update(JSON.stringify([
      0, event.pubkey, event.created_at, event.kind, event.tags, event.content,
    ])).digest('hex');
    if (difficulty(event.id) >= bits) {
      event.sig = Buffer.from(schnorr.sign(event.id, key)).toString('hex');
      return event;
    }
  }
}

function store() {
  const appended = [];
  return { appended, async append(r) { appended.push(r); return r; } };
}

const limiter = () => createRateLimiter({ perKey: 100, total: Infinity });

test('an area report names its event, its key and a city or a region', () => {
  assert.deepEqual(parseReportPayload(JSON.stringify(areaPayload())).eventId, EVENT_ID);
  for (const bad of [
    { eventId: undefined },
    { eventId: 'xyz' },
    { geohash: undefined },
    { geohash: 'u8vxn' },
    { geohash: 'u8' },
    { target: undefined },
  ]) {
    assert.equal(parseReportPayload(JSON.stringify(areaPayload(bad))), null, JSON.stringify(bad));
  }
  // The two area fields belong to area reports alone.
  assert.equal(parseReportPayload(JSON.stringify({
    reason: 'spam', context: 'general', eventId: EVENT_ID,
  })), null);
});

test('an area report needs the work, and its address is held to ten an hour', async () => {
  const content = JSON.stringify(areaPayload());
  const lazy = signedWithWork(content, 0);
  if (difficulty(lazy.id) < 8) {
    const r = await handleReport(lazy, { nowSeconds: now, limiter: limiter(), store: store(), areaPowBits: 8 });
    assert.equal(r.status, 403);
    assert.equal(r.body.reason, 'pow');
  }
  const areaIpLimiter = createRateLimiter({ perKey: 10, total: Infinity });
  const s = store();
  for (let i = 0; i < 10; i++) {
    const r = await handleReport(signedWithWork(content, 8), {
      nowSeconds: now, limiter: limiter(), store: s, ip: '203.0.113.9', areaIpLimiter, areaPowBits: 8,
    });
    assert.equal(r.status, 200, `report ${i}`);
  }
  const eleventh = await handleReport(signedWithWork(content, 8), {
    nowSeconds: now, limiter: limiter(), store: s, ip: '203.0.113.9', areaIpLimiter, areaPowBits: 8,
  });
  assert.equal(eleventh.status, 429);
  assert.equal(s.appended[0].context, 'area');
  assert.equal(s.appended[0].geohash, 'u8vx');
});

test('a ban on an area report goes to the area list, signed, and never to /banned', async () => {
  const reportsStore = {
    reports: new Map([['a1', { id: 'a1', status: 'open', context: 'area', target: AREA_KEY, eventId: EVENT_ID, geohash: 'u8vx' }]]),
    async decide(id, patch) {
      const r = this.reports.get(id);
      if (!r) return { notFound: true };
      if (r.status !== 'open') return { conflict: r.status };
      const updated = { ...r, ...patch };
      this.reports.set(id, updated);
      return { report: updated };
    },
    async update() {},
  };
  const bans = createBans({ path: path.join(dir, 'general.json') });
  const areaBans = createAreaBans();
  const result = await handleAdmin(
    { method: 'POST', url: '/admin/reports/a1/ban', headers: { authorization: 'Bearer test-admin-token' }, body: '' },
    { store: reportsStore, bans, areaBans, remoteAddress: '127.0.0.1' },
  );
  assert.equal(result.status, 200);
  assert.deepEqual(bans.list().identities, []);
  assert.deepEqual(bans.list().npubs, []);

  const published = handleBannedArea({ bans: areaBans });
  assert.equal(published.status, 200);
  assert.deepEqual(published.body.events, [EVENT_ID]);
  assert.deepEqual(published.body.keys, [AREA_KEY]);
  const { sig, ...unsigned } = published.body;
  assert.ok(edVerify(null, Buffer.from(canonicalAreaBanBody(unsigned), 'utf8'), publicKey, Buffer.from(sig, 'hex')));
  assert.ok(areaBans.isBannedKey(AREA_KEY));

  // The file the area relay reads, readable by its user.
  const file = JSON.parse(await readFile(process.env.AREA_BANNED_PATH, 'utf8'));
  assert.deepEqual(file.keys.map((k) => k.key), [AREA_KEY]);
  assert.equal((await stat(process.env.AREA_BANNED_PATH)).mode & 0o044, 0o044);
});

test('an area ban is forgotten after a day', async () => {
  let t = 1_800_000_000;
  const bans = createAreaBans({ path: path.join(dir, 'aged.json'), nowSeconds: () => t });
  await bans.ban({ context: 'area', target: AREA_KEY, eventId: EVENT_ID });
  assert.deepEqual(bans.list().keys, [AREA_KEY]);
  t += 24 * 3600 + 1;
  assert.deepEqual(bans.list().keys, []);
  assert.deepEqual(bans.list().events, []);
});

test('without a signing key the area list answers 503, not an unsigned list', () => {
  const bans = createAreaBans({ path: path.join(dir, 'none.json'), signingKeyPkcs8B64: '' });
  assert.equal(handleBannedArea({ bans }).status, 503);
});
