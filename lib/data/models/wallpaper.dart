import 'package:freezed_annotation/freezed_annotation.dart';

part 'wallpaper.freezed.dart';
part 'wallpaper.g.dart';

/// Represents a single wallpaper entry from the manifest.
///
/// Uses [freezed] for immutable data classes and [json_serializable]
/// for JSON deserialization.
@freezed
class Wallpaper with _$Wallpaper {
  // ignore: invalid_annotation_target
  const factory Wallpaper({
    /// Unique identifier (e.g. "nature_01").
    required String id,

    /// Display title (e.g. "Forest Dawn").
    required String title,

    /// Category this wallpaper belongs to (e.g. "nature").
    required String category,

    /// Searchable tags.
    required List<String> tags,

    /// Full-resolution image URL.
    required String url,

    /// Thumbnail image URL.
    // ignore: invalid_annotation_target
    @JsonKey(name: 'thumb_url') required String thumbUrl,

    /// Human-readable resolution label (e.g. "4K").
    String? resolution,

    /// Image width in pixels.
    int? width,

    /// Image height in pixels.
    int? height,
  }) = _Wallpaper;

  factory Wallpaper.fromJson(Map<String, dynamic> json) =>
      _$WallpaperFromJson(json);
}

