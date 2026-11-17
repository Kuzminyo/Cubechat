# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

Encrypted, serverless P2P messaging over a Bluetooth LE mesh, with an optional
Nostr relay fallback. Flutter; Android and iOS are the real targets. Windows and
macOS are linked devices that work over the relays, web is UI-only — none of the
three has BLE. The marketing site at cubechat.tech
lives in its own repository, Kuzminyo/landing_cubechat — it is not in this tree.

`lib/core/` holds transport, crypto, ble, storage, theme and shared widgets.
`lib/features/<name>/{data,models,domain,presentation}` holds the rest — `data/`
is Riverpod `Notifier` controllers. `lib/app/` wires the two together:
`bindings.dart` binds what core declares and features provide, plus the router,
the wipe and key rotation. Core imports neither `lib/app/` nor any feature —
`test/architecture_test.dart` enforces it. What the transport needs from a
feature is a port in `core/transport/ports/`, implemented by that feature's
controller. Anything that builds the app or the transport, tests included,
needs `appBindings`. `README.md` documents the protocol and the threat model in
full.

Beyond the app:

- `push/` — Node ≥20 server on the droplet: wake-up pushes (APNs, VoIP for
  calls, FCM), short-lived TURN logins, reports and the signed ban list. `node --test` inside it; deployment in
  `push/deploy/README.md`.
- `relay/` — config for our own Nostr relay (strfry): the meeting point every
  build listens on, the media lane, the walkie-talkie and the area chat. A new
  event kind goes into its write policy before a build sends it.
- `third_party/camera_*` — **vendored, patched** camera plugins wired as path
  dependencies. Change them there and record it in their `CUBECHAT_PATCH.md`;
  an upgrade means reapplying the patch. Never add `camera_android` — see the
  comment in `pubspec.yaml`.
- `docs/legal/` — privacy policy, terms and store disclosures, each claim checked
  against the code. A change to what leaves the phone — a new server call, a new
  field in a push, a new relay — changes these too.
- `docs/superpowers/` — design specs and plans; calls started there.

## Commands

`flutter` (3.41.9, same as CI) is on PATH via `~/.zprofile`.

```bash
flutter test test/mesh_ttl_test.dart
```

```bash
flutter analyze
```

```bash
flutter gen-l10n
```

Run it after any `.arb` edit and commit the regenerated
`lib/l10n/app_localizations*.dart` — they are checked in and CI does not
rebuild them. All 19 ARBs carry the same key set; `app_en.arb` is the template.

APKs are built by a script, not by `flutter build apk` on its own — the script
is what cross-checks the version and proves the build stamp reached the
artifact. Which script depends on the machine:

- **macOS / Linux** — `tool/build_apk.sh`
- **Windows** — `powershell -ExecutionPolicy Bypass -File tool/build_apk.ps1`;
  only there is `flutter build apk` broken (verified 2026-08-31), and a hook
  denies it.

Load the `release-build` skill before building.

`.claude/hooks/guard.py` denies three commands before they run: `flutter build
apk` on Windows, any `adb uninstall` / `pm uninstall`, and rewriting a tracked text
file through the shell (`sed -i`, a redirect, `Set-Content`) — use Edit or
Write. Its reason says why. After changing a pattern there, run
`python3 .claude/hooks/guard_test.py`; it pins both what must be denied and
what must pass.

## Skills — load these rather than reconstructing the rules

- **`wire-protocol`** — anything under `lib/core/transport/**` or `lib/core/crypto/**`: tag namespaces, envelope layout, adding a payload, peer-id epochs.
- **`release-build`** — building an APK or IPA, version and stamp, installing on a phone, CI.
- **`flutter-testing`** — running or writing tests, goldens, Hive and Riverpod harnesses.
- **`glass-ui`** — screens, widgets, colours, blur, animation.
- **`perf-triage`** — heat, battery, lag: which instrument answers which question.
- **`calls`** — voice and video calls: `callSignal`, the state machine, TURN, CallKit and Android's incoming-call surface.

## Two rules that cost the most when broken

**IMPORTANT: read the comment above a constant before changing it.** This tree
records experiments that were measured and reverted — refresh rate in
`main.dart`, blur sigma in `glass.dart`, the `pro_image_editor` pin in
`pubspec.yaml`. Re-proposing one of them is the most common failure here.

**IMPORTANT: load the `wire-protocol` skill before changing anything on the
wire.** A colliding tag byte produces no compile error and no failing test; it
ships and breaks phones that already have the app installed.

## Conventions

- Commit subjects are a sentence about the effect, not a conventional-commits
  prefix: "Stop the read-receipt storm that ate the phone and the log".
- Comments explain why, and carry the measurement that justified the change. Add
  one when you revert something, too.
- Measure before optimising. The wins here were GPS and uncapped image decodes,
  not blurs and not signing.
- `MessagingService` is ~14k lines and reaches the features only through the
  ports in `core/transport/ports/`. Inbound payloads are dispatched through
  the registry in `core/transport/inbound/`. A payload a feature answers is
  handled in that feature's `*_inbound.dart` (see
  `features/chat/data/chat_inbound.dart`), bound in `lib/app/bindings.dart`,
  and listed in `_directByModules` / `_roomByModules` so the transport stops
  claiming it; any other type lands in the transport's exhaustive switch.
  `test/inbound_registry_complete_test.dart` fails if a type has no owner. Moving more out follows
  `docs/superpowers/specs/2026-11-16-messaging-service-split-design.md`, one
  domain per change; do not extract a subsystem in passing.
- Analyzer runs strict (`analysis_options.yaml`: `strict-casts`,
  `strict-inference`, `strict-raw-types`, `prefer_final_locals`,
  `require_trailing_commas`). The tree carries hundreds of style infos, so CI
  gates on errors and warnings only; leave no new warning behind.
