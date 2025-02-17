import 'package:cat_ai_gen/config/dependencies.dart';
import 'package:cat_ai_gen/core/core.dart';
import 'package:cat_ai_gen/firebase_options.dart';
import 'package:cat_ai_gen/routing/routing.dart';
import 'package:cat_ai_gen/utils/logging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:provider/provider.dart';

Future<void> _grantPermission() async {
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
    print('Permission granted: ${settings.authorizationStatus}');
  }
}

Future<void> _fcmRegistration() async {
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await _grantPermission();
  await _fcmRegistration();
  usePathUrlStrategy();
  runApp(
    MultiProvider(
      providers: providers,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router(context.read()),
      theme: AppTheme(context).theme(),
    );
  }
}
