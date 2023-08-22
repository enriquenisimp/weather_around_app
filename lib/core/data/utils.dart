import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

import '../../features/forecast/data/models/weather_condition_model.dart';

class Utils {
  static Future<dynamic> getJsonFromFile(String asset) async {
    try {
      final jsonAsStringFormat = await rootBundle.loadString(asset);

      return json.decode(jsonAsStringFormat);
    } catch (e) {
      log(e.toString(), level: Level.warning.value);
      return null;
    }
  }
}

class WeatherConditionsUtils {
  static String calculateUVDanger(int uv) {
    if (uv < 5) {
      return "Low";
    }
    if (uv < 7) {
      return "Moderate";
    }
    return "High";
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
