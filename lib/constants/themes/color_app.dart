import 'package:flutter/material.dart';

/// [INFO]
/// Constant for colors to be used in the app with following the design system
class ColorApp {
  static const Color primary = Color(0xFF8B4F25);
  static const Color surfaceTint = Color(0xFF8B4F25);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFFFFDBC8);
  static const Color onPrimaryContainer = Color(0xFF311300);
  static const Color secondary = Color(0xFF755846);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color secondaryContainer = Color(0xFFFFDBC8);
  static const Color onSecondaryContainer = Color(0xFF2B1709);
  static const Color tertiary = Color(0xFF616133);
  static const Color onTertiary = Color(0xFFFFFFFF);
  static const Color tertiaryContainer = Color(0xFFE7E6AC);
  static const Color onTertiaryContainer = Color(0xFF1D1D00);
  static const Color error = Color(0xFFBA1A1A);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color errorContainer = Color(0xFFFFDAD6);
  static const Color onErrorContainer = Color(0xFF410002);
  static const Color background = Color(0xFFFFF8F5);
  static const Color onBackground = Color(0xFF221A15);
  static const Color surface = Color(0xFFFFF8F5);
  static const Color onSurface = Color(0xFF221A15);
  static const Color surfaceVariant = Color(0xFFF4DED3);
  static const Color onSurfaceVariant = Color(0xFF52443C);
  static const Color outline = Color(0xFF84746B);
  static const Color outlineVariant = Color(0xFFD7C3B8);
  static const Color shadow = Color(0xFF000000);
  static const Color scrim = Color(0xFF000000);
  static const Color inverseSurface = Color(0xFF382E29);
  static const Color inverseOnSurface = Color(0xFFFFEDE5);
  static const Color inversePrimary = Color(0xFFFFB689);
  static const Color primaryFixed = Color(0xFFFFDBC8);
  static const Color onPrimaryFixed = Color(0xFF311300);
  static const Color primaryFixedDim = Color(0xFFFFB689);
  static const Color onPrimaryFixedVariant = Color(0xFF6E380F);
  static const Color secondaryFixed = Color(0xFFFFDBC8);
  static const Color onSecondaryFixed = Color(0xFF2B1709);
  static const Color secondaryFixedDim = Color(0xFFE5BFA9);
  static const Color onSecondaryFixedVariant = Color(0xFF5C4130);
  static const Color tertiaryFixed = Color(0xFFE7E6AC);
  static const Color onTertiaryFixed = Color(0xFF1D1D00);
  static const Color tertiaryFixedDim = Color(0xFFCBC993);
  static const Color onTertiaryFixedVariant = Color(0xFF49491E);
  static const Color surfaceDim = Color(0xFFE7D7CF);
  static const Color surfaceBright = Color(0xFFFFF8F5);
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color surfaceContainerLow = Color(0xFFFFF1EA);
  static const Color surfaceContainer = Color(0xFFFCEBE2);
  static const Color surfaceContainerHigh = Color(0xFFF6E5DC);
  static const Color surfaceContainerHighest = Color(0xFFF0DFD7);
}

ColorScheme get colorSchemeLight => const ColorScheme(
      brightness: Brightness.light,
      primary: ColorApp.primary,
      onPrimary: ColorApp.onPrimary,
      primaryContainer: ColorApp.primaryContainer,
      onPrimaryContainer: ColorApp.onPrimaryContainer,
      secondary: ColorApp.secondary,
      onSecondary: ColorApp.onSecondary,
      secondaryContainer: ColorApp.secondaryContainer,
      onSecondaryContainer: ColorApp.onSecondaryContainer,
      tertiary: ColorApp.tertiary,
      onTertiary: ColorApp.onTertiary,
      tertiaryContainer: ColorApp.tertiaryContainer,
      onTertiaryContainer: ColorApp.onTertiaryContainer,
      error: ColorApp.error,
      onError: ColorApp.onError,
      errorContainer: ColorApp.errorContainer,
      onErrorContainer: ColorApp.onErrorContainer,
      surface: ColorApp.surface,
      onSurface: ColorApp.onSurface,
      surfaceContainerHighest: ColorApp.surfaceVariant,
      onSurfaceVariant: ColorApp.onSurfaceVariant,
      outline: ColorApp.outline,
      shadow: ColorApp.shadow,
      inverseSurface: ColorApp.inverseSurface,
      onInverseSurface: ColorApp.inverseOnSurface,
      inversePrimary: ColorApp.inversePrimary,
      surfaceTint: ColorApp.surfaceTint,
    );
