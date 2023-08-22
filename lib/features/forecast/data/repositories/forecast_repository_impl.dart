import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:weather_around_app/core/data/constants/api_status.dart';
import 'package:weather_around_app/core/error/failure.dart';
import 'package:weather_around_app/features/forecast/data/data_source/forecast_data_source.dart';
import 'package:weather_around_app/features/forecast/data/models/api_error.dart';
import 'package:weather_around_app/features/forecast/data/models/current_weather_model.dart';
import 'package:weather_around_app/features/forecast/data/models/forecast_model.dart';
import 'package:weather_around_app/features/forecast/data/models/list_cities_model.dart';

import 'forecast_repository.dart';

@Injectable(as: ForecastRepository)
class ForecastRepositoryImpl implements ForecastRepository {
  final ForecastDataSource _forecastDataSource;

  ForecastRepositoryImpl(this._forecastDataSource);
  @override
  Future<Either<Failure, ListCitiesModel>> getListCitiesByNameRepository(
    String cityName,
  ) async {
    try {
      final result = await _forecastDataSource.getListCitiesByNameAPi(cityName);

      if (result.statusCode == ApiStatus.success.code) {
        final listCitiesEntity = ListCitiesModel.fromJson(result.data);
        print(listCitiesEntity);
        return Right(
          listCitiesEntity,
        );
      } else {
        final apiError = ApiError.fromJson(result.data);
        return Left(
          Failure(apiError?.message),
        );
      }
    } catch (e) {
      log(e.toString(), level: Level.error.value);
      return const Left(
        Failure.unknown(),
      );
    }
  }

  @override
  Future<Either<Failure, CurrentWeatherModel>>
      getCurrentWeatherConditionByCityRepository(String latLong) async {
    try {
      final result =
          await _forecastDataSource.getCurrentWeatherConditionByCityApi(
        latLong,
      );

      if (result.statusCode == ApiStatus.success.code) {
        final listCitiesEntity = CurrentWeatherModel.fromJson(result.data);
        return Right(
          listCitiesEntity,
        );
      } else {
        final apiError = ApiError.fromJson(result.data);
        return Left(
          Failure(apiError?.message),
        );
      }
    } catch (e) {
      log(e.toString(), level: Level.error.value);
      return const Left(
        Failure.unknown(),
      );
    }
  }

  @override
  Future<Either<Failure, ForecastModel>>
      getForecastWeatherDetailByCityRepository(String latLong) async {
    try {
      final result =
          await _forecastDataSource.getForecastWeatherDetailByCityApi(
        latLong,
      );

      if (result.statusCode == ApiStatus.success.code) {
        final forecastDetails = ForecastModel.fromJson(result.data);
        return Right(
          forecastDetails,
        );
      } else {
        final apiError = ApiError.fromJson(result.data);
        return Left(
          Failure(apiError?.message),
        );
      }
    } catch (e) {
      log(e.toString(), level: Level.error.value);
      return const Left(
        Failure.unknown(),
      );
    }
  }
}
