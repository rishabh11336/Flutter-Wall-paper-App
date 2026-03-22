import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:path_provider/path_provider.dart';

/// Encapsulates the wallpaper download-and-set logic for Android.
///
/// Separates the I/O and platform work from the UI layer so that
/// [PreviewActionsSheet] only deals with showing/hiding dialogs.
class WallpaperSetter {
  WallpaperSetter({Dio? dio}) : _dio = dio ?? Dio();

  final Dio _dio;

  /// The filename used for the temporary downloaded image.
  static const String _tempFilename = 'wallcraft_temp.jpg';

  /// Downloads the full-resolution image from [imageUrl] to a temporary file
  /// and sets it as the device wallpaper at the given [location].
  ///
  /// [location] must be one of:
  /// - [WallpaperManager.HOME_SCREEN]
  /// - [WallpaperManager.LOCK_SCREEN]
  /// - [WallpaperManager.BOTH_SCREEN]
  ///
  /// Throws on network errors or if the platform call fails.
  /// Always cleans up the temporary file, even on failure.
  Future<void> setWallpaper(String imageUrl, int location) async {
    File? tempFile;

    try {
      // Step 1 — Download to a temporary file.
      final tempDir = await getTemporaryDirectory();
      final filePath = '${tempDir.path}/$_tempFilename';
      tempFile = File(filePath);

      await _dio.download(imageUrl, filePath);

      // Step 2 — Set the wallpaper using flutter_wallpaper_manager.
      await WallpaperManager.setWallpaperFromFile(filePath, location);
    } finally {
      // Step 3 — Clean up the temporary file.
      if (tempFile != null && await tempFile.exists()) {
        await tempFile.delete();
      }
    }
  }
}
