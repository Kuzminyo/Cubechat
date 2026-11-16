// Offline marketing capture using the current production router and widgets.
// All names/messages/radio discoveries below are fictional fixture data.
//
// Run with `flutter test`, so the test-only hooks are legitimate here; the
// analyzer only counts files under test/ as tests, and its warnings on this
// one kept the Android CI gate red from 2026-10-25 to 2026-10-31.
// ignore_for_file: invalid_use_of_visible_for_testing_member
import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cubechat/app/app_router.dart';
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
import '../test/support/hive_settle.dart';

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
  final output=Directory('design-previews/cubechat-app-reel-v2/captures');output.createSync(recursive:true);
  await tester.runAsync(()async{
   for(final item in {'Roboto':'assets/fonts/Inter-Regular.ttf','Ahem':'assets/fonts/Inter-Regular.ttf','Inter':'assets/fonts/Inter-Regular.ttf','SpaceGrotesk':'assets/fonts/Inter-Medium.ttf'}.entries){final loader=FontLoader(item.key)..addFont(rootBundle.load(item.value));await loader.load();}
   final icons=FontLoader('MaterialIcons')..addFont(rootBundle.load('fonts/MaterialIcons-Regular.otf'));await icons.load();
  });
  tester.view.physicalSize=const Size(1170,2532);tester.view.devicePixelRatio=3;
  final router=buildRouter();final key=GlobalKey();
  final container=ProviderContainer(overrides:[
   chatsProvider.overrideWithValue([for(var i=0;i<6;i++)Chat(id:ids[i],peerId:ids[i],peerName:names[i],lastMessage:previews[i],lastTime:now.subtract(Duration(minutes:i*8)),unreadCount:i==0?2:0,isMesh:true,isPinned:i==0)]),
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
  for(var i=0;i<16;i++){await tester.pump(const Duration(milliseconds:33));await capture('open-chat-${i.toString().padLeft(2,'0')}');}
  await beat();await capture('chat');
  router.go('/contacts');await beat();await capture('contacts');
  router.go('/peers');await beat();await beat();await capture('nearby');
  await tester.pumpWidget(const SizedBox());router.dispose();container.dispose();await tester.runAsync(settleBackgroundStorage);await tester.runAsync(Hive.close);
  tester.view.resetPhysicalSize();tester.view.resetDevicePixelRatio();
 });
}



