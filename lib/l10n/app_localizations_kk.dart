// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Kazakh (`kk`).
class AppLocalizationsKk extends AppLocalizations {
  AppLocalizationsKk([String locale = 'kk']) : super(locale);

  @override
  String get callVoice => 'Дауыстық қоңырау';

  @override
  String get callVideo => 'Бейнеқоңырау';

  @override
  String get callIncomingVideo => 'Кіріс бейнеқоңырау';

  @override
  String get callCamera => 'Камера';

  @override
  String get callFlipCamera => 'Аудару';

  @override
  String get contactProfileVideo => 'Бейне';

  @override
  String get callPreparing => 'Микрофон дайындалуда…';

  @override
  String get callDialing => 'Қоңырау шалынуда…';

  @override
  String get callRinging => 'Жауап күтілуде…';

  @override
  String get callConnecting => 'Қосылуда…';

  @override
  String get callMicrophoneRequired =>
      'Қоңырау шалу үшін жүйе баптауларында микрофонға рұқсат беріңіз.';

  @override
  String get callMicrophoneWindows =>
      'Windows CubeChat-қа микрофонды бермеді. Параметрлер → Құпиялылық және қауіпсіздік → Микрофон → «Жұмыс үстелі қолданбаларына микрофонға кіруге рұқсат ету» тармағын қосыңыз.';

  @override
  String get callElsewhere =>
      'Осы аккаунттың басқа құрылғысында қоңырау жүріп жатыр.';

  @override
  String get callRelayUnavailable =>
      'Қоңырау сервері қолжетімсіз. Кейінірек қайталап көріңіз.';

  @override
  String get callBusy => 'Бос емес';

  @override
  String get callNoAnswer => 'Жауап жоқ';

  @override
  String get callFailed => 'Қоңырауды қосу мүмкін болмады';

  @override
  String get callDeclined => 'Қоңырау қабылданбады';

  @override
  String get callEnded => 'Қоңырау аяқталды';

  @override
  String get callMicrophone => 'Микрофон';

  @override
  String get callSpeaker => 'Динамик';

  @override
  String get callAnswer => 'Жауап беру';

  @override
  String get callDecline => 'Қабылдамау';

  @override
  String get callEnd => 'Аяқтау';

  @override
  String get callClose => 'Жабу';

  @override
  String get callMinimize => 'Кішірейту';

  @override
  String get callAudioOutput => 'Қоңырау дыбысы';

  @override
  String get callRoutePhone => 'Телефон';

  @override
  String get callRouteBluetooth => 'Bluetooth';

  @override
  String get callRouteHeadphones => 'Құлаққап';

  @override
  String get callFullScreenTitle => 'Құлып экранындағы қоңыраулар';

  @override
  String get callFullScreenBody =>
      'Кіріс қоңырау құлыпталған экранда көрсетілсін, сонда құлыпты ашпай-ақ жауап беруге болады.';

  @override
  String get callFullScreenXiaomi =>
      'Xiaomi, Redmi және Poco қолданбаларға мұны өздігінен қосуға мүмкіндік бермейді: «Басқа рұқсаттар» бөлімінде «Құлып экранында көрсету» тармағын қосыңыз.';

  @override
  String get circleMessage => 'Бейнехабарлама';

  @override
  String get appName => 'Cubechat';

  @override
  String get navChats => 'Чаттар';

  @override
  String get navPeers => 'Маңайда';

  @override
  String get navProfile => 'Профиль';

  @override
  String get navContacts => 'Контактілер';

  @override
  String get navMap => 'Карта';

  @override
  String get mapTitle => 'Карта';

  @override
  String get mapFriendsTitle => 'Картадағы адамдар';

  @override
  String get mapFriendsHint => 'Орныңызды тек осы контактілер алады';

  @override
  String mapClusterTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Мұнда $count адам',
      one: 'Мұнда $count адам',
    );
    return '$_temp0';
  }

  @override
  String get mapClusterHint => 'Картаны адамға жылжыту үшін оны түртіңіз';

  @override
  String get mapNorthUp => 'Солтүстікті жоғары бұру';

  @override
  String get mapLayerTitle => 'Карта түрі';

  @override
  String get mapLayerHint => 'Белгілер неге салынады';

  @override
  String get mapLayerDark => 'Қараңғы';

  @override
  String get mapLayerDarkHint =>
      'Жазусыз көшелер — белгілер астындағы ең тыныш фон';

  @override
  String get mapLayerSatellite => 'Спутник';

  @override
  String get mapLayerSatelliteHint => 'Аэросурет: қай ғимарат, қай аула';

  @override
  String get mapLayerTerrain => 'Бедер';

  @override
  String get mapLayerTerrainHint =>
      'Горизонтальдар мен бедер — төбелер мен соқпақтар';

  @override
  String get mapFriendsEmpty => 'Әзірге ешкім сізбен картаны бөліспейді.';

  @override
  String get mapFriendsEmptyHint =>
      'Контактіні шақырыңыз — ол шақыруды қабылдаған соң осында пайда болады.';

  @override
  String get mapFriendsInvite => 'Шақыру';

  @override
  String get mapFriendsRemove => 'Картадан алып тастау';

  @override
  String mapFriendsRemoved(String name) {
    return '$name енді сізбен картаны бөліспейді';
  }

  @override
  String get mapFriendsLive => 'Қазір картада';

  @override
  String get mapFriendsIdle => 'Қазір орны белгісіз';

  @override
  String get mapInviteTitle => 'Картаға шақыру';

  @override
  String get mapInviteHint => 'Бір не бірнеше чатты таңдаңыз';

  @override
  String get mapInviteEmpty => 'Шақыратын чаттар әзірге жоқ.';

  @override
  String mapInviteAction(int count) {
    return 'Жіберу ($count)';
  }

  @override
  String get mapInviteMessage =>
      'Cubechat картасына шақыру. Картада көріну үшін осы чатқа геолокацияңызды жіберіңіз.';

  @override
  String mapInviteSent(int count) {
    return 'Жіберілген шақырулар: $count';
  }

  @override
  String get mapInviteFailed => 'Шақыруларды жіберу мүмкін болмады';

  @override
  String mapPeopleVisible(int count) {
    return 'Бөлісілген геолокациялар: $count';
  }

  @override
  String get mapCenterMe => 'Мені ортаға қою';

  @override
  String get mapNoSharedLocations => 'Әзірге геолокациялар жоқ';

  @override
  String get mapNoSharedLocationsHint =>
      'Контакт чатта геолокация жіберген соң осында пайда болады.';

  @override
  String get mapWebHintTitle => 'Маңайдағы байланыстар';

  @override
  String get mapWebHint =>
      'Сызықтар хабарлама маршрутын емес, жақындықты көрсетеді.';

  @override
  String get mapOpenProfile => 'Профиль';

  @override
  String get mapLocationPrivacyOff => 'Картадағы орын жасырылған';

  @override
  String get mapLocationPrivacyOffHint =>
      'Белгіңізді көру үшін «Құпиялылық» бөлімінде «Мені картада көрсету» параметрін қосыңыз.';

  @override
  String get mapYouOnMap => 'Орныңыз осы құрылғыда көрінеді';

  @override
  String get locationSharingDisabled =>
      'Алдымен «Құпиялылық» бөлімінде «Мені картада көрсету» параметрін қосыңыз.';

  @override
  String get mapLocationDenied => 'Геолокацияға рұқсат өшірілген';

  @override
  String get mapLocationServiceOff =>
      'Өзіңізді көрсету үшін геолокацияны қосыңыз';

  @override
  String get mapLocationUnavailable => 'Орныңызды анықтау мүмкін болмады';

  @override
  String get mapDistanceUnknown => 'Қашықтық белгісіз';

  @override
  String mapDistanceMetres(int metres) {
    return '$metres м қашықта';
  }

  @override
  String mapDistanceKilometres(String kilometres) {
    return '$kilometres км қашықта';
  }

  @override
  String get mapUpdatedNow => 'жаңа ғана жіберілді';

  @override
  String mapUpdatedMinutes(int minutes) {
    return '$minutes мин бұрын жіберілді';
  }

  @override
  String mapUpdatedHours(int hours) {
    return '$hours сағ бұрын жіберілді';
  }

  @override
  String get contactsTitle => 'Контактілер';

  @override
  String get contactsSubtitle => 'Сіз хат жазысқандардың бәрі';

  @override
  String get contactsSearchHint => 'Контактілерді іздеу…';

  @override
  String get contactsEmptyTitle => 'Әзірге контактілер жоқ';

  @override
  String get contactsEmptyHint =>
      'Сөйлесуді бастаңыз — әңгімелесушіңіз осында пайда болады.';

  @override
  String get contactsSearchEmpty => 'Контактілер табылмады';

  @override
  String get contactsTabContacts => 'Контактілер';

  @override
  String get contactsTabCalls => 'Қоңыраулар';

  @override
  String get callsFilterAll => 'Барлығы';

  @override
  String get callsFilterMissed => 'Өткізіп алынған';

  @override
  String get callsEmptyTitle => 'Әзірге қоңыраулар жоқ';

  @override
  String get callsEmptyHint =>
      'Кіріс, шығыс және өткізіп алынған қоңыраулар осында көрсетіледі.';

  @override
  String get callsMissedEmpty => 'Өткізіп алынған қоңыраулар жоқ';

  @override
  String get callsCallBack => 'Қоңырау шалу';

  @override
  String get contactProfileChat => 'Чат';

  @override
  String get contactProfileCall => 'Қоңырау';

  @override
  String get contactProfileRadio => 'Рация';

  @override
  String get contactProfileSecurity => 'Қауіпсіздік';

  @override
  String get contactProfileActions => 'Контакт әрекеттері';

  @override
  String get contactProfileVerify => 'Растау';

  @override
  String get contactProfileCopyId => 'Контакт ID-ін көшіру';

  @override
  String get contactProfileIdCopied => 'Контакт ID-і көшірілді';

  @override
  String get contactProfileId => 'Контакт ID-і';

  @override
  String get contactProfileVerifyHint =>
      'Бұл адамды растау үшін шифрлау іздерін салыстырыңыз.';

  @override
  String get chatsTitle => 'Чаттар';

  @override
  String get chatsSubtitle => 'Mesh · өтпелі шифрлау';

  @override
  String get chatsEmptyTitle => 'Әзірге сөйлесулер жоқ';

  @override
  String get chatsEmptyHint =>
      'Сөйлесуді бастау үшін «Маңайда» қойындысынан әңгімелесушіні ашыңыз.';

  @override
  String get chatsFilterAll => 'Барлығы';

  @override
  String get chatsFilterUnread => 'Оқылмаған';

  @override
  String get chatsFilterMesh => 'Mesh';

  @override
  String get chatsFilterFavorites => 'Таңдаулылар';

  @override
  String get chatsFolderDirect => 'Жеке';

  @override
  String get chatsFolderChannels => 'Арналар';

  @override
  String get chatsFolderOnline => 'Байланыста';

  @override
  String get chatsFoldersTitle => 'Қалталар';

  @override
  String get chatsFoldersHint =>
      'Қалталар — чаттар көшірілетін орын емес, осы тізімнің сүзгілері. Чаттардың үстінде керектерін қосыңыз.';

  @override
  String get chatsSearchHint => 'Чаттарды іздеу…';

  @override
  String get chatsStatusViaMesh => 'mesh арқылы';

  @override
  String get chatsStatusOffline => 'офлайн';

  @override
  String get peerKeyRotated => 'кілт өзгерді — қайта растаңыз';

  @override
  String get peersTitle => 'Маңайда';

  @override
  String get peersSubtitle => 'Bluetooth аясындағы құрылғылар';

  @override
  String get peersEmpty => 'Әңгімелесушілер ізделуде…';

  @override
  String peersHopsOne(int n) {
    return '$n секіріс қашықта';
  }

  @override
  String peersHopsOther(int n) {
    return '$n секіріс қашықта';
  }

  @override
  String get blePermissionTitle => 'Bluetooth рұқсаты қажет';

  @override
  String get blePermissionHint =>
      'Cubechat әңгімелесушілерді табу және хабарлама жіберу үшін Bluetooth-ты пайдаланады — интернет қажет емес.';

  @override
  String get blePermissionGrant => 'Рұқсат беру';

  @override
  String get blePermissionOpenSettings => 'Баптауларды ашу';

  @override
  String get blePermissionDeniedHint =>
      'Рұқсат берілмеді. Bluetooth-қа рұқсат беру үшін баптауларды ашыңыз.';

  @override
  String get bleAdapterOffTitle => 'Bluetooth өшірулі';

  @override
  String get bleAdapterOffHint =>
      'Маңайдағы құрылғыларды көру үшін Bluetooth-ты қосыңыз.';

  @override
  String get bleUnsupportedTitle => 'Bluetooth LE қолжетімсіз';

  @override
  String get bleUnsupportedHint =>
      'Бұл құрылғы немесе платформа Bluetooth Low Energy-ді қолдамайды. Телефонда көріңіз.';

  @override
  String get bleScanning => 'Іздеу…';

  @override
  String get bleRetry => 'Қайталау';

  @override
  String get bleEnable => 'Қосу';

  @override
  String get bleConnectFailed =>
      'Қосылу мүмкін болмады. Құрылғы аядан тыс болуы немесе оның Bluetooth мекенжайы өзгеруі мүмкін.';

  @override
  String get bleSignal => 'Сигнал';

  @override
  String get bleConnect => 'Қосылу';

  @override
  String get bleConnected => 'Қосылды';

  @override
  String get bleVerified => 'Расталған';

  @override
  String get editorAdjustBrightness => 'Жарықтық';

  @override
  String get editorAdjustContrast => 'Контраст';

  @override
  String get editorAdjustSaturation => 'Қанықтық';

  @override
  String get editorToolCrop => 'Қию';

  @override
  String get editorToolDraw => 'Сурет салу';

  @override
  String get editorToolAdjust => 'Түзету';

  @override
  String get editorTabSticker => 'Стикер';

  @override
  String get editorTabText => 'Мәтін';

  @override
  String get editorPenPen => 'Қалам';

  @override
  String get editorPenMarker => 'Маркер';

  @override
  String get editorPenNeon => 'Неон';

  @override
  String get editorPenArrow => 'Нұсқар';

  @override
  String get editorPenBlur => 'Бұлыңғыр';

  @override
  String get editorPenEraser => 'Өшіргіш';

  @override
  String get editorLevel => 'Түзулеу';

  @override
  String get editorTextHint => 'Фотодағы мәтін';

  @override
  String get editorCropFree => 'Еркін';

  @override
  String get editorRemove => 'Алып тастау';

  @override
  String get notificationUnknownSender => 'Жаңа хабарлама';

  @override
  String get bleUnknownPeer => 'Белгісіз құрылғы';

  @override
  String get bleBroadcasting => 'Эфирде';

  @override
  String bleConnectedCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n орталық құрылғы қосылған',
      one: '$n орталық құрылғы қосылған',
      zero: 'Қосылыс жоқ',
    );
    return '$_temp0';
  }

  @override
  String get verifyTitle => 'Растау';

  @override
  String get verifyIntro =>
      'Осы екі ізді әңгімелесушіңізбен жеке кездесіп немесе дауыстық қоңырау арқылы салыстырыңыз. Екі жақта да сәйкес келсе, Noise қол алысуына ешкім араласпағаны расталады.';

  @override
  String get verifyMine => 'СІЗДІҢ ІЗІҢІЗ';

  @override
  String verifyTheirs(String name) {
    return '$name ІЗІ';
  }

  @override
  String get verifyMarkAsVerified => 'Расталған деп белгілеу';

  @override
  String get verifyAlreadyDone => 'Бұл әңгімелесуші расталған.';

  @override
  String get verifyRevoke => 'Қайтарып алу';

  @override
  String verifyDoneSnack(String name) {
    return '$name расталған деп белгіленді';
  }

  @override
  String get chatInputHint => 'Хабарлама';

  @override
  String get chatSend => 'Жіберу';

  @override
  String get chatToday => 'Бүгін';

  @override
  String get chatYesterday => 'Кеше';

  @override
  String get chatDelivered => 'Жеткізілді';

  @override
  String get chatRead => 'Оқылды';

  @override
  String get chatSending => 'Жіберілуде';

  @override
  String get chatWaitingForConnection => 'Байланыс күтілуде';

  @override
  String sendQueueCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count хабарлама байланысты күтуде',
      one: '$count хабарлама байланысты күтуде',
    );
    return '$_temp0';
  }

  @override
  String sendQueueSlowNetwork(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Желі баяу — $count хабарлама жіберілуде',
      one: 'Желі баяу — $count хабарлама жіберілуде',
    );
    return '$_temp0';
  }

  @override
  String get sendQueueTitle => 'Жіберуді күтуде';

  @override
  String get sendQueueHint =>
      'Жол пайда болған сәтте — маңайда Bluetooth не интернет — олар өздігінен кетеді. Ештеңе басудың қажеті жоқ.';

  @override
  String get sendQueueRetry => 'Қазір көру';

  @override
  String get sendQueueCancel => 'Жіберуді болдырмау';

  @override
  String get sendQueueCancelled => 'Жіберілмеді — кері алынды';

  @override
  String get sendQueueTooLate => 'Кері алу кеш: хабарлама кетіп қалды';

  @override
  String get chatEncryptedNotice =>
      'Хабарламалар Noise протоколымен өтпелі шифрланған.';

  @override
  String get chatSessionHandshaking => 'Қорғалған арна орнатылуда…';

  @override
  String get chatSessionEstablished => 'Қорғалған · Noise XX';

  @override
  String get chatSessionFailed => 'Қосылу сәтсіз аяқталды';

  @override
  String get presenceOnline => 'желіде';

  @override
  String get presenceOffline => 'желіде емес';

  @override
  String get chatSessionFingerprintPending =>
      'Із қол алысу аяқталған соң пайда болады.';

  @override
  String get chatEmptyEstablished =>
      'Қорғалған арна дайын. Сөйлесуді бастау үшін хабарлама жіберіңіз.';

  @override
  String get chatEmptyHandshaking =>
      'Екінші жақтың қол алысуды аяқтауы күтілуде…';

  @override
  String get chatEmptyTitle => 'Мұнда әзірге хабарлама жоқ';

  @override
  String get chatEmptyGreetHint =>
      'Хабарлама жазыңыз немесе сәлемдесу үшін Кубиді түртіңіз.';

  @override
  String get profileTitle => 'Профиль';

  @override
  String get profileNickname => 'Лақап ат';

  @override
  String get profileNicknameEditTitle => 'Лақап атыңызды орнатыңыз';

  @override
  String get profileNicknameHint =>
      'Mesh желісінде басқалар сізді қалай көреді';

  @override
  String get profileNicknameSave => 'Сақтау';

  @override
  String get profileFingerprint => 'Ашық кілт ізі';

  @override
  String get profileLanguage => 'Тіл';

  @override
  String get profileLanguageEn => 'Ағылшын';

  @override
  String get profileLanguageUk => 'Украин';

  @override
  String get profileTransport => 'Транспорт';

  @override
  String get profileTransportMesh => 'Bluetooth mesh';

  @override
  String get profileBackground => 'Фонда жұмыс істеу';

  @override
  String get profileBackgroundSubtitle =>
      'Қолданба жабық кезде де хабарлама алу';

  @override
  String get profileBatteryExempt => 'Батареяны оңтайландыруды өшіру';

  @override
  String get profileAbout => 'Қолданба туралы';

  @override
  String profileVersion(String v) {
    return 'Нұсқа $v';
  }

  @override
  String get rotateKeysTitle => 'Аккаунт кілттерін ауыстыру';

  @override
  String get rotateKeysHint => 'Аккаунтыңыз бар құрылғы жоғалса не ұрланса';

  @override
  String get rotateKeysConfirmTitle => 'Аккаунт кілттерін ауыстыру керек пе?';

  @override
  String get rotateKeysConfirmBody =>
      'Контактілеріңіз жаңа кілттеріңізді алады және чаттарын сақтайды, бірақ әрқайсысынан кілттеріңізді қайта тексеру сұралады. Аккаунттың басқа құрылғыларының бәрі шығады; қалдырғыңыз келетіндерін осы телефоннан қайта байланыстырыңыз. CubeChat-тың ескі нұсқасындағы контактілер жаңартпайынша сізге жаза алмайды. Арналардың кілттері өзгермейді.';

  @override
  String get rotateKeysConfirmAction => 'Кілттерді ауыстыру';

  @override
  String get rotateKeysWorking => 'Кілттер ауыстырылуда…';

  @override
  String rotateKeysDone(int sent, int total) {
    return 'Жаңа кілттер. Хабарланған контактілер: $sent/$total';
  }

  @override
  String get rotateKeysSlow =>
      'Жаңа кілттер. Барлық контакт уақытында растамады; ретрансляторлар оларға сақтап қояды';

  @override
  String get profileEmergencyWipe => 'Шұғыл тазалау';

  @override
  String get profileEmergencyWipeConfirm => 'Бәрін өшіру керек пе?';

  @override
  String get profileEmergencyWipeConfirmHint =>
      'Сәйкестендіргішіңіз, контактілер тізімі және сөйлесулер тарихы жойылады. Бұл әрекетті қайтару мүмкін емес.';

  @override
  String get profileEmergencyWipeAction => 'Өшіру';

  @override
  String get cancel => 'Болдырмау';

  @override
  String get copy => 'Көшіру';

  @override
  String get copied => 'Көшірілді';

  @override
  String get channelsNewTitle => 'Жаңа арна';

  @override
  String get channelsNewTooltip => 'Жаңа арна';

  @override
  String get channelNameLabel => 'Арна атауы';

  @override
  String get channelPasswordLabel => 'Құпиясөз (міндетті емес)';

  @override
  String get channelJoinAction => 'Қосылу';

  @override
  String get channelNameHint =>
      'Дәл сол атау мен құпиясөзді енгізген кез келген адам сол бөлмеге түседі. Олардың тізімін сақтайтын сервер жоқ.';

  @override
  String get channelPasswordHint =>
      'Құпиясөз — кілттің өзі. Онсыз бөлме атауын білетін маңайдағы кез келген адамға ашық.';

  @override
  String get channelSubtitle => 'Топтық арна · ортақ кілт';

  @override
  String get channelMute => 'Дыбысын өшіру';

  @override
  String get channelUnmute => 'Дыбысын қосу';

  @override
  String channelMutedUntil(String time) {
    return '$time дейін дыбыссыз';
  }

  @override
  String get channelMuteFor => 'Дыбысын өшіру…';

  @override
  String channelMuteMinutes(int minutes) {
    return '$minutes минут';
  }

  @override
  String channelMuteHours(int hours) {
    return '$hours сағат';
  }

  @override
  String channelMuteDays(int days) {
    return '$days күн';
  }

  @override
  String get channelMuteForever => 'Қайта қосқанша';

  @override
  String get channelCommunity => 'Пікірлер';

  @override
  String get channelCommunityOpen => 'Талқылауды ашу';

  @override
  String channelCommunitySubtitle(String channel) {
    return '$channel талқылауы';
  }

  @override
  String get channelBackToChannel => 'Арнаға оралу';

  @override
  String get channelMemberActions => 'Қатысушы';

  @override
  String get channelRemoveMember => 'Арнадан шығару';

  @override
  String get channelRemoveMemberHint =>
      'Оның жазбалары мұнда енді қабылданбайды. Атау бойынша қайта кіруге ештеңе кедергі емес — мүшелік дегеніміз тек ортақ кілт.';

  @override
  String get channelMuteMember => 'Үнсіз ету…';

  @override
  String get channelUnmuteMember => 'Қайта жазуға рұқсат беру';

  @override
  String channelMemberRemoved(String name) {
    return '$name шығарылды';
  }

  @override
  String channelMemberMuted(String name) {
    return '$name үнсіз етілді';
  }

  @override
  String channelMemberCleared(String name) {
    return '$name қайта жаза алады';
  }

  @override
  String get channelMemberMutedNote => 'Үнсіз';

  @override
  String get channelShareHistory => 'Тарихпен бөлісу';

  @override
  String get channelShareHistoryHint =>
      'Кейін қосылғандар көре алуы үшін осы бөлменің соңғы жазбаларын эфирге қайта шығарады. Бұрыннан осында болғандар жаңа ештеңе алмайды.';

  @override
  String channelHistoryShared(int count) {
    return 'Ұсынылған жазбалар: $count';
  }

  @override
  String get channelHistoryNothing => 'Әзірге бөлісетін ештеңе жоқ';

  @override
  String get channelHistoryAuto => 'Жаңа қатысушыларға тарихты беру';

  @override
  String get channelHistoryAutoHint =>
      'Бөлмеде жаңа адам пайда болғанда, соңғы жазбалар оған өздігінен жіберіледі. Әзірге тек мәтін — фотолар бөліктер ағыны түрінде жүреді, оларды барлығына қайталамай қайта жіберу мүмкін емес.';

  @override
  String get channelPostComments => 'Пікірлер';

  @override
  String get channelNoComments => 'Бұл туралы әлі ешкім ештеңе айтпады';

  @override
  String get channelCommentHint => 'Пікір';

  @override
  String get channelMuteCustom => 'Қанша уақытқа?';

  @override
  String get channelMuteCustomHint => 'Сағат';

  @override
  String get chatPinnedManage => 'Бекітілгендер';

  @override
  String get chatPeekOpen => 'Чатты ашу';

  @override
  String get chatPeekPin => 'Бекіту';

  @override
  String get chatPeekUnpin => 'Бекітуден алу';

  @override
  String get chatPeekUnmute => 'Дыбысын қосу';

  @override
  String get chatPeekMarkRead => 'Оқылды деп белгілеу';

  @override
  String get chatDeleteForMeHint =>
      'Осы телефоннан жойылады және бекітуден алынады. Екінші жақтағы көшірме сақталады.';

  @override
  String get pushWakeTitle => 'Осы телефонды ояту';

  @override
  String get pushWakeHint =>
      'Шағын сервер ретрансляторларда мекенжайыңызды бақылап, бірдеңе келгенде осы телефонды оятады — сонда жабық қолданба да хабарлайды. Ол хабарламаны да, кілтті де көрмейді — тек мекенжайыңызға бірдеңе келгенін және қашан келгенін біледі. Ретранслятор мұны онсыз да біледі; бұл соны білетін екінші орын.';

  @override
  String get pushWakeDeniedTitle => 'Хабарландырулар өшірулі';

  @override
  String get pushWakeDeniedHint =>
      'Жүйеге бір рет «жоқ» деп жауап берілген, ол енді қайта сұрамайды, сондықтан мұны тек Баптаулардан қосуға болады — cubechat, содан кейін «Хабарландырулар». Кейін осында қайтыңыз.';

  @override
  String get pushWakeRefused => 'Хабарландыруларға рұқсат берілмеді';

  @override
  String get privacyForwardLinkTitle => 'Қайта жіберулерде профильге сілтеме';

  @override
  String get privacyForwardLinkHint =>
      'Біреу сіздің хабарламаңызды қайта жібергенде, оның үстіндегі жол профиліңізді аша алады. Өшірулі болса, олар тек атыңызды көреді, басатын ештеңе жоқ. Бұл олардың қолданбасына жасалған өтініш, бұл қолданба оны мәжбүрлей алмайды.';

  @override
  String get privacyShareSheetTitle => '«Бөлісу» мәзіріндегі чаттар';

  @override
  String get privacyShareSheetOnHint =>
      'Соңғы төрт чатыңыздың атаулары Android-қа беріледі, сонда оларға кез келген қолданбадан жіберуге болады. Қолданба құлпы оларды жасырмайды.';

  @override
  String get privacyShareSheetOffHint =>
      'Android-қа ештеңе берілмейді. CubeChat-қа бөліскенде чатты таңдау сұралады.';

  @override
  String get privacyCallsTitle => 'Қоңырауларды қабылдау';

  @override
  String get privacyCallsOnHint =>
      'Контактілеріңіз сізге қоңырау шала алады. Бір адамға тыйым салу үшін оның профилін ашыңыз.';

  @override
  String get privacyCallsOffHint =>
      'Профилінде рұқсат бергендеріңізден басқа ешкім сізге қоңырау шала алмайды. Қабылданбаған қоңырау оларға «бос емес» болып көрінеді.';

  @override
  String get chatsStatusChannel => 'арна';

  @override
  String get channelInviteTitle => 'Адам қосу';

  @override
  String get channelInviteAction => 'Шақыру';

  @override
  String get channelInviteEmpty =>
      'Әзірге таныс әңгімелесушілер жоқ. Алдымен «Маңайда» қойындысында біреумен танысыңыз.';

  @override
  String get channelInviteSent => 'Шақырулар жіберілді';

  @override
  String get channelInviteNoneSent => 'Қазір ешкімге жету мүмкін болмады';

  @override
  String get channelNameTooLong => 'Арна атауы тым ұзын';

  @override
  String get chatsActionFavorite => 'Таңдаулыларға қосу';

  @override
  String get chatsActionUnfavorite => 'Таңдаулылардан алып тастау';

  @override
  String get chatsActionDelete => 'Чатты жою';

  @override
  String get chatsDeleteTitle => 'Бұл чатты жою керек пе?';

  @override
  String chatsDeleteManyHint(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          '$count сөйлесу тазаланады. Контактілер сақталады, сондықтан оларға кодтармен алмаспай-ақ қайта жаза аласыз.',
      one:
          '$count сөйлесу тазаланады. Контактілер сақталады, сондықтан оларға кодтармен алмаспай-ақ қайта жаза аласыз.',
    );
    return '$_temp0';
  }

  @override
  String get chatsDeletedToast => 'Чат жойылды.';

  @override
  String chatsDeletedManyToast(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count чат жойылды.',
      one: '$count чат жойылды.',
    );
    return '$_temp0';
  }

  @override
  String get undo => 'Қайтару';

  @override
  String get chatsDeletePeerHint =>
      'Сөйлесу тазаланады. Контакт сақталады, сондықтан оған кодтармен алмаспай-ақ қайта жаза аласыз.';

  @override
  String get chatsDeleteChannelHint =>
      'Арнадан шығып, оның тарихын жоясыз. Қайта қосылу үшін кілт қайта керек болады.';

  @override
  String get chatsDeleteForThemToo => 'Әңгімелесушіде де жою';

  @override
  String get chatsDeleteForThemHint =>
      'Оның қолданбасынан бүкіл сөйлесуді, соның ішінде өзі жазғанын да тазалауды сұрайды. Арнада тек өз хабарламаларыңыз қайтарылады.';

  @override
  String get chatEditAction => 'Өңдеу';

  @override
  String get chatEditTitle => 'Хабарламаны өңдеу';

  @override
  String get chatEditSave => 'Сақтау';

  @override
  String get chatEdited => 'өңделді';

  @override
  String get chatDeleteAction => 'Жою';

  @override
  String get chatDeleteTitle => 'Хабарламаны жою керек пе?';

  @override
  String get chatDeleteForMe => 'Менде жою';

  @override
  String get chatDeleteForEveryone => 'Барлығында жою';

  @override
  String get chatPinTitle => 'Хабарламаны бекіту керек пе?';

  @override
  String get chatPinForBoth => 'Екеумізде бекіту';

  @override
  String get chatPinForMe => 'Тек менде бекіту';

  @override
  String get chatReplyAction => 'Жауап беру';

  @override
  String chatReplyingTo(String name) {
    return 'Жауап: $name';
  }

  @override
  String get chatReplyYou => 'өзіңіз';

  @override
  String get chatCopyAction => 'Көшіру';

  @override
  String get chatCopied => 'Көшірілді';

  @override
  String get chatForwardAction => 'Қайта жіберу';

  @override
  String get chatForwardTitle => 'Кімге жіберу';

  @override
  String get shareIntoTitle => 'Кімге жіберу';

  @override
  String get shareNearbyAirDrop => 'Маңайға AirDrop арқылы';

  @override
  String get shareNearbyAirDropHint => 'Интернетсіз — қасыңыздағыларға';

  @override
  String get shareSent => 'Жіберілді';

  @override
  String get shareFailed => 'Бір бөлігін жіберу мүмкін болмады';

  @override
  String get chatForwardEmpty => 'Әзірге басқа чаттар жоқ';

  @override
  String chatForwardSendCount(int count) {
    return 'Жіберу ($count)';
  }

  @override
  String chatForwardSentCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count чатқа қайта жіберілді',
      one: 'Бір чатқа қайта жіберілді',
    );
    return '$_temp0';
  }

  @override
  String chatForwardSent(String name) {
    return 'Қайта жіберілді: $name';
  }

  @override
  String chatSentAt(String time) {
    return 'Жіберілді: $time';
  }

  @override
  String chatReadAt(String time) {
    return 'Оқылды: $time';
  }

  @override
  String get chatPinAction => 'Бекіту';

  @override
  String get chatUnpinAction => 'Бекітуден алу';

  @override
  String chatPinnedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count бекітілген хабарлама',
      one: '$count бекітілген хабарлама',
      zero: 'Бекітілген хабарлама жоқ',
    );
    return '$_temp0';
  }

  @override
  String get chatNoPins => 'Мұнда ештеңе бекітілмеген';

  @override
  String get chatUnpinAll => 'Барлық хабарламаны бекітуден алу';

  @override
  String get chatShowAllPins => 'Барлық бекітілген хабарламалар';

  @override
  String get chatUnpinConfirm => 'Бұл хабарламаны бекітуден алу керек пе?';

  @override
  String get chatUnpinConfirmHint =>
      'Ол осы чаттағы барлығы үшін бекітуден алынады.';

  @override
  String get chatPinnedTitle => 'Бекітілген хабарлама';

  @override
  String get chatPinnedGone => 'Бұл хабарлама чатта енді жоқ';

  @override
  String get peerBlock => 'Бұғаттау';

  @override
  String get peerUnblock => 'Бұғаттан шығару';

  @override
  String get peerMute => 'Дыбысын өшіру';

  @override
  String get peerUnmute => 'Дыбысын қосу';

  @override
  String get peerBlockedNote => 'Бұғатталған — хабарламалары қабылданбайды.';

  @override
  String get relaysTitle => 'Интернет арқылы қосалқы арна';

  @override
  String get relaysCardTitle => 'Әңгімелесушілерге интернет арқылы жету';

  @override
  String get relaysCardSubtitle =>
      'Bluetooth жеткізе алмаса, Nostr ретрансляторлары арқылы жіберу';

  @override
  String get relaysExplainer =>
      'Хабарламалар өтпелі шифрланған күйде қалады — ретранслятор Bluetooth жеткізетін сол мөрленген кадрды ғана тасиды. Бірақ ол қай екі кілттің және қашан сөйлесетінін біледі. Әдепкіде өшірулі.';

  @override
  String get relaysMyAddress => 'Ретранслятордағы мекенжайыңыз';

  @override
  String get relaysCopied => 'Көшірілді';

  @override
  String get circleLensTitle => 'Дөңгелектерге алдыңғы камера';

  @override
  String get circleLensFrontHint =>
      'Дөңгелек бейнехабарламалар сізге қараған камерамен түсіріледі.';

  @override
  String get circleLensBackHint =>
      'Дөңгелек бейнехабарламалар негізгі камерамен түсіріледі — өзіңіз қарап тұрған нәрсені көрсету үшін.';

  @override
  String get channelCloseTitle => 'Бөлмені барлығы үшін жабу';

  @override
  String get channelCloseSubtitle =>
      'Оны әр қатысушының телефонынан жояды. Мұны тек сіз жасай аласыз.';

  @override
  String get channelCloseConfirm =>
      'Бөлме, оның хабарламалары мен қатысушылары ол бар әр телефоннан жойылады. Ешкім бұғатталмайды: кілт атаудан шығады, сондықтан атауды есте сақтаған кез келген адам бос бөлмені қайта аша алады.';

  @override
  String get channelCloseAction => 'Бөлмені жабу';

  @override
  String get circleHint =>
      'Жіберу үшін босатыңыз · болдырмау үшін солға сырғытыңыз';

  @override
  String get circleHintLocked => 'Аяқтаған соң «Жіберу» түймесін басыңыз';

  @override
  String get circleNeedsCamera => 'Дөңгелектерге камера мен микрофон қажет';

  @override
  String get circleFailed => 'Дөңгелекті жазу мүмкін болмады';

  @override
  String get relaysListLabel => 'Ретрансляторлар';

  @override
  String get relaysLaneMedia => 'Медиа ретрансляторлары';

  @override
  String get relaysLaneMediaNote =>
      'Фото, файл және бейне осылар арқылы жүреді, сонда тасымалдау сөйлесуді баяулатпайды.';

  @override
  String get relaysLaneLocation => 'Геолокация ретрансляторлары';

  @override
  String get relaysLaneLocationNote =>
      'Картадағы маяктар басқаның бәрінен бөлек осылар арқылы жүреді.';

  @override
  String get relaysAdd => 'Ретранслятор қосу';

  @override
  String get relaysAddHint => 'wss://relay.example.com';

  @override
  String get relaysInvalidUrl => 'wss:// немесе ws:// мекенжайын енгізіңіз';

  @override
  String get relaysRemove => 'Жою';

  @override
  String get relaysStateConnected => 'Қосылды';

  @override
  String get relaysStateConnecting => 'Қосылуда…';

  @override
  String get relaysStateFailed => 'Қолжетімсіз';

  @override
  String get relaysStateIdle => 'Өшірулі';

  @override
  String get relaysEmpty =>
      'Ретрансляторлар бапталмаған — қосалқы арна өшірулі.';

  @override
  String get contactTitle => 'Контакт картасы';

  @override
  String get contactMineLabel => 'Сіздің картаңыз';

  @override
  String get contactMineExplainer =>
      'Мұны Bluetooth аясынан тыс адамға жіберіңіз. Онда кілттеріңіз бен ретранслятордағы мекенжайыңыз бар — сізбен интернет арқылы шифрланған чат бастауға осы жеткілікті.';

  @override
  String get contactCopy => 'Көшіру';

  @override
  String get contactShare => 'Бөлісу';

  @override
  String get contactCopied => 'Карта көшірілді';

  @override
  String get contactShareSubject => 'Менің cubechat контакт картам';

  @override
  String get contactAddLabel => 'Адам қосу';

  @override
  String get contactAddHint => 'Контакт картасын қойыңыз';

  @override
  String get contactAddAction => 'Қосу';

  @override
  String get contactPaste => 'Қою';

  @override
  String contactAdded(String name) {
    return '$name қосылды';
  }

  @override
  String get contactInvalid => 'Бұл жарамды контакт картасы емес';

  @override
  String get contactOwnCard => 'Бұл өзіңіздің картаңыз';

  @override
  String get contactUnverified =>
      'Осылай қосылған контакт басында расталмаған болады. Кез келген адам карта жасап, оған кез келген атты жаза алады, сондықтан сенбес бұрын іздерді жеке кездесіп немесе қоңырау арқылы салыстырыңыз.';

  @override
  String get contactRelayOff =>
      'Интернет арқылы қосалқы арна өшірулі, сондықтан карта әзірге ешкімге жетпейді.';

  @override
  String get contactRelayEnable => 'Қосу';

  @override
  String get profileContactCard => 'Контакт картасы';

  @override
  String get chatsAddContactTooltip => 'Контактіні карта арқылы қосу';

  @override
  String get chatsMenuTooltip => 'Тағы';

  @override
  String get chatsMenuAddContact => 'Контакт қосу';

  @override
  String get chatsMenuNewChannel => 'Жаңа арна';

  @override
  String get profileDiscoverable => 'Маңайда көріну';

  @override
  String get profileDiscoverableOnHint =>
      'Аядағы кез келген адам сізді таба алады';

  @override
  String get profileDiscoverableOffHint =>
      'Сізге тек контактілеріңіз жете алады';

  @override
  String get profileDiscoverableExplainer =>
      'Қосулы болса, хабарландыруыңыз ашық таратылады, сондықтан бейтаныс адам жақындап келіп сізбен таныса алады — бірақ тыңдап тұрған кез келген адам кілтіңіз бен атыңызды жазып алады. Өшірулі болса, сол жинақ тек бар контактілеріңізге мөрленіп жіберіледі, ал маршруттау ID-леріңізді бір-бірімен байланыстыру мүмкін емес. Жаңа адамдарға онда контакт картасы керек.';

  @override
  String get voiceHoldHint => 'Дауыстық хабарлама жазу үшін басып тұрыңыз';

  @override
  String get voiceTrimPlay => 'Ойнату';

  @override
  String get voiceTrimPause => 'Кідірту';

  @override
  String get voiceTrimDiscard => 'Жазбаны жою';

  @override
  String voiceTrimSelection(String duration) {
    return 'Жіберілетіні: $duration';
  }

  @override
  String get profileLastSeen => 'Соңғы рет желіде';

  @override
  String get profileLastSeenOnHint =>
      'Контактілер қолданбада қашан болғаныңызды көреді';

  @override
  String get profileLastSeenOffHint =>
      'Сіздің уақытыңызды ешкім көрмейді, сіз де ешкімдікін көрмейсіз — тек кім желіде екені көрінеді';

  @override
  String get profileMapLocation => 'Мені картада көрсету';

  @override
  String get profileMapLocationOnHint =>
      'Геолокацияны қолмен жіберуге болады, ал белгіңіз картада көрсетіледі';

  @override
  String get profileMapLocationOffHint =>
      'Қолданба геолокацияны сұрамайды, ал белгіңіз жасырын қалады';

  @override
  String get desktopAutostartTitle => 'Windows-пен бірге іске қосу';

  @override
  String get desktopAutostartHint =>
      'CubeChat жүйелік науада күтеді, сондықтан терезесі жабық болса да қоңыраулар мен хабарламалар осы компьютерге жетеді';

  @override
  String get trayOpen => 'CubeChat-ты ашу';

  @override
  String get trayQuit => 'Шығу';

  @override
  String get callDirectTitle => 'Тікелей қоңыраулар';

  @override
  String get callDirectOnHint =>
      'Жылдамырақ, бірақ әңгімелесушіңіз IP мекенжайыңызды біледі';

  @override
  String get callDirectOffHint =>
      'Қоңыраулар біздің ретранслятор арқылы өтеді: әңгімелесушіңіз IP мекенжайыңызды көрмейді, ал ретранслятор сөйлесуді ести алмайды';

  @override
  String get profileReadReceipts => 'Оқылғанын көрсету';

  @override
  String get profileReadReceiptsOnHint => 'Жіберуші сіздің оқығаныңызды көреді';

  @override
  String get profileReadReceiptsOffHint =>
      'Оқыған уақытыңызды жібермейсіз, бірақ басқаларынікін көресіз';

  @override
  String get profilePrivacyExplainer =>
      'Соңғы рет желіде болу екі жаққа да әсер етеді: өз күйіңізді жасырсаңыз, басқалардың күйін де көрмейсіз. Оқылғанын көрсету тек сіз жіберетін нәрсені басқарады. Хабарламалардың жеткізілуіне әсер етпейді.';

  @override
  String get chatTimerAction => 'Таймер';

  @override
  String get chatTimerRemove => 'Таймерді алып тастау';

  @override
  String get chatTimerTitle => 'Бұл хабарламаны мына уақыттан кейін жою';

  @override
  String chatTimerSet(String time) {
    return 'Хабарлама $time өткен соң жойылады';
  }

  @override
  String get chatTimerLocalHint =>
      'Тек осы құрылғыда — олардағы көшірме өздерінікі';

  @override
  String get contactTagAction => 'Белгі';

  @override
  String get contactTagRemove => 'Белгіні алып тастау';

  @override
  String get contactTagTitle => 'Белгі таңдаңыз';

  @override
  String get contactTagAll => 'Барлығы';

  @override
  String get quietHoursTitle => 'Тыныш сағаттар';

  @override
  String get quietHoursHint => 'Хабарламалар келе береді, телефон үндемейді';

  @override
  String get quietHoursFrom => 'Бастап';

  @override
  String get quietHoursTo => 'Дейін';

  @override
  String get notifPreviewTitle => 'Хабарландыруларда көрсету';

  @override
  String get notifPreviewFull => 'Аты және мәтін';

  @override
  String get notifPreviewNameOnly => 'Тек аты';

  @override
  String get notifPreviewHidden => 'Ештеңе';

  @override
  String get notifPreviewHint =>
      'Хабарландырулар құлып экранында және хабарландыруларға рұқсаты бар қолданбаларға көрінеді — қолданба құлпы қосулы болса да';

  @override
  String get notifPreviewNewMessage => 'Жаңа хабарлама';

  @override
  String get appLockTitle => 'Қолданба құлпы';

  @override
  String get appLockHint => 'Қолданба ашылғанда код сұрау';

  @override
  String get appLockPrompt => 'Кодыңызды енгізіңіз';

  @override
  String get appLockUnlock => 'Құлыпты ашу';

  @override
  String get appLockWrong => 'Код қате';

  @override
  String get appLockSetTitle => 'Код орнату';

  @override
  String get appLockSetHint =>
      'Төрт не одан көп сан. Оны қалпына келтіру мүмкін емес.';

  @override
  String get appLockOffTitle => 'Құлыпты өшіру';

  @override
  String get appLockOffHint => 'Ағымдағы кодыңызды енгізіңіз';

  @override
  String get appLockOn => 'Қолданба құлпы қосулы';

  @override
  String get appLockOff => 'Қолданба құлпы өшірулі';

  @override
  String get avatarSet => 'Фото таңдау';

  @override
  String get avatarChange => 'Фотоны өзгерту';

  @override
  String get avatarView => 'Фотоны көру';

  @override
  String get profileCoverPhoto =>
      'Профиль фотосы, үлкейту үшін екі рет түртіңіз';

  @override
  String get profileCoverMenu => 'Фото әрекеттері';

  @override
  String get avatarSaved => 'Галереяға сақталды';

  @override
  String get avatarRemove => 'Фотоны алып тастау';

  @override
  String get avatarRemoveConfirm =>
      'Аватар осы құрылғыдан жойылады. Оның орнына жасалған градиент қайта оралады.';

  @override
  String get avatarFailed => 'Суретті оқу мүмкін болмады';

  @override
  String get fileOpenHint => 'Ашу үшін түртіңіз';

  @override
  String get fileMissing => 'Бұл файл енді қолжетімсіз';

  @override
  String get fileNoHandlerTitle => 'Мұны ашатын қолданба жоқ';

  @override
  String get fileNoHandlerHint =>
      'Орнатылған қолданбалардың ешқайсысы бұл файл түрін ашпайды. Оның орнына оны басқа қолданбаға жіберуге болады.';

  @override
  String get fileRequestedAgain => 'Жіберушіден қайта сұралды';

  @override
  String get fileOpenFailed => 'Бұл файлды ашу мүмкін болмады';

  @override
  String get fileShareAction => 'Қолданбаға жіберу';

  @override
  String fileTooLargeMesh(int limit) {
    return 'Файл тым үлкен — mesh арқылы шегі $limit МБ';
  }

  @override
  String fileTooLargeRelay(int limit) {
    return 'Интернет арқылы шегі $limit МБ. Үлкенірек файл жіберу үшін алушыға жақынырақ барыңыз.';
  }

  @override
  String get mediaSendOriginal => 'Түпнұсқа';

  @override
  String get attachFile => 'Файл';

  @override
  String get attachGallery => 'Галерея';

  @override
  String get attachCamera => 'Камера';

  @override
  String get cameraUnavailable => 'Камера қолжетімсіз';

  @override
  String get profileEditName => 'Аты';

  @override
  String get profileMyCard => 'Карта';

  @override
  String get mediaCaptionHint => 'Сипаттама қосу…';

  @override
  String get mediaDiscardTitle => 'Таңдауды тастау керек пе?';

  @override
  String get mediaDiscardMessage =>
      'Галереяны жауып, таңдалған фотоларды тастау керек пе?';

  @override
  String get mediaDiscardConfirm => 'Тастау';

  @override
  String get mediaPhotosAccessOff => 'Фотоларға рұқсат өшірулі';

  @override
  String get mediaPhotosAccessOffHint =>
      'Қазір CubeChat тек бейнелерді көреді. Суреттеріңізді көрсету үшін жүйе баптауларында фотоларға рұқсат беріңіз.';

  @override
  String get mediaVideosOnly =>
      'Тек бейнелер көрінеді — фотоларға рұқсат беріңіз';

  @override
  String get mediaOpenSettings => 'Баптауларды ашу';

  @override
  String get mediaTakePhoto => 'Суретке түсіру';

  @override
  String get contactProfileAutoDelete => 'Чатты автотазалау';

  @override
  String get contactProfileAutoDeleteTitle => 'Хабарламаларды автожою';

  @override
  String get contactProfileAutoDeleteOff => 'Өшірулі';

  @override
  String get contactProfileAutoDeleteOneDay => '1 күннен кейін';

  @override
  String get contactProfileAutoDeleteSevenDays => '7 күннен кейін';

  @override
  String get contactProfileAutoDeleteThirtyDays => '30 күннен кейін';

  @override
  String contactProfileAutoDeleteUpdated(String period) {
    return 'Автотазалау: $period';
  }

  @override
  String get contactProfileShare => 'Контактімен бөлісу';

  @override
  String get contactProfileShareTitle => 'Контактіні кімге жіберу';

  @override
  String get contactProfileShareEmpty => 'Әзірге басқа чаттар жоқ';

  @override
  String contactProfileShareSent(String name) {
    return 'Жіберілді: $name';
  }

  @override
  String get contactProfileRestrictCopying => 'Көшіруге тыйым салу';

  @override
  String get contactProfileAllowCopying => 'Көшіруге рұқсат беру';

  @override
  String get contactHideAvatar => 'Фотомды жасыру';

  @override
  String get contactShowAvatar => 'Фотомды көрсету';

  @override
  String get contactHideLastSeen => 'Соңғы рет желіде болғанымды жасыру';

  @override
  String get contactShowLastSeen => 'Соңғы рет желіде болғанымды көрсету';

  @override
  String get contactHideReadReceipts => 'Оқыған уақытымды жасыру';

  @override
  String get contactShowReadReceipts => 'Оқыған уақытымды көрсету';

  @override
  String get contactHiddenFromThem => 'Бұл контактіден жасырылған';

  @override
  String get contactRefuseCalls => 'Оның қоңырауларын қабылдамау';

  @override
  String get contactAllowCalls => 'Оның қоңырауларын қабылдау';

  @override
  String get contactCallsException => 'Қоңырау баптауыңыздан ерекшелік';

  @override
  String get contactProfileCopyingRestricted =>
      'Көшіру және қайта жіберу өшірулі';

  @override
  String get contactProfileCopyingRestrictedByPeer => 'Әңгімелесуші өшірген';

  @override
  String get contactProfileCopyingAllowed =>
      'Көшіру және қайта жіберу рұқсат етілген';

  @override
  String get contactProfileDelete => 'Контактілерден жою';

  @override
  String get contactProfileRestore => 'Контактілерге қайтару';

  @override
  String get contactProfileRestoreDone => 'Контактілеріңізге қайтарылды';

  @override
  String get contactProfileDeleteTitle => 'Контактіні жою керек пе?';

  @override
  String contactProfileDeleteMessage(String name) {
    return '$name «Контактілер» бөлімінен жоғалады. Чат тарихы осы құрылғыда сақталады.';
  }

  @override
  String get contactProfileMedia => 'Медиа';

  @override
  String get contactProfileVoiceMessages => 'Дауыстық хабарламалар';

  @override
  String get contactProfileStickers => 'Стикерлер';

  @override
  String get contactProfileNoStickers => 'Әзірге стикерлер жоқ';

  @override
  String get contactProfileNoMedia => 'Әзірге медиа жоқ';

  @override
  String get contactProfileNoVoiceMessages =>
      'Әзірге дауыстық хабарламалар жоқ';

  @override
  String get contactProfileOpen => 'Профильді ашу';

  @override
  String autoDeleteDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count күн',
      one: '$count күн',
    );
    return '$_temp0';
  }

  @override
  String autoDeleteHours(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count сағат',
      one: '$count сағат',
    );
    return '$_temp0';
  }

  @override
  String autoDeleteMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count минут',
      one: '$count минут',
    );
    return '$_temp0';
  }

  @override
  String autoDeleteSeconds(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count секунд',
      one: '$count секунд',
    );
    return '$_temp0';
  }

  @override
  String get autoDeleteCustom => 'Басқа…';

  @override
  String get autoDeleteCustomHint => 'Саны';

  @override
  String get autoDeleteUnitMinutes => 'мин';

  @override
  String get autoDeleteUnitHours => 'сағат';

  @override
  String get autoDeleteUnitDays => 'күн';

  @override
  String get contactProfileAutoDeleteSet => 'Орнату';

  @override
  String get contactProfileFiles => 'Файлдар';

  @override
  String get contactProfileNoFiles => 'Әзірге файлдар жоқ';

  @override
  String get contactProfileLinks => 'Сілтемелер';

  @override
  String get contactProfileNoLinks => 'Әзірге сілтемелер жоқ';

  @override
  String get contactProfilePolls => 'Сауалнамалар';

  @override
  String get contactProfileNoPolls => 'Әзірге сауалнамалар жоқ';

  @override
  String get presenceRecently => 'жақында болды';

  @override
  String get presenceJustNow => 'жаңа ғана';

  @override
  String presenceHoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count сағат бұрын болды',
      one: '$count сағат бұрын болды',
    );
    return '$_temp0';
  }

  @override
  String presenceYesterdayAt(String time) {
    return 'кеше сағат $time болды';
  }

  @override
  String presenceOnWeekday(String day) {
    String _temp0 = intl.Intl.selectLogic(
      day,
      {
        '1': 'дүйсенбіде болды',
        '2': 'сейсенбіде болды',
        '3': 'сәрсенбіде болды',
        '4': 'бейсенбіде болды',
        '5': 'жұмада болды',
        '6': 'сенбіде болды',
        '7': 'жексенбіде болды',
        'other': 'осы аптада болды',
      },
    );
    return '$_temp0';
  }

  @override
  String presenceWeeksAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count апта бұрын болды',
      one: 'бір апта бұрын болды',
    );
    return '$_temp0';
  }

  @override
  String presenceMonthsAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ай бұрын болды',
      one: 'бір ай бұрын болды',
    );
    return '$_temp0';
  }

  @override
  String get presenceLongAgo => 'көптен бері болмады';

  @override
  String presenceMinutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count минут бұрын болды',
      one: '$count минут бұрын болды',
    );
    return '$_temp0';
  }

  @override
  String chatReadByCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count адам оқыды',
      one: '$count адам оқыды',
    );
    return '$_temp0';
  }

  @override
  String get chatsSearchFrequent => 'Жиі сөйлесетіндер';

  @override
  String get chatsSearchRecent => 'Соңғылар';

  @override
  String get chatsSearchClear => 'Тазалау';

  @override
  String get chatsSearchStartHint =>
      'Чаттарды атауы бойынша, ал кез келген хабарламаны сөздері бойынша іздеңіз.';

  @override
  String get chatsSearchEmpty => 'Ештеңе табылмады';

  @override
  String get chatRoutesTitle => 'Бұл оған қалай жетеді';

  @override
  String get chatRoutesBluetoothHint => 'Тікелей оның телефонына, интернетсіз';

  @override
  String get chatRoutesMeshHint => 'Арадағы телефондар арқылы жеткізіледі';

  @override
  String get chatRoutesInternetHint =>
      'Маңайда ешкім болмаса, ретранслятор арқылы';

  @override
  String get chatRoutesHint =>
      'Жол әр хабарлама үшін сол сәтте қолжетімді нұсқалардан бөлек таңдалады.';

  @override
  String get chatRoutesPreferTitle => 'Алдымен нені көру';

  @override
  String get chatRoutesPreferMesh => 'Алдымен Bluetooth';

  @override
  String get chatRoutesPreferMeshHint =>
      'Бір бөлмеде жылдамырақ, трафик жұмсамайды, ретрансляторға ештеңе айтпайды';

  @override
  String get chatRoutesPreferRelay => 'Алдымен интернет';

  @override
  String get chatRoutesPreferRelayHint =>
      'Bluetooth байланысы нашар, ал интернет жақсы болғанда';

  @override
  String get chatRoutesPreferNote =>
      'Бұл қалау ғана, құлып емес. Таңдаған жолыңыз қолжетімсіз болса, хабарлама бәрібір екінші жолмен кетеді.';

  @override
  String get deadmanTitle => 'Пайдаланылмаса өшіру';

  @override
  String get deadmanOff => 'Өшірулі';

  @override
  String deadmanDays(int days) {
    return '$days күннен кейін';
  }

  @override
  String get deadmanHint =>
      'Егер қолданба сонша уақыт ашылмаса, келесі ашылғанда ондағының бәрі өшіріледі. Ол алдын ала ескерте алмайды — мәні де сонда.';

  @override
  String chatForwardedFrom(String name) {
    return 'Қайта жіберілген: $name';
  }

  @override
  String appLockWait(String left) {
    return 'Әрекет тым көп — $left күтіңіз';
  }

  @override
  String get appLockGraceTitle => 'Код сұрау';

  @override
  String get appLockGraceNow => 'Әр жолы';

  @override
  String appLockGraceAfter(String left) {
    return '$left бойы ашылмаса';
  }

  @override
  String get chatCalendarTitle => 'Күні бойынша';

  @override
  String get chatCalendarEmpty => 'Мұнда әлі ештеңе айтылмаған';

  @override
  String get chatsSearchChatsSection => 'Чаттар';

  @override
  String get chatsSearchMessagesSection => 'Хабарламалар';

  @override
  String get contactProfileViewInChat => 'Чатта көру';

  @override
  String get chatDraft => 'Жоба';

  @override
  String get chatSearchTitle => 'Іздеу';

  @override
  String get chatSearchHint => 'Хабарламаларды іздеу';

  @override
  String get chatSearchNoResults => 'Сәйкестік жоқ';

  @override
  String get chatSearchPrevious => 'Алдыңғы нәтиже';

  @override
  String get chatSearchNext => 'Келесі нәтиже';

  @override
  String chatMessageCount(int count) {
    return '$count хабарлама';
  }

  @override
  String get chatRouteBluetooth => 'Bluetooth';

  @override
  String get chatRouteMesh => 'Mesh';

  @override
  String get chatRouteInternet => 'Интернет';

  @override
  String get chatRouteQueued => 'Кезекте';

  @override
  String get attachStickers => 'Стикерлер';

  @override
  String get stickersEmpty => 'Әзірге стикерлер жоқ';

  @override
  String get stickersEmptyHint =>
      'Чаттағы суретті сақтаңыз — ол осында пайда болады.';

  @override
  String get stickerKeep => 'Стикер ретінде сақтау';

  @override
  String get stickerKept => 'Стикерлеріңізге сақталды';

  @override
  String get stickerForget => 'Стикерді жою';

  @override
  String get stickerCreate => 'Фотодан стикер жасау';

  @override
  String get stickerFailed => 'Бұл суреттен стикер жасау мүмкін болмады';

  @override
  String get stickerLabel => 'Стикер';

  @override
  String get previewPhoto => 'Фото';

  @override
  String get previewVoice => 'Дауыстық хабарлама';

  @override
  String get previewFile => 'Файл';

  @override
  String get stickerEmojiTitle => 'Оған эмодзи таңдаңыз';

  @override
  String get stickersMine => 'Менің стикерлерім';

  @override
  String get stickersStarterPack => 'Куби';

  @override
  String get emojiTab => 'Эмодзи';

  @override
  String get chatBlockedStatus => 'бұғатталған';

  @override
  String get chatBlockedHint => 'Сіз бұл адамды бұғаттадыңыз';

  @override
  String get chatRouteFallbackOff => 'Интернет өшірулі';

  @override
  String get chatAttachmentUnavailable =>
      'Қолжетімді байланыс жоқ. Bluetooth немесе интернет арқылы қосылып, қайталап көріңіз.';

  @override
  String get fileTransfersTitle => 'Файл тасымалдау';

  @override
  String get fileTransfersClear => 'Тарихты тазалау';

  @override
  String get fileTransfersEmpty => 'Әзірге файл тасымалдау болған жоқ';

  @override
  String get fileTransfersActive => 'Белсенді';

  @override
  String get fileTransfersHistory => 'Тарих';

  @override
  String get fileTransferPause => 'Кідірту';

  @override
  String get fileTransferResume => 'Жалғастыру';

  @override
  String get fileTransferRetry => 'Қайталау';

  @override
  String get fileTransferQueued => 'Байланыс күтуде';

  @override
  String get fileTransferRunning => 'Тасымалдануда';

  @override
  String get fileTransferPaused => 'Кідіртілді';

  @override
  String get fileTransferCompleted => 'Аяқталды';

  @override
  String get fileTransferFailed => 'Қате';

  @override
  String get fileTransferCanceled => 'Болдырылмады';

  @override
  String get profileFileTransfers => 'Файл тасымалдау';

  @override
  String get profileFileTransfersSubtitle =>
      'Барысы, кезек және тасымалдау тарихы';

  @override
  String get qrScanAction => 'QR кодты сканерлеу';

  @override
  String get qrScanTitle => 'QR кодты сканерлеу';

  @override
  String get qrScanHint =>
      'CubeChat контактісінің, арнасының, аккаунт тасымалының немесе компьютерге кіру кодын сканерлеңіз.';

  @override
  String get qrFlash => 'Қалта шам';

  @override
  String get qrCameraError =>
      'Камера қолжетімсіз. Камера рұқсатын тексеріп, қайталап көріңіз.';

  @override
  String get qrInvalid => 'Бұл жарамды Cubechat QR коды емес.';

  @override
  String qrChannelAdded(String name) {
    return '$name қосылды';
  }

  @override
  String get qrShow => 'QR кодты көрсету';

  @override
  String qrChannelTitle(String name) {
    return 'Қосылу: $name';
  }

  @override
  String get profileBackup => 'Шифрланған сақтық көшірме';

  @override
  String get profileBackupSubtitle =>
      'Кілттерді, контактілерді және тарихты қауіпсіз көшіру';

  @override
  String get backupTitle => 'Шифрланған сақтық көшірме';

  @override
  String get backupExplainer =>
      'Сақтық көшірмеде жеке сәйкестендіру кілттеріңіз, контактілер, арналар, баптаулар және хабарламалар тарихы бар. Ол осы телефонда сіз таңдаған құпиясөзбен шифрланады; Cubechat ұмытылған құпиясөзді қалпына келтіре алмайды.';

  @override
  String get backupCreate => 'Көшірме жасау';

  @override
  String get backupCreateSubtitle =>
      'Бәрін шифрлап, .cchatbackup файлын сақтау';

  @override
  String get backupRestore => 'Көшірмені қалпына келтіру';

  @override
  String get backupRestoreSubtitle =>
      'Осы телефондағы Cubechat профилін көшірме файлымен ауыстыру';

  @override
  String get backupPasswordTitle => 'Сақтық көшірме құпиясөзі';

  @override
  String get backupPasswordHint => 'Кемінде 8 таңба';

  @override
  String get backupConfirmPassword => 'Құпиясөзді қайталаңыз';

  @override
  String get backupPasswordMismatch => 'Құпиясөздер сәйкес келмейді';

  @override
  String get backupPasswordShort => 'Кемінде 8 таңба пайдаланыңыз';

  @override
  String get backupSaveTitle => 'Cubechat сақтық көшірмесін сақтау';

  @override
  String get backupSaved => 'Шифрланған көшірме сақталды';

  @override
  String get backupWhereTitle => 'Көшірмені қайда сақтау керек?';

  @override
  String get backupSaveToFiles => 'Файлдарға сақтау';

  @override
  String get backupSaveToFilesHint =>
      'Осы телефондағы қалта, жад картасы не бұлттық диск';

  @override
  String get backupSendToApp => 'Қолданбаға жіберу';

  @override
  String get backupSendToAppHint =>
      'Telegram, пошта, мессенджер — файл қабылдайтынның бәрі';

  @override
  String get backupFailed => 'Сақтық көшірме әрекетін аяқтау мүмкін болмады';

  @override
  String get backupRestoreConfirmTitle => 'Бұл профильді ауыстыру керек пе?';

  @override
  String get backupRestoreConfirmMessage =>
      'Осы телефондағы ағымдағы кілттер, контактілер, арналар, баптаулар және тарих таңдалған сақтық көшірмемен ауыстырылады.';

  @override
  String get backupRestoreConfirmAction => 'Қалпына келтіру';

  @override
  String get backupRestored => 'Сақтық көшірме қалпына келтірілді';

  @override
  String get backupPackingWait => 'Сақтық көшірме жасалуда…';

  @override
  String get backupUnpackingWait => 'Сақтық көшірме қалпына келтірілуде…';

  @override
  String get backupWaitHint =>
      'Фото мен бейнелер болса, бұл бірнеше минутқа созылуы мүмкін. Қолданбаны жаппаңыз.';

  @override
  String get backupInvalid =>
      'Құпиясөз қате, файл бүлінген немесе көшірме қолдау көрсетілмейді';

  @override
  String get channelInfoTitle => 'Арна туралы';

  @override
  String get channelParticipantsTitle => 'Қатысушылар';

  @override
  String get channelAdministratorsTitle => 'Әкімшілер';

  @override
  String get channelMakeAdmin => 'Әкімші ету';

  @override
  String get channelRemoveAdmin => 'Әкімшіліктен алу';

  @override
  String get channelNoParticipants =>
      'Қатысушылар қолтаңбалы әрекеттен кейін пайда болады';

  @override
  String get channelSharedContent => 'Медиа, файлдар және сауалнамалар';

  @override
  String get channelDescriptionTitle => 'Сипаттама';

  @override
  String get channelDescriptionEmpty => 'Әзірге сипаттама жоқ';

  @override
  String get channelDescriptionHint => 'Бұл арна не үшін';

  @override
  String get channelDescriptionAdminOnly =>
      'Сипаттаманы тек әкімші өзгерте алады';

  @override
  String get channelDescriptionSave => 'Сақтау';

  @override
  String get channelPrivateSubtitle => 'жабық арна';

  @override
  String get channelAvatarSet => 'Жаңа фото орнату';

  @override
  String get channelSettingsTitle => 'Арна баптаулары';

  @override
  String get channelSettingsHint => 'Кім жаза алады, көшіру, тарих';

  @override
  String get channelLeaveAction => 'Шығу';

  @override
  String get channelLeaveConfirm =>
      'Бөлме және онда айтылғанның бәрі осы телефоннан жойылады. Кілт атаудан шығады, сондықтан сол атауды теріп, оны қайта аша аласыз.';

  @override
  String get channelShareAction => 'Бөлісу';

  @override
  String channelMembersOf(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count қатысушы',
      one: '$count қатысушы',
    );
    return '$_temp0';
  }

  @override
  String get chatTyping => 'жазып жатыр…';

  @override
  String get chatRecordingVoice => 'дауыстық хабарлама жазып жатыр…';

  @override
  String get chatRecordingCircle => 'бейнехабарлама жазып жатыр…';

  @override
  String get chatSendingPhoto => 'фото жіберіп жатыр…';

  @override
  String get chatSendingVideo => 'бейне жіберіп жатыр…';

  @override
  String get chatSendingFile => 'файл жіберіп жатыр…';

  @override
  String get onboardingMeshTitle => 'Интернетсіз жұмыс істейді';

  @override
  String get onboardingMeshBody =>
      'Хабарламалар Bluetooth арқылы телефоннан телефонға жетеді. Байланыссыз, Wi-Fi-сыз, аккаунтсыз — тек айналаңыздағы адамдар.';

  @override
  String get onboardingRelayTitle => 'Ол болса — онымен де';

  @override
  String get onboardingRelayBody =>
      'Bluetooth аясынан тыс хабарламалар интернетпен жүріп, дәл солай жетеді. Қайсысын таңдаудың қажеті жоқ.';

  @override
  String get onboardingPrivacyTitle => 'Ортадағы ешкім оқи алмайды';

  @override
  String get onboardingPrivacyBody =>
      'Бәрі өтпелі шифрланған, ал сіздің сәйкестігіңіз — осы телефондағы кілт: телефон нөмірі емес, пошта емес, біреу тартып ала алатын аккаунт емес.';

  @override
  String get onboardingSkip => 'Өткізу';

  @override
  String get onboardingNext => 'Келесі';

  @override
  String get onboardingStart => 'Бастау';

  @override
  String get chatMediaShare => 'Бөлісу';

  @override
  String get chatMediaSaveToGallery => 'Галереяға сақтау';

  @override
  String get chatMediaShowInChat => 'Чатта көрсету';

  @override
  String get chatWallpaperTitle => 'Тұсқағаз';

  @override
  String get chatWallpaperClear => 'Қалпына келтіру';

  @override
  String get chatWallpaperDim => 'Хабарламалар астын күңгірттеу';

  @override
  String get chatSelectAction => 'Таңдау';

  @override
  String get chatForwardNothing => 'Мұнда қайта жіберуге болатын ештеңе жоқ';

  @override
  String chatSelectedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count таңдалды',
      one: '$count таңдалды',
    );
    return '$_temp0';
  }

  @override
  String chatDeleteSelectedTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count хабарламаны жою керек пе?',
      one: '$count хабарламаны жою керек пе?',
    );
    return '$_temp0';
  }

  @override
  String get contactAliasAction => 'Контакт атын өзгерту';

  @override
  String get contactAliasHint =>
      'Бұл атты тек сіз көресіз. Оның өз атын қолдану үшін бос қалдырыңыз.';

  @override
  String get viewOnceSendLabel => 'Бір рет көру';

  @override
  String get viewOnceTitle => 'Бір рет көру';

  @override
  String get viewOnceTapToView => 'Фото · бір рет көру үшін түртіңіз';

  @override
  String get viewOnceSent => 'Фото · жіберілді';

  @override
  String get viewOnceOpened => 'Фото ашылды';

  @override
  String get viewOnceUnavailable => 'Бұл фото енді қолжетімсіз';

  @override
  String get viewOnceWarning => 'Жапсаңыз, фото екеуіңізде де жойылады.';

  @override
  String get channelAvatarAdminOnly => 'Арна фотосын тек әкімші өзгерте алады';

  @override
  String get channelAdminOnly => 'Мұны тек әкімші өзгерте алады';

  @override
  String get channelAvatarTooLarge => 'Бұл фото тарату үшін тым үлкен';

  @override
  String get channelMemberUnknown => 'Әзірге контактілеріңізде жоқ';

  @override
  String get channelInviteToContacts => 'Оған контакт картаңызды жіберу';

  @override
  String channelContactInviteSent(String name) {
    return 'Контакт картасы ұсынылды: $name';
  }

  @override
  String get chatContactInvitation => 'Байланысуға шақыру';

  @override
  String get chatContactInvitationForYou => 'Сізге шақыру';

  @override
  String get channelPollTitle => 'Сауалнама';

  @override
  String get channelCreatePoll => 'Сауалнама жасау';

  @override
  String get channelPollQuestion => 'Сұрақ';

  @override
  String channelPollOption(int number) {
    return '$number-нұсқа';
  }

  @override
  String get channelPollAddOption => 'Нұсқа қосу';

  @override
  String get channelPollCreate => 'Жариялау';

  @override
  String channelPollVotes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count дауыс',
      one: '$count дауыс',
      zero: 'Дауыс жоқ',
    );
    return '$_temp0';
  }

  @override
  String get phoneTransferTitle => 'Жаңа телефонға көшіру';

  @override
  String get desktopPickChat => 'Кімге жазғыңыз келетінін таңдаңыз';

  @override
  String get desktopListCollapse => 'Тек аватарларды қалдыру';

  @override
  String get desktopListExpand => 'Чаттар тізімін көрсету';

  @override
  String get desktopLinkConnectTitle => 'Компьютерді қосу';

  @override
  String get desktopLinkConnectHint =>
      'Компьютердегі CubeChat көрсететін кодты сканерлеңіз';

  @override
  String get desktopLinkSignIn => 'Телефондағы аккаунтпен кіру';

  @override
  String get desktopLinkTitle => 'Телефон арқылы кіру';

  @override
  String get desktopLinkSteps =>
      'Телефонда: Профиль → Деректер → «Компьютерді қосу», содан кейін осы кодты сканерлеңіз. Екеуі де бір Wi-Fi желісінде болуы керек.';

  @override
  String get desktopLinkLimits =>
      'Телефон жұмысын жалғастырады. Интернеттен келген хабарламалар екеуіне де жетеді; біреуінен жіберілгені екіншісінде әзірге көрінбейді.';

  @override
  String get desktopLinkWaiting => 'Телефон күтілуде…';

  @override
  String get desktopLinkFailed =>
      'Аккаунтты алу мүмкін болмады. Қайталап көріңіз.';

  @override
  String get desktopLinkRetry => 'Қайталау';

  @override
  String get desktopLinkConfirmTitle =>
      'Бұл аккаунттың көшірмесін компьютерге жіберу керек пе?';

  @override
  String get desktopLinkConfirmMessage =>
      'Компьютер кілттеріңізді, контактілеріңізді және чаттарыңызды алады. Бұл телефон бұрынғыдай жұмыс істей береді.';

  @override
  String get desktopLinkConfirmAction => 'Жіберу';

  @override
  String desktopLinkConfirmWhere(String address) {
    return 'Тек осы кодты жаңа ғана өз компьютеріңіздің экранынан сканерлеген болсаңыз. Көшірме осы желідегі $address мекенжайына жіберіледі.';
  }

  @override
  String get desktopLinkSending => 'Аккаунт жіберілуде…';

  @override
  String get desktopLinkSent => 'Компьютер қосылды';

  @override
  String get desktopLinkPhoneFound =>
      'Телефон осы компьютерді тауып, аккаунттың көшірмесін жасап жатыр. Фотолар болса, бұл бірнеше минутқа созылуы мүмкін.';

  @override
  String desktopLinkReceiving(int percent) {
    return 'Аккаунт алынуда: $percent%';
  }

  @override
  String get desktopLinkRestoring => 'Аккаунт осы компьютерде орнатылуда…';

  @override
  String get desktopLinkFinding => 'Компьютер ізделуде…';

  @override
  String get desktopLinkPreparing =>
      'Аккаунттың көшірмесі жасалуда. Фотолар болса, бұл бірнеше минутқа созылуы мүмкін.';

  @override
  String desktopLinkSendingPercent(int percent) {
    return 'Жіберілуде: $percent%';
  }

  @override
  String get desktopLinkComputerRestoring =>
      'Компьютер аккаунтты орнатып жатыр…';

  @override
  String get devicesTitle => 'Құрылғылар';

  @override
  String get devicesRowHint =>
      'Аккаунтыңыз қай жерде ашық және сол жерден шығу';

  @override
  String get devicesThisDevice => 'Осы құрылғы';

  @override
  String get devicesSeenNow => 'Жаңа ғана желіде болды';

  @override
  String devicesSeenMinutes(int n) {
    return '$n мин бұрын желіде болды';
  }

  @override
  String devicesSeenHours(int n) {
    return '$n сағ бұрын желіде болды';
  }

  @override
  String devicesSeenDays(int n) {
    return '$n күн бұрын желіде болды';
  }

  @override
  String get devicesLeaving => 'Шығуда — желіге қосылуы күтілуде';

  @override
  String get devicesSignOut => 'Шығу';

  @override
  String get devicesSignOutAll => 'Басқа барлық құрылғылардан шығу';

  @override
  String devicesSignOutTitle(String name) {
    return '«$name» құрылғысынан шығу керек пе?';
  }

  @override
  String get devicesSignOutMessage =>
      'Ол құрылғы желіге қосылған бойда ондағы CubeChat кілттері, чаттары мен баптаулары өшіріледі. Аккаунт осында және басқа құрылғыларыңызда қалады.';

  @override
  String get devicesSignOutPhoneMessage =>
      'Бұл — телефон: ондағы CubeChat толығымен өшіріледі. Аккаунт осында және басқа құрылғыларыңызда қалады.';

  @override
  String get devicesSignOutAllMessage =>
      'Басқа әр құрылғы желіге қосылған бойда аккаунттан шығады. Аккаунт тек осында қалады.';

  @override
  String get devicesRename => 'Атын өзгерту';

  @override
  String get devicesRenameTitle => 'Осы құрылғының аты';

  @override
  String get devicesSave => 'Сақтау';

  @override
  String get devicesEmpty =>
      'Әзірге басқа құрылғылар жоқ. Құрылғы CubeChat 1.0.0+1147 немесе жаңарақ нұсқасын ашқанда осында пайда болады.';

  @override
  String get devicesCaveat =>
      'Шығу сол құрылғы желіге қосылғанда күшіне енеді. Желіден тыс ұсталған құрылғы кілттерін сақтап қалады; толық қорғаныс үшін аккаунтқа жаңа кілттер керек.';

  @override
  String get desktopLinkImportTitle => 'Аккаунтты телефоннан көшіру';

  @override
  String get desktopLinkImportHint =>
      'Телефонға кодты көрсетіңіз — бұл компьютер оның аккаунтының көшірмесіне айналады';

  @override
  String get desktopLinkImportConfirmTitle =>
      'Осы компьютердегі аккаунтты ауыстыру керек пе?';

  @override
  String get desktopLinkImportConfirmMessage =>
      'Осы компьютердің кілттері, контактілері мен чаттары телефонның аккаунтымен ауыстырылады. Бұл аккаунт әлі керек болса, алдымен сақтық көшірме жасаңыз.';

  @override
  String get desktopLinkImportConfirmAction => 'Жалғастыру';

  @override
  String get desktopLinkUnreachable =>
      'Компьютерге жету мүмкін болмады. Екеуі де бір Wi-Fi желісінде болуы керек, ал компьютерде CubeChat-қа брандмауэр арқылы рұқсат берілуі тиіс.';

  @override
  String get desktopLinkFirewallHint =>
      'Windows телефонды осы компьютерге жібермеуі мүмкін. CubeChat-қа брандмауэрде рұқсат беріңіз — тек жергілікті желіңіз үшін.';

  @override
  String get desktopLinkFirewallAllow => 'Брандмауэрде рұқсат беру';

  @override
  String get desktopLinkFirewallDeclined =>
      'Windows рұқсат бермеді. Онсыз телефон жете алмауы мүмкін.';

  @override
  String get phoneTransferIntro =>
      'Профильді, кілттерді, контактілерді, арналарды, баптауларды және тарихты екі телефон арасында тікелей көшіріңіз.';

  @override
  String get phoneTransferSend => 'Бұл — ескі телефон';

  @override
  String get phoneTransferReceive => 'Бұл — жаңа телефон';

  @override
  String get phoneTransferSameWifi =>
      'Екі телефонды да бір Wi-Fi желісіне қосыңыз. Көшіру аяқталғанша бұл экранды жаппаңыз.';

  @override
  String get phoneTransferPreparing => 'Шифрланған көшіру дайындалуда…';

  @override
  String get phoneTransferReady =>
      'Бұл бір реттік QR кодты жаңа телефонда сканерлеңіз';

  @override
  String get phoneTransferScan => 'Ескі телефонды сканерлеу';

  @override
  String get phoneTransferConfirmTitle =>
      'Осы телефондағы профильді ауыстыру керек пе?';

  @override
  String get phoneTransferConfirmMessage =>
      'Қазір осы телефонда сақталған профиль шифрланған жергілікті көшірудегі деректермен ауыстырылады.';

  @override
  String get phoneTransferConfirmAction => 'Профильді көшіру';

  @override
  String get phoneTransferSuccess => 'Профиль сәтті көшірілді';

  @override
  String get phoneTransferFailed => 'Телефонды көшіруді аяқтау мүмкін болмады';

  @override
  String get profileSummaryMeshOnly => 'Тек mesh';

  @override
  String get profileSummaryMeshInternet => 'Mesh · интернет';

  @override
  String get profileSummaryBackgroundOn => 'фонда жұмыс істейді';

  @override
  String profileSummaryTransfersActive(int count) {
    return 'Орындалуда: $count';
  }

  @override
  String get profileSummaryCardBackup => 'Файлдар, көшірме';

  @override
  String get chatPlay => 'Ойнату';

  @override
  String get chatPause => 'Кідірту';

  @override
  String get profileTheme => 'Түс';

  @override
  String get profileThemeEmerald => 'Зүмірет';

  @override
  String get profileThemeIndigo => 'Индиго';

  @override
  String get profileThemeAmber => 'Янтарь';

  @override
  String get profileThemeRose => 'Раушан';

  @override
  String get profileThemeFuchsia => 'Фуксия';

  @override
  String get profileThemeViolet => 'Күлгін';

  @override
  String get profileThemeOcean => 'Мұхит';

  @override
  String get profileThemeSlate => 'Графит';

  @override
  String get profileScale => 'Интерфейс өлшемі';

  @override
  String get profileScaleSystem => 'Жүйелік';

  @override
  String get profileGlass => 'Шыны';

  @override
  String get profileGlassAuto => 'Автоматты';

  @override
  String get profileGlassFull => 'Толық';

  @override
  String get profileGlassLight => 'Жеңіл';

  @override
  String get profileGlassHint =>
      'Жеңіл режим реңкті қалдырып, панельдер артындағы бұлыңғырлықты алып тастайды. Автоматты режим телефоныңызды бір рет өлшеп, өзі шешеді. Онсыз да үлгеретін телефонға мұның пайдасы аз — бұл үлгермейтін телефонға арналған.';

  @override
  String get mapAlwaysNeeded =>
      'cubechat жабық кезде карта жаңарып тұруы үшін Геолокация «Әрқашан» күйінде болуы керек. Баптауларды ашу үшін түртіңіз.';

  @override
  String get mapShareConsentTitle => 'Орныңызды картада көрсету керек пе?';

  @override
  String get mapShareConsentBody =>
      'Нақты уақыттағы орныңызды тек картаңыздағы контактілер көреді: сіз шақырғандар немесе шақыруын сіз қабылдағандар. Ол сіз жасырынғанша жаңарып тұрады, соның ішінде Cubechat фонда болғанда да. Ол өтпелі шифрланған және бізге ешқашан жетпейді. Кез келген уақытта картада не Профильде жасырына аласыз, ал бұғатталған контактілер сізді ешқашан көрмейді.';

  @override
  String get mapShareConsentAllow => 'Рұқсат беру';

  @override
  String get mapShareConsentDecline => 'Рұқсат бермеу';

  @override
  String get mapVisibleToFriends => 'Картадағы достарыңыз сізді көреді';

  @override
  String get mapHiddenFromFriends => 'Сіз жасырынсыз';

  @override
  String get mapHideMe => 'Жасырыну';

  @override
  String get mapShowMe => 'Мені көрсету';

  @override
  String get profileScaleSmall => 'Кішірек';

  @override
  String get profileScaleNormal => 'Қалыпты';

  @override
  String get profileScaleLarge => 'Үлкенірек';

  @override
  String get profileScaleSample => 'Мәтін мен жолдар осы өлшеммен салынады.';

  @override
  String get savedTitle => 'Сақталғандар';

  @override
  String get savedSubtitle => 'Өзіңізге арналған жазбалар, осы құрылғыда';

  @override
  String get savedEmpty => 'Мұнда жазғаныңыздың бәрі осы телефонда қалады.';

  @override
  String get meshOffTitle => 'Bluetooth mesh өшірулі';

  @override
  String get meshOffHint =>
      'Маңайдағы ешкім сізді таба алмайды, сіз де оларды таба алмайсыз. Хабарламалар интернет ретрансляторы арқылы жүре береді.';

  @override
  String get profileMeshSwitch => 'Bluetooth mesh';

  @override
  String get profileMeshSwitchHint =>
      'Маңайдағы адамдарды табады және хабарламаларды интернетсіз жеткізеді. Өшірсеңіз, батарея үнемделеді.';

  @override
  String get channelAdminOnlyHint => 'Хабарландыру арнасы. Оны бәрі оқи алады.';

  @override
  String get attachLocation => 'Геолокация';

  @override
  String get locationBubbleTitle => 'Геолокация';

  @override
  String get locationOpenInMaps => 'Карталарда ашу';

  @override
  String locationAccuracy(int metres) {
    return '$metres м дәлдікпен';
  }

  @override
  String get locationExpired => 'Бұл геолокация енді өзекті емес';

  @override
  String get locationDenied => 'Геолокацияға рұқсат өшірулі';

  @override
  String get locationUnavailable => 'Орынды анықтау мүмкін болмады';

  @override
  String get locationShareFor => 'Бөлісу ұзақтығы';

  @override
  String get locationShareOnce => 'Бір рет';

  @override
  String get locationShare15m => '15 минут';

  @override
  String get locationShare1h => '1 сағат';

  @override
  String get storageTitle => 'Жад';

  @override
  String get storageHeadline => 'Жадты пайдалану';

  @override
  String storageSubtitle(String size) {
    return 'cubechat осы құрылғыда $size алып тұр';
  }

  @override
  String get storageEmpty => 'Әзірге ештеңе сақталмаған';

  @override
  String get storageScanning => 'Есептелуде…';

  @override
  String get storageCatPhotos => 'Фотолар';

  @override
  String get storageCatVoice => 'Дауыстық хабарламалар';

  @override
  String get storageCatFiles => 'Алынған файлдар';

  @override
  String get storageCatOutbox => 'Жіберілген файлдар';

  @override
  String get storageCatStickers => 'Стикерлер';

  @override
  String get storageCatSaved => 'Сақталған хабарламалар';

  @override
  String get storageCatWallpapers => 'Тұсқағаздар';

  @override
  String get storageCatHistory => 'Сөйлесулер мен кілттер';

  @override
  String get storageCatCache => 'Кэш';

  @override
  String storageClear(String size) {
    return '$size тазалау';
  }

  @override
  String get storageClearNothing => 'Ештеңе таңдалмаған';

  @override
  String storageFreed(String size) {
    return 'Босатылды: $size';
  }

  @override
  String get storageNoCloud =>
      'Мұның артында бұлт жоқ. Тазалағаныңыз осы телефоннан жойылады, ал жалғыз басқа көшірмесі ол келген телефонда.';

  @override
  String get storageWhyHistoryLocked =>
      'Сөйлесулер мұнда тазаланбайды — «Шұғыл тазалауды» пайдаланыңыз.';

  @override
  String get storageRecoveryFree => 'Тазалау қауіпсіз';

  @override
  String get storageRecoveryGone => 'Басқа еш жерде көшірмесі жоқ';

  @override
  String get storageRecoveryAskSender => 'Жіберушіден қайта сұрауға болады';

  @override
  String get storageRecoveryCostsThem =>
      'Олар сізден қайта жіберуді сұрай алмайды';

  @override
  String storageConfirmTitle(String size) {
    return '$size тазалау керек пе?';
  }

  @override
  String get storageConfirmBody =>
      'Файлдар осы телефоннан жойылады. Ештеңе еш жерге жүктелмейді, сондықтан оларды қалпына келтіретін жер жоқ.';

  @override
  String storageFilesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count файл',
      one: '$count файл',
      zero: 'бос',
    );
    return '$_temp0';
  }

  @override
  String get customizeBarTitle => 'Навигация панелі';

  @override
  String get customizeBarHint =>
      'Ретін өзгерту үшін сүйреңіз. Чаттарды алып тастауға болмайды.';

  @override
  String get customizeBarShown => 'Көрсетілген';

  @override
  String get customizeBarHidden => 'Жасырылған';

  @override
  String get customizeBarHiddenEmpty => 'Ештеңе жасырылмаған';

  @override
  String get customizeBarMinimum => 'Кемінде екі қойынды қалдырыңыз';

  @override
  String get customizeReset => 'Әдепкіге қайтару';

  @override
  String get chatsArchiveTitle => 'Мұрағат';

  @override
  String get chatsArchiveEmpty => 'Мұрағат бос';

  @override
  String get chatsArchiveHint =>
      'Мұрағаттағы чаттар жұмыс істей береді — олар тек тізімде көрінбейді.';

  @override
  String get chatsArchivedToast => 'Мұрағатталды';

  @override
  String get chatsUnarchivedToast => 'Тізімге қайтарылды';

  @override
  String chatsArchiveCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count чат',
      one: '$count чат',
    );
    return '$_temp0';
  }

  @override
  String get chatsSwipeNotHere => 'Бұл чат үшін қолжетімсіз';

  @override
  String get customizeSwipeTitle => 'Чатты оңға сырғыту';

  @override
  String get customizeSwipeHint =>
      'Солға сырғыту бұрынғыдай қойындыларды ауыстырады.';

  @override
  String get customizeSwipeArchive => 'Мұрағаттау';

  @override
  String get customizeSwipeMute => 'Дыбысын өшіру';

  @override
  String get customizeSwipePin => 'Бекіту';

  @override
  String get customizeSwipeRead => 'Оқылды деу';

  @override
  String get customizeSwipeDelete => 'Жою';

  @override
  String get customizeSwipeNone => 'Ештеңе';

  @override
  String get customizeHighRefresh => 'Толық жаңарту жиілігі';

  @override
  String get customizeHighRefreshHint =>
      'Тегісірек, бірақ телефон екі есе көп кадр салады. Қызып кетсе, өшіріңіз — қолданбаның көрінісі өзгермейді, тек қаншалықты жиі қайта салынатыны өзгереді.';

  @override
  String get customizeQuickReaction => 'Екі рет түрту реакциясы';

  @override
  String get customizeQuickReactionHint =>
      'Хабарламаны екі рет түрткенде қалатын реакция. Басқасын қолдансаңыз, ол осында ауысады.';

  @override
  String get customizeCircleAudioTitle =>
      'Бейнехабарлама кезінде музыканы кідірту';

  @override
  String get customizeCircleAudioOn =>
      'Жазу немесе көру басқа ойнап тұрғанның бәрін тоқтатады. Ол кейін өздігінен қайта басталмайды.';

  @override
  String get customizeCircleAudioOff =>
      'Музыкаңыз астында ойнай береді, бейнехабарлама кезінде ақырынырақ.';

  @override
  String get customizeMediaQualityTitle => 'Жіберу кезіндегі фото сапасы';

  @override
  String get customizeMediaQualityEconomy => 'Үнемді';

  @override
  String get customizeMediaQualityStandard => 'Қалыпты';

  @override
  String get customizeMediaQualityHigh => 'Жоғары';

  @override
  String get customizeMediaQualityEconomyHint =>
      'Бір фотоға 96 КБ дейін, 800 px. Сигнал әлсіз немесе Bluetooth mesh толы болғанда: күту екі есе аз, сурет жұмсағырақ.';

  @override
  String get customizeMediaQualityStandardHint =>
      'Бір фотоға 192 КБ дейін, 1280 px. Тек Bluetooth арқылы да өтетіндей өлшем. Бейнелер мен «Түпнұсқа» әрқашан сол күйінде жіберіледі.';

  @override
  String get customizeMediaQualityHighHint =>
      'Бір фотоға 768 КБ дейін, 2048 px. Үлкейтуге жеткілікті анық; жіберу төрт есе ұзақ, сондықтан Wi-Fi арқылы жақсы.';

  @override
  String get previewReacted => 'хабарламаңызға';

  @override
  String get previewLocation => 'Геолокация';

  @override
  String get previewMapInvite => 'Картаға шақыру';

  @override
  String get previewContact => 'Контакт';

  @override
  String get previewUnsupported => 'Қолдау көрсетілмейтін хабарлама';

  @override
  String get previewCallOutgoing => 'Шығыс қоңырау';

  @override
  String get previewCallIncoming => 'Кіріс қоңырау';

  @override
  String get previewCallMissed => 'Өткізіп алынған қоңырау';

  @override
  String chatPreparingPhotos(int count) {
    return '$count фото дайындалуда…';
  }

  @override
  String get circleSwitchCamera => 'Камераны ауыстыру';

  @override
  String get circleLight => 'Жазу жарығы';

  @override
  String get circleCameraSwitchFailed =>
      'Камераны ауыстыру мүмкін болмады. Жазбаңыз әлі ашық.';

  @override
  String get diagnosticsTitle => 'Диагностика';

  @override
  String get diagnosticsIntro =>
      'Қолданба соңғы кезде не істеді. Бірдеңе жұмыс істемесе, мұны әзірлеушіге жіберіңіз.';

  @override
  String get diagnosticsShare => 'Журналды әзірлеушіге жіберу';

  @override
  String get diagnosticsEvents => 'Соңғы оқиғалар';

  @override
  String get diagnosticsTechnical => 'Техникалық жазбалар';

  @override
  String get diagnosticsEmpty => 'Әзірге көрсететін ештеңе жоқ.';

  @override
  String get diagnosticsDeveloperOn => 'Әзірлеуші режимі қосулы';

  @override
  String get diagnosticsDeveloperOff => 'Әзірлеуші режимі өшірулі';

  @override
  String get logAppStarted => 'Қолданба іске қосылды';

  @override
  String get logInternetOn => 'Интернет байланысы қосылды';

  @override
  String logServerConnected(String host) {
    return 'Қосылды: $host';
  }

  @override
  String logServerLost(String host) {
    return 'Байланыс үзілді: $host';
  }

  @override
  String get chatSaveAction => 'Сақтау';

  @override
  String get savedTagAsk => 'Сақталды. Тег қосу керек пе?';

  @override
  String get savedTagAdd => 'Тег қосу';

  @override
  String get chatSharedWallpaperFailed =>
      'Тұсқағаз мұнда орнатылды. Әңгімелесуші маңайға келгенде оған жетеді.';

  @override
  String get chatTranscribeAction => 'Мәтінге айналдыру';

  @override
  String get chatTranscribeFailed =>
      'Бұл телефон оны мәтінге айналдыра алмайды.';

  @override
  String get chatTranscribing => 'Танылуда…';

  @override
  String get chatTranscriptHide => 'Мәтінді жасыру';

  @override
  String get chatCancelSend => 'Жіберуді болдырмау';

  @override
  String get chatDownloadAction => 'Жүктеп алу';

  @override
  String get chatDownloaded => 'Телефонға сақталды';

  @override
  String get chatDownloadFailed => 'Сақтау мүмкін болмады';

  @override
  String get selfUpdateTitle => 'Жаңартуды файлдан орнату';

  @override
  String get selfUpdateHint =>
      'Жаңа cubechat APK файлын чаттан ашпай, осы жерден таңдаңыз: осылай орнатылса, құлып экранындағы қоңыраулар қосулы қалады.';

  @override
  String get selfUpdateConfirm => 'Орнатуды жүйелік терезеде растаңыз.';

  @override
  String get selfUpdateAllow =>
      'cubechat-қа қолданба орнатуға рұқсат беріп, қайта түртіңіз.';

  @override
  String get selfUpdateNotOurs => 'Бұл файл cubechat жаңартуы емес.';

  @override
  String get selfUpdateFailed => 'Жаңарту орнатылмады.';

  @override
  String get chatTranscribeDownloading =>
      'Телефон бұл үшін тілді жүктеп жатыр. Бір минуттан кейін қайталап көріңіз.';

  @override
  String get chatTranscribeNoLanguage =>
      'Бұл телефонда сол тілдің сөйлеу моделі жоқ. Тану тілін Профиль → Чаттар және медиа бөлімінде таңдаңыз.';

  @override
  String get chatTranscribeNotAllowed =>
      'CubeChat үшін сөйлеуді тану өшірулі. Оны iPhone Баптаулары → CubeChat бөлімінде қосыңыз.';

  @override
  String get customizeTranscribeLanguageTitle =>
      'Дауысты мәтінге айналдыру тілі';

  @override
  String get customizeTranscribeLanguageAuto => 'Авто';

  @override
  String get customizeTranscribeLanguageHint =>
      'Дауыстық хабарламалар айтылатын тіл, ол қолданба тілімен бірдей болмауы мүмкін. «Авто» телефонның тілдерін қолданып көреді. Жоқ тілді телефон өзі жүктейді; дауыс телефоннан ешқайда шықпайды.';

  @override
  String get chatTranslateAction => 'Аудару';

  @override
  String get chatTranslateFailed => 'Мұны осы телефонда аудару мүмкін емес.';

  @override
  String get customizeDeferMediaTitle => 'Медианы жүктеу үшін Wi-Fi күту';

  @override
  String get customizeDeferMediaHint =>
      'Мобильді интернетте мәтін мен қоңыраулар әдеттегідей жұмыс істейді, ал фото, дауыстық хабарламалар, бейнехабарламалар мен файлдар серверде Wi-Fi-ды күтеді — екі аптаға дейін. Чаттардың үстіндегі жол нені күтіп тұрғанын көрсетеді және оны қазір жүктейді.';

  @override
  String heldMediaCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count медиа Wi-Fi күтуде',
      one: '$count медиа Wi-Fi күтуде',
    );
    return '$_temp0';
  }

  @override
  String get heldMediaDownload => 'Жүктеп алу';

  @override
  String get nearbyAirDropSubtitle => 'Маңайдағы адамдармен файл алмасу';

  @override
  String get nearbyFilesSubtitle => 'Жіберілген және алынған файлдар';

  @override
  String get airdropTab => 'AirDrop';

  @override
  String get nearbyTabFiles => 'Файлдар';

  @override
  String get airdropReceiveHint => 'Сізге кім файл жібере алады';

  @override
  String get airdropReceiveContacts => 'Контактілер';

  @override
  String get airdropReceiveEveryone => 'Барлығы 10 мин';

  @override
  String airdropEveryoneLeft(String time) {
    return 'Барлығы · $time';
  }

  @override
  String get airdropSendFiles => 'Файл жіберу';

  @override
  String get airdropChooseFiles => 'Файлдарды таңдау';

  @override
  String airdropStagedTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count файл дайын',
      one: '1 файл дайын',
    );
    return '$_temp0';
  }

  @override
  String get airdropStagedHint =>
      'Екі телефонда да Bluetooth қосулы және AirDrop ашық болса, оларды бір-біріне жақындатыңыз немесе адамды таңдаңыз';

  @override
  String get airdropStagedPickPerson => 'Адамды таңдау';

  @override
  String airdropRequestBody(String what, String size) {
    return '$what жібергісі келеді · $size';
  }

  @override
  String airdropWhatPhotos(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count фото',
      one: '$count фото',
    );
    return '$_temp0';
  }

  @override
  String airdropWhatVideos(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count бейне',
      one: '$count бейне',
    );
    return '$_temp0';
  }

  @override
  String airdropWhatFiles(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count файл',
      one: '$count файл',
    );
    return '$_temp0';
  }

  @override
  String get airdropAccept => 'Қабылдау';

  @override
  String get airdropDecline => 'Қабылдамау';

  @override
  String get airdropWaiting => 'Жауап күтілуде…';

  @override
  String get airdropAccepted => 'Қабылданды';

  @override
  String get airdropUnheard =>
      'Алынбады — CubeChat-тың ескі нұсқасы болуы мүмкін';

  @override
  String get airdropSending => 'Жіберілуде';

  @override
  String get airdropReceiving => 'Алынуда';

  @override
  String get airdropInterrupted => 'Үзілді';

  @override
  String get airdropRetry => 'Қайталау';

  @override
  String get airdropOutcomeSent => 'Жіберілді';

  @override
  String get airdropOutcomeReceived => 'Алынды';

  @override
  String get airdropOutcomeDeclined => 'Қабылданбады';

  @override
  String get airdropOutcomeCancelled => 'Болдырылмады';

  @override
  String get airdropOutcomePartial => 'Ішінара';

  @override
  String get airdropReasonNoSpace => 'орын жеткіліксіз';

  @override
  String get airdropReasonContactsOnly => 'тек контактілерден';

  @override
  String get airdropReasonBusy => 'бос емес';

  @override
  String get airdropReasonTimeout => 'жауап жоқ';

  @override
  String get airdropFileDeleted => 'жойылды';

  @override
  String get airdropHistory => 'Тарих';

  @override
  String get airdropClearHistory => 'Тарихты тазалау';

  @override
  String get airdropEmpty =>
      'Маңайда жіберген не алған файлдарыңыз осында болады';

  @override
  String get airdropPickPerson => 'Кімге жіберу';

  @override
  String get airdropNobody => 'Маңайда әзірге cubechat бар ешкім жоқ';

  @override
  String get airdropNoDirect => 'Бұл адаммен Bluetooth байланысы жоқ';

  @override
  String get airdropNearbyUnknown => 'Маңайда';

  @override
  String get airdropConnecting => 'Қосылуда…';

  @override
  String get airdropConnectFailed => 'Қосылу мүмкін болмады';

  @override
  String get airdropSlowWarning => 'Bluetooth арқылы бұл ұзаққа созылуы мүмкін';

  @override
  String airdropTooLarge(String name, int limit) {
    return '$name көлемі $limit МБ-тан асады';
  }

  @override
  String airdropFromLabel(String name) {
    return 'AirDrop · $name';
  }

  @override
  String get airdropWrite => 'Жазу';

  @override
  String get airdropAction => 'AirDrop';

  @override
  String get airdropLaneTitle => 'Арна';

  @override
  String get airdropLaneAuto => 'Авто';

  @override
  String get airdropLaneBluetooth => 'Bluetooth';

  @override
  String get airdropLaneWifi => 'Wi‑Fi';

  @override
  String get airdropBluetoothNeededHint =>
      'Бір-біріңізді табу және тасымалдауды растау үшін екі телефонда да Bluetooth-ты қосыңыз.';

  @override
  String get airdropLaneHint =>
      'Bluetooth телефондарды тауып, қосады. Екі телефон бір желіде немесе хотспотта болса, Wi‑Fi файлдарды тасымалдайды.';

  @override
  String get airdropWifiUnreachable => 'Бір желіде емес';

  @override
  String get airdropWifiOldVersion =>
      'Оның қолданбасы Wi‑Fi арқылы әлі қабылдай алмайды';

  @override
  String get airdropBumpAdd => 'Қосу';

  @override
  String get airdropBumpAlreadyContact => 'Контактілеріңізде бар';

  @override
  String airdropBumpSending(String name) {
    return 'Жіберілуде: $name';
  }

  @override
  String airdropBumpReceiving(String name) {
    return '$name сізге файл жіберіп жатыр';
  }

  @override
  String get termsTitle => 'cubechat ережелері';

  @override
  String get termsBody =>
      'cubechat қорлайтын мазмұнға және теріс пиғылды пайдаланушыларға мүлдем төзбейді. Жалғастыру арқылы сіз қудалау, қорқыту, кәмелетке толмағандар қатысқан жыныстық мазмұн, спам немесе заңсыз ештеңе жібермеуге келісесіз. Кез келген адам хабарлама немесе адам туралы шағымдана алады; шағымдар әзірлеушіге жетіп, 24 сағат ішінде қаралады, ал бұзушылар бұғатталады.';

  @override
  String get termsReadFull => 'Толық шарттарды оқу';

  @override
  String get termsAccept => 'Келісемін';

  @override
  String get messageHide => 'Жасыру';

  @override
  String get messageHidden => 'Сіз үшін жасырылды';

  @override
  String get reportAction => 'Шағымдану';

  @override
  String get reportTitle => 'Не болды?';

  @override
  String get reportReasonSpam => 'Спам';

  @override
  String get reportReasonAbuse => 'Қорлау не қудалау';

  @override
  String get reportReasonViolence => 'Зорлық-зомбылық';

  @override
  String get reportReasonSexual => 'Жыныстық мазмұн';

  @override
  String get reportReasonOther => 'Басқа';

  @override
  String get reportNoteHint => 'Сипаттаңыз (міндетті емес)';

  @override
  String get reportSend => 'Шағым жіберу';

  @override
  String get reportDisclosure =>
      'Таңдалған хабарлама мәтіні мен шағымыңыз cubechat модерациясына және оның жеке Telegram ботына жіберіледі.';

  @override
  String get reportSent =>
      'Шағым жіберілді. Шағымдарды 24 сағат ішінде қараймыз.';

  @override
  String get reportBlockedToo => 'Ол сіз үшін бұғатталды.';

  @override
  String get reportQueued => 'Шағым сақталды. Желі пайда болғанда жіберіледі.';

  @override
  String get reportFailed => 'Шағымды жіберу мүмкін болмады.';

  @override
  String get filteredMessage => 'Сүзгі жасырды';

  @override
  String get filteredShow => 'Көрсету';

  @override
  String get filterToggle => 'Қорлайтын мазмұн сүзгісі';

  @override
  String get filterToggleHint =>
      'Бейтаныс адамдардан және арналардағы дөрекі сөздерді жасырады';

  @override
  String get aboutTitle => 'Қолданба туралы';

  @override
  String get aboutContact => 'Әзірлеушіге хат жазу';

  @override
  String get aboutReport => 'Бұзушылық туралы хабарлау';

  @override
  String get aboutTerms => 'Пайдалану шарттары';

  @override
  String get aboutPrivacy => 'Құпиялылық саясаты';

  @override
  String get requestsTitle => 'Сұраулар';

  @override
  String get requestsEmpty => 'Сұраулар жоқ';

  @override
  String requestBanner(String name) {
    return '$name контактілеріңізде жоқ. Сұрауды қабылдамайынша ол сіздің оқығаныңызды көрмейді және сізге қоңырау шала алмайды.';
  }

  @override
  String get requestAccept => 'Қабылдау';

  @override
  String get requestDelete => 'Жою';

  @override
  String get requestBlock => 'Бұғаттау';

  @override
  String get cubeIdTitle => 'Cube ID';

  @override
  String get cubeIdExplainer =>
      'Сіздің @атыңыз контакт картаңызға сілтейді. Сервер тек атты және ашық картаңызды сақтайды — хабарламаларыңызды ешқашан.';

  @override
  String get cubeIdFieldHint => 'a–z, 0–9 және _, 3–20 таңба';

  @override
  String get cubeIdAvailable => 'Бос';

  @override
  String get cubeIdTaken => 'Бос емес';

  @override
  String get cubeIdReserved => 'Рұқсат етілмейді';

  @override
  String get cubeIdInvalid => 'Тек a–z, 0–9 және _, 3–20 таңба';

  @override
  String get cubeIdClaim => 'Бұл атты алу';

  @override
  String get cubeIdWorking => 'Ат бекітілуде…';

  @override
  String get cubeIdChange => 'Өзгерту';

  @override
  String get cubeIdEmail => 'Қалпына келтіру поштасы';

  @override
  String get cubeIdEmailHint =>
      'Бұл телефон жоғалса, ат осы мекенжайға келетін хат арқылы қайтарылады';

  @override
  String get cubeIdEmailField => 'Email';

  @override
  String cubeIdEmailSent(String email) {
    return '$email мекенжайына хат жіберілді. Ондағы сілтемені ашыңыз.';
  }

  @override
  String get cubeIdEmailRemove => 'Поштаны алып тастау';

  @override
  String get cubeIdEmailUnavailable =>
      'Пошта қазір қолжетімсіз. Кейінірек көріңіз.';

  @override
  String get cubeIdEmailInvalid => 'Бұл email мекенжайына ұқсамайды';

  @override
  String get cubeIdSave => 'Сақтау';

  @override
  String get cubeIdRecover => 'Атты пошта арқылы қалпына келтіру';

  @override
  String get cubeIdRecoverSent =>
      'Мекенжай сәйкес келсе, хат келеді. Ондағы сілтемені ашқаннан кейін 48 сағаттан соң ат осы телефонға ауысады.';

  @override
  String cubeIdRecoveryWarning(String name, String when) {
    return 'Біреу @$name атын басқа телефонда пошта арқылы қалпына келтіріп жатыр. Болдырмасаңыз, ол $when ауысады.';
  }

  @override
  String get cubeIdRecoveryCancel => 'Қалпына келтіруді болдырмау';

  @override
  String get cubeIdRecoveryCancelled => 'Қалпына келтіру болдырылмады';

  @override
  String get cubeIdRelease => 'Босату';

  @override
  String cubeIdReleaseConfirm(String name) {
    return '@$name атын босату керек пе? Оны кез келген адам ала алады.';
  }

  @override
  String get cubeIdShare => 'Бөлісу';

  @override
  String cubeIdShareText(String name) {
    return 'Мені cubechat-тан табыңыз: @$name\nhttps://cubechat.tech/u.html#$name';
  }

  @override
  String get cubeIdFailed => 'Атты сақтау мүмкін болмады. Қайталап көріңіз.';

  @override
  String get cubeIdOffline => 'Интернет жоқ';

  @override
  String get lookupNotFound => 'Мұндай @аты бар адам жоқ';

  @override
  String searchFindCubeName(String name) {
    return '@$name іздеу';
  }

  @override
  String get searchFindCubeNameHint => 'Cube ID-ден іздеп, қосу';

  @override
  String get addContactHintName => 'Картаны қойыңыз немесе @атты енгізіңіз';

  @override
  String get strangerReachTitle => 'Маған интернеттен кім жаза алады';

  @override
  String get strangerReachAll => 'Барлығы';

  @override
  String get strangerReachRequest => 'Сұрау арқылы';

  @override
  String get strangerReachNone => 'Ешкім';

  @override
  String get strangerReachHint =>
      'Сіз жазбаған және сізге интернет арқылы жазатын адамдарға қатысты. Bluetooth арқылы маңайдағы адамдарға әсер етпейді.';

  @override
  String get sectionPrivacy => 'Құпиялылық және қауіпсіздік';

  @override
  String get sectionNotifications => 'Хабарландырулар мен қоңыраулар';

  @override
  String get sectionConnection => 'Байланыс';

  @override
  String get sectionChats => 'Чаттар және медиа';

  @override
  String get sectionAppearance => 'Безендіру';

  @override
  String get sectionData => 'Деректер және жад';

  @override
  String get sectionAbout => 'Қолданба туралы';

  @override
  String get subWhoSeesMe => 'Мені кім көреді';

  @override
  String get subProtection => 'Қорғаныс';

  @override
  String get subNotifications => 'Хабарландырулар';

  @override
  String get subCalls => 'Қоңыраулар';

  @override
  String get profileDiscoverableMeshOff =>
      'Bluetooth mesh өшірулі — оны «Байланыс» бөлімінде қосыңыз.';

  @override
  String get chatRouteBluetoothDirect => 'Bluetooth, тікелей';

  @override
  String chatRouteMeshHops(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Mesh · $n секіріс',
      one: 'Mesh · $n секіріс',
    );
    return '$_temp0';
  }

  @override
  String chatRouteDeliveredVia(String route) {
    return 'Жеткізілді: $route';
  }

  @override
  String chatRouteReceivedVia(String route) {
    return 'Алынды: $route';
  }

  @override
  String get chatUnreadDivider => 'Жаңа хабарламалар';

  @override
  String get radioTitle => 'Рация';

  @override
  String get radioNearbySubtitle =>
      'Түймені басып тұрып, топпен не контактімен сөйлесіңіз';

  @override
  String get radioGroupsLabel => 'Топтар';

  @override
  String get radioDirectLabel => 'Жеке';

  @override
  String get radioAddGroup => 'Рация қосу';

  @override
  String get radioNoGroups =>
      'Әзірге рациялар жоқ. Біреуін қосыңыз — дәл сол атау мен құпиясөзді енгізгендердің бәрі бір-бірін естиді.';

  @override
  String get radioLeave => 'Бұл рациядан шығу';

  @override
  String get radioPickChannel => 'Топты не контактіні таңдаңыз';

  @override
  String get radioPushToTalk => 'Сөйлеу үшін басып тұрыңыз';

  @override
  String get radioTalking => 'Сөйлеп жатырсыз…';

  @override
  String get radioChannelBusy => 'Арна бос емес';

  @override
  String radioSpeaker(String name) {
    return '$name сөйлеп жатыр';
  }

  @override
  String get radioSilentTitle => 'Үнсіз режимде сөйлеу';

  @override
  String get radioSilentHint =>
      'Телефон үнсіз режимде болса да дауыс естіледі.';

  @override
  String get radioJoinNameLabel => 'Атауы';

  @override
  String get radioJoinPasswordLabel => 'Құпиясөз (міндетті емес)';

  @override
  String get radioJoinHint =>
      'Дәл сол атау мен құпиясөзді енгізгендердің бәрі бір рацияда болады. Олардың тізімін ешбір сервер сақтамайды.';

  @override
  String get radioJoinNameRequired => 'Атауын енгізіңіз';

  @override
  String get radioJoinSubmit => 'Қосу';

  @override
  String get radioBlockedTooLong => 'Бір минут сөйлегеннен кейін үзілді';

  @override
  String get radioBlockedCall => 'Қоңырау жүріп жатыр';

  @override
  String get radioBlockedMicrophone => 'Микрофонға рұқсат жоқ';

  @override
  String get radioBlockedUnavailable => 'Бұл құрылғыда рация қолжетімсіз';

  @override
  String get radioBlockedNoChannel => 'Алдымен топты не контактіні таңдаңыз';

  @override
  String get radioTurnOff => 'Рацияны өшіру';

  @override
  String get radioPersonalCallsTitle => 'Жеке шақыруларды қабылдау';

  @override
  String get radioPersonalCallsHint =>
      'Рация өшірулі болғанда, сізбен сөйлескен контактіге ол өзі бапталады.';

  @override
  String get radioBackgroundHint =>
      'Экран өшірулі болса, рация тек фондық режим қосулы кезде естіледі.';

  @override
  String get areaNearby => 'Маңайдағы чат';

  @override
  String get areaLevelDistrict => 'Аудан';

  @override
  String get areaLevelCity => 'Қала';

  @override
  String get areaLevelRegion => 'Өңір';

  @override
  String areaPresentCount(int count) {
    return 'Мұнда ≈$count';
  }

  @override
  String get areaPresentMany => 'Мұнда 50+';

  @override
  String get areaBlockViaBluetooth => 'Кварталыңыз — Bluetooth арқылы';

  @override
  String get areaOpenNearbyTab => '«Маңайда» ашу';

  @override
  String get areaLocating => 'Ауданыңыз ізделуде…';

  @override
  String get areaNoPlace =>
      'Орын әлі белгісіз. Аудан чатына осы экран ашық тұрғанда шамамен орныңыз қажет.';

  @override
  String get areaLocationDenied =>
      'Cubechat үшін геолокация өшірулі. Ауданыңызды көру үшін Баптауларда шамамен орынға рұқсат беріңіз.';

  @override
  String get areaOffline => 'Аудан чатымен байланыс жоқ';

  @override
  String get areaEmpty => 'Соңғы 24 сағатта мұнда ешкім жазбаған.';

  @override
  String get areaConsentTitle => 'Аудан чаты көпшілікке ашық';

  @override
  String get areaConsentBody =>
      'Мұндағы хабарламалар көпшілікке ашық. Ауданыңызды не қалаңызды ашқан кез келген адам оларды оқиды, олар Cubechat серверінде 24 сағат сақталады. Сіз әр бірнеше сағат сайын өзгеретін уақытша атпен жазасыз; @атыңызды не контактілеріңізді ешкім көрмейді. Ауданыңызды білу үшін Cubechat тек осы экран ашық тұрғанда шамамен орныңызды сұрайды.';

  @override
  String get areaConsentAllow => 'Жалғастыру';

  @override
  String get areaConsentDecline => 'Қазір емес';

  @override
  String areaDefaultName(String tag) {
    return 'Куб-$tag';
  }

  @override
  String areaYouAre(String name, int hours) {
    return 'Сіз — $name · жаңа ат $hours сағаттан кейін';
  }

  @override
  String get areaNewName => 'Жаңа ат';

  @override
  String get areaSetName => 'Ат таңдау';

  @override
  String get areaNameHint =>
      'Тек осы аттың бірнеше сағатына. Автоматты ат үшін бос қалдырыңыз.';

  @override
  String get areaNameSameWarning =>
      'Бірдей ат сізді әр аудандарда байланыстырып қояды';

  @override
  String get areaShowPresence => 'Мұнда екенімді көрсету';

  @override
  String get areaPresenceOffHint =>
      'Маңайда қанша адам барын көру үшін «Мұнда екенімді көрсету» параметрін қосыңыз';

  @override
  String get areaReadOnly => 'Тек өзіңіз тұрған жерде жаза аласыз';

  @override
  String get areaComposerHint => 'Мұндағылардың бәріне хабарлама';

  @override
  String get areaSend => 'Жіберу';

  @override
  String get areaWaitALittle => 'Сәл күтіңіз';

  @override
  String areaFlood(int count) {
    return 'Флуд ($count) · Көрсету';
  }

  @override
  String get areaReply => 'Жауап беру';

  @override
  String get areaHide => 'Жасыру';

  @override
  String get areaBlock => 'Аты өзгергенше бұғаттау';

  @override
  String get areaBlocked => 'Аты өзгергенше бұғатталды';

  @override
  String get areaReport => 'Шағымдану';

  @override
  String get areaOpenLink => 'Сілтемені ашу';

  @override
  String areaOpenLinkConfirm(String url) {
    return '$url ашу керек пе?';
  }

  @override
  String get areaOpen => 'Ашу';

  @override
  String get areaReadHere => 'Осында оқу';

  @override
  String get areaReadHereHint =>
      'Тек оқу. Тек өзіңіз тұрған жерде жаза аласыз; ретранслятор қай жерді оқып отырғаныңызды біледі.';

  @override
  String get areaNotes => 'Жазбалар';

  @override
  String areaNotesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count жазба',
      one: '$count жазба',
      zero: 'Жазба жоқ',
    );
    return '$_temp0';
  }

  @override
  String get areaLeaveNote => 'Жазба қалдыру';

  @override
  String get areaNoteHint => 'Қалаңызға арналған қысқа жазба';

  @override
  String get areaNoteLifetime => 'Сақталу мерзімі';

  @override
  String get areaNote1h => '1 сағ';

  @override
  String get areaNote24h => '24 сағ';

  @override
  String get areaNote7d => '7 күн';

  @override
  String get areaPinToDistrict => 'Ауданға бекіту';

  @override
  String get areaPinHint =>
      'Қалаңыздың ішінде картаны түртіңіз — белгі сол ауданға бекітіледі.';

  @override
  String get areaPinOutside => 'Тек қалаңыздың ішінде';

  @override
  String get areaNoteDelete => 'Жазбамды жою';

  @override
  String get areaNoNotes => 'Мұнда әлі жазбалар жоқ';

  @override
  String get areaNotesLimit => 'Тәулігіне үш жазба';

  @override
  String get areaNoteLeft => 'Жазба қалдырылды';

  @override
  String get areaNoteSend => 'Қалдыру';

  @override
  String get areaOwnNote => 'Сіздің жазбаңыз';

  @override
  String get areaNotePinned => 'Ауданға бекітілген';

  @override
  String get areaHidden => 'Жасырылды';

  @override
  String get areaPublicBadge => 'Ашық · 24 сағ сақталады';

  @override
  String get areaSettingTitle => 'Аудан чаты';

  @override
  String get areaSettingOnHint =>
      'Картадағы «Маңайдағы чат» түймесі: ауданыңыз бен қалаңыздың уақытша атпен жазылатын ашық чаттары.';

  @override
  String get areaSettingOffHint =>
      'Өшірулі: картада түйме жоқ, ал аудан чаты орныңызды ешқашан сұрамайды және қосылмайды.';

  @override
  String get wallpaperPhotoLocalOnly =>
      'Фото тұсқағаздар әзірге тек осы құрылғыда';

  @override
  String get wallpaperSavedNoRoute =>
      'Осында сақталды. Қазір әңгімелесушіге бағыт жоқ';

  @override
  String get wallpaperScopeTitle => 'Бұл тұсқағазды кім көреді?';

  @override
  String get wallpaperScopeChannel => 'Бүкіл арна';

  @override
  String get wallpaperScopeBoth => 'Мен және әңгімелесуші';

  @override
  String get wallpaperScopeLocal => 'Тек менде';

  @override
  String get wallpaperScopeSharedHint =>
      'Шифрланған қызметтік пакет ретінде жіберіледі';

  @override
  String get wallpaperScopePhotoHint =>
      'Фотолар әзірге тек осы телефонда қалады';

  @override
  String get foldersCreate => 'Қалта жасау';

  @override
  String get foldersYours => 'Сіздің қалталарыңыз';

  @override
  String get foldersSmartFilters => 'Ақылды сүзгілер';

  @override
  String get foldersName => 'Қалта атауы';

  @override
  String get foldersSave => 'Сақтау';

  @override
  String get foldersDeleteTitle => 'Қалтаны жою керек пе?';

  @override
  String get foldersDelete => 'Жою';

  @override
  String get foldersCreateAction => 'Жасау';

  @override
  String get chatsArchiveHiddenToast =>
      'Мұрағат жасырылды. Оны «Безендіру» бөлімінде қайтаруға болады.';

  @override
  String get chatsBulkPin => 'Бекіту';

  @override
  String get chatsBulkMute => 'Дыбыссыз';

  @override
  String get chatsUnarchive => 'Мұрағаттан шығару';

  @override
  String get chatsAddToFolder => 'Қалтаға қосу';

  @override
  String get chatsMarkUnread => 'Оқылмаған деп белгілеу';

  @override
  String get chatsClearHistory => 'Чат тарихын тазалау';

  @override
  String get foldersNew => 'Жаңа қалта';

  @override
  String get foldersNameHint => 'Достар';

  @override
  String get chatsNoIncoming => 'Кіріс хабарлар жоқ';

  @override
  String get chatsMarkedUnread => 'Оқылмаған деп белгіленді';

  @override
  String get chatsClearHistoryTitle => 'Чат тарихын тазалау керек пе?';

  @override
  String get chatsClearHistoryBody =>
      'Хабарлар тек осы құрылғыда жойылады. Чат, контакт және таңдаулылар сақталады.';

  @override
  String get chatsClearHistoryAction => 'Тазалау';

  @override
  String get chatsHistoryCleared => 'Тарих тазаланды';

  @override
  String get savedTagMenuTag => 'Тег';

  @override
  String get savedTagRemove => 'Тегті алып тастау';

  @override
  String get customizeArchiveRowTitle => 'Мұрағат жолы';

  @override
  String get customizeArchiveRowHint =>
      'Чаттар тізімінің үстінде көрсету. Мұрағаттағы чаттар бәрібір хабар алады.';

  @override
  String get mapLayerStandard => 'Қалыпты';

  @override
  String get mapLayerStandardHint =>
      'Ашық түсті көше картасы — ең тұрақты нұсқа';

  @override
  String get callYourMicOff => 'Микрофоныңыз өшірулі';

  @override
  String callTheirCameraOff(String name) {
    return '$name: камера өшірулі';
  }
}
