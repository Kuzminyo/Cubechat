// Cube ID's whole state: which name points at which signed card.
//
// Every change arrives as a Nostr event signed by the owner, and the card must
// carry that same Nostr key — so the database can be restored from a backup and
// any forged row is visible, because it would not verify.

import { randomBytes } from 'node:crypto';
import { DatabaseSync } from 'node:sqlite';
import { parseCard } from './card.js';
import { MAX_FUTURE, MAX_PAST, POW_BITS, difficulty, verifyEvent } from './events.js';
import { nameProblem, normalizeName } from './names.js';

const DAY = 86_400;
/// After a rename the old name keeps pointing at its owner this long, so
/// nobody can take it and receive messages meant for them.
export const HOLD_SECONDS = 30 * DAY;
/// A name nobody renewed for six months belongs to a lost key; it goes free.
export const EXPIRE_SECONDS = 182 * DAY;
const REACH = new Set(['all', 'request', 'none']);
const OPS = new Set([
  'claim', 'rename', 'update', 'renew', 'release', 'rotate',
  'email-set', 'email-remove', 'recover', 'cancel-recovery',
]);
/// How long a confirmed recovery waits before the name moves, so a living old
/// key can say no (docs/superpowers/specs/2026-09-29-cube-id-names-design.md §4).
export const RECOVERY_WAIT_SECONDS = 2 * DAY;
/// How long a link in a letter stays good.
export const LINK_SECONDS = DAY;
const EMAIL = /^[^\s@]{1,64}@[^\s@]{1,190}\.[^\s@]{2,}$/;
const normalizeEmail = (raw) => String(raw ?? '').trim().toLowerCase();
const HEX64 = /^[0-9a-f]{64}$/;

const fail = (status, error) => ({ status, body: { error } });
const ok = (body = { ok: true }) => ({ status: 200, body });

export function openRegistry({ path = ':memory:', now = () => Date.now() } = {}) {
  const db = new DatabaseSync(path);
  db.exec(`
    PRAGMA journal_mode = WAL;
    CREATE TABLE IF NOT EXISTS names (
      name TEXT PRIMARY KEY, nostr_pub TEXT NOT NULL UNIQUE, card BLOB NOT NULL,
      reach TEXT NOT NULL DEFAULT 'all', created_at INTEGER NOT NULL, renewed_at INTEGER NOT NULL);
    CREATE TABLE IF NOT EXISTS held (
      name TEXT PRIMARY KEY, nostr_pub TEXT NOT NULL, until INTEGER NOT NULL);
    CREATE TABLE IF NOT EXISTS revoked (
      name TEXT PRIMARY KEY, reason TEXT, at INTEGER NOT NULL);
    CREATE TABLE IF NOT EXISTS seen (
      id TEXT PRIMARY KEY, at INTEGER NOT NULL);
    CREATE TABLE IF NOT EXISTS emails (
      nostr_pub TEXT PRIMARY KEY, email TEXT NOT NULL, verified INTEGER NOT NULL DEFAULT 0,
      token TEXT, token_until INTEGER);
    CREATE TABLE IF NOT EXISTS recoveries (
      name TEXT PRIMARY KEY, new_pub TEXT NOT NULL, card BLOB NOT NULL, token TEXT NOT NULL,
      token_until INTEGER NOT NULL, confirmed_at INTEGER, moves_at INTEGER);
  `);
  const seconds = () => Math.floor(now() / 1000);
  // Nostr keys the moderator banned (push's banned.json). Refused a name
  // outright; see [setBanned].
  let banned = new Set();
  const q = {
    byName: db.prepare('SELECT * FROM names WHERE name = ?'),
    byPub: db.prepare('SELECT * FROM names WHERE nostr_pub = ?'),
    held: db.prepare('SELECT * FROM held WHERE name = ?'),
    revoked: db.prepare('SELECT 1 FROM revoked WHERE name = ?'),
    revoke: db.prepare('INSERT OR REPLACE INTO revoked (name, reason, at) VALUES (?, ?, ?)'),
    seen: db.prepare('SELECT 1 FROM seen WHERE id = ?'),
    remember: db.prepare('INSERT INTO seen (id, at) VALUES (?, ?)'),
    insert: db.prepare('INSERT INTO names (name, nostr_pub, card, reach, created_at, renewed_at) VALUES (?, ?, ?, ?, ?, ?)'),
    del: db.prepare('DELETE FROM names WHERE nostr_pub = ?'),
    hold: db.prepare('INSERT OR REPLACE INTO held (name, nostr_pub, until) VALUES (?, ?, ?)'),
    unholdOwn: db.prepare('DELETE FROM held WHERE nostr_pub = ?'),
    update: db.prepare('UPDATE names SET card = ?, reach = ? WHERE nostr_pub = ?'),
    renew: db.prepare('UPDATE names SET renewed_at = ? WHERE nostr_pub = ?'),
    rotate: db.prepare('UPDATE names SET nostr_pub = ?, renewed_at = ? WHERE nostr_pub = ?'),
    rotateHeld: db.prepare('UPDATE held SET nostr_pub = ? WHERE nostr_pub = ?'),
    emailOf: db.prepare('SELECT * FROM emails WHERE nostr_pub = ?'),
    emailByToken: db.prepare('SELECT * FROM emails WHERE token = ?'),
    emailSet: db.prepare('INSERT OR REPLACE INTO emails (nostr_pub, email, verified, token, token_until) VALUES (?, ?, 0, ?, ?)'),
    emailVerify: db.prepare('UPDATE emails SET verified = 1, token = NULL, token_until = NULL WHERE nostr_pub = ?'),
    emailDel: db.prepare('DELETE FROM emails WHERE nostr_pub = ?'),
    emailMove: db.prepare('UPDATE emails SET nostr_pub = ? WHERE nostr_pub = ?'),
    recoveryOf: db.prepare('SELECT * FROM recoveries WHERE name = ?'),
    recoveryByToken: db.prepare('SELECT * FROM recoveries WHERE token = ?'),
    recoverySet: db.prepare('INSERT OR REPLACE INTO recoveries (name, new_pub, card, token, token_until, confirmed_at, moves_at) VALUES (?, ?, ?, ?, ?, NULL, NULL)'),
    recoveryConfirm: db.prepare('UPDATE recoveries SET confirmed_at = ?, moves_at = ?, token = \'\' WHERE name = ?'),
    recoveryDel: db.prepare('DELETE FROM recoveries WHERE name = ?'),
    recoveriesDue: db.prepare('SELECT * FROM recoveries WHERE moves_at IS NOT NULL AND moves_at <= ?'),
  };
  // Links in letters: unguessable, single use. Injected for tests.
  const newToken = () => randomBytes(24).toString('base64url');

  function blocked(name, pub) {
    const problem = nameProblem(name);
    if (problem) return problem;
    if (q.revoked.get(name)) return 'reserved';
    const owner = q.byName.get(name);
    if (owner && owner.nostr_pub !== pub) return 'taken';
    const held = q.held.get(name);
    if (held && held.nostr_pub !== pub && held.until > seconds()) return 'taken';
    return null;
  }

  function verifiedCard(content, pub) {
    let card;
    try {
      card = new Uint8Array(Buffer.from(String(content.card ?? ''), 'base64url'));
      if (parseCard(card).nostrHex !== pub) return { error: fail(403, 'card-mismatch') };
    } catch {
      return { error: fail(403, 'card-invalid') };
    }
    return { card };
  }

  /// What the owner of [name] is told on every renew and update: a confirmed
  /// recovery that will take the name from them at `movesAt`, while they can
  /// still cancel it.
  function pendingFor(name) {
    const r = q.recoveryOf.get(name);
    return r && r.moves_at ? { recoveryMovesAt: r.moves_at } : {};
  }

  /// The link in a verification letter was opened.
  function verifyEmail(token) {
    const row = token ? q.emailByToken.get(String(token)) : null;
    if (!row || row.token_until < seconds()) return false;
    q.emailVerify.run(row.nostr_pub);
    return true;
  }

  /// The link in a recovery letter was opened: the name moves in
  /// [RECOVERY_WAIT_SECONDS] unless the old key cancels. Returns what the
  /// page says, and whom to warn.
  function confirmRecovery(token) {
    const row = token ? q.recoveryByToken.get(String(token)) : null;
    if (!row || row.token_until < seconds()) return null;
    const t = seconds();
    q.recoveryConfirm.run(t, t + RECOVERY_WAIT_SECONDS, row.name);
    const owner = q.byName.get(row.name);
    const bound = owner ? q.emailOf.get(owner.nostr_pub) : null;
    return { name: row.name, movesAt: t + RECOVERY_WAIT_SECONDS, email: bound?.email ?? null };
  }

  /// Recoveries whose wait is over: the name, its held names and its address
  /// go to the new key, with the card it sent.
  function completeRecoveries() {
    const done = [];
    for (const r of q.recoveriesDue.all(seconds())) {
      const owner = q.byName.get(r.name);
      db.exec('BEGIN');
      try {
        if (owner && !q.byPub.get(r.new_pub)) {
          q.rotate.run(r.new_pub, seconds(), owner.nostr_pub);
          q.rotateHeld.run(r.new_pub, owner.nostr_pub);
          q.emailMove.run(r.new_pub, owner.nostr_pub);
          q.update.run(r.card, owner.reach, r.new_pub);
          done.push(r.name);
        }
        q.recoveryDel.run(r.name);
        db.exec('COMMIT');
      } catch (e) {
        db.exec('ROLLBACK');
        throw e;
      }
    }
    return done;
  }

  function apply(event) {
    if (!verifyEvent(event)) return fail(401, 'bad-signature');
    const t = seconds();
    if (event.created_at < t - MAX_PAST || event.created_at > t + MAX_FUTURE) return fail(401, 'stale');
    if (q.seen.get(event.id)) return fail(401, 'stale');
    let content;
    try {
      content = JSON.parse(event.content);
    } catch {
      return fail(400, 'bad-request');
    }
    if (!OPS.has(content?.op)) return fail(400, 'bad-request');
    const pub = event.pubkey;
    const mine = q.byPub.get(pub);
    const op = content.op;

    if ((op === 'claim' || op === 'rename') && difficulty(event.id) < POW_BITS) return fail(403, 'pow');
    if ((op === 'claim' || op === 'rename') && banned.has(pub)) return fail(403, 'banned');
    // A recovery is asked by the new key, which by definition owns nothing.
    if (op !== 'claim' && op !== 'recover' && !mine) return fail(404, 'no-name');
    if (op === 'claim' && mine) return fail(409, 'has-name');
    // A claim may carry who can find us, so choosing "nobody" before taking a
    // name never leaves it public for even one request.
    if (content.reach !== undefined && !REACH.has(content.reach)) return fail(400, 'bad-request');

    let result;
    if (op === 'claim' || op === 'rename') {
      const name = normalizeName(content.name);
      const why = blocked(name, pub);
      if (why) return fail(409, why);
      const { card, error } = verifiedCard(content, pub);
      if (error) return error;
      db.exec('BEGIN');
      try {
        if (mine) {
          q.del.run(pub);
          if (mine.name !== name) q.hold.run(mine.name, pub, t + HOLD_SECONDS);
        }
        q.insert.run(name, pub, card, content.reach ?? mine?.reach ?? 'all', mine?.created_at ?? t, t);
        db.exec('COMMIT');
      } catch (e) {
        db.exec('ROLLBACK');
        throw e;
      }
      result = ok({ name });
    } else if (op === 'update') {
      const reach = content.reach ?? mine.reach;
      if (!REACH.has(reach)) return fail(400, 'bad-request');
      const { card, error } = content.card ? verifiedCard(content, pub) : { card: mine.card };
      if (error) return error;
      q.update.run(card, reach, pub);
      result = ok({ name: mine.name, ...pendingFor(mine.name) });
    } else if (op === 'renew') {
      q.renew.run(t, pub);
      result = ok({ name: mine.name, ...pendingFor(mine.name) });
    } else if (op === 'email-set') {
      // Kept only to send letters about this name; stored plain because a
      // letter needs the address. Unverified until the link in the first one
      // is opened, and only a verified address can recover the name.
      const email = normalizeEmail(content.email);
      if (!EMAIL.test(email)) return fail(400, 'bad-email');
      const token = newToken();
      q.emailSet.run(pub, email, token, t + LINK_SECONDS);
      result = ok({ name: mine.name, email: 'pending' });
      result.mail = {
        to: email,
        kind: 'verify',
        name: mine.name,
        link: `/v1/email/verify?t=${token}`,
      };
    } else if (op === 'email-remove') {
      q.emailDel.run(pub);
      result = ok({ name: mine.name });
    } else if (op === 'recover') {
      // A new phone asks for a name it lost. The answer is the same whether
      // or not the address matched, so this cannot be used to learn whose
      // address is whose; a letter goes only when it did.
      if (mine) return fail(409, 'has-name');
      const name = normalizeName(content.name);
      const email = normalizeEmail(content.email);
      const { card, error } = verifiedCard(content, pub);
      if (error) return error;
      const owner = q.byName.get(name);
      const bound = owner ? q.emailOf.get(owner.nostr_pub) : null;
      result = ok({ recovery: 'requested' });
      if (bound && bound.verified && bound.email === email && owner.nostr_pub !== pub) {
        const token = newToken();
        q.recoverySet.run(name, pub, card, token, t + LINK_SECONDS);
        result.mail = {
          to: email,
          kind: 'recover',
          name,
          link: `/v1/recover/confirm?t=${token}`,
        };
      }
    } else if (op === 'cancel-recovery') {
      // The old key is alive and says no.
      q.recoveryDel.run(mine.name);
      result = ok({ name: mine.name });
    } else if (op === 'rotate') {
      // The account changed its keys (docs/superpowers/specs/2026-11-01-key-
      // rotation-design.md). Signed by the key that owns the name, naming the
      // key that will: the name moves at once, with any name it still holds
      // after a rename, so nobody can take it in between. The card stays the
      // old one until the new key sends `update` a moment later — the old key
      // is destroyed by then and cannot sign a card for the new one.
      const next = String(content.newPub ?? '');
      if (!HEX64.test(next) || next === pub) return fail(400, 'bad-request');
      if (q.byPub.get(next)) return fail(409, 'has-name');
      if (banned.has(next)) return fail(403, 'banned');
      db.exec('BEGIN');
      try {
        q.rotate.run(next, t, pub);
        q.rotateHeld.run(next, pub);
        q.emailMove.run(next, pub);
        db.exec('COMMIT');
      } catch (e) {
        db.exec('ROLLBACK');
        throw e;
      }
      result = ok({ name: mine.name });
    } else {
      q.del.run(pub);
      q.unholdOwn.run(pub);
      q.emailDel.run(pub);
      q.recoveryDel.run(mine.name);
      result = ok();
    }
    q.remember.run(event.id, t);
    return result;
  }

  function lookup(raw) {
    const name = normalizeName(raw);
    if (nameProblem(name) === 'invalid' || q.revoked.get(name)) return null;
    let row = q.byName.get(name);
    if (!row) {
      const held = q.held.get(name);
      if (held && held.until > seconds()) row = q.byPub.get(held.nostr_pub);
    }
    if (!row || row.reach === 'none') return null;
    return { name, card: new Uint8Array(row.card), reach: row.reach };
  }

  function availability(raw) {
    const name = normalizeName(raw);
    const problem = nameProblem(name);
    if (problem) return { available: false, reason: problem };
    if (q.revoked.get(name)) return { available: false, reason: 'reserved' };
    if (q.byName.get(name)) return { available: false, reason: 'taken' };
    const held = q.held.get(name);
    if (held && held.until > seconds()) return { available: false, reason: 'taken' };
    return { available: true };
  }

  function revoke({ name, npub, reason = '' }) {
    const row = name ? q.byName.get(normalizeName(name)) : q.byPub.get(String(npub ?? '').toLowerCase());
    if (row) {
      q.del.run(row.nostr_pub);
      q.revoke.run(row.name, reason, seconds());
      return 1;
    }
    // A name can be revoked before anybody takes it, to keep it from ever
    // being handed out.
    if (name) q.revoke.run(normalizeName(name), reason, seconds());
    return 0;
  }

  // A banned key loses its name, but the name itself is not burned: it was
  // somebody's handle, not the offence, and another person may take it.
  // Moderator revocation of an offensive *name* is [revoke] instead.
  function revokeNpubs(npubs) {
    let n = 0;
    for (const npub of npubs) {
      n += Number(q.del.run(String(npub).toLowerCase()).changes);
      q.unholdOwn.run(String(npub).toLowerCase());
    }
    return n;
  }

  function setBanned(npubs) {
    banned = new Set([...npubs].map((x) => String(x).toLowerCase()));
  }

  function sweep() {
    const t = seconds();
    const expired = db.prepare('DELETE FROM names WHERE renewed_at < ?').run(t - EXPIRE_SECONDS).changes;
    const unheld = db.prepare('DELETE FROM held WHERE until <= ?').run(t).changes;
    db.prepare('DELETE FROM seen WHERE at < ?').run(t - MAX_PAST - MAX_FUTURE);
    // An address nobody confirmed, and a recovery nobody confirmed, are kept
    // no longer than their link; an address whose name is gone goes with it.
    db.prepare('DELETE FROM emails WHERE verified = 0 AND token_until < ?').run(t);
    db.prepare('DELETE FROM emails WHERE nostr_pub NOT IN (SELECT nostr_pub FROM names)').run();
    db.prepare('DELETE FROM recoveries WHERE confirmed_at IS NULL AND token_until < ?').run(t);
    return { expired: Number(expired), unheld: Number(unheld) };
  }

  return {
    apply, lookup, availability, revoke, revokeNpubs, setBanned, sweep,
    verifyEmail, confirmRecovery, completeRecoveries,
    count: () => Number(db.prepare('SELECT COUNT(*) AS n FROM names').get().n),
    close: () => db.close(),
  };
}
