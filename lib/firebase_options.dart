// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyAuGxsTmOLEcOFZ5NgDY1Rmf105uxZz_3w',
    appId: '1:472031580584:web:406ab90bd61316fab28d9d',
    messagingSenderId: '472031580584',
    projectId: 'planet-sucker',
    authDomain: 'planet-sucker.firebaseapp.com',
    storageBucket: 'planet-sucker.appspot.com',
    measurementId: 'G-C8TLSPRJDW',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCaAty56zZJPy9vlzUb8P1lqRFmpUTGXlk',
    appId: '1:472031580584:android:aeeb1d28fa2a5457b28d9d',
    messagingSenderId: '472031580584',
    projectId: 'planet-sucker',
    storageBucket: 'planet-sucker.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB21UJHDgyzn9gyMjI2HeYz1S4JvqLOxxQ',
    appId: '1:472031580584:ios:5ac7d7094f0ce754b28d9d',
    messagingSenderId: '472031580584',
    projectId: 'planet-sucker',
    storageBucket: 'planet-sucker.appspot.com',
    iosBundleId: 'com.example.jumpJump',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAuGxsTmOLEcOFZ5NgDY1Rmf105uxZz_3w',
    appId: '1:472031580584:web:0299460d5a2e8cf8b28d9d',
    messagingSenderId: '472031580584',
    projectId: 'planet-sucker',
    authDomain: 'planet-sucker.firebaseapp.com',
    storageBucket: 'planet-sucker.appspot.com',
    measurementId: 'G-QGXP13MXTD',
  );
}
