import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

extension AppTextTheme on TextTheme {
  createTextTheme(
    BuildContext context,
    String bodyFont,
    String displayFont,
  ) {
    TextTheme baseTextTheme = Theme.of(context).textTheme;
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
