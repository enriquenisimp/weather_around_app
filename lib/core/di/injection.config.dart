// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:weather_around_app/core/di/modules/api_module.dart' as _i10;
import 'package:weather_around_app/features/forecast/data/data_source/forecast_data_source.dart'
    as _i4;
import 'package:weather_around_app/features/forecast/data/repositories/forecast_repository.dart'
    as _i5;
import 'package:weather_around_app/features/forecast/data/repositories/forecast_repository_impl.dart'
    as _i6;
import 'package:weather_around_app/features/forecast/domain/usecases/get_current_weather_by_city_usecase.dart'
    as _i7;
import 'package:weather_around_app/features/forecast/domain/usecases/get_forecast_day_weather_by_city_usecase.dart'
    as _i8;
import 'package:weather_around_app/features/forecast/domain/usecases/get_list_cities_by_name_usecase.dart'
    as _i9;

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
    final apiModule = _$ApiModule();
    gh.lazySingleton<_i3.Dio>(() => apiModule.dio);
    gh.factory<_i4.ForecastDataSource>(
        () => _i4.ForecastDataSource(gh<_i3.Dio>()));
    gh.factory<_i5.ForecastRepository>(
        () => _i6.ForecastRepositoryImpl(gh<_i4.ForecastDataSource>()));
    gh.factory<_i7.GetCurrentWeatherByCityUseCase>(
        () => _i7.GetCurrentWeatherByCityUseCase(gh<_i5.ForecastRepository>()));
    gh.factory<_i8.GetForecastDetailWeatherByCityUseCase>(() =>
        _i8.GetForecastDetailWeatherByCityUseCase(
            gh<_i5.ForecastRepository>()));
    gh.factory<_i9.GetListCitiesByNameUseCase>(
        () => _i9.GetListCitiesByNameUseCase(gh<_i5.ForecastRepository>()));
    return this;
  }
}

class _$ApiModule extends _i10.ApiModule {}
