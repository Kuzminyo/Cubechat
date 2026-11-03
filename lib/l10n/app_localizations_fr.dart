// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get callVoice => 'Appel vocal';

  @override
  String get callVideo => 'Appel vidéo';

  @override
  String get callIncomingVideo => 'Appel vidéo entrant';

  @override
  String get callCamera => 'Caméra';

  @override
  String get callFlipCamera => 'Retourner';

  @override
  String get contactProfileVideo => 'Vidéo';

  @override
  String get callPreparing => 'Préparation du micro…';

  @override
  String get callDialing => 'Appel…';

  @override
  String get callRinging => 'Sonnerie…';

  @override
  String get callConnecting => 'Connexion…';

  @override
  String get callMicrophoneRequired =>
      'Autorisez l’accès au micro dans les réglages système pour passer des appels.';

  @override
  String get callMicrophoneWindows =>
      'Windows n’a pas donné le micro à CubeChat. Activez Paramètres → Confidentialité et sécurité → Microphone → « Autoriser les applications de bureau à accéder à votre microphone ».';

  @override
  String get callElsewhere =>
      'Un appel est déjà en cours sur un autre appareil de ce compte.';

  @override
  String get callRelayUnavailable =>
      'Serveur d’appels indisponible. Réessayez plus tard.';

  @override
  String get callBusy => 'Occupé';

  @override
  String get callNoAnswer => 'Pas de réponse';

  @override
  String get callFailed => 'Impossible d’établir l’appel';

  @override
  String get callDeclined => 'Appel refusé';

  @override
  String get callEnded => 'Appel terminé';

  @override
  String get callMicrophone => 'Micro';

  @override
  String get callSpeaker => 'Haut-parleur';

  @override
  String get callAnswer => 'Répondre';

  @override
  String get callDecline => 'Refuser';

  @override
  String get callEnd => 'Raccrocher';

  @override
  String get callClose => 'Fermer';

  @override
  String get callMinimize => 'Réduire';

  @override
  String get callAudioOutput => 'Son de l’appel';

  @override
  String get callRoutePhone => 'Téléphone';

  @override
  String get callRouteBluetooth => 'Bluetooth';

  @override
  String get callRouteHeadphones => 'Écouteurs';

  @override
  String get callFullScreenTitle => 'Appels sur l’écran verrouillé';

  @override
  String get callFullScreenBody =>
      'Autorisez l’affichage des appels entrants sur l’écran verrouillé pour pouvoir répondre sans déverrouiller.';

  @override
  String get callFullScreenXiaomi =>
      'Xiaomi, Redmi et Poco ne laissent pas les applis l’activer elles-mêmes : activez « Afficher sur l’écran de verrouillage » dans Autres autorisations.';

  @override
  String get circleMessage => 'Message vidéo';

  @override
  String get appName => 'Cubechat';

  @override
  String get navChats => 'Discussions';

  @override
  String get navPeers => 'Autour';

  @override
  String get navProfile => 'Profil';

  @override
  String get navContacts => 'Contacts';

  @override
  String get navMap => 'Carte';

  @override
  String get mapTitle => 'Carte';

  @override
  String get mapFriendsTitle => 'Personnes sur la carte';

  @override
  String get mapFriendsHint => 'Seuls ces contacts reçoivent votre position';

  @override
  String mapClusterTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count personnes ici',
      one: '$count personne ici',
    );
    return '$_temp0';
  }

  @override
  String get mapClusterHint =>
      'Touchez une personne pour centrer la carte sur elle';

  @override
  String get mapNorthUp => 'Orienter vers le nord';

  @override
  String get mapLayerTitle => 'Style de carte';

  @override
  String get mapLayerHint => 'Le fond sous les repères';

  @override
  String get mapLayerDark => 'Sombre';

  @override
  String get mapLayerDarkHint =>
      'Rues sans libellés — le fond le plus discret sous les repères';

  @override
  String get mapLayerSatellite => 'Satellite';

  @override
  String get mapLayerSatelliteHint =>
      'Vue aérienne : quel immeuble, quelle cour';

  @override
  String get mapLayerTerrain => 'Relief';

  @override
  String get mapLayerTerrainHint =>
      'Courbes de niveau et relief, pour les collines et les sentiers';

  @override
  String get mapFriendsEmpty =>
      'Personne ne partage encore la carte avec vous.';

  @override
  String get mapFriendsEmptyHint =>
      'Invitez un contact : il apparaîtra ici dès qu’il aura accepté.';

  @override
  String get mapFriendsInvite => 'Inviter';

  @override
  String get mapFriendsRemove => 'Retirer de la carte';

  @override
  String mapFriendsRemoved(String name) {
    return '$name ne partage plus la carte avec vous';
  }

  @override
  String get mapFriendsLive => 'Sur la carte';

  @override
  String get mapFriendsIdle => 'Pas de position pour l’instant';

  @override
  String get mapInviteTitle => 'Inviter sur la carte';

  @override
  String get mapInviteHint => 'Choisissez une ou plusieurs discussions';

  @override
  String get mapInviteEmpty => 'Aucune discussion à inviter pour l’instant.';

  @override
  String mapInviteAction(int count) {
    return 'Envoyer ($count)';
  }

  @override
  String get mapInviteMessage =>
      'Invitation à la carte Cubechat. Partagez votre position dans cette discussion pour apparaître sur la carte.';

  @override
  String mapInviteSent(int count) {
    return 'Invitations envoyées : $count';
  }

  @override
  String get mapInviteFailed => 'Impossible d’envoyer les invitations';

  @override
  String mapPeopleVisible(int count) {
    return 'Positions partagées : $count';
  }

  @override
  String get mapCenterMe => 'Centrer sur moi';

  @override
  String get mapNoSharedLocations => 'Aucune position partagée';

  @override
  String get mapNoSharedLocationsHint =>
      'Un contact apparaît ici après avoir envoyé sa position dans une discussion.';

  @override
  String get mapWebHintTitle => 'Connexions à proximité';

  @override
  String get mapWebHint =>
      'Les lignes indiquent la proximité, pas le trajet des messages.';

  @override
  String get mapOpenProfile => 'Profil';

  @override
  String get mapLocationPrivacyOff => 'Votre position est masquée';

  @override
  String get mapLocationPrivacyOffHint =>
      'Activez « Me montrer sur la carte » dans Confidentialité pour afficher votre repère.';

  @override
  String get mapYouOnMap => 'Votre position est visible sur cet appareil';

  @override
  String get locationSharingDisabled =>
      'Activez d’abord « Me montrer sur la carte » dans Confidentialité.';

  @override
  String get mapLocationDenied => 'L’accès à la localisation est désactivé';

  @override
  String get mapLocationServiceOff =>
      'Activez la localisation pour vous afficher';

  @override
  String get mapLocationUnavailable =>
      'Impossible de déterminer votre position';

  @override
  String get mapDistanceUnknown => 'Distance inconnue';

  @override
  String mapDistanceMetres(int metres) {
    return 'à $metres m';
  }

  @override
  String mapDistanceKilometres(String kilometres) {
    return 'à $kilometres km';
  }

  @override
  String get mapUpdatedNow => 'partagée à l’instant';

  @override
  String mapUpdatedMinutes(int minutes) {
    return 'partagée il y a $minutes min';
  }

  @override
  String mapUpdatedHours(int hours) {
    return 'partagée il y a $hours h';
  }

  @override
  String get contactsTitle => 'Contacts';

  @override
  String get contactsSubtitle => 'Tous ceux à qui vous avez écrit';

  @override
  String get contactsSearchHint => 'Rechercher des contacts…';

  @override
  String get contactsEmptyTitle => 'Aucun contact pour l’instant';

  @override
  String get contactsEmptyHint =>
      'Commencez une conversation et la personne apparaîtra ici.';

  @override
  String get contactsSearchEmpty => 'Aucun contact trouvé';

  @override
  String get contactsTabContacts => 'Contacts';

  @override
  String get contactsTabCalls => 'Appels';

  @override
  String get callsFilterAll => 'Tous';

  @override
  String get callsFilterMissed => 'Manqués';

  @override
  String get callsEmptyTitle => 'Aucun appel pour l’instant';

  @override
  String get callsEmptyHint =>
      'Les appels entrants, sortants et manqués apparaîtront ici.';

  @override
  String get callsMissedEmpty => 'Aucun appel manqué';

  @override
  String get callsCallBack => 'Appeler';

  @override
  String get contactProfileChat => 'Discuter';

  @override
  String get contactProfileCall => 'Appeler';

  @override
  String get contactProfileRadio => 'Talkie';

  @override
  String get contactProfileSecurity => 'Sécurité';

  @override
  String get contactProfileActions => 'Actions du contact';

  @override
  String get contactProfileVerify => 'Vérifier';

  @override
  String get contactProfileCopyId => 'Copier l’ID du contact';

  @override
  String get contactProfileIdCopied => 'ID du contact copié';

  @override
  String get contactProfileId => 'ID du contact';

  @override
  String get contactProfileVerifyHint =>
      'Comparez les empreintes de chiffrement pour confirmer l’identité de cette personne.';

  @override
  String get chatsTitle => 'Discussions';

  @override
  String get chatsSubtitle => 'Mesh · chiffré de bout en bout';

  @override
  String get chatsEmptyTitle => 'Aucune conversation pour l’instant';

  @override
  String get chatsEmptyHint =>
      'Ouvrez un pair depuis l’onglet À proximité pour commencer à discuter.';

  @override
  String get chatsFilterAll => 'Toutes';

  @override
  String get chatsFilterUnread => 'Non lues';

  @override
  String get chatsFilterMesh => 'Mesh';

  @override
  String get chatsFilterFavorites => 'Favoris';

  @override
  String get chatsFolderDirect => 'Privées';

  @override
  String get chatsFolderChannels => 'Canaux';

  @override
  String get chatsFolderOnline => 'Joignables';

  @override
  String get chatsFoldersTitle => 'Dossiers';

  @override
  String get chatsFoldersHint =>
      'Les dossiers sont des vues de cette liste, pas des endroits où l’on déplace les discussions. Activez ceux que vous voulez au-dessus des discussions.';

  @override
  String get chatsSearchHint => 'Rechercher des discussions…';

  @override
  String get chatsStatusViaMesh => 'via mesh';

  @override
  String get chatsStatusOffline => 'hors ligne';

  @override
  String get peerKeyRotated => 'clé modifiée — revérifiez';

  @override
  String get peersTitle => 'À proximité';

  @override
  String get peersSubtitle => 'Appareils à portée Bluetooth';

  @override
  String get peersEmpty => 'Recherche d’appareils…';

  @override
  String peersHopsOne(int n) {
    return 'à $n saut';
  }

  @override
  String peersHopsOther(int n) {
    return 'à $n sauts';
  }

  @override
  String get blePermissionTitle => 'Autorisation Bluetooth requise';

  @override
  String get blePermissionHint =>
      'Cubechat utilise le Bluetooth pour trouver des appareils et envoyer des messages — sans Internet.';

  @override
  String get blePermissionGrant => 'Autoriser';

  @override
  String get blePermissionOpenSettings => 'Ouvrir les réglages';

  @override
  String get blePermissionDeniedHint =>
      'L’autorisation a été refusée. Ouvrez les réglages pour autoriser l’accès au Bluetooth.';

  @override
  String get bleAdapterOffTitle => 'Le Bluetooth est désactivé';

  @override
  String get bleAdapterOffHint =>
      'Activez le Bluetooth pour voir les appareils à proximité.';

  @override
  String get bleUnsupportedTitle => 'Bluetooth LE indisponible';

  @override
  String get bleUnsupportedHint =>
      'Cet appareil ou cette plateforme ne prend pas en charge le Bluetooth Low Energy. Essayez sur un téléphone.';

  @override
  String get bleScanning => 'Recherche…';

  @override
  String get bleRetry => 'Réessayer';

  @override
  String get bleEnable => 'Activer';

  @override
  String get bleConnectFailed =>
      'Connexion impossible. L’appareil est peut-être hors de portée, ou son adresse Bluetooth a changé.';

  @override
  String get bleSignal => 'Signal';

  @override
  String get bleConnect => 'Connecter';

  @override
  String get bleConnected => 'Connecté';

  @override
  String get bleVerified => 'Vérifié';

  @override
  String get editorAdjustBrightness => 'Luminosité';

  @override
  String get editorAdjustContrast => 'Contraste';

  @override
  String get editorAdjustSaturation => 'Saturation';

  @override
  String get editorToolCrop => 'Recadrer';

  @override
  String get editorToolDraw => 'Dessin';

  @override
  String get editorToolAdjust => 'Réglages';

  @override
  String get editorTabSticker => 'Sticker';

  @override
  String get editorTabText => 'Texte';

  @override
  String get editorPenPen => 'Stylo';

  @override
  String get editorPenMarker => 'Surligneur';

  @override
  String get editorPenNeon => 'Néon';

  @override
  String get editorPenArrow => 'Flèche';

  @override
  String get editorPenBlur => 'Flou';

  @override
  String get editorPenEraser => 'Gomme';

  @override
  String get editorLevel => 'Redresser';

  @override
  String get editorTextHint => 'Texte sur la photo';

  @override
  String get editorCropFree => 'Libre';

  @override
  String get editorRemove => 'Retirer';

  @override
  String get notificationUnknownSender => 'Nouveau message';

  @override
  String get bleUnknownPeer => 'Appareil non identifié';

  @override
  String get bleBroadcasting => 'En diffusion';

  @override
  String bleConnectedCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n appareils centraux connectés',
      one: '1 appareil central connecté',
      zero: 'Aucun appareil central',
    );
    return '$_temp0';
  }

  @override
  String get verifyTitle => 'Vérifier le contact';

  @override
  String get verifyIntro =>
      'Comparez ces deux empreintes avec votre contact en personne ou lors d’un appel vocal. Si elles correspondent des deux côtés, vous avez confirmé que la négociation Noise n’a pas été falsifiée.';

  @override
  String get verifyMine => 'VOTRE EMPREINTE';

  @override
  String verifyTheirs(String name) {
    return 'EMPREINTE DE $name';
  }

  @override
  String get verifyMarkAsVerified => 'Marquer comme vérifié';

  @override
  String get verifyAlreadyDone => 'Ce contact est vérifié.';

  @override
  String get verifyRevoke => 'Révoquer';

  @override
  String verifyDoneSnack(String name) {
    return '$name marqué comme vérifié';
  }

  @override
  String get chatInputHint => 'Message';

  @override
  String get chatSend => 'Envoyer';

  @override
  String get chatToday => 'Aujourd’hui';

  @override
  String get chatYesterday => 'Hier';

  @override
  String get chatDelivered => 'Distribué';

  @override
  String get chatRead => 'Lu';

  @override
  String get chatSending => 'Envoi';

  @override
  String get chatWaitingForConnection => 'En attente de connexion';

  @override
  String sendQueueCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count messages en attente de connexion',
      one: '1 message en attente de connexion',
    );
    return '$_temp0';
  }

  @override
  String sendQueueSlowNetwork(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Réseau lent — envoi de $count messages',
      one: 'Réseau lent — envoi de 1 message',
    );
    return '$_temp0';
  }

  @override
  String get sendQueueTitle => 'En attente d’envoi';

  @override
  String get sendQueueHint =>
      'Ils partiront d’eux-mêmes dès qu’une voie sera disponible — Bluetooth à proximité ou Internet. Rien à faire.';

  @override
  String get sendQueueRetry => 'Réessayer';

  @override
  String get sendQueueCancel => 'Annuler l’envoi';

  @override
  String get sendQueueCancelled => 'Non envoyé — annulé';

  @override
  String get sendQueueTooLate =>
      'Trop tard pour annuler : le message est déjà parti';

  @override
  String get chatEncryptedNotice =>
      'Les messages sont chiffrés de bout en bout avec le protocole Noise.';

  @override
  String get chatSessionHandshaking => 'Établissement du canal sécurisé…';

  @override
  String get chatSessionEstablished => 'Sécurisé · Noise XX';

  @override
  String get chatSessionFailed => 'Échec de la connexion';

  @override
  String get presenceOnline => 'en ligne';

  @override
  String get presenceOffline => 'hors ligne';

  @override
  String get chatSessionFingerprintPending =>
      'L’empreinte apparaîtra une fois la négociation terminée.';

  @override
  String get chatEmptyEstablished =>
      'Le canal sécurisé est prêt. Envoyez un message pour commencer la conversation.';

  @override
  String get chatEmptyHandshaking =>
      'En attente de la fin de la négociation par l’autre côté…';

  @override
  String get chatEmptyTitle => 'Aucun message pour l’instant';

  @override
  String get chatEmptyGreetHint =>
      'Envoyez un message ou touchez Kubi pour dire bonjour.';

  @override
  String get profileTitle => 'Profil';

  @override
  String get profileNickname => 'Pseudo';

  @override
  String get profileNicknameEditTitle => 'Choisissez votre pseudo';

  @override
  String get profileNicknameHint =>
      'Comment les autres vous voient sur le mesh';

  @override
  String get profileNicknameSave => 'Enregistrer';

  @override
  String get profileFingerprint => 'Empreinte de la clé publique';

  @override
  String get profileLanguage => 'Langue';

  @override
  String get profileLanguageEn => 'Anglais';

  @override
  String get profileLanguageUk => 'Ukrainien';

  @override
  String get profileTransport => 'Transport';

  @override
  String get profileTransportMesh => 'Mesh Bluetooth';

  @override
  String get profileBackground => 'Rester joignable en arrière-plan';

  @override
  String get profileBackgroundSubtitle =>
      'Continuer à recevoir des messages quand l’appli est fermée';

  @override
  String get profileBatteryExempt => 'Désactiver l’optimisation de la batterie';

  @override
  String get profileAbout => 'À propos';

  @override
  String profileVersion(String v) {
    return 'Version $v';
  }

  @override
  String get rotateKeysTitle => 'Changer les clés du compte';

  @override
  String get rotateKeysHint =>
      'Si un appareil lié à votre compte a été perdu ou volé';

  @override
  String get rotateKeysConfirmTitle => 'Changer les clés du compte ?';

  @override
  String get rotateKeysConfirmBody =>
      'Vos contacts reçoivent vos nouvelles clés et conservent vos discussions, mais chacun d’eux devra revérifier vos clés. Tous les autres appareils de votre compte sont déconnectés ; reliez à nouveau ceux que vous gardez depuis ce téléphone. Les contacts sur une ancienne version de CubeChat ne pourront plus vous joindre avant de faire la mise à jour. Les canaux conservent leurs clés.';

  @override
  String get rotateKeysConfirmAction => 'Changer les clés';

  @override
  String get rotateKeysWorking => 'Changement des clés…';

  @override
  String rotateKeysDone(int sent, int total) {
    return 'Nouvelles clés. $sent contacts sur $total prévenus';
  }

  @override
  String get rotateKeysSlow =>
      'Nouvelles clés. Tous les contacts n’ont pas confirmé à temps ; les relais les conservent pour eux';

  @override
  String get profileEmergencyWipe => 'Effacement d’urgence';

  @override
  String get profileEmergencyWipeConfirm => 'Tout effacer ?';

  @override
  String get profileEmergencyWipeConfirmHint =>
      'Votre identité, votre liste de contacts et l’historique des conversations seront supprimés. Action irréversible.';

  @override
  String get profileEmergencyWipeAction => 'Effacer';

  @override
  String get cancel => 'Annuler';

  @override
  String get copy => 'Copier';

  @override
  String get copied => 'Copié';

  @override
  String get channelsNewTitle => 'Nouveau canal';

  @override
  String get channelsNewTooltip => 'Nouveau canal';

  @override
  String get channelNameLabel => 'Nom du canal';

  @override
  String get channelPasswordLabel => 'Mot de passe (facultatif)';

  @override
  String get channelJoinAction => 'Rejoindre';

  @override
  String get channelNameHint =>
      'Toute personne qui saisit le même nom et le même mot de passe arrive dans le même salon. Aucun serveur n’en conserve la liste.';

  @override
  String get channelPasswordHint =>
      'Le mot de passe est la clé. Sans lui, le salon est ouvert à toute personne à proximité qui connaît son nom.';

  @override
  String get channelSubtitle => 'Canal de groupe · clé partagée';

  @override
  String get channelMute => 'Couper le son';

  @override
  String get channelUnmute => 'Rétablir le son';

  @override
  String channelMutedUntil(String time) {
    return 'Son coupé jusqu’à $time';
  }

  @override
  String get channelMuteFor => 'Couper le son pendant…';

  @override
  String channelMuteMinutes(int minutes) {
    return '$minutes minutes';
  }

  @override
  String channelMuteHours(int hours) {
    return '$hours heures';
  }

  @override
  String channelMuteDays(int days) {
    return '$days jours';
  }

  @override
  String get channelMuteForever => 'Jusqu’à ce que je le réactive';

  @override
  String get channelCommunity => 'Commentaires';

  @override
  String get channelCommunityOpen => 'Ouvrir la discussion';

  @override
  String channelCommunitySubtitle(String channel) {
    return 'Discussion de $channel';
  }

  @override
  String get channelBackToChannel => 'Retour au canal';

  @override
  String get channelMemberActions => 'Membre';

  @override
  String get channelRemoveMember => 'Retirer du canal';

  @override
  String get channelRemoveMemberHint =>
      'Ses publications ne sont plus acceptées ici. Rien ne l’empêche de revenir avec le nom — une clé partagée est la seule forme d’adhésion qui existe.';

  @override
  String get channelMuteMember => 'Rendre muet pendant…';

  @override
  String get channelUnmuteMember => 'Autoriser à publier';

  @override
  String channelMemberRemoved(String name) {
    return '$name a été retiré';
  }

  @override
  String channelMemberMuted(String name) {
    return '$name a été rendu muet';
  }

  @override
  String channelMemberCleared(String name) {
    return '$name peut de nouveau publier';
  }

  @override
  String get channelMemberMutedNote => 'Muet';

  @override
  String get channelShareHistory => 'Partager l’historique';

  @override
  String get channelShareHistoryHint =>
      'Remet en diffusion les dernières publications de ce salon pour que ceux qui sont arrivés plus tard puissent les voir. Ceux qui étaient déjà là ne reçoivent rien de nouveau.';

  @override
  String channelHistoryShared(int count) {
    return 'Publications proposées : $count';
  }

  @override
  String get channelHistoryNothing => 'Rien à partager pour l’instant';

  @override
  String get channelHistoryAuto => 'Donner l’historique aux nouveaux';

  @override
  String get channelHistoryAutoHint =>
      'Quand quelqu’un de nouveau arrive dans le salon, les publications récentes lui sont envoyées automatiquement. Texte uniquement pour l’instant — les photos sont envoyées en flux de fragments et ne peuvent pas être renvoyées sans les dupliquer pour tout le monde.';

  @override
  String get channelPostComments => 'Commentaires';

  @override
  String get channelNoComments => 'Personne n’a encore commenté';

  @override
  String get channelCommentHint => 'Commenter';

  @override
  String get channelMuteCustom => 'Pendant combien de temps ?';

  @override
  String get channelMuteCustomHint => 'Heures';

  @override
  String get chatPinnedManage => 'Épinglés';

  @override
  String get chatPeekOpen => 'Ouvrir la discussion';

  @override
  String get chatPeekPin => 'Épingler';

  @override
  String get chatPeekUnpin => 'Désépingler';

  @override
  String get chatPeekUnmute => 'Rétablir le son';

  @override
  String get chatPeekMarkRead => 'Marquer comme lu';

  @override
  String get chatDeleteForMeHint =>
      'Supprimé de ce téléphone et désépinglé. L’autre personne garde sa copie.';

  @override
  String get pushWakeTitle => 'Réveiller ce téléphone';

  @override
  String get pushWakeHint =>
      'Un petit serveur surveille les relais pour votre adresse et réveille ce téléphone quand quelque chose arrive, pour que l’appli vous prévienne même fermée. Il ne voit jamais de message ni de clé — seulement que votre adresse a reçu quelque chose, et quand. Le relais le sait déjà ; c’est un deuxième endroit qui le sait.';

  @override
  String get pushWakeDeniedTitle => 'Les notifications sont désactivées';

  @override
  String get pushWakeDeniedHint =>
      'Le système a reçu un refus une fois et ne redemandera plus, donc cela ne peut être réactivé que dans Réglages — cubechat, puis Notifications. Revenez ici ensuite.';

  @override
  String get pushWakeRefused => 'Les notifications n’ont pas été autorisées';

  @override
  String get privacyForwardLinkTitle =>
      'Lien vers le profil dans les transferts';

  @override
  String get privacyForwardLinkHint =>
      'Quand quelqu’un transfère l’un de vos messages, la ligne au-dessus peut ouvrir votre profil. Désactivé, on voit votre nom sans rien à toucher. C’est une demande faite à leur appli, que celle-ci ne peut pas imposer.';

  @override
  String get privacyShareSheetTitle => 'Discussions dans le menu Partager';

  @override
  String get privacyShareSheetOnHint =>
      'Les noms de vos quatre dernières discussions sont transmis à Android pour que vous puissiez leur envoyer du contenu depuis n’importe quelle appli. Le verrouillage de l’appli ne les masque pas.';

  @override
  String get privacyShareSheetOffHint =>
      'Rien n’est transmis à Android. En partageant vers CubeChat, vous choisissez la discussion dans la liste.';

  @override
  String get privacyCallsTitle => 'Accepter les appels';

  @override
  String get privacyCallsOnHint =>
      'Vos contacts peuvent vous appeler. Pour refuser une personne, ouvrez son profil.';

  @override
  String get privacyCallsOffHint =>
      'Personne ne peut vous appeler, sauf ceux que vous autorisez dans leur profil. Un appel refusé leur apparaît comme occupé.';

  @override
  String get chatsStatusChannel => 'canal';

  @override
  String get channelInviteTitle => 'Ajouter des personnes';

  @override
  String get channelInviteAction => 'Inviter';

  @override
  String get channelInviteEmpty =>
      'Aucun appareil connu pour l’instant. Rencontrez d’abord quelqu’un dans l’onglet À proximité.';

  @override
  String get channelInviteSent => 'Invitations envoyées';

  @override
  String get channelInviteNoneSent =>
      'Personne n’a pu être joint pour le moment';

  @override
  String get channelNameTooLong => 'Ce nom de canal est trop long';

  @override
  String get chatsActionFavorite => 'Ajouter aux favoris';

  @override
  String get chatsActionUnfavorite => 'Retirer des favoris';

  @override
  String get chatsActionDelete => 'Supprimer la discussion';

  @override
  String get chatsDeleteTitle => 'Supprimer cette discussion ?';

  @override
  String chatsDeleteManyHint(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Efface $count conversations. Les contacts restent, vous pourrez donc leur réécrire sans échanger de codes.',
      one:
          'Efface $count conversation. Le contact reste, vous pourrez donc lui réécrire sans échanger de codes.',
    );
    return '$_temp0';
  }

  @override
  String get chatsDeletedToast => 'Discussion supprimée.';

  @override
  String chatsDeletedManyToast(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count discussions supprimées.',
      one: '$count discussion supprimée.',
    );
    return '$_temp0';
  }

  @override
  String get undo => 'Annuler';

  @override
  String get chatsDeletePeerHint =>
      'Efface la conversation. Le contact reste, vous pourrez donc lui réécrire sans échanger de codes.';

  @override
  String get chatsDeleteChannelHint =>
      'Quitte le canal et supprime son historique. Il vous faudra de nouveau la clé pour le rejoindre.';

  @override
  String get chatsDeleteForThemToo => 'Supprimer aussi chez lui';

  @override
  String get chatsDeleteForThemHint =>
      'Demande à son appli d’effacer aussi toute la conversation, y compris ce qu’il a écrit. Dans un canal, seuls vos propres messages sont retirés.';

  @override
  String get chatEditAction => 'Modifier';

  @override
  String get chatEditTitle => 'Modifier le message';

  @override
  String get chatEditSave => 'Enregistrer';

  @override
  String get chatEdited => 'modifié';

  @override
  String get chatDeleteAction => 'Supprimer';

  @override
  String get chatDeleteTitle => 'Supprimer le message ?';

  @override
  String get chatDeleteForMe => 'Supprimer pour moi';

  @override
  String get chatDeleteForEveryone => 'Supprimer pour tous';

  @override
  String get chatPinTitle => 'Épingler le message ?';

  @override
  String get chatPinForBoth => 'Épingler pour nous deux';

  @override
  String get chatPinForMe => 'Épingler pour moi seul';

  @override
  String get chatReplyAction => 'Répondre';

  @override
  String chatReplyingTo(String name) {
    return 'Réponse à $name';
  }

  @override
  String get chatReplyYou => 'vous-même';

  @override
  String get chatCopyAction => 'Copier';

  @override
  String get chatCopied => 'Copié';

  @override
  String get chatForwardAction => 'Transférer';

  @override
  String get chatForwardTitle => 'Transférer à';

  @override
  String get shareIntoTitle => 'Envoyer à';

  @override
  String get shareNearbyAirDrop => 'À proximité via AirDrop';

  @override
  String get shareNearbyAirDropHint =>
      'Sans Internet — aux personnes près de vous';

  @override
  String get shareSent => 'Envoyé';

  @override
  String get shareFailed => 'Une partie n’a pas pu être envoyée';

  @override
  String get chatForwardEmpty => 'Aucune autre discussion pour l’instant';

  @override
  String chatForwardSendCount(int count) {
    return 'Envoyer ($count)';
  }

  @override
  String chatForwardSentCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Transféré à $count discussions',
      one: 'Transféré à une discussion',
    );
    return '$_temp0';
  }

  @override
  String chatForwardSent(String name) {
    return 'Transféré à $name';
  }

  @override
  String chatSentAt(String time) {
    return 'Envoyé $time';
  }

  @override
  String chatReadAt(String time) {
    return 'Lu $time';
  }

  @override
  String get chatPinAction => 'Épingler';

  @override
  String get chatUnpinAction => 'Désépingler';

  @override
  String chatPinnedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count messages épinglés',
      one: '1 message épinglé',
      zero: 'Aucun message épinglé',
    );
    return '$_temp0';
  }

  @override
  String get chatNoPins => 'Rien n’est épinglé ici';

  @override
  String get chatUnpinAll => 'Désépingler tous les messages';

  @override
  String get chatShowAllPins => 'Tous les messages épinglés';

  @override
  String get chatUnpinConfirm => 'Désépingler ce message ?';

  @override
  String get chatUnpinConfirmHint =>
      'Il ne sera plus épinglé pour personne dans cette discussion.';

  @override
  String get chatPinnedTitle => 'Message épinglé';

  @override
  String get chatPinnedGone => 'Ce message n’est plus dans cette discussion';

  @override
  String get peerBlock => 'Bloquer';

  @override
  String get peerUnblock => 'Débloquer';

  @override
  String get peerMute => 'Couper le son';

  @override
  String get peerUnmute => 'Rétablir le son';

  @override
  String get peerBlockedNote => 'Bloqué — ses messages sont ignorés.';

  @override
  String get relaysTitle => 'Secours via Internet';

  @override
  String get relaysCardTitle => 'Joindre les contacts via Internet';

  @override
  String get relaysCardSubtitle =>
      'Quand le Bluetooth ne peut pas livrer, envoyer via les relais Nostr';

  @override
  String get relaysExplainer =>
      'Les messages restent chiffrés de bout en bout — un relais ne transporte que la même trame scellée que le Bluetooth. Il apprend en revanche quelles deux clés communiquent, et quand. Désactivé par défaut.';

  @override
  String get relaysMyAddress => 'Votre adresse de relais';

  @override
  String get relaysCopied => 'Copié';

  @override
  String get circleLensTitle => 'Caméra avant pour les messages vidéo';

  @override
  String get circleLensFrontHint =>
      'Les messages vidéo ronds sont filmés avec la caméra tournée vers vous.';

  @override
  String get circleLensBackHint =>
      'Les messages vidéo ronds sont filmés avec la caméra arrière, pour montrer ce que vous regardez.';

  @override
  String get channelCloseTitle => 'Fermer ce salon pour tous';

  @override
  String get channelCloseSubtitle =>
      'Le supprime du téléphone de chaque membre. Vous seul pouvez le faire.';

  @override
  String get channelCloseConfirm =>
      'Le salon, ses messages et ses membres disparaissent de chaque téléphone qui l’a. Personne n’est exclu : la clé vient du nom, donc quiconque s’en souvient peut rouvrir un salon vide.';

  @override
  String get channelCloseAction => 'Fermer le salon';

  @override
  String get circleHint =>
      'Relâchez pour envoyer · glissez à gauche pour annuler';

  @override
  String get circleHintLocked => 'Touchez Envoyer quand vous avez fini';

  @override
  String get circleNeedsCamera =>
      'Les messages vidéo nécessitent la caméra et le micro';

  @override
  String get circleFailed => 'Impossible d’enregistrer ce message vidéo';

  @override
  String get relaysListLabel => 'Relais';

  @override
  String get relaysLaneMedia => 'Relais médias';

  @override
  String get relaysLaneMediaNote =>
      'Les photos, fichiers et vidéos passent par ceux-ci, pour qu’un transfert ne ralentisse pas la conversation.';

  @override
  String get relaysLaneLocation => 'Relais de position';

  @override
  String get relaysLaneLocationNote =>
      'Les balises de la carte passent par ceux-ci, séparément de tout le reste.';

  @override
  String get relaysAdd => 'Ajouter un relais';

  @override
  String get relaysAddHint => 'wss://relay.example.com';

  @override
  String get relaysInvalidUrl => 'Saisissez une adresse wss:// ou ws://';

  @override
  String get relaysRemove => 'Supprimer';

  @override
  String get relaysStateConnected => 'Connecté';

  @override
  String get relaysStateConnecting => 'Connexion…';

  @override
  String get relaysStateFailed => 'Injoignable';

  @override
  String get relaysStateIdle => 'Désactivé';

  @override
  String get relaysEmpty =>
      'Aucun relais configuré — le secours reste désactivé.';

  @override
  String get contactTitle => 'Carte de contact';

  @override
  String get contactMineLabel => 'Votre carte';

  @override
  String get contactMineExplainer =>
      'Envoyez-la à quelqu’un hors de portée Bluetooth. Elle contient vos clés et votre adresse de relais — de quoi démarrer avec vous une discussion chiffrée via Internet.';

  @override
  String get contactCopy => 'Copier';

  @override
  String get contactShare => 'Partager';

  @override
  String get contactCopied => 'Carte copiée';

  @override
  String get contactShareSubject => 'Ma carte de contact cubechat';

  @override
  String get contactAddLabel => 'Ajouter quelqu’un';

  @override
  String get contactAddHint => 'Collez une carte de contact';

  @override
  String get contactAddAction => 'Ajouter';

  @override
  String get contactPaste => 'Coller';

  @override
  String contactAdded(String name) {
    return '$name ajouté';
  }

  @override
  String get contactInvalid => 'Ce n’est pas une carte de contact valide';

  @override
  String get contactOwnCard => 'C’est votre propre carte';

  @override
  String get contactUnverified =>
      'Un contact ajouté ainsi n’est pas vérifié au départ. N’importe qui peut créer une carte avec n’importe quel nom : comparez les empreintes en personne ou lors d’un appel avant de faire confiance à l’identité.';

  @override
  String get contactRelayOff =>
      'Le secours via Internet est désactivé : une carte ne peut encore joindre personne.';

  @override
  String get contactRelayEnable => 'Activer';

  @override
  String get profileContactCard => 'Carte de contact';

  @override
  String get chatsAddContactTooltip => 'Ajouter un contact par carte';

  @override
  String get chatsMenuTooltip => 'Plus';

  @override
  String get chatsMenuAddContact => 'Ajouter un contact';

  @override
  String get chatsMenuNewChannel => 'Nouveau canal';

  @override
  String get profileDiscoverable => 'Visible à proximité';

  @override
  String get profileDiscoverableOnHint =>
      'Toute personne à portée peut vous trouver';

  @override
  String get profileDiscoverableOffHint =>
      'Seuls vos contacts peuvent vous joindre';

  @override
  String get profileDiscoverableExplainer =>
      'Activé, votre annonce est diffusée en clair pour que des inconnus puissent vous rencontrer en s’approchant — et toute personne à l’écoute enregistre votre clé et votre nom. Désactivé, les mêmes données ne vont qu’à vos contacts existants, scellées, et vos identifiants de routage restent impossibles à relier. Les nouvelles personnes ont alors besoin d’une carte de contact.';

  @override
  String get voiceHoldHint => 'Maintenez pour enregistrer un message vocal';

  @override
  String get voiceTrimPlay => 'Lire';

  @override
  String get voiceTrimPause => 'Pause';

  @override
  String get voiceTrimDiscard => 'Supprimer l’enregistrement';

  @override
  String voiceTrimSelection(String duration) {
    return 'Envoi de $duration';
  }

  @override
  String get profileLastSeen => 'Partager « Vu à »';

  @override
  String get profileLastSeenOnHint =>
      'Vos contacts voient quand vous êtes dans l’appli';

  @override
  String get profileLastSeenOffHint =>
      'Personne ne voit votre heure, et vous ne voyez celle de personne : seulement qui est en ligne';

  @override
  String get profileMapLocation => 'Me montrer sur la carte';

  @override
  String get profileMapLocationOnHint =>
      'La position peut être partagée manuellement et votre repère est affiché sur la carte';

  @override
  String get profileMapLocationOffHint =>
      'L’appli ne demande pas la position et votre repère reste masqué';

  @override
  String get desktopAutostartTitle => 'Lancer avec Windows';

  @override
  String get desktopAutostartHint =>
      'CubeChat attend dans la zone de notification, pour que les appels et messages arrivent sur cet ordinateur même fenêtre fermée';

  @override
  String get trayOpen => 'Ouvrir CubeChat';

  @override
  String get trayQuit => 'Quitter';

  @override
  String get callDirectTitle => 'Appels directs';

  @override
  String get callDirectOnHint =>
      'Plus rapide, mais votre correspondant apprend votre adresse IP';

  @override
  String get callDirectOffHint =>
      'Les appels passent par notre relais : votre correspondant ne voit jamais votre IP, et le relais ne peut pas entendre l’appel';

  @override
  String get profileReadReceipts => 'Confirmations de lecture';

  @override
  String get profileReadReceiptsOnHint =>
      'Les expéditeurs voient quand vous les avez lus';

  @override
  String get profileReadReceiptsOffHint =>
      'Vous n’envoyez plus votre heure de lecture, mais voyez toujours celle des autres';

  @override
  String get profilePrivacyExplainer =>
      '« Vu à » fonctionne dans les deux sens : masquez votre statut et vous ne voyez plus celui des autres. Les confirmations de lecture ne concernent que ce que vous envoyez. La distribution des messages n’est pas affectée.';

  @override
  String get chatTimerAction => 'Minuteur';

  @override
  String get chatTimerRemove => 'Retirer le minuteur';

  @override
  String get chatTimerTitle => 'Supprimer ce message après';

  @override
  String chatTimerSet(String time) {
    return 'Ce message disparaît dans $time';
  }

  @override
  String get chatTimerLocalHint =>
      'Sur cet appareil uniquement — leur copie leur appartient';

  @override
  String get contactTagAction => 'Étiquette';

  @override
  String get contactTagRemove => 'Retirer l’étiquette';

  @override
  String get contactTagTitle => 'Choisir une étiquette';

  @override
  String get contactTagAll => 'Tous';

  @override
  String get quietHoursTitle => 'Heures calmes';

  @override
  String get quietHoursHint =>
      'Les messages arrivent toujours ; le téléphone reste silencieux';

  @override
  String get quietHoursFrom => 'De';

  @override
  String get quietHoursTo => 'À';

  @override
  String get notifPreviewTitle => 'Afficher dans les notifications';

  @override
  String get notifPreviewFull => 'Nom et texte';

  @override
  String get notifPreviewNameOnly => 'Nom seulement';

  @override
  String get notifPreviewHidden => 'Rien';

  @override
  String get notifPreviewHint =>
      'Les notifications sont visibles sur l’écran verrouillé et par les applis ayant accès aux notifications, même avec le verrouillage de l’appli';

  @override
  String get notifPreviewNewMessage => 'Nouveau message';

  @override
  String get appLockTitle => 'Verrouillage de l’appli';

  @override
  String get appLockHint => 'Demander un code à l’ouverture de l’appli';

  @override
  String get appLockPrompt => 'Saisissez votre code';

  @override
  String get appLockUnlock => 'Déverrouiller';

  @override
  String get appLockWrong => 'Code incorrect';

  @override
  String get appLockSetTitle => 'Définir un code';

  @override
  String get appLockSetHint =>
      'Quatre chiffres ou plus. Il est impossible de le récupérer.';

  @override
  String get appLockOffTitle => 'Désactiver le verrouillage';

  @override
  String get appLockOffHint => 'Saisissez votre code actuel';

  @override
  String get appLockOn => 'Verrouillage activé';

  @override
  String get appLockOff => 'Verrouillage désactivé';

  @override
  String get avatarSet => 'Choisir une photo';

  @override
  String get avatarChange => 'Changer de photo';

  @override
  String get avatarView => 'Voir la photo';

  @override
  String get profileCoverPhoto =>
      'Photo de profil, touchez deux fois pour agrandir';

  @override
  String get profileCoverMenu => 'Options de la photo';

  @override
  String get avatarSaved => 'Enregistré dans la galerie';

  @override
  String get avatarRemove => 'Retirer la photo';

  @override
  String get avatarRemoveConfirm =>
      'L’avatar sera supprimé de cet appareil. Le dégradé généré reviendra à sa place.';

  @override
  String get avatarFailed => 'Impossible de lire cette image';

  @override
  String get fileOpenHint => 'Touchez pour ouvrir';

  @override
  String get fileMissing => 'Ce fichier n’est plus disponible';

  @override
  String get fileNoHandlerTitle => 'Aucune appli ne peut l’ouvrir';

  @override
  String get fileNoHandlerHint =>
      'Aucune appli installée ne gère ce type de fichier. Vous pouvez plutôt l’envoyer vers une autre appli.';

  @override
  String get fileRequestedAgain => 'Nouvelle demande envoyée à l’expéditeur';

  @override
  String get fileOpenFailed => 'Impossible d’ouvrir ce fichier';

  @override
  String get fileShareAction => 'Envoyer vers une appli';

  @override
  String fileTooLargeMesh(int limit) {
    return 'Fichier trop volumineux — la limite via le mesh est de $limit Mo';
  }

  @override
  String fileTooLargeRelay(int limit) {
    return 'Via Internet, la limite est de $limit Mo. Rapprochez-vous du destinataire pour envoyer un fichier plus gros.';
  }

  @override
  String get mediaSendOriginal => 'Original';

  @override
  String get attachFile => 'Fichier';

  @override
  String get attachGallery => 'Galerie';

  @override
  String get attachCamera => 'Caméra';

  @override
  String get cameraUnavailable => 'Caméra indisponible';

  @override
  String get profileEditName => 'Nom';

  @override
  String get profileMyCard => 'Carte';

  @override
  String get mediaCaptionHint => 'Ajouter une légende…';

  @override
  String get mediaDiscardTitle => 'Abandonner la sélection ?';

  @override
  String get mediaDiscardMessage =>
      'Fermer la galerie et abandonner les photos sélectionnées ?';

  @override
  String get mediaDiscardConfirm => 'Abandonner';

  @override
  String get mediaPhotosAccessOff => 'L’accès aux photos est désactivé';

  @override
  String get mediaPhotosAccessOffHint =>
      'CubeChat ne voit actuellement que les vidéos. Autorisez l’accès aux photos dans les réglages système pour afficher vos images.';

  @override
  String get mediaVideosOnly =>
      'Seules les vidéos sont visibles — autorisez l’accès aux photos';

  @override
  String get mediaOpenSettings => 'Ouvrir les réglages';

  @override
  String get mediaTakePhoto => 'Prendre une photo';

  @override
  String get contactProfileAutoDelete => 'Suppression auto';

  @override
  String get contactProfileAutoDeleteTitle =>
      'Suppression automatique des messages';

  @override
  String get contactProfileAutoDeleteOff => 'Désactivée';

  @override
  String get contactProfileAutoDeleteOneDay => 'Après 1 jour';

  @override
  String get contactProfileAutoDeleteSevenDays => 'Après 7 jours';

  @override
  String get contactProfileAutoDeleteThirtyDays => 'Après 30 jours';

  @override
  String contactProfileAutoDeleteUpdated(String period) {
    return 'Suppression auto : $period';
  }

  @override
  String get contactProfileShare => 'Partager le contact';

  @override
  String get contactProfileShareTitle => 'Envoyer le contact à';

  @override
  String get contactProfileShareEmpty =>
      'Aucune autre discussion pour l’instant';

  @override
  String contactProfileShareSent(String name) {
    return 'Envoyé à $name';
  }

  @override
  String get contactProfileRestrictCopying => 'Interdire la copie';

  @override
  String get contactProfileAllowCopying => 'Autoriser la copie';

  @override
  String get contactHideAvatar => 'Masquer ma photo';

  @override
  String get contactShowAvatar => 'Afficher ma photo';

  @override
  String get contactHideLastSeen => 'Masquer mon « Vu à »';

  @override
  String get contactShowLastSeen => 'Afficher mon « Vu à »';

  @override
  String get contactHideReadReceipts => 'Masquer mes heures de lecture';

  @override
  String get contactShowReadReceipts => 'Afficher mes heures de lecture';

  @override
  String get contactHiddenFromThem => 'Masqué pour ce contact';

  @override
  String get contactRefuseCalls => 'Refuser ses appels';

  @override
  String get contactAllowCalls => 'Accepter ses appels';

  @override
  String get contactCallsException => 'Une exception à votre réglage d’appels';

  @override
  String get contactProfileCopyingRestricted => 'Copie et transfert désactivés';

  @override
  String get contactProfileCopyingRestrictedByPeer =>
      'Désactivé par l’autre personne';

  @override
  String get contactProfileCopyingAllowed => 'Copie et transfert autorisés';

  @override
  String get contactProfileDelete => 'Supprimer des contacts';

  @override
  String get contactProfileRestore => 'Rajouter aux contacts';

  @override
  String get contactProfileRestoreDone => 'De retour dans vos contacts';

  @override
  String get contactProfileDeleteTitle => 'Supprimer le contact ?';

  @override
  String contactProfileDeleteMessage(String name) {
    return '$name disparaîtra de Contacts. L’historique de la discussion reste sur cet appareil.';
  }

  @override
  String get contactProfileMedia => 'Médias';

  @override
  String get contactProfileVoiceMessages => 'Messages vocaux';

  @override
  String get contactProfileStickers => 'Stickers';

  @override
  String get contactProfileNoStickers => 'Aucun sticker pour l’instant';

  @override
  String get contactProfileNoMedia => 'Aucun média pour l’instant';

  @override
  String get contactProfileNoVoiceMessages =>
      'Aucun message vocal pour l’instant';

  @override
  String get contactProfileOpen => 'Ouvrir le profil';

  @override
  String autoDeleteDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count jours',
      one: '$count jour',
    );
    return '$_temp0';
  }

  @override
  String autoDeleteHours(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count heures',
      one: '$count heure',
    );
    return '$_temp0';
  }

  @override
  String autoDeleteMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count minutes',
      one: '$count minute',
    );
    return '$_temp0';
  }

  @override
  String autoDeleteSeconds(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count secondes',
      one: '$count seconde',
    );
    return '$_temp0';
  }

  @override
  String get autoDeleteCustom => 'Personnalisé…';

  @override
  String get autoDeleteCustomHint => 'Quantité';

  @override
  String get autoDeleteUnitMinutes => 'min';

  @override
  String get autoDeleteUnitHours => 'heures';

  @override
  String get autoDeleteUnitDays => 'jours';

  @override
  String get contactProfileAutoDeleteSet => 'Définir';

  @override
  String get contactProfileFiles => 'Fichiers';

  @override
  String get contactProfileNoFiles => 'Aucun fichier pour l’instant';

  @override
  String get contactProfileLinks => 'Liens';

  @override
  String get contactProfileNoLinks => 'Aucun lien pour l’instant';

  @override
  String get contactProfilePolls => 'Sondages';

  @override
  String get contactProfileNoPolls => 'Aucun sondage pour l’instant';

  @override
  String get presenceRecently => 'vu(e) récemment';

  @override
  String get presenceJustNow => 'à l’instant';

  @override
  String presenceHoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'vu(e) il y a $count heures',
      one: 'vu(e) il y a $count heure',
    );
    return '$_temp0';
  }

  @override
  String presenceYesterdayAt(String time) {
    return 'vu(e) hier à $time';
  }

  @override
  String presenceOnWeekday(String day) {
    String _temp0 = intl.Intl.selectLogic(
      day,
      {
        '1': 'vu(e) lundi',
        '2': 'vu(e) mardi',
        '3': 'vu(e) mercredi',
        '4': 'vu(e) jeudi',
        '5': 'vu(e) vendredi',
        '6': 'vu(e) samedi',
        '7': 'vu(e) dimanche',
        'other': 'vu(e) cette semaine',
      },
    );
    return '$_temp0';
  }

  @override
  String presenceWeeksAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'vu(e) il y a $count semaines',
      one: 'vu(e) il y a une semaine',
    );
    return '$_temp0';
  }

  @override
  String presenceMonthsAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'vu(e) il y a $count mois',
      one: 'vu(e) il y a un mois',
    );
    return '$_temp0';
  }

  @override
  String get presenceLongAgo => 'vu(e) il y a longtemps';

  @override
  String presenceMinutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'vu(e) il y a $count minutes',
      one: 'vu(e) il y a $count minute',
    );
    return '$_temp0';
  }

  @override
  String chatReadByCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Lu par $count',
      one: 'Lu par $count',
    );
    return '$_temp0';
  }

  @override
  String get chatsSearchFrequent => 'Vos interlocuteurs';

  @override
  String get chatsSearchRecent => 'Récents';

  @override
  String get chatsSearchClear => 'Effacer';

  @override
  String get chatsSearchStartHint =>
      'Recherchez une discussion par son nom, ou n’importe quel message par ses mots.';

  @override
  String get chatsSearchEmpty => 'Aucun résultat';

  @override
  String get chatRoutesTitle => 'Comment le message lui parvient';

  @override
  String get chatRoutesBluetoothHint =>
      'Directement sur son téléphone, sans Internet';

  @override
  String get chatRoutesMeshHint => 'Relayé par les téléphones entre vous';

  @override
  String get chatRoutesInternetHint =>
      'Via un relais, quand personne n’est à portée';

  @override
  String get chatRoutesHint =>
      'La voie est choisie pour chaque message, parmi ce qui est joignable à ce moment-là.';

  @override
  String get chatRoutesPreferTitle => 'Quoi essayer d’abord';

  @override
  String get chatRoutesPreferMesh => 'Bluetooth d’abord';

  @override
  String get chatRoutesPreferMeshHint =>
      'Plus rapide dans la même pièce, ne consomme pas de données, ne dit rien à un relais';

  @override
  String get chatRoutesPreferRelay => 'Internet d’abord';

  @override
  String get chatRoutesPreferRelayHint =>
      'Pour une liaison Bluetooth faible et une bonne connexion';

  @override
  String get chatRoutesPreferNote =>
      'Une préférence, pas un verrou. Si la voie choisie n’est pas joignable, l’autre achemine quand même le message.';

  @override
  String get deadmanTitle => 'Effacer si inutilisé';

  @override
  String get deadmanOff => 'Désactivé';

  @override
  String deadmanDays(int days) {
    return 'Après $days jours';
  }

  @override
  String get deadmanHint =>
      'Si personne n’ouvre cette appli pendant ce temps, tout son contenu est effacé à la prochaine ouverture. Elle ne peut pas vous prévenir avant — c’est tout l’intérêt.';

  @override
  String chatForwardedFrom(String name) {
    return 'Transféré de $name';
  }

  @override
  String appLockWait(String left) {
    return 'Trop de tentatives — patientez $left';
  }

  @override
  String get appLockGraceTitle => 'Demander le code';

  @override
  String get appLockGraceNow => 'À chaque fois';

  @override
  String appLockGraceAfter(String left) {
    return 'Après $left d’absence';
  }

  @override
  String get chatCalendarTitle => 'Par date';

  @override
  String get chatCalendarEmpty => 'Rien n’a encore été dit ici';

  @override
  String get chatsSearchChatsSection => 'Discussions';

  @override
  String get chatsSearchMessagesSection => 'Messages';

  @override
  String get contactProfileViewInChat => 'Voir dans la discussion';

  @override
  String get chatDraft => 'Brouillon';

  @override
  String get chatSearchTitle => 'Rechercher';

  @override
  String get chatSearchHint => 'Rechercher des messages';

  @override
  String get chatSearchNoResults => 'Aucun résultat';

  @override
  String get chatSearchPrevious => 'Résultat précédent';

  @override
  String get chatSearchNext => 'Résultat suivant';

  @override
  String chatMessageCount(int count) {
    return '$count messages';
  }

  @override
  String get chatRouteBluetooth => 'Bluetooth';

  @override
  String get chatRouteMesh => 'Mesh';

  @override
  String get chatRouteInternet => 'Internet';

  @override
  String get chatRouteQueued => 'En file d’attente';

  @override
  String get attachStickers => 'Stickers';

  @override
  String get stickersEmpty => 'Aucun sticker pour l’instant';

  @override
  String get stickersEmptyHint =>
      'Gardez une image d’une discussion et elle apparaîtra ici.';

  @override
  String get stickerKeep => 'Enregistrer comme sticker';

  @override
  String get stickerKept => 'Ajouté à vos stickers';

  @override
  String get stickerForget => 'Retirer le sticker';

  @override
  String get stickerCreate => 'Créer un sticker à partir d’une photo';

  @override
  String get stickerFailed => 'Impossible de créer un sticker avec cette image';

  @override
  String get stickerLabel => 'Sticker';

  @override
  String get previewPhoto => 'Photo';

  @override
  String get previewVoice => 'Message vocal';

  @override
  String get previewFile => 'Fichier';

  @override
  String get stickerEmojiTitle => 'Choisissez un emoji pour lui';

  @override
  String get stickersMine => 'Mes stickers';

  @override
  String get stickersStarterPack => 'Cubi';

  @override
  String get emojiTab => 'Emoji';

  @override
  String get chatBlockedStatus => 'bloqué';

  @override
  String get chatBlockedHint => 'Vous avez bloqué cette personne';

  @override
  String get chatRouteFallbackOff => 'Internet désact.';

  @override
  String get chatAttachmentUnavailable =>
      'Aucune connexion disponible. Connectez-vous via Bluetooth ou Internet et réessayez.';

  @override
  String get fileTransfersTitle => 'Transferts de fichiers';

  @override
  String get fileTransfersClear => 'Effacer l’historique';

  @override
  String get fileTransfersEmpty => 'Aucun transfert de fichier pour l’instant';

  @override
  String get fileTransfersActive => 'En cours';

  @override
  String get fileTransfersHistory => 'Historique';

  @override
  String get fileTransferPause => 'Pause';

  @override
  String get fileTransferResume => 'Reprendre';

  @override
  String get fileTransferRetry => 'Réessayer';

  @override
  String get fileTransferQueued => 'En attente de connexion';

  @override
  String get fileTransferRunning => 'Transfert en cours';

  @override
  String get fileTransferPaused => 'En pause';

  @override
  String get fileTransferCompleted => 'Terminé';

  @override
  String get fileTransferFailed => 'Échec';

  @override
  String get fileTransferCanceled => 'Annulé';

  @override
  String get profileFileTransfers => 'Transferts de fichiers';

  @override
  String get profileFileTransfersSubtitle =>
      'Progression, file d’attente et historique';

  @override
  String get qrScanAction => 'Scanner un QR code';

  @override
  String get qrScanTitle => 'Scanner un QR code';

  @override
  String get qrScanHint =>
      'Scannez un code CubeChat de contact, de canal, de transfert de compte ou de connexion d’ordinateur.';

  @override
  String get qrFlash => 'Lampe';

  @override
  String get qrCameraError =>
      'Caméra indisponible. Vérifiez l’autorisation de la caméra et réessayez.';

  @override
  String get qrInvalid => 'Ce n’est pas un QR code Cubechat valide.';

  @override
  String qrChannelAdded(String name) {
    return '$name ajouté';
  }

  @override
  String get qrShow => 'Afficher le QR code';

  @override
  String qrChannelTitle(String name) {
    return 'Rejoindre $name';
  }

  @override
  String get profileBackup => 'Sauvegarde chiffrée';

  @override
  String get profileBackupSubtitle =>
      'Transférez clés, contacts et historique en toute sécurité';

  @override
  String get backupTitle => 'Sauvegarde chiffrée';

  @override
  String get backupExplainer =>
      'La sauvegarde contient vos clés d’identité privées, vos contacts, canaux, réglages et l’historique des messages. Elle est chiffrée sur ce téléphone avec le mot de passe que vous choisissez ; Cubechat ne peut pas récupérer un mot de passe oublié.';

  @override
  String get backupCreate => 'Créer une sauvegarde';

  @override
  String get backupCreateSubtitle =>
      'Tout chiffrer et enregistrer un fichier .cchatbackup';

  @override
  String get backupRestore => 'Restaurer une sauvegarde';

  @override
  String get backupRestoreSubtitle =>
      'Remplacer le profil Cubechat de ce téléphone par un fichier de sauvegarde';

  @override
  String get backupPasswordTitle => 'Mot de passe de la sauvegarde';

  @override
  String get backupPasswordHint => 'Au moins 8 caractères';

  @override
  String get backupConfirmPassword => 'Répétez le mot de passe';

  @override
  String get backupPasswordMismatch => 'Les mots de passe ne correspondent pas';

  @override
  String get backupPasswordShort => 'Utilisez au moins 8 caractères';

  @override
  String get backupSaveTitle => 'Enregistrer la sauvegarde Cubechat';

  @override
  String get backupSaved => 'Sauvegarde chiffrée enregistrée';

  @override
  String get backupWhereTitle => 'Où enregistrer la sauvegarde ?';

  @override
  String get backupSaveToFiles => 'Enregistrer dans Fichiers';

  @override
  String get backupSaveToFilesHint =>
      'Un dossier sur ce téléphone, une carte mémoire ou un stockage cloud';

  @override
  String get backupSendToApp => 'Envoyer vers une appli';

  @override
  String get backupSendToAppHint =>
      'Telegram, e-mail, une messagerie — tout ce qui accepte des fichiers';

  @override
  String get backupFailed => 'Impossible de terminer l’opération de sauvegarde';

  @override
  String get backupRestoreConfirmTitle => 'Remplacer ce profil ?';

  @override
  String get backupRestoreConfirmMessage =>
      'Les clés, contacts, canaux, réglages et l’historique actuels de ce téléphone seront remplacés par la sauvegarde sélectionnée.';

  @override
  String get backupRestoreConfirmAction => 'Restaurer';

  @override
  String get backupRestored => 'Sauvegarde restaurée';

  @override
  String get backupPackingWait => 'Création de la sauvegarde…';

  @override
  String get backupUnpackingWait => 'Restauration de la sauvegarde…';

  @override
  String get backupWaitHint =>
      'Avec des photos et des vidéos, cela peut prendre quelques minutes. Gardez l’appli ouverte.';

  @override
  String get backupInvalid =>
      'Mot de passe incorrect, fichier endommagé ou sauvegarde non prise en charge';

  @override
  String get channelInfoTitle => 'Infos du canal';

  @override
  String get channelParticipantsTitle => 'Participants';

  @override
  String get channelAdministratorsTitle => 'Administrateurs';

  @override
  String get channelMakeAdmin => 'Nommer administrateur';

  @override
  String get channelRemoveAdmin => 'Retirer l’administrateur';

  @override
  String get channelNoParticipants =>
      'Les participants apparaîtront après une activité signée';

  @override
  String get channelSharedContent => 'Médias, fichiers et sondages';

  @override
  String get channelDescriptionTitle => 'Description';

  @override
  String get channelDescriptionEmpty => 'Aucune description pour l’instant';

  @override
  String get channelDescriptionHint => 'À quoi sert ce canal';

  @override
  String get channelDescriptionAdminOnly =>
      'Seul un administrateur peut modifier la description';

  @override
  String get channelDescriptionSave => 'Enregistrer';

  @override
  String get channelPrivateSubtitle => 'canal privé';

  @override
  String get channelAvatarSet => 'Choisir une nouvelle photo';

  @override
  String get channelSettingsTitle => 'Réglages du canal';

  @override
  String get channelSettingsHint => 'Qui peut publier, copie, historique';

  @override
  String get channelLeaveAction => 'Quitter';

  @override
  String get channelLeaveConfirm =>
      'Le salon et tout ce qui y a été dit disparaissent de ce téléphone. La clé vient du nom : vous pourrez le rouvrir en saisissant le même.';

  @override
  String get channelShareAction => 'Partager';

  @override
  String channelMembersOf(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count membres',
      one: '1 membre',
    );
    return '$_temp0';
  }

  @override
  String get chatTyping => 'écrit…';

  @override
  String get chatRecordingVoice => 'enregistre un message vocal…';

  @override
  String get chatRecordingCircle => 'enregistre un message vidéo…';

  @override
  String get chatSendingPhoto => 'envoie une photo…';

  @override
  String get chatSendingVideo => 'envoie une vidéo…';

  @override
  String get chatSendingFile => 'envoie un fichier…';

  @override
  String get onboardingMeshTitle => 'Fonctionne sans Internet';

  @override
  String get onboardingMeshBody =>
      'Les messages passent par Bluetooth, de téléphone à téléphone. Sans réseau, sans Wi-Fi, sans compte — juste les gens autour de vous.';

  @override
  String get onboardingRelayTitle => 'Et avec, quand il y en a';

  @override
  String get onboardingRelayBody =>
      'Hors de portée Bluetooth, les messages passent par Internet et arrivent de la même façon. Vous n’avez jamais à choisir.';

  @override
  String get onboardingPrivacyTitle => 'Personne entre vous ne peut le lire';

  @override
  String get onboardingPrivacyBody =>
      'Tout est chiffré de bout en bout, et votre identité est une clé sur ce téléphone — pas un numéro, pas un e-mail, pas un compte que quelqu’un pourrait vous retirer.';

  @override
  String get onboardingSkip => 'Passer';

  @override
  String get onboardingNext => 'Suivant';

  @override
  String get onboardingStart => 'Commencer';

  @override
  String get chatMediaShare => 'Partager';

  @override
  String get chatMediaSaveToGallery => 'Enregistrer dans la galerie';

  @override
  String get chatMediaShowInChat => 'Voir dans la discussion';

  @override
  String get chatWallpaperTitle => 'Fond d’écran';

  @override
  String get chatWallpaperClear => 'Réinitialiser';

  @override
  String get chatWallpaperDim => 'Assombrir derrière les messages';

  @override
  String get chatSelectAction => 'Sélectionner';

  @override
  String get chatForwardNothing => 'Rien ici ne peut être transféré';

  @override
  String chatSelectedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count sélectionnés',
      one: '1 sélectionné',
    );
    return '$_temp0';
  }

  @override
  String chatDeleteSelectedTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Supprimer $count messages ?',
      one: 'Supprimer ce message ?',
    );
    return '$_temp0';
  }

  @override
  String get contactAliasAction => 'Renommer le contact';

  @override
  String get contactAliasHint =>
      'Vous seul voyez ce nom. Laissez vide pour utiliser le sien.';

  @override
  String get viewOnceSendLabel => 'Vue unique';

  @override
  String get viewOnceTitle => 'Vue unique';

  @override
  String get viewOnceTapToView => 'Photo · touchez pour la voir une fois';

  @override
  String get viewOnceSent => 'Photo · envoyée';

  @override
  String get viewOnceOpened => 'Photo ouverte';

  @override
  String get viewOnceUnavailable => 'Cette photo n’est plus disponible';

  @override
  String get viewOnceWarning =>
      'En fermant, la photo sera supprimée pour vous deux.';

  @override
  String get channelAvatarAdminOnly =>
      'Seul un administrateur peut changer la photo du canal';

  @override
  String get channelAdminOnly => 'Seul un administrateur peut modifier ceci';

  @override
  String get channelAvatarTooLarge =>
      'Cette photo est trop lourde pour être diffusée';

  @override
  String get channelMemberUnknown => 'Pas encore dans vos contacts';

  @override
  String get channelInviteToContacts => 'Lui envoyer votre carte de contact';

  @override
  String channelContactInviteSent(String name) {
    return 'Carte de contact proposée à $name';
  }

  @override
  String get chatContactInvitation => 'Invitation à se connecter';

  @override
  String get chatContactInvitationForYou => 'Invitation pour vous';

  @override
  String get channelPollTitle => 'Sondage';

  @override
  String get channelCreatePoll => 'Créer un sondage';

  @override
  String get channelPollQuestion => 'Question';

  @override
  String channelPollOption(int number) {
    return 'Option $number';
  }

  @override
  String get channelPollAddOption => 'Ajouter une option';

  @override
  String get channelPollCreate => 'Publier';

  @override
  String channelPollVotes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count votes',
      one: '1 vote',
      zero: 'Aucun vote',
    );
    return '$_temp0';
  }

  @override
  String get phoneTransferTitle => 'Transfert vers un nouveau téléphone';

  @override
  String get desktopPickChat => 'Choisissez à qui vous voulez écrire';

  @override
  String get desktopListCollapse => 'Afficher seulement les avatars';

  @override
  String get desktopListExpand => 'Afficher la liste des discussions';

  @override
  String get desktopLinkConnectTitle => 'Connecter un ordinateur';

  @override
  String get desktopLinkConnectHint =>
      'Scannez le code que CubeChat affiche sur l’ordinateur';

  @override
  String get desktopLinkSignIn =>
      'Se connecter avec le compte de mon téléphone';

  @override
  String get desktopLinkTitle => 'Connexion avec votre téléphone';

  @override
  String get desktopLinkSteps =>
      'Sur le téléphone : Profil → Données → Connecter un ordinateur, puis scannez ce code. Les deux doivent être sur le même Wi-Fi.';

  @override
  String get desktopLinkLimits =>
      'Le téléphone continue de fonctionner. Les messages venant d’Internet arrivent sur les deux ; ce que vous envoyez depuis l’un n’apparaît pas encore sur l’autre.';

  @override
  String get desktopLinkWaiting => 'En attente du téléphone…';

  @override
  String get desktopLinkFailed =>
      'Impossible de recevoir le compte. Réessayez.';

  @override
  String get desktopLinkRetry => 'Réessayer';

  @override
  String get desktopLinkConfirmTitle =>
      'Envoyer une copie de ce compte à l’ordinateur ?';

  @override
  String get desktopLinkConfirmMessage =>
      'L’ordinateur reçoit vos clés, contacts et discussions. Ce téléphone continue de fonctionner comme avant.';

  @override
  String get desktopLinkConfirmAction => 'Envoyer';

  @override
  String desktopLinkConfirmWhere(String address) {
    return 'Seulement si vous venez de scanner ce code sur l’écran de votre propre ordinateur. La copie part vers $address sur ce réseau.';
  }

  @override
  String get desktopLinkSending => 'Envoi du compte…';

  @override
  String get desktopLinkSent => 'L’ordinateur est connecté';

  @override
  String get desktopLinkPhoneFound =>
      'Le téléphone a trouvé cet ordinateur et prépare une copie du compte. Avec des photos, cela peut prendre quelques minutes.';

  @override
  String desktopLinkReceiving(int percent) {
    return 'Réception du compte : $percent %';
  }

  @override
  String get desktopLinkRestoring =>
      'Installation du compte sur cet ordinateur…';

  @override
  String get desktopLinkFinding => 'Recherche de l’ordinateur…';

  @override
  String get desktopLinkPreparing =>
      'Préparation d’une copie du compte. Avec des photos, cela peut prendre quelques minutes.';

  @override
  String desktopLinkSendingPercent(int percent) {
    return 'Envoi : $percent %';
  }

  @override
  String get desktopLinkComputerRestoring => 'L’ordinateur installe le compte…';

  @override
  String get devicesTitle => 'Appareils';

  @override
  String get devicesRowHint => 'Où votre compte est ouvert, et s’y déconnecter';

  @override
  String get devicesThisDevice => 'Cet appareil';

  @override
  String get devicesSeenNow => 'En ligne à l’instant';

  @override
  String devicesSeenMinutes(int n) {
    return 'En ligne il y a $n min';
  }

  @override
  String devicesSeenHours(int n) {
    return 'En ligne il y a $n h';
  }

  @override
  String devicesSeenDays(int n) {
    return 'En ligne il y a $n j';
  }

  @override
  String get devicesLeaving => 'Déconnexion — en attente de sa mise en ligne';

  @override
  String get devicesSignOut => 'Déconnecter';

  @override
  String get devicesSignOutAll => 'Déconnecter tous les autres appareils';

  @override
  String devicesSignOutTitle(String name) {
    return 'Déconnecter « $name » ?';
  }

  @override
  String get devicesSignOutMessage =>
      'Les clés, discussions et réglages de CubeChat seront effacés sur cet appareil dès qu’il sera en ligne. Le compte reste ici et sur vos autres appareils.';

  @override
  String get devicesSignOutPhoneMessage =>
      'C’est un téléphone : CubeChat y sera entièrement effacé. Le compte reste ici et sur vos autres appareils.';

  @override
  String get devicesSignOutAllMessage =>
      'Tous les autres appareils seront déconnectés dès qu’ils seront en ligne. Le compte restera uniquement ici.';

  @override
  String get devicesRename => 'Renommer';

  @override
  String get devicesRenameTitle => 'Nom de cet appareil';

  @override
  String get devicesSave => 'Enregistrer';

  @override
  String get devicesEmpty =>
      'Aucun autre appareil pour l’instant. Un appareil apparaît ici dès qu’il ouvre CubeChat 1.0.0+1147 ou une version plus récente.';

  @override
  String get devicesCaveat =>
      'Une déconnexion prend effet quand l’appareil passe en ligne. Un appareil gardé hors ligne conserve ses clés ; une protection complète demanderait de nouvelles clés pour le compte.';

  @override
  String get desktopLinkImportTitle =>
      'Transférer le compte depuis votre téléphone';

  @override
  String get desktopLinkImportHint =>
      'Montrez un code au téléphone, et cet ordinateur devient une copie de son compte';

  @override
  String get desktopLinkImportConfirmTitle =>
      'Remplacer le compte sur cet ordinateur ?';

  @override
  String get desktopLinkImportConfirmMessage =>
      'Les clés, contacts et discussions de cet ordinateur seront remplacés par le compte du téléphone. Si vous avez encore besoin de celui-ci, faites d’abord une sauvegarde.';

  @override
  String get desktopLinkImportConfirmAction => 'Continuer';

  @override
  String get desktopLinkUnreachable =>
      'Impossible de joindre l’ordinateur. Les deux doivent être sur le même Wi-Fi, et CubeChat doit être autorisé dans le pare-feu de l’ordinateur.';

  @override
  String get desktopLinkFirewallHint =>
      'Windows peut empêcher le téléphone d’accéder à cet ordinateur. Autorisez CubeChat dans le pare-feu — pour votre réseau local uniquement.';

  @override
  String get desktopLinkFirewallAllow => 'Autoriser dans le pare-feu';

  @override
  String get desktopLinkFirewallDeclined =>
      'Windows ne l’a pas autorisé. Sans cela, le téléphone risque de ne pas passer.';

  @override
  String get phoneTransferIntro =>
      'Transférez votre profil, vos clés, contacts, canaux, réglages et historique directement d’un téléphone à l’autre.';

  @override
  String get phoneTransferSend => 'C’est l’ancien téléphone';

  @override
  String get phoneTransferReceive => 'C’est le nouveau téléphone';

  @override
  String get phoneTransferSameWifi =>
      'Connectez les deux téléphones au même Wi-Fi. Gardez cet écran ouvert jusqu’à la fin du transfert.';

  @override
  String get phoneTransferPreparing => 'Préparation du transfert chiffré…';

  @override
  String get phoneTransferReady =>
      'Scannez ce QR code à usage unique sur le nouveau téléphone';

  @override
  String get phoneTransferScan => 'Scanner l’ancien téléphone';

  @override
  String get phoneTransferConfirmTitle =>
      'Remplacer le profil de ce téléphone ?';

  @override
  String get phoneTransferConfirmMessage =>
      'Le profil actuellement enregistré sur ce téléphone sera remplacé par le transfert local chiffré.';

  @override
  String get phoneTransferConfirmAction => 'Transférer le profil';

  @override
  String get phoneTransferSuccess => 'Profil transféré avec succès';

  @override
  String get phoneTransferFailed =>
      'Impossible de terminer le transfert de téléphone';

  @override
  String get profileSummaryMeshOnly => 'Mesh uniquement';

  @override
  String get profileSummaryMeshInternet => 'Mesh · Internet';

  @override
  String get profileSummaryBackgroundOn => 'actif en arrière-plan';

  @override
  String profileSummaryTransfersActive(int count) {
    return '$count en cours';
  }

  @override
  String get profileSummaryCardBackup => 'Fichiers, sauvegarde';

  @override
  String get chatPlay => 'Lire';

  @override
  String get chatPause => 'Pause';

  @override
  String get profileTheme => 'Couleur';

  @override
  String get profileThemeEmerald => 'Émeraude';

  @override
  String get profileThemeIndigo => 'Indigo';

  @override
  String get profileThemeAmber => 'Ambre';

  @override
  String get profileThemeRose => 'Rose';

  @override
  String get profileThemeFuchsia => 'Fuchsia';

  @override
  String get profileThemeViolet => 'Violette';

  @override
  String get profileThemeOcean => 'Océan';

  @override
  String get profileThemeSlate => 'Ardoise';

  @override
  String get profileScale => 'Taille de l’interface';

  @override
  String get profileScaleSystem => 'Système';

  @override
  String get profileGlass => 'Verre';

  @override
  String get profileGlassAuto => 'Automatique';

  @override
  String get profileGlassFull => 'Complet';

  @override
  String get profileGlassLight => 'Allégé';

  @override
  String get profileGlassHint =>
      'Allégé garde la teinte et supprime le flou derrière les panneaux. Automatique mesure votre téléphone une fois et décide. Sur un téléphone qui suit déjà sans peine, le gain est minime — c’est pour celui qui peine.';

  @override
  String get mapAlwaysNeeded =>
      'Pour que la carte reste à jour quand cubechat est fermé, la localisation doit être réglée sur Toujours. Touchez pour ouvrir Réglages.';

  @override
  String get mapShareConsentTitle => 'Afficher votre position sur la carte ?';

  @override
  String get mapShareConsentBody =>
      'Votre position en temps réel ne sera visible que par les contacts de votre carte : les personnes que vous avez invitées ou dont vous avez accepté l’invitation. Elle continue de se mettre à jour, y compris quand Cubechat est en arrière-plan, jusqu’à ce que vous vous masquiez. Elle est chiffrée de bout en bout et ne nous parvient jamais. Vous pouvez vous masquer à tout moment sur la carte ou dans Profil, et les contacts que vous bloquez ne vous voient jamais.';

  @override
  String get mapShareConsentAllow => 'Autoriser';

  @override
  String get mapShareConsentDecline => 'Ne pas autoriser';

  @override
  String get mapVisibleToFriends => 'Vos amis sur la carte vous voient';

  @override
  String get mapHiddenFromFriends => 'Vous êtes masqué';

  @override
  String get mapHideMe => 'Me masquer';

  @override
  String get mapShowMe => 'Me montrer';

  @override
  String get profileScaleSmall => 'Plus petit';

  @override
  String get profileScaleNormal => 'Normal';

  @override
  String get profileScaleLarge => 'Plus grand';

  @override
  String get profileScaleSample =>
      'Le texte et les lignes s’affichent à cette taille.';

  @override
  String get savedTitle => 'Enregistrés';

  @override
  String get savedSubtitle => 'Notes pour vous-même, sur cet appareil';

  @override
  String get savedEmpty =>
      'Tout ce que vous écrivez ici reste sur ce téléphone.';

  @override
  String get meshOffTitle => 'Le mesh Bluetooth est désactivé';

  @override
  String get meshOffHint =>
      'Personne à proximité ne peut vous trouver, et vous ne pouvez trouver personne. Les messages passent toujours par le relais Internet.';

  @override
  String get profileMeshSwitch => 'Mesh Bluetooth';

  @override
  String get profileMeshSwitchHint =>
      'Trouve les personnes à proximité et achemine les messages sans Internet. Désactivé, économise la batterie.';

  @override
  String get channelAdminOnlyHint =>
      'Un canal d’annonces. Tout le monde peut le lire.';

  @override
  String get attachLocation => 'Position';

  @override
  String get locationBubbleTitle => 'Position';

  @override
  String get locationOpenInMaps => 'Ouvrir dans Plans';

  @override
  String locationAccuracy(int metres) {
    return 'à $metres m près';
  }

  @override
  String get locationExpired => 'Cette position n’est plus à jour';

  @override
  String get locationDenied => 'L’accès à la localisation est désactivé';

  @override
  String get locationUnavailable => 'Impossible d’obtenir une position';

  @override
  String get locationShareFor => 'Partager pendant';

  @override
  String get locationShareOnce => 'Une seule fois';

  @override
  String get locationShare15m => '15 minutes';

  @override
  String get locationShare1h => '1 heure';

  @override
  String get storageTitle => 'Stockage';

  @override
  String get storageHeadline => 'Utilisation du stockage';

  @override
  String storageSubtitle(String size) {
    return 'cubechat utilise $size sur cet appareil';
  }

  @override
  String get storageEmpty => 'Rien n’est encore stocké';

  @override
  String get storageScanning => 'Calcul…';

  @override
  String get storageCatPhotos => 'Photos';

  @override
  String get storageCatVoice => 'Messages vocaux';

  @override
  String get storageCatFiles => 'Fichiers reçus';

  @override
  String get storageCatOutbox => 'Fichiers envoyés';

  @override
  String get storageCatStickers => 'Stickers';

  @override
  String get storageCatSaved => 'Messages enregistrés';

  @override
  String get storageCatWallpapers => 'Fonds d’écran';

  @override
  String get storageCatHistory => 'Conversations et clés';

  @override
  String get storageCatCache => 'Cache';

  @override
  String storageClear(String size) {
    return 'Libérer $size';
  }

  @override
  String get storageClearNothing => 'Rien de sélectionné';

  @override
  String storageFreed(String size) {
    return '$size libérés';
  }

  @override
  String get storageNoCloud =>
      'Il n’y a pas de cloud derrière. Tout ce que vous effacez disparaît de ce téléphone, et la seule autre copie se trouve sur le téléphone d’où il vient.';

  @override
  String get storageWhyHistoryLocked =>
      'Les conversations ne s’effacent pas d’ici — utilisez l’Effacement d’urgence.';

  @override
  String get storageRecoveryFree => 'Sans risque';

  @override
  String get storageRecoveryGone => 'Aucune copie ailleurs';

  @override
  String get storageRecoveryAskSender => 'Peut être redemandé à l’expéditeur';

  @override
  String get storageRecoveryCostsThem =>
      'Ils ne pourront plus vous demander de le renvoyer';

  @override
  String storageConfirmTitle(String size) {
    return 'Libérer $size ?';
  }

  @override
  String get storageConfirmBody =>
      'Les fichiers seront supprimés de ce téléphone. Rien n’est envoyé nulle part, il n’y a donc rien à partir de quoi les restaurer.';

  @override
  String storageFilesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count fichiers',
      one: '$count fichier',
      zero: 'vide',
    );
    return '$_temp0';
  }

  @override
  String get customizeBarTitle => 'Barre de navigation';

  @override
  String get customizeBarHint =>
      'Faites glisser pour réorganiser. Discussions ne peut pas être retiré.';

  @override
  String get customizeBarShown => 'Affichés';

  @override
  String get customizeBarHidden => 'Masqués';

  @override
  String get customizeBarHiddenEmpty => 'Rien de masqué';

  @override
  String get customizeBarMinimum => 'Gardez au moins deux onglets';

  @override
  String get customizeReset => 'Rétablir par défaut';

  @override
  String get chatsArchiveTitle => 'Archives';

  @override
  String get chatsArchiveEmpty => 'Rien d’archivé';

  @override
  String get chatsArchiveHint =>
      'Les discussions archivées continuent de fonctionner — elles sont seulement hors de la liste.';

  @override
  String get chatsArchivedToast => 'Archivée';

  @override
  String get chatsUnarchivedToast => 'De retour dans la liste';

  @override
  String chatsArchiveCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count discussions',
      one: '$count discussion',
    );
    return '$_temp0';
  }

  @override
  String get chatsSwipeNotHere => 'Indisponible pour cette discussion';

  @override
  String get customizeSwipeTitle => 'Balayer une discussion vers la droite';

  @override
  String get customizeSwipeHint =>
      'Balayer vers la gauche passe toujours d’un onglet à l’autre.';

  @override
  String get customizeSwipeArchive => 'Archiver';

  @override
  String get customizeSwipeMute => 'Son coupé';

  @override
  String get customizeSwipePin => 'Épingler';

  @override
  String get customizeSwipeRead => 'Marquer lu';

  @override
  String get customizeSwipeDelete => 'Supprimer';

  @override
  String get customizeSwipeNone => 'Rien';

  @override
  String get customizeHighRefresh => 'Fréquence maximale';

  @override
  String get customizeHighRefreshHint =>
      'Plus fluide, et le téléphone affiche deux fois plus d’images. Désactivez-la s’il chauffe — l’apparence de l’appli ne change pas, seulement la fréquence à laquelle elle est redessinée.';

  @override
  String get customizeQuickReaction => 'Réaction au double appui';

  @override
  String get customizeQuickReactionHint =>
      'Ce que laisse un double appui sur un message. Si vous en utilisez une autre, elle prend sa place ici.';

  @override
  String get customizeCircleAudioTitle =>
      'Mettre la musique en pause pour les messages vidéo';

  @override
  String get customizeCircleAudioOn =>
      'Enregistrer ou regarder un message vidéo arrête tout ce qui joue. La lecture ne reprend pas d’elle-même.';

  @override
  String get customizeCircleAudioOff =>
      'Votre musique continue en fond, plus bas pendant un message vidéo.';

  @override
  String get customizeMediaQualityTitle => 'Qualité des photos envoyées';

  @override
  String get customizeMediaQualityEconomy => 'Éco';

  @override
  String get customizeMediaQualityStandard => 'Standard';

  @override
  String get customizeMediaQualityHigh => 'Haute';

  @override
  String get customizeMediaQualityEconomyHint =>
      'Jusqu’à 96 Ko par photo, 800 px. Pour une seule barre de réseau ou un mesh Bluetooth encombré : deux fois moins d’attente, une image plus douce.';

  @override
  String get customizeMediaQualityStandardHint =>
      'Jusqu’à 192 Ko par photo, 1280 px. Calibré pour passer même par Bluetooth seul. Les vidéos et « Original » sont toujours envoyés tels quels.';

  @override
  String get customizeMediaQualityHighHint =>
      'Jusqu’à 768 Ko par photo, 2048 px. Assez net pour zoomer ; quatre fois plus long à envoyer, donc idéal en Wi-Fi.';

  @override
  String get previewReacted => 'à votre message';

  @override
  String get previewLocation => 'Position';

  @override
  String get previewMapInvite => 'Invitation à la carte';

  @override
  String get previewContact => 'Contact';

  @override
  String get previewUnsupported => 'Message non pris en charge';

  @override
  String get previewCallOutgoing => 'Appel sortant';

  @override
  String get previewCallIncoming => 'Appel entrant';

  @override
  String get previewCallMissed => 'Appel manqué';

  @override
  String chatPreparingPhotos(int count) {
    return 'Préparation de $count photos…';
  }

  @override
  String get circleSwitchCamera => 'Changer de caméra';

  @override
  String get circleLight => 'Éclairage d’enregistrement';

  @override
  String get circleCameraSwitchFailed =>
      'Impossible de changer de caméra. Votre enregistrement reste ouvert.';

  @override
  String get diagnosticsTitle => 'Diagnostic';

  @override
  String get diagnosticsIntro =>
      'Ce que l’appli a fait récemment. Si quelque chose ne fonctionne pas, envoyez ceci au développeur.';

  @override
  String get diagnosticsShare => 'Envoyer le journal au développeur';

  @override
  String get diagnosticsEvents => 'Événements récents';

  @override
  String get diagnosticsTechnical => 'Journaux techniques';

  @override
  String get diagnosticsEmpty => 'Rien à afficher pour l’instant.';

  @override
  String get diagnosticsDeveloperOn => 'Mode développeur activé';

  @override
  String get diagnosticsDeveloperOff => 'Mode développeur désactivé';

  @override
  String get logAppStarted => 'Appli démarrée';

  @override
  String get logInternetOn => 'Connexion Internet activée';

  @override
  String logServerConnected(String host) {
    return 'Connecté à $host';
  }

  @override
  String logServerLost(String host) {
    return 'Connexion perdue avec $host';
  }

  @override
  String get chatSaveAction => 'Enregistrer';

  @override
  String get savedTagAsk => 'Enregistré. Ajouter un tag ?';

  @override
  String get savedTagAdd => 'Ajouter un tag';

  @override
  String get chatSharedWallpaperFailed =>
      'Fond d’écran appliqué ici. Il lui parviendra quand il sera à portée.';

  @override
  String get chatTranscribeAction => 'Transcrire';

  @override
  String get chatTranscribeFailed =>
      'Ce téléphone ne peut pas transcrire ce message.';

  @override
  String get chatTranscribing => 'Reconnaissance…';

  @override
  String get chatTranscriptHide => 'Masquer le texte';

  @override
  String get chatCancelSend => 'Annuler l’envoi';

  @override
  String get chatDownloadAction => 'Télécharger';

  @override
  String get chatDownloaded => 'Enregistré sur le téléphone';

  @override
  String get chatDownloadFailed => 'Impossible de l’enregistrer';

  @override
  String get selfUpdateTitle => 'Installer une mise à jour depuis un fichier';

  @override
  String get selfUpdateHint =>
      'Choisissez le nouvel APK cubechat ici plutôt que de l’ouvrir depuis une discussion : installé ainsi, les appels sur l’écran verrouillé restent activés.';

  @override
  String get selfUpdateConfirm =>
      'Confirmez l’installation dans la fenêtre du système.';

  @override
  String get selfUpdateAllow =>
      'Autorisez cubechat à installer des applis, puis touchez à nouveau.';

  @override
  String get selfUpdateNotOurs =>
      'Ce fichier n’est pas une mise à jour de cubechat.';

  @override
  String get selfUpdateFailed => 'La mise à jour n’a pas été installée.';

  @override
  String get chatTranscribeDownloading =>
      'Le téléphone télécharge la langue nécessaire. Réessayez dans une minute.';

  @override
  String get chatTranscribeNoLanguage =>
      'Ce téléphone n’a pas de modèle vocal pour cette langue. Choisissez la langue de transcription dans Profil → Discussions et médias.';

  @override
  String get chatTranscribeNotAllowed =>
      'La reconnaissance vocale est désactivée pour CubeChat. Activez-la dans Réglages de l’iPhone → CubeChat.';

  @override
  String get customizeTranscribeLanguageTitle => 'Langue de transcription';

  @override
  String get customizeTranscribeLanguageAuto => 'Auto';

  @override
  String get customizeTranscribeLanguageHint =>
      'La langue parlée dans les messages vocaux, qui n’est pas forcément celle de l’appli. Auto essaie les langues du téléphone. Une langue manquante est téléchargée par le téléphone lui-même ; la voix ne le quitte jamais.';

  @override
  String get chatTranslateAction => 'Traduire';

  @override
  String get chatTranslateFailed =>
      'Ce message ne peut pas être traduit sur ce téléphone.';

  @override
  String get customizeDeferMediaTitle =>
      'Attendre le Wi-Fi pour télécharger les médias';

  @override
  String get customizeDeferMediaHint =>
      'En données mobiles, les messages et les appels fonctionnent normalement, tandis que photos, messages vocaux, messages vidéo et fichiers attendent le Wi-Fi sur le serveur — jusqu’à deux semaines. Une ligne au-dessus des discussions indique ce qui attend et le télécharge tout de suite.';

  @override
  String heldMediaCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count médias en attente du Wi-Fi',
      one: '1 média en attente du Wi-Fi',
    );
    return '$_temp0';
  }

  @override
  String get heldMediaDownload => 'Télécharger';

  @override
  String get nearbyAirDropSubtitle =>
      'Partagez des fichiers avec les personnes à proximité';

  @override
  String get nearbyFilesSubtitle => 'Fichiers envoyés et reçus';

  @override
  String get airdropTab => 'AirDrop';

  @override
  String get nearbyTabFiles => 'Fichiers';

  @override
  String get airdropReceiveHint => 'Qui peut vous envoyer des fichiers';

  @override
  String get airdropReceiveContacts => 'Contacts';

  @override
  String get airdropReceiveEveryone => 'Tous 10 min';

  @override
  String airdropEveryoneLeft(String time) {
    return 'Tous · $time';
  }

  @override
  String get airdropSendFiles => 'Envoyer des fichiers';

  @override
  String get airdropChooseFiles => 'Choisir des fichiers';

  @override
  String airdropStagedTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count fichiers prêts',
      one: '$count fichier prêt',
    );
    return '$_temp0';
  }

  @override
  String get airdropStagedHint =>
      'Bluetooth activé et AirDrop ouvert sur les deux téléphones, rapprochez-les ou choisissez une personne';

  @override
  String get airdropStagedPickPerson => 'Choisir une personne';

  @override
  String airdropRequestBody(String what, String size) {
    return 'veut envoyer $what · $size';
  }

  @override
  String airdropWhatPhotos(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count photos',
      one: '1 photo',
    );
    return '$_temp0';
  }

  @override
  String airdropWhatVideos(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count vidéos',
      one: '1 vidéo',
    );
    return '$_temp0';
  }

  @override
  String airdropWhatFiles(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count fichiers',
      one: '1 fichier',
    );
    return '$_temp0';
  }

  @override
  String get airdropAccept => 'Accepter';

  @override
  String get airdropDecline => 'Refuser';

  @override
  String get airdropWaiting => 'En attente d’une réponse…';

  @override
  String get airdropAccepted => 'Accepté';

  @override
  String get airdropUnheard =>
      'Non reçu — peut-être une ancienne version de CubeChat';

  @override
  String get airdropSending => 'Envoi';

  @override
  String get airdropReceiving => 'Réception';

  @override
  String get airdropInterrupted => 'Interrompu';

  @override
  String get airdropRetry => 'Réessayer';

  @override
  String get airdropOutcomeSent => 'Envoyé';

  @override
  String get airdropOutcomeReceived => 'Reçu';

  @override
  String get airdropOutcomeDeclined => 'Refusé';

  @override
  String get airdropOutcomeCancelled => 'Annulé';

  @override
  String get airdropOutcomePartial => 'Partiel';

  @override
  String get airdropReasonNoSpace => 'espace insuffisant';

  @override
  String get airdropReasonContactsOnly => 'contacts uniquement';

  @override
  String get airdropReasonBusy => 'occupé';

  @override
  String get airdropReasonTimeout => 'pas de réponse';

  @override
  String get airdropFileDeleted => 'supprimé';

  @override
  String get airdropHistory => 'Historique';

  @override
  String get airdropClearHistory => 'Effacer l’historique';

  @override
  String get airdropEmpty =>
      'Les fichiers que vous envoyez ou recevez à proximité apparaîtront ici';

  @override
  String get airdropPickPerson => 'Envoyer à';

  @override
  String get airdropNobody =>
      'Personne avec cubechat à proximité pour l’instant';

  @override
  String get airdropNoDirect =>
      'Pas de connexion Bluetooth avec cette personne';

  @override
  String get airdropNearbyUnknown => 'À proximité';

  @override
  String get airdropConnecting => 'Connexion…';

  @override
  String get airdropConnectFailed => 'Connexion impossible';

  @override
  String get airdropSlowWarning => 'Cela peut prendre longtemps via Bluetooth';

  @override
  String airdropTooLarge(String name, int limit) {
    return '$name dépasse $limit Mo';
  }

  @override
  String airdropFromLabel(String name) {
    return 'AirDrop · $name';
  }

  @override
  String get airdropWrite => 'Écrire';

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
      'Activez le Bluetooth sur les deux téléphones pour qu’ils se trouvent et confirment le transfert.';

  @override
  String get airdropLaneHint =>
      'Le Bluetooth trouve et connecte les téléphones. Le Wi‑Fi transfère les fichiers quand les deux téléphones partagent un réseau ou un point d’accès.';

  @override
  String get airdropWifiUnreachable => 'Pas sur le même réseau';

  @override
  String get airdropWifiOldVersion =>
      'Son appli ne peut pas encore recevoir via Wi‑Fi';

  @override
  String get airdropBumpAdd => 'Ajouter';

  @override
  String get airdropBumpAlreadyContact => 'Déjà dans vos contacts';

  @override
  String airdropBumpSending(String name) {
    return 'Envoi à $name';
  }

  @override
  String airdropBumpReceiving(String name) {
    return '$name vous envoie des fichiers';
  }

  @override
  String get termsTitle => 'Règles de cubechat';

  @override
  String get termsBody =>
      'cubechat applique une tolérance zéro envers les contenus répréhensibles et les utilisateurs abusifs. En continuant, vous acceptez de ne pas envoyer de harcèlement, de menaces, de contenu sexuel impliquant des mineurs, de spam ni quoi que ce soit d’illégal. Tout le monde peut signaler un message ou une personne ; les signalements parviennent au développeur et sont traités sous 24 heures, et les contrevenants sont bannis.';

  @override
  String get termsReadFull => 'Lire les conditions complètes';

  @override
  String get termsAccept => 'J’accepte';

  @override
  String get messageHide => 'Masquer';

  @override
  String get messageHidden => 'Masqué pour vous';

  @override
  String get reportAction => 'Signaler';

  @override
  String get reportTitle => 'Quel est le problème ?';

  @override
  String get reportReasonSpam => 'Spam';

  @override
  String get reportReasonAbuse => 'Insultes ou harcèlement';

  @override
  String get reportReasonViolence => 'Violence';

  @override
  String get reportReasonSexual => 'Contenu sexuel';

  @override
  String get reportReasonOther => 'Autre';

  @override
  String get reportNoteHint => 'Décrivez (facultatif)';

  @override
  String get reportSend => 'Envoyer le signalement';

  @override
  String get reportDisclosure =>
      'Le texte du message sélectionné et votre signalement sont transmis à la modération de cubechat et à son bot Telegram privé.';

  @override
  String get reportSent =>
      'Signalement envoyé. Nous examinons les signalements sous 24 heures.';

  @override
  String get reportBlockedToo => 'Cette personne est bloquée pour vous.';

  @override
  String get reportQueued =>
      'Signalement enregistré. Il sera envoyé une fois en ligne.';

  @override
  String get reportFailed => 'Impossible d’envoyer le signalement.';

  @override
  String get filteredMessage => 'Masqué par le filtre';

  @override
  String get filteredShow => 'Afficher';

  @override
  String get filterToggle => 'Filtre de contenu offensant';

  @override
  String get filterToggleHint =>
      'Masque les grossièretés des inconnus et dans les canaux';

  @override
  String get aboutTitle => 'À propos';

  @override
  String get aboutContact => 'Écrire au développeur';

  @override
  String get aboutReport => 'Signaler une infraction';

  @override
  String get aboutTerms => 'Conditions d’utilisation';

  @override
  String get aboutPrivacy => 'Politique de confidentialité';

  @override
  String get requestsTitle => 'Demandes';

  @override
  String get requestsEmpty => 'Aucune demande';

  @override
  String requestBanner(String name) {
    return '$name n’est pas dans vos contacts. Tant que vous n’acceptez pas, cette personne ne voit pas que vous avez lu ce message et ne peut pas vous appeler.';
  }

  @override
  String get requestAccept => 'Accepter';

  @override
  String get requestDelete => 'Supprimer';

  @override
  String get requestBlock => 'Bloquer';

  @override
  String get cubeIdTitle => 'Cube ID';

  @override
  String get cubeIdExplainer =>
      'Votre @nom renvoie à votre carte de contact. Le serveur ne conserve que le nom et votre carte publique — jamais vos messages.';

  @override
  String get cubeIdFieldHint => 'a–z, 0–9 et _, 3 à 20 caractères';

  @override
  String get cubeIdAvailable => 'Disponible';

  @override
  String get cubeIdTaken => 'Déjà pris';

  @override
  String get cubeIdReserved => 'Non autorisé';

  @override
  String get cubeIdInvalid => 'Uniquement a–z, 0–9 et _, 3 à 20 caractères';

  @override
  String get cubeIdClaim => 'Prendre ce nom';

  @override
  String get cubeIdWorking => 'Réservation du nom…';

  @override
  String get cubeIdChange => 'Modifier';

  @override
  String get cubeIdEmail => 'E-mail de récupération';

  @override
  String get cubeIdEmailHint =>
      'Si ce téléphone est perdu, le nom peut être récupéré grâce à un e-mail envoyé à cette adresse';

  @override
  String get cubeIdEmailField => 'E-mail';

  @override
  String cubeIdEmailSent(String email) {
    return 'Un e-mail a été envoyé à $email. Ouvrez le lien qu’il contient.';
  }

  @override
  String get cubeIdEmailRemove => 'Retirer l’e-mail';

  @override
  String get cubeIdEmailUnavailable =>
      'L’e-mail est indisponible pour le moment. Réessayez plus tard.';

  @override
  String get cubeIdEmailInvalid => 'Cela ne ressemble pas à une adresse e-mail';

  @override
  String get cubeIdSave => 'Enregistrer';

  @override
  String get cubeIdRecover => 'Récupérer un nom par e-mail';

  @override
  String get cubeIdRecoverSent =>
      'Si l’adresse correspond, un e-mail arrivera. Le nom passera sur ce téléphone 48 heures après l’ouverture du lien.';

  @override
  String cubeIdRecoveryWarning(String name, String when) {
    return 'Quelqu’un récupère @$name sur un autre téléphone par e-mail. Le nom sera transféré $when si vous n’annulez pas.';
  }

  @override
  String get cubeIdRecoveryCancel => 'Annuler la récupération';

  @override
  String get cubeIdRecoveryCancelled => 'Récupération annulée';

  @override
  String get cubeIdRelease => 'Libérer';

  @override
  String cubeIdReleaseConfirm(String name) {
    return 'Libérer @$name ? N’importe qui pourra le prendre.';
  }

  @override
  String get cubeIdShare => 'Partager';

  @override
  String cubeIdShareText(String name) {
    return 'Retrouvez-moi sur cubechat : @$name\nhttps://cubechat.tech/u.html#$name';
  }

  @override
  String get cubeIdFailed => 'Impossible d’enregistrer le nom. Réessayez.';

  @override
  String get cubeIdOffline => 'Pas d’Internet';

  @override
  String get lookupNotFound => 'Personne avec ce @nom';

  @override
  String searchFindCubeName(String name) {
    return 'Rechercher @$name';
  }

  @override
  String get searchFindCubeNameHint => 'Chercher dans Cube ID et ajouter';

  @override
  String get addContactHintName => 'Collez une carte ou tapez @nom';

  @override
  String get strangerReachTitle => 'Qui peut m’écrire depuis Internet';

  @override
  String get strangerReachAll => 'Tout le monde';

  @override
  String get strangerReachRequest => 'Sur demande';

  @override
  String get strangerReachNone => 'Personne';

  @override
  String get strangerReachHint =>
      'Pour les personnes à qui vous n’avez pas écrit et qui vous contactent via Internet. Les personnes à proximité via Bluetooth ne sont pas concernées.';

  @override
  String get sectionPrivacy => 'Confidentialité et sécurité';

  @override
  String get sectionNotifications => 'Notifications et appels';

  @override
  String get sectionConnection => 'Connexion';

  @override
  String get sectionChats => 'Discussions et médias';

  @override
  String get sectionAppearance => 'Apparence';

  @override
  String get sectionData => 'Données et stockage';

  @override
  String get sectionAbout => 'À propos';

  @override
  String get subWhoSeesMe => 'Qui me voit';

  @override
  String get subProtection => 'Protection';

  @override
  String get subNotifications => 'Notifications';

  @override
  String get subCalls => 'Appels';

  @override
  String get profileDiscoverableMeshOff =>
      'Le mesh Bluetooth est désactivé — activez-le dans Connexion.';

  @override
  String get chatRouteBluetoothDirect => 'Bluetooth direct';

  @override
  String chatRouteMeshHops(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Mesh · $n sauts',
      one: 'Mesh · $n saut',
    );
    return '$_temp0';
  }

  @override
  String chatRouteDeliveredVia(String route) {
    return 'Distribué : $route';
  }

  @override
  String chatRouteReceivedVia(String route) {
    return 'Reçu : $route';
  }

  @override
  String get chatUnreadDivider => 'Nouveaux messages';

  @override
  String get radioTitle => 'Talkie-walkie';

  @override
  String get radioNearbySubtitle =>
      'Maintenez un bouton et parlez à un groupe ou à un contact';

  @override
  String get radioGroupsLabel => 'Groupes';

  @override
  String get radioDirectLabel => 'Privé';

  @override
  String get radioAddGroup => 'Ajouter un talkie';

  @override
  String get radioNoGroups =>
      'Aucun talkie pour l’instant. Ajoutez-en un — tous ceux qui saisissent le même nom et le même mot de passe s’entendent.';

  @override
  String get radioLeave => 'Quitter ce talkie';

  @override
  String get radioPickChannel => 'Choisissez un groupe ou un contact';

  @override
  String get radioPushToTalk => 'Maintenir pour parler';

  @override
  String get radioTalking => 'Vous parlez…';

  @override
  String get radioChannelBusy => 'Canal occupé';

  @override
  String radioSpeaker(String name) {
    return '$name parle';
  }

  @override
  String get radioSilentTitle => 'Parler en mode silencieux';

  @override
  String get radioSilentHint =>
      'La voix est diffusée même quand le téléphone est en mode silencieux.';

  @override
  String get radioJoinNameLabel => 'Nom';

  @override
  String get radioJoinPasswordLabel => 'Mot de passe (facultatif)';

  @override
  String get radioJoinHint =>
      'Tous ceux qui saisissent le même nom et le même mot de passe sont sur le même talkie. Aucun serveur n’en conserve la liste.';

  @override
  String get radioJoinNameRequired => 'Saisissez un nom';

  @override
  String get radioJoinSubmit => 'Ajouter';

  @override
  String get radioBlockedTooLong => 'Coupé après une minute de parole';

  @override
  String get radioBlockedCall => 'Un appel est en cours';

  @override
  String get radioBlockedMicrophone => 'Pas d’accès au micro';

  @override
  String get radioBlockedUnavailable =>
      'Le talkie n’est pas disponible sur cet appareil';

  @override
  String get radioBlockedNoChannel =>
      'Choisissez d’abord un groupe ou un contact';

  @override
  String get radioTurnOff => 'Éteindre le talkie';

  @override
  String get radioPersonalCallsTitle => 'Recevoir les appels privés';

  @override
  String get radioPersonalCallsHint =>
      'Quand le talkie est éteint, un contact qui vous parle le règle sur lui.';

  @override
  String get radioBackgroundHint =>
      'Écran éteint, le talkie ne s’entend que si le mode arrière-plan est activé.';

  @override
  String get areaNearby => 'Discussion locale';

  @override
  String get areaLevelDistrict => 'Quartier';

  @override
  String get areaLevelCity => 'Ville';

  @override
  String get areaLevelRegion => 'Région';

  @override
  String areaPresentCount(int count) {
    return '≈$count ici';
  }

  @override
  String get areaPresentMany => '50+ ici';

  @override
  String get areaBlockViaBluetooth => 'Votre pâté de maisons — via Bluetooth';

  @override
  String get areaOpenNearbyTab => 'Ouvrir À proximité';

  @override
  String get areaLocating => 'Recherche de votre quartier…';

  @override
  String get areaNoPlace =>
      'Pas encore de position. La discussion locale a besoin de votre position approximative tant que cet écran est ouvert.';

  @override
  String get areaLocationDenied =>
      'La localisation est désactivée pour Cubechat. Autorisez la position approximative dans Réglages pour voir votre quartier.';

  @override
  String get areaOffline => 'Pas de connexion à la discussion locale';

  @override
  String get areaEmpty => 'Personne n’a écrit ici ces dernières 24 heures.';

  @override
  String get areaConsentTitle => 'La discussion locale est publique';

  @override
  String get areaConsentBody =>
      'Les messages ici sont publics. Toute personne qui ouvre votre quartier ou votre ville les lira, et ils sont conservés 24 heures sur le serveur Cubechat. Vous écrivez sous un nom temporaire qui change toutes les quelques heures ; personne ne voit votre @nom ni vos contacts. Pour connaître votre quartier, Cubechat demande votre position approximative, uniquement tant que cet écran est ouvert.';

  @override
  String get areaConsentAllow => 'Continuer';

  @override
  String get areaConsentDecline => 'Pas maintenant';

  @override
  String areaDefaultName(String tag) {
    return 'Cube-$tag';
  }

  @override
  String areaYouAre(String name, int hours) {
    return 'Vous êtes $name · nouveau nom dans $hours h';
  }

  @override
  String get areaNewName => 'Nouveau nom';

  @override
  String get areaSetName => 'Choisir un nom';

  @override
  String get areaNameHint =>
      'Seulement pour les quelques heures de ce nom. Laissez vide pour le nom automatique.';

  @override
  String get areaNameSameWarning =>
      'Un même nom vous relie d’un quartier à l’autre';

  @override
  String get areaShowPresence => 'Montrer que je suis là';

  @override
  String get areaPresenceOffHint =>
      'Activez « Montrer que je suis là » pour voir combien de personnes sont à proximité';

  @override
  String get areaReadOnly => 'Vous ne pouvez écrire que là où vous êtes';

  @override
  String get areaComposerHint => 'Message pour tout le monde ici';

  @override
  String get areaSend => 'Envoyer';

  @override
  String get areaWaitALittle => 'Patientez un peu';

  @override
  String areaFlood(int count) {
    return 'Flood ($count) · Afficher';
  }

  @override
  String get areaReply => 'Répondre';

  @override
  String get areaHide => 'Masquer';

  @override
  String get areaBlock => 'Bloquer jusqu’au changement de nom';

  @override
  String get areaBlocked => 'Bloqué jusqu’au changement de nom';

  @override
  String get areaReport => 'Signaler';

  @override
  String get areaOpenLink => 'Ouvrir le lien';

  @override
  String areaOpenLinkConfirm(String url) {
    return 'Ouvrir $url ?';
  }

  @override
  String get areaOpen => 'Ouvrir';

  @override
  String get areaReadHere => 'Lire ici';

  @override
  String get areaReadHereHint =>
      'Lecture seule. Vous ne pouvez écrire que là où vous êtes ; le relais apprend quel lieu vous lisez.';

  @override
  String get areaNotes => 'Notes';

  @override
  String areaNotesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count notes',
      one: '$count note',
      zero: 'Aucune note',
    );
    return '$_temp0';
  }

  @override
  String get areaLeaveNote => 'Laisser une note';

  @override
  String get areaNoteHint => 'Une courte note pour votre ville';

  @override
  String get areaNoteLifetime => 'Durée';

  @override
  String get areaNote1h => '1 h';

  @override
  String get areaNote24h => '24 h';

  @override
  String get areaNote7d => '7 jours';

  @override
  String get areaPinToDistrict => 'Épingler à un quartier';

  @override
  String get areaPinHint =>
      'Touchez la carte dans votre ville ; le repère s’aligne sur son quartier.';

  @override
  String get areaPinOutside => 'Uniquement dans votre ville';

  @override
  String get areaNoteDelete => 'Supprimer ma note';

  @override
  String get areaNoNotes => 'Aucune note ici pour l’instant';

  @override
  String get areaNotesLimit => 'Trois notes par jour';

  @override
  String get areaNoteLeft => 'Note laissée';

  @override
  String get areaNoteSend => 'Laisser';

  @override
  String get areaOwnNote => 'Votre note';

  @override
  String get areaNotePinned => 'Épinglée à un quartier';

  @override
  String get areaHidden => 'Masqué';

  @override
  String get areaPublicBadge => 'Public · conservé 24 h';

  @override
  String get areaSettingTitle => 'Discussion locale';

  @override
  String get areaSettingOnHint =>
      'Le bouton Discussion locale sur la carte : discussions publiques de votre quartier et de votre ville, sous un nom temporaire.';

  @override
  String get areaSettingOffHint =>
      'Désactivé : pas de bouton sur la carte, et la discussion locale ne demande jamais votre position et ne se connecte jamais.';

  @override
  String get wallpaperPhotoLocalOnly =>
      'Les fonds photo sont pour l’instant uniquement locaux';

  @override
  String get wallpaperSavedNoRoute =>
      'Enregistré ici. Aucun itinéraire vers le correspondant pour le moment';

  @override
  String get wallpaperScopeTitle => 'Qui doit voir ce fond d’écran ?';

  @override
  String get wallpaperScopeChannel => 'Tout le canal';

  @override
  String get wallpaperScopeBoth => 'Moi et mon correspondant';

  @override
  String get wallpaperScopeLocal => 'Seulement chez moi';

  @override
  String get wallpaperScopeSharedHint =>
      'Envoyé comme paquet de contrôle chiffré';

  @override
  String get wallpaperScopePhotoHint =>
      'Les photos restent pour l’instant sur ce téléphone';

  @override
  String get foldersCreate => 'Créer un dossier';

  @override
  String get foldersYours => 'Vos dossiers';

  @override
  String get foldersSmartFilters => 'Filtres intelligents';

  @override
  String get foldersName => 'Nom du dossier';

  @override
  String get foldersSave => 'Enregistrer';

  @override
  String get foldersDeleteTitle => 'Supprimer le dossier ?';

  @override
  String get foldersDelete => 'Supprimer';

  @override
  String get foldersCreateAction => 'Créer';

  @override
  String get chatsArchiveHiddenToast =>
      'Archives masquées. Rétablissez-les dans « Apparence ».';

  @override
  String get chatsBulkPin => 'Épingler';

  @override
  String get chatsBulkMute => 'Couper le son';

  @override
  String get chatsUnarchive => 'Désarchiver';

  @override
  String get chatsAddToFolder => 'Ajouter au dossier';

  @override
  String get chatsMarkUnread => 'Marquer comme non lu';

  @override
  String get chatsClearHistory => 'Effacer l’historique';

  @override
  String get foldersNew => 'Nouveau dossier';

  @override
  String get foldersNameHint => 'Amis';

  @override
  String get chatsNoIncoming => 'Aucun message entrant';

  @override
  String get chatsMarkedUnread => 'Marqué comme non lu';

  @override
  String get chatsClearHistoryTitle =>
      'Effacer l’historique de la discussion ?';

  @override
  String get chatsClearHistoryBody =>
      'Les messages seront supprimés uniquement sur cet appareil. La discussion, le contact et les favoris restent.';

  @override
  String get chatsClearHistoryAction => 'Effacer';

  @override
  String get chatsHistoryCleared => 'Historique effacé';

  @override
  String get savedTagMenuTag => 'Étiquette';

  @override
  String get savedTagRemove => 'Retirer l’étiquette';

  @override
  String get customizeArchiveRowTitle => 'Ligne des archives';

  @override
  String get customizeArchiveRowHint =>
      'L’afficher au-dessus de la liste des discussions. Les discussions archivées reçoivent les messages dans tous les cas.';

  @override
  String get mapLayerStandard => 'Standard';

  @override
  String get mapLayerStandardHint =>
      'Plan de rues clair — l’option la plus stable';

  @override
  String get callYourMicOff => 'Votre micro est coupé';

  @override
  String callTheirCameraOff(String name) {
    return 'La caméra de $name est coupée';
  }
}
