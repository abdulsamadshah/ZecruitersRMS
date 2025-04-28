import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'Routers/app_route_config.dart';
import 'core/constant/global.dart';
import 'core/theme/themes_data.dart';



@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // print("Handling a background message: ${message.messageId}");
  await Firebase.initializeApp(); // Ensure Firebase is initialized
  // showCallkitIncoming("some_unique_id",message);
}
//
// Future<void> showCallkitIncoming(String uuid,RemoteMessage message) async {
//   final params = CallKitParams(
//     id: uuid,
//     nameCaller: 'John Doe',
//     appName: 'Zecruiters',
//     avatar: 'https://i.pravatar.cc/100',
//     handle: '7249303582',
//     type: 0,
//     duration: 30000,
//     textAccept: 'Accept',
//     textDecline: 'Decline',
//     missedCallNotification: const NotificationParams(
//       showNotification: true,
//       isShowCallback: true,
//       subtitle: 'Missed call',
//       callbackText: 'Call back',
//     ),
//     extra: <String, dynamic>{'userId': '1a2b3c4d'},
//     headers: <String, dynamic>{'apiKey': 'Abc@123!', 'platform': 'flutter'},
//     android: const AndroidParams(
//       isCustomNotification: true,
//       isShowLogo: false,
//       ringtonePath: 'system_ringtone_default',
//       backgroundColor: '#0955fa',
//       backgroundUrl: 'assets/test.png',
//       actionColor: '#4CAF50',
//       textColor: '#ffffff',
//     ),
//   );
//   await FlutterCallkitIncoming.showCallkitIncoming(params);
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Global.init();
  await Firebase.initializeApp();


  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
// try{
//   listenForCallEvents();
// }catch(e){
//
// }
  runApp(MyApp(router: MyAppRouter().router));
}

class MyApp extends StatefulWidget {
  final GoRouter router;

  const MyApp({required this.router, super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => MaterialApp.router(
        theme: ToggleThemeData.lightTheme,
        title: 'Zecruiters RMS',
        debugShowCheckedModeBanner: false,
        routerConfig: widget.router,
      ),
    );
  }
}
