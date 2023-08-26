import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_around_app/core/data/constants/common_constants.dart';
import 'package:weather_around_app/core/presentation/theme/theme_constants.dart';
import 'package:weather_around_app/core/presentation/theme/theme_utils.dart';
import 'package:weather_around_app/features/forecast/domain/entities/forecast_detail/forecast_detail_hour.dart';

class ForecastDetailCityCard extends StatelessWidget {
  const ForecastDetailCityCard({
    super.key,
    required this.controller,
    required this.forecastByHourList,
    required this.localTime,
  });
  final ScrollController controller;
  final List<ForecastDetailByHour> forecastByHourList;
  final DateTime localTime;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal: ThemeConstants.dimensionMedium),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(ThemeConstants.dimensionLarge),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(ThemeConstants.dimensionMedium),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Today",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  DateFormat(DateFormats.ddMMMyyyy).format(localTime),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 140,
            child: ListView.builder(
                itemCount: forecastByHourList.length,
                controller: controller,
                padding: const EdgeInsets.symmetric(
                  horizontal: ThemeConstants.dimensionSmall,
                  vertical: ThemeConstants.dimensionSmall,
                ),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final forecastByHour = forecastByHourList[index];

                  return Container(
                    width: 80,
                    margin: const EdgeInsets.symmetric(
                        horizontal: ThemeConstants.dimensionExtraSmall),
                    padding: const EdgeInsets.symmetric(
                        vertical: ThemeConstants.dimensionSmall),
                    decoration: BoxDecoration(
                      color: isCurrentTime(
                        forecastByHour.hourOfTheDay,
                        localTime,
                      )
                          ? ThemeUtils.chooseColor(forecastByHour.periodOfDay)
                              .withOpacity(0.5)
                          : Colors.white.withOpacity(0.3),
                      border: isCurrentTime(
                        forecastByHour.hourOfTheDay,
                        localTime,
                      )
                          ? Border.all(
                              color: ThemeUtils.chooseColor(
                                  forecastByHour.periodOfDay),
                              width: 2)
                          : null,
                      borderRadius:
                          BorderRadius.circular(ThemeConstants.dimensionLarge),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("${forecastByHour.temperature.round()}°",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            )),
                        Image.network(
                          forecastByHour.weatherConditionsEntity.iconUrl,
                          height: 60,
                        ),
                        Text("${forecastByHour.hourOfTheDay}:00"),
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  bool isCurrentTime(int hour, DateTime dateTime) {
    return hour == dateTime.hour;
  }
}
