// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../data/remote/dio_http_client.dart' as _i3;
import '../data/remote/services/photo_search_service.dart' as _i4;
import '../domain/repository/photo_search_repository.dart' as _i5;
import '../ui/photo-search/cubit/photo_search_cubit.dart' as _i6;

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i3.DioHttpClient>(_i3.DioHttpClient());
    gh.singleton<_i4.PhotoSearchService>(
        _i4.PhotoSearchService(gh<_i3.DioHttpClient>()));
    gh.singleton<_i5.PhotoSearchRepository>(
        _i5.PhotoSearchRepository.create(gh<_i4.PhotoSearchService>()));
    gh.factory<_i6.PhotoSearchCubit>(
        () => _i6.PhotoSearchCubit(gh<_i5.PhotoSearchRepository>()));
    return this;
  }
}
