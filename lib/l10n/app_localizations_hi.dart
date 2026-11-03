// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get callVoice => 'वॉइस कॉल';

  @override
  String get callVideo => 'वीडियो कॉल';

  @override
  String get callIncomingVideo => 'आने वाली वीडियो कॉल';

  @override
  String get callCamera => 'कैमरा';

  @override
  String get callFlipCamera => 'पलटें';

  @override
  String get contactProfileVideo => 'वीडियो';

  @override
  String get callPreparing => 'माइक्रोफ़ोन तैयार हो रहा है…';

  @override
  String get callDialing => 'कॉल हो रही है…';

  @override
  String get callRinging => 'घंटी बज रही है…';

  @override
  String get callConnecting => 'कनेक्ट हो रहा है…';

  @override
  String get callMicrophoneRequired =>
      'कॉल करने के लिए सिस्टम सेटिंग्स में माइक्रोफ़ोन की अनुमति दें।';

  @override
  String get callMicrophoneWindows =>
      'Windows ने CubeChat को माइक्रोफ़ोन नहीं दिया। सेटिंग्स → गोपनीयता और सुरक्षा → माइक्रोफ़ोन → “डेस्कटॉप ऐप्स को आपके माइक्रोफ़ोन तक पहुँचने दें” चालू करें।';

  @override
  String get callElsewhere =>
      'इस अकाउंट के किसी दूसरे डिवाइस पर पहले से कॉल चल रही है।';

  @override
  String get callRelayUnavailable =>
      'कॉल सर्वर उपलब्ध नहीं है। कृपया बाद में फिर कोशिश करें।';

  @override
  String get callBusy => 'व्यस्त';

  @override
  String get callNoAnswer => 'जवाब नहीं मिला';

  @override
  String get callFailed => 'कॉल कनेक्ट नहीं हो सकी';

  @override
  String get callDeclined => 'कॉल अस्वीकार की गई';

  @override
  String get callEnded => 'कॉल समाप्त';

  @override
  String get callMicrophone => 'माइक्रोफ़ोन';

  @override
  String get callSpeaker => 'स्पीकर';

  @override
  String get callAnswer => 'उठाएँ';

  @override
  String get callDecline => 'अस्वीकार';

  @override
  String get callEnd => 'कॉल काटें';

  @override
  String get callClose => 'बंद करें';

  @override
  String get callMinimize => 'छोटा करें';

  @override
  String get callAudioOutput => 'कॉल ऑडियो';

  @override
  String get callRoutePhone => 'फ़ोन';

  @override
  String get callRouteBluetooth => 'Bluetooth';

  @override
  String get callRouteHeadphones => 'हेडफ़ोन';

  @override
  String get callFullScreenTitle => 'लॉक स्क्रीन पर कॉल';

  @override
  String get callFullScreenBody =>
      'आने वाली कॉल को लॉक स्क्रीन पर दिखने दें, ताकि फ़ोन अनलॉक किए बिना उसका जवाब दिया जा सके।';

  @override
  String get callFullScreenXiaomi =>
      'Xiaomi, Redmi और Poco ऐप्स को यह खुद चालू नहीं करने देते: “अन्य अनुमतियाँ” में “लॉक स्क्रीन पर दिखाएँ” चालू करें।';

  @override
  String get circleMessage => 'वीडियो मैसेज';

  @override
  String get appName => 'Cubechat';

  @override
  String get navChats => 'चैट';

  @override
  String get navPeers => 'आस-पास';

  @override
  String get navProfile => 'प्रोफ़ाइल';

  @override
  String get navContacts => 'संपर्क';

  @override
  String get navMap => 'मैप';

  @override
  String get mapTitle => 'मैप';

  @override
  String get mapFriendsTitle => 'मैप पर लोग';

  @override
  String get mapFriendsHint => 'सिर्फ़ इन संपर्कों को आपकी लोकेशन मिलती है';

  @override
  String mapClusterTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'यहाँ $count लोग',
      one: 'यहाँ $count व्यक्ति',
    );
    return '$_temp0';
  }

  @override
  String get mapClusterHint => 'किसी पर टैप करें, मैप उन तक ले जाएगा';

  @override
  String get mapNorthUp => 'उत्तर दिशा ऊपर करें';

  @override
  String get mapLayerTitle => 'मैप स्टाइल';

  @override
  String get mapLayerHint => 'पिन किस पर दिखें';

  @override
  String get mapLayerDark => 'डार्क';

  @override
  String get mapLayerDarkHint => 'सड़कें, बिना नाम — पिन के नीचे सबसे शांत';

  @override
  String get mapLayerSatellite => 'सैटेलाइट';

  @override
  String get mapLayerSatelliteHint =>
      'ऊपर से ली गई तस्वीरें: कौन-सी इमारत, कौन-सा आँगन';

  @override
  String get mapLayerTerrain => 'भू-भाग';

  @override
  String get mapLayerTerrainHint =>
      'समोच्च रेखाएँ और ऊँचाई — पहाड़ियों और पगडंडियों के लिए';

  @override
  String get mapFriendsEmpty => 'अभी कोई भी आपके साथ मैप शेयर नहीं कर रहा है।';

  @override
  String get mapFriendsEmptyHint =>
      'किसी संपर्क को आमंत्रित करें, स्वीकार करते ही वे यहाँ दिखेंगे।';

  @override
  String get mapFriendsInvite => 'आमंत्रित करें';

  @override
  String get mapFriendsRemove => 'मैप से हटाएँ';

  @override
  String mapFriendsRemoved(String name) {
    return '$name अब आपके साथ मैप शेयर नहीं करते';
  }

  @override
  String get mapFriendsLive => 'अभी मैप पर';

  @override
  String get mapFriendsIdle => 'अभी कोई लोकेशन नहीं';

  @override
  String get mapInviteTitle => 'मैप पर आमंत्रित करें';

  @override
  String get mapInviteHint => 'एक या ज़्यादा चैट चुनें';

  @override
  String get mapInviteEmpty => 'आमंत्रित करने के लिए अभी कोई चैट नहीं है।';

  @override
  String mapInviteAction(int count) {
    return 'भेजें ($count)';
  }

  @override
  String get mapInviteMessage =>
      'Cubechat मैप का आमंत्रण। मैप पर दिखने के लिए इस चैट में अपनी लोकेशन शेयर करें।';

  @override
  String mapInviteSent(int count) {
    return 'भेजे गए आमंत्रण: $count';
  }

  @override
  String get mapInviteFailed => 'आमंत्रण नहीं भेजे जा सके';

  @override
  String mapPeopleVisible(int count) {
    return 'शेयर की गई लोकेशन: $count';
  }

  @override
  String get mapCenterMe => 'मुझ पर केंद्रित करें';

  @override
  String get mapNoSharedLocations => 'अभी कोई शेयर की गई लोकेशन नहीं';

  @override
  String get mapNoSharedLocationsHint =>
      'चैट में लोकेशन भेजने के बाद संपर्क यहाँ दिखेगा।';

  @override
  String get mapWebHintTitle => 'आस-पास के कनेक्शन';

  @override
  String get mapWebHint => 'रेखाएँ नज़दीकी दिखाती हैं, मैसेज का रास्ता नहीं।';

  @override
  String get mapOpenProfile => 'प्रोफ़ाइल';

  @override
  String get mapLocationPrivacyOff => 'मैप पर लोकेशन छिपी है';

  @override
  String get mapLocationPrivacyOffHint =>
      'अपना पिन दिखाने के लिए प्राइवेसी में “मुझे मैप पर दिखाएँ” चालू करें।';

  @override
  String get mapYouOnMap => 'आपकी लोकेशन इस डिवाइस पर दिख रही है';

  @override
  String get locationSharingDisabled =>
      'पहले प्राइवेसी में “मुझे मैप पर दिखाएँ” चालू करें।';

  @override
  String get mapLocationDenied => 'लोकेशन की अनुमति बंद है';

  @override
  String get mapLocationServiceOff =>
      'खुद को दिखाने के लिए लोकेशन सेवाएँ चालू करें';

  @override
  String get mapLocationUnavailable => 'आपकी लोकेशन पता नहीं चल सकी';

  @override
  String get mapDistanceUnknown => 'दूरी उपलब्ध नहीं';

  @override
  String mapDistanceMetres(int metres) {
    return '$metres मी. दूर';
  }

  @override
  String mapDistanceKilometres(String kilometres) {
    return '$kilometres कि.मी. दूर';
  }

  @override
  String get mapUpdatedNow => 'अभी-अभी शेयर की गई';

  @override
  String mapUpdatedMinutes(int minutes) {
    return '$minutes मिनट पहले शेयर की गई';
  }

  @override
  String mapUpdatedHours(int hours) {
    return '$hours घंटे पहले शेयर की गई';
  }

  @override
  String get contactsTitle => 'संपर्क';

  @override
  String get contactsSubtitle => 'वे सभी जिन्हें आपने मैसेज किया है';

  @override
  String get contactsSearchHint => 'संपर्क खोजें…';

  @override
  String get contactsEmptyTitle => 'अभी कोई संपर्क नहीं';

  @override
  String get contactsEmptyHint => 'बातचीत शुरू करें, वह व्यक्ति यहाँ दिखेगा।';

  @override
  String get contactsSearchEmpty => 'कोई मिलता-जुलता संपर्क नहीं';

  @override
  String get contactsTabContacts => 'संपर्क';

  @override
  String get contactsTabCalls => 'कॉल';

  @override
  String get callsFilterAll => 'सभी';

  @override
  String get callsFilterMissed => 'मिस्ड';

  @override
  String get callsEmptyTitle => 'अभी कोई कॉल नहीं';

  @override
  String get callsEmptyHint => 'आने वाली, जाने वाली और मिस्ड कॉल यहाँ दिखेंगी।';

  @override
  String get callsMissedEmpty => 'कोई मिस्ड कॉल नहीं';

  @override
  String get callsCallBack => 'कॉल करें';

  @override
  String get contactProfileChat => 'चैट';

  @override
  String get contactProfileCall => 'कॉल';

  @override
  String get contactProfileRadio => 'रेडियो';

  @override
  String get contactProfileSecurity => 'सुरक्षा';

  @override
  String get contactProfileActions => 'संपर्क विकल्प';

  @override
  String get contactProfileVerify => 'वेरिफ़ाई करें';

  @override
  String get contactProfileCopyId => 'संपर्क ID कॉपी करें';

  @override
  String get contactProfileIdCopied => 'संपर्क ID कॉपी हो गई';

  @override
  String get contactProfileId => 'संपर्क ID';

  @override
  String get contactProfileVerifyHint =>
      'इस व्यक्ति की पुष्टि के लिए एन्क्रिप्शन फ़िंगरप्रिंट मिलाएँ।';

  @override
  String get chatsTitle => 'चैट';

  @override
  String get chatsSubtitle => 'Mesh · एंड-टू-एंड एन्क्रिप्टेड';

  @override
  String get chatsEmptyTitle => 'अभी कोई बातचीत नहीं';

  @override
  String get chatsEmptyHint =>
      'चैट शुरू करने के लिए “आस-पास” टैब से किसी पीयर को खोलें।';

  @override
  String get chatsFilterAll => 'सभी';

  @override
  String get chatsFilterUnread => 'अनपढ़े';

  @override
  String get chatsFilterMesh => 'Mesh';

  @override
  String get chatsFilterFavorites => 'पसंदीदा';

  @override
  String get chatsFolderDirect => 'निजी';

  @override
  String get chatsFolderChannels => 'चैनल';

  @override
  String get chatsFolderOnline => 'संपर्क में';

  @override
  String get chatsFoldersTitle => 'फ़ोल्डर';

  @override
  String get chatsFoldersHint =>
      'फ़ोल्डर इसी सूची के हिस्से हैं, ऐसी जगहें नहीं जहाँ चैट ले जाई जाती हैं। जो फ़ोल्डर चैट के ऊपर चाहिए, उन्हें चालू करें।';

  @override
  String get chatsSearchHint => 'चैट खोजें…';

  @override
  String get chatsStatusViaMesh => 'mesh से';

  @override
  String get chatsStatusOffline => 'ऑफ़लाइन';

  @override
  String get peerKeyRotated => 'कुंजी बदली — फिर से वेरिफ़ाई करें';

  @override
  String get peersTitle => 'आस-पास';

  @override
  String get peersSubtitle => 'Bluetooth रेंज में डिवाइस';

  @override
  String get peersEmpty => 'पीयर खोजे जा रहे हैं…';

  @override
  String peersHopsOne(int n) {
    return '$n हॉप दूर';
  }

  @override
  String peersHopsOther(int n) {
    return '$n हॉप दूर';
  }

  @override
  String get blePermissionTitle => 'Bluetooth अनुमति चाहिए';

  @override
  String get blePermissionHint =>
      'पीयर खोजने और मैसेज भेजने के लिए Cubechat को Bluetooth चाहिए — इंटरनेट की ज़रूरत नहीं।';

  @override
  String get blePermissionGrant => 'अनुमति दें';

  @override
  String get blePermissionOpenSettings => 'सेटिंग्स खोलें';

  @override
  String get blePermissionDeniedHint =>
      'अनुमति नहीं दी गई। Bluetooth की अनुमति देने के लिए सेटिंग्स खोलें।';

  @override
  String get bleAdapterOffTitle => 'Bluetooth बंद है';

  @override
  String get bleAdapterOffHint =>
      'आस-पास के पीयर देखने के लिए Bluetooth चालू करें।';

  @override
  String get bleUnsupportedTitle => 'Bluetooth LE उपलब्ध नहीं';

  @override
  String get bleUnsupportedHint =>
      'यह डिवाइस या प्लेटफ़ॉर्म Bluetooth Low Energy सपोर्ट नहीं करता। फ़ोन पर आज़माएँ।';

  @override
  String get bleScanning => 'स्कैन हो रहा है…';

  @override
  String get bleRetry => 'फिर कोशिश करें';

  @override
  String get bleEnable => 'चालू करें';

  @override
  String get bleConnectFailed =>
      'कनेक्ट नहीं हो सका। पीयर रेंज से बाहर हो सकता है, या उसका Bluetooth पता बदल गया है।';

  @override
  String get bleSignal => 'सिग्नल';

  @override
  String get bleConnect => 'कनेक्ट करें';

  @override
  String get bleConnected => 'कनेक्टेड';

  @override
  String get bleVerified => 'वेरिफ़ाइड';

  @override
  String get editorAdjustBrightness => 'ब्राइटनेस';

  @override
  String get editorAdjustContrast => 'कंट्रास्ट';

  @override
  String get editorAdjustSaturation => 'सैचुरेशन';

  @override
  String get editorToolCrop => 'क्रॉप';

  @override
  String get editorToolDraw => 'ड्रॉ';

  @override
  String get editorToolAdjust => 'एडजस्ट';

  @override
  String get editorTabSticker => 'स्टिकर';

  @override
  String get editorTabText => 'टेक्स्ट';

  @override
  String get editorPenPen => 'पेन';

  @override
  String get editorPenMarker => 'मार्कर';

  @override
  String get editorPenNeon => 'नियॉन';

  @override
  String get editorPenArrow => 'तीर';

  @override
  String get editorPenBlur => 'ब्लर';

  @override
  String get editorPenEraser => 'इरेज़र';

  @override
  String get editorLevel => 'सीधा करें';

  @override
  String get editorTextHint => 'फ़ोटो पर टेक्स्ट';

  @override
  String get editorCropFree => 'फ़्री';

  @override
  String get editorRemove => 'हटाएँ';

  @override
  String get notificationUnknownSender => 'नया मैसेज';

  @override
  String get bleUnknownPeer => 'अज्ञात पीयर';

  @override
  String get bleBroadcasting => 'ब्रॉडकास्ट हो रहा है';

  @override
  String bleConnectedCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n सेंट्रल कनेक्टेड',
      one: '1 सेंट्रल कनेक्टेड',
      zero: 'कोई सेंट्रल नहीं',
    );
    return '$_temp0';
  }

  @override
  String get verifyTitle => 'पीयर वेरिफ़ाई करें';

  @override
  String get verifyIntro =>
      'इन दोनों फ़िंगरप्रिंट को अपने पीयर के साथ आमने-सामने या वॉइस कॉल पर मिलाएँ। अगर दोनों तरफ़ ये एक जैसे हैं, तो पक्का है कि Noise हैंडशेक से छेड़छाड़ नहीं हुई।';

  @override
  String get verifyMine => 'आपका फ़िंगरप्रिंट';

  @override
  String verifyTheirs(String name) {
    return '$name का फ़िंगरप्रिंट';
  }

  @override
  String get verifyMarkAsVerified => 'वेरिफ़ाइड मार्क करें';

  @override
  String get verifyAlreadyDone => 'यह पीयर वेरिफ़ाइड है।';

  @override
  String get verifyRevoke => 'वापस लें';

  @override
  String verifyDoneSnack(String name) {
    return '$name वेरिफ़ाइड मार्क किए गए';
  }

  @override
  String get chatInputHint => 'मैसेज';

  @override
  String get chatSend => 'भेजें';

  @override
  String get chatToday => 'आज';

  @override
  String get chatYesterday => 'कल';

  @override
  String get chatDelivered => 'डिलीवर हुआ';

  @override
  String get chatRead => 'पढ़ा गया';

  @override
  String get chatSending => 'भेजा जा रहा है';

  @override
  String get chatWaitingForConnection => 'कनेक्शन का इंतज़ार';

  @override
  String sendQueueCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count मैसेज कनेक्शन का इंतज़ार कर रहे हैं',
      one: '1 मैसेज कनेक्शन का इंतज़ार कर रहा है',
    );
    return '$_temp0';
  }

  @override
  String sendQueueSlowNetwork(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'धीमा नेटवर्क — $count मैसेज भेजे जा रहे हैं',
      one: 'धीमा नेटवर्क — 1 मैसेज भेजा जा रहा है',
    );
    return '$_temp0';
  }

  @override
  String get sendQueueTitle => 'भेजे जाने बाकी';

  @override
  String get sendQueueHint =>
      'जैसे ही कोई रास्ता मिलेगा — आस-पास Bluetooth या इंटरनेट — ये अपने-आप चले जाएँगे। कुछ दबाने की ज़रूरत नहीं।';

  @override
  String get sendQueueRetry => 'अभी कोशिश करें';

  @override
  String get sendQueueCancel => 'भेजना रद्द करें';

  @override
  String get sendQueueCancelled => 'नहीं भेजा — वापस लिया गया';

  @override
  String get sendQueueTooLate => 'अब वापस नहीं ले सकते: मैसेज जा चुका है';

  @override
  String get chatEncryptedNotice =>
      'मैसेज Noise Protocol से एंड-टू-एंड एन्क्रिप्टेड हैं।';

  @override
  String get chatSessionHandshaking => 'सुरक्षित चैनल बन रहा है…';

  @override
  String get chatSessionEstablished => 'सुरक्षित · Noise XX';

  @override
  String get chatSessionFailed => 'कनेक्शन विफल';

  @override
  String get presenceOnline => 'ऑनलाइन';

  @override
  String get presenceOffline => 'ऑफ़लाइन';

  @override
  String get chatSessionFingerprintPending =>
      'हैंडशेक पूरा होते ही फ़िंगरप्रिंट दिखेगा।';

  @override
  String get chatEmptyEstablished =>
      'सुरक्षित चैनल तैयार है। बातचीत शुरू करने के लिए मैसेज भेजें।';

  @override
  String get chatEmptyHandshaking =>
      'दूसरी तरफ़ से हैंडशेक पूरा होने का इंतज़ार…';

  @override
  String get chatEmptyTitle => 'यहाँ अभी कोई मैसेज नहीं';

  @override
  String get chatEmptyGreetHint =>
      'मैसेज भेजें, या हैलो कहने के लिए Kubi पर टैप करें।';

  @override
  String get profileTitle => 'प्रोफ़ाइल';

  @override
  String get profileNickname => 'निकनेम';

  @override
  String get profileNicknameEditTitle => 'अपना निकनेम सेट करें';

  @override
  String get profileNicknameHint => 'mesh पर दूसरे आपको इस नाम से देखेंगे';

  @override
  String get profileNicknameSave => 'सेव करें';

  @override
  String get profileFingerprint => 'पब्लिक कुंजी फ़िंगरप्रिंट';

  @override
  String get profileLanguage => 'भाषा';

  @override
  String get profileLanguageEn => 'अंग्रेज़ी';

  @override
  String get profileLanguageUk => 'यूक्रेनी';

  @override
  String get profileTransport => 'ट्रांसपोर्ट';

  @override
  String get profileTransportMesh => 'Bluetooth mesh';

  @override
  String get profileBackground => 'बैकग्राउंड में उपलब्ध रहें';

  @override
  String get profileBackgroundSubtitle => 'ऐप बंद होने पर भी मैसेज मिलते रहें';

  @override
  String get profileBatteryExempt => 'बैटरी ऑप्टिमाइज़ेशन बंद करें';

  @override
  String get profileAbout => 'जानकारी';

  @override
  String profileVersion(String v) {
    return 'वर्शन $v';
  }

  @override
  String get rotateKeysTitle => 'अकाउंट कुंजियाँ बदलें';

  @override
  String get rotateKeysHint =>
      'अगर आपके अकाउंट वाला कोई डिवाइस खो गया या चोरी हो गया';

  @override
  String get rotateKeysConfirmTitle => 'अकाउंट कुंजियाँ बदलें?';

  @override
  String get rotateKeysConfirmBody =>
      'आपके संपर्कों को आपकी नई कुंजियाँ मिलेंगी और उनकी चैट बनी रहेंगी, लेकिन हर किसी से आपकी कुंजियाँ फिर से जाँचने को कहा जाएगा। आपके अकाउंट के बाकी सभी डिवाइस साइन आउट हो जाएँगे; जिन्हें रखना है, उन्हें इस फ़ोन से फिर लिंक करें। पुराने CubeChat वाले संपर्क अपडेट करने तक आप तक नहीं पहुँच पाएँगे। चैनलों की कुंजियाँ नहीं बदलेंगी।';

  @override
  String get rotateKeysConfirmAction => 'कुंजियाँ बदलें';

  @override
  String get rotateKeysWorking => 'कुंजियाँ बदली जा रही हैं…';

  @override
  String rotateKeysDone(int sent, int total) {
    return 'नई कुंजियाँ। $total में से $sent संपर्कों को बताया गया';
  }

  @override
  String get rotateKeysSlow =>
      'नई कुंजियाँ। हर संपर्क ने समय पर पुष्टि नहीं की; रिले उनके लिए इसे रखेंगे';

  @override
  String get profileEmergencyWipe => 'इमरजेंसी वाइप';

  @override
  String get profileEmergencyWipeConfirm => 'सब कुछ मिटाएँ?';

  @override
  String get profileEmergencyWipeConfirmHint =>
      'इससे आपकी पहचान, पीयर सूची और बातचीत का इतिहास हट जाएगा। इसे वापस नहीं किया जा सकता।';

  @override
  String get profileEmergencyWipeAction => 'मिटाएँ';

  @override
  String get cancel => 'रद्द करें';

  @override
  String get copy => 'कॉपी करें';

  @override
  String get copied => 'कॉपी हो गया';

  @override
  String get channelsNewTitle => 'नया चैनल';

  @override
  String get channelsNewTooltip => 'नया चैनल';

  @override
  String get channelNameLabel => 'चैनल का नाम';

  @override
  String get channelPasswordLabel => 'पासवर्ड (वैकल्पिक)';

  @override
  String get channelJoinAction => 'जुड़ें';

  @override
  String get channelNameHint =>
      'जो भी वही नाम और पासवर्ड डालेगा, वह उसी रूम में पहुँचेगा। उनकी सूची रखने वाला कोई सर्वर नहीं है।';

  @override
  String get channelPasswordHint =>
      'पासवर्ड ही कुंजी है। इसके बिना रूम आस-पास के हर उस व्यक्ति के लिए खुला है जो उसका नाम जानता है।';

  @override
  String get channelSubtitle => 'ग्रुप चैनल · साझा कुंजी';

  @override
  String get channelMute => 'म्यूट करें';

  @override
  String get channelUnmute => 'अनम्यूट करें';

  @override
  String channelMutedUntil(String time) {
    return '$time तक म्यूट';
  }

  @override
  String get channelMuteFor => 'इतनी देर म्यूट करें…';

  @override
  String channelMuteMinutes(int minutes) {
    return '$minutes मिनट';
  }

  @override
  String channelMuteHours(int hours) {
    return '$hours घंटे';
  }

  @override
  String channelMuteDays(int days) {
    return '$days दिन';
  }

  @override
  String get channelMuteForever => 'जब तक मैं वापस चालू न करूँ';

  @override
  String get channelCommunity => 'कमेंट';

  @override
  String get channelCommunityOpen => 'चर्चा खोलें';

  @override
  String channelCommunitySubtitle(String channel) {
    return '$channel की चर्चा';
  }

  @override
  String get channelBackToChannel => 'चैनल पर वापस';

  @override
  String get channelMemberActions => 'सदस्य';

  @override
  String get channelRemoveMember => 'चैनल से हटाएँ';

  @override
  String get channelRemoveMemberHint =>
      'उनकी पोस्ट अब यहाँ स्वीकार नहीं होंगी। नाम से दोबारा जुड़ने से उन्हें कुछ नहीं रोकता — साझा कुंजी ही एकमात्र सदस्यता है।';

  @override
  String get channelMuteMember => 'इतनी देर म्यूट करें…';

  @override
  String get channelUnmuteMember => 'फिर से पोस्ट करने दें';

  @override
  String channelMemberRemoved(String name) {
    return '$name को हटाया गया';
  }

  @override
  String channelMemberMuted(String name) {
    return '$name को म्यूट किया गया';
  }

  @override
  String channelMemberCleared(String name) {
    return '$name फिर से पोस्ट कर सकते हैं';
  }

  @override
  String get channelMemberMutedNote => 'म्यूट';

  @override
  String get channelShareHistory => 'इतिहास शेयर करें';

  @override
  String get channelShareHistoryHint =>
      'इस रूम की पिछली पोस्ट फिर से भेजता है, ताकि बाद में जुड़ने वाले उन्हें देख सकें। जो पहले से यहाँ थे, उन्हें कुछ नया नहीं मिलेगा।';

  @override
  String channelHistoryShared(int count) {
    return '$count पोस्ट भेजी गईं';
  }

  @override
  String get channelHistoryNothing => 'अभी शेयर करने को कुछ नहीं';

  @override
  String get channelHistoryAuto => 'नए सदस्यों को इतिहास दें';

  @override
  String get channelHistoryAutoHint =>
      'जब रूम में कोई नया आता है, तो हाल की पोस्ट अपने-आप उन तक जाती हैं। अभी सिर्फ़ टेक्स्ट — फ़ोटो टुकड़ों की स्ट्रीम में जाती हैं और सबके लिए दोहराए बिना फिर से नहीं भेजी जा सकतीं।';

  @override
  String get channelPostComments => 'कमेंट';

  @override
  String get channelNoComments => 'इस पर अभी किसी ने कुछ नहीं कहा';

  @override
  String get channelCommentHint => 'कमेंट';

  @override
  String get channelMuteCustom => 'कितनी देर के लिए?';

  @override
  String get channelMuteCustomHint => 'घंटे';

  @override
  String get chatPinnedManage => 'पिन किए गए';

  @override
  String get chatPeekOpen => 'चैट खोलें';

  @override
  String get chatPeekPin => 'पिन करें';

  @override
  String get chatPeekUnpin => 'अनपिन करें';

  @override
  String get chatPeekUnmute => 'अनम्यूट करें';

  @override
  String get chatPeekMarkRead => 'पढ़ा हुआ मार्क करें';

  @override
  String get chatDeleteForMeHint =>
      'इस फ़ोन से हटाया और अनपिन किया जाएगा। दूसरी तरफ़ उनकी कॉपी बनी रहेगी।';

  @override
  String get pushWakeTitle => 'इस फ़ोन को जगाएँ';

  @override
  String get pushWakeHint =>
      'एक छोटा सर्वर रिले पर आपके पते पर नज़र रखता है और कुछ आने पर इस फ़ोन को जगा देता है, ताकि बंद ऐप भी आपको बता सके। वह कभी कोई मैसेज या कुंजी नहीं देखता — बस इतना कि आपके पते पर कुछ आया, और कब। रिले यह पहले से जानता है; यह दूसरी जगह है जो इसे जानती है।';

  @override
  String get pushWakeDeniedTitle => 'नोटिफ़िकेशन बंद हैं';

  @override
  String get pushWakeDeniedHint =>
      'सिस्टम को एक बार “नहीं” कहा जा चुका है और वह फिर नहीं पूछेगा, इसलिए इसे सिर्फ़ सेटिंग्स में चालू किया जा सकता है — cubechat, फिर नोटिफ़िकेशन। उसके बाद यहाँ वापस आएँ।';

  @override
  String get pushWakeRefused => 'नोटिफ़िकेशन की अनुमति नहीं मिली';

  @override
  String get privacyForwardLinkTitle => 'फ़ॉरवर्ड में प्रोफ़ाइल लिंक';

  @override
  String get privacyForwardLinkHint =>
      'जब कोई आपका मैसेज आगे भेजता है, तो उसके ऊपर की लाइन से आपकी प्रोफ़ाइल खुल सकती है। बंद होने पर उन्हें सिर्फ़ आपका नाम दिखेगा, टैप करने को कुछ नहीं। यह उनके ऐप से एक अनुरोध है, यह ऐप इसे लागू नहीं करवा सकता।';

  @override
  String get privacyShareSheetTitle => 'शेयर मेन्यू में चैट';

  @override
  String get privacyShareSheetOnHint =>
      'आपकी चार सबसे हाल की चैट के नाम Android को दिए जाते हैं, ताकि आप किसी भी ऐप से उन्हें भेज सकें। ऐप लॉक उन्हें नहीं छिपाता।';

  @override
  String get privacyShareSheetOffHint =>
      'Android को कुछ नहीं दिया जाता। CubeChat में शेयर करने पर आपसे चैट चुनने को कहा जाएगा।';

  @override
  String get privacyCallsTitle => 'कॉल स्वीकार करें';

  @override
  String get privacyCallsOnHint =>
      'आपके संपर्क आपको कॉल कर सकते हैं। किसी एक को रोकने के लिए उनकी प्रोफ़ाइल खोलें।';

  @override
  String get privacyCallsOffHint =>
      'कोई आपको कॉल नहीं कर सकता, सिवाय उनके जिन्हें आपने उनकी प्रोफ़ाइल में अनुमति दी है। रोकी गई कॉल उन्हें व्यस्त दिखेगी।';

  @override
  String get chatsStatusChannel => 'चैनल';

  @override
  String get channelInviteTitle => 'लोग जोड़ें';

  @override
  String get channelInviteAction => 'आमंत्रित करें';

  @override
  String get channelInviteEmpty =>
      'अभी कोई जाना-पहचाना पीयर नहीं। पहले “आस-पास” टैब पर किसी से मिलें।';

  @override
  String get channelInviteSent => 'आमंत्रण भेजे गए';

  @override
  String get channelInviteNoneSent => 'अभी किसी तक नहीं पहुँचा जा सका';

  @override
  String get channelNameTooLong => 'चैनल का नाम बहुत लंबा है';

  @override
  String get chatsActionFavorite => 'पसंदीदा में जोड़ें';

  @override
  String get chatsActionUnfavorite => 'पसंदीदा से हटाएँ';

  @override
  String get chatsActionDelete => 'चैट डिलीट करें';

  @override
  String get chatsDeleteTitle => 'यह चैट डिलीट करें?';

  @override
  String chatsDeleteManyHint(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          '$count बातचीत मिट जाएँगी। संपर्क बने रहेंगे, इसलिए आप कोड बदले बिना उन्हें फिर से लिख सकते हैं।',
    );
    return '$_temp0';
  }

  @override
  String get chatsDeletedToast => 'चैट डिलीट हो गई।';

  @override
  String chatsDeletedManyToast(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count चैट डिलीट हुईं।',
      one: '$count चैट डिलीट हुई।',
    );
    return '$_temp0';
  }

  @override
  String get undo => 'पहले जैसा करें';

  @override
  String get chatsDeletePeerHint =>
      'बातचीत मिट जाएगी। संपर्क बना रहेगा, इसलिए आप कोड बदले बिना उन्हें फिर से लिख सकते हैं।';

  @override
  String get chatsDeleteChannelHint =>
      'चैनल छोड़ देगा और उसका इतिहास हटा देगा। फिर से जुड़ने के लिए आपको दोबारा कुंजी चाहिए होगी।';

  @override
  String get chatsDeleteForThemToo => 'उनके लिए भी डिलीट करें';

  @override
  String get chatsDeleteForThemHint =>
      'उनके ऐप से भी पूरी बातचीत मिटाने को कहता है, उनके लिखे मैसेज समेत। चैनल में सिर्फ़ आपके अपने मैसेज वापस लिए जाते हैं।';

  @override
  String get chatEditAction => 'एडिट करें';

  @override
  String get chatEditTitle => 'मैसेज एडिट करें';

  @override
  String get chatEditSave => 'सेव करें';

  @override
  String get chatEdited => 'एडिट किया गया';

  @override
  String get chatDeleteAction => 'डिलीट करें';

  @override
  String get chatDeleteTitle => 'मैसेज डिलीट करें?';

  @override
  String get chatDeleteForMe => 'मेरे लिए डिलीट करें';

  @override
  String get chatDeleteForEveryone => 'सभी के लिए डिलीट करें';

  @override
  String get chatPinTitle => 'मैसेज पिन करें?';

  @override
  String get chatPinForBoth => 'हम दोनों के लिए पिन करें';

  @override
  String get chatPinForMe => 'सिर्फ़ मेरे लिए पिन करें';

  @override
  String get chatReplyAction => 'जवाब दें';

  @override
  String chatReplyingTo(String name) {
    return '$name को जवाब';
  }

  @override
  String get chatReplyYou => 'खुद को';

  @override
  String get chatCopyAction => 'कॉपी करें';

  @override
  String get chatCopied => 'कॉपी हो गया';

  @override
  String get chatForwardAction => 'फ़ॉरवर्ड करें';

  @override
  String get chatForwardTitle => 'इसे फ़ॉरवर्ड करें';

  @override
  String get shareIntoTitle => 'इसे भेजें';

  @override
  String get shareNearbyAirDrop => 'AirDrop से आस-पास';

  @override
  String get shareNearbyAirDropHint =>
      'इंटरनेट की ज़रूरत नहीं — पास के लोगों को';

  @override
  String get shareSent => 'भेजा गया';

  @override
  String get shareFailed => 'कुछ हिस्सा भेजा नहीं जा सका';

  @override
  String get chatForwardEmpty => 'अभी कोई और चैट नहीं';

  @override
  String chatForwardSendCount(int count) {
    return 'भेजें ($count)';
  }

  @override
  String chatForwardSentCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count चैट में फ़ॉरवर्ड किया',
      one: 'एक चैट में फ़ॉरवर्ड किया',
    );
    return '$_temp0';
  }

  @override
  String chatForwardSent(String name) {
    return '$name को फ़ॉरवर्ड किया';
  }

  @override
  String chatSentAt(String time) {
    return '$time को भेजा';
  }

  @override
  String chatReadAt(String time) {
    return '$time को पढ़ा';
  }

  @override
  String get chatPinAction => 'पिन करें';

  @override
  String get chatUnpinAction => 'अनपिन करें';

  @override
  String chatPinnedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count पिन किए मैसेज',
      one: '1 पिन किया मैसेज',
      zero: 'कोई पिन किया मैसेज नहीं',
    );
    return '$_temp0';
  }

  @override
  String get chatNoPins => 'यहाँ कुछ भी पिन नहीं है';

  @override
  String get chatUnpinAll => 'सभी मैसेज अनपिन करें';

  @override
  String get chatShowAllPins => 'सभी पिन किए मैसेज';

  @override
  String get chatUnpinConfirm => 'यह मैसेज अनपिन करें?';

  @override
  String get chatUnpinConfirmHint => 'यह इस चैट में सभी के लिए अनपिन हो जाएगा।';

  @override
  String get chatPinnedTitle => 'पिन किया मैसेज';

  @override
  String get chatPinnedGone => 'वह मैसेज अब इस चैट में नहीं है';

  @override
  String get peerBlock => 'ब्लॉक करें';

  @override
  String get peerUnblock => 'अनब्लॉक करें';

  @override
  String get peerMute => 'म्यूट करें';

  @override
  String get peerUnmute => 'अनम्यूट करें';

  @override
  String get peerBlockedNote => 'ब्लॉक है — उनके मैसेज छोड़ दिए जाते हैं।';

  @override
  String get relaysTitle => 'इंटरनेट बैकअप रास्ता';

  @override
  String get relaysCardTitle => 'इंटरनेट से पीयर तक पहुँचें';

  @override
  String get relaysCardSubtitle =>
      'जब Bluetooth से डिलीवर न हो, तो Nostr रिले से भेजें';

  @override
  String get relaysExplainer =>
      'मैसेज एंड-टू-एंड एन्क्रिप्टेड रहते हैं — रिले वही सील किया फ़्रेम ले जाता है जो Bluetooth ले जाता। हाँ, उसे यह पता चलता है कि कौन-सी दो कुंजियाँ आपस में बात कर रही हैं, और कब। डिफ़ॉल्ट रूप से बंद।';

  @override
  String get relaysMyAddress => 'आपका रिले पता';

  @override
  String get relaysCopied => 'कॉपी हो गया';

  @override
  String get circleLensTitle => 'सर्कल के लिए फ़्रंट कैमरा';

  @override
  String get circleLensFrontHint =>
      'गोल वीडियो मैसेज आपकी ओर वाले कैमरे से रिकॉर्ड होते हैं।';

  @override
  String get circleLensBackHint =>
      'गोल वीडियो मैसेज पीछे वाले कैमरे से रिकॉर्ड होते हैं, ताकि आप जो देख रहे हैं वह दिखा सकें।';

  @override
  String get channelCloseTitle => 'यह रूम सभी के लिए बंद करें';

  @override
  String get channelCloseSubtitle =>
      'हर सदस्य के फ़ोन से इसे हटा देता है। यह सिर्फ़ आप कर सकते हैं।';

  @override
  String get channelCloseConfirm =>
      'रूम, उसके मैसेज और उसके सदस्य हर उस फ़ोन से हट जाएँगे जिस पर वह है। किसी को रोका नहीं जाता: कुंजी नाम से बनती है, इसलिए जिसे नाम याद है वह फिर से एक खाली रूम खोल सकता है।';

  @override
  String get channelCloseAction => 'रूम बंद करें';

  @override
  String get circleHint =>
      'भेजने के लिए छोड़ें · रद्द करने के लिए बाएँ खिसकाएँ';

  @override
  String get circleHintLocked => 'हो जाने पर भेजें पर टैप करें';

  @override
  String get circleNeedsCamera => 'सर्कल के लिए कैमरा और माइक्रोफ़ोन चाहिए';

  @override
  String get circleFailed => 'वह सर्कल रिकॉर्ड नहीं हो सका';

  @override
  String get relaysListLabel => 'रिले';

  @override
  String get relaysLaneMedia => 'मीडिया रिले';

  @override
  String get relaysLaneMediaNote =>
      'फ़ोटो, फ़ाइलें और वीडियो इनसे जाते हैं, ताकि ट्रांसफ़र से बातचीत धीमी न हो।';

  @override
  String get relaysLaneLocation => 'लोकेशन रिले';

  @override
  String get relaysLaneLocationNote =>
      'मैप बीकन इनसे जाते हैं, बाकी सब से अलग।';

  @override
  String get relaysAdd => 'रिले जोड़ें';

  @override
  String get relaysAddHint => 'wss://relay.example.com';

  @override
  String get relaysInvalidUrl => 'wss:// या ws:// पता डालें';

  @override
  String get relaysRemove => 'हटाएँ';

  @override
  String get relaysStateConnected => 'कनेक्टेड';

  @override
  String get relaysStateConnecting => 'कनेक्ट हो रहा है…';

  @override
  String get relaysStateFailed => 'पहुँच से बाहर';

  @override
  String get relaysStateIdle => 'बंद';

  @override
  String get relaysEmpty => 'कोई रिले सेट नहीं — बैकअप रास्ता बंद रहेगा।';

  @override
  String get contactTitle => 'संपर्क कार्ड';

  @override
  String get contactMineLabel => 'आपका कार्ड';

  @override
  String get contactMineExplainer =>
      'इसे उस व्यक्ति को भेजें जो Bluetooth रेंज से बाहर है। इसमें आपकी कुंजियाँ और आपका रिले पता है — इतना काफ़ी है कि वे इंटरनेट पर आपके साथ एन्क्रिप्टेड चैट शुरू कर सकें।';

  @override
  String get contactCopy => 'कॉपी करें';

  @override
  String get contactShare => 'शेयर करें';

  @override
  String get contactCopied => 'कार्ड कॉपी हो गया';

  @override
  String get contactShareSubject => 'मेरा cubechat संपर्क कार्ड';

  @override
  String get contactAddLabel => 'किसी को जोड़ें';

  @override
  String get contactAddHint => 'संपर्क कार्ड पेस्ट करें';

  @override
  String get contactAddAction => 'जोड़ें';

  @override
  String get contactPaste => 'पेस्ट करें';

  @override
  String contactAdded(String name) {
    return '$name जोड़े गए';
  }

  @override
  String get contactInvalid => 'यह सही संपर्क कार्ड नहीं है';

  @override
  String get contactOwnCard => 'यह आपका अपना कार्ड है';

  @override
  String get contactUnverified =>
      'इस तरह जोड़ा गया संपर्क शुरू में अनवेरिफ़ाइड होता है। कोई भी कार्ड बनाकर उस पर कोई भी नाम लिख सकता है, इसलिए पहचान पर भरोसा करने से पहले आमने-सामने या कॉल पर फ़िंगरप्रिंट मिलाएँ।';

  @override
  String get contactRelayOff =>
      'इंटरनेट बैकअप रास्ता बंद है, इसलिए कार्ड अभी किसी तक नहीं पहुँच सकता।';

  @override
  String get contactRelayEnable => 'चालू करें';

  @override
  String get profileContactCard => 'संपर्क कार्ड';

  @override
  String get chatsAddContactTooltip => 'कार्ड से संपर्क जोड़ें';

  @override
  String get chatsMenuTooltip => 'और';

  @override
  String get chatsMenuAddContact => 'संपर्क जोड़ें';

  @override
  String get chatsMenuNewChannel => 'नया चैनल';

  @override
  String get profileDiscoverable => 'आस-पास दिखें';

  @override
  String get profileDiscoverableOnHint => 'रेंज में कोई भी आपको ढूँढ सकता है';

  @override
  String get profileDiscoverableOffHint =>
      'सिर्फ़ आपके संपर्क आप तक पहुँच सकते हैं';

  @override
  String get profileDiscoverableExplainer =>
      'चालू होने पर आपकी घोषणा खुले में ब्रॉडकास्ट होती है, ताकि अनजान लोग पास आकर आपसे मिल सकें — और सुनने वाला कोई भी आपकी कुंजी और नाम रिकॉर्ड कर सकता है। बंद होने पर वही जानकारी सील होकर सिर्फ़ आपके मौजूदा संपर्कों को जाती है, और आपकी रूटिंग ID आपस में जोड़ी नहीं जा सकतीं। तब नए लोगों को संपर्क कार्ड चाहिए होगा।';

  @override
  String get voiceHoldHint => 'वॉइस मैसेज रिकॉर्ड करने के लिए दबाकर रखें';

  @override
  String get voiceTrimPlay => 'चलाएँ';

  @override
  String get voiceTrimPause => 'रोकें';

  @override
  String get voiceTrimDiscard => 'रिकॉर्डिंग हटाएँ';

  @override
  String voiceTrimSelection(String duration) {
    return '$duration भेजा जा रहा है';
  }

  @override
  String get profileLastSeen => 'लास्ट सीन दिखाएँ';

  @override
  String get profileLastSeenOnHint => 'संपर्क देख सकते हैं कि आप कब ऐप में हैं';

  @override
  String get profileLastSeenOffHint =>
      'कोई आपका समय नहीं देखता, और आप किसी का नहीं: सिर्फ़ कौन ऑनलाइन है';

  @override
  String get profileMapLocation => 'मुझे मैप पर दिखाएँ';

  @override
  String get profileMapLocationOnHint =>
      'लोकेशन हाथ से शेयर करने के लिए उपलब्ध है और आपका पिन मैप पर दिखता है';

  @override
  String get profileMapLocationOffHint =>
      'ऐप लोकेशन नहीं माँगता और आपका पिन छिपा रहता है';

  @override
  String get desktopAutostartTitle => 'Windows के साथ शुरू करें';

  @override
  String get desktopAutostartHint =>
      'CubeChat ट्रे में इंतज़ार करता है, ताकि विंडो बंद होने पर भी कॉल और मैसेज इस कंप्यूटर तक पहुँचें';

  @override
  String get trayOpen => 'CubeChat खोलें';

  @override
  String get trayQuit => 'बंद करें';

  @override
  String get callDirectTitle => 'डायरेक्ट कॉल';

  @override
  String get callDirectOnHint =>
      'तेज़, लेकिन जिसे आप कॉल करते हैं उसे आपका IP पता पता चल जाता है';

  @override
  String get callDirectOffHint =>
      'कॉल हमारे रिले से जाती हैं: जिसे आप कॉल करते हैं वह आपका IP कभी नहीं देखता, और रिले कॉल नहीं सुन सकता';

  @override
  String get profileReadReceipts => 'रीड रसीद भेजें';

  @override
  String get profileReadReceiptsOnHint =>
      'भेजने वाले देख सकते हैं कि आपने कब पढ़ा';

  @override
  String get profileReadReceiptsOffHint =>
      'आप पढ़ने का समय नहीं भेजते, पर दूसरों का देखते रहते हैं';

  @override
  String get profilePrivacyExplainer =>
      'लास्ट सीन दोनों तरफ़ लागू होता है: अपना स्टेटस छिपाएँगे तो दूसरों का भी नहीं देख पाएँगे। रीड रसीद सिर्फ़ यह तय करती हैं कि आप क्या भेजते हैं। मैसेज की डिलीवरी पर कोई असर नहीं होता।';

  @override
  String get chatTimerAction => 'टाइमर';

  @override
  String get chatTimerRemove => 'टाइमर हटाएँ';

  @override
  String get chatTimerTitle => 'यह मैसेज इतनी देर बाद डिलीट करें';

  @override
  String chatTimerSet(String time) {
    return 'यह मैसेज $time में हट जाएगा';
  }

  @override
  String get chatTimerLocalHint => 'सिर्फ़ इस डिवाइस पर — उनकी कॉपी उनकी है';

  @override
  String get contactTagAction => 'लेबल';

  @override
  String get contactTagRemove => 'लेबल हटाएँ';

  @override
  String get contactTagTitle => 'लेबल चुनें';

  @override
  String get contactTagAll => 'सभी';

  @override
  String get quietHoursTitle => 'शांत समय';

  @override
  String get quietHoursHint => 'मैसेज आते रहेंगे; फ़ोन चुप रहेगा';

  @override
  String get quietHoursFrom => 'से';

  @override
  String get quietHoursTo => 'तक';

  @override
  String get notifPreviewTitle => 'नोटिफ़िकेशन में दिखाएँ';

  @override
  String get notifPreviewFull => 'नाम और टेक्स्ट';

  @override
  String get notifPreviewNameOnly => 'सिर्फ़ नाम';

  @override
  String get notifPreviewHidden => 'कुछ नहीं';

  @override
  String get notifPreviewHint =>
      'नोटिफ़िकेशन लॉक स्क्रीन पर और नोटिफ़िकेशन ऐक्सेस वाले ऐप्स को दिखते हैं, ऐप लॉक चालू होने पर भी';

  @override
  String get notifPreviewNewMessage => 'नया मैसेज';

  @override
  String get appLockTitle => 'ऐप लॉक';

  @override
  String get appLockHint => 'ऐप खोलने पर कोड माँगें';

  @override
  String get appLockPrompt => 'अपना कोड डालें';

  @override
  String get appLockUnlock => 'अनलॉक करें';

  @override
  String get appLockWrong => 'गलत कोड';

  @override
  String get appLockSetTitle => 'कोड सेट करें';

  @override
  String get appLockSetHint =>
      'चार या ज़्यादा अंक। इसे रिकवर करने का कोई तरीका नहीं है।';

  @override
  String get appLockOffTitle => 'लॉक बंद करें';

  @override
  String get appLockOffHint => 'अपना मौजूदा कोड डालें';

  @override
  String get appLockOn => 'ऐप लॉक चालू है';

  @override
  String get appLockOff => 'ऐप लॉक बंद है';

  @override
  String get avatarSet => 'फ़ोटो चुनें';

  @override
  String get avatarChange => 'फ़ोटो बदलें';

  @override
  String get avatarView => 'फ़ोटो देखें';

  @override
  String get profileCoverPhoto =>
      'प्रोफ़ाइल फ़ोटो, बड़ा करने के लिए डबल टैप करें';

  @override
  String get profileCoverMenu => 'फ़ोटो विकल्प';

  @override
  String get avatarSaved => 'गैलरी में सेव हो गई';

  @override
  String get avatarRemove => 'फ़ोटो हटाएँ';

  @override
  String get avatarRemoveConfirm =>
      'अवतार इस डिवाइस से डिलीट हो जाएगा। उसकी जगह बना हुआ ग्रेडिएंट वापस आ जाएगा।';

  @override
  String get avatarFailed => 'वह इमेज पढ़ी नहीं जा सकी';

  @override
  String get fileOpenHint => 'खोलने के लिए टैप करें';

  @override
  String get fileMissing => 'वह फ़ाइल अब उपलब्ध नहीं है';

  @override
  String get fileNoHandlerTitle => 'कोई ऐप इसे नहीं खोल सकता';

  @override
  String get fileNoHandlerHint =>
      'इंस्टॉल किया कोई भी ऐप इस फ़ाइल टाइप को नहीं खोलता। आप इसे किसी दूसरे ऐप को भेज सकते हैं।';

  @override
  String get fileRequestedAgain => 'भेजने वाले से फिर माँगा गया';

  @override
  String get fileOpenFailed => 'यह फ़ाइल नहीं खुल सकी';

  @override
  String get fileShareAction => 'ऐप को भेजें';

  @override
  String fileTooLargeMesh(int limit) {
    return 'फ़ाइल बहुत बड़ी है — mesh पर सीमा $limit MB है';
  }

  @override
  String fileTooLargeRelay(int limit) {
    return 'इंटरनेट पर सीमा $limit MB है। बड़ी फ़ाइल भेजने के लिए पाने वाले के पास जाएँ।';
  }

  @override
  String get mediaSendOriginal => 'ओरिजिनल';

  @override
  String get attachFile => 'फ़ाइल';

  @override
  String get attachGallery => 'गैलरी';

  @override
  String get attachCamera => 'कैमरा';

  @override
  String get cameraUnavailable => 'कैमरा उपलब्ध नहीं';

  @override
  String get profileEditName => 'नाम';

  @override
  String get profileMyCard => 'कार्ड';

  @override
  String get mediaCaptionHint => 'कैप्शन जोड़ें…';

  @override
  String get mediaDiscardTitle => 'चुनाव छोड़ें?';

  @override
  String get mediaDiscardMessage => 'गैलरी बंद करें और चुनी गई फ़ोटो छोड़ दें?';

  @override
  String get mediaDiscardConfirm => 'छोड़ें';

  @override
  String get mediaPhotosAccessOff => 'फ़ोटो ऐक्सेस बंद है';

  @override
  String get mediaPhotosAccessOffHint =>
      'CubeChat अभी सिर्फ़ वीडियो देख सकता है। अपनी तस्वीरें दिखाने के लिए सिस्टम सेटिंग्स में फ़ोटो ऐक्सेस की अनुमति दें।';

  @override
  String get mediaVideosOnly =>
      'सिर्फ़ वीडियो दिख रहे हैं — फ़ोटो ऐक्सेस की अनुमति दें';

  @override
  String get mediaOpenSettings => 'सेटिंग्स खोलें';

  @override
  String get mediaTakePhoto => 'फ़ोटो लें';

  @override
  String get contactProfileAutoDelete => 'चैट ऑटो-डिलीट';

  @override
  String get contactProfileAutoDeleteTitle => 'मैसेज ऑटो-डिलीट';

  @override
  String get contactProfileAutoDeleteOff => 'बंद';

  @override
  String get contactProfileAutoDeleteOneDay => '1 दिन बाद';

  @override
  String get contactProfileAutoDeleteSevenDays => '7 दिन बाद';

  @override
  String get contactProfileAutoDeleteThirtyDays => '30 दिन बाद';

  @override
  String contactProfileAutoDeleteUpdated(String period) {
    return 'ऑटो-डिलीट: $period';
  }

  @override
  String get contactProfileShare => 'संपर्क शेयर करें';

  @override
  String get contactProfileShareTitle => 'संपर्क इसे भेजें';

  @override
  String get contactProfileShareEmpty => 'अभी कोई और चैट नहीं';

  @override
  String contactProfileShareSent(String name) {
    return '$name को भेजा गया';
  }

  @override
  String get contactProfileRestrictCopying => 'कॉपी करना बंद करें';

  @override
  String get contactProfileAllowCopying => 'कॉपी करने दें';

  @override
  String get contactHideAvatar => 'मेरी फ़ोटो छिपाएँ';

  @override
  String get contactShowAvatar => 'मेरी फ़ोटो दिखाएँ';

  @override
  String get contactHideLastSeen => 'मेरा लास्ट सीन छिपाएँ';

  @override
  String get contactShowLastSeen => 'मेरा लास्ट सीन दिखाएँ';

  @override
  String get contactHideReadReceipts => 'मेरा पढ़ने का समय छिपाएँ';

  @override
  String get contactShowReadReceipts => 'मेरा पढ़ने का समय दिखाएँ';

  @override
  String get contactHiddenFromThem => 'इस संपर्क से छिपा है';

  @override
  String get contactRefuseCalls => 'इनकी कॉल स्वीकार न करें';

  @override
  String get contactAllowCalls => 'इनकी कॉल स्वीकार करें';

  @override
  String get contactCallsException => 'आपकी कॉल सेटिंग से अपवाद';

  @override
  String get contactProfileCopyingRestricted => 'कॉपी और फ़ॉरवर्ड करना बंद है';

  @override
  String get contactProfileCopyingRestrictedByPeer =>
      'दूसरी तरफ़ से बंद किया गया';

  @override
  String get contactProfileCopyingAllowed =>
      'कॉपी और फ़ॉरवर्ड करने की अनुमति है';

  @override
  String get contactProfileDelete => 'संपर्कों से हटाएँ';

  @override
  String get contactProfileRestore => 'संपर्कों में वापस जोड़ें';

  @override
  String get contactProfileRestoreDone => 'फिर से आपके संपर्कों में';

  @override
  String get contactProfileDeleteTitle => 'संपर्क हटाएँ?';

  @override
  String contactProfileDeleteMessage(String name) {
    return '$name संपर्कों से हट जाएँगे। चैट का इतिहास इस डिवाइस पर बना रहेगा।';
  }

  @override
  String get contactProfileMedia => 'मीडिया';

  @override
  String get contactProfileVoiceMessages => 'वॉइस मैसेज';

  @override
  String get contactProfileStickers => 'स्टिकर';

  @override
  String get contactProfileNoStickers => 'अभी कोई स्टिकर नहीं';

  @override
  String get contactProfileNoMedia => 'अभी कोई मीडिया नहीं';

  @override
  String get contactProfileNoVoiceMessages => 'अभी कोई वॉइस मैसेज नहीं';

  @override
  String get contactProfileOpen => 'प्रोफ़ाइल खोलें';

  @override
  String autoDeleteDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count दिन',
      one: '$count दिन',
    );
    return '$_temp0';
  }

  @override
  String autoDeleteHours(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count घंटे',
      one: '$count घंटा',
    );
    return '$_temp0';
  }

  @override
  String autoDeleteMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count मिनट',
      one: '$count मिनट',
    );
    return '$_temp0';
  }

  @override
  String autoDeleteSeconds(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count सेकंड',
      one: '$count सेकंड',
    );
    return '$_temp0';
  }

  @override
  String get autoDeleteCustom => 'कस्टम…';

  @override
  String get autoDeleteCustomHint => 'मात्रा';

  @override
  String get autoDeleteUnitMinutes => 'मिनट';

  @override
  String get autoDeleteUnitHours => 'घंटे';

  @override
  String get autoDeleteUnitDays => 'दिन';

  @override
  String get contactProfileAutoDeleteSet => 'सेट करें';

  @override
  String get contactProfileFiles => 'फ़ाइलें';

  @override
  String get contactProfileNoFiles => 'अभी कोई फ़ाइल नहीं';

  @override
  String get contactProfileLinks => 'लिंक';

  @override
  String get contactProfileNoLinks => 'अभी कोई लिंक नहीं';

  @override
  String get contactProfilePolls => 'पोल';

  @override
  String get contactProfileNoPolls => 'अभी कोई पोल नहीं';

  @override
  String get presenceRecently => 'हाल ही में देखे गए';

  @override
  String get presenceJustNow => 'अभी-अभी';

  @override
  String presenceHoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count घंटे पहले',
      one: '$count घंटा पहले',
    );
    return '$_temp0';
  }

  @override
  String presenceYesterdayAt(String time) {
    return 'कल $time बजे';
  }

  @override
  String presenceOnWeekday(String day) {
    String _temp0 = intl.Intl.selectLogic(
      day,
      {
        '1': 'सोमवार को',
        '2': 'मंगलवार को',
        '3': 'बुधवार को',
        '4': 'गुरुवार को',
        '5': 'शुक्रवार को',
        '6': 'शनिवार को',
        '7': 'रविवार को',
        'other': 'इस हफ़्ते',
      },
    );
    return '$_temp0';
  }

  @override
  String presenceWeeksAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count हफ़्ते पहले',
      one: 'एक हफ़्ता पहले',
    );
    return '$_temp0';
  }

  @override
  String presenceMonthsAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count महीने पहले',
      one: 'एक महीना पहले',
    );
    return '$_temp0';
  }

  @override
  String get presenceLongAgo => 'काफ़ी समय पहले';

  @override
  String presenceMinutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count मिनट पहले',
      one: '$count मिनट पहले',
    );
    return '$_temp0';
  }

  @override
  String chatReadByCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ने पढ़ा',
      one: '$count ने पढ़ा',
    );
    return '$_temp0';
  }

  @override
  String get chatsSearchFrequent => 'जिनसे आप बात करते हैं';

  @override
  String get chatsSearchRecent => 'हाल के';

  @override
  String get chatsSearchClear => 'साफ़ करें';

  @override
  String get chatsSearchStartHint =>
      'नाम से चैट खोजें, या शब्दों से कोई भी मैसेज।';

  @override
  String get chatsSearchEmpty => 'इससे कुछ भी मेल नहीं खाता';

  @override
  String get chatRoutesTitle => 'यह उन तक कैसे पहुँचता है';

  @override
  String get chatRoutesBluetoothHint => 'सीधे उनके फ़ोन पर, बिना इंटरनेट';

  @override
  String get chatRoutesMeshHint => 'बीच के फ़ोन से होकर';

  @override
  String get chatRoutesInternetHint => 'रिले से, जब कोई रेंज में न हो';

  @override
  String get chatRoutesHint =>
      'रास्ता हर मैसेज के लिए अलग चुना जाता है, उस पल जो भी पहुँच में हो उसमें से।';

  @override
  String get chatRoutesPreferTitle => 'पहले क्या आज़माएँ';

  @override
  String get chatRoutesPreferMesh => 'पहले Bluetooth';

  @override
  String get chatRoutesPreferMeshHint =>
      'एक ही कमरे में तेज़, डेटा खर्च नहीं, रिले को कुछ पता नहीं चलता';

  @override
  String get chatRoutesPreferRelay => 'पहले इंटरनेट';

  @override
  String get chatRoutesPreferRelayHint =>
      'जब Bluetooth कमज़ोर हो और इंटरनेट अच्छा हो';

  @override
  String get chatRoutesPreferNote =>
      'यह पसंद है, बंदिश नहीं। अगर चुना रास्ता उपलब्ध नहीं है, तो मैसेज दूसरे रास्ते से फिर भी जाएगा।';

  @override
  String get deadmanTitle => 'इस्तेमाल न होने पर मिटाएँ';

  @override
  String get deadmanOff => 'बंद';

  @override
  String deadmanDays(int days) {
    return '$days दिन बाद';
  }

  @override
  String get deadmanHint =>
      'अगर इतने समय तक कोई यह ऐप नहीं खोलता, तो अगली बार खुलने पर इसमें सब कुछ मिटा दिया जाएगा। यह पहले से चेतावनी नहीं दे सकता — यही इसका मकसद है।';

  @override
  String chatForwardedFrom(String name) {
    return '$name से फ़ॉरवर्ड किया गया';
  }

  @override
  String appLockWait(String left) {
    return 'बहुत ज़्यादा कोशिशें — $left रुकें';
  }

  @override
  String get appLockGraceTitle => 'कोड माँगें';

  @override
  String get appLockGraceNow => 'हर बार';

  @override
  String appLockGraceAfter(String left) {
    return '$left दूर रहने के बाद';
  }

  @override
  String get chatCalendarTitle => 'तारीख़ से';

  @override
  String get chatCalendarEmpty => 'यहाँ अभी तक कुछ नहीं कहा गया';

  @override
  String get chatsSearchChatsSection => 'चैट';

  @override
  String get chatsSearchMessagesSection => 'मैसेज';

  @override
  String get contactProfileViewInChat => 'चैट में देखें';

  @override
  String get chatDraft => 'ड्राफ़्ट';

  @override
  String get chatSearchTitle => 'खोजें';

  @override
  String get chatSearchHint => 'मैसेज खोजें';

  @override
  String get chatSearchNoResults => 'कोई नतीजा नहीं';

  @override
  String get chatSearchPrevious => 'पिछला नतीजा';

  @override
  String get chatSearchNext => 'अगला नतीजा';

  @override
  String chatMessageCount(int count) {
    return '$count मैसेज';
  }

  @override
  String get chatRouteBluetooth => 'Bluetooth';

  @override
  String get chatRouteMesh => 'मेश';

  @override
  String get chatRouteInternet => 'इंटरनेट';

  @override
  String get chatRouteQueued => 'कतार में';

  @override
  String get attachStickers => 'स्टिकर';

  @override
  String get stickersEmpty => 'अभी कोई स्टिकर नहीं';

  @override
  String get stickersEmptyHint => 'चैट से कोई तस्वीर सेव करें, वह यहाँ दिखेगी।';

  @override
  String get stickerKeep => 'स्टिकर के रूप में सेव करें';

  @override
  String get stickerKept => 'आपके स्टिकर में सेव हो गया';

  @override
  String get stickerForget => 'स्टिकर हटाएँ';

  @override
  String get stickerCreate => 'फ़ोटो से स्टिकर बनाएँ';

  @override
  String get stickerFailed => 'उस तस्वीर से स्टिकर नहीं बन सका';

  @override
  String get stickerLabel => 'स्टिकर';

  @override
  String get previewPhoto => 'फ़ोटो';

  @override
  String get previewVoice => 'वॉइस मैसेज';

  @override
  String get previewFile => 'फ़ाइल';

  @override
  String get stickerEmojiTitle => 'इसके लिए एक इमोजी चुनें';

  @override
  String get stickersMine => 'मेरे स्टिकर';

  @override
  String get stickersStarterPack => 'Cubi';

  @override
  String get emojiTab => 'इमोजी';

  @override
  String get chatBlockedStatus => 'ब्लॉक है';

  @override
  String get chatBlockedHint => 'आपने इस व्यक्ति को ब्लॉक किया है';

  @override
  String get chatRouteFallbackOff => 'इंटरनेट बंद';

  @override
  String get chatAttachmentUnavailable =>
      'कोई कनेक्शन उपलब्ध नहीं है। Bluetooth या इंटरनेट से कनेक्ट करें और फिर कोशिश करें।';

  @override
  String get fileTransfersTitle => 'फ़ाइल ट्रांसफ़र';

  @override
  String get fileTransfersClear => 'इतिहास साफ़ करें';

  @override
  String get fileTransfersEmpty => 'अभी कोई फ़ाइल ट्रांसफ़र नहीं';

  @override
  String get fileTransfersActive => 'चालू';

  @override
  String get fileTransfersHistory => 'इतिहास';

  @override
  String get fileTransferPause => 'रोकें';

  @override
  String get fileTransferResume => 'जारी रखें';

  @override
  String get fileTransferRetry => 'फिर कोशिश करें';

  @override
  String get fileTransferQueued => 'कनेक्शन का इंतज़ार';

  @override
  String get fileTransferRunning => 'ट्रांसफ़र हो रहा है';

  @override
  String get fileTransferPaused => 'रुका हुआ';

  @override
  String get fileTransferCompleted => 'पूरा हुआ';

  @override
  String get fileTransferFailed => 'विफल';

  @override
  String get fileTransferCanceled => 'रद्द किया गया';

  @override
  String get profileFileTransfers => 'फ़ाइल ट्रांसफ़र';

  @override
  String get profileFileTransfersSubtitle =>
      'प्रगति, कतार और ट्रांसफ़र का इतिहास';

  @override
  String get qrScanAction => 'QR कोड स्कैन करें';

  @override
  String get qrScanTitle => 'QR कोड स्कैन करें';

  @override
  String get qrScanHint =>
      'CubeChat संपर्क, चैनल, अकाउंट ट्रांसफ़र या कंप्यूटर साइन-इन का कोड स्कैन करें।';

  @override
  String get qrFlash => 'फ़्लैशलाइट';

  @override
  String get qrCameraError =>
      'कैमरा उपलब्ध नहीं है। कैमरे की अनुमति जाँचें और फिर कोशिश करें।';

  @override
  String get qrInvalid => 'यह सही Cubechat QR कोड नहीं है।';

  @override
  String qrChannelAdded(String name) {
    return '$name जोड़ा गया';
  }

  @override
  String get qrShow => 'QR कोड दिखाएँ';

  @override
  String qrChannelTitle(String name) {
    return '$name से जुड़ें';
  }

  @override
  String get profileBackup => 'एन्क्रिप्टेड बैकअप';

  @override
  String get profileBackupSubtitle =>
      'कुंजियाँ, संपर्क और इतिहास सुरक्षित रूप से ले जाएँ';

  @override
  String get backupTitle => 'एन्क्रिप्टेड बैकअप';

  @override
  String get backupExplainer =>
      'बैकअप में आपकी निजी पहचान कुंजियाँ, संपर्क, चैनल, सेटिंग्स और मैसेज का इतिहास होता है। इसे इसी फ़ोन पर आपके चुने पासवर्ड से एन्क्रिप्ट किया जाता है; Cubechat भूला हुआ पासवर्ड रिकवर नहीं कर सकता।';

  @override
  String get backupCreate => 'बैकअप बनाएँ';

  @override
  String get backupCreateSubtitle =>
      'सब कुछ एन्क्रिप्ट करें और .cchatbackup फ़ाइल सेव करें';

  @override
  String get backupRestore => 'बैकअप रीस्टोर करें';

  @override
  String get backupRestoreSubtitle =>
      'इस फ़ोन की Cubechat प्रोफ़ाइल को बैकअप फ़ाइल से बदलें';

  @override
  String get backupPasswordTitle => 'बैकअप पासवर्ड';

  @override
  String get backupPasswordHint => 'कम से कम 8 अक्षर';

  @override
  String get backupConfirmPassword => 'पासवर्ड दोबारा डालें';

  @override
  String get backupPasswordMismatch => 'पासवर्ड मेल नहीं खाते';

  @override
  String get backupPasswordShort => 'कम से कम 8 अक्षर इस्तेमाल करें';

  @override
  String get backupSaveTitle => 'Cubechat बैकअप सेव करें';

  @override
  String get backupSaved => 'एन्क्रिप्टेड बैकअप सेव हो गया';

  @override
  String get backupWhereTitle => 'बैकअप कहाँ रखें?';

  @override
  String get backupSaveToFiles => 'फ़ाइलों में सेव करें';

  @override
  String get backupSaveToFilesHint =>
      'इस फ़ोन का कोई फ़ोल्डर, मेमोरी कार्ड या क्लाउड ड्राइव';

  @override
  String get backupSendToApp => 'किसी ऐप को भेजें';

  @override
  String get backupSendToAppHint =>
      'Telegram, ईमेल, कोई मैसेंजर — जो भी फ़ाइलें लेता हो';

  @override
  String get backupFailed => 'बैकअप का काम पूरा नहीं हो सका';

  @override
  String get backupRestoreConfirmTitle => 'यह प्रोफ़ाइल बदलें?';

  @override
  String get backupRestoreConfirmMessage =>
      'इस फ़ोन की मौजूदा कुंजियाँ, संपर्क, चैनल, सेटिंग्स और इतिहास चुने गए बैकअप से बदल दिए जाएँगे।';

  @override
  String get backupRestoreConfirmAction => 'रीस्टोर करें';

  @override
  String get backupRestored => 'बैकअप रीस्टोर हो गया';

  @override
  String get backupPackingWait => 'बैकअप बन रहा है…';

  @override
  String get backupUnpackingWait => 'बैकअप रीस्टोर हो रहा है…';

  @override
  String get backupWaitHint =>
      'फ़ोटो और वीडियो के साथ इसमें कुछ मिनट लग सकते हैं। ऐप खुला रखें।';

  @override
  String get backupInvalid =>
      'गलत पासवर्ड, खराब फ़ाइल, या यह बैकअप सपोर्टेड नहीं है';

  @override
  String get channelInfoTitle => 'चैनल की जानकारी';

  @override
  String get channelParticipantsTitle => 'सदस्य';

  @override
  String get channelAdministratorsTitle => 'एडमिन';

  @override
  String get channelMakeAdmin => 'एडमिन बनाएँ';

  @override
  String get channelRemoveAdmin => 'एडमिन से हटाएँ';

  @override
  String get channelNoParticipants => 'साइन की गई गतिविधि के बाद सदस्य दिखेंगे';

  @override
  String get channelSharedContent => 'मीडिया, फ़ाइलें और पोल';

  @override
  String get channelDescriptionTitle => 'विवरण';

  @override
  String get channelDescriptionEmpty => 'अभी कोई विवरण नहीं';

  @override
  String get channelDescriptionHint => 'यह चैनल किस लिए है';

  @override
  String get channelDescriptionAdminOnly => 'सिर्फ़ एडमिन विवरण बदल सकते हैं';

  @override
  String get channelDescriptionSave => 'सेव करें';

  @override
  String get channelPrivateSubtitle => 'निजी चैनल';

  @override
  String get channelAvatarSet => 'नई फ़ोटो लगाएँ';

  @override
  String get channelSettingsTitle => 'चैनल सेटिंग्स';

  @override
  String get channelSettingsHint =>
      'कौन पोस्ट कर सकता है, कॉपी करना, पुराना इतिहास';

  @override
  String get channelLeaveAction => 'छोड़ें';

  @override
  String get channelLeaveConfirm =>
      'रूम और उसमें कही गई हर बात इस फ़ोन से हट जाएगी। कुंजी नाम से बनती है, इसलिए वही नाम टाइप करके आप इसे फिर से खोल सकते हैं।';

  @override
  String get channelShareAction => 'शेयर करें';

  @override
  String channelMembersOf(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count सदस्य',
      one: '1 सदस्य',
    );
    return '$_temp0';
  }

  @override
  String get chatTyping => 'टाइप कर रहे हैं…';

  @override
  String get chatRecordingVoice => 'वॉइस मैसेज रिकॉर्ड कर रहे हैं…';

  @override
  String get chatRecordingCircle => 'वीडियो मैसेज रिकॉर्ड कर रहे हैं…';

  @override
  String get chatSendingPhoto => 'फ़ोटो भेज रहे हैं…';

  @override
  String get chatSendingVideo => 'वीडियो भेज रहे हैं…';

  @override
  String get chatSendingFile => 'फ़ाइल भेज रहे हैं…';

  @override
  String get onboardingMeshTitle => 'बिना इंटरनेट के चलता है';

  @override
  String get onboardingMeshBody =>
      'मैसेज Bluetooth से एक फ़ोन से दूसरे फ़ोन तक जाते हैं। न सिग्नल, न Wi-Fi, न अकाउंट — बस आपके आस-पास के लोग।';

  @override
  String get onboardingRelayTitle => 'और इंटरनेट हो, तो उसके साथ भी';

  @override
  String get onboardingRelayBody =>
      'Bluetooth रेंज से बाहर होने पर मैसेज इंटरनेट से जाते हैं और वैसे ही पहुँचते हैं। आपको कभी चुनना नहीं पड़ता।';

  @override
  String get onboardingPrivacyTitle => 'बीच में कोई इसे पढ़ नहीं सकता';

  @override
  String get onboardingPrivacyBody =>
      'सब कुछ एंड-टू-एंड एन्क्रिप्टेड है, और आपकी पहचान इस फ़ोन पर एक कुंजी है — न फ़ोन नंबर, न ईमेल, न कोई अकाउंट जिसे कोई छीन सके।';

  @override
  String get onboardingSkip => 'छोड़ें';

  @override
  String get onboardingNext => 'आगे';

  @override
  String get onboardingStart => 'शुरू करें';

  @override
  String get chatMediaShare => 'शेयर करें';

  @override
  String get chatMediaSaveToGallery => 'गैलरी में सेव करें';

  @override
  String get chatMediaShowInChat => 'चैट में दिखाएँ';

  @override
  String get chatWallpaperTitle => 'वॉलपेपर';

  @override
  String get chatWallpaperClear => 'रीसेट करें';

  @override
  String get chatWallpaperDim => 'मैसेज के पीछे गहरा करें';

  @override
  String get chatSelectAction => 'चुनें';

  @override
  String get chatForwardNothing => 'यहाँ फ़ॉरवर्ड करने लायक कुछ नहीं है';

  @override
  String chatSelectedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count चुने गए',
      one: '1 चुना गया',
    );
    return '$_temp0';
  }

  @override
  String chatDeleteSelectedTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count मैसेज डिलीट करें?',
      one: 'यह मैसेज डिलीट करें?',
    );
    return '$_temp0';
  }

  @override
  String get contactAliasAction => 'संपर्क का नाम बदलें';

  @override
  String get contactAliasHint =>
      'यह नाम सिर्फ़ आपको दिखता है। उनका नाम रखने के लिए खाली छोड़ें।';

  @override
  String get viewOnceSendLabel => 'एक बार देखें';

  @override
  String get viewOnceTitle => 'एक बार देखें';

  @override
  String get viewOnceTapToView => 'फ़ोटो · एक बार देखने के लिए टैप करें';

  @override
  String get viewOnceSent => 'फ़ोटो · भेजी गई';

  @override
  String get viewOnceOpened => 'फ़ोटो खोली गई';

  @override
  String get viewOnceUnavailable => 'यह फ़ोटो अब उपलब्ध नहीं है';

  @override
  String get viewOnceWarning =>
      'इसे बंद करते ही फ़ोटो आप दोनों के लिए डिलीट हो जाएगी।';

  @override
  String get channelAvatarAdminOnly =>
      'सिर्फ़ एडमिन चैनल की फ़ोटो बदल सकते हैं';

  @override
  String get channelAdminOnly => 'सिर्फ़ एडमिन इसे बदल सकते हैं';

  @override
  String get channelAvatarTooLarge =>
      'यह फ़ोटो ब्रॉडकास्ट करने के लिए बहुत बड़ी है';

  @override
  String get channelMemberUnknown => 'अभी आपके संपर्कों में नहीं';

  @override
  String get channelInviteToContacts => 'उन्हें अपना संपर्क कार्ड भेजें';

  @override
  String channelContactInviteSent(String name) {
    return '$name को संपर्क कार्ड भेजा गया';
  }

  @override
  String get chatContactInvitation => 'जुड़ने का आमंत्रण';

  @override
  String get chatContactInvitationForYou => 'आपके लिए आमंत्रण';

  @override
  String get channelPollTitle => 'पोल';

  @override
  String get channelCreatePoll => 'पोल बनाएँ';

  @override
  String get channelPollQuestion => 'सवाल';

  @override
  String channelPollOption(int number) {
    return 'विकल्प $number';
  }

  @override
  String get channelPollAddOption => 'विकल्प जोड़ें';

  @override
  String get channelPollCreate => 'पोल पब्लिश करें';

  @override
  String channelPollVotes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count वोट',
      one: '1 वोट',
      zero: 'कोई वोट नहीं',
    );
    return '$_temp0';
  }

  @override
  String get phoneTransferTitle => 'नए फ़ोन पर ट्रांसफ़र करें';

  @override
  String get desktopPickChat => 'चुनें कि आप किसे लिखना चाहते हैं';

  @override
  String get desktopListCollapse => 'सिर्फ़ चेहरे दिखाएँ';

  @override
  String get desktopListExpand => 'चैट सूची दिखाएँ';

  @override
  String get desktopLinkConnectTitle => 'कंप्यूटर कनेक्ट करें';

  @override
  String get desktopLinkConnectHint =>
      'कंप्यूटर पर CubeChat जो कोड दिखा रहा है, उसे स्कैन करें';

  @override
  String get desktopLinkSignIn => 'फ़ोन के अकाउंट से साइन इन करें';

  @override
  String get desktopLinkTitle => 'अपने फ़ोन से साइन इन करें';

  @override
  String get desktopLinkSteps =>
      'फ़ोन पर: प्रोफ़ाइल → डेटा → कंप्यूटर कनेक्ट करें, फिर यह कोड स्कैन करें। दोनों एक ही Wi-Fi पर होने चाहिए।';

  @override
  String get desktopLinkLimits =>
      'फ़ोन चलता रहेगा। इंटरनेट से आने वाले मैसेज दोनों पर पहुँचते हैं; एक से भेजा गया अभी दूसरे पर नहीं दिखता।';

  @override
  String get desktopLinkWaiting => 'फ़ोन का इंतज़ार…';

  @override
  String get desktopLinkFailed => 'अकाउंट नहीं मिल सका। फिर कोशिश करें।';

  @override
  String get desktopLinkRetry => 'फिर कोशिश करें';

  @override
  String get desktopLinkConfirmTitle => 'इस अकाउंट की कॉपी कंप्यूटर पर भेजें?';

  @override
  String get desktopLinkConfirmMessage =>
      'कंप्यूटर को आपकी कुंजियाँ, संपर्क और चैट मिलेंगी। यह फ़ोन पहले की तरह चलता रहेगा।';

  @override
  String get desktopLinkConfirmAction => 'भेजें';

  @override
  String desktopLinkConfirmWhere(String address) {
    return 'सिर्फ़ तभी, जब आपने यह कोड अभी-अभी अपने ही कंप्यूटर की स्क्रीन से स्कैन किया हो। यह इस नेटवर्क पर $address को जाएगा।';
  }

  @override
  String get desktopLinkSending => 'अकाउंट भेजा जा रहा है…';

  @override
  String get desktopLinkSent => 'कंप्यूटर कनेक्ट हो गया';

  @override
  String get desktopLinkPhoneFound =>
      'फ़ोन ने यह कंप्यूटर ढूँढ लिया है और अकाउंट की कॉपी बना रहा है। फ़ोटो के साथ इसमें कुछ मिनट लग सकते हैं।';

  @override
  String desktopLinkReceiving(int percent) {
    return 'अकाउंट मिल रहा है: $percent%';
  }

  @override
  String get desktopLinkRestoring => 'अकाउंट इस कंप्यूटर पर सेट हो रहा है…';

  @override
  String get desktopLinkFinding => 'कंप्यूटर खोजा जा रहा है…';

  @override
  String get desktopLinkPreparing =>
      'अकाउंट की कॉपी बन रही है। फ़ोटो के साथ इसमें कुछ मिनट लग सकते हैं।';

  @override
  String desktopLinkSendingPercent(int percent) {
    return 'भेजा जा रहा है: $percent%';
  }

  @override
  String get desktopLinkComputerRestoring => 'कंप्यूटर अकाउंट सेट कर रहा है…';

  @override
  String get devicesTitle => 'डिवाइस';

  @override
  String get devicesRowHint => 'आपका अकाउंट कहाँ खुला है, और वहाँ से साइन आउट';

  @override
  String get devicesThisDevice => 'यह डिवाइस';

  @override
  String get devicesSeenNow => 'अभी-अभी ऑनलाइन';

  @override
  String devicesSeenMinutes(int n) {
    return '$n मिनट पहले ऑनलाइन';
  }

  @override
  String devicesSeenHours(int n) {
    return '$n घंटे पहले ऑनलाइन';
  }

  @override
  String devicesSeenDays(int n) {
    return '$n दिन पहले ऑनलाइन';
  }

  @override
  String get devicesLeaving => 'साइन आउट हो रहा है — ऑनलाइन आने का इंतज़ार';

  @override
  String get devicesSignOut => 'साइन आउट करें';

  @override
  String get devicesSignOutAll => 'बाकी सभी डिवाइस से साइन आउट करें';

  @override
  String devicesSignOutTitle(String name) {
    return '“$name” से साइन आउट करें?';
  }

  @override
  String get devicesSignOutMessage =>
      'वह डिवाइस ऑनलाइन आते ही उस पर CubeChat की कुंजियाँ, चैट और सेटिंग्स मिटा दी जाएँगी। अकाउंट यहाँ और आपके दूसरे डिवाइस पर बना रहेगा।';

  @override
  String get devicesSignOutPhoneMessage =>
      'वह एक फ़ोन है: उस पर CubeChat पूरी तरह मिटा दिया जाएगा। अकाउंट यहाँ और आपके दूसरे डिवाइस पर बना रहेगा।';

  @override
  String get devicesSignOutAllMessage =>
      'बाकी हर डिवाइस ऑनलाइन आते ही साइन आउट हो जाएगा। अकाउंट सिर्फ़ यहीं रहेगा।';

  @override
  String get devicesRename => 'नाम बदलें';

  @override
  String get devicesRenameTitle => 'इस डिवाइस का नाम';

  @override
  String get devicesSave => 'सेव करें';

  @override
  String get devicesEmpty =>
      'अभी कोई दूसरा डिवाइस नहीं। CubeChat 1.0.0+1147 या नया वर्शन खोलते ही डिवाइस यहाँ दिखेगा।';

  @override
  String get devicesCaveat =>
      'साइन आउट तब लागू होता है जब वह डिवाइस ऑनलाइन आता है। जिसे ऑफ़लाइन रखा जाए, उसकी कुंजियाँ बनी रहती हैं; पूरी सुरक्षा का मतलब होगा अकाउंट के लिए नई कुंजियाँ।';

  @override
  String get desktopLinkImportTitle => 'अपने फ़ोन से अकाउंट लाएँ';

  @override
  String get desktopLinkImportHint =>
      'फ़ोन को एक कोड दिखाएँ, और यह कंप्यूटर उसके अकाउंट की कॉपी बन जाएगा';

  @override
  String get desktopLinkImportConfirmTitle => 'इस कंप्यूटर का अकाउंट बदलें?';

  @override
  String get desktopLinkImportConfirmMessage =>
      'इस कंप्यूटर की कुंजियाँ, संपर्क और चैट फ़ोन के अकाउंट से बदल दिए जाएँगे। अगर आपको यह अकाउंट अभी भी चाहिए, तो पहले बैकअप बना लें।';

  @override
  String get desktopLinkImportConfirmAction => 'जारी रखें';

  @override
  String get desktopLinkUnreachable =>
      'कंप्यूटर तक नहीं पहुँचा जा सका। दोनों एक ही Wi-Fi पर होने चाहिए, और कंप्यूटर पर CubeChat को फ़ायरवॉल से अनुमति होनी चाहिए।';

  @override
  String get desktopLinkFirewallHint =>
      'Windows फ़ोन को इस कंप्यूटर तक पहुँचने से रोक सकता है। फ़ायरवॉल में CubeChat को अनुमति दें — सिर्फ़ आपके लोकल नेटवर्क के लिए।';

  @override
  String get desktopLinkFirewallAllow => 'फ़ायरवॉल में अनुमति दें';

  @override
  String get desktopLinkFirewallDeclined =>
      'Windows ने अनुमति नहीं दी। इसके बिना फ़ोन शायद नहीं पहुँच पाएगा।';

  @override
  String get phoneTransferIntro =>
      'अपनी प्रोफ़ाइल, कुंजियाँ, संपर्क, चैनल, सेटिंग्स और इतिहास सीधे दो फ़ोन के बीच ले जाएँ।';

  @override
  String get phoneTransferSend => 'यह पुराना फ़ोन है';

  @override
  String get phoneTransferReceive => 'यह नया फ़ोन है';

  @override
  String get phoneTransferSameWifi =>
      'दोनों फ़ोन एक ही Wi-Fi से कनेक्ट करें। ट्रांसफ़र पूरा होने तक यह स्क्रीन खुली रखें।';

  @override
  String get phoneTransferPreparing =>
      'एन्क्रिप्टेड ट्रांसफ़र तैयार हो रहा है…';

  @override
  String get phoneTransferReady =>
      'नए फ़ोन पर यह एक बार वाला QR कोड स्कैन करें';

  @override
  String get phoneTransferScan => 'पुराना फ़ोन स्कैन करें';

  @override
  String get phoneTransferConfirmTitle => 'इस फ़ोन की प्रोफ़ाइल बदलें?';

  @override
  String get phoneTransferConfirmMessage =>
      'इस फ़ोन पर अभी सेव प्रोफ़ाइल एन्क्रिप्टेड लोकल ट्रांसफ़र से बदल दी जाएगी।';

  @override
  String get phoneTransferConfirmAction => 'प्रोफ़ाइल ट्रांसफ़र करें';

  @override
  String get phoneTransferSuccess => 'प्रोफ़ाइल ट्रांसफ़र हो गई';

  @override
  String get phoneTransferFailed => 'फ़ोन ट्रांसफ़र पूरा नहीं हो सका';

  @override
  String get profileSummaryMeshOnly => 'सिर्फ़ mesh';

  @override
  String get profileSummaryMeshInternet => 'Mesh · इंटरनेट';

  @override
  String get profileSummaryBackgroundOn => 'बैकग्राउंड में चलता है';

  @override
  String profileSummaryTransfersActive(int count) {
    return '$count जारी';
  }

  @override
  String get profileSummaryCardBackup => 'फ़ाइलें, बैकअप';

  @override
  String get chatPlay => 'चलाएँ';

  @override
  String get chatPause => 'रोकें';

  @override
  String get profileTheme => 'रंग';

  @override
  String get profileThemeEmerald => 'पन्ना';

  @override
  String get profileThemeIndigo => 'इंडिगो';

  @override
  String get profileThemeAmber => 'एम्बर';

  @override
  String get profileThemeRose => 'गुलाबी';

  @override
  String get profileThemeFuchsia => 'फ़्यूशिया';

  @override
  String get profileThemeViolet => 'बैंगनी';

  @override
  String get profileThemeOcean => 'समुद्री';

  @override
  String get profileThemeSlate => 'स्लेट';

  @override
  String get profileScale => 'इंटरफ़ेस साइज़';

  @override
  String get profileScaleSystem => 'सिस्टम';

  @override
  String get profileGlass => 'ग्लास';

  @override
  String get profileGlassAuto => 'ऑटोमैटिक';

  @override
  String get profileGlassFull => 'पूरा';

  @override
  String get profileGlassLight => 'हल्का';

  @override
  String get profileGlassHint =>
      'हल्का मोड रंगत रखता है और पैनल के पीछे का ब्लर हटा देता है। ऑटोमैटिक एक बार आपके फ़ोन को मापकर तय करता है। जो फ़ोन पहले से ठीक चलता है उस पर इसका फ़ायदा बहुत कम है — यह उस फ़ोन के लिए है जो नहीं चलता।';

  @override
  String get mapAlwaysNeeded =>
      'cubechat बंद होने पर भी मैप अपडेट होता रहे, इसके लिए लोकेशन को “हमेशा” पर सेट करना होगा। सेटिंग्स खोलने के लिए टैप करें।';

  @override
  String get mapShareConsentTitle => 'मैप पर अपनी लोकेशन दिखाएँ?';

  @override
  String get mapShareConsentBody =>
      'आपकी लाइव लोकेशन सिर्फ़ आपके मैप वाले संपर्कों को दिखेगी: जिन्हें आपने आमंत्रित किया, या जिनका आमंत्रण आपने स्वीकार किया। जब तक आप छिपते नहीं, यह अपडेट होती रहेगी, Cubechat के बैकग्राउंड में होने पर भी। यह एंड-टू-एंड एन्क्रिप्टेड है और कभी हम तक नहीं पहुँचती। आप मैप पर या प्रोफ़ाइल में कभी भी छिप सकते हैं, और जिन संपर्कों को आप ब्लॉक करते हैं वे आपको कभी नहीं देखते।';

  @override
  String get mapShareConsentAllow => 'अनुमति दें';

  @override
  String get mapShareConsentDecline => 'अनुमति न दें';

  @override
  String get mapVisibleToFriends => 'मैप पर दोस्त आपको देख सकते हैं';

  @override
  String get mapHiddenFromFriends => 'आप छिपे हुए हैं';

  @override
  String get mapHideMe => 'छिपाएँ';

  @override
  String get mapShowMe => 'मुझे दिखाएँ';

  @override
  String get profileScaleSmall => 'छोटा';

  @override
  String get profileScaleNormal => 'सामान्य';

  @override
  String get profileScaleLarge => 'बड़ा';

  @override
  String get profileScaleSample =>
      'टेक्स्ट और पंक्तियाँ इसी साइज़ में दिखेंगी।';

  @override
  String get savedTitle => 'सेव किए गए';

  @override
  String get savedSubtitle => 'खुद के लिए नोट्स, इस डिवाइस पर';

  @override
  String get savedEmpty => 'आप यहाँ जो भी लिखेंगे, वह इसी फ़ोन पर रहेगा।';

  @override
  String get meshOffTitle => 'Bluetooth mesh बंद है';

  @override
  String get meshOffHint =>
      'आस-पास कोई आपको नहीं ढूँढ सकता और आप उन्हें नहीं ढूँढ सकते। मैसेज फिर भी इंटरनेट रिले से जाते हैं।';

  @override
  String get profileMeshSwitch => 'Bluetooth mesh';

  @override
  String get profileMeshSwitchHint =>
      'आस-पास के लोगों को ढूँढें और बिना इंटरनेट मैसेज पहुँचाएँ। बंद करने से बैटरी बचती है।';

  @override
  String get channelAdminOnlyHint => 'घोषणा चैनल। पढ़ सब सकते हैं।';

  @override
  String get attachLocation => 'लोकेशन';

  @override
  String get locationBubbleTitle => 'लोकेशन';

  @override
  String get locationOpenInMaps => 'मैप्स में खोलें';

  @override
  String locationAccuracy(int metres) {
    return '$metres मी. के भीतर';
  }

  @override
  String get locationExpired => 'यह लोकेशन अब ताज़ा नहीं है';

  @override
  String get locationDenied => 'लोकेशन की अनुमति बंद है';

  @override
  String get locationUnavailable => 'लोकेशन पता नहीं चल सकी';

  @override
  String get locationShareFor => 'कितनी देर शेयर करें';

  @override
  String get locationShareOnce => 'सिर्फ़ एक बार';

  @override
  String get locationShare15m => '15 मिनट';

  @override
  String get locationShare1h => '1 घंटा';

  @override
  String get storageTitle => 'स्टोरेज';

  @override
  String get storageHeadline => 'स्टोरेज का इस्तेमाल';

  @override
  String storageSubtitle(String size) {
    return 'cubechat इस डिवाइस पर $size इस्तेमाल कर रहा है';
  }

  @override
  String get storageEmpty => 'अभी कुछ भी सेव नहीं';

  @override
  String get storageScanning => 'माप रहे हैं…';

  @override
  String get storageCatPhotos => 'फ़ोटो';

  @override
  String get storageCatVoice => 'वॉइस मैसेज';

  @override
  String get storageCatFiles => 'मिली फ़ाइलें';

  @override
  String get storageCatOutbox => 'आपकी भेजी फ़ाइलें';

  @override
  String get storageCatStickers => 'स्टिकर';

  @override
  String get storageCatSaved => 'सेव किए मैसेज';

  @override
  String get storageCatWallpapers => 'वॉलपेपर';

  @override
  String get storageCatHistory => 'बातचीत और कुंजियाँ';

  @override
  String get storageCatCache => 'कैश';

  @override
  String storageClear(String size) {
    return '$size साफ़ करें';
  }

  @override
  String get storageClearNothing => 'कुछ नहीं चुना गया';

  @override
  String storageFreed(String size) {
    return '$size खाली हुआ';
  }

  @override
  String get storageNoCloud =>
      'इसके पीछे कोई क्लाउड नहीं है। आप जो भी साफ़ करेंगे वह इस फ़ोन से चला जाएगा, और इसकी दूसरी कॉपी सिर्फ़ उस फ़ोन पर है जहाँ से यह आया था।';

  @override
  String get storageWhyHistoryLocked =>
      'बातचीत यहाँ से साफ़ नहीं होती — इसके लिए इमरजेंसी वाइप इस्तेमाल करें।';

  @override
  String get storageRecoveryFree => 'साफ़ करना सुरक्षित है';

  @override
  String get storageRecoveryGone => 'कहीं और कोई कॉपी नहीं';

  @override
  String get storageRecoveryAskSender => 'भेजने वाले से फिर माँगा जा सकता है';

  @override
  String get storageRecoveryCostsThem =>
      'वे अब आपसे दोबारा भेजने को नहीं कह पाएँगे';

  @override
  String storageConfirmTitle(String size) {
    return '$size साफ़ करें?';
  }

  @override
  String get storageConfirmBody =>
      'इससे फ़ाइलें इस फ़ोन से डिलीट हो जाएँगी। कुछ भी कहीं अपलोड नहीं होता, इसलिए इन्हें वापस लाने का कोई ज़रिया नहीं है।';

  @override
  String storageFilesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count फ़ाइलें',
      one: '$count फ़ाइल',
      zero: 'खाली',
    );
    return '$_temp0';
  }

  @override
  String get customizeBarTitle => 'नेविगेशन बार';

  @override
  String get customizeBarHint =>
      'क्रम बदलने के लिए खींचें। चैट हटाई नहीं जा सकती।';

  @override
  String get customizeBarShown => 'दिख रहे';

  @override
  String get customizeBarHidden => 'छिपे हुए';

  @override
  String get customizeBarHiddenEmpty => 'कुछ भी छिपा नहीं';

  @override
  String get customizeBarMinimum => 'कम से कम दो टैब रखें';

  @override
  String get customizeReset => 'डिफ़ॉल्ट पर रीसेट करें';

  @override
  String get chatsArchiveTitle => 'आर्काइव';

  @override
  String get chatsArchiveEmpty => 'कुछ भी आर्काइव नहीं';

  @override
  String get chatsArchiveHint =>
      'आर्काइव की गई चैट काम करती रहती हैं — वे बस सूची से बाहर हैं।';

  @override
  String get chatsArchivedToast => 'आर्काइव की गई';

  @override
  String get chatsUnarchivedToast => 'सूची में वापस';

  @override
  String chatsArchiveCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count चैट',
      one: '$count चैट',
    );
    return '$_temp0';
  }

  @override
  String get chatsSwipeNotHere => 'इस चैट के लिए उपलब्ध नहीं';

  @override
  String get customizeSwipeTitle => 'चैट को दाईं ओर स्वाइप करें';

  @override
  String get customizeSwipeHint =>
      'बाईं ओर स्वाइप करने से अब भी टैब बदलते हैं।';

  @override
  String get customizeSwipeArchive => 'आर्काइव';

  @override
  String get customizeSwipeMute => 'म्यूट';

  @override
  String get customizeSwipePin => 'पिन';

  @override
  String get customizeSwipeRead => 'पढ़ा हुआ';

  @override
  String get customizeSwipeDelete => 'डिलीट';

  @override
  String get customizeSwipeNone => 'कुछ नहीं';

  @override
  String get customizeHighRefresh => 'पूरा रिफ़्रेश रेट';

  @override
  String get customizeHighRefreshHint =>
      'ज़्यादा स्मूद, और फ़ोन दोगुने फ़्रेम बनाता है। फ़ोन गरम हो तो इसे बंद कर दें — ऐप के दिखने में कुछ नहीं बदलता, सिर्फ़ यह कि उसे कितनी बार दोबारा बनाया जाता है।';

  @override
  String get customizeQuickReaction => 'डबल-टैप रिएक्शन';

  @override
  String get customizeQuickReactionHint =>
      'मैसेज पर डबल टैप करने से क्या लगे। कोई दूसरा इस्तेमाल करेंगे तो वह यहाँ आ जाएगा।';

  @override
  String get customizeCircleAudioTitle => 'वीडियो मैसेज के लिए म्यूज़िक रोकें';

  @override
  String get customizeCircleAudioOn =>
      'रिकॉर्ड करने या देखने पर बाकी जो भी चल रहा है वह रुक जाता है। वह अपने-आप फिर शुरू नहीं होता।';

  @override
  String get customizeCircleAudioOff =>
      'आपका म्यूज़िक नीचे चलता रहता है, वीडियो मैसेज के दौरान धीमा।';

  @override
  String get customizeMediaQualityTitle => 'भेजते समय फ़ोटो क्वालिटी';

  @override
  String get customizeMediaQualityEconomy => 'किफ़ायती';

  @override
  String get customizeMediaQualityStandard => 'सामान्य';

  @override
  String get customizeMediaQualityHigh => 'हाई';

  @override
  String get customizeMediaQualityEconomyHint =>
      'हर फ़ोटो 96 KB तक, 800 px। एक सिग्नल बार या भीड़ भरे Bluetooth mesh के लिए: आधा इंतज़ार, थोड़ी धुंधली तस्वीर।';

  @override
  String get customizeMediaQualityStandardHint =>
      'हर फ़ोटो 192 KB तक, 1280 px। इतना कि सिर्फ़ Bluetooth से भी चली जाए। वीडियो और “ओरिजिनल” हमेशा जैसे हैं वैसे ही भेजे जाते हैं।';

  @override
  String get customizeMediaQualityHighHint =>
      'हर फ़ोटो 768 KB तक, 2048 px। ज़ूम करने लायक साफ़; भेजने में चार गुना समय, इसलिए Wi-Fi पर बेहतर।';

  @override
  String get previewReacted => 'आपके मैसेज पर';

  @override
  String get previewLocation => 'लोकेशन';

  @override
  String get previewMapInvite => 'मैप आमंत्रण';

  @override
  String get previewContact => 'संपर्क';

  @override
  String get previewUnsupported => 'यह मैसेज सपोर्टेड नहीं है';

  @override
  String get previewCallOutgoing => 'जाने वाली कॉल';

  @override
  String get previewCallIncoming => 'आने वाली कॉल';

  @override
  String get previewCallMissed => 'मिस्ड कॉल';

  @override
  String chatPreparingPhotos(int count) {
    return '$count फ़ोटो तैयार हो रही हैं…';
  }

  @override
  String get circleSwitchCamera => 'कैमरा बदलें';

  @override
  String get circleLight => 'रिकॉर्डिंग लाइट';

  @override
  String get circleCameraSwitchFailed =>
      'कैमरा नहीं बदल सका। आपकी रिकॉर्डिंग अब भी खुली है।';

  @override
  String get diagnosticsTitle => 'डायग्नोस्टिक्स';

  @override
  String get diagnosticsIntro =>
      'ऐप हाल में क्या करता रहा है। अगर कुछ काम नहीं कर रहा, तो इसे डेवलपर को भेजें।';

  @override
  String get diagnosticsShare => 'डेवलपर को लॉग भेजें';

  @override
  String get diagnosticsEvents => 'हाल की घटनाएँ';

  @override
  String get diagnosticsTechnical => 'तकनीकी रिकॉर्ड';

  @override
  String get diagnosticsEmpty => 'अभी दिखाने को कुछ नहीं।';

  @override
  String get diagnosticsDeveloperOn => 'डेवलपर मोड चालू';

  @override
  String get diagnosticsDeveloperOff => 'डेवलपर मोड बंद';

  @override
  String get logAppStarted => 'ऐप शुरू हुआ';

  @override
  String get logInternetOn => 'इंटरनेट कनेक्शन चालू';

  @override
  String logServerConnected(String host) {
    return '$host से कनेक्ट हुआ';
  }

  @override
  String logServerLost(String host) {
    return '$host से कनेक्शन टूटा';
  }

  @override
  String get chatSaveAction => 'सेव करें';

  @override
  String get savedTagAsk => 'सेव हो गया। टैग जोड़ें?';

  @override
  String get savedTagAdd => 'टैग जोड़ें';

  @override
  String get chatSharedWallpaperFailed =>
      'वॉलपेपर यहाँ लग गया। रेंज में आने पर उन तक पहुँच जाएगा।';

  @override
  String get chatTranscribeAction => 'टेक्स्ट में बदलें';

  @override
  String get chatTranscribeFailed => 'यह फ़ोन इसे टेक्स्ट में नहीं बदल सकता।';

  @override
  String get chatTranscribing => 'पहचाना जा रहा है…';

  @override
  String get chatTranscriptHide => 'टेक्स्ट छिपाएँ';

  @override
  String get chatCancelSend => 'भेजना रद्द करें';

  @override
  String get chatDownloadAction => 'डाउनलोड करें';

  @override
  String get chatDownloaded => 'फ़ोन में सेव हो गया';

  @override
  String get chatDownloadFailed => 'सेव नहीं हो सका';

  @override
  String get selfUpdateTitle => 'फ़ाइल से अपडेट इंस्टॉल करें';

  @override
  String get selfUpdateHint =>
      'नया cubechat APK चैट से खोलने के बजाय यहाँ चुनें: इस तरह इंस्टॉल करने पर लॉक स्क्रीन पर कॉल चालू रहती हैं।';

  @override
  String get selfUpdateConfirm => 'सिस्टम विंडो में इंस्टॉलेशन की पुष्टि करें।';

  @override
  String get selfUpdateAllow =>
      'cubechat को ऐप्स इंस्टॉल करने की अनुमति दें, फिर दोबारा टैप करें।';

  @override
  String get selfUpdateNotOurs => 'यह फ़ाइल cubechat अपडेट नहीं है।';

  @override
  String get selfUpdateFailed => 'अपडेट इंस्टॉल नहीं हुआ।';

  @override
  String get chatTranscribeDownloading =>
      'फ़ोन इसके लिए भाषा डाउनलोड कर रहा है। एक मिनट में फिर कोशिश करें।';

  @override
  String get chatTranscribeNoLanguage =>
      'इस फ़ोन में उस भाषा का स्पीच मॉडल नहीं है। प्रोफ़ाइल → चैट और मीडिया में वॉइस-टू-टेक्स्ट भाषा चुनें।';

  @override
  String get chatTranscribeNotAllowed =>
      'CubeChat के लिए स्पीच रिकग्निशन बंद है। इसे iPhone की सेटिंग्स → CubeChat में चालू करें।';

  @override
  String get customizeTranscribeLanguageTitle => 'वॉइस-टू-टेक्स्ट भाषा';

  @override
  String get customizeTranscribeLanguageAuto => 'ऑटो';

  @override
  String get customizeTranscribeLanguageHint =>
      'वॉइस मैसेज किस भाषा में बोले जाते हैं — यह ऐप की भाषा से अलग हो सकती है। ऑटो फ़ोन की भाषाएँ आज़माता है। कोई भाषा न हो तो फ़ोन खुद उसे डाउनलोड करता है; आवाज़ फ़ोन से बाहर नहीं जाती।';

  @override
  String get chatTranslateAction => 'अनुवाद करें';

  @override
  String get chatTranslateFailed => 'इस फ़ोन पर इसका अनुवाद नहीं हो सकता।';

  @override
  String get customizeDeferMediaTitle =>
      'मीडिया डाउनलोड के लिए Wi-Fi का इंतज़ार करें';

  @override
  String get customizeDeferMediaHint =>
      'मोबाइल डेटा पर टेक्स्ट और कॉल हमेशा की तरह चलते हैं, जबकि फ़ोटो, वॉइस मैसेज, वीडियो मैसेज और फ़ाइलें सर्वर पर Wi-Fi का इंतज़ार करती हैं — दो हफ़्ते तक। चैट के ऊपर की एक पंक्ति दिखाती है कि क्या इंतज़ार में है और उसे अभी डाउनलोड करती है।';

  @override
  String heldMediaCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count मीडिया Wi-Fi के इंतज़ार में',
      one: '1 मीडिया Wi-Fi के इंतज़ार में',
    );
    return '$_temp0';
  }

  @override
  String get heldMediaDownload => 'डाउनलोड करें';

  @override
  String get nearbyAirDropSubtitle =>
      'आस-पास के लोगों के साथ फ़ाइलें शेयर करें';

  @override
  String get nearbyFilesSubtitle => 'भेजी और मिली फ़ाइलें';

  @override
  String get airdropTab => 'AirDrop';

  @override
  String get nearbyTabFiles => 'फ़ाइलें';

  @override
  String get airdropReceiveHint => 'कौन आपको फ़ाइलें भेज सकता है';

  @override
  String get airdropReceiveContacts => 'संपर्क';

  @override
  String get airdropReceiveEveryone => 'सभी 10 मिनट';

  @override
  String airdropEveryoneLeft(String time) {
    return 'सभी · $time';
  }

  @override
  String get airdropSendFiles => 'फ़ाइलें भेजें';

  @override
  String get airdropChooseFiles => 'फ़ाइलें चुनें';

  @override
  String airdropStagedTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count फ़ाइलें तैयार',
      one: '1 फ़ाइल तैयार',
    );
    return '$_temp0';
  }

  @override
  String get airdropStagedHint =>
      'दोनों फ़ोन पर Bluetooth चालू और AirDrop खुला रखकर उन्हें पास लाएँ या कोई व्यक्ति चुनें';

  @override
  String get airdropStagedPickPerson => 'व्यक्ति चुनें';

  @override
  String airdropRequestBody(String what, String size) {
    return '$what भेजना चाहते हैं · $size';
  }

  @override
  String airdropWhatPhotos(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count फ़ोटो',
      one: '1 फ़ोटो',
    );
    return '$_temp0';
  }

  @override
  String airdropWhatVideos(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count वीडियो',
      one: '1 वीडियो',
    );
    return '$_temp0';
  }

  @override
  String airdropWhatFiles(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count फ़ाइलें',
      one: '1 फ़ाइल',
    );
    return '$_temp0';
  }

  @override
  String get airdropAccept => 'स्वीकार करें';

  @override
  String get airdropDecline => 'अस्वीकार करें';

  @override
  String get airdropWaiting => 'जवाब का इंतज़ार…';

  @override
  String get airdropAccepted => 'स्वीकार किया';

  @override
  String get airdropUnheard => 'नहीं मिला — शायद CubeChat का पुराना वर्शन है';

  @override
  String get airdropSending => 'भेजा जा रहा है';

  @override
  String get airdropReceiving => 'मिल रहा है';

  @override
  String get airdropInterrupted => 'रुक गया';

  @override
  String get airdropRetry => 'फिर कोशिश करें';

  @override
  String get airdropOutcomeSent => 'भेजा गया';

  @override
  String get airdropOutcomeReceived => 'मिला';

  @override
  String get airdropOutcomeDeclined => 'अस्वीकार किया';

  @override
  String get airdropOutcomeCancelled => 'रद्द किया';

  @override
  String get airdropOutcomePartial => 'आंशिक';

  @override
  String get airdropReasonNoSpace => 'जगह कम है';

  @override
  String get airdropReasonContactsOnly => 'सिर्फ़ संपर्कों से';

  @override
  String get airdropReasonBusy => 'व्यस्त';

  @override
  String get airdropReasonTimeout => 'जवाब नहीं मिला';

  @override
  String get airdropFileDeleted => 'डिलीट हुई';

  @override
  String get airdropHistory => 'इतिहास';

  @override
  String get airdropClearHistory => 'इतिहास साफ़ करें';

  @override
  String get airdropEmpty => 'आस-पास भेजी या मिली फ़ाइलें यहाँ दिखेंगी';

  @override
  String get airdropPickPerson => 'इसे भेजें';

  @override
  String get airdropNobody => 'अभी आस-पास cubechat वाला कोई नहीं';

  @override
  String get airdropNoDirect => 'इस व्यक्ति से Bluetooth कनेक्शन नहीं है';

  @override
  String get airdropNearbyUnknown => 'आस-पास';

  @override
  String get airdropConnecting => 'कनेक्ट हो रहा है…';

  @override
  String get airdropConnectFailed => 'कनेक्ट नहीं हो सका';

  @override
  String get airdropSlowWarning => 'Bluetooth पर इसमें काफ़ी समय लग सकता है';

  @override
  String airdropTooLarge(String name, int limit) {
    return '$name $limit MB से बड़ी है';
  }

  @override
  String airdropFromLabel(String name) {
    return 'AirDrop · $name';
  }

  @override
  String get airdropWrite => 'मैसेज करें';

  @override
  String get airdropAction => 'AirDrop';

  @override
  String get airdropLaneTitle => 'चैनल';

  @override
  String get airdropLaneAuto => 'ऑटो';

  @override
  String get airdropLaneBluetooth => 'Bluetooth';

  @override
  String get airdropLaneWifi => 'Wi‑Fi';

  @override
  String get airdropBluetoothNeededHint =>
      'एक-दूसरे को ढूँढने और ट्रांसफ़र की पुष्टि के लिए दोनों फ़ोन पर Bluetooth चालू करें।';

  @override
  String get airdropLaneHint =>
      'Bluetooth फ़ोन ढूँढता और जोड़ता है। जब दोनों फ़ोन एक ही नेटवर्क या हॉटस्पॉट पर हों, तो Wi‑Fi फ़ाइलें भेजता है।';

  @override
  String get airdropWifiUnreachable => 'एक ही नेटवर्क पर नहीं';

  @override
  String get airdropWifiOldVersion =>
      'उनका ऐप अभी Wi‑Fi पर फ़ाइलें नहीं ले सकता';

  @override
  String get airdropBumpAdd => 'जोड़ें';

  @override
  String get airdropBumpAlreadyContact => 'पहले से आपके संपर्कों में';

  @override
  String airdropBumpSending(String name) {
    return '$name को भेजा जा रहा है';
  }

  @override
  String airdropBumpReceiving(String name) {
    return '$name आपको फ़ाइलें भेज रहे हैं';
  }

  @override
  String get termsTitle => 'cubechat के नियम';

  @override
  String get termsBody =>
      'cubechat आपत्तिजनक कंटेंट और दुर्व्यवहार करने वाले यूज़र्स को बिल्कुल बर्दाश्त नहीं करता। आगे बढ़कर आप सहमत होते हैं कि आप उत्पीड़न, धमकी, नाबालिगों से जुड़ा यौन कंटेंट, स्पैम या कुछ भी गैरकानूनी नहीं भेजेंगे। कोई भी किसी मैसेज या व्यक्ति की रिपोर्ट कर सकता है; रिपोर्ट डेवलपर तक पहुँचती हैं और 24 घंटे के भीतर उन पर कार्रवाई होती है, और नियम तोड़ने वालों को बैन किया जाता है।';

  @override
  String get termsReadFull => 'पूरी शर्तें पढ़ें';

  @override
  String get termsAccept => 'मैं सहमत हूँ';

  @override
  String get messageHide => 'छिपाएँ';

  @override
  String get messageHidden => 'आपके लिए छिपाया गया';

  @override
  String get reportAction => 'रिपोर्ट करें';

  @override
  String get reportTitle => 'क्या गड़बड़ है?';

  @override
  String get reportReasonSpam => 'स्पैम';

  @override
  String get reportReasonAbuse => 'दुर्व्यवहार या उत्पीड़न';

  @override
  String get reportReasonViolence => 'हिंसा';

  @override
  String get reportReasonSexual => 'यौन कंटेंट';

  @override
  String get reportReasonOther => 'अन्य';

  @override
  String get reportNoteHint => 'बताएँ (वैकल्पिक)';

  @override
  String get reportSend => 'रिपोर्ट भेजें';

  @override
  String get reportDisclosure =>
      'चुने गए मैसेज का टेक्स्ट और आपकी रिपोर्ट cubechat मॉडरेशन और उसके निजी Telegram बॉट को जाती है।';

  @override
  String get reportSent =>
      'रिपोर्ट भेजी गई। हम 24 घंटे के भीतर रिपोर्ट की समीक्षा करते हैं।';

  @override
  String get reportBlockedToo => 'वे आपके लिए ब्लॉक कर दिए गए हैं।';

  @override
  String get reportQueued => 'रिपोर्ट सेव हो गई। ऑनलाइन होने पर भेजी जाएगी।';

  @override
  String get reportFailed => 'रिपोर्ट नहीं भेजी जा सकी।';

  @override
  String get filteredMessage => 'फ़िल्टर ने छिपाया';

  @override
  String get filteredShow => 'दिखाएँ';

  @override
  String get filterToggle => 'आपत्तिजनक कंटेंट फ़िल्टर';

  @override
  String get filterToggleHint =>
      'अनजान लोगों और चैनलों में अभद्र शब्द छिपाता है';

  @override
  String get aboutTitle => 'जानकारी';

  @override
  String get aboutContact => 'डेवलपर को ईमेल करें';

  @override
  String get aboutReport => 'उल्लंघन की रिपोर्ट करें';

  @override
  String get aboutTerms => 'इस्तेमाल की शर्तें';

  @override
  String get aboutPrivacy => 'प्राइवेसी पॉलिसी';

  @override
  String get requestsTitle => 'अनुरोध';

  @override
  String get requestsEmpty => 'कोई अनुरोध नहीं';

  @override
  String requestBanner(String name) {
    return '$name आपके संपर्कों में नहीं हैं। जब तक आप स्वीकार नहीं करते, वे न यह देख सकते हैं कि आपने पढ़ लिया, न आपको कॉल कर सकते हैं।';
  }

  @override
  String get requestAccept => 'स्वीकार करें';

  @override
  String get requestDelete => 'डिलीट करें';

  @override
  String get requestBlock => 'ब्लॉक करें';

  @override
  String get cubeIdTitle => 'Cube ID';

  @override
  String get cubeIdExplainer =>
      'आपका @नाम आपके संपर्क कार्ड की ओर इशारा करता है। सर्वर सिर्फ़ नाम और आपका पब्लिक कार्ड रखता है — आपके मैसेज कभी नहीं।';

  @override
  String get cubeIdFieldHint => 'a–z, 0–9 और _, 3–20 अक्षर';

  @override
  String get cubeIdAvailable => 'उपलब्ध';

  @override
  String get cubeIdTaken => 'लिया जा चुका';

  @override
  String get cubeIdReserved => 'अनुमति नहीं';

  @override
  String get cubeIdInvalid => 'सिर्फ़ a–z, 0–9 और _, 3–20 अक्षर';

  @override
  String get cubeIdClaim => 'यह नाम लें';

  @override
  String get cubeIdWorking => 'नाम सुरक्षित किया जा रहा है…';

  @override
  String get cubeIdChange => 'बदलें';

  @override
  String get cubeIdEmail => 'रिकवरी ईमेल';

  @override
  String get cubeIdEmailHint =>
      'अगर यह फ़ोन खो जाए, तो इस पते पर भेजे गए ईमेल से नाम वापस मिल जाएगा';

  @override
  String get cubeIdEmailField => 'ईमेल';

  @override
  String cubeIdEmailSent(String email) {
    return '$email पर ईमेल भेजा गया। उसमें दिया लिंक खोलें।';
  }

  @override
  String get cubeIdEmailRemove => 'ईमेल हटाएँ';

  @override
  String get cubeIdEmailUnavailable =>
      'ईमेल अभी उपलब्ध नहीं है। बाद में कोशिश करें।';

  @override
  String get cubeIdEmailInvalid => 'यह ईमेल पता नहीं लगता';

  @override
  String get cubeIdSave => 'सेव करें';

  @override
  String get cubeIdRecover => 'ईमेल से नाम रिकवर करें';

  @override
  String get cubeIdRecoverSent =>
      'अगर पता मेल खाता है, तो ईमेल आएगा। उसका लिंक खोलने के 48 घंटे बाद नाम इस फ़ोन पर आ जाएगा।';

  @override
  String cubeIdRecoveryWarning(String name, String when) {
    return 'कोई दूसरे फ़ोन पर ईमेल से @$name रिकवर कर रहा है। अगर आप रद्द नहीं करते, तो यह $when चला जाएगा।';
  }

  @override
  String get cubeIdRecoveryCancel => 'रिकवरी रद्द करें';

  @override
  String get cubeIdRecoveryCancelled => 'रिकवरी रद्द की गई';

  @override
  String get cubeIdRelease => 'छोड़ें';

  @override
  String cubeIdReleaseConfirm(String name) {
    return '@$name छोड़ें? कोई भी इसे ले सकेगा।';
  }

  @override
  String get cubeIdShare => 'शेयर करें';

  @override
  String cubeIdShareText(String name) {
    return 'cubechat में मुझे ढूँढें: @$name\nhttps://cubechat.tech/u.html#$name';
  }

  @override
  String get cubeIdFailed => 'नाम सेव नहीं हो सका। फिर कोशिश करें।';

  @override
  String get cubeIdOffline => 'इंटरनेट नहीं';

  @override
  String get lookupNotFound => 'इस @नाम का कोई नहीं';

  @override
  String searchFindCubeName(String name) {
    return '@$name खोजें';
  }

  @override
  String get searchFindCubeNameHint => 'Cube ID पर खोजें और जोड़ें';

  @override
  String get addContactHintName => 'कार्ड पेस्ट करें या @नाम लिखें';

  @override
  String get strangerReachTitle => 'इंटरनेट से मुझे कौन मैसेज कर सकता है';

  @override
  String get strangerReachAll => 'सभी';

  @override
  String get strangerReachRequest => 'अनुरोध से';

  @override
  String get strangerReachNone => 'कोई नहीं';

  @override
  String get strangerReachHint =>
      'उन लोगों के लिए जिन्हें आपने नहीं लिखा और जो इंटरनेट से आप तक पहुँचते हैं। Bluetooth से आस-पास के लोगों पर इसका असर नहीं होता।';

  @override
  String get sectionPrivacy => 'प्राइवेसी और सुरक्षा';

  @override
  String get sectionNotifications => 'नोटिफ़िकेशन और कॉल';

  @override
  String get sectionConnection => 'कनेक्शन';

  @override
  String get sectionChats => 'चैट और मीडिया';

  @override
  String get sectionAppearance => 'रूप-रंग';

  @override
  String get sectionData => 'डेटा और स्टोरेज';

  @override
  String get sectionAbout => 'जानकारी';

  @override
  String get subWhoSeesMe => 'मुझे कौन देखता है';

  @override
  String get subProtection => 'सुरक्षा';

  @override
  String get subNotifications => 'नोटिफ़िकेशन';

  @override
  String get subCalls => 'कॉल';

  @override
  String get profileDiscoverableMeshOff =>
      'Bluetooth mesh बंद है — इसे कनेक्शन में चालू करें।';

  @override
  String get chatRouteBluetoothDirect => 'Bluetooth, सीधे';

  @override
  String chatRouteMeshHops(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'मेश · $n हॉप',
      one: 'मेश · $n हॉप',
    );
    return '$_temp0';
  }

  @override
  String chatRouteDeliveredVia(String route) {
    return 'डिलीवर हुआ: $route';
  }

  @override
  String chatRouteReceivedVia(String route) {
    return 'मिला: $route';
  }

  @override
  String get chatUnreadDivider => 'नए मैसेज';

  @override
  String get radioTitle => 'वॉकी-टॉकी';

  @override
  String get radioNearbySubtitle =>
      'बटन दबाकर रखें और किसी ग्रुप या संपर्क से बात करें';

  @override
  String get radioGroupsLabel => 'ग्रुप';

  @override
  String get radioDirectLabel => 'निजी';

  @override
  String get radioAddGroup => 'रेडियो जोड़ें';

  @override
  String get radioNoGroups =>
      'अभी कोई रेडियो नहीं। एक जोड़ें — जो भी वही नाम और पासवर्ड डालेगा, सब एक-दूसरे को सुनेंगे।';

  @override
  String get radioLeave => 'यह रेडियो छोड़ें';

  @override
  String get radioPickChannel => 'कोई ग्रुप या संपर्क चुनें';

  @override
  String get radioPushToTalk => 'बोलने के लिए दबाकर रखें';

  @override
  String get radioTalking => 'बोल रहे हैं…';

  @override
  String get radioChannelBusy => 'चैनल व्यस्त है';

  @override
  String radioSpeaker(String name) {
    return '$name बोल रहे हैं';
  }

  @override
  String get radioSilentTitle => 'साइलेंट मोड में भी बोलें';

  @override
  String get radioSilentHint =>
      'फ़ोन साइलेंट पर होने पर भी आवाज़ सुनाई देती है।';

  @override
  String get radioJoinNameLabel => 'नाम';

  @override
  String get radioJoinPasswordLabel => 'पासवर्ड (वैकल्पिक)';

  @override
  String get radioJoinHint =>
      'जो भी वही नाम और पासवर्ड डालता है, वह उसी रेडियो पर होता है। कोई सर्वर उनकी सूची नहीं रखता।';

  @override
  String get radioJoinNameRequired => 'नाम डालें';

  @override
  String get radioJoinSubmit => 'जोड़ें';

  @override
  String get radioBlockedTooLong => 'एक मिनट बोलने के बाद काट दिया गया';

  @override
  String get radioBlockedCall => 'कॉल चल रही है';

  @override
  String get radioBlockedMicrophone => 'माइक्रोफ़ोन की अनुमति नहीं है';

  @override
  String get radioBlockedUnavailable => 'इस डिवाइस पर रेडियो उपलब्ध नहीं है';

  @override
  String get radioBlockedNoChannel => 'पहले कोई ग्रुप या संपर्क चुनें';

  @override
  String get radioTurnOff => 'रेडियो बंद करें';

  @override
  String get radioPersonalCallsTitle => 'निजी कॉल लें';

  @override
  String get radioPersonalCallsHint =>
      'रेडियो बंद होने पर, जो संपर्क आपसे बात करता है, रेडियो अपने-आप उस पर सेट हो जाता है।';

  @override
  String get radioBackgroundHint =>
      'स्क्रीन बंद होने पर रेडियो सिर्फ़ तभी सुनाई देता है जब बैकग्राउंड मोड चालू हो।';

  @override
  String get areaNearby => 'आस-पास चैट';

  @override
  String get areaLevelDistrict => 'इलाका';

  @override
  String get areaLevelCity => 'शहर';

  @override
  String get areaLevelRegion => 'क्षेत्र';

  @override
  String areaPresentCount(int count) {
    return '≈$count यहाँ';
  }

  @override
  String get areaPresentMany => '50+ यहाँ';

  @override
  String get areaBlockViaBluetooth => 'आपका ब्लॉक — Bluetooth से';

  @override
  String get areaOpenNearbyTab => 'आस-पास खोलें';

  @override
  String get areaLocating => 'आपका इलाका खोजा जा रहा है…';

  @override
  String get areaNoPlace =>
      'अभी कोई लोकेशन नहीं। इलाके की चैट को, यह स्क्रीन खुली रहने तक, आपकी अनुमानित लोकेशन चाहिए।';

  @override
  String get areaLocationDenied =>
      'Cubechat के लिए लोकेशन बंद है। अपना इलाका देखने के लिए सेटिंग्स में अनुमानित लोकेशन की अनुमति दें।';

  @override
  String get areaOffline => 'इलाके की चैट से कनेक्शन नहीं';

  @override
  String get areaEmpty => 'पिछले 24 घंटों में यहाँ किसी ने कुछ नहीं लिखा।';

  @override
  String get areaConsentTitle => 'इलाके की चैट सार्वजनिक है';

  @override
  String get areaConsentBody =>
      'यहाँ के मैसेज सार्वजनिक हैं। जो भी आपका इलाका या शहर खोलेगा, वह इन्हें पढ़ेगा, और ये Cubechat सर्वर पर 24 घंटे तक रखे जाते हैं। आप एक अस्थायी नाम से लिखते हैं जो हर कुछ घंटों में बदलता है; आपका @नाम या आपके संपर्क कोई नहीं देखता। आपका इलाका जानने के लिए Cubechat आपकी अनुमानित लोकेशन माँगता है, सिर्फ़ तब तक जब तक यह स्क्रीन खुली है।';

  @override
  String get areaConsentAllow => 'जारी रखें';

  @override
  String get areaConsentDecline => 'अभी नहीं';

  @override
  String areaDefaultName(String tag) {
    return 'Cube-$tag';
  }

  @override
  String areaYouAre(String name, int hours) {
    return 'आप $name हैं · $hours घंटे में नया नाम';
  }

  @override
  String get areaNewName => 'नया नाम';

  @override
  String get areaSetName => 'नाम चुनें';

  @override
  String get areaNameHint =>
      'सिर्फ़ इस नाम के कुछ घंटों के लिए। अपने-आप वाले नाम के लिए खाली छोड़ें।';

  @override
  String get areaNameSameWarning =>
      'एक ही नाम अलग-अलग इलाकों में आपको आपस में जोड़ देता है';

  @override
  String get areaShowPresence => 'दिखाएँ कि मैं यहाँ हूँ';

  @override
  String get areaPresenceOffHint =>
      'आस-पास कितने लोग हैं, यह देखने के लिए “दिखाएँ कि मैं यहाँ हूँ” चालू करें';

  @override
  String get areaReadOnly => 'आप सिर्फ़ वहीं लिख सकते हैं जहाँ आप हैं';

  @override
  String get areaComposerHint => 'यहाँ सभी को मैसेज करें';

  @override
  String get areaSend => 'भेजें';

  @override
  String get areaWaitALittle => 'थोड़ा रुकें';

  @override
  String areaFlood(int count) {
    return 'फ़्लड ($count) · दिखाएँ';
  }

  @override
  String get areaReply => 'जवाब दें';

  @override
  String get areaHide => 'छिपाएँ';

  @override
  String get areaBlock => 'नाम बदलने तक ब्लॉक करें';

  @override
  String get areaBlocked => 'नाम बदलने तक ब्लॉक है';

  @override
  String get areaReport => 'रिपोर्ट करें';

  @override
  String get areaOpenLink => 'लिंक खोलें';

  @override
  String areaOpenLinkConfirm(String url) {
    return '$url खोलें?';
  }

  @override
  String get areaOpen => 'खोलें';

  @override
  String get areaReadHere => 'यहाँ पढ़ें';

  @override
  String get areaReadHereHint =>
      'सिर्फ़ पढ़ना। आप सिर्फ़ वहीं लिख सकते हैं जहाँ आप हैं; रिले को पता चलता है कि आप कौन-सी जगह पढ़ रहे हैं।';

  @override
  String get areaNotes => 'नोट';

  @override
  String areaNotesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count नोट',
      one: '$count नोट',
      zero: 'कोई नोट नहीं',
    );
    return '$_temp0';
  }

  @override
  String get areaLeaveNote => 'नोट छोड़ें';

  @override
  String get areaNoteHint => 'अपने शहर के लिए एक छोटा नोट';

  @override
  String get areaNoteLifetime => 'कितनी देर रहे';

  @override
  String get areaNote1h => '1 घंटा';

  @override
  String get areaNote24h => '24 घंटे';

  @override
  String get areaNote7d => '7 दिन';

  @override
  String get areaPinToDistrict => 'किसी इलाके पर पिन करें';

  @override
  String get areaPinHint =>
      'अपने शहर के अंदर मैप पर टैप करें; पिन उस इलाके से जुड़ जाएगा।';

  @override
  String get areaPinOutside => 'सिर्फ़ आपके शहर के अंदर';

  @override
  String get areaNoteDelete => 'मेरा नोट डिलीट करें';

  @override
  String get areaNoNotes => 'यहाँ अभी कोई नोट नहीं';

  @override
  String get areaNotesLimit => 'दिन में तीन नोट';

  @override
  String get areaNoteLeft => 'नोट छोड़ा गया';

  @override
  String get areaNoteSend => 'छोड़ें';

  @override
  String get areaOwnNote => 'आपका नोट';

  @override
  String get areaNotePinned => 'इलाके पर पिन किया';

  @override
  String get areaHidden => 'छिपा हुआ';

  @override
  String get areaPublicBadge => 'सार्वजनिक · 24 घंटे';

  @override
  String get areaSettingTitle => 'इलाके की चैट';

  @override
  String get areaSettingOnHint =>
      'मैप पर “आस-पास चैट” बटन: आपके इलाके और शहर की सार्वजनिक चैट, एक अस्थायी नाम से।';

  @override
  String get areaSettingOffHint =>
      'बंद: मैप पर कोई बटन नहीं, और इलाके की चैट कभी आपकी लोकेशन नहीं माँगती और न कनेक्ट होती है।';

  @override
  String get wallpaperPhotoLocalOnly =>
      'फ़ोटो वॉलपेपर अभी सिर्फ़ इसी डिवाइस पर लगते हैं';

  @override
  String get wallpaperSavedNoRoute =>
      'यहाँ सेव हो गया। अभी सामने वाले तक कोई रास्ता नहीं है';

  @override
  String get wallpaperScopeTitle => 'यह वॉलपेपर किसे दिखे?';

  @override
  String get wallpaperScopeChannel => 'पूरा चैनल';

  @override
  String get wallpaperScopeBoth => 'मैं और सामने वाला';

  @override
  String get wallpaperScopeLocal => 'सिर्फ़ मेरे पास';

  @override
  String get wallpaperScopeSharedHint =>
      'एन्क्रिप्टेड कंट्रोल पैकेट के रूप में भेजा जाता है';

  @override
  String get wallpaperScopePhotoHint => 'फ़ोटो अभी सिर्फ़ इसी फ़ोन पर रहती हैं';

  @override
  String get foldersCreate => 'फ़ोल्डर बनाएँ';

  @override
  String get foldersYours => 'आपके फ़ोल्डर';

  @override
  String get foldersSmartFilters => 'स्मार्ट फ़िल्टर';

  @override
  String get foldersName => 'फ़ोल्डर का नाम';

  @override
  String get foldersSave => 'सेव करें';

  @override
  String get foldersDeleteTitle => 'फ़ोल्डर हटाएँ?';

  @override
  String get foldersDelete => 'हटाएँ';

  @override
  String get foldersCreateAction => 'बनाएँ';

  @override
  String get chatsArchiveHiddenToast =>
      'आर्काइव छिपा दिया गया। इसे “रूप-रंग” में वापस लाएँ।';

  @override
  String get chatsBulkPin => 'पिन करें';

  @override
  String get chatsBulkMute => 'म्यूट करें';

  @override
  String get chatsUnarchive => 'आर्काइव से निकालें';

  @override
  String get chatsAddToFolder => 'फ़ोल्डर में जोड़ें';

  @override
  String get chatsMarkUnread => 'अपठित मार्क करें';

  @override
  String get chatsClearHistory => 'चैट हिस्ट्री साफ़ करें';

  @override
  String get foldersNew => 'नया फ़ोल्डर';

  @override
  String get foldersNameHint => 'दोस्त';

  @override
  String get chatsNoIncoming => 'कोई आने वाला मैसेज नहीं';

  @override
  String get chatsMarkedUnread => 'अपठित मार्क किया गया';

  @override
  String get chatsClearHistoryTitle => 'चैट हिस्ट्री साफ़ करें?';

  @override
  String get chatsClearHistoryBody =>
      'मैसेज सिर्फ़ इसी डिवाइस से हटेंगे। चैट, संपर्क और पसंदीदा बने रहेंगे।';

  @override
  String get chatsClearHistoryAction => 'साफ़ करें';

  @override
  String get chatsHistoryCleared => 'हिस्ट्री साफ़ हो गई';

  @override
  String get savedTagMenuTag => 'टैग';

  @override
  String get savedTagRemove => 'टैग हटाएँ';

  @override
  String get customizeArchiveRowTitle => 'आर्काइव पंक्ति';

  @override
  String get customizeArchiveRowHint =>
      'इसे चैट सूची के ऊपर दिखाएँ। आर्काइव की गई चैट को मैसेज मिलते रहते हैं।';

  @override
  String get mapLayerStandard => 'स्टैंडर्ड';

  @override
  String get mapLayerStandardHint => 'हल्का सड़क मैप — सबसे स्थिर विकल्प';

  @override
  String get backupAutoTitle => 'ऑटो बैकअप';

  @override
  String get backupAutoHint =>
      'दिन में एक बार, चुने गए फ़ोल्डर की एक ही फ़ाइल में; हर कॉपी पिछली कॉपी की जगह लेती है।';

  @override
  String backupAutoFolder(String name) {
    return 'फ़ोल्डर: $name';
  }

  @override
  String backupAutoLast(String time) {
    return 'आख़िरी कॉपी: $time';
  }

  @override
  String get backupAutoNever => 'अभी कोई कॉपी नहीं';

  @override
  String get backupAutoRunning => 'कॉपी बन रही है…';

  @override
  String get backupAutoFolderLost =>
      'फ़ोल्डर तक नहीं पहुँचा जा सका। इसे फिर से चुनें।';

  @override
  String get backupAutoFailed =>
      'आख़िरी कॉपी नहीं बन पाई। बाद में फिर कोशिश होगी।';

  @override
  String get backupAutoNow => 'अभी बैकअप लें';

  @override
  String get backupAutoChangeFolder => 'फ़ोल्डर बदलें';

  @override
  String get callYourMicOff => 'आपका माइक बंद है';

  @override
  String callTheirCameraOff(String name) {
    return '$name का कैमरा बंद है';
  }
}
