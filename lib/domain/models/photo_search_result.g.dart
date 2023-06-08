// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_search_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PhotoSearchResult _$PhotoSearchResultFromJson(Map<String, dynamic> json) =>
    PhotoSearchResult(
      id: json['id'] as String,
      type: json['type'] as String,
      title: json['title'] as String,
      thumb: json['thumb'] as String,
      small: json['small'] as String,
      raw: json['raw'] as String,
      smallS3: json['smallS3'] as String,
      regular: json['regular'] as String,
      full: json['full'] as String,
      description: json['description'] as String? ?? '',
      altDescription: json['altDescription'] as String? ?? '',
      authorName: json['authorName'] as String,
    );

Map<String, dynamic> _$PhotoSearchResultToJson(PhotoSearchResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'title': instance.title,
      'raw': instance.raw,
      'full': instance.full,
      'regular': instance.regular,
      'small': instance.small,
      'thumb': instance.thumb,
      'smallS3': instance.smallS3,
      'description': instance.description,
      'altDescription': instance.altDescription,
      'authorName': instance.authorName,
    };
