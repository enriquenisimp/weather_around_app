import 'package:weather_around_app/features/forecast/data/models/forecast_model.dart';
import 'package:weather_around_app/features/forecast/domain/entities/forecast_card/current_weather_city_entity.dart';

class ForecastDetailCityEntity {
  final List<ForecastDetailByHour> forecastByHourList;
  final ForecastDetailDay forecastDetailDay;
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
    required this.forecastDetailDay,
  });
}

class ForecastDetailDay {
  final double maxTempC;
  final double minTempC;
  final double avgTempC;
  final double maxWindKph;
  final double totalPrecipitationMm;
  final double avgHumidity;
  final int dailyWillItRain;
  final int dailyChanceOfRain;
  final int dailyWillItSnow;
  final int dailyChanceOfSnow;
  final WeatherConditionsEntity condition;
  final double uv;

  ForecastDetailDay({
    required this.maxTempC,
    required this.minTempC,
    required this.avgTempC,
    required this.maxWindKph,
    required this.totalPrecipitationMm,
    required this.avgHumidity,
    required this.dailyWillItRain,
    required this.dailyChanceOfRain,
    required this.dailyWillItSnow,
    required this.dailyChanceOfSnow,
    required this.condition,
    required this.uv,
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
  final double uv;
  final int willItRain;
  final int chanceOfRain;
  final bool isCloudy;

  ForecastDetailByHour({
    required this.hourOfTheDay,
    required this.temperature,
    required this.periodOfDay,
    required this.weatherConditionsEntity,
    required this.windKph,
    required this.windDegree,
    required this.windDir,
    required this.uv,
    required this.willItRain,
    required this.chanceOfRain,
    required this.isCloudy,
  });
}
