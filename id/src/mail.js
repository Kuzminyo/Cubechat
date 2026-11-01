// Letters for Cube ID's e-mail recovery, sent through Resend
// (docs/superpowers/specs/2026-09-29-cube-id-names-design.md §4). The key is
// RESEND_API_KEY in the service's environment — a systemd drop-in, never the
// repository. Without it every letter is refused and the server says so.

const API = 'https://api.resend.com/emails';

/// What a letter says, in both languages the app speaks: whoever opens it has
/// not necessarily set the phone to the one the address suggests.
export function letterFor({ kind, name, url }) {
  if (kind === 'verify') {
    return {
      subject: `Cube ID: підтвердіть пошту для @${name} / confirm your email`,
      text:
        `Цю пошту вказали для відновлення імені @${name} у CubeChat.\n` +
        `Підтвердіть: ${url}\n\n` +
        `This address was given to recover the name @${name} in CubeChat.\n` +
        `Confirm: ${url}\n\n` +
        'Якщо це були не ви, нічого не робіть. / If this was not you, ignore this letter.\n',
    };
  }
  return {
    subject: `Cube ID: перенести @${name} на новий телефон? / move to a new phone?`,
    text:
      `Хтось просить перенести ім'я @${name} на новий телефон.\n` +
      `Якщо це ви, відкрийте посилання: ${url}\n` +
      'Ім\'я перейде через 48 годин після цього. Старий телефон, якщо він ще у вас, ' +
      'може скасувати перенесення в ці 48 годин.\n\n' +
      `Somebody asked to move the name @${name} to a new phone.\n` +
      `If it was you, open: ${url}\n` +
      'The name moves 48 hours later; the old phone, if you still have it, can cancel.\n\n' +
      'Якщо це були не ви, нічого не робіть. / If this was not you, ignore this letter.\n',
  };
}

/// A function that sends one letter and resolves to whether Resend took it.
export function makeMailer({
  apiKey = process.env.RESEND_API_KEY || '',
  from = 'Cube ID <id@cubechat.tech>',
  base = 'https://id.cubechat.tech',
  fetchImpl = globalThis.fetch,
} = {}) {
  const send = async ({ to, kind, name, link }) => {
    if (!apiKey) return false;
    const { subject, text } = letterFor({ kind, name, url: base + link });
    try {
      const res = await fetchImpl(API, {
        method: 'POST',
        headers: { authorization: `Bearer ${apiKey}`, 'content-type': 'application/json' },
        body: JSON.stringify({ from, to: [to], subject, text }),
      });
      if (!res.ok) console.error('[id] resend refused', res.status, await res.text());
      return res.ok;
    } catch (e) {
      console.error('[id] resend unreachable', e);
      return false;
    }
  };
  send.ready = Boolean(apiKey);
  return send;
}
