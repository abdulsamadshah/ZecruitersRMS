import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:io';

import '../../core/Utils/Context_Utility.dart';


class firebaseNotificationServices {

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  static String fcmToken = "";
  //notification show plugin
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  //android and ios notification initialize
  void inItLocalNotification(
      BuildContext context, RemoteMessage message) async {
    var androidinitializeSetting =
        const AndroidInitializationSettings("@mipmap/ic_launcher");

    var iosinitializeSetting = const DarwinInitializationSettings();

    var initializationSetting = InitializationSettings(
      android: androidinitializeSetting,
      iOS: iosinitializeSetting,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSetting,
        onDidReceiveNotificationResponse: (payload) {
      handleMessage(context, message, type: "recienvedmessage");
    });
  }

  Future<void> showNotification(RemoteMessage message) async {
    //android completed
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      Random.secure().nextInt(10000).toString(),
      "High Importance Notification",
      importance: Importance.max,
      sound:
          const RawResourceAndroidNotificationSound('recieve_notification.mp3'),
    );

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            channel.id.toString(), channel.name.toString(),
            channelDescription: "you Channel Description",
            importance: Importance.high,
            priority: Priority.high,
            ticker: "ticker",
            sound: const RawResourceAndroidNotificationSound(
                'recieve_notification'),
            enableVibration: true);

    //

    //ios notification
    const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
            sound: "recieve_notification.mp3");

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );

    Future.delayed(Duration.zero, () {
      flutterLocalNotificationsPlugin.show(0, message.notification!.title,
          message.notification!.body, notificationDetails);
    });
  }

  Future<String> getDiviceToken() async {
    String? token = await messaging.getToken();
    return token!;
  }

  

  Future<void> setupInteractMessage(BuildContext context) async {
    // When app is terminated
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      // handleMessage(context, initialMessage);
      handleMessage(context, initialMessage, type: "recienvedmessage");
    }

    // When app is in background
    FirebaseMessaging.onMessageOpenedApp.listen((event) async {
      handleMessage(context, event, type: "recienvedmessage");
    });
  }

  askPermission() async {
    await Firebase.initializeApp();

    if (Platform.isAndroid) {
      NotificationSettings setting = await messaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: true,
        criticalAlert: true,
        provisional: true,
        sound: true,
      );
      if (setting.authorizationStatus == AuthorizationStatus.authorized) {
        // debugPrint("user granted permission");
      } else {
        // debugPrint("user denied permission");
        // openAppSettings();
      }
    } else if (Platform.isIOS) {
      await FlutterLocalNotificationsPlugin()
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    }
  }

  Future<void> initialized() async {


    getDeviceTokenToSendNotification();

    // If App is Terminated state & used click notification
    FirebaseMessaging.instance.getInitialMessage().then((message) {});

    // App is Forground this method  work
    FirebaseMessaging.onMessage.listen((message) async {


      if (Platform.isAndroid) {
        inItLocalNotification(
            ContextUtility.navigatorkey.currentState!.context, message);
        showNotification(message);
        handleMessage(
            ContextUtility.navigatorkey.currentState!.context, message);
      } else {
        // showNotification(message);
        // handleMessage(context, message);
      }
    });

    // App on Backaground not Terminated
    // When app is in background
    FirebaseMessaging.onMessageOpenedApp.listen((event) async {
      handleMessage(ContextUtility.navigatorkey.currentState!.context, event,
          type: "recienvedmessage");
    });

    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);
  }

  static Future<String> getDeviceTokenToSendNotification() async {
    fcmToken = (await FirebaseMessaging.instance.getToken()).toString();

    return fcmToken;
  }

  Future<void> handleMessage(BuildContext context, RemoteMessage message,
      {String? type}) async {

  }
}
