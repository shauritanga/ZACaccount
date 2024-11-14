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
        return macos;
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
    apiKey: 'AIzaSyCZSORFy9H_YG_NzUI9RCxQa2az80f7sjU',
    appId: '1:464484198684:web:41231e0950b076d67db2d9',
    messagingSenderId: '464484198684',
    projectId: 'zacaccount',
    authDomain: 'zacaccount.firebaseapp.com',
    storageBucket: 'zacaccount.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAfv-RYhMPpNfIdiuit-hwqQ4DjMDsBGUI',
    appId: '1:80114757459:android:723a3938bef0141c0d7ba6',
    messagingSenderId: '80114757459',
    projectId: 'shaccount',
    storageBucket: 'shaccount.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDJ-4bFoNt8SaVJWM4RR8APnvnezzxs8wM',
    appId: '1:80114757459:ios:67559ace364ec35b0d7ba6',
    messagingSenderId: '80114757459',
    projectId: 'shaccount',
    storageBucket: 'shaccount.firebasestorage.app',
    iosBundleId: 'com.shauritanga.zaccount',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCGIRjTe62HV0SKudfzo16GxiXWKOu8KJg',
    appId: '1:464484198684:ios:4a45b30d362bf93b7db2d9',
    messagingSenderId: '464484198684',
    projectId: 'zacaccount',
    storageBucket: 'zacaccount.appspot.com',
    iosBundleId: 'com.shauritanga.zaccount',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCZSORFy9H_YG_NzUI9RCxQa2az80f7sjU',
    appId: '1:464484198684:web:67977b8f6107e7f57db2d9',
    messagingSenderId: '464484198684',
    projectId: 'zacaccount',
    authDomain: 'zacaccount.firebaseapp.com',
    storageBucket: 'zacaccount.appspot.com',
  );

}