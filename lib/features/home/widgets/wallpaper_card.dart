import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/wallpaper.dart';
import '../../../shared/extensions/context_extensions.dart';
import '../../favourites/favourites_provider.dart';

/// A single wallpaper grid item with rounded corners, shimmer loading
/// placeholder, a Hero-animated tap gesture that navigates to the
/// preview screen, and a favourite heart badge (top-right) when hearted.
class WallpaperCard extends ConsumerWidget {
  const WallpaperCard({super.key, required this.wallpaper});

  final Wallpaper wallpaper;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the favourites list to determine heart badge visibility.
    final favouriteIds = ref.watch(favouriteIdsProvider);
    final isFavourite = favouriteIds.contains(wallpaper.id);

    return GestureDetector(
      onTap: () => context.pushNamed('preview', extra: wallpaper),
      child: Hero(
        tag: 'wallpaper_${wallpaper.id}',
        flightShuttleBuilder: (
          flightContext,
          animation,
          flightDirection,
          fromHeroContext,
          toHeroContext,
        ) {
          final startRadius = flightDirection == HeroFlightDirection.push
              ? BorderRadius.circular(AppTheme.cardRadius)
              : BorderRadius.zero;
          final endRadius = flightDirection == HeroFlightDirection.push
              ? BorderRadius.zero
              : BorderRadius.circular(AppTheme.cardRadius);

          return AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              final radius =
                  BorderRadius.lerp(startRadius, endRadius, animation.value)!;
              return ClipPath(
                clipper: ShapeBorderClipper(
                  shape: RoundedRectangleBorder(borderRadius: radius),
                ),
                child: CachedNetworkImage(
                  imageUrl: wallpaper.thumbUrl,
                  fit: BoxFit.cover,
                ),
              );
            },
          );
        },
        placeholderBuilder: (context, size, widget) {
          return Shimmer.fromColors(
            baseColor: context.isDark
                ? AppColors.imagePlaceholderDark
                : AppColors.imagePlaceholder,
            highlightColor: context.isDark
                ? AppColors.imagePlaceholderDark.withValues(alpha: 0.5)
                : Colors.white,
            child: Container(
              color: context.isDark
                  ? AppColors.imagePlaceholderDark
                  : AppColors.imagePlaceholder,
            ),
          );
        },
        child: Material(
          type: MaterialType.card,
          elevation: 3,
          borderRadius: BorderRadius.circular(AppTheme.cardRadius),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // ─── Image with shimmer placeholder ─────────────────────
              CachedNetworkImage(
                imageUrl: wallpaper.thumbUrl,
                fit: BoxFit.cover,
                placeholder: (_, __) => Shimmer.fromColors(
                  baseColor: context.isDark
                      ? AppColors.imagePlaceholderDark
                      : AppColors.imagePlaceholder,
                  highlightColor: context.isDark
                      ? AppColors.imagePlaceholderDark.withValues(alpha: 0.5)
                      : Colors.white,
                  child: Container(
                    color: context.isDark
                        ? AppColors.imagePlaceholderDark
                        : AppColors.imagePlaceholder,
                  ),
                ),
                errorWidget: (_, __, ___) => Container(
                  color: context.colorScheme.surfaceContainerHigh,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.broken_image_outlined,
                        size: 28,
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Image unavailable',
                        style: context.textTheme.labelSmall?.copyWith(
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ─── Favourite heart badge (top-right, only when fav) ───
              if (isFavourite)
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.4),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.favorite_rounded,
                      color: Colors.red,
                      size: 18,
                    ),
                  ),
                ),

              // ─── Bottom title overlay ──────────────────────────────
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        context.isDark
                            ? Colors.black.withValues(alpha: 0.55)
                            : Colors.black.withValues(alpha: 0.45),
                      ],
                    ),
                  ),
                  child: Text(
                    wallpaper.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.labelMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
