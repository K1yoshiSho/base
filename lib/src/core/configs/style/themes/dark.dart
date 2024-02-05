import 'package:base_starter/src/core/utils/extensions/colors_extension.dart';
import 'package:flutter/material.dart';

/// {@template app_theme}
/// `getBaseDarkTheme` is a function that returns a Dark `ThemeData` for the app.
/// {@endtemplate}
ThemeData getBaseDarkTheme({required Color seed}) {
  final ThemeData baseTheme = ThemeData.from(
    colorScheme: ColorScheme.fromSeed(
      seedColor: seed,
      brightness: Brightness.dark,
    ),
  ).copyWith(
    appBarTheme: const AppBarTheme(
      scrolledUnderElevation: 0,
    ),
  );
  return baseTheme.copyWith(
    extensions: [
      AppColorsExtension(
        primary: baseTheme.colorScheme.primary,
        onPrimary: baseTheme.colorScheme.onPrimary,
        secondary: baseTheme.colorScheme.secondary,
        onSecondary: baseTheme.colorScheme.onSecondary,
        error: baseTheme.colorScheme.error,
        onError: baseTheme.colorScheme.onError,
        background: baseTheme.colorScheme.background,
        onBackground: baseTheme.colorScheme.onBackground,
        surface: baseTheme.colorScheme.surface,
        onSurface: baseTheme.colorScheme.onSurface,
        divider: Colors.grey[700]!,
        text: Colors.white,
        border: Colors.grey[600]!,
        card: Colors.grey.withOpacity(0.1),
        shadow: const Color.fromARGB(255, 211, 211, 211),
        shimmerBase: const Color(0xffB4B4B4),
        shimmerHighlight: Colors.white,
      ),
    ],
  );
}
