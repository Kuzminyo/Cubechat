# Cubechat Privacy Policy

**Last updated: 3 November 2026**

Cubechat is a peer-to-peer messenger. Messages travel directly between phones
over Bluetooth Low Energy, and optionally through public relays that carry them
sealed. There is no Cubechat account, no Cubechat message server, and no
company database holding your conversations.

This policy describes exactly what the app does with data, including the parts
that are not private, because a messenger that overstates its privacy is more
dangerous than one that has none.

> This document is written from the source code and is not legal advice; have
> it reviewed before you rely on it.

---

## 1. Who is responsible

**Controller:** Kuzminyo
**Contact:** cubechatble@gmail.com

If you are in the European Economic Area, the United Kingdom or Ukraine, you
have the rights described in section 11.

---

## 2. There is no account

Cubechat never asks for an email address, a phone number, a real name or a
password, and there is nothing to sign up for.

When you first open the app it generates a cryptographic key pair on your
device. That key pair **is** your identity. Nobody, including us, holds a copy.
Your display name and profile photo are chosen by you, stored on your device,
and sent only to people you actually communicate with.

**A consequence you should understand:** because we hold no account, we cannot
restore your identity, your contacts or your history if you lose the device or
delete the app. There is nothing on our side to restore from.

---

## 3. What stays on your device

All of the following is stored only on your phone, in AES-encrypted databases
whose key is held in the Android Keystore or the iOS Keychain:

- your identity keys and your contacts' public keys;
- your message history, including photos, voice messages and files;
- your display name, profile photo and app settings;
- pinned, archived, hidden and foldered conversations;
- the in-app diagnostic log (the most recent 1000 lines).

**One optional exception, off by default (Android).** If you switch on
*Privacy → Chats in the share sheet*, the display names of your four most
recent conversations with people are given to Android's own shortcut store, so
that they appear as tiles in the system "Share" menu of other apps. They stay
on the phone, are not sent anywhere by Cubechat, and are not shown on the home
screen, but Android shows them to any app's share menu and the app lock does
not hide them. Archived, hidden and not-yet-accepted conversations are never
given. Switching the setting off, or erasing the app's data, removes them.

This history stays on the phone unless you choose a message and tap Report; that report sends only the selected excerpt described below. Local copies are removed when you uninstall the app, use
**Emergency Wipe**, or when the **dead man's switch** you configured fires.

The diagnostic log stays on the device unless you deliberately export it and
send it to somebody. It contains public key fragments, timings, transport
states and error messages. It does **not** contain message text, photos or
your location.

---

## 4. What travels between phones

### 4.1 Over Bluetooth (the default)

Messages between nearby phones are encrypted end-to-end using the Noise
Protocol (XX and IK patterns) with X25519, ChaCha20-Poly1305 and BLAKE2s, and
signed with Ed25519. They pass directly from one device to another, or hop
through other Cubechat devices that cannot read them.

The Bluetooth identifier the app advertises **rotates periodically**, so a
passive observer cannot follow one device across the day by its address alone.

Anyone within Bluetooth range can observe that a Cubechat device is present and
that encrypted traffic is occurring. They cannot read it.

### 4.2 Over Nostr relays (on by default, and you can switch it off)

When **Internet fallback** is on, a message the mesh could not deliver is
published to public Nostr relays, which forward it to the recipient. The relay
receives the message already sealed and signed; it cannot decrypt it.

**A relay does learn metadata, and this is the most important disclosure in
this policy:** it can see which two Nostr public keys exchanged a frame, when,
and how large it was. The Bluetooth mesh does not leak this.

This feature was off by default until September 2026 for exactly that reason.
It is now **on by default**, because with it off a message to somebody out of
Bluetooth range simply does not arrive until you are near each other again. You
can turn it off at any time in Profile → Internet fallback, and **Emergency
Wipe** switches it off too.

The relays are operated by unrelated third parties, not by us. The default list
is editable in the app.

**One relay is ours and carries no private messages:**
`relay.cubechat.tech/area`, the public **area chat** (section 6a). It is built
into the app, cannot be changed, and is used only while an area chat screen is
open. Nothing private is ever sent to it.

### 4.3 Group rooms

A room's key is derived from its name and password. Anyone who knows both can
read the room. Rooms are not forward-secret, and a room password is only as
good as the care taken in sharing it.

### 4.4 AirDrop (sending files to someone nearby)

Files you send someone nearby through AirDrop travel directly between the two
phones, by default over Bluetooth like any other message. They may also
travel over the local Wi-Fi network when both phones are on one, encrypted
with a key that exists only for that transfer; no server is involved.

**While the AirDrop page is open, or "Everyone" is switched on for receiving,
your phone can be found by people nearby** even if "Discoverable nearby" is
off in your profile. For that time it answers Bluetooth handshakes from phones
it does not know, and sends its signed announcement unencrypted — your public
key, nickname and profile picture — to the phones it is linked to, which pass
it on through the mesh. Holding two phones together on the AirDrop page also
makes your phone connect to the other one by itself, so the two can exchange
files or contact cards. When you leave the page (or "Everyone" switches itself
off after ten minutes), your phone goes back to answering only people who
already know it.

---

## 5. The push notification service

To wake a phone whose app is fully closed, Cubechat runs one small service at
`push.cubechat.tech`. This is the only server we operate; the same machine also
relays voice and video calls, described in section 5.1.

**It is on by default, and you can switch it off.** It never sees message
content.

Your phone's operating system asks separately before any notification can be
shown, and if you decline there, nothing is registered at all. Turning the
switch off in the app deletes your entry from the service. Before September
2026 this feature was off until switched on; it now starts on, because a
messenger whose notifications only work while it is already open is not doing
the job.

For each phone that registers, it stores:

| What | Why |
|---|---|
| Your Nostr public key (`npub`) | The address to watch for incoming mail |
| The APNs or FCM device token | The address of the phone to ring |
| Language code (`en` or `uk`) | So the banner is in a language you read |
| Platform (`ios` / `android`) | To choose between Apple and Google |
| Which Apple host answered | To avoid a wasted round trip on every push |
| Timestamp of the registration | So a stale entry can be replaced |

The service watches the relays for events addressed to your public key and asks
Apple or Google to ring your phone. **The banner text is a fixed string** —
"New message" or "Нове повідомлення" — because the service cannot decrypt
anything and has nothing else to say. The message itself is fetched and opened
by your phone.

Registrations are cryptographically signed, so nobody can register a token
against somebody else's key. Turning the feature off in the app deletes your
entry from the service. Uninstalling the app leaves the entry until the token
is refused by Apple or Google, at which point it is deleted automatically. An
entry not renewed for 60 days — the app renews it every time it starts — is
deleted as well.

**Apple and Google are involved.** Apple Push Notification service (iOS) and
Firebase Cloud Messaging (Android) receive the device token and the fact that a
notification was sent. They do not receive message content. Their own privacy
policies apply to that processing.

Server logs are kept for operational purposes and contain shortened public key
fragments and delivery outcomes, not content.

**Your IP address**, on a registration, a call-server login or a report, is
used only in the server's memory, for at most an hour, to limit how often such
requests can arrive, and is not written to disk. The cubechat relay likewise
holds in memory the IP address of a phone publishing to it, so that no single
address can fill its disk.

### 5.1 Voice and video calls

A call is set up with encrypted messages, like any other message, and its
audio — and in a video call, the camera picture — is carried through a call
relay (TURN) on the same server. Both are encrypted between the two phones
(DTLS-SRTP); the relay forwards them and can neither hear nor see them. The
camera is used only during a video call, and only while its button is on.

**The relay does see network metadata:** the IP addresses of both phones, when
a call took place, how long it lasted and how much data it carried. To use it,
your phone asks the service for short-lived access with a request signed by
your key. We do not record calls. The relay's server logs, kept for operating
and securing the service, can contain those IP addresses and session times;
they never contain audio or video.

By default both phones only ever see the relay's address, not each other's. If
you turn on **direct calls** in your profile, a call may connect phone to phone
instead, and then the other person's phone can see your IP address.

**Calls on a computer.** CubeChat for Windows and for the Mac makes and takes
calls the same way, through the same relay; everything above about phones
applies to it.
When a computer is signed in with your phone's account, a call rings on both,
and only one call can be on at a time: the device that has a call tells your
other devices so, with a short message sent through the internet relays to
your own key and encrypted to it. It says only that a call is on, declined or
over, and when; nobody but your own devices can read it. Because nothing can
wake a computer the way a push wakes a phone, CubeChat for Windows starts when
you sign in to Windows and keeps running in the notification area with its
window closed, until you choose Quit there; you can switch the start off in
Profile → Notifications & calls. This sends nothing anywhere new: it only keeps
the same relay connection open.

**Your devices.** The devices signed in with one account tell each other they
exist — each one's name, kind (Android, iPhone, Windows) and when it was last
online — with the same kind of message, sent through the relays to your own
key and encrypted to it, so Profile → Data → Devices can list them. Signing a
device out there sends it a message to erase CubeChat's data on it, which it
does the next time it goes online. When you change your nickname or profile
picture on one of them, the new name and picture are sent to the others the
same way — through the relays, to your own key, encrypted to it — so every
device shows the same profile.

The conversation is kept the same on all of them in the same way. What you
send from one device — a message, an edit, a deletion, a reaction, a pin —
is also sent to your other devices, together with how far you have read each
chat and the keys and names of the contacts you write to, all through the
relays to your own key and encrypted to it. When relays are on, a message
that reached your phone only over Bluetooth is passed on to your other
devices the same way, as the same encrypted message it arrived as. With
relays off, nothing that arrived over Bluetooth leaves the phone. None of
this happens on a device that is the only one on its account.

**Changing your keys.** If you choose Change account keys on your phone, each
of your contacts is sent your new public keys, signed with your old and new
keys and encrypted to them, so their copy of your chat moves to the new keys;
your other devices are signed out; and, if you have a @name, our name server
moves it to your new key. Your old private keys are then deleted from the
phone.

---

## 6. Location

Cubechat uses your location for three things, and only when you ask for them:
sending a location into a chat, showing yourself on the map to friends, and
the public area chat (section 6a), which uses only your approximate district.
**Nothing is shared until you choose to.** The app does not ask for location
during the first-run introduction.

**Showing yourself on the map.** This is off until you turn it on. Before it
turns on, the app asks whether you allow your location to be shown on the map,
and you can decline. It asks again if you turn it off and later back on.

- Your location on the friends map is shown **only to the contacts on your
  map**: people you invited, or whose invitation you accepted. Your position
  on the friends map is never shown to strangers, to people nearby, or
  publicly. (The area chat in section 6a is a separate, public feature that
  never uses or reveals your map position.)
- It is sent **end-to-end encrypted**, the same way as a message. We never
  receive it, and neither do the relays that carry it.
- While it is on, your pin **keeps updating**, including while Cubechat is in
  the background, so friends see where you are rather than where you last
  opened the app. Each update expires on their map after six minutes if no
  newer one arrives.
- **Hide** on the Map tab, or the switch in Profile, turns it off in one tap
  and withdraws your pin from every friend's map at once.

**Background location ("Always").** Only requested once you have agreed to be
shown on the map, and only used to keep that pin current. Granting it is
optional: without it, your pin updates only while Cubechat is open.

**Blocking.** You can block any contact from their profile. A blocked contact
receives no location from you, a pin you had already shown them is withdrawn at
once, and their location is not drawn on your map.

**Sending a location in a chat** reads your position once and sends it, like a
message, to the chat you chose, for the time you choose.

**Third parties who see something:**

- **Map tiles** are fetched from OpenStreetMap, Esri ArcGIS, OpenTopoMap or
  Google Maps, depending on the layer you pick; the dark layer is
  OpenStreetMap's tiles, darkened on the device. Those servers see your IP
  address and which map squares you asked for — which reveals roughly where
  you are looking, though not necessarily where you are. On a computer the
  map always comes from the first three, since Google's map has no
  Windows version. A computer only shows the map: it never reads or sends its
  own location, even when the phone it was signed in from shares one.
- **Reverse geocoding** (turning coordinates into a street name) is performed
  by the operating system's own geocoder — Apple's or Google's — which
  receives the coordinates being named.

Neither of these is avoidable while a map is on screen, and neither is reached
unless you open the Map tab.

---

## 6a. Area chat and notes (public)

The **Nearby chat** button on the Map tab opens public chats of your district,
city and region, and notes people leave on the map for up to a week. **This is
public, not encrypted, and not private messaging.** It is a phone feature only.

**Before anything happens.** The first time you open it, the app tells you in
words that it is public and asks you to continue or decline. Until you
continue, it asks for no location and connects nowhere. Profile → Privacy &
security → *Area chat* switches it off altogether: the button disappears and
the feature never reads your location or connects.

**Your location.** Approximate location is enough (Android's coarse location,
iOS's reduced accuracy). It is read once when the screen opens and every five
minutes while it stays open — **never in the background**, and "Always" is not
needed. The phone turns the reading into a geohash cell of about 5 × 5 km (your
"district") straight away; the coordinates themselves are neither sent nor
kept. Place names ("Podil", "Kyiv") come from your phone's own geocoder, asked
about the centre of the cell, not about where you are.

**What leaves your phone, and to whom.** Everything goes to our own relay,
`relay.cubechat.tech/area` — never to public relays.

- **What you read:** to show you the chats, the phone asks the relay for
  messages of your city-sized cells (about 39 × 20 km; the four around your
  district at most) and your region (about 156 km). The relay never sees
  anything finer than that from reading alone. If you open another city from
  the map ("Read here"), the relay learns which city you are reading; nothing
  else is sent for it, and you cannot write there.
- **What you write:** a message carries its text, the city or region it
  belongs to, a temporary name, a temporary key and the time. A message in the
  *district* chat also carries your district cell (about 5 km) — only because
  you typed it into that chat. Anyone who reads that place can read it, and so
  can we, as the relay's operator.
- **Notes:** a note carries its text, your city, a key used for that note
  only, and a time rounded to ten minutes. It carries a district only if you
  pin one on the map yourself; it never takes one from your location.
- **"Show that I'm here"** is **off by default**. When you turn it on, while a
  city or region chat is open, the phone sends a small signal about once a
  minute to that level only, so people there see "≈N here". It is symmetric:
  with it off you send nothing and do not see the count either. It never
  exists for a district.

**Who you are there.** You write under a temporary name like "Cube-4F2A" and
a temporary key, random and **not derived from your account**: a new one at
least every six hours, for each place and level, and whenever you tap *New
name*. Your @name, nickname, photo, contacts and account keys are never shown
or used. If you set your own name and use the same one in two places, the app
warns you that it links them. There are no private messages, delivery or read
receipts, or "typing" signals in the area chat, and nothing is ever sent
automatically in reply to what you receive.

**How long it is kept.** Messages are kept on our relay for **24 hours**,
notes for 1 hour, 24 hours or 7 days as you choose (**7 days at most**); you can
delete your own note earlier. On your phone, the area chat keeps only its own
switches, your current temporary keys (until they expire), the authors you
blocked there (for a day) and your own notes until they expire. What you read
there is held in memory only and never written to disk.

**What we, the relay operator, see.** Cubechat has no Tor, so **our relay sees
the IP address of a reader next to the city they subscribe to, and of a writer
next to what they write**. We do not log it: the `/area` route keeps no access
log, its limits per address are counters in memory, and no address is stored
with any event. For the same reason there is **no ban by IP address**:
moderation removes events and refuses keys.

---

## 7. Camera, microphone, photos and files

These permissions are used only for what you explicitly do: take a photo to
send, record a voice message, attach a picture or a document. Nothing is
captured in the background, and nothing is uploaded anywhere except to the
conversation you send it to, encrypted.

The **walkie-talkie** uses the microphone only while you hold its button. What
you say goes, in 300 ms pieces as you speak, to phones nearby over Bluetooth,
end-to-end encrypted with the key of the radio group (from its name and
password) or of the contact you are talking to. It is never kept in a
store-and-forward queue and never saved on your phone or theirs: it is played
as it arrives and then gone.

If you have switched relays on, the same encrypted pieces also go through our
own relay (`relay.cubechat.tech`) while the walkie-talkie is tuned to a group
or a contact, so people out of Bluetooth range can hear you. The relay hands
each piece to whoever is listening on that channel at that moment and keeps
nothing: it is sent as a Nostr ephemeral event, which the relay does not store.
The relay sees an 8-byte channel label (fixed for a group; changing every hour
for a contact), a one-time key made fresh for each connection rather than your
identity, the size and time of each piece, and your IP address. It cannot hear
what is said or tell who you are talking to. With relays off, the
walkie-talkie stays on Bluetooth only.

Media you receive is stored inside the app's private container.

---

## 7a. Reports and moderation

When you tap Report, the app sends a signed complaint over HTTPS to our push
service. It contains your public signing key, the reason and optional note,
the reported person's public identity key (and their Nostr public key, when
your phone knows it) or channel-author fingerprint, and, if you reported a
specific message, its type, time and selected text or caption (up to 4,000
characters; a shared location or contact card goes as its one-line label, not
its contents). A channel report also names the channel. Nothing is
sent for an ordinary message you do not report. If you are offline, the report
waits in encrypted storage on your phone for up to seven days and is signed
again when delivery resumes.

The developer reviews reports through a private Telegram moderation bot. The bot forwards the reason, note, a shortened reporter and target key, and up to 1,000 characters of the selected message excerpt to Telegram, a third-party service. The
server keeps the report until it is decided, then deletes it 90 days after
the decision; an undecided report is kept until it is. A decision to
ban publishes a signed list containing public identity keys, Nostr public keys
and channel-author fingerprints only. Every app can download that public list
to suppress banned senders. The list never contains report text or your note.
The banned key itself stays on that public list until the developer lifts the
ban — the 90-day deletion above is for the report, not the ban.

**The ban list download.** Every copy of the app fetches that list from
`push.cubechat.tech/banned` when it starts and every six hours while it is
open, whether or not push or the relays are switched on. The request carries
nothing about you — no key, no token — only what any connection shows, your
IP address. The list is the same for everyone.

The offensive-content filter runs on your phone only. Nothing about what it
folds is sent anywhere.

**Reports from the area chat** (section 6a) are **not** signed with your
account key: each is signed with a key made for that one report, so the report
service does not learn which account was reading which city. Such a report
carries the reason and optional note, the author's temporary area key, the
message's event id and text, and the city or region it was published under.
Its address is limited to ten reports an hour. A decision to ban removes the
message from our area relay and refuses that temporary key; it is published,
signed, at `push.cubechat.tech/banned/area` (event ids and temporary keys of
the last 24 hours only), which the app fetches when the area chat opens and
every ten minutes while it stays open.

---

## 7b. Cube ID — a short @name (optional)

In Profile → Cube ID you can take a short name such as `@dima`, so people can
find you without a QR code. It is not an account: there is no password, e-mail
or phone number, and the name belongs to the key on your phone.

**What `id.cubechat.tech` keeps while you have a name:** the name itself; your
public contact card — the same public keys, nickname and avatar digest a QR
code carries; your "Who can message me from the internet" setting; when the
name was taken and last renewed. Every change is signed by your key. After a
rename the old name keeps pointing at you for 30 days (the server remembers
the old name and your Nostr key) so nobody else can take it. The ids of signed
requests are kept for up to an hour to stop replays. An offensive name removed
by a moderator stays on a list of blocked names, with the reason, so it is not
handed out again.

**The name is public.** Anyone who knows it gets your contact card and can
write to you — unless you choose "Nobody", and then the server hands out no
card at all. There is no reverse lookup from a key to a name, and no directory
of names. The name and your Nostr key are also answered under the Nostr NIP-05
standard (`id.cubechat.tech/.well-known/nostr.json`).

**A recovery e-mail, if you give one.** In Cube ID you can add an e-mail
address so the name can come back to a new phone if you lose this one. The
server keeps that address next to your name and uses it for two letters only:
one to confirm the address, and one when somebody asks to move the name to a
new phone — the name moves 48 hours after the link in it is opened, and your
old phone, if you still have it, can cancel within those 48 hours. The letters
are sent through Resend (Resend, Inc., USA), which receives the address and the
letter's text to deliver it. An address nobody confirmed is deleted after a
day; a confirmed one is deleted when you remove it, release the name, or the
name expires. A recovery request answers the same whether or not the address
matches, so it cannot be used to find out whose address is whose.

**Your IP address** is used only in the server's memory to limit request
rates, and is not written to the name database.

**How long it is kept.** The app renews the name once a week; a name not
renewed for 6 months (for example, a lost phone) is deleted. "Release" deletes
it at once. Emergency Wipe also tries to release it but does not wait for the
server longer than three seconds — offline, the name disappears after 6
months. The name of a banned key is removed. Backups of the name database are
kept for 14 days.

---

## 8. What Cubechat does not do

- **No analytics.** No Firebase Analytics, no Crashlytics, no Sentry, no
  Amplitude, no Mixpanel — none of it, and no home-grown equivalent.
- **No advertising and no ad identifiers.** The app does not read the IDFA or
  the Android advertising ID.
- **No tracking as Apple's App Tracking Transparency defines it.** Nothing is
  linked to you or your device for advertising, and nothing is shared with a
  data broker.
- **No selling or sharing of personal data.** There is nothing to sell.
- **No server-side content scanning.** We cannot read ordinary messages; the design makes it
  impossible rather than merely forbidden. The **area chat** is the exception
  by design: it is public, and we can read it like anyone else (section 6a).

---

## 9. Backups and transfers

Cubechat can produce an **encrypted backup** of your conversations and an
encrypted **phone-to-phone transfer**. Both are protected by a passphrase you
choose, and both stay under your control — the file goes wherever you put it.

If you lose the passphrase, the backup cannot be recovered. We do not hold a
key.

**Phone to phone, and phone to computer.** A transfer between two phones, or
copying your account to the Windows app (*Data → Connect a computer*), goes
directly between the two devices over the local Wi-Fi network; it does not pass
through any server of ours. It is encrypted with a random password and a
one-time token that exist only in the QR code shown on the receiving screen,
and the code works once. A computer that receives your account holds a copy of
your keys and can read what is addressed to you, as your phone can; the phone
keeps working.

---

## 10. Deleting your data

- **Uninstall the app.** Everything on the device goes with it, including the
  keys. This is irreversible: reinstalling produces a *new* identity, and
  existing conversations cannot be resumed.
- **Emergency Wipe** does the same from inside the app, and switches the
  internet fallback back off. It also switches the area chat off and erases
  its temporary keys and your notes' keys.
- **Area chat** — your own note can be deleted from the relay before it
  expires (*Delete my note*). Messages cannot be recalled; they expire on our
  relay after 24 hours.
- **The dead man's switch**, if you configured one, wipes the device after the
  period of inactivity you set.
- **Push registration** is deleted from our service when you switch push off.
- **Cube ID** — Profile → Cube ID → "Release" deletes your name and card from
  `id.cubechat.tech` at once (see section 7b).
- **Nostr relays** are third parties with their own retention. A frame already
  published cannot be recalled from them by us. It is ciphertext, and relays
  typically expire events after a period of their choosing.

---

## 11. Your rights

If the GDPR, the UK GDPR or Ukraine's law on personal data protection applies
to you, you have the right to access, correct, erase, restrict and port your
personal data, and to object to processing.

Push registrations can be erased by switching push off. Submitted reports are
also held by our service; contact us to request access or deletion. The call relay in section 5.1
keeps connection metadata only for operating and securing the service. For anything else, or to
complain, use the contact address in section 1. You may also complain to your
national supervisory authority.

**Legal basis**, where one is required: consent for the push service and for
location sharing. Both are revocable at any moment from inside the app, and
both sit behind an operating-system permission prompt that you answer yourself
— declining it means nothing is collected, whatever the in-app switch says.
Legitimate interest covers keeping the push service secure and operational and
reviewing abuse reports you choose to submit.

---

## 12. Children

Cubechat is intended for adults aged **18+**. It is not directed at
children. If you believe a child has provided us with personal data — which,
given section 2, could include a push registration or a submitted report — contact us and it
will be deleted.

---

## 13. Security, honestly stated

Cubechat is built to be private and its cryptography is implemented against
published test vectors. It is not audited by a third party, and you should
weigh that.

Known limitations, stated plainly because you deserve to know them:

- **Group rooms are not forward-secret**, and their key is derived from a
  name and a password.
- **Received media is stored decrypted** inside the app's private container,
  protected by the operating system's app sandbox rather than by a second
  layer of encryption.
- **Relay metadata is real**, as described in section 4.2.
- **A phone that is unlocked and in someone else's hands** can read Cubechat,
  as it can read any messenger.

---

## 14. Changes

If this policy changes materially, the app will say so and the date at the top
will change. The current version is always published at
`https://cubechat.tech/privacy`.

---

## 15. Contact

Write to **cubechatble@gmail.com** with any question about this policy, to
exercise a right described in section 11, or to report a security problem.
