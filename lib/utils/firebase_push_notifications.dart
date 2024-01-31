// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../screen/sign_in.dart';

late BuildContext homeBuildContext;

class FirebasePushNotifications {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final _localNotification = FlutterLocalNotificationsPlugin();

  Future<void> requestPermission() async {
    await _firebaseMessaging
        .requestPermission(
      announcement: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
    )
        .then((notificationSettings) {
      if (notificationSettings.authorizationStatus ==
              AuthorizationStatus.authorized ||
          notificationSettings.authorizationStatus ==
              AuthorizationStatus.provisional) {
        _initFirebasePushNotification();
      } else {
        requestPermission();
      }
    });
  }

  Future<void> _initFirebasePushNotification() async {
    const androidNotificationChannel = AndroidNotificationChannel(
      'broadcast',
      'high_importance_channel',
      importance: Importance.high,
    );
    final platform = _localNotification.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(androidNotificationChannel);

    FirebaseMessaging.onMessage.listen(
      (remoteMessage) => _handleNotification(remoteMessage),
    );
  }

  Future<void> _handleNotification(
    RemoteMessage remoteMessage,
  ) async {
    RemoteNotification remoteNotification =
        _remoteMessageToRemoteNotification(remoteMessage);
    if (remoteNotification.android!.channelId == 'Sign Out') {
      Navigator.pushReplacementNamed(homeBuildContext, SignInScreen.screenName);
    }
  }

  RemoteNotification _remoteMessageToRemoteNotification(
    RemoteMessage remoteMessage,
  ) {
    AndroidNotification? androidNotification;
    AppleNotification? appleNotification;
    WebNotification? webNotification;

    if (remoteMessage.data['android'] != null) {
      androidNotification = AndroidNotification.fromMap(
        jsonDecode(remoteMessage.data['android']),
      );
    }

    if (remoteMessage.data['apple'] != null) {
      appleNotification = AppleNotification.fromMap(
        jsonDecode(remoteMessage.data['apple']),
      );
    }
    if (remoteMessage.data['web'] != null) {
      webNotification = WebNotification.fromMap(
        jsonDecode(remoteMessage.data['web']),
      );
    }

    return RemoteNotification(
      title: remoteMessage.data['title'],
      body: remoteMessage.data['body'],
      bodyLocKey: remoteMessage.data['bodyLocKey'],
      titleLocKey: remoteMessage.data['titleLocKey'],
      bodyLocArgs: List.from(jsonDecode(remoteMessage.data['bodyLocArgs']))
          .cast<String>(),
      titleLocArgs: List.from(jsonDecode(remoteMessage.data['titleLocArgs']))
          .cast<String>(),
      android: androidNotification,
      apple: appleNotification,
      web: webNotification,
    );
  }
}
