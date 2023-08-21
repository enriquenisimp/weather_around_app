part of 'forecast_weather_detail_cubit.dart';

class ForecastWeatherDetailState extends Equatable {
  const ForecastWeatherDetailState({
    this.forecastDetail,
    required this.status,
  });

  final ForecastDetailCityEntity? forecastDetail;
  final BaseStatus status;

  const ForecastWeatherDetailState.loading()
      : status = BaseStatus.loading,
        forecastDetail = null;
  const ForecastWeatherDetailState.error()
      : status = BaseStatus.error,
        forecastDetail = null;
  const ForecastWeatherDetailState.success(this.forecastDetail)
      : status = BaseStatus.success;

  @override
  List<Object?> get props => [
        forecastDetail,
        status,
      ];
}
