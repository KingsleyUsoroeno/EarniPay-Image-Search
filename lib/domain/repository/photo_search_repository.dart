import 'package:earnipay_image_search/data/remote/services/photo_search_service.dart';
import 'package:earnipay_image_search/data/repository/photo_search_repository_impl.dart';
import 'package:earnipay_image_search/domain/models/photo_search_result.dart';
import 'package:injectable/injectable.dart';

@singleton
abstract class PhotoSearchRepository {

  @factoryMethod
  factory PhotoSearchRepository.create(PhotoSearchService service) =>
      PhotoSearchRepositoryImpl(service);

  Future<List<PhotoSearchResult>> performImageSearch({required String query, int page = 1});
}
