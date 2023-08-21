import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
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
      String cityName) async {
    try {
      final result = await _forecastDataSource.getListCitiesByNameAPi(cityName);
      if (result == null) {
        return const Left(Failure.unknown());
      }

      if (result.statusCode == ApiStatus.success.code) {
        final listCitiesEntity = ListCitiesModel.fromJson(result.data);
        return Right(
          listCitiesEntity,
        );
      } else {
        return const Left(
          Failure(
            "No city were found with that name",
          ),
        );
      }
    } on DioException catch (e) {
      final apiError = ApiError.fromJson(e.response?.data["error"]);
      return Left(
        Failure(
          apiError.message,
        ),
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
      if (result == null) {
        return const Left(Failure.unknown());
      }

      if (result.statusCode == ApiStatus.success.code) {
        final listCitiesEntity = CurrentWeatherModel.fromJson(result.data);
        return Right(
          listCitiesEntity,
        );
      } else {
        return const Left(
          Failure.unknown(),
        );
      }
    } on DioException catch (e) {
      final apiError = ApiError.fromJson(e.response?.data["error"]);
      return Left(
        Failure(
          apiError.message,
        ),
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

      if (result == null) {
        return const Left(Failure.unknown());
      }

      if (result.statusCode == ApiStatus.success.code) {
        final listCitiesEntity = ForecastModel.fromJson(result.data);
        return Right(
          listCitiesEntity,
        );
      } else {
        return const Left(
          Failure.unknown(),
        );
      }
    } on DioException catch (e) {
      final apiError = ApiError.fromJson(e.response?.data["error"]);
      return Left(
        Failure(
          apiError.message,
        ),
      );
    }
  }
}
