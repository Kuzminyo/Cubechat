// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get callVoice => 'Голосовой звонок';

  @override
  String get callVideo => 'Видеозвонок';

  @override
  String get callIncomingVideo => 'Входящий видеозвонок';

  @override
  String get callCamera => 'Камера';

  @override
  String get callFlipCamera => 'Повернуть';

  @override
  String get contactProfileVideo => 'Видео';

  @override
  String get callPreparing => 'Подготовка микрофона…';

  @override
  String get callDialing => 'Вызов…';

  @override
  String get callRinging => 'Ожидание ответа…';

  @override
  String get callConnecting => 'Соединение…';

  @override
  String get callMicrophoneRequired =>
      'Разрешите доступ к микрофону в системных настройках, чтобы звонить.';

  @override
  String get callMicrophoneWindows =>
      'Windows не дала CubeChat доступ к микрофону. Включите Параметры → Конфиденциальность и защита → Микрофон → «Разрешить классическим приложениям доступ к микрофону».';

  @override
  String get callElsewhere =>
      'Звонок уже идёт на другом устройстве этого аккаунта.';

  @override
  String get callRelayUnavailable =>
      'Сервер звонков недоступен. Попробуйте позже.';

  @override
  String get callBusy => 'Занято';

  @override
  String get callNoAnswer => 'Нет ответа';

  @override
  String get callFailed => 'Не удалось соединить звонок';

  @override
  String get callDeclined => 'Звонок отклонён';

  @override
  String get callEnded => 'Звонок завершён';

  @override
  String get callMicrophone => 'Микрофон';

  @override
  String get callSpeaker => 'Динамик';

  @override
  String get callAnswer => 'Ответить';

  @override
  String get callDecline => 'Отклонить';

  @override
  String get callEnd => 'Завершить';

  @override
  String get callClose => 'Закрыть';

  @override
  String get callMinimize => 'Свернуть';

  @override
  String get callAudioOutput => 'Звук звонка';

  @override
  String get callRoutePhone => 'Телефон';

  @override
  String get callRouteBluetooth => 'Bluetooth';

  @override
  String get callRouteHeadphones => 'Наушники';

  @override
  String get callFullScreenTitle => 'Звонки на экране блокировки';

  @override
  String get callFullScreenBody =>
      'Разрешите показывать входящий звонок на заблокированном экране, чтобы отвечать без разблокировки.';

  @override
  String get callFullScreenXiaomi =>
      'Xiaomi, Redmi и Poco не позволяют приложениям включать это самостоятельно: включите «Показывать на экране блокировки» в разделе «Другие разрешения».';

  @override
  String get circleMessage => 'Видеосообщение';

  @override
  String get appName => 'Cubechat';

  @override
  String get navChats => 'Чаты';

  @override
  String get navPeers => 'Рядом';

  @override
  String get navProfile => 'Профиль';

  @override
  String get navContacts => 'Контакты';

  @override
  String get navMap => 'Карта';

  @override
  String get mapTitle => 'Карта';

  @override
  String get mapFriendsTitle => 'Люди на карте';

  @override
  String get mapFriendsHint =>
      'Только эти контакты получают ваше местоположение';

  @override
  String mapClusterTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count человека здесь',
      many: '$count человек здесь',
      few: '$count человека здесь',
      one: '$count человек здесь',
    );
    return '$_temp0';
  }

  @override
  String get mapClusterHint =>
      'Нажмите на человека, чтобы перейти к нему на карте';

  @override
  String get mapNorthUp => 'Север вверх';

  @override
  String get mapLayerTitle => 'Вид карты';

  @override
  String get mapLayerHint => 'На чём нарисованы метки';

  @override
  String get mapLayerDark => 'Тёмная';

  @override
  String get mapLayerDarkHint =>
      'Улицы без подписей — самый спокойный фон под метками';

  @override
  String get mapLayerSatellite => 'Спутник';

  @override
  String get mapLayerSatelliteHint => 'Снимки сверху: какой дом, какой двор';

  @override
  String get mapLayerTerrain => 'Рельеф';

  @override
  String get mapLayerTerrainHint => 'Горизонтали и рельеф — для холмов и троп';

  @override
  String get mapFriendsEmpty => 'С вами пока никто не делится картой.';

  @override
  String get mapFriendsEmptyHint =>
      'Пригласите контакт — он появится здесь, как только примет приглашение.';

  @override
  String get mapFriendsInvite => 'Пригласить';

  @override
  String get mapFriendsRemove => 'Убрать с карты';

  @override
  String mapFriendsRemoved(String name) {
    return '$name больше не делится с вами картой';
  }

  @override
  String get mapFriendsLive => 'Сейчас на карте';

  @override
  String get mapFriendsIdle => 'Местоположения сейчас нет';

  @override
  String get mapInviteTitle => 'Пригласить на карту';

  @override
  String get mapInviteHint => 'Выберите один или несколько чатов';

  @override
  String get mapInviteEmpty => 'Пока нет чатов для приглашения.';

  @override
  String mapInviteAction(int count) {
    return 'Отправить ($count)';
  }

  @override
  String get mapInviteMessage =>
      'Приглашение на карту Cubechat. Отправьте свою геопозицию в этот чат, чтобы появиться на карте.';

  @override
  String mapInviteSent(int count) {
    return 'Отправлено приглашений: $count';
  }

  @override
  String get mapInviteFailed => 'Не удалось отправить приглашения';

  @override
  String mapPeopleVisible(int count) {
    return 'Общих геопозиций: $count';
  }

  @override
  String get mapCenterMe => 'Показать меня';

  @override
  String get mapNoSharedLocations => 'Пока нет геопозиций';

  @override
  String get mapNoSharedLocationsHint =>
      'Контакт появится здесь после того, как отправит геопозицию в чате.';

  @override
  String get mapWebHintTitle => 'Связи поблизости';

  @override
  String get mapWebHint => 'Линии показывают близость, а не маршрут сообщения.';

  @override
  String get mapOpenProfile => 'Профиль';

  @override
  String get mapLocationPrivacyOff => 'Геопозиция скрыта';

  @override
  String get mapLocationPrivacyOffHint =>
      'Включите «Показывать меня на карте» в разделе «Конфиденциальность», чтобы увидеть свою метку.';

  @override
  String get mapYouOnMap => 'Ваше местоположение видно на этом устройстве';

  @override
  String get locationSharingDisabled =>
      'Сначала включите «Показывать меня на карте» в разделе «Конфиденциальность».';

  @override
  String get mapLocationDenied => 'Доступ к геопозиции отключён';

  @override
  String get mapLocationServiceOff =>
      'Включите геолокацию, чтобы показать себя';

  @override
  String get mapLocationUnavailable =>
      'Не удалось определить ваше местоположение';

  @override
  String get mapDistanceUnknown => 'Расстояние неизвестно';

  @override
  String mapDistanceMetres(int metres) {
    return '$metres м от вас';
  }

  @override
  String mapDistanceKilometres(String kilometres) {
    return '$kilometres км от вас';
  }

  @override
  String get mapUpdatedNow => 'отправлено только что';

  @override
  String mapUpdatedMinutes(int minutes) {
    return 'отправлено $minutes мин назад';
  }

  @override
  String mapUpdatedHours(int hours) {
    return 'отправлено $hours ч назад';
  }

  @override
  String get contactsTitle => 'Контакты';

  @override
  String get contactsSubtitle => 'Все, с кем вы переписывались';

  @override
  String get contactsSearchHint => 'Поиск контактов…';

  @override
  String get contactsEmptyTitle => 'Пока нет контактов';

  @override
  String get contactsEmptyHint =>
      'Начните разговор — и собеседник появится здесь.';

  @override
  String get contactsSearchEmpty => 'Контакты не найдены';

  @override
  String get contactsTabContacts => 'Контакты';

  @override
  String get contactsTabCalls => 'Звонки';

  @override
  String get callsFilterAll => 'Все';

  @override
  String get callsFilterMissed => 'Пропущенные';

  @override
  String get callsEmptyTitle => 'Пока нет звонков';

  @override
  String get callsEmptyHint =>
      'Здесь появятся входящие, исходящие и пропущенные звонки.';

  @override
  String get callsMissedEmpty => 'Пропущенных звонков нет';

  @override
  String get callsCallBack => 'Позвонить';

  @override
  String get contactProfileChat => 'Чат';

  @override
  String get contactProfileCall => 'Звонок';

  @override
  String get contactProfileRadio => 'Рация';

  @override
  String get contactProfileSecurity => 'Безопасность';

  @override
  String get contactProfileActions => 'Действия с контактом';

  @override
  String get contactProfileVerify => 'Проверить';

  @override
  String get contactProfileCopyId => 'Копировать ID контакта';

  @override
  String get contactProfileIdCopied => 'ID контакта скопирован';

  @override
  String get contactProfileId => 'ID контакта';

  @override
  String get contactProfileVerifyHint =>
      'Сравните отпечатки ключей шифрования, чтобы подтвердить личность собеседника.';

  @override
  String get chatsTitle => 'Чаты';

  @override
  String get chatsSubtitle => 'Mesh · сквозное шифрование';

  @override
  String get chatsEmptyTitle => 'Пока нет переписок';

  @override
  String get chatsEmptyHint =>
      'Откройте собеседника на вкладке «Рядом», чтобы начать общение.';

  @override
  String get chatsFilterAll => 'Все';

  @override
  String get chatsFilterUnread => 'Непрочитанные';

  @override
  String get chatsFilterMesh => 'Mesh';

  @override
  String get chatsFilterFavorites => 'Избранные';

  @override
  String get chatsFolderDirect => 'Личные';

  @override
  String get chatsFolderChannels => 'Каналы';

  @override
  String get chatsFolderOnline => 'На связи';

  @override
  String get chatsFoldersTitle => 'Папки';

  @override
  String get chatsFoldersHint =>
      'Папки — это срезы того же списка, а не места, куда переносятся чаты. Включите те, что хотите видеть над чатами.';

  @override
  String get chatsSearchHint => 'Поиск чатов…';

  @override
  String get chatsStatusViaMesh => 'через mesh';

  @override
  String get chatsStatusOffline => 'офлайн';

  @override
  String get peerKeyRotated => 'ключ изменён — проверьте снова';

  @override
  String get peersTitle => 'Рядом';

  @override
  String get peersSubtitle => 'Устройства в радиусе Bluetooth';

  @override
  String get peersEmpty => 'Ищем собеседников…';

  @override
  String peersHopsOne(int n) {
    return '$n пересылка';
  }

  @override
  String peersHopsOther(int n) {
    return '$n пересылок';
  }

  @override
  String get blePermissionTitle => 'Нужно разрешение на Bluetooth';

  @override
  String get blePermissionHint =>
      'Cubechat использует Bluetooth, чтобы находить собеседников и отправлять сообщения — без интернета.';

  @override
  String get blePermissionGrant => 'Разрешить';

  @override
  String get blePermissionOpenSettings => 'Открыть настройки';

  @override
  String get blePermissionDeniedHint =>
      'В разрешении отказано. Откройте настройки, чтобы разрешить доступ к Bluetooth.';

  @override
  String get bleAdapterOffTitle => 'Bluetooth выключен';

  @override
  String get bleAdapterOffHint =>
      'Включите Bluetooth, чтобы видеть устройства поблизости.';

  @override
  String get bleUnsupportedTitle => 'Bluetooth LE недоступен';

  @override
  String get bleUnsupportedHint =>
      'Это устройство или платформа не поддерживает Bluetooth Low Energy. Попробуйте на смартфоне.';

  @override
  String get bleScanning => 'Поиск…';

  @override
  String get bleRetry => 'Повторить';

  @override
  String get bleEnable => 'Включить';

  @override
  String get bleConnectFailed =>
      'Не удалось подключиться. Устройство вне зоны действия, или его Bluetooth-адрес изменился.';

  @override
  String get bleSignal => 'Сигнал';

  @override
  String get bleConnect => 'Подключить';

  @override
  String get bleConnected => 'Подключено';

  @override
  String get bleVerified => 'Проверено';

  @override
  String get editorAdjustBrightness => 'Яркость';

  @override
  String get editorAdjustContrast => 'Контраст';

  @override
  String get editorAdjustSaturation => 'Насыщенность';

  @override
  String get editorToolCrop => 'Обрезать';

  @override
  String get editorToolDraw => 'Рисунок';

  @override
  String get editorToolAdjust => 'Настроить';

  @override
  String get editorTabSticker => 'Стикер';

  @override
  String get editorTabText => 'Текст';

  @override
  String get editorPenPen => 'Ручка';

  @override
  String get editorPenMarker => 'Маркер';

  @override
  String get editorPenNeon => 'Неон';

  @override
  String get editorPenArrow => 'Стрелка';

  @override
  String get editorPenBlur => 'Размытие';

  @override
  String get editorPenEraser => 'Ластик';

  @override
  String get editorLevel => 'Выровнять';

  @override
  String get editorTextHint => 'Текст на фото';

  @override
  String get editorCropFree => 'Свободно';

  @override
  String get editorRemove => 'Убрать';

  @override
  String get notificationUnknownSender => 'Новое сообщение';

  @override
  String get bleUnknownPeer => 'Неизвестное устройство';

  @override
  String get bleBroadcasting => 'В эфире';

  @override
  String bleConnectedCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n центральных устройства',
      many: '$n центральных устройств',
      few: '$n центральных устройства',
      one: '$n центральное устройство',
      zero: 'Нет подключений',
    );
    return '$_temp0';
  }

  @override
  String get verifyTitle => 'Проверка';

  @override
  String get verifyIntro =>
      'Сравните эти два отпечатка с собеседником лично или по голосовому звонку. Если они совпадают с обеих сторон — рукопожатие Noise не было подменено.';

  @override
  String get verifyMine => 'ВАШ ОТПЕЧАТОК';

  @override
  String verifyTheirs(String name) {
    return 'ОТПЕЧАТОК $name';
  }

  @override
  String get verifyMarkAsVerified => 'Отметить как проверенный';

  @override
  String get verifyAlreadyDone => 'Этот собеседник проверен.';

  @override
  String get verifyRevoke => 'Отменить';

  @override
  String verifyDoneSnack(String name) {
    return '$name: отмечен как проверенный';
  }

  @override
  String get chatInputHint => 'Сообщение';

  @override
  String get chatSend => 'Отправить';

  @override
  String get chatToday => 'Сегодня';

  @override
  String get chatYesterday => 'Вчера';

  @override
  String get chatDelivered => 'Доставлено';

  @override
  String get chatRead => 'Прочитано';

  @override
  String get chatSending => 'Отправляется';

  @override
  String get chatWaitingForConnection => 'Ожидает связи';

  @override
  String sendQueueCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count сообщения ожидают связи',
      many: '$count сообщений ожидают связи',
      few: '$count сообщения ожидают связи',
      one: '$count сообщение ожидает связи',
    );
    return '$_temp0';
  }

  @override
  String sendQueueSlowNetwork(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Медленная сеть — отправляем $count сообщения',
      many: 'Медленная сеть — отправляем $count сообщений',
      few: 'Медленная сеть — отправляем $count сообщения',
      one: 'Медленная сеть — отправляем $count сообщение',
    );
    return '$_temp0';
  }

  @override
  String get sendQueueTitle => 'Ожидают отправки';

  @override
  String get sendQueueHint =>
      'Они уйдут сами, как только появится путь — Bluetooth рядом или интернет. Ничего нажимать не нужно.';

  @override
  String get sendQueueRetry => 'Попробовать';

  @override
  String get sendQueueCancel => 'Отменить отправку';

  @override
  String get sendQueueCancelled => 'Не отправлено — отменено';

  @override
  String get sendQueueTooLate => 'Отменить уже нельзя: сообщение ушло';

  @override
  String get chatEncryptedNotice =>
      'Сообщения защищены сквозным шифрованием по протоколу Noise.';

  @override
  String get chatSessionHandshaking => 'Устанавливается защищённый канал…';

  @override
  String get chatSessionEstablished => 'Защищено · Noise XX';

  @override
  String get chatSessionFailed => 'Не удалось соединиться';

  @override
  String get presenceOnline => 'в сети';

  @override
  String get presenceOffline => 'не в сети';

  @override
  String get chatSessionFingerprintPending =>
      'Отпечаток появится после завершения рукопожатия.';

  @override
  String get chatEmptyEstablished =>
      'Защищённый канал готов. Отправьте сообщение, чтобы начать разговор.';

  @override
  String get chatEmptyHandshaking =>
      'Ждём, пока другая сторона завершит рукопожатие…';

  @override
  String get chatEmptyTitle => 'Здесь пока нет сообщений';

  @override
  String get chatEmptyGreetHint =>
      'Напишите сообщение или нажмите на Куби, чтобы поздороваться.';

  @override
  String get profileTitle => 'Профиль';

  @override
  String get profileNickname => 'Никнейм';

  @override
  String get profileNicknameEditTitle => 'Укажите никнейм';

  @override
  String get profileNicknameHint => 'Как вас видят другие в mesh-сети';

  @override
  String get profileNicknameSave => 'Сохранить';

  @override
  String get profileFingerprint => 'Отпечаток открытого ключа';

  @override
  String get profileLanguage => 'Язык';

  @override
  String get profileLanguageEn => 'Английский';

  @override
  String get profileLanguageUk => 'Украинский';

  @override
  String get profileTransport => 'Транспорт';

  @override
  String get profileTransportMesh => 'Bluetooth mesh';

  @override
  String get profileBackground => 'Работать в фоне';

  @override
  String get profileBackgroundSubtitle =>
      'Получать сообщения, когда приложение закрыто';

  @override
  String get profileBatteryExempt => 'Отключить оптимизацию батареи';

  @override
  String get profileAbout => 'О приложении';

  @override
  String profileVersion(String v) {
    return 'Версия $v';
  }

  @override
  String get rotateKeysTitle => 'Сменить ключи аккаунта';

  @override
  String get rotateKeysHint =>
      'Если устройство с вашим аккаунтом потеряли или украли';

  @override
  String get rotateKeysConfirmTitle => 'Сменить ключи аккаунта?';

  @override
  String get rotateKeysConfirmBody =>
      'Контакты получат ваши новые ключи и сохранят переписку, но каждого попросят проверить ваши ключи заново. Все остальные устройства аккаунта выйдут из него; нужные подключите снова с этого телефона. Контакты со старой версией CubeChat не смогут вам писать, пока не обновятся. Ключи каналов не изменятся.';

  @override
  String get rotateKeysConfirmAction => 'Сменить ключи';

  @override
  String get rotateKeysWorking => 'Меняем ключи…';

  @override
  String rotateKeysDone(int sent, int total) {
    return 'Новые ключи. Уведомлено контактов: $sent из $total';
  }

  @override
  String get rotateKeysSlow =>
      'Новые ключи. Не все контакты успели подтвердить; релеи сохранят уведомление для них';

  @override
  String get profileEmergencyWipe => 'Экстренная очистка';

  @override
  String get profileEmergencyWipeConfirm => 'Стереть всё?';

  @override
  String get profileEmergencyWipeConfirmHint =>
      'Будут удалены ваша личность, список контактов и история переписки. Это действие нельзя отменить.';

  @override
  String get profileEmergencyWipeAction => 'Стереть';

  @override
  String get cancel => 'Отмена';

  @override
  String get copy => 'Копировать';

  @override
  String get copied => 'Скопировано';

  @override
  String get channelsNewTitle => 'Новый канал';

  @override
  String get channelsNewTooltip => 'Новый канал';

  @override
  String get channelNameLabel => 'Название канала';

  @override
  String get channelPasswordLabel => 'Пароль (необязательно)';

  @override
  String get channelJoinAction => 'Войти';

  @override
  String get channelNameHint =>
      'Все, кто введёт то же название и пароль, попадут в одну комнату. Нет сервера, который хранил бы их список.';

  @override
  String get channelPasswordHint =>
      'Пароль и есть ключ. Без него комната открыта любому поблизости, кто знает её название.';

  @override
  String get channelSubtitle => 'Групповой канал · общий ключ';

  @override
  String get channelMute => 'Без звука';

  @override
  String get channelUnmute => 'Включить звук';

  @override
  String channelMutedUntil(String time) {
    return 'Без звука до $time';
  }

  @override
  String get channelMuteFor => 'Без звука на…';

  @override
  String channelMuteMinutes(int minutes) {
    return '$minutes мин';
  }

  @override
  String channelMuteHours(int hours) {
    return '$hours ч';
  }

  @override
  String channelMuteDays(int days) {
    return '$days дн.';
  }

  @override
  String get channelMuteForever => 'Пока не включу снова';

  @override
  String get channelCommunity => 'Комментарии';

  @override
  String get channelCommunityOpen => 'Открыть обсуждение';

  @override
  String channelCommunitySubtitle(String channel) {
    return 'Обсуждение $channel';
  }

  @override
  String get channelBackToChannel => 'К каналу';

  @override
  String get channelMemberActions => 'Участник';

  @override
  String get channelRemoveMember => 'Удалить из канала';

  @override
  String get channelRemoveMemberHint =>
      'Его посты больше не будут приниматься здесь. Ничто не мешает ему снова войти по названию — общий ключ и есть всё членство.';

  @override
  String get channelMuteMember => 'Заглушить на…';

  @override
  String get channelUnmuteMember => 'Разрешить писать снова';

  @override
  String channelMemberRemoved(String name) {
    return '$name удалён';
  }

  @override
  String channelMemberMuted(String name) {
    return '$name заглушён';
  }

  @override
  String channelMemberCleared(String name) {
    return '$name снова может писать';
  }

  @override
  String get channelMemberMutedNote => 'Заглушён';

  @override
  String get channelShareHistory => 'Поделиться историей';

  @override
  String get channelShareHistoryHint =>
      'Возвращает в эфир последние посты этой комнаты, чтобы их увидел тот, кто присоединился позже. Те, кто уже был здесь, ничего нового не получат.';

  @override
  String channelHistoryShared(int count) {
    return 'Предложено постов: $count';
  }

  @override
  String get channelHistoryNothing => 'Пока нечем делиться';

  @override
  String get channelHistoryAuto => 'Отдавать историю новым участникам';

  @override
  String get channelHistoryAutoHint =>
      'Когда в комнате появляется кто-то новый, последние посты уходят к нему сами. Пока только текст — фото передаются потоком частей, и повторить их без дублирования для всех нельзя.';

  @override
  String get channelPostComments => 'Комментарии';

  @override
  String get channelNoComments => 'Об этом посте пока ничего не сказали';

  @override
  String get channelCommentHint => 'Комментарий';

  @override
  String get channelMuteCustom => 'На сколько?';

  @override
  String get channelMuteCustomHint => 'Часов';

  @override
  String get chatPinnedManage => 'Закреплённые';

  @override
  String get chatPeekOpen => 'Открыть чат';

  @override
  String get chatPeekPin => 'Закрепить';

  @override
  String get chatPeekUnpin => 'Открепить';

  @override
  String get chatPeekUnmute => 'Включить звук';

  @override
  String get chatPeekMarkRead => 'Отметить прочитанным';

  @override
  String get chatDeleteForMeHint =>
      'Убрать с этого телефона и открепить. У собеседника копия останется.';

  @override
  String get pushWakeTitle => 'Будить этот телефон';

  @override
  String get pushWakeHint =>
      'Небольшой сервер следит за релеями для вашего адреса и будит этот телефон, когда что-то приходит, — чтобы закрытое приложение всё равно вам сообщило. Он не видит ни сообщений, ни ключей: только то, что на ваш адрес что-то пришло, и когда. Релей это уже знает; здесь появляется второе такое место.';

  @override
  String get pushWakeDeniedTitle => 'Уведомления отключены';

  @override
  String get pushWakeDeniedHint =>
      'Система однажды услышала «нет» и больше не спросит, поэтому включить это можно только в Настройках — cubechat, затем «Уведомления». После этого вернитесь сюда.';

  @override
  String get pushWakeRefused => 'Уведомления не разрешены';

  @override
  String get privacyForwardLinkTitle => 'Ссылка на профиль в пересылках';

  @override
  String get privacyForwardLinkHint =>
      'Когда кто-то пересылает ваше сообщение, строка над ним может открывать ваш профиль. Если выключено, видно только имя, нажать не на что. Это просьба к их приложению, а не то, что это может обеспечить.';

  @override
  String get privacyShareSheetTitle => 'Чаты в меню «Поделиться»';

  @override
  String get privacyShareSheetOnHint =>
      'Имена четырёх последних чатов передаются Android, чтобы отправлять им из любого приложения. Блокировка приложения их не скрывает.';

  @override
  String get privacyShareSheetOffHint =>
      'Android ничего не получает. Отправляя в CubeChat, вы выбираете чат из списка.';

  @override
  String get privacyCallsTitle => 'Принимать звонки';

  @override
  String get privacyCallsOnHint =>
      'Ваши контакты могут вам звонить. Чтобы запретить кому-то одному, откройте его профиль.';

  @override
  String get privacyCallsOffHint =>
      'Никто не может вам звонить, кроме тех, кому вы разрешили в их профиле. Отклонённый звонок они увидят как «занято».';

  @override
  String get chatsStatusChannel => 'канал';

  @override
  String get channelInviteTitle => 'Добавить участников';

  @override
  String get channelInviteAction => 'Пригласить';

  @override
  String get channelInviteEmpty =>
      'Пока нет знакомых собеседников. Сначала найдите кого-нибудь на вкладке «Рядом».';

  @override
  String get channelInviteSent => 'Приглашения отправлены';

  @override
  String get channelInviteNoneSent => 'Сейчас никого не удалось достичь';

  @override
  String get channelNameTooLong => 'Слишком длинное название канала';

  @override
  String get chatsActionFavorite => 'В избранное';

  @override
  String get chatsActionUnfavorite => 'Убрать из избранного';

  @override
  String get chatsActionDelete => 'Удалить чат';

  @override
  String get chatsDeleteTitle => 'Удалить этот чат?';

  @override
  String chatsDeleteManyHint(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Будут очищены $count переписки. Контакты останутся, и вы сможете снова написать им без обмена кодами.',
      many:
          'Будут очищены $count переписок. Контакты останутся, и вы сможете снова написать им без обмена кодами.',
      few:
          'Будут очищены $count переписки. Контакты останутся, и вы сможете снова написать им без обмена кодами.',
      one:
          'Будет очищена $count переписка. Контакты останутся, и вы сможете снова написать им без обмена кодами.',
    );
    return '$_temp0';
  }

  @override
  String get chatsDeletedToast => 'Чат удалён.';

  @override
  String chatsDeletedManyToast(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Удалено $count чата.',
      many: 'Удалено $count чатов.',
      few: 'Удалено $count чата.',
      one: 'Удалён $count чат.',
    );
    return '$_temp0';
  }

  @override
  String get undo => 'Отменить';

  @override
  String get chatsDeletePeerHint =>
      'Переписка будет очищена. Контакт останется — написать ему снова можно без обмена кодами.';

  @override
  String get chatsDeleteChannelHint =>
      'Вы выйдете из канала и удалите его историю. Чтобы вернуться, понадобится ключ.';

  @override
  String get chatsDeleteForThemToo => 'Удалить и у собеседника';

  @override
  String get chatsDeleteForThemHint =>
      'Попросит его приложение стереть всю переписку, включая его собственные сообщения. В канале отзываются только ваши.';

  @override
  String get chatEditAction => 'Изменить';

  @override
  String get chatEditTitle => 'Изменить сообщение';

  @override
  String get chatEditSave => 'Сохранить';

  @override
  String get chatEdited => 'изменено';

  @override
  String get chatDeleteAction => 'Удалить';

  @override
  String get chatDeleteTitle => 'Удалить сообщение?';

  @override
  String get chatDeleteForMe => 'Удалить у меня';

  @override
  String get chatDeleteForEveryone => 'Удалить у всех';

  @override
  String get chatPinTitle => 'Закрепить сообщение?';

  @override
  String get chatPinForBoth => 'Закрепить у обоих';

  @override
  String get chatPinForMe => 'Закрепить только у меня';

  @override
  String get chatReplyAction => 'Ответить';

  @override
  String chatReplyingTo(String name) {
    return 'Ответ для $name';
  }

  @override
  String get chatReplyYou => 'себя';

  @override
  String get chatCopyAction => 'Копировать';

  @override
  String get chatCopied => 'Скопировано';

  @override
  String get chatForwardAction => 'Переслать';

  @override
  String get chatForwardTitle => 'Переслать в';

  @override
  String get shareIntoTitle => 'Отправить в';

  @override
  String get shareNearbyAirDrop => 'Рядом через AirDrop';

  @override
  String get shareNearbyAirDropHint => 'Без интернета — тем, кто рядом';

  @override
  String get shareSent => 'Отправлено';

  @override
  String get shareFailed => 'Часть не удалось отправить';

  @override
  String get chatForwardEmpty => 'Других чатов пока нет';

  @override
  String chatForwardSendCount(int count) {
    return 'Отправить ($count)';
  }

  @override
  String chatForwardSentCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Переслано в $count чата',
      many: 'Переслано в $count чатов',
      few: 'Переслано в $count чата',
      one: 'Переслано в $count чат',
    );
    return '$_temp0';
  }

  @override
  String chatForwardSent(String name) {
    return 'Переслано: $name';
  }

  @override
  String chatSentAt(String time) {
    return 'Отправлено $time';
  }

  @override
  String chatReadAt(String time) {
    return 'Прочитано $time';
  }

  @override
  String get chatPinAction => 'Закрепить';

  @override
  String get chatUnpinAction => 'Открепить';

  @override
  String chatPinnedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count закреплённого сообщения',
      many: '$count закреплённых сообщений',
      few: '$count закреплённых сообщения',
      one: '$count закреплённое сообщение',
      zero: 'Нет закреплённых',
    );
    return '$_temp0';
  }

  @override
  String get chatNoPins => 'Здесь ничего не закреплено';

  @override
  String get chatUnpinAll => 'Открепить все сообщения';

  @override
  String get chatShowAllPins => 'Все закреплённые сообщения';

  @override
  String get chatUnpinConfirm => 'Открепить это сообщение?';

  @override
  String get chatUnpinConfirmHint =>
      'Оно перестанет быть закреплённым для всех в этом чате.';

  @override
  String get chatPinnedTitle => 'Закреплённое сообщение';

  @override
  String get chatPinnedGone => 'Этого сообщения уже нет в чате';

  @override
  String get peerBlock => 'Заблокировать';

  @override
  String get peerUnblock => 'Разблокировать';

  @override
  String get peerMute => 'Без звука';

  @override
  String get peerUnmute => 'Включить звук';

  @override
  String get peerBlockedNote => 'Заблокирован — его сообщения отбрасываются.';

  @override
  String get relaysTitle => 'Резервный канал через интернет';

  @override
  String get relaysCardTitle => 'Связь через интернет';

  @override
  String get relaysCardSubtitle =>
      'Когда Bluetooth не доставляет — отправлять через релеи Nostr';

  @override
  String get relaysExplainer =>
      'Сообщения остаются защищены сквозным шифрованием — релей передаёт тот же запечатанный кадр, что и Bluetooth. Но он видит, какие два ключа общаются и когда. По умолчанию выключено.';

  @override
  String get relaysMyAddress => 'Ваш адрес на релеях';

  @override
  String get relaysCopied => 'Скопировано';

  @override
  String get circleLensTitle => 'Фронтальная камера для кружков';

  @override
  String get circleLensFrontHint =>
      'Кружки снимаются камерой, направленной на вас.';

  @override
  String get circleLensBackHint =>
      'Кружки снимаются основной камерой — чтобы показать то, на что вы смотрите.';

  @override
  String get channelCloseTitle => 'Закрыть комнату для всех';

  @override
  String get channelCloseSubtitle =>
      'Удалит её с телефона каждого участника. Это можете сделать только вы.';

  @override
  String get channelCloseConfirm =>
      'Комната, её сообщения и участники исчезнут с каждого телефона, где она есть. Никто не заблокирован: ключ выводится из названия, так что кто его помнит, тот снова откроет пустую комнату.';

  @override
  String get channelCloseAction => 'Закрыть комнату';

  @override
  String get circleHint => 'Отпустите, чтобы отправить · влево — отмена';

  @override
  String get circleHintLocked => 'Нажмите «Отправить», когда закончите';

  @override
  String get circleNeedsCamera => 'Для кружков нужны камера и микрофон';

  @override
  String get circleFailed => 'Не удалось записать кружок';

  @override
  String get relaysListLabel => 'Релеи';

  @override
  String get relaysLaneMedia => 'Релеи для медиа';

  @override
  String get relaysLaneMediaNote =>
      'Фото, файлы и видео идут через них, чтобы передача не тормозила переписку.';

  @override
  String get relaysLaneLocation => 'Релеи для геопозиции';

  @override
  String get relaysLaneLocationNote =>
      'Маячки на карте идут через них, отдельно от всего остального.';

  @override
  String get relaysAdd => 'Добавить релей';

  @override
  String get relaysAddHint => 'wss://relay.example.com';

  @override
  String get relaysInvalidUrl => 'Введите адрес wss:// или ws://';

  @override
  String get relaysRemove => 'Удалить';

  @override
  String get relaysStateConnected => 'Подключено';

  @override
  String get relaysStateConnecting => 'Подключение…';

  @override
  String get relaysStateFailed => 'Недоступен';

  @override
  String get relaysStateIdle => 'Выключен';

  @override
  String get relaysEmpty => 'Релеи не настроены — резервный канал выключен.';

  @override
  String get contactTitle => 'Карточка контакта';

  @override
  String get contactMineLabel => 'Ваша карточка';

  @override
  String get contactMineExplainer =>
      'Отправьте её тому, кто вне зоны Bluetooth. В ней ваши ключи и адрес на релеях — этого достаточно, чтобы начать с вами зашифрованный чат через интернет.';

  @override
  String get contactCopy => 'Копировать';

  @override
  String get contactShare => 'Поделиться';

  @override
  String get contactCopied => 'Карточка скопирована';

  @override
  String get contactShareSubject => 'Моя карточка контакта cubechat';

  @override
  String get contactAddLabel => 'Добавить человека';

  @override
  String get contactAddHint => 'Вставьте карточку контакта';

  @override
  String get contactAddAction => 'Добавить';

  @override
  String get contactPaste => 'Вставить';

  @override
  String contactAdded(String name) {
    return '$name добавлен';
  }

  @override
  String get contactInvalid => 'Это не карточка контакта';

  @override
  String get contactOwnCard => 'Это ваша собственная карточка';

  @override
  String get contactUnverified =>
      'Контакт, добавленный так, изначально не проверен. Любой может создать карточку и написать на ней любое имя, поэтому сверьте отпечатки лично или по звонку, прежде чем доверять.';

  @override
  String get contactRelayOff =>
      'Резервный канал через интернет выключен, поэтому карточка пока никого не достигнет.';

  @override
  String get contactRelayEnable => 'Включить';

  @override
  String get profileContactCard => 'Карточка контакта';

  @override
  String get chatsAddContactTooltip => 'Добавить контакт по карточке';

  @override
  String get chatsMenuTooltip => 'Ещё';

  @override
  String get chatsMenuAddContact => 'Добавить контакт';

  @override
  String get chatsMenuNewChannel => 'Новый канал';

  @override
  String get profileDiscoverable => 'Видимость рядом';

  @override
  String get profileDiscoverableOnHint => 'Вас найдёт любой в радиусе';

  @override
  String get profileDiscoverableOffHint => 'Вас найдут только ваши контакты';

  @override
  String get profileDiscoverableExplainer =>
      'Если включено, ваш анонс передаётся открыто: незнакомец может познакомиться, просто подойдя, но и любой рядом запишет ваш ключ и имя. Если выключено, тот же набор уходит только имеющимся контактам в запечатанном виде, а ваши маршрутные ID невозможно связать между собой. Новым людям тогда понадобится карточка контакта.';

  @override
  String get voiceHoldHint => 'Удерживайте, чтобы записать голосовое';

  @override
  String get voiceTrimPlay => 'Воспроизвести';

  @override
  String get voiceTrimPause => 'Пауза';

  @override
  String get voiceTrimDiscard => 'Удалить запись';

  @override
  String voiceTrimSelection(String duration) {
    return 'Отправляем $duration';
  }

  @override
  String get profileLastSeen => 'Показывать время в сети';

  @override
  String get profileLastSeenOnHint => 'Контакты видят, когда вы в приложении';

  @override
  String get profileLastSeenOffHint =>
      'Ваше время не видит никто, и вы не видите чужое — только кто в сети';

  @override
  String get profileMapLocation => 'Показывать меня на карте';

  @override
  String get profileMapLocationOnHint =>
      'Геопозицию можно отправлять вручную, а ваша метка видна на карте';

  @override
  String get profileMapLocationOffHint =>
      'Приложение не запрашивает геопозицию, а ваша метка скрыта';

  @override
  String get desktopAutostartTitle => 'Запускать вместе с Windows';

  @override
  String get desktopAutostartHint =>
      'CubeChat ждёт в трее, поэтому звонки и сообщения доходят до компьютера даже с закрытым окном';

  @override
  String get trayOpen => 'Открыть CubeChat';

  @override
  String get trayQuit => 'Выйти';

  @override
  String get callDirectTitle => 'Прямые звонки';

  @override
  String get callDirectOnHint => 'Быстрее, но собеседник узнает ваш IP-адрес';

  @override
  String get callDirectOffHint =>
      'Звонки идут через наш ретранслятор: собеседник не видит ваш IP-адрес, а ретранслятор не слышит разговор';

  @override
  String get profileReadReceipts => 'Отчёты о прочтении';

  @override
  String get profileReadReceiptsOnHint => 'Отправитель видит, что вы прочитали';

  @override
  String get profileReadReceiptsOffHint =>
      'Вы не отправляете время прочтения, но видите его от других';

  @override
  String get profilePrivacyExplainer =>
      'Время в сети работает в обе стороны: скрыв свой статус, вы перестаёте видеть чужой. Отчёты о прочтении управляют только тем, что отправляете вы. На доставку сообщений это не влияет.';

  @override
  String get chatTimerAction => 'Таймер';

  @override
  String get chatTimerRemove => 'Убрать таймер';

  @override
  String get chatTimerTitle => 'Удалить это сообщение через';

  @override
  String chatTimerSet(String time) {
    return 'Сообщение исчезнет через $time';
  }

  @override
  String get chatTimerLocalHint =>
      'Только на этом устройстве — их копия остаётся у них';

  @override
  String get contactTagAction => 'Метка';

  @override
  String get contactTagRemove => 'Убрать метку';

  @override
  String get contactTagTitle => 'Выберите метку';

  @override
  String get contactTagAll => 'Все';

  @override
  String get quietHoursTitle => 'Тихие часы';

  @override
  String get quietHoursHint => 'Сообщения приходят, телефон молчит';

  @override
  String get quietHoursFrom => 'С';

  @override
  String get quietHoursTo => 'До';

  @override
  String get notifPreviewTitle => 'Показывать в уведомлениях';

  @override
  String get notifPreviewFull => 'Имя и текст';

  @override
  String get notifPreviewNameOnly => 'Только имя';

  @override
  String get notifPreviewHidden => 'Ничего';

  @override
  String get notifPreviewHint =>
      'Уведомления видны на экране блокировки и приложениям с доступом к уведомлениям — даже при включённой блокировке приложения';

  @override
  String get notifPreviewNewMessage => 'Новое сообщение';

  @override
  String get appLockTitle => 'Блокировка приложения';

  @override
  String get appLockHint => 'Запрашивать код при открытии';

  @override
  String get appLockPrompt => 'Введите код';

  @override
  String get appLockUnlock => 'Разблокировать';

  @override
  String get appLockWrong => 'Неверный код';

  @override
  String get appLockSetTitle => 'Задать код';

  @override
  String get appLockSetHint =>
      'Четыре цифры или больше. Восстановить его невозможно.';

  @override
  String get appLockOffTitle => 'Выключить блокировку';

  @override
  String get appLockOffHint => 'Введите текущий код';

  @override
  String get appLockOn => 'Блокировка включена';

  @override
  String get appLockOff => 'Блокировка выключена';

  @override
  String get avatarSet => 'Выбрать фото';

  @override
  String get avatarChange => 'Изменить фото';

  @override
  String get avatarView => 'Посмотреть фото';

  @override
  String get profileCoverPhoto => 'Фото профиля, двойное касание увеличивает';

  @override
  String get profileCoverMenu => 'Действия с фото';

  @override
  String get avatarSaved => 'Сохранено в галерею';

  @override
  String get avatarRemove => 'Убрать фото';

  @override
  String get avatarRemoveConfirm =>
      'Аватарка будет удалена с этого устройства. Вместо неё вернётся сгенерированный градиент.';

  @override
  String get avatarFailed => 'Не удалось прочитать изображение';

  @override
  String get fileOpenHint => 'Нажмите, чтобы открыть';

  @override
  String get fileMissing => 'Файл больше недоступен';

  @override
  String get fileNoHandlerTitle => 'Нет приложения для этого файла';

  @override
  String get fileNoHandlerHint =>
      'Ни одно установленное приложение не открывает этот тип. Можно отправить его в другое приложение.';

  @override
  String get fileRequestedAgain => 'Попросили отправить ещё раз';

  @override
  String get fileOpenFailed => 'Не удалось открыть этот файл';

  @override
  String get fileShareAction => 'Отправить в приложение';

  @override
  String fileTooLargeMesh(int limit) {
    return 'Файл слишком большой — максимум $limit МБ через mesh-сеть';
  }

  @override
  String fileTooLargeRelay(int limit) {
    return 'Через интернет можно отправить до $limit МБ. Подойдите ближе к собеседнику, чтобы отправить файл побольше.';
  }

  @override
  String get mediaSendOriginal => 'Оригинал';

  @override
  String get attachFile => 'Файл';

  @override
  String get attachGallery => 'Галерея';

  @override
  String get attachCamera => 'Камера';

  @override
  String get cameraUnavailable => 'Камера недоступна';

  @override
  String get profileEditName => 'Имя';

  @override
  String get profileMyCard => 'Карточка';

  @override
  String get mediaCaptionHint => 'Добавить подпись…';

  @override
  String get mediaDiscardTitle => 'Отменить выбор?';

  @override
  String get mediaDiscardMessage => 'Закрыть галерею и отменить выбор фото?';

  @override
  String get mediaDiscardConfirm => 'Отменить';

  @override
  String get mediaPhotosAccessOff => 'Доступ к фото выключен';

  @override
  String get mediaPhotosAccessOffHint =>
      'Сейчас CubeChat видит только видео. Разрешите доступ к фото в системных настройках, чтобы показать изображения.';

  @override
  String get mediaVideosOnly => 'Видно только видео — разрешите доступ к фото';

  @override
  String get mediaOpenSettings => 'Открыть настройки';

  @override
  String get mediaTakePhoto => 'Сделать фото';

  @override
  String get contactProfileAutoDelete => 'Автоудаление';

  @override
  String get contactProfileAutoDeleteTitle => 'Автоудаление сообщений';

  @override
  String get contactProfileAutoDeleteOff => 'Выключено';

  @override
  String get contactProfileAutoDeleteOneDay => 'Через 1 день';

  @override
  String get contactProfileAutoDeleteSevenDays => 'Через 7 дней';

  @override
  String get contactProfileAutoDeleteThirtyDays => 'Через 30 дней';

  @override
  String contactProfileAutoDeleteUpdated(String period) {
    return 'Автоудаление: $period';
  }

  @override
  String get contactProfileShare => 'Поделиться контактом';

  @override
  String get contactProfileShareTitle => 'Отправить контакт в';

  @override
  String get contactProfileShareEmpty => 'Других чатов пока нет';

  @override
  String contactProfileShareSent(String name) {
    return 'Отправлено: $name';
  }

  @override
  String get contactProfileRestrictCopying => 'Запретить копирование';

  @override
  String get contactProfileAllowCopying => 'Разрешить копирование';

  @override
  String get contactHideAvatar => 'Скрыть моё фото';

  @override
  String get contactShowAvatar => 'Показывать моё фото';

  @override
  String get contactHideLastSeen => 'Скрыть моё время в сети';

  @override
  String get contactShowLastSeen => 'Показывать моё время в сети';

  @override
  String get contactHideReadReceipts => 'Скрыть моё время прочтения';

  @override
  String get contactShowReadReceipts => 'Показывать моё время прочтения';

  @override
  String get contactHiddenFromThem => 'Скрыто от этого контакта';

  @override
  String get contactRefuseCalls => 'Не принимать его звонки';

  @override
  String get contactAllowCalls => 'Принимать его звонки';

  @override
  String get contactCallsException => 'Исключение из ваших настроек звонков';

  @override
  String get contactProfileCopyingRestricted =>
      'Копирование и пересылка запрещены';

  @override
  String get contactProfileCopyingRestrictedByPeer => 'Запрещено собеседником';

  @override
  String get contactProfileCopyingAllowed =>
      'Копирование и пересылка разрешены';

  @override
  String get contactProfileDelete => 'Удалить из контактов';

  @override
  String get contactProfileRestore => 'Вернуть в контакты';

  @override
  String get contactProfileRestoreDone => 'Снова в ваших контактах';

  @override
  String get contactProfileDeleteTitle => 'Удалить контакт?';

  @override
  String contactProfileDeleteMessage(String name) {
    return '$name исчезнет из раздела «Контакты». История чата останется на этом устройстве.';
  }

  @override
  String get contactProfileMedia => 'Медиа';

  @override
  String get contactProfileVoiceMessages => 'Голосовые';

  @override
  String get contactProfileStickers => 'Стикеры';

  @override
  String get contactProfileNoStickers => 'Стикеров пока нет';

  @override
  String get contactProfileNoMedia => 'Медиа пока нет';

  @override
  String get contactProfileNoVoiceMessages => 'Голосовых сообщений пока нет';

  @override
  String get contactProfileOpen => 'Открыть профиль';

  @override
  String autoDeleteDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count дня',
      many: '$count дней',
      few: '$count дня',
      one: '$count день',
    );
    return '$_temp0';
  }

  @override
  String autoDeleteHours(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count часа',
      many: '$count часов',
      few: '$count часа',
      one: '$count час',
    );
    return '$_temp0';
  }

  @override
  String autoDeleteMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count минуты',
      many: '$count минут',
      few: '$count минуты',
      one: '$count минута',
    );
    return '$_temp0';
  }

  @override
  String autoDeleteSeconds(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count секунды',
      many: '$count секунд',
      few: '$count секунды',
      one: '$count секунда',
    );
    return '$_temp0';
  }

  @override
  String get autoDeleteCustom => 'Свой вариант…';

  @override
  String get autoDeleteCustomHint => 'Количество';

  @override
  String get autoDeleteUnitMinutes => 'мин';

  @override
  String get autoDeleteUnitHours => 'ч';

  @override
  String get autoDeleteUnitDays => 'дн.';

  @override
  String get contactProfileAutoDeleteSet => 'Установить';

  @override
  String get contactProfileFiles => 'Файлы';

  @override
  String get contactProfileNoFiles => 'Файлов пока нет';

  @override
  String get contactProfileLinks => 'Ссылки';

  @override
  String get contactProfileNoLinks => 'Ссылок пока нет';

  @override
  String get contactProfilePolls => 'Опросы';

  @override
  String get contactProfileNoPolls => 'Опросов пока нет';

  @override
  String get presenceRecently => 'был(а) недавно';

  @override
  String get presenceJustNow => 'только что';

  @override
  String presenceHoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'был(а) $count часа назад',
      many: 'был(а) $count часов назад',
      few: 'был(а) $count часа назад',
      one: 'был(а) $count час назад',
    );
    return '$_temp0';
  }

  @override
  String presenceYesterdayAt(String time) {
    return 'был(а) вчера в $time';
  }

  @override
  String presenceOnWeekday(String day) {
    String _temp0 = intl.Intl.selectLogic(
      day,
      {
        '1': 'был(а) в понедельник',
        '2': 'был(а) во вторник',
        '3': 'был(а) в среду',
        '4': 'был(а) в четверг',
        '5': 'был(а) в пятницу',
        '6': 'был(а) в субботу',
        '7': 'был(а) в воскресенье',
        'other': 'был(а) на этой неделе',
      },
    );
    return '$_temp0';
  }

  @override
  String presenceWeeksAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'был(а) $count недели назад',
      many: 'был(а) $count недель назад',
      few: 'был(а) $count недели назад',
      one: 'был(а) неделю назад',
    );
    return '$_temp0';
  }

  @override
  String presenceMonthsAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'был(а) $count месяца назад',
      many: 'был(а) $count месяцев назад',
      few: 'был(а) $count месяца назад',
      one: 'был(а) месяц назад',
    );
    return '$_temp0';
  }

  @override
  String get presenceLongAgo => 'был(а) давно';

  @override
  String presenceMinutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'был(а) $count минуты назад',
      many: 'был(а) $count минут назад',
      few: 'был(а) $count минуты назад',
      one: 'был(а) $count минуту назад',
    );
    return '$_temp0';
  }

  @override
  String chatReadByCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Прочитали $count',
      many: 'Прочитали $count',
      few: 'Прочитали $count',
      one: 'Прочитал $count',
    );
    return '$_temp0';
  }

  @override
  String get chatsSearchFrequent => 'С кем вы общаетесь';

  @override
  String get chatsSearchRecent => 'Недавние';

  @override
  String get chatsSearchClear => 'Очистить';

  @override
  String get chatsSearchStartHint =>
      'Ищите чаты по названию или любое сообщение по словам.';

  @override
  String get chatsSearchEmpty => 'Ничего не найдено';

  @override
  String get chatRoutesTitle => 'Как это до него дойдёт';

  @override
  String get chatRoutesBluetoothHint => 'Прямо на его телефон, без интернета';

  @override
  String get chatRoutesMeshHint => 'Через телефоны, которые между вами';

  @override
  String get chatRoutesInternetHint => 'Через релей, когда рядом никого нет';

  @override
  String get chatRoutesHint =>
      'Путь выбирается для каждого сообщения отдельно — из того, что доступно именно в этот момент.';

  @override
  String get chatRoutesPreferTitle => 'Что пробовать первым';

  @override
  String get chatRoutesPreferMesh => 'Сначала Bluetooth';

  @override
  String get chatRoutesPreferMeshHint =>
      'Быстрее в одной комнате, не тратит трафик и ничего не сообщает релею';

  @override
  String get chatRoutesPreferRelay => 'Сначала интернет';

  @override
  String get chatRoutesPreferRelayHint =>
      'Когда Bluetooth еле держит, а связь хорошая';

  @override
  String get chatRoutesPreferNote =>
      'Это предпочтение, а не запрет. Если выбранный путь недоступен, сообщение всё равно уйдёт другим.';

  @override
  String get deadmanTitle => 'Стереть при неактивности';

  @override
  String get deadmanOff => 'Выключено';

  @override
  String deadmanDays(int days) {
    return 'Через $days дн.';
  }

  @override
  String get deadmanHint =>
      'Если приложение не открывать столько времени, всё в нём будет стёрто при следующем открытии. Предупредить оно не сможет — в этом и смысл.';

  @override
  String chatForwardedFrom(String name) {
    return 'Переслано от $name';
  }

  @override
  String appLockWait(String left) {
    return 'Слишком много попыток — подождите $left';
  }

  @override
  String get appLockGraceTitle => 'Запрашивать код';

  @override
  String get appLockGraceNow => 'Каждый раз';

  @override
  String appLockGraceAfter(String left) {
    return 'Через $left отсутствия';
  }

  @override
  String get chatCalendarTitle => 'По датам';

  @override
  String get chatCalendarEmpty => 'Здесь пока ничего не сказано';

  @override
  String get chatsSearchChatsSection => 'Чаты';

  @override
  String get chatsSearchMessagesSection => 'Сообщения';

  @override
  String get contactProfileViewInChat => 'Показать в чате';

  @override
  String get chatDraft => 'Черновик';

  @override
  String get chatSearchTitle => 'Поиск';

  @override
  String get chatSearchHint => 'Поиск по сообщениям';

  @override
  String get chatSearchNoResults => 'Ничего не найдено';

  @override
  String get chatSearchPrevious => 'Предыдущий результат';

  @override
  String get chatSearchNext => 'Следующий результат';

  @override
  String chatMessageCount(int count) {
    return 'Сообщений: $count';
  }

  @override
  String get chatRouteBluetooth => 'Bluetooth';

  @override
  String get chatRouteMesh => 'Mesh';

  @override
  String get chatRouteInternet => 'Интернет';

  @override
  String get chatRouteQueued => 'В очереди';

  @override
  String get attachStickers => 'Стикеры';

  @override
  String get stickersEmpty => 'Стикеров пока нет';

  @override
  String get stickersEmptyHint =>
      'Сохраните картинку из чата — и она появится здесь.';

  @override
  String get stickerKeep => 'Сохранить как стикер';

  @override
  String get stickerKept => 'Сохранено в стикеры';

  @override
  String get stickerForget => 'Удалить стикер';

  @override
  String get stickerCreate => 'Сделать стикер из фото';

  @override
  String get stickerFailed => 'Не удалось сделать стикер из этой картинки';

  @override
  String get stickerLabel => 'Стикер';

  @override
  String get previewPhoto => 'Фото';

  @override
  String get previewVoice => 'Голосовое сообщение';

  @override
  String get previewFile => 'Файл';

  @override
  String get stickerEmojiTitle => 'Выберите для него эмодзи';

  @override
  String get stickersMine => 'Мои стикеры';

  @override
  String get stickersStarterPack => 'Куби';

  @override
  String get emojiTab => 'Эмодзи';

  @override
  String get chatBlockedStatus => 'заблокирован';

  @override
  String get chatBlockedHint => 'Вы заблокировали этого человека';

  @override
  String get chatRouteFallbackOff => 'Интернет выкл.';

  @override
  String get chatAttachmentUnavailable =>
      'Нет доступного соединения. Подключитесь через Bluetooth или интернет и попробуйте ещё раз.';

  @override
  String get fileTransfersTitle => 'Передача файлов';

  @override
  String get fileTransfersClear => 'Очистить историю';

  @override
  String get fileTransfersEmpty => 'Передач файлов пока нет';

  @override
  String get fileTransfersActive => 'Активные';

  @override
  String get fileTransfersHistory => 'История';

  @override
  String get fileTransferPause => 'Пауза';

  @override
  String get fileTransferResume => 'Продолжить';

  @override
  String get fileTransferRetry => 'Повторить';

  @override
  String get fileTransferQueued => 'Ожидает соединения';

  @override
  String get fileTransferRunning => 'Передаётся';

  @override
  String get fileTransferPaused => 'Приостановлено';

  @override
  String get fileTransferCompleted => 'Завершено';

  @override
  String get fileTransferFailed => 'Ошибка';

  @override
  String get fileTransferCanceled => 'Отменено';

  @override
  String get profileFileTransfers => 'Передача файлов';

  @override
  String get profileFileTransfersSubtitle =>
      'Прогресс, очередь и история передач';

  @override
  String get qrScanAction => 'Сканировать QR-код';

  @override
  String get qrScanTitle => 'Сканирование QR-кода';

  @override
  String get qrScanHint =>
      'Отсканируйте QR-код контакта, канала, переноса аккаунта или входа на компьютере CubeChat.';

  @override
  String get qrFlash => 'Фонарик';

  @override
  String get qrCameraError =>
      'Камера недоступна. Проверьте разрешение на камеру и попробуйте ещё раз.';

  @override
  String get qrInvalid => 'Это недействительный QR-код Cubechat.';

  @override
  String qrChannelAdded(String name) {
    return '$name: добавлено';
  }

  @override
  String get qrShow => 'Показать QR-код';

  @override
  String qrChannelTitle(String name) {
    return 'Войти в $name';
  }

  @override
  String get profileBackup => 'Зашифрованная резервная копия';

  @override
  String get profileBackupSubtitle =>
      'Безопасный перенос ключей, контактов и истории';

  @override
  String get backupTitle => 'Зашифрованная резервная копия';

  @override
  String get backupExplainer =>
      'Резервная копия содержит закрытые ключи профиля, контакты, каналы, настройки и историю сообщений. Она шифруется на этом телефоне выбранным паролем; Cubechat не сможет восстановить забытый пароль.';

  @override
  String get backupCreate => 'Создать копию';

  @override
  String get backupCreateSubtitle =>
      'Зашифровать всё и сохранить файл .cchatbackup';

  @override
  String get backupRestore => 'Восстановить копию';

  @override
  String get backupRestoreSubtitle =>
      'Заменить профиль Cubechat на этом телефоне данными из копии';

  @override
  String get backupPasswordTitle => 'Пароль резервной копии';

  @override
  String get backupPasswordHint => 'Не менее 8 символов';

  @override
  String get backupConfirmPassword => 'Повторите пароль';

  @override
  String get backupPasswordMismatch => 'Пароли не совпадают';

  @override
  String get backupPasswordShort => 'Используйте не менее 8 символов';

  @override
  String get backupSaveTitle => 'Сохранить резервную копию Cubechat';

  @override
  String get backupSaved => 'Зашифрованная копия сохранена';

  @override
  String get backupWhereTitle => 'Куда сохранить копию?';

  @override
  String get backupSaveToFiles => 'Сохранить в Файлы';

  @override
  String get backupSaveToFilesHint =>
      'Папка на телефоне, карта памяти или облачный диск';

  @override
  String get backupSendToApp => 'Отправить в приложение';

  @override
  String get backupSendToAppHint =>
      'Telegram, почта, мессенджер — всё, что принимает файлы';

  @override
  String get backupFailed => 'Не удалось завершить операцию с резервной копией';

  @override
  String get backupRestoreConfirmTitle => 'Заменить этот профиль?';

  @override
  String get backupRestoreConfirmMessage =>
      'Текущие ключи, контакты, каналы, настройки и история на этом телефоне будут заменены выбранной резервной копией.';

  @override
  String get backupRestoreConfirmAction => 'Восстановить';

  @override
  String get backupRestored => 'Резервная копия восстановлена';

  @override
  String get backupPackingWait => 'Создаём резервную копию…';

  @override
  String get backupUnpackingWait => 'Восстанавливаем резервную копию…';

  @override
  String get backupWaitHint =>
      'С фото и видео это может занять несколько минут. Не закрывайте приложение.';

  @override
  String get backupInvalid =>
      'Неверный пароль, повреждённый файл или неподдерживаемая копия';

  @override
  String get channelInfoTitle => 'О канале';

  @override
  String get channelParticipantsTitle => 'Участники';

  @override
  String get channelAdministratorsTitle => 'Администраторы';

  @override
  String get channelMakeAdmin => 'Сделать администратором';

  @override
  String get channelRemoveAdmin => 'Снять права администратора';

  @override
  String get channelNoParticipants =>
      'Участники появятся после подписанной активности';

  @override
  String get channelSharedContent => 'Медиа, файлы и опросы';

  @override
  String get channelDescriptionTitle => 'Описание';

  @override
  String get channelDescriptionEmpty => 'Описания пока нет';

  @override
  String get channelDescriptionHint => 'Для чего этот канал';

  @override
  String get channelDescriptionAdminOnly =>
      'Изменять описание может только администратор';

  @override
  String get channelDescriptionSave => 'Сохранить';

  @override
  String get channelPrivateSubtitle => 'частный канал';

  @override
  String get channelAvatarSet => 'Установить новое фото';

  @override
  String get channelSettingsTitle => 'Настройки канала';

  @override
  String get channelSettingsHint => 'Кто может писать, копирование, история';

  @override
  String get channelLeaveAction => 'Покинуть';

  @override
  String get channelLeaveConfirm =>
      'Комната и всё сказанное в ней исчезнут с этого телефона. Ключ выводится из названия, поэтому вы сможете открыть её снова, введя то же название.';

  @override
  String get channelShareAction => 'Поделиться';

  @override
  String channelMembersOf(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count участника',
      many: '$count участников',
      few: '$count участника',
      one: '$count участник',
    );
    return '$_temp0';
  }

  @override
  String get chatTyping => 'печатает…';

  @override
  String get chatRecordingVoice => 'записывает голосовое…';

  @override
  String get chatRecordingCircle => 'записывает видеосообщение…';

  @override
  String get chatSendingPhoto => 'отправляет фото…';

  @override
  String get chatSendingVideo => 'отправляет видео…';

  @override
  String get chatSendingFile => 'отправляет файл…';

  @override
  String get onboardingMeshTitle => 'Работает без интернета';

  @override
  String get onboardingMeshBody =>
      'Сообщения идут через Bluetooth, от телефона к телефону. Без сотовой связи, без Wi-Fi, без аккаунтов — только люди рядом.';

  @override
  String get onboardingRelayTitle => 'И с ним, когда он есть';

  @override
  String get onboardingRelayBody =>
      'Вне зоны Bluetooth сообщения идут через интернет и доходят так же. Выбирать ничего не нужно.';

  @override
  String get onboardingPrivacyTitle => 'Никто посередине не прочитает';

  @override
  String get onboardingPrivacyBody =>
      'Всё защищено сквозным шифрованием, а ваша личность — это ключ на этом телефоне: не номер, не почта, не аккаунт, который кто-то может отнять.';

  @override
  String get onboardingSkip => 'Пропустить';

  @override
  String get onboardingNext => 'Далее';

  @override
  String get onboardingStart => 'Начать';

  @override
  String get chatMediaShare => 'Поделиться';

  @override
  String get chatMediaSaveToGallery => 'Сохранить в галерею';

  @override
  String get chatMediaShowInChat => 'Показать в чате';

  @override
  String get chatWallpaperTitle => 'Обои';

  @override
  String get chatWallpaperClear => 'Сбросить';

  @override
  String get chatWallpaperDim => 'Затемнение под сообщениями';

  @override
  String get chatSelectAction => 'Выбрать';

  @override
  String get chatForwardNothing => 'Здесь нечего переслать';

  @override
  String chatSelectedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Выбрано: $count',
      many: 'Выбрано: $count',
      few: 'Выбрано: $count',
      one: 'Выбрано: $count',
    );
    return '$_temp0';
  }

  @override
  String chatDeleteSelectedTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Удалить $count сообщения?',
      many: 'Удалить $count сообщений?',
      few: 'Удалить $count сообщения?',
      one: 'Удалить $count сообщение?',
    );
    return '$_temp0';
  }

  @override
  String get contactAliasAction => 'Переименовать контакт';

  @override
  String get contactAliasHint =>
      'Это имя видите только вы. Оставьте пустым, чтобы использовать его собственное.';

  @override
  String get viewOnceSendLabel => 'Один просмотр';

  @override
  String get viewOnceTitle => 'Один просмотр';

  @override
  String get viewOnceTapToView => 'Фото · нажмите, чтобы посмотреть один раз';

  @override
  String get viewOnceSent => 'Фото · отправлено';

  @override
  String get viewOnceOpened => 'Фото просмотрено';

  @override
  String get viewOnceUnavailable => 'Это фото больше недоступно';

  @override
  String get viewOnceWarning =>
      'После закрытия фото будет удалено у вас обоих.';

  @override
  String get channelAvatarAdminOnly =>
      'Изменять фото канала может только администратор';

  @override
  String get channelAdminOnly => 'Изменять это может только администратор';

  @override
  String get channelAvatarTooLarge => 'Это фото слишком большое для рассылки';

  @override
  String get channelMemberUnknown => 'Пока не в ваших контактах';

  @override
  String get channelInviteToContacts => 'Отправить свою карточку контакта';

  @override
  String channelContactInviteSent(String name) {
    return 'Карточка контакта отправлена: $name';
  }

  @override
  String get chatContactInvitation => 'Приглашение добавить контакт';

  @override
  String get chatContactInvitationForYou => 'Приглашение для вас';

  @override
  String get channelPollTitle => 'Опрос';

  @override
  String get channelCreatePoll => 'Создать опрос';

  @override
  String get channelPollQuestion => 'Вопрос';

  @override
  String channelPollOption(int number) {
    return 'Вариант $number';
  }

  @override
  String get channelPollAddOption => 'Добавить вариант';

  @override
  String get channelPollCreate => 'Опубликовать';

  @override
  String channelPollVotes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count голоса',
      many: '$count голосов',
      few: '$count голоса',
      one: '$count голос',
      zero: 'Нет голосов',
    );
    return '$_temp0';
  }

  @override
  String get phoneTransferTitle => 'Перенос на новый телефон';

  @override
  String get desktopPickChat => 'Выберите, кому хотите написать';

  @override
  String get desktopListCollapse => 'Оставить только аватарки';

  @override
  String get desktopListExpand => 'Показать список чатов';

  @override
  String get desktopLinkConnectTitle => 'Подключить компьютер';

  @override
  String get desktopLinkConnectHint =>
      'Отсканируйте код, который показывает CubeChat на компьютере';

  @override
  String get desktopLinkSignIn => 'Войти аккаунтом с телефона';

  @override
  String get desktopLinkTitle => 'Вход через телефон';

  @override
  String get desktopLinkSteps =>
      'На телефоне: Профиль → Данные → «Подключить компьютер», затем отсканируйте этот код. Оба устройства должны быть в одной сети Wi-Fi.';

  @override
  String get desktopLinkLimits =>
      'Телефон продолжит работать. Сообщения из интернета приходят на оба; отправленное с одного пока не появляется на другом.';

  @override
  String get desktopLinkWaiting => 'Ждём телефон…';

  @override
  String get desktopLinkFailed =>
      'Не удалось получить аккаунт. Попробуйте ещё раз.';

  @override
  String get desktopLinkRetry => 'Попробовать ещё раз';

  @override
  String get desktopLinkConfirmTitle =>
      'Отправить копию аккаунта на компьютер?';

  @override
  String get desktopLinkConfirmMessage =>
      'Компьютер получит ваши ключи, контакты и чаты. Этот телефон будет работать как раньше.';

  @override
  String get desktopLinkConfirmAction => 'Отправить';

  @override
  String desktopLinkConfirmWhere(String address) {
    return 'Только если вы только что отсканировали этот код с экрана своего компьютера. Копия будет отправлена на $address в этой сети.';
  }

  @override
  String get desktopLinkSending => 'Отправляем аккаунт…';

  @override
  String get desktopLinkSent => 'Компьютер подключён';

  @override
  String get desktopLinkPhoneFound =>
      'Телефон нашёл компьютер и готовит копию аккаунта. С фото это может занять несколько минут.';

  @override
  String desktopLinkReceiving(int percent) {
    return 'Получаем аккаунт: $percent%';
  }

  @override
  String get desktopLinkRestoring => 'Восстанавливаем аккаунт на компьютере…';

  @override
  String get desktopLinkFinding => 'Ищем компьютер…';

  @override
  String get desktopLinkPreparing =>
      'Готовим копию аккаунта. С фото это может занять несколько минут.';

  @override
  String desktopLinkSendingPercent(int percent) {
    return 'Отправляем: $percent%';
  }

  @override
  String get desktopLinkComputerRestoring =>
      'Компьютер восстанавливает аккаунт…';

  @override
  String get devicesTitle => 'Устройства';

  @override
  String get devicesRowHint => 'Где открыт ваш аккаунт и выход оттуда';

  @override
  String get devicesThisDevice => 'Это устройство';

  @override
  String get devicesSeenNow => 'В сети только что';

  @override
  String devicesSeenMinutes(int n) {
    return 'В сети $n мин назад';
  }

  @override
  String devicesSeenHours(int n) {
    return 'В сети $n ч назад';
  }

  @override
  String devicesSeenDays(int n) {
    return 'В сети $n дн. назад';
  }

  @override
  String get devicesLeaving => 'Выход — ждём, пока появится в сети';

  @override
  String get devicesSignOut => 'Выйти';

  @override
  String get devicesSignOutAll => 'Выйти на всех других устройствах';

  @override
  String devicesSignOutTitle(String name) {
    return 'Выйти на «$name»?';
  }

  @override
  String get devicesSignOutMessage =>
      'Ключи, чаты и настройки CubeChat на том устройстве будут стёрты, как только оно появится в сети. Аккаунт останется здесь и на других ваших устройствах.';

  @override
  String get devicesSignOutPhoneMessage =>
      'Это телефон: CubeChat на нём будет стёрт полностью. Аккаунт останется здесь и на других ваших устройствах.';

  @override
  String get devicesSignOutAllMessage =>
      'Все остальные устройства выйдут из аккаунта, как только появятся в сети. Аккаунт останется только здесь.';

  @override
  String get devicesRename => 'Переименовать';

  @override
  String get devicesRenameTitle => 'Название этого устройства';

  @override
  String get devicesSave => 'Сохранить';

  @override
  String get devicesEmpty =>
      'Других устройств пока не видно. Устройство появится здесь, когда откроет CubeChat 1.0.0+1147 или новее.';

  @override
  String get devicesCaveat =>
      'Выход сработает, когда то устройство выйдет в сеть. Устройство, которое держат без интернета, сохранит ключи; полная защита — это новые ключи аккаунта.';

  @override
  String get desktopLinkImportTitle => 'Перенести аккаунт с телефона';

  @override
  String get desktopLinkImportHint =>
      'Покажите телефону код — и этот компьютер станет копией его аккаунта';

  @override
  String get desktopLinkImportConfirmTitle =>
      'Заменить аккаунт на этом компьютере?';

  @override
  String get desktopLinkImportConfirmMessage =>
      'Ключи, контакты и чаты этого компьютера будут заменены аккаунтом с телефона. Если этот аккаунт ещё нужен, сначала сделайте резервную копию.';

  @override
  String get desktopLinkImportConfirmAction => 'Продолжить';

  @override
  String get desktopLinkUnreachable =>
      'Не удалось связаться с компьютером. Оба устройства должны быть в одной сети Wi-Fi, а на компьютере CubeChat должен быть разрешён в брандмауэре.';

  @override
  String get desktopLinkFirewallHint =>
      'Windows может не пустить телефон к этому компьютеру. Разрешите CubeChat в брандмауэре — только для вашей локальной сети.';

  @override
  String get desktopLinkFirewallAllow => 'Разрешить в брандмауэре';

  @override
  String get desktopLinkFirewallDeclined =>
      'Windows не дала разрешения. Без него телефон может не достучаться.';

  @override
  String get phoneTransferIntro =>
      'Перенесите профиль, ключи, контакты, каналы, настройки и историю напрямую между двумя телефонами.';

  @override
  String get phoneTransferSend => 'Это старый телефон';

  @override
  String get phoneTransferReceive => 'Это новый телефон';

  @override
  String get phoneTransferSameWifi =>
      'Подключите оба телефона к одной сети Wi-Fi и не закрывайте этот экран до завершения.';

  @override
  String get phoneTransferPreparing => 'Готовим зашифрованный перенос…';

  @override
  String get phoneTransferReady =>
      'Отсканируйте этот одноразовый QR-код на новом телефоне';

  @override
  String get phoneTransferScan => 'Сканировать старый телефон';

  @override
  String get phoneTransferConfirmTitle => 'Заменить профиль на этом телефоне?';

  @override
  String get phoneTransferConfirmMessage =>
      'Текущий профиль на этом телефоне будет заменён данными из зашифрованного локального переноса.';

  @override
  String get phoneTransferConfirmAction => 'Перенести профиль';

  @override
  String get phoneTransferSuccess => 'Профиль успешно перенесён';

  @override
  String get phoneTransferFailed => 'Не удалось завершить перенос телефона';

  @override
  String get profileSummaryMeshOnly => 'Только mesh';

  @override
  String get profileSummaryMeshInternet => 'Mesh · интернет';

  @override
  String get profileSummaryBackgroundOn => 'работает в фоне';

  @override
  String profileSummaryTransfersActive(int count) {
    return 'В процессе: $count';
  }

  @override
  String get profileSummaryCardBackup => 'Файлы, резервная копия';

  @override
  String get chatPlay => 'Воспроизвести';

  @override
  String get chatPause => 'Пауза';

  @override
  String get profileTheme => 'Цвет';

  @override
  String get profileThemeEmerald => 'Изумруд';

  @override
  String get profileThemeIndigo => 'Индиго';

  @override
  String get profileThemeAmber => 'Янтарь';

  @override
  String get profileThemeRose => 'Роза';

  @override
  String get profileThemeFuchsia => 'Фуксия';

  @override
  String get profileThemeViolet => 'Фиалка';

  @override
  String get profileThemeOcean => 'Океан';

  @override
  String get profileThemeSlate => 'Графит';

  @override
  String get profileScale => 'Размер интерфейса';

  @override
  String get profileScaleSystem => 'Системный';

  @override
  String get profileGlass => 'Стекло';

  @override
  String get profileGlassAuto => 'Авто';

  @override
  String get profileGlassFull => 'Полное';

  @override
  String get profileGlassLight => 'Облегчённое';

  @override
  String get profileGlassHint =>
      'Облегчённое оставляет оттенок и убирает размытие за панелями. «Авто» один раз измеряет ваш телефон и решает само. На телефоне, который и так успевает, пользы от этого немного — это для того, который не успевает.';

  @override
  String get mapAlwaysNeeded =>
      'Чтобы карта обновлялась, пока cubechat закрыт, в настройках геолокации нужно выбрать «Всегда». Нажмите, чтобы открыть настройки.';

  @override
  String get mapShareConsentTitle => 'Показывать ваше местоположение на карте?';

  @override
  String get mapShareConsentBody =>
      'Ваше местоположение в реальном времени будут видеть только контакты с вашей карты: те, кого вы пригласили, или чьё приглашение вы приняли. Оно обновляется, в том числе когда Cubechat в фоне, пока вы не скроетесь. Оно защищено сквозным шифрованием и никогда не попадает к нам. Скрыться можно в любой момент на карте или в профиле, а заблокированные контакты никогда вас не видят.';

  @override
  String get mapShareConsentAllow => 'Разрешить';

  @override
  String get mapShareConsentDecline => 'Не разрешать';

  @override
  String get mapVisibleToFriends => 'Друзья на карте видят вас';

  @override
  String get mapHiddenFromFriends => 'Вас не видно';

  @override
  String get mapHideMe => 'Скрыться';

  @override
  String get mapShowMe => 'Показать меня';

  @override
  String get profileScaleSmall => 'Меньше';

  @override
  String get profileScaleNormal => 'Обычный';

  @override
  String get profileScaleLarge => 'Больше';

  @override
  String get profileScaleSample =>
      'Текст и строки отображаются в этом размере.';

  @override
  String get savedTitle => 'Сохранённое';

  @override
  String get savedSubtitle => 'Заметки для себя, на этом устройстве';

  @override
  String get savedEmpty =>
      'Всё, что вы здесь напишете, останется на этом телефоне.';

  @override
  String get meshOffTitle => 'Bluetooth mesh выключен';

  @override
  String get meshOffHint =>
      'Никто рядом не найдёт вас, а вы — их. Сообщения по-прежнему идут через интернет-релей.';

  @override
  String get profileMeshSwitch => 'Bluetooth mesh';

  @override
  String get profileMeshSwitchHint =>
      'Находит людей рядом и передаёт сообщения без интернета. Выключение экономит батарею.';

  @override
  String get channelAdminOnlyHint => 'Канал объявлений. Читать могут все.';

  @override
  String get attachLocation => 'Геопозиция';

  @override
  String get locationBubbleTitle => 'Геопозиция';

  @override
  String get locationOpenInMaps => 'Открыть в картах';

  @override
  String locationAccuracy(int metres) {
    return 'с точностью до $metres м';
  }

  @override
  String get locationExpired => 'Эта геопозиция уже неактуальна';

  @override
  String get locationDenied => 'Доступ к геопозиции выключен';

  @override
  String get locationUnavailable => 'Не удалось определить местоположение';

  @override
  String get locationShareFor => 'Делиться';

  @override
  String get locationShareOnce => 'Один раз';

  @override
  String get locationShare15m => '15 минут';

  @override
  String get locationShare1h => '1 час';

  @override
  String get storageTitle => 'Память';

  @override
  String get storageHeadline => 'Использование памяти';

  @override
  String storageSubtitle(String size) {
    return 'cubechat занимает $size на этом устройстве';
  }

  @override
  String get storageEmpty => 'Пока ничего не сохранено';

  @override
  String get storageScanning => 'Подсчёт…';

  @override
  String get storageCatPhotos => 'Фото';

  @override
  String get storageCatVoice => 'Голосовые';

  @override
  String get storageCatFiles => 'Полученные файлы';

  @override
  String get storageCatOutbox => 'Отправленные файлы';

  @override
  String get storageCatStickers => 'Стикеры';

  @override
  String get storageCatSaved => 'Сохранённое';

  @override
  String get storageCatWallpapers => 'Обои';

  @override
  String get storageCatHistory => 'Переписка и ключи';

  @override
  String get storageCatCache => 'Кэш';

  @override
  String storageClear(String size) {
    return 'Очистить $size';
  }

  @override
  String get storageClearNothing => 'Ничего не выбрано';

  @override
  String storageFreed(String size) {
    return 'Освобождено $size';
  }

  @override
  String get storageNoCloud =>
      'Облака здесь нет. Всё, что вы очистите, исчезнет с этого телефона, а единственная другая копия — на телефоне, откуда это пришло.';

  @override
  String get storageWhyHistoryLocked =>
      'Переписка отсюда не очищается — для этого есть «Экстренная очистка».';

  @override
  String get storageRecoveryFree => 'Можно очистить';

  @override
  String get storageRecoveryGone => 'Копий больше нигде нет';

  @override
  String get storageRecoveryAskSender => 'Можно снова запросить у отправителя';

  @override
  String get storageRecoveryCostsThem =>
      'Они больше не смогут попросить вас отправить повторно';

  @override
  String storageConfirmTitle(String size) {
    return 'Очистить $size?';
  }

  @override
  String get storageConfirmBody =>
      'Файлы будут удалены с этого телефона. Никуда ничего не выгружается, поэтому восстановить их неоткуда.';

  @override
  String storageFilesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count файла',
      many: '$count файлов',
      few: '$count файла',
      one: '$count файл',
      zero: 'нет файлов',
    );
    return '$_temp0';
  }

  @override
  String get customizeBarTitle => 'Нижняя панель';

  @override
  String get customizeBarHint =>
      'Перетащите, чтобы изменить порядок. Чаты убрать нельзя.';

  @override
  String get customizeBarShown => 'Показаны';

  @override
  String get customizeBarHidden => 'Скрыты';

  @override
  String get customizeBarHiddenEmpty => 'Ничего не скрыто';

  @override
  String get customizeBarMinimum => 'Оставьте хотя бы две вкладки';

  @override
  String get customizeReset => 'Сбросить';

  @override
  String get chatsArchiveTitle => 'Архив';

  @override
  String get chatsArchiveEmpty => 'Архив пуст';

  @override
  String get chatsArchiveHint =>
      'Архивные чаты работают как обычно — их просто нет в списке.';

  @override
  String get chatsArchivedToast => 'В архиве';

  @override
  String get chatsUnarchivedToast => 'Возвращено в список';

  @override
  String chatsArchiveCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count чата',
      many: '$count чатов',
      few: '$count чата',
      one: '$count чат',
    );
    return '$_temp0';
  }

  @override
  String get chatsSwipeNotHere => 'Для этого чата недоступно';

  @override
  String get customizeSwipeTitle => 'Свайп чата вправо';

  @override
  String get customizeSwipeHint => 'Свайп влево по-прежнему листает вкладки.';

  @override
  String get customizeSwipeArchive => 'В архив';

  @override
  String get customizeSwipeMute => 'Без звука';

  @override
  String get customizeSwipePin => 'Закрепить';

  @override
  String get customizeSwipeRead => 'Прочитано';

  @override
  String get customizeSwipeDelete => 'Удалить';

  @override
  String get customizeSwipeNone => 'Ничего';

  @override
  String get customizeHighRefresh => 'Полная частота обновления';

  @override
  String get customizeHighRefreshHint =>
      'Плавнее, но телефон рисует вдвое больше кадров. Выключите, если он греется — внешний вид приложения не меняется, только то, как часто его перерисовывают.';

  @override
  String get customizeQuickReaction => 'Реакция двойным касанием';

  @override
  String get customizeQuickReactionHint =>
      'Что ставит двойное касание по сообщению. Если воспользоваться другой реакцией, она займёт это место.';

  @override
  String get customizeCircleAudioTitle => 'Пауза музыки для видеосообщений';

  @override
  String get customizeCircleAudioOn =>
      'Запись или просмотр останавливает всё, что играет. Само оно потом не возобновится.';

  @override
  String get customizeCircleAudioOff =>
      'Ваша музыка продолжает играть, тише, пока идёт видеосообщение.';

  @override
  String get customizeMediaQualityTitle => 'Качество фото при отправке';

  @override
  String get customizeMediaQualityEconomy => 'Эконом';

  @override
  String get customizeMediaQualityStandard => 'Обычное';

  @override
  String get customizeMediaQualityHigh => 'Высокое';

  @override
  String get customizeMediaQualityEconomyHint =>
      'До 96 КБ на фото, 800 px. Для одного деления связи или перегруженной Bluetooth-сети: вдвое быстрее, но картинка мягче.';

  @override
  String get customizeMediaQualityStandardHint =>
      'До 192 КБ на фото, 1280 px. Так, чтобы прошло даже только через Bluetooth. Видео и «Оригинал» всегда отправляются как есть.';

  @override
  String get customizeMediaQualityHighHint =>
      'До 768 КБ на фото, 2048 px. Можно приближать; отправляется вчетверо дольше, поэтому лучше через Wi-Fi.';

  @override
  String get previewReacted => 'на ваше сообщение';

  @override
  String get previewLocation => 'Геопозиция';

  @override
  String get previewMapInvite => 'Приглашение на карту';

  @override
  String get previewContact => 'Контакт';

  @override
  String get previewUnsupported => 'Сообщение не поддерживается';

  @override
  String get previewCallOutgoing => 'Исходящий звонок';

  @override
  String get previewCallIncoming => 'Входящий звонок';

  @override
  String get previewCallMissed => 'Пропущенный звонок';

  @override
  String chatPreparingPhotos(int count) {
    return 'Подготовка фото: $count…';
  }

  @override
  String get circleSwitchCamera => 'Сменить камеру';

  @override
  String get circleLight => 'Подсветка записи';

  @override
  String get circleCameraSwitchFailed =>
      'Не удалось сменить камеру. Запись по-прежнему открыта.';

  @override
  String get diagnosticsTitle => 'Диагностика';

  @override
  String get diagnosticsIntro =>
      'Что приложение делало в последнее время. Если что-то не работает — отправьте это разработчику.';

  @override
  String get diagnosticsShare => 'Отправить журнал разработчику';

  @override
  String get diagnosticsEvents => 'Последние события';

  @override
  String get diagnosticsTechnical => 'Технические записи';

  @override
  String get diagnosticsEmpty => 'Пока ничего нет.';

  @override
  String get diagnosticsDeveloperOn => 'Режим разработчика включён';

  @override
  String get diagnosticsDeveloperOff => 'Режим разработчика выключен';

  @override
  String get logAppStarted => 'Приложение запущено';

  @override
  String get logInternetOn => 'Связь через интернет включена';

  @override
  String logServerConnected(String host) {
    return 'Подключено к $host';
  }

  @override
  String logServerLost(String host) {
    return 'Потеряна связь с $host';
  }

  @override
  String get chatSaveAction => 'Сохранить';

  @override
  String get savedTagAsk => 'Сохранено. Добавить тег?';

  @override
  String get savedTagAdd => 'Добавить тег';

  @override
  String get chatSharedWallpaperFailed =>
      'Обои установлены здесь. Собеседник получит их, когда будет рядом.';

  @override
  String get chatTranscribeAction => 'Распознать';

  @override
  String get chatTranscribeFailed =>
      'Этот телефон не может распознать это сообщение.';

  @override
  String get chatTranscribing => 'Распознаю…';

  @override
  String get chatTranscriptHide => 'Скрыть текст';

  @override
  String get chatCancelSend => 'Отменить отправку';

  @override
  String get chatDownloadAction => 'Скачать';

  @override
  String get chatDownloaded => 'Сохранено на телефон';

  @override
  String get chatDownloadFailed => 'Не удалось сохранить';

  @override
  String get selfUpdateTitle => 'Установить обновление из файла';

  @override
  String get selfUpdateHint =>
      'Выбирайте новый APK cubechat здесь, а не открывайте его из чата: так звонки на экране блокировки останутся включёнными.';

  @override
  String get selfUpdateConfirm => 'Подтвердите установку в системном окне.';

  @override
  String get selfUpdateAllow =>
      'Разрешите cubechat устанавливать приложения и нажмите ещё раз.';

  @override
  String get selfUpdateNotOurs => 'Этот файл — не обновление cubechat.';

  @override
  String get selfUpdateFailed => 'Обновление не установилось.';

  @override
  String get chatTranscribeDownloading =>
      'Телефон загружает языковую модель для этого. Попробуйте через минуту.';

  @override
  String get chatTranscribeNoLanguage =>
      'На этом телефоне нет речевой модели для этого языка. Выберите язык распознавания: Профиль → Чаты и медиа.';

  @override
  String get chatTranscribeNotAllowed =>
      'Распознавание речи выключено для CubeChat. Включите его в Настройках iPhone → CubeChat.';

  @override
  String get customizeTranscribeLanguageTitle => 'Язык распознавания голосовых';

  @override
  String get customizeTranscribeLanguageAuto => 'Авто';

  @override
  String get customizeTranscribeLanguageHint =>
      'Язык, на котором говорят в голосовых, — не обязательно язык приложения. «Авто» пробует языки телефона. Если модели нет, телефон загрузит её сам; голос никуда не уходит.';

  @override
  String get chatTranslateAction => 'Перевести';

  @override
  String get chatTranslateFailed =>
      'Это сообщение не получается перевести на этом телефоне.';

  @override
  String get customizeDeferMediaTitle => 'Ждать Wi-Fi для загрузки медиа';

  @override
  String get customizeDeferMediaHint =>
      'Через мобильный интернет сообщения и звонки работают как обычно, а фото, голосовые, кружки и файлы ждут Wi-Fi на сервере — до двух недель. Строка над чатами показывает, что ждёт, и загружает это сразу.';

  @override
  String heldMediaCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count медиафайла ждут Wi-Fi',
      many: '$count медиафайлов ждут Wi-Fi',
      few: '$count медиафайла ждут Wi-Fi',
      one: '$count медиафайл ждёт Wi-Fi',
    );
    return '$_temp0';
  }

  @override
  String get heldMediaDownload => 'Загрузить';

  @override
  String get nearbyAirDropSubtitle => 'Обмен файлами с людьми рядом';

  @override
  String get nearbyFilesSubtitle => 'Отправленные и полученные файлы';

  @override
  String get airdropTab => 'AirDrop';

  @override
  String get nearbyTabFiles => 'Файлы';

  @override
  String get airdropReceiveHint => 'Кто может отправлять вам файлы';

  @override
  String get airdropReceiveContacts => 'Контакты';

  @override
  String get airdropReceiveEveryone => 'Все на 10 мин';

  @override
  String airdropEveryoneLeft(String time) {
    return 'Все · $time';
  }

  @override
  String get airdropSendFiles => 'Отправить файлы';

  @override
  String get airdropChooseFiles => 'Выбрать файлы';

  @override
  String airdropStagedTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count файла готовы',
      many: '$count файлов готовы',
      few: '$count файла готовы',
      one: '$count файл готов',
    );
    return '$_temp0';
  }

  @override
  String get airdropStagedHint =>
      'Включите Bluetooth и откройте AirDrop на обоих телефонах, затем поднесите их друг к другу или выберите человека';

  @override
  String get airdropStagedPickPerson => 'Выбрать человека';

  @override
  String airdropRequestBody(String what, String size) {
    return 'хочет отправить $what · $size';
  }

  @override
  String airdropWhatPhotos(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count фото',
      one: '1 фото',
    );
    return '$_temp0';
  }

  @override
  String airdropWhatVideos(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count видео',
      one: '1 видео',
    );
    return '$_temp0';
  }

  @override
  String airdropWhatFiles(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count файла',
      many: '$count файлов',
      few: '$count файла',
      one: '$count файл',
    );
    return '$_temp0';
  }

  @override
  String get airdropAccept => 'Принять';

  @override
  String get airdropDecline => 'Отклонить';

  @override
  String get airdropWaiting => 'Ждём ответа…';

  @override
  String get airdropAccepted => 'Принято';

  @override
  String get airdropUnheard => 'Не получено — возможно, старая версия CubeChat';

  @override
  String get airdropSending => 'Отправляем';

  @override
  String get airdropReceiving => 'Получаем';

  @override
  String get airdropInterrupted => 'Прервано';

  @override
  String get airdropRetry => 'Повторить';

  @override
  String get airdropOutcomeSent => 'Отправлено';

  @override
  String get airdropOutcomeReceived => 'Получено';

  @override
  String get airdropOutcomeDeclined => 'Отклонено';

  @override
  String get airdropOutcomeCancelled => 'Отменено';

  @override
  String get airdropOutcomePartial => 'Частично';

  @override
  String get airdropReasonNoSpace => 'недостаточно места';

  @override
  String get airdropReasonContactsOnly => 'только от контактов';

  @override
  String get airdropReasonBusy => 'занято';

  @override
  String get airdropReasonTimeout => 'нет ответа';

  @override
  String get airdropFileDeleted => 'удалено';

  @override
  String get airdropHistory => 'История';

  @override
  String get airdropClearHistory => 'Очистить историю';

  @override
  String get airdropEmpty =>
      'Здесь будут файлы, которые вы отправляете и получаете рядом';

  @override
  String get airdropPickPerson => 'Кому отправить';

  @override
  String get airdropNobody => 'Рядом пока никого с cubechat';

  @override
  String get airdropNoDirect => 'Нет Bluetooth-связи с этим человеком';

  @override
  String get airdropNearbyUnknown => 'Рядом';

  @override
  String get airdropConnecting => 'Подключение…';

  @override
  String get airdropConnectFailed => 'Не удалось подключиться';

  @override
  String get airdropSlowWarning =>
      'Через Bluetooth это может занять много времени';

  @override
  String airdropTooLarge(String name, int limit) {
    return '$name больше $limit МБ';
  }

  @override
  String airdropFromLabel(String name) {
    return 'AirDrop · $name';
  }

  @override
  String get airdropWrite => 'Написать';

  @override
  String get airdropAction => 'AirDrop';

  @override
  String get airdropLaneTitle => 'Канал';

  @override
  String get airdropLaneAuto => 'Авто';

  @override
  String get airdropLaneBluetooth => 'Bluetooth';

  @override
  String get airdropLaneWifi => 'Wi‑Fi';

  @override
  String get airdropBluetoothNeededHint =>
      'Включите Bluetooth на обоих телефонах, чтобы найти друг друга и подтвердить передачу.';

  @override
  String get airdropLaneHint =>
      'Bluetooth находит и соединяет телефоны. Wi‑Fi передаёт файлы, когда оба телефона в одной сети или точке доступа.';

  @override
  String get airdropWifiUnreachable => 'Не в одной сети';

  @override
  String get airdropWifiOldVersion =>
      'Их приложение пока не принимает через Wi‑Fi';

  @override
  String get airdropBumpAdd => 'Добавить';

  @override
  String get airdropBumpAlreadyContact => 'Уже в контактах';

  @override
  String airdropBumpSending(String name) {
    return 'Отправляю: $name';
  }

  @override
  String airdropBumpReceiving(String name) {
    return '$name отправляет вам файлы';
  }

  @override
  String get termsTitle => 'Правила cubechat';

  @override
  String get termsBody =>
      'cubechat не терпит недопустимого контента и пользователей, нарушающих правила. Продолжая, вы соглашаетесь не отправлять травлю, угрозы, сексуальный контент с участием несовершеннолетних, спам и ничего незаконного. Любой может пожаловаться на сообщение или человека; жалобы поступают разработчику и рассматриваются в течение 24 часов, нарушителей блокируют.';

  @override
  String get termsReadFull => 'Полные условия';

  @override
  String get termsAccept => 'Принимаю';

  @override
  String get messageHide => 'Скрыть';

  @override
  String get messageHidden => 'Скрыто для вас';

  @override
  String get reportAction => 'Пожаловаться';

  @override
  String get reportTitle => 'Что не так?';

  @override
  String get reportReasonSpam => 'Спам';

  @override
  String get reportReasonAbuse => 'Оскорбления или травля';

  @override
  String get reportReasonViolence => 'Насилие';

  @override
  String get reportReasonSexual => 'Сексуальный контент';

  @override
  String get reportReasonOther => 'Другое';

  @override
  String get reportNoteHint => 'Опишите (необязательно)';

  @override
  String get reportSend => 'Отправить жалобу';

  @override
  String get reportDisclosure =>
      'Текст выбранного сообщения и ваша жалоба будут переданы модерации cubechat и её частному боту в Telegram.';

  @override
  String get reportSent =>
      'Жалоба отправлена. Мы рассматриваем жалобы в течение 24 часов.';

  @override
  String get reportBlockedToo => 'Этот человек заблокирован для вас.';

  @override
  String get reportQueued =>
      'Жалоба сохранена. Отправим её, когда появится сеть.';

  @override
  String get reportFailed => 'Не удалось отправить жалобу.';

  @override
  String get filteredMessage => 'Скрыто фильтром';

  @override
  String get filteredShow => 'Показать';

  @override
  String get filterToggle => 'Фильтр оскорбительного контента';

  @override
  String get filterToggleHint =>
      'Скрывает грубые слова от незнакомых и в каналах';

  @override
  String get aboutTitle => 'О приложении';

  @override
  String get aboutContact => 'Написать разработчику';

  @override
  String get aboutReport => 'Сообщить о нарушении';

  @override
  String get aboutTerms => 'Условия использования';

  @override
  String get aboutPrivacy => 'Политика конфиденциальности';

  @override
  String get requestsTitle => 'Запросы';

  @override
  String get requestsEmpty => 'Запросов нет';

  @override
  String requestBanner(String name) {
    return '$name нет в ваших контактах. Пока вы не примете запрос, этот человек не видит, что вы прочитали, и не может вам позвонить.';
  }

  @override
  String get requestAccept => 'Принять';

  @override
  String get requestDelete => 'Удалить';

  @override
  String get requestBlock => 'Заблокировать';

  @override
  String get cubeIdTitle => 'Cube ID';

  @override
  String get cubeIdExplainer =>
      'Ваше @имя указывает на вашу карточку контакта. Сервер хранит только имя и открытую карточку — никогда не сообщения.';

  @override
  String get cubeIdFieldHint => 'a–z, 0–9 и _, 3–20 символов';

  @override
  String get cubeIdAvailable => 'Свободно';

  @override
  String get cubeIdTaken => 'Занято';

  @override
  String get cubeIdReserved => 'Недоступно';

  @override
  String get cubeIdInvalid => 'Только a–z, 0–9 и _, 3–20 символов';

  @override
  String get cubeIdClaim => 'Занять';

  @override
  String get cubeIdWorking => 'Закрепляем имя…';

  @override
  String get cubeIdChange => 'Изменить';

  @override
  String get cubeIdEmail => 'Почта для восстановления';

  @override
  String get cubeIdEmailHint =>
      'Если телефон потеряется, имя можно вернуть письмом на этот адрес';

  @override
  String get cubeIdEmailField => 'Почта';

  @override
  String cubeIdEmailSent(String email) {
    return 'Письмо отправлено на $email. Откройте ссылку в нём.';
  }

  @override
  String get cubeIdEmailRemove => 'Убрать почту';

  @override
  String get cubeIdEmailUnavailable =>
      'Почта сейчас недоступна. Попробуйте позже.';

  @override
  String get cubeIdEmailInvalid => 'Это не похоже на адрес почты';

  @override
  String get cubeIdSave => 'Сохранить';

  @override
  String get cubeIdRecover => 'Восстановить имя через почту';

  @override
  String get cubeIdRecoverSent =>
      'Если адрес совпадает, придёт письмо. Имя перейдёт на этот телефон через 48 часов после того, как вы откроете ссылку.';

  @override
  String cubeIdRecoveryWarning(String name, String when) {
    return 'Кто-то восстанавливает @$name на другом телефоне через почту. Имя перейдёт $when, если не отменить.';
  }

  @override
  String get cubeIdRecoveryCancel => 'Отменить восстановление';

  @override
  String get cubeIdRecoveryCancelled => 'Восстановление отменено';

  @override
  String get cubeIdRelease => 'Освободить';

  @override
  String cubeIdReleaseConfirm(String name) {
    return 'Освободить @$name? Его сможет занять кто угодно.';
  }

  @override
  String get cubeIdShare => 'Поделиться';

  @override
  String cubeIdShareText(String name) {
    return 'Найдите меня в cubechat: @$name\nhttps://cubechat.tech/u.html#$name';
  }

  @override
  String get cubeIdFailed => 'Не удалось сохранить имя. Попробуйте ещё раз.';

  @override
  String get cubeIdOffline => 'Нет интернета';

  @override
  String get lookupNotFound => 'Нет никого с таким @именем';

  @override
  String searchFindCubeName(String name) {
    return 'Найти @$name';
  }

  @override
  String get searchFindCubeNameHint => 'Найти в Cube ID и добавить';

  @override
  String get addContactHintName => 'Вставьте карточку или введите @имя';

  @override
  String get strangerReachTitle => 'Кто может писать мне из интернета';

  @override
  String get strangerReachAll => 'Все';

  @override
  String get strangerReachRequest => 'Через запрос';

  @override
  String get strangerReachNone => 'Никто';

  @override
  String get strangerReachHint =>
      'Для людей, которым вы не писали и которые пишут через интернет. Людей рядом через Bluetooth это не касается.';

  @override
  String get sectionPrivacy => 'Конфиденциальность';

  @override
  String get sectionNotifications => 'Уведомления и звонки';

  @override
  String get sectionConnection => 'Связь';

  @override
  String get sectionChats => 'Чаты и медиа';

  @override
  String get sectionAppearance => 'Оформление';

  @override
  String get sectionData => 'Данные и память';

  @override
  String get sectionAbout => 'О приложении';

  @override
  String get subWhoSeesMe => 'Кто меня видит';

  @override
  String get subProtection => 'Защита';

  @override
  String get subNotifications => 'Уведомления';

  @override
  String get subCalls => 'Звонки';

  @override
  String get profileDiscoverableMeshOff =>
      'Bluetooth mesh выключен — включите его в разделе «Связь».';

  @override
  String get chatRouteBluetoothDirect => 'Bluetooth напрямую';

  @override
  String chatRouteMeshHops(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Mesh · $n перехода',
      many: 'Mesh · $n переходов',
      few: 'Mesh · $n перехода',
      one: 'Mesh · $n переход',
    );
    return '$_temp0';
  }

  @override
  String chatRouteDeliveredVia(String route) {
    return 'Доставлено: $route';
  }

  @override
  String chatRouteReceivedVia(String route) {
    return 'Получено: $route';
  }

  @override
  String get chatUnreadDivider => 'Новые сообщения';

  @override
  String get radioTitle => 'Рация';

  @override
  String get radioNearbySubtitle =>
      'Зажмите кнопку и говорите с группой или контактом';

  @override
  String get radioGroupsLabel => 'Группы';

  @override
  String get radioDirectLabel => 'Личная';

  @override
  String get radioAddGroup => 'Добавить рацию';

  @override
  String get radioNoGroups =>
      'Раций пока нет. Добавьте — все, кто введёт то же название и пароль, слышат друг друга.';

  @override
  String get radioLeave => 'Выйти из рации';

  @override
  String get radioPickChannel => 'Выберите группу или контакт';

  @override
  String get radioPushToTalk => 'Зажмите и говорите';

  @override
  String get radioTalking => 'Говорите…';

  @override
  String get radioChannelBusy => 'Канал занят';

  @override
  String radioSpeaker(String name) {
    return 'Говорит: $name';
  }

  @override
  String get radioSilentTitle => 'Говорить в беззвучном режиме';

  @override
  String get radioSilentHint =>
      'Голос звучит, даже когда телефон в беззвучном режиме.';

  @override
  String get radioJoinNameLabel => 'Название';

  @override
  String get radioJoinPasswordLabel => 'Пароль (необязательно)';

  @override
  String get radioJoinHint =>
      'Все, кто введёт то же название и пароль, попадают в одну рацию. Ни один сервер не хранит их список.';

  @override
  String get radioJoinNameRequired => 'Введите название';

  @override
  String get radioJoinSubmit => 'Добавить';

  @override
  String get radioBlockedTooLong => 'Прервано после минуты разговора';

  @override
  String get radioBlockedCall => 'Идёт звонок';

  @override
  String get radioBlockedMicrophone => 'Нет доступа к микрофону';

  @override
  String get radioBlockedUnavailable => 'Рация недоступна на этом устройстве';

  @override
  String get radioBlockedNoChannel => 'Сначала выберите группу или контакт';

  @override
  String get radioTurnOff => 'Выключить рацию';

  @override
  String get radioPersonalCallsTitle => 'Принимать личные вызовы';

  @override
  String get radioPersonalCallsHint =>
      'Когда рация выключена, она сама настраивается на контакт, который с вами заговорил.';

  @override
  String get radioBackgroundHint =>
      'С выключенным экраном рацию слышно, только когда включена работа в фоне.';

  @override
  String get areaNearby => 'Чат рядом';

  @override
  String get areaLevelDistrict => 'Район';

  @override
  String get areaLevelCity => 'Город';

  @override
  String get areaLevelRegion => 'Регион';

  @override
  String areaPresentCount(int count) {
    return '≈$count здесь';
  }

  @override
  String get areaPresentMany => '50+ здесь';

  @override
  String get areaBlockViaBluetooth => 'Ваш квартал — через Bluetooth';

  @override
  String get areaOpenNearbyTab => 'Открыть «Рядом»';

  @override
  String get areaLocating => 'Ищем ваш район…';

  @override
  String get areaNoPlace =>
      'Местоположения пока нет. Чату района нужно ваше приблизительное местоположение, пока открыт этот экран.';

  @override
  String get areaLocationDenied =>
      'Геолокация для Cubechat выключена. Разрешите приблизительное местоположение в Настройках, чтобы видеть свой район.';

  @override
  String get areaOffline => 'Нет связи с чатом района';

  @override
  String get areaEmpty => 'За последние 24 часа здесь никто не писал.';

  @override
  String get areaConsentTitle => 'Чат района публичный';

  @override
  String get areaConsentBody =>
      'Сообщения здесь публичные. Их прочитает каждый, кто откроет ваш район или город, и они хранятся 24 часа на сервере Cubechat. Вы пишете под временным именем, которое меняется каждые несколько часов; ваше @имя и контакты никто не видит. Чтобы знать ваш район, Cubechat запрашивает приблизительное местоположение — только пока открыт этот экран.';

  @override
  String get areaConsentAllow => 'Продолжить';

  @override
  String get areaConsentDecline => 'Не сейчас';

  @override
  String areaDefaultName(String tag) {
    return 'Кубик-$tag';
  }

  @override
  String areaYouAre(String name, int hours) {
    return 'Вы — $name · новое имя через $hours ч';
  }

  @override
  String get areaNewName => 'Новое имя';

  @override
  String get areaSetName => 'Задать имя';

  @override
  String get areaNameHint =>
      'Только на несколько часов этого имени. Оставьте пустым для автоматического.';

  @override
  String get areaNameSameWarning =>
      'Одинаковое имя связывает вас между районами';

  @override
  String get areaShowPresence => 'Показывать, что я здесь';

  @override
  String get areaPresenceOffHint =>
      'Включите «Показывать, что я здесь», чтобы видеть, сколько людей рядом';

  @override
  String get areaReadOnly => 'Писать можно только там, где вы находитесь';

  @override
  String get areaComposerHint => 'Сообщение для всех здесь';

  @override
  String get areaSend => 'Отправить';

  @override
  String get areaWaitALittle => 'Подождите немного';

  @override
  String areaFlood(int count) {
    return 'Флуд ($count) · Показать';
  }

  @override
  String get areaReply => 'Ответить';

  @override
  String get areaHide => 'Скрыть';

  @override
  String get areaBlock => 'Заблокировать до смены его имени';

  @override
  String get areaBlocked => 'Заблокирован до смены имени';

  @override
  String get areaReport => 'Пожаловаться';

  @override
  String get areaOpenLink => 'Открыть ссылку';

  @override
  String areaOpenLinkConfirm(String url) {
    return 'Открыть $url?';
  }

  @override
  String get areaOpen => 'Открыть';

  @override
  String get areaReadHere => 'Читать здесь';

  @override
  String get areaReadHereHint =>
      'Только чтение. Писать можно только там, где вы находитесь; релей узнаёт, какое место вы читаете.';

  @override
  String get areaNotes => 'Записки';

  @override
  String areaNotesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count записки',
      many: '$count записок',
      few: '$count записки',
      one: '$count записка',
      zero: 'Записок нет',
    );
    return '$_temp0';
  }

  @override
  String get areaLeaveNote => 'Оставить записку';

  @override
  String get areaNoteHint => 'Короткая записка для вашего города';

  @override
  String get areaNoteLifetime => 'Хранится';

  @override
  String get areaNote1h => '1 ч';

  @override
  String get areaNote24h => '24 ч';

  @override
  String get areaNote7d => '7 дней';

  @override
  String get areaPinToDistrict => 'Привязать к району';

  @override
  String get areaPinHint =>
      'Нажмите на карту в пределах своего города — метка привяжется к району.';

  @override
  String get areaPinOutside => 'Только в пределах вашего города';

  @override
  String get areaNoteDelete => 'Удалить мою записку';

  @override
  String get areaNoNotes => 'Здесь пока нет записок';

  @override
  String get areaNotesLimit => 'Три записки в сутки';

  @override
  String get areaNoteLeft => 'Записка оставлена';

  @override
  String get areaNoteSend => 'Оставить';

  @override
  String get areaOwnNote => 'Ваша записка';

  @override
  String get areaNotePinned => 'Привязана к району';

  @override
  String get areaHidden => 'Скрыто';

  @override
  String get areaPublicBadge => 'Публично · хранится 24 ч';

  @override
  String get areaSettingTitle => 'Чат района';

  @override
  String get areaSettingOnHint =>
      'Кнопка «Чат рядом» на карте: публичные чаты вашего района и города под временным именем.';

  @override
  String get areaSettingOffHint =>
      'Выключено: кнопки на карте нет, и чат района никогда не запрашивает местоположение и не подключается.';

  @override
  String get wallpaperPhotoLocalOnly =>
      'Фото-обои пока можно ставить только локально';

  @override
  String get wallpaperSavedNoRoute =>
      'Сохранено здесь. Сейчас нет маршрута до собеседника';

  @override
  String get wallpaperScopeTitle => 'Кто будет видеть эти обои?';

  @override
  String get wallpaperScopeChannel => 'Весь канал';

  @override
  String get wallpaperScopeBoth => 'Я и собеседник';

  @override
  String get wallpaperScopeLocal => 'Только у меня';

  @override
  String get wallpaperScopeSharedHint =>
      'Отправляется зашифрованным служебным пакетом';

  @override
  String get wallpaperScopePhotoHint =>
      'Фото пока остаётся только на этом телефоне';

  @override
  String get foldersCreate => 'Создать папку';

  @override
  String get foldersYours => 'Ваши папки';

  @override
  String get foldersSmartFilters => 'Умные фильтры';

  @override
  String get foldersName => 'Название папки';

  @override
  String get foldersSave => 'Сохранить';

  @override
  String get foldersDeleteTitle => 'Удалить папку?';

  @override
  String get foldersDelete => 'Удалить';

  @override
  String get foldersCreateAction => 'Создать';

  @override
  String get chatsArchiveHiddenToast =>
      'Архив скрыт. Вернуть — в разделе «Оформление».';

  @override
  String get chatsBulkPin => 'Закрепить';

  @override
  String get chatsBulkMute => 'Без звука';

  @override
  String get chatsUnarchive => 'Вернуть из архива';

  @override
  String get chatsAddToFolder => 'Добавить в папку';

  @override
  String get chatsMarkUnread => 'Отметить как непрочитанное';

  @override
  String get chatsClearHistory => 'Очистить историю чата';

  @override
  String get foldersNew => 'Новая папка';

  @override
  String get foldersNameHint => 'Друзья';

  @override
  String get chatsNoIncoming => 'Нет входящих сообщений';

  @override
  String get chatsMarkedUnread => 'Отмечено как непрочитанное';

  @override
  String get chatsClearHistoryTitle => 'Очистить историю чата?';

  @override
  String get chatsClearHistoryBody =>
      'Сообщения будут удалены только на этом устройстве. Чат, контакт и избранное останутся.';

  @override
  String get chatsClearHistoryAction => 'Очистить';

  @override
  String get chatsHistoryCleared => 'История очищена';

  @override
  String get savedTagMenuTag => 'Тег';

  @override
  String get savedTagRemove => 'Убрать тег';

  @override
  String get customizeArchiveRowTitle => 'Строка архива';

  @override
  String get customizeArchiveRowHint =>
      'Показывать над списком чатов. Архивные чаты всё равно получают сообщения.';

  @override
  String get mapLayerStandard => 'Обычная';

  @override
  String get mapLayerStandardHint =>
      'Светлая карта улиц — самый стабильный вариант';
}
