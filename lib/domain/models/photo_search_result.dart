import 'package:json_annotation/json_annotation.dart';

part 'photo_search_result.g.dart';

@JsonSerializable()
class PhotoSearchResult {
  final String id;
  final String type;
  final String title;
  final String raw;
  final String full;
  final String regular;
  final String small;
  final String thumb;
  final String smallS3;
  final String description;
  final String altDescription;
  final String authorName;

  PhotoSearchResult({
    required this.id,
    required this.type,
    required this.title,
    required this.thumb,
    required this.small,
    required this.raw,
    required this.smallS3,
    required this.regular,
    required this.full,
    this.description = '',
    this.altDescription = '',
    required this.authorName,
  });

  factory PhotoSearchResult.fromJson(Map<String, dynamic> json) =>
      _$PhotoSearchResultFromJson(json);

  factory PhotoSearchResult.forTest() => PhotoSearchResult(
        id: "0",
        type: "test",
        title: "dogs",
        thumb: "",
        small: "",
        raw: "",
        smallS3: "",
        regular: "",
        full: "",
        authorName: "",
      );

  Map<String, dynamic> toJson() => _$PhotoSearchResultToJson(this);

  @override
  String toString() {
    return 'ImageSearchResult{id: $id, type: $type, title: $title, raw: $raw, full: $full, '
        'regular: $regular, small: $small, thumb: $thumb, smallS3: $smallS3}';
  }
}
