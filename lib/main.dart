import 'package:cat_ai_gen/app.dart';
import 'package:cat_ai_gen/config/dependencies.dart';
import 'package:cat_ai_gen/data/data.dart';
import 'package:cat_ai_gen/firebase_options.dart';
import 'package:cat_ai_gen/l10n/gen_l10n/app_localizations.dart';
import 'package:cat_ai_gen/routing/routing.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:provider/provider.dart';

void main() async {
  await initLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await NotificationService.init();
  usePathUrlStrategy();
  runApp(
    MultiProvider(
      providers: providers,
      child: App(child: const MyApp()),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeRepository>(
      builder: (context, notifier, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: router(context.read()),
          theme: notifier.themeData,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        );
      },
    );
  }
}
