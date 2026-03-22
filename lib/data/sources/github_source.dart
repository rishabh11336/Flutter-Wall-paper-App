import 'package:dio/dio.dart';

import '../../core/constants.dart';
import '../models/wallpaper.dart';

/// Fetches and parses the wallpaper manifest from the GitHub repository.
///
/// Modified dynamically to scrape the Github API directory contents since the
/// user intends to simply upload files individually without manually building
/// a manifest.json.
class GitHubSource {
  GitHubSource({Dio? dio})
      : _dio = dio ??
            Dio(
              BaseOptions(
                connectTimeout: AppConstants.apiTimeout,
                receiveTimeout: AppConstants.apiTimeout,
              ),
            );

  final Dio _dio;

  /// Hits the GitHub REST API contents endpoint and maps raw files
  /// straight into our internal Wallpaper objects locally.
  Future<({List<String> categories, List<Wallpaper> wallpapers})>
      fetchManifest() async {
    final response = await _dio.get<List<dynamic>>(
      AppConstants.manifestUrl,
    );

    final List<dynamic> data = response.data!;
    final List<Wallpaper> wallpapers = [];

    // Process every file in the repository dynamically
    for (final item in data) {
      final fileInfo = item as Map<String, dynamic>;
      final type = fileInfo['type'] as String?;
      
      if (type != 'file') continue;

      final name = (fileInfo['name'] as String?) ?? '';
      final downloadUrl = (fileInfo['download_url'] as String?) ?? '';
      final sha = (fileInfo['sha'] as String?) ?? '';
      final lowerName = name.toLowerCase();

      // Filter to only include supported image payloads
      if (lowerName.endsWith('.jpg') ||
          lowerName.endsWith('.jpeg') ||
          lowerName.endsWith('.png') ||
          lowerName.endsWith('.webp')) {
        
        // Convert filename to readable title "Simple-Mountain-Backdrop.png" -> "Simple Mountain Backdrop"
        final title = name.split('.').first.replaceAll('-', ' ');

        wallpapers.add(
          Wallpaper(
            id: sha,
            title: title.isEmpty ? 'Untitled' : title,
            category: 'All Wallpapers',
            tags: title.toLowerCase().split(' '), // Create tags automatically from the title words
            url: downloadUrl,
            thumbUrl: downloadUrl, // Since we pull direct files, thumb maps identically
          ),
        );
      }
    }

    // Since files are in a flat root directory, we provide a single default category filter
    return (categories: ['All Wallpapers'], wallpapers: wallpapers);
  }
}
