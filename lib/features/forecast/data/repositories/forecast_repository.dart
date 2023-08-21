import 'package:dartz/dartz.dart';
import 'package:weather_around_app/core/error/failure.dart';
import 'package:weather_around_app/features/forecast/data/models/current_weather_model.dart';
import 'package:weather_around_app/features/forecast/data/models/forecast_model.dart';
import 'package:weather_around_app/features/forecast/data/models/list_cities_model.dart';

abstract class ForecastRepository {
  Future<Either<Failure, ListCitiesModel>> getListCitiesByNameRepository(
    String cityName,
  );
  Future<Either<Failure, CurrentWeatherModel>>
      getCurrentWeatherConditionByCityRepository(
    String latLong,
  );
  Future<Either<Failure, ForecastModel>>
      getForecastWeatherDetailByCityRepository(
    String latLong,
  );
}
