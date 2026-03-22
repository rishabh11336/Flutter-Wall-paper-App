import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/favourites/favourites_screen.dart';
import '../features/home/home_screen.dart';
import '../features/settings/settings_screen.dart';

// ─── Tab index provider ─────────────────────────────────────────────────────

/// Tracks the currently selected bottom navigation tab.
/// 0 = Home, 1 = Favourites, 2 = Settings.
final selectedTabProvider = StateProvider<int>((ref) => 0);

// ─── Shell Screen ───────────────────────────────────────────────────────────

/// Root scaffold that holds the [BottomNavigationBar] and an [IndexedStack]
/// of the three tab screens.
///
/// Uses [IndexedStack] to preserve scroll position and widget state when
/// switching between tabs — no Navigator-based tab routing.
class ShellScreen extends ConsumerWidget {
  const ShellScreen({super.key});

  /// The three tab body widgets. Order matches the BottomNavigationBar items.
  static const List<Widget> _screens = [
    HomeScreen(),
    FavouritesScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTab = ref.watch(selectedTabProvider);
    final theme = Theme.of(context);

    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        transitionBuilder: (child, animation) => FadeTransition(
          opacity: animation,
          child: child,
        ),
        child: IndexedStack(
          key: ValueKey<int>(currentTab),
          index: currentTab,
          children: _screens,
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentTab,
        onDestinationSelected: (index) {
          ref.read(selectedTabProvider.notifier).state = index;
        },
        backgroundColor: theme.colorScheme.surface,
        indicatorColor: theme.colorScheme.primaryContainer,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.grid_view_rounded),
            selectedIcon: Icon(Icons.grid_view_rounded),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_outline_rounded),
            selectedIcon: Icon(Icons.favorite_rounded),
            label: 'Favourites',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings_rounded),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
