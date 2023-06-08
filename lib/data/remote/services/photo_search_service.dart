import 'package:earnipay_image_search/data/remote/dio_http_client.dart';
import 'package:earnipay_image_search/data/remote/dto/photo_search_response_dto.dart';
import 'package:injectable/injectable.dart';

@singleton
class PhotoSearchService {
  final DioHttpClient _client;

  PhotoSearchService(this._client);

  Future<PhotoSearchResponseDto> searchImage({
    required String query,
    int page = 1,
    int limit = 10,
  }) async {
    final String url = "search/photos?page=$page&query=$query&per_page=$limit";
    final response = await _client.get(url);
    return PhotoSearchResponseDto.fromJson(response.data);
  }
}
