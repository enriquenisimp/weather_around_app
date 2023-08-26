import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_around_app/core/presentation/theme/theme_constants.dart';
import 'package:weather_around_app/core/presentation/theme/theme_utils.dart';
import 'package:weather_around_app/features/forecast/domain/entities/enums/period_day.dart';
import 'package:weather_around_app/features/forecast/domain/entities/forecast_card/city_entity.dart';
import 'package:weather_around_app/features/forecast/domain/entities/forecast_card/current_weather_city_entity.dart';
import 'package:weather_around_app/features/forecast/presentation/list_cities/bloc/current_weather/current_weather_cubit.dart';

class ForecastCityItemCard extends StatefulWidget {
  const ForecastCityItemCard({
    super.key,
    required this.city,
    required this.cityIndex,
    required this.onCitySelected,
  });
  final CityEntity city;
  final int cityIndex;
  final Function(int index) onCitySelected;
  @override
  State<ForecastCityItemCard> createState() => _ForecastCityItemCardState();
}

class _ForecastCityItemCardState extends State<ForecastCityItemCard> {
  PeriodOfDay periodOfDay = PeriodOfDay.unknown;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal: ThemeConstants.dimensionSmall,
          vertical: ThemeConstants.dimensionSmall),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(ThemeConstants.dimensionLarge),
        gradient: LinearGradient(colors: [
          Theme.of(context).colorScheme.onPrimary.withOpacity(0.2),
          ThemeUtils.chooseColor(periodOfDay),
        ]),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () => widget.onCitySelected(widget.cityIndex),
        child:
            BlocListener<CurrentWeatherCubit, List<CurrentWeatherCityEntity?>>(
          listener: (context, list) {
            if (list.isNotEmpty && list.length > widget.cityIndex) {
              setState(() {
                periodOfDay =
                    list[widget.cityIndex]?.periodOfDay ?? PeriodOfDay.unknown;
              });
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: ThemeConstants.dimensionLarge,
              vertical: ThemeConstants.dimensionSmall,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.city.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 3.0,
                          bottom: ThemeConstants.dimensionSmall,
                        ),
                        child: Text(
                          '${widget.city.region} ⸱ ${widget.city.country}',
                        ),
                      ),
                      BlocBuilder<CurrentWeatherCubit,
                          List<CurrentWeatherCityEntity?>>(
                        builder: (context, currentWeatherList) {
                          if (currentWeatherList.isNotEmpty &&
                              currentWeatherList[widget.cityIndex] != null) {
                            final currentWeather =
                                currentWeatherList[widget.cityIndex]!;
                            return Text(currentWeather.formattedLocalTime);
                          } else {
                            return Container();
                          }
                        },
                      )
                    ],
                  ),
                ),
                BlocBuilder<CurrentWeatherCubit,
                    List<CurrentWeatherCityEntity?>>(
                  builder: (context, currentWeatherList) {
                    if (currentWeatherList.isNotEmpty &&
                        currentWeatherList[widget.cityIndex] != null) {
                      final currentWeather =
                          currentWeatherList[widget.cityIndex]!;

                      return Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 2.0),
                              child: RichText(
                                text: TextSpan(
                                    text: currentWeather
                                        .weatherConditions.description,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                    children: [
                                      TextSpan(
                                        text:
                                            ' ⸱ ${currentWeather.temperature.truncate()}°C',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      )
                                    ]),
                                textAlign: TextAlign.end,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      offset: const Offset(2.0, 1.5),
                                      blurRadius: 30.0,
                                      color: ThemeUtils.chooseShadowColor(
                                        currentWeather.isCloudy,
                                        periodOfDay,
                                      ),
                                    )
                                  ]),
                              child: Image.network(
                                currentWeather.weatherConditions.iconUrl,
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
