// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallpaper.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WallpaperImpl _$$WallpaperImplFromJson(Map<String, dynamic> json) =>
    _$WallpaperImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      category: json['category'] as String,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      url: json['url'] as String,
      thumbUrl: json['thumb_url'] as String,
      resolution: json['resolution'] as String?,
      width: (json['width'] as num?)?.toInt(),
      height: (json['height'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$WallpaperImplToJson(_$WallpaperImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'category': instance.category,
      'tags': instance.tags,
      'url': instance.url,
      'thumb_url': instance.thumbUrl,
      'resolution': instance.resolution,
      'width': instance.width,
      'height': instance.height,
    };
