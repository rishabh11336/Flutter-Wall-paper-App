/// App-wide constants for networking and configuration.
class AppConstants {
  AppConstants._();

  // ─── GitHub API source ──────────────────────────────────────────
  // Replaced manifest.json with the live GitHub Contents API
  // This reads directly from the repo directory, fetching all uploaded images.
  static const String manifestUrl =
      'https://api.github.com/repos/rishabh11336/Wallpaper-Images/contents/';

  // ─── Placeholder image base URLs (for Phase 1 development) ──────────
  static const String placeholderThumbBase = 'https://picsum.photos/seed';
  static const String placeholderFullBase = 'https://picsum.photos/seed';

  /// Build a placeholder thumbnail URL using the wallpaper id as the seed.
  static String placeholderThumb(String id) => '$placeholderThumbBase/$id/400/700';

  /// Build a placeholder full-res URL using the wallpaper id as the seed.
  static String placeholderFull(String id) => '$placeholderFullBase/$id/1080/1920';

  // ─── Networking ──────────────────────────────────────────────────────
  static const Duration apiTimeout = Duration(seconds: 15);
}
