import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_around_app/core/di/injection.dart';
import 'package:weather_around_app/core/presentation/bloc_status.dart';
import 'package:weather_around_app/core/presentation/theme/theme_constants.dart';
import 'package:weather_around_app/core/presentation/theme/theme_utils.dart';
import 'package:weather_around_app/features/forecast/domain/entities/forecast_card/city_entity.dart';
import 'package:weather_around_app/features/forecast/domain/entities/forecast_card/current_weather_city_entity.dart';
import 'package:weather_around_app/features/forecast/domain/entities/forecast_detail/forecast_detail_city_entity.dart';
import 'package:weather_around_app/features/forecast/presentation/detail_city/error_detail_view.dart';
import 'package:weather_around_app/features/forecast/presentation/widgets/cards/forecast_current_weather_card.dart';
import 'package:weather_around_app/features/forecast/presentation/widgets/cards/forecast_detail_city_card.dart';
import 'package:weather_around_app/features/forecast/presentation/widgets/cards/weather_box.dart';
import 'package:weather_around_app/features/forecast/presentation/widgets/headers/forecast_detail_header.dart';

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

  PeriodOfDay periodOfDay = PeriodOfDay.unknown;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: ThemeUtils.chooseColor(periodOfDay),
        body: BlocListener<ForecastWeatherDetailCubit,
            ForecastWeatherDetailState>(
          listener: (context, state) async {
            if (state.status == BaseStatus.success) {
              if (state.forecastDetail != null) {
                final index = getIndexByHour(
                    state.forecastDetail!.localTime.hour,
                    state.forecastDetail!.forecastByHourList);
                await Future.delayed(const Duration(milliseconds: 400));
                setState(() {
                  periodOfDay = state
                      .forecastDetail!.forecastByHourList[index].periodOfDay;
                });
                controller.animateTo(index * 90,
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.linearToEaseOut);
              }
            }
          },
          child: BlocBuilder<ForecastWeatherDetailCubit,
              ForecastWeatherDetailState>(
            builder: (context, state) {
              if (state.status == BaseStatus.success &&
                  state.forecastDetail != null) {
                final detail = state.forecastDetail!;

                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ForecastDetailHeader(
                        forecastDetail: detail,
                        city: widget.city,
                      ),
                      ForecastCurrentWeatherCard(
                        forecastDetail: detail,
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
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                );
              } else if (state.status == BaseStatus.error) {
                return const ErrorDetailView();
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                );
              }
            },
          ),
        ));
  }

  int getIndexByHour(int hour, List<ForecastDetailByHour> detailByHour) {
    return detailByHour
        .indexWhere((element) => element.hourOfTheDay == hour)
        .abs();
  }
}
