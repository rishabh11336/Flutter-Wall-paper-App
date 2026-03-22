import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/widgets/error_view.dart';
import '../home_provider.dart';
import 'wallpaper_card.dart';

/// 2-column grid of wallpaper cards.
///
/// Uses a standard [GridView] with a fixed cross-axis count and a 9:16
/// child aspect ratio to simulate a phone-screen shape.
class WallpaperGrid extends ConsumerWidget {
  const WallpaperGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wallpapersAsync = ref.watch(filteredWallpapersProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);

    return wallpapersAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => ErrorView(
        message: "Couldn't load wallpapers",
        onRetry: () => ref.invalidate(wallpaperManifestProvider),
      ),
      data: (wallpapers) {
        if (wallpapers.isEmpty) {
          return const ErrorView(
            message: 'No wallpapers in this category\nCheck back later for new additions',
            icon: Icons.photo_library_outlined,
          );
        }

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          transitionBuilder: (child, animation) => FadeTransition(
            opacity: animation,
            child: child,
          ),
          child: GridView.builder(
            key: ValueKey<String>(selectedCategory),
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 9 / 16,
            ),
            itemCount: wallpapers.length,
            itemBuilder: (context, index) {
              return WallpaperCard(wallpaper: wallpapers[index]);
            },
          ),
        );
      },
    );
  }
}
