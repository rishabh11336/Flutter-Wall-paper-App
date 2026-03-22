import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/wallpaper.dart';
import '../home/home_provider.dart';

// ─── Search query ───────────────────────────────────────────────────────────

/// The current search query string. Empty string means no active search.
final searchQueryProvider = StateProvider<String>((ref) => '');

// ─── Search results ─────────────────────────────────────────────────────────

/// Watches [wallpaperManifestProvider] and [searchQueryProvider] to return
/// filtered wallpapers matching the search query.
///
/// Matches are case-insensitive against:
/// - [Wallpaper.title]
/// - [Wallpaper.category]
/// - [Wallpaper.tags] (any tag that contains the query)
///
/// When the query is empty, returns all wallpapers.
final searchResultsProvider = Provider<AsyncValue<List<Wallpaper>>>((ref) {
  final manifestAsync = ref.watch(wallpaperManifestProvider);
  final query = ref.watch(searchQueryProvider).trim().toLowerCase();

  return manifestAsync.whenData((manifest) {
    if (query.isEmpty) {
      return manifest.wallpapers;
    }

    return manifest.wallpapers.where((w) {
      final titleMatch = w.title.toLowerCase().contains(query);
      final categoryMatch = w.category.toLowerCase().contains(query);
      final tagMatch = w.tags.any(
        (tag) => tag.toLowerCase().contains(query),
      );
      return titleMatch || categoryMatch || tagMatch;
    }).toList();
  });
});
