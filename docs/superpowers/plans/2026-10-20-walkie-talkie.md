# Рация — план реализации (этапы 0–2)

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** рация «как настоящая, но с нашим шифрованием»: группы по названию+паролю и один на один, рядом по Bluetooth-mesh; этап 0 выясняет, что iOS разрешит с выключенным экраном.

**Architecture:** голос пишется потоком PCM 48 кГц (`record.startStream`), кодируется libopus в 8 кбит/с кадрами по 20 мс, 15 кадров (300 мс) — один кусок `radioChunk`. Кусок идёт в обычном `TransportEnvelope` + `SignedPayload`: один на один — адресно под SealedBox (шифр 0x01), группа — broadcast под новым шифр-тегом 0x05 с ключом из (название, пароль). Приёмник: проверка свежести → «канал занят» → буфер против дрожания → нативный проигрыватель PCM (`cubechat/radio_audio`). Ни store-and-forward, ни outbox, ни Nostr на этапах 0–2.

**Tech Stack:** Flutter/Riverpod, `record` 6 (`startStream`), libopus через FFI (`lib/core/audio/opus_voice.dart`), Kotlin `AudioTrack`, Swift `AVAudioEngine` + фреймворк PushToTalk (этап 0).

**Spec:** `docs/superpowers/specs/2026-10-20-walkie-talkie-design.md`

## Global Constraints

- Перед любым изменением провода — скилл `wire-protocol`; свободный байт `InnerPayloadType` печатать его скриптом (на 2026-10-20: `0xEC 0xED 0xEE 0xEF 0xFD 0xFE 0xFF`), шифр-теги заняты `0x01–0x04`.
- Ключ группы рации — домен `cubechat-radio-key-v1`, тег — `cubechat-radio-tag-v1`; никогда не совпадает с ключом текстового канала с тем же (название, пароль).
- Кусок рации: никогда в `StoreForwardCache`, `_outbox`, `_relayChannelFrameOverNostr`, `_sendOverNostr` (этапы 0–2).
- Приёмник выбрасывает кусок, если `startedAtMs + seq·300 мс` старше **5 с** относительно сейчас (с допуском часов `clockSkew` 30 с вперёд — как `call_rules.dart`).
- TTL группового куска — **3** (`TransportEnvelope.ttlForLinkCount` только понижает).
- Opus: 48 кГц, моно, кадр 960 сэмплов (`OpusVoice.frameSamples`), битрейт рации **8000**; голосовые сообщения остаются на `OpusVoice.bitRate` (32000).
- Тумблер «Говорити в беззвучному режимі», по умолчанию **включён**.
- `MessagingService` — только добавлять; не выносить подсистемы.
- Строки — uk/en через `flutter gen-l10n`; UI — по скиллу `glass-ui`.
- Коммиты — предложением об эффекте; комментарии — «почему» с замером.
- Анализатор строгий; CI валит `warning`: `flutter analyze 2>&1 | grep -E "^[[:space:]]*(error|warning)[[:space:]]*[-•]"`.
- Не-ASCII (кириллицу) писать только Write/Edit, не через bash/PowerShell.
- Сборка APK — по скиллу `release-build`, только в основной папке (не в worktree), версия и `appBuildStamp` поднимаются заранее.

## Review Focus

1. Кусок, пришедший через минуты (держал чужой телефон в store-and-forward, промежуточный узел не может знать, что это рация) — выбрасывается, не звучит. Тест в Task 3.
2. Двое нажали почти одновременно — у всех слушателей звучит один и тот же говорящий. Тест в Task 4.
3. Последний кусок передачи потерян — «канал занят» сам снимается через хвост, кнопка не залипает. Тест в Task 4.
4. Чужая группа с тем же тегом/неверный пароль — тишина, без исключений и без строки лога на каждый кусок. Тест в Task 2 и Task 5.
5. Поток рации не забивает mesh для текста: отправитель шлёт не больше ~4 кусков в секунду и прекращает сразу после отпускания. Тест в Task 7.

---

## Этап 0 — проба на iPhone (выбрасывается)

Ветка `spike/ios-ptt`, в `main` не сливается. Вопрос один: **звучит ли на заблокированном iPhone голос, пришедший по Bluetooth без интернета, через PushToTalk-канал**, и что делает беззвучный режим.

### Task 0.1: Что должен сделать владелец заранее

- [ ] **Step 1:** Дать владельцу шаги (по-русски): developer.apple.com → Identifiers → `app.cubechat` → включить **Push to Talk**; Profiles → пересоздать `cubechat App Store`; скачать, `base64` и заменить секрет `IOS_PROVISION_PROFILE` в GitHub.
- [ ] **Step 2:** Объяснить, почему не Sideloadly: он подписывает бесплатным профилем и выбрасывает entitlement, которого профиль не покрывает (`RunnerRelease.entitlements`, комментарий). Проба ставится через TestFlight (`ios-testflight.yml`, `workflow_dispatch` по ветке).

### Task 0.2: Нативная проба PushToTalk

**Files:**
- Create: `ios/Runner/CubechatRadioSpikePlugin.swift`
- Modify: `ios/Runner/AppDelegate.swift` (регистрация плагина), `ios/Runner/Info.plist` (`UIBackgroundModes` += `push-to-talk`), `ios/Runner/RunnerRelease.entitlements` и `Runner.entitlements` (+ `com.apple.developer.push-to-talk` = true), `ios/Runner.xcodeproj` (файл в target)

**Interfaces:**
- Produces: MethodChannel `cubechat/radio_spike`: `join() -> String` (результат `requestJoinChannel`), `incoming(name: String) -> String` (результат `setActiveRemoteParticipant` или текст ошибки), `leave()`. В Dart лог `[RADIO-SPIKE] …` на каждый ответ.

- [ ] **Step 1:** `PTChannelManager.channelManager(delegate:restorationDelegate:)` при старте; `join()` → `requestJoinChannel(channelUUID:descriptor:)` с фиксированным UUID и именем «cubechat test».
- [ ] **Step 2:** `incoming(name)` → `setActiveRemoteParticipant(PTParticipant(name:image:nil), channelUUID:)`; ошибку отдать строкой.
- [ ] **Step 3:** `channelManager(_:didActivate audioSession:)` → проиграть встроенный `radio_spike_beep.caf` (2 с) через `AVAudioPlayer`, записать в лог `activated`, `played`, а также `AVAudioSession.sharedInstance().secondaryAudioShouldBeSilencedHint` и громкость.
- [ ] **Step 4:** `incomingPushResult(...)` вернуть `.leaveChannel` — push в пробе не используется.
- [ ] **Step 5:** Сборка: `workflow_dispatch` `ios-testflight.yml` на ветке; убедиться в логе workflow, что профиль содержит `com.apple.developer.push-to-talk` (`security cms -D` уже печатает entitlements профиля).

### Task 0.3: Dart-крючок пробы

**Files:**
- Create: `lib/core/radio_spike.dart`
- Modify: `lib/core/transport/messaging_service.dart` (ветка `case InnerPayloadType.text:` для 1:1, ~стр. 7476, сразу после `plaintext`), `lib/features/profile/presentation/diagnostics_screen.dart` (кнопка «Рация: проба»)

**Interfaces:**
- Produces: `RadioSpike.instance.join()`, `RadioSpike.instance.incoming(String fromName)`; маркер текста `cubechat:radiospike:v1`.

- [ ] **Step 1:** Если `plaintext.startsWith('cubechat:radiospike:v1')` и платформа iOS — `unawaited(RadioSpike.instance.incoming(<имя контакта>))` и `return` (в чат не сохранять).
- [ ] **Step 2:** В Диагностике кнопка «Рация: проба → войти в канал» (`join()`), под ней последние строки `[RADIO-SPIKE]`.
- [ ] **Step 3:** Отправителю сборка не нужна: Android-телефон шлёт этот текст обычным сообщением из чата (вставить вручную).

### Task 0.4: Проверка владельцем и решение

- [ ] **Step 1:** Шаги владельцу по-русски: на обоих телефонах выключить интернет, Bluetooth включён; на iPhone Диагностика → «Рация: проба» → войти; заблокировать iPhone; с Android отправить в чат с iPhone текст `cubechat:radiospike:v1`. Повторить: (а) экран iPhone открыт, (б) заблокирован, (в) заблокирован + беззвучный режим, (г) приложение смахнуто из многозадачности. После каждого — прислать строки `[RADIO-SPIKE]` из Диагностики.
- [ ] **Step 2:** Записать итог в спеку (раздел «Экран выключен»):
  - **А — звучит из фона без push.** Этап 3 = PushToTalk-канал на каждую группу/контакт, звук через `didActivate`.
  - **Б — отказ без push.** На iPhone рация с выключенным экраном работает только через интернет (этап 4, push `pushtotalk`); по Bluetooth — при открытом приложении. Сказать владельцу прямо.
  - **В — иное.** Описать и вернуться к владельцу до этапа 3.
- [ ] **Step 3:** Ветку не сливать; удалить после записи итога.

---

## Этап 1 — рация рядом, экран открыт (Android и iOS)

### Task 1: Кодек куска рации

**Files:**
- Create: `lib/core/transport/radio_chunk.dart`
- Modify: `lib/core/transport/inner_payload.dart` (новое значение `radioChunk(<байт из скрипта>)` с комментарием-описанием, как у соседей)
- Test: `test/radio_chunk_test.dart`

**Interfaces:**
- Produces:
  ```dart
  class RadioChunk {
    const RadioChunk({required this.transmissionId, required this.seq,
      required this.isLast, required this.startedAtMs, required this.frames});
    final Uint8List transmissionId; // 16 B
    final int seq;                  // 0..65535
    final bool isLast;
    final int startedAtMs;          // начало передачи, мс epoch
    final List<Uint8List> frames;   // Opus-пакеты по 20 мс, 1..50
    Uint8List encode();
    static RadioChunk decode(Uint8List bytes); // FormatException на мусор
    static const int framesPerChunk = 15;
    static const Duration chunkDuration = Duration(milliseconds: 300);
  }
  ```
  Раскладка: `[version:1=0x01][flags:1 bit0=isLast][transmissionId:16][seq:2 BE][startedAtMs:8 BE][frameCount:1][{len:2 BE, bytes}×frameCount]`.

- [ ] **Step 1: Тесты** `test/radio_chunk_test.dart`:
  - `round trip keeps every field` — 15 кадров разной длины, `isLast` true/false.
  - `truncated bytes throw FormatException` — каждая длина от 0 до `encode().length - 1`.
  - `a frame length past the end throws FormatException`.
  - `unknown version throws FormatException`.
  - `zero frames or more than 50 throws` (и на encode — `ArgumentError`).
- [ ] **Step 2:** `flutter test test/radio_chunk_test.dart` — FAIL (нет файла).
- [ ] **Step 3:** Реализовать; байт `InnerPayloadType` взять из вывода скрипта `wire-protocol`, комментарий: что делает старая сборка (молча отбрасывает — для рации правильно).
- [ ] **Step 4:** Тест — PASS.
- [ ] **Step 5:** Коммит: «Give a walkie-talkie chunk its own payload on the wire».

### Task 2: Ключи группы рации

**Files:**
- Create: `lib/core/crypto/radio_crypto.dart`
- Test: `test/radio_crypto_test.dart`

**Interfaces:**
- Consumes: примитивы, как в `ChannelCrypto` (BLAKE2s, ChaCha20-Poly1305).
- Produces:
  ```dart
  class RadioCrypto {
    static Future<Uint8List> deriveKey(String name, String password); // 32 B, домен cubechat-radio-key-v1
    static Future<Uint8List> deriveTag(Uint8List key);                 // 8 B, домен cubechat-radio-tag-v1
    static Future<Uint8List> seal(Uint8List key, Uint8List plain);     // nonce‖ct‖mac
    static Future<Uint8List> open(Uint8List key, Uint8List blob);      // кидает при неверном ключе
  }
  ```
  Материал — как в `ChannelCrypto.deriveKey` (домен, NUL, имя, NUL, пароль), только свой домен. Своей нормализации у `ChannelCrypto` нет: имя приводит `channel_controller.dart` перед вызовом — рация приводит его тем же кодом (вынести в общую функцию, если он приватный), не копией.

- [ ] **Step 1: Тесты:** `same name and password give the same key`; `radio key differs from the channel key for the same name and password` (сравнить с `ChannelCrypto`); `tag differs from the channel tag`; `open with a wrong password throws`; `tampered blob throws`.
- [ ] **Step 2:** FAIL. **Step 3:** Реализовать. **Step 4:** PASS.
- [ ] **Step 5:** Коммит: «Derive a radio group's key apart from any text channel's».

### Task 3: Кодирование потока и буфер приёма

**Files:**
- Modify: `lib/core/audio/opus_voice.dart` — `OpusVoiceEncoder([OpusLibrary? library, int bitRate = OpusVoice.bitRate])`
- Create: `lib/features/radio/domain/radio_frames.dart`, `lib/features/radio/domain/radio_jitter_buffer.dart`
- Test: `test/radio_frames_test.dart`, `test/radio_jitter_buffer_test.dart`

**Interfaces:**
- Produces:
  ```dart
  /// PCM16 произвольными порциями → готовые куски по 15 кадров.
  class RadioFramer {
    RadioFramer({required Uint8List Function(Int16List frame) encode,
      required DateTime Function() clock, Uint8List? transmissionId});
    List<RadioChunk> add(Uint8List pcmBytes); // 0..n готовых кусков
    RadioChunk finish();                      // хвост, isLast = true (может быть 1 кадр тишины)
  }

  class RadioJitterBuffer {
    RadioJitterBuffer({required DateTime Function() clock,
      Duration prebuffer = const Duration(milliseconds: 400),
      Duration maxAge = const Duration(seconds: 5),
      Duration clockSkew = const Duration(seconds: 30)});
    /// false — выброшен (дубль, устарел, из будущего дальше clockSkew, чужая передача).
    bool push(RadioChunk chunk);
    /// Кадры, которые пора играть, по порядку seq; пропуск seq после
    /// ожидания 300 мс — пропускается (декодер получит null → PLC/тишина).
    List<Uint8List?> drain();
    bool get finished; // isLast сыгран
  }
  ```

- [ ] **Step 1: Тесты** `radio_frames_test.dart`: `pcm in uneven pieces comes out as 15-frame chunks with rising seq`; `finish marks the last chunk and keeps the transmission id`; `every chunk carries the same startedAtMs`.
- [ ] **Step 2: Тесты** `radio_jitter_buffer_test.dart`: `nothing plays before the prebuffer fills`; `out-of-order chunks play in seq order`; `a duplicate seq is refused`; **`a chunk whose start is older than five seconds is refused`** (Review Focus 1); `a chunk from further than clockSkew ahead is refused`; `a missing seq is skipped after waiting one chunk`; `finished once the last chunk drains`.
- [ ] **Step 3:** FAIL. **Step 4:** Реализовать; `RadioFramer` — пакетирует по 960 сэмплов, `encode` внедряется (в тестах фейк без libopus). **Step 5:** PASS.
- [ ] **Step 6:** Коммит: «Cut the microphone into radio chunks and play them back in order».

### Task 4: «Канал занят»

**Files:**
- Create: `lib/features/radio/domain/radio_floor.dart`
- Test: `test/radio_floor_test.dart`

**Interfaces:**
- Produces:
  ```dart
  sealed class FloorState {}          // Idle / Talking(myTxId) / Listening(senderId, txId)
  class RadioFloor {
    RadioFloor({required DateTime Function() clock,
      Duration tail = const Duration(seconds: 1)});
    FloorState get state;
    bool tryTalk(Uint8List myTxId, int startedAtMs); // false, если занят
    void stopTalking();
    /// Возвращает true, если кусок этой передачи надо играть.
    bool onChunk(String senderId, RadioChunk chunk);
    void tick(); // снимает Listening через tail после последнего куска
  }
  ```
  Правило коллизии: побеждает меньший `startedAtMs`, при равенстве — лексикографически меньший `transmissionId`. Если я говорю и пришла передача-победитель — `state` → `Listening`, контроллер обязан прекратить запись (см. Task 7).

- [ ] **Step 1: Тесты:** `pressing while someone talks is refused`; **`two near-simultaneous starts resolve to the earlier one on every side`** (два экземпляра `RadioFloor` получают одни куски в разном порядке → одинаковый победитель; Review Focus 2); `equal start breaks ties on the lower id`; **`a lost last chunk frees the floor after the tail`** (Review Focus 3); `isLast frees the floor at once`.
- [ ] **Step 2:** FAIL. **Step 3:** Реализовать. **Step 4:** PASS.
- [ ] **Step 5:** Коммит: «Let one person hold a radio channel at a time».

### Task 5: Провод в MessagingService (только добавления)

**Files:**
- Modify: `lib/core/transport/messaging_service.dart`
- Create: `lib/features/radio/data/radio_inbound.dart` (провайдер потока входящих)
- Test: `test/radio_transport_test.dart`

**Interfaces:**
- Consumes: `RadioChunk` (Task 1), `RadioCrypto` (Task 2).
- Produces:
  ```dart
  // MessagingService
  static const int _cipherRadio = 0x05; // комментарий: почему не 0x03 — канальный путь ретранслирует в Nostr
  Future<int> sendRadioToContact(String canonicalId, RadioChunk chunk); // число линков, 0 = никуда; без очередей
  Future<int> sendRadioToGroup(Uint8List key, Uint8List tag, RadioChunk chunk);
  // radio_inbound.dart
  class RadioInbound { final String senderId; final Uint8List? groupTag; final RadioChunk chunk; }
  final radioInboundProvider = Provider<Stream<RadioInbound>>(...); // broadcast
  /// Ключи групп, в которых состоит телефон: tag → key. Заполняет RadioController.
  final radioGroupKeysProvider = StateProvider<Map<String, Uint8List>>(...); // ключ map — hex тега
  ```
  1:1: inner `radioChunk` → `SignedPayload` → SealedBox → адресный конверт, BLE (`_writeFrameToClient` / notify / `_fanoutAllLinks`); при 0 линков — **ничего не хранить**. Группа: `[0x05][tag:8][RadioCrypto.seal(key, signedPayload)]`, broadcast, ttl 3. Приём: шифр 0x05 → искать тег в `radioGroupKeysProvider`; нет — `return` молча (ретрансляция mesh идёт уровнем выше, как сейчас); есть — `open`, проверить подпись, отдать в поток. Inner `radioChunk` в ветке 1:1 → поток.

- [ ] **Step 1: Тесты** (харнесс — как в существующих тестах `MessagingService`, напр. `queued_remint_test.dart`; `settleBackgroundStorage` в tearDown):
  - `a radio chunk to an unreachable contact is not held` — после `sendRadioToContact` без линков `StoreForwardCache` пуст и outbox пуст.
  - `a radio chunk never goes to a relay` — фейковый `NostrTransport` не получил ни одного `sendFrame`.
  - `a group chunk under an unknown tag is dropped without a log line per chunk` — 20 кусков → в `DebugLog` не больше одной строки `[RADIO]` (Review Focus 4).
  - `a group chunk under a known tag reaches radioInbound with its sender`.
  - `a group frame decrypted with the wrong key is dropped`.
- [ ] **Step 2:** FAIL. **Step 3:** Реализовать. **Step 4:** PASS + существующие тесты транспорта зелёные (`flutter test test/relay_lanes_test.dart test/queued_remint_test.dart test/mesh_ttl_test.dart`).
- [ ] **Step 5:** Коммит: «Carry radio chunks over the mesh and never keep them for later».

### Task 6: Нативный проигрыватель PCM

**Files:**
- Create: `android/app/src/main/kotlin/com/cubechat/cubechat/CubechatRadioAudioPlugin.kt`, `ios/Runner/CubechatRadioAudioPlugin.swift`, `lib/core/audio/radio_audio.dart`
- Modify: `MainActivity`/регистрация плагинов Android, `ios/Runner/AppDelegate.swift`, Xcode-проект
- Test: `test/radio_audio_test.dart` (только Dart-сторона, мок канала)

**Interfaces:**
- Produces:
  ```dart
  abstract class RadioAudioSink {
    Future<void> start({required bool playInSilentMode}); // 48 кГц моно PCM16
    Future<void> write(Int16List pcm);
    Future<void> stop();
  }
  class PlatformRadioAudio implements RadioAudioSink { /* MethodChannel 'cubechat/radio_audio' */ }
  final radioAudioProvider = Provider<RadioAudioSink>((_) => PlatformRadioAudio());
  ```
  Android: `AudioTrack` MODE_STREAM; `playInSilentMode` → `AudioAttributes.USAGE_ALARM` (не глушится беззвучным), иначе `USAGE_MEDIA`; запрос audio focus `GAIN_TRANSIENT_MAY_DUCK`. iOS: `AVAudioEngine` + `AVAudioPlayerNode`; `playInSilentMode` → категория `.playback`, иначе `.ambient` (уважает переключатель). Не трогать сессию, если идёт звонок (`.voiceChat`, правило 8 скилла `calls`).

- [ ] **Step 1: Тест:** `write sends pcm bytes in order and start passes the silent flag` (мок `MethodChannel`).
- [ ] **Step 2:** FAIL. **Step 3:** Реализовать Dart + нативное. **Step 4:** PASS; `flutter analyze` без warning.
- [ ] **Step 5:** Коммит: «Play radio audio as it arrives, through or past the silent switch».

### Task 7: RadioController

**Files:**
- Create: `lib/features/radio/data/radio_controller.dart`, `lib/features/radio/models/radio_channel.dart`
- Modify: `lib/core/storage/hive_init.dart` (новое имя ящика `cubechat.radio_groups` в списке `all` — тогда его подхватят бэкап и перенос на новый телефон)
- Test: `test/radio_controller_test.dart`

**Interfaces:**
- Consumes: Tasks 1–6; `record` (`AudioRecorder.startStream(AudioSession.voiceStream)`), `OpusVoiceEncoder(null, 8000)`, `OpusVoiceDecoder`.
- Produces:
  ```dart
  sealed class RadioChannel { } // RadioGroup(name, hasPassword, tagHex) | RadioContact(canonicalId)
  class RadioState { final List<RadioGroup> groups; final RadioChannel? active;
    final FloorState floor; final bool playInSilentMode; }
  class RadioController extends Notifier<RadioState> {
    Future<void> joinGroup(String name, String password);
    Future<void> leaveGroup(String tagHex);
    void select(RadioChannel? channel);
    Future<bool> pressToTalk();   // false — занят или нет микрофона
    Future<void> releaseToTalk();
    Future<void> setPlayInSilentMode(bool value);
  }
  final radioControllerProvider = NotifierProvider<RadioController, RadioState>(RadioController.new);
  ```
  Пароль не хранится — хранится ключ (как каналы; проверить, как `channel_controller.dart` хранит, и сделать так же). Лог: одна строка на передачу — `[RADIO] sent 12 chunks in 3.6 s` / `[RADIO] heard 12 chunks, 0.8 s latency, 2 lost`.

- [ ] **Step 1: Тесты** (фейки: рекордер-поток, `RadioAudioSink`, отправка):
  - `joining a group registers its key for inbound` (`radioGroupKeysProvider` содержит тег).
  - **`holding the button sends at most four chunks a second and stops on release`** — 3 с PCM → 10 ± 1 кусков, после `releaseToTalk` ни одного (Review Focus 5).
  - `pressing while the floor is busy is refused and records nothing`.
  - `losing a collision stops the recording`.
  - `inbound chunks of the active channel reach the audio sink in order`.
  - `inbound for a channel that is not active is not played`.
  - `play-in-silent defaults to on and survives a restart`.
- [ ] **Step 2:** FAIL. **Step 3:** Реализовать. **Step 4:** PASS.
- [ ] **Step 5:** Коммит: «Talk and listen on a radio channel».

### Task 8: Экран рации

**Files:**
- Create: `lib/features/radio/presentation/radio_screen.dart`, `lib/features/radio/presentation/radio_join_sheet.dart`
- Modify: экран «Поблизу» (`lib/features/peers/presentation/peers_screen.dart` — вход «Рація»), заголовок чата 1:1 (`lib/features/chat/presentation/chat_screen.dart` — кнопка рации), роутер, `lib/l10n/app_uk.arb` и `app_en.arb`
- Test: `test/radio_screen_test.dart`

- [ ] **Step 1:** Загрузить скилл `glass-ui`.
- [ ] **Step 2: Тест** (харнесс локализаций — из `chat_search_capture_test.dart`, `radioControllerProvider.overrideWith`): `the button reads busy while someone else talks`; `the join sheet needs a name`; `the silent-mode switch reflects the state`.
- [ ] **Step 3:** FAIL. **Step 4:** Экран: список групп + «Додати рацію» (название, пароль), большая кнопка «Затисни й говори» (`onLongPressStart`/`End`), строка «Говорить: <ім'я>» / «Канал зайнятий», тумблер «Говорити в беззвучному режимі». Тексты uk/en, `flutter gen-l10n`. **Step 5:** PASS.
- [ ] **Step 6:** Коммит: «Give the radio a screen of its own».

### Task 9: Сборка и проверка этапа 1

- [ ] **Step 1:** Полный прогон: `flutter test --exclude-tags golden`, `flutter analyze` (warning-грeп из Global Constraints) — оба чистые.
- [ ] **Step 2:** Скилл `release-build`; поднять `version:`, `appVersion`, `appBuildStamp`; универсальный APK скриптом `tool/build_apk.ps1`; IPA — через CI.
- [ ] **Step 3:** Шаги владельцу по-русски: два телефона, интернет выключен; оба → «Поблизу» → «Рація» → «Додати рацію» с одним названием и паролем; зажать и сказать «раз-два-три»; затем то же с неверным паролем на одном (должна быть тишина); затем оба нажимают одновременно. Прислать строки `[RADIO]` из Диагностики.

---

## Этап 2 — Android с выключенным экраном

### Этап 2 — решения (2026-10-22, по просьбе владельца «доделывай всё по плану»)

Что выяснилось в коде перед этапом 2: нативный проигрыватель уже зарегистрирован на кэшированном движке (`MainApplication`), а фоновую жизнь процесса держит `MeshForegroundService` (`connectedDevice|location`). Не хватает другого: `radioControllerProvider` создаётся **только когда открывается экран рации** (его читает только экран), и выбранный канал **не сохраняется** — после перезапуска или пока экран не открыт, рация никого не слышит.

- **Передача с выключенным экраном по-прежнему вне объёма** (спека: не цели): нажать кнопку на выключенном экране нечем. Поэтому тип `microphone` у службы mesh **не добавляем** — запись идёт только при открытом приложении, как сейчас. Меняем **приём**.
- **Ruling 25.** Контроллер рации создаётся при старте приложения (как `mapPresenceControllerProvider` в `lib/app.dart`), чтобы приём работал на любом экране и в фоне. Для тех, кто рацией не пользовался, он ничего не стоит: нечего слушать → нет таймера, нет ключей, нет криптографии (Ruling M6).
- **Ruling 26.** Настроенный канал (группа по `tagHex` или контакт по каноническому id) **сохраняется** и восстанавливается после перезапуска; «Вимкнути рацію», выход из группы и экстренное стирание его очищают.
- **Ruling 27 (входящий вызов рации, Ruling 23).** Тумблер «Приймати особисті виклики» (по умолчанию **включён**, хранится рядом с `playInSilentMode`). Пока рация **ни на что не настроена** и тумблер включён, контроллер публикует в `radioPairPeersProvider` всех не заблокированных контактов; если пришёл кусок 1:1 от контакта и ничего не настроено — рация **сама настраивается на этого контакта** и играет. Если уже настроено на что-то, чужой личный вызов **не** перебивает. Чтобы «рацией не пользовался — ничего не платит» оставалось верным, это включается только после того, как рацией хоть раз пользовались (группа добавлена, канал выбирался хоть раз — флаг `radio.used` в том же хранилище настроек).
- **Ruling 28.** На Android проигрыватель держит `PARTIAL_WAKE_LOCK` на время приёма (с таймаутом, например 3 минуты, и снятием в `stop`): иначе процессор может уснуть между кусками. Разрешение `WAKE_LOCK` — проверить в манифесте, добавить, если нет.
- **Ruling 29.** Если фоновый режим mesh выключен (`backgroundModeProvider`), на экране рации показывается одна строка-подсказка «С выключенным экраном рация слышна, только если включён фоновый режим» (uk/en), потому что без службы Android убьёт процесс.

### Task 10: Приём рации с выключенным экраном на Android (Dart)

**Files:**
- Modify: `lib/app.dart` (создать контроллер при старте), `lib/features/radio/data/radio_controller.dart` (сохранение канала, личные вызовы, флаг `used`), `lib/features/radio/data/radio_ports.dart` (хранение `active`, `personalCalls`, `used` в хранилище настроек радио), `lib/features/radio/presentation/radio_screen.dart` (тумблер и подсказка), `lib/l10n/app_uk.arb` и `app_en.arb`
- Test: `test/radio_controller_test.dart`, `test/radio_screen_test.dart`

**Interfaces:**
- Produces: `RadioState.personalCalls: bool`; `RadioController.setPersonalCalls(bool)`; сохранение `active` как `RadioChannelRef` (`room:<tagHex>` | `contact:<id>`) в `RadioSettingsStore`.

- [ ] **Step 1: Тесты (FAIL).** В `radio_controller_test.dart`: `a tuned room is restored after a restart`; `turning the radio off forgets the channel`; `leaving the tuned room forgets it`; `the wipe forgets the channel and the used flag`; `a personal call tunes an idle radio to that contact` (ничего не настроено, `used`, тумблер включён → чужой 1:1 кусок настраивает на контакта и доходит до динамика); `a personal call does not interrupt a tuned room`; `with personal calls off an idle radio hears nothing`; `a phone that never used the radio publishes no pair peers and runs no timer` (флаг `used` ложен); `the controller exists without the screen` (провайдер читается из `ProviderContainer` без экрана и принимает кусок). В `radio_screen_test.dart`: `the personal calls switch reflects the state`; `the background hint shows when background mode is off`.
- [ ] **Step 2:** Запустить — FAIL.
- [ ] **Step 3:** Реализовать: `lib/app.dart` — `ref.watch(radioControllerProvider)` рядом с `ref.watch(mapPresenceControllerProvider)` (см. комментарий там про фоновый старт); сохранять `active` при каждом `select`; восстанавливать после загрузки групп (если сохранённой группы больше нет — молча `select(null)`); `_publishKeys` расширить Ruling 27; флаг `used` ставится при первом `joinGroup` или первом непустом `select`. Не нарушать Ruling M6 и ленивый таймер (Ruling 20).
- [ ] **Step 4:** Тесты — PASS; общий анализатор чистый.
- [ ] **Step 5:** Коммит: «Keep the radio tuned across restarts and let a personal call tune an idle radio».

### Task 11: Приём рации с выключенным экраном на Android (нативная часть)

**Files:**
- Modify: `android/app/src/main/kotlin/com/cubechat/cubechat/CubechatRadioAudioPlugin.kt` (wake lock), `android/app/src/main/AndroidManifest.xml` (`WAKE_LOCK`, если нет)
- Test: Dart-тест с моканным каналом не нужен (поведение нативное); проверка — только на телефоне.

- [ ] **Step 1:** В `start` взять `PowerManager.PARTIAL_WAKE_LOCK` (тег `cubechat:radio`) с таймаутом 3 минуты; в `stop`/`release` снять; повторный `start` не копит замки; без исключения, если замок не дали.
- [ ] **Step 2:** Проверить, что в манифесте есть `WAKE_LOCK`; добавить с комментарием, если нет. Проверить, что фоновый приём не требует нового `foregroundServiceType` (приём — это воспроизведение, не запись).
- [ ] **Step 3:** Анализатор чистый; Kotlin сверить с SDK (minSdk 24).
- [ ] **Step 4:** Коммит: «Hold the CPU awake while the radio is playing».

### Task 12: Сборка и шаги владельцу (этап 2)

- [ ] **Step 1:** Поднять `version:` и `appBuildStamp`, собрать APK `tool/build_apk.ps1` (в основной папке), проверить подпись и штамп.
- [ ] **Step 2:** Шаги владельцу: настроить рацию на группу → заблокировать экран → со второго телефона говорить; повторить после «убить приложение из списка» и после перезапуска телефона; личный вызов: оба телефона с выключенным каналом, один говорит из чата → второй слышит сам; на беззвучном с тумблером вкл/выкл.

---

## Этапы 3–4 — отдельными планами

- **Этап 3 (iOS, экран выключен)** — план пишется по итогу Task 0.4 (вариант А/Б/В).
- **Этап 4 (через интернет)** — свой план: эфемерные события на нашем relay (`relay/write-policy.mjs` + тесты), push `pushtotalk`/FCM с `push/`, правки `docs/legal/` (privacy uk/en, store-disclosures).
