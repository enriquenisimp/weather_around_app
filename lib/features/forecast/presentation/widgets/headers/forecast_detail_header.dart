import 'package:flutter/material.dart';
import 'package:weather_around_app/core/presentation/theme/theme_constants.dart';
import 'package:weather_around_app/features/forecast/domain/entities/forecast_card/city_entity.dart';
import 'package:weather_around_app/features/forecast/domain/entities/forecast_detail/forecast_detail_city_entity.dart';
import 'package:weather_around_app/features/forecast/domain/entities/forecast_detail/forecast_detail_hour.dart';
import 'package:weather_around_app/features/forecast/presentation/widgets/headers/weather_digit_widget.dart';

class ForecastDetailHeader extends StatelessWidget {
  const ForecastDetailHeader({
    super.key,
    required this.forecastDetail,
    required this.city,
  });
  final ForecastDetailCityEntity? forecastDetail;
  final CityEntity city;

  ForecastDetailByHour? get _currentWeather =>
      forecastDetail?.forecastByHourList[getIndexByHour(
              forecastDetail?.localTime.hour ?? 0,
              forecastDetail?.forecastByHourList) ??
          0];

  int get _temperature => _currentWeather?.temperature.round() ?? 0;

  @override
  Widget build(BuildContext context) {
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
                WeatherDigitWidget.degrees(
                  value: _temperature,
                  style: const TextStyle(fontSize: 60),
                ),
                Text(
                  "${_currentWeather?.weatherConditionsEntity.description}",
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
                      color: Colors.white.withOpacity(0.5),
                      borderRadius:
                          BorderRadius.circular(ThemeConstants.dimensionLarge)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      WeatherDigitWidget.degrees(
                        value: forecastDetail?.maxTemperature.round(),
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w500),
                        prefix: "H:",
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      WeatherDigitWidget.degrees(
                        value: forecastDetail?.minTemperature.round(),
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w500),
                        prefix: "L:",
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

  int? getIndexByHour(int hour, List<ForecastDetailByHour>? detailByHour) {
    return detailByHour
        ?.indexWhere((element) => element.hourOfTheDay == hour)
        .abs();
  }
}
