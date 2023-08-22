import 'package:flutter/material.dart';
import 'package:weather_around_app/core/presentation/theme/theme_constants.dart';
import 'package:weather_around_app/core/presentation/theme/theme_utils.dart';
import 'package:weather_around_app/features/forecast/domain/entities/forecast_card/city_entity.dart';
import 'package:weather_around_app/features/forecast/domain/entities/forecast_detail/forecast_detail_city_entity.dart';

class ForecastDetailHeader extends StatelessWidget {
  const ForecastDetailHeader({
    super.key,
    required this.forecastDetail,
    required this.city,
  });
  final ForecastDetailCityEntity forecastDetail;
  final CityEntity city;
  @override
  Widget build(BuildContext context) {
    final currentWeather = forecastDetail.forecastByHourList[getIndexByHour(
        forecastDetail.localTime.hour, forecastDetail.forecastByHourList)];
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: ThemeConstants.dimensionMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(ThemeConstants.dimensionSmall),
                  decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                    BoxShadow(
                      offset: const Offset(2.0, 1.5),
                      blurRadius: 30.0,
                      color: ThemeUtils.chooseShadowColor(
                        currentWeather.isCloudy,
                        currentWeather.periodOfDay,
                      ),
                    )
                  ]),
                  child: Image.network(
                    currentWeather.weatherConditionsEntity.biggerImageSize,
                  ),
                ),
                Text(
                  "${currentWeather.temperature.round()}°",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                Text(
                  currentWeather.weatherConditionsEntity.description,
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: ThemeConstants.dimensionExtraSmall,
                      horizontal: ThemeConstants.dimensionSmall),
                  margin: const EdgeInsets.symmetric(
                      vertical: ThemeConstants.dimensionExtraSmall),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.4),
                      borderRadius:
                          BorderRadius.circular(ThemeConstants.dimensionLarge)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "H:${forecastDetail.maxTemperature.round()}°",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "L:${forecastDetail.minTemperature.round()}°",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.location_on_rounded,
                color: Colors.white,
              ),
              Flexible(
                child: Text(
                  city.name,
                  style: Theme.of(context).textTheme.displaySmall,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            "${city.region} ${city.country}",
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(city.country),
        ],
      ),
    );
  }

  int getIndexByHour(int hour, List<ForecastDetailByHour> detailByHour) {
    return detailByHour
        .indexWhere((element) => element.hourOfTheDay == hour)
        .abs();
  }
}
