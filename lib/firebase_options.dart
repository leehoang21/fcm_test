// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    // ignore: missing_enum_constant_in_switch
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBF6UuZtB1B-dEVY0--WH-8GiQrqCNnqII',
    appId: '1:823543690982:web:11d246b7c8c8a758a4ed27',
    messagingSenderId: '823543690982',
    projectId: 'fcm-test-a07d5',
    authDomain: 'fcm-test-a07d5.firebaseapp.com',
    storageBucket: 'fcm-test-a07d5.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDzHlbEPqeIKzNNJZoKM_JYfGkGUd6G2p8',
    appId: '1:823543690982:android:753fd7d67c263961a4ed27',
    messagingSenderId: '823543690982',
    projectId: 'fcm-test-a07d5',
    storageBucket: 'fcm-test-a07d5.appspot.com',
  );
}