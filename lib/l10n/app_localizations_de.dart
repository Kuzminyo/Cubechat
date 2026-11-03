// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get callVoice => 'Sprachanruf';

  @override
  String get callVideo => 'Videoanruf';

  @override
  String get callIncomingVideo => 'Eingehender Videoanruf';

  @override
  String get callCamera => 'Kamera';

  @override
  String get callFlipCamera => 'Wechseln';

  @override
  String get contactProfileVideo => 'Video';

  @override
  String get callPreparing => 'Mikrofon wird vorbereitet…';

  @override
  String get callDialing => 'Wird angerufen…';

  @override
  String get callRinging => 'Klingelt…';

  @override
  String get callConnecting => 'Verbinden…';

  @override
  String get callMicrophoneRequired =>
      'Erlaube den Mikrofonzugriff in den Systemeinstellungen, um Anrufe zu tätigen.';

  @override
  String get callMicrophoneWindows =>
      'Windows hat CubeChat keinen Mikrofonzugriff gegeben. Aktiviere Einstellungen → Datenschutz und Sicherheit → Mikrofon → „Desktop-Apps Zugriff auf das Mikrofon erlauben“.';

  @override
  String get callElsewhere =>
      'Auf einem anderen Gerät dieses Kontos läuft bereits ein Anruf.';

  @override
  String get callRelayUnavailable =>
      'Anrufserver nicht erreichbar. Bitte versuche es später erneut.';

  @override
  String get callBusy => 'Besetzt';

  @override
  String get callNoAnswer => 'Keine Antwort';

  @override
  String get callFailed => 'Anruf konnte nicht verbunden werden';

  @override
  String get callDeclined => 'Anruf abgelehnt';

  @override
  String get callEnded => 'Anruf beendet';

  @override
  String get callMicrophone => 'Mikrofon';

  @override
  String get callSpeaker => 'Lautsprecher';

  @override
  String get callAnswer => 'Annehmen';

  @override
  String get callDecline => 'Ablehnen';

  @override
  String get callEnd => 'Auflegen';

  @override
  String get callClose => 'Schließen';

  @override
  String get callMinimize => 'Minimieren';

  @override
  String get callAudioOutput => 'Anrufaudio';

  @override
  String get callRoutePhone => 'Telefon';

  @override
  String get callRouteBluetooth => 'Bluetooth';

  @override
  String get callRouteHeadphones => 'Kopfhörer';

  @override
  String get callFullScreenTitle => 'Anrufe auf dem Sperrbildschirm';

  @override
  String get callFullScreenBody =>
      'Erlaube, dass eingehende Anrufe auf dem Sperrbildschirm angezeigt werden, damit du sie ohne Entsperren annehmen kannst.';

  @override
  String get callFullScreenXiaomi =>
      'Xiaomi, Redmi und Poco lassen Apps das nicht selbst aktivieren: Schalte „Auf Sperrbildschirm anzeigen“ unter Weitere Berechtigungen ein.';

  @override
  String get circleMessage => 'Videonachricht';

  @override
  String get appName => 'Cubechat';

  @override
  String get navChats => 'Chats';

  @override
  String get navPeers => 'Umgebung';

  @override
  String get navProfile => 'Profil';

  @override
  String get navContacts => 'Kontakte';

  @override
  String get navMap => 'Karte';

  @override
  String get mapTitle => 'Karte';

  @override
  String get mapFriendsTitle => 'Personen auf der Karte';

  @override
  String get mapFriendsHint => 'Nur diese Kontakte erhalten deinen Standort';

  @override
  String mapClusterTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Personen hier',
      one: '$count Person hier',
    );
    return '$_temp0';
  }

  @override
  String get mapClusterHint => 'Tippe auf jemanden, um zu ihm zu springen';

  @override
  String get mapNorthUp => 'Norden nach oben';

  @override
  String get mapLayerTitle => 'Kartenstil';

  @override
  String get mapLayerHint => 'Worauf die Pins gezeichnet werden';

  @override
  String get mapLayerDark => 'Dunkel';

  @override
  String get mapLayerDarkHint =>
      'Straßen ohne Beschriftung — am ruhigsten unter den Pins';

  @override
  String get mapLayerSatellite => 'Satellit';

  @override
  String get mapLayerSatelliteHint =>
      'Luftbilder: welches Gebäude, welcher Hof';

  @override
  String get mapLayerTerrain => 'Gelände';

  @override
  String get mapLayerTerrainHint =>
      'Höhenlinien und Relief, für Hügel und Wege';

  @override
  String get mapFriendsEmpty => 'Noch teilt niemand die Karte mit dir.';

  @override
  String get mapFriendsEmptyHint =>
      'Lade einen Kontakt ein – er erscheint hier, sobald er annimmt.';

  @override
  String get mapFriendsInvite => 'Einladen';

  @override
  String get mapFriendsRemove => 'Von Karte entfernen';

  @override
  String mapFriendsRemoved(String name) {
    return '$name teilt die Karte nicht mehr mit dir';
  }

  @override
  String get mapFriendsLive => 'Jetzt auf der Karte';

  @override
  String get mapFriendsIdle => 'Gerade kein Standort';

  @override
  String get mapInviteTitle => 'Zur Karte einladen';

  @override
  String get mapInviteHint => 'Wähle einen oder mehrere Chats';

  @override
  String get mapInviteEmpty => 'Noch keine Chats zum Einladen.';

  @override
  String mapInviteAction(int count) {
    return 'Senden ($count)';
  }

  @override
  String get mapInviteMessage =>
      'Einladung zur Cubechat-Karte. Teile deinen Standort in diesem Chat, um auf der Karte zu erscheinen.';

  @override
  String mapInviteSent(int count) {
    return 'Einladungen gesendet: $count';
  }

  @override
  String get mapInviteFailed => 'Einladungen konnten nicht gesendet werden';

  @override
  String mapPeopleVisible(int count) {
    return 'Geteilte Standorte: $count';
  }

  @override
  String get mapCenterMe => 'Auf mich zentrieren';

  @override
  String get mapNoSharedLocations => 'Noch keine geteilten Standorte';

  @override
  String get mapNoSharedLocationsHint =>
      'Ein Kontakt erscheint hier, nachdem er einen Standort im Chat gesendet hat.';

  @override
  String get mapWebHintTitle => 'Verbindungen in der Nähe';

  @override
  String get mapWebHint =>
      'Linien zeigen die Nähe, nicht den Weg der Nachrichten.';

  @override
  String get mapOpenProfile => 'Profil';

  @override
  String get mapLocationPrivacyOff => 'Standort auf Karte verborgen';

  @override
  String get mapLocationPrivacyOffHint =>
      'Aktiviere „Mich auf der Karte zeigen“ unter Datenschutz, um deinen Pin anzuzeigen.';

  @override
  String get mapYouOnMap => 'Dein Standort ist auf diesem Gerät sichtbar';

  @override
  String get locationSharingDisabled =>
      'Aktiviere zuerst „Mich auf der Karte zeigen“ unter Datenschutz.';

  @override
  String get mapLocationDenied => 'Standortzugriff ist deaktiviert';

  @override
  String get mapLocationServiceOff =>
      'Aktiviere die Ortungsdienste, um dich anzuzeigen';

  @override
  String get mapLocationUnavailable =>
      'Dein Standort konnte nicht ermittelt werden';

  @override
  String get mapDistanceUnknown => 'Entfernung unbekannt';

  @override
  String mapDistanceMetres(int metres) {
    return '$metres m entfernt';
  }

  @override
  String mapDistanceKilometres(String kilometres) {
    return '$kilometres km entfernt';
  }

  @override
  String get mapUpdatedNow => 'gerade geteilt';

  @override
  String mapUpdatedMinutes(int minutes) {
    return 'vor $minutes Min. geteilt';
  }

  @override
  String mapUpdatedHours(int hours) {
    return 'vor $hours Std. geteilt';
  }

  @override
  String get contactsTitle => 'Kontakte';

  @override
  String get contactsSubtitle => 'Alle, denen du geschrieben hast';

  @override
  String get contactsSearchHint => 'Kontakte suchen…';

  @override
  String get contactsEmptyTitle => 'Noch keine Kontakte';

  @override
  String get contactsEmptyHint =>
      'Beginne eine Unterhaltung und die Person erscheint hier.';

  @override
  String get contactsSearchEmpty => 'Keine passenden Kontakte';

  @override
  String get contactsTabContacts => 'Kontakte';

  @override
  String get contactsTabCalls => 'Anrufe';

  @override
  String get callsFilterAll => 'Alle';

  @override
  String get callsFilterMissed => 'Verpasst';

  @override
  String get callsEmptyTitle => 'Noch keine Anrufe';

  @override
  String get callsEmptyHint =>
      'Eingehende, ausgehende und verpasste Anrufe erscheinen hier.';

  @override
  String get callsMissedEmpty => 'Keine verpassten Anrufe';

  @override
  String get callsCallBack => 'Anrufen';

  @override
  String get contactProfileChat => 'Chat';

  @override
  String get contactProfileCall => 'Anrufen';

  @override
  String get contactProfileRadio => 'Funk';

  @override
  String get contactProfileSecurity => 'Sicherheit';

  @override
  String get contactProfileActions => 'Kontaktaktionen';

  @override
  String get contactProfileVerify => 'Verifizieren';

  @override
  String get contactProfileCopyId => 'Kontakt-ID kopieren';

  @override
  String get contactProfileIdCopied => 'Kontakt-ID kopiert';

  @override
  String get contactProfileId => 'Kontakt-ID';

  @override
  String get contactProfileVerifyHint =>
      'Vergleiche die Schlüssel-Fingerabdrücke, um diese Person zu bestätigen.';

  @override
  String get chatsTitle => 'Chats';

  @override
  String get chatsSubtitle => 'Mesh · Ende-zu-Ende-verschlüsselt';

  @override
  String get chatsEmptyTitle => 'Noch keine Unterhaltungen';

  @override
  String get chatsEmptyHint =>
      'Öffne im Tab „In der Nähe“ eine Person, um zu chatten.';

  @override
  String get chatsFilterAll => 'Alle';

  @override
  String get chatsFilterUnread => 'Ungelesen';

  @override
  String get chatsFilterMesh => 'Mesh';

  @override
  String get chatsFilterFavorites => 'Favoriten';

  @override
  String get chatsFolderDirect => 'Direkt';

  @override
  String get chatsFolderChannels => 'Kanäle';

  @override
  String get chatsFolderOnline => 'Erreichbar';

  @override
  String get chatsFoldersTitle => 'Ordner';

  @override
  String get chatsFoldersHint =>
      'Ordner sind Ausschnitte dieser Liste, keine Orte, an die Chats verschoben werden. Aktiviere die, die du über den Chats sehen willst.';

  @override
  String get chatsSearchHint => 'Chats suchen…';

  @override
  String get chatsStatusViaMesh => 'über Mesh';

  @override
  String get chatsStatusOffline => 'offline';

  @override
  String get peerKeyRotated => 'Schlüssel geändert — erneut verifizieren';

  @override
  String get peersTitle => 'In der Nähe';

  @override
  String get peersSubtitle => 'Geräte in Bluetooth-Reichweite';

  @override
  String get peersEmpty => 'Suche nach Geräten…';

  @override
  String peersHopsOne(int n) {
    return '$n Hop entfernt';
  }

  @override
  String peersHopsOther(int n) {
    return '$n Hops entfernt';
  }

  @override
  String get blePermissionTitle => 'Bluetooth-Berechtigung nötig';

  @override
  String get blePermissionHint =>
      'Cubechat braucht Bluetooth, um Geräte zu finden und Nachrichten zu senden — ganz ohne Internet.';

  @override
  String get blePermissionGrant => 'Erlauben';

  @override
  String get blePermissionOpenSettings => 'Einstellungen öffnen';

  @override
  String get blePermissionDeniedHint =>
      'Berechtigung verweigert. Öffne die Einstellungen, um Bluetooth-Zugriff zu erlauben.';

  @override
  String get bleAdapterOffTitle => 'Bluetooth ist aus';

  @override
  String get bleAdapterOffHint =>
      'Schalte Bluetooth ein, um Geräte in der Nähe zu sehen.';

  @override
  String get bleUnsupportedTitle => 'Bluetooth LE nicht verfügbar';

  @override
  String get bleUnsupportedHint =>
      'Dieses Gerät oder diese Plattform bietet kein Bluetooth Low Energy. Probiere es auf einem Smartphone.';

  @override
  String get bleScanning => 'Suche…';

  @override
  String get bleRetry => 'Wiederholen';

  @override
  String get bleEnable => 'Einschalten';

  @override
  String get bleConnectFailed =>
      'Verbindung fehlgeschlagen. Das Gerät ist vielleicht außer Reichweite oder seine Bluetooth-Adresse hat sich geändert.';

  @override
  String get bleSignal => 'Signal';

  @override
  String get bleConnect => 'Verbinden';

  @override
  String get bleConnected => 'Verbunden';

  @override
  String get bleVerified => 'Verifiziert';

  @override
  String get editorAdjustBrightness => 'Helligkeit';

  @override
  String get editorAdjustContrast => 'Kontrast';

  @override
  String get editorAdjustSaturation => 'Sättigung';

  @override
  String get editorToolCrop => 'Zuschneiden';

  @override
  String get editorToolDraw => 'Zeichnen';

  @override
  String get editorToolAdjust => 'Anpassen';

  @override
  String get editorTabSticker => 'Sticker';

  @override
  String get editorTabText => 'Text';

  @override
  String get editorPenPen => 'Stift';

  @override
  String get editorPenMarker => 'Marker';

  @override
  String get editorPenNeon => 'Neon';

  @override
  String get editorPenArrow => 'Pfeil';

  @override
  String get editorPenBlur => 'Weichzeichnen';

  @override
  String get editorPenEraser => 'Radierer';

  @override
  String get editorLevel => 'Ausrichten';

  @override
  String get editorTextHint => 'Text auf dem Foto';

  @override
  String get editorCropFree => 'Frei';

  @override
  String get editorRemove => 'Entfernen';

  @override
  String get notificationUnknownSender => 'Neue Nachricht';

  @override
  String get bleUnknownPeer => 'Unbekanntes Gerät';

  @override
  String get bleBroadcasting => 'Sendet';

  @override
  String bleConnectedCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n Centrals verbunden',
      one: '1 Central verbunden',
      zero: 'Keine Centrals',
    );
    return '$_temp0';
  }

  @override
  String get verifyTitle => 'Kontakt verifizieren';

  @override
  String get verifyIntro =>
      'Vergleiche diese beiden Fingerabdrücke mit deinem Gegenüber persönlich oder in einem Sprachanruf. Stimmen sie auf beiden Seiten überein, ist bestätigt, dass der Noise-Handshake nicht manipuliert wurde.';

  @override
  String get verifyMine => 'DEIN FINGERABDRUCK';

  @override
  String verifyTheirs(String name) {
    return 'FINGERABDRUCK VON $name';
  }

  @override
  String get verifyMarkAsVerified => 'Als verifiziert markieren';

  @override
  String get verifyAlreadyDone => 'Dieser Kontakt ist verifiziert.';

  @override
  String get verifyRevoke => 'Widerrufen';

  @override
  String verifyDoneSnack(String name) {
    return '$name als verifiziert markiert';
  }

  @override
  String get chatInputHint => 'Nachricht';

  @override
  String get chatSend => 'Senden';

  @override
  String get chatToday => 'Heute';

  @override
  String get chatYesterday => 'Gestern';

  @override
  String get chatDelivered => 'Zugestellt';

  @override
  String get chatRead => 'Gelesen';

  @override
  String get chatSending => 'Wird gesendet';

  @override
  String get chatWaitingForConnection => 'Wartet auf Verbindung';

  @override
  String sendQueueCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Nachrichten warten auf Verbindung',
      one: '1 Nachricht wartet auf Verbindung',
    );
    return '$_temp0';
  }

  @override
  String sendQueueSlowNetwork(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Langsames Netz — $count Nachrichten werden gesendet',
      one: 'Langsames Netz — 1 Nachricht wird gesendet',
    );
    return '$_temp0';
  }

  @override
  String get sendQueueTitle => 'Warten auf Versand';

  @override
  String get sendQueueHint =>
      'Sie gehen von selbst raus, sobald es einen Weg gibt — Bluetooth in der Nähe oder Internet. Du musst nichts drücken.';

  @override
  String get sendQueueRetry => 'Jetzt versuchen';

  @override
  String get sendQueueCancel => 'Senden abbrechen';

  @override
  String get sendQueueCancelled => 'Nicht gesendet — zurückgenommen';

  @override
  String get sendQueueTooLate =>
      'Zu spät zum Zurücknehmen: Sie ist schon unterwegs';

  @override
  String get chatEncryptedNotice =>
      'Nachrichten sind mit dem Noise-Protokoll Ende-zu-Ende-verschlüsselt.';

  @override
  String get chatSessionHandshaking => 'Sicherer Kanal wird aufgebaut…';

  @override
  String get chatSessionEstablished => 'Gesichert · Noise XX';

  @override
  String get chatSessionFailed => 'Verbindung fehlgeschlagen';

  @override
  String get presenceOnline => 'online';

  @override
  String get presenceOffline => 'offline';

  @override
  String get chatSessionFingerprintPending =>
      'Der Fingerabdruck erscheint, sobald der Handshake abgeschlossen ist.';

  @override
  String get chatEmptyEstablished =>
      'Der sichere Kanal steht. Sende eine Nachricht, um die Unterhaltung zu beginnen.';

  @override
  String get chatEmptyHandshaking =>
      'Warte, bis die Gegenseite den Handshake abschließt…';

  @override
  String get chatEmptyTitle => 'Hier gibt es noch keine Nachrichten';

  @override
  String get chatEmptyGreetHint =>
      'Schreib eine Nachricht oder tippe auf Kubi, um Hallo zu sagen.';

  @override
  String get profileTitle => 'Profil';

  @override
  String get profileNickname => 'Spitzname';

  @override
  String get profileNicknameEditTitle => 'Spitzname festlegen';

  @override
  String get profileNicknameHint => 'So sehen dich andere im Mesh';

  @override
  String get profileNicknameSave => 'Speichern';

  @override
  String get profileFingerprint => 'Fingerabdruck des öffentlichen Schlüssels';

  @override
  String get profileLanguage => 'Sprache';

  @override
  String get profileLanguageEn => 'Englisch';

  @override
  String get profileLanguageUk => 'Ukrainisch';

  @override
  String get profileTransport => 'Transport';

  @override
  String get profileTransportMesh => 'Bluetooth-Mesh';

  @override
  String get profileBackground => 'Im Hintergrund erreichbar';

  @override
  String get profileBackgroundSubtitle =>
      'Nachrichten auch bei geschlossener App empfangen';

  @override
  String get profileBatteryExempt => 'Akkuoptimierung deaktivieren';

  @override
  String get profileAbout => 'Über';

  @override
  String profileVersion(String v) {
    return 'Version $v';
  }

  @override
  String get rotateKeysTitle => 'Kontoschlüssel ändern';

  @override
  String get rotateKeysHint =>
      'Falls ein Gerät mit deinem Konto verloren oder gestohlen wurde';

  @override
  String get rotateKeysConfirmTitle => 'Kontoschlüssel ändern?';

  @override
  String get rotateKeysConfirmBody =>
      'Deine Kontakte erhalten deine neuen Schlüssel und behalten eure Chats, werden aber gebeten, deine Schlüssel erneut zu prüfen. Alle anderen Geräte deines Kontos werden abgemeldet; verknüpfe die, die du behältst, erneut von diesem Telefon aus. Kontakte mit einer älteren CubeChat-Version erreichen dich erst nach einem Update. Kanäle behalten ihre Schlüssel.';

  @override
  String get rotateKeysConfirmAction => 'Schlüssel ändern';

  @override
  String get rotateKeysWorking => 'Schlüssel werden geändert…';

  @override
  String rotateKeysDone(int sent, int total) {
    return 'Neue Schlüssel. $sent von $total Kontakten benachrichtigt';
  }

  @override
  String get rotateKeysSlow =>
      'Neue Schlüssel. Nicht alle Kontakte haben rechtzeitig bestätigt; die Relays heben es für sie auf';

  @override
  String get profileEmergencyWipe => 'Notfall-Löschung';

  @override
  String get profileEmergencyWipeConfirm => 'Alles löschen?';

  @override
  String get profileEmergencyWipeConfirmHint =>
      'Deine Identität, Kontaktliste und dein Chatverlauf werden entfernt. Das kann nicht rückgängig gemacht werden.';

  @override
  String get profileEmergencyWipeAction => 'Löschen';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get copy => 'Kopieren';

  @override
  String get copied => 'Kopiert';

  @override
  String get channelsNewTitle => 'Neuer Kanal';

  @override
  String get channelsNewTooltip => 'Neuer Kanal';

  @override
  String get channelNameLabel => 'Kanalname';

  @override
  String get channelPasswordLabel => 'Passwort (optional)';

  @override
  String get channelJoinAction => 'Beitreten';

  @override
  String get channelNameHint =>
      'Wer denselben Namen und dasselbe Passwort eingibt, landet im selben Raum. Kein Server führt eine Liste davon.';

  @override
  String get channelPasswordHint =>
      'Das Passwort ist der Schlüssel. Ohne Passwort ist der Raum für alle in der Nähe offen, die seinen Namen kennen.';

  @override
  String get channelSubtitle => 'Gruppenkanal · gemeinsamer Schlüssel';

  @override
  String get channelMute => 'Stummschalten';

  @override
  String get channelUnmute => 'Ton an';

  @override
  String channelMutedUntil(String time) {
    return 'Stumm bis $time';
  }

  @override
  String get channelMuteFor => 'Stumm für…';

  @override
  String channelMuteMinutes(int minutes) {
    return '$minutes Minuten';
  }

  @override
  String channelMuteHours(int hours) {
    return '$hours Stunden';
  }

  @override
  String channelMuteDays(int days) {
    return '$days Tage';
  }

  @override
  String get channelMuteForever => 'Bis ich es wieder einschalte';

  @override
  String get channelCommunity => 'Kommentare';

  @override
  String get channelCommunityOpen => 'Diskussion öffnen';

  @override
  String channelCommunitySubtitle(String channel) {
    return 'Diskussion zu $channel';
  }

  @override
  String get channelBackToChannel => 'Zurück zum Kanal';

  @override
  String get channelMemberActions => 'Mitglied';

  @override
  String get channelRemoveMember => 'Aus dem Kanal entfernen';

  @override
  String get channelRemoveMemberHint =>
      'Ihre Beiträge werden hier nicht mehr angenommen. Nichts hindert sie daran, über den Namen wieder beizutreten — ein gemeinsamer Schlüssel ist die einzige Mitgliedschaft, die es gibt.';

  @override
  String get channelMuteMember => 'Stumm für…';

  @override
  String get channelUnmuteMember => 'Wieder schreiben lassen';

  @override
  String channelMemberRemoved(String name) {
    return '$name wurde entfernt';
  }

  @override
  String channelMemberMuted(String name) {
    return '$name wurde stummgeschaltet';
  }

  @override
  String channelMemberCleared(String name) {
    return '$name kann wieder schreiben';
  }

  @override
  String get channelMemberMutedNote => 'Stumm';

  @override
  String get channelShareHistory => 'Verlauf teilen';

  @override
  String get channelShareHistoryHint =>
      'Sendet die letzten Beiträge dieses Raums erneut, damit später Beigetretene sie sehen. Wer schon hier war, bekommt nichts Neues.';

  @override
  String channelHistoryShared(int count) {
    return 'Angebotene Beiträge: $count';
  }

  @override
  String get channelHistoryNothing => 'Noch nichts zu teilen';

  @override
  String get channelHistoryAuto => 'Neuen Mitgliedern den Verlauf geben';

  @override
  String get channelHistoryAutoHint =>
      'Taucht jemand Neues im Raum auf, gehen die letzten Beiträge automatisch an ihn. Vorerst nur Text — Fotos sind gestückelte Streams und lassen sich nicht erneut senden, ohne sie für alle zu verdoppeln.';

  @override
  String get channelPostComments => 'Kommentare';

  @override
  String get channelNoComments => 'Dazu wurde noch nichts gesagt';

  @override
  String get channelCommentHint => 'Kommentar';

  @override
  String get channelMuteCustom => 'Wie lange?';

  @override
  String get channelMuteCustomHint => 'Stunden';

  @override
  String get chatPinnedManage => 'Angeheftet';

  @override
  String get chatPeekOpen => 'Chat öffnen';

  @override
  String get chatPeekPin => 'Anheften';

  @override
  String get chatPeekUnpin => 'Loslösen';

  @override
  String get chatPeekUnmute => 'Ton an';

  @override
  String get chatPeekMarkRead => 'Als gelesen markieren';

  @override
  String get chatDeleteForMeHint =>
      'Von diesem Telefon entfernt und losgelöst. Die Gegenseite behält ihre Kopie.';

  @override
  String get pushWakeTitle => 'Dieses Telefon wecken';

  @override
  String get pushWakeHint =>
      'Ein kleiner Server beobachtet die Relays auf deine Adresse und weckt dieses Telefon, wenn etwas ankommt — so meldet sich auch die geschlossene App. Er sieht nie eine Nachricht oder einen Schlüssel, nur dass deine Adresse etwas erhalten hat und wann. Das Relay weiß das ohnehin; dies ist ein zweiter Ort, der es weiß.';

  @override
  String get pushWakeDeniedTitle => 'Mitteilungen sind ausgeschaltet';

  @override
  String get pushWakeDeniedHint =>
      'Das System hat einmal ein Nein bekommen und fragt nicht erneut, daher lässt sich das nur in den Einstellungen wieder einschalten — cubechat, dann Mitteilungen. Komm danach hierher zurück.';

  @override
  String get pushWakeRefused => 'Mitteilungen wurden nicht erlaubt';

  @override
  String get privacyForwardLinkTitle => 'Link in Weiterleitungen';

  @override
  String get privacyForwardLinkHint =>
      'Wenn jemand eine Nachricht von dir weiterleitet, kann die Zeile darüber dein Profil öffnen. Ist das aus, sehen andere deinen Namen, aber nichts zum Antippen. Das ist eine Bitte an ihre App, nichts, was diese App erzwingen kann.';

  @override
  String get privacyShareSheetTitle => 'Chats im Teilen-Menü';

  @override
  String get privacyShareSheetOnHint =>
      'Die Namen deiner vier neuesten Chats werden an Android übergeben, damit du aus jeder App an sie senden kannst. Die App-Sperre verbirgt sie nicht.';

  @override
  String get privacyShareSheetOffHint =>
      'Nichts wird an Android übergeben. Beim Teilen in CubeChat wählst du den Chat selbst.';

  @override
  String get privacyCallsTitle => 'Anrufe annehmen';

  @override
  String get privacyCallsOnHint =>
      'Deine Kontakte können dich anrufen. Um eine Person abzulehnen, öffne ihr Profil.';

  @override
  String get privacyCallsOffHint =>
      'Niemand kann dich anrufen, außer Personen, die du in ihrem Profil erlaubst. Ein abgelehnter Anruf kommt bei ihnen als besetzt an.';

  @override
  String get chatsStatusChannel => 'Kanal';

  @override
  String get channelInviteTitle => 'Personen hinzufügen';

  @override
  String get channelInviteAction => 'Einladen';

  @override
  String get channelInviteEmpty =>
      'Noch keine bekannten Kontakte. Triff zuerst jemanden im Tab „In der Nähe“.';

  @override
  String get channelInviteSent => 'Einladungen gesendet';

  @override
  String get channelInviteNoneSent => 'Gerade war niemand erreichbar';

  @override
  String get channelNameTooLong => 'Dieser Kanalname ist zu lang';

  @override
  String get chatsActionFavorite => 'Zu Favoriten';

  @override
  String get chatsActionUnfavorite => 'Aus Favoriten entfernen';

  @override
  String get chatsActionDelete => 'Chat löschen';

  @override
  String get chatsDeleteTitle => 'Diesen Chat löschen?';

  @override
  String chatsDeleteManyHint(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Leert $count Unterhaltungen. Die Kontakte bleiben, du kannst ihnen also wieder schreiben, ohne Codes auszutauschen.',
      one:
          'Leert $count Unterhaltung. Die Kontakte bleiben, du kannst ihnen also wieder schreiben, ohne Codes auszutauschen.',
    );
    return '$_temp0';
  }

  @override
  String get chatsDeletedToast => 'Chat gelöscht.';

  @override
  String chatsDeletedManyToast(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Chats gelöscht.',
      one: '$count Chat gelöscht.',
    );
    return '$_temp0';
  }

  @override
  String get undo => 'Rückgängig';

  @override
  String get chatsDeletePeerHint =>
      'Leert die Unterhaltung. Der Kontakt bleibt, du kannst ihm also wieder schreiben, ohne Codes auszutauschen.';

  @override
  String get chatsDeleteChannelHint =>
      'Verlässt den Kanal und entfernt seinen Verlauf. Zum erneuten Beitreten brauchst du wieder den Schlüssel.';

  @override
  String get chatsDeleteForThemToo => 'Auch beim Gegenüber löschen';

  @override
  String get chatsDeleteForThemHint =>
      'Bittet die App der anderen Person, die ganze Unterhaltung ebenfalls zu leeren, auch was sie geschrieben hat. In einem Kanal werden nur deine eigenen Nachrichten zurückgezogen.';

  @override
  String get chatEditAction => 'Bearbeiten';

  @override
  String get chatEditTitle => 'Nachricht bearbeiten';

  @override
  String get chatEditSave => 'Speichern';

  @override
  String get chatEdited => 'bearbeitet';

  @override
  String get chatDeleteAction => 'Löschen';

  @override
  String get chatDeleteTitle => 'Nachricht löschen?';

  @override
  String get chatDeleteForMe => 'Für mich löschen';

  @override
  String get chatDeleteForEveryone => 'Für alle löschen';

  @override
  String get chatPinTitle => 'Nachricht anheften?';

  @override
  String get chatPinForBoth => 'Für beide anheften';

  @override
  String get chatPinForMe => 'Nur für mich anheften';

  @override
  String get chatReplyAction => 'Antworten';

  @override
  String chatReplyingTo(String name) {
    return 'Antwort an $name';
  }

  @override
  String get chatReplyYou => 'dich selbst';

  @override
  String get chatCopyAction => 'Kopieren';

  @override
  String get chatCopied => 'Kopiert';

  @override
  String get chatForwardAction => 'Weiterleiten';

  @override
  String get chatForwardTitle => 'Weiterleiten an';

  @override
  String get shareIntoTitle => 'Senden an';

  @override
  String get shareNearbyAirDrop => 'In der Nähe per AirDrop';

  @override
  String get shareNearbyAirDropHint =>
      'Kein Internet nötig — an Personen direkt neben dir';

  @override
  String get shareSent => 'Gesendet';

  @override
  String get shareFailed => 'Einiges konnte nicht gesendet werden';

  @override
  String get chatForwardEmpty => 'Noch keine anderen Chats';

  @override
  String chatForwardSendCount(int count) {
    return 'Senden ($count)';
  }

  @override
  String chatForwardSentCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'An $count Chats weitergeleitet',
      one: 'An einen Chat weitergeleitet',
    );
    return '$_temp0';
  }

  @override
  String chatForwardSent(String name) {
    return 'An $name weitergeleitet';
  }

  @override
  String chatSentAt(String time) {
    return 'Gesendet $time';
  }

  @override
  String chatReadAt(String time) {
    return 'Gelesen $time';
  }

  @override
  String get chatPinAction => 'Anheften';

  @override
  String get chatUnpinAction => 'Loslösen';

  @override
  String chatPinnedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count angeheftete Nachrichten',
      one: '1 angeheftete Nachricht',
      zero: 'Keine angehefteten Nachrichten',
    );
    return '$_temp0';
  }

  @override
  String get chatNoPins => 'Hier ist nichts angeheftet';

  @override
  String get chatUnpinAll => 'Alle Nachrichten loslösen';

  @override
  String get chatShowAllPins => 'Alle angehefteten Nachrichten';

  @override
  String get chatUnpinConfirm => 'Diese Nachricht loslösen?';

  @override
  String get chatUnpinConfirmHint =>
      'Sie ist dann für alle in diesem Chat nicht mehr angeheftet.';

  @override
  String get chatPinnedTitle => 'Angeheftete Nachricht';

  @override
  String get chatPinnedGone => 'Diese Nachricht ist nicht mehr in diesem Chat';

  @override
  String get peerBlock => 'Blockieren';

  @override
  String get peerUnblock => 'Freigeben';

  @override
  String get peerMute => 'Stumm';

  @override
  String get peerUnmute => 'Ton an';

  @override
  String get peerBlockedNote => 'Blockiert — Nachrichten werden verworfen.';

  @override
  String get relaysTitle => 'Internet als Ausweichweg';

  @override
  String get relaysCardTitle => 'Kontakte übers Internet erreichen';

  @override
  String get relaysCardSubtitle =>
      'Wenn Bluetooth nicht zustellen kann, über Nostr-Relays senden';

  @override
  String get relaysExplainer =>
      'Nachrichten bleiben Ende-zu-Ende-verschlüsselt — ein Relay transportiert nur denselben versiegelten Frame wie Bluetooth. Es erfährt aber, welche zwei Schlüssel miteinander sprechen und wann. Standardmäßig aus.';

  @override
  String get relaysMyAddress => 'Deine Relay-Adresse';

  @override
  String get relaysCopied => 'Kopiert';

  @override
  String get circleLensTitle => 'Frontkamera für Videonachrichten';

  @override
  String get circleLensFrontHint =>
      'Runde Videonachrichten werden mit der Kamera aufgenommen, die auf dich zeigt.';

  @override
  String get circleLensBackHint =>
      'Runde Videonachrichten werden mit der Rückkamera aufgenommen, um zu zeigen, was du siehst.';

  @override
  String get channelCloseTitle => 'Raum für alle schließen';

  @override
  String get channelCloseSubtitle =>
      'Entfernt ihn von den Telefonen aller Mitglieder. Nur du kannst das.';

  @override
  String get channelCloseConfirm =>
      'Der Raum, seine Nachrichten und Mitglieder verschwinden von jedem Telefon, das ihn hat. Ausgesperrt wird niemand: Der Schlüssel ergibt sich aus dem Namen, wer ihn kennt, kann wieder einen leeren Raum öffnen.';

  @override
  String get channelCloseAction => 'Raum schließen';

  @override
  String get circleHint => 'Loslassen zum Senden · nach links zum Abbrechen';

  @override
  String get circleHintLocked => 'Tippe auf Senden, wenn du fertig bist';

  @override
  String get circleNeedsCamera =>
      'Videonachrichten brauchen Kamera und Mikrofon';

  @override
  String get circleFailed =>
      'Die Videonachricht konnte nicht aufgenommen werden';

  @override
  String get relaysListLabel => 'Relays';

  @override
  String get relaysLaneMedia => 'Medien-Relays';

  @override
  String get relaysLaneMediaNote =>
      'Fotos, Dateien und Videos laufen über diese, damit eine Übertragung die Unterhaltung nicht bremst.';

  @override
  String get relaysLaneLocation => 'Standort-Relays';

  @override
  String get relaysLaneLocationNote =>
      'Kartensignale laufen über diese, getrennt von allem anderen.';

  @override
  String get relaysAdd => 'Relay hinzufügen';

  @override
  String get relaysAddHint => 'wss://relay.example.com';

  @override
  String get relaysInvalidUrl => 'Gib eine wss://- oder ws://-Adresse ein';

  @override
  String get relaysRemove => 'Entfernen';

  @override
  String get relaysStateConnected => 'Verbunden';

  @override
  String get relaysStateConnecting => 'Verbinden…';

  @override
  String get relaysStateFailed => 'Nicht erreichbar';

  @override
  String get relaysStateIdle => 'Aus';

  @override
  String get relaysEmpty =>
      'Keine Relays eingerichtet — der Ausweichweg bleibt aus.';

  @override
  String get contactTitle => 'Kontaktkarte';

  @override
  String get contactMineLabel => 'Deine Karte';

  @override
  String get contactMineExplainer =>
      'Sende sie an jemanden außerhalb der Bluetooth-Reichweite. Sie enthält deine Schlüssel und deine Relay-Adresse — genug, um übers Internet einen verschlüsselten Chat mit dir zu beginnen.';

  @override
  String get contactCopy => 'Kopieren';

  @override
  String get contactShare => 'Teilen';

  @override
  String get contactCopied => 'Karte kopiert';

  @override
  String get contactShareSubject => 'Meine cubechat-Kontaktkarte';

  @override
  String get contactAddLabel => 'Jemanden hinzufügen';

  @override
  String get contactAddHint => 'Kontaktkarte einfügen';

  @override
  String get contactAddAction => 'Hinzufügen';

  @override
  String get contactPaste => 'Einfügen';

  @override
  String contactAdded(String name) {
    return '$name hinzugefügt';
  }

  @override
  String get contactInvalid => 'Das ist keine gültige Kontaktkarte';

  @override
  String get contactOwnCard => 'Das ist deine eigene Karte';

  @override
  String get contactUnverified =>
      'Ein so hinzugefügter Kontakt ist zunächst nicht verifiziert. Jeder kann eine Karte erstellen und einen beliebigen Namen daraufsetzen. Vergleiche daher Fingerabdrücke persönlich oder per Anruf, bevor du der Identität vertraust.';

  @override
  String get contactRelayOff =>
      'Der Internet-Ausweichweg ist aus, daher erreicht eine Karte noch niemanden.';

  @override
  String get contactRelayEnable => 'Einschalten';

  @override
  String get profileContactCard => 'Kontaktkarte';

  @override
  String get chatsAddContactTooltip => 'Kontakt per Karte hinzufügen';

  @override
  String get chatsMenuTooltip => 'Mehr';

  @override
  String get chatsMenuAddContact => 'Kontakt hinzufügen';

  @override
  String get chatsMenuNewChannel => 'Neuer Kanal';

  @override
  String get profileDiscoverable => 'In der Nähe sichtbar';

  @override
  String get profileDiscoverableOnHint =>
      'Jeder in Reichweite kann dich finden';

  @override
  String get profileDiscoverableOffHint => 'Nur deine Kontakte erreichen dich';

  @override
  String get profileDiscoverableExplainer =>
      'Ist es an, wird deine Ankündigung unverschlüsselt gesendet, damit Fremde dich einfach in der Nähe treffen können — und jeder Mithörende speichert deinen Schlüssel und Namen. Ist es aus, geht dasselbe Paket versiegelt nur an deine bestehenden Kontakte, und deine Routing-IDs bleiben unverknüpfbar. Neue Personen brauchen dann eine Kontaktkarte.';

  @override
  String get voiceHoldHint => 'Halten für Sprachnachricht';

  @override
  String get voiceTrimPlay => 'Abspielen';

  @override
  String get voiceTrimPause => 'Pause';

  @override
  String get voiceTrimDiscard => 'Aufnahme verwerfen';

  @override
  String voiceTrimSelection(String duration) {
    return 'Sende $duration';
  }

  @override
  String get profileLastSeen => 'Zuletzt online teilen';

  @override
  String get profileLastSeenOnHint => 'Kontakte sehen, wann du in der App bist';

  @override
  String get profileLastSeenOffHint =>
      'Niemand sieht deine Zeit, und du siehst niemandes: nur, wer online ist';

  @override
  String get profileMapLocation => 'Mich auf der Karte zeigen';

  @override
  String get profileMapLocationOnHint =>
      'Standort kann manuell geteilt werden und dein Pin wird auf der Karte gezeigt';

  @override
  String get profileMapLocationOffHint =>
      'Die App fragt keinen Standort ab und dein Pin bleibt verborgen';

  @override
  String get desktopAutostartTitle => 'Mit Windows starten';

  @override
  String get desktopAutostartHint =>
      'CubeChat wartet im Infobereich, damit Anrufe und Nachrichten diesen Computer auch bei geschlossenem Fenster erreichen';

  @override
  String get trayOpen => 'CubeChat öffnen';

  @override
  String get trayQuit => 'Beenden';

  @override
  String get callDirectTitle => 'Direkte Anrufe';

  @override
  String get callDirectOnHint =>
      'Schneller, aber die angerufene Person erfährt deine IP-Adresse';

  @override
  String get callDirectOffHint =>
      'Anrufe laufen über unser Relay: Die angerufene Person sieht deine IP nie, und das Relay kann den Anruf nicht hören';

  @override
  String get profileReadReceipts => 'Lesebestätigungen senden';

  @override
  String get profileReadReceiptsOnHint =>
      'Absender sehen, wann du gelesen hast';

  @override
  String get profileReadReceiptsOffHint =>
      'Du sendest deine Lesezeit nicht mehr, siehst ihre aber weiterhin';

  @override
  String get profilePrivacyExplainer =>
      '„Zuletzt online“ gilt in beide Richtungen: Verbirgst du deinen Status, siehst du auch den der anderen nicht mehr. Lesebestätigungen betreffen nur, was du sendest. Die Zustellung von Nachrichten bleibt unberührt.';

  @override
  String get chatTimerAction => 'Timer';

  @override
  String get chatTimerRemove => 'Timer entfernen';

  @override
  String get chatTimerTitle => 'Nachricht löschen nach';

  @override
  String chatTimerSet(String time) {
    return 'Diese Nachricht verschwindet in $time';
  }

  @override
  String get chatTimerLocalHint =>
      'Nur auf diesem Gerät — ihre Kopie gehört ihnen';

  @override
  String get contactTagAction => 'Label';

  @override
  String get contactTagRemove => 'Label entfernen';

  @override
  String get contactTagTitle => 'Label wählen';

  @override
  String get contactTagAll => 'Alle';

  @override
  String get quietHoursTitle => 'Ruhezeiten';

  @override
  String get quietHoursHint =>
      'Nachrichten kommen weiter an; das Telefon bleibt still';

  @override
  String get quietHoursFrom => 'Von';

  @override
  String get quietHoursTo => 'Bis';

  @override
  String get notifPreviewTitle => 'In Mitteilungen zeigen';

  @override
  String get notifPreviewFull => 'Name und Text';

  @override
  String get notifPreviewNameOnly => 'Nur Name';

  @override
  String get notifPreviewHidden => 'Nichts';

  @override
  String get notifPreviewHint =>
      'Mitteilungen sind auf dem Sperrbildschirm und für Apps mit Mitteilungszugriff sichtbar, auch bei aktiver App-Sperre';

  @override
  String get notifPreviewNewMessage => 'Neue Nachricht';

  @override
  String get appLockTitle => 'App-Sperre';

  @override
  String get appLockHint => 'Beim Öffnen nach einem Code fragen';

  @override
  String get appLockPrompt => 'Code eingeben';

  @override
  String get appLockUnlock => 'Entsperren';

  @override
  String get appLockWrong => 'Falscher Code';

  @override
  String get appLockSetTitle => 'Code festlegen';

  @override
  String get appLockSetHint =>
      'Mindestens vier Ziffern. Er lässt sich nicht wiederherstellen.';

  @override
  String get appLockOffTitle => 'Sperre ausschalten';

  @override
  String get appLockOffHint => 'Aktuellen Code eingeben';

  @override
  String get appLockOn => 'App-Sperre ist an';

  @override
  String get appLockOff => 'App-Sperre ist aus';

  @override
  String get avatarSet => 'Foto wählen';

  @override
  String get avatarChange => 'Foto ändern';

  @override
  String get avatarView => 'Foto ansehen';

  @override
  String get profileCoverPhoto => 'Profilfoto, zum Vergrößern doppelt tippen';

  @override
  String get profileCoverMenu => 'Fotooptionen';

  @override
  String get avatarSaved => 'In Galerie gespeichert';

  @override
  String get avatarRemove => 'Foto entfernen';

  @override
  String get avatarRemoveConfirm =>
      'Das Profilbild wird von diesem Gerät gelöscht. An seine Stelle tritt wieder der erzeugte Farbverlauf.';

  @override
  String get avatarFailed => 'Bild konnte nicht gelesen werden';

  @override
  String get fileOpenHint => 'Zum Öffnen tippen';

  @override
  String get fileMissing => 'Diese Datei ist nicht mehr verfügbar';

  @override
  String get fileNoHandlerTitle => 'Keine App kann das öffnen';

  @override
  String get fileNoHandlerHint =>
      'Keine installierte App unterstützt diesen Dateityp. Du kannst die Datei stattdessen an eine andere App senden.';

  @override
  String get fileRequestedAgain => 'Absender erneut darum gebeten';

  @override
  String get fileOpenFailed => 'Datei konnte nicht geöffnet werden';

  @override
  String get fileShareAction => 'An App senden';

  @override
  String fileTooLargeMesh(int limit) {
    return 'Datei zu groß — über das Mesh sind maximal $limit MB möglich';
  }

  @override
  String fileTooLargeRelay(int limit) {
    return 'Übers Internet liegt das Limit bei $limit MB. Geh näher an den Empfänger heran, um eine größere Datei zu senden.';
  }

  @override
  String get mediaSendOriginal => 'Original';

  @override
  String get attachFile => 'Datei';

  @override
  String get attachGallery => 'Galerie';

  @override
  String get attachCamera => 'Kamera';

  @override
  String get cameraUnavailable => 'Kamera nicht verfügbar';

  @override
  String get profileEditName => 'Name';

  @override
  String get profileMyCard => 'Karte';

  @override
  String get mediaCaptionHint => 'Bildunterschrift hinzufügen…';

  @override
  String get mediaDiscardTitle => 'Auswahl verwerfen?';

  @override
  String get mediaDiscardMessage =>
      'Galerie schließen und ausgewählte Fotos verwerfen?';

  @override
  String get mediaDiscardConfirm => 'Verwerfen';

  @override
  String get mediaPhotosAccessOff => 'Fotozugriff ist aus';

  @override
  String get mediaPhotosAccessOffHint =>
      'CubeChat sieht derzeit nur Videos. Erlaube den Fotozugriff in den Systemeinstellungen, um deine Bilder anzuzeigen.';

  @override
  String get mediaVideosOnly => 'Nur Videos sichtbar — Fotozugriff erlauben';

  @override
  String get mediaOpenSettings => 'Einstellungen öffnen';

  @override
  String get mediaTakePhoto => 'Foto aufnehmen';

  @override
  String get contactProfileAutoDelete => 'Chat automatisch löschen';

  @override
  String get contactProfileAutoDeleteTitle => 'Nachrichten automatisch löschen';

  @override
  String get contactProfileAutoDeleteOff => 'Aus';

  @override
  String get contactProfileAutoDeleteOneDay => 'Nach 1 Tag';

  @override
  String get contactProfileAutoDeleteSevenDays => 'Nach 7 Tagen';

  @override
  String get contactProfileAutoDeleteThirtyDays => 'Nach 30 Tagen';

  @override
  String contactProfileAutoDeleteUpdated(String period) {
    return 'Automatisch löschen: $period';
  }

  @override
  String get contactProfileShare => 'Kontakt teilen';

  @override
  String get contactProfileShareTitle => 'Kontakt senden an';

  @override
  String get contactProfileShareEmpty => 'Noch keine anderen Chats';

  @override
  String contactProfileShareSent(String name) {
    return 'An $name gesendet';
  }

  @override
  String get contactProfileRestrictCopying => 'Kopieren verbieten';

  @override
  String get contactProfileAllowCopying => 'Kopieren erlauben';

  @override
  String get contactHideAvatar => 'Mein Foto verbergen';

  @override
  String get contactShowAvatar => 'Mein Foto zeigen';

  @override
  String get contactHideLastSeen => '„Zuletzt online“ verbergen';

  @override
  String get contactShowLastSeen => '„Zuletzt online“ zeigen';

  @override
  String get contactHideReadReceipts => 'Meine Lesezeiten verbergen';

  @override
  String get contactShowReadReceipts => 'Meine Lesezeiten zeigen';

  @override
  String get contactHiddenFromThem => 'Vor diesem Kontakt verborgen';

  @override
  String get contactRefuseCalls => 'Anrufe ablehnen';

  @override
  String get contactAllowCalls => 'Anrufe annehmen';

  @override
  String get contactCallsException =>
      'Eine Ausnahme von deiner Anrufeinstellung';

  @override
  String get contactProfileCopyingRestricted =>
      'Kopieren und Weiterleiten sind gesperrt';

  @override
  String get contactProfileCopyingRestrictedByPeer =>
      'Von der Gegenseite gesperrt';

  @override
  String get contactProfileCopyingAllowed =>
      'Kopieren und Weiterleiten sind erlaubt';

  @override
  String get contactProfileDelete => 'Aus Kontakten löschen';

  @override
  String get contactProfileRestore => 'Wieder zu Kontakten';

  @override
  String get contactProfileRestoreDone => 'Wieder in deinen Kontakten';

  @override
  String get contactProfileDeleteTitle => 'Kontakt entfernen?';

  @override
  String contactProfileDeleteMessage(String name) {
    return '$name verschwindet aus den Kontakten. Der Chatverlauf bleibt auf diesem Gerät.';
  }

  @override
  String get contactProfileMedia => 'Medien';

  @override
  String get contactProfileVoiceMessages => 'Sprachnachrichten';

  @override
  String get contactProfileStickers => 'Sticker';

  @override
  String get contactProfileNoStickers => 'Noch keine Sticker';

  @override
  String get contactProfileNoMedia => 'Noch keine Medien';

  @override
  String get contactProfileNoVoiceMessages => 'Noch keine Sprachnachrichten';

  @override
  String get contactProfileOpen => 'Profil öffnen';

  @override
  String autoDeleteDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Tage',
      one: '$count Tag',
    );
    return '$_temp0';
  }

  @override
  String autoDeleteHours(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Stunden',
      one: '$count Stunde',
    );
    return '$_temp0';
  }

  @override
  String autoDeleteMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Minuten',
      one: '$count Minute',
    );
    return '$_temp0';
  }

  @override
  String autoDeleteSeconds(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Sekunden',
      one: '$count Sekunde',
    );
    return '$_temp0';
  }

  @override
  String get autoDeleteCustom => 'Eigene…';

  @override
  String get autoDeleteCustomHint => 'Anzahl';

  @override
  String get autoDeleteUnitMinutes => 'Min.';

  @override
  String get autoDeleteUnitHours => 'Std.';

  @override
  String get autoDeleteUnitDays => 'Tage';

  @override
  String get contactProfileAutoDeleteSet => 'Festlegen';

  @override
  String get contactProfileFiles => 'Dateien';

  @override
  String get contactProfileNoFiles => 'Noch keine Dateien';

  @override
  String get contactProfileLinks => 'Links';

  @override
  String get contactProfileNoLinks => 'Noch keine Links';

  @override
  String get contactProfilePolls => 'Umfragen';

  @override
  String get contactProfileNoPolls => 'Noch keine Umfragen';

  @override
  String get presenceRecently => 'zuletzt kürzlich online';

  @override
  String get presenceJustNow => 'gerade eben';

  @override
  String presenceHoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'vor $count Stunden',
      one: 'vor $count Stunde',
    );
    return '$_temp0';
  }

  @override
  String presenceYesterdayAt(String time) {
    return 'gestern um $time';
  }

  @override
  String presenceOnWeekday(String day) {
    String _temp0 = intl.Intl.selectLogic(
      day,
      {
        '1': 'am Montag',
        '2': 'am Dienstag',
        '3': 'am Mittwoch',
        '4': 'am Donnerstag',
        '5': 'am Freitag',
        '6': 'am Samstag',
        '7': 'am Sonntag',
        'other': 'diese Woche',
      },
    );
    return '$_temp0';
  }

  @override
  String presenceWeeksAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'vor $count Wochen',
      one: 'vor einer Woche',
    );
    return '$_temp0';
  }

  @override
  String presenceMonthsAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'vor $count Monaten',
      one: 'vor einem Monat',
    );
    return '$_temp0';
  }

  @override
  String get presenceLongAgo => 'vor langer Zeit';

  @override
  String presenceMinutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'vor $count Minuten',
      one: 'vor $count Minute',
    );
    return '$_temp0';
  }

  @override
  String chatReadByCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Gelesen von $count',
      one: 'Gelesen von $count',
    );
    return '$_temp0';
  }

  @override
  String get chatsSearchFrequent => 'Häufige Kontakte';

  @override
  String get chatsSearchRecent => 'Zuletzt';

  @override
  String get chatsSearchClear => 'Leeren';

  @override
  String get chatsSearchStartHint =>
      'Suche Chats nach Namen oder jede Nachricht nach ihren Wörtern.';

  @override
  String get chatsSearchEmpty => 'Keine Treffer';

  @override
  String get chatRoutesTitle => 'Wie es ankommt';

  @override
  String get chatRoutesBluetoothHint =>
      'Direkt auf ihr Telefon, ganz ohne Internet';

  @override
  String get chatRoutesMeshHint => 'Weitergereicht über Telefone dazwischen';

  @override
  String get chatRoutesInternetHint =>
      'Über ein Relay, wenn niemand in Reichweite ist';

  @override
  String get chatRoutesHint =>
      'Der Weg wird pro Nachricht gewählt, je nachdem, was gerade erreichbar ist.';

  @override
  String get chatRoutesPreferTitle => 'Was zuerst versuchen';

  @override
  String get chatRoutesPreferMesh => 'Zuerst Bluetooth';

  @override
  String get chatRoutesPreferMeshHint =>
      'Im selben Raum schneller, kostet kein Datenvolumen, verrät einem Relay nichts';

  @override
  String get chatRoutesPreferRelay => 'Zuerst Internet';

  @override
  String get chatRoutesPreferRelayHint =>
      'Bei schwacher Bluetooth-Verbindung und gutem Netz';

  @override
  String get chatRoutesPreferNote =>
      'Eine Vorliebe, keine Sperre. Ist der gewählte Weg nicht erreichbar, trägt der andere die Nachricht trotzdem.';

  @override
  String get deadmanTitle => 'Bei Nichtnutzung löschen';

  @override
  String get deadmanOff => 'Aus';

  @override
  String deadmanDays(int days) {
    return 'Nach $days Tagen';
  }

  @override
  String get deadmanHint =>
      'Öffnet niemand die App so lange, wird beim nächsten Öffnen alles darauf gelöscht. Eine Vorwarnung ist nicht möglich — genau darum geht es.';

  @override
  String chatForwardedFrom(String name) {
    return 'Weitergeleitet von $name';
  }

  @override
  String appLockWait(String left) {
    return 'Zu viele Versuche — warte $left';
  }

  @override
  String get appLockGraceTitle => 'Code abfragen';

  @override
  String get appLockGraceNow => 'Jedes Mal';

  @override
  String appLockGraceAfter(String left) {
    return 'Nach $left Abwesenheit';
  }

  @override
  String get chatCalendarTitle => 'Nach Datum';

  @override
  String get chatCalendarEmpty => 'Hier wurde noch nichts gesagt';

  @override
  String get chatsSearchChatsSection => 'Chats';

  @override
  String get chatsSearchMessagesSection => 'Nachrichten';

  @override
  String get contactProfileViewInChat => 'Im Chat ansehen';

  @override
  String get chatDraft => 'Entwurf';

  @override
  String get chatSearchTitle => 'Suche';

  @override
  String get chatSearchHint => 'Nachrichten suchen';

  @override
  String get chatSearchNoResults => 'Keine Treffer';

  @override
  String get chatSearchPrevious => 'Vorheriges Ergebnis';

  @override
  String get chatSearchNext => 'Nächstes Ergebnis';

  @override
  String chatMessageCount(int count) {
    return '$count Nachrichten';
  }

  @override
  String get chatRouteBluetooth => 'Bluetooth';

  @override
  String get chatRouteMesh => 'Mesh';

  @override
  String get chatRouteInternet => 'Internet';

  @override
  String get chatRouteQueued => 'Wartend';

  @override
  String get attachStickers => 'Sticker';

  @override
  String get stickersEmpty => 'Noch keine Sticker';

  @override
  String get stickersEmptyHint =>
      'Behalte ein Bild aus einem Chat, dann erscheint es hier.';

  @override
  String get stickerKeep => 'Als Sticker speichern';

  @override
  String get stickerKept => 'In deinen Stickern gespeichert';

  @override
  String get stickerForget => 'Sticker entfernen';

  @override
  String get stickerCreate => 'Sticker aus Foto erstellen';

  @override
  String get stickerFailed => 'Aus diesem Bild ließ sich kein Sticker machen';

  @override
  String get stickerLabel => 'Sticker';

  @override
  String get previewPhoto => 'Foto';

  @override
  String get previewVoice => 'Sprachnachricht';

  @override
  String get previewFile => 'Datei';

  @override
  String get stickerEmojiTitle => 'Wähle ein Emoji dafür';

  @override
  String get stickersMine => 'Meine Sticker';

  @override
  String get stickersStarterPack => 'Cubi';

  @override
  String get emojiTab => 'Emoji';

  @override
  String get chatBlockedStatus => 'blockiert';

  @override
  String get chatBlockedHint => 'Du hast diese Person blockiert';

  @override
  String get chatRouteFallbackOff => 'Internet aus';

  @override
  String get chatAttachmentUnavailable =>
      'Keine Verbindung verfügbar. Verbinde dich über Bluetooth oder das Internet und versuche es erneut.';

  @override
  String get fileTransfersTitle => 'Dateiübertragungen';

  @override
  String get fileTransfersClear => 'Verlauf leeren';

  @override
  String get fileTransfersEmpty => 'Noch keine Dateiübertragungen';

  @override
  String get fileTransfersActive => 'Aktiv';

  @override
  String get fileTransfersHistory => 'Verlauf';

  @override
  String get fileTransferPause => 'Pausieren';

  @override
  String get fileTransferResume => 'Fortsetzen';

  @override
  String get fileTransferRetry => 'Wiederholen';

  @override
  String get fileTransferQueued => 'Wartet auf Verbindung';

  @override
  String get fileTransferRunning => 'Wird übertragen';

  @override
  String get fileTransferPaused => 'Pausiert';

  @override
  String get fileTransferCompleted => 'Abgeschlossen';

  @override
  String get fileTransferFailed => 'Fehlgeschlagen';

  @override
  String get fileTransferCanceled => 'Abgebrochen';

  @override
  String get profileFileTransfers => 'Dateiübertragungen';

  @override
  String get profileFileTransfersSubtitle =>
      'Fortschritt, Warteschlange und Verlauf';

  @override
  String get qrScanAction => 'QR-Code scannen';

  @override
  String get qrScanTitle => 'QR-Code scannen';

  @override
  String get qrScanHint =>
      'Scanne einen CubeChat-Code für Kontakt, Kanal, Kontoübertragung oder Computer-Anmeldung.';

  @override
  String get qrFlash => 'Taschenlampe';

  @override
  String get qrCameraError =>
      'Kamera nicht verfügbar. Prüfe die Kameraberechtigung und versuche es erneut.';

  @override
  String get qrInvalid => 'Das ist kein gültiger Cubechat-QR-Code.';

  @override
  String qrChannelAdded(String name) {
    return '$name hinzugefügt';
  }

  @override
  String get qrShow => 'QR-Code zeigen';

  @override
  String qrChannelTitle(String name) {
    return '$name beitreten';
  }

  @override
  String get profileBackup => 'Verschlüsseltes Backup';

  @override
  String get profileBackupSubtitle =>
      'Schlüssel, Kontakte und Verlauf sicher umziehen';

  @override
  String get backupTitle => 'Verschlüsseltes Backup';

  @override
  String get backupExplainer =>
      'Das Backup enthält deine privaten Identitätsschlüssel, Kontakte, Kanäle, Einstellungen und deinen Nachrichtenverlauf. Es wird auf diesem Telefon mit dem von dir gewählten Passwort verschlüsselt; ein vergessenes Passwort kann Cubechat nicht wiederherstellen.';

  @override
  String get backupCreate => 'Backup erstellen';

  @override
  String get backupCreateSubtitle =>
      'Alles verschlüsseln und als .cchatbackup-Datei speichern';

  @override
  String get backupRestore => 'Backup wiederherstellen';

  @override
  String get backupRestoreSubtitle =>
      'Cubechat-Profil dieses Telefons aus einer Backup-Datei ersetzen';

  @override
  String get backupPasswordTitle => 'Backup-Passwort';

  @override
  String get backupPasswordHint => 'Mindestens 8 Zeichen';

  @override
  String get backupConfirmPassword => 'Passwort wiederholen';

  @override
  String get backupPasswordMismatch => 'Passwörter stimmen nicht überein';

  @override
  String get backupPasswordShort => 'Mindestens 8 Zeichen verwenden';

  @override
  String get backupSaveTitle => 'Cubechat-Backup speichern';

  @override
  String get backupSaved => 'Verschlüsseltes Backup gespeichert';

  @override
  String get backupWhereTitle => 'Wohin mit dem Backup?';

  @override
  String get backupSaveToFiles => 'In Dateien sichern';

  @override
  String get backupSaveToFilesHint =>
      'Ein Ordner auf diesem Telefon, eine Speicherkarte oder ein Cloud-Speicher';

  @override
  String get backupSendToApp => 'An eine App senden';

  @override
  String get backupSendToAppHint =>
      'Telegram, Mail, ein Messenger — alles, was Dateien annimmt';

  @override
  String get backupFailed => 'Backup-Vorgang konnte nicht abgeschlossen werden';

  @override
  String get backupRestoreConfirmTitle => 'Dieses Profil ersetzen?';

  @override
  String get backupRestoreConfirmMessage =>
      'Aktuelle Schlüssel, Kontakte, Kanäle, Einstellungen und Verlauf auf diesem Telefon werden durch das gewählte Backup ersetzt.';

  @override
  String get backupRestoreConfirmAction => 'Wiederherstellen';

  @override
  String get backupRestored => 'Backup wiederhergestellt';

  @override
  String get backupPackingWait => 'Backup wird erstellt…';

  @override
  String get backupUnpackingWait => 'Backup wird wiederhergestellt…';

  @override
  String get backupWaitHint =>
      'Mit Fotos und Videos kann das einige Minuten dauern. Lass die App geöffnet.';

  @override
  String get backupInvalid =>
      'Falsches Passwort, beschädigte Datei oder nicht unterstütztes Backup';

  @override
  String get channelInfoTitle => 'Kanaldetails';

  @override
  String get channelParticipantsTitle => 'Mitglieder';

  @override
  String get channelAdministratorsTitle => 'Administratoren';

  @override
  String get channelMakeAdmin => 'Zum Admin machen';

  @override
  String get channelRemoveAdmin => 'Admin-Rechte entziehen';

  @override
  String get channelNoParticipants =>
      'Mitglieder erscheinen nach signierter Aktivität';

  @override
  String get channelSharedContent => 'Medien, Dateien und Umfragen';

  @override
  String get channelDescriptionTitle => 'Beschreibung';

  @override
  String get channelDescriptionEmpty => 'Noch keine Beschreibung';

  @override
  String get channelDescriptionHint => 'Wofür dieser Kanal ist';

  @override
  String get channelDescriptionAdminOnly =>
      'Nur ein Administrator kann die Beschreibung ändern';

  @override
  String get channelDescriptionSave => 'Speichern';

  @override
  String get channelPrivateSubtitle => 'privater Kanal';

  @override
  String get channelAvatarSet => 'Neues Foto festlegen';

  @override
  String get channelSettingsTitle => 'Kanaleinstellungen';

  @override
  String get channelSettingsHint => 'Wer schreiben darf, Kopieren, Verlauf';

  @override
  String get channelLeaveAction => 'Verlassen';

  @override
  String get channelLeaveConfirm =>
      'Der Raum und alles darin Gesagte verschwinden von diesem Telefon. Der Schlüssel ergibt sich aus dem Namen, du kannst ihn also durch Eingabe desselben Namens wieder öffnen.';

  @override
  String get channelShareAction => 'Teilen';

  @override
  String channelMembersOf(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Mitglieder',
      one: '1 Mitglied',
    );
    return '$_temp0';
  }

  @override
  String get chatTyping => 'schreibt…';

  @override
  String get chatRecordingVoice => 'nimmt Sprachnachricht auf…';

  @override
  String get chatRecordingCircle => 'nimmt Videonachricht auf…';

  @override
  String get chatSendingPhoto => 'sendet ein Foto…';

  @override
  String get chatSendingVideo => 'sendet ein Video…';

  @override
  String get chatSendingFile => 'sendet eine Datei…';

  @override
  String get onboardingMeshTitle => 'Funktioniert ohne Internet';

  @override
  String get onboardingMeshBody =>
      'Nachrichten reisen per Bluetooth von Telefon zu Telefon. Kein Netz, kein Wi-Fi, keine Konten — nur die Menschen um dich herum.';

  @override
  String get onboardingRelayTitle => 'Und mit, wenn es welches gibt';

  @override
  String get onboardingRelayBody =>
      'Außerhalb der Bluetooth-Reichweite nehmen Nachrichten stattdessen das Internet und kommen genauso an. Du musst nie wählen.';

  @override
  String get onboardingPrivacyTitle => 'Niemand dazwischen kann mitlesen';

  @override
  String get onboardingPrivacyBody =>
      'Alles ist Ende-zu-Ende-verschlüsselt, und deine Identität ist ein Schlüssel auf diesem Telefon — keine Telefonnummer, keine E-Mail, kein Konto, das dir jemand wegnehmen kann.';

  @override
  String get onboardingSkip => 'Überspringen';

  @override
  String get onboardingNext => 'Weiter';

  @override
  String get onboardingStart => 'Los geht’s';

  @override
  String get chatMediaShare => 'Teilen';

  @override
  String get chatMediaSaveToGallery => 'In Galerie speichern';

  @override
  String get chatMediaShowInChat => 'Im Chat zeigen';

  @override
  String get chatWallpaperTitle => 'Hintergrund';

  @override
  String get chatWallpaperClear => 'Zurücksetzen';

  @override
  String get chatWallpaperDim => 'Hinter Nachrichten abdunkeln';

  @override
  String get chatSelectAction => 'Auswählen';

  @override
  String get chatForwardNothing => 'Hier lässt sich nichts weiterleiten';

  @override
  String chatSelectedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ausgewählt',
      one: '1 ausgewählt',
    );
    return '$_temp0';
  }

  @override
  String chatDeleteSelectedTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Nachrichten löschen?',
      one: 'Diese Nachricht löschen?',
    );
    return '$_temp0';
  }

  @override
  String get contactAliasAction => 'Kontakt umbenennen';

  @override
  String get contactAliasHint =>
      'Nur du siehst diesen Namen. Leer lassen, um ihren eigenen zu verwenden.';

  @override
  String get viewOnceSendLabel => 'Einmal ansehen';

  @override
  String get viewOnceTitle => 'Einmal ansehen';

  @override
  String get viewOnceTapToView => 'Foto · tippen, um es einmal anzusehen';

  @override
  String get viewOnceSent => 'Foto · gesendet';

  @override
  String get viewOnceOpened => 'Foto geöffnet';

  @override
  String get viewOnceUnavailable => 'Dieses Foto ist nicht mehr verfügbar';

  @override
  String get viewOnceWarning =>
      'Beim Schließen wird das Foto für euch beide gelöscht.';

  @override
  String get channelAvatarAdminOnly =>
      'Nur ein Administrator kann das Kanalfoto ändern';

  @override
  String get channelAdminOnly => 'Nur ein Administrator kann das ändern';

  @override
  String get channelAvatarTooLarge => 'Dieses Foto ist zu groß zum Verteilen';

  @override
  String get channelMemberUnknown => 'Noch nicht in deinen Kontakten';

  @override
  String get channelInviteToContacts => 'Deine Kontaktkarte senden';

  @override
  String channelContactInviteSent(String name) {
    return 'Kontaktkarte an $name angeboten';
  }

  @override
  String get chatContactInvitation => 'Einladung zum Verbinden';

  @override
  String get chatContactInvitationForYou => 'Einladung für dich';

  @override
  String get channelPollTitle => 'Umfrage';

  @override
  String get channelCreatePoll => 'Umfrage erstellen';

  @override
  String get channelPollQuestion => 'Frage';

  @override
  String channelPollOption(int number) {
    return 'Option $number';
  }

  @override
  String get channelPollAddOption => 'Option hinzufügen';

  @override
  String get channelPollCreate => 'Veröffentlichen';

  @override
  String channelPollVotes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Stimmen',
      one: '1 Stimme',
      zero: 'Keine Stimmen',
    );
    return '$_temp0';
  }

  @override
  String get phoneTransferTitle => 'Auf neues Telefon übertragen';

  @override
  String get desktopPickChat => 'Wähle, wem du schreiben möchtest';

  @override
  String get desktopListCollapse => 'Nur Profilbilder zeigen';

  @override
  String get desktopListExpand => 'Chatliste zeigen';

  @override
  String get desktopLinkConnectTitle => 'Computer verbinden';

  @override
  String get desktopLinkConnectHint =>
      'Scanne den Code, den CubeChat auf dem Computer zeigt';

  @override
  String get desktopLinkSignIn => 'Mit dem Konto vom Telefon anmelden';

  @override
  String get desktopLinkTitle => 'Mit dem Telefon anmelden';

  @override
  String get desktopLinkSteps =>
      'Auf dem Telefon: Profil → Daten → Computer verbinden, dann diesen Code scannen. Beide müssen im selben Wi-Fi sein.';

  @override
  String get desktopLinkLimits =>
      'Das Telefon funktioniert weiter. Nachrichten aus dem Internet erreichen beide; was du auf einem sendest, erscheint noch nicht auf dem anderen.';

  @override
  String get desktopLinkWaiting => 'Warte auf das Telefon…';

  @override
  String get desktopLinkFailed =>
      'Konto konnte nicht empfangen werden. Versuche es erneut.';

  @override
  String get desktopLinkRetry => 'Erneut versuchen';

  @override
  String get desktopLinkConfirmTitle =>
      'Eine Kopie dieses Kontos an den Computer senden?';

  @override
  String get desktopLinkConfirmMessage =>
      'Der Computer erhält deine Schlüssel, Kontakte und Chats. Dieses Telefon funktioniert weiter wie bisher.';

  @override
  String get desktopLinkConfirmAction => 'Senden';

  @override
  String desktopLinkConfirmWhere(String address) {
    return 'Nur wenn du diesen Code gerade vom Bildschirm deines eigenen Computers gescannt hast. Er geht an $address in diesem Netzwerk.';
  }

  @override
  String get desktopLinkSending => 'Konto wird gesendet…';

  @override
  String get desktopLinkSent => 'Der Computer ist verbunden';

  @override
  String get desktopLinkPhoneFound =>
      'Das Telefon hat diesen Computer gefunden und erstellt eine Kopie des Kontos. Mit Fotos kann das einige Minuten dauern.';

  @override
  String desktopLinkReceiving(int percent) {
    return 'Konto wird empfangen: $percent%';
  }

  @override
  String get desktopLinkRestoring =>
      'Konto wird auf diesem Computer eingerichtet…';

  @override
  String get desktopLinkFinding => 'Suche den Computer…';

  @override
  String get desktopLinkPreparing =>
      'Kopie des Kontos wird erstellt. Mit Fotos kann das einige Minuten dauern.';

  @override
  String desktopLinkSendingPercent(int percent) {
    return 'Senden: $percent%';
  }

  @override
  String get desktopLinkComputerRestoring =>
      'Der Computer richtet das Konto ein…';

  @override
  String get devicesTitle => 'Geräte';

  @override
  String get devicesRowHint => 'Wo dein Konto geöffnet ist, und dort abmelden';

  @override
  String get devicesThisDevice => 'Dieses Gerät';

  @override
  String get devicesSeenNow => 'Gerade online';

  @override
  String devicesSeenMinutes(int n) {
    return 'Online vor $n Min.';
  }

  @override
  String devicesSeenHours(int n) {
    return 'Online vor $n Std.';
  }

  @override
  String devicesSeenDays(int n) {
    return 'Online vor $n T.';
  }

  @override
  String get devicesLeaving => 'Abmeldung — wartet, bis es online kommt';

  @override
  String get devicesSignOut => 'Abmelden';

  @override
  String get devicesSignOutAll => 'Auf allen anderen Geräten abmelden';

  @override
  String devicesSignOutTitle(String name) {
    return 'Auf „$name“ abmelden?';
  }

  @override
  String get devicesSignOutMessage =>
      'Schlüssel, Chats und Einstellungen von CubeChat werden auf diesem Gerät gelöscht, sobald es online kommt. Das Konto bleibt hier und auf deinen anderen Geräten.';

  @override
  String get devicesSignOutPhoneMessage =>
      'Das ist ein Telefon: CubeChat wird darauf vollständig gelöscht. Das Konto bleibt hier und auf deinen anderen Geräten.';

  @override
  String get devicesSignOutAllMessage =>
      'Jedes andere Gerät wird abgemeldet, sobald es online kommt. Das Konto bleibt nur hier.';

  @override
  String get devicesRename => 'Umbenennen';

  @override
  String get devicesRenameTitle => 'Name dieses Geräts';

  @override
  String get devicesSave => 'Speichern';

  @override
  String get devicesEmpty =>
      'Noch keine anderen Geräte. Ein Gerät erscheint hier, sobald es CubeChat 1.0.0+1147 oder neuer öffnet.';

  @override
  String get devicesCaveat =>
      'Eine Abmeldung wirkt, wenn das Gerät online geht. Ein offline gehaltenes Gerät behält seine Schlüssel; vollen Schutz bieten nur neue Schlüssel für das Konto.';

  @override
  String get desktopLinkImportTitle => 'Konto vom Telefon übernehmen';

  @override
  String get desktopLinkImportHint =>
      'Zeige dem Telefon einen Code, und dieser Computer wird zur Kopie seines Kontos';

  @override
  String get desktopLinkImportConfirmTitle =>
      'Konto auf diesem Computer ersetzen?';

  @override
  String get desktopLinkImportConfirmMessage =>
      'Schlüssel, Kontakte und Chats dieses Computers werden durch das Konto des Telefons ersetzt. Wenn du dieses noch brauchst, erstelle zuerst ein Backup.';

  @override
  String get desktopLinkImportConfirmAction => 'Weiter';

  @override
  String get desktopLinkUnreachable =>
      'Computer nicht erreichbar. Beide müssen im selben Wi-Fi sein, und auf dem Computer muss CubeChat durch die Firewall gelassen werden.';

  @override
  String get desktopLinkFirewallHint =>
      'Windows sperrt das Telefon möglicherweise aus. Lass CubeChat durch die Firewall — nur für dein lokales Netzwerk.';

  @override
  String get desktopLinkFirewallAllow => 'In der Firewall erlauben';

  @override
  String get desktopLinkFirewallDeclined =>
      'Windows hat es nicht erlaubt. Ohne das kommt das Telefon womöglich nicht durch.';

  @override
  String get phoneTransferIntro =>
      'Übertrage Profil, Schlüssel, Kontakte, Kanäle, Einstellungen und Verlauf direkt zwischen zwei Telefonen.';

  @override
  String get phoneTransferSend => 'Das ist das alte Telefon';

  @override
  String get phoneTransferReceive => 'Das ist das neue Telefon';

  @override
  String get phoneTransferSameWifi =>
      'Verbinde beide Telefone mit demselben Wi-Fi. Lass diesen Bildschirm offen, bis die Übertragung fertig ist.';

  @override
  String get phoneTransferPreparing =>
      'Verschlüsselte Übertragung wird vorbereitet…';

  @override
  String get phoneTransferReady =>
      'Scanne diesen Einmal-QR-Code auf dem neuen Telefon';

  @override
  String get phoneTransferScan => 'Altes Telefon scannen';

  @override
  String get phoneTransferConfirmTitle => 'Profil dieses Telefons ersetzen?';

  @override
  String get phoneTransferConfirmMessage =>
      'Das aktuell auf diesem Telefon gespeicherte Profil wird durch die verschlüsselte lokale Übertragung ersetzt.';

  @override
  String get phoneTransferConfirmAction => 'Profil übertragen';

  @override
  String get phoneTransferSuccess => 'Profil erfolgreich übertragen';

  @override
  String get phoneTransferFailed =>
      'Übertragung konnte nicht abgeschlossen werden';

  @override
  String get profileSummaryMeshOnly => 'Nur Mesh';

  @override
  String get profileSummaryMeshInternet => 'Mesh · Internet';

  @override
  String get profileSummaryBackgroundOn => 'läuft im Hintergrund';

  @override
  String profileSummaryTransfersActive(int count) {
    return '$count laufend';
  }

  @override
  String get profileSummaryCardBackup => 'Dateien, Backup';

  @override
  String get chatPlay => 'Abspielen';

  @override
  String get chatPause => 'Pause';

  @override
  String get profileTheme => 'Farbe';

  @override
  String get profileThemeEmerald => 'Smaragd';

  @override
  String get profileThemeIndigo => 'Indigo';

  @override
  String get profileThemeAmber => 'Bernstein';

  @override
  String get profileThemeRose => 'Rose';

  @override
  String get profileThemeFuchsia => 'Fuchsia';

  @override
  String get profileThemeViolet => 'Violett';

  @override
  String get profileThemeOcean => 'Ozean';

  @override
  String get profileThemeSlate => 'Schiefer';

  @override
  String get profileScale => 'Größe der Oberfläche';

  @override
  String get profileScaleSystem => 'System';

  @override
  String get profileGlass => 'Glas';

  @override
  String get profileGlassAuto => 'Automatisch';

  @override
  String get profileGlassFull => 'Voll';

  @override
  String get profileGlassLight => 'Leicht';

  @override
  String get profileGlassHint =>
      '„Leicht“ behält die Tönung und lässt die Unschärfe hinter Feldern weg. „Automatisch“ misst dein Telefon einmal und entscheidet. Auf einem Telefon, das ohnehin mithält, bringt das wenig — es ist für eines, das es nicht tut.';

  @override
  String get mapAlwaysNeeded =>
      'Damit die Karte aktuell bleibt, während cubechat geschlossen ist, muss der Standort auf „Immer“ stehen. Tippe, um die Einstellungen zu öffnen.';

  @override
  String get mapShareConsentTitle => 'Deinen Standort auf der Karte zeigen?';

  @override
  String get mapShareConsentBody =>
      'Dein Live-Standort wird nur den Kontakten auf deiner Karte gezeigt: Personen, die du eingeladen hast oder deren Einladung du angenommen hast. Er wird laufend aktualisiert, auch wenn Cubechat im Hintergrund ist, bis du dich verbirgst. Er ist Ende-zu-Ende-verschlüsselt und erreicht uns nie. Du kannst dich jederzeit auf der Karte oder im Profil verbergen, und blockierte Kontakte sehen dich nie.';

  @override
  String get mapShareConsentAllow => 'Erlauben';

  @override
  String get mapShareConsentDecline => 'Nicht erlauben';

  @override
  String get mapVisibleToFriends => 'Freunde auf deiner Karte sehen dich';

  @override
  String get mapHiddenFromFriends => 'Du bist verborgen';

  @override
  String get mapHideMe => 'Verbergen';

  @override
  String get mapShowMe => 'Mich zeigen';

  @override
  String get profileScaleSmall => 'Kleiner';

  @override
  String get profileScaleNormal => 'Normal';

  @override
  String get profileScaleLarge => 'Größer';

  @override
  String get profileScaleSample =>
      'Text und Zeilen werden in dieser Größe dargestellt.';

  @override
  String get savedTitle => 'Gespeichert';

  @override
  String get savedSubtitle => 'Notizen an dich selbst, auf diesem Gerät';

  @override
  String get savedEmpty =>
      'Alles, was du hier schreibst, bleibt auf diesem Telefon.';

  @override
  String get meshOffTitle => 'Bluetooth-Mesh ist aus';

  @override
  String get meshOffHint =>
      'Niemand in der Nähe kann dich finden, und du findest niemanden. Nachrichten laufen weiter über das Internet-Relay.';

  @override
  String get profileMeshSwitch => 'Bluetooth-Mesh';

  @override
  String get profileMeshSwitchHint =>
      'Personen in der Nähe finden und Nachrichten ohne Internet weitergeben. Aus spart Akku.';

  @override
  String get channelAdminOnlyHint =>
      'Ein Ankündigungskanal. Lesen können ihn weiterhin alle.';

  @override
  String get attachLocation => 'Standort';

  @override
  String get locationBubbleTitle => 'Standort';

  @override
  String get locationOpenInMaps => 'In Karten öffnen';

  @override
  String locationAccuracy(int metres) {
    return 'auf $metres m genau';
  }

  @override
  String get locationExpired => 'Dieser Standort ist nicht mehr aktuell';

  @override
  String get locationDenied => 'Standortberechtigung ist aus';

  @override
  String get locationUnavailable => 'Position konnte nicht ermittelt werden';

  @override
  String get locationShareFor => 'Teilen für';

  @override
  String get locationShareOnce => 'Nur einmal';

  @override
  String get locationShare15m => '15 Minuten';

  @override
  String get locationShare1h => '1 Stunde';

  @override
  String get storageTitle => 'Speicher';

  @override
  String get storageHeadline => 'Speichernutzung';

  @override
  String storageSubtitle(String size) {
    return 'cubechat belegt $size auf diesem Gerät';
  }

  @override
  String get storageEmpty => 'Noch nichts gespeichert';

  @override
  String get storageScanning => 'Wird gemessen…';

  @override
  String get storageCatPhotos => 'Fotos';

  @override
  String get storageCatVoice => 'Sprachnachrichten';

  @override
  String get storageCatFiles => 'Empfangene Dateien';

  @override
  String get storageCatOutbox => 'Gesendete Dateien';

  @override
  String get storageCatStickers => 'Sticker';

  @override
  String get storageCatSaved => 'Gespeicherte Nachrichten';

  @override
  String get storageCatWallpapers => 'Hintergründe';

  @override
  String get storageCatHistory => 'Unterhaltungen und Schlüssel';

  @override
  String get storageCatCache => 'Cache';

  @override
  String storageClear(String size) {
    return '$size freigeben';
  }

  @override
  String get storageClearNothing => 'Nichts ausgewählt';

  @override
  String storageFreed(String size) {
    return '$size freigegeben';
  }

  @override
  String get storageNoCloud =>
      'Dahinter steht keine Cloud. Was du löschst, ist von diesem Telefon weg, und die einzige andere Kopie liegt auf dem Telefon, von dem es kam.';

  @override
  String get storageWhyHistoryLocked =>
      'Unterhaltungen werden nicht hier gelöscht — nutze die Notfall-Löschung.';

  @override
  String get storageRecoveryFree => 'Sicher zu löschen';

  @override
  String get storageRecoveryGone => 'Nirgendwo sonst eine Kopie';

  @override
  String get storageRecoveryAskSender =>
      'Kann erneut beim Absender angefordert werden';

  @override
  String get storageRecoveryCostsThem =>
      'Sie könnten dich nicht mehr um erneutes Senden bitten';

  @override
  String storageConfirmTitle(String size) {
    return '$size freigeben?';
  }

  @override
  String get storageConfirmBody =>
      'Die Dateien werden von diesem Telefon gelöscht. Nichts wird irgendwo hochgeladen, es gibt also nichts, woraus sie sich wiederherstellen ließen.';

  @override
  String storageFilesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Dateien',
      one: '$count Datei',
      zero: 'leer',
    );
    return '$_temp0';
  }

  @override
  String get customizeBarTitle => 'Navigationsleiste';

  @override
  String get customizeBarHint =>
      'Ziehen zum Umsortieren. Chats lassen sich nicht entfernen.';

  @override
  String get customizeBarShown => 'Angezeigt';

  @override
  String get customizeBarHidden => 'Ausgeblendet';

  @override
  String get customizeBarHiddenEmpty => 'Nichts ausgeblendet';

  @override
  String get customizeBarMinimum => 'Mindestens zwei Tabs behalten';

  @override
  String get customizeReset => 'Zurücksetzen';

  @override
  String get chatsArchiveTitle => 'Archiv';

  @override
  String get chatsArchiveEmpty => 'Nichts archiviert';

  @override
  String get chatsArchiveHint =>
      'Archivierte Chats funktionieren weiter — sie sind nur nicht in der Liste.';

  @override
  String get chatsArchivedToast => 'Archiviert';

  @override
  String get chatsUnarchivedToast => 'Wieder in der Liste';

  @override
  String chatsArchiveCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Chats',
      one: '$count Chat',
    );
    return '$_temp0';
  }

  @override
  String get chatsSwipeNotHere => 'Für diesen Chat nicht verfügbar';

  @override
  String get customizeSwipeTitle => 'Chat nach rechts wischen';

  @override
  String get customizeSwipeHint =>
      'Nach links wischen wechselt weiterhin die Tabs.';

  @override
  String get customizeSwipeArchive => 'Archivieren';

  @override
  String get customizeSwipeMute => 'Stumm';

  @override
  String get customizeSwipePin => 'Anheften';

  @override
  String get customizeSwipeRead => 'Gelesen';

  @override
  String get customizeSwipeDelete => 'Löschen';

  @override
  String get customizeSwipeNone => 'Nichts';

  @override
  String get customizeHighRefresh => 'Volle Bildwiederholrate';

  @override
  String get customizeHighRefreshHint =>
      'Flüssiger, dafür zeichnet das Telefon doppelt so viele Bilder. Schalte es aus, wenn es warm wird — am Aussehen der App ändert sich nichts, nur wie oft sie neu gezeichnet wird.';

  @override
  String get customizeQuickReaction => 'Reaktion per Doppeltippen';

  @override
  String get customizeQuickReactionHint =>
      'Was ein Doppeltippen auf eine Nachricht hinterlässt. Nutzt du eine andere, rückt sie hierher.';

  @override
  String get customizeCircleAudioTitle =>
      'Musik für Videonachrichten pausieren';

  @override
  String get customizeCircleAudioOn =>
      'Aufnehmen oder Ansehen stoppt alles andere, was gerade läuft. Es startet nicht von selbst wieder.';

  @override
  String get customizeCircleAudioOff =>
      'Deine Musik läuft darunter weiter, leiser, solange eine Videonachricht läuft.';

  @override
  String get customizeMediaQualityTitle => 'Fotoqualität beim Senden';

  @override
  String get customizeMediaQualityEconomy => 'Sparsam';

  @override
  String get customizeMediaQualityStandard => 'Standard';

  @override
  String get customizeMediaQualityHigh => 'Hoch';

  @override
  String get customizeMediaQualityEconomyHint =>
      'Bis 96 KB pro Foto, 800 px. Für einen Balken Empfang oder ein volles Bluetooth-Mesh: halbe Wartezeit, weicheres Bild.';

  @override
  String get customizeMediaQualityStandardHint =>
      'Bis 192 KB pro Foto, 1280 px. So bemessen, dass es auch allein über Bluetooth durchgeht. Videos und „Original“ werden immer unverändert gesendet.';

  @override
  String get customizeMediaQualityHighHint =>
      'Bis 768 KB pro Foto, 2048 px. Scharf genug zum Zoomen; braucht viermal so lange zum Senden, also am besten im Wi-Fi.';

  @override
  String get previewReacted => 'auf deine Nachricht';

  @override
  String get previewLocation => 'Standort';

  @override
  String get previewMapInvite => 'Karteneinladung';

  @override
  String get previewContact => 'Kontakt';

  @override
  String get previewUnsupported => 'Nicht unterstützte Nachricht';

  @override
  String get previewCallOutgoing => 'Ausgehender Anruf';

  @override
  String get previewCallIncoming => 'Eingehender Anruf';

  @override
  String get previewCallMissed => 'Verpasster Anruf';

  @override
  String chatPreparingPhotos(int count) {
    return '$count Fotos werden vorbereitet…';
  }

  @override
  String get circleSwitchCamera => 'Kamera wechseln';

  @override
  String get circleLight => 'Aufnahmelicht';

  @override
  String get circleCameraSwitchFailed =>
      'Kamera konnte nicht gewechselt werden. Deine Aufnahme ist noch offen.';

  @override
  String get diagnosticsTitle => 'Diagnose';

  @override
  String get diagnosticsIntro =>
      'Was die App zuletzt getan hat. Wenn etwas nicht funktioniert, sende das an den Entwickler.';

  @override
  String get diagnosticsShare => 'Protokoll an Entwickler senden';

  @override
  String get diagnosticsEvents => 'Letzte Ereignisse';

  @override
  String get diagnosticsTechnical => 'Technische Einträge';

  @override
  String get diagnosticsEmpty => 'Noch nichts anzuzeigen.';

  @override
  String get diagnosticsDeveloperOn => 'Entwicklermodus an';

  @override
  String get diagnosticsDeveloperOff => 'Entwicklermodus aus';

  @override
  String get logAppStarted => 'App gestartet';

  @override
  String get logInternetOn => 'Internetverbindung an';

  @override
  String logServerConnected(String host) {
    return 'Mit $host verbunden';
  }

  @override
  String logServerLost(String host) {
    return 'Verbindung zu $host verloren';
  }

  @override
  String get chatSaveAction => 'Speichern';

  @override
  String get savedTagAsk => 'Gespeichert. Tag hinzufügen?';

  @override
  String get savedTagAdd => 'Tag hinzufügen';

  @override
  String get chatSharedWallpaperFailed =>
      'Hintergrund hier gesetzt. Er erreicht die andere Seite, sobald sie in Reichweite ist.';

  @override
  String get chatTranscribeAction => 'Transkribieren';

  @override
  String get chatTranscribeFailed =>
      'Dieses Telefon kann das nicht transkribieren.';

  @override
  String get chatTranscribing => 'Wird erkannt…';

  @override
  String get chatTranscriptHide => 'Text ausblenden';

  @override
  String get chatCancelSend => 'Senden abbrechen';

  @override
  String get chatDownloadAction => 'Herunterladen';

  @override
  String get chatDownloaded => 'Auf dem Telefon gespeichert';

  @override
  String get chatDownloadFailed => 'Speichern fehlgeschlagen';

  @override
  String get selfUpdateTitle => 'Update aus Datei installieren';

  @override
  String get selfUpdateHint =>
      'Wähle die neue cubechat-APK hier aus, statt sie aus einem Chat zu öffnen: So installiert, bleiben Anrufe auf dem Sperrbildschirm aktiv.';

  @override
  String get selfUpdateConfirm =>
      'Bestätige die Installation im Systemfenster.';

  @override
  String get selfUpdateAllow =>
      'Erlaube cubechat, Apps zu installieren, und tippe dann erneut.';

  @override
  String get selfUpdateNotOurs => 'Diese Datei ist kein cubechat-Update.';

  @override
  String get selfUpdateFailed => 'Das Update wurde nicht installiert.';

  @override
  String get chatTranscribeDownloading =>
      'Das Telefon lädt die Sprache dafür herunter. Versuche es in einer Minute erneut.';

  @override
  String get chatTranscribeNoLanguage =>
      'Dieses Telefon hat kein Sprachmodell für diese Sprache. Wähle die Sprache für Sprache-zu-Text unter Profil → Chats & Medien.';

  @override
  String get chatTranscribeNotAllowed =>
      'Spracherkennung ist für CubeChat aus. Schalte sie in den iPhone-Einstellungen → CubeChat ein.';

  @override
  String get customizeTranscribeLanguageTitle => 'Sprache für Sprache-zu-Text';

  @override
  String get customizeTranscribeLanguageAuto => 'Auto';

  @override
  String get customizeTranscribeLanguageHint =>
      'In welcher Sprache die Nachrichten gesprochen werden, das muss nicht die App-Sprache sein. „Auto“ probiert die Sprachen des Telefons. Eine fehlende Sprache lädt das Telefon selbst herunter; die Stimme verlässt es nie.';

  @override
  String get chatTranslateAction => 'Übersetzen';

  @override
  String get chatTranslateFailed =>
      'Das lässt sich auf diesem Telefon nicht übersetzen.';

  @override
  String get customizeDeferMediaTitle => 'Medien erst im Wi-Fi laden';

  @override
  String get customizeDeferMediaHint =>
      'Im Mobilfunknetz funktionieren Texte und Anrufe wie gewohnt, während Fotos, Sprachnachrichten, Videonachrichten und Dateien auf dem Server auf Wi-Fi warten — bis zu zwei Wochen. Eine Zeile über den Chats zeigt, was wartet, und lädt es sofort herunter.';

  @override
  String heldMediaCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Medien warten auf Wi-Fi',
      one: '1 Medium wartet auf Wi-Fi',
    );
    return '$_temp0';
  }

  @override
  String get heldMediaDownload => 'Herunterladen';

  @override
  String get nearbyAirDropSubtitle => 'Dateien mit Personen in der Nähe teilen';

  @override
  String get nearbyFilesSubtitle => 'Gesendete und empfangene Dateien';

  @override
  String get airdropTab => 'AirDrop';

  @override
  String get nearbyTabFiles => 'Dateien';

  @override
  String get airdropReceiveHint => 'Wer dir Dateien senden darf';

  @override
  String get airdropReceiveContacts => 'Kontakte';

  @override
  String get airdropReceiveEveryone => 'Alle 10 Min.';

  @override
  String airdropEveryoneLeft(String time) {
    return 'Alle · $time';
  }

  @override
  String get airdropSendFiles => 'Dateien senden';

  @override
  String get airdropChooseFiles => 'Dateien wählen';

  @override
  String airdropStagedTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Dateien bereit',
      one: '1 Datei bereit',
    );
    return '$_temp0';
  }

  @override
  String get airdropStagedHint =>
      'Mit Bluetooth an und geöffnetem AirDrop auf beiden Telefonen: halte sie aneinander oder wähle eine Person';

  @override
  String get airdropStagedPickPerson => 'Person wählen';

  @override
  String airdropRequestBody(String what, String size) {
    return 'möchte $what senden · $size';
  }

  @override
  String airdropWhatPhotos(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Fotos',
      one: '1 Foto',
    );
    return '$_temp0';
  }

  @override
  String airdropWhatVideos(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Videos',
      one: '1 Video',
    );
    return '$_temp0';
  }

  @override
  String airdropWhatFiles(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Dateien',
      one: '1 Datei',
    );
    return '$_temp0';
  }

  @override
  String get airdropAccept => 'Annehmen';

  @override
  String get airdropDecline => 'Ablehnen';

  @override
  String get airdropWaiting => 'Warte auf Antwort…';

  @override
  String get airdropAccepted => 'Angenommen';

  @override
  String get airdropUnheard =>
      'Nicht empfangen — vielleicht eine alte CubeChat-Version';

  @override
  String get airdropSending => 'Wird gesendet';

  @override
  String get airdropReceiving => 'Wird empfangen';

  @override
  String get airdropInterrupted => 'Unterbrochen';

  @override
  String get airdropRetry => 'Wiederholen';

  @override
  String get airdropOutcomeSent => 'Gesendet';

  @override
  String get airdropOutcomeReceived => 'Empfangen';

  @override
  String get airdropOutcomeDeclined => 'Abgelehnt';

  @override
  String get airdropOutcomeCancelled => 'Abgebrochen';

  @override
  String get airdropOutcomePartial => 'Teilweise';

  @override
  String get airdropReasonNoSpace => 'nicht genug Speicher';

  @override
  String get airdropReasonContactsOnly => 'nur Kontakte';

  @override
  String get airdropReasonBusy => 'beschäftigt';

  @override
  String get airdropReasonTimeout => 'keine Antwort';

  @override
  String get airdropFileDeleted => 'gelöscht';

  @override
  String get airdropHistory => 'Verlauf';

  @override
  String get airdropClearHistory => 'Verlauf leeren';

  @override
  String get airdropEmpty =>
      'Dateien, die du in der Nähe sendest oder empfängst, erscheinen hier';

  @override
  String get airdropPickPerson => 'Senden an';

  @override
  String get airdropNobody => 'Noch niemand mit cubechat in der Nähe';

  @override
  String get airdropNoDirect => 'Keine Bluetooth-Verbindung zu dieser Person';

  @override
  String get airdropNearbyUnknown => 'In der Nähe';

  @override
  String get airdropConnecting => 'Verbinden…';

  @override
  String get airdropConnectFailed => 'Verbindung fehlgeschlagen';

  @override
  String get airdropSlowWarning => 'Über Bluetooth kann das lange dauern';

  @override
  String airdropTooLarge(String name, int limit) {
    return '$name ist größer als $limit MB';
  }

  @override
  String airdropFromLabel(String name) {
    return 'AirDrop · $name';
  }

  @override
  String get airdropWrite => 'Schreiben';

  @override
  String get airdropAction => 'AirDrop';

  @override
  String get airdropLaneTitle => 'Kanal';

  @override
  String get airdropLaneAuto => 'Auto';

  @override
  String get airdropLaneBluetooth => 'Bluetooth';

  @override
  String get airdropLaneWifi => 'Wi‑Fi';

  @override
  String get airdropBluetoothNeededHint =>
      'Schalte Bluetooth auf beiden Telefonen ein, damit sie sich finden und eine Übertragung bestätigen können.';

  @override
  String get airdropLaneHint =>
      'Bluetooth findet und verbindet die Telefone. Wi‑Fi überträgt Dateien, wenn beide Telefone im selben Netz oder Hotspot sind.';

  @override
  String get airdropWifiUnreachable => 'Nicht im selben Netz';

  @override
  String get airdropWifiOldVersion =>
      'Ihre App kann noch nicht über Wi‑Fi empfangen';

  @override
  String get airdropBumpAdd => 'Hinzufügen';

  @override
  String get airdropBumpAlreadyContact => 'Schon in deinen Kontakten';

  @override
  String airdropBumpSending(String name) {
    return 'Sende an $name';
  }

  @override
  String airdropBumpReceiving(String name) {
    return '$name sendet dir Dateien';
  }

  @override
  String get termsTitle => 'cubechat-Regeln';

  @override
  String get termsBody =>
      'cubechat duldet keinerlei anstößige Inhalte und missbräuchliche Nutzer. Wenn du fortfährst, stimmst du zu, keine Belästigung, Drohungen, sexuellen Inhalte mit Minderjährigen, keinen Spam und nichts Illegales zu senden. Jeder kann eine Nachricht oder eine Person melden; Meldungen gehen an den Entwickler und werden innerhalb von 24 Stunden bearbeitet, und Täter werden gesperrt.';

  @override
  String get termsReadFull => 'Vollständige Bedingungen';

  @override
  String get termsAccept => 'Ich stimme zu';

  @override
  String get messageHide => 'Ausblenden';

  @override
  String get messageHidden => 'Für dich ausgeblendet';

  @override
  String get reportAction => 'Melden';

  @override
  String get reportTitle => 'Was ist los?';

  @override
  String get reportReasonSpam => 'Spam';

  @override
  String get reportReasonAbuse => 'Beleidigung oder Belästigung';

  @override
  String get reportReasonViolence => 'Gewalt';

  @override
  String get reportReasonSexual => 'Sexuelle Inhalte';

  @override
  String get reportReasonOther => 'Sonstiges';

  @override
  String get reportNoteHint => 'Beschreiben (optional)';

  @override
  String get reportSend => 'Meldung senden';

  @override
  String get reportDisclosure =>
      'Der ausgewählte Nachrichtentext und deine Meldung gehen an die cubechat-Moderation und ihren privaten Telegram-Bot.';

  @override
  String get reportSent =>
      'Meldung gesendet. Wir prüfen Meldungen innerhalb von 24 Stunden.';

  @override
  String get reportBlockedToo => 'Die Person ist für dich blockiert.';

  @override
  String get reportQueued =>
      'Meldung gespeichert. Sie wird gesendet, sobald du online bist.';

  @override
  String get reportFailed => 'Meldung konnte nicht gesendet werden.';

  @override
  String get filteredMessage => 'Vom Filter ausgeblendet';

  @override
  String get filteredShow => 'Zeigen';

  @override
  String get filterToggle => 'Filter für anstößige Inhalte';

  @override
  String get filterToggleHint =>
      'Blendet grobe Wörter von Fremden und in Kanälen aus';

  @override
  String get aboutTitle => 'Über';

  @override
  String get aboutContact => 'E-Mail an den Entwickler';

  @override
  String get aboutReport => 'Verstoß melden';

  @override
  String get aboutTerms => 'Nutzungsbedingungen';

  @override
  String get aboutPrivacy => 'Datenschutzerklärung';

  @override
  String get requestsTitle => 'Anfragen';

  @override
  String get requestsEmpty => 'Keine Anfragen';

  @override
  String requestBanner(String name) {
    return '$name ist nicht in deinen Kontakten. Bis du annimmst, sieht diese Person nicht, dass du das gelesen hast, und kann dich nicht anrufen.';
  }

  @override
  String get requestAccept => 'Annehmen';

  @override
  String get requestDelete => 'Löschen';

  @override
  String get requestBlock => 'Blockieren';

  @override
  String get cubeIdTitle => 'Cube ID';

  @override
  String get cubeIdExplainer =>
      'Dein @Name verweist auf deine Kontaktkarte. Der Server speichert nur den Namen und deine öffentliche Karte — nie deine Nachrichten.';

  @override
  String get cubeIdFieldHint => 'a–z, 0–9 und _, 3–20 Zeichen';

  @override
  String get cubeIdAvailable => 'Verfügbar';

  @override
  String get cubeIdTaken => 'Vergeben';

  @override
  String get cubeIdReserved => 'Nicht erlaubt';

  @override
  String get cubeIdInvalid => 'Nur a–z, 0–9 und _, 3–20 Zeichen';

  @override
  String get cubeIdClaim => 'Namen sichern';

  @override
  String get cubeIdWorking => 'Name wird gesichert…';

  @override
  String get cubeIdChange => 'Ändern';

  @override
  String get cubeIdEmail => 'E-Mail zur Wiederherstellung';

  @override
  String get cubeIdEmailHint =>
      'Geht dieses Telefon verloren, bekommst du den Namen per Mail an diese Adresse zurück';

  @override
  String get cubeIdEmailField => 'E-Mail';

  @override
  String cubeIdEmailSent(String email) {
    return 'Eine Mail ging an $email. Öffne den Link darin.';
  }

  @override
  String get cubeIdEmailRemove => 'E-Mail entfernen';

  @override
  String get cubeIdEmailUnavailable =>
      'E-Mail ist gerade nicht verfügbar. Versuche es später.';

  @override
  String get cubeIdEmailInvalid =>
      'Das sieht nicht nach einer E-Mail-Adresse aus';

  @override
  String get cubeIdSave => 'Speichern';

  @override
  String get cubeIdRecover => 'Namen per E-Mail wiederherstellen';

  @override
  String get cubeIdRecoverSent =>
      'Wenn die Adresse passt, kommt eine Mail. Der Name wechselt 48 Stunden nach dem Öffnen des Links auf dieses Telefon.';

  @override
  String cubeIdRecoveryWarning(String name, String when) {
    return 'Jemand stellt @$name auf einem anderen Telefon per E-Mail wieder her. Der Name wechselt am $when, wenn du nicht abbrichst.';
  }

  @override
  String get cubeIdRecoveryCancel => 'Wiederherstellung abbrechen';

  @override
  String get cubeIdRecoveryCancelled => 'Wiederherstellung abgebrochen';

  @override
  String get cubeIdRelease => 'Freigeben';

  @override
  String cubeIdReleaseConfirm(String name) {
    return '@$name freigeben? Dann kann jeder den Namen nehmen.';
  }

  @override
  String get cubeIdShare => 'Teilen';

  @override
  String cubeIdShareText(String name) {
    return 'Finde mich in cubechat: @$name\nhttps://cubechat.tech/u.html#$name';
  }

  @override
  String get cubeIdFailed =>
      'Name konnte nicht gespeichert werden. Versuche es erneut.';

  @override
  String get cubeIdOffline => 'Kein Internet';

  @override
  String get lookupNotFound => 'Niemand mit diesem @Namen';

  @override
  String searchFindCubeName(String name) {
    return '@$name finden';
  }

  @override
  String get searchFindCubeNameHint => 'In Cube ID suchen und hinzufügen';

  @override
  String get addContactHintName => 'Karte einfügen oder @Name eingeben';

  @override
  String get strangerReachTitle => 'Wer mir übers Internet schreiben darf';

  @override
  String get strangerReachAll => 'Alle';

  @override
  String get strangerReachRequest => 'Mit Anfrage';

  @override
  String get strangerReachNone => 'Niemand';

  @override
  String get strangerReachHint =>
      'Für Personen, denen du noch nicht geschrieben hast und die dich übers Internet erreichen. Personen in der Nähe über Bluetooth sind nicht betroffen.';

  @override
  String get sectionPrivacy => 'Datenschutz & Sicherheit';

  @override
  String get sectionNotifications => 'Mitteilungen & Anrufe';

  @override
  String get sectionConnection => 'Verbindung';

  @override
  String get sectionChats => 'Chats & Medien';

  @override
  String get sectionAppearance => 'Darstellung';

  @override
  String get sectionData => 'Daten & Speicher';

  @override
  String get sectionAbout => 'Über';

  @override
  String get subWhoSeesMe => 'Wer mich sieht';

  @override
  String get subProtection => 'Schutz';

  @override
  String get subNotifications => 'Mitteilungen';

  @override
  String get subCalls => 'Anrufe';

  @override
  String get profileDiscoverableMeshOff =>
      'Bluetooth-Mesh ist aus — schalte es unter Verbindung ein.';

  @override
  String get chatRouteBluetoothDirect => 'Bluetooth, direkt';

  @override
  String chatRouteMeshHops(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Mesh · $n Hops',
      one: 'Mesh · $n Hop',
    );
    return '$_temp0';
  }

  @override
  String chatRouteDeliveredVia(String route) {
    return 'Zugestellt: $route';
  }

  @override
  String chatRouteReceivedVia(String route) {
    return 'Empfangen: $route';
  }

  @override
  String get chatUnreadDivider => 'Neue Nachrichten';

  @override
  String get radioTitle => 'Funkgerät';

  @override
  String get radioNearbySubtitle =>
      'Taste halten und mit einer Gruppe oder einem Kontakt sprechen';

  @override
  String get radioGroupsLabel => 'Gruppen';

  @override
  String get radioDirectLabel => 'Direkt';

  @override
  String get radioAddGroup => 'Funk hinzufügen';

  @override
  String get radioNoGroups =>
      'Noch kein Funk. Füge einen hinzu — alle, die denselben Namen und dasselbe Passwort eingeben, hören einander.';

  @override
  String get radioLeave => 'Diesen Funk verlassen';

  @override
  String get radioPickChannel => 'Wähle eine Gruppe oder einen Kontakt';

  @override
  String get radioPushToTalk => 'Halten zum Sprechen';

  @override
  String get radioTalking => 'Sprich…';

  @override
  String get radioChannelBusy => 'Kanal belegt';

  @override
  String radioSpeaker(String name) {
    return '$name spricht';
  }

  @override
  String get radioSilentTitle => 'Im Lautlos-Modus sprechen';

  @override
  String get radioSilentHint =>
      'Die Stimme ist auch zu hören, wenn das Telefon lautlos ist.';

  @override
  String get radioJoinNameLabel => 'Name';

  @override
  String get radioJoinPasswordLabel => 'Passwort (optional)';

  @override
  String get radioJoinHint =>
      'Alle, die denselben Namen und dasselbe Passwort eingeben, sind im selben Funk. Kein Server führt eine Liste davon.';

  @override
  String get radioJoinNameRequired => 'Gib einen Namen ein';

  @override
  String get radioJoinSubmit => 'Hinzufügen';

  @override
  String get radioBlockedTooLong => 'Nach einer Minute Sprechen abgebrochen';

  @override
  String get radioBlockedCall => 'Ein Anruf läuft';

  @override
  String get radioBlockedMicrophone => 'Kein Zugriff auf das Mikrofon';

  @override
  String get radioBlockedUnavailable =>
      'Der Funk ist auf diesem Gerät nicht verfügbar';

  @override
  String get radioBlockedNoChannel =>
      'Wähle zuerst eine Gruppe oder einen Kontakt';

  @override
  String get radioTurnOff => 'Funk ausschalten';

  @override
  String get radioPersonalCallsTitle => 'Persönliche Rufe annehmen';

  @override
  String get radioPersonalCallsHint =>
      'Ist der Funk aus, stellt ein Kontakt, der mit dir spricht, ihn auf sich ein.';

  @override
  String get radioBackgroundHint =>
      'Bei ausgeschaltetem Bildschirm ist der Funk nur zu hören, wenn der Hintergrundmodus an ist.';

  @override
  String get areaNearby => 'Chat in der Nähe';

  @override
  String get areaLevelDistrict => 'Viertel';

  @override
  String get areaLevelCity => 'Stadt';

  @override
  String get areaLevelRegion => 'Region';

  @override
  String areaPresentCount(int count) {
    return '≈$count hier';
  }

  @override
  String get areaPresentMany => '50+ hier';

  @override
  String get areaBlockViaBluetooth => 'Dein Block — über Bluetooth';

  @override
  String get areaOpenNearbyTab => '„In der Nähe“ öffnen';

  @override
  String get areaLocating => 'Dein Viertel wird gesucht…';

  @override
  String get areaNoPlace =>
      'Noch kein Standort. Der Gebietschat braucht deinen ungefähren Standort, solange dieser Bildschirm offen ist.';

  @override
  String get areaLocationDenied =>
      'Standort ist für Cubechat aus. Erlaube den ungefähren Standort in den Einstellungen, um dein Viertel zu sehen.';

  @override
  String get areaOffline => 'Keine Verbindung zum Gebietschat';

  @override
  String get areaEmpty =>
      'Hier hat in den letzten 24 Stunden niemand geschrieben.';

  @override
  String get areaConsentTitle => 'Der Gebietschat ist öffentlich';

  @override
  String get areaConsentBody =>
      'Nachrichten hier sind öffentlich. Jeder, der dein Viertel oder deine Stadt öffnet, kann sie lesen, und sie werden 24 Stunden auf dem Cubechat-Server gespeichert. Du schreibst unter einem temporären Namen, der sich alle paar Stunden ändert; niemand sieht deinen @Namen oder deine Kontakte. Um dein Viertel zu kennen, fragt Cubechat nach deinem ungefähren Standort, nur solange dieser Bildschirm offen ist.';

  @override
  String get areaConsentAllow => 'Weiter';

  @override
  String get areaConsentDecline => 'Nicht jetzt';

  @override
  String areaDefaultName(String tag) {
    return 'Cube-$tag';
  }

  @override
  String areaYouAre(String name, int hours) {
    return 'Du bist $name · neuer Name in $hours Std.';
  }

  @override
  String get areaNewName => 'Neuer Name';

  @override
  String get areaSetName => 'Namen wählen';

  @override
  String get areaNameHint =>
      'Nur für die paar Stunden dieses Namens. Leer lassen für den automatischen.';

  @override
  String get areaNameSameWarning =>
      'Derselbe Name verknüpft dich über Viertel hinweg';

  @override
  String get areaShowPresence => 'Zeigen, dass ich hier bin';

  @override
  String get areaPresenceOffHint =>
      'Schalte „Zeigen, dass ich hier bin“ ein, um zu sehen, wie viele Leute in der Nähe sind';

  @override
  String get areaReadOnly => 'Du kannst nur dort schreiben, wo du bist';

  @override
  String get areaComposerHint => 'Nachricht an alle hier';

  @override
  String get areaSend => 'Senden';

  @override
  String get areaWaitALittle => 'Warte kurz';

  @override
  String areaFlood(int count) {
    return 'Flut ($count) · Zeigen';
  }

  @override
  String get areaReply => 'Antworten';

  @override
  String get areaHide => 'Ausblenden';

  @override
  String get areaBlock => 'Blockieren bis zur Namensänderung';

  @override
  String get areaBlocked => 'Blockiert bis zur Namensänderung';

  @override
  String get areaReport => 'Melden';

  @override
  String get areaOpenLink => 'Link öffnen';

  @override
  String areaOpenLinkConfirm(String url) {
    return '$url öffnen?';
  }

  @override
  String get areaOpen => 'Öffnen';

  @override
  String get areaReadHere => 'Hier lesen';

  @override
  String get areaReadHereHint =>
      'Nur lesen. Schreiben kannst du nur dort, wo du bist; das Relay erfährt, welchen Ort du liest.';

  @override
  String get areaNotes => 'Notizen';

  @override
  String areaNotesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Notizen',
      one: '$count Notiz',
      zero: 'Keine Notizen',
    );
    return '$_temp0';
  }

  @override
  String get areaLeaveNote => 'Notiz hinterlassen';

  @override
  String get areaNoteHint => 'Eine kurze Notiz für deine Stadt';

  @override
  String get areaNoteLifetime => 'Hält für';

  @override
  String get areaNote1h => '1 Std.';

  @override
  String get areaNote24h => '24 Std.';

  @override
  String get areaNote7d => '7 Tage';

  @override
  String get areaPinToDistrict => 'An Viertel heften';

  @override
  String get areaPinHint =>
      'Tippe auf die Karte innerhalb deiner Stadt; der Pin rastet in sein Viertel ein.';

  @override
  String get areaPinOutside => 'Nur innerhalb deiner Stadt';

  @override
  String get areaNoteDelete => 'Meine Notiz löschen';

  @override
  String get areaNoNotes => 'Hier noch keine Notizen';

  @override
  String get areaNotesLimit => 'Drei Notizen pro Tag';

  @override
  String get areaNoteLeft => 'Notiz hinterlegt';

  @override
  String get areaNoteSend => 'Hinterlassen';

  @override
  String get areaOwnNote => 'Deine Notiz';

  @override
  String get areaNotePinned => 'An ein Viertel geheftet';

  @override
  String get areaHidden => 'Ausgeblendet';

  @override
  String get areaPublicBadge => 'Öffentlich · 24 Std. gespeichert';

  @override
  String get areaSettingTitle => 'Gebietschat';

  @override
  String get areaSettingOnHint =>
      'Die Schaltfläche „Chat in der Nähe“ auf der Karte: öffentliche Chats deines Viertels und deiner Stadt, unter einem temporären Namen.';

  @override
  String get areaSettingOffHint =>
      'Aus: keine Schaltfläche auf der Karte, und der Gebietschat fragt nie nach deinem Standort und verbindet sich nie.';

  @override
  String get wallpaperPhotoLocalOnly =>
      'Fotohintergründe gibt es vorerst nur lokal';

  @override
  String get wallpaperSavedNoRoute =>
      'Hier gespeichert. Gerade gibt es keine Route zum Gegenüber';

  @override
  String get wallpaperScopeTitle => 'Wer soll diesen Hintergrund sehen?';

  @override
  String get wallpaperScopeChannel => 'Ganzer Kanal';

  @override
  String get wallpaperScopeBoth => 'Ich und mein Gegenüber';

  @override
  String get wallpaperScopeLocal => 'Nur bei mir';

  @override
  String get wallpaperScopeSharedHint =>
      'Wird als verschlüsseltes Steuerpaket gesendet';

  @override
  String get wallpaperScopePhotoHint =>
      'Fotos bleiben vorerst nur auf diesem Telefon';

  @override
  String get foldersCreate => 'Ordner erstellen';

  @override
  String get foldersYours => 'Deine Ordner';

  @override
  String get foldersSmartFilters => 'Intelligente Filter';

  @override
  String get foldersName => 'Ordnername';

  @override
  String get foldersSave => 'Speichern';

  @override
  String get foldersDeleteTitle => 'Ordner löschen?';

  @override
  String get foldersDelete => 'Löschen';

  @override
  String get foldersCreateAction => 'Erstellen';

  @override
  String get chatsArchiveHiddenToast =>
      'Archiv ausgeblendet. Zurückholen unter „Darstellung“.';

  @override
  String get chatsBulkPin => 'Anheften';

  @override
  String get chatsBulkMute => 'Stumm';

  @override
  String get chatsUnarchive => 'Aus Archiv holen';

  @override
  String get chatsAddToFolder => 'Zu Ordner hinzufügen';

  @override
  String get chatsMarkUnread => 'Als ungelesen markieren';

  @override
  String get chatsClearHistory => 'Chatverlauf leeren';

  @override
  String get foldersNew => 'Neuer Ordner';

  @override
  String get foldersNameHint => 'Freunde';

  @override
  String get chatsNoIncoming => 'Keine eingehenden Nachrichten';

  @override
  String get chatsMarkedUnread => 'Als ungelesen markiert';

  @override
  String get chatsClearHistoryTitle => 'Chatverlauf leeren?';

  @override
  String get chatsClearHistoryBody =>
      'Nachrichten werden nur auf diesem Gerät gelöscht. Chat, Kontakt und Favoriten bleiben.';

  @override
  String get chatsClearHistoryAction => 'Leeren';

  @override
  String get chatsHistoryCleared => 'Verlauf geleert';

  @override
  String get savedTagMenuTag => 'Tag';

  @override
  String get savedTagRemove => 'Tag entfernen';

  @override
  String get customizeArchiveRowTitle => 'Archivzeile';

  @override
  String get customizeArchiveRowHint =>
      'Über der Chatliste anzeigen. Archivierte Chats empfangen so oder so weiter.';

  @override
  String get mapLayerStandard => 'Standard';

  @override
  String get mapLayerStandardHint => 'Helle Straßenkarte — die stabilste Wahl';
}
