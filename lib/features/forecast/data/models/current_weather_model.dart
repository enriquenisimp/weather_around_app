import 'dart:developer';

import 'package:logger/logger.dart';
import 'package:weather_around_app/features/forecast/data/models/weather_condition_model.dart';

class CurrentWeatherModel {
  final int lastUpdatedEpoch;
  final double tempC;
  final int isDay;
  final int cloud;
  final String localTimeString;
  final WeatherConditionModel weatherCondition;
  CurrentWeatherModel({
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
      return DateTime.parse(localTimeString);
    } catch (e) {
      log(localTimeString, level: Level.error.value);
      return DateTime.now();
    }
  }
}
