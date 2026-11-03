// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Czech (`cs`).
class AppLocalizationsCs extends AppLocalizations {
  AppLocalizationsCs([String locale = 'cs']) : super(locale);

  @override
  String get callVoice => 'Hlasový hovor';

  @override
  String get callVideo => 'Videohovor';

  @override
  String get callIncomingVideo => 'Příchozí videohovor';

  @override
  String get callCamera => 'Kamera';

  @override
  String get callFlipCamera => 'Otočit';

  @override
  String get contactProfileVideo => 'Video';

  @override
  String get callPreparing => 'Příprava mikrofonu…';

  @override
  String get callDialing => 'Volání…';

  @override
  String get callRinging => 'Vyzvání…';

  @override
  String get callConnecting => 'Připojování…';

  @override
  String get callMicrophoneRequired =>
      'Pro volání povolte přístup k mikrofonu v nastavení systému.';

  @override
  String get callMicrophoneWindows =>
      'Windows nedal aplikaci CubeChat přístup k mikrofonu. Zapněte Nastavení → Ochrana osobních údajů a zabezpečení → Mikrofon → „Povolit desktopovým aplikacím přístup k mikrofonu“.';

  @override
  String get callElsewhere => 'Na jiném zařízení tohoto účtu už probíhá hovor.';

  @override
  String get callRelayUnavailable =>
      'Server pro hovory není dostupný. Zkuste to později.';

  @override
  String get callBusy => 'Obsazeno';

  @override
  String get callNoAnswer => 'Nepřijato';

  @override
  String get callFailed => 'Hovor se nepodařilo spojit';

  @override
  String get callDeclined => 'Hovor odmítnut';

  @override
  String get callEnded => 'Hovor ukončen';

  @override
  String get callMicrophone => 'Mikrofon';

  @override
  String get callSpeaker => 'Reproduktor';

  @override
  String get callAnswer => 'Přijmout';

  @override
  String get callDecline => 'Odmítnout';

  @override
  String get callEnd => 'Ukončit';

  @override
  String get callClose => 'Zavřít';

  @override
  String get callMinimize => 'Minimalizovat';

  @override
  String get callAudioOutput => 'Zvuk hovoru';

  @override
  String get callRoutePhone => 'Telefon';

  @override
  String get callRouteBluetooth => 'Bluetooth';

  @override
  String get callRouteHeadphones => 'Sluchátka';

  @override
  String get callFullScreenTitle => 'Hovory na zamčené obrazovce';

  @override
  String get callFullScreenBody =>
      'Povolte zobrazení příchozího hovoru na zamčené obrazovce, abyste ho mohli přijmout bez odemknutí.';

  @override
  String get callFullScreenXiaomi =>
      'Xiaomi, Redmi a Poco nedovolí aplikacím zapnout to samy: zapněte „Zobrazit na zamčené obrazovce“ v části Další oprávnění.';

  @override
  String get circleMessage => 'Videozpráva';

  @override
  String get appName => 'Cubechat';

  @override
  String get navChats => 'Chaty';

  @override
  String get navPeers => 'Poblíž';

  @override
  String get navProfile => 'Profil';

  @override
  String get navContacts => 'Kontakty';

  @override
  String get navMap => 'Mapa';

  @override
  String get mapTitle => 'Mapa';

  @override
  String get mapFriendsTitle => 'Lidé na mapě';

  @override
  String get mapFriendsHint => 'Vaši polohu dostávají jen tyto kontakty';

  @override
  String mapClusterTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lidí tady',
      few: '$count lidé tady',
      one: '$count člověk tady',
    );
    return '$_temp0';
  }

  @override
  String get mapClusterHint => 'Klepnutím na člověka na něj mapu přesunete';

  @override
  String get mapNorthUp => 'Sever nahoru';

  @override
  String get mapLayerTitle => 'Styl mapy';

  @override
  String get mapLayerHint => 'Na čem jsou špendlíky nakresleny';

  @override
  String get mapLayerDark => 'Tmavá';

  @override
  String get mapLayerDarkHint =>
      'Ulice bez popisků — nejklidnější pozadí pod špendlíky';

  @override
  String get mapLayerSatellite => 'Satelit';

  @override
  String get mapLayerSatelliteHint =>
      'Letecké snímky: která budova, který dvůr';

  @override
  String get mapLayerTerrain => 'Terén';

  @override
  String get mapLayerTerrainHint => 'Vrstevnice a reliéf — kopce a stezky';

  @override
  String get mapFriendsEmpty => 'Zatím s vámi nikdo nesdílí mapu.';

  @override
  String get mapFriendsEmptyHint =>
      'Pozvěte kontakt — objeví se tu, jakmile pozvánku přijme.';

  @override
  String get mapFriendsInvite => 'Pozvat';

  @override
  String get mapFriendsRemove => 'Odebrat z mapy';

  @override
  String mapFriendsRemoved(String name) {
    return '$name už s vámi nesdílí mapu';
  }

  @override
  String get mapFriendsLive => 'Teď na mapě';

  @override
  String get mapFriendsIdle => 'Teď bez polohy';

  @override
  String get mapInviteTitle => 'Pozvat na mapu';

  @override
  String get mapInviteHint => 'Vyberte jeden nebo více chatů';

  @override
  String get mapInviteEmpty => 'Zatím nejsou žádné chaty k pozvání.';

  @override
  String mapInviteAction(int count) {
    return 'Odeslat ($count)';
  }

  @override
  String get mapInviteMessage =>
      'Pozvánka na mapu Cubechat. Pošlete do tohoto chatu svou polohu a objevíte se na mapě.';

  @override
  String mapInviteSent(int count) {
    return 'Odeslané pozvánky: $count';
  }

  @override
  String get mapInviteFailed => 'Pozvánky se nepodařilo odeslat';

  @override
  String mapPeopleVisible(int count) {
    return 'Sdílené polohy: $count';
  }

  @override
  String get mapCenterMe => 'Vycentrovat na mě';

  @override
  String get mapNoSharedLocations => 'Zatím žádné sdílené polohy';

  @override
  String get mapNoSharedLocationsHint =>
      'Kontakt se tu objeví, jakmile pošle polohu v chatu.';

  @override
  String get mapWebHintTitle => 'Spojení poblíž';

  @override
  String get mapWebHint => 'Čáry ukazují blízkost, ne trasu zprávy.';

  @override
  String get mapOpenProfile => 'Profil';

  @override
  String get mapLocationPrivacyOff => 'Poloha na mapě je skrytá';

  @override
  String get mapLocationPrivacyOffHint =>
      'Svůj špendlík zobrazíte zapnutím „Zobrazit mě na mapě“ v části Soukromí.';

  @override
  String get mapYouOnMap => 'Vaše poloha je viditelná na tomto zařízení';

  @override
  String get locationSharingDisabled =>
      'Nejdřív zapněte „Zobrazit mě na mapě“ v části Soukromí.';

  @override
  String get mapLocationDenied => 'Přístup k poloze je vypnutý';

  @override
  String get mapLocationServiceOff =>
      'Zapněte polohové služby, abyste se zobrazili';

  @override
  String get mapLocationUnavailable => 'Vaši polohu se nepodařilo zjistit';

  @override
  String get mapDistanceUnknown => 'Vzdálenost neznámá';

  @override
  String mapDistanceMetres(int metres) {
    return '$metres m od vás';
  }

  @override
  String mapDistanceKilometres(String kilometres) {
    return '$kilometres km od vás';
  }

  @override
  String get mapUpdatedNow => 'sdíleno právě teď';

  @override
  String mapUpdatedMinutes(int minutes) {
    return 'sdíleno před $minutes min';
  }

  @override
  String mapUpdatedHours(int hours) {
    return 'sdíleno před $hours h';
  }

  @override
  String get contactsTitle => 'Kontakty';

  @override
  String get contactsSubtitle => 'Všichni, komu jste psali';

  @override
  String get contactsSearchHint => 'Hledat kontakty…';

  @override
  String get contactsEmptyTitle => 'Zatím žádné kontakty';

  @override
  String get contactsEmptyHint =>
      'Začněte konverzaci a protějšek se tu objeví.';

  @override
  String get contactsSearchEmpty => 'Žádné odpovídající kontakty';

  @override
  String get contactsTabContacts => 'Kontakty';

  @override
  String get contactsTabCalls => 'Hovory';

  @override
  String get callsFilterAll => 'Vše';

  @override
  String get callsFilterMissed => 'Zmeškané';

  @override
  String get callsEmptyTitle => 'Zatím žádné hovory';

  @override
  String get callsEmptyHint =>
      'Zde se zobrazí příchozí, odchozí a zmeškané hovory.';

  @override
  String get callsMissedEmpty => 'Žádné zmeškané hovory';

  @override
  String get callsCallBack => 'Zavolat';

  @override
  String get contactProfileChat => 'Chat';

  @override
  String get contactProfileCall => 'Volat';

  @override
  String get contactProfileRadio => 'Vysílačka';

  @override
  String get contactProfileSecurity => 'Zabezpečení';

  @override
  String get contactProfileActions => 'Akce kontaktu';

  @override
  String get contactProfileVerify => 'Ověřit';

  @override
  String get contactProfileCopyId => 'Kopírovat ID kontaktu';

  @override
  String get contactProfileIdCopied => 'ID kontaktu zkopírováno';

  @override
  String get contactProfileId => 'ID kontaktu';

  @override
  String get contactProfileVerifyHint =>
      'Porovnejte otisky šifrování a ověřte tuto osobu.';

  @override
  String get chatsTitle => 'Chaty';

  @override
  String get chatsSubtitle => 'Mesh · koncové šifrování';

  @override
  String get chatsEmptyTitle => 'Zatím žádné konverzace';

  @override
  String get chatsEmptyHint =>
      'Chat zahájíte otevřením protějšku na kartě Poblíž.';

  @override
  String get chatsFilterAll => 'Vše';

  @override
  String get chatsFilterUnread => 'Nepřečtené';

  @override
  String get chatsFilterMesh => 'Mesh';

  @override
  String get chatsFilterFavorites => 'Oblíbené';

  @override
  String get chatsFolderDirect => 'Osobní';

  @override
  String get chatsFolderChannels => 'Kanály';

  @override
  String get chatsFolderOnline => 'Dostupní';

  @override
  String get chatsFoldersTitle => 'Složky';

  @override
  String get chatsFoldersHint =>
      'Složky jsou výřezy tohoto seznamu, ne místa, kam se chaty přesouvají. Zapněte ty, které chcete mít nad chaty.';

  @override
  String get chatsSearchHint => 'Hledat chaty…';

  @override
  String get chatsStatusViaMesh => 'přes mesh';

  @override
  String get chatsStatusOffline => 'offline';

  @override
  String get peerKeyRotated => 'klíč se změnil — ověřte znovu';

  @override
  String get peersTitle => 'Poblíž';

  @override
  String get peersSubtitle => 'Zařízení v dosahu Bluetooth';

  @override
  String get peersEmpty => 'Hledání protějšků…';

  @override
  String peersHopsOne(int n) {
    return '$n skok';
  }

  @override
  String peersHopsOther(int n) {
    return 'skoků: $n';
  }

  @override
  String get blePermissionTitle => 'Je potřeba oprávnění Bluetooth';

  @override
  String get blePermissionHint =>
      'Cubechat potřebuje Bluetooth k hledání protějšků a odesílání zpráv — bez internetu.';

  @override
  String get blePermissionGrant => 'Udělit oprávnění';

  @override
  String get blePermissionOpenSettings => 'Otevřít nastavení';

  @override
  String get blePermissionDeniedHint =>
      'Oprávnění bylo zamítnuto. Povolte přístup k Bluetooth v nastavení.';

  @override
  String get bleAdapterOffTitle => 'Bluetooth je vypnutý';

  @override
  String get bleAdapterOffHint =>
      'Zapněte Bluetooth, abyste viděli protějšky poblíž.';

  @override
  String get bleUnsupportedTitle => 'Bluetooth LE není k dispozici';

  @override
  String get bleUnsupportedHint =>
      'Toto zařízení nebo platforma nepodporuje Bluetooth Low Energy. Zkuste to na telefonu.';

  @override
  String get bleScanning => 'Vyhledávání…';

  @override
  String get bleRetry => 'Zkusit znovu';

  @override
  String get bleEnable => 'Zapnout';

  @override
  String get bleConnectFailed =>
      'Nepodařilo se připojit. Protějšek může být mimo dosah nebo se změnila jeho adresa Bluetooth.';

  @override
  String get bleSignal => 'Signál';

  @override
  String get bleConnect => 'Připojit';

  @override
  String get bleConnected => 'Připojeno';

  @override
  String get bleVerified => 'Ověřeno';

  @override
  String get editorAdjustBrightness => 'Jas';

  @override
  String get editorAdjustContrast => 'Kontrast';

  @override
  String get editorAdjustSaturation => 'Sytost';

  @override
  String get editorToolCrop => 'Oříznout';

  @override
  String get editorToolDraw => 'Kreslit';

  @override
  String get editorToolAdjust => 'Upravit';

  @override
  String get editorTabSticker => 'Nálepka';

  @override
  String get editorTabText => 'Text';

  @override
  String get editorPenPen => 'Pero';

  @override
  String get editorPenMarker => 'Zvýrazňovač';

  @override
  String get editorPenNeon => 'Neon';

  @override
  String get editorPenArrow => 'Šipka';

  @override
  String get editorPenBlur => 'Rozmazání';

  @override
  String get editorPenEraser => 'Guma';

  @override
  String get editorLevel => 'Vyrovnat';

  @override
  String get editorTextHint => 'Text na fotce';

  @override
  String get editorCropFree => 'Volně';

  @override
  String get editorRemove => 'Odebrat';

  @override
  String get notificationUnknownSender => 'Nová zpráva';

  @override
  String get bleUnknownPeer => 'Neznámé zařízení';

  @override
  String get bleBroadcasting => 'Vysílá';

  @override
  String bleConnectedCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Připojeno $n centrálních zařízení',
      few: 'Připojena $n centrální zařízení',
      one: 'Připojeno 1 centrální zařízení',
      zero: 'Žádná centrální zařízení',
    );
    return '$_temp0';
  }

  @override
  String get verifyTitle => 'Ověřit protějšek';

  @override
  String get verifyIntro =>
      'Porovnejte tyto dva otisky se svým protějškem osobně nebo během hlasového hovoru. Pokud se na obou stranách shodují, máte potvrzeno, že s handshakem Noise nikdo nemanipuloval.';

  @override
  String get verifyMine => 'VÁŠ OTISK';

  @override
  String verifyTheirs(String name) {
    return 'OTISK: $name';
  }

  @override
  String get verifyMarkAsVerified => 'Označit jako ověřené';

  @override
  String get verifyAlreadyDone => 'Tento protějšek je ověřen.';

  @override
  String get verifyRevoke => 'Zrušit';

  @override
  String verifyDoneSnack(String name) {
    return '$name: označeno jako ověřené';
  }

  @override
  String get chatInputHint => 'Zpráva';

  @override
  String get chatSend => 'Odeslat';

  @override
  String get chatToday => 'Dnes';

  @override
  String get chatYesterday => 'Včera';

  @override
  String get chatDelivered => 'Doručeno';

  @override
  String get chatRead => 'Přečteno';

  @override
  String get chatSending => 'Odesílání';

  @override
  String get chatWaitingForConnection => 'Čeká na připojení';

  @override
  String sendQueueCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count zpráv čeká na připojení',
      few: '$count zprávy čekají na připojení',
      one: '1 zpráva čeká na připojení',
    );
    return '$_temp0';
  }

  @override
  String sendQueueSlowNetwork(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Pomalá síť — odesílá se $count zpráv',
      few: 'Pomalá síť — odesílají se $count zprávy',
      one: 'Pomalá síť — odesílá se 1 zpráva',
    );
    return '$_temp0';
  }

  @override
  String get sendQueueTitle => 'Čeká na odeslání';

  @override
  String get sendQueueHint =>
      'Odejdou samy, jakmile bude cesta — Bluetooth poblíž nebo internet. Nic není třeba mačkat.';

  @override
  String get sendQueueRetry => 'Zkusit teď';

  @override
  String get sendQueueCancel => 'Zrušit odeslání';

  @override
  String get sendQueueCancelled => 'Neodesláno — vzato zpět';

  @override
  String get sendQueueTooLate => 'Na zrušení je pozdě: zpráva už odešla';

  @override
  String get chatEncryptedNotice =>
      'Zprávy jsou koncově šifrovány protokolem Noise.';

  @override
  String get chatSessionHandshaking => 'Navazování zabezpečeného kanálu…';

  @override
  String get chatSessionEstablished => 'Zabezpečeno · Noise XX';

  @override
  String get chatSessionFailed => 'Spojení selhalo';

  @override
  String get presenceOnline => 'online';

  @override
  String get presenceOffline => 'offline';

  @override
  String get chatSessionFingerprintPending =>
      'Otisk se zobrazí po dokončení handshaku.';

  @override
  String get chatEmptyEstablished =>
      'Zabezpečený kanál je připraven. Pošlete zprávu a zahajte konverzaci.';

  @override
  String get chatEmptyHandshaking =>
      'Čeká se, až druhá strana dokončí handshake…';

  @override
  String get chatEmptyTitle => 'Zatím tu nejsou žádné zprávy';

  @override
  String get chatEmptyGreetHint =>
      'Napište zprávu nebo pozdravte klepnutím na Kubiho.';

  @override
  String get profileTitle => 'Profil';

  @override
  String get profileNickname => 'Přezdívka';

  @override
  String get profileNicknameEditTitle => 'Nastavte přezdívku';

  @override
  String get profileNicknameHint => 'Jak vás uvidí ostatní v síti mesh';

  @override
  String get profileNicknameSave => 'Uložit';

  @override
  String get profileFingerprint => 'Otisk veřejného klíče';

  @override
  String get profileLanguage => 'Jazyk';

  @override
  String get profileLanguageEn => 'Angličtina';

  @override
  String get profileLanguageUk => 'Ukrajinština';

  @override
  String get profileTransport => 'Přenos';

  @override
  String get profileTransportMesh => 'Bluetooth mesh';

  @override
  String get profileBackground => 'Zůstat dostupný na pozadí';

  @override
  String get profileBackgroundSubtitle =>
      'Přijímat zprávy, i když je aplikace zavřená';

  @override
  String get profileBatteryExempt => 'Vypnout optimalizaci baterie';

  @override
  String get profileAbout => 'O aplikaci';

  @override
  String profileVersion(String v) {
    return 'Verze $v';
  }

  @override
  String get rotateKeysTitle => 'Změnit klíče účtu';

  @override
  String get rotateKeysHint =>
      'Pokud jste ztratili zařízení s účtem nebo vám ho ukradli';

  @override
  String get rotateKeysConfirmTitle => 'Změnit klíče účtu?';

  @override
  String get rotateKeysConfirmBody =>
      'Vaše kontakty dostanou nové klíče a chaty jim zůstanou, ale každý z nich bude vyzván, aby vaše klíče znovu ověřil. Všechna ostatní zařízení účtu se odhlásí; ta, která si necháte, z tohoto telefonu znovu propojte. Kontakty se starší verzí CubeChat se k vám nedostanou, dokud neaktualizují. Kanály si své klíče ponechají.';

  @override
  String get rotateKeysConfirmAction => 'Změnit klíče';

  @override
  String get rotateKeysWorking => 'Mění se klíče…';

  @override
  String rotateKeysDone(int sent, int total) {
    return 'Nové klíče. Informováno $sent z $total kontaktů';
  }

  @override
  String get rotateKeysSlow =>
      'Nové klíče. Ne každý kontakt stihl potvrdit; relé to pro ně uchovají';

  @override
  String get profileEmergencyWipe => 'Nouzové vymazání';

  @override
  String get profileEmergencyWipeConfirm => 'Vymazat vše?';

  @override
  String get profileEmergencyWipeConfirmHint =>
      'Odstraní se vaše identita, seznam protějšků a historie konverzací. Nelze vrátit zpět.';

  @override
  String get profileEmergencyWipeAction => 'Vymazat';

  @override
  String get cancel => 'Zrušit';

  @override
  String get copy => 'Kopírovat';

  @override
  String get copied => 'Zkopírováno';

  @override
  String get channelsNewTitle => 'Nový kanál';

  @override
  String get channelsNewTooltip => 'Nový kanál';

  @override
  String get channelNameLabel => 'Název kanálu';

  @override
  String get channelPasswordLabel => 'Heslo (volitelné)';

  @override
  String get channelJoinAction => 'Připojit se';

  @override
  String get channelNameHint =>
      'Kdo zadá stejný název a heslo, ocitne se ve stejné místnosti. Žádný server nevede jejich seznam.';

  @override
  String get channelPasswordHint =>
      'Heslo je klíč. Bez něj je místnost otevřená každému poblíž, kdo zná její název.';

  @override
  String get channelSubtitle => 'Skupinový kanál · sdílený klíč';

  @override
  String get channelMute => 'Ztlumit';

  @override
  String get channelUnmute => 'Zrušit ztlumení';

  @override
  String channelMutedUntil(String time) {
    return 'Ztlumeno do $time';
  }

  @override
  String get channelMuteFor => 'Ztlumit na…';

  @override
  String channelMuteMinutes(int minutes) {
    return '$minutes min';
  }

  @override
  String channelMuteHours(int hours) {
    return '$hours h';
  }

  @override
  String channelMuteDays(int days) {
    return '$days d';
  }

  @override
  String get channelMuteForever => 'Dokud to znovu nezapnu';

  @override
  String get channelCommunity => 'Komentáře';

  @override
  String get channelCommunityOpen => 'Otevřít diskusi';

  @override
  String channelCommunitySubtitle(String channel) {
    return 'Diskuse ke kanálu $channel';
  }

  @override
  String get channelBackToChannel => 'Zpět do kanálu';

  @override
  String get channelMemberActions => 'Člen';

  @override
  String get channelRemoveMember => 'Odebrat z kanálu';

  @override
  String get channelRemoveMemberHint =>
      'Jeho příspěvky tu přestanou být přijímány. Nic mu nebrání se podle názvu znovu připojit — sdílený klíč je jediné členství, které existuje.';

  @override
  String get channelMuteMember => 'Umlčet na…';

  @override
  String get channelUnmuteMember => 'Dovolit znovu psát';

  @override
  String channelMemberRemoved(String name) {
    return 'Uživatel $name byl odebrán';
  }

  @override
  String channelMemberMuted(String name) {
    return 'Uživatel $name byl umlčen';
  }

  @override
  String channelMemberCleared(String name) {
    return '$name může znovu psát';
  }

  @override
  String get channelMemberMutedNote => 'Umlčen';

  @override
  String get channelShareHistory => 'Sdílet historii';

  @override
  String get channelShareHistoryHint =>
      'Znovu odvysílá poslední příspěvky této místnosti, aby je viděl každý, kdo se připojil později. Kdo tu už byl, nedostane nic nového.';

  @override
  String channelHistoryShared(int count) {
    return 'Nabídnuté příspěvky: $count';
  }

  @override
  String get channelHistoryNothing => 'Zatím není co sdílet';

  @override
  String get channelHistoryAuto => 'Dávat novým členům historii';

  @override
  String get channelHistoryAutoHint =>
      'Když se v místnosti objeví někdo nový, poslední příspěvky mu odejdou samy. Zatím jen text — fotky jsou proudy po částech a nejdou znovu odeslat, aniž by se všem zdvojily.';

  @override
  String get channelPostComments => 'Komentáře';

  @override
  String get channelNoComments => 'K tomuto zatím nikdo nic neřekl';

  @override
  String get channelCommentHint => 'Komentář';

  @override
  String get channelMuteCustom => 'Na jak dlouho?';

  @override
  String get channelMuteCustomHint => 'Hodiny';

  @override
  String get chatPinnedManage => 'Připnuté';

  @override
  String get chatPeekOpen => 'Otevřít chat';

  @override
  String get chatPeekPin => 'Připnout';

  @override
  String get chatPeekUnpin => 'Odepnout';

  @override
  String get chatPeekUnmute => 'Zrušit ztlumení';

  @override
  String get chatPeekMarkRead => 'Označit jako přečtené';

  @override
  String get chatDeleteForMeHint =>
      'Odstraní se z tohoto telefonu a odepne. Druhá strana si svou kopii ponechá.';

  @override
  String get pushWakeTitle => 'Budit tento telefon';

  @override
  String get pushWakeHint =>
      'Malý server hlídá na relé vaši adresu a ťukne na tento telefon, když něco dorazí, takže se to dozvíte i se zavřenou aplikací. Nikdy nevidí zprávu ani klíč — jen to, že vaše adresa něco dostala, a kdy. Relé to už ví; tohle je druhé místo, které to ví.';

  @override
  String get pushWakeDeniedTitle => 'Oznámení jsou vypnutá';

  @override
  String get pushWakeDeniedHint =>
      'Systém jednou dostal odpověď ne a už se znovu nezeptá, takže to lze zapnout jen v Nastavení — cubechat, pak Oznámení. Potom se sem vraťte.';

  @override
  String get pushWakeRefused => 'Oznámení nebyla povolena';

  @override
  String get privacyForwardLinkTitle => 'Odkaz zpět z přeposlaných';

  @override
  String get privacyForwardLinkHint =>
      'Když někdo přepošle vaši zprávu, řádek nad ní může otevřít váš profil. Když je to vypnuté, uvidí vaše jméno a nic, na co klepnout. Je to žádost pro jejich aplikaci, ne něco, co tato aplikace může vynutit.';

  @override
  String get privacyShareSheetTitle => 'Chaty v nabídce sdílení';

  @override
  String get privacyShareSheetOnHint =>
      'Názvy vašich čtyř posledních chatů dostane Android, abyste do nich mohli posílat z jakékoli aplikace. Zámek aplikace je neskryje.';

  @override
  String get privacyShareSheetOffHint =>
      'Android nedostane nic. Při sdílení do CubeChat vyberete chat sami.';

  @override
  String get privacyCallsTitle => 'Přijímat hovory';

  @override
  String get privacyCallsOnHint =>
      'Vaše kontakty vám mohou volat. Chcete-li to zakázat jednomu člověku, otevřete jeho profil.';

  @override
  String get privacyCallsOffHint =>
      'Nikdo vám nemůže volat kromě lidí, kterým to povolíte v jejich profilu. Odmítnutý hovor u nich vypadá jako obsazeno.';

  @override
  String get chatsStatusChannel => 'kanál';

  @override
  String get channelInviteTitle => 'Přidat lidi';

  @override
  String get channelInviteAction => 'Pozvat';

  @override
  String get channelInviteEmpty =>
      'Zatím žádné známé protějšky. Nejdřív se s někým setkejte na kartě Poblíž.';

  @override
  String get channelInviteSent => 'Pozvánky odeslány';

  @override
  String get channelInviteNoneSent => 'Teď se nikoho nepodařilo zastihnout';

  @override
  String get channelNameTooLong => 'Název kanálu je příliš dlouhý';

  @override
  String get chatsActionFavorite => 'Přidat do oblíbených';

  @override
  String get chatsActionUnfavorite => 'Odebrat z oblíbených';

  @override
  String get chatsActionDelete => 'Smazat chat';

  @override
  String get chatsDeleteTitle => 'Smazat tento chat?';

  @override
  String chatsDeleteManyHint(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Vymaže $count konverzací. Kontakty zůstanou, takže jim můžete znovu napsat bez výměny kódů.',
      few:
          'Vymaže $count konverzace. Kontakty zůstanou, takže jim můžete znovu napsat bez výměny kódů.',
      one:
          'Vymaže $count konverzaci. Kontakt zůstane, takže mu můžete znovu napsat bez výměny kódů.',
    );
    return '$_temp0';
  }

  @override
  String get chatsDeletedToast => 'Chat smazán.';

  @override
  String chatsDeletedManyToast(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Smazáno $count chatů.',
      few: 'Smazány $count chaty.',
      one: 'Smazán $count chat.',
    );
    return '$_temp0';
  }

  @override
  String get undo => 'Zpět';

  @override
  String get chatsDeletePeerHint =>
      'Vymaže konverzaci. Kontakt zůstane, takže mu můžete znovu napsat bez výměny kódů.';

  @override
  String get chatsDeleteChannelHint =>
      'Opustí kanál a odstraní jeho historii. K opětovnému připojení budete znovu potřebovat klíč.';

  @override
  String get chatsDeleteForThemToo => 'Smazat i u protějšku';

  @override
  String get chatsDeleteForThemHint =>
      'Požádá jeho aplikaci, aby také vymazala celou konverzaci včetně toho, co napsal on. V kanálu se stáhnou jen vaše vlastní zprávy.';

  @override
  String get chatEditAction => 'Upravit';

  @override
  String get chatEditTitle => 'Upravit zprávu';

  @override
  String get chatEditSave => 'Uložit';

  @override
  String get chatEdited => 'upraveno';

  @override
  String get chatDeleteAction => 'Smazat';

  @override
  String get chatDeleteTitle => 'Smazat zprávu?';

  @override
  String get chatDeleteForMe => 'Smazat u mě';

  @override
  String get chatDeleteForEveryone => 'Smazat u všech';

  @override
  String get chatPinTitle => 'Připnout zprávu?';

  @override
  String get chatPinForBoth => 'Připnout pro oba';

  @override
  String get chatPinForMe => 'Připnout jen pro mě';

  @override
  String get chatReplyAction => 'Odpovědět';

  @override
  String chatReplyingTo(String name) {
    return 'Odpověď pro $name';
  }

  @override
  String get chatReplyYou => 'sebe';

  @override
  String get chatCopyAction => 'Kopírovat';

  @override
  String get chatCopied => 'Zkopírováno';

  @override
  String get chatForwardAction => 'Přeposlat';

  @override
  String get chatForwardTitle => 'Přeposlat do';

  @override
  String get shareIntoTitle => 'Odeslat do';

  @override
  String get shareNearbyAirDrop => 'Poblíž přes AirDrop';

  @override
  String get shareNearbyAirDropHint => 'Bez internetu — lidem vedle vás';

  @override
  String get shareSent => 'Odesláno';

  @override
  String get shareFailed => 'Část se nepodařilo odeslat';

  @override
  String get chatForwardEmpty => 'Zatím žádné další chaty';

  @override
  String chatForwardSendCount(int count) {
    return 'Odeslat ($count)';
  }

  @override
  String chatForwardSentCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Přeposláno do $count chatů',
      few: 'Přeposláno do $count chatů',
      one: 'Přeposláno do jednoho chatu',
    );
    return '$_temp0';
  }

  @override
  String chatForwardSent(String name) {
    return 'Přeposláno: $name';
  }

  @override
  String chatSentAt(String time) {
    return 'Odesláno $time';
  }

  @override
  String chatReadAt(String time) {
    return 'Přečteno $time';
  }

  @override
  String get chatPinAction => 'Připnout';

  @override
  String get chatUnpinAction => 'Odepnout';

  @override
  String chatPinnedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count připnutých zpráv',
      few: '$count připnuté zprávy',
      one: '1 připnutá zpráva',
      zero: 'Žádné připnuté zprávy',
    );
    return '$_temp0';
  }

  @override
  String get chatNoPins => 'Nic tu není připnuto';

  @override
  String get chatUnpinAll => 'Odepnout všechny zprávy';

  @override
  String get chatShowAllPins => 'Všechny připnuté zprávy';

  @override
  String get chatUnpinConfirm => 'Odepnout tuto zprávu?';

  @override
  String get chatUnpinConfirmHint =>
      'Přestane být připnutá pro všechny v tomto chatu.';

  @override
  String get chatPinnedTitle => 'Připnutá zpráva';

  @override
  String get chatPinnedGone => 'Tato zpráva už v chatu není';

  @override
  String get peerBlock => 'Blokovat';

  @override
  String get peerUnblock => 'Odblokovat';

  @override
  String get peerMute => 'Ztlumit';

  @override
  String get peerUnmute => 'Zrušit ztlumení';

  @override
  String get peerBlockedNote => 'Blokováno — jeho zprávy se zahazují.';

  @override
  String get relaysTitle => 'Náhradní cesta přes internet';

  @override
  String get relaysCardTitle => 'Dosáhnout protějšků přes internet';

  @override
  String get relaysCardSubtitle =>
      'Když Bluetooth nedoručí, posílat přes relé Nostr';

  @override
  String get relaysExplainer =>
      'Zprávy zůstávají koncově šifrované — relé nese jen stejný zapečetěný rámec, jaký by nesl Bluetooth. Zjistí ale, které dva klíče spolu mluví a kdy. Ve výchozím stavu vypnuto.';

  @override
  String get relaysMyAddress => 'Vaše adresa na relé';

  @override
  String get relaysCopied => 'Zkopírováno';

  @override
  String get circleLensTitle => 'Přední kamera pro kolečka';

  @override
  String get circleLensFrontHint =>
      'Kulaté videozprávy se nahrávají kamerou otočenou k vám.';

  @override
  String get circleLensBackHint =>
      'Kulaté videozprávy se nahrávají zadní kamerou, abyste mohli ukázat, na co se díváte.';

  @override
  String get channelCloseTitle => 'Zavřít místnost pro všechny';

  @override
  String get channelCloseSubtitle =>
      'Odstraní ji z telefonu každého člena. Můžete to udělat jen vy.';

  @override
  String get channelCloseConfirm =>
      'Místnost, její zprávy i členové zmizí z každého telefonu, který ji má. Nikdo není zablokován: klíč vychází z názvu, takže kdo si ho pamatuje, může prázdnou místnost znovu otevřít.';

  @override
  String get channelCloseAction => 'Zavřít místnost';

  @override
  String get circleHint => 'Pusťte pro odeslání · posuňte doleva pro zrušení';

  @override
  String get circleHintLocked => 'Až skončíte, klepněte na odeslat';

  @override
  String get circleNeedsCamera => 'Kolečka potřebují kameru a mikrofon';

  @override
  String get circleFailed => 'Kolečko se nepodařilo nahrát';

  @override
  String get relaysListLabel => 'Relé';

  @override
  String get relaysLaneMedia => 'Relé pro média';

  @override
  String get relaysLaneMediaNote =>
      'Fotky, soubory a videa jdou přes ně, aby přenos nezpomaloval konverzaci.';

  @override
  String get relaysLaneLocation => 'Relé pro polohu';

  @override
  String get relaysLaneLocationNote =>
      'Majáky na mapě jdou přes ně, odděleně od všeho ostatního.';

  @override
  String get relaysAdd => 'Přidat relé';

  @override
  String get relaysAddHint => 'wss://relay.example.com';

  @override
  String get relaysInvalidUrl => 'Zadejte adresu wss:// nebo ws://';

  @override
  String get relaysRemove => 'Odebrat';

  @override
  String get relaysStateConnected => 'Připojeno';

  @override
  String get relaysStateConnecting => 'Připojování…';

  @override
  String get relaysStateFailed => 'Nedostupné';

  @override
  String get relaysStateIdle => 'Vypnuto';

  @override
  String get relaysEmpty =>
      'Nejsou nastavena žádná relé — náhradní cesta zůstává vypnutá.';

  @override
  String get contactTitle => 'Kontaktní karta';

  @override
  String get contactMineLabel => 'Vaše karta';

  @override
  String get contactMineExplainer =>
      'Pošlete ji někomu, kdo je mimo dosah Bluetooth. Obsahuje vaše klíče a adresu na relé — to mu stačí, aby s vámi zahájil šifrovaný chat přes internet.';

  @override
  String get contactCopy => 'Kopírovat';

  @override
  String get contactShare => 'Sdílet';

  @override
  String get contactCopied => 'Karta zkopírována';

  @override
  String get contactShareSubject => 'Moje kontaktní karta cubechat';

  @override
  String get contactAddLabel => 'Přidat někoho';

  @override
  String get contactAddHint => 'Vložte kontaktní kartu';

  @override
  String get contactAddAction => 'Přidat';

  @override
  String get contactPaste => 'Vložit';

  @override
  String contactAdded(String name) {
    return 'Přidáno: $name';
  }

  @override
  String get contactInvalid => 'To není platná kontaktní karta';

  @override
  String get contactOwnCard => 'To je vaše vlastní karta';

  @override
  String get contactUnverified =>
      'Kontakt přidaný tímto způsobem je zpočátku neověřený. Kartu si může vyrobit kdokoli a napsat na ni jakékoli jméno, proto si před důvěrou v identitu porovnejte otisky osobně nebo během hovoru.';

  @override
  String get contactRelayOff =>
      'Náhradní cesta přes internet je vypnutá, takže karta zatím nikoho nezastihne.';

  @override
  String get contactRelayEnable => 'Zapnout';

  @override
  String get profileContactCard => 'Kontaktní karta';

  @override
  String get chatsAddContactTooltip => 'Přidat kontakt podle karty';

  @override
  String get chatsMenuTooltip => 'Další';

  @override
  String get chatsMenuAddContact => 'Přidat kontakt';

  @override
  String get chatsMenuNewChannel => 'Nový kanál';

  @override
  String get profileDiscoverable => 'Viditelný poblíž';

  @override
  String get profileDiscoverableOnHint => 'Najde vás kdokoli v dosahu';

  @override
  String get profileDiscoverableOffHint => 'Zastihnou vás jen vaše kontakty';

  @override
  String get profileDiscoverableExplainer =>
      'Když je to zapnuté, vaše ohlášení se vysílá nešifrovaně, takže vás cizí lidé mohou poznat jen tím, že přijdou blíž — a kdokoli naslouchá, si zaznamená váš klíč a jméno. Když je to vypnuté, stejný balíček jde zapečetěný jen kontaktům, které už máte, a vaše směrovací ID zůstanou nepropojitelná. Noví lidé pak potřebují kontaktní kartu.';

  @override
  String get voiceHoldHint => 'Podržením nahrajete hlasovou zprávu';

  @override
  String get voiceTrimPlay => 'Přehrát';

  @override
  String get voiceTrimPause => 'Pozastavit';

  @override
  String get voiceTrimDiscard => 'Zahodit nahrávku';

  @override
  String voiceTrimSelection(String duration) {
    return 'Odesílá se $duration';
  }

  @override
  String get profileLastSeen => 'Sdílet naposledy online';

  @override
  String get profileLastSeenOnHint => 'Kontakty vidí, kdy jste v aplikaci';

  @override
  String get profileLastSeenOffHint =>
      'Váš čas nikdo nevidí a vy nevidíte čas nikoho: jen kdo je online';

  @override
  String get profileMapLocation => 'Zobrazit mě na mapě';

  @override
  String get profileMapLocationOnHint =>
      'Poloha je k dispozici pro ruční sdílení a váš špendlík je vidět na mapě';

  @override
  String get profileMapLocationOffHint =>
      'Aplikace nežádá o polohu a váš špendlík zůstává skrytý';

  @override
  String get desktopAutostartTitle => 'Spouštět s Windows';

  @override
  String get desktopAutostartHint =>
      'CubeChat čeká v oznamovací oblasti, takže hovory a zprávy dorazí do počítače i se zavřeným oknem';

  @override
  String get trayOpen => 'Otevřít CubeChat';

  @override
  String get trayQuit => 'Ukončit';

  @override
  String get callDirectTitle => 'Přímé hovory';

  @override
  String get callDirectOnHint => 'Rychlejší, ale volaný zjistí vaši IP adresu';

  @override
  String get callDirectOffHint =>
      'Hovory jdou přes náš přenosový server: volaný nikdy neuvidí vaši IP adresu a server hovor neslyší';

  @override
  String get profileReadReceipts => 'Sdílet potvrzení o přečtení';

  @override
  String get profileReadReceiptsOnHint =>
      'Odesílatelé vidí, kdy jste si zprávu přečetli';

  @override
  String get profileReadReceiptsOffHint =>
      'Přestanete posílat čas přečtení, ale ten jejich uvidíte dál';

  @override
  String get profilePrivacyExplainer =>
      'Naposledy online funguje oběma směry: skryjete-li svůj stav, přestanete vidět stav ostatních. Potvrzení o přečtení řídí jen to, co posíláte vy. Doručování zpráv to neovlivní.';

  @override
  String get chatTimerAction => 'Časovač';

  @override
  String get chatTimerRemove => 'Odebrat časovač';

  @override
  String get chatTimerTitle => 'Smazat tuto zprávu za';

  @override
  String chatTimerSet(String time) {
    return 'Tato zpráva zmizí za $time';
  }

  @override
  String get chatTimerLocalHint =>
      'Jen na tomto zařízení — jejich kopie patří jim';

  @override
  String get contactTagAction => 'Štítek';

  @override
  String get contactTagRemove => 'Odebrat štítek';

  @override
  String get contactTagTitle => 'Vyberte štítek';

  @override
  String get contactTagAll => 'Vše';

  @override
  String get quietHoursTitle => 'Tiché hodiny';

  @override
  String get quietHoursHint => 'Zprávy dál chodí, telefon zůstane potichu';

  @override
  String get quietHoursFrom => 'Od';

  @override
  String get quietHoursTo => 'Do';

  @override
  String get notifPreviewTitle => 'Zobrazit v oznámeních';

  @override
  String get notifPreviewFull => 'Jméno a text';

  @override
  String get notifPreviewNameOnly => 'Jen jméno';

  @override
  String get notifPreviewHidden => 'Nic';

  @override
  String get notifPreviewHint =>
      'Oznámení jsou vidět na zamčené obrazovce a aplikacím s přístupem k oznámením, i když je zapnutý zámek aplikace';

  @override
  String get notifPreviewNewMessage => 'Nová zpráva';

  @override
  String get appLockTitle => 'Zámek aplikace';

  @override
  String get appLockHint => 'Při otevření aplikace žádat kód';

  @override
  String get appLockPrompt => 'Zadejte kód';

  @override
  String get appLockUnlock => 'Odemknout';

  @override
  String get appLockWrong => 'Nesprávný kód';

  @override
  String get appLockSetTitle => 'Nastavit kód';

  @override
  String get appLockSetHint => 'Čtyři číslice nebo více. Obnovit ho nelze.';

  @override
  String get appLockOffTitle => 'Vypnout zámek';

  @override
  String get appLockOffHint => 'Zadejte současný kód';

  @override
  String get appLockOn => 'Zámek aplikace je zapnutý';

  @override
  String get appLockOff => 'Zámek aplikace je vypnutý';

  @override
  String get avatarSet => 'Vybrat fotku';

  @override
  String get avatarChange => 'Změnit fotku';

  @override
  String get avatarView => 'Zobrazit fotku';

  @override
  String get profileCoverPhoto =>
      'Profilová fotka, dvojitým klepnutím zvětšíte';

  @override
  String get profileCoverMenu => 'Možnosti fotky';

  @override
  String get avatarSaved => 'Uloženo do galerie';

  @override
  String get avatarRemove => 'Odebrat fotku';

  @override
  String get avatarRemoveConfirm =>
      'Avatar bude z tohoto zařízení smazán. Na jeho místo se vrátí vygenerovaný přechod.';

  @override
  String get avatarFailed => 'Obrázek se nepodařilo načíst';

  @override
  String get fileOpenHint => 'Klepnutím otevřete';

  @override
  String get fileMissing => 'Tento soubor už není k dispozici';

  @override
  String get fileNoHandlerTitle => 'Žádná aplikace to neotevře';

  @override
  String get fileNoHandlerHint =>
      'Tento typ souboru neumí otevřít žádná nainstalovaná aplikace. Můžete ho místo toho poslat do jiné aplikace.';

  @override
  String get fileRequestedAgain => 'Požádali jsme odesílatele znovu';

  @override
  String get fileOpenFailed => 'Soubor se nepodařilo otevřít';

  @override
  String get fileShareAction => 'Poslat do aplikace';

  @override
  String fileTooLargeMesh(int limit) {
    return 'Soubor je příliš velký — přes mesh je limit $limit MB';
  }

  @override
  String fileTooLargeRelay(int limit) {
    return 'Přes internet je limit $limit MB. Pro odeslání většího souboru se přibližte k příjemci.';
  }

  @override
  String get mediaSendOriginal => 'Originál';

  @override
  String get attachFile => 'Soubor';

  @override
  String get attachGallery => 'Galerie';

  @override
  String get attachCamera => 'Kamera';

  @override
  String get cameraUnavailable => 'Kamera není k dispozici';

  @override
  String get profileEditName => 'Jméno';

  @override
  String get profileMyCard => 'Karta';

  @override
  String get mediaCaptionHint => 'Přidat popisek…';

  @override
  String get mediaDiscardTitle => 'Zahodit výběr?';

  @override
  String get mediaDiscardMessage => 'Zavřít galerii a zahodit vybrané fotky?';

  @override
  String get mediaDiscardConfirm => 'Zahodit';

  @override
  String get mediaPhotosAccessOff => 'Přístup k fotkám je vypnutý';

  @override
  String get mediaPhotosAccessOffHint =>
      'CubeChat teď vidí jen videa. Povolte přístup k fotkám v nastavení systému, aby se zobrazily vaše obrázky.';

  @override
  String get mediaVideosOnly =>
      'Vidět jsou jen videa — povolte přístup k fotkám';

  @override
  String get mediaOpenSettings => 'Otevřít nastavení';

  @override
  String get mediaTakePhoto => 'Vyfotit';

  @override
  String get contactProfileAutoDelete => 'Automatické mazání chatu';

  @override
  String get contactProfileAutoDeleteTitle => 'Automatické mazání zpráv';

  @override
  String get contactProfileAutoDeleteOff => 'Vypnuto';

  @override
  String get contactProfileAutoDeleteOneDay => 'Po 1 dni';

  @override
  String get contactProfileAutoDeleteSevenDays => 'Po 7 dnech';

  @override
  String get contactProfileAutoDeleteThirtyDays => 'Po 30 dnech';

  @override
  String contactProfileAutoDeleteUpdated(String period) {
    return 'Automatické mazání: $period';
  }

  @override
  String get contactProfileShare => 'Sdílet kontakt';

  @override
  String get contactProfileShareTitle => 'Poslat kontakt do';

  @override
  String get contactProfileShareEmpty => 'Zatím žádné další chaty';

  @override
  String contactProfileShareSent(String name) {
    return 'Odesláno: $name';
  }

  @override
  String get contactProfileRestrictCopying => 'Zakázat kopírování';

  @override
  String get contactProfileAllowCopying => 'Povolit kopírování';

  @override
  String get contactHideAvatar => 'Skrýt mou fotku';

  @override
  String get contactShowAvatar => 'Zobrazit mou fotku';

  @override
  String get contactHideLastSeen => 'Skrýt mé naposledy online';

  @override
  String get contactShowLastSeen => 'Zobrazit mé naposledy online';

  @override
  String get contactHideReadReceipts => 'Skrýt mé časy přečtení';

  @override
  String get contactShowReadReceipts => 'Zobrazit mé časy přečtení';

  @override
  String get contactHiddenFromThem => 'Skryto před tímto kontaktem';

  @override
  String get contactRefuseCalls => 'Nepřijímat jeho hovory';

  @override
  String get contactAllowCalls => 'Přijímat jeho hovory';

  @override
  String get contactCallsException => 'Výjimka z vašeho nastavení hovorů';

  @override
  String get contactProfileCopyingRestricted =>
      'Kopírování a přeposílání je zakázáno';

  @override
  String get contactProfileCopyingRestrictedByPeer => 'Zakázáno druhou stranou';

  @override
  String get contactProfileCopyingAllowed =>
      'Kopírování a přeposílání je povoleno';

  @override
  String get contactProfileDelete => 'Odstranit z kontaktů';

  @override
  String get contactProfileRestore => 'Vrátit do kontaktů';

  @override
  String get contactProfileRestoreDone => 'Znovu ve vašich kontaktech';

  @override
  String get contactProfileDeleteTitle => 'Odebrat kontakt?';

  @override
  String contactProfileDeleteMessage(String name) {
    return '$name zmizí z Kontaktů. Historie chatu na tomto zařízení zůstane.';
  }

  @override
  String get contactProfileMedia => 'Média';

  @override
  String get contactProfileVoiceMessages => 'Hlasové zprávy';

  @override
  String get contactProfileStickers => 'Nálepky';

  @override
  String get contactProfileNoStickers => 'Zatím žádné nálepky';

  @override
  String get contactProfileNoMedia => 'Zatím žádná média';

  @override
  String get contactProfileNoVoiceMessages => 'Zatím žádné hlasové zprávy';

  @override
  String get contactProfileOpen => 'Otevřít profil';

  @override
  String autoDeleteDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dní',
      few: '$count dny',
      one: '$count den',
    );
    return '$_temp0';
  }

  @override
  String autoDeleteHours(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count hodin',
      few: '$count hodiny',
      one: '$count hodina',
    );
    return '$_temp0';
  }

  @override
  String autoDeleteMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count minut',
      few: '$count minuty',
      one: '$count minuta',
    );
    return '$_temp0';
  }

  @override
  String autoDeleteSeconds(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count sekund',
      few: '$count sekundy',
      one: '$count sekunda',
    );
    return '$_temp0';
  }

  @override
  String get autoDeleteCustom => 'Vlastní…';

  @override
  String get autoDeleteCustomHint => 'Počet';

  @override
  String get autoDeleteUnitMinutes => 'min';

  @override
  String get autoDeleteUnitHours => 'hod';

  @override
  String get autoDeleteUnitDays => 'dní';

  @override
  String get contactProfileAutoDeleteSet => 'Nastavit';

  @override
  String get contactProfileFiles => 'Soubory';

  @override
  String get contactProfileNoFiles => 'Zatím žádné soubory';

  @override
  String get contactProfileLinks => 'Odkazy';

  @override
  String get contactProfileNoLinks => 'Zatím žádné odkazy';

  @override
  String get contactProfilePolls => 'Ankety';

  @override
  String get contactProfileNoPolls => 'Zatím žádné ankety';

  @override
  String get presenceRecently => 'naposledy nedávno';

  @override
  String get presenceJustNow => 'právě teď';

  @override
  String presenceHoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'naposledy před $count hodinami',
      few: 'naposledy před $count hodinami',
      one: 'naposledy před $count hodinou',
    );
    return '$_temp0';
  }

  @override
  String presenceYesterdayAt(String time) {
    return 'naposledy včera v $time';
  }

  @override
  String presenceOnWeekday(String day) {
    String _temp0 = intl.Intl.selectLogic(
      day,
      {
        '1': 'naposledy v pondělí',
        '2': 'naposledy v úterý',
        '3': 'naposledy ve středu',
        '4': 'naposledy ve čtvrtek',
        '5': 'naposledy v pátek',
        '6': 'naposledy v sobotu',
        '7': 'naposledy v neděli',
        'other': 'naposledy tento týden',
      },
    );
    return '$_temp0';
  }

  @override
  String presenceWeeksAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'naposledy před $count týdny',
      few: 'naposledy před $count týdny',
      one: 'naposledy před týdnem',
    );
    return '$_temp0';
  }

  @override
  String presenceMonthsAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'naposledy před $count měsíci',
      few: 'naposledy před $count měsíci',
      one: 'naposledy před měsícem',
    );
    return '$_temp0';
  }

  @override
  String get presenceLongAgo => 'naposledy dávno';

  @override
  String presenceMinutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'naposledy před $count minutami',
      few: 'naposledy před $count minutami',
      one: 'naposledy před $count minutou',
    );
    return '$_temp0';
  }

  @override
  String chatReadByCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Přečteno: $count',
      few: 'Přečteno: $count',
      one: 'Přečteno: $count',
    );
    return '$_temp0';
  }

  @override
  String get chatsSearchFrequent => 'Lidé, se kterými mluvíte';

  @override
  String get chatsSearchRecent => 'Nedávné';

  @override
  String get chatsSearchClear => 'Vymazat';

  @override
  String get chatsSearchStartHint =>
      'Hledejte chaty podle názvu nebo jakoukoli zprávu podle slov.';

  @override
  String get chatsSearchEmpty => 'Nic neodpovídá';

  @override
  String get chatRoutesTitle => 'Jak se to k němu dostane';

  @override
  String get chatRoutesBluetoothHint =>
      'Rovnou do jeho telefonu, bez internetu';

  @override
  String get chatRoutesMeshHint => 'Předají ji telefony mezi vámi';

  @override
  String get chatRoutesInternetHint => 'Přes relé, když nikdo není v dosahu';

  @override
  String get chatRoutesHint =>
      'Cesta se volí pro každou zprávu zvlášť podle toho, co je v tu chvíli dostupné.';

  @override
  String get chatRoutesPreferTitle => 'Co zkusit nejdřív';

  @override
  String get chatRoutesPreferMesh => 'Nejdřív Bluetooth';

  @override
  String get chatRoutesPreferMeshHint =>
      'V jedné místnosti rychlejší, nestojí data a relé nic neprozradí';

  @override
  String get chatRoutesPreferRelay => 'Nejdřív internet';

  @override
  String get chatRoutesPreferRelayHint =>
      'Při slabém Bluetooth a dobrém připojení';

  @override
  String get chatRoutesPreferNote =>
      'Je to preference, ne zámek. Když zvolená cesta není dostupná, zprávu ponese ta druhá.';

  @override
  String get deadmanTitle => 'Vymazat při nepoužívání';

  @override
  String get deadmanOff => 'Vypnuto';

  @override
  String deadmanDays(int days) {
    return 'Po $days dnech';
  }

  @override
  String get deadmanHint =>
      'Pokud aplikaci nikdo tak dlouho neotevře, vše v ní se při příštím otevření vymaže. Předem varovat nemůže — právě o to jde.';

  @override
  String chatForwardedFrom(String name) {
    return 'Přeposláno od: $name';
  }

  @override
  String appLockWait(String left) {
    return 'Příliš mnoho pokusů — počkejte $left';
  }

  @override
  String get appLockGraceTitle => 'Žádat kód';

  @override
  String get appLockGraceNow => 'Pokaždé';

  @override
  String appLockGraceAfter(String left) {
    return 'Po $left nepřítomnosti';
  }

  @override
  String get chatCalendarTitle => 'Podle data';

  @override
  String get chatCalendarEmpty => 'Zatím tu nic nezaznělo';

  @override
  String get chatsSearchChatsSection => 'Chaty';

  @override
  String get chatsSearchMessagesSection => 'Zprávy';

  @override
  String get contactProfileViewInChat => 'Zobrazit v chatu';

  @override
  String get chatDraft => 'Koncept';

  @override
  String get chatSearchTitle => 'Hledat';

  @override
  String get chatSearchHint => 'Hledat ve zprávách';

  @override
  String get chatSearchNoResults => 'Žádné shody';

  @override
  String get chatSearchPrevious => 'Předchozí výsledek';

  @override
  String get chatSearchNext => 'Další výsledek';

  @override
  String chatMessageCount(int count) {
    return 'Zpráv: $count';
  }

  @override
  String get chatRouteBluetooth => 'Bluetooth';

  @override
  String get chatRouteMesh => 'Mesh';

  @override
  String get chatRouteInternet => 'Internet';

  @override
  String get chatRouteQueued => 'Ve frontě';

  @override
  String get attachStickers => 'Nálepky';

  @override
  String get stickersEmpty => 'Zatím žádné nálepky';

  @override
  String get stickersEmptyHint => 'Uložte si obrázek z chatu a objeví se tady.';

  @override
  String get stickerKeep => 'Uložit jako nálepku';

  @override
  String get stickerKept => 'Uloženo do vašich nálepek';

  @override
  String get stickerForget => 'Odebrat nálepku';

  @override
  String get stickerCreate => 'Vytvořit nálepku z fotky';

  @override
  String get stickerFailed => 'Z tohoto obrázku se nálepku vytvořit nepodařilo';

  @override
  String get stickerLabel => 'Nálepka';

  @override
  String get previewPhoto => 'Fotka';

  @override
  String get previewVoice => 'Hlasová zpráva';

  @override
  String get previewFile => 'Soubor';

  @override
  String get stickerEmojiTitle => 'Vyberte k ní emoji';

  @override
  String get stickersMine => 'Moje nálepky';

  @override
  String get stickersStarterPack => 'Cubi';

  @override
  String get emojiTab => 'Emoji';

  @override
  String get chatBlockedStatus => 'blokováno';

  @override
  String get chatBlockedHint => 'Tohoto člověka jste zablokovali';

  @override
  String get chatRouteFallbackOff => 'Internet vyp.';

  @override
  String get chatAttachmentUnavailable =>
      'Není k dispozici žádné připojení. Připojte se přes Bluetooth nebo internet a zkuste to znovu.';

  @override
  String get fileTransfersTitle => 'Přenosy souborů';

  @override
  String get fileTransfersClear => 'Vymazat historii';

  @override
  String get fileTransfersEmpty => 'Zatím žádné přenosy souborů';

  @override
  String get fileTransfersActive => 'Aktivní';

  @override
  String get fileTransfersHistory => 'Historie';

  @override
  String get fileTransferPause => 'Pozastavit';

  @override
  String get fileTransferResume => 'Pokračovat';

  @override
  String get fileTransferRetry => 'Zkusit znovu';

  @override
  String get fileTransferQueued => 'Čeká na připojení';

  @override
  String get fileTransferRunning => 'Přenáší se';

  @override
  String get fileTransferPaused => 'Pozastaveno';

  @override
  String get fileTransferCompleted => 'Dokončeno';

  @override
  String get fileTransferFailed => 'Selhalo';

  @override
  String get fileTransferCanceled => 'Zrušeno';

  @override
  String get profileFileTransfers => 'Přenosy souborů';

  @override
  String get profileFileTransfersSubtitle =>
      'Průběh, fronta a historie přenosů';

  @override
  String get qrScanAction => 'Naskenovat QR kód';

  @override
  String get qrScanTitle => 'Skenovat QR kód';

  @override
  String get qrScanHint =>
      'Naskenujte kód CubeChat pro kontakt, kanál, přenos účtu nebo přihlášení počítače.';

  @override
  String get qrFlash => 'Svítilna';

  @override
  String get qrCameraError =>
      'Kamera není k dispozici. Zkontrolujte oprávnění ke kameře a zkuste to znovu.';

  @override
  String get qrInvalid => 'Toto není platný QR kód Cubechat.';

  @override
  String qrChannelAdded(String name) {
    return '$name přidán';
  }

  @override
  String get qrShow => 'Zobrazit QR kód';

  @override
  String qrChannelTitle(String name) {
    return 'Připojit se k $name';
  }

  @override
  String get profileBackup => 'Šifrovaná záloha';

  @override
  String get profileBackupSubtitle =>
      'Bezpečný přesun klíčů, kontaktů a historie';

  @override
  String get backupTitle => 'Šifrovaná záloha';

  @override
  String get backupExplainer =>
      'Záloha obsahuje vaše soukromé klíče identity, kontakty, kanály, nastavení a historii zpráv. Šifruje se na tomto telefonu heslem, které si zvolíte; zapomenuté heslo Cubechat obnovit nedokáže.';

  @override
  String get backupCreate => 'Vytvořit zálohu';

  @override
  String get backupCreateSubtitle =>
      'Zašifrovat vše a uložit soubor .cchatbackup';

  @override
  String get backupRestore => 'Obnovit zálohu';

  @override
  String get backupRestoreSubtitle =>
      'Nahradit profil Cubechat v tomto telefonu ze souboru zálohy';

  @override
  String get backupPasswordTitle => 'Heslo zálohy';

  @override
  String get backupPasswordHint => 'Alespoň 8 znaků';

  @override
  String get backupConfirmPassword => 'Zopakujte heslo';

  @override
  String get backupPasswordMismatch => 'Hesla se neshodují';

  @override
  String get backupPasswordShort => 'Použijte alespoň 8 znaků';

  @override
  String get backupSaveTitle => 'Uložit zálohu Cubechat';

  @override
  String get backupSaved => 'Šifrovaná záloha uložena';

  @override
  String get backupWhereTitle => 'Kam zálohu uložit?';

  @override
  String get backupSaveToFiles => 'Uložit do Souborů';

  @override
  String get backupSaveToFilesHint =>
      'Složka v tomto telefonu, paměťová karta nebo cloudové úložiště';

  @override
  String get backupSendToApp => 'Poslat do aplikace';

  @override
  String get backupSendToAppHint =>
      'Telegram, e-mail, messenger — cokoli, co přijímá soubory';

  @override
  String get backupFailed => 'Operaci se zálohou se nepodařilo dokončit';

  @override
  String get backupRestoreConfirmTitle => 'Nahradit tento profil?';

  @override
  String get backupRestoreConfirmMessage =>
      'Současné klíče, kontakty, kanály, nastavení a historie v tomto telefonu budou nahrazeny vybranou zálohou.';

  @override
  String get backupRestoreConfirmAction => 'Obnovit';

  @override
  String get backupRestored => 'Záloha obnovena';

  @override
  String get backupPackingWait => 'Vytváření zálohy…';

  @override
  String get backupUnpackingWait => 'Obnovování zálohy…';

  @override
  String get backupWaitHint =>
      'S fotkami a videi to může trvat několik minut. Nechte aplikaci otevřenou.';

  @override
  String get backupInvalid =>
      'Špatné heslo, poškozený soubor nebo nepodporovaná záloha';

  @override
  String get channelInfoTitle => 'Podrobnosti kanálu';

  @override
  String get channelParticipantsTitle => 'Účastníci';

  @override
  String get channelAdministratorsTitle => 'Správci';

  @override
  String get channelMakeAdmin => 'Jmenovat správcem';

  @override
  String get channelRemoveAdmin => 'Odebrat správce';

  @override
  String get channelNoParticipants =>
      'Účastníci se objeví po podepsané aktivitě';

  @override
  String get channelSharedContent => 'Média, soubory a ankety';

  @override
  String get channelDescriptionTitle => 'Popis';

  @override
  String get channelDescriptionEmpty => 'Zatím bez popisu';

  @override
  String get channelDescriptionHint => 'K čemu tento kanál slouží';

  @override
  String get channelDescriptionAdminOnly => 'Popis může měnit jen správce';

  @override
  String get channelDescriptionSave => 'Uložit';

  @override
  String get channelPrivateSubtitle => 'soukromý kanál';

  @override
  String get channelAvatarSet => 'Nastavit novou fotku';

  @override
  String get channelSettingsTitle => 'Nastavení kanálu';

  @override
  String get channelSettingsHint => 'Kdo smí psát, kopírování, historie';

  @override
  String get channelLeaveAction => 'Opustit';

  @override
  String get channelLeaveConfirm =>
      'Místnost a vše, co v ní zaznělo, zmizí z tohoto telefonu. Klíč vychází z názvu, takže ji můžete znovu otevřít zadáním stejného názvu.';

  @override
  String get channelShareAction => 'Sdílet';

  @override
  String channelMembersOf(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count členů',
      few: '$count členové',
      one: '1 člen',
    );
    return '$_temp0';
  }

  @override
  String get chatTyping => 'píše…';

  @override
  String get chatRecordingVoice => 'nahrává hlasovou zprávu…';

  @override
  String get chatRecordingCircle => 'nahrává videozprávu…';

  @override
  String get chatSendingPhoto => 'posílá fotku…';

  @override
  String get chatSendingVideo => 'posílá video…';

  @override
  String get chatSendingFile => 'posílá soubor…';

  @override
  String get onboardingMeshTitle => 'Funguje bez internetu';

  @override
  String get onboardingMeshBody =>
      'Zprávy putují přes Bluetooth z telefonu do telefonu. Bez signálu, bez Wi-Fi, bez účtů — jen lidé kolem vás.';

  @override
  String get onboardingRelayTitle => 'A s ním, když nějaký je';

  @override
  String get onboardingRelayBody =>
      'Mimo dosah Bluetooth jdou zprávy přes internet a dorazí stejně. Nikdy nemusíte vybírat.';

  @override
  String get onboardingPrivacyTitle => 'Nikdo mezi vámi to nepřečte';

  @override
  String get onboardingPrivacyBody =>
      'Vše je koncově šifrované a vaše identita je klíč v tomto telefonu — ne telefonní číslo, ne e-mail, ne účet, který vám může někdo vzít.';

  @override
  String get onboardingSkip => 'Přeskočit';

  @override
  String get onboardingNext => 'Další';

  @override
  String get onboardingStart => 'Začít';

  @override
  String get chatMediaShare => 'Sdílet';

  @override
  String get chatMediaSaveToGallery => 'Uložit do galerie';

  @override
  String get chatMediaShowInChat => 'Zobrazit v chatu';

  @override
  String get chatWallpaperTitle => 'Tapeta';

  @override
  String get chatWallpaperClear => 'Obnovit výchozí';

  @override
  String get chatWallpaperDim => 'Ztmavit za zprávami';

  @override
  String get chatSelectAction => 'Vybrat';

  @override
  String get chatForwardNothing => 'Nic tu nelze přeposlat';

  @override
  String chatSelectedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Vybráno $count',
      few: 'Vybrány $count',
      one: 'Vybrána 1',
    );
    return '$_temp0';
  }

  @override
  String chatDeleteSelectedTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Smazat $count zpráv?',
      few: 'Smazat $count zprávy?',
      one: 'Smazat tuto zprávu?',
    );
    return '$_temp0';
  }

  @override
  String get contactAliasAction => 'Přejmenovat kontakt';

  @override
  String get contactAliasHint =>
      'Toto jméno vidíte jen vy. Necháte-li pole prázdné, použije se jeho vlastní.';

  @override
  String get viewOnceSendLabel => 'Jedno zobrazení';

  @override
  String get viewOnceTitle => 'Jedno zobrazení';

  @override
  String get viewOnceTapToView => 'Fotka · klepnutím zobrazíte jednou';

  @override
  String get viewOnceSent => 'Fotka · odesláno';

  @override
  String get viewOnceOpened => 'Fotka otevřena';

  @override
  String get viewOnceUnavailable => 'Tato fotka už není k dispozici';

  @override
  String get viewOnceWarning => 'Zavřením se fotka smaže vám oběma.';

  @override
  String get channelAvatarAdminOnly => 'Fotku kanálu může měnit jen správce';

  @override
  String get channelAdminOnly => 'Toto může měnit jen správce';

  @override
  String get channelAvatarTooLarge => 'Tato fotka je na rozeslání příliš velká';

  @override
  String get channelMemberUnknown => 'Zatím není ve vašich kontaktech';

  @override
  String get channelInviteToContacts => 'Poslat mu svou kontaktní kartu';

  @override
  String channelContactInviteSent(String name) {
    return 'Kontaktní karta nabídnuta: $name';
  }

  @override
  String get chatContactInvitation => 'Pozvánka ke spojení';

  @override
  String get chatContactInvitationForYou => 'Pozvánka pro vás';

  @override
  String get channelPollTitle => 'Anketa';

  @override
  String get channelCreatePoll => 'Vytvořit anketu';

  @override
  String get channelPollQuestion => 'Otázka';

  @override
  String channelPollOption(int number) {
    return 'Možnost $number';
  }

  @override
  String get channelPollAddOption => 'Přidat možnost';

  @override
  String get channelPollCreate => 'Zveřejnit anketu';

  @override
  String channelPollVotes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count hlasů',
      few: '$count hlasy',
      one: '1 hlas',
      zero: 'Žádné hlasy',
    );
    return '$_temp0';
  }

  @override
  String get phoneTransferTitle => 'Přenos do nového telefonu';

  @override
  String get desktopPickChat => 'Vyberte, komu chcete napsat';

  @override
  String get desktopListCollapse => 'Zobrazit jen tváře';

  @override
  String get desktopListExpand => 'Zobrazit seznam chatů';

  @override
  String get desktopLinkConnectTitle => 'Připojit počítač';

  @override
  String get desktopLinkConnectHint =>
      'Naskenujte kód, který CubeChat zobrazuje na počítači';

  @override
  String get desktopLinkSignIn => 'Přihlásit se účtem z telefonu';

  @override
  String get desktopLinkTitle => 'Přihlášení telefonem';

  @override
  String get desktopLinkSteps =>
      'V telefonu: Profil → Data → Připojit počítač, pak naskenujte tento kód. Obě zařízení musí být na stejné Wi-Fi.';

  @override
  String get desktopLinkLimits =>
      'Telefon funguje dál. Zprávy z internetu dorazí na obě zařízení; co odešlete z jednoho, se na druhém zatím nezobrazí.';

  @override
  String get desktopLinkWaiting => 'Čeká se na telefon…';

  @override
  String get desktopLinkFailed =>
      'Účet se nepodařilo přijmout. Zkuste to znovu.';

  @override
  String get desktopLinkRetry => 'Zkusit znovu';

  @override
  String get desktopLinkConfirmTitle => 'Poslat kopii tohoto účtu do počítače?';

  @override
  String get desktopLinkConfirmMessage =>
      'Počítač dostane vaše klíče, kontakty a chaty. Tento telefon bude fungovat dál jako dosud.';

  @override
  String get desktopLinkConfirmAction => 'Odeslat';

  @override
  String desktopLinkConfirmWhere(String address) {
    return 'Jen pokud jste tento kód právě naskenovali z obrazovky vlastního počítače. Kopie půjde na $address v této síti.';
  }

  @override
  String get desktopLinkSending => 'Odesílání účtu…';

  @override
  String get desktopLinkSent => 'Počítač je připojen';

  @override
  String get desktopLinkPhoneFound =>
      'Telefon našel tento počítač a vytváří kopii účtu. S fotkami to může trvat několik minut.';

  @override
  String desktopLinkReceiving(int percent) {
    return 'Přijímání účtu: $percent %';
  }

  @override
  String get desktopLinkRestoring => 'Ukládání účtu do tohoto počítače…';

  @override
  String get desktopLinkFinding => 'Hledání počítače…';

  @override
  String get desktopLinkPreparing =>
      'Vytváří se kopie účtu. S fotkami to může trvat několik minut.';

  @override
  String desktopLinkSendingPercent(int percent) {
    return 'Odesílání: $percent %';
  }

  @override
  String get desktopLinkComputerRestoring => 'Počítač ukládá účet…';

  @override
  String get devicesTitle => 'Zařízení';

  @override
  String get devicesRowHint => 'Kde je váš účet otevřený a odhlášení tam';

  @override
  String get devicesThisDevice => 'Toto zařízení';

  @override
  String get devicesSeenNow => 'Online právě teď';

  @override
  String devicesSeenMinutes(int n) {
    return 'Online před $n min';
  }

  @override
  String devicesSeenHours(int n) {
    return 'Online před $n h';
  }

  @override
  String devicesSeenDays(int n) {
    return 'Online před $n d';
  }

  @override
  String get devicesLeaving => 'Odhlašování — čeká se, až bude online';

  @override
  String get devicesSignOut => 'Odhlásit';

  @override
  String get devicesSignOutAll => 'Odhlásit všechna ostatní zařízení';

  @override
  String devicesSignOutTitle(String name) {
    return 'Odhlásit zařízení „$name“?';
  }

  @override
  String get devicesSignOutMessage =>
      'Klíče, chaty a nastavení CubeChat budou na tom zařízení vymazány, jakmile bude online. Účet zůstane tady a na vašich dalších zařízeních.';

  @override
  String get devicesSignOutPhoneMessage =>
      'Je to telefon: CubeChat v něm bude vymazán celý. Účet zůstane tady a na vašich dalších zařízeních.';

  @override
  String get devicesSignOutAllMessage =>
      'Všechna ostatní zařízení se odhlásí, jakmile budou online. Účet zůstane jen tady.';

  @override
  String get devicesRename => 'Přejmenovat';

  @override
  String get devicesRenameTitle => 'Název tohoto zařízení';

  @override
  String get devicesSave => 'Uložit';

  @override
  String get devicesEmpty =>
      'Zatím žádná další zařízení. Zařízení se tu objeví, jakmile otevře CubeChat 1.0.0+1147 nebo novější.';

  @override
  String get devicesCaveat =>
      'Odhlášení se projeví, až bude to zařízení online. Zařízení držené offline si klíče ponechá; plná ochrana by znamenala nové klíče účtu.';

  @override
  String get desktopLinkImportTitle => 'Přesunout účet z telefonu';

  @override
  String get desktopLinkImportHint =>
      'Ukažte telefonu kód a tento počítač se stane kopií jeho účtu';

  @override
  String get desktopLinkImportConfirmTitle => 'Nahradit účet v tomto počítači?';

  @override
  String get desktopLinkImportConfirmMessage =>
      'Klíče, kontakty a chaty tohoto počítače budou nahrazeny účtem z telefonu. Pokud tento účet ještě potřebujete, nejdřív si udělejte zálohu.';

  @override
  String get desktopLinkImportConfirmAction => 'Pokračovat';

  @override
  String get desktopLinkUnreachable =>
      'Počítač se nepodařilo zastihnout. Obě zařízení musí být na stejné Wi-Fi a na počítači musí mít CubeChat povolený průchod firewallem.';

  @override
  String get desktopLinkFirewallHint =>
      'Windows může telefonu bránit v přístupu k tomuto počítači. Povolte CubeChat ve firewallu — jen pro vaši místní síť.';

  @override
  String get desktopLinkFirewallAllow => 'Povolit ve firewallu';

  @override
  String get desktopLinkFirewallDeclined =>
      'Windows to nepovolil. Bez toho se telefon nemusí spojit.';

  @override
  String get phoneTransferIntro =>
      'Přeneste profil, klíče, kontakty, kanály, nastavení a historii přímo mezi dvěma telefony.';

  @override
  String get phoneTransferSend => 'Toto je starý telefon';

  @override
  String get phoneTransferReceive => 'Toto je nový telefon';

  @override
  String get phoneTransferSameWifi =>
      'Připojte oba telefony ke stejné Wi-Fi. Nechte tuto obrazovku otevřenou, dokud přenos neskončí.';

  @override
  String get phoneTransferPreparing => 'Příprava šifrovaného přenosu…';

  @override
  String get phoneTransferReady =>
      'Naskenujte tento jednorázový QR kód novým telefonem';

  @override
  String get phoneTransferScan => 'Naskenovat starý telefon';

  @override
  String get phoneTransferConfirmTitle => 'Nahradit profil v tomto telefonu?';

  @override
  String get phoneTransferConfirmMessage =>
      'Profil uložený v tomto telefonu bude nahrazen šifrovaným místním přenosem.';

  @override
  String get phoneTransferConfirmAction => 'Přenést profil';

  @override
  String get phoneTransferSuccess => 'Profil byl úspěšně přenesen';

  @override
  String get phoneTransferFailed => 'Přenos telefonu se nepodařilo dokončit';

  @override
  String get profileSummaryMeshOnly => 'Jen mesh';

  @override
  String get profileSummaryMeshInternet => 'Mesh · internet';

  @override
  String get profileSummaryBackgroundOn => 'běží na pozadí';

  @override
  String profileSummaryTransfersActive(int count) {
    return 'Probíhá: $count';
  }

  @override
  String get profileSummaryCardBackup => 'Soubory, záloha';

  @override
  String get chatPlay => 'Přehrát';

  @override
  String get chatPause => 'Pozastavit';

  @override
  String get profileTheme => 'Barva';

  @override
  String get profileThemeEmerald => 'Smaragd';

  @override
  String get profileThemeIndigo => 'Indigo';

  @override
  String get profileThemeAmber => 'Jantar';

  @override
  String get profileThemeRose => 'Růže';

  @override
  String get profileThemeFuchsia => 'Fuchsie';

  @override
  String get profileThemeViolet => 'Fialka';

  @override
  String get profileThemeOcean => 'Oceán';

  @override
  String get profileThemeSlate => 'Břidlice';

  @override
  String get profileScale => 'Velikost rozhraní';

  @override
  String get profileScaleSystem => 'Systémová';

  @override
  String get profileGlass => 'Sklo';

  @override
  String get profileGlassAuto => 'Automaticky';

  @override
  String get profileGlassFull => 'Plné';

  @override
  String get profileGlassLight => 'Odlehčené';

  @override
  String get profileGlassHint =>
      'Odlehčené ponechá tónování a vypne rozmazání za panely. Automaticky jednou změří váš telefon a rozhodne. Na telefonu, který už stíhá, to přinese jen málo — je to pro ten, který nestíhá.';

  @override
  String get mapAlwaysNeeded =>
      'Aby se mapa aktualizovala i se zavřeným cubechat, musí být Poloha nastavena na Vždy. Klepnutím otevřete Nastavení.';

  @override
  String get mapShareConsentTitle => 'Zobrazit vaši polohu na mapě?';

  @override
  String get mapShareConsentBody =>
      'Vaše živá poloha se zobrazí jen kontaktům na vaší mapě: lidem, které jste pozvali nebo jejichž pozvánku jste přijali. Průběžně se aktualizuje, i když je Cubechat na pozadí, dokud se neskryjete. Je koncově šifrovaná a nikdy se k nám nedostane. Skrýt se můžete kdykoli na mapě nebo v Profilu a kontakty, které zablokujete, vás nikdy neuvidí.';

  @override
  String get mapShareConsentAllow => 'Povolit';

  @override
  String get mapShareConsentDecline => 'Nepovolovat';

  @override
  String get mapVisibleToFriends => 'Přátelé na mapě vás vidí';

  @override
  String get mapHiddenFromFriends => 'Jste skrytí';

  @override
  String get mapHideMe => 'Skrýt se';

  @override
  String get mapShowMe => 'Zobrazit mě';

  @override
  String get profileScaleSmall => 'Menší';

  @override
  String get profileScaleNormal => 'Normální';

  @override
  String get profileScaleLarge => 'Větší';

  @override
  String get profileScaleSample =>
      'Text a řádky se vykreslují v této velikosti.';

  @override
  String get savedTitle => 'Uložené';

  @override
  String get savedSubtitle => 'Poznámky pro sebe, na tomto zařízení';

  @override
  String get savedEmpty => 'Cokoli sem napíšete, zůstane v tomto telefonu.';

  @override
  String get meshOffTitle => 'Bluetooth mesh je vypnutý';

  @override
  String get meshOffHint =>
      'Nikdo poblíž vás nenajde a vy nenajdete je. Zprávy dál putují přes internetové relé.';

  @override
  String get profileMeshSwitch => 'Bluetooth mesh';

  @override
  String get profileMeshSwitchHint =>
      'Hledá lidi poblíž a přenáší zprávy bez internetu. Vypnutím ušetříte baterii.';

  @override
  String get channelAdminOnlyHint => 'Kanál oznámení. Číst ho mohou všichni.';

  @override
  String get attachLocation => 'Poloha';

  @override
  String get locationBubbleTitle => 'Poloha';

  @override
  String get locationOpenInMaps => 'Otevřít v mapách';

  @override
  String locationAccuracy(int metres) {
    return 's přesností $metres m';
  }

  @override
  String get locationExpired => 'Tato poloha už není aktuální';

  @override
  String get locationDenied => 'Oprávnění k poloze je vypnuté';

  @override
  String get locationUnavailable => 'Polohu se nepodařilo zjistit';

  @override
  String get locationShareFor => 'Sdílet na';

  @override
  String get locationShareOnce => 'Jen jednou';

  @override
  String get locationShare15m => '15 minut';

  @override
  String get locationShare1h => '1 hodinu';

  @override
  String get storageTitle => 'Úložiště';

  @override
  String get storageHeadline => 'Využití úložiště';

  @override
  String storageSubtitle(String size) {
    return 'cubechat na tomto zařízení zabírá $size';
  }

  @override
  String get storageEmpty => 'Zatím nic uloženo';

  @override
  String get storageScanning => 'Měření…';

  @override
  String get storageCatPhotos => 'Fotky';

  @override
  String get storageCatVoice => 'Hlasové zprávy';

  @override
  String get storageCatFiles => 'Přijaté soubory';

  @override
  String get storageCatOutbox => 'Odeslané soubory';

  @override
  String get storageCatStickers => 'Nálepky';

  @override
  String get storageCatSaved => 'Uložené zprávy';

  @override
  String get storageCatWallpapers => 'Tapety';

  @override
  String get storageCatHistory => 'Konverzace a klíče';

  @override
  String get storageCatCache => 'Mezipaměť';

  @override
  String storageClear(String size) {
    return 'Vymazat $size';
  }

  @override
  String get storageClearNothing => 'Nic nevybráno';

  @override
  String storageFreed(String size) {
    return 'Uvolněno $size';
  }

  @override
  String get storageNoCloud =>
      'Za tím není žádný cloud. Cokoli vymažete, z tohoto telefonu zmizí a jediná další kopie je v telefonu, odkud to přišlo.';

  @override
  String get storageWhyHistoryLocked =>
      'Konverzace se odsud nemažou — použijte Nouzové vymazání.';

  @override
  String get storageRecoveryFree => 'Lze bezpečně vymazat';

  @override
  String get storageRecoveryGone => 'Kopie nikde jinde není';

  @override
  String get storageRecoveryAskSender => 'Lze znovu vyžádat od odesílatele';

  @override
  String get storageRecoveryCostsThem =>
      'Už vás nebudou moci požádat o opětovné odeslání';

  @override
  String storageConfirmTitle(String size) {
    return 'Vymazat $size?';
  }

  @override
  String get storageConfirmBody =>
      'Soubory se smažou z tohoto telefonu. Nic se nikam nenahrává, takže je nebude odkud obnovit.';

  @override
  String storageFilesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count souborů',
      few: '$count soubory',
      one: '$count soubor',
      zero: 'prázdné',
    );
    return '$_temp0';
  }

  @override
  String get customizeBarTitle => 'Navigační lišta';

  @override
  String get customizeBarHint =>
      'Pořadí změníte přetažením. Chaty nelze odebrat.';

  @override
  String get customizeBarShown => 'Zobrazené';

  @override
  String get customizeBarHidden => 'Skryté';

  @override
  String get customizeBarHiddenEmpty => 'Nic není skryté';

  @override
  String get customizeBarMinimum => 'Ponechte aspoň dvě karty';

  @override
  String get customizeReset => 'Obnovit výchozí';

  @override
  String get chatsArchiveTitle => 'Archiv';

  @override
  String get chatsArchiveEmpty => 'Nic není archivováno';

  @override
  String get chatsArchiveHint =>
      'Archivované chaty fungují dál — jen nejsou v seznamu.';

  @override
  String get chatsArchivedToast => 'Archivováno';

  @override
  String get chatsUnarchivedToast => 'Zpět v seznamu';

  @override
  String chatsArchiveCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count chatů',
      few: '$count chaty',
      one: '$count chat',
    );
    return '$_temp0';
  }

  @override
  String get chatsSwipeNotHere => 'Pro tento chat není dostupné';

  @override
  String get customizeSwipeTitle => 'Přejetí chatu doprava';

  @override
  String get customizeSwipeHint => 'Přejetím doleva se dál přepínají karty.';

  @override
  String get customizeSwipeArchive => 'Archivovat';

  @override
  String get customizeSwipeMute => 'Ztlumit';

  @override
  String get customizeSwipePin => 'Připnout';

  @override
  String get customizeSwipeRead => 'Přečteno';

  @override
  String get customizeSwipeDelete => 'Smazat';

  @override
  String get customizeSwipeNone => 'Nic';

  @override
  String get customizeHighRefresh => 'Plná obnovovací frekvence';

  @override
  String get customizeHighRefreshHint =>
      'Plynulejší, ale telefon vykresluje dvakrát víc snímků. Pokud se zahřívá, vypněte to — vzhled aplikace se nezmění, jen jak často se překresluje.';

  @override
  String get customizeQuickReaction => 'Reakce dvojím klepnutím';

  @override
  String get customizeQuickReactionHint =>
      'Co zanechá dvojí klepnutí na zprávu. Když použijete jinou, přesune se sem.';

  @override
  String get customizeCircleAudioTitle => 'Pozastavit hudbu u videozpráv';

  @override
  String get customizeCircleAudioOn =>
      'Nahrávání nebo přehrávání videozprávy zastaví vše ostatní, co hraje. Samo se to pak znovu nespustí.';

  @override
  String get customizeCircleAudioOff =>
      'Vaše hudba hraje dál v pozadí, tišeji, dokud běží videozpráva.';

  @override
  String get customizeMediaQualityTitle => 'Kvalita odesílaných fotek';

  @override
  String get customizeMediaQualityEconomy => 'Úsporná';

  @override
  String get customizeMediaQualityStandard => 'Běžná';

  @override
  String get customizeMediaQualityHigh => 'Vysoká';

  @override
  String get customizeMediaQualityEconomyHint =>
      'Až 96 KB na fotku, 800 px. Pro jednu čárku signálu nebo přeplněnou Bluetooth mesh: poloviční čekání, měkčí obraz.';

  @override
  String get customizeMediaQualityStandardHint =>
      'Až 192 KB na fotku, 1280 px. Tak, aby prošla i jen přes Bluetooth. Videa a „Originál“ se vždy posílají tak, jak jsou.';

  @override
  String get customizeMediaQualityHighHint =>
      'Až 768 KB na fotku, 2048 px. Dost ostré na přiblížení; odesílání trvá čtyřikrát déle, takže nejlépe přes Wi-Fi.';

  @override
  String get previewReacted => 'na vaši zprávu';

  @override
  String get previewLocation => 'Poloha';

  @override
  String get previewMapInvite => 'Pozvánka na mapu';

  @override
  String get previewContact => 'Kontakt';

  @override
  String get previewUnsupported => 'Nepodporovaná zpráva';

  @override
  String get previewCallOutgoing => 'Odchozí hovor';

  @override
  String get previewCallIncoming => 'Příchozí hovor';

  @override
  String get previewCallMissed => 'Zmeškaný hovor';

  @override
  String chatPreparingPhotos(int count) {
    return 'Příprava fotek: $count…';
  }

  @override
  String get circleSwitchCamera => 'Přepnout kameru';

  @override
  String get circleLight => 'Přisvícení při nahrávání';

  @override
  String get circleCameraSwitchFailed =>
      'Kameru se nepodařilo přepnout. Nahrávání zůstává otevřené.';

  @override
  String get diagnosticsTitle => 'Diagnostika';

  @override
  String get diagnosticsIntro =>
      'Co aplikace v poslední době dělala. Pokud něco nefunguje, pošlete to vývojáři.';

  @override
  String get diagnosticsShare => 'Poslat protokol vývojáři';

  @override
  String get diagnosticsEvents => 'Nedávné události';

  @override
  String get diagnosticsTechnical => 'Technické záznamy';

  @override
  String get diagnosticsEmpty => 'Zatím není co zobrazit.';

  @override
  String get diagnosticsDeveloperOn => 'Režim vývojáře zapnut';

  @override
  String get diagnosticsDeveloperOff => 'Režim vývojáře vypnut';

  @override
  String get logAppStarted => 'Aplikace spuštěna';

  @override
  String get logInternetOn => 'Připojení k internetu zapnuto';

  @override
  String logServerConnected(String host) {
    return 'Připojeno k $host';
  }

  @override
  String logServerLost(String host) {
    return 'Ztraceno spojení s $host';
  }

  @override
  String get chatSaveAction => 'Uložit';

  @override
  String get savedTagAsk => 'Uloženo. Přidat štítek?';

  @override
  String get savedTagAdd => 'Přidat štítek';

  @override
  String get chatSharedWallpaperFailed =>
      'Tapeta nastavena tady. Protějšek ji dostane, až bude v dosahu.';

  @override
  String get chatTranscribeAction => 'Přepsat na text';

  @override
  String get chatTranscribeFailed => 'Tento telefon tuto zprávu přepsat neumí.';

  @override
  String get chatTranscribing => 'Rozpoznávání…';

  @override
  String get chatTranscriptHide => 'Skrýt text';

  @override
  String get chatCancelSend => 'Zrušit odeslání';

  @override
  String get chatDownloadAction => 'Stáhnout';

  @override
  String get chatDownloaded => 'Uloženo do telefonu';

  @override
  String get chatDownloadFailed => 'Nepodařilo se uložit';

  @override
  String get selfUpdateTitle => 'Nainstalovat aktualizaci ze souboru';

  @override
  String get selfUpdateHint =>
      'Nový APK cubechat vyberte tady, místo abyste ho otevírali z chatu: při instalaci touto cestou zůstanou hovory na zamčené obrazovce zapnuté.';

  @override
  String get selfUpdateConfirm => 'Potvrďte instalaci v systémovém okně.';

  @override
  String get selfUpdateAllow =>
      'Povolte cubechat instalovat aplikace a klepněte znovu.';

  @override
  String get selfUpdateNotOurs => 'Tento soubor není aktualizace cubechat.';

  @override
  String get selfUpdateFailed => 'Aktualizace se nenainstalovala.';

  @override
  String get chatTranscribeDownloading =>
      'Telefon k tomu stahuje jazyk. Zkuste to za minutu.';

  @override
  String get chatTranscribeNoLanguage =>
      'Tento telefon nemá řečový model pro tento jazyk. Jazyk přepisu hlasu vyberte v Profil → Chaty a média.';

  @override
  String get chatTranscribeNotAllowed =>
      'Rozpoznávání řeči je pro CubeChat vypnuté. Zapněte ho v Nastavení iPhonu → CubeChat.';

  @override
  String get customizeTranscribeLanguageTitle => 'Jazyk přepisu hlasu';

  @override
  String get customizeTranscribeLanguageAuto => 'Auto';

  @override
  String get customizeTranscribeLanguageHint =>
      'Jazyk, kterým se ve zprávách mluví, nemusí být jazykem aplikace. Auto zkouší jazyky telefonu. Chybějící jazyk si telefon stáhne sám; hlas ho nikdy neopustí.';

  @override
  String get chatTranslateAction => 'Přeložit';

  @override
  String get chatTranslateFailed =>
      'Tuto zprávu nelze na tomto telefonu přeložit.';

  @override
  String get customizeDeferMediaTitle => 'Stahovat média až na Wi-Fi';

  @override
  String get customizeDeferMediaHint =>
      'Na mobilních datech fungují zprávy a hovory jako obvykle, zatímco fotky, hlasové zprávy, videozprávy a soubory čekají na serveru na Wi-Fi — až dva týdny. Řádek nad chaty ukazuje, co čeká, a stáhne to hned.';

  @override
  String heldMediaCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count mediálních souborů čeká na Wi-Fi',
      few: '$count mediální soubory čekají na Wi-Fi',
      one: '1 mediální soubor čeká na Wi-Fi',
    );
    return '$_temp0';
  }

  @override
  String get heldMediaDownload => 'Stáhnout';

  @override
  String get nearbyAirDropSubtitle => 'Sdílejte soubory s lidmi poblíž';

  @override
  String get nearbyFilesSubtitle => 'Odeslané a přijaté soubory';

  @override
  String get airdropTab => 'AirDrop';

  @override
  String get nearbyTabFiles => 'Soubory';

  @override
  String get airdropReceiveHint => 'Kdo vám může posílat soubory';

  @override
  String get airdropReceiveContacts => 'Kontakty';

  @override
  String get airdropReceiveEveryone => 'Všichni 10 min';

  @override
  String airdropEveryoneLeft(String time) {
    return 'Všichni · $time';
  }

  @override
  String get airdropSendFiles => 'Poslat soubory';

  @override
  String get airdropChooseFiles => 'Vybrat soubory';

  @override
  String airdropStagedTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count souborů připraveno',
      few: '$count soubory připraveny',
      one: '1 soubor připraven',
    );
    return '$_temp0';
  }

  @override
  String get airdropStagedHint =>
      'Se zapnutým Bluetooth a otevřeným AirDropem na obou telefonech je přiložte k sobě nebo vyberte člověka';

  @override
  String get airdropStagedPickPerson => 'Vybrat člověka';

  @override
  String airdropRequestBody(String what, String size) {
    return 'chce poslat $what · $size';
  }

  @override
  String airdropWhatPhotos(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count fotek',
      few: '$count fotky',
      one: '1 fotku',
    );
    return '$_temp0';
  }

  @override
  String airdropWhatVideos(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count videí',
      few: '$count videa',
      one: '1 video',
    );
    return '$_temp0';
  }

  @override
  String airdropWhatFiles(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count souborů',
      few: '$count soubory',
      one: '1 soubor',
    );
    return '$_temp0';
  }

  @override
  String get airdropAccept => 'Přijmout';

  @override
  String get airdropDecline => 'Odmítnout';

  @override
  String get airdropWaiting => 'Čeká se na odpověď…';

  @override
  String get airdropAccepted => 'Přijato';

  @override
  String get airdropUnheard => 'Nepřijato — možná stará verze CubeChat';

  @override
  String get airdropSending => 'Odesílání';

  @override
  String get airdropReceiving => 'Přijímání';

  @override
  String get airdropInterrupted => 'Přerušeno';

  @override
  String get airdropRetry => 'Zkusit znovu';

  @override
  String get airdropOutcomeSent => 'Odesláno';

  @override
  String get airdropOutcomeReceived => 'Přijato';

  @override
  String get airdropOutcomeDeclined => 'Odmítnuto';

  @override
  String get airdropOutcomeCancelled => 'Zrušeno';

  @override
  String get airdropOutcomePartial => 'Částečně';

  @override
  String get airdropReasonNoSpace => 'nedostatek místa';

  @override
  String get airdropReasonContactsOnly => 'jen od kontaktů';

  @override
  String get airdropReasonBusy => 'obsazeno';

  @override
  String get airdropReasonTimeout => 'bez odpovědi';

  @override
  String get airdropFileDeleted => 'smazáno';

  @override
  String get airdropHistory => 'Historie';

  @override
  String get airdropClearHistory => 'Vymazat historii';

  @override
  String get airdropEmpty =>
      'Tady budou soubory, které poblíž odešlete nebo přijmete';

  @override
  String get airdropPickPerson => 'Odeslat komu';

  @override
  String get airdropNobody => 'Poblíž zatím nikdo s cubechat není';

  @override
  String get airdropNoDirect => 'S tímto člověkem není spojení přes Bluetooth';

  @override
  String get airdropNearbyUnknown => 'Poblíž';

  @override
  String get airdropConnecting => 'Připojování…';

  @override
  String get airdropConnectFailed => 'Nepodařilo se připojit';

  @override
  String get airdropSlowWarning => 'Přes Bluetooth to může trvat dlouho';

  @override
  String airdropTooLarge(String name, int limit) {
    return '$name je větší než $limit MB';
  }

  @override
  String airdropFromLabel(String name) {
    return 'AirDrop · $name';
  }

  @override
  String get airdropWrite => 'Napsat';

  @override
  String get airdropAction => 'AirDrop';

  @override
  String get airdropLaneTitle => 'Kanál';

  @override
  String get airdropLaneAuto => 'Auto';

  @override
  String get airdropLaneBluetooth => 'Bluetooth';

  @override
  String get airdropLaneWifi => 'Wi‑Fi';

  @override
  String get airdropBluetoothNeededHint =>
      'Zapněte Bluetooth na obou telefonech, aby se navzájem našly a mohly potvrdit přenos.';

  @override
  String get airdropLaneHint =>
      'Bluetooth telefony najde a propojí. Wi‑Fi přenáší soubory, když jsou oba telefony ve stejné síti nebo na stejném hotspotu.';

  @override
  String get airdropWifiUnreachable => 'Nejsou ve stejné síti';

  @override
  String get airdropWifiOldVersion =>
      'Jeho aplikace zatím neumí přijímat přes Wi‑Fi';

  @override
  String get airdropBumpAdd => 'Přidat';

  @override
  String get airdropBumpAlreadyContact => 'Už je ve vašich kontaktech';

  @override
  String airdropBumpSending(String name) {
    return 'Odesílání: $name';
  }

  @override
  String airdropBumpReceiving(String name) {
    return '$name vám posílá soubory';
  }

  @override
  String get termsTitle => 'Pravidla cubechat';

  @override
  String get termsBody =>
      'cubechat netoleruje závadný obsah ani uživatele, kteří ho zneužívají. Pokračováním souhlasíte, že nebudete posílat obtěžování, výhrůžky, sexuální obsah zahrnující nezletilé, spam ani nic nezákonného. Kdokoli může nahlásit zprávu nebo člověka; nahlášení dostane vývojář a vyřídí je do 24 hodin, provinilci jsou zablokováni.';

  @override
  String get termsReadFull => 'Přečíst celé podmínky';

  @override
  String get termsAccept => 'Souhlasím';

  @override
  String get messageHide => 'Skrýt';

  @override
  String get messageHidden => 'Skryto pro vás';

  @override
  String get reportAction => 'Nahlásit';

  @override
  String get reportTitle => 'Co je špatně?';

  @override
  String get reportReasonSpam => 'Spam';

  @override
  String get reportReasonAbuse => 'Urážky nebo obtěžování';

  @override
  String get reportReasonViolence => 'Násilí';

  @override
  String get reportReasonSexual => 'Sexuální obsah';

  @override
  String get reportReasonOther => 'Jiné';

  @override
  String get reportNoteHint => 'Popište (volitelné)';

  @override
  String get reportSend => 'Odeslat hlášení';

  @override
  String get reportDisclosure =>
      'Text vybrané zprávy a vaše hlášení půjdou moderátorům cubechat a jejich soukromému botu v Telegramu.';

  @override
  String get reportSent => 'Hlášení odesláno. Hlášení vyřizujeme do 24 hodin.';

  @override
  String get reportBlockedToo => 'Pro vás je zablokován.';

  @override
  String get reportQueued => 'Hlášení uloženo. Odešle se, až budete online.';

  @override
  String get reportFailed => 'Hlášení se nepodařilo odeslat.';

  @override
  String get filteredMessage => 'Skryto filtrem';

  @override
  String get filteredShow => 'Zobrazit';

  @override
  String get filterToggle => 'Filtr urážlivého obsahu';

  @override
  String get filterToggleHint =>
      'Skrývá hrubá slova od cizích lidí a v kanálech';

  @override
  String get aboutTitle => 'O aplikaci';

  @override
  String get aboutContact => 'Napsat vývojáři';

  @override
  String get aboutReport => 'Nahlásit porušení';

  @override
  String get aboutTerms => 'Podmínky použití';

  @override
  String get aboutPrivacy => 'Zásady ochrany soukromí';

  @override
  String get requestsTitle => 'Žádosti';

  @override
  String get requestsEmpty => 'Žádné žádosti';

  @override
  String requestBanner(String name) {
    return '$name není ve vašich kontaktech. Dokud žádost nepřijmete, neuvidí, že jste si zprávu přečetli, a nemůže vám volat.';
  }

  @override
  String get requestAccept => 'Přijmout';

  @override
  String get requestDelete => 'Smazat';

  @override
  String get requestBlock => 'Blokovat';

  @override
  String get cubeIdTitle => 'Cube ID';

  @override
  String get cubeIdExplainer =>
      'Vaše @jméno odkazuje na vaši kontaktní kartu. Server uchovává jen jméno a vaši veřejnou kartu — nikdy vaše zprávy.';

  @override
  String get cubeIdFieldHint => 'a–z, 0–9 a _, 3–20 znaků';

  @override
  String get cubeIdAvailable => 'Volné';

  @override
  String get cubeIdTaken => 'Obsazené';

  @override
  String get cubeIdReserved => 'Nepovolené';

  @override
  String get cubeIdInvalid => 'Jen a–z, 0–9 a _, 3–20 znaků';

  @override
  String get cubeIdClaim => 'Zabrat jméno';

  @override
  String get cubeIdWorking => 'Zajišťování jména…';

  @override
  String get cubeIdChange => 'Změnit';

  @override
  String get cubeIdEmail => 'E-mail pro obnovení';

  @override
  String get cubeIdEmailHint =>
      'Pokud tento telefon ztratíte, jméno získáte zpět přes e-mail na tuto adresu';

  @override
  String get cubeIdEmailField => 'E-mail';

  @override
  String cubeIdEmailSent(String email) {
    return 'Na $email odešel e-mail. Otevřete odkaz v něm.';
  }

  @override
  String get cubeIdEmailRemove => 'Odebrat e-mail';

  @override
  String get cubeIdEmailUnavailable =>
      'E-mail teď není dostupný. Zkuste to později.';

  @override
  String get cubeIdEmailInvalid => 'Tohle nevypadá jako e-mailová adresa';

  @override
  String get cubeIdSave => 'Uložit';

  @override
  String get cubeIdRecover => 'Obnovit jméno přes e-mail';

  @override
  String get cubeIdRecoverSent =>
      'Pokud adresa souhlasí, přijde e-mail. Jméno se přesune do tohoto telefonu 48 hodin poté, co otevřete jeho odkaz.';

  @override
  String cubeIdRecoveryWarning(String name, String when) {
    return 'Někdo obnovuje @$name na jiném telefonu přes e-mail. Přesune se $when, pokud to nezrušíte.';
  }

  @override
  String get cubeIdRecoveryCancel => 'Zrušit obnovení';

  @override
  String get cubeIdRecoveryCancelled => 'Obnovení zrušeno';

  @override
  String get cubeIdRelease => 'Uvolnit';

  @override
  String cubeIdReleaseConfirm(String name) {
    return 'Uvolnit @$name? Kdokoli si ho pak bude moci vzít.';
  }

  @override
  String get cubeIdShare => 'Sdílet';

  @override
  String cubeIdShareText(String name) {
    return 'Najděte mě v cubechat: @$name\nhttps://cubechat.tech/u.html#$name';
  }

  @override
  String get cubeIdFailed => 'Jméno se nepodařilo uložit. Zkuste to znovu.';

  @override
  String get cubeIdOffline => 'Bez internetu';

  @override
  String get lookupNotFound => 'Nikdo s tímto @jménem';

  @override
  String searchFindCubeName(String name) {
    return 'Najít @$name';
  }

  @override
  String get searchFindCubeNameHint => 'Vyhledat v Cube ID a přidat';

  @override
  String get addContactHintName => 'Vložte kartu nebo zadejte @jméno';

  @override
  String get strangerReachTitle => 'Kdo mi smí psát z internetu';

  @override
  String get strangerReachAll => 'Všichni';

  @override
  String get strangerReachRequest => 'Žádost';

  @override
  String get strangerReachNone => 'Nikdo';

  @override
  String get strangerReachHint =>
      'Pro lidi, kterým jste nepsali a kteří se k vám dostanou přes internet. Lidí poblíž přes Bluetooth se to netýká.';

  @override
  String get sectionPrivacy => 'Soukromí a zabezpečení';

  @override
  String get sectionNotifications => 'Oznámení a hovory';

  @override
  String get sectionConnection => 'Připojení';

  @override
  String get sectionChats => 'Chaty a média';

  @override
  String get sectionAppearance => 'Vzhled';

  @override
  String get sectionData => 'Data a úložiště';

  @override
  String get sectionAbout => 'O aplikaci';

  @override
  String get subWhoSeesMe => 'Kdo mě vidí';

  @override
  String get subProtection => 'Ochrana';

  @override
  String get subNotifications => 'Oznámení';

  @override
  String get subCalls => 'Hovory';

  @override
  String get profileDiscoverableMeshOff =>
      'Bluetooth mesh je vypnutý — zapněte ho v části Připojení.';

  @override
  String get chatRouteBluetoothDirect => 'Bluetooth, přímo';

  @override
  String chatRouteMeshHops(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Mesh · $n skoků',
      few: 'Mesh · $n skoky',
      one: 'Mesh · $n skok',
    );
    return '$_temp0';
  }

  @override
  String chatRouteDeliveredVia(String route) {
    return 'Doručeno: $route';
  }

  @override
  String chatRouteReceivedVia(String route) {
    return 'Přijato: $route';
  }

  @override
  String get chatUnreadDivider => 'Nové zprávy';

  @override
  String get radioTitle => 'Vysílačka';

  @override
  String get radioNearbySubtitle =>
      'Podržte tlačítko a mluvte se skupinou nebo kontaktem';

  @override
  String get radioGroupsLabel => 'Skupiny';

  @override
  String get radioDirectLabel => 'Osobní';

  @override
  String get radioAddGroup => 'Přidat vysílačku';

  @override
  String get radioNoGroups =>
      'Zatím žádné vysílačky. Přidejte si jednu — všichni, kdo zadají stejný název a heslo, se navzájem slyší.';

  @override
  String get radioLeave => 'Opustit tuto vysílačku';

  @override
  String get radioPickChannel => 'Vyberte skupinu nebo kontakt';

  @override
  String get radioPushToTalk => 'Podržte a mluvte';

  @override
  String get radioTalking => 'Mluvíte…';

  @override
  String get radioChannelBusy => 'Kanál obsazen';

  @override
  String radioSpeaker(String name) {
    return 'Mluví: $name';
  }

  @override
  String get radioSilentTitle => 'Mluvit v tichém režimu';

  @override
  String get radioSilentHint => 'Hlas zní, i když je telefon v tichém režimu.';

  @override
  String get radioJoinNameLabel => 'Název';

  @override
  String get radioJoinPasswordLabel => 'Heslo (volitelné)';

  @override
  String get radioJoinHint =>
      'Všichni, kdo zadají stejný název a heslo, jsou na stejné vysílačce. Žádný server nevede jejich seznam.';

  @override
  String get radioJoinNameRequired => 'Zadejte název';

  @override
  String get radioJoinSubmit => 'Přidat';

  @override
  String get radioBlockedTooLong => 'Přerušeno po minutě mluvení';

  @override
  String get radioBlockedCall => 'Probíhá hovor';

  @override
  String get radioBlockedMicrophone => 'Není přístup k mikrofonu';

  @override
  String get radioBlockedUnavailable =>
      'Vysílačka není na tomto zařízení dostupná';

  @override
  String get radioBlockedNoChannel => 'Nejdřív vyberte skupinu nebo kontakt';

  @override
  String get radioTurnOff => 'Vypnout vysílačku';

  @override
  String get radioPersonalCallsTitle => 'Přijímat osobní volání';

  @override
  String get radioPersonalCallsHint =>
      'Když je vysílačka vypnutá, kontakt, který na vás promluví, si ji naladí na sebe.';

  @override
  String get radioBackgroundHint =>
      'Se zhasnutou obrazovkou je vysílačka slyšet jen se zapnutým režimem na pozadí.';

  @override
  String get areaNearby => 'Chat poblíž';

  @override
  String get areaLevelDistrict => 'Čtvrť';

  @override
  String get areaLevelCity => 'Město';

  @override
  String get areaLevelRegion => 'Kraj';

  @override
  String areaPresentCount(int count) {
    return '≈$count tady';
  }

  @override
  String get areaPresentMany => '50+ tady';

  @override
  String get areaBlockViaBluetooth => 'Váš blok — přes Bluetooth';

  @override
  String get areaOpenNearbyTab => 'Otevřít Poblíž';

  @override
  String get areaLocating => 'Hledání vaší čtvrti…';

  @override
  String get areaNoPlace =>
      'Zatím bez polohy. Místní chat potřebuje vaši přibližnou polohu, dokud je tato obrazovka otevřená.';

  @override
  String get areaLocationDenied =>
      'Poloha je pro Cubechat vypnutá. Povolte v Nastavení přibližnou polohu, abyste viděli svou čtvrť.';

  @override
  String get areaOffline => 'Není spojení s místním chatem';

  @override
  String get areaEmpty => 'Za posledních 24 hodin sem nikdo nenapsal.';

  @override
  String get areaConsentTitle => 'Místní chat je veřejný';

  @override
  String get areaConsentBody =>
      'Zprávy tady jsou veřejné. Přečte je každý, kdo otevře vaši čtvrť nebo město, a na serveru Cubechat se uchovávají 24 hodin. Píšete pod dočasným jménem, které se mění každých několik hodin; vaše @jméno ani kontakty nikdo nevidí. Aby Cubechat znal vaši čtvrť, žádá o přibližnou polohu — jen dokud je tato obrazovka otevřená.';

  @override
  String get areaConsentAllow => 'Pokračovat';

  @override
  String get areaConsentDecline => 'Teď ne';

  @override
  String areaDefaultName(String tag) {
    return 'Kostka-$tag';
  }

  @override
  String areaYouAre(String name, int hours) {
    return 'Jste $name · nové jméno za $hours h';
  }

  @override
  String get areaNewName => 'Nové jméno';

  @override
  String get areaSetName => 'Zvolit jméno';

  @override
  String get areaNameHint =>
      'Jen na těch pár hodin tohoto jména. Prázdné pole = automatické.';

  @override
  String get areaNameSameWarning =>
      'Stejné jméno vás propojuje napříč čtvrtěmi';

  @override
  String get areaShowPresence => 'Ukázat, že jsem tady';

  @override
  String get areaPresenceOffHint =>
      'Zapněte „Ukázat, že jsem tady“, abyste viděli, kolik lidí je poblíž';

  @override
  String get areaReadOnly => 'Psát můžete jen tam, kde jste';

  @override
  String get areaComposerHint => 'Zpráva pro všechny tady';

  @override
  String get areaSend => 'Odeslat';

  @override
  String get areaWaitALittle => 'Chvíli počkejte';

  @override
  String areaFlood(int count) {
    return 'Flood ($count) · Zobrazit';
  }

  @override
  String get areaReply => 'Odpovědět';

  @override
  String get areaHide => 'Skrýt';

  @override
  String get areaBlock => 'Blokovat do změny jména';

  @override
  String get areaBlocked => 'Blokováno do změny jména';

  @override
  String get areaReport => 'Nahlásit';

  @override
  String get areaOpenLink => 'Otevřít odkaz';

  @override
  String areaOpenLinkConfirm(String url) {
    return 'Otevřít $url?';
  }

  @override
  String get areaOpen => 'Otevřít';

  @override
  String get areaReadHere => 'Číst tady';

  @override
  String get areaReadHereHint =>
      'Jen čtení. Psát můžete jen tam, kde jste; relé se dozví, které místo čtete.';

  @override
  String get areaNotes => 'Vzkazy';

  @override
  String areaNotesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count vzkazů',
      few: '$count vzkazy',
      one: '$count vzkaz',
      zero: 'Žádné vzkazy',
    );
    return '$_temp0';
  }

  @override
  String get areaLeaveNote => 'Zanechat vzkaz';

  @override
  String get areaNoteHint => 'Krátký vzkaz pro vaše město';

  @override
  String get areaNoteLifetime => 'Vydrží';

  @override
  String get areaNote1h => '1 h';

  @override
  String get areaNote24h => '24 h';

  @override
  String get areaNote7d => '7 dní';

  @override
  String get areaPinToDistrict => 'Připnout ke čtvrti';

  @override
  String get areaPinHint =>
      'Klepněte na mapu uvnitř svého města; špendlík se přichytí k jeho čtvrti.';

  @override
  String get areaPinOutside => 'Jen uvnitř vašeho města';

  @override
  String get areaNoteDelete => 'Smazat můj vzkaz';

  @override
  String get areaNoNotes => 'Zatím tu nejsou žádné vzkazy';

  @override
  String get areaNotesLimit => 'Tři vzkazy denně';

  @override
  String get areaNoteLeft => 'Vzkaz zanechán';

  @override
  String get areaNoteSend => 'Zanechat';

  @override
  String get areaOwnNote => 'Váš vzkaz';

  @override
  String get areaNotePinned => 'Připnuto ke čtvrti';

  @override
  String get areaHidden => 'Skryto';

  @override
  String get areaPublicBadge => 'Veřejné · 24 h';

  @override
  String get areaSettingTitle => 'Místní chat';

  @override
  String get areaSettingOnHint =>
      'Tlačítko Chat poblíž na mapě: veřejné chaty vaší čtvrti a města, pod dočasným jménem.';

  @override
  String get areaSettingOffHint =>
      'Vypnuto: na mapě není tlačítko a místní chat nikdy nežádá o polohu ani se nepřipojuje.';

  @override
  String get wallpaperPhotoLocalOnly =>
      'Fotografické tapety jsou zatím jen místní';

  @override
  String get wallpaperSavedNoRoute =>
      'Uloženo zde. Momentálně nevede cesta k protějšku';

  @override
  String get wallpaperScopeTitle => 'Kdo má tuto tapetu vidět?';

  @override
  String get wallpaperScopeChannel => 'Celý kanál';

  @override
  String get wallpaperScopeBoth => 'Já a protějšek';

  @override
  String get wallpaperScopeLocal => 'Jen u mě';

  @override
  String get wallpaperScopeSharedHint =>
      'Odesílá se jako šifrovaný řídicí paket';

  @override
  String get wallpaperScopePhotoHint =>
      'Fotky zatím zůstávají jen v tomto telefonu';

  @override
  String get foldersCreate => 'Vytvořit složku';

  @override
  String get foldersYours => 'Vaše složky';

  @override
  String get foldersSmartFilters => 'Chytré filtry';

  @override
  String get foldersName => 'Název složky';

  @override
  String get foldersSave => 'Uložit';

  @override
  String get foldersDeleteTitle => 'Smazat složku?';

  @override
  String get foldersDelete => 'Smazat';

  @override
  String get foldersCreateAction => 'Vytvořit';

  @override
  String get chatsArchiveHiddenToast =>
      'Archiv skryt. Vrátíte ho v sekci „Vzhled“.';

  @override
  String get chatsBulkPin => 'Připnout';

  @override
  String get chatsBulkMute => 'Ztlumit';

  @override
  String get chatsUnarchive => 'Vrátit z archivu';

  @override
  String get chatsAddToFolder => 'Přidat do složky';

  @override
  String get chatsMarkUnread => 'Označit jako nepřečtené';

  @override
  String get chatsClearHistory => 'Vymazat historii chatu';

  @override
  String get foldersNew => 'Nová složka';

  @override
  String get foldersNameHint => 'Přátelé';

  @override
  String get chatsNoIncoming => 'Žádné příchozí zprávy';

  @override
  String get chatsMarkedUnread => 'Označeno jako nepřečtené';

  @override
  String get chatsClearHistoryTitle => 'Vymazat historii chatu?';

  @override
  String get chatsClearHistoryBody =>
      'Zprávy budou odstraněny jen v tomto zařízení. Chat, kontakt a oblíbené zůstanou.';

  @override
  String get chatsClearHistoryAction => 'Vymazat';

  @override
  String get chatsHistoryCleared => 'Historie vymazána';

  @override
  String get savedTagMenuTag => 'Štítek';

  @override
  String get savedTagRemove => 'Odebrat štítek';

  @override
  String get customizeArchiveRowTitle => 'Řádek archivu';

  @override
  String get customizeArchiveRowHint =>
      'Zobrazit nad seznamem chatů. Archivované chaty přijímají zprávy tak jako tak.';

  @override
  String get mapLayerStandard => 'Standardní';

  @override
  String get mapLayerStandardHint => 'Světlá mapa ulic — nejstabilnější volba';

  @override
  String get callYourMicOff => 'Váš mikrofon je vypnutý';

  @override
  String callTheirCameraOff(String name) {
    return 'Kamera uživatele $name je vypnutá';
  }
}
