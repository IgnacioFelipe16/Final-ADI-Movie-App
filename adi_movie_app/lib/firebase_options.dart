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
    apiKey: 'AIzaSyDet29WxHfvBiaFnwpDAxkdnRXYklLKWG8',
    appId: '1:758804125937:web:ff733cdda5d7f249473150',
    messagingSenderId: '758804125937',
    projectId: 'movieapp-8761b',
    authDomain: 'movieapp-8761b.firebaseapp.com',
    storageBucket: 'movieapp-8761b.appspot.com',
    measurementId: 'G-V785HK970W',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD27-R0fKkiwCFh9wgfWMcwAhw6gJ7qH7Y',
    appId: '1:758804125937:android:dd06362bf75ff1ff473150',
    messagingSenderId: '758804125937',
    projectId: 'movieapp-8761b',
    storageBucket: 'movieapp-8761b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCPH-CC8vMI3i_IIA0M4Hm3--JAa7mEZJM',
    appId: '1:758804125937:ios:f724194efbeb6105473150',
    messagingSenderId: '758804125937',
    projectId: 'movieapp-8761b',
    storageBucket: 'movieapp-8761b.appspot.com',
    iosBundleId: 'com.example.adiMovieApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCPH-CC8vMI3i_IIA0M4Hm3--JAa7mEZJM',
    appId: '1:758804125937:ios:f724194efbeb6105473150',
    messagingSenderId: '758804125937',
    projectId: 'movieapp-8761b',
    storageBucket: 'movieapp-8761b.appspot.com',
    iosBundleId: 'com.example.adiMovieApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDet29WxHfvBiaFnwpDAxkdnRXYklLKWG8',
    appId: '1:758804125937:web:1f718554629d6f2f473150',
    messagingSenderId: '758804125937',
    projectId: 'movieapp-8761b',
    authDomain: 'movieapp-8761b.firebaseapp.com',
    storageBucket: 'movieapp-8761b.appspot.com',
    measurementId: 'G-FNM6PQC8W2',
  );
}
