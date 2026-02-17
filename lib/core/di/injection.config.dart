// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter_api_fetch/features/products/data/repo/product_repo_impl.dart'
    as _i3;
import 'package:flutter_api_fetch/features/products/data/source/api_source.dart'
    as _i733;
import 'package:flutter_api_fetch/features/products/data/source/local_source.dart'
    as _i539;
import 'package:flutter_api_fetch/features/products/domain/repo/product_repo.dart'
    as _i751;
import 'package:flutter_api_fetch/features/products/presentation/bloc/product_bloc.dart'
    as _i578;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i733.ApiSource>(() => _i733.ApiSource());
    gh.lazySingleton<_i539.LocalSource>(() => _i539.LocalSource());
    gh.lazySingleton<_i751.ProductRepo>(() => _i3.ProductRepoImpl(
          gh<_i733.ApiSource>(),
          gh<_i539.LocalSource>(),
        ));
    gh.factory<_i578.ProductBloc>(
        () => _i578.ProductBloc(gh<_i751.ProductRepo>()));
    return this;
  }
}
