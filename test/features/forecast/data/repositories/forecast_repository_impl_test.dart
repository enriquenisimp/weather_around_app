import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_around_app/core/error/failure.dart';
import 'package:weather_around_app/features/forecast/data/data_source/forecast_data_source.dart';
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
    final listCitiesJson = [
      {
        "id": 315398,
        "name": "London",
        "region": "Ontario",
        "country": "Canada",
        "lat": 42.98,
        "lon": -81.25,
        "url": "london-ontario-canada"
      }
    ];
    test(
        'when getListCitiesByNameAPi return real data,'
        ' the repository should handle the data and encapsulate the data into a model',
        () async {
      when(() => forecastDataSource.getListCitiesByNameAPi("london"))
          .thenAnswer((_) => Future.value(Response(
              data: {listCitiesJson}, requestOptions: RequestOptions())));

      final result =
          await forecastRepositoryImpl.getListCitiesByNameRepository("london");

      expect(result, Right(ListCitiesModel.fromJson(listCitiesJson)));
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

  //   test(
  //       'getPropertiesListRemote should return a PropertiesListWrapperModel,'
  //       ' the repository should got it and return a Right(SearchProperties)',
  //       () async {
  //     when(() => propertiesRemoteDataSource.getPropertiesListRemote(any()))
  //         .thenAnswer(
  //       (i) => Future.value(
  //         const PropertiesListWrapperModel(
  //           data: PropertiesListData(
  //             body: PropertiesListBody(
  //               searchProperties: SearchProperties(totalCount: 0, results: []),
  //             ),
  //           ),
  //         ),
  //       ),
  //     );
  //
  //     final result = await propertiesRepository.getListPropertiesRepository({});
  //
  //     expect(result, const Right(SearchProperties(totalCount: 0, results: [])));
  //   });
  // }
}
