import 'package:equatable/equatable.dart';
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

  static PeriodOfDay calculateByHour(int isDay, DateTime dateTime) {
    if (isDay == 0) return PeriodOfDay.night;

    if (dateTime.hour < 11) {
      return PeriodOfDay.morning;
    }

    if (dateTime.hour < 16) {
      return PeriodOfDay.afternoon;
    }

    return PeriodOfDay.evening;
  }
}

class CurrentWeatherCityEntity extends Equatable {
  final PeriodOfDay periodOfDay;
  final DateTime localDateTime;
  final double temperature;
  final bool isCloudy;
  final WeatherConditionsEntity weatherConditions;

  const CurrentWeatherCityEntity({
    required this.periodOfDay,
    required this.localDateTime,
    required this.temperature,
    required this.isCloudy,
    required this.weatherConditions,
  });

  String get formattedLocalTime =>
      DateFormat(DateFormats.ddMMMHm).format(localDateTime);

  @override
  List<Object?> get props => [
        periodOfDay,
        localDateTime,
        temperature,
        isCloudy,
        weatherConditions,
      ];
}

class WeatherConditionsEntity extends Equatable {
  final String description;
  final String iconUrl;

  const WeatherConditionsEntity({
    required this.description,
    required this.iconUrl,
  });

  String get biggerImageSize => iconUrl.replaceAll("64x64", "128x128");

  @override
  // TODO: implement props
  List<Object?> get props => [
        description,
        iconUrl,
      ];
}
