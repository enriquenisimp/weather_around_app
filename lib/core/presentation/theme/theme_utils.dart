import 'package:flutter/material.dart';
import 'package:weather_around_app/features/forecast/domain/entities/forecast_card/current_weather_city_entity.dart';

class ThemeUtils {
  static Color chooseColor(PeriodOfDay periodOfDay) {
    if (periodOfDay.isUnknown) return Colors.grey;

    switch (periodOfDay) {
      case PeriodOfDay.morning:
        return Colors.lightBlue;
      case PeriodOfDay.afternoon:
        return Colors.blue;
      case PeriodOfDay.evening:
        return Colors.black.withBlue(120).withGreen(80);
      default:
        return Colors.black.withBlue(80).withGreen(30);
    }
  }

  static Color chooseShadowColor(bool isCloudy, PeriodOfDay periodOfDay) {
    if (periodOfDay.isUnknown) return Colors.transparent;
    if (isCloudy) return Colors.white.withOpacity(0.6);

    switch (periodOfDay) {
      case PeriodOfDay.morning:
        return Colors.yellowAccent.withOpacity(0.5);
      case PeriodOfDay.afternoon:
        return Colors.yellow.withOpacity(0.5);
      case PeriodOfDay.evening:
        return Colors.orangeAccent.withOpacity(0.5);
      default:
        return Colors.indigoAccent.withOpacity(0.5);
    }
  }
}
