import 'package:weather_around_app/features/forecast/data/models/forecast_model.dart';
import 'package:weather_around_app/features/forecast/domain/entities/enums/period_day.dart';
import 'package:weather_around_app/features/forecast/domain/entities/forecast_card/current_weather_city_entity.dart';

class ForecastDetailByHour {
  final int hourOfTheDay;
  final double temperature;
  final PeriodOfDay periodOfDay;
  final WeatherConditionsEntity weatherConditionsEntity;
  final double windKph;
  final int windDegree;
  final WindDir windDir;
  final double uv;
  final double precipitationMM;
  final int chanceOfRain;
  final bool isCloudy;
  final int chanceOfSnow;

  ForecastDetailByHour({
    required this.hourOfTheDay,
    required this.temperature,
    required this.periodOfDay,
    required this.weatherConditionsEntity,
    required this.windKph,
    required this.windDegree,
    required this.windDir,
    required this.uv,
    required this.precipitationMM,
    required this.chanceOfRain,
    required this.isCloudy,
    required this.chanceOfSnow,
  });
}
