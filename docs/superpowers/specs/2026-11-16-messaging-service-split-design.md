# Разделение MessagingService — дизайн

Дата: 2026-11-16. Статус: **предложение**, решений владельца ещё нет (см.
«Открытые вопросы»). До утверждения действует правило из CLAUDE.md: работа в
`MessagingService` аддитивна, подсистемы попутно не выносятся.

## Зачем

Цифры на 2026-11-16 (`main` @ 0220c27e):

- `lib/core/transport/messaging_service.dart` — **14 831 строка**, ~256 методов.
  CLAUDE.md всё ещё говорит «~8k»: за два месяца файл почти удвоился.
- **289** вызовов `_ref.read(...)` к ~40 провайдерам. Больше всего у
  `messagesController` (47), `knownPeers` (37), `channelController` (26),
  `channelRoster` (23), `chatSessionManager` (22), `identity` (20),
  `fileTransfer` (15) и `conversationSettings` (12).
- **50+ импортов из `features/`** в одном файле транспорта. Всего в `core/` их
  делают семь файлов: `messaging_service`, `ble_scanner`, `wipe_service`,
  `account_key_rotation`, `ios_background_refresh`, `app_router`, `app_shell`.
  Поэтому «ядро» нельзя ни собрать, ни протестировать без всех фич.
- `_handleTransportFrame` (с 8249-й строки) — один метод на **~2 575 строк**.
- Входящие разбираются **тремя** `switch` по `InnerPayloadType`:
  - 1:1 — в `_handleTransportFrame`, ~45 case;
  - канал — в `_handleChannelBody` (с 6774-й строки), ~40 case;
  - отложенные FS-чанки — в `_flushPendingFsChunks`.

  Текст, ответ, правка, удаление, реакция и закреп разобраны в 1:1 и в канале
  **дважды**, в слегка разных вариантах.

Что это стоит на практике:

- любой новый тип сообщения правит файл на 15k строк, а параллельная работа
  над двумя фичами конфликтует в нём;
- тест входящего кадра поднимает весь `ProviderContainer` с Hive;
- 44 члена с `@visibleForTesting` / `debug*` — обходные пути внутрь объекта,
  у которого нет внутренних границ.

## Что не меняется (инварианты)

1. **Провод — ни байта.** Теги `InnerPayloadType`, cipher tags 0x01–0x05,
   конверт, фрагменты, подписи, PoW — как есть. Код переезжает внутри
   `lib/core/transport/**`, поэтому каждый этап начинается с загрузки скилла
   `wire-protocol`, хотя формат не трогаем.
2. **Порядок проверок остаётся в транспорте:** расшифровать → проверить
   подпись → dedup → «придержать» (неподтверждённый отправитель,
   `_holdChannelPost` для adminOnly) → эффект → пересылка и уведомление.
   Обработчик получает только уже проверенную полезную нагрузку и никогда не
   решает, доверять ли ей.
3. **Публичный API `MessagingService` не меняется:** `send*`, `callSignals`,
   `nearbyInbound`, `radioInbound` и остальные потоки. Вызывающие места в
   `features/` в этом проекте не трогаются.
4. **Константы переезжают вместе с комментарием над ними, дословно.** Лимиты
   `_maxPendingFsChunks`/`_maxPendingFsBytes`, `_radioTtl` и подобные
   измерены — см. первое правило в CLAUDE.md.
5. **Один этап — один PR**, слитый в `main` быстро. Долгоживущей ветки нет:
   файл слишком горячий, чтобы держать его вне `main` неделями.

## Что получится

```
lib/core/transport/
  messaging_service.dart     # каналы связи, сессии, крипто, dedup, store-and-forward,
                             # пересылка, «придержать», исходящие — только транспорт
  inbound/
    inbound_context.dart     # кто, откуда, куда, каким путём — считается один раз
    payload_handler.dart     # интерфейс обработчика
    inbound_registry.dart    # тип → обработчик; проверка полноты
  ports/
    message_sink.dart        # append / edit / delete / status / react / pin
    peer_directory.dart      # ключи, предключи, имена, блокировка
    channel_directory.dart   # каналы и состав (roster), adminOnly
features/<x>/data/<x>_inbound.dart   # обработчики своих типов
lib/app/bindings.dart                # composition root: регистрирует обработчики,
                                     # связывает порты с контроллерами фич
```

`core/` перестаёт импортировать `features/`. Зависимость идёт в одну сторону:
фичи → ядро, а связывает их `lib/app/`.

### InboundContext

Сейчас контекст собирается заново в каждой ветке (`authorName`, `reactorId`,
`route`/`routeHops`, `TransportEnvelope.hashHex(env.msgId)`). Он станет
неизменяемым значением, которое транспорт строит один раз после проверок:

```dart
final class InboundContext {
  final String chatId;        // canonical id собеседника или имя канала
  final String senderId;      // canonical id; в канале — отпечаток Ed25519
  final String? authorName;
  final Channel? channel;     // null для 1:1
  final String wireId;        // hashHex(env.msgId)
  final MessageRoute route;   // bluetooth / mesh / internet
  final int? routeHops;
  final String linkPeerId;    // кто передал кадр (для ответа и пересылки)
  final bool fromCentral;
}
```

### Обработчик и реестр

```dart
abstract interface class PayloadHandler {
  Set<InnerPayloadType> get types;
  Set<InboundScope> get scopes;   // direct, channel или оба
  Future<void> handle(InboundContext ctx, UnpackedPayload payload);
}
```

`InboundRegistry` — это `Map<(InboundScope, InnerPayloadType), PayloadHandler>`.

- Два обработчика на одну пару — **ошибка при старте** (`StateError`), а не
  тихая перезапись.
- **Полнота.** Сейчас `switch` по enum без `default` даёт ошибку компиляции,
  если новый тип забыли обработать. Реестр эту гарантию теряет, поэтому её
  переносим в тест: `test/inbound_registry_complete_test.dart` проходит по
  `InnerPayloadType.values` × `InboundScope.values` и требует для каждой пары
  либо обработчик, либо явную запись в `ignored` с причиной. Это обязательная
  часть этапа 2, а не «потом».
- Незарегистрированный тип во время работы — лог и отброс, так же как сейчас
  ведёт себя старая сборка. Точное текущее поведение для каждого типа
  фиксируется на этапе 0.

### Порты

Порты — только для зависимостей, которые нужны **самому транспорту** или
встречаются в нём десятки раз. Хвост из 1–4 обращений (`typing`, `pinnedChats`,
`hiddenAuthors`…) уходит вместе с обработчиком в фичу, а не превращается в порт.

| Порт | Заменяет | Обращений |
|---|---|---|
| `MessageSink` | `messagesController` | 47 |
| `PeerDirectory` | `knownPeers`, `removedContacts`, `peerAvatars` (чтение) | ~41 |
| `ChannelDirectory` | `channelController`, `channelRoster` | 49 |
| `FileTransfers` | `fileTransferController` | 15 |

`chatSessionManager`, `identity` и `prekeyService` живут в `core/` — это
состояние транспорта, им порты не нужны.

Связывание. `main.dart` уже сам строит `ProviderContainer()`, чтобы iOS
background refresh видел те же провайдеры, что и UI. Поэтому `bindings`
передаются туда же:

```dart
final container = ProviderContainer(overrides: appBindings);
```

В `core/` провайдер порта по умолчанию бросает исключение
`UnimplementedError('bound in lib/app/bindings.dart')`. Тестам нужен общий
помощник `test/support/app_bindings.dart`. Это стоит правки во всех тестах,
которые сейчас строят `MessagingService`: 18 файлов читают
`messagingServiceProvider`, ещё 12 вызывают конструктор напрямую.

Рассмотрен и отвергнут сеттер, как у `nearbyFileSink`. Он зависит от
порядка: кадр, пришедший до того, как контроллер поставил сеттер, теряется. В
фоновом запуске iOS это значит молча пропущенное сообщение.

## Этапы

### Этап 0 — страховочная сетка (без изменений в `lib/`)

- **Характеризующие тесты** через существующий `debugReceiveFrame`: для каждого
  типа в каждой области (1:1, канал) — кадр на входе, а на выходе состояние
  контроллеров, уведомления, ответные кадры и пересылка. Фиксируются и
  отличия 1:1 от канала. Это основная защита всего проекта: без неё этап 1
  не начинать.
- `test/architecture_test.dart` — **храповик**: считает импорты `features/` из
  `core/` и падает, если их стало больше, чем записано. Число в тесте
  уменьшается с каждым этапом.
- Замер: CPU приёма по `cpu_probe` на двух телефонах в шторме подтверждений
  о прочтении и при приёме альбома (скилл `perf-triage`). Это база для
  сравнения после этапов 1 и 3.
- CLAUDE.md: «~8k» → фактическое число.

### Этап 1 — внутри файла, без переносов

- `InboundContext` строится один раз.
- Тело каждого `case` становится приватным методом `_on<Type>(ctx, payload)`,
  а `switch` — списком вызовов. Поведение не меняется, диф — почти одни
  перемещения.
- Отличия между 1:1 и каналом для text/edit/delete/reaction/pin
  записываются таблицей **в эту спеку**. Сливать их на этом этапе нельзя.

Это самый конфликтный PR, его делать в момент, когда в файле нет другой работы.

### Этап 2 — реестр, composition root, первые порты

- `InboundRegistry`, `lib/app/bindings.dart`, тест полноты.
- Сначала `MessagingService` регистрирует **свои же** методы из этапа 1 —
  поведение то же, меняется только маршрут вызова.
- Порты `MessageSink` и `PeerDirectory` с заменой 84 обращений.

### Этап 3 — по домену за PR

Порядок — от самого изолированного, у которого уже есть шов, к самому
запутанному:

1. `radioChunk` — уже есть `radio_ports.dart` и `radioInbound`.
2. `nearbyOffer`/`nearbyAnswer`/`nearbyBump` — уже есть поток `nearbyInbound`.
3. `callSignal` — уже есть поток `callSignals`.
4. `ownDevice`, `keyRotation`.
5. `presence`, `typing`, `avatar`, `avatarRequest`, `voiceLevels`.
6. Медиа: `mediaManifest`, `imageChunk`/`audioChunk`/`fileChunk`,
   `mediaRequest`, `albumHint`, `viewOnceConsumed`. Сюда входит третий
   `switch`; лимиты памяти FS-чанков остаются в транспорте.
7. Каналы: `channelAdmin`, `channelModeration`, `channelHistory`,
   `channelPoll`, `channelDelete`, `channelInvite`, `channelAvatar`,
   `channelDescription`, `channelAdminOnly`. Механизм «придержать до roster»
   остаётся в транспорте и повторяет кадр через реестр.
8. Последними — `text`, `textReply`, `edit`, `delete`, `reaction`, `pin`,
   `receipt`, `forwardedFrom`, `conversationClear`, `copyRestriction`,
   `conversationWallpaper`, `forwardPrivacy`.

После каждого PR из `messaging_service.dart` уходят соответствующие импорты, а
число в храповике уменьшается.

### Этап 4 — остальной `core/` → `lib/app/`

`app_router`, `app_shell`, `wipe_service` (импортирует ~60 контроллеров),
`account_key_rotation`, `ios_background_refresh` — это сборка приложения из
фич, а не ядро. `DiscoveredPeer` переезжает из `features/peers/models` в
`core/ble`. После этого в храповике 0, и он становится запретом.

### Проверка каждого этапа

`flutter analyze`, полный набор тестов, затем установка на Android и iOS
(скилл `release-build`) и ручной прогон:

- текст 1:1 по Bluetooth;
- текст 1:1 через релей;
- пост в канал с adminOnly;
- фото и голосовое;
- звонок, который звонит с заблокированного экрана;
- рация;
- AirDrop;
- сообщение, полученное в фоновом обновлении iOS.

## Готово, когда

- `core/` не импортирует `features/`, и это проверяет тест.
- Новый тип сообщения = значение в enum (по правилам `wire-protocol`) +
  обработчик в фиче + строка в `bindings.dart`; `messaging_service.dart`
  при этом не открывается.
- `messaging_service.dart` содержит только транспорт. Ориентир — ≤ 6k строк,
  но это следствие, а не цель.
- CPU приёма не хуже базы из этапа 0.

## Риски

- **Порядок побочных эффектов.** Например, уведомление показывается, только
  если `append` вернул `true`. Ловится тестами этапа 0, поэтому они идут первыми.
- **Пересоздание сервиса.** `wipe_service` и `account_key_rotation` делают
  `ref.invalidate(messagingServiceProvider)`. Реестр должен жить и умирать
  вместе с сервисом, а не быть глобальным синглтоном.
- **Фоновый запуск iOS.** Если какой-то порт не связан, он бросит исключение в
  фоне, где его никто не увидит: сообщение будет пропущено молча. Поэтому
  `bindings` передаются в единственный контейнер в `main.dart`, а в чеклисте
  есть пункт про фоновое обновление.
- **Конфликты с текущей работой** — см. инвариант 5 и этап 1.

## Что не входит

- Исходящая сторона: `send*`, outbox, таймеры presence, файловая очередь.
  После этого проекта — отдельная спека.
- Циклы между фичами, которые не проходят через `core/`
  (`chat ↔ peers ↔ profile ↔ chats`).
- Большие экраны (`chat_screen` — 6,1k строк, `message_bubble` — 5,1k).
- `push/src/index.js`.

## Открытые вопросы владельцу

1. **Composition root:** новая папка `lib/app/` (туда же `app.dart` и
   роутинг) или достаточно файла `lib/bindings.dart` рядом с `main.dart`?
2. **Дубли 1:1 и канала** для text/edit/delete/reaction/pin: сливать в один
   обработчик с `ctx.channel` после того, как на этапе 1 будет таблица
   отличий, или оставить два?
3. **Порядок этапа 3** — устраивает, или есть фича, которую сейчас активно
   меняют и её стоит вынести первой (или последней)?
