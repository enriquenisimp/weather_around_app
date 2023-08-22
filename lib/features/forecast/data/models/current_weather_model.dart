import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:weather_around_app/features/forecast/data/models/weather_condition_model.dart';

class CurrentWeatherModel extends Equatable {
  final int lastUpdatedEpoch;
  final double tempC;
  final int isDay;
  final int cloud;
  final String localTimeString;
  final WeatherConditionModel weatherCondition;
  const CurrentWeatherModel({
    required this.lastUpdatedEpoch,
    required this.localTimeString,
    required this.tempC,
    required this.isDay,
    required this.cloud,
    required this.weatherCondition,
  });

  factory CurrentWeatherModel.fromJson(Map<String, dynamic> json) =>
      CurrentWeatherModel(
        lastUpdatedEpoch: json["current"]["last_updated_epoch"],
        tempC: json["current"]["temp_c"],
        isDay: json["current"]["is_day"],
        cloud: json["current"]["cloud"],
        weatherCondition:
            WeatherConditionModel.fromJson(json["current"]["condition"]),
        localTimeString: json["location"]["localtime"],
      );

  DateTime localTimeDate() {
    try {
      return DateFormat("yyyy-MM-dd H:mm").parse(localTimeString);
    } catch (e) {
      log(localTimeString, level: Level.error.value);
      return DateTime.now();
    }
  }

  @override
  List<Object?> get props => [
        lastUpdatedEpoch,
        localTimeString,
        tempC,
        isDay,
        cloud,
        weatherCondition,
      ];
}
