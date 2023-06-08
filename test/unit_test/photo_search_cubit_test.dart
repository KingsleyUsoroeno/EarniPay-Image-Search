import 'package:earnipay_image_search/domain/models/photo_search_result.dart';
import 'package:earnipay_image_search/domain/repository/photo_search_repository.dart';
import 'package:earnipay_image_search/ui/photo-search/cubit/photo_search_cubit.dart';
import 'package:earnipay_image_search/util/exceptions/exceptions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/mocks.dart';

void main() {
  late PhotoSearchCubit photoSearchCubit;
  late PhotoSearchRepository photoSearchRepository;
  late Storage storage;

  const String query = "dogs";
  final photoSearchResults = [PhotoSearchResult.forTest()];

  setUp(() {
    photoSearchRepository = PhotoSearchRepositoryMock();
    storage = MockStorage();
    when(() => storage.write(any(), any<dynamic>())).thenAnswer((_) async {});

    HydratedBloc.storage = storage;

    photoSearchCubit = PhotoSearchCubit(photoSearchRepository);
  });

  tearDown(() => photoSearchCubit.close());

  blocTest<PhotoSearchCubit, PhotoSearchState>(
    'emits [ImageSearchLoadingState, ImageSearchLoadedState] states for successful image search',
    build: () => photoSearchCubit,
    act: (bloc) {
      when(() => photoSearchRepository.performImageSearch(query: query))
          .thenAnswer((_) => Future.value(photoSearchResults));
      bloc.performImageSearch(query);
    },
    expect: () => [isA<ImageSearchLoadingState>(), isA<ImageSearchLoadedState>()],
  );

  blocTest<PhotoSearchCubit, PhotoSearchState>(
    'emits [ImageSearchLoadingState, ImageSearchErrorState] states when an exception is thrown'
    'whilst trying to perform an image search',
    build: () => photoSearchCubit,
    act: (bloc) {
      when(() => photoSearchRepository.performImageSearch(query: query)).thenAnswer((_) async =>
          throw ConnectionException("Oops you have no internet connection at this time"));
      bloc.performImageSearch(query);
    },
    expect: () => [isA<ImageSearchLoadingState>(), isA<ImageSearchErrorState>()],
  );
}
