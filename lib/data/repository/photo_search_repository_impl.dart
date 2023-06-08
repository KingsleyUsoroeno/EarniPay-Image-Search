import 'package:earnipay_image_search/data/remote/dto/photo_search_response_dto.dart';
import 'package:earnipay_image_search/data/remote/services/photo_search_service.dart';
import 'package:earnipay_image_search/domain/models/photo_search_result.dart';
import 'package:earnipay_image_search/domain/repository/photo_search_repository.dart';

class PhotoSearchRepositoryImpl implements PhotoSearchRepository {
  final PhotoSearchService _imageSearchService;

  PhotoSearchRepositoryImpl(this._imageSearchService);

  @override
  Future<List<PhotoSearchResult>> performImageSearch({required String query, int page = 1}) async {
    final result = await _imageSearchService.searchImage(query: query, page: page);
    return result.results.map((response) {
      final tag = response.tags.isNotEmpty ? response.tags.first : TagDto.empty();
      return PhotoSearchResult(
        id: response.id,
        type: tag.type,
        title: "${tag.title[0].toUpperCase()}${tag.title.substring(1).toLowerCase()}",
        thumb: response.urls.thumb,
        small: response.urls.small,
        raw: response.urls.raw,
        smallS3: response.urls.smallS3,
        regular: response.urls.regular,
        full: response.urls.full,
      );
    }).toList();
  }
}
