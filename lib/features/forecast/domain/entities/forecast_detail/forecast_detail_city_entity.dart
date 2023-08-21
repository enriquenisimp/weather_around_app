import 'package:weather_around_app/features/forecast/data/models/forecast_model.dart';
import 'package:weather_around_app/features/forecast/domain/entities/forecast_card/current_weather_city_entity.dart';

class ForecastDetailCityEntity {
  final List<ForecastDetailByHour> forecastByHourList;
  final double maxTemperature;
  final double minTemperature;
  final double averageTemperature;
  final DateTime localTime;
  ForecastDetailCityEntity({
    required this.forecastByHourList,
    required this.maxTemperature,
    required this.minTemperature,
    required this.averageTemperature,
    required this.localTime,
  });
}

class ForecastDetailByHour {
  final int hourOfTheDay;
  final double temperature;
  final PeriodOfDay periodOfDay;
  final WeatherConditionsEntity weatherConditionsEntity;
  final double windKph;
  final int windDegree;
  final WindDir windDir;

  ForecastDetailByHour({
    required this.hourOfTheDay,
    required this.temperature,
    required this.periodOfDay,
    required this.weatherConditionsEntity,
    required this.windKph,
    required this.windDegree,
    required this.windDir,
  });
}
