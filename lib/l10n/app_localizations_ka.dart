// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Georgian (`ka`).
class AppLocalizationsKa extends AppLocalizations {
  AppLocalizationsKa([String locale = 'ka']) : super(locale);

  @override
  String get callVoice => 'ხმოვანი ზარი';

  @override
  String get callVideo => 'ვიდეოზარი';

  @override
  String get callIncomingVideo => 'შემომავალი ვიდეოზარი';

  @override
  String get callCamera => 'კამერა';

  @override
  String get callFlipCamera => 'შებრუნება';

  @override
  String get contactProfileVideo => 'ვიდეო';

  @override
  String get callPreparing => 'მიკროფონის მომზადება…';

  @override
  String get callDialing => 'დარეკვა…';

  @override
  String get callRinging => 'ირეკება…';

  @override
  String get callConnecting => 'დაკავშირება…';

  @override
  String get callMicrophoneRequired =>
      'ზარებისთვის დაუშვით მიკროფონზე წვდომა სისტემის პარამეტრებში.';

  @override
  String get callMicrophoneWindows =>
      'Windows-მა CubeChat-ს მიკროფონი არ მისცა. ჩართეთ პარამეტრები → კონფიდენციალურობა და უსაფრთხოება → მიკროფონი → „დესკტოპის აპებს მიკროფონზე წვდომის დაშვება“.';

  @override
  String get callElsewhere =>
      'ზარი უკვე მიმდინარეობს ამ ანგარიშის სხვა მოწყობილობაზე.';

  @override
  String get callRelayUnavailable =>
      'ზარების სერვერი მიუწვდომელია. სცადეთ მოგვიანებით.';

  @override
  String get callBusy => 'დაკავებულია';

  @override
  String get callNoAnswer => 'არ პასუხობს';

  @override
  String get callFailed => 'ზარის დაკავშირება ვერ მოხერხდა';

  @override
  String get callDeclined => 'ზარი უარყოფილია';

  @override
  String get callEnded => 'ზარი დასრულდა';

  @override
  String get callMicrophone => 'მიკროფონი';

  @override
  String get callSpeaker => 'დინამიკი';

  @override
  String get callAnswer => 'პასუხი';

  @override
  String get callDecline => 'უარყოფა';

  @override
  String get callEnd => 'დასრულება';

  @override
  String get callClose => 'დახურვა';

  @override
  String get callMinimize => 'ჩაკეცვა';

  @override
  String get callAudioOutput => 'ზარის ხმა';

  @override
  String get callRoutePhone => 'ტელეფონი';

  @override
  String get callRouteBluetooth => 'Bluetooth';

  @override
  String get callRouteHeadphones => 'ყურსასმენი';

  @override
  String get callFullScreenTitle => 'ზარები დაბლოკილ ეკრანზე';

  @override
  String get callFullScreenBody =>
      'დაუშვით შემომავალი ზარის ჩვენება დაბლოკილ ეკრანზე, რომ განბლოკვის გარეშე უპასუხოთ.';

  @override
  String get callFullScreenXiaomi =>
      'Xiaomi, Redmi და Poco აპებს არ აძლევს ამის თავად ჩართვის საშუალებას: ჩართეთ „ჩვენება დაბლოკილ ეკრანზე“ განყოფილებაში „სხვა ნებართვები“.';

  @override
  String get circleMessage => 'ვიდეოშეტყობინება';

  @override
  String get appName => 'Cubechat';

  @override
  String get navChats => 'ჩატები';

  @override
  String get navPeers => 'ახლოს';

  @override
  String get navProfile => 'პროფილი';

  @override
  String get navContacts => 'კონტაქტები';

  @override
  String get navMap => 'რუკა';

  @override
  String get mapTitle => 'რუკა';

  @override
  String get mapFriendsTitle => 'ხალხი რუკაზე';

  @override
  String get mapFriendsHint => 'თქვენს მდებარეობას მხოლოდ ეს კონტაქტები იღებენ';

  @override
  String mapClusterTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'აქ $count ადამიანია',
      one: 'აქ $count ადამიანია',
    );
    return '$_temp0';
  }

  @override
  String get mapClusterHint => 'შეეხეთ ადამიანს, რომ რუკა მასზე გადავიდეს';

  @override
  String get mapNorthUp => 'ჩრდილოეთი ზემოთ';

  @override
  String get mapLayerTitle => 'რუკის სტილი';

  @override
  String get mapLayerHint => 'რაზეა დახატული ნიშნულები';

  @override
  String get mapLayerDark => 'მუქი';

  @override
  String get mapLayerDarkHint =>
      'ქუჩები წარწერების გარეშე — ყველაზე მშვიდი ფონი ნიშნულებისთვის';

  @override
  String get mapLayerSatellite => 'თანამგზავრი';

  @override
  String get mapLayerSatelliteHint => 'აეროფოტოები: რომელი შენობა, რომელი ეზო';

  @override
  String get mapLayerTerrain => 'რელიეფი';

  @override
  String get mapLayerTerrainHint =>
      'ჰორიზონტალები და რელიეფი — ბორცვებისა და ბილიკებისთვის';

  @override
  String get mapFriendsEmpty => 'ჯერ არავინ გიზიარებთ რუკას.';

  @override
  String get mapFriendsEmptyHint =>
      'მოიწვიეთ კონტაქტი — ის აქ გამოჩნდება, როგორც კი მოწვევას მიიღებს.';

  @override
  String get mapFriendsInvite => 'მოწვევა';

  @override
  String get mapFriendsRemove => 'რუკიდან წაშლა';

  @override
  String mapFriendsRemoved(String name) {
    return '$name აღარ გიზიარებთ რუკას';
  }

  @override
  String get mapFriendsLive => 'ახლა რუკაზეა';

  @override
  String get mapFriendsIdle => 'მდებარეობა ახლა არ არის';

  @override
  String get mapInviteTitle => 'რუკაზე მოწვევა';

  @override
  String get mapInviteHint => 'აირჩიეთ ერთი ან რამდენიმე ჩატი';

  @override
  String get mapInviteEmpty => 'მოსაწვევი ჩატები ჯერ არ არის.';

  @override
  String mapInviteAction(int count) {
    return 'გაგზავნა ($count)';
  }

  @override
  String get mapInviteMessage =>
      'მოწვევა Cubechat-ის რუკაზე. გააზიარეთ თქვენი მდებარეობა ამ ჩატში, რომ რუკაზე გამოჩნდეთ.';

  @override
  String mapInviteSent(int count) {
    return 'გაგზავნილი მოწვევები: $count';
  }

  @override
  String get mapInviteFailed => 'მოწვევების გაგზავნა ვერ მოხერხდა';

  @override
  String mapPeopleVisible(int count) {
    return 'გაზიარებული მდებარეობები: $count';
  }

  @override
  String get mapCenterMe => 'ჩემზე ცენტრირება';

  @override
  String get mapNoSharedLocations => 'გაზიარებული მდებარეობები ჯერ არ არის';

  @override
  String get mapNoSharedLocationsHint =>
      'კონტაქტი აქ გამოჩნდება, როცა ჩატში მდებარეობას გამოგიგზავნით.';

  @override
  String get mapWebHintTitle => 'კავშირები ახლოს';

  @override
  String get mapWebHint =>
      'ხაზები სიახლოვეს აჩვენებს და არა შეტყობინების მარშრუტს.';

  @override
  String get mapOpenProfile => 'პროფილი';

  @override
  String get mapLocationPrivacyOff => 'მდებარეობა რუკაზე დამალულია';

  @override
  String get mapLocationPrivacyOffHint =>
      'თქვენი ნიშნულის საჩვენებლად ჩართეთ „მაჩვენე რუკაზე“ განყოფილებაში „კონფიდენციალურობა“.';

  @override
  String get mapYouOnMap => 'თქვენი მდებარეობა ამ მოწყობილობაზე ჩანს';

  @override
  String get locationSharingDisabled =>
      'ჯერ ჩართეთ „მაჩვენე რუკაზე“ განყოფილებაში „კონფიდენციალურობა“.';

  @override
  String get mapLocationDenied => 'მდებარეობაზე წვდომა გამორთულია';

  @override
  String get mapLocationServiceOff =>
      'საკუთარი თავის საჩვენებლად ჩართეთ მდებარეობის სერვისები';

  @override
  String get mapLocationUnavailable =>
      'თქვენი მდებარეობის დადგენა ვერ მოხერხდა';

  @override
  String get mapDistanceUnknown => 'მანძილი უცნობია';

  @override
  String mapDistanceMetres(int metres) {
    return '$metres მ მოშორებით';
  }

  @override
  String mapDistanceKilometres(String kilometres) {
    return '$kilometres კმ მოშორებით';
  }

  @override
  String get mapUpdatedNow => 'ახლახან გაზიარდა';

  @override
  String mapUpdatedMinutes(int minutes) {
    return 'გაზიარდა $minutes წთ-ის წინ';
  }

  @override
  String mapUpdatedHours(int hours) {
    return 'გაზიარდა $hours სთ-ის წინ';
  }

  @override
  String get contactsTitle => 'კონტაქტები';

  @override
  String get contactsSubtitle => 'ყველა, ვისაც მიწერეთ';

  @override
  String get contactsSearchHint => 'კონტაქტების ძიება…';

  @override
  String get contactsEmptyTitle => 'კონტაქტები ჯერ არ არის';

  @override
  String get contactsEmptyHint => 'დაიწყეთ საუბარი და მოსაუბრე აქ გამოჩნდება.';

  @override
  String get contactsSearchEmpty => 'კონტაქტები ვერ მოიძებნა';

  @override
  String get contactsTabContacts => 'კონტაქტები';

  @override
  String get contactsTabCalls => 'ზარები';

  @override
  String get callsFilterAll => 'ყველა';

  @override
  String get callsFilterMissed => 'გამოტოვებული';

  @override
  String get callsEmptyTitle => 'ზარები ჯერ არ არის';

  @override
  String get callsEmptyHint =>
      'აქ გამოჩნდება შემომავალი, გამავალი და გამოტოვებული ზარები.';

  @override
  String get callsMissedEmpty => 'გამოტოვებული ზარები არ არის';

  @override
  String get callsCallBack => 'დარეკვა';

  @override
  String get contactProfileChat => 'ჩატი';

  @override
  String get contactProfileCall => 'ზარი';

  @override
  String get contactProfileRadio => 'რაცია';

  @override
  String get contactProfileSecurity => 'უსაფრთხოება';

  @override
  String get contactProfileActions => 'კონტაქტის მოქმედებები';

  @override
  String get contactProfileVerify => 'დადასტურება';

  @override
  String get contactProfileCopyId => 'კონტაქტის ID-ის კოპირება';

  @override
  String get contactProfileIdCopied => 'კონტაქტის ID დაკოპირდა';

  @override
  String get contactProfileId => 'კონტაქტის ID';

  @override
  String get contactProfileVerifyHint =>
      'შეადარეთ დაშიფვრის ანაბეჭდები, რომ ამ ადამიანის ვინაობა დაადასტუროთ.';

  @override
  String get chatsTitle => 'ჩატები';

  @override
  String get chatsSubtitle => 'Mesh · ბოლომდე დაშიფრული';

  @override
  String get chatsEmptyTitle => 'საუბრები ჯერ არ არის';

  @override
  String get chatsEmptyHint => 'სასაუბროდ გახსენით მოსაუბრე ჩანართში „ახლოს“.';

  @override
  String get chatsFilterAll => 'ყველა';

  @override
  String get chatsFilterUnread => 'წაუკითხავი';

  @override
  String get chatsFilterMesh => 'Mesh';

  @override
  String get chatsFilterFavorites => 'რჩეული';

  @override
  String get chatsFolderDirect => 'პირადი';

  @override
  String get chatsFolderChannels => 'არხები';

  @override
  String get chatsFolderOnline => 'კავშირზე';

  @override
  String get chatsFoldersTitle => 'საქაღალდეები';

  @override
  String get chatsFoldersHint =>
      'საქაღალდეები ამავე სიის ჭრილებია და არა ადგილები, სადაც ჩატები გადაიტანება. ჩართეთ ისინი, რომლებიც ჩატების ზემოთ გჭირდებათ.';

  @override
  String get chatsSearchHint => 'ჩატების ძიება…';

  @override
  String get chatsStatusViaMesh => 'mesh-ით';

  @override
  String get chatsStatusOffline => 'ოფლაინ';

  @override
  String get peerKeyRotated => 'გასაღები შეიცვალა — დაადასტურეთ ხელახლა';

  @override
  String get peersTitle => 'ახლოს';

  @override
  String get peersSubtitle => 'მოწყობილობები Bluetooth-ის რადიუსში';

  @override
  String get peersEmpty => 'მოსაუბრეების ძიება…';

  @override
  String peersHopsOne(int n) {
    return '$n ხტომის მანძილზე';
  }

  @override
  String peersHopsOther(int n) {
    return '$n ხტომის მანძილზე';
  }

  @override
  String get blePermissionTitle => 'საჭიროა Bluetooth-ის ნებართვა';

  @override
  String get blePermissionHint =>
      'Cubechat-ს Bluetooth სჭირდება მოსაუბრეების საპოვნელად და შეტყობინებების გასაგზავნად — ინტერნეტის გარეშე.';

  @override
  String get blePermissionGrant => 'ნებართვის მიცემა';

  @override
  String get blePermissionOpenSettings => 'პარამეტრების გახსნა';

  @override
  String get blePermissionDeniedHint =>
      'ნებართვა უარყოფილია. გახსენით პარამეტრები და დაუშვით Bluetooth-ზე წვდომა.';

  @override
  String get bleAdapterOffTitle => 'Bluetooth გამორთულია';

  @override
  String get bleAdapterOffHint =>
      'ჩართეთ Bluetooth, რომ ახლოს მყოფი მოწყობილობები დაინახოთ.';

  @override
  String get bleUnsupportedTitle => 'Bluetooth LE მიუწვდომელია';

  @override
  String get bleUnsupportedHint =>
      'ეს მოწყობილობა ან პლატფორმა Bluetooth Low Energy-ს არ უჭერს მხარს. სცადეთ ტელეფონზე.';

  @override
  String get bleScanning => 'სკანირება…';

  @override
  String get bleRetry => 'ხელახლა';

  @override
  String get bleEnable => 'ჩართვა';

  @override
  String get bleConnectFailed =>
      'დაკავშირება ვერ მოხერხდა. მოსაუბრე შესაძლოა მიუწვდომელ ზონაშია ან მისი Bluetooth-მისამართი შეიცვალა.';

  @override
  String get bleSignal => 'სიგნალი';

  @override
  String get bleConnect => 'დაკავშირება';

  @override
  String get bleConnected => 'დაკავშირებულია';

  @override
  String get bleVerified => 'დადასტურებულია';

  @override
  String get editorAdjustBrightness => 'სიკაშკაშე';

  @override
  String get editorAdjustContrast => 'კონტრასტი';

  @override
  String get editorAdjustSaturation => 'გაჯერება';

  @override
  String get editorToolCrop => 'ამოჭრა';

  @override
  String get editorToolDraw => 'ხატვა';

  @override
  String get editorToolAdjust => 'კორექცია';

  @override
  String get editorTabSticker => 'სტიკერი';

  @override
  String get editorTabText => 'ტექსტი';

  @override
  String get editorPenPen => 'კალამი';

  @override
  String get editorPenMarker => 'მარკერი';

  @override
  String get editorPenNeon => 'ნეონი';

  @override
  String get editorPenArrow => 'ისარი';

  @override
  String get editorPenBlur => 'გაბუნდოვნება';

  @override
  String get editorPenEraser => 'საშლელი';

  @override
  String get editorLevel => 'გასწორება';

  @override
  String get editorTextHint => 'ტექსტი ფოტოზე';

  @override
  String get editorCropFree => 'თავისუფალი';

  @override
  String get editorRemove => 'მოშორება';

  @override
  String get notificationUnknownSender => 'ახალი შეტყობინება';

  @override
  String get bleUnknownPeer => 'უცნობი მოწყობილობა';

  @override
  String get bleBroadcasting => 'ეთერშია';

  @override
  String bleConnectedCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'დაკავშირებულია $n ცენტრალური მოწყობილობა',
      one: 'დაკავშირებულია 1 ცენტრალური მოწყობილობა',
      zero: 'კავშირები არ არის',
    );
    return '$_temp0';
  }

  @override
  String get verifyTitle => 'დადასტურება';

  @override
  String get verifyIntro =>
      'შეადარეთ ეს ორი ანაბეჭდი მოსაუბრესთან პირადად ან ხმოვანი ზარით. თუ ორივე მხარეს ემთხვევა, დადასტურებულია, რომ Noise-ის ხელის ჩამორთმევა არ გაყალბებულა.';

  @override
  String get verifyMine => 'თქვენი ანაბეჭდი';

  @override
  String verifyTheirs(String name) {
    return '$name-ის ანაბეჭდი';
  }

  @override
  String get verifyMarkAsVerified => 'დადასტურებულად მონიშვნა';

  @override
  String get verifyAlreadyDone => 'ეს მოსაუბრე დადასტურებულია.';

  @override
  String get verifyRevoke => 'გაუქმება';

  @override
  String verifyDoneSnack(String name) {
    return '$name დადასტურებულად მოინიშნა';
  }

  @override
  String get chatInputHint => 'შეტყობინება';

  @override
  String get chatSend => 'გაგზავნა';

  @override
  String get chatToday => 'დღეს';

  @override
  String get chatYesterday => 'გუშინ';

  @override
  String get chatDelivered => 'მიწოდებულია';

  @override
  String get chatRead => 'წაკითხულია';

  @override
  String get chatSending => 'იგზავნება';

  @override
  String get chatWaitingForConnection => 'კავშირს ელოდება';

  @override
  String sendQueueCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count შეტყობინება კავშირს ელოდება',
      one: '1 შეტყობინება კავშირს ელოდება',
    );
    return '$_temp0';
  }

  @override
  String sendQueueSlowNetwork(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'ნელი ქსელი — იგზავნება $count შეტყობინება',
      one: 'ნელი ქსელი — იგზავნება 1 შეტყობინება',
    );
    return '$_temp0';
  }

  @override
  String get sendQueueTitle => 'გაგზავნას ელოდება';

  @override
  String get sendQueueHint =>
      'ისინი თავად წავლენ, როგორც კი გზა გაჩნდება — ახლოს Bluetooth ან ინტერნეტი. არაფრის დაჭერა არ არის საჭირო.';

  @override
  String get sendQueueRetry => 'ახლავე ცდა';

  @override
  String get sendQueueCancel => 'გაგზავნის გაუქმება';

  @override
  String get sendQueueCancelled => 'არ გაიგზავნა — გაუქმდა';

  @override
  String get sendQueueTooLate => 'გაუქმება უკვე გვიანია: შეტყობინება წავიდა';

  @override
  String get chatEncryptedNotice =>
      'შეტყობინებები ბოლომდე დაშიფრულია Noise Protocol-ით.';

  @override
  String get chatSessionHandshaking => 'დაცული არხის დამყარება…';

  @override
  String get chatSessionEstablished => 'დაცულია · Noise XX';

  @override
  String get chatSessionFailed => 'დაკავშირება ვერ მოხერხდა';

  @override
  String get presenceOnline => 'ონლაინ';

  @override
  String get presenceOffline => 'ოფლაინ';

  @override
  String get chatSessionFingerprintPending =>
      'ანაბეჭდი გამოჩნდება ხელის ჩამორთმევის დასრულების შემდეგ.';

  @override
  String get chatEmptyEstablished =>
      'დაცული არხი მზადაა. საუბრის დასაწყებად გაგზავნეთ შეტყობინება.';

  @override
  String get chatEmptyHandshaking =>
      'ველოდებით, როდის დაასრულებს მეორე მხარე ხელის ჩამორთმევას…';

  @override
  String get chatEmptyTitle => 'აქ ჯერ შეტყობინებები არ არის';

  @override
  String get chatEmptyGreetHint =>
      'დაწერეთ შეტყობინება ან შეეხეთ კუბის, რომ მიესალმოთ.';

  @override
  String get profileTitle => 'პროფილი';

  @override
  String get profileNickname => 'მეტსახელი';

  @override
  String get profileNicknameEditTitle => 'მიუთითეთ მეტსახელი';

  @override
  String get profileNicknameHint => 'როგორ დაგინახავენ სხვები mesh-ქსელში';

  @override
  String get profileNicknameSave => 'შენახვა';

  @override
  String get profileFingerprint => 'საჯარო გასაღების ანაბეჭდი';

  @override
  String get profileLanguage => 'ენა';

  @override
  String get profileLanguageEn => 'ინგლისური';

  @override
  String get profileLanguageUk => 'უკრაინული';

  @override
  String get profileTransport => 'ტრანსპორტი';

  @override
  String get profileTransportMesh => 'Bluetooth mesh';

  @override
  String get profileBackground => 'ფონურ რეჟიმში მუშაობა';

  @override
  String get profileBackgroundSubtitle =>
      'შეტყობინებების მიღება, როცა აპი დახურულია';

  @override
  String get profileBatteryExempt => 'ბატარეის ოპტიმიზაციის გამორთვა';

  @override
  String get profileAbout => 'აპის შესახებ';

  @override
  String profileVersion(String v) {
    return 'ვერსია $v';
  }

  @override
  String get rotateKeysTitle => 'ანგარიშის გასაღებების შეცვლა';

  @override
  String get rotateKeysHint =>
      'თუ თქვენი ანგარიშით მოწყობილობა დაიკარგა ან მოიპარეს';

  @override
  String get rotateKeysConfirmTitle => 'შეიცვალოს ანგარიშის გასაღებები?';

  @override
  String get rotateKeysConfirmBody =>
      'კონტაქტები მიიღებენ თქვენს ახალ გასაღებებს და მიმოწერა შეუნარჩუნდებათ, მაგრამ თითოეულს სთხოვენ თქვენი გასაღებების ხელახლა შემოწმებას. ანგარიშის ყველა სხვა მოწყობილობა გამოვა; საჭიროები ხელახლა დააკავშირეთ ამ ტელეფონიდან. CubeChat-ის ძველი ვერსიის მქონე კონტაქტები ვერ მოგწერენ, სანამ არ განაახლებენ. არხების გასაღებები არ შეიცვლება.';

  @override
  String get rotateKeysConfirmAction => 'გასაღებების შეცვლა';

  @override
  String get rotateKeysWorking => 'გასაღებები იცვლება…';

  @override
  String rotateKeysDone(int sent, int total) {
    return 'ახალი გასაღებები. ეცნობა $total-დან $sent კონტაქტს';
  }

  @override
  String get rotateKeysSlow =>
      'ახალი გასაღებები. ყველა კონტაქტმა ვერ მოასწრო დადასტურება; რელეები მათთვის შეინახავს';

  @override
  String get profileEmergencyWipe => 'საგანგებო წაშლა';

  @override
  String get profileEmergencyWipeConfirm => 'წაიშალოს ყველაფერი?';

  @override
  String get profileEmergencyWipeConfirmHint =>
      'წაიშლება თქვენი იდენტობა, კონტაქტების სია და საუბრების ისტორია. ამ მოქმედების გაუქმება შეუძლებელია.';

  @override
  String get profileEmergencyWipeAction => 'წაშლა';

  @override
  String get cancel => 'გაუქმება';

  @override
  String get copy => 'კოპირება';

  @override
  String get copied => 'დაკოპირდა';

  @override
  String get channelsNewTitle => 'ახალი არხი';

  @override
  String get channelsNewTooltip => 'ახალი არხი';

  @override
  String get channelNameLabel => 'არხის სახელი';

  @override
  String get channelPasswordLabel => 'პაროლი (არასავალდებულო)';

  @override
  String get channelJoinAction => 'შესვლა';

  @override
  String get channelNameHint =>
      'ვინც იმავე სახელსა და პაროლს შეიყვანს, იმავე ოთახში მოხვდება. არ არსებობს სერვერი, რომელიც მათ სიას ინახავს.';

  @override
  String get channelPasswordHint =>
      'პაროლი თავად არის გასაღები. მის გარეშე ოთახი ღიაა ახლოს მყოფი ყველასთვის, ვინც მისი სახელი იცის.';

  @override
  String get channelSubtitle => 'ჯგუფური არხი · საერთო გასაღები';

  @override
  String get channelMute => 'დადუმება';

  @override
  String get channelUnmute => 'ხმის ჩართვა';

  @override
  String channelMutedUntil(String time) {
    return 'დადუმებულია $time-მდე';
  }

  @override
  String get channelMuteFor => 'დადუმება…';

  @override
  String channelMuteMinutes(int minutes) {
    return '$minutes წუთი';
  }

  @override
  String channelMuteHours(int hours) {
    return '$hours საათი';
  }

  @override
  String channelMuteDays(int days) {
    return '$days დღე';
  }

  @override
  String get channelMuteForever => 'სანამ ხელახლა არ ჩავრთავ';

  @override
  String get channelCommunity => 'კომენტარები';

  @override
  String get channelCommunityOpen => 'განხილვის გახსნა';

  @override
  String channelCommunitySubtitle(String channel) {
    return '$channel-ის განხილვა';
  }

  @override
  String get channelBackToChannel => 'არხზე დაბრუნება';

  @override
  String get channelMemberActions => 'მონაწილე';

  @override
  String get channelRemoveMember => 'არხიდან წაშლა';

  @override
  String get channelRemoveMemberHint =>
      'მისი პოსტები აქ აღარ მიიღება. არაფერი უშლის ხელს, სახელით ხელახლა შემოვიდეს — საერთო გასაღები ერთადერთი წევრობაა, რაც არსებობს.';

  @override
  String get channelMuteMember => 'დადუმება…';

  @override
  String get channelUnmuteMember => 'წერის ხელახლა დაშვება';

  @override
  String channelMemberRemoved(String name) {
    return '$name წაიშალა';
  }

  @override
  String channelMemberMuted(String name) {
    return '$name დადუმდა';
  }

  @override
  String channelMemberCleared(String name) {
    return '$name-ს ისევ შეუძლია წერა';
  }

  @override
  String get channelMemberMutedNote => 'დადუმებული';

  @override
  String get channelShareHistory => 'ისტორიის გაზიარება';

  @override
  String get channelShareHistoryHint =>
      'ამ ოთახის ბოლო პოსტებს ხელახლა უშვებს ეთერში, რომ მოგვიანებით შემოსულებმაც დაინახონ. ვინც უკვე აქ იყო, ახალს არაფერს მიიღებს.';

  @override
  String channelHistoryShared(int count) {
    return 'შეთავაზებული პოსტები: $count';
  }

  @override
  String get channelHistoryNothing => 'გასაზიარებელი ჯერ არაფერია';

  @override
  String get channelHistoryAuto => 'ისტორია ახალ წევრებს';

  @override
  String get channelHistoryAutoHint =>
      'როცა ოთახში ვინმე ახალი ჩნდება, ბოლო პოსტები მას თავისით მიდის. ჯერჯერობით მხოლოდ ტექსტი — ფოტოები ნაწილების ნაკადით იგზავნება და მათი გამეორება ყველასთვის დუბლირების გარეშე შეუძლებელია.';

  @override
  String get channelPostComments => 'კომენტარები';

  @override
  String get channelNoComments => 'ამ პოსტზე ჯერ არავის არაფერი უთქვამს';

  @override
  String get channelCommentHint => 'კომენტარი';

  @override
  String get channelMuteCustom => 'რამდენი ხნით?';

  @override
  String get channelMuteCustomHint => 'საათი';

  @override
  String get chatPinnedManage => 'ჩამაგრებული';

  @override
  String get chatPeekOpen => 'ჩატის გახსნა';

  @override
  String get chatPeekPin => 'ჩამაგრება';

  @override
  String get chatPeekUnpin => 'მოხსნა';

  @override
  String get chatPeekUnmute => 'ხმის ჩართვა';

  @override
  String get chatPeekMarkRead => 'წაკითხულად მონიშვნა';

  @override
  String get chatDeleteForMeHint =>
      'წაიშლება ამ ტელეფონიდან და მოიხსნება ჩამაგრებიდან. მოსაუბრეს თავისი ასლი დარჩება.';

  @override
  String get pushWakeTitle => 'ამ ტელეფონის გაღვიძება';

  @override
  String get pushWakeHint =>
      'პატარა სერვერი რელეებზე თქვენს მისამართს ადევნებს თვალს და ამ ტელეფონს აკაკუნებს, როცა რამე მოდის, რომ დახურულმა აპმაც გაცნობოთ. ის ვერასოდეს ხედავს შეტყობინებას ან გასაღებს — მხოლოდ იმას, რომ თქვენს მისამართზე რაღაც მოვიდა და როდის. რელემ ეს უკვე იცის; ეს მეორე ადგილია, რომელმაც იცის.';

  @override
  String get pushWakeDeniedTitle => 'შეტყობინებები გამორთულია';

  @override
  String get pushWakeDeniedHint =>
      'სისტემამ ერთხელ უკვე მიიღო უარი და აღარ იკითხავს, ამიტომ ამის ჩართვა მხოლოდ პარამეტრებშია შესაძლებელი — cubechat, შემდეგ „შეტყობინებები“. ამის შემდეგ აქ დაბრუნდით.';

  @override
  String get pushWakeRefused => 'შეტყობინებები არ დაიშვა';

  @override
  String get privacyForwardLinkTitle => 'ბმული გადაგზავნილებიდან';

  @override
  String get privacyForwardLinkHint =>
      'როცა ვინმე თქვენს შეტყობინებას გადააგზავნის, მის ზემოთ სტრიქონს შეუძლია თქვენი პროფილის გახსნა. გამორთულისას ისინი მხოლოდ სახელს ხედავენ, დასაჭერი არაფერია. ეს თხოვნაა მათი აპისადმი და არა ის, რისი იძულებაც ამ აპს შეუძლია.';

  @override
  String get privacyShareSheetTitle => 'ჩატები გაზიარების მენიუში';

  @override
  String get privacyShareSheetOnHint =>
      'თქვენი ბოლო ოთხი ჩატის სახელები Android-ს გადაეცემა, რომ ნებისმიერი აპიდან გაუგზავნოთ. აპის დაბლოკვა მათ არ მალავს.';

  @override
  String get privacyShareSheetOffHint =>
      'Android-ს არაფერი გადაეცემა. CubeChat-ში გაზიარებისას ჩატს სიიდან აირჩევთ.';

  @override
  String get privacyCallsTitle => 'ზარების მიღება';

  @override
  String get privacyCallsOnHint =>
      'თქვენს კონტაქტებს შეუძლიათ დაგირეკონ. ერთი ადამიანისთვის ასაკრძალად გახსენით მისი პროფილი.';

  @override
  String get privacyCallsOffHint =>
      'ვერავინ დაგირეკავთ, გარდა იმათისა, ვისაც მათ პროფილში დაუშვებთ. უარყოფილ ზარს ისინი „დაკავებულად“ დაინახავენ.';

  @override
  String get chatsStatusChannel => 'არხი';

  @override
  String get channelInviteTitle => 'ხალხის დამატება';

  @override
  String get channelInviteAction => 'მოწვევა';

  @override
  String get channelInviteEmpty =>
      'ნაცნობი მოსაუბრეები ჯერ არ არის. ჯერ იპოვეთ ვინმე ჩანართში „ახლოს“.';

  @override
  String get channelInviteSent => 'მოწვევები გაიგზავნა';

  @override
  String get channelInviteNoneSent =>
      'ახლა ვერავისთან დაკავშირება ვერ მოხერხდა';

  @override
  String get channelNameTooLong => 'არხის სახელი ძალიან გრძელია';

  @override
  String get chatsActionFavorite => 'რჩეულებში დამატება';

  @override
  String get chatsActionUnfavorite => 'რჩეულებიდან ამოღება';

  @override
  String get chatsActionDelete => 'ჩატის წაშლა';

  @override
  String get chatsDeleteTitle => 'წაიშალოს ეს ჩატი?';

  @override
  String chatsDeleteManyHint(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'გასუფთავდება $count საუბარი. კონტაქტები დარჩება, ასე რომ, კოდების გაცვლის გარეშე შეძლებთ ხელახლა მიწერას.',
    );
    return '$_temp0';
  }

  @override
  String get chatsDeletedToast => 'ჩატი წაიშალა.';

  @override
  String chatsDeletedManyToast(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'წაიშალა $count ჩატი.',
      one: 'წაიშალა $count ჩატი.',
    );
    return '$_temp0';
  }

  @override
  String get undo => 'დაბრუნება';

  @override
  String get chatsDeletePeerHint =>
      'საუბარი გასუფთავდება. კონტაქტი დარჩება, ასე რომ, კოდების გაცვლის გარეშე შეძლებთ ხელახლა მიწერას.';

  @override
  String get chatsDeleteChannelHint =>
      'გახვალთ არხიდან და წაიშლება მისი ისტორია. დასაბრუნებლად ისევ გასაღები დაგჭირდებათ.';

  @override
  String get chatsDeleteForThemToo => 'მოსაუბრესთანაც წაშლა';

  @override
  String get chatsDeleteForThemHint =>
      'მის აპს სთხოვს, მთელი საუბარი გაასუფთაოს, მისი დაწერილის ჩათვლით. არხში მხოლოდ თქვენი შეტყობინებები გაიწვევა.';

  @override
  String get chatEditAction => 'რედაქტირება';

  @override
  String get chatEditTitle => 'შეტყობინების რედაქტირება';

  @override
  String get chatEditSave => 'შენახვა';

  @override
  String get chatEdited => 'შეცვლილია';

  @override
  String get chatDeleteAction => 'წაშლა';

  @override
  String get chatDeleteTitle => 'წაიშალოს შეტყობინება?';

  @override
  String get chatDeleteForMe => 'ჩემთან წაშლა';

  @override
  String get chatDeleteForEveryone => 'ყველასთან წაშლა';

  @override
  String get chatPinTitle => 'ჩამაგრდეს შეტყობინება?';

  @override
  String get chatPinForBoth => 'ორივესთან ჩამაგრება';

  @override
  String get chatPinForMe => 'მხოლოდ ჩემთან ჩამაგრება';

  @override
  String get chatReplyAction => 'პასუხი';

  @override
  String chatReplyingTo(String name) {
    return 'პასუხი: $name';
  }

  @override
  String get chatReplyYou => 'საკუთარ თავს';

  @override
  String get chatCopyAction => 'კოპირება';

  @override
  String get chatCopied => 'დაკოპირდა';

  @override
  String get chatForwardAction => 'გადაგზავნა';

  @override
  String get chatForwardTitle => 'გადაგზავნა';

  @override
  String get shareIntoTitle => 'გაგზავნა';

  @override
  String get shareNearbyAirDrop => 'ახლოს AirDrop-ით';

  @override
  String get shareNearbyAirDropHint => 'ინტერნეტის გარეშე — გვერდით მყოფებს';

  @override
  String get shareSent => 'გაიგზავნა';

  @override
  String get shareFailed => 'ნაწილის გაგზავნა ვერ მოხერხდა';

  @override
  String get chatForwardEmpty => 'სხვა ჩატები ჯერ არ არის';

  @override
  String chatForwardSendCount(int count) {
    return 'გაგზავნა ($count)';
  }

  @override
  String chatForwardSentCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'გადაიგზავნა $count ჩატში',
      one: 'გადაიგზავნა ერთ ჩატში',
    );
    return '$_temp0';
  }

  @override
  String chatForwardSent(String name) {
    return 'გადაიგზავნა: $name';
  }

  @override
  String chatSentAt(String time) {
    return 'გაიგზავნა $time';
  }

  @override
  String chatReadAt(String time) {
    return 'წაიკითხა $time';
  }

  @override
  String get chatPinAction => 'ჩამაგრება';

  @override
  String get chatUnpinAction => 'მოხსნა';

  @override
  String chatPinnedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ჩამაგრებული შეტყობინება',
      one: '1 ჩამაგრებული შეტყობინება',
      zero: 'ჩამაგრებული შეტყობინებები არ არის',
    );
    return '$_temp0';
  }

  @override
  String get chatNoPins => 'აქ არაფერია ჩამაგრებული';

  @override
  String get chatUnpinAll => 'ყველა შეტყობინების მოხსნა';

  @override
  String get chatShowAllPins => 'ყველა ჩამაგრებული შეტყობინება';

  @override
  String get chatUnpinConfirm => 'მოიხსნას ეს შეტყობინება?';

  @override
  String get chatUnpinConfirmHint =>
      'ის აღარ იქნება ჩამაგრებული ამ ჩატის ყველა მონაწილისთვის.';

  @override
  String get chatPinnedTitle => 'ჩამაგრებული შეტყობინება';

  @override
  String get chatPinnedGone => 'ეს შეტყობინება ამ ჩატში აღარ არის';

  @override
  String get peerBlock => 'დაბლოკვა';

  @override
  String get peerUnblock => 'განბლოკვა';

  @override
  String get peerMute => 'დადუმება';

  @override
  String get peerUnmute => 'ხმის ჩართვა';

  @override
  String get peerBlockedNote =>
      'დაბლოკილია — მისი შეტყობინებები უგულებელყოფილია.';

  @override
  String get relaysTitle => 'სათადარიგო ინტერნეტ-არხი';

  @override
  String get relaysCardTitle => 'მოსაუბრეებთან ინტერნეტით დაკავშირება';

  @override
  String get relaysCardSubtitle =>
      'როცა Bluetooth ვერ აწვდის — გაგზავნა Nostr-ის რელეებით';

  @override
  String get relaysExplainer =>
      'შეტყობინებები ბოლომდე დაშიფრული რჩება — რელე იმავე დალუქულ კადრს ატარებს, რასაც Bluetooth. თუმცა ის ხედავს, რომელი ორი გასაღები ურთიერთობს და როდის. ნაგულისხმევად გამორთულია.';

  @override
  String get relaysMyAddress => 'თქვენი მისამართი რელეებზე';

  @override
  String get relaysCopied => 'დაკოპირდა';

  @override
  String get circleLensTitle => 'წინა კამერა წრიული ვიდეოსთვის';

  @override
  String get circleLensFrontHint =>
      'წრიული ვიდეოშეტყობინებები თქვენკენ მიმართული კამერით იწერება.';

  @override
  String get circleLensBackHint =>
      'წრიული ვიდეოშეტყობინებები უკანა კამერით იწერება, რომ აჩვენოთ, რასაც უყურებთ.';

  @override
  String get channelCloseTitle => 'ოთახის დახურვა ყველასთვის';

  @override
  String get channelCloseSubtitle =>
      'წაიშლება ყველა მონაწილის ტელეფონიდან. ამის გაკეთება მხოლოდ თქვენ შეგიძლიათ.';

  @override
  String get channelCloseConfirm =>
      'ოთახი, მისი შეტყობინებები და მონაწილეები გაქრება ყველა ტელეფონიდან, სადაც ის არის. არავინ იბლოკება: გასაღები სახელიდან მოდის, ასე რომ, ვისაც ის ახსოვს, ცარიელ ოთახს ხელახლა გახსნის.';

  @override
  String get channelCloseAction => 'ოთახის დახურვა';

  @override
  String get circleHint => 'გაუშვით გასაგზავნად · მარცხნივ — გაუქმება';

  @override
  String get circleHintLocked => 'დასრულებისას დააჭირეთ გაგზავნას';

  @override
  String get circleNeedsCamera => 'წრიულ ვიდეოს კამერა და მიკროფონი სჭირდება';

  @override
  String get circleFailed => 'წრიული ვიდეოს ჩაწერა ვერ მოხერხდა';

  @override
  String get relaysListLabel => 'რელეები';

  @override
  String get relaysLaneMedia => 'მედიის რელეები';

  @override
  String get relaysLaneMediaNote =>
      'ფოტოები, ფაილები და ვიდეო ამათით მიდის, რომ გადაცემამ საუბარი არ შეანელოს.';

  @override
  String get relaysLaneLocation => 'მდებარეობის რელეები';

  @override
  String get relaysLaneLocationNote =>
      'რუკის შუქურები ამათით მიდის, ყველაფრისგან ცალკე.';

  @override
  String get relaysAdd => 'რელეს დამატება';

  @override
  String get relaysAddHint => 'wss://relay.example.com';

  @override
  String get relaysInvalidUrl => 'შეიყვანეთ wss:// ან ws:// მისამართი';

  @override
  String get relaysRemove => 'წაშლა';

  @override
  String get relaysStateConnected => 'დაკავშირებულია';

  @override
  String get relaysStateConnecting => 'დაკავშირება…';

  @override
  String get relaysStateFailed => 'მიუწვდომელია';

  @override
  String get relaysStateIdle => 'გამორთულია';

  @override
  String get relaysEmpty =>
      'რელეები არ არის მითითებული — სათადარიგო არხი გამორთულია.';

  @override
  String get contactTitle => 'საკონტაქტო ბარათი';

  @override
  String get contactMineLabel => 'თქვენი ბარათი';

  @override
  String get contactMineExplainer =>
      'გაუგზავნეთ ის მას, ვინც Bluetooth-ის ზონის გარეთაა. ის შეიცავს თქვენს გასაღებებს და რელეზე მისამართს — ეს საკმარისია, რომ ინტერნეტით თქვენთან დაშიფრული ჩატი დაიწყოს.';

  @override
  String get contactCopy => 'კოპირება';

  @override
  String get contactShare => 'გაზიარება';

  @override
  String get contactCopied => 'ბარათი დაკოპირდა';

  @override
  String get contactShareSubject => 'ჩემი cubechat-ის საკონტაქტო ბარათი';

  @override
  String get contactAddLabel => 'ადამიანის დამატება';

  @override
  String get contactAddHint => 'ჩასვით საკონტაქტო ბარათი';

  @override
  String get contactAddAction => 'დამატება';

  @override
  String get contactPaste => 'ჩასმა';

  @override
  String contactAdded(String name) {
    return 'დაემატა $name';
  }

  @override
  String get contactInvalid => 'ეს არ არის სწორი საკონტაქტო ბარათი';

  @override
  String get contactOwnCard => 'ეს თქვენი საკუთარი ბარათია';

  @override
  String get contactUnverified =>
      'ასე დამატებული კონტაქტი თავიდან დაუდასტურებელია. ნებისმიერს შეუძლია ბარათის შექმნა და მასზე ნებისმიერი სახელის დაწერა, ამიტომ ვინაობის ნდობამდე შეადარეთ ანაბეჭდები პირადად ან ზარით.';

  @override
  String get contactRelayOff =>
      'სათადარიგო ინტერნეტ-არხი გამორთულია, ამიტომ ბარათი ჯერ ვერავის მიაღწევს.';

  @override
  String get contactRelayEnable => 'ჩართვა';

  @override
  String get profileContactCard => 'საკონტაქტო ბარათი';

  @override
  String get chatsAddContactTooltip => 'კონტაქტის დამატება ბარათით';

  @override
  String get chatsMenuTooltip => 'მეტი';

  @override
  String get chatsMenuAddContact => 'კონტაქტის დამატება';

  @override
  String get chatsMenuNewChannel => 'ახალი არხი';

  @override
  String get profileDiscoverable => 'ხილვადობა ახლოს';

  @override
  String get profileDiscoverableOnHint =>
      'რადიუსში ნებისმიერს შეუძლია თქვენი პოვნა';

  @override
  String get profileDiscoverableOffHint =>
      'თქვენთან მხოლოდ კონტაქტები დაგიკავშირდებიან';

  @override
  String get profileDiscoverableExplainer =>
      'ჩართულისას თქვენი ანონსი ღიად ვრცელდება, რომ უცნობმა უბრალოდ მოახლოებით გაგიცნოთ — და ნებისმიერი მსმენელი ჩაიწერს თქვენს გასაღებსა და სახელს. გამორთულისას იგივე ნაკრები მხოლოდ არსებულ კონტაქტებს მიდის, დალუქული, და თქვენი მარშრუტიზაციის ID-ები ერთმანეთს ვერ დაუკავშირდება. ახალ ადამიანებს მაშინ საკონტაქტო ბარათი დასჭირდებათ.';

  @override
  String get voiceHoldHint =>
      'დააჭირეთ და გეჭიროთ ხმოვანი შეტყობინების ჩასაწერად';

  @override
  String get voiceTrimPlay => 'დაკვრა';

  @override
  String get voiceTrimPause => 'პაუზა';

  @override
  String get voiceTrimDiscard => 'ჩანაწერის წაშლა';

  @override
  String voiceTrimSelection(String duration) {
    return 'იგზავნება $duration';
  }

  @override
  String get profileLastSeen => 'ბოლო ვიზიტის ჩვენება';

  @override
  String get profileLastSeenOnHint => 'კონტაქტები ხედავენ, როდის ხართ აპში';

  @override
  String get profileLastSeenOffHint =>
      'თქვენს დროს ვერავინ ხედავს და ვერც თქვენ ხედავთ სხვისას: მხოლოდ ვინ არის ონლაინ';

  @override
  String get profileMapLocation => 'მაჩვენე რუკაზე';

  @override
  String get profileMapLocationOnHint =>
      'მდებარეობა ხელმისაწვდომია ხელით გასაზიარებლად და თქვენი ნიშნული რუკაზე ჩანს';

  @override
  String get profileMapLocationOffHint =>
      'აპი მდებარეობას არ ითხოვს და თქვენი ნიშნული დამალულია';

  @override
  String get desktopAutostartTitle => 'Windows-თან ერთად გაშვება';

  @override
  String get desktopAutostartHint =>
      'CubeChat ტრეიში ელოდება, ასე რომ, ზარები და შეტყობინებები ამ კომპიუტერს დახურული ფანჯრითაც მიაღწევს';

  @override
  String get trayOpen => 'CubeChat-ის გახსნა';

  @override
  String get trayQuit => 'გასვლა';

  @override
  String get callDirectTitle => 'პირდაპირი ზარები';

  @override
  String get callDirectOnHint =>
      'უფრო სწრაფია, მაგრამ ვისაც ურეკავთ, თქვენს IP-მისამართს გაიგებს';

  @override
  String get callDirectOffHint =>
      'ზარები ჩვენი რელეთი მიდის: ვისაც ურეკავთ, თქვენს IP-ს ვერ ხედავს, რელე კი ზარს ვერ ისმენს';

  @override
  String get profileReadReceipts => 'წაკითხვის დადასტურება';

  @override
  String get profileReadReceiptsOnHint => 'გამგზავნი ხედავს, რომ წაიკითხეთ';

  @override
  String get profileReadReceiptsOffHint =>
      'თქვენ აღარ აგზავნით წაკითხვის დროს, მაგრამ სხვებისას ისევ ხედავთ';

  @override
  String get profilePrivacyExplainer =>
      'ბოლო ვიზიტი ორივე მხარეს მოქმედებს: თუ საკუთარ სტატუსს დამალავთ, აღარც სხვებისას დაინახავთ. წაკითხვის დადასტურება მხოლოდ იმას მართავს, რასაც თქვენ აგზავნით. შეტყობინებების მიწოდებაზე ეს გავლენას არ ახდენს.';

  @override
  String get chatTimerAction => 'ტაიმერი';

  @override
  String get chatTimerRemove => 'ტაიმერის მოხსნა';

  @override
  String get chatTimerTitle => 'ამ შეტყობინების წაშლა';

  @override
  String chatTimerSet(String time) {
    return 'შეტყობინება გაქრება $time-ში';
  }

  @override
  String get chatTimerLocalHint => 'მხოლოდ ამ მოწყობილობაზე — მათი ასლი მათია';

  @override
  String get contactTagAction => 'იარლიყი';

  @override
  String get contactTagRemove => 'იარლიყის მოხსნა';

  @override
  String get contactTagTitle => 'აირჩიეთ იარლიყი';

  @override
  String get contactTagAll => 'ყველა';

  @override
  String get quietHoursTitle => 'წყნარი საათები';

  @override
  String get quietHoursHint => 'შეტყობინებები მოდის, ტელეფონი კი ჩუმადაა';

  @override
  String get quietHoursFrom => 'დან';

  @override
  String get quietHoursTo => 'მდე';

  @override
  String get notifPreviewTitle => 'შეტყობინებებში ჩვენება';

  @override
  String get notifPreviewFull => 'სახელი და ტექსტი';

  @override
  String get notifPreviewNameOnly => 'მხოლოდ სახელი';

  @override
  String get notifPreviewHidden => 'არაფერი';

  @override
  String get notifPreviewHint =>
      'შეტყობინებები ჩანს დაბლოკილ ეკრანზე და შეტყობინებებზე წვდომის მქონე აპებისთვის, აპის დაბლოკვის ჩართვის დროსაც';

  @override
  String get notifPreviewNewMessage => 'ახალი შეტყობინება';

  @override
  String get appLockTitle => 'აპის დაბლოკვა';

  @override
  String get appLockHint => 'გახსნისას კოდის მოთხოვნა';

  @override
  String get appLockPrompt => 'შეიყვანეთ კოდი';

  @override
  String get appLockUnlock => 'განბლოკვა';

  @override
  String get appLockWrong => 'არასწორი კოდი';

  @override
  String get appLockSetTitle => 'კოდის დაყენება';

  @override
  String get appLockSetHint => 'ოთხი ან მეტი ციფრი. მისი აღდგენა შეუძლებელია.';

  @override
  String get appLockOffTitle => 'დაბლოკვის გამორთვა';

  @override
  String get appLockOffHint => 'შეიყვანეთ მიმდინარე კოდი';

  @override
  String get appLockOn => 'აპის დაბლოკვა ჩართულია';

  @override
  String get appLockOff => 'აპის დაბლოკვა გამორთულია';

  @override
  String get avatarSet => 'ფოტოს არჩევა';

  @override
  String get avatarChange => 'ფოტოს შეცვლა';

  @override
  String get avatarView => 'ფოტოს ნახვა';

  @override
  String get profileCoverPhoto => 'პროფილის ფოტო, ორჯერ შეხებით გადიდდება';

  @override
  String get profileCoverMenu => 'ფოტოს მოქმედებები';

  @override
  String get avatarSaved => 'შენახულია გალერეაში';

  @override
  String get avatarRemove => 'ფოტოს წაშლა';

  @override
  String get avatarRemoveConfirm =>
      'ავატარი წაიშლება ამ მოწყობილობიდან. მის ადგილას დაბრუნდება გენერირებული გრადიენტი.';

  @override
  String get avatarFailed => 'გამოსახულების წაკითხვა ვერ მოხერხდა';

  @override
  String get fileOpenHint => 'შეეხეთ გასახსნელად';

  @override
  String get fileMissing => 'ეს ფაილი აღარ არის ხელმისაწვდომი';

  @override
  String get fileNoHandlerTitle => 'ამის გამხსნელი აპი არ არის';

  @override
  String get fileNoHandlerHint =>
      'არცერთი დაინსტალირებული აპი ამ ტიპის ფაილს ვერ ხსნის. სამაგიეროდ, შეგიძლიათ სხვა აპში გაგზავნოთ.';

  @override
  String get fileRequestedAgain => 'გამგზავნს ხელახლა ვთხოვეთ';

  @override
  String get fileOpenFailed => 'ამ ფაილის გახსნა ვერ მოხერხდა';

  @override
  String get fileShareAction => 'აპში გაგზავნა';

  @override
  String fileTooLargeMesh(int limit) {
    return 'ფაილი ძალიან დიდია — mesh-ით ლიმიტი $limit მბ-ია';
  }

  @override
  String fileTooLargeRelay(int limit) {
    return 'ინტერნეტით ლიმიტი $limit მბ-ია. უფრო დიდი ფაილის გასაგზავნად მიუახლოვდით მიმღებს.';
  }

  @override
  String get mediaSendOriginal => 'ორიგინალი';

  @override
  String get attachFile => 'ფაილი';

  @override
  String get attachGallery => 'გალერეა';

  @override
  String get attachCamera => 'კამერა';

  @override
  String get cameraUnavailable => 'კამერა მიუწვდომელია';

  @override
  String get profileEditName => 'სახელი';

  @override
  String get profileMyCard => 'ბარათი';

  @override
  String get mediaCaptionHint => 'წარწერის დამატება…';

  @override
  String get mediaDiscardTitle => 'გაუქმდეს არჩევანი?';

  @override
  String get mediaDiscardMessage =>
      'დაიხუროს გალერეა და გაუქმდეს არჩეული ფოტოები?';

  @override
  String get mediaDiscardConfirm => 'გაუქმება';

  @override
  String get mediaPhotosAccessOff => 'ფოტოებზე წვდომა გამორთულია';

  @override
  String get mediaPhotosAccessOffHint =>
      'CubeChat ახლა მხოლოდ ვიდეოებს ხედავს. სურათების საჩვენებლად დაუშვით ფოტოებზე წვდომა სისტემის პარამეტრებში.';

  @override
  String get mediaVideosOnly =>
      'ჩანს მხოლოდ ვიდეოები — დაუშვით ფოტოებზე წვდომა';

  @override
  String get mediaOpenSettings => 'პარამეტრების გახსნა';

  @override
  String get mediaTakePhoto => 'ფოტოს გადაღება';

  @override
  String get contactProfileAutoDelete => 'ჩატის ავტოწაშლა';

  @override
  String get contactProfileAutoDeleteTitle => 'შეტყობინებების ავტოწაშლა';

  @override
  String get contactProfileAutoDeleteOff => 'გამორთულია';

  @override
  String get contactProfileAutoDeleteOneDay => '1 დღის შემდეგ';

  @override
  String get contactProfileAutoDeleteSevenDays => '7 დღის შემდეგ';

  @override
  String get contactProfileAutoDeleteThirtyDays => '30 დღის შემდეგ';

  @override
  String contactProfileAutoDeleteUpdated(String period) {
    return 'ავტოწაშლა: $period';
  }

  @override
  String get contactProfileShare => 'კონტაქტის გაზიარება';

  @override
  String get contactProfileShareTitle => 'კონტაქტის გაგზავნა';

  @override
  String get contactProfileShareEmpty => 'სხვა ჩატები ჯერ არ არის';

  @override
  String contactProfileShareSent(String name) {
    return 'გაეგზავნა: $name';
  }

  @override
  String get contactProfileRestrictCopying => 'კოპირების აკრძალვა';

  @override
  String get contactProfileAllowCopying => 'კოპირების დაშვება';

  @override
  String get contactHideAvatar => 'ჩემი ფოტოს დამალვა';

  @override
  String get contactShowAvatar => 'ჩემი ფოტოს ჩვენება';

  @override
  String get contactHideLastSeen => 'ჩემი ბოლო ვიზიტის დამალვა';

  @override
  String get contactShowLastSeen => 'ჩემი ბოლო ვიზიტის ჩვენება';

  @override
  String get contactHideReadReceipts => 'ჩემი წაკითხვის დროის დამალვა';

  @override
  String get contactShowReadReceipts => 'ჩემი წაკითხვის დროის ჩვენება';

  @override
  String get contactHiddenFromThem => 'დამალულია ამ კონტაქტისგან';

  @override
  String get contactRefuseCalls => 'მისი ზარების აკრძალვა';

  @override
  String get contactAllowCalls => 'მისი ზარების მიღება';

  @override
  String get contactCallsException => 'გამონაკლისი თქვენი ზარების პარამეტრიდან';

  @override
  String get contactProfileCopyingRestricted =>
      'კოპირება და გადაგზავნა აკრძალულია';

  @override
  String get contactProfileCopyingRestrictedByPeer =>
      'აკრძალულია მოსაუბრის მიერ';

  @override
  String get contactProfileCopyingAllowed =>
      'კოპირება და გადაგზავნა დაშვებულია';

  @override
  String get contactProfileDelete => 'კონტაქტებიდან წაშლა';

  @override
  String get contactProfileRestore => 'კონტაქტებში დაბრუნება';

  @override
  String get contactProfileRestoreDone => 'ისევ თქვენს კონტაქტებშია';

  @override
  String get contactProfileDeleteTitle => 'წაიშალოს კონტაქტი?';

  @override
  String contactProfileDeleteMessage(String name) {
    return '$name გაქრება „კონტაქტებიდან“. ჩატის ისტორია ამ მოწყობილობაზე დარჩება.';
  }

  @override
  String get contactProfileMedia => 'მედია';

  @override
  String get contactProfileVoiceMessages => 'ხმოვანი შეტყობინებები';

  @override
  String get contactProfileStickers => 'სტიკერები';

  @override
  String get contactProfileNoStickers => 'სტიკერები ჯერ არ არის';

  @override
  String get contactProfileNoMedia => 'მედია ჯერ არ არის';

  @override
  String get contactProfileNoVoiceMessages =>
      'ხმოვანი შეტყობინებები ჯერ არ არის';

  @override
  String get contactProfileOpen => 'პროფილის გახსნა';

  @override
  String autoDeleteDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count დღე',
      one: '$count დღე',
    );
    return '$_temp0';
  }

  @override
  String autoDeleteHours(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count საათი',
      one: '$count საათი',
    );
    return '$_temp0';
  }

  @override
  String autoDeleteMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count წუთი',
      one: '$count წუთი',
    );
    return '$_temp0';
  }

  @override
  String autoDeleteSeconds(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count წამი',
      one: '$count წამი',
    );
    return '$_temp0';
  }

  @override
  String get autoDeleteCustom => 'სხვა…';

  @override
  String get autoDeleteCustomHint => 'რაოდენობა';

  @override
  String get autoDeleteUnitMinutes => 'წთ';

  @override
  String get autoDeleteUnitHours => 'სთ';

  @override
  String get autoDeleteUnitDays => 'დღე';

  @override
  String get contactProfileAutoDeleteSet => 'დაყენება';

  @override
  String get contactProfileFiles => 'ფაილები';

  @override
  String get contactProfileNoFiles => 'ფაილები ჯერ არ არის';

  @override
  String get contactProfileLinks => 'ბმულები';

  @override
  String get contactProfileNoLinks => 'ბმულები ჯერ არ არის';

  @override
  String get contactProfilePolls => 'გამოკითხვები';

  @override
  String get contactProfileNoPolls => 'გამოკითხვები ჯერ არ არის';

  @override
  String get presenceRecently => 'იყო ცოტა ხნის წინ';

  @override
  String get presenceJustNow => 'ახლახან';

  @override
  String presenceHoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'იყო $count საათის წინ',
      one: 'იყო $count საათის წინ',
    );
    return '$_temp0';
  }

  @override
  String presenceYesterdayAt(String time) {
    return 'იყო გუშინ, $time-ზე';
  }

  @override
  String presenceOnWeekday(String day) {
    String _temp0 = intl.Intl.selectLogic(
      day,
      {
        '1': 'იყო ორშაბათს',
        '2': 'იყო სამშაბათს',
        '3': 'იყო ოთხშაბათს',
        '4': 'იყო ხუთშაბათს',
        '5': 'იყო პარასკევს',
        '6': 'იყო შაბათს',
        '7': 'იყო კვირას',
        'other': 'იყო ამ კვირაში',
      },
    );
    return '$_temp0';
  }

  @override
  String presenceWeeksAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'იყო $count კვირის წინ',
      one: 'იყო ერთი კვირის წინ',
    );
    return '$_temp0';
  }

  @override
  String presenceMonthsAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'იყო $count თვის წინ',
      one: 'იყო ერთი თვის წინ',
    );
    return '$_temp0';
  }

  @override
  String get presenceLongAgo => 'იყო დიდი ხნის წინ';

  @override
  String presenceMinutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'იყო $count წუთის წინ',
      one: 'იყო $count წუთის წინ',
    );
    return '$_temp0';
  }

  @override
  String chatReadByCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'წაიკითხა $count-მა',
      one: 'წაიკითხა $count-მა',
    );
    return '$_temp0';
  }

  @override
  String get chatsSearchFrequent => 'ვისაც ესაუბრებით';

  @override
  String get chatsSearchRecent => 'ბოლოდროინდელი';

  @override
  String get chatsSearchClear => 'გასუფთავება';

  @override
  String get chatsSearchStartHint =>
      'მოძებნეთ ჩატები სახელით ან ნებისმიერი შეტყობინება სიტყვებით.';

  @override
  String get chatsSearchEmpty => 'ვერაფერი მოიძებნა';

  @override
  String get chatRoutesTitle => 'როგორ მიაღწევს მას';

  @override
  String get chatRoutesBluetoothHint =>
      'პირდაპირ მის ტელეფონზე, ინტერნეტის გარეშე';

  @override
  String get chatRoutesMeshHint => 'გადაეცემა თქვენ შორის მყოფი ტელეფონებით';

  @override
  String get chatRoutesInternetHint => 'რელეთი, როცა ახლოს არავინ არის';

  @override
  String get chatRoutesHint =>
      'გზა თითოეული შეტყობინებისთვის ცალკე ირჩევა, იმისგან, რაც იმ მომენტში ხელმისაწვდომია.';

  @override
  String get chatRoutesPreferTitle => 'რა ვცადოთ პირველად';

  @override
  String get chatRoutesPreferMesh => 'ჯერ Bluetooth';

  @override
  String get chatRoutesPreferMeshHint =>
      'ერთ ოთახში უფრო სწრაფია, ტრაფიკს არ ხარჯავს და რელეს არაფერს ეუბნება';

  @override
  String get chatRoutesPreferRelay => 'ჯერ ინტერნეტი';

  @override
  String get chatRoutesPreferRelayHint =>
      'როცა Bluetooth სუსტია, კავშირი კი კარგი';

  @override
  String get chatRoutesPreferNote =>
      'ეს უპირატესობაა და არა აკრძალვა. თუ არჩეული გზა მიუწვდომელია, შეტყობინება მაინც მეორე გზით წავა.';

  @override
  String get deadmanTitle => 'წაშლა, თუ არ გამოიყენება';

  @override
  String get deadmanOff => 'გამორთულია';

  @override
  String deadmanDays(int days) {
    return '$days დღის შემდეგ';
  }

  @override
  String get deadmanHint =>
      'თუ ამ აპს ამდენ ხანს არავინ გახსნის, მასზე ყველაფერი წაიშლება შემდეგი გახსნისას. ის წინასწარ ვერ გაგაფრთხილებთ — სწორედ ესაა მისი აზრი.';

  @override
  String chatForwardedFrom(String name) {
    return 'გადაგზავნილია: $name';
  }

  @override
  String appLockWait(String left) {
    return 'ძალიან ბევრი მცდელობა — დაელოდეთ $left';
  }

  @override
  String get appLockGraceTitle => 'კოდის მოთხოვნა';

  @override
  String get appLockGraceNow => 'ყოველ ჯერზე';

  @override
  String appLockGraceAfter(String left) {
    return '$left არყოფნის შემდეგ';
  }

  @override
  String get chatCalendarTitle => 'თარიღის მიხედვით';

  @override
  String get chatCalendarEmpty => 'აქ ჯერ არაფერი თქმულა';

  @override
  String get chatsSearchChatsSection => 'ჩატები';

  @override
  String get chatsSearchMessagesSection => 'შეტყობინებები';

  @override
  String get contactProfileViewInChat => 'ჩატში ნახვა';

  @override
  String get chatDraft => 'მონახაზი';

  @override
  String get chatSearchTitle => 'ძიება';

  @override
  String get chatSearchHint => 'შეტყობინებებში ძიება';

  @override
  String get chatSearchNoResults => 'ვერაფერი მოიძებნა';

  @override
  String get chatSearchPrevious => 'წინა შედეგი';

  @override
  String get chatSearchNext => 'შემდეგი შედეგი';

  @override
  String chatMessageCount(int count) {
    return '$count შეტყობინება';
  }

  @override
  String get chatRouteBluetooth => 'Bluetooth';

  @override
  String get chatRouteMesh => 'Mesh';

  @override
  String get chatRouteInternet => 'ინტერნეტი';

  @override
  String get chatRouteQueued => 'რიგშია';

  @override
  String get attachStickers => 'სტიკერები';

  @override
  String get stickersEmpty => 'სტიკერები ჯერ არ არის';

  @override
  String get stickersEmptyHint =>
      'შეინახეთ სურათი ჩატიდან და ის აქ გამოჩნდება.';

  @override
  String get stickerKeep => 'სტიკერად შენახვა';

  @override
  String get stickerKept => 'შენახულია თქვენს სტიკერებში';

  @override
  String get stickerForget => 'სტიკერის წაშლა';

  @override
  String get stickerCreate => 'სტიკერის შექმნა ფოტოდან';

  @override
  String get stickerFailed => 'ამ სურათიდან სტიკერის შექმნა ვერ მოხერხდა';

  @override
  String get stickerLabel => 'სტიკერი';

  @override
  String get previewPhoto => 'ფოტო';

  @override
  String get previewVoice => 'ხმოვანი შეტყობინება';

  @override
  String get previewFile => 'ფაილი';

  @override
  String get stickerEmojiTitle => 'აირჩიეთ მისთვის ემოჯი';

  @override
  String get stickersMine => 'ჩემი სტიკერები';

  @override
  String get stickersStarterPack => 'კუბი';

  @override
  String get emojiTab => 'ემოჯი';

  @override
  String get chatBlockedStatus => 'დაბლოკილია';

  @override
  String get chatBlockedHint => 'თქვენ დაბლოკეთ ეს ადამიანი';

  @override
  String get chatRouteFallbackOff => 'ინტერნეტი გამორთ.';

  @override
  String get chatAttachmentUnavailable =>
      'კავშირი მიუწვდომელია. დაუკავშირდით Bluetooth-ით ან ინტერნეტით და სცადეთ ხელახლა.';

  @override
  String get fileTransfersTitle => 'ფაილების გადაცემა';

  @override
  String get fileTransfersClear => 'ისტორიის გასუფთავება';

  @override
  String get fileTransfersEmpty => 'ფაილების გადაცემები ჯერ არ არის';

  @override
  String get fileTransfersActive => 'აქტიური';

  @override
  String get fileTransfersHistory => 'ისტორია';

  @override
  String get fileTransferPause => 'პაუზა';

  @override
  String get fileTransferResume => 'გაგრძელება';

  @override
  String get fileTransferRetry => 'ხელახლა';

  @override
  String get fileTransferQueued => 'კავშირს ელოდება';

  @override
  String get fileTransferRunning => 'გადაიცემა';

  @override
  String get fileTransferPaused => 'შეჩერებულია';

  @override
  String get fileTransferCompleted => 'დასრულდა';

  @override
  String get fileTransferFailed => 'შეცდომა';

  @override
  String get fileTransferCanceled => 'გაუქმდა';

  @override
  String get profileFileTransfers => 'ფაილების გადაცემა';

  @override
  String get profileFileTransfersSubtitle =>
      'პროგრესი, რიგი და გადაცემების ისტორია';

  @override
  String get qrScanAction => 'QR-კოდის სკანირება';

  @override
  String get qrScanTitle => 'QR-კოდის სკანირება';

  @override
  String get qrScanHint =>
      'დაასკანირეთ CubeChat-ის კონტაქტის, არხის, ანგარიშის გადატანის ან კომპიუტერთან დაკავშირების კოდი.';

  @override
  String get qrFlash => 'ფანარი';

  @override
  String get qrCameraError =>
      'კამერა მიუწვდომელია. შეამოწმეთ კამერის ნებართვა და სცადეთ ხელახლა.';

  @override
  String get qrInvalid => 'ეს არ არის სწორი Cubechat-ის QR-კოდი.';

  @override
  String qrChannelAdded(String name) {
    return '$name დაემატა';
  }

  @override
  String get qrShow => 'QR-კოდის ჩვენება';

  @override
  String qrChannelTitle(String name) {
    return 'შესვლა: $name';
  }

  @override
  String get profileBackup => 'დაშიფრული სარეზერვო ასლი';

  @override
  String get profileBackupSubtitle =>
      'გასაღებების, კონტაქტებისა და ისტორიის უსაფრთხო გადატანა';

  @override
  String get backupTitle => 'დაშიფრული სარეზერვო ასლი';

  @override
  String get backupExplainer =>
      'სარეზერვო ასლი შეიცავს თქვენს პირად საიდენტიფიკაციო გასაღებებს, კონტაქტებს, არხებს, პარამეტრებსა და შეტყობინებების ისტორიას. ის ამ ტელეფონზე იშიფრება თქვენ მიერ არჩეული პაროლით; Cubechat დავიწყებულ პაროლს ვერ აღადგენს.';

  @override
  String get backupCreate => 'ასლის შექმნა';

  @override
  String get backupCreateSubtitle =>
      'ყველაფრის დაშიფვრა და .cchatbackup ფაილის შენახვა';

  @override
  String get backupRestore => 'ასლის აღდგენა';

  @override
  String get backupRestoreSubtitle =>
      'ამ ტელეფონზე Cubechat-ის პროფილის ჩანაცვლება ასლის ფაილიდან';

  @override
  String get backupPasswordTitle => 'სარეზერვო ასლის პაროლი';

  @override
  String get backupPasswordHint => 'მინიმუმ 8 სიმბოლო';

  @override
  String get backupConfirmPassword => 'გაიმეორეთ პაროლი';

  @override
  String get backupPasswordMismatch => 'პაროლები არ ემთხვევა';

  @override
  String get backupPasswordShort => 'გამოიყენეთ მინიმუმ 8 სიმბოლო';

  @override
  String get backupSaveTitle => 'Cubechat-ის სარეზერვო ასლის შენახვა';

  @override
  String get backupSaved => 'დაშიფრული ასლი შენახულია';

  @override
  String get backupWhereTitle => 'სად შევინახოთ ასლი?';

  @override
  String get backupSaveToFiles => 'ფაილებში შენახვა';

  @override
  String get backupSaveToFilesHint =>
      'საქაღალდე ამ ტელეფონზე, მეხსიერების ბარათი ან ღრუბლოვანი დისკი';

  @override
  String get backupSendToApp => 'აპში გაგზავნა';

  @override
  String get backupSendToAppHint =>
      'Telegram, ფოსტა, მესენჯერი — ყველაფერი, რაც ფაილებს იღებს';

  @override
  String get backupFailed => 'სარეზერვო ასლის ოპერაციის დასრულება ვერ მოხერხდა';

  @override
  String get backupRestoreConfirmTitle => 'ჩანაცვლდეს ეს პროფილი?';

  @override
  String get backupRestoreConfirmMessage =>
      'ამ ტელეფონზე არსებული გასაღებები, კონტაქტები, არხები, პარამეტრები და ისტორია ჩანაცვლდება არჩეული სარეზერვო ასლით.';

  @override
  String get backupRestoreConfirmAction => 'აღდგენა';

  @override
  String get backupRestored => 'სარეზერვო ასლი აღდგა';

  @override
  String get backupPackingWait => 'სარეზერვო ასლი იქმნება…';

  @override
  String get backupUnpackingWait => 'სარეზერვო ასლი აღდგება…';

  @override
  String get backupWaitHint =>
      'ფოტოებითა და ვიდეოებით ამას შეიძლება რამდენიმე წუთი დასჭირდეს. არ დახუროთ აპი.';

  @override
  String get backupInvalid =>
      'არასწორი პაროლი, დაზიანებული ფაილი ან მხარდაუჭერელი ასლი';

  @override
  String get channelInfoTitle => 'არხის შესახებ';

  @override
  String get channelParticipantsTitle => 'მონაწილეები';

  @override
  String get channelAdministratorsTitle => 'ადმინისტრატორები';

  @override
  String get channelMakeAdmin => 'ადმინისტრატორად დანიშვნა';

  @override
  String get channelRemoveAdmin => 'ადმინისტრატორობის მოხსნა';

  @override
  String get channelNoParticipants =>
      'მონაწილეები ხელმოწერილი აქტივობის შემდეგ გამოჩნდებიან';

  @override
  String get channelSharedContent => 'მედია, ფაილები და გამოკითხვები';

  @override
  String get channelDescriptionTitle => 'აღწერა';

  @override
  String get channelDescriptionEmpty => 'აღწერა ჯერ არ არის';

  @override
  String get channelDescriptionHint => 'რისთვისაა ეს არხი';

  @override
  String get channelDescriptionAdminOnly =>
      'აღწერის შეცვლა მხოლოდ ადმინისტრატორს შეუძლია';

  @override
  String get channelDescriptionSave => 'შენახვა';

  @override
  String get channelPrivateSubtitle => 'პირადი არხი';

  @override
  String get channelAvatarSet => 'ახალი ფოტოს დაყენება';

  @override
  String get channelSettingsTitle => 'არხის პარამეტრები';

  @override
  String get channelSettingsHint => 'ვის შეუძლია წერა, კოპირება, ისტორია';

  @override
  String get channelLeaveAction => 'გასვლა';

  @override
  String get channelLeaveConfirm =>
      'ოთახი და მასში თქმული ყველაფერი ამ ტელეფონიდან გაქრება. გასაღები სახელიდან მოდის, ასე რომ, იმავე სახელის აკრეფით მისი ხელახლა გახსნა შეგიძლიათ.';

  @override
  String get channelShareAction => 'გაზიარება';

  @override
  String channelMembersOf(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count მონაწილე',
      one: '1 მონაწილე',
    );
    return '$_temp0';
  }

  @override
  String get chatTyping => 'წერს…';

  @override
  String get chatRecordingVoice => 'ხმოვანს იწერს…';

  @override
  String get chatRecordingCircle => 'ვიდეოშეტყობინებას იწერს…';

  @override
  String get chatSendingPhoto => 'ფოტოს აგზავნის…';

  @override
  String get chatSendingVideo => 'ვიდეოს აგზავნის…';

  @override
  String get chatSendingFile => 'ფაილს აგზავნის…';

  @override
  String get onboardingMeshTitle => 'მუშაობს ინტერნეტის გარეშე';

  @override
  String get onboardingMeshBody =>
      'შეტყობინებები Bluetooth-ით მოგზაურობს, ტელეფონიდან ტელეფონზე. არც სიგნალი, არც Wi-Fi, არც ანგარიშები — მხოლოდ ხალხი თქვენ გარშემო.';

  @override
  String get onboardingRelayTitle => 'და ინტერნეტითაც, როცა ის არის';

  @override
  String get onboardingRelayBody =>
      'Bluetooth-ის ზონის გარეთ შეტყობინებები ინტერნეტით მიდის და ისევე აღწევს ადრესატს. არჩევა არასოდეს გიწევთ.';

  @override
  String get onboardingPrivacyTitle => 'შუაში ვერავინ წაიკითხავს';

  @override
  String get onboardingPrivacyBody =>
      'ყველაფერი ბოლომდე დაშიფრულია, თქვენი ვინაობა კი ამ ტელეფონზე არსებული გასაღებია — არა ტელეფონის ნომერი, არა ელფოსტა, არა ანგარიში, რომლის წართმევაც ვინმეს შეუძლია.';

  @override
  String get onboardingSkip => 'გამოტოვება';

  @override
  String get onboardingNext => 'შემდეგი';

  @override
  String get onboardingStart => 'დაწყება';

  @override
  String get chatMediaShare => 'გაზიარება';

  @override
  String get chatMediaSaveToGallery => 'გალერეაში შენახვა';

  @override
  String get chatMediaShowInChat => 'ჩატში ჩვენება';

  @override
  String get chatWallpaperTitle => 'ფონი';

  @override
  String get chatWallpaperClear => 'ჩამოყრა';

  @override
  String get chatWallpaperDim => 'შეტყობინებების უკან დაბნელება';

  @override
  String get chatSelectAction => 'არჩევა';

  @override
  String get chatForwardNothing => 'აქ გადასაგზავნი არაფერია';

  @override
  String chatSelectedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'არჩეულია $count',
      one: 'არჩეულია 1',
    );
    return '$_temp0';
  }

  @override
  String chatDeleteSelectedTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'წაიშალოს $count შეტყობინება?',
      one: 'წაიშალოს ეს შეტყობინება?',
    );
    return '$_temp0';
  }

  @override
  String get contactAliasAction => 'კონტაქტის გადარქმევა';

  @override
  String get contactAliasHint =>
      'ამ სახელს მხოლოდ თქვენ ხედავთ. დატოვეთ ცარიელი, რომ მისი სახელი გამოჩნდეს.';

  @override
  String get viewOnceSendLabel => 'ერთჯერადი';

  @override
  String get viewOnceTitle => 'ერთჯერადი ნახვა';

  @override
  String get viewOnceTapToView => 'ფოტო · შეეხეთ ერთხელ სანახავად';

  @override
  String get viewOnceSent => 'ფოტო · გაიგზავნა';

  @override
  String get viewOnceOpened => 'ფოტო ნანახია';

  @override
  String get viewOnceUnavailable => 'ეს ფოტო აღარ არის ხელმისაწვდომი';

  @override
  String get viewOnceWarning => 'დახურვისას ფოტო ორივესთან წაიშლება.';

  @override
  String get channelAvatarAdminOnly =>
      'არხის ფოტოს შეცვლა მხოლოდ ადმინისტრატორს შეუძლია';

  @override
  String get channelAdminOnly => 'ამის შეცვლა მხოლოდ ადმინისტრატორს შეუძლია';

  @override
  String get channelAvatarTooLarge => 'ეს ფოტო ძალიან დიდია გასავრცელებლად';

  @override
  String get channelMemberUnknown => 'ჯერ არ არის თქვენს კონტაქტებში';

  @override
  String get channelInviteToContacts => 'საკონტაქტო ბარათის გაგზავნა';

  @override
  String channelContactInviteSent(String name) {
    return 'საკონტაქტო ბარათი შესთავაზეთ: $name';
  }

  @override
  String get chatContactInvitation => 'კონტაქტად დამატების მოწვევა';

  @override
  String get chatContactInvitationForYou => 'მოწვევა თქვენთვის';

  @override
  String get channelPollTitle => 'გამოკითხვა';

  @override
  String get channelCreatePoll => 'გამოკითხვის შექმნა';

  @override
  String get channelPollQuestion => 'კითხვა';

  @override
  String channelPollOption(int number) {
    return 'ვარიანტი $number';
  }

  @override
  String get channelPollAddOption => 'ვარიანტის დამატება';

  @override
  String get channelPollCreate => 'გამოქვეყნება';

  @override
  String channelPollVotes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ხმა',
      one: '1 ხმა',
      zero: 'ხმები არ არის',
    );
    return '$_temp0';
  }

  @override
  String get phoneTransferTitle => 'ახალ ტელეფონზე გადატანა';

  @override
  String get desktopPickChat => 'აირჩიეთ, ვის მისწერდით';

  @override
  String get desktopListCollapse => 'მხოლოდ ავატარები';

  @override
  String get desktopListExpand => 'ჩატების სიის ჩვენება';

  @override
  String get desktopLinkConnectTitle => 'კომპიუტერის დაკავშირება';

  @override
  String get desktopLinkConnectHint =>
      'დაასკანირეთ კოდი, რომელსაც CubeChat კომპიუტერზე აჩვენებს';

  @override
  String get desktopLinkSignIn => 'შესვლა ტელეფონის ანგარიშით';

  @override
  String get desktopLinkTitle => 'შესვლა ტელეფონით';

  @override
  String get desktopLinkSteps =>
      'ტელეფონზე: პროფილი → მონაცემები → „კომპიუტერის დაკავშირება“, შემდეგ დაასკანირეთ ეს კოდი. ორივე ერთსა და იმავე Wi-Fi-ზე უნდა იყოს.';

  @override
  String get desktopLinkLimits =>
      'ტელეფონი განაგრძობს მუშაობას. ინტერნეტიდან შეტყობინებები ორივეზე მოდის; ერთიდან გაგზავნილი მეორეზე ჯერ არ ჩანს.';

  @override
  String get desktopLinkWaiting => 'ტელეფონს ველოდებით…';

  @override
  String get desktopLinkFailed =>
      'ანგარიშის მიღება ვერ მოხერხდა. სცადეთ ხელახლა.';

  @override
  String get desktopLinkRetry => 'ხელახლა ცდა';

  @override
  String get desktopLinkConfirmTitle =>
      'გაეგზავნოს ამ ანგარიშის ასლი კომპიუტერს?';

  @override
  String get desktopLinkConfirmMessage =>
      'კომპიუტერი მიიღებს თქვენს გასაღებებს, კონტაქტებსა და ჩატებს. ეს ტელეფონი ისევე იმუშავებს, როგორც აქამდე.';

  @override
  String get desktopLinkConfirmAction => 'გაგზავნა';

  @override
  String desktopLinkConfirmWhere(String address) {
    return 'მხოლოდ იმ შემთხვევაში, თუ ეს კოდი ახლახან საკუთარი კომპიუტერის ეკრანიდან დაასკანირეთ. ასლი გაიგზავნება $address-ზე ამ ქსელში.';
  }

  @override
  String get desktopLinkSending => 'ანგარიში იგზავნება…';

  @override
  String get desktopLinkSent => 'კომპიუტერი დაკავშირებულია';

  @override
  String get desktopLinkPhoneFound =>
      'ტელეფონმა იპოვა ეს კომპიუტერი და ანგარიშის ასლს ამზადებს. ფოტოებით ამას შეიძლება რამდენიმე წუთი დასჭირდეს.';

  @override
  String desktopLinkReceiving(int percent) {
    return 'ანგარიშის მიღება: $percent%';
  }

  @override
  String get desktopLinkRestoring => 'ანგარიში ამ კომპიუტერზე აღდგება…';

  @override
  String get desktopLinkFinding => 'კომპიუტერის ძიება…';

  @override
  String get desktopLinkPreparing =>
      'ანგარიშის ასლი მზადდება. ფოტოებით ამას შეიძლება რამდენიმე წუთი დასჭირდეს.';

  @override
  String desktopLinkSendingPercent(int percent) {
    return 'იგზავნება: $percent%';
  }

  @override
  String get desktopLinkComputerRestoring => 'კომპიუტერი ანგარიშს აღადგენს…';

  @override
  String get devicesTitle => 'მოწყობილობები';

  @override
  String get devicesRowHint =>
      'სად არის გახსნილი თქვენი ანგარიში და იქიდან გამოსვლა';

  @override
  String get devicesThisDevice => 'ეს მოწყობილობა';

  @override
  String get devicesSeenNow => 'ონლაინ იყო ახლახან';

  @override
  String devicesSeenMinutes(int n) {
    return 'ონლაინ იყო $n წთ-ის წინ';
  }

  @override
  String devicesSeenHours(int n) {
    return 'ონლაინ იყო $n სთ-ის წინ';
  }

  @override
  String devicesSeenDays(int n) {
    return 'ონლაინ იყო $n დღის წინ';
  }

  @override
  String get devicesLeaving => 'გამოდის — ველოდებით, როდის გამოჩნდება ონლაინ';

  @override
  String get devicesSignOut => 'გამოსვლა';

  @override
  String get devicesSignOutAll => 'ყველა სხვა მოწყობილობიდან გამოსვლა';

  @override
  String devicesSignOutTitle(String name) {
    return 'გამოხვიდეთ „$name“-ზე?';
  }

  @override
  String get devicesSignOutMessage =>
      'CubeChat-ის გასაღებები, ჩატები და პარამეტრები იმ მოწყობილობაზე წაიშლება, როგორც კი ის ონლაინ გამოჩნდება. ანგარიში დარჩება აქ და თქვენს სხვა მოწყობილობებზე.';

  @override
  String get devicesSignOutPhoneMessage =>
      'ეს ტელეფონია: CubeChat მასზე მთლიანად წაიშლება. ანგარიში დარჩება აქ და თქვენს სხვა მოწყობილობებზე.';

  @override
  String get devicesSignOutAllMessage =>
      'ყველა სხვა მოწყობილობა გამოვა, როგორც კი ონლაინ გამოჩნდება. ანგარიში მხოლოდ აქ დარჩება.';

  @override
  String get devicesRename => 'გადარქმევა';

  @override
  String get devicesRenameTitle => 'ამ მოწყობილობის სახელი';

  @override
  String get devicesSave => 'შენახვა';

  @override
  String get devicesEmpty =>
      'სხვა მოწყობილობები ჯერ არ არის. მოწყობილობა აქ გამოჩნდება, როცა CubeChat 1.0.0+1147 ან უფრო ახალ ვერსიას გახსნის.';

  @override
  String get devicesCaveat =>
      'გამოსვლა ძალაში შედის, როცა ის მოწყობილობა ონლაინ გამოვა. ოფლაინ დატოვებული მოწყობილობა გასაღებებს შეინარჩუნებს; სრული დაცვისთვის ანგარიშს ახალი გასაღებები სჭირდება.';

  @override
  String get desktopLinkImportTitle => 'ანგარიშის გადმოტანა ტელეფონიდან';

  @override
  String get desktopLinkImportHint =>
      'აჩვენეთ ტელეფონს კოდი და ეს კომპიუტერი მისი ანგარიშის ასლი გახდება';

  @override
  String get desktopLinkImportConfirmTitle =>
      'ჩანაცვლდეს ანგარიში ამ კომპიუტერზე?';

  @override
  String get desktopLinkImportConfirmMessage =>
      'ამ კომპიუტერის გასაღებები, კონტაქტები და ჩატები ტელეფონის ანგარიშით ჩანაცვლდება. თუ ეს ანგარიში ჯერ კიდევ გჭირდებათ, ჯერ სარეზერვო ასლი შექმენით.';

  @override
  String get desktopLinkImportConfirmAction => 'გაგრძელება';

  @override
  String get desktopLinkUnreachable =>
      'კომპიუტერთან დაკავშირება ვერ მოხერხდა. ორივე ერთსა და იმავე Wi-Fi-ზე უნდა იყოს, კომპიუტერზე კი CubeChat ბრანდმაუერში უნდა იყოს დაშვებული.';

  @override
  String get desktopLinkFirewallHint =>
      'Windows-მა შეიძლება ტელეფონი ამ კომპიუტერთან არ შემოუშვას. დაუშვით CubeChat ბრანდმაუერში — მხოლოდ თქვენი ლოკალური ქსელისთვის.';

  @override
  String get desktopLinkFirewallAllow => 'ბრანდმაუერში დაშვება';

  @override
  String get desktopLinkFirewallDeclined =>
      'Windows-მა არ დაუშვა. ამის გარეშე ტელეფონი შეიძლება ვერ დაუკავშირდეს.';

  @override
  String get phoneTransferIntro =>
      'გადაიტანეთ პროფილი, გასაღებები, კონტაქტები, არხები, პარამეტრები და ისტორია პირდაპირ ორ ტელეფონს შორის.';

  @override
  String get phoneTransferSend => 'ეს ძველი ტელეფონია';

  @override
  String get phoneTransferReceive => 'ეს ახალი ტელეფონია';

  @override
  String get phoneTransferSameWifi =>
      'დააკავშირეთ ორივე ტელეფონი ერთსა და იმავე Wi-Fi-ს და არ დახუროთ ეს ეკრანი გადატანის დასრულებამდე.';

  @override
  String get phoneTransferPreparing => 'დაშიფრული გადატანა მზადდება…';

  @override
  String get phoneTransferReady =>
      'დაასკანირეთ ეს ერთჯერადი QR-კოდი ახალ ტელეფონზე';

  @override
  String get phoneTransferScan => 'ძველი ტელეფონის სკანირება';

  @override
  String get phoneTransferConfirmTitle => 'ჩანაცვლდეს ამ ტელეფონის პროფილი?';

  @override
  String get phoneTransferConfirmMessage =>
      'ამ ტელეფონზე შენახული პროფილი ჩანაცვლდება დაშიფრული ლოკალური გადატანით.';

  @override
  String get phoneTransferConfirmAction => 'პროფილის გადატანა';

  @override
  String get phoneTransferSuccess => 'პროფილი წარმატებით გადაიტანა';

  @override
  String get phoneTransferFailed =>
      'ტელეფონის გადატანის დასრულება ვერ მოხერხდა';

  @override
  String get profileSummaryMeshOnly => 'მხოლოდ mesh';

  @override
  String get profileSummaryMeshInternet => 'Mesh · ინტერნეტი';

  @override
  String get profileSummaryBackgroundOn => 'მუშაობს ფონურად';

  @override
  String profileSummaryTransfersActive(int count) {
    return '$count მიმდინარეობს';
  }

  @override
  String get profileSummaryCardBackup => 'ფაილები, ასლი';

  @override
  String get chatPlay => 'დაკვრა';

  @override
  String get chatPause => 'პაუზა';

  @override
  String get profileTheme => 'ფერი';

  @override
  String get profileThemeEmerald => 'ზურმუხტი';

  @override
  String get profileThemeIndigo => 'ინდიგო';

  @override
  String get profileThemeAmber => 'ქარვა';

  @override
  String get profileThemeRose => 'ვარდი';

  @override
  String get profileThemeFuchsia => 'ფუქსია';

  @override
  String get profileThemeViolet => 'იისფერი';

  @override
  String get profileThemeOcean => 'ოკეანე';

  @override
  String get profileThemeSlate => 'გრაფიტი';

  @override
  String get profileScale => 'ინტერფეისის ზომა';

  @override
  String get profileScaleSystem => 'სისტემური';

  @override
  String get profileGlass => 'მინა';

  @override
  String get profileGlassAuto => 'ავტომატური';

  @override
  String get profileGlassFull => 'სრული';

  @override
  String get profileGlassLight => 'მსუბუქი';

  @override
  String get profileGlassHint =>
      'მსუბუქი ინარჩუნებს შეფერილობას და პანელების უკან გაბუნდოვნებას აშორებს. ავტომატური ერთხელ ზომავს თქვენს ტელეფონს და თავად წყვეტს. ტელეფონზე, რომელიც ისედაც ასწრებს, ამას დიდი სარგებელი არ აქვს — ეს იმისთვისაა, რომელიც ვერ ასწრებს.';

  @override
  String get mapAlwaysNeeded =>
      'რომ რუკა განახლდეს, როცა cubechat დახურულია, მდებარეობა „ყოველთვის“-ზე უნდა იყოს დაყენებული. შეეხეთ პარამეტრების გასახსნელად.';

  @override
  String get mapShareConsentTitle => 'ვაჩვენოთ თქვენი მდებარეობა რუკაზე?';

  @override
  String get mapShareConsentBody =>
      'თქვენს რეალურ დროის მდებარეობას მხოლოდ თქვენი რუკის კონტაქტები დაინახავენ: ვინც მოიწვიეთ, ან ვისი მოწვევაც მიიღეთ. ის განახლდება, მათ შორის მაშინაც, როცა Cubechat ფონურ რეჟიმშია, სანამ არ დაიმალებით. ის ბოლომდე დაშიფრულია და ჩვენამდე არასოდეს აღწევს. დამალვა ნებისმიერ დროს შეგიძლიათ რუკაზე ან პროფილში, დაბლოკილი კონტაქტები კი ვერასოდეს დაგინახავენ.';

  @override
  String get mapShareConsentAllow => 'დაშვება';

  @override
  String get mapShareConsentDecline => 'არ დაიშვას';

  @override
  String get mapVisibleToFriends => 'რუკაზე მეგობრები გხედავენ';

  @override
  String get mapHiddenFromFriends => 'თქვენ დამალული ხართ';

  @override
  String get mapHideMe => 'დამალვა';

  @override
  String get mapShowMe => 'მაჩვენე';

  @override
  String get profileScaleSmall => 'პატარა';

  @override
  String get profileScaleNormal => 'ჩვეულებრივი';

  @override
  String get profileScaleLarge => 'დიდი';

  @override
  String get profileScaleSample => 'ტექსტი და სტრიქონები ამ ზომით გამოისახება.';

  @override
  String get savedTitle => 'შენახული';

  @override
  String get savedSubtitle => 'ჩანაწერები საკუთარი თავისთვის, ამ მოწყობილობაზე';

  @override
  String get savedEmpty => 'რასაც აქ დაწერთ, ამ ტელეფონზე დარჩება.';

  @override
  String get meshOffTitle => 'Bluetooth mesh გამორთულია';

  @override
  String get meshOffHint =>
      'ახლოს მყოფები ვერ გიპოვიან და ვერც თქვენ იპოვით მათ. შეტყობინებები ისევ ინტერნეტ-რელეთი მიდის.';

  @override
  String get profileMeshSwitch => 'Bluetooth mesh';

  @override
  String get profileMeshSwitchHint =>
      'პოულობს ახლოს მყოფ ხალხს და შეტყობინებებს ინტერნეტის გარეშე გადასცემს. გამორთვა ბატარეას ზოგავს.';

  @override
  String get channelAdminOnlyHint =>
      'განცხადებების არხი. წაკითხვა ყველას შეუძლია.';

  @override
  String get attachLocation => 'მდებარეობა';

  @override
  String get locationBubbleTitle => 'მდებარეობა';

  @override
  String get locationOpenInMaps => 'რუკებში გახსნა';

  @override
  String locationAccuracy(int metres) {
    return '$metres მ სიზუსტით';
  }

  @override
  String get locationExpired => 'ეს მდებარეობა აღარ არის აქტუალური';

  @override
  String get locationDenied => 'მდებარეობის ნებართვა გამორთულია';

  @override
  String get locationUnavailable => 'მდებარეობის დადგენა ვერ მოხერხდა';

  @override
  String get locationShareFor => 'გაზიარების ხანგრძლივობა';

  @override
  String get locationShareOnce => 'ერთჯერადად';

  @override
  String get locationShare15m => '15 წუთი';

  @override
  String get locationShare1h => '1 საათი';

  @override
  String get storageTitle => 'მეხსიერება';

  @override
  String get storageHeadline => 'მეხსიერების გამოყენება';

  @override
  String storageSubtitle(String size) {
    return 'cubechat ამ მოწყობილობაზე $size-ს იკავებს';
  }

  @override
  String get storageEmpty => 'ჯერ არაფერია შენახული';

  @override
  String get storageScanning => 'ითვლება…';

  @override
  String get storageCatPhotos => 'ფოტოები';

  @override
  String get storageCatVoice => 'ხმოვანი შეტყობინებები';

  @override
  String get storageCatFiles => 'მიღებული ფაილები';

  @override
  String get storageCatOutbox => 'გაგზავნილი ფაილები';

  @override
  String get storageCatStickers => 'სტიკერები';

  @override
  String get storageCatSaved => 'შენახული შეტყობინებები';

  @override
  String get storageCatWallpapers => 'ფონები';

  @override
  String get storageCatHistory => 'მიმოწერა და გასაღებები';

  @override
  String get storageCatCache => 'ქეში';

  @override
  String storageClear(String size) {
    return 'გასუფთავება ($size)';
  }

  @override
  String get storageClearNothing => 'არაფერია არჩეული';

  @override
  String storageFreed(String size) {
    return 'გათავისუფლდა $size';
  }

  @override
  String get storageNoCloud =>
      'ამის უკან ღრუბელი არ დგას. რასაც გაასუფთავებთ, ამ ტელეფონიდან გაქრება, ერთადერთი სხვა ასლი კი იმ ტელეფონზეა, საიდანაც მოვიდა.';

  @override
  String get storageWhyHistoryLocked =>
      'მიმოწერა აქედან არ სუფთავდება — გამოიყენეთ „საგანგებო წაშლა“.';

  @override
  String get storageRecoveryFree => 'უსაფრთხოდ გასუფთავდება';

  @override
  String get storageRecoveryGone => 'ასლი სხვაგან არსად არის';

  @override
  String get storageRecoveryAskSender => 'შეიძლება გამგზავნს ხელახლა სთხოვოთ';

  @override
  String get storageRecoveryCostsThem =>
      'ისინი ვეღარ გთხოვენ ხელახლა გაგზავნას';

  @override
  String storageConfirmTitle(String size) {
    return 'გასუფთავდეს $size?';
  }

  @override
  String get storageConfirmBody =>
      'ფაილები ამ ტელეფონიდან წაიშლება. არსად არაფერი იტვირთება, ასე რომ, აღსადგენი არსაიდან იქნება.';

  @override
  String storageFilesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ფაილი',
      one: '$count ფაილი',
      zero: 'ცარიელია',
    );
    return '$_temp0';
  }

  @override
  String get customizeBarTitle => 'ნავიგაციის პანელი';

  @override
  String get customizeBarHint =>
      'გადაათრიეთ რიგის შესაცვლელად. ჩატების მოშორება შეუძლებელია.';

  @override
  String get customizeBarShown => 'ნაჩვენები';

  @override
  String get customizeBarHidden => 'დამალული';

  @override
  String get customizeBarHiddenEmpty => 'არაფერია დამალული';

  @override
  String get customizeBarMinimum => 'დატოვეთ მინიმუმ ორი ჩანართი';

  @override
  String get customizeReset => 'ნაგულისხმევზე დაბრუნება';

  @override
  String get chatsArchiveTitle => 'არქივი';

  @override
  String get chatsArchiveEmpty => 'არქივი ცარიელია';

  @override
  String get chatsArchiveHint =>
      'დაარქივებული ჩატები ჩვეულებრივ მუშაობს — უბრალოდ სიაში არ ჩანს.';

  @override
  String get chatsArchivedToast => 'დაარქივდა';

  @override
  String get chatsUnarchivedToast => 'სიაში დაბრუნდა';

  @override
  String chatsArchiveCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ჩატი',
      one: '$count ჩატი',
    );
    return '$_temp0';
  }

  @override
  String get chatsSwipeNotHere => 'ამ ჩატისთვის მიუწვდომელია';

  @override
  String get customizeSwipeTitle => 'ჩატის გასრიალება მარჯვნივ';

  @override
  String get customizeSwipeHint =>
      'მარცხნივ გასრიალება ისევ ჩანართებს შორის გადადის.';

  @override
  String get customizeSwipeArchive => 'არქივში';

  @override
  String get customizeSwipeMute => 'დადუმება';

  @override
  String get customizeSwipePin => 'ჩამაგრება';

  @override
  String get customizeSwipeRead => 'წაკითხულია';

  @override
  String get customizeSwipeDelete => 'წაშლა';

  @override
  String get customizeSwipeNone => 'არაფერი';

  @override
  String get customizeHighRefresh => 'განახლების სრული სიხშირე';

  @override
  String get customizeHighRefreshHint =>
      'უფრო გლუვია და ტელეფონი ორჯერ მეტ კადრს ხატავს. გამორთეთ, თუ ცხელდება — აპის იერსახე არ იცვლება, მხოლოდ ის, თუ რამდენად ხშირად იხატება ხელახლა.';

  @override
  String get customizeQuickReaction => 'რეაქცია ორმაგი შეხებით';

  @override
  String get customizeQuickReactionHint =>
      'რას ტოვებს შეტყობინებაზე ორმაგი შეხება. სხვა რეაქციის გამოყენება მას აქ გადმოიტანს.';

  @override
  String get customizeCircleAudioTitle =>
      'მუსიკის შეჩერება ვიდეოშეტყობინებებისთვის';

  @override
  String get customizeCircleAudioOn =>
      'ჩაწერა ან ნახვა აჩერებს ყველაფერს, რაც უკრავს. თავისით აღარ განახლდება.';

  @override
  String get customizeCircleAudioOff =>
      'თქვენი მუსიკა ფონზე გააგრძელებს დაკვრას, ვიდეოშეტყობინების დროს უფრო ჩუმად.';

  @override
  String get customizeMediaQualityTitle => 'ფოტოს ხარისხი გაგზავნისას';

  @override
  String get customizeMediaQualityEconomy => 'ეკონომი';

  @override
  String get customizeMediaQualityStandard => 'სტანდარტი';

  @override
  String get customizeMediaQualityHigh => 'მაღალი';

  @override
  String get customizeMediaQualityEconomyHint =>
      'ფოტოზე 96 KB-მდე, 800 px. ერთი ზოლი სიგნალისთვის ან გადატვირთული Bluetooth mesh-ისთვის: ნახევარი ლოდინი, უფრო რბილი სურათი.';

  @override
  String get customizeMediaQualityStandardHint =>
      'ფოტოზე 192 KB-მდე, 1280 px. ზომა ისეა შერჩეული, რომ მხოლოდ Bluetooth-ითაც გავიდეს. ვიდეოები და „ორიგინალი“ ყოველთვის ისე იგზავნება, როგორიც არის.';

  @override
  String get customizeMediaQualityHighHint =>
      'ფოტოზე 768 KB-მდე, 2048 px. საკმარისად მკვეთრია გასადიდებლად; გაგზავნას ოთხჯერ მეტი დრო სჭირდება, ამიტომ Wi-Fi-ზე ჯობს.';

  @override
  String get previewReacted => 'თქვენს შეტყობინებაზე';

  @override
  String get previewLocation => 'მდებარეობა';

  @override
  String get previewMapInvite => 'მოწვევა რუკაზე';

  @override
  String get previewContact => 'კონტაქტი';

  @override
  String get previewUnsupported => 'მხარდაუჭერელი შეტყობინება';

  @override
  String get previewCallOutgoing => 'გამავალი ზარი';

  @override
  String get previewCallIncoming => 'შემომავალი ზარი';

  @override
  String get previewCallMissed => 'გამოტოვებული ზარი';

  @override
  String chatPreparingPhotos(int count) {
    return 'მზადდება $count ფოტო…';
  }

  @override
  String get circleSwitchCamera => 'კამერის გადართვა';

  @override
  String get circleLight => 'ჩაწერის განათება';

  @override
  String get circleCameraSwitchFailed =>
      'კამერის გადართვა ვერ მოხერხდა. ჩანაწერი ისევ ღიაა.';

  @override
  String get diagnosticsTitle => 'დიაგნოსტიკა';

  @override
  String get diagnosticsIntro =>
      'რას აკეთებდა აპი ბოლო დროს. თუ რამე არ მუშაობს, გაუგზავნეთ ეს დეველოპერს.';

  @override
  String get diagnosticsShare => 'ჟურნალის გაგზავნა დეველოპერისთვის';

  @override
  String get diagnosticsEvents => 'ბოლო მოვლენები';

  @override
  String get diagnosticsTechnical => 'ტექნიკური ჩანაწერები';

  @override
  String get diagnosticsEmpty => 'საჩვენებელი ჯერ არაფერია.';

  @override
  String get diagnosticsDeveloperOn => 'დეველოპერის რეჟიმი ჩართულია';

  @override
  String get diagnosticsDeveloperOff => 'დეველოპერის რეჟიმი გამორთულია';

  @override
  String get logAppStarted => 'აპი გაეშვა';

  @override
  String get logInternetOn => 'ინტერნეტ-კავშირი ჩართულია';

  @override
  String logServerConnected(String host) {
    return 'დაკავშირებულია $host-თან';
  }

  @override
  String logServerLost(String host) {
    return '$host-თან კავშირი დაიკარგა';
  }

  @override
  String get chatSaveAction => 'შენახვა';

  @override
  String get savedTagAsk => 'შენახულია. დაემატოს თეგი?';

  @override
  String get savedTagAdd => 'თეგის დამატება';

  @override
  String get chatSharedWallpaperFailed =>
      'ფონი აქ დაყენდა. მოსაუბრე მას მიიღებს, როცა ახლოს იქნება.';

  @override
  String get chatTranscribeAction => 'ტექსტად გარდაქმნა';

  @override
  String get chatTranscribeFailed =>
      'ეს ტელეფონი ამ შეტყობინების ტექსტად გარდაქმნას ვერ ახერხებს.';

  @override
  String get chatTranscribing => 'ამოცნობა…';

  @override
  String get chatTranscriptHide => 'ტექსტის დამალვა';

  @override
  String get chatCancelSend => 'გაგზავნის გაუქმება';

  @override
  String get chatDownloadAction => 'ჩამოტვირთვა';

  @override
  String get chatDownloaded => 'შენახულია ტელეფონში';

  @override
  String get chatDownloadFailed => 'შენახვა ვერ მოხერხდა';

  @override
  String get selfUpdateTitle => 'განახლების დაყენება ფაილიდან';

  @override
  String get selfUpdateHint =>
      'აირჩიეთ cubechat-ის ახალი APK აქ და არა ჩატიდან გახსნით: ასე დაყენებისას ზარები დაბლოკილ ეკრანზე ჩართული დარჩება.';

  @override
  String get selfUpdateConfirm => 'დაადასტურეთ დაყენება სისტემურ ფანჯარაში.';

  @override
  String get selfUpdateAllow =>
      'დაუშვით, რომ cubechat-მა აპები დააყენოს, შემდეგ ისევ შეეხეთ.';

  @override
  String get selfUpdateNotOurs => 'ეს ფაილი cubechat-ის განახლება არ არის.';

  @override
  String get selfUpdateFailed => 'განახლება არ დაყენდა.';

  @override
  String get chatTranscribeDownloading =>
      'ტელეფონი ამისთვის ენას ჩამოტვირთავს. სცადეთ ერთ წუთში.';

  @override
  String get chatTranscribeNoLanguage =>
      'ამ ტელეფონზე ამ ენის მეტყველების მოდელი არ არის. აირჩიეთ ხმის ტექსტად გარდაქმნის ენა: პროფილი → ჩატები და მედია.';

  @override
  String get chatTranscribeNotAllowed =>
      'მეტყველების ამოცნობა CubeChat-ისთვის გამორთულია. ჩართეთ iPhone-ის პარამეტრებში → CubeChat.';

  @override
  String get customizeTranscribeLanguageTitle => 'ხმის ტექსტად გარდაქმნის ენა';

  @override
  String get customizeTranscribeLanguageAuto => 'ავტო';

  @override
  String get customizeTranscribeLanguageHint =>
      'რა ენაზე საუბრობენ ხმოვან შეტყობინებებში — აუცილებლად აპის ენა არ არის. „ავტო“ ტელეფონის ენებს ცდის. არარსებულ ენას ტელეფონი თავად ჩამოტვირთავს; ხმა მას არასოდეს ტოვებს.';

  @override
  String get chatTranslateAction => 'თარგმნა';

  @override
  String get chatTranslateFailed =>
      'ამ შეტყობინების თარგმნა ამ ტელეფონზე შეუძლებელია.';

  @override
  String get customizeDeferMediaTitle => 'მედიის ჩამოტვირთვა მხოლოდ Wi-Fi-ით';

  @override
  String get customizeDeferMediaHint =>
      'მობილური ინტერნეტით ტექსტები და ზარები ჩვეულებრივ მუშაობს, ფოტოები, ხმოვანი, ვიდეოშეტყობინებები და ფაილები კი სერვერზე Wi-Fi-ს ელოდება — ორ კვირამდე. ჩატების ზემოთ სტრიქონი აჩვენებს, რა ელოდება, და მაშინვე ჩამოტვირთავს.';

  @override
  String heldMediaCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count მედიაფაილი Wi-Fi-ს ელოდება',
      one: '1 მედიაფაილი Wi-Fi-ს ელოდება',
    );
    return '$_temp0';
  }

  @override
  String get heldMediaDownload => 'ჩამოტვირთვა';

  @override
  String get nearbyAirDropSubtitle => 'ფაილების გაზიარება ახლოს მყოფებთან';

  @override
  String get nearbyFilesSubtitle => 'გაგზავნილი და მიღებული ფაილები';

  @override
  String get airdropTab => 'AirDrop';

  @override
  String get nearbyTabFiles => 'ფაილები';

  @override
  String get airdropReceiveHint => 'ვის შეუძლია ფაილების გამოგზავნა';

  @override
  String get airdropReceiveContacts => 'კონტაქტები';

  @override
  String get airdropReceiveEveryone => 'ყველა 10 წთ';

  @override
  String airdropEveryoneLeft(String time) {
    return 'ყველა · $time';
  }

  @override
  String get airdropSendFiles => 'ფაილების გაგზავნა';

  @override
  String get airdropChooseFiles => 'ფაილების არჩევა';

  @override
  String airdropStagedTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ფაილი მზადაა',
      one: '1 ფაილი მზადაა',
    );
    return '$_temp0';
  }

  @override
  String get airdropStagedHint =>
      'ორივე ტელეფონზე ჩართული Bluetooth-ითა და გახსნილი AirDrop-ით მიადეთ ისინი ერთმანეთს ან აირჩიეთ ადამიანი';

  @override
  String get airdropStagedPickPerson => 'ადამიანის არჩევა';

  @override
  String airdropRequestBody(String what, String size) {
    return 'სურს გამოგიგზავნოთ $what · $size';
  }

  @override
  String airdropWhatPhotos(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ფოტო',
      one: '1 ფოტო',
    );
    return '$_temp0';
  }

  @override
  String airdropWhatVideos(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ვიდეო',
      one: '1 ვიდეო',
    );
    return '$_temp0';
  }

  @override
  String airdropWhatFiles(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ფაილი',
      one: '1 ფაილი',
    );
    return '$_temp0';
  }

  @override
  String get airdropAccept => 'მიღება';

  @override
  String get airdropDecline => 'უარყოფა';

  @override
  String get airdropWaiting => 'პასუხს ველოდებით…';

  @override
  String get airdropAccepted => 'მიღებულია';

  @override
  String get airdropUnheard =>
      'არ მიუღია — შესაძლოა, CubeChat-ის ძველი ვერსიაა';

  @override
  String get airdropSending => 'იგზავნება';

  @override
  String get airdropReceiving => 'მიიღება';

  @override
  String get airdropInterrupted => 'შეწყდა';

  @override
  String get airdropRetry => 'ხელახლა';

  @override
  String get airdropOutcomeSent => 'გაიგზავნა';

  @override
  String get airdropOutcomeReceived => 'მიღებულია';

  @override
  String get airdropOutcomeDeclined => 'უარყოფილია';

  @override
  String get airdropOutcomeCancelled => 'გაუქმდა';

  @override
  String get airdropOutcomePartial => 'ნაწილობრივ';

  @override
  String get airdropReasonNoSpace => 'ადგილი არ არის საკმარისი';

  @override
  String get airdropReasonContactsOnly => 'მხოლოდ კონტაქტებიდან';

  @override
  String get airdropReasonBusy => 'დაკავებულია';

  @override
  String get airdropReasonTimeout => 'არ პასუხობს';

  @override
  String get airdropFileDeleted => 'წაშლილია';

  @override
  String get airdropHistory => 'ისტორია';

  @override
  String get airdropClearHistory => 'ისტორიის გასუფთავება';

  @override
  String get airdropEmpty =>
      'აქ იქნება ფაილები, რომლებსაც ახლოს აგზავნით ან იღებთ';

  @override
  String get airdropPickPerson => 'ვის გავუგზავნოთ';

  @override
  String get airdropNobody => 'ახლოს cubechat-ით ჯერ არავინ არის';

  @override
  String get airdropNoDirect => 'ამ ადამიანთან Bluetooth-კავშირი არ არის';

  @override
  String get airdropNearbyUnknown => 'ახლოს';

  @override
  String get airdropConnecting => 'დაკავშირება…';

  @override
  String get airdropConnectFailed => 'დაკავშირება ვერ მოხერხდა';

  @override
  String get airdropSlowWarning =>
      'Bluetooth-ით ამას შეიძლება დიდი დრო დასჭირდეს';

  @override
  String airdropTooLarge(String name, int limit) {
    return '$name $limit მბ-ზე დიდია';
  }

  @override
  String airdropFromLabel(String name) {
    return 'AirDrop · $name';
  }

  @override
  String get airdropWrite => 'მიწერა';

  @override
  String get airdropAction => 'AirDrop';

  @override
  String get airdropLaneTitle => 'არხი';

  @override
  String get airdropLaneAuto => 'ავტო';

  @override
  String get airdropLaneBluetooth => 'Bluetooth';

  @override
  String get airdropLaneWifi => 'Wi‑Fi';

  @override
  String get airdropBluetoothNeededHint =>
      'ჩართეთ Bluetooth ორივე ტელეფონზე, რომ ერთმანეთი იპოვონ და გადაცემა დაადასტურონ.';

  @override
  String get airdropLaneHint =>
      'Bluetooth ტელეფონებს პოულობს და აკავშირებს. Wi‑Fi ფაილებს გადასცემს, როცა ორივე ტელეფონი ერთ ქსელში ან ერთ წვდომის წერტილზეა.';

  @override
  String get airdropWifiUnreachable => 'ერთ ქსელში არ არის';

  @override
  String get airdropWifiOldVersion => 'მის აპს Wi‑Fi-ით მიღება ჯერ არ შეუძლია';

  @override
  String get airdropBumpAdd => 'დამატება';

  @override
  String get airdropBumpAlreadyContact => 'უკვე კონტაქტებშია';

  @override
  String airdropBumpSending(String name) {
    return 'ეგზავნება: $name';
  }

  @override
  String airdropBumpReceiving(String name) {
    return '$name ფაილებს გიგზავნით';
  }

  @override
  String get termsTitle => 'cubechat-ის წესები';

  @override
  String get termsBody =>
      'cubechat-ში შეურაცხმყოფელი კონტენტი და მოძალადე მომხმარებლები დაუშვებელია. გაგრძელებით თქვენ თანხმდებით, რომ არ გააგზავნით შევიწროებას, მუქარას, არასრულწლოვნების მონაწილეობით სექსუალურ კონტენტს, სპამს ან რაიმე უკანონოს. ნებისმიერს შეუძლია შეტყობინებაზე ან ადამიანზე გასაჩივრება; საჩივრები დეველოპერს მიდის და 24 საათში განიხილება, დამრღვევები კი იბლოკებიან.';

  @override
  String get termsReadFull => 'სრული პირობები';

  @override
  String get termsAccept => 'ვეთანხმები';

  @override
  String get messageHide => 'დამალვა';

  @override
  String get messageHidden => 'დამალულია თქვენთვის';

  @override
  String get reportAction => 'გასაჩივრება';

  @override
  String get reportTitle => 'რა არის პრობლემა?';

  @override
  String get reportReasonSpam => 'სპამი';

  @override
  String get reportReasonAbuse => 'შეურაცხყოფა ან შევიწროება';

  @override
  String get reportReasonViolence => 'ძალადობა';

  @override
  String get reportReasonSexual => 'სექსუალური კონტენტი';

  @override
  String get reportReasonOther => 'სხვა';

  @override
  String get reportNoteHint => 'აღწერეთ (არასავალდებულო)';

  @override
  String get reportSend => 'საჩივრის გაგზავნა';

  @override
  String get reportDisclosure =>
      'არჩეული შეტყობინების ტექსტი და თქვენი საჩივარი გადაეცემა cubechat-ის მოდერაციას და მის პირად Telegram-ბოტს.';

  @override
  String get reportSent =>
      'საჩივარი გაიგზავნა. საჩივრებს 24 საათში განვიხილავთ.';

  @override
  String get reportBlockedToo => 'ეს ადამიანი თქვენთვის დაბლოკილია.';

  @override
  String get reportQueued =>
      'საჩივარი შენახულია. გაიგზავნება, როცა ონლაინ იქნებით.';

  @override
  String get reportFailed => 'საჩივრის გაგზავნა ვერ მოხერხდა.';

  @override
  String get filteredMessage => 'დამალულია ფილტრით';

  @override
  String get filteredShow => 'ჩვენება';

  @override
  String get filterToggle => 'შეურაცხმყოფელი კონტენტის ფილტრი';

  @override
  String get filterToggleHint => 'მალავს უხეშ სიტყვებს უცნობებისგან და არხებში';

  @override
  String get aboutTitle => 'აპის შესახებ';

  @override
  String get aboutContact => 'დეველოპერისთვის მიწერა';

  @override
  String get aboutReport => 'დარღვევის შეტყობინება';

  @override
  String get aboutTerms => 'გამოყენების პირობები';

  @override
  String get aboutPrivacy => 'კონფიდენციალურობის პოლიტიკა';

  @override
  String get requestsTitle => 'მოთხოვნები';

  @override
  String get requestsEmpty => 'მოთხოვნები არ არის';

  @override
  String requestBanner(String name) {
    return '$name არ არის თქვენს კონტაქტებში. სანამ მოთხოვნას არ მიიღებთ, ვერ დაინახავს, რომ წაიკითხეთ, და ვერ დაგირეკავთ.';
  }

  @override
  String get requestAccept => 'მიღება';

  @override
  String get requestDelete => 'წაშლა';

  @override
  String get requestBlock => 'დაბლოკვა';

  @override
  String get cubeIdTitle => 'Cube ID';

  @override
  String get cubeIdExplainer =>
      'თქვენი @სახელი თქვენს საკონტაქტო ბარათზე მიუთითებს. სერვერი ინახავს მხოლოდ სახელს და თქვენს საჯარო ბარათს — არასოდეს თქვენს შეტყობინებებს.';

  @override
  String get cubeIdFieldHint => 'a–z, 0–9 და _, 3–20 სიმბოლო';

  @override
  String get cubeIdAvailable => 'თავისუფალია';

  @override
  String get cubeIdTaken => 'დაკავებულია';

  @override
  String get cubeIdReserved => 'დაუშვებელია';

  @override
  String get cubeIdInvalid => 'მხოლოდ a–z, 0–9 და _, 3–20 სიმბოლო';

  @override
  String get cubeIdClaim => 'დაკავება';

  @override
  String get cubeIdWorking => 'სახელი მაგრდება…';

  @override
  String get cubeIdChange => 'შეცვლა';

  @override
  String get cubeIdEmail => 'აღდგენის ელფოსტა';

  @override
  String get cubeIdEmailHint =>
      'თუ ეს ტელეფონი დაიკარგა, სახელი ამ მისამართზე გამოგზავნილი წერილით დაბრუნდება';

  @override
  String get cubeIdEmailField => 'ელფოსტა';

  @override
  String cubeIdEmailSent(String email) {
    return 'წერილი გაიგზავნა $email-ზე. გახსენით მასში არსებული ბმული.';
  }

  @override
  String get cubeIdEmailRemove => 'ელფოსტის წაშლა';

  @override
  String get cubeIdEmailUnavailable =>
      'ელფოსტა ახლა მიუწვდომელია. სცადეთ მოგვიანებით.';

  @override
  String get cubeIdEmailInvalid => 'ეს ელფოსტის მისამართს არ ჰგავს';

  @override
  String get cubeIdSave => 'შენახვა';

  @override
  String get cubeIdRecover => 'სახელის აღდგენა ელფოსტით';

  @override
  String get cubeIdRecoverSent =>
      'თუ მისამართი ემთხვევა, წერილი მოვა. სახელი ამ ტელეფონზე გადმოვა ბმულის გახსნიდან 48 საათის შემდეგ.';

  @override
  String cubeIdRecoveryWarning(String name, String when) {
    return 'ვიღაც სხვა ტელეფონზე @$name-ს ელფოსტით აღადგენს. სახელი გადავა $when, თუ არ გააუქმებთ.';
  }

  @override
  String get cubeIdRecoveryCancel => 'აღდგენის გაუქმება';

  @override
  String get cubeIdRecoveryCancelled => 'აღდგენა გაუქმდა';

  @override
  String get cubeIdRelease => 'გათავისუფლება';

  @override
  String cubeIdReleaseConfirm(String name) {
    return 'გათავისუფლდეს @$name? მისი დაკავება ნებისმიერს შეეძლება.';
  }

  @override
  String get cubeIdShare => 'გაზიარება';

  @override
  String cubeIdShareText(String name) {
    return 'მიპოვეთ cubechat-ში: @$name\nhttps://cubechat.tech/u.html#$name';
  }

  @override
  String get cubeIdFailed => 'სახელის შენახვა ვერ მოხერხდა. სცადეთ ხელახლა.';

  @override
  String get cubeIdOffline => 'ინტერნეტი არ არის';

  @override
  String get lookupNotFound => 'ასეთი @სახელით არავინ არის';

  @override
  String searchFindCubeName(String name) {
    return '@$name-ის პოვნა';
  }

  @override
  String get searchFindCubeNameHint => 'Cube ID-ში ძიება და დამატება';

  @override
  String get addContactHintName => 'ჩასვით ბარათი ან აკრიფეთ @სახელი';

  @override
  String get strangerReachTitle => 'ვის შეუძლია მომწეროს ინტერნეტიდან';

  @override
  String get strangerReachAll => 'ყველას';

  @override
  String get strangerReachRequest => 'მოთხოვნით';

  @override
  String get strangerReachNone => 'არავის';

  @override
  String get strangerReachHint =>
      'იმ ადამიანებისთვის, ვისაც არ მიგიწერიათ და ინტერნეტით გიკავშირდებიან. ახლოს მყოფებს Bluetooth-ით ეს არ ეხება.';

  @override
  String get sectionPrivacy => 'კონფიდენციალურობა და უსაფრთხოება';

  @override
  String get sectionNotifications => 'შეტყობინებები და ზარები';

  @override
  String get sectionConnection => 'კავშირი';

  @override
  String get sectionChats => 'ჩატები და მედია';

  @override
  String get sectionAppearance => 'იერსახე';

  @override
  String get sectionData => 'მონაცემები და მეხსიერება';

  @override
  String get sectionAbout => 'აპის შესახებ';

  @override
  String get subWhoSeesMe => 'ვინ მხედავს';

  @override
  String get subProtection => 'დაცვა';

  @override
  String get subNotifications => 'შეტყობინებები';

  @override
  String get subCalls => 'ზარები';

  @override
  String get profileDiscoverableMeshOff =>
      'Bluetooth mesh გამორთულია — ჩართეთ განყოფილებაში „კავშირი“.';

  @override
  String get chatRouteBluetoothDirect => 'Bluetooth, პირდაპირ';

  @override
  String chatRouteMeshHops(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Mesh · $n ხტომა',
      one: 'Mesh · $n ხტომა',
    );
    return '$_temp0';
  }

  @override
  String chatRouteDeliveredVia(String route) {
    return 'მიწოდებულია: $route';
  }

  @override
  String chatRouteReceivedVia(String route) {
    return 'მიღებულია: $route';
  }

  @override
  String get chatUnreadDivider => 'ახალი შეტყობინებები';

  @override
  String get radioTitle => 'რაცია';

  @override
  String get radioNearbySubtitle =>
      'დააჭირეთ ღილაკს და ესაუბრეთ ჯგუფს ან კონტაქტს';

  @override
  String get radioGroupsLabel => 'ჯგუფები';

  @override
  String get radioDirectLabel => 'პირადი';

  @override
  String get radioAddGroup => 'რაციის დამატება';

  @override
  String get radioNoGroups =>
      'რაციები ჯერ არ არის. დაამატეთ — ყველა, ვინც იმავე სახელსა და პაროლს შეიყვანს, ერთმანეთს გაიგონებს.';

  @override
  String get radioLeave => 'რაციიდან გასვლა';

  @override
  String get radioPickChannel => 'აირჩიეთ ჯგუფი ან კონტაქტი';

  @override
  String get radioPushToTalk => 'დააჭირეთ და ისაუბრეთ';

  @override
  String get radioTalking => 'ლაპარაკობთ…';

  @override
  String get radioChannelBusy => 'არხი დაკავებულია';

  @override
  String radioSpeaker(String name) {
    return 'ლაპარაკობს: $name';
  }

  @override
  String get radioSilentTitle => 'ლაპარაკი უხმო რეჟიმში';

  @override
  String get radioSilentHint =>
      'ხმა ისმის მაშინაც, როცა ტელეფონი უხმო რეჟიმშია.';

  @override
  String get radioJoinNameLabel => 'სახელი';

  @override
  String get radioJoinPasswordLabel => 'პაროლი (არასავალდებულო)';

  @override
  String get radioJoinHint =>
      'ყველა, ვინც იმავე სახელსა და პაროლს შეიყვანს, ერთ რაციაზეა. არცერთი სერვერი მათ სიას არ ინახავს.';

  @override
  String get radioJoinNameRequired => 'შეიყვანეთ სახელი';

  @override
  String get radioJoinSubmit => 'დამატება';

  @override
  String get radioBlockedTooLong => 'შეწყდა ერთწუთიანი ლაპარაკის შემდეგ';

  @override
  String get radioBlockedCall => 'მიმდინარეობს ზარი';

  @override
  String get radioBlockedMicrophone => 'მიკროფონზე წვდომა არ არის';

  @override
  String get radioBlockedUnavailable => 'რაცია ამ მოწყობილობაზე მიუწვდომელია';

  @override
  String get radioBlockedNoChannel => 'ჯერ აირჩიეთ ჯგუფი ან კონტაქტი';

  @override
  String get radioTurnOff => 'რაციის გამორთვა';

  @override
  String get radioPersonalCallsTitle => 'პირადი გამოძახებების მიღება';

  @override
  String get radioPersonalCallsHint =>
      'როცა რაცია გამორთულია, კონტაქტი, რომელიც გელაპარაკებათ, მას თავისკენ გადართავს.';

  @override
  String get radioBackgroundHint =>
      'გამორთული ეკრანით რაცია მხოლოდ ფონური რეჟიმის ჩართვისას ისმის.';

  @override
  String get areaNearby => 'ჩატი ახლოს';

  @override
  String get areaLevelDistrict => 'უბანი';

  @override
  String get areaLevelCity => 'ქალაქი';

  @override
  String get areaLevelRegion => 'რეგიონი';

  @override
  String areaPresentCount(int count) {
    return '≈$count აქ';
  }

  @override
  String get areaPresentMany => '50+ აქ';

  @override
  String get areaBlockViaBluetooth => 'თქვენი კვარტალი — Bluetooth-ით';

  @override
  String get areaOpenNearbyTab => '„ახლოს“-ის გახსნა';

  @override
  String get areaLocating => 'თქვენი უბნის ძიება…';

  @override
  String get areaNoPlace =>
      'მდებარეობა ჯერ არ არის. უბნის ჩატს თქვენი მიახლოებითი მდებარეობა სჭირდება, სანამ ეს ეკრანი ღიაა.';

  @override
  String get areaLocationDenied =>
      'მდებარეობა Cubechat-ისთვის გამორთულია. უბნის სანახავად დაუშვით მიახლოებითი მდებარეობა პარამეტრებში.';

  @override
  String get areaOffline => 'უბნის ჩატთან კავშირი არ არის';

  @override
  String get areaEmpty => 'ბოლო 24 საათში აქ არავის დაუწერია.';

  @override
  String get areaConsentTitle => 'უბნის ჩატი საჯაროა';

  @override
  String get areaConsentBody =>
      'აქ შეტყობინებები საჯაროა. მათ წაიკითხავს ყველა, ვინც თქვენს უბანს ან ქალაქს გახსნის, და ისინი Cubechat-ის სერვერზე 24 საათი ინახება. თქვენ წერთ დროებითი სახელით, რომელიც რამდენიმე საათში ერთხელ იცვლება; თქვენს @სახელს ან კონტაქტებს ვერავინ ხედავს. თქვენი უბნის დასადგენად Cubechat ითხოვს თქვენს მიახლოებით მდებარეობას, მხოლოდ სანამ ეს ეკრანი ღიაა.';

  @override
  String get areaConsentAllow => 'გაგრძელება';

  @override
  String get areaConsentDecline => 'ახლა არა';

  @override
  String areaDefaultName(String tag) {
    return 'კუბი-$tag';
  }

  @override
  String areaYouAre(String name, int hours) {
    return 'თქვენ ხართ $name · ახალი სახელი $hours სთ-ში';
  }

  @override
  String get areaNewName => 'ახალი სახელი';

  @override
  String get areaSetName => 'სახელის არჩევა';

  @override
  String get areaNameHint =>
      'მხოლოდ ამ სახელის რამდენიმე საათისთვის. დატოვეთ ცარიელი ავტომატურისთვის.';

  @override
  String get areaNameSameWarning =>
      'ერთი და იგივე სახელი გაკავშირებთ სხვადასხვა უბანში';

  @override
  String get areaShowPresence => 'ჩვენება, რომ აქ ვარ';

  @override
  String get areaPresenceOffHint =>
      'ჩართეთ „ჩვენება, რომ აქ ვარ“, რომ დაინახოთ, რამდენი ადამიანია ახლოს';

  @override
  String get areaReadOnly => 'წერა მხოლოდ იქ შეგიძლიათ, სადაც ხართ';

  @override
  String get areaComposerHint => 'შეტყობინება აქ მყოფი ყველასთვის';

  @override
  String get areaSend => 'გაგზავნა';

  @override
  String get areaWaitALittle => 'ცოტა დაელოდეთ';

  @override
  String areaFlood(int count) {
    return 'ფლუდი ($count) · ჩვენება';
  }

  @override
  String get areaReply => 'პასუხი';

  @override
  String get areaHide => 'დამალვა';

  @override
  String get areaBlock => 'დაბლოკვა სახელის შეცვლამდე';

  @override
  String get areaBlocked => 'დაბლოკილია სახელის შეცვლამდე';

  @override
  String get areaReport => 'გასაჩივრება';

  @override
  String get areaOpenLink => 'ბმულის გახსნა';

  @override
  String areaOpenLinkConfirm(String url) {
    return 'გაიხსნას $url?';
  }

  @override
  String get areaOpen => 'გახსნა';

  @override
  String get areaReadHere => 'აქ კითხვა';

  @override
  String get areaReadHereHint =>
      'მხოლოდ კითხვა. წერა მხოლოდ იქ შეგიძლიათ, სადაც ხართ; რელე გაიგებს, რომელ ადგილს კითხულობთ.';

  @override
  String get areaNotes => 'ჩანაწერები';

  @override
  String areaNotesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ჩანაწერი',
      one: '$count ჩანაწერი',
      zero: 'ჩანაწერები არ არის',
    );
    return '$_temp0';
  }

  @override
  String get areaLeaveNote => 'ჩანაწერის დატოვება';

  @override
  String get areaNoteHint => 'მოკლე ჩანაწერი თქვენი ქალაქისთვის';

  @override
  String get areaNoteLifetime => 'ინახება';

  @override
  String get areaNote1h => '1 სთ';

  @override
  String get areaNote24h => '24 სთ';

  @override
  String get areaNote7d => '7 დღე';

  @override
  String get areaPinToDistrict => 'უბანზე მიმაგრება';

  @override
  String get areaPinHint =>
      'შეეხეთ რუკას თქვენი ქალაქის ფარგლებში; ნიშნული უბანს მიემაგრება.';

  @override
  String get areaPinOutside => 'მხოლოდ თქვენი ქალაქის ფარგლებში';

  @override
  String get areaNoteDelete => 'ჩემი ჩანაწერის წაშლა';

  @override
  String get areaNoNotes => 'აქ ჯერ ჩანაწერები არ არის';

  @override
  String get areaNotesLimit => 'სამი ჩანაწერი დღეში';

  @override
  String get areaNoteLeft => 'ჩანაწერი დატოვებულია';

  @override
  String get areaNoteSend => 'დატოვება';

  @override
  String get areaOwnNote => 'თქვენი ჩანაწერი';

  @override
  String get areaNotePinned => 'მიმაგრებულია უბანზე';

  @override
  String get areaHidden => 'დამალულია';

  @override
  String get areaPublicBadge => 'საჯარო · 24 სთ';

  @override
  String get areaSettingTitle => 'უბნის ჩატი';

  @override
  String get areaSettingOnHint =>
      'ღილაკი „ჩატი ახლოს“ რუკაზე: თქვენი უბნისა და ქალაქის საჯარო ჩატები, დროებითი სახელით.';

  @override
  String get areaSettingOffHint =>
      'გამორთულია: რუკაზე ღილაკი არ არის და უბნის ჩატი არასოდეს ითხოვს თქვენს მდებარეობას და არ უკავშირდება.';

  @override
  String get wallpaperPhotoLocalOnly =>
      'ფოტო-ფონები ჯერჯერობით მხოლოდ ლოკალურია';

  @override
  String get wallpaperSavedNoRoute =>
      'შენახულია აქ. ახლა თანამოსაუბრემდე მარშრუტი არ არის';

  @override
  String get wallpaperScopeTitle => 'ვინ უნდა ნახოს ეს ფონი?';

  @override
  String get wallpaperScopeChannel => 'მთელი არხი';

  @override
  String get wallpaperScopeBoth => 'მე და თანამოსაუბრე';

  @override
  String get wallpaperScopeLocal => 'მხოლოდ ჩემთან';

  @override
  String get wallpaperScopeSharedHint =>
      'იგზავნება დაშიფრული სერვისული პაკეტით';

  @override
  String get wallpaperScopePhotoHint =>
      'ფოტოები ჯერჯერობით მხოლოდ ამ ტელეფონზე რჩება';

  @override
  String get foldersCreate => 'საქაღალდის შექმნა';

  @override
  String get foldersYours => 'თქვენი საქაღალდეები';

  @override
  String get foldersSmartFilters => 'ჭკვიანი ფილტრები';

  @override
  String get foldersName => 'საქაღალდის სახელი';

  @override
  String get foldersSave => 'შენახვა';

  @override
  String get foldersDeleteTitle => 'წაიშალოს საქაღალდე?';

  @override
  String get foldersDelete => 'წაშლა';

  @override
  String get foldersCreateAction => 'შექმნა';

  @override
  String get chatsArchiveHiddenToast =>
      'არქივი დამალულია. დააბრუნეთ განყოფილებაში „იერსახე“.';

  @override
  String get chatsBulkPin => 'მიმაგრება';

  @override
  String get chatsBulkMute => 'დადუმება';

  @override
  String get chatsUnarchive => 'არქივიდან ამოღება';

  @override
  String get chatsAddToFolder => 'საქაღალდეში დამატება';

  @override
  String get chatsMarkUnread => 'წაუკითხავად მონიშვნა';

  @override
  String get chatsClearHistory => 'ჩატის ისტორიის გასუფთავება';

  @override
  String get foldersNew => 'ახალი საქაღალდე';

  @override
  String get foldersNameHint => 'მეგობრები';

  @override
  String get chatsNoIncoming => 'შემომავალი შეტყობინებები არ არის';

  @override
  String get chatsMarkedUnread => 'მონიშნულია წაუკითხავად';

  @override
  String get chatsClearHistoryTitle => 'გასუფთავდეს ჩატის ისტორია?';

  @override
  String get chatsClearHistoryBody =>
      'შეტყობინებები წაიშლება მხოლოდ ამ მოწყობილობაზე. ჩატი, კონტაქტი და რჩეულები დარჩება.';

  @override
  String get chatsClearHistoryAction => 'გასუფთავება';

  @override
  String get chatsHistoryCleared => 'ისტორია გასუფთავდა';

  @override
  String get savedTagMenuTag => 'თეგი';

  @override
  String get savedTagRemove => 'თეგის მოხსნა';

  @override
  String get customizeArchiveRowTitle => 'არქივის ხაზი';

  @override
  String get customizeArchiveRowHint =>
      'ჩვენება ჩატების სიის ზემოთ. დაარქივებული ჩატები შეტყობინებებს მაინც იღებს.';

  @override
  String get mapLayerStandard => 'სტანდარტული';

  @override
  String get mapLayerStandardHint =>
      'ღია ფერის ქუჩების რუკა — ყველაზე სტაბილური ვარიანტი';

  @override
  String get backupAutoTitle => 'ავტომატური ასლი';

  @override
  String get backupAutoHint =>
      'დღეში ერთხელ, არჩეულ საქაღალდეში ერთ ფაილად; ყოველი ასლი წინას ცვლის.';

  @override
  String backupAutoFolder(String name) {
    return 'საქაღალდე: $name';
  }

  @override
  String backupAutoLast(String time) {
    return 'ბოლო ასლი: $time';
  }

  @override
  String get backupAutoNever => 'ასლი ჯერ არ არის';

  @override
  String get backupAutoRunning => 'ასლი იქმნება…';

  @override
  String get backupAutoFolderLost => 'საქაღალდე მიუწვდომელია. აირჩიეთ ხელახლა.';

  @override
  String get backupAutoFailed =>
      'ბოლო ასლი ვერ შეიქმნა. მოგვიანებით ვცდით ხელახლა.';

  @override
  String get backupAutoNow => 'ასლის შექმნა ახლა';

  @override
  String get backupAutoChangeFolder => 'საქაღალდის შეცვლა';

  @override
  String get callYourMicOff => 'თქვენი მიკროფონი გამორთულია';

  @override
  String callTheirCameraOff(String name) {
    return '$name: კამერა გამორთულია';
  }
}
