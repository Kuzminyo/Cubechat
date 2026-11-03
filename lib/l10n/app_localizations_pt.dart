// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get callVoice => 'Chamada de voz';

  @override
  String get callVideo => 'Chamada de vídeo';

  @override
  String get callIncomingVideo => 'Chamada de vídeo recebida';

  @override
  String get callCamera => 'Câmera';

  @override
  String get callFlipCamera => 'Virar';

  @override
  String get contactProfileVideo => 'Vídeo';

  @override
  String get callPreparing => 'Preparando o microfone…';

  @override
  String get callDialing => 'Chamando…';

  @override
  String get callRinging => 'Tocando…';

  @override
  String get callConnecting => 'Conectando…';

  @override
  String get callMicrophoneRequired =>
      'Permita o acesso ao microfone nas configurações do sistema para fazer chamadas.';

  @override
  String get callMicrophoneWindows =>
      'O Windows não liberou o microfone para o CubeChat. Ative Configurações → Privacidade e segurança → Microfone → \"Permitir que aplicativos da área de trabalho acessem o microfone\".';

  @override
  String get callElsewhere =>
      'Já há uma chamada em andamento em outro dispositivo desta conta.';

  @override
  String get callRelayUnavailable =>
      'Servidor de chamadas indisponível. Tente novamente mais tarde.';

  @override
  String get callBusy => 'Ocupado';

  @override
  String get callNoAnswer => 'Sem resposta';

  @override
  String get callFailed => 'Não foi possível conectar a chamada';

  @override
  String get callDeclined => 'Chamada recusada';

  @override
  String get callEnded => 'Chamada encerrada';

  @override
  String get callMicrophone => 'Microfone';

  @override
  String get callSpeaker => 'Alto-falante';

  @override
  String get callAnswer => 'Atender';

  @override
  String get callDecline => 'Recusar';

  @override
  String get callEnd => 'Encerrar';

  @override
  String get callClose => 'Fechar';

  @override
  String get callMinimize => 'Minimizar';

  @override
  String get callAudioOutput => 'Áudio da chamada';

  @override
  String get callRoutePhone => 'Telefone';

  @override
  String get callRouteBluetooth => 'Bluetooth';

  @override
  String get callRouteHeadphones => 'Fones de ouvido';

  @override
  String get callFullScreenTitle => 'Chamadas na tela de bloqueio';

  @override
  String get callFullScreenBody =>
      'Permita que chamadas recebidas apareçam na tela bloqueada, para atender sem desbloquear.';

  @override
  String get callFullScreenXiaomi =>
      'Xiaomi, Redmi e Poco não deixam os apps ativarem isso sozinhos: ative “Mostrar na tela de bloqueio” em Outras permissões.';

  @override
  String get circleMessage => 'Mensagem de vídeo';

  @override
  String get appName => 'Cubechat';

  @override
  String get navChats => 'Conversas';

  @override
  String get navPeers => 'Por perto';

  @override
  String get navProfile => 'Perfil';

  @override
  String get navContacts => 'Contatos';

  @override
  String get navMap => 'Mapa';

  @override
  String get mapTitle => 'Mapa';

  @override
  String get mapFriendsTitle => 'Pessoas no mapa';

  @override
  String get mapFriendsHint => 'Só estes contatos recebem a sua posição';

  @override
  String mapClusterTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count pessoas aqui',
      one: '$count pessoa aqui',
    );
    return '$_temp0';
  }

  @override
  String get mapClusterHint => 'Toque em alguém para levar o mapa até a pessoa';

  @override
  String get mapNorthUp => 'Norte para cima';

  @override
  String get mapLayerTitle => 'Estilo do mapa';

  @override
  String get mapLayerHint => 'Sobre o que os marcadores são desenhados';

  @override
  String get mapLayerDark => 'Escuro';

  @override
  String get mapLayerDarkHint =>
      'Ruas, sem rótulos — o fundo mais discreto sob os marcadores';

  @override
  String get mapLayerSatellite => 'Satélite';

  @override
  String get mapLayerSatelliteHint =>
      'Imagens aéreas: qual prédio, qual quintal';

  @override
  String get mapLayerTerrain => 'Relevo';

  @override
  String get mapLayerTerrainHint =>
      'Curvas de nível e relevo, para morros e trilhas';

  @override
  String get mapFriendsEmpty =>
      'Ninguém está compartilhando o mapa com você ainda.';

  @override
  String get mapFriendsEmptyHint =>
      'Convide um contato e ele aparecerá aqui assim que aceitar.';

  @override
  String get mapFriendsInvite => 'Convidar';

  @override
  String get mapFriendsRemove => 'Remover do mapa';

  @override
  String mapFriendsRemoved(String name) {
    return '$name não compartilha mais o mapa com você';
  }

  @override
  String get mapFriendsLive => 'No mapa agora';

  @override
  String get mapFriendsIdle => 'Sem posição no momento';

  @override
  String get mapInviteTitle => 'Convidar para o mapa';

  @override
  String get mapInviteHint => 'Escolha uma ou mais conversas';

  @override
  String get mapInviteEmpty => 'Ainda não há conversas para convidar.';

  @override
  String mapInviteAction(int count) {
    return 'Enviar ($count)';
  }

  @override
  String get mapInviteMessage =>
      'Convite para o mapa do Cubechat. Compartilhe sua localização nesta conversa para aparecer no mapa.';

  @override
  String mapInviteSent(int count) {
    return 'Convites enviados: $count';
  }

  @override
  String get mapInviteFailed => 'Não foi possível enviar os convites';

  @override
  String mapPeopleVisible(int count) {
    return 'Localizações compartilhadas: $count';
  }

  @override
  String get mapCenterMe => 'Centralizar em mim';

  @override
  String get mapNoSharedLocations => 'Nenhuma localização compartilhada ainda';

  @override
  String get mapNoSharedLocationsHint =>
      'Um contato aparece aqui depois de enviar uma localização na conversa.';

  @override
  String get mapWebHintTitle => 'Conexões por perto';

  @override
  String get mapWebHint =>
      'As linhas mostram proximidade, não a rota da mensagem.';

  @override
  String get mapOpenProfile => 'Perfil';

  @override
  String get mapLocationPrivacyOff => 'Localização no mapa oculta';

  @override
  String get mapLocationPrivacyOffHint =>
      'Ative Mostrar-me no mapa em Privacidade para exibir o seu marcador.';

  @override
  String get mapYouOnMap => 'Sua posição está visível neste dispositivo';

  @override
  String get locationSharingDisabled =>
      'Primeiro ative Mostrar-me no mapa em Privacidade.';

  @override
  String get mapLocationDenied => 'Acesso à localização desativado';

  @override
  String get mapLocationServiceOff =>
      'Ative os serviços de localização para se mostrar';

  @override
  String get mapLocationUnavailable =>
      'Não foi possível determinar sua localização';

  @override
  String get mapDistanceUnknown => 'Distância indisponível';

  @override
  String mapDistanceMetres(int metres) {
    return 'a $metres m';
  }

  @override
  String mapDistanceKilometres(String kilometres) {
    return 'a $kilometres km';
  }

  @override
  String get mapUpdatedNow => 'compartilhada agora mesmo';

  @override
  String mapUpdatedMinutes(int minutes) {
    return 'compartilhada há $minutes min';
  }

  @override
  String mapUpdatedHours(int hours) {
    return 'compartilhada há $hours h';
  }

  @override
  String get contactsTitle => 'Contatos';

  @override
  String get contactsSubtitle => 'Todos com quem você já conversou';

  @override
  String get contactsSearchHint => 'Buscar contatos…';

  @override
  String get contactsEmptyTitle => 'Nenhum contato ainda';

  @override
  String get contactsEmptyHint =>
      'Comece uma conversa e a pessoa aparecerá aqui.';

  @override
  String get contactsSearchEmpty => 'Nenhum contato encontrado';

  @override
  String get contactsTabContacts => 'Contatos';

  @override
  String get contactsTabCalls => 'Chamadas';

  @override
  String get callsFilterAll => 'Todas';

  @override
  String get callsFilterMissed => 'Perdidas';

  @override
  String get callsEmptyTitle => 'Nenhuma chamada ainda';

  @override
  String get callsEmptyHint =>
      'Chamadas recebidas, feitas e perdidas aparecerão aqui.';

  @override
  String get callsMissedEmpty => 'Nenhuma chamada perdida';

  @override
  String get callsCallBack => 'Ligar';

  @override
  String get contactProfileChat => 'Conversa';

  @override
  String get contactProfileCall => 'Ligar';

  @override
  String get contactProfileRadio => 'Rádio';

  @override
  String get contactProfileSecurity => 'Segurança';

  @override
  String get contactProfileActions => 'Ações do contato';

  @override
  String get contactProfileVerify => 'Verificar';

  @override
  String get contactProfileCopyId => 'Copiar ID do contato';

  @override
  String get contactProfileIdCopied => 'ID do contato copiado';

  @override
  String get contactProfileId => 'ID do contato';

  @override
  String get contactProfileVerifyHint =>
      'Compare as impressões digitais da criptografia para confirmar esta pessoa.';

  @override
  String get chatsTitle => 'Conversas';

  @override
  String get chatsSubtitle => 'Mesh · criptografia de ponta a ponta';

  @override
  String get chatsEmptyTitle => 'Nenhuma conversa ainda';

  @override
  String get chatsEmptyHint =>
      'Abra alguém na aba Por perto para começar a conversar.';

  @override
  String get chatsFilterAll => 'Todas';

  @override
  String get chatsFilterUnread => 'Não lidas';

  @override
  String get chatsFilterMesh => 'Mesh';

  @override
  String get chatsFilterFavorites => 'Favoritas';

  @override
  String get chatsFolderDirect => 'Pessoais';

  @override
  String get chatsFolderChannels => 'Canais';

  @override
  String get chatsFolderOnline => 'Acessíveis';

  @override
  String get chatsFoldersTitle => 'Pastas';

  @override
  String get chatsFoldersHint =>
      'Pastas são recortes desta lista, não lugares para onde as conversas são movidas. Ative as que você quer acima das conversas.';

  @override
  String get chatsSearchHint => 'Buscar conversas…';

  @override
  String get chatsStatusViaMesh => 'via mesh';

  @override
  String get chatsStatusOffline => 'offline';

  @override
  String get peerKeyRotated => 'chave alterada — verifique de novo';

  @override
  String get peersTitle => 'Por perto';

  @override
  String get peersSubtitle => 'Dispositivos ao alcance do Bluetooth';

  @override
  String get peersEmpty => 'Procurando pessoas por perto…';

  @override
  String peersHopsOne(int n) {
    return 'a $n salto';
  }

  @override
  String peersHopsOther(int n) {
    return 'a $n saltos';
  }

  @override
  String get blePermissionTitle => 'Permissão de Bluetooth necessária';

  @override
  String get blePermissionHint =>
      'O Cubechat usa o Bluetooth para encontrar pessoas e enviar mensagens — sem precisar de internet.';

  @override
  String get blePermissionGrant => 'Permitir';

  @override
  String get blePermissionOpenSettings => 'Abrir configurações';

  @override
  String get blePermissionDeniedHint =>
      'A permissão foi negada. Abra as configurações para permitir o acesso ao Bluetooth.';

  @override
  String get bleAdapterOffTitle => 'Bluetooth desligado';

  @override
  String get bleAdapterOffHint =>
      'Ligue o Bluetooth para ver quem está por perto.';

  @override
  String get bleUnsupportedTitle => 'Bluetooth LE indisponível';

  @override
  String get bleUnsupportedHint =>
      'Este dispositivo ou plataforma não oferece Bluetooth Low Energy. Tente em um celular.';

  @override
  String get bleScanning => 'Procurando…';

  @override
  String get bleRetry => 'Tentar de novo';

  @override
  String get bleEnable => 'Ligar';

  @override
  String get bleConnectFailed =>
      'Não foi possível conectar. O dispositivo pode estar fora de alcance ou o endereço Bluetooth dele mudou.';

  @override
  String get bleSignal => 'Sinal';

  @override
  String get bleConnect => 'Conectar';

  @override
  String get bleConnected => 'Conectado';

  @override
  String get bleVerified => 'Verificado';

  @override
  String get editorAdjustBrightness => 'Brilho';

  @override
  String get editorAdjustContrast => 'Contraste';

  @override
  String get editorAdjustSaturation => 'Saturação';

  @override
  String get editorToolCrop => 'Cortar';

  @override
  String get editorToolDraw => 'Desenhar';

  @override
  String get editorToolAdjust => 'Ajustar';

  @override
  String get editorTabSticker => 'Figurinha';

  @override
  String get editorTabText => 'Texto';

  @override
  String get editorPenPen => 'Caneta';

  @override
  String get editorPenMarker => 'Marca-texto';

  @override
  String get editorPenNeon => 'Neon';

  @override
  String get editorPenArrow => 'Seta';

  @override
  String get editorPenBlur => 'Desfocar';

  @override
  String get editorPenEraser => 'Borracha';

  @override
  String get editorLevel => 'Nivelar';

  @override
  String get editorTextHint => 'Texto na foto';

  @override
  String get editorCropFree => 'Livre';

  @override
  String get editorRemove => 'Remover';

  @override
  String get notificationUnknownSender => 'Nova mensagem';

  @override
  String get bleUnknownPeer => 'Dispositivo desconhecido';

  @override
  String get bleBroadcasting => 'Transmitindo';

  @override
  String bleConnectedCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n centrais conectadas',
      one: '1 central conectada',
      zero: 'Nenhuma central',
    );
    return '$_temp0';
  }

  @override
  String get verifyTitle => 'Verificar contato';

  @override
  String get verifyIntro =>
      'Compare estas duas impressões digitais com a outra pessoa pessoalmente ou por uma chamada de voz. Se forem iguais dos dois lados, você confirmou que o handshake do Noise não foi adulterado.';

  @override
  String get verifyMine => 'SUA IMPRESSÃO DIGITAL';

  @override
  String verifyTheirs(String name) {
    return 'IMPRESSÃO DIGITAL DE $name';
  }

  @override
  String get verifyMarkAsVerified => 'Marcar como verificado';

  @override
  String get verifyAlreadyDone => 'Este contato está verificado.';

  @override
  String get verifyRevoke => 'Revogar';

  @override
  String verifyDoneSnack(String name) {
    return '$name marcado como verificado';
  }

  @override
  String get chatInputHint => 'Mensagem';

  @override
  String get chatSend => 'Enviar';

  @override
  String get chatToday => 'Hoje';

  @override
  String get chatYesterday => 'Ontem';

  @override
  String get chatDelivered => 'Entregue';

  @override
  String get chatRead => 'Lida';

  @override
  String get chatSending => 'Enviando';

  @override
  String get chatWaitingForConnection => 'Aguardando conexão';

  @override
  String sendQueueCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count mensagens aguardando conexão',
      one: '1 mensagem aguardando conexão',
    );
    return '$_temp0';
  }

  @override
  String sendQueueSlowNetwork(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Rede lenta — enviando $count mensagens',
      one: 'Rede lenta — enviando 1 mensagem',
    );
    return '$_temp0';
  }

  @override
  String get sendQueueTitle => 'Aguardando envio';

  @override
  String get sendQueueHint =>
      'Elas saem sozinhas assim que houver um caminho — Bluetooth por perto ou internet. Não precisa apertar nada.';

  @override
  String get sendQueueRetry => 'Tentar agora';

  @override
  String get sendQueueCancel => 'Cancelar envio';

  @override
  String get sendQueueCancelled => 'Não enviada — cancelada';

  @override
  String get sendQueueTooLate =>
      'Tarde demais para cancelar: ela já foi enviada';

  @override
  String get chatEncryptedNotice =>
      'As mensagens têm criptografia de ponta a ponta com o Noise Protocol.';

  @override
  String get chatSessionHandshaking => 'Estabelecendo canal seguro…';

  @override
  String get chatSessionEstablished => 'Protegido · Noise XX';

  @override
  String get chatSessionFailed => 'Falha na conexão';

  @override
  String get presenceOnline => 'online';

  @override
  String get presenceOffline => 'offline';

  @override
  String get chatSessionFingerprintPending =>
      'A impressão digital aparecerá quando o handshake terminar.';

  @override
  String get chatEmptyEstablished =>
      'O canal seguro está pronto. Envie uma mensagem para começar a conversa.';

  @override
  String get chatEmptyHandshaking =>
      'Aguardando o outro lado concluir o handshake…';

  @override
  String get chatEmptyTitle => 'Nenhuma mensagem aqui ainda';

  @override
  String get chatEmptyGreetHint =>
      'Envie uma mensagem ou toque no Kubi para dizer oi.';

  @override
  String get profileTitle => 'Perfil';

  @override
  String get profileNickname => 'Apelido';

  @override
  String get profileNicknameEditTitle => 'Defina seu apelido';

  @override
  String get profileNicknameHint => 'Como os outros veem você na mesh';

  @override
  String get profileNicknameSave => 'Salvar';

  @override
  String get profileFingerprint => 'Impressão digital da chave pública';

  @override
  String get profileLanguage => 'Idioma';

  @override
  String get profileLanguageEn => 'Inglês';

  @override
  String get profileLanguageUk => 'Ucraniano';

  @override
  String get profileTransport => 'Transporte';

  @override
  String get profileTransportMesh => 'Bluetooth mesh';

  @override
  String get profileBackground => 'Ficar acessível em segundo plano';

  @override
  String get profileBackgroundSubtitle =>
      'Continuar recebendo mensagens com o app fechado';

  @override
  String get profileBatteryExempt => 'Desativar otimização de bateria';

  @override
  String get profileAbout => 'Sobre';

  @override
  String profileVersion(String v) {
    return 'Versão $v';
  }

  @override
  String get rotateKeysTitle => 'Trocar chaves da conta';

  @override
  String get rotateKeysHint =>
      'Se um dispositivo com a sua conta foi perdido ou roubado';

  @override
  String get rotateKeysConfirmTitle => 'Trocar as chaves da sua conta?';

  @override
  String get rotateKeysConfirmBody =>
      'Seus contatos recebem as novas chaves e mantêm as conversas, mas cada um deles terá que verificar suas chaves de novo. Todos os outros dispositivos da sua conta serão desconectados; vincule de novo, a partir deste celular, os que você quiser manter. Contatos com uma versão antiga do CubeChat não conseguirão falar com você até atualizarem. Os canais mantêm suas chaves.';

  @override
  String get rotateKeysConfirmAction => 'Trocar chaves';

  @override
  String get rotateKeysWorking => 'Trocando as chaves…';

  @override
  String rotateKeysDone(int sent, int total) {
    return 'Novas chaves. $sent de $total contatos avisados';
  }

  @override
  String get rotateKeysSlow =>
      'Novas chaves. Nem todos os contatos confirmaram a tempo; os relays guardam o aviso para eles';

  @override
  String get profileEmergencyWipe => 'Apagamento de emergência';

  @override
  String get profileEmergencyWipeConfirm => 'Apagar tudo?';

  @override
  String get profileEmergencyWipeConfirmHint =>
      'Isso removerá sua identidade, a lista de contatos e o histórico de conversas. Não pode ser desfeito.';

  @override
  String get profileEmergencyWipeAction => 'Apagar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get copy => 'Copiar';

  @override
  String get copied => 'Copiado';

  @override
  String get channelsNewTitle => 'Novo canal';

  @override
  String get channelsNewTooltip => 'Novo canal';

  @override
  String get channelNameLabel => 'Nome do canal';

  @override
  String get channelPasswordLabel => 'Senha (opcional)';

  @override
  String get channelJoinAction => 'Entrar';

  @override
  String get channelNameHint =>
      'Quem digitar o mesmo nome e a mesma senha entra na mesma sala. Não há servidor guardando uma lista delas.';

  @override
  String get channelPasswordHint =>
      'A senha é a chave. Sem ela, a sala fica aberta a qualquer pessoa por perto que saiba o nome.';

  @override
  String get channelSubtitle => 'Canal em grupo · chave compartilhada';

  @override
  String get channelMute => 'Silenciar';

  @override
  String get channelUnmute => 'Ativar som';

  @override
  String channelMutedUntil(String time) {
    return 'Silenciado até $time';
  }

  @override
  String get channelMuteFor => 'Silenciar por…';

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
    return '$days dias';
  }

  @override
  String get channelMuteForever => 'Até eu reativar';

  @override
  String get channelCommunity => 'Comentários';

  @override
  String get channelCommunityOpen => 'Abrir a discussão';

  @override
  String channelCommunitySubtitle(String channel) {
    return 'Discussão de $channel';
  }

  @override
  String get channelBackToChannel => 'Voltar ao canal';

  @override
  String get channelMemberActions => 'Membro';

  @override
  String get channelRemoveMember => 'Remover do canal';

  @override
  String get channelRemoveMemberHint =>
      'As publicações dessa pessoa deixam de ser aceitas aqui. Nada impede que ela volte pelo nome — a chave compartilhada é a única forma de participação que existe.';

  @override
  String get channelMuteMember => 'Silenciar por…';

  @override
  String get channelUnmuteMember => 'Deixar publicar de novo';

  @override
  String channelMemberRemoved(String name) {
    return '$name foi removido';
  }

  @override
  String channelMemberMuted(String name) {
    return '$name foi silenciado';
  }

  @override
  String channelMemberCleared(String name) {
    return '$name pode publicar de novo';
  }

  @override
  String get channelMemberMutedNote => 'Silenciado';

  @override
  String get channelShareHistory => 'Compartilhar o histórico';

  @override
  String get channelShareHistoryHint =>
      'Transmite de novo as últimas publicações desta sala, para que quem entrou depois possa vê-las. Quem já estava aqui não recebe nada novo.';

  @override
  String channelHistoryShared(int count) {
    return 'Publicações oferecidas: $count';
  }

  @override
  String get channelHistoryNothing => 'Nada para compartilhar ainda';

  @override
  String get channelHistoryAuto => 'Dar o histórico a novos membros';

  @override
  String get channelHistoryAutoHint =>
      'Quando alguém novo aparece na sala, as publicações recentes vão para essa pessoa automaticamente. Por enquanto só texto — fotos são enviadas em partes e não podem ser reenviadas sem duplicá-las para todos.';

  @override
  String get channelPostComments => 'Comentários';

  @override
  String get channelNoComments => 'Ninguém comentou isto ainda';

  @override
  String get channelCommentHint => 'Comentar';

  @override
  String get channelMuteCustom => 'Por quanto tempo?';

  @override
  String get channelMuteCustomHint => 'Horas';

  @override
  String get chatPinnedManage => 'Fixadas';

  @override
  String get chatPeekOpen => 'Abrir conversa';

  @override
  String get chatPeekPin => 'Fixar';

  @override
  String get chatPeekUnpin => 'Desafixar';

  @override
  String get chatPeekUnmute => 'Ativar som';

  @override
  String get chatPeekMarkRead => 'Marcar como lida';

  @override
  String get chatDeleteForMeHint =>
      'Removida deste celular e desafixada. O outro lado mantém a cópia dele.';

  @override
  String get pushWakeTitle => 'Despertar este celular';

  @override
  String get pushWakeHint =>
      'Um pequeno servidor observa os relays em busca do seu endereço e avisa este celular quando algo chega, para que o app fechado ainda possa te avisar. Ele nunca vê mensagens nem chaves — só que o seu endereço recebeu algo, e quando. O relay já sabe disso; este é um segundo lugar que também sabe.';

  @override
  String get pushWakeDeniedTitle => 'As notificações estão desativadas';

  @override
  String get pushWakeDeniedHint =>
      'O sistema recebeu um \"não\" uma vez e não vai perguntar de novo, então isso só pode ser reativado em Ajustes — cubechat, depois Notificações. Depois volte aqui.';

  @override
  String get pushWakeRefused => 'As notificações não foram permitidas';

  @override
  String get privacyForwardLinkTitle => 'Link para o perfil em encaminhadas';

  @override
  String get privacyForwardLinkHint =>
      'Quando alguém repassa uma mensagem sua, a linha acima dela pode abrir o seu perfil. Desativado, a pessoa vê seu nome e nada para tocar. É um pedido ao app dela, não algo que este app possa garantir.';

  @override
  String get privacyShareSheetTitle => 'Conversas no menu Compartilhar';

  @override
  String get privacyShareSheetOnHint =>
      'Os nomes das suas quatro conversas mais recentes são passados ao Android, para você enviar a elas de qualquer app. O bloqueio do app não as esconde.';

  @override
  String get privacyShareSheetOffHint =>
      'Nada é passado ao Android. Ao compartilhar com o CubeChat, você escolhe a conversa.';

  @override
  String get privacyCallsTitle => 'Aceitar chamadas';

  @override
  String get privacyCallsOnHint =>
      'Seus contatos podem ligar para você. Para recusar uma pessoa, abra o perfil dela.';

  @override
  String get privacyCallsOffHint =>
      'Ninguém pode ligar para você, exceto quem você permitir no perfil. Uma chamada recusada aparece para a pessoa como ocupado.';

  @override
  String get chatsStatusChannel => 'canal';

  @override
  String get channelInviteTitle => 'Adicionar pessoas';

  @override
  String get channelInviteAction => 'Convidar';

  @override
  String get channelInviteEmpty =>
      'Nenhum contato conhecido ainda. Encontre alguém primeiro na aba Por perto.';

  @override
  String get channelInviteSent => 'Convites enviados';

  @override
  String get channelInviteNoneSent => 'Não foi possível alcançar ninguém agora';

  @override
  String get channelNameTooLong => 'Esse nome de canal é longo demais';

  @override
  String get chatsActionFavorite => 'Adicionar aos favoritos';

  @override
  String get chatsActionUnfavorite => 'Remover dos favoritos';

  @override
  String get chatsActionDelete => 'Apagar conversa';

  @override
  String get chatsDeleteTitle => 'Apagar esta conversa?';

  @override
  String chatsDeleteManyHint(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Limpa $count conversas. Os contatos continuam, então você pode escrever para eles de novo sem trocar códigos.',
      one:
          'Limpa $count conversa. Os contatos continuam, então você pode escrever para eles de novo sem trocar códigos.',
    );
    return '$_temp0';
  }

  @override
  String get chatsDeletedToast => 'Conversa apagada.';

  @override
  String chatsDeletedManyToast(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count conversas apagadas.',
      one: '$count conversa apagada.',
    );
    return '$_temp0';
  }

  @override
  String get undo => 'Desfazer';

  @override
  String get chatsDeletePeerHint =>
      'Limpa a conversa. O contato continua, então você pode escrever para ele de novo sem trocar códigos.';

  @override
  String get chatsDeleteChannelHint =>
      'Sai do canal e remove o histórico dele. Você vai precisar da chave de novo para voltar.';

  @override
  String get chatsDeleteForThemToo => 'Apagar também para a outra pessoa';

  @override
  String get chatsDeleteForThemHint =>
      'Pede ao app da outra pessoa que limpe a conversa inteira também, incluindo o que ela escreveu. Em um canal, só as suas mensagens são retiradas.';

  @override
  String get chatEditAction => 'Editar';

  @override
  String get chatEditTitle => 'Editar mensagem';

  @override
  String get chatEditSave => 'Salvar';

  @override
  String get chatEdited => 'editada';

  @override
  String get chatDeleteAction => 'Apagar';

  @override
  String get chatDeleteTitle => 'Apagar mensagem?';

  @override
  String get chatDeleteForMe => 'Apagar para mim';

  @override
  String get chatDeleteForEveryone => 'Apagar para todos';

  @override
  String get chatPinTitle => 'Fixar mensagem?';

  @override
  String get chatPinForBoth => 'Fixar para nós dois';

  @override
  String get chatPinForMe => 'Fixar só para mim';

  @override
  String get chatReplyAction => 'Responder';

  @override
  String chatReplyingTo(String name) {
    return 'Respondendo a $name';
  }

  @override
  String get chatReplyYou => 'você mesmo';

  @override
  String get chatCopyAction => 'Copiar';

  @override
  String get chatCopied => 'Copiado';

  @override
  String get chatForwardAction => 'Encaminhar';

  @override
  String get chatForwardTitle => 'Encaminhar para';

  @override
  String get shareIntoTitle => 'Enviar para';

  @override
  String get shareNearbyAirDrop => 'Por perto via AirDrop';

  @override
  String get shareNearbyAirDropHint =>
      'Sem internet — para quem está do seu lado';

  @override
  String get shareSent => 'Enviado';

  @override
  String get shareFailed => 'Parte não pôde ser enviada';

  @override
  String get chatForwardEmpty => 'Nenhuma outra conversa ainda';

  @override
  String chatForwardSendCount(int count) {
    return 'Enviar ($count)';
  }

  @override
  String chatForwardSentCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Encaminhada para $count conversas',
      one: 'Encaminhada para uma conversa',
    );
    return '$_temp0';
  }

  @override
  String chatForwardSent(String name) {
    return 'Encaminhada para $name';
  }

  @override
  String chatSentAt(String time) {
    return 'Enviada $time';
  }

  @override
  String chatReadAt(String time) {
    return 'Lida $time';
  }

  @override
  String get chatPinAction => 'Fixar';

  @override
  String get chatUnpinAction => 'Desafixar';

  @override
  String chatPinnedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count mensagens fixadas',
      one: '1 mensagem fixada',
      zero: 'Nenhuma mensagem fixada',
    );
    return '$_temp0';
  }

  @override
  String get chatNoPins => 'Nada fixado aqui';

  @override
  String get chatUnpinAll => 'Desafixar todas as mensagens';

  @override
  String get chatShowAllPins => 'Todas as mensagens fixadas';

  @override
  String get chatUnpinConfirm => 'Desafixar esta mensagem?';

  @override
  String get chatUnpinConfirmHint =>
      'Ela deixa de estar fixada para todos nesta conversa.';

  @override
  String get chatPinnedTitle => 'Mensagem fixada';

  @override
  String get chatPinnedGone => 'Essa mensagem não está mais nesta conversa';

  @override
  String get peerBlock => 'Bloquear';

  @override
  String get peerUnblock => 'Desbloquear';

  @override
  String get peerMute => 'Silenciar';

  @override
  String get peerUnmute => 'Ativar som';

  @override
  String get peerBlockedNote =>
      'Bloqueado — as mensagens dessa pessoa são descartadas.';

  @override
  String get relaysTitle => 'Alternativa pela internet';

  @override
  String get relaysCardTitle => 'Alcançar contatos pela internet';

  @override
  String get relaysCardSubtitle =>
      'Quando o Bluetooth não entrega, enviar por relays Nostr';

  @override
  String get relaysExplainer =>
      'As mensagens continuam com criptografia de ponta a ponta — um relay só transporta o mesmo pacote lacrado que o Bluetooth transportaria. Mas ele fica sabendo quais duas chaves estão conversando, e quando. Desativado por padrão.';

  @override
  String get relaysMyAddress => 'Seu endereço nos relays';

  @override
  String get relaysCopied => 'Copiado';

  @override
  String get circleLensTitle => 'Câmera frontal nas mensagens de vídeo';

  @override
  String get circleLensFrontHint =>
      'As mensagens de vídeo redondas são gravadas com a câmera voltada para você.';

  @override
  String get circleLensBackHint =>
      'As mensagens de vídeo redondas são gravadas com a câmera traseira, para mostrar o que você está vendo.';

  @override
  String get channelCloseTitle => 'Fechar esta sala para todos';

  @override
  String get channelCloseSubtitle =>
      'Remove a sala do celular de cada membro. Só você pode fazer isso.';

  @override
  String get channelCloseConfirm =>
      'A sala, as mensagens e os membros somem de todos os celulares que a têm. Ninguém fica bloqueado: a chave vem do nome, então quem lembrar dele pode abrir uma sala vazia de novo.';

  @override
  String get channelCloseAction => 'Fechar a sala';

  @override
  String get circleHint =>
      'Solte para enviar · deslize para a esquerda para cancelar';

  @override
  String get circleHintLocked => 'Toque em enviar quando terminar';

  @override
  String get circleNeedsCamera =>
      'Mensagens de vídeo precisam da câmera e do microfone';

  @override
  String get circleFailed => 'Não foi possível gravar a mensagem de vídeo';

  @override
  String get relaysListLabel => 'Relays';

  @override
  String get relaysLaneMedia => 'Relays de mídia';

  @override
  String get relaysLaneMediaNote =>
      'Fotos, arquivos e vídeos passam por estes, para que uma transferência não deixe a conversa lenta.';

  @override
  String get relaysLaneLocation => 'Relays de localização';

  @override
  String get relaysLaneLocationNote =>
      'Os sinais do mapa passam por estes, separados de todo o resto.';

  @override
  String get relaysAdd => 'Adicionar relay';

  @override
  String get relaysAddHint => 'wss://relay.example.com';

  @override
  String get relaysInvalidUrl => 'Digite um endereço wss:// ou ws://';

  @override
  String get relaysRemove => 'Remover';

  @override
  String get relaysStateConnected => 'Conectado';

  @override
  String get relaysStateConnecting => 'Conectando…';

  @override
  String get relaysStateFailed => 'Inacessível';

  @override
  String get relaysStateIdle => 'Desligado';

  @override
  String get relaysEmpty =>
      'Nenhum relay configurado — a alternativa fica desligada.';

  @override
  String get contactTitle => 'Cartão de contato';

  @override
  String get contactMineLabel => 'Seu cartão';

  @override
  String get contactMineExplainer =>
      'Envie isto para alguém fora do alcance do Bluetooth. Ele contém suas chaves e seu endereço nos relays — o suficiente para a pessoa começar uma conversa criptografada com você pela internet.';

  @override
  String get contactCopy => 'Copiar';

  @override
  String get contactShare => 'Compartilhar';

  @override
  String get contactCopied => 'Cartão copiado';

  @override
  String get contactShareSubject => 'Meu cartão de contato do cubechat';

  @override
  String get contactAddLabel => 'Adicionar alguém';

  @override
  String get contactAddHint => 'Cole um cartão de contato';

  @override
  String get contactAddAction => 'Adicionar';

  @override
  String get contactPaste => 'Colar';

  @override
  String contactAdded(String name) {
    return '$name adicionado';
  }

  @override
  String get contactInvalid => 'Isso não é um cartão de contato válido';

  @override
  String get contactOwnCard => 'Esse é o seu próprio cartão';

  @override
  String get contactUnverified =>
      'Um contato adicionado assim começa não verificado. Qualquer um pode criar um cartão e colocar qualquer nome nele, então compare as impressões digitais pessoalmente ou por chamada antes de confiar na identidade.';

  @override
  String get contactRelayOff =>
      'A alternativa pela internet está desligada, então um cartão ainda não alcança ninguém.';

  @override
  String get contactRelayEnable => 'Ligar';

  @override
  String get profileContactCard => 'Cartão de contato';

  @override
  String get chatsAddContactTooltip => 'Adicionar contato por cartão';

  @override
  String get chatsMenuTooltip => 'Mais';

  @override
  String get chatsMenuAddContact => 'Adicionar contato';

  @override
  String get chatsMenuNewChannel => 'Novo canal';

  @override
  String get profileDiscoverable => 'Visível por perto';

  @override
  String get profileDiscoverableOnHint =>
      'Qualquer pessoa ao alcance pode te encontrar';

  @override
  String get profileDiscoverableOffHint => 'Só seus contatos podem te alcançar';

  @override
  String get profileDiscoverableExplainer =>
      'Ativado, seu anúncio é transmitido abertamente para que desconhecidos possam te conhecer só de chegar perto — e quem estiver ouvindo registra sua chave e seu nome. Desativado, o mesmo pacote vai só para os contatos que você já tem, lacrado, e seus IDs de roteamento não podem ser vinculados. Pessoas novas passam a precisar de um cartão de contato.';

  @override
  String get voiceHoldHint => 'Segure para gravar uma mensagem de voz';

  @override
  String get voiceTrimPlay => 'Reproduzir';

  @override
  String get voiceTrimPause => 'Pausar';

  @override
  String get voiceTrimDiscard => 'Descartar gravação';

  @override
  String voiceTrimSelection(String duration) {
    return 'Enviando $duration';
  }

  @override
  String get profileLastSeen => 'Mostrar visto por último';

  @override
  String get profileLastSeenOnHint => 'Contatos veem quando você está no app';

  @override
  String get profileLastSeenOffHint =>
      'Ninguém vê o seu horário, e você não vê o de ninguém: só quem está online';

  @override
  String get profileMapLocation => 'Mostrar-me no mapa';

  @override
  String get profileMapLocationOnHint =>
      'A localização fica disponível para envio manual e seu marcador aparece no mapa';

  @override
  String get profileMapLocationOffHint =>
      'O app não pede a localização e seu marcador fica oculto';

  @override
  String get desktopAutostartTitle => 'Iniciar com o Windows';

  @override
  String get desktopAutostartHint =>
      'O CubeChat espera na bandeja do sistema, então chamadas e mensagens chegam a este computador com a janela fechada';

  @override
  String get trayOpen => 'Abrir o CubeChat';

  @override
  String get trayQuit => 'Sair';

  @override
  String get callDirectTitle => 'Chamadas diretas';

  @override
  String get callDirectOnHint =>
      'Mais rápido, mas a pessoa para quem você liga descobre seu endereço IP';

  @override
  String get callDirectOffHint =>
      'As chamadas passam pelo nosso relay: a pessoa nunca vê seu IP, e o relay não consegue ouvir a chamada';

  @override
  String get profileReadReceipts => 'Confirmações de leitura';

  @override
  String get profileReadReceiptsOnHint => 'Quem enviou vê quando você leu';

  @override
  String get profileReadReceiptsOffHint =>
      'Você para de enviar seu horário de leitura, mas continua vendo o dos outros';

  @override
  String get profilePrivacyExplainer =>
      'O visto por último vale nos dois sentidos: se você esconder o seu status, deixa de ver o dos outros. As confirmações de leitura só controlam o que você envia. A entrega das mensagens não muda.';

  @override
  String get chatTimerAction => 'Timer';

  @override
  String get chatTimerRemove => 'Remover timer';

  @override
  String get chatTimerTitle => 'Apagar esta mensagem após';

  @override
  String chatTimerSet(String time) {
    return 'Esta mensagem some em $time';
  }

  @override
  String get chatTimerLocalHint =>
      'Só neste dispositivo — a cópia da outra pessoa é dela';

  @override
  String get contactTagAction => 'Etiqueta';

  @override
  String get contactTagRemove => 'Remover etiqueta';

  @override
  String get contactTagTitle => 'Escolha uma etiqueta';

  @override
  String get contactTagAll => 'Todos';

  @override
  String get quietHoursTitle => 'Horário silencioso';

  @override
  String get quietHoursHint =>
      'As mensagens continuam chegando; o celular fica em silêncio';

  @override
  String get quietHoursFrom => 'De';

  @override
  String get quietHoursTo => 'Até';

  @override
  String get notifPreviewTitle => 'Mostrar nas notificações';

  @override
  String get notifPreviewFull => 'Nome e texto';

  @override
  String get notifPreviewNameOnly => 'Só o nome';

  @override
  String get notifPreviewHidden => 'Nada';

  @override
  String get notifPreviewHint =>
      'As notificações ficam visíveis na tela de bloqueio e para apps com acesso às notificações, mesmo com o bloqueio do app ativado';

  @override
  String get notifPreviewNewMessage => 'Nova mensagem';

  @override
  String get appLockTitle => 'Bloqueio do app';

  @override
  String get appLockHint => 'Pedir um código ao abrir o app';

  @override
  String get appLockPrompt => 'Digite seu código';

  @override
  String get appLockUnlock => 'Desbloquear';

  @override
  String get appLockWrong => 'Código incorreto';

  @override
  String get appLockSetTitle => 'Definir um código';

  @override
  String get appLockSetHint =>
      'Quatro dígitos ou mais. Não há como recuperá-lo.';

  @override
  String get appLockOffTitle => 'Desativar o bloqueio';

  @override
  String get appLockOffHint => 'Digite seu código atual';

  @override
  String get appLockOn => 'Bloqueio do app ativado';

  @override
  String get appLockOff => 'Bloqueio do app desativado';

  @override
  String get avatarSet => 'Escolher foto';

  @override
  String get avatarChange => 'Trocar foto';

  @override
  String get avatarView => 'Ver foto';

  @override
  String get profileCoverPhoto =>
      'Foto do perfil, toque duas vezes para ampliar';

  @override
  String get profileCoverMenu => 'Opções da foto';

  @override
  String get avatarSaved => 'Salva na galeria';

  @override
  String get avatarRemove => 'Remover foto';

  @override
  String get avatarRemoveConfirm =>
      'A foto será apagada deste dispositivo. O degradê gerado volta no lugar dela.';

  @override
  String get avatarFailed => 'Não foi possível ler essa imagem';

  @override
  String get fileOpenHint => 'Toque para abrir';

  @override
  String get fileMissing => 'Esse arquivo não está mais disponível';

  @override
  String get fileNoHandlerTitle => 'Nenhum app abre isto';

  @override
  String get fileNoHandlerHint =>
      'Nenhum app instalado abre este tipo de arquivo. Você pode enviá-lo para outro app.';

  @override
  String get fileRequestedAgain => 'Pedimos de novo a quem enviou';

  @override
  String get fileOpenFailed => 'Não foi possível abrir este arquivo';

  @override
  String get fileShareAction => 'Enviar para app';

  @override
  String fileTooLargeMesh(int limit) {
    return 'Arquivo grande demais — o limite pela mesh é $limit MB';
  }

  @override
  String fileTooLargeRelay(int limit) {
    return 'Pela internet o limite é $limit MB. Chegue mais perto da pessoa para enviar um arquivo maior.';
  }

  @override
  String get mediaSendOriginal => 'Original';

  @override
  String get attachFile => 'Arquivo';

  @override
  String get attachGallery => 'Galeria';

  @override
  String get attachCamera => 'Câmera';

  @override
  String get cameraUnavailable => 'Câmera indisponível';

  @override
  String get profileEditName => 'Nome';

  @override
  String get profileMyCard => 'Cartão';

  @override
  String get mediaCaptionHint => 'Adicionar legenda…';

  @override
  String get mediaDiscardTitle => 'Descartar seleção?';

  @override
  String get mediaDiscardMessage =>
      'Fechar a galeria e descartar as fotos selecionadas?';

  @override
  String get mediaDiscardConfirm => 'Descartar';

  @override
  String get mediaPhotosAccessOff => 'Acesso às fotos desativado';

  @override
  String get mediaPhotosAccessOffHint =>
      'No momento o CubeChat só vê vídeos. Permita o acesso às fotos nas configurações do sistema para mostrar suas imagens.';

  @override
  String get mediaVideosOnly =>
      'Só os vídeos estão visíveis — permita o acesso às fotos';

  @override
  String get mediaOpenSettings => 'Abrir configurações';

  @override
  String get mediaTakePhoto => 'Tirar foto';

  @override
  String get contactProfileAutoDelete => 'Apagar conversa automaticamente';

  @override
  String get contactProfileAutoDeleteTitle =>
      'Apagar mensagens automaticamente';

  @override
  String get contactProfileAutoDeleteOff => 'Desativado';

  @override
  String get contactProfileAutoDeleteOneDay => 'Após 1 dia';

  @override
  String get contactProfileAutoDeleteSevenDays => 'Após 7 dias';

  @override
  String get contactProfileAutoDeleteThirtyDays => 'Após 30 dias';

  @override
  String contactProfileAutoDeleteUpdated(String period) {
    return 'Apagar automaticamente: $period';
  }

  @override
  String get contactProfileShare => 'Compartilhar contato';

  @override
  String get contactProfileShareTitle => 'Enviar contato para';

  @override
  String get contactProfileShareEmpty => 'Nenhuma outra conversa ainda';

  @override
  String contactProfileShareSent(String name) {
    return 'Enviado para $name';
  }

  @override
  String get contactProfileRestrictCopying => 'Bloquear cópia';

  @override
  String get contactProfileAllowCopying => 'Permitir cópia';

  @override
  String get contactHideAvatar => 'Ocultar minha foto';

  @override
  String get contactShowAvatar => 'Mostrar minha foto';

  @override
  String get contactHideLastSeen => 'Ocultar meu visto por último';

  @override
  String get contactShowLastSeen => 'Mostrar meu visto por último';

  @override
  String get contactHideReadReceipts => 'Ocultar meus horários de leitura';

  @override
  String get contactShowReadReceipts => 'Mostrar meus horários de leitura';

  @override
  String get contactHiddenFromThem => 'Oculto para este contato';

  @override
  String get contactRefuseCalls => 'Não aceitar chamadas dele';

  @override
  String get contactAllowCalls => 'Aceitar chamadas dele';

  @override
  String get contactCallsException =>
      'Uma exceção à sua configuração de chamadas';

  @override
  String get contactProfileCopyingRestricted =>
      'Cópia e encaminhamento bloqueados';

  @override
  String get contactProfileCopyingRestrictedByPeer =>
      'Bloqueado pela outra pessoa';

  @override
  String get contactProfileCopyingAllowed =>
      'Cópia e encaminhamento permitidos';

  @override
  String get contactProfileDelete => 'Remover dos contatos';

  @override
  String get contactProfileRestore => 'Adicionar de volta aos contatos';

  @override
  String get contactProfileRestoreDone => 'De volta aos seus contatos';

  @override
  String get contactProfileDeleteTitle => 'Remover contato?';

  @override
  String contactProfileDeleteMessage(String name) {
    return '$name vai sumir dos Contatos. O histórico da conversa continua neste dispositivo.';
  }

  @override
  String get contactProfileMedia => 'Mídia';

  @override
  String get contactProfileVoiceMessages => 'Mensagens de voz';

  @override
  String get contactProfileStickers => 'Figurinhas';

  @override
  String get contactProfileNoStickers => 'Nenhuma figurinha ainda';

  @override
  String get contactProfileNoMedia => 'Nenhuma mídia ainda';

  @override
  String get contactProfileNoVoiceMessages => 'Nenhuma mensagem de voz ainda';

  @override
  String get contactProfileOpen => 'Abrir perfil';

  @override
  String autoDeleteDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dias',
      one: '$count dia',
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
  String get autoDeleteCustom => 'Personalizar…';

  @override
  String get autoDeleteCustomHint => 'Quantidade';

  @override
  String get autoDeleteUnitMinutes => 'min';

  @override
  String get autoDeleteUnitHours => 'horas';

  @override
  String get autoDeleteUnitDays => 'dias';

  @override
  String get contactProfileAutoDeleteSet => 'Definir';

  @override
  String get contactProfileFiles => 'Arquivos';

  @override
  String get contactProfileNoFiles => 'Nenhum arquivo ainda';

  @override
  String get contactProfileLinks => 'Links';

  @override
  String get contactProfileNoLinks => 'Nenhum link ainda';

  @override
  String get contactProfilePolls => 'Enquetes';

  @override
  String get contactProfileNoPolls => 'Nenhuma enquete ainda';

  @override
  String get presenceRecently => 'visto recentemente';

  @override
  String get presenceJustNow => 'agora mesmo';

  @override
  String presenceHoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'visto há $count horas',
      one: 'visto há $count hora',
    );
    return '$_temp0';
  }

  @override
  String presenceYesterdayAt(String time) {
    return 'visto ontem às $time';
  }

  @override
  String presenceOnWeekday(String day) {
    String _temp0 = intl.Intl.selectLogic(
      day,
      {
        '1': 'visto na segunda-feira',
        '2': 'visto na terça-feira',
        '3': 'visto na quarta-feira',
        '4': 'visto na quinta-feira',
        '5': 'visto na sexta-feira',
        '6': 'visto no sábado',
        '7': 'visto no domingo',
        'other': 'visto esta semana',
      },
    );
    return '$_temp0';
  }

  @override
  String presenceWeeksAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'visto há $count semanas',
      one: 'visto há uma semana',
    );
    return '$_temp0';
  }

  @override
  String presenceMonthsAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'visto há $count meses',
      one: 'visto há um mês',
    );
    return '$_temp0';
  }

  @override
  String get presenceLongAgo => 'visto há muito tempo';

  @override
  String presenceMinutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'visto há $count minutos',
      one: 'visto há $count minuto',
    );
    return '$_temp0';
  }

  @override
  String chatReadByCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Lida por $count',
      one: 'Lida por $count',
    );
    return '$_temp0';
  }

  @override
  String get chatsSearchFrequent => 'Com quem você conversa';

  @override
  String get chatsSearchRecent => 'Recentes';

  @override
  String get chatsSearchClear => 'Limpar';

  @override
  String get chatsSearchStartHint =>
      'Busque conversas pelo nome, ou qualquer mensagem pelas palavras.';

  @override
  String get chatsSearchEmpty => 'Nada encontrado';

  @override
  String get chatRoutesTitle => 'Como isto chega à pessoa';

  @override
  String get chatRoutesBluetoothHint =>
      'Direto para o celular dela, sem internet';

  @override
  String get chatRoutesMeshHint => 'Repassada pelos celulares no caminho';

  @override
  String get chatRoutesInternetHint =>
      'Por um relay, quando não há ninguém ao alcance';

  @override
  String get chatRoutesHint =>
      'O caminho é escolhido a cada mensagem, entre o que estiver acessível naquele momento.';

  @override
  String get chatRoutesPreferTitle => 'O que tentar primeiro';

  @override
  String get chatRoutesPreferMesh => 'Bluetooth primeiro';

  @override
  String get chatRoutesPreferMeshHint =>
      'Mais rápido no mesmo ambiente, não gasta dados e não conta nada a um relay';

  @override
  String get chatRoutesPreferRelay => 'Internet primeiro';

  @override
  String get chatRoutesPreferRelayHint =>
      'Para Bluetooth fraco e uma boa conexão';

  @override
  String get chatRoutesPreferNote =>
      'Uma preferência, não uma trava. Se o caminho escolhido não estiver acessível, o outro ainda leva a mensagem.';

  @override
  String get deadmanTitle => 'Apagar se não for usado';

  @override
  String get deadmanOff => 'Desativado';

  @override
  String deadmanDays(int days) {
    return 'Após $days dias';
  }

  @override
  String get deadmanHint =>
      'Se ninguém abrir este app por esse tempo, tudo nele será apagado na próxima vez que for aberto. Ele não pode avisar antes — esse é o objetivo.';

  @override
  String chatForwardedFrom(String name) {
    return 'Encaminhada de $name';
  }

  @override
  String appLockWait(String left) {
    return 'Tentativas demais — aguarde $left';
  }

  @override
  String get appLockGraceTitle => 'Pedir o código';

  @override
  String get appLockGraceNow => 'Sempre';

  @override
  String appLockGraceAfter(String left) {
    return 'Após $left fora';
  }

  @override
  String get chatCalendarTitle => 'Por data';

  @override
  String get chatCalendarEmpty => 'Nada foi dito aqui ainda';

  @override
  String get chatsSearchChatsSection => 'Conversas';

  @override
  String get chatsSearchMessagesSection => 'Mensagens';

  @override
  String get contactProfileViewInChat => 'Ver na conversa';

  @override
  String get chatDraft => 'Rascunho';

  @override
  String get chatSearchTitle => 'Buscar';

  @override
  String get chatSearchHint => 'Buscar mensagens';

  @override
  String get chatSearchNoResults => 'Nenhum resultado';

  @override
  String get chatSearchPrevious => 'Resultado anterior';

  @override
  String get chatSearchNext => 'Próximo resultado';

  @override
  String chatMessageCount(int count) {
    return '$count mensagens';
  }

  @override
  String get chatRouteBluetooth => 'Bluetooth';

  @override
  String get chatRouteMesh => 'Mesh';

  @override
  String get chatRouteInternet => 'Internet';

  @override
  String get chatRouteQueued => 'Na fila';

  @override
  String get attachStickers => 'Figurinhas';

  @override
  String get stickersEmpty => 'Nenhuma figurinha ainda';

  @override
  String get stickersEmptyHint =>
      'Guarde uma imagem de uma conversa e ela aparece aqui.';

  @override
  String get stickerKeep => 'Salvar como figurinha';

  @override
  String get stickerKept => 'Salva nas suas figurinhas';

  @override
  String get stickerForget => 'Remover figurinha';

  @override
  String get stickerCreate => 'Criar figurinha a partir de uma foto';

  @override
  String get stickerFailed =>
      'Não foi possível transformar essa imagem em figurinha';

  @override
  String get stickerLabel => 'Figurinha';

  @override
  String get previewPhoto => 'Foto';

  @override
  String get previewVoice => 'Mensagem de voz';

  @override
  String get previewFile => 'Arquivo';

  @override
  String get stickerEmojiTitle => 'Escolha um emoji para ela';

  @override
  String get stickersMine => 'Minhas figurinhas';

  @override
  String get stickersStarterPack => 'Cubi';

  @override
  String get emojiTab => 'Emoji';

  @override
  String get chatBlockedStatus => 'bloqueado';

  @override
  String get chatBlockedHint => 'Você bloqueou esta pessoa';

  @override
  String get chatRouteFallbackOff => 'Internet desl.';

  @override
  String get chatAttachmentUnavailable =>
      'Nenhuma conexão disponível. Conecte-se por Bluetooth ou pela internet e tente de novo.';

  @override
  String get fileTransfersTitle => 'Transferências';

  @override
  String get fileTransfersClear => 'Limpar histórico';

  @override
  String get fileTransfersEmpty => 'Nenhuma transferência de arquivo ainda';

  @override
  String get fileTransfersActive => 'Ativas';

  @override
  String get fileTransfersHistory => 'Histórico';

  @override
  String get fileTransferPause => 'Pausar';

  @override
  String get fileTransferResume => 'Retomar';

  @override
  String get fileTransferRetry => 'Tentar de novo';

  @override
  String get fileTransferQueued => 'Aguardando conexão';

  @override
  String get fileTransferRunning => 'Transferindo';

  @override
  String get fileTransferPaused => 'Pausada';

  @override
  String get fileTransferCompleted => 'Concluída';

  @override
  String get fileTransferFailed => 'Falhou';

  @override
  String get fileTransferCanceled => 'Cancelada';

  @override
  String get profileFileTransfers => 'Transferências de arquivos';

  @override
  String get profileFileTransfersSubtitle =>
      'Progresso, fila e histórico de transferências';

  @override
  String get qrScanAction => 'Ler código QR';

  @override
  String get qrScanTitle => 'Ler código QR';

  @override
  String get qrScanHint =>
      'Leia um código do CubeChat de contato, canal, transferência de conta ou login no computador.';

  @override
  String get qrFlash => 'Lanterna';

  @override
  String get qrCameraError =>
      'Câmera indisponível. Verifique a permissão da câmera e tente de novo.';

  @override
  String get qrInvalid => 'Este não é um código QR válido do Cubechat.';

  @override
  String qrChannelAdded(String name) {
    return '$name adicionado';
  }

  @override
  String get qrShow => 'Mostrar código QR';

  @override
  String qrChannelTitle(String name) {
    return 'Entrar em $name';
  }

  @override
  String get profileBackup => 'Backup criptografado';

  @override
  String get profileBackupSubtitle =>
      'Transfira chaves, contatos e histórico com segurança';

  @override
  String get backupTitle => 'Backup criptografado';

  @override
  String get backupExplainer =>
      'O backup contém suas chaves privadas de identidade, contatos, canais, configurações e histórico de mensagens. Ele é criptografado neste celular com a senha que você escolher; o Cubechat não consegue recuperar uma senha esquecida.';

  @override
  String get backupCreate => 'Criar backup';

  @override
  String get backupCreateSubtitle =>
      'Criptografar tudo e salvar um arquivo .cchatbackup';

  @override
  String get backupRestore => 'Restaurar backup';

  @override
  String get backupRestoreSubtitle =>
      'Substituir o perfil do Cubechat deste celular a partir de um arquivo de backup';

  @override
  String get backupPasswordTitle => 'Senha do backup';

  @override
  String get backupPasswordHint => 'Pelo menos 8 caracteres';

  @override
  String get backupConfirmPassword => 'Repita a senha';

  @override
  String get backupPasswordMismatch => 'As senhas não coincidem';

  @override
  String get backupPasswordShort => 'Use pelo menos 8 caracteres';

  @override
  String get backupSaveTitle => 'Salvar backup do Cubechat';

  @override
  String get backupSaved => 'Backup criptografado salvo';

  @override
  String get backupWhereTitle => 'Onde salvar o backup?';

  @override
  String get backupSaveToFiles => 'Salvar em Arquivos';

  @override
  String get backupSaveToFilesHint =>
      'Uma pasta neste celular, um cartão de memória ou um drive na nuvem';

  @override
  String get backupSendToApp => 'Enviar para um app';

  @override
  String get backupSendToAppHint =>
      'Telegram, e-mail, um mensageiro — qualquer coisa que aceite arquivos';

  @override
  String get backupFailed => 'Não foi possível concluir a operação de backup';

  @override
  String get backupRestoreConfirmTitle => 'Substituir este perfil?';

  @override
  String get backupRestoreConfirmMessage =>
      'As chaves, contatos, canais, configurações e histórico atuais deste celular serão substituídos pelo backup selecionado.';

  @override
  String get backupRestoreConfirmAction => 'Restaurar';

  @override
  String get backupRestored => 'Backup restaurado';

  @override
  String get backupPackingWait => 'Criando o backup…';

  @override
  String get backupUnpackingWait => 'Restaurando o backup…';

  @override
  String get backupWaitHint =>
      'Com fotos e vídeos, isso pode levar alguns minutos. Mantenha o app aberto.';

  @override
  String get backupInvalid =>
      'Senha incorreta, arquivo danificado ou backup não suportado';

  @override
  String get channelInfoTitle => 'Detalhes do canal';

  @override
  String get channelParticipantsTitle => 'Participantes';

  @override
  String get channelAdministratorsTitle => 'Administradores';

  @override
  String get channelMakeAdmin => 'Tornar administrador';

  @override
  String get channelRemoveAdmin => 'Remover administrador';

  @override
  String get channelNoParticipants =>
      'Os participantes aparecerão após atividade assinada';

  @override
  String get channelSharedContent => 'Mídia, arquivos e enquetes';

  @override
  String get channelDescriptionTitle => 'Descrição';

  @override
  String get channelDescriptionEmpty => 'Nenhuma descrição ainda';

  @override
  String get channelDescriptionHint => 'Para que serve este canal';

  @override
  String get channelDescriptionAdminOnly =>
      'Só um administrador pode mudar a descrição';

  @override
  String get channelDescriptionSave => 'Salvar';

  @override
  String get channelPrivateSubtitle => 'canal privado';

  @override
  String get channelAvatarSet => 'Definir nova foto';

  @override
  String get channelSettingsTitle => 'Configurações do canal';

  @override
  String get channelSettingsHint => 'Quem pode publicar, cópia, histórico';

  @override
  String get channelLeaveAction => 'Sair';

  @override
  String get channelLeaveConfirm =>
      'A sala e tudo o que foi dito nela somem deste celular. A chave vem do nome, então você pode abri-la de novo digitando o mesmo nome.';

  @override
  String get channelShareAction => 'Compartilhar';

  @override
  String channelMembersOf(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count membros',
      one: '1 membro',
    );
    return '$_temp0';
  }

  @override
  String get chatTyping => 'digitando…';

  @override
  String get chatRecordingVoice => 'gravando áudio…';

  @override
  String get chatRecordingCircle => 'gravando vídeo…';

  @override
  String get chatSendingPhoto => 'enviando foto…';

  @override
  String get chatSendingVideo => 'enviando vídeo…';

  @override
  String get chatSendingFile => 'enviando arquivo…';

  @override
  String get onboardingMeshTitle => 'Funciona sem internet';

  @override
  String get onboardingMeshBody =>
      'As mensagens viajam por Bluetooth, de celular para celular. Sem sinal, sem Wi-Fi, sem contas — só as pessoas ao seu redor.';

  @override
  String get onboardingRelayTitle => 'E com ela, quando houver';

  @override
  String get onboardingRelayBody =>
      'Fora do alcance do Bluetooth, as mensagens vão pela internet e chegam do mesmo jeito. Você nunca precisa escolher.';

  @override
  String get onboardingPrivacyTitle =>
      'Ninguém no meio do caminho consegue ler';

  @override
  String get onboardingPrivacyBody =>
      'Tudo tem criptografia de ponta a ponta, e sua identidade é uma chave neste celular — não um número de telefone, não um e-mail, não uma conta que alguém possa tirar de você.';

  @override
  String get onboardingSkip => 'Pular';

  @override
  String get onboardingNext => 'Avançar';

  @override
  String get onboardingStart => 'Começar';

  @override
  String get chatMediaShare => 'Compartilhar';

  @override
  String get chatMediaSaveToGallery => 'Salvar na galeria';

  @override
  String get chatMediaShowInChat => 'Mostrar na conversa';

  @override
  String get chatWallpaperTitle => 'Papel de parede';

  @override
  String get chatWallpaperClear => 'Redefinir';

  @override
  String get chatWallpaperDim => 'Escurecer atrás das mensagens';

  @override
  String get chatSelectAction => 'Selecionar';

  @override
  String get chatForwardNothing => 'Nada aqui pode ser encaminhado';

  @override
  String chatSelectedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count selecionadas',
      one: '1 selecionada',
    );
    return '$_temp0';
  }

  @override
  String chatDeleteSelectedTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Apagar $count mensagens?',
      one: 'Apagar esta mensagem?',
    );
    return '$_temp0';
  }

  @override
  String get contactAliasAction => 'Renomear contato';

  @override
  String get contactAliasHint =>
      'Só você vê este nome. Deixe vazio para usar o da pessoa.';

  @override
  String get viewOnceSendLabel => 'Ver uma vez';

  @override
  String get viewOnceTitle => 'Ver uma vez';

  @override
  String get viewOnceTapToView => 'Foto · toque para ver uma vez';

  @override
  String get viewOnceSent => 'Foto · enviada';

  @override
  String get viewOnceOpened => 'Foto aberta';

  @override
  String get viewOnceUnavailable => 'Esta foto não está mais disponível';

  @override
  String get viewOnceWarning =>
      'Ao fechar, a foto será apagada para vocês dois.';

  @override
  String get channelAvatarAdminOnly =>
      'Só um administrador pode mudar a foto do canal';

  @override
  String get channelAdminOnly => 'Só um administrador pode mudar isto';

  @override
  String get channelAvatarTooLarge =>
      'Essa foto é grande demais para transmitir';

  @override
  String get channelMemberUnknown => 'Ainda não está nos seus contatos';

  @override
  String get channelInviteToContacts => 'Enviar seu cartão de contato';

  @override
  String channelContactInviteSent(String name) {
    return 'Cartão de contato oferecido a $name';
  }

  @override
  String get chatContactInvitation => 'Convite para se conectar';

  @override
  String get chatContactInvitationForYou => 'Convite para você';

  @override
  String get channelPollTitle => 'Enquete';

  @override
  String get channelCreatePoll => 'Criar enquete';

  @override
  String get channelPollQuestion => 'Pergunta';

  @override
  String channelPollOption(int number) {
    return 'Opção $number';
  }

  @override
  String get channelPollAddOption => 'Adicionar opção';

  @override
  String get channelPollCreate => 'Publicar enquete';

  @override
  String channelPollVotes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count votos',
      one: '1 voto',
      zero: 'Nenhum voto',
    );
    return '$_temp0';
  }

  @override
  String get phoneTransferTitle => 'Transferir para um novo celular';

  @override
  String get desktopPickChat => 'Escolha para quem você quer escrever';

  @override
  String get desktopListCollapse => 'Mostrar só as fotos';

  @override
  String get desktopListExpand => 'Mostrar a lista de conversas';

  @override
  String get desktopLinkConnectTitle => 'Conectar um computador';

  @override
  String get desktopLinkConnectHint =>
      'Leia o código que o CubeChat mostra no computador';

  @override
  String get desktopLinkSignIn => 'Entrar com a conta do meu celular';

  @override
  String get desktopLinkTitle => 'Entrar com o seu celular';

  @override
  String get desktopLinkSteps =>
      'No celular: Perfil → Dados → Conectar um computador, depois leia este código. Os dois precisam estar no mesmo Wi-Fi.';

  @override
  String get desktopLinkLimits =>
      'O celular continua funcionando. Mensagens vindas da internet chegam aos dois; o que você envia de um ainda não aparece no outro.';

  @override
  String get desktopLinkWaiting => 'Aguardando o celular…';

  @override
  String get desktopLinkFailed =>
      'Não foi possível receber a conta. Tente de novo.';

  @override
  String get desktopLinkRetry => 'Tentar de novo';

  @override
  String get desktopLinkConfirmTitle =>
      'Enviar uma cópia desta conta para o computador?';

  @override
  String get desktopLinkConfirmMessage =>
      'O computador recebe suas chaves, contatos e conversas. Este celular continua funcionando como está.';

  @override
  String get desktopLinkConfirmAction => 'Enviar';

  @override
  String desktopLinkConfirmWhere(String address) {
    return 'Só se você acabou de ler este código na tela do seu próprio computador. A cópia vai para $address nesta rede.';
  }

  @override
  String get desktopLinkSending => 'Enviando a conta…';

  @override
  String get desktopLinkSent => 'O computador está conectado';

  @override
  String get desktopLinkPhoneFound =>
      'O celular encontrou este computador e está fazendo uma cópia da conta. Com fotos, isso pode levar alguns minutos.';

  @override
  String desktopLinkReceiving(int percent) {
    return 'Recebendo a conta: $percent%';
  }

  @override
  String get desktopLinkRestoring => 'Instalando a conta neste computador…';

  @override
  String get desktopLinkFinding => 'Procurando o computador…';

  @override
  String get desktopLinkPreparing =>
      'Fazendo uma cópia da conta. Com fotos, isso pode levar alguns minutos.';

  @override
  String desktopLinkSendingPercent(int percent) {
    return 'Enviando: $percent%';
  }

  @override
  String get desktopLinkComputerRestoring =>
      'O computador está instalando a conta…';

  @override
  String get devicesTitle => 'Dispositivos';

  @override
  String get devicesRowHint =>
      'Onde sua conta está aberta, e como sair dela lá';

  @override
  String get devicesThisDevice => 'Este dispositivo';

  @override
  String get devicesSeenNow => 'Online agora mesmo';

  @override
  String devicesSeenMinutes(int n) {
    return 'Online há $n min';
  }

  @override
  String devicesSeenHours(int n) {
    return 'Online há $n h';
  }

  @override
  String devicesSeenDays(int n) {
    return 'Online há $n d';
  }

  @override
  String get devicesLeaving => 'Saindo — aguardando ele ficar online';

  @override
  String get devicesSignOut => 'Sair';

  @override
  String get devicesSignOutAll => 'Sair de todos os outros dispositivos';

  @override
  String devicesSignOutTitle(String name) {
    return 'Sair em \"$name\"?';
  }

  @override
  String get devicesSignOutMessage =>
      'As chaves, conversas e configurações do CubeChat serão apagadas naquele dispositivo assim que ele ficar online. A conta continua aqui e nos seus outros dispositivos.';

  @override
  String get devicesSignOutPhoneMessage =>
      'Esse é um celular: o CubeChat será apagado nele por completo. A conta continua aqui e nos seus outros dispositivos.';

  @override
  String get devicesSignOutAllMessage =>
      'Todos os outros dispositivos sairão assim que ficarem online. A conta continuará só aqui.';

  @override
  String get devicesRename => 'Renomear';

  @override
  String get devicesRenameTitle => 'Nome deste dispositivo';

  @override
  String get devicesSave => 'Salvar';

  @override
  String get devicesEmpty =>
      'Nenhum outro dispositivo ainda. Um dispositivo aparece aqui quando abrir o CubeChat 1.0.0+1147 ou mais recente.';

  @override
  String get devicesCaveat =>
      'A saída vale quando o dispositivo ficar online. Um que for mantido offline continua com as chaves; a proteção completa exigiria novas chaves para a conta.';

  @override
  String get desktopLinkImportTitle => 'Trazer a conta do seu celular';

  @override
  String get desktopLinkImportHint =>
      'Mostre um código ao celular e este computador vira uma cópia da conta dele';

  @override
  String get desktopLinkImportConfirmTitle =>
      'Substituir a conta neste computador?';

  @override
  String get desktopLinkImportConfirmMessage =>
      'As chaves, contatos e conversas deste computador serão substituídos pela conta do celular. Se você ainda precisa desta, faça um backup antes.';

  @override
  String get desktopLinkImportConfirmAction => 'Continuar';

  @override
  String get desktopLinkUnreachable =>
      'Não foi possível alcançar o computador. Os dois precisam estar no mesmo Wi-Fi, e no computador o CubeChat precisa ser liberado no firewall.';

  @override
  String get desktopLinkFirewallHint =>
      'O Windows pode impedir o celular de chegar a este computador. Libere o CubeChat no firewall — só para a sua rede local.';

  @override
  String get desktopLinkFirewallAllow => 'Liberar no firewall';

  @override
  String get desktopLinkFirewallDeclined =>
      'O Windows não liberou. Sem isso, o celular pode não conseguir se conectar.';

  @override
  String get phoneTransferIntro =>
      'Transfira seu perfil, chaves, contatos, canais, configurações e histórico diretamente entre dois celulares.';

  @override
  String get phoneTransferSend => 'Este é o celular antigo';

  @override
  String get phoneTransferReceive => 'Este é o celular novo';

  @override
  String get phoneTransferSameWifi =>
      'Conecte os dois celulares ao mesmo Wi-Fi. Mantenha esta tela aberta até a transferência terminar.';

  @override
  String get phoneTransferPreparing =>
      'Preparando transferência criptografada…';

  @override
  String get phoneTransferReady =>
      'Leia este código QR de uso único no celular novo';

  @override
  String get phoneTransferScan => 'Ler o celular antigo';

  @override
  String get phoneTransferConfirmTitle => 'Substituir o perfil deste celular?';

  @override
  String get phoneTransferConfirmMessage =>
      'O perfil guardado neste celular será substituído pela transferência local criptografada.';

  @override
  String get phoneTransferConfirmAction => 'Transferir perfil';

  @override
  String get phoneTransferSuccess => 'Perfil transferido com sucesso';

  @override
  String get phoneTransferFailed => 'Não foi possível concluir a transferência';

  @override
  String get profileSummaryMeshOnly => 'Só mesh';

  @override
  String get profileSummaryMeshInternet => 'Mesh · internet';

  @override
  String get profileSummaryBackgroundOn => 'roda em segundo plano';

  @override
  String profileSummaryTransfersActive(int count) {
    return '$count em andamento';
  }

  @override
  String get profileSummaryCardBackup => 'Arquivos, backup';

  @override
  String get chatPlay => 'Reproduzir';

  @override
  String get chatPause => 'Pausar';

  @override
  String get profileTheme => 'Cor';

  @override
  String get profileThemeEmerald => 'Esmeralda';

  @override
  String get profileThemeIndigo => 'Índigo';

  @override
  String get profileThemeAmber => 'Âmbar';

  @override
  String get profileThemeRose => 'Rosa';

  @override
  String get profileThemeFuchsia => 'Fúcsia';

  @override
  String get profileThemeViolet => 'Violeta';

  @override
  String get profileThemeOcean => 'Oceano';

  @override
  String get profileThemeSlate => 'Grafite';

  @override
  String get profileScale => 'Tamanho da interface';

  @override
  String get profileScaleSystem => 'Sistema';

  @override
  String get profileGlass => 'Vidro';

  @override
  String get profileGlassAuto => 'Automático';

  @override
  String get profileGlassFull => 'Completo';

  @override
  String get profileGlassLight => 'Leve';

  @override
  String get profileGlassHint =>
      'Leve mantém a cor e tira o desfoque atrás dos painéis. Automático mede seu celular uma vez e decide. Num celular que já dá conta, isso faz pouca diferença — é para um que não dá.';

  @override
  String get mapAlwaysNeeded =>
      'Para o mapa continuar atualizando com o cubechat fechado, a Localização precisa estar em Sempre. Toque para abrir os Ajustes.';

  @override
  String get mapShareConsentTitle => 'Mostrar sua localização no mapa?';

  @override
  String get mapShareConsentBody =>
      'Sua localização em tempo real será mostrada só aos contatos do seu mapa: pessoas que você convidou ou cujo convite você aceitou. Ela continua atualizando, inclusive com o Cubechat em segundo plano, até você se ocultar. Ela tem criptografia de ponta a ponta e nunca chega até nós. Você pode se ocultar a qualquer momento no mapa ou no Perfil, e contatos que você bloquear nunca te veem.';

  @override
  String get mapShareConsentAllow => 'Permitir';

  @override
  String get mapShareConsentDecline => 'Não permitir';

  @override
  String get mapVisibleToFriends => 'Amigos no seu mapa te veem';

  @override
  String get mapHiddenFromFriends => 'Você está oculto';

  @override
  String get mapHideMe => 'Ocultar';

  @override
  String get mapShowMe => 'Mostrar-me';

  @override
  String get profileScaleSmall => 'Menor';

  @override
  String get profileScaleNormal => 'Normal';

  @override
  String get profileScaleLarge => 'Maior';

  @override
  String get profileScaleSample =>
      'Textos e linhas são exibidos neste tamanho.';

  @override
  String get savedTitle => 'Salvas';

  @override
  String get savedSubtitle => 'Notas para você mesmo, neste dispositivo';

  @override
  String get savedEmpty => 'Tudo o que você escrever aqui fica neste celular.';

  @override
  String get meshOffTitle => 'Bluetooth mesh desligada';

  @override
  String get meshOffHint =>
      'Ninguém por perto consegue te encontrar e você não consegue encontrá-los. As mensagens continuam indo pelo relay da internet.';

  @override
  String get profileMeshSwitch => 'Bluetooth mesh';

  @override
  String get profileMeshSwitchHint =>
      'Encontra pessoas por perto e leva mensagens sem internet. Desligado, economiza bateria.';

  @override
  String get channelAdminOnlyHint =>
      'Um canal de avisos. Todos continuam podendo ler.';

  @override
  String get attachLocation => 'Localização';

  @override
  String get locationBubbleTitle => 'Localização';

  @override
  String get locationOpenInMaps => 'Abrir no mapa';

  @override
  String locationAccuracy(int metres) {
    return 'precisão de $metres m';
  }

  @override
  String get locationExpired => 'Esta localização não é mais atual';

  @override
  String get locationDenied => 'Permissão de localização desativada';

  @override
  String get locationUnavailable => 'Não foi possível obter a posição';

  @override
  String get locationShareFor => 'Compartilhar por';

  @override
  String get locationShareOnce => 'Só uma vez';

  @override
  String get locationShare15m => '15 minutos';

  @override
  String get locationShare1h => '1 hora';

  @override
  String get storageTitle => 'Armazenamento';

  @override
  String get storageHeadline => 'Uso do armazenamento';

  @override
  String storageSubtitle(String size) {
    return 'O cubechat está usando $size neste dispositivo';
  }

  @override
  String get storageEmpty => 'Nada armazenado ainda';

  @override
  String get storageScanning => 'Calculando…';

  @override
  String get storageCatPhotos => 'Fotos';

  @override
  String get storageCatVoice => 'Mensagens de voz';

  @override
  String get storageCatFiles => 'Arquivos recebidos';

  @override
  String get storageCatOutbox => 'Arquivos enviados';

  @override
  String get storageCatStickers => 'Figurinhas';

  @override
  String get storageCatSaved => 'Mensagens salvas';

  @override
  String get storageCatWallpapers => 'Papéis de parede';

  @override
  String get storageCatHistory => 'Conversas e chaves';

  @override
  String get storageCatCache => 'Cache';

  @override
  String storageClear(String size) {
    return 'Limpar $size';
  }

  @override
  String get storageClearNothing => 'Nada selecionado';

  @override
  String storageFreed(String size) {
    return '$size liberados';
  }

  @override
  String get storageNoCloud =>
      'Não há nuvem por trás disto. O que você limpar some deste celular, e a única outra cópia está no celular de onde veio.';

  @override
  String get storageWhyHistoryLocked =>
      'As conversas não são limpas por aqui — use o Apagamento de emergência.';

  @override
  String get storageRecoveryFree => 'Pode limpar com segurança';

  @override
  String get storageRecoveryGone => 'Não há cópia em nenhum outro lugar';

  @override
  String get storageRecoveryAskSender =>
      'Pode ser pedido de novo a quem enviou';

  @override
  String get storageRecoveryCostsThem =>
      'Não poderão mais pedir que você reenvie';

  @override
  String storageConfirmTitle(String size) {
    return 'Limpar $size?';
  }

  @override
  String get storageConfirmBody =>
      'Isso apaga os arquivos deste celular. Nada é enviado para lugar nenhum, então não há de onde restaurá-los.';

  @override
  String storageFilesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count arquivos',
      one: '$count arquivo',
      zero: 'vazio',
    );
    return '$_temp0';
  }

  @override
  String get customizeBarTitle => 'Barra de navegação';

  @override
  String get customizeBarHint =>
      'Arraste para reordenar. Conversas não pode ser removida.';

  @override
  String get customizeBarShown => 'Visíveis';

  @override
  String get customizeBarHidden => 'Ocultas';

  @override
  String get customizeBarHiddenEmpty => 'Nada oculto';

  @override
  String get customizeBarMinimum => 'Mantenha pelo menos duas abas';

  @override
  String get customizeReset => 'Restaurar padrão';

  @override
  String get chatsArchiveTitle => 'Arquivadas';

  @override
  String get chatsArchiveEmpty => 'Nada arquivado';

  @override
  String get chatsArchiveHint =>
      'Conversas arquivadas continuam funcionando — só ficam fora da lista.';

  @override
  String get chatsArchivedToast => 'Arquivada';

  @override
  String get chatsUnarchivedToast => 'De volta à lista';

  @override
  String chatsArchiveCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count conversas',
      one: '$count conversa',
    );
    return '$_temp0';
  }

  @override
  String get chatsSwipeNotHere => 'Indisponível para esta conversa';

  @override
  String get customizeSwipeTitle => 'Deslizar conversa para a direita';

  @override
  String get customizeSwipeHint =>
      'Deslizar para a esquerda continua alternando entre as abas.';

  @override
  String get customizeSwipeArchive => 'Arquivar';

  @override
  String get customizeSwipeMute => 'Silenciar';

  @override
  String get customizeSwipePin => 'Fixar';

  @override
  String get customizeSwipeRead => 'Marcar lida';

  @override
  String get customizeSwipeDelete => 'Apagar';

  @override
  String get customizeSwipeNone => 'Nada';

  @override
  String get customizeHighRefresh => 'Taxa de atualização máxima';

  @override
  String get customizeHighRefreshHint =>
      'Mais fluido, e o celular desenha o dobro de quadros. Desative se ele esquentar — a aparência do app não muda, só a frequência com que é redesenhado.';

  @override
  String get customizeQuickReaction => 'Reação com toque duplo';

  @override
  String get customizeQuickReactionHint =>
      'O que um toque duplo numa mensagem deixa. Se você usar outra, ela passa a ficar aqui.';

  @override
  String get customizeCircleAudioTitle =>
      'Pausar música nas mensagens de vídeo';

  @override
  String get customizeCircleAudioOn =>
      'Gravar ou assistir uma interrompe o que estiver tocando. Não volta a tocar sozinho.';

  @override
  String get customizeCircleAudioOff =>
      'Sua música continua tocando por baixo, mais baixa enquanto a mensagem de vídeo roda.';

  @override
  String get customizeMediaQualityTitle => 'Qualidade das fotos ao enviar';

  @override
  String get customizeMediaQualityEconomy => 'Econômica';

  @override
  String get customizeMediaQualityStandard => 'Padrão';

  @override
  String get customizeMediaQualityHigh => 'Alta';

  @override
  String get customizeMediaQualityEconomyHint =>
      'Até 96 KB por foto, 800 px. Para sinal de uma barrinha ou uma Bluetooth mesh lotada: metade da espera, imagem mais suave.';

  @override
  String get customizeMediaQualityStandardHint =>
      'Até 192 KB por foto, 1280 px. No tamanho certo para passar mesmo só por Bluetooth. Vídeos e \"Original\" sempre são enviados como estão.';

  @override
  String get customizeMediaQualityHighHint =>
      'Até 768 KB por foto, 2048 px. Nítida o bastante para dar zoom; leva quatro vezes mais para enviar, então é melhor no Wi-Fi.';

  @override
  String get previewReacted => 'à sua mensagem';

  @override
  String get previewLocation => 'Localização';

  @override
  String get previewMapInvite => 'Convite para o mapa';

  @override
  String get previewContact => 'Contato';

  @override
  String get previewUnsupported => 'Mensagem não suportada';

  @override
  String get previewCallOutgoing => 'Chamada feita';

  @override
  String get previewCallIncoming => 'Chamada recebida';

  @override
  String get previewCallMissed => 'Chamada perdida';

  @override
  String chatPreparingPhotos(int count) {
    return 'Preparando $count fotos…';
  }

  @override
  String get circleSwitchCamera => 'Trocar câmera';

  @override
  String get circleLight => 'Luz de gravação';

  @override
  String get circleCameraSwitchFailed =>
      'Não foi possível trocar de câmera. Sua gravação continua aberta.';

  @override
  String get diagnosticsTitle => 'Diagnóstico';

  @override
  String get diagnosticsIntro =>
      'O que o app tem feito ultimamente. Se algo não funcionar, envie isto ao desenvolvedor.';

  @override
  String get diagnosticsShare => 'Enviar log ao desenvolvedor';

  @override
  String get diagnosticsEvents => 'Eventos recentes';

  @override
  String get diagnosticsTechnical => 'Registros técnicos';

  @override
  String get diagnosticsEmpty => 'Nada para mostrar ainda.';

  @override
  String get diagnosticsDeveloperOn => 'Modo desenvolvedor ativado';

  @override
  String get diagnosticsDeveloperOff => 'Modo desenvolvedor desativado';

  @override
  String get logAppStarted => 'App iniciado';

  @override
  String get logInternetOn => 'Conexão pela internet ativada';

  @override
  String logServerConnected(String host) {
    return 'Conectado a $host';
  }

  @override
  String logServerLost(String host) {
    return 'Conexão perdida com $host';
  }

  @override
  String get chatSaveAction => 'Salvar';

  @override
  String get savedTagAsk => 'Salva. Adicionar uma tag?';

  @override
  String get savedTagAdd => 'Adicionar tag';

  @override
  String get chatSharedWallpaperFailed =>
      'Papel de parede definido aqui. Ele chegará à outra pessoa quando ela estiver ao alcance.';

  @override
  String get chatTranscribeAction => 'Transcrever';

  @override
  String get chatTranscribeFailed =>
      'Este celular não consegue transcrever esta.';

  @override
  String get chatTranscribing => 'Reconhecendo…';

  @override
  String get chatTranscriptHide => 'Ocultar texto';

  @override
  String get chatCancelSend => 'Cancelar envio';

  @override
  String get chatDownloadAction => 'Baixar';

  @override
  String get chatDownloaded => 'Salvo no celular';

  @override
  String get chatDownloadFailed => 'Não foi possível salvar';

  @override
  String get selfUpdateTitle => 'Instalar atualização de um arquivo';

  @override
  String get selfUpdateHint =>
      'Escolha o novo APK do cubechat aqui em vez de abri-lo a partir de uma conversa: instalado assim, as chamadas na tela de bloqueio continuam ativadas.';

  @override
  String get selfUpdateConfirm => 'Confirme a instalação na janela do sistema.';

  @override
  String get selfUpdateAllow =>
      'Permita que o cubechat instale apps e toque de novo.';

  @override
  String get selfUpdateNotOurs =>
      'Esse arquivo não é uma atualização do cubechat.';

  @override
  String get selfUpdateFailed => 'A atualização não foi instalada.';

  @override
  String get chatTranscribeDownloading =>
      'O celular está baixando o idioma para isso. Tente de novo em um minuto.';

  @override
  String get chatTranscribeNoLanguage =>
      'Este celular não tem modelo de fala para esse idioma. Escolha o idioma da transcrição em Perfil → Conversas e mídia.';

  @override
  String get chatTranscribeNotAllowed =>
      'O reconhecimento de fala está desativado para o CubeChat. Ative em Ajustes do iPhone → CubeChat.';

  @override
  String get customizeTranscribeLanguageTitle => 'Idioma da transcrição';

  @override
  String get customizeTranscribeLanguageAuto => 'Auto';

  @override
  String get customizeTranscribeLanguageHint =>
      'O idioma falado nos áudios, que não precisa ser o idioma do app. Auto tenta os idiomas do celular. Um idioma que falta é baixado pelo próprio celular; a voz nunca sai dele.';

  @override
  String get chatTranslateAction => 'Traduzir';

  @override
  String get chatTranslateFailed =>
      'Esta não pode ser traduzida neste celular.';

  @override
  String get customizeDeferMediaTitle => 'Esperar o Wi-Fi para baixar mídia';

  @override
  String get customizeDeferMediaHint =>
      'Nos dados móveis, textos e chamadas funcionam normalmente, enquanto fotos, áudios, mensagens de vídeo e arquivos esperam o Wi-Fi no servidor — por até duas semanas. Uma linha acima das conversas mostra o que está esperando e baixa na hora.';

  @override
  String heldMediaCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count mídias esperando o Wi-Fi',
      one: '1 mídia esperando o Wi-Fi',
    );
    return '$_temp0';
  }

  @override
  String get heldMediaDownload => 'Baixar';

  @override
  String get nearbyAirDropSubtitle =>
      'Compartilhe arquivos com pessoas por perto';

  @override
  String get nearbyFilesSubtitle => 'Arquivos enviados e recebidos';

  @override
  String get airdropTab => 'AirDrop';

  @override
  String get nearbyTabFiles => 'Arquivos';

  @override
  String get airdropReceiveHint => 'Quem pode te enviar arquivos';

  @override
  String get airdropReceiveContacts => 'Contatos';

  @override
  String get airdropReceiveEveryone => 'Todos por 10 min';

  @override
  String airdropEveryoneLeft(String time) {
    return 'Todos · $time';
  }

  @override
  String get airdropSendFiles => 'Enviar arquivos';

  @override
  String get airdropChooseFiles => 'Escolher arquivos';

  @override
  String airdropStagedTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count arquivos prontos',
      one: '1 arquivo pronto',
    );
    return '$_temp0';
  }

  @override
  String get airdropStagedHint =>
      'Com o Bluetooth ligado e o AirDrop aberto nos dois celulares, aproxime-os ou escolha uma pessoa';

  @override
  String get airdropStagedPickPerson => 'Escolher pessoa';

  @override
  String airdropRequestBody(String what, String size) {
    return 'quer enviar $what · $size';
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
      other: '$count vídeos',
      one: '1 vídeo',
    );
    return '$_temp0';
  }

  @override
  String airdropWhatFiles(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count arquivos',
      one: '1 arquivo',
    );
    return '$_temp0';
  }

  @override
  String get airdropAccept => 'Aceitar';

  @override
  String get airdropDecline => 'Recusar';

  @override
  String get airdropWaiting => 'Aguardando resposta…';

  @override
  String get airdropAccepted => 'Aceito';

  @override
  String get airdropUnheard =>
      'Não recebido — talvez uma versão antiga do CubeChat';

  @override
  String get airdropSending => 'Enviando';

  @override
  String get airdropReceiving => 'Recebendo';

  @override
  String get airdropInterrupted => 'Interrompido';

  @override
  String get airdropRetry => 'Tentar de novo';

  @override
  String get airdropOutcomeSent => 'Enviado';

  @override
  String get airdropOutcomeReceived => 'Recebido';

  @override
  String get airdropOutcomeDeclined => 'Recusado';

  @override
  String get airdropOutcomeCancelled => 'Cancelado';

  @override
  String get airdropOutcomePartial => 'Parcial';

  @override
  String get airdropReasonNoSpace => 'sem espaço suficiente';

  @override
  String get airdropReasonContactsOnly => 'só contatos';

  @override
  String get airdropReasonBusy => 'ocupado';

  @override
  String get airdropReasonTimeout => 'sem resposta';

  @override
  String get airdropFileDeleted => 'apagado';

  @override
  String get airdropHistory => 'Histórico';

  @override
  String get airdropClearHistory => 'Limpar histórico';

  @override
  String get airdropEmpty =>
      'Os arquivos que você enviar ou receber por perto aparecerão aqui';

  @override
  String get airdropPickPerson => 'Enviar para';

  @override
  String get airdropNobody => 'Ninguém com cubechat por perto ainda';

  @override
  String get airdropNoDirect => 'Sem conexão Bluetooth com esta pessoa';

  @override
  String get airdropNearbyUnknown => 'Por perto';

  @override
  String get airdropConnecting => 'Conectando…';

  @override
  String get airdropConnectFailed => 'Não foi possível conectar';

  @override
  String get airdropSlowWarning => 'Isso pode demorar bastante por Bluetooth';

  @override
  String airdropTooLarge(String name, int limit) {
    return '$name tem mais de $limit MB';
  }

  @override
  String airdropFromLabel(String name) {
    return 'AirDrop · $name';
  }

  @override
  String get airdropWrite => 'Mensagem';

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
      'Ligue o Bluetooth nos dois celulares para se encontrarem e confirmarem a transferência.';

  @override
  String get airdropLaneHint =>
      'O Bluetooth encontra e conecta os celulares. O Wi‑Fi transfere os arquivos quando os dois estão na mesma rede ou hotspot.';

  @override
  String get airdropWifiUnreachable => 'Não estão na mesma rede';

  @override
  String get airdropWifiOldVersion =>
      'O app da outra pessoa ainda não recebe por Wi‑Fi';

  @override
  String get airdropBumpAdd => 'Adicionar';

  @override
  String get airdropBumpAlreadyContact => 'Já está nos seus contatos';

  @override
  String airdropBumpSending(String name) {
    return 'Enviando para $name';
  }

  @override
  String airdropBumpReceiving(String name) {
    return '$name está te enviando arquivos';
  }

  @override
  String get termsTitle => 'Regras do cubechat';

  @override
  String get termsBody =>
      'O cubechat tem tolerância zero com conteúdo ofensivo e usuários abusivos. Ao continuar, você concorda em não enviar assédio, ameaças, conteúdo sexual envolvendo menores, spam ou qualquer coisa ilegal. Qualquer pessoa pode denunciar uma mensagem ou uma pessoa; as denúncias chegam ao desenvolvedor e são tratadas em até 24 horas, e os infratores são banidos.';

  @override
  String get termsReadFull => 'Ler os termos completos';

  @override
  String get termsAccept => 'Concordo';

  @override
  String get messageHide => 'Ocultar';

  @override
  String get messageHidden => 'Oculta para você';

  @override
  String get reportAction => 'Denunciar';

  @override
  String get reportTitle => 'Qual é o problema?';

  @override
  String get reportReasonSpam => 'Spam';

  @override
  String get reportReasonAbuse => 'Abuso ou assédio';

  @override
  String get reportReasonViolence => 'Violência';

  @override
  String get reportReasonSexual => 'Conteúdo sexual';

  @override
  String get reportReasonOther => 'Outro';

  @override
  String get reportNoteHint => 'Descreva (opcional)';

  @override
  String get reportSend => 'Enviar denúncia';

  @override
  String get reportDisclosure =>
      'O texto da mensagem selecionada e sua denúncia vão para a moderação do cubechat e para o bot privado dela no Telegram.';

  @override
  String get reportSent =>
      'Denúncia enviada. Analisamos as denúncias em até 24 horas.';

  @override
  String get reportBlockedToo => 'A pessoa foi bloqueada para você.';

  @override
  String get reportQueued =>
      'Denúncia salva. Ela será enviada quando houver conexão.';

  @override
  String get reportFailed => 'Não foi possível enviar a denúncia.';

  @override
  String get filteredMessage => 'Oculta pelo filtro';

  @override
  String get filteredShow => 'Mostrar';

  @override
  String get filterToggle => 'Filtro de conteúdo ofensivo';

  @override
  String get filterToggleHint =>
      'Oculta palavrões de desconhecidos e nos canais';

  @override
  String get aboutTitle => 'Sobre';

  @override
  String get aboutContact => 'Enviar e-mail ao desenvolvedor';

  @override
  String get aboutReport => 'Denunciar uma violação';

  @override
  String get aboutTerms => 'Termos de uso';

  @override
  String get aboutPrivacy => 'Política de privacidade';

  @override
  String get requestsTitle => 'Pedidos';

  @override
  String get requestsEmpty => 'Nenhum pedido';

  @override
  String requestBanner(String name) {
    return '$name não está nos seus contatos. Até você aceitar, a pessoa não vê que você leu isto nem pode te ligar.';
  }

  @override
  String get requestAccept => 'Aceitar';

  @override
  String get requestDelete => 'Apagar';

  @override
  String get requestBlock => 'Bloquear';

  @override
  String get cubeIdTitle => 'Cube ID';

  @override
  String get cubeIdExplainer =>
      'Seu @nome aponta para o seu cartão de contato. O servidor guarda só o nome e o seu cartão público — nunca as suas mensagens.';

  @override
  String get cubeIdFieldHint => 'a–z, 0–9 e _, de 3 a 20 caracteres';

  @override
  String get cubeIdAvailable => 'Disponível';

  @override
  String get cubeIdTaken => 'Em uso';

  @override
  String get cubeIdReserved => 'Não permitido';

  @override
  String get cubeIdInvalid => 'Só a–z, 0–9 e _, de 3 a 20 caracteres';

  @override
  String get cubeIdClaim => 'Usar este nome';

  @override
  String get cubeIdWorking => 'Garantindo o nome…';

  @override
  String get cubeIdChange => 'Alterar';

  @override
  String get cubeIdEmail => 'E-mail de recuperação';

  @override
  String get cubeIdEmailHint =>
      'Se este celular for perdido, o nome volta por um e-mail enviado a este endereço';

  @override
  String get cubeIdEmailField => 'E-mail';

  @override
  String cubeIdEmailSent(String email) {
    return 'Enviamos um e-mail para $email. Abra o link que está nele.';
  }

  @override
  String get cubeIdEmailRemove => 'Remover e-mail';

  @override
  String get cubeIdEmailUnavailable =>
      'O e-mail está indisponível no momento. Tente mais tarde.';

  @override
  String get cubeIdEmailInvalid => 'Isso não parece um endereço de e-mail';

  @override
  String get cubeIdSave => 'Salvar';

  @override
  String get cubeIdRecover => 'Recuperar um nome por e-mail';

  @override
  String get cubeIdRecoverSent =>
      'Se o endereço corresponder, chegará um e-mail. O nome passa para este celular 48 horas depois de você abrir o link.';

  @override
  String cubeIdRecoveryWarning(String name, String when) {
    return 'Alguém está recuperando @$name em outro celular por e-mail. Ele será transferido em $when, a menos que você cancele.';
  }

  @override
  String get cubeIdRecoveryCancel => 'Cancelar a recuperação';

  @override
  String get cubeIdRecoveryCancelled => 'Recuperação cancelada';

  @override
  String get cubeIdRelease => 'Liberar';

  @override
  String cubeIdReleaseConfirm(String name) {
    return 'Liberar @$name? Qualquer pessoa poderá usá-lo.';
  }

  @override
  String get cubeIdShare => 'Compartilhar';

  @override
  String cubeIdShareText(String name) {
    return 'Me encontre no cubechat: @$name\nhttps://cubechat.tech/u.html#$name';
  }

  @override
  String get cubeIdFailed => 'Não foi possível salvar o nome. Tente de novo.';

  @override
  String get cubeIdOffline => 'Sem internet';

  @override
  String get lookupNotFound => 'Ninguém com esse @nome';

  @override
  String searchFindCubeName(String name) {
    return 'Encontrar @$name';
  }

  @override
  String get searchFindCubeNameHint => 'Buscar no Cube ID e adicionar';

  @override
  String get addContactHintName => 'Cole um cartão ou digite um @nome';

  @override
  String get strangerReachTitle =>
      'Quem pode me enviar mensagens pela internet';

  @override
  String get strangerReachAll => 'Todos';

  @override
  String get strangerReachRequest => 'Pedido';

  @override
  String get strangerReachNone => 'Ninguém';

  @override
  String get strangerReachHint =>
      'Para pessoas com quem você não conversou e que te procuram pela internet. Pessoas por perto via Bluetooth não são afetadas.';

  @override
  String get sectionPrivacy => 'Privacidade e segurança';

  @override
  String get sectionNotifications => 'Notificações e chamadas';

  @override
  String get sectionConnection => 'Conexão';

  @override
  String get sectionChats => 'Conversas e mídia';

  @override
  String get sectionAppearance => 'Aparência';

  @override
  String get sectionData => 'Dados e armazenamento';

  @override
  String get sectionAbout => 'Sobre';

  @override
  String get subWhoSeesMe => 'Quem me vê';

  @override
  String get subProtection => 'Proteção';

  @override
  String get subNotifications => 'Notificações';

  @override
  String get subCalls => 'Chamadas';

  @override
  String get profileDiscoverableMeshOff =>
      'A Bluetooth mesh está desligada — ligue-a em Conexão.';

  @override
  String get chatRouteBluetoothDirect => 'Bluetooth, direto';

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
    return 'Entregue: $route';
  }

  @override
  String chatRouteReceivedVia(String route) {
    return 'Recebida: $route';
  }

  @override
  String get chatUnreadDivider => 'Novas mensagens';

  @override
  String get radioTitle => 'Walkie-talkie';

  @override
  String get radioNearbySubtitle =>
      'Segure um botão e fale com um grupo ou um contato';

  @override
  String get radioGroupsLabel => 'Grupos';

  @override
  String get radioDirectLabel => 'Pessoal';

  @override
  String get radioAddGroup => 'Adicionar rádio';

  @override
  String get radioNoGroups =>
      'Nenhum rádio ainda. Adicione um — todos que digitarem o mesmo nome e a mesma senha se ouvem.';

  @override
  String get radioLeave => 'Sair deste rádio';

  @override
  String get radioPickChannel => 'Escolha um grupo ou um contato';

  @override
  String get radioPushToTalk => 'Segure para falar';

  @override
  String get radioTalking => 'Falando…';

  @override
  String get radioChannelBusy => 'Canal ocupado';

  @override
  String radioSpeaker(String name) {
    return '$name está falando';
  }

  @override
  String get radioSilentTitle => 'Falar no modo silencioso';

  @override
  String get radioSilentHint => 'A voz toca mesmo com o celular no silencioso.';

  @override
  String get radioJoinNameLabel => 'Nome';

  @override
  String get radioJoinPasswordLabel => 'Senha (opcional)';

  @override
  String get radioJoinHint =>
      'Todos que digitarem o mesmo nome e a mesma senha ficam no mesmo rádio. Nenhum servidor guarda uma lista deles.';

  @override
  String get radioJoinNameRequired => 'Digite um nome';

  @override
  String get radioJoinSubmit => 'Adicionar';

  @override
  String get radioBlockedTooLong => 'Cortado após um minuto de fala';

  @override
  String get radioBlockedCall => 'Há uma chamada em andamento';

  @override
  String get radioBlockedMicrophone => 'Sem acesso ao microfone';

  @override
  String get radioBlockedUnavailable =>
      'O rádio não está disponível neste dispositivo';

  @override
  String get radioBlockedNoChannel => 'Escolha um grupo ou um contato primeiro';

  @override
  String get radioTurnOff => 'Desligar o rádio';

  @override
  String get radioPersonalCallsTitle => 'Receber chamadas pessoais';

  @override
  String get radioPersonalCallsHint =>
      'Com o rádio desligado, um contato que falar com você sintoniza o rádio nele.';

  @override
  String get radioBackgroundHint =>
      'Com a tela desligada, o rádio só é ouvido se o modo em segundo plano estiver ativado.';

  @override
  String get areaNearby => 'Conversa local';

  @override
  String get areaLevelDistrict => 'Bairro';

  @override
  String get areaLevelCity => 'Cidade';

  @override
  String get areaLevelRegion => 'Região';

  @override
  String areaPresentCount(int count) {
    return '≈$count aqui';
  }

  @override
  String get areaPresentMany => '50+ aqui';

  @override
  String get areaBlockViaBluetooth => 'Seu quarteirão — por Bluetooth';

  @override
  String get areaOpenNearbyTab => 'Abrir Por perto';

  @override
  String get areaLocating => 'Encontrando seu bairro…';

  @override
  String get areaNoPlace =>
      'Ainda sem localização. A conversa local precisa da sua localização aproximada enquanto esta tela estiver aberta.';

  @override
  String get areaLocationDenied =>
      'A localização está desativada para o Cubechat. Permita a localização aproximada nas configurações para ver seu bairro.';

  @override
  String get areaOffline => 'Sem conexão com a conversa local';

  @override
  String get areaEmpty => 'Ninguém escreveu aqui nas últimas 24 horas.';

  @override
  String get areaConsentTitle => 'A conversa local é pública';

  @override
  String get areaConsentBody =>
      'As mensagens aqui são públicas. Qualquer pessoa que abrir seu bairro ou sua cidade vai lê-las, e elas ficam guardadas por 24 horas no servidor do Cubechat. Você escreve com um nome temporário que muda a cada poucas horas; ninguém vê seu @nome nem seus contatos. Para saber seu bairro, o Cubechat pede sua localização aproximada, só enquanto esta tela estiver aberta.';

  @override
  String get areaConsentAllow => 'Continuar';

  @override
  String get areaConsentDecline => 'Agora não';

  @override
  String areaDefaultName(String tag) {
    return 'Cubo-$tag';
  }

  @override
  String areaYouAre(String name, int hours) {
    return 'Você é $name · novo nome em $hours h';
  }

  @override
  String get areaNewName => 'Novo nome';

  @override
  String get areaSetName => 'Escolher um nome';

  @override
  String get areaNameHint =>
      'Só pelas poucas horas deste nome. Deixe vazio para usar o automático.';

  @override
  String get areaNameSameWarning =>
      'O mesmo nome liga você entre bairros diferentes';

  @override
  String get areaShowPresence => 'Mostrar que estou aqui';

  @override
  String get areaPresenceOffHint =>
      'Ative \"Mostrar que estou aqui\" para ver quantas pessoas estão por perto';

  @override
  String get areaReadOnly => 'Você só pode escrever onde está';

  @override
  String get areaComposerHint => 'Mensagem para todos aqui';

  @override
  String get areaSend => 'Enviar';

  @override
  String get areaWaitALittle => 'Aguarde um pouco';

  @override
  String areaFlood(int count) {
    return 'Flood ($count) · Mostrar';
  }

  @override
  String get areaReply => 'Responder';

  @override
  String get areaHide => 'Ocultar';

  @override
  String get areaBlock => 'Bloquear até o nome mudar';

  @override
  String get areaBlocked => 'Bloqueado até o nome mudar';

  @override
  String get areaReport => 'Denunciar';

  @override
  String get areaOpenLink => 'Abrir link';

  @override
  String areaOpenLinkConfirm(String url) {
    return 'Abrir $url?';
  }

  @override
  String get areaOpen => 'Abrir';

  @override
  String get areaReadHere => 'Ler aqui';

  @override
  String get areaReadHereHint =>
      'Só leitura. Você só pode escrever onde está; o relay fica sabendo qual lugar você lê.';

  @override
  String get areaNotes => 'Recados';

  @override
  String areaNotesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count recados',
      one: '$count recado',
      zero: 'Nenhum recado',
    );
    return '$_temp0';
  }

  @override
  String get areaLeaveNote => 'Deixar um recado';

  @override
  String get areaNoteHint => 'Um recado curto para a sua cidade';

  @override
  String get areaNoteLifetime => 'Dura';

  @override
  String get areaNote1h => '1 h';

  @override
  String get areaNote24h => '24 h';

  @override
  String get areaNote7d => '7 dias';

  @override
  String get areaPinToDistrict => 'Fixar num bairro';

  @override
  String get areaPinHint =>
      'Toque no mapa dentro da sua cidade; o marcador se encaixa no bairro.';

  @override
  String get areaPinOutside => 'Só dentro da sua cidade';

  @override
  String get areaNoteDelete => 'Apagar meu recado';

  @override
  String get areaNoNotes => 'Nenhum recado aqui ainda';

  @override
  String get areaNotesLimit => 'Três recados por dia';

  @override
  String get areaNoteLeft => 'Recado deixado';

  @override
  String get areaNoteSend => 'Deixar';

  @override
  String get areaOwnNote => 'Seu recado';

  @override
  String get areaNotePinned => 'Fixado num bairro';

  @override
  String get areaHidden => 'Oculto';

  @override
  String get areaPublicBadge => 'Pública · guardada 24 h';

  @override
  String get areaSettingTitle => 'Conversa local';

  @override
  String get areaSettingOnHint =>
      'O botão Conversa local no mapa: conversas públicas do seu bairro e da sua cidade, com um nome temporário.';

  @override
  String get areaSettingOffHint =>
      'Desativado: nenhum botão no mapa, e a conversa local nunca pede sua localização nem se conecta.';

  @override
  String get wallpaperPhotoLocalOnly =>
      'Papéis de parede com foto por enquanto são só locais';

  @override
  String get wallpaperSavedNoRoute =>
      'Salvo aqui. Agora não há rota até a outra pessoa';

  @override
  String get wallpaperScopeTitle => 'Quem deve ver este papel de parede?';

  @override
  String get wallpaperScopeChannel => 'Canal inteiro';

  @override
  String get wallpaperScopeBoth => 'Eu e a outra pessoa';

  @override
  String get wallpaperScopeLocal => 'Só no meu celular';

  @override
  String get wallpaperScopeSharedHint =>
      'Enviado como pacote de controle criptografado';

  @override
  String get wallpaperScopePhotoHint =>
      'Por enquanto as fotos ficam só neste celular';

  @override
  String get foldersCreate => 'Criar pasta';

  @override
  String get foldersYours => 'Suas pastas';

  @override
  String get foldersSmartFilters => 'Filtros inteligentes';

  @override
  String get foldersName => 'Nome da pasta';

  @override
  String get foldersSave => 'Salvar';

  @override
  String get foldersDeleteTitle => 'Excluir pasta?';

  @override
  String get foldersDelete => 'Excluir';

  @override
  String get foldersCreateAction => 'Criar';

  @override
  String get chatsArchiveHiddenToast =>
      'Arquivo oculto. Traga de volta em “Aparência”.';

  @override
  String get chatsBulkPin => 'Fixar';

  @override
  String get chatsBulkMute => 'Silenciar';

  @override
  String get chatsUnarchive => 'Desarquivar';

  @override
  String get chatsAddToFolder => 'Adicionar à pasta';

  @override
  String get chatsMarkUnread => 'Marcar como não lida';

  @override
  String get chatsClearHistory => 'Limpar histórico';

  @override
  String get foldersNew => 'Nova pasta';

  @override
  String get foldersNameHint => 'Amigos';

  @override
  String get chatsNoIncoming => 'Nenhuma mensagem recebida';

  @override
  String get chatsMarkedUnread => 'Marcada como não lida';

  @override
  String get chatsClearHistoryTitle => 'Limpar o histórico da conversa?';

  @override
  String get chatsClearHistoryBody =>
      'As mensagens serão removidas só neste aparelho. A conversa, o contato e os favoritos continuam.';

  @override
  String get chatsClearHistoryAction => 'Limpar';

  @override
  String get chatsHistoryCleared => 'Histórico limpo';

  @override
  String get savedTagMenuTag => 'Tag';

  @override
  String get savedTagRemove => 'Remover tag';

  @override
  String get customizeArchiveRowTitle => 'Linha do arquivo';

  @override
  String get customizeArchiveRowHint =>
      'Mostrar acima da lista de conversas. Conversas arquivadas continuam recebendo mensagens de qualquer forma.';

  @override
  String get mapLayerStandard => 'Padrão';

  @override
  String get mapLayerStandardHint =>
      'Mapa de ruas claro — a opção mais estável';

  @override
  String get callYourMicOff => 'Seu microfone está desligado';

  @override
  String callTheirCameraOff(String name) {
    return 'A câmera de $name está desligada';
  }
}
