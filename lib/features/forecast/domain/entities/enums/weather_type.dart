import 'package:weather_around_app/features/forecast/domain/entities/forecast_detail/forecast_detail_hour.dart';

enum WeatherType {
  snowing,
  raining,
  clear,
  cloudy,
  storm;

  bool get isClear => this == clear;

  static getWeatherBy(
    ForecastDetailByHour currentWeather,
  ) {
    if (currentWeather.chanceOfRain > 10) {
      if (currentWeather.precipitationMM > 4) {
        return storm;
      }
      return raining;
    }

    if (currentWeather.isCloudy) {
      return cloudy;
    }

    if (currentWeather.chanceOfSnow > 3) {
      return cloudy;
    }

    return clear;
  }
}
