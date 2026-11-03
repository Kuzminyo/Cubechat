// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Romanian Moldavian Moldovan (`ro`).
class AppLocalizationsRo extends AppLocalizations {
  AppLocalizationsRo([String locale = 'ro']) : super(locale);

  @override
  String get callVoice => 'Apel vocal';

  @override
  String get callVideo => 'Apel video';

  @override
  String get callIncomingVideo => 'Apel video primit';

  @override
  String get callCamera => 'Cameră';

  @override
  String get callFlipCamera => 'Întoarce';

  @override
  String get contactProfileVideo => 'Video';

  @override
  String get callPreparing => 'Se pregătește microfonul…';

  @override
  String get callDialing => 'Se apelează…';

  @override
  String get callRinging => 'Sună…';

  @override
  String get callConnecting => 'Se conectează…';

  @override
  String get callMicrophoneRequired =>
      'Permite accesul la microfon din setările sistemului pentru a efectua apeluri.';

  @override
  String get callMicrophoneWindows =>
      'Windows nu a dat acces CubeChat la microfon. Activează Setări → Confidențialitate și securitate → Microfon → „Permiteți aplicațiilor desktop să vă acceseze microfonul”.';

  @override
  String get callElsewhere =>
      'Un apel este deja în curs pe alt dispozitiv al acestui cont.';

  @override
  String get callRelayUnavailable =>
      'Serverul de apeluri nu e disponibil. Încearcă din nou mai târziu.';

  @override
  String get callBusy => 'Ocupat';

  @override
  String get callNoAnswer => 'Niciun răspuns';

  @override
  String get callFailed => 'Apelul nu a putut fi conectat';

  @override
  String get callDeclined => 'Apel respins';

  @override
  String get callEnded => 'Apel încheiat';

  @override
  String get callMicrophone => 'Microfon';

  @override
  String get callSpeaker => 'Difuzor';

  @override
  String get callAnswer => 'Răspunde';

  @override
  String get callDecline => 'Respinge';

  @override
  String get callEnd => 'Închide';

  @override
  String get callClose => 'Închide';

  @override
  String get callMinimize => 'Minimizează';

  @override
  String get callAudioOutput => 'Sunet apel';

  @override
  String get callRoutePhone => 'Telefon';

  @override
  String get callRouteBluetooth => 'Bluetooth';

  @override
  String get callRouteHeadphones => 'Căști';

  @override
  String get callFullScreenTitle => 'Apeluri pe ecranul de blocare';

  @override
  String get callFullScreenBody =>
      'Permite afișarea apelurilor primite pe ecranul blocat, ca să poți răspunde fără deblocare.';

  @override
  String get callFullScreenXiaomi =>
      'Xiaomi, Redmi și Poco nu permit aplicațiilor să activeze singure asta: activează „Afișare pe ecranul de blocare” la Alte permisiuni.';

  @override
  String get circleMessage => 'Mesaj video';

  @override
  String get appName => 'Cubechat';

  @override
  String get navChats => 'Chaturi';

  @override
  String get navPeers => 'Aproape';

  @override
  String get navProfile => 'Profil';

  @override
  String get navContacts => 'Contacte';

  @override
  String get navMap => 'Hartă';

  @override
  String get mapTitle => 'Hartă';

  @override
  String get mapFriendsTitle => 'Persoane pe hartă';

  @override
  String get mapFriendsHint => 'Doar aceste contacte primesc poziția ta';

  @override
  String mapClusterTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count de persoane aici',
      few: '$count persoane aici',
      one: '$count persoană aici',
    );
    return '$_temp0';
  }

  @override
  String get mapClusterHint => 'Atinge o persoană ca harta să se mute la ea';

  @override
  String get mapNorthUp => 'Nordul în sus';

  @override
  String get mapLayerTitle => 'Stil hartă';

  @override
  String get mapLayerHint => 'Pe ce sunt desenate marcajele';

  @override
  String get mapLayerDark => 'Întunecată';

  @override
  String get mapLayerDarkHint =>
      'Străzi, fără etichete — cel mai discret fundal pentru marcaje';

  @override
  String get mapLayerSatellite => 'Satelit';

  @override
  String get mapLayerSatelliteHint => 'Imagini aeriene: ce clădire, ce curte';

  @override
  String get mapLayerTerrain => 'Relief';

  @override
  String get mapLayerTerrainHint =>
      'Curbe de nivel și relief, pentru dealuri și trasee';

  @override
  String get mapFriendsEmpty => 'Încă nimeni nu partajează harta cu tine.';

  @override
  String get mapFriendsEmptyHint =>
      'Invită un contact și va apărea aici după ce acceptă.';

  @override
  String get mapFriendsInvite => 'Invită';

  @override
  String get mapFriendsRemove => 'Elimină de pe hartă';

  @override
  String mapFriendsRemoved(String name) {
    return '$name nu mai partajează harta cu tine';
  }

  @override
  String get mapFriendsLive => 'Acum pe hartă';

  @override
  String get mapFriendsIdle => 'Fără poziție acum';

  @override
  String get mapInviteTitle => 'Invită pe hartă';

  @override
  String get mapInviteHint => 'Alege unul sau mai multe chaturi';

  @override
  String get mapInviteEmpty => 'Încă nu există chaturi pentru invitații.';

  @override
  String mapInviteAction(int count) {
    return 'Trimite ($count)';
  }

  @override
  String get mapInviteMessage =>
      'Invitație pe harta Cubechat. Trimite-ți locația în acest chat ca să apari pe hartă.';

  @override
  String mapInviteSent(int count) {
    return 'Invitații trimise: $count';
  }

  @override
  String get mapInviteFailed => 'Invitațiile nu au putut fi trimise';

  @override
  String mapPeopleVisible(int count) {
    return 'Locații partajate: $count';
  }

  @override
  String get mapCenterMe => 'Centrează pe mine';

  @override
  String get mapNoSharedLocations => 'Încă nicio locație partajată';

  @override
  String get mapNoSharedLocationsHint =>
      'Un contact apare aici după ce trimite o locație în chat.';

  @override
  String get mapWebHintTitle => 'Conexiuni în apropiere';

  @override
  String get mapWebHint => 'Liniile arată apropierea, nu ruta mesajului.';

  @override
  String get mapOpenProfile => 'Profil';

  @override
  String get mapLocationPrivacyOff => 'Locația pe hartă e ascunsă';

  @override
  String get mapLocationPrivacyOffHint =>
      'Activează „Arată-mă pe hartă” la Confidențialitate ca să-ți afișezi marcajul.';

  @override
  String get mapYouOnMap => 'Poziția ta e vizibilă pe acest dispozitiv';

  @override
  String get locationSharingDisabled =>
      'Activează mai întâi „Arată-mă pe hartă” la Confidențialitate.';

  @override
  String get mapLocationDenied => 'Accesul la locație e dezactivat';

  @override
  String get mapLocationServiceOff =>
      'Activează serviciile de localizare ca să apari';

  @override
  String get mapLocationUnavailable => 'Locația ta nu a putut fi determinată';

  @override
  String get mapDistanceUnknown => 'Distanță indisponibilă';

  @override
  String mapDistanceMetres(int metres) {
    return 'la $metres m';
  }

  @override
  String mapDistanceKilometres(String kilometres) {
    return 'la $kilometres km';
  }

  @override
  String get mapUpdatedNow => 'partajată chiar acum';

  @override
  String mapUpdatedMinutes(int minutes) {
    return 'partajată acum $minutes min';
  }

  @override
  String mapUpdatedHours(int hours) {
    return 'partajată acum $hours h';
  }

  @override
  String get contactsTitle => 'Contacte';

  @override
  String get contactsSubtitle => 'Toți cei cărora le-ai scris';

  @override
  String get contactsSearchHint => 'Caută contacte…';

  @override
  String get contactsEmptyTitle => 'Încă niciun contact';

  @override
  String get contactsEmptyHint =>
      'Începe o conversație și persoana va apărea aici.';

  @override
  String get contactsSearchEmpty => 'Niciun contact găsit';

  @override
  String get contactsTabContacts => 'Contacte';

  @override
  String get contactsTabCalls => 'Apeluri';

  @override
  String get callsFilterAll => 'Toate';

  @override
  String get callsFilterMissed => 'Pierdute';

  @override
  String get callsEmptyTitle => 'Încă niciun apel';

  @override
  String get callsEmptyHint =>
      'Apelurile primite, efectuate și pierdute vor apărea aici.';

  @override
  String get callsMissedEmpty => 'Niciun apel pierdut';

  @override
  String get callsCallBack => 'Sună';

  @override
  String get contactProfileChat => 'Chat';

  @override
  String get contactProfileCall => 'Apel';

  @override
  String get contactProfileRadio => 'Stație';

  @override
  String get contactProfileSecurity => 'Securitate';

  @override
  String get contactProfileActions => 'Acțiuni contact';

  @override
  String get contactProfileVerify => 'Verifică';

  @override
  String get contactProfileCopyId => 'Copiază ID-ul contactului';

  @override
  String get contactProfileIdCopied => 'ID-ul contactului a fost copiat';

  @override
  String get contactProfileId => 'ID contact';

  @override
  String get contactProfileVerifyHint =>
      'Compară amprentele de criptare ca să confirmi identitatea acestei persoane.';

  @override
  String get chatsTitle => 'Chaturi';

  @override
  String get chatsSubtitle => 'Mesh · criptare integrală';

  @override
  String get chatsEmptyTitle => 'Încă nicio conversație';

  @override
  String get chatsEmptyHint =>
      'Deschide o persoană din fila În apropiere ca să începi un chat.';

  @override
  String get chatsFilterAll => 'Toate';

  @override
  String get chatsFilterUnread => 'Necitite';

  @override
  String get chatsFilterMesh => 'Mesh';

  @override
  String get chatsFilterFavorites => 'Favorite';

  @override
  String get chatsFolderDirect => 'Personale';

  @override
  String get chatsFolderChannels => 'Canale';

  @override
  String get chatsFolderOnline => 'Accesibile';

  @override
  String get chatsFoldersTitle => 'Dosare';

  @override
  String get chatsFoldersHint =>
      'Dosarele sunt filtre ale acestei liste, nu locuri în care se mută chaturile. Activează-le pe cele pe care le vrei deasupra chaturilor.';

  @override
  String get chatsSearchHint => 'Caută chaturi…';

  @override
  String get chatsStatusViaMesh => 'prin mesh';

  @override
  String get chatsStatusOffline => 'offline';

  @override
  String get peerKeyRotated => 'cheie schimbată — verifică din nou';

  @override
  String get peersTitle => 'În apropiere';

  @override
  String get peersSubtitle => 'Dispozitive în raza Bluetooth';

  @override
  String get peersEmpty => 'Se caută persoane…';

  @override
  String peersHopsOne(int n) {
    return 'la $n salt';
  }

  @override
  String peersHopsOther(int n) {
    return 'la $n salturi';
  }

  @override
  String get blePermissionTitle => 'E necesară permisiunea Bluetooth';

  @override
  String get blePermissionHint =>
      'Cubechat folosește Bluetooth ca să găsească persoane și să trimită mesaje — fără internet.';

  @override
  String get blePermissionGrant => 'Acordă permisiunea';

  @override
  String get blePermissionOpenSettings => 'Deschide setările';

  @override
  String get blePermissionDeniedHint =>
      'Permisiunea a fost refuzată. Deschide setările ca să permiți accesul la Bluetooth.';

  @override
  String get bleAdapterOffTitle => 'Bluetooth e dezactivat';

  @override
  String get bleAdapterOffHint =>
      'Activează Bluetooth ca să vezi persoanele din apropiere.';

  @override
  String get bleUnsupportedTitle => 'Bluetooth LE nu e disponibil';

  @override
  String get bleUnsupportedHint =>
      'Acest dispozitiv sau această platformă nu oferă Bluetooth Low Energy. Încearcă pe un telefon.';

  @override
  String get bleScanning => 'Se scanează…';

  @override
  String get bleRetry => 'Reîncearcă';

  @override
  String get bleEnable => 'Activează';

  @override
  String get bleConnectFailed =>
      'Conectarea a eșuat. Persoana poate fi în afara razei sau adresa ei Bluetooth s-a schimbat.';

  @override
  String get bleSignal => 'Semnal';

  @override
  String get bleConnect => 'Conectează';

  @override
  String get bleConnected => 'Conectat';

  @override
  String get bleVerified => 'Verificat';

  @override
  String get editorAdjustBrightness => 'Luminozitate';

  @override
  String get editorAdjustContrast => 'Contrast';

  @override
  String get editorAdjustSaturation => 'Saturație';

  @override
  String get editorToolCrop => 'Decupează';

  @override
  String get editorToolDraw => 'Desen';

  @override
  String get editorToolAdjust => 'Ajustări';

  @override
  String get editorTabSticker => 'Sticker';

  @override
  String get editorTabText => 'Text';

  @override
  String get editorPenPen => 'Pix';

  @override
  String get editorPenMarker => 'Marker';

  @override
  String get editorPenNeon => 'Neon';

  @override
  String get editorPenArrow => 'Săgeată';

  @override
  String get editorPenBlur => 'Estompare';

  @override
  String get editorPenEraser => 'Radieră';

  @override
  String get editorLevel => 'Aliniază';

  @override
  String get editorTextHint => 'Text pe fotografie';

  @override
  String get editorCropFree => 'Liber';

  @override
  String get editorRemove => 'Elimină';

  @override
  String get notificationUnknownSender => 'Mesaj nou';

  @override
  String get bleUnknownPeer => 'Dispozitiv necunoscut';

  @override
  String get bleBroadcasting => 'Emite';

  @override
  String bleConnectedCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n de dispozitive centrale conectate',
      few: '$n dispozitive centrale conectate',
      one: '1 dispozitiv central conectat',
      zero: 'Niciun dispozitiv central',
    );
    return '$_temp0';
  }

  @override
  String get verifyTitle => 'Verificare';

  @override
  String get verifyIntro =>
      'Compară aceste două amprente cu interlocutorul, față în față sau într-un apel vocal. Dacă se potrivesc pe ambele părți, ai confirmat că handshake-ul Noise nu a fost compromis.';

  @override
  String get verifyMine => 'AMPRENTA TA';

  @override
  String verifyTheirs(String name) {
    return 'AMPRENTA LUI $name';
  }

  @override
  String get verifyMarkAsVerified => 'Marchează ca verificat';

  @override
  String get verifyAlreadyDone => 'Această persoană este verificată.';

  @override
  String get verifyRevoke => 'Revocă';

  @override
  String verifyDoneSnack(String name) {
    return '$name a fost marcat ca verificat';
  }

  @override
  String get chatInputHint => 'Mesaj';

  @override
  String get chatSend => 'Trimite';

  @override
  String get chatToday => 'Azi';

  @override
  String get chatYesterday => 'Ieri';

  @override
  String get chatDelivered => 'Livrat';

  @override
  String get chatRead => 'Citit';

  @override
  String get chatSending => 'Se trimite';

  @override
  String get chatWaitingForConnection => 'Așteaptă conexiunea';

  @override
  String sendQueueCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count de mesaje așteaptă conexiunea',
      few: '$count mesaje așteaptă conexiunea',
      one: '1 mesaj așteaptă conexiunea',
    );
    return '$_temp0';
  }

  @override
  String sendQueueSlowNetwork(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Rețea lentă — se trimit $count de mesaje',
      few: 'Rețea lentă — se trimit $count mesaje',
      one: 'Rețea lentă — se trimite 1 mesaj',
    );
    return '$_temp0';
  }

  @override
  String get sendQueueTitle => 'Așteaptă trimiterea';

  @override
  String get sendQueueHint =>
      'Pleacă singure imediat ce apare o cale — Bluetooth în apropiere sau internetul. Nu trebuie să apeși nimic.';

  @override
  String get sendQueueRetry => 'Încearcă acum';

  @override
  String get sendQueueCancel => 'Anulează trimiterea';

  @override
  String get sendQueueCancelled => 'Netrimis — retras';

  @override
  String get sendQueueTooLate =>
      'Prea târziu pentru a-l retrage: a plecat deja';

  @override
  String get chatEncryptedNotice =>
      'Mesajele sunt criptate integral cu Noise Protocol.';

  @override
  String get chatSessionHandshaking => 'Se stabilește canalul securizat…';

  @override
  String get chatSessionEstablished => 'Securizat · Noise XX';

  @override
  String get chatSessionFailed => 'Conexiunea a eșuat';

  @override
  String get presenceOnline => 'online';

  @override
  String get presenceOffline => 'offline';

  @override
  String get chatSessionFingerprintPending =>
      'Amprenta va apărea după finalizarea handshake-ului.';

  @override
  String get chatEmptyEstablished =>
      'Canalul securizat e gata. Trimite un mesaj ca să începi conversația.';

  @override
  String get chatEmptyHandshaking =>
      'Se așteaptă ca cealaltă parte să finalizeze handshake-ul…';

  @override
  String get chatEmptyTitle => 'Încă niciun mesaj aici';

  @override
  String get chatEmptyGreetHint =>
      'Trimite un mesaj sau atinge-l pe Kubi ca să saluți.';

  @override
  String get profileTitle => 'Profil';

  @override
  String get profileNickname => 'Pseudonim';

  @override
  String get profileNicknameEditTitle => 'Setează-ți pseudonimul';

  @override
  String get profileNicknameHint => 'Cum te văd ceilalți în rețeaua mesh';

  @override
  String get profileNicknameSave => 'Salvează';

  @override
  String get profileFingerprint => 'Amprenta cheii publice';

  @override
  String get profileLanguage => 'Limbă';

  @override
  String get profileLanguageEn => 'Engleză';

  @override
  String get profileLanguageUk => 'Ucraineană';

  @override
  String get profileTransport => 'Transport';

  @override
  String get profileTransportMesh => 'Bluetooth mesh';

  @override
  String get profileBackground => 'Rămâi accesibil în fundal';

  @override
  String get profileBackgroundSubtitle =>
      'Primește mesaje și când aplicația e închisă';

  @override
  String get profileBatteryExempt => 'Dezactivează optimizarea bateriei';

  @override
  String get profileAbout => 'Despre';

  @override
  String profileVersion(String v) {
    return 'Versiunea $v';
  }

  @override
  String get rotateKeysTitle => 'Schimbă cheile contului';

  @override
  String get rotateKeysHint =>
      'Dacă un dispozitiv cu contul tău a fost pierdut sau furat';

  @override
  String get rotateKeysConfirmTitle => 'Schimbi cheile contului?';

  @override
  String get rotateKeysConfirmBody =>
      'Contactele tale primesc noile chei și își păstrează chaturile, dar fiecăruia i se va cere să-ți verifice din nou cheile. Toate celelalte dispozitive ale contului se deconectează; leagă din nou de pe acest telefon pe cele pe care le păstrezi. Contactele cu o versiune mai veche de CubeChat nu te vor putea contacta până nu actualizează. Canalele își păstrează cheile.';

  @override
  String get rotateKeysConfirmAction => 'Schimbă cheile';

  @override
  String get rotateKeysWorking => 'Se schimbă cheile…';

  @override
  String rotateKeysDone(int sent, int total) {
    return 'Chei noi. $sent din $total contacte au fost anunțate';
  }

  @override
  String get rotateKeysSlow =>
      'Chei noi. Nu toate contactele au confirmat la timp; releele păstrează anunțul pentru ele';

  @override
  String get profileEmergencyWipe => 'Ștergere de urgență';

  @override
  String get profileEmergencyWipeConfirm => 'Ștergi tot?';

  @override
  String get profileEmergencyWipeConfirmHint =>
      'Se vor șterge identitatea ta, lista de persoane și istoricul conversațiilor. Acțiunea nu poate fi anulată.';

  @override
  String get profileEmergencyWipeAction => 'Șterge';

  @override
  String get cancel => 'Anulează';

  @override
  String get copy => 'Copiază';

  @override
  String get copied => 'Copiat';

  @override
  String get channelsNewTitle => 'Canal nou';

  @override
  String get channelsNewTooltip => 'Canal nou';

  @override
  String get channelNameLabel => 'Numele canalului';

  @override
  String get channelPasswordLabel => 'Parolă (opțional)';

  @override
  String get channelJoinAction => 'Alătură-te';

  @override
  String get channelNameHint =>
      'Oricine introduce același nume și aceeași parolă ajunge în aceeași cameră. Nu există un server care să țină lista lor.';

  @override
  String get channelPasswordHint =>
      'Parola este cheia. Fără ea, camera e deschisă oricui din apropiere care îi știe numele.';

  @override
  String get channelSubtitle => 'Canal de grup · cheie comună';

  @override
  String get channelMute => 'Fără sunet';

  @override
  String get channelUnmute => 'Cu sunet';

  @override
  String channelMutedUntil(String time) {
    return 'Fără sunet până la $time';
  }

  @override
  String get channelMuteFor => 'Fără sunet pentru…';

  @override
  String channelMuteMinutes(int minutes) {
    return '$minutes minute';
  }

  @override
  String channelMuteHours(int hours) {
    return '$hours ore';
  }

  @override
  String channelMuteDays(int days) {
    return '$days zile';
  }

  @override
  String get channelMuteForever => 'Până îl reactivez';

  @override
  String get channelCommunity => 'Comentarii';

  @override
  String get channelCommunityOpen => 'Deschide discuția';

  @override
  String channelCommunitySubtitle(String channel) {
    return 'Discuție pentru $channel';
  }

  @override
  String get channelBackToChannel => 'Înapoi la canal';

  @override
  String get channelMemberActions => 'Membru';

  @override
  String get channelRemoveMember => 'Elimină din canal';

  @override
  String get channelRemoveMemberHint =>
      'Postările lui nu mai sunt acceptate aici. Nimic nu-l împiedică să revină după nume — cheia comună este singura formă de apartenență.';

  @override
  String get channelMuteMember => 'Restricționează pentru…';

  @override
  String get channelUnmuteMember => 'Permite-i să scrie din nou';

  @override
  String channelMemberRemoved(String name) {
    return '$name a fost eliminat';
  }

  @override
  String channelMemberMuted(String name) {
    return '$name a fost restricționat';
  }

  @override
  String channelMemberCleared(String name) {
    return '$name poate scrie din nou';
  }

  @override
  String get channelMemberMutedNote => 'Restricționat';

  @override
  String get channelShareHistory => 'Partajează istoricul';

  @override
  String get channelShareHistoryHint =>
      'Retransmite ultimele postări din această cameră, ca oricine s-a alăturat mai târziu să le vadă. Cei care erau deja aici nu primesc nimic nou.';

  @override
  String channelHistoryShared(int count) {
    return 'Postări oferite: $count';
  }

  @override
  String get channelHistoryNothing => 'Încă nimic de partajat';

  @override
  String get channelHistoryAuto => 'Dă istoricul membrilor noi';

  @override
  String get channelHistoryAutoHint =>
      'Când cineva nou apare în cameră, postările recente îi sunt trimise automat. Deocamdată doar text — fotografiile sunt fluxuri de fragmente și nu pot fi retransmise fără a le dubla pentru toți.';

  @override
  String get channelPostComments => 'Comentarii';

  @override
  String get channelNoComments => 'Încă nimeni n-a spus nimic despre asta';

  @override
  String get channelCommentHint => 'Comentariu';

  @override
  String get channelMuteCustom => 'Pentru cât timp?';

  @override
  String get channelMuteCustomHint => 'Ore';

  @override
  String get chatPinnedManage => 'Fixate';

  @override
  String get chatPeekOpen => 'Deschide chatul';

  @override
  String get chatPeekPin => 'Fixează';

  @override
  String get chatPeekUnpin => 'Anulează fixarea';

  @override
  String get chatPeekUnmute => 'Cu sunet';

  @override
  String get chatPeekMarkRead => 'Marchează ca citit';

  @override
  String get chatDeleteForMeHint =>
      'Șters de pe acest telefon și anulată fixarea. Cealaltă parte își păstrează copia.';

  @override
  String get pushWakeTitle => 'Trezește acest telefon';

  @override
  String get pushWakeHint =>
      'Un mic server urmărește releele pentru adresa ta și bate la acest telefon când sosește ceva, ca aplicația închisă să te anunțe totuși. Nu vede niciodată vreun mesaj sau vreo cheie — doar că adresa ta a primit ceva și când. Releul știe deja asta; acesta e un al doilea loc care știe.';

  @override
  String get pushWakeDeniedTitle => 'Notificările sunt dezactivate';

  @override
  String get pushWakeDeniedHint =>
      'Sistemul a primit o dată „nu” și nu va mai întreba, așa că asta se poate reactiva doar din Setări — cubechat, apoi Notificări. Revino aici după aceea.';

  @override
  String get pushWakeRefused => 'Notificările nu au fost permise';

  @override
  String get privacyForwardLinkTitle => 'Link spre profil în redirecționări';

  @override
  String get privacyForwardLinkHint =>
      'Când cineva redirecționează un mesaj de-al tău, rândul de deasupra poate deschide profilul tău. Dezactivat, văd numele tău și nimic de atins. E o cerere către aplicația lor, nu ceva ce aceasta poate impune.';

  @override
  String get privacyShareSheetTitle => 'Chaturi în meniul de partajare';

  @override
  String get privacyShareSheetOnHint =>
      'Numele ultimelor patru chaturi sunt date către Android, ca să le poți trimite din orice aplicație. Blocarea aplicației nu le ascunde.';

  @override
  String get privacyShareSheetOffHint =>
      'Nimic nu e dat către Android. La partajarea în CubeChat, alegi chatul din listă.';

  @override
  String get privacyCallsTitle => 'Acceptă apeluri';

  @override
  String get privacyCallsOnHint =>
      'Contactele tale te pot suna. Ca să refuzi o persoană anume, deschide-i profilul.';

  @override
  String get privacyCallsOffHint =>
      'Nimeni nu te poate suna, în afară de cei cărora le permiți în profilul lor. Un apel refuzat le apare ca ocupat.';

  @override
  String get chatsStatusChannel => 'canal';

  @override
  String get channelInviteTitle => 'Adaugă persoane';

  @override
  String get channelInviteAction => 'Invită';

  @override
  String get channelInviteEmpty =>
      'Încă nicio persoană cunoscută. Întâlnește pe cineva mai întâi în fila În apropiere.';

  @override
  String get channelInviteSent => 'Invitații trimise';

  @override
  String get channelInviteNoneSent => 'Nimeni nu a putut fi contactat acum';

  @override
  String get channelNameTooLong => 'Numele canalului e prea lung';

  @override
  String get chatsActionFavorite => 'Adaugă la favorite';

  @override
  String get chatsActionUnfavorite => 'Elimină din favorite';

  @override
  String get chatsActionDelete => 'Șterge chatul';

  @override
  String get chatsDeleteTitle => 'Ștergi acest chat?';

  @override
  String chatsDeleteManyHint(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Golește $count de conversații. Contactele rămân, așa că le poți scrie din nou fără să faceți schimb de coduri.',
      few:
          'Golește $count conversații. Contactele rămân, așa că le poți scrie din nou fără să faceți schimb de coduri.',
      one:
          'Golește $count conversație. Contactul rămâne, așa că îi poți scrie din nou fără să faceți schimb de coduri.',
    );
    return '$_temp0';
  }

  @override
  String get chatsDeletedToast => 'Chat șters.';

  @override
  String chatsDeletedManyToast(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count de chaturi șterse.',
      few: '$count chaturi șterse.',
      one: '$count chat șters.',
    );
    return '$_temp0';
  }

  @override
  String get undo => 'Anulează';

  @override
  String get chatsDeletePeerHint =>
      'Golește conversația. Contactul rămâne, așa că îi poți scrie din nou fără să faceți schimb de coduri.';

  @override
  String get chatsDeleteChannelHint =>
      'Părăsești canalul și îi ștergi istoricul. Vei avea nevoie din nou de cheie ca să revii.';

  @override
  String get chatsDeleteForThemToo => 'Șterge și pentru celălalt';

  @override
  String get chatsDeleteForThemHint =>
      'Cere aplicației lui să golească și ea toată conversația, inclusiv ce a scris el. Într-un canal se retrag doar mesajele tale.';

  @override
  String get chatEditAction => 'Editează';

  @override
  String get chatEditTitle => 'Editează mesajul';

  @override
  String get chatEditSave => 'Salvează';

  @override
  String get chatEdited => 'editat';

  @override
  String get chatDeleteAction => 'Șterge';

  @override
  String get chatDeleteTitle => 'Ștergi mesajul?';

  @override
  String get chatDeleteForMe => 'Șterge pentru mine';

  @override
  String get chatDeleteForEveryone => 'Șterge pentru toți';

  @override
  String get chatPinTitle => 'Fixezi mesajul?';

  @override
  String get chatPinForBoth => 'Fixează pentru amândoi';

  @override
  String get chatPinForMe => 'Fixează doar pentru mine';

  @override
  String get chatReplyAction => 'Răspunde';

  @override
  String chatReplyingTo(String name) {
    return 'Răspuns pentru $name';
  }

  @override
  String get chatReplyYou => 'tine';

  @override
  String get chatCopyAction => 'Copiază';

  @override
  String get chatCopied => 'Copiat';

  @override
  String get chatForwardAction => 'Redirecționează';

  @override
  String get chatForwardTitle => 'Redirecționează către';

  @override
  String get shareIntoTitle => 'Trimite către';

  @override
  String get shareNearbyAirDrop => 'În apropiere prin AirDrop';

  @override
  String get shareNearbyAirDropHint => 'Fără internet — celor de lângă tine';

  @override
  String get shareSent => 'Trimis';

  @override
  String get shareFailed => 'O parte nu a putut fi trimisă';

  @override
  String get chatForwardEmpty => 'Încă niciun alt chat';

  @override
  String chatForwardSendCount(int count) {
    return 'Trimite ($count)';
  }

  @override
  String chatForwardSentCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Redirecționat în $count de chaturi',
      few: 'Redirecționat în $count chaturi',
      one: 'Redirecționat într-un chat',
    );
    return '$_temp0';
  }

  @override
  String chatForwardSent(String name) {
    return 'Redirecționat către $name';
  }

  @override
  String chatSentAt(String time) {
    return 'Trimis $time';
  }

  @override
  String chatReadAt(String time) {
    return 'Citit $time';
  }

  @override
  String get chatPinAction => 'Fixează';

  @override
  String get chatUnpinAction => 'Anulează fixarea';

  @override
  String chatPinnedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count de mesaje fixate',
      few: '$count mesaje fixate',
      one: '1 mesaj fixat',
      zero: 'Niciun mesaj fixat',
    );
    return '$_temp0';
  }

  @override
  String get chatNoPins => 'Nimic nu e fixat aici';

  @override
  String get chatUnpinAll => 'Anulează fixarea tuturor';

  @override
  String get chatShowAllPins => 'Toate mesajele fixate';

  @override
  String get chatUnpinConfirm => 'Anulezi fixarea mesajului?';

  @override
  String get chatUnpinConfirmHint =>
      'Nu va mai fi fixat pentru nimeni din acest chat.';

  @override
  String get chatPinnedTitle => 'Mesaj fixat';

  @override
  String get chatPinnedGone => 'Mesajul nu mai există în acest chat';

  @override
  String get peerBlock => 'Blochează';

  @override
  String get peerUnblock => 'Deblochează';

  @override
  String get peerMute => 'Fără sunet';

  @override
  String get peerUnmute => 'Cu sunet';

  @override
  String get peerBlockedNote => 'Blocat — mesajele lui sunt respinse.';

  @override
  String get relaysTitle => 'Rezervă prin internet';

  @override
  String get relaysCardTitle => 'Contactează persoane prin internet';

  @override
  String get relaysCardSubtitle =>
      'Când Bluetooth nu poate livra, trimite prin relee Nostr';

  @override
  String get relaysExplainer =>
      'Mesajele rămân criptate integral — un releu transportă doar același cadru sigilat pe care l-ar transporta Bluetooth. Află însă ce două chei comunică și când. Dezactivat implicit.';

  @override
  String get relaysMyAddress => 'Adresa ta pe relee';

  @override
  String get relaysCopied => 'Copiat';

  @override
  String get circleLensTitle => 'Camera frontală pentru mesaje rotunde';

  @override
  String get circleLensFrontHint =>
      'Mesajele video rotunde se înregistrează cu camera îndreptată spre tine.';

  @override
  String get circleLensBackHint =>
      'Mesajele video rotunde se înregistrează cu camera din spate, ca să arăți ce vezi.';

  @override
  String get channelCloseTitle => 'Închide camera pentru toți';

  @override
  String get channelCloseSubtitle =>
      'O elimină de pe telefonul fiecărui membru. Doar tu poți face asta.';

  @override
  String get channelCloseConfirm =>
      'Camera, mesajele și membrii ei dispar de pe fiecare telefon care o are. Nimeni nu e blocat: cheia provine din nume, așa că oricine și-l amintește poate deschide din nou o cameră goală.';

  @override
  String get channelCloseAction => 'Închide camera';

  @override
  String get circleHint =>
      'Eliberează ca să trimiți · glisează la stânga ca să anulezi';

  @override
  String get circleHintLocked => 'Atinge Trimite când ai terminat';

  @override
  String get circleNeedsCamera =>
      'Mesajele rotunde au nevoie de cameră și microfon';

  @override
  String get circleFailed => 'Mesajul rotund nu a putut fi înregistrat';

  @override
  String get relaysListLabel => 'Relee';

  @override
  String get relaysLaneMedia => 'Relee pentru media';

  @override
  String get relaysLaneMediaNote =>
      'Fotografiile, fișierele și clipurile video trec prin acestea, ca un transfer să nu încetinească conversația.';

  @override
  String get relaysLaneLocation => 'Relee pentru locație';

  @override
  String get relaysLaneLocationNote =>
      'Semnalele de pe hartă trec prin acestea, separat de tot restul.';

  @override
  String get relaysAdd => 'Adaugă releu';

  @override
  String get relaysAddHint => 'wss://relay.example.com';

  @override
  String get relaysInvalidUrl => 'Introdu o adresă wss:// sau ws://';

  @override
  String get relaysRemove => 'Elimină';

  @override
  String get relaysStateConnected => 'Conectat';

  @override
  String get relaysStateConnecting => 'Se conectează…';

  @override
  String get relaysStateFailed => 'Inaccesibil';

  @override
  String get relaysStateIdle => 'Oprit';

  @override
  String get relaysEmpty => 'Niciun releu configurat — rezerva rămâne oprită.';

  @override
  String get contactTitle => 'Card de contact';

  @override
  String get contactMineLabel => 'Cardul tău';

  @override
  String get contactMineExplainer =>
      'Trimite-l cuiva care e în afara razei Bluetooth. Conține cheile tale și adresa ta pe relee — suficient ca să înceapă cu tine un chat criptat prin internet.';

  @override
  String get contactCopy => 'Copiază';

  @override
  String get contactShare => 'Partajează';

  @override
  String get contactCopied => 'Card copiat';

  @override
  String get contactShareSubject => 'Cardul meu de contact cubechat';

  @override
  String get contactAddLabel => 'Adaugă pe cineva';

  @override
  String get contactAddHint => 'Lipește un card de contact';

  @override
  String get contactAddAction => 'Adaugă';

  @override
  String get contactPaste => 'Lipește';

  @override
  String contactAdded(String name) {
    return '$name a fost adăugat';
  }

  @override
  String get contactInvalid => 'Nu e un card de contact valid';

  @override
  String get contactOwnCard => 'Acesta e propriul tău card';

  @override
  String get contactUnverified =>
      'Un contact adăugat astfel pornește neverificat. Oricine poate crea un card și poate pune orice nume pe el, așa că compară amprentele față în față sau într-un apel înainte să ai încredere în identitate.';

  @override
  String get contactRelayOff =>
      'Rezerva prin internet e oprită, așa că un card nu poate ajunge încă la nimeni.';

  @override
  String get contactRelayEnable => 'Activează';

  @override
  String get profileContactCard => 'Card de contact';

  @override
  String get chatsAddContactTooltip => 'Adaugă un contact după card';

  @override
  String get chatsMenuTooltip => 'Mai mult';

  @override
  String get chatsMenuAddContact => 'Adaugă contact';

  @override
  String get chatsMenuNewChannel => 'Canal nou';

  @override
  String get profileDiscoverable => 'Vizibil în apropiere';

  @override
  String get profileDiscoverableOnHint => 'Oricine din raza ta te poate găsi';

  @override
  String get profileDiscoverableOffHint =>
      'Doar contactele tale te pot contacta';

  @override
  String get profileDiscoverableExplainer =>
      'Activat, anunțul tău e difuzat necriptat, ca străinii să te poată cunoaște apropiindu-se — și oricine ascultă îți înregistrează cheia și numele. Dezactivat, același pachet ajunge doar la contactele pe care le ai deja, sigilat, iar ID-urile tale de rutare nu pot fi legate între ele. Persoanele noi au atunci nevoie de un card de contact.';

  @override
  String get voiceHoldHint => 'Ține apăsat ca să înregistrezi un mesaj vocal';

  @override
  String get voiceTrimPlay => 'Redă';

  @override
  String get voiceTrimPause => 'Pauză';

  @override
  String get voiceTrimDiscard => 'Renunță la înregistrare';

  @override
  String voiceTrimSelection(String duration) {
    return 'Se trimite $duration';
  }

  @override
  String get profileLastSeen => 'Arată ultima accesare';

  @override
  String get profileLastSeenOnHint => 'Contactele văd când ești în aplicație';

  @override
  String get profileLastSeenOffHint =>
      'Nimeni nu-ți vede ora și nu vezi nici tu ora nimănui: doar cine e online';

  @override
  String get profileMapLocation => 'Arată-mă pe hartă';

  @override
  String get profileMapLocationOnHint =>
      'Locația e disponibilă pentru partajare manuală și marcajul tău apare pe hartă';

  @override
  String get profileMapLocationOffHint =>
      'Aplicația nu cere locația, iar marcajul tău rămâne ascuns';

  @override
  String get desktopAutostartTitle => 'Pornește odată cu Windows';

  @override
  String get desktopAutostartHint =>
      'CubeChat așteaptă în bara de sistem, ca apelurile și mesajele să ajungă la acest computer și cu fereastra închisă';

  @override
  String get trayOpen => 'Deschide CubeChat';

  @override
  String get trayQuit => 'Ieșire';

  @override
  String get callDirectTitle => 'Apeluri directe';

  @override
  String get callDirectOnHint =>
      'Mai rapid, dar persoana pe care o suni îți află adresa IP';

  @override
  String get callDirectOffHint =>
      'Apelurile trec prin releul nostru: persoana pe care o suni nu îți vede niciodată IP-ul, iar releul nu poate auzi apelul';

  @override
  String get profileReadReceipts => 'Confirmări de citire';

  @override
  String get profileReadReceiptsOnHint =>
      'Expeditorii văd când le-ai citit mesajele';

  @override
  String get profileReadReceiptsOffHint =>
      'Nu mai trimiți ora citirii, dar o vezi pe a celorlalți';

  @override
  String get profilePrivacyExplainer =>
      'Ultima accesare funcționează în ambele sensuri: dacă îți ascunzi statusul, nu-l mai vezi nici pe al celorlalți. Confirmările de citire controlează doar ce trimiți tu. Livrarea mesajelor nu e afectată.';

  @override
  String get chatTimerAction => 'Cronometru';

  @override
  String get chatTimerRemove => 'Elimină cronometrul';

  @override
  String get chatTimerTitle => 'Șterge acest mesaj după';

  @override
  String chatTimerSet(String time) {
    return 'Mesajul dispare în $time';
  }

  @override
  String get chatTimerLocalHint =>
      'Doar pe acest dispozitiv — copia lor le aparține';

  @override
  String get contactTagAction => 'Etichetă';

  @override
  String get contactTagRemove => 'Elimină eticheta';

  @override
  String get contactTagTitle => 'Alege o etichetă';

  @override
  String get contactTagAll => 'Toate';

  @override
  String get quietHoursTitle => 'Ore de liniște';

  @override
  String get quietHoursHint =>
      'Mesajele sosesc în continuare; telefonul rămâne silențios';

  @override
  String get quietHoursFrom => 'De la';

  @override
  String get quietHoursTo => 'Până la';

  @override
  String get notifPreviewTitle => 'Arată în notificări';

  @override
  String get notifPreviewFull => 'Nume și text';

  @override
  String get notifPreviewNameOnly => 'Doar numele';

  @override
  String get notifPreviewHidden => 'Nimic';

  @override
  String get notifPreviewHint =>
      'Notificările sunt vizibile pe ecranul de blocare și aplicațiilor cu acces la notificări, chiar și cu blocarea aplicației activă';

  @override
  String get notifPreviewNewMessage => 'Mesaj nou';

  @override
  String get appLockTitle => 'Blocare aplicație';

  @override
  String get appLockHint => 'Cere un cod la deschiderea aplicației';

  @override
  String get appLockPrompt => 'Introdu codul';

  @override
  String get appLockUnlock => 'Deblochează';

  @override
  String get appLockWrong => 'Cod greșit';

  @override
  String get appLockSetTitle => 'Setează un cod';

  @override
  String get appLockSetHint =>
      'Patru cifre sau mai multe. Nu există nicio cale de a-l recupera.';

  @override
  String get appLockOffTitle => 'Dezactivează blocarea';

  @override
  String get appLockOffHint => 'Introdu codul actual';

  @override
  String get appLockOn => 'Blocarea aplicației e activă';

  @override
  String get appLockOff => 'Blocarea aplicației e dezactivată';

  @override
  String get avatarSet => 'Alege o fotografie';

  @override
  String get avatarChange => 'Schimbă fotografia';

  @override
  String get avatarView => 'Vezi fotografia';

  @override
  String get profileCoverPhoto =>
      'Fotografie de profil, atinge de două ori pentru a mări';

  @override
  String get profileCoverMenu => 'Opțiuni fotografie';

  @override
  String get avatarSaved => 'Salvată în galerie';

  @override
  String get avatarRemove => 'Elimină fotografia';

  @override
  String get avatarRemoveConfirm =>
      'Avatarul va fi șters de pe acest dispozitiv. În locul lui revine gradientul generat.';

  @override
  String get avatarFailed => 'Imaginea nu a putut fi citită';

  @override
  String get fileOpenHint => 'Atinge pentru a deschide';

  @override
  String get fileMissing => 'Fișierul nu mai este disponibil';

  @override
  String get fileNoHandlerTitle => 'Nicio aplicație nu poate deschide asta';

  @override
  String get fileNoHandlerHint =>
      'Nicio aplicație instalată nu gestionează acest tip de fișier. Îl poți trimite în schimb către altă aplicație.';

  @override
  String get fileRequestedAgain => 'I-am cerut expeditorului să-l retrimită';

  @override
  String get fileOpenFailed => 'Fișierul nu a putut fi deschis';

  @override
  String get fileShareAction => 'Trimite în aplicație';

  @override
  String fileTooLargeMesh(int limit) {
    return 'Fișierul e prea mare — limita prin mesh este de $limit MB';
  }

  @override
  String fileTooLargeRelay(int limit) {
    return 'Prin internet limita este de $limit MB. Apropie-te de destinatar ca să trimiți un fișier mai mare.';
  }

  @override
  String get mediaSendOriginal => 'Original';

  @override
  String get attachFile => 'Fișier';

  @override
  String get attachGallery => 'Galerie';

  @override
  String get attachCamera => 'Cameră';

  @override
  String get cameraUnavailable => 'Camera nu e disponibilă';

  @override
  String get profileEditName => 'Nume';

  @override
  String get profileMyCard => 'Card';

  @override
  String get mediaCaptionHint => 'Adaugă o descriere…';

  @override
  String get mediaDiscardTitle => 'Renunți la selecție?';

  @override
  String get mediaDiscardMessage =>
      'Închizi galeria și renunți la fotografiile selectate?';

  @override
  String get mediaDiscardConfirm => 'Renunță';

  @override
  String get mediaPhotosAccessOff => 'Accesul la fotografii e dezactivat';

  @override
  String get mediaPhotosAccessOffHint =>
      'Momentan CubeChat vede doar clipurile video. Permite accesul la fotografii din setările sistemului ca să-ți afișezi imaginile.';

  @override
  String get mediaVideosOnly =>
      'Se văd doar clipurile video — permite accesul la fotografii';

  @override
  String get mediaOpenSettings => 'Deschide setările';

  @override
  String get mediaTakePhoto => 'Fă o fotografie';

  @override
  String get contactProfileAutoDelete => 'Ștergere automată';

  @override
  String get contactProfileAutoDeleteTitle => 'Ștergere automată a mesajelor';

  @override
  String get contactProfileAutoDeleteOff => 'Dezactivată';

  @override
  String get contactProfileAutoDeleteOneDay => 'După 1 zi';

  @override
  String get contactProfileAutoDeleteSevenDays => 'După 7 zile';

  @override
  String get contactProfileAutoDeleteThirtyDays => 'După 30 de zile';

  @override
  String contactProfileAutoDeleteUpdated(String period) {
    return 'Ștergere automată: $period';
  }

  @override
  String get contactProfileShare => 'Partajează contactul';

  @override
  String get contactProfileShareTitle => 'Trimite contactul către';

  @override
  String get contactProfileShareEmpty => 'Încă niciun alt chat';

  @override
  String contactProfileShareSent(String name) {
    return 'Trimis către $name';
  }

  @override
  String get contactProfileRestrictCopying => 'Interzice copierea';

  @override
  String get contactProfileAllowCopying => 'Permite copierea';

  @override
  String get contactHideAvatar => 'Ascunde-mi fotografia';

  @override
  String get contactShowAvatar => 'Arată-mi fotografia';

  @override
  String get contactHideLastSeen => 'Ascunde-mi ultima accesare';

  @override
  String get contactShowLastSeen => 'Arată-mi ultima accesare';

  @override
  String get contactHideReadReceipts => 'Ascunde-mi orele de citire';

  @override
  String get contactShowReadReceipts => 'Arată-mi orele de citire';

  @override
  String get contactHiddenFromThem => 'Ascuns de acest contact';

  @override
  String get contactRefuseCalls => 'Nu-i accepta apelurile';

  @override
  String get contactAllowCalls => 'Acceptă-i apelurile';

  @override
  String get contactCallsException =>
      'O excepție de la setarea ta pentru apeluri';

  @override
  String get contactProfileCopyingRestricted =>
      'Copierea și redirecționarea sunt dezactivate';

  @override
  String get contactProfileCopyingRestrictedByPeer =>
      'Dezactivat de cealaltă parte';

  @override
  String get contactProfileCopyingAllowed =>
      'Copierea și redirecționarea sunt permise';

  @override
  String get contactProfileDelete => 'Șterge din contacte';

  @override
  String get contactProfileRestore => 'Adaugă înapoi în contacte';

  @override
  String get contactProfileRestoreDone => 'Din nou în contactele tale';

  @override
  String get contactProfileDeleteTitle => 'Elimini contactul?';

  @override
  String contactProfileDeleteMessage(String name) {
    return '$name va dispărea din Contacte. Istoricul chatului rămâne pe acest dispozitiv.';
  }

  @override
  String get contactProfileMedia => 'Media';

  @override
  String get contactProfileVoiceMessages => 'Mesaje vocale';

  @override
  String get contactProfileStickers => 'Stickere';

  @override
  String get contactProfileNoStickers => 'Încă niciun sticker';

  @override
  String get contactProfileNoMedia => 'Încă nicio fotografie sau clip';

  @override
  String get contactProfileNoVoiceMessages => 'Încă niciun mesaj vocal';

  @override
  String get contactProfileOpen => 'Deschide profilul';

  @override
  String autoDeleteDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count de zile',
      few: '$count zile',
      one: '$count zi',
    );
    return '$_temp0';
  }

  @override
  String autoDeleteHours(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count de ore',
      few: '$count ore',
      one: '$count oră',
    );
    return '$_temp0';
  }

  @override
  String autoDeleteMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count de minute',
      few: '$count minute',
      one: '$count minut',
    );
    return '$_temp0';
  }

  @override
  String autoDeleteSeconds(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count de secunde',
      few: '$count secunde',
      one: '$count secundă',
    );
    return '$_temp0';
  }

  @override
  String get autoDeleteCustom => 'Personalizat…';

  @override
  String get autoDeleteCustomHint => 'Cantitate';

  @override
  String get autoDeleteUnitMinutes => 'min';

  @override
  String get autoDeleteUnitHours => 'ore';

  @override
  String get autoDeleteUnitDays => 'zile';

  @override
  String get contactProfileAutoDeleteSet => 'Setează';

  @override
  String get contactProfileFiles => 'Fișiere';

  @override
  String get contactProfileNoFiles => 'Încă niciun fișier';

  @override
  String get contactProfileLinks => 'Linkuri';

  @override
  String get contactProfileNoLinks => 'Încă niciun link';

  @override
  String get contactProfilePolls => 'Sondaje';

  @override
  String get contactProfileNoPolls => 'Încă niciun sondaj';

  @override
  String get presenceRecently => 'văzut(ă) recent';

  @override
  String get presenceJustNow => 'chiar acum';

  @override
  String presenceHoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'văzut(ă) acum $count de ore',
      few: 'văzut(ă) acum $count ore',
      one: 'văzut(ă) acum $count oră',
    );
    return '$_temp0';
  }

  @override
  String presenceYesterdayAt(String time) {
    return 'văzut(ă) ieri la $time';
  }

  @override
  String presenceOnWeekday(String day) {
    String _temp0 = intl.Intl.selectLogic(
      day,
      {
        '1': 'văzut(ă) luni',
        '2': 'văzut(ă) marți',
        '3': 'văzut(ă) miercuri',
        '4': 'văzut(ă) joi',
        '5': 'văzut(ă) vineri',
        '6': 'văzut(ă) sâmbătă',
        '7': 'văzut(ă) duminică',
        'other': 'văzut(ă) săptămâna aceasta',
      },
    );
    return '$_temp0';
  }

  @override
  String presenceWeeksAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'văzut(ă) acum $count de săptămâni',
      few: 'văzut(ă) acum $count săptămâni',
      one: 'văzut(ă) acum o săptămână',
    );
    return '$_temp0';
  }

  @override
  String presenceMonthsAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'văzut(ă) acum $count de luni',
      few: 'văzut(ă) acum $count luni',
      one: 'văzut(ă) acum o lună',
    );
    return '$_temp0';
  }

  @override
  String get presenceLongAgo => 'văzut(ă) demult';

  @override
  String presenceMinutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'văzut(ă) acum $count de minute',
      few: 'văzut(ă) acum $count minute',
      one: 'văzut(ă) acum $count minut',
    );
    return '$_temp0';
  }

  @override
  String chatReadByCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Citit de $count',
      few: 'Citit de $count',
      one: 'Citit de $count',
    );
    return '$_temp0';
  }

  @override
  String get chatsSearchFrequent => 'Persoane cu care vorbești';

  @override
  String get chatsSearchRecent => 'Recente';

  @override
  String get chatsSearchClear => 'Golește';

  @override
  String get chatsSearchStartHint =>
      'Caută chaturi după nume sau orice mesaj după cuvinte.';

  @override
  String get chatsSearchEmpty => 'Nimic nu se potrivește';

  @override
  String get chatRoutesTitle => 'Cum ajunge la destinatar';

  @override
  String get chatRoutesBluetoothHint =>
      'Direct pe telefonul lui, fără internet';

  @override
  String get chatRoutesMeshHint =>
      'Transmis mai departe de telefoanele dintre voi';

  @override
  String get chatRoutesInternetHint =>
      'Printr-un releu, când nu e nimeni în rază';

  @override
  String get chatRoutesHint =>
      'Calea se alege pentru fiecare mesaj, din ce e accesibil în acel moment.';

  @override
  String get chatRoutesPreferTitle => 'Ce să încerce întâi';

  @override
  String get chatRoutesPreferMesh => 'Întâi Bluetooth';

  @override
  String get chatRoutesPreferMeshHint =>
      'Mai rapid în aceeași cameră, nu consumă date, nu-i spune nimic unui releu';

  @override
  String get chatRoutesPreferRelay => 'Întâi internetul';

  @override
  String get chatRoutesPreferRelayHint =>
      'Pentru o legătură Bluetooth slabă și o conexiune bună';

  @override
  String get chatRoutesPreferNote =>
      'O preferință, nu o restricție. Dacă ruta aleasă nu e accesibilă, mesajul pleacă totuși pe cealaltă.';

  @override
  String get deadmanTitle => 'Șterge dacă nu e folosită';

  @override
  String get deadmanOff => 'Dezactivat';

  @override
  String deadmanDays(int days) {
    return 'După $days zile';
  }

  @override
  String get deadmanHint =>
      'Dacă nimeni nu deschide aplicația atâta timp, tot ce e în ea se șterge la următoarea deschidere. Nu te poate avertiza înainte — tocmai acesta e rostul.';

  @override
  String chatForwardedFrom(String name) {
    return 'Redirecționat de la $name';
  }

  @override
  String appLockWait(String left) {
    return 'Prea multe încercări — așteaptă $left';
  }

  @override
  String get appLockGraceTitle => 'Cere codul';

  @override
  String get appLockGraceNow => 'De fiecare dată';

  @override
  String appLockGraceAfter(String left) {
    return 'După $left de absență';
  }

  @override
  String get chatCalendarTitle => 'După dată';

  @override
  String get chatCalendarEmpty => 'Încă nu s-a spus nimic aici';

  @override
  String get chatsSearchChatsSection => 'Chaturi';

  @override
  String get chatsSearchMessagesSection => 'Mesaje';

  @override
  String get contactProfileViewInChat => 'Vezi în chat';

  @override
  String get chatDraft => 'Ciornă';

  @override
  String get chatSearchTitle => 'Căutare';

  @override
  String get chatSearchHint => 'Caută în mesaje';

  @override
  String get chatSearchNoResults => 'Niciun rezultat';

  @override
  String get chatSearchPrevious => 'Rezultatul anterior';

  @override
  String get chatSearchNext => 'Rezultatul următor';

  @override
  String chatMessageCount(int count) {
    return 'Mesaje: $count';
  }

  @override
  String get chatRouteBluetooth => 'Bluetooth';

  @override
  String get chatRouteMesh => 'Mesh';

  @override
  String get chatRouteInternet => 'Internet';

  @override
  String get chatRouteQueued => 'În coadă';

  @override
  String get attachStickers => 'Stickere';

  @override
  String get stickersEmpty => 'Încă niciun sticker';

  @override
  String get stickersEmptyHint =>
      'Păstrează o imagine dintr-un chat și va apărea aici.';

  @override
  String get stickerKeep => 'Salvează ca sticker';

  @override
  String get stickerKept => 'Salvat în stickerele tale';

  @override
  String get stickerForget => 'Elimină stickerul';

  @override
  String get stickerCreate => 'Creează un sticker dintr-o fotografie';

  @override
  String get stickerFailed =>
      'Din această imagine nu s-a putut face un sticker';

  @override
  String get stickerLabel => 'Sticker';

  @override
  String get previewPhoto => 'Fotografie';

  @override
  String get previewVoice => 'Mesaj vocal';

  @override
  String get previewFile => 'Fișier';

  @override
  String get stickerEmojiTitle => 'Alege un emoji pentru el';

  @override
  String get stickersMine => 'Stickerele mele';

  @override
  String get stickersStarterPack => 'Cubi';

  @override
  String get emojiTab => 'Emoji';

  @override
  String get chatBlockedStatus => 'blocat';

  @override
  String get chatBlockedHint => 'Ai blocat această persoană';

  @override
  String get chatRouteFallbackOff => 'Internet oprit';

  @override
  String get chatAttachmentUnavailable =>
      'Nicio conexiune disponibilă. Conectează-te prin Bluetooth sau internet și încearcă din nou.';

  @override
  String get fileTransfersTitle => 'Transferuri de fișiere';

  @override
  String get fileTransfersClear => 'Golește istoricul';

  @override
  String get fileTransfersEmpty => 'Încă niciun transfer de fișiere';

  @override
  String get fileTransfersActive => 'Active';

  @override
  String get fileTransfersHistory => 'Istoric';

  @override
  String get fileTransferPause => 'Pauză';

  @override
  String get fileTransferResume => 'Reia';

  @override
  String get fileTransferRetry => 'Reîncearcă';

  @override
  String get fileTransferQueued => 'Așteaptă conexiunea';

  @override
  String get fileTransferRunning => 'Se transferă';

  @override
  String get fileTransferPaused => 'Întrerupt';

  @override
  String get fileTransferCompleted => 'Finalizat';

  @override
  String get fileTransferFailed => 'Eșuat';

  @override
  String get fileTransferCanceled => 'Anulat';

  @override
  String get profileFileTransfers => 'Transferuri de fișiere';

  @override
  String get profileFileTransfersSubtitle =>
      'Progres, coadă și istoric transferuri';

  @override
  String get qrScanAction => 'Scanează codul QR';

  @override
  String get qrScanTitle => 'Scanează codul QR';

  @override
  String get qrScanHint =>
      'Scanează un cod CubeChat de contact, canal, transfer de cont sau conectare a unui computer.';

  @override
  String get qrFlash => 'Lanternă';

  @override
  String get qrCameraError =>
      'Camera nu e disponibilă. Verifică permisiunea pentru cameră și încearcă din nou.';

  @override
  String get qrInvalid => 'Acesta nu este un cod QR Cubechat valid.';

  @override
  String qrChannelAdded(String name) {
    return '$name a fost adăugat';
  }

  @override
  String get qrShow => 'Arată codul QR';

  @override
  String qrChannelTitle(String name) {
    return 'Alătură-te la $name';
  }

  @override
  String get profileBackup => 'Backup criptat';

  @override
  String get profileBackupSubtitle =>
      'Mută în siguranță cheile, contactele și istoricul';

  @override
  String get backupTitle => 'Backup criptat';

  @override
  String get backupExplainer =>
      'Backupul conține cheile tale private de identitate, contactele, canalele, setările și istoricul mesajelor. E criptat pe acest telefon cu parola pe care o alegi; Cubechat nu poate recupera o parolă uitată.';

  @override
  String get backupCreate => 'Creează backup';

  @override
  String get backupCreateSubtitle =>
      'Criptează tot și salvează un fișier .cchatbackup';

  @override
  String get backupRestore => 'Restaurează backup';

  @override
  String get backupRestoreSubtitle =>
      'Înlocuiește profilul Cubechat de pe acest telefon dintr-un fișier de backup';

  @override
  String get backupPasswordTitle => 'Parola backupului';

  @override
  String get backupPasswordHint => 'Cel puțin 8 caractere';

  @override
  String get backupConfirmPassword => 'Repetă parola';

  @override
  String get backupPasswordMismatch => 'Parolele nu se potrivesc';

  @override
  String get backupPasswordShort => 'Folosește cel puțin 8 caractere';

  @override
  String get backupSaveTitle => 'Salvează backupul Cubechat';

  @override
  String get backupSaved => 'Backup criptat salvat';

  @override
  String get backupWhereTitle => 'Unde să fie salvat backupul?';

  @override
  String get backupSaveToFiles => 'Salvează în Fișiere';

  @override
  String get backupSaveToFilesHint =>
      'Un dosar pe acest telefon, un card de memorie sau un spațiu în cloud';

  @override
  String get backupSendToApp => 'Trimite într-o aplicație';

  @override
  String get backupSendToAppHint =>
      'Telegram, e-mail, un messenger — orice acceptă fișiere';

  @override
  String get backupFailed => 'Operațiunea de backup nu a putut fi finalizată';

  @override
  String get backupRestoreConfirmTitle => 'Înlocuiești acest profil?';

  @override
  String get backupRestoreConfirmMessage =>
      'Cheile, contactele, canalele, setările și istoricul actuale de pe acest telefon vor fi înlocuite cu backupul selectat.';

  @override
  String get backupRestoreConfirmAction => 'Restaurează';

  @override
  String get backupRestored => 'Backup restaurat';

  @override
  String get backupPackingWait => 'Se creează backupul…';

  @override
  String get backupUnpackingWait => 'Se restaurează backupul…';

  @override
  String get backupWaitHint =>
      'Cu fotografii și clipuri video poate dura câteva minute. Ține aplicația deschisă.';

  @override
  String get backupInvalid =>
      'Parolă greșită, fișier deteriorat sau backup neacceptat';

  @override
  String get channelInfoTitle => 'Detalii canal';

  @override
  String get channelParticipantsTitle => 'Participanți';

  @override
  String get channelAdministratorsTitle => 'Administratori';

  @override
  String get channelMakeAdmin => 'Fă administrator';

  @override
  String get channelRemoveAdmin => 'Elimină administratorul';

  @override
  String get channelNoParticipants =>
      'Participanții vor apărea după o activitate semnată';

  @override
  String get channelSharedContent => 'Media, fișiere și sondaje';

  @override
  String get channelDescriptionTitle => 'Descriere';

  @override
  String get channelDescriptionEmpty => 'Încă nicio descriere';

  @override
  String get channelDescriptionHint => 'La ce folosește acest canal';

  @override
  String get channelDescriptionAdminOnly =>
      'Doar un administrator poate schimba descrierea';

  @override
  String get channelDescriptionSave => 'Salvează';

  @override
  String get channelPrivateSubtitle => 'canal privat';

  @override
  String get channelAvatarSet => 'Setează o fotografie nouă';

  @override
  String get channelSettingsTitle => 'Setări canal';

  @override
  String get channelSettingsHint => 'Cine poate posta, copierea, istoricul';

  @override
  String get channelLeaveAction => 'Părăsește';

  @override
  String get channelLeaveConfirm =>
      'Camera și tot ce s-a spus în ea dispar de pe acest telefon. Cheia provine din nume, așa că o poți deschide din nou tastând același nume.';

  @override
  String get channelShareAction => 'Partajează';

  @override
  String channelMembersOf(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count de membri',
      few: '$count membri',
      one: '1 membru',
    );
    return '$_temp0';
  }

  @override
  String get chatTyping => 'scrie…';

  @override
  String get chatRecordingVoice => 'înregistrează un mesaj vocal…';

  @override
  String get chatRecordingCircle => 'înregistrează un mesaj video…';

  @override
  String get chatSendingPhoto => 'trimite o fotografie…';

  @override
  String get chatSendingVideo => 'trimite un videoclip…';

  @override
  String get chatSendingFile => 'trimite un fișier…';

  @override
  String get onboardingMeshTitle => 'Funcționează fără internet';

  @override
  String get onboardingMeshBody =>
      'Mesajele circulă prin Bluetooth, de la telefon la telefon. Fără semnal, fără Wi-Fi, fără conturi — doar oamenii din jurul tău.';

  @override
  String get onboardingRelayTitle => 'Și cu internet, când există';

  @override
  String get onboardingRelayBody =>
      'În afara razei Bluetooth, mesajele folosesc în schimb internetul și ajung la fel. Nu trebuie să alegi tu.';

  @override
  String get onboardingPrivacyTitle => 'Nimeni de pe drum nu le poate citi';

  @override
  String get onboardingPrivacyBody =>
      'Totul e criptat integral, iar identitatea ta e o cheie pe acest telefon — nu un număr de telefon, nu un e-mail, nu un cont pe care ți-l poate lua cineva.';

  @override
  String get onboardingSkip => 'Omite';

  @override
  String get onboardingNext => 'Înainte';

  @override
  String get onboardingStart => 'Să începem';

  @override
  String get chatMediaShare => 'Partajează';

  @override
  String get chatMediaSaveToGallery => 'Salvează în galerie';

  @override
  String get chatMediaShowInChat => 'Arată în chat';

  @override
  String get chatWallpaperTitle => 'Fundal';

  @override
  String get chatWallpaperClear => 'Resetează';

  @override
  String get chatWallpaperDim => 'Întunecă în spatele mesajelor';

  @override
  String get chatSelectAction => 'Selectează';

  @override
  String get chatForwardNothing => 'Nimic de aici nu poate fi redirecționat';

  @override
  String chatSelectedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count selectate',
      few: '$count selectate',
      one: '1 selectat',
    );
    return '$_temp0';
  }

  @override
  String chatDeleteSelectedTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Ștergi $count de mesaje?',
      few: 'Ștergi $count mesaje?',
      one: 'Ștergi acest mesaj?',
    );
    return '$_temp0';
  }

  @override
  String get contactAliasAction => 'Redenumește contactul';

  @override
  String get contactAliasHint =>
      'Doar tu vezi acest nume. Lasă gol ca să folosești numele lui.';

  @override
  String get viewOnceSendLabel => 'O singură vizualizare';

  @override
  String get viewOnceTitle => 'O singură vizualizare';

  @override
  String get viewOnceTapToView =>
      'Fotografie · atinge pentru o singură vizualizare';

  @override
  String get viewOnceSent => 'Fotografie · trimisă';

  @override
  String get viewOnceOpened => 'Fotografie deschisă';

  @override
  String get viewOnceUnavailable => 'Fotografia nu mai este disponibilă';

  @override
  String get viewOnceWarning =>
      'La închidere, fotografia se șterge pentru amândoi.';

  @override
  String get channelAvatarAdminOnly =>
      'Doar un administrator poate schimba fotografia canalului';

  @override
  String get channelAdminOnly => 'Doar un administrator poate schimba asta';

  @override
  String get channelAvatarTooLarge =>
      'Fotografia e prea mare pentru a fi difuzată';

  @override
  String get channelMemberUnknown => 'Încă nu e în contactele tale';

  @override
  String get channelInviteToContacts => 'Trimite-i cardul tău de contact';

  @override
  String channelContactInviteSent(String name) {
    return 'Card de contact oferit lui $name';
  }

  @override
  String get chatContactInvitation => 'Invitație de conectare';

  @override
  String get chatContactInvitationForYou => 'Invitație pentru tine';

  @override
  String get channelPollTitle => 'Sondaj';

  @override
  String get channelCreatePoll => 'Creează sondaj';

  @override
  String get channelPollQuestion => 'Întrebare';

  @override
  String channelPollOption(int number) {
    return 'Opțiunea $number';
  }

  @override
  String get channelPollAddOption => 'Adaugă opțiune';

  @override
  String get channelPollCreate => 'Publică sondajul';

  @override
  String channelPollVotes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count de voturi',
      few: '$count voturi',
      one: '1 vot',
      zero: 'Niciun vot',
    );
    return '$_temp0';
  }

  @override
  String get phoneTransferTitle => 'Transfer pe un telefon nou';

  @override
  String get desktopPickChat => 'Alege cui vrei să-i scrii';

  @override
  String get desktopListCollapse => 'Arată doar fețele';

  @override
  String get desktopListExpand => 'Arată lista de chaturi';

  @override
  String get desktopLinkConnectTitle => 'Conectează un computer';

  @override
  String get desktopLinkConnectHint =>
      'Scanează codul afișat de CubeChat pe computer';

  @override
  String get desktopLinkSignIn => 'Conectează-te cu contul telefonului';

  @override
  String get desktopLinkTitle => 'Conectare cu telefonul';

  @override
  String get desktopLinkSteps =>
      'Pe telefon: Profil → Date → Conectează un computer, apoi scanează acest cod. Ambele trebuie să fie în aceeași rețea Wi-Fi.';

  @override
  String get desktopLinkLimits =>
      'Telefonul continuă să funcționeze. Mesajele de pe internet ajung pe amândouă; ce trimiți de pe unul nu apare încă pe celălalt.';

  @override
  String get desktopLinkWaiting => 'Se așteaptă telefonul…';

  @override
  String get desktopLinkFailed =>
      'Contul nu a putut fi primit. Încearcă din nou.';

  @override
  String get desktopLinkRetry => 'Încearcă din nou';

  @override
  String get desktopLinkConfirmTitle =>
      'Trimiți o copie a acestui cont pe computer?';

  @override
  String get desktopLinkConfirmMessage =>
      'Computerul primește cheile, contactele și chaturile tale. Acest telefon continuă să funcționeze ca până acum.';

  @override
  String get desktopLinkConfirmAction => 'Trimite';

  @override
  String desktopLinkConfirmWhere(String address) {
    return 'Doar dacă ai scanat chiar acum acest cod de pe ecranul propriului computer. Copia pleacă la $address în această rețea.';
  }

  @override
  String get desktopLinkSending => 'Se trimite contul…';

  @override
  String get desktopLinkSent => 'Computerul e conectat';

  @override
  String get desktopLinkPhoneFound =>
      'Telefonul a găsit acest computer și face o copie a contului. Cu fotografii poate dura câteva minute.';

  @override
  String desktopLinkReceiving(int percent) {
    return 'Se primește contul: $percent%';
  }

  @override
  String get desktopLinkRestoring => 'Se instalează contul pe acest computer…';

  @override
  String get desktopLinkFinding => 'Se caută computerul…';

  @override
  String get desktopLinkPreparing =>
      'Se face o copie a contului. Cu fotografii poate dura câteva minute.';

  @override
  String desktopLinkSendingPercent(int percent) {
    return 'Se trimite: $percent%';
  }

  @override
  String get desktopLinkComputerRestoring => 'Computerul instalează contul…';

  @override
  String get devicesTitle => 'Dispozitive';

  @override
  String get devicesRowHint =>
      'Unde e deschis contul tău și deconectarea de acolo';

  @override
  String get devicesThisDevice => 'Acest dispozitiv';

  @override
  String get devicesSeenNow => 'Online chiar acum';

  @override
  String devicesSeenMinutes(int n) {
    return 'Online acum $n min';
  }

  @override
  String devicesSeenHours(int n) {
    return 'Online acum $n h';
  }

  @override
  String devicesSeenDays(int n) {
    return 'Online acum $n z';
  }

  @override
  String get devicesLeaving => 'Se deconectează — se așteaptă să apară online';

  @override
  String get devicesSignOut => 'Deconectează';

  @override
  String get devicesSignOutAll => 'Deconectează toate celelalte dispozitive';

  @override
  String devicesSignOutTitle(String name) {
    return 'Deconectezi „$name”?';
  }

  @override
  String get devicesSignOutMessage =>
      'Cheile, chaturile și setările CubeChat vor fi șterse de pe acel dispozitiv imediat ce apare online. Contul rămâne aici și pe celelalte dispozitive ale tale.';

  @override
  String get devicesSignOutPhoneMessage =>
      'Acela e un telefon: CubeChat va fi șters complet de pe el. Contul rămâne aici și pe celelalte dispozitive ale tale.';

  @override
  String get devicesSignOutAllMessage =>
      'Fiecare alt dispozitiv se va deconecta imediat ce apare online. Contul va rămâne doar aici.';

  @override
  String get devicesRename => 'Redenumește';

  @override
  String get devicesRenameTitle => 'Numele acestui dispozitiv';

  @override
  String get devicesSave => 'Salvează';

  @override
  String get devicesEmpty =>
      'Încă niciun alt dispozitiv. Un dispozitiv apare aici după ce deschide CubeChat 1.0.0+1147 sau mai nou.';

  @override
  String get devicesCaveat =>
      'Deconectarea are efect când dispozitivul acela intră online. Unul ținut offline își păstrează cheile; protecția completă ar însemna chei noi pentru cont.';

  @override
  String get desktopLinkImportTitle => 'Mută contul de pe telefon';

  @override
  String get desktopLinkImportHint =>
      'Arată-i telefonului un cod și acest computer devine o copie a contului lui';

  @override
  String get desktopLinkImportConfirmTitle =>
      'Înlocuiești contul de pe acest computer?';

  @override
  String get desktopLinkImportConfirmMessage =>
      'Cheile, contactele și chaturile acestui computer vor fi înlocuite cu contul telefonului. Dacă mai ai nevoie de acesta, fă mai întâi un backup.';

  @override
  String get desktopLinkImportConfirmAction => 'Continuă';

  @override
  String get desktopLinkUnreachable =>
      'Computerul nu a putut fi contactat. Ambele trebuie să fie în aceeași rețea Wi-Fi, iar pe computer CubeChat trebuie permis în firewall.';

  @override
  String get desktopLinkFirewallHint =>
      'Windows poate bloca accesul telefonului la acest computer. Permite CubeChat în firewall — doar pentru rețeaua ta locală.';

  @override
  String get desktopLinkFirewallAllow => 'Permite în firewall';

  @override
  String get desktopLinkFirewallDeclined =>
      'Windows nu a permis. Fără asta, telefonul s-ar putea să nu ajungă la computer.';

  @override
  String get phoneTransferIntro =>
      'Mută profilul, cheile, contactele, canalele, setările și istoricul direct între două telefoane.';

  @override
  String get phoneTransferSend => 'Acesta e telefonul vechi';

  @override
  String get phoneTransferReceive => 'Acesta e telefonul nou';

  @override
  String get phoneTransferSameWifi =>
      'Conectează ambele telefoane la aceeași rețea Wi-Fi. Ține acest ecran deschis până la finalizarea transferului.';

  @override
  String get phoneTransferPreparing => 'Se pregătește transferul criptat…';

  @override
  String get phoneTransferReady =>
      'Scanează acest cod QR de unică folosință pe telefonul nou';

  @override
  String get phoneTransferScan => 'Scanează telefonul vechi';

  @override
  String get phoneTransferConfirmTitle =>
      'Înlocuiești profilul de pe acest telefon?';

  @override
  String get phoneTransferConfirmMessage =>
      'Profilul stocat acum pe acest telefon va fi înlocuit prin transferul local criptat.';

  @override
  String get phoneTransferConfirmAction => 'Transferă profilul';

  @override
  String get phoneTransferSuccess => 'Profil transferat cu succes';

  @override
  String get phoneTransferFailed =>
      'Transferul între telefoane nu a putut fi finalizat';

  @override
  String get profileSummaryMeshOnly => 'Doar mesh';

  @override
  String get profileSummaryMeshInternet => 'Mesh · internet';

  @override
  String get profileSummaryBackgroundOn => 'rulează în fundal';

  @override
  String profileSummaryTransfersActive(int count) {
    return '$count în curs';
  }

  @override
  String get profileSummaryCardBackup => 'Fișiere, backup';

  @override
  String get chatPlay => 'Redă';

  @override
  String get chatPause => 'Pauză';

  @override
  String get profileTheme => 'Culoare';

  @override
  String get profileThemeEmerald => 'Smarald';

  @override
  String get profileThemeIndigo => 'Indigo';

  @override
  String get profileThemeAmber => 'Chihlimbar';

  @override
  String get profileThemeRose => 'Trandafir';

  @override
  String get profileThemeFuchsia => 'Fucsia';

  @override
  String get profileThemeViolet => 'Violet';

  @override
  String get profileThemeOcean => 'Ocean';

  @override
  String get profileThemeSlate => 'Ardezie';

  @override
  String get profileScale => 'Mărimea interfeței';

  @override
  String get profileScaleSystem => 'Sistem';

  @override
  String get profileGlass => 'Sticlă';

  @override
  String get profileGlassAuto => 'Automat';

  @override
  String get profileGlassFull => 'Complet';

  @override
  String get profileGlassLight => 'Ușor';

  @override
  String get profileGlassHint =>
      'Ușor păstrează nuanța și renunță la estomparea din spatele panourilor. Automat îți măsoară telefonul o dată și decide. Pe un telefon care face deja față asta contează foarte puțin — e pentru unul care nu face față.';

  @override
  String get mapAlwaysNeeded =>
      'Ca harta să se actualizeze cât timp cubechat e închis, Locația trebuie setată pe Întotdeauna. Atinge pentru a deschide Setările.';

  @override
  String get mapShareConsentTitle => 'Îți arăți locația pe hartă?';

  @override
  String get mapShareConsentBody =>
      'Locația ta în timp real va fi afișată doar contactelor de pe harta ta: persoanele pe care le-ai invitat sau a căror invitație ai acceptat-o. Se actualizează continuu, inclusiv cât timp Cubechat e în fundal, până te ascunzi. E criptată integral și nu ajunge niciodată la noi. Te poți ascunde oricând de pe hartă sau din Profil, iar contactele pe care le blochezi nu te văd niciodată.';

  @override
  String get mapShareConsentAllow => 'Permite';

  @override
  String get mapShareConsentDecline => 'Nu permite';

  @override
  String get mapVisibleToFriends => 'Prietenii de pe hartă te văd';

  @override
  String get mapHiddenFromFriends => 'Ești ascuns';

  @override
  String get mapHideMe => 'Ascunde-mă';

  @override
  String get mapShowMe => 'Arată-mă';

  @override
  String get profileScaleSmall => 'Mai mic';

  @override
  String get profileScaleNormal => 'Normal';

  @override
  String get profileScaleLarge => 'Mai mare';

  @override
  String get profileScaleSample =>
      'Textul și rândurile sunt afișate la această mărime.';

  @override
  String get savedTitle => 'Salvate';

  @override
  String get savedSubtitle => 'Notițe pentru tine, pe acest dispozitiv';

  @override
  String get savedEmpty => 'Tot ce scrii aici rămâne pe acest telefon.';

  @override
  String get meshOffTitle => 'Rețeaua mesh Bluetooth e oprită';

  @override
  String get meshOffHint =>
      'Nimeni din apropiere nu te poate găsi și nici tu nu-i poți găsi. Mesajele circulă în continuare prin releul de internet.';

  @override
  String get profileMeshSwitch => 'Rețea mesh Bluetooth';

  @override
  String get profileMeshSwitchHint =>
      'Găsește persoane din apropiere și transmite mesaje fără internet. Oprită, economisește bateria.';

  @override
  String get channelAdminOnlyHint =>
      'Un canal de anunțuri. Toată lumea îl poate citi în continuare.';

  @override
  String get attachLocation => 'Locație';

  @override
  String get locationBubbleTitle => 'Locație';

  @override
  String get locationOpenInMaps => 'Deschide în hărți';

  @override
  String locationAccuracy(int metres) {
    return 'cu precizie de $metres m';
  }

  @override
  String get locationExpired => 'Această locație nu mai este actuală';

  @override
  String get locationDenied => 'Permisiunea de localizare e dezactivată';

  @override
  String get locationUnavailable => 'Poziția nu a putut fi obținută';

  @override
  String get locationShareFor => 'Partajează pentru';

  @override
  String get locationShareOnce => 'O singură dată';

  @override
  String get locationShare15m => '15 minute';

  @override
  String get locationShare1h => '1 oră';

  @override
  String get storageTitle => 'Stocare';

  @override
  String get storageHeadline => 'Utilizarea spațiului';

  @override
  String storageSubtitle(String size) {
    return 'cubechat folosește $size pe acest dispozitiv';
  }

  @override
  String get storageEmpty => 'Încă nimic stocat';

  @override
  String get storageScanning => 'Se măsoară…';

  @override
  String get storageCatPhotos => 'Fotografii';

  @override
  String get storageCatVoice => 'Mesaje vocale';

  @override
  String get storageCatFiles => 'Fișiere primite';

  @override
  String get storageCatOutbox => 'Fișiere trimise';

  @override
  String get storageCatStickers => 'Stickere';

  @override
  String get storageCatSaved => 'Mesaje salvate';

  @override
  String get storageCatWallpapers => 'Fundaluri';

  @override
  String get storageCatHistory => 'Conversații și chei';

  @override
  String get storageCatCache => 'Cache';

  @override
  String storageClear(String size) {
    return 'Golește $size';
  }

  @override
  String get storageClearNothing => 'Nimic selectat';

  @override
  String storageFreed(String size) {
    return 'S-au eliberat $size';
  }

  @override
  String get storageNoCloud =>
      'În spatele acestui lucru nu există niciun cloud. Tot ce golești dispare de pe acest telefon, iar singura altă copie e pe telefonul de la care a venit.';

  @override
  String get storageWhyHistoryLocked =>
      'Conversațiile nu se golesc de aici — folosește Ștergerea de urgență.';

  @override
  String get storageRecoveryFree => 'Se poate goli în siguranță';

  @override
  String get storageRecoveryGone => 'Nicio copie în altă parte';

  @override
  String get storageRecoveryAskSender => 'Poate fi cerut din nou expeditorului';

  @override
  String get storageRecoveryCostsThem => 'Nu-ți mai pot cere să retrimiți';

  @override
  String storageConfirmTitle(String size) {
    return 'Golești $size?';
  }

  @override
  String get storageConfirmBody =>
      'Fișierele vor fi șterse de pe acest telefon. Nimic nu e încărcat nicăieri, deci nu există de unde să fie restaurate.';

  @override
  String storageFilesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count de fișiere',
      few: '$count fișiere',
      one: '$count fișier',
      zero: 'gol',
    );
    return '$_temp0';
  }

  @override
  String get customizeBarTitle => 'Bara de navigare';

  @override
  String get customizeBarHint =>
      'Trage ca să reordonezi. Chaturile nu pot fi eliminate.';

  @override
  String get customizeBarShown => 'Afișate';

  @override
  String get customizeBarHidden => 'Ascunse';

  @override
  String get customizeBarHiddenEmpty => 'Nimic ascuns';

  @override
  String get customizeBarMinimum => 'Păstrează cel puțin două file';

  @override
  String get customizeReset => 'Resetează la implicit';

  @override
  String get chatsArchiveTitle => 'Arhivă';

  @override
  String get chatsArchiveEmpty => 'Nimic arhivat';

  @override
  String get chatsArchiveHint =>
      'Chaturile arhivate funcționează în continuare — doar nu mai sunt în listă.';

  @override
  String get chatsArchivedToast => 'Arhivat';

  @override
  String get chatsUnarchivedToast => 'Înapoi în listă';

  @override
  String chatsArchiveCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count de chaturi',
      few: '$count chaturi',
      one: '$count chat',
    );
    return '$_temp0';
  }

  @override
  String get chatsSwipeNotHere => 'Indisponibil pentru acest chat';

  @override
  String get customizeSwipeTitle => 'Glisarea unui chat la dreapta';

  @override
  String get customizeSwipeHint =>
      'Glisarea la stânga trece în continuare între file.';

  @override
  String get customizeSwipeArchive => 'Arhivează';

  @override
  String get customizeSwipeMute => 'Fără sunet';

  @override
  String get customizeSwipePin => 'Fixează';

  @override
  String get customizeSwipeRead => 'Citit';

  @override
  String get customizeSwipeDelete => 'Șterge';

  @override
  String get customizeSwipeNone => 'Nimic';

  @override
  String get customizeHighRefresh => 'Rată de reîmprospătare maximă';

  @override
  String get customizeHighRefreshHint =>
      'Mai fluid, iar telefonul desenează de două ori mai multe cadre. Dezactivează dacă se încălzește — aspectul aplicației nu se schimbă, doar cât de des e redesenată.';

  @override
  String get customizeQuickReaction => 'Reacție la dublă atingere';

  @override
  String get customizeQuickReactionHint =>
      'Ce lasă o dublă atingere pe un mesaj. Dacă folosești alta, ea ajunge aici.';

  @override
  String get customizeCircleAudioTitle =>
      'Pune muzica pe pauză pentru mesajele video';

  @override
  String get customizeCircleAudioOn =>
      'Înregistrarea sau vizionarea unuia oprește orice altceva rulează. Nu repornește singur.';

  @override
  String get customizeCircleAudioOff =>
      'Muzica ta continuă în fundal, mai încet cât rulează un mesaj video.';

  @override
  String get customizeMediaQualityTitle =>
      'Calitatea fotografiilor la trimitere';

  @override
  String get customizeMediaQualityEconomy => 'Economic';

  @override
  String get customizeMediaQualityStandard => 'Standard';

  @override
  String get customizeMediaQualityHigh => 'Ridicată';

  @override
  String get customizeMediaQualityEconomyHint =>
      'Până la 96 KB pe fotografie, 800 px. Pentru o liniuță de semnal sau o rețea mesh Bluetooth aglomerată: jumătate din așteptare, o imagine mai puțin clară.';

  @override
  String get customizeMediaQualityStandardHint =>
      'Până la 192 KB pe fotografie, 1280 px. Dimensionată ca să treacă și doar prin Bluetooth. Clipurile video și „Original” se trimit mereu așa cum sunt.';

  @override
  String get customizeMediaQualityHighHint =>
      'Până la 768 KB pe fotografie, 2048 px. Destul de clară pentru zoom; durează de patru ori mai mult la trimitere, deci ideal pe Wi-Fi.';

  @override
  String get previewReacted => 'la mesajul tău';

  @override
  String get previewLocation => 'Locație';

  @override
  String get previewMapInvite => 'Invitație pe hartă';

  @override
  String get previewContact => 'Contact';

  @override
  String get previewUnsupported => 'Mesaj neacceptat';

  @override
  String get previewCallOutgoing => 'Apel efectuat';

  @override
  String get previewCallIncoming => 'Apel primit';

  @override
  String get previewCallMissed => 'Apel pierdut';

  @override
  String chatPreparingPhotos(int count) {
    return 'Se pregătesc fotografiile ($count)…';
  }

  @override
  String get circleSwitchCamera => 'Schimbă camera';

  @override
  String get circleLight => 'Lumină pentru înregistrare';

  @override
  String get circleCameraSwitchFailed =>
      'Camera nu a putut fi schimbată. Înregistrarea rămâne deschisă.';

  @override
  String get diagnosticsTitle => 'Diagnosticare';

  @override
  String get diagnosticsIntro =>
      'Ce a făcut aplicația în ultima vreme. Dacă ceva nu funcționează, trimite asta dezvoltatorului.';

  @override
  String get diagnosticsShare => 'Trimite jurnalul dezvoltatorului';

  @override
  String get diagnosticsEvents => 'Evenimente recente';

  @override
  String get diagnosticsTechnical => 'Înregistrări tehnice';

  @override
  String get diagnosticsEmpty => 'Încă nimic de afișat.';

  @override
  String get diagnosticsDeveloperOn => 'Modul dezvoltator activat';

  @override
  String get diagnosticsDeveloperOff => 'Modul dezvoltator dezactivat';

  @override
  String get logAppStarted => 'Aplicația a pornit';

  @override
  String get logInternetOn => 'Conexiunea la internet activată';

  @override
  String logServerConnected(String host) {
    return 'Conectat la $host';
  }

  @override
  String logServerLost(String host) {
    return 'Conexiunea cu $host s-a pierdut';
  }

  @override
  String get chatSaveAction => 'Salvează';

  @override
  String get savedTagAsk => 'Salvat. Adaugi o etichetă?';

  @override
  String get savedTagAdd => 'Adaugă o etichetă';

  @override
  String get chatSharedWallpaperFailed =>
      'Fundal setat aici. Va ajunge la celălalt când va fi în rază.';

  @override
  String get chatTranscribeAction => 'Transcrie';

  @override
  String get chatTranscribeFailed =>
      'Acest telefon nu poate transcrie mesajul.';

  @override
  String get chatTranscribing => 'Se recunoaște…';

  @override
  String get chatTranscriptHide => 'Ascunde textul';

  @override
  String get chatCancelSend => 'Anulează trimiterea';

  @override
  String get chatDownloadAction => 'Descarcă';

  @override
  String get chatDownloaded => 'Salvat pe telefon';

  @override
  String get chatDownloadFailed => 'Nu a putut fi salvat';

  @override
  String get selfUpdateTitle => 'Instalează o actualizare dintr-un fișier';

  @override
  String get selfUpdateHint =>
      'Alege aici noul APK cubechat în loc să-l deschizi dintr-un chat: instalat așa, apelurile pe ecranul de blocare rămân activate.';

  @override
  String get selfUpdateConfirm =>
      'Confirmă instalarea în fereastra sistemului.';

  @override
  String get selfUpdateAllow =>
      'Permite-i cubechat să instaleze aplicații, apoi atinge din nou.';

  @override
  String get selfUpdateNotOurs => 'Fișierul nu este o actualizare cubechat.';

  @override
  String get selfUpdateFailed => 'Actualizarea nu a fost instalată.';

  @override
  String get chatTranscribeDownloading =>
      'Telefonul descarcă limba necesară. Încearcă din nou peste un minut.';

  @override
  String get chatTranscribeNoLanguage =>
      'Acest telefon nu are un model de vorbire pentru limba respectivă. Alege limba pentru transcriere în Profil → Chaturi și media.';

  @override
  String get chatTranscribeNotAllowed =>
      'Recunoașterea vorbirii e dezactivată pentru CubeChat. Activeaz-o în Setările iPhone → CubeChat.';

  @override
  String get customizeTranscribeLanguageTitle => 'Limba pentru transcriere';

  @override
  String get customizeTranscribeLanguageAuto => 'Auto';

  @override
  String get customizeTranscribeLanguageHint =>
      'Limba în care se vorbește în mesaje, care nu trebuie să fie limba aplicației. Auto încearcă limbile telefonului. O limbă lipsă e descărcată de telefon; vocea nu părăsește niciodată telefonul.';

  @override
  String get chatTranslateAction => 'Traduce';

  @override
  String get chatTranslateFailed =>
      'Mesajul nu poate fi tradus pe acest telefon.';

  @override
  String get customizeDeferMediaTitle =>
      'Așteaptă Wi-Fi pentru descărcarea media';

  @override
  String get customizeDeferMediaHint =>
      'Pe date mobile, mesajele text și apelurile funcționează ca de obicei, iar fotografiile, mesajele vocale, mesajele video și fișierele așteaptă Wi-Fi pe server — până la două săptămâni. Un rând deasupra chaturilor arată ce așteaptă și le descarcă imediat.';

  @override
  String heldMediaCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count de elemente media așteaptă Wi-Fi',
      few: '$count elemente media așteaptă Wi-Fi',
      one: '1 element media așteaptă Wi-Fi',
    );
    return '$_temp0';
  }

  @override
  String get heldMediaDownload => 'Descarcă';

  @override
  String get nearbyAirDropSubtitle =>
      'Partajează fișiere cu persoane din apropiere';

  @override
  String get nearbyFilesSubtitle => 'Fișiere trimise și primite';

  @override
  String get airdropTab => 'AirDrop';

  @override
  String get nearbyTabFiles => 'Fișiere';

  @override
  String get airdropReceiveHint => 'Cine îți poate trimite fișiere';

  @override
  String get airdropReceiveContacts => 'Contacte';

  @override
  String get airdropReceiveEveryone => 'Toți 10 min';

  @override
  String airdropEveryoneLeft(String time) {
    return 'Toți · $time';
  }

  @override
  String get airdropSendFiles => 'Trimite fișiere';

  @override
  String get airdropChooseFiles => 'Alege fișiere';

  @override
  String airdropStagedTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count de fișiere pregătite',
      few: '$count fișiere pregătite',
      one: '1 fișier pregătit',
    );
    return '$_temp0';
  }

  @override
  String get airdropStagedHint =>
      'Cu Bluetooth activat și AirDrop deschis pe ambele telefoane, apropie-le sau alege o persoană';

  @override
  String get airdropStagedPickPerson => 'Alege persoana';

  @override
  String airdropRequestBody(String what, String size) {
    return 'vrea să trimită $what · $size';
  }

  @override
  String airdropWhatPhotos(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count de fotografii',
      few: '$count fotografii',
      one: '1 fotografie',
    );
    return '$_temp0';
  }

  @override
  String airdropWhatVideos(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count de videoclipuri',
      few: '$count videoclipuri',
      one: '1 videoclip',
    );
    return '$_temp0';
  }

  @override
  String airdropWhatFiles(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count de fișiere',
      few: '$count fișiere',
      one: '1 fișier',
    );
    return '$_temp0';
  }

  @override
  String get airdropAccept => 'Acceptă';

  @override
  String get airdropDecline => 'Refuză';

  @override
  String get airdropWaiting => 'Se așteaptă un răspuns…';

  @override
  String get airdropAccepted => 'Acceptat';

  @override
  String get airdropUnheard =>
      'Nu a fost primit — poate o versiune veche de CubeChat';

  @override
  String get airdropSending => 'Se trimite';

  @override
  String get airdropReceiving => 'Se primește';

  @override
  String get airdropInterrupted => 'Întrerupt';

  @override
  String get airdropRetry => 'Reîncearcă';

  @override
  String get airdropOutcomeSent => 'Trimis';

  @override
  String get airdropOutcomeReceived => 'Primit';

  @override
  String get airdropOutcomeDeclined => 'Refuzat';

  @override
  String get airdropOutcomeCancelled => 'Anulat';

  @override
  String get airdropOutcomePartial => 'Parțial';

  @override
  String get airdropReasonNoSpace => 'spațiu insuficient';

  @override
  String get airdropReasonContactsOnly => 'doar de la contacte';

  @override
  String get airdropReasonBusy => 'ocupat';

  @override
  String get airdropReasonTimeout => 'niciun răspuns';

  @override
  String get airdropFileDeleted => 'șters';

  @override
  String get airdropHistory => 'Istoric';

  @override
  String get airdropClearHistory => 'Golește istoricul';

  @override
  String get airdropEmpty =>
      'Fișierele pe care le trimiți sau le primești în apropiere vor apărea aici';

  @override
  String get airdropPickPerson => 'Trimite către';

  @override
  String get airdropNobody => 'Încă nimeni cu cubechat în apropiere';

  @override
  String get airdropNoDirect => 'Nicio conexiune Bluetooth cu această persoană';

  @override
  String get airdropNearbyUnknown => 'În apropiere';

  @override
  String get airdropConnecting => 'Se conectează…';

  @override
  String get airdropConnectFailed => 'Conectarea a eșuat';

  @override
  String get airdropSlowWarning => 'Prin Bluetooth poate dura mult';

  @override
  String airdropTooLarge(String name, int limit) {
    return '$name depășește $limit MB';
  }

  @override
  String airdropFromLabel(String name) {
    return 'AirDrop · $name';
  }

  @override
  String get airdropWrite => 'Mesaj';

  @override
  String get airdropAction => 'AirDrop';

  @override
  String get airdropLaneTitle => 'Canal';

  @override
  String get airdropLaneAuto => 'Auto';

  @override
  String get airdropLaneBluetooth => 'Bluetooth';

  @override
  String get airdropLaneWifi => 'Wi‑Fi';

  @override
  String get airdropBluetoothNeededHint =>
      'Activează Bluetooth pe ambele telefoane ca să se găsească și să confirme un transfer.';

  @override
  String get airdropLaneHint =>
      'Bluetooth găsește și conectează telefoanele. Wi‑Fi transferă fișierele când ambele telefoane sunt în aceeași rețea sau pe același hotspot.';

  @override
  String get airdropWifiUnreachable => 'Nu sunteți în aceeași rețea';

  @override
  String get airdropWifiOldVersion =>
      'Aplicația lui încă nu poate primi prin Wi‑Fi';

  @override
  String get airdropBumpAdd => 'Adaugă';

  @override
  String get airdropBumpAlreadyContact => 'E deja în contactele tale';

  @override
  String airdropBumpSending(String name) {
    return 'Se trimite către $name';
  }

  @override
  String airdropBumpReceiving(String name) {
    return '$name îți trimite fișiere';
  }

  @override
  String get termsTitle => 'Regulile cubechat';

  @override
  String get termsBody =>
      'cubechat are toleranță zero față de conținutul inacceptabil și utilizatorii abuzivi. Continuând, ești de acord să nu trimiți hărțuire, amenințări, conținut sexual care implică minori, spam sau orice lucru ilegal. Oricine poate raporta un mesaj sau o persoană; raportările ajung la dezvoltator și sunt soluționate în 24 de ore, iar cei care încalcă regulile sunt blocați.';

  @override
  String get termsReadFull => 'Citește termenii completi';

  @override
  String get termsAccept => 'Sunt de acord';

  @override
  String get messageHide => 'Ascunde';

  @override
  String get messageHidden => 'Ascuns pentru tine';

  @override
  String get reportAction => 'Raportează';

  @override
  String get reportTitle => 'Care e problema?';

  @override
  String get reportReasonSpam => 'Spam';

  @override
  String get reportReasonAbuse => 'Abuz sau hărțuire';

  @override
  String get reportReasonViolence => 'Violență';

  @override
  String get reportReasonSexual => 'Conținut sexual';

  @override
  String get reportReasonOther => 'Altceva';

  @override
  String get reportNoteHint => 'Descrie (opțional)';

  @override
  String get reportSend => 'Trimite raportarea';

  @override
  String get reportDisclosure =>
      'Textul mesajului selectat și raportarea ta ajung la moderarea cubechat și la botul ei privat de Telegram.';

  @override
  String get reportSent =>
      'Raportare trimisă. Analizăm raportările în 24 de ore.';

  @override
  String get reportBlockedToo => 'Persoana e blocată pentru tine.';

  @override
  String get reportQueued =>
      'Raportare salvată. Va fi trimisă când ești online.';

  @override
  String get reportFailed => 'Raportarea nu a putut fi trimisă.';

  @override
  String get filteredMessage => 'Ascuns de filtru';

  @override
  String get filteredShow => 'Arată';

  @override
  String get filterToggle => 'Filtru pentru conținut ofensator';

  @override
  String get filterToggleHint =>
      'Ascunde cuvintele vulgare de la străini și din canale';

  @override
  String get aboutTitle => 'Despre';

  @override
  String get aboutContact => 'Scrie-i dezvoltatorului';

  @override
  String get aboutReport => 'Raportează o încălcare';

  @override
  String get aboutTerms => 'Termeni de utilizare';

  @override
  String get aboutPrivacy => 'Politica de confidențialitate';

  @override
  String get requestsTitle => 'Solicitări';

  @override
  String get requestsEmpty => 'Nicio solicitare';

  @override
  String requestBanner(String name) {
    return '$name nu e în contactele tale. Nu poate vedea că ai citit și nu te poate suna până nu accepți.';
  }

  @override
  String get requestAccept => 'Acceptă';

  @override
  String get requestDelete => 'Șterge';

  @override
  String get requestBlock => 'Blochează';

  @override
  String get cubeIdTitle => 'Cube ID';

  @override
  String get cubeIdExplainer =>
      '@numele tău trimite la cardul tău de contact. Serverul păstrează doar numele și cardul tău public — niciodată mesajele.';

  @override
  String get cubeIdFieldHint => 'a–z, 0–9 și _, 3–20 de caractere';

  @override
  String get cubeIdAvailable => 'Disponibil';

  @override
  String get cubeIdTaken => 'Ocupat';

  @override
  String get cubeIdReserved => 'Nepermis';

  @override
  String get cubeIdInvalid => 'Doar a–z, 0–9 și _, 3–20 de caractere';

  @override
  String get cubeIdClaim => 'Ia acest nume';

  @override
  String get cubeIdWorking => 'Se rezervă numele…';

  @override
  String get cubeIdChange => 'Schimbă';

  @override
  String get cubeIdEmail => 'E-mail de recuperare';

  @override
  String get cubeIdEmailHint =>
      'Dacă pierzi telefonul, numele revine printr-un e-mail trimis la această adresă';

  @override
  String get cubeIdEmailField => 'E-mail';

  @override
  String cubeIdEmailSent(String email) {
    return 'Am trimis un e-mail la $email. Deschide linkul din el.';
  }

  @override
  String get cubeIdEmailRemove => 'Elimină e-mailul';

  @override
  String get cubeIdEmailUnavailable =>
      'E-mailul nu e disponibil acum. Încearcă mai târziu.';

  @override
  String get cubeIdEmailInvalid => 'Nu pare o adresă de e-mail';

  @override
  String get cubeIdSave => 'Salvează';

  @override
  String get cubeIdRecover => 'Recuperează un nume prin e-mail';

  @override
  String get cubeIdRecoverSent =>
      'Dacă adresa se potrivește, vei primi un e-mail. Numele trece pe acest telefon la 48 de ore după ce deschizi linkul.';

  @override
  String cubeIdRecoveryWarning(String name, String when) {
    return 'Cineva recuperează @$name pe alt telefon prin e-mail. Numele se mută pe $when, dacă nu anulezi.';
  }

  @override
  String get cubeIdRecoveryCancel => 'Anulează recuperarea';

  @override
  String get cubeIdRecoveryCancelled => 'Recuperare anulată';

  @override
  String get cubeIdRelease => 'Eliberează';

  @override
  String cubeIdReleaseConfirm(String name) {
    return 'Eliberezi @$name? Oricine îl va putea lua.';
  }

  @override
  String get cubeIdShare => 'Partajează';

  @override
  String cubeIdShareText(String name) {
    return 'Găsește-mă în cubechat: @$name\nhttps://cubechat.tech/u.html#$name';
  }

  @override
  String get cubeIdFailed => 'Numele nu a putut fi salvat. Încearcă din nou.';

  @override
  String get cubeIdOffline => 'Fără internet';

  @override
  String get lookupNotFound => 'Nimeni cu acest @nume';

  @override
  String searchFindCubeName(String name) {
    return 'Găsește @$name';
  }

  @override
  String get searchFindCubeNameHint => 'Caută în Cube ID și adaugă';

  @override
  String get addContactHintName => 'Lipește un card sau tastează @nume';

  @override
  String get strangerReachTitle => 'Cine îmi poate scrie de pe internet';

  @override
  String get strangerReachAll => 'Toți';

  @override
  String get strangerReachRequest => 'Cu solicitare';

  @override
  String get strangerReachNone => 'Nimeni';

  @override
  String get strangerReachHint =>
      'Pentru persoanele cărora nu le-ai scris și care te contactează prin internet. Persoanele din apropiere prin Bluetooth nu sunt afectate.';

  @override
  String get sectionPrivacy => 'Confidențialitate și securitate';

  @override
  String get sectionNotifications => 'Notificări și apeluri';

  @override
  String get sectionConnection => 'Conexiune';

  @override
  String get sectionChats => 'Chaturi și media';

  @override
  String get sectionAppearance => 'Aspect';

  @override
  String get sectionData => 'Date și stocare';

  @override
  String get sectionAbout => 'Despre';

  @override
  String get subWhoSeesMe => 'Cine mă vede';

  @override
  String get subProtection => 'Protecție';

  @override
  String get subNotifications => 'Notificări';

  @override
  String get subCalls => 'Apeluri';

  @override
  String get profileDiscoverableMeshOff =>
      'Rețeaua mesh Bluetooth e oprită — activeaz-o la Conexiune.';

  @override
  String get chatRouteBluetoothDirect => 'Bluetooth, direct';

  @override
  String chatRouteMeshHops(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Mesh · $n de salturi',
      few: 'Mesh · $n salturi',
      one: 'Mesh · $n salt',
    );
    return '$_temp0';
  }

  @override
  String chatRouteDeliveredVia(String route) {
    return 'Livrat: $route';
  }

  @override
  String chatRouteReceivedVia(String route) {
    return 'Primit: $route';
  }

  @override
  String get chatUnreadDivider => 'Mesaje noi';

  @override
  String get radioTitle => 'Stație radio';

  @override
  String get radioNearbySubtitle =>
      'Ține apăsat un buton și vorbește cu un grup sau un contact';

  @override
  String get radioGroupsLabel => 'Grupuri';

  @override
  String get radioDirectLabel => 'Personal';

  @override
  String get radioAddGroup => 'Adaugă o stație';

  @override
  String get radioNoGroups =>
      'Încă nicio stație. Adaugă una — toți cei care introduc același nume și aceeași parolă se aud între ei.';

  @override
  String get radioLeave => 'Părăsește această stație';

  @override
  String get radioPickChannel => 'Alege un grup sau un contact';

  @override
  String get radioPushToTalk => 'Ține apăsat și vorbește';

  @override
  String get radioTalking => 'Vorbești…';

  @override
  String get radioChannelBusy => 'Canal ocupat';

  @override
  String radioSpeaker(String name) {
    return 'Vorbește $name';
  }

  @override
  String get radioSilentTitle => 'Vorbește în modul silențios';

  @override
  String get radioSilentHint =>
      'Vocea se aude chiar și când telefonul e pe silențios.';

  @override
  String get radioJoinNameLabel => 'Nume';

  @override
  String get radioJoinPasswordLabel => 'Parolă (opțional)';

  @override
  String get radioJoinHint =>
      'Toți cei care introduc același nume și aceeași parolă sunt pe aceeași stație. Niciun server nu păstrează lista lor.';

  @override
  String get radioJoinNameRequired => 'Introdu un nume';

  @override
  String get radioJoinSubmit => 'Adaugă';

  @override
  String get radioBlockedTooLong => 'Întrerupt după un minut de vorbit';

  @override
  String get radioBlockedCall => 'Un apel e în curs';

  @override
  String get radioBlockedMicrophone => 'Fără acces la microfon';

  @override
  String get radioBlockedUnavailable =>
      'Stația nu e disponibilă pe acest dispozitiv';

  @override
  String get radioBlockedNoChannel => 'Alege mai întâi un grup sau un contact';

  @override
  String get radioTurnOff => 'Oprește stația';

  @override
  String get radioPersonalCallsTitle => 'Primește apeluri personale';

  @override
  String get radioPersonalCallsHint =>
      'Cât timp stația e oprită, un contact care îți vorbește o acordează pe el.';

  @override
  String get radioBackgroundHint =>
      'Cu ecranul stins, stația se aude doar dacă modul în fundal e activat.';

  @override
  String get areaNearby => 'Chat în apropiere';

  @override
  String get areaLevelDistrict => 'Cartier';

  @override
  String get areaLevelCity => 'Oraș';

  @override
  String get areaLevelRegion => 'Regiune';

  @override
  String areaPresentCount(int count) {
    return '≈$count aici';
  }

  @override
  String get areaPresentMany => '50+ aici';

  @override
  String get areaBlockViaBluetooth => 'Zona ta — prin Bluetooth';

  @override
  String get areaOpenNearbyTab => 'Deschide În apropiere';

  @override
  String get areaLocating => 'Se caută cartierul tău…';

  @override
  String get areaNoPlace =>
      'Încă nicio locație. Chatul zonei are nevoie de locația ta aproximativă cât timp acest ecran e deschis.';

  @override
  String get areaLocationDenied =>
      'Locația e dezactivată pentru Cubechat. Permite locația aproximativă în Setări ca să-ți vezi cartierul.';

  @override
  String get areaOffline => 'Nicio conexiune la chatul zonei';

  @override
  String get areaEmpty => 'Nimeni n-a scris aici în ultimele 24 de ore.';

  @override
  String get areaConsentTitle => 'Chatul zonei e public';

  @override
  String get areaConsentBody =>
      'Mesajele de aici sunt publice. Oricine îți deschide cartierul sau orașul le va citi, iar ele sunt păstrate 24 de ore pe serverul Cubechat. Scrii sub un nume temporar care se schimbă la câteva ore; nimeni nu-ți vede @numele sau contactele. Ca să-ți afle cartierul, Cubechat îți cere locația aproximativă, doar cât timp acest ecran e deschis.';

  @override
  String get areaConsentAllow => 'Continuă';

  @override
  String get areaConsentDecline => 'Nu acum';

  @override
  String areaDefaultName(String tag) {
    return 'Cub-$tag';
  }

  @override
  String areaYouAre(String name, int hours) {
    return 'Ești $name · nume nou în $hours h';
  }

  @override
  String get areaNewName => 'Nume nou';

  @override
  String get areaSetName => 'Alege un nume';

  @override
  String get areaNameHint =>
      'Doar pentru cele câteva ore ale acestui nume. Lasă gol pentru numele automat.';

  @override
  String get areaNameSameWarning => 'Același nume te leagă între cartiere';

  @override
  String get areaShowPresence => 'Arată că sunt aici';

  @override
  String get areaPresenceOffHint =>
      'Activează „Arată că sunt aici” ca să vezi câte persoane sunt în apropiere';

  @override
  String get areaReadOnly => 'Poți scrie doar acolo unde ești';

  @override
  String get areaComposerHint => 'Mesaj pentru toți cei de aici';

  @override
  String get areaSend => 'Trimite';

  @override
  String get areaWaitALittle => 'Așteaptă puțin';

  @override
  String areaFlood(int count) {
    return 'Flood ($count) · Arată';
  }

  @override
  String get areaReply => 'Răspunde';

  @override
  String get areaHide => 'Ascunde';

  @override
  String get areaBlock => 'Blochează până își schimbă numele';

  @override
  String get areaBlocked => 'Blocat până își schimbă numele';

  @override
  String get areaReport => 'Raportează';

  @override
  String get areaOpenLink => 'Deschide linkul';

  @override
  String areaOpenLinkConfirm(String url) {
    return 'Deschizi $url?';
  }

  @override
  String get areaOpen => 'Deschide';

  @override
  String get areaReadHere => 'Citește aici';

  @override
  String get areaReadHereHint =>
      'Doar citire. Poți scrie doar acolo unde ești; releul află ce loc citești.';

  @override
  String get areaNotes => 'Bilețele';

  @override
  String areaNotesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count de bilețele',
      few: '$count bilețele',
      one: '$count bilețel',
      zero: 'Niciun bilețel',
    );
    return '$_temp0';
  }

  @override
  String get areaLeaveNote => 'Lasă un bilețel';

  @override
  String get areaNoteHint => 'Un bilețel scurt pentru orașul tău';

  @override
  String get areaNoteLifetime => 'Rămâne';

  @override
  String get areaNote1h => '1 h';

  @override
  String get areaNote24h => '24 h';

  @override
  String get areaNote7d => '7 zile';

  @override
  String get areaPinToDistrict => 'Fixează pe un cartier';

  @override
  String get areaPinHint =>
      'Atinge harta în interiorul orașului tău; marcajul se prinde de cartierul respectiv.';

  @override
  String get areaPinOutside => 'Doar în interiorul orașului tău';

  @override
  String get areaNoteDelete => 'Șterge bilețelul meu';

  @override
  String get areaNoNotes => 'Încă niciun bilețel aici';

  @override
  String get areaNotesLimit => 'Trei bilețele pe zi';

  @override
  String get areaNoteLeft => 'Bilețel lăsat';

  @override
  String get areaNoteSend => 'Lasă';

  @override
  String get areaOwnNote => 'Bilețelul tău';

  @override
  String get areaNotePinned => 'Fixat pe un cartier';

  @override
  String get areaHidden => 'Ascuns';

  @override
  String get areaPublicBadge => 'Public · păstrat 24 h';

  @override
  String get areaSettingTitle => 'Chatul zonei';

  @override
  String get areaSettingOnHint =>
      'Butonul Chat în apropiere de pe hartă: chaturi publice ale cartierului și orașului tău, sub un nume temporar.';

  @override
  String get areaSettingOffHint =>
      'Dezactivat: niciun buton pe hartă, iar chatul zonei nu-ți cere niciodată locația și nu se conectează.';

  @override
  String get wallpaperPhotoLocalOnly =>
      'Imaginile de fundal cu foto sunt deocamdată doar locale';

  @override
  String get wallpaperSavedNoRoute =>
      'Salvat aici. Acum nu există rută către celălalt';

  @override
  String get wallpaperScopeTitle => 'Cine să vadă acest fundal?';

  @override
  String get wallpaperScopeChannel => 'Tot canalul';

  @override
  String get wallpaperScopeBoth => 'Eu și celălalt';

  @override
  String get wallpaperScopeLocal => 'Doar la mine';

  @override
  String get wallpaperScopeSharedHint =>
      'Se trimite ca pachet de control criptat';

  @override
  String get wallpaperScopePhotoHint =>
      'Deocamdată fotografiile rămân doar pe acest telefon';

  @override
  String get foldersCreate => 'Creează dosar';

  @override
  String get foldersYours => 'Dosarele tale';

  @override
  String get foldersSmartFilters => 'Filtre inteligente';

  @override
  String get foldersName => 'Numele dosarului';

  @override
  String get foldersSave => 'Salvează';

  @override
  String get foldersDeleteTitle => 'Ștergi dosarul?';

  @override
  String get foldersDelete => 'Șterge';

  @override
  String get foldersCreateAction => 'Creează';

  @override
  String get chatsArchiveHiddenToast =>
      'Arhivă ascunsă. O readuci din „Aspect”.';

  @override
  String get chatsBulkPin => 'Fixează';

  @override
  String get chatsBulkMute => 'Fără sunet';

  @override
  String get chatsUnarchive => 'Scoate din arhivă';

  @override
  String get chatsAddToFolder => 'Adaugă în dosar';

  @override
  String get chatsMarkUnread => 'Marchează ca necitit';

  @override
  String get chatsClearHistory => 'Golește istoricul';

  @override
  String get foldersNew => 'Dosar nou';

  @override
  String get foldersNameHint => 'Prieteni';

  @override
  String get chatsNoIncoming => 'Niciun mesaj primit';

  @override
  String get chatsMarkedUnread => 'Marcat ca necitit';

  @override
  String get chatsClearHistoryTitle => 'Golești istoricul chatului?';

  @override
  String get chatsClearHistoryBody =>
      'Mesajele vor fi șterse doar pe acest dispozitiv. Chatul, contactul și favoritele rămân.';

  @override
  String get chatsClearHistoryAction => 'Golește';

  @override
  String get chatsHistoryCleared => 'Istoric golit';

  @override
  String get savedTagMenuTag => 'Etichetă';

  @override
  String get savedTagRemove => 'Elimină eticheta';

  @override
  String get customizeArchiveRowTitle => 'Rândul arhivei';

  @override
  String get customizeArchiveRowHint =>
      'Afișează-l deasupra listei de chaturi. Chaturile arhivate primesc mesaje oricum.';

  @override
  String get mapLayerStandard => 'Standard';

  @override
  String get mapLayerStandardHint =>
      'Hartă stradală deschisă — varianta cea mai stabilă';

  @override
  String get backupAutoTitle => 'Backup automat';

  @override
  String get backupAutoHint =>
      'O dată pe zi, într-un singur fișier din dosarul ales; fiecare copie o înlocuiește pe cea dinainte.';

  @override
  String backupAutoFolder(String name) {
    return 'Dosar: $name';
  }

  @override
  String backupAutoLast(String time) {
    return 'Ultima copie: $time';
  }

  @override
  String get backupAutoNever => 'Încă nicio copie';

  @override
  String get backupAutoRunning => 'Se face copia…';

  @override
  String get backupAutoFolderLost => 'Dosarul nu e accesibil. Alege-l din nou.';

  @override
  String get backupAutoFailed =>
      'Ultima copie a eșuat. Se reîncearcă mai târziu.';

  @override
  String get backupAutoNow => 'Fă backup acum';

  @override
  String get backupAutoChangeFolder => 'Schimbă dosarul';

  @override
  String get callYourMicOff => 'Microfonul tău e oprit';

  @override
  String callTheirCameraOff(String name) {
    return 'Camera lui $name e oprită';
  }
}
