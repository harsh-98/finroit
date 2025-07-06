import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextTheme createTextTheme(
  BuildContext context,
  String bodyFontString,
  String displayFontString,
) {
  TextTheme baseTextTheme = Theme.of(context).textTheme;
  TextTheme bodyTextTheme = GoogleFonts.getTextTheme(
    bodyFontString,
    baseTextTheme,
  );
  TextTheme displayTextTheme = GoogleFonts.getTextTheme(
    displayFontString,
    baseTextTheme,
  );
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


String notion(double x) {
  if (x > 1_000_000_000_000) {
    return '${(x / 1_000_000_000_000).toStringAsFixed(2)}T';
  } else if (x > 1_000_000_000) {
    return '${(x / 1_000_000_000).toStringAsFixed(2)}B';
  } else if (x > 1_000_000_000) {
    return '${(x / 1_000_000_000).toStringAsFixed(2)}B';
  } else if (x > 1_000_000) {
    return '${(x / 1_000_000).toStringAsFixed(2)}M';
  } else if (x > 1_000) {
    return '${(x / 1_000).toStringAsFixed(2)}K';
  } else {
    return x.toStringAsFixed(2);
  }
}

String formatDollar(double x) {
  return '\$${notion(x)}';
}

String formatPercent100(double x) {
  return '${(x*100)}%';
}