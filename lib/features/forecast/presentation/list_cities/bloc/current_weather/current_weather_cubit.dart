import 'dart:developer';

import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:weather_around_app/features/forecast/domain/entities/forecast_card/current_weather_city_entity.dart';
import 'package:weather_around_app/features/forecast/domain/entities/params/get_current_weather_by_city_params.dart';
import 'package:weather_around_app/features/forecast/domain/usecases/get_current_weather_by_city_usecase.dart';

class CurrentWeatherCubit extends Cubit<List<CurrentWeatherCityEntity?>> {
  CurrentWeatherCubit(this._getCurrentWeatherByCityUseCase) : super([]);

  final GetCurrentWeatherByCityUseCase _getCurrentWeatherByCityUseCase;

  void getCurrentWeatherByCity(String latLong, int positionInList) async {
    final result = await _getCurrentWeatherByCityUseCase(
      GetCurrentWeatherByCityParams(
        latitudeLongitude: latLong,
      ),
    );

    result.fold((failure) {
      log(failure.message ?? "Something went wrong", level: Level.error.value);
    }, (currentWeather) {
      state[positionInList] = currentWeather;
      emit([...state]);
    });
  }

  void getCurrentWeathersOfCitiesAvailable(List<String> latLongList) {
    emit(List.generate(latLongList.length, (_) => null));
    EasyDebounce.debounce(
      'citySearch',
      const Duration(milliseconds: 500),
      () {
        latLongList.asMap().forEach(
          (index, latLong) {
            getCurrentWeatherByCity(
              latLong,
              index,
            );
          },
        );
      },
    );
  }
}
