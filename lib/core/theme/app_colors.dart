import 'package:flutter/material.dart';

/// Semantic color tokens used across the app.
///
/// Actual values come from [ColorScheme.fromSeed] in app_theme.dart;
/// this class holds any supplementary named colors.
class AppColors {
  AppColors._();

  /// Seed color for [ColorScheme.fromSeed].
  static const Color seed = Color(0xFF1A237E); // deep indigo

  /// Overlay gradient for the preview screen bottom bar.
  static const List<Color> previewGradient = [
    Colors.transparent,
    Colors.black87,
  ];

  /// Placeholder background for broken images.
  static const Color imagePlaceholder = Color(0xFFE0E0E0);
  static const Color imagePlaceholderDark = Color(0xFF424242);
}
