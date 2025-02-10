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
    apiKey: 'AIzaSyBtCR5rHQ3C_G39ehobRbQQG1RGI3-ahVQ',
    appId: '1:346724123785:web:db564271dbfdf28285f258',
    messagingSenderId: '346724123785',
    projectId: 'simple-chat-app-5840f',
    authDomain: 'simple-chat-app-5840f.firebaseapp.com',
    storageBucket: 'simple-chat-app-5840f.firebasestorage.app',
    measurementId: 'G-R9N6TFMP3G',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBE-xTU9YsKAVaUZcn66JD7B3Lavrd5Yq4',
    appId: '1:346724123785:android:8cf2fad39a751a1085f258',
    messagingSenderId: '346724123785',
    projectId: 'simple-chat-app-5840f',
    storageBucket: 'simple-chat-app-5840f.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCzZXQEXCsNCg-Gds2jXP0aavb_zTt_51s',
    appId: '1:346724123785:ios:64f828e19b91cc5d85f258',
    messagingSenderId: '346724123785',
    projectId: 'simple-chat-app-5840f',
    storageBucket: 'simple-chat-app-5840f.firebasestorage.app',
    iosBundleId: 'com.example.catAiGen',
  );
}
