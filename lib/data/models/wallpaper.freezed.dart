// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wallpaper.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Wallpaper _$WallpaperFromJson(Map<String, dynamic> json) {
  return _Wallpaper.fromJson(json);
}

/// @nodoc
mixin _$Wallpaper {
  /// Unique identifier (e.g. "nature_01").
  String get id => throw _privateConstructorUsedError;

  /// Display title (e.g. "Forest Dawn").
  String get title => throw _privateConstructorUsedError;

  /// Category this wallpaper belongs to (e.g. "nature").
  String get category => throw _privateConstructorUsedError;

  /// Searchable tags.
  List<String> get tags => throw _privateConstructorUsedError;

  /// Full-resolution image URL.
  String get url => throw _privateConstructorUsedError;

  /// Thumbnail image URL.
// ignore: invalid_annotation_target
  @JsonKey(name: 'thumb_url')
  String get thumbUrl => throw _privateConstructorUsedError;

  /// Human-readable resolution label (e.g. "4K").
  String? get resolution => throw _privateConstructorUsedError;

  /// Image width in pixels.
  int? get width => throw _privateConstructorUsedError;

  /// Image height in pixels.
  int? get height => throw _privateConstructorUsedError;

  /// Serializes this Wallpaper to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Wallpaper
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WallpaperCopyWith<Wallpaper> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WallpaperCopyWith<$Res> {
  factory $WallpaperCopyWith(Wallpaper value, $Res Function(Wallpaper) then) =
      _$WallpaperCopyWithImpl<$Res, Wallpaper>;
  @useResult
  $Res call(
      {String id,
      String title,
      String category,
      List<String> tags,
      String url,
      @JsonKey(name: 'thumb_url') String thumbUrl,
      String? resolution,
      int? width,
      int? height});
}

/// @nodoc
class _$WallpaperCopyWithImpl<$Res, $Val extends Wallpaper>
    implements $WallpaperCopyWith<$Res> {
  _$WallpaperCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Wallpaper
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? category = null,
    Object? tags = null,
    Object? url = null,
    Object? thumbUrl = null,
    Object? resolution = freezed,
    Object? width = freezed,
    Object? height = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      thumbUrl: null == thumbUrl
          ? _value.thumbUrl
          : thumbUrl // ignore: cast_nullable_to_non_nullable
              as String,
      resolution: freezed == resolution
          ? _value.resolution
          : resolution // ignore: cast_nullable_to_non_nullable
              as String?,
      width: freezed == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as int?,
      height: freezed == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WallpaperImplCopyWith<$Res>
    implements $WallpaperCopyWith<$Res> {
  factory _$$WallpaperImplCopyWith(
          _$WallpaperImpl value, $Res Function(_$WallpaperImpl) then) =
      __$$WallpaperImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String category,
      List<String> tags,
      String url,
      @JsonKey(name: 'thumb_url') String thumbUrl,
      String? resolution,
      int? width,
      int? height});
}

/// @nodoc
class __$$WallpaperImplCopyWithImpl<$Res>
    extends _$WallpaperCopyWithImpl<$Res, _$WallpaperImpl>
    implements _$$WallpaperImplCopyWith<$Res> {
  __$$WallpaperImplCopyWithImpl(
      _$WallpaperImpl _value, $Res Function(_$WallpaperImpl) _then)
      : super(_value, _then);

  /// Create a copy of Wallpaper
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? category = null,
    Object? tags = null,
    Object? url = null,
    Object? thumbUrl = null,
    Object? resolution = freezed,
    Object? width = freezed,
    Object? height = freezed,
  }) {
    return _then(_$WallpaperImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      thumbUrl: null == thumbUrl
          ? _value.thumbUrl
          : thumbUrl // ignore: cast_nullable_to_non_nullable
              as String,
      resolution: freezed == resolution
          ? _value.resolution
          : resolution // ignore: cast_nullable_to_non_nullable
              as String?,
      width: freezed == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as int?,
      height: freezed == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WallpaperImpl implements _Wallpaper {
  const _$WallpaperImpl(
      {required this.id,
      required this.title,
      required this.category,
      required final List<String> tags,
      required this.url,
      @JsonKey(name: 'thumb_url') required this.thumbUrl,
      this.resolution,
      this.width,
      this.height})
      : _tags = tags;

  factory _$WallpaperImpl.fromJson(Map<String, dynamic> json) =>
      _$$WallpaperImplFromJson(json);

  /// Unique identifier (e.g. "nature_01").
  @override
  final String id;

  /// Display title (e.g. "Forest Dawn").
  @override
  final String title;

  /// Category this wallpaper belongs to (e.g. "nature").
  @override
  final String category;

  /// Searchable tags.
  final List<String> _tags;

  /// Searchable tags.
  @override
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  /// Full-resolution image URL.
  @override
  final String url;

  /// Thumbnail image URL.
// ignore: invalid_annotation_target
  @override
  @JsonKey(name: 'thumb_url')
  final String thumbUrl;

  /// Human-readable resolution label (e.g. "4K").
  @override
  final String? resolution;

  /// Image width in pixels.
  @override
  final int? width;

  /// Image height in pixels.
  @override
  final int? height;

  @override
  String toString() {
    return 'Wallpaper(id: $id, title: $title, category: $category, tags: $tags, url: $url, thumbUrl: $thumbUrl, resolution: $resolution, width: $width, height: $height)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WallpaperImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.category, category) ||
                other.category == category) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.thumbUrl, thumbUrl) ||
                other.thumbUrl == thumbUrl) &&
            (identical(other.resolution, resolution) ||
                other.resolution == resolution) &&
            (identical(other.width, width) || other.width == width) &&
            (identical(other.height, height) || other.height == height));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      category,
      const DeepCollectionEquality().hash(_tags),
      url,
      thumbUrl,
      resolution,
      width,
      height);

  /// Create a copy of Wallpaper
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WallpaperImplCopyWith<_$WallpaperImpl> get copyWith =>
      __$$WallpaperImplCopyWithImpl<_$WallpaperImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WallpaperImplToJson(
      this,
    );
  }
}

abstract class _Wallpaper implements Wallpaper {
  const factory _Wallpaper(
      {required final String id,
      required final String title,
      required final String category,
      required final List<String> tags,
      required final String url,
      @JsonKey(name: 'thumb_url') required final String thumbUrl,
      final String? resolution,
      final int? width,
      final int? height}) = _$WallpaperImpl;

  factory _Wallpaper.fromJson(Map<String, dynamic> json) =
      _$WallpaperImpl.fromJson;

  /// Unique identifier (e.g. "nature_01").
  @override
  String get id;

  /// Display title (e.g. "Forest Dawn").
  @override
  String get title;

  /// Category this wallpaper belongs to (e.g. "nature").
  @override
  String get category;

  /// Searchable tags.
  @override
  List<String> get tags;

  /// Full-resolution image URL.
  @override
  String get url;

  /// Thumbnail image URL.
// ignore: invalid_annotation_target
  @override
  @JsonKey(name: 'thumb_url')
  String get thumbUrl;

  /// Human-readable resolution label (e.g. "4K").
  @override
  String? get resolution;

  /// Image width in pixels.
  @override
  int? get width;

  /// Image height in pixels.
  @override
  int? get height;

  /// Create a copy of Wallpaper
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WallpaperImplCopyWith<_$WallpaperImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
