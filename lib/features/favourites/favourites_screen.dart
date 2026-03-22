import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../shared/widgets/error_view.dart';
import '../home/home_provider.dart';
import '../home/widgets/shimmer_grid.dart';
import '../home/widgets/wallpaper_card.dart';
import 'favourites_provider.dart';

/// Favourites screen — displays wallpapers the user has hearted.
///
/// Watches [favouriteWallpapersProvider] which reactively filters the
/// manifest to only include wallpapers whose IDs are in the Hive box.
class FavouritesScreen extends ConsumerWidget {
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favouritesAsync = ref.watch(favouriteWallpapersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourites'),
      ),
      body: favouritesAsync.when(
        // ─── Loading state ────────────────────────────────────────────
        loading: () => const ShimmerGrid(),

        // ─── Error state ──────────────────────────────────────────────
        error: (error, _) => ErrorView(
          message: "Couldn't load favourites",
          onRetry: () => ref.invalidate(wallpaperManifestProvider),
        ),

        // ─── Data state ──────────────────────────────────────────────
        data: (wallpapers) {
          // Empty favourites
          if (wallpapers.isEmpty) {
            return const ErrorView(
              icon: Icons.favorite_border_rounded,
              message:
                  'No favourites yet\nTap the heart on any wallpaper to save it here',
            );
          }

          // Favourites grid — same 2-column layout as the home screen
          return GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 9 / 16, // phone-screen ratio
            ),
            itemCount: wallpapers.length,
            itemBuilder: (context, index) {
              return WallpaperCard(wallpaper: wallpapers[index]);
            },
          );
        },
      ),
    );
  }
}
