import 'package:flutter/material.dart';

/// Convenience extensions on [BuildContext] for quick access to
/// theme data and screen dimensions.
extension ContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => theme.colorScheme;
  TextTheme get textTheme => theme.textTheme;
  MediaQueryData get mq => MediaQuery.of(this);
  double get screenWidth => mq.size.width;
  double get screenHeight => mq.size.height;
  EdgeInsets get padding => mq.padding;
  bool get isDark => theme.brightness == Brightness.dark;
}
