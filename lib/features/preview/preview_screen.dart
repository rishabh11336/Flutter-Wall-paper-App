import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/theme/app_theme.dart';
import '../../data/models/wallpaper.dart';
import '../../shared/extensions/context_extensions.dart';
import '../favourites/favourites_provider.dart';
import 'image_downloader.dart';
import 'widgets/ios_save_sheet.dart';
import 'widgets/preview_actions_sheet.dart';

/// Full-screen wallpaper preview with transparent overlaid controls.
///
/// Features:
/// - Hero animation from the grid card.
/// - Loading progress indicator while full-res image loads.
/// - Gradient bottom bar with title, resolution badge, Set Wallpaper button,
///   a favourite heart button, and a Download button.
/// - Platform-aware wallpaper setting: Android gets the three-option sheet,
///   iOS gets the "Save to Photos" sheet.
class PreviewScreen extends ConsumerStatefulWidget {
  const PreviewScreen({super.key, required this.wallpaper});

  final Wallpaper wallpaper;

  @override
  ConsumerState<PreviewScreen> createState() => _PreviewScreenState();
}

class _PreviewScreenState extends ConsumerState<PreviewScreen> {
  Animation<double>? _routeAnimation;

  @override
  void initState() {
    super.initState();
    // Force edge-to-edge immersive mode on the preview screen.
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Cache the route animation and listen for the pop flight completion
    // to restore System UI without causing a visible blink during flight.
    _routeAnimation ??= ModalRoute.of(context)?.animation
      ?..addStatusListener(_onRouteAnimation);
  }

  void _onRouteAnimation(AnimationStatus status) {
    if (status == AnimationStatus.dismissed) {
      SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.manual,
        overlays: SystemUiOverlay.values,
      );
    }
  }

  @override
  void dispose() {
    _routeAnimation?.removeStatusListener(_onRouteAnimation);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Watch favourites to toggle heart icon state.
    final favouriteIds = ref.watch(favouriteIdsProvider);
    final isFavourite = favouriteIds.contains(widget.wallpaper.id);

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,

      // ─── Transparent app bar overlaid on the image ──────────────────
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        elevation: 0,
        title: Text(
          widget.wallpaper.title,
          style: context.textTheme.titleMedium?.copyWith(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),

      body: Stack(
        fit: StackFit.expand,
        children: [
          // ─── Full-screen image ──────────────────────────────────────
          Hero(
            tag: 'wallpaper_${widget.wallpaper.id}',
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
                  final radius = BorderRadius.lerp(
                      startRadius, endRadius, animation.value)!;
                  return ClipPath(
                    clipper: ShapeBorderClipper(
                      shape: RoundedRectangleBorder(borderRadius: radius),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: widget.wallpaper.thumbUrl,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              );
            },
            placeholderBuilder: (context, size, child) {
              return Shimmer.fromColors(
                baseColor: context.isDark
                    ? context.colorScheme.surfaceContainerHigh
                    : context.colorScheme.surfaceContainerLow,
                highlightColor: context.isDark
                    ? context.colorScheme.surfaceContainerLow
                    : context.colorScheme.surfaceContainerHigh,
                child: Container(
                  color: context.isDark
                      ? context.colorScheme.surfaceContainerHigh
                      : context.colorScheme.surfaceContainerLow,
                ),
              );
            },
            child: CachedNetworkImage(
              imageUrl: widget.wallpaper.url,
              fit: BoxFit.cover,
              progressIndicatorBuilder: (_, __, progress) {
                return Center(
                  child: CircularProgressIndicator(
                    value: progress.progress,
                    color: Colors.white,
                    strokeWidth: 3,
                  ),
                );
              },
              errorWidget: (_, __, ___) => Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.broken_image_outlined,
                      size: 36,
                      color: Colors.white38,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Image unavailable',
                      style: context.textTheme.labelMedium?.copyWith(
                        color: Colors.white38,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ─── Bottom gradient overlay with controls ──────────────────
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 40,
                bottom: context.padding.bottom + 20,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    context.isDark
                        ? Colors.black.withValues(alpha: 0.85)
                        : Colors.black.withValues(alpha: 0.70),
                  ],
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    widget.wallpaper.title,
                    style: context.textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),

                  // Resolution badge
                  if (widget.wallpaper.resolution != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        widget.wallpaper.resolution!,
                        style: context.textTheme.labelSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  const SizedBox(height: 20),

                  // Action row
                  Row(
                    children: [
                      // Set Wallpaper / Save to Photos button
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => _onSetWallpaperTapped(context),
                          icon: const Icon(Icons.wallpaper_rounded),
                          label: Text(
                            Platform.isIOS
                                ? 'Save to Photos'
                                : 'Set Wallpaper',
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),

                      // Download button — saves image to gallery
                      IconButton(
                        onPressed: () => ImageDownloader.downloadToGallery(
                          widget.wallpaper.url,
                          context,
                        ),
                        icon: const Icon(
                          Icons.download_rounded,
                          color: Colors.white,
                          size: 28,
                        ),
                        tooltip: 'Download',
                      ),
                      const SizedBox(width: 4),

                      // Favourite button — toggle with Hive persistence
                      IconButton(
                        onPressed: () {
                          ref
                              .read(favouriteIdsProvider.notifier)
                              .toggle(widget.wallpaper.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                isFavourite
                                    ? 'Removed from favourites'
                                    : 'Added to favourites',
                              ),
                              behavior: SnackBarBehavior.floating,
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        },
                        icon: Icon(
                          isFavourite
                              ? Icons.favorite_rounded
                              : Icons.favorite_border_rounded,
                          color: isFavourite ? Colors.red : Colors.white,
                          size: 28,
                        ),
                        tooltip: 'Favourite',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Routes to the platform-appropriate bottom sheet.
  ///
  /// - **iOS**: Shows [IosSaveSheet] (save to Photos + manual instructions).
  /// - **Android**: Shows [PreviewActionsSheet] (Home / Lock / Both).
  void _onSetWallpaperTapped(BuildContext context) {
    if (Platform.isIOS) {
      showModalBottomSheet(
        context: context,
        builder: (_) => IosSaveSheet(imageUrl: widget.wallpaper.url),
      );
    } else {
      showModalBottomSheet(
        context: context,
        builder: (_) => PreviewActionsSheet(imageUrl: widget.wallpaper.url),
      );
    }
  }
}
