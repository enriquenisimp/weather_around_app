import 'package:weather_around_app/features/forecast/domain/entities/forecast_card/current_weather_city_entity.dart';

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
