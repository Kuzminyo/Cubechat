# Cubechat

**Encrypted, anonymous messaging over a Bluetooth Low Energy mesh, with the
internet as a fallback rather than a requirement.** No accounts, no phone
numbers. Inspired by [bitchat](https://github.com/permissionlesstech/bitchat);
built in Flutter with a glassmorphism UI.

Two phones in Bluetooth range talk directly. Phones out of range are reached
over multi-hop relay through the phones in between, and when the mesh cannot
reach someone at all, the same sealed frame goes out over Nostr relays.
Everything private is end-to-end encrypted; the only identity is a
cryptographic key you generate on first launch.

Two phones in Bluetooth range need no server at all. The features that do use
one — push wake-ups, calls, the media lane, @names, the public area chat — are
listed under [What touches a server](#what-touches-a-server), with what each
server can and cannot see.

---

## Status

Runs on **Android** and **iOS** with real Bluetooth. The **Windows** and
**macOS** apps are linked devices: signed in from your phone, they work over
the relays and have no BLE. Web builds for UI work only.

- [x] M0 — Flutter scaffold, glass design system, EN/UK i18n, mock chat UI
- [x] M0.5 — Smooth animation pass (aurora drift, hero avatars, bubble entrance, sliding nav)
- [x] M1 — BLE central scanning (`flutter_blue_plus`), permissions, peer discovery UI
- [x] M1.5 — Native peripheral mode (Swift + Kotlin via MethodChannel)
- [x] M2 — Noise Protocol XX handshake + ChaCha20-Poly1305 transport
- [x] M3 — Multi-hop mesh relay + message dedup + store-and-forward outbox
      *(LZ4 compression intentionally dropped — it defeats the length-hiding
      padding and is a CRIME/BREACH-class leak with encryption)*
- [x] M4 — Local message store (Hive), key storage (flutter_secure_storage)
- [x] M5 — Emergency wipe, IRC-style commands, image + voice transfer (signed manifests)
- [x] M5.5 — Group channels, receipts/reactions, message edit/delete, reply/quote, block/mute peers
- [x] M6 — Nostr internet fallback (see below)
- [x] M6.5 — Contact cards: open a chat with someone who has never been in BLE range
- [x] M7 — Rotating peer IDs + sealed announcements (Profile → Discoverable nearby)
- [x] M7.5 — Noise IK: a stranger who dials you no longer learns your static key

Shipped since, outside the milestone numbering: voice and video calls, the
walkie-talkie, the map and public area chat, AirDrop to people nearby, linked
desktop devices, encrypted backup and transfer, Cube ID @names, and reporting
and moderation. The test suite (`flutter test`) includes known-answer vectors
for the crypto.

> The one thing the test suite can't prove is real radio behaviour: two-phone
> BLE range/reconnect and a live public relay both need hardware.

---

## Features

**Messaging**
- 1:1 chats with delivery **and read receipts**
- Emoji **reactions** on any message — long-press for the picker, or
  **double-tap** for a heart when that's all you meant
- **Replies** — **swipe a message left** (or long-press → Reply) to quote it;
  the quote rides in the envelope
- **Edit** your own messages (inline, Telegram-style) and **delete** them —
  *for me* (local) or *for everyone* (retracted over the wire)
- **Voice messages** — hold the mic to talk and release to send, **slide up to
  lock** it hands-free, **slide left to discard**; live waveform while
  recording. A locked recording gets a **trim editor** first (drag either end
  of the waveform, preview the selection, then send). The cut is a native
  re-mux, so it is lossless and best-effort: if a device can't do it, the
  untrimmed recording is sent rather than nothing
- **Images, files and stickers** — chunked, with a signed manifest and SHA-256
  reassembly check; a batch of photos arrives as one album. View-once media,
  pinned messages, and forwarding
- **In-app gallery** — a custom multi-select photo picker (send several at once)
  and a Telegram-style swipeable full-screen viewer with pinch-zoom, save and
  share
- **Group channels** — shared-key rooms broadcast across the mesh *and* over the
  relays, so a room works between people who are nowhere near each other
  (`/join #room`), with admins, polls and history for late joiners
- **Channel invites** — hand a peer the channel key over their 1:1 encrypted
  link, or as a QR code
- **Favorites**, folders, archive, real unread tracking (badge + highlighted
  tile that clears when you open the chat), search, and rich **MessagingStyle
  notifications** with the sender's avatar and an inline **Reply** box
  (suppressed for the chat you're actively reading)

**Calls and the walkie-talkie**
- **Voice and video calls** — set up inside the encrypted envelope
  (`callSignal`), media encrypted end to end (DTLS-SRTP) and carried through our
  TURN relay, which forwards it but cannot hear or see it. CallKit on iOS, a
  full-screen incoming call on Android. Phone-to-phone calls without the relay
  are opt-in, because they show each side the other's IP address
- **Walkie-talkie** — hold to talk to a radio group or a contact; speech goes
  out in 300 ms pieces over Bluetooth, is played as it arrives and is never
  stored. With relays on it also travels through our relay as ephemeral
  events, which the relay forwards and does not keep

**Places**
- **Friends map** — off until you turn it on; your position goes end-to-end
  encrypted to the contacts on your map only, and a pin expires after six
  minutes without an update. A location can also be sent into any chat
- **Area chat** — public chats of your district, city and region, and notes on
  the map. Public and unencrypted on purpose; see
  [Area chat](#area-chat--public-and-built-so-it-does-not-leak-place) for how
  it avoids giving away where you stand

**Nearby and your own devices**
- **AirDrop** — send files and contact cards to someone nearby, over
  Bluetooth or the local Wi-Fi with a key made for that one transfer; hold two
  phones together to connect them
- **Linked devices** — sign a Windows or Mac app in from your phone; messages,
  edits, read state and profile stay in step through the relays, encrypted to
  your own key. A device can be signed out (and wiped) from the phone
- **Encrypted backup** — by hand or daily to a folder you choose, under a
  passphrase only you hold; phone-to-phone and phone-to-computer transfer go
  over the local Wi-Fi through a one-time QR code
- **Cube ID** — an optional short `@name` so people can find you without a QR
  code; not an account, and "Nobody" hides your card from lookups

**Trust & privacy**
- **Out-of-band verification**: compare two fingerprints in person to confirm no
  man-in-the-middle; verified peers get a shield badge
- **Key-rotation warnings**: if a peer's signing key changes, the chat flags it
  and asks you to re-verify
- **Anonymous by default**: no device name is ever broadcast; unnamed peers show
  as `Anonymous <tag>` where the tag is derived from their public key
- **Block / mute** a peer — blocked peers' messages are dropped on arrival,
  muted peers arrive silently
- **Emergency wipe**: triple-tap the CubeChat title on the Chats tab (or type
  `/wipe yes`) to erase every key, peer, and message
- **Notification preview**: name and text, name only, or nothing — a banner is
  drawn on the lock screen and read by apps with notification access, which the
  app lock does not cover
- **Reports and moderation** — report a message or a person; bans are published
  as a signed list every app checks, and the offensive-content filter runs on
  the phone only

**Transport**
- BLE **central + peripheral** — every phone both scans and advertises
- **Multi-hop mesh relay** with a density-scaled TTL (full depth in a chain, cut
  in a crowd where flooding costs most) and per-message deduplication
- **Store-and-forward**: messages for an offline peer are held (encrypted) and
  delivered automatically when they come back into range
- **Internet fallback (on by default, switchable off)** — when the mesh can't
  reach a peer, the same sealed frame goes out over public Nostr relays
- **Contact cards** — start a chat with someone who has *never* been in
  Bluetooth range: share a signed identity card as text through any other app,
  they paste it, and messages flow over the relay from the first tap
- Automatic reconnect with address-rotation rescan and backoff

**Commands** (IRC-style, typed into any chat)
`/nick <name>` · `/who` · `/join #x [pw]` · `/leave` · `/channels` · `/clear` ·
`/wipe yes` · `/help`

---

## What touches a server

Between two phones in Bluetooth range, nothing does. Everything else is in the
table; [`docs/legal/privacy-policy.en.md`](docs/legal/privacy-policy.en.md) is
the full version, each claim checked against the code, and it changes with any
change to what leaves the phone.

| Server | Run by | Used for | What it sees |
|---|---|---|---|
| Public Nostr relays (list editable in the app) | third parties | internet fallback for messages the mesh could not deliver | ciphertext; which two Nostr keys, when, how large |
| `relay.cubechat.tech` ([`relay/`](relay/README.md), strfry) | us | the meeting point every build listens on; the media lane (`/media`); the walkie-talkie over the internet; the public area chat (`/area`) | the same as a public relay — area chat in the clear, by design; IP addresses in memory only |
| `push.cubechat.tech` ([`push/`](push/README.md)) | us | APNs/FCM wake-ups with a fixed banner; short-lived TURN logins and the call relay; reports; the signed ban list | npub → device token, and that an npub got mail; call IPs and durations, never audio or video; report contents |
| `id.cubechat.tech` | us | Cube ID @names, and an optional recovery e-mail (sent through Resend) | the name and the public contact card it points at |
| APNs / FCM | Apple / Google | delivering the wake-up | the device token, and that a push was sent |
| Map tiles (OpenStreetMap, Esri, OpenTopoMap, Google) | third parties | the Map tab, only while it is open | your IP and which tiles you asked for |

Push and the internet fallback are on by default and each is one switch away;
Emergency Wipe turns the fallback off.

---

## Build & run

Requires **Flutter SDK ≥ 3.27**; releases and CI are built with 3.41.x and
JDK 17. Platform folders (`android/`, `ios/`,
`macos/`, `windows/`, `web/`) are checked in.

```bash
flutter pub get      # also runs gen-l10n (generate: true in pubspec)
flutter test --exclude-tags golden   # the suite as CI runs it, incl. crypto known-answer vectors
flutter run          # pick a target below
```

| Target | Command | BLE | Notes |
|---|---|---|---|
| **Android device** | `flutter run -d <id>` | ✅ central + peripheral | full mesh — two phones see each other |
| **iOS device** | `flutter run -d <id>` | ✅ central + peripheral | needs a Mac to build |
| **Web (Chrome)** | `flutter run -d chrome` | ❌ | UI only; Peers shows "Bluetooth LE not available" |
| **Windows desktop** | `flutter run -d windows` | ❌ | linked device over the relays; needs Visual Studio 2022 + "Desktop development with C++" |
| **macOS desktop** | `flutter run -d macos` | ❌ | linked device over the relays |

Release APKs are built by a script rather than by `flutter build apk` alone:
the script cross-checks the version and proves the build stamp reached the
artifact.

```bash
tool/build_apk.sh             # macOS / Linux: universal APK (--arm64, --bundle for an AAB)
flutter build web --release   # → build/web/ (any static host)
```

> **On Windows** use `powershell -ExecutionPolicy Bypass -File
> tool/build_apk.ps1` — plain `flutter build apk` is broken there (the plugin
> list is written with double-escaped paths). Building for Android on Windows
> also needs symlink support: enable Developer Mode
> (`start ms-settings:developers`).

### iOS builds

iPhones get builds through TestFlight: run `.github/workflows/ios-testflight.yml`
by hand (`gh workflow run ios-testflight.yml -f notes="…"`). The unsigned-IPA
job that ran on every push was removed on 2026-10-31 — the repository is
private, a macOS runner minute counts ten times against the free allowance, and
that job alone was most of every push's minutes.

### Branding

The in-app logo is drawn programmatically by `CubeLogoPainter` so it scales at
any size. Launcher/splash PNGs are generated once:

```bash
flutter run -t tool/export_logo.dart -d macos     # rasterizes the painter (any desktop target)
dart run flutter_launcher_icons
dart run flutter_native_splash:create
```

---

## Security & cryptography

All primitives come from the vetted [`cryptography`](https://pub.dev/packages/cryptography)
package (X25519, ChaCha20-Poly1305, BLAKE2s, HKDF, Ed25519). secp256k1 +
BIP-340 Schnorr (for the Nostr fallback signer) is a self-contained pure-Dart
implementation in `lib/core/crypto/secp256k1.dart` — no extra dependency. The
Noise/X3DH/Nostr-event framing is implemented in-repo and pinned to test vectors.

| Layer | Purpose | Primitive |
|---|---|---|
| **Noise Protocol XX** | Meeting a stranger over a direct BLE link | X25519 + ChaCha20-Poly1305 + BLAKE2s, spec-faithful (§5 SymmetricState, HMAC-BLAKE2s HKDF, correct 96-bit nonce) |
| **Noise Protocol IK** | Calling a peer whose key we already hold — the responder never transmits its own | Same primitives; two messages, with the responder static as a pre-message |
| **X3DH** | Per-message forward secrecy for multi-hop / async delivery | X25519 signed prekeys + ephemeral keys |
| **SealedBox** | Anonymous encryption to a peer we can't hold a session with (relays forward without decrypting) | libsodium-style `crypto_box_seal` |
| **SignedPayload** | Proves message authorship end-to-end | Ed25519 over a route-bound context (origin ‖ dest ‖ msgId ‖ timestamp) |
| **Channel crypto** | Shared-key group rooms | key = BLAKE2s(name ‖ password); ChaCha20-Poly1305; 8-byte public tag selects the room without trial decryption |
| **At rest** | Chat history, roster, keys | AES-encrypted Hive boxes; the AES key + identity private key live in the OS Keystore/Keychain (`flutter_secure_storage`) |

**Two-tier envelope.** Every application message is wrapped as: outer cipher
(SealedBox `0x01`, X3DH `0x02`, channel `0x03`, forward-secret media `0x04`, or
walkie-talkie `0x05` — see the wire protocol below) → inner `SignedPayload`
(Ed25519) → typed inner payload. So relays route without decrypting, the
recipient decrypts, and the signature proves who sent it.

**Not deniable.** That proof is transferable: a recipient holds a signature
anybody can check. The app keeps it beside every signed text it receives and
puts it in a report, so moderation can tell the author's words from a quote
the reporter made up (`SignedPayload.detachedProof`, `verifyAuthorProof` in
`push/src/index.js`). It proves which Ed25519 key wrote the words — not whose
contact that key is, which only the reporter's roster says — so a ban on such
a report goes on the signing key's fingerprint, never on the identity it was
filed under.

**Replay & dedup.** Signed timestamps + a 1-hour replay window; a dedup cache
keyed on `(originPubkeyHash, msgId)` drops loops and reflections across the mesh.

### Rotating peer IDs, and the announcement that has to change with them

The 8-byte id on every frame used to be `BLAKE2s(x25519_pubkey)[0:8]`, computed
once and never again. Anyone recording the air could group a device's entire
history by those eight bytes without breaking a cipher — across BLE address
rotations that exist precisely to stop that. It is now

```
id(pubkey, epoch) = BLAKE2s("cubechat/peer-id/v1" ‖ pubkey ‖ epoch_be64)[0:8]
epoch             = unix_millis ~/ 1h
```

Still deterministic, so anyone holding the peer's public key recomputes it with
no negotiation and no state — which is what lets a recipient recognise its own
mail. But it is only stable for an hour. Receivers accept the previous, current
and next epoch (`PeerId.activeEpochs`): a frame held in store-and-forward, or
sat in a relay backlog, arrives bearing the epoch it was minted in, and phones
are not NTP-synced. The store-and-forward buffer drains *all* of a peer's live
ids for the same reason — draining only the current one would strand exactly the
mail that waited longest. The pre-rotation fixed hash is still accepted on
receive so a staggered rollout survives; nothing mints it any more.

**Rotation alone would have been theatre.** The ids derive from the static
public key, and the mesh announcement broadcasts that key in the clear, with a
full hop budget, to everyone in range and beyond. One overheard announcement and
a listener recomputes every future id forever. So rotation ships with its
counterpart: **Profile → Discoverable nearby**.

| | Discoverable (default) | Off |
|---|---|---|
| Announcement | cleartext broadcast, relayed mesh-wide | sealed per contact, addressed to their rotating id |
| Handshake accepted | XX and IK | **IK only** |
| A stranger in range | learns your key, name, prekey, npub | sees opaque frames to meaningless ids, and gets no answer at all |
| Meeting someone new | walk up to them | they need a contact card |

Default on, because meeting someone by standing next to them is the premise of
the app and silently disabling it would break the Peers screen for a property
most people did not ask for.

### Two handshake patterns, and why

XX puts the responder's static key in its second message. Encrypted, so a
listener cannot read it — but the *initiator* can, and the initiator is whoever
just dialled you. So one deliberate connection hands a stranger the long-term
key that identifies the device forever and from which every rotating id is
derived, undoing both of the measures above.

**IK** (`Noise_IK_25519_ChaChaPoly_BLAKE2s`, `noise_ik_handshake_state.dart`)
never transmits it:

```
  <- s                     pre-message: the initiator already has it
  -> e, es, s, ss
  <- e, ee, se
```

The opener is encrypted under `es` — a DH against the responder's static key —
so producing one that decrypts *is* proof of already holding it. Someone
without it gets no session, no key, and no reply. It is also a round trip
shorter, and the initiator's own key travels encrypted rather than in the clear.

The two are used together: IK whenever we already know who we are calling
(a chat opened from the Chats list, a reconnect within the same run), XX
otherwise. With discovery **off** the responder refuses XX outright, which is
what closes the hole.

> **How a contact finds you.** BLE advertises a service UUID and a rotating
> hardware address — not an identity — so an IK opener had nobody to be
> addressed at. The advertisement now carries the **rotating peer id**: eight
> bytes a contact resolves through the index they already build, and that mean
> nothing to anyone else. Android puts it in service data (a local name there
> would mean renaming the Bluetooth adapter system-wide); iOS puts it in the
> local name, because CoreBluetooth cannot advertise service data at all. It is
> re-advertised when the epoch turns, since a contact computes the current one.
>
> This replaced broadcasting the **nickname**, which was a permanent handle any
> passive scanner could follow forever — and on Android it replaced
> `setIncludeDeviceName(true)`, which was putting the phone's own Bluetooth
> name ("Galaxy S24") on the air, flatly contradicting the anonymity the rest
> of the app is built around.
>
> One standard IK caveat also applies: an attacker who later compromises the
> responder's static key can decrypt a recorded first message and learn *who*
> was calling. Message contents stay safe — transport keys come from the
> ephemerals — and the application layer adds its own forward secrecy on top.

> **Scope note.** Group channels use one shared symmetric key (no per-sender
> forward secrecy — that needs a group key-agreement protocol like MLS, out of
> scope). Author authenticity within a channel still holds via the Ed25519
> signature. The Noise implementation is verified for self-consistency, not
> against the official Noise KATs (fine for cubechat↔cubechat).

### Nostr internet fallback (optional, M6)

When the mesh can't reach a peer, cubechat can push the **same encrypted frame**
through public Nostr relays instead of only holding it in the store-and-forward
buffer. Nostr is a dumb pipe: the frame is already sealed (SealedBox / X3DH) and
signed, so a relay carries ciphertext it cannot read. Lives in
`lib/core/transport/nostr/`.

- **`Secp256k1NostrSigner`** — deterministically derives a stable Nostr key
  from the Ed25519 identity seed (`HKDF-SHA256`, reduced into `[1, n-1]`), so
  no extra key material is persisted; signs NIP-01 events with BIP-340 Schnorr
  (pure-Dart, **pinned to the official BIP-340 vectors**).
- **NIP-01 event model + relay protocol** — canonical event serialization,
  SHA-256 event id, and the client↔relay `REQ`/`EVENT`/`CLOSE`/`OK`/`EOSE`
  framing, including `verifyInboundEvent` (the untrusted-relay gate that
  recomputes the event id and checks the Schnorr signature before anything
  reaches the app).
- **`cc1:` frame codec** — wraps the same encrypted cubechat `Frame` used on BLE
  inside a Nostr event, self-identifying so a shared relay's unrelated traffic
  is cheaply skipped.
- **`WebSocketNostrRelayClient`** — the relay pool: publishes to every connected
  relay, merges inbound events into one stream, de-duplicates by event id across
  relays, and reconnects with exponential backoff (replaying `since` so nothing
  is missed or re-downloaded).
- **Signed announcement carries the address** — the peer announcement (since
  v0x04; v0x05 adds the avatar hash) signs each peer's `npub` alongside the
  signed prekey, so a relay can't swap in its own Nostr address.
- **`MessagingService` bridge** — a frame the mesh couldn't deliver is
  published to the recipient's `npub`; if no relay accepts it, it still falls
  through to store-and-forward. Inbound relay frames re-enter the *same*
  dispatch as a BLE notification, so they get the same dedup, replay window,
  and signature checks.
- **Lanes** — conversation, media and map traffic go to separate relay lists
  (`relay_settings_controller.dart`), so a burst of photo chunks cannot get a
  typed sentence throttled behind it. Conversation also always goes to our
  meeting-point relay, so two people who edited their lists apart still hear
  each other; the media lane starts with our own `/media` inbox, whose
  retention outlives a transfer.

**On by default since build 986, and the cost is unchanged.** A relay never sees
plaintext, but it does learn which two Nostr keys exchanged a message and when —
metadata the BLE mesh never leaks. That was the reason it shipped off, and it is
still true.

What changed is the other side. Off, a message to somebody out of Bluetooth
range does not arrive at all until one of you walks into range of the other, and
a messenger that silently fails to deliver is not private — it is broken, which
is how it kept being reported. So the default flipped: the switch is one tap
away (Profile → Internet fallback), the relay list is user-editable, Emergency
Wipe switches it back off, and a device that has already been switched off stays
off — the new default applies only where nothing was ever stored.

### Area chat — public, and built so it does not leak place

The **Nearby chat** button on the map opens public chats of the district
(geohash 5, ~5 km), city (4, ~39 × 20 km) and region (3, ~156 km), and notes
on the map (`lib/features/area/`, spec
`docs/superpowers/specs/2026-11-02-area-chat-design.md`). It is **public and
unencrypted** by design and never touches the mesh, `MessagingService` or the
private relay pool: plain Nostr events (kinds 1060 message, 1062 note, 21060
presence) on our own `wss://relay.cubechat.tech/area` only, over a socket of
its own (`area_relay_link.dart`) that is open only while an area screen is.

The threat model is bitchat's geohash channels and the findings of a
2026-07-27 security review of bitchat-android against them (H5–H8, M9–M12
below; the table is in the spec's "Уроки bitchat" section — the review itself
is not in this repository):

- **What the relay indexes is never finer than a city.** The `g` tag and every
  subscription filter are 3–4 characters; a district (5) appears only inside
  the content of a message typed into the district chat or a note pinned by
  hand; nothing finer leaves at all, and the fix is coarsened in one function
  and dropped (`checkAreaCeilings`, `coarsenToDistrict`). The district view is
  the district and its eight neighbours, filtered on the phone (M10, H7).
- **Keys are random, per (cell, level), ≤ 6 hours** — never derived from the
  account seed, its Nostr key or the device key — and a note gets a key of its
  own. The name lives in `content`, never in an `n` tag (H8).
- **Nothing is sent in reply to anything received.** No direct messages, no
  receipts, no typing; presence is off by default, only while a city or region
  chat is open, only to that level, and symmetric — off, you see no count (H6).
- **Every inbound event is checked before it reaches memory**: kind and size,
  the id hash, NIP-13 work (12 / 16 / 8 bits), the exact schema, then BIP-340
  off the UI isolate — so a relay cannot make the phone verify Schnorr for
  rubbish, nor speak for anyone (`verifyAreaEvent`, H5). Rooms are bounded
  (300 messages, 500 keys, 100 notes; frames ≤ 64 KiB) (M12).
- **One relay, ours, built in** — no public relays, no catalogue (M9). Its
  honest cost: the operator sees a reader's IP next to the city subscribed
  to. The `/area` route keeps no access log and the policy's per-address
  limits are in memory; there is no ban by IP (`relay/README.md`, "The area
  relay").
- **Moderation** signs area reports with a throwaway key (16 bits of work),
  bans go to a separate signed `GET /banned/area` (never the general
  `/banned`, whose canonical body old builds verify field by field), and the
  relay deletes the event.

### Contact cards — starting a chat with no BLE at all

The fallback above assumes you already know the peer, and until now the only way
to learn someone was to stand next to them: the signed announcement that carries
their keys travelled over Bluetooth and nowhere else. Two people in different
cities therefore couldn't open a chat at all — the relay could have carried the
message, but neither side held the keys to encrypt one.

A **contact card** is that missing handshake, moved off the radio. It is the
*same* signed `PeerAnnouncement` the mesh broadcasts, base64'd into a string you
can send through any other app:

```
cubechat:c1:<base64url(signed announcement)>
```

Because it's the announcement verbatim, there is no second wire format and no
new signing context — importing a card runs the identical
`PeerAnnouncement.verifyAndDecode` gate a mesh announcement does, so a card
edited in transit fails the Ed25519 check before it can reach the roster
(`lib/core/transport/contact_card.dart`). The parser is deliberately forgiving
about *packaging* — surrounding chat text, injected line breaks, a stripped
scheme — and unforgiving about content.

**The reply path.** A card only travels one way: they now hold your keys, but
you hold none of theirs, and an inbound frame carries just an 8-byte origin hash
that cannot be reversed into an identity. So the first thing sent to a peer's
`npub` is our own signed announcement (`_announceOverNostrTo`, once per process
per peer). Without it our message would land in their app attributable to no
chat, and they'd have no address to answer at.

That introduction is **sealed to the recipient**, unlike its mesh counterpart.
On BLE an announcement has to be cleartext — it's addressed to whoever is in
range. A public relay is a different room: events there are readable by anyone
who asks, so publishing the bundle as-is would park a *human-readable nickname*
next to a Nostr pubkey, permanently, for any passive scraper — the one thing
every other frame on this path is careful not to leak. So it goes out as
`[0x01][SealedBox to their X25519 key]` (we have that key — it's what a card is
for), and the tag can't be mistaken for a plaintext announcement, which always
opens with its version byte (`0x04` or `0x05`). It also carries `ttl: 1`: a
point-to-point introduction, not a broadcast, so the receiver decrementing it to
zero stops it being flooded across their local Bluetooth neighbourhood, where
nobody could open it anyway.

> **A card proves consistency, not provenance.** The signature says the bundle
> is internally coherent and unmodified; it says nothing about *who handed it to
> you*. Anyone can mint a card for their own keys under any nickname, and a card
> forwarded through a chat app could have been swapped in transit. So a peer
> added this way starts **unverified** — compare fingerprints in person or over
> a call (Peers → verification) before trusting the identity. Accepting an
> introduction over a relay is likewise trust-on-first-use: it is what lets a
> stranger who knows your `npub` appear in your roster, the same exposure as
> being messageable at all.

---

## Wire protocol

Every BLE write/notification carries one **frame**: `[type:1][payload:N]`.

```
Frame
 ├─ noiseHandshake1/2/3   0x01–0x03  raw Noise XX messages
 ├─ noiseIk1/2            0x04–0x05  raw Noise IK messages
 ├─ transport             0x10       TransportEnvelope:
 │      [originHash:8][destHash:8][msgId:16][ttl:1][body]
 │      body = [cipherTag:1][ciphertext]
 │             cipherTag: 0x01 SealedBox · 0x02 X3DH · 0x03 channel ·
 │                        0x04 X3DH media · 0x05 walkie-talkie
 │             ciphertext → SignedPayload → InnerPayload (~40 types):
 │               messages   text · textReply · edit · delete · pin · forwardedFrom
 │               media      imageChunk · audioChunk · fileChunk · mediaManifest ·
 │                          mediaRequest · albumHint · voiceLevels · radioChunk
 │               state      receipt · reaction · typing · presence · avatar …
 │               channels   channelInvite · channelPoll · channelAdmin · …
 │               other      callSignal · nearbyOffer/Answer/Bump · ownDevice ·
 │                          keyRotation
 ├─ peerAnnouncement      0x20       signed (x25519, ed25519, signed prekey,
 │                                   npub, nickname, avatar hash) broadcast
 ├─ proBadge              0x21       reserved, unused in this build
 ├─ fragment              0x40       [fragId:4][index:1][count:1][slice]
 └─ reset                 0xFE       drop-your-session
```

The full list of inner-payload tags, with what each one carries, is
`InnerPayloadType` in `lib/core/transport/inner_payload.dart`.

`destHash` all-zero = broadcast (announcements, channels). Each relay decrements
`ttl`. Short text is padded to a 48-byte bucket to hide length from passive
sniffers.

**Hop budget scales with density.** A flood costs roughly `fanout ^ hops`, so
the two can't be set independently. With ≤5 links the mesh is a chain and the
full depth of **7** is what makes a distant node reachable at all; at **6+
links** the topology is a cluster, where every extra hop multiplies the copies
in flight while adding almost no reach — so the budget drops to **5**
(`TransportEnvelope.ttlForLinkCount`). The ceiling is applied both when minting
a frame *and* at every forward, using the density of whichever node is relaying:
a frame minted in a sparse corner carries the full budget, and spending all of
it once it reaches a crowd is exactly what turns a message into a storm. It only
ever lowers a ttl, so a deliberately short budget (a relay introduction rides at
1) is never inflated. The trade is real: a node deep in a crowd no longer reaches
a peer more than five hops out — rare in the topology that triggers the cut, and
store-and-forward plus the internet fallback remain as backstops.

**Media chunks are sized for the fragmenter, not for one write.** Matching a
chunk to the link's MTU is the obvious thing and it was badly wrong: every chunk
pays ~124 bytes of envelope, AEAD and chunk header no matter how little it
carries, so on a real 225-byte link a chunk held 101 bytes of photo and 124 of
packaging. A field log caught the result — **1367 chunks for one photo**, over
half the airtime spent on overhead, about two minutes on the radio. Since
fragmentation already splits oversized frames and rejoins them before dispatch,
a chunk no longer has to fit one write: at 4 KiB the same photo is ~34 chunks,
overhead drops under 3%, and both the bytes on air and the number of writes
roughly halve. `bleMediaChunkData` steps the target down on narrow links so the
frame can never need more fragments than the 255 the header can count.

**An album is grouped by what the sender said, not by when photos arrived.**
A batch of photos used to be reassembled into a grid on the receiving side by
a heuristic — same sender, close together, at the batch's own pace — because
nothing on the wire said where a batch began or ended. That reads five photos,
a pause, five more as one run of ten. `sendImageBatch` now announces the batch
first, as an `albumHint` inner payload naming the media ids in it, and the
receiver stamps those photos as one album when they land (or retroactively, if
the relay hands them over in the other order).

It is a payload type rather than a field on the media manifest for a
compatibility reason that runs the other way from the usual one. An unknown
*manifest version* is refused, and refusing a manifest drops the chunks behind
it — a build that predates this would lose every photo in an album rather than
merely fail to group them. An unknown *inner-payload type* is dropped by
itself: the photos arrive, ungrouped, which is exactly what happens today. The
hint is the only thing that can be lost, and losing it costs the grouping and
nothing else.

**MTU-aware framing.** Real iOS↔Android links often negotiate an ATT MTU well
below the ~247 the code once assumed, and a frame larger than the link's usable
payload is silently truncated on the wire (the AEAD open then fails). Media
chunks are sized from the link's actual `negotiatedMtu` (`mtu_budget.dart`), and
any frame that still doesn't fit is split into `fragment` frames and rejoined by
the receiver *before* dispatch (`frame_fragment.dart`) — transparent to dedup,
replay and relay. The native peripheral side (Swift/Kotlin) queues notifies and
drains them on the BLE "ready to send" callback, so a media burst no longer
overruns the transmit queue and aborts the transfer.

**Walkie-talkie chunks are broadcast, and nothing keeps them.** A press of the
radio button becomes 300 ms `radioChunk` inner payloads (`0xEC`) under their
own envelope cipher tag, **`0x05`**: `body = [0x05][tag:8][ChaCha20-Poly1305]`,
always a broadcast (`destHash` all zero), ttl at most 3. A group's key is
`BLAKE2s(name ‖ password)` on a radio domain (never equal to the text channel
of the same name); a 1:1 pair's key comes from static-static X25519 between the
two identity keys, behind a tag that rotates with the hourly peer-id epoch.
1:1 voice is a broadcast too, on purpose: every phone that relays a frame
*addressed* to somebody keeps a copy in its store-and-forward cache, and a few
seconds of voice there pushed out the mail a neighbour was carrying. Chunks are
never stored, queued or published to Nostr — voice late is worse than none.
The Ed25519 signature covers the tag, so a chunk signed for one group or pair
cannot be re-sealed into another and verify as the same speaker. A phone outside
the group, or not tuned to it, forwards the frame and drops it without a word
and without any crypto: only the channel the radio is tuned to is opened. An
older build never sees the `0xEC` inside — it sits inside `0x05`. It forwards
the `0x05` broadcast (that happens before the cipher is read) and logs one
collapsed `[CRYPTO] drop transport … unknown cipher tag 0x5` line for the
first copy of each frame; the third hop logs `ttl exhausted`.

---

## Architecture

Flutter + Riverpod (Notifier pattern), `go_router` with a `StatefulShellRoute`
so tabs keep their state. The floating glass nav bar and chat-input capsule are
overlays, not welded plates — and so is the chat header: it has no `AppBar` at
all. Header capsule, pinned island and composer are three siblings of the
message list inside one `Stack`, each carrying the same glass, with the list
padding itself top and bottom to clear them. That padding is *measured* rather
than guessed, because both ends change height (the composer grows with
multi-line text and the reply island, the header gains and loses the pinned
bar). The effect is that the conversation runs edge to edge behind them instead
of starting below a bar, and nothing ever shows a band of empty backdrop between
the islands and the chat. It also fixed a real bug for free: the pinned island
appearing used to re-parent the list, detaching the scroll position and snapping
the conversation to the bottom mid-read.

The animated aurora backdrop is a single
`CustomPainter` so it never rebuilds the widget tree, and its drift runs off a
~30 fps wall-clock ticker (paused while backgrounded) rather than every vsync —
the blobs rebuild four shaders per paint, so at 120 fps on ProMotion it ran the
GPU hot even while the app sat idle.

```
lib/
├── main.dart · app.dart               # entry, MaterialApp.router, lifecycle
├── app/              # where core meets the features: bindings.dart (what the
│                     #   transport needs from them), router and shell,
│                     #   emergency wipe, key rotation, iOS background refresh
├── core/             # imports no feature (test/architecture_test.dart);
│   │                 #   transport/ports/ is what it needs from them
│   ├── crypto/       # Noise (XX, IK), X3DH, SealedBox, SignedPayload, prekeys,
│   │                 #   channel crypto, identity
│   ├── transport/    # messaging service, envelope, frame, dedup, store-forward,
│   │                 #   chat sessions, inner payloads, peer ids, call signal,
│   │                 #   radio chunks, inbound/ (the registry features answer
│   │                 #   payloads through), nostr/ (signer, frame codec, relay
│   │                 #   protocol + WebSocket relay pool)
│   ├── models/       # Message, Channel, KnownPeer, DiscoveredPeer
│   ├── ble/          # scanner, peripheral bridge, permissions, constants
│   ├── audio/        # Opus voice codec + Ogg container, radio audio
│   ├── storage/      # encrypted Hive boxes + AES cipher provider
│   ├── identity/     # nickname, anon naming, avatar
│   ├── notifications/· locale/ · routing/ · theme/ · widgets/ · desktop/ · util(s)/
├── features/
│   ├── chats/        # chat list, folders, archive, requests, search
│   ├── chat/         # conversation screen, bubbles, input, voice, commands
│   ├── channels/     # group channels: model, admin, polls, history
│   ├── contacts/     # contact list
│   ├── peers/        # Nearby discovery, peripheral controller, verification
│   ├── call/         # voice and video calls (WebRTC over our TURN, CallKit)
│   ├── radio/        # walkie-talkie
│   ├── map/ · area/  # map, shared locations, public area chats and notes
│   ├── airdrop/      # send to people nearby (bump, Wi-Fi lane)
│   ├── files/ · stickers/ · share/ · qr/
│   ├── cube_id/      # @names registered with the Cube ID server
│   ├── devices/      # linking your own second device
│   ├── backup/       # backup files, phone-to-phone and desktop transfer
│   ├── moderation/   # reports, ban list, terms, filters
│   ├── onboarding/
│   ├── desktop/      # desktop rail and split view
│   └── profile/      # settings, identity, customize, diagnostics, relays
└── l10n/             # ARB files (19 locales)
```

### Peripheral mode

`flutter_blue_plus` is central-only, so the peripheral side is a thin
`MethodChannel` bridge to native code:

- **Android** — `CubechatBlePeripheralPlugin.kt` uses `BluetoothLeAdvertiser` +
  `BluetoothGattServer` (service UUID in the primary packet, the rotating peer
  id as service data in the scan response, never the device name). Registered
  in `MainApplication.kt`.
- **iOS** — `CubechatBlePeripheralPlugin.swift` does the same with
  `CBPeripheralManager` (the rotating peer id goes in the local name),
  registered in `AppDelegate.swift`.

Discovery — scanner and peripheral together — starts at app launch on a phone
(permissions/adapter permitting), not when the Peers screen opens: a phone that
launched into Chats and stayed there used to hold no links at all. The scan
cadence stays idle until someone is watching the Nearby list or a delivery is
owed.

### Background delivery on aggressive OEMs (Xiaomi/MIUI, etc.)

BLE delivery while the app is backgrounded needs the OS to keep the process
alive. Most phones are fine once **Background mode** is on (Profile → Background)
and the battery-optimisation exemption is granted (the "Battery exempt" button
there). MIUI/HyperOS (Xiaomi/Redmi/POCO) additionally kill apps unless
**Autostart** is enabled for cubechat — grant it in *Settings → Apps → cubechat →
Autostart* (or Security app → Autostart), and set battery saver to *No
restrictions*. Without those, messages sent while cubechat is closed only arrive
after the peer reopens it.

---

## Testing

`flutter test` runs the whole suite (`test/`, ~440 files, flat). The golden
captures are tagged `golden` and pinned to the host that recorded them, so CI
runs `--exclude-tags golden`. Highlights:

- `architecture_test` — the dependency direction: `lib/core/` imports no
  feature and nothing from `lib/app/`
- `inbound_registry_complete_test`, `inbound_dispatch_characterization_test` —
  every inner-payload type is answered or dropped on purpose in every scope, and real signed, sealed
  frames fed in from outside land where they did before the transport was split
  (`test/support/inbound_harness.dart`)

- `noise_ik_test`, `noise_ik_session_test` — the IK pattern: two-message
  round trip, mutual authentication, that neither static key appears on the
  wire, that a caller with the wrong key gets no session and no reply, and that
  XX still runs unchanged alongside it
- `noise_xx_test`, `x3dh_test`, `sealed_box_test`, `signed_payload_test`,
  `fs_message_test`, `announcement_test` — session + message crypto
- `secp256k1_bip340_test` — pure-Dart secp256k1 signer pinned to the
  **official BIP-340 vectors**
- `nostr_signer_test`, `nostr_event_test`, `nostr_relay_protocol_test`,
  `nostr_transport_test` — Nostr fallback signer, event framing, relay
  protocol, and the in-memory fake-relay round-trip
- `websocket_relay_client_test` — the relay pool driven against a **real
  in-process WebSocket relay**: publish, REQ filter, cross-relay dedup,
  forged-signature rejection, and the no-relay throw that keeps
  store-and-forward as the backstop
- `contact_card_test`, `contact_bootstrap_test` — the off-mesh first contact:
  card round-trip, tolerant parsing, tampered/forged-card rejection, and the
  relay introduction (announcement → `cc1:` content → frame → verified) with
  its `ttl: 1` point-to-point budget
- `channel_crypto_test`, `channel_invite_test`, `receipt_reaction_test`,
  `edit_delete_test` — feature wire formats
- `peer_id_test` — rotating ids: determinism, per-epoch change, the ±1 epoch
  acceptance window against boundary and clock skew, the reverse index
  (including roster invalidation and legacy ids), and store-and-forward draining
  mail filed under a previous epoch
- `mesh_ttl_test` — the density-scaled hop budget: monotonic in link count,
  never inflating a short ttl, and the decrement-then-cap a relay applies
- `dedup_cache_test`, `store_forward_cache_test`, `hive_cipher_test` — mesh +
  storage (incl. the storage-key single-flight race)
- widget tests for the chat/nav UI

---

© 2026 Kuzminyo. All rights reserved.
