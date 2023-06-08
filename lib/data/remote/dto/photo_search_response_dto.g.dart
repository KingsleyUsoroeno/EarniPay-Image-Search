// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_search_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PhotoSearchResponseDto _$PhotoSearchResponseDtoFromJson(
        Map<String, dynamic> json) =>
    PhotoSearchResponseDto(
      results: (json['results'] as List<dynamic>)
          .map((e) => PhotoSearchResultDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PhotoSearchResponseDtoToJson(
        PhotoSearchResponseDto instance) =>
    <String, dynamic>{
      'results': instance.results,
    };

PhotoSearchResultDto _$PhotoSearchResultDtoFromJson(
        Map<String, dynamic> json) =>
    PhotoSearchResultDto(
      id: json['id'] as String,
      tags: (json['tags'] as List<dynamic>)
          .map((e) => TagDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      urls: ImageUrlDto.fromJson(json['urls'] as Map<String, dynamic>),
      description: json['description'] as String?,
      altDescription: json['alt_description'] as String?,
      photoAuthor:
          PhotoAuthorDto.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PhotoSearchResultDtoToJson(
        PhotoSearchResultDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'urls': instance.urls,
      'tags': instance.tags,
      'description': instance.description,
      'alt_description': instance.altDescription,
      'user': instance.photoAuthor,
    };

ImageUrlDto _$ImageUrlDtoFromJson(Map<String, dynamic> json) => ImageUrlDto(
      raw: json['raw'] as String,
      full: json['full'] as String,
      regular: json['regular'] as String,
      small: json['small'] as String,
      smallS3: json['small_s3'] as String,
      thumb: json['thumb'] as String,
    );

Map<String, dynamic> _$ImageUrlDtoToJson(ImageUrlDto instance) =>
    <String, dynamic>{
      'raw': instance.raw,
      'full': instance.full,
      'regular': instance.regular,
      'small': instance.small,
      'thumb': instance.thumb,
      'small_s3': instance.smallS3,
    };

TagDto _$TagDtoFromJson(Map<String, dynamic> json) => TagDto(
      type: json['type'] as String,
      title: json['title'] as String,
    );

Map<String, dynamic> _$TagDtoToJson(TagDto instance) => <String, dynamic>{
      'type': instance.type,
      'title': instance.title,
    };

PhotoAuthorDto _$PhotoAuthorDtoFromJson(Map<String, dynamic> json) =>
    PhotoAuthorDto(
      id: json['id'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$PhotoAuthorDtoToJson(PhotoAuthorDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
