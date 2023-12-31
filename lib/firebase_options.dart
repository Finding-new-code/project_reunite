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
    apiKey: 'AIzaSyCr3lmgkGZ3-BwamI2oLscJkiYI7U7UBOo',
    appId: '1:564007385931:web:f3aeecdcd41feec83006ce',
    messagingSenderId: '564007385931',
    projectId: 'example-test-c6d6a',
    authDomain: 'example-test-c6d6a.firebaseapp.com',
    storageBucket: 'example-test-c6d6a.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCtzXKqiNT5rDGZJxqu7gqFDhoqdE1v7Kk',
    appId: '1:564007385931:android:05868d995d80ea3d3006ce',
    messagingSenderId: '564007385931',
    projectId: 'example-test-c6d6a',
    storageBucket: 'example-test-c6d6a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAS7hr1MkRtaWWYR7xZJT9G0130rsZarBM',
    appId: '1:564007385931:ios:688195936c6545983006ce',
    messagingSenderId: '564007385931',
    projectId: 'example-test-c6d6a',
    storageBucket: 'example-test-c6d6a.appspot.com',
    iosClientId: '564007385931-nd0si905qliqc0de7bhd9dt67ekdn5v7.apps.googleusercontent.com',
    iosBundleId: 'com.example.projectReunite',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAS7hr1MkRtaWWYR7xZJT9G0130rsZarBM',
    appId: '1:564007385931:ios:688195936c6545983006ce',
    messagingSenderId: '564007385931',
    projectId: 'example-test-c6d6a',
    storageBucket: 'example-test-c6d6a.appspot.com',
    iosClientId: '564007385931-nd0si905qliqc0de7bhd9dt67ekdn5v7.apps.googleusercontent.com',
    iosBundleId: 'com.example.projectReunite',
  );
}
