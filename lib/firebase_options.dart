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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBnxmCxO0Sag1nV8cGYlXD6eDXIrsAi6gk',
    appId: '1:137961333259:web:49dfe0b9b450d6dbba5d0e',
    messagingSenderId: '137961333259',
    projectId: 'project-reunite',
    authDomain: 'project-reunite.firebaseapp.com',
    storageBucket: 'project-reunite.appspot.com',
    measurementId: 'G-R8B0C09L1F',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyByyr61skCSWS8Xl-J6FkC6b204cMBpy0w',
    appId: '1:137961333259:android:7c7a8d6a1288af68ba5d0e',
    messagingSenderId: '137961333259',
    projectId: 'project-reunite',
    storageBucket: 'project-reunite.appspot.com',
  );
}