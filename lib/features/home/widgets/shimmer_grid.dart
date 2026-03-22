import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';


import '../../../core/theme/app_theme.dart';
import '../../../shared/extensions/context_extensions.dart';

/// A full shimmer placeholder grid shown while the manifest is loading.
///
/// Mimics the layout of [WallpaperGrid] with 2 columns and 9:16 aspect ratio
/// placeholders so the transition from loading → loaded is seamless.
class ShimmerGrid extends StatelessWidget {
  const ShimmerGrid({super.key, this.itemCount = 6});

  /// Number of placeholder items to display.
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: context.isDark
          ? context.colorScheme.surfaceContainerHigh
          : context.colorScheme.surfaceContainerLow,
      highlightColor: context.isDark
          ? context.colorScheme.surfaceContainerLow
          : context.colorScheme.surfaceContainerHigh,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 9 / 16,
        ),
        itemCount: itemCount,
        itemBuilder: (_, __) {
          return Container(
            decoration: BoxDecoration(
              color: context.isDark
                  ? context.colorScheme.surfaceContainerHigh
                  : context.colorScheme.surfaceContainerLow,
              borderRadius: BorderRadius.circular(AppTheme.cardRadius),
            ),
          );
        },
      ),
    );
  }
}
