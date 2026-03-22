import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Provides the light and dark [ThemeData] for the app.
///
/// - Uses [ColorScheme.fromSeed] with a deep indigo seed.
/// - [GoogleFonts.outfit] for headlines (distinctive display font).
/// - [GoogleFonts.inter] for body text (clean sans-serif).
/// - Consistent 12 px border radius on cards, chips, and buttons.
class AppTheme {
  AppTheme._();

  // ─── Border radius tokens ────────────────────────────────────────────
  static const double cardRadius = 12.0;
  static const double chipRadius = 20.0;
  static const double buttonRadius = 12.0;
  static const double bottomSheetRadius = 20.0;

  // ─── Light theme ─────────────────────────────────────────────────────
  static ThemeData get light {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.seed,
      brightness: Brightness.light,
    );

    return _buildTheme(colorScheme);
  }

  // ─── Dark theme ──────────────────────────────────────────────────────
  static ThemeData get dark {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.seed,
      brightness: Brightness.dark,
    );

    return _buildTheme(colorScheme);
  }

  // ─── Shared builder ──────────────────────────────────────────────────
  static ThemeData _buildTheme(ColorScheme colorScheme) {
    final isDark = colorScheme.brightness == Brightness.dark;

    final textTheme = _textTheme(colorScheme);

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      brightness: colorScheme.brightness,
      scaffoldBackgroundColor: colorScheme.surface,
      textTheme: textTheme,

      // AppBar
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 2,
        titleTextStyle: textTheme.titleLarge?.copyWith(
          color: colorScheme.onSurface,
        ),
      ),

      // Cards — slightly elevated from scaffold background
      cardTheme: CardThemeData(
        color: isDark
            ? colorScheme.surfaceContainerHigh
            : colorScheme.surfaceContainerLow,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(cardRadius),
        ),
        clipBehavior: Clip.antiAlias,
      ),

      // Chips
      chipTheme: ChipThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(chipRadius),
        ),
        selectedColor: colorScheme.primary,
        labelStyle: textTheme.labelLarge,
        side: BorderSide(color: colorScheme.outline),
      ),

      // Elevated buttons
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: colorScheme.onPrimary,
          backgroundColor: colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(buttonRadius),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          textStyle: textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // Bottom sheet
      bottomSheetTheme: BottomSheetThemeData(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(bottomSheetRadius),
          ),
        ),
        backgroundColor: colorScheme.surface,
      ),

      // Snackbar
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(cardRadius),
        ),
      ),
    );
  }

  // ─── Typography ──────────────────────────────────────────────────────
  static TextTheme _textTheme(ColorScheme colorScheme) {
    final displayFont = GoogleFonts.outfit(color: colorScheme.onSurface);
    final bodyFont = GoogleFonts.inter(color: colorScheme.onSurface);

    return TextTheme(
      // Display / Headlines — Outfit
      displayLarge: displayFont.copyWith(fontSize: 57, fontWeight: FontWeight.w700),
      displayMedium: displayFont.copyWith(fontSize: 45, fontWeight: FontWeight.w700),
      displaySmall: displayFont.copyWith(fontSize: 36, fontWeight: FontWeight.w600),
      headlineLarge: displayFont.copyWith(fontSize: 32, fontWeight: FontWeight.w600),
      headlineMedium: displayFont.copyWith(fontSize: 28, fontWeight: FontWeight.w600),
      headlineSmall: displayFont.copyWith(fontSize: 24, fontWeight: FontWeight.w600),
      titleLarge: displayFont.copyWith(fontSize: 22, fontWeight: FontWeight.w600),
      titleMedium: displayFont.copyWith(fontSize: 16, fontWeight: FontWeight.w600),
      titleSmall: displayFont.copyWith(fontSize: 14, fontWeight: FontWeight.w600),

      // Body / Labels — Inter
      bodyLarge: bodyFont.copyWith(fontSize: 16),
      bodyMedium: bodyFont.copyWith(fontSize: 14),
      bodySmall: bodyFont.copyWith(fontSize: 12),
      labelLarge: bodyFont.copyWith(fontSize: 14, fontWeight: FontWeight.w500),
      labelMedium: bodyFont.copyWith(fontSize: 12, fontWeight: FontWeight.w500),
      labelSmall: bodyFont.copyWith(fontSize: 11, fontWeight: FontWeight.w500),
    );
  }
}
