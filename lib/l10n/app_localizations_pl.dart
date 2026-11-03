// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get callVoice => 'Połączenie głosowe';

  @override
  String get callVideo => 'Połączenie wideo';

  @override
  String get callIncomingVideo => 'Przychodzące połączenie wideo';

  @override
  String get callCamera => 'Kamera';

  @override
  String get callFlipCamera => 'Obróć';

  @override
  String get contactProfileVideo => 'Wideo';

  @override
  String get callPreparing => 'Przygotowywanie mikrofonu…';

  @override
  String get callDialing => 'Dzwonienie…';

  @override
  String get callRinging => 'Oczekiwanie na odpowiedź…';

  @override
  String get callConnecting => 'Łączenie…';

  @override
  String get callMicrophoneRequired =>
      'Zezwól na dostęp do mikrofonu w ustawieniach systemu, aby dzwonić.';

  @override
  String get callMicrophoneWindows =>
      'Windows nie udostępnił mikrofonu aplikacji CubeChat. Włącz Ustawienia → Prywatność i zabezpieczenia → Mikrofon → „Zezwalaj aplikacjom klasycznym na dostęp do mikrofonu”.';

  @override
  String get callElsewhere =>
      'Trwa już połączenie na innym urządzeniu tego konta.';

  @override
  String get callRelayUnavailable =>
      'Serwer połączeń jest niedostępny. Spróbuj ponownie później.';

  @override
  String get callBusy => 'Zajęte';

  @override
  String get callNoAnswer => 'Brak odpowiedzi';

  @override
  String get callFailed => 'Nie udało się nawiązać połączenia';

  @override
  String get callDeclined => 'Połączenie odrzucone';

  @override
  String get callEnded => 'Połączenie zakończone';

  @override
  String get callMicrophone => 'Mikrofon';

  @override
  String get callSpeaker => 'Głośnik';

  @override
  String get callAnswer => 'Odbierz';

  @override
  String get callDecline => 'Odrzuć';

  @override
  String get callEnd => 'Zakończ';

  @override
  String get callClose => 'Zamknij';

  @override
  String get callMinimize => 'Zwiń';

  @override
  String get callAudioOutput => 'Dźwięk połączenia';

  @override
  String get callRoutePhone => 'Telefon';

  @override
  String get callRouteBluetooth => 'Bluetooth';

  @override
  String get callRouteHeadphones => 'Słuchawki';

  @override
  String get callFullScreenTitle => 'Połączenia na ekranie blokady';

  @override
  String get callFullScreenBody =>
      'Zezwól na wyświetlanie połączenia przychodzącego na zablokowanym ekranie, aby odebrać je bez odblokowywania.';

  @override
  String get callFullScreenXiaomi =>
      'Xiaomi, Redmi i Poco nie pozwalają aplikacjom włączyć tego samodzielnie: włącz „Pokazuj na ekranie blokady” w sekcji Inne uprawnienia.';

  @override
  String get circleMessage => 'Wiadomość wideo';

  @override
  String get appName => 'Cubechat';

  @override
  String get navChats => 'Czaty';

  @override
  String get navPeers => 'W pobliżu';

  @override
  String get navProfile => 'Profil';

  @override
  String get navContacts => 'Kontakty';

  @override
  String get navMap => 'Mapa';

  @override
  String get mapTitle => 'Mapa';

  @override
  String get mapFriendsTitle => 'Osoby na mapie';

  @override
  String get mapFriendsHint => 'Tylko te kontakty otrzymują twoją pozycję';

  @override
  String mapClusterTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count osoby tutaj',
      many: '$count osób tutaj',
      few: '$count osoby tutaj',
      one: '$count osoba tutaj',
    );
    return '$_temp0';
  }

  @override
  String get mapClusterHint => 'Dotknij osoby, aby przesunąć do niej mapę';

  @override
  String get mapNorthUp => 'Północ do góry';

  @override
  String get mapLayerTitle => 'Styl mapy';

  @override
  String get mapLayerHint => 'Na czym rysowane są pinezki';

  @override
  String get mapLayerDark => 'Ciemna';

  @override
  String get mapLayerDarkHint =>
      'Ulice bez napisów — najspokojniejsze tło pod pinezkami';

  @override
  String get mapLayerSatellite => 'Satelita';

  @override
  String get mapLayerSatelliteHint =>
      'Zdjęcia lotnicze: który budynek, które podwórko';

  @override
  String get mapLayerTerrain => 'Teren';

  @override
  String get mapLayerTerrainHint =>
      'Poziomice i rzeźba terenu — wzgórza i szlaki';

  @override
  String get mapFriendsEmpty => 'Nikt jeszcze nie udostępnia ci mapy.';

  @override
  String get mapFriendsEmptyHint =>
      'Zaproś kontakt — pojawi się tutaj, gdy przyjmie zaproszenie.';

  @override
  String get mapFriendsInvite => 'Zaproś';

  @override
  String get mapFriendsRemove => 'Usuń z mapy';

  @override
  String mapFriendsRemoved(String name) {
    return '$name nie udostępnia ci już mapy';
  }

  @override
  String get mapFriendsLive => 'Teraz na mapie';

  @override
  String get mapFriendsIdle => 'Brak pozycji w tej chwili';

  @override
  String get mapInviteTitle => 'Zaproś na mapę';

  @override
  String get mapInviteHint => 'Wybierz jeden lub więcej czatów';

  @override
  String get mapInviteEmpty =>
      'Nie ma jeszcze czatów, do których można zaprosić.';

  @override
  String mapInviteAction(int count) {
    return 'Wyślij ($count)';
  }

  @override
  String get mapInviteMessage =>
      'Zaproszenie na mapę Cubechat. Udostępnij swoją lokalizację w tym czacie, aby pojawić się na mapie.';

  @override
  String mapInviteSent(int count) {
    return 'Wysłane zaproszenia: $count';
  }

  @override
  String get mapInviteFailed => 'Nie udało się wysłać zaproszeń';

  @override
  String mapPeopleVisible(int count) {
    return 'Udostępnione lokalizacje: $count';
  }

  @override
  String get mapCenterMe => 'Wyśrodkuj na mnie';

  @override
  String get mapNoSharedLocations => 'Brak udostępnionych lokalizacji';

  @override
  String get mapNoSharedLocationsHint =>
      'Kontakt pojawi się tutaj, gdy wyśle lokalizację na czacie.';

  @override
  String get mapWebHintTitle => 'Połączenia w pobliżu';

  @override
  String get mapWebHint => 'Linie pokazują bliskość, a nie trasę wiadomości.';

  @override
  String get mapOpenProfile => 'Profil';

  @override
  String get mapLocationPrivacyOff => 'Lokalizacja na mapie jest ukryta';

  @override
  String get mapLocationPrivacyOffHint =>
      'Włącz „Pokazuj mnie na mapie” w sekcji Prywatność, aby wyświetlić swoją pinezkę.';

  @override
  String get mapYouOnMap => 'Twoja pozycja jest widoczna na tym urządzeniu';

  @override
  String get locationSharingDisabled =>
      'Najpierw włącz „Pokazuj mnie na mapie” w sekcji Prywatność.';

  @override
  String get mapLocationDenied => 'Dostęp do lokalizacji jest wyłączony';

  @override
  String get mapLocationServiceOff =>
      'Włącz usługi lokalizacji, aby pokazać siebie';

  @override
  String get mapLocationUnavailable =>
      'Nie udało się ustalić twojej lokalizacji';

  @override
  String get mapDistanceUnknown => 'Odległość nieznana';

  @override
  String mapDistanceMetres(int metres) {
    return '$metres m stąd';
  }

  @override
  String mapDistanceKilometres(String kilometres) {
    return '$kilometres km stąd';
  }

  @override
  String get mapUpdatedNow => 'udostępniono przed chwilą';

  @override
  String mapUpdatedMinutes(int minutes) {
    return 'udostępniono $minutes min temu';
  }

  @override
  String mapUpdatedHours(int hours) {
    return 'udostępniono $hours godz. temu';
  }

  @override
  String get contactsTitle => 'Kontakty';

  @override
  String get contactsSubtitle => 'Wszyscy, z którymi wymieniasz wiadomości';

  @override
  String get contactsSearchHint => 'Szukaj kontaktów…';

  @override
  String get contactsEmptyTitle => 'Brak kontaktów';

  @override
  String get contactsEmptyHint =>
      'Rozpocznij rozmowę, a ta osoba pojawi się tutaj.';

  @override
  String get contactsSearchEmpty => 'Brak pasujących kontaktów';

  @override
  String get contactsTabContacts => 'Kontakty';

  @override
  String get contactsTabCalls => 'Połączenia';

  @override
  String get callsFilterAll => 'Wszystkie';

  @override
  String get callsFilterMissed => 'Nieodebrane';

  @override
  String get callsEmptyTitle => 'Brak połączeń';

  @override
  String get callsEmptyHint =>
      'Tutaj pojawią się połączenia przychodzące, wychodzące i nieodebrane.';

  @override
  String get callsMissedEmpty => 'Brak nieodebranych połączeń';

  @override
  String get callsCallBack => 'Zadzwoń';

  @override
  String get contactProfileChat => 'Czat';

  @override
  String get contactProfileCall => 'Zadzwoń';

  @override
  String get contactProfileRadio => 'Krótkofalówka';

  @override
  String get contactProfileSecurity => 'Bezpieczeństwo';

  @override
  String get contactProfileActions => 'Działania kontaktu';

  @override
  String get contactProfileVerify => 'Zweryfikuj';

  @override
  String get contactProfileCopyId => 'Kopiuj ID kontaktu';

  @override
  String get contactProfileIdCopied => 'Skopiowano ID kontaktu';

  @override
  String get contactProfileId => 'ID kontaktu';

  @override
  String get contactProfileVerifyHint =>
      'Porównaj odciski kluczy szyfrowania, aby potwierdzić tożsamość tej osoby.';

  @override
  String get chatsTitle => 'Czaty';

  @override
  String get chatsSubtitle => 'Mesh · szyfrowanie end-to-end';

  @override
  String get chatsEmptyTitle => 'Brak rozmów';

  @override
  String get chatsEmptyHint =>
      'Otwórz osobę na karcie W pobliżu, aby zacząć rozmowę.';

  @override
  String get chatsFilterAll => 'Wszystkie';

  @override
  String get chatsFilterUnread => 'Nieprzeczytane';

  @override
  String get chatsFilterMesh => 'Mesh';

  @override
  String get chatsFilterFavorites => 'Ulubione';

  @override
  String get chatsFolderDirect => 'Prywatne';

  @override
  String get chatsFolderChannels => 'Kanały';

  @override
  String get chatsFolderOnline => 'Osiągalni';

  @override
  String get chatsFoldersTitle => 'Foldery';

  @override
  String get chatsFoldersHint =>
      'Foldery to wycinki tej listy, a nie miejsca, do których przenosi się czaty. Włącz te, które mają być widoczne nad czatami.';

  @override
  String get chatsSearchHint => 'Szukaj czatów…';

  @override
  String get chatsStatusViaMesh => 'przez mesh';

  @override
  String get chatsStatusOffline => 'offline';

  @override
  String get peerKeyRotated => 'klucz zmieniony — zweryfikuj ponownie';

  @override
  String get peersTitle => 'W pobliżu';

  @override
  String get peersSubtitle => 'Urządzenia w zasięgu Bluetooth';

  @override
  String get peersEmpty => 'Szukanie rozmówców…';

  @override
  String peersHopsOne(int n) {
    return '$n przeskok stąd';
  }

  @override
  String peersHopsOther(int n) {
    return 'Przeskoki: $n';
  }

  @override
  String get blePermissionTitle => 'Wymagane uprawnienie Bluetooth';

  @override
  String get blePermissionHint =>
      'Cubechat używa Bluetooth do wyszukiwania rozmówców i wysyłania wiadomości — bez internetu.';

  @override
  String get blePermissionGrant => 'Udziel uprawnienia';

  @override
  String get blePermissionOpenSettings => 'Otwórz ustawienia';

  @override
  String get blePermissionDeniedHint =>
      'Odmówiono uprawnienia. Otwórz ustawienia, aby zezwolić na dostęp do Bluetooth.';

  @override
  String get bleAdapterOffTitle => 'Bluetooth jest wyłączony';

  @override
  String get bleAdapterOffHint =>
      'Włącz Bluetooth, aby zobaczyć urządzenia w pobliżu.';

  @override
  String get bleUnsupportedTitle => 'Bluetooth LE niedostępny';

  @override
  String get bleUnsupportedHint =>
      'To urządzenie lub platforma nie obsługuje Bluetooth Low Energy. Spróbuj na telefonie.';

  @override
  String get bleScanning => 'Skanowanie…';

  @override
  String get bleRetry => 'Ponów';

  @override
  String get bleEnable => 'Włącz';

  @override
  String get bleConnectFailed =>
      'Nie udało się połączyć. Urządzenie może być poza zasięgiem lub zmienił się jego adres Bluetooth.';

  @override
  String get bleSignal => 'Sygnał';

  @override
  String get bleConnect => 'Połącz';

  @override
  String get bleConnected => 'Połączono';

  @override
  String get bleVerified => 'Zweryfikowano';

  @override
  String get editorAdjustBrightness => 'Jasność';

  @override
  String get editorAdjustContrast => 'Kontrast';

  @override
  String get editorAdjustSaturation => 'Nasycenie';

  @override
  String get editorToolCrop => 'Przytnij';

  @override
  String get editorToolDraw => 'Rysuj';

  @override
  String get editorToolAdjust => 'Dostosuj';

  @override
  String get editorTabSticker => 'Naklejka';

  @override
  String get editorTabText => 'Tekst';

  @override
  String get editorPenPen => 'Pióro';

  @override
  String get editorPenMarker => 'Marker';

  @override
  String get editorPenNeon => 'Neon';

  @override
  String get editorPenArrow => 'Strzałka';

  @override
  String get editorPenBlur => 'Rozmycie';

  @override
  String get editorPenEraser => 'Gumka';

  @override
  String get editorLevel => 'Wyrównaj';

  @override
  String get editorTextHint => 'Tekst na zdjęciu';

  @override
  String get editorCropFree => 'Dowolnie';

  @override
  String get editorRemove => 'Usuń';

  @override
  String get notificationUnknownSender => 'Nowa wiadomość';

  @override
  String get bleUnknownPeer => 'Nieznane urządzenie';

  @override
  String get bleBroadcasting => 'Nadawanie';

  @override
  String bleConnectedCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Połączone urządzenia centralne: $n',
      many: '$n urządzeń centralnych połączonych',
      few: '$n urządzenia centralne połączone',
      one: '1 urządzenie centralne połączone',
      zero: 'Brak urządzeń centralnych',
    );
    return '$_temp0';
  }

  @override
  String get verifyTitle => 'Weryfikacja';

  @override
  String get verifyIntro =>
      'Porównaj te dwa odciski z rozmówcą osobiście lub podczas połączenia głosowego. Jeśli zgadzają się po obu stronach, masz pewność, że uzgadnianie Noise nie zostało podmienione.';

  @override
  String get verifyMine => 'TWÓJ ODCISK';

  @override
  String verifyTheirs(String name) {
    return 'ODCISK: $name';
  }

  @override
  String get verifyMarkAsVerified => 'Oznacz jako zweryfikowany';

  @override
  String get verifyAlreadyDone => 'Ten rozmówca jest zweryfikowany.';

  @override
  String get verifyRevoke => 'Cofnij';

  @override
  String verifyDoneSnack(String name) {
    return '$name: oznaczono jako zweryfikowany';
  }

  @override
  String get chatInputHint => 'Wiadomość';

  @override
  String get chatSend => 'Wyślij';

  @override
  String get chatToday => 'Dzisiaj';

  @override
  String get chatYesterday => 'Wczoraj';

  @override
  String get chatDelivered => 'Dostarczono';

  @override
  String get chatRead => 'Przeczytano';

  @override
  String get chatSending => 'Wysyłanie';

  @override
  String get chatWaitingForConnection => 'Czeka na połączenie';

  @override
  String sendQueueCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count wiadomości czeka na połączenie',
      many: '$count wiadomości czeka na połączenie',
      few: '$count wiadomości czekają na połączenie',
      one: '1 wiadomość czeka na połączenie',
    );
    return '$_temp0';
  }

  @override
  String sendQueueSlowNetwork(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Wolna sieć — wysyłanie $count wiadomości',
      many: 'Wolna sieć — wysyłanie $count wiadomości',
      few: 'Wolna sieć — wysyłanie $count wiadomości',
      one: 'Wolna sieć — wysyłanie 1 wiadomości',
    );
    return '$_temp0';
  }

  @override
  String get sendQueueTitle => 'Czekają na wysłanie';

  @override
  String get sendQueueHint =>
      'Wyjdą same, gdy tylko pojawi się droga — Bluetooth w pobliżu albo internet. Nie trzeba niczego naciskać.';

  @override
  String get sendQueueRetry => 'Spróbuj teraz';

  @override
  String get sendQueueCancel => 'Anuluj wysyłanie';

  @override
  String get sendQueueCancelled => 'Nie wysłano — wycofano';

  @override
  String get sendQueueTooLate => 'Za późno na wycofanie: wiadomość już wyszła';

  @override
  String get chatEncryptedNotice =>
      'Wiadomości są szyfrowane end-to-end protokołem Noise.';

  @override
  String get chatSessionHandshaking => 'Nawiązywanie bezpiecznego kanału…';

  @override
  String get chatSessionEstablished => 'Zabezpieczono · Noise XX';

  @override
  String get chatSessionFailed => 'Połączenie nieudane';

  @override
  String get presenceOnline => 'online';

  @override
  String get presenceOffline => 'offline';

  @override
  String get chatSessionFingerprintPending =>
      'Odcisk pojawi się po zakończeniu uzgadniania.';

  @override
  String get chatEmptyEstablished =>
      'Bezpieczny kanał jest gotowy. Wyślij wiadomość, aby rozpocząć rozmowę.';

  @override
  String get chatEmptyHandshaking =>
      'Czekanie, aż druga strona zakończy uzgadnianie…';

  @override
  String get chatEmptyTitle => 'Nie ma tu jeszcze wiadomości';

  @override
  String get chatEmptyGreetHint =>
      'Napisz wiadomość albo dotknij Kubiego, aby się przywitać.';

  @override
  String get profileTitle => 'Profil';

  @override
  String get profileNickname => 'Pseudonim';

  @override
  String get profileNicknameEditTitle => 'Ustaw pseudonim';

  @override
  String get profileNicknameHint => 'Jak widzą cię inni w sieci mesh';

  @override
  String get profileNicknameSave => 'Zapisz';

  @override
  String get profileFingerprint => 'Odcisk klucza publicznego';

  @override
  String get profileLanguage => 'Język';

  @override
  String get profileLanguageEn => 'Angielski';

  @override
  String get profileLanguageUk => 'Ukraiński';

  @override
  String get profileTransport => 'Transport';

  @override
  String get profileTransportMesh => 'Bluetooth mesh';

  @override
  String get profileBackground => 'Działaj w tle';

  @override
  String get profileBackgroundSubtitle =>
      'Odbieraj wiadomości, gdy aplikacja jest zamknięta';

  @override
  String get profileBatteryExempt => 'Wyłącz optymalizację baterii';

  @override
  String get profileAbout => 'O aplikacji';

  @override
  String profileVersion(String v) {
    return 'Wersja $v';
  }

  @override
  String get rotateKeysTitle => 'Zmień klucze konta';

  @override
  String get rotateKeysHint =>
      'Jeśli urządzenie z twoim kontem zostało zgubione lub skradzione';

  @override
  String get rotateKeysConfirmTitle => 'Zmienić klucze konta?';

  @override
  String get rotateKeysConfirmBody =>
      'Twoje kontakty otrzymają nowe klucze i zachowają czaty, ale każdy z nich zostanie poproszony o ponowne sprawdzenie twoich kluczy. Wszystkie inne urządzenia twojego konta zostaną wylogowane; te, które chcesz zachować, połącz ponownie z tego telefonu. Kontakty ze starszą wersją CubeChat nie skontaktują się z tobą, dopóki jej nie zaktualizują. Kanały zachowują swoje klucze.';

  @override
  String get rotateKeysConfirmAction => 'Zmień klucze';

  @override
  String get rotateKeysWorking => 'Zmienianie kluczy…';

  @override
  String rotateKeysDone(int sent, int total) {
    return 'Nowe klucze. Powiadomiono $sent z $total kontaktów';
  }

  @override
  String get rotateKeysSlow =>
      'Nowe klucze. Nie wszystkie kontakty potwierdziły na czas; przekaźniki przechowają to dla nich';

  @override
  String get profileEmergencyWipe => 'Awaryjne wymazanie';

  @override
  String get profileEmergencyWipeConfirm => 'Wymazać wszystko?';

  @override
  String get profileEmergencyWipeConfirmHint =>
      'Usunie to twoją tożsamość, listę kontaktów i historię rozmów. Tej operacji nie można cofnąć.';

  @override
  String get profileEmergencyWipeAction => 'Wymaż';

  @override
  String get cancel => 'Anuluj';

  @override
  String get copy => 'Kopiuj';

  @override
  String get copied => 'Skopiowano';

  @override
  String get channelsNewTitle => 'Nowy kanał';

  @override
  String get channelsNewTooltip => 'Nowy kanał';

  @override
  String get channelNameLabel => 'Nazwa kanału';

  @override
  String get channelPasswordLabel => 'Hasło (opcjonalnie)';

  @override
  String get channelJoinAction => 'Dołącz';

  @override
  String get channelNameHint =>
      'Każdy, kto wpisze tę samą nazwę i hasło, trafi do tego samego pokoju. Nie ma serwera, który przechowywałby ich listę.';

  @override
  String get channelPasswordHint =>
      'Hasło jest kluczem. Bez niego pokój jest otwarty dla każdego w pobliżu, kto zna jego nazwę.';

  @override
  String get channelSubtitle => 'Kanał grupowy · wspólny klucz';

  @override
  String get channelMute => 'Wycisz';

  @override
  String get channelUnmute => 'Wyłącz wyciszenie';

  @override
  String channelMutedUntil(String time) {
    return 'Wyciszono do $time';
  }

  @override
  String get channelMuteFor => 'Wycisz na…';

  @override
  String channelMuteMinutes(int minutes) {
    return '$minutes min';
  }

  @override
  String channelMuteHours(int hours) {
    return '$hours godz.';
  }

  @override
  String channelMuteDays(int days) {
    return '$days dni';
  }

  @override
  String get channelMuteForever => 'Dopóki nie włączę ponownie';

  @override
  String get channelCommunity => 'Komentarze';

  @override
  String get channelCommunityOpen => 'Otwórz dyskusję';

  @override
  String channelCommunitySubtitle(String channel) {
    return 'Dyskusja: $channel';
  }

  @override
  String get channelBackToChannel => 'Wróć do kanału';

  @override
  String get channelMemberActions => 'Uczestnik';

  @override
  String get channelRemoveMember => 'Usuń z kanału';

  @override
  String get channelRemoveMemberHint =>
      'Jego posty przestaną być tu przyjmowane. Nic nie stoi na przeszkodzie, by dołączył ponownie po nazwie — wspólny klucz to jedyne członkostwo, jakie istnieje.';

  @override
  String get channelMuteMember => 'Wycisz na…';

  @override
  String get channelUnmuteMember => 'Pozwól znów pisać';

  @override
  String channelMemberRemoved(String name) {
    return 'Usunięto: $name';
  }

  @override
  String channelMemberMuted(String name) {
    return 'Wyciszono: $name';
  }

  @override
  String channelMemberCleared(String name) {
    return '$name może znów pisać';
  }

  @override
  String get channelMemberMutedNote => 'Wyciszono';

  @override
  String get channelShareHistory => 'Udostępnij historię';

  @override
  String get channelShareHistoryHint =>
      'Ponownie nadaje ostatnie posty tego pokoju, aby zobaczył je każdy, kto dołączył później. Osoby, które już tu były, nie otrzymają nic nowego.';

  @override
  String channelHistoryShared(int count) {
    return 'Zaoferowane posty: $count';
  }

  @override
  String get channelHistoryNothing => 'Na razie nie ma czego udostępnić';

  @override
  String get channelHistoryAuto => 'Przekazuj historię nowym';

  @override
  String get channelHistoryAutoHint =>
      'Gdy w pokoju pojawi się ktoś nowy, ostatnie posty trafią do niego same. Na razie tylko tekst — zdjęcia są przesyłane w częściach i nie da się ich powtórzyć bez duplikowania dla wszystkich.';

  @override
  String get channelPostComments => 'Komentarze';

  @override
  String get channelNoComments => 'Nikt jeszcze tego nie skomentował';

  @override
  String get channelCommentHint => 'Komentarz';

  @override
  String get channelMuteCustom => 'Na jak długo?';

  @override
  String get channelMuteCustomHint => 'Godziny';

  @override
  String get chatPinnedManage => 'Przypięte';

  @override
  String get chatPeekOpen => 'Otwórz czat';

  @override
  String get chatPeekPin => 'Przypnij';

  @override
  String get chatPeekUnpin => 'Odepnij';

  @override
  String get chatPeekUnmute => 'Włącz dźwięk';

  @override
  String get chatPeekMarkRead => 'Oznacz jako przeczytane';

  @override
  String get chatDeleteForMeHint =>
      'Usunięte z tego telefonu i odpięte. Druga strona zachowuje swoją kopię.';

  @override
  String get pushWakeTitle => 'Budź ten telefon';

  @override
  String get pushWakeHint =>
      'Niewielki serwer obserwuje przekaźniki pod kątem twojego adresu i puka do tego telefonu, gdy coś przyjdzie, więc nawet zamknięta aplikacja da ci znać. Nigdy nie widzi wiadomości ani klucza — tylko to, że na twój adres coś przyszło, i kiedy. Przekaźnik już to wie; to drugie miejsce, które to wie.';

  @override
  String get pushWakeDeniedTitle => 'Powiadomienia są wyłączone';

  @override
  String get pushWakeDeniedHint =>
      'System raz usłyszał „nie” i nie zapyta ponownie, więc można to włączyć tylko w Ustawieniach — cubechat, potem Powiadomienia. Potem wróć tutaj.';

  @override
  String get pushWakeRefused => 'Nie zezwolono na powiadomienia';

  @override
  String get privacyForwardLinkTitle => 'Link do profilu w przekazanych';

  @override
  String get privacyForwardLinkHint =>
      'Gdy ktoś przekaże dalej twoją wiadomość, linia nad nią może otwierać twój profil. Po wyłączeniu widać tylko imię, bez możliwości kliknięcia. To prośba do ich aplikacji, a nie coś, co ta aplikacja może wymusić.';

  @override
  String get privacyShareSheetTitle => 'Czaty w menu udostępniania';

  @override
  String get privacyShareSheetOnHint =>
      'Nazwy twoich czterech ostatnich czatów są przekazywane do Androida, aby można było wysyłać do nich z dowolnej aplikacji. Blokada aplikacji ich nie ukrywa.';

  @override
  String get privacyShareSheetOffHint =>
      'Android nic nie otrzymuje. Przy udostępnianiu do CubeChat wybierasz czat z listy.';

  @override
  String get privacyCallsTitle => 'Przyjmuj połączenia';

  @override
  String get privacyCallsOnHint =>
      'Twoje kontakty mogą do ciebie dzwonić. Aby zablokować jedną osobę, otwórz jej profil.';

  @override
  String get privacyCallsOffHint =>
      'Nikt nie może do ciebie dzwonić poza osobami, którym zezwolisz w ich profilu. Odrzucone połączenie zobaczą jako „zajęte”.';

  @override
  String get chatsStatusChannel => 'kanał';

  @override
  String get channelInviteTitle => 'Dodaj osoby';

  @override
  String get channelInviteAction => 'Zaproś';

  @override
  String get channelInviteEmpty =>
      'Brak znanych rozmówców. Najpierw znajdź kogoś na karcie W pobliżu.';

  @override
  String get channelInviteSent => 'Wysłano zaproszenia';

  @override
  String get channelInviteNoneSent => 'Nie udało się teraz z nikim połączyć';

  @override
  String get channelNameTooLong => 'Nazwa kanału jest za długa';

  @override
  String get chatsActionFavorite => 'Dodaj do ulubionych';

  @override
  String get chatsActionUnfavorite => 'Usuń z ulubionych';

  @override
  String get chatsActionDelete => 'Usuń czat';

  @override
  String get chatsDeleteTitle => 'Usunąć ten czat?';

  @override
  String chatsDeleteManyHint(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Wyczyści $count rozmowy. Kontakty zostaną, więc możesz znowu do nich napisać bez wymiany kodów.',
      many:
          'Wyczyści $count rozmów. Kontakty zostaną, więc możesz znowu do nich napisać bez wymiany kodów.',
      few:
          'Wyczyści $count rozmowy. Kontakty zostaną, więc możesz znowu do nich napisać bez wymiany kodów.',
      one:
          'Wyczyści $count rozmowę. Kontakty zostaną, więc możesz znowu do nich napisać bez wymiany kodów.',
    );
    return '$_temp0';
  }

  @override
  String get chatsDeletedToast => 'Czat usunięty.';

  @override
  String chatsDeletedManyToast(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Usunięto $count czatu.',
      many: 'Usunięto $count czatów.',
      few: 'Usunięto $count czaty.',
      one: 'Usunięto $count czat.',
    );
    return '$_temp0';
  }

  @override
  String get undo => 'Cofnij';

  @override
  String get chatsDeletePeerHint =>
      'Czyści rozmowę. Kontakt zostaje, więc możesz znowu do niego napisać bez wymiany kodów.';

  @override
  String get chatsDeleteChannelHint =>
      'Opuszcza kanał i usuwa jego historię. Aby wrócić, znów będzie potrzebny klucz.';

  @override
  String get chatsDeleteForThemToo => 'Usuń też u rozmówcy';

  @override
  String get chatsDeleteForThemHint =>
      'Poprosi jego aplikację o wyczyszczenie całej rozmowy, łącznie z tym, co sam napisał. W kanale wycofywane są tylko twoje wiadomości.';

  @override
  String get chatEditAction => 'Edytuj';

  @override
  String get chatEditTitle => 'Edytuj wiadomość';

  @override
  String get chatEditSave => 'Zapisz';

  @override
  String get chatEdited => 'edytowano';

  @override
  String get chatDeleteAction => 'Usuń';

  @override
  String get chatDeleteTitle => 'Usunąć wiadomość?';

  @override
  String get chatDeleteForMe => 'Usuń u mnie';

  @override
  String get chatDeleteForEveryone => 'Usuń u wszystkich';

  @override
  String get chatPinTitle => 'Przypiąć wiadomość?';

  @override
  String get chatPinForBoth => 'Przypnij u obu stron';

  @override
  String get chatPinForMe => 'Przypnij tylko u mnie';

  @override
  String get chatReplyAction => 'Odpowiedz';

  @override
  String chatReplyingTo(String name) {
    return 'Odpowiedź: $name';
  }

  @override
  String get chatReplyYou => 'sobie';

  @override
  String get chatCopyAction => 'Kopiuj';

  @override
  String get chatCopied => 'Skopiowano';

  @override
  String get chatForwardAction => 'Przekaż';

  @override
  String get chatForwardTitle => 'Przekaż do';

  @override
  String get shareIntoTitle => 'Wyślij do';

  @override
  String get shareNearbyAirDrop => 'W pobliżu przez AirDrop';

  @override
  String get shareNearbyAirDropHint => 'Bez internetu — do osób obok ciebie';

  @override
  String get shareSent => 'Wysłano';

  @override
  String get shareFailed => 'Części nie udało się wysłać';

  @override
  String get chatForwardEmpty => 'Brak innych czatów';

  @override
  String chatForwardSendCount(int count) {
    return 'Wyślij ($count)';
  }

  @override
  String chatForwardSentCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Przekazano do $count czatu',
      many: 'Przekazano do $count czatów',
      few: 'Przekazano do $count czatów',
      one: 'Przekazano do jednego czatu',
    );
    return '$_temp0';
  }

  @override
  String chatForwardSent(String name) {
    return 'Przekazano: $name';
  }

  @override
  String chatSentAt(String time) {
    return 'Wysłano $time';
  }

  @override
  String chatReadAt(String time) {
    return 'Przeczytano $time';
  }

  @override
  String get chatPinAction => 'Przypnij';

  @override
  String get chatUnpinAction => 'Odepnij';

  @override
  String chatPinnedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count przypiętej wiadomości',
      many: '$count przypiętych wiadomości',
      few: '$count przypięte wiadomości',
      one: '1 przypięta wiadomość',
      zero: 'Brak przypiętych wiadomości',
    );
    return '$_temp0';
  }

  @override
  String get chatNoPins => 'Nic tu nie jest przypięte';

  @override
  String get chatUnpinAll => 'Odepnij wszystkie wiadomości';

  @override
  String get chatShowAllPins => 'Wszystkie przypięte wiadomości';

  @override
  String get chatUnpinConfirm => 'Odpiąć tę wiadomość?';

  @override
  String get chatUnpinConfirmHint =>
      'Przestanie być przypięta dla wszystkich w tym czacie.';

  @override
  String get chatPinnedTitle => 'Przypięta wiadomość';

  @override
  String get chatPinnedGone => 'Tej wiadomości nie ma już w tym czacie';

  @override
  String get peerBlock => 'Zablokuj';

  @override
  String get peerUnblock => 'Odblokuj';

  @override
  String get peerMute => 'Wycisz';

  @override
  String get peerUnmute => 'Włącz dźwięk';

  @override
  String get peerBlockedNote => 'Zablokowano — wiadomości są odrzucane.';

  @override
  String get relaysTitle => 'Zapasowo przez internet';

  @override
  String get relaysCardTitle => 'Docieraj do rozmówców przez internet';

  @override
  String get relaysCardSubtitle =>
      'Gdy Bluetooth nie dostarczy, wysyłaj przez przekaźniki Nostr';

  @override
  String get relaysExplainer =>
      'Wiadomości pozostają szyfrowane end-to-end — przekaźnik przenosi tylko tę samą zapieczętowaną ramkę, co Bluetooth. Wie jednak, które dwa klucze rozmawiają i kiedy. Domyślnie wyłączone.';

  @override
  String get relaysMyAddress => 'Twój adres na przekaźnikach';

  @override
  String get relaysCopied => 'Skopiowano';

  @override
  String get circleLensTitle => 'Przednia kamera do kółek';

  @override
  String get circleLensFrontHint =>
      'Okrągłe wiadomości wideo nagrywane są kamerą skierowaną na ciebie.';

  @override
  String get circleLensBackHint =>
      'Okrągłe wiadomości wideo nagrywane są tylną kamerą — aby pokazać to, na co patrzysz.';

  @override
  String get channelCloseTitle => 'Zamknij pokój dla wszystkich';

  @override
  String get channelCloseSubtitle =>
      'Usuwa go z telefonu każdego uczestnika. Tylko ty możesz to zrobić.';

  @override
  String get channelCloseConfirm =>
      'Pokój, jego wiadomości i uczestnicy znikną z każdego telefonu, na którym jest. Nikt nie zostaje zablokowany: klucz wynika z nazwy, więc każdy, kto ją pamięta, może znów otworzyć pusty pokój.';

  @override
  String get channelCloseAction => 'Zamknij pokój';

  @override
  String get circleHint => 'Puść, aby wysłać · przesuń w lewo, aby anulować';

  @override
  String get circleHintLocked => 'Gdy skończysz, dotknij Wyślij';

  @override
  String get circleNeedsCamera => 'Kółka wymagają kamery i mikrofonu';

  @override
  String get circleFailed => 'Nie udało się nagrać kółka';

  @override
  String get relaysListLabel => 'Przekaźniki';

  @override
  String get relaysLaneMedia => 'Przekaźniki multimediów';

  @override
  String get relaysLaneMediaNote =>
      'Zdjęcia, pliki i wideo idą przez nie, aby przesyłanie nie spowalniało rozmowy.';

  @override
  String get relaysLaneLocation => 'Przekaźniki lokalizacji';

  @override
  String get relaysLaneLocationNote =>
      'Sygnały lokalizacji na mapie idą przez nie, osobno od całej reszty.';

  @override
  String get relaysAdd => 'Dodaj przekaźnik';

  @override
  String get relaysAddHint => 'wss://relay.example.com';

  @override
  String get relaysInvalidUrl => 'Wpisz adres wss:// lub ws://';

  @override
  String get relaysRemove => 'Usuń';

  @override
  String get relaysStateConnected => 'Połączono';

  @override
  String get relaysStateConnecting => 'Łączenie…';

  @override
  String get relaysStateFailed => 'Nieosiągalny';

  @override
  String get relaysStateIdle => 'Wyłączony';

  @override
  String get relaysEmpty =>
      'Brak skonfigurowanych przekaźników — kanał zapasowy pozostaje wyłączony.';

  @override
  String get contactTitle => 'Wizytówka';

  @override
  String get contactMineLabel => 'Twoja wizytówka';

  @override
  String get contactMineExplainer =>
      'Wyślij ją komuś, kto jest poza zasięgiem Bluetooth. Zawiera twoje klucze i adres na przekaźnikach — to wystarczy, by rozpocząć z tobą szyfrowany czat przez internet.';

  @override
  String get contactCopy => 'Kopiuj';

  @override
  String get contactShare => 'Udostępnij';

  @override
  String get contactCopied => 'Skopiowano wizytówkę';

  @override
  String get contactShareSubject => 'Moja wizytówka cubechat';

  @override
  String get contactAddLabel => 'Dodaj kogoś';

  @override
  String get contactAddHint => 'Wklej wizytówkę';

  @override
  String get contactAddAction => 'Dodaj';

  @override
  String get contactPaste => 'Wklej';

  @override
  String contactAdded(String name) {
    return 'Dodano: $name';
  }

  @override
  String get contactInvalid => 'To nie jest prawidłowa wizytówka';

  @override
  String get contactOwnCard => 'To twoja własna wizytówka';

  @override
  String get contactUnverified =>
      'Kontakt dodany w ten sposób jest początkowo niezweryfikowany. Każdy może wygenerować wizytówkę i wpisać na niej dowolne imię, więc zanim zaufasz tożsamości, porównaj odciski osobiście lub podczas rozmowy.';

  @override
  String get contactRelayOff =>
      'Zapasowy kanał przez internet jest wyłączony, więc wizytówka jeszcze do nikogo nie dotrze.';

  @override
  String get contactRelayEnable => 'Włącz';

  @override
  String get profileContactCard => 'Wizytówka';

  @override
  String get chatsAddContactTooltip => 'Dodaj kontakt z wizytówki';

  @override
  String get chatsMenuTooltip => 'Więcej';

  @override
  String get chatsMenuAddContact => 'Dodaj kontakt';

  @override
  String get chatsMenuNewChannel => 'Nowy kanał';

  @override
  String get profileDiscoverable => 'Widoczność w pobliżu';

  @override
  String get profileDiscoverableOnHint => 'Każdy w zasięgu może cię znaleźć';

  @override
  String get profileDiscoverableOffHint =>
      'Tylko twoje kontakty mogą się z tobą skontaktować';

  @override
  String get profileDiscoverableExplainer =>
      'Gdy włączone, twoje ogłoszenie jest nadawane jawnie, więc nieznajomi mogą cię poznać, po prostu podchodząc — a każdy, kto nasłuchuje, zapisze twój klucz i imię. Gdy wyłączone, ten sam pakiet trafia tylko do istniejących kontaktów, zapieczętowany, a twoje identyfikatory routingu pozostają niepowiązane. Nowe osoby potrzebują wtedy wizytówki.';

  @override
  String get voiceHoldHint => 'Przytrzymaj, aby nagrać wiadomość głosową';

  @override
  String get voiceTrimPlay => 'Odtwórz';

  @override
  String get voiceTrimPause => 'Pauza';

  @override
  String get voiceTrimDiscard => 'Odrzuć nagranie';

  @override
  String voiceTrimSelection(String duration) {
    return 'Wysyłanie $duration';
  }

  @override
  String get profileLastSeen => 'Pokazuj ostatnią aktywność';

  @override
  String get profileLastSeenOnHint =>
      'Kontakty widzą, kiedy jesteś w aplikacji';

  @override
  String get profileLastSeenOffHint =>
      'Nikt nie widzi twojego czasu, a ty niczyjego: tylko kto jest online';

  @override
  String get profileMapLocation => 'Pokazuj mnie na mapie';

  @override
  String get profileMapLocationOnHint =>
      'Lokalizacja jest dostępna do ręcznego udostępniania, a twoja pinezka jest widoczna na mapie';

  @override
  String get profileMapLocationOffHint =>
      'Aplikacja nie prosi o lokalizację, a twoja pinezka pozostaje ukryta';

  @override
  String get desktopAutostartTitle => 'Uruchamiaj z systemem Windows';

  @override
  String get desktopAutostartHint =>
      'CubeChat czeka w zasobniku, więc połączenia i wiadomości docierają do tego komputera przy zamkniętym oknie';

  @override
  String get trayOpen => 'Otwórz CubeChat';

  @override
  String get trayQuit => 'Zakończ';

  @override
  String get callDirectTitle => 'Połączenia bezpośrednie';

  @override
  String get callDirectOnHint => 'Szybciej, ale rozmówca pozna twój adres IP';

  @override
  String get callDirectOffHint =>
      'Połączenia idą przez nasz przekaźnik: rozmówca nie widzi twojego adresu IP, a przekaźnik nie słyszy rozmowy';

  @override
  String get profileReadReceipts => 'Potwierdzenia odczytu';

  @override
  String get profileReadReceiptsOnHint =>
      'Nadawcy widzą, kiedy ich wiadomość została przeczytana';

  @override
  String get profileReadReceiptsOffHint =>
      'Nie wysyłasz czasu odczytu, ale nadal widzisz go u innych';

  @override
  String get profilePrivacyExplainer =>
      'Ostatnia aktywność działa w obie strony: gdy ukryjesz swój status, przestajesz widzieć status innych. Potwierdzenia odczytu dotyczą tylko tego, co wysyłasz. Nie ma to wpływu na dostarczanie wiadomości.';

  @override
  String get chatTimerAction => 'Licznik';

  @override
  String get chatTimerRemove => 'Usuń licznik';

  @override
  String get chatTimerTitle => 'Usuń tę wiadomość za';

  @override
  String chatTimerSet(String time) {
    return 'Ta wiadomość zniknie za $time';
  }

  @override
  String get chatTimerLocalHint =>
      'Tylko na tym urządzeniu — ich kopia należy do nich';

  @override
  String get contactTagAction => 'Etykieta';

  @override
  String get contactTagRemove => 'Usuń etykietę';

  @override
  String get contactTagTitle => 'Wybierz etykietę';

  @override
  String get contactTagAll => 'Wszystkie';

  @override
  String get quietHoursTitle => 'Godziny ciszy';

  @override
  String get quietHoursHint => 'Wiadomości nadal przychodzą; telefon milczy';

  @override
  String get quietHoursFrom => 'Od';

  @override
  String get quietHoursTo => 'Do';

  @override
  String get notifPreviewTitle => 'Pokazuj w powiadomieniach';

  @override
  String get notifPreviewFull => 'Imię i tekst';

  @override
  String get notifPreviewNameOnly => 'Tylko imię';

  @override
  String get notifPreviewHidden => 'Nic';

  @override
  String get notifPreviewHint =>
      'Powiadomienia są widoczne na ekranie blokady i dla aplikacji z dostępem do powiadomień, nawet przy włączonej blokadzie aplikacji';

  @override
  String get notifPreviewNewMessage => 'Nowa wiadomość';

  @override
  String get appLockTitle => 'Blokada aplikacji';

  @override
  String get appLockHint => 'Pytaj o kod przy otwieraniu aplikacji';

  @override
  String get appLockPrompt => 'Wpisz kod';

  @override
  String get appLockUnlock => 'Odblokuj';

  @override
  String get appLockWrong => 'Nieprawidłowy kod';

  @override
  String get appLockSetTitle => 'Ustaw kod';

  @override
  String get appLockSetHint =>
      'Co najmniej cztery cyfry. Nie da się go odzyskać.';

  @override
  String get appLockOffTitle => 'Wyłącz blokadę';

  @override
  String get appLockOffHint => 'Wpisz obecny kod';

  @override
  String get appLockOn => 'Blokada aplikacji włączona';

  @override
  String get appLockOff => 'Blokada aplikacji wyłączona';

  @override
  String get avatarSet => 'Wybierz zdjęcie';

  @override
  String get avatarChange => 'Zmień zdjęcie';

  @override
  String get avatarView => 'Pokaż zdjęcie';

  @override
  String get profileCoverPhoto =>
      'Zdjęcie profilowe, dotknij dwukrotnie, aby powiększyć';

  @override
  String get profileCoverMenu => 'Opcje zdjęcia';

  @override
  String get avatarSaved => 'Zapisano w galerii';

  @override
  String get avatarRemove => 'Usuń zdjęcie';

  @override
  String get avatarRemoveConfirm =>
      'Awatar zostanie usunięty z tego urządzenia. W jego miejsce wróci wygenerowany gradient.';

  @override
  String get avatarFailed => 'Nie udało się odczytać obrazu';

  @override
  String get fileOpenHint => 'Dotknij, aby otworzyć';

  @override
  String get fileMissing => 'Ten plik nie jest już dostępny';

  @override
  String get fileNoHandlerTitle => 'Brak aplikacji do otwarcia';

  @override
  String get fileNoHandlerHint =>
      'Żadna zainstalowana aplikacja nie obsługuje tego typu pliku. Możesz zamiast tego wysłać go do innej aplikacji.';

  @override
  String get fileRequestedAgain => 'Poproszono nadawcę o ponowne wysłanie';

  @override
  String get fileOpenFailed => 'Nie udało się otworzyć pliku';

  @override
  String get fileShareAction => 'Wyślij do aplikacji';

  @override
  String fileTooLargeMesh(int limit) {
    return 'Plik jest za duży — limit przez mesh to $limit MB';
  }

  @override
  String fileTooLargeRelay(int limit) {
    return 'Przez internet limit wynosi $limit MB. Podejdź bliżej odbiorcy, aby wysłać większy plik.';
  }

  @override
  String get mediaSendOriginal => 'Oryginał';

  @override
  String get attachFile => 'Plik';

  @override
  String get attachGallery => 'Galeria';

  @override
  String get attachCamera => 'Aparat';

  @override
  String get cameraUnavailable => 'Aparat niedostępny';

  @override
  String get profileEditName => 'Imię';

  @override
  String get profileMyCard => 'Wizytówka';

  @override
  String get mediaCaptionHint => 'Dodaj podpis…';

  @override
  String get mediaDiscardTitle => 'Odrzucić wybór?';

  @override
  String get mediaDiscardMessage =>
      'Zamknąć galerię i odrzucić wybrane zdjęcia?';

  @override
  String get mediaDiscardConfirm => 'Odrzuć';

  @override
  String get mediaPhotosAccessOff => 'Dostęp do zdjęć wyłączony';

  @override
  String get mediaPhotosAccessOffHint =>
      'CubeChat widzi obecnie tylko filmy. Zezwól na dostęp do zdjęć w ustawieniach systemu, aby wyświetlić swoje zdjęcia.';

  @override
  String get mediaVideosOnly =>
      'Widoczne są tylko filmy — zezwól na dostęp do zdjęć';

  @override
  String get mediaOpenSettings => 'Otwórz ustawienia';

  @override
  String get mediaTakePhoto => 'Zrób zdjęcie';

  @override
  String get contactProfileAutoDelete => 'Autousuwanie czatu';

  @override
  String get contactProfileAutoDeleteTitle => 'Autousuwanie wiadomości';

  @override
  String get contactProfileAutoDeleteOff => 'Wyłączone';

  @override
  String get contactProfileAutoDeleteOneDay => 'Po 1 dniu';

  @override
  String get contactProfileAutoDeleteSevenDays => 'Po 7 dniach';

  @override
  String get contactProfileAutoDeleteThirtyDays => 'Po 30 dniach';

  @override
  String contactProfileAutoDeleteUpdated(String period) {
    return 'Autousuwanie: $period';
  }

  @override
  String get contactProfileShare => 'Udostępnij kontakt';

  @override
  String get contactProfileShareTitle => 'Wyślij kontakt do';

  @override
  String get contactProfileShareEmpty => 'Brak innych czatów';

  @override
  String contactProfileShareSent(String name) {
    return 'Wysłano do: $name';
  }

  @override
  String get contactProfileRestrictCopying => 'Zablokuj kopiowanie';

  @override
  String get contactProfileAllowCopying => 'Zezwól na kopiowanie';

  @override
  String get contactHideAvatar => 'Ukryj moje zdjęcie';

  @override
  String get contactShowAvatar => 'Pokazuj moje zdjęcie';

  @override
  String get contactHideLastSeen => 'Ukryj moją ostatnią aktywność';

  @override
  String get contactShowLastSeen => 'Pokazuj moją ostatnią aktywność';

  @override
  String get contactHideReadReceipts => 'Ukryj moje potwierdzenia odczytu';

  @override
  String get contactShowReadReceipts => 'Pokazuj moje potwierdzenia odczytu';

  @override
  String get contactHiddenFromThem => 'Ukryte przed tym kontaktem';

  @override
  String get contactRefuseCalls => 'Nie przyjmuj połączeń od tej osoby';

  @override
  String get contactAllowCalls => 'Przyjmuj połączenia od tej osoby';

  @override
  String get contactCallsException => 'Wyjątek od twoich ustawień połączeń';

  @override
  String get contactProfileCopyingRestricted =>
      'Kopiowanie i przekazywanie są zablokowane';

  @override
  String get contactProfileCopyingRestrictedByPeer =>
      'Zablokowane przez rozmówcę';

  @override
  String get contactProfileCopyingAllowed =>
      'Kopiowanie i przekazywanie są dozwolone';

  @override
  String get contactProfileDelete => 'Usuń z kontaktów';

  @override
  String get contactProfileRestore => 'Przywróć do kontaktów';

  @override
  String get contactProfileRestoreDone => 'Ponownie w twoich kontaktach';

  @override
  String get contactProfileDeleteTitle => 'Usunąć kontakt?';

  @override
  String contactProfileDeleteMessage(String name) {
    return '$name zniknie z Kontaktów. Historia czatu pozostanie na tym urządzeniu.';
  }

  @override
  String get contactProfileMedia => 'Multimedia';

  @override
  String get contactProfileVoiceMessages => 'Wiadomości głosowe';

  @override
  String get contactProfileStickers => 'Naklejki';

  @override
  String get contactProfileNoStickers => 'Brak naklejek';

  @override
  String get contactProfileNoMedia => 'Brak multimediów';

  @override
  String get contactProfileNoVoiceMessages => 'Brak wiadomości głosowych';

  @override
  String get contactProfileOpen => 'Otwórz profil';

  @override
  String autoDeleteDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dnia',
      many: '$count dni',
      few: '$count dni',
      one: '$count dzień',
    );
    return '$_temp0';
  }

  @override
  String autoDeleteHours(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count godziny',
      many: '$count godzin',
      few: '$count godziny',
      one: '$count godzina',
    );
    return '$_temp0';
  }

  @override
  String autoDeleteMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count minuty',
      many: '$count minut',
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
      other: '$count sekundy',
      many: '$count sekund',
      few: '$count sekundy',
      one: '$count sekunda',
    );
    return '$_temp0';
  }

  @override
  String get autoDeleteCustom => 'Własne…';

  @override
  String get autoDeleteCustomHint => 'Ilość';

  @override
  String get autoDeleteUnitMinutes => 'min';

  @override
  String get autoDeleteUnitHours => 'godz.';

  @override
  String get autoDeleteUnitDays => 'dni';

  @override
  String get contactProfileAutoDeleteSet => 'Ustaw';

  @override
  String get contactProfileFiles => 'Pliki';

  @override
  String get contactProfileNoFiles => 'Brak plików';

  @override
  String get contactProfileLinks => 'Linki';

  @override
  String get contactProfileNoLinks => 'Brak linków';

  @override
  String get contactProfilePolls => 'Ankiety';

  @override
  String get contactProfileNoPolls => 'Brak ankiet';

  @override
  String get presenceRecently => 'widziano niedawno';

  @override
  String get presenceJustNow => 'przed chwilą';

  @override
  String presenceHoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'widziano $count godziny temu',
      many: 'widziano $count godzin temu',
      few: 'widziano $count godziny temu',
      one: 'widziano $count godzinę temu',
    );
    return '$_temp0';
  }

  @override
  String presenceYesterdayAt(String time) {
    return 'widziano wczoraj o $time';
  }

  @override
  String presenceOnWeekday(String day) {
    String _temp0 = intl.Intl.selectLogic(
      day,
      {
        '1': 'widziano w poniedziałek',
        '2': 'widziano we wtorek',
        '3': 'widziano w środę',
        '4': 'widziano w czwartek',
        '5': 'widziano w piątek',
        '6': 'widziano w sobotę',
        '7': 'widziano w niedzielę',
        'other': 'widziano w tym tygodniu',
      },
    );
    return '$_temp0';
  }

  @override
  String presenceWeeksAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'widziano $count tygodnia temu',
      many: 'widziano $count tygodni temu',
      few: 'widziano $count tygodnie temu',
      one: 'widziano tydzień temu',
    );
    return '$_temp0';
  }

  @override
  String presenceMonthsAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'widziano $count miesiąca temu',
      many: 'widziano $count miesięcy temu',
      few: 'widziano $count miesiące temu',
      one: 'widziano miesiąc temu',
    );
    return '$_temp0';
  }

  @override
  String get presenceLongAgo => 'widziano dawno temu';

  @override
  String presenceMinutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'widziano $count minuty temu',
      many: 'widziano $count minut temu',
      few: 'widziano $count minuty temu',
      one: 'widziano $count minutę temu',
    );
    return '$_temp0';
  }

  @override
  String chatReadByCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Przeczytało $count osoby',
      many: 'Przeczytało $count osób',
      few: 'Przeczytały $count osoby',
      one: 'Przeczytała $count osoba',
    );
    return '$_temp0';
  }

  @override
  String get chatsSearchFrequent => 'Twoi rozmówcy';

  @override
  String get chatsSearchRecent => 'Ostatnie';

  @override
  String get chatsSearchClear => 'Wyczyść';

  @override
  String get chatsSearchStartHint =>
      'Szukaj czatów po nazwie albo dowolnej wiadomości po jej słowach.';

  @override
  String get chatsSearchEmpty => 'Nic nie pasuje';

  @override
  String get chatRoutesTitle => 'Jak to do niego dotrze';

  @override
  String get chatRoutesBluetoothHint =>
      'Prosto na jego telefon, bez udziału internetu';

  @override
  String get chatRoutesMeshHint => 'Przekazywane przez telefony pomiędzy wami';

  @override
  String get chatRoutesInternetHint =>
      'Przez przekaźnik, gdy nikogo nie ma w zasięgu';

  @override
  String get chatRoutesHint =>
      'Droga jest wybierana dla każdej wiadomości osobno, spośród tego, co jest osiągalne w danej chwili.';

  @override
  String get chatRoutesPreferTitle => 'Co próbować najpierw';

  @override
  String get chatRoutesPreferMesh => 'Najpierw Bluetooth';

  @override
  String get chatRoutesPreferMeshHint =>
      'Szybciej w tym samym pomieszczeniu, nie zużywa danych, przekaźnik nic nie wie';

  @override
  String get chatRoutesPreferRelay => 'Najpierw internet';

  @override
  String get chatRoutesPreferRelayHint =>
      'Przy słabym łączu Bluetooth i dobrym połączeniu';

  @override
  String get chatRoutesPreferNote =>
      'To preferencja, a nie blokada. Jeśli wybrana droga jest nieosiągalna, wiadomość i tak pójdzie drugą.';

  @override
  String get deadmanTitle => 'Wymaż, jeśli nieużywana';

  @override
  String get deadmanOff => 'Wyłączone';

  @override
  String deadmanDays(int days) {
    return 'Po $days dniach';
  }

  @override
  String get deadmanHint =>
      'Jeśli nikt nie otworzy tej aplikacji przez tyle czasu, wszystko w niej zostanie wymazane przy następnym otwarciu. Nie może cię wcześniej ostrzec — na tym to polega.';

  @override
  String chatForwardedFrom(String name) {
    return 'Przekazano od: $name';
  }

  @override
  String appLockWait(String left) {
    return 'Zbyt wiele prób — poczekaj $left';
  }

  @override
  String get appLockGraceTitle => 'Pytaj o kod';

  @override
  String get appLockGraceNow => 'Za każdym razem';

  @override
  String appLockGraceAfter(String left) {
    return 'Po $left nieobecności';
  }

  @override
  String get chatCalendarTitle => 'Według daty';

  @override
  String get chatCalendarEmpty => 'Nic tu jeszcze nie napisano';

  @override
  String get chatsSearchChatsSection => 'Czaty';

  @override
  String get chatsSearchMessagesSection => 'Wiadomości';

  @override
  String get contactProfileViewInChat => 'Pokaż w czacie';

  @override
  String get chatDraft => 'Wersja robocza';

  @override
  String get chatSearchTitle => 'Szukaj';

  @override
  String get chatSearchHint => 'Szukaj wiadomości';

  @override
  String get chatSearchNoResults => 'Brak wyników';

  @override
  String get chatSearchPrevious => 'Poprzedni wynik';

  @override
  String get chatSearchNext => 'Następny wynik';

  @override
  String chatMessageCount(int count) {
    return 'Wiadomości: $count';
  }

  @override
  String get chatRouteBluetooth => 'Bluetooth';

  @override
  String get chatRouteMesh => 'Mesh';

  @override
  String get chatRouteInternet => 'Internet';

  @override
  String get chatRouteQueued => 'W kolejce';

  @override
  String get attachStickers => 'Naklejki';

  @override
  String get stickersEmpty => 'Brak naklejek';

  @override
  String get stickersEmptyHint =>
      'Zachowaj obrazek z czatu, a pojawi się tutaj.';

  @override
  String get stickerKeep => 'Zapisz jako naklejkę';

  @override
  String get stickerKept => 'Zapisano w twoich naklejkach';

  @override
  String get stickerForget => 'Usuń naklejkę';

  @override
  String get stickerCreate => 'Utwórz naklejkę ze zdjęcia';

  @override
  String get stickerFailed => 'Z tego obrazka nie udało się zrobić naklejki';

  @override
  String get stickerLabel => 'Naklejka';

  @override
  String get previewPhoto => 'Zdjęcie';

  @override
  String get previewVoice => 'Wiadomość głosowa';

  @override
  String get previewFile => 'Plik';

  @override
  String get stickerEmojiTitle => 'Wybierz dla niej emoji';

  @override
  String get stickersMine => 'Moje naklejki';

  @override
  String get stickersStarterPack => 'Kubi';

  @override
  String get emojiTab => 'Emoji';

  @override
  String get chatBlockedStatus => 'zablokowano';

  @override
  String get chatBlockedHint => 'Ta osoba jest zablokowana';

  @override
  String get chatRouteFallbackOff => 'Internet wył.';

  @override
  String get chatAttachmentUnavailable =>
      'Brak dostępnego połączenia. Połącz się przez Bluetooth lub internet i spróbuj ponownie.';

  @override
  String get fileTransfersTitle => 'Przesyłanie plików';

  @override
  String get fileTransfersClear => 'Wyczyść historię';

  @override
  String get fileTransfersEmpty => 'Brak przesłanych plików';

  @override
  String get fileTransfersActive => 'Aktywne';

  @override
  String get fileTransfersHistory => 'Historia';

  @override
  String get fileTransferPause => 'Wstrzymaj';

  @override
  String get fileTransferResume => 'Wznów';

  @override
  String get fileTransferRetry => 'Ponów';

  @override
  String get fileTransferQueued => 'Czeka na połączenie';

  @override
  String get fileTransferRunning => 'Przesyłanie';

  @override
  String get fileTransferPaused => 'Wstrzymano';

  @override
  String get fileTransferCompleted => 'Ukończono';

  @override
  String get fileTransferFailed => 'Niepowodzenie';

  @override
  String get fileTransferCanceled => 'Anulowano';

  @override
  String get profileFileTransfers => 'Przesyłanie plików';

  @override
  String get profileFileTransfersSubtitle =>
      'Postęp, kolejka i historia przesyłania';

  @override
  String get qrScanAction => 'Skanuj kod QR';

  @override
  String get qrScanTitle => 'Skanuj kod QR';

  @override
  String get qrScanHint =>
      'Zeskanuj kod CubeChat kontaktu, kanału, przeniesienia konta lub logowania na komputerze.';

  @override
  String get qrFlash => 'Latarka';

  @override
  String get qrCameraError =>
      'Aparat jest niedostępny. Sprawdź uprawnienie do aparatu i spróbuj ponownie.';

  @override
  String get qrInvalid => 'To nie jest prawidłowy kod QR Cubechat.';

  @override
  String qrChannelAdded(String name) {
    return 'Dodano: $name';
  }

  @override
  String get qrShow => 'Pokaż kod QR';

  @override
  String qrChannelTitle(String name) {
    return 'Dołącz do $name';
  }

  @override
  String get profileBackup => 'Szyfrowana kopia zapasowa';

  @override
  String get profileBackupSubtitle =>
      'Bezpiecznie przenieś klucze, kontakty i historię';

  @override
  String get backupTitle => 'Szyfrowana kopia zapasowa';

  @override
  String get backupExplainer =>
      'Kopia zapasowa zawiera twoje prywatne klucze tożsamości, kontakty, kanały, ustawienia i historię wiadomości. Jest szyfrowana na tym telefonie wybranym przez ciebie hasłem; Cubechat nie odzyska zapomnianego hasła.';

  @override
  String get backupCreate => 'Utwórz kopię';

  @override
  String get backupCreateSubtitle =>
      'Zaszyfruj wszystko i zapisz plik .cchatbackup';

  @override
  String get backupRestore => 'Przywróć kopię';

  @override
  String get backupRestoreSubtitle =>
      'Zastąp profil Cubechat na tym telefonie danymi z pliku kopii';

  @override
  String get backupPasswordTitle => 'Hasło kopii zapasowej';

  @override
  String get backupPasswordHint => 'Co najmniej 8 znaków';

  @override
  String get backupConfirmPassword => 'Powtórz hasło';

  @override
  String get backupPasswordMismatch => 'Hasła nie są zgodne';

  @override
  String get backupPasswordShort => 'Użyj co najmniej 8 znaków';

  @override
  String get backupSaveTitle => 'Zapisz kopię zapasową Cubechat';

  @override
  String get backupSaved => 'Zapisano szyfrowaną kopię';

  @override
  String get backupWhereTitle => 'Gdzie zapisać kopię?';

  @override
  String get backupSaveToFiles => 'Zapisz w Plikach';

  @override
  String get backupSaveToFilesHint =>
      'Folder na tym telefonie, karta pamięci lub dysk w chmurze';

  @override
  String get backupSendToApp => 'Wyślij do aplikacji';

  @override
  String get backupSendToAppHint =>
      'Telegram, poczta, komunikator — cokolwiek przyjmuje pliki';

  @override
  String get backupFailed => 'Nie udało się ukończyć operacji kopii zapasowej';

  @override
  String get backupRestoreConfirmTitle => 'Zastąpić ten profil?';

  @override
  String get backupRestoreConfirmMessage =>
      'Obecne klucze, kontakty, kanały, ustawienia i historia na tym telefonie zostaną zastąpione wybraną kopią zapasową.';

  @override
  String get backupRestoreConfirmAction => 'Przywróć';

  @override
  String get backupRestored => 'Przywrócono kopię zapasową';

  @override
  String get backupPackingWait => 'Tworzenie kopii zapasowej…';

  @override
  String get backupUnpackingWait => 'Przywracanie kopii zapasowej…';

  @override
  String get backupWaitHint =>
      'Ze zdjęciami i filmami może to potrwać kilka minut. Nie zamykaj aplikacji.';

  @override
  String get backupInvalid =>
      'Błędne hasło, uszkodzony plik lub nieobsługiwana kopia';

  @override
  String get channelInfoTitle => 'Informacje o kanale';

  @override
  String get channelParticipantsTitle => 'Uczestnicy';

  @override
  String get channelAdministratorsTitle => 'Administratorzy';

  @override
  String get channelMakeAdmin => 'Mianuj administratorem';

  @override
  String get channelRemoveAdmin => 'Odbierz uprawnienia administratora';

  @override
  String get channelNoParticipants =>
      'Uczestnicy pojawią się po podpisanej aktywności';

  @override
  String get channelSharedContent => 'Multimedia, pliki i ankiety';

  @override
  String get channelDescriptionTitle => 'Opis';

  @override
  String get channelDescriptionEmpty => 'Brak opisu';

  @override
  String get channelDescriptionHint => 'Do czego służy ten kanał';

  @override
  String get channelDescriptionAdminOnly =>
      'Tylko administrator może zmienić opis';

  @override
  String get channelDescriptionSave => 'Zapisz';

  @override
  String get channelPrivateSubtitle => 'kanał prywatny';

  @override
  String get channelAvatarSet => 'Ustaw nowe zdjęcie';

  @override
  String get channelSettingsTitle => 'Ustawienia kanału';

  @override
  String get channelSettingsHint => 'Kto może pisać, kopiowanie, historia';

  @override
  String get channelLeaveAction => 'Opuść';

  @override
  String get channelLeaveConfirm =>
      'Pokój i wszystko, co w nim napisano, zniknie z tego telefonu. Klucz wynika z nazwy, więc możesz otworzyć go ponownie, wpisując tę samą.';

  @override
  String get channelShareAction => 'Udostępnij';

  @override
  String channelMembersOf(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count uczestnika',
      many: '$count uczestników',
      few: '$count uczestnicy',
      one: '1 uczestnik',
    );
    return '$_temp0';
  }

  @override
  String get chatTyping => 'pisze…';

  @override
  String get chatRecordingVoice => 'nagrywa wiadomość głosową…';

  @override
  String get chatRecordingCircle => 'nagrywa wiadomość wideo…';

  @override
  String get chatSendingPhoto => 'wysyła zdjęcie…';

  @override
  String get chatSendingVideo => 'wysyła film…';

  @override
  String get chatSendingFile => 'wysyła plik…';

  @override
  String get onboardingMeshTitle => 'Działa bez internetu';

  @override
  String get onboardingMeshBody =>
      'Wiadomości wędrują przez Bluetooth, z telefonu na telefon. Bez zasięgu, bez Wi-Fi, bez kont — tylko ludzie wokół ciebie.';

  @override
  String get onboardingRelayTitle => 'A z nim, gdy jest';

  @override
  String get onboardingRelayBody =>
      'Poza zasięgiem Bluetooth wiadomości idą przez internet i docierają tak samo. Nigdy nie musisz wybierać.';

  @override
  String get onboardingPrivacyTitle => 'Nikt po drodze tego nie przeczyta';

  @override
  String get onboardingPrivacyBody =>
      'Wszystko jest szyfrowane end-to-end, a twoja tożsamość to klucz na tym telefonie — nie numer telefonu, nie e-mail, nie konto, które ktoś może odebrać.';

  @override
  String get onboardingSkip => 'Pomiń';

  @override
  String get onboardingNext => 'Dalej';

  @override
  String get onboardingStart => 'Zaczynamy';

  @override
  String get chatMediaShare => 'Udostępnij';

  @override
  String get chatMediaSaveToGallery => 'Zapisz w galerii';

  @override
  String get chatMediaShowInChat => 'Pokaż w czacie';

  @override
  String get chatWallpaperTitle => 'Tapeta';

  @override
  String get chatWallpaperClear => 'Resetuj';

  @override
  String get chatWallpaperDim => 'Przyciemnij za wiadomościami';

  @override
  String get chatSelectAction => 'Zaznacz';

  @override
  String get chatForwardNothing => 'Nic tutaj nie da się przekazać';

  @override
  String chatSelectedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Zaznaczono $count',
      many: 'Zaznaczono $count',
      few: 'Zaznaczono $count',
      one: 'Zaznaczono 1',
    );
    return '$_temp0';
  }

  @override
  String chatDeleteSelectedTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Usunąć $count wiadomości?',
      many: 'Usunąć $count wiadomości?',
      few: 'Usunąć $count wiadomości?',
      one: 'Usunąć tę wiadomość?',
    );
    return '$_temp0';
  }

  @override
  String get contactAliasAction => 'Zmień nazwę kontaktu';

  @override
  String get contactAliasHint =>
      'Tylko ty widzisz tę nazwę. Zostaw puste, aby użyć jego własnej.';

  @override
  String get viewOnceSendLabel => 'Jednorazowe';

  @override
  String get viewOnceTitle => 'Wyświetl raz';

  @override
  String get viewOnceTapToView => 'Zdjęcie · dotknij, aby wyświetlić raz';

  @override
  String get viewOnceSent => 'Zdjęcie · wysłano';

  @override
  String get viewOnceOpened => 'Zdjęcie otwarte';

  @override
  String get viewOnceUnavailable => 'To zdjęcie nie jest już dostępne';

  @override
  String get viewOnceWarning => 'Zamknięcie usunie zdjęcie u was obojga.';

  @override
  String get channelAvatarAdminOnly =>
      'Tylko administrator może zmienić zdjęcie kanału';

  @override
  String get channelAdminOnly => 'Tylko administrator może to zmienić';

  @override
  String get channelAvatarTooLarge => 'To zdjęcie jest za duże do rozesłania';

  @override
  String get channelMemberUnknown => 'Jeszcze nie w twoich kontaktach';

  @override
  String get channelInviteToContacts => 'Wyślij swoją wizytówkę';

  @override
  String channelContactInviteSent(String name) {
    return 'Zaproponowano wizytówkę: $name';
  }

  @override
  String get chatContactInvitation => 'Zaproszenie do kontaktu';

  @override
  String get chatContactInvitationForYou => 'Zaproszenie dla ciebie';

  @override
  String get channelPollTitle => 'Ankieta';

  @override
  String get channelCreatePoll => 'Utwórz ankietę';

  @override
  String get channelPollQuestion => 'Pytanie';

  @override
  String channelPollOption(int number) {
    return 'Opcja $number';
  }

  @override
  String get channelPollAddOption => 'Dodaj opcję';

  @override
  String get channelPollCreate => 'Opublikuj ankietę';

  @override
  String channelPollVotes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count głosu',
      many: '$count głosów',
      few: '$count głosy',
      one: '1 głos',
      zero: 'Brak głosów',
    );
    return '$_temp0';
  }

  @override
  String get phoneTransferTitle => 'Przeniesienie na nowy telefon';

  @override
  String get desktopPickChat => 'Wybierz, do kogo chcesz napisać';

  @override
  String get desktopListCollapse => 'Pokaż tylko awatary';

  @override
  String get desktopListExpand => 'Pokaż listę czatów';

  @override
  String get desktopLinkConnectTitle => 'Połącz komputer';

  @override
  String get desktopLinkConnectHint =>
      'Zeskanuj kod wyświetlany przez CubeChat na komputerze';

  @override
  String get desktopLinkSignIn => 'Zaloguj się kontem z telefonu';

  @override
  String get desktopLinkTitle => 'Zaloguj się przez telefon';

  @override
  String get desktopLinkSteps =>
      'Na telefonie: Profil → Dane → Połącz komputer, a następnie zeskanuj ten kod. Oba urządzenia muszą być w tej samej sieci Wi-Fi.';

  @override
  String get desktopLinkLimits =>
      'Telefon nadal działa. Wiadomości z internetu docierają na oba urządzenia; to, co wyślesz z jednego, nie pojawia się jeszcze na drugim.';

  @override
  String get desktopLinkWaiting => 'Czekanie na telefon…';

  @override
  String get desktopLinkFailed =>
      'Nie udało się odebrać konta. Spróbuj ponownie.';

  @override
  String get desktopLinkRetry => 'Spróbuj ponownie';

  @override
  String get desktopLinkConfirmTitle => 'Wysłać kopię tego konta na komputer?';

  @override
  String get desktopLinkConfirmMessage =>
      'Komputer otrzyma twoje klucze, kontakty i czaty. Ten telefon będzie działał jak dotąd.';

  @override
  String get desktopLinkConfirmAction => 'Wyślij';

  @override
  String desktopLinkConfirmWhere(String address) {
    return 'Tylko jeśli przed chwilą zeskanowano ten kod z ekranu twojego własnego komputera. Kopia trafi do $address w tej sieci.';
  }

  @override
  String get desktopLinkSending => 'Wysyłanie konta…';

  @override
  String get desktopLinkSent => 'Komputer jest połączony';

  @override
  String get desktopLinkPhoneFound =>
      'Telefon znalazł ten komputer i tworzy kopię konta. Ze zdjęciami może to potrwać kilka minut.';

  @override
  String desktopLinkReceiving(int percent) {
    return 'Odbieranie konta: $percent%';
  }

  @override
  String get desktopLinkRestoring => 'Instalowanie konta na tym komputerze…';

  @override
  String get desktopLinkFinding => 'Szukanie komputera…';

  @override
  String get desktopLinkPreparing =>
      'Tworzenie kopii konta. Ze zdjęciami może to potrwać kilka minut.';

  @override
  String desktopLinkSendingPercent(int percent) {
    return 'Wysyłanie: $percent%';
  }

  @override
  String get desktopLinkComputerRestoring => 'Komputer instaluje konto…';

  @override
  String get devicesTitle => 'Urządzenia';

  @override
  String get devicesRowHint => 'Gdzie twoje konto jest otwarte i wylogowywanie';

  @override
  String get devicesThisDevice => 'To urządzenie';

  @override
  String get devicesSeenNow => 'Online przed chwilą';

  @override
  String devicesSeenMinutes(int n) {
    return 'Online $n min temu';
  }

  @override
  String devicesSeenHours(int n) {
    return 'Online $n godz. temu';
  }

  @override
  String devicesSeenDays(int n) {
    return 'Online $n dn. temu';
  }

  @override
  String get devicesLeaving => 'Wylogowywanie — czekamy, aż będzie online';

  @override
  String get devicesSignOut => 'Wyloguj';

  @override
  String get devicesSignOutAll => 'Wyloguj na wszystkich innych urządzeniach';

  @override
  String devicesSignOutTitle(String name) {
    return 'Wylogować na „$name”?';
  }

  @override
  String get devicesSignOutMessage =>
      'Klucze, czaty i ustawienia CubeChat zostaną wymazane na tym urządzeniu, gdy tylko będzie online. Konto pozostanie tutaj i na twoich innych urządzeniach.';

  @override
  String get devicesSignOutPhoneMessage =>
      'To telefon: CubeChat zostanie na nim całkowicie wymazany. Konto pozostanie tutaj i na twoich innych urządzeniach.';

  @override
  String get devicesSignOutAllMessage =>
      'Każde inne urządzenie wyloguje się, gdy tylko będzie online. Konto pozostanie tylko tutaj.';

  @override
  String get devicesRename => 'Zmień nazwę';

  @override
  String get devicesRenameTitle => 'Nazwa tego urządzenia';

  @override
  String get devicesSave => 'Zapisz';

  @override
  String get devicesEmpty =>
      'Brak innych urządzeń. Urządzenie pojawi się tutaj, gdy otworzy CubeChat 1.0.0+1147 lub nowszy.';

  @override
  String get devicesCaveat =>
      'Wylogowanie zadziała, gdy to urządzenie połączy się z siecią. Urządzenie trzymane offline zachowa klucze; pełna ochrona oznaczałaby nowe klucze konta.';

  @override
  String get desktopLinkImportTitle => 'Przenieś konto z telefonu';

  @override
  String get desktopLinkImportHint =>
      'Pokaż telefonowi kod, a ten komputer stanie się kopią jego konta';

  @override
  String get desktopLinkImportConfirmTitle =>
      'Zastąpić konto na tym komputerze?';

  @override
  String get desktopLinkImportConfirmMessage =>
      'Klucze, kontakty i czaty tego komputera zostaną zastąpione kontem z telefonu. Jeśli to konto jest ci jeszcze potrzebne, najpierw zrób kopię zapasową.';

  @override
  String get desktopLinkImportConfirmAction => 'Kontynuuj';

  @override
  String get desktopLinkUnreachable =>
      'Nie udało się połączyć z komputerem. Oba urządzenia muszą być w tej samej sieci Wi-Fi, a na komputerze CubeChat musi mieć zezwolenie w zaporze.';

  @override
  String get desktopLinkFirewallHint =>
      'Windows może nie wpuścić telefonu do tego komputera. Zezwól CubeChat w zaporze — tylko dla sieci lokalnej.';

  @override
  String get desktopLinkFirewallAllow => 'Zezwól w zaporze';

  @override
  String get desktopLinkFirewallDeclined =>
      'Windows nie zezwolił. Bez tego telefon może się nie połączyć.';

  @override
  String get phoneTransferIntro =>
      'Przenieś profil, klucze, kontakty, kanały, ustawienia i historię bezpośrednio między dwoma telefonami.';

  @override
  String get phoneTransferSend => 'To jest stary telefon';

  @override
  String get phoneTransferReceive => 'To jest nowy telefon';

  @override
  String get phoneTransferSameWifi =>
      'Połącz oba telefony z tą samą siecią Wi-Fi. Nie zamykaj tego ekranu do końca przenoszenia.';

  @override
  String get phoneTransferPreparing =>
      'Przygotowywanie szyfrowanego przeniesienia…';

  @override
  String get phoneTransferReady =>
      'Zeskanuj ten jednorazowy kod QR na nowym telefonie';

  @override
  String get phoneTransferScan => 'Skanuj stary telefon';

  @override
  String get phoneTransferConfirmTitle => 'Zastąpić profil na tym telefonie?';

  @override
  String get phoneTransferConfirmMessage =>
      'Profil zapisany obecnie na tym telefonie zostanie zastąpiony danymi z szyfrowanego przeniesienia lokalnego.';

  @override
  String get phoneTransferConfirmAction => 'Przenieś profil';

  @override
  String get phoneTransferSuccess => 'Profil został przeniesiony';

  @override
  String get phoneTransferFailed =>
      'Nie udało się ukończyć przenoszenia telefonu';

  @override
  String get profileSummaryMeshOnly => 'Tylko mesh';

  @override
  String get profileSummaryMeshInternet => 'Mesh · internet';

  @override
  String get profileSummaryBackgroundOn => 'działa w tle';

  @override
  String profileSummaryTransfersActive(int count) {
    return 'W toku: $count';
  }

  @override
  String get profileSummaryCardBackup => 'Pliki, kopia';

  @override
  String get chatPlay => 'Odtwórz';

  @override
  String get chatPause => 'Pauza';

  @override
  String get profileTheme => 'Kolor';

  @override
  String get profileThemeEmerald => 'Szmaragd';

  @override
  String get profileThemeIndigo => 'Indygo';

  @override
  String get profileThemeAmber => 'Bursztyn';

  @override
  String get profileThemeRose => 'Róża';

  @override
  String get profileThemeFuchsia => 'Fuksja';

  @override
  String get profileThemeViolet => 'Fiolet';

  @override
  String get profileThemeOcean => 'Ocean';

  @override
  String get profileThemeSlate => 'Grafit';

  @override
  String get profileScale => 'Rozmiar interfejsu';

  @override
  String get profileScaleSystem => 'Systemowy';

  @override
  String get profileGlass => 'Szkło';

  @override
  String get profileGlassAuto => 'Automatycznie';

  @override
  String get profileGlassFull => 'Pełne';

  @override
  String get profileGlassLight => 'Lekkie';

  @override
  String get profileGlassHint =>
      'Lekkie zachowuje odcień i usuwa rozmycie za panelami. Automatycznie mierzy twój telefon raz i decyduje. Na telefonie, który i tak nadąża, daje to niewiele — jest dla tego, który nie nadąża.';

  @override
  String get mapAlwaysNeeded =>
      'Aby mapa aktualizowała się, gdy cubechat jest zamknięty, lokalizacja musi być ustawiona na Zawsze. Dotknij, aby otworzyć Ustawienia.';

  @override
  String get mapShareConsentTitle => 'Pokazywać twoją lokalizację na mapie?';

  @override
  String get mapShareConsentBody =>
      'Twoja bieżąca lokalizacja będzie widoczna tylko dla kontaktów na twojej mapie: osób, które zaprosisz, lub których zaproszenie przyjmiesz. Będzie się aktualizować, także gdy Cubechat działa w tle, dopóki się nie ukryjesz. Jest szyfrowana end-to-end i nigdy do nas nie trafia. Możesz się ukryć w każdej chwili na mapie lub w Profilu, a zablokowane kontakty nigdy cię nie widzą.';

  @override
  String get mapShareConsentAllow => 'Zezwól';

  @override
  String get mapShareConsentDecline => 'Nie zezwalaj';

  @override
  String get mapVisibleToFriends => 'Znajomi na mapie cię widzą';

  @override
  String get mapHiddenFromFriends => 'Twoja lokalizacja jest ukryta';

  @override
  String get mapHideMe => 'Ukryj';

  @override
  String get mapShowMe => 'Pokaż mnie';

  @override
  String get profileScaleSmall => 'Mniejszy';

  @override
  String get profileScaleNormal => 'Normalny';

  @override
  String get profileScaleLarge => 'Większy';

  @override
  String get profileScaleSample =>
      'Tekst i wiersze są rysowane w tym rozmiarze.';

  @override
  String get savedTitle => 'Zapisane';

  @override
  String get savedSubtitle => 'Notatki dla siebie, na tym urządzeniu';

  @override
  String get savedEmpty =>
      'Wszystko, co tu napiszesz, zostaje na tym telefonie.';

  @override
  String get meshOffTitle => 'Bluetooth mesh jest wyłączony';

  @override
  String get meshOffHint =>
      'Nikt w pobliżu cię nie znajdzie, a ty nie znajdziesz nikogo. Wiadomości nadal idą przez przekaźnik internetowy.';

  @override
  String get profileMeshSwitch => 'Bluetooth mesh';

  @override
  String get profileMeshSwitchHint =>
      'Znajduj osoby w pobliżu i przesyłaj wiadomości bez internetu. Wyłączenie oszczędza baterię.';

  @override
  String get channelAdminOnlyHint => 'Kanał ogłoszeniowy. Czytać mogą wszyscy.';

  @override
  String get attachLocation => 'Lokalizacja';

  @override
  String get locationBubbleTitle => 'Lokalizacja';

  @override
  String get locationOpenInMaps => 'Otwórz w mapach';

  @override
  String locationAccuracy(int metres) {
    return 'z dokładnością do $metres m';
  }

  @override
  String get locationExpired => 'Ta lokalizacja nie jest już aktualna';

  @override
  String get locationDenied => 'Dostęp do lokalizacji jest wyłączony';

  @override
  String get locationUnavailable => 'Nie udało się ustalić pozycji';

  @override
  String get locationShareFor => 'Udostępnij na';

  @override
  String get locationShareOnce => 'Jednorazowo';

  @override
  String get locationShare15m => '15 minut';

  @override
  String get locationShare1h => '1 godzina';

  @override
  String get storageTitle => 'Pamięć';

  @override
  String get storageHeadline => 'Użycie pamięci';

  @override
  String storageSubtitle(String size) {
    return 'cubechat zajmuje $size na tym urządzeniu';
  }

  @override
  String get storageEmpty => 'Nic jeszcze nie zapisano';

  @override
  String get storageScanning => 'Liczenie…';

  @override
  String get storageCatPhotos => 'Zdjęcia';

  @override
  String get storageCatVoice => 'Wiadomości głosowe';

  @override
  String get storageCatFiles => 'Odebrane pliki';

  @override
  String get storageCatOutbox => 'Wysłane pliki';

  @override
  String get storageCatStickers => 'Naklejki';

  @override
  String get storageCatSaved => 'Zapisane wiadomości';

  @override
  String get storageCatWallpapers => 'Tapety';

  @override
  String get storageCatHistory => 'Rozmowy i klucze';

  @override
  String get storageCatCache => 'Pamięć podręczna';

  @override
  String storageClear(String size) {
    return 'Wyczyść $size';
  }

  @override
  String get storageClearNothing => 'Nic nie zaznaczono';

  @override
  String storageFreed(String size) {
    return 'Zwolniono $size';
  }

  @override
  String get storageNoCloud =>
      'Nie ma za tym żadnej chmury. Wszystko, co wyczyścisz, zniknie z tego telefonu, a jedyna inna kopia jest na telefonie, z którego przyszło.';

  @override
  String get storageWhyHistoryLocked =>
      'Rozmów nie czyści się stąd — użyj Awaryjnego wymazania.';

  @override
  String get storageRecoveryFree => 'Można bezpiecznie wyczyścić';

  @override
  String get storageRecoveryGone => 'Nigdzie indziej nie ma kopii';

  @override
  String get storageRecoveryAskSender => 'Można ponownie poprosić nadawcę';

  @override
  String get storageRecoveryCostsThem =>
      'Nie będą mogli już poprosić cię o ponowne wysłanie';

  @override
  String storageConfirmTitle(String size) {
    return 'Wyczyścić $size?';
  }

  @override
  String get storageConfirmBody =>
      'Pliki zostaną usunięte z tego telefonu. Nic nie jest nigdzie wysyłane, więc nie będzie skąd ich przywrócić.';

  @override
  String storageFilesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count pliku',
      many: '$count plików',
      few: '$count pliki',
      one: '$count plik',
      zero: 'puste',
    );
    return '$_temp0';
  }

  @override
  String get customizeBarTitle => 'Pasek nawigacji';

  @override
  String get customizeBarHint =>
      'Przeciągnij, aby zmienić kolejność. Czatów nie można usunąć.';

  @override
  String get customizeBarShown => 'Widoczne';

  @override
  String get customizeBarHidden => 'Ukryte';

  @override
  String get customizeBarHiddenEmpty => 'Nic nie jest ukryte';

  @override
  String get customizeBarMinimum => 'Zostaw co najmniej dwie karty';

  @override
  String get customizeReset => 'Przywróć domyślne';

  @override
  String get chatsArchiveTitle => 'Archiwum';

  @override
  String get chatsArchiveEmpty => 'Archiwum jest puste';

  @override
  String get chatsArchiveHint =>
      'Zarchiwizowane czaty działają normalnie — są tylko poza listą.';

  @override
  String get chatsArchivedToast => 'Zarchiwizowano';

  @override
  String get chatsUnarchivedToast => 'Przywrócono na listę';

  @override
  String chatsArchiveCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count czatu',
      many: '$count czatów',
      few: '$count czaty',
      one: '$count czat',
    );
    return '$_temp0';
  }

  @override
  String get chatsSwipeNotHere => 'Niedostępne dla tego czatu';

  @override
  String get customizeSwipeTitle => 'Przesunięcie czatu w prawo';

  @override
  String get customizeSwipeHint => 'Przesunięcie w lewo nadal przełącza karty.';

  @override
  String get customizeSwipeArchive => 'Archiwizuj';

  @override
  String get customizeSwipeMute => 'Wycisz';

  @override
  String get customizeSwipePin => 'Przypnij';

  @override
  String get customizeSwipeRead => 'Przeczytane';

  @override
  String get customizeSwipeDelete => 'Usuń';

  @override
  String get customizeSwipeNone => 'Nic';

  @override
  String get customizeHighRefresh => 'Pełna częstotliwość odświeżania';

  @override
  String get customizeHighRefreshHint =>
      'Płynniej, a telefon rysuje dwa razy więcej klatek. Wyłącz, jeśli się nagrzewa — wygląd aplikacji się nie zmienia, tylko to, jak często jest przerysowywana.';

  @override
  String get customizeQuickReaction => 'Reakcja na podwójne dotknięcie';

  @override
  String get customizeQuickReactionHint =>
      'Co zostawia podwójne dotknięcie wiadomości. Użycie innej reakcji przenosi ją tutaj.';

  @override
  String get customizeCircleAudioTitle =>
      'Wstrzymuj muzykę dla wiadomości wideo';

  @override
  String get customizeCircleAudioOn =>
      'Nagrywanie lub oglądanie zatrzymuje wszystko inne, co gra. Potem nie wznowi się samo.';

  @override
  String get customizeCircleAudioOff =>
      'Twoja muzyka gra dalej w tle, ciszej podczas wiadomości wideo.';

  @override
  String get customizeMediaQualityTitle => 'Jakość wysyłanych zdjęć';

  @override
  String get customizeMediaQualityEconomy => 'Oszczędna';

  @override
  String get customizeMediaQualityStandard => 'Standard';

  @override
  String get customizeMediaQualityHigh => 'Wysoka';

  @override
  String get customizeMediaQualityEconomyHint =>
      'Do 96 KB na zdjęcie, 800 px. Na jedną kreskę zasięgu lub zatłoczoną sieć Bluetooth mesh: połowa czekania, mniej ostry obraz.';

  @override
  String get customizeMediaQualityStandardHint =>
      'Do 192 KB na zdjęcie, 1280 px. W takim rozmiarze przejdzie nawet przez sam Bluetooth. Filmy i „Oryginał” zawsze są wysyłane bez zmian.';

  @override
  String get customizeMediaQualityHighHint =>
      'Do 768 KB na zdjęcie, 2048 px. Wystarczająco ostre do powiększania; wysyła się cztery razy dłużej, więc najlepiej przez Wi-Fi.';

  @override
  String get previewReacted => 'na twoją wiadomość';

  @override
  String get previewLocation => 'Lokalizacja';

  @override
  String get previewMapInvite => 'Zaproszenie na mapę';

  @override
  String get previewContact => 'Kontakt';

  @override
  String get previewUnsupported => 'Nieobsługiwana wiadomość';

  @override
  String get previewCallOutgoing => 'Połączenie wychodzące';

  @override
  String get previewCallIncoming => 'Połączenie przychodzące';

  @override
  String get previewCallMissed => 'Nieodebrane połączenie';

  @override
  String chatPreparingPhotos(int count) {
    return 'Przygotowywanie zdjęć: $count…';
  }

  @override
  String get circleSwitchCamera => 'Przełącz kamerę';

  @override
  String get circleLight => 'Podświetlenie nagrania';

  @override
  String get circleCameraSwitchFailed =>
      'Nie udało się przełączyć kamery. Nagranie jest nadal otwarte.';

  @override
  String get diagnosticsTitle => 'Diagnostyka';

  @override
  String get diagnosticsIntro =>
      'Co aplikacja robiła ostatnio. Jeśli coś nie działa, wyślij to deweloperowi.';

  @override
  String get diagnosticsShare => 'Wyślij dziennik deweloperowi';

  @override
  String get diagnosticsEvents => 'Ostatnie zdarzenia';

  @override
  String get diagnosticsTechnical => 'Zapisy techniczne';

  @override
  String get diagnosticsEmpty => 'Na razie nic do pokazania.';

  @override
  String get diagnosticsDeveloperOn => 'Tryb dewelopera włączony';

  @override
  String get diagnosticsDeveloperOff => 'Tryb dewelopera wyłączony';

  @override
  String get logAppStarted => 'Aplikacja uruchomiona';

  @override
  String get logInternetOn => 'Połączenie przez internet włączone';

  @override
  String logServerConnected(String host) {
    return 'Połączono z $host';
  }

  @override
  String logServerLost(String host) {
    return 'Utracono połączenie z $host';
  }

  @override
  String get chatSaveAction => 'Zapisz';

  @override
  String get savedTagAsk => 'Zapisano. Dodać tag?';

  @override
  String get savedTagAdd => 'Dodaj tag';

  @override
  String get chatSharedWallpaperFailed =>
      'Tapeta ustawiona tutaj. Dotrze do rozmówcy, gdy będzie w zasięgu.';

  @override
  String get chatTranscribeAction => 'Transkrybuj';

  @override
  String get chatTranscribeFailed =>
      'Ten telefon nie może transkrybować tej wiadomości.';

  @override
  String get chatTranscribing => 'Rozpoznawanie…';

  @override
  String get chatTranscriptHide => 'Ukryj tekst';

  @override
  String get chatCancelSend => 'Anuluj wysyłanie';

  @override
  String get chatDownloadAction => 'Pobierz';

  @override
  String get chatDownloaded => 'Zapisano na telefonie';

  @override
  String get chatDownloadFailed => 'Nie udało się zapisać';

  @override
  String get selfUpdateTitle => 'Zainstaluj aktualizację z pliku';

  @override
  String get selfUpdateHint =>
      'Wybierz nowy plik APK cubechat tutaj, zamiast otwierać go z czatu: po takiej instalacji połączenia na ekranie blokady pozostaną włączone.';

  @override
  String get selfUpdateConfirm => 'Potwierdź instalację w oknie systemowym.';

  @override
  String get selfUpdateAllow =>
      'Zezwól cubechat na instalowanie aplikacji, a potem dotknij ponownie.';

  @override
  String get selfUpdateNotOurs => 'Ten plik nie jest aktualizacją cubechat.';

  @override
  String get selfUpdateFailed => 'Aktualizacja nie została zainstalowana.';

  @override
  String get chatTranscribeDownloading =>
      'Telefon pobiera model języka. Spróbuj ponownie za minutę.';

  @override
  String get chatTranscribeNoLanguage =>
      'Ten telefon nie ma modelu mowy dla tego języka. Wybierz język transkrypcji w Profil → Czaty i multimedia.';

  @override
  String get chatTranscribeNotAllowed =>
      'Rozpoznawanie mowy jest wyłączone dla CubeChat. Włącz je w Ustawieniach iPhone’a → CubeChat.';

  @override
  String get customizeTranscribeLanguageTitle => 'Język transkrypcji';

  @override
  String get customizeTranscribeLanguageAuto => 'Auto';

  @override
  String get customizeTranscribeLanguageHint =>
      'Język, w którym nagrywane są wiadomości — nie musi być językiem aplikacji. Auto próbuje języków telefonu. Brakujący język telefon pobierze sam; głos nigdy go nie opuszcza.';

  @override
  String get chatTranslateAction => 'Przetłumacz';

  @override
  String get chatTranslateFailed =>
      'Tej wiadomości nie da się przetłumaczyć na tym telefonie.';

  @override
  String get customizeDeferMediaTitle =>
      'Pobieraj multimedia tylko przez Wi-Fi';

  @override
  String get customizeDeferMediaHint =>
      'Na danych komórkowych wiadomości tekstowe i połączenia działają normalnie, a zdjęcia, wiadomości głosowe, wiadomości wideo i pliki czekają na serwerze na Wi-Fi — do dwóch tygodni. Wiersz nad czatami pokazuje, co czeka, i pozwala pobrać to od razu.';

  @override
  String heldMediaCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count pliku czeka na Wi-Fi',
      many: '$count plików czeka na Wi-Fi',
      few: '$count pliki czekają na Wi-Fi',
      one: '1 plik czeka na Wi-Fi',
    );
    return '$_temp0';
  }

  @override
  String get heldMediaDownload => 'Pobierz';

  @override
  String get nearbyAirDropSubtitle => 'Udostępniaj pliki osobom w pobliżu';

  @override
  String get nearbyFilesSubtitle => 'Wysłane i odebrane pliki';

  @override
  String get airdropTab => 'AirDrop';

  @override
  String get nearbyTabFiles => 'Pliki';

  @override
  String get airdropReceiveHint => 'Kto może wysyłać ci pliki';

  @override
  String get airdropReceiveContacts => 'Kontakty';

  @override
  String get airdropReceiveEveryone => 'Wszyscy 10 min';

  @override
  String airdropEveryoneLeft(String time) {
    return 'Wszyscy · $time';
  }

  @override
  String get airdropSendFiles => 'Wyślij pliki';

  @override
  String get airdropChooseFiles => 'Wybierz pliki';

  @override
  String airdropStagedTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count pliku gotowego',
      many: '$count plików gotowych',
      few: '$count pliki gotowe',
      one: '1 plik gotowy',
    );
    return '$_temp0';
  }

  @override
  String get airdropStagedHint =>
      'Z włączonym Bluetooth i otwartym AirDrop na obu telefonach zbliż je do siebie albo wybierz osobę';

  @override
  String get airdropStagedPickPerson => 'Wybierz osobę';

  @override
  String airdropRequestBody(String what, String size) {
    return 'chce wysłać $what · $size';
  }

  @override
  String airdropWhatPhotos(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count zdjęcia',
      many: '$count zdjęć',
      few: '$count zdjęcia',
      one: '1 zdjęcie',
    );
    return '$_temp0';
  }

  @override
  String airdropWhatVideos(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count filmu',
      many: '$count filmów',
      few: '$count filmy',
      one: '1 film',
    );
    return '$_temp0';
  }

  @override
  String airdropWhatFiles(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count pliku',
      many: '$count plików',
      few: '$count pliki',
      one: '1 plik',
    );
    return '$_temp0';
  }

  @override
  String get airdropAccept => 'Przyjmij';

  @override
  String get airdropDecline => 'Odrzuć';

  @override
  String get airdropWaiting => 'Czekanie na odpowiedź…';

  @override
  String get airdropAccepted => 'Przyjęto';

  @override
  String get airdropUnheard => 'Nie odebrano — może to stara wersja CubeChat';

  @override
  String get airdropSending => 'Wysyłanie';

  @override
  String get airdropReceiving => 'Odbieranie';

  @override
  String get airdropInterrupted => 'Przerwano';

  @override
  String get airdropRetry => 'Ponów';

  @override
  String get airdropOutcomeSent => 'Wysłano';

  @override
  String get airdropOutcomeReceived => 'Odebrano';

  @override
  String get airdropOutcomeDeclined => 'Odrzucono';

  @override
  String get airdropOutcomeCancelled => 'Anulowano';

  @override
  String get airdropOutcomePartial => 'Częściowo';

  @override
  String get airdropReasonNoSpace => 'brak miejsca';

  @override
  String get airdropReasonContactsOnly => 'tylko od kontaktów';

  @override
  String get airdropReasonBusy => 'zajęte';

  @override
  String get airdropReasonTimeout => 'brak odpowiedzi';

  @override
  String get airdropFileDeleted => 'usunięto';

  @override
  String get airdropHistory => 'Historia';

  @override
  String get airdropClearHistory => 'Wyczyść historię';

  @override
  String get airdropEmpty =>
      'Tutaj pojawią się pliki wysyłane i odbierane w pobliżu';

  @override
  String get airdropPickPerson => 'Wyślij do';

  @override
  String get airdropNobody => 'Nikogo z cubechat jeszcze nie ma w pobliżu';

  @override
  String get airdropNoDirect => 'Brak połączenia Bluetooth z tą osobą';

  @override
  String get airdropNearbyUnknown => 'W pobliżu';

  @override
  String get airdropConnecting => 'Łączenie…';

  @override
  String get airdropConnectFailed => 'Nie udało się połączyć';

  @override
  String get airdropSlowWarning => 'Przez Bluetooth może to długo potrwać';

  @override
  String airdropTooLarge(String name, int limit) {
    return '$name przekracza $limit MB';
  }

  @override
  String airdropFromLabel(String name) {
    return 'AirDrop · $name';
  }

  @override
  String get airdropWrite => 'Napisz';

  @override
  String get airdropAction => 'AirDrop';

  @override
  String get airdropLaneTitle => 'Kanał';

  @override
  String get airdropLaneAuto => 'Auto';

  @override
  String get airdropLaneBluetooth => 'Bluetooth';

  @override
  String get airdropLaneWifi => 'Wi‑Fi';

  @override
  String get airdropBluetoothNeededHint =>
      'Włącz Bluetooth na obu telefonach, aby mogły się znaleźć i potwierdzić przesyłanie.';

  @override
  String get airdropLaneHint =>
      'Bluetooth znajduje i łączy telefony. Wi‑Fi przesyła pliki, gdy oba telefony są w tej samej sieci lub hotspocie.';

  @override
  String get airdropWifiUnreachable => 'Nie w tej samej sieci';

  @override
  String get airdropWifiOldVersion =>
      'Ich aplikacja nie odbiera jeszcze przez Wi‑Fi';

  @override
  String get airdropBumpAdd => 'Dodaj';

  @override
  String get airdropBumpAlreadyContact => 'Już w twoich kontaktach';

  @override
  String airdropBumpSending(String name) {
    return 'Wysyłanie do: $name';
  }

  @override
  String airdropBumpReceiving(String name) {
    return '$name wysyła ci pliki';
  }

  @override
  String get termsTitle => 'Zasady cubechat';

  @override
  String get termsBody =>
      'cubechat nie toleruje niestosownych treści ani obraźliwych użytkowników. Kontynuując, zgadzasz się nie wysyłać nękania, gróźb, treści seksualnych z udziałem nieletnich, spamu ani niczego nielegalnego. Każdy może zgłosić wiadomość lub osobę; zgłoszenia trafiają do dewelopera i są rozpatrywane w ciągu 24 godzin, a sprawcy są blokowani.';

  @override
  String get termsReadFull => 'Pełny regulamin';

  @override
  String get termsAccept => 'Akceptuję';

  @override
  String get messageHide => 'Ukryj';

  @override
  String get messageHidden => 'Ukryte dla ciebie';

  @override
  String get reportAction => 'Zgłoś';

  @override
  String get reportTitle => 'Co jest nie tak?';

  @override
  String get reportReasonSpam => 'Spam';

  @override
  String get reportReasonAbuse => 'Obraźliwe treści lub nękanie';

  @override
  String get reportReasonViolence => 'Przemoc';

  @override
  String get reportReasonSexual => 'Treści seksualne';

  @override
  String get reportReasonOther => 'Inne';

  @override
  String get reportNoteHint => 'Opisz (opcjonalnie)';

  @override
  String get reportSend => 'Wyślij zgłoszenie';

  @override
  String get reportDisclosure =>
      'Tekst wybranej wiadomości i twoje zgłoszenie trafią do moderacji cubechat i jej prywatnego bota w Telegramie.';

  @override
  String get reportSent =>
      'Zgłoszenie wysłane. Rozpatrujemy zgłoszenia w ciągu 24 godzin.';

  @override
  String get reportBlockedToo => 'Ta osoba jest dla ciebie zablokowana.';

  @override
  String get reportQueued =>
      'Zgłoszenie zapisane. Zostanie wysłane, gdy będziesz online.';

  @override
  String get reportFailed => 'Nie udało się wysłać zgłoszenia.';

  @override
  String get filteredMessage => 'Ukryte przez filtr';

  @override
  String get filteredShow => 'Pokaż';

  @override
  String get filterToggle => 'Filtr obraźliwych treści';

  @override
  String get filterToggleHint =>
      'Ukrywa wulgaryzmy od nieznajomych i w kanałach';

  @override
  String get aboutTitle => 'O aplikacji';

  @override
  String get aboutContact => 'Napisz do dewelopera';

  @override
  String get aboutReport => 'Zgłoś naruszenie';

  @override
  String get aboutTerms => 'Warunki korzystania';

  @override
  String get aboutPrivacy => 'Polityka prywatności';

  @override
  String get requestsTitle => 'Prośby';

  @override
  String get requestsEmpty => 'Brak próśb';

  @override
  String requestBanner(String name) {
    return '$name nie ma w twoich kontaktach. Dopóki nie zaakceptujesz, ta osoba nie widzi, że przeczytano wiadomość, i nie może do ciebie zadzwonić.';
  }

  @override
  String get requestAccept => 'Akceptuj';

  @override
  String get requestDelete => 'Usuń';

  @override
  String get requestBlock => 'Zablokuj';

  @override
  String get cubeIdTitle => 'Cube ID';

  @override
  String get cubeIdExplainer =>
      'Twoja @nazwa wskazuje na twoją wizytówkę. Serwer przechowuje tylko nazwę i publiczną wizytówkę — nigdy twoje wiadomości.';

  @override
  String get cubeIdFieldHint => 'a–z, 0–9 i _, 3–20 znaków';

  @override
  String get cubeIdAvailable => 'Dostępna';

  @override
  String get cubeIdTaken => 'Zajęta';

  @override
  String get cubeIdReserved => 'Niedozwolona';

  @override
  String get cubeIdInvalid => 'Tylko a–z, 0–9 i _, 3–20 znaków';

  @override
  String get cubeIdClaim => 'Zajmij tę nazwę';

  @override
  String get cubeIdWorking => 'Rezerwowanie nazwy…';

  @override
  String get cubeIdChange => 'Zmień';

  @override
  String get cubeIdEmail => 'E-mail do odzyskiwania';

  @override
  String get cubeIdEmailHint =>
      'Jeśli zgubisz ten telefon, nazwę można odzyskać przez list na ten adres';

  @override
  String get cubeIdEmailField => 'E-mail';

  @override
  String cubeIdEmailSent(String email) {
    return 'Wysłano wiadomość na $email. Otwórz link w niej.';
  }

  @override
  String get cubeIdEmailRemove => 'Usuń e-mail';

  @override
  String get cubeIdEmailUnavailable =>
      'E-mail jest teraz niedostępny. Spróbuj później.';

  @override
  String get cubeIdEmailInvalid => 'To nie wygląda na adres e-mail';

  @override
  String get cubeIdSave => 'Zapisz';

  @override
  String get cubeIdRecover => 'Odzyskaj nazwę przez e-mail';

  @override
  String get cubeIdRecoverSent =>
      'Jeśli adres się zgadza, przyjdzie wiadomość. Nazwa przejdzie na ten telefon 48 godzin po otwarciu linku.';

  @override
  String cubeIdRecoveryWarning(String name, String when) {
    return 'Ktoś odzyskuje @$name na innym telefonie przez e-mail. Nazwa przejdzie $when, chyba że anulujesz.';
  }

  @override
  String get cubeIdRecoveryCancel => 'Anuluj odzyskiwanie';

  @override
  String get cubeIdRecoveryCancelled => 'Odzyskiwanie anulowane';

  @override
  String get cubeIdRelease => 'Zwolnij';

  @override
  String cubeIdReleaseConfirm(String name) {
    return 'Zwolnić @$name? Każdy będzie mógł ją zająć.';
  }

  @override
  String get cubeIdShare => 'Udostępnij';

  @override
  String cubeIdShareText(String name) {
    return 'Znajdź mnie w cubechat: @$name\nhttps://cubechat.tech/u.html#$name';
  }

  @override
  String get cubeIdFailed => 'Nie udało się zapisać nazwy. Spróbuj ponownie.';

  @override
  String get cubeIdOffline => 'Brak internetu';

  @override
  String get lookupNotFound => 'Nikt nie ma takiej @nazwy';

  @override
  String searchFindCubeName(String name) {
    return 'Znajdź @$name';
  }

  @override
  String get searchFindCubeNameHint => 'Wyszukaj w Cube ID i dodaj';

  @override
  String get addContactHintName => 'Wklej wizytówkę lub wpisz @nazwę';

  @override
  String get strangerReachTitle => 'Kto może pisać do mnie z internetu';

  @override
  String get strangerReachAll => 'Wszyscy';

  @override
  String get strangerReachRequest => 'Przez prośbę';

  @override
  String get strangerReachNone => 'Nikt';

  @override
  String get strangerReachHint =>
      'Dotyczy osób spoza twoich rozmów, które piszą przez internet. Nie dotyczy osób w pobliżu przez Bluetooth.';

  @override
  String get sectionPrivacy => 'Prywatność i bezpieczeństwo';

  @override
  String get sectionNotifications => 'Powiadomienia i połączenia';

  @override
  String get sectionConnection => 'Łączność';

  @override
  String get sectionChats => 'Czaty i multimedia';

  @override
  String get sectionAppearance => 'Wygląd';

  @override
  String get sectionData => 'Dane i pamięć';

  @override
  String get sectionAbout => 'O aplikacji';

  @override
  String get subWhoSeesMe => 'Kto mnie widzi';

  @override
  String get subProtection => 'Ochrona';

  @override
  String get subNotifications => 'Powiadomienia';

  @override
  String get subCalls => 'Połączenia';

  @override
  String get profileDiscoverableMeshOff =>
      'Bluetooth mesh jest wyłączony — włącz go w sekcji Łączność.';

  @override
  String get chatRouteBluetoothDirect => 'Bluetooth, bezpośrednio';

  @override
  String chatRouteMeshHops(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Mesh · $n przeskoku',
      many: 'Mesh · $n przeskoków',
      few: 'Mesh · $n przeskoki',
      one: 'Mesh · $n przeskok',
    );
    return '$_temp0';
  }

  @override
  String chatRouteDeliveredVia(String route) {
    return 'Dostarczono: $route';
  }

  @override
  String chatRouteReceivedVia(String route) {
    return 'Odebrano: $route';
  }

  @override
  String get chatUnreadDivider => 'Nowe wiadomości';

  @override
  String get radioTitle => 'Krótkofalówka';

  @override
  String get radioNearbySubtitle =>
      'Przytrzymaj przycisk i mów do grupy lub kontaktu';

  @override
  String get radioGroupsLabel => 'Grupy';

  @override
  String get radioDirectLabel => 'Prywatne';

  @override
  String get radioAddGroup => 'Dodaj krótkofalówkę';

  @override
  String get radioNoGroups =>
      'Brak krótkofalówek. Dodaj jedną — wszyscy, którzy wpiszą tę samą nazwę i hasło, słyszą się nawzajem.';

  @override
  String get radioLeave => 'Opuść tę krótkofalówkę';

  @override
  String get radioPickChannel => 'Wybierz grupę lub kontakt';

  @override
  String get radioPushToTalk => 'Przytrzymaj, aby mówić';

  @override
  String get radioTalking => 'Mów…';

  @override
  String get radioChannelBusy => 'Kanał zajęty';

  @override
  String radioSpeaker(String name) {
    return 'Mówi: $name';
  }

  @override
  String get radioSilentTitle => 'Mów w trybie cichym';

  @override
  String get radioSilentHint =>
      'Głos jest odtwarzany nawet wtedy, gdy telefon jest wyciszony.';

  @override
  String get radioJoinNameLabel => 'Nazwa';

  @override
  String get radioJoinPasswordLabel => 'Hasło (opcjonalnie)';

  @override
  String get radioJoinHint =>
      'Wszyscy, którzy wpiszą tę samą nazwę i hasło, są na tej samej krótkofalówce. Żaden serwer nie przechowuje ich listy.';

  @override
  String get radioJoinNameRequired => 'Wpisz nazwę';

  @override
  String get radioJoinSubmit => 'Dodaj';

  @override
  String get radioBlockedTooLong => 'Przerwano po minucie mówienia';

  @override
  String get radioBlockedCall => 'Trwa połączenie';

  @override
  String get radioBlockedMicrophone => 'Brak dostępu do mikrofonu';

  @override
  String get radioBlockedUnavailable =>
      'Krótkofalówka jest niedostępna na tym urządzeniu';

  @override
  String get radioBlockedNoChannel => 'Najpierw wybierz grupę lub kontakt';

  @override
  String get radioTurnOff => 'Wyłącz krótkofalówkę';

  @override
  String get radioPersonalCallsTitle => 'Odbieraj wywołania prywatne';

  @override
  String get radioPersonalCallsHint =>
      'Gdy krótkofalówka jest wyłączona, kontakt, który do ciebie mówi, sam ją do siebie dostraja.';

  @override
  String get radioBackgroundHint =>
      'Przy wyłączonym ekranie krótkofalówkę słychać tylko wtedy, gdy włączona jest praca w tle.';

  @override
  String get areaNearby => 'Czat okolicy';

  @override
  String get areaLevelDistrict => 'Dzielnica';

  @override
  String get areaLevelCity => 'Miasto';

  @override
  String get areaLevelRegion => 'Region';

  @override
  String areaPresentCount(int count) {
    return '≈$count tutaj';
  }

  @override
  String get areaPresentMany => '50+ tutaj';

  @override
  String get areaBlockViaBluetooth => 'Twoja okolica — przez Bluetooth';

  @override
  String get areaOpenNearbyTab => 'Otwórz W pobliżu';

  @override
  String get areaLocating => 'Szukanie twojej dzielnicy…';

  @override
  String get areaNoPlace =>
      'Brak lokalizacji. Czat okolicy potrzebuje twojej przybliżonej lokalizacji, gdy ten ekran jest otwarty.';

  @override
  String get areaLocationDenied =>
      'Lokalizacja jest wyłączona dla Cubechat. Zezwól na przybliżoną lokalizację w Ustawieniach, aby zobaczyć swoją dzielnicę.';

  @override
  String get areaOffline => 'Brak połączenia z czatem okolicy';

  @override
  String get areaEmpty => 'Nikt tu nie pisał w ciągu ostatnich 24 godzin.';

  @override
  String get areaConsentTitle => 'Czat okolicy jest publiczny';

  @override
  String get areaConsentBody =>
      'Wiadomości tutaj są publiczne. Przeczyta je każdy, kto otworzy twoją dzielnicę lub miasto, a serwer Cubechat przechowuje je przez 24 godziny. Piszesz pod tymczasową nazwą, która zmienia się co kilka godzin; nikt nie widzi twojej @nazwy ani twoich kontaktów. Aby znać twoją dzielnicę, Cubechat prosi o przybliżoną lokalizację, tylko gdy ten ekran jest otwarty.';

  @override
  String get areaConsentAllow => 'Kontynuuj';

  @override
  String get areaConsentDecline => 'Nie teraz';

  @override
  String areaDefaultName(String tag) {
    return 'Kostka-$tag';
  }

  @override
  String areaYouAre(String name, int hours) {
    return 'Jesteś $name · nowa nazwa za $hours godz.';
  }

  @override
  String get areaNewName => 'Nowa nazwa';

  @override
  String get areaSetName => 'Wybierz nazwę';

  @override
  String get areaNameHint =>
      'Tylko na kilka godzin tej nazwy. Zostaw puste, aby użyć automatycznej.';

  @override
  String get areaNameSameWarning =>
      'Ta sama nazwa łączy cię między dzielnicami';

  @override
  String get areaShowPresence => 'Pokazuj, że tu jestem';

  @override
  String get areaPresenceOffHint =>
      'Włącz „Pokazuj, że tu jestem”, aby widzieć, ile osób jest w pobliżu';

  @override
  String get areaReadOnly => 'Pisać możesz tylko tam, gdzie jesteś';

  @override
  String get areaComposerHint => 'Wiadomość do wszystkich tutaj';

  @override
  String get areaSend => 'Wyślij';

  @override
  String get areaWaitALittle => 'Poczekaj chwilę';

  @override
  String areaFlood(int count) {
    return 'Flood ($count) · Pokaż';
  }

  @override
  String get areaReply => 'Odpowiedz';

  @override
  String get areaHide => 'Ukryj';

  @override
  String get areaBlock => 'Zablokuj do zmiany nazwy';

  @override
  String get areaBlocked => 'Zablokowano do zmiany nazwy';

  @override
  String get areaReport => 'Zgłoś';

  @override
  String get areaOpenLink => 'Otwórz link';

  @override
  String areaOpenLinkConfirm(String url) {
    return 'Otworzyć $url?';
  }

  @override
  String get areaOpen => 'Otwórz';

  @override
  String get areaReadHere => 'Czytaj tutaj';

  @override
  String get areaReadHereHint =>
      'Tylko odczyt. Pisać możesz tylko tam, gdzie jesteś; przekaźnik dowie się, które miejsce czytasz.';

  @override
  String get areaNotes => 'Notatki';

  @override
  String areaNotesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count notatki',
      many: '$count notatek',
      few: '$count notatki',
      one: '$count notatka',
      zero: 'Brak notatek',
    );
    return '$_temp0';
  }

  @override
  String get areaLeaveNote => 'Zostaw notatkę';

  @override
  String get areaNoteHint => 'Krótka notatka dla twojego miasta';

  @override
  String get areaNoteLifetime => 'Ważna przez';

  @override
  String get areaNote1h => '1 godz.';

  @override
  String get areaNote24h => '24 godz.';

  @override
  String get areaNote7d => '7 dni';

  @override
  String get areaPinToDistrict => 'Przypnij do dzielnicy';

  @override
  String get areaPinHint =>
      'Dotknij mapy w obrębie swojego miasta; pinezka przyciągnie się do dzielnicy.';

  @override
  String get areaPinOutside => 'Tylko w obrębie twojego miasta';

  @override
  String get areaNoteDelete => 'Usuń moją notatkę';

  @override
  String get areaNoNotes => 'Nie ma tu jeszcze notatek';

  @override
  String get areaNotesLimit => 'Trzy notatki dziennie';

  @override
  String get areaNoteLeft => 'Zostawiono notatkę';

  @override
  String get areaNoteSend => 'Zostaw';

  @override
  String get areaOwnNote => 'Twoja notatka';

  @override
  String get areaNotePinned => 'Przypięta do dzielnicy';

  @override
  String get areaHidden => 'Ukryte';

  @override
  String get areaPublicBadge => 'Publiczne · 24 godz.';

  @override
  String get areaSettingTitle => 'Czat okolicy';

  @override
  String get areaSettingOnHint =>
      'Przycisk czatu okolicy na mapie: publiczne czaty twojej dzielnicy i miasta, pod tymczasową nazwą.';

  @override
  String get areaSettingOffHint =>
      'Wyłączone: brak przycisku na mapie, a czat okolicy nigdy nie prosi o lokalizację ani się nie łączy.';

  @override
  String get wallpaperPhotoLocalOnly =>
      'Tapety ze zdjęć na razie działają tylko lokalnie';

  @override
  String get wallpaperSavedNoRoute =>
      'Zapisano tutaj. Teraz nie ma trasy do rozmówcy';

  @override
  String get wallpaperScopeTitle => 'Kto ma widzieć tę tapetę?';

  @override
  String get wallpaperScopeChannel => 'Cały kanał';

  @override
  String get wallpaperScopeBoth => 'Ja i rozmówca';

  @override
  String get wallpaperScopeLocal => 'Tylko u mnie';

  @override
  String get wallpaperScopeSharedHint =>
      'Wysyłane jako zaszyfrowany pakiet sterujący';

  @override
  String get wallpaperScopePhotoHint =>
      'Zdjęcia na razie zostają tylko na tym telefonie';

  @override
  String get foldersCreate => 'Utwórz folder';

  @override
  String get foldersYours => 'Twoje foldery';

  @override
  String get foldersSmartFilters => 'Inteligentne filtry';

  @override
  String get foldersName => 'Nazwa folderu';

  @override
  String get foldersSave => 'Zapisz';

  @override
  String get foldersDeleteTitle => 'Usunąć folder?';

  @override
  String get foldersDelete => 'Usuń';

  @override
  String get foldersCreateAction => 'Utwórz';

  @override
  String get chatsArchiveHiddenToast =>
      'Archiwum ukryte. Przywrócisz je w sekcji „Wygląd”.';

  @override
  String get chatsBulkPin => 'Przypnij';

  @override
  String get chatsBulkMute => 'Wycisz';

  @override
  String get chatsUnarchive => 'Przywróć z archiwum';

  @override
  String get chatsAddToFolder => 'Dodaj do folderu';

  @override
  String get chatsMarkUnread => 'Oznacz jako nieprzeczytane';

  @override
  String get chatsClearHistory => 'Wyczyść historię czatu';

  @override
  String get foldersNew => 'Nowy folder';

  @override
  String get foldersNameHint => 'Znajomi';

  @override
  String get chatsNoIncoming => 'Brak wiadomości przychodzących';

  @override
  String get chatsMarkedUnread => 'Oznaczono jako nieprzeczytane';

  @override
  String get chatsClearHistoryTitle => 'Wyczyścić historię czatu?';

  @override
  String get chatsClearHistoryBody =>
      'Wiadomości zostaną usunięte tylko na tym urządzeniu. Czat, kontakt i ulubione zostaną.';

  @override
  String get chatsClearHistoryAction => 'Wyczyść';

  @override
  String get chatsHistoryCleared => 'Historia wyczyszczona';

  @override
  String get savedTagMenuTag => 'Tag';

  @override
  String get savedTagRemove => 'Usuń tag';

  @override
  String get customizeArchiveRowTitle => 'Wiersz archiwum';

  @override
  String get customizeArchiveRowHint =>
      'Pokazuj nad listą czatów. Zarchiwizowane czaty i tak odbierają wiadomości.';

  @override
  String get mapLayerStandard => 'Standardowa';

  @override
  String get mapLayerStandardHint => 'Jasna mapa ulic — najstabilniejsza opcja';

  @override
  String get callYourMicOff => 'Twój mikrofon jest wyłączony';

  @override
  String callTheirCameraOff(String name) {
    return '$name ma wyłączoną kamerę';
  }
}
