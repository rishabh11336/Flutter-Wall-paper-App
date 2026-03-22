import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/theme/app_theme.dart';
import '../features/settings/settings_screen.dart';
import 'router.dart';

/// Root widget for the Wallpaper app.
///
/// Sets up MaterialApp with GoRouter, theme, and dynamic theme mode
/// controlled by [themeModeProvider] from the settings screen.
class WallpaperApp extends ConsumerWidget {
  const WallpaperApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      title: 'Wallcraft',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      routerConfig: router,
    );
  }
}
