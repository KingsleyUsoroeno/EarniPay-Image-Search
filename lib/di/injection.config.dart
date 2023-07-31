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

import '../data/remote/dio_http_client.dart' as _i4;
import '../data/remote/services/photo_search_service.dart' as _i5;
import '../data/repository/photo_search_repository_impl.dart' as _i7;
import '../domain/repository/photo_search_repository.dart' as _i6;
import '../ui/photo-search/cubit/photo_search_cubit.dart' as _i8;
import '../util/config.dart' as _i3;

const String _prod = 'prod';
const String _test = 'test';

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
    gh.singleton<_i3.Config>(
      _i3.ProdConfig(),
      registerFor: {_prod},
    );
    gh.singleton<_i3.Config>(
      _i3.LocalHostConfig(),
      registerFor: {_test},
    );
    gh.singleton<_i4.DioHttpClient>(_i4.DioHttpClient());
    gh.singleton<_i5.PhotoSearchService>(
        _i5.PhotoSearchService(gh<_i4.DioHttpClient>()));
    gh.singleton<_i6.PhotoSearchRepository>(
        _i7.PhotoSearchRepositoryImpl(gh<_i5.PhotoSearchService>()));
    gh.factory<_i8.PhotoSearchCubit>(
        () => _i8.PhotoSearchCubit(gh<_i6.PhotoSearchRepository>()));
    return this;
  }
}
