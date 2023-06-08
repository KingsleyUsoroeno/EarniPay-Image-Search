import 'package:json_annotation/json_annotation.dart';

part 'photo_search_response_dto.g.dart';

@JsonSerializable()
class PhotoSearchResponseDto {
  final List<PhotoSearchResultDto> results;

  PhotoSearchResponseDto({required this.results});

  factory PhotoSearchResponseDto.fromJson(Map<String, dynamic> json) =>
      _$PhotoSearchResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PhotoSearchResponseDtoToJson(this);
}

@JsonSerializable()
class PhotoSearchResultDto {
  final String id;
  @JsonKey(name: "urls")
  final ImageUrlDto urls;
  @JsonKey(name: "tags")
  final List<TagDto> tags;
  @JsonKey(includeIfNull: true)
  final String? description;
  @JsonKey(name: "alt_description", includeIfNull: true)
  final String? altDescription;
  @JsonKey(name: "user")
  final PhotoAuthorDto photoAuthor;

  PhotoSearchResultDto({
    required this.id,
    required this.tags,
    required this.urls,
    required this.description,
    required this.altDescription,
    required this.photoAuthor,
  });

  factory PhotoSearchResultDto.fromJson(Map<String, dynamic> json) =>
      _$PhotoSearchResultDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PhotoSearchResultDtoToJson(this);
}

@JsonSerializable()
class ImageUrlDto {
  final String raw;
  final String full;
  final String regular;
  final String small;
  final String thumb;
  @JsonKey(name: "small_s3")
  final String smallS3;

  ImageUrlDto({
    required this.raw,
    required this.full,
    required this.regular,
    required this.small,
    required this.smallS3,
    required this.thumb,
  });

  factory ImageUrlDto.fromJson(Map<String, dynamic> json) => _$ImageUrlDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ImageUrlDtoToJson(this);
}

@JsonSerializable()
class TagDto {
  final String type;
  final String title;

  TagDto({required this.type, required this.title});

  factory TagDto.fromJson(Map<String, dynamic> json) => _$TagDtoFromJson(json);

  factory TagDto.empty() => TagDto(type: "", title: "");

  Map<String, dynamic> toJson() => _$TagDtoToJson(this);
}

@JsonSerializable()
class PhotoAuthorDto {
  final String id;
  final String name;

  PhotoAuthorDto({required this.id, required this.name});

  factory PhotoAuthorDto.fromJson(Map<String, dynamic> json) => _$PhotoAuthorDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PhotoAuthorDtoToJson(this);
}
