import 'package:flutter/material.dart';

import 'core/di/injection.dart';
import 'core/presentation/theme/weather_around_app_theme.dart';
import 'features/forecast/presentation/list_cities/forecast_list_cities_page.dart';

void main() {
  configureDependencies();
  runApp(const WeatherAroundApp());
}

class WeatherAroundApp extends StatelessWidget {
  const WeatherAroundApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: WeatherAroundAppTheme.themeData,
      home: const WeatherAroundHandler(),
    );
  }
}

class WeatherAroundHandler extends StatelessWidget {
  const WeatherAroundHandler({super.key});

  @override
  Widget build(BuildContext context) {
    return const ForecastListCitiesPage();
  }
}
