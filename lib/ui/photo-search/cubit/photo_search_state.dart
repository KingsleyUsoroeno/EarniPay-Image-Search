part of 'photo_search_cubit.dart';

sealed class PhotoSearchState {}

class ImageSearchInitialState extends PhotoSearchState {}

class ImageSearchLoadingState extends PhotoSearchState {}

class ImageSearchLoadedState implements PhotoSearchState {
  final List<PhotoSearchResult> imageResults;
  final String searchQuery;

  ImageSearchLoadedState({required this.imageResults, required this.searchQuery});

  factory ImageSearchLoadedState.paginated(
      List<PhotoSearchResult> oldValue, List<PhotoSearchResult> newValue, String searchQuery) {
    return ImageSearchLoadedState(
        imageResults: [...oldValue, ...newValue], searchQuery: searchQuery);
  }

  Map<String, dynamic> toJson() => {'imageResults': imageResults, 'searchQuery': searchQuery};
}

class ImageSearchErrorState extends PhotoSearchState {
  final String errorMessage;
  final VoidCallback? onTryAgain;

  ImageSearchErrorState({required this.errorMessage, this.onTryAgain});
}
