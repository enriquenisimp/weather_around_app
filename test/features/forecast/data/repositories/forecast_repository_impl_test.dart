import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_around_app/core/data/constants/api_constants.dart';
import 'package:weather_around_app/core/data/constants/assets_constants.dart';
import 'package:weather_around_app/core/data/utils.dart';
import 'package:weather_around_app/core/error/failure.dart';
import 'package:weather_around_app/features/forecast/data/data_source/forecast_data_source.dart';
import 'package:weather_around_app/features/forecast/data/models/current_weather_model.dart';
import 'package:weather_around_app/features/forecast/data/models/forecast_model.dart';
import 'package:weather_around_app/features/forecast/data/models/list_cities_model.dart';
import 'package:weather_around_app/features/forecast/data/repositories/forecast_repository_impl.dart';

class MockForecastDataSource extends Mock implements ForecastDataSource {}

Future<void> main() async {
  late ForecastDataSource forecastDataSource;
  late ForecastRepositoryImpl forecastRepositoryImpl;
  setUp(() {
    forecastDataSource = MockForecastDataSource();
    forecastRepositoryImpl = ForecastRepositoryImpl(forecastDataSource);
  });

  group("exceptions for APIs", () {
    test(
        'when getListCitiesByNameAPi throw an exception,'
        ' the repository should catch that exception and return the Failure',
        () async {
      when(() => forecastDataSource.getListCitiesByNameAPi("dummy")).thenThrow(
          DioException(
              requestOptions: RequestOptions(),
              type: DioExceptionType.unknown));

      final result =
          await forecastRepositoryImpl.getListCitiesByNameRepository("dummy");

      expect(result, const Left(Failure.unknown()));
    });

    test(
        'when getForecastWeatherDetailByCityApi throw an exception,'
        ' the repository should catch that exception and return the Failure',
        () async {
      when(() => forecastDataSource.getForecastWeatherDetailByCityApi("dummy"))
          .thenThrow(DioException(
              requestOptions: RequestOptions(),
              type: DioExceptionType.unknown));

      final result =
          await forecastRepositoryImpl.getListCitiesByNameRepository("dummy");

      expect(result, const Left(Failure.unknown()));
    });

    test(
        'when getCurrentWeatherConditionByCityApi throw an exception,'
        ' the repository should catch that exception and return the Failure',
        () async {
      when(() =>
              forecastDataSource.getCurrentWeatherConditionByCityApi("dummy"))
          .thenThrow(DioException(
              requestOptions: RequestOptions(),
              type: DioExceptionType.unknown));

      final result =
          await forecastRepositoryImpl.getListCitiesByNameRepository("dummy");

      expect(result, const Left(Failure.unknown()));
    });
  });

  group("success from APIs", () {
    test(
        'when getListCitiesByNameAPi return real data,'
        'the repository should handle the data and encapsulate the data into a model',
        () async {
      WidgetsFlutterBinding.ensureInitialized();

      final json = await Utils.getJsonFromFile(
        MockConstants.getMockAPi(
          ApiConstants.citySearch,
        ),
      );

      when(() => forecastDataSource.getListCitiesByNameAPi("london"))
          .thenAnswer(
        (_) => Future.value(
          Response(
            statusCode: 200,
            data: json,
            requestOptions: RequestOptions(),
          ),
        ),
      );

      final result =
          await forecastRepositoryImpl.getListCitiesByNameRepository("london");
      expect(
        result,
        Right(
          ListCitiesModel.fromJson(
            json,
          ),
        ),
      );
    });

    test(
        'when getForecastWeatherDetailByCityApi return real data ,'
        'the repository should handle the data and encapsulate the data into a model',
        () async {
      WidgetsFlutterBinding.ensureInitialized();

      final json = await Utils.getJsonFromFile(
        MockConstants.getMockAPi(
          ApiConstants.forecastDetailWeather,
        ),
      );

      when(() => forecastDataSource.getForecastWeatherDetailByCityApi("22,00"))
          .thenAnswer(
        (_) => Future.value(
          Response(
            statusCode: 200,
            data: json,
            requestOptions: RequestOptions(),
          ),
        ),
      );

      final result = await forecastRepositoryImpl
          .getForecastWeatherDetailByCityRepository("22,00");

      expect(result, Right(ForecastModel.fromJson(json)));
    });

    test(
        'when getCurrentWeatherConditionByCityApi return real data,'
        ' the repository should handle the data and encapsulate the data into a model',
        () async {
      WidgetsFlutterBinding.ensureInitialized();

      final json = await Utils.getJsonFromFile(
        MockConstants.getMockAPi(
          ApiConstants.currentWeather,
        ),
      );

      when(() =>
              forecastDataSource.getCurrentWeatherConditionByCityApi("22,00"))
          .thenAnswer(
        (_) => Future.value(
          Response(
            statusCode: 200,
            data: json,
            requestOptions: RequestOptions(),
          ),
        ),
      );

      final result = await forecastRepositoryImpl
          .getCurrentWeatherConditionByCityRepository("22,00");

      expect(result, Right(CurrentWeatherModel.fromJson(json)));
    });
  });
}
