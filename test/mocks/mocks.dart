import 'package:earnipay_image_search/domain/repository/photo_search_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';

class PhotoSearchRepositoryMock extends Mock implements PhotoSearchRepository {}

class MockStorage extends Mock implements Storage {}