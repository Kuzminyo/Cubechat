import assert from 'node:assert/strict';
import { createHash, generateKeyPairSync, sign as edSign } from 'node:crypto';
import { mkdtemp, readFile } from 'node:fs/promises';
import { tmpdir } from 'node:os';
import path from 'node:path';
import test from 'node:test';
import { schnorr } from '@noble/curves/secp256k1';

// A direct report's quote checked against the author's own signature
// (verifyAuthorProof / directEvidence in src/index.js), and the ban that
// follows landing on the signing key rather than on the reported target.
const dir = await mkdtemp(path.join(tmpdir(), 'cubechat-author-proof-'));
process.env.REPORTS_PATH = path.join(dir, 'reports.jsonl');
process.env.BANNED_PATH = path.join(dir, 'banned.json');
process.env.AREA_BANNED_PATH = path.join(dir, 'banned-area.json');

const {
  createBans, createRateLimiter, directEvidence, handleReport, parseReportPayload, verifyAuthorProof,
} = await import('../src/index.js');

// Made by the app's own code — SignedPayload.wrap / wrapCompact and
// detachedProof, with the real text, reply and edit encoders — from the
// Ed25519 seed 0x07 × 32, so a change to either side's layout fails here.
const DART = {
  signer: 'ea4a6c63e29c520abef5507b132ec5f9954776aebebe7b92421eea691446d22c',
  text: 'AQEBAQEBAQECAgICAgICAgABAgMEBQYHCAkKCwwNDg_qSmxj4pxSCr71UHsTLsX5lUd2rr6-e5JCHuppFEbSLFHxoDUOGdksOWSwB6iKMGpelkGyZXANONphmAN0BQjsQtX8rrYlahTj04__EXBOyuX_ZDFixoSvkEebmVqZdgAAAAGhdyDKABAAF9Cd0ZYsINGC0Lgg0LTRg9GA0LXQvdGM1tKapISAKXjLxVOflFfq6EJidcSra4M',
  reply: 'AQEBAQEBAQECAgICAgICAgABAgMEBQYHCAkKCwwNDg_qSmxj4pxSCr71UHsTLsX5lUd2rr6-e5JCHuppFEbSLGptsREDenrRHX34ZzunVBBX3BM-Bd_dQzy_H2NlOMuae5RV41Q0JNk94cZm-HuyEOhAvwxTNKY5TWXEfs_cdwcAAAGhdyDKAKAJCQkJCQkJCQkJCQkJCQkJABLQstGW0LTQv9C-0LLRltC00YwjHWCaRWfcEEXBgkjh44kSgXHq_c1GXtxceU-E',
  edit: 'AQEBAQEBAQECAgICAgICAgABAgMEBQYHCAkKCwwNDg_qSmxj4pxSCr71UHsTLsX5lUd2rr6-e5JCHuppFEbSLBgyU46qTT1nVUIIJrcMxhApK9VzlFD2l7I17qb6i-dPY4OjF4Vo7HdLqVlOKhhTuxBtODntApFhFoijBMuP9gkAAAGhdyDKAIAJCQkJCQkJCQkJCQkJCQkJ0LLQuNC_0YDQsNCy0LvQtdC90L4',
};

const now = 1793000000;
const TARGET = 'ab'.repeat(32);

test('proofs made by the app verify, and read back the words, the kind and the time', () => {
  const text = verifyAuthorProof(DART.text);
  assert.equal(text.signer, DART.signer);
  assert.equal(text.kind, 'text');
  assert.equal(text.text, 'Ні, ти дурень');
  assert.equal(text.signedAt, 1793000000000);
  assert.equal(verifyAuthorProof(DART.reply).text, 'відповідь');
  assert.equal(verifyAuthorProof(DART.reply).kind, 'reply');
  assert.equal(verifyAuthorProof(DART.edit).text, 'виправлено');
  assert.equal(verifyAuthorProof(DART.edit).kind, 'edit');
});

test('any changed byte, or a key spliced in from somebody else, fails', () => {
  const bytes = Buffer.from(DART.text, 'base64url');
  for (const at of [0, 40, 100, 130, bytes.length - 1]) {
    const bad = Buffer.from(bytes);
    bad[at] ^= 1;
    assert.equal(verifyAuthorProof(bad.toString('base64url')), null, `byte ${at}`);
  }
  assert.equal(verifyAuthorProof('AAAA'), null);
});

/// A proof signed here with a fresh key, for the reporter-forges-it cases.
function proofFrom(innerBytes, { privateKey, publicKey } = generateKeyPairSync('ed25519')) {
  const pub = publicKey.export({ format: 'der', type: 'spki' }).subarray(12);
  const context = Buffer.alloc(32, 3);
  const ts = Buffer.alloc(8);
  ts.writeBigUInt64BE(1793000000000n);
  const sig = edSign(null, Buffer.concat([context, pub, ts, innerBytes]), privateKey);
  return { proof: Buffer.concat([context, pub, sig, ts, innerBytes]).toString('base64url'), signer: pub.toString('hex') };
}

function paddedText(s) {
  const utf = Buffer.from(s, 'utf8');
  const len = Buffer.alloc(2);
  len.writeUInt16BE(utf.length);
  return Buffer.concat([Buffer.from([0x10]), len, utf, Buffer.alloc(5, 0x77)]);
}

test('evidence: verified, a different quote, a forged proof, no proof', () => {
  const payload = (message) => ({ reason: 'abuse', context: 'direct', target: TARGET, message });
  const verified = directEvidence(payload({ text: 'Ні, ти дурень', proof: DART.text }), now);
  assert.equal(verified.status, 'verified');
  assert.equal(verified.fingerprint, DART.signer.slice(0, 16));

  const differs = directEvidence(payload({ text: 'погрози', proof: DART.text }), now);
  assert.equal(differs.status, 'mismatch');
  assert.deepEqual(differs.mismatches, ['text']);
  assert.equal(differs.text, 'Ні, ти дурень');

  const broken = Buffer.from(DART.text, 'base64url');
  broken[150] ^= 1;
  assert.equal(directEvidence(payload({ text: 'x', proof: broken.toString('base64url') }), now).status, 'invalid');

  // Signed, but not words: a receipt (0x40) proves nothing a moderator reads.
  const receipt = proofFrom(Buffer.from([0x40, 1, 2, 3])).proof;
  assert.equal(directEvidence(payload({ proof: receipt }), now).status, 'invalid');

  assert.equal(directEvidence(payload({ text: 'x' }), now), null);
});

test('a proof is accepted only on a direct report, as base64url, within the cap', () => {
  const base = { reason: 'abuse', target: TARGET };
  assert.equal(parseReportPayload(JSON.stringify({ ...base, context: 'direct', message: { proof: DART.text } })).message.proof, DART.text);
  assert.equal(parseReportPayload(JSON.stringify({ ...base, context: 'airdrop', message: { proof: DART.text } })), null);
  assert.equal(parseReportPayload(JSON.stringify({ ...base, context: 'direct', message: { proof: 'a+b/' } })), null);
  assert.equal(parseReportPayload(JSON.stringify({ ...base, context: 'direct', message: { proof: 'A'.repeat(16385) } })), null);
});

function reportEvent(payload) {
  const key = schnorr.utils.randomPrivateKey();
  const event = {
    pubkey: Buffer.from(schnorr.getPublicKey(key)).toString('hex'),
    created_at: now, kind: 24242, tags: [['action', 'report']], content: JSON.stringify(payload),
  };
  event.id = createHash('sha256').update(JSON.stringify([
    0, event.pubkey, event.created_at, event.kind, event.tags, event.content,
  ])).digest('hex');
  event.sig = Buffer.from(schnorr.sign(event.id, key)).toString('hex');
  return event;
}

test('handleReport stores what the proof proved, and not the proof', async () => {
  const appended = [];
  const r = await handleReport(reportEvent({
    reason: 'abuse', context: 'direct', target: TARGET,
    message: { text: 'Ні, ти дурень', kind: 'text', proof: DART.text },
  }), {
    nowSeconds: now, limiter: createRateLimiter({ perKey: 100, total: Infinity }),
    store: { async append(x) { appended.push(x); return x; } },
  });
  assert.equal(r.status, 200);
  assert.equal(appended[0].evidence.status, 'verified');
  assert.equal(appended[0].message.proof, undefined);
  assert.equal(appended[0].message.text, 'Ні, ти дурень');
});

test('a ban on a proven report adds the signer and leaves the named target alone', async () => {
  const bans = createBans({ path: path.join(dir, 'proven.json'), signingKeyPkcs8B64: undefined });
  await bans.ban({
    context: 'direct', target: TARGET, targetNpub: 'cd'.repeat(32),
    evidence: { status: 'verified', fingerprint: DART.signer.slice(0, 16), signer: DART.signer },
  });
  const list = bans.list();
  assert.deepEqual(list.fingerprints, [DART.signer.slice(0, 16)]);
  assert.deepEqual(list.identities, []);
  assert.deepEqual(list.npubs, []);
});

test('the framing attempt: a reporter signs abuse with their own key and names somebody else', async () => {
  const forged = proofFrom(paddedText('ти покидьок'));
  const evidence = directEvidence({ reason: 'abuse', context: 'direct', target: TARGET, message: { text: 'ти покидьок', proof: forged.proof } }, now);
  // The signature is genuine — it is the reporter's own.
  assert.equal(evidence.status, 'verified');
  assert.equal(evidence.signer, forged.signer);
  const bans = createBans({ path: path.join(dir, 'framed.json'), signingKeyPkcs8B64: undefined });
  await bans.ban({ context: 'direct', target: TARGET, evidence });
  // So the ban hits the forger's key, and the person they named stays clear.
  assert.deepEqual(bans.list().identities, []);
  assert.deepEqual(bans.list().fingerprints, [forged.signer.slice(0, 16)]);
});

test('a report without a proof, or with a forged one, bans the target as before', async () => {
  const bans = createBans({ path: path.join(dir, 'plain.json'), signingKeyPkcs8B64: undefined });
  await bans.ban({ context: 'direct', target: TARGET, targetNpub: 'cd'.repeat(32) });
  await bans.ban({ context: 'direct', target: 'ef'.repeat(32), evidence: { status: 'invalid' } });
  assert.deepEqual(bans.list().identities, [TARGET, 'ef'.repeat(32)]);
  assert.deepEqual(bans.list().npubs, ['cd'.repeat(32)]);
  assert.deepEqual(bans.list().fingerprints, []);
  const saved = JSON.parse(await readFile(path.join(dir, 'plain.json'), 'utf8'));
  assert.equal(saved.identities.length, 2);
});
