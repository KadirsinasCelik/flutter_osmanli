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
    apiKey: 'AIzaSyDmgiGPAcKNRxbmObeLSi0UsZoJYJ1T_jE',
    appId: '1:1092149925470:web:3d00513d929305d062c6cf',
    messagingSenderId: '1092149925470',
    projectId: 'osmanliansiklopedisi',
    authDomain: 'osmanliansiklopedisi.firebaseapp.com',
    databaseURL: 'https://osmanliansiklopedisi-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'osmanliansiklopedisi.appspot.com',
    measurementId: 'G-QE6ME27RNS',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD5TH2YeMl0dDJvCiUwrSE8BgcNt9sIYFM',
    appId: '1:1092149925470:android:44665fe822ec88d262c6cf',
    messagingSenderId: '1092149925470',
    projectId: 'osmanliansiklopedisi',
    databaseURL: 'https://osmanliansiklopedisi-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'osmanliansiklopedisi.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCl20Y3_HJBHE7u7e0PDhjIPlE--pUSJ7E',
    appId: '1:1092149925470:ios:6b72f90478b009d462c6cf',
    messagingSenderId: '1092149925470',
    projectId: 'osmanliansiklopedisi',
    databaseURL: 'https://osmanliansiklopedisi-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'osmanliansiklopedisi.appspot.com',
    iosClientId: '1092149925470-ne6klign7mut35ghvcgarptbi1c0isj9.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterOsmanli',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCl20Y3_HJBHE7u7e0PDhjIPlE--pUSJ7E',
    appId: '1:1092149925470:ios:6b72f90478b009d462c6cf',
    messagingSenderId: '1092149925470',
    projectId: 'osmanliansiklopedisi',
    databaseURL: 'https://osmanliansiklopedisi-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'osmanliansiklopedisi.appspot.com',
    iosClientId: '1092149925470-ne6klign7mut35ghvcgarptbi1c0isj9.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterOsmanli',
  );
}
