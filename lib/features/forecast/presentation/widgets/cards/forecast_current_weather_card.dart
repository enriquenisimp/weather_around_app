import 'package:flutter/material.dart';
import 'package:weather_around_app/core/data/utils.dart';
import 'package:weather_around_app/core/presentation/theme/theme_constants.dart';
import 'package:weather_around_app/features/forecast/domain/entities/forecast_detail/forecast_detail_city_entity.dart';
import 'package:weather_around_app/features/forecast/presentation/widgets/horizontal_divider.dart';

class ForecastCurrentWeatherCard extends StatelessWidget {
  const ForecastCurrentWeatherCard(
      {super.key,
      required this.forecastDetail,
      required this.forecastDetailDay});
  final ForecastDetailCityEntity forecastDetail;
  final ForecastDetailDay forecastDetailDay;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(ThemeConstants.dimensionMedium),
      margin: const EdgeInsets.all(ThemeConstants.dimensionMedium),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.4),
        borderRadius: BorderRadius.circular(ThemeConstants.dimensionLarge),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.water_drop_outlined,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    Text(
                      "Precipitation",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  "${forecastDetailDay.dailyChanceOfRain} %",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontWeight: FontWeight.w400),
                )
              ],
            ),
          ),
          const HorizontalDivider(
            height: ThemeConstants.dimensionLarge,
            padding: ThemeConstants.dimensionSmall,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.sunny,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      "UV Index risk",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  WeatherConditionsUtils.calculateUVDanger(
                    forecastDetailDay.uv.round(),
                  ),
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontWeight: FontWeight.w400),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
