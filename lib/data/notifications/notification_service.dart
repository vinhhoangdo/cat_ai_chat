import 'package:cat_ai_gen/firebase_options.dart';
import 'package:cat_ai_gen/utils/utils.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

class NotificationService {
  const NotificationService._();

  static Future<void> init() async {
    await _grantPermission();
    await _fcmRegistration();
  }

  static Future<void> _grantPermission() async {
    final messaging = FirebaseMessaging.instance;

    final settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (kDebugMode) {
      logging.i('Permission granted: ${settings.authorizationStatus}');
    }
  }

  static Future<void> _fcmRegistration() async {
    const vapidKey =
        "BAa86ysT85eE-V4dBoSySRhGB5PMNQeomGbrAd2FGkM5NxoSIEbz3WTrYFxM9cSct-3OTIWZ6EOX9I-FnHVilHA";

    // use the registration token to send messages to users from your trusted server environment
    String? token;

    if (DefaultFirebaseOptions.currentPlatform == DefaultFirebaseOptions.web) {
      token = await FirebaseMessaging.instance.getToken(
        vapidKey: vapidKey,
      );
      logging.i('Registration Web Token=$token');
    } else {
      token = await FirebaseMessaging.instance.getToken();
      logging.i('Registration Token=$token');
    }
  }
}
