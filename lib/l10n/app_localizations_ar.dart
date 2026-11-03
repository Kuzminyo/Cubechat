// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get callVoice => 'مكالمة صوتية';

  @override
  String get callVideo => 'مكالمة فيديو';

  @override
  String get callIncomingVideo => 'مكالمة فيديو واردة';

  @override
  String get callCamera => 'الكاميرا';

  @override
  String get callFlipCamera => 'قلب';

  @override
  String get contactProfileVideo => 'فيديو';

  @override
  String get callPreparing => 'جارٍ تجهيز الميكروفون…';

  @override
  String get callDialing => 'جارٍ الاتصال…';

  @override
  String get callRinging => 'يرنّ…';

  @override
  String get callConnecting => 'جارٍ الربط…';

  @override
  String get callMicrophoneRequired =>
      'اسمح بالوصول إلى الميكروفون في إعدادات النظام لإجراء المكالمات.';

  @override
  String get callMicrophoneWindows =>
      'لم يمنح Windows تطبيق CubeChat الوصول إلى الميكروفون. شغّل الإعدادات ← الخصوصية والأمان ← الميكروفون ← «السماح لتطبيقات سطح المكتب بالوصول إلى الميكروفون».';

  @override
  String get callElsewhere =>
      'هناك مكالمة جارية بالفعل على جهاز آخر لهذا الحساب.';

  @override
  String get callRelayUnavailable =>
      'خادم المكالمات غير متاح. يُرجى المحاولة لاحقًا.';

  @override
  String get callBusy => 'مشغول';

  @override
  String get callNoAnswer => 'لا إجابة';

  @override
  String get callFailed => 'تعذّر إجراء المكالمة';

  @override
  String get callDeclined => 'تم رفض المكالمة';

  @override
  String get callEnded => 'انتهت المكالمة';

  @override
  String get callMicrophone => 'الميكروفون';

  @override
  String get callSpeaker => 'مكبّر الصوت';

  @override
  String get callAnswer => 'رد';

  @override
  String get callDecline => 'رفض';

  @override
  String get callEnd => 'إنهاء';

  @override
  String get callClose => 'إغلاق';

  @override
  String get callMinimize => 'تصغير';

  @override
  String get callAudioOutput => 'صوت المكالمة';

  @override
  String get callRoutePhone => 'الهاتف';

  @override
  String get callRouteBluetooth => 'Bluetooth';

  @override
  String get callRouteHeadphones => 'سماعات الرأس';

  @override
  String get callFullScreenTitle => 'المكالمات على شاشة القفل';

  @override
  String get callFullScreenBody =>
      'اسمح بظهور المكالمة الواردة على الشاشة المقفلة حتى يمكن الرد عليها دون فتح القفل.';

  @override
  String get callFullScreenXiaomi =>
      'لا تسمح Xiaomi وRedmi وPoco للتطبيقات بتشغيل هذا الخيار بنفسها: شغّل «العرض على شاشة القفل» ضمن الأذونات الأخرى.';

  @override
  String get circleMessage => 'رسالة فيديو';

  @override
  String get appName => 'Cubechat';

  @override
  String get navChats => 'الدردشات';

  @override
  String get navPeers => 'بالقرب';

  @override
  String get navProfile => 'ملفي';

  @override
  String get navContacts => 'جهات الاتصال';

  @override
  String get navMap => 'الخريطة';

  @override
  String get mapTitle => 'الخريطة';

  @override
  String get mapFriendsTitle => 'أشخاص على الخريطة';

  @override
  String get mapFriendsHint => 'جهات الاتصال هذه فقط تتلقى موقعك';

  @override
  String mapClusterTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count شخص هنا',
      many: '$count شخصًا هنا',
      few: '$count أشخاص هنا',
      two: 'شخصان هنا',
      one: 'شخص واحد هنا',
      zero: 'لا أحد هنا',
    );
    return '$_temp0';
  }

  @override
  String get mapClusterHint => 'اضغط على أحدهم لتحريك الخريطة إليه';

  @override
  String get mapNorthUp => 'توجيه الشمال للأعلى';

  @override
  String get mapLayerTitle => 'نمط الخريطة';

  @override
  String get mapLayerHint => 'الخلفية التي تُرسم عليها الدبابيس';

  @override
  String get mapLayerDark => 'داكنة';

  @override
  String get mapLayerDarkHint => 'شوارع بلا تسميات — الأهدأ تحت الدبابيس';

  @override
  String get mapLayerSatellite => 'قمر صناعي';

  @override
  String get mapLayerSatelliteHint => 'صور جوية: أي مبنى، أي فناء';

  @override
  String get mapLayerTerrain => 'تضاريس';

  @override
  String get mapLayerTerrainHint => 'خطوط الكنتور والتضاريس، للتلال والمسارات';

  @override
  String get mapFriendsEmpty => 'لا أحد يشارك الخريطة معك بعد.';

  @override
  String get mapFriendsEmptyHint =>
      'ادعُ جهة اتصال وستظهر هنا بعد أن تقبل الدعوة.';

  @override
  String get mapFriendsInvite => 'دعوة';

  @override
  String get mapFriendsRemove => 'إزالة من الخريطة';

  @override
  String mapFriendsRemoved(String name) {
    return 'لم يعد $name يشارك الخريطة معك';
  }

  @override
  String get mapFriendsLive => 'على الخريطة الآن';

  @override
  String get mapFriendsIdle => 'لا يوجد موقع حاليًا';

  @override
  String get mapInviteTitle => 'دعوة إلى الخريطة';

  @override
  String get mapInviteHint => 'اختر دردشة واحدة أو أكثر';

  @override
  String get mapInviteEmpty => 'لا توجد دردشات للدعوة بعد.';

  @override
  String mapInviteAction(int count) {
    return 'إرسال ($count)';
  }

  @override
  String get mapInviteMessage =>
      'دعوة إلى خريطة Cubechat. شارك موقعك في هذه الدردشة لتظهر على الخريطة.';

  @override
  String mapInviteSent(int count) {
    return 'الدعوات المُرسلة: $count';
  }

  @override
  String get mapInviteFailed => 'تعذّر إرسال الدعوات';

  @override
  String mapPeopleVisible(int count) {
    return 'المواقع المشتركة: $count';
  }

  @override
  String get mapCenterMe => 'توسيط على موقعي';

  @override
  String get mapNoSharedLocations => 'لا توجد مواقع مشتركة بعد';

  @override
  String get mapNoSharedLocationsHint =>
      'تظهر جهة الاتصال هنا بعد أن ترسل موقعها في الدردشة.';

  @override
  String get mapWebHintTitle => 'الاتصالات القريبة';

  @override
  String get mapWebHint => 'تُظهر الخطوط القرب، لا مسار الرسائل.';

  @override
  String get mapOpenProfile => 'الملف الشخصي';

  @override
  String get mapLocationPrivacyOff => 'الموقع مخفي على الخريطة';

  @override
  String get mapLocationPrivacyOffHint =>
      'شغّل «إظهاري على الخريطة» ضمن الخصوصية لعرض دبوسك.';

  @override
  String get mapYouOnMap => 'موقعك ظاهر على هذا الجهاز';

  @override
  String get locationSharingDisabled =>
      'شغّل «إظهاري على الخريطة» ضمن الخصوصية أولًا.';

  @override
  String get mapLocationDenied => 'الوصول إلى الموقع معطّل';

  @override
  String get mapLocationServiceOff => 'شغّل خدمات الموقع لإظهار نفسك';

  @override
  String get mapLocationUnavailable => 'تعذّر تحديد موقعك';

  @override
  String get mapDistanceUnknown => 'المسافة غير متاحة';

  @override
  String mapDistanceMetres(int metres) {
    return 'على بُعد $metres م';
  }

  @override
  String mapDistanceKilometres(String kilometres) {
    return 'على بُعد $kilometres كم';
  }

  @override
  String get mapUpdatedNow => 'شاركه للتو';

  @override
  String mapUpdatedMinutes(int minutes) {
    return 'شاركه قبل $minutes د';
  }

  @override
  String mapUpdatedHours(int hours) {
    return 'شاركه قبل $hours س';
  }

  @override
  String get contactsTitle => 'جهات الاتصال';

  @override
  String get contactsSubtitle => 'كل من راسلتهم';

  @override
  String get contactsSearchHint => 'ابحث في جهات الاتصال…';

  @override
  String get contactsEmptyTitle => 'لا توجد جهات اتصال بعد';

  @override
  String get contactsEmptyHint => 'ابدأ محادثة وسيظهر الشخص هنا.';

  @override
  String get contactsSearchEmpty => 'لا توجد جهات اتصال مطابقة';

  @override
  String get contactsTabContacts => 'جهات الاتصال';

  @override
  String get contactsTabCalls => 'المكالمات';

  @override
  String get callsFilterAll => 'الكل';

  @override
  String get callsFilterMissed => 'الفائتة';

  @override
  String get callsEmptyTitle => 'لا توجد مكالمات بعد';

  @override
  String get callsEmptyHint => 'ستظهر هنا المكالمات الواردة والصادرة والفائتة.';

  @override
  String get callsMissedEmpty => 'لا توجد مكالمات فائتة';

  @override
  String get callsCallBack => 'اتصال';

  @override
  String get contactProfileChat => 'دردشة';

  @override
  String get contactProfileCall => 'اتصال';

  @override
  String get contactProfileRadio => 'لاسلكي';

  @override
  String get contactProfileSecurity => 'الأمان';

  @override
  String get contactProfileActions => 'إجراءات جهة الاتصال';

  @override
  String get contactProfileVerify => 'تحقّق';

  @override
  String get contactProfileCopyId => 'نسخ معرّف جهة الاتصال';

  @override
  String get contactProfileIdCopied => 'تم نسخ معرّف جهة الاتصال';

  @override
  String get contactProfileId => 'معرّف جهة الاتصال';

  @override
  String get contactProfileVerifyHint =>
      'قارن بصمات التشفير للتأكد من هوية هذا الشخص.';

  @override
  String get chatsTitle => 'الدردشات';

  @override
  String get chatsSubtitle => 'Mesh · تشفير تام بين الطرفين';

  @override
  String get chatsEmptyTitle => 'لا توجد محادثات بعد';

  @override
  String get chatsEmptyHint =>
      'افتح أحد الأشخاص من تبويب «بالقرب» لبدء الدردشة.';

  @override
  String get chatsFilterAll => 'الكل';

  @override
  String get chatsFilterUnread => 'غير المقروءة';

  @override
  String get chatsFilterMesh => 'Mesh';

  @override
  String get chatsFilterFavorites => 'المفضلة';

  @override
  String get chatsFolderDirect => 'الخاصة';

  @override
  String get chatsFolderChannels => 'القنوات';

  @override
  String get chatsFolderOnline => 'المتصلون';

  @override
  String get chatsFoldersTitle => 'المجلدات';

  @override
  String get chatsFoldersHint =>
      'المجلدات هي طرق عرض لهذه القائمة، لا أماكن تُنقل إليها الدردشات. شغّل ما تريده منها فوق الدردشات.';

  @override
  String get chatsSearchHint => 'ابحث في الدردشات…';

  @override
  String get chatsStatusViaMesh => 'عبر Mesh';

  @override
  String get chatsStatusOffline => 'غير متصل';

  @override
  String get peerKeyRotated => 'تغيّر المفتاح — تحقّق مجددًا';

  @override
  String get peersTitle => 'بالقرب';

  @override
  String get peersSubtitle => 'الأجهزة ضمن نطاق Bluetooth';

  @override
  String get peersEmpty => 'جارٍ البحث عن أشخاص قريبين…';

  @override
  String peersHopsOne(int n) {
    return 'على بُعد $n قفزة';
  }

  @override
  String peersHopsOther(int n) {
    return 'عدد القفزات: $n';
  }

  @override
  String get blePermissionTitle => 'يلزم إذن Bluetooth';

  @override
  String get blePermissionHint =>
      'يحتاج Cubechat إلى Bluetooth للعثور على الأشخاص القريبين وإرسال الرسائل — دون الحاجة إلى الإنترنت.';

  @override
  String get blePermissionGrant => 'منح الإذن';

  @override
  String get blePermissionOpenSettings => 'فتح الإعدادات';

  @override
  String get blePermissionDeniedHint =>
      'تم رفض الإذن. افتح الإعدادات للسماح بالوصول إلى Bluetooth.';

  @override
  String get bleAdapterOffTitle => 'Bluetooth متوقف';

  @override
  String get bleAdapterOffHint => 'شغّل Bluetooth لرؤية الأشخاص القريبين.';

  @override
  String get bleUnsupportedTitle => 'Bluetooth LE غير متاح';

  @override
  String get bleUnsupportedHint =>
      'هذا الجهاز أو النظام لا يوفّر Bluetooth منخفض الطاقة. جرّبه على هاتف.';

  @override
  String get bleScanning => 'جارٍ الفحص…';

  @override
  String get bleRetry => 'إعادة المحاولة';

  @override
  String get bleEnable => 'تشغيل';

  @override
  String get bleConnectFailed =>
      'تعذّر الاتصال. ربما يكون الطرف الآخر خارج النطاق، أو تغيّر عنوان Bluetooth الخاص به.';

  @override
  String get bleSignal => 'الإشارة';

  @override
  String get bleConnect => 'اتصال';

  @override
  String get bleConnected => 'متصل';

  @override
  String get bleVerified => 'تم التحقق';

  @override
  String get editorAdjustBrightness => 'السطوع';

  @override
  String get editorAdjustContrast => 'التباين';

  @override
  String get editorAdjustSaturation => 'التشبّع';

  @override
  String get editorToolCrop => 'قص';

  @override
  String get editorToolDraw => 'رسم';

  @override
  String get editorToolAdjust => 'ضبط';

  @override
  String get editorTabSticker => 'ملصق';

  @override
  String get editorTabText => 'نص';

  @override
  String get editorPenPen => 'قلم';

  @override
  String get editorPenMarker => 'ماركر';

  @override
  String get editorPenNeon => 'نيون';

  @override
  String get editorPenArrow => 'سهم';

  @override
  String get editorPenBlur => 'تمويه';

  @override
  String get editorPenEraser => 'ممحاة';

  @override
  String get editorLevel => 'تسوية';

  @override
  String get editorTextHint => 'نص على الصورة';

  @override
  String get editorCropFree => 'حر';

  @override
  String get editorRemove => 'إزالة';

  @override
  String get notificationUnknownSender => 'رسالة جديدة';

  @override
  String get bleUnknownPeer => 'طرف غير معروف';

  @override
  String get bleBroadcasting => 'قيد البث';

  @override
  String bleConnectedCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n جهاز مركزي متصل',
      many: '$n جهازًا مركزيًا متصلًا',
      few: '$n أجهزة مركزية متصلة',
      two: 'جهازان مركزيان متصلان',
      one: 'جهاز مركزي واحد متصل',
      zero: 'لا توجد أجهزة مركزية',
    );
    return '$_temp0';
  }

  @override
  String get verifyTitle => 'التحقق من الطرف الآخر';

  @override
  String get verifyIntro =>
      'قارن هاتين البصمتين مع الطرف الآخر وجهًا لوجه أو عبر مكالمة صوتية. إذا تطابقتا لدى الطرفين، فقد تأكدت من أن مصافحة Noise لم يُعبث بها.';

  @override
  String get verifyMine => 'بصمتك';

  @override
  String verifyTheirs(String name) {
    return 'بصمة $name';
  }

  @override
  String get verifyMarkAsVerified => 'وضع علامة «تم التحقق»';

  @override
  String get verifyAlreadyDone => 'تم التحقق من هذا الطرف.';

  @override
  String get verifyRevoke => 'إلغاء';

  @override
  String verifyDoneSnack(String name) {
    return 'تم التحقق من $name';
  }

  @override
  String get chatInputHint => 'رسالة';

  @override
  String get chatSend => 'إرسال';

  @override
  String get chatToday => 'اليوم';

  @override
  String get chatYesterday => 'أمس';

  @override
  String get chatDelivered => 'تم التسليم';

  @override
  String get chatRead => 'مقروءة';

  @override
  String get chatSending => 'جارٍ الإرسال';

  @override
  String get chatWaitingForConnection => 'في انتظار الاتصال';

  @override
  String sendQueueCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count رسالة في انتظار الاتصال',
      many: '$count رسالة في انتظار الاتصال',
      few: '$count رسائل في انتظار الاتصال',
      two: 'رسالتان في انتظار الاتصال',
      one: 'رسالة واحدة في انتظار الاتصال',
      zero: 'لا توجد رسائل في انتظار الاتصال',
    );
    return '$_temp0';
  }

  @override
  String sendQueueSlowNetwork(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'شبكة بطيئة — جارٍ إرسال $count رسالة',
      many: 'شبكة بطيئة — جارٍ إرسال $count رسالة',
      few: 'شبكة بطيئة — جارٍ إرسال $count رسائل',
      two: 'شبكة بطيئة — جارٍ إرسال رسالتين',
      one: 'شبكة بطيئة — جارٍ إرسال رسالة واحدة',
      zero: 'شبكة بطيئة — لا رسائل قيد الإرسال',
    );
    return '$_temp0';
  }

  @override
  String get sendQueueTitle => 'في انتظار الإرسال';

  @override
  String get sendQueueHint =>
      'ستُرسل تلقائيًا فور توفّر طريق — Bluetooth قريب أو الإنترنت. لا حاجة للضغط على أي شيء.';

  @override
  String get sendQueueRetry => 'جرّب الآن';

  @override
  String get sendQueueCancel => 'إلغاء الإرسال';

  @override
  String get sendQueueCancelled => 'لم تُرسل — تم سحبها';

  @override
  String get sendQueueTooLate => 'فات أوان سحبها: لقد أُرسلت بالفعل';

  @override
  String get chatEncryptedNotice =>
      'الرسائل مشفّرة تمامًا بين الطرفين باستخدام بروتوكول Noise.';

  @override
  String get chatSessionHandshaking => 'جارٍ إنشاء قناة آمنة…';

  @override
  String get chatSessionEstablished => 'محمي · Noise XX';

  @override
  String get chatSessionFailed => 'فشل الاتصال';

  @override
  String get presenceOnline => 'متصل';

  @override
  String get presenceOffline => 'غير متصل';

  @override
  String get chatSessionFingerprintPending =>
      'ستظهر البصمة بعد اكتمال المصافحة.';

  @override
  String get chatEmptyEstablished =>
      'القناة الآمنة جاهزة. أرسل رسالة لبدء المحادثة.';

  @override
  String get chatEmptyHandshaking => 'في انتظار أن يُكمل الطرف الآخر المصافحة…';

  @override
  String get chatEmptyTitle => 'لا توجد رسائل هنا بعد';

  @override
  String get chatEmptyGreetHint =>
      'أرسل رسالة، أو اضغط على كوبي لإلقاء التحية.';

  @override
  String get profileTitle => 'الملف الشخصي';

  @override
  String get profileNickname => 'الاسم المستعار';

  @override
  String get profileNicknameEditTitle => 'عيّن اسمك المستعار';

  @override
  String get profileNicknameHint => 'كيف يراك الآخرون على Mesh';

  @override
  String get profileNicknameSave => 'حفظ';

  @override
  String get profileFingerprint => 'بصمة المفتاح العام';

  @override
  String get profileLanguage => 'اللغة';

  @override
  String get profileLanguageEn => 'الإنجليزية';

  @override
  String get profileLanguageUk => 'الأوكرانية';

  @override
  String get profileTransport => 'وسيلة النقل';

  @override
  String get profileTransportMesh => 'Bluetooth Mesh';

  @override
  String get profileBackground => 'البقاء متاحًا في الخلفية';

  @override
  String get profileBackgroundSubtitle => 'مواصلة تلقي الرسائل والتطبيق مغلق';

  @override
  String get profileBatteryExempt => 'تعطيل تحسين البطارية';

  @override
  String get profileAbout => 'حول التطبيق';

  @override
  String profileVersion(String v) {
    return 'الإصدار $v';
  }

  @override
  String get rotateKeysTitle => 'تغيير مفاتيح الحساب';

  @override
  String get rotateKeysHint => 'إذا فُقد جهاز عليه حسابك أو سُرق';

  @override
  String get rotateKeysConfirmTitle => 'تغيير مفاتيح حسابك؟';

  @override
  String get rotateKeysConfirmBody =>
      'ستصل مفاتيحك الجديدة إلى جهات اتصالك وتبقى دردشاتك كما هي، لكن سيُطلب من كل منهم التحقق من مفاتيحك مجددًا. ستُسجَّل جميع أجهزة حسابك الأخرى خروجها؛ اربط مجددًا ما تريد الاحتفاظ به من هذا الهاتف. جهات الاتصال التي تستخدم إصدارًا أقدم من CubeChat لن تتمكن من الوصول إليك حتى تحدّثه. تحتفظ القنوات بمفاتيحها.';

  @override
  String get rotateKeysConfirmAction => 'تغيير المفاتيح';

  @override
  String get rotateKeysWorking => 'جارٍ تغيير المفاتيح…';

  @override
  String rotateKeysDone(int sent, int total) {
    return 'مفاتيح جديدة. تم إبلاغ $sent من $total جهة اتصال';
  }

  @override
  String get rotateKeysSlow =>
      'مفاتيح جديدة. لم تؤكد كل جهات الاتصال في الوقت المحدد؛ ستحتفظ المُرحِّلات بها من أجلهم';

  @override
  String get profileEmergencyWipe => 'مسح طارئ';

  @override
  String get profileEmergencyWipeConfirm => 'مسح كل شيء؟';

  @override
  String get profileEmergencyWipeConfirmHint =>
      'سيؤدي هذا إلى إزالة هويتك وقائمة الأشخاص وسجل المحادثات. لا يمكن التراجع عن ذلك.';

  @override
  String get profileEmergencyWipeAction => 'مسح';

  @override
  String get cancel => 'إلغاء';

  @override
  String get copy => 'نسخ';

  @override
  String get copied => 'تم النسخ';

  @override
  String get channelsNewTitle => 'قناة جديدة';

  @override
  String get channelsNewTooltip => 'قناة جديدة';

  @override
  String get channelNameLabel => 'اسم القناة';

  @override
  String get channelPasswordLabel => 'كلمة المرور (اختياري)';

  @override
  String get channelJoinAction => 'انضمام';

  @override
  String get channelNameHint =>
      'كل من يُدخل الاسم وكلمة المرور نفسيهما يصل إلى الغرفة ذاتها. لا يوجد خادم يحتفظ بقائمة بها.';

  @override
  String get channelPasswordHint =>
      'كلمة المرور هي المفتاح. بدونها تكون الغرفة مفتوحة لأي شخص قريب يعرف اسمها.';

  @override
  String get channelSubtitle => 'قناة جماعية · مفتاح مشترك';

  @override
  String get channelMute => 'كتم';

  @override
  String get channelUnmute => 'إلغاء الكتم';

  @override
  String channelMutedUntil(String time) {
    return 'مكتومة حتى $time';
  }

  @override
  String get channelMuteFor => 'كتم لمدة…';

  @override
  String channelMuteMinutes(int minutes) {
    return '$minutes دقيقة';
  }

  @override
  String channelMuteHours(int hours) {
    return '$hours ساعة';
  }

  @override
  String channelMuteDays(int days) {
    return '$days يوم';
  }

  @override
  String get channelMuteForever => 'حتى أعيد تشغيلها';

  @override
  String get channelCommunity => 'التعليقات';

  @override
  String get channelCommunityOpen => 'فتح النقاش';

  @override
  String channelCommunitySubtitle(String channel) {
    return 'نقاش $channel';
  }

  @override
  String get channelBackToChannel => 'العودة إلى القناة';

  @override
  String get channelMemberActions => 'عضو';

  @override
  String get channelRemoveMember => 'إزالة من القناة';

  @override
  String get channelRemoveMemberHint =>
      'لن تُقبل منشوراته هنا بعد الآن. لا شيء يمنعه من الانضمام مجددًا بالاسم — فالمفتاح المشترك هو العضوية الوحيدة الموجودة.';

  @override
  String get channelMuteMember => 'كتم لمدة…';

  @override
  String get channelUnmuteMember => 'السماح له بالنشر مجددًا';

  @override
  String channelMemberRemoved(String name) {
    return 'تمت إزالة $name';
  }

  @override
  String channelMemberMuted(String name) {
    return 'تم كتم $name';
  }

  @override
  String channelMemberCleared(String name) {
    return 'يمكن لـ $name النشر مجددًا';
  }

  @override
  String get channelMemberMutedNote => 'مكتوم';

  @override
  String get channelShareHistory => 'مشاركة السجل';

  @override
  String get channelShareHistoryHint =>
      'يعيد بث آخر منشورات هذه الغرفة، ليتمكن من انضم لاحقًا من رؤيتها. لن يتلقى من كان هنا من قبل أي شيء جديد.';

  @override
  String channelHistoryShared(int count) {
    return 'المنشورات المعروضة: $count';
  }

  @override
  String get channelHistoryNothing => 'لا شيء للمشاركة بعد';

  @override
  String get channelHistoryAuto => 'منح الأعضاء الجدد السجل';

  @override
  String get channelHistoryAutoHint =>
      'عندما يظهر شخص جديد في الغرفة، تُرسل إليه المنشورات الأخيرة تلقائيًا. النصوص فقط حاليًا — فالصور تُرسل كتدفقات مجزأة ولا يمكن إعادة بثها دون تكرارها للجميع.';

  @override
  String get channelPostComments => 'التعليقات';

  @override
  String get channelNoComments => 'لا تعليقات على هذا المنشور بعد';

  @override
  String get channelCommentHint => 'تعليق';

  @override
  String get channelMuteCustom => 'لأي مدة؟';

  @override
  String get channelMuteCustomHint => 'ساعات';

  @override
  String get chatPinnedManage => 'المثبّتة';

  @override
  String get chatPeekOpen => 'فتح الدردشة';

  @override
  String get chatPeekPin => 'تثبيت';

  @override
  String get chatPeekUnpin => 'إلغاء التثبيت';

  @override
  String get chatPeekUnmute => 'إلغاء الكتم';

  @override
  String get chatPeekMarkRead => 'تعليم كمقروءة';

  @override
  String get chatDeleteForMeHint =>
      'تُحذف من هذا الهاتف ويُلغى تثبيتها. يحتفظ الطرف الآخر بنسخته.';

  @override
  String get pushWakeTitle => 'إيقاظ هذا الهاتف';

  @override
  String get pushWakeHint =>
      'يراقب خادم صغير المُرحِّلات بحثًا عن عنوانك وينبّه هذا الهاتف عند وصول شيء، فيُعلمك التطبيق حتى وهو مغلق. لا يرى الخادم أي رسالة أو مفتاح — فقط أن عنوانك تلقى شيئًا، ومتى. المُرحِّل يعرف ذلك أصلًا؛ وهذا مكان ثانٍ يعرفه.';

  @override
  String get pushWakeDeniedTitle => 'الإشعارات متوقفة';

  @override
  String get pushWakeDeniedHint =>
      'رُفض طلب النظام مرة ولن يسأل مجددًا، لذا لا يمكن إعادة تشغيل هذا إلا من الإعدادات — cubechat، ثم الإشعارات. عُد إلى هنا بعد ذلك.';

  @override
  String get pushWakeRefused => 'لم يُسمح بالإشعارات';

  @override
  String get privacyForwardLinkTitle => 'رابط من الرسائل المُعاد توجيهها';

  @override
  String get privacyForwardLinkHint =>
      'عندما يعيد أحدهم توجيه رسالة منك، يمكن للسطر الذي فوقها أن يفتح ملفك الشخصي. عند الإيقاف، يرون اسمك فقط دون ما يُضغط عليه. هذا طلب إلى تطبيقهم، وليس شيئًا يستطيع هذا التطبيق فرضه.';

  @override
  String get privacyShareSheetTitle => 'الدردشات في قائمة المشاركة';

  @override
  String get privacyShareSheetOnHint =>
      'تُعطى أسماء آخر أربع دردشات لك إلى Android، لتتمكن من الإرسال إليها من أي تطبيق. قفل التطبيق لا يخفيها.';

  @override
  String get privacyShareSheetOffHint =>
      'لا يُعطى أي شيء إلى Android. عند المشاركة إلى CubeChat سيُطلب منك اختيار الدردشة.';

  @override
  String get privacyCallsTitle => 'قبول المكالمات';

  @override
  String get privacyCallsOnHint =>
      'يمكن لجهات اتصالك الاتصال بك. لرفض شخص بعينه، افتح ملفه الشخصي.';

  @override
  String get privacyCallsOffHint =>
      'لا يمكن لأحد الاتصال بك، باستثناء من تسمح لهم في ملفاتهم الشخصية. تصلهم المكالمة المرفوضة على أنك مشغول.';

  @override
  String get chatsStatusChannel => 'قناة';

  @override
  String get channelInviteTitle => 'إضافة أشخاص';

  @override
  String get channelInviteAction => 'دعوة';

  @override
  String get channelInviteEmpty =>
      'لا يوجد أشخاص معروفون بعد. تعرّف على أحدهم في تبويب «بالقرب» أولًا.';

  @override
  String get channelInviteSent => 'تم إرسال الدعوات';

  @override
  String get channelInviteNoneSent => 'تعذّر الوصول إلى أي أحد الآن';

  @override
  String get channelNameTooLong => 'اسم القناة طويل جدًا';

  @override
  String get chatsActionFavorite => 'إضافة إلى المفضلة';

  @override
  String get chatsActionUnfavorite => 'إزالة من المفضلة';

  @override
  String get chatsActionDelete => 'حذف الدردشة';

  @override
  String get chatsDeleteTitle => 'حذف هذه الدردشة؟';

  @override
  String chatsDeleteManyHint(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'يمسح $count محادثة. تبقى جهات الاتصال، لتتمكن من مراسلتها مجددًا دون تبادل الرموز.',
      many:
          'يمسح $count محادثة. تبقى جهات الاتصال، لتتمكن من مراسلتها مجددًا دون تبادل الرموز.',
      few:
          'يمسح $count محادثات. تبقى جهات الاتصال، لتتمكن من مراسلتها مجددًا دون تبادل الرموز.',
      two:
          'يمسح محادثتين. تبقى جهات الاتصال، لتتمكن من مراسلتها مجددًا دون تبادل الرموز.',
      one:
          'يمسح محادثة واحدة. تبقى جهة الاتصال، لتتمكن من مراسلتها مجددًا دون تبادل الرموز.',
      zero:
          'لن تُمسح أي محادثة. تبقى جهات الاتصال، لتتمكن من مراسلتها مجددًا دون تبادل الرموز.',
    );
    return '$_temp0';
  }

  @override
  String get chatsDeletedToast => 'تم حذف الدردشة.';

  @override
  String chatsDeletedManyToast(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'تم حذف $count دردشة.',
      many: 'تم حذف $count دردشة.',
      few: 'تم حذف $count دردشات.',
      two: 'تم حذف دردشتين.',
      one: 'تم حذف دردشة واحدة.',
      zero: 'لم تُحذف أي دردشة.',
    );
    return '$_temp0';
  }

  @override
  String get undo => 'تراجع';

  @override
  String get chatsDeletePeerHint =>
      'يمسح المحادثة. تبقى جهة الاتصال، لتتمكن من مراسلتها مجددًا دون تبادل الرموز.';

  @override
  String get chatsDeleteChannelHint =>
      'يغادر القناة ويحذف سجلها. ستحتاج إلى المفتاح مجددًا للانضمام.';

  @override
  String get chatsDeleteForThemToo => 'الحذف لديه أيضًا';

  @override
  String get chatsDeleteForThemHint =>
      'يطلب من تطبيقه مسح المحادثة كاملة أيضًا، بما في ذلك ما كتبه هو. في القناة، تُسحب رسائلك فقط.';

  @override
  String get chatEditAction => 'تعديل';

  @override
  String get chatEditTitle => 'تعديل الرسالة';

  @override
  String get chatEditSave => 'حفظ';

  @override
  String get chatEdited => 'مُعدّلة';

  @override
  String get chatDeleteAction => 'حذف';

  @override
  String get chatDeleteTitle => 'حذف الرسالة؟';

  @override
  String get chatDeleteForMe => 'حذف لديّ';

  @override
  String get chatDeleteForEveryone => 'حذف لدى الجميع';

  @override
  String get chatPinTitle => 'تثبيت الرسالة؟';

  @override
  String get chatPinForBoth => 'تثبيت لدى كلينا';

  @override
  String get chatPinForMe => 'تثبيت لديّ فقط';

  @override
  String get chatReplyAction => 'رد';

  @override
  String chatReplyingTo(String name) {
    return 'رد على $name';
  }

  @override
  String get chatReplyYou => 'نفسك';

  @override
  String get chatCopyAction => 'نسخ';

  @override
  String get chatCopied => 'تم النسخ';

  @override
  String get chatForwardAction => 'إعادة توجيه';

  @override
  String get chatForwardTitle => 'إعادة توجيه إلى';

  @override
  String get shareIntoTitle => 'إرسال إلى';

  @override
  String get shareNearbyAirDrop => 'بالقرب عبر AirDrop';

  @override
  String get shareNearbyAirDropHint => 'دون إنترنت — إلى الأشخاص بجانبك';

  @override
  String get shareSent => 'تم الإرسال';

  @override
  String get shareFailed => 'تعذّر إرسال بعض المحتوى';

  @override
  String get chatForwardEmpty => 'لا توجد دردشات أخرى بعد';

  @override
  String chatForwardSendCount(int count) {
    return 'إرسال ($count)';
  }

  @override
  String chatForwardSentCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'تمت إعادة التوجيه إلى $count دردشة',
      many: 'تمت إعادة التوجيه إلى $count دردشة',
      few: 'تمت إعادة التوجيه إلى $count دردشات',
      two: 'تمت إعادة التوجيه إلى دردشتين',
      one: 'تمت إعادة التوجيه إلى دردشة واحدة',
      zero: 'لم تتم إعادة التوجيه إلى أي دردشة',
    );
    return '$_temp0';
  }

  @override
  String chatForwardSent(String name) {
    return 'تمت إعادة التوجيه إلى $name';
  }

  @override
  String chatSentAt(String time) {
    return 'أُرسلت $time';
  }

  @override
  String chatReadAt(String time) {
    return 'قُرئت $time';
  }

  @override
  String get chatPinAction => 'تثبيت';

  @override
  String get chatUnpinAction => 'إلغاء التثبيت';

  @override
  String chatPinnedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count رسالة مثبّتة',
      many: '$count رسالة مثبّتة',
      few: '$count رسائل مثبّتة',
      two: 'رسالتان مثبّتتان',
      one: 'رسالة مثبّتة واحدة',
      zero: 'لا توجد رسائل مثبّتة',
    );
    return '$_temp0';
  }

  @override
  String get chatNoPins => 'لا يوجد شيء مثبّت هنا';

  @override
  String get chatUnpinAll => 'إلغاء تثبيت كل الرسائل';

  @override
  String get chatShowAllPins => 'كل الرسائل المثبّتة';

  @override
  String get chatUnpinConfirm => 'إلغاء تثبيت هذه الرسالة؟';

  @override
  String get chatUnpinConfirmHint =>
      'سيُلغى تثبيتها لدى الجميع في هذه الدردشة.';

  @override
  String get chatPinnedTitle => 'رسالة مثبّتة';

  @override
  String get chatPinnedGone => 'لم تعد تلك الرسالة موجودة في هذه الدردشة';

  @override
  String get peerBlock => 'حظر';

  @override
  String get peerUnblock => 'إلغاء الحظر';

  @override
  String get peerMute => 'كتم';

  @override
  String get peerUnmute => 'إلغاء الكتم';

  @override
  String get peerBlockedNote => 'محظور — تُتجاهل رسائله.';

  @override
  String get relaysTitle => 'بديل عبر الإنترنت';

  @override
  String get relaysCardTitle => 'الوصول إلى الأشخاص عبر الإنترنت';

  @override
  String get relaysCardSubtitle =>
      'عندما يتعذّر التسليم عبر Bluetooth، أرسل عبر مُرحِّلات Nostr';

  @override
  String get relaysExplainer =>
      'تبقى الرسائل مشفّرة تمامًا بين الطرفين — فالمُرحِّل لا ينقل إلا الإطار المختوم نفسه الذي كان سينقله Bluetooth. لكنه يعرف أي مفتاحين يتواصلان، ومتى. متوقف افتراضيًا.';

  @override
  String get relaysMyAddress => 'عنوانك على المُرحِّلات';

  @override
  String get relaysCopied => 'تم النسخ';

  @override
  String get circleLensTitle => 'الكاميرا الأمامية للفيديو الدائري';

  @override
  String get circleLensFrontHint =>
      'تُسجَّل رسائل الفيديو الدائرية بالكاميرا المواجهة لك.';

  @override
  String get circleLensBackHint =>
      'تُسجَّل رسائل الفيديو الدائرية بالكاميرا الخلفية، لإظهار ما تنظر إليه.';

  @override
  String get channelCloseTitle => 'إغلاق هذه الغرفة للجميع';

  @override
  String get channelCloseSubtitle =>
      'يزيلها من هاتف كل عضو. أنت وحدك من يستطيع ذلك.';

  @override
  String get channelCloseConfirm =>
      'ستختفي الغرفة ورسائلها وأعضاؤها من كل هاتف توجد عليه. لن يُمنع أحد: فالمفتاح مشتق من الاسم، لذا يمكن لأي شخص يتذكره أن يفتح غرفة فارغة مجددًا.';

  @override
  String get channelCloseAction => 'إغلاق الغرفة';

  @override
  String get circleHint => 'اترك للإرسال · اسحب لليسار للإلغاء';

  @override
  String get circleHintLocked => 'اضغط إرسال عند الانتهاء';

  @override
  String get circleNeedsCamera =>
      'يحتاج الفيديو الدائري إلى الكاميرا والميكروفون';

  @override
  String get circleFailed => 'تعذّر تسجيل هذا الفيديو الدائري';

  @override
  String get relaysListLabel => 'المُرحِّلات';

  @override
  String get relaysLaneMedia => 'مُرحِّلات الوسائط';

  @override
  String get relaysLaneMediaNote =>
      'تمر الصور والملفات والفيديو عبر هذه، حتى لا يُبطئ النقل المحادثة.';

  @override
  String get relaysLaneLocation => 'مُرحِّلات الموقع';

  @override
  String get relaysLaneLocationNote =>
      'تمر إشارات الخريطة عبر هذه، بمعزل عن كل ما عداها.';

  @override
  String get relaysAdd => 'إضافة مُرحِّل';

  @override
  String get relaysAddHint => 'wss://relay.example.com';

  @override
  String get relaysInvalidUrl => 'أدخل عنوانًا يبدأ بـ wss:// أو ws://';

  @override
  String get relaysRemove => 'إزالة';

  @override
  String get relaysStateConnected => 'متصل';

  @override
  String get relaysStateConnecting => 'جارٍ الاتصال…';

  @override
  String get relaysStateFailed => 'يتعذّر الوصول';

  @override
  String get relaysStateIdle => 'متوقف';

  @override
  String get relaysEmpty => 'لا توجد مُرحِّلات مُعدّة — يبقى البديل متوقفًا.';

  @override
  String get contactTitle => 'بطاقة جهة الاتصال';

  @override
  String get contactMineLabel => 'بطاقتك';

  @override
  String get contactMineExplainer =>
      'أرسل هذه إلى شخص خارج نطاق Bluetooth. تحمل مفاتيحك وعنوانك على المُرحِّلات — وهذا يكفيه لبدء دردشة مشفّرة معك عبر الإنترنت.';

  @override
  String get contactCopy => 'نسخ';

  @override
  String get contactShare => 'مشاركة';

  @override
  String get contactCopied => 'تم نسخ البطاقة';

  @override
  String get contactShareSubject => 'بطاقة جهة اتصالي في cubechat';

  @override
  String get contactAddLabel => 'إضافة شخص';

  @override
  String get contactAddHint => 'الصق بطاقة جهة اتصال';

  @override
  String get contactAddAction => 'إضافة';

  @override
  String get contactPaste => 'لصق';

  @override
  String contactAdded(String name) {
    return 'تمت إضافة $name';
  }

  @override
  String get contactInvalid => 'هذه ليست بطاقة جهة اتصال صالحة';

  @override
  String get contactOwnCard => 'هذه بطاقتك أنت';

  @override
  String get contactUnverified =>
      'تبدأ جهة الاتصال المضافة بهذه الطريقة غير متحقَّق منها. يمكن لأي شخص إنشاء بطاقة ووضع أي اسم عليها، لذا قارن البصمات وجهًا لوجه أو عبر مكالمة قبل أن تثق بالهوية.';

  @override
  String get contactRelayOff =>
      'البديل عبر الإنترنت متوقف، لذا لا يمكن للبطاقة الوصول إلى أحد بعد.';

  @override
  String get contactRelayEnable => 'تشغيل';

  @override
  String get profileContactCard => 'بطاقة جهة الاتصال';

  @override
  String get chatsAddContactTooltip => 'إضافة جهة اتصال ببطاقة';

  @override
  String get chatsMenuTooltip => 'المزيد';

  @override
  String get chatsMenuAddContact => 'إضافة جهة اتصال';

  @override
  String get chatsMenuNewChannel => 'قناة جديدة';

  @override
  String get profileDiscoverable => 'قابل للاكتشاف بالقرب';

  @override
  String get profileDiscoverableOnHint => 'يمكن لأي شخص ضمن النطاق العثور عليك';

  @override
  String get profileDiscoverableOffHint => 'جهات اتصالك فقط يمكنها الوصول إليك';

  @override
  String get profileDiscoverableExplainer =>
      'عند التشغيل، يُبث إعلانك دون تشفير ليتمكن الغرباء من التعرّف عليك بمجرد الاقتراب — وكل من يستمع يسجّل مفتاحك واسمك. عند الإيقاف، تُرسل الحزمة نفسها مختومة إلى جهات اتصالك الحالية فقط، وتبقى معرّفات التوجيه الخاصة بك غير قابلة للربط. حينها يحتاج الأشخاص الجدد إلى بطاقة جهة اتصال.';

  @override
  String get voiceHoldHint => 'اضغط مطولًا لتسجيل رسالة صوتية';

  @override
  String get voiceTrimPlay => 'تشغيل';

  @override
  String get voiceTrimPause => 'إيقاف مؤقت';

  @override
  String get voiceTrimDiscard => 'حذف التسجيل';

  @override
  String voiceTrimSelection(String duration) {
    return 'جارٍ إرسال $duration';
  }

  @override
  String get profileLastSeen => 'مشاركة آخر ظهور';

  @override
  String get profileLastSeenOnHint =>
      'يمكن لجهات الاتصال رؤية وقت وجودك في التطبيق';

  @override
  String get profileLastSeenOffHint =>
      'لا أحد يرى وقتك، ولا ترى وقت أحد: فقط من هو متصل';

  @override
  String get profileMapLocation => 'إظهاري على الخريطة';

  @override
  String get profileMapLocationOnHint =>
      'الموقع متاح للمشاركة اليدوية ويظهر دبوسك على الخريطة';

  @override
  String get profileMapLocationOffHint =>
      'لا يطلب التطبيق الموقع ويبقى دبوسك مخفيًا';

  @override
  String get desktopAutostartTitle => 'التشغيل مع Windows';

  @override
  String get desktopAutostartHint =>
      'ينتظر CubeChat في شريط النظام، لتصل المكالمات والرسائل إلى هذا الكمبيوتر ونافذته مغلقة';

  @override
  String get trayOpen => 'فتح CubeChat';

  @override
  String get trayQuit => 'خروج';

  @override
  String get callDirectTitle => 'المكالمات المباشرة';

  @override
  String get callDirectOnHint =>
      'أسرع، لكن الشخص الذي تتصل به يعرف عنوان IP الخاص بك';

  @override
  String get callDirectOffHint =>
      'تمر المكالمات عبر مُرحِّلنا: لا يرى الشخص الذي تتصل به عنوان IP الخاص بك، ولا يمكن للمُرحِّل سماع المكالمة';

  @override
  String get profileReadReceipts => 'مشاركة إشعارات القراءة';

  @override
  String get profileReadReceiptsOnHint => 'يرى المرسلون متى قرأت رسائلهم';

  @override
  String get profileReadReceiptsOffHint =>
      'تتوقف عن إرسال وقت قراءتك، لكنك ترى وقت قراءتهم';

  @override
  String get profilePrivacyExplainer =>
      'آخر ظهور يسري في الاتجاهين: إذا أخفيت حالتك فلن ترى حالة أي أحد. إشعارات القراءة تتحكم فقط فيما ترسله. لا يتأثر تسليم الرسائل.';

  @override
  String get chatTimerAction => 'مؤقت';

  @override
  String get chatTimerRemove => 'إزالة المؤقت';

  @override
  String get chatTimerTitle => 'حذف هذه الرسالة بعد';

  @override
  String chatTimerSet(String time) {
    return 'ستُحذف هذه الرسالة بعد $time';
  }

  @override
  String get chatTimerLocalHint => 'على هذا الجهاز فقط — نسخته تخصه';

  @override
  String get contactTagAction => 'تصنيف';

  @override
  String get contactTagRemove => 'إزالة التصنيف';

  @override
  String get contactTagTitle => 'اختر تصنيفًا';

  @override
  String get contactTagAll => 'الكل';

  @override
  String get quietHoursTitle => 'ساعات الهدوء';

  @override
  String get quietHoursHint => 'تظل الرسائل تصل؛ ويبقى الهاتف صامتًا';

  @override
  String get quietHoursFrom => 'من';

  @override
  String get quietHoursTo => 'حتى';

  @override
  String get notifPreviewTitle => 'العرض في الإشعارات';

  @override
  String get notifPreviewFull => 'الاسم والنص';

  @override
  String get notifPreviewNameOnly => 'الاسم فقط';

  @override
  String get notifPreviewHidden => 'لا شيء';

  @override
  String get notifPreviewHint =>
      'تظهر الإشعارات على شاشة القفل وللتطبيقات التي لديها إذن الوصول إلى الإشعارات، حتى مع تشغيل قفل التطبيق';

  @override
  String get notifPreviewNewMessage => 'رسالة جديدة';

  @override
  String get appLockTitle => 'قفل التطبيق';

  @override
  String get appLockHint => 'طلب رمز عند فتح التطبيق';

  @override
  String get appLockPrompt => 'أدخل رمزك';

  @override
  String get appLockUnlock => 'فتح القفل';

  @override
  String get appLockWrong => 'رمز خاطئ';

  @override
  String get appLockSetTitle => 'تعيين رمز';

  @override
  String get appLockSetHint => 'أربعة أرقام أو أكثر. لا توجد طريقة لاستعادته.';

  @override
  String get appLockOffTitle => 'إيقاف القفل';

  @override
  String get appLockOffHint => 'أدخل رمزك الحالي';

  @override
  String get appLockOn => 'قفل التطبيق مُفعّل';

  @override
  String get appLockOff => 'قفل التطبيق متوقف';

  @override
  String get avatarSet => 'اختيار صورة';

  @override
  String get avatarChange => 'تغيير الصورة';

  @override
  String get avatarView => 'عرض الصورة';

  @override
  String get profileCoverPhoto => 'صورة الملف الشخصي، انقر مرتين للتكبير';

  @override
  String get profileCoverMenu => 'خيارات الصورة';

  @override
  String get avatarSaved => 'تم الحفظ في المعرض';

  @override
  String get avatarRemove => 'إزالة الصورة';

  @override
  String get avatarRemoveConfirm =>
      'ستُحذف الصورة الرمزية من هذا الجهاز. وسيعود التدرج اللوني المُولَّد مكانها.';

  @override
  String get avatarFailed => 'تعذّرت قراءة هذه الصورة';

  @override
  String get fileOpenHint => 'اضغط للفتح';

  @override
  String get fileMissing => 'لم يعد هذا الملف متاحًا';

  @override
  String get fileNoHandlerTitle => 'لا يوجد تطبيق لفتح هذا';

  @override
  String get fileNoHandlerHint =>
      'لا يوجد تطبيق مثبّت يتعامل مع هذا النوع من الملفات. يمكنك إرساله إلى تطبيق آخر بدلًا من ذلك.';

  @override
  String get fileRequestedAgain => 'طُلب الملف من المرسل مجددًا';

  @override
  String get fileOpenFailed => 'تعذّر فتح هذا الملف';

  @override
  String get fileShareAction => 'إرسال إلى تطبيق';

  @override
  String fileTooLargeMesh(int limit) {
    return 'الملف كبير جدًا — الحد الأقصى عبر Mesh هو $limit ميغابايت';
  }

  @override
  String fileTooLargeRelay(int limit) {
    return 'الحد الأقصى عبر الإنترنت هو $limit ميغابايت. اقترب من المستلم لإرسال ملف أكبر.';
  }

  @override
  String get mediaSendOriginal => 'الأصلي';

  @override
  String get attachFile => 'ملف';

  @override
  String get attachGallery => 'المعرض';

  @override
  String get attachCamera => 'الكاميرا';

  @override
  String get cameraUnavailable => 'الكاميرا غير متاحة';

  @override
  String get profileEditName => 'الاسم';

  @override
  String get profileMyCard => 'البطاقة';

  @override
  String get mediaCaptionHint => 'أضف تعليقًا…';

  @override
  String get mediaDiscardTitle => 'تجاهل التحديد؟';

  @override
  String get mediaDiscardMessage => 'إغلاق المعرض وتجاهل الصور المحددة؟';

  @override
  String get mediaDiscardConfirm => 'تجاهل';

  @override
  String get mediaPhotosAccessOff => 'الوصول إلى الصور متوقف';

  @override
  String get mediaPhotosAccessOffHint =>
      'يرى CubeChat حاليًا مقاطع الفيديو فقط. اسمح بالوصول إلى الصور في إعدادات النظام لعرض صورك.';

  @override
  String get mediaVideosOnly => 'الفيديوهات فقط ظاهرة — اسمح بالوصول إلى الصور';

  @override
  String get mediaOpenSettings => 'فتح الإعدادات';

  @override
  String get mediaTakePhoto => 'التقاط صورة';

  @override
  String get contactProfileAutoDelete => 'الحذف التلقائي للدردشة';

  @override
  String get contactProfileAutoDeleteTitle => 'الحذف التلقائي للرسائل';

  @override
  String get contactProfileAutoDeleteOff => 'متوقف';

  @override
  String get contactProfileAutoDeleteOneDay => 'بعد يوم واحد';

  @override
  String get contactProfileAutoDeleteSevenDays => 'بعد 7 أيام';

  @override
  String get contactProfileAutoDeleteThirtyDays => 'بعد 30 يومًا';

  @override
  String contactProfileAutoDeleteUpdated(String period) {
    return 'الحذف التلقائي: $period';
  }

  @override
  String get contactProfileShare => 'مشاركة جهة الاتصال';

  @override
  String get contactProfileShareTitle => 'إرسال جهة الاتصال إلى';

  @override
  String get contactProfileShareEmpty => 'لا توجد دردشات أخرى بعد';

  @override
  String contactProfileShareSent(String name) {
    return 'أُرسلت إلى $name';
  }

  @override
  String get contactProfileRestrictCopying => 'منع النسخ';

  @override
  String get contactProfileAllowCopying => 'السماح بالنسخ';

  @override
  String get contactHideAvatar => 'إخفاء صورتي';

  @override
  String get contactShowAvatar => 'إظهار صورتي';

  @override
  String get contactHideLastSeen => 'إخفاء آخر ظهور لي';

  @override
  String get contactShowLastSeen => 'إظهار آخر ظهور لي';

  @override
  String get contactHideReadReceipts => 'إخفاء أوقات قراءتي';

  @override
  String get contactShowReadReceipts => 'إظهار أوقات قراءتي';

  @override
  String get contactHiddenFromThem => 'مخفي عن جهة الاتصال هذه';

  @override
  String get contactRefuseCalls => 'عدم قبول مكالماته';

  @override
  String get contactAllowCalls => 'قبول مكالماته';

  @override
  String get contactCallsException => 'استثناء من إعداد المكالمات لديك';

  @override
  String get contactProfileCopyingRestricted => 'النسخ وإعادة التوجيه ممنوعان';

  @override
  String get contactProfileCopyingRestrictedByPeer => 'ممنوع من الطرف الآخر';

  @override
  String get contactProfileCopyingAllowed => 'النسخ وإعادة التوجيه مسموحان';

  @override
  String get contactProfileDelete => 'حذف من جهات الاتصال';

  @override
  String get contactProfileRestore => 'إعادة إلى جهات الاتصال';

  @override
  String get contactProfileRestoreDone => 'عاد إلى جهات اتصالك';

  @override
  String get contactProfileDeleteTitle => 'إزالة جهة الاتصال؟';

  @override
  String contactProfileDeleteMessage(String name) {
    return 'سيختفي $name من جهات الاتصال. يبقى سجل الدردشة على هذا الجهاز.';
  }

  @override
  String get contactProfileMedia => 'الوسائط';

  @override
  String get contactProfileVoiceMessages => 'الرسائل الصوتية';

  @override
  String get contactProfileStickers => 'الملصقات';

  @override
  String get contactProfileNoStickers => 'لا توجد ملصقات بعد';

  @override
  String get contactProfileNoMedia => 'لا توجد وسائط بعد';

  @override
  String get contactProfileNoVoiceMessages => 'لا توجد رسائل صوتية بعد';

  @override
  String get contactProfileOpen => 'فتح الملف الشخصي';

  @override
  String autoDeleteDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count يوم',
      many: '$count يومًا',
      few: '$count أيام',
      two: 'يومان',
      one: 'يوم واحد',
      zero: '$count يوم',
    );
    return '$_temp0';
  }

  @override
  String autoDeleteHours(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ساعة',
      many: '$count ساعة',
      few: '$count ساعات',
      two: 'ساعتان',
      one: 'ساعة واحدة',
      zero: '$count ساعة',
    );
    return '$_temp0';
  }

  @override
  String autoDeleteMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count دقيقة',
      many: '$count دقيقة',
      few: '$count دقائق',
      two: 'دقيقتان',
      one: 'دقيقة واحدة',
      zero: '$count دقيقة',
    );
    return '$_temp0';
  }

  @override
  String autoDeleteSeconds(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ثانية',
      many: '$count ثانية',
      few: '$count ثوانٍ',
      two: 'ثانيتان',
      one: 'ثانية واحدة',
      zero: '$count ثانية',
    );
    return '$_temp0';
  }

  @override
  String get autoDeleteCustom => 'مخصص…';

  @override
  String get autoDeleteCustomHint => 'المقدار';

  @override
  String get autoDeleteUnitMinutes => 'دقيقة';

  @override
  String get autoDeleteUnitHours => 'ساعات';

  @override
  String get autoDeleteUnitDays => 'أيام';

  @override
  String get contactProfileAutoDeleteSet => 'تعيين';

  @override
  String get contactProfileFiles => 'الملفات';

  @override
  String get contactProfileNoFiles => 'لا توجد ملفات بعد';

  @override
  String get contactProfileLinks => 'الروابط';

  @override
  String get contactProfileNoLinks => 'لا توجد روابط بعد';

  @override
  String get contactProfilePolls => 'الاستطلاعات';

  @override
  String get contactProfileNoPolls => 'لا توجد استطلاعات بعد';

  @override
  String get presenceRecently => 'آخر ظهور مؤخرًا';

  @override
  String get presenceJustNow => 'للتو';

  @override
  String presenceHoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'آخر ظهور منذ $count ساعة',
      many: 'آخر ظهور منذ $count ساعة',
      few: 'آخر ظهور منذ $count ساعات',
      two: 'آخر ظهور منذ ساعتين',
      one: 'آخر ظهور منذ ساعة',
      zero: 'آخر ظهور منذ $count ساعة',
    );
    return '$_temp0';
  }

  @override
  String presenceYesterdayAt(String time) {
    return 'آخر ظهور أمس عند $time';
  }

  @override
  String presenceOnWeekday(String day) {
    String _temp0 = intl.Intl.selectLogic(
      day,
      {
        '1': 'آخر ظهور يوم الاثنين',
        '2': 'آخر ظهور يوم الثلاثاء',
        '3': 'آخر ظهور يوم الأربعاء',
        '4': 'آخر ظهور يوم الخميس',
        '5': 'آخر ظهور يوم الجمعة',
        '6': 'آخر ظهور يوم السبت',
        '7': 'آخر ظهور يوم الأحد',
        'other': 'آخر ظهور هذا الأسبوع',
      },
    );
    return '$_temp0';
  }

  @override
  String presenceWeeksAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'آخر ظهور منذ $count أسبوع',
      many: 'آخر ظهور منذ $count أسبوعًا',
      few: 'آخر ظهور منذ $count أسابيع',
      two: 'آخر ظهور منذ أسبوعين',
      one: 'آخر ظهور منذ أسبوع',
      zero: 'آخر ظهور منذ $count أسبوع',
    );
    return '$_temp0';
  }

  @override
  String presenceMonthsAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'آخر ظهور منذ $count شهر',
      many: 'آخر ظهور منذ $count شهرًا',
      few: 'آخر ظهور منذ $count أشهر',
      two: 'آخر ظهور منذ شهرين',
      one: 'آخر ظهور منذ شهر',
      zero: 'آخر ظهور منذ $count شهر',
    );
    return '$_temp0';
  }

  @override
  String get presenceLongAgo => 'آخر ظهور منذ مدة طويلة';

  @override
  String presenceMinutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'آخر ظهور منذ $count دقيقة',
      many: 'آخر ظهور منذ $count دقيقة',
      few: 'آخر ظهور منذ $count دقائق',
      two: 'آخر ظهور منذ دقيقتين',
      one: 'آخر ظهور منذ دقيقة',
      zero: 'آخر ظهور منذ $count دقيقة',
    );
    return '$_temp0';
  }

  @override
  String chatReadByCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'قرأها $count شخص',
      many: 'قرأها $count شخصًا',
      few: 'قرأها $count أشخاص',
      two: 'قرأها شخصان',
      one: 'قرأها شخص واحد',
      zero: 'لم يقرأها أحد',
    );
    return '$_temp0';
  }

  @override
  String get chatsSearchFrequent => 'من تتحدث معهم';

  @override
  String get chatsSearchRecent => 'الأخيرة';

  @override
  String get chatsSearchClear => 'مسح';

  @override
  String get chatsSearchStartHint =>
      'ابحث عن الدردشات بالاسم، أو عن أي رسالة بكلماتها.';

  @override
  String get chatsSearchEmpty => 'لا توجد نتائج مطابقة';

  @override
  String get chatRoutesTitle => 'كيف تصل إليه';

  @override
  String get chatRoutesBluetoothHint => 'مباشرة إلى هاتفه، دون إنترنت';

  @override
  String get chatRoutesMeshHint => 'تمررها الهواتف الموجودة بينكما';

  @override
  String get chatRoutesInternetHint =>
      'عبر مُرحِّل، عندما لا يكون أحد ضمن النطاق';

  @override
  String get chatRoutesHint =>
      'يُختار الطريق لكل رسالة على حدة، مما هو متاح في تلك اللحظة.';

  @override
  String get chatRoutesPreferTitle => 'ما يُجرَّب أولًا';

  @override
  String get chatRoutesPreferMesh => 'Bluetooth أولًا';

  @override
  String get chatRoutesPreferMeshHint =>
      'أسرع في المكان نفسه، لا يستهلك بيانات، ولا يُخبر أي مُرحِّل بشيء';

  @override
  String get chatRoutesPreferRelay => 'الإنترنت أولًا';

  @override
  String get chatRoutesPreferRelayHint =>
      'لاتصال Bluetooth ضعيف واتصال إنترنت جيد';

  @override
  String get chatRoutesPreferNote =>
      'هذا تفضيل وليس قيدًا. إذا تعذّر الوصول عبر الطريق الذي اخترته، فسيحمل الطريق الآخر الرسالة.';

  @override
  String get deadmanTitle => 'المسح عند عدم الاستخدام';

  @override
  String get deadmanOff => 'متوقف';

  @override
  String deadmanDays(int days) {
    return 'بعد $days يوم';
  }

  @override
  String get deadmanHint =>
      'إذا لم يفتح أحد هذا التطبيق طوال تلك المدة، فسيُمسح كل ما عليه عند فتحه في المرة التالية. لا يمكنه تحذيرك مسبقًا — وهذا هو الغرض منه.';

  @override
  String chatForwardedFrom(String name) {
    return 'مُعاد توجيهها من $name';
  }

  @override
  String appLockWait(String left) {
    return 'محاولات كثيرة جدًا — انتظر $left';
  }

  @override
  String get appLockGraceTitle => 'طلب الرمز';

  @override
  String get appLockGraceNow => 'في كل مرة';

  @override
  String appLockGraceAfter(String left) {
    return 'بعد غياب $left';
  }

  @override
  String get chatCalendarTitle => 'حسب التاريخ';

  @override
  String get chatCalendarEmpty => 'لم يُقل شيء هنا بعد';

  @override
  String get chatsSearchChatsSection => 'الدردشات';

  @override
  String get chatsSearchMessagesSection => 'الرسائل';

  @override
  String get contactProfileViewInChat => 'عرض في الدردشة';

  @override
  String get chatDraft => 'مسودة';

  @override
  String get chatSearchTitle => 'بحث';

  @override
  String get chatSearchHint => 'البحث في الرسائل';

  @override
  String get chatSearchNoResults => 'لا توجد نتائج';

  @override
  String get chatSearchPrevious => 'النتيجة السابقة';

  @override
  String get chatSearchNext => 'النتيجة التالية';

  @override
  String chatMessageCount(int count) {
    return 'الرسائل: $count';
  }

  @override
  String get chatRouteBluetooth => 'Bluetooth';

  @override
  String get chatRouteMesh => 'Mesh';

  @override
  String get chatRouteInternet => 'الإنترنت';

  @override
  String get chatRouteQueued => 'في الانتظار';

  @override
  String get attachStickers => 'الملصقات';

  @override
  String get stickersEmpty => 'لا توجد ملصقات بعد';

  @override
  String get stickersEmptyHint => 'احفظ صورة من دردشة وستظهر هنا.';

  @override
  String get stickerKeep => 'حفظ كملصق';

  @override
  String get stickerKept => 'تم الحفظ في ملصقاتك';

  @override
  String get stickerForget => 'إزالة الملصق';

  @override
  String get stickerCreate => 'إنشاء ملصق من صورة';

  @override
  String get stickerFailed => 'تعذّر تحويل هذه الصورة إلى ملصق';

  @override
  String get stickerLabel => 'ملصق';

  @override
  String get previewPhoto => 'صورة';

  @override
  String get previewVoice => 'رسالة صوتية';

  @override
  String get previewFile => 'ملف';

  @override
  String get stickerEmojiTitle => 'اختر رمزًا تعبيريًا له';

  @override
  String get stickersMine => 'ملصقاتي';

  @override
  String get stickersStarterPack => 'كوبي';

  @override
  String get emojiTab => 'الرموز التعبيرية';

  @override
  String get chatBlockedStatus => 'محظور';

  @override
  String get chatBlockedHint => 'لقد حظرت هذا الشخص';

  @override
  String get chatRouteFallbackOff => 'الإنترنت متوقف';

  @override
  String get chatAttachmentUnavailable =>
      'لا يوجد اتصال متاح. اتصل عبر Bluetooth أو الإنترنت ثم حاول مجددًا.';

  @override
  String get fileTransfersTitle => 'نقل الملفات';

  @override
  String get fileTransfersClear => 'مسح السجل';

  @override
  String get fileTransfersEmpty => 'لا توجد عمليات نقل ملفات بعد';

  @override
  String get fileTransfersActive => 'النشطة';

  @override
  String get fileTransfersHistory => 'السجل';

  @override
  String get fileTransferPause => 'إيقاف مؤقت';

  @override
  String get fileTransferResume => 'استئناف';

  @override
  String get fileTransferRetry => 'إعادة المحاولة';

  @override
  String get fileTransferQueued => 'في انتظار الاتصال';

  @override
  String get fileTransferRunning => 'جارٍ النقل';

  @override
  String get fileTransferPaused => 'متوقف مؤقتًا';

  @override
  String get fileTransferCompleted => 'مكتمل';

  @override
  String get fileTransferFailed => 'فشل';

  @override
  String get fileTransferCanceled => 'أُلغي';

  @override
  String get profileFileTransfers => 'نقل الملفات';

  @override
  String get profileFileTransfersSubtitle =>
      'التقدّم وقائمة الانتظار وسجل النقل';

  @override
  String get qrScanAction => 'مسح رمز QR';

  @override
  String get qrScanTitle => 'مسح رمز QR';

  @override
  String get qrScanHint =>
      'امسح رمز جهة اتصال أو قناة أو نقل حساب أو تسجيل دخول كمبيوتر في CubeChat.';

  @override
  String get qrFlash => 'الكشاف';

  @override
  String get qrCameraError =>
      'الكاميرا غير متاحة. تحقّق من إذن الكاميرا وحاول مجددًا.';

  @override
  String get qrInvalid => 'هذا ليس رمز QR صالحًا لـ Cubechat.';

  @override
  String qrChannelAdded(String name) {
    return 'تمت إضافة $name';
  }

  @override
  String get qrShow => 'إظهار رمز QR';

  @override
  String qrChannelTitle(String name) {
    return 'الانضمام إلى $name';
  }

  @override
  String get profileBackup => 'نسخة احتياطية مشفّرة';

  @override
  String get profileBackupSubtitle =>
      'انقل المفاتيح وجهات الاتصال والسجل بأمان';

  @override
  String get backupTitle => 'نسخة احتياطية مشفّرة';

  @override
  String get backupExplainer =>
      'تحتوي النسخة الاحتياطية على مفاتيح هويتك الخاصة وجهات الاتصال والقنوات والإعدادات وسجل الرسائل. تُشفَّر على هذا الهاتف بكلمة المرور التي تختارها؛ ولا يستطيع Cubechat استعادة كلمة مرور منسية.';

  @override
  String get backupCreate => 'إنشاء نسخة احتياطية';

  @override
  String get backupCreateSubtitle => 'شفّر كل شيء واحفظ ملف .cchatbackup';

  @override
  String get backupRestore => 'استعادة نسخة احتياطية';

  @override
  String get backupRestoreSubtitle =>
      'استبدل ملف Cubechat الشخصي على هذا الهاتف من ملف نسخة احتياطية';

  @override
  String get backupPasswordTitle => 'كلمة مرور النسخة الاحتياطية';

  @override
  String get backupPasswordHint => '8 أحرف على الأقل';

  @override
  String get backupConfirmPassword => 'كرّر كلمة المرور';

  @override
  String get backupPasswordMismatch => 'كلمتا المرور غير متطابقتين';

  @override
  String get backupPasswordShort => 'استخدم 8 أحرف على الأقل';

  @override
  String get backupSaveTitle => 'حفظ نسخة Cubechat الاحتياطية';

  @override
  String get backupSaved => 'تم حفظ النسخة الاحتياطية المشفّرة';

  @override
  String get backupWhereTitle => 'أين تريد حفظ النسخة الاحتياطية؟';

  @override
  String get backupSaveToFiles => 'حفظ في الملفات';

  @override
  String get backupSaveToFilesHint =>
      'مجلد على هذا الهاتف أو بطاقة ذاكرة أو تخزين سحابي';

  @override
  String get backupSendToApp => 'إرسال إلى تطبيق';

  @override
  String get backupSendToAppHint =>
      'Telegram أو البريد أو تطبيق مراسلة — أي تطبيق يقبل الملفات';

  @override
  String get backupFailed => 'تعذّر إكمال عملية النسخ الاحتياطي';

  @override
  String get backupRestoreConfirmTitle => 'استبدال هذا الملف الشخصي؟';

  @override
  String get backupRestoreConfirmMessage =>
      'ستُستبدل المفاتيح وجهات الاتصال والقنوات والإعدادات والسجل الحالية على هذا الهاتف بالنسخة الاحتياطية المحددة.';

  @override
  String get backupRestoreConfirmAction => 'استعادة';

  @override
  String get backupRestored => 'تمت استعادة النسخة الاحتياطية';

  @override
  String get backupPackingWait => 'جارٍ إنشاء النسخة الاحتياطية…';

  @override
  String get backupUnpackingWait => 'جارٍ استعادة النسخة الاحتياطية…';

  @override
  String get backupWaitHint =>
      'مع الصور والفيديوهات قد يستغرق هذا بضع دقائق. أبقِ التطبيق مفتوحًا.';

  @override
  String get backupInvalid =>
      'كلمة مرور خاطئة، أو ملف تالف، أو نسخة احتياطية غير مدعومة';

  @override
  String get channelInfoTitle => 'تفاصيل القناة';

  @override
  String get channelParticipantsTitle => 'المشاركون';

  @override
  String get channelAdministratorsTitle => 'المشرفون';

  @override
  String get channelMakeAdmin => 'تعيين مشرفًا';

  @override
  String get channelRemoveAdmin => 'إزالة الإشراف';

  @override
  String get channelNoParticipants => 'سيظهر المشاركون بعد نشاط موقَّع';

  @override
  String get channelSharedContent => 'الوسائط والملفات والاستطلاعات';

  @override
  String get channelDescriptionTitle => 'الوصف';

  @override
  String get channelDescriptionEmpty => 'لا يوجد وصف بعد';

  @override
  String get channelDescriptionHint => 'الغرض من هذه القناة';

  @override
  String get channelDescriptionAdminOnly => 'المشرف فقط يمكنه تغيير الوصف';

  @override
  String get channelDescriptionSave => 'حفظ';

  @override
  String get channelPrivateSubtitle => 'قناة خاصة';

  @override
  String get channelAvatarSet => 'تعيين صورة جديدة';

  @override
  String get channelSettingsTitle => 'إعدادات القناة';

  @override
  String get channelSettingsHint => 'من يمكنه النشر، النسخ، الرسائل السابقة';

  @override
  String get channelLeaveAction => 'مغادرة';

  @override
  String get channelLeaveConfirm =>
      'ستختفي الغرفة وكل ما قيل فيها من هذا الهاتف. المفتاح مشتق من الاسم، لذا يمكنك فتحها مجددًا بكتابة الاسم نفسه.';

  @override
  String get channelShareAction => 'مشاركة';

  @override
  String channelMembersOf(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count عضو',
      many: '$count عضوًا',
      few: '$count أعضاء',
      two: 'عضوان',
      one: 'عضو واحد',
      zero: 'لا أعضاء',
    );
    return '$_temp0';
  }

  @override
  String get chatTyping => 'يكتب…';

  @override
  String get chatRecordingVoice => 'يسجّل رسالة صوتية…';

  @override
  String get chatRecordingCircle => 'يسجّل رسالة فيديو…';

  @override
  String get chatSendingPhoto => 'يرسل صورة…';

  @override
  String get chatSendingVideo => 'يرسل فيديو…';

  @override
  String get chatSendingFile => 'يرسل ملفًا…';

  @override
  String get onboardingMeshTitle => 'يعمل دون إنترنت';

  @override
  String get onboardingMeshBody =>
      'تنتقل الرسائل عبر Bluetooth من هاتف إلى هاتف. لا إشارة، لا Wi-Fi، لا حسابات — فقط الأشخاص من حولك.';

  @override
  String get onboardingRelayTitle => 'ومعه، عندما يتوفر';

  @override
  String get onboardingRelayBody =>
      'خارج نطاق Bluetooth، تسلك الرسائل طريق الإنترنت بدلًا من ذلك وتصل بالطريقة نفسها. لن تضطر أبدًا إلى الاختيار.';

  @override
  String get onboardingPrivacyTitle => 'لا أحد في المنتصف يستطيع قراءتها';

  @override
  String get onboardingPrivacyBody =>
      'كل شيء مشفّر تمامًا بين الطرفين، وهويتك مفتاح على هذا الهاتف — لا رقم هاتف، ولا بريد إلكتروني، ولا حساب يمكن لأحد أن يسلبه منك.';

  @override
  String get onboardingSkip => 'تخطٍّ';

  @override
  String get onboardingNext => 'التالي';

  @override
  String get onboardingStart => 'ابدأ';

  @override
  String get chatMediaShare => 'مشاركة';

  @override
  String get chatMediaSaveToGallery => 'حفظ في المعرض';

  @override
  String get chatMediaShowInChat => 'عرض في الدردشة';

  @override
  String get chatWallpaperTitle => 'الخلفية';

  @override
  String get chatWallpaperClear => 'إعادة تعيين';

  @override
  String get chatWallpaperDim => 'تعتيم ما خلف الرسائل';

  @override
  String get chatSelectAction => 'تحديد';

  @override
  String get chatForwardNothing => 'لا شيء هنا يمكن إعادة توجيهه';

  @override
  String chatSelectedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'تم تحديد $count',
      many: 'تم تحديد $count',
      few: 'تم تحديد $count',
      two: 'تم تحديد اثنتين',
      one: 'تم تحديد واحدة',
      zero: 'لم يُحدَّد شيء',
    );
    return '$_temp0';
  }

  @override
  String chatDeleteSelectedTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'حذف $count رسالة؟',
      many: 'حذف $count رسالة؟',
      few: 'حذف $count رسائل؟',
      two: 'حذف رسالتين؟',
      one: 'حذف هذه الرسالة؟',
      zero: 'حذف $count رسالة؟',
    );
    return '$_temp0';
  }

  @override
  String get contactAliasAction => 'إعادة تسمية جهة الاتصال';

  @override
  String get contactAliasHint =>
      'أنت وحدك ترى هذا الاسم. اتركه فارغًا لاستخدام اسمه.';

  @override
  String get viewOnceSendLabel => 'عرض مرة واحدة';

  @override
  String get viewOnceTitle => 'عرض مرة واحدة';

  @override
  String get viewOnceTapToView => 'صورة · اضغط لعرضها مرة واحدة';

  @override
  String get viewOnceSent => 'صورة · أُرسلت';

  @override
  String get viewOnceOpened => 'تم فتح الصورة';

  @override
  String get viewOnceUnavailable => 'لم تعد هذه الصورة متاحة';

  @override
  String get viewOnceWarning => 'إغلاق هذه الصورة يحذفها لدى كليكما.';

  @override
  String get channelAvatarAdminOnly => 'المشرف فقط يمكنه تغيير صورة القناة';

  @override
  String get channelAdminOnly => 'المشرف فقط يمكنه تغيير هذا';

  @override
  String get channelAvatarTooLarge => 'هذه الصورة كبيرة جدًا للبث';

  @override
  String get channelMemberUnknown => 'ليس في جهات اتصالك بعد';

  @override
  String get channelInviteToContacts => 'أرسل إليه بطاقة جهة اتصالك';

  @override
  String channelContactInviteSent(String name) {
    return 'عُرضت بطاقة جهة الاتصال على $name';
  }

  @override
  String get chatContactInvitation => 'دعوة للتواصل';

  @override
  String get chatContactInvitationForYou => 'دعوة لك';

  @override
  String get channelPollTitle => 'استطلاع';

  @override
  String get channelCreatePoll => 'إنشاء استطلاع';

  @override
  String get channelPollQuestion => 'السؤال';

  @override
  String channelPollOption(int number) {
    return 'الخيار $number';
  }

  @override
  String get channelPollAddOption => 'إضافة خيار';

  @override
  String get channelPollCreate => 'نشر الاستطلاع';

  @override
  String channelPollVotes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count صوت',
      many: '$count صوتًا',
      few: '$count أصوات',
      two: 'صوتان',
      one: 'صوت واحد',
      zero: 'لا أصوات',
    );
    return '$_temp0';
  }

  @override
  String get phoneTransferTitle => 'النقل إلى هاتف جديد';

  @override
  String get desktopPickChat => 'اختر من تريد مراسلته';

  @override
  String get desktopListCollapse => 'إظهار الصور فقط';

  @override
  String get desktopListExpand => 'إظهار قائمة الدردشات';

  @override
  String get desktopLinkConnectTitle => 'ربط كمبيوتر';

  @override
  String get desktopLinkConnectHint =>
      'امسح الرمز الذي يعرضه CubeChat على الكمبيوتر';

  @override
  String get desktopLinkSignIn => 'تسجيل الدخول بحساب هاتفي';

  @override
  String get desktopLinkTitle => 'تسجيل الدخول بهاتفك';

  @override
  String get desktopLinkSteps =>
      'على الهاتف: الملف الشخصي ← البيانات ← ربط كمبيوتر، ثم امسح هذا الرمز. يجب أن يكون الجهازان على شبكة Wi-Fi نفسها.';

  @override
  String get desktopLinkLimits =>
      'يواصل الهاتف العمل. تصل الرسائل من الإنترنت إلى كليهما؛ لكن ما ترسله من أحدهما لا يظهر على الآخر بعد.';

  @override
  String get desktopLinkWaiting => 'في انتظار الهاتف…';

  @override
  String get desktopLinkFailed => 'تعذّر استلام الحساب. حاول مجددًا.';

  @override
  String get desktopLinkRetry => 'حاول مجددًا';

  @override
  String get desktopLinkConfirmTitle =>
      'إرسال نسخة من هذا الحساب إلى الكمبيوتر؟';

  @override
  String get desktopLinkConfirmMessage =>
      'سيحصل الكمبيوتر على مفاتيحك وجهات اتصالك ودردشاتك. ويواصل هذا الهاتف العمل كما هو.';

  @override
  String get desktopLinkConfirmAction => 'إرسال';

  @override
  String desktopLinkConfirmWhere(String address) {
    return 'فقط إذا مسحت هذا الرمز للتو من شاشة كمبيوترك أنت. سيُرسل إلى $address على هذه الشبكة.';
  }

  @override
  String get desktopLinkSending => 'جارٍ إرسال الحساب…';

  @override
  String get desktopLinkSent => 'تم ربط الكمبيوتر';

  @override
  String get desktopLinkPhoneFound =>
      'عثر الهاتف على هذا الكمبيوتر ويُنشئ نسخة من الحساب. مع الصور قد يستغرق هذا بضع دقائق.';

  @override
  String desktopLinkReceiving(int percent) {
    return 'جارٍ استلام الحساب: $percent%';
  }

  @override
  String get desktopLinkRestoring => 'جارٍ إعداد الحساب على هذا الكمبيوتر…';

  @override
  String get desktopLinkFinding => 'جارٍ البحث عن الكمبيوتر…';

  @override
  String get desktopLinkPreparing =>
      'جارٍ إنشاء نسخة من الحساب. مع الصور قد يستغرق هذا بضع دقائق.';

  @override
  String desktopLinkSendingPercent(int percent) {
    return 'جارٍ الإرسال: $percent%';
  }

  @override
  String get desktopLinkComputerRestoring => 'يُعدّ الكمبيوتر الحساب…';

  @override
  String get devicesTitle => 'الأجهزة';

  @override
  String get devicesRowHint => 'أين حسابك مفتوح، وتسجيل الخروج منه هناك';

  @override
  String get devicesThisDevice => 'هذا الجهاز';

  @override
  String get devicesSeenNow => 'متصل للتو';

  @override
  String devicesSeenMinutes(int n) {
    return 'متصل منذ $n د';
  }

  @override
  String devicesSeenHours(int n) {
    return 'متصل منذ $n س';
  }

  @override
  String devicesSeenDays(int n) {
    return 'متصل منذ $n ي';
  }

  @override
  String get devicesLeaving => 'جارٍ تسجيل الخروج — في انتظار اتصاله';

  @override
  String get devicesSignOut => 'تسجيل الخروج';

  @override
  String get devicesSignOutAll => 'تسجيل الخروج من كل الأجهزة الأخرى';

  @override
  String devicesSignOutTitle(String name) {
    return 'تسجيل الخروج من «$name»؟';
  }

  @override
  String get devicesSignOutMessage =>
      'ستُمسح مفاتيح CubeChat ودردشاته وإعداداته على ذلك الجهاز فور اتصاله. يبقى الحساب هنا وعلى أجهزتك الأخرى.';

  @override
  String get devicesSignOutPhoneMessage =>
      'هذا هاتف: سيُمسح CubeChat منه بالكامل. يبقى الحساب هنا وعلى أجهزتك الأخرى.';

  @override
  String get devicesSignOutAllMessage =>
      'سيُسجَّل خروج كل جهاز آخر فور اتصاله. وسيبقى الحساب هنا فقط.';

  @override
  String get devicesRename => 'إعادة تسمية';

  @override
  String get devicesRenameTitle => 'اسم هذا الجهاز';

  @override
  String get devicesSave => 'حفظ';

  @override
  String get devicesEmpty =>
      'لا توجد أجهزة أخرى بعد. يظهر الجهاز هنا بعد أن يفتح CubeChat 1.0.0+1147 أو أحدث.';

  @override
  String get devicesCaveat =>
      'يسري تسجيل الخروج عندما يتصل ذلك الجهاز بالإنترنت. الجهاز الذي يبقى غير متصل يحتفظ بمفاتيحه؛ والحماية الكاملة تعني مفاتيح جديدة للحساب.';

  @override
  String get desktopLinkImportTitle => 'نقل الحساب من هاتفك';

  @override
  String get desktopLinkImportHint =>
      'اعرض رمزًا على الهاتف، ليصبح هذا الكمبيوتر نسخة من حسابه';

  @override
  String get desktopLinkImportConfirmTitle =>
      'استبدال الحساب على هذا الكمبيوتر؟';

  @override
  String get desktopLinkImportConfirmMessage =>
      'ستُستبدل مفاتيح هذا الكمبيوتر وجهات اتصاله ودردشاته بحساب الهاتف. إذا كنت لا تزال تحتاج هذا الحساب، فأنشئ نسخة احتياطية أولًا.';

  @override
  String get desktopLinkImportConfirmAction => 'متابعة';

  @override
  String get desktopLinkUnreachable =>
      'تعذّر الوصول إلى الكمبيوتر. يجب أن يكون الجهازان على شبكة Wi-Fi نفسها، ويجب السماح لـ CubeChat عبر جدار الحماية على الكمبيوتر.';

  @override
  String get desktopLinkFirewallHint =>
      'قد يمنع Windows الهاتف من الوصول إلى هذا الكمبيوتر. اسمح لـ CubeChat عبر جدار الحماية — لشبكتك المحلية فقط.';

  @override
  String get desktopLinkFirewallAllow => 'السماح عبر جدار الحماية';

  @override
  String get desktopLinkFirewallDeclined =>
      'لم يسمح Windows بذلك. بدونه قد لا يتمكن الهاتف من الوصول.';

  @override
  String get phoneTransferIntro =>
      'انقل ملفك الشخصي ومفاتيحك وجهات اتصالك وقنواتك وإعداداتك وسجلك مباشرة بين هاتفين.';

  @override
  String get phoneTransferSend => 'هذا هو الهاتف القديم';

  @override
  String get phoneTransferReceive => 'هذا هو الهاتف الجديد';

  @override
  String get phoneTransferSameWifi =>
      'اربط الهاتفين بشبكة Wi-Fi نفسها. أبقِ هذه الشاشة مفتوحة حتى ينتهي النقل.';

  @override
  String get phoneTransferPreparing => 'جارٍ تجهيز النقل المشفّر…';

  @override
  String get phoneTransferReady =>
      'امسح رمز QR هذا الصالح لمرة واحدة على الهاتف الجديد';

  @override
  String get phoneTransferScan => 'مسح الهاتف القديم';

  @override
  String get phoneTransferConfirmTitle =>
      'استبدال الملف الشخصي على هذا الهاتف؟';

  @override
  String get phoneTransferConfirmMessage =>
      'سيُستبدل الملف الشخصي المخزّن حاليًا على هذا الهاتف بالنقل المحلي المشفّر.';

  @override
  String get phoneTransferConfirmAction => 'نقل الملف الشخصي';

  @override
  String get phoneTransferSuccess => 'تم نقل الملف الشخصي بنجاح';

  @override
  String get phoneTransferFailed => 'تعذّر إكمال النقل بين الهاتفين';

  @override
  String get profileSummaryMeshOnly => 'Mesh فقط';

  @override
  String get profileSummaryMeshInternet => 'Mesh · الإنترنت';

  @override
  String get profileSummaryBackgroundOn => 'يعمل في الخلفية';

  @override
  String profileSummaryTransfersActive(int count) {
    return 'قيد التقدّم: $count';
  }

  @override
  String get profileSummaryCardBackup => 'الملفات، النسخ الاحتياطي';

  @override
  String get chatPlay => 'تشغيل';

  @override
  String get chatPause => 'إيقاف مؤقت';

  @override
  String get profileTheme => 'اللون';

  @override
  String get profileThemeEmerald => 'زمردي';

  @override
  String get profileThemeIndigo => 'نيلي';

  @override
  String get profileThemeAmber => 'كهرماني';

  @override
  String get profileThemeRose => 'وردي';

  @override
  String get profileThemeFuchsia => 'فوشيا';

  @override
  String get profileThemeViolet => 'بنفسجي';

  @override
  String get profileThemeOcean => 'محيطي';

  @override
  String get profileThemeSlate => 'رمادي';

  @override
  String get profileScale => 'حجم الواجهة';

  @override
  String get profileScaleSystem => 'النظام';

  @override
  String get profileGlass => 'الزجاج';

  @override
  String get profileGlassAuto => 'تلقائي';

  @override
  String get profileGlassFull => 'كامل';

  @override
  String get profileGlassLight => 'خفيف';

  @override
  String get profileGlassHint =>
      'يحتفظ «خفيف» بالصبغة ويُسقط التمويه خلف اللوحات. أما «تلقائي» فيقيس أداء هاتفك مرة واحدة ويقرر. على هاتف يواكب الأداء أصلًا لا قيمة كبيرة لهذا — إنه للهاتف الذي لا يواكب.';

  @override
  String get mapAlwaysNeeded =>
      'لكي تبقى الخريطة محدّثة وcubechat مغلق، يجب ضبط الموقع على «دائمًا». اضغط لفتح الإعدادات.';

  @override
  String get mapShareConsentTitle => 'إظهار موقعك على الخريطة؟';

  @override
  String get mapShareConsentBody =>
      'سيظهر موقعك المباشر فقط لجهات الاتصال على خريطتك: من دعوتهم، أو من قبلت دعوتهم. يستمر في التحديث، حتى أثناء عمل Cubechat في الخلفية، إلى أن تختفي. إنه مشفّر تمامًا بين الطرفين ولا يصل إلينا أبدًا. يمكنك الاختفاء في أي وقت من الخريطة أو من الملف الشخصي، ولن تراك أبدًا جهات الاتصال التي تحظرها.';

  @override
  String get mapShareConsentAllow => 'سماح';

  @override
  String get mapShareConsentDecline => 'عدم السماح';

  @override
  String get mapVisibleToFriends => 'يراك الأصدقاء على خريطتك';

  @override
  String get mapHiddenFromFriends => 'أنت مخفي';

  @override
  String get mapHideMe => 'اختفاء';

  @override
  String get mapShowMe => 'إظهاري';

  @override
  String get profileScaleSmall => 'أصغر';

  @override
  String get profileScaleNormal => 'عادي';

  @override
  String get profileScaleLarge => 'أكبر';

  @override
  String get profileScaleSample => 'يُعرض النص والصفوف بهذا الحجم.';

  @override
  String get savedTitle => 'المحفوظة';

  @override
  String get savedSubtitle => 'ملاحظات لنفسك، على هذا الجهاز';

  @override
  String get savedEmpty => 'كل ما تكتبه هنا يبقى على هذا الهاتف.';

  @override
  String get meshOffTitle => 'شبكة Bluetooth Mesh متوقفة';

  @override
  String get meshOffHint =>
      'لا يمكن لأحد قريب العثور عليك ولا يمكنك العثور عليهم. لا تزال الرسائل تنتقل عبر مُرحِّل الإنترنت.';

  @override
  String get profileMeshSwitch => 'شبكة Bluetooth Mesh';

  @override
  String get profileMeshSwitchHint =>
      'اعثر على الأشخاص القريبين وانقل الرسائل دون إنترنت. الإيقاف يوفّر البطارية.';

  @override
  String get channelAdminOnlyHint => 'قناة إعلانات. لا يزال الجميع يقرؤونها.';

  @override
  String get attachLocation => 'الموقع';

  @override
  String get locationBubbleTitle => 'الموقع';

  @override
  String get locationOpenInMaps => 'فتح في الخرائط';

  @override
  String locationAccuracy(int metres) {
    return 'بدقة $metres م';
  }

  @override
  String get locationExpired => 'لم يعد هذا الموقع حاليًا';

  @override
  String get locationDenied => 'إذن الموقع متوقف';

  @override
  String get locationUnavailable => 'تعذّر تحديد الموقع';

  @override
  String get locationShareFor => 'المشاركة لمدة';

  @override
  String get locationShareOnce => 'مرة واحدة';

  @override
  String get locationShare15m => '15 دقيقة';

  @override
  String get locationShare1h => 'ساعة واحدة';

  @override
  String get storageTitle => 'التخزين';

  @override
  String get storageHeadline => 'استخدام التخزين';

  @override
  String storageSubtitle(String size) {
    return 'يستخدم cubechat مساحة $size على هذا الجهاز';
  }

  @override
  String get storageEmpty => 'لا يوجد شيء مخزّن بعد';

  @override
  String get storageScanning => 'جارٍ القياس…';

  @override
  String get storageCatPhotos => 'الصور';

  @override
  String get storageCatVoice => 'الرسائل الصوتية';

  @override
  String get storageCatFiles => 'الملفات المستلمة';

  @override
  String get storageCatOutbox => 'الملفات المُرسلة';

  @override
  String get storageCatStickers => 'الملصقات';

  @override
  String get storageCatSaved => 'الرسائل المحفوظة';

  @override
  String get storageCatWallpapers => 'الخلفيات';

  @override
  String get storageCatHistory => 'المحادثات والمفاتيح';

  @override
  String get storageCatCache => 'ذاكرة التخزين المؤقت';

  @override
  String storageClear(String size) {
    return 'مسح $size';
  }

  @override
  String get storageClearNothing => 'لم يُحدَّد شيء';

  @override
  String storageFreed(String size) {
    return 'تم تحرير $size';
  }

  @override
  String get storageNoCloud =>
      'لا توجد سحابة خلف هذا. كل ما تمسحه يختفي من هذا الهاتف، والنسخة الأخرى الوحيدة موجودة على الهاتف الذي جاء منه.';

  @override
  String get storageWhyHistoryLocked =>
      'لا تُمسح المحادثات من هنا — استخدم المسح الطارئ.';

  @override
  String get storageRecoveryFree => 'آمن للمسح';

  @override
  String get storageRecoveryGone => 'لا توجد نسخة في أي مكان آخر';

  @override
  String get storageRecoveryAskSender => 'يمكن طلبها من المرسل مجددًا';

  @override
  String get storageRecoveryCostsThem =>
      'لن يتمكنوا بعد ذلك من طلب إعادة الإرسال منك';

  @override
  String storageConfirmTitle(String size) {
    return 'مسح $size؟';
  }

  @override
  String get storageConfirmBody =>
      'سيؤدي هذا إلى حذف الملفات من هذا الهاتف. لا يُرفع شيء إلى أي مكان، لذا لا يوجد ما يمكن استعادتها منه.';

  @override
  String storageFilesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ملف',
      many: '$count ملفًا',
      few: '$count ملفات',
      two: 'ملفان',
      one: 'ملف واحد',
      zero: 'لا ملفات',
    );
    return '$_temp0';
  }

  @override
  String get customizeBarTitle => 'شريط التنقل';

  @override
  String get customizeBarHint => 'اسحب لإعادة الترتيب. لا يمكن إزالة الدردشات.';

  @override
  String get customizeBarShown => 'الظاهرة';

  @override
  String get customizeBarHidden => 'المخفية';

  @override
  String get customizeBarHiddenEmpty => 'لا شيء مخفي';

  @override
  String get customizeBarMinimum => 'أبقِ تبويبين على الأقل';

  @override
  String get customizeReset => 'استعادة الافتراضي';

  @override
  String get chatsArchiveTitle => 'الأرشيف';

  @override
  String get chatsArchiveEmpty => 'لا شيء في الأرشيف';

  @override
  String get chatsArchiveHint =>
      'الدردشات المؤرشفة تواصل العمل — هي فقط خارج القائمة.';

  @override
  String get chatsArchivedToast => 'تمت الأرشفة';

  @override
  String get chatsUnarchivedToast => 'عادت إلى القائمة';

  @override
  String chatsArchiveCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count دردشة',
      many: '$count دردشة',
      few: '$count دردشات',
      two: 'دردشتان',
      one: 'دردشة واحدة',
      zero: 'لا دردشات',
    );
    return '$_temp0';
  }

  @override
  String get chatsSwipeNotHere => 'غير متاح لهذه الدردشة';

  @override
  String get customizeSwipeTitle => 'سحب الدردشة لليمين';

  @override
  String get customizeSwipeHint => 'السحب لليسار لا يزال ينقلك بين التبويبات.';

  @override
  String get customizeSwipeArchive => 'أرشفة';

  @override
  String get customizeSwipeMute => 'كتم';

  @override
  String get customizeSwipePin => 'تثبيت';

  @override
  String get customizeSwipeRead => 'مقروءة';

  @override
  String get customizeSwipeDelete => 'حذف';

  @override
  String get customizeSwipeNone => 'لا شيء';

  @override
  String get customizeHighRefresh => 'معدل التحديث الكامل';

  @override
  String get customizeHighRefreshHint =>
      'أكثر سلاسة، ويرسم الهاتف ضعف عدد الإطارات. أوقفه إذا سخن الهاتف — لا يتغير شكل التطبيق، فقط عدد مرات إعادة رسمه.';

  @override
  String get customizeQuickReaction => 'تفاعل النقر المزدوج';

  @override
  String get customizeQuickReactionHint =>
      'ما يتركه النقر المزدوج على رسالة. استخدام تفاعل آخر ينقله إلى هنا.';

  @override
  String get customizeCircleAudioTitle =>
      'إيقاف الموسيقى مؤقتًا لرسائل الفيديو';

  @override
  String get customizeCircleAudioOn =>
      'تسجيل رسالة فيديو أو مشاهدتها يوقف أي شيء آخر قيد التشغيل. ولا يُستأنف من تلقاء نفسه.';

  @override
  String get customizeCircleAudioOff =>
      'تستمر موسيقاك في الخلفية، بصوت أخفض أثناء تشغيل رسالة الفيديو.';

  @override
  String get customizeMediaQualityTitle => 'جودة الصور عند الإرسال';

  @override
  String get customizeMediaQualityEconomy => 'اقتصادية';

  @override
  String get customizeMediaQualityStandard => 'عادية';

  @override
  String get customizeMediaQualityHigh => 'عالية';

  @override
  String get customizeMediaQualityEconomyHint =>
      'حتى 96 كيلوبايت للصورة، 800 بكسل. لإشارة ضعيفة جدًا أو شبكة Bluetooth Mesh مزدحمة: نصف وقت الانتظار، وصورة أقل حدة.';

  @override
  String get customizeMediaQualityStandardHint =>
      'حتى 192 كيلوبايت للصورة، 1280 بكسل. بحجم يسمح بمرورها عبر Bluetooth وحده. الفيديوهات و«الأصلي» تُرسل دائمًا كما هي.';

  @override
  String get customizeMediaQualityHighHint =>
      'حتى 768 كيلوبايت للصورة، 2048 بكسل. حادة بما يكفي للتكبير؛ تستغرق أربعة أضعاف الوقت للإرسال، لذا الأفضل عبر Wi-Fi.';

  @override
  String get previewReacted => 'على رسالتك';

  @override
  String get previewLocation => 'الموقع';

  @override
  String get previewMapInvite => 'دعوة إلى الخريطة';

  @override
  String get previewContact => 'جهة اتصال';

  @override
  String get previewUnsupported => 'رسالة غير مدعومة';

  @override
  String get previewCallOutgoing => 'مكالمة صادرة';

  @override
  String get previewCallIncoming => 'مكالمة واردة';

  @override
  String get previewCallMissed => 'مكالمة فائتة';

  @override
  String chatPreparingPhotos(int count) {
    return 'جارٍ تجهيز الصور ($count)…';
  }

  @override
  String get circleSwitchCamera => 'تبديل الكاميرا';

  @override
  String get circleLight => 'إضاءة التسجيل';

  @override
  String get circleCameraSwitchFailed =>
      'تعذّر تبديل الكاميرا. لا يزال تسجيلك مفتوحًا.';

  @override
  String get diagnosticsTitle => 'التشخيص';

  @override
  String get diagnosticsIntro =>
      'ما كان التطبيق يفعله مؤخرًا. إذا لم يعمل شيء ما، أرسل هذا إلى المطوّر.';

  @override
  String get diagnosticsShare => 'إرسال السجل إلى المطوّر';

  @override
  String get diagnosticsEvents => 'الأحداث الأخيرة';

  @override
  String get diagnosticsTechnical => 'السجلات التقنية';

  @override
  String get diagnosticsEmpty => 'لا شيء لعرضه بعد.';

  @override
  String get diagnosticsDeveloperOn => 'وضع المطوّر مُفعّل';

  @override
  String get diagnosticsDeveloperOff => 'وضع المطوّر متوقف';

  @override
  String get logAppStarted => 'بدأ التطبيق';

  @override
  String get logInternetOn => 'تم تشغيل الاتصال عبر الإنترنت';

  @override
  String logServerConnected(String host) {
    return 'تم الاتصال بـ $host';
  }

  @override
  String logServerLost(String host) {
    return 'انقطع الاتصال بـ $host';
  }

  @override
  String get chatSaveAction => 'حفظ';

  @override
  String get savedTagAsk => 'تم الحفظ. إضافة وسم؟';

  @override
  String get savedTagAdd => 'إضافة وسم';

  @override
  String get chatSharedWallpaperFailed =>
      'تم تعيين الخلفية هنا. ستصل إليه عندما يكون ضمن النطاق.';

  @override
  String get chatTranscribeAction => 'تحويل إلى نص';

  @override
  String get chatTranscribeFailed =>
      'لا يستطيع هذا الهاتف تحويل هذه الرسالة إلى نص.';

  @override
  String get chatTranscribing => 'جارٍ التعرّف…';

  @override
  String get chatTranscriptHide => 'إخفاء النص';

  @override
  String get chatCancelSend => 'إلغاء الإرسال';

  @override
  String get chatDownloadAction => 'تنزيل';

  @override
  String get chatDownloaded => 'تم الحفظ على الهاتف';

  @override
  String get chatDownloadFailed => 'تعذّر الحفظ';

  @override
  String get selfUpdateTitle => 'تثبيت تحديث من ملف';

  @override
  String get selfUpdateHint =>
      'اختر ملف APK الجديد لـ cubechat من هنا بدلًا من فتحه من دردشة: عند التثبيت بهذه الطريقة تبقى المكالمات على شاشة القفل مُفعّلة.';

  @override
  String get selfUpdateConfirm => 'أكّد التثبيت في نافذة النظام.';

  @override
  String get selfUpdateAllow =>
      'اسمح لـ cubechat بتثبيت التطبيقات، ثم اضغط مجددًا.';

  @override
  String get selfUpdateNotOurs => 'هذا الملف ليس تحديثًا لـ cubechat.';

  @override
  String get selfUpdateFailed => 'لم يُثبَّت التحديث.';

  @override
  String get chatTranscribeDownloading =>
      'يُنزّل الهاتف اللغة اللازمة لهذا. حاول مجددًا بعد دقيقة.';

  @override
  String get chatTranscribeNoLanguage =>
      'لا يوجد على هذا الهاتف نموذج كلام لهذه اللغة. اختر لغة تحويل الصوت إلى نص في الملف الشخصي ← الدردشات والوسائط.';

  @override
  String get chatTranscribeNotAllowed =>
      'التعرّف على الكلام متوقف لـ CubeChat. شغّله في إعدادات iPhone ← CubeChat.';

  @override
  String get customizeTranscribeLanguageTitle => 'لغة تحويل الصوت إلى نص';

  @override
  String get customizeTranscribeLanguageAuto => 'تلقائي';

  @override
  String get customizeTranscribeLanguageHint =>
      'اللغة التي تُنطق بها الرسائل، وليس بالضرورة لغة التطبيق. يجرّب «تلقائي» لغات الهاتف. يُنزّل الهاتف بنفسه أي لغة ناقصة؛ ولا يغادره الصوت أبدًا.';

  @override
  String get chatTranslateAction => 'ترجمة';

  @override
  String get chatTranslateFailed => 'لا يمكن ترجمة هذه الرسالة على هذا الهاتف.';

  @override
  String get customizeDeferMediaTitle => 'انتظار Wi-Fi لتنزيل الوسائط';

  @override
  String get customizeDeferMediaHint =>
      'على بيانات الجوال، تعمل الرسائل النصية والمكالمات كالمعتاد، بينما تنتظر الصور والرسائل الصوتية ورسائل الفيديو والملفات على الخادم حتى يتوفر Wi-Fi — لمدة تصل إلى أسبوعين. يعرض صف فوق الدردشات ما ينتظر ويُنزّله فورًا.';

  @override
  String heldMediaCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count عنصر وسائط في انتظار Wi-Fi',
      many: '$count عنصرًا من الوسائط في انتظار Wi-Fi',
      few: '$count عناصر وسائط في انتظار Wi-Fi',
      two: 'عنصرا وسائط في انتظار Wi-Fi',
      one: 'عنصر وسائط واحد في انتظار Wi-Fi',
      zero: 'لا وسائط في انتظار Wi-Fi',
    );
    return '$_temp0';
  }

  @override
  String get heldMediaDownload => 'تنزيل';

  @override
  String get nearbyAirDropSubtitle => 'شارك الملفات مع الأشخاص القريبين';

  @override
  String get nearbyFilesSubtitle => 'الملفات المُرسلة والمستلمة';

  @override
  String get airdropTab => 'AirDrop';

  @override
  String get nearbyTabFiles => 'الملفات';

  @override
  String get airdropReceiveHint => 'من يمكنه إرسال الملفات إليك';

  @override
  String get airdropReceiveContacts => 'جهات الاتصال';

  @override
  String get airdropReceiveEveryone => 'الجميع 10 د';

  @override
  String airdropEveryoneLeft(String time) {
    return 'الجميع · $time';
  }

  @override
  String get airdropSendFiles => 'إرسال الملفات';

  @override
  String get airdropChooseFiles => 'اختيار الملفات';

  @override
  String airdropStagedTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ملف جاهز',
      many: '$count ملفًا جاهزًا',
      few: '$count ملفات جاهزة',
      two: 'ملفان جاهزان',
      one: 'ملف واحد جاهز',
      zero: 'لا ملفات جاهزة',
    );
    return '$_temp0';
  }

  @override
  String get airdropStagedHint =>
      'مع تشغيل Bluetooth وفتح AirDrop على الهاتفين، قرّبهما من بعضهما أو اختر شخصًا';

  @override
  String get airdropStagedPickPerson => 'اختيار شخص';

  @override
  String airdropRequestBody(String what, String size) {
    return 'يريد إرسال $what · $size';
  }

  @override
  String airdropWhatPhotos(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count صورة',
      many: '$count صورة',
      few: '$count صور',
      two: 'صورتين',
      one: 'صورة واحدة',
      zero: 'لا صور',
    );
    return '$_temp0';
  }

  @override
  String airdropWhatVideos(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count فيديو',
      many: '$count فيديو',
      few: '$count فيديوهات',
      two: 'فيديوهين',
      one: 'فيديو واحد',
      zero: 'لا فيديوهات',
    );
    return '$_temp0';
  }

  @override
  String airdropWhatFiles(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ملف',
      many: '$count ملفًا',
      few: '$count ملفات',
      two: 'ملفين',
      one: 'ملف واحد',
      zero: 'لا ملفات',
    );
    return '$_temp0';
  }

  @override
  String get airdropAccept => 'قبول';

  @override
  String get airdropDecline => 'رفض';

  @override
  String get airdropWaiting => 'في انتظار الرد…';

  @override
  String get airdropAccepted => 'تم القبول';

  @override
  String get airdropUnheard => 'لم يُستلم — ربما إصدار قديم من CubeChat';

  @override
  String get airdropSending => 'جارٍ الإرسال';

  @override
  String get airdropReceiving => 'جارٍ الاستلام';

  @override
  String get airdropInterrupted => 'انقطع';

  @override
  String get airdropRetry => 'إعادة المحاولة';

  @override
  String get airdropOutcomeSent => 'أُرسل';

  @override
  String get airdropOutcomeReceived => 'استُلم';

  @override
  String get airdropOutcomeDeclined => 'رُفض';

  @override
  String get airdropOutcomeCancelled => 'أُلغي';

  @override
  String get airdropOutcomePartial => 'جزئيًا';

  @override
  String get airdropReasonNoSpace => 'لا توجد مساحة كافية';

  @override
  String get airdropReasonContactsOnly => 'جهات الاتصال فقط';

  @override
  String get airdropReasonBusy => 'مشغول';

  @override
  String get airdropReasonTimeout => 'لا رد';

  @override
  String get airdropFileDeleted => 'محذوف';

  @override
  String get airdropHistory => 'السجل';

  @override
  String get airdropClearHistory => 'مسح السجل';

  @override
  String get airdropEmpty => 'ستظهر هنا الملفات التي ترسلها أو تستلمها بالقرب';

  @override
  String get airdropPickPerson => 'إرسال إلى';

  @override
  String get airdropNobody => 'لا أحد قريب يستخدم cubechat بعد';

  @override
  String get airdropNoDirect => 'لا يوجد اتصال Bluetooth مع هذا الشخص';

  @override
  String get airdropNearbyUnknown => 'بالقرب';

  @override
  String get airdropConnecting => 'جارٍ الاتصال…';

  @override
  String get airdropConnectFailed => 'تعذّر الاتصال';

  @override
  String get airdropSlowWarning => 'قد يستغرق هذا وقتًا طويلًا عبر Bluetooth';

  @override
  String airdropTooLarge(String name, int limit) {
    return 'حجم $name أكبر من $limit ميغابايت';
  }

  @override
  String airdropFromLabel(String name) {
    return 'AirDrop · $name';
  }

  @override
  String get airdropWrite => 'مراسلة';

  @override
  String get airdropAction => 'AirDrop';

  @override
  String get airdropLaneTitle => 'المسار';

  @override
  String get airdropLaneAuto => 'تلقائي';

  @override
  String get airdropLaneBluetooth => 'Bluetooth';

  @override
  String get airdropLaneWifi => 'Wi‑Fi';

  @override
  String get airdropBluetoothNeededHint =>
      'شغّل Bluetooth على الهاتفين ليعثر كل منهما على الآخر ويؤكدا النقل.';

  @override
  String get airdropLaneHint =>
      'يعثر Bluetooth على الهاتفين ويربطهما. وينقل Wi‑Fi الملفات عندما يتشارك الهاتفان شبكة أو نقطة اتصال.';

  @override
  String get airdropWifiUnreachable => 'ليسا على الشبكة نفسها';

  @override
  String get airdropWifiOldVersion => 'لا يستطيع تطبيقه الاستلام عبر Wi‑Fi بعد';

  @override
  String get airdropBumpAdd => 'إضافة';

  @override
  String get airdropBumpAlreadyContact => 'موجود في جهات اتصالك';

  @override
  String airdropBumpSending(String name) {
    return 'جارٍ الإرسال إلى $name';
  }

  @override
  String airdropBumpReceiving(String name) {
    return '$name يرسل إليك ملفات';
  }

  @override
  String get termsTitle => 'قواعد cubechat';

  @override
  String get termsBody =>
      'لا يتسامح cubechat إطلاقًا مع المحتوى المسيء والمستخدمين المسيئين. بالمتابعة، توافق على عدم إرسال أي تحرش أو تهديدات أو محتوى جنسي يتعلق بالقاصرين أو رسائل مزعجة أو أي شيء غير قانوني. يمكن لأي شخص الإبلاغ عن رسالة أو شخص؛ تصل البلاغات إلى المطوّر ويُتخذ إجراء بشأنها خلال 24 ساعة، ويُحظر المخالفون.';

  @override
  String get termsReadFull => 'قراءة الشروط كاملة';

  @override
  String get termsAccept => 'أوافق';

  @override
  String get messageHide => 'إخفاء';

  @override
  String get messageHidden => 'مخفية لديك';

  @override
  String get reportAction => 'إبلاغ';

  @override
  String get reportTitle => 'ما المشكلة؟';

  @override
  String get reportReasonSpam => 'رسائل مزعجة';

  @override
  String get reportReasonAbuse => 'إساءة أو تحرش';

  @override
  String get reportReasonViolence => 'عنف';

  @override
  String get reportReasonSexual => 'محتوى جنسي';

  @override
  String get reportReasonOther => 'أخرى';

  @override
  String get reportNoteHint => 'صِف المشكلة (اختياري)';

  @override
  String get reportSend => 'إرسال البلاغ';

  @override
  String get reportDisclosure =>
      'يُرسل نص الرسالة المحددة وبلاغك إلى فريق الإشراف في cubechat وإلى بوت Telegram الخاص به.';

  @override
  String get reportSent => 'تم إرسال البلاغ. نراجع البلاغات خلال 24 ساعة.';

  @override
  String get reportBlockedToo => 'تم حظره لديك.';

  @override
  String get reportQueued => 'تم حفظ البلاغ. سيُرسل عند الاتصال.';

  @override
  String get reportFailed => 'تعذّر إرسال البلاغ.';

  @override
  String get filteredMessage => 'مخفية بواسطة الفلتر';

  @override
  String get filteredShow => 'إظهار';

  @override
  String get filterToggle => 'فلتر المحتوى المسيء';

  @override
  String get filterToggleHint => 'يخفي الكلمات البذيئة من الغرباء وفي القنوات';

  @override
  String get aboutTitle => 'حول التطبيق';

  @override
  String get aboutContact => 'مراسلة المطوّر';

  @override
  String get aboutReport => 'الإبلاغ عن مخالفة';

  @override
  String get aboutTerms => 'شروط الاستخدام';

  @override
  String get aboutPrivacy => 'سياسة الخصوصية';

  @override
  String get requestsTitle => 'الطلبات';

  @override
  String get requestsEmpty => 'لا توجد طلبات';

  @override
  String requestBanner(String name) {
    return '$name ليس في جهات اتصالك. لا يمكنه معرفة أنك قرأت هذا أو الاتصال بك حتى تقبل.';
  }

  @override
  String get requestAccept => 'قبول';

  @override
  String get requestDelete => 'حذف';

  @override
  String get requestBlock => 'حظر';

  @override
  String get cubeIdTitle => 'Cube ID';

  @override
  String get cubeIdExplainer =>
      'يشير @اسمك إلى بطاقة جهة اتصالك. لا يحتفظ الخادم إلا بالاسم وبطاقتك العامة — ولا يحتفظ برسائلك أبدًا.';

  @override
  String get cubeIdFieldHint => 'a–z و0–9 و_، من 3 إلى 20 حرفًا';

  @override
  String get cubeIdAvailable => 'متاح';

  @override
  String get cubeIdTaken => 'محجوز';

  @override
  String get cubeIdReserved => 'غير مسموح';

  @override
  String get cubeIdInvalid => 'فقط a–z و0–9 و_، من 3 إلى 20 حرفًا';

  @override
  String get cubeIdClaim => 'حجز هذا الاسم';

  @override
  String get cubeIdWorking => 'جارٍ تأمين الاسم…';

  @override
  String get cubeIdChange => 'تغيير';

  @override
  String get cubeIdEmail => 'بريد الاستعادة';

  @override
  String get cubeIdEmailHint =>
      'إذا فُقد هذا الهاتف، يعود الاسم عبر رسالة إلى هذا العنوان';

  @override
  String get cubeIdEmailField => 'البريد الإلكتروني';

  @override
  String cubeIdEmailSent(String email) {
    return 'أُرسلت رسالة إلى $email. افتح الرابط الموجود فيها.';
  }

  @override
  String get cubeIdEmailRemove => 'إزالة البريد';

  @override
  String get cubeIdEmailUnavailable =>
      'البريد الإلكتروني غير متاح حاليًا. حاول لاحقًا.';

  @override
  String get cubeIdEmailInvalid => 'لا يبدو هذا عنوان بريد إلكتروني';

  @override
  String get cubeIdSave => 'حفظ';

  @override
  String get cubeIdRecover => 'استعادة اسم عبر البريد';

  @override
  String get cubeIdRecoverSent =>
      'إذا تطابق العنوان، ستصلك رسالة. ينتقل الاسم إلى هذا الهاتف بعد 48 ساعة من فتح الرابط.';

  @override
  String cubeIdRecoveryWarning(String name, String when) {
    return 'هناك من يستعيد @$name على هاتف آخر عبر البريد. سينتقل في $when ما لم تلغِ ذلك.';
  }

  @override
  String get cubeIdRecoveryCancel => 'إلغاء الاستعادة';

  @override
  String get cubeIdRecoveryCancelled => 'أُلغيت الاستعادة';

  @override
  String get cubeIdRelease => 'تحرير';

  @override
  String cubeIdReleaseConfirm(String name) {
    return 'تحرير @$name؟ سيتمكن أي شخص من أخذه.';
  }

  @override
  String get cubeIdShare => 'مشاركة';

  @override
  String cubeIdShareText(String name) {
    return 'تجدني في cubechat: @$name\nhttps://cubechat.tech/u.html#$name';
  }

  @override
  String get cubeIdFailed => 'تعذّر حفظ الاسم. حاول مجددًا.';

  @override
  String get cubeIdOffline => 'لا يوجد إنترنت';

  @override
  String get lookupNotFound => 'لا يوجد أحد بهذا @الاسم';

  @override
  String searchFindCubeName(String name) {
    return 'البحث عن @$name';
  }

  @override
  String get searchFindCubeNameHint => 'ابحث في Cube ID وأضف';

  @override
  String get addContactHintName => 'الصق بطاقة أو اكتب @الاسم';

  @override
  String get strangerReachTitle => 'من يمكنه مراسلتي عبر الإنترنت';

  @override
  String get strangerReachAll => 'الجميع';

  @override
  String get strangerReachRequest => 'بطلب';

  @override
  String get strangerReachNone => 'لا أحد';

  @override
  String get strangerReachHint =>
      'للأشخاص الذين لم تراسلهم ويصلون إليك عبر الإنترنت. لا يتأثر الأشخاص القريبون عبر Bluetooth.';

  @override
  String get sectionPrivacy => 'الخصوصية والأمان';

  @override
  String get sectionNotifications => 'الإشعارات والمكالمات';

  @override
  String get sectionConnection => 'الاتصال';

  @override
  String get sectionChats => 'الدردشات والوسائط';

  @override
  String get sectionAppearance => 'المظهر';

  @override
  String get sectionData => 'البيانات والتخزين';

  @override
  String get sectionAbout => 'حول التطبيق';

  @override
  String get subWhoSeesMe => 'من يراني';

  @override
  String get subProtection => 'الحماية';

  @override
  String get subNotifications => 'الإشعارات';

  @override
  String get subCalls => 'المكالمات';

  @override
  String get profileDiscoverableMeshOff =>
      'شبكة Bluetooth Mesh متوقفة — شغّلها من قسم الاتصال.';

  @override
  String get chatRouteBluetoothDirect => 'Bluetooth، مباشرة';

  @override
  String chatRouteMeshHops(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Mesh · $n قفزة',
      many: 'Mesh · $n قفزة',
      few: 'Mesh · $n قفزات',
      two: 'Mesh · قفزتان',
      one: 'Mesh · قفزة واحدة',
      zero: 'Mesh · $n قفزة',
    );
    return '$_temp0';
  }

  @override
  String chatRouteDeliveredVia(String route) {
    return 'تم التسليم: $route';
  }

  @override
  String chatRouteReceivedVia(String route) {
    return 'تم الاستلام: $route';
  }

  @override
  String get chatUnreadDivider => 'رسائل جديدة';

  @override
  String get radioTitle => 'اللاسلكي';

  @override
  String get radioNearbySubtitle =>
      'اضغط مطولًا على زر وتحدّث إلى مجموعة أو جهة اتصال';

  @override
  String get radioGroupsLabel => 'المجموعات';

  @override
  String get radioDirectLabel => 'خاص';

  @override
  String get radioAddGroup => 'إضافة لاسلكي';

  @override
  String get radioNoGroups =>
      'لا يوجد لاسلكي بعد. أضف واحدًا — كل من يُدخل الاسم وكلمة المرور نفسيهما يسمع بعضهم بعضًا.';

  @override
  String get radioLeave => 'مغادرة هذا اللاسلكي';

  @override
  String get radioPickChannel => 'اختر مجموعة أو جهة اتصال';

  @override
  String get radioPushToTalk => 'اضغط مطولًا للتحدث';

  @override
  String get radioTalking => 'تتحدث…';

  @override
  String get radioChannelBusy => 'الخط مشغول';

  @override
  String radioSpeaker(String name) {
    return '$name يتحدث';
  }

  @override
  String get radioSilentTitle => 'التحدث في الوضع الصامت';

  @override
  String get radioSilentHint =>
      'يُشغَّل الصوت حتى عندما يكون الهاتف في الوضع الصامت.';

  @override
  String get radioJoinNameLabel => 'الاسم';

  @override
  String get radioJoinPasswordLabel => 'كلمة المرور (اختياري)';

  @override
  String get radioJoinHint =>
      'كل من يُدخل الاسم وكلمة المرور نفسيهما يكون على اللاسلكي نفسه. لا يوجد خادم يحتفظ بقائمة بهم.';

  @override
  String get radioJoinNameRequired => 'أدخل اسمًا';

  @override
  String get radioJoinSubmit => 'إضافة';

  @override
  String get radioBlockedTooLong => 'قُطع بعد دقيقة من التحدث';

  @override
  String get radioBlockedCall => 'هناك مكالمة جارية';

  @override
  String get radioBlockedMicrophone => 'لا يوجد وصول إلى الميكروفون';

  @override
  String get radioBlockedUnavailable => 'اللاسلكي غير متاح على هذا الجهاز';

  @override
  String get radioBlockedNoChannel => 'اختر مجموعة أو جهة اتصال أولًا';

  @override
  String get radioTurnOff => 'إيقاف اللاسلكي';

  @override
  String get radioPersonalCallsTitle => 'استقبال النداءات الشخصية';

  @override
  String get radioPersonalCallsHint =>
      'عندما يكون اللاسلكي متوقفًا، تضبطه جهة الاتصال التي تتحدث إليك على نفسها.';

  @override
  String get radioBackgroundHint =>
      'مع إطفاء الشاشة، لا يُسمع اللاسلكي إلا أثناء تشغيل وضع الخلفية.';

  @override
  String get areaNearby => 'دردشة المنطقة';

  @override
  String get areaLevelDistrict => 'الحي';

  @override
  String get areaLevelCity => 'المدينة';

  @override
  String get areaLevelRegion => 'الإقليم';

  @override
  String areaPresentCount(int count) {
    return '≈$count هنا';
  }

  @override
  String get areaPresentMany => '50+ هنا';

  @override
  String get areaBlockViaBluetooth => 'مربّعك السكني — عبر Bluetooth';

  @override
  String get areaOpenNearbyTab => 'فتح «بالقرب»';

  @override
  String get areaLocating => 'جارٍ تحديد حيّك…';

  @override
  String get areaNoPlace =>
      'لا يوجد موقع بعد. تحتاج دردشة المنطقة إلى موقعك التقريبي أثناء فتح هذه الشاشة.';

  @override
  String get areaLocationDenied =>
      'الموقع متوقف لـ Cubechat. اسمح بالموقع التقريبي في الإعدادات لرؤية حيّك.';

  @override
  String get areaOffline => 'لا يوجد اتصال بدردشة المنطقة';

  @override
  String get areaEmpty => 'لم يكتب أحد هنا خلال آخر 24 ساعة.';

  @override
  String get areaConsentTitle => 'دردشة المنطقة عامة';

  @override
  String get areaConsentBody =>
      'الرسائل هنا عامة. سيقرؤها كل من يفتح حيّك أو مدينتك، وتُحفظ لمدة 24 ساعة على خادم Cubechat. تكتب باسم مؤقت يتغير كل بضع ساعات؛ ولا أحد يرى @اسمك أو جهات اتصالك. لمعرفة حيّك، يطلب Cubechat موقعك التقريبي، فقط أثناء فتح هذه الشاشة.';

  @override
  String get areaConsentAllow => 'متابعة';

  @override
  String get areaConsentDecline => 'ليس الآن';

  @override
  String areaDefaultName(String tag) {
    return 'مكعب-$tag';
  }

  @override
  String areaYouAre(String name, int hours) {
    return 'أنت $name · اسم جديد بعد $hours س';
  }

  @override
  String get areaNewName => 'اسم جديد';

  @override
  String get areaSetName => 'اختيار اسم';

  @override
  String get areaNameHint =>
      'لساعات هذا الاسم القليلة فقط. اتركه فارغًا للاسم التلقائي.';

  @override
  String get areaNameSameWarning => 'الاسم نفسه يربط بين ظهورك في أحياء مختلفة';

  @override
  String get areaShowPresence => 'إظهار أنني هنا';

  @override
  String get areaPresenceOffHint =>
      'شغّل «إظهار أنني هنا» لترى عدد الأشخاص القريبين';

  @override
  String get areaReadOnly => 'يمكنك الكتابة فقط حيث تكون';

  @override
  String get areaComposerHint => 'رسالة إلى كل من هنا';

  @override
  String get areaSend => 'إرسال';

  @override
  String get areaWaitALittle => 'انتظر قليلًا';

  @override
  String areaFlood(int count) {
    return 'إغراق ($count) · إظهار';
  }

  @override
  String get areaReply => 'رد';

  @override
  String get areaHide => 'إخفاء';

  @override
  String get areaBlock => 'حظر حتى يتغير اسمه';

  @override
  String get areaBlocked => 'محظور حتى يتغير اسمه';

  @override
  String get areaReport => 'إبلاغ';

  @override
  String get areaOpenLink => 'فتح الرابط';

  @override
  String areaOpenLinkConfirm(String url) {
    return 'فتح $url؟';
  }

  @override
  String get areaOpen => 'فتح';

  @override
  String get areaReadHere => 'القراءة هنا';

  @override
  String get areaReadHereHint =>
      'للقراءة فقط. يمكنك الكتابة فقط حيث تكون؛ ويعرف المُرحِّل أي مكان تقرأ.';

  @override
  String get areaNotes => 'الملاحظات';

  @override
  String areaNotesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ملاحظة',
      many: '$count ملاحظة',
      few: '$count ملاحظات',
      two: 'ملاحظتان',
      one: 'ملاحظة واحدة',
      zero: 'لا ملاحظات',
    );
    return '$_temp0';
  }

  @override
  String get areaLeaveNote => 'ترك ملاحظة';

  @override
  String get areaNoteHint => 'ملاحظة قصيرة لمدينتك';

  @override
  String get areaNoteLifetime => 'تبقى لمدة';

  @override
  String get areaNote1h => '1 س';

  @override
  String get areaNote24h => '24 س';

  @override
  String get areaNote7d => '7 أيام';

  @override
  String get areaPinToDistrict => 'تثبيت في حي';

  @override
  String get areaPinHint =>
      'اضغط على الخريطة داخل مدينتك؛ وسيلتصق الدبوس بالحي.';

  @override
  String get areaPinOutside => 'داخل مدينتك فقط';

  @override
  String get areaNoteDelete => 'حذف ملاحظتي';

  @override
  String get areaNoNotes => 'لا توجد ملاحظات هنا بعد';

  @override
  String get areaNotesLimit => 'ثلاث ملاحظات في اليوم';

  @override
  String get areaNoteLeft => 'تُركت الملاحظة';

  @override
  String get areaNoteSend => 'ترك';

  @override
  String get areaOwnNote => 'ملاحظتك';

  @override
  String get areaNotePinned => 'مثبّتة في حي';

  @override
  String get areaHidden => 'مخفي';

  @override
  String get areaPublicBadge => 'عامة · 24 س';

  @override
  String get areaSettingTitle => 'دردشة المنطقة';

  @override
  String get areaSettingOnHint =>
      'زر دردشة المنطقة على الخريطة: دردشات عامة لحيّك ومدينتك، باسم مؤقت.';

  @override
  String get areaSettingOffHint =>
      'متوقف: لا زر على الخريطة، ولا تطلب دردشة المنطقة موقعك أبدًا ولا تتصل.';

  @override
  String get wallpaperPhotoLocalOnly => 'خلفيات الصور محلية فقط حاليًا';

  @override
  String get wallpaperSavedNoRoute =>
      'حُفظت هنا. لا يوجد مسار إلى الطرف الآخر الآن';

  @override
  String get wallpaperScopeTitle => 'من يرى هذه الخلفية؟';

  @override
  String get wallpaperScopeChannel => 'القناة كلها';

  @override
  String get wallpaperScopeBoth => 'أنا والطرف الآخر';

  @override
  String get wallpaperScopeLocal => 'عندي فقط';

  @override
  String get wallpaperScopeSharedHint => 'تُرسل كحزمة تحكم مشفّرة';

  @override
  String get wallpaperScopePhotoHint => 'تبقى الصور على هذا الهاتف فقط حاليًا';

  @override
  String get foldersCreate => 'إنشاء مجلد';

  @override
  String get foldersYours => 'مجلداتك';

  @override
  String get foldersSmartFilters => 'عوامل تصفية ذكية';

  @override
  String get foldersName => 'اسم المجلد';

  @override
  String get foldersSave => 'حفظ';

  @override
  String get foldersDeleteTitle => 'حذف المجلد؟';

  @override
  String get foldersDelete => 'حذف';

  @override
  String get foldersCreateAction => 'إنشاء';

  @override
  String get chatsArchiveHiddenToast => 'الأرشيف مخفي. أعِده من «المظهر».';

  @override
  String get chatsBulkPin => 'تثبيت';

  @override
  String get chatsBulkMute => 'كتم';

  @override
  String get chatsUnarchive => 'إلغاء الأرشفة';

  @override
  String get chatsAddToFolder => 'إضافة إلى مجلد';

  @override
  String get chatsMarkUnread => 'تعليم كغير مقروءة';

  @override
  String get chatsClearHistory => 'مسح سجل الدردشة';

  @override
  String get foldersNew => 'مجلد جديد';

  @override
  String get foldersNameHint => 'الأصدقاء';

  @override
  String get chatsNoIncoming => 'لا توجد رسائل واردة';

  @override
  String get chatsMarkedUnread => 'عُلّمت كغير مقروءة';

  @override
  String get chatsClearHistoryTitle => 'مسح سجل الدردشة؟';

  @override
  String get chatsClearHistoryBody =>
      'ستُحذف الرسائل من هذا الجهاز فقط. تبقى الدردشة وجهة الاتصال والمفضلة.';

  @override
  String get chatsClearHistoryAction => 'مسح';

  @override
  String get chatsHistoryCleared => 'مُسح السجل';

  @override
  String get savedTagMenuTag => 'وسم';

  @override
  String get savedTagRemove => 'إزالة الوسم';

  @override
  String get customizeArchiveRowTitle => 'صف الأرشيف';

  @override
  String get customizeArchiveRowHint =>
      'اعرضه فوق قائمة الدردشات. تستمر الدردشات المؤرشفة في تلقي الرسائل في كل الأحوال.';

  @override
  String get mapLayerStandard => 'قياسية';

  @override
  String get mapLayerStandardHint => 'خريطة شوارع فاتحة — الخيار الأكثر ثباتًا';

  @override
  String get backupAutoTitle => 'نسخ احتياطي تلقائي';

  @override
  String get backupAutoHint =>
      'مرة يوميًا في ملف واحد داخل المجلد الذي تختاره؛ كل نسخة تحل محل السابقة.';

  @override
  String backupAutoFolder(String name) {
    return 'المجلد: $name';
  }

  @override
  String backupAutoLast(String time) {
    return 'آخر نسخة: $time';
  }

  @override
  String get backupAutoNever => 'لا توجد نسخة بعد';

  @override
  String get backupAutoRunning => 'جارٍ إنشاء نسخة…';

  @override
  String get backupAutoFolderLost => 'تعذّر الوصول إلى المجلد. اختره مرة أخرى.';

  @override
  String get backupAutoFailed => 'فشلت آخر نسخة. ستُعاد المحاولة لاحقًا.';

  @override
  String get backupAutoNow => 'نسخ احتياطي الآن';

  @override
  String get backupAutoChangeFolder => 'تغيير المجلد';

  @override
  String get callYourMicOff => 'الميكروفون لديك مغلق';

  @override
  String callTheirCameraOff(String name) {
    return 'كاميرا $name مغلقة';
  }
}
