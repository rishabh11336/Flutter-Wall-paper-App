import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../../data/models/wallpaper.dart';
import '../home/home_provider.dart';

// ─── Hive box provider ──────────────────────────────────────────────────────

/// Provides the already-opened Hive box for favourite wallpaper IDs.
///
/// The box must be opened in main.dart via `Hive.openBox<String>('favourites')`
/// **before** `runApp` is called. This provider simply returns the reference.
final favouritesBoxProvider = Provider<Box<String>>((ref) {
  return Hive.box<String>('favourites');
});

// ─── Favourites state notifier ──────────────────────────────────────────────

/// Manages the list of favourite wallpaper IDs, persisted via Hive.
///
/// Exposes [toggle] to add/remove an ID and [isFavourite] to check state.
class FavouritesNotifier extends StateNotifier<List<String>> {
  FavouritesNotifier(this._box) : super(_box.values.toList());

  final Box<String> _box;

  /// Adds the [wallpaperId] if not present, removes it if present.
  /// Persists the updated list to the Hive box immediately.
  void toggle(String wallpaperId) {
    if (state.contains(wallpaperId)) {
      state = state.where((id) => id != wallpaperId).toList();
    } else {
      state = [...state, wallpaperId];
    }
    _persistToHive();
  }

  /// Returns `true` if the given [wallpaperId] is in the favourites list.
  bool isFavourite(String wallpaperId) {
    return state.contains(wallpaperId);
  }

  /// Writes the current state to Hive. Clears the box first, then adds
  /// all current IDs so the box stays in sync.
  void _persistToHive() {
    _box.clear();
    for (final id in state) {
      _box.add(id);
    }
  }
}

/// Provides the current list of favourite wallpaper IDs and exposes
/// [FavouritesNotifier] for add/remove operations.
final favouriteIdsProvider =
    StateNotifierProvider<FavouritesNotifier, List<String>>((ref) {
  final box = ref.watch(favouritesBoxProvider);
  return FavouritesNotifier(box);
});

// ─── Favourite wallpapers (filtered from manifest) ──────────────────────────

/// Watches the favourites list and the wallpaper manifest, returning only
/// the [Wallpaper] objects whose IDs are in the favourites.
final favouriteWallpapersProvider =
    Provider<AsyncValue<List<Wallpaper>>>((ref) {
  final favouriteIds = ref.watch(favouriteIdsProvider);
  final manifestAsync = ref.watch(wallpaperManifestProvider);

  return manifestAsync.whenData((manifest) {
    final idSet = favouriteIds.toSet();
    return manifest.wallpapers
        .where((w) => idSet.contains(w.id))
        .toList();
  });
});
