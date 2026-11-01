import assert from 'node:assert/strict';
import { once } from 'node:events';
import test from 'node:test';
import { letterFor, makeMailer } from '../src/mail.js';
import { RECOVERY_WAIT_SECONDS, openRegistry } from '../src/registry.js';
import { createIdServer } from '../src/server.js';
import { T0, b64u, cardFor, nostrPub, signedOp } from './helpers.js';

const OLD = '01'.repeat(32);
const NEW = '02'.repeat(32);
const THIEF = '03'.repeat(32);

function reg() {
  let now = T0;
  const r = openRegistry({ now: () => now * 1000 });
  return { r, advance: (s) => { now += s; }, at: () => now };
}

const token = (mail) => new URL(`https://x${mail.link}`).searchParams.get('t');

/// Claims @dima for the old key; returns the card it claimed with.
function named(r, at) {
  const card = b64u(cardFor(nostrPub(OLD)));
  r.apply(signedOp({ op: 'claim', name: 'dima', card }, { key: OLD, createdAt: at() }));
  return card;
}

function bindEmail(r, at, email = 'Dima@Example.com') {
  const res = r.apply(signedOp({ op: 'email-set', email }, { key: OLD, powBits: 0, createdAt: at() + 1 }));
  assert.equal(res.status, 200);
  assert.equal(res.mail.to, 'dima@example.com');
  assert.equal(res.mail.kind, 'verify');
  return res.mail;
}

const recover = (key, at, email = 'dima@example.com') =>
  signedOp(
    { op: 'recover', name: 'dima', email, card: b64u(cardFor(nostrPub(key))) },
    { key, powBits: 0, createdAt: at },
  );

test('an address is kept unverified until its link, then can recover', () => {
  const { r, advance, at } = reg();
  named(r, at);
  const verify = bindEmail(r, at);
  // Not yet verified: a recovery sends nothing.
  assert.equal(r.apply(recover(NEW, at() + 2)).mail, undefined);
  assert.equal(r.verifyEmail(token(verify)), true);
  assert.equal(r.verifyEmail(token(verify)), false, 'single use');

  const request = recover(NEW, at() + 3);
  const res = r.apply(request);
  assert.equal(res.status, 200);
  assert.equal(res.mail.kind, 'recover');
  const confirmed = r.confirmRecovery(token(res.mail));
  assert.equal(confirmed.name, 'dima');

  // The old owner is told on its next renew, and the name has not moved.
  const renew = r.apply(signedOp({ op: 'renew' }, { key: OLD, powBits: 0, createdAt: at() + 4 }));
  assert.equal(renew.body.recoveryMovesAt, confirmed.movesAt);
  assert.deepEqual(r.completeRecoveries(), []);

  advance(RECOVERY_WAIT_SECONDS);
  assert.deepEqual(r.completeRecoveries(), ['dima']);
  const card = JSON.parse(request.content).card;
  assert.equal(b64u(r.lookup('dima').card), card, 'the new phone\'s card');
  // The address went along with the name.
  assert.equal(
    r.apply(signedOp({ op: 'recover', name: 'dima', email: 'dima@example.com', card: b64u(cardFor(nostrPub(THIEF))) }, { key: THIEF, powBits: 0, createdAt: at() + 1 })).mail.to,
    'dima@example.com',
  );
});

test('the living old key cancels a recovery', () => {
  const { r, advance, at } = reg();
  const oldCard = named(r, at);
  r.verifyEmail(token(bindEmail(r, at)));
  const res = r.apply(recover(THIEF, at() + 2));
  r.confirmRecovery(token(res.mail));
  const cancel = r.apply(signedOp({ op: 'cancel-recovery' }, { key: OLD, powBits: 0, createdAt: at() + 3 }));
  assert.equal(cancel.status, 200);
  advance(RECOVERY_WAIT_SECONDS + 1);
  assert.deepEqual(r.completeRecoveries(), []);
  assert.equal(b64u(r.lookup('dima').card), oldCard, 'still the old key\'s');
});

test('a wrong address answers the same and sends nothing', () => {
  const { r, at } = reg();
  named(r, at);
  r.verifyEmail(token(bindEmail(r, at)));
  const wrong = r.apply(recover(NEW, at() + 2, 'someone@else.com'));
  const unknown = r.apply(signedOp(
    { op: 'recover', name: 'nobody', email: 'dima@example.com', card: b64u(cardFor(nostrPub(NEW))) },
    { key: NEW, powBits: 0, createdAt: at() + 3 },
  ));
  assert.deepEqual(wrong.body, { recovery: 'requested' });
  assert.deepEqual(unknown.body, { recovery: 'requested' });
  assert.equal(wrong.mail, undefined);
  assert.equal(unknown.mail, undefined);
});

test('a bad address is refused, and release forgets it', () => {
  const { r, at } = reg();
  named(r, at);
  assert.equal(r.apply(signedOp({ op: 'email-set', email: 'not an email' }, { key: OLD, powBits: 0, createdAt: at() + 1 })).body.error, 'bad-email');
  r.verifyEmail(token(bindEmail(r, at)));
  r.apply(signedOp({ op: 'release' }, { key: OLD, powBits: 0, createdAt: at() + 2 }));
  r.apply(signedOp({ op: 'claim', name: 'dima', card: b64u(cardFor(nostrPub(NEW))) }, { key: NEW, createdAt: at() + 3 }));
  assert.equal(r.apply(recover(THIEF, at() + 4)).mail, undefined, 'the old address is gone');
});

test('an expired link does nothing', () => {
  const { r, advance, at } = reg();
  named(r, at);
  const verify = bindEmail(r, at);
  advance(86_400 + 1);
  assert.equal(r.verifyEmail(token(verify)), false);
});

test('letters carry the link and say it in both languages', () => {
  const letter = letterFor({ kind: 'recover', name: 'dima', url: 'https://id.cubechat.tech/v1/recover/confirm?t=abc' });
  assert.match(letter.text, /t=abc/);
  assert.match(letter.text, /48 годин/);
  assert.match(letter.text, /48 hours/);
});

test('over HTTP: binding mails the link, and no key means mail-unavailable', async (t) => {
  const sent = [];
  const registry = openRegistry({ now: () => T0 * 1000 });
  const mailer = Object.assign(async (m) => { sent.push(m); return true; }, { ready: true });
  const server = createIdServer({ registry, adminToken: 'x', now: () => T0 * 1000, mailer });
  server.listen(0, '127.0.0.1');
  await once(server, 'listening');
  t.after(() => server.close());
  const base = `http://127.0.0.1:${server.address().port}`;
  const post = (body) => fetch(`${base}/v1/op`, { method: 'POST', body: JSON.stringify(body) });

  await post(signedOp({ op: 'claim', name: 'dima', card: b64u(cardFor(nostrPub(OLD))) }, { key: OLD }));
  const res = await post(signedOp({ op: 'email-set', email: 'dima@example.com' }, { key: OLD, powBits: 0, createdAt: T0 + 1 }));
  assert.equal(res.status, 200);
  assert.equal(sent.length, 1);
  const page = await fetch(`${base}${sent[0].link}`);
  assert.match(await page.text(), /Email confirmed/);

  const noKey = createIdServer({ registry, adminToken: 'x', now: () => T0 * 1000, mailer: makeMailer({ apiKey: '' }) });
  noKey.listen(0, '127.0.0.1');
  await once(noKey, 'listening');
  t.after(() => noKey.close());
  const r2 = await fetch(`http://127.0.0.1:${noKey.address().port}/v1/op`, {
    method: 'POST',
    body: JSON.stringify(signedOp({ op: 'email-set', email: 'a@b.cd' }, { key: OLD, powBits: 0, createdAt: T0 + 2 })),
  });
  assert.equal(r2.status, 503);
});
