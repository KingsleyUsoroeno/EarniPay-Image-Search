import 'package:earnipay_image_search/domain/models/photo_search_result.dart';
import 'package:earnipay_image_search/domain/repository/photo_search_repository.dart';
import 'package:earnipay_image_search/ui/photo-search/cubit/photo_search_cubit.dart';
import 'package:earnipay_image_search/ui/photo-search/photo_search_screen.dart';
import 'package:earnipay_image_search/util/exceptions/exceptions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/mocks.dart';

Widget widgetForTesting({required Widget child}) {
  return MaterialApp(home: Scaffold(body: child));
}

void main() {
  late PhotoSearchCubit photoSearchCubit;
  late Storage storage;
  late PhotoSearchRepository repository;

  setUp(() {
    repository = PhotoSearchRepositoryMock();
    storage = MockStorage();
    when(() => storage.write(any(), any<dynamic>())).thenAnswer((_) async {});

    HydratedBloc.storage = storage;
    photoSearchCubit = PhotoSearchCubit(repository);
    GetIt.I.registerFactory<PhotoSearchCubit>(() => photoSearchCubit);
  });

  tearDown(() {
    GetIt.I.reset();
  });

  testWidgets(
    "check that user sees a text saying `Go ahead and search for an amazing image you would love "
    "to see` when the app is initially opened and nothing has been searched for yet",
    (WidgetTester tester) async {
      await tester.pumpWidget(widgetForTesting(child: const PhotoSearchScreen()));
      await tester.pumpAndSettle();

      expect(find.text("Go ahead and search for an amazing image you would love to see"),
          findsOneWidget);

      expect(find.byKey(const Key('image-search-result-grid-view')), findsNothing);
    },
  );

  testWidgets(
    'check that user sees can search for an image and see it populated on the gridview',
    (WidgetTester tester) async {
      const String query = 'dogs';
      final dogsSearchResult = [PhotoSearchResult.forTest()];
      final searchResultGridView = find.byKey(const Key('image-search-result-grid-view'));

      when(() => repository.performImageSearch(query: query))
          .thenAnswer((_) async => dogsSearchResult);

      await tester.pumpWidget(widgetForTesting(child: const PhotoSearchScreen()));
      await tester.pumpAndSettle();

      expect(find.text("Go ahead and search for an amazing image you would love to see"),
          findsOneWidget);
      expect(searchResultGridView, findsNothing);

      await tester.enterText(find.byKey(const Key("search-text-field")), query);
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();

      expect(find.text("Go ahead and search for an amazing image you would love to see"),
          findsNothing);
      expect(searchResultGridView, findsOneWidget);
    },
  );

  testWidgets(
    'check that user sees can see an error view if an exception was thrown whilst searching'
    'for an image',
    (WidgetTester tester) async {
      const String query = 'dogs';
      final searchResultGridView = find.byKey(const Key('image-search-result-grid-view'));

      when(() => repository.performImageSearch(query: query)).thenAnswer(
          (_) async => throw ConnectionException('Oops, please check your internet connection'));

      await tester.pumpWidget(widgetForTesting(child: const PhotoSearchScreen()));
      await tester.pumpAndSettle();

      expect(find.text("Go ahead and search for an amazing image you would love to see"),
          findsOneWidget);
      expect(searchResultGridView, findsNothing);

      await tester.enterText(find.byKey(const Key("search-text-field")), query);
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();

      expect(find.text("Go ahead and search for an amazing image you would love to see"),
          findsNothing);
      expect(searchResultGridView, findsNothing);
      expect(find.byKey(const Key('search-result-grid-view')), findsOneWidget);
    },
  );
}
