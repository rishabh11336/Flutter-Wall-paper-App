import 'package:flutter/material.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';

import '../wallpaper_setter.dart';

/// Bottom sheet shown on Android when the user taps "Set Wallpaper".
///
/// Offers three options: Home screen, Lock screen, Both.
/// Each option downloads the full-res image and sets it via
/// [WallpaperSetter], showing a loading dialog during the operation.
class PreviewActionsSheet extends StatelessWidget {
  const PreviewActionsSheet({
    super.key,
    required this.imageUrl,
  });

  /// The full-resolution image URL to download and set.
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            Text(
              'Set wallpaper as',
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 12),

            _ActionTile(
              icon: Icons.phone_android_rounded,
              label: 'Home screen',
              onTap: () => _setWallpaper(
                context,
                WallpaperManager.HOME_SCREEN,
              ),
            ),
            _ActionTile(
              icon: Icons.lock_outline_rounded,
              label: 'Lock screen',
              onTap: () => _setWallpaper(
                context,
                WallpaperManager.LOCK_SCREEN,
              ),
            ),
            _ActionTile(
              icon: Icons.smartphone_rounded,
              label: 'Both',
              onTap: () => _setWallpaper(
                context,
                WallpaperManager.BOTH_SCREEN,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Downloads the image, sets the wallpaper, and handles loading/error states.
  Future<void> _setWallpaper(BuildContext context, int location) async {
    // Close the bottom sheet first.
    Navigator.of(context).pop();

    // Step 1 — Show a non-dismissible loading dialog.
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const _LoadingDialog(),
    );

    try {
      // Steps 2 & 3 — Download and set the wallpaper.
      await WallpaperSetter().setWallpaper(imageUrl, location);

      if (!context.mounted) return;

      // Step 4a — Dismiss loading dialog & show success SnackBar.
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Wallpaper set successfully'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 3),
        ),
      );
    } catch (e) {
      if (!context.mounted) return;

      // Step 4b — Dismiss loading dialog & show error SnackBar.
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to set wallpaper. Please try again.'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
    }
  }
}

// ─── Loading Dialog ─────────────────────────────────────────────────────────

/// Non-dismissible dialog shown while the wallpaper is being downloaded
/// and applied.
class _LoadingDialog extends StatelessWidget {
  const _LoadingDialog();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: AlertDialog(
        content: Row(
          children: [
            const CircularProgressIndicator(),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                'Applying wallpaper...',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Action Tile ────────────────────────────────────────────────────────────

/// A single option row in the actions bottom sheet.
class _ActionTile extends StatelessWidget {
  const _ActionTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      onTap: onTap,
    );
  }
}
