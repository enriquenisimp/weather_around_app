import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:weather_around_app/core/data/constants/assets_constants.dart';

import '../../features/forecast/data/models/weather_condition_model.dart';

class Utils {
  static Future<dynamic> getJsonFromFile(
      BuildContext context, String asset) async {
    try {
      final jsonAsStringFormat =
          await DefaultAssetBundle.of(context).loadString(asset);

      return json.decode(jsonAsStringFormat);
    } catch (e) {
      log(e.toString(), level: Level.warning.value);
      return null;
    }
  }
}

class WeatherConditionsUtils {
  static Future<List<WeatherConditionModel>> getWeatherConditionsList(
      BuildContext context) async {
    final weatherConditionList = <WeatherConditionModel>[];
    try {
      final jsonConditionsList = (await Utils.getJsonFromFile(
          context, WeatherConditionsConstants.weatherConditionsPath) as List);

      final weatherConditionMap =
          jsonConditionsList.map<WeatherConditionModel?>(
        (weatherConditionJson) {
          return WeatherConditionModel.fromJson(
            weatherConditionJson,
          );
        },
      );

      return weatherConditionMap.whereType<WeatherConditionModel>().toList();
    } catch (e) {
      log(e.toString(), level: Level.error.value);
    }
    return weatherConditionList;
  }

  static WeatherConditionModel? getWeatherConditionByCode(BuildContext context,
      List<WeatherConditionModel> weatherConditions, int code) {
    try {
      return weatherConditions.firstWhere(
        (weatherCondition) => weatherCondition.code == code,
      );
    } catch (e) {
      log(e.toString(), level: Level.error.value);
      return null;
    }
  }
}
