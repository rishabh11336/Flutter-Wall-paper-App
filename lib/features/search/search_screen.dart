import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/wallpaper.dart';
import '../../shared/widgets/error_view.dart';
import '../home/home_provider.dart';
import '../home/widgets/shimmer_grid.dart';
import '../home/widgets/wallpaper_card.dart';
import 'search_provider.dart';

/// Full search screen with live filtering as the user types.
///
/// Reached by tapping the search icon in the HomeScreen AppBar.
/// Matches against wallpaper title, category, and tags (case-insensitive).
class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: ref.read(searchQueryProvider),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = ref.watch(searchQueryProvider);
    final resultsAsync = ref.watch(searchResultsProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        // ─── Search text field in the AppBar ───────────────────────────
        title: TextField(
          controller: _controller,
          autofocus: true,
          cursorColor: theme.colorScheme.primary,
          style: theme.textTheme.bodyLarge,
          decoration: InputDecoration(
            hintText: 'Search wallpapers...',
            border: InputBorder.none,
            hintStyle: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
            ),
            // Clear button when query is non-empty
            suffixIcon: query.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear_rounded),
                    onPressed: () {
                      _controller.clear();
                      ref.read(searchQueryProvider.notifier).state = '';
                    },
                  )
                : null,
          ),
          onChanged: (value) {
            ref.read(searchQueryProvider.notifier).state = value;
          },
        ),
      ),

      body: _buildBody(query, resultsAsync, theme),
    );
  }

  Widget _buildBody(
    String query,
    AsyncValue<List<Wallpaper>> resultsAsync,
    ThemeData theme,
  ) {
    // ─── Empty query — prompt to start typing ──────────────────────────
    if (query.isEmpty) {
      return const ErrorView(
        icon: Icons.search_rounded,
        message:
            'Search wallpapers\nTry a title, category, or tag like "nature" or "4K"',
      );
    }

    // ─── Async states ──────────────────────────────────────────────────
    return resultsAsync.when(
      loading: () => const ShimmerGrid(),
      error: (error, _) => ErrorView(
        message: "Couldn't load wallpapers",
        onRetry: () => ref.invalidate(wallpaperManifestProvider),
      ),
      data: (wallpapers) {
        // No results for the current query
        if (wallpapers.isEmpty) {
          return ErrorView(
            icon: Icons.image_search_rounded,
            message:
                'No results for "$query"\nTry a different word or category',
          );
        }

        // Results grid — same layout as home screen
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          transitionBuilder: (child, animation) => FadeTransition(
            opacity: animation,
            child: child,
          ),
          child: GridView.builder(
            key: ValueKey<String>(query),
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
