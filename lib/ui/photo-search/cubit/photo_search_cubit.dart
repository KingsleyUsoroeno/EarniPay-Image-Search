import 'package:earnipay_image_search/domain/models/photo_search_result.dart';
import 'package:earnipay_image_search/domain/repository/photo_search_repository.dart';
import 'package:earnipay_image_search/util/exceptions/exceptions.dart';
import 'package:flutter/foundation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

part 'photo_search_state.dart';

@injectable
class PhotoSearchCubit extends HydratedCubit<PhotoSearchState> {
  final PhotoSearchRepository _repository;

  PhotoSearchCubit(this._repository) : super(ImageSearchInitialState());

  Future<void> performImageSearch(String query) async {
    try {
      emit(ImageSearchLoadingState());
      final searchResults = await _repository.performImageSearch(query: query.trim());
      emit(ImageSearchLoadedState(imageResults: searchResults, searchQuery: query));
    } on ConnectionException {
      emit(ImageSearchErrorState(errorMessage: "", onTryAgain: () => performImageSearch(query)));
    } catch (exception, stackTrace) {
      final String errorMessage = "$exception$stackTrace";
      debugPrint("logged error message is $errorMessage");
      emit(ImageSearchErrorState(errorMessage: errorMessage));
    }
  }

  String get _searchQuery {
    return state is ImageSearchLoadedState ? (state as ImageSearchLoadedState).searchQuery : "";
  }

  Future<void> loadMoreImages(List<PhotoSearchResult> photos) async {
    try {
      if (_searchQuery.isEmpty) return;

      // using 10 because we have set a per_page param of 10 the api
      if (photos.length % 10 == 0 || photos.length % 11 == 0) {
        final int currentPage = photos.length ~/ 10 + 1;
        debugPrint("currentPage is ===> $currentPage");
        final paginatedPhotos =
            await _repository.performImageSearch(query: _searchQuery, page: currentPage);
        debugPrint("paginatedPhotos is ===> $paginatedPhotos");
        debugPrint("_searchQuery is ===> $_searchQuery");
        emit(ImageSearchLoadedState.paginated(photos, paginatedPhotos, _searchQuery));
      }
    } catch (e) {
      debugPrint("exception caught is $e");
      emit(ImageSearchLoadedState(imageResults: photos, searchQuery: _searchQuery));
    }
  }

  @override
  PhotoSearchState? fromJson(Map<String, dynamic> json) {
    try {
      final searchResults =
          List.from(json['imageResults']).map((e) => PhotoSearchResult.fromJson(e)).toList();
      final searchQuery = json['searchQuery'] as String;
      return ImageSearchLoadedState(imageResults: searchResults, searchQuery: searchQuery);
    } catch (e) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(PhotoSearchState state) {
    if (state is ImageSearchLoadedState) {
      return state.toJson();
    } else {
      return null;
    }
  }
}
