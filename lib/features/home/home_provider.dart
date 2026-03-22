import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/wallpaper.dart';
import '../../data/repositories/wallpaper_repository.dart';

// ─── Repository provider ────────────────────────────────────────────────────

final wallpaperRepositoryProvider = Provider<WallpaperRepository>((ref) {
  return WallpaperRepository();
});

// ─── Manifest provider ──────────────────────────────────────────────────────

/// Fetches & caches the full wallpaper manifest from GitHub.
///
/// Returns a record of `(categories, wallpapers)`.
/// Call `ref.invalidate(wallpaperManifestProvider)` to force a refresh.
final wallpaperManifestProvider = FutureProvider<
    ({List<String> categories, List<Wallpaper> wallpapers})>((ref) async {
  final repo = ref.watch(wallpaperRepositoryProvider);
  return repo.getManifest();
});

// ─── Selected category ──────────────────────────────────────────────────────

/// Currently selected category tab. Defaults to "All".
final selectedCategoryProvider = StateProvider<String>((ref) => 'All');

// ─── Filtered wallpapers ────────────────────────────────────────────────────

/// Watches [wallpaperManifestProvider] and [selectedCategoryProvider] to
/// return a filtered list of wallpapers.
///
/// When the selected category is "All", all wallpapers are returned.
final filteredWallpapersProvider = Provider<AsyncValue<List<Wallpaper>>>((ref) {
  final manifestAsync = ref.watch(wallpaperManifestProvider);
  final selectedCategory = ref.watch(selectedCategoryProvider);

  return manifestAsync.whenData((manifest) {
    if (selectedCategory == 'All') {
      return manifest.wallpapers;
    }
    return manifest.wallpapers
        .where((w) => w.category == selectedCategory)
        .toList();
  });
});

/// Provides the full category list with "All" prepended.
final categoriesProvider = Provider<AsyncValue<List<String>>>((ref) {
  final manifestAsync = ref.watch(wallpaperManifestProvider);
  return manifestAsync.whenData((manifest) {
    return ['All', ...manifest.categories];
  });
});
