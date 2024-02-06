// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAXx-Y49j2Gpige1qXhZmliCFswyD5roII',
    appId: '1:383062960915:web:a04a8aafe625cbdec588e6',
    messagingSenderId: '383062960915',
    projectId: 'eelu-3c8a8',
    authDomain: 'eelu-3c8a8.firebaseapp.com',
    storageBucket: 'eelu-3c8a8.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAoQ5EUGoaYKtkHo3QvK6hYAQXo827OoJw',
    appId: '1:383062960915:android:8415e48c401ae2adc588e6',
    messagingSenderId: '383062960915',
    projectId: 'eelu-3c8a8',
    storageBucket: 'eelu-3c8a8.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDobauMvV9XchxD81gjhAaAkoe1bLiiTPo',
    appId: '1:383062960915:ios:f2d5c3b4b717bd08c588e6',
    messagingSenderId: '383062960915',
    projectId: 'eelu-3c8a8',
    storageBucket: 'eelu-3c8a8.appspot.com',
    iosBundleId: 'com.example.payment',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDobauMvV9XchxD81gjhAaAkoe1bLiiTPo',
    appId: '1:383062960915:ios:b273d863ddf0bedac588e6',
    messagingSenderId: '383062960915',
    projectId: 'eelu-3c8a8',
    storageBucket: 'eelu-3c8a8.appspot.com',
    iosBundleId: 'com.example.payment.RunnerTests',
  );
}