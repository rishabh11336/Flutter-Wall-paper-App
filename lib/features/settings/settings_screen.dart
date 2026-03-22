import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/extensions/context_extensions.dart';

// ─── Theme mode provider ────────────────────────────────────────────────────

/// Stores the user's selected theme mode.
/// Watched by [WallpaperApp] in app.dart to switch themes live.
final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.system);

// ─── Settings Screen ────────────────────────────────────────────────────────

/// Settings screen with theme toggle, about info, and cache management.
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final currentMode = ref.watch(themeModeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          // ─── Theme mode toggle ────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Appearance',
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Theme mode',
                        style: theme.textTheme.bodyLarge,
                      ),
                    ),
                    SegmentedButton<ThemeMode>(
                      segments: const [
                        ButtonSegment(
                          value: ThemeMode.system,
                          label: Text('System'),
                          icon: Icon(Icons.settings_brightness_rounded),
                        ),
                        ButtonSegment(
                          value: ThemeMode.light,
                          label: Text('Light'),
                          icon: Icon(Icons.light_mode_rounded),
                        ),
                        ButtonSegment(
                          value: ThemeMode.dark,
                          label: Text('Dark'),
                          icon: Icon(Icons.dark_mode_rounded),
                        ),
                      ],
                      selected: {currentMode},
                      onSelectionChanged: (selected) {
                        ref.read(themeModeProvider.notifier).state =
                            selected.first;
                      },
                      style: ButtonStyle(
                        visualDensity: VisualDensity.compact,
                        textStyle: WidgetStatePropertyAll(
                          theme.textTheme.labelSmall,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const Divider(),

          // ─── About tile ───────────────────────────────────────────────
          ListTile(
            leading: const Icon(Icons.info_outline_rounded),
            title: const Text('About WallCraft'),
            subtitle: const Text('Version 1.0.0'),
            onTap: () => _showAboutDialog(context),
          ),

          // ─── Clear image cache tile ───────────────────────────────────
          ListTile(
            leading: const Icon(Icons.delete_sweep_rounded),
            title: const Text('Clear image cache'),
            subtitle: const Text('Free up storage used by cached images'),
            onTap: () => _clearImageCache(context),
          ),
        ],
      ),
    );
  }

  /// Shows an AlertDialog with app information.
  void _showAboutDialog(BuildContext context) {
    final theme = Theme.of(context);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: context.colorScheme.surfaceContainerHigh,
        title: Row(
          children: [
            Icon(
              Icons.wallpaper_rounded,
              color: theme.colorScheme.primary,
            ),
            const SizedBox(width: 12),
            const Text('WallCraft'),
          ],
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Version 1.0.0'),
            SizedBox(height: 12),
            Text(
              'A beautiful wallpaper app that lets you browse, preview, '
              'and set stunning wallpapers from a curated collection '
              'hosted on GitHub.',
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  /// Clears the image cache and shows a confirmation SnackBar.
  void _clearImageCache(BuildContext context) {
    // Clear the CachedNetworkImage disk and memory cache.
    CachedNetworkImage.evictFromCache('');
    PaintingBinding.instance.imageCache.clear();
    PaintingBinding.instance.imageCache.clearLiveImages();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Image cache cleared'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
