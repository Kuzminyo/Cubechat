// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get callVoice => '음성 통화';

  @override
  String get callVideo => '영상 통화';

  @override
  String get callIncomingVideo => '영상 통화 수신 중';

  @override
  String get callCamera => '카메라';

  @override
  String get callFlipCamera => '전환';

  @override
  String get contactProfileVideo => '영상';

  @override
  String get callPreparing => '마이크 준비 중…';

  @override
  String get callDialing => '발신 중…';

  @override
  String get callRinging => '연결음…';

  @override
  String get callConnecting => '연결 중…';

  @override
  String get callMicrophoneRequired => '통화하려면 시스템 설정에서 마이크 접근을 허용하세요.';

  @override
  String get callMicrophoneWindows =>
      'Windows가 CubeChat에 마이크 사용을 허용하지 않았습니다. 설정 → 개인 정보 및 보안 → 마이크 → ‘데스크톱 앱이 마이크에 액세스하도록 허용’을 켜세요.';

  @override
  String get callElsewhere => '이 계정의 다른 기기에서 이미 통화 중입니다.';

  @override
  String get callRelayUnavailable => '통화 서버를 사용할 수 없습니다. 잠시 후 다시 시도하세요.';

  @override
  String get callBusy => '통화 중';

  @override
  String get callNoAnswer => '응답 없음';

  @override
  String get callFailed => '통화를 연결할 수 없습니다';

  @override
  String get callDeclined => '통화 거절됨';

  @override
  String get callEnded => '통화 종료됨';

  @override
  String get callMicrophone => '마이크';

  @override
  String get callSpeaker => '스피커';

  @override
  String get callAnswer => '받기';

  @override
  String get callDecline => '거절';

  @override
  String get callEnd => '종료';

  @override
  String get callClose => '닫기';

  @override
  String get callMinimize => '최소화';

  @override
  String get callAudioOutput => '통화 오디오';

  @override
  String get callRoutePhone => '휴대폰';

  @override
  String get callRouteBluetooth => 'Bluetooth';

  @override
  String get callRouteHeadphones => '헤드폰';

  @override
  String get callFullScreenTitle => '잠금 화면 통화';

  @override
  String get callFullScreenBody =>
      '수신 전화를 잠금 화면에 표시하도록 허용하면 잠금을 해제하지 않고도 받을 수 있습니다.';

  @override
  String get callFullScreenXiaomi =>
      'Xiaomi, Redmi, Poco는 앱이 이 설정을 직접 켤 수 없습니다. ‘기타 권한’에서 ‘잠금 화면에 표시’를 켜세요.';

  @override
  String get circleMessage => '영상 메시지';

  @override
  String get appName => 'Cubechat';

  @override
  String get navChats => '채팅';

  @override
  String get navPeers => '주변';

  @override
  String get navProfile => '프로필';

  @override
  String get navContacts => '연락처';

  @override
  String get navMap => '지도';

  @override
  String get mapTitle => '지도';

  @override
  String get mapFriendsTitle => '지도 위의 사람들';

  @override
  String get mapFriendsHint => '이 연락처들만 내 위치를 받습니다';

  @override
  String mapClusterTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '이곳에 $count명',
    );
    return '$_temp0';
  }

  @override
  String get mapClusterHint => '사람을 탭하면 지도가 그 위치로 이동합니다';

  @override
  String get mapNorthUp => '북쪽을 위로';

  @override
  String get mapLayerTitle => '지도 스타일';

  @override
  String get mapLayerHint => '핀 아래에 표시할 지도';

  @override
  String get mapLayerDark => '다크';

  @override
  String get mapLayerDarkHint => '라벨 없는 거리 — 핀 아래 가장 차분한 배경';

  @override
  String get mapLayerSatellite => '위성';

  @override
  String get mapLayerSatelliteHint => '항공 사진: 어느 건물, 어느 마당인지';

  @override
  String get mapLayerTerrain => '지형';

  @override
  String get mapLayerTerrainHint => '등고선과 지형 — 언덕과 산책로용';

  @override
  String get mapFriendsEmpty => '아직 나와 지도를 공유하는 사람이 없습니다.';

  @override
  String get mapFriendsEmptyHint => '연락처를 초대하세요. 수락하면 여기에 표시됩니다.';

  @override
  String get mapFriendsInvite => '초대';

  @override
  String get mapFriendsRemove => '지도에서 제거';

  @override
  String mapFriendsRemoved(String name) {
    return '$name님이 더 이상 지도를 공유하지 않습니다';
  }

  @override
  String get mapFriendsLive => '지금 지도에 표시 중';

  @override
  String get mapFriendsIdle => '현재 위치 없음';

  @override
  String get mapInviteTitle => '지도에 초대';

  @override
  String get mapInviteHint => '채팅을 하나 이상 선택하세요';

  @override
  String get mapInviteEmpty => '초대할 채팅이 아직 없습니다.';

  @override
  String mapInviteAction(int count) {
    return '보내기 ($count)';
  }

  @override
  String get mapInviteMessage =>
      'Cubechat 지도 초대입니다. 이 채팅에서 위치를 공유하면 지도에 표시됩니다.';

  @override
  String mapInviteSent(int count) {
    return '초대 $count건을 보냈습니다';
  }

  @override
  String get mapInviteFailed => '초대를 보낼 수 없습니다';

  @override
  String mapPeopleVisible(int count) {
    return '공유된 위치 $count개';
  }

  @override
  String get mapCenterMe => '내 위치로';

  @override
  String get mapNoSharedLocations => '아직 공유된 위치가 없습니다';

  @override
  String get mapNoSharedLocationsHint => '연락처가 채팅에서 위치를 보내면 여기에 표시됩니다.';

  @override
  String get mapWebHintTitle => '주변 연결';

  @override
  String get mapWebHint => '선은 메시지 경로가 아니라 가까운 정도를 나타냅니다.';

  @override
  String get mapOpenProfile => '프로필';

  @override
  String get mapLocationPrivacyOff => '지도 위치가 숨겨져 있습니다';

  @override
  String get mapLocationPrivacyOffHint =>
      '내 핀을 표시하려면 ‘개인정보 및 보안’에서 ‘지도에 내 위치 표시’를 켜세요.';

  @override
  String get mapYouOnMap => '이 기기에서 내 위치가 보입니다';

  @override
  String get locationSharingDisabled => '먼저 ‘개인정보 및 보안’에서 ‘지도에 내 위치 표시’를 켜세요.';

  @override
  String get mapLocationDenied => '위치 접근이 꺼져 있습니다';

  @override
  String get mapLocationServiceOff => '내 위치를 표시하려면 위치 서비스를 켜세요';

  @override
  String get mapLocationUnavailable => '현재 위치를 확인할 수 없습니다';

  @override
  String get mapDistanceUnknown => '거리 알 수 없음';

  @override
  String mapDistanceMetres(int metres) {
    return '${metres}m 거리';
  }

  @override
  String mapDistanceKilometres(String kilometres) {
    return '${kilometres}km 거리';
  }

  @override
  String get mapUpdatedNow => '방금 공유됨';

  @override
  String mapUpdatedMinutes(int minutes) {
    return '$minutes분 전 공유됨';
  }

  @override
  String mapUpdatedHours(int hours) {
    return '$hours시간 전 공유됨';
  }

  @override
  String get contactsTitle => '연락처';

  @override
  String get contactsSubtitle => '메시지를 주고받은 모든 사람';

  @override
  String get contactsSearchHint => '연락처 검색…';

  @override
  String get contactsEmptyTitle => '아직 연락처가 없습니다';

  @override
  String get contactsEmptyHint => '대화를 시작하면 상대방이 여기에 표시됩니다.';

  @override
  String get contactsSearchEmpty => '일치하는 연락처가 없습니다';

  @override
  String get contactsTabContacts => '연락처';

  @override
  String get contactsTabCalls => '통화';

  @override
  String get callsFilterAll => '전체';

  @override
  String get callsFilterMissed => '부재중';

  @override
  String get callsEmptyTitle => '아직 통화 기록이 없습니다';

  @override
  String get callsEmptyHint => '수신, 발신, 부재중 통화가 여기에 표시됩니다.';

  @override
  String get callsMissedEmpty => '부재중 통화 없음';

  @override
  String get callsCallBack => '전화하기';

  @override
  String get contactProfileChat => '채팅';

  @override
  String get contactProfileCall => '통화';

  @override
  String get contactProfileRadio => '무전';

  @override
  String get contactProfileSecurity => '보안';

  @override
  String get contactProfileActions => '연락처 작업';

  @override
  String get contactProfileVerify => '인증';

  @override
  String get contactProfileCopyId => '연락처 ID 복사';

  @override
  String get contactProfileIdCopied => '연락처 ID를 복사했습니다';

  @override
  String get contactProfileId => '연락처 ID';

  @override
  String get contactProfileVerifyHint => '암호화 지문을 비교해 이 사람을 확인하세요.';

  @override
  String get chatsTitle => '채팅';

  @override
  String get chatsSubtitle => '메시 · 종단간 암호화';

  @override
  String get chatsEmptyTitle => '아직 대화가 없습니다';

  @override
  String get chatsEmptyHint => '‘주변’ 탭에서 상대를 열어 채팅을 시작하세요.';

  @override
  String get chatsFilterAll => '전체';

  @override
  String get chatsFilterUnread => '읽지 않음';

  @override
  String get chatsFilterMesh => '메시';

  @override
  String get chatsFilterFavorites => '즐겨찾기';

  @override
  String get chatsFolderDirect => '개인';

  @override
  String get chatsFolderChannels => '채널';

  @override
  String get chatsFolderOnline => '연결 가능';

  @override
  String get chatsFoldersTitle => '폴더';

  @override
  String get chatsFoldersHint =>
      '폴더는 채팅을 옮겨 두는 곳이 아니라 이 목록을 걸러 보는 방식입니다. 채팅 위에 표시할 폴더를 켜세요.';

  @override
  String get chatsSearchHint => '채팅 검색…';

  @override
  String get chatsStatusViaMesh => '메시 경유';

  @override
  String get chatsStatusOffline => '오프라인';

  @override
  String get peerKeyRotated => '키 변경됨 — 다시 인증하세요';

  @override
  String get peersTitle => '주변';

  @override
  String get peersSubtitle => 'Bluetooth 범위 내 기기';

  @override
  String get peersEmpty => '주변 기기 찾는 중…';

  @override
  String peersHopsOne(int n) {
    return '$n홉 거리';
  }

  @override
  String peersHopsOther(int n) {
    return '$n홉 거리';
  }

  @override
  String get blePermissionTitle => 'Bluetooth 권한 필요';

  @override
  String get blePermissionHint =>
      'Cubechat은 Bluetooth로 주변 기기를 찾고 메시지를 보냅니다. 인터넷이 필요 없습니다.';

  @override
  String get blePermissionGrant => '권한 허용';

  @override
  String get blePermissionOpenSettings => '설정 열기';

  @override
  String get blePermissionDeniedHint =>
      '권한이 거부되었습니다. 설정에서 Bluetooth 접근을 허용하세요.';

  @override
  String get bleAdapterOffTitle => 'Bluetooth가 꺼져 있습니다';

  @override
  String get bleAdapterOffHint => '주변 기기를 보려면 Bluetooth를 켜세요.';

  @override
  String get bleUnsupportedTitle => 'Bluetooth LE를 사용할 수 없음';

  @override
  String get bleUnsupportedHint =>
      '이 기기 또는 플랫폼은 Bluetooth Low Energy를 지원하지 않습니다. 휴대폰에서 사용해 보세요.';

  @override
  String get bleScanning => '검색 중…';

  @override
  String get bleRetry => '다시 시도';

  @override
  String get bleEnable => '켜기';

  @override
  String get bleConnectFailed =>
      '연결할 수 없습니다. 상대 기기가 범위를 벗어났거나 Bluetooth 주소가 바뀌었을 수 있습니다.';

  @override
  String get bleSignal => '신호';

  @override
  String get bleConnect => '연결';

  @override
  String get bleConnected => '연결됨';

  @override
  String get bleVerified => '인증됨';

  @override
  String get editorAdjustBrightness => '밝기';

  @override
  String get editorAdjustContrast => '대비';

  @override
  String get editorAdjustSaturation => '채도';

  @override
  String get editorToolCrop => '자르기';

  @override
  String get editorToolDraw => '그리기';

  @override
  String get editorToolAdjust => '보정';

  @override
  String get editorTabSticker => '스티커';

  @override
  String get editorTabText => '텍스트';

  @override
  String get editorPenPen => '펜';

  @override
  String get editorPenMarker => '마커';

  @override
  String get editorPenNeon => '네온';

  @override
  String get editorPenArrow => '화살표';

  @override
  String get editorPenBlur => '흐림';

  @override
  String get editorPenEraser => '지우개';

  @override
  String get editorLevel => '수평';

  @override
  String get editorTextHint => '사진에 넣을 텍스트';

  @override
  String get editorCropFree => '자유';

  @override
  String get editorRemove => '삭제';

  @override
  String get notificationUnknownSender => '새 메시지';

  @override
  String get bleUnknownPeer => '알 수 없는 기기';

  @override
  String get bleBroadcasting => '송출 중';

  @override
  String bleConnectedCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '센트럴 $n개 연결됨',
      one: '센트럴 1개 연결됨',
      zero: '연결된 센트럴 없음',
    );
    return '$_temp0';
  }

  @override
  String get verifyTitle => '상대 인증';

  @override
  String get verifyIntro =>
      '이 두 지문을 상대와 직접 만나거나 음성 통화로 비교하세요. 양쪽에서 일치하면 Noise 핸드셰이크가 변조되지 않았음이 확인됩니다.';

  @override
  String get verifyMine => '내 지문';

  @override
  String verifyTheirs(String name) {
    return '$name님의 지문';
  }

  @override
  String get verifyMarkAsVerified => '인증됨으로 표시';

  @override
  String get verifyAlreadyDone => '인증된 상대입니다.';

  @override
  String get verifyRevoke => '취소';

  @override
  String verifyDoneSnack(String name) {
    return '$name님을 인증됨으로 표시했습니다';
  }

  @override
  String get chatInputHint => '메시지';

  @override
  String get chatSend => '보내기';

  @override
  String get chatToday => '오늘';

  @override
  String get chatYesterday => '어제';

  @override
  String get chatDelivered => '전달됨';

  @override
  String get chatRead => '읽음';

  @override
  String get chatSending => '보내는 중';

  @override
  String get chatWaitingForConnection => '연결 대기 중';

  @override
  String sendQueueCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '메시지 $count개가 연결을 기다리는 중',
      one: '메시지 1개가 연결을 기다리는 중',
    );
    return '$_temp0';
  }

  @override
  String sendQueueSlowNetwork(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '느린 네트워크 — 메시지 $count개 보내는 중',
      one: '느린 네트워크 — 메시지 1개 보내는 중',
    );
    return '$_temp0';
  }

  @override
  String get sendQueueTitle => '전송 대기 중';

  @override
  String get sendQueueHint =>
      'Bluetooth 근처 기기나 인터넷 등 경로가 생기는 즉시 자동으로 전송됩니다. 아무것도 누를 필요가 없습니다.';

  @override
  String get sendQueueRetry => '지금 시도';

  @override
  String get sendQueueCancel => '전송 취소';

  @override
  String get sendQueueCancelled => '전송 취소됨';

  @override
  String get sendQueueTooLate => '이미 전송되어 취소할 수 없습니다';

  @override
  String get chatEncryptedNotice => '메시지는 Noise 프로토콜로 종단간 암호화됩니다.';

  @override
  String get chatSessionHandshaking => '보안 채널 설정 중…';

  @override
  String get chatSessionEstablished => '보안 연결 · Noise XX';

  @override
  String get chatSessionFailed => '연결 실패';

  @override
  String get presenceOnline => '온라인';

  @override
  String get presenceOffline => '오프라인';

  @override
  String get chatSessionFingerprintPending => '핸드셰이크가 완료되면 지문이 표시됩니다.';

  @override
  String get chatEmptyEstablished => '보안 채널이 준비되었습니다. 메시지를 보내 대화를 시작하세요.';

  @override
  String get chatEmptyHandshaking => '상대방이 핸드셰이크를 완료하기를 기다리는 중…';

  @override
  String get chatEmptyTitle => '아직 메시지가 없습니다';

  @override
  String get chatEmptyGreetHint => '메시지를 보내거나 큐비를 탭해 인사하세요.';

  @override
  String get profileTitle => '프로필';

  @override
  String get profileNickname => '닉네임';

  @override
  String get profileNicknameEditTitle => '닉네임 설정';

  @override
  String get profileNicknameHint => '메시에서 다른 사람에게 보이는 이름';

  @override
  String get profileNicknameSave => '저장';

  @override
  String get profileFingerprint => '공개 키 지문';

  @override
  String get profileLanguage => '언어';

  @override
  String get profileLanguageEn => '영어';

  @override
  String get profileLanguageUk => '우크라이나어';

  @override
  String get profileTransport => '전송 방식';

  @override
  String get profileTransportMesh => 'Bluetooth 메시';

  @override
  String get profileBackground => '백그라운드에서 연결 유지';

  @override
  String get profileBackgroundSubtitle => '앱을 닫아도 메시지 계속 받기';

  @override
  String get profileBatteryExempt => '배터리 최적화 끄기';

  @override
  String get profileAbout => '정보';

  @override
  String profileVersion(String v) {
    return '버전 $v';
  }

  @override
  String get rotateKeysTitle => '계정 키 변경';

  @override
  String get rotateKeysHint => '계정이 있는 기기를 분실했거나 도난당한 경우';

  @override
  String get rotateKeysConfirmTitle => '계정 키를 변경할까요?';

  @override
  String get rotateKeysConfirmBody =>
      '연락처는 새 키를 받고 채팅도 그대로 유지되지만, 각 연락처에게 키를 다시 확인하라는 요청이 표시됩니다. 계정의 다른 모든 기기는 로그아웃되며, 계속 쓸 기기는 이 휴대폰에서 다시 연결하세요. 이전 버전의 CubeChat을 쓰는 연락처는 업데이트하기 전까지 연락할 수 없습니다. 채널 키는 바뀌지 않습니다.';

  @override
  String get rotateKeysConfirmAction => '키 변경';

  @override
  String get rotateKeysWorking => '키 변경 중…';

  @override
  String rotateKeysDone(int sent, int total) {
    return '새 키 적용. 연락처 $total명 중 $sent명에게 알림';
  }

  @override
  String get rotateKeysSlow => '새 키 적용. 일부 연락처가 제때 확인하지 못했습니다. 릴레이가 대신 보관합니다';

  @override
  String get profileEmergencyWipe => '긴급 삭제';

  @override
  String get profileEmergencyWipeConfirm => '모두 지울까요?';

  @override
  String get profileEmergencyWipeConfirmHint =>
      '내 신원, 상대 목록, 대화 기록이 모두 삭제됩니다. 되돌릴 수 없습니다.';

  @override
  String get profileEmergencyWipeAction => '지우기';

  @override
  String get cancel => '취소';

  @override
  String get copy => '복사';

  @override
  String get copied => '복사됨';

  @override
  String get channelsNewTitle => '새 채널';

  @override
  String get channelsNewTooltip => '새 채널';

  @override
  String get channelNameLabel => '채널 이름';

  @override
  String get channelPasswordLabel => '비밀번호 (선택)';

  @override
  String get channelJoinAction => '참여';

  @override
  String get channelNameHint =>
      '같은 이름과 비밀번호를 입력한 사람은 모두 같은 방에 들어옵니다. 목록을 보관하는 서버는 없습니다.';

  @override
  String get channelPasswordHint =>
      '비밀번호가 곧 키입니다. 비밀번호가 없으면 이름을 아는 주변 누구나 들어올 수 있습니다.';

  @override
  String get channelSubtitle => '그룹 채널 · 공유 키';

  @override
  String get channelMute => '알림 끄기';

  @override
  String get channelUnmute => '알림 켜기';

  @override
  String channelMutedUntil(String time) {
    return '$time까지 알림 꺼짐';
  }

  @override
  String get channelMuteFor => '알림 끄기…';

  @override
  String channelMuteMinutes(int minutes) {
    return '$minutes분';
  }

  @override
  String channelMuteHours(int hours) {
    return '$hours시간';
  }

  @override
  String channelMuteDays(int days) {
    return '$days일';
  }

  @override
  String get channelMuteForever => '다시 켤 때까지';

  @override
  String get channelCommunity => '댓글';

  @override
  String get channelCommunityOpen => '토론 열기';

  @override
  String channelCommunitySubtitle(String channel) {
    return '$channel 토론';
  }

  @override
  String get channelBackToChannel => '채널로 돌아가기';

  @override
  String get channelMemberActions => '멤버';

  @override
  String get channelRemoveMember => '채널에서 내보내기';

  @override
  String get channelRemoveMemberHint =>
      '이 사람의 게시물은 더 이상 여기서 받지 않습니다. 하지만 이름으로 다시 들어오는 것은 막을 수 없습니다. 공유 키가 멤버십의 전부입니다.';

  @override
  String get channelMuteMember => '다음 기간 동안 차단…';

  @override
  String get channelUnmuteMember => '다시 게시 허용';

  @override
  String channelMemberRemoved(String name) {
    return '$name님을 내보냈습니다';
  }

  @override
  String channelMemberMuted(String name) {
    return '$name님의 게시를 막았습니다';
  }

  @override
  String channelMemberCleared(String name) {
    return '$name님이 다시 게시할 수 있습니다';
  }

  @override
  String get channelMemberMutedNote => '게시 제한됨';

  @override
  String get channelShareHistory => '기록 공유';

  @override
  String get channelShareHistoryHint =>
      '이 방의 최근 게시물을 다시 송출해 나중에 참여한 사람도 볼 수 있게 합니다. 이미 있던 사람에게는 새로 가는 것이 없습니다.';

  @override
  String channelHistoryShared(int count) {
    return '게시물 $count개를 공유했습니다';
  }

  @override
  String get channelHistoryNothing => '아직 공유할 내용이 없습니다';

  @override
  String get channelHistoryAuto => '새 멤버에게 기록 보내기';

  @override
  String get channelHistoryAutoHint =>
      '방에 새로운 사람이 나타나면 최근 게시물이 자동으로 전송됩니다. 지금은 텍스트만 가능합니다. 사진은 조각난 스트림으로 전송되어 모두에게 중복 전송하지 않고는 다시 보낼 수 없습니다.';

  @override
  String get channelPostComments => '댓글';

  @override
  String get channelNoComments => '아직 댓글이 없습니다';

  @override
  String get channelCommentHint => '댓글';

  @override
  String get channelMuteCustom => '얼마 동안?';

  @override
  String get channelMuteCustomHint => '시간';

  @override
  String get chatPinnedManage => '고정됨';

  @override
  String get chatPeekOpen => '채팅 열기';

  @override
  String get chatPeekPin => '고정';

  @override
  String get chatPeekUnpin => '고정 해제';

  @override
  String get chatPeekUnmute => '알림 켜기';

  @override
  String get chatPeekMarkRead => '읽음으로 표시';

  @override
  String get chatDeleteForMeHint => '이 휴대폰에서 삭제되고 고정도 해제됩니다. 상대방에게는 그대로 남습니다.';

  @override
  String get pushWakeTitle => '이 휴대폰 깨우기';

  @override
  String get pushWakeHint =>
      '작은 서버가 릴레이에서 내 주소를 지켜보다가 무언가 도착하면 이 휴대폰을 깨웁니다. 그래서 앱이 닫혀 있어도 알림을 받을 수 있습니다. 서버는 메시지나 키를 절대 보지 못하며, 내 주소로 무언가가 언제 도착했는지만 압니다. 릴레이는 이미 그 사실을 알고 있으며, 이 서버가 그것을 아는 두 번째 장소가 됩니다.';

  @override
  String get pushWakeDeniedTitle => '알림이 꺼져 있습니다';

  @override
  String get pushWakeDeniedHint =>
      '시스템은 한 번 거부되면 다시 묻지 않으므로 설정 → cubechat → 알림에서만 다시 켤 수 있습니다. 그런 다음 여기로 돌아오세요.';

  @override
  String get pushWakeRefused => '알림이 허용되지 않았습니다';

  @override
  String get privacyForwardLinkTitle => '전달 메시지에 프로필 링크';

  @override
  String get privacyForwardLinkHint =>
      '누군가 내 메시지를 전달하면 그 위의 줄을 눌러 내 프로필을 열 수 있습니다. 끄면 이름만 보이고 누를 수 있는 것은 없습니다. 상대 앱에 대한 요청일 뿐, 이 앱이 강제할 수는 없습니다.';

  @override
  String get privacyShareSheetTitle => '공유 메뉴의 채팅';

  @override
  String get privacyShareSheetOnHint =>
      '최근 채팅 4개의 이름을 Android에 제공해 어느 앱에서든 바로 보낼 수 있습니다. 앱 잠금으로도 숨겨지지 않습니다.';

  @override
  String get privacyShareSheetOffHint =>
      'Android에 아무것도 제공하지 않습니다. CubeChat으로 공유할 때 채팅을 직접 선택합니다.';

  @override
  String get privacyCallsTitle => '통화 받기';

  @override
  String get privacyCallsOnHint =>
      '연락처가 나에게 전화할 수 있습니다. 특정 사람만 막으려면 그 사람의 프로필을 여세요.';

  @override
  String get privacyCallsOffHint =>
      '프로필에서 허용한 사람 외에는 아무도 전화할 수 없습니다. 거절된 통화는 상대에게 ‘통화 중’으로 표시됩니다.';

  @override
  String get chatsStatusChannel => '채널';

  @override
  String get channelInviteTitle => '사람 추가';

  @override
  String get channelInviteAction => '초대';

  @override
  String get channelInviteEmpty => '아직 아는 상대가 없습니다. 먼저 ‘주변’ 탭에서 누군가를 만나세요.';

  @override
  String get channelInviteSent => '초대를 보냈습니다';

  @override
  String get channelInviteNoneSent => '지금은 아무에게도 연결할 수 없습니다';

  @override
  String get channelNameTooLong => '채널 이름이 너무 깁니다';

  @override
  String get chatsActionFavorite => '즐겨찾기에 추가';

  @override
  String get chatsActionUnfavorite => '즐겨찾기에서 제거';

  @override
  String get chatsActionDelete => '채팅 삭제';

  @override
  String get chatsDeleteTitle => '이 채팅을 삭제할까요?';

  @override
  String chatsDeleteManyHint(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '대화 $count개를 지웁니다. 연락처는 남아 있으므로 코드를 다시 교환하지 않고도 메시지를 보낼 수 있습니다.',
    );
    return '$_temp0';
  }

  @override
  String get chatsDeletedToast => '채팅을 삭제했습니다.';

  @override
  String chatsDeletedManyToast(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '채팅 $count개를 삭제했습니다.',
    );
    return '$_temp0';
  }

  @override
  String get undo => '실행 취소';

  @override
  String get chatsDeletePeerHint =>
      '대화를 지웁니다. 연락처는 남아 있으므로 코드를 다시 교환하지 않고도 메시지를 보낼 수 있습니다.';

  @override
  String get chatsDeleteChannelHint => '채널에서 나가고 기록을 삭제합니다. 다시 참여하려면 키가 필요합니다.';

  @override
  String get chatsDeleteForThemToo => '상대방에게서도 삭제';

  @override
  String get chatsDeleteForThemHint =>
      '상대 앱에도 상대가 쓴 메시지를 포함해 대화 전체를 지우도록 요청합니다. 채널에서는 내 메시지만 회수됩니다.';

  @override
  String get chatEditAction => '수정';

  @override
  String get chatEditTitle => '메시지 수정';

  @override
  String get chatEditSave => '저장';

  @override
  String get chatEdited => '수정됨';

  @override
  String get chatDeleteAction => '삭제';

  @override
  String get chatDeleteTitle => '메시지를 삭제할까요?';

  @override
  String get chatDeleteForMe => '나에게서 삭제';

  @override
  String get chatDeleteForEveryone => '모두에게서 삭제';

  @override
  String get chatPinTitle => '메시지를 고정할까요?';

  @override
  String get chatPinForBoth => '양쪽 모두 고정';

  @override
  String get chatPinForMe => '나에게만 고정';

  @override
  String get chatReplyAction => '답장';

  @override
  String chatReplyingTo(String name) {
    return '$name님에게 답장';
  }

  @override
  String get chatReplyYou => '나';

  @override
  String get chatCopyAction => '복사';

  @override
  String get chatCopied => '복사됨';

  @override
  String get chatForwardAction => '전달';

  @override
  String get chatForwardTitle => '전달 대상';

  @override
  String get shareIntoTitle => '보낼 곳';

  @override
  String get shareNearbyAirDrop => 'AirDrop으로 주변에';

  @override
  String get shareNearbyAirDropHint => '인터넷 없이 — 곁에 있는 사람에게';

  @override
  String get shareSent => '보냈습니다';

  @override
  String get shareFailed => '일부를 보내지 못했습니다';

  @override
  String get chatForwardEmpty => '다른 채팅이 아직 없습니다';

  @override
  String chatForwardSendCount(int count) {
    return '보내기 ($count)';
  }

  @override
  String chatForwardSentCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '채팅 $count개에 전달했습니다',
    );
    return '$_temp0';
  }

  @override
  String chatForwardSent(String name) {
    return '$name에게 전달했습니다';
  }

  @override
  String chatSentAt(String time) {
    return '$time에 보냄';
  }

  @override
  String chatReadAt(String time) {
    return '$time에 읽음';
  }

  @override
  String get chatPinAction => '고정';

  @override
  String get chatUnpinAction => '고정 해제';

  @override
  String chatPinnedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '고정된 메시지 $count개',
      one: '고정된 메시지 1개',
      zero: '고정된 메시지 없음',
    );
    return '$_temp0';
  }

  @override
  String get chatNoPins => '고정된 메시지가 없습니다';

  @override
  String get chatUnpinAll => '모든 메시지 고정 해제';

  @override
  String get chatShowAllPins => '고정된 모든 메시지';

  @override
  String get chatUnpinConfirm => '이 메시지의 고정을 해제할까요?';

  @override
  String get chatUnpinConfirmHint => '이 채팅의 모든 사람에게서 고정이 해제됩니다.';

  @override
  String get chatPinnedTitle => '고정된 메시지';

  @override
  String get chatPinnedGone => '이 메시지는 더 이상 채팅에 없습니다';

  @override
  String get peerBlock => '차단';

  @override
  String get peerUnblock => '차단 해제';

  @override
  String get peerMute => '알림 끄기';

  @override
  String get peerUnmute => '알림 켜기';

  @override
  String get peerBlockedNote => '차단됨 — 이 사람의 메시지는 버려집니다.';

  @override
  String get relaysTitle => '인터넷 대체 경로';

  @override
  String get relaysCardTitle => '인터넷으로 상대에게 연결';

  @override
  String get relaysCardSubtitle => 'Bluetooth로 전달할 수 없으면 Nostr 릴레이로 보내기';

  @override
  String get relaysExplainer =>
      '메시지는 계속 종단간 암호화됩니다. 릴레이는 Bluetooth가 나르는 것과 같은 봉인된 프레임만 전달합니다. 다만 어느 두 키가 언제 대화하는지는 알 수 있습니다. 기본값은 꺼짐입니다.';

  @override
  String get relaysMyAddress => '내 릴레이 주소';

  @override
  String get relaysCopied => '복사됨';

  @override
  String get circleLensTitle => '원형 영상에 전면 카메라 사용';

  @override
  String get circleLensFrontHint => '원형 영상 메시지를 나를 향한 카메라로 녹화합니다.';

  @override
  String get circleLensBackHint => '원형 영상 메시지를 후면 카메라로 녹화해 내가 보고 있는 것을 보여 줍니다.';

  @override
  String get channelCloseTitle => '모두에게서 이 방 닫기';

  @override
  String get channelCloseSubtitle => '모든 멤버의 휴대폰에서 방을 삭제합니다. 나만 할 수 있습니다.';

  @override
  String get channelCloseConfirm =>
      '방과 메시지, 멤버가 방이 있는 모든 휴대폰에서 사라집니다. 누구도 차단되지는 않습니다. 키는 이름에서 만들어지므로 이름을 기억하는 사람은 누구나 빈 방을 다시 열 수 있습니다.';

  @override
  String get channelCloseAction => '방 닫기';

  @override
  String get circleHint => '손을 떼면 전송 · 왼쪽으로 밀면 취소';

  @override
  String get circleHintLocked => '다 찍었으면 전송을 누르세요';

  @override
  String get circleNeedsCamera => '원형 영상에는 카메라와 마이크가 필요합니다';

  @override
  String get circleFailed => '원형 영상을 녹화할 수 없습니다';

  @override
  String get relaysListLabel => '릴레이';

  @override
  String get relaysLaneMedia => '미디어 릴레이';

  @override
  String get relaysLaneMediaNote =>
      '사진, 파일, 영상은 이 릴레이로 전송되므로 전송 중에도 대화가 느려지지 않습니다.';

  @override
  String get relaysLaneLocation => '위치 릴레이';

  @override
  String get relaysLaneLocationNote => '지도 비콘은 다른 모든 것과 분리되어 이 릴레이로 전송됩니다.';

  @override
  String get relaysAdd => '릴레이 추가';

  @override
  String get relaysAddHint => 'wss://relay.example.com';

  @override
  String get relaysInvalidUrl => 'wss:// 또는 ws:// 주소를 입력하세요';

  @override
  String get relaysRemove => '제거';

  @override
  String get relaysStateConnected => '연결됨';

  @override
  String get relaysStateConnecting => '연결 중…';

  @override
  String get relaysStateFailed => '연결 불가';

  @override
  String get relaysStateIdle => '꺼짐';

  @override
  String get relaysEmpty => '설정된 릴레이가 없어 대체 경로가 꺼져 있습니다.';

  @override
  String get contactTitle => '연락처 카드';

  @override
  String get contactMineLabel => '내 카드';

  @override
  String get contactMineExplainer =>
      'Bluetooth 범위 밖에 있는 사람에게 보내세요. 카드에는 내 키와 릴레이 주소가 들어 있어, 상대가 인터넷으로 나와 암호화 채팅을 시작할 수 있습니다.';

  @override
  String get contactCopy => '복사';

  @override
  String get contactShare => '공유';

  @override
  String get contactCopied => '카드를 복사했습니다';

  @override
  String get contactShareSubject => '내 cubechat 연락처 카드';

  @override
  String get contactAddLabel => '사람 추가';

  @override
  String get contactAddHint => '연락처 카드 붙여넣기';

  @override
  String get contactAddAction => '추가';

  @override
  String get contactPaste => '붙여넣기';

  @override
  String contactAdded(String name) {
    return '$name님을 추가했습니다';
  }

  @override
  String get contactInvalid => '올바른 연락처 카드가 아닙니다';

  @override
  String get contactOwnCard => '내 카드입니다';

  @override
  String get contactUnverified =>
      '이 방법으로 추가한 연락처는 처음에 인증되지 않은 상태입니다. 누구나 카드를 만들고 아무 이름이나 넣을 수 있으므로, 신원을 믿기 전에 직접 만나거나 통화로 지문을 비교하세요.';

  @override
  String get contactRelayOff => '인터넷 대체 경로가 꺼져 있어 아직 카드로 누구에게도 연결할 수 없습니다.';

  @override
  String get contactRelayEnable => '켜기';

  @override
  String get profileContactCard => '연락처 카드';

  @override
  String get chatsAddContactTooltip => '카드로 연락처 추가';

  @override
  String get chatsMenuTooltip => '더보기';

  @override
  String get chatsMenuAddContact => '연락처 추가';

  @override
  String get chatsMenuNewChannel => '새 채널';

  @override
  String get profileDiscoverable => '주변에 표시';

  @override
  String get profileDiscoverableOnHint => '범위 안의 누구나 나를 찾을 수 있음';

  @override
  String get profileDiscoverableOffHint => '내 연락처만 나에게 연결 가능';

  @override
  String get profileDiscoverableExplainer =>
      '켜면 내 알림 신호가 암호화되지 않은 채 송출되어 낯선 사람도 가까이 오기만 하면 나를 만날 수 있지만, 듣고 있는 누구나 내 키와 이름을 기록할 수 있습니다. 끄면 같은 정보가 이미 있는 연락처에게만 봉인되어 전송되고, 내 라우팅 ID는 서로 연결 지을 수 없게 됩니다. 이때 새로운 사람은 연락처 카드가 필요합니다.';

  @override
  String get voiceHoldHint => '길게 눌러 음성 메시지 녹음';

  @override
  String get voiceTrimPlay => '재생';

  @override
  String get voiceTrimPause => '일시정지';

  @override
  String get voiceTrimDiscard => '녹음 삭제';

  @override
  String voiceTrimSelection(String duration) {
    return '$duration 보내는 중';
  }

  @override
  String get profileLastSeen => '마지막 접속 공유';

  @override
  String get profileLastSeenOnHint => '연락처가 내가 앱에 있는 시간을 볼 수 있음';

  @override
  String get profileLastSeenOffHint =>
      '아무도 내 시간을 볼 수 없고 나도 다른 사람의 시간을 볼 수 없음: 온라인 여부만 표시';

  @override
  String get profileMapLocation => '지도에 내 위치 표시';

  @override
  String get profileMapLocationOnHint => '위치를 직접 공유할 수 있고 내 핀이 지도에 표시됨';

  @override
  String get profileMapLocationOffHint => '앱이 위치를 요청하지 않으며 내 핀은 숨겨짐';

  @override
  String get desktopAutostartTitle => 'Windows 시작 시 실행';

  @override
  String get desktopAutostartHint =>
      'CubeChat이 트레이에서 대기하므로 창을 닫아도 통화와 메시지가 이 컴퓨터로 옵니다';

  @override
  String get trayOpen => 'CubeChat 열기';

  @override
  String get trayQuit => '종료';

  @override
  String get callDirectTitle => '직접 통화';

  @override
  String get callDirectOnHint => '더 빠르지만 통화 상대가 내 IP 주소를 알게 됩니다';

  @override
  String get callDirectOffHint =>
      '통화가 우리 릴레이를 거칩니다. 상대는 내 IP를 볼 수 없고 릴레이는 통화를 들을 수 없습니다';

  @override
  String get profileReadReceipts => '읽음 확인 공유';

  @override
  String get profileReadReceiptsOnHint => '보낸 사람이 내가 읽은 시점을 볼 수 있음';

  @override
  String get profileReadReceiptsOffHint => '내 읽은 시간은 보내지 않지만 상대의 시간은 계속 보임';

  @override
  String get profilePrivacyExplainer =>
      '마지막 접속은 양방향입니다. 내 상태를 숨기면 다른 사람의 상태도 볼 수 없습니다. 읽음 확인은 내가 보내는 것만 제어합니다. 메시지 전달에는 영향이 없습니다.';

  @override
  String get chatTimerAction => '타이머';

  @override
  String get chatTimerRemove => '타이머 제거';

  @override
  String get chatTimerTitle => '다음 시간 후 이 메시지 삭제';

  @override
  String chatTimerSet(String time) {
    return '이 메시지는 $time 후 삭제됩니다';
  }

  @override
  String get chatTimerLocalHint => '이 기기에서만 — 상대의 사본은 상대의 것입니다';

  @override
  String get contactTagAction => '라벨';

  @override
  String get contactTagRemove => '라벨 제거';

  @override
  String get contactTagTitle => '라벨 선택';

  @override
  String get contactTagAll => '전체';

  @override
  String get quietHoursTitle => '방해 금지 시간';

  @override
  String get quietHoursHint => '메시지는 계속 받지만 휴대폰은 조용합니다';

  @override
  String get quietHoursFrom => '시작';

  @override
  String get quietHoursTo => '종료';

  @override
  String get notifPreviewTitle => '알림에 표시';

  @override
  String get notifPreviewFull => '이름과 내용';

  @override
  String get notifPreviewNameOnly => '이름만';

  @override
  String get notifPreviewHidden => '표시 안 함';

  @override
  String get notifPreviewHint => '앱 잠금이 켜져 있어도 알림은 잠금 화면과 알림 접근 권한이 있는 앱에 보입니다';

  @override
  String get notifPreviewNewMessage => '새 메시지';

  @override
  String get appLockTitle => '앱 잠금';

  @override
  String get appLockHint => '앱을 열 때 코드 요구';

  @override
  String get appLockPrompt => '코드를 입력하세요';

  @override
  String get appLockUnlock => '잠금 해제';

  @override
  String get appLockWrong => '잘못된 코드';

  @override
  String get appLockSetTitle => '코드 설정';

  @override
  String get appLockSetHint => '4자리 이상. 복구할 방법이 없습니다.';

  @override
  String get appLockOffTitle => '잠금 끄기';

  @override
  String get appLockOffHint => '현재 코드를 입력하세요';

  @override
  String get appLockOn => '앱 잠금 켜짐';

  @override
  String get appLockOff => '앱 잠금 꺼짐';

  @override
  String get avatarSet => '사진 선택';

  @override
  String get avatarChange => '사진 변경';

  @override
  String get avatarView => '사진 보기';

  @override
  String get profileCoverPhoto => '프로필 사진, 두 번 탭하여 확대';

  @override
  String get profileCoverMenu => '사진 옵션';

  @override
  String get avatarSaved => '갤러리에 저장했습니다';

  @override
  String get avatarRemove => '사진 삭제';

  @override
  String get avatarRemoveConfirm =>
      '이 기기에서 프로필 사진이 삭제되고, 그 자리에 자동 생성된 그라데이션이 다시 표시됩니다.';

  @override
  String get avatarFailed => '이미지를 읽을 수 없습니다';

  @override
  String get fileOpenHint => '탭하여 열기';

  @override
  String get fileMissing => '이 파일은 더 이상 사용할 수 없습니다';

  @override
  String get fileNoHandlerTitle => '열 수 있는 앱이 없음';

  @override
  String get fileNoHandlerHint =>
      '설치된 앱 중 이 파일 형식을 처리하는 앱이 없습니다. 대신 다른 앱으로 보낼 수 있습니다.';

  @override
  String get fileRequestedAgain => '보낸 사람에게 다시 요청했습니다';

  @override
  String get fileOpenFailed => '이 파일을 열 수 없습니다';

  @override
  String get fileShareAction => '앱으로 보내기';

  @override
  String fileTooLargeMesh(int limit) {
    return '파일이 너무 큽니다 — 메시로는 최대 ${limit}MB입니다';
  }

  @override
  String fileTooLargeRelay(int limit) {
    return '인터넷으로는 최대 ${limit}MB까지 보낼 수 있습니다. 더 큰 파일을 보내려면 받는 사람에게 더 가까이 가세요.';
  }

  @override
  String get mediaSendOriginal => '원본';

  @override
  String get attachFile => '파일';

  @override
  String get attachGallery => '갤러리';

  @override
  String get attachCamera => '카메라';

  @override
  String get cameraUnavailable => '카메라를 사용할 수 없음';

  @override
  String get profileEditName => '이름';

  @override
  String get profileMyCard => '카드';

  @override
  String get mediaCaptionHint => '설명 추가…';

  @override
  String get mediaDiscardTitle => '선택을 취소할까요?';

  @override
  String get mediaDiscardMessage => '갤러리를 닫고 선택한 사진을 버릴까요?';

  @override
  String get mediaDiscardConfirm => '버리기';

  @override
  String get mediaPhotosAccessOff => '사진 접근이 꺼져 있습니다';

  @override
  String get mediaPhotosAccessOffHint =>
      '현재 CubeChat은 동영상만 볼 수 있습니다. 사진을 표시하려면 시스템 설정에서 사진 접근을 허용하세요.';

  @override
  String get mediaVideosOnly => '동영상만 보입니다 — 사진 접근을 허용하세요';

  @override
  String get mediaOpenSettings => '설정 열기';

  @override
  String get mediaTakePhoto => '사진 찍기';

  @override
  String get contactProfileAutoDelete => '채팅 자동 삭제';

  @override
  String get contactProfileAutoDeleteTitle => '메시지 자동 삭제';

  @override
  String get contactProfileAutoDeleteOff => '끔';

  @override
  String get contactProfileAutoDeleteOneDay => '1일 후';

  @override
  String get contactProfileAutoDeleteSevenDays => '7일 후';

  @override
  String get contactProfileAutoDeleteThirtyDays => '30일 후';

  @override
  String contactProfileAutoDeleteUpdated(String period) {
    return '자동 삭제: $period';
  }

  @override
  String get contactProfileShare => '연락처 공유';

  @override
  String get contactProfileShareTitle => '연락처 보낼 곳';

  @override
  String get contactProfileShareEmpty => '다른 채팅이 아직 없습니다';

  @override
  String contactProfileShareSent(String name) {
    return '$name에게 보냈습니다';
  }

  @override
  String get contactProfileRestrictCopying => '복사 금지';

  @override
  String get contactProfileAllowCopying => '복사 허용';

  @override
  String get contactHideAvatar => '내 사진 숨기기';

  @override
  String get contactShowAvatar => '내 사진 표시';

  @override
  String get contactHideLastSeen => '내 마지막 접속 숨기기';

  @override
  String get contactShowLastSeen => '내 마지막 접속 표시';

  @override
  String get contactHideReadReceipts => '내 읽은 시간 숨기기';

  @override
  String get contactShowReadReceipts => '내 읽은 시간 표시';

  @override
  String get contactHiddenFromThem => '이 연락처에게 숨김';

  @override
  String get contactRefuseCalls => '이 사람의 전화 받지 않기';

  @override
  String get contactAllowCalls => '이 사람의 전화 받기';

  @override
  String get contactCallsException => '통화 설정의 예외';

  @override
  String get contactProfileCopyingRestricted => '복사 및 전달이 금지됨';

  @override
  String get contactProfileCopyingRestrictedByPeer => '상대방이 금지함';

  @override
  String get contactProfileCopyingAllowed => '복사 및 전달이 허용됨';

  @override
  String get contactProfileDelete => '연락처에서 삭제';

  @override
  String get contactProfileRestore => '연락처에 다시 추가';

  @override
  String get contactProfileRestoreDone => '연락처에 다시 추가했습니다';

  @override
  String get contactProfileDeleteTitle => '연락처를 삭제할까요?';

  @override
  String contactProfileDeleteMessage(String name) {
    return '$name님이 연락처에서 사라집니다. 채팅 기록은 이 기기에 남습니다.';
  }

  @override
  String get contactProfileMedia => '미디어';

  @override
  String get contactProfileVoiceMessages => '음성 메시지';

  @override
  String get contactProfileStickers => '스티커';

  @override
  String get contactProfileNoStickers => '아직 스티커가 없습니다';

  @override
  String get contactProfileNoMedia => '아직 미디어가 없습니다';

  @override
  String get contactProfileNoVoiceMessages => '아직 음성 메시지가 없습니다';

  @override
  String get contactProfileOpen => '프로필 열기';

  @override
  String autoDeleteDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count일',
    );
    return '$_temp0';
  }

  @override
  String autoDeleteHours(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count시간',
    );
    return '$_temp0';
  }

  @override
  String autoDeleteMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count분',
    );
    return '$_temp0';
  }

  @override
  String autoDeleteSeconds(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count초',
    );
    return '$_temp0';
  }

  @override
  String get autoDeleteCustom => '직접 설정…';

  @override
  String get autoDeleteCustomHint => '값';

  @override
  String get autoDeleteUnitMinutes => '분';

  @override
  String get autoDeleteUnitHours => '시간';

  @override
  String get autoDeleteUnitDays => '일';

  @override
  String get contactProfileAutoDeleteSet => '설정';

  @override
  String get contactProfileFiles => '파일';

  @override
  String get contactProfileNoFiles => '아직 파일이 없습니다';

  @override
  String get contactProfileLinks => '링크';

  @override
  String get contactProfileNoLinks => '아직 링크가 없습니다';

  @override
  String get contactProfilePolls => '투표';

  @override
  String get contactProfileNoPolls => '아직 투표가 없습니다';

  @override
  String get presenceRecently => '최근 접속';

  @override
  String get presenceJustNow => '방금 접속';

  @override
  String presenceHoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count시간 전 접속',
    );
    return '$_temp0';
  }

  @override
  String presenceYesterdayAt(String time) {
    return '어제 $time 접속';
  }

  @override
  String presenceOnWeekday(String day) {
    String _temp0 = intl.Intl.selectLogic(
      day,
      {
        '1': '월요일 접속',
        '2': '화요일 접속',
        '3': '수요일 접속',
        '4': '목요일 접속',
        '5': '금요일 접속',
        '6': '토요일 접속',
        '7': '일요일 접속',
        'other': '이번 주 접속',
      },
    );
    return '$_temp0';
  }

  @override
  String presenceWeeksAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count주 전 접속',
      one: '1주 전 접속',
    );
    return '$_temp0';
  }

  @override
  String presenceMonthsAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count개월 전 접속',
      one: '한 달 전 접속',
    );
    return '$_temp0';
  }

  @override
  String get presenceLongAgo => '오래전 접속';

  @override
  String presenceMinutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count분 전 접속',
    );
    return '$_temp0';
  }

  @override
  String chatReadByCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count명 읽음',
    );
    return '$_temp0';
  }

  @override
  String get chatsSearchFrequent => '자주 대화하는 사람';

  @override
  String get chatsSearchRecent => '최근';

  @override
  String get chatsSearchClear => '지우기';

  @override
  String get chatsSearchStartHint => '이름으로 채팅을 찾거나 단어로 메시지를 검색하세요.';

  @override
  String get chatsSearchEmpty => '일치하는 항목이 없습니다';

  @override
  String get chatRoutesTitle => '전달 경로';

  @override
  String get chatRoutesBluetoothHint => '인터넷 없이 상대 휴대폰으로 바로';

  @override
  String get chatRoutesMeshHint => '사이에 있는 휴대폰을 거쳐 전달';

  @override
  String get chatRoutesInternetHint => '범위 안에 아무도 없을 때 릴레이를 통해';

  @override
  String get chatRoutesHint => '경로는 메시지마다 그 순간 연결 가능한 것 중에서 선택됩니다.';

  @override
  String get chatRoutesPreferTitle => '먼저 시도할 경로';

  @override
  String get chatRoutesPreferMesh => 'Bluetooth 우선';

  @override
  String get chatRoutesPreferMeshHint =>
      '같은 공간에서 더 빠르고, 데이터를 쓰지 않으며, 릴레이에 아무것도 알리지 않음';

  @override
  String get chatRoutesPreferRelay => '인터넷 우선';

  @override
  String get chatRoutesPreferRelayHint => 'Bluetooth 연결이 약하고 인터넷 연결이 좋을 때';

  @override
  String get chatRoutesPreferNote =>
      '고정이 아닌 우선순위입니다. 선택한 경로를 쓸 수 없으면 다른 경로로 메시지가 전달됩니다.';

  @override
  String get deadmanTitle => '미사용 시 삭제';

  @override
  String get deadmanOff => '끔';

  @override
  String deadmanDays(int days) {
    return '$days일 후';
  }

  @override
  String get deadmanHint =>
      '그 기간 동안 아무도 이 앱을 열지 않으면 다음에 열 때 모든 데이터가 삭제됩니다. 미리 경고할 수는 없습니다. 그게 이 기능의 목적입니다.';

  @override
  String chatForwardedFrom(String name) {
    return '$name님이 보낸 메시지 전달';
  }

  @override
  String appLockWait(String left) {
    return '시도 횟수 초과 — $left 기다리세요';
  }

  @override
  String get appLockGraceTitle => '코드 요구';

  @override
  String get appLockGraceNow => '매번';

  @override
  String appLockGraceAfter(String left) {
    return '$left 동안 자리를 비운 후';
  }

  @override
  String get chatCalendarTitle => '날짜별';

  @override
  String get chatCalendarEmpty => '아직 여기서 나눈 대화가 없습니다';

  @override
  String get chatsSearchChatsSection => '채팅';

  @override
  String get chatsSearchMessagesSection => '메시지';

  @override
  String get contactProfileViewInChat => '채팅에서 보기';

  @override
  String get chatDraft => '임시 저장';

  @override
  String get chatSearchTitle => '검색';

  @override
  String get chatSearchHint => '메시지 검색';

  @override
  String get chatSearchNoResults => '결과 없음';

  @override
  String get chatSearchPrevious => '이전 결과';

  @override
  String get chatSearchNext => '다음 결과';

  @override
  String chatMessageCount(int count) {
    return '메시지 $count개';
  }

  @override
  String get chatRouteBluetooth => 'Bluetooth';

  @override
  String get chatRouteMesh => '메시';

  @override
  String get chatRouteInternet => '인터넷';

  @override
  String get chatRouteQueued => '대기 중';

  @override
  String get attachStickers => '스티커';

  @override
  String get stickersEmpty => '아직 스티커가 없습니다';

  @override
  String get stickersEmptyHint => '채팅의 사진을 저장하면 여기에 표시됩니다.';

  @override
  String get stickerKeep => '스티커로 저장';

  @override
  String get stickerKept => '내 스티커에 저장했습니다';

  @override
  String get stickerForget => '스티커 삭제';

  @override
  String get stickerCreate => '사진으로 스티커 만들기';

  @override
  String get stickerFailed => '이 사진으로는 스티커를 만들 수 없습니다';

  @override
  String get stickerLabel => '스티커';

  @override
  String get previewPhoto => '사진';

  @override
  String get previewVoice => '음성 메시지';

  @override
  String get previewFile => '파일';

  @override
  String get stickerEmojiTitle => '스티커에 쓸 이모지 선택';

  @override
  String get stickersMine => '내 스티커';

  @override
  String get stickersStarterPack => '큐비';

  @override
  String get emojiTab => '이모지';

  @override
  String get chatBlockedStatus => '차단됨';

  @override
  String get chatBlockedHint => '이 사람을 차단했습니다';

  @override
  String get chatRouteFallbackOff => '인터넷 꺼짐';

  @override
  String get chatAttachmentUnavailable =>
      '사용 가능한 연결이 없습니다. Bluetooth나 인터넷에 연결한 후 다시 시도하세요.';

  @override
  String get fileTransfersTitle => '파일 전송';

  @override
  String get fileTransfersClear => '기록 지우기';

  @override
  String get fileTransfersEmpty => '아직 파일 전송이 없습니다';

  @override
  String get fileTransfersActive => '진행 중';

  @override
  String get fileTransfersHistory => '기록';

  @override
  String get fileTransferPause => '일시정지';

  @override
  String get fileTransferResume => '재개';

  @override
  String get fileTransferRetry => '다시 시도';

  @override
  String get fileTransferQueued => '연결 대기 중';

  @override
  String get fileTransferRunning => '전송 중';

  @override
  String get fileTransferPaused => '일시정지됨';

  @override
  String get fileTransferCompleted => '완료됨';

  @override
  String get fileTransferFailed => '실패';

  @override
  String get fileTransferCanceled => '취소됨';

  @override
  String get profileFileTransfers => '파일 전송';

  @override
  String get profileFileTransfersSubtitle => '진행률, 대기열, 전송 기록';

  @override
  String get qrScanAction => 'QR 코드 스캔';

  @override
  String get qrScanTitle => 'QR 코드 스캔';

  @override
  String get qrScanHint => 'CubeChat 연락처, 채널, 계정 이전 또는 컴퓨터 로그인 코드를 스캔하세요.';

  @override
  String get qrFlash => '손전등';

  @override
  String get qrCameraError => '카메라를 사용할 수 없습니다. 카메라 권한을 확인한 후 다시 시도하세요.';

  @override
  String get qrInvalid => '올바른 Cubechat QR 코드가 아닙니다.';

  @override
  String qrChannelAdded(String name) {
    return '$name 추가됨';
  }

  @override
  String get qrShow => 'QR 코드 표시';

  @override
  String qrChannelTitle(String name) {
    return '$name 참여';
  }

  @override
  String get profileBackup => '암호화 백업';

  @override
  String get profileBackupSubtitle => '키, 연락처, 기록을 안전하게 옮기기';

  @override
  String get backupTitle => '암호화 백업';

  @override
  String get backupExplainer =>
      '백업에는 개인 신원 키, 연락처, 채널, 설정, 메시지 기록이 들어 있습니다. 백업은 내가 정한 비밀번호로 이 휴대폰에서 암호화되며, 비밀번호를 잊으면 Cubechat도 복구할 수 없습니다.';

  @override
  String get backupCreate => '백업 만들기';

  @override
  String get backupCreateSubtitle => '모두 암호화해 .cchatbackup 파일로 저장';

  @override
  String get backupRestore => '백업 복원';

  @override
  String get backupRestoreSubtitle => '이 휴대폰의 Cubechat 프로필을 백업 파일로 교체';

  @override
  String get backupPasswordTitle => '백업 비밀번호';

  @override
  String get backupPasswordHint => '8자 이상';

  @override
  String get backupConfirmPassword => '비밀번호 확인';

  @override
  String get backupPasswordMismatch => '비밀번호가 일치하지 않습니다';

  @override
  String get backupPasswordShort => '8자 이상 입력하세요';

  @override
  String get backupSaveTitle => 'Cubechat 백업 저장';

  @override
  String get backupSaved => '암호화 백업을 저장했습니다';

  @override
  String get backupWhereTitle => '백업을 어디에 저장할까요?';

  @override
  String get backupSaveToFiles => '파일에 저장';

  @override
  String get backupSaveToFilesHint => '휴대폰의 폴더, 메모리 카드 또는 클라우드 드라이브';

  @override
  String get backupSendToApp => '앱으로 보내기';

  @override
  String get backupSendToAppHint => 'Telegram, 메일, 메신저 등 파일을 받는 앱';

  @override
  String get backupFailed => '백업 작업을 완료할 수 없습니다';

  @override
  String get backupRestoreConfirmTitle => '이 프로필을 교체할까요?';

  @override
  String get backupRestoreConfirmMessage =>
      '이 휴대폰의 현재 키, 연락처, 채널, 설정, 기록이 선택한 백업으로 교체됩니다.';

  @override
  String get backupRestoreConfirmAction => '복원';

  @override
  String get backupRestored => '백업을 복원했습니다';

  @override
  String get backupPackingWait => '백업 만드는 중…';

  @override
  String get backupUnpackingWait => '백업 복원 중…';

  @override
  String get backupWaitHint => '사진과 동영상이 있으면 몇 분 걸릴 수 있습니다. 앱을 열어 두세요.';

  @override
  String get backupInvalid => '비밀번호가 틀렸거나, 파일이 손상되었거나, 지원하지 않는 백업입니다';

  @override
  String get channelInfoTitle => '채널 정보';

  @override
  String get channelParticipantsTitle => '참여자';

  @override
  String get channelAdministratorsTitle => '관리자';

  @override
  String get channelMakeAdmin => '관리자로 지정';

  @override
  String get channelRemoveAdmin => '관리자 해제';

  @override
  String get channelNoParticipants => '서명된 활동이 있으면 참여자가 표시됩니다';

  @override
  String get channelSharedContent => '미디어, 파일, 투표';

  @override
  String get channelDescriptionTitle => '설명';

  @override
  String get channelDescriptionEmpty => '아직 설명이 없습니다';

  @override
  String get channelDescriptionHint => '이 채널의 용도';

  @override
  String get channelDescriptionAdminOnly => '관리자만 설명을 변경할 수 있습니다';

  @override
  String get channelDescriptionSave => '저장';

  @override
  String get channelPrivateSubtitle => '비공개 채널';

  @override
  String get channelAvatarSet => '새 사진 설정';

  @override
  String get channelSettingsTitle => '채널 설정';

  @override
  String get channelSettingsHint => '게시 권한, 복사, 이전 기록';

  @override
  String get channelLeaveAction => '나가기';

  @override
  String get channelLeaveConfirm =>
      '방과 그 안의 모든 대화가 이 휴대폰에서 사라집니다. 키는 이름에서 만들어지므로 같은 이름을 입력하면 다시 열 수 있습니다.';

  @override
  String get channelShareAction => '공유';

  @override
  String channelMembersOf(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '멤버 $count명',
      one: '멤버 1명',
    );
    return '$_temp0';
  }

  @override
  String get chatTyping => '입력 중…';

  @override
  String get chatRecordingVoice => '음성 메시지 녹음 중…';

  @override
  String get chatRecordingCircle => '영상 메시지 녹화 중…';

  @override
  String get chatSendingPhoto => '사진 보내는 중…';

  @override
  String get chatSendingVideo => '동영상 보내는 중…';

  @override
  String get chatSendingFile => '파일 보내는 중…';

  @override
  String get onboardingMeshTitle => '인터넷 없이 작동';

  @override
  String get onboardingMeshBody =>
      '메시지는 Bluetooth를 통해 휴대폰에서 휴대폰으로 전달됩니다. 신호도, Wi-Fi도, 계정도 필요 없이 주변 사람들만 있으면 됩니다.';

  @override
  String get onboardingRelayTitle => '인터넷이 있으면 함께';

  @override
  String get onboardingRelayBody =>
      'Bluetooth 범위를 벗어나면 메시지는 인터넷으로 전달되며 똑같이 도착합니다. 경로를 고를 필요가 없습니다.';

  @override
  String get onboardingPrivacyTitle => '중간에서는 아무도 읽을 수 없습니다';

  @override
  String get onboardingPrivacyBody =>
      '모든 것이 종단간 암호화되며, 내 신원은 이 휴대폰에 있는 키입니다. 전화번호도, 이메일도, 누군가 빼앗을 수 있는 계정도 아닙니다.';

  @override
  String get onboardingSkip => '건너뛰기';

  @override
  String get onboardingNext => '다음';

  @override
  String get onboardingStart => '시작하기';

  @override
  String get chatMediaShare => '공유';

  @override
  String get chatMediaSaveToGallery => '갤러리에 저장';

  @override
  String get chatMediaShowInChat => '채팅에서 보기';

  @override
  String get chatWallpaperTitle => '배경화면';

  @override
  String get chatWallpaperClear => '초기화';

  @override
  String get chatWallpaperDim => '메시지 뒤 어둡게';

  @override
  String get chatSelectAction => '선택';

  @override
  String get chatForwardNothing => '전달할 수 있는 항목이 없습니다';

  @override
  String chatSelectedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count개 선택됨',
      one: '1개 선택됨',
    );
    return '$_temp0';
  }

  @override
  String chatDeleteSelectedTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '메시지 $count개를 삭제할까요?',
      one: '이 메시지를 삭제할까요?',
    );
    return '$_temp0';
  }

  @override
  String get contactAliasAction => '연락처 이름 변경';

  @override
  String get contactAliasHint => '이 이름은 나만 볼 수 있습니다. 비워 두면 상대의 이름을 사용합니다.';

  @override
  String get viewOnceSendLabel => '한 번 보기';

  @override
  String get viewOnceTitle => '한 번 보기';

  @override
  String get viewOnceTapToView => '사진 · 탭하여 한 번 보기';

  @override
  String get viewOnceSent => '사진 · 보냄';

  @override
  String get viewOnceOpened => '사진 열람됨';

  @override
  String get viewOnceUnavailable => '이 사진은 더 이상 볼 수 없습니다';

  @override
  String get viewOnceWarning => '닫으면 양쪽 모두에서 사진이 삭제됩니다.';

  @override
  String get channelAvatarAdminOnly => '관리자만 채널 사진을 변경할 수 있습니다';

  @override
  String get channelAdminOnly => '관리자만 변경할 수 있습니다';

  @override
  String get channelAvatarTooLarge => '사진이 너무 커서 전송할 수 없습니다';

  @override
  String get channelMemberUnknown => '아직 연락처에 없음';

  @override
  String get channelInviteToContacts => '내 연락처 카드 보내기';

  @override
  String channelContactInviteSent(String name) {
    return '$name님에게 연락처 카드를 보냈습니다';
  }

  @override
  String get chatContactInvitation => '연결 초대';

  @override
  String get chatContactInvitationForYou => '나에게 온 초대';

  @override
  String get channelPollTitle => '투표';

  @override
  String get channelCreatePoll => '투표 만들기';

  @override
  String get channelPollQuestion => '질문';

  @override
  String channelPollOption(int number) {
    return '선택지 $number';
  }

  @override
  String get channelPollAddOption => '선택지 추가';

  @override
  String get channelPollCreate => '투표 게시';

  @override
  String channelPollVotes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count표',
      one: '1표',
      zero: '투표 없음',
    );
    return '$_temp0';
  }

  @override
  String get phoneTransferTitle => '새 휴대폰으로 이전';

  @override
  String get desktopPickChat => '메시지를 보낼 상대를 선택하세요';

  @override
  String get desktopListCollapse => '프로필 사진만 표시';

  @override
  String get desktopListExpand => '채팅 목록 표시';

  @override
  String get desktopLinkConnectTitle => '컴퓨터 연결';

  @override
  String get desktopLinkConnectHint => '컴퓨터의 CubeChat에 표시된 코드를 스캔하세요';

  @override
  String get desktopLinkSignIn => '휴대폰 계정으로 로그인';

  @override
  String get desktopLinkTitle => '휴대폰으로 로그인';

  @override
  String get desktopLinkSteps =>
      '휴대폰에서 프로필 → 데이터 및 저장 공간 → 컴퓨터 연결로 이동한 후 이 코드를 스캔하세요. 두 기기가 같은 Wi-Fi에 연결되어 있어야 합니다.';

  @override
  String get desktopLinkLimits =>
      '휴대폰은 계속 작동합니다. 인터넷으로 오는 메시지는 양쪽 모두에 도착하지만, 한쪽에서 보낸 메시지는 아직 다른 쪽에 표시되지 않습니다.';

  @override
  String get desktopLinkWaiting => '휴대폰을 기다리는 중…';

  @override
  String get desktopLinkFailed => '계정을 받을 수 없습니다. 다시 시도하세요.';

  @override
  String get desktopLinkRetry => '다시 시도';

  @override
  String get desktopLinkConfirmTitle => '이 계정의 사본을 컴퓨터로 보낼까요?';

  @override
  String get desktopLinkConfirmMessage =>
      '컴퓨터가 내 키, 연락처, 채팅을 받습니다. 이 휴대폰은 지금처럼 계속 작동합니다.';

  @override
  String get desktopLinkConfirmAction => '보내기';

  @override
  String desktopLinkConfirmWhere(String address) {
    return '방금 내 컴퓨터 화면에서 이 코드를 스캔한 경우에만 진행하세요. 이 네트워크의 $address(으)로 전송됩니다.';
  }

  @override
  String get desktopLinkSending => '계정 보내는 중…';

  @override
  String get desktopLinkSent => '컴퓨터가 연결되었습니다';

  @override
  String get desktopLinkPhoneFound =>
      '휴대폰이 이 컴퓨터를 찾아 계정 사본을 만들고 있습니다. 사진이 있으면 몇 분 걸릴 수 있습니다.';

  @override
  String desktopLinkReceiving(int percent) {
    return '계정 받는 중: $percent%';
  }

  @override
  String get desktopLinkRestoring => '이 컴퓨터에 계정을 설정하는 중…';

  @override
  String get desktopLinkFinding => '컴퓨터를 찾는 중…';

  @override
  String get desktopLinkPreparing => '계정 사본을 만드는 중입니다. 사진이 있으면 몇 분 걸릴 수 있습니다.';

  @override
  String desktopLinkSendingPercent(int percent) {
    return '보내는 중: $percent%';
  }

  @override
  String get desktopLinkComputerRestoring => '컴퓨터에서 계정을 설정하는 중…';

  @override
  String get devicesTitle => '기기';

  @override
  String get devicesRowHint => '계정이 열려 있는 곳과 로그아웃';

  @override
  String get devicesThisDevice => '이 기기';

  @override
  String get devicesSeenNow => '방금 온라인';

  @override
  String devicesSeenMinutes(int n) {
    return '$n분 전 온라인';
  }

  @override
  String devicesSeenHours(int n) {
    return '$n시간 전 온라인';
  }

  @override
  String devicesSeenDays(int n) {
    return '$n일 전 온라인';
  }

  @override
  String get devicesLeaving => '로그아웃 중 — 기기가 온라인 상태가 되기를 기다리는 중';

  @override
  String get devicesSignOut => '로그아웃';

  @override
  String get devicesSignOutAll => '다른 모든 기기에서 로그아웃';

  @override
  String devicesSignOutTitle(String name) {
    return '‘$name’에서 로그아웃할까요?';
  }

  @override
  String get devicesSignOutMessage =>
      '해당 기기가 온라인 상태가 되는 즉시 그 기기의 CubeChat 키, 채팅, 설정이 삭제됩니다. 계정은 이 기기와 다른 기기에 남습니다.';

  @override
  String get devicesSignOutPhoneMessage =>
      '휴대폰입니다. 그 휴대폰의 CubeChat이 완전히 삭제됩니다. 계정은 이 기기와 다른 기기에 남습니다.';

  @override
  String get devicesSignOutAllMessage =>
      '다른 모든 기기는 온라인 상태가 되는 즉시 로그아웃됩니다. 계정은 이 기기에만 남습니다.';

  @override
  String get devicesRename => '이름 변경';

  @override
  String get devicesRenameTitle => '이 기기의 이름';

  @override
  String get devicesSave => '저장';

  @override
  String get devicesEmpty =>
      '아직 다른 기기가 없습니다. CubeChat 1.0.0+1147 이상을 연 기기가 여기에 표시됩니다.';

  @override
  String get devicesCaveat =>
      '로그아웃은 해당 기기가 온라인 상태가 될 때 적용됩니다. 오프라인으로 유지되는 기기는 키를 그대로 갖게 되므로, 완벽하게 보호하려면 계정 키를 새로 만들어야 합니다.';

  @override
  String get desktopLinkImportTitle => '휴대폰에서 계정 옮기기';

  @override
  String get desktopLinkImportHint => '휴대폰에 코드를 보여 주면 이 컴퓨터가 그 계정의 사본이 됩니다';

  @override
  String get desktopLinkImportConfirmTitle => '이 컴퓨터의 계정을 교체할까요?';

  @override
  String get desktopLinkImportConfirmMessage =>
      '이 컴퓨터의 키, 연락처, 채팅이 휴대폰의 계정으로 교체됩니다. 기존 계정이 아직 필요하면 먼저 백업하세요.';

  @override
  String get desktopLinkImportConfirmAction => '계속';

  @override
  String get desktopLinkUnreachable =>
      '컴퓨터에 연결할 수 없습니다. 두 기기가 같은 Wi-Fi에 있어야 하며, 컴퓨터의 방화벽에서 CubeChat을 허용해야 합니다.';

  @override
  String get desktopLinkFirewallHint =>
      'Windows가 휴대폰의 연결을 막을 수 있습니다. 방화벽에서 CubeChat을 허용하세요 — 로컬 네트워크에만.';

  @override
  String get desktopLinkFirewallAllow => '방화벽에서 허용';

  @override
  String get desktopLinkFirewallDeclined =>
      'Windows가 허용하지 않았습니다. 허용하지 않으면 휴대폰이 연결되지 않을 수 있습니다.';

  @override
  String get phoneTransferIntro => '프로필, 키, 연락처, 채널, 설정, 기록을 두 휴대폰 간에 직접 옮기세요.';

  @override
  String get phoneTransferSend => '이전 휴대폰입니다';

  @override
  String get phoneTransferReceive => '새 휴대폰입니다';

  @override
  String get phoneTransferSameWifi =>
      '두 휴대폰을 같은 Wi-Fi에 연결하세요. 이전이 끝날 때까지 이 화면을 열어 두세요.';

  @override
  String get phoneTransferPreparing => '암호화 이전 준비 중…';

  @override
  String get phoneTransferReady => '새 휴대폰에서 이 일회용 QR 코드를 스캔하세요';

  @override
  String get phoneTransferScan => '이전 휴대폰 스캔';

  @override
  String get phoneTransferConfirmTitle => '이 휴대폰의 프로필을 교체할까요?';

  @override
  String get phoneTransferConfirmMessage =>
      '현재 이 휴대폰에 저장된 프로필이 암호화된 로컬 이전 데이터로 교체됩니다.';

  @override
  String get phoneTransferConfirmAction => '프로필 이전';

  @override
  String get phoneTransferSuccess => '프로필을 이전했습니다';

  @override
  String get phoneTransferFailed => '휴대폰 이전을 완료할 수 없습니다';

  @override
  String get profileSummaryMeshOnly => '메시만';

  @override
  String get profileSummaryMeshInternet => '메시 · 인터넷';

  @override
  String get profileSummaryBackgroundOn => '백그라운드 실행';

  @override
  String profileSummaryTransfersActive(int count) {
    return '$count개 진행 중';
  }

  @override
  String get profileSummaryCardBackup => '파일, 백업';

  @override
  String get chatPlay => '재생';

  @override
  String get chatPause => '일시정지';

  @override
  String get profileTheme => '색상';

  @override
  String get profileThemeEmerald => '에메랄드';

  @override
  String get profileThemeIndigo => '인디고';

  @override
  String get profileThemeAmber => '앰버';

  @override
  String get profileThemeRose => '로즈';

  @override
  String get profileThemeFuchsia => '푸크시아';

  @override
  String get profileThemeViolet => '바이올렛';

  @override
  String get profileThemeOcean => '오션';

  @override
  String get profileThemeSlate => '슬레이트';

  @override
  String get profileScale => '인터페이스 크기';

  @override
  String get profileScaleSystem => '시스템';

  @override
  String get profileGlass => '유리 효과';

  @override
  String get profileGlassAuto => '자동';

  @override
  String get profileGlassFull => '전체';

  @override
  String get profileGlassLight => '가볍게';

  @override
  String get profileGlassHint =>
      '가볍게는 색조는 유지하고 패널 뒤의 흐림을 없앱니다. 자동은 휴대폰 성능을 한 번 측정해 결정합니다. 이미 충분히 빠른 휴대폰에서는 효과가 거의 없으며, 느린 휴대폰을 위한 기능입니다.';

  @override
  String get mapAlwaysNeeded =>
      'cubechat이 닫혀 있을 때도 지도가 업데이트되려면 위치를 ‘항상’으로 설정해야 합니다. 탭하여 설정을 여세요.';

  @override
  String get mapShareConsentTitle => '지도에 내 위치를 표시할까요?';

  @override
  String get mapShareConsentBody =>
      '내 실시간 위치는 지도에 있는 연락처, 즉 내가 초대했거나 초대를 수락한 사람에게만 표시됩니다. 숨기기 전까지 Cubechat이 백그라운드에 있을 때도 계속 업데이트됩니다. 위치는 종단간 암호화되며 우리에게 전달되지 않습니다. 지도나 프로필에서 언제든 숨길 수 있으며, 차단한 연락처는 절대 나를 볼 수 없습니다.';

  @override
  String get mapShareConsentAllow => '허용';

  @override
  String get mapShareConsentDecline => '허용 안 함';

  @override
  String get mapVisibleToFriends => '지도 위 친구들이 나를 볼 수 있음';

  @override
  String get mapHiddenFromFriends => '숨겨져 있음';

  @override
  String get mapHideMe => '숨기기';

  @override
  String get mapShowMe => '내 위치 표시';

  @override
  String get profileScaleSmall => '작게';

  @override
  String get profileScaleNormal => '보통';

  @override
  String get profileScaleLarge => '크게';

  @override
  String get profileScaleSample => '텍스트와 항목이 이 크기로 표시됩니다.';

  @override
  String get savedTitle => '저장됨';

  @override
  String get savedSubtitle => '이 기기에 저장되는 나만의 메모';

  @override
  String get savedEmpty => '여기에 쓴 내용은 이 휴대폰에만 남습니다.';

  @override
  String get meshOffTitle => 'Bluetooth 메시가 꺼져 있습니다';

  @override
  String get meshOffHint =>
      '주변 사람이 나를 찾을 수 없고 나도 찾을 수 없습니다. 메시지는 계속 인터넷 릴레이로 전달됩니다.';

  @override
  String get profileMeshSwitch => 'Bluetooth 메시';

  @override
  String get profileMeshSwitchHint =>
      '인터넷 없이 주변 사람을 찾고 메시지를 전달합니다. 끄면 배터리가 절약됩니다.';

  @override
  String get channelAdminOnlyHint => '공지 채널입니다. 모두가 읽을 수 있습니다.';

  @override
  String get attachLocation => '위치';

  @override
  String get locationBubbleTitle => '위치';

  @override
  String get locationOpenInMaps => '지도 앱에서 열기';

  @override
  String locationAccuracy(int metres) {
    return '오차 ${metres}m 이내';
  }

  @override
  String get locationExpired => '이 위치는 더 이상 최신이 아닙니다';

  @override
  String get locationDenied => '위치 권한이 꺼져 있습니다';

  @override
  String get locationUnavailable => '위치를 가져올 수 없습니다';

  @override
  String get locationShareFor => '공유 기간';

  @override
  String get locationShareOnce => '한 번만';

  @override
  String get locationShare15m => '15분';

  @override
  String get locationShare1h => '1시간';

  @override
  String get storageTitle => '저장 공간';

  @override
  String get storageHeadline => '저장 공간 사용량';

  @override
  String storageSubtitle(String size) {
    return 'cubechat이 이 기기에서 $size 사용 중';
  }

  @override
  String get storageEmpty => '아직 저장된 항목이 없습니다';

  @override
  String get storageScanning => '계산 중…';

  @override
  String get storageCatPhotos => '사진';

  @override
  String get storageCatVoice => '음성 메시지';

  @override
  String get storageCatFiles => '받은 파일';

  @override
  String get storageCatOutbox => '보낸 파일';

  @override
  String get storageCatStickers => '스티커';

  @override
  String get storageCatSaved => '저장된 메시지';

  @override
  String get storageCatWallpapers => '배경화면';

  @override
  String get storageCatHistory => '대화 및 키';

  @override
  String get storageCatCache => '캐시';

  @override
  String storageClear(String size) {
    return '$size 삭제';
  }

  @override
  String get storageClearNothing => '선택된 항목 없음';

  @override
  String storageFreed(String size) {
    return '$size 확보됨';
  }

  @override
  String get storageNoCloud =>
      '클라우드가 없습니다. 삭제한 항목은 이 휴대폰에서 사라지며, 남은 사본은 보낸 사람의 휴대폰에만 있습니다.';

  @override
  String get storageWhyHistoryLocked => '대화는 여기서 지울 수 없습니다. 긴급 삭제를 사용하세요.';

  @override
  String get storageRecoveryFree => '안전하게 삭제 가능';

  @override
  String get storageRecoveryGone => '다른 곳에 사본 없음';

  @override
  String get storageRecoveryAskSender => '보낸 사람에게 다시 요청 가능';

  @override
  String get storageRecoveryCostsThem => '상대가 더 이상 재전송을 요청할 수 없음';

  @override
  String storageConfirmTitle(String size) {
    return '$size를 삭제할까요?';
  }

  @override
  String get storageConfirmBody =>
      '이 휴대폰에서 파일이 삭제됩니다. 어디에도 업로드되지 않으므로 복원할 방법이 없습니다.';

  @override
  String storageFilesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '파일 $count개',
      zero: '비어 있음',
    );
    return '$_temp0';
  }

  @override
  String get customizeBarTitle => '하단 탭 바';

  @override
  String get customizeBarHint => '끌어서 순서를 바꾸세요. 채팅은 제거할 수 없습니다.';

  @override
  String get customizeBarShown => '표시됨';

  @override
  String get customizeBarHidden => '숨김';

  @override
  String get customizeBarHiddenEmpty => '숨긴 항목 없음';

  @override
  String get customizeBarMinimum => '탭을 2개 이상 유지하세요';

  @override
  String get customizeReset => '기본값으로 재설정';

  @override
  String get chatsArchiveTitle => '보관함';

  @override
  String get chatsArchiveEmpty => '보관된 채팅 없음';

  @override
  String get chatsArchiveHint => '보관된 채팅도 정상 작동합니다. 목록에서만 빠질 뿐입니다.';

  @override
  String get chatsArchivedToast => '보관됨';

  @override
  String get chatsUnarchivedToast => '목록으로 복원됨';

  @override
  String chatsArchiveCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '채팅 $count개',
    );
    return '$_temp0';
  }

  @override
  String get chatsSwipeNotHere => '이 채팅에서는 사용할 수 없음';

  @override
  String get customizeSwipeTitle => '채팅을 오른쪽으로 스와이프';

  @override
  String get customizeSwipeHint => '왼쪽으로 스와이프하면 그대로 탭이 전환됩니다.';

  @override
  String get customizeSwipeArchive => '보관';

  @override
  String get customizeSwipeMute => '알림 끄기';

  @override
  String get customizeSwipePin => '고정';

  @override
  String get customizeSwipeRead => '읽음';

  @override
  String get customizeSwipeDelete => '삭제';

  @override
  String get customizeSwipeNone => '없음';

  @override
  String get customizeHighRefresh => '최대 화면 주사율';

  @override
  String get customizeHighRefreshHint =>
      '더 부드럽지만 휴대폰이 두 배 많은 프레임을 그립니다. 휴대폰이 뜨거워지면 끄세요. 앱의 모양은 바뀌지 않고 다시 그리는 빈도만 바뀝니다.';

  @override
  String get customizeQuickReaction => '두 번 탭 반응';

  @override
  String get customizeQuickReactionHint =>
      '메시지를 두 번 탭할 때 남길 반응입니다. 다른 반응을 사용하면 그 반응이 여기로 옵니다.';

  @override
  String get customizeCircleAudioTitle => '영상 메시지 재생 시 음악 일시정지';

  @override
  String get customizeCircleAudioOn =>
      '녹화하거나 볼 때 재생 중인 다른 소리를 멈춥니다. 이후 자동으로 다시 재생되지 않습니다.';

  @override
  String get customizeCircleAudioOff => '영상 메시지가 재생되는 동안 음악은 작은 소리로 계속 재생됩니다.';

  @override
  String get customizeMediaQualityTitle => '보낼 때 사진 화질';

  @override
  String get customizeMediaQualityEconomy => '절약';

  @override
  String get customizeMediaQualityStandard => '표준';

  @override
  String get customizeMediaQualityHigh => '고화질';

  @override
  String get customizeMediaQualityEconomyHint =>
      '사진당 최대 96KB, 800px. 신호가 약하거나 Bluetooth 메시가 붐빌 때: 대기 시간은 절반, 사진은 덜 선명합니다.';

  @override
  String get customizeMediaQualityStandardHint =>
      '사진당 최대 192KB, 1280px. Bluetooth만으로도 전송되는 크기입니다. 동영상과 ‘원본’은 항상 그대로 보냅니다.';

  @override
  String get customizeMediaQualityHighHint =>
      '사진당 최대 768KB, 2048px. 확대해도 선명하지만 전송 시간이 네 배라서 Wi-Fi에서 쓰는 것이 좋습니다.';

  @override
  String get previewReacted => '내 메시지에 반응';

  @override
  String get previewLocation => '위치';

  @override
  String get previewMapInvite => '지도 초대';

  @override
  String get previewContact => '연락처';

  @override
  String get previewUnsupported => '지원되지 않는 메시지';

  @override
  String get previewCallOutgoing => '발신 통화';

  @override
  String get previewCallIncoming => '수신 통화';

  @override
  String get previewCallMissed => '부재중 통화';

  @override
  String chatPreparingPhotos(int count) {
    return '사진 $count장 준비 중…';
  }

  @override
  String get circleSwitchCamera => '카메라 전환';

  @override
  String get circleLight => '녹화 조명';

  @override
  String get circleCameraSwitchFailed => '카메라를 전환할 수 없습니다. 녹화는 계속 열려 있습니다.';

  @override
  String get diagnosticsTitle => '진단';

  @override
  String get diagnosticsIntro => '최근 앱의 활동 내역입니다. 문제가 있으면 개발자에게 보내 주세요.';

  @override
  String get diagnosticsShare => '개발자에게 로그 보내기';

  @override
  String get diagnosticsEvents => '최근 이벤트';

  @override
  String get diagnosticsTechnical => '기술 기록';

  @override
  String get diagnosticsEmpty => '아직 표시할 내용이 없습니다.';

  @override
  String get diagnosticsDeveloperOn => '개발자 모드 켜짐';

  @override
  String get diagnosticsDeveloperOff => '개발자 모드 꺼짐';

  @override
  String get logAppStarted => '앱 시작됨';

  @override
  String get logInternetOn => '인터넷 연결 켜짐';

  @override
  String logServerConnected(String host) {
    return '$host에 연결됨';
  }

  @override
  String logServerLost(String host) {
    return '$host 연결 끊김';
  }

  @override
  String get chatSaveAction => '저장';

  @override
  String get savedTagAsk => '저장했습니다. 태그를 추가할까요?';

  @override
  String get savedTagAdd => '태그 추가';

  @override
  String get chatSharedWallpaperFailed =>
      '여기에 배경화면을 설정했습니다. 상대가 범위 안에 들어오면 전달됩니다.';

  @override
  String get chatTranscribeAction => '텍스트 변환';

  @override
  String get chatTranscribeFailed => '이 휴대폰에서는 이 메시지를 텍스트로 변환할 수 없습니다.';

  @override
  String get chatTranscribing => '인식 중…';

  @override
  String get chatTranscriptHide => '텍스트 숨기기';

  @override
  String get chatCancelSend => '전송 취소';

  @override
  String get chatDownloadAction => '다운로드';

  @override
  String get chatDownloaded => '휴대폰에 저장했습니다';

  @override
  String get chatDownloadFailed => '저장할 수 없습니다';

  @override
  String get selfUpdateTitle => '파일로 업데이트 설치';

  @override
  String get selfUpdateHint =>
      '새 cubechat APK를 채팅에서 열지 말고 여기서 선택하세요. 이렇게 설치해야 잠금 화면 통화가 계속 켜져 있습니다.';

  @override
  String get selfUpdateConfirm => '시스템 창에서 설치를 확인하세요.';

  @override
  String get selfUpdateAllow => 'cubechat의 앱 설치를 허용한 후 다시 탭하세요.';

  @override
  String get selfUpdateNotOurs => 'cubechat 업데이트 파일이 아닙니다.';

  @override
  String get selfUpdateFailed => '업데이트가 설치되지 않았습니다.';

  @override
  String get chatTranscribeDownloading =>
      '휴대폰이 이 언어를 다운로드하고 있습니다. 잠시 후 다시 시도하세요.';

  @override
  String get chatTranscribeNoLanguage =>
      '이 휴대폰에 해당 언어의 음성 모델이 없습니다. 프로필 → 채팅 및 미디어에서 음성 텍스트 변환 언어를 선택하세요.';

  @override
  String get chatTranscribeNotAllowed =>
      'CubeChat의 음성 인식이 꺼져 있습니다. iPhone 설정 → CubeChat에서 켜세요.';

  @override
  String get customizeTranscribeLanguageTitle => '음성 텍스트 변환 언어';

  @override
  String get customizeTranscribeLanguageAuto => '자동';

  @override
  String get customizeTranscribeLanguageHint =>
      '음성 메시지에서 말하는 언어로, 앱 언어와 달라도 됩니다. 자동은 휴대폰의 언어를 시도합니다. 없는 언어는 휴대폰이 직접 다운로드하며, 음성은 휴대폰 밖으로 나가지 않습니다.';

  @override
  String get chatTranslateAction => '번역';

  @override
  String get chatTranslateFailed => '이 휴대폰에서는 이 메시지를 번역할 수 없습니다.';

  @override
  String get customizeDeferMediaTitle => 'Wi-Fi에서만 미디어 다운로드';

  @override
  String get customizeDeferMediaHint =>
      '모바일 데이터에서는 메시지와 통화가 평소처럼 작동하고, 사진, 음성 메시지, 영상 메시지, 파일은 서버에서 Wi-Fi를 최대 2주간 기다립니다. 채팅 목록 위의 줄에서 대기 중인 항목을 확인하고 바로 다운로드할 수 있습니다.';

  @override
  String heldMediaCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '미디어 $count개가 Wi-Fi 대기 중',
      one: '미디어 1개가 Wi-Fi 대기 중',
    );
    return '$_temp0';
  }

  @override
  String get heldMediaDownload => '다운로드';

  @override
  String get nearbyAirDropSubtitle => '주변 사람과 파일 공유';

  @override
  String get nearbyFilesSubtitle => '보내고 받은 파일';

  @override
  String get airdropTab => 'AirDrop';

  @override
  String get nearbyTabFiles => '파일';

  @override
  String get airdropReceiveHint => '나에게 파일을 보낼 수 있는 사람';

  @override
  String get airdropReceiveContacts => '연락처';

  @override
  String get airdropReceiveEveryone => '모두 10분';

  @override
  String airdropEveryoneLeft(String time) {
    return '모두 · $time';
  }

  @override
  String get airdropSendFiles => '파일 보내기';

  @override
  String get airdropChooseFiles => '파일 선택';

  @override
  String airdropStagedTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '파일 $count개 준비됨',
    );
    return '$_temp0';
  }

  @override
  String get airdropStagedHint =>
      '두 휴대폰 모두 Bluetooth를 켜고 AirDrop을 연 상태에서 휴대폰을 맞대거나 사람을 선택하세요';

  @override
  String get airdropStagedPickPerson => '사람 선택';

  @override
  String airdropRequestBody(String what, String size) {
    return '$what 보내기 요청 · $size';
  }

  @override
  String airdropWhatPhotos(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '사진 $count장',
      one: '사진 1장',
    );
    return '$_temp0';
  }

  @override
  String airdropWhatVideos(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '동영상 $count개',
      one: '동영상 1개',
    );
    return '$_temp0';
  }

  @override
  String airdropWhatFiles(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '파일 $count개',
      one: '파일 1개',
    );
    return '$_temp0';
  }

  @override
  String get airdropAccept => '수락';

  @override
  String get airdropDecline => '거절';

  @override
  String get airdropWaiting => '응답 기다리는 중…';

  @override
  String get airdropAccepted => '수락됨';

  @override
  String get airdropUnheard => '받지 못함 — 이전 버전의 CubeChat일 수 있음';

  @override
  String get airdropSending => '보내는 중';

  @override
  String get airdropReceiving => '받는 중';

  @override
  String get airdropInterrupted => '중단됨';

  @override
  String get airdropRetry => '다시 시도';

  @override
  String get airdropOutcomeSent => '보냄';

  @override
  String get airdropOutcomeReceived => '받음';

  @override
  String get airdropOutcomeDeclined => '거절됨';

  @override
  String get airdropOutcomeCancelled => '취소됨';

  @override
  String get airdropOutcomePartial => '일부만';

  @override
  String get airdropReasonNoSpace => '공간 부족';

  @override
  String get airdropReasonContactsOnly => '연락처만';

  @override
  String get airdropReasonBusy => '사용 중';

  @override
  String get airdropReasonTimeout => '응답 없음';

  @override
  String get airdropFileDeleted => '삭제됨';

  @override
  String get airdropHistory => '기록';

  @override
  String get airdropClearHistory => '기록 지우기';

  @override
  String get airdropEmpty => '주변에서 보내거나 받은 파일이 여기에 표시됩니다';

  @override
  String get airdropPickPerson => '보낼 대상';

  @override
  String get airdropNobody => '아직 주변에 cubechat 사용자가 없습니다';

  @override
  String get airdropNoDirect => '이 사람과 Bluetooth로 연결되어 있지 않습니다';

  @override
  String get airdropNearbyUnknown => '주변';

  @override
  String get airdropConnecting => '연결 중…';

  @override
  String get airdropConnectFailed => '연결할 수 없음';

  @override
  String get airdropSlowWarning => 'Bluetooth로는 시간이 오래 걸릴 수 있습니다';

  @override
  String airdropTooLarge(String name, int limit) {
    return '$name이(가) ${limit}MB보다 큽니다';
  }

  @override
  String airdropFromLabel(String name) {
    return 'AirDrop · $name';
  }

  @override
  String get airdropWrite => '메시지';

  @override
  String get airdropAction => 'AirDrop';

  @override
  String get airdropLaneTitle => '전송 경로';

  @override
  String get airdropLaneAuto => '자동';

  @override
  String get airdropLaneBluetooth => 'Bluetooth';

  @override
  String get airdropLaneWifi => 'Wi‑Fi';

  @override
  String get airdropBluetoothNeededHint =>
      '서로를 찾고 전송을 확인하려면 두 휴대폰 모두 Bluetooth를 켜세요.';

  @override
  String get airdropLaneHint =>
      'Bluetooth는 휴대폰을 찾아 연결합니다. 두 휴대폰이 같은 네트워크나 핫스팟에 있으면 Wi‑Fi로 파일을 옮깁니다.';

  @override
  String get airdropWifiUnreachable => '같은 네트워크에 없음';

  @override
  String get airdropWifiOldVersion => '상대 앱이 아직 Wi‑Fi로 받을 수 없습니다';

  @override
  String get airdropBumpAdd => '추가';

  @override
  String get airdropBumpAlreadyContact => '이미 연락처에 있음';

  @override
  String airdropBumpSending(String name) {
    return '$name님에게 보내는 중';
  }

  @override
  String airdropBumpReceiving(String name) {
    return '$name님이 파일을 보내는 중';
  }

  @override
  String get termsTitle => 'cubechat 이용 규칙';

  @override
  String get termsBody =>
      'cubechat은 불쾌한 콘텐츠와 악성 사용자를 절대 용납하지 않습니다. 계속하면 괴롭힘, 협박, 미성년자가 관련된 성적 콘텐츠, 스팸 또는 불법적인 내용을 보내지 않는 데 동의하는 것입니다. 누구나 메시지나 사람을 신고할 수 있으며, 신고는 개발자에게 전달되어 24시간 이내에 처리되고 위반자는 이용이 정지됩니다.';

  @override
  String get termsReadFull => '전체 약관 보기';

  @override
  String get termsAccept => '동의합니다';

  @override
  String get messageHide => '숨기기';

  @override
  String get messageHidden => '나에게서 숨김';

  @override
  String get reportAction => '신고';

  @override
  String get reportTitle => '어떤 문제인가요?';

  @override
  String get reportReasonSpam => '스팸';

  @override
  String get reportReasonAbuse => '욕설 또는 괴롭힘';

  @override
  String get reportReasonViolence => '폭력';

  @override
  String get reportReasonSexual => '성적 콘텐츠';

  @override
  String get reportReasonOther => '기타';

  @override
  String get reportNoteHint => '설명 (선택)';

  @override
  String get reportSend => '신고 보내기';

  @override
  String get reportDisclosure =>
      '선택한 메시지 텍스트와 신고 내용이 cubechat 운영팀과 비공개 Telegram 봇으로 전달됩니다.';

  @override
  String get reportSent => '신고를 보냈습니다. 신고는 24시간 이내에 검토합니다.';

  @override
  String get reportBlockedToo => '이 사람을 차단했습니다.';

  @override
  String get reportQueued => '신고를 저장했습니다. 온라인이 되면 전송됩니다.';

  @override
  String get reportFailed => '신고를 보낼 수 없습니다.';

  @override
  String get filteredMessage => '필터로 숨겨짐';

  @override
  String get filteredShow => '보기';

  @override
  String get filterToggle => '불쾌한 콘텐츠 필터';

  @override
  String get filterToggleHint => '모르는 사람과 채널의 욕설을 숨깁니다';

  @override
  String get aboutTitle => '정보';

  @override
  String get aboutContact => '개발자에게 이메일 보내기';

  @override
  String get aboutReport => '위반 신고';

  @override
  String get aboutTerms => '이용약관';

  @override
  String get aboutPrivacy => '개인정보 처리방침';

  @override
  String get requestsTitle => '요청';

  @override
  String get requestsEmpty => '요청 없음';

  @override
  String requestBanner(String name) {
    return '$name님은 연락처에 없습니다. 수락하기 전까지 이 사람은 내가 읽었는지 볼 수 없고 전화할 수도 없습니다.';
  }

  @override
  String get requestAccept => '수락';

  @override
  String get requestDelete => '삭제';

  @override
  String get requestBlock => '차단';

  @override
  String get cubeIdTitle => 'Cube ID';

  @override
  String get cubeIdExplainer =>
      '내 @이름은 내 연락처 카드로 연결됩니다. 서버는 이름과 공개 카드만 보관하며, 메시지는 절대 보관하지 않습니다.';

  @override
  String get cubeIdFieldHint => 'a–z, 0–9, _ 사용, 3–20자';

  @override
  String get cubeIdAvailable => '사용 가능';

  @override
  String get cubeIdTaken => '사용 중';

  @override
  String get cubeIdReserved => '사용 불가';

  @override
  String get cubeIdInvalid => 'a–z, 0–9, _만 사용, 3–20자';

  @override
  String get cubeIdClaim => '이 이름 사용';

  @override
  String get cubeIdWorking => '이름 등록 중…';

  @override
  String get cubeIdChange => '변경';

  @override
  String get cubeIdEmail => '복구 이메일';

  @override
  String get cubeIdEmailHint => '이 휴대폰을 분실하면 이 주소로 오는 메일로 이름을 되찾을 수 있습니다';

  @override
  String get cubeIdEmailField => '이메일';

  @override
  String cubeIdEmailSent(String email) {
    return '$email(으)로 메일을 보냈습니다. 메일 속 링크를 여세요.';
  }

  @override
  String get cubeIdEmailRemove => '이메일 제거';

  @override
  String get cubeIdEmailUnavailable => '지금은 이메일을 사용할 수 없습니다. 나중에 다시 시도하세요.';

  @override
  String get cubeIdEmailInvalid => '올바른 이메일 주소가 아닌 것 같습니다';

  @override
  String get cubeIdSave => '저장';

  @override
  String get cubeIdRecover => '이메일로 이름 복구';

  @override
  String get cubeIdRecoverSent =>
      '주소가 일치하면 메일이 옵니다. 링크를 열고 48시간 후에 이름이 이 휴대폰으로 옮겨집니다.';

  @override
  String cubeIdRecoveryWarning(String name, String when) {
    return '누군가 다른 휴대폰에서 이메일로 @$name을(를) 복구하고 있습니다. 취소하지 않으면 $when에 이름이 옮겨집니다.';
  }

  @override
  String get cubeIdRecoveryCancel => '복구 취소';

  @override
  String get cubeIdRecoveryCancelled => '복구를 취소했습니다';

  @override
  String get cubeIdRelease => '해제';

  @override
  String cubeIdReleaseConfirm(String name) {
    return '@$name을(를) 해제할까요? 누구나 이 이름을 가져갈 수 있게 됩니다.';
  }

  @override
  String get cubeIdShare => '공유';

  @override
  String cubeIdShareText(String name) {
    return 'cubechat에서 저를 찾아 주세요: @$name\nhttps://cubechat.tech/u.html#$name';
  }

  @override
  String get cubeIdFailed => '이름을 저장할 수 없습니다. 다시 시도하세요.';

  @override
  String get cubeIdOffline => '인터넷 연결 없음';

  @override
  String get lookupNotFound => '해당 @이름의 사용자가 없습니다';

  @override
  String searchFindCubeName(String name) {
    return '@$name 찾기';
  }

  @override
  String get searchFindCubeNameHint => 'Cube ID에서 찾아 추가';

  @override
  String get addContactHintName => '카드를 붙여넣거나 @이름 입력';

  @override
  String get strangerReachTitle => '인터넷으로 나에게 메시지를 보낼 수 있는 사람';

  @override
  String get strangerReachAll => '모두';

  @override
  String get strangerReachRequest => '요청 시';

  @override
  String get strangerReachNone => '아무도 없음';

  @override
  String get strangerReachHint =>
      '내가 메시지를 보낸 적 없는 사람이 인터넷으로 연락할 때 적용됩니다. Bluetooth로 연결된 주변 사람에게는 영향이 없습니다.';

  @override
  String get sectionPrivacy => '개인정보 및 보안';

  @override
  String get sectionNotifications => '알림 및 통화';

  @override
  String get sectionConnection => '연결';

  @override
  String get sectionChats => '채팅 및 미디어';

  @override
  String get sectionAppearance => '모양';

  @override
  String get sectionData => '데이터 및 저장 공간';

  @override
  String get sectionAbout => '정보';

  @override
  String get subWhoSeesMe => '나를 볼 수 있는 사람';

  @override
  String get subProtection => '보호';

  @override
  String get subNotifications => '알림';

  @override
  String get subCalls => '통화';

  @override
  String get profileDiscoverableMeshOff =>
      'Bluetooth 메시가 꺼져 있습니다 — ‘연결’에서 켜세요.';

  @override
  String get chatRouteBluetoothDirect => 'Bluetooth 직접';

  @override
  String chatRouteMeshHops(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '메시 · $n홉',
    );
    return '$_temp0';
  }

  @override
  String chatRouteDeliveredVia(String route) {
    return '전달됨: $route';
  }

  @override
  String chatRouteReceivedVia(String route) {
    return '수신됨: $route';
  }

  @override
  String get chatUnreadDivider => '새 메시지';

  @override
  String get radioTitle => '무전기';

  @override
  String get radioNearbySubtitle => '버튼을 누른 채 그룹이나 연락처와 대화하세요';

  @override
  String get radioGroupsLabel => '그룹';

  @override
  String get radioDirectLabel => '개인';

  @override
  String get radioAddGroup => '무전 채널 추가';

  @override
  String get radioNoGroups =>
      '아직 무전 채널이 없습니다. 추가해 보세요. 같은 이름과 비밀번호를 입력한 사람은 모두 서로의 목소리를 들을 수 있습니다.';

  @override
  String get radioLeave => '이 무전 채널 나가기';

  @override
  String get radioPickChannel => '그룹이나 연락처 선택';

  @override
  String get radioPushToTalk => '눌러서 말하기';

  @override
  String get radioTalking => '말하는 중…';

  @override
  String get radioChannelBusy => '채널 사용 중';

  @override
  String radioSpeaker(String name) {
    return '$name님이 말하는 중';
  }

  @override
  String get radioSilentTitle => '무음 모드에서도 재생';

  @override
  String get radioSilentHint => '휴대폰이 무음 모드일 때도 음성이 재생됩니다.';

  @override
  String get radioJoinNameLabel => '이름';

  @override
  String get radioJoinPasswordLabel => '비밀번호 (선택)';

  @override
  String get radioJoinHint =>
      '같은 이름과 비밀번호를 입력한 사람은 모두 같은 무전 채널에 들어옵니다. 목록을 보관하는 서버는 없습니다.';

  @override
  String get radioJoinNameRequired => '이름을 입력하세요';

  @override
  String get radioJoinSubmit => '추가';

  @override
  String get radioBlockedTooLong => '1분 동안 말해서 끊겼습니다';

  @override
  String get radioBlockedCall => '통화 중입니다';

  @override
  String get radioBlockedMicrophone => '마이크에 접근할 수 없습니다';

  @override
  String get radioBlockedUnavailable => '이 기기에서는 무전기를 사용할 수 없습니다';

  @override
  String get radioBlockedNoChannel => '먼저 그룹이나 연락처를 선택하세요';

  @override
  String get radioTurnOff => '무전기 끄기';

  @override
  String get radioPersonalCallsTitle => '개인 호출 받기';

  @override
  String get radioPersonalCallsHint =>
      '무전기가 꺼져 있을 때 연락처가 나에게 말하면 그 사람에게 자동으로 맞춰집니다.';

  @override
  String get radioBackgroundHint => '화면이 꺼져 있으면 백그라운드 모드가 켜져 있을 때만 무전이 들립니다.';

  @override
  String get areaNearby => '주변 채팅';

  @override
  String get areaLevelDistrict => '동네';

  @override
  String get areaLevelCity => '도시';

  @override
  String get areaLevelRegion => '지역';

  @override
  String areaPresentCount(int count) {
    return '여기 ≈$count명';
  }

  @override
  String get areaPresentMany => '여기 50명 이상';

  @override
  String get areaBlockViaBluetooth => '내 블록 — Bluetooth로';

  @override
  String get areaOpenNearbyTab => '‘주변’ 열기';

  @override
  String get areaLocating => '내 동네를 찾는 중…';

  @override
  String get areaNoPlace =>
      '아직 위치가 없습니다. 지역 채팅은 이 화면이 열려 있는 동안 대략적인 위치가 필요합니다.';

  @override
  String get areaLocationDenied =>
      'Cubechat의 위치 접근이 꺼져 있습니다. 내 동네를 보려면 설정에서 대략적인 위치를 허용하세요.';

  @override
  String get areaOffline => '지역 채팅에 연결되지 않음';

  @override
  String get areaEmpty => '지난 24시간 동안 여기에 쓴 사람이 없습니다.';

  @override
  String get areaConsentTitle => '지역 채팅은 공개입니다';

  @override
  String get areaConsentBody =>
      '이곳의 메시지는 공개됩니다. 내 동네나 도시를 여는 누구나 읽을 수 있으며, Cubechat 서버에 24시간 동안 보관됩니다. 몇 시간마다 바뀌는 임시 이름으로 글을 쓰며, 아무도 내 @이름이나 연락처를 볼 수 없습니다. 내 동네를 알기 위해 Cubechat은 이 화면이 열려 있는 동안에만 대략적인 위치를 요청합니다.';

  @override
  String get areaConsentAllow => '계속';

  @override
  String get areaConsentDecline => '나중에';

  @override
  String areaDefaultName(String tag) {
    return '큐브-$tag';
  }

  @override
  String areaYouAre(String name, int hours) {
    return '현재 이름: $name · $hours시간 후 새 이름';
  }

  @override
  String get areaNewName => '새 이름';

  @override
  String get areaSetName => '이름 정하기';

  @override
  String get areaNameHint => '이 이름이 유지되는 몇 시간 동안만 적용됩니다. 비워 두면 자동 이름을 씁니다.';

  @override
  String get areaNameSameWarning => '같은 이름을 쓰면 여러 동네에서 동일인임이 드러납니다';

  @override
  String get areaShowPresence => '여기 있음 표시';

  @override
  String get areaPresenceOffHint => '근처에 몇 명이 있는지 보려면 ‘여기 있음 표시’를 켜세요';

  @override
  String get areaReadOnly => '현재 있는 곳에서만 글을 쓸 수 있습니다';

  @override
  String get areaComposerHint => '여기 있는 모두에게 메시지';

  @override
  String get areaSend => '보내기';

  @override
  String get areaWaitALittle => '잠시 기다리세요';

  @override
  String areaFlood(int count) {
    return '도배 ($count) · 보기';
  }

  @override
  String get areaReply => '답장';

  @override
  String get areaHide => '숨기기';

  @override
  String get areaBlock => '이름이 바뀔 때까지 차단';

  @override
  String get areaBlocked => '이름이 바뀔 때까지 차단됨';

  @override
  String get areaReport => '신고';

  @override
  String get areaOpenLink => '링크 열기';

  @override
  String areaOpenLinkConfirm(String url) {
    return '$url을(를) 열까요?';
  }

  @override
  String get areaOpen => '열기';

  @override
  String get areaReadHere => '여기서 읽기';

  @override
  String get areaReadHereHint =>
      '읽기만 가능합니다. 글은 현재 있는 곳에서만 쓸 수 있으며, 릴레이는 내가 어느 장소를 읽는지 알게 됩니다.';

  @override
  String get areaNotes => '쪽지';

  @override
  String areaNotesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '쪽지 $count개',
      zero: '쪽지 없음',
    );
    return '$_temp0';
  }

  @override
  String get areaLeaveNote => '쪽지 남기기';

  @override
  String get areaNoteHint => '우리 도시에 남길 짧은 쪽지';

  @override
  String get areaNoteLifetime => '유지 기간';

  @override
  String get areaNote1h => '1시간';

  @override
  String get areaNote24h => '24시간';

  @override
  String get areaNote7d => '7일';

  @override
  String get areaPinToDistrict => '동네에 고정';

  @override
  String get areaPinHint => '내 도시 안의 지도를 탭하세요. 핀이 해당 동네에 맞춰집니다.';

  @override
  String get areaPinOutside => '내 도시 안에서만 가능';

  @override
  String get areaNoteDelete => '내 쪽지 삭제';

  @override
  String get areaNoNotes => '아직 쪽지가 없습니다';

  @override
  String get areaNotesLimit => '하루에 쪽지 3개';

  @override
  String get areaNoteLeft => '쪽지를 남겼습니다';

  @override
  String get areaNoteSend => '남기기';

  @override
  String get areaOwnNote => '내 쪽지';

  @override
  String get areaNotePinned => '동네에 고정됨';

  @override
  String get areaHidden => '숨김';

  @override
  String get areaPublicBadge => '공개 · 24시간 보관';

  @override
  String get areaSettingTitle => '지역 채팅';

  @override
  String get areaSettingOnHint =>
      '지도의 주변 채팅 버튼: 임시 이름으로 참여하는 내 동네와 도시의 공개 채팅입니다.';

  @override
  String get areaSettingOffHint => '끄면 지도에 버튼이 없고, 지역 채팅은 위치를 요청하거나 연결하지 않습니다.';

  @override
  String get wallpaperPhotoLocalOnly => '사진 배경화면은 아직 이 기기에서만 적용됩니다';

  @override
  String get wallpaperSavedNoRoute => '여기에 저장했습니다. 지금은 상대방까지 경로가 없습니다';

  @override
  String get wallpaperScopeTitle => '이 배경화면을 누가 볼까요?';

  @override
  String get wallpaperScopeChannel => '채널 전체';

  @override
  String get wallpaperScopeBoth => '나와 상대방';

  @override
  String get wallpaperScopeLocal => '나만';

  @override
  String get wallpaperScopeSharedHint => '암호화된 제어 패킷으로 전송됩니다';

  @override
  String get wallpaperScopePhotoHint => '사진은 당분간 이 휴대폰에만 남습니다';

  @override
  String get foldersCreate => '폴더 만들기';

  @override
  String get foldersYours => '내 폴더';

  @override
  String get foldersSmartFilters => '스마트 필터';

  @override
  String get foldersName => '폴더 이름';

  @override
  String get foldersSave => '저장';

  @override
  String get foldersDeleteTitle => '폴더를 삭제할까요?';

  @override
  String get foldersDelete => '삭제';

  @override
  String get foldersCreateAction => '만들기';

  @override
  String get chatsArchiveHiddenToast => '보관함을 숨겼습니다. \'모양\'에서 다시 표시할 수 있습니다.';

  @override
  String get chatsBulkPin => '고정';

  @override
  String get chatsBulkMute => '무음';

  @override
  String get chatsUnarchive => '보관 해제';

  @override
  String get chatsAddToFolder => '폴더에 추가';

  @override
  String get chatsMarkUnread => '읽지 않음으로 표시';

  @override
  String get chatsClearHistory => '채팅 기록 지우기';

  @override
  String get foldersNew => '새 폴더';

  @override
  String get foldersNameHint => '친구';

  @override
  String get chatsNoIncoming => '받은 메시지가 없습니다';

  @override
  String get chatsMarkedUnread => '읽지 않음으로 표시했습니다';

  @override
  String get chatsClearHistoryTitle => '채팅 기록을 지울까요?';

  @override
  String get chatsClearHistoryBody =>
      '메시지는 이 기기에서만 삭제됩니다. 채팅, 연락처, 즐겨찾기는 그대로 남습니다.';

  @override
  String get chatsClearHistoryAction => '지우기';

  @override
  String get chatsHistoryCleared => '기록을 지웠습니다';

  @override
  String get savedTagMenuTag => '태그';

  @override
  String get savedTagRemove => '태그 삭제';

  @override
  String get customizeArchiveRowTitle => '보관함 행';

  @override
  String get customizeArchiveRowHint => '채팅 목록 위에 표시합니다. 보관된 채팅도 메시지는 계속 받습니다.';

  @override
  String get mapLayerStandard => '표준';

  @override
  String get mapLayerStandardHint => '밝은 거리 지도 — 가장 안정적인 기본값';
}
