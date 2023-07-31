import 'package:earnipay_image_search/domain/models/photo_search_result.dart';

//@Singleton()
abstract class PhotoSearchRepository {

  // @factoryMethod
  // factory PhotoSearchRepository.create(PhotoSearchService service) =>
  //     PhotoSearchRepositoryImpl(service);

  Future<List<PhotoSearchResult>> performImageSearch({required String query, int page = 1});
}
