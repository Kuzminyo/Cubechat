// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get callVoice => 'Chiamata vocale';

  @override
  String get callVideo => 'Videochiamata';

  @override
  String get callIncomingVideo => 'Videochiamata in arrivo';

  @override
  String get callCamera => 'Fotocamera';

  @override
  String get callFlipCamera => 'Gira';

  @override
  String get contactProfileVideo => 'Video';

  @override
  String get callPreparing => 'Preparazione microfono…';

  @override
  String get callDialing => 'Chiamata…';

  @override
  String get callRinging => 'Squilla…';

  @override
  String get callConnecting => 'Connessione…';

  @override
  String get callMicrophoneRequired =>
      'Consenti l\'accesso al microfono nelle impostazioni di sistema per effettuare chiamate.';

  @override
  String get callMicrophoneWindows =>
      'Windows non ha dato il microfono a CubeChat. Attiva Impostazioni → Privacy e sicurezza → Microfono → \"Consenti alle app desktop di accedere al microfono\".';

  @override
  String get callElsewhere =>
      'È già in corso una chiamata su un altro dispositivo di questo account.';

  @override
  String get callRelayUnavailable =>
      'Server delle chiamate non disponibile. Riprova più tardi.';

  @override
  String get callBusy => 'Occupato';

  @override
  String get callNoAnswer => 'Nessuna risposta';

  @override
  String get callFailed => 'Impossibile collegare la chiamata';

  @override
  String get callDeclined => 'Chiamata rifiutata';

  @override
  String get callEnded => 'Chiamata terminata';

  @override
  String get callMicrophone => 'Microfono';

  @override
  String get callSpeaker => 'Altoparlante';

  @override
  String get callAnswer => 'Rispondi';

  @override
  String get callDecline => 'Rifiuta';

  @override
  String get callEnd => 'Termina';

  @override
  String get callClose => 'Chiudi';

  @override
  String get callMinimize => 'Riduci';

  @override
  String get callAudioOutput => 'Audio chiamata';

  @override
  String get callRoutePhone => 'Telefono';

  @override
  String get callRouteBluetooth => 'Bluetooth';

  @override
  String get callRouteHeadphones => 'Cuffie';

  @override
  String get callFullScreenTitle => 'Chiamate sulla schermata di blocco';

  @override
  String get callFullScreenBody =>
      'Consenti di mostrare una chiamata in arrivo sulla schermata bloccata, così puoi rispondere senza sbloccare.';

  @override
  String get callFullScreenXiaomi =>
      'Xiaomi, Redmi e Poco non permettono alle app di attivarlo da sole: attiva “Mostra sulla schermata di blocco” in Altre autorizzazioni.';

  @override
  String get circleMessage => 'Videomessaggio';

  @override
  String get appName => 'Cubechat';

  @override
  String get navChats => 'Chat';

  @override
  String get navPeers => 'Vicini';

  @override
  String get navProfile => 'Profilo';

  @override
  String get navContacts => 'Contatti';

  @override
  String get navMap => 'Mappa';

  @override
  String get mapTitle => 'Mappa';

  @override
  String get mapFriendsTitle => 'Persone sulla mappa';

  @override
  String get mapFriendsHint => 'Solo questi contatti ricevono la tua posizione';

  @override
  String mapClusterTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count persone qui',
      one: '$count persona qui',
    );
    return '$_temp0';
  }

  @override
  String get mapClusterHint =>
      'Tocca una persona per spostare la mappa su di lei';

  @override
  String get mapNorthUp => 'Nord in alto';

  @override
  String get mapLayerTitle => 'Stile mappa';

  @override
  String get mapLayerHint => 'Lo sfondo su cui sono disegnati i segnaposto';

  @override
  String get mapLayerDark => 'Scura';

  @override
  String get mapLayerDarkHint =>
      'Strade, senza etichette: lo sfondo più discreto sotto i segnaposto';

  @override
  String get mapLayerSatellite => 'Satellite';

  @override
  String get mapLayerSatelliteHint =>
      'Immagini aeree: quale edificio, quale cortile';

  @override
  String get mapLayerTerrain => 'Rilievo';

  @override
  String get mapLayerTerrainHint =>
      'Curve di livello e rilievo, per colline e sentieri';

  @override
  String get mapFriendsEmpty => 'Nessuno condivide ancora la mappa con te.';

  @override
  String get mapFriendsEmptyHint =>
      'Invita un contatto: apparirà qui quando accetta.';

  @override
  String get mapFriendsInvite => 'Invita';

  @override
  String get mapFriendsRemove => 'Rimuovi dalla mappa';

  @override
  String mapFriendsRemoved(String name) {
    return '$name non condivide più la mappa con te';
  }

  @override
  String get mapFriendsLive => 'Sulla mappa ora';

  @override
  String get mapFriendsIdle => 'Nessuna posizione al momento';

  @override
  String get mapInviteTitle => 'Invita sulla mappa';

  @override
  String get mapInviteHint => 'Scegli una o più chat';

  @override
  String get mapInviteEmpty => 'Non ci sono ancora chat da invitare.';

  @override
  String mapInviteAction(int count) {
    return 'Invia ($count)';
  }

  @override
  String get mapInviteMessage =>
      'Invito alla mappa di Cubechat. Condividi la tua posizione in questa chat per apparire sulla mappa.';

  @override
  String mapInviteSent(int count) {
    return 'Inviti inviati: $count';
  }

  @override
  String get mapInviteFailed => 'Impossibile inviare gli inviti';

  @override
  String mapPeopleVisible(int count) {
    return 'Posizioni condivise: $count';
  }

  @override
  String get mapCenterMe => 'Centra su di me';

  @override
  String get mapNoSharedLocations => 'Ancora nessuna posizione condivisa';

  @override
  String get mapNoSharedLocationsHint =>
      'Un contatto appare qui dopo aver inviato una posizione in chat.';

  @override
  String get mapWebHintTitle => 'Connessioni vicine';

  @override
  String get mapWebHint =>
      'Le linee mostrano la vicinanza, non il percorso dei messaggi.';

  @override
  String get mapOpenProfile => 'Profilo';

  @override
  String get mapLocationPrivacyOff => 'La posizione sulla mappa è nascosta';

  @override
  String get mapLocationPrivacyOffHint =>
      'Attiva «Mostrami sulla mappa» in Privacy per vedere il tuo segnaposto.';

  @override
  String get mapYouOnMap => 'La tua posizione è visibile su questo dispositivo';

  @override
  String get locationSharingDisabled =>
      'Prima attiva «Mostrami sulla mappa» in Privacy.';

  @override
  String get mapLocationDenied => 'L\'accesso alla posizione è disattivato';

  @override
  String get mapLocationServiceOff =>
      'Attiva i servizi di localizzazione per mostrarti';

  @override
  String get mapLocationUnavailable =>
      'Impossibile determinare la tua posizione';

  @override
  String get mapDistanceUnknown => 'Distanza non disponibile';

  @override
  String mapDistanceMetres(int metres) {
    return 'a $metres m';
  }

  @override
  String mapDistanceKilometres(String kilometres) {
    return 'a $kilometres km';
  }

  @override
  String get mapUpdatedNow => 'condivisa ora';

  @override
  String mapUpdatedMinutes(int minutes) {
    return 'condivisa $minutes min fa';
  }

  @override
  String mapUpdatedHours(int hours) {
    return 'condivisa $hours h fa';
  }

  @override
  String get contactsTitle => 'Contatti';

  @override
  String get contactsSubtitle => 'Tutti quelli a cui hai scritto';

  @override
  String get contactsSearchHint => 'Cerca contatti…';

  @override
  String get contactsEmptyTitle => 'Ancora nessun contatto';

  @override
  String get contactsEmptyHint =>
      'Inizia una conversazione e la persona apparirà qui.';

  @override
  String get contactsSearchEmpty => 'Nessun contatto trovato';

  @override
  String get contactsTabContacts => 'Contatti';

  @override
  String get contactsTabCalls => 'Chiamate';

  @override
  String get callsFilterAll => 'Tutte';

  @override
  String get callsFilterMissed => 'Perse';

  @override
  String get callsEmptyTitle => 'Ancora nessuna chiamata';

  @override
  String get callsEmptyHint =>
      'Qui appariranno le chiamate in arrivo, in uscita e perse.';

  @override
  String get callsMissedEmpty => 'Nessuna chiamata persa';

  @override
  String get callsCallBack => 'Chiama';

  @override
  String get contactProfileChat => 'Chat';

  @override
  String get contactProfileCall => 'Chiama';

  @override
  String get contactProfileRadio => 'Radio';

  @override
  String get contactProfileSecurity => 'Sicurezza';

  @override
  String get contactProfileActions => 'Azioni contatto';

  @override
  String get contactProfileVerify => 'Verifica';

  @override
  String get contactProfileCopyId => 'Copia ID contatto';

  @override
  String get contactProfileIdCopied => 'ID contatto copiato';

  @override
  String get contactProfileId => 'ID contatto';

  @override
  String get contactProfileVerifyHint =>
      'Confronta le impronte di crittografia per verificare questa persona.';

  @override
  String get chatsTitle => 'Chat';

  @override
  String get chatsSubtitle => 'Mesh · crittografia end-to-end';

  @override
  String get chatsEmptyTitle => 'Ancora nessuna conversazione';

  @override
  String get chatsEmptyHint =>
      'Apri un utente dalla scheda Vicini per iniziare a chattare.';

  @override
  String get chatsFilterAll => 'Tutte';

  @override
  String get chatsFilterUnread => 'Non lette';

  @override
  String get chatsFilterMesh => 'Mesh';

  @override
  String get chatsFilterFavorites => 'Preferite';

  @override
  String get chatsFolderDirect => 'Private';

  @override
  String get chatsFolderChannels => 'Canali';

  @override
  String get chatsFolderOnline => 'Raggiungibili';

  @override
  String get chatsFoldersTitle => 'Cartelle';

  @override
  String get chatsFoldersHint =>
      'Le cartelle sono viste di questo elenco, non posti in cui spostare le chat. Attiva quelle che vuoi sopra le chat.';

  @override
  String get chatsSearchHint => 'Cerca chat…';

  @override
  String get chatsStatusViaMesh => 'via mesh';

  @override
  String get chatsStatusOffline => 'offline';

  @override
  String get peerKeyRotated => 'chiave cambiata — verifica di nuovo';

  @override
  String get peersTitle => 'Vicini';

  @override
  String get peersSubtitle => 'Dispositivi nel raggio del Bluetooth';

  @override
  String get peersEmpty => 'Ricerca di utenti…';

  @override
  String peersHopsOne(int n) {
    return 'a $n salto';
  }

  @override
  String peersHopsOther(int n) {
    return 'a $n salti';
  }

  @override
  String get blePermissionTitle => 'Serve l\'autorizzazione Bluetooth';

  @override
  String get blePermissionHint =>
      'Cubechat usa il Bluetooth per trovare utenti e inviare messaggi — senza internet.';

  @override
  String get blePermissionGrant => 'Concedi autorizzazione';

  @override
  String get blePermissionOpenSettings => 'Apri impostazioni';

  @override
  String get blePermissionDeniedHint =>
      'Autorizzazione negata. Apri le impostazioni per consentire l\'accesso al Bluetooth.';

  @override
  String get bleAdapterOffTitle => 'Il Bluetooth è disattivato';

  @override
  String get bleAdapterOffHint =>
      'Attiva il Bluetooth per vedere gli utenti vicini.';

  @override
  String get bleUnsupportedTitle => 'Bluetooth LE non disponibile';

  @override
  String get bleUnsupportedHint =>
      'Questo dispositivo o piattaforma non supporta Bluetooth Low Energy. Prova su uno smartphone.';

  @override
  String get bleScanning => 'Ricerca…';

  @override
  String get bleRetry => 'Riprova';

  @override
  String get bleEnable => 'Attiva';

  @override
  String get bleConnectFailed =>
      'Impossibile connettersi. L\'utente potrebbe essere fuori portata o il suo indirizzo Bluetooth è cambiato.';

  @override
  String get bleSignal => 'Segnale';

  @override
  String get bleConnect => 'Connetti';

  @override
  String get bleConnected => 'Connesso';

  @override
  String get bleVerified => 'Verificato';

  @override
  String get editorAdjustBrightness => 'Luminosità';

  @override
  String get editorAdjustContrast => 'Contrasto';

  @override
  String get editorAdjustSaturation => 'Saturazione';

  @override
  String get editorToolCrop => 'Ritaglia';

  @override
  String get editorToolDraw => 'Disegna';

  @override
  String get editorToolAdjust => 'Regola';

  @override
  String get editorTabSticker => 'Sticker';

  @override
  String get editorTabText => 'Testo';

  @override
  String get editorPenPen => 'Penna';

  @override
  String get editorPenMarker => 'Evidenziatore';

  @override
  String get editorPenNeon => 'Neon';

  @override
  String get editorPenArrow => 'Freccia';

  @override
  String get editorPenBlur => 'Sfocatura';

  @override
  String get editorPenEraser => 'Gomma';

  @override
  String get editorLevel => 'Raddrizza';

  @override
  String get editorTextHint => 'Testo sulla foto';

  @override
  String get editorCropFree => 'Libero';

  @override
  String get editorRemove => 'Rimuovi';

  @override
  String get notificationUnknownSender => 'Nuovo messaggio';

  @override
  String get bleUnknownPeer => 'Dispositivo sconosciuto';

  @override
  String get bleBroadcasting => 'In trasmissione';

  @override
  String bleConnectedCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n centrali connessi',
      one: '1 centrale connesso',
      zero: 'Nessun centrale',
    );
    return '$_temp0';
  }

  @override
  String get verifyTitle => 'Verifica utente';

  @override
  String get verifyIntro =>
      'Confronta queste due impronte con l\'altra persona di persona o durante una chiamata vocale. Se coincidono da entrambe le parti, hai la conferma che l\'handshake Noise non è stato manomesso.';

  @override
  String get verifyMine => 'LA TUA IMPRONTA';

  @override
  String verifyTheirs(String name) {
    return 'IMPRONTA DI $name';
  }

  @override
  String get verifyMarkAsVerified => 'Segna come verificato';

  @override
  String get verifyAlreadyDone => 'Questo utente è verificato.';

  @override
  String get verifyRevoke => 'Revoca';

  @override
  String verifyDoneSnack(String name) {
    return '$name segnato come verificato';
  }

  @override
  String get chatInputHint => 'Messaggio';

  @override
  String get chatSend => 'Invia';

  @override
  String get chatToday => 'Oggi';

  @override
  String get chatYesterday => 'Ieri';

  @override
  String get chatDelivered => 'Consegnato';

  @override
  String get chatRead => 'Letto';

  @override
  String get chatSending => 'Invio in corso';

  @override
  String get chatWaitingForConnection => 'In attesa di connessione';

  @override
  String sendQueueCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count messaggi in attesa di connessione',
      one: '1 messaggio in attesa di connessione',
    );
    return '$_temp0';
  }

  @override
  String sendQueueSlowNetwork(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Rete lenta — invio di $count messaggi',
      one: 'Rete lenta — invio di 1 messaggio',
    );
    return '$_temp0';
  }

  @override
  String get sendQueueTitle => 'In attesa di invio';

  @override
  String get sendQueueHint =>
      'Partiranno da soli appena c\'è una strada — Bluetooth vicino o internet. Non serve premere nulla.';

  @override
  String get sendQueueRetry => 'Prova ora';

  @override
  String get sendQueueCancel => 'Annulla invio';

  @override
  String get sendQueueCancelled => 'Non inviato — ritirato';

  @override
  String get sendQueueTooLate => 'Troppo tardi per ritirarlo: è già partito';

  @override
  String get chatEncryptedNotice =>
      'I messaggi sono crittografati end-to-end con il Noise Protocol.';

  @override
  String get chatSessionHandshaking => 'Creazione del canale sicuro…';

  @override
  String get chatSessionEstablished => 'Protetto · Noise XX';

  @override
  String get chatSessionFailed => 'Connessione non riuscita';

  @override
  String get presenceOnline => 'online';

  @override
  String get presenceOffline => 'offline';

  @override
  String get chatSessionFingerprintPending =>
      'L\'impronta apparirà al termine dell\'handshake.';

  @override
  String get chatEmptyEstablished =>
      'Il canale sicuro è attivo. Invia un messaggio per iniziare la conversazione.';

  @override
  String get chatEmptyHandshaking =>
      'In attesa che l\'altra parte completi l\'handshake…';

  @override
  String get chatEmptyTitle => 'Ancora nessun messaggio';

  @override
  String get chatEmptyGreetHint =>
      'Scrivi un messaggio o tocca Kubi per salutare.';

  @override
  String get profileTitle => 'Profilo';

  @override
  String get profileNickname => 'Nickname';

  @override
  String get profileNicknameEditTitle => 'Imposta il tuo nickname';

  @override
  String get profileNicknameHint => 'Come ti vedono gli altri nella mesh';

  @override
  String get profileNicknameSave => 'Salva';

  @override
  String get profileFingerprint => 'Impronta della chiave pubblica';

  @override
  String get profileLanguage => 'Lingua';

  @override
  String get profileLanguageEn => 'Inglese';

  @override
  String get profileLanguageUk => 'Ucraino';

  @override
  String get profileTransport => 'Trasporto';

  @override
  String get profileTransportMesh => 'Bluetooth mesh';

  @override
  String get profileBackground => 'Raggiungibile in background';

  @override
  String get profileBackgroundSubtitle =>
      'Continua a ricevere messaggi quando l\'app è chiusa';

  @override
  String get profileBatteryExempt => 'Disattiva ottimizzazione batteria';

  @override
  String get profileAbout => 'Info';

  @override
  String profileVersion(String v) {
    return 'Versione $v';
  }

  @override
  String get rotateKeysTitle => 'Cambia chiavi dell\'account';

  @override
  String get rotateKeysHint =>
      'Se un dispositivo con il tuo account è stato perso o rubato';

  @override
  String get rotateKeysConfirmTitle => 'Cambiare le chiavi dell\'account?';

  @override
  String get rotateKeysConfirmBody =>
      'I tuoi contatti ricevono le nuove chiavi e mantengono le chat, ma a ciascuno verrà chiesto di verificare di nuovo le tue chiavi. Tutti gli altri dispositivi del tuo account verranno disconnessi; collega di nuovo da questo telefono quelli che vuoi tenere. I contatti con una versione vecchia di CubeChat non potranno raggiungerti finché non aggiornano. I canali mantengono le loro chiavi.';

  @override
  String get rotateKeysConfirmAction => 'Cambia chiavi';

  @override
  String get rotateKeysWorking => 'Cambio chiavi…';

  @override
  String rotateKeysDone(int sent, int total) {
    return 'Nuove chiavi. Avvisati $sent contatti su $total';
  }

  @override
  String get rotateKeysSlow =>
      'Nuove chiavi. Non tutti i contatti hanno confermato in tempo; i relay le conservano per loro';

  @override
  String get profileEmergencyWipe => 'Cancellazione d\'emergenza';

  @override
  String get profileEmergencyWipeConfirm => 'Cancellare tutto?';

  @override
  String get profileEmergencyWipeConfirmHint =>
      'Verranno rimossi la tua identità, l\'elenco dei contatti e la cronologia delle conversazioni. L\'operazione è irreversibile.';

  @override
  String get profileEmergencyWipeAction => 'Cancella';

  @override
  String get cancel => 'Annulla';

  @override
  String get copy => 'Copia';

  @override
  String get copied => 'Copiato';

  @override
  String get channelsNewTitle => 'Nuovo canale';

  @override
  String get channelsNewTooltip => 'Nuovo canale';

  @override
  String get channelNameLabel => 'Nome del canale';

  @override
  String get channelPasswordLabel => 'Password (facoltativa)';

  @override
  String get channelJoinAction => 'Entra';

  @override
  String get channelNameHint =>
      'Chi inserisce lo stesso nome e la stessa password finisce nella stessa stanza. Nessun server ne tiene un elenco.';

  @override
  String get channelPasswordHint =>
      'La password è la chiave. Senza, la stanza è aperta a chiunque nelle vicinanze ne conosca il nome.';

  @override
  String get channelSubtitle => 'Canale di gruppo · chiave condivisa';

  @override
  String get channelMute => 'Silenzia';

  @override
  String get channelUnmute => 'Riattiva audio';

  @override
  String channelMutedUntil(String time) {
    return 'Silenziato fino alle $time';
  }

  @override
  String get channelMuteFor => 'Silenzia per…';

  @override
  String channelMuteMinutes(int minutes) {
    return '$minutes minuti';
  }

  @override
  String channelMuteHours(int hours) {
    return '$hours ore';
  }

  @override
  String channelMuteDays(int days) {
    return '$days giorni';
  }

  @override
  String get channelMuteForever => 'Finché non lo riattivo';

  @override
  String get channelCommunity => 'Commenti';

  @override
  String get channelCommunityOpen => 'Apri la discussione';

  @override
  String channelCommunitySubtitle(String channel) {
    return 'Discussione di $channel';
  }

  @override
  String get channelBackToChannel => 'Torna al canale';

  @override
  String get channelMemberActions => 'Membro';

  @override
  String get channelRemoveMember => 'Rimuovi dal canale';

  @override
  String get channelRemoveMemberHint =>
      'I suoi post non vengono più accettati qui. Nulla gli impedisce di rientrare tramite il nome: la chiave condivisa è l\'unica forma di appartenenza.';

  @override
  String get channelMuteMember => 'Silenzia per…';

  @override
  String get channelUnmuteMember => 'Consenti di nuovo di scrivere';

  @override
  String channelMemberRemoved(String name) {
    return '$name è stato rimosso';
  }

  @override
  String channelMemberMuted(String name) {
    return '$name è stato silenziato';
  }

  @override
  String channelMemberCleared(String name) {
    return '$name può scrivere di nuovo';
  }

  @override
  String get channelMemberMutedNote => 'Silenziato';

  @override
  String get channelShareHistory => 'Condividi la cronologia';

  @override
  String get channelShareHistoryHint =>
      'Rimette in onda gli ultimi post di questa stanza, così chi è entrato dopo può vederli. Chi era già qui non riceve nulla di nuovo.';

  @override
  String channelHistoryShared(int count) {
    return 'Post offerti: $count';
  }

  @override
  String get channelHistoryNothing => 'Ancora niente da condividere';

  @override
  String get channelHistoryAuto => 'Dai la cronologia ai nuovi membri';

  @override
  String get channelHistoryAutoHint =>
      'Quando nella stanza arriva qualcuno di nuovo, i post recenti gli vengono inviati da soli. Per ora solo testo: le foto viaggiano in flussi a blocchi e non si possono reinviare senza duplicarle per tutti.';

  @override
  String get channelPostComments => 'Commenti';

  @override
  String get channelNoComments => 'Nessuno ha ancora commentato';

  @override
  String get channelCommentHint => 'Commento';

  @override
  String get channelMuteCustom => 'Per quanto tempo?';

  @override
  String get channelMuteCustomHint => 'Ore';

  @override
  String get chatPinnedManage => 'Fissati';

  @override
  String get chatPeekOpen => 'Apri chat';

  @override
  String get chatPeekPin => 'Fissa';

  @override
  String get chatPeekUnpin => 'Sblocca';

  @override
  String get chatPeekUnmute => 'Riattiva audio';

  @override
  String get chatPeekMarkRead => 'Segna come letta';

  @override
  String get chatDeleteForMeHint =>
      'Rimossa da questo telefono e tolta dai fissati. L\'altra parte conserva la sua copia.';

  @override
  String get pushWakeTitle => 'Risveglia questo telefono';

  @override
  String get pushWakeHint =>
      'Un piccolo server controlla i relay per il tuo indirizzo e dà un colpetto a questo telefono quando arriva qualcosa, così anche l\'app chiusa ti avvisa. Non vede mai un messaggio né una chiave: solo che il tuo indirizzo ha ricevuto qualcosa, e quando. Il relay lo sa già; questo è un secondo posto che lo sa.';

  @override
  String get pushWakeDeniedTitle => 'Le notifiche sono disattivate';

  @override
  String get pushWakeDeniedHint =>
      'Al sistema è stato detto di no una volta e non lo chiederà più, quindi puoi riattivarle solo in Impostazioni — cubechat, poi Notifiche. Poi torna qui.';

  @override
  String get pushWakeRefused => 'Notifiche non consentite';

  @override
  String get privacyForwardLinkTitle => 'Link al profilo negli inoltri';

  @override
  String get privacyForwardLinkHint =>
      'Quando qualcuno inoltra un tuo messaggio, la riga sopra può aprire il tuo profilo. Se disattivato, vedono il tuo nome e niente da toccare. È una richiesta alla loro app, non qualcosa che questa può imporre.';

  @override
  String get privacyShareSheetTitle => 'Chat nel menu Condividi';

  @override
  String get privacyShareSheetOnHint =>
      'I nomi delle tue quattro chat più recenti vengono passati ad Android, così puoi inviare a loro da qualsiasi app. Il blocco dell\'app non li nasconde.';

  @override
  String get privacyShareSheetOffHint =>
      'Ad Android non viene passato nulla. Condividendo in CubeChat scegli tu la chat.';

  @override
  String get privacyCallsTitle => 'Accetta chiamate';

  @override
  String get privacyCallsOnHint =>
      'I tuoi contatti possono chiamarti. Per rifiutare una persona, apri il suo profilo.';

  @override
  String get privacyCallsOffHint =>
      'Nessuno può chiamarti, tranne chi autorizzi nel suo profilo. Una chiamata rifiutata gli risulta come occupato.';

  @override
  String get chatsStatusChannel => 'canale';

  @override
  String get channelInviteTitle => 'Aggiungi persone';

  @override
  String get channelInviteAction => 'Invita';

  @override
  String get channelInviteEmpty =>
      'Ancora nessun utente conosciuto. Prima incontra qualcuno nella scheda Vicini.';

  @override
  String get channelInviteSent => 'Inviti inviati';

  @override
  String get channelInviteNoneSent =>
      'Al momento non è stato possibile raggiungere nessuno';

  @override
  String get channelNameTooLong => 'Il nome del canale è troppo lungo';

  @override
  String get chatsActionFavorite => 'Aggiungi ai preferiti';

  @override
  String get chatsActionUnfavorite => 'Rimuovi dai preferiti';

  @override
  String get chatsActionDelete => 'Elimina chat';

  @override
  String get chatsDeleteTitle => 'Eliminare questa chat?';

  @override
  String chatsDeleteManyHint(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Cancella $count conversazioni. I contatti restano, quindi puoi scrivergli di nuovo senza scambiare codici.',
      one:
          'Cancella $count conversazione. Il contatto resta, quindi puoi scrivergli di nuovo senza scambiare codici.',
    );
    return '$_temp0';
  }

  @override
  String get chatsDeletedToast => 'Chat eliminata.';

  @override
  String chatsDeletedManyToast(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count chat eliminate.',
      one: '$count chat eliminata.',
    );
    return '$_temp0';
  }

  @override
  String get undo => 'Annulla';

  @override
  String get chatsDeletePeerHint =>
      'Cancella la conversazione. Il contatto resta, quindi puoi scrivergli di nuovo senza scambiare codici.';

  @override
  String get chatsDeleteChannelHint =>
      'Esci dal canale e ne rimuovi la cronologia. Per rientrare ti servirà di nuovo la chiave.';

  @override
  String get chatsDeleteForThemToo => 'Elimina anche per l\'altra persona';

  @override
  String get chatsDeleteForThemHint =>
      'Chiede alla sua app di cancellare anche tutta la conversazione, compreso ciò che ha scritto. In un canale vengono ritirati solo i tuoi messaggi.';

  @override
  String get chatEditAction => 'Modifica';

  @override
  String get chatEditTitle => 'Modifica messaggio';

  @override
  String get chatEditSave => 'Salva';

  @override
  String get chatEdited => 'modificato';

  @override
  String get chatDeleteAction => 'Elimina';

  @override
  String get chatDeleteTitle => 'Eliminare il messaggio?';

  @override
  String get chatDeleteForMe => 'Elimina per me';

  @override
  String get chatDeleteForEveryone => 'Elimina per tutti';

  @override
  String get chatPinTitle => 'Fissare il messaggio?';

  @override
  String get chatPinForBoth => 'Fissa per entrambi';

  @override
  String get chatPinForMe => 'Fissa solo per me';

  @override
  String get chatReplyAction => 'Rispondi';

  @override
  String chatReplyingTo(String name) {
    return 'In risposta a $name';
  }

  @override
  String get chatReplyYou => 'te stesso';

  @override
  String get chatCopyAction => 'Copia';

  @override
  String get chatCopied => 'Copiato';

  @override
  String get chatForwardAction => 'Inoltra';

  @override
  String get chatForwardTitle => 'Inoltra a';

  @override
  String get shareIntoTitle => 'Invia a';

  @override
  String get shareNearbyAirDrop => 'Vicino tramite AirDrop';

  @override
  String get shareNearbyAirDropHint => 'Senza internet — a chi ti sta accanto';

  @override
  String get shareSent => 'Inviato';

  @override
  String get shareFailed => 'Non è stato possibile inviare tutto';

  @override
  String get chatForwardEmpty => 'Ancora nessun\'altra chat';

  @override
  String chatForwardSendCount(int count) {
    return 'Invia ($count)';
  }

  @override
  String chatForwardSentCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Inoltrato a $count chat',
      one: 'Inoltrato a una chat',
    );
    return '$_temp0';
  }

  @override
  String chatForwardSent(String name) {
    return 'Inoltrato a $name';
  }

  @override
  String chatSentAt(String time) {
    return 'Inviato $time';
  }

  @override
  String chatReadAt(String time) {
    return 'Letto $time';
  }

  @override
  String get chatPinAction => 'Fissa';

  @override
  String get chatUnpinAction => 'Sblocca';

  @override
  String chatPinnedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count messaggi fissati',
      one: '1 messaggio fissato',
      zero: 'Nessun messaggio fissato',
    );
    return '$_temp0';
  }

  @override
  String get chatNoPins => 'Nessun messaggio fissato qui';

  @override
  String get chatUnpinAll => 'Sblocca tutti i messaggi';

  @override
  String get chatShowAllPins => 'Tutti i messaggi fissati';

  @override
  String get chatUnpinConfirm => 'Sbloccare questo messaggio?';

  @override
  String get chatUnpinConfirmHint =>
      'Non sarà più fissato per nessuno in questa chat.';

  @override
  String get chatPinnedTitle => 'Messaggio fissato';

  @override
  String get chatPinnedGone => 'Quel messaggio non è più in questa chat';

  @override
  String get peerBlock => 'Blocca';

  @override
  String get peerUnblock => 'Sblocca';

  @override
  String get peerMute => 'Silenzia';

  @override
  String get peerUnmute => 'Riattiva audio';

  @override
  String get peerBlockedNote => 'Bloccato — i suoi messaggi vengono scartati.';

  @override
  String get relaysTitle => 'Riserva via internet';

  @override
  String get relaysCardTitle => 'Raggiungi utenti via internet';

  @override
  String get relaysCardSubtitle =>
      'Quando il Bluetooth non riesce a consegnare, invia tramite relay Nostr';

  @override
  String get relaysExplainer =>
      'I messaggi restano crittografati end-to-end: un relay trasporta solo lo stesso pacchetto sigillato che trasporterebbe il Bluetooth. Però sa quali due chiavi stanno comunicando, e quando. Disattivato per impostazione predefinita.';

  @override
  String get relaysMyAddress => 'Il tuo indirizzo relay';

  @override
  String get relaysCopied => 'Copiato';

  @override
  String get circleLensTitle => 'Fotocamera frontale per videomessaggi';

  @override
  String get circleLensFrontHint =>
      'I videomessaggi rotondi vengono registrati con la fotocamera rivolta verso di te.';

  @override
  String get circleLensBackHint =>
      'I videomessaggi rotondi vengono registrati con la fotocamera posteriore, per mostrare ciò che stai guardando.';

  @override
  String get channelCloseTitle => 'Chiudi questa stanza per tutti';

  @override
  String get channelCloseSubtitle =>
      'La rimuove dal telefono di ogni membro. Solo tu puoi farlo.';

  @override
  String get channelCloseConfirm =>
      'La stanza, i suoi messaggi e i suoi membri spariscono da ogni telefono che la ha. Nessuno viene escluso: la chiave deriva dal nome, quindi chiunque lo ricordi può riaprire una stanza vuota.';

  @override
  String get channelCloseAction => 'Chiudi la stanza';

  @override
  String get circleHint =>
      'Rilascia per inviare · scorri a sinistra per annullare';

  @override
  String get circleHintLocked => 'Tocca invia quando hai finito';

  @override
  String get circleNeedsCamera =>
      'I videomessaggi richiedono fotocamera e microfono';

  @override
  String get circleFailed => 'Impossibile registrare il videomessaggio';

  @override
  String get relaysListLabel => 'Relay';

  @override
  String get relaysLaneMedia => 'Relay per i media';

  @override
  String get relaysLaneMediaNote =>
      'Foto, file e video passano da questi, così un trasferimento non rallenta la conversazione.';

  @override
  String get relaysLaneLocation => 'Relay per la posizione';

  @override
  String get relaysLaneLocationNote =>
      'I segnali della mappa passano da questi, separati da tutto il resto.';

  @override
  String get relaysAdd => 'Aggiungi relay';

  @override
  String get relaysAddHint => 'wss://relay.example.com';

  @override
  String get relaysInvalidUrl => 'Inserisci un indirizzo wss:// o ws://';

  @override
  String get relaysRemove => 'Rimuovi';

  @override
  String get relaysStateConnected => 'Connesso';

  @override
  String get relaysStateConnecting => 'Connessione…';

  @override
  String get relaysStateFailed => 'Irraggiungibile';

  @override
  String get relaysStateIdle => 'Spento';

  @override
  String get relaysEmpty =>
      'Nessun relay configurato — la riserva resta disattivata.';

  @override
  String get contactTitle => 'Scheda contatto';

  @override
  String get contactMineLabel => 'La tua scheda';

  @override
  String get contactMineExplainer =>
      'Inviala a chi è fuori dalla portata del Bluetooth. Contiene le tue chiavi e il tuo indirizzo relay: basta per iniziare con te una chat crittografata via internet.';

  @override
  String get contactCopy => 'Copia';

  @override
  String get contactShare => 'Condividi';

  @override
  String get contactCopied => 'Scheda copiata';

  @override
  String get contactShareSubject => 'La mia scheda contatto cubechat';

  @override
  String get contactAddLabel => 'Aggiungi qualcuno';

  @override
  String get contactAddHint => 'Incolla una scheda contatto';

  @override
  String get contactAddAction => 'Aggiungi';

  @override
  String get contactPaste => 'Incolla';

  @override
  String contactAdded(String name) {
    return '$name aggiunto';
  }

  @override
  String get contactInvalid => 'Non è una scheda contatto valida';

  @override
  String get contactOwnCard => 'È la tua scheda';

  @override
  String get contactUnverified =>
      'Un contatto aggiunto così parte come non verificato. Chiunque può creare una scheda e scriverci qualsiasi nome, quindi confronta le impronte di persona o in chiamata prima di fidarti dell\'identità.';

  @override
  String get contactRelayOff =>
      'La riserva via internet è disattivata, quindi per ora una scheda non può raggiungere nessuno.';

  @override
  String get contactRelayEnable => 'Attiva';

  @override
  String get profileContactCard => 'Scheda contatto';

  @override
  String get chatsAddContactTooltip => 'Aggiungi un contatto da scheda';

  @override
  String get chatsMenuTooltip => 'Altro';

  @override
  String get chatsMenuAddContact => 'Aggiungi contatto';

  @override
  String get chatsMenuNewChannel => 'Nuovo canale';

  @override
  String get profileDiscoverable => 'Visibile nelle vicinanze';

  @override
  String get profileDiscoverableOnHint => 'Chiunque nel raggio può trovarti';

  @override
  String get profileDiscoverableOffHint =>
      'Solo i tuoi contatti possono raggiungerti';

  @override
  String get profileDiscoverableExplainer =>
      'Se attivo, il tuo annuncio viene trasmesso in chiaro, così uno sconosciuto può conoscerti semplicemente avvicinandosi — e chiunque ascolti registra la tua chiave e il tuo nome. Se disattivo, lo stesso pacchetto va solo ai contatti che hai già, sigillato, e i tuoi ID di instradamento restano non collegabili. Le persone nuove avranno allora bisogno di una scheda contatto.';

  @override
  String get voiceHoldHint =>
      'Tieni premuto per registrare un messaggio vocale';

  @override
  String get voiceTrimPlay => 'Riproduci';

  @override
  String get voiceTrimPause => 'Pausa';

  @override
  String get voiceTrimDiscard => 'Scarta registrazione';

  @override
  String voiceTrimSelection(String duration) {
    return 'Invio di $duration';
  }

  @override
  String get profileLastSeen => 'Condividi ultimo accesso';

  @override
  String get profileLastSeenOnHint => 'I contatti vedono quando sei nell\'app';

  @override
  String get profileLastSeenOffHint =>
      'Nessuno vede il tuo orario e tu non vedi quello degli altri: solo chi è online';

  @override
  String get profileMapLocation => 'Mostrami sulla mappa';

  @override
  String get profileMapLocationOnHint =>
      'La posizione è disponibile per la condivisione manuale e il tuo segnaposto è visibile sulla mappa';

  @override
  String get profileMapLocationOffHint =>
      'L\'app non richiede la posizione e il tuo segnaposto resta nascosto';

  @override
  String get desktopAutostartTitle => 'Avvia con Windows';

  @override
  String get desktopAutostartHint =>
      'CubeChat resta nell\'area di notifica, così chiamate e messaggi raggiungono questo computer anche a finestra chiusa';

  @override
  String get trayOpen => 'Apri CubeChat';

  @override
  String get trayQuit => 'Esci';

  @override
  String get callDirectTitle => 'Chiamate dirette';

  @override
  String get callDirectOnHint =>
      'Più veloci, ma la persona che chiami vede il tuo indirizzo IP';

  @override
  String get callDirectOffHint =>
      'Le chiamate passano dal nostro relay: la persona che chiami non vede mai il tuo IP e il relay non può ascoltare la chiamata';

  @override
  String get profileReadReceipts => 'Conferme di lettura';

  @override
  String get profileReadReceiptsOnHint => 'Chi scrive vede quando hai letto';

  @override
  String get profileReadReceiptsOffHint =>
      'Non invii più l\'orario di lettura, ma vedi ancora quello degli altri';

  @override
  String get profilePrivacyExplainer =>
      'L\'ultimo accesso vale in entrambe le direzioni: se nascondi il tuo stato, smetti di vedere quello degli altri. Le conferme di lettura controllano solo ciò che invii tu. La consegna dei messaggi non cambia.';

  @override
  String get chatTimerAction => 'Timer';

  @override
  String get chatTimerRemove => 'Rimuovi timer';

  @override
  String get chatTimerTitle => 'Elimina questo messaggio dopo';

  @override
  String chatTimerSet(String time) {
    return 'Questo messaggio sparisce tra $time';
  }

  @override
  String get chatTimerLocalHint =>
      'Solo su questo dispositivo — la loro copia resta loro';

  @override
  String get contactTagAction => 'Etichetta';

  @override
  String get contactTagRemove => 'Rimuovi etichetta';

  @override
  String get contactTagTitle => 'Scegli un\'etichetta';

  @override
  String get contactTagAll => 'Tutti';

  @override
  String get quietHoursTitle => 'Ore silenziose';

  @override
  String get quietHoursHint =>
      'I messaggi arrivano comunque; il telefono resta in silenzio';

  @override
  String get quietHoursFrom => 'Da';

  @override
  String get quietHoursTo => 'A';

  @override
  String get notifPreviewTitle => 'Mostra nelle notifiche';

  @override
  String get notifPreviewFull => 'Nome e testo';

  @override
  String get notifPreviewNameOnly => 'Solo nome';

  @override
  String get notifPreviewHidden => 'Niente';

  @override
  String get notifPreviewHint =>
      'Le notifiche sono visibili sulla schermata di blocco e alle app con accesso alle notifiche, anche con il blocco app attivo';

  @override
  String get notifPreviewNewMessage => 'Nuovo messaggio';

  @override
  String get appLockTitle => 'Blocco app';

  @override
  String get appLockHint => 'Chiedi un codice all\'apertura dell\'app';

  @override
  String get appLockPrompt => 'Inserisci il codice';

  @override
  String get appLockUnlock => 'Sblocca';

  @override
  String get appLockWrong => 'Codice errato';

  @override
  String get appLockSetTitle => 'Imposta un codice';

  @override
  String get appLockSetHint =>
      'Quattro cifre o più. Non c\'è modo di recuperarlo.';

  @override
  String get appLockOffTitle => 'Disattiva il blocco';

  @override
  String get appLockOffHint => 'Inserisci il codice attuale';

  @override
  String get appLockOn => 'Blocco app attivo';

  @override
  String get appLockOff => 'Blocco app disattivato';

  @override
  String get avatarSet => 'Scegli una foto';

  @override
  String get avatarChange => 'Cambia foto';

  @override
  String get avatarView => 'Vedi foto';

  @override
  String get profileCoverPhoto =>
      'Foto profilo, tocca due volte per ingrandire';

  @override
  String get profileCoverMenu => 'Opzioni foto';

  @override
  String get avatarSaved => 'Salvata in galleria';

  @override
  String get avatarRemove => 'Rimuovi foto';

  @override
  String get avatarRemoveConfirm =>
      'L\'avatar verrà eliminato da questo dispositivo. Al suo posto tornerà il gradiente generato.';

  @override
  String get avatarFailed => 'Impossibile leggere l\'immagine';

  @override
  String get fileOpenHint => 'Tocca per aprire';

  @override
  String get fileMissing => 'Il file non è più disponibile';

  @override
  String get fileNoHandlerTitle => 'Nessuna app può aprirlo';

  @override
  String get fileNoHandlerHint =>
      'Nessuna app installata gestisce questo tipo di file. Puoi invece inviarlo a un\'altra app.';

  @override
  String get fileRequestedAgain => 'Chiesto di nuovo al mittente';

  @override
  String get fileOpenFailed => 'Impossibile aprire il file';

  @override
  String get fileShareAction => 'Invia a un\'app';

  @override
  String fileTooLargeMesh(int limit) {
    return 'File troppo grande — il limite tramite mesh è $limit MB';
  }

  @override
  String fileTooLargeRelay(int limit) {
    return 'Via internet il limite è $limit MB. Avvicinati al destinatario per inviare un file più grande.';
  }

  @override
  String get mediaSendOriginal => 'Originale';

  @override
  String get attachFile => 'File';

  @override
  String get attachGallery => 'Galleria';

  @override
  String get attachCamera => 'Fotocamera';

  @override
  String get cameraUnavailable => 'Fotocamera non disponibile';

  @override
  String get profileEditName => 'Nome';

  @override
  String get profileMyCard => 'Scheda';

  @override
  String get mediaCaptionHint => 'Aggiungi una didascalia…';

  @override
  String get mediaDiscardTitle => 'Scartare la selezione?';

  @override
  String get mediaDiscardMessage =>
      'Chiudere la galleria e scartare le foto selezionate?';

  @override
  String get mediaDiscardConfirm => 'Scarta';

  @override
  String get mediaPhotosAccessOff => 'L\'accesso alle foto è disattivato';

  @override
  String get mediaPhotosAccessOffHint =>
      'Al momento CubeChat vede solo i video. Consenti l\'accesso alle foto nelle impostazioni di sistema per mostrare le tue immagini.';

  @override
  String get mediaVideosOnly =>
      'Sono visibili solo i video — consenti l\'accesso alle foto';

  @override
  String get mediaOpenSettings => 'Apri impostazioni';

  @override
  String get mediaTakePhoto => 'Scatta una foto';

  @override
  String get contactProfileAutoDelete => 'Eliminazione automatica';

  @override
  String get contactProfileAutoDeleteTitle =>
      'Elimina messaggi automaticamente';

  @override
  String get contactProfileAutoDeleteOff => 'Disattivata';

  @override
  String get contactProfileAutoDeleteOneDay => 'Dopo 1 giorno';

  @override
  String get contactProfileAutoDeleteSevenDays => 'Dopo 7 giorni';

  @override
  String get contactProfileAutoDeleteThirtyDays => 'Dopo 30 giorni';

  @override
  String contactProfileAutoDeleteUpdated(String period) {
    return 'Eliminazione automatica: $period';
  }

  @override
  String get contactProfileShare => 'Condividi contatto';

  @override
  String get contactProfileShareTitle => 'Invia contatto a';

  @override
  String get contactProfileShareEmpty => 'Ancora nessun\'altra chat';

  @override
  String contactProfileShareSent(String name) {
    return 'Inviato a $name';
  }

  @override
  String get contactProfileRestrictCopying => 'Disattiva copia';

  @override
  String get contactProfileAllowCopying => 'Consenti copia';

  @override
  String get contactHideAvatar => 'Nascondi la mia foto';

  @override
  String get contactShowAvatar => 'Mostra la mia foto';

  @override
  String get contactHideLastSeen => 'Nascondi il mio ultimo accesso';

  @override
  String get contactShowLastSeen => 'Mostra il mio ultimo accesso';

  @override
  String get contactHideReadReceipts => 'Nascondi le mie conferme di lettura';

  @override
  String get contactShowReadReceipts => 'Mostra le mie conferme di lettura';

  @override
  String get contactHiddenFromThem => 'Nascosto a questo contatto';

  @override
  String get contactRefuseCalls => 'Non accettare le sue chiamate';

  @override
  String get contactAllowCalls => 'Accetta le sue chiamate';

  @override
  String get contactCallsException =>
      'Un\'eccezione alla tua impostazione chiamate';

  @override
  String get contactProfileCopyingRestricted =>
      'Copia e inoltro sono disattivati';

  @override
  String get contactProfileCopyingRestrictedByPeer =>
      'Disattivato dall\'altra parte';

  @override
  String get contactProfileCopyingAllowed => 'Copia e inoltro sono consentiti';

  @override
  String get contactProfileDelete => 'Elimina dai contatti';

  @override
  String get contactProfileRestore => 'Aggiungi di nuovo ai contatti';

  @override
  String get contactProfileRestoreDone => 'Di nuovo nei tuoi contatti';

  @override
  String get contactProfileDeleteTitle => 'Rimuovere il contatto?';

  @override
  String contactProfileDeleteMessage(String name) {
    return '$name sparirà dai Contatti. La cronologia della chat resta su questo dispositivo.';
  }

  @override
  String get contactProfileMedia => 'Media';

  @override
  String get contactProfileVoiceMessages => 'Messaggi vocali';

  @override
  String get contactProfileStickers => 'Sticker';

  @override
  String get contactProfileNoStickers => 'Ancora nessuno sticker';

  @override
  String get contactProfileNoMedia => 'Ancora nessun media';

  @override
  String get contactProfileNoVoiceMessages => 'Ancora nessun messaggio vocale';

  @override
  String get contactProfileOpen => 'Apri profilo';

  @override
  String autoDeleteDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count giorni',
      one: '$count giorno',
    );
    return '$_temp0';
  }

  @override
  String autoDeleteHours(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ore',
      one: '$count ora',
    );
    return '$_temp0';
  }

  @override
  String autoDeleteMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count minuti',
      one: '$count minuto',
    );
    return '$_temp0';
  }

  @override
  String autoDeleteSeconds(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count secondi',
      one: '$count secondo',
    );
    return '$_temp0';
  }

  @override
  String get autoDeleteCustom => 'Personalizzato…';

  @override
  String get autoDeleteCustomHint => 'Quantità';

  @override
  String get autoDeleteUnitMinutes => 'min';

  @override
  String get autoDeleteUnitHours => 'ore';

  @override
  String get autoDeleteUnitDays => 'giorni';

  @override
  String get contactProfileAutoDeleteSet => 'Imposta';

  @override
  String get contactProfileFiles => 'File';

  @override
  String get contactProfileNoFiles => 'Ancora nessun file';

  @override
  String get contactProfileLinks => 'Link';

  @override
  String get contactProfileNoLinks => 'Ancora nessun link';

  @override
  String get contactProfilePolls => 'Sondaggi';

  @override
  String get contactProfileNoPolls => 'Ancora nessun sondaggio';

  @override
  String get presenceRecently => 'ultimo accesso di recente';

  @override
  String get presenceJustNow => 'proprio ora';

  @override
  String presenceHoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ore fa',
      one: '$count ora fa',
    );
    return '$_temp0';
  }

  @override
  String presenceYesterdayAt(String time) {
    return 'ieri alle $time';
  }

  @override
  String presenceOnWeekday(String day) {
    String _temp0 = intl.Intl.selectLogic(
      day,
      {
        '1': 'lunedì scorso',
        '2': 'martedì scorso',
        '3': 'mercoledì scorso',
        '4': 'giovedì scorso',
        '5': 'venerdì scorso',
        '6': 'sabato scorso',
        '7': 'domenica scorsa',
        'other': 'questa settimana',
      },
    );
    return '$_temp0';
  }

  @override
  String presenceWeeksAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count settimane fa',
      one: 'una settimana fa',
    );
    return '$_temp0';
  }

  @override
  String presenceMonthsAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count mesi fa',
      one: 'un mese fa',
    );
    return '$_temp0';
  }

  @override
  String get presenceLongAgo => 'molto tempo fa';

  @override
  String presenceMinutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count minuti fa',
      one: '$count minuto fa',
    );
    return '$_temp0';
  }

  @override
  String chatReadByCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Letto da $count',
      one: 'Letto da $count',
    );
    return '$_temp0';
  }

  @override
  String get chatsSearchFrequent => 'Persone con cui parli';

  @override
  String get chatsSearchRecent => 'Recenti';

  @override
  String get chatsSearchClear => 'Cancella';

  @override
  String get chatsSearchStartHint =>
      'Cerca le chat per nome o qualsiasi messaggio per parole.';

  @override
  String get chatsSearchEmpty => 'Nessun risultato';

  @override
  String get chatRoutesTitle => 'Come gli arriva';

  @override
  String get chatRoutesBluetoothHint =>
      'Direttamente sul suo telefono, senza internet';

  @override
  String get chatRoutesMeshHint => 'Passato dai telefoni che stanno in mezzo';

  @override
  String get chatRoutesInternetHint =>
      'Tramite un relay, quando non c\'è nessuno nel raggio';

  @override
  String get chatRoutesHint =>
      'La strada viene scelta per ogni messaggio, tra quello che è raggiungibile in quel momento.';

  @override
  String get chatRoutesPreferTitle => 'Cosa provare prima';

  @override
  String get chatRoutesPreferMesh => 'Prima Bluetooth';

  @override
  String get chatRoutesPreferMeshHint =>
      'Più veloce nella stessa stanza, non consuma dati, non dice nulla a un relay';

  @override
  String get chatRoutesPreferRelay => 'Prima internet';

  @override
  String get chatRoutesPreferRelayHint =>
      'Per un Bluetooth debole e una buona connessione';

  @override
  String get chatRoutesPreferNote =>
      'Una preferenza, non un vincolo. Se la strada scelta non è raggiungibile, il messaggio passa comunque dall\'altra.';

  @override
  String get deadmanTitle => 'Cancella se inutilizzata';

  @override
  String get deadmanOff => 'Disattivato';

  @override
  String deadmanDays(int days) {
    return 'Dopo $days giorni';
  }

  @override
  String get deadmanHint =>
      'Se nessuno apre l\'app per tutto quel tempo, tutto ciò che contiene viene cancellato alla successiva apertura. Non può avvisarti prima — è proprio questo lo scopo.';

  @override
  String chatForwardedFrom(String name) {
    return 'Inoltrato da $name';
  }

  @override
  String appLockWait(String left) {
    return 'Troppi tentativi — attendi $left';
  }

  @override
  String get appLockGraceTitle => 'Chiedi il codice';

  @override
  String get appLockGraceNow => 'Ogni volta';

  @override
  String appLockGraceAfter(String left) {
    return 'Dopo $left di assenza';
  }

  @override
  String get chatCalendarTitle => 'Per data';

  @override
  String get chatCalendarEmpty => 'Qui non è stato ancora detto nulla';

  @override
  String get chatsSearchChatsSection => 'Chat';

  @override
  String get chatsSearchMessagesSection => 'Messaggi';

  @override
  String get contactProfileViewInChat => 'Vedi nella chat';

  @override
  String get chatDraft => 'Bozza';

  @override
  String get chatSearchTitle => 'Cerca';

  @override
  String get chatSearchHint => 'Cerca nei messaggi';

  @override
  String get chatSearchNoResults => 'Nessun risultato';

  @override
  String get chatSearchPrevious => 'Risultato precedente';

  @override
  String get chatSearchNext => 'Risultato successivo';

  @override
  String chatMessageCount(int count) {
    return '$count messaggi';
  }

  @override
  String get chatRouteBluetooth => 'Bluetooth';

  @override
  String get chatRouteMesh => 'Mesh';

  @override
  String get chatRouteInternet => 'Internet';

  @override
  String get chatRouteQueued => 'In coda';

  @override
  String get attachStickers => 'Sticker';

  @override
  String get stickersEmpty => 'Ancora nessuno sticker';

  @override
  String get stickersEmptyHint =>
      'Salva un\'immagine da una chat e apparirà qui.';

  @override
  String get stickerKeep => 'Salva come sticker';

  @override
  String get stickerKept => 'Salvato nei tuoi sticker';

  @override
  String get stickerForget => 'Rimuovi sticker';

  @override
  String get stickerCreate => 'Crea uno sticker da una foto';

  @override
  String get stickerFailed =>
      'Impossibile trasformare questa immagine in uno sticker';

  @override
  String get stickerLabel => 'Sticker';

  @override
  String get previewPhoto => 'Foto';

  @override
  String get previewVoice => 'Messaggio vocale';

  @override
  String get previewFile => 'File';

  @override
  String get stickerEmojiTitle => 'Scegli un\'emoji per lo sticker';

  @override
  String get stickersMine => 'I miei sticker';

  @override
  String get stickersStarterPack => 'Cubi';

  @override
  String get emojiTab => 'Emoji';

  @override
  String get chatBlockedStatus => 'bloccato';

  @override
  String get chatBlockedHint => 'Hai bloccato questa persona';

  @override
  String get chatRouteFallbackOff => 'Internet off';

  @override
  String get chatAttachmentUnavailable =>
      'Nessuna connessione disponibile. Connettiti tramite Bluetooth o internet e riprova.';

  @override
  String get fileTransfersTitle => 'Trasferimenti file';

  @override
  String get fileTransfersClear => 'Cancella cronologia';

  @override
  String get fileTransfersEmpty => 'Ancora nessun trasferimento';

  @override
  String get fileTransfersActive => 'Attivi';

  @override
  String get fileTransfersHistory => 'Cronologia';

  @override
  String get fileTransferPause => 'Pausa';

  @override
  String get fileTransferResume => 'Riprendi';

  @override
  String get fileTransferRetry => 'Riprova';

  @override
  String get fileTransferQueued => 'In attesa di connessione';

  @override
  String get fileTransferRunning => 'Trasferimento';

  @override
  String get fileTransferPaused => 'In pausa';

  @override
  String get fileTransferCompleted => 'Completato';

  @override
  String get fileTransferFailed => 'Non riuscito';

  @override
  String get fileTransferCanceled => 'Annullato';

  @override
  String get profileFileTransfers => 'Trasferimenti file';

  @override
  String get profileFileTransfersSubtitle =>
      'Avanzamento, coda e cronologia dei trasferimenti';

  @override
  String get qrScanAction => 'Scansiona codice QR';

  @override
  String get qrScanTitle => 'Scansiona codice QR';

  @override
  String get qrScanHint =>
      'Scansiona un codice CubeChat di contatto, canale, trasferimento account o accesso da computer.';

  @override
  String get qrFlash => 'Torcia';

  @override
  String get qrCameraError =>
      'Fotocamera non disponibile. Controlla l\'autorizzazione della fotocamera e riprova.';

  @override
  String get qrInvalid => 'Questo non è un codice QR Cubechat valido.';

  @override
  String qrChannelAdded(String name) {
    return '$name aggiunto';
  }

  @override
  String get qrShow => 'Mostra codice QR';

  @override
  String qrChannelTitle(String name) {
    return 'Entra in $name';
  }

  @override
  String get profileBackup => 'Backup crittografato';

  @override
  String get profileBackupSubtitle =>
      'Sposta chiavi, contatti e cronologia in sicurezza';

  @override
  String get backupTitle => 'Backup crittografato';

  @override
  String get backupExplainer =>
      'Il backup contiene le tue chiavi di identità private, i contatti, i canali, le impostazioni e la cronologia dei messaggi. Viene crittografato su questo telefono con la password che scegli; Cubechat non può recuperare una password dimenticata.';

  @override
  String get backupCreate => 'Crea backup';

  @override
  String get backupCreateSubtitle =>
      'Crittografa tutto e salva un file .cchatbackup';

  @override
  String get backupRestore => 'Ripristina backup';

  @override
  String get backupRestoreSubtitle =>
      'Sostituisci il profilo Cubechat di questo telefono da un file di backup';

  @override
  String get backupPasswordTitle => 'Password del backup';

  @override
  String get backupPasswordHint => 'Almeno 8 caratteri';

  @override
  String get backupConfirmPassword => 'Ripeti la password';

  @override
  String get backupPasswordMismatch => 'Le password non coincidono';

  @override
  String get backupPasswordShort => 'Usa almeno 8 caratteri';

  @override
  String get backupSaveTitle => 'Salva backup Cubechat';

  @override
  String get backupSaved => 'Backup crittografato salvato';

  @override
  String get backupWhereTitle => 'Dove salvare il backup?';

  @override
  String get backupSaveToFiles => 'Salva in File';

  @override
  String get backupSaveToFilesHint =>
      'Una cartella su questo telefono, una scheda di memoria o un cloud';

  @override
  String get backupSendToApp => 'Invia a un\'app';

  @override
  String get backupSendToAppHint =>
      'Telegram, email, un messenger — qualsiasi cosa accetti file';

  @override
  String get backupFailed => 'Impossibile completare l\'operazione di backup';

  @override
  String get backupRestoreConfirmTitle => 'Sostituire questo profilo?';

  @override
  String get backupRestoreConfirmMessage =>
      'Le chiavi, i contatti, i canali, le impostazioni e la cronologia attuali su questo telefono verranno sostituiti dal backup selezionato.';

  @override
  String get backupRestoreConfirmAction => 'Ripristina';

  @override
  String get backupRestored => 'Backup ripristinato';

  @override
  String get backupPackingWait => 'Creazione del backup…';

  @override
  String get backupUnpackingWait => 'Ripristino del backup…';

  @override
  String get backupWaitHint =>
      'Con foto e video può richiedere qualche minuto. Tieni l\'app aperta.';

  @override
  String get backupInvalid =>
      'Password errata, file danneggiato o backup non supportato';

  @override
  String get channelInfoTitle => 'Info canale';

  @override
  String get channelParticipantsTitle => 'Partecipanti';

  @override
  String get channelAdministratorsTitle => 'Amministratori';

  @override
  String get channelMakeAdmin => 'Rendi amministratore';

  @override
  String get channelRemoveAdmin => 'Rimuovi amministratore';

  @override
  String get channelNoParticipants =>
      'I partecipanti appariranno dopo un\'attività firmata';

  @override
  String get channelSharedContent => 'Media, file e sondaggi';

  @override
  String get channelDescriptionTitle => 'Descrizione';

  @override
  String get channelDescriptionEmpty => 'Ancora nessuna descrizione';

  @override
  String get channelDescriptionHint => 'A cosa serve questo canale';

  @override
  String get channelDescriptionAdminOnly =>
      'Solo un amministratore può modificare la descrizione';

  @override
  String get channelDescriptionSave => 'Salva';

  @override
  String get channelPrivateSubtitle => 'canale privato';

  @override
  String get channelAvatarSet => 'Imposta una nuova foto';

  @override
  String get channelSettingsTitle => 'Impostazioni canale';

  @override
  String get channelSettingsHint => 'Chi può scrivere, copia, cronologia';

  @override
  String get channelLeaveAction => 'Esci';

  @override
  String get channelLeaveConfirm =>
      'La stanza e tutto ciò che vi è stato detto spariscono da questo telefono. La chiave deriva dal nome, quindi puoi riaprirla digitando lo stesso nome.';

  @override
  String get channelShareAction => 'Condividi';

  @override
  String channelMembersOf(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count membri',
      one: '1 membro',
    );
    return '$_temp0';
  }

  @override
  String get chatTyping => 'sta scrivendo…';

  @override
  String get chatRecordingVoice => 'registra un vocale…';

  @override
  String get chatRecordingCircle => 'registra un videomessaggio…';

  @override
  String get chatSendingPhoto => 'invia una foto…';

  @override
  String get chatSendingVideo => 'invia un video…';

  @override
  String get chatSendingFile => 'invia un file…';

  @override
  String get onboardingMeshTitle => 'Funziona senza internet';

  @override
  String get onboardingMeshBody =>
      'I messaggi viaggiano via Bluetooth, da telefono a telefono. Niente segnale, niente Wi-Fi, niente account — solo le persone intorno a te.';

  @override
  String get onboardingRelayTitle => 'E con internet, quando c\'è';

  @override
  String get onboardingRelayBody =>
      'Fuori dalla portata del Bluetooth, i messaggi passano da internet e arrivano allo stesso modo. Non devi mai scegliere tu.';

  @override
  String get onboardingPrivacyTitle => 'Nessuno nel mezzo può leggerli';

  @override
  String get onboardingPrivacyBody =>
      'Tutto è crittografato end-to-end e la tua identità è una chiave su questo telefono — non un numero di telefono, non un\'email, non un account che qualcuno può portarti via.';

  @override
  String get onboardingSkip => 'Salta';

  @override
  String get onboardingNext => 'Avanti';

  @override
  String get onboardingStart => 'Inizia';

  @override
  String get chatMediaShare => 'Condividi';

  @override
  String get chatMediaSaveToGallery => 'Salva in galleria';

  @override
  String get chatMediaShowInChat => 'Mostra nella chat';

  @override
  String get chatWallpaperTitle => 'Sfondo';

  @override
  String get chatWallpaperClear => 'Ripristina';

  @override
  String get chatWallpaperDim => 'Scurisci dietro i messaggi';

  @override
  String get chatSelectAction => 'Seleziona';

  @override
  String get chatForwardNothing => 'Qui non c\'è nulla da inoltrare';

  @override
  String chatSelectedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count selezionati',
      one: '1 selezionato',
    );
    return '$_temp0';
  }

  @override
  String chatDeleteSelectedTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Eliminare $count messaggi?',
      one: 'Eliminare questo messaggio?',
    );
    return '$_temp0';
  }

  @override
  String get contactAliasAction => 'Rinomina contatto';

  @override
  String get contactAliasHint =>
      'Solo tu vedi questo nome. Lascia vuoto per usare il suo.';

  @override
  String get viewOnceSendLabel => 'Visualizza una volta';

  @override
  String get viewOnceTitle => 'Visualizza una volta';

  @override
  String get viewOnceTapToView => 'Foto · tocca per vederla una volta';

  @override
  String get viewOnceSent => 'Foto · inviata';

  @override
  String get viewOnceOpened => 'Foto aperta';

  @override
  String get viewOnceUnavailable => 'Questa foto non è più disponibile';

  @override
  String get viewOnceWarning =>
      'Chiudendo, la foto verrà eliminata per entrambi.';

  @override
  String get channelAvatarAdminOnly =>
      'Solo un amministratore può cambiare la foto del canale';

  @override
  String get channelAdminOnly => 'Solo un amministratore può modificarlo';

  @override
  String get channelAvatarTooLarge =>
      'Questa foto è troppo grande da trasmettere';

  @override
  String get channelMemberUnknown => 'Non ancora nei tuoi contatti';

  @override
  String get channelInviteToContacts => 'Inviagli la tua scheda contatto';

  @override
  String channelContactInviteSent(String name) {
    return 'Scheda contatto offerta a $name';
  }

  @override
  String get chatContactInvitation => 'Invito a connettersi';

  @override
  String get chatContactInvitationForYou => 'Invito per te';

  @override
  String get channelPollTitle => 'Sondaggio';

  @override
  String get channelCreatePoll => 'Crea sondaggio';

  @override
  String get channelPollQuestion => 'Domanda';

  @override
  String channelPollOption(int number) {
    return 'Opzione $number';
  }

  @override
  String get channelPollAddOption => 'Aggiungi opzione';

  @override
  String get channelPollCreate => 'Pubblica sondaggio';

  @override
  String channelPollVotes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count voti',
      one: '1 voto',
      zero: 'Nessun voto',
    );
    return '$_temp0';
  }

  @override
  String get phoneTransferTitle => 'Trasferisci su un nuovo telefono';

  @override
  String get desktopPickChat => 'Scegli a chi vuoi scrivere';

  @override
  String get desktopListCollapse => 'Mostra solo le foto';

  @override
  String get desktopListExpand => 'Mostra l\'elenco delle chat';

  @override
  String get desktopLinkConnectTitle => 'Collega un computer';

  @override
  String get desktopLinkConnectHint =>
      'Scansiona il codice che CubeChat mostra sul computer';

  @override
  String get desktopLinkSignIn => 'Accedi con l\'account del telefono';

  @override
  String get desktopLinkTitle => 'Accedi con il telefono';

  @override
  String get desktopLinkSteps =>
      'Sul telefono: Profilo → Dati → Collega un computer, poi scansiona questo codice. Entrambi devono essere sulla stessa rete Wi-Fi.';

  @override
  String get desktopLinkLimits =>
      'Il telefono continua a funzionare. I messaggi da internet arrivano su entrambi; ciò che invii da uno non appare ancora sull\'altro.';

  @override
  String get desktopLinkWaiting => 'In attesa del telefono…';

  @override
  String get desktopLinkFailed => 'Impossibile ricevere l\'account. Riprova.';

  @override
  String get desktopLinkRetry => 'Riprova';

  @override
  String get desktopLinkConfirmTitle =>
      'Inviare una copia di questo account al computer?';

  @override
  String get desktopLinkConfirmMessage =>
      'Il computer riceve le tue chiavi, i contatti e le chat. Questo telefono continua a funzionare com\'è.';

  @override
  String get desktopLinkConfirmAction => 'Invia';

  @override
  String desktopLinkConfirmWhere(String address) {
    return 'Solo se hai appena scansionato questo codice dallo schermo del tuo computer. Verrà inviato a $address su questa rete.';
  }

  @override
  String get desktopLinkSending => 'Invio dell\'account…';

  @override
  String get desktopLinkSent => 'Il computer è collegato';

  @override
  String get desktopLinkPhoneFound =>
      'Il telefono ha trovato questo computer e sta creando una copia dell\'account. Con le foto può richiedere qualche minuto.';

  @override
  String desktopLinkReceiving(int percent) {
    return 'Ricezione dell\'account: $percent%';
  }

  @override
  String get desktopLinkRestoring =>
      'Installazione dell\'account su questo computer…';

  @override
  String get desktopLinkFinding => 'Ricerca del computer…';

  @override
  String get desktopLinkPreparing =>
      'Creazione di una copia dell\'account. Con le foto può richiedere qualche minuto.';

  @override
  String desktopLinkSendingPercent(int percent) {
    return 'Invio: $percent%';
  }

  @override
  String get desktopLinkComputerRestoring =>
      'Il computer sta installando l\'account…';

  @override
  String get devicesTitle => 'Dispositivi';

  @override
  String get devicesRowHint =>
      'Dove è aperto il tuo account, e come disconnetterlo';

  @override
  String get devicesThisDevice => 'Questo dispositivo';

  @override
  String get devicesSeenNow => 'Online proprio ora';

  @override
  String devicesSeenMinutes(int n) {
    return 'Online $n min fa';
  }

  @override
  String devicesSeenHours(int n) {
    return 'Online $n h fa';
  }

  @override
  String devicesSeenDays(int n) {
    return 'Online $n g fa';
  }

  @override
  String get devicesLeaving => 'Disconnessione — in attesa che torni online';

  @override
  String get devicesSignOut => 'Esci';

  @override
  String get devicesSignOutAll => 'Esci da tutti gli altri dispositivi';

  @override
  String devicesSignOutTitle(String name) {
    return 'Uscire da «$name»?';
  }

  @override
  String get devicesSignOutMessage =>
      'Chiavi, chat e impostazioni di CubeChat verranno cancellate su quel dispositivo appena torna online. L\'account resta qui e sugli altri tuoi dispositivi.';

  @override
  String get devicesSignOutPhoneMessage =>
      'È un telefono: CubeChat verrà cancellata completamente. L\'account resta qui e sugli altri tuoi dispositivi.';

  @override
  String get devicesSignOutAllMessage =>
      'Ogni altro dispositivo verrà disconnesso appena torna online. L\'account resterà solo qui.';

  @override
  String get devicesRename => 'Rinomina';

  @override
  String get devicesRenameTitle => 'Nome di questo dispositivo';

  @override
  String get devicesSave => 'Salva';

  @override
  String get devicesEmpty =>
      'Ancora nessun altro dispositivo. Un dispositivo appare qui dopo aver aperto CubeChat 1.0.0+1147 o successiva.';

  @override
  String get devicesCaveat =>
      'La disconnessione ha effetto quando quel dispositivo va online. Uno tenuto offline conserva le chiavi; la protezione completa richiederebbe nuove chiavi per l\'account.';

  @override
  String get desktopLinkImportTitle => 'Sposta l\'account dal telefono';

  @override
  String get desktopLinkImportHint =>
      'Mostra un codice al telefono e questo computer diventerà una copia del suo account';

  @override
  String get desktopLinkImportConfirmTitle =>
      'Sostituire l\'account su questo computer?';

  @override
  String get desktopLinkImportConfirmMessage =>
      'Chiavi, contatti e chat di questo computer verranno sostituiti dall\'account del telefono. Se ti serve ancora questo, prima fai un backup.';

  @override
  String get desktopLinkImportConfirmAction => 'Continua';

  @override
  String get desktopLinkUnreachable =>
      'Impossibile raggiungere il computer. Entrambi devono essere sulla stessa rete Wi-Fi e sul computer CubeChat deve essere consentita nel firewall.';

  @override
  String get desktopLinkFirewallHint =>
      'Windows potrebbe bloccare il telefono verso questo computer. Consenti CubeChat nel firewall — solo per la rete locale.';

  @override
  String get desktopLinkFirewallAllow => 'Consenti nel firewall';

  @override
  String get desktopLinkFirewallDeclined =>
      'Windows non l\'ha consentito. Senza, il telefono potrebbe non riuscire a collegarsi.';

  @override
  String get phoneTransferIntro =>
      'Sposta profilo, chiavi, contatti, canali, impostazioni e cronologia direttamente tra due telefoni.';

  @override
  String get phoneTransferSend => 'Questo è il vecchio telefono';

  @override
  String get phoneTransferReceive => 'Questo è il nuovo telefono';

  @override
  String get phoneTransferSameWifi =>
      'Collega entrambi i telefoni alla stessa rete Wi-Fi. Tieni aperta questa schermata fino al termine del trasferimento.';

  @override
  String get phoneTransferPreparing =>
      'Preparazione del trasferimento crittografato…';

  @override
  String get phoneTransferReady =>
      'Scansiona questo codice QR monouso sul nuovo telefono';

  @override
  String get phoneTransferScan => 'Scansiona il vecchio telefono';

  @override
  String get phoneTransferConfirmTitle =>
      'Sostituire il profilo di questo telefono?';

  @override
  String get phoneTransferConfirmMessage =>
      'Il profilo attualmente salvato su questo telefono verrà sostituito dal trasferimento locale crittografato.';

  @override
  String get phoneTransferConfirmAction => 'Trasferisci profilo';

  @override
  String get phoneTransferSuccess => 'Profilo trasferito correttamente';

  @override
  String get phoneTransferFailed => 'Impossibile completare il trasferimento';

  @override
  String get profileSummaryMeshOnly => 'Solo mesh';

  @override
  String get profileSummaryMeshInternet => 'Mesh · internet';

  @override
  String get profileSummaryBackgroundOn => 'attivo in background';

  @override
  String profileSummaryTransfersActive(int count) {
    return '$count in corso';
  }

  @override
  String get profileSummaryCardBackup => 'File, backup';

  @override
  String get chatPlay => 'Riproduci';

  @override
  String get chatPause => 'Pausa';

  @override
  String get profileTheme => 'Colore';

  @override
  String get profileThemeEmerald => 'Smeraldo';

  @override
  String get profileThemeIndigo => 'Indaco';

  @override
  String get profileThemeAmber => 'Ambra';

  @override
  String get profileThemeRose => 'Rosa';

  @override
  String get profileThemeFuchsia => 'Fucsia';

  @override
  String get profileThemeViolet => 'Viola';

  @override
  String get profileThemeOcean => 'Oceano';

  @override
  String get profileThemeSlate => 'Ardesia';

  @override
  String get profileScale => 'Dimensione interfaccia';

  @override
  String get profileScaleSystem => 'Sistema';

  @override
  String get profileGlass => 'Vetro';

  @override
  String get profileGlassAuto => 'Automatico';

  @override
  String get profileGlassFull => 'Completo';

  @override
  String get profileGlassLight => 'Leggero';

  @override
  String get profileGlassHint =>
      'Leggero mantiene la tinta ed elimina la sfocatura dietro i pannelli. Automatico misura il telefono una volta e decide. Su un telefono che già tiene il passo serve a poco — è pensato per uno che non ce la fa.';

  @override
  String get mapAlwaysNeeded =>
      'Perché la mappa resti aggiornata mentre cubechat è chiusa, la posizione deve essere impostata su Sempre. Tocca per aprire Impostazioni.';

  @override
  String get mapShareConsentTitle => 'Mostrare la tua posizione sulla mappa?';

  @override
  String get mapShareConsentBody =>
      'La tua posizione in tempo reale sarà mostrata solo ai contatti sulla tua mappa: persone che hai invitato o di cui hai accettato l\'invito. Continua ad aggiornarsi, anche quando Cubechat è in background, finché non ti nascondi. È crittografata end-to-end e non arriva mai a noi. Puoi nasconderti in qualsiasi momento sulla mappa o nel Profilo, e i contatti che blocchi non ti vedono mai.';

  @override
  String get mapShareConsentAllow => 'Consenti';

  @override
  String get mapShareConsentDecline => 'Non consentire';

  @override
  String get mapVisibleToFriends => 'Gli amici sulla mappa ti vedono';

  @override
  String get mapHiddenFromFriends => 'Sei nascosto';

  @override
  String get mapHideMe => 'Nasconditi';

  @override
  String get mapShowMe => 'Mostrami';

  @override
  String get profileScaleSmall => 'Più piccola';

  @override
  String get profileScaleNormal => 'Normale';

  @override
  String get profileScaleLarge => 'Più grande';

  @override
  String get profileScaleSample =>
      'Testo e righe vengono disegnati a questa dimensione.';

  @override
  String get savedTitle => 'Salvati';

  @override
  String get savedSubtitle => 'Note per te, su questo dispositivo';

  @override
  String get savedEmpty => 'Tutto ciò che scrivi qui resta su questo telefono.';

  @override
  String get meshOffTitle => 'La mesh Bluetooth è disattivata';

  @override
  String get meshOffHint =>
      'Nessuno nelle vicinanze può trovarti e tu non puoi trovare loro. I messaggi viaggiano comunque tramite il relay internet.';

  @override
  String get profileMeshSwitch => 'Mesh Bluetooth';

  @override
  String get profileMeshSwitchHint =>
      'Trova persone vicine e trasporta messaggi senza internet. Disattivarla fa risparmiare batteria.';

  @override
  String get channelAdminOnlyHint =>
      'Un canale di annunci. Tutti possono comunque leggerlo.';

  @override
  String get attachLocation => 'Posizione';

  @override
  String get locationBubbleTitle => 'Posizione';

  @override
  String get locationOpenInMaps => 'Apri in Mappe';

  @override
  String locationAccuracy(int metres) {
    return 'entro $metres m';
  }

  @override
  String get locationExpired => 'Questa posizione non è più attuale';

  @override
  String get locationDenied => 'L\'autorizzazione alla posizione è disattivata';

  @override
  String get locationUnavailable => 'Impossibile ottenere la posizione';

  @override
  String get locationShareFor => 'Condividi per';

  @override
  String get locationShareOnce => 'Solo una volta';

  @override
  String get locationShare15m => '15 minuti';

  @override
  String get locationShare1h => '1 ora';

  @override
  String get storageTitle => 'Spazio';

  @override
  String get storageHeadline => 'Utilizzo spazio';

  @override
  String storageSubtitle(String size) {
    return 'cubechat usa $size su questo dispositivo';
  }

  @override
  String get storageEmpty => 'Ancora niente salvato';

  @override
  String get storageScanning => 'Calcolo…';

  @override
  String get storageCatPhotos => 'Foto';

  @override
  String get storageCatVoice => 'Messaggi vocali';

  @override
  String get storageCatFiles => 'File ricevuti';

  @override
  String get storageCatOutbox => 'File inviati';

  @override
  String get storageCatStickers => 'Sticker';

  @override
  String get storageCatSaved => 'Messaggi salvati';

  @override
  String get storageCatWallpapers => 'Sfondi';

  @override
  String get storageCatHistory => 'Conversazioni e chiavi';

  @override
  String get storageCatCache => 'Cache';

  @override
  String storageClear(String size) {
    return 'Libera $size';
  }

  @override
  String get storageClearNothing => 'Nessuna selezione';

  @override
  String storageFreed(String size) {
    return 'Liberati $size';
  }

  @override
  String get storageNoCloud =>
      'Dietro non c\'è nessun cloud. Tutto ciò che cancelli sparisce da questo telefono, e l\'unica altra copia è sul telefono da cui è arrivato.';

  @override
  String get storageWhyHistoryLocked =>
      'Le conversazioni non si cancellano da qui — usa la Cancellazione d\'emergenza.';

  @override
  String get storageRecoveryFree => 'Sicuro da cancellare';

  @override
  String get storageRecoveryGone => 'Nessuna copia altrove';

  @override
  String get storageRecoveryAskSender =>
      'Si può richiedere di nuovo al mittente';

  @override
  String get storageRecoveryCostsThem =>
      'Non potranno più chiederti di reinviarlo';

  @override
  String storageConfirmTitle(String size) {
    return 'Liberare $size?';
  }

  @override
  String get storageConfirmBody =>
      'I file verranno eliminati da questo telefono. Nulla viene caricato altrove, quindi non c\'è da dove ripristinarli.';

  @override
  String storageFilesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count file',
      one: '$count file',
      zero: 'nessun file',
    );
    return '$_temp0';
  }

  @override
  String get customizeBarTitle => 'Barra di navigazione';

  @override
  String get customizeBarHint =>
      'Trascina per riordinare. Chat non può essere rimossa.';

  @override
  String get customizeBarShown => 'Visibili';

  @override
  String get customizeBarHidden => 'Nascoste';

  @override
  String get customizeBarHiddenEmpty => 'Niente di nascosto';

  @override
  String get customizeBarMinimum => 'Tieni almeno due schede';

  @override
  String get customizeReset => 'Ripristina predefiniti';

  @override
  String get chatsArchiveTitle => 'Archivio';

  @override
  String get chatsArchiveEmpty => 'Nessuna chat archiviata';

  @override
  String get chatsArchiveHint =>
      'Le chat archiviate continuano a funzionare — sono solo fuori dall\'elenco.';

  @override
  String get chatsArchivedToast => 'Archiviata';

  @override
  String get chatsUnarchivedToast => 'Di nuovo nell\'elenco';

  @override
  String chatsArchiveCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count chat',
      one: '$count chat',
    );
    return '$_temp0';
  }

  @override
  String get chatsSwipeNotHere => 'Non disponibile per questa chat';

  @override
  String get customizeSwipeTitle => 'Scorri una chat a destra';

  @override
  String get customizeSwipeHint =>
      'Scorrere a sinistra cambia comunque scheda.';

  @override
  String get customizeSwipeArchive => 'Archivia';

  @override
  String get customizeSwipeMute => 'Silenzia';

  @override
  String get customizeSwipePin => 'Fissa';

  @override
  String get customizeSwipeRead => 'Segna letta';

  @override
  String get customizeSwipeDelete => 'Elimina';

  @override
  String get customizeSwipeNone => 'Niente';

  @override
  String get customizeHighRefresh => 'Frequenza di aggiornamento piena';

  @override
  String get customizeHighRefreshHint =>
      'Più fluido, e il telefono disegna il doppio dei fotogrammi. Disattivala se il telefono si scalda — l\'aspetto dell\'app non cambia, solo quanto spesso viene ridisegnata.';

  @override
  String get customizeQuickReaction => 'Reazione con doppio tocco';

  @override
  String get customizeQuickReactionHint =>
      'Cosa lascia un doppio tocco su un messaggio. Se ne usi un\'altra, finisce qui.';

  @override
  String get customizeCircleAudioTitle =>
      'Metti in pausa la musica per i videomessaggi';

  @override
  String get customizeCircleAudioOn =>
      'Registrarne o guardarne uno interrompe qualsiasi altra riproduzione. Non riparte da sola.';

  @override
  String get customizeCircleAudioOff =>
      'La tua musica continua in sottofondo, più bassa mentre c\'è un videomessaggio.';

  @override
  String get customizeMediaQualityTitle => 'Qualità delle foto inviate';

  @override
  String get customizeMediaQualityEconomy => 'Economica';

  @override
  String get customizeMediaQualityStandard => 'Standard';

  @override
  String get customizeMediaQualityHigh => 'Alta';

  @override
  String get customizeMediaQualityEconomyHint =>
      'Fino a 96 KB per foto, 800 px. Per una tacca di segnale o una mesh Bluetooth affollata: metà dell\'attesa, un\'immagine più morbida.';

  @override
  String get customizeMediaQualityStandardHint =>
      'Fino a 192 KB per foto, 1280 px. Dimensionata per passare anche solo via Bluetooth. I video e \"Originale\" vengono sempre inviati così come sono.';

  @override
  String get customizeMediaQualityHighHint =>
      'Fino a 768 KB per foto, 2048 px. Abbastanza nitida per zoomare; quattro volte più lenta da inviare, meglio su Wi-Fi.';

  @override
  String get previewReacted => 'al tuo messaggio';

  @override
  String get previewLocation => 'Posizione';

  @override
  String get previewMapInvite => 'Invito alla mappa';

  @override
  String get previewContact => 'Contatto';

  @override
  String get previewUnsupported => 'Messaggio non supportato';

  @override
  String get previewCallOutgoing => 'Chiamata in uscita';

  @override
  String get previewCallIncoming => 'Chiamata in arrivo';

  @override
  String get previewCallMissed => 'Chiamata persa';

  @override
  String chatPreparingPhotos(int count) {
    return 'Preparazione di $count foto…';
  }

  @override
  String get circleSwitchCamera => 'Cambia fotocamera';

  @override
  String get circleLight => 'Luce di registrazione';

  @override
  String get circleCameraSwitchFailed =>
      'Impossibile cambiare fotocamera. La registrazione è ancora aperta.';

  @override
  String get diagnosticsTitle => 'Diagnostica';

  @override
  String get diagnosticsIntro =>
      'Cosa ha fatto l\'app di recente. Se qualcosa non funziona, invia questo allo sviluppatore.';

  @override
  String get diagnosticsShare => 'Invia log allo sviluppatore';

  @override
  String get diagnosticsEvents => 'Eventi recenti';

  @override
  String get diagnosticsTechnical => 'Registri tecnici';

  @override
  String get diagnosticsEmpty => 'Ancora niente da mostrare.';

  @override
  String get diagnosticsDeveloperOn => 'Modalità sviluppatore attiva';

  @override
  String get diagnosticsDeveloperOff => 'Modalità sviluppatore disattivata';

  @override
  String get logAppStarted => 'App avviata';

  @override
  String get logInternetOn => 'Connessione internet attiva';

  @override
  String logServerConnected(String host) {
    return 'Connesso a $host';
  }

  @override
  String logServerLost(String host) {
    return 'Connessione persa con $host';
  }

  @override
  String get chatSaveAction => 'Salva';

  @override
  String get savedTagAsk => 'Salvato. Aggiungere un tag?';

  @override
  String get savedTagAdd => 'Aggiungi un tag';

  @override
  String get chatSharedWallpaperFailed =>
      'Sfondo impostato qui. Gli arriverà quando sarà nel raggio.';

  @override
  String get chatTranscribeAction => 'Trascrivi';

  @override
  String get chatTranscribeFailed =>
      'Questo telefono non riesce a trascriverlo.';

  @override
  String get chatTranscribing => 'Riconoscimento…';

  @override
  String get chatTranscriptHide => 'Nascondi testo';

  @override
  String get chatCancelSend => 'Annulla invio';

  @override
  String get chatDownloadAction => 'Scarica';

  @override
  String get chatDownloaded => 'Salvato sul telefono';

  @override
  String get chatDownloadFailed => 'Impossibile salvarlo';

  @override
  String get selfUpdateTitle => 'Installa un aggiornamento da file';

  @override
  String get selfUpdateHint =>
      'Scegli qui il nuovo APK di cubechat invece di aprirlo da una chat: installato così, le chiamate sulla schermata di blocco restano attive.';

  @override
  String get selfUpdateConfirm =>
      'Conferma l\'installazione nella finestra di sistema.';

  @override
  String get selfUpdateAllow =>
      'Consenti a cubechat di installare app, poi tocca di nuovo.';

  @override
  String get selfUpdateNotOurs =>
      'Questo file non è un aggiornamento di cubechat.';

  @override
  String get selfUpdateFailed => 'L\'aggiornamento non è stato installato.';

  @override
  String get chatTranscribeDownloading =>
      'Il telefono sta scaricando la lingua necessaria. Riprova tra un minuto.';

  @override
  String get chatTranscribeNoLanguage =>
      'Questo telefono non ha un modello vocale per quella lingua. Scegli la lingua di trascrizione in Profilo → Chat e media.';

  @override
  String get chatTranscribeNotAllowed =>
      'Il riconoscimento vocale è disattivato per CubeChat. Attivalo in Impostazioni dell\'iPhone → CubeChat.';

  @override
  String get customizeTranscribeLanguageTitle => 'Lingua di trascrizione';

  @override
  String get customizeTranscribeLanguageAuto => 'Auto';

  @override
  String get customizeTranscribeLanguageHint =>
      'La lingua in cui sono parlati i vocali, che non deve per forza essere quella dell\'app. Auto prova le lingue del telefono. Una lingua mancante viene scaricata dal telefono stesso; la voce non lo lascia mai.';

  @override
  String get chatTranslateAction => 'Traduci';

  @override
  String get chatTranslateFailed =>
      'Questo messaggio non si può tradurre su questo telefono.';

  @override
  String get customizeDeferMediaTitle =>
      'Attendi il Wi-Fi per scaricare i media';

  @override
  String get customizeDeferMediaHint =>
      'Con i dati mobili, messaggi e chiamate funzionano come sempre, mentre foto, vocali, videomessaggi e file aspettano il Wi-Fi sul server — fino a due settimane. Una riga sopra le chat mostra cosa è in attesa e lo scarica subito.';

  @override
  String heldMediaCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count media in attesa del Wi-Fi',
      one: '1 media in attesa del Wi-Fi',
    );
    return '$_temp0';
  }

  @override
  String get heldMediaDownload => 'Scarica';

  @override
  String get nearbyAirDropSubtitle => 'Condividi file con le persone vicine';

  @override
  String get nearbyFilesSubtitle => 'File inviati e ricevuti';

  @override
  String get airdropTab => 'AirDrop';

  @override
  String get nearbyTabFiles => 'File';

  @override
  String get airdropReceiveHint => 'Chi può inviarti file';

  @override
  String get airdropReceiveContacts => 'Contatti';

  @override
  String get airdropReceiveEveryone => 'Tutti 10 min';

  @override
  String airdropEveryoneLeft(String time) {
    return 'Tutti · $time';
  }

  @override
  String get airdropSendFiles => 'Invia file';

  @override
  String get airdropChooseFiles => 'Scegli file';

  @override
  String airdropStagedTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count file pronti',
      one: '1 file pronto',
    );
    return '$_temp0';
  }

  @override
  String get airdropStagedHint =>
      'Con il Bluetooth attivo e AirDrop aperto su entrambi i telefoni, avvicinali o scegli una persona';

  @override
  String get airdropStagedPickPerson => 'Scegli persona';

  @override
  String airdropRequestBody(String what, String size) {
    return 'vuole inviare $what · $size';
  }

  @override
  String airdropWhatPhotos(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count foto',
      one: '1 foto',
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
      other: '$count file',
      one: '1 file',
    );
    return '$_temp0';
  }

  @override
  String get airdropAccept => 'Accetta';

  @override
  String get airdropDecline => 'Rifiuta';

  @override
  String get airdropWaiting => 'In attesa di risposta…';

  @override
  String get airdropAccepted => 'Accettato';

  @override
  String get airdropUnheard =>
      'Non ricevuto — forse una versione vecchia di CubeChat';

  @override
  String get airdropSending => 'Invio';

  @override
  String get airdropReceiving => 'Ricezione';

  @override
  String get airdropInterrupted => 'Interrotto';

  @override
  String get airdropRetry => 'Riprova';

  @override
  String get airdropOutcomeSent => 'Inviato';

  @override
  String get airdropOutcomeReceived => 'Ricevuto';

  @override
  String get airdropOutcomeDeclined => 'Rifiutato';

  @override
  String get airdropOutcomeCancelled => 'Annullato';

  @override
  String get airdropOutcomePartial => 'In parte';

  @override
  String get airdropReasonNoSpace => 'spazio insufficiente';

  @override
  String get airdropReasonContactsOnly => 'solo contatti';

  @override
  String get airdropReasonBusy => 'occupato';

  @override
  String get airdropReasonTimeout => 'nessuna risposta';

  @override
  String get airdropFileDeleted => 'eliminato';

  @override
  String get airdropHistory => 'Cronologia';

  @override
  String get airdropClearHistory => 'Cancella cronologia';

  @override
  String get airdropEmpty =>
      'Qui appariranno i file che invii o ricevi nelle vicinanze';

  @override
  String get airdropPickPerson => 'Invia a';

  @override
  String get airdropNobody => 'Ancora nessuno vicino con cubechat';

  @override
  String get airdropNoDirect =>
      'Nessuna connessione Bluetooth con questa persona';

  @override
  String get airdropNearbyUnknown => 'Vicino';

  @override
  String get airdropConnecting => 'Connessione…';

  @override
  String get airdropConnectFailed => 'Impossibile connettersi';

  @override
  String get airdropSlowWarning => 'Via Bluetooth può richiedere molto tempo';

  @override
  String airdropTooLarge(String name, int limit) {
    return '$name supera $limit MB';
  }

  @override
  String airdropFromLabel(String name) {
    return 'AirDrop · $name';
  }

  @override
  String get airdropWrite => 'Scrivi';

  @override
  String get airdropAction => 'AirDrop';

  @override
  String get airdropLaneTitle => 'Canale';

  @override
  String get airdropLaneAuto => 'Auto';

  @override
  String get airdropLaneBluetooth => 'Bluetooth';

  @override
  String get airdropLaneWifi => 'Wi‑Fi';

  @override
  String get airdropBluetoothNeededHint =>
      'Attiva il Bluetooth su entrambi i telefoni per trovarvi e confermare un trasferimento.';

  @override
  String get airdropLaneHint =>
      'Il Bluetooth trova e collega i telefoni. Il Wi‑Fi trasferisce i file quando entrambi i telefoni sono sulla stessa rete o hotspot.';

  @override
  String get airdropWifiUnreachable => 'Non sulla stessa rete';

  @override
  String get airdropWifiOldVersion =>
      'La sua app non può ancora ricevere via Wi‑Fi';

  @override
  String get airdropBumpAdd => 'Aggiungi';

  @override
  String get airdropBumpAlreadyContact => 'Già nei tuoi contatti';

  @override
  String airdropBumpSending(String name) {
    return 'Invio a $name';
  }

  @override
  String airdropBumpReceiving(String name) {
    return '$name ti sta inviando dei file';
  }

  @override
  String get termsTitle => 'Regole di cubechat';

  @override
  String get termsBody =>
      'cubechat ha tolleranza zero per i contenuti inappropriati e gli utenti molesti. Continuando accetti di non inviare molestie, minacce, contenuti sessuali che coinvolgono minori, spam o qualsiasi cosa illegale. Chiunque può segnalare un messaggio o una persona; le segnalazioni arrivano allo sviluppatore e vengono gestite entro 24 ore, e chi viola le regole viene bannato.';

  @override
  String get termsReadFull => 'Leggi i termini completi';

  @override
  String get termsAccept => 'Accetto';

  @override
  String get messageHide => 'Nascondi';

  @override
  String get messageHidden => 'Nascosto per te';

  @override
  String get reportAction => 'Segnala';

  @override
  String get reportTitle => 'Qual è il problema?';

  @override
  String get reportReasonSpam => 'Spam';

  @override
  String get reportReasonAbuse => 'Abusi o molestie';

  @override
  String get reportReasonViolence => 'Violenza';

  @override
  String get reportReasonSexual => 'Contenuti sessuali';

  @override
  String get reportReasonOther => 'Altro';

  @override
  String get reportNoteHint => 'Descrivi (facoltativo)';

  @override
  String get reportSend => 'Invia segnalazione';

  @override
  String get reportDisclosure =>
      'Il testo del messaggio selezionato e la tua segnalazione vengono inviati alla moderazione di cubechat e al suo bot Telegram privato.';

  @override
  String get reportSent =>
      'Segnalazione inviata. Esaminiamo le segnalazioni entro 24 ore.';

  @override
  String get reportBlockedToo => 'Questa persona è stata bloccata per te.';

  @override
  String get reportQueued =>
      'Segnalazione salvata. Verrà inviata quando sarai online.';

  @override
  String get reportFailed => 'Impossibile inviare la segnalazione.';

  @override
  String get filteredMessage => 'Nascosto dal filtro';

  @override
  String get filteredShow => 'Mostra';

  @override
  String get filterToggle => 'Filtro contenuti offensivi';

  @override
  String get filterToggleHint =>
      'Nasconde le parole volgari degli sconosciuti e nei canali';

  @override
  String get aboutTitle => 'Info';

  @override
  String get aboutContact => 'Scrivi allo sviluppatore';

  @override
  String get aboutReport => 'Segnala una violazione';

  @override
  String get aboutTerms => 'Termini di utilizzo';

  @override
  String get aboutPrivacy => 'Informativa sulla privacy';

  @override
  String get requestsTitle => 'Richieste';

  @override
  String get requestsEmpty => 'Nessuna richiesta';

  @override
  String requestBanner(String name) {
    return '$name non è nei tuoi contatti. Finché non accetti, non può vedere che hai letto né chiamarti.';
  }

  @override
  String get requestAccept => 'Accetta';

  @override
  String get requestDelete => 'Elimina';

  @override
  String get requestBlock => 'Blocca';

  @override
  String get cubeIdTitle => 'Cube ID';

  @override
  String get cubeIdExplainer =>
      'Il tuo @nome rimanda alla tua scheda contatto. Il server conserva solo il nome e la tua scheda pubblica — mai i tuoi messaggi.';

  @override
  String get cubeIdFieldHint => 'a–z, 0–9 e _, 3–20 caratteri';

  @override
  String get cubeIdAvailable => 'Disponibile';

  @override
  String get cubeIdTaken => 'Già preso';

  @override
  String get cubeIdReserved => 'Non consentito';

  @override
  String get cubeIdInvalid => 'Solo a–z, 0–9 e _, 3–20 caratteri';

  @override
  String get cubeIdClaim => 'Prendi questo nome';

  @override
  String get cubeIdWorking => 'Registrazione del nome…';

  @override
  String get cubeIdChange => 'Cambia';

  @override
  String get cubeIdEmail => 'Email di recupero';

  @override
  String get cubeIdEmailHint =>
      'Se perdi questo telefono, il nome torna tramite una email a questo indirizzo';

  @override
  String get cubeIdEmailField => 'Email';

  @override
  String cubeIdEmailSent(String email) {
    return 'Abbiamo inviato una email a $email. Apri il link che contiene.';
  }

  @override
  String get cubeIdEmailRemove => 'Rimuovi email';

  @override
  String get cubeIdEmailUnavailable =>
      'L\'email non è disponibile al momento. Riprova più tardi.';

  @override
  String get cubeIdEmailInvalid => 'Non sembra un indirizzo email';

  @override
  String get cubeIdSave => 'Salva';

  @override
  String get cubeIdRecover => 'Recupera un nome via email';

  @override
  String get cubeIdRecoverSent =>
      'Se l\'indirizzo corrisponde, arriverà una email. Il nome passa a questo telefono 48 ore dopo che apri il link.';

  @override
  String cubeIdRecoveryWarning(String name, String when) {
    return 'Qualcuno sta recuperando @$name su un altro telefono via email. Il nome verrà spostato $when, a meno che tu non annulli.';
  }

  @override
  String get cubeIdRecoveryCancel => 'Annulla il recupero';

  @override
  String get cubeIdRecoveryCancelled => 'Recupero annullato';

  @override
  String get cubeIdRelease => 'Rilascia';

  @override
  String cubeIdReleaseConfirm(String name) {
    return 'Rilasciare @$name? Chiunque potrà prenderlo.';
  }

  @override
  String get cubeIdShare => 'Condividi';

  @override
  String cubeIdShareText(String name) {
    return 'Trovami su cubechat: @$name\nhttps://cubechat.tech/u.html#$name';
  }

  @override
  String get cubeIdFailed => 'Impossibile salvare il nome. Riprova.';

  @override
  String get cubeIdOffline => 'Nessuna connessione internet';

  @override
  String get lookupNotFound => 'Nessuno con questo @nome';

  @override
  String searchFindCubeName(String name) {
    return 'Trova @$name';
  }

  @override
  String get searchFindCubeNameHint => 'Cerca su Cube ID e aggiungi';

  @override
  String get addContactHintName => 'Incolla una scheda o digita @nome';

  @override
  String get strangerReachTitle => 'Chi può scrivermi da internet';

  @override
  String get strangerReachAll => 'Tutti';

  @override
  String get strangerReachRequest => 'Su richiesta';

  @override
  String get strangerReachNone => 'Nessuno';

  @override
  String get strangerReachHint =>
      'Per le persone a cui non hai scritto che ti raggiungono via internet. Le persone vicine via Bluetooth non sono interessate.';

  @override
  String get sectionPrivacy => 'Privacy e sicurezza';

  @override
  String get sectionNotifications => 'Notifiche e chiamate';

  @override
  String get sectionConnection => 'Connessione';

  @override
  String get sectionChats => 'Chat e media';

  @override
  String get sectionAppearance => 'Aspetto';

  @override
  String get sectionData => 'Dati e spazio';

  @override
  String get sectionAbout => 'Info';

  @override
  String get subWhoSeesMe => 'Chi mi vede';

  @override
  String get subProtection => 'Protezione';

  @override
  String get subNotifications => 'Notifiche';

  @override
  String get subCalls => 'Chiamate';

  @override
  String get profileDiscoverableMeshOff =>
      'La mesh Bluetooth è disattivata — attivala in Connessione.';

  @override
  String get chatRouteBluetoothDirect => 'Bluetooth, diretto';

  @override
  String chatRouteMeshHops(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Mesh · $n salti',
      one: 'Mesh · $n salto',
    );
    return '$_temp0';
  }

  @override
  String chatRouteDeliveredVia(String route) {
    return 'Consegnato: $route';
  }

  @override
  String chatRouteReceivedVia(String route) {
    return 'Ricevuto: $route';
  }

  @override
  String get chatUnreadDivider => 'Nuovi messaggi';

  @override
  String get radioTitle => 'Walkie-talkie';

  @override
  String get radioNearbySubtitle =>
      'Tieni premuto un pulsante e parla con un gruppo o un contatto';

  @override
  String get radioGroupsLabel => 'Gruppi';

  @override
  String get radioDirectLabel => 'Privata';

  @override
  String get radioAddGroup => 'Aggiungi una radio';

  @override
  String get radioNoGroups =>
      'Ancora nessuna radio. Aggiungine una — chi inserisce lo stesso nome e la stessa password si sente a vicenda.';

  @override
  String get radioLeave => 'Esci da questa radio';

  @override
  String get radioPickChannel => 'Scegli un gruppo o un contatto';

  @override
  String get radioPushToTalk => 'Tieni premuto per parlare';

  @override
  String get radioTalking => 'Stai parlando…';

  @override
  String get radioChannelBusy => 'Canale occupato';

  @override
  String radioSpeaker(String name) {
    return '$name sta parlando';
  }

  @override
  String get radioSilentTitle => 'Parla in modalità silenziosa';

  @override
  String get radioSilentHint =>
      'La voce si sente anche quando il telefono è in silenzioso.';

  @override
  String get radioJoinNameLabel => 'Nome';

  @override
  String get radioJoinPasswordLabel => 'Password (facoltativa)';

  @override
  String get radioJoinHint =>
      'Chi inserisce lo stesso nome e la stessa password è sulla stessa radio. Nessun server ne tiene un elenco.';

  @override
  String get radioJoinNameRequired => 'Inserisci un nome';

  @override
  String get radioJoinSubmit => 'Aggiungi';

  @override
  String get radioBlockedTooLong =>
      'Interrotto dopo un minuto di conversazione';

  @override
  String get radioBlockedCall => 'È in corso una chiamata';

  @override
  String get radioBlockedMicrophone => 'Nessun accesso al microfono';

  @override
  String get radioBlockedUnavailable =>
      'La radio non è disponibile su questo dispositivo';

  @override
  String get radioBlockedNoChannel => 'Prima scegli un gruppo o un contatto';

  @override
  String get radioTurnOff => 'Spegni la radio';

  @override
  String get radioPersonalCallsTitle => 'Ricevi chiamate personali';

  @override
  String get radioPersonalCallsHint =>
      'Quando la radio è spenta, un contatto che ti parla la sintonizza su di sé.';

  @override
  String get radioBackgroundHint =>
      'Con lo schermo spento la radio si sente solo se è attiva la modalità in background.';

  @override
  String get areaNearby => 'Chat di zona';

  @override
  String get areaLevelDistrict => 'Quartiere';

  @override
  String get areaLevelCity => 'Città';

  @override
  String get areaLevelRegion => 'Regione';

  @override
  String areaPresentCount(int count) {
    return '≈$count qui';
  }

  @override
  String get areaPresentMany => '50+ qui';

  @override
  String get areaBlockViaBluetooth => 'Il tuo isolato — via Bluetooth';

  @override
  String get areaOpenNearbyTab => 'Apri Vicini';

  @override
  String get areaLocating => 'Ricerca del tuo quartiere…';

  @override
  String get areaNoPlace =>
      'Ancora nessuna posizione. La chat di zona ha bisogno della tua posizione approssimativa mentre questa schermata è aperta.';

  @override
  String get areaLocationDenied =>
      'La posizione è disattivata per Cubechat. Consenti la posizione approssimativa nelle Impostazioni per vedere il tuo quartiere.';

  @override
  String get areaOffline => 'Nessuna connessione alla chat di zona';

  @override
  String get areaEmpty => 'Nessuno ha scritto qui nelle ultime 24 ore.';

  @override
  String get areaConsentTitle => 'La chat di zona è pubblica';

  @override
  String get areaConsentBody =>
      'I messaggi qui sono pubblici. Chiunque apra il tuo quartiere o la tua città li leggerà, e vengono conservati per 24 ore sul server di Cubechat. Scrivi con un nome temporaneo che cambia ogni poche ore; nessuno vede il tuo @nome o i tuoi contatti. Per sapere il tuo quartiere, Cubechat chiede la tua posizione approssimativa, solo mentre questa schermata è aperta.';

  @override
  String get areaConsentAllow => 'Continua';

  @override
  String get areaConsentDecline => 'Non ora';

  @override
  String areaDefaultName(String tag) {
    return 'Cube-$tag';
  }

  @override
  String areaYouAre(String name, int hours) {
    return 'Sei $name · nuovo nome tra $hours h';
  }

  @override
  String get areaNewName => 'Nuovo nome';

  @override
  String get areaSetName => 'Scegli un nome';

  @override
  String get areaNameHint =>
      'Solo per le poche ore di questo nome. Lascia vuoto per quello automatico.';

  @override
  String get areaNameSameWarning =>
      'Lo stesso nome ti rende riconoscibile tra quartieri diversi';

  @override
  String get areaShowPresence => 'Mostra che sono qui';

  @override
  String get areaPresenceOffHint =>
      'Attiva «Mostra che sono qui» per vedere quante persone ci sono vicino';

  @override
  String get areaReadOnly => 'Puoi scrivere solo dove ti trovi';

  @override
  String get areaComposerHint => 'Messaggio per tutti qui';

  @override
  String get areaSend => 'Invia';

  @override
  String get areaWaitALittle => 'Attendi un attimo';

  @override
  String areaFlood(int count) {
    return 'Flood ($count) · Mostra';
  }

  @override
  String get areaReply => 'Rispondi';

  @override
  String get areaHide => 'Nascondi';

  @override
  String get areaBlock => 'Blocca finché non cambia nome';

  @override
  String get areaBlocked => 'Bloccato finché non cambia nome';

  @override
  String get areaReport => 'Segnala';

  @override
  String get areaOpenLink => 'Apri link';

  @override
  String areaOpenLinkConfirm(String url) {
    return 'Aprire $url?';
  }

  @override
  String get areaOpen => 'Apri';

  @override
  String get areaReadHere => 'Leggi qui';

  @override
  String get areaReadHereHint =>
      'Solo lettura. Puoi scrivere solo dove ti trovi; il relay sa quale luogo stai leggendo.';

  @override
  String get areaNotes => 'Biglietti';

  @override
  String areaNotesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count biglietti',
      one: '$count biglietto',
      zero: 'Nessun biglietto',
    );
    return '$_temp0';
  }

  @override
  String get areaLeaveNote => 'Lascia un biglietto';

  @override
  String get areaNoteHint => 'Un breve biglietto per la tua città';

  @override
  String get areaNoteLifetime => 'Dura';

  @override
  String get areaNote1h => '1 h';

  @override
  String get areaNote24h => '24 h';

  @override
  String get areaNote7d => '7 giorni';

  @override
  String get areaPinToDistrict => 'Fissa a un quartiere';

  @override
  String get areaPinHint =>
      'Tocca la mappa all\'interno della tua città; il segnaposto si aggancia al suo quartiere.';

  @override
  String get areaPinOutside => 'Solo all\'interno della tua città';

  @override
  String get areaNoteDelete => 'Elimina il mio biglietto';

  @override
  String get areaNoNotes => 'Ancora nessun biglietto qui';

  @override
  String get areaNotesLimit => 'Tre biglietti al giorno';

  @override
  String get areaNoteLeft => 'Biglietto lasciato';

  @override
  String get areaNoteSend => 'Lascia';

  @override
  String get areaOwnNote => 'Il tuo biglietto';

  @override
  String get areaNotePinned => 'Fissato a un quartiere';

  @override
  String get areaHidden => 'Nascosto';

  @override
  String get areaPublicBadge => 'Pubblico · 24 h';

  @override
  String get areaSettingTitle => 'Chat di zona';

  @override
  String get areaSettingOnHint =>
      'Il pulsante Chat di zona sulla mappa: chat pubbliche del tuo quartiere e della tua città, con un nome temporaneo.';

  @override
  String get areaSettingOffHint =>
      'Disattivato: nessun pulsante sulla mappa, e la chat di zona non chiede mai la tua posizione né si connette.';

  @override
  String get wallpaperPhotoLocalOnly =>
      'Gli sfondi con foto per ora sono solo locali';

  @override
  String get wallpaperSavedNoRoute =>
      'Salvato qui. Al momento non c’è un percorso verso l’altra persona';

  @override
  String get wallpaperScopeTitle => 'Chi deve vedere questo sfondo?';

  @override
  String get wallpaperScopeChannel => 'Tutto il canale';

  @override
  String get wallpaperScopeBoth => 'Io e l’altra persona';

  @override
  String get wallpaperScopeLocal => 'Solo da me';

  @override
  String get wallpaperScopeSharedHint =>
      'Inviato come pacchetto di controllo cifrato';

  @override
  String get wallpaperScopePhotoHint =>
      'Per ora le foto restano solo su questo telefono';

  @override
  String get foldersCreate => 'Crea cartella';

  @override
  String get foldersYours => 'Le tue cartelle';

  @override
  String get foldersSmartFilters => 'Filtri intelligenti';

  @override
  String get foldersName => 'Nome cartella';

  @override
  String get foldersSave => 'Salva';

  @override
  String get foldersDeleteTitle => 'Eliminare la cartella?';

  @override
  String get foldersDelete => 'Elimina';

  @override
  String get foldersCreateAction => 'Crea';

  @override
  String get chatsArchiveHiddenToast =>
      'Archivio nascosto. Ripristinalo in «Aspetto».';

  @override
  String get chatsBulkPin => 'Fissa';

  @override
  String get chatsBulkMute => 'Silenzia';

  @override
  String get chatsUnarchive => 'Ripristina dall’archivio';

  @override
  String get chatsAddToFolder => 'Aggiungi a cartella';

  @override
  String get chatsMarkUnread => 'Segna come non letto';

  @override
  String get chatsClearHistory => 'Cancella cronologia chat';

  @override
  String get foldersNew => 'Nuova cartella';

  @override
  String get foldersNameHint => 'Amici';

  @override
  String get chatsNoIncoming => 'Nessun messaggio in arrivo';

  @override
  String get chatsMarkedUnread => 'Segnato come non letto';

  @override
  String get chatsClearHistoryTitle => 'Cancellare la cronologia della chat?';

  @override
  String get chatsClearHistoryBody =>
      'I messaggi verranno rimossi solo su questo dispositivo. Chat, contatto e preferiti restano.';

  @override
  String get chatsClearHistoryAction => 'Cancella';

  @override
  String get chatsHistoryCleared => 'Cronologia cancellata';

  @override
  String get savedTagMenuTag => 'Tag';

  @override
  String get savedTagRemove => 'Rimuovi tag';

  @override
  String get customizeArchiveRowTitle => 'Riga dell’archivio';

  @override
  String get customizeArchiveRowHint =>
      'Mostrala sopra l’elenco delle chat. Le chat archiviate ricevono comunque i messaggi.';

  @override
  String get mapLayerStandard => 'Standard';

  @override
  String get mapLayerStandardHint =>
      'Mappa stradale chiara — l’opzione più stabile';

  @override
  String get backupAutoTitle => 'Backup automatico';

  @override
  String get backupAutoHint =>
      'Una volta al giorno in un unico file nella cartella scelta; ogni copia sostituisce la precedente.';

  @override
  String backupAutoFolder(String name) {
    return 'Cartella: $name';
  }

  @override
  String backupAutoLast(String time) {
    return 'Ultima copia: $time';
  }

  @override
  String get backupAutoNever => 'Nessuna copia ancora';

  @override
  String get backupAutoRunning => 'Copia in corso…';

  @override
  String get backupAutoFolderLost =>
      'Cartella non raggiungibile. Sceglila di nuovo.';

  @override
  String get backupAutoFailed =>
      'L’ultima copia non è riuscita. Si riproverà più tardi.';

  @override
  String get backupAutoNow => 'Fai il backup ora';

  @override
  String get backupAutoChangeFolder => 'Cambia cartella';

  @override
  String get callYourMicOff => 'Il tuo microfono è spento';

  @override
  String callTheirCameraOff(String name) {
    return 'La fotocamera di $name è spenta';
  }
}
