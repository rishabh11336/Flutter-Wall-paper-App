import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../shared/widgets/error_view.dart';
import 'home_provider.dart';
import 'widgets/category_tab_bar.dart';
import 'widgets/shimmer_grid.dart';
import 'widgets/wallpaper_grid.dart';

/// Home screen — app bar, category tabs, and wallpaper grid.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final manifestAsync = ref.watch(wallpaperManifestProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('WallCraft'),
        actions: [
          // Search icon — navigates to the search screen
          IconButton(
            icon: const Icon(Icons.search_rounded),
            tooltip: 'Search',
            onPressed: () => context.pushNamed('search'),
          ),
        ],
      ),
      body: manifestAsync.when(
        loading: () => const Column(
          children: [
            // Show a disabled tab bar skeleton while loading.
            SizedBox(height: 56),
            Expanded(child: ShimmerGrid()),
          ],
        ),
        error: (error, _) => ErrorView(
          message: "Couldn't load wallpapers\nCheck your connection and try again",
          icon: Icons.cloud_off_rounded,
          onRetry: () => ref.invalidate(wallpaperManifestProvider),
        ),
        data: (_) => const Column(
          children: [
            CategoryTabBar(),
            Expanded(child: WallpaperGrid()),
          ],
        ),
      ),
    );
  }
}
