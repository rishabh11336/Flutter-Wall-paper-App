import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';

/// Handles downloading full-resolution wallpaper images to the device gallery.
///
/// Uses [Dio] for downloading, [path_provider] for temp storage, and
/// [image_gallery_saver] for saving to the platform gallery.
class ImageDownloader {
  ImageDownloader._();

  /// Downloads the image at [imageUrl] to a temporary file, saves it to the
  /// device gallery, then cleans up the temp file.
  ///
  /// Shows a non-dismissible loading dialog while downloading, followed by
  /// a success (green) or failure (red) SnackBar.
  static Future<void> downloadToGallery(
    String imageUrl,
    BuildContext context,
  ) async {
    // Step 1: Show a non-dismissible loading dialog.
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const PopScope(
        canPop: false,
        child: Center(
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Downloading...'),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    File? tempFile;

    try {
      // Step 2: Download image to a temporary file.
      final tempDir = await getTemporaryDirectory();
      final filePath = '${tempDir.path}/wallcraft_download_temp.jpg';
      tempFile = File(filePath);

      await Dio().download(imageUrl, filePath);

      // Step 3: Save to the device gallery.
      final result = await ImageGallerySaver.saveFile(filePath);

      // Step 4: Dismiss the loading dialog.
      if (context.mounted) Navigator.of(context).pop();

      // Step 5 / 6: Show feedback SnackBar.
      if (context.mounted) {
        final success = result != null && result['isSuccess'] == true;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              success
                  ? 'Saved to gallery'
                  : 'Failed to download. Please try again.',
            ),
            backgroundColor: success ? Colors.green : Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (_) {
      // Step 4: Dismiss the loading dialog on failure.
      if (context.mounted) Navigator.of(context).pop();

      // Step 6: Show failure SnackBar.
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to download. Please try again.'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      // Step 7: Always delete the temporary file.
      if (tempFile != null && tempFile.existsSync()) {
        tempFile.deleteSync();
      }
    }
  }
}
