import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:weather_around_app/core/data/constants/api_constants.dart';
import 'package:weather_around_app/core/data/constants/api_status.dart';
import 'package:weather_around_app/core/error/failure.dart';
import 'package:weather_around_app/features/forecast/data/models/api_error.dart';
import 'package:weather_around_app/features/forecast/data/models/current_weather_model.dart';
import 'package:weather_around_app/features/forecast/data/models/forecast_model.dart';
import 'package:weather_around_app/features/forecast/data/models/list_cities_model.dart';

import 'forecast_repository.dart';

@Injectable(as: ForecastRepository)
class ForecastRepositoryImpl implements ForecastRepository {
  final Dio _dio;

  ForecastRepositoryImpl(this._dio);
  @override
  Future<Either<Failure, ListCitiesModel>> getListCitiesByNameRepository(
      String cityName) async {
    try {
      try {
        final result = await _dio.get(
          ApiConstants.citySearch,
          queryParameters: {
            "key": ApiConstants.apiKey,
            "q": cityName,
          },
        );

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
    } catch (e) {
      log(e.toString(), level: Level.warning.value);
      return const Left(
        Failure(
          'Something went wrong',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, CurrentWeatherModel>>
      getCurrentWeatherConditionByCityRepository(String latLong) async {
    try {
      try {
        final result = await _dio.get(
          ApiConstants.currentWeather,
          queryParameters: {
            "key": ApiConstants.apiKey,
            "q": latLong,
          },
        );

        if (result.statusCode == ApiStatus.success.code) {
          final listCitiesEntity = CurrentWeatherModel.fromJson(result.data);
          return Right(
            listCitiesEntity,
          );
        } else {
          return const Left(
            Failure(
              "No information available",
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
    } catch (e) {
      log(e.toString(), level: Level.warning.value);
      return const Left(
        Failure(
          'Something went wrong',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, ForecastModel>>
      getForecastWeatherDetailByCityRepository(String latLong) async {
    try {
      try {
        final result = await _dio.get(
          ApiConstants.forecastDetailWeather,
          queryParameters: {
            "key": ApiConstants.apiKey,
            "q": latLong,
          },
        );

        if (result.statusCode == ApiStatus.success.code) {
          final listCitiesEntity = ForecastModel.fromJson(result.data);
          return Right(
            listCitiesEntity,
          );
        } else {
          return const Left(
            Failure(
              "No information available",
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
    } catch (e) {
      log(e.toString(), level: Level.error.value);
      return const Left(
        Failure(
          'Something went wrong',
        ),
      );
    }
  }
}
