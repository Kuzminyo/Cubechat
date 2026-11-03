// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get callVoice => 'Llamada de voz';

  @override
  String get callVideo => 'Videollamada';

  @override
  String get callIncomingVideo => 'Videollamada entrante';

  @override
  String get callCamera => 'Cámara';

  @override
  String get callFlipCamera => 'Girar';

  @override
  String get contactProfileVideo => 'Video';

  @override
  String get callPreparing => 'Preparando el micrófono…';

  @override
  String get callDialing => 'Llamando…';

  @override
  String get callRinging => 'Sonando…';

  @override
  String get callConnecting => 'Conectando…';

  @override
  String get callMicrophoneRequired =>
      'Permite el acceso al micrófono en los ajustes del sistema para hacer llamadas.';

  @override
  String get callMicrophoneWindows =>
      'Windows no dio acceso al micrófono a CubeChat. Activa Configuración → Privacidad y seguridad → Micrófono → \"Permitir que las aplicaciones de escritorio accedan al micrófono\".';

  @override
  String get callElsewhere =>
      'Ya hay una llamada en curso en otro dispositivo de esta cuenta.';

  @override
  String get callRelayUnavailable =>
      'El servidor de llamadas no está disponible. Inténtalo más tarde.';

  @override
  String get callBusy => 'Ocupado';

  @override
  String get callNoAnswer => 'Sin respuesta';

  @override
  String get callFailed => 'No se pudo conectar la llamada';

  @override
  String get callDeclined => 'Llamada rechazada';

  @override
  String get callEnded => 'Llamada finalizada';

  @override
  String get callMicrophone => 'Micrófono';

  @override
  String get callSpeaker => 'Altavoz';

  @override
  String get callAnswer => 'Responder';

  @override
  String get callDecline => 'Rechazar';

  @override
  String get callEnd => 'Colgar';

  @override
  String get callClose => 'Cerrar';

  @override
  String get callMinimize => 'Minimizar';

  @override
  String get callAudioOutput => 'Audio de llamada';

  @override
  String get callRoutePhone => 'Teléfono';

  @override
  String get callRouteBluetooth => 'Bluetooth';

  @override
  String get callRouteHeadphones => 'Auriculares';

  @override
  String get callFullScreenTitle => 'Llamadas en la pantalla de bloqueo';

  @override
  String get callFullScreenBody =>
      'Permite que las llamadas entrantes aparezcan en la pantalla bloqueada para poder responder sin desbloquear.';

  @override
  String get callFullScreenXiaomi =>
      'Xiaomi, Redmi y Poco no permiten que las apps lo activen por sí mismas: activa «Mostrar en pantalla de bloqueo» en Otros permisos.';

  @override
  String get circleMessage => 'Videomensaje';

  @override
  String get appName => 'Cubechat';

  @override
  String get navChats => 'Chats';

  @override
  String get navPeers => 'Cerca';

  @override
  String get navProfile => 'Perfil';

  @override
  String get navContacts => 'Contactos';

  @override
  String get navMap => 'Mapa';

  @override
  String get mapTitle => 'Mapa';

  @override
  String get mapFriendsTitle => 'Personas en el mapa';

  @override
  String get mapFriendsHint => 'Solo estos contactos reciben tu ubicación';

  @override
  String mapClusterTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count personas aquí',
      one: '$count persona aquí',
    );
    return '$_temp0';
  }

  @override
  String get mapClusterHint =>
      'Toca a alguien para centrar el mapa en esa persona';

  @override
  String get mapNorthUp => 'Norte arriba';

  @override
  String get mapLayerTitle => 'Estilo del mapa';

  @override
  String get mapLayerHint => 'Sobre qué se dibujan los marcadores';

  @override
  String get mapLayerDark => 'Oscuro';

  @override
  String get mapLayerDarkHint =>
      'Calles sin etiquetas: el fondo más discreto para los marcadores';

  @override
  String get mapLayerSatellite => 'Satélite';

  @override
  String get mapLayerSatelliteHint =>
      'Imágenes aéreas: qué edificio, qué patio';

  @override
  String get mapLayerTerrain => 'Relieve';

  @override
  String get mapLayerTerrainHint =>
      'Curvas de nivel y relieve, para colinas y senderos';

  @override
  String get mapFriendsEmpty => 'Todavía nadie comparte el mapa contigo.';

  @override
  String get mapFriendsEmptyHint =>
      'Invita a un contacto y aparecerá aquí en cuanto acepte.';

  @override
  String get mapFriendsInvite => 'Invitar';

  @override
  String get mapFriendsRemove => 'Quitar del mapa';

  @override
  String mapFriendsRemoved(String name) {
    return '$name ya no comparte el mapa contigo';
  }

  @override
  String get mapFriendsLive => 'En el mapa ahora';

  @override
  String get mapFriendsIdle => 'Sin ubicación ahora';

  @override
  String get mapInviteTitle => 'Invitar al mapa';

  @override
  String get mapInviteHint => 'Elige uno o varios chats';

  @override
  String get mapInviteEmpty => 'Todavía no hay chats a los que invitar.';

  @override
  String mapInviteAction(int count) {
    return 'Enviar ($count)';
  }

  @override
  String get mapInviteMessage =>
      'Invitación al mapa de Cubechat. Comparte tu ubicación en este chat para aparecer en el mapa.';

  @override
  String mapInviteSent(int count) {
    return 'Invitaciones enviadas: $count';
  }

  @override
  String get mapInviteFailed => 'No se pudieron enviar las invitaciones';

  @override
  String mapPeopleVisible(int count) {
    return 'Ubicaciones compartidas: $count';
  }

  @override
  String get mapCenterMe => 'Centrar en mí';

  @override
  String get mapNoSharedLocations => 'Aún no hay ubicaciones compartidas';

  @override
  String get mapNoSharedLocationsHint =>
      'Un contacto aparece aquí después de enviar su ubicación en el chat.';

  @override
  String get mapWebHintTitle => 'Conexiones cercanas';

  @override
  String get mapWebHint =>
      'Las líneas muestran proximidad, no la ruta de los mensajes.';

  @override
  String get mapOpenProfile => 'Perfil';

  @override
  String get mapLocationPrivacyOff => 'La ubicación en el mapa está oculta';

  @override
  String get mapLocationPrivacyOffHint =>
      'Activa «Mostrarme en el mapa» en Privacidad para ver tu marcador.';

  @override
  String get mapYouOnMap => 'Tu ubicación es visible en este dispositivo';

  @override
  String get locationSharingDisabled =>
      'Primero activa «Mostrarme en el mapa» en Privacidad.';

  @override
  String get mapLocationDenied => 'El acceso a la ubicación está desactivado';

  @override
  String get mapLocationServiceOff =>
      'Activa los servicios de ubicación para mostrarte';

  @override
  String get mapLocationUnavailable => 'No se pudo determinar tu ubicación';

  @override
  String get mapDistanceUnknown => 'Distancia no disponible';

  @override
  String mapDistanceMetres(int metres) {
    return 'a $metres m';
  }

  @override
  String mapDistanceKilometres(String kilometres) {
    return 'a $kilometres km';
  }

  @override
  String get mapUpdatedNow => 'compartida ahora mismo';

  @override
  String mapUpdatedMinutes(int minutes) {
    return 'compartida hace $minutes min';
  }

  @override
  String mapUpdatedHours(int hours) {
    return 'compartida hace $hours h';
  }

  @override
  String get contactsTitle => 'Contactos';

  @override
  String get contactsSubtitle => 'Todas las personas con las que has chateado';

  @override
  String get contactsSearchHint => 'Buscar contactos…';

  @override
  String get contactsEmptyTitle => 'Aún no hay contactos';

  @override
  String get contactsEmptyHint =>
      'Inicia una conversación y la persona aparecerá aquí.';

  @override
  String get contactsSearchEmpty => 'No se encontraron contactos';

  @override
  String get contactsTabContacts => 'Contactos';

  @override
  String get contactsTabCalls => 'Llamadas';

  @override
  String get callsFilterAll => 'Todas';

  @override
  String get callsFilterMissed => 'Perdidas';

  @override
  String get callsEmptyTitle => 'Aún no hay llamadas';

  @override
  String get callsEmptyHint =>
      'Aquí aparecerán las llamadas entrantes, salientes y perdidas.';

  @override
  String get callsMissedEmpty => 'No hay llamadas perdidas';

  @override
  String get callsCallBack => 'Llamar';

  @override
  String get contactProfileChat => 'Chat';

  @override
  String get contactProfileCall => 'Llamar';

  @override
  String get contactProfileRadio => 'Radio';

  @override
  String get contactProfileSecurity => 'Seguridad';

  @override
  String get contactProfileActions => 'Acciones del contacto';

  @override
  String get contactProfileVerify => 'Verificar';

  @override
  String get contactProfileCopyId => 'Copiar ID del contacto';

  @override
  String get contactProfileIdCopied => 'ID del contacto copiado';

  @override
  String get contactProfileId => 'ID del contacto';

  @override
  String get contactProfileVerifyHint =>
      'Compara las huellas de cifrado para confirmar la identidad de esta persona.';

  @override
  String get chatsTitle => 'Chats';

  @override
  String get chatsSubtitle => 'Mesh · cifrado de extremo a extremo';

  @override
  String get chatsEmptyTitle => 'Aún no hay conversaciones';

  @override
  String get chatsEmptyHint =>
      'Abre un contacto en la pestaña Cerca para empezar a chatear.';

  @override
  String get chatsFilterAll => 'Todos';

  @override
  String get chatsFilterUnread => 'No leídos';

  @override
  String get chatsFilterMesh => 'Mesh';

  @override
  String get chatsFilterFavorites => 'Favoritos';

  @override
  String get chatsFolderDirect => 'Personales';

  @override
  String get chatsFolderChannels => 'Canales';

  @override
  String get chatsFolderOnline => 'Conectados';

  @override
  String get chatsFoldersTitle => 'Carpetas';

  @override
  String get chatsFoldersHint =>
      'Las carpetas son filtros de esta lista, no lugares a los que se mueven los chats. Activa las que quieras ver encima de los chats.';

  @override
  String get chatsSearchHint => 'Buscar chats…';

  @override
  String get chatsStatusViaMesh => 'vía mesh';

  @override
  String get chatsStatusOffline => 'sin conexión';

  @override
  String get peerKeyRotated => 'clave cambiada: vuelve a verificar';

  @override
  String get peersTitle => 'Cerca';

  @override
  String get peersSubtitle => 'Dispositivos al alcance de Bluetooth';

  @override
  String get peersEmpty => 'Buscando dispositivos…';

  @override
  String peersHopsOne(int n) {
    return 'a $n salto';
  }

  @override
  String peersHopsOther(int n) {
    return 'a $n saltos';
  }

  @override
  String get blePermissionTitle => 'Se necesita permiso de Bluetooth';

  @override
  String get blePermissionHint =>
      'Cubechat usa Bluetooth para encontrar dispositivos y enviar mensajes, sin necesidad de internet.';

  @override
  String get blePermissionGrant => 'Dar permiso';

  @override
  String get blePermissionOpenSettings => 'Abrir ajustes';

  @override
  String get blePermissionDeniedHint =>
      'Se denegó el permiso. Abre los ajustes para permitir el acceso a Bluetooth.';

  @override
  String get bleAdapterOffTitle => 'Bluetooth está desactivado';

  @override
  String get bleAdapterOffHint =>
      'Activa Bluetooth para ver dispositivos cercanos.';

  @override
  String get bleUnsupportedTitle => 'Bluetooth LE no disponible';

  @override
  String get bleUnsupportedHint =>
      'Este dispositivo o plataforma no ofrece Bluetooth Low Energy. Pruébalo en un teléfono.';

  @override
  String get bleScanning => 'Buscando…';

  @override
  String get bleRetry => 'Reintentar';

  @override
  String get bleEnable => 'Activar';

  @override
  String get bleConnectFailed =>
      'No se pudo conectar. Es posible que el otro dispositivo esté fuera de alcance o que haya cambiado su dirección Bluetooth.';

  @override
  String get bleSignal => 'Señal';

  @override
  String get bleConnect => 'Conectar';

  @override
  String get bleConnected => 'Conectado';

  @override
  String get bleVerified => 'Verificado';

  @override
  String get editorAdjustBrightness => 'Brillo';

  @override
  String get editorAdjustContrast => 'Contraste';

  @override
  String get editorAdjustSaturation => 'Saturación';

  @override
  String get editorToolCrop => 'Recortar';

  @override
  String get editorToolDraw => 'Dibujar';

  @override
  String get editorToolAdjust => 'Ajustar';

  @override
  String get editorTabSticker => 'Sticker';

  @override
  String get editorTabText => 'Texto';

  @override
  String get editorPenPen => 'Pluma';

  @override
  String get editorPenMarker => 'Marcador';

  @override
  String get editorPenNeon => 'Neón';

  @override
  String get editorPenArrow => 'Flecha';

  @override
  String get editorPenBlur => 'Desenfocar';

  @override
  String get editorPenEraser => 'Borrador';

  @override
  String get editorLevel => 'Nivelar';

  @override
  String get editorTextHint => 'Texto en la foto';

  @override
  String get editorCropFree => 'Libre';

  @override
  String get editorRemove => 'Quitar';

  @override
  String get notificationUnknownSender => 'Nuevo mensaje';

  @override
  String get bleUnknownPeer => 'Dispositivo desconocido';

  @override
  String get bleBroadcasting => 'Emitiendo';

  @override
  String bleConnectedCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n centrales conectados',
      one: '1 central conectado',
      zero: 'Sin centrales',
    );
    return '$_temp0';
  }

  @override
  String get verifyTitle => 'Verificar contacto';

  @override
  String get verifyIntro =>
      'Compara estas dos huellas con tu contacto en persona o en una llamada de voz. Si coinciden en ambos lados, habrás confirmado que nadie manipuló la negociación de Noise.';

  @override
  String get verifyMine => 'TU HUELLA';

  @override
  String verifyTheirs(String name) {
    return 'HUELLA DE $name';
  }

  @override
  String get verifyMarkAsVerified => 'Marcar como verificado';

  @override
  String get verifyAlreadyDone => 'Este contacto está verificado.';

  @override
  String get verifyRevoke => 'Revocar';

  @override
  String verifyDoneSnack(String name) {
    return '$name marcado como verificado';
  }

  @override
  String get chatInputHint => 'Mensaje';

  @override
  String get chatSend => 'Enviar';

  @override
  String get chatToday => 'Hoy';

  @override
  String get chatYesterday => 'Ayer';

  @override
  String get chatDelivered => 'Entregado';

  @override
  String get chatRead => 'Leído';

  @override
  String get chatSending => 'Enviando';

  @override
  String get chatWaitingForConnection => 'Esperando conexión';

  @override
  String sendQueueCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count mensajes esperando conexión',
      one: '1 mensaje esperando conexión',
    );
    return '$_temp0';
  }

  @override
  String sendQueueSlowNetwork(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Red lenta: enviando $count mensajes',
      one: 'Red lenta: enviando 1 mensaje',
    );
    return '$_temp0';
  }

  @override
  String get sendQueueTitle => 'Pendientes de envío';

  @override
  String get sendQueueHint =>
      'Se enviarán solos en cuanto haya un camino: Bluetooth cerca o internet. No hace falta pulsar nada.';

  @override
  String get sendQueueRetry => 'Intentar ahora';

  @override
  String get sendQueueCancel => 'Cancelar envío';

  @override
  String get sendQueueCancelled => 'No enviado: cancelado';

  @override
  String get sendQueueTooLate => 'Demasiado tarde para cancelar: ya se envió';

  @override
  String get chatEncryptedNotice =>
      'Los mensajes están cifrados de extremo a extremo con el protocolo Noise.';

  @override
  String get chatSessionHandshaking => 'Estableciendo canal seguro…';

  @override
  String get chatSessionEstablished => 'Seguro · Noise XX';

  @override
  String get chatSessionFailed => 'Error de conexión';

  @override
  String get presenceOnline => 'en línea';

  @override
  String get presenceOffline => 'sin conexión';

  @override
  String get chatSessionFingerprintPending =>
      'La huella aparecerá cuando termine la negociación.';

  @override
  String get chatEmptyEstablished =>
      'El canal seguro está listo. Envía un mensaje para empezar la conversación.';

  @override
  String get chatEmptyHandshaking =>
      'Esperando a que el otro lado termine la negociación…';

  @override
  String get chatEmptyTitle => 'Aún no hay mensajes';

  @override
  String get chatEmptyGreetHint =>
      'Escribe un mensaje o toca a Kubi para saludar.';

  @override
  String get profileTitle => 'Perfil';

  @override
  String get profileNickname => 'Apodo';

  @override
  String get profileNicknameEditTitle => 'Elige tu apodo';

  @override
  String get profileNicknameHint => 'Cómo te ven los demás en la red mesh';

  @override
  String get profileNicknameSave => 'Guardar';

  @override
  String get profileFingerprint => 'Huella de la clave pública';

  @override
  String get profileLanguage => 'Idioma';

  @override
  String get profileLanguageEn => 'Inglés';

  @override
  String get profileLanguageUk => 'Ucraniano';

  @override
  String get profileTransport => 'Transporte';

  @override
  String get profileTransportMesh => 'Bluetooth mesh';

  @override
  String get profileBackground => 'Disponible en segundo plano';

  @override
  String get profileBackgroundSubtitle =>
      'Seguir recibiendo mensajes con la app cerrada';

  @override
  String get profileBatteryExempt => 'Desactivar optimización de batería';

  @override
  String get profileAbout => 'Acerca de';

  @override
  String profileVersion(String v) {
    return 'Versión $v';
  }

  @override
  String get rotateKeysTitle => 'Cambiar claves de la cuenta';

  @override
  String get rotateKeysHint =>
      'Si perdiste o te robaron un dispositivo con tu cuenta';

  @override
  String get rotateKeysConfirmTitle => '¿Cambiar las claves de tu cuenta?';

  @override
  String get rotateKeysConfirmBody =>
      'Tus contactos recibirán tus nuevas claves y conservarán sus chats, pero a cada uno se le pedirá que vuelva a verificar tus claves. Todos los demás dispositivos de tu cuenta cerrarán sesión; vuelve a vincular los que conserves desde este teléfono. Los contactos con una versión antigua de CubeChat no podrán comunicarse contigo hasta que actualicen. Los canales conservan sus claves.';

  @override
  String get rotateKeysConfirmAction => 'Cambiar claves';

  @override
  String get rotateKeysWorking => 'Cambiando claves…';

  @override
  String rotateKeysDone(int sent, int total) {
    return 'Claves nuevas. Avisados $sent de $total contactos';
  }

  @override
  String get rotateKeysSlow =>
      'Claves nuevas. No todos los contactos confirmaron a tiempo; los relés lo guardan para ellos';

  @override
  String get profileEmergencyWipe => 'Borrado de emergencia';

  @override
  String get profileEmergencyWipeConfirm => '¿Borrar todo?';

  @override
  String get profileEmergencyWipeConfirmHint =>
      'Se eliminarán tu identidad, tu lista de contactos y el historial de conversaciones. No se puede deshacer.';

  @override
  String get profileEmergencyWipeAction => 'Borrar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get copy => 'Copiar';

  @override
  String get copied => 'Copiado';

  @override
  String get channelsNewTitle => 'Nuevo canal';

  @override
  String get channelsNewTooltip => 'Nuevo canal';

  @override
  String get channelNameLabel => 'Nombre del canal';

  @override
  String get channelPasswordLabel => 'Contraseña (opcional)';

  @override
  String get channelJoinAction => 'Unirse';

  @override
  String get channelNameHint =>
      'Quien escriba el mismo nombre y la misma contraseña entra en la misma sala. No hay ningún servidor que guarde una lista de salas.';

  @override
  String get channelPasswordHint =>
      'La contraseña es la clave. Sin ella, la sala está abierta a cualquiera cercano que conozca su nombre.';

  @override
  String get channelSubtitle => 'Canal de grupo · clave compartida';

  @override
  String get channelMute => 'Silenciar';

  @override
  String get channelUnmute => 'Activar sonido';

  @override
  String channelMutedUntil(String time) {
    return 'Silenciado hasta $time';
  }

  @override
  String get channelMuteFor => 'Silenciar durante…';

  @override
  String channelMuteMinutes(int minutes) {
    return '$minutes minutos';
  }

  @override
  String channelMuteHours(int hours) {
    return '$hours horas';
  }

  @override
  String channelMuteDays(int days) {
    return '$days días';
  }

  @override
  String get channelMuteForever => 'Hasta que lo vuelva a activar';

  @override
  String get channelCommunity => 'Comentarios';

  @override
  String get channelCommunityOpen => 'Abrir la conversación';

  @override
  String channelCommunitySubtitle(String channel) {
    return 'Conversación de $channel';
  }

  @override
  String get channelBackToChannel => 'Volver al canal';

  @override
  String get channelMemberActions => 'Miembro';

  @override
  String get channelRemoveMember => 'Quitar del canal';

  @override
  String get channelRemoveMemberHint =>
      'Sus publicaciones dejarán de aceptarse aquí. Nada le impide volver a unirse por el nombre: la clave compartida es la única forma de pertenencia.';

  @override
  String get channelMuteMember => 'Silenciar durante…';

  @override
  String get channelUnmuteMember => 'Permitir que vuelva a publicar';

  @override
  String channelMemberRemoved(String name) {
    return 'Se quitó a $name';
  }

  @override
  String channelMemberMuted(String name) {
    return 'Se silenció a $name';
  }

  @override
  String channelMemberCleared(String name) {
    return '$name puede volver a publicar';
  }

  @override
  String get channelMemberMutedNote => 'Silenciado';

  @override
  String get channelShareHistory => 'Compartir el historial';

  @override
  String get channelShareHistoryHint =>
      'Vuelve a emitir las últimas publicaciones de esta sala para que las vea quien se unió más tarde. Quienes ya estaban aquí no reciben nada nuevo.';

  @override
  String channelHistoryShared(int count) {
    return 'Publicaciones ofrecidas: $count';
  }

  @override
  String get channelHistoryNothing => 'Aún no hay nada que compartir';

  @override
  String get channelHistoryAuto => 'Dar el historial a los nuevos miembros';

  @override
  String get channelHistoryAutoHint =>
      'Cuando aparece alguien nuevo en la sala, se le envían automáticamente las publicaciones recientes. Por ahora solo texto: las fotos se envían por partes y no se pueden repetir sin duplicarlas para todos.';

  @override
  String get channelPostComments => 'Comentarios';

  @override
  String get channelNoComments => 'Aún nadie ha comentado esto';

  @override
  String get channelCommentHint => 'Comentario';

  @override
  String get channelMuteCustom => '¿Durante cuánto tiempo?';

  @override
  String get channelMuteCustomHint => 'Horas';

  @override
  String get chatPinnedManage => 'Fijados';

  @override
  String get chatPeekOpen => 'Abrir chat';

  @override
  String get chatPeekPin => 'Fijar';

  @override
  String get chatPeekUnpin => 'Desfijar';

  @override
  String get chatPeekUnmute => 'Activar sonido';

  @override
  String get chatPeekMarkRead => 'Marcar como leído';

  @override
  String get chatDeleteForMeHint =>
      'Se elimina de este teléfono y se desfija. La otra persona conserva su copia.';

  @override
  String get pushWakeTitle => 'Despertar este teléfono';

  @override
  String get pushWakeHint =>
      'Un pequeño servidor vigila los relés en busca de tu dirección y avisa a este teléfono cuando llega algo, para que la app te avise aunque esté cerrada. Nunca ve un mensaje ni una clave: solo que tu dirección recibió algo y cuándo. El relé ya lo sabe; este sería un segundo sitio que también lo sabe.';

  @override
  String get pushWakeDeniedTitle => 'Las notificaciones están desactivadas';

  @override
  String get pushWakeDeniedHint =>
      'El sistema ya recibió un «no» y no volverá a preguntar, así que solo se puede reactivar en Ajustes: cubechat y luego Notificaciones. Después vuelve aquí.';

  @override
  String get pushWakeRefused => 'No se permitieron las notificaciones';

  @override
  String get privacyForwardLinkTitle => 'Enlace al perfil en reenvíos';

  @override
  String get privacyForwardLinkHint =>
      'Cuando alguien reenvía un mensaje tuyo, la línea encima puede abrir tu perfil. Desactivado, ven tu nombre y nada que tocar. Es una petición a su app, no algo que esta pueda imponer.';

  @override
  String get privacyShareSheetTitle => 'Chats en el menú Compartir';

  @override
  String get privacyShareSheetOnHint =>
      'Los nombres de tus cuatro chats más recientes se envían a Android para que puedas enviarles cosas desde cualquier app. El bloqueo de la app no los oculta.';

  @override
  String get privacyShareSheetOffHint =>
      'No se envía nada a Android. Al compartir en CubeChat, tendrás que elegir el chat.';

  @override
  String get privacyCallsTitle => 'Aceptar llamadas';

  @override
  String get privacyCallsOnHint =>
      'Tus contactos pueden llamarte. Para impedírselo a alguien, abre su perfil.';

  @override
  String get privacyCallsOffHint =>
      'Nadie puede llamarte, excepto las personas a las que lo permitas en su perfil. Una llamada rechazada les aparecerá como ocupado.';

  @override
  String get chatsStatusChannel => 'canal';

  @override
  String get channelInviteTitle => 'Añadir personas';

  @override
  String get channelInviteAction => 'Invitar';

  @override
  String get channelInviteEmpty =>
      'Aún no conoces a nadie. Primero encuentra a alguien en la pestaña Cerca.';

  @override
  String get channelInviteSent => 'Invitaciones enviadas';

  @override
  String get channelInviteNoneSent =>
      'Ahora mismo no se pudo contactar a nadie';

  @override
  String get channelNameTooLong => 'Ese nombre de canal es demasiado largo';

  @override
  String get chatsActionFavorite => 'Añadir a favoritos';

  @override
  String get chatsActionUnfavorite => 'Quitar de favoritos';

  @override
  String get chatsActionDelete => 'Eliminar chat';

  @override
  String get chatsDeleteTitle => '¿Eliminar este chat?';

  @override
  String chatsDeleteManyHint(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Se vaciarán $count conversaciones. Los contactos se conservan, así que podrás volver a escribirles sin intercambiar códigos.',
    );
    return '$_temp0';
  }

  @override
  String get chatsDeletedToast => 'Chat eliminado.';

  @override
  String chatsDeletedManyToast(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count chats eliminados.',
      one: '$count chat eliminado.',
    );
    return '$_temp0';
  }

  @override
  String get undo => 'Deshacer';

  @override
  String get chatsDeletePeerHint =>
      'Se vacía la conversación. El contacto se conserva, así que podrás volver a escribirle sin intercambiar códigos.';

  @override
  String get chatsDeleteChannelHint =>
      'Sales del canal y se elimina su historial. Necesitarás la clave de nuevo para volver a unirte.';

  @override
  String get chatsDeleteForThemToo => 'Eliminar también para la otra persona';

  @override
  String get chatsDeleteForThemHint =>
      'Pide a su app que borre también toda la conversación, incluido lo que escribió. En un canal, solo se retiran tus propios mensajes.';

  @override
  String get chatEditAction => 'Editar';

  @override
  String get chatEditTitle => 'Editar mensaje';

  @override
  String get chatEditSave => 'Guardar';

  @override
  String get chatEdited => 'editado';

  @override
  String get chatDeleteAction => 'Eliminar';

  @override
  String get chatDeleteTitle => '¿Eliminar mensaje?';

  @override
  String get chatDeleteForMe => 'Eliminar para mí';

  @override
  String get chatDeleteForEveryone => 'Eliminar para todos';

  @override
  String get chatPinTitle => '¿Fijar mensaje?';

  @override
  String get chatPinForBoth => 'Fijar para ambos';

  @override
  String get chatPinForMe => 'Fijar solo para mí';

  @override
  String get chatReplyAction => 'Responder';

  @override
  String chatReplyingTo(String name) {
    return 'Respondiendo a $name';
  }

  @override
  String get chatReplyYou => 'ti mismo';

  @override
  String get chatCopyAction => 'Copiar';

  @override
  String get chatCopied => 'Copiado';

  @override
  String get chatForwardAction => 'Reenviar';

  @override
  String get chatForwardTitle => 'Reenviar a';

  @override
  String get shareIntoTitle => 'Enviar a';

  @override
  String get shareNearbyAirDrop => 'Cerca por AirDrop';

  @override
  String get shareNearbyAirDropHint =>
      'Sin internet: a las personas que tienes al lado';

  @override
  String get shareSent => 'Enviado';

  @override
  String get shareFailed => 'No se pudo enviar una parte';

  @override
  String get chatForwardEmpty => 'Aún no hay otros chats';

  @override
  String chatForwardSendCount(int count) {
    return 'Enviar ($count)';
  }

  @override
  String chatForwardSentCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Reenviado a $count chats',
      one: 'Reenviado a un chat',
    );
    return '$_temp0';
  }

  @override
  String chatForwardSent(String name) {
    return 'Reenviado a $name';
  }

  @override
  String chatSentAt(String time) {
    return 'Enviado $time';
  }

  @override
  String chatReadAt(String time) {
    return 'Leído $time';
  }

  @override
  String get chatPinAction => 'Fijar';

  @override
  String get chatUnpinAction => 'Desfijar';

  @override
  String chatPinnedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count mensajes fijados',
      one: '1 mensaje fijado',
      zero: 'No hay mensajes fijados',
    );
    return '$_temp0';
  }

  @override
  String get chatNoPins => 'No hay nada fijado aquí';

  @override
  String get chatUnpinAll => 'Desfijar todos los mensajes';

  @override
  String get chatShowAllPins => 'Todos los mensajes fijados';

  @override
  String get chatUnpinConfirm => '¿Desfijar este mensaje?';

  @override
  String get chatUnpinConfirmHint =>
      'Dejará de estar fijado para todos en este chat.';

  @override
  String get chatPinnedTitle => 'Mensaje fijado';

  @override
  String get chatPinnedGone => 'Ese mensaje ya no está en este chat';

  @override
  String get peerBlock => 'Bloquear';

  @override
  String get peerUnblock => 'Desbloquear';

  @override
  String get peerMute => 'Silenciar';

  @override
  String get peerUnmute => 'Activar sonido';

  @override
  String get peerBlockedNote => 'Bloqueado: sus mensajes se descartan.';

  @override
  String get relaysTitle => 'Respaldo por internet';

  @override
  String get relaysCardTitle => 'Llegar a contactos por internet';

  @override
  String get relaysCardSubtitle =>
      'Si Bluetooth no puede entregar, enviar por relés Nostr';

  @override
  String get relaysExplainer =>
      'Los mensajes siguen cifrados de extremo a extremo: un relé solo transporta la misma trama sellada que transportaría Bluetooth. Pero sí sabe qué dos claves se comunican y cuándo. Desactivado por defecto.';

  @override
  String get relaysMyAddress => 'Tu dirección en los relés';

  @override
  String get relaysCopied => 'Copiado';

  @override
  String get circleLensTitle => 'Cámara frontal para videomensajes';

  @override
  String get circleLensFrontHint =>
      'Los videomensajes redondos se graban con la cámara que te apunta a ti.';

  @override
  String get circleLensBackHint =>
      'Los videomensajes redondos se graban con la cámara trasera, para mostrar lo que estás viendo.';

  @override
  String get channelCloseTitle => 'Cerrar esta sala para todos';

  @override
  String get channelCloseSubtitle =>
      'La elimina del teléfono de cada miembro. Solo tú puedes hacerlo.';

  @override
  String get channelCloseConfirm =>
      'La sala, sus mensajes y sus miembros desaparecerán de todos los teléfonos que la tengan. Nadie queda bloqueado: la clave se deriva del nombre, así que cualquiera que lo recuerde puede volver a abrir una sala vacía.';

  @override
  String get channelCloseAction => 'Cerrar la sala';

  @override
  String get circleHint =>
      'Suelta para enviar · desliza a la izquierda para cancelar';

  @override
  String get circleHintLocked => 'Toca enviar cuando termines';

  @override
  String get circleNeedsCamera =>
      'Los videomensajes necesitan la cámara y el micrófono';

  @override
  String get circleFailed => 'No se pudo grabar el videomensaje';

  @override
  String get relaysListLabel => 'Relés';

  @override
  String get relaysLaneMedia => 'Relés para multimedia';

  @override
  String get relaysLaneMediaNote =>
      'Las fotos, los archivos y los videos van por estos, para que una transferencia no ralentice la conversación.';

  @override
  String get relaysLaneLocation => 'Relés para ubicación';

  @override
  String get relaysLaneLocationNote =>
      'Las balizas del mapa van por estos, separadas de todo lo demás.';

  @override
  String get relaysAdd => 'Añadir relé';

  @override
  String get relaysAddHint => 'wss://relay.example.com';

  @override
  String get relaysInvalidUrl => 'Escribe una dirección wss:// o ws://';

  @override
  String get relaysRemove => 'Quitar';

  @override
  String get relaysStateConnected => 'Conectado';

  @override
  String get relaysStateConnecting => 'Conectando…';

  @override
  String get relaysStateFailed => 'Inaccesible';

  @override
  String get relaysStateIdle => 'Desactivado';

  @override
  String get relaysEmpty =>
      'No hay relés configurados: el respaldo sigue desactivado.';

  @override
  String get contactTitle => 'Tarjeta de contacto';

  @override
  String get contactMineLabel => 'Tu tarjeta';

  @override
  String get contactMineExplainer =>
      'Envíala a alguien que esté fuera del alcance de Bluetooth. Contiene tus claves y tu dirección en los relés: suficiente para que inicie contigo un chat cifrado por internet.';

  @override
  String get contactCopy => 'Copiar';

  @override
  String get contactShare => 'Compartir';

  @override
  String get contactCopied => 'Tarjeta copiada';

  @override
  String get contactShareSubject => 'Mi tarjeta de contacto de cubechat';

  @override
  String get contactAddLabel => 'Añadir a alguien';

  @override
  String get contactAddHint => 'Pega una tarjeta de contacto';

  @override
  String get contactAddAction => 'Añadir';

  @override
  String get contactPaste => 'Pegar';

  @override
  String contactAdded(String name) {
    return '$name añadido';
  }

  @override
  String get contactInvalid => 'No es una tarjeta de contacto válida';

  @override
  String get contactOwnCard => 'Es tu propia tarjeta';

  @override
  String get contactUnverified =>
      'Un contacto añadido así empieza sin verificar. Cualquiera puede crear una tarjeta y ponerle cualquier nombre, así que compara las huellas en persona o en una llamada antes de confiar en su identidad.';

  @override
  String get contactRelayOff =>
      'El respaldo por internet está desactivado, así que una tarjeta aún no puede llegar a nadie.';

  @override
  String get contactRelayEnable => 'Activar';

  @override
  String get profileContactCard => 'Tarjeta de contacto';

  @override
  String get chatsAddContactTooltip => 'Añadir contacto con tarjeta';

  @override
  String get chatsMenuTooltip => 'Más';

  @override
  String get chatsMenuAddContact => 'Añadir contacto';

  @override
  String get chatsMenuNewChannel => 'Nuevo canal';

  @override
  String get profileDiscoverable => 'Visible para cercanos';

  @override
  String get profileDiscoverableOnHint =>
      'Cualquiera al alcance puede encontrarte';

  @override
  String get profileDiscoverableOffHint =>
      'Solo tus contactos pueden contactarte';

  @override
  String get profileDiscoverableExplainer =>
      'Activado, tu anuncio se emite sin cifrar para que desconocidos puedan conocerte al acercarse, y cualquiera que escuche registra tu clave y tu nombre. Desactivado, el mismo paquete va solo a tus contactos, sellado, y tus ID de enrutamiento no se pueden vincular. Entonces las personas nuevas necesitan una tarjeta de contacto.';

  @override
  String get voiceHoldHint => 'Mantén pulsado para grabar un mensaje de voz';

  @override
  String get voiceTrimPlay => 'Reproducir';

  @override
  String get voiceTrimPause => 'Pausa';

  @override
  String get voiceTrimDiscard => 'Descartar grabación';

  @override
  String voiceTrimSelection(String duration) {
    return 'Se enviará $duration';
  }

  @override
  String get profileLastSeen => 'Compartir última conexión';

  @override
  String get profileLastSeenOnHint =>
      'Tus contactos ven cuándo estás en la app';

  @override
  String get profileLastSeenOffHint =>
      'Nadie ve tu hora y tú no ves la de nadie: solo quién está en línea';

  @override
  String get profileMapLocation => 'Mostrarme en el mapa';

  @override
  String get profileMapLocationOnHint =>
      'La ubicación está disponible para compartirla manualmente y tu marcador se muestra en el mapa';

  @override
  String get profileMapLocationOffHint =>
      'La app no solicita la ubicación y tu marcador permanece oculto';

  @override
  String get desktopAutostartTitle => 'Iniciar con Windows';

  @override
  String get desktopAutostartHint =>
      'CubeChat espera en la bandeja del sistema, así las llamadas y los mensajes llegan a esta computadora con la ventana cerrada';

  @override
  String get trayOpen => 'Abrir CubeChat';

  @override
  String get trayQuit => 'Salir';

  @override
  String get callDirectTitle => 'Llamadas directas';

  @override
  String get callDirectOnHint =>
      'Más rápidas, pero la persona a la que llamas conoce tu dirección IP';

  @override
  String get callDirectOffHint =>
      'Las llamadas pasan por nuestro relé: la persona a la que llamas nunca ve tu IP y el relé no puede oír la llamada';

  @override
  String get profileReadReceipts => 'Confirmaciones de lectura';

  @override
  String get profileReadReceiptsOnHint =>
      'Los remitentes ven cuándo leíste sus mensajes';

  @override
  String get profileReadReceiptsOffHint =>
      'Dejas de enviar tu hora de lectura, pero sigues viendo la de los demás';

  @override
  String get profilePrivacyExplainer =>
      'La última conexión funciona en ambos sentidos: si ocultas tu estado, dejas de ver el de los demás. Las confirmaciones de lectura solo controlan lo que tú envías. La entrega de mensajes no cambia.';

  @override
  String get chatTimerAction => 'Temporizador';

  @override
  String get chatTimerRemove => 'Quitar temporizador';

  @override
  String get chatTimerTitle => 'Eliminar este mensaje dentro de';

  @override
  String chatTimerSet(String time) {
    return 'Este mensaje se eliminará en $time';
  }

  @override
  String get chatTimerLocalHint => 'Solo en este dispositivo: su copia es suya';

  @override
  String get contactTagAction => 'Etiqueta';

  @override
  String get contactTagRemove => 'Quitar etiqueta';

  @override
  String get contactTagTitle => 'Elige una etiqueta';

  @override
  String get contactTagAll => 'Todos';

  @override
  String get quietHoursTitle => 'Horas de silencio';

  @override
  String get quietHoursHint =>
      'Los mensajes siguen llegando; el teléfono no suena';

  @override
  String get quietHoursFrom => 'Desde';

  @override
  String get quietHoursTo => 'Hasta';

  @override
  String get notifPreviewTitle => 'Mostrar en notificaciones';

  @override
  String get notifPreviewFull => 'Nombre y texto';

  @override
  String get notifPreviewNameOnly => 'Solo nombre';

  @override
  String get notifPreviewHidden => 'Nada';

  @override
  String get notifPreviewHint =>
      'Las notificaciones se ven en la pantalla de bloqueo y las pueden leer las apps con acceso a notificaciones, incluso con el bloqueo de la app activado';

  @override
  String get notifPreviewNewMessage => 'Nuevo mensaje';

  @override
  String get appLockTitle => 'Bloqueo de la app';

  @override
  String get appLockHint => 'Pedir un código al abrir la app';

  @override
  String get appLockPrompt => 'Introduce tu código';

  @override
  String get appLockUnlock => 'Desbloquear';

  @override
  String get appLockWrong => 'Código incorrecto';

  @override
  String get appLockSetTitle => 'Establecer un código';

  @override
  String get appLockSetHint =>
      'Cuatro dígitos o más. No hay forma de recuperarlo.';

  @override
  String get appLockOffTitle => 'Desactivar el bloqueo';

  @override
  String get appLockOffHint => 'Introduce tu código actual';

  @override
  String get appLockOn => 'El bloqueo de la app está activado';

  @override
  String get appLockOff => 'El bloqueo de la app está desactivado';

  @override
  String get avatarSet => 'Elegir foto';

  @override
  String get avatarChange => 'Cambiar foto';

  @override
  String get avatarView => 'Ver foto';

  @override
  String get profileCoverPhoto => 'Foto de perfil, toca dos veces para ampliar';

  @override
  String get profileCoverMenu => 'Opciones de foto';

  @override
  String get avatarSaved => 'Guardado en la galería';

  @override
  String get avatarRemove => 'Quitar foto';

  @override
  String get avatarRemoveConfirm =>
      'El avatar se eliminará de este dispositivo. En su lugar volverá el degradado generado.';

  @override
  String get avatarFailed => 'No se pudo leer esa imagen';

  @override
  String get fileOpenHint => 'Toca para abrir';

  @override
  String get fileMissing => 'Ese archivo ya no está disponible';

  @override
  String get fileNoHandlerTitle => 'Ninguna app puede abrir esto';

  @override
  String get fileNoHandlerHint =>
      'No hay ninguna app instalada para este tipo de archivo. Puedes enviarlo a otra app.';

  @override
  String get fileRequestedAgain =>
      'Se pidió al remitente que lo envíe de nuevo';

  @override
  String get fileOpenFailed => 'No se pudo abrir este archivo';

  @override
  String get fileShareAction => 'Enviar a una app';

  @override
  String fileTooLargeMesh(int limit) {
    return 'El archivo es demasiado grande: el límite por la red mesh es de $limit MB';
  }

  @override
  String fileTooLargeRelay(int limit) {
    return 'Por internet el límite es de $limit MB. Acércate al destinatario para enviar un archivo más grande.';
  }

  @override
  String get mediaSendOriginal => 'Original';

  @override
  String get attachFile => 'Archivo';

  @override
  String get attachGallery => 'Galería';

  @override
  String get attachCamera => 'Cámara';

  @override
  String get cameraUnavailable => 'Cámara no disponible';

  @override
  String get profileEditName => 'Nombre';

  @override
  String get profileMyCard => 'Tarjeta';

  @override
  String get mediaCaptionHint => 'Añade un pie de foto…';

  @override
  String get mediaDiscardTitle => '¿Descartar la selección?';

  @override
  String get mediaDiscardMessage =>
      '¿Cerrar la galería y descartar las fotos seleccionadas?';

  @override
  String get mediaDiscardConfirm => 'Descartar';

  @override
  String get mediaPhotosAccessOff => 'El acceso a fotos está desactivado';

  @override
  String get mediaPhotosAccessOffHint =>
      'Ahora CubeChat solo puede ver videos. Permite el acceso a fotos en los ajustes del sistema para mostrar tus imágenes.';

  @override
  String get mediaVideosOnly => 'Solo se ven videos: permite el acceso a fotos';

  @override
  String get mediaOpenSettings => 'Abrir ajustes';

  @override
  String get mediaTakePhoto => 'Tomar una foto';

  @override
  String get contactProfileAutoDelete => 'Autoeliminar chat';

  @override
  String get contactProfileAutoDeleteTitle => 'Autoeliminar mensajes';

  @override
  String get contactProfileAutoDeleteOff => 'Desactivado';

  @override
  String get contactProfileAutoDeleteOneDay => 'Después de 1 día';

  @override
  String get contactProfileAutoDeleteSevenDays => 'Después de 7 días';

  @override
  String get contactProfileAutoDeleteThirtyDays => 'Después de 30 días';

  @override
  String contactProfileAutoDeleteUpdated(String period) {
    return 'Autoeliminación: $period';
  }

  @override
  String get contactProfileShare => 'Compartir contacto';

  @override
  String get contactProfileShareTitle => 'Enviar contacto a';

  @override
  String get contactProfileShareEmpty => 'Aún no hay otros chats';

  @override
  String contactProfileShareSent(String name) {
    return 'Enviado a $name';
  }

  @override
  String get contactProfileRestrictCopying => 'Desactivar copia';

  @override
  String get contactProfileAllowCopying => 'Permitir copia';

  @override
  String get contactHideAvatar => 'Ocultar mi foto';

  @override
  String get contactShowAvatar => 'Mostrar mi foto';

  @override
  String get contactHideLastSeen => 'Ocultar mi última conexión';

  @override
  String get contactShowLastSeen => 'Mostrar mi última conexión';

  @override
  String get contactHideReadReceipts => 'Ocultar mis horas de lectura';

  @override
  String get contactShowReadReceipts => 'Mostrar mis horas de lectura';

  @override
  String get contactHiddenFromThem => 'Oculto para este contacto';

  @override
  String get contactRefuseCalls => 'No aceptar sus llamadas';

  @override
  String get contactAllowCalls => 'Aceptar sus llamadas';

  @override
  String get contactCallsException => 'Una excepción a tu ajuste de llamadas';

  @override
  String get contactProfileCopyingRestricted =>
      'Copiar y reenviar están desactivados';

  @override
  String get contactProfileCopyingRestrictedByPeer =>
      'Desactivado por la otra persona';

  @override
  String get contactProfileCopyingAllowed =>
      'Copiar y reenviar están permitidos';

  @override
  String get contactProfileDelete => 'Eliminar de contactos';

  @override
  String get contactProfileRestore => 'Volver a añadir a contactos';

  @override
  String get contactProfileRestoreDone => 'De nuevo en tus contactos';

  @override
  String get contactProfileDeleteTitle => '¿Eliminar contacto?';

  @override
  String contactProfileDeleteMessage(String name) {
    return '$name desaparecerá de Contactos. El historial del chat se queda en este dispositivo.';
  }

  @override
  String get contactProfileMedia => 'Multimedia';

  @override
  String get contactProfileVoiceMessages => 'Mensajes de voz';

  @override
  String get contactProfileStickers => 'Stickers';

  @override
  String get contactProfileNoStickers => 'Aún no hay stickers';

  @override
  String get contactProfileNoMedia => 'Aún no hay multimedia';

  @override
  String get contactProfileNoVoiceMessages => 'Aún no hay mensajes de voz';

  @override
  String get contactProfileOpen => 'Abrir perfil';

  @override
  String autoDeleteDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count días',
      one: '$count día',
    );
    return '$_temp0';
  }

  @override
  String autoDeleteHours(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count horas',
      one: '$count hora',
    );
    return '$_temp0';
  }

  @override
  String autoDeleteMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count minutos',
      one: '$count minuto',
    );
    return '$_temp0';
  }

  @override
  String autoDeleteSeconds(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count segundos',
      one: '$count segundo',
    );
    return '$_temp0';
  }

  @override
  String get autoDeleteCustom => 'Personalizado…';

  @override
  String get autoDeleteCustomHint => 'Cantidad';

  @override
  String get autoDeleteUnitMinutes => 'min';

  @override
  String get autoDeleteUnitHours => 'horas';

  @override
  String get autoDeleteUnitDays => 'días';

  @override
  String get contactProfileAutoDeleteSet => 'Aplicar';

  @override
  String get contactProfileFiles => 'Archivos';

  @override
  String get contactProfileNoFiles => 'Aún no hay archivos';

  @override
  String get contactProfileLinks => 'Enlaces';

  @override
  String get contactProfileNoLinks => 'Aún no hay enlaces';

  @override
  String get contactProfilePolls => 'Encuestas';

  @override
  String get contactProfileNoPolls => 'Aún no hay encuestas';

  @override
  String get presenceRecently => 'últ. vez hace poco';

  @override
  String get presenceJustNow => 'justo ahora';

  @override
  String presenceHoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'hace $count horas',
      one: 'hace $count hora',
    );
    return '$_temp0';
  }

  @override
  String presenceYesterdayAt(String time) {
    return 'ayer a las $time';
  }

  @override
  String presenceOnWeekday(String day) {
    String _temp0 = intl.Intl.selectLogic(
      day,
      {
        '1': 'el lunes',
        '2': 'el martes',
        '3': 'el miércoles',
        '4': 'el jueves',
        '5': 'el viernes',
        '6': 'el sábado',
        '7': 'el domingo',
        'other': 'esta semana',
      },
    );
    return '$_temp0';
  }

  @override
  String presenceWeeksAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'hace $count semanas',
      one: 'hace una semana',
    );
    return '$_temp0';
  }

  @override
  String presenceMonthsAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'hace $count meses',
      one: 'hace un mes',
    );
    return '$_temp0';
  }

  @override
  String get presenceLongAgo => 'hace mucho tiempo';

  @override
  String presenceMinutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'hace $count minutos',
      one: 'hace $count minuto',
    );
    return '$_temp0';
  }

  @override
  String chatReadByCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Leído por $count',
      one: 'Leído por $count',
    );
    return '$_temp0';
  }

  @override
  String get chatsSearchFrequent => 'Con quién hablas';

  @override
  String get chatsSearchRecent => 'Recientes';

  @override
  String get chatsSearchClear => 'Borrar';

  @override
  String get chatsSearchStartHint =>
      'Busca chats por nombre o cualquier mensaje por sus palabras.';

  @override
  String get chatsSearchEmpty => 'No hay coincidencias';

  @override
  String get chatRoutesTitle => 'Cómo le llega esto';

  @override
  String get chatRoutesBluetoothHint => 'Directo a su teléfono, sin internet';

  @override
  String get chatRoutesMeshHint =>
      'Lo pasan los teléfonos que hay entre los dos';

  @override
  String get chatRoutesInternetHint =>
      'A través de un relé, cuando no hay nadie al alcance';

  @override
  String get chatRoutesHint =>
      'El camino se elige para cada mensaje, según lo que esté disponible en ese momento.';

  @override
  String get chatRoutesPreferTitle => 'Qué probar primero';

  @override
  String get chatRoutesPreferMesh => 'Primero Bluetooth';

  @override
  String get chatRoutesPreferMeshHint =>
      'Más rápido en la misma sala, no gasta datos y no le dice nada a un relé';

  @override
  String get chatRoutesPreferRelay => 'Primero internet';

  @override
  String get chatRoutesPreferRelayHint =>
      'Para un Bluetooth débil y una buena conexión';

  @override
  String get chatRoutesPreferNote =>
      'Es una preferencia, no un bloqueo. Si el camino elegido no está disponible, el otro igualmente lleva el mensaje.';

  @override
  String get deadmanTitle => 'Borrar si no se usa';

  @override
  String get deadmanOff => 'Desactivado';

  @override
  String deadmanDays(int days) {
    return 'Después de $days días';
  }

  @override
  String get deadmanHint =>
      'Si nadie abre esta app durante ese tiempo, todo lo que contiene se borrará la próxima vez que se abra. No puede avisarte antes: de eso se trata.';

  @override
  String chatForwardedFrom(String name) {
    return 'Reenviado de $name';
  }

  @override
  String appLockWait(String left) {
    return 'Demasiados intentos: espera $left';
  }

  @override
  String get appLockGraceTitle => 'Pedir el código';

  @override
  String get appLockGraceNow => 'Siempre';

  @override
  String appLockGraceAfter(String left) {
    return 'Tras $left fuera';
  }

  @override
  String get chatCalendarTitle => 'Por fecha';

  @override
  String get chatCalendarEmpty => 'Aún no se ha dicho nada aquí';

  @override
  String get chatsSearchChatsSection => 'Chats';

  @override
  String get chatsSearchMessagesSection => 'Mensajes';

  @override
  String get contactProfileViewInChat => 'Ver en el chat';

  @override
  String get chatDraft => 'Borrador';

  @override
  String get chatSearchTitle => 'Buscar';

  @override
  String get chatSearchHint => 'Buscar mensajes';

  @override
  String get chatSearchNoResults => 'Sin coincidencias';

  @override
  String get chatSearchPrevious => 'Resultado anterior';

  @override
  String get chatSearchNext => 'Resultado siguiente';

  @override
  String chatMessageCount(int count) {
    return '$count mensajes';
  }

  @override
  String get chatRouteBluetooth => 'Bluetooth';

  @override
  String get chatRouteMesh => 'Mesh';

  @override
  String get chatRouteInternet => 'Internet';

  @override
  String get chatRouteQueued => 'En cola';

  @override
  String get attachStickers => 'Stickers';

  @override
  String get stickersEmpty => 'Aún no hay stickers';

  @override
  String get stickersEmptyHint =>
      'Guarda una imagen de un chat y aparecerá aquí.';

  @override
  String get stickerKeep => 'Guardar como sticker';

  @override
  String get stickerKept => 'Guardado en tus stickers';

  @override
  String get stickerForget => 'Quitar sticker';

  @override
  String get stickerCreate => 'Crear un sticker con una foto';

  @override
  String get stickerFailed => 'No se pudo convertir esa imagen en sticker';

  @override
  String get stickerLabel => 'Sticker';

  @override
  String get previewPhoto => 'Foto';

  @override
  String get previewVoice => 'Mensaje de voz';

  @override
  String get previewFile => 'Archivo';

  @override
  String get stickerEmojiTitle => 'Elige un emoji para él';

  @override
  String get stickersMine => 'Mis stickers';

  @override
  String get stickersStarterPack => 'Cubi';

  @override
  String get emojiTab => 'Emoji';

  @override
  String get chatBlockedStatus => 'bloqueado';

  @override
  String get chatBlockedHint => 'Bloqueaste a esta persona';

  @override
  String get chatRouteFallbackOff => 'Internet desact.';

  @override
  String get chatAttachmentUnavailable =>
      'No hay ninguna conexión disponible. Conéctate por Bluetooth o internet e inténtalo de nuevo.';

  @override
  String get fileTransfersTitle => 'Transferencias de archivos';

  @override
  String get fileTransfersClear => 'Borrar historial';

  @override
  String get fileTransfersEmpty => 'Aún no hay transferencias de archivos';

  @override
  String get fileTransfersActive => 'Activas';

  @override
  String get fileTransfersHistory => 'Historial';

  @override
  String get fileTransferPause => 'Pausar';

  @override
  String get fileTransferResume => 'Reanudar';

  @override
  String get fileTransferRetry => 'Reintentar';

  @override
  String get fileTransferQueued => 'Esperando conexión';

  @override
  String get fileTransferRunning => 'Transfiriendo';

  @override
  String get fileTransferPaused => 'En pausa';

  @override
  String get fileTransferCompleted => 'Completada';

  @override
  String get fileTransferFailed => 'Error';

  @override
  String get fileTransferCanceled => 'Cancelada';

  @override
  String get profileFileTransfers => 'Transferencias de archivos';

  @override
  String get profileFileTransfersSubtitle =>
      'Progreso, cola e historial de transferencias';

  @override
  String get qrScanAction => 'Escanear código QR';

  @override
  String get qrScanTitle => 'Escanear código QR';

  @override
  String get qrScanHint =>
      'Escanea un código de CubeChat de contacto, canal, transferencia de cuenta o inicio de sesión en una computadora.';

  @override
  String get qrFlash => 'Linterna';

  @override
  String get qrCameraError =>
      'La cámara no está disponible. Revisa el permiso de cámara e inténtalo de nuevo.';

  @override
  String get qrInvalid => 'No es un código QR de Cubechat válido.';

  @override
  String qrChannelAdded(String name) {
    return '$name añadido';
  }

  @override
  String get qrShow => 'Mostrar código QR';

  @override
  String qrChannelTitle(String name) {
    return 'Unirse a $name';
  }

  @override
  String get profileBackup => 'Copia de seguridad cifrada';

  @override
  String get profileBackupSubtitle =>
      'Traslada claves, contactos e historial de forma segura';

  @override
  String get backupTitle => 'Copia de seguridad cifrada';

  @override
  String get backupExplainer =>
      'La copia de seguridad contiene tus claves privadas de identidad, contactos, canales, ajustes e historial de mensajes. Se cifra en este teléfono con la contraseña que elijas; Cubechat no puede recuperar una contraseña olvidada.';

  @override
  String get backupCreate => 'Crear copia';

  @override
  String get backupCreateSubtitle =>
      'Cifrar todo y guardar un archivo .cchatbackup';

  @override
  String get backupRestore => 'Restaurar copia';

  @override
  String get backupRestoreSubtitle =>
      'Reemplazar el perfil de Cubechat de este teléfono con un archivo de copia';

  @override
  String get backupPasswordTitle => 'Contraseña de la copia';

  @override
  String get backupPasswordHint => 'Al menos 8 caracteres';

  @override
  String get backupConfirmPassword => 'Repite la contraseña';

  @override
  String get backupPasswordMismatch => 'Las contraseñas no coinciden';

  @override
  String get backupPasswordShort => 'Usa al menos 8 caracteres';

  @override
  String get backupSaveTitle => 'Guardar copia de seguridad de Cubechat';

  @override
  String get backupSaved => 'Copia de seguridad cifrada guardada';

  @override
  String get backupWhereTitle => '¿Dónde guardar la copia?';

  @override
  String get backupSaveToFiles => 'Guardar en Archivos';

  @override
  String get backupSaveToFilesHint =>
      'Una carpeta del teléfono, una tarjeta de memoria o una nube';

  @override
  String get backupSendToApp => 'Enviar a una app';

  @override
  String get backupSendToAppHint =>
      'Telegram, correo, un mensajero: cualquier app que acepte archivos';

  @override
  String get backupFailed =>
      'No se pudo completar la operación de copia de seguridad';

  @override
  String get backupRestoreConfirmTitle => '¿Reemplazar este perfil?';

  @override
  String get backupRestoreConfirmMessage =>
      'Las claves, contactos, canales, ajustes e historial actuales de este teléfono se reemplazarán por la copia de seguridad seleccionada.';

  @override
  String get backupRestoreConfirmAction => 'Restaurar';

  @override
  String get backupRestored => 'Copia de seguridad restaurada';

  @override
  String get backupPackingWait => 'Creando la copia de seguridad…';

  @override
  String get backupUnpackingWait => 'Restaurando la copia de seguridad…';

  @override
  String get backupWaitHint =>
      'Con fotos y videos puede tardar unos minutos. Mantén la app abierta.';

  @override
  String get backupInvalid =>
      'Contraseña incorrecta, archivo dañado o copia no compatible';

  @override
  String get channelInfoTitle => 'Información del canal';

  @override
  String get channelParticipantsTitle => 'Participantes';

  @override
  String get channelAdministratorsTitle => 'Administradores';

  @override
  String get channelMakeAdmin => 'Hacer administrador';

  @override
  String get channelRemoveAdmin => 'Quitar como administrador';

  @override
  String get channelNoParticipants =>
      'Los participantes aparecerán tras actividad firmada';

  @override
  String get channelSharedContent => 'Multimedia, archivos y encuestas';

  @override
  String get channelDescriptionTitle => 'Descripción';

  @override
  String get channelDescriptionEmpty => 'Aún no hay descripción';

  @override
  String get channelDescriptionHint => 'Para qué es este canal';

  @override
  String get channelDescriptionAdminOnly =>
      'Solo un administrador puede cambiar la descripción';

  @override
  String get channelDescriptionSave => 'Guardar';

  @override
  String get channelPrivateSubtitle => 'canal privado';

  @override
  String get channelAvatarSet => 'Poner una foto nueva';

  @override
  String get channelSettingsTitle => 'Ajustes del canal';

  @override
  String get channelSettingsHint => 'Quién publica, copia, historial';

  @override
  String get channelLeaveAction => 'Salir';

  @override
  String get channelLeaveConfirm =>
      'La sala y todo lo dicho en ella desaparecerán de este teléfono. La clave se deriva del nombre, así que puedes volver a abrirla escribiendo el mismo.';

  @override
  String get channelShareAction => 'Compartir';

  @override
  String channelMembersOf(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count miembros',
      one: '1 miembro',
    );
    return '$_temp0';
  }

  @override
  String get chatTyping => 'escribiendo…';

  @override
  String get chatRecordingVoice => 'grabando un mensaje de voz…';

  @override
  String get chatRecordingCircle => 'grabando un videomensaje…';

  @override
  String get chatSendingPhoto => 'enviando una foto…';

  @override
  String get chatSendingVideo => 'enviando un video…';

  @override
  String get chatSendingFile => 'enviando un archivo…';

  @override
  String get onboardingMeshTitle => 'Funciona sin internet';

  @override
  String get onboardingMeshBody =>
      'Los mensajes viajan por Bluetooth, de teléfono a teléfono. Sin señal, sin Wi-Fi, sin cuentas: solo las personas que te rodean.';

  @override
  String get onboardingRelayTitle => 'Y con internet, cuando lo hay';

  @override
  String get onboardingRelayBody =>
      'Fuera del alcance de Bluetooth, los mensajes van por internet y llegan igual. Nunca tienes que elegir.';

  @override
  String get onboardingPrivacyTitle => 'Nadie en medio puede leerlo';

  @override
  String get onboardingPrivacyBody =>
      'Todo está cifrado de extremo a extremo y tu identidad es una clave en este teléfono: no un número de teléfono, ni un correo, ni una cuenta que alguien te pueda quitar.';

  @override
  String get onboardingSkip => 'Omitir';

  @override
  String get onboardingNext => 'Siguiente';

  @override
  String get onboardingStart => 'Empezar';

  @override
  String get chatMediaShare => 'Compartir';

  @override
  String get chatMediaSaveToGallery => 'Guardar en la galería';

  @override
  String get chatMediaShowInChat => 'Mostrar en el chat';

  @override
  String get chatWallpaperTitle => 'Fondo de pantalla';

  @override
  String get chatWallpaperClear => 'Restablecer';

  @override
  String get chatWallpaperDim => 'Oscurecer detrás de los mensajes';

  @override
  String get chatSelectAction => 'Seleccionar';

  @override
  String get chatForwardNothing => 'Aquí no hay nada que se pueda reenviar';

  @override
  String chatSelectedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count seleccionados',
      one: '1 seleccionado',
    );
    return '$_temp0';
  }

  @override
  String chatDeleteSelectedTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '¿Eliminar $count mensajes?',
      one: '¿Eliminar este mensaje?',
    );
    return '$_temp0';
  }

  @override
  String get contactAliasAction => 'Renombrar contacto';

  @override
  String get contactAliasHint =>
      'Solo tú ves este nombre. Déjalo vacío para usar el suyo.';

  @override
  String get viewOnceSendLabel => 'Ver una vez';

  @override
  String get viewOnceTitle => 'Ver una vez';

  @override
  String get viewOnceTapToView => 'Foto · toca para verla una vez';

  @override
  String get viewOnceSent => 'Foto · enviada';

  @override
  String get viewOnceOpened => 'Foto abierta';

  @override
  String get viewOnceUnavailable => 'Esta foto ya no está disponible';

  @override
  String get viewOnceWarning => 'Al cerrar, la foto se eliminará para ambos.';

  @override
  String get channelAvatarAdminOnly =>
      'Solo un administrador puede cambiar la foto del canal';

  @override
  String get channelAdminOnly => 'Solo un administrador puede cambiar esto';

  @override
  String get channelAvatarTooLarge =>
      'Esa foto es demasiado grande para difundirla';

  @override
  String get channelMemberUnknown => 'Aún no está en tus contactos';

  @override
  String get channelInviteToContacts => 'Enviarle tu tarjeta de contacto';

  @override
  String channelContactInviteSent(String name) {
    return 'Tarjeta de contacto ofrecida a $name';
  }

  @override
  String get chatContactInvitation => 'Invitación para conectar';

  @override
  String get chatContactInvitationForYou => 'Invitación para ti';

  @override
  String get channelPollTitle => 'Encuesta';

  @override
  String get channelCreatePoll => 'Crear encuesta';

  @override
  String get channelPollQuestion => 'Pregunta';

  @override
  String channelPollOption(int number) {
    return 'Opción $number';
  }

  @override
  String get channelPollAddOption => 'Añadir opción';

  @override
  String get channelPollCreate => 'Publicar encuesta';

  @override
  String channelPollVotes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count votos',
      one: '1 voto',
      zero: 'Sin votos',
    );
    return '$_temp0';
  }

  @override
  String get phoneTransferTitle => 'Transferir a un teléfono nuevo';

  @override
  String get desktopPickChat => 'Elige a quién quieres escribir';

  @override
  String get desktopListCollapse => 'Mostrar solo avatares';

  @override
  String get desktopListExpand => 'Mostrar la lista de chats';

  @override
  String get desktopLinkConnectTitle => 'Conectar una computadora';

  @override
  String get desktopLinkConnectHint =>
      'Escanea el código que muestra CubeChat en la computadora';

  @override
  String get desktopLinkSignIn => 'Iniciar sesión con la cuenta de mi teléfono';

  @override
  String get desktopLinkTitle => 'Inicia sesión con tu teléfono';

  @override
  String get desktopLinkSteps =>
      'En el teléfono: Perfil → Datos y almacenamiento → Conectar una computadora y escanea este código. Ambos deben estar en la misma red Wi-Fi.';

  @override
  String get desktopLinkLimits =>
      'El teléfono sigue funcionando. Los mensajes de internet llegan a ambos; lo que envías desde uno aún no aparece en el otro.';

  @override
  String get desktopLinkWaiting => 'Esperando al teléfono…';

  @override
  String get desktopLinkFailed =>
      'No se pudo recibir la cuenta. Inténtalo de nuevo.';

  @override
  String get desktopLinkRetry => 'Reintentar';

  @override
  String get desktopLinkConfirmTitle =>
      '¿Enviar una copia de esta cuenta a la computadora?';

  @override
  String get desktopLinkConfirmMessage =>
      'La computadora recibirá tus claves, contactos y chats. Este teléfono sigue funcionando igual.';

  @override
  String get desktopLinkConfirmAction => 'Enviar';

  @override
  String desktopLinkConfirmWhere(String address) {
    return 'Solo si acabas de escanear este código en la pantalla de tu propia computadora. Se enviará a $address en esta red.';
  }

  @override
  String get desktopLinkSending => 'Enviando la cuenta…';

  @override
  String get desktopLinkSent => 'La computadora está conectada';

  @override
  String get desktopLinkPhoneFound =>
      'El teléfono encontró esta computadora y está haciendo una copia de la cuenta. Con fotos puede tardar unos minutos.';

  @override
  String desktopLinkReceiving(int percent) {
    return 'Recibiendo la cuenta: $percent%';
  }

  @override
  String get desktopLinkRestoring =>
      'Instalando la cuenta en esta computadora…';

  @override
  String get desktopLinkFinding => 'Buscando la computadora…';

  @override
  String get desktopLinkPreparing =>
      'Haciendo una copia de la cuenta. Con fotos puede tardar unos minutos.';

  @override
  String desktopLinkSendingPercent(int percent) {
    return 'Enviando: $percent%';
  }

  @override
  String get desktopLinkComputerRestoring =>
      'La computadora está instalando la cuenta…';

  @override
  String get devicesTitle => 'Dispositivos';

  @override
  String get devicesRowHint =>
      'Dónde está abierta tu cuenta y cerrar sesión allí';

  @override
  String get devicesThisDevice => 'Este dispositivo';

  @override
  String get devicesSeenNow => 'En línea hace un momento';

  @override
  String devicesSeenMinutes(int n) {
    return 'En línea hace $n min';
  }

  @override
  String devicesSeenHours(int n) {
    return 'En línea hace $n h';
  }

  @override
  String devicesSeenDays(int n) {
    return 'En línea hace $n d';
  }

  @override
  String get devicesLeaving => 'Cerrando sesión: esperando a que se conecte';

  @override
  String get devicesSignOut => 'Cerrar sesión';

  @override
  String get devicesSignOutAll =>
      'Cerrar sesión en todos los demás dispositivos';

  @override
  String devicesSignOutTitle(String name) {
    return '¿Cerrar sesión en \"$name\"?';
  }

  @override
  String get devicesSignOutMessage =>
      'Las claves, chats y ajustes de CubeChat se borrarán en ese dispositivo en cuanto se conecte. La cuenta se queda aquí y en tus otros dispositivos.';

  @override
  String get devicesSignOutPhoneMessage =>
      'Es un teléfono: CubeChat se borrará por completo en él. La cuenta se queda aquí y en tus otros dispositivos.';

  @override
  String get devicesSignOutAllMessage =>
      'Todos los demás dispositivos cerrarán sesión en cuanto se conecten. La cuenta quedará solo aquí.';

  @override
  String get devicesRename => 'Renombrar';

  @override
  String get devicesRenameTitle => 'Nombre de este dispositivo';

  @override
  String get devicesSave => 'Guardar';

  @override
  String get devicesEmpty =>
      'Aún no hay otros dispositivos. Un dispositivo aparece aquí cuando abre CubeChat 1.0.0+1147 o posterior.';

  @override
  String get devicesCaveat =>
      'El cierre de sesión se aplica cuando ese dispositivo se conecta. Uno que se mantenga sin conexión conserva sus claves; la protección total implicaría nuevas claves para la cuenta.';

  @override
  String get desktopLinkImportTitle => 'Traer la cuenta desde tu teléfono';

  @override
  String get desktopLinkImportHint =>
      'Muestra un código al teléfono y esta computadora se convertirá en una copia de su cuenta';

  @override
  String get desktopLinkImportConfirmTitle =>
      '¿Reemplazar la cuenta en esta computadora?';

  @override
  String get desktopLinkImportConfirmMessage =>
      'Las claves, contactos y chats de esta computadora se reemplazarán por la cuenta del teléfono. Si aún necesitas esta, haz primero una copia de seguridad.';

  @override
  String get desktopLinkImportConfirmAction => 'Continuar';

  @override
  String get desktopLinkUnreachable =>
      'No se pudo contactar con la computadora. Ambos deben estar en la misma red Wi-Fi y, en la computadora, CubeChat debe estar permitido en el firewall.';

  @override
  String get desktopLinkFirewallHint =>
      'Windows puede impedir que el teléfono llegue a esta computadora. Permite CubeChat en el firewall, solo para tu red local.';

  @override
  String get desktopLinkFirewallAllow => 'Permitir en el firewall';

  @override
  String get desktopLinkFirewallDeclined =>
      'Windows no lo permitió. Sin eso, puede que el teléfono no consiga conectarse.';

  @override
  String get phoneTransferIntro =>
      'Traslada tu perfil, claves, contactos, canales, ajustes e historial directamente entre dos teléfonos.';

  @override
  String get phoneTransferSend => 'Este es el teléfono antiguo';

  @override
  String get phoneTransferReceive => 'Este es el teléfono nuevo';

  @override
  String get phoneTransferSameWifi =>
      'Conecta ambos teléfonos a la misma red Wi-Fi. Mantén esta pantalla abierta hasta que termine la transferencia.';

  @override
  String get phoneTransferPreparing => 'Preparando la transferencia cifrada…';

  @override
  String get phoneTransferReady =>
      'Escanea este código QR de un solo uso en el teléfono nuevo';

  @override
  String get phoneTransferScan => 'Escanear el teléfono antiguo';

  @override
  String get phoneTransferConfirmTitle =>
      '¿Reemplazar el perfil de este teléfono?';

  @override
  String get phoneTransferConfirmMessage =>
      'El perfil guardado ahora en este teléfono se reemplazará por la transferencia local cifrada.';

  @override
  String get phoneTransferConfirmAction => 'Transferir perfil';

  @override
  String get phoneTransferSuccess => 'Perfil transferido correctamente';

  @override
  String get phoneTransferFailed =>
      'No se pudo completar la transferencia entre teléfonos';

  @override
  String get profileSummaryMeshOnly => 'Solo mesh';

  @override
  String get profileSummaryMeshInternet => 'Mesh · internet';

  @override
  String get profileSummaryBackgroundOn => 'en segundo plano';

  @override
  String profileSummaryTransfersActive(int count) {
    return '$count en curso';
  }

  @override
  String get profileSummaryCardBackup => 'Archivos, copia';

  @override
  String get chatPlay => 'Reproducir';

  @override
  String get chatPause => 'Pausa';

  @override
  String get profileTheme => 'Color';

  @override
  String get profileThemeEmerald => 'Esmeralda';

  @override
  String get profileThemeIndigo => 'Índigo';

  @override
  String get profileThemeAmber => 'Ámbar';

  @override
  String get profileThemeRose => 'Rosa';

  @override
  String get profileThemeFuchsia => 'Fucsia';

  @override
  String get profileThemeViolet => 'Violeta';

  @override
  String get profileThemeOcean => 'Océano';

  @override
  String get profileThemeSlate => 'Pizarra';

  @override
  String get profileScale => 'Tamaño de la interfaz';

  @override
  String get profileScaleSystem => 'Sistema';

  @override
  String get profileGlass => 'Cristal';

  @override
  String get profileGlassAuto => 'Automático';

  @override
  String get profileGlassFull => 'Completo';

  @override
  String get profileGlassLight => 'Ligero';

  @override
  String get profileGlassHint =>
      'Ligero conserva el tinte y quita el desenfoque detrás de los paneles. Automático mide tu teléfono una vez y decide. En un teléfono que ya va fluido apenas aporta nada: es para uno que no lo consigue.';

  @override
  String get mapAlwaysNeeded =>
      'Para que el mapa siga actualizándose con cubechat cerrado, la ubicación debe estar en «Siempre». Toca para abrir Ajustes.';

  @override
  String get mapShareConsentTitle => '¿Mostrar tu ubicación en el mapa?';

  @override
  String get mapShareConsentBody =>
      'Tu ubicación en tiempo real solo la verán los contactos de tu mapa: las personas que invitaste o cuya invitación aceptaste. Se sigue actualizando, también con Cubechat en segundo plano, hasta que te ocultes. Está cifrada de extremo a extremo y nunca llega a nosotros. Puedes ocultarte en cualquier momento en el mapa o en Perfil, y los contactos que bloquees nunca te ven.';

  @override
  String get mapShareConsentAllow => 'Permitir';

  @override
  String get mapShareConsentDecline => 'No permitir';

  @override
  String get mapVisibleToFriends => 'Tus amigos del mapa te ven';

  @override
  String get mapHiddenFromFriends => 'Estás oculto';

  @override
  String get mapHideMe => 'Ocultarme';

  @override
  String get mapShowMe => 'Mostrarme';

  @override
  String get profileScaleSmall => 'Más pequeño';

  @override
  String get profileScaleNormal => 'Normal';

  @override
  String get profileScaleLarge => 'Más grande';

  @override
  String get profileScaleSample =>
      'El texto y las filas se muestran con este tamaño.';

  @override
  String get savedTitle => 'Guardados';

  @override
  String get savedSubtitle => 'Notas para ti, en este dispositivo';

  @override
  String get savedEmpty =>
      'Todo lo que escribas aquí se queda en este teléfono.';

  @override
  String get meshOffTitle => 'La red mesh Bluetooth está desactivada';

  @override
  String get meshOffHint =>
      'Nadie cerca puede encontrarte y tú tampoco a ellos. Los mensajes siguen viajando por el relé de internet.';

  @override
  String get profileMeshSwitch => 'Red mesh Bluetooth';

  @override
  String get profileMeshSwitchHint =>
      'Encuentra a personas cerca y transmite mensajes sin internet. Desactivado ahorra batería.';

  @override
  String get channelAdminOnlyHint =>
      'Un canal de anuncios. Todos pueden leerlo.';

  @override
  String get attachLocation => 'Ubicación';

  @override
  String get locationBubbleTitle => 'Ubicación';

  @override
  String get locationOpenInMaps => 'Abrir en mapas';

  @override
  String locationAccuracy(int metres) {
    return 'con precisión de $metres m';
  }

  @override
  String get locationExpired => 'Esta ubicación ya no está actualizada';

  @override
  String get locationDenied => 'El permiso de ubicación está desactivado';

  @override
  String get locationUnavailable => 'No se pudo obtener la ubicación';

  @override
  String get locationShareFor => 'Compartir durante';

  @override
  String get locationShareOnce => 'Solo una vez';

  @override
  String get locationShare15m => '15 minutos';

  @override
  String get locationShare1h => '1 hora';

  @override
  String get storageTitle => 'Almacenamiento';

  @override
  String get storageHeadline => 'Uso del almacenamiento';

  @override
  String storageSubtitle(String size) {
    return 'cubechat ocupa $size en este dispositivo';
  }

  @override
  String get storageEmpty => 'Aún no hay nada guardado';

  @override
  String get storageScanning => 'Calculando…';

  @override
  String get storageCatPhotos => 'Fotos';

  @override
  String get storageCatVoice => 'Mensajes de voz';

  @override
  String get storageCatFiles => 'Archivos recibidos';

  @override
  String get storageCatOutbox => 'Archivos enviados';

  @override
  String get storageCatStickers => 'Stickers';

  @override
  String get storageCatSaved => 'Mensajes guardados';

  @override
  String get storageCatWallpapers => 'Fondos de pantalla';

  @override
  String get storageCatHistory => 'Conversaciones y claves';

  @override
  String get storageCatCache => 'Caché';

  @override
  String storageClear(String size) {
    return 'Liberar $size';
  }

  @override
  String get storageClearNothing => 'Nada seleccionado';

  @override
  String storageFreed(String size) {
    return 'Liberados $size';
  }

  @override
  String get storageNoCloud =>
      'No hay ninguna nube detrás. Lo que borres desaparece de este teléfono, y la única otra copia está en el teléfono del que vino.';

  @override
  String get storageWhyHistoryLocked =>
      'Las conversaciones no se borran desde aquí: usa el Borrado de emergencia.';

  @override
  String get storageRecoveryFree => 'Se puede borrar sin riesgo';

  @override
  String get storageRecoveryGone => 'No hay copia en ningún otro sitio';

  @override
  String get storageRecoveryAskSender => 'Se puede volver a pedir al remitente';

  @override
  String get storageRecoveryCostsThem =>
      'Ya no podrían pedirte que lo reenvíes';

  @override
  String storageConfirmTitle(String size) {
    return '¿Liberar $size?';
  }

  @override
  String get storageConfirmBody =>
      'Esto elimina los archivos de este teléfono. No se sube nada a ningún sitio, así que no hay de dónde restaurarlos.';

  @override
  String storageFilesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count archivos',
      one: '$count archivo',
      zero: 'vacío',
    );
    return '$_temp0';
  }

  @override
  String get customizeBarTitle => 'Barra de navegación';

  @override
  String get customizeBarHint =>
      'Arrastra para reordenar. Chats no se puede quitar.';

  @override
  String get customizeBarShown => 'Visibles';

  @override
  String get customizeBarHidden => 'Ocultas';

  @override
  String get customizeBarHiddenEmpty => 'No hay nada oculto';

  @override
  String get customizeBarMinimum => 'Deja al menos dos pestañas';

  @override
  String get customizeReset => 'Restablecer';

  @override
  String get chatsArchiveTitle => 'Archivo';

  @override
  String get chatsArchiveEmpty => 'No hay nada archivado';

  @override
  String get chatsArchiveHint =>
      'Los chats archivados siguen funcionando: solo están fuera de la lista.';

  @override
  String get chatsArchivedToast => 'Archivado';

  @override
  String get chatsUnarchivedToast => 'De nuevo en la lista';

  @override
  String chatsArchiveCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count chats',
      one: '$count chat',
    );
    return '$_temp0';
  }

  @override
  String get chatsSwipeNotHere => 'No disponible para este chat';

  @override
  String get customizeSwipeTitle => 'Deslizar un chat a la derecha';

  @override
  String get customizeSwipeHint =>
      'Deslizar a la izquierda sigue cambiando de pestaña.';

  @override
  String get customizeSwipeArchive => 'Archivar';

  @override
  String get customizeSwipeMute => 'Silenciar';

  @override
  String get customizeSwipePin => 'Fijar';

  @override
  String get customizeSwipeRead => 'Marcar leído';

  @override
  String get customizeSwipeDelete => 'Eliminar';

  @override
  String get customizeSwipeNone => 'Nada';

  @override
  String get customizeHighRefresh => 'Frecuencia de actualización máxima';

  @override
  String get customizeHighRefreshHint =>
      'Más fluido, y el teléfono dibuja el doble de fotogramas. Desactívalo si se calienta: el aspecto de la app no cambia, solo la frecuencia con la que se redibuja.';

  @override
  String get customizeQuickReaction => 'Reacción con doble toque';

  @override
  String get customizeQuickReactionHint =>
      'Lo que deja un doble toque en un mensaje. Si usas otra, pasa a estar aquí.';

  @override
  String get customizeCircleAudioTitle => 'Pausar la música en videomensajes';

  @override
  String get customizeCircleAudioOn =>
      'Grabar o ver uno detiene lo que esté sonando. No se reanuda solo.';

  @override
  String get customizeCircleAudioOff =>
      'Tu música sigue sonando de fondo, más baja mientras se reproduce un videomensaje.';

  @override
  String get customizeMediaQualityTitle => 'Calidad de las fotos al enviar';

  @override
  String get customizeMediaQualityEconomy => 'Ahorro';

  @override
  String get customizeMediaQualityStandard => 'Estándar';

  @override
  String get customizeMediaQualityHigh => 'Alta';

  @override
  String get customizeMediaQualityEconomyHint =>
      'Hasta 96 KB por foto, 800 px. Para una sola barra de señal o una red mesh Bluetooth saturada: la mitad de espera, una imagen más suave.';

  @override
  String get customizeMediaQualityStandardHint =>
      'Hasta 192 KB por foto, 1280 px. Con un tamaño que aún pasa solo por Bluetooth. Los videos y «Original» siempre se envían tal cual.';

  @override
  String get customizeMediaQualityHighHint =>
      'Hasta 768 KB por foto, 2048 px. Con nitidez para hacer zoom; tarda cuatro veces más en enviarse, así que mejor con Wi-Fi.';

  @override
  String get previewReacted => 'a tu mensaje';

  @override
  String get previewLocation => 'Ubicación';

  @override
  String get previewMapInvite => 'Invitación al mapa';

  @override
  String get previewContact => 'Contacto';

  @override
  String get previewUnsupported => 'Mensaje no compatible';

  @override
  String get previewCallOutgoing => 'Llamada saliente';

  @override
  String get previewCallIncoming => 'Llamada entrante';

  @override
  String get previewCallMissed => 'Llamada perdida';

  @override
  String chatPreparingPhotos(int count) {
    return 'Preparando $count fotos…';
  }

  @override
  String get circleSwitchCamera => 'Cambiar de cámara';

  @override
  String get circleLight => 'Luz de grabación';

  @override
  String get circleCameraSwitchFailed =>
      'No se pudo cambiar de cámara. La grabación sigue abierta.';

  @override
  String get diagnosticsTitle => 'Diagnóstico';

  @override
  String get diagnosticsIntro =>
      'Lo que ha hecho la app últimamente. Si algo no funciona, envía esto al desarrollador.';

  @override
  String get diagnosticsShare => 'Enviar registro al desarrollador';

  @override
  String get diagnosticsEvents => 'Eventos recientes';

  @override
  String get diagnosticsTechnical => 'Registros técnicos';

  @override
  String get diagnosticsEmpty => 'Aún no hay nada que mostrar.';

  @override
  String get diagnosticsDeveloperOn => 'Modo desarrollador activado';

  @override
  String get diagnosticsDeveloperOff => 'Modo desarrollador desactivado';

  @override
  String get logAppStarted => 'App iniciada';

  @override
  String get logInternetOn => 'Conexión a internet activada';

  @override
  String logServerConnected(String host) {
    return 'Conectado a $host';
  }

  @override
  String logServerLost(String host) {
    return 'Se perdió la conexión con $host';
  }

  @override
  String get chatSaveAction => 'Guardar';

  @override
  String get savedTagAsk => 'Guardado. ¿Añadir una etiqueta?';

  @override
  String get savedTagAdd => 'Añadir etiqueta';

  @override
  String get chatSharedWallpaperFailed =>
      'Fondo aplicado aquí. Le llegará a la otra persona cuando esté al alcance.';

  @override
  String get chatTranscribeAction => 'Transcribir';

  @override
  String get chatTranscribeFailed =>
      'Este teléfono no puede transcribir este mensaje.';

  @override
  String get chatTranscribing => 'Reconociendo…';

  @override
  String get chatTranscriptHide => 'Ocultar texto';

  @override
  String get chatCancelSend => 'Cancelar envío';

  @override
  String get chatDownloadAction => 'Descargar';

  @override
  String get chatDownloaded => 'Guardado en el teléfono';

  @override
  String get chatDownloadFailed => 'No se pudo guardar';

  @override
  String get selfUpdateTitle => 'Instalar una actualización desde un archivo';

  @override
  String get selfUpdateHint =>
      'Elige aquí el nuevo APK de cubechat en lugar de abrirlo desde un chat: instalado así, las llamadas en la pantalla de bloqueo siguen activas.';

  @override
  String get selfUpdateConfirm =>
      'Confirma la instalación en la ventana del sistema.';

  @override
  String get selfUpdateAllow =>
      'Permite que cubechat instale apps y vuelve a tocar.';

  @override
  String get selfUpdateNotOurs =>
      'Ese archivo no es una actualización de cubechat.';

  @override
  String get selfUpdateFailed => 'La actualización no se instaló.';

  @override
  String get chatTranscribeDownloading =>
      'El teléfono está descargando el idioma para esto. Inténtalo de nuevo en un minuto.';

  @override
  String get chatTranscribeNoLanguage =>
      'Este teléfono no tiene modelo de voz para ese idioma. Elige el idioma de voz a texto en Perfil → Chats y multimedia.';

  @override
  String get chatTranscribeNotAllowed =>
      'El reconocimiento de voz está desactivado para CubeChat. Actívalo en Ajustes del iPhone → CubeChat.';

  @override
  String get customizeTranscribeLanguageTitle => 'Idioma de voz a texto';

  @override
  String get customizeTranscribeLanguageAuto => 'Auto';

  @override
  String get customizeTranscribeLanguageHint =>
      'El idioma en que se habla en las notas de voz, que no tiene por qué ser el de la app. Auto prueba los idiomas del teléfono. Si falta un idioma, el propio teléfono lo descarga; la voz nunca sale de él.';

  @override
  String get chatTranslateAction => 'Traducir';

  @override
  String get chatTranslateFailed =>
      'Este mensaje no se puede traducir en este teléfono.';

  @override
  String get customizeDeferMediaTitle =>
      'Esperar al Wi-Fi para descargar multimedia';

  @override
  String get customizeDeferMediaHint =>
      'Con datos móviles, los mensajes de texto y las llamadas funcionan como siempre, mientras que las fotos, notas de voz, videomensajes y archivos esperan en el servidor hasta tener Wi-Fi, hasta dos semanas. Una fila encima de los chats muestra lo que espera y lo descarga al momento.';

  @override
  String heldMediaCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count archivos multimedia esperando Wi-Fi',
      one: '1 archivo multimedia esperando Wi-Fi',
    );
    return '$_temp0';
  }

  @override
  String get heldMediaDownload => 'Descargar';

  @override
  String get nearbyAirDropSubtitle => 'Comparte archivos con personas cercanas';

  @override
  String get nearbyFilesSubtitle => 'Archivos enviados y recibidos';

  @override
  String get airdropTab => 'AirDrop';

  @override
  String get nearbyTabFiles => 'Archivos';

  @override
  String get airdropReceiveHint => 'Quién puede enviarte archivos';

  @override
  String get airdropReceiveContacts => 'Contactos';

  @override
  String get airdropReceiveEveryone => 'Todos 10 min';

  @override
  String airdropEveryoneLeft(String time) {
    return 'Todos · $time';
  }

  @override
  String get airdropSendFiles => 'Enviar archivos';

  @override
  String get airdropChooseFiles => 'Elegir archivos';

  @override
  String airdropStagedTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count archivos listos',
      one: '1 archivo listo',
    );
    return '$_temp0';
  }

  @override
  String get airdropStagedHint =>
      'Con Bluetooth activado y AirDrop abierto en ambos teléfonos, júntalos o elige a una persona';

  @override
  String get airdropStagedPickPerson => 'Elegir persona';

  @override
  String airdropRequestBody(String what, String size) {
    return 'quiere enviar $what · $size';
  }

  @override
  String airdropWhatPhotos(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count fotos',
      one: '1 foto',
    );
    return '$_temp0';
  }

  @override
  String airdropWhatVideos(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count videos',
      one: '1 video',
    );
    return '$_temp0';
  }

  @override
  String airdropWhatFiles(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count archivos',
      one: '1 archivo',
    );
    return '$_temp0';
  }

  @override
  String get airdropAccept => 'Aceptar';

  @override
  String get airdropDecline => 'Rechazar';

  @override
  String get airdropWaiting => 'Esperando respuesta…';

  @override
  String get airdropAccepted => 'Aceptado';

  @override
  String get airdropUnheard =>
      'No recibido: quizá tenga una versión antigua de CubeChat';

  @override
  String get airdropSending => 'Enviando';

  @override
  String get airdropReceiving => 'Recibiendo';

  @override
  String get airdropInterrupted => 'Interrumpido';

  @override
  String get airdropRetry => 'Reintentar';

  @override
  String get airdropOutcomeSent => 'Enviado';

  @override
  String get airdropOutcomeReceived => 'Recibido';

  @override
  String get airdropOutcomeDeclined => 'Rechazado';

  @override
  String get airdropOutcomeCancelled => 'Cancelado';

  @override
  String get airdropOutcomePartial => 'Parcial';

  @override
  String get airdropReasonNoSpace => 'no hay espacio suficiente';

  @override
  String get airdropReasonContactsOnly => 'solo contactos';

  @override
  String get airdropReasonBusy => 'ocupado';

  @override
  String get airdropReasonTimeout => 'sin respuesta';

  @override
  String get airdropFileDeleted => 'eliminado';

  @override
  String get airdropHistory => 'Historial';

  @override
  String get airdropClearHistory => 'Borrar historial';

  @override
  String get airdropEmpty =>
      'Aquí aparecerán los archivos que envíes o recibas cerca';

  @override
  String get airdropPickPerson => 'Enviar a';

  @override
  String get airdropNobody => 'Aún no hay nadie cerca con cubechat';

  @override
  String get airdropNoDirect => 'No hay conexión Bluetooth con esta persona';

  @override
  String get airdropNearbyUnknown => 'Cerca';

  @override
  String get airdropConnecting => 'Conectando…';

  @override
  String get airdropConnectFailed => 'No se pudo conectar';

  @override
  String get airdropSlowWarning => 'Por Bluetooth esto puede tardar mucho';

  @override
  String airdropTooLarge(String name, int limit) {
    return '$name ocupa más de $limit MB';
  }

  @override
  String airdropFromLabel(String name) {
    return 'AirDrop · $name';
  }

  @override
  String get airdropWrite => 'Mensaje';

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
      'Activa Bluetooth en ambos teléfonos para que se encuentren y confirmar la transferencia.';

  @override
  String get airdropLaneHint =>
      'Bluetooth encuentra y conecta los teléfonos. Wi‑Fi transfiere los archivos cuando ambos comparten una red o un punto de acceso.';

  @override
  String get airdropWifiUnreachable => 'No están en la misma red';

  @override
  String get airdropWifiOldVersion => 'Su app aún no puede recibir por Wi‑Fi';

  @override
  String get airdropBumpAdd => 'Añadir';

  @override
  String get airdropBumpAlreadyContact => 'Ya está en tus contactos';

  @override
  String airdropBumpSending(String name) {
    return 'Enviando a $name';
  }

  @override
  String airdropBumpReceiving(String name) {
    return '$name te está enviando archivos';
  }

  @override
  String get termsTitle => 'Normas de cubechat';

  @override
  String get termsBody =>
      'cubechat no tolera el contenido ofensivo ni a los usuarios abusivos. Al continuar, aceptas no enviar acoso, amenazas, contenido sexual con menores, spam ni nada ilegal. Cualquiera puede denunciar un mensaje o a una persona; las denuncias llegan al desarrollador y se atienden en un plazo de 24 horas, y los infractores son expulsados.';

  @override
  String get termsReadFull => 'Leer los términos completos';

  @override
  String get termsAccept => 'Acepto';

  @override
  String get messageHide => 'Ocultar';

  @override
  String get messageHidden => 'Oculto para ti';

  @override
  String get reportAction => 'Denunciar';

  @override
  String get reportTitle => '¿Qué ocurre?';

  @override
  String get reportReasonSpam => 'Spam';

  @override
  String get reportReasonAbuse => 'Abuso o acoso';

  @override
  String get reportReasonViolence => 'Violencia';

  @override
  String get reportReasonSexual => 'Contenido sexual';

  @override
  String get reportReasonOther => 'Otro';

  @override
  String get reportNoteHint => 'Describe (opcional)';

  @override
  String get reportSend => 'Enviar denuncia';

  @override
  String get reportDisclosure =>
      'El texto del mensaje seleccionado y tu denuncia se envían a la moderación de cubechat y a su bot privado de Telegram.';

  @override
  String get reportSent =>
      'Denuncia enviada. Revisamos las denuncias en un plazo de 24 horas.';

  @override
  String get reportBlockedToo => 'Esta persona queda bloqueada para ti.';

  @override
  String get reportQueued =>
      'Denuncia guardada. Se enviará cuando haya conexión.';

  @override
  String get reportFailed => 'No se pudo enviar la denuncia.';

  @override
  String get filteredMessage => 'Oculto por el filtro';

  @override
  String get filteredShow => 'Mostrar';

  @override
  String get filterToggle => 'Filtro de contenido ofensivo';

  @override
  String get filterToggleHint =>
      'Oculta palabras groseras de desconocidos y en canales';

  @override
  String get aboutTitle => 'Acerca de';

  @override
  String get aboutContact => 'Escribir al desarrollador';

  @override
  String get aboutReport => 'Denunciar una infracción';

  @override
  String get aboutTerms => 'Términos de uso';

  @override
  String get aboutPrivacy => 'Política de privacidad';

  @override
  String get requestsTitle => 'Solicitudes';

  @override
  String get requestsEmpty => 'No hay solicitudes';

  @override
  String requestBanner(String name) {
    return '$name no está en tus contactos. No puede ver que has leído esto ni llamarte hasta que aceptes.';
  }

  @override
  String get requestAccept => 'Aceptar';

  @override
  String get requestDelete => 'Eliminar';

  @override
  String get requestBlock => 'Bloquear';

  @override
  String get cubeIdTitle => 'Cube ID';

  @override
  String get cubeIdExplainer =>
      'Tu @nombre apunta a tu tarjeta de contacto. El servidor guarda solo el nombre y tu tarjeta pública, nunca tus mensajes.';

  @override
  String get cubeIdFieldHint => 'a–z, 0–9 y _, de 3 a 20 caracteres';

  @override
  String get cubeIdAvailable => 'Disponible';

  @override
  String get cubeIdTaken => 'Ocupado';

  @override
  String get cubeIdReserved => 'No permitido';

  @override
  String get cubeIdInvalid => 'Solo a–z, 0–9 y _, de 3 a 20 caracteres';

  @override
  String get cubeIdClaim => 'Usar este nombre';

  @override
  String get cubeIdWorking => 'Reservando el nombre…';

  @override
  String get cubeIdChange => 'Cambiar';

  @override
  String get cubeIdEmail => 'Correo de recuperación';

  @override
  String get cubeIdEmailHint =>
      'Si pierdes este teléfono, el nombre se recupera mediante un correo a esta dirección';

  @override
  String get cubeIdEmailField => 'Correo';

  @override
  String cubeIdEmailSent(String email) {
    return 'Se envió un correo a $email. Abre el enlace que contiene.';
  }

  @override
  String get cubeIdEmailRemove => 'Quitar correo';

  @override
  String get cubeIdEmailUnavailable =>
      'El correo no está disponible ahora. Inténtalo más tarde.';

  @override
  String get cubeIdEmailInvalid => 'Eso no parece una dirección de correo';

  @override
  String get cubeIdSave => 'Guardar';

  @override
  String get cubeIdRecover => 'Recuperar un nombre por correo';

  @override
  String get cubeIdRecoverSent =>
      'Si la dirección coincide, llegará un correo. El nombre pasará a este teléfono 48 horas después de abrir su enlace.';

  @override
  String cubeIdRecoveryWarning(String name, String when) {
    return 'Alguien está recuperando @$name en otro teléfono por correo. Pasará el $when a menos que lo canceles.';
  }

  @override
  String get cubeIdRecoveryCancel => 'Cancelar la recuperación';

  @override
  String get cubeIdRecoveryCancelled => 'Recuperación cancelada';

  @override
  String get cubeIdRelease => 'Liberar';

  @override
  String cubeIdReleaseConfirm(String name) {
    return '¿Liberar @$name? Cualquiera podrá quedárselo.';
  }

  @override
  String get cubeIdShare => 'Compartir';

  @override
  String cubeIdShareText(String name) {
    return 'Búscame en cubechat: @$name\nhttps://cubechat.tech/u.html#$name';
  }

  @override
  String get cubeIdFailed =>
      'No se pudo guardar el nombre. Inténtalo de nuevo.';

  @override
  String get cubeIdOffline => 'Sin internet';

  @override
  String get lookupNotFound => 'Nadie tiene ese @nombre';

  @override
  String searchFindCubeName(String name) {
    return 'Buscar @$name';
  }

  @override
  String get searchFindCubeNameHint => 'Buscar en Cube ID y añadir';

  @override
  String get addContactHintName => 'Pega una tarjeta o escribe un @nombre';

  @override
  String get strangerReachTitle => 'Quién puede escribirme desde internet';

  @override
  String get strangerReachAll => 'Todos';

  @override
  String get strangerReachRequest => 'Con solicitud';

  @override
  String get strangerReachNone => 'Nadie';

  @override
  String get strangerReachHint =>
      'Para personas a las que no has escrito y que te contactan por internet. No afecta a las personas cercanas por Bluetooth.';

  @override
  String get sectionPrivacy => 'Privacidad y seguridad';

  @override
  String get sectionNotifications => 'Notificaciones y llamadas';

  @override
  String get sectionConnection => 'Conexión';

  @override
  String get sectionChats => 'Chats y multimedia';

  @override
  String get sectionAppearance => 'Apariencia';

  @override
  String get sectionData => 'Datos y almacenamiento';

  @override
  String get sectionAbout => 'Acerca de';

  @override
  String get subWhoSeesMe => 'Quién me ve';

  @override
  String get subProtection => 'Protección';

  @override
  String get subNotifications => 'Notificaciones';

  @override
  String get subCalls => 'Llamadas';

  @override
  String get profileDiscoverableMeshOff =>
      'La red mesh Bluetooth está desactivada: actívala en Conexión.';

  @override
  String get chatRouteBluetoothDirect => 'Bluetooth, directo';

  @override
  String chatRouteMeshHops(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Mesh · $n saltos',
      one: 'Mesh · $n salto',
    );
    return '$_temp0';
  }

  @override
  String chatRouteDeliveredVia(String route) {
    return 'Entregado: $route';
  }

  @override
  String chatRouteReceivedVia(String route) {
    return 'Recibido: $route';
  }

  @override
  String get chatUnreadDivider => 'Mensajes nuevos';

  @override
  String get radioTitle => 'Walkie-talkie';

  @override
  String get radioNearbySubtitle =>
      'Mantén pulsado un botón y habla con un grupo o un contacto';

  @override
  String get radioGroupsLabel => 'Grupos';

  @override
  String get radioDirectLabel => 'Directo';

  @override
  String get radioAddGroup => 'Añadir una radio';

  @override
  String get radioNoGroups =>
      'Aún no hay radios. Añade una: todos los que escriban el mismo nombre y la misma contraseña se oyen entre sí.';

  @override
  String get radioLeave => 'Salir de esta radio';

  @override
  String get radioPickChannel => 'Elige un grupo o un contacto';

  @override
  String get radioPushToTalk => 'Mantén pulsado para hablar';

  @override
  String get radioTalking => 'Hablando…';

  @override
  String get radioChannelBusy => 'Canal ocupado';

  @override
  String radioSpeaker(String name) {
    return '$name está hablando';
  }

  @override
  String get radioSilentTitle => 'Hablar en modo silencio';

  @override
  String get radioSilentHint =>
      'La voz se oye aunque el teléfono esté en silencio.';

  @override
  String get radioJoinNameLabel => 'Nombre';

  @override
  String get radioJoinPasswordLabel => 'Contraseña (opcional)';

  @override
  String get radioJoinHint =>
      'Todos los que escriban el mismo nombre y la misma contraseña están en la misma radio. Ningún servidor guarda una lista de ellas.';

  @override
  String get radioJoinNameRequired => 'Escribe un nombre';

  @override
  String get radioJoinSubmit => 'Añadir';

  @override
  String get radioBlockedTooLong => 'Cortado tras un minuto hablando';

  @override
  String get radioBlockedCall => 'Hay una llamada en curso';

  @override
  String get radioBlockedMicrophone => 'Sin acceso al micrófono';

  @override
  String get radioBlockedUnavailable =>
      'La radio no está disponible en este dispositivo';

  @override
  String get radioBlockedNoChannel => 'Primero elige un grupo o un contacto';

  @override
  String get radioTurnOff => 'Apagar la radio';

  @override
  String get radioPersonalCallsTitle => 'Recibir llamadas personales';

  @override
  String get radioPersonalCallsHint =>
      'Con la radio apagada, un contacto que te hable la sintoniza hacia él.';

  @override
  String get radioBackgroundHint =>
      'Con la pantalla apagada, la radio solo se oye si el modo en segundo plano está activado.';

  @override
  String get areaNearby => 'Chat cercano';

  @override
  String get areaLevelDistrict => 'Barrio';

  @override
  String get areaLevelCity => 'Ciudad';

  @override
  String get areaLevelRegion => 'Región';

  @override
  String areaPresentCount(int count) {
    return '≈$count aquí';
  }

  @override
  String get areaPresentMany => '50+ aquí';

  @override
  String get areaBlockViaBluetooth => 'Tu manzana, por Bluetooth';

  @override
  String get areaOpenNearbyTab => 'Abrir Cerca';

  @override
  String get areaLocating => 'Buscando tu barrio…';

  @override
  String get areaNoPlace =>
      'Aún no hay ubicación. El chat de la zona necesita tu ubicación aproximada mientras esta pantalla está abierta.';

  @override
  String get areaLocationDenied =>
      'La ubicación está desactivada para Cubechat. Permite la ubicación aproximada en Ajustes para ver tu barrio.';

  @override
  String get areaOffline => 'Sin conexión con el chat de la zona';

  @override
  String get areaEmpty => 'Nadie ha escrito aquí en las últimas 24 horas.';

  @override
  String get areaConsentTitle => 'El chat de la zona es público';

  @override
  String get areaConsentBody =>
      'Los mensajes de aquí son públicos. Cualquiera que abra tu barrio o tu ciudad los leerá, y se guardan durante 24 horas en el servidor de Cubechat. Escribes con un nombre temporal que cambia cada pocas horas; nadie ve tu @nombre ni tus contactos. Para saber tu barrio, Cubechat pide tu ubicación aproximada, solo mientras esta pantalla está abierta.';

  @override
  String get areaConsentAllow => 'Continuar';

  @override
  String get areaConsentDecline => 'Ahora no';

  @override
  String areaDefaultName(String tag) {
    return 'Cubo-$tag';
  }

  @override
  String areaYouAre(String name, int hours) {
    return 'Eres $name · nombre nuevo en $hours h';
  }

  @override
  String get areaNewName => 'Nombre nuevo';

  @override
  String get areaSetName => 'Elegir un nombre';

  @override
  String get areaNameHint =>
      'Solo durante las pocas horas de este nombre. Déjalo vacío para usar el automático.';

  @override
  String get areaNameSameWarning =>
      'Usar el mismo nombre te vincula entre barrios';

  @override
  String get areaShowPresence => 'Mostrar que estoy aquí';

  @override
  String get areaPresenceOffHint =>
      'Activa «Mostrar que estoy aquí» para ver cuántas personas hay cerca';

  @override
  String get areaReadOnly => 'Solo puedes escribir donde estás';

  @override
  String get areaComposerHint => 'Mensaje para todos aquí';

  @override
  String get areaSend => 'Enviar';

  @override
  String get areaWaitALittle => 'Espera un poco';

  @override
  String areaFlood(int count) {
    return 'Flood ($count) · Mostrar';
  }

  @override
  String get areaReply => 'Responder';

  @override
  String get areaHide => 'Ocultar';

  @override
  String get areaBlock => 'Bloquear hasta que cambie de nombre';

  @override
  String get areaBlocked => 'Bloqueado hasta que cambie de nombre';

  @override
  String get areaReport => 'Denunciar';

  @override
  String get areaOpenLink => 'Abrir enlace';

  @override
  String areaOpenLinkConfirm(String url) {
    return '¿Abrir $url?';
  }

  @override
  String get areaOpen => 'Abrir';

  @override
  String get areaReadHere => 'Leer aquí';

  @override
  String get areaReadHereHint =>
      'Solo lectura. Solo puedes escribir donde estás; el relé sabe qué lugar estás leyendo.';

  @override
  String get areaNotes => 'Notas';

  @override
  String areaNotesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count notas',
      one: '$count nota',
      zero: 'No hay notas',
    );
    return '$_temp0';
  }

  @override
  String get areaLeaveNote => 'Dejar una nota';

  @override
  String get areaNoteHint => 'Una nota breve para tu ciudad';

  @override
  String get areaNoteLifetime => 'Dura';

  @override
  String get areaNote1h => '1 h';

  @override
  String get areaNote24h => '24 h';

  @override
  String get areaNote7d => '7 días';

  @override
  String get areaPinToDistrict => 'Anclar a un barrio';

  @override
  String get areaPinHint =>
      'Toca el mapa dentro de tu ciudad; el marcador se ajusta a su barrio.';

  @override
  String get areaPinOutside => 'Solo dentro de tu ciudad';

  @override
  String get areaNoteDelete => 'Eliminar mi nota';

  @override
  String get areaNoNotes => 'Aún no hay notas aquí';

  @override
  String get areaNotesLimit => 'Tres notas al día';

  @override
  String get areaNoteLeft => 'Nota dejada';

  @override
  String get areaNoteSend => 'Dejar';

  @override
  String get areaOwnNote => 'Tu nota';

  @override
  String get areaNotePinned => 'Anclada a un barrio';

  @override
  String get areaHidden => 'Oculto';

  @override
  String get areaPublicBadge => 'Público · se guarda 24 h';

  @override
  String get areaSettingTitle => 'Chat de la zona';

  @override
  String get areaSettingOnHint =>
      'El botón Chat cercano en el mapa: chats públicos de tu barrio y tu ciudad, con un nombre temporal.';

  @override
  String get areaSettingOffHint =>
      'Desactivado: no hay botón en el mapa y el chat de la zona nunca pide tu ubicación ni se conecta.';

  @override
  String get wallpaperPhotoLocalOnly =>
      'Los fondos con foto por ahora son solo locales';

  @override
  String get wallpaperSavedNoRoute =>
      'Guardado aquí. Ahora no hay ruta hasta el otro dispositivo';

  @override
  String get wallpaperScopeTitle => '¿Quién debe ver este fondo?';

  @override
  String get wallpaperScopeChannel => 'Todo el canal';

  @override
  String get wallpaperScopeBoth => 'Yo y la otra persona';

  @override
  String get wallpaperScopeLocal => 'Solo en mi teléfono';

  @override
  String get wallpaperScopeSharedHint =>
      'Se envía como paquete de control cifrado';

  @override
  String get wallpaperScopePhotoHint =>
      'Las fotos por ahora se quedan en este teléfono';

  @override
  String get foldersCreate => 'Crear carpeta';

  @override
  String get foldersYours => 'Tus carpetas';

  @override
  String get foldersSmartFilters => 'Filtros inteligentes';

  @override
  String get foldersName => 'Nombre de la carpeta';

  @override
  String get foldersSave => 'Guardar';

  @override
  String get foldersDeleteTitle => '¿Eliminar carpeta?';

  @override
  String get foldersDelete => 'Eliminar';

  @override
  String get foldersCreateAction => 'Crear';

  @override
  String get chatsArchiveHiddenToast =>
      'Archivo oculto. Recupéralo en «Apariencia».';

  @override
  String get chatsBulkPin => 'Fijar';

  @override
  String get chatsBulkMute => 'Silenciar';

  @override
  String get chatsUnarchive => 'Desarchivar';

  @override
  String get chatsAddToFolder => 'Añadir a carpeta';

  @override
  String get chatsMarkUnread => 'Marcar como no leído';

  @override
  String get chatsClearHistory => 'Vaciar historial del chat';

  @override
  String get foldersNew => 'Nueva carpeta';

  @override
  String get foldersNameHint => 'Amigos';

  @override
  String get chatsNoIncoming => 'No hay mensajes entrantes';

  @override
  String get chatsMarkedUnread => 'Marcado como no leído';

  @override
  String get chatsClearHistoryTitle => '¿Vaciar historial del chat?';

  @override
  String get chatsClearHistoryBody =>
      'Los mensajes se eliminarán solo en este dispositivo. El chat, el contacto y los favoritos se mantienen.';

  @override
  String get chatsClearHistoryAction => 'Vaciar';

  @override
  String get chatsHistoryCleared => 'Historial vaciado';

  @override
  String get savedTagMenuTag => 'Etiqueta';

  @override
  String get savedTagRemove => 'Quitar etiqueta';

  @override
  String get customizeArchiveRowTitle => 'Fila del archivo';

  @override
  String get customizeArchiveRowHint =>
      'Mostrarla sobre la lista de chats. Los chats archivados siguen recibiendo mensajes igualmente.';

  @override
  String get mapLayerStandard => 'Estándar';

  @override
  String get mapLayerStandardHint =>
      'Mapa de calles claro — la opción más estable';

  @override
  String get callYourMicOff => 'Tu micrófono está desactivado';

  @override
  String callTheirCameraOff(String name) {
    return 'La cámara de $name está apagada';
  }
}
