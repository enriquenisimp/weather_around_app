import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_around_app/core/di/injection.dart';
import 'package:weather_around_app/core/presentation/bloc_status.dart';
import 'package:weather_around_app/core/presentation/theme/theme_utils.dart';
import 'package:weather_around_app/features/forecast/domain/entities/forecast_card/city_entity.dart';
import 'package:weather_around_app/features/forecast/domain/entities/forecast_card/current_weather_city_entity.dart';
import 'package:weather_around_app/features/forecast/domain/entities/forecast_detail/forecast_detail_city_entity.dart';
import 'package:weather_around_app/features/forecast/presentation/widgets/cards/forecast_detail_city_card.dart';

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
                await Future.delayed(const Duration(milliseconds: 400));
                setState(() {
                  periodOfDay = PeriodOfDay.getFromHour(
                      state.forecastDetail!.localTime.hour);
                });
                controller.animateTo(
                    getIndexByHour(state.forecastDetail!.localTime.hour,
                            state.forecastDetail!.forecastByHourList) *
                        90,
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
                final currentWeather = detail.forecastByHourList[getIndexByHour(
                    detail.localTime.hour, detail.forecastByHourList)];

                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 20),
                              child: Column(
                                children: [
                                  Text(
                                    "${currentWeather.temperature}°C",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge,
                                  ),
                                  Image.network(currentWeather
                                      .weatherConditionsEntity.iconUrl),
                                  Text(
                                    currentWeather
                                        .weatherConditionsEntity.description,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              widget.city.name,
                              style: Theme.of(context).textTheme.displayLarge,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "${widget.city.region} ${widget.city.country}",
                              style: Theme.of(context).textTheme.displaySmall,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(widget.city.country),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ForecastDetailCityCard(
                        controller: controller,
                        forecastByHourList: detail.forecastByHourList,
                        localTime: detail.localTime,
                      )
                    ],
                  ),
                );
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
