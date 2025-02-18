
import 'package:cat_ai_gen/l10n/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

extension AppTextTheme on TextTheme {
  createTextTheme(
    String bodyFont,
    String displayFont,
  ) {
    TextTheme baseTextTheme = this;
    TextTheme bodyTextTheme = GoogleFonts.getTextTheme(bodyFont, baseTextTheme);
    TextTheme displayTextTheme =
        GoogleFonts.getTextTheme(displayFont, baseTextTheme);
    TextTheme textTheme = displayTextTheme.copyWith(
      bodyLarge: bodyTextTheme.bodyLarge,
      bodyMedium: bodyTextTheme.bodyMedium,
      bodySmall: bodyTextTheme.bodySmall,
      labelLarge: bodyTextTheme.labelLarge,
      labelMedium: bodyTextTheme.labelMedium,
      labelSmall: bodyTextTheme.labelSmall,
    );
    return textTheme;
  }
}

extension AppLocalizationsX on BuildContext {
  AppLocalizations get locale => AppLocalizations.of(this);
}
