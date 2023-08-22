import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_around_app/features/forecast/domain/entities/forecast_card/current_weather_city_entity.dart';
import 'package:weather_around_app/features/forecast/domain/entities/params/get_current_weather_by_city_params.dart';
import 'package:weather_around_app/features/forecast/domain/usecases/get_current_weather_by_city_usecase.dart';
import 'package:weather_around_app/features/forecast/presentation/list_cities/bloc/current_weather/current_weather_cubit.dart';

class MockGetCurrentWeatherByCityUseCase extends Mock
    implements GetCurrentWeatherByCityUseCase {}

Future<void> main() async {
  late GetCurrentWeatherByCityUseCase getCurrentWeatherByCityUseCase;
  late CurrentWeatherCubit currentWeatherCubit;
  setUpAll(() {
    getCurrentWeatherByCityUseCase = MockGetCurrentWeatherByCityUseCase();
    currentWeatherCubit = CurrentWeatherCubit(
      getCurrentWeatherByCityUseCase,
    );
  });

  group('Current Weather Cubit', () {
    blocTest(
      'emits [] when nothing is called',
      build: () => CurrentWeatherCubit(getCurrentWeatherByCityUseCase),
      expect: () => [],
    );

    final currentWeather = CurrentWeatherCityEntity(
      periodOfDay: PeriodOfDay.afternoon,
      temperature: 20.0,
      isCloudy: true,
      localDateTime: DateTime.now(),
      weatherConditions: const WeatherConditionsEntity(
        description: 'Partly cloudy',
        iconUrl: '',
      ),
    );

    blocTest<CurrentWeatherCubit, List<CurrentWeatherCityEntity?>>(
      'emits [currentWeather] when getCurrentWeathersOfCitiesAvailable is called for a specific location/cityName',
      build: () {
        when(() => getCurrentWeatherByCityUseCase(
            const GetCurrentWeatherByCityParams(
                latitudeLongitude: '22,00'))).thenAnswer(
          (_) => Future.value(
            Right(
              currentWeather,
            ),
          ),
        );
        return currentWeatherCubit;
      },
      act: (CurrentWeatherCubit bloc) =>
          bloc.getCurrentWeathersOfCitiesAvailable(['22,00']),
      wait: const Duration(seconds: 1),
      skip: 1,
      expect: () => [
        [currentWeather]
      ],
    );
  });
}
