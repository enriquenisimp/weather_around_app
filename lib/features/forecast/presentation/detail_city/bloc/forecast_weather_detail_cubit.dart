import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_around_app/core/presentation/bloc_status.dart';
import 'package:weather_around_app/features/forecast/domain/entities/forecast_detail/forecast_detail_city_entity.dart';
import 'package:weather_around_app/features/forecast/domain/entities/params/get_current_weather_by_city_params.dart';
import 'package:weather_around_app/features/forecast/domain/usecases/get_forecast_day_weather_by_city_usecase.dart';

part 'forecast_weather_detail_state.dart';

class ForecastWeatherDetailCubit extends Cubit<ForecastWeatherDetailState> {
  ForecastWeatherDetailCubit(this._getForecastDetailWeatherByCityUseCase)
      : super(const ForecastWeatherDetailState.loading());
  final GetForecastDetailWeatherByCityUseCase
      _getForecastDetailWeatherByCityUseCase;

  void getForecastDetails(String latLong) async {
    final result = await _getForecastDetailWeatherByCityUseCase(
      GetCurrentWeatherByCityParams(
        latitudeLongitude: latLong,
      ),
    );

    result.fold(
      (failure) => emit(
        const ForecastWeatherDetailState.error(),
      ),
      (forecastDetail) => emit(
        ForecastWeatherDetailState.success(
          forecastDetail,
        ),
      ),
    );
  }
}
