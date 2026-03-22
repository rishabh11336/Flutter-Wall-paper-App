import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../data/models/wallpaper.dart';
import '../features/preview/preview_screen.dart';
import '../features/search/search_screen.dart';
import 'shell_screen.dart';

/// GoRouter configuration provider.
///
/// Defines the following route structure:
/// - `/`        → ShellScreen (bottom nav with IndexedStack)
/// - `/search`  → SearchScreen (inside shell — keeps bottom nav visible)
/// - `/preview` → PreviewScreen (full-screen wallpaper view, outside shell)
///
/// The ShellScreen wraps three tab destinations (Home, Favourites, Settings)
/// using an IndexedStack, so tab state and scroll position are preserved.
/// The preview route is kept outside the shell so it displays full-screen
/// without the bottom navigation bar.
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      // ─── Main shell with bottom navigation ──────────────────────────
      GoRoute(
        path: '/',
        name: 'home',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const ShellScreen(),
          transitionDuration: const Duration(milliseconds: 300),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // The outgoing content (home screen) fades out to 0% opacity 
            // in the first 30% of the transition when something is pushed over it.
            final fadeOut = Tween<double>(begin: 1.0, end: 0.0).animate(
              CurvedAnimation(
                parent: secondaryAnimation,
                curve: const Interval(0.0, 0.3, curve: Curves.easeInOut),
              ),
            );

            return FadeTransition(
              opacity: fadeOut,
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
        ),
      ),

      // ─── Search screen (inside shell — bottom nav stays visible) ────
      GoRoute(
        path: '/search',
        name: 'search',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const SearchScreen(),
          transitionDuration: const Duration(milliseconds: 300),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Fades in from 0% to 100% in the last 70% of the animation.
            final fadeIn = Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                parent: animation,
                curve: const Interval(0.3, 1.0, curve: Curves.easeInOut),
              ),
            );
            
            // Allow this screen to also fade out if something else goes over it.
            final fadeOut = Tween<double>(begin: 1.0, end: 0.0).animate(
              CurvedAnimation(
                parent: secondaryAnimation,
                curve: const Interval(0.0, 0.3, curve: Curves.easeInOut),
              ),
            );

            return FadeTransition(
              opacity: fadeOut,
              child: FadeTransition(
                opacity: fadeIn,
                child: child,
              ),
            );
          },
        ),
      ),

      // ─── Full-screen preview (outside the shell — no bottom nav) ────
      GoRoute(
        path: '/preview',
        name: 'preview',
        pageBuilder: (context, state) {
          final wallpaper = state.extra as Wallpaper;
          return CustomTransitionPage(
            key: state.pageKey,
            child: PreviewScreen(wallpaper: wallpaper),
            transitionDuration: const Duration(milliseconds: 350),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              // Fades in AND slides up slightly from 8% below its final position.
              final curvedAnim = CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutCubic,
              );

              final slideAnim = Tween<Offset>(
                begin: const Offset(0.0, 0.08),
                end: Offset.zero,
              ).animate(curvedAnim);

              return SlideTransition(
                position: slideAnim,
                child: FadeTransition(
                  opacity: curvedAnim,
                  child: child,
                ),
              );
            },
          );
        },
      ),
    ],
  );
});
