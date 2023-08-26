import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_around_app/core/di/injection.dart';
import 'package:weather_around_app/core/presentation/bloc_status.dart';
import 'package:weather_around_app/core/presentation/theme/theme_constants.dart';
import 'package:weather_around_app/core/presentation/theme/theme_utils.dart';
import 'package:weather_around_app/features/forecast/domain/entities/enums/weather_type.dart';
import 'package:weather_around_app/features/forecast/domain/entities/forecast_card/city_entity.dart';
import 'package:weather_around_app/features/forecast/domain/entities/forecast_detail/forecast_detail_hour.dart';
import 'package:weather_around_app/features/forecast/presentation/detail_city/error_detail_view.dart';
import 'package:weather_around_app/features/forecast/presentation/widgets/cards/forecast_current_weather_card.dart';
import 'package:weather_around_app/features/forecast/presentation/widgets/cards/forecast_detail_city_card.dart';
import 'package:weather_around_app/features/forecast/presentation/widgets/cards/weather_box.dart';
import 'package:weather_around_app/features/forecast/presentation/widgets/headers/forecast_detail_header.dart';
import 'package:weather_around_app/features/forecast/presentation/widgets/shimmer/skeleton_detail_forecast.dart';
import 'package:weather_around_app/features/forecast/presentation/widgets/shimmer/skeleton_widget.dart';
import 'package:weather_around_app/features/forecast/presentation/widgets/weather_selector/weather_selector.dart';

import '../../domain/usecases/get_forecast_day_weather_by_city_usecase.dart';
import 'bloc/forecast_weather_detail_cubit.dart';

class DetailCityForecastPage extends StatelessWidget {
  const DetailCityForecastPage({
    super.key,
    required this.city,
  });
  final CityEntity city;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForecastWeatherDetailCubit(
          getIt<GetForecastDetailWeatherByCityUseCase>())
        ..getForecastDetails(
          city.latLong,
        ),
      child: DetailCityForecastView(
        city: city,
      ),
    );
  }
}

class DetailCityForecastView extends StatefulWidget {
  const DetailCityForecastView({
    super.key,
    required this.city,
  });
  final CityEntity city;

  @override
  State<DetailCityForecastView> createState() => _DetailCityForecastViewState();
}

class _DetailCityForecastViewState extends State<DetailCityForecastView> {
  final ScrollController controller = ScrollController();

  Color _backgroundColor = Colors.blueGrey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body:
          BlocListener<ForecastWeatherDetailCubit, ForecastWeatherDetailState>(
        listener: (context, state) async {
          if (state.status == BaseStatus.success) {
            if (state.forecastDetail != null) {
              final index = getIndexByHour(state.forecastDetail!.localTime.hour,
                  state.forecastDetail!.forecastByHourList);
              await Future.delayed(const Duration(milliseconds: 400));

              final currentWeather = state.forecastDetail!
                  .forecastByHourList[state.forecastDetail!.localTime.hour];
              setState(() {
                _backgroundColor = calculateBackgroundByWeather(currentWeather);
              });
              controller.animateTo(index * 90,
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.linearToEaseOut);
            }
          }
        },
        child:
            BlocBuilder<ForecastWeatherDetailCubit, ForecastWeatherDetailState>(
          builder: (context, state) {
            final detail = state.forecastDetail;
            ForecastDetailByHour? currentWeather;
            if (detail != null) {
              currentWeather = state
                  .forecastDetail!.forecastByHourList[detail.localTime.hour];
            }
            return Stack(
              children: [
                if (state.status == BaseStatus.success)
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (BaseStatus.success == state.status)
                          SizedBox(
                            height: 200,
                            child: WeatherSelector(
                              weatherType:
                                  WeatherType.getWeatherBy(currentWeather!),
                              periodOfDay: currentWeather.periodOfDay,
                            ),
                          ),
                        if (BaseStatus.success != state.status)
                          const SkeletonWidget(
                            child: BannerPlaceholder(),
                          ),
                        ForecastDetailHeader(
                          forecastDetail: detail,
                          city: widget.city,
                        ),
                        if (BaseStatus.success == state.status)
                          Column(
                            children: [
                              ForecastCurrentWeatherCard(
                                forecastDetail: detail!,
                                forecastDetailDay: detail.forecastDetailDay,
                              ),
                              ForecastDetailCityCard(
                                controller: controller,
                                forecastByHourList: detail.forecastByHourList,
                                localTime: detail.localTime,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: ThemeConstants.dimensionSmall),
                                child: IntrinsicHeight(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: WeatherBox(
                                          icon: Icons.water,
                                          title: "Humidity",
                                          value:
                                              "${detail.forecastDetailDay.avgHumidity}",
                                          units: '%',
                                        ),
                                      ),
                                      Expanded(
                                        child: WeatherBox(
                                          icon: Icons.water_drop_outlined,
                                          title: "Precipitation",
                                          value:
                                              "${detail.forecastDetailDay.totalPrecipitationMm}",
                                          units: ' mm\nin the last 24h',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        if (BaseStatus.success != state.status)
                          const SkeletonWidget(
                            child: BannerPlaceholder(),
                          ),
                        if (BaseStatus.success != state.status)
                          const SkeletonWidget(
                            child: BannerPlaceholder(),
                          ),
                      ],
                    ),
                  ),
                if (state.status != BaseStatus.success)
                  const SkeletonDetailForecast(),
                if (state.status == BaseStatus.error) const ErrorDetailView(),
                Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: EdgeInsets.only(left: 15, top: 80, bottom: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new_rounded),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            );
            // } else if (state.status == BaseStatus.error) {
            //   return const ErrorDetailView();
            // } else {
            //   return const Center(
            //     child: CircularProgressIndicator(
            //       color: Colors.white,
            //     ),
            //   );
            // }
          },
        ),
      ),
    );
  }

  int getIndexByHour(int hour, List<ForecastDetailByHour> detailByHour) {
    return detailByHour
        .indexWhere((element) => element.hourOfTheDay == hour)
        .abs();
  }

  Color calculateBackgroundByWeather(
    ForecastDetailByHour forecastDetailByHour,
  ) {
    WeatherType weatherType = WeatherType.getWeatherBy(forecastDetailByHour);

    if (weatherType.isClear) {
      return ThemeUtils.chooseColor(forecastDetailByHour.periodOfDay);
    } else {
      return Colors.blueGrey;
    }
  }

  _getCurrentWeather() {
    setState(() {});
  }
}
