// Offline marketing capture using the current production router and widgets.
// All names/messages/radio discoveries below are fictional fixture data.
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cubechat/core/routing/app_router.dart';
import 'package:cubechat/core/theme/app_theme.dart';
import 'package:cubechat/core/util/ui_activity.dart';
import 'package:cubechat/features/chat/data/messages_controller.dart';
import 'package:cubechat/features/chat/models/message.dart';
import 'package:cubechat/features/chats/models/chat.dart';
import 'package:cubechat/features/chats/presentation/chats_list_screen.dart';
import 'package:cubechat/features/peers/data/known_peers_controller.dart';
import 'package:cubechat/features/peers/data/peer_discovery_controller.dart';
import 'package:cubechat/features/peers/data/peripheral_controller.dart';
import 'package:cubechat/features/peers/models/discovered_peer.dart';
import 'package:cubechat/features/peers/models/known_peer.dart';
import 'package:cubechat/l10n/app_localizations.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:cubechat/core/util/platform_capabilities.dart';
import 'package:cubechat/core/identity/avatar_controller.dart';
import 'package:cubechat/core/identity/nickname_controller.dart';
import 'package:cubechat/core/transport/shared_location.dart';
import 'package:cubechat/core/util/location_service.dart';
import 'package:cubechat/features/map/data/shared_map_locations_provider.dart';
import 'package:cubechat/features/map/presentation/people_map_screen.dart';
import 'package:cubechat/features/profile/data/privacy_settings_controller.dart';
import '../test/support/hive_settle.dart';

class _LogHttp extends HttpOverrides{
 static int created=0;
 @override HttpClient createHttpClient(SecurityContext? context){created++;return super.createHttpClient(context);}
}
class DemoNickname extends NicknameController{
 @override String build()=>'Олексій';
}
class DemoAvatar extends AvatarController{
 @override Uint8List? build()=>null;
}
class DemoPrivacy extends PrivacySettingsController{
 @override PrivacySettings build()=>const PrivacySettings(shareLastSeen:true,shareReadReceipts:true,shareMapLocation:true);
}

final now=DateTime.now();
final ids=List.generate(6,(i)=>List.filled(64,'${i+1}').join());
const names=['Марія','Максим','Софія','Андрій','Олена','Данило'];
const previews=['Зустрінемось біля кав’ярні','Дякую, усе отримав!','Надішлю фото ввечері','Я вже поруч','Побачимось у суботу','Голосове повідомлення'];
class DemoPeers extends KnownPeersController{
 @override Map<String,KnownPeer> build()=>{for(var i=0;i<6;i++)ids[i]:KnownPeer(pubkeyHex:ids[i],displayName:names[i],lastSeen:now)};
}
class DemoMessages extends MessagesController{
 @override Map<String,List<Message>> build()=>{ids[0]:[
 for(var i=0;i<6;i++)Message(id:'demo-$i',chatId:ids[0],text:['Привіт! Ти вже в центрі?','Так, щойно приїхала','Де зустрінемось?','Біля нашої кав’ярні. Тут так гарно сьогодні!','Супер, я за п’ять хвилин','Зустрінемось біля кав’ярні'][i],sentAt:now.subtract(Duration(minutes:8-i)),isMine:i.isEven,status:MessageStatus.read,route:MessageRoute.bluetooth),
 ]};
}
class DemoDiscovery extends PeerDiscoveryController{
 @override PeerDiscoveryState build()=>PeerDiscoveryState(status:PeerDiscoveryStatus.scanning,peers:[for(var i=0;i<3;i++)DiscoveredPeer(id:'AA:BB:CC:DD:EE:0$i',advertisedName:names[i],rssi:-44-i*9,lastSeen:now)]);
 @override Future<void> start()async{}
 @override Future<void> retuneScan()async{}
 @override Future<void> stop()async{}
}
class DemoPeripheral extends PeripheralController{
 @override PeripheralState build()=>PeripheralState.initial;
}
void main(){
 TestWidgetsFlutterBinding.ensureInitialized();
 UiActivity.debugDisableQuietTimer=true;
 testWidgets('record current production screens for promo',(tester)async{
  final dir=Directory.systemTemp.createTempSync('cubechat_promo_');Hive.init(dir.path);
  FlutterSecureStorage.setMockInitialValues({});SharedPreferences.setMockInitialValues({});
  final cacheDir=Directory.systemTemp.createTempSync('cubechat_tiles_');
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(const MethodChannel('plugins.flutter.io/path_provider'),(call)async=>cacheDir.path);
  final output=Directory('D:/projects/presentation_creator/output/cubechat/assets/screens');output.createSync(recursive:true);
  await tester.runAsync(()async{
   for(final item in {'Roboto':'assets/fonts/Inter-Regular.ttf','Ahem':'assets/fonts/Inter-Regular.ttf','Inter':'assets/fonts/Inter-Regular.ttf','SpaceGrotesk':'assets/fonts/Inter-Medium.ttf'}.entries){final loader=FontLoader(item.key)..addFont(rootBundle.load(item.value));await loader.load();}
   final icons=FontLoader('MaterialIcons')..addFont(rootBundle.load('fonts/MaterialIcons-Regular.otf'));await icons.load();
  });
  tester.view.physicalSize=const Size(1170,2532);tester.view.devicePixelRatio=3;
  final router=buildRouter();final key=GlobalKey();
  final container=ProviderContainer(overrides:[
   chatsProvider.overrideWithValue([for(var i=0;i<6;i++)Chat(id:ids[i],peerId:ids[i],peerName:names[i],lastMessage:previews[i],lastTime:now.subtract(Duration(minutes:i*8)),unreadCount:i==0?2:0,isMesh:true,isPinned:i==0)]),
   nicknameControllerProvider.overrideWith(DemoNickname.new),avatarProvider.overrideWith(DemoAvatar.new),privacySettingsProvider.overrideWith(DemoPrivacy.new),
   platformCapabilitiesProvider.overrideWithValue(const PlatformCapabilities(bluetooth:true,maps:true,googleMaps:false,shareLocation:true,camera:true,calls:true,translation:true,gallery:true)),
   sharedMapLocationsProvider.overrideWithValue({
    ids[0]:SharedMapLocation(chatId:ids[0],location:const SharedLocation(latitude:50.4507,longitude:30.5240),sentAt:now),
    ids[1]:SharedMapLocation(chatId:ids[1],location:const SharedLocation(latitude:50.4495,longitude:30.5226),sentAt:now),
    ids[2]:SharedMapLocation(chatId:ids[2],location:const SharedLocation(latitude:50.4491,longitude:30.5243),sentAt:now),
   }),
   mapLocationReaderProvider.overrideWithValue(()async=>(const LocationFix(latitude:50.4501,longitude:30.5234,accuracyMetres:12),null)),
   knownPeersControllerProvider.overrideWith(DemoPeers.new),messagesControllerProvider.overrideWith(DemoMessages.new),peerDiscoveryControllerProvider.overrideWith(DemoDiscovery.new),peripheralControllerProvider.overrideWith(DemoPeripheral.new),
  ]);
  await tester.pumpWidget(UncontrolledProviderScope(container:container,child:RepaintBoundary(key:key,child:MaterialApp.router(debugShowCheckedModeBanner:false,theme:AppTheme.dark(),locale:const Locale('uk'),localizationsDelegates:AppLocalizations.localizationsDelegates,supportedLocales:AppLocalizations.supportedLocales,routerConfig:router))));
  Future<void> beat()async{await tester.pump();await tester.pump(const Duration(milliseconds:900));await tester.pump(const Duration(milliseconds:900));}
  Future<void> capture(String name)async{
   final boundary=key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
   // The headless engine has no platform fallback font. Match the app's
   // bundled sans face for spans that normally inherit the device default.
   InlineSpan fonts(InlineSpan span){
    if(span is! TextSpan)return span;
    final style=span.style ?? const TextStyle();
    return TextSpan(text:span.text,style:style.copyWith(fontFamily:style.fontFamily == 'MaterialIcons' ? 'MaterialIcons' : 'Inter'),children:span.children?.map(fonts).toList());
   }
   void fix(RenderObject object){if(object is RenderParagraph)object.text=fonts(object.text);object.visitChildren(fix);}
   fix(boundary);await tester.pump();
   await tester.runAsync(()async{final image=await boundary.toImage(pixelRatio:3);final data=await image.toByteData(format:ui.ImageByteFormat.png);File('${output.path}/$name.png').writeAsBytesSync(data!.buffer.asUint8List());image.dispose();});
  }
  await beat();await capture('chats');
  router.push('/chat/${ids[0]}?name=${Uri.encodeComponent(names[0])}');
  await tester.pump();
  await beat();await beat();await capture('chat');
  router.go('/contacts');await beat();await capture('contacts');
  router.go('/peers');await beat();await beat();await capture('nearby');
  router.go('/map');await beat();
  for(var i=0;i<2;i++){await tester.runAsync(()async=>Future<void>.delayed(const Duration(seconds:2)));for(var j=0;j<4;j++){await tester.pump(const Duration(milliseconds:250));}}
  final fmState=tester.state<State>(find.byType(FlutterMap));
  final cam=MapController.maybeOf(tester.element(find.byType(FlutterMap)));
  debugPrint('TILE-PROBE clients=${_LogHttp.created} cam=${cam?.camera.center} zoom=${cam?.camera.zoom} ${fmState.runtimeType}');
  await capture('map');
  router.go('/profile');await beat();await beat();await capture('profile');
  await tester.pumpWidget(const SizedBox());router.dispose();container.dispose();await tester.runAsync(settleBackgroundStorage);await tester.runAsync(Hive.close);
  tester.view.resetPhysicalSize();tester.view.resetDevicePixelRatio();
 });
}



