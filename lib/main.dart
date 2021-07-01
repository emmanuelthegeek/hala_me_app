// @dart=2.9
import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hala_me/provider/user_provider.dart';
import 'package:hala_me/screens/login_screen.dart';
import 'package:provider/provider.dart';

import 'screens/home_screen.dart';

void _enablePlatformOverrideForDesktop() {
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux)) {
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }
}

void main() {
  _enablePlatformOverrideForDesktop();
  AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
      //'resource://drawable/res_app_icon',
      null,
      [
        NotificationChannel(
            channelKey: 'message_recieved',
            channelName: 'Message Recieved',
            channelDescription: 'Notification for recieved messages.',
            defaultColor: Color(0xFF9D50DD),
            ledColor: Colors.white)
      ]);
  AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      // Insert here your friendly dialog box before call the request method
      // This is very important to not harm the user experience
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });

  runApp(
    MyApp(),
    /* MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => UserProvider()),
      //ChangeNotifierProvider(create: (_) => ChatProvider()),
    ], child: MyApp()), */
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hala Me',
      theme: ThemeData(
        primaryColor: Color(0xFF01afbd),
      ),
      home: LoginScreen(force: false),
    );
  }
}
