// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get callVoice => 'Sesli arama';

  @override
  String get callVideo => 'Görüntülü arama';

  @override
  String get callIncomingVideo => 'Gelen görüntülü arama';

  @override
  String get callCamera => 'Kamera';

  @override
  String get callFlipCamera => 'Çevir';

  @override
  String get contactProfileVideo => 'Video';

  @override
  String get callPreparing => 'Mikrofon hazırlanıyor…';

  @override
  String get callDialing => 'Aranıyor…';

  @override
  String get callRinging => 'Çalıyor…';

  @override
  String get callConnecting => 'Bağlanıyor…';

  @override
  String get callMicrophoneRequired =>
      'Arama yapmak için sistem ayarlarından mikrofon erişimine izin verin.';

  @override
  String get callMicrophoneWindows =>
      'Windows, CubeChat\'e mikrofon erişimi vermedi. Ayarlar → Gizlilik ve güvenlik → Mikrofon → \"Masaüstü uygulamalarının mikrofonunuza erişmesine izin verin\" seçeneğini açın.';

  @override
  String get callElsewhere =>
      'Bu hesabın başka bir cihazında zaten bir arama sürüyor.';

  @override
  String get callRelayUnavailable =>
      'Arama sunucusuna ulaşılamıyor. Lütfen daha sonra tekrar deneyin.';

  @override
  String get callBusy => 'Meşgul';

  @override
  String get callNoAnswer => 'Yanıt yok';

  @override
  String get callFailed => 'Arama bağlanamadı';

  @override
  String get callDeclined => 'Arama reddedildi';

  @override
  String get callEnded => 'Arama sona erdi';

  @override
  String get callMicrophone => 'Mikrofon';

  @override
  String get callSpeaker => 'Hoparlör';

  @override
  String get callAnswer => 'Yanıtla';

  @override
  String get callDecline => 'Reddet';

  @override
  String get callEnd => 'Bitir';

  @override
  String get callClose => 'Kapat';

  @override
  String get callMinimize => 'Küçült';

  @override
  String get callAudioOutput => 'Arama sesi';

  @override
  String get callRoutePhone => 'Telefon';

  @override
  String get callRouteBluetooth => 'Bluetooth';

  @override
  String get callRouteHeadphones => 'Kulaklık';

  @override
  String get callFullScreenTitle => 'Kilit ekranında aramalar';

  @override
  String get callFullScreenBody =>
      'Gelen aramaların kilitli ekranda gösterilmesine izin verin; böylece kilidi açmadan yanıtlayabilirsiniz.';

  @override
  String get callFullScreenXiaomi =>
      'Xiaomi, Redmi ve Poco uygulamaların bunu kendisinin açmasına izin vermez: Diğer izinler altında “Kilit ekranında göster” seçeneğini açın.';

  @override
  String get circleMessage => 'Görüntülü mesaj';

  @override
  String get appName => 'Cubechat';

  @override
  String get navChats => 'Sohbetler';

  @override
  String get navPeers => 'Yakında';

  @override
  String get navProfile => 'Profil';

  @override
  String get navContacts => 'Kişiler';

  @override
  String get navMap => 'Harita';

  @override
  String get mapTitle => 'Harita';

  @override
  String get mapFriendsTitle => 'Haritadaki kişiler';

  @override
  String get mapFriendsHint => 'Konumunuzu yalnızca bu kişiler alır';

  @override
  String mapClusterTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Burada $count kişi',
      one: 'Burada $count kişi',
    );
    return '$_temp0';
  }

  @override
  String get mapClusterHint => 'Haritayı birine götürmek için ona dokunun';

  @override
  String get mapNorthUp => 'Kuzeyi yukarı çevir';

  @override
  String get mapLayerTitle => 'Harita stili';

  @override
  String get mapLayerHint => 'İşaretlerin üzerine çizildiği zemin';

  @override
  String get mapLayerDark => 'Koyu';

  @override
  String get mapLayerDarkHint =>
      'Etiketsiz sokaklar — işaretlerin altında en sade zemin';

  @override
  String get mapLayerSatellite => 'Uydu';

  @override
  String get mapLayerSatelliteHint =>
      'Hava fotoğrafları: hangi bina, hangi avlu';

  @override
  String get mapLayerTerrain => 'Arazi';

  @override
  String get mapLayerTerrainHint =>
      'Eş yükselti eğrileri ve rölyef; tepeler ve patikalar için';

  @override
  String get mapFriendsEmpty => 'Henüz kimse haritayı sizinle paylaşmıyor.';

  @override
  String get mapFriendsEmptyHint =>
      'Bir kişiyi davet edin; kabul ettiğinde burada görünecek.';

  @override
  String get mapFriendsInvite => 'Davet et';

  @override
  String get mapFriendsRemove => 'Haritadan kaldır';

  @override
  String mapFriendsRemoved(String name) {
    return '$name artık haritayı sizinle paylaşmıyor';
  }

  @override
  String get mapFriendsLive => 'Şu an haritada';

  @override
  String get mapFriendsIdle => 'Şu an konum yok';

  @override
  String get mapInviteTitle => 'Haritaya davet et';

  @override
  String get mapInviteHint => 'Bir veya daha fazla sohbet seçin';

  @override
  String get mapInviteEmpty => 'Henüz davet edilecek sohbet yok.';

  @override
  String mapInviteAction(int count) {
    return 'Gönder ($count)';
  }

  @override
  String get mapInviteMessage =>
      'Cubechat harita daveti. Haritada görünmek için konumunuzu bu sohbette paylaşın.';

  @override
  String mapInviteSent(int count) {
    return 'Gönderilen davet: $count';
  }

  @override
  String get mapInviteFailed => 'Davetler gönderilemedi';

  @override
  String mapPeopleVisible(int count) {
    return 'Paylaşılan konum: $count';
  }

  @override
  String get mapCenterMe => 'Beni ortala';

  @override
  String get mapNoSharedLocations => 'Henüz paylaşılan konum yok';

  @override
  String get mapNoSharedLocationsHint =>
      'Bir kişi sohbette konum gönderdiğinde burada görünür.';

  @override
  String get mapWebHintTitle => 'Yakındaki bağlantılar';

  @override
  String get mapWebHint =>
      'Çizgiler mesajın rotasını değil, yakınlığı gösterir.';

  @override
  String get mapOpenProfile => 'Profil';

  @override
  String get mapLocationPrivacyOff => 'Harita konumu gizli';

  @override
  String get mapLocationPrivacyOffHint =>
      'İşaretinizi göstermek için Gizlilik altında “Beni haritada göster”i açın.';

  @override
  String get mapYouOnMap => 'Konumunuz bu cihazda görünüyor';

  @override
  String get locationSharingDisabled =>
      'Önce Gizlilik altında “Beni haritada göster”i açın.';

  @override
  String get mapLocationDenied => 'Konum erişimi kapalı';

  @override
  String get mapLocationServiceOff =>
      'Kendinizi göstermek için konum servislerini açın';

  @override
  String get mapLocationUnavailable => 'Konumunuz belirlenemedi';

  @override
  String get mapDistanceUnknown => 'Mesafe bilinmiyor';

  @override
  String mapDistanceMetres(int metres) {
    return '$metres m uzakta';
  }

  @override
  String mapDistanceKilometres(String kilometres) {
    return '$kilometres km uzakta';
  }

  @override
  String get mapUpdatedNow => 'az önce paylaşıldı';

  @override
  String mapUpdatedMinutes(int minutes) {
    return '$minutes dk önce paylaşıldı';
  }

  @override
  String mapUpdatedHours(int hours) {
    return '$hours sa önce paylaşıldı';
  }

  @override
  String get contactsTitle => 'Kişiler';

  @override
  String get contactsSubtitle => 'Mesajlaştığınız herkes';

  @override
  String get contactsSearchHint => 'Kişilerde ara…';

  @override
  String get contactsEmptyTitle => 'Henüz kişi yok';

  @override
  String get contactsEmptyHint => 'Bir sohbet başlatın, kişi burada görünecek.';

  @override
  String get contactsSearchEmpty => 'Eşleşen kişi yok';

  @override
  String get contactsTabContacts => 'Kişiler';

  @override
  String get contactsTabCalls => 'Aramalar';

  @override
  String get callsFilterAll => 'Tümü';

  @override
  String get callsFilterMissed => 'Cevapsız';

  @override
  String get callsEmptyTitle => 'Henüz arama yok';

  @override
  String get callsEmptyHint =>
      'Gelen, giden ve cevapsız aramalar burada görünecek.';

  @override
  String get callsMissedEmpty => 'Cevapsız arama yok';

  @override
  String get callsCallBack => 'Ara';

  @override
  String get contactProfileChat => 'Sohbet';

  @override
  String get contactProfileCall => 'Ara';

  @override
  String get contactProfileRadio => 'Telsiz';

  @override
  String get contactProfileSecurity => 'Güvenlik';

  @override
  String get contactProfileActions => 'Kişi işlemleri';

  @override
  String get contactProfileVerify => 'Doğrula';

  @override
  String get contactProfileCopyId => 'Kişi kimliğini kopyala';

  @override
  String get contactProfileIdCopied => 'Kişi kimliği kopyalandı';

  @override
  String get contactProfileId => 'Kişi kimliği';

  @override
  String get contactProfileVerifyHint =>
      'Bu kişiyi doğrulamak için şifreleme parmak izlerini karşılaştırın.';

  @override
  String get chatsTitle => 'Sohbetler';

  @override
  String get chatsSubtitle => 'Mesh · uçtan uca şifreli';

  @override
  String get chatsEmptyTitle => 'Henüz sohbet yok';

  @override
  String get chatsEmptyHint =>
      'Sohbete başlamak için Yakında sekmesinden bir kişiyi açın.';

  @override
  String get chatsFilterAll => 'Tümü';

  @override
  String get chatsFilterUnread => 'Okunmamış';

  @override
  String get chatsFilterMesh => 'Mesh';

  @override
  String get chatsFilterFavorites => 'Favoriler';

  @override
  String get chatsFolderDirect => 'Kişisel';

  @override
  String get chatsFolderChannels => 'Kanallar';

  @override
  String get chatsFolderOnline => 'Erişilebilir';

  @override
  String get chatsFoldersTitle => 'Klasörler';

  @override
  String get chatsFoldersHint =>
      'Klasörler bu listenin kesitleridir, sohbetlerin taşındığı yerler değil. Sohbetlerin üstünde görmek istediklerinizi açın.';

  @override
  String get chatsSearchHint => 'Sohbetlerde ara…';

  @override
  String get chatsStatusViaMesh => 'mesh üzerinden';

  @override
  String get chatsStatusOffline => 'çevrimdışı';

  @override
  String get peerKeyRotated => 'anahtar değişti — yeniden doğrulayın';

  @override
  String get peersTitle => 'Yakında';

  @override
  String get peersSubtitle => 'Bluetooth menzilindeki cihazlar';

  @override
  String get peersEmpty => 'Yakındaki cihazlar aranıyor…';

  @override
  String peersHopsOne(int n) {
    return '$n atlama uzakta';
  }

  @override
  String peersHopsOther(int n) {
    return '$n atlama uzakta';
  }

  @override
  String get blePermissionTitle => 'Bluetooth izni gerekli';

  @override
  String get blePermissionHint =>
      'Cubechat, yakındaki kişileri bulmak ve mesaj göndermek için Bluetooth kullanır — internet gerekmez.';

  @override
  String get blePermissionGrant => 'İzin ver';

  @override
  String get blePermissionOpenSettings => 'Ayarları aç';

  @override
  String get blePermissionDeniedHint =>
      'İzin reddedildi. Bluetooth erişimine izin vermek için ayarları açın.';

  @override
  String get bleAdapterOffTitle => 'Bluetooth kapalı';

  @override
  String get bleAdapterOffHint =>
      'Yakındaki cihazları görmek için Bluetooth\'u açın.';

  @override
  String get bleUnsupportedTitle => 'Bluetooth LE kullanılamıyor';

  @override
  String get bleUnsupportedHint =>
      'Bu cihaz veya platform Bluetooth Low Energy desteği sunmuyor. Bir telefonda deneyin.';

  @override
  String get bleScanning => 'Taranıyor…';

  @override
  String get bleRetry => 'Tekrar dene';

  @override
  String get bleEnable => 'Aç';

  @override
  String get bleConnectFailed =>
      'Bağlanılamadı. Cihaz menzil dışında olabilir veya Bluetooth adresi değişmiş olabilir.';

  @override
  String get bleSignal => 'Sinyal';

  @override
  String get bleConnect => 'Bağlan';

  @override
  String get bleConnected => 'Bağlandı';

  @override
  String get bleVerified => 'Doğrulandı';

  @override
  String get editorAdjustBrightness => 'Parlaklık';

  @override
  String get editorAdjustContrast => 'Kontrast';

  @override
  String get editorAdjustSaturation => 'Doygunluk';

  @override
  String get editorToolCrop => 'Kırp';

  @override
  String get editorToolDraw => 'Çiz';

  @override
  String get editorToolAdjust => 'Ayarla';

  @override
  String get editorTabSticker => 'Çıkartma';

  @override
  String get editorTabText => 'Metin';

  @override
  String get editorPenPen => 'Kalem';

  @override
  String get editorPenMarker => 'Fosforlu';

  @override
  String get editorPenNeon => 'Neon';

  @override
  String get editorPenArrow => 'Ok';

  @override
  String get editorPenBlur => 'Bulanık';

  @override
  String get editorPenEraser => 'Silgi';

  @override
  String get editorLevel => 'Düzle';

  @override
  String get editorTextHint => 'Fotoğraftaki metin';

  @override
  String get editorCropFree => 'Serbest';

  @override
  String get editorRemove => 'Kaldır';

  @override
  String get notificationUnknownSender => 'Yeni mesaj';

  @override
  String get bleUnknownPeer => 'Tanımlanamayan cihaz';

  @override
  String get bleBroadcasting => 'Yayında';

  @override
  String bleConnectedCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n merkezi cihaz bağlı',
      one: '1 merkezi cihaz bağlı',
      zero: 'Merkezi cihaz yok',
    );
    return '$_temp0';
  }

  @override
  String get verifyTitle => 'Kişiyi doğrula';

  @override
  String get verifyIntro =>
      'Bu iki parmak izini karşınızdaki kişiyle yüz yüze veya sesli aramada karşılaştırın. Her iki tarafta da eşleşiyorsa Noise el sıkışmasının değiştirilmediğini doğrulamış olursunuz.';

  @override
  String get verifyMine => 'PARMAK İZİNİZ';

  @override
  String verifyTheirs(String name) {
    return '$name PARMAK İZİ';
  }

  @override
  String get verifyMarkAsVerified => 'Doğrulandı olarak işaretle';

  @override
  String get verifyAlreadyDone => 'Bu kişi doğrulandı.';

  @override
  String get verifyRevoke => 'Geri al';

  @override
  String verifyDoneSnack(String name) {
    return '$name doğrulandı olarak işaretlendi';
  }

  @override
  String get chatInputHint => 'Mesaj';

  @override
  String get chatSend => 'Gönder';

  @override
  String get chatToday => 'Bugün';

  @override
  String get chatYesterday => 'Dün';

  @override
  String get chatDelivered => 'İletildi';

  @override
  String get chatRead => 'Okundu';

  @override
  String get chatSending => 'Gönderiliyor';

  @override
  String get chatWaitingForConnection => 'Bağlantı bekleniyor';

  @override
  String sendQueueCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count mesaj bağlantı bekliyor',
      one: '1 mesaj bağlantı bekliyor',
    );
    return '$_temp0';
  }

  @override
  String sendQueueSlowNetwork(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Yavaş ağ — $count mesaj gönderiliyor',
      one: 'Yavaş ağ — 1 mesaj gönderiliyor',
    );
    return '$_temp0';
  }

  @override
  String get sendQueueTitle => 'Gönderilmeyi bekleyenler';

  @override
  String get sendQueueHint =>
      'Bir yol açıldığı anda — yakında Bluetooth ya da internet — kendiliğinden gidecekler. Hiçbir şeye basmanız gerekmez.';

  @override
  String get sendQueueRetry => 'Şimdi dene';

  @override
  String get sendQueueCancel => 'Gönderimi iptal et';

  @override
  String get sendQueueCancelled => 'Gönderilmedi — geri alındı';

  @override
  String get sendQueueTooLate => 'Geri almak için çok geç: mesaj gitti';

  @override
  String get chatEncryptedNotice =>
      'Mesajlar Noise Protokolü ile uçtan uca şifrelenir.';

  @override
  String get chatSessionHandshaking => 'Güvenli kanal kuruluyor…';

  @override
  String get chatSessionEstablished => 'Güvenli · Noise XX';

  @override
  String get chatSessionFailed => 'Bağlantı başarısız';

  @override
  String get presenceOnline => 'çevrimiçi';

  @override
  String get presenceOffline => 'çevrimdışı';

  @override
  String get chatSessionFingerprintPending =>
      'Parmak izi, el sıkışma tamamlanınca görünecek.';

  @override
  String get chatEmptyEstablished =>
      'Güvenli kanal hazır. Sohbeti başlatmak için bir mesaj gönderin.';

  @override
  String get chatEmptyHandshaking =>
      'Karşı tarafın el sıkışmayı tamamlaması bekleniyor…';

  @override
  String get chatEmptyTitle => 'Burada henüz mesaj yok';

  @override
  String get chatEmptyGreetHint =>
      'Bir mesaj yazın ya da selam vermek için Kubi\'ye dokunun.';

  @override
  String get profileTitle => 'Profil';

  @override
  String get profileNickname => 'Takma ad';

  @override
  String get profileNicknameEditTitle => 'Takma adınızı belirleyin';

  @override
  String get profileNicknameHint => 'Mesh ağında başkalarının sizi göreceği ad';

  @override
  String get profileNicknameSave => 'Kaydet';

  @override
  String get profileFingerprint => 'Açık anahtar parmak izi';

  @override
  String get profileLanguage => 'Dil';

  @override
  String get profileLanguageEn => 'İngilizce';

  @override
  String get profileLanguageUk => 'Ukraynaca';

  @override
  String get profileTransport => 'Aktarım';

  @override
  String get profileTransportMesh => 'Bluetooth mesh';

  @override
  String get profileBackground => 'Arka planda erişilebilir kal';

  @override
  String get profileBackgroundSubtitle =>
      'Uygulama kapalıyken de mesaj almaya devam et';

  @override
  String get profileBatteryExempt => 'Pil optimizasyonunu kapat';

  @override
  String get profileAbout => 'Hakkında';

  @override
  String profileVersion(String v) {
    return 'Sürüm $v';
  }

  @override
  String get rotateKeysTitle => 'Hesap anahtarlarını değiştir';

  @override
  String get rotateKeysHint =>
      'Hesabınızın açık olduğu bir cihaz kaybolduysa veya çalındıysa';

  @override
  String get rotateKeysConfirmTitle => 'Hesap anahtarlarınız değiştirilsin mi?';

  @override
  String get rotateKeysConfirmBody =>
      'Kişileriniz yeni anahtarlarınızı alır ve sohbetleri korunur, ancak her birinden anahtarlarınızı yeniden doğrulaması istenir. Hesabınızın diğer tüm cihazlarında oturum kapanır; tutmak istediklerinizi bu telefondan yeniden bağlayın. Eski bir CubeChat sürümünü kullanan kişiler güncelleyene kadar size ulaşamaz. Kanalların anahtarları değişmez.';

  @override
  String get rotateKeysConfirmAction => 'Anahtarları değiştir';

  @override
  String get rotateKeysWorking => 'Anahtarlar değiştiriliyor…';

  @override
  String rotateKeysDone(int sent, int total) {
    return 'Yeni anahtarlar. $total kişiden $sent kişiye bildirildi';
  }

  @override
  String get rotateKeysSlow =>
      'Yeni anahtarlar. Her kişi zamanında onaylamadı; röleler onlar için saklıyor';

  @override
  String get profileEmergencyWipe => 'Acil silme';

  @override
  String get profileEmergencyWipeConfirm => 'Her şey silinsin mi?';

  @override
  String get profileEmergencyWipeConfirmHint =>
      'Kimliğiniz, kişi listeniz ve sohbet geçmişiniz silinecek. Bu işlem geri alınamaz.';

  @override
  String get profileEmergencyWipeAction => 'Sil';

  @override
  String get cancel => 'İptal';

  @override
  String get copy => 'Kopyala';

  @override
  String get copied => 'Kopyalandı';

  @override
  String get channelsNewTitle => 'Yeni kanal';

  @override
  String get channelsNewTooltip => 'Yeni kanal';

  @override
  String get channelNameLabel => 'Kanal adı';

  @override
  String get channelPasswordLabel => 'Şifre (isteğe bağlı)';

  @override
  String get channelJoinAction => 'Katıl';

  @override
  String get channelNameHint =>
      'Aynı adı ve şifreyi giren herkes aynı odaya düşer. Bunların listesini tutan bir sunucu yoktur.';

  @override
  String get channelPasswordHint =>
      'Şifre, anahtarın kendisidir. Şifre yoksa oda, adını bilen yakındaki herkese açıktır.';

  @override
  String get channelSubtitle => 'Grup kanalı · ortak anahtar';

  @override
  String get channelMute => 'Sessize al';

  @override
  String get channelUnmute => 'Sesi aç';

  @override
  String channelMutedUntil(String time) {
    return '$time saatine kadar sessiz';
  }

  @override
  String get channelMuteFor => 'Sessize al…';

  @override
  String channelMuteMinutes(int minutes) {
    return '$minutes dakika';
  }

  @override
  String channelMuteHours(int hours) {
    return '$hours saat';
  }

  @override
  String channelMuteDays(int days) {
    return '$days gün';
  }

  @override
  String get channelMuteForever => 'Ben tekrar açana kadar';

  @override
  String get channelCommunity => 'Yorumlar';

  @override
  String get channelCommunityOpen => 'Tartışmayı aç';

  @override
  String channelCommunitySubtitle(String channel) {
    return '$channel tartışması';
  }

  @override
  String get channelBackToChannel => 'Kanala dön';

  @override
  String get channelMemberActions => 'Üye';

  @override
  String get channelRemoveMember => 'Kanaldan çıkar';

  @override
  String get channelRemoveMemberHint =>
      'Gönderileri artık burada kabul edilmez. Adı bilerek yeniden katılmasını hiçbir şey engellemez — tek üyelik ortak anahtardır.';

  @override
  String get channelMuteMember => 'Sustur…';

  @override
  String get channelUnmuteMember => 'Yeniden yazmasına izin ver';

  @override
  String channelMemberRemoved(String name) {
    return '$name çıkarıldı';
  }

  @override
  String channelMemberMuted(String name) {
    return '$name susturuldu';
  }

  @override
  String channelMemberCleared(String name) {
    return '$name yeniden yazabilir';
  }

  @override
  String get channelMemberMutedNote => 'Susturuldu';

  @override
  String get channelShareHistory => 'Geçmişi paylaş';

  @override
  String get channelShareHistoryHint =>
      'Bu odanın son gönderilerini yeniden yayına koyar; böylece sonradan katılanlar da görebilir. Zaten burada olanlara yeni bir şey gitmez.';

  @override
  String channelHistoryShared(int count) {
    return 'Sunulan gönderi: $count';
  }

  @override
  String get channelHistoryNothing => 'Henüz paylaşılacak bir şey yok';

  @override
  String get channelHistoryAuto => 'Yeni üyelere geçmişi ver';

  @override
  String get channelHistoryAutoHint =>
      'Odada yeni biri belirdiğinde son gönderiler ona kendiliğinden gider. Şimdilik yalnızca metin — fotoğraflar parça parça akışla gider ve herkes için çoğaltılmadan yeniden gönderilemez.';

  @override
  String get channelPostComments => 'Yorumlar';

  @override
  String get channelNoComments =>
      'Bu gönderi hakkında henüz bir şey söylenmedi';

  @override
  String get channelCommentHint => 'Yorum';

  @override
  String get channelMuteCustom => 'Ne kadar süreyle?';

  @override
  String get channelMuteCustomHint => 'Saat';

  @override
  String get chatPinnedManage => 'Sabitlenenler';

  @override
  String get chatPeekOpen => 'Sohbeti aç';

  @override
  String get chatPeekPin => 'Sabitle';

  @override
  String get chatPeekUnpin => 'Sabitlemeyi kaldır';

  @override
  String get chatPeekUnmute => 'Sesi aç';

  @override
  String get chatPeekMarkRead => 'Okundu olarak işaretle';

  @override
  String get chatDeleteForMeHint =>
      'Bu telefondan kaldırılır ve sabitlemesi kaldırılır. Karşı taraftaki kopya kalır.';

  @override
  String get pushWakeTitle => 'Bu telefonu uyandır';

  @override
  String get pushWakeHint =>
      'Küçük bir sunucu, rölelerde adresinizi izler ve bir şey geldiğinde bu telefonu dürter; böylece uygulama kapalıyken de haberiniz olur. Hiçbir mesajı veya anahtarı görmez — yalnızca adresinize bir şey geldiğini ve ne zaman geldiğini bilir. Röle bunu zaten biliyor; bu, bunu bilen ikinci bir yer olur.';

  @override
  String get pushWakeDeniedTitle => 'Bildirimler kapalı';

  @override
  String get pushWakeDeniedHint =>
      'Sisteme bir kez hayır dendi ve bir daha sormayacak; bu yüzden yalnızca Ayarlar\'dan yeniden açılabilir — cubechat, ardından Bildirimler. Sonra buraya dönün.';

  @override
  String get pushWakeRefused => 'Bildirimlere izin verilmedi';

  @override
  String get privacyForwardLinkTitle => 'İletilenlerden profile bağlantı';

  @override
  String get privacyForwardLinkHint =>
      'Biri mesajınızı ilettiğinde, üstündeki satır profilinizi açabilir. Kapalıysa yalnızca adınızı görürler, dokunacak bir şey olmaz. Bu, onların uygulamasına bir ricadır; bu uygulama bunu zorlayamaz.';

  @override
  String get privacyShareSheetTitle => 'Paylaşım menüsünde sohbetler';

  @override
  String get privacyShareSheetOnHint =>
      'Son dört sohbetinizin adları Android\'e verilir; böylece herhangi bir uygulamadan onlara gönderebilirsiniz. Uygulama kilidi bunları gizlemez.';

  @override
  String get privacyShareSheetOffHint =>
      'Android\'e hiçbir şey verilmez. CubeChat\'e paylaşırken sohbeti siz seçersiniz.';

  @override
  String get privacyCallsTitle => 'Aramaları kabul et';

  @override
  String get privacyCallsOnHint =>
      'Kişileriniz sizi arayabilir. Tek bir kişiyi engellemek için profilini açın.';

  @override
  String get privacyCallsOffHint =>
      'Profilinde izin verdikleriniz dışında kimse sizi arayamaz. Reddedilen arama onlara meşgul olarak görünür.';

  @override
  String get chatsStatusChannel => 'kanal';

  @override
  String get channelInviteTitle => 'Kişi ekle';

  @override
  String get channelInviteAction => 'Davet et';

  @override
  String get channelInviteEmpty =>
      'Henüz bilinen kişi yok. Önce Yakında sekmesinde biriyle tanışın.';

  @override
  String get channelInviteSent => 'Davetler gönderildi';

  @override
  String get channelInviteNoneSent => 'Şu an kimseye ulaşılamadı';

  @override
  String get channelNameTooLong => 'Kanal adı çok uzun';

  @override
  String get chatsActionFavorite => 'Favorilere ekle';

  @override
  String get chatsActionUnfavorite => 'Favorilerden çıkar';

  @override
  String get chatsActionDelete => 'Sohbeti sil';

  @override
  String get chatsDeleteTitle => 'Bu sohbet silinsin mi?';

  @override
  String chatsDeleteManyHint(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          '$count sohbet temizlenir. Kişiler kalır; kod değiş tokuşu yapmadan onlara yeniden yazabilirsiniz.',
    );
    return '$_temp0';
  }

  @override
  String get chatsDeletedToast => 'Sohbet silindi.';

  @override
  String chatsDeletedManyToast(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count sohbet silindi.',
      one: '$count sohbet silindi.',
    );
    return '$_temp0';
  }

  @override
  String get undo => 'Geri al';

  @override
  String get chatsDeletePeerHint =>
      'Sohbet temizlenir. Kişi kalır; kod değiş tokuşu yapmadan ona yeniden yazabilirsiniz.';

  @override
  String get chatsDeleteChannelHint =>
      'Kanaldan çıkar ve geçmişini silersiniz. Yeniden katılmak için anahtar yine gerekir.';

  @override
  String get chatsDeleteForThemToo => 'Karşı taraf için de sil';

  @override
  String get chatsDeleteForThemHint =>
      'Onun uygulamasından da, onun yazdıkları dahil tüm sohbeti temizlemesini ister. Kanalda yalnızca kendi mesajlarınız geri çekilir.';

  @override
  String get chatEditAction => 'Düzenle';

  @override
  String get chatEditTitle => 'Mesajı düzenle';

  @override
  String get chatEditSave => 'Kaydet';

  @override
  String get chatEdited => 'düzenlendi';

  @override
  String get chatDeleteAction => 'Sil';

  @override
  String get chatDeleteTitle => 'Mesaj silinsin mi?';

  @override
  String get chatDeleteForMe => 'Benden sil';

  @override
  String get chatDeleteForEveryone => 'Herkesten sil';

  @override
  String get chatPinTitle => 'Mesaj sabitlensin mi?';

  @override
  String get chatPinForBoth => 'İkimiz için sabitle';

  @override
  String get chatPinForMe => 'Yalnızca benim için sabitle';

  @override
  String get chatReplyAction => 'Yanıtla';

  @override
  String chatReplyingTo(String name) {
    return '$name yanıtlanıyor';
  }

  @override
  String get chatReplyYou => 'kendiniz';

  @override
  String get chatCopyAction => 'Kopyala';

  @override
  String get chatCopied => 'Kopyalandı';

  @override
  String get chatForwardAction => 'İlet';

  @override
  String get chatForwardTitle => 'Şuraya ilet';

  @override
  String get shareIntoTitle => 'Şuraya gönder';

  @override
  String get shareNearbyAirDrop => 'AirDrop ile yakındakilere';

  @override
  String get shareNearbyAirDropHint =>
      'İnternet gerekmez — yanınızdaki kişilere';

  @override
  String get shareSent => 'Gönderildi';

  @override
  String get shareFailed => 'Bir kısmı gönderilemedi';

  @override
  String get chatForwardEmpty => 'Henüz başka sohbet yok';

  @override
  String chatForwardSendCount(int count) {
    return 'Gönder ($count)';
  }

  @override
  String chatForwardSentCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count sohbete iletildi',
      one: 'Bir sohbete iletildi',
    );
    return '$_temp0';
  }

  @override
  String chatForwardSent(String name) {
    return '$name sohbetine iletildi';
  }

  @override
  String chatSentAt(String time) {
    return 'Gönderildi: $time';
  }

  @override
  String chatReadAt(String time) {
    return 'Okundu: $time';
  }

  @override
  String get chatPinAction => 'Sabitle';

  @override
  String get chatUnpinAction => 'Sabitlemeyi kaldır';

  @override
  String chatPinnedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count sabitlenmiş mesaj',
      one: '1 sabitlenmiş mesaj',
      zero: 'Sabitlenmiş mesaj yok',
    );
    return '$_temp0';
  }

  @override
  String get chatNoPins => 'Burada sabitlenmiş bir şey yok';

  @override
  String get chatUnpinAll => 'Tüm mesajların sabitlemesini kaldır';

  @override
  String get chatShowAllPins => 'Tüm sabitlenmiş mesajlar';

  @override
  String get chatUnpinConfirm => 'Bu mesajın sabitlemesi kaldırılsın mı?';

  @override
  String get chatUnpinConfirmHint =>
      'Bu sohbetteki herkes için sabitlemesi kaldırılır.';

  @override
  String get chatPinnedTitle => 'Sabitlenmiş mesaj';

  @override
  String get chatPinnedGone => 'Bu mesaj artık bu sohbette yok';

  @override
  String get peerBlock => 'Engelle';

  @override
  String get peerUnblock => 'Engeli kaldır';

  @override
  String get peerMute => 'Sessize al';

  @override
  String get peerUnmute => 'Sesi aç';

  @override
  String get peerBlockedNote => 'Engellendi — mesajları yok sayılıyor.';

  @override
  String get relaysTitle => 'İnternet yedeği';

  @override
  String get relaysCardTitle => 'Kişilere internet üzerinden ulaş';

  @override
  String get relaysCardSubtitle =>
      'Bluetooth iletemediğinde Nostr röleleri üzerinden gönder';

  @override
  String get relaysExplainer =>
      'Mesajlar uçtan uca şifreli kalır — röle yalnızca Bluetooth\'un taşıyacağı mühürlü çerçevenin aynısını taşır. Ancak hangi iki anahtarın ne zaman konuştuğunu öğrenir. Varsayılan olarak kapalıdır.';

  @override
  String get relaysMyAddress => 'Röle adresiniz';

  @override
  String get relaysCopied => 'Kopyalandı';

  @override
  String get circleLensTitle => 'Yuvarlak videolarda ön kamera';

  @override
  String get circleLensFrontHint =>
      'Yuvarlak video mesajlar size bakan kamerayla kaydedilir.';

  @override
  String get circleLensBackHint =>
      'Yuvarlak video mesajlar arka kamerayla kaydedilir; baktığınız şeyi göstermek için.';

  @override
  String get channelCloseTitle => 'Bu odayı herkes için kapat';

  @override
  String get channelCloseSubtitle =>
      'Odayı her üyenin telefonundan kaldırır. Bunu yalnızca siz yapabilirsiniz.';

  @override
  String get channelCloseConfirm =>
      'Oda, mesajları ve üyeleri, bulunduğu her telefondan kaldırılır. Kimse dışarıda bırakılmaz: anahtar addan türetilir, bu yüzden adı hatırlayan herkes boş bir odayı yeniden açabilir.';

  @override
  String get channelCloseAction => 'Odayı kapat';

  @override
  String get circleHint => 'Göndermek için bırakın · iptal için sola kaydırın';

  @override
  String get circleHintLocked => 'Bitirince gönder\'e dokunun';

  @override
  String get circleNeedsCamera =>
      'Yuvarlak videolar için kamera ve mikrofon gerekir';

  @override
  String get circleFailed => 'Yuvarlak video kaydedilemedi';

  @override
  String get relaysListLabel => 'Röleler';

  @override
  String get relaysLaneMedia => 'Medya röleleri';

  @override
  String get relaysLaneMediaNote =>
      'Fotoğraflar, dosyalar ve videolar bunlar üzerinden gider; böylece bir aktarım sohbeti yavaşlatmaz.';

  @override
  String get relaysLaneLocation => 'Konum röleleri';

  @override
  String get relaysLaneLocationNote =>
      'Harita işaretleri, diğer her şeyden ayrı olarak bunlar üzerinden gider.';

  @override
  String get relaysAdd => 'Röle ekle';

  @override
  String get relaysAddHint => 'wss://relay.example.com';

  @override
  String get relaysInvalidUrl => 'Bir wss:// veya ws:// adresi girin';

  @override
  String get relaysRemove => 'Kaldır';

  @override
  String get relaysStateConnected => 'Bağlı';

  @override
  String get relaysStateConnecting => 'Bağlanıyor…';

  @override
  String get relaysStateFailed => 'Ulaşılamıyor';

  @override
  String get relaysStateIdle => 'Kapalı';

  @override
  String get relaysEmpty =>
      'Yapılandırılmış röle yok — internet yedeği kapalı kalır.';

  @override
  String get contactTitle => 'Kişi kartı';

  @override
  String get contactMineLabel => 'Kartınız';

  @override
  String get contactMineExplainer =>
      'Bunu Bluetooth menzili dışındaki birine gönderin. Anahtarlarınızı ve röle adresinizi içerir — sizinle internet üzerinden şifreli bir sohbet başlatması için yeterlidir.';

  @override
  String get contactCopy => 'Kopyala';

  @override
  String get contactShare => 'Paylaş';

  @override
  String get contactCopied => 'Kart kopyalandı';

  @override
  String get contactShareSubject => 'cubechat kişi kartım';

  @override
  String get contactAddLabel => 'Birini ekle';

  @override
  String get contactAddHint => 'Bir kişi kartı yapıştırın';

  @override
  String get contactAddAction => 'Ekle';

  @override
  String get contactPaste => 'Yapıştır';

  @override
  String contactAdded(String name) {
    return '$name eklendi';
  }

  @override
  String get contactInvalid => 'Bu geçerli bir kişi kartı değil';

  @override
  String get contactOwnCard => 'Bu sizin kendi kartınız';

  @override
  String get contactUnverified =>
      'Bu şekilde eklenen kişi doğrulanmamış olarak başlar. Herkes bir kart oluşturup üzerine istediği adı yazabilir; bu yüzden kimliğe güvenmeden önce parmak izlerini yüz yüze veya bir aramada karşılaştırın.';

  @override
  String get contactRelayOff =>
      'İnternet yedeği kapalı; bu yüzden kart henüz kimseye ulaşamaz.';

  @override
  String get contactRelayEnable => 'Aç';

  @override
  String get profileContactCard => 'Kişi kartı';

  @override
  String get chatsAddContactTooltip => 'Kartla kişi ekle';

  @override
  String get chatsMenuTooltip => 'Diğer';

  @override
  String get chatsMenuAddContact => 'Kişi ekle';

  @override
  String get chatsMenuNewChannel => 'Yeni kanal';

  @override
  String get profileDiscoverable => 'Yakındakiler bulabilsin';

  @override
  String get profileDiscoverableOnHint => 'Menzildeki herkes sizi bulabilir';

  @override
  String get profileDiscoverableOffHint =>
      'Size yalnızca kişileriniz ulaşabilir';

  @override
  String get profileDiscoverableExplainer =>
      'Açıkken duyurunuz açık olarak yayınlanır; yabancılar yanınıza gelerek sizinle tanışabilir — ama dinleyen herkes anahtarınızı ve adınızı kaydeder. Kapalıyken aynı paket yalnızca mevcut kişilerinize mühürlü olarak gider ve yönlendirme kimlikleriniz birbirine bağlanamaz. Yeni kişilerin o zaman bir kişi kartına ihtiyacı olur.';

  @override
  String get voiceHoldHint => 'Sesli mesaj kaydetmek için basılı tutun';

  @override
  String get voiceTrimPlay => 'Oynat';

  @override
  String get voiceTrimPause => 'Duraklat';

  @override
  String get voiceTrimDiscard => 'Kaydı sil';

  @override
  String voiceTrimSelection(String duration) {
    return '$duration gönderiliyor';
  }

  @override
  String get profileLastSeen => 'Son görülmeyi paylaş';

  @override
  String get profileLastSeenOnHint =>
      'Kişiler uygulamada olduğunuz zamanı görebilir';

  @override
  String get profileLastSeenOffHint =>
      'Kimse sizin zamanınızı görmez, siz de kimseninkini görmezsiniz: yalnızca kimin çevrimiçi olduğunu';

  @override
  String get profileMapLocation => 'Beni haritada göster';

  @override
  String get profileMapLocationOnHint =>
      'Konum elle paylaşım için kullanılabilir ve işaretiniz haritada gösterilir';

  @override
  String get profileMapLocationOffHint =>
      'Uygulama konum istemez ve işaretiniz gizli kalır';

  @override
  String get desktopAutostartTitle => 'Windows ile başlat';

  @override
  String get desktopAutostartHint =>
      'CubeChat sistem tepsisinde bekler; böylece pencere kapalıyken de aramalar ve mesajlar bu bilgisayara ulaşır';

  @override
  String get trayOpen => 'CubeChat\'i aç';

  @override
  String get trayQuit => 'Çık';

  @override
  String get callDirectTitle => 'Doğrudan aramalar';

  @override
  String get callDirectOnHint =>
      'Daha hızlı, ancak aradığınız kişi IP adresinizi öğrenir';

  @override
  String get callDirectOffHint =>
      'Aramalar bizim rölemiz üzerinden gider: aradığınız kişi IP adresinizi hiç görmez, röle de aramayı duyamaz';

  @override
  String get profileReadReceipts => 'Okundu bilgisini paylaş';

  @override
  String get profileReadReceiptsOnHint =>
      'Gönderenler mesajlarını okuduğunuzu görür';

  @override
  String get profileReadReceiptsOffHint =>
      'Okuma zamanınızı göndermezsiniz, ama başkalarınınkini görmeye devam edersiniz';

  @override
  String get profilePrivacyExplainer =>
      'Son görülme iki yönlü çalışır: kendi durumunuzu gizlerseniz başkalarınınkini de görmezsiniz. Okundu bilgisi yalnızca sizin gönderdiğinizi denetler. Mesaj iletimi etkilenmez.';

  @override
  String get chatTimerAction => 'Zamanlayıcı';

  @override
  String get chatTimerRemove => 'Zamanlayıcıyı kaldır';

  @override
  String get chatTimerTitle => 'Bu mesajı şu süre sonra sil';

  @override
  String chatTimerSet(String time) {
    return 'Bu mesaj $time sonra silinecek';
  }

  @override
  String get chatTimerLocalHint =>
      'Yalnızca bu cihazda — onların kopyası onlara ait';

  @override
  String get contactTagAction => 'Etiket';

  @override
  String get contactTagRemove => 'Etiketi kaldır';

  @override
  String get contactTagTitle => 'Bir etiket seçin';

  @override
  String get contactTagAll => 'Tümü';

  @override
  String get quietHoursTitle => 'Sessiz saatler';

  @override
  String get quietHoursHint => 'Mesajlar yine gelir; telefon sessiz kalır';

  @override
  String get quietHoursFrom => 'Başlangıç';

  @override
  String get quietHoursTo => 'Bitiş';

  @override
  String get notifPreviewTitle => 'Bildirimlerde göster';

  @override
  String get notifPreviewFull => 'Ad ve metin';

  @override
  String get notifPreviewNameOnly => 'Yalnızca ad';

  @override
  String get notifPreviewHidden => 'Hiçbir şey';

  @override
  String get notifPreviewHint =>
      'Bildirimler, uygulama kilidi açıkken bile kilit ekranında ve bildirim erişimi olan uygulamalarda görünür';

  @override
  String get notifPreviewNewMessage => 'Yeni mesaj';

  @override
  String get appLockTitle => 'Uygulama kilidi';

  @override
  String get appLockHint => 'Uygulama açılırken kod iste';

  @override
  String get appLockPrompt => 'Kodunuzu girin';

  @override
  String get appLockUnlock => 'Kilidi aç';

  @override
  String get appLockWrong => 'Yanlış kod';

  @override
  String get appLockSetTitle => 'Kod belirleyin';

  @override
  String get appLockSetHint =>
      'Dört veya daha fazla rakam. Kurtarmanın bir yolu yoktur.';

  @override
  String get appLockOffTitle => 'Kilidi kapat';

  @override
  String get appLockOffHint => 'Mevcut kodunuzu girin';

  @override
  String get appLockOn => 'Uygulama kilidi açık';

  @override
  String get appLockOff => 'Uygulama kilidi kapalı';

  @override
  String get avatarSet => 'Fotoğraf seç';

  @override
  String get avatarChange => 'Fotoğrafı değiştir';

  @override
  String get avatarView => 'Fotoğrafı görüntüle';

  @override
  String get profileCoverPhoto =>
      'Profil fotoğrafı, büyütmek için iki kez dokunun';

  @override
  String get profileCoverMenu => 'Fotoğraf seçenekleri';

  @override
  String get avatarSaved => 'Galeriye kaydedildi';

  @override
  String get avatarRemove => 'Fotoğrafı kaldır';

  @override
  String get avatarRemoveConfirm =>
      'Profil fotoğrafı bu cihazdan silinecek. Yerine oluşturulan renk geçişi geri gelir.';

  @override
  String get avatarFailed => 'Bu görsel okunamadı';

  @override
  String get fileOpenHint => 'Açmak için dokunun';

  @override
  String get fileMissing => 'Bu dosya artık mevcut değil';

  @override
  String get fileNoHandlerTitle => 'Bunu açabilecek uygulama yok';

  @override
  String get fileNoHandlerHint =>
      'Yüklü hiçbir uygulama bu dosya türünü açamıyor. Bunun yerine başka bir uygulamaya gönderebilirsiniz.';

  @override
  String get fileRequestedAgain => 'Gönderenden yeniden istendi';

  @override
  String get fileOpenFailed => 'Bu dosya açılamadı';

  @override
  String get fileShareAction => 'Uygulamaya gönder';

  @override
  String fileTooLargeMesh(int limit) {
    return 'Dosya çok büyük — mesh üzerinden sınır $limit MB';
  }

  @override
  String fileTooLargeRelay(int limit) {
    return 'İnternet üzerinden sınır $limit MB. Daha büyük bir dosya göndermek için alıcıya yaklaşın.';
  }

  @override
  String get mediaSendOriginal => 'Orijinal';

  @override
  String get attachFile => 'Dosya';

  @override
  String get attachGallery => 'Galeri';

  @override
  String get attachCamera => 'Kamera';

  @override
  String get cameraUnavailable => 'Kamera kullanılamıyor';

  @override
  String get profileEditName => 'Ad';

  @override
  String get profileMyCard => 'Kart';

  @override
  String get mediaCaptionHint => 'Açıklama ekle…';

  @override
  String get mediaDiscardTitle => 'Seçim iptal edilsin mi?';

  @override
  String get mediaDiscardMessage =>
      'Galeri kapatılsın ve seçilen fotoğraflar iptal edilsin mi?';

  @override
  String get mediaDiscardConfirm => 'İptal et';

  @override
  String get mediaPhotosAccessOff => 'Fotoğraf erişimi kapalı';

  @override
  String get mediaPhotosAccessOffHint =>
      'CubeChat şu an yalnızca videoları görebiliyor. Resimlerinizi göstermek için sistem ayarlarından fotoğraf erişimine izin verin.';

  @override
  String get mediaVideosOnly =>
      'Yalnızca videolar görünüyor — fotoğraf erişimine izin verin';

  @override
  String get mediaOpenSettings => 'Ayarları aç';

  @override
  String get mediaTakePhoto => 'Fotoğraf çek';

  @override
  String get contactProfileAutoDelete => 'Sohbeti otomatik sil';

  @override
  String get contactProfileAutoDeleteTitle => 'Mesajları otomatik sil';

  @override
  String get contactProfileAutoDeleteOff => 'Kapalı';

  @override
  String get contactProfileAutoDeleteOneDay => '1 gün sonra';

  @override
  String get contactProfileAutoDeleteSevenDays => '7 gün sonra';

  @override
  String get contactProfileAutoDeleteThirtyDays => '30 gün sonra';

  @override
  String contactProfileAutoDeleteUpdated(String period) {
    return 'Otomatik silme: $period';
  }

  @override
  String get contactProfileShare => 'Kişiyi paylaş';

  @override
  String get contactProfileShareTitle => 'Kişiyi şuraya gönder';

  @override
  String get contactProfileShareEmpty => 'Henüz başka sohbet yok';

  @override
  String contactProfileShareSent(String name) {
    return '$name sohbetine gönderildi';
  }

  @override
  String get contactProfileRestrictCopying => 'Kopyalamayı kapat';

  @override
  String get contactProfileAllowCopying => 'Kopyalamaya izin ver';

  @override
  String get contactHideAvatar => 'Fotoğrafımı gizle';

  @override
  String get contactShowAvatar => 'Fotoğrafımı göster';

  @override
  String get contactHideLastSeen => 'Son görülmemi gizle';

  @override
  String get contactShowLastSeen => 'Son görülmemi göster';

  @override
  String get contactHideReadReceipts => 'Okuma zamanlarımı gizle';

  @override
  String get contactShowReadReceipts => 'Okuma zamanlarımı göster';

  @override
  String get contactHiddenFromThem => 'Bu kişiden gizlendi';

  @override
  String get contactRefuseCalls => 'Aramalarını kabul etme';

  @override
  String get contactAllowCalls => 'Aramalarını kabul et';

  @override
  String get contactCallsException => 'Arama ayarınıza bir istisna';

  @override
  String get contactProfileCopyingRestricted => 'Kopyalama ve iletme kapalı';

  @override
  String get contactProfileCopyingRestrictedByPeer => 'Karşı taraf kapattı';

  @override
  String get contactProfileCopyingAllowed =>
      'Kopyalama ve iletmeye izin veriliyor';

  @override
  String get contactProfileDelete => 'Kişilerden sil';

  @override
  String get contactProfileRestore => 'Kişilere geri ekle';

  @override
  String get contactProfileRestoreDone => 'Yeniden kişilerinizde';

  @override
  String get contactProfileDeleteTitle => 'Kişi kaldırılsın mı?';

  @override
  String contactProfileDeleteMessage(String name) {
    return '$name Kişiler\'den kaldırılacak. Sohbet geçmişi bu cihazda kalır.';
  }

  @override
  String get contactProfileMedia => 'Medya';

  @override
  String get contactProfileVoiceMessages => 'Sesli mesajlar';

  @override
  String get contactProfileStickers => 'Çıkartmalar';

  @override
  String get contactProfileNoStickers => 'Henüz çıkartma yok';

  @override
  String get contactProfileNoMedia => 'Henüz medya yok';

  @override
  String get contactProfileNoVoiceMessages => 'Henüz sesli mesaj yok';

  @override
  String get contactProfileOpen => 'Profili aç';

  @override
  String autoDeleteDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count gün',
      one: '$count gün',
    );
    return '$_temp0';
  }

  @override
  String autoDeleteHours(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count saat',
      one: '$count saat',
    );
    return '$_temp0';
  }

  @override
  String autoDeleteMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dakika',
      one: '$count dakika',
    );
    return '$_temp0';
  }

  @override
  String autoDeleteSeconds(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count saniye',
      one: '$count saniye',
    );
    return '$_temp0';
  }

  @override
  String get autoDeleteCustom => 'Özel…';

  @override
  String get autoDeleteCustomHint => 'Miktar';

  @override
  String get autoDeleteUnitMinutes => 'dk';

  @override
  String get autoDeleteUnitHours => 'saat';

  @override
  String get autoDeleteUnitDays => 'gün';

  @override
  String get contactProfileAutoDeleteSet => 'Ayarla';

  @override
  String get contactProfileFiles => 'Dosyalar';

  @override
  String get contactProfileNoFiles => 'Henüz dosya yok';

  @override
  String get contactProfileLinks => 'Bağlantılar';

  @override
  String get contactProfileNoLinks => 'Henüz bağlantı yok';

  @override
  String get contactProfilePolls => 'Anketler';

  @override
  String get contactProfileNoPolls => 'Henüz anket yok';

  @override
  String get presenceRecently => 'yakın zamanda görüldü';

  @override
  String get presenceJustNow => 'az önce';

  @override
  String presenceHoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count saat önce görüldü',
      one: '$count saat önce görüldü',
    );
    return '$_temp0';
  }

  @override
  String presenceYesterdayAt(String time) {
    return 'dün $time saatinde görüldü';
  }

  @override
  String presenceOnWeekday(String day) {
    String _temp0 = intl.Intl.selectLogic(
      day,
      {
        '1': 'pazartesi görüldü',
        '2': 'salı görüldü',
        '3': 'çarşamba görüldü',
        '4': 'perşembe görüldü',
        '5': 'cuma görüldü',
        '6': 'cumartesi görüldü',
        '7': 'pazar görüldü',
        'other': 'bu hafta görüldü',
      },
    );
    return '$_temp0';
  }

  @override
  String presenceWeeksAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count hafta önce görüldü',
      one: 'bir hafta önce görüldü',
    );
    return '$_temp0';
  }

  @override
  String presenceMonthsAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ay önce görüldü',
      one: 'bir ay önce görüldü',
    );
    return '$_temp0';
  }

  @override
  String get presenceLongAgo => 'uzun zaman önce görüldü';

  @override
  String presenceMinutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dakika önce görüldü',
      one: '$count dakika önce görüldü',
    );
    return '$_temp0';
  }

  @override
  String chatReadByCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count kişi okudu',
      one: '$count kişi okudu',
    );
    return '$_temp0';
  }

  @override
  String get chatsSearchFrequent => 'Konuştuğunuz kişiler';

  @override
  String get chatsSearchRecent => 'Son aramalar';

  @override
  String get chatsSearchClear => 'Temizle';

  @override
  String get chatsSearchStartHint =>
      'Sohbetleri adıyla, mesajları içindeki kelimelerle arayın.';

  @override
  String get chatsSearchEmpty => 'Eşleşen bir şey yok';

  @override
  String get chatRoutesTitle => 'Bu ona nasıl ulaşır';

  @override
  String get chatRoutesBluetoothHint => 'Doğrudan telefonuna, internet olmadan';

  @override
  String get chatRoutesMeshHint => 'Aradaki telefonlar üzerinden aktarılır';

  @override
  String get chatRoutesInternetHint =>
      'Menzilde kimse yoksa bir röle üzerinden';

  @override
  String get chatRoutesHint =>
      'Yol her mesaj için ayrı seçilir; o anda neye ulaşılabiliyorsa ondan.';

  @override
  String get chatRoutesPreferTitle => 'Önce ne denensin';

  @override
  String get chatRoutesPreferMesh => 'Önce Bluetooth';

  @override
  String get chatRoutesPreferMeshHint =>
      'Aynı odada daha hızlı, veri harcamaz, röleye hiçbir şey söylemez';

  @override
  String get chatRoutesPreferRelay => 'Önce internet';

  @override
  String get chatRoutesPreferRelayHint => 'Bluetooth zayıf, bağlantı iyiyse';

  @override
  String get chatRoutesPreferNote =>
      'Bu bir tercih, kilit değil. Seçtiğiniz yola ulaşılamazsa mesaj diğer yoldan yine gider.';

  @override
  String get deadmanTitle => 'Kullanılmazsa sil';

  @override
  String get deadmanOff => 'Kapalı';

  @override
  String deadmanDays(int days) {
    return '$days gün sonra';
  }

  @override
  String get deadmanHint =>
      'Uygulama bu kadar süre açılmazsa, bir sonraki açılışta içindeki her şey silinir. Önceden uyaramaz — amacı da budur.';

  @override
  String chatForwardedFrom(String name) {
    return '$name kişisinden iletildi';
  }

  @override
  String appLockWait(String left) {
    return 'Çok fazla deneme — $left bekleyin';
  }

  @override
  String get appLockGraceTitle => 'Kodu iste';

  @override
  String get appLockGraceNow => 'Her seferinde';

  @override
  String appLockGraceAfter(String left) {
    return '$left uzak kalınca';
  }

  @override
  String get chatCalendarTitle => 'Tarihe göre';

  @override
  String get chatCalendarEmpty => 'Burada henüz bir şey söylenmedi';

  @override
  String get chatsSearchChatsSection => 'Sohbetler';

  @override
  String get chatsSearchMessagesSection => 'Mesajlar';

  @override
  String get contactProfileViewInChat => 'Sohbette göster';

  @override
  String get chatDraft => 'Taslak';

  @override
  String get chatSearchTitle => 'Ara';

  @override
  String get chatSearchHint => 'Mesajlarda ara';

  @override
  String get chatSearchNoResults => 'Eşleşme yok';

  @override
  String get chatSearchPrevious => 'Önceki sonuç';

  @override
  String get chatSearchNext => 'Sonraki sonuç';

  @override
  String chatMessageCount(int count) {
    return '$count mesaj';
  }

  @override
  String get chatRouteBluetooth => 'Bluetooth';

  @override
  String get chatRouteMesh => 'Mesh';

  @override
  String get chatRouteInternet => 'İnternet';

  @override
  String get chatRouteQueued => 'Sırada';

  @override
  String get attachStickers => 'Çıkartmalar';

  @override
  String get stickersEmpty => 'Henüz çıkartma yok';

  @override
  String get stickersEmptyHint =>
      'Bir sohbetten bir resmi saklayın, burada görünür.';

  @override
  String get stickerKeep => 'Çıkartma olarak kaydet';

  @override
  String get stickerKept => 'Çıkartmalarınıza kaydedildi';

  @override
  String get stickerForget => 'Çıkartmayı kaldır';

  @override
  String get stickerCreate => 'Fotoğraftan çıkartma yap';

  @override
  String get stickerFailed => 'Bu resimden çıkartma yapılamadı';

  @override
  String get stickerLabel => 'Çıkartma';

  @override
  String get previewPhoto => 'Fotoğraf';

  @override
  String get previewVoice => 'Sesli mesaj';

  @override
  String get previewFile => 'Dosya';

  @override
  String get stickerEmojiTitle => 'Bunun için bir emoji seçin';

  @override
  String get stickersMine => 'Çıkartmalarım';

  @override
  String get stickersStarterPack => 'Cubi';

  @override
  String get emojiTab => 'Emoji';

  @override
  String get chatBlockedStatus => 'engellendi';

  @override
  String get chatBlockedHint => 'Bu kişiyi engellediniz';

  @override
  String get chatRouteFallbackOff => 'İnternet kapalı';

  @override
  String get chatAttachmentUnavailable =>
      'Kullanılabilir bağlantı yok. Bluetooth veya internet üzerinden bağlanıp tekrar deneyin.';

  @override
  String get fileTransfersTitle => 'Dosya aktarımları';

  @override
  String get fileTransfersClear => 'Geçmişi temizle';

  @override
  String get fileTransfersEmpty => 'Henüz dosya aktarımı yok';

  @override
  String get fileTransfersActive => 'Etkin';

  @override
  String get fileTransfersHistory => 'Geçmiş';

  @override
  String get fileTransferPause => 'Duraklat';

  @override
  String get fileTransferResume => 'Devam et';

  @override
  String get fileTransferRetry => 'Tekrar dene';

  @override
  String get fileTransferQueued => 'Bağlantı bekleniyor';

  @override
  String get fileTransferRunning => 'Aktarılıyor';

  @override
  String get fileTransferPaused => 'Duraklatıldı';

  @override
  String get fileTransferCompleted => 'Tamamlandı';

  @override
  String get fileTransferFailed => 'Başarısız';

  @override
  String get fileTransferCanceled => 'İptal edildi';

  @override
  String get profileFileTransfers => 'Dosya aktarımları';

  @override
  String get profileFileTransfersSubtitle =>
      'İlerleme, sıra ve aktarım geçmişi';

  @override
  String get qrScanAction => 'QR kodu tara';

  @override
  String get qrScanTitle => 'QR kodu tara';

  @override
  String get qrScanHint =>
      'Bir CubeChat kişi, kanal, hesap taşıma veya bilgisayar giriş kodu tarayın.';

  @override
  String get qrFlash => 'El feneri';

  @override
  String get qrCameraError =>
      'Kamera kullanılamıyor. Kamera iznini kontrol edip tekrar deneyin.';

  @override
  String get qrInvalid => 'Bu geçerli bir Cubechat QR kodu değil.';

  @override
  String qrChannelAdded(String name) {
    return '$name eklendi';
  }

  @override
  String get qrShow => 'QR kodu göster';

  @override
  String qrChannelTitle(String name) {
    return '$name kanalına katıl';
  }

  @override
  String get profileBackup => 'Şifreli yedek';

  @override
  String get profileBackupSubtitle =>
      'Anahtarları, kişileri ve geçmişi güvenle taşıyın';

  @override
  String get backupTitle => 'Şifreli yedek';

  @override
  String get backupExplainer =>
      'Yedek; özel kimlik anahtarlarınızı, kişilerinizi, kanallarınızı, ayarlarınızı ve mesaj geçmişinizi içerir. Seçtiğiniz şifreyle bu telefonda şifrelenir; Cubechat unutulan bir şifreyi kurtaramaz.';

  @override
  String get backupCreate => 'Yedek oluştur';

  @override
  String get backupCreateSubtitle =>
      'Her şeyi şifreleyip bir .cchatbackup dosyası kaydet';

  @override
  String get backupRestore => 'Yedeği geri yükle';

  @override
  String get backupRestoreSubtitle =>
      'Bu telefondaki Cubechat profilini bir yedek dosyasıyla değiştir';

  @override
  String get backupPasswordTitle => 'Yedek şifresi';

  @override
  String get backupPasswordHint => 'En az 8 karakter';

  @override
  String get backupConfirmPassword => 'Şifreyi tekrarlayın';

  @override
  String get backupPasswordMismatch => 'Şifreler eşleşmiyor';

  @override
  String get backupPasswordShort => 'En az 8 karakter kullanın';

  @override
  String get backupSaveTitle => 'Cubechat yedeğini kaydet';

  @override
  String get backupSaved => 'Şifreli yedek kaydedildi';

  @override
  String get backupWhereTitle => 'Yedek nereye kaydedilsin?';

  @override
  String get backupSaveToFiles => 'Dosyalar\'a kaydet';

  @override
  String get backupSaveToFilesHint =>
      'Bu telefondaki bir klasör, bellek kartı veya bulut sürücü';

  @override
  String get backupSendToApp => 'Bir uygulamaya gönder';

  @override
  String get backupSendToAppHint =>
      'Telegram, e-posta, bir mesajlaşma uygulaması — dosya alan herhangi biri';

  @override
  String get backupFailed => 'Yedekleme işlemi tamamlanamadı';

  @override
  String get backupRestoreConfirmTitle => 'Bu profil değiştirilsin mi?';

  @override
  String get backupRestoreConfirmMessage =>
      'Bu telefondaki mevcut anahtarlar, kişiler, kanallar, ayarlar ve geçmiş, seçilen yedekle değiştirilecek.';

  @override
  String get backupRestoreConfirmAction => 'Geri yükle';

  @override
  String get backupRestored => 'Yedek geri yüklendi';

  @override
  String get backupPackingWait => 'Yedek oluşturuluyor…';

  @override
  String get backupUnpackingWait => 'Yedek geri yükleniyor…';

  @override
  String get backupWaitHint =>
      'Fotoğraf ve videolarla bu birkaç dakika sürebilir. Uygulamayı açık tutun.';

  @override
  String get backupInvalid =>
      'Yanlış şifre, bozuk dosya veya desteklenmeyen yedek';

  @override
  String get channelInfoTitle => 'Kanal bilgileri';

  @override
  String get channelParticipantsTitle => 'Katılımcılar';

  @override
  String get channelAdministratorsTitle => 'Yöneticiler';

  @override
  String get channelMakeAdmin => 'Yönetici yap';

  @override
  String get channelRemoveAdmin => 'Yöneticilikten çıkar';

  @override
  String get channelNoParticipants =>
      'Katılımcılar imzalı etkinlikten sonra görünür';

  @override
  String get channelSharedContent => 'Medya, dosyalar ve anketler';

  @override
  String get channelDescriptionTitle => 'Açıklama';

  @override
  String get channelDescriptionEmpty => 'Henüz açıklama yok';

  @override
  String get channelDescriptionHint => 'Bu kanal ne için';

  @override
  String get channelDescriptionAdminOnly =>
      'Açıklamayı yalnızca bir yönetici değiştirebilir';

  @override
  String get channelDescriptionSave => 'Kaydet';

  @override
  String get channelPrivateSubtitle => 'özel kanal';

  @override
  String get channelAvatarSet => 'Yeni fotoğraf ayarla';

  @override
  String get channelSettingsTitle => 'Kanal ayarları';

  @override
  String get channelSettingsHint => 'Kimler yazabilir, kopyalama, geçmiş';

  @override
  String get channelLeaveAction => 'Ayrıl';

  @override
  String get channelLeaveConfirm =>
      'Oda ve içinde söylenen her şey bu telefondan kaldırılır. Anahtar addan türetilir; aynı adı yazarak odayı yeniden açabilirsiniz.';

  @override
  String get channelShareAction => 'Paylaş';

  @override
  String channelMembersOf(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count üye',
      one: '1 üye',
    );
    return '$_temp0';
  }

  @override
  String get chatTyping => 'yazıyor…';

  @override
  String get chatRecordingVoice => 'sesli mesaj kaydediyor…';

  @override
  String get chatRecordingCircle => 'görüntülü mesaj kaydediyor…';

  @override
  String get chatSendingPhoto => 'fotoğraf gönderiyor…';

  @override
  String get chatSendingVideo => 'video gönderiyor…';

  @override
  String get chatSendingFile => 'dosya gönderiyor…';

  @override
  String get onboardingMeshTitle => 'İnternetsiz çalışır';

  @override
  String get onboardingMeshBody =>
      'Mesajlar Bluetooth üzerinden telefondan telefona gider. Şebeke yok, Wi-Fi yok, hesap yok — yalnızca çevrenizdeki insanlar.';

  @override
  String get onboardingRelayTitle => 'Varsa internetle de';

  @override
  String get onboardingRelayBody =>
      'Bluetooth menzili dışında mesajlar internetten gider ve aynı şekilde ulaşır. Hangisi olacağını siz seçmezsiniz.';

  @override
  String get onboardingPrivacyTitle => 'Aradaki kimse okuyamaz';

  @override
  String get onboardingPrivacyBody =>
      'Her şey uçtan uca şifrelenir ve kimliğiniz bu telefondaki bir anahtardır — telefon numarası değil, e-posta değil, birinin elinizden alabileceği bir hesap değil.';

  @override
  String get onboardingSkip => 'Atla';

  @override
  String get onboardingNext => 'İleri';

  @override
  String get onboardingStart => 'Başla';

  @override
  String get chatMediaShare => 'Paylaş';

  @override
  String get chatMediaSaveToGallery => 'Galeriye kaydet';

  @override
  String get chatMediaShowInChat => 'Sohbette göster';

  @override
  String get chatWallpaperTitle => 'Duvar kağıdı';

  @override
  String get chatWallpaperClear => 'Sıfırla';

  @override
  String get chatWallpaperDim => 'Mesajların arkasını karart';

  @override
  String get chatSelectAction => 'Seç';

  @override
  String get chatForwardNothing => 'Burada iletilebilecek bir şey yok';

  @override
  String chatSelectedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count seçildi',
      one: '1 seçildi',
    );
    return '$_temp0';
  }

  @override
  String chatDeleteSelectedTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count mesaj silinsin mi?',
      one: 'Bu mesaj silinsin mi?',
    );
    return '$_temp0';
  }

  @override
  String get contactAliasAction => 'Kişiyi yeniden adlandır';

  @override
  String get contactAliasHint =>
      'Bu adı yalnızca siz görürsünüz. Kendi adını kullanmak için boş bırakın.';

  @override
  String get viewOnceSendLabel => 'Tek görüntüleme';

  @override
  String get viewOnceTitle => 'Tek görüntüleme';

  @override
  String get viewOnceTapToView => 'Fotoğraf · bir kez görmek için dokunun';

  @override
  String get viewOnceSent => 'Fotoğraf · gönderildi';

  @override
  String get viewOnceOpened => 'Fotoğraf açıldı';

  @override
  String get viewOnceUnavailable => 'Bu fotoğraf artık mevcut değil';

  @override
  String get viewOnceWarning =>
      'Bunu kapatınca fotoğraf ikiniz için de silinir.';

  @override
  String get channelAvatarAdminOnly =>
      'Kanal fotoğrafını yalnızca bir yönetici değiştirebilir';

  @override
  String get channelAdminOnly => 'Bunu yalnızca bir yönetici değiştirebilir';

  @override
  String get channelAvatarTooLarge => 'Bu fotoğraf yayınlamak için çok büyük';

  @override
  String get channelMemberUnknown => 'Henüz kişilerinizde değil';

  @override
  String get channelInviteToContacts => 'Ona kişi kartınızı gönderin';

  @override
  String channelContactInviteSent(String name) {
    return 'Kişi kartı $name kişisine sunuldu';
  }

  @override
  String get chatContactInvitation => 'Bağlantı daveti';

  @override
  String get chatContactInvitationForYou => 'Size bir davet';

  @override
  String get channelPollTitle => 'Anket';

  @override
  String get channelCreatePoll => 'Anket oluştur';

  @override
  String get channelPollQuestion => 'Soru';

  @override
  String channelPollOption(int number) {
    return 'Seçenek $number';
  }

  @override
  String get channelPollAddOption => 'Seçenek ekle';

  @override
  String get channelPollCreate => 'Anketi yayınla';

  @override
  String channelPollVotes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count oy',
      one: '1 oy',
      zero: 'Oy yok',
    );
    return '$_temp0';
  }

  @override
  String get phoneTransferTitle => 'Yeni telefona taşı';

  @override
  String get desktopPickChat => 'Kime yazmak istediğinizi seçin';

  @override
  String get desktopListCollapse => 'Yalnızca fotoğrafları göster';

  @override
  String get desktopListExpand => 'Sohbet listesini göster';

  @override
  String get desktopLinkConnectTitle => 'Bilgisayar bağla';

  @override
  String get desktopLinkConnectHint =>
      'CubeChat\'in bilgisayarda gösterdiği kodu tarayın';

  @override
  String get desktopLinkSignIn => 'Telefonumun hesabıyla giriş yap';

  @override
  String get desktopLinkTitle => 'Telefonunuzla giriş yapın';

  @override
  String get desktopLinkSteps =>
      'Telefonda: Profil → Veriler → Bilgisayar bağla, ardından bu kodu tarayın. İkisi de aynı Wi-Fi ağında olmalı.';

  @override
  String get desktopLinkLimits =>
      'Telefon çalışmaya devam eder. İnternetten gelen mesajlar ikisine de ulaşır; birinden gönderdiğiniz şey henüz diğerinde görünmez.';

  @override
  String get desktopLinkWaiting => 'Telefon bekleniyor…';

  @override
  String get desktopLinkFailed => 'Hesap alınamadı. Tekrar deneyin.';

  @override
  String get desktopLinkRetry => 'Tekrar dene';

  @override
  String get desktopLinkConfirmTitle =>
      'Bu hesabın bir kopyası bilgisayara gönderilsin mi?';

  @override
  String get desktopLinkConfirmMessage =>
      'Bilgisayar anahtarlarınızı, kişilerinizi ve sohbetlerinizi alır. Bu telefon olduğu gibi çalışmaya devam eder.';

  @override
  String get desktopLinkConfirmAction => 'Gönder';

  @override
  String desktopLinkConfirmWhere(String address) {
    return 'Yalnızca bu kodu az önce kendi bilgisayarınızın ekranından taradıysanız. Kopya bu ağdaki $address adresine gider.';
  }

  @override
  String get desktopLinkSending => 'Hesap gönderiliyor…';

  @override
  String get desktopLinkSent => 'Bilgisayar bağlandı';

  @override
  String get desktopLinkPhoneFound =>
      'Telefon bu bilgisayarı buldu ve hesabın bir kopyasını hazırlıyor. Fotoğraflarla bu birkaç dakika sürebilir.';

  @override
  String desktopLinkReceiving(int percent) {
    return 'Hesap alınıyor: %$percent';
  }

  @override
  String get desktopLinkRestoring => 'Hesap bu bilgisayara yerleştiriliyor…';

  @override
  String get desktopLinkFinding => 'Bilgisayar aranıyor…';

  @override
  String get desktopLinkPreparing =>
      'Hesabın kopyası hazırlanıyor. Fotoğraflarla bu birkaç dakika sürebilir.';

  @override
  String desktopLinkSendingPercent(int percent) {
    return 'Gönderiliyor: %$percent';
  }

  @override
  String get desktopLinkComputerRestoring => 'Bilgisayar hesabı yerleştiriyor…';

  @override
  String get devicesTitle => 'Cihazlar';

  @override
  String get devicesRowHint =>
      'Hesabınızın açık olduğu yerler ve oralardan çıkış';

  @override
  String get devicesThisDevice => 'Bu cihaz';

  @override
  String get devicesSeenNow => 'Az önce çevrimiçiydi';

  @override
  String devicesSeenMinutes(int n) {
    return '$n dk önce çevrimiçiydi';
  }

  @override
  String devicesSeenHours(int n) {
    return '$n sa önce çevrimiçiydi';
  }

  @override
  String devicesSeenDays(int n) {
    return '$n g önce çevrimiçiydi';
  }

  @override
  String get devicesLeaving => 'Çıkış yapılıyor — çevrimiçi olması bekleniyor';

  @override
  String get devicesSignOut => 'Çıkış yap';

  @override
  String get devicesSignOutAll => 'Diğer tüm cihazlarda çıkış yap';

  @override
  String devicesSignOutTitle(String name) {
    return '\"$name\" cihazında çıkış yapılsın mı?';
  }

  @override
  String get devicesSignOutMessage =>
      'CubeChat\'in anahtarları, sohbetleri ve ayarları o cihaz çevrimiçi olur olmaz orada silinecek. Hesap burada ve diğer cihazlarınızda kalır.';

  @override
  String get devicesSignOutPhoneMessage =>
      'Bu bir telefon: CubeChat orada tamamen silinecek. Hesap burada ve diğer cihazlarınızda kalır.';

  @override
  String get devicesSignOutAllMessage =>
      'Diğer tüm cihazlar çevrimiçi olur olmaz çıkış yapacak. Hesap yalnızca burada kalacak.';

  @override
  String get devicesRename => 'Yeniden adlandır';

  @override
  String get devicesRenameTitle => 'Bu cihazın adı';

  @override
  String get devicesSave => 'Kaydet';

  @override
  String get devicesEmpty =>
      'Henüz başka cihaz yok. Bir cihaz, CubeChat 1.0.0+1147 veya daha yeni bir sürümü açtığında burada görünür.';

  @override
  String get devicesCaveat =>
      'Çıkış, o cihaz çevrimiçi olduğunda gerçekleşir. Çevrimdışı tutulan bir cihaz anahtarlarını korur; tam koruma, hesap için yeni anahtarlar demektir.';

  @override
  String get desktopLinkImportTitle => 'Hesabı telefonunuzdan taşıyın';

  @override
  String get desktopLinkImportHint =>
      'Telefona bir kod gösterin; bu bilgisayar onun hesabının bir kopyası olur';

  @override
  String get desktopLinkImportConfirmTitle =>
      'Bu bilgisayardaki hesap değiştirilsin mi?';

  @override
  String get desktopLinkImportConfirmMessage =>
      'Bu bilgisayarın anahtarları, kişileri ve sohbetleri telefonun hesabıyla değiştirilecek. Bu hesaba hâlâ ihtiyacınız varsa önce yedek alın.';

  @override
  String get desktopLinkImportConfirmAction => 'Devam et';

  @override
  String get desktopLinkUnreachable =>
      'Bilgisayara ulaşılamadı. İkisi de aynı Wi-Fi ağında olmalı ve bilgisayarda CubeChat\'e güvenlik duvarından izin verilmeli.';

  @override
  String get desktopLinkFirewallHint =>
      'Windows telefonun bu bilgisayara erişmesini engelleyebilir. CubeChat\'e güvenlik duvarından izin verin — yalnızca yerel ağınız için.';

  @override
  String get desktopLinkFirewallAllow => 'Güvenlik duvarından izin ver';

  @override
  String get desktopLinkFirewallDeclined =>
      'Windows izin vermedi. Bu olmadan telefon bağlanamayabilir.';

  @override
  String get phoneTransferIntro =>
      'Profilinizi, anahtarlarınızı, kişilerinizi, kanallarınızı, ayarlarınızı ve geçmişinizi iki telefon arasında doğrudan taşıyın.';

  @override
  String get phoneTransferSend => 'Bu eski telefon';

  @override
  String get phoneTransferReceive => 'Bu yeni telefon';

  @override
  String get phoneTransferSameWifi =>
      'İki telefonu da aynı Wi-Fi ağına bağlayın. Aktarım bitene kadar bu ekranı açık tutun.';

  @override
  String get phoneTransferPreparing => 'Şifreli aktarım hazırlanıyor…';

  @override
  String get phoneTransferReady =>
      'Bu tek kullanımlık QR kodu yeni telefonda tarayın';

  @override
  String get phoneTransferScan => 'Eski telefonu tara';

  @override
  String get phoneTransferConfirmTitle =>
      'Bu telefonun profili değiştirilsin mi?';

  @override
  String get phoneTransferConfirmMessage =>
      'Bu telefonda şu an kayıtlı olan profil, şifreli yerel aktarımla değiştirilecek.';

  @override
  String get phoneTransferConfirmAction => 'Profili taşı';

  @override
  String get phoneTransferSuccess => 'Profil başarıyla taşındı';

  @override
  String get phoneTransferFailed => 'Telefon aktarımı tamamlanamadı';

  @override
  String get profileSummaryMeshOnly => 'Yalnızca mesh';

  @override
  String get profileSummaryMeshInternet => 'Mesh · internet';

  @override
  String get profileSummaryBackgroundOn => 'arka planda çalışır';

  @override
  String profileSummaryTransfersActive(int count) {
    return '$count sürüyor';
  }

  @override
  String get profileSummaryCardBackup => 'Dosyalar, yedek';

  @override
  String get chatPlay => 'Oynat';

  @override
  String get chatPause => 'Duraklat';

  @override
  String get profileTheme => 'Renk';

  @override
  String get profileThemeEmerald => 'Zümrüt';

  @override
  String get profileThemeIndigo => 'Çivit';

  @override
  String get profileThemeAmber => 'Kehribar';

  @override
  String get profileThemeRose => 'Gül';

  @override
  String get profileThemeFuchsia => 'Fuşya';

  @override
  String get profileThemeViolet => 'Menekşe';

  @override
  String get profileThemeOcean => 'Okyanus';

  @override
  String get profileThemeSlate => 'Arduvaz';

  @override
  String get profileScale => 'Arayüz boyutu';

  @override
  String get profileScaleSystem => 'Sistem';

  @override
  String get profileGlass => 'Cam';

  @override
  String get profileGlassAuto => 'Otomatik';

  @override
  String get profileGlassFull => 'Tam';

  @override
  String get profileGlassLight => 'Hafif';

  @override
  String get profileGlassHint =>
      'Hafif, renk tonunu korur ve panellerin arkasındaki bulanıklığı kaldırır. Otomatik, telefonunuzu bir kez ölçer ve karar verir. Zaten akıcı çalışan bir telefonda bunun pek faydası yoktur — akıcı çalışmayan telefonlar içindir.';

  @override
  String get mapAlwaysNeeded =>
      'cubechat kapalıyken haritanın güncel kalması için Konum\'un Her Zaman olarak ayarlanması gerekir. Ayarlar\'ı açmak için dokunun.';

  @override
  String get mapShareConsentTitle => 'Konumunuz haritada gösterilsin mi?';

  @override
  String get mapShareConsentBody =>
      'Canlı konumunuz yalnızca haritanızdaki kişilere gösterilir: davet ettiğiniz ya da davetini kabul ettiğiniz kişiler. Siz gizlenene kadar, Cubechat arka plandayken de güncellenmeye devam eder. Uçtan uca şifrelidir ve bize asla ulaşmaz. Haritada veya Profil\'de istediğiniz zaman gizlenebilirsiniz; engellediğiniz kişiler sizi hiçbir zaman görmez.';

  @override
  String get mapShareConsentAllow => 'İzin ver';

  @override
  String get mapShareConsentDecline => 'İzin verme';

  @override
  String get mapVisibleToFriends => 'Haritanızdaki arkadaşlar sizi görüyor';

  @override
  String get mapHiddenFromFriends => 'Gizlisiniz';

  @override
  String get mapHideMe => 'Gizlen';

  @override
  String get mapShowMe => 'Beni göster';

  @override
  String get profileScaleSmall => 'Daha küçük';

  @override
  String get profileScaleNormal => 'Normal';

  @override
  String get profileScaleLarge => 'Daha büyük';

  @override
  String get profileScaleSample => 'Metin ve satırlar bu boyutta çizilir.';

  @override
  String get savedTitle => 'Kaydedilenler';

  @override
  String get savedSubtitle => 'Kendinize notlar, bu cihazda';

  @override
  String get savedEmpty => 'Buraya yazdığınız her şey bu telefonda kalır.';

  @override
  String get meshOffTitle => 'Bluetooth mesh kapalı';

  @override
  String get meshOffHint =>
      'Yakındaki kimse sizi bulamaz, siz de onları bulamazsınız. Mesajlar yine internet rölesi üzerinden gider.';

  @override
  String get profileMeshSwitch => 'Bluetooth mesh';

  @override
  String get profileMeshSwitchHint =>
      'Yakındaki kişileri bulur ve mesajları internetsiz taşır. Kapalıyken pil tasarrufu sağlar.';

  @override
  String get channelAdminOnlyHint =>
      'Bir duyuru kanalı. Herkes yine de okuyabilir.';

  @override
  String get attachLocation => 'Konum';

  @override
  String get locationBubbleTitle => 'Konum';

  @override
  String get locationOpenInMaps => 'Haritalarda aç';

  @override
  String locationAccuracy(int metres) {
    return '$metres m hassasiyetle';
  }

  @override
  String get locationExpired => 'Bu konum artık güncel değil';

  @override
  String get locationDenied => 'Konum izni kapalı';

  @override
  String get locationUnavailable => 'Konum alınamadı';

  @override
  String get locationShareFor => 'Paylaşım süresi';

  @override
  String get locationShareOnce => 'Yalnızca bir kez';

  @override
  String get locationShare15m => '15 dakika';

  @override
  String get locationShare1h => '1 saat';

  @override
  String get storageTitle => 'Depolama';

  @override
  String get storageHeadline => 'Depolama kullanımı';

  @override
  String storageSubtitle(String size) {
    return 'cubechat bu cihazda $size kullanıyor';
  }

  @override
  String get storageEmpty => 'Henüz kayıtlı bir şey yok';

  @override
  String get storageScanning => 'Ölçülüyor…';

  @override
  String get storageCatPhotos => 'Fotoğraflar';

  @override
  String get storageCatVoice => 'Sesli mesajlar';

  @override
  String get storageCatFiles => 'Alınan dosyalar';

  @override
  String get storageCatOutbox => 'Gönderdiğiniz dosyalar';

  @override
  String get storageCatStickers => 'Çıkartmalar';

  @override
  String get storageCatSaved => 'Kaydedilen mesajlar';

  @override
  String get storageCatWallpapers => 'Duvar kağıtları';

  @override
  String get storageCatHistory => 'Sohbetler ve anahtarlar';

  @override
  String get storageCatCache => 'Önbellek';

  @override
  String storageClear(String size) {
    return '$size temizle';
  }

  @override
  String get storageClearNothing => 'Hiçbir şey seçilmedi';

  @override
  String storageFreed(String size) {
    return '$size boşaltıldı';
  }

  @override
  String get storageNoCloud =>
      'Bunun arkasında bir bulut yok. Temizlediğiniz her şey bu telefondan gider ve tek diğer kopyası geldiği telefondadır.';

  @override
  String get storageWhyHistoryLocked =>
      'Sohbetler buradan temizlenmez — Acil silme\'yi kullanın.';

  @override
  String get storageRecoveryFree => 'Temizlemesi güvenli';

  @override
  String get storageRecoveryGone => 'Başka hiçbir yerde kopyası yok';

  @override
  String get storageRecoveryAskSender => 'Gönderenden yeniden istenebilir';

  @override
  String get storageRecoveryCostsThem =>
      'Artık sizden yeniden göndermenizi isteyemezler';

  @override
  String storageConfirmTitle(String size) {
    return '$size temizlensin mi?';
  }

  @override
  String get storageConfirmBody =>
      'Bu, dosyaları bu telefondan siler. Hiçbir yere yüklenmediği için geri yüklenecek bir kaynak da yoktur.';

  @override
  String storageFilesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dosya',
      one: '$count dosya',
      zero: 'boş',
    );
    return '$_temp0';
  }

  @override
  String get customizeBarTitle => 'Gezinme çubuğu';

  @override
  String get customizeBarHint =>
      'Sıralamak için sürükleyin. Sohbetler kaldırılamaz.';

  @override
  String get customizeBarShown => 'Gösterilenler';

  @override
  String get customizeBarHidden => 'Gizlenenler';

  @override
  String get customizeBarHiddenEmpty => 'Gizlenen bir şey yok';

  @override
  String get customizeBarMinimum => 'En az iki sekme bırakın';

  @override
  String get customizeReset => 'Varsayılana dön';

  @override
  String get chatsArchiveTitle => 'Arşiv';

  @override
  String get chatsArchiveEmpty => 'Arşivde bir şey yok';

  @override
  String get chatsArchiveHint =>
      'Arşivlenen sohbetler çalışmaya devam eder — yalnızca listede görünmezler.';

  @override
  String get chatsArchivedToast => 'Arşivlendi';

  @override
  String get chatsUnarchivedToast => 'Listeye geri döndü';

  @override
  String chatsArchiveCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count sohbet',
      one: '$count sohbet',
    );
    return '$_temp0';
  }

  @override
  String get chatsSwipeNotHere => 'Bu sohbet için kullanılamaz';

  @override
  String get customizeSwipeTitle => 'Sohbeti sağa kaydırma';

  @override
  String get customizeSwipeHint =>
      'Sola kaydırmak yine sekmeler arasında geçiş yapar.';

  @override
  String get customizeSwipeArchive => 'Arşivle';

  @override
  String get customizeSwipeMute => 'Sessize al';

  @override
  String get customizeSwipePin => 'Sabitle';

  @override
  String get customizeSwipeRead => 'Okundu yap';

  @override
  String get customizeSwipeDelete => 'Sil';

  @override
  String get customizeSwipeNone => 'Hiçbiri';

  @override
  String get customizeHighRefresh => 'Tam yenileme hızı';

  @override
  String get customizeHighRefreshHint =>
      'Daha akıcı; telefon iki kat fazla kare çizer. Telefon ısınıyorsa kapatın — uygulamanın görünümü değişmez, yalnızca ne sıklıkla yeniden çizildiği değişir.';

  @override
  String get customizeQuickReaction => 'Çift dokunma tepkisi';

  @override
  String get customizeQuickReactionHint =>
      'Bir mesaja çift dokunulduğunda bırakılan tepki. Başka birini kullanırsanız o buraya geçer.';

  @override
  String get customizeCircleAudioTitle =>
      'Görüntülü mesajlarda müziği duraklat';

  @override
  String get customizeCircleAudioOn =>
      'Kayıt ya da izleme, çalan diğer her şeyi durdurur. Sonra kendiliğinden yeniden başlamaz.';

  @override
  String get customizeCircleAudioOff =>
      'Müziğiniz altta çalmaya devam eder; görüntülü mesaj oynarken sesi kısılır.';

  @override
  String get customizeMediaQualityTitle => 'Gönderirken fotoğraf kalitesi';

  @override
  String get customizeMediaQualityEconomy => 'Tasarruf';

  @override
  String get customizeMediaQualityStandard => 'Standart';

  @override
  String get customizeMediaQualityHigh => 'Yüksek';

  @override
  String get customizeMediaQualityEconomyHint =>
      'Fotoğraf başına en fazla 96 KB, 800 px. Tek çizgi çekim ya da kalabalık bir Bluetooth mesh için: yarı bekleme, daha yumuşak bir resim.';

  @override
  String get customizeMediaQualityStandardHint =>
      'Fotoğraf başına en fazla 192 KB, 1280 px. Yalnızca Bluetooth üzerinden bile geçebilecek boyutta. Videolar ve \"Orijinal\" her zaman olduğu gibi gönderilir.';

  @override
  String get customizeMediaQualityHighHint =>
      'Fotoğraf başına en fazla 768 KB, 2048 px. Yakınlaştırılacak kadar net; göndermesi dört kat uzun sürer, en iyisi Wi-Fi\'da.';

  @override
  String get previewReacted => 'mesajınıza';

  @override
  String get previewLocation => 'Konum';

  @override
  String get previewMapInvite => 'Harita daveti';

  @override
  String get previewContact => 'Kişi';

  @override
  String get previewUnsupported => 'Desteklenmeyen mesaj';

  @override
  String get previewCallOutgoing => 'Giden arama';

  @override
  String get previewCallIncoming => 'Gelen arama';

  @override
  String get previewCallMissed => 'Cevapsız arama';

  @override
  String chatPreparingPhotos(int count) {
    return '$count fotoğraf hazırlanıyor…';
  }

  @override
  String get circleSwitchCamera => 'Kamerayı değiştir';

  @override
  String get circleLight => 'Kayıt ışığı';

  @override
  String get circleCameraSwitchFailed =>
      'Kamera değiştirilemedi. Kaydınız hâlâ açık.';

  @override
  String get diagnosticsTitle => 'Tanılama';

  @override
  String get diagnosticsIntro =>
      'Uygulamanın son zamanlarda yaptıkları. Bir şey çalışmıyorsa bunu geliştiriciye gönderin.';

  @override
  String get diagnosticsShare => 'Günlüğü geliştiriciye gönder';

  @override
  String get diagnosticsEvents => 'Son olaylar';

  @override
  String get diagnosticsTechnical => 'Teknik kayıtlar';

  @override
  String get diagnosticsEmpty => 'Henüz gösterilecek bir şey yok.';

  @override
  String get diagnosticsDeveloperOn => 'Geliştirici modu açık';

  @override
  String get diagnosticsDeveloperOff => 'Geliştirici modu kapalı';

  @override
  String get logAppStarted => 'Uygulama başlatıldı';

  @override
  String get logInternetOn => 'İnternet bağlantısı açık';

  @override
  String logServerConnected(String host) {
    return '$host sunucusuna bağlanıldı';
  }

  @override
  String logServerLost(String host) {
    return '$host ile bağlantı koptu';
  }

  @override
  String get chatSaveAction => 'Kaydet';

  @override
  String get savedTagAsk => 'Kaydedildi. Etiket eklensin mi?';

  @override
  String get savedTagAdd => 'Etiket ekle';

  @override
  String get chatSharedWallpaperFailed =>
      'Duvar kağıdı burada ayarlandı. Menzile girdiğinde karşı tarafa ulaşacak.';

  @override
  String get chatTranscribeAction => 'Yazıya dök';

  @override
  String get chatTranscribeFailed => 'Bu telefon bunu yazıya dökemiyor.';

  @override
  String get chatTranscribing => 'Tanınıyor…';

  @override
  String get chatTranscriptHide => 'Metni gizle';

  @override
  String get chatCancelSend => 'Gönderimi iptal et';

  @override
  String get chatDownloadAction => 'İndir';

  @override
  String get chatDownloaded => 'Telefona kaydedildi';

  @override
  String get chatDownloadFailed => 'Kaydedilemedi';

  @override
  String get selfUpdateTitle => 'Dosyadan güncelleme yükle';

  @override
  String get selfUpdateHint =>
      'Yeni cubechat APK\'sını bir sohbetten açmak yerine buradan seçin: bu şekilde yüklenirse kilit ekranındaki aramalar açık kalır.';

  @override
  String get selfUpdateConfirm => 'Yüklemeyi sistem penceresinde onaylayın.';

  @override
  String get selfUpdateAllow =>
      'cubechat\'in uygulama yüklemesine izin verin, ardından yeniden dokunun.';

  @override
  String get selfUpdateNotOurs => 'Bu dosya bir cubechat güncellemesi değil.';

  @override
  String get selfUpdateFailed => 'Güncelleme yüklenmedi.';

  @override
  String get chatTranscribeDownloading =>
      'Telefon bunun için dili indiriyor. Bir dakika sonra tekrar deneyin.';

  @override
  String get chatTranscribeNoLanguage =>
      'Bu telefonda o dil için konuşma modeli yok. Sesten yazıya dilini Profil → Sohbetler ve medya bölümünden seçin.';

  @override
  String get chatTranscribeNotAllowed =>
      'CubeChat için konuşma tanıma kapalı. iPhone\'un Ayarlar → CubeChat bölümünden açın.';

  @override
  String get customizeTranscribeLanguageTitle => 'Sesten yazıya dili';

  @override
  String get customizeTranscribeLanguageAuto => 'Otomatik';

  @override
  String get customizeTranscribeLanguageHint =>
      'Sesli mesajların konuşulduğu dil; uygulamanın dili olması gerekmez. Otomatik, telefonun dillerini dener. Eksik bir dili telefon kendisi indirir; ses telefondan hiç çıkmaz.';

  @override
  String get chatTranslateAction => 'Çevir';

  @override
  String get chatTranslateFailed => 'Bu, bu telefonda çevrilemiyor.';

  @override
  String get customizeDeferMediaTitle => 'Medyayı indirmek için Wi-Fi bekle';

  @override
  String get customizeDeferMediaHint =>
      'Mobil veride mesajlar ve aramalar her zamanki gibi çalışır; fotoğraflar, sesli mesajlar, görüntülü mesajlar ve dosyalar ise Wi-Fi için sunucuda bekler — iki haftaya kadar. Sohbetlerin üstündeki bir satır neyin beklediğini gösterir ve hemen indirir.';

  @override
  String heldMediaCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count medya Wi-Fi bekliyor',
      one: '1 medya Wi-Fi bekliyor',
    );
    return '$_temp0';
  }

  @override
  String get heldMediaDownload => 'İndir';

  @override
  String get nearbyAirDropSubtitle => 'Yakındaki kişilerle dosya paylaşın';

  @override
  String get nearbyFilesSubtitle => 'Gönderilen ve alınan dosyalar';

  @override
  String get airdropTab => 'AirDrop';

  @override
  String get nearbyTabFiles => 'Dosyalar';

  @override
  String get airdropReceiveHint => 'Size kimler dosya gönderebilir';

  @override
  String get airdropReceiveContacts => 'Kişiler';

  @override
  String get airdropReceiveEveryone => 'Herkes 10 dk';

  @override
  String airdropEveryoneLeft(String time) {
    return 'Herkes · $time';
  }

  @override
  String get airdropSendFiles => 'Dosya gönder';

  @override
  String get airdropChooseFiles => 'Dosya seç';

  @override
  String airdropStagedTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dosya hazır',
      one: '1 dosya hazır',
    );
    return '$_temp0';
  }

  @override
  String get airdropStagedHint =>
      'Her iki telefonda Bluetooth açık ve AirDrop ekranı açıkken telefonları birbirine yaklaştırın ya da bir kişi seçin';

  @override
  String get airdropStagedPickPerson => 'Kişi seç';

  @override
  String airdropRequestBody(String what, String size) {
    return '$what göndermek istiyor · $size';
  }

  @override
  String airdropWhatPhotos(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count fotoğraf',
      one: '1 fotoğraf',
    );
    return '$_temp0';
  }

  @override
  String airdropWhatVideos(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count video',
      one: '1 video',
    );
    return '$_temp0';
  }

  @override
  String airdropWhatFiles(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dosya',
      one: '1 dosya',
    );
    return '$_temp0';
  }

  @override
  String get airdropAccept => 'Kabul et';

  @override
  String get airdropDecline => 'Reddet';

  @override
  String get airdropWaiting => 'Yanıt bekleniyor…';

  @override
  String get airdropAccepted => 'Kabul edildi';

  @override
  String get airdropUnheard =>
      'Alınmadı — CubeChat\'in eski bir sürümü olabilir';

  @override
  String get airdropSending => 'Gönderiliyor';

  @override
  String get airdropReceiving => 'Alınıyor';

  @override
  String get airdropInterrupted => 'Kesildi';

  @override
  String get airdropRetry => 'Tekrar dene';

  @override
  String get airdropOutcomeSent => 'Gönderildi';

  @override
  String get airdropOutcomeReceived => 'Alındı';

  @override
  String get airdropOutcomeDeclined => 'Reddedildi';

  @override
  String get airdropOutcomeCancelled => 'İptal edildi';

  @override
  String get airdropOutcomePartial => 'Kısmen';

  @override
  String get airdropReasonNoSpace => 'yeterli alan yok';

  @override
  String get airdropReasonContactsOnly => 'yalnızca kişiler';

  @override
  String get airdropReasonBusy => 'meşgul';

  @override
  String get airdropReasonTimeout => 'yanıt yok';

  @override
  String get airdropFileDeleted => 'silindi';

  @override
  String get airdropHistory => 'Geçmiş';

  @override
  String get airdropClearHistory => 'Geçmişi temizle';

  @override
  String get airdropEmpty =>
      'Yakındakilerle gönderdiğiniz veya aldığınız dosyalar burada olacak';

  @override
  String get airdropPickPerson => 'Şuraya gönder';

  @override
  String get airdropNobody => 'Yakında henüz cubechat kullanan kimse yok';

  @override
  String get airdropNoDirect => 'Bu kişiyle Bluetooth bağlantısı yok';

  @override
  String get airdropNearbyUnknown => 'Yakında';

  @override
  String get airdropConnecting => 'Bağlanıyor…';

  @override
  String get airdropConnectFailed => 'Bağlanılamadı';

  @override
  String get airdropSlowWarning => 'Bu, Bluetooth üzerinden uzun sürebilir';

  @override
  String airdropTooLarge(String name, int limit) {
    return '$name $limit MB\'tan büyük';
  }

  @override
  String airdropFromLabel(String name) {
    return 'AirDrop · $name';
  }

  @override
  String get airdropWrite => 'Mesaj yaz';

  @override
  String get airdropAction => 'AirDrop';

  @override
  String get airdropLaneTitle => 'Kanal';

  @override
  String get airdropLaneAuto => 'Otomatik';

  @override
  String get airdropLaneBluetooth => 'Bluetooth';

  @override
  String get airdropLaneWifi => 'Wi‑Fi';

  @override
  String get airdropBluetoothNeededHint =>
      'Birbirinizi bulmak ve aktarımı onaylamak için iki telefonda da Bluetooth\'u açın.';

  @override
  String get airdropLaneHint =>
      'Bluetooth telefonları bulur ve bağlar. Wi‑Fi, iki telefon aynı ağda veya erişim noktasında olduğunda dosyaları taşır.';

  @override
  String get airdropWifiUnreachable => 'Aynı ağda değil';

  @override
  String get airdropWifiOldVersion =>
      'Onun uygulaması henüz Wi‑Fi üzerinden alamıyor';

  @override
  String get airdropBumpAdd => 'Ekle';

  @override
  String get airdropBumpAlreadyContact => 'Zaten kişilerinizde';

  @override
  String airdropBumpSending(String name) {
    return '$name kişisine gönderiliyor';
  }

  @override
  String airdropBumpReceiving(String name) {
    return '$name size dosya gönderiyor';
  }

  @override
  String get termsTitle => 'cubechat kuralları';

  @override
  String get termsBody =>
      'cubechat, uygunsuz içeriğe ve kötü niyetli kullanıcılara sıfır tolerans gösterir. Devam ederek taciz, tehdit, reşit olmayanları içeren cinsel içerik, spam veya yasa dışı herhangi bir şey göndermemeyi kabul edersiniz. Herkes bir mesajı veya kişiyi şikâyet edebilir; şikâyetler geliştiriciye ulaşır ve 24 saat içinde işleme alınır, kuralları ihlal edenler yasaklanır.';

  @override
  String get termsReadFull => 'Koşulların tamamını okuyun';

  @override
  String get termsAccept => 'Kabul ediyorum';

  @override
  String get messageHide => 'Gizle';

  @override
  String get messageHidden => 'Sizin için gizlendi';

  @override
  String get reportAction => 'Şikâyet et';

  @override
  String get reportTitle => 'Sorun ne?';

  @override
  String get reportReasonSpam => 'Spam';

  @override
  String get reportReasonAbuse => 'Hakaret veya taciz';

  @override
  String get reportReasonViolence => 'Şiddet';

  @override
  String get reportReasonSexual => 'Cinsel içerik';

  @override
  String get reportReasonOther => 'Diğer';

  @override
  String get reportNoteHint => 'Açıklayın (isteğe bağlı)';

  @override
  String get reportSend => 'Şikâyeti gönder';

  @override
  String get reportDisclosure =>
      'Seçilen mesajın metni ve şikâyetiniz, cubechat moderasyonuna ve onun özel Telegram botuna gider.';

  @override
  String get reportSent =>
      'Şikâyet gönderildi. Şikâyetleri 24 saat içinde inceleriz.';

  @override
  String get reportBlockedToo => 'Bu kişi sizin için engellendi.';

  @override
  String get reportQueued =>
      'Şikâyet kaydedildi. Çevrimiçi olunca gönderilecek.';

  @override
  String get reportFailed => 'Şikâyet gönderilemedi.';

  @override
  String get filteredMessage => 'Filtre tarafından gizlendi';

  @override
  String get filteredShow => 'Göster';

  @override
  String get filterToggle => 'Rahatsız edici içerik filtresi';

  @override
  String get filterToggleHint =>
      'Yabancılardan gelen ve kanallardaki kaba sözleri gizler';

  @override
  String get aboutTitle => 'Hakkında';

  @override
  String get aboutContact => 'Geliştiriciye e-posta gönder';

  @override
  String get aboutReport => 'İhlal bildir';

  @override
  String get aboutTerms => 'Kullanım koşulları';

  @override
  String get aboutPrivacy => 'Gizlilik politikası';

  @override
  String get requestsTitle => 'İstekler';

  @override
  String get requestsEmpty => 'İstek yok';

  @override
  String requestBanner(String name) {
    return '$name kişilerinizde değil. Siz kabul edene kadar bunu okuduğunuzu göremez ve sizi arayamaz.';
  }

  @override
  String get requestAccept => 'Kabul et';

  @override
  String get requestDelete => 'Sil';

  @override
  String get requestBlock => 'Engelle';

  @override
  String get cubeIdTitle => 'Cube ID';

  @override
  String get cubeIdExplainer =>
      '@adınız kişi kartınızı gösterir. Sunucu yalnızca adı ve herkese açık kartınızı saklar — mesajlarınızı asla.';

  @override
  String get cubeIdFieldHint => 'a–z, 0–9 ve _, 3–20 karakter';

  @override
  String get cubeIdAvailable => 'Uygun';

  @override
  String get cubeIdTaken => 'Alınmış';

  @override
  String get cubeIdReserved => 'İzin verilmiyor';

  @override
  String get cubeIdInvalid => 'Yalnızca a–z, 0–9 ve _, 3–20 karakter';

  @override
  String get cubeIdClaim => 'Bu adı al';

  @override
  String get cubeIdWorking => 'Ad güvenceye alınıyor…';

  @override
  String get cubeIdChange => 'Değiştir';

  @override
  String get cubeIdEmail => 'Kurtarma e-postası';

  @override
  String get cubeIdEmailHint =>
      'Bu telefon kaybolursa ad, bu adrese gönderilen bir e-postayla geri alınır';

  @override
  String get cubeIdEmailField => 'E-posta';

  @override
  String cubeIdEmailSent(String email) {
    return '$email adresine bir e-posta gönderildi. İçindeki bağlantıyı açın.';
  }

  @override
  String get cubeIdEmailRemove => 'E-postayı kaldır';

  @override
  String get cubeIdEmailUnavailable =>
      'E-posta şu an kullanılamıyor. Daha sonra deneyin.';

  @override
  String get cubeIdEmailInvalid => 'Bu bir e-posta adresine benzemiyor';

  @override
  String get cubeIdSave => 'Kaydet';

  @override
  String get cubeIdRecover => 'Adı e-postayla kurtar';

  @override
  String get cubeIdRecoverSent =>
      'Adres eşleşirse bir e-posta gelir. Ad, bağlantıyı açmanızdan 48 saat sonra bu telefona geçer.';

  @override
  String cubeIdRecoveryWarning(String name, String when) {
    return 'Biri başka bir telefonda @$name adını e-postayla kurtarıyor. İptal etmezseniz ad $when geçecek.';
  }

  @override
  String get cubeIdRecoveryCancel => 'Kurtarmayı iptal et';

  @override
  String get cubeIdRecoveryCancelled => 'Kurtarma iptal edildi';

  @override
  String get cubeIdRelease => 'Bırak';

  @override
  String cubeIdReleaseConfirm(String name) {
    return '@$name bırakılsın mı? Herkes onu alabilecek.';
  }

  @override
  String get cubeIdShare => 'Paylaş';

  @override
  String cubeIdShareText(String name) {
    return 'Beni cubechat\'te bul: @$name\nhttps://cubechat.tech/u.html#$name';
  }

  @override
  String get cubeIdFailed => 'Ad kaydedilemedi. Tekrar deneyin.';

  @override
  String get cubeIdOffline => 'İnternet yok';

  @override
  String get lookupNotFound => 'Bu @ada sahip kimse yok';

  @override
  String searchFindCubeName(String name) {
    return '@$name bul';
  }

  @override
  String get searchFindCubeNameHint => 'Cube ID\'de ara ve ekle';

  @override
  String get addContactHintName => 'Bir kart yapıştırın veya @ad yazın';

  @override
  String get strangerReachTitle => 'İnternetten bana kimler yazabilir';

  @override
  String get strangerReachAll => 'Herkes';

  @override
  String get strangerReachRequest => 'İstekle';

  @override
  String get strangerReachNone => 'Hiç kimse';

  @override
  String get strangerReachHint =>
      'Daha önce yazmadığınız ve size internet üzerinden ulaşan kişiler için. Bluetooth ile yakındaki kişiler etkilenmez.';

  @override
  String get sectionPrivacy => 'Gizlilik ve güvenlik';

  @override
  String get sectionNotifications => 'Bildirimler ve aramalar';

  @override
  String get sectionConnection => 'Bağlantı';

  @override
  String get sectionChats => 'Sohbetler ve medya';

  @override
  String get sectionAppearance => 'Görünüm';

  @override
  String get sectionData => 'Veri ve depolama';

  @override
  String get sectionAbout => 'Hakkında';

  @override
  String get subWhoSeesMe => 'Beni kimler görür';

  @override
  String get subProtection => 'Koruma';

  @override
  String get subNotifications => 'Bildirimler';

  @override
  String get subCalls => 'Aramalar';

  @override
  String get profileDiscoverableMeshOff =>
      'Bluetooth mesh kapalı — Bağlantı bölümünden açın.';

  @override
  String get chatRouteBluetoothDirect => 'Bluetooth, doğrudan';

  @override
  String chatRouteMeshHops(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Mesh · $n atlama',
      one: 'Mesh · $n atlama',
    );
    return '$_temp0';
  }

  @override
  String chatRouteDeliveredVia(String route) {
    return 'İletildi: $route';
  }

  @override
  String chatRouteReceivedVia(String route) {
    return 'Alındı: $route';
  }

  @override
  String get chatUnreadDivider => 'Yeni mesajlar';

  @override
  String get radioTitle => 'Telsiz';

  @override
  String get radioNearbySubtitle =>
      'Bir düğmeye basılı tutun ve bir grupla ya da bir kişiyle konuşun';

  @override
  String get radioGroupsLabel => 'Gruplar';

  @override
  String get radioDirectLabel => 'Kişisel';

  @override
  String get radioAddGroup => 'Telsiz ekle';

  @override
  String get radioNoGroups =>
      'Henüz telsiz yok. Bir tane ekleyin — aynı adı ve şifreyi giren herkes birbirini duyar.';

  @override
  String get radioLeave => 'Bu telsizden ayrıl';

  @override
  String get radioPickChannel => 'Bir grup veya kişi seçin';

  @override
  String get radioPushToTalk => 'Konuşmak için basılı tutun';

  @override
  String get radioTalking => 'Konuşuyorsunuz…';

  @override
  String get radioChannelBusy => 'Kanal meşgul';

  @override
  String radioSpeaker(String name) {
    return '$name konuşuyor';
  }

  @override
  String get radioSilentTitle => 'Sessiz modda konuş';

  @override
  String get radioSilentHint => 'Telefon sessizdeyken bile ses çalar.';

  @override
  String get radioJoinNameLabel => 'Ad';

  @override
  String get radioJoinPasswordLabel => 'Şifre (isteğe bağlı)';

  @override
  String get radioJoinHint =>
      'Aynı adı ve şifreyi giren herkes aynı telsizdedir. Hiçbir sunucu bunların listesini tutmaz.';

  @override
  String get radioJoinNameRequired => 'Bir ad girin';

  @override
  String get radioJoinSubmit => 'Ekle';

  @override
  String get radioBlockedTooLong => 'Bir dakikalık konuşmadan sonra kesildi';

  @override
  String get radioBlockedCall => 'Bir arama sürüyor';

  @override
  String get radioBlockedMicrophone => 'Mikrofon erişimi yok';

  @override
  String get radioBlockedUnavailable => 'Telsiz bu cihazda kullanılamıyor';

  @override
  String get radioBlockedNoChannel => 'Önce bir grup veya kişi seçin';

  @override
  String get radioTurnOff => 'Telsizi kapat';

  @override
  String get radioPersonalCallsTitle => 'Kişisel çağrıları al';

  @override
  String get radioPersonalCallsHint =>
      'Telsiz kapalıyken, sizinle konuşan bir kişi telsizi kendisine ayarlar.';

  @override
  String get radioBackgroundHint =>
      'Ekran kapalıyken telsiz yalnızca arka plan modu açıksa duyulur.';

  @override
  String get areaNearby => 'Yakındaki sohbet';

  @override
  String get areaLevelDistrict => 'Semt';

  @override
  String get areaLevelCity => 'Şehir';

  @override
  String get areaLevelRegion => 'Bölge';

  @override
  String areaPresentCount(int count) {
    return '≈$count kişi burada';
  }

  @override
  String get areaPresentMany => '50+ kişi burada';

  @override
  String get areaBlockViaBluetooth => 'Mahalleniz — Bluetooth üzerinden';

  @override
  String get areaOpenNearbyTab => 'Yakında\'yı aç';

  @override
  String get areaLocating => 'Semtiniz bulunuyor…';

  @override
  String get areaNoPlace =>
      'Henüz konum yok. Bölge sohbeti, bu ekran açıkken yaklaşık konumunuza ihtiyaç duyar.';

  @override
  String get areaLocationDenied =>
      'Cubechat için konum kapalı. Semtinizi görmek için Ayarlar\'dan yaklaşık konuma izin verin.';

  @override
  String get areaOffline => 'Bölge sohbetiyle bağlantı yok';

  @override
  String get areaEmpty => 'Son 24 saatte burada kimse yazmadı.';

  @override
  String get areaConsentTitle => 'Bölge sohbeti herkese açıktır';

  @override
  String get areaConsentBody =>
      'Buradaki mesajlar herkese açıktır. Semtinizi veya şehrinizi açan herkes okuyabilir ve mesajlar Cubechat sunucusunda 24 saat saklanır. Birkaç saatte bir değişen geçici bir adla yazarsınız; kimse @adınızı veya kişilerinizi görmez. Semtinizi bilmek için Cubechat, yalnızca bu ekran açıkken yaklaşık konumunuzu ister.';

  @override
  String get areaConsentAllow => 'Devam et';

  @override
  String get areaConsentDecline => 'Şimdi değil';

  @override
  String areaDefaultName(String tag) {
    return 'Küp-$tag';
  }

  @override
  String areaYouAre(String name, int hours) {
    return 'Siz $name · $hours sa sonra yeni ad';
  }

  @override
  String get areaNewName => 'Yeni ad';

  @override
  String get areaSetName => 'Ad seçin';

  @override
  String get areaNameHint =>
      'Yalnızca bu adın birkaç saati için. Otomatik ad için boş bırakın.';

  @override
  String get areaNameSameWarning =>
      'Aynı ad, semtler arasında sizi birbirine bağlar';

  @override
  String get areaShowPresence => 'Burada olduğumu göster';

  @override
  String get areaPresenceOffHint =>
      'Yakında kaç kişi olduğunu görmek için \"Burada olduğumu göster\"i açın';

  @override
  String get areaReadOnly => 'Yalnızca bulunduğunuz yerde yazabilirsiniz';

  @override
  String get areaComposerHint => 'Buradaki herkese mesaj';

  @override
  String get areaSend => 'Gönder';

  @override
  String get areaWaitALittle => 'Biraz bekleyin';

  @override
  String areaFlood(int count) {
    return 'Flood ($count) · Göster';
  }

  @override
  String get areaReply => 'Yanıtla';

  @override
  String get areaHide => 'Gizle';

  @override
  String get areaBlock => 'Adı değişene kadar engelle';

  @override
  String get areaBlocked => 'Adı değişene kadar engellendi';

  @override
  String get areaReport => 'Şikâyet et';

  @override
  String get areaOpenLink => 'Bağlantıyı aç';

  @override
  String areaOpenLinkConfirm(String url) {
    return '$url açılsın mı?';
  }

  @override
  String get areaOpen => 'Aç';

  @override
  String get areaReadHere => 'Burada oku';

  @override
  String get areaReadHereHint =>
      'Yalnızca okuma. Yalnızca bulunduğunuz yerde yazabilirsiniz; röle hangi yeri okuduğunuzu öğrenir.';

  @override
  String get areaNotes => 'Notlar';

  @override
  String areaNotesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count not',
      one: '$count not',
      zero: 'Not yok',
    );
    return '$_temp0';
  }

  @override
  String get areaLeaveNote => 'Not bırak';

  @override
  String get areaNoteHint => 'Şehriniz için kısa bir not';

  @override
  String get areaNoteLifetime => 'Saklama süresi';

  @override
  String get areaNote1h => '1 sa';

  @override
  String get areaNote24h => '24 sa';

  @override
  String get areaNote7d => '7 gün';

  @override
  String get areaPinToDistrict => 'Bir semte iğnele';

  @override
  String get areaPinHint =>
      'Şehrinizin içinde haritaya dokunun; iğne o semte oturur.';

  @override
  String get areaPinOutside => 'Yalnızca şehrinizin içinde';

  @override
  String get areaNoteDelete => 'Notumu sil';

  @override
  String get areaNoNotes => 'Burada henüz not yok';

  @override
  String get areaNotesLimit => 'Günde üç not';

  @override
  String get areaNoteLeft => 'Not bırakıldı';

  @override
  String get areaNoteSend => 'Bırak';

  @override
  String get areaOwnNote => 'Notunuz';

  @override
  String get areaNotePinned => 'Bir semte iğnelendi';

  @override
  String get areaHidden => 'Gizlendi';

  @override
  String get areaPublicBadge => 'Herkese açık · 24 sa saklanır';

  @override
  String get areaSettingTitle => 'Bölge sohbeti';

  @override
  String get areaSettingOnHint =>
      'Haritadaki Yakındaki sohbet düğmesi: semtinizin ve şehrinizin herkese açık sohbetleri, geçici bir adla.';

  @override
  String get areaSettingOffHint =>
      'Kapalı: haritada düğme yok ve bölge sohbeti asla konumunuzu istemez ya da bağlanmaz.';

  @override
  String get wallpaperPhotoLocalOnly =>
      'Fotoğraflı duvar kâğıtları şimdilik yalnızca yerel';

  @override
  String get wallpaperSavedNoRoute =>
      'Burada kaydedildi. Şu an karşı tarafa bir yol yok';

  @override
  String get wallpaperScopeTitle => 'Bu duvar kâğıdını kim görsün?';

  @override
  String get wallpaperScopeChannel => 'Tüm kanal';

  @override
  String get wallpaperScopeBoth => 'Ben ve karşı taraf';

  @override
  String get wallpaperScopeLocal => 'Yalnızca bende';

  @override
  String get wallpaperScopeSharedHint =>
      'Şifreli bir kontrol paketi olarak gönderilir';

  @override
  String get wallpaperScopePhotoHint =>
      'Fotoğraflar şimdilik yalnızca bu telefonda kalır';

  @override
  String get foldersCreate => 'Klasör oluştur';

  @override
  String get foldersYours => 'Klasörleriniz';

  @override
  String get foldersSmartFilters => 'Akıllı filtreler';

  @override
  String get foldersName => 'Klasör adı';

  @override
  String get foldersSave => 'Kaydet';

  @override
  String get foldersDeleteTitle => 'Klasör silinsin mi?';

  @override
  String get foldersDelete => 'Sil';

  @override
  String get foldersCreateAction => 'Oluştur';

  @override
  String get chatsArchiveHiddenToast =>
      'Arşiv gizlendi. “Görünüm” bölümünden geri getirebilirsiniz.';

  @override
  String get chatsBulkPin => 'Sabitle';

  @override
  String get chatsBulkMute => 'Sessize al';

  @override
  String get chatsUnarchive => 'Arşivden çıkar';

  @override
  String get chatsAddToFolder => 'Klasöre ekle';

  @override
  String get chatsMarkUnread => 'Okunmadı olarak işaretle';

  @override
  String get chatsClearHistory => 'Sohbet geçmişini temizle';

  @override
  String get foldersNew => 'Yeni klasör';

  @override
  String get foldersNameHint => 'Arkadaşlar';

  @override
  String get chatsNoIncoming => 'Gelen mesaj yok';

  @override
  String get chatsMarkedUnread => 'Okunmadı olarak işaretlendi';

  @override
  String get chatsClearHistoryTitle => 'Sohbet geçmişi temizlensin mi?';

  @override
  String get chatsClearHistoryBody =>
      'Mesajlar yalnızca bu cihazdan silinir. Sohbet, kişi ve favoriler kalır.';

  @override
  String get chatsClearHistoryAction => 'Temizle';

  @override
  String get chatsHistoryCleared => 'Geçmiş temizlendi';

  @override
  String get savedTagMenuTag => 'Etiket';

  @override
  String get savedTagRemove => 'Etiketi kaldır';

  @override
  String get customizeArchiveRowTitle => 'Arşiv satırı';

  @override
  String get customizeArchiveRowHint =>
      'Sohbet listesinin üstünde gösterin. Arşivlenmiş sohbetler her durumda mesaj almaya devam eder.';

  @override
  String get mapLayerStandard => 'Standart';

  @override
  String get mapLayerStandardHint => 'Açık sokak haritası — en kararlı seçenek';
}
