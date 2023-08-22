import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:weather_around_app/core/data/constants/api_constants.dart';

@injectable
class ForecastDataSource {
  final Dio _dio;
  ForecastDataSource(this._dio);

  Future<Response> getListCitiesByNameAPi(
    String cityName,
  ) async {
    try {
      return _dio.get(
        ApiConstants.getAPiByEndPoint(ApiConstants.citySearch),
        queryParameters: {
          "key": ApiConstants.apiKey,
          "q": cityName,
        },
      );
    } catch (e) {
      log(e.toString(), level: Level.error.value);

      throw DioException(
        requestOptions: RequestOptions(),
        error: e,
        type: DioExceptionType.unknown,
      );
    }
  }

  Future<Response> getCurrentWeatherConditionByCityApi(
    String latLong,
  ) async {
    try {
      return _dio.get(
        ApiConstants.getAPiByEndPoint(ApiConstants.currentWeather),
        queryParameters: {
          "key": ApiConstants.apiKey,
          "q": latLong,
        },
      );
    } catch (e) {
      log(e.toString(), level: Level.error.value);
      throw DioException(
        requestOptions: RequestOptions(),
        error: e,
        type: DioExceptionType.unknown,
      );
    }
  }

  Future<Response> getForecastWeatherDetailByCityApi(
    String latLong,
  ) async {
    try {
      return _dio.get(
        ApiConstants.getAPiByEndPoint(ApiConstants.forecastDetailWeather),
        queryParameters: {
          "key": ApiConstants.apiKey,
          "q": latLong,
        },
      );
    } catch (e) {
      log(e.toString(), level: Level.error.value);
      throw DioException(
        requestOptions: RequestOptions(),
        error: e,
        type: DioExceptionType.unknown,
      );
    }
  }
}
