import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:weather_around_app/core/data/constants/common_constants.dart';
import 'package:weather_around_app/features/forecast/domain/entities/enums/period_day.dart';

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
