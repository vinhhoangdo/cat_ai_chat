import 'package:cat_ai_gen/core/core.dart';
import 'package:cat_ai_gen/utils/utils.dart';
import 'package:flutter/material.dart';

class ThemeRepository extends ChangeNotifier {
  ThemeData _themeData = AppTheme.light();

  ThemeData get themeData => _themeData;

  void toggleThemeData(Brightness brightness) {
    _themeData = switch (brightness) {
      Brightness.light => ThemeData.light(),
      _ => ThemeData.dark(),
    };
    logging.i("Toggle theme: ${_themeData.brightness}");
    notifyListeners();
  }
}
