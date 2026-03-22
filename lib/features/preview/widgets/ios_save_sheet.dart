import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';

/// iOS-specific bottom sheet shown instead of the Android wallpaper options.
///
/// Since iOS does not allow apps to programmatically set wallpapers, this sheet
/// offers a "Save to Photos" flow and instructs the user to set the wallpaper
/// manually via Settings > Wallpaper.
class IosSaveSheet extends StatelessWidget {
  const IosSaveSheet({super.key, required this.imageUrl});

  /// The full-resolution image URL to download and save.
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // Download icon
            Icon(
              Icons.photo_library_rounded,
              size: 48,
              color: theme.colorScheme.primary,
            ),
            const SizedBox(height: 16),

            // Heading
            Text(
              'Save to Photos',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),

            // Explanation text
            Text(
              'iOS does not allow apps to set wallpapers directly. '
              'Save this image to your Photos library, then open '
              'Settings > Wallpaper to set it.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            // Save button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _saveToPhotos(context),
                icon: const Icon(Icons.download_rounded),
                label: const Text('Save to Photos'),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  /// Downloads the image and saves it to the iOS photo library
  /// using [ImageGallerySaver].
  Future<void> _saveToPhotos(BuildContext context) async {
    // Show a loading dialog.
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    File? tempFile;

    try {
      // Download the image to a temp file.
      final tempDir = await getTemporaryDirectory();
      final filePath = '${tempDir.path}/wallcraft_ios_temp.jpg';
      tempFile = File(filePath);

      await Dio().download(imageUrl, filePath);

      // Save to photo library.
      final result = await ImageGallerySaver.saveFile(filePath);

      if (!context.mounted) return;

      // Dismiss loading dialog.
      Navigator.of(context).pop();
      // Dismiss the bottom sheet.
      Navigator.of(context).pop();

      final success = result != null &&
          (result is Map ? result['isSuccess'] == true : true);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            success
                ? 'Saved to Photos! Go to Settings > Wallpaper to set it.'
                : 'Failed to save image.',
          ),
          backgroundColor: success ? Colors.green : Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    } catch (e) {
      if (!context.mounted) return;

      // Dismiss loading dialog.
      Navigator.of(context).pop();
      // Dismiss the bottom sheet.
      Navigator.of(context).pop();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to save image.'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
    } finally {
      // Clean up temp file.
      if (tempFile != null && await tempFile.exists()) {
        await tempFile.delete();
      }
    }
  }
}
