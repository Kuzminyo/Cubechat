// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get callVoice => '语音通话';

  @override
  String get callVideo => '视频通话';

  @override
  String get callIncomingVideo => '视频来电';

  @override
  String get callCamera => '摄像头';

  @override
  String get callFlipCamera => '翻转';

  @override
  String get contactProfileVideo => '视频';

  @override
  String get callPreparing => '正在准备麦克风…';

  @override
  String get callDialing => '正在呼叫…';

  @override
  String get callRinging => '等待接听…';

  @override
  String get callConnecting => '正在连接…';

  @override
  String get callMicrophoneRequired => '请在系统设置中允许访问麦克风以进行通话。';

  @override
  String get callMicrophoneWindows =>
      'Windows 未允许 CubeChat 使用麦克风。请打开“设置 → 隐私和安全性 → 麦克风 → 允许桌面应用访问你的麦克风”。';

  @override
  String get callElsewhere => '此账号的另一台设备上已有通话在进行。';

  @override
  String get callRelayUnavailable => '通话服务器不可用，请稍后重试。';

  @override
  String get callBusy => '忙线中';

  @override
  String get callNoAnswer => '无人接听';

  @override
  String get callFailed => '无法接通通话';

  @override
  String get callDeclined => '通话已拒绝';

  @override
  String get callEnded => '通话已结束';

  @override
  String get callMicrophone => '麦克风';

  @override
  String get callSpeaker => '扬声器';

  @override
  String get callAnswer => '接听';

  @override
  String get callDecline => '拒绝';

  @override
  String get callEnd => '挂断';

  @override
  String get callClose => '关闭';

  @override
  String get callMinimize => '最小化';

  @override
  String get callAudioOutput => '通话音频';

  @override
  String get callRoutePhone => '手机';

  @override
  String get callRouteBluetooth => 'Bluetooth';

  @override
  String get callRouteHeadphones => '耳机';

  @override
  String get callFullScreenTitle => '锁屏来电';

  @override
  String get callFullScreenBody => '允许来电显示在锁屏上，无需解锁即可接听。';

  @override
  String get callFullScreenXiaomi =>
      '小米、红米和 Poco 不允许应用自行开启此项：请在“其他权限”中开启“锁屏显示”。';

  @override
  String get circleMessage => '视频消息';

  @override
  String get appName => 'Cubechat';

  @override
  String get navChats => '聊天';

  @override
  String get navPeers => '附近';

  @override
  String get navProfile => '我的';

  @override
  String get navContacts => '联系人';

  @override
  String get navMap => '地图';

  @override
  String get mapTitle => '地图';

  @override
  String get mapFriendsTitle => '地图上的人';

  @override
  String get mapFriendsHint => '只有这些联系人能收到你的位置';

  @override
  String mapClusterTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '此处有 $count 人',
    );
    return '$_temp0';
  }

  @override
  String get mapClusterHint => '点按某人，地图将移动到其位置';

  @override
  String get mapNorthUp => '正北朝上';

  @override
  String get mapLayerTitle => '地图样式';

  @override
  String get mapLayerHint => '标记下方显示的底图';

  @override
  String get mapLayerDark => '深色';

  @override
  String get mapLayerDarkHint => '仅街道、无标注——标记下最安静的底图';

  @override
  String get mapLayerSatellite => '卫星';

  @override
  String get mapLayerSatelliteHint => '航拍影像：看清是哪栋楼、哪个院子';

  @override
  String get mapLayerTerrain => '地形';

  @override
  String get mapLayerTerrainHint => '等高线和地势，适合山丘和小径';

  @override
  String get mapFriendsEmpty => '还没有人与你共享地图。';

  @override
  String get mapFriendsEmptyHint => '邀请联系人，对方接受后就会出现在这里。';

  @override
  String get mapFriendsInvite => '邀请';

  @override
  String get mapFriendsRemove => '从地图移除';

  @override
  String mapFriendsRemoved(String name) {
    return '$name 已不再与你共享地图';
  }

  @override
  String get mapFriendsLive => '正在地图上';

  @override
  String get mapFriendsIdle => '暂无位置';

  @override
  String get mapInviteTitle => '邀请到地图';

  @override
  String get mapInviteHint => '选择一个或多个聊天';

  @override
  String get mapInviteEmpty => '暂无可邀请的聊天。';

  @override
  String mapInviteAction(int count) {
    return '发送（$count）';
  }

  @override
  String get mapInviteMessage => 'Cubechat 地图邀请。在此聊天中发送你的位置，即可出现在地图上。';

  @override
  String mapInviteSent(int count) {
    return '已发送邀请：$count';
  }

  @override
  String get mapInviteFailed => '无法发送邀请';

  @override
  String mapPeopleVisible(int count) {
    return '共享位置：$count';
  }

  @override
  String get mapCenterMe => '定位到我';

  @override
  String get mapNoSharedLocations => '暂无共享位置';

  @override
  String get mapNoSharedLocationsHint => '联系人在聊天中发送位置后会出现在这里。';

  @override
  String get mapWebHintTitle => '附近的连接';

  @override
  String get mapWebHint => '连线表示距离远近，而非消息路由。';

  @override
  String get mapOpenProfile => '资料';

  @override
  String get mapLocationPrivacyOff => '地图位置已隐藏';

  @override
  String get mapLocationPrivacyOffHint => '在“隐私”中开启“在地图上显示我”即可显示你的标记。';

  @override
  String get mapYouOnMap => '你的位置在此设备上可见';

  @override
  String get locationSharingDisabled => '请先在“隐私”中开启“在地图上显示我”。';

  @override
  String get mapLocationDenied => '位置访问已关闭';

  @override
  String get mapLocationServiceOff => '开启定位服务以显示你自己';

  @override
  String get mapLocationUnavailable => '无法确定你的位置';

  @override
  String get mapDistanceUnknown => '距离未知';

  @override
  String mapDistanceMetres(int metres) {
    return '$metres 米外';
  }

  @override
  String mapDistanceKilometres(String kilometres) {
    return '$kilometres 公里外';
  }

  @override
  String get mapUpdatedNow => '刚刚共享';

  @override
  String mapUpdatedMinutes(int minutes) {
    return '$minutes 分钟前共享';
  }

  @override
  String mapUpdatedHours(int hours) {
    return '$hours 小时前共享';
  }

  @override
  String get contactsTitle => '联系人';

  @override
  String get contactsSubtitle => '所有与你聊过天的人';

  @override
  String get contactsSearchHint => '搜索联系人…';

  @override
  String get contactsEmptyTitle => '暂无联系人';

  @override
  String get contactsEmptyHint => '开始一段对话，对方就会出现在这里。';

  @override
  String get contactsSearchEmpty => '没有匹配的联系人';

  @override
  String get contactsTabContacts => '联系人';

  @override
  String get contactsTabCalls => '通话';

  @override
  String get callsFilterAll => '全部';

  @override
  String get callsFilterMissed => '未接';

  @override
  String get callsEmptyTitle => '暂无通话';

  @override
  String get callsEmptyHint => '呼入、呼出和未接通话会显示在这里。';

  @override
  String get callsMissedEmpty => '没有未接来电';

  @override
  String get callsCallBack => '呼叫';

  @override
  String get contactProfileChat => '聊天';

  @override
  String get contactProfileCall => '通话';

  @override
  String get contactProfileRadio => '对讲';

  @override
  String get contactProfileSecurity => '安全';

  @override
  String get contactProfileActions => '联系人操作';

  @override
  String get contactProfileVerify => '验证';

  @override
  String get contactProfileCopyId => '复制联系人 ID';

  @override
  String get contactProfileIdCopied => '已复制联系人 ID';

  @override
  String get contactProfileId => '联系人 ID';

  @override
  String get contactProfileVerifyHint => '比对加密指纹以确认此人身份。';

  @override
  String get chatsTitle => '聊天';

  @override
  String get chatsSubtitle => 'Mesh · 端到端加密';

  @override
  String get chatsEmptyTitle => '暂无对话';

  @override
  String get chatsEmptyHint => '在“附近”标签页中打开一个联系人即可开始聊天。';

  @override
  String get chatsFilterAll => '全部';

  @override
  String get chatsFilterUnread => '未读';

  @override
  String get chatsFilterMesh => 'Mesh';

  @override
  String get chatsFilterFavorites => '星标';

  @override
  String get chatsFolderDirect => '私聊';

  @override
  String get chatsFolderChannels => '频道';

  @override
  String get chatsFolderOnline => '可联系';

  @override
  String get chatsFoldersTitle => '文件夹';

  @override
  String get chatsFoldersHint => '文件夹只是此列表的筛选视图，不会移动聊天。开启你希望显示在聊天上方的文件夹。';

  @override
  String get chatsSearchHint => '搜索聊天…';

  @override
  String get chatsStatusViaMesh => '经 Mesh';

  @override
  String get chatsStatusOffline => '离线';

  @override
  String get peerKeyRotated => '密钥已更改——请重新验证';

  @override
  String get peersTitle => '附近';

  @override
  String get peersSubtitle => 'Bluetooth 范围内的设备';

  @override
  String get peersEmpty => '正在寻找附近的人…';

  @override
  String peersHopsOne(int n) {
    return '$n 跳';
  }

  @override
  String peersHopsOther(int n) {
    return '$n 跳';
  }

  @override
  String get blePermissionTitle => '需要 Bluetooth 权限';

  @override
  String get blePermissionHint => 'Cubechat 需要 Bluetooth 来发现附近的人并发送消息——无需互联网。';

  @override
  String get blePermissionGrant => '授予权限';

  @override
  String get blePermissionOpenSettings => '打开设置';

  @override
  String get blePermissionDeniedHint => '权限被拒绝。请打开设置以允许访问 Bluetooth。';

  @override
  String get bleAdapterOffTitle => 'Bluetooth 已关闭';

  @override
  String get bleAdapterOffHint => '开启 Bluetooth 以查看附近的设备。';

  @override
  String get bleUnsupportedTitle => 'Bluetooth LE 不可用';

  @override
  String get bleUnsupportedHint => '此设备或平台不支持 Bluetooth 低功耗（BLE）。请在手机上尝试。';

  @override
  String get bleScanning => '正在扫描…';

  @override
  String get bleRetry => '重试';

  @override
  String get bleEnable => '开启';

  @override
  String get bleConnectFailed => '无法连接。对方可能超出范围，或其 Bluetooth 地址已变更。';

  @override
  String get bleSignal => '信号';

  @override
  String get bleConnect => '连接';

  @override
  String get bleConnected => '已连接';

  @override
  String get bleVerified => '已验证';

  @override
  String get editorAdjustBrightness => '亮度';

  @override
  String get editorAdjustContrast => '对比度';

  @override
  String get editorAdjustSaturation => '饱和度';

  @override
  String get editorToolCrop => '裁剪';

  @override
  String get editorToolDraw => '涂鸦';

  @override
  String get editorToolAdjust => '调整';

  @override
  String get editorTabSticker => '贴纸';

  @override
  String get editorTabText => '文字';

  @override
  String get editorPenPen => '钢笔';

  @override
  String get editorPenMarker => '马克笔';

  @override
  String get editorPenNeon => '霓虹';

  @override
  String get editorPenArrow => '箭头';

  @override
  String get editorPenBlur => '模糊';

  @override
  String get editorPenEraser => '橡皮擦';

  @override
  String get editorLevel => '校平';

  @override
  String get editorTextHint => '照片上的文字';

  @override
  String get editorCropFree => '自由';

  @override
  String get editorRemove => '移除';

  @override
  String get notificationUnknownSender => '新消息';

  @override
  String get bleUnknownPeer => '未知设备';

  @override
  String get bleBroadcasting => '广播中';

  @override
  String bleConnectedCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '已连接 $n 个中心设备',
      one: '已连接 1 个中心设备',
      zero: '无中心设备',
    );
    return '$_temp0';
  }

  @override
  String get verifyTitle => '验证对方';

  @override
  String get verifyIntro =>
      '当面或通过语音通话与对方比对这两个指纹。如果双方看到的完全一致，即可确认 Noise 握手未被篡改。';

  @override
  String get verifyMine => '你的指纹';

  @override
  String verifyTheirs(String name) {
    return '$name 的指纹';
  }

  @override
  String get verifyMarkAsVerified => '标记为已验证';

  @override
  String get verifyAlreadyDone => '已验证此联系人。';

  @override
  String get verifyRevoke => '撤销';

  @override
  String verifyDoneSnack(String name) {
    return '已将 $name 标记为已验证';
  }

  @override
  String get chatInputHint => '消息';

  @override
  String get chatSend => '发送';

  @override
  String get chatToday => '今天';

  @override
  String get chatYesterday => '昨天';

  @override
  String get chatDelivered => '已送达';

  @override
  String get chatRead => '已读';

  @override
  String get chatSending => '发送中';

  @override
  String get chatWaitingForConnection => '等待连接';

  @override
  String sendQueueCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 条消息等待连接',
      one: '1 条消息等待连接',
    );
    return '$_temp0';
  }

  @override
  String sendQueueSlowNetwork(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '网络较慢——正在发送 $count 条消息',
      one: '网络较慢——正在发送 1 条消息',
    );
    return '$_temp0';
  }

  @override
  String get sendQueueTitle => '等待发送';

  @override
  String get sendQueueHint => '一旦有可用的线路——附近的 Bluetooth 或互联网——它们就会自动发出，无需任何操作。';

  @override
  String get sendQueueRetry => '立即尝试';

  @override
  String get sendQueueCancel => '取消发送';

  @override
  String get sendQueueCancelled => '未发送——已撤回';

  @override
  String get sendQueueTooLate => '无法撤回：消息已发出';

  @override
  String get chatEncryptedNotice => '消息使用 Noise 协议进行端到端加密。';

  @override
  String get chatSessionHandshaking => '正在建立安全通道…';

  @override
  String get chatSessionEstablished => '已加密 · Noise XX';

  @override
  String get chatSessionFailed => '连接失败';

  @override
  String get presenceOnline => '在线';

  @override
  String get presenceOffline => '离线';

  @override
  String get chatSessionFingerprintPending => '握手完成后将显示指纹。';

  @override
  String get chatEmptyEstablished => '安全通道已建立。发送一条消息开始对话吧。';

  @override
  String get chatEmptyHandshaking => '等待对方完成握手…';

  @override
  String get chatEmptyTitle => '这里还没有消息';

  @override
  String get chatEmptyGreetHint => '发送一条消息，或点按 Kubi 打个招呼。';

  @override
  String get profileTitle => '我的';

  @override
  String get profileNickname => '昵称';

  @override
  String get profileNicknameEditTitle => '设置昵称';

  @override
  String get profileNicknameHint => '其他人在 Mesh 网络中看到的你';

  @override
  String get profileNicknameSave => '保存';

  @override
  String get profileFingerprint => '公钥指纹';

  @override
  String get profileLanguage => '语言';

  @override
  String get profileLanguageEn => '英语';

  @override
  String get profileLanguageUk => '乌克兰语';

  @override
  String get profileTransport => '传输方式';

  @override
  String get profileTransportMesh => 'Bluetooth Mesh';

  @override
  String get profileBackground => '后台保持在线';

  @override
  String get profileBackgroundSubtitle => '应用关闭时仍可接收消息';

  @override
  String get profileBatteryExempt => '关闭电池优化';

  @override
  String get profileAbout => '关于';

  @override
  String profileVersion(String v) {
    return '版本 $v';
  }

  @override
  String get rotateKeysTitle => '更换账号密钥';

  @override
  String get rotateKeysHint => '如果登录你账号的设备丢失或被盗';

  @override
  String get rotateKeysConfirmTitle => '更换账号密钥？';

  @override
  String get rotateKeysConfirmBody =>
      '你的联系人会收到新密钥并保留聊天记录，但每个人都会被要求重新验证你的密钥。账号的其他所有设备都将退出登录；需要保留的设备请用这部手机重新关联。使用旧版 CubeChat 的联系人在更新前将无法联系你。频道密钥保持不变。';

  @override
  String get rotateKeysConfirmAction => '更换密钥';

  @override
  String get rotateKeysWorking => '正在更换密钥…';

  @override
  String rotateKeysDone(int sent, int total) {
    return '新密钥已生效。已通知 $sent/$total 位联系人';
  }

  @override
  String get rotateKeysSlow => '新密钥已生效。部分联系人未及时确认；中继会为他们保留通知';

  @override
  String get profileEmergencyWipe => '紧急清除';

  @override
  String get profileEmergencyWipeConfirm => '清除所有数据？';

  @override
  String get profileEmergencyWipeConfirmHint => '这将删除你的身份、联系人列表和聊天记录，且无法撤销。';

  @override
  String get profileEmergencyWipeAction => '清除';

  @override
  String get cancel => '取消';

  @override
  String get copy => '复制';

  @override
  String get copied => '已复制';

  @override
  String get channelsNewTitle => '新建频道';

  @override
  String get channelsNewTooltip => '新建频道';

  @override
  String get channelNameLabel => '频道名称';

  @override
  String get channelPasswordLabel => '密码（可选）';

  @override
  String get channelJoinAction => '加入';

  @override
  String get channelNameHint => '输入相同名称和密码的人都会进入同一个房间。没有任何服务器保存成员列表。';

  @override
  String get channelPasswordHint => '密码就是密钥。没有密码时，附近任何知道房间名称的人都能进入。';

  @override
  String get channelSubtitle => '群组频道 · 共享密钥';

  @override
  String get channelMute => '静音';

  @override
  String get channelUnmute => '取消静音';

  @override
  String channelMutedUntil(String time) {
    return '静音至 $time';
  }

  @override
  String get channelMuteFor => '静音时长…';

  @override
  String channelMuteMinutes(int minutes) {
    return '$minutes 分钟';
  }

  @override
  String channelMuteHours(int hours) {
    return '$hours 小时';
  }

  @override
  String channelMuteDays(int days) {
    return '$days 天';
  }

  @override
  String get channelMuteForever => '直到我重新开启';

  @override
  String get channelCommunity => '评论';

  @override
  String get channelCommunityOpen => '打开讨论';

  @override
  String channelCommunitySubtitle(String channel) {
    return '$channel 的讨论';
  }

  @override
  String get channelBackToChannel => '返回频道';

  @override
  String get channelMemberActions => '成员';

  @override
  String get channelRemoveMember => '从频道移除';

  @override
  String get channelRemoveMemberHint =>
      '这里将不再接受其发布的内容。但无法阻止其凭名称重新加入——共享密钥就是唯一的成员资格。';

  @override
  String get channelMuteMember => '禁言时长…';

  @override
  String get channelUnmuteMember => '允许再次发言';

  @override
  String channelMemberRemoved(String name) {
    return '已移除 $name';
  }

  @override
  String channelMemberMuted(String name) {
    return '已禁言 $name';
  }

  @override
  String channelMemberCleared(String name) {
    return '$name 可以再次发言';
  }

  @override
  String get channelMemberMutedNote => '已禁言';

  @override
  String get channelShareHistory => '分享历史记录';

  @override
  String get channelShareHistoryHint =>
      '将此房间最近的帖子重新广播，让后来加入的人也能看到。已在房间里的人不会收到任何新内容。';

  @override
  String channelHistoryShared(int count) {
    return '已提供 $count 条帖子';
  }

  @override
  String get channelHistoryNothing => '暂无可分享的内容';

  @override
  String get channelHistoryAuto => '向新成员提供历史记录';

  @override
  String get channelHistoryAutoHint =>
      '当有新成员出现在房间中时，最近的帖子会自动发送给对方。目前仅限文字——照片以分块流发送，无法在不向所有人重复发送的情况下重播。';

  @override
  String get channelPostComments => '评论';

  @override
  String get channelNoComments => '还没有人评论这条帖子';

  @override
  String get channelCommentHint => '评论';

  @override
  String get channelMuteCustom => '多长时间？';

  @override
  String get channelMuteCustomHint => '小时';

  @override
  String get chatPinnedManage => '置顶';

  @override
  String get chatPeekOpen => '打开聊天';

  @override
  String get chatPeekPin => '置顶';

  @override
  String get chatPeekUnpin => '取消置顶';

  @override
  String get chatPeekUnmute => '取消静音';

  @override
  String get chatPeekMarkRead => '标为已读';

  @override
  String get chatDeleteForMeHint => '从这部手机上删除并取消置顶。对方保留其副本。';

  @override
  String get pushWakeTitle => '唤醒这部手机';

  @override
  String get pushWakeHint =>
      '一台小型服务器会在中继上留意你的地址，有消息到达时唤醒这部手机，因此即使应用已关闭也能通知你。它看不到任何消息或密钥——只知道你的地址收到了东西以及收到的时间。中继本来就知道这些；这只是多了一个知道的地方。';

  @override
  String get pushWakeDeniedTitle => '通知已关闭';

  @override
  String get pushWakeDeniedHint =>
      '系统已被拒绝过一次，不会再询问，因此只能在“设置”中重新开启——依次进入 cubechat 和“通知”。完成后请回到这里。';

  @override
  String get pushWakeRefused => '未允许通知';

  @override
  String get privacyForwardLinkTitle => '转发时链接回资料';

  @override
  String get privacyForwardLinkHint =>
      '当有人转发你的消息时，消息上方的那一行可以打开你的资料。关闭后，对方只能看到你的名字，无法点按。这只是对其应用的请求，本应用无法强制执行。';

  @override
  String get privacyShareSheetTitle => '分享菜单中的聊天';

  @override
  String get privacyShareSheetOnHint =>
      '你最近四个聊天的名称会提供给 Android，以便从任何应用发送给他们。应用锁不会隐藏这些名称。';

  @override
  String get privacyShareSheetOffHint =>
      '不向 Android 提供任何信息。分享到 CubeChat 时需要你选择聊天。';

  @override
  String get privacyCallsTitle => '接听来电';

  @override
  String get privacyCallsOnHint => '你的联系人可以给你打电话。如需拒绝某个人，请打开其资料。';

  @override
  String get privacyCallsOffHint => '除你在其资料中允许的人外，任何人都无法给你打电话。被拒绝的来电在对方看来是忙线。';

  @override
  String get chatsStatusChannel => '频道';

  @override
  String get channelInviteTitle => '添加成员';

  @override
  String get channelInviteAction => '邀请';

  @override
  String get channelInviteEmpty => '暂无已知联系人。请先在“附近”标签页中认识一个人。';

  @override
  String get channelInviteSent => '邀请已发送';

  @override
  String get channelInviteNoneSent => '目前无法联系到任何人';

  @override
  String get channelNameTooLong => '频道名称过长';

  @override
  String get chatsActionFavorite => '设为星标';

  @override
  String get chatsActionUnfavorite => '取消星标';

  @override
  String get chatsActionDelete => '删除聊天';

  @override
  String get chatsDeleteTitle => '删除此聊天？';

  @override
  String chatsDeleteManyHint(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '将清空 $count 个对话。联系人会保留，无需重新交换代码即可再次给他们发消息。',
    );
    return '$_temp0';
  }

  @override
  String get chatsDeletedToast => '聊天已删除。';

  @override
  String chatsDeletedManyToast(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '已删除 $count 个聊天。',
    );
    return '$_temp0';
  }

  @override
  String get undo => '撤销';

  @override
  String get chatsDeletePeerHint => '将清空对话。联系人会保留，无需重新交换代码即可再次给对方发消息。';

  @override
  String get chatsDeleteChannelHint => '将退出频道并删除其历史记录。重新加入需要再次输入密钥。';

  @override
  String get chatsDeleteForThemToo => '同时为对方删除';

  @override
  String get chatsDeleteForThemHint =>
      '请求对方的应用也清空整个对话，包括对方发送的内容。在频道中，只会撤回你自己的消息。';

  @override
  String get chatEditAction => '编辑';

  @override
  String get chatEditTitle => '编辑消息';

  @override
  String get chatEditSave => '保存';

  @override
  String get chatEdited => '已编辑';

  @override
  String get chatDeleteAction => '删除';

  @override
  String get chatDeleteTitle => '删除消息？';

  @override
  String get chatDeleteForMe => '仅为我删除';

  @override
  String get chatDeleteForEveryone => '为所有人删除';

  @override
  String get chatPinTitle => '置顶消息？';

  @override
  String get chatPinForBoth => '为双方置顶';

  @override
  String get chatPinForMe => '仅为我置顶';

  @override
  String get chatReplyAction => '回复';

  @override
  String chatReplyingTo(String name) {
    return '回复 $name';
  }

  @override
  String get chatReplyYou => '自己';

  @override
  String get chatCopyAction => '复制';

  @override
  String get chatCopied => '已复制';

  @override
  String get chatForwardAction => '转发';

  @override
  String get chatForwardTitle => '转发到';

  @override
  String get shareIntoTitle => '发送到';

  @override
  String get shareNearbyAirDrop => '通过 AirDrop 发给附近的人';

  @override
  String get shareNearbyAirDropHint => '无需互联网——发给身边的人';

  @override
  String get shareSent => '已发送';

  @override
  String get shareFailed => '部分内容未能发送';

  @override
  String get chatForwardEmpty => '暂无其他聊天';

  @override
  String chatForwardSendCount(int count) {
    return '发送（$count）';
  }

  @override
  String chatForwardSentCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '已转发到 $count 个聊天',
    );
    return '$_temp0';
  }

  @override
  String chatForwardSent(String name) {
    return '已转发给 $name';
  }

  @override
  String chatSentAt(String time) {
    return '发送于 $time';
  }

  @override
  String chatReadAt(String time) {
    return '已读于 $time';
  }

  @override
  String get chatPinAction => '置顶';

  @override
  String get chatUnpinAction => '取消置顶';

  @override
  String chatPinnedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 条置顶消息',
      one: '1 条置顶消息',
      zero: '没有置顶消息',
    );
    return '$_temp0';
  }

  @override
  String get chatNoPins => '这里没有置顶内容';

  @override
  String get chatUnpinAll => '取消置顶所有消息';

  @override
  String get chatShowAllPins => '所有置顶消息';

  @override
  String get chatUnpinConfirm => '取消置顶此消息？';

  @override
  String get chatUnpinConfirmHint => '此聊天中所有人都将看不到这条置顶。';

  @override
  String get chatPinnedTitle => '置顶消息';

  @override
  String get chatPinnedGone => '该消息已不在此聊天中';

  @override
  String get peerBlock => '屏蔽';

  @override
  String get peerUnblock => '取消屏蔽';

  @override
  String get peerMute => '静音';

  @override
  String get peerUnmute => '取消静音';

  @override
  String get peerBlockedNote => '已屏蔽——其消息将被丢弃。';

  @override
  String get relaysTitle => '互联网备用通道';

  @override
  String get relaysCardTitle => '通过互联网联系对方';

  @override
  String get relaysCardSubtitle => 'Bluetooth 无法送达时，通过 Nostr 中继发送';

  @override
  String get relaysExplainer =>
      '消息仍保持端到端加密——中继传送的只是与 Bluetooth 相同的密封数据帧。但它能知道哪两个密钥在通信以及通信时间。默认关闭。';

  @override
  String get relaysMyAddress => '你的中继地址';

  @override
  String get relaysCopied => '已复制';

  @override
  String get circleLensTitle => '圆形视频使用前置摄像头';

  @override
  String get circleLensFrontHint => '圆形视频消息使用朝向你的摄像头录制。';

  @override
  String get circleLensBackHint => '圆形视频消息使用后置摄像头录制，用于展示你眼前的景象。';

  @override
  String get channelCloseTitle => '为所有人关闭此房间';

  @override
  String get channelCloseSubtitle => '从每位成员的手机上移除。只有你能执行此操作。';

  @override
  String get channelCloseConfirm =>
      '房间、其中的消息和成员将从所有拥有它的手机上消失。不会将任何人拒之门外：密钥来自名称，任何记得名称的人都能再次打开一个空房间。';

  @override
  String get channelCloseAction => '关闭房间';

  @override
  String get circleHint => '松开发送 · 左滑取消';

  @override
  String get circleHintLocked => '完成后点按发送';

  @override
  String get circleNeedsCamera => '圆形视频需要摄像头和麦克风';

  @override
  String get circleFailed => '无法录制该圆形视频';

  @override
  String get relaysListLabel => '中继';

  @override
  String get relaysLaneMedia => '媒体中继';

  @override
  String get relaysLaneMediaNote => '照片、文件和视频通过这些中继传输，这样传输文件不会拖慢对话。';

  @override
  String get relaysLaneLocation => '位置中继';

  @override
  String get relaysLaneLocationNote => '地图信标通过这些中继传输，与其他内容分开。';

  @override
  String get relaysAdd => '添加中继';

  @override
  String get relaysAddHint => 'wss://relay.example.com';

  @override
  String get relaysInvalidUrl => '请输入 wss:// 或 ws:// 地址';

  @override
  String get relaysRemove => '移除';

  @override
  String get relaysStateConnected => '已连接';

  @override
  String get relaysStateConnecting => '正在连接…';

  @override
  String get relaysStateFailed => '无法访问';

  @override
  String get relaysStateIdle => '关闭';

  @override
  String get relaysEmpty => '未配置中继——备用通道保持关闭。';

  @override
  String get contactTitle => '联系人名片';

  @override
  String get contactMineLabel => '你的名片';

  @override
  String get contactMineExplainer =>
      '将它发送给不在 Bluetooth 范围内的人。名片包含你的密钥和中继地址——足以让对方通过互联网与你开始加密聊天。';

  @override
  String get contactCopy => '复制';

  @override
  String get contactShare => '分享';

  @override
  String get contactCopied => '名片已复制';

  @override
  String get contactShareSubject => '我的 cubechat 联系人名片';

  @override
  String get contactAddLabel => '添加联系人';

  @override
  String get contactAddHint => '粘贴联系人名片';

  @override
  String get contactAddAction => '添加';

  @override
  String get contactPaste => '粘贴';

  @override
  String contactAdded(String name) {
    return '已添加 $name';
  }

  @override
  String get contactInvalid => '这不是有效的联系人名片';

  @override
  String get contactOwnCard => '这是你自己的名片';

  @override
  String get contactUnverified =>
      '以这种方式添加的联系人最初处于未验证状态。任何人都能生成名片并写上任意名字，因此在信任其身份之前，请当面或通过通话比对指纹。';

  @override
  String get contactRelayOff => '互联网备用通道已关闭，因此名片暂时无法联系到任何人。';

  @override
  String get contactRelayEnable => '开启';

  @override
  String get profileContactCard => '联系人名片';

  @override
  String get chatsAddContactTooltip => '通过名片添加联系人';

  @override
  String get chatsMenuTooltip => '更多';

  @override
  String get chatsMenuAddContact => '添加联系人';

  @override
  String get chatsMenuNewChannel => '新建频道';

  @override
  String get profileDiscoverable => '允许附近的人发现';

  @override
  String get profileDiscoverableOnHint => '范围内的任何人都能找到你';

  @override
  String get profileDiscoverableOffHint => '只有你的联系人能联系你';

  @override
  String get profileDiscoverableExplainer =>
      '开启时，你的公告以明文广播，陌生人走近就能认识你——但任何监听者都能记录你的密钥和名字。关闭时，同样的信息只以密封形式发送给已有联系人，你的路由 ID 也无法被关联。新认识的人则需要联系人名片。';

  @override
  String get voiceHoldHint => '按住录制语音消息';

  @override
  String get voiceTrimPlay => '播放';

  @override
  String get voiceTrimPause => '暂停';

  @override
  String get voiceTrimDiscard => '丢弃录音';

  @override
  String voiceTrimSelection(String duration) {
    return '将发送 $duration';
  }

  @override
  String get profileLastSeen => '显示最后上线时间';

  @override
  String get profileLastSeenOnHint => '联系人可以看到你何时在使用应用';

  @override
  String get profileLastSeenOffHint => '没有人能看到你的上线时间，你也看不到别人的：只能看到谁在线';

  @override
  String get profileMapLocation => '在地图上显示我';

  @override
  String get profileMapLocationOnHint => '可手动分享位置，你的标记会显示在地图上';

  @override
  String get profileMapLocationOffHint => '应用不请求位置，你的标记保持隐藏';

  @override
  String get desktopAutostartTitle => '随 Windows 启动';

  @override
  String get desktopAutostartHint => 'CubeChat 在系统托盘中待命，即使窗口关闭，通话和消息也能到达这台电脑';

  @override
  String get trayOpen => '打开 CubeChat';

  @override
  String get trayQuit => '退出';

  @override
  String get callDirectTitle => '直连通话';

  @override
  String get callDirectOnHint => '更快，但对方会知道你的 IP 地址';

  @override
  String get callDirectOffHint => '通话经由我们的中继：对方看不到你的 IP，中继也无法听到通话内容';

  @override
  String get profileReadReceipts => '发送已读回执';

  @override
  String get profileReadReceiptsOnHint => '发送者可以看到你已读';

  @override
  String get profileReadReceiptsOffHint => '你不再发送已读时间，但仍能看到别人的';

  @override
  String get profilePrivacyExplainer =>
      '最后上线时间是双向的：隐藏自己的状态后，你也将看不到其他人的。已读回执只控制你发送的内容。消息送达不受影响。';

  @override
  String get chatTimerAction => '定时';

  @override
  String get chatTimerRemove => '移除定时';

  @override
  String get chatTimerTitle => '此消息删除时间';

  @override
  String chatTimerSet(String time) {
    return '此消息将在 $time 后删除';
  }

  @override
  String get chatTimerLocalHint => '仅限此设备——对方的副本归对方所有';

  @override
  String get contactTagAction => '标签';

  @override
  String get contactTagRemove => '移除标签';

  @override
  String get contactTagTitle => '选择标签';

  @override
  String get contactTagAll => '全部';

  @override
  String get quietHoursTitle => '免打扰时段';

  @override
  String get quietHoursHint => '消息照常接收，手机保持安静';

  @override
  String get quietHoursFrom => '从';

  @override
  String get quietHoursTo => '至';

  @override
  String get notifPreviewTitle => '通知中显示';

  @override
  String get notifPreviewFull => '名字和内容';

  @override
  String get notifPreviewNameOnly => '仅名字';

  @override
  String get notifPreviewHidden => '不显示';

  @override
  String get notifPreviewHint => '即使开启了应用锁，通知仍会显示在锁屏上，并对有通知访问权限的应用可见';

  @override
  String get notifPreviewNewMessage => '新消息';

  @override
  String get appLockTitle => '应用锁';

  @override
  String get appLockHint => '打开应用时要求输入密码';

  @override
  String get appLockPrompt => '输入密码';

  @override
  String get appLockUnlock => '解锁';

  @override
  String get appLockWrong => '密码错误';

  @override
  String get appLockSetTitle => '设置密码';

  @override
  String get appLockSetHint => '至少四位数字。密码无法找回。';

  @override
  String get appLockOffTitle => '关闭应用锁';

  @override
  String get appLockOffHint => '输入当前密码';

  @override
  String get appLockOn => '应用锁已开启';

  @override
  String get appLockOff => '应用锁已关闭';

  @override
  String get avatarSet => '选择照片';

  @override
  String get avatarChange => '更换照片';

  @override
  String get avatarView => '查看照片';

  @override
  String get profileCoverPhoto => '头像照片，双击放大';

  @override
  String get profileCoverMenu => '照片选项';

  @override
  String get avatarSaved => '已保存到相册';

  @override
  String get avatarRemove => '移除照片';

  @override
  String get avatarRemoveConfirm => '头像将从此设备上删除，并恢复为自动生成的渐变背景。';

  @override
  String get avatarFailed => '无法读取该图片';

  @override
  String get fileOpenHint => '点按打开';

  @override
  String get fileMissing => '该文件已不可用';

  @override
  String get fileNoHandlerTitle => '没有应用能打开此文件';

  @override
  String get fileNoHandlerHint => '已安装的应用都无法处理此文件类型。你可以将其发送到其他应用。';

  @override
  String get fileRequestedAgain => '已请求对方重新发送';

  @override
  String get fileOpenFailed => '无法打开此文件';

  @override
  String get fileShareAction => '发送到应用';

  @override
  String fileTooLargeMesh(int limit) {
    return '文件过大——通过 Mesh 网络最多 $limit MB';
  }

  @override
  String fileTooLargeRelay(int limit) {
    return '通过互联网最多可发送 $limit MB。靠近接收方即可发送更大的文件。';
  }

  @override
  String get mediaSendOriginal => '原图';

  @override
  String get attachFile => '文件';

  @override
  String get attachGallery => '相册';

  @override
  String get attachCamera => '相机';

  @override
  String get cameraUnavailable => '相机不可用';

  @override
  String get profileEditName => '名字';

  @override
  String get profileMyCard => '名片';

  @override
  String get mediaCaptionHint => '添加说明…';

  @override
  String get mediaDiscardTitle => '放弃所选内容？';

  @override
  String get mediaDiscardMessage => '关闭相册并放弃已选的照片？';

  @override
  String get mediaDiscardConfirm => '放弃';

  @override
  String get mediaPhotosAccessOff => '照片访问已关闭';

  @override
  String get mediaPhotosAccessOffHint =>
      'CubeChat 目前只能看到视频。请在系统设置中允许访问照片以显示你的图片。';

  @override
  String get mediaVideosOnly => '仅显示视频——请允许访问照片';

  @override
  String get mediaOpenSettings => '打开设置';

  @override
  String get mediaTakePhoto => '拍照';

  @override
  String get contactProfileAutoDelete => '自动删除聊天';

  @override
  String get contactProfileAutoDeleteTitle => '自动删除消息';

  @override
  String get contactProfileAutoDeleteOff => '关闭';

  @override
  String get contactProfileAutoDeleteOneDay => '1 天后';

  @override
  String get contactProfileAutoDeleteSevenDays => '7 天后';

  @override
  String get contactProfileAutoDeleteThirtyDays => '30 天后';

  @override
  String contactProfileAutoDeleteUpdated(String period) {
    return '自动删除：$period';
  }

  @override
  String get contactProfileShare => '分享联系人';

  @override
  String get contactProfileShareTitle => '将联系人发送给';

  @override
  String get contactProfileShareEmpty => '暂无其他聊天';

  @override
  String contactProfileShareSent(String name) {
    return '已发送给 $name';
  }

  @override
  String get contactProfileRestrictCopying => '禁止复制';

  @override
  String get contactProfileAllowCopying => '允许复制';

  @override
  String get contactHideAvatar => '隐藏我的头像';

  @override
  String get contactShowAvatar => '显示我的头像';

  @override
  String get contactHideLastSeen => '隐藏我的上线时间';

  @override
  String get contactShowLastSeen => '显示我的上线时间';

  @override
  String get contactHideReadReceipts => '隐藏我的已读时间';

  @override
  String get contactShowReadReceipts => '显示我的已读时间';

  @override
  String get contactHiddenFromThem => '对此联系人隐藏';

  @override
  String get contactRefuseCalls => '不接听其来电';

  @override
  String get contactAllowCalls => '接听其来电';

  @override
  String get contactCallsException => '你的通话设置的例外';

  @override
  String get contactProfileCopyingRestricted => '已禁止复制和转发';

  @override
  String get contactProfileCopyingRestrictedByPeer => '已被对方禁止';

  @override
  String get contactProfileCopyingAllowed => '允许复制和转发';

  @override
  String get contactProfileDelete => '从联系人中删除';

  @override
  String get contactProfileRestore => '重新添加到联系人';

  @override
  String get contactProfileRestoreDone => '已重新添加到联系人';

  @override
  String get contactProfileDeleteTitle => '删除联系人？';

  @override
  String contactProfileDeleteMessage(String name) {
    return '$name 将从“联系人”中消失。聊天记录仍保留在此设备上。';
  }

  @override
  String get contactProfileMedia => '媒体';

  @override
  String get contactProfileVoiceMessages => '语音消息';

  @override
  String get contactProfileStickers => '贴纸';

  @override
  String get contactProfileNoStickers => '暂无贴纸';

  @override
  String get contactProfileNoMedia => '暂无媒体';

  @override
  String get contactProfileNoVoiceMessages => '暂无语音消息';

  @override
  String get contactProfileOpen => '打开资料';

  @override
  String autoDeleteDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 天',
    );
    return '$_temp0';
  }

  @override
  String autoDeleteHours(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 小时',
    );
    return '$_temp0';
  }

  @override
  String autoDeleteMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 分钟',
    );
    return '$_temp0';
  }

  @override
  String autoDeleteSeconds(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 秒',
    );
    return '$_temp0';
  }

  @override
  String get autoDeleteCustom => '自定义…';

  @override
  String get autoDeleteCustomHint => '数量';

  @override
  String get autoDeleteUnitMinutes => '分钟';

  @override
  String get autoDeleteUnitHours => '小时';

  @override
  String get autoDeleteUnitDays => '天';

  @override
  String get contactProfileAutoDeleteSet => '设置';

  @override
  String get contactProfileFiles => '文件';

  @override
  String get contactProfileNoFiles => '暂无文件';

  @override
  String get contactProfileLinks => '链接';

  @override
  String get contactProfileNoLinks => '暂无链接';

  @override
  String get contactProfilePolls => '投票';

  @override
  String get contactProfileNoPolls => '暂无投票';

  @override
  String get presenceRecently => '最近在线';

  @override
  String get presenceJustNow => '刚刚在线';

  @override
  String presenceHoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 小时前在线',
    );
    return '$_temp0';
  }

  @override
  String presenceYesterdayAt(String time) {
    return '昨天 $time 在线';
  }

  @override
  String presenceOnWeekday(String day) {
    String _temp0 = intl.Intl.selectLogic(
      day,
      {
        '1': '周一在线',
        '2': '周二在线',
        '3': '周三在线',
        '4': '周四在线',
        '5': '周五在线',
        '6': '周六在线',
        '7': '周日在线',
        'other': '本周在线',
      },
    );
    return '$_temp0';
  }

  @override
  String presenceWeeksAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 周前在线',
    );
    return '$_temp0';
  }

  @override
  String presenceMonthsAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 个月前在线',
    );
    return '$_temp0';
  }

  @override
  String get presenceLongAgo => '很久以前在线';

  @override
  String presenceMinutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 分钟前在线',
    );
    return '$_temp0';
  }

  @override
  String chatReadByCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 人已读',
    );
    return '$_temp0';
  }

  @override
  String get chatsSearchFrequent => '常用联系人';

  @override
  String get chatsSearchRecent => '最近';

  @override
  String get chatsSearchClear => '清除';

  @override
  String get chatsSearchStartHint => '按名称搜索聊天，或按关键词搜索任何消息。';

  @override
  String get chatsSearchEmpty => '没有匹配结果';

  @override
  String get chatRoutesTitle => '消息如何送达对方';

  @override
  String get chatRoutesBluetoothHint => '直接发到对方手机，不经过互联网';

  @override
  String get chatRoutesMeshHint => '由中间的手机转发';

  @override
  String get chatRoutesInternetHint => '附近没有人时，经由中继';

  @override
  String get chatRoutesHint => '每条消息都会根据当时可用的线路单独选择路径。';

  @override
  String get chatRoutesPreferTitle => '优先尝试';

  @override
  String get chatRoutesPreferMesh => 'Bluetooth 优先';

  @override
  String get chatRoutesPreferMeshHint => '同处一室时更快，不耗流量，不向中继透露任何信息';

  @override
  String get chatRoutesPreferRelay => '互联网优先';

  @override
  String get chatRoutesPreferRelayHint => '适用于 Bluetooth 信号差而网络良好时';

  @override
  String get chatRoutesPreferNote => '这只是偏好，而非锁定。如果所选线路不可用，消息仍会通过另一条线路发送。';

  @override
  String get deadmanTitle => '长期未用时清除';

  @override
  String get deadmanOff => '关闭';

  @override
  String deadmanDays(int days) {
    return '$days 天后';
  }

  @override
  String get deadmanHint =>
      '如果这么长时间都没人打开此应用，下次打开时其中的所有数据都会被清除。它无法事先提醒你——这正是它的意义所在。';

  @override
  String chatForwardedFrom(String name) {
    return '转发自 $name';
  }

  @override
  String appLockWait(String left) {
    return '尝试次数过多——请等待 $left';
  }

  @override
  String get appLockGraceTitle => '要求输入密码';

  @override
  String get appLockGraceNow => '每次';

  @override
  String appLockGraceAfter(String left) {
    return '离开 $left 后';
  }

  @override
  String get chatCalendarTitle => '按日期';

  @override
  String get chatCalendarEmpty => '这里还没有任何消息';

  @override
  String get chatsSearchChatsSection => '聊天';

  @override
  String get chatsSearchMessagesSection => '消息';

  @override
  String get contactProfileViewInChat => '在聊天中查看';

  @override
  String get chatDraft => '草稿';

  @override
  String get chatSearchTitle => '搜索';

  @override
  String get chatSearchHint => '搜索消息';

  @override
  String get chatSearchNoResults => '无匹配结果';

  @override
  String get chatSearchPrevious => '上一个结果';

  @override
  String get chatSearchNext => '下一个结果';

  @override
  String chatMessageCount(int count) {
    return '$count 条消息';
  }

  @override
  String get chatRouteBluetooth => 'Bluetooth';

  @override
  String get chatRouteMesh => 'Mesh';

  @override
  String get chatRouteInternet => '互联网';

  @override
  String get chatRouteQueued => '排队中';

  @override
  String get attachStickers => '贴纸';

  @override
  String get stickersEmpty => '暂无贴纸';

  @override
  String get stickersEmptyHint => '保存聊天中的图片，它就会出现在这里。';

  @override
  String get stickerKeep => '保存为贴纸';

  @override
  String get stickerKept => '已保存到你的贴纸';

  @override
  String get stickerForget => '移除贴纸';

  @override
  String get stickerCreate => '用照片制作贴纸';

  @override
  String get stickerFailed => '无法将该图片制作成贴纸';

  @override
  String get stickerLabel => '贴纸';

  @override
  String get previewPhoto => '照片';

  @override
  String get previewVoice => '语音消息';

  @override
  String get previewFile => '文件';

  @override
  String get stickerEmojiTitle => '为它选择一个表情';

  @override
  String get stickersMine => '我的贴纸';

  @override
  String get stickersStarterPack => 'Cubi';

  @override
  String get emojiTab => '表情';

  @override
  String get chatBlockedStatus => '已屏蔽';

  @override
  String get chatBlockedHint => '你已屏蔽此人';

  @override
  String get chatRouteFallbackOff => '互联网已关';

  @override
  String get chatAttachmentUnavailable => '没有可用的连接。请通过 Bluetooth 或互联网连接后重试。';

  @override
  String get fileTransfersTitle => '文件传输';

  @override
  String get fileTransfersClear => '清除历史';

  @override
  String get fileTransfersEmpty => '暂无文件传输';

  @override
  String get fileTransfersActive => '进行中';

  @override
  String get fileTransfersHistory => '历史';

  @override
  String get fileTransferPause => '暂停';

  @override
  String get fileTransferResume => '继续';

  @override
  String get fileTransferRetry => '重试';

  @override
  String get fileTransferQueued => '等待连接';

  @override
  String get fileTransferRunning => '传输中';

  @override
  String get fileTransferPaused => '已暂停';

  @override
  String get fileTransferCompleted => '已完成';

  @override
  String get fileTransferFailed => '失败';

  @override
  String get fileTransferCanceled => '已取消';

  @override
  String get profileFileTransfers => '文件传输';

  @override
  String get profileFileTransfersSubtitle => '进度、队列和传输历史';

  @override
  String get qrScanAction => '扫描二维码';

  @override
  String get qrScanTitle => '扫描二维码';

  @override
  String get qrScanHint => '扫描 CubeChat 的联系人、频道、账号迁移或电脑登录二维码。';

  @override
  String get qrFlash => '手电筒';

  @override
  String get qrCameraError => '相机不可用。请检查相机权限后重试。';

  @override
  String get qrInvalid => '这不是有效的 Cubechat 二维码。';

  @override
  String qrChannelAdded(String name) {
    return '已添加 $name';
  }

  @override
  String get qrShow => '显示二维码';

  @override
  String qrChannelTitle(String name) {
    return '加入 $name';
  }

  @override
  String get profileBackup => '加密备份';

  @override
  String get profileBackupSubtitle => '安全迁移密钥、联系人和历史记录';

  @override
  String get backupTitle => '加密备份';

  @override
  String get backupExplainer =>
      '备份包含你的私有身份密钥、联系人、频道、设置和消息历史。它会在这部手机上用你设置的密码加密；如果忘记密码，Cubechat 无法找回。';

  @override
  String get backupCreate => '创建备份';

  @override
  String get backupCreateSubtitle => '加密所有数据并保存为 .cchatbackup 文件';

  @override
  String get backupRestore => '恢复备份';

  @override
  String get backupRestoreSubtitle => '用备份文件替换此手机上的 Cubechat 资料';

  @override
  String get backupPasswordTitle => '备份密码';

  @override
  String get backupPasswordHint => '至少 8 个字符';

  @override
  String get backupConfirmPassword => '再次输入密码';

  @override
  String get backupPasswordMismatch => '两次输入的密码不一致';

  @override
  String get backupPasswordShort => '请至少使用 8 个字符';

  @override
  String get backupSaveTitle => '保存 Cubechat 备份';

  @override
  String get backupSaved => '加密备份已保存';

  @override
  String get backupWhereTitle => '备份保存到哪里？';

  @override
  String get backupSaveToFiles => '保存到文件';

  @override
  String get backupSaveToFilesHint => '手机上的文件夹、存储卡或云盘';

  @override
  String get backupSendToApp => '发送到应用';

  @override
  String get backupSendToAppHint => 'Telegram、邮件、聊天应用——任何能接收文件的应用';

  @override
  String get backupFailed => '无法完成备份操作';

  @override
  String get backupRestoreConfirmTitle => '替换此资料？';

  @override
  String get backupRestoreConfirmMessage => '此手机上当前的密钥、联系人、频道、设置和历史记录将被所选备份替换。';

  @override
  String get backupRestoreConfirmAction => '恢复';

  @override
  String get backupRestored => '备份已恢复';

  @override
  String get backupPackingWait => '正在创建备份…';

  @override
  String get backupUnpackingWait => '正在恢复备份…';

  @override
  String get backupWaitHint => '如果包含照片和视频，可能需要几分钟。请保持应用打开。';

  @override
  String get backupInvalid => '密码错误、文件损坏或备份不受支持';

  @override
  String get channelInfoTitle => '频道详情';

  @override
  String get channelParticipantsTitle => '成员';

  @override
  String get channelAdministratorsTitle => '管理员';

  @override
  String get channelMakeAdmin => '设为管理员';

  @override
  String get channelRemoveAdmin => '取消管理员';

  @override
  String get channelNoParticipants => '成员会在有签名活动后显示';

  @override
  String get channelSharedContent => '媒体、文件和投票';

  @override
  String get channelDescriptionTitle => '简介';

  @override
  String get channelDescriptionEmpty => '暂无简介';

  @override
  String get channelDescriptionHint => '这个频道是做什么的';

  @override
  String get channelDescriptionAdminOnly => '只有管理员可以修改简介';

  @override
  String get channelDescriptionSave => '保存';

  @override
  String get channelPrivateSubtitle => '私密频道';

  @override
  String get channelAvatarSet => '设置新照片';

  @override
  String get channelSettingsTitle => '频道设置';

  @override
  String get channelSettingsHint => '谁能发言、复制、历史记录';

  @override
  String get channelLeaveAction => '退出';

  @override
  String get channelLeaveConfirm =>
      '房间及其中的所有内容将从这部手机上消失。密钥来自名称，因此输入相同的名称即可再次打开它。';

  @override
  String get channelShareAction => '分享';

  @override
  String channelMembersOf(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 位成员',
      one: '1 位成员',
    );
    return '$_temp0';
  }

  @override
  String get chatTyping => '正在输入…';

  @override
  String get chatRecordingVoice => '正在录制语音…';

  @override
  String get chatRecordingCircle => '正在录制视频消息…';

  @override
  String get chatSendingPhoto => '正在发送照片…';

  @override
  String get chatSendingVideo => '正在发送视频…';

  @override
  String get chatSendingFile => '正在发送文件…';

  @override
  String get onboardingMeshTitle => '无需互联网也能用';

  @override
  String get onboardingMeshBody =>
      '消息通过 Bluetooth 在手机之间传递。无需信号、无需 Wi-Fi、无需账号——只需身边的人。';

  @override
  String get onboardingRelayTitle => '有网络时也能用';

  @override
  String get onboardingRelayBody => '超出 Bluetooth 范围时，消息改走互联网，同样能送达。你无需选择。';

  @override
  String get onboardingPrivacyTitle => '中间人无法读取';

  @override
  String get onboardingPrivacyBody =>
      '所有内容均端到端加密，你的身份是这部手机上的一把密钥——不是手机号，不是邮箱，也不是任何人能夺走的账号。';

  @override
  String get onboardingSkip => '跳过';

  @override
  String get onboardingNext => '下一步';

  @override
  String get onboardingStart => '开始使用';

  @override
  String get chatMediaShare => '分享';

  @override
  String get chatMediaSaveToGallery => '保存到相册';

  @override
  String get chatMediaShowInChat => '在聊天中显示';

  @override
  String get chatWallpaperTitle => '壁纸';

  @override
  String get chatWallpaperClear => '重置';

  @override
  String get chatWallpaperDim => '调暗消息背景';

  @override
  String get chatSelectAction => '选择';

  @override
  String get chatForwardNothing => '这里没有可转发的内容';

  @override
  String chatSelectedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '已选择 $count 项',
      one: '已选择 1 项',
    );
    return '$_temp0';
  }

  @override
  String chatDeleteSelectedTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '删除 $count 条消息？',
      one: '删除此消息？',
    );
    return '$_temp0';
  }

  @override
  String get contactAliasAction => '重命名联系人';

  @override
  String get contactAliasHint => '只有你能看到此名称。留空则使用对方的名字。';

  @override
  String get viewOnceSendLabel => '阅后即焚';

  @override
  String get viewOnceTitle => '阅后即焚';

  @override
  String get viewOnceTapToView => '照片 · 点按查看一次';

  @override
  String get viewOnceSent => '照片 · 已发送';

  @override
  String get viewOnceOpened => '照片已查看';

  @override
  String get viewOnceUnavailable => '此照片已不可用';

  @override
  String get viewOnceWarning => '关闭后，照片将从双方设备上删除。';

  @override
  String get channelAvatarAdminOnly => '只有管理员可以更改频道照片';

  @override
  String get channelAdminOnly => '只有管理员可以更改此项';

  @override
  String get channelAvatarTooLarge => '该照片太大，无法广播';

  @override
  String get channelMemberUnknown => '尚未加为联系人';

  @override
  String get channelInviteToContacts => '向对方发送你的名片';

  @override
  String channelContactInviteSent(String name) {
    return '已向 $name 发送名片';
  }

  @override
  String get chatContactInvitation => '添加联系人邀请';

  @override
  String get chatContactInvitationForYou => '给你的邀请';

  @override
  String get channelPollTitle => '投票';

  @override
  String get channelCreatePoll => '创建投票';

  @override
  String get channelPollQuestion => '问题';

  @override
  String channelPollOption(int number) {
    return '选项 $number';
  }

  @override
  String get channelPollAddOption => '添加选项';

  @override
  String get channelPollCreate => '发布投票';

  @override
  String channelPollVotes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 票',
      one: '1 票',
      zero: '暂无投票',
    );
    return '$_temp0';
  }

  @override
  String get phoneTransferTitle => '迁移到新手机';

  @override
  String get desktopPickChat => '选择你想给谁发消息';

  @override
  String get desktopListCollapse => '仅显示头像';

  @override
  String get desktopListExpand => '显示聊天列表';

  @override
  String get desktopLinkConnectTitle => '连接电脑';

  @override
  String get desktopLinkConnectHint => '扫描电脑上 CubeChat 显示的二维码';

  @override
  String get desktopLinkSignIn => '使用手机上的账号登录';

  @override
  String get desktopLinkTitle => '用手机登录';

  @override
  String get desktopLinkSteps =>
      '在手机上依次进入“我的 → 数据 → 连接电脑”，然后扫描此二维码。两台设备必须连接同一个 Wi-Fi。';

  @override
  String get desktopLinkLimits =>
      '手机仍可正常使用。来自互联网的消息会同时到达两台设备；但在一台设备上发送的消息暂时不会显示在另一台上。';

  @override
  String get desktopLinkWaiting => '等待手机…';

  @override
  String get desktopLinkFailed => '无法接收账号，请重试。';

  @override
  String get desktopLinkRetry => '重试';

  @override
  String get desktopLinkConfirmTitle => '将此账号的副本发送到电脑？';

  @override
  String get desktopLinkConfirmMessage => '电脑将获得你的密钥、联系人和聊天。这部手机照常使用。';

  @override
  String get desktopLinkConfirmAction => '发送';

  @override
  String desktopLinkConfirmWhere(String address) {
    return '仅当你刚刚从自己电脑的屏幕上扫描此二维码时才继续。副本将发送到此网络中的 $address。';
  }

  @override
  String get desktopLinkSending => '正在发送账号…';

  @override
  String get desktopLinkSent => '电脑已连接';

  @override
  String get desktopLinkPhoneFound => '手机已找到此电脑，正在制作账号副本。如有照片，可能需要几分钟。';

  @override
  String desktopLinkReceiving(int percent) {
    return '正在接收账号：$percent%';
  }

  @override
  String get desktopLinkRestoring => '正在此电脑上部署账号…';

  @override
  String get desktopLinkFinding => '正在寻找电脑…';

  @override
  String get desktopLinkPreparing => '正在制作账号副本。如有照片，可能需要几分钟。';

  @override
  String desktopLinkSendingPercent(int percent) {
    return '正在发送：$percent%';
  }

  @override
  String get desktopLinkComputerRestoring => '电脑正在部署账号…';

  @override
  String get devicesTitle => '设备';

  @override
  String get devicesRowHint => '你的账号在哪些设备上登录，以及从那里退出';

  @override
  String get devicesThisDevice => '此设备';

  @override
  String get devicesSeenNow => '刚刚在线';

  @override
  String devicesSeenMinutes(int n) {
    return '$n 分钟前在线';
  }

  @override
  String devicesSeenHours(int n) {
    return '$n 小时前在线';
  }

  @override
  String devicesSeenDays(int n) {
    return '$n 天前在线';
  }

  @override
  String get devicesLeaving => '正在退出——等待其上线';

  @override
  String get devicesSignOut => '退出登录';

  @override
  String get devicesSignOutAll => '退出所有其他设备';

  @override
  String devicesSignOutTitle(String name) {
    return '在“$name”上退出登录？';
  }

  @override
  String get devicesSignOutMessage =>
      '该设备一上线，其上的 CubeChat 密钥、聊天和设置就会被清除。账号会保留在此设备和你的其他设备上。';

  @override
  String get devicesSignOutPhoneMessage =>
      '这是一部手机：其上的 CubeChat 将被完全清除。账号会保留在此设备和你的其他设备上。';

  @override
  String get devicesSignOutAllMessage => '所有其他设备一上线就会退出登录。账号将只保留在此设备上。';

  @override
  String get devicesRename => '重命名';

  @override
  String get devicesRenameTitle => '此设备的名称';

  @override
  String get devicesSave => '保存';

  @override
  String get devicesEmpty => '暂无其他设备。设备打开 CubeChat 1.0.0+1147 或更新版本后会显示在这里。';

  @override
  String get devicesCaveat =>
      '退出登录在该设备上线后才会生效。一直保持离线的设备会保留其密钥；要完全防护，需要为账号更换新密钥。';

  @override
  String get desktopLinkImportTitle => '从手机迁移账号';

  @override
  String get desktopLinkImportHint => '向手机出示二维码，这台电脑就会成为其账号的副本';

  @override
  String get desktopLinkImportConfirmTitle => '替换此电脑上的账号？';

  @override
  String get desktopLinkImportConfirmMessage =>
      '此电脑上的密钥、联系人和聊天将被手机上的账号替换。如果仍需要当前账号，请先备份。';

  @override
  String get desktopLinkImportConfirmAction => '继续';

  @override
  String get desktopLinkUnreachable =>
      '无法连接到电脑。两台设备需连接同一个 Wi-Fi，且电脑的防火墙必须允许 CubeChat。';

  @override
  String get desktopLinkFirewallHint =>
      'Windows 可能会阻止手机连接这台电脑。请在防火墙中允许 CubeChat——仅限本地网络。';

  @override
  String get desktopLinkFirewallAllow => '在防火墙中允许';

  @override
  String get desktopLinkFirewallDeclined => 'Windows 未允许。否则手机可能无法连接。';

  @override
  String get phoneTransferIntro => '在两部手机之间直接迁移你的资料、密钥、联系人、频道、设置和历史记录。';

  @override
  String get phoneTransferSend => '这是旧手机';

  @override
  String get phoneTransferReceive => '这是新手机';

  @override
  String get phoneTransferSameWifi => '将两部手机连接到同一个 Wi-Fi。迁移完成前请保持此页面打开。';

  @override
  String get phoneTransferPreparing => '正在准备加密迁移…';

  @override
  String get phoneTransferReady => '在新手机上扫描此一次性二维码';

  @override
  String get phoneTransferScan => '扫描旧手机';

  @override
  String get phoneTransferConfirmTitle => '替换此手机上的资料？';

  @override
  String get phoneTransferConfirmMessage => '此手机上当前保存的资料将被加密本地迁移的数据替换。';

  @override
  String get phoneTransferConfirmAction => '迁移资料';

  @override
  String get phoneTransferSuccess => '资料迁移成功';

  @override
  String get phoneTransferFailed => '无法完成手机迁移';

  @override
  String get profileSummaryMeshOnly => '仅 Mesh';

  @override
  String get profileSummaryMeshInternet => 'Mesh · 互联网';

  @override
  String get profileSummaryBackgroundOn => '后台运行';

  @override
  String profileSummaryTransfersActive(int count) {
    return '$count 个进行中';
  }

  @override
  String get profileSummaryCardBackup => '文件、备份';

  @override
  String get chatPlay => '播放';

  @override
  String get chatPause => '暂停';

  @override
  String get profileTheme => '颜色';

  @override
  String get profileThemeEmerald => '翡翠';

  @override
  String get profileThemeIndigo => '靛蓝';

  @override
  String get profileThemeAmber => '琥珀';

  @override
  String get profileThemeRose => '玫瑰';

  @override
  String get profileThemeFuchsia => '紫红';

  @override
  String get profileThemeViolet => '紫罗兰';

  @override
  String get profileThemeOcean => '海洋';

  @override
  String get profileThemeSlate => '石墨';

  @override
  String get profileScale => '界面大小';

  @override
  String get profileScaleSystem => '跟随系统';

  @override
  String get profileGlass => '玻璃效果';

  @override
  String get profileGlassAuto => '自动';

  @override
  String get profileGlassFull => '完整';

  @override
  String get profileGlassLight => '轻量';

  @override
  String get profileGlassHint =>
      '轻量模式保留色调，去掉面板后的模糊。自动模式会测量一次你的手机后决定。对于本来就流畅的手机，这几乎没有作用——它是为不够流畅的手机准备的。';

  @override
  String get mapAlwaysNeeded => '要在 cubechat 关闭时地图仍保持更新，位置权限必须设为“始终”。点按打开设置。';

  @override
  String get mapShareConsentTitle => '在地图上显示你的位置？';

  @override
  String get mapShareConsentBody =>
      '你的实时位置只会显示给地图上的联系人：你邀请的人，或你接受了其邀请的人。在你隐藏之前，位置会持续更新，包括 Cubechat 在后台运行时。位置经过端到端加密，绝不会到达我们这里。你可以随时在地图上或“我的”中隐藏，被你屏蔽的联系人永远看不到你。';

  @override
  String get mapShareConsentAllow => '允许';

  @override
  String get mapShareConsentDecline => '不允许';

  @override
  String get mapVisibleToFriends => '地图上的好友能看到你';

  @override
  String get mapHiddenFromFriends => '你已隐藏';

  @override
  String get mapHideMe => '隐藏';

  @override
  String get mapShowMe => '显示我';

  @override
  String get profileScaleSmall => '较小';

  @override
  String get profileScaleNormal => '标准';

  @override
  String get profileScaleLarge => '较大';

  @override
  String get profileScaleSample => '文字和列表将以此大小显示。';

  @override
  String get savedTitle => '收藏夹';

  @override
  String get savedSubtitle => '给自己的笔记，保存在此设备上';

  @override
  String get savedEmpty => '你在这里写下的一切都只保留在这部手机上。';

  @override
  String get meshOffTitle => 'Bluetooth Mesh 已关闭';

  @override
  String get meshOffHint => '附近的人找不到你，你也找不到他们。消息仍会通过互联网中继传输。';

  @override
  String get profileMeshSwitch => 'Bluetooth Mesh';

  @override
  String get profileMeshSwitchHint => '发现附近的人，无需互联网即可传递消息。关闭可节省电量。';

  @override
  String get channelAdminOnlyHint => '公告频道。所有人仍可阅读。';

  @override
  String get attachLocation => '位置';

  @override
  String get locationBubbleTitle => '位置';

  @override
  String get locationOpenInMaps => '在地图应用中打开';

  @override
  String locationAccuracy(int metres) {
    return '精度 $metres 米';
  }

  @override
  String get locationExpired => '此位置已过时';

  @override
  String get locationDenied => '位置权限已关闭';

  @override
  String get locationUnavailable => '无法获取位置';

  @override
  String get locationShareFor => '共享时长';

  @override
  String get locationShareOnce => '仅一次';

  @override
  String get locationShare15m => '15 分钟';

  @override
  String get locationShare1h => '1 小时';

  @override
  String get storageTitle => '存储空间';

  @override
  String get storageHeadline => '存储使用情况';

  @override
  String storageSubtitle(String size) {
    return 'cubechat 在此设备上占用了 $size';
  }

  @override
  String get storageEmpty => '暂无存储内容';

  @override
  String get storageScanning => '正在计算…';

  @override
  String get storageCatPhotos => '照片';

  @override
  String get storageCatVoice => '语音消息';

  @override
  String get storageCatFiles => '收到的文件';

  @override
  String get storageCatOutbox => '发送的文件';

  @override
  String get storageCatStickers => '贴纸';

  @override
  String get storageCatSaved => '收藏夹';

  @override
  String get storageCatWallpapers => '壁纸';

  @override
  String get storageCatHistory => '聊天记录和密钥';

  @override
  String get storageCatCache => '缓存';

  @override
  String storageClear(String size) {
    return '清除 $size';
  }

  @override
  String get storageClearNothing => '未选择任何内容';

  @override
  String storageFreed(String size) {
    return '已释放 $size';
  }

  @override
  String get storageNoCloud => '这里没有云端。你清除的内容会从这部手机上消失，唯一的其他副本在发送它的那部手机上。';

  @override
  String get storageWhyHistoryLocked => '聊天记录无法在这里清除——请使用“紧急清除”。';

  @override
  String get storageRecoveryFree => '可安全清除';

  @override
  String get storageRecoveryGone => '其他地方没有副本';

  @override
  String get storageRecoveryAskSender => '可再次向发送者请求';

  @override
  String get storageRecoveryCostsThem => '对方将无法再请求你重新发送';

  @override
  String storageConfirmTitle(String size) {
    return '清除 $size？';
  }

  @override
  String get storageConfirmBody => '这将从这部手机上删除这些文件。没有任何内容上传到别处，因此无法恢复。';

  @override
  String storageFilesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 个文件',
      zero: '空',
    );
    return '$_temp0';
  }

  @override
  String get customizeBarTitle => '导航栏';

  @override
  String get customizeBarHint => '拖动以调整顺序。“聊天”无法移除。';

  @override
  String get customizeBarShown => '已显示';

  @override
  String get customizeBarHidden => '已隐藏';

  @override
  String get customizeBarHiddenEmpty => '没有隐藏项';

  @override
  String get customizeBarMinimum => '至少保留两个标签页';

  @override
  String get customizeReset => '恢复默认';

  @override
  String get chatsArchiveTitle => '归档';

  @override
  String get chatsArchiveEmpty => '没有归档内容';

  @override
  String get chatsArchiveHint => '归档的聊天照常工作——只是不在列表中显示。';

  @override
  String get chatsArchivedToast => '已归档';

  @override
  String get chatsUnarchivedToast => '已移回列表';

  @override
  String chatsArchiveCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 个聊天',
    );
    return '$_temp0';
  }

  @override
  String get chatsSwipeNotHere => '此聊天不可用';

  @override
  String get customizeSwipeTitle => '向右滑动聊天';

  @override
  String get customizeSwipeHint => '向左滑动仍用于切换标签页。';

  @override
  String get customizeSwipeArchive => '归档';

  @override
  String get customizeSwipeMute => '静音';

  @override
  String get customizeSwipePin => '置顶';

  @override
  String get customizeSwipeRead => '标为已读';

  @override
  String get customizeSwipeDelete => '删除';

  @override
  String get customizeSwipeNone => '无';

  @override
  String get customizeHighRefresh => '最高刷新率';

  @override
  String get customizeHighRefreshHint =>
      '更流畅，但手机要绘制两倍的帧数。如果手机发热，请关闭——应用外观不会改变，只是重绘频率不同。';

  @override
  String get customizeQuickReaction => '双击回应';

  @override
  String get customizeQuickReactionHint => '双击消息时留下的表情回应。使用其他表情后，它会替换到这里。';

  @override
  String get customizeCircleAudioTitle => '播放视频消息时暂停音乐';

  @override
  String get customizeCircleAudioOn => '录制或观看视频消息时会停止其他正在播放的内容，之后不会自动继续播放。';

  @override
  String get customizeCircleAudioOff => '音乐会在后台继续播放，播放视频消息时音量降低。';

  @override
  String get customizeMediaQualityTitle => '发送照片的质量';

  @override
  String get customizeMediaQualityEconomy => '节省';

  @override
  String get customizeMediaQualityStandard => '标准';

  @override
  String get customizeMediaQualityHigh => '高';

  @override
  String get customizeMediaQualityEconomyHint =>
      '每张照片最大 96 KB、800 px。适合信号只有一格或 Bluetooth Mesh 拥挤时：等待时间减半，画面稍模糊。';

  @override
  String get customizeMediaQualityStandardHint =>
      '每张照片最大 192 KB、1280 px。大小确保仅靠 Bluetooth 也能发出。视频和“原图”始终按原样发送。';

  @override
  String get customizeMediaQualityHighHint =>
      '每张照片最大 768 KB、2048 px。清晰到可以放大；发送时间是四倍，建议在 Wi-Fi 下使用。';

  @override
  String get previewReacted => '回应了你的消息';

  @override
  String get previewLocation => '位置';

  @override
  String get previewMapInvite => '地图邀请';

  @override
  String get previewContact => '联系人';

  @override
  String get previewUnsupported => '不支持的消息';

  @override
  String get previewCallOutgoing => '呼出通话';

  @override
  String get previewCallIncoming => '呼入通话';

  @override
  String get previewCallMissed => '未接来电';

  @override
  String chatPreparingPhotos(int count) {
    return '正在准备 $count 张照片…';
  }

  @override
  String get circleSwitchCamera => '切换摄像头';

  @override
  String get circleLight => '补光';

  @override
  String get circleCameraSwitchFailed => '无法切换摄像头。你的录制仍在进行。';

  @override
  String get diagnosticsTitle => '诊断';

  @override
  String get diagnosticsIntro => '应用最近的运行情况。如果有功能不正常，请将其发送给开发者。';

  @override
  String get diagnosticsShare => '将日志发送给开发者';

  @override
  String get diagnosticsEvents => '最近事件';

  @override
  String get diagnosticsTechnical => '技术记录';

  @override
  String get diagnosticsEmpty => '暂无内容。';

  @override
  String get diagnosticsDeveloperOn => '开发者模式已开启';

  @override
  String get diagnosticsDeveloperOff => '开发者模式已关闭';

  @override
  String get logAppStarted => '应用已启动';

  @override
  String get logInternetOn => '互联网连接已开启';

  @override
  String logServerConnected(String host) {
    return '已连接到 $host';
  }

  @override
  String logServerLost(String host) {
    return '与 $host 的连接已断开';
  }

  @override
  String get chatSaveAction => '保存';

  @override
  String get savedTagAsk => '已保存。添加标签？';

  @override
  String get savedTagAdd => '添加标签';

  @override
  String get chatSharedWallpaperFailed => '已在此处设置壁纸。对方进入范围后将收到。';

  @override
  String get chatTranscribeAction => '转文字';

  @override
  String get chatTranscribeFailed => '这部手机无法转写这条消息。';

  @override
  String get chatTranscribing => '正在识别…';

  @override
  String get chatTranscriptHide => '隐藏文字';

  @override
  String get chatCancelSend => '取消发送';

  @override
  String get chatDownloadAction => '下载';

  @override
  String get chatDownloaded => '已保存到手机';

  @override
  String get chatDownloadFailed => '无法保存';

  @override
  String get selfUpdateTitle => '从文件安装更新';

  @override
  String get selfUpdateHint =>
      '请在这里选择新的 cubechat APK，而不要从聊天中打开：通过这种方式安装，锁屏来电功能会保持开启。';

  @override
  String get selfUpdateConfirm => '请在系统窗口中确认安装。';

  @override
  String get selfUpdateAllow => '请允许 cubechat 安装应用，然后再次点按。';

  @override
  String get selfUpdateNotOurs => '该文件不是 cubechat 更新。';

  @override
  String get selfUpdateFailed => '更新未安装。';

  @override
  String get chatTranscribeDownloading => '手机正在下载所需的语言，请一分钟后重试。';

  @override
  String get chatTranscribeNoLanguage =>
      '这部手机没有该语言的语音模型。请在“我的 → 聊天和媒体”中选择语音转文字语言。';

  @override
  String get chatTranscribeNotAllowed =>
      'CubeChat 的语音识别已关闭。请在 iPhone 的“设置 → CubeChat”中开启。';

  @override
  String get customizeTranscribeLanguageTitle => '语音转文字语言';

  @override
  String get customizeTranscribeLanguageAuto => '自动';

  @override
  String get customizeTranscribeLanguageHint =>
      '语音消息所用的语言，不一定是应用的语言。“自动”会尝试手机的语言。缺少的语言由手机自行下载；语音永远不会离开手机。';

  @override
  String get chatTranslateAction => '翻译';

  @override
  String get chatTranslateFailed => '这部手机无法翻译这条消息。';

  @override
  String get customizeDeferMediaTitle => '等待 Wi-Fi 再下载媒体';

  @override
  String get customizeDeferMediaHint =>
      '使用移动数据时，文字和通话照常工作，而照片、语音消息、视频消息和文件会在服务器上等待 Wi-Fi——最多两周。聊天列表上方的一行会显示等待的内容，并可立即下载。';

  @override
  String heldMediaCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 个媒体等待 Wi-Fi',
      one: '1 个媒体等待 Wi-Fi',
    );
    return '$_temp0';
  }

  @override
  String get heldMediaDownload => '下载';

  @override
  String get nearbyAirDropSubtitle => '与附近的人分享文件';

  @override
  String get nearbyFilesSubtitle => '已发送和已接收的文件';

  @override
  String get airdropTab => 'AirDrop';

  @override
  String get nearbyTabFiles => '文件';

  @override
  String get airdropReceiveHint => '谁可以给你发送文件';

  @override
  String get airdropReceiveContacts => '联系人';

  @override
  String get airdropReceiveEveryone => '所有人 10 分钟';

  @override
  String airdropEveryoneLeft(String time) {
    return '所有人 · $time';
  }

  @override
  String get airdropSendFiles => '发送文件';

  @override
  String get airdropChooseFiles => '选择文件';

  @override
  String airdropStagedTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 个文件已就绪',
    );
    return '$_temp0';
  }

  @override
  String get airdropStagedHint =>
      '两部手机都开启 Bluetooth 并打开 AirDrop 后，将它们靠在一起，或选择一个人';

  @override
  String get airdropStagedPickPerson => '选择联系人';

  @override
  String airdropRequestBody(String what, String size) {
    return '想发送 $what · $size';
  }

  @override
  String airdropWhatPhotos(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 张照片',
      one: '1 张照片',
    );
    return '$_temp0';
  }

  @override
  String airdropWhatVideos(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 个视频',
      one: '1 个视频',
    );
    return '$_temp0';
  }

  @override
  String airdropWhatFiles(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 个文件',
      one: '1 个文件',
    );
    return '$_temp0';
  }

  @override
  String get airdropAccept => '接受';

  @override
  String get airdropDecline => '拒绝';

  @override
  String get airdropWaiting => '等待回应…';

  @override
  String get airdropAccepted => '已接受';

  @override
  String get airdropUnheard => '对方未收到——可能是旧版 CubeChat';

  @override
  String get airdropSending => '发送中';

  @override
  String get airdropReceiving => '接收中';

  @override
  String get airdropInterrupted => '已中断';

  @override
  String get airdropRetry => '重试';

  @override
  String get airdropOutcomeSent => '已发送';

  @override
  String get airdropOutcomeReceived => '已接收';

  @override
  String get airdropOutcomeDeclined => '已拒绝';

  @override
  String get airdropOutcomeCancelled => '已取消';

  @override
  String get airdropOutcomePartial => '部分完成';

  @override
  String get airdropReasonNoSpace => '空间不足';

  @override
  String get airdropReasonContactsOnly => '仅限联系人';

  @override
  String get airdropReasonBusy => '忙碌';

  @override
  String get airdropReasonTimeout => '无回应';

  @override
  String get airdropFileDeleted => '已删除';

  @override
  String get airdropHistory => '历史';

  @override
  String get airdropClearHistory => '清除历史';

  @override
  String get airdropEmpty => '你在附近发送或接收的文件会显示在这里';

  @override
  String get airdropPickPerson => '发送给';

  @override
  String get airdropNobody => '附近暂时没有使用 cubechat 的人';

  @override
  String get airdropNoDirect => '与此人没有 Bluetooth 连接';

  @override
  String get airdropNearbyUnknown => '附近';

  @override
  String get airdropConnecting => '正在连接…';

  @override
  String get airdropConnectFailed => '无法连接';

  @override
  String get airdropSlowWarning => '通过 Bluetooth 可能需要很长时间';

  @override
  String airdropTooLarge(String name, int limit) {
    return '$name 超过 $limit MB';
  }

  @override
  String airdropFromLabel(String name) {
    return 'AirDrop · $name';
  }

  @override
  String get airdropWrite => '发消息';

  @override
  String get airdropAction => 'AirDrop';

  @override
  String get airdropLaneTitle => '通道';

  @override
  String get airdropLaneAuto => '自动';

  @override
  String get airdropLaneBluetooth => 'Bluetooth';

  @override
  String get airdropLaneWifi => 'Wi‑Fi';

  @override
  String get airdropBluetoothNeededHint => '在两部手机上开启 Bluetooth，以便互相发现并确认传输。';

  @override
  String get airdropLaneHint =>
      'Bluetooth 负责发现并连接手机。当两部手机处于同一网络或热点时，由 Wi‑Fi 传输文件。';

  @override
  String get airdropWifiUnreachable => '不在同一网络中';

  @override
  String get airdropWifiOldVersion => '对方的应用暂不支持通过 Wi‑Fi 接收';

  @override
  String get airdropBumpAdd => '添加';

  @override
  String get airdropBumpAlreadyContact => '已是你的联系人';

  @override
  String airdropBumpSending(String name) {
    return '正在发送给 $name';
  }

  @override
  String airdropBumpReceiving(String name) {
    return '$name 正在向你发送文件';
  }

  @override
  String get termsTitle => 'cubechat 规则';

  @override
  String get termsBody =>
      'cubechat 对不良内容和滥用行为零容忍。继续即表示你同意不发送骚扰、威胁、涉及未成年人的色情内容、垃圾信息或任何违法内容。任何人都可以举报消息或用户；举报会送达开发者并在 24 小时内处理，违规者将被封禁。';

  @override
  String get termsReadFull => '阅读完整条款';

  @override
  String get termsAccept => '我同意';

  @override
  String get messageHide => '隐藏';

  @override
  String get messageHidden => '已对你隐藏';

  @override
  String get reportAction => '举报';

  @override
  String get reportTitle => '有什么问题？';

  @override
  String get reportReasonSpam => '垃圾信息';

  @override
  String get reportReasonAbuse => '辱骂或骚扰';

  @override
  String get reportReasonViolence => '暴力';

  @override
  String get reportReasonSexual => '色情内容';

  @override
  String get reportReasonOther => '其他';

  @override
  String get reportNoteHint => '描述（可选）';

  @override
  String get reportSend => '发送举报';

  @override
  String get reportDisclosure =>
      '所选消息的文字和你的举报将发送给 cubechat 审核团队及其私有 Telegram 机器人。';

  @override
  String get reportSent => '举报已发送。我们会在 24 小时内处理。';

  @override
  String get reportBlockedToo => '已为你屏蔽此人。';

  @override
  String get reportQueued => '举报已保存，联网后将发送。';

  @override
  String get reportFailed => '无法发送举报。';

  @override
  String get filteredMessage => '已被过滤器隐藏';

  @override
  String get filteredShow => '显示';

  @override
  String get filterToggle => '不良内容过滤';

  @override
  String get filterToggleHint => '隐藏陌生人消息和频道中的粗俗用语';

  @override
  String get aboutTitle => '关于';

  @override
  String get aboutContact => '给开发者发邮件';

  @override
  String get aboutReport => '举报违规';

  @override
  String get aboutTerms => '使用条款';

  @override
  String get aboutPrivacy => '隐私政策';

  @override
  String get requestsTitle => '请求';

  @override
  String get requestsEmpty => '没有请求';

  @override
  String requestBanner(String name) {
    return '$name 不在你的联系人中。在你接受之前，对方无法看到你是否已读，也无法给你打电话。';
  }

  @override
  String get requestAccept => '接受';

  @override
  String get requestDelete => '删除';

  @override
  String get requestBlock => '屏蔽';

  @override
  String get cubeIdTitle => 'Cube ID';

  @override
  String get cubeIdExplainer => '你的 @用户名 指向你的联系人名片。服务器只保存用户名和你的公开名片——绝不保存你的消息。';

  @override
  String get cubeIdFieldHint => 'a–z、0–9 和 _，3–20 个字符';

  @override
  String get cubeIdAvailable => '可用';

  @override
  String get cubeIdTaken => '已被占用';

  @override
  String get cubeIdReserved => '不允许使用';

  @override
  String get cubeIdInvalid => '仅限 a–z、0–9 和 _，3–20 个字符';

  @override
  String get cubeIdClaim => '使用此用户名';

  @override
  String get cubeIdWorking => '正在锁定用户名…';

  @override
  String get cubeIdChange => '更改';

  @override
  String get cubeIdEmail => '找回邮箱';

  @override
  String get cubeIdEmailHint => '如果这部手机丢失，可以通过发到此地址的邮件找回用户名';

  @override
  String get cubeIdEmailField => '邮箱';

  @override
  String cubeIdEmailSent(String email) {
    return '已向 $email 发送邮件，请打开其中的链接。';
  }

  @override
  String get cubeIdEmailRemove => '移除邮箱';

  @override
  String get cubeIdEmailUnavailable => '邮件服务暂不可用，请稍后重试。';

  @override
  String get cubeIdEmailInvalid => '这看起来不像邮箱地址';

  @override
  String get cubeIdSave => '保存';

  @override
  String get cubeIdRecover => '通过邮箱找回用户名';

  @override
  String get cubeIdRecoverSent => '如果地址匹配，你会收到一封邮件。打开其中的链接 48 小时后，用户名将转移到这部手机。';

  @override
  String cubeIdRecoveryWarning(String name, String when) {
    return '有人正在另一部手机上通过邮箱找回 @$name。除非你取消，否则它将于 $when 转移。';
  }

  @override
  String get cubeIdRecoveryCancel => '取消找回';

  @override
  String get cubeIdRecoveryCancelled => '已取消找回';

  @override
  String get cubeIdRelease => '释放';

  @override
  String cubeIdReleaseConfirm(String name) {
    return '释放 @$name？任何人都可以占用它。';
  }

  @override
  String get cubeIdShare => '分享';

  @override
  String cubeIdShareText(String name) {
    return '在 cubechat 上找到我：@$name\nhttps://cubechat.tech/u.html#$name';
  }

  @override
  String get cubeIdFailed => '无法保存用户名，请重试。';

  @override
  String get cubeIdOffline => '无网络连接';

  @override
  String get lookupNotFound => '没有使用该 @用户名 的人';

  @override
  String searchFindCubeName(String name) {
    return '查找 @$name';
  }

  @override
  String get searchFindCubeNameHint => '在 Cube ID 中查找并添加';

  @override
  String get addContactHintName => '粘贴名片或输入 @用户名';

  @override
  String get strangerReachTitle => '谁可以通过互联网给我发消息';

  @override
  String get strangerReachAll => '所有人';

  @override
  String get strangerReachRequest => '需请求';

  @override
  String get strangerReachNone => '没有人';

  @override
  String get strangerReachHint =>
      '适用于你没有联系过、通过互联网找到你的人。附近通过 Bluetooth 联系的人不受影响。';

  @override
  String get sectionPrivacy => '隐私与安全';

  @override
  String get sectionNotifications => '通知与通话';

  @override
  String get sectionConnection => '连接';

  @override
  String get sectionChats => '聊天和媒体';

  @override
  String get sectionAppearance => '外观';

  @override
  String get sectionData => '数据与存储';

  @override
  String get sectionAbout => '关于';

  @override
  String get subWhoSeesMe => '谁能看到我';

  @override
  String get subProtection => '保护';

  @override
  String get subNotifications => '通知';

  @override
  String get subCalls => '通话';

  @override
  String get profileDiscoverableMeshOff => 'Bluetooth Mesh 已关闭——请在“连接”中开启。';

  @override
  String get chatRouteBluetoothDirect => 'Bluetooth 直连';

  @override
  String chatRouteMeshHops(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Mesh · $n 跳',
    );
    return '$_temp0';
  }

  @override
  String chatRouteDeliveredVia(String route) {
    return '送达方式：$route';
  }

  @override
  String chatRouteReceivedVia(String route) {
    return '接收方式：$route';
  }

  @override
  String get chatUnreadDivider => '新消息';

  @override
  String get radioTitle => '对讲机';

  @override
  String get radioNearbySubtitle => '按住按钮，与群组或联系人对讲';

  @override
  String get radioGroupsLabel => '群组';

  @override
  String get radioDirectLabel => '私人';

  @override
  String get radioAddGroup => '添加对讲频道';

  @override
  String get radioNoGroups => '还没有对讲频道。添加一个——输入相同名称和密码的人都能互相听到。';

  @override
  String get radioLeave => '退出此对讲频道';

  @override
  String get radioPickChannel => '选择群组或联系人';

  @override
  String get radioPushToTalk => '按住说话';

  @override
  String get radioTalking => '正在说话…';

  @override
  String get radioChannelBusy => '频道占线';

  @override
  String radioSpeaker(String name) {
    return '$name 正在说话';
  }

  @override
  String get radioSilentTitle => '静音模式下也播放';

  @override
  String get radioSilentHint => '即使手机处于静音模式，也会播放语音。';

  @override
  String get radioJoinNameLabel => '名称';

  @override
  String get radioJoinPasswordLabel => '密码（可选）';

  @override
  String get radioJoinHint => '输入相同名称和密码的人都在同一个对讲频道中。没有任何服务器保存成员列表。';

  @override
  String get radioJoinNameRequired => '请输入名称';

  @override
  String get radioJoinSubmit => '添加';

  @override
  String get radioBlockedTooLong => '通话超过一分钟，已中断';

  @override
  String get radioBlockedCall => '正在通话中';

  @override
  String get radioBlockedMicrophone => '无法访问麦克风';

  @override
  String get radioBlockedUnavailable => '此设备不支持对讲机';

  @override
  String get radioBlockedNoChannel => '请先选择群组或联系人';

  @override
  String get radioTurnOff => '关闭对讲机';

  @override
  String get radioPersonalCallsTitle => '接收私人呼叫';

  @override
  String get radioPersonalCallsHint => '对讲机关闭时，联系人对你说话，对讲机会自动切换到该联系人。';

  @override
  String get radioBackgroundHint => '屏幕关闭时，只有开启后台模式才能听到对讲机。';

  @override
  String get areaNearby => '附近聊天';

  @override
  String get areaLevelDistrict => '街区';

  @override
  String get areaLevelCity => '城市';

  @override
  String get areaLevelRegion => '地区';

  @override
  String areaPresentCount(int count) {
    return '此处约 $count 人';
  }

  @override
  String get areaPresentMany => '此处 50+ 人';

  @override
  String get areaBlockViaBluetooth => '你所在的街坊——通过 Bluetooth';

  @override
  String get areaOpenNearbyTab => '打开“附近”';

  @override
  String get areaLocating => '正在查找你所在的街区…';

  @override
  String get areaNoPlace => '暂无位置。此页面打开期间，区域聊天需要你的大致位置。';

  @override
  String get areaLocationDenied => 'Cubechat 的定位已关闭。请在“设置”中允许获取大致位置，以查看你所在的街区。';

  @override
  String get areaOffline => '无法连接到区域聊天';

  @override
  String get areaEmpty => '过去 24 小时内没有人在这里发言。';

  @override
  String get areaConsentTitle => '区域聊天是公开的';

  @override
  String get areaConsentBody =>
      '这里的消息是公开的。任何打开你所在街区或城市的人都能阅读，消息会在 Cubechat 服务器上保留 24 小时。你会以每隔几小时更换一次的临时名字发言；没有人能看到你的 @用户名 或联系人。为了确定你所在的街区，Cubechat 会请求你的大致位置，且仅在此页面打开时。';

  @override
  String get areaConsentAllow => '继续';

  @override
  String get areaConsentDecline => '以后再说';

  @override
  String areaDefaultName(String tag) {
    return '方块-$tag';
  }

  @override
  String areaYouAre(String name, int hours) {
    return '你是 $name · $hours 小时后更换新名字';
  }

  @override
  String get areaNewName => '新名字';

  @override
  String get areaSetName => '设置名字';

  @override
  String get areaNameHint => '仅在此名字的几小时内有效。留空则自动生成。';

  @override
  String get areaNameSameWarning => '使用相同的名字会让你在不同街区之间被关联起来';

  @override
  String get areaShowPresence => '显示我在这里';

  @override
  String get areaPresenceOffHint => '开启“显示我在这里”即可查看附近有多少人';

  @override
  String get areaReadOnly => '只能在你所在的地方发言';

  @override
  String get areaComposerHint => '给这里的所有人发消息';

  @override
  String get areaSend => '发送';

  @override
  String get areaWaitALittle => '请稍候';

  @override
  String areaFlood(int count) {
    return '刷屏（$count）· 显示';
  }

  @override
  String get areaReply => '回复';

  @override
  String get areaHide => '隐藏';

  @override
  String get areaBlock => '屏蔽至其更换名字';

  @override
  String get areaBlocked => '已屏蔽至其更换名字';

  @override
  String get areaReport => '举报';

  @override
  String get areaOpenLink => '打开链接';

  @override
  String areaOpenLinkConfirm(String url) {
    return '打开 $url？';
  }

  @override
  String get areaOpen => '打开';

  @override
  String get areaReadHere => '在此阅读';

  @override
  String get areaReadHereHint => '仅可阅读。你只能在你所在的地方发言；中继会知道你在阅读哪个地方。';

  @override
  String get areaNotes => '便条';

  @override
  String areaNotesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 张便条',
      zero: '没有便条',
    );
    return '$_temp0';
  }

  @override
  String get areaLeaveNote => '留下便条';

  @override
  String get areaNoteHint => '给你所在城市的一张短便条';

  @override
  String get areaNoteLifetime => '保留时长';

  @override
  String get areaNote1h => '1 小时';

  @override
  String get areaNote24h => '24 小时';

  @override
  String get areaNote7d => '7 天';

  @override
  String get areaPinToDistrict => '固定到街区';

  @override
  String get areaPinHint => '点按你所在城市内的地图；图钉会自动吸附到对应街区。';

  @override
  String get areaPinOutside => '仅限你所在的城市内';

  @override
  String get areaNoteDelete => '删除我的便条';

  @override
  String get areaNoNotes => '这里还没有便条';

  @override
  String get areaNotesLimit => '每天三张便条';

  @override
  String get areaNoteLeft => '便条已留下';

  @override
  String get areaNoteSend => '留下';

  @override
  String get areaOwnNote => '你的便条';

  @override
  String get areaNotePinned => '已固定到街区';

  @override
  String get areaHidden => '已隐藏';

  @override
  String get areaPublicBadge => '公开 · 保留 24 小时';

  @override
  String get areaSettingTitle => '区域聊天';

  @override
  String get areaSettingOnHint => '地图上的“附近聊天”按钮：以临时名字参与你所在街区和城市的公开聊天。';

  @override
  String get areaSettingOffHint => '关闭：地图上不显示按钮，区域聊天永远不会请求你的位置或建立连接。';

  @override
  String get wallpaperPhotoLocalOnly => '照片壁纸目前仅限本地';

  @override
  String get wallpaperSavedNoRoute => '已保存在本机。目前没有到对方的路由';

  @override
  String get wallpaperScopeTitle => '谁能看到这张壁纸？';

  @override
  String get wallpaperScopeChannel => '整个频道';

  @override
  String get wallpaperScopeBoth => '我和对方';

  @override
  String get wallpaperScopeLocal => '仅我自己';

  @override
  String get wallpaperScopeSharedHint => '以加密控制包发送';

  @override
  String get wallpaperScopePhotoHint => '照片目前只保留在这部手机上';

  @override
  String get foldersCreate => '新建文件夹';

  @override
  String get foldersYours => '你的文件夹';

  @override
  String get foldersSmartFilters => '智能筛选';

  @override
  String get foldersName => '文件夹名称';

  @override
  String get foldersSave => '保存';

  @override
  String get foldersDeleteTitle => '删除文件夹？';

  @override
  String get foldersDelete => '删除';

  @override
  String get foldersCreateAction => '创建';

  @override
  String get chatsArchiveHiddenToast => '归档已隐藏。可在“外观”中恢复。';

  @override
  String get chatsBulkPin => '置顶';

  @override
  String get chatsBulkMute => '静音';

  @override
  String get chatsUnarchive => '取消归档';

  @override
  String get chatsAddToFolder => '添加到文件夹';

  @override
  String get chatsMarkUnread => '标为未读';

  @override
  String get chatsClearHistory => '清空聊天记录';

  @override
  String get foldersNew => '新文件夹';

  @override
  String get foldersNameHint => '好友';

  @override
  String get chatsNoIncoming => '没有收到的消息';

  @override
  String get chatsMarkedUnread => '已标为未读';

  @override
  String get chatsClearHistoryTitle => '清空聊天记录？';

  @override
  String get chatsClearHistoryBody => '消息仅会从此设备删除。聊天、联系人和星标都会保留。';

  @override
  String get chatsClearHistoryAction => '清空';

  @override
  String get chatsHistoryCleared => '记录已清空';

  @override
  String get savedTagMenuTag => '标签';

  @override
  String get savedTagRemove => '移除标签';

  @override
  String get customizeArchiveRowTitle => '归档行';

  @override
  String get customizeArchiveRowHint => '显示在聊天列表上方。已归档的聊天仍会照常接收消息。';

  @override
  String get mapLayerStandard => '标准';

  @override
  String get mapLayerStandardHint => '浅色街道地图——最稳定的选择';
}
