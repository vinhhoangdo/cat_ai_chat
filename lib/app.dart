import 'package:cat_ai_gen/data/repositories/theme/theme_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class App extends StatefulWidget {
  const App({super.key, required this.child});
  final Widget child;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    final brightness = View.of(context).platformDispatcher.platformBrightness;
    context.read<ThemeRepository>().toggleThemeData(brightness);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
