# Лёгкий режим для слабого интернета (EDGE) — план реализации

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** на EDGE текст и файлы cubechat уходят через relay, а не висят с «чекають на зв’язок»; режим включается и выключается сам.

**Architecture:** relay-пул сам меряет, как быстро отвечают серверы (`LinkQualityMeter`), растягивает по замерам ожидание `OK` и probe и на медленной сети держит только три сокета. `MessagingService` получает от пула флаг «медленно» и на нём реже шлёт служебное, пропускает текст вперёд, режет файлы мельче и не бросает файл на обрыве. UI показывает честную плашку. Формат на проводе не меняется.

**Tech Stack:** Flutter/Dart, Riverpod `Notifier`, `web_socket_channel`, `flutter_test` с in-process `_FakeRelayServer`.

**Spec:** `docs/superpowers/specs/2026-10-20-weak-network-design.md`

## Global Constraints

- Ни одного нового байта на проводе: тот же кадр, тот же Nostr-event, тот же `cc1:`. Новый `InnerPayloadType` не нужен.
- `MessagingService` — только добавлять; подсистему не выносить (CLAUDE.md).
- Перед изменением константы прочитать комментарий над ней; новое значение получает свой комментарий «почему» с цифрой (CLAUDE.md, «Comments explain why, and carry the measurement»).
- На хорошей сети поведение как сейчас: пока `isSlow == false`, таймауты не ниже нынешних (2 с `OK`, 2 с probe, 1,5 с ожидания сокета) и сокетов столько же.
- Анализатор строгий: `strict-casts`, `strict-inference`, `strict-raw-types`, `prefer_final_locals`, `require_trailing_commas`. `flutter analyze` без новых warning (на CI одна warning валит сборку).
- Строки интерфейса — uk и en в `lib/l10n/app_uk.arb` / `app_en.arb`, потом `flutter gen-l10n`. Не-ASCII писать только через Write/Edit, не через shell.
- Коммиты — предложение про эффект, не conventional-commits; в конце `Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>`. Коммитить только свои файлы: дерево у владельца грязное, `git stash` не трогать.
- `docs/legal/` не меняется: новых серверов и полей нет.

## Review Focus

1. **Сеть пропала совсем (авиарежим), потом вернулась по Wi-Fi.** Тишина вводит режим; после возврата он должен выйти по быстрым ответам, а не залипнуть. Тест в Task 1: `exits after four fast acks once the dwell has passed`.
2. **Собеседник на старой сборке не слушает `relay.cubechat.tech`.** На медленной сети среди оставленных сокетов всегда должен быть хотя бы один публичный conversation-relay. Тест в Task 3: `slow mode keeps one public conversation relay beside ours`.
3. **Наш relay лежит, а сеть медленная.** Набор сокетов не должен остаться пустым: два лучших публичных. Тест в Task 3: `without our relay slow mode keeps the two fastest public ones`.
4. **Большой файл на EDGE к собеседнику.** Приёмник сейчас выбрасывает недокачанный файл через 5 минут **от манифеста** (манифест живёт 5 минут; сам буфер — 10), даже если куски идут. Новый приёмник считает от последнего куска (Task 6, тест `a transfer that keeps moving is not expired`). У старых сборок лимит остаётся: уже установленный приёмник выбрасывает файл через 5 минут после его манифеста (`_oldReceiverFileWindow`) — это ~1–1,5 МБ на EDGE, — а фото через 2 минуты. Это известное ограничение, сказать владельцу.
5. **Режим мигает.** Одна удачная быстрая отправка не выключает режим. Тест в Task 1: `one fast ack does not end slow mode`.

---

### Task 1: `LinkQualityMeter` — замер и решение «медленно»

**Files:**
- Create: `lib/core/transport/nostr/link_quality.dart`
- Test: `test/link_quality_test.dart`

**Interfaces:**
- Produces:
  ```dart
  class LinkQualityMeter {
    LinkQualityMeter({DateTime Function()? clock});
    void recordAck(String url, Duration elapsed);
    void recordConnect(String url, Duration elapsed);
    void recordSilence(String url);
    bool get isSlow;
    Stream<bool> get changes;              // только на переходах
    Duration ackTimeout({required Duration floor});
    Duration probeTimeout({required Duration floor});
    String? fastestOf(Iterable<String> urls); // наименьшая медиана OK; null без замеров
    String describe();                     // "ok-median 2.4 s, connect 7.1 s"
    void dispose();
  }
  ```

Значения (решение плана, каждое — константа с комментарием «почему»):
- окно: последние 6 замеров `OK` на весь пул;
- **вход**: медиана `OK` > 1500 мс при ≥ 3 замерах, **или** любой `connect` > 5 с, **или** две тишины подряд;
- **выход**: последние 4 `OK` все < 800 мс **и** прошло ≥ 30 с с момента входа;
- `ackTimeout`: не медленно и нет замеров → `floor`; иначе `clamp(медиана × 4, floor, 15 s)`; медленно без замеров `OK` → 10 с;
- `probeTimeout`: не медленно → `floor`; медленно → `clamp(медиана × 3, floor, 10 s)`, без замеров 6 с.

- [ ] **Step 1: Написать падающие тесты**

```dart
test('starts fast and keeps the floor', () {
  final m = LinkQualityMeter();
  expect(m.isSlow, isFalse);
  expect(m.ackTimeout(floor: const Duration(seconds: 2)), const Duration(seconds: 2));
});
test('three slow acks make it slow and stretch the wait', () {
  final m = LinkQualityMeter();
  for (var i = 0; i < 3; i++) m.recordAck('a', const Duration(milliseconds: 2400));
  expect(m.isSlow, isTrue);
  expect(m.ackTimeout(floor: const Duration(seconds: 2)), const Duration(milliseconds: 9600));
});
test('the wait never passes fifteen seconds', () { /* 3 × 6 s → ackTimeout == 15 s */ });
test('two silences in a row make it slow', () { /* recordSilence ×2 → isSlow, ackTimeout == 10 s */ });
test('a five-second connect makes it slow', () { /* recordConnect 5100 ms → isSlow */ });
test('one fast ack does not end slow mode', () { /* slow, +31 s, recordAck 300 ms ×1 → still slow */ });
test('exits after four fast acks once the dwell has passed', () {
  // clock injected: enter slow at t0; at t0+10 s four fast acks → still slow;
  // at t0+31 s four more fast acks → isSlow false, changes emitted [true, false]
});
test('fastestOf picks the lowest median and ignores unmeasured urls', () { /* a 900, b 400 → 'b'; fastestOf(['c']) → null */ });
```

- [ ] **Step 2: Убедиться, что падают**

Run: `flutter test test/link_quality_test.dart`
Expected: FAIL — `link_quality.dart` не существует.

- [ ] **Step 3: Реализовать `LinkQualityMeter`** по сигнатурам и значениям выше; `changes` — broadcast `StreamController<bool>`, событие только при смене `isSlow`.

- [ ] **Step 4: Тесты зелёные**

Run: `flutter test test/link_quality_test.dart`
Expected: PASS.

- [ ] **Step 5: Commit** — `git add lib/core/transport/nostr/link_quality.dart test/link_quality_test.dart`, сообщение: «Measure how fast the relays answer, and call the link slow when they crawl».

---

### Task 2: пул ждёт по замерам и не рвёт медленное соединение

**Files:**
- Modify: `lib/core/transport/nostr/websocket_relay_client.dart` (ctor; `_publishTo`; `_PendingPublish`; `_onOk`; `_RelayConnection.open`, `_runProbe`, `wake`; silence-ветка в `publish`)
- Test: `test/websocket_relay_client_test.dart` (расширить `_FakeRelayServer`)

**Interfaces:**
- Consumes: `LinkQualityMeter` (Task 1).
- Produces:
  ```dart
  WebSocketNostrRelayClient({..., LinkQualityMeter? linkQuality, String? anchorUrl});
  bool get isSlow;
  Stream<bool> get slowChanges;
  String describeLink();
  ```
  (`anchorUrl` используется в Task 3; здесь только принять и сохранить.)

Что меняется:
- `_PendingPublish` получает `sentAt`; `_onOk(url, eventId, accepted, message)` пишет `recordAck(url, now − sentAt)` для принятых.
- **Поздний `OK`**: id недавно закрытых по таймауту публикаций (до 64 штук, с их `sentAt`) запоминаются, и поздний ответ тоже идёт в замер. Без этого на EDGE медиана никогда не превысит таймаут.
- По истечении ожидания каждый промолчавший url → `recordSilence`.
- `_publishTo` ждёт `linkQuality.ackTimeout(floor: _publishAckTimeout)`; probe ждёт `linkQuality.probeTimeout(floor: _probeTimeout)`; `open()` пишет `recordConnect` с реальной длительностью `ready`.
- Комментарии над `defaultPublishAckTimeout` и `defaultProbeTimeout` не удалять: дописать, что это теперь пол, а не потолок, и почему (EDGE: 0,5–1 с на круг плюс очередь; цикл «тишина → probe → reopen → новый TLS»).

- [ ] **Step 1: Добавить в `_FakeRelayServer` поле `Duration answerDelay = Duration.zero`**, которое задерживает **все** ответы (`OK`, `EVENT`, `EOSE`), — так выглядит EDGE.

- [ ] **Step 2: Написать падающие тесты** в группе `group('slow link', ...)`:

```dart
test('a relay that answers late is measured, and the next publish waits for it', () async {
  relay.answerDelay = const Duration(milliseconds: 1200);
  // client: publishAckTimeout 300 ms, probeTimeout left at the 2 s default —
  // the probe's EOSE lands at 1200 ms, so a silent publish finds the socket
  // alive and must not reopen it. Two silences → slow; the late OKs (1200 ms)
  // are the samples, so the third publish waits clamp(4.8 s) and is accepted.
  final first = await client.publish(ev1);        // silent at 300 ms
  final second = await client.publish(ev2);       // silent again → slow
  expect(client.isSlow, isTrue);
  final third = await client.publish(ev3);
  expect(third.isAccepted, isTrue);               // waited ≥ 1200 ms
});
test('a slow relay is not torn down and reopened', () async {
  // the same setup; after the three publishes
  expect(relay.connections, 1);
});
test('on a fast link the floor still holds', () async {
  // answerDelay zero, publishAckTimeout 2 s: accepted, isSlow false, connections 1
});
```

- [ ] **Step 3: Убедиться, что падают**

Run: `flutter test test/websocket_relay_client_test.dart --plain-name "slow link"`
Expected: FAIL — `isSlow` не определён / сокет переоткрыт (`connections` 2+).

- [ ] **Step 4: Реализовать** изменения из списка выше.

- [ ] **Step 5: Тесты файла зелёные целиком** (старые тесты на тишину и мёртвый сокет обязаны остаться зелёными: мёртвый сокет по-прежнему переоткрывается, если не ответил даже на растянутый probe).

Run: `flutter test test/websocket_relay_client_test.dart test/relay_connection_lifecycle_test.dart test/relay_pool_once_test.dart`
Expected: PASS.

- [ ] **Step 6: Commit** — «Wait for a slow relay as long as it actually takes, instead of reopening it every two seconds».

---

### Task 3: на медленной сети — три сокета

**Files:**
- Modify: `lib/core/transport/nostr/websocket_relay_client.dart` (`start`, `wake`, новый `_applySlowMode`)
- Modify: `lib/core/transport/messaging_service.dart` ~стр. 982 — передать `anchorUrl: RelaySettings.meetingPointUrl`
- Test: `test/websocket_relay_client_test.dart`

**Interfaces:**
- Consumes: `LinkQualityMeter.fastestOf`, `slowChanges` (Task 2).
- Produces: поведение; новых публичных методов нет.

Правило набора на медленной сети (`_slowKeep`):
- `anchorUrl`, если он есть среди conversation-url и открыт;
- плюс один публичный conversation-url: `fastestOf(...)`, иначе первый открытый;
- если anchor не открыт — два лучших публичных conversation-url;
- плюс `mediaPrimaryUrl` (наш `/media`), чтобы файлы шли только туда.

Остальные сокеты закрываются и до выхода из режима не открываются: ни `start()`, ни `wake()`, ни таймер переподключения. На выходе — `start()` открывает всех, и REQ берёт пропущенное по водяному знаку. Location- и публичные media-сокеты на это время молчат, это и есть «карта и медиа ждут» из спеки. Пропущенные маячки карты повторяются каждые 45 с, их не жалко.

- [ ] **Step 1: Написать падающие тесты** (четыре `_FakeRelayServer`: anchor, pubA, pubB, geo; `anchorUrl: anchor.url`, conversation = [anchor, pubA, pubB], location = [geo]):

```dart
test('slow mode keeps one public conversation relay beside ours', () async {
  // drive slow (answerDelay on pubB only + silences), then:
  expect(openUrls(client), {anchor.url, pubA.url});   // pubA fastest
});
test('without our relay slow mode keeps the two fastest public ones', () async {
  // anchor server closed before slow mode
  expect(openUrls(client), {pubA.url, pubB.url});
});
test('a wake in slow mode does not reopen what was let go', () async {
  client.wake();
  await pump();
  expect(geo.activeConnections, 0);
});
test('leaving slow mode opens every relay again', () async {
  // fast acks ×4 after the 30 s dwell (meter with injected clock)
  expect(geo.activeConnections, 1);
});
```
(`openUrls` — тестовый хелпер по `client.states` == `RelayState.connected`.)

- [ ] **Step 2: Убедиться, что падают**

Run: `flutter test test/websocket_relay_client_test.dart --plain-name "slow mode"`
Expected: FAIL.

- [ ] **Step 3: Реализовать** `_applySlowMode(bool slow)` по подписке на `slowChanges`; `start()`/`wake()` уважают `_slowKeep`; передать `anchorUrl` из `messaging_service.dart`.

- [ ] **Step 4: Зелёные**

Run: `flutter test test/websocket_relay_client_test.dart test/relay_lanes_test.dart`
Expected: PASS.

- [ ] **Step 5: Commit** — «On a crawling link keep three sockets open, not nine».

---

### Task 4: `MessagingService` — флаг, лог, текст вперёд, служебное реже

**Files:**
- Modify: `lib/features/profile/data/relay_settings_controller.dart` — рядом с `RelayStatusController`
- Modify: `lib/core/transport/messaging_service.dart`: подписка рядом с `_relayStateSub` (~1040); `_ensureRelayAwakeForSend` (~9923); таймер presence (~10588); `_readReceiptFlushGap` (~3460); путь текста через relay (~1929–2004) и `_flushOutboxOverRelay` (~3487)
- Test: `test/slow_network_policy_test.dart`

**Interfaces:**
- Consumes: `WebSocketNostrRelayClient.isSlow`, `slowChanges`, `describeLink()`.
- Produces:
  ```dart
  // relay_settings_controller.dart
  class SlowNetworkController extends Notifier<bool> { void publish(bool slow); }
  final slowNetworkProvider = NotifierProvider<SlowNetworkController, bool>(SlowNetworkController.new);

  // MessagingService — чистые статические правила, чтобы тестировать без сервиса
  static Duration relayWakeWaitFor({required bool slow});          // 1500 ms / 8 s
  static bool heartbeatDue({required bool slow, required bool textWaiting,
      required DateTime? lastHeartbeat, required DateTime now});    // !slow → true; slow → !textWaiting && (last == null || ≥ 150 s)
  static Duration readReceiptFlushGapFor({required bool slow});    // 5 s / 30 s
  bool get isSlowNetwork;                                          // _relayClient?.isSlow ?? false
  bool get textWaitingForRelay;                                    // _textRelayInFlight > 0 || _outbox.isNotEmpty
  ```

Что делает:
- На каждом переходе `slowChanges`: `slowNetworkProvider.publish(slow)` и одна строка `DebugLog.instance.log('NET', slow ? 'slow: ${client.describeLink()} → 3 sockets' : 'fast again: ${client.describeLink()}')`. Проверка `_disposed` — как у соседнего `_relayStateSub`.
- `_ensureRelayAwakeForSend` ждёт `relayWakeWaitFor(slow: isSlowNetwork)`. Комментарий «a send button should feel broken if it blocks» дополнить: отправка асинхронная, кнопка не блокируется; на EDGE подключение занимает секунды.
- `_textRelayInFlight++/--` вокруг `_sendOverNostr` для текста (не transient) и в `_flushOutboxOverRelay`.
- Heartbeat: колбэк таймера спрашивает `heartbeatDue`; arriving/goodbye не трогаются. 150 с — решение плана: presence-TTL 60 с, так что на медленной сети «в сети» у собеседника будет гаснуть между раундами. Это сознательная цена, комментарий это говорит.
- Отметки о прочтении: `_flushPendingReadReceipts` берёт `readReceiptFlushGapFor(slow: isSlowNetwork)` и на медленной сети пропускает раунд, пока `textWaitingForRelay`.

- [ ] **Step 1: Падающие тесты на чистые правила**

```dart
test('a fast link waits 1.5 s for a socket, a slow one 8 s', () {
  expect(MessagingService.relayWakeWaitFor(slow: false), const Duration(milliseconds: 1500));
  expect(MessagingService.relayWakeWaitFor(slow: true), const Duration(seconds: 8));
});
test('every heartbeat is due on a fast link', () { /* slow false, last 5 s ago → true */ });
test('a slow link beats every 150 s', () { /* last 100 s → false; 150 s → true; null → true */ });
test('a slow link lets a waiting text go first', () { /* textWaiting true, last null → false */ });
test('receipts gather for 30 s on a slow link', () {
  expect(MessagingService.readReceiptFlushGapFor(slow: true), const Duration(seconds: 30));
  expect(MessagingService.readReceiptFlushGapFor(slow: false), const Duration(seconds: 5));
});
```

- [ ] **Step 2: Падают**

Run: `flutter test test/slow_network_policy_test.dart`
Expected: FAIL — методов нет.

- [ ] **Step 3: Реализовать** всё из списка выше.

- [ ] **Step 4: Зелёные плюс соседи**

Run: `flutter test test/slow_network_policy_test.dart test/presence_controller_test.dart test/presence_expiry_test.dart test/presence_targets_test.dart test/send_queue_test.dart test/queued_remint_test.dart`
Expected: PASS (`presence_expiry_test` держит пару «heartbeat 25 с / TTL 60 с»: на быстрой сети она не меняется).

- [ ] **Step 5: Commit** — «On a slow link a text goes before presence and receipts, and the log says when the link turned slow».

---

### Task 5: маячки карты молчат на медленной сети

**Files:**
- Modify: `lib/features/map/data/map_presence_controller.dart` (`_sendUpdate` / `_publish`)
- Test: `test/map_presence_slow_test.dart`

**Interfaces:**
- Consumes: `slowNetworkProvider` (Task 4).
- Produces: `static bool roundAllowed({required bool slow, required bool force})` → `!slow || force`.

Отзыв метки (retraction) и `force` идут всегда: это «я перестал делиться», и молчание тут хуже лишних байт.

- [ ] **Step 1: Падающий тест**

```dart
test('a slow link skips the beacon round, a forced one still goes', () {
  expect(MapPresenceController.roundAllowed(slow: true, force: false), isFalse);
  expect(MapPresenceController.roundAllowed(slow: true, force: true), isTrue);
  expect(MapPresenceController.roundAllowed(slow: false, force: false), isTrue);
});
```

- [ ] **Step 2: Падает** — Run: `flutter test test/map_presence_slow_test.dart` → FAIL.
- [ ] **Step 3: Реализовать**: `_publish` возвращает раньше, если `!roundAllowed(slow: ref.read(slowNetworkProvider), force: force)`.
- [ ] **Step 4: Зелёный** — Run: `flutter test test/map_presence_slow_test.dart` → PASS.
- [ ] **Step 5: Commit** — «Hold the map beacons while the link is crawling».

---

### Task 6: файлы — мельче кусок, не бросать на обрыве, приёмник терпеливее

**Files:**
- Modify: `lib/core/transport/mtu_budget.dart` (рядом с `kRelayMediaChunkData`, ~стр. 93–101)
- Modify: `lib/core/transport/messaging_service.dart`: `_mediaChunkData` (~10030); цикл кусков файла (~2370–2440) и циклы картинок/голосовых (~2725, ~3000, ~5140, ~5263)
- Modify: `lib/core/transport/file_reassembly.dart` (`_PendingFile`, `_gc`, конструктор `FileReassembler`)
- Test: `test/relay_transfer_ceiling_test.dart` (или новый `test/relay_slow_chunk_test.dart`), `test/file_reassembly_stale_test.dart`

**Interfaces:**
- Consumes: `isSlowNetwork`, `textWaitingForRelay` (Task 4).
- Produces:
  ```dart
  const int kRelaySlowMediaChunkData = 16 * 1024;
  int relayMediaChunkData({required int ceiling, bool slow = false});
  // MessagingService
  static const Duration _slowChunkPatience = Duration(minutes: 5);
  Future<bool> _awaitMediaRouteBack(String canonicalId, {required Duration max});
  Future<void> _yieldToText({required Duration max}); // max 30 s
  // FileReassembler
  FileReassembler({..., DateTime Function()? clock});
  ```

Проверено перед планом:
- Приёмник принимает кусок **любого** размера, если в пределах передачи он одинаковый: `FileReassembler` пишет по `seq * stride`, stride берёт из первого неконечного куска, а манифест несёт только `total`. Поэтому 16 КиБ на медленной сети не трогают провод. Размер выбирается **один раз на передачу**, иначе приёмник убьёт её (инвариант stride).
- Повтор файла сейчас — это `retryFileTransfer` → новый `sendFile`: новый `fileId`, с куска 0. Докачки нет. Её даёт терпение внутри одной передачи: тот же `fileId`, тот же кусок.
- Приёмник выбрасывает недокачанное через `staleAfter` = 10 мин **от `startedAt`**, даже если куски идут.

Что делает:
- `relayMediaChunkData(slow: true)` → 16 КиБ (≈22 КБ события). Комментарий: на EDGE ~3–5 КБ/с вверх кусок 63 КиБ (≈87 КБ события) идёт ~20–30 с, дольше потолка ожидания `OK` в 15 с; 16 КиБ ≈ 5–7 с. **Проверить лимит частоты событий нашего relay** в `relay/write-policy.mjs`: событий станет вчетверо больше; если лимит их режет — сказать владельцу, сервер в этом плане не менять.
- В циклах кусков: на медленной сети перед каждым куском `await _yieldToText(max: 30 s)`; если `_deliverMediaFrameRetrying` вернул `sent: false` и `isSlowNetwork`, то `_awaitMediaRouteBack(canonicalId, max: _slowChunkPatience)` и ещё одна попытка **того же** куска; `MediaRouteUnavailable` — только если и она не прошла. На быстрой сети как сейчас.
- `FileReassembler`: `_PendingFile.lastChunkAt` обновляется на каждом принятом куске; `_gc` сравнивает `staleAfter` с `lastChunkAt`. Комментарий над `staleAfter` дописать: считать от последнего куска, потому что на EDGE файл в несколько мегабайт идёт дольше 10 минут; старые сборки приёмника по-прежнему считают от начала.

- [ ] **Step 1: Падающие тесты**

```dart
// relay_slow_chunk_test.dart
test('a slow link cuts relay chunks to 16 KiB', () {
  expect(relayMediaChunkData(ceiling: 1 << 20, slow: true), 16 * 1024);
  expect(relayMediaChunkData(ceiling: 1 << 20), kRelayMediaChunkData);
});
// file_reassembly_stale_test.dart (clock injected)
test('a transfer that keeps moving is not expired', () async {
  // chunk 0 at t0, chunk 1 at t0+9 min, gc at t0+12 min → still pending
});
test('a transfer that stopped is expired ten minutes after its last chunk', () async {
  // chunk 0 at t0, gc at t0+10 min+1 s → expired
});
```

- [ ] **Step 2: Падают** — Run: `flutter test test/relay_slow_chunk_test.dart test/file_reassembly_stale_test.dart` → FAIL.
- [ ] **Step 3: Реализовать** всё из списка выше.
- [ ] **Step 4: Зелёные плюс соседи** — Run: `flutter test test/relay_slow_chunk_test.dart test/file_reassembly_stale_test.dart test/relay_transfer_ceiling_test.dart test/file_transfer_test.dart test/file_transfer_controller_test.dart` → PASS.
- [ ] **Step 5: Commit** — «On a slow link files go in smaller pieces and wait out a dropout instead of starting over».

---

### Task 7: фото в «эконом» на медленной сети

**Files:**
- Modify: `lib/core/util/image_encode.dart` (рядом с `enum MediaQuality`)
- Modify: `lib/features/chat/presentation/chat_screen.dart` ~5131 и ~5308 (`resolved()` перед `encodeBytesForMesh`); ~5049 — проверить, выбирает ли там `quality` то, что уйдёт на провод, и если да, сделать так же
- Test: `test/media_quality_test.dart`

**Interfaces:**
- Consumes: `slowNetworkProvider` (Task 4).
- Produces: `MediaQuality effectiveMediaQuality(MediaQuality chosen, {required bool slowNetwork})` — `slowNetwork && chosen == MediaQuality.standard` → `economy`, иначе `chosen`.

`high` в настройках — явный выбор человека, его не трогаем. «Отправить как файл» (оригинал, ~5030) не кодируется и не трогается.

- [ ] **Step 1: Падающий тест**

```dart
test('a slow link sends standard photos as economy, and leaves a chosen high alone', () {
  expect(effectiveMediaQuality(MediaQuality.standard, slowNetwork: true), MediaQuality.economy);
  expect(effectiveMediaQuality(MediaQuality.high, slowNetwork: true), MediaQuality.high);
  expect(effectiveMediaQuality(MediaQuality.standard, slowNetwork: false), MediaQuality.standard);
});
```

- [ ] **Step 2: Падает** — Run: `flutter test test/media_quality_test.dart` → FAIL.
- [ ] **Step 3: Реализовать** функцию и обернуть в неё `resolved()` на точках вызова.
- [ ] **Step 4: Зелёный** — Run: `flutter test test/media_quality_test.dart` → PASS.
- [ ] **Step 5: Commit** — «Send photos at economy size while the link is slow, unless high was chosen».

---

### Task 8: плашка «Повільна мережа — надсилаємо»

Загрузить скилл `glass-ui` перед правкой виджета.

**Files:**
- Modify: `lib/features/chat/presentation/widgets/send_queue_sheet.dart` (`SendQueueEntry`)
- Modify: `lib/l10n/app_uk.arb`, `lib/l10n/app_en.arb`; затем `flutter gen-l10n`
- Test: `test/send_queue_slow_test.dart` (виджет-тест; harness — по скиллу `flutter-testing`)

**Interfaces:**
- Consumes: `slowNetworkProvider`, `sendQueueProvider`.
- Produces: ключ l10n `sendQueueSlowNetwork` с плюралом по `count`:
  - uk: `{count, plural, =1{Повільна мережа — надсилаємо 1 повідомлення} few{Повільна мережа — надсилаємо {count} повідомлення} many{Повільна мережа — надсилаємо {count} повідомлень} other{Повільна мережа — надсилаємо {count} повідомлення}}`
  - en: `{count, plural, =1{Slow network — sending 1 message} other{Slow network — sending {count} messages}}`

Та же строка, что сейчас, и только пока очередь не пуста: постоянной поверхности не добавлять (владелец её отвергал). Меняется только текст: при `slow` — `sendQueueSlowNetwork`, иначе `sendQueueCount`.

- [ ] **Step 1: Падающий виджет-тест**: очередь из 2 сообщений, `slowNetworkProvider` = true → на экране `Slow network — sending 2 messages` (en-локаль); `false` → текст `sendQueueCount(2)`; пустая очередь → строки нет.
- [ ] **Step 2: Падает** — Run: `flutter test test/send_queue_slow_test.dart` → FAIL.
- [ ] **Step 3: Добавить ключи в оба arb, `flutter gen-l10n`, переключить текст в `SendQueueEntry`.**
- [ ] **Step 4: Зелёный** — Run: `flutter test test/send_queue_slow_test.dart test/send_queue_test.dart` → PASS.
- [ ] **Step 5: Commit** — «Say "slow network, sending" instead of "waiting for a connection" while the link crawls».

---

### Task 9: полная проверка и шаги для владельца

- [ ] **Step 1: Анализатор** — Run: `flutter analyze`. Expected: ни одной новой `warning` и `error`. Грепать и `-`, и `•`: на Windows разделитель другой, чем на CI.
- [ ] **Step 2: Весь набор тестов** (в фоне, это дольше 2 минут) — Run: `flutter test`. Expected: всё зелёное, кроме уже известных падений; новых падений нет. Если что-то красное — по `superpowers:systematic-debugging`, не подгонять тест.
- [ ] **Step 3: Сборка** — загрузить скилл `release-build`. Поднять `version:` в pubspec, `appVersion` и `appBuildStamp` **до** сборки; на Windows `powershell -ExecutionPolicy Bypass -File tool/build_apk.ps1`, universal APK, не в worktree. Только когда владелец попросит сборку.
- [ ] **Step 4: Отдать владельцу шаги на русском** (не проверяли на устройстве, EDGE у нас нет):

  1. Установи новую сборку **поверх** старой, не удаляя её.
  2. Выключи Wi-Fi. Samsung: Настройки → Подключения → Мобильные сети → Режим сети → **Только 2G**. Или просто зайди туда, где горит «E».
  3. На втором телефоне выключи Bluetooth, чтобы сообщение пошло через интернет.
  4. Отправь 3 коротких сообщения. Над чатами должна появиться строка «Повільна мережа — надсилаємо …», потом галочки.
  5. Отправь одно фото.
  6. **Сразу после этого**, до других фото, открой Профиль → Диагностика → лог и пришли строки с `[NET]`, `sent … via relay`, `published` и `[IMG] sent photo` (у фото одна итоговая строка вместо строки на каждый кусок). Лог держит 200 строк, и одно фото их вытесняет.
  7. Верни «Режим сети» в авто/5G. Через полминуты–минуту в логе должна появиться `[NET] fast again`.

  Ожидаемая строка: `[NET] slow: ok-median …` (например, `[NET] slow: ok-median 2.4 s, connect 7.1 s`). Числа сокетов в ней нет: какие сокеты оставлены, пишет отдельная строка `[NOSTR] link slow (…) — keeping …`.

- [ ] **Step 5: Сказать владельцу про ограничение из Review Focus №4:** у собеседника на уже установленной (старой) сборке файл выбрасывается через 5 минут после его манифеста (~1–1,5 МБ на EDGE), фото — через 2 минуты. Больше на EDGE за это время к нему не дойдёт. Лечится обновлением у собеседника.
