import 'package:intl/intl.dart';
import 'package:weather_around_app/core/data/constants/common_constants.dart';

enum PeriodOfDay {
  unknown,
  morning,
  afternoon,
  evening,
  night;

  bool get isUnknown => this == unknown;
  bool get isMorning => this == morning;
  bool get isAfternoon => this == afternoon;
  bool get isEvening => this == evening;
  bool get isNight => this == night;

  static PeriodOfDay getFromHour(int hour) {
    if (hour < 11 && hour > 6) {
      return morning;
    }
    if (hour < 16) {
      return afternoon;
    }
    if (hour < 20) {
      return evening;
    }
    return night;
  }
}

class CurrentWeatherCityEntity {
  final PeriodOfDay periodOfDay;
  final DateTime localDateTime;
  final double temperature;
  final bool isCloudy;
  final WeatherConditionsEntity weatherConditions;

  CurrentWeatherCityEntity({
    required this.periodOfDay,
    required this.localDateTime,
    required this.temperature,
    required this.isCloudy,
    required this.weatherConditions,
  });

  String get formattedLocalTime =>
      DateFormat(DateFormats.ddMMMHm).format(localDateTime);
}

class WeatherConditionsEntity {
  final String description;
  final String iconUrl;

  WeatherConditionsEntity({
    required this.description,
    required this.iconUrl,
  });
}
