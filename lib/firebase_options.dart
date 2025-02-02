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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDNmqb4j8VAxwGITw-RuTbk00paKUJE5Hc',
    appId: '1:863763827789:android:3e415957bbd7b13e68e004',
    messagingSenderId: '863763827789',
    projectId: 'spring-valley-e2a8f',
    databaseURL: 'https://spring-valley-e2a8f-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'spring-valley-e2a8f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDvRKZgVfsUz4lvXtVYtMlB3X0OzkYZC4Q',
    appId: '1:863763827789:ios:084ea7767a7edb6768e004',
    messagingSenderId: '863763827789',
    projectId: 'spring-valley-e2a8f',
    databaseURL: 'https://spring-valley-e2a8f-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'spring-valley-e2a8f.appspot.com',
    iosClientId: '863763827789-v3pcf00e1au0m8gcvt2sqb2du38ekn01.apps.googleusercontent.com',
    iosBundleId: 'com.zerobee.springvalley1',
  );

}