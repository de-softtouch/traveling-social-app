import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:traveling_social_app/app.dart';
import 'package:traveling_social_app/repository/authentication_repository/authentication_repository.dart';
import 'package:traveling_social_app/repository/notification_repository/notification_repository.dart';
import 'package:traveling_social_app/repository/user_repository/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:traveling_social_app/screens/restartWidget.dart';

import 'config/my_custom_vi_message.dart';
import 'package:timeago/timeago.dart' as timeago;

//handle background message
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  //init firebase
  await Firebase.initializeApp();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //
  FlutterLocalNotificationsPlugin localNotification =
      FlutterLocalNotificationsPlugin();
  localNotification.initialize(
    const InitializationSettings(
      android: AndroidInitializationSettings('tc_launcher_icon'),
      iOS: IOSInitializationSettings(),
    ),
  );
  //android notification details
  AndroidNotificationDetails android = const AndroidNotificationDetails(
      'id', 'channel ',
      priority: Priority.max, importance: Importance.max, playSound: true);
  //ios notification details
  IOSNotificationDetails iOS = const IOSNotificationDetails();
  NotificationDetails platform =
      NotificationDetails(android: android, iOS: iOS);
  Map<String, dynamic> data = message.data;
  String title = data['title'];
  String body = data['body'];
  await localNotification.show(0, title, body, platform);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //initial firebase
  await Firebase.initializeApp();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  //request ios permission
  FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  runApp(
    App(
      userRepo: UserRepository(),
      authRepo: AuthenticationRepository(),
      notificationRepo: NotificationRepository(),
    ),
  );
}
