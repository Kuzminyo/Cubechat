// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get callVoice => '音声通話';

  @override
  String get callVideo => 'ビデオ通話';

  @override
  String get callIncomingVideo => 'ビデオ通話の着信';

  @override
  String get callCamera => 'カメラ';

  @override
  String get callFlipCamera => '切替';

  @override
  String get contactProfileVideo => 'ビデオ';

  @override
  String get callPreparing => 'マイクを準備中…';

  @override
  String get callDialing => '発信中…';

  @override
  String get callRinging => '呼び出し中…';

  @override
  String get callConnecting => '接続中…';

  @override
  String get callMicrophoneRequired => '通話するには、システム設定でマイクへのアクセスを許可してください。';

  @override
  String get callMicrophoneWindows =>
      'Windows が CubeChat にマイクの使用を許可していません。設定 → プライバシーとセキュリティ → マイク →「デスクトップ アプリがマイクにアクセスできるようにする」をオンにしてください。';

  @override
  String get callElsewhere => 'このアカウントの別の端末で通話中です。';

  @override
  String get callRelayUnavailable => '通話サーバーに接続できません。しばらくしてからもう一度お試しください。';

  @override
  String get callBusy => '話し中';

  @override
  String get callNoAnswer => '応答なし';

  @override
  String get callFailed => '通話を接続できませんでした';

  @override
  String get callDeclined => '通話が拒否されました';

  @override
  String get callEnded => '通話終了';

  @override
  String get callMicrophone => 'マイク';

  @override
  String get callSpeaker => 'スピーカー';

  @override
  String get callAnswer => '応答';

  @override
  String get callDecline => '拒否';

  @override
  String get callEnd => '終了';

  @override
  String get callClose => '閉じる';

  @override
  String get callMinimize => '最小化';

  @override
  String get callAudioOutput => '通話の音声';

  @override
  String get callRoutePhone => '電話';

  @override
  String get callRouteBluetooth => 'Bluetooth';

  @override
  String get callRouteHeadphones => 'ヘッドフォン';

  @override
  String get callFullScreenTitle => 'ロック画面での着信';

  @override
  String get callFullScreenBody => 'ロック画面に着信を表示して、ロックを解除せずに応答できるようにします。';

  @override
  String get callFullScreenXiaomi =>
      'Xiaomi、Redmi、Poco ではアプリが自分でこの設定をオンにできません。「その他の権限」で「ロック画面に表示」をオンにしてください。';

  @override
  String get circleMessage => 'ビデオメッセージ';

  @override
  String get appName => 'Cubechat';

  @override
  String get navChats => 'チャット';

  @override
  String get navPeers => '近く';

  @override
  String get navProfile => 'プロフィール';

  @override
  String get navContacts => '連絡先';

  @override
  String get navMap => 'マップ';

  @override
  String get mapTitle => 'マップ';

  @override
  String get mapFriendsTitle => 'マップ上の人';

  @override
  String get mapFriendsHint => 'あなたの位置はこの連絡先にだけ届きます';

  @override
  String mapClusterTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'ここに$count人',
    );
    return '$_temp0';
  }

  @override
  String get mapClusterHint => 'タップするとその人の位置へマップを移動します';

  @override
  String get mapNorthUp => '北を上にする';

  @override
  String get mapLayerTitle => 'マップの種類';

  @override
  String get mapLayerHint => 'ピンを表示する背景';

  @override
  String get mapLayerDark => 'ダーク';

  @override
  String get mapLayerDarkHint => 'ラベルなしの道路 — ピンが一番見やすい背景';

  @override
  String get mapLayerSatellite => '航空写真';

  @override
  String get mapLayerSatelliteHint => '上空からの写真：どの建物か、どの庭か';

  @override
  String get mapLayerTerrain => '地形';

  @override
  String get mapLayerTerrainHint => '等高線と起伏 — 丘や山道に';

  @override
  String get mapFriendsEmpty => 'まだ誰もあなたとマップを共有していません。';

  @override
  String get mapFriendsEmptyHint => '連絡先を招待すると、承諾後にここに表示されます。';

  @override
  String get mapFriendsInvite => '招待';

  @override
  String get mapFriendsRemove => 'マップから削除';

  @override
  String mapFriendsRemoved(String name) {
    return '$nameさんはマップの共有をやめました';
  }

  @override
  String get mapFriendsLive => '現在マップに表示中';

  @override
  String get mapFriendsIdle => '現在の位置情報なし';

  @override
  String get mapInviteTitle => 'マップに招待';

  @override
  String get mapInviteHint => 'チャットを1つ以上選択してください';

  @override
  String get mapInviteEmpty => '招待できるチャットがまだありません。';

  @override
  String mapInviteAction(int count) {
    return '送信（$count）';
  }

  @override
  String get mapInviteMessage =>
      'Cubechat マップへの招待です。このチャットで位置情報を送ると、マップに表示されます。';

  @override
  String mapInviteSent(int count) {
    return '招待を送信しました：$count件';
  }

  @override
  String get mapInviteFailed => '招待を送信できませんでした';

  @override
  String mapPeopleVisible(int count) {
    return '共有中の位置情報：$count件';
  }

  @override
  String get mapCenterMe => '現在地を中心に';

  @override
  String get mapNoSharedLocations => '共有された位置情報はまだありません';

  @override
  String get mapNoSharedLocationsHint => '連絡先がチャットで位置情報を送ると、ここに表示されます。';

  @override
  String get mapWebHintTitle => '近くのつながり';

  @override
  String get mapWebHint => '線は距離の近さを表し、メッセージの経路ではありません。';

  @override
  String get mapOpenProfile => 'プロフィール';

  @override
  String get mapLocationPrivacyOff => 'マップ上の位置は非表示です';

  @override
  String get mapLocationPrivacyOffHint =>
      '自分のピンを表示するには、「プライバシー」で「マップに自分を表示」をオンにしてください。';

  @override
  String get mapYouOnMap => 'あなたの位置はこの端末に表示されています';

  @override
  String get locationSharingDisabled => '先に「プライバシー」で「マップに自分を表示」をオンにしてください。';

  @override
  String get mapLocationDenied => '位置情報へのアクセスがオフです';

  @override
  String get mapLocationServiceOff => '自分を表示するには位置情報サービスをオンにしてください';

  @override
  String get mapLocationUnavailable => '現在地を特定できませんでした';

  @override
  String get mapDistanceUnknown => '距離不明';

  @override
  String mapDistanceMetres(int metres) {
    return '$metres m 先';
  }

  @override
  String mapDistanceKilometres(String kilometres) {
    return '$kilometres km 先';
  }

  @override
  String get mapUpdatedNow => 'たった今共有';

  @override
  String mapUpdatedMinutes(int minutes) {
    return '$minutes分前に共有';
  }

  @override
  String mapUpdatedHours(int hours) {
    return '$hours時間前に共有';
  }

  @override
  String get contactsTitle => '連絡先';

  @override
  String get contactsSubtitle => 'メッセージをやり取りしたすべての人';

  @override
  String get contactsSearchHint => '連絡先を検索…';

  @override
  String get contactsEmptyTitle => '連絡先はまだありません';

  @override
  String get contactsEmptyHint => '会話を始めると、相手がここに表示されます。';

  @override
  String get contactsSearchEmpty => '一致する連絡先はありません';

  @override
  String get contactsTabContacts => '連絡先';

  @override
  String get contactsTabCalls => '通話';

  @override
  String get callsFilterAll => 'すべて';

  @override
  String get callsFilterMissed => '不在着信';

  @override
  String get callsEmptyTitle => '通話履歴はまだありません';

  @override
  String get callsEmptyHint => '着信・発信・不在着信がここに表示されます。';

  @override
  String get callsMissedEmpty => '不在着信はありません';

  @override
  String get callsCallBack => '発信';

  @override
  String get contactProfileChat => 'チャット';

  @override
  String get contactProfileCall => '通話';

  @override
  String get contactProfileRadio => '無線';

  @override
  String get contactProfileSecurity => 'セキュリティ';

  @override
  String get contactProfileActions => '連絡先の操作';

  @override
  String get contactProfileVerify => '検証';

  @override
  String get contactProfileCopyId => '連絡先IDをコピー';

  @override
  String get contactProfileIdCopied => '連絡先IDをコピーしました';

  @override
  String get contactProfileId => '連絡先ID';

  @override
  String get contactProfileVerifyHint => '暗号化のフィンガープリントを照合して、本人であることを確認してください。';

  @override
  String get chatsTitle => 'チャット';

  @override
  String get chatsSubtitle => 'メッシュ · エンドツーエンド暗号化';

  @override
  String get chatsEmptyTitle => '会話はまだありません';

  @override
  String get chatsEmptyHint => '「近く」タブで相手を開いて、チャットを始めましょう。';

  @override
  String get chatsFilterAll => 'すべて';

  @override
  String get chatsFilterUnread => '未読';

  @override
  String get chatsFilterMesh => 'メッシュ';

  @override
  String get chatsFilterFavorites => 'お気に入り';

  @override
  String get chatsFolderDirect => '個人';

  @override
  String get chatsFolderChannels => 'チャンネル';

  @override
  String get chatsFolderOnline => '接続可能';

  @override
  String get chatsFoldersTitle => 'フォルダ';

  @override
  String get chatsFoldersHint =>
      'フォルダはこのリストの絞り込みで、チャットの移動先ではありません。チャットの上に表示したいものをオンにしてください。';

  @override
  String get chatsSearchHint => 'チャットを検索…';

  @override
  String get chatsStatusViaMesh => 'メッシュ経由';

  @override
  String get chatsStatusOffline => 'オフライン';

  @override
  String get peerKeyRotated => '鍵が変更されました — 再検証してください';

  @override
  String get peersTitle => '近く';

  @override
  String get peersSubtitle => 'Bluetooth の範囲内の端末';

  @override
  String get peersEmpty => '相手を探しています…';

  @override
  String peersHopsOne(int n) {
    return '$nホップ先';
  }

  @override
  String peersHopsOther(int n) {
    return '$nホップ先';
  }

  @override
  String get blePermissionTitle => 'Bluetooth の許可が必要です';

  @override
  String get blePermissionHint =>
      'Cubechat は Bluetooth を使って相手を見つけ、メッセージを送ります。インターネットは不要です。';

  @override
  String get blePermissionGrant => '許可する';

  @override
  String get blePermissionOpenSettings => '設定を開く';

  @override
  String get blePermissionDeniedHint =>
      '許可されませんでした。設定を開いて Bluetooth へのアクセスを許可してください。';

  @override
  String get bleAdapterOffTitle => 'Bluetooth がオフです';

  @override
  String get bleAdapterOffHint => '近くの相手を表示するには Bluetooth をオンにしてください。';

  @override
  String get bleUnsupportedTitle => 'Bluetooth LE を利用できません';

  @override
  String get bleUnsupportedHint =>
      'この端末またはプラットフォームは Bluetooth Low Energy に対応していません。スマートフォンでお試しください。';

  @override
  String get bleScanning => 'スキャン中…';

  @override
  String get bleRetry => '再試行';

  @override
  String get bleEnable => 'オンにする';

  @override
  String get bleConnectFailed =>
      '接続できませんでした。相手が範囲外にいるか、Bluetooth アドレスが変わった可能性があります。';

  @override
  String get bleSignal => '信号';

  @override
  String get bleConnect => '接続';

  @override
  String get bleConnected => '接続済み';

  @override
  String get bleVerified => '検証済み';

  @override
  String get editorAdjustBrightness => '明るさ';

  @override
  String get editorAdjustContrast => 'コントラスト';

  @override
  String get editorAdjustSaturation => '彩度';

  @override
  String get editorToolCrop => '切り抜き';

  @override
  String get editorToolDraw => '描画';

  @override
  String get editorToolAdjust => '調整';

  @override
  String get editorTabSticker => 'スタンプ';

  @override
  String get editorTabText => 'テキスト';

  @override
  String get editorPenPen => 'ペン';

  @override
  String get editorPenMarker => 'マーカー';

  @override
  String get editorPenNeon => 'ネオン';

  @override
  String get editorPenArrow => '矢印';

  @override
  String get editorPenBlur => 'ぼかし';

  @override
  String get editorPenEraser => '消しゴム';

  @override
  String get editorLevel => '水平';

  @override
  String get editorTextHint => '写真に文字を入力';

  @override
  String get editorCropFree => '自由';

  @override
  String get editorRemove => '削除';

  @override
  String get notificationUnknownSender => '新しいメッセージ';

  @override
  String get bleUnknownPeer => '不明な相手';

  @override
  String get bleBroadcasting => '発信中';

  @override
  String bleConnectedCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n台のセントラルと接続中',
      one: '$n台のセントラルと接続中',
      zero: 'セントラル：なし',
    );
    return '$_temp0';
  }

  @override
  String get verifyTitle => '相手を検証';

  @override
  String get verifyIntro =>
      'この2つのフィンガープリントを、相手と直接会うか音声通話で照合してください。双方で一致すれば、Noise ハンドシェイクが改ざんされていないことを確認できます。';

  @override
  String get verifyMine => 'あなたのフィンガープリント';

  @override
  String verifyTheirs(String name) {
    return '$nameさんのフィンガープリント';
  }

  @override
  String get verifyMarkAsVerified => '検証済みにする';

  @override
  String get verifyAlreadyDone => 'この相手は検証済みです。';

  @override
  String get verifyRevoke => '取り消す';

  @override
  String verifyDoneSnack(String name) {
    return '$nameさんを検証済みにしました';
  }

  @override
  String get chatInputHint => 'メッセージ';

  @override
  String get chatSend => '送信';

  @override
  String get chatToday => '今日';

  @override
  String get chatYesterday => '昨日';

  @override
  String get chatDelivered => '配信済み';

  @override
  String get chatRead => '既読';

  @override
  String get chatSending => '送信中';

  @override
  String get chatWaitingForConnection => '接続を待っています';

  @override
  String sendQueueCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count件のメッセージが接続待ち',
      one: '$count件のメッセージが接続待ち',
    );
    return '$_temp0';
  }

  @override
  String sendQueueSlowNetwork(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'ネットワークが低速 — $count件を送信中',
      one: 'ネットワークが低速 — 1件を送信中',
    );
    return '$_temp0';
  }

  @override
  String get sendQueueTitle => '送信待ち';

  @override
  String get sendQueueHint =>
      '近くの Bluetooth かインターネットなど、経路ができ次第自動で送信されます。操作は不要です。';

  @override
  String get sendQueueRetry => '今すぐ送信';

  @override
  String get sendQueueCancel => '送信を取り消す';

  @override
  String get sendQueueCancelled => '未送信 — 取り消しました';

  @override
  String get sendQueueTooLate => '取り消せません：すでに送信されました';

  @override
  String get chatEncryptedNotice => 'メッセージは Noise Protocol でエンドツーエンド暗号化されています。';

  @override
  String get chatSessionHandshaking => '安全な接続を確立中…';

  @override
  String get chatSessionEstablished => '保護済み · Noise XX';

  @override
  String get chatSessionFailed => '接続に失敗しました';

  @override
  String get presenceOnline => 'オンライン';

  @override
  String get presenceOffline => 'オフライン';

  @override
  String get chatSessionFingerprintPending => 'ハンドシェイクが完了するとフィンガープリントが表示されます。';

  @override
  String get chatEmptyEstablished => '安全な接続が確立されました。メッセージを送って会話を始めましょう。';

  @override
  String get chatEmptyHandshaking => '相手がハンドシェイクを完了するのを待っています…';

  @override
  String get chatEmptyTitle => 'まだメッセージはありません';

  @override
  String get chatEmptyGreetHint => 'メッセージを送るか、Kubi をタップしてあいさつしましょう。';

  @override
  String get profileTitle => 'プロフィール';

  @override
  String get profileNickname => 'ニックネーム';

  @override
  String get profileNicknameEditTitle => 'ニックネームを設定';

  @override
  String get profileNicknameHint => 'メッシュ上でほかの人に表示される名前';

  @override
  String get profileNicknameSave => '保存';

  @override
  String get profileFingerprint => '公開鍵のフィンガープリント';

  @override
  String get profileLanguage => '言語';

  @override
  String get profileLanguageEn => '英語';

  @override
  String get profileLanguageUk => 'ウクライナ語';

  @override
  String get profileTransport => '通信方式';

  @override
  String get profileTransportMesh => 'Bluetooth メッシュ';

  @override
  String get profileBackground => 'バックグラウンドで受信';

  @override
  String get profileBackgroundSubtitle => 'アプリを閉じていてもメッセージを受信します';

  @override
  String get profileBatteryExempt => 'バッテリーの最適化をオフ';

  @override
  String get profileAbout => 'アプリについて';

  @override
  String profileVersion(String v) {
    return 'バージョン $v';
  }

  @override
  String get rotateKeysTitle => 'アカウントの鍵を変更';

  @override
  String get rotateKeysHint => 'アカウントのある端末を紛失したり盗まれたりした場合';

  @override
  String get rotateKeysConfirmTitle => 'アカウントの鍵を変更しますか？';

  @override
  String get rotateKeysConfirmBody =>
      '連絡先には新しい鍵が届き、チャットはそのまま残りますが、全員にあなたの鍵の再確認が求められます。このアカウントのほかの端末はすべてログアウトされます。引き続き使う端末は、このスマートフォンから再度リンクしてください。古いバージョンの CubeChat を使っている連絡先は、アップデートするまであなたに連絡できません。チャンネルの鍵は変わりません。';

  @override
  String get rotateKeysConfirmAction => '鍵を変更';

  @override
  String get rotateKeysWorking => '鍵を変更中…';

  @override
  String rotateKeysDone(int sent, int total) {
    return '新しい鍵になりました。$total人中$sent人の連絡先に通知済み';
  }

  @override
  String get rotateKeysSlow => '新しい鍵になりました。時間内に確認できなかった連絡先の分は、リレーが保管します';

  @override
  String get profileEmergencyWipe => '緊急消去';

  @override
  String get profileEmergencyWipeConfirm => 'すべて消去しますか？';

  @override
  String get profileEmergencyWipeConfirmHint =>
      'あなたの ID、連絡先リスト、会話履歴が削除されます。元に戻すことはできません。';

  @override
  String get profileEmergencyWipeAction => '消去';

  @override
  String get cancel => 'キャンセル';

  @override
  String get copy => 'コピー';

  @override
  String get copied => 'コピーしました';

  @override
  String get channelsNewTitle => '新しいチャンネル';

  @override
  String get channelsNewTooltip => '新しいチャンネル';

  @override
  String get channelNameLabel => 'チャンネル名';

  @override
  String get channelPasswordLabel => 'パスワード（任意）';

  @override
  String get channelJoinAction => '参加';

  @override
  String get channelNameHint =>
      '同じ名前とパスワードを入力した人は、同じルームに入ります。参加者のリストを持つサーバーはありません。';

  @override
  String get channelPasswordHint =>
      'パスワードがそのまま鍵になります。パスワードがなければ、名前を知っている近くの誰でもルームに入れます。';

  @override
  String get channelSubtitle => 'グループチャンネル · 共有鍵';

  @override
  String get channelMute => '通知オフ';

  @override
  String get channelUnmute => '通知オン';

  @override
  String channelMutedUntil(String time) {
    return '$timeまで通知オフ';
  }

  @override
  String get channelMuteFor => '通知オフの期間…';

  @override
  String channelMuteMinutes(int minutes) {
    return '$minutes分';
  }

  @override
  String channelMuteHours(int hours) {
    return '$hours時間';
  }

  @override
  String channelMuteDays(int days) {
    return '$days日';
  }

  @override
  String get channelMuteForever => '自分でオンにするまで';

  @override
  String get channelCommunity => 'コメント';

  @override
  String get channelCommunityOpen => 'ディスカッションを開く';

  @override
  String channelCommunitySubtitle(String channel) {
    return '$channelのディスカッション';
  }

  @override
  String get channelBackToChannel => 'チャンネルに戻る';

  @override
  String get channelMemberActions => 'メンバー';

  @override
  String get channelRemoveMember => 'チャンネルから削除';

  @override
  String get channelRemoveMemberHint =>
      'この人の投稿はここで受け付けられなくなります。ただし名前で再参加することは防げません。共有鍵がメンバーシップのすべてだからです。';

  @override
  String get channelMuteMember => '投稿を制限…';

  @override
  String get channelUnmuteMember => '投稿を再び許可';

  @override
  String channelMemberRemoved(String name) {
    return '$nameさんを削除しました';
  }

  @override
  String channelMemberMuted(String name) {
    return '$nameさんの投稿を制限しました';
  }

  @override
  String channelMemberCleared(String name) {
    return '$nameさんは再び投稿できます';
  }

  @override
  String get channelMemberMutedNote => '投稿制限中';

  @override
  String get channelShareHistory => '履歴を共有';

  @override
  String get channelShareHistoryHint =>
      'このルームの最近の投稿をもう一度配信し、あとから参加した人にも見えるようにします。もともといた人には何も新しく届きません。';

  @override
  String channelHistoryShared(int count) {
    return '$count件の投稿を配信しました';
  }

  @override
  String get channelHistoryNothing => '共有するものはまだありません';

  @override
  String get channelHistoryAuto => '新メンバーに履歴を渡す';

  @override
  String get channelHistoryAutoHint =>
      'ルームに新しい人が現れると、最近の投稿が自動でその人に送られます。今はテキストのみです。写真は分割ストリームで送られるため、全員に重複させずに再送することはできません。';

  @override
  String get channelPostComments => 'コメント';

  @override
  String get channelNoComments => 'この投稿へのコメントはまだありません';

  @override
  String get channelCommentHint => 'コメント';

  @override
  String get channelMuteCustom => '期間は？';

  @override
  String get channelMuteCustomHint => '時間';

  @override
  String get chatPinnedManage => 'ピン留め';

  @override
  String get chatPeekOpen => 'チャットを開く';

  @override
  String get chatPeekPin => 'ピン留め';

  @override
  String get chatPeekUnpin => 'ピン留めを解除';

  @override
  String get chatPeekUnmute => '通知オン';

  @override
  String get chatPeekMarkRead => '既読にする';

  @override
  String get chatDeleteForMeHint => 'このスマートフォンから削除され、ピン留めも解除されます。相手側のコピーは残ります。';

  @override
  String get pushWakeTitle => 'このスマートフォンを起こす';

  @override
  String get pushWakeHint =>
      '小さなサーバーがリレー上のあなたのアドレスを見張り、何か届いたらこのスマートフォンに知らせます。アプリを閉じていても通知が届くようになります。サーバーがメッセージや鍵を見ることはなく、わかるのはあなたのアドレスに何かが届いたこととその時刻だけです。リレーはすでにそれを知っていますが、これで知っている場所がもう1つ増えます。';

  @override
  String get pushWakeDeniedTitle => '通知がオフになっています';

  @override
  String get pushWakeDeniedHint =>
      'システムで一度拒否されたため、再度確認されることはありません。設定 → cubechat → 通知 からのみオンにできます。その後、ここに戻ってください。';

  @override
  String get pushWakeRefused => '通知が許可されませんでした';

  @override
  String get privacyForwardLinkTitle => '転送からプロフィールへのリンク';

  @override
  String get privacyForwardLinkHint =>
      '誰かがあなたのメッセージを転送したとき、その上の行からあなたのプロフィールを開けるようにします。オフにすると、名前だけが表示され、タップできません。これは相手のアプリへのお願いであり、このアプリが強制できるものではありません。';

  @override
  String get privacyShareSheetTitle => '共有シートのチャット';

  @override
  String get privacyShareSheetOnHint =>
      '最近の4つのチャットの名前を Android に渡し、どのアプリからでも送れるようにします。アプリロックではこれらは隠れません。';

  @override
  String get privacyShareSheetOffHint =>
      'Android には何も渡しません。CubeChat に共有するときはチャットを選んでください。';

  @override
  String get privacyCallsTitle => '通話を受ける';

  @override
  String get privacyCallsOnHint =>
      '連絡先から着信を受けられます。特定の人を拒否するには、その人のプロフィールを開いてください。';

  @override
  String get privacyCallsOffHint =>
      'プロフィールで許可した人以外は誰も通話をかけられません。拒否された通話は相手に「話し中」と表示されます。';

  @override
  String get chatsStatusChannel => 'チャンネル';

  @override
  String get channelInviteTitle => 'メンバーを追加';

  @override
  String get channelInviteAction => '招待';

  @override
  String get channelInviteEmpty => '知っている相手がまだいません。まず「近く」タブで誰かと出会ってください。';

  @override
  String get channelInviteSent => '招待を送信しました';

  @override
  String get channelInviteNoneSent => '現在誰にも届けられませんでした';

  @override
  String get channelNameTooLong => 'チャンネル名が長すぎます';

  @override
  String get chatsActionFavorite => 'お気に入りに追加';

  @override
  String get chatsActionUnfavorite => 'お気に入りから削除';

  @override
  String get chatsActionDelete => 'チャットを削除';

  @override
  String get chatsDeleteTitle => 'このチャットを削除しますか？';

  @override
  String chatsDeleteManyHint(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count件の会話を消去します。連絡先は残るので、コードを交換し直さなくても再びメッセージを送れます。',
    );
    return '$_temp0';
  }

  @override
  String get chatsDeletedToast => 'チャットを削除しました。';

  @override
  String chatsDeletedManyToast(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count件のチャットを削除しました。',
    );
    return '$_temp0';
  }

  @override
  String get undo => '元に戻す';

  @override
  String get chatsDeletePeerHint =>
      '会話を消去します。連絡先は残るので、コードを交換し直さなくても再びメッセージを送れます。';

  @override
  String get chatsDeleteChannelHint => 'チャンネルを退出し、履歴を削除します。再参加するには鍵が必要です。';

  @override
  String get chatsDeleteForThemToo => '相手側でも削除';

  @override
  String get chatsDeleteForThemHint =>
      '相手のアプリにも、相手が書いた分を含めて会話全体を消去するよう依頼します。チャンネルでは自分のメッセージだけが取り消されます。';

  @override
  String get chatEditAction => '編集';

  @override
  String get chatEditTitle => 'メッセージを編集';

  @override
  String get chatEditSave => '保存';

  @override
  String get chatEdited => '編集済み';

  @override
  String get chatDeleteAction => '削除';

  @override
  String get chatDeleteTitle => 'メッセージを削除しますか？';

  @override
  String get chatDeleteForMe => '自分のみ削除';

  @override
  String get chatDeleteForEveryone => '全員から削除';

  @override
  String get chatPinTitle => 'メッセージをピン留めしますか？';

  @override
  String get chatPinForBoth => '双方でピン留め';

  @override
  String get chatPinForMe => '自分だけピン留め';

  @override
  String get chatReplyAction => '返信';

  @override
  String chatReplyingTo(String name) {
    return '$nameさんに返信';
  }

  @override
  String get chatReplyYou => '自分';

  @override
  String get chatCopyAction => 'コピー';

  @override
  String get chatCopied => 'コピーしました';

  @override
  String get chatForwardAction => '転送';

  @override
  String get chatForwardTitle => '転送先';

  @override
  String get shareIntoTitle => '送信先';

  @override
  String get shareNearbyAirDrop => 'AirDrop で近くに送信';

  @override
  String get shareNearbyAirDropHint => 'インターネット不要 — すぐ近くの人に';

  @override
  String get shareSent => '送信しました';

  @override
  String get shareFailed => '一部を送信できませんでした';

  @override
  String get chatForwardEmpty => 'ほかのチャットはまだありません';

  @override
  String chatForwardSendCount(int count) {
    return '送信（$count）';
  }

  @override
  String chatForwardSentCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count件のチャットに転送しました',
    );
    return '$_temp0';
  }

  @override
  String chatForwardSent(String name) {
    return '$nameに転送しました';
  }

  @override
  String chatSentAt(String time) {
    return '$timeに送信';
  }

  @override
  String chatReadAt(String time) {
    return '$timeに既読';
  }

  @override
  String get chatPinAction => 'ピン留め';

  @override
  String get chatUnpinAction => 'ピン留めを解除';

  @override
  String chatPinnedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'ピン留めされたメッセージ$count件',
      one: 'ピン留めされたメッセージ$count件',
      zero: 'ピン留め：なし',
    );
    return '$_temp0';
  }

  @override
  String get chatNoPins => 'ピン留めされたものはありません';

  @override
  String get chatUnpinAll => 'すべてのピン留めを解除';

  @override
  String get chatShowAllPins => 'ピン留めされたすべてのメッセージ';

  @override
  String get chatUnpinConfirm => 'このメッセージのピン留めを解除しますか？';

  @override
  String get chatUnpinConfirmHint => 'このチャットの全員に対してピン留めが解除されます。';

  @override
  String get chatPinnedTitle => 'ピン留めされたメッセージ';

  @override
  String get chatPinnedGone => 'そのメッセージはこのチャットにもうありません';

  @override
  String get peerBlock => 'ブロック';

  @override
  String get peerUnblock => 'ブロック解除';

  @override
  String get peerMute => '通知オフ';

  @override
  String get peerUnmute => '通知オン';

  @override
  String get peerBlockedNote => 'ブロック中 — メッセージは破棄されます。';

  @override
  String get relaysTitle => 'インターネット経由の予備経路';

  @override
  String get relaysCardTitle => 'インターネット経由で相手に届ける';

  @override
  String get relaysCardSubtitle => 'Bluetooth で届かないときは Nostr リレー経由で送信';

  @override
  String get relaysExplainer =>
      'メッセージはエンドツーエンド暗号化されたままです。リレーが運ぶのは、Bluetooth で送るのと同じ封印されたフレームだけです。ただし、どの2つの鍵がいつやり取りしているかはリレーに知られます。初期設定はオフです。';

  @override
  String get relaysMyAddress => 'あなたのリレーアドレス';

  @override
  String get relaysCopied => 'コピーしました';

  @override
  String get circleLensTitle => '丸型ビデオにフロントカメラ';

  @override
  String get circleLensFrontHint => '丸型ビデオメッセージは自分側のカメラで録画されます。';

  @override
  String get circleLensBackHint => '丸型ビデオメッセージは背面カメラで録画され、見ているものを相手に見せられます。';

  @override
  String get channelCloseTitle => '全員に対してルームを閉じる';

  @override
  String get channelCloseSubtitle => 'すべてのメンバーのスマートフォンから削除します。これはあなただけが実行できます。';

  @override
  String get channelCloseConfirm =>
      'ルーム、そのメッセージ、メンバーが、これを持つすべてのスマートフォンから消えます。誰かが締め出されるわけではありません。鍵は名前から作られるため、名前を覚えている人は空のルームをもう一度開けます。';

  @override
  String get channelCloseAction => 'ルームを閉じる';

  @override
  String get circleHint => '指を離して送信 · 左にスライドでキャンセル';

  @override
  String get circleHintLocked => '終わったら送信をタップ';

  @override
  String get circleNeedsCamera => '丸型ビデオにはカメラとマイクが必要です';

  @override
  String get circleFailed => '丸型ビデオを録画できませんでした';

  @override
  String get relaysListLabel => 'リレー';

  @override
  String get relaysLaneMedia => 'メディア用リレー';

  @override
  String get relaysLaneMediaNote => '写真・ファイル・動画はこちらを通るため、転送中も会話が遅くなりません。';

  @override
  String get relaysLaneLocation => '位置情報用リレー';

  @override
  String get relaysLaneLocationNote => 'マップのビーコンは、ほかとは別にこちらを通ります。';

  @override
  String get relaysAdd => 'リレーを追加';

  @override
  String get relaysAddHint => 'wss://relay.example.com';

  @override
  String get relaysInvalidUrl => 'wss:// または ws:// のアドレスを入力してください';

  @override
  String get relaysRemove => '削除';

  @override
  String get relaysStateConnected => '接続済み';

  @override
  String get relaysStateConnecting => '接続中…';

  @override
  String get relaysStateFailed => '接続不可';

  @override
  String get relaysStateIdle => 'オフ';

  @override
  String get relaysEmpty => 'リレーが設定されていません — 予備経路はオフのままです。';

  @override
  String get contactTitle => '連絡先カード';

  @override
  String get contactMineLabel => 'あなたのカード';

  @override
  String get contactMineExplainer =>
      'Bluetooth の範囲外にいる人に送ってください。カードにはあなたの鍵とリレーアドレスが含まれており、相手はインターネット経由で暗号化チャットを始められます。';

  @override
  String get contactCopy => 'コピー';

  @override
  String get contactShare => '共有';

  @override
  String get contactCopied => 'カードをコピーしました';

  @override
  String get contactShareSubject => '私の cubechat 連絡先カード';

  @override
  String get contactAddLabel => '連絡先を追加';

  @override
  String get contactAddHint => '連絡先カードを貼り付け';

  @override
  String get contactAddAction => '追加';

  @override
  String get contactPaste => '貼り付け';

  @override
  String contactAdded(String name) {
    return '$nameさんを追加しました';
  }

  @override
  String get contactInvalid => '有効な連絡先カードではありません';

  @override
  String get contactOwnCard => 'これはあなた自身のカードです';

  @override
  String get contactUnverified =>
      'この方法で追加した連絡先は未検証の状態です。誰でもカードを作って好きな名前を付けられるため、相手を信頼する前に、直接会うか通話でフィンガープリントを照合してください。';

  @override
  String get contactRelayOff => 'インターネット経由の予備経路がオフのため、カードはまだ誰にも届きません。';

  @override
  String get contactRelayEnable => 'オンにする';

  @override
  String get profileContactCard => '連絡先カード';

  @override
  String get chatsAddContactTooltip => 'カードで連絡先を追加';

  @override
  String get chatsMenuTooltip => 'その他';

  @override
  String get chatsMenuAddContact => '連絡先を追加';

  @override
  String get chatsMenuNewChannel => '新しいチャンネル';

  @override
  String get profileDiscoverable => '近くの人に表示';

  @override
  String get profileDiscoverableOnHint => '範囲内の誰でもあなたを見つけられます';

  @override
  String get profileDiscoverableOffHint => '連絡先だけがあなたに連絡できます';

  @override
  String get profileDiscoverableExplainer =>
      'オンの場合、あなたのアナウンスは暗号化されずに発信されるため、知らない人も近づくだけであなたと知り合えます。その一方で、受信している人には鍵と名前が記録されます。オフの場合、同じ情報は既存の連絡先にだけ封印して送られ、ルーティングIDも互いに関連付けられません。新しい人とつながるには連絡先カードが必要になります。';

  @override
  String get voiceHoldHint => '長押しでボイスメッセージを録音';

  @override
  String get voiceTrimPlay => '再生';

  @override
  String get voiceTrimPause => '一時停止';

  @override
  String get voiceTrimDiscard => '録音を破棄';

  @override
  String voiceTrimSelection(String duration) {
    return '$durationを送信';
  }

  @override
  String get profileLastSeen => '最終オンラインを共有';

  @override
  String get profileLastSeenOnHint => 'アプリを使っている時間が連絡先に表示されます';

  @override
  String get profileLastSeenOffHint =>
      '誰にもあなたの時間は表示されず、あなたにも他人の時間は表示されません。オンラインかどうかだけがわかります';

  @override
  String get profileMapLocation => 'マップに自分を表示';

  @override
  String get profileMapLocationOnHint => '位置情報を手動で共有でき、マップにあなたのピンが表示されます';

  @override
  String get profileMapLocationOffHint => 'アプリは位置情報を要求せず、あなたのピンは非表示になります';

  @override
  String get desktopAutostartTitle => 'Windows と同時に起動';

  @override
  String get desktopAutostartHint =>
      'CubeChat はトレイで待機するため、ウィンドウを閉じていても通話やメッセージがこのコンピューターに届きます';

  @override
  String get trayOpen => 'CubeChat を開く';

  @override
  String get trayQuit => '終了';

  @override
  String get callDirectTitle => '直接通話';

  @override
  String get callDirectOnHint => '速くなりますが、通話相手にあなたの IP アドレスが知られます';

  @override
  String get callDirectOffHint =>
      '通話は私たちのリレーを経由します。相手にはあなたの IP が見えず、リレーも通話を聞くことはできません';

  @override
  String get profileReadReceipts => '既読を共有';

  @override
  String get profileReadReceiptsOnHint => '送信者にあなたが読んだことが表示されます';

  @override
  String get profileReadReceiptsOffHint => 'あなたの既読時刻は送信されませんが、相手の既読は表示されます';

  @override
  String get profilePrivacyExplainer =>
      '最終オンラインは双方向です。自分のステータスを隠すと、ほかの人のステータスも見えなくなります。既読は自分が送る情報だけを制御します。メッセージの配信には影響しません。';

  @override
  String get chatTimerAction => 'タイマー';

  @override
  String get chatTimerRemove => 'タイマーを解除';

  @override
  String get chatTimerTitle => 'このメッセージを削除するまで';

  @override
  String chatTimerSet(String time) {
    return 'このメッセージは$time後に消えます';
  }

  @override
  String get chatTimerLocalHint => 'この端末のみ — 相手のコピーは相手のものです';

  @override
  String get contactTagAction => 'ラベル';

  @override
  String get contactTagRemove => 'ラベルを削除';

  @override
  String get contactTagTitle => 'ラベルを選択';

  @override
  String get contactTagAll => 'すべて';

  @override
  String get quietHoursTitle => 'おやすみ時間';

  @override
  String get quietHoursHint => 'メッセージは届きますが、スマートフォンは鳴りません';

  @override
  String get quietHoursFrom => '開始';

  @override
  String get quietHoursTo => '終了';

  @override
  String get notifPreviewTitle => '通知に表示';

  @override
  String get notifPreviewFull => '名前と本文';

  @override
  String get notifPreviewNameOnly => '名前のみ';

  @override
  String get notifPreviewHidden => '表示しない';

  @override
  String get notifPreviewHint =>
      '通知はロック画面や通知へのアクセス権を持つアプリから見えます。アプリロックがオンでも同様です';

  @override
  String get notifPreviewNewMessage => '新しいメッセージ';

  @override
  String get appLockTitle => 'アプリロック';

  @override
  String get appLockHint => 'アプリを開くときにコードを求める';

  @override
  String get appLockPrompt => 'コードを入力';

  @override
  String get appLockUnlock => 'ロック解除';

  @override
  String get appLockWrong => 'コードが違います';

  @override
  String get appLockSetTitle => 'コードを設定';

  @override
  String get appLockSetHint => '4桁以上の数字。復元する方法はありません。';

  @override
  String get appLockOffTitle => 'ロックをオフにする';

  @override
  String get appLockOffHint => '現在のコードを入力してください';

  @override
  String get appLockOn => 'アプリロックはオンです';

  @override
  String get appLockOff => 'アプリロックはオフです';

  @override
  String get avatarSet => '写真を選択';

  @override
  String get avatarChange => '写真を変更';

  @override
  String get avatarView => '写真を表示';

  @override
  String get profileCoverPhoto => 'プロフィール写真。ダブルタップで拡大';

  @override
  String get profileCoverMenu => '写真のオプション';

  @override
  String get avatarSaved => 'ギャラリーに保存しました';

  @override
  String get avatarRemove => '写真を削除';

  @override
  String get avatarRemoveConfirm => 'アバターはこの端末から削除され、代わりに自動生成のグラデーションが表示されます。';

  @override
  String get avatarFailed => '画像を読み込めませんでした';

  @override
  String get fileOpenHint => 'タップして開く';

  @override
  String get fileMissing => 'このファイルはもう利用できません';

  @override
  String get fileNoHandlerTitle => '開けるアプリがありません';

  @override
  String get fileNoHandlerHint =>
      'このファイル形式に対応したアプリがインストールされていません。代わりにほかのアプリに送ることができます。';

  @override
  String get fileRequestedAgain => '送信者にもう一度依頼しました';

  @override
  String get fileOpenFailed => 'このファイルを開けませんでした';

  @override
  String get fileShareAction => 'アプリに送る';

  @override
  String fileTooLargeMesh(int limit) {
    return 'ファイルが大きすぎます — メッシュ経由の上限は $limit MB です';
  }

  @override
  String fileTooLargeRelay(int limit) {
    return 'インターネット経由の上限は $limit MB です。より大きなファイルを送るには、相手に近づいてください。';
  }

  @override
  String get mediaSendOriginal => 'オリジナル';

  @override
  String get attachFile => 'ファイル';

  @override
  String get attachGallery => 'ギャラリー';

  @override
  String get attachCamera => 'カメラ';

  @override
  String get cameraUnavailable => 'カメラを使用できません';

  @override
  String get profileEditName => '名前';

  @override
  String get profileMyCard => 'カード';

  @override
  String get mediaCaptionHint => 'キャプションを追加…';

  @override
  String get mediaDiscardTitle => '選択を破棄しますか？';

  @override
  String get mediaDiscardMessage => 'ギャラリーを閉じて、選択した写真を破棄しますか？';

  @override
  String get mediaDiscardConfirm => '破棄';

  @override
  String get mediaPhotosAccessOff => '写真へのアクセスがオフです';

  @override
  String get mediaPhotosAccessOffHint =>
      '現在 CubeChat は動画しか表示できません。写真を表示するには、システム設定で写真へのアクセスを許可してください。';

  @override
  String get mediaVideosOnly => '動画のみ表示中 — 写真へのアクセスを許可してください';

  @override
  String get mediaOpenSettings => '設定を開く';

  @override
  String get mediaTakePhoto => '写真を撮る';

  @override
  String get contactProfileAutoDelete => 'チャットの自動削除';

  @override
  String get contactProfileAutoDeleteTitle => 'メッセージの自動削除';

  @override
  String get contactProfileAutoDeleteOff => 'オフ';

  @override
  String get contactProfileAutoDeleteOneDay => '1日後';

  @override
  String get contactProfileAutoDeleteSevenDays => '7日後';

  @override
  String get contactProfileAutoDeleteThirtyDays => '30日後';

  @override
  String contactProfileAutoDeleteUpdated(String period) {
    return '自動削除：$period';
  }

  @override
  String get contactProfileShare => '連絡先を共有';

  @override
  String get contactProfileShareTitle => '連絡先の送信先';

  @override
  String get contactProfileShareEmpty => 'ほかのチャットはまだありません';

  @override
  String contactProfileShareSent(String name) {
    return '$nameに送信しました';
  }

  @override
  String get contactProfileRestrictCopying => 'コピーを禁止';

  @override
  String get contactProfileAllowCopying => 'コピーを許可';

  @override
  String get contactHideAvatar => '自分の写真を隠す';

  @override
  String get contactShowAvatar => '自分の写真を表示';

  @override
  String get contactHideLastSeen => '自分の最終オンラインを隠す';

  @override
  String get contactShowLastSeen => '自分の最終オンラインを表示';

  @override
  String get contactHideReadReceipts => '自分の既読時刻を隠す';

  @override
  String get contactShowReadReceipts => '自分の既読時刻を表示';

  @override
  String get contactHiddenFromThem => 'この連絡先には非表示';

  @override
  String get contactRefuseCalls => 'この人からの通話を受けない';

  @override
  String get contactAllowCalls => 'この人からの通話を受ける';

  @override
  String get contactCallsException => '通話設定の例外';

  @override
  String get contactProfileCopyingRestricted => 'コピーと転送は禁止されています';

  @override
  String get contactProfileCopyingRestrictedByPeer => '相手側で禁止されています';

  @override
  String get contactProfileCopyingAllowed => 'コピーと転送は許可されています';

  @override
  String get contactProfileDelete => '連絡先から削除';

  @override
  String get contactProfileRestore => '連絡先に戻す';

  @override
  String get contactProfileRestoreDone => '連絡先に戻しました';

  @override
  String get contactProfileDeleteTitle => '連絡先を削除しますか？';

  @override
  String contactProfileDeleteMessage(String name) {
    return '$nameさんは連絡先から消えます。チャット履歴はこの端末に残ります。';
  }

  @override
  String get contactProfileMedia => 'メディア';

  @override
  String get contactProfileVoiceMessages => 'ボイスメッセージ';

  @override
  String get contactProfileStickers => 'スタンプ';

  @override
  String get contactProfileNoStickers => 'スタンプはまだありません';

  @override
  String get contactProfileNoMedia => 'メディアはまだありません';

  @override
  String get contactProfileNoVoiceMessages => 'ボイスメッセージはまだありません';

  @override
  String get contactProfileOpen => 'プロフィールを開く';

  @override
  String autoDeleteDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count日',
    );
    return '$_temp0';
  }

  @override
  String autoDeleteHours(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count時間',
    );
    return '$_temp0';
  }

  @override
  String autoDeleteMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count分',
    );
    return '$_temp0';
  }

  @override
  String autoDeleteSeconds(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count秒',
    );
    return '$_temp0';
  }

  @override
  String get autoDeleteCustom => 'カスタム…';

  @override
  String get autoDeleteCustomHint => '数値';

  @override
  String get autoDeleteUnitMinutes => '分';

  @override
  String get autoDeleteUnitHours => '時間';

  @override
  String get autoDeleteUnitDays => '日';

  @override
  String get contactProfileAutoDeleteSet => '設定';

  @override
  String get contactProfileFiles => 'ファイル';

  @override
  String get contactProfileNoFiles => 'ファイルはまだありません';

  @override
  String get contactProfileLinks => 'リンク';

  @override
  String get contactProfileNoLinks => 'リンクはまだありません';

  @override
  String get contactProfilePolls => '投票';

  @override
  String get contactProfileNoPolls => '投票はまだありません';

  @override
  String get presenceRecently => '最終オンライン：最近';

  @override
  String get presenceJustNow => 'たった今';

  @override
  String presenceHoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '最終オンライン：$count時間前',
    );
    return '$_temp0';
  }

  @override
  String presenceYesterdayAt(String time) {
    return '最終オンライン：昨日 $time';
  }

  @override
  String presenceOnWeekday(String day) {
    String _temp0 = intl.Intl.selectLogic(
      day,
      {
        '1': '最終オンライン：月曜日',
        '2': '最終オンライン：火曜日',
        '3': '最終オンライン：水曜日',
        '4': '最終オンライン：木曜日',
        '5': '最終オンライン：金曜日',
        '6': '最終オンライン：土曜日',
        '7': '最終オンライン：日曜日',
        'other': '最終オンライン：今週',
      },
    );
    return '$_temp0';
  }

  @override
  String presenceWeeksAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '最終オンライン：$count週間前',
    );
    return '$_temp0';
  }

  @override
  String presenceMonthsAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '最終オンライン：$countか月前',
    );
    return '$_temp0';
  }

  @override
  String get presenceLongAgo => '最終オンライン：かなり前';

  @override
  String presenceMinutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '最終オンライン：$count分前',
    );
    return '$_temp0';
  }

  @override
  String chatReadByCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count人が既読',
    );
    return '$_temp0';
  }

  @override
  String get chatsSearchFrequent => 'よく話す人';

  @override
  String get chatsSearchRecent => '最近';

  @override
  String get chatsSearchClear => 'クリア';

  @override
  String get chatsSearchStartHint => '名前でチャットを、言葉でメッセージを検索できます。';

  @override
  String get chatsSearchEmpty => '一致するものはありません';

  @override
  String get chatRoutesTitle => '相手に届く経路';

  @override
  String get chatRoutesBluetoothHint => '相手のスマートフォンに直接。インターネット不要';

  @override
  String get chatRoutesMeshHint => '間にあるスマートフォンが中継';

  @override
  String get chatRoutesInternetHint => '範囲内に誰もいないときはリレー経由';

  @override
  String get chatRoutesHint => '経路はメッセージごとに、その時点で届くものから選ばれます。';

  @override
  String get chatRoutesPreferTitle => '優先する経路';

  @override
  String get chatRoutesPreferMesh => 'Bluetooth を優先';

  @override
  String get chatRoutesPreferMeshHint => '同じ部屋なら速く、データ通信を使わず、リレーに何も知られません';

  @override
  String get chatRoutesPreferRelay => 'インターネットを優先';

  @override
  String get chatRoutesPreferRelayHint => 'Bluetooth が不安定で、回線が良好なときに';

  @override
  String get chatRoutesPreferNote =>
      'これは優先順位であり、固定ではありません。選んだ経路が使えない場合は、もう一方の経路でメッセージが届けられます。';

  @override
  String get deadmanTitle => '未使用時に消去';

  @override
  String get deadmanOff => 'オフ';

  @override
  String deadmanDays(int days) {
    return '$days日後';
  }

  @override
  String get deadmanHint =>
      'その期間アプリが一度も開かれなかった場合、次に開いたときにすべてが消去されます。事前に警告することはできません。それがこの機能の目的です。';

  @override
  String chatForwardedFrom(String name) {
    return '$nameから転送';
  }

  @override
  String appLockWait(String left) {
    return '試行回数が多すぎます — $leftお待ちください';
  }

  @override
  String get appLockGraceTitle => 'コードを求めるタイミング';

  @override
  String get appLockGraceNow => '毎回';

  @override
  String appLockGraceAfter(String left) {
    return '$left離れた後';
  }

  @override
  String get chatCalendarTitle => '日付で表示';

  @override
  String get chatCalendarEmpty => 'ここではまだ何も話されていません';

  @override
  String get chatsSearchChatsSection => 'チャット';

  @override
  String get chatsSearchMessagesSection => 'メッセージ';

  @override
  String get contactProfileViewInChat => 'チャットで表示';

  @override
  String get chatDraft => '下書き';

  @override
  String get chatSearchTitle => '検索';

  @override
  String get chatSearchHint => 'メッセージを検索';

  @override
  String get chatSearchNoResults => '一致なし';

  @override
  String get chatSearchPrevious => '前の結果';

  @override
  String get chatSearchNext => '次の結果';

  @override
  String chatMessageCount(int count) {
    return '$count件のメッセージ';
  }

  @override
  String get chatRouteBluetooth => 'Bluetooth';

  @override
  String get chatRouteMesh => 'メッシュ';

  @override
  String get chatRouteInternet => 'インターネット';

  @override
  String get chatRouteQueued => '送信待ち';

  @override
  String get attachStickers => 'スタンプ';

  @override
  String get stickersEmpty => 'スタンプはまだありません';

  @override
  String get stickersEmptyHint => 'チャットの画像を保存すると、ここに表示されます。';

  @override
  String get stickerKeep => 'スタンプとして保存';

  @override
  String get stickerKept => 'スタンプに保存しました';

  @override
  String get stickerForget => 'スタンプを削除';

  @override
  String get stickerCreate => '写真からスタンプを作成';

  @override
  String get stickerFailed => 'この画像からスタンプを作成できませんでした';

  @override
  String get stickerLabel => 'スタンプ';

  @override
  String get previewPhoto => '写真';

  @override
  String get previewVoice => 'ボイスメッセージ';

  @override
  String get previewFile => 'ファイル';

  @override
  String get stickerEmojiTitle => 'スタンプの絵文字を選択';

  @override
  String get stickersMine => 'マイスタンプ';

  @override
  String get stickersStarterPack => 'Cubi';

  @override
  String get emojiTab => '絵文字';

  @override
  String get chatBlockedStatus => 'ブロック中';

  @override
  String get chatBlockedHint => 'この人をブロックしています';

  @override
  String get chatRouteFallbackOff => 'ネット オフ';

  @override
  String get chatAttachmentUnavailable =>
      '利用できる接続がありません。Bluetooth またはインターネットで接続して、もう一度お試しください。';

  @override
  String get fileTransfersTitle => 'ファイル転送';

  @override
  String get fileTransfersClear => '履歴を消去';

  @override
  String get fileTransfersEmpty => 'ファイル転送はまだありません';

  @override
  String get fileTransfersActive => '転送中';

  @override
  String get fileTransfersHistory => '履歴';

  @override
  String get fileTransferPause => '一時停止';

  @override
  String get fileTransferResume => '再開';

  @override
  String get fileTransferRetry => '再試行';

  @override
  String get fileTransferQueued => '接続待ち';

  @override
  String get fileTransferRunning => '転送中';

  @override
  String get fileTransferPaused => '一時停止中';

  @override
  String get fileTransferCompleted => '完了';

  @override
  String get fileTransferFailed => '失敗';

  @override
  String get fileTransferCanceled => 'キャンセル済み';

  @override
  String get profileFileTransfers => 'ファイル転送';

  @override
  String get profileFileTransfersSubtitle => '進行状況、キュー、転送履歴';

  @override
  String get qrScanAction => 'QR コードをスキャン';

  @override
  String get qrScanTitle => 'QR コードをスキャン';

  @override
  String get qrScanHint =>
      'CubeChat の連絡先、チャンネル、アカウント移行、またはコンピューターのサインイン用コードをスキャンしてください。';

  @override
  String get qrFlash => 'ライト';

  @override
  String get qrCameraError => 'カメラを使用できません。カメラの許可を確認して、もう一度お試しください。';

  @override
  String get qrInvalid => '有効な Cubechat の QR コードではありません。';

  @override
  String qrChannelAdded(String name) {
    return '$nameを追加しました';
  }

  @override
  String get qrShow => 'QR コードを表示';

  @override
  String qrChannelTitle(String name) {
    return '$nameに参加';
  }

  @override
  String get profileBackup => '暗号化バックアップ';

  @override
  String get profileBackupSubtitle => '鍵・連絡先・履歴を安全に移行';

  @override
  String get backupTitle => '暗号化バックアップ';

  @override
  String get backupExplainer =>
      'バックアップには、あなたの秘密の ID 鍵、連絡先、チャンネル、設定、メッセージ履歴が含まれます。このスマートフォン上で、あなたが選んだパスワードで暗号化されます。パスワードを忘れた場合、Cubechat では復元できません。';

  @override
  String get backupCreate => 'バックアップを作成';

  @override
  String get backupCreateSubtitle => 'すべてを暗号化して .cchatbackup ファイルに保存';

  @override
  String get backupRestore => 'バックアップを復元';

  @override
  String get backupRestoreSubtitle =>
      'このスマートフォンの Cubechat プロフィールをバックアップファイルで置き換えます';

  @override
  String get backupPasswordTitle => 'バックアップのパスワード';

  @override
  String get backupPasswordHint => '8文字以上';

  @override
  String get backupConfirmPassword => 'パスワードを再入力';

  @override
  String get backupPasswordMismatch => 'パスワードが一致しません';

  @override
  String get backupPasswordShort => '8文字以上にしてください';

  @override
  String get backupSaveTitle => 'Cubechat のバックアップを保存';

  @override
  String get backupSaved => '暗号化バックアップを保存しました';

  @override
  String get backupWhereTitle => 'バックアップの保存先は？';

  @override
  String get backupSaveToFiles => 'ファイルに保存';

  @override
  String get backupSaveToFilesHint => 'このスマートフォンのフォルダ、メモリーカード、クラウドドライブ';

  @override
  String get backupSendToApp => 'アプリに送る';

  @override
  String get backupSendToAppHint => 'Telegram、メール、メッセンジャーなど、ファイルを受け取れるアプリ';

  @override
  String get backupFailed => 'バックアップの操作を完了できませんでした';

  @override
  String get backupRestoreConfirmTitle => 'このプロフィールを置き換えますか？';

  @override
  String get backupRestoreConfirmMessage =>
      'このスマートフォンにある現在の鍵、連絡先、チャンネル、設定、履歴が、選択したバックアップで置き換えられます。';

  @override
  String get backupRestoreConfirmAction => '復元';

  @override
  String get backupRestored => 'バックアップを復元しました';

  @override
  String get backupPackingWait => 'バックアップを作成中…';

  @override
  String get backupUnpackingWait => 'バックアップを復元中…';

  @override
  String get backupWaitHint => '写真や動画があると数分かかることがあります。アプリを開いたままにしてください。';

  @override
  String get backupInvalid => 'パスワードが違うか、ファイルが破損しているか、対応していないバックアップです';

  @override
  String get channelInfoTitle => 'チャンネル情報';

  @override
  String get channelParticipantsTitle => '参加者';

  @override
  String get channelAdministratorsTitle => '管理者';

  @override
  String get channelMakeAdmin => '管理者にする';

  @override
  String get channelRemoveAdmin => '管理者から外す';

  @override
  String get channelNoParticipants => '署名付きのアクティビティがあると参加者が表示されます';

  @override
  String get channelSharedContent => 'メディア・ファイル・投票';

  @override
  String get channelDescriptionTitle => '説明';

  @override
  String get channelDescriptionEmpty => '説明はまだありません';

  @override
  String get channelDescriptionHint => 'このチャンネルの目的';

  @override
  String get channelDescriptionAdminOnly => '説明を変更できるのは管理者だけです';

  @override
  String get channelDescriptionSave => '保存';

  @override
  String get channelPrivateSubtitle => '非公開チャンネル';

  @override
  String get channelAvatarSet => '新しい写真を設定';

  @override
  String get channelSettingsTitle => 'チャンネル設定';

  @override
  String get channelSettingsHint => '投稿できる人、コピー、過去の投稿';

  @override
  String get channelLeaveAction => '退出';

  @override
  String get channelLeaveConfirm =>
      'ルームとそこで話されたすべてがこのスマートフォンから消えます。鍵は名前から作られるため、同じ名前を入力すればもう一度開けます。';

  @override
  String get channelShareAction => '共有';

  @override
  String channelMembersOf(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'メンバー$count人',
      one: 'メンバー$count人',
    );
    return '$_temp0';
  }

  @override
  String get chatTyping => '入力中…';

  @override
  String get chatRecordingVoice => 'ボイスメッセージを録音中…';

  @override
  String get chatRecordingCircle => 'ビデオメッセージを録画中…';

  @override
  String get chatSendingPhoto => '写真を送信中…';

  @override
  String get chatSendingVideo => '動画を送信中…';

  @override
  String get chatSendingFile => 'ファイルを送信中…';

  @override
  String get onboardingMeshTitle => 'インターネットなしで使える';

  @override
  String get onboardingMeshBody =>
      'メッセージは Bluetooth でスマートフォンからスマートフォンへ届きます。電波も Wi-Fi もアカウントも不要。周りにいる人だけでつながります。';

  @override
  String get onboardingRelayTitle => 'インターネットがあれば、それも使う';

  @override
  String get onboardingRelayBody =>
      'Bluetooth の範囲外では、メッセージはインターネット経由で同じように届きます。どちらを使うか選ぶ必要はありません。';

  @override
  String get onboardingPrivacyTitle => '途中の誰にも読めない';

  @override
  String get onboardingPrivacyBody =>
      'すべてエンドツーエンドで暗号化されます。あなたの ID はこのスマートフォンにある鍵です。電話番号でもメールアドレスでもなく、誰かに奪われるアカウントでもありません。';

  @override
  String get onboardingSkip => 'スキップ';

  @override
  String get onboardingNext => '次へ';

  @override
  String get onboardingStart => 'はじめる';

  @override
  String get chatMediaShare => '共有';

  @override
  String get chatMediaSaveToGallery => 'ギャラリーに保存';

  @override
  String get chatMediaShowInChat => 'チャットで表示';

  @override
  String get chatWallpaperTitle => '壁紙';

  @override
  String get chatWallpaperClear => 'リセット';

  @override
  String get chatWallpaperDim => 'メッセージの背景を暗くする';

  @override
  String get chatSelectAction => '選択';

  @override
  String get chatForwardNothing => '転送できるものはありません';

  @override
  String chatSelectedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count件選択',
      one: '$count件選択',
    );
    return '$_temp0';
  }

  @override
  String chatDeleteSelectedTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count件のメッセージを削除しますか？',
      one: 'このメッセージを削除しますか？',
    );
    return '$_temp0';
  }

  @override
  String get contactAliasAction => '連絡先の名前を変更';

  @override
  String get contactAliasHint => 'この名前はあなただけに表示されます。空欄にすると相手の名前を使います。';

  @override
  String get viewOnceSendLabel => '1回だけ表示';

  @override
  String get viewOnceTitle => '1回だけ表示';

  @override
  String get viewOnceTapToView => '写真 · タップして1回だけ表示';

  @override
  String get viewOnceSent => '写真 · 送信済み';

  @override
  String get viewOnceOpened => '写真を開封済み';

  @override
  String get viewOnceUnavailable => 'この写真はもう表示できません';

  @override
  String get viewOnceWarning => '閉じると、双方からこの写真が削除されます。';

  @override
  String get channelAvatarAdminOnly => 'チャンネルの写真を変更できるのは管理者だけです';

  @override
  String get channelAdminOnly => 'これを変更できるのは管理者だけです';

  @override
  String get channelAvatarTooLarge => 'この写真は大きすぎて配信できません';

  @override
  String get channelMemberUnknown => 'まだ連絡先にいません';

  @override
  String get channelInviteToContacts => '自分の連絡先カードを送る';

  @override
  String channelContactInviteSent(String name) {
    return '$nameさんに連絡先カードを送りました';
  }

  @override
  String get chatContactInvitation => '連絡先追加の招待';

  @override
  String get chatContactInvitationForYou => 'あなたへの招待';

  @override
  String get channelPollTitle => '投票';

  @override
  String get channelCreatePoll => '投票を作成';

  @override
  String get channelPollQuestion => '質問';

  @override
  String channelPollOption(int number) {
    return '選択肢 $number';
  }

  @override
  String get channelPollAddOption => '選択肢を追加';

  @override
  String get channelPollCreate => '投票を公開';

  @override
  String channelPollVotes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count票',
      one: '$count票',
      zero: '投票：なし',
    );
    return '$_temp0';
  }

  @override
  String get phoneTransferTitle => '新しいスマートフォンへ移行';

  @override
  String get desktopPickChat => 'メッセージを送る相手を選んでください';

  @override
  String get desktopListCollapse => 'アイコンのみ表示';

  @override
  String get desktopListExpand => 'チャットリストを表示';

  @override
  String get desktopLinkConnectTitle => 'コンピューターを接続';

  @override
  String get desktopLinkConnectHint => 'コンピューターの CubeChat に表示されたコードをスキャン';

  @override
  String get desktopLinkSignIn => 'スマートフォンのアカウントでサインイン';

  @override
  String get desktopLinkTitle => 'スマートフォンでサインイン';

  @override
  String get desktopLinkSteps =>
      'スマートフォンで プロフィール → データ →「コンピューターを接続」を開き、このコードをスキャンしてください。両方が同じ Wi-Fi に接続されている必要があります。';

  @override
  String get desktopLinkLimits =>
      'スマートフォンはそのまま使えます。インターネット経由のメッセージは両方に届きますが、一方から送ったメッセージはまだもう一方には表示されません。';

  @override
  String get desktopLinkWaiting => 'スマートフォンを待っています…';

  @override
  String get desktopLinkFailed => 'アカウントを受信できませんでした。もう一度お試しください。';

  @override
  String get desktopLinkRetry => '再試行';

  @override
  String get desktopLinkConfirmTitle => 'このアカウントのコピーをコンピューターに送信しますか？';

  @override
  String get desktopLinkConfirmMessage =>
      'コンピューターにあなたの鍵、連絡先、チャットが送られます。このスマートフォンはこれまでどおり使えます。';

  @override
  String get desktopLinkConfirmAction => '送信';

  @override
  String desktopLinkConfirmWhere(String address) {
    return 'このコードを今まさに自分のコンピューターの画面からスキャンした場合にのみ続けてください。このネットワーク上の $address に送信されます。';
  }

  @override
  String get desktopLinkSending => 'アカウントを送信中…';

  @override
  String get desktopLinkSent => 'コンピューターが接続されました';

  @override
  String get desktopLinkPhoneFound =>
      'スマートフォンがこのコンピューターを見つけ、アカウントのコピーを作成しています。写真があると数分かかることがあります。';

  @override
  String desktopLinkReceiving(int percent) {
    return 'アカウントを受信中：$percent%';
  }

  @override
  String get desktopLinkRestoring => 'このコンピューターにアカウントを設定中…';

  @override
  String get desktopLinkFinding => 'コンピューターを探しています…';

  @override
  String get desktopLinkPreparing => 'アカウントのコピーを作成中です。写真があると数分かかることがあります。';

  @override
  String desktopLinkSendingPercent(int percent) {
    return '送信中：$percent%';
  }

  @override
  String get desktopLinkComputerRestoring => 'コンピューターがアカウントを設定中…';

  @override
  String get devicesTitle => '端末';

  @override
  String get devicesRowHint => 'アカウントが開かれている場所と、そこからのログアウト';

  @override
  String get devicesThisDevice => 'この端末';

  @override
  String get devicesSeenNow => 'たった今オンライン';

  @override
  String devicesSeenMinutes(int n) {
    return '$n分前にオンライン';
  }

  @override
  String devicesSeenHours(int n) {
    return '$n時間前にオンライン';
  }

  @override
  String devicesSeenDays(int n) {
    return '$n日前にオンライン';
  }

  @override
  String get devicesLeaving => 'ログアウト中 — オンラインになるのを待っています';

  @override
  String get devicesSignOut => 'ログアウト';

  @override
  String get devicesSignOutAll => 'ほかのすべての端末からログアウト';

  @override
  String devicesSignOutTitle(String name) {
    return '「$name」からログアウトしますか？';
  }

  @override
  String get devicesSignOutMessage =>
      'その端末がオンラインになるとすぐに、CubeChat の鍵、チャット、設定が消去されます。アカウントはこの端末とほかの端末に残ります。';

  @override
  String get devicesSignOutPhoneMessage =>
      'これはスマートフォンです。CubeChat が完全に消去されます。アカウントはこの端末とほかの端末に残ります。';

  @override
  String get devicesSignOutAllMessage =>
      'ほかのすべての端末は、オンラインになるとすぐにログアウトされます。アカウントはこの端末にだけ残ります。';

  @override
  String get devicesRename => '名前を変更';

  @override
  String get devicesRenameTitle => 'この端末の名前';

  @override
  String get devicesSave => '保存';

  @override
  String get devicesEmpty =>
      'ほかの端末はまだありません。CubeChat 1.0.0+1147 以降を開いた端末がここに表示されます。';

  @override
  String get devicesCaveat =>
      'ログアウトはその端末がオンラインになったときに実行されます。オフラインのままの端末は鍵を保持し続けます。完全に保護するには、アカウントの鍵を新しくする必要があります。';

  @override
  String get desktopLinkImportTitle => 'スマートフォンからアカウントを移行';

  @override
  String get desktopLinkImportHint =>
      'スマートフォンにコードを見せると、このコンピューターがそのアカウントのコピーになります';

  @override
  String get desktopLinkImportConfirmTitle => 'このコンピューターのアカウントを置き換えますか？';

  @override
  String get desktopLinkImportConfirmMessage =>
      'このコンピューターの鍵、連絡先、チャットは、スマートフォンのアカウントで置き換えられます。今のアカウントがまだ必要なら、先にバックアップを作成してください。';

  @override
  String get desktopLinkImportConfirmAction => '続ける';

  @override
  String get desktopLinkUnreachable =>
      'コンピューターに接続できませんでした。両方が同じ Wi-Fi に接続され、コンピューターのファイアウォールで CubeChat が許可されている必要があります。';

  @override
  String get desktopLinkFirewallHint =>
      'Windows がスマートフォンからこのコンピューターへの接続を遮断することがあります。ファイアウォールで CubeChat を許可してください（ローカルネットワークのみ）。';

  @override
  String get desktopLinkFirewallAllow => 'ファイアウォールで許可';

  @override
  String get desktopLinkFirewallDeclined =>
      'Windows で許可されませんでした。許可がないと、スマートフォンから接続できない場合があります。';

  @override
  String get phoneTransferIntro =>
      'プロフィール、鍵、連絡先、チャンネル、設定、履歴を2台のスマートフォン間で直接移行します。';

  @override
  String get phoneTransferSend => 'こちらが古いスマートフォン';

  @override
  String get phoneTransferReceive => 'こちらが新しいスマートフォン';

  @override
  String get phoneTransferSameWifi =>
      '両方のスマートフォンを同じ Wi-Fi に接続してください。移行が終わるまでこの画面を開いたままにしてください。';

  @override
  String get phoneTransferPreparing => '暗号化された移行を準備中…';

  @override
  String get phoneTransferReady => '新しいスマートフォンでこの使い捨て QR コードをスキャンしてください';

  @override
  String get phoneTransferScan => '古いスマートフォンをスキャン';

  @override
  String get phoneTransferConfirmTitle => 'このスマートフォンのプロフィールを置き換えますか？';

  @override
  String get phoneTransferConfirmMessage =>
      'このスマートフォンに現在保存されているプロフィールは、暗号化されたローカル移行のデータで置き換えられます。';

  @override
  String get phoneTransferConfirmAction => 'プロフィールを移行';

  @override
  String get phoneTransferSuccess => 'プロフィールを移行しました';

  @override
  String get phoneTransferFailed => 'スマートフォンの移行を完了できませんでした';

  @override
  String get profileSummaryMeshOnly => 'メッシュのみ';

  @override
  String get profileSummaryMeshInternet => 'メッシュ · インターネット';

  @override
  String get profileSummaryBackgroundOn => 'バックグラウンドで動作中';

  @override
  String profileSummaryTransfersActive(int count) {
    return '$count件が進行中';
  }

  @override
  String get profileSummaryCardBackup => 'ファイル、バックアップ';

  @override
  String get chatPlay => '再生';

  @override
  String get chatPause => '一時停止';

  @override
  String get profileTheme => 'カラー';

  @override
  String get profileThemeEmerald => 'エメラルド';

  @override
  String get profileThemeIndigo => 'インディゴ';

  @override
  String get profileThemeAmber => 'アンバー';

  @override
  String get profileThemeRose => 'ローズ';

  @override
  String get profileThemeFuchsia => 'フューシャ';

  @override
  String get profileThemeViolet => 'バイオレット';

  @override
  String get profileThemeOcean => 'オーシャン';

  @override
  String get profileThemeSlate => 'スレート';

  @override
  String get profileScale => '表示サイズ';

  @override
  String get profileScaleSystem => 'システム';

  @override
  String get profileGlass => 'ガラス効果';

  @override
  String get profileGlassAuto => '自動';

  @override
  String get profileGlassFull => 'フル';

  @override
  String get profileGlassLight => 'ライト';

  @override
  String get profileGlassHint =>
      'ライトは色合いを残し、パネル背後のぼかしを省きます。自動はスマートフォンの性能を一度測定して決めます。すでに快適に動くスマートフォンではほとんど効果がなく、動作が重いスマートフォン向けの設定です。';

  @override
  String get mapAlwaysNeeded =>
      'cubechat を閉じている間もマップを更新するには、位置情報を「常に」に設定する必要があります。タップして設定を開きます。';

  @override
  String get mapShareConsentTitle => 'マップにあなたの位置情報を表示しますか？';

  @override
  String get mapShareConsentBody =>
      'あなたのリアルタイムの位置情報は、マップ上の連絡先（あなたが招待した人、またはあなたが招待を承諾した人）にだけ表示されます。非表示にするまで、Cubechat がバックグラウンドにあるときも含めて更新され続けます。位置情報はエンドツーエンドで暗号化され、私たちに届くことはありません。マップまたはプロフィールからいつでも非表示にでき、ブロックした連絡先にはあなたが表示されることはありません。';

  @override
  String get mapShareConsentAllow => '許可';

  @override
  String get mapShareConsentDecline => '許可しない';

  @override
  String get mapVisibleToFriends => 'マップ上の友だちに表示中';

  @override
  String get mapHiddenFromFriends => '非表示中';

  @override
  String get mapHideMe => '非表示';

  @override
  String get mapShowMe => '表示する';

  @override
  String get profileScaleSmall => '小';

  @override
  String get profileScaleNormal => '標準';

  @override
  String get profileScaleLarge => '大';

  @override
  String get profileScaleSample => 'テキストと行はこのサイズで表示されます。';

  @override
  String get savedTitle => '保存済み';

  @override
  String get savedSubtitle => '自分用のメモ（この端末のみ）';

  @override
  String get savedEmpty => 'ここに書いた内容はこのスマートフォンにだけ残ります。';

  @override
  String get meshOffTitle => 'Bluetooth メッシュはオフです';

  @override
  String get meshOffHint =>
      '近くの人はあなたを見つけられず、あなたも近くの人を見つけられません。メッセージはインターネットのリレー経由で引き続き届きます。';

  @override
  String get profileMeshSwitch => 'Bluetooth メッシュ';

  @override
  String get profileMeshSwitchHint =>
      '近くの人を見つけ、インターネットなしでメッセージを届けます。オフにするとバッテリーを節約できます。';

  @override
  String get channelAdminOnlyHint => 'お知らせ用チャンネルです。全員が閲覧できます。';

  @override
  String get attachLocation => '位置情報';

  @override
  String get locationBubbleTitle => '位置情報';

  @override
  String get locationOpenInMaps => 'マップで開く';

  @override
  String locationAccuracy(int metres) {
    return '誤差 $metres m 以内';
  }

  @override
  String get locationExpired => 'この位置情報は最新ではありません';

  @override
  String get locationDenied => '位置情報の許可がオフです';

  @override
  String get locationUnavailable => '位置を取得できませんでした';

  @override
  String get locationShareFor => '共有する期間';

  @override
  String get locationShareOnce => '1回のみ';

  @override
  String get locationShare15m => '15分';

  @override
  String get locationShare1h => '1時間';

  @override
  String get storageTitle => 'ストレージ';

  @override
  String get storageHeadline => 'ストレージ使用量';

  @override
  String storageSubtitle(String size) {
    return 'cubechat はこの端末で $size を使用しています';
  }

  @override
  String get storageEmpty => '保存されているものはまだありません';

  @override
  String get storageScanning => '計測中…';

  @override
  String get storageCatPhotos => '写真';

  @override
  String get storageCatVoice => 'ボイスメッセージ';

  @override
  String get storageCatFiles => '受信したファイル';

  @override
  String get storageCatOutbox => '送信したファイル';

  @override
  String get storageCatStickers => 'スタンプ';

  @override
  String get storageCatSaved => '保存済みメッセージ';

  @override
  String get storageCatWallpapers => '壁紙';

  @override
  String get storageCatHistory => '会話と鍵';

  @override
  String get storageCatCache => 'キャッシュ';

  @override
  String storageClear(String size) {
    return '$sizeを消去';
  }

  @override
  String get storageClearNothing => '何も選択されていません';

  @override
  String storageFreed(String size) {
    return '$sizeを解放しました';
  }

  @override
  String get storageNoCloud =>
      'クラウドへの保存はありません。消去したものはこのスマートフォンから消え、ほかにあるコピーは送られてきた元のスマートフォンだけです。';

  @override
  String get storageWhyHistoryLocked => '会話はここからは消去できません。緊急消去を使ってください。';

  @override
  String get storageRecoveryFree => '消去しても安全';

  @override
  String get storageRecoveryGone => 'ほかにコピーはありません';

  @override
  String get storageRecoveryAskSender => '送信者にもう一度依頼できます';

  @override
  String get storageRecoveryCostsThem => '相手から再送を頼まれても応じられなくなります';

  @override
  String storageConfirmTitle(String size) {
    return '$sizeを消去しますか？';
  }

  @override
  String get storageConfirmBody =>
      'ファイルはこのスマートフォンから削除されます。どこにもアップロードされていないため、復元元はありません。';

  @override
  String storageFilesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count個のファイル',
      zero: '空',
    );
    return '$_temp0';
  }

  @override
  String get customizeBarTitle => 'ナビゲーションバー';

  @override
  String get customizeBarHint => 'ドラッグで並べ替えます。チャットは削除できません。';

  @override
  String get customizeBarShown => '表示';

  @override
  String get customizeBarHidden => '非表示';

  @override
  String get customizeBarHiddenEmpty => '非表示の項目はありません';

  @override
  String get customizeBarMinimum => 'タブは2つ以上必要です';

  @override
  String get customizeReset => '初期設定に戻す';

  @override
  String get chatsArchiveTitle => 'アーカイブ';

  @override
  String get chatsArchiveEmpty => 'アーカイブは空です';

  @override
  String get chatsArchiveHint => 'アーカイブしたチャットも通常どおり動作します。リストに表示されないだけです。';

  @override
  String get chatsArchivedToast => 'アーカイブしました';

  @override
  String get chatsUnarchivedToast => 'リストに戻しました';

  @override
  String chatsArchiveCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count件のチャット',
    );
    return '$_temp0';
  }

  @override
  String get chatsSwipeNotHere => 'このチャットでは使用できません';

  @override
  String get customizeSwipeTitle => 'チャットを右にスワイプ';

  @override
  String get customizeSwipeHint => '左へのスワイプは引き続きタブの切り替えです。';

  @override
  String get customizeSwipeArchive => 'アーカイブ';

  @override
  String get customizeSwipeMute => '通知オフ';

  @override
  String get customizeSwipePin => 'ピン留め';

  @override
  String get customizeSwipeRead => '既読にする';

  @override
  String get customizeSwipeDelete => '削除';

  @override
  String get customizeSwipeNone => 'なし';

  @override
  String get customizeHighRefresh => '最大リフレッシュレート';

  @override
  String get customizeHighRefreshHint =>
      '表示がなめらかになり、スマートフォンは2倍のフレームを描画します。本体が熱くなる場合はオフにしてください。アプリの見た目は変わらず、再描画の頻度だけが変わります。';

  @override
  String get customizeQuickReaction => 'ダブルタップのリアクション';

  @override
  String get customizeQuickReactionHint =>
      'メッセージをダブルタップしたときに付くリアクションです。ほかのリアクションを使うと、それがここに設定されます。';

  @override
  String get customizeCircleAudioTitle => 'ビデオメッセージで音楽を一時停止';

  @override
  String get customizeCircleAudioOn => '録画や再生をすると、ほかに再生中の音声は停止します。自動では再開されません。';

  @override
  String get customizeCircleAudioOff => '音楽は再生を続け、ビデオメッセージの再生中は音量が下がります。';

  @override
  String get customizeMediaQualityTitle => '送信する写真の画質';

  @override
  String get customizeMediaQualityEconomy => '節約';

  @override
  String get customizeMediaQualityStandard => '標準';

  @override
  String get customizeMediaQualityHigh => '高画質';

  @override
  String get customizeMediaQualityEconomyHint =>
      '写真1枚あたり最大 96 KB、800 px。電波が弱いときや混雑した Bluetooth メッシュ向け：待ち時間は半分、画像はやや粗くなります。';

  @override
  String get customizeMediaQualityStandardHint =>
      '写真1枚あたり最大 192 KB、1280 px。Bluetooth だけでも届くサイズです。動画と「オリジナル」は常にそのまま送信されます。';

  @override
  String get customizeMediaQualityHighHint =>
      '写真1枚あたり最大 768 KB、2048 px。拡大しても鮮明ですが、送信に4倍の時間がかかるため Wi-Fi 向きです。';

  @override
  String get previewReacted => 'あなたのメッセージに';

  @override
  String get previewLocation => '位置情報';

  @override
  String get previewMapInvite => 'マップへの招待';

  @override
  String get previewContact => '連絡先';

  @override
  String get previewUnsupported => '未対応のメッセージ';

  @override
  String get previewCallOutgoing => '発信';

  @override
  String get previewCallIncoming => '着信';

  @override
  String get previewCallMissed => '不在着信';

  @override
  String chatPreparingPhotos(int count) {
    return '$count枚の写真を準備中…';
  }

  @override
  String get circleSwitchCamera => 'カメラを切り替え';

  @override
  String get circleLight => '録画用ライト';

  @override
  String get circleCameraSwitchFailed => 'カメラを切り替えられませんでした。録画は継続中です。';

  @override
  String get diagnosticsTitle => '診断';

  @override
  String get diagnosticsIntro => 'アプリの最近の動作記録です。うまく動かないときは、これを開発者に送ってください。';

  @override
  String get diagnosticsShare => 'ログを開発者に送信';

  @override
  String get diagnosticsEvents => '最近のイベント';

  @override
  String get diagnosticsTechnical => '技術的な記録';

  @override
  String get diagnosticsEmpty => '表示する内容はまだありません。';

  @override
  String get diagnosticsDeveloperOn => '開発者モード オン';

  @override
  String get diagnosticsDeveloperOff => '開発者モード オフ';

  @override
  String get logAppStarted => 'アプリを起動しました';

  @override
  String get logInternetOn => 'インターネット接続がオンになりました';

  @override
  String logServerConnected(String host) {
    return '$host に接続しました';
  }

  @override
  String logServerLost(String host) {
    return '$host との接続が切れました';
  }

  @override
  String get chatSaveAction => '保存';

  @override
  String get savedTagAsk => '保存しました。タグを付けますか？';

  @override
  String get savedTagAdd => 'タグを追加';

  @override
  String get chatSharedWallpaperFailed => 'こちらに壁紙を設定しました。相手が範囲内に来たら届きます。';

  @override
  String get chatTranscribeAction => '文字起こし';

  @override
  String get chatTranscribeFailed => 'このスマートフォンではこのメッセージを文字起こしできません。';

  @override
  String get chatTranscribing => '認識中…';

  @override
  String get chatTranscriptHide => 'テキストを隠す';

  @override
  String get chatCancelSend => '送信を取り消す';

  @override
  String get chatDownloadAction => 'ダウンロード';

  @override
  String get chatDownloaded => 'スマートフォンに保存しました';

  @override
  String get chatDownloadFailed => '保存できませんでした';

  @override
  String get selfUpdateTitle => 'ファイルからアップデートをインストール';

  @override
  String get selfUpdateHint =>
      '新しい cubechat の APK はチャットから開かず、ここで選んでください。この方法でインストールすると、ロック画面での着信がオンのまま維持されます。';

  @override
  String get selfUpdateConfirm => 'システムの画面でインストールを確認してください。';

  @override
  String get selfUpdateAllow => 'cubechat にアプリのインストールを許可してから、もう一度タップしてください。';

  @override
  String get selfUpdateNotOurs => 'このファイルは cubechat のアップデートではありません。';

  @override
  String get selfUpdateFailed => 'アップデートはインストールされませんでした。';

  @override
  String get chatTranscribeDownloading =>
      'スマートフォンがこのための言語データをダウンロード中です。1分ほどしてからもう一度お試しください。';

  @override
  String get chatTranscribeNoLanguage =>
      'このスマートフォンにはその言語の音声モデルがありません。プロフィール → チャットとメディア で文字起こしの言語を選んでください。';

  @override
  String get chatTranscribeNotAllowed =>
      'CubeChat の音声認識がオフになっています。iPhone の 設定 → CubeChat でオンにしてください。';

  @override
  String get customizeTranscribeLanguageTitle => '文字起こしの言語';

  @override
  String get customizeTranscribeLanguageAuto => '自動';

  @override
  String get customizeTranscribeLanguageHint =>
      'ボイスメッセージで話されている言語です。アプリの表示言語と同じである必要はありません。「自動」はスマートフォンの言語を試します。ない言語はスマートフォン自身がダウンロードし、音声が外部に送られることはありません。';

  @override
  String get chatTranslateAction => '翻訳';

  @override
  String get chatTranslateFailed => 'このスマートフォンではこのメッセージを翻訳できません。';

  @override
  String get customizeDeferMediaTitle => 'メディアは Wi-Fi でダウンロード';

  @override
  String get customizeDeferMediaHint =>
      'モバイルデータ通信中もメッセージと通話は通常どおり使えますが、写真、ボイスメッセージ、ビデオメッセージ、ファイルは Wi-Fi に接続するまでサーバーで待機します（最大2週間）。チャットの上の行に待機中のものが表示され、すぐにダウンロードすることもできます。';

  @override
  String heldMediaCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count件のメディアが Wi-Fi 待ち',
      one: '1件のメディアが Wi-Fi 待ち',
    );
    return '$_temp0';
  }

  @override
  String get heldMediaDownload => 'ダウンロード';

  @override
  String get nearbyAirDropSubtitle => '近くの人とファイルを共有';

  @override
  String get nearbyFilesSubtitle => '送受信したファイル';

  @override
  String get airdropTab => 'AirDrop';

  @override
  String get nearbyTabFiles => 'ファイル';

  @override
  String get airdropReceiveHint => 'ファイルを送れる人';

  @override
  String get airdropReceiveContacts => '連絡先';

  @override
  String get airdropReceiveEveryone => '全員（10分）';

  @override
  String airdropEveryoneLeft(String time) {
    return '全員 · $time';
  }

  @override
  String get airdropSendFiles => 'ファイルを送信';

  @override
  String get airdropChooseFiles => 'ファイルを選択';

  @override
  String airdropStagedTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count個のファイルを準備完了',
    );
    return '$_temp0';
  }

  @override
  String get airdropStagedHint =>
      '両方のスマートフォンで Bluetooth をオンにして AirDrop を開き、端末を近づけるか相手を選んでください';

  @override
  String get airdropStagedPickPerson => '相手を選択';

  @override
  String airdropRequestBody(String what, String size) {
    return '$whatを送信しようとしています · $size';
  }

  @override
  String airdropWhatPhotos(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '写真$count枚',
      one: '写真$count枚',
    );
    return '$_temp0';
  }

  @override
  String airdropWhatVideos(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '動画$count本',
      one: '動画$count本',
    );
    return '$_temp0';
  }

  @override
  String airdropWhatFiles(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'ファイル$count個',
      one: 'ファイル$count個',
    );
    return '$_temp0';
  }

  @override
  String get airdropAccept => '受け入れる';

  @override
  String get airdropDecline => '拒否';

  @override
  String get airdropWaiting => '応答を待っています…';

  @override
  String get airdropAccepted => '受け入れられました';

  @override
  String get airdropUnheard => '届きませんでした — CubeChat のバージョンが古い可能性があります';

  @override
  String get airdropSending => '送信中';

  @override
  String get airdropReceiving => '受信中';

  @override
  String get airdropInterrupted => '中断されました';

  @override
  String get airdropRetry => '再試行';

  @override
  String get airdropOutcomeSent => '送信済み';

  @override
  String get airdropOutcomeReceived => '受信済み';

  @override
  String get airdropOutcomeDeclined => '拒否されました';

  @override
  String get airdropOutcomeCancelled => 'キャンセル済み';

  @override
  String get airdropOutcomePartial => '一部のみ';

  @override
  String get airdropReasonNoSpace => '空き容量不足';

  @override
  String get airdropReasonContactsOnly => '連絡先のみ';

  @override
  String get airdropReasonBusy => '取り込み中';

  @override
  String get airdropReasonTimeout => '応答なし';

  @override
  String get airdropFileDeleted => '削除済み';

  @override
  String get airdropHistory => '履歴';

  @override
  String get airdropClearHistory => '履歴を消去';

  @override
  String get airdropEmpty => '近くの人と送受信したファイルがここに表示されます';

  @override
  String get airdropPickPerson => '送信先';

  @override
  String get airdropNobody => '近くに cubechat を使っている人はまだいません';

  @override
  String get airdropNoDirect => 'この人との Bluetooth 接続がありません';

  @override
  String get airdropNearbyUnknown => '近く';

  @override
  String get airdropConnecting => '接続中…';

  @override
  String get airdropConnectFailed => '接続できませんでした';

  @override
  String get airdropSlowWarning => 'Bluetooth では時間がかかる場合があります';

  @override
  String airdropTooLarge(String name, int limit) {
    return '$name は $limit MB を超えています';
  }

  @override
  String airdropFromLabel(String name) {
    return 'AirDrop · $name';
  }

  @override
  String get airdropWrite => 'メッセージ';

  @override
  String get airdropAction => 'AirDrop';

  @override
  String get airdropLaneTitle => '経路';

  @override
  String get airdropLaneAuto => '自動';

  @override
  String get airdropLaneBluetooth => 'Bluetooth';

  @override
  String get airdropLaneWifi => 'Wi‑Fi';

  @override
  String get airdropBluetoothNeededHint =>
      'お互いを見つけて転送を確認するため、両方のスマートフォンで Bluetooth をオンにしてください。';

  @override
  String get airdropLaneHint =>
      'Bluetooth でスマートフォン同士を見つけて接続します。両方が同じネットワークまたはテザリングにつながっていれば、ファイルは Wi‑Fi で転送されます。';

  @override
  String get airdropWifiUnreachable => '同じネットワークにいません';

  @override
  String get airdropWifiOldVersion => '相手のアプリはまだ Wi‑Fi での受信に対応していません';

  @override
  String get airdropBumpAdd => '追加';

  @override
  String get airdropBumpAlreadyContact => 'すでに連絡先にいます';

  @override
  String airdropBumpSending(String name) {
    return '$nameさんに送信中';
  }

  @override
  String airdropBumpReceiving(String name) {
    return '$nameさんがファイルを送信しています';
  }

  @override
  String get termsTitle => 'cubechat のルール';

  @override
  String get termsBody =>
      'cubechat は、不快なコンテンツや迷惑行為を行うユーザーを一切容認しません。続行すると、嫌がらせ、脅迫、未成年者が関わる性的コンテンツ、スパム、その他違法なものを送信しないことに同意したものとみなされます。誰でもメッセージや人物を通報できます。通報は開発者に届き、24時間以内に対応され、違反者は利用を禁止されます。';

  @override
  String get termsReadFull => '利用規約の全文を読む';

  @override
  String get termsAccept => '同意する';

  @override
  String get messageHide => '非表示';

  @override
  String get messageHidden => 'あなたには非表示';

  @override
  String get reportAction => '通報';

  @override
  String get reportTitle => '何が問題ですか？';

  @override
  String get reportReasonSpam => 'スパム';

  @override
  String get reportReasonAbuse => '暴言・嫌がらせ';

  @override
  String get reportReasonViolence => '暴力';

  @override
  String get reportReasonSexual => '性的なコンテンツ';

  @override
  String get reportReasonOther => 'その他';

  @override
  String get reportNoteHint => '詳細（任意）';

  @override
  String get reportSend => '通報を送信';

  @override
  String get reportDisclosure =>
      '選択したメッセージの本文と通報内容は、cubechat のモデレーションとその非公開 Telegram ボットに送られます。';

  @override
  String get reportSent => '通報を送信しました。24時間以内に確認します。';

  @override
  String get reportBlockedToo => 'この人をブロックしました。';

  @override
  String get reportQueued => '通報を保存しました。オンラインになったら送信されます。';

  @override
  String get reportFailed => '通報を送信できませんでした。';

  @override
  String get filteredMessage => 'フィルターで非表示';

  @override
  String get filteredShow => '表示';

  @override
  String get filterToggle => '不快なコンテンツのフィルター';

  @override
  String get filterToggleHint => '知らない人からのメッセージやチャンネルで、乱暴な言葉を隠します';

  @override
  String get aboutTitle => 'アプリについて';

  @override
  String get aboutContact => '開発者にメール';

  @override
  String get aboutReport => '違反を報告';

  @override
  String get aboutTerms => '利用規約';

  @override
  String get aboutPrivacy => 'プライバシーポリシー';

  @override
  String get requestsTitle => 'リクエスト';

  @override
  String get requestsEmpty => 'リクエストはありません';

  @override
  String requestBanner(String name) {
    return '$nameさんは連絡先にいません。承認するまで、相手にはあなたが既読にしたことが表示されず、通話もかけられません。';
  }

  @override
  String get requestAccept => '承認';

  @override
  String get requestDelete => '削除';

  @override
  String get requestBlock => 'ブロック';

  @override
  String get cubeIdTitle => 'Cube ID';

  @override
  String get cubeIdExplainer =>
      'あなたの @名前 は連絡先カードにつながります。サーバーに保存されるのは名前と公開カードだけで、メッセージは保存されません。';

  @override
  String get cubeIdFieldHint => 'a–z、0–9、_ で3〜20文字';

  @override
  String get cubeIdAvailable => '使用可能';

  @override
  String get cubeIdTaken => '使用済み';

  @override
  String get cubeIdReserved => '使用不可';

  @override
  String get cubeIdInvalid => 'a–z、0–9、_ のみ、3〜20文字';

  @override
  String get cubeIdClaim => 'この名前を取得';

  @override
  String get cubeIdWorking => '名前を確保中…';

  @override
  String get cubeIdChange => '変更';

  @override
  String get cubeIdEmail => '復元用メールアドレス';

  @override
  String get cubeIdEmailHint => 'このスマートフォンを紛失した場合、このアドレスに届くメールで名前を取り戻せます';

  @override
  String get cubeIdEmailField => 'メールアドレス';

  @override
  String cubeIdEmailSent(String email) {
    return '$email にメールを送信しました。メール内のリンクを開いてください。';
  }

  @override
  String get cubeIdEmailRemove => 'メールアドレスを削除';

  @override
  String get cubeIdEmailUnavailable => '現在メールを利用できません。しばらくしてからお試しください。';

  @override
  String get cubeIdEmailInvalid => 'メールアドレスの形式ではないようです';

  @override
  String get cubeIdSave => '保存';

  @override
  String get cubeIdRecover => 'メールで名前を復元';

  @override
  String get cubeIdRecoverSent =>
      'アドレスが一致すれば、メールが届きます。リンクを開いてから48時間後に、名前がこのスマートフォンに移ります。';

  @override
  String cubeIdRecoveryWarning(String name, String when) {
    return '誰かが別のスマートフォンでメールを使って @$name を復元しようとしています。キャンセルしない限り、$whenに名前が移ります。';
  }

  @override
  String get cubeIdRecoveryCancel => '復元をキャンセル';

  @override
  String get cubeIdRecoveryCancelled => '復元をキャンセルしました';

  @override
  String get cubeIdRelease => '解放';

  @override
  String cubeIdReleaseConfirm(String name) {
    return '@$name を解放しますか？誰でも取得できるようになります。';
  }

  @override
  String get cubeIdShare => '共有';

  @override
  String cubeIdShareText(String name) {
    return 'cubechat で私を見つけてください：@$name\nhttps://cubechat.tech/u.html#$name';
  }

  @override
  String get cubeIdFailed => '名前を保存できませんでした。もう一度お試しください。';

  @override
  String get cubeIdOffline => 'インターネット接続なし';

  @override
  String get lookupNotFound => 'その @名前 のユーザーはいません';

  @override
  String searchFindCubeName(String name) {
    return '@$name を検索';
  }

  @override
  String get searchFindCubeNameHint => 'Cube ID で検索して追加';

  @override
  String get addContactHintName => 'カードを貼り付けるか @名前 を入力';

  @override
  String get strangerReachTitle => 'インターネット経由でメッセージを送れる人';

  @override
  String get strangerReachAll => '全員';

  @override
  String get strangerReachRequest => 'リクエスト';

  @override
  String get strangerReachNone => 'なし';

  @override
  String get strangerReachHint =>
      'あなたがメッセージを送ったことのない人がインターネット経由で連絡してくる場合の設定です。Bluetooth で近くにいる人には影響しません。';

  @override
  String get sectionPrivacy => 'プライバシーとセキュリティ';

  @override
  String get sectionNotifications => '通知と通話';

  @override
  String get sectionConnection => '接続';

  @override
  String get sectionChats => 'チャットとメディア';

  @override
  String get sectionAppearance => '外観';

  @override
  String get sectionData => 'データとストレージ';

  @override
  String get sectionAbout => 'アプリについて';

  @override
  String get subWhoSeesMe => '自分を見られる人';

  @override
  String get subProtection => '保護';

  @override
  String get subNotifications => '通知';

  @override
  String get subCalls => '通話';

  @override
  String get profileDiscoverableMeshOff =>
      'Bluetooth メッシュがオフです — 「接続」でオンにしてください。';

  @override
  String get chatRouteBluetoothDirect => 'Bluetooth 直接';

  @override
  String chatRouteMeshHops(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'メッシュ · $nホップ',
    );
    return '$_temp0';
  }

  @override
  String chatRouteDeliveredVia(String route) {
    return '配信経路：$route';
  }

  @override
  String chatRouteReceivedVia(String route) {
    return '受信経路：$route';
  }

  @override
  String get chatUnreadDivider => '新着メッセージ';

  @override
  String get radioTitle => 'トランシーバー';

  @override
  String get radioNearbySubtitle => 'ボタンを押したまま、グループや連絡先と話せます';

  @override
  String get radioGroupsLabel => 'グループ';

  @override
  String get radioDirectLabel => '個人';

  @override
  String get radioAddGroup => '無線を追加';

  @override
  String get radioNoGroups => '無線はまだありません。追加すると、同じ名前とパスワードを入力した全員と話せます。';

  @override
  String get radioLeave => 'この無線から退出';

  @override
  String get radioPickChannel => 'グループか連絡先を選択';

  @override
  String get radioPushToTalk => '押して話す';

  @override
  String get radioTalking => '通話中…';

  @override
  String get radioChannelBusy => 'チャンネル使用中';

  @override
  String radioSpeaker(String name) {
    return '$nameさんが話しています';
  }

  @override
  String get radioSilentTitle => 'マナーモードでも話す';

  @override
  String get radioSilentHint => 'スマートフォンがマナーモードでも音声が再生されます。';

  @override
  String get radioJoinNameLabel => '名前';

  @override
  String get radioJoinPasswordLabel => 'パスワード（任意）';

  @override
  String get radioJoinHint =>
      '同じ名前とパスワードを入力した人は、同じ無線につながります。参加者のリストを持つサーバーはありません。';

  @override
  String get radioJoinNameRequired => '名前を入力してください';

  @override
  String get radioJoinSubmit => '追加';

  @override
  String get radioBlockedTooLong => '1分間話したため切断されました';

  @override
  String get radioBlockedCall => '通話中です';

  @override
  String get radioBlockedMicrophone => 'マイクにアクセスできません';

  @override
  String get radioBlockedUnavailable => 'この端末では無線を使用できません';

  @override
  String get radioBlockedNoChannel => '先にグループか連絡先を選んでください';

  @override
  String get radioTurnOff => '無線をオフにする';

  @override
  String get radioPersonalCallsTitle => '個人呼び出しを受ける';

  @override
  String get radioPersonalCallsHint => '無線がオフのときに連絡先から話しかけられると、その人に自動で合わせます。';

  @override
  String get radioBackgroundHint => '画面がオフのときは、バックグラウンド動作がオンの場合のみ無線が聞こえます。';

  @override
  String get areaNearby => '近くのチャット';

  @override
  String get areaLevelDistrict => '地区';

  @override
  String get areaLevelCity => '市';

  @override
  String get areaLevelRegion => '地域';

  @override
  String areaPresentCount(int count) {
    return 'ここに約$count人';
  }

  @override
  String get areaPresentMany => 'ここに50人以上';

  @override
  String get areaBlockViaBluetooth => 'あなたの街区 — Bluetooth 経由';

  @override
  String get areaOpenNearbyTab => '「近く」を開く';

  @override
  String get areaLocating => 'あなたの地区を探しています…';

  @override
  String get areaNoPlace =>
      'まだ位置情報がありません。エリアチャットでは、この画面を開いている間、おおよその位置情報が必要です。';

  @override
  String get areaLocationDenied =>
      'Cubechat の位置情報がオフです。地区を表示するには、設定でおおよその位置情報を許可してください。';

  @override
  String get areaOffline => 'エリアチャットに接続できません';

  @override
  String get areaEmpty => '過去24時間、ここには誰も書き込んでいません。';

  @override
  String get areaConsentTitle => 'エリアチャットは公開されています';

  @override
  String get areaConsentBody =>
      'ここでのメッセージは公開されます。あなたの地区や市を開いた人なら誰でも読むことができ、Cubechat のサーバーに24時間保存されます。あなたは数時間ごとに変わる一時的な名前で書き込みます。あなたの @名前 や連絡先は誰にも見えません。地区を判別するため、Cubechat はこの画面を開いている間だけ、おおよその位置情報を求めます。';

  @override
  String get areaConsentAllow => '続ける';

  @override
  String get areaConsentDecline => '今はしない';

  @override
  String areaDefaultName(String tag) {
    return 'Cube-$tag';
  }

  @override
  String areaYouAre(String name, int hours) {
    return 'あなたは $name · $hours時間後に新しい名前';
  }

  @override
  String get areaNewName => '新しい名前';

  @override
  String get areaSetName => '名前を決める';

  @override
  String get areaNameHint => 'この名前が有効な数時間だけ使われます。空欄にすると自動の名前になります。';

  @override
  String get areaNameSameWarning => '同じ名前を使うと、地区をまたいであなたが同一人物だとわかります';

  @override
  String get areaShowPresence => 'ここにいることを表示';

  @override
  String get areaPresenceOffHint => '近くに何人いるか見るには、「ここにいることを表示」をオンにしてください';

  @override
  String get areaReadOnly => '書き込めるのは今いる場所だけです';

  @override
  String get areaComposerHint => 'ここにいる全員へのメッセージ';

  @override
  String get areaSend => '送信';

  @override
  String get areaWaitALittle => '少しお待ちください';

  @override
  String areaFlood(int count) {
    return '連投（$count）· 表示';
  }

  @override
  String get areaReply => '返信';

  @override
  String get areaHide => '非表示';

  @override
  String get areaBlock => '名前が変わるまでブロック';

  @override
  String get areaBlocked => '名前が変わるまでブロック中';

  @override
  String get areaReport => '通報';

  @override
  String get areaOpenLink => 'リンクを開く';

  @override
  String areaOpenLinkConfirm(String url) {
    return '$url を開きますか？';
  }

  @override
  String get areaOpen => '開く';

  @override
  String get areaReadHere => 'ここを読む';

  @override
  String get areaReadHereHint =>
      '閲覧のみです。書き込めるのは今いる場所だけです。どの場所を読んでいるかはリレーに知られます。';

  @override
  String get areaNotes => 'メモ';

  @override
  String areaNotesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'メモ$count件',
      zero: 'メモ：なし',
    );
    return '$_temp0';
  }

  @override
  String get areaLeaveNote => 'メモを残す';

  @override
  String get areaNoteHint => 'あなたの市に向けた短いメモ';

  @override
  String get areaNoteLifetime => '保存期間';

  @override
  String get areaNote1h => '1時間';

  @override
  String get areaNote24h => '24時間';

  @override
  String get areaNote7d => '7日';

  @override
  String get areaPinToDistrict => '地区にピン留め';

  @override
  String get areaPinHint => '市内のマップをタップすると、ピンがその地区に固定されます。';

  @override
  String get areaPinOutside => '市内のみ';

  @override
  String get areaNoteDelete => '自分のメモを削除';

  @override
  String get areaNoNotes => 'ここにはまだメモがありません';

  @override
  String get areaNotesLimit => '1日3件まで';

  @override
  String get areaNoteLeft => 'メモを残しました';

  @override
  String get areaNoteSend => '残す';

  @override
  String get areaOwnNote => 'あなたのメモ';

  @override
  String get areaNotePinned => '地区にピン留め済み';

  @override
  String get areaHidden => '非表示';

  @override
  String get areaPublicBadge => '公開 · 24時間保存';

  @override
  String get areaSettingTitle => 'エリアチャット';

  @override
  String get areaSettingOnHint =>
      'マップ上の「近くのチャット」ボタン：一時的な名前で参加する、あなたの地区と市の公開チャットです。';

  @override
  String get areaSettingOffHint =>
      'オフ：マップにボタンは表示されず、エリアチャットが位置情報を求めたり接続したりすることはありません。';

  @override
  String get wallpaperPhotoLocalOnly => '写真の壁紙は今のところこの端末だけです';

  @override
  String get wallpaperSavedNoRoute => 'ここに保存しました。現在、相手への経路がありません';

  @override
  String get wallpaperScopeTitle => 'この壁紙を誰に表示しますか？';

  @override
  String get wallpaperScopeChannel => 'チャンネル全体';

  @override
  String get wallpaperScopeBoth => '自分と相手';

  @override
  String get wallpaperScopeLocal => '自分だけ';

  @override
  String get wallpaperScopeSharedHint => '暗号化された制御パケットとして送信';

  @override
  String get wallpaperScopePhotoHint => '写真は今のところこの端末にのみ残ります';

  @override
  String get foldersCreate => 'フォルダを作成';

  @override
  String get foldersYours => 'あなたのフォルダ';

  @override
  String get foldersSmartFilters => 'スマートフィルター';

  @override
  String get foldersName => 'フォルダ名';

  @override
  String get foldersSave => '保存';

  @override
  String get foldersDeleteTitle => 'フォルダを削除しますか？';

  @override
  String get foldersDelete => '削除';

  @override
  String get foldersCreateAction => '作成';

  @override
  String get chatsArchiveHiddenToast => 'アーカイブを非表示にしました。「外観」で元に戻せます。';

  @override
  String get chatsBulkPin => 'ピン留め';

  @override
  String get chatsBulkMute => '通知オフ';

  @override
  String get chatsUnarchive => 'アーカイブ解除';

  @override
  String get chatsAddToFolder => 'フォルダに追加';

  @override
  String get chatsMarkUnread => '未読にする';

  @override
  String get chatsClearHistory => '履歴を消去';

  @override
  String get foldersNew => '新しいフォルダ';

  @override
  String get foldersNameHint => '友だち';

  @override
  String get chatsNoIncoming => '受信メッセージはありません';

  @override
  String get chatsMarkedUnread => '未読にしました';

  @override
  String get chatsClearHistoryTitle => 'チャット履歴を消去しますか？';

  @override
  String get chatsClearHistoryBody =>
      'メッセージはこの端末からのみ削除されます。チャット、連絡先、お気に入りは残ります。';

  @override
  String get chatsClearHistoryAction => '消去';

  @override
  String get chatsHistoryCleared => '履歴を消去しました';

  @override
  String get savedTagMenuTag => 'タグ';

  @override
  String get savedTagRemove => 'タグを外す';

  @override
  String get customizeArchiveRowTitle => 'アーカイブ行';

  @override
  String get customizeArchiveRowHint =>
      'チャット一覧の上に表示します。アーカイブしたチャットもメッセージは受信し続けます。';

  @override
  String get mapLayerStandard => '標準';

  @override
  String get mapLayerStandardHint => '明るい道路地図 — 最も安定した選択肢';

  @override
  String get backupAutoTitle => '自動バックアップ';

  @override
  String get backupAutoHint =>
      '1日1回、選んだフォルダ内の1つのファイルに保存します。新しいコピーが前のものを置き換えます。';

  @override
  String backupAutoFolder(String name) {
    return 'フォルダ：$name';
  }

  @override
  String backupAutoLast(String time) {
    return '前回のコピー：$time';
  }

  @override
  String get backupAutoNever => 'まだコピーはありません';

  @override
  String get backupAutoRunning => 'コピーを作成中…';

  @override
  String get backupAutoFolderLost => 'フォルダにアクセスできません。もう一度選んでください。';

  @override
  String get backupAutoFailed => '前回のコピーに失敗しました。後でもう一度試します。';

  @override
  String get backupAutoNow => '今すぐバックアップ';

  @override
  String get backupAutoChangeFolder => 'フォルダを変更';

  @override
  String get callYourMicOff => 'マイクがオフです';

  @override
  String callTheirCameraOff(String name) {
    return '$name さんのカメラはオフです';
  }
}
