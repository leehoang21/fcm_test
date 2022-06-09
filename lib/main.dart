import 'dart:convert';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'firebase_options.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // TODO: Request permission
  final messaging = FirebaseMessaging.instance;
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  //Web/iOS app users need to grant permission to receive messages
  final settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  // TODO: Register with FCM
  // use the registration token to send messages to users from your trusted server environment
  String? token;

  token = await messaging.getToken();

  messaging.onTokenRefresh.listen((String fcmToken) {
    token = fcmToken;
  }).onError((err) {
    log(err.toString());
  });
  log(token.toString());

  // TODO: Set up foreground message handler
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (kDebugMode) {
      log('Handling a foreground message: ${message.messageId}');
      log('Message data: ${message.data}');
      log('Message notification: ${message.notification?.title}');
      log('Message notification: ${message.notification?.body}');
    }
  });

  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: Center(
        child: Text(
          'Push notification token: $token\n\n',
          style: TextStyle(fontSize: 24),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async {
        final response = await post(
          Uri.parse(
              "https://fcm.googleapis.com/v1/projects/fcm-test-a07d5/messages:send"),
          headers: {
            'Content-Type': 'application/json',
            'Authorization':
                'Bearer ya29.a0ARrdaM8TPwhAtzXyMwjQfVMW2GksJQgKYAsNNHMF4Pn0ZWpOFGFLGZ4pKhwnPke5wwmDLNg8qtQ15tv_p7xuuWIsWb46O-eowhHsY_QvaGgxHmcM_0pgbeVROM8GK_HVHDPQJ_rFeTdHmzx79Q2UUgCBeBOZ'
          },
          body: json.encode(
            {
              "message": {
                "topic": "topic",
                "notification": {
                  "title": "up 1.43% on the day",
                  "body":
                      "FooCorp gained 11.80 points to close at 835.67, up 1.43% on the day."
                },
              }
            },
          ),
        );

        log(response.statusCode.toString());
        log(response.body.toString());
      }),
    ),
  ));
}
